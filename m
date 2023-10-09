Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF47BDDE2
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376808AbjJINOH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376951AbjJINNo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9B94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE552C433C7;
        Mon,  9 Oct 2023 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857202;
        bh=Fwhy3Rs/JdAY9GmGIzPhfU5Gks9mvFmZtl0Gf0h/il4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZLCn6e1NWfHOxwwMl8zLasNi+jv0A7ubYPIvvXXS92x8XLLuxPtLIouZqq7Jwbax
         UFAOIF3zkvgDWIwsAccqlCA1obx+CrK7VXKqoYQGa30NGsXKoHytpRDKHTTkpBfbzb
         of8h9oyFPGir4bHAro4VYZpGcqD1BNlyPgkuri6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haiyang Zhang <haiyangz@microsoft.com>,
        Simon Horman <horms@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 131/163] net: mana: Fix the tso_bytes calculation
Date:   Mon,  9 Oct 2023 15:01:35 +0200
Message-ID: <20231009130127.659991056@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

commit 7a54de92657455210d0ca71d4176b553952c871a upstream.

sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
the subtraction from header size.

Cc: stable@vger.kernel.org
Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: a43e8e9ffa0d ("net: mana: Fix oversized sge0 for GSO packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -262,8 +262,6 @@ netdev_tx_t mana_start_xmit(struct sk_bu
 				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
 			} else {
 				ihs = skb_tcp_all_headers(skb);
-				if (ipv6_has_hopopt_jumbo(skb))
-					ihs -= sizeof(struct hop_jumbo_hdr);
 			}
 
 			u64_stats_update_begin(&tx_stats->syncp);



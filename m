Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7A791CD4
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbjIDScE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbjIDScE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34ECC8
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8F20CE0F9E
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F6C433C9;
        Mon,  4 Sep 2023 18:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852318;
        bh=X8ex41euhtXoRCELElv56kIbqAB2QIDJd6UWy6MS5gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+e6pqCECAa4LOA3OPjxoWY6B0VJKYvn1IonYZ5JDAZ7cbWTE3mCNzzofM2o7cV7J
         aLBD0F3cZji8KVcQcQsPpnurSPdy839/JxjPWmQ3yOilm5ysngtBxUYlvMYTTlBQDn
         8ZRIxavAUk8eRKcRPrK7uFJYykthugSUfgqsz3j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.5 09/34] net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
Date:   Mon,  4 Sep 2023 19:29:56 +0100
Message-ID: <20230904182949.021589774@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 569820befb16ffc755ab7af71f4f08cc5f68f0fe upstream.

enetc_phc_index is only used via symbol_get, which was only ever
intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
for it so that symbol_get can enforce only being used on
EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -8,7 +8,7 @@
 #include "enetc.h"
 
 int enetc_phc_index = -1;
-EXPORT_SYMBOL(enetc_phc_index);
+EXPORT_SYMBOL_GPL(enetc_phc_index);
 
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,



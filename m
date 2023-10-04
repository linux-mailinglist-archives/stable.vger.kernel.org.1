Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8007B88E1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjJDSU3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbjJDSU2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D3BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB1C433C8;
        Wed,  4 Oct 2023 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443625;
        bh=8BZYqbFftHcoRSBBhw744UW3nhNB5DGTvIGqeVyglpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYgsRussoa6PWrL2LMt31Ld4t3aTkR7sxQnzlia8f8KzkglEr4XYV6tvuDvbJQ0ps
         R3n1lvuF9waVCloZWFl8q2l1s/RsF+Uxg+9hIXEinFMlJgx2aggJ5RokOalKa7w+kV
         V0Ia8z0czBqjrJLVBmGiVFd3dh25guzeqOzAy6Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/259] net: hsr: Add __packed to struct hsr_sup_tlv.
Date:   Wed,  4 Oct 2023 19:56:07 +0200
Message-ID: <20231004175226.189414454@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit fbd825fcd7dd4c11d4c48c3d0adc248a4a0ce90b ]

Struct hsr_sup_tlv describes HW layout and therefore it needs a __packed
attribute to ensure the compiler does not add any padding.
Due to the size and __packed attribute of the structs that use
hsr_sup_tlv it has no functional impact.

Add __packed to struct hsr_sup_tlv.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 16ae9fb09ccd2..58a5a8b3891ff 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -83,7 +83,7 @@ struct hsr_vlan_ethhdr {
 struct hsr_sup_tlv {
 	u8		HSR_TLV_type;
 	u8		HSR_TLV_length;
-};
+} __packed;
 
 /* HSR/PRP Supervision Frame data types.
  * Field names as defined in the IEC:2010 standard for HSR.
-- 
2.40.1




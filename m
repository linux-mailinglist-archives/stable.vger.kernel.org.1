Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AACB75CDE1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGUQP3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjGUQPJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE73580
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A08E61D1D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB1CC433C7;
        Fri, 21 Jul 2023 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956079;
        bh=x5rRuxYPnb9Zu47nvcFlB94zcNRcWhJ+dSOS+iQH0Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qy++mNq7QId25lMAxo8nIcny7auuvRSRUpFyhvQUeAaWwYkUP2K9H3v4EVy7Ju+FG
         4ipNL1I2qmbYtINNtXkaVMtpkvWB880oq2/+VOxdzOkpyE3O6R+h/yxSLgX/IiWRsq
         KXJyzHNqa2EEUdyrPtn4bw6e5LnFDgUkAIvu+JSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 125/292] tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11
Date:   Fri, 21 Jul 2023 18:03:54 +0200
Message-ID: <20230721160534.197570949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit edb13d7bb034c4d5523f15e9aeea31c504af6f91 upstream.

Further restrict with DMI_PRODUCT_VERSION.

Cc: stable@vger.kernel.org # v6.4+
Link: https://lore.kernel.org/linux-integrity/20230517122931.22385-1-peter.ujfalusi@linux.intel.com/
Fixes: 95a9359ee22f ("tpm: tpm_tis: Disable interrupts for AEON UPX-i11")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..9cb4e81fc548 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -143,6 +143,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
 		},
 	},
 	{}
-- 
2.41.0




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218AC726C44
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjFGUcB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjFGUcA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6712184
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7425764513
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EFAC433D2;
        Wed,  7 Jun 2023 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169918;
        bh=8qy9H8mu9Rip5/EcNILUftZ4fVQrC2Ma0GXcMJ+wzmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSNVK/WbEC87QQBOdvnrwfVhNcX8kTj3quHQeoWuFF+RmRJi55EFJ8h6AZg2/Tfqr
         PY/dNef4UR5AzPZ3iC93vLT1OOqtky+oTURD4grxaWHGgHAxw9tG/2602XaQpB1orz
         NPNyS0kPivFV9EbmQMouaVHxq5+FItPzl6v2idR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Machek <pavel@denx.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.3 234/286] tpm, tpm_tis: correct tpm_tis_flags enumeration values
Date:   Wed,  7 Jun 2023 22:15:33 +0200
Message-ID: <20230607200930.941611005@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

commit 4ecd704a4c51fd95973fcc3a60444e0e24eb9439 upstream.

With commit 858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in test
for interrupts") bit accessor functions are used to access flags in
tpm_tis_data->flags.

However these functions expect bit numbers, while the flags are defined
as bit masks in enum tpm_tis_flag.

Fix this inconsistency by using numbers instead of masks also for the
flags in the enum.

Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 858e8b792d06 ("tpm, tpm_tis: Avoid cache incoherency in test for interrupts")
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: stable@vger.kernel.org
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -84,10 +84,10 @@ enum tis_defaults {
 #define ILB_REMAP_SIZE			0x100
 
 enum tpm_tis_flags {
-	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
-	TPM_TIS_INVALID_STATUS		= BIT(1),
-	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
-	TPM_TIS_IRQ_TESTED		= BIT(3),
+	TPM_TIS_ITPM_WORKAROUND		= 0,
+	TPM_TIS_INVALID_STATUS		= 1,
+	TPM_TIS_DEFAULT_CANCELLATION	= 2,
+	TPM_TIS_IRQ_TESTED		= 3,
 };
 
 struct tpm_tis_data {



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FC475D463
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjGUTUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGUTUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:20:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6EBED
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D3461B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A929C433C8;
        Fri, 21 Jul 2023 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967235;
        bh=cLVnscSZzd4+xNdDB9Yip0knvi+t/y96oFzaBcpgx8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGu+fj1Wwe5dxq2EVa58DuCZjTN8x3oEifPFiM2HB51ngMbpzpQLA91ALFoxPfx3q
         OvMQd9BiWI9W0P//WlyT64NUQh22u+6q0KYpMjj0kk+ljyI8dEMwudvWs9SuVIqtnF
         ovA4N3pwensxZLRjOEGJ1iRXBdnUPvYzNFO/LEmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sachin Sant <sachinp@linux.ibm.com>,
        "Aneesh Kumar K. V" <aneesh.kumar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.1 092/223] tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms
Date:   Fri, 21 Jul 2023 18:05:45 +0200
Message-ID: <20230721160524.785552133@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

commit ecff6813d2bcf0c670881a9ba3f51cb032dd405a upstream.

tpm_amd_is_rng_defective is for dealing with an issue related to the
AMD firmware TPM, so on non-x86 architectures just have it inline and
return false.

Cc: stable@vger.kernel.org # v6.3+
Reported-by: Sachin Sant <sachinp@linux.ibm.com>
Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm-chip.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -515,6 +515,7 @@ static int tpm_add_legacy_sysfs(struct t
  * 6.x.y.z series: 6.0.18.6 +
  * 3.x.y.z series: 3.57.y.5 +
  */
+#ifdef CONFIG_X86
 static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 {
 	u32 val1, val2;
@@ -563,6 +564,12 @@ release:
 
 	return true;
 }
+#else
+static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
 
 static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {



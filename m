Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB6975CE07
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjGUQQx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGUQQc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:16:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF203AA3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC38661D1E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED868C433C9;
        Fri, 21 Jul 2023 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956135;
        bh=yP7whKuukUFTKHrP3igh2R+xGSNiId5N9vm0RdS58Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejQ9HyLxbNhdGZu9he32dOrZhwGc4YU3TY2/Me97A2Ki7CuLVdFkh5qO/rgoZ1t+I
         A8FCzE0LpC1n7xmYNYLS3HHy3TUjKxPPw2/Tn9w6042w+SHMuhqs2g5y+h74rNhuOK
         nGpnaua3Uu7/cSviXJdxyHF+kJasH7QPNIOromnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sachin Sant <sachinp@linux.ibm.com>,
        "Aneesh Kumar K. V" <aneesh.kumar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 129/292] tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms
Date:   Fri, 21 Jul 2023 18:03:58 +0200
Message-ID: <20230721160534.367204554@linuxfoundation.org>
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
@@ -518,6 +518,7 @@ static int tpm_add_legacy_sysfs(struct t
  * 6.x.y.z series: 6.0.18.6 +
  * 3.x.y.z series: 3.57.y.5 +
  */
+#ifdef CONFIG_X86
 static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
 {
 	u32 val1, val2;
@@ -566,6 +567,12 @@ release:
 
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



Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062667BE0E1
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbjJINoy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377427AbjJINos (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:44:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4091
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:44:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10982C433C8;
        Mon,  9 Oct 2023 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859086;
        bh=z29+xHYkbzip2Ileb5Lvn5+ZT4eNc6UI1ReQfS0ATiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0bg1IjLjvt/dPtCN+kfwuoimFffm/UMfF19bz8wqx1xT1qdQcGIGGNZdagRwLB6r
         o2oxcfUsBLFdDoCO5O2HZJibj13uVuQPLgO5e99Fhv5o0v0JHPGKa5RKw0vAL6SF8l
         PMfHDNvKzM4fGYorWfnI7pHD2rWdM/+EIlOIih8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 195/226] ima: rework CONFIG_IMA dependency block
Date:   Mon,  9 Oct 2023 15:02:36 +0200
Message-ID: <20231009130131.693133269@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 91e326563ee34509c35267808a4b1b3ea3db62a8 ]

Changing the direct dependencies of IMA_BLACKLIST_KEYRING and
IMA_LOAD_X509 caused them to no longer depend on IMA, but a
a configuration without IMA results in link failures:

arm-linux-gnueabi-ld: security/integrity/iint.o: in function `integrity_load_keys':
iint.c:(.init.text+0xd8): undefined reference to `ima_load_x509'

aarch64-linux-ld: security/integrity/digsig_asymmetric.o: in function `asymmetric_verify':
digsig_asymmetric.c:(.text+0x104): undefined reference to `ima_blacklist_keyring'

Adding explicit dependencies on IMA would fix this, but a more reliable
way to do this is to enclose the entire Kconfig file in an 'if IMA' block.
This also allows removing the existing direct dependencies.

Fixes: be210c6d3597f ("ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/Kconfig | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index d1b490705c2e8..d0d3ff58da491 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -29,9 +29,11 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+if IMA
+
 config IMA_KEXEC
 	bool "Enable carrying the IMA measurement list across a soft boot"
-	depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
+	depends on TCG_TPM && HAVE_IMA_KEXEC
 	default n
 	help
 	   TPM PCRs are only reset on a hard reboot.  In order to validate
@@ -43,7 +45,6 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	depends on IMA
 	range 8 14
 	default 10
 	help
@@ -53,7 +54,7 @@ config IMA_MEASURE_PCR_IDX
 
 config IMA_LSM_RULES
 	bool
-	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
+	depends on AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
 	default y
 	help
 	  Disabling this option will disregard LSM based policy rules.
@@ -61,7 +62,6 @@ config IMA_LSM_RULES
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
-	depends on IMA
 	help
 	  Select the default IMA measurement template.
 
@@ -80,14 +80,12 @@ endchoice
 
 config IMA_DEFAULT_TEMPLATE
 	string
-	depends on IMA
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
 	default IMA_DEFAULT_HASH_SHA1
-	depends on IMA
 	help
 	   Select the default hash algorithm used for the measurement
 	   list, integrity appraisal and audit log.  The compiled default
@@ -117,7 +115,6 @@ endchoice
 
 config IMA_DEFAULT_HASH
 	string
-	depends on IMA
 	default "sha1" if IMA_DEFAULT_HASH_SHA1
 	default "sha256" if IMA_DEFAULT_HASH_SHA256
 	default "sha512" if IMA_DEFAULT_HASH_SHA512
@@ -126,7 +123,6 @@ config IMA_DEFAULT_HASH
 
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
-	depends on IMA
 	default n
 	help
 	  IMA policy can now be updated multiple times.  The new rules get
@@ -137,7 +133,6 @@ config IMA_WRITE_POLICY
 
 config IMA_READ_POLICY
 	bool "Enable reading back the current IMA policy"
-	depends on IMA
 	default y if IMA_WRITE_POLICY
 	default n if !IMA_WRITE_POLICY
 	help
@@ -147,7 +142,6 @@ config IMA_READ_POLICY
 
 config IMA_APPRAISE
 	bool "Appraise integrity measurements"
-	depends on IMA
 	default n
 	help
 	  This option enables local measurement integrity appraisal.
@@ -303,7 +297,6 @@ config IMA_APPRAISE_SIGNED_INIT
 
 config IMA_MEASURE_ASYMMETRIC_KEYS
 	bool
-	depends on IMA
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
@@ -319,3 +312,5 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+
+endif
-- 
2.40.1




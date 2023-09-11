Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCAD79BC0B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbjIKVEH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjIKOmv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:42:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F5312A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:42:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC37C433CB;
        Mon, 11 Sep 2023 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443367;
        bh=hK8tKTD58vkXQYYnpK4pkvmXALuEu4tnWzQukoEWbNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5Q4E1SNGS73J6nvyiP5T4R5toZq7Vv6GJ7khCQuQRuZYQuofFz0qh4Wwykq5qhpV
         f67O46SMby/a2GdzCtDykv98RPLGbgs+rpAjNG4hawWpQZ/5s0CCMLCMltwrTBUq0s
         3w+bhNngWWFo95h3MaUDpFJWGSlJmBubqT+cGoPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 352/737] ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig
Date:   Mon, 11 Sep 2023 15:43:31 +0200
Message-ID: <20230911134700.351102001@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nayna Jain <nayna@linux.ibm.com>

[ Upstream commit 5087fd9e80e539d2163accd045b73da64de7de95 ]

Time to remove "IMA_TRUSTED_KEYRING".

Fixes: f4dc37785e9b ("integrity: define '.evm' as a builtin 'trusted' keyring") # v4.5+
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/Kconfig | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 60a511c6b583e..c17660bf5f347 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -248,18 +248,6 @@ config IMA_APPRAISE_MODSIG
 	   The modsig keyword can be used in the IMA policy to allow a hook
 	   to accept such signatures.
 
-config IMA_TRUSTED_KEYRING
-	bool "Require all keys on the .ima keyring be signed (deprecated)"
-	depends on IMA_APPRAISE && SYSTEM_TRUSTED_KEYRING
-	depends on INTEGRITY_ASYMMETRIC_KEYS
-	select INTEGRITY_TRUSTED_KEYRING
-	default y
-	help
-	   This option requires that all keys added to the .ima
-	   keyring be signed by a key on the system trusted keyring.
-
-	   This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
-
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-- 
2.40.1




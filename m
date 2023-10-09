Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB487BDDC0
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376838AbjJINNF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376840AbjJINMx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283ED64
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06429C433CC;
        Mon,  9 Oct 2023 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857107;
        bh=aAEhpef9Dcy0zrzSpKxjMoLhQUfF5ICha+OW9y340vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9ot4eNkGXKFeTZ/hsNOlY/6vuhJdjihyflfKdXLOBslpwP88Ky+AImrwMmcmaF8L
         2nUREOpVOIjJ8uOpXrlLedPh/YGFncuuZjeHbOHsFy3uJ60AEU3iqb9GlhnE03q9lf
         Z9uPpQ/I9o21sNU0wDr5U3D4kICMABowqxZK3FCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksandr Tymoshenko <ovt@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 091/163] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
Date:   Mon,  9 Oct 2023 15:00:55 +0200
Message-ID: <20231009130126.548452389@linuxfoundation.org>
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

From: Oleksandr Tymoshenko <ovt@google.com>

[ Upstream commit be210c6d3597faf330cb9af33b9f1591d7b2a983 ]

The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
and IMA_BLACKLIST_KEYRING unavailable because the latter
two depend on the former. Since IMA_TRUSTED_KEYRING was
deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
as a dependency for the two Kconfigs affected by the
deprecation.

Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig")
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index c17660bf5f347..e6df7c930397c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -268,7 +268,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 config IMA_BLACKLIST_KEYRING
 	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   This option creates an IMA blacklist keyring, which contains all
@@ -278,7 +278,7 @@ config IMA_BLACKLIST_KEYRING
 
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
-	depends on IMA_TRUSTED_KEYRING
+	depends on INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
 	   File signature verification is based on the public keys
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4487975CD36
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGUQJJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjGUQJI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD02D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4AE61D2B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF5FC433C8;
        Fri, 21 Jul 2023 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955744;
        bh=Uc8ceBpJ4OdagaIg//tWhmadzOBuuafKECSH9p1P5No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2xABdAiYwZGCQ+WNcPqPN/9BkJgkzfEAxIHX0zcylFapyBvtctCOueR+ajXrorbk
         qT1VAL4atgyta3zyJtfCP+9KlU1yHhjg57A2HQvCaq6mSolAk26/x3ssd80M0r8Ywa
         tU2HTiAgKASUY6FPnXuobsnIlLvu4AXMuUeUhxHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nayna Jain <nayna@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kenrnel.org
Subject: [PATCH 6.4 002/292] security/integrity: fix pointer to ESL data and its size on pseries
Date:   Fri, 21 Jul 2023 18:01:51 +0200
Message-ID: <20230721160528.914189552@linuxfoundation.org>
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

From: Nayna Jain <nayna@linux.ibm.com>

commit e66effaf61ffb1dc6088492ca3a0e98dcbf1c10d upstream.

On PowerVM guest, variable data is prefixed with 8 bytes of timestamp.
Extract ESL by stripping off the timestamp before passing to ESL parser.

Fixes: 4b3e71e9a34c ("integrity/powerpc: Support loading keys from PLPKS")
Cc: stable@vger.kenrnel.org # v6.3
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230608120444.382527-1-nayna@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../integrity/platform_certs/load_powerpc.c   | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index b9de70b90826..170789dc63d2 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -15,6 +15,9 @@
 #include "keyring_handler.h"
 #include "../integrity.h"
 
+#define extract_esl(db, data, size, offset)	\
+	do { db = data + offset; size = size - offset; } while (0)
+
 /*
  * Get a certificate list blob from the named secure variable.
  *
@@ -55,8 +58,9 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, u64 *size)
  */
 static int __init load_powerpc_certs(void)
 {
-	void *db = NULL, *dbx = NULL;
-	u64 dbsize = 0, dbxsize = 0;
+	void *db = NULL, *dbx = NULL, *data = NULL;
+	u64 dsize = 0;
+	u64 offset = 0;
 	int rc = 0;
 	ssize_t len;
 	char buf[32];
@@ -74,38 +78,46 @@ static int __init load_powerpc_certs(void)
 		return -ENODEV;
 	}
 
+	if (strcmp("ibm,plpks-sb-v1", buf) == 0)
+		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of timestamp */
+		offset = 8;
+
 	/*
 	 * Get db, and dbx. They might not exist, so it isn't an error if we
 	 * can't get them.
 	 */
-	db = get_cert_list("db", 3, &dbsize);
-	if (!db) {
+	data = get_cert_list("db", 3, &dsize);
+	if (!data) {
 		pr_info("Couldn't get db list from firmware\n");
-	} else if (IS_ERR(db)) {
-		rc = PTR_ERR(db);
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
 		pr_err("Error reading db from firmware: %d\n", rc);
 		return rc;
 	} else {
-		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
+		extract_esl(db, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:db", db, dsize,
 					      get_handler_for_db);
 		if (rc)
 			pr_err("Couldn't parse db signatures: %d\n", rc);
-		kfree(db);
+		kfree(data);
 	}
 
-	dbx = get_cert_list("dbx", 4,  &dbxsize);
-	if (!dbx) {
+	data = get_cert_list("dbx", 4,  &dsize);
+	if (!data) {
 		pr_info("Couldn't get dbx list from firmware\n");
-	} else if (IS_ERR(dbx)) {
-		rc = PTR_ERR(dbx);
+	} else if (IS_ERR(data)) {
+		rc = PTR_ERR(data);
 		pr_err("Error reading dbx from firmware: %d\n", rc);
 		return rc;
 	} else {
-		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
+		extract_esl(dbx, data, dsize, offset);
+
+		rc = parse_efi_signature_list("powerpc:dbx", dbx, dsize,
 					      get_handler_for_dbx);
 		if (rc)
 			pr_err("Couldn't parse dbx signatures: %d\n", rc);
-		kfree(dbx);
+		kfree(data);
 	}
 
 	return rc;
-- 
2.41.0




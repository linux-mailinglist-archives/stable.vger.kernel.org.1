Return-Path: <stable+bounces-124786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8005EA67211
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 12:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A55A19A71D2
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DD920A5F8;
	Tue, 18 Mar 2025 11:01:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F020A5E5;
	Tue, 18 Mar 2025 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295718; cv=none; b=ag+MT7CLdmj6Vamm/msC/gnl8k7a0i6SPSMDxWY7WNFVAOFDf6cXPZut+X1dCyYTTAI8O8CN7nLsVvIMbAp5KOQe7LSG3UKd00KfTKWZHOA1EMUjaDWhHy5sCySH1x+iRW8Vk/ANXgix9ZGSh8zQzHJSxj2mZ0q+e8xk9+Hj8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295718; c=relaxed/simple;
	bh=UzWZkEsEI9HQUR1U3KgL+aNDmYBpAorw9AaWD1lA9mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzLO5y9ckgWz0O5cuciyWeVqz6DLlTPYX3BdkMRwNi5c0eHZkDJMpcOa8SWXrNyM+EkaHrgKjZoWmgJy7nXBkDkyVO+knqBIiEGKGlViNgLVEYYHAFMoVrqZAriY/Ok5SQ5l2cbABFao0r+Qd048cu9SVRJnH27CT6Rxaq99Y8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8AxDGuiUtlntoqbAA--.768S3;
	Tue, 18 Mar 2025 19:01:54 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowMDxDceOUtlnb6FRAA--.22930S3;
	Tue, 18 Mar 2025 19:01:52 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Stancek <jstancek@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Neal Gompa <neal@gompa.dev>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1&6.6 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Date: Tue, 18 Mar 2025 19:01:22 +0800
Message-ID: <20250318110124.2160941-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318110124.2160941-1-chenhuacai@loongson.cn>
References: <20250318110124.2160941-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxDceOUtlnb6FRAA--.22930S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw15ur1kKw1Utr47JFWDAwc_yoW7GrW7pa
	1fAw1ftr93JF9rG3srCFyYg3Wj9rWkKr15ZrZrKw1xAFn5A34xZa92kw1Fg348XFyDC3W3
	urW5XFyjkr48J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
	ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVOJeDUUUU

From: Jan Stancek <jstancek@redhat.com>

commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.

Couple error handling helpers are repeated in both tools, so
move them to a common header.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 MAINTAINERS          |  1 +
 certs/Makefile       |  2 +-
 certs/extract-cert.c | 37 ++-----------------------------------
 scripts/sign-file.c  | 37 ++-----------------------------------
 scripts/ssl-common.h | 39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 45 insertions(+), 71 deletions(-)
 create mode 100644 scripts/ssl-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ae4c0cec5073..294d2ce29b73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4784,6 +4784,7 @@ S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
+F:	scripts/ssl-common.h
 F:	tools/certs/
 
 CFAG12864B LCD DRIVER
diff --git a/certs/Makefile b/certs/Makefile
index 799ad7b9e68a..67e1f2707c2f 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -84,5 +84,5 @@ targets += x509_revocation_list
 
 hostprogs := extract-cert
 
-HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null) -I$(srctree)/scripts
 HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
diff --git a/certs/extract-cert.c b/certs/extract-cert.c
index 70e9ec89d87d..8e7ba9974a1f 100644
--- a/certs/extract-cert.c
+++ b/certs/extract-cert.c
@@ -23,6 +23,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -40,41 +42,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			err(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 3edb156ae52c..39ba58db5d4e 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -29,6 +29,8 @@
 #include <openssl/err.h>
 #include <openssl/engine.h>
 
+#include "ssl-common.h"
+
 /*
  * OpenSSL 3.0 deprecates the OpenSSL's ENGINE API.
  *
@@ -83,41 +85,6 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
-{
-	const char *file;
-	char buf[120];
-	int e, line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
-
-	while ((e = ERR_get_error_line(&file, &line))) {
-		ERR_error_string(e, buf);
-		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
-	}
-}
-
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() == 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
-#define ERR(cond, fmt, ...)				\
-	do {						\
-		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
-		if (__cond) {				\
-			errx(1, fmt, ## __VA_ARGS__);	\
-		}					\
-	} while(0)
-
 static const char *key_pass;
 
 static int pem_pw_cb(char *buf, int len, int w, void *v)
diff --git a/scripts/ssl-common.h b/scripts/ssl-common.h
new file mode 100644
index 000000000000..e6711c75ed91
--- /dev/null
+++ b/scripts/ssl-common.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ * SSL helper functions shared by sign-file and extract-cert.
+ */
+
+static void display_openssl_errors(int l)
+{
+	const char *file;
+	char buf[120];
+	int e, line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	fprintf(stderr, "At main.c:%d:\n", l);
+
+	while ((e = ERR_get_error_line(&file, &line))) {
+		ERR_error_string(e, buf);
+		fprintf(stderr, "- SSL %s: %s:%d\n", buf, file, line);
+	}
+}
+
+static void drain_openssl_errors(void)
+{
+	const char *file;
+	int line;
+
+	if (ERR_peek_error() == 0)
+		return;
+	while (ERR_get_error_line(&file, &line)) {}
+}
+
+#define ERR(cond, fmt, ...)				\
+	do {						\
+		bool __cond = (cond);			\
+		display_openssl_errors(__LINE__);	\
+		if (__cond) {				\
+			errx(1, fmt, ## __VA_ARGS__);	\
+		}					\
+	} while (0)
-- 
2.47.1



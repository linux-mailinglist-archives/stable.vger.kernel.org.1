Return-Path: <stable+bounces-9113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCE820A43
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423E7B21777
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8817C2;
	Sun, 31 Dec 2023 07:19:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA561844
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so3845327b3a.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007194; x=1704611994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgdn5abXgteMttkBzH2S3oLzUL6fhH2uT+M4BEedUdk=;
        b=kCgFBNqQGM+AfuQQYVullu+GViDjuc9rKDq6YYQk5ptJ8EINHP1gMiwaPz/jgx7BYn
         tvoGBdVAYL2ExNpWwBH/W5v0ccJTKRYI2MZMJ2Tz6fEWJVF2a7PETvueuzeIRQMjeK7t
         U4Q6dQggy5e3q1K45pP0C2U80l9moT11uMb7KxZ55JXLYX/K3fhaoTW7wWIwdz2tlCY+
         hovEvvU+YC1EY176EQtieaQ7kkqyLLzkj2IapUeijh5GKU83VBB8lnDri+45CO9Py/pu
         /Al2/PDTCKkjVCZ6+D7V/T5ROTIsQBKi3p1MwFDUyp4POWh+5oeJjed3LzzyJL8N1Dsb
         Xx1w==
X-Gm-Message-State: AOJu0Yyy2oaTnuIx6IGkhXfUUJyGddpR6Vu5qGY32ev8j+fa576mlRyR
	dvgdAU7ZbN5+9cQycHyxrXs=
X-Google-Smtp-Source: AGHT+IHVfJH0xuBe6W6p26uJnhxb7pd8vmvO2Mdq9+taerRr2jDxqsdpmRTCETkAEEiFjkxiApcLHw==
X-Received: by 2002:aa7:8d59:0:b0:6d9:8b96:d453 with SMTP id s25-20020aa78d59000000b006d98b96d453mr14222269pfe.42.1704007194534;
        Sat, 30 Dec 2023 23:19:54 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:54 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 05/19] ksmbd: add support for surrogate pair conversion
Date: Sun, 31 Dec 2023 16:19:05 +0900
Message-Id: <20231231071919.32103-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071919.32103-1-linkinjeon@kernel.org>
References: <20231231071919.32103-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 0c180317c654a494fe429adbf7bc9b0793caf9e2 ]

ksmbd is missing supporting to convert filename included surrogate pair
characters. It triggers a "file or folder does not exist" error in
Windows client.

[Steps to Reproduce for bug]
1. Create surrogate pair file
 touch $(echo -e '\xf0\x9d\x9f\xa3')
 touch $(echo -e '\xf0\x9d\x9f\xa4')

2. Try to open these files in ksmbd share through Windows client.

This patch update unicode functions not to consider about surrogate pair
(and IVS).

Reviewed-by: Marios Makassikis <mmakassikis@freebox.fr>
Tested-by: Marios Makassikis <mmakassikis@freebox.fr>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/unicode.c | 187 +++++++++++++++++++++++++++++-----------
 1 file changed, 138 insertions(+), 49 deletions(-)

diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index 393dd4a7432b..43ed29ee44ea 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -13,46 +13,10 @@
 #include "unicode.h"
 #include "smb_common.h"
 
-/*
- * smb_utf16_bytes() - how long will a string be after conversion?
- * @from:	pointer to input string
- * @maxbytes:	don't go past this many bytes of input string
- * @codepage:	destination codepage
- *
- * Walk a utf16le string and return the number of bytes that the string will
- * be after being converted to the given charset, not including any null
- * termination required. Don't walk past maxbytes in the source buffer.
- *
- * Return:	string length after conversion
- */
-static int smb_utf16_bytes(const __le16 *from, int maxbytes,
-			   const struct nls_table *codepage)
-{
-	int i;
-	int charlen, outlen = 0;
-	int maxwords = maxbytes / 2;
-	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
-
-	for (i = 0; i < maxwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
-			break;
-
-		charlen = codepage->uni2char(ftmp, tmp, NLS_MAX_CHARSET_SIZE);
-		if (charlen > 0)
-			outlen += charlen;
-		else
-			outlen++;
-	}
-
-	return outlen;
-}
-
 /*
  * cifs_mapchar() - convert a host-endian char to proper char in codepage
  * @target:	where converted character should be copied
- * @src_char:	2 byte host-endian source character
+ * @from:	host-endian source string
  * @cp:		codepage to which character should be converted
  * @mapchar:	should character be mapped according to mapchars mount option?
  *
@@ -63,10 +27,13 @@ static int smb_utf16_bytes(const __le16 *from, int maxbytes,
  * Return:	string length after conversion
  */
 static int
-cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
+cifs_mapchar(char *target, const __u16 *from, const struct nls_table *cp,
 	     bool mapchar)
 {
 	int len = 1;
+	__u16 src_char;
+
+	src_char = *from;
 
 	if (!mapchar)
 		goto cp_convert;
@@ -104,12 +71,66 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 
 cp_convert:
 	len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
-	if (len <= 0) {
-		*target = '?';
-		len = 1;
-	}
+	if (len <= 0)
+		goto surrogate_pair;
 
 	goto out;
+
+surrogate_pair:
+	/* convert SURROGATE_PAIR and IVS */
+	if (strcmp(cp->charset, "utf8"))
+		goto unknown;
+	len = utf16s_to_utf8s(from, 3, UTF16_LITTLE_ENDIAN, target, 6);
+	if (len <= 0)
+		goto unknown;
+	return len;
+
+unknown:
+	*target = '?';
+	len = 1;
+	goto out;
+}
+
+/*
+ * smb_utf16_bytes() - compute converted string length
+ * @from:	pointer to input string
+ * @maxbytes:	input string length
+ * @codepage:	destination codepage
+ *
+ * Walk a utf16le string and return the number of bytes that the string will
+ * be after being converted to the given charset, not including any null
+ * termination required. Don't walk past maxbytes in the source buffer.
+ *
+ * Return:	string length after conversion
+ */
+static int smb_utf16_bytes(const __le16 *from, int maxbytes,
+			   const struct nls_table *codepage)
+{
+	int i, j;
+	int charlen, outlen = 0;
+	int maxwords = maxbytes / 2;
+	char tmp[NLS_MAX_CHARSET_SIZE];
+	__u16 ftmp[3];
+
+	for (i = 0; i < maxwords; i++) {
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
+			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < maxwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
+
+		charlen = cifs_mapchar(tmp, ftmp, codepage, 0);
+		if (charlen > 0)
+			outlen += charlen;
+		else
+			outlen++;
+	}
+
+	return outlen;
 }
 
 /*
@@ -139,12 +160,12 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 			  const struct nls_table *codepage, bool mapchar)
 {
-	int i, charlen, safelen;
+	int i, j, charlen, safelen;
 	int outlen = 0;
 	int nullsize = nls_nullsize(codepage);
 	int fromwords = fromlen / 2;
 	char tmp[NLS_MAX_CHARSET_SIZE];
-	__u16 ftmp;
+	__u16 ftmp[3];	/* ftmp[3] = 3array x 2bytes = 6bytes UTF-16 */
 
 	/*
 	 * because the chars can be of varying widths, we need to take care
@@ -155,9 +176,15 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 	safelen = tolen - (NLS_MAX_CHARSET_SIZE + nullsize);
 
 	for (i = 0; i < fromwords; i++) {
-		ftmp = get_unaligned_le16(&from[i]);
-		if (ftmp == 0)
+		ftmp[0] = get_unaligned_le16(&from[i]);
+		if (ftmp[0] == 0)
 			break;
+		for (j = 1; j <= 2; j++) {
+			if (i + j < fromwords)
+				ftmp[j] = get_unaligned_le16(&from[i + j]);
+			else
+				ftmp[j] = 0;
+		}
 
 		/*
 		 * check to see if converting this character might make the
@@ -172,6 +199,19 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 		/* put converted char into 'to' buffer */
 		charlen = cifs_mapchar(&to[outlen], ftmp, codepage, mapchar);
 		outlen += charlen;
+
+		/*
+		 * charlen (=bytes of UTF-8 for 1 character)
+		 * 4bytes UTF-8(surrogate pair) is charlen=4
+		 * (4bytes UTF-16 code)
+		 * 7-8bytes UTF-8(IVS) is charlen=3+4 or 4+4
+		 * (2 UTF-8 pairs divided to 2 UTF-16 pairs)
+		 */
+		if (charlen == 4)
+			i++;
+		else if (charlen >= 5)
+			/* 5-6bytes UTF-8 */
+			i += 2;
 	}
 
 	/* properly null-terminate string */
@@ -306,6 +346,9 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 	char src_char;
 	__le16 dst_char;
 	wchar_t tmp;
+	wchar_t wchar_to[6];	/* UTF-16 */
+	int ret;
+	unicode_t u;
 
 	if (!mapchars)
 		return smb_strtoUTF16(target, source, srclen, cp);
@@ -348,11 +391,57 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 			 * if no match, use question mark, which at least in
 			 * some cases serves as wild card
 			 */
-			if (charlen < 1) {
-				dst_char = cpu_to_le16(0x003f);
-				charlen = 1;
+			if (charlen > 0)
+				goto ctoUTF16;
+
+			/* convert SURROGATE_PAIR */
+			if (strcmp(cp->charset, "utf8"))
+				goto unknown;
+			if (*(source + i) & 0x80) {
+				charlen = utf8_to_utf32(source + i, 6, &u);
+				if (charlen < 0)
+					goto unknown;
+			} else
+				goto unknown;
+			ret  = utf8s_to_utf16s(source + i, charlen,
+					UTF16_LITTLE_ENDIAN,
+					wchar_to, 6);
+			if (ret < 0)
+				goto unknown;
+
+			i += charlen;
+			dst_char = cpu_to_le16(*wchar_to);
+			if (charlen <= 3)
+				/* 1-3bytes UTF-8 to 2bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+			else if (charlen == 4) {
+				/*
+				 * 4bytes UTF-8(surrogate pair) to 4bytes UTF-16
+				 * 7-8bytes UTF-8(IVS) divided to 2 UTF-16
+				 * (charlen=3+4 or 4+4)
+				 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+			} else if (charlen >= 5) {
+				/* 5-6bytes UTF-8 to 6bytes UTF-16 */
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 1));
+				j++;
+				put_unaligned(dst_char, &target[j]);
+				dst_char = cpu_to_le16(*(wchar_to + 2));
+				j++;
+				put_unaligned(dst_char, &target[j]);
 			}
+			continue;
+
+unknown:
+			dst_char = cpu_to_le16(0x003f);
+			charlen = 1;
 		}
+
+ctoUTF16:
 		/*
 		 * character may take more than one byte in the source string,
 		 * but will take exactly two bytes in the target string
-- 
2.25.1



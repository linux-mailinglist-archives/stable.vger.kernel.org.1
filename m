Return-Path: <stable+bounces-7773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A480B817633
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA791F2543D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745C498B7;
	Mon, 18 Dec 2023 15:43:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127115485
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b7a0d1665so521650a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914186; x=1703518986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4q7tA+3qrd8T+bneHmflBQ6qoxNMZ79yyF7h/wHaT+Q=;
        b=dAflWCMsIDZ7s3ZpsUw+P3rpGoMlqIRWWK2zWOI0TXPiyR+BSGv2cyIxWOyZpD3Xgw
         MeQgiInAIy7cW8ZqBKNKbpnmnnOWoR3K0GbKyY3bSYra/5diVRAJ8uBgK4L2uPamR01I
         +4CK4C5XoqQFOty5ntCZ9+TVqQJK0tRho6DEkiueog2mYeUD5/lfikovBiy62iitFGLR
         6ohFpfgbiMF2xxOjQlJOLmUcuvSzshAomFbl1ssnX8Ng+ATpyYu5I0lgAs+kBEtwyAiW
         DFUVjN9FQCFzYRyD4LGlOfnPJgfP2fkWQ99RLb9lFyg9AEv6P2lMfzlA4LfLhuRwzNTm
         8R1w==
X-Gm-Message-State: AOJu0Yxi9DyRNh+8GlPtTmFQ/jM4Rys9LqvJCy+yXngWvQVvylO+BB0Z
	oiME8YwgKJRw7sNH6yTm7iw=
X-Google-Smtp-Source: AGHT+IH7tjkP9BGiyvi0+XBIq+KTCk3Y0d2tZnTb2Uw9n7LQSTHTwKBEIzTLYmd0W/B2vwP2zh/QWg==
X-Received: by 2002:a17:90a:f190:b0:28b:6a8a:188 with SMTP id bv16-20020a17090af19000b0028b6a8a0188mr763017pjb.95.1702914186065;
        Mon, 18 Dec 2023 07:43:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:43:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 144/154] ksmbd: add support for surrogate pair conversion
Date: Tue, 19 Dec 2023 00:34:44 +0900
Message-Id: <20231218153454.8090-145-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
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
 fs/ksmbd/unicode.c | 187 +++++++++++++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 49 deletions(-)

diff --git a/fs/ksmbd/unicode.c b/fs/ksmbd/unicode.c
index 9ae676906ed3..33fc6d45c0f3 100644
--- a/fs/ksmbd/unicode.c
+++ b/fs/ksmbd/unicode.c
@@ -14,46 +14,10 @@
 #include "uniupr.h"
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
@@ -64,10 +28,13 @@ static int smb_utf16_bytes(const __le16 *from, int maxbytes,
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
@@ -105,12 +72,66 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
 
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
@@ -140,12 +161,12 @@ cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
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
@@ -156,9 +177,15 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
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
@@ -173,6 +200,19 @@ static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
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
@@ -307,6 +347,9 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
 	char src_char;
 	__le16 dst_char;
 	wchar_t tmp;
+	wchar_t wchar_to[6];	/* UTF-16 */
+	int ret;
+	unicode_t u;
 
 	if (!mapchars)
 		return smb_strtoUTF16(target, source, srclen, cp);
@@ -349,11 +392,57 @@ int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
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



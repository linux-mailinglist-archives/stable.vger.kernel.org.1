Return-Path: <stable+bounces-61428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9D93C2E1
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8B1C209AB
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281DF19ADB9;
	Thu, 25 Jul 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTfIT8Dx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818319AD8E;
	Thu, 25 Jul 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913676; cv=none; b=LafPrz5V2Isr0uJvfOlOYbfEvaAvnDTa+DjbJqqfBjjYk1WcBliHNWswypoxosvKmBSf97Lf85Ua5bBZIHxTwSh1QltaTQYlwZob/SwJF5sk2Wu/0zZZ8iDNPlf1p1l54pAIIeo7lO2dUKpoe0YAO4zywvDAMtNaCigpo55SZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913676; c=relaxed/simple;
	bh=SQwUyJJYNBDNrApEgNlpZK9VLTUGWcTFRG44qxB3Ilk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtAS6JCON71KfAHoxnjmWjdnRksek5+BLGMIXHyyh7Q0AoNXebC59XH2Vw9B9q20K8QQsYgw5ARmCQJCj7vKaM9RIYZIKMgDja0Y0YTViryK8fXi7sj2Oy9BSCycTG1V7kk/WbWUnmQcMtGmm+7KDNnyf5Kq9Qs9TecTX5xsaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTfIT8Dx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so3655680a12.0;
        Thu, 25 Jul 2024 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721913673; x=1722518473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZFdDgftgxCkgqicoizCp1UMCfVU/fB+iQDh+LTpyjI=;
        b=ZTfIT8DxL1Sj/T8PCdKukSQKIDWQd0iPrxaHICulvW1RPQWA/O1FwXFdv0x/mTQQ9w
         jy93dbLlgp5NjTL2MSN9CCMH0omJQJeRGPojOqy2VVKLhZMqZ1WrysOBExiVHO5XIMK7
         +u9Q3uhQ2ZJwHwJd15O+wYNzxOnx0fUTcwCohU38Sg3k91MVixFHf0EQBhqwQ87PUh5z
         /wCUwcJMVcL1I2awW5Ay3xEJkQQbEsIU7ow3YVeM8Ty0o92kDDfrbD8fDDpt6GXS+dFa
         8/xrDR08T9YOspvHmEWKrjLx3zUSdojfaHlNPMYsLuAv0UHmEQYv5l2otiJctgSjbzSg
         AZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721913673; x=1722518473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZFdDgftgxCkgqicoizCp1UMCfVU/fB+iQDh+LTpyjI=;
        b=wQOey0AlvFUlhVybU2y+5BSZI/U2nn36e80W6tL//478U3GMcyZyo2pC959fCy2Hh3
         EgC4dQCuRonY6PMPWzW6HkCD5Fqqf+7jqmY23o8Smdu55Y/9aRQDYtjh9GvxszqZikTI
         PzqnQXKF6kRKYRBEvgooi6OQNXU/tTH30bcthvrCKIBo1mDN085BmT0B9xch4/93oxYU
         qX+YMPdch4Bn3QaURbwsDGDPHHWNTOvduh+Tpfvx0K8J0JP+YKvL0wABAL8HmecZxufB
         2EpK1CK5WI4L9wnMHC1qgysj1rc+NwugXAO5zoOngf5g28Y8eiQtDkGIR+jx0nLVHRwQ
         Uk+w==
X-Forwarded-Encrypted: i=1; AJvYcCWeYUjjQyozqBYyNEQNeIlzL6lByUwSxCXpu7eCbO+YF+uZuOPk+XVMoEiN1P6HwyG/Rr72vj0tpYQqHfqqdTent5pT+hUqbPNQT9xX3VuKU/SDHIrGbTsYvq7Q0JBz2vJ4VU7l0YY7tEVu
X-Gm-Message-State: AOJu0Yy8wvsSZsihXykeygKCDweRmxwBaH4wy7DFXw9tHitd5e+y2Abp
	mU/wm7oSji4cvoncKzbxsfq6+RHHikxPkP0+PvsbMtb7eJQdvDlLgG7GBg==
X-Google-Smtp-Source: AGHT+IGz5KVJkIKHOpUoQWx9ZY8f3DwGu4JbzCa1sB/EsdNoJ6+0JN1wbu0FtJHq/UfLXxeyiR6D6Q==
X-Received: by 2002:a17:907:3187:b0:a77:d4e1:f66e with SMTP id a640c23a62f3a-a7ac4563c14mr267021166b.20.1721913673638;
        Thu, 25 Jul 2024 06:21:13 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab535a6sm73158666b.88.2024.07.25.06.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 06:21:13 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
Date: Thu, 25 Jul 2024 15:20:45 +0200
Message-ID: <20240725132056.9151-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

conmakehash uses getenv("abs_srctree") from the environment to strip
the absolute path from the generated sources.
However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
abs_objtree") this environment variable no longer gets set.
Instead use basename() to indicate the used file in a comment of the
generated source file.

Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path of the input in output")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 drivers/tty/vt/conmakehash.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/conmakehash.c b/drivers/tty/vt/conmakehash.c
index dc2177fec715..82d9db68b2ce 100644
--- a/drivers/tty/vt/conmakehash.c
+++ b/drivers/tty/vt/conmakehash.c
@@ -11,6 +11,8 @@
  * Copyright (C) 1995-1997 H. Peter Anvin
  */
 
+#include <libgen.h>
+#include <linux/limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sysexits.h>
@@ -76,8 +78,8 @@ static void addpair(int fp, int un)
 int main(int argc, char *argv[])
 {
   FILE *ctbl;
-  const char *tblname, *rel_tblname;
-  const char *abs_srctree;
+  const char *tblname;
+  char base_tblname[PATH_MAX];
   char buffer[65536];
   int fontlen;
   int i, nuni, nent;
@@ -102,16 +104,6 @@ int main(int argc, char *argv[])
 	}
     }
 
-  abs_srctree = getenv("abs_srctree");
-  if (abs_srctree && !strncmp(abs_srctree, tblname, strlen(abs_srctree)))
-    {
-      rel_tblname = tblname + strlen(abs_srctree);
-      while (*rel_tblname == '/')
-	++rel_tblname;
-    }
-  else
-    rel_tblname = tblname;
-
   /* For now we assume the default font is always 256 characters. */
   fontlen = 256;
 
@@ -253,6 +245,8 @@ int main(int argc, char *argv[])
   for ( i = 0 ; i < fontlen ; i++ )
     nuni += unicount[i];
 
+  strncpy(base_tblname, tblname, PATH_MAX);
+  base_tblname[PATH_MAX - 1] = 0;
   printf("\
 /*\n\
  * Do not edit this file; it was automatically generated by\n\
@@ -264,7 +258,7 @@ int main(int argc, char *argv[])
 #include <linux/types.h>\n\
 \n\
 u8 dfont_unicount[%d] = \n\
-{\n\t", rel_tblname, fontlen);
+{\n\t", basename(base_tblname), fontlen);
 
   for ( i = 0 ; i < fontlen ; i++ )
     {
-- 
2.42.0



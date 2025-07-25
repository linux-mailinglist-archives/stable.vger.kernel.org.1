Return-Path: <stable+bounces-164718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59DB11807
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 07:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D3E3BF931
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 05:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62C9242D83;
	Fri, 25 Jul 2025 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJw7SO/E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF09242D67
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421953; cv=none; b=EVLa3jL3UeTVSyChQrllT4MrsWE1xvhrsDhsWRDYA4ZSAnEutBpcRpiCDPcpC2B/JPob/sgZlP0e024ZtL5nE5A3oAMjCLT0UodmUeBB8lBIDZI5LhUGgwmmh3mOSeIQ1cM7dHj9k2rIlYjUPM1FDu5mQhBEz0EeOCdTxdP4cYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421953; c=relaxed/simple;
	bh=966m0GOxsGJ5j1rjf2yCyD9LYwLA3a2IkLlHrebXO20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3NYGA2DcWr51fNX6rkZClDQWrvPBWEiqsQYd6IqFuP9xoB6OBsjBQjW/27UA4Fau0sX5vHT2U5OkDUKKWJzuQastN4A4vNMgfmVZtzYRLOo6Mwllwp6olUb87NcY3iETDdrXuewIbebOd0NzZrY+cnN0EmuM/l2WhgSqHf59wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJw7SO/E; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso1391613a91.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 22:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753421951; x=1754026751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPHXvAt3l53zXxlvilGeFtRkhY9gS5qitSJjpuzQX8U=;
        b=UJw7SO/EMAaXuTpVLaiEeTeRpDjO8iFFTb/QhCDQ7D+tOr7pWzlIlFN6niwV+ICsog
         ZrGI2jXURsUgS0P631mpoP0PHXCYmVWJtWCQUXBL6nHwWwZRRywNk5fQ2fCAXYi3JdQ2
         CaK+TnWFTs39t8a4e9hSLYSddmvwjq510Y2QBXRSquw3lwlf62fBQjySbiiTsc6yxMCk
         yWFuidKz5OhulVRWDY0TnPfN+mP7cKVRmzaxq/sHAsv1N7aR1gu4VfKGZXqRZ5cy9eO5
         76/SfJojoJBYuaDU74RLHh3CrEnXA/cB1/gxY02oJmFDxvPoeNbhAKkgrYh7AYM0yIjd
         lsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753421951; x=1754026751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPHXvAt3l53zXxlvilGeFtRkhY9gS5qitSJjpuzQX8U=;
        b=Qa1bveZq57jYEBJERhE71sOLlS+PK0UvzDMJHe7E7OpA0pF/mglOPUa74IHjT4aiN0
         DtntbS5t90gk4pxjuIHguZaSd8EFUOiryNtF8yJsTyfkvlxFsHQoPxEea8SDewjbMAI5
         kFJZWh7RSmJ2VFLrhN4Na5iauf935WGseUGrkn1GEB57o8jNgGHCD39uwpgEryVYXmwd
         JF5wQGq0A8MQnQHYrlZOPZUaWT37KzvurPazBQmtGTXAnp9fnH5YidqZUhOvHrKiQy/8
         2rsdNG/lEwepc+AAdZCaSHbxLZVuF4q3ljOS1Npt6QpLkQWMDOqMgOCpxEZdN0stL5eR
         MlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM3eJT3pZUDK3B6Q05EVxrC4zl4MgIlhyrDQkRiNpwfOnfQjbaBc/fUwZisF6oGHB9Uk5YDf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCa0MYdU/qQJG5gqr3vGjabywL+DVlFKLyC7TsDRikIBoCtsiL
	bIt/3yCHcRaEEGFu5wrXbSSrFUkJZvGyEnzlmUyttGPcxRdGr8nP5Fl2
X-Gm-Gg: ASbGncv3tdAjxT5e11v2+I04mnjFqvljl6LhYLPGC2LcXgvcHHjNC3pD2NzHOT7o5Oc
	MIHOplcceMROLTp6v2d8BmcN2agJT+DeGy1wXd6cDLs1FsI9r4vDWQSSBmgXwfr56bxwWCBt3fj
	ooCXCXvFUAaBqQBNDaY66AAlEN9cMpfuEJlcGjDaY3GFDQjZXggXCVXfXfbsCCT7jla3uuKH64q
	CX2lJ/OsZD2yciMtCjR7aeIDBUoefmrhelBY3RiiHyPXTweuu020EZNJP/bVF5XtjMPs1xkrL+Z
	8ecjOZYdWj+W0omNKLlvCONV/19ahurOVsG6161z9HjjUquZG2tF3WV9kqLTnUQQQULYeahyjDt
	GQhjmt0yhdo9bXyfNzwufQEm0/fcH2wJJ0+ISPFOuoRTNlQ==
X-Google-Smtp-Source: AGHT+IEfocSkBuFg0ctSah7zTyb7jqeh5RukwbMZprqXK0hKFEaFOTG3tScP+6sedm5tsIWAoh5l5Q==
X-Received: by 2002:a17:90b:5408:b0:311:fde5:c4c2 with SMTP id 98e67ed59e1d1-31e77841a77mr730037a91.1.1753421950909;
        Thu, 24 Jul 2025 22:39:10 -0700 (PDT)
Received: from localhost.localdomain ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662685fesm2657265a91.6.2025.07.24.22.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:39:10 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: suchitk.211me155@nitk.edu.in
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] sprintf.h requires stdarg.h
Date: Fri, 25 Jul 2025 11:09:00 +0530
Message-Id: <20250725053900.32262-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stephen Rothwell <sfr@canb.auug.org.au>

In file included from drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c:4:
include/linux/sprintf.h:11:54: error: unknown type name 'va_list'
   11 | __printf(2, 0) int vsprintf(char *buf, const char *, va_list);
      |                                                      ^~~~~~~
include/linux/sprintf.h:1:1: note: 'va_list' is defined in header '<stdarg.h>'; this is probably fixable by adding '#include <stdarg.h>'

Link: https://lkml.kernel.org/r/20250721173754.42865913@canb.auug.org.au
Fixes: 39ced19b9e60 ("lib/vsprintf: split out sprintf() and friends")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 include/linux/sprintf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 51cab2def9ec..876130091384 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
+#include <linux/stdarg.h>
 
 int num_to_str(char *buf, int size, unsigned long long num, unsigned int width);
 
-- 
2.39.5



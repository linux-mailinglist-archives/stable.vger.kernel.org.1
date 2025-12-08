Return-Path: <stable+bounces-200378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F81CAE63C
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 00:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D908B3024E55
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 23:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30022D3EDF;
	Mon,  8 Dec 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ5DMln0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7B2D5A14
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765235614; cv=none; b=Rt3c81KUovIWjqgdRJ+AzGMHVj/qHqUl330DGsC67vAe2R09QZ1ZWojGoNB9PwUBi7yqivGBHdhZR83mUoVrgI8Y921y6LTH/SPghOKCREPq9l6EUDEaqvQwiz8KzNHHtdaTJSOQfGtwTnTSmZveaTWsrhIQcGAAwM1Vdvf9dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765235614; c=relaxed/simple;
	bh=sCuYg/i8Zn5qmYz6s1tkarVebpCmEojScJUUpBsYWWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZyyyh/dv6A+oEQTBAptXWkRi6Yi19kkFRzldoZbDxV5QW7VDrLunvTy/37sS4d0iiP4HvCTucSuoJW6rZ3gd/mx3yxEVq+ror/anzh0DbGnvla35BIjHNnrSuNXJQx1VH+C+zS8q6tZL8k/gu410+SOQx0ZVTjWtdc4oM5I8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ5DMln0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso5739108b3a.2
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 15:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765235612; x=1765840412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7cNkudiHBLvbO1BAbAlJ5UuS7KUF5P5v2oxjto4jk7E=;
        b=dZ5DMln0FLpqA0c99xH6JqFgXByVitX269oJzubAls1hWjf1Mx1Rn5NTIJ4Sj9YY5l
         8eNYR9lVNBTiGxrS0KKkQPqMBi0ZRqQudAWtVzZt8P8TKrL1ymBXe3XqnhWRbPy5Y3Ad
         abg8OUnzDogRIj+tFDOGtUAYsCGM2FIiJ+4yzSbS4/aMiPuJuAiS4kkUUsZ2i10eZ5Dn
         TOW83pjIJbvtyRCDvg7hYcTnmD/QGHncUq9GlkrZkSkpXokKWTwZB+wV48Y2Zf0hMwv1
         eJ1DWTxEK+kHUBmezvF2NHb7BOJpmyLDxLF8PiS5xUUhiG3j6zAV7NSX0qniIqv+d+p2
         x8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765235612; x=1765840412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cNkudiHBLvbO1BAbAlJ5UuS7KUF5P5v2oxjto4jk7E=;
        b=BFOkIwQcsdblTIkNO9JUBxVbE9Td2S4Akmi0DVPrqPPsldDY3iJCJd3u4hvfQiYK1C
         ATxn/aLxs7IU4VmJ89t/Z3jIo4pGsXonxnwLyq3R5qw4LKXxCGT4Shbb9MrLE21wsEi2
         N1cp2UskVSb4RI6XtAFWY0tHzrOP7ZJChroxzqE1r9zcgEGAGBPqJZGlrG/2TaWnj7eG
         HAX9AaJY43SbZcpqVCqioDsLVGlVeMxWYdxHFXFBkPx39dgBTPGFAIAR9ScaHc3zVBBs
         ZfKnwJNZXYXws80vrPhf687pkVeMZX5qVnPQmSBaIbNxtMBrsto8gLyvokATtq70XCVJ
         nWVA==
X-Forwarded-Encrypted: i=1; AJvYcCVsSX07zfIxbnT7MO79CIc4R8noaYsHDJe7MBVPwWfHyghi6FiiiSBhGwnv9qquNVM1tzupUcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7inCoAbIhU6owUlWn6JFuCuHblqeBs/E5dgce99x25amEnUtR
	7oD4GLwFOZj/+kvMOdGhRf9fnlkuQd9L1F5wHL7yZZIcF22QZ++vCvZC
X-Gm-Gg: ASbGncu9PgADXPSQNkGjmITuHWuizVFyLFUmwIbKih+ShLMS1H6WyLVhlMYt/8HITzj
	brNocs9TqQfu/FbFPmAhd1r1/2zuKw8LYm+ubhlGnlFrbYNR+OGcms9txCdHCNWICzCXxFZNfiy
	qCLKR3YiHFPrqZdwEy8h7ho4YCKC4oFyFNCGlEgN7e7bPfwgiQkyf/rjK0ci8hcuRmTilP+0sl7
	2TqoVBAFWiyp0EXCQFBxuCXfc5thhzAuyh0rKk99Y9pSmZYkQVovz70EKPJ0rikUISwD/vcQR3w
	8D66WY/UD2Ut7UbU+JgqvmqSozO/NOiHHREBoB2XvyVbQikcLrzPLT8ZLeldR5abtGSPEz5mJCX
	JbpEmHTvt08hKND7WTv8zF+pVQIRyIXSUCOvF9/EWZvTLuW4mc8XDBwNfYWdE4wn1nS5uEz5HYl
	Rn28nNZQaNjh4=
X-Google-Smtp-Source: AGHT+IENI8piQgxp7BPJwYHC2wEim4PgmyRYNo8uvtRwTtLeTNSPYOAZs1mD+ZS6wM1lTT6oQ+n41Q==
X-Received: by 2002:a05:6a20:7f81:b0:334:912f:acea with SMTP id adf61e73a8af0-366180175c0mr8791792637.59.1765235611666;
        Mon, 08 Dec 2025 15:13:31 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6817397d0sm13136853a12.6.2025.12.08.15.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 15:13:31 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 24242421DA23; Tue, 09 Dec 2025 06:13:28 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	stable@vger.kernel.org,
	Gopi Krishna Menon <krishnagopi487@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 6.18.y] Documentation/rtla: rename common_xxx.rst files to common_xxx.txt
Date: Tue,  9 Dec 2025 06:13:00 +0700
Message-ID: <20251208231300.9386-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13847; i=bagasdotme@gmail.com; h=from:subject; bh=4yDdjpvK5UYgmsBWh3Cf2nkLEypdnAasaE0SdB09688=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnmUbOOc/556++80l3r8p+v1V8TJjjXxVxZW2dSazTJV WuNhMvzjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwkUJ/hr/yTjQ9l2lYuU564 vXSt3o2tdbMn+53KSUkJ5djj+fPgvRiG/66HrewvnPjCd6W9WOjNxvSQ/3uj/u9M1+Vfbzvl9YR jb1kA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Gopi Krishna Menon <krishnagopi487@gmail.com>

commit 96b546c241b11a97ba1247580208c554458e7866 upstream.

Sphinx reports htmldocs errors:

Documentation/tools/rtla/common_options.rst:58: ERROR: Undefined substitution referenced: "threshold".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tool".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "thresharg".
Documentation/tools/rtla/common_options.rst:88: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:92: ERROR: Undefined substitution referenced: "tracer".
Documentation/tools/rtla/common_options.rst:98: ERROR: Undefined substitution referenced: "actionsperf".
Documentation/tools/rtla/common_options.rst:113: ERROR: Undefined substitution referenced: "tool".

common_*.rst files are snippets that are intended to be included by rtla
docs (rtla*.rst). common_options.rst in particular contains
substitutions which depend on other common_* includes, so building it
independently as reST source results in above errors.

Rename all common_*.rst files to common_*.txt to prevent Sphinx from
building these snippets as standalone reST source and update all include
references accordingly.

Cc: stable@vger.kernel.org
Link: https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions
Suggested-by: Tomas Glozar <tglozar@redhat.com>
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Fixes: 05b7e10687c6 ("tools/rtla: Add remaining support for osnoise actions")
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20251008184522.13201-1-krishnagopi487@gmail.com
[Bagas: massage commit message and apply trailers]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <20251013092719.30780-2-bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Note: The warnings were present in 6.18 cycle but unfortunately the original
96b546c241b11a97ba1247580208c554458e7866 got instead queued up for 6.19
merge window.

 .../{common_appendix.rst => common_appendix.txt}     |  0
 ...mmon_hist_options.rst => common_hist_options.txt} |  0
 .../rtla/{common_options.rst => common_options.txt}  |  0
 ...escription.rst => common_osnoise_description.txt} |  0
 ...snoise_options.rst => common_osnoise_options.txt} |  0
 ...common_timerlat_aa.rst => common_timerlat_aa.txt} |  0
 ...scription.rst => common_timerlat_description.txt} |  0
 ...erlat_options.rst => common_timerlat_options.txt} |  0
 ...common_top_options.rst => common_top_options.txt} |  0
 Documentation/tools/rtla/rtla-hwnoise.rst            |  8 ++++----
 Documentation/tools/rtla/rtla-osnoise-hist.rst       | 10 +++++-----
 Documentation/tools/rtla/rtla-osnoise-top.rst        | 10 +++++-----
 Documentation/tools/rtla/rtla-osnoise.rst            |  4 ++--
 Documentation/tools/rtla/rtla-timerlat-hist.rst      | 12 ++++++------
 Documentation/tools/rtla/rtla-timerlat-top.rst       | 12 ++++++------
 Documentation/tools/rtla/rtla-timerlat.rst           |  4 ++--
 Documentation/tools/rtla/rtla.rst                    |  2 +-
 17 files changed, 31 insertions(+), 31 deletions(-)
 rename Documentation/tools/rtla/{common_appendix.rst => common_appendix.txt} (100%)
 rename Documentation/tools/rtla/{common_hist_options.rst => common_hist_options.txt} (100%)
 rename Documentation/tools/rtla/{common_options.rst => common_options.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_description.rst => common_osnoise_description.txt} (100%)
 rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_aa.rst => common_timerlat_aa.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)
 rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)
 rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.txt
similarity index 100%
rename from Documentation/tools/rtla/common_appendix.rst
rename to Documentation/tools/rtla/common_appendix.txt
diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_hist_options.rst
rename to Documentation/tools/rtla/common_hist_options.txt
diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_options.rst
rename to Documentation/tools/rtla/common_options.txt
diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_description.rst
rename to Documentation/tools/rtla/common_osnoise_description.txt
diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_options.rst
rename to Documentation/tools/rtla/common_osnoise_options.txt
diff --git a/Documentation/tools/rtla/common_timerlat_aa.rst b/Documentation/tools/rtla/common_timerlat_aa.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_aa.rst
rename to Documentation/tools/rtla/common_timerlat_aa.txt
diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_description.rst
rename to Documentation/tools/rtla/common_timerlat_description.txt
diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_options.rst
rename to Documentation/tools/rtla/common_timerlat_options.txt
diff --git a/Documentation/tools/rtla/common_top_options.rst b/Documentation/tools/rtla/common_top_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_top_options.rst
rename to Documentation/tools/rtla/common_top_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 3a7163c02ac8e8..26512b15fe7ba5 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -29,11 +29,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -106,4 +106,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 1fc60ef2610677..007521c865d97e 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The **rtla osnoise hist** tool collects all **osnoise:sample_threshold**
 occurrence in a histogram, displaying the results in a user-friendly way.
@@ -24,11 +24,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -65,4 +65,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index b1cbd7bcd4aed2..6ccadae3894570 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -15,7 +15,7 @@ SYNOPSIS
 
 DESCRIPTION
 ===========
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 **rtla osnoise top** collects the periodic summary from the *osnoise* tracer,
 including the counters of the occurrence of the interference source,
@@ -26,11 +26,11 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
 EXAMPLE
 =======
@@ -60,4 +60,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index c129b206ce3484..540d2bf6c15247 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_osnoise_description.rst
+.. include:: common_osnoise_description.txt
 
 The *osnoise* tracer outputs information in two ways. It periodically prints
 a summary of the noise of the operating system, including the counters of
@@ -56,4 +56,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 4923a362129bbd..f56fe546411bd4 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat hist** displays a histogram of each tracer event
 occurrence. This tool uses the periodic information, and the
@@ -25,13 +25,13 @@ occurrence. This tool uses the periodic information, and the
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
-.. include:: common_hist_options.rst
+.. include:: common_hist_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 EXAMPLE
 =======
@@ -110,4 +110,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 50968cdd2095a1..7dbe625d0c4243 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** displays a summary of the periodic output
 from the *timerlat* tracer. It also provides information for each
@@ -26,13 +26,13 @@ seem with the option **-T**.
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
-.. include:: common_options.rst
+.. include:: common_options.txt
 
-.. include:: common_timerlat_aa.rst
+.. include:: common_timerlat_aa.txt
 
 **--aa-only** *us*
 
@@ -133,4 +133,4 @@ AUTHOR
 ------
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index 20e2d259467fd0..ce9f57e038c37f 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** mode displays a summary of the periodic output
 from the *timerlat* tracer. The **rtla timerlat hist** mode displays
@@ -51,4 +51,4 @@ AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt
diff --git a/Documentation/tools/rtla/rtla.rst b/Documentation/tools/rtla/rtla.rst
index fc0d233efcd5df..2a5fb7004ad448 100644
--- a/Documentation/tools/rtla/rtla.rst
+++ b/Documentation/tools/rtla/rtla.rst
@@ -45,4 +45,4 @@ AUTHOR
 ======
 Daniel Bristot de Oliveira <bristot@kernel.org>
 
-.. include:: common_appendix.rst
+.. include:: common_appendix.txt

base-commit: a66aab4b0ed2ca786d5512e843f32d96942ff311
-- 
An old man doll... just what I always wanted! - Clara



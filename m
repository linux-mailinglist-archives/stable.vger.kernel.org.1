Return-Path: <stable+bounces-6760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FB48139AE
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF041C20C09
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1667E66;
	Thu, 14 Dec 2023 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxKw4w2K"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1718123
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:14 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e2f0e7e17dso23006637b3.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702577714; x=1703182514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Dc13JLQ0ggY/MY+gcECuojTLa0Kc5Wj2q3a3yLHuk=;
        b=xxKw4w2KbRXq6xOprhkFWsoRLHz2kFnfdLg5+18AbjsWxexpxUK0qHsjtS0M8wYxi6
         /n9FDDstCTlHRz8nDC+yPYD3aV9D5Nz5Enc4C3XoIMcU79TaAQFQmwdafrMJd5PihZkK
         yWnWwTSaocKPvL5ty8PzYLScK8g3qkhN1qG/MHA543UtI6o7MW31iX3IcXfXkwGncNIV
         Pi58ij2qDRPvyqQXRQkkewRExzFINPD7a2bgIgAxoVVhfTxM83fMEozJyACNglMzGd6G
         094qBkx732CF7VqLZ5PXmtji5+vBMXae+TaIV6vnq5CrCkkt63jzLAEx8h4F2hLbaa3H
         bWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577714; x=1703182514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Dc13JLQ0ggY/MY+gcECuojTLa0Kc5Wj2q3a3yLHuk=;
        b=ZsvKKsrL+XxK/S3z+hO5cjsU/K74i6QnhKm8W0hhAkTw/xxxA43m9COh1F9ip6ZXH9
         mtMERwd5Ah6lxrnouN6SJ2n5XzSxVqwfDywmPsLZyLYOQfh1BqqrHblinqsWaWX+g4yo
         kWl2lxYhmGvsj0z4HR1Db1/sKdaeN2u6Txs/mmVfXnNydnmS5P2aMpkykhIMi5o+ygxt
         TwjQRbg9arGhifTS6Me9w7rmQZltJXPTtcu/e4bVGQ5M5+Rm2FDJRnfXZ9sMgotrBQSg
         ynTypQu1/XTjgQ/lq8MXlGFfAJJXLxMQpxlYgaenKbcjJlF7Q8p6cPRCbEWv89REp9Ts
         EXAg==
X-Gm-Message-State: AOJu0Yw3YFWSkPy/0xZfxdy4FbmPpfjaLSF6xJh3r/+W44bI0ck5sXm/
	tkxd2OX42AkEJv/S7yXCYDQsFelbc467dzSMwcVhdyvcIg3Us9yuVufPu7YibAgFhE7FaXrEZrW
	BA2/RIi1hJWpUb5lGyxFKSJVG7qyF/fKbJWm0G4S9mzwKDyp4tq+u2ZJV2V12AS0v2CA=
X-Google-Smtp-Source: AGHT+IFKzRb2y+iZAvdCAs6Ux0eRlKTm+E2+rfY1Hq6QOZFjJBN8Y/VD6rR9eCZzoiNTzp20HRocJ39CqUkXyw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:b8c:b0:5ca:5fcd:7063 with SMTP
 id ck12-20020a05690c0b8c00b005ca5fcd7063mr127417ywb.3.1702577713787; Thu, 14
 Dec 2023 10:15:13 -0800 (PST)
Date: Thu, 14 Dec 2023 18:15:04 +0000
In-Reply-To: <20231214181505.2780546-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214181505.2780546-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214181505.2780546-3-cmllamas@google.com>
Subject: [PATCH 5.10 2/2] checkpatch: fix false positives in REPEATED_WORD warning
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>
Cc: kernel-team@android.com, Aditya Srivastava <yashsri421@gmail.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Aditya Srivastava <yashsri421@gmail.com>

commit 8d0325cc74a31d517b5b4307c8d895c6e81076b7 upstream.

Presence of hexadecimal address or symbol results in false warning
message by checkpatch.pl.

For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
memory leak in mptcp_subflow_create_socket()") results in warning:

  WARNING:REPEATED_WORD: Possible repeated word: 'ff'
      00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....

Similarly, the presence of list command output in commit results in
an unnecessary warning.

For example, running checkpatch on commit 899e5ffbf246 ("perf record:
Introduce --switch-output-event") gives:

  WARNING:REPEATED_WORD: Possible repeated word: 'root'
    dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..

Here, it reports 'ff' and 'root' to be repeated, but it is in fact part
of some address or code, where it has to be repeated.

In these cases, the intent of the warning to find stylistic issues in
commit messages is not met and the warning is just completely wrong in
this case.

To avoid these warnings, add an additional regex check for the directory
permission pattern and avoid checking the line for this class of
warning.  Similarly, to avoid hex pattern, check if the word consists of
hex symbols and skip this warning if it is not among the common english
words formed using hex letters.

A quick evaluation on v5.6..v5.8 showed that this fix reduces
REPEATED_WORD warnings by the frequency of 1890.

A quick manual check found all cases are related to hex output or list
command outputs in commit messages.

Link: https://lkml.kernel.org/r/20201024102253.13614-1-yashsri421@gmail.com
Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
Acked-by: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/checkpatch.pl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a83e5f0088bb..c2704af497ba 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -853,6 +853,13 @@ our $declaration_macros = qr{(?x:
 	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
 )};
 
+our %allow_repeated_words = (
+	add => '',
+	added => '',
+	bad => '',
+	be => '',
+);
+
 sub deparenthesize {
 	my ($string) = @_;
 	return "" if (!defined($string));
@@ -3049,7 +3056,9 @@ sub process {
 		}
 
 # check for repeated words separated by a single space
-		if ($rawline =~ /^\+/ || $in_commit_log) {
+# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
+		if (($rawline =~ /^\+/ || $in_commit_log) &&
+		    $rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
 			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
@@ -3074,6 +3083,11 @@ sub process {
 				next if ($start_char =~ /^\S$/);
 				next if (index(" \t.,;?!", $end_char) == -1);
 
+                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
+                                if ($first =~ /\b[0-9a-f]{2,}\b/i) {
+                                        next if (!exists($allow_repeated_words{lc($first)}));
+                                }
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.43.0.472.g3155946c3a-goog



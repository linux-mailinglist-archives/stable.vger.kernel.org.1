Return-Path: <stable+bounces-6759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D68139AD
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F5E1C20D40
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121DF67E99;
	Thu, 14 Dec 2023 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWW4csfa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B70F128
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d34350cbe8so35485965ad.0
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702577712; x=1703182512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpErYhHcAVQWtwLI6q5M1DEEO/9/sXgbxd5RV6ElUmE=;
        b=LWW4csfaY0rkwH3PnW2JtO2yBGUNEWMj6YdAgk4DsQ7ilsPqfjSgMEfAdQILl1K8M8
         RKGe1sCMNGeNB4duCx5JUgdYyBLf+ha+D71pTrq+g2zT58b+1nUE/K0llhPuaN3vBT2A
         x/oJ8pNE+TTHMKqR8zLk3vnvN2gSg4WMDMrCySk5L8zLwJWf3zQaecz+LQTPo4aSdNRD
         cerY+I4whfopGvSPCdHMdXF/yby6Lh3kJDTTbZdUwLdTUUGCgoOAsYVc+eAK/SZvDFX3
         WIri2CoU2epRRrlKnCw5LUx/3u8amav3OqhwFwYy9OQHDpwRgW2zHO3oboPaqGbfI3N4
         eTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577712; x=1703182512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpErYhHcAVQWtwLI6q5M1DEEO/9/sXgbxd5RV6ElUmE=;
        b=Kh8hRjHO1bgFLCiRGHVIea7ZRGnm0Gp4LMWDpyW7vr/whsD/vAH1ThKVkShfYPYRyC
         kPs/Yz2dJYtjyWWsy9Gul8m5FvKWV2nUnUnKOR/Iinzny4CfB9+6RBUwLs6X2qe+PfUR
         laM+/NR7/nXb4VuC4FACDQoLx1OfnxOOVjy8V1qX3dEbsWnYdcBbH0ozprwsOIQM+2nL
         0Plc1OmyFlnR3wZJzBUZHXNNR0orCV5JF6ajOovqSUSqj9XQjotg4X8ryrz65g+Cl1gn
         OrGRLF7Vcwx2cT3U8rqi91Nt+LY2Y7lxDTMIOvE9ROyOcYHSfZli+Bc23FBSi9+m0JE+
         K/0Q==
X-Gm-Message-State: AOJu0Ywg2lX6zqG2ynLMH12q0Rq3vHKFJzmi4sWp9cXNh3wTd2bhhF7X
	vOHRAanCVChbgjVCLL6nSSMXUhbSYmTFaTdS6qRGZkBfUftPOVMNP1kkQfKE9KzfyplUwnOaZNZ
	qIU5gQ9yWbEKE+eEv236KBJkCUcWAl1usJcOPCOTfZw4Vtrz6HJLQ/5ZdpXEAediHzU8=
X-Google-Smtp-Source: AGHT+IHdoyIz/eD2VR5RsTsIda+aupvdBofiTkWnWl+jX5H1K2h/RaNeRAw+tRwT770y13+mL6VAgDvvxQ25ng==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:e852:b0:1d3:6110:32f2 with SMTP
 id t18-20020a170902e85200b001d3611032f2mr1453232plg.9.1702577711696; Thu, 14
 Dec 2023 10:15:11 -0800 (PST)
Date: Thu, 14 Dec 2023 18:15:03 +0000
In-Reply-To: <20231214181505.2780546-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214181505.2780546-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214181505.2780546-2-cmllamas@google.com>
Subject: [PATCH 5.10 1/2] checkpatch: add new exception to repeated word check
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>
Cc: kernel-team@android.com, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Aditya Srivastava <yashsri421@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Dwaipayan Ray <dwaipayanray1@gmail.com>

commit 1db81a682a2f2a664489c4e94f3b945f70a43a13 upstream.

Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
moved the repeated word test to check for more file types. But after
this, if checkpatch.pl is run on MAINTAINERS, it generates several
new warnings of the type:

  WARNING: Possible repeated word: 'git'

For example:

  WARNING: Possible repeated word: 'git'
  +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

So, the pattern "git git://..." is a false positive in this case.

There are several other combinations which may produce a wrong warning
message, such as "@size size", ":Begin begin", etc.

Extend repeated word check to compare the characters before and after
the word matches.

If there is a non whitespace character before the first word or a non
whitespace character excluding punctuation characters after the second
word, then the check is skipped and the warning is avoided.

Also add case insensitive word matching to the repeated word check.

Link: https://lore.kernel.org/linux-kernel-mentees/81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com/
Link: https://lkml.kernel.org/r/20201017162732.152351-1-dwaipayanray1@gmail.com
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
Suggested-by: Joe Perches <joe@perches.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Joe Perches <joe@perches.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0ad235ee96f9..a83e5f0088bb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3050,19 +3050,30 @@ sub process {
 
 # check for repeated words separated by a single space
 		if ($rawline =~ /^\+/ || $in_commit_log) {
+			pos($rawline) = 1 if (!$in_commit_log);
 			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
 
 				my $first = $1;
 				my $second = $2;
-
+				my $start_pos = $-[1];
+				my $end_pos = $+[2];
 				if ($first =~ /(?:struct|union|enum)/) {
 					pos($rawline) += length($first) + length($second) + 1;
 					next;
 				}
 
-				next if ($first ne $second);
+				next if (lc($first) ne lc($second));
 				next if ($first eq 'long');
 
+				# check for character before and after the word matches
+				my $start_char = '';
+				my $end_char = '';
+				$start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > ($in_commit_log ? 0 : 1));
+				$end_char = substr($rawline, $end_pos, 1) if ($end_pos < length($rawline));
+
+				next if ($start_char =~ /^\S$/);
+				next if (index(" \t.,;?!", $end_char) == -1);
+
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&
 				    $fix) {
-- 
2.43.0.472.g3155946c3a-goog



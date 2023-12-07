Return-Path: <stable+bounces-4881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CB807CCF
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 01:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4368B21135
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 00:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150767E;
	Thu,  7 Dec 2023 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MBRKJCGD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4451380
	for <stable@vger.kernel.org>; Thu,  7 Dec 2023 00:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44975C433C9;
	Thu,  7 Dec 2023 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701908011;
	bh=9WD1wAGYhjrCyk90QtJ4lOnF8ebhQSAKs5c17ysIlkA=;
	h=Date:To:From:Subject:From;
	b=MBRKJCGDEboozCgtr8DNmCHwdLGSPw8qwzOUoCQ3QzURe+hn1uKrXqkOUIqvpPx0w
	 OClaf8X63RqEn9vBs1lZuNMFKbsr2OPRCWiwj4xPZwKXHHhz+OnXaqQZ3jBhyHDeiE
	 fh+HkhC+nafa2yyau7wf9lL1ET0KbNqf//gM5E7w=
Date: Wed, 06 Dec 2023 16:13:30 -0800
To: mm-commits@vger.kernel.org,v.narang@samsung.com,stable@vger.kernel.org,masahiroy@kernel.org,maninder1.s@samsung.com,hca@linux.ibm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] checkstack-fix-printed-address.patch removed from -mm tree
Message-Id: <20231207001331.44975C433C9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: checkstack: fix printed address
has been removed from the -mm tree.  Its filename was
     checkstack-fix-printed-address.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Heiko Carstens <hca@linux.ibm.com>
Subject: checkstack: fix printed address
Date: Mon, 20 Nov 2023 19:37:17 +0100

All addresses printed by checkstack have an extra incorrect 0 appended at
the end.

This was introduced with commit 677f1410e058 ("scripts/checkstack.pl: don't
display $dre as different entity"): since then the address is taken from
the line which contains the function name, instead of the line which
contains stack consumption. E.g. on s390:

0000000000100a30 <do_one_initcall>:
...
  100a44:       e3 f0 ff 70 ff 71       lay     %r15,-144(%r15)

So the used regex which matches spaces and hexadecimal numbers to extract
an address now matches a different substring. Subsequently replacing spaces
with 0 appends a zero at the and, instead of replacing leading spaces.

Fix this by using the proper regex, and simplify the code a bit.

Link: https://lkml.kernel.org/r/20231120183719.2188479-2-hca@linux.ibm.com
Fixes: 677f1410e058 ("scripts/checkstack.pl: don't display $dre as different entity")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Cc: Maninder Singh <maninder1.s@samsung.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Vaneet Narang <v.narang@samsung.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 scripts/checkstack.pl |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/scripts/checkstack.pl~checkstack-fix-printed-address
+++ a/scripts/checkstack.pl
@@ -139,15 +139,11 @@ $total_size = 0;
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
-		next if $line !~ m/^($xs*)/;
+		next if $line !~ m/^($x*)/;
 		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
-
-		$addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
-
+		$addr = "0x$1";
 		$intro = "$addr $func [$file]:";
 		my $padlen = 56 - length($intro);
 		while ($padlen > 0) {
_

Patches currently in -mm which might be from hca@linux.ibm.com are

arch-remove-arch_thread_stack_allocator.patch
arch-remove-arch_task_struct_allocator.patch
arch-remove-arch_task_struct_on_stack.patch
checkstack-sort-output-by-size-and-function-name.patch
checkstack-allow-to-pass-minstacksize-parameter.patch



Return-Path: <stable+bounces-161513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BC8AFF7C5
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 06:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B041734E0
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 04:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7E28136B;
	Thu, 10 Jul 2025 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SlU1hcAj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61561A285;
	Thu, 10 Jul 2025 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752120539; cv=none; b=LhPNBiy/VZMFJbeyrGLYI2PC2QIrmpyqWTVQAV45XFCvCCkibmciAxBKAXSeRjqrs2iX4lSu5XLokJIKVVJgsgME9ZWlFOtDzXjXZzl4JVDiO0HDkB8Rp45UIMPV3ZI9u6BqV2YfJ6AvAgZOzPonnL/ziF38D2dz6ebpLAdpKuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752120539; c=relaxed/simple;
	bh=fweoABG85MNv8GTowspSS4Q03wrZiJz4aoSNjRkRRNc=;
	h=Date:To:From:Subject:Message-Id; b=FstxZ210frP71/ynYzlCVX4s9Rqon6xK32jN1meOKzGEC0suN31JVrgxReWxLmoHARJYMFhg+UvOF8EkdU3H9jpC6JVj6wKlq6i1diGoDT38nRB08BSejvNEocMRwCvoFmx7gfuCVLw7Vrv95o628GrSLk8MS7iH5is7S1GpGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SlU1hcAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5630DC4CEE3;
	Thu, 10 Jul 2025 04:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752120538;
	bh=fweoABG85MNv8GTowspSS4Q03wrZiJz4aoSNjRkRRNc=;
	h=Date:To:From:Subject:From;
	b=SlU1hcAjDrJofz3RG4XnXOi28vE5MW/7HB7H1zJ1vbwvQgg2Rl7hw4anxrdWWpNsl
	 33nWAiNoNwcCdYZBf5SnwxGBQlpUEO7Qr72Pa0gb2haV7CgrVS28ih9lVAftP9//TV
	 kZ+LdBzF4whPPBgo2GrF477XufRvXoGsbbfMa7d8=
Date: Wed, 09 Jul 2025 21:08:57 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,luis@igalia.com,gregkh@linuxfoundation.org,fossdd@pwned.life,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] kallsyms-fix-build-without-execinfo.patch removed from -mm tree
Message-Id: <20250710040858.5630DC4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: kallsyms: fix build without execinfo
has been removed from the -mm tree.  Its filename was
     kallsyms-fix-build-without-execinfo.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Achill Gilgenast <fossdd@pwned.life>
Subject: kallsyms: fix build without execinfo
Date: Sun, 22 Jun 2025 03:45:49 +0200

Some libc's like musl libc don't provide execinfo.h since it's not part of
POSIX.  In order to fix compilation on musl, only include execinfo.h if
available (HAVE_BACKTRACE_SUPPORT)

This was discovered with c104c16073b7 ("Kunit to check the longest symbol
length") which starts to include linux/kallsyms.h with Alpine Linux'
configs.

Link: https://lkml.kernel.org/r/20250622014608.448718-1-fossdd@pwned.life
Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
Cc: Luis Henriques <luis@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/include/linux/kallsyms.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/include/linux/kallsyms.h~kallsyms-fix-build-without-execinfo
+++ a/tools/include/linux/kallsyms.h
@@ -18,6 +18,7 @@ static inline const char *kallsyms_looku
 	return NULL;
 }
 
+#ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #include <stdlib.h>
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
@@ -30,5 +31,8 @@ static inline void print_ip_sym(const ch
 
 	free(name);
 }
+#else
+static inline void print_ip_sym(const char *loglvl, unsigned long ip) {}
+#endif
 
 #endif
_

Patches currently in -mm which might be from fossdd@pwned.life are




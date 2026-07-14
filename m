Return-Path: <stable+bounces-274044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5BMMUyJVWodpwAAu9opvQ
	(envelope-from <stable+bounces-274044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 02:56:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE774FF14
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 02:56:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=Ak4bkaw2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274044-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274044-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 883AE301C898
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 00:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EE630216D;
	Tue, 14 Jul 2026 00:56:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434526B973;
	Tue, 14 Jul 2026 00:56:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990596; cv=none; b=fAOg0KPUvgOV7l0FdnKuYzcFq92zwhHmklpXXwVQ9nSePK6C890duUsFoFj3BEqDvUMLKyehZtIqo3eWQlBwiPosmspIFtXep9Eds9pQ4hKl9dcZX7CPUEV8qLSLndyS8n0NwQNJxZwSv7nnEm8ERazm/eX9vym/DdFOJrs9PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990596; c=relaxed/simple;
	bh=PF20xbni8f0VWjHbNXhxaVnHLT+ddkLnv9GvKeLkODk=;
	h=Date:To:From:Subject:Message-Id; b=AOKjJ+CZCnc2NlK7sXIWPMNa5ET8lIj8ROGd/2KdkMrqytwGdRbseApD4sdEE8VNst948US8srUnxL3SGUx4mUXQNiD8m3QwHfy81ok0sbBCYdwVuyaS5k212c5mM5cYMtkkaHWtBLFmB/vGOMHTiZHihjVc39as6BDXZNo74rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ak4bkaw2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C69D1F000E9;
	Tue, 14 Jul 2026 00:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783990587;
	bh=FTx6djY941twNw2l1n+fBHuoJOdeR+nolps2nTi/6mY=;
	h=Date:To:From:Subject;
	b=Ak4bkaw2s3Xulkf+KsnG/oGWTqVfzdj0IHcVWZds31UAiG5eBFkl1gUzzI/OBcofR
	 Hhc7y/sLggGXO5EWJ1q5nQikLmGx82P9VlXuCC8gj6uco4leVntGx6HUIOAFETpm7A
	 ExA0tYE6QIf5qWRusziwRImjHQZG1lA2AlIBPdPk=
Date: Mon, 13 Jul 2026 17:56:27 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ljs@kernel.org,jackmanb@google.com,david@kernel.org,injaeryou@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + selftests-mm-fix-on-fault-limit-false-failure-under-sudo-rs.patch added to mm-new branch
Message-Id: <20260714005627.8C69D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274044-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:ljs@kernel.org,m:jackmanb@google.com,m:david@kernel.org,m:injaeryou@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,google.com,gmail.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:email,linux-foundation.org:dkim,smtp.kernel.org:mid,run_vmtests.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14CE774FF14


The patch titled
     Subject: selftests/mm: fix on-fault-limit false failure under sudo-rs
has been added to the -mm mm-new branch.  Its filename is
     selftests-mm-fix-on-fault-limit-false-failure-under-sudo-rs.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-mm-fix-on-fault-limit-false-failure-under-sudo-rs.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

The mm-new branch of mm.git is not included in linux-next

If a few days of testing in mm-new is successful, the patch will me moved
into mm.git's mm-unstable branch, which is included in linux-next

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Injae Ryou <injaeryou@gmail.com>
Subject: selftests/mm: fix on-fault-limit false failure under sudo-rs
Date: Mon, 13 Jul 2026 18:27:00 +0900

run_vmtests.sh runs on-fault-limit as the nobody user via "sudo -u nobody
./on-fault-limit", guarded by a check that nobody can access the binary
("sudo -u nobody ls ./on-fault-limit").

The guard resolves the relative path from the inherited working directory,
which only requires search permission on the test directory itself. 
Classic sudo passes the relative path through to execve() the same way, so
the two agree.  However, sudo-rs (the default sudo implementation since
Ubuntu 25.10) canonicalizes the command to an absolute path before
executing it, which requires search permission on every ancestor
directory.  When the kernel tree lives under a private home directory
(mode 0750, the Ubuntu default for new users since 21.04), the guard
passes but the execution fails with "command not found", and the test is
reported as a false FAIL:

  # running sudo -u nobody ./on-fault-limit
  sudo: './on-fault-limit': command not found
  # [FAIL]

Wrap the command in "sh -c" so that sudo only resolves the shell binary,
and the relative path is resolved by nobody's shell from the inherited
working directory, matching what the guard checks.  This is the only "sudo
-u nobody" invocation in the script; uid, cwd, rlimits (including
RLIMIT_MEMLOCK, which this test exercises) and the exit status are
unchanged through sh.

Verified on Ubuntu 26.04 (sudo-rs 0.2.13): the test now runs and passes
instead of failing.  Verified on Ubuntu 24.04 (sudo 1.9.15p5): behavior is
unchanged.

Link: https://lore.kernel.org/20260713092700.464376-1-injaeryou@gmail.com
Fixes: 5d2146a3354f ("selftests/mm: skip mlock tests if nobody user can't read it")
Signed-off-by: Injae Ryou <injaeryou@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/run_vmtests.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/run_vmtests.sh~selftests-mm-fix-on-fault-limit-false-failure-under-sudo-rs
+++ a/tools/testing/selftests/mm/run_vmtests.sh
@@ -303,7 +303,7 @@ CATEGORY="compaction" run_test ./compact
 
 if command -v sudo &> /dev/null && sudo -u nobody ls ./on-fault-limit >/dev/null;
 then
-	CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
+	CATEGORY="mlock" run_test sudo -u nobody sh -c ./on-fault-limit
 else
 	echo "# SKIP ./on-fault-limit"
 fi
_

Patches currently in -mm which might be from injaeryou@gmail.com are

selftests-mm-fix-on-fault-limit-false-failure-under-sudo-rs.patch



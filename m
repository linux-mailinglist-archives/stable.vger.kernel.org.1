Return-Path: <stable+bounces-262966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 76f1HA5aLGojPwQAu9opvQ
	(envelope-from <stable+bounces-262966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 21:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8667BEED
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 21:12:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=tke3v0+a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262966-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262966-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F6031553B6
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26683A7D82;
	Fri, 12 Jun 2026 19:10:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521933C1AD;
	Fri, 12 Jun 2026 19:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291432; cv=none; b=VHarNAIF5EuDDI6cD4fhyB7X70ifPPGhVM6uxvzxndI/80jNHSizdHWNk0fc6C8WGBUigmcwZrOFvW9dneCOY50IKnga3GSur8dqEeeefryJqCta26fXO9uU74jjeJ2pTnhm0UDsAX+yfoRsnEOjCuH9ssZcypi5hTQIVHpLhdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291432; c=relaxed/simple;
	bh=Ind7OMFAL3B7N2bgDg5escGqPCGjAbL1eUprnuhrvd8=;
	h=Date:To:From:Subject:Message-Id; b=oY7fbJIXmlbh7WWlbt6OQqHhv0IO8XVL0i+9hxQ6RFL464NyOXB2qUdRrR8nKjVEEHjLubpeVfFVaG1qd340PCLepA1rdZxTkPh3iBHGyQxpjjwNdaQ58lnBojwyVJG7vXWu5uqh0d7PfayB+Ms928qsGOD5HxjKkV2L/oFnqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tke3v0+a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337831F000E9;
	Fri, 12 Jun 2026 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781291431;
	bh=XXmmT7lZZeyxX4+epgjzp56hFjVQgxBr29JCGmGjhGo=;
	h=Date:To:From:Subject;
	b=tke3v0+apKPXCUt5RuVCSfCZsiQpOdh9V1g80t3Ge1tMhjPmu+mUHZVftzE/Pb/Yo
	 IvhpgKu+8w3duJAQLtYGJkw2zApIEzk7lP0i1obEu0zLsbDxHexwvz3zzpTK3ReWHC
	 3QnRMm3eZWWBT+KSrzSDXnUbRjfecssZZsBE0Zv4=
Date: Fri, 12 Jun 2026 12:10:30 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,kylebot@openai.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-avoid-moving-extents-to-occupied-clusters.patch added to mm-nonmm-unstable branch
Message-Id: <20260612191031.337831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262966-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:piaojun@huawei.com,m:mark@fasheh.com,m:junxiao.bi@oracle.com,m:joseph.qi@linux.alibaba.com,m:jlbec@evilplan.org,m:heming.zhao@suse.com,m:gechangwei@live.cn,m:kylebot@openai.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,openai.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,oracle.com:email,alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,huawei.com:email,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,smtp.kernel.org:mid,evilplan.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0E8667BEED


The patch titled
     Subject: ocfs2: avoid moving extents to occupied clusters
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     ocfs2-avoid-moving-extents-to-occupied-clusters.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-avoid-moving-extents-to-occupied-clusters.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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
From: Kyle Zeng <kylebot@openai.com>
Subject: ocfs2: avoid moving extents to occupied clusters
Date: Thu, 11 Jun 2026 14:35:10 -0700

For non-auto OCFS2_IOC_MOVE_EXT operations, userspace supplies a physical
me_goal.  ocfs2_move_extent() initializes new_phys_cpos from that goal and
expects ocfs2_probe_alloc_group() to replace it with a free run in the
target block group.

The probe currently leaves *phys_cpos unchanged if the scan reaches the
end of the group without finding a free run.  An occupied goal at the last
bit can therefore survive the probe and be passed to
__ocfs2_move_extent(), which copies file data into a cluster still owned
by another inode before the bitmap is updated.

When the probe does find a free run, it also subtracts move_len from the
ending bit.  The start of an N-bit run ending at i is i - N + 1, so the
current calculation can report the bit immediately before the free run.

Clear *phys_cpos before scanning and use the correct free-run start. 
Callers already treat a zero result as -ENOSPC, so failed probes no longer
continue with an occupied caller-controlled goal.

Link: https://lore.kernel.org/20260611213510.16956-1-kylebot@openai.com
Fixes: e6b5859cccfa ("Ocfs2/move_extents: helper to probe a proper region to move in an alloc group.")
Fixes: 236b9254f8d1 ("ocfs2: fix non-auto defrag path not working issue")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/move_extents.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ocfs2/move_extents.c~ocfs2-avoid-moving-extents-to-occupied-clusters
+++ a/fs/ocfs2/move_extents.c
@@ -534,6 +534,8 @@ static void ocfs2_probe_alloc_group(stru
 	u32 base_cpos = ocfs2_blocks_to_clusters(inode->i_sb,
 						 le64_to_cpu(gd->bg_blkno));
 
+	*phys_cpos = 0;
+
 	for (i = base_bit; i < le16_to_cpu(gd->bg_bits); i++) {
 
 		used = ocfs2_test_bit(i, (unsigned long *)gd->bg_bitmap);
@@ -555,7 +557,7 @@ static void ocfs2_probe_alloc_group(stru
 			last_free_bits++;
 
 		if (last_free_bits == move_len) {
-			i -= move_len;
+			i = i - move_len + 1;
 			*goal_bit = i;
 			*phys_cpos = base_cpos + i;
 			break;
_

Patches currently in -mm which might be from kylebot@openai.com are

ocfs2-avoid-moving-extents-to-occupied-clusters.patch



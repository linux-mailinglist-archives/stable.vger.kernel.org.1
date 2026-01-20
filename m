Return-Path: <stable+bounces-210535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNg0EalMcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:48:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EAB50940
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D38ACA68
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE4428827;
	Tue, 20 Jan 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYqmyrLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424943F077A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914561; cv=none; b=XkM/NlMJQhFl6wDWSl4IcJltLvPmwsxRwGuDDuZjtHe5USYJ7+NyW1loeHY4tpdEAj4Xa2PYaIMJJXkWS27Q8X1xUU0Mw3NY03EccorThQ/PQPBwcxsxGRov5TfFZwk4o0QdmxQlFpk39sZQoJLLjxbw8v8ZAe5zf8UUJ2Bq/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914561; c=relaxed/simple;
	bh=XZrQ3kTlnRqmjK/UR2jMY5+lOKR3f/GeqEU14nFiwRI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dQERtnNicye/HWyhBmAoOlNtzsyvhmiygZwbpExKrPcjcKbAWxvIA48/bnVvQf4s9FaJmy20HJ0/kpJpFiIYWr4ImrQ4gD66//LjVgHGNNVL0Uj5kSoQeJ+/V00PhnHiYWA3bG90734AVNMw/+d9M/z/wMtnNCedr2JqZ+Trru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYqmyrLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F4BC16AAE;
	Tue, 20 Jan 2026 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914561;
	bh=XZrQ3kTlnRqmjK/UR2jMY5+lOKR3f/GeqEU14nFiwRI=;
	h=Subject:To:Cc:From:Date:From;
	b=xYqmyrLLwH3OW+cl+I7WWzZqAgXGppwbNBY8W/OS8KxPb8cW3qDllhYYhy4WoKkTN
	 1sMzi1qkWU/1FhLuG2QV5YAPQ8OczoUgbC8rJrd9zMf5sff6xwTbmP8MLZV72NWorQ
	 CC2n7egZpTrTrwuMZrCzhur2tWdnQyJeiRUQeA4Q=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,jiapeng.chong@linux.alibaba.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:09:15 +0100
Message-ID: <2026012015-plank-morphing-040c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210535-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alibaba.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B4EAB50940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 392b3d9d595f34877dd745b470c711e8ebcd225c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012015-plank-morphing-040c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 392b3d9d595f34877dd745b470c711e8ebcd225c Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 24 Dec 2025 18:30:37 -0800
Subject: [PATCH] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on
 scheme dir setup failure

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
access_pattern/ directory, subdirectories of access_pattern/ directory are
not cleaned up.  As a result, DAMON sysfs interface is nearly broken until
the system reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-5-sj@kernel.org
Fixes: 9bbb820a5bd5 ("mm/damon/sysfs: support DAMOS quotas")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2c7a2b54be57..3a699dcd5a7f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2152,7 +2152,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		return err;
 	err = damos_sysfs_set_dests(scheme);
 	if (err)
-		goto put_access_pattern_out;
+		goto rmdir_put_access_pattern_out;
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
 		goto put_dests_out;
@@ -2190,7 +2190,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_dests_out:
 	kobject_put(&scheme->dests->kobj);
 	scheme->dests = NULL;
-put_access_pattern_out:
+rmdir_put_access_pattern_out:
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
 	return err;



Return-Path: <stable+bounces-210531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNWGLMBfcGkVXwAAu9opvQ
	(envelope-from <stable+bounces-210531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:10:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA19515B9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FEBA6C604D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5438421A17;
	Tue, 20 Jan 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aCkIRAiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F613B531E
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914545; cv=none; b=UV0oK+o0laTrXeyXxH4xFoe+5KV9mnrNMPC6SXbH2vf37jPj+sV0MLh+yQKE/v/D+RqQ9HzHP8vjS+drvjaNyweKzbf17W+fRaqLBM823mEio2/wl9kT1SMxAG+i/J02qoXOjYpviKsa27iCNUPTsS8ZyqMw/q5TwYKWz0ApuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914545; c=relaxed/simple;
	bh=LV+wuka3cJbG9wzkfnvvTig8NVwUotkiYp1uzgc8v5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b5imslo3nTZaSr3fwrSH/D7W++yXY/y02Y4rxfeiWWbMjVBM4996Za+cRABzivlgNhLcsKyGlzy1DLTVLGk0ZxmAYHGRbsJIEfQf3v4Sj5dVXE/aMls0flZM4QhQorkAveLAbs0ot3nkQYZzhmHWKaqTgI7TpBh1cW9IQaKemB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aCkIRAiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BB6C16AAE;
	Tue, 20 Jan 2026 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914544;
	bh=LV+wuka3cJbG9wzkfnvvTig8NVwUotkiYp1uzgc8v5w=;
	h=Subject:To:Cc:From:Date:From;
	b=aCkIRAiqGtKgb6JZmqxSz2Pnngj4X8+r014dv+hJKdjdkExdqoII1AKhBtW3F22ep
	 3CdYZ+EySA9M0CsO4vKMXB6ItFMlKItLLfwO7QgSxLJWFmWK7T9mlfJxvoiFqpZ9Fy
	 JSsrHLPuVDvPT4IErQ2TlImy2QYJHP5LYQCokyKU=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir" failed to apply to 6.12-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,jiapeng.chong@linux.alibaba.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:09:01 +0100
Message-ID: <2026012001-endurance-retrieval-1f57@gregkh>
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
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210531-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 5AA19515B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dc7e1d75fd8c505096d0cddeca9e2efb2b55aaf9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012001-endurance-retrieval-1f57@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dc7e1d75fd8c505096d0cddeca9e2efb2b55aaf9 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 24 Dec 2025 18:30:36 -0800
Subject: [PATCH] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir
 setup failure

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
quotas/ directory, subdirectories of quotas/ directory are not cleaned up.
As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Link: https://lkml.kernel.org/r/20251225023043.18579-4-sj@kernel.org
Fixes: 1b32234ab087 ("mm/damon/sysfs: support DAMOS watermarks")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 30d20f5b3192..2c7a2b54be57 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2158,7 +2158,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_dests_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damos_sysfs_set_filter_dirs(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -2183,7 +2183,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
+rmdir_put_quotas_access_pattern_out:
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
 put_dests_out:



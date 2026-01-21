Return-Path: <stable+bounces-210633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPsbBUwrcGniWwAAu9opvQ
	(envelope-from <stable+bounces-210633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:26:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E64F12F
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B2747874
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A721CC55;
	Wed, 21 Jan 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmlxBwta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002042A96;
	Wed, 21 Jan 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958759; cv=none; b=KrRMijRJtLykQWFxLDI2lcqHr6Lqp6iqWUI6ISX3DXBLZMuVhKmNPwlAVVApmLWiW5BpDDqH46BZ2scLxV44GVHe0cr+GJMj0BgRze88YfZcJ9KPpN5r0TfPsA7rYBJBfVqMftKXUimtM8uZF3lAzAgrsuNtauZ4E9+phM2ak6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958759; c=relaxed/simple;
	bh=oxHPTh/zDNyXXpPXyNaGy5UyL4F+G/F+9SZr67xEFKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHTXeM1i5rirGlRmkEHEhxaPf73sIw2vykZsmACJNC8mRpS1Tbv9FYabdVAwbFTY/+rwOh7k2uT0Lss5UP4ItMRwzvQDc0eLmGqpT0QuLVc2+9wm0T6CVofYfkx4i/SQKCoetqqLeO+IKZ1y/V57JLrc/bm/jlLOPMdTKzGR0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmlxBwta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB05C16AAE;
	Wed, 21 Jan 2026 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958758;
	bh=oxHPTh/zDNyXXpPXyNaGy5UyL4F+G/F+9SZr67xEFKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PmlxBwtadyCuT+gLNWEwqHNChRLZCQOe4U95xpN3d2xSfgf9sA4y+LKfsgEFGU+Qt
	 uqMgSyBXlVUScocUmAW7UDp4YMsMH77w0ZUtSbDEHfJUduaEAo/xrbztYOEpD49nHy
	 +EiLdGTnlnCTmHsTNGTjwfpKjyn+YuwJMB0LsedL3gvf5sSfOg/0QnhSqhPy7ulz2L
	 JAWpQR3uMoMAkT7NxDpcsw7Z9NqGopFjoRONStvOFzCP6iHQvEKalZdA+fp5GZWfY7
	 56+FFTHWoOtkrjbli4ylv6liUxSkNELPzI5Ta0gGgcs6qR/YFwtTYT+WbHMHzrqfFi
	 UvyXlhsCSMnLw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:25:49 -0800
Message-ID: <20260121012549.251984-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012015-plank-morphing-040c@gregkh>
References: <2026012015-plank-morphing-040c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210633-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,alibaba.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: A74E64F12F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
(cherry picked from commit 392b3d9d595f34877dd745b470c711e8ebcd225c)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 18f459a3c9fff..1b85a0beeaaa4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -856,7 +856,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		return err;
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
-		goto put_access_pattern_out;
+		goto rmdir_put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
@@ -871,7 +871,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
-put_access_pattern_out:
+rmdir_put_access_pattern_out:
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
 	return err;
-- 
2.47.3



Return-Path: <stable+bounces-210626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AiGEvoocGmyWwAAu9opvQ
	(envelope-from <stable+bounces-210626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:16:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C124EF24
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECF6D4AF94C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE9303CAF;
	Wed, 21 Jan 2026 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6oZkCC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAB302750
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768958175; cv=none; b=hxtyf5Z5He+0X/MtjA7zdYI2/AZS6GyJZ8pSeGQHpU97RzvgRk2GBuqFrPL7D/OIueM8oy/pKWy3VG1D5I3b51RElUs5/SOeiN/auHFq7zZ7NIydsmbgJU7eFAnAuc33eBOsct1P2wg7rJ3otbOrKFcROOMk//WjUy4H8nV16/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768958175; c=relaxed/simple;
	bh=9v9Cet/tLsIbGyg5HU0NBA44amp0wB6CYglulzZc3RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFMQmSTmPSzPSY8hhg+yLmGL10nFzzs0NjdHM9orudUInnw9+XLCzSBJdu6pqV1UhcO79ou3d4DjI9KnIKSlHaNExvPkhWJQR+G05clXVsWfnFWcLJZs1xxn/NO95svn2PQWkxMkV7kmk+DVc40qKocfnizxWYHV/OA+tsWbs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6oZkCC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05094C16AAE;
	Wed, 21 Jan 2026 01:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768958175;
	bh=9v9Cet/tLsIbGyg5HU0NBA44amp0wB6CYglulzZc3RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F6oZkCC/OZBC9X1oc/y+KJC9EpvyWhkARk54K8dSBuB+1/6A5Tr0GNUWwW1nSMcAN
	 cq+HGNjFRzc7ojV+cK5AG6UJls+fkt1JW55FPgXtIb5nbBikXI9w8KXjr7deM2fgAc
	 JFocfqxab9ns7b6oLoQBWpe6Ru5XLdtjAv1qV6jPGAqEoM2oswqK0WXtmTdZkJxBCK
	 0rr9j/qh8p5z3eCdkMwYMu7IVO5XGnGejqulZQQYASibWad6Z2tjqAkjYSuRS7GP2h
	 E2th7oUBE7yVI4fdtB5tczPA0WEXTrlIRPvSlAv3perVwqkAXkORbr3eq5I8mS9RRJ
	 O6k1YAqmsq8GQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux-dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
Date: Tue, 20 Jan 2026 17:16:08 -0800
Message-ID: <20260121011608.167602-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026012015-democracy-snowdrop-9f8c@gregkh>
References: <2026012015-democracy-snowdrop-9f8c@gregkh>
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
	TAGGED_FROM(0.00)[bounces-210626-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,alibaba.com:email,linux-foundation.org:email]
X-Rspamd-Queue-Id: D6C124EF24
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
 mm/damon/sysfs-schemes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 19d661889cf79..2d081df6b2c16 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1282,9 +1282,10 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 	err = damon_sysfs_scheme_set_access_pattern(scheme);
 	if (err)
 		return err;
+
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
-		goto put_access_pattern_out;
+		goto rmdir_put_access_pattern_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
 		goto put_quotas_access_pattern_out;
@@ -1311,7 +1312,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
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



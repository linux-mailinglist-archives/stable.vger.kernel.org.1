Return-Path: <stable+bounces-266803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t80mBbS0Mmq83wUAu9opvQ
	(envelope-from <stable+bounces-266803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:52:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A669AADB
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:52:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ei7jrHtx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266803-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266803-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE81831CE7BB
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E743D8105;
	Wed, 17 Jun 2026 14:48:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2692F0661;
	Wed, 17 Jun 2026 14:48:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707716; cv=none; b=u4lrPZrVGcRbXAhI9O/xjG7+0xnOxVS+N0jfBE3gFwlvsaoDXjytnz2sicL3lzocMJxDMafw2QGFPNYhhWseDM2/qvKCoZpn3klW1HNcI9tmVKfhYgWlxofsvjQ3PiSlKuM/0O7QCNhghtgwyLQPWRhGbrqMbxstAT25+Kemug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707716; c=relaxed/simple;
	bh=duPOuJ8FNsuebqjEG9yiYUIcdf3k01iIxKFw2e2cV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7wmyXm7g0XPHKW3OqYezs9J7I4EPFIENYQYrL1cP+Vs4qOmx8x5HVh8FYPuaGEYiWjX5WTf8cgPFAhLBPdo7bATiJepAEzVtEa4cUNhfOHL7VqDIfaS3hB6ltPVLgX3gI6h+az8Ds/99mXAQNvQVPxdtOUR/WElqdOZjexER7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei7jrHtx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FA1F00A3A;
	Wed, 17 Jun 2026 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707714;
	bh=oMPoBzlor4YU5RTzivO7rISJyt7/7CUYk2cjtpLbxXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ei7jrHtx2dlhidm0rTM4a1j+BoexWcUkxDPwPYX+0eqTMV3QQN3ANxShN00kB3BNN
	 Kupt4KlTe9Q5f2rQfV/1QCt6OhODTnXcqNmbwTWQwAKlXiS93AskpVj7Vh9lLRFcbK
	 VrSxcOUHZtT+BwSki/KRjUoQ7285uGp/sBKc1LrlpHsebn/5HndEjdVvODHT2wFTNk
	 Mv4bqYk/0VM+wlJGCuNKpmM6PZEe55mjKeeBZmasb82+xyS8p4b1KlT5ykEkju3+Is
	 DW8vZGtWAuOeksxaWN7Q4CQJl1KXgPNOgd0RT0hSTt9Ig4qNdSbg1oLRDDVMDRX5NJ
	 qf+Yire5fXKeQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/11] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Wed, 17 Jun 2026 07:47:57 -0700
Message-ID: <20260617144807.91441-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266803-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B7A669AADB

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0134111c3c1ff..debf2a3a0d8fc 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2683,6 +2683,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
-- 
2.47.3


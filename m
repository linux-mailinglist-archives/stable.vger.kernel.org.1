Return-Path: <stable+bounces-267163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sz/MMsoMNGooMQYAu9opvQ
	(envelope-from <stable+bounces-267163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 17:20:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B1A6A1307
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 17:20:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HK9ZrErr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267163-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267163-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCEBF31105FE
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977253F58D9;
	Thu, 18 Jun 2026 15:15:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB83FC5A8;
	Thu, 18 Jun 2026 15:15:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795736; cv=none; b=ZGvz+3j5fjLcqGZ6lK2FHWo7RSHINT7Z0x9U0XC1H4u/Se68Dcn8VHbcqb8N0SqfDrHeXE29cmm8gqI4FT+QOqgmKvdHHZSMETVioH75Exwvvr72Jb1Wn4Y88uy7S58bHePzfj59DN5pR+ko3fg3eTOw+XEsnHJ4eVUu4yiu1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795736; c=relaxed/simple;
	bh=a7LFJkRoCnBEG+IV6eG6YWf+u+LzueVya0LdGjnZf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+npSv0Zl5Uvhqr6+FyoWP3yLwwfiSwlEYwBnVlVbqfGZ4L4OoyLFyqj6vEb8KYCsuSc8A/seAAsfGmsfErEgndvKdvzI3zu3DSTr9tCu8KZd/tcna9+qnHa2oMw1iNQ4APYbKrJnvU5amXxMk9S+5NgZg6kEheZBptVNRMQJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK9ZrErr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B11F00A3D;
	Thu, 18 Jun 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795732;
	bh=AYOzMyZwHARxR0NZjcHLGHg4Al6n3ZFtJVQObKKPsUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HK9ZrErrT/G95PukbMmY9I40KAE9YhFy3SmSqjosNPeVV2aV0AkD03Jgs7TOMMfZq
	 n/tbanT6cTPQsFXcukot33O/Oj4S8PCSNWnsO3Q4DiqKUjySk6MMkWkD4IPxuOqnpD
	 i1zAMudAtaqZvqEywGXUnC7lC3dr3rzv2PaoC2U17ulAqHJzGkAXEVzb3D3UKLgcJP
	 FAOf4f30h4xKXQfLH5Xnud+AjFDIk87Gc/7CZZWMpcQmAgQWLMGxsJKXpiUgzZbYMn
	 k9uUcaymjMkUWdt9cbqeKAhJeQQcfEBi9cdDNZG5Vdvt9/34wKztKESNfzq+B1verL
	 UUZ8B8/n3awbQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 03/11] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Date: Thu, 18 Jun 2026 08:15:07 -0700
Message-ID: <20260618151517.5366-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-267163-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 39B1A6A1307

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

Fixes: 7e84b1f8212a ("mm/damon/sysfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 0134111c3c1ff..13f5fae01800b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2683,6 +2683,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs_schemes *schemes)
 
 	for (i = 0; i < schemes->nr; i++) {
 		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
+		kobject_del(&schemes_arr[i]->kobj);
 		kobject_put(&schemes_arr[i]->kobj);
 	}
 	schemes->nr = 0;
@@ -2724,13 +2725,15 @@ static int damon_sysfs_schemes_add_dirs(struct damon_sysfs_schemes *schemes,
 			goto out;
 		err = damon_sysfs_scheme_add_dirs(scheme);
 		if (err)
-			goto out;
+			goto del_out;
 
 		schemes_arr[i] = scheme;
 		schemes->nr++;
 	}
 	return 0;
 
+del_out:
+	kobject_del(&scheme->kobj);
 out:
 	damon_sysfs_schemes_rm_dirs(schemes);
 	kobject_put(&scheme->kobj);
-- 
2.47.3


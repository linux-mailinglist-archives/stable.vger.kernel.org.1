Return-Path: <stable+bounces-267162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UzhhKr4MNGoTMQYAu9opvQ
	(envelope-from <stable+bounces-267162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 17:20:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E26A12F6
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 17:20:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o3YCEZTr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267162-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267162-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1E4310D3F6
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135743FAE01;
	Thu, 18 Jun 2026 15:15:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC693FC5A9;
	Thu, 18 Jun 2026 15:15:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795734; cv=none; b=ulofHye1h6ELCIRQiaY84rEKsuoB27EFPayMM+l06E5joQVe42FPt6Y4aDuVjAkdI/aih7qgY9rIlyoNex/EmmPS75rH1rtncgPD2dJbL9x9QQqqbELC0u9eBn9LneSLg/MK1jmkelrzIaoEWCxGKTkUUDdGzscEFXxWbwqcq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795734; c=relaxed/simple;
	bh=ZEnagPMbJ+SZ9NxkHl15NRRU4mAP7XqbFmOd7PdujSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q69736yMYLRk2B5lqyBoPmiUyjhc8MThagTk7owdJ6bhCOqcPdazpv4UXylI0Z6sMtS485sP1S/4dkDr0z/dV/zDz9krbwGh6Pu0b54/lBJ9bF+7tfogWkGad87zvbvWPoZZ/qZzWU02rRPyy7vQYc/y+5tlF3GgIlYuP8gily0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3YCEZTr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684921F000E9;
	Thu, 18 Jun 2026 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795732;
	bh=Ot9STQ1g/9bWHz2PjKibHQ71PZQcqWhCbB69SWOFmKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o3YCEZTrO+wyO3PqS/j1/Gt2GLsXLY9FxL6xZbWT1uGZLwZjqayIGag//weJb512F
	 RJNNCcmISu+dza9sGmQCswEbLB+3tcbT4/ySZehAtBUwVpeCePuB60lVcXd+0LIjIv
	 I5PwxR5LoA1sjjb1NIT+u2ZnUV8DOSHS+UhkGhmgzivxt5XdRgy7yUt7koLZ2A1Zrp
	 m/huCaE4WBwCYlNePgvJJTBKVPTV36UzLUwDaHgVD6FBxCkQ0tMOg/sMlF/1fXfrQn
	 7lvWn778TGS8/RyF1rs4COUeOXrdWp7krVcbg6DYx57zNoLNr0sDcRerYOo4s01bB+
	 khYE9UPlNjLrw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 2 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 04/11] mm/damon/sysfs-schemes: kobject_del() scheme region dirs
Date: Thu, 18 Jun 2026 08:15:08 -0700
Message-ID: <20260618151517.5366-5-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-267162-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 031E26A12F6

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme region directories by adding kobject_del()
calls.

This issue was discovered [1] by Sashiko, though its analysis was
partially incorrect.

[1] https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org

Fixes: 9277d0367ba1 ("mm/damon/sysfs-schemes: implement scheme region directory")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 13f5fae01800b..36a35ad0983eb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
 		damos_sysfs_region_rm_dirs(r);
 		list_del(&r->list);
+		kobject_del(&r->kobj);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
-- 
2.47.3


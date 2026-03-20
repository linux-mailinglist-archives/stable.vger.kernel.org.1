Return-Path: <stable+bounces-227573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPntAXJ6vWmt9wIAu9opvQ
	(envelope-from <stable+bounces-227573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:48:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 789542DDFA1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EBB8313D5F2
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B43B2FC4;
	Fri, 20 Mar 2026 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="I+rSrwmd"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DD39A803;
	Fri, 20 Mar 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024579; cv=pass; b=rHxyK8uiHQXKV8Z4BjFvVMRZK8AO2R3pZWxIoahLwCFoja6z7aydf3VHY7yRe1ggkEd7skeheC2ttEmBMQkwcVq+jpAcqjZhuFs7v9+24jrfp8mC0w5zsOwXtXGlcwLUJotFTxeE4gJPnbjoNnxOHWKLg5lXILD1/yUzHbAgjdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024579; c=relaxed/simple;
	bh=rXBnjOpdM4Zz9KkgGNRIZmxPV6JW3HhGTuomv2aKen8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPbVMewKJ1TYY//Q2vY9l99pNX/S0XgYajd883uzBfNNhBE5fyj3OYn6PfnpYNytHh8geZzxEcsIJy3pmAvsGxcltIjwbnHw9J61hBFBLcC4fyHVpb/nkVUTEC7glI40Ba/P74WAICpNgoNB+A8kUHux6FH58FeBvjgqRe3bq0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=I+rSrwmd; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774024563; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ff8X3tljHjklyFzeIFOMCAdNbLmebNvpYED9ZqvO5oAD7NDG1a45ss15UN6rHaeUpEF87bR6hsw4wmrIsW2j4KmhzuOc7YqAQmp49YiORUQdPIhzYlGKnYBxHdBY6IvtkY15H0jjAhxHRjbrnZfAMb0ojGsK1vvlG2ydZXgLss0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024563; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=; 
	b=Et+EfbnAdIfTOdfn2PjpJQeP4ypoP4uxvfKy9C1+AVGQSrKOzpFxuK7BPala0qvsStG2h0MF5C9Vz0ZZBbUMHrev2ZelqjEqefje9uXmFIr7pMwMhYnilH65aFwi3j1ZEFivFfdGiaZRrG4H54WJnbRnJm0P6hbq1y5HQZiyQUg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024563;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=;
	b=I+rSrwmdO5diJIt0LdFNl3Yk3dlXhjTt0x0zyF30VEYe6opl27xXPDSUJJ3tXuYj
	1CMYjf3lBkYeKUDR3YP7NTyVHGex8JG3e8me/ea7fJzJV7H4XsLbLeKHaO5n+mTseGj
	7/xRFtAU2A4eivvzCxi6s6B3sCWpX/vEWTlm4eh0=
Received: by mx.zoho.eu with SMTPS id 1774024562167191.42267947695075;
	Fri, 20 Mar 2026 17:36:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Fri, 20 Mar 2026 16:35:58 +0000
Message-Id: <20260320163559.178101-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320163559.178101-1-objecting@objecting.org>
References: <20260320163559.178101-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227573-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[objecting.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:dkim,objecting.org:email,objecting.org:mid]
X-Rspamd-Queue-Id: 789542DDFA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that nr_contexts >= 1.  A user can set nr_contexts to 0 via
sysfs while DAMON is running, causing NULL pointer dereferences.

Guard all commands (except OFF) at the entry point of
damon_sysfs_handle_cmd().

Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Cc: <stable@vger.kernel.org>	# 5.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b573b9d60784..ddc30586c0e6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1749,6 +1749,9 @@ static int damon_sysfs_update_schemes_tried_regions(
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
-- 
2.34.1



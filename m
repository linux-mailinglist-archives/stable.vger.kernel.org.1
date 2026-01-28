Return-Path: <stable+bounces-212203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCUcArc2eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DDDA563B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 364FA30E114D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E32E762C;
	Wed, 28 Jan 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvgIdcUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F712DE6FC;
	Wed, 28 Jan 2026 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614730; cv=none; b=K8y2t5GXKwkE1EVWkHgphpnuZ6xpIinoijkMmw6HqWIxVoSvPq0PksnImjEv4Hnz2fG55uXGtTzlKY5ko4EIdPTlc1Y1Oz4+7V7lVcI0nUG+XjBae4l2zpg7tlLxWoDHXVssgqvb6yJxzFPAH2oDTclkp617nQqntB/RfOrilfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614730; c=relaxed/simple;
	bh=15tPriOdj3X7gpPcubtNl7J2lLa1ObAmrqsN3hFv6VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZA+EmafB0132J6JiyepYl96eC+mKKbmJ2Bv351d4rAilv4xT3L1kKwWUEf0osr7HHWV8hblKWLcBzCIgFNutb1JHaHb4jEAklHRdGypN0jEyNu314zXvmWqrMmytIulbn9V1OIoSmus+W5n7jufBKUFCXmThtEvoEr43FUpw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvgIdcUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FFC2BC9E;
	Wed, 28 Jan 2026 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614730;
	bh=15tPriOdj3X7gpPcubtNl7J2lLa1ObAmrqsN3hFv6VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvgIdcUnkeIK7fEZZWyKlrbpKkFf9kCBcqp/inYfJbquYQhWSLMOtBmb4h6mo8bQC
	 Jn2QVfiheH7qsAvBMak/db83UhqMcbq6GafAHmFY7IrB/N6tq4LbbUrXotCYp2VT0N
	 /VTVaOaIyN0uI6jOQ23B63CBQU2QXQ4egmktu7mc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	chongjiapeng <jiapeng.chong@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 225/254] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
Date: Wed, 28 Jan 2026 16:23:21 +0100
Message-ID: <20260128145352.881694537@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212203-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52DDDA563B
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 392b3d9d595f34877dd745b470c711e8ebcd225c upstream.

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
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/sysfs-schemes.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1282,9 +1282,10 @@ static int damon_sysfs_scheme_add_dirs(s
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
@@ -1311,7 +1312,8 @@ put_watermarks_quotas_access_pattern_out
 put_quotas_access_pattern_out:
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
-put_access_pattern_out:
+rmdir_put_access_pattern_out:
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
 	return err;




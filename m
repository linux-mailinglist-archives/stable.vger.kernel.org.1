Return-Path: <stable+bounces-266807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nNmBECq0Mmpz3wUAu9opvQ
	(envelope-from <stable+bounces-266807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:50:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B33F69AAA9
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 16:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YTSK+CWW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266807-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266807-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A87E3132749
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2794369D42;
	Wed, 17 Jun 2026 14:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB825F984;
	Wed, 17 Jun 2026 14:48:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707726; cv=none; b=oqipYZsUTu2TLkH54+R/jikDy8ZhXq04n9scu7qEi/TNmjU49FBRUIHMR5SHJjQxebgG2nRl5WCMtu1lytC8JQpfoPGoqShFD74/eyfvKLPn4MHIhZmkMZD6fFU7utPryG4nYwoUSr9L2frEHy55tB0fE44nT/+pY0fe3BEymZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707726; c=relaxed/simple;
	bh=n+MpPsjDxaJNzCR36ZHui5GCopQ8H1IC/W8er6O8MP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv1jKsre9lKfEBuSpfsZNr5cabPj655YJ+v9Xj6krgJeU4jQBj50wCFnCDCWozrClcOqBZqxiJps7DPT4jIp9MFnTJQAwIIXgJrTVZbjtHevPhOfJAtnKRuy0xfmgV0Hj7ZOBscG5yDmLTLlvWy8T5yBF6E5IYJM7dFuOQ7cTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTSK+CWW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0B41F00A3D;
	Wed, 17 Jun 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707724;
	bh=CaF8UdvZVDDussggfwjRLGsPjlTiPuwSrEK65nFYR9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YTSK+CWWyy07fQAd79Drqssx8EIz0d1umquuzvD0ZbX8Scsa+HOIG0PyZWxPcJnOp
	 YIrJZFgZSdwLv3THjsKukFxPyF7a0dDVukj1UTz8zG3dAuqxBVmOimH2rH1JWydV06
	 VZJD69fV6T7CBSfscjR1ClWWhXsxi4q7IQa0DkOyb6syaZe02+TAWtA1M2FjKZHX2H
	 UeZUe6NjuIpfz6GOCv8jMkDi1iVDG8uQWtmi1RTcx/tDdXpUndGiAFCc+/UV7H+WQ2
	 dCEdxRubeJnecn7xCBAMuWJoALKti7qqPQkLz3mC5zY7cXfzqd+CeftszHLhCwimUL
	 ln7eIPlXC776Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/11] mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
Date: Wed, 17 Jun 2026 07:48:01 -0700
Message-ID: <20260617144807.91441-8-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266807-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B33F69AAA9

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme action destination directories by adding
kobject_del() calls.

Fixes: 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement DAMOS action destinations directory")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 573a40c679be3..0c0c9637b594e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2145,8 +2145,10 @@ static void damos_sysfs_dests_rm_dirs(
 	struct damos_sysfs_dest **dests_arr = dests->dests_arr;
 	int i;
 
-	for (i = 0; i < dests->nr; i++)
+	for (i = 0; i < dests->nr; i++) {
+		kobject_del(&dests_arr[i]->kobj);
 		kobject_put(&dests_arr[i]->kobj);
+	}
 	dests->nr = 0;
 	kfree(dests_arr);
 	dests->dests_arr = NULL;
-- 
2.47.3


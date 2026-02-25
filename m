Return-Path: <stable+bounces-218999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM4FGRJanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3528190A41
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2CA3215D5B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84995258EF9;
	Wed, 25 Feb 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uEB+7Nmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C520C012;
	Wed, 25 Feb 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983908; cv=none; b=RjiQ4HH3i2NR6cI/k9SMvxhB2krM7Ywb4F70gOjBlQ9z6QfOqKKhipHc4da662pISqF6FRqdxxjp5b13rwaYAutrfeqTWnHxi/y+kIB1XhP3kfv4YGMWpuqJR8CMsdZo+LJW3G7rNmJvnmUofH5pQRcs5S9fOkk5oIs5W7aHNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983908; c=relaxed/simple;
	bh=gDZYe6zWDHDtdJMTEoowy2y92/Ttb7SbVZIrYe5P5m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6VcHZc5HiawkmrmVJMzHbVtT9RB0rwGnkTtOcfGVTXCmJLs4g8kPa7YpOY1TA1wor9u/MI278JuY6FTvE524yBY02gUjTzr+tNKFsHkM5UFAuXbjsybnS/n21BK2Ge50sw/xMl6ZK+ctwJCBFthtXhy7PDTqS0Sg8FkmT0kQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uEB+7Nmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A824C116D0;
	Wed, 25 Feb 2026 01:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983908;
	bh=gDZYe6zWDHDtdJMTEoowy2y92/Ttb7SbVZIrYe5P5m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEB+7NmjJScc2Xw2yxO7bDFBhge9o/hbGEZmngilzqv54QCLCkxURqskeAIwRv+CG
	 pkUXXipS9094jh2G49TyHYBKH/KT7kF9wUgUiETr4OFtoGW8Bl8PODmzJQWpOOscCM
	 4WUTvgj5MZa8Ju2GGz34f7LF3WJ4R3ytCJ+7up70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 175/641] workqueue: Only assign rescuer work when really needed
Date: Tue, 24 Feb 2026 17:18:21 -0800
Message-ID: <20260225012353.275439761@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218999-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,antgroup.com:email]
X-Rspamd-Queue-Id: E3528190A41
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

[ Upstream commit 7b05c90b3302cf3d830dfa6f8961376bcaf43b94 ]

If the pwq does not need rescue (normal workers have been created or
become available), the rescuer can immediately move on to other stalled
pwqs.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: e5a30c303b07 ("workqueue: Process rescuer work items one-by-one using a cursor")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2fa3187101725..f678200ce8692 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3448,6 +3448,10 @@ static bool assign_rescuer_work(struct pool_workqueue *pwq, struct worker *rescu
 	struct worker_pool *pool = pwq->pool;
 	struct work_struct *work, *n;
 
+	/* need rescue? */
+	if (!pwq->nr_active || !need_to_create_worker(pool))
+		return false;
+
 	/*
 	 * Slurp in all works issued via this workqueue and
 	 * process'em.
-- 
2.51.0





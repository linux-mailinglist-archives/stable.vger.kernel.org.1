Return-Path: <stable+bounces-212276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G0sFDCMxemlT4gEAu9opvQ
	(envelope-from <stable+bounces-212276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC4A4AD3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 631C3312CAEF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F330C619;
	Wed, 28 Jan 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwBVXNCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B42FB093;
	Wed, 28 Jan 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614975; cv=none; b=m68pBaG6fvNzR1oTKuaO7goD6Q6S8ehECPZpnlGAA+OnDtELUQGyIC2E36jpVBMqwld65E1M3Sm3lYChV9+/pnl6GI8JFpp3YzPoCCiT5l/cz9Y6StaSficqazyqIp3cH8GawW87h6tYTK7+DcrkrrG8OqOoDQth/70eH5H32Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614975; c=relaxed/simple;
	bh=FHGn+1UFq5pk30UPkk4P6skYVM5H3cc7t8P1WA6HRzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OemKjOFpmipzm0CCzRF2LouwUmXuWGgrrpPNrZgA8DyapF+TcgcaXVtKML2TKJxgzWfEkxnHsRqha6hu6HZpOisHLSmYjvqysIzCdxvZQa4CfYdKJRKi1coH3U3AFviIV3+6MB/5P/8ZC8yswJlBciMd59jT7g89Th6dtEqOi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwBVXNCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1487FC2BCAF;
	Wed, 28 Jan 2026 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614975;
	bh=FHGn+1UFq5pk30UPkk4P6skYVM5H3cc7t8P1WA6HRzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwBVXNCas5GNweYs++zZHEWACNKDF3Er7qd7Bl9Y/30QeHhPZvnh3NkrxAiPk/4e/
	 q/30TXhlgVP60i4RK5a+YWzxY6Dgf61cWZTTU3Fb2vxqSNvKFYztSq2EW8oSci7Gzk
	 8lScpxGOCxzBKI8jbRL6B5Xk7IIMQ+jYN0RQ11Yg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 040/169] net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag
Date: Wed, 28 Jan 2026 16:22:03 +0100
Message-ID: <20260128145335.463296850@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212276-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E5EC4A4AD3
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jamal Hadi Salim <jhs@mojatatu.com>

[ Upstream commit d837fbee92453fbb829f950c8e7cf76207d73f33 ]

This is more of a preventive patch to make the code more consistent and
to prevent possible exploits that employ child qlen manipulations on qfq.
use cl_is_active instead of relying on the child qdisc's qlen to determine
class activation.

Fixes: 462dbc9101acd ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260114160243.913069-3-jhs@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d8dabc1a620bd..c7c8e8dde31d1 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -373,7 +373,7 @@ static void qfq_rm_from_agg(struct qfq_sched *q, struct qfq_class *cl)
 /* Deschedule class and remove it from its parent aggregate. */
 static void qfq_deact_rm_from_agg(struct qfq_sched *q, struct qfq_class *cl)
 {
-	if (cl->qdisc->q.qlen > 0) /* class is active */
+	if (cl_is_active(cl)) /* class is active */
 		qfq_deactivate_class(q, cl);
 
 	qfq_rm_from_agg(q, cl);
-- 
2.51.0





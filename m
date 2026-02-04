Return-Path: <stable+bounces-213390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBm4BPdag2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:43:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FEE73FA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28E233004F3A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAACC410D10;
	Wed,  4 Feb 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUKj0sBn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED501EA84;
	Wed,  4 Feb 2026 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216179; cv=none; b=na8xNp3zd9BTRptSV/NwLDCXvHQzfprfvp+Mh8N4IrV8d/0qVjd2LbwMhgWvAIpKZ8vbf2STz/ueIdO4jvVekWy4xkQlvGR4nGtw29YUC5CqVy/97l+PIOV0g8nJ11SlXxLPeqJ30GlPDQPghvQpGdnSTX0uzsfgQs6oDmlDisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216179; c=relaxed/simple;
	bh=rhDF6y1K2DXFq7nyyTCSM8GXTMo6w8k9Lfsw8jE5MZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTwMOlWVqjVpLpXr/GYKPLGU8k0bmF3R9riIan8Y7txCVATag38PNUdo7mtgrcjFT/vRV8zEvy4+y8x/f8eZYYTEtiRxV6YAwK7qgaB0P46rMvuYXNq9uUKrUUijQpzOvdqXTCLmvtocJjJirV31d5zRBivmWTHFGKuVjEGydfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUKj0sBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E83C116C6;
	Wed,  4 Feb 2026 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216179;
	bh=rhDF6y1K2DXFq7nyyTCSM8GXTMo6w8k9Lfsw8jE5MZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUKj0sBnMEiP6CVvVoB9tfrpYBH+dTtfjfQSPj+MJFM4mNPAZ/Kikx8rPwWYgWZAY
	 2XVFJ2Gog9X/pqQ0vQkzAmLZujrRDWdgxFaBbNApzOxuIBhehxsKo0T6R24kGQ5OIh
	 Qwn3IG0qbYBEZEW6p+gy9aV5o/O0WUKkeELWJjEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 011/161] net/sched: sch_qfq: do not free existing class in qfq_change_class()
Date: Wed,  4 Feb 2026 15:37:54 +0100
Message-ID: <20260204143852.169872461@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-213390-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,07f3f38f723c335f106d];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: D34FEE73FA
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3879cffd9d07aa0377c4b8835c4f64b4fb24ac78 ]

Fixes qfq_change_class() error case.

cl->qdisc and cl should only be freed if a new class and qdisc
were allocated, or we risk various UAF.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6965351d.050a0220.eaf7.00c5.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260112175656.17605-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_qfq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 34a6c4ec9a157..9751de2d95e78 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -532,8 +532,10 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	return 0;
 
 destroy_class:
-	qdisc_put(cl->qdisc);
-	kfree(cl);
+	if (!existing) {
+		qdisc_put(cl->qdisc);
+		kfree(cl);
+	}
 	return err;
 }
 
-- 
2.51.0





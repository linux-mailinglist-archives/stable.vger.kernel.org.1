Return-Path: <stable+bounces-232281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E5XCvn+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B991936DDDF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EAB330AF396
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA3423A62;
	Tue, 31 Mar 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLQKHzTp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B5423A9B;
	Tue, 31 Mar 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976344; cv=none; b=pO2Ul2ZAgGbmpYC5BM5fsEQFAju41vFmvJYTbjyV05pmuluGtsclzcW1SUihVnqblHg7tnAir95uMzrlurxpZlj1KGEKmNU53yDuP3BpX1805NCTwklOAvfQSK880WYZAaPyfX/RiJcnDsaMTfBnYDgvcPTK7ubx51WmzSiksdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976344; c=relaxed/simple;
	bh=lVpEoRfoDuLpgTsD8uUhyNAjvfC2/mspilJtezqoWTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtGygVHhSzZ3qkk1IfC/uSBq1TApDgk+28HIb+Mle98eELa24C2axuqOLHd86UKsi70237xgLohd/SM1yxdKlyY7cKTEdTIQeaDagD6oqbbDqAwHbmWjwSUBaXMnh0IYFZEDsOPjr9nbHGNtlpca+C8crxxY2f/DTsBDQ1Ty5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLQKHzTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A22C19424;
	Tue, 31 Mar 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976344;
	bh=lVpEoRfoDuLpgTsD8uUhyNAjvfC2/mspilJtezqoWTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLQKHzTpmQ3+v3mzbLKGk+tASZAfPWCnq6YT7eeLWKs96Io2uVacG/zu8t+wOswdB
	 p7U8/6XSeR7Xa+lkzZTo+dq3hKMK92/AGo16aMeiLvW3EzwNh9DiCGI4+rjsb+VqsJ
	 5mSeyH+V2U+UQXBpl5kCt4wHvl0IWpvzGgInonEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	zhidao su <suzhidao@xiaomi.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 055/309] sched_ext: Use WRITE_ONCE() for the write side of dsq->seq update
Date: Tue, 31 Mar 2026 18:19:18 +0200
Message-ID: <20260331161755.512104407@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232281-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B991936DDDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhidao su <soolaugust@gmail.com>

[ Upstream commit 7a8464555d2e5f038758bb19e72ab4710b79e9cd ]

bpf_iter_scx_dsq_new() reads dsq->seq via READ_ONCE() without holding
any lock, making dsq->seq a lock-free concurrently accessed variable.
However, dispatch_enqueue(), the sole writer of dsq->seq, uses a plain
increment without the matching WRITE_ONCE() on the write side:

    dsq->seq++;
    ^^^^^^^^^^^
    plain write -- KCSAN data race

The KCSAN documentation requires that if one accessor uses READ_ONCE()
or WRITE_ONCE() on a variable to annotate lock-free access, all other
accesses must also use the appropriate accessor. A plain write leaves
the pair incomplete and will trigger KCSAN warnings.

Fix by using WRITE_ONCE() for the write side of the update:

    WRITE_ONCE(dsq->seq, dsq->seq + 1);

This is consistent with bpf_iter_scx_dsq_new() and makes the
concurrent access annotation complete and KCSAN-clean.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e3f06c19ab46..bf4bea3595cd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1019,7 +1019,7 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 	}
 
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
-	dsq->seq++;
+	WRITE_ONCE(dsq->seq, dsq->seq + 1);
 	p->scx.dsq_seq = dsq->seq;
 
 	dsq_mod_nr(dsq, 1);
-- 
2.51.0





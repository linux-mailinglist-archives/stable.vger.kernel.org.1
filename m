Return-Path: <stable+bounces-250066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGOqLIoMDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:33:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3375986D5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F328E33E5C2A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E656370D43;
	Wed, 20 May 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z7wlurm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9F3F23B7;
	Wed, 20 May 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294454; cv=none; b=qzgfxOZkNYL2A/a5lFOG7u2scVIVx/seCi2LuSCwTDB3+S77q2AIH3t/6rRVFPM+fMgPVCcA3suNH8rug1G64Cr6HnY8VsgPBcuBSr+fjSqk3rE9AKaoTVcUiBU+ksz2MRm4jLzaLiKcEPy/AVp/mT61iv93izsBRZX/tRyhA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294454; c=relaxed/simple;
	bh=2v/xkidaA693bBz9YA2o09f+iXwiHrTr6oyZVSpdjIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFIQYYQMKM5yHySZtIJg30A5CdTQeDX+JONuh58J18cFyU9zIrcEL3ixmmSE0cJXS2V2WMnHYQUPw86Nr3eVr5nJ6C1eQa5ofrxxvoyHy2D2mGWkSO7un4aiBM5a7rSPgEU5AVlzKSDTFbMCgiRxno9PmMVvgXSFR8WC/2UBRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z7wlurm0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41E51F00893;
	Wed, 20 May 2026 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294453;
	bh=ccxC7TlZND9IdBit+A/w5SetkyF82XWB/To40/jo16k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z7wlurm0b61k/+laBKPmEW9LHg4SLE4GXKKjT/pCnCBmzMmW7riOkoYDs6SdGthxB
	 1narEtSSCsgrJ8ifdmwIZCqViYx3genBnt+uyTWTgrFJGqrsv7yT8yJ/uCnOhJrKuZ
	 +DqzBFRT72i3N5jRcDDirNN9n3Kro8oilbykL8zY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0046/1146] hrtimer: Avoid pointless reprogramming in __hrtimer_start_range_ns()
Date: Wed, 20 May 2026 18:04:56 +0200
Message-ID: <20260520162149.421270951@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250066-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 1D3375986D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit d19ff16c11db38f3ee179d72751fb9b340174330 ]

Much like hrtimer_reprogram(), skip programming if the cpu_base is running
the hrtimer interrupt.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260224163429.069535561@kernel.org
Stable-dep-of: f2e388a019e4 ("hrtimer: Reduce trace noise in hrtimer_start()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 1e37142fe52f4..1bbb0a9ff3a23 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1269,6 +1269,14 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
+
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (new_base->cpu_base->in_hrtirq)
+		return false;
+
 	if (!force_local) {
 		/*
 		 * If the current CPU base is online, then the timer is
-- 
2.53.0





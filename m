Return-Path: <stable+bounces-218235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FovOiRSnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D718F21B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06C98317B015
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211823EAA5;
	Wed, 25 Feb 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkpJyumj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABC1E2834;
	Wed, 25 Feb 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983031; cv=none; b=rYYwURWYYxTIZ5FUBWQ7XDxbJek3zEeSc6wpAhMAzN+uyuEVYbJJNa345mxMvYiR9YeRjlCPjiJw3bbiBAEf6ouuzm/qKosV66D2pamHiU78f58nD8SP3aP2/PELjaxXftTvvFikXydEAgV1w87rDjX5ked10rpHV4O5Qq/spao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983031; c=relaxed/simple;
	bh=kWopEeLVLtL86K/p/+tns0EdNnsqmqaXt1W0sPmAYNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hce2MnszuJC25B7DkL4Wr3RqkXiZADMBy/JL0U+WDllKxg435WqhO6ZbK/J3v0Hqe8TBFpa2p0MYHP9R76yzz8lsYVpI6He9aQQ0WGJTo66/FdHcvRIhqh7kO4Ww6asNwHylH7oWLthGSo02wC4r+FyYtFiu2Ek0yLaBw80tYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkpJyumj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523F2C116D0;
	Wed, 25 Feb 2026 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983031;
	bh=kWopEeLVLtL86K/p/+tns0EdNnsqmqaXt1W0sPmAYNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkpJyumjcdQg5ocxbzqAE/2A80huJoKNg4LM3AlC429c/fNAZVJyOh/Z90+B785qp
	 EpK2S6Ed1SUPuw6Tc+dd8Cm8TfO/PfAPJORtvT2N2atndQjURniNHK7dXKGPanRGo0
	 Onpqc08/aphHJMIC5v1Z99b1XdjEMGDTV55/21nU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 196/781] drm/panthor: Fix immediate ticking on a disabled tick
Date: Tue, 24 Feb 2026 17:15:05 -0800
Message-ID: <20260225012404.465154311@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arm.com,gmail.com,collabora.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-218235-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tick_work.work:url]
X-Rspamd-Queue-Id: 712D718F21B
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit 4356d21994f4ff5c87305b874939b359f16f6677 ]

We have a few paths where we schedule the tick work immediately without
changing the resched_target. If the tick was stopped, this would lead
to a remaining_jiffies that's always > 0, and it wouldn't force a full
tick in that case. Add extra checks to cover that case properly.

v2:
- Fix typo
- Simplify the code as suggested by Steve

v3:
- Collect R-b

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Link: https://patch.msgid.link/20251128094839.3856402-6-boris.brezillon@collabora.com
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 3f502cc7cfd1f..20d21e35d05ab 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2470,6 +2470,7 @@ static void tick_work(struct work_struct *work)
 						      tick_work.work);
 	struct panthor_device *ptdev = sched->ptdev;
 	struct panthor_sched_tick_ctx ctx;
+	u64 resched_target = sched->resched_target;
 	u64 remaining_jiffies = 0, resched_delay;
 	u64 now = get_jiffies_64();
 	int prio, ret, cookie;
@@ -2482,8 +2483,12 @@ static void tick_work(struct work_struct *work)
 	if (drm_WARN_ON(&ptdev->base, ret))
 		goto out_dev_exit;
 
-	if (time_before64(now, sched->resched_target))
-		remaining_jiffies = sched->resched_target - now;
+	/* If the tick is stopped, calculate when the next tick would be */
+	if (resched_target == U64_MAX)
+		resched_target = sched->last_tick + sched->tick_period;
+
+	if (time_before64(now, resched_target))
+		remaining_jiffies = resched_target - now;
 
 	full_tick = remaining_jiffies == 0;
 
-- 
2.51.0





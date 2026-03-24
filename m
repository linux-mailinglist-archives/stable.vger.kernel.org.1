Return-Path: <stable+bounces-230065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFk4M+w9wmmCagQAu9opvQ
	(envelope-from <stable+bounces-230065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:31:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664C3303FFD
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47F130FA02F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02523CCFBA;
	Tue, 24 Mar 2026 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbHsqHgD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28A3A452D
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336587; cv=none; b=Y2SfBi3qHeZwCdzbneyyQyi+Eb3ACq3+prDHW6B9hWXPODWEjw1ouETfmMgo5R42UT8Kwa/7Sf4UoSOgQiEcrL9vvl6AiCWKdpqffSOeyOC6hq7gM8GYtzSSZOeWptBnHMQ5zoJMkVd+evNGuivffThGaCK1uFG1o5b6pD5Oz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336587; c=relaxed/simple;
	bh=8SWfp5EFfj44304kxwLpa375WRpi8z2h893tyv7u24A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iywEhaG6vkblzbYmMQr3IQkc19WiuTFlO2yG9VerFJnuV4mb8Af7bATYgCrOtTLeKr9voOfdxyuwNosZFyPTYFY9dMjM5ptVDVTGL+CF/NzWdTmKl4xy5qcnZd89CQOAjRS6CpPB7U6yKeIJ3lwEasq14RUfBYIFcqdr/Rx20z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linyaa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbHsqHgD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linyaa.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aeb90532f6so22317545ad.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774336577; x=1774941377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nNP7GmT6mcFVsg2gbh7Sv2GmdBN3MRKXVSXl7oCqjfM=;
        b=PbHsqHgDzTMkr+zIcqltQdLrlSJWFfdEAwk1idTsUppnPHjD4S+2Dd4lZuohyDW0Iz
         Bskea0JflFpaU3gDqjJHZiFyt3MZp9sBM3xHmLoPFZjcRtYUjiqMblS7tLezGSR9F9v2
         n63BJcV52OPPviojAxMkWQPVonvst3Q2s58Ccb2Istsoj3xpGb2zYDbBPMgsub1u0WlY
         fke7p/6q9WdwOgThzSQzRHwMhif2SgrBfCdSYLn69gdlirO3XI2PoH8oLa+8HB0xBzHi
         MHigY3VYdgcBNesEyJSD5hTsnTgD6BJeclyvuofhIuboKaFDYxJOfuHFQPu24X0ZVT2j
         iVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336577; x=1774941377;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNP7GmT6mcFVsg2gbh7Sv2GmdBN3MRKXVSXl7oCqjfM=;
        b=jcFbSZoZvnasb5tSa50y/jEutG2g8lFdFoD1DOJ2bB+X8D3soqby4EhajfBwcQjoXt
         S2K+63s36TinO5d92DdGnPicQsBklnEls6nN2Ssy6sko1kXM+R1xI9rxrnj1p5uenybj
         EI37EjOUsibbhdQNdXc46igT6hImh6+m+dtgYx/6ljNk0ks4DnlkTC88ZSm8xcJvgLjv
         /VLffZ2t5aPczxEihJN8GM63uBDpwPbN9RyZZpDSxcVAK3R3dNtHCemQUQ7JmV92bq3S
         2Kw6OQPTgbyWwTFPIvV67H3RFulW6UkvvDrUB7EnolPjv7KwlkRT8o/ha60LJwqTWFxQ
         6ibQ==
X-Gm-Message-State: AOJu0YyXupmPLqtamrAbOfRqxyCGp29xj3MUUM2/Cu6kzq9eGDryj7Jv
	zvmgTcQgBXzUfYy/Dd6GFk1qECwDlkeR+eeA3IH0bE8DRe4ZLN3dEp8Or3R9hcTn1dfIfDfG9io
	5dXPv0RXRZjfabnJJw9LT7dbcXYEYH+YPhtaCHLxZ4dCwImpyQujuVleG3DUU0nOtmvcuaVSFUA
	rxi6CtXLyi7VJWDuOh5mkBGiMzCodc2om64VQN
X-Received: from pljf15.prod.google.com ([2002:a17:902:ff0f:b0:2ae:3d74:7993])
 (user=linyaa job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f652:b0:2ae:44db:56ed
 with SMTP id d9443c01a7336-2b08271c87bmr141563565ad.15.1774336577041; Tue, 24
 Mar 2026 00:16:17 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:16:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260324071614.207783-1-linyaa@google.com>
Subject: [RFC PATCH 6.1.y] Reapply "cgroup_freezer: cgroup_freezing: Check if
 not frozen"
From: Lina Versace <linyaa@google.com>
To: stable@vger.kernel.org
Cc: Lina Versace <linyaa@google.com>, Chen Ridong <chenridong@huawei.com>, 
	Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-230065-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linyaa@google.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,huawei.com:email]
X-Rspamd-Queue-Id: 664C3303FFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit 8594813132f02bb569380461346583918b6e5e86
from v6.1.147.

Commit 8594813132f0 appears to be an incomplete backport. It triggers
the below warning in ChromeOS suspend/resume tests.

    kernel/freezer.c:199 __thaw_task+0xc5/0xd0

Why is it incomplete? When 14a67b42cb6f (Revert "cgroup_freezer:
cgroup_freezing: Check if not frozen") was backported from master to
stable branches, Chen Ridong reported[1] to LKML that the backports to
6.1 and 6.6 had misssing dependencies. In response, the dependencies
were backported to 6.6, but were not backported to 6.1 (as of v6.1.166).

For reference, below is the backported commit and its dependencies (derived from
this email thread[1]).

  master       linux-6.6.y  linux-6.1.y  subject
  14a67b42cb6f f371ad6471ee 8594813132f0 Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
  9beb8c5e77dc ae591cf2348a 0            sched,freezer: Remove unnecessary warning in __thaw_task
  418146e39891 036bdae8c985 0            freezer,sched: Clean saved_state when restoring it during thaw
  23ab79e8e469 2e62985121b7 0            freezer,sched: Do not restore saved_state of a thawed task
  8f0eed4a78a8 e241ca2f0ec3 0            freezer,sched: Use saved_state to reduce some spurious wakeups
  fbaa6a181a4b 8afa818c7733 0            sched/core: Remove ifdeffery for saved_state

[1]: https://lore.kernel.org/all/3f80facc-8bef-4fc7-ac7e-59279906a707@huaweicloud.com/

Cc: Chen Ridong <chenridong@huawei.com>
Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Lina Versace <linyaa@google.com>
---

Should this commit really be reverted? I'm unsure. But the incomplete 6.1
backport does feel suspicious, especially since it is triggering warnings.

For completeness, I want to point out that in the old LKML thread, Chen Ridong
proposed[2] an alternative solution to backporting those dependencies to 6.1.
Maybe it's better to take his proposal rather than doing this revert. Chen's
proposal was the below diff.

    # diff --git a/kernel/freezer.c b/kernel/freezer.c
    # index 4fad0e6fca64..288d1cce1fc4 100644
    # --- a/kernel/freezer.c
    # +++ b/kernel/freezer.c
    # @@ -196,7 +196,7 @@ void __thaw_task(struct task_struct *p)
    #         unsigned long flags, flags2;
    # 
    #         spin_lock_irqsave(&freezer_lock, flags);
    # -       if (WARN_ON_ONCE(freezing(p)))
    # +       if (!frozen(p))
    #                 goto unlock;
    # 
    #         if (lock_task_sighand(p, &flags2)) {

[2]: https://lore.kernel.org/all/89465e3f-7c07-4354-ba41-36d5a5139261@huaweicloud.com/

 kernel/cgroup/legacy_freezer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index bee2f9ea5e4ae..a3e13e6d5ee40 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -66,9 +66,15 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 bool cgroup_freezing(struct task_struct *task)
 {
 	bool ret;
+	unsigned int state;
 
 	rcu_read_lock();
-	ret = task_freezer(task)->state & CGROUP_FREEZING;
+	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
+	 * !FROZEN check is required, because the FREEZING bit is not cleared
+	 * when the state FROZEN is reached.
+	 */
+	state = task_freezer(task)->state;
+	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
 	rcu_read_unlock();
 
 	return ret;
-- 
2.53.0.983.g0bb29b3bc5-goog



Return-Path: <stable+bounces-248969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGpfFpPfB2pSMgMAu9opvQ
	(envelope-from <stable+bounces-248969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 05:08:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5E5559FF1
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 05:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE963013A9C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB22222A9;
	Sat, 16 May 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="wsOuW936"
X-Original-To: stable@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68485405C58
	for <stable@vger.kernel.org>; Sat, 16 May 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778900858; cv=none; b=n/nIih1Wtuv4YOF0Ehdm2mT2aulon6p2Ca0xv7Ae1kFf6xcvpp1P5c8KDlEokliBuQNOa0a/0AQAmanTgWxVfbOkhcXfCuQgpdDwSCPRKwyyaLhsVONUquaMMIrmlcwUxGFBFZQp906taK3T91I/cE75g6cH2ReydLdQz8+vvDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778900858; c=relaxed/simple;
	bh=6fy1f7XUSZQA5YcDBruOrIfvmpOs85SiG27ChDz4mGo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TXvJu1M7U7CpvjzFyf/6OsOaiNj6LqF6ghBFvigHgQRPD7IzIiZJtXQmvIN/G5OXoQVs1VzM//F5EPmw3NNV0C1goY5RdsTSSE/LXt/AQY7YA5mgGHw2t4PxViPX+M+62eB+3rhzBpQGst4ipezNVfI3oKL2V8Np1wV2/ZmCTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=wsOuW936; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778900849; x=1779160049;
	bh=6fy1f7XUSZQA5YcDBruOrIfvmpOs85SiG27ChDz4mGo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wsOuW93677eETvfQejFSSQfk1LiZ18Cx35z2BFYaCOe70vOFS9nTyH4HycGsi8jDG
	 qyGoSTWAXquDcpjZoMnFqF58qJUALLvvH7LBDKZA7Zv8jeRGBEz2Bt6hP0SYJzXntr
	 vP1sU4sY+ix54zucUYDJu4QmPfb/nPTpm0DEFKwJLlLkBHJVwepjTi9mgdDltgUwI6
	 EJGXpdH0ErIgNTnkIP4gddFZY8N5uuTiUopqLukJIIr40ZyWRdV3tDySOj/54wPxhh
	 MGI36Le2KZ+AID5ixi3mRcF15hGuNKrJVPjf5yqwrUpMEhuW8jKFBTDy5F0RZvIxBe
	 rFyIxGXZranwQ==
Date: Sat, 16 May 2026 03:07:22 +0000
To: "peterz@infradead.org" <peterz@infradead.org>
From: batcain <batcain@protonmail.com>
Cc: "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "jstultz@google.com" <jstultz@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [REGRESSION] sched/deadline: Hard lockup during CPU offline after commit 14a857056466
Message-ID: <r16mBH1ydY4oK0PInLKwpYR2I5qZBsV5J0JsNLrXAh8OR_QC6z6lABKlcvpzgUiBuarTKtVTP977RLI4mqt64Ydtd2O3yfhRuRJkQ1JL8u8=@protonmail.com>
Feedback-ID: 19886882:user:proton
X-Pm-Message-ID: 77c86ae82036ad0157b9a6547e3c3ace3618e4fb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AC5E5559FF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248969-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[batcain@protonmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Action: no action

[1.] One line summary of the problem:sched/deadline: Hard lockup during CPU=
 offline/migration due to frozen rq_clock loop in update_dl_revised_wakeup(=
)

[2.] Full description of the problem/report:
A deterministic hard lockup occurs during CPU hotplug (offlining a secondar=
y core) on stable kernels containing commit 14a857056466be9d3d907a94e92a704=
ac1be149b.

When a CPU core is set offline, tasks are migrated within the stop_machine(=
) context where local interrupts are fully disabled (irqs_disabled()). Duri=
ng task migration, enqueue_task_dl() calls update_dl_entity(). Because of t=
he new dl_defer rule introduced for implicit dl_servers, the code is forced=
 into the update_dl_revised_wakeup() branch.

Inside update_dl_revised_wakeup(), the logic depends on rq_clock(rq) to cal=
culate laxity:
u64 laxity =3D dl_se->deadline - rq_clock(rq);

However, under the stop_machine() noirq phase, the runqueue clock is stale/=
frozen. Since the clock does not progress across iterations within the enqu=
eue loop, the mathematical state stalls. Consequently, dl_entity_overflow()=
 continuously evaluates to true, trapping the processor core in an infinite=
 loop inside the enqueue path, resulting in a system-wide hard lockup.

[3.] Keywords (keywords of the affected subsystem):
sched, deadline, dl_server, cpuhp, hotplug, hard-lockup, regression

[4.] Kernel information (output of "uname -a" or version):
Linux workstation 7.0.7-hardened2-1-hardened #1 SMP PREEMPT_DYNAMIC Fri, 15=
 May 2026 00:03:13 +0000 x86_64 GNU/Linux

[5.] Most recent kernel version which did not have the bug:
Any kernel release prior to the integration/backport of commit 14a857056466=
.

[6.] Output of Oops/Panic/Bug/Objdump:
No native kernel oops/panic stack trace is written to disk/serial because t=
he freeze occurs inside stop_machine() with interrupts masked. NMI watchdog=
 triggers a hard lockup panic if aggressively armed.

[7.] A small program which triggers the problem:
# echo 0 > /sys/devices/system/cpu/cpu1/online

[8.] Environment description (Hardware, distribution, etc.):
Hardware: Confirmed on both AMD Zen 2 (Renoir) and AMD Zen 4 (Phoenix) plat=
forms.
Distribution: Arch Linux (using official extra/linux-hardened kernel packag=
e).


Return-Path: <stable+bounces-274670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6v7CCrfqVmqpCwEAu9opvQ
	(envelope-from <stable+bounces-274670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:04:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F7F75A00B
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:04:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ultrarisc.com header.s=dkim header.b=ECfOVz8J;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274670-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274670-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ultrarisc.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 800A0306B54C
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30A3A872C;
	Wed, 15 Jul 2026 02:04:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF138F64C;
	Wed, 15 Jul 2026 02:04:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081069; cv=none; b=PybACNXj8PSUZ2geuKozToFcmX7KLV6wR49rXa7aiVwf4VIHLz1Y+kFGYrQmSDZ1g/tOJ/tZcUwO2afkbU8cyfbjXYu3/Vhp14W1de7z3OYlah3kI74vezbWe4ZCWGM48+SWTcJSweIvVIAh+4loZzPSN5mIEL3A4+MLmVqYqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081069; c=relaxed/simple;
	bh=PX5km05g/W6UeP4bHhbxX3nQahWLu0TE7I9fhNhU8ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUsPqRNGH0IY7pfexbId0t6d8NrDntYXLTx/efWCmlzFiaEVL74yLzQUX21OA+1tBieaf2S6nZC8oKdUwX1p9ZJ+98dA42tmLa5Nt7QHgXQK+95L0e7FLw6Dso73DYQpqmxornn57nSg8JLZZzAuRaOb/rIPaM7rXBUhF6RG+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ECfOVz8J; arc=none smtp.client-ip=218.76.62.146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Ux+YlDFnPNWIMjq0BvNP9tiG0/QVCKDhsi
	CSzr+cmBM=; b=ECfOVz8JkJ/xiz+0tGE5UVlsczMbKo580e3uvhIWyTrGXXtKP9
	iBrfeVxO70nCGlb0tOmssK6DlPMV9RCAxvtLSd6GaV1+Hhh+rDXXP9v05mZv0GZ1
	QlXb3JQQdf8dy0O1CCDQzzTxCyYmwVD8yCTn/VV0uJcB8jvbXeNG9P89Y=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUKu6lZqDtkRAA--.16825S2;
	Wed, 15 Jul 2026 10:04:31 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: Anup Patel <anup@brainfault.org>
Cc: Xie Bo <xb@ultrarisc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] RISC-V: KVM: Serialize virtual interrupt pending state updates
Date: Wed, 15 Jul 2026 10:03:58 +0800
Message-ID: <20260715020359.1521354-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
References: <178159067899.108868.8176174463274678253@ultrarisc.com> <CAAhSdy3_YnzNiSE=KykriwSWU8X2CLhdr2E8CB=32JxA_L7caA@mail.gmail.com> <20260713073346.1293408-1-xb@ultrarisc.com> <20260713073346.1293408-2-xb@ultrarisc.com> <CAAhSdy0hX0z6BpOUZSnCmhh7aeHUm3Yh5k9TdzUGC+4A1W+Czw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnYUKu6lZqDtkRAA--.16825S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW8KF1xur43XFWDJw1UJrb_yoWxArg_W3
	4aka17G34kJF43ta95Ar48CrsYgw1DCa4xGw4Sgr9rtrn5CF43WFZ7ArnxWwn7J3yYva43
	twn09an2gayayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAHB2pUYNAARQAEsO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ultrarisc.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ultrarisc.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274670-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anup@brainfault.org,m:xb@ultrarisc.com,m:atish.patra@linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:pbonzini@redhat.com,m:graf@amazon.com,m:kvm-riscv@lists.infradead.org,m:kvm@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xb@ultrarisc.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xb@ultrarisc.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ultrarisc.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ultrarisc.com:from_mime,ultrarisc.com:dkim,ultrarisc.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70F7F75A00B

Hi Anup,

I addressed your comments in v5:

- kept kvm_riscv_vcpu_aia_has_interrupts() as a single helper and made
  it acquire irqs_pending_lock internally while checking the high
  pending bitmap;
- released irqs_pending_lock before the IMSIC VS-file check, since that
  path takes vsfile_lock;
- kept the guest CSR updates outside the critical section and protected
  only the dirty bitmap updates; and
- added the requested whitespace and clarified the race example.

The patch remains based on Linux 7.2-rc3. RV64, RV32, and RV64 with
PREEMPT_RT KVM builds pass, and checkpatch reports no issues.

The v5 patch follows this reply.

Regards,
Xie Bo



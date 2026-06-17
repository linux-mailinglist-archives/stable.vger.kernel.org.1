Return-Path: <stable+bounces-266671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +Ib0DPFgMmrzzAUAu9opvQ
	(envelope-from <stable+bounces-266671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2584697B12
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:55:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=tGnL3Cez;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=Mommjx+g;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266671-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266671-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0613A30E7375
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD83D904D;
	Wed, 17 Jun 2026 08:49:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51C3CB918;
	Wed, 17 Jun 2026 08:49:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686164; cv=none; b=Aaqia/3ByZh//br+PLknClIfvJK7B6rz6upYfkIZWdiFYcDPOAjO4T4dGmwCLQx3QrQNAPg8n+4FKBHVypY1CH2AGu9z2q1eA3zOI+BEfd9OjbFmFbfrabxTO1MNo95nDMagszM73acQ48moxL8C/RU2kwFlWuqx7TvBrc3T2+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686164; c=relaxed/simple;
	bh=4l2BKjym3mytO0Q6PBB2W4g8XqgjCbKZyZOeZ1FMgK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxm6bke++FnUsLwZtKZIT2RPouvmr9AO2x8V0r1CNBuZ0bjwGiqtJEVwDtqS0oOK4+xXlO28dLMaWCA/Ks5dLDgz/iBlDJffPnDgQ5QxnjacTv59o151he9APLuo1CoiYIgQvSMjiH//se8jqYCVTlikvnzIzJP9MgSNeqjoreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGnL3Cez; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mommjx+g; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781686147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4l2BKjym3mytO0Q6PBB2W4g8XqgjCbKZyZOeZ1FMgK0=;
	b=tGnL3CezgSQSCYxHm+fgYbSvzfuf2ltLwHErTnksa+NUvalR2pVJXOatyHId9e/9qJQLHI
	yB2rEFsjAZyTHuUf0++Kw5OJRPcuD9coec8pk8va1KL0jPmVvIh2CK/TXoJD3yMywrw+SK
	F+j1Jz6bUiquuFKiKvzZoE4AsnlmzNWAdOsmCLO1Dq4W8MGMKboW8B0YhNfKZ/lHgiQqJq
	8Mm0g4G5NUwc5cyeXM/+txsTAK3DwttyXyrXjec3Q9nxzae0Ac8Xd3i+UsrMWx8P89gHhN
	WYpER0No/Nev27EPg1feRo0b+ScuO27CI/7p20/GtlGH9uMgujG4n8Hr/h0MrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781686147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4l2BKjym3mytO0Q6PBB2W4g8XqgjCbKZyZOeZ1FMgK0=;
	b=Mommjx+gS7sauK5jJ6WSnQenr2JKsc8xxW8s2nMZFeACOx0q/JYO6c8bbpXM8xq+orf1YQ
	y85Vcgy1uKLfCeCA==
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Andrew
 Jones <andrew.jones@oss.qualcomm.com>, Jingwei Wang
 <wangjingwei@iscas.ac.cn>, Anirudh Srinivasan
 <asrinivasan@oss.tenstorrent.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: unaligned: stop using kthread for
 check_vector_unaligned_access()
In-Reply-To: <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
References: <cover.1781666867.git.namcao@linutronix.de>
 <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
Date: Wed, 17 Jun 2026 10:49:06 +0200
Message-ID: <87tsr1zh4t.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266671-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:andrew.jones@oss.qualcomm.com,m:wangjingwei@iscas.ac.cn,m:asrinivasan@oss.tenstorrent.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:from_mime,vger.kernel.org:from_smtp,yellow.woof:mid,tenstorrent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2584697B12

Nam Cao <namcao@linutronix.de> writes:
> A kthread is used to run check_vector_unaligned_access() to optimize boot
> time, allowing the kernel to continue booting without waiting for the
> unaligned vector speed probe to finish.
>
> However, this asynchronous approach introduces several complications.
> First, the kthread may not complete before a user reads vDSO data,
> resulting in incorrect values. This was previously addressed by
> commit 5d15d2ad36b0 ("riscv: hwprobe: Fix stale vDSO data for
> late-initialized keys at boot"), which added complex synchronization
> between the kthread and vDSO reads.
>
> Second, it was discovered that the kthread may not finish before
> vec_check_unaligned_access_speed_all_cpus() (marked with __init) is freed,
> triggering a page fault.
>
> These issues raise the question of whether the kthread is worth the added
> complexity. A past boot time regression report was actually unrelated to
> synchronous probing; it was caused by the probe running serially. Since
> switching to a parallel probe, no further complaints have been made.
> Furthermore, the unaligned scalar access speed probe takes the same amount
> of time, runs synchronously, and has caused no issues.

Another point I forgot to include. We start the kthread to run
asynchronously, but the probe is executed on all CPUs including the boot
CPU. Therefore if the kthread is executed before boot is completed,
asynchronous probe will actually slow down boot time due to the overhead
with kthread. If the kthread is executed after boot is completed, we run
into the two race conditions mentioned above.

> Testing shows no noticeable boot time slowdown when running the vector
> probe synchronously (0.464474s with kthread vs. 0.457991s without).
>
> Remove the kthread usage and run the probe synchronously. This simplifies
> the boot flow and allows for the revert of commit 5d15d2ad36b0 ("riscv:
> hwprobe: Fix stale vDSO data for late-initialized keys at boot")
>
> Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> Closes: https://lore.kernel.org/linux-riscv/20260612-vec_unaligned_drop_init-v1-1-df969210ae34@oss.tenstorrent.com/
> Fixes: a00e022be531 ("riscv: Annotate unaligned access init functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>


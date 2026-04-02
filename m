Return-Path: <stable+bounces-232963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNgyBG08zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A853873B3
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1705630B46E6
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDA63C554C;
	Thu,  2 Apr 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWpDCS1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOBaqdFG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499823AB27E
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123382; cv=pass; b=Uc5idCx2VO7X6RPLUqBIvdUwg+MJASGD2rwAX7fr1t0yDaI0lA5/OprDh7DVRb8P55GRI0fTAHwWwvvaKDQil0i7iIonJb2jQRTBElkVTNkTbA1Ouxj0FugDhrbDVsqAUoR+eheB9egfMQdVwV6h43wxNFVu/S0qJdFHXmagf78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123382; c=relaxed/simple;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+9qit8mcNMrWiqavbWxUehUQ5K8iEoaTQdd791kHKcdJHLhQqbQm29aud2rEEamvVBmrULDDZhH4nnxriFnBZMk5Fq+YbW4VucASsOKnzAKZ71TXjIFUgdN9I3R9FsfkYelk35/ZdDiaHlZu+ZUjtalH1lQd8BQQoj3lb5E9eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWpDCS1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOBaqdFG; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	b=LWpDCS1VjflzmgDG/PxwXOMQq+9TmI6g72ySxcoGjYJx86B22ZGpBNNOGyczK0CLBpFoh4
	Z+boYVlLSfcLF2qNjIQDZH6tN3GhXS47XzQRCSPvdY9SQIbBadL5ecNnIqA5E3IremL6A8
	MDNxBAG1/5rJDanUEPB46P3Pd5oNAHU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-5YJ1x-63M26iQJLuq-IMTQ-1; Thu, 02 Apr 2026 05:49:34 -0400
X-MC-Unique: 5YJ1x-63M26iQJLuq-IMTQ-1
X-Mimecast-MFC-AGG-ID: 5YJ1x-63M26iQJLuq-IMTQ_1775123373
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b844098869cso55511666b.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775123373; cv=none;
        d=google.com; s=arc-20240605;
        b=lq/tPwTPly6GZ6JW2qTrcZyi9/zu/pB/oP2yg5xIdxW2rftTA7yGO4ylzIu4MQxZS1
         sP6rdrOuT9DLd3TlR93XD7F/K/MbcL0p5690aUeBWV9DuHbcZyYnrMOTf3w9JJ1jLGSj
         DUsmF3PgiHnn/xsTvnBmYNUYGeV3zqinhqxvK9xh/48yioe/ktiJmFjoa3S+Dwet60en
         RaOFnUY74gBtAhE/Lder3YoXAJvIyHpgSAoAlrqJHeCie4TCK79HLrpuRKH10l8EovgY
         S41KAJqWUJJKPgmrXI1FT+xlQ6vOf71TIWoGQS18s3D5gc8AAN8R35zsoLmMPHJdlgX/
         GSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        fh=uvKnsGs0e07Jq5lPHU7dnfooGKdcpmzAg3b4GSW9FEg=;
        b=O8q2EVPpEzkLVAz6gX/mVflmsKlxExx3MWTGJ0/Ea0Sz57KdIeeAJA3QjwLlBBKrTa
         DW/L+boJ28y+1tV6OA6PMHI1W4B68gt+QoiYxk1D8rh9R51xQ4LNif2SjHzTiv8CFwyq
         hFE4VIp1PvbQUqH2GSFz6zBWF7jqcwa/7GLlYlEzHCSY+tGyxa47tm2L8tWnYU/mX2J6
         SdI8l5lAXvKI8gtGG4kn35TaN8OZs66v9ObCNmrfMGEyNKTGYhibI9J8AIzcvwJXlA0P
         k9/Re1qFzWDuyjjIxIoGf+5akTT/X06O1420xIGSh0dTAeJL/aFmjmwT8wwUffCjk4FL
         2Dkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123373; x=1775728173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=UOBaqdFGTixDkdR6S35LVJjoFbXZ5cM2ZGgDD2OKMOrb5dXOS99tH6hYnIB9FMO31j
         W3m4oqmXQVWZkuTX4oU5da+LG4bfp8WKh5eHuorBEOw8HPAKoN8YjguP2zEJs3Qy53Aa
         UHu6VA9+QkhuwqHdjW2qw0MTzGH4gBJX0z9TwXqAvhKZXNcU9G46DspqjGbdJYTwGqCe
         4aa0i/yIVs8EH5wAphwGc8TUHyce31EXOiCY9e5s1uuRmzpC/wHS0dJ8KIYvWi7E8E4W
         O5SxzTTb1PbFk7/YYfhnWTaEDCrrKlnaIOmuCVM8YBgEWRe0Vw1t92KGJb+aQZEJKkce
         MYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123373; x=1775728173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=h93uuH19hse0O4BcsXqhKoQXr1rBATaCGv0izpB3Sl+uwFNeDYRxNY80BiE7qZWrx6
         /gZ2V0nwRuzEbqbCq4IuzQoVaikcSW4EnBz9PdwJixxnbOiYBRJHbAacR6tgpiGs3cUK
         VISR7zvDRa0sTK+FZmtRFxBcaNNXsGz+sF0zA8kcSoYWeMShsdxBKw7i9XIIWLg0qrMs
         AlhugIW1leVNEvSUdFltWhK29B7lyeJD/axZMct0YkHt3PC31+wEwl7v7eMyUkVXHwiA
         FPV5R7+vO/PKAn/ByelPUdtDb8EddpdRnhcGRF7hztNeuFdP259vPsmZOWaLkDmACc/n
         li0w==
X-Forwarded-Encrypted: i=1; AJvYcCUaLXOPLqeao8z5HwGfqO3RCwTIU+VuXhx1hUfoKP9vOFebLW8UOmLdzrQZL9P2pEwQw1HvZ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrH2RgGpKmdnXJZ9ADVno7nxM+xvCoPRyeKlpa5v7Qc3CdGLIJ
	TSRO3KAhxyi1TfUzNW1Kxw88s/WeKW929F2JhKTPZp8GvlvyOMY7kX9URjzguObAwQOEtzSgd2v
	G2oASusTSdGGuueMV3De5huzl5lXDvmyVoXfMieIvljnrqKo4GtBGiFrE6EApLsOQD0bTqkHJFO
	Fq2R7P+Cx2PILMmYtdpEjXbQEY7uR0QVfj
X-Gm-Gg: ATEYQzzh+Gqe0091nx/wUyfr/bw3pqW3H+hyEjmSha91ra0DP9YgRuxwu4QeBNhkxC+
	iBFSzce3qPbYg8oRPBZ18DUN8EVNypRtl7n3wp5bQIqyZPE/8YynOR7BZvZLo8fOodPuk2Up0vo
	osF+v7HZEVsErpGIlhtaBun3uop85uJJeb95+wDV1FG+oss8PxV3HQ+nP7j/0w532xMF4P0+tSU
	TSToA==
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id a640c23a62f3a-b9c13b0b08emr475388666b.24.1775123372901;
        Thu, 02 Apr 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id
 a640c23a62f3a-b9c13b0b08emr475385466b.24.1775123372331; Thu, 02 Apr 2026
 02:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com> <20260401165841.532687-1-ionut.nechita@windriver.com>
In-Reply-To: <20260401165841.532687-1-ionut.nechita@windriver.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Apr 2026 11:49:20 +0200
X-Gm-Features: AQROBzBJw-tLhM-lD_x8-woUH2LWxJHrMMtqB3L4YgOqRmMqBGl5_Aj9bKxBLJU
Message-ID: <CAP4=nvQehXtd2AEFzuRzcqfXOmU6U3LH9M-nQTvNkdCtAV8YTA@mail.gmail.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: jan.kiszka@siemens.com, crwood@redhat.com, florian.bezdeka@siemens.com, 
	namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232963-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglozar@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9A853873B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

st 1. 4. 2026 v 19:08 odes=C3=ADlatel Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> napsal:
>
> Separate question: could eosnoise itself be improved to avoid this
> contention? For example, using one epoll instance per CPU instead of
> a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
> instead of the per-cpu perf buffer which requires epoll.

Neither BPF ring buffers nor perf event buffers strictly require you
to use epoll. Just as a BPF ring buffer can be read using libbpf's
ring_buffer__consume() [1] without polling, perf_buffer__consume() [2]
can be used the same way for the perf event ringbuffer; neither of the
functions block. If you need to poll, BPF ring buffer also uses
epoll_wait() [3] so that won't make a difference (or is there another
way to poll it?)

[1] https://docs.ebpf.io/ebpf-library/libbpf/userspace/ring_buffer__consume=
/
[2] https://docs.ebpf.io/ebpf-library/libbpf/userspace/perf_buffer__consume=
/
[3] https://github.com/libbpf/libbpf/blob/master/src/ringbuf.c#L341

That being said, BPF ring buffer is not per-CPU and should allow
collecting data from all CPUs into one buffer.

> If the consensus is that the kernel side is working as intended and the t=
ool
> should adapt, I'd like to understand what the recommended pattern is
> for BPF observability tools on PREEMPT_RT.

The ideal solution is to aggregate data in BPF directly, not in
userspace, and collect them at the end of the measurement, when
possible. This is what rtla-timerlat does for collecting samples [4]
where it was implemented to prevent the collecting user space thread
from being overloaded with too many samples on systems with a large
number of CPU; polling on ring buffer is used to signal end of tracing
on latency threshold only, no issues have been reported with that. To
collect data about system noise, timerlat collects the events in an
ftrace ring buffer, and then analyzes the tail of the buffer (i.e.
what is relevant to the spike, not all data throughout the entire
measurement) in user space [5]. The same could be replicated in
eosnoise, i.e. collecting the data into a ringbuffer and only reading
the tail in userspace, if that suffices for your use case.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat.bpf.c
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/tracing/rtla/src/timerlat_aa.c


Tomas



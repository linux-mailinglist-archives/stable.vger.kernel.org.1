Return-Path: <stable+bounces-254314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKFQKYuBFWoHWQcAu9opvQ
	(envelope-from <stable+bounces-254314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FE25D4C78
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25C9F302514F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35503E0080;
	Tue, 26 May 2026 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Whqwe4D6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFA3DF018
	for <stable@vger.kernel.org>; Tue, 26 May 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794312; cv=none; b=W+aNmUniNb9eFLryoja7qYnmhqs02TTtaWX5JtKYCVBLzDmqyq2fnJR8ZeRmAa/NHqSFfAAGqCQRPW+vXDtkwXe/3UPMuur0yK/2Nj5ZC+cYvH2EmBzKxIThNnqS7hYc2xC9AtXUA8wr2Ca5MtEmTEjpSctczKSEZmGklMxvjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794312; c=relaxed/simple;
	bh=WXyxERZkAF0LlknC4H8opQvQi25M6gfBOrIFzH8Jgu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2RvPK3n5Vkya9QriY1UFRwwaOA8CqxdvBTJO1Hpm4fkmJBph5UaB0iByIm1t7Bj5mu5NBu9pQVMTawZpzGSxeyt+Z9531QtXXSsjSuMN3ey3WAhLrsl9VTW+Mq95BqtNDS3J4agKKh9OItvHdi7ElaWgwniDMiRgnzbfP5nQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Whqwe4D6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so40642545e9.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779794309; x=1780399109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iel9G2dSq5mVeEVrZU7ubpkoHb7PNbJx58eC9mITM2Y=;
        b=Whqwe4D6Evk2cto9uUaFrD5Q+gP27VvhZwh9NUsFXDiK8di0F3WB/ZOeaXrleQEdx5
         MGS6Lwlx0D5JxNn+4aFO3W0Kao9BbdbPAlRVuCXXo3lF0haWRQQ5Gqvbrfv3WEsTFwbK
         vQ7fEdKPa4U/23Dl7dXpo13lxX35W69VKNssQktL0OCeN8Q5omSR4jpfY5KqQJzVp1KA
         pO+mzlpeq/xmMdVjlZSN4e2ZxZ5s9q4qDK9eBOrEqEIUYlKBHyG8/jf+EAblCgq/oGYq
         xu3XmSJHLaVDIivUtqTXQUiIoFj6bV1Z7JYYHmJd7NGipRkA2sIQ0vy98+RwzCHwAWFa
         KbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779794309; x=1780399109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iel9G2dSq5mVeEVrZU7ubpkoHb7PNbJx58eC9mITM2Y=;
        b=dSf8+mqaUMCP94mu5oJ8KOwkAbY0WKVtPujKt+nheXRvWMfcyXcX5eV2kHQyhR3BV5
         JpusSz4Af1ghcqNS6FJ1lxtJpWvYJQNCizXAZjgUozgHZPyFYXjfOCU9MIwg8a+r/j+B
         4GvIfmt+FF8meCfhUvJ418+TC4Cs78GmjrysECm+u4GhDK5JJKmWQwGRtmTcJWMEe+I2
         BPZujai4P7QoFRvlk3laOeElCQoCstH2U7KHO7oIrFAworJbXdTwIUwc4Ibaq60QZMGR
         +YjffJ89vbGm3HzuIlHkeFs503vMmsb7y+gMfFVMoFby0fRB5kUpbRTlFCC8K9fHWJYi
         J3Uw==
X-Gm-Message-State: AOJu0YyPg7+GvUhg/+PkReGPgtaGpT6b0rKy89xvFaclVOivBNC5yJRQ
	2igzJT/6UnzsXQzGaSsQCp/zVDL45ZqZfptJQkJOs13v3Y0kVSNwFnLj90/C6fVJze4=
X-Gm-Gg: Acq92OGNVJyhLkNUAtEDXGxgGZIdRhKZ7+gISivWtgLV+5d3X6Wy4TsKvdFq2g6ax3x
	ae0OX7e4zEZcrNpuuyuFBaiJnE1nAsJNufdaTgRSTQPdbyeMp8pDepUWDULYxfcZxKJcI6tYPai
	Oh7cj4WBqjL2PrUzQ/GmUIO1x01Z/tFe8Cuho30dCsvve4SCSVI4OBcO7xmQJMOIfsSiHxbndQt
	gmK07KTE+kHciBG6E8FdO1s7COFPco7/AVradd2EgXh7bvmPdp9WfPJj/0Ks8AmgYgz++CCNs0S
	f8houDk5h14Z/psTnh8plqQ0XdVc+FQ6sRXkQN1AmjB8MtjKuKSc2A0iNtIw4taVWTxj1LfJtJ7
	fLgNat+l0wEUwg2ApeuuaQTPXiA7mNx2syWoLDwTO1pRptLz/P5ktO8nou9gbq4kYd8QfJZoHnW
	rgt/p95DIwyhlaPpb4nFkHxhu/XKrA
X-Received: by 2002:a05:600c:4510:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490428ddf15mr282865845e9.28.1779794309281;
        Tue, 26 May 2026 04:18:29 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428d4d8asm109534425e9.16.2026.05.26.04.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 04:18:28 -0700 (PDT)
Message-ID: <f767dc3b-9796-4b12-a776-1de6a9ff3f99@linaro.org>
Date: Tue, 26 May 2026 12:18:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf cs-etm: stamp pid/tid/EL on each buffered packet to
 fix cross-pid attribution
To: Amir Ayupov <aaupov@meta.com>
Cc: stable@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515021135.1729028-1-aaupov@meta.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260515021135.1729028-1-aaupov@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-254314-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james.clark@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 22FE25D4C78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 15/05/2026 3:11 am, Amir Ayupov wrote:
> In a system-wide `perf record -e cs_etm/.../u` capture on aarch64,
> synthesized samples emitted by `perf script --itrace=il64` are
> sometimes attributed to the WRONG sample.pid/tid (and to the wrong
> EL/cpumode) for the chunk of branches that straddle a context-switch
> boundary on a CPU. A branch actually retired by process A is emitted
> with sample.pid set to the thread that next ran on the same CPU.
> 
> Mechanism:
>    1. ETM emits CONTEXTIDR/EL packets in-stream when the kernel updates
>       CONTEXTIDR_EL1 on context switch / EL change. OpenCSD turns these
>       into OCSD_GEN_TRC_ELEM_PE_CONTEXT elements interleaved with
>       OCSD_GEN_TRC_ELEM_INSTR_RANGE elements for retired branch ranges.
>    2. cs_etm_decoder__buffer_range() queues each INSTR_RANGE into
>       packet_queue->packet_buffer[]; packets carry start/end addrs,
>       instr_count, last-instruction info, etc., but NO owner identity.
>    3. PE_CONTEXT goes through cs_etm_decoder__set_tid() ->
>       cs_etm__set_thread(), which immediately mutates tidq->thread and
>       tidq->el. Queued packets are not drained first; reset_timestamp()
>       is called so the next TIMESTAMP triggers OCSD_RESP_WAIT and a
>       drain.
>    4. By drain time in cs_etm__process_traceid_queue() ->
>       cs_etm__sample(), sample.pid/tid is read from the now-mutated
>       tidq->thread and sample.cpumode from the now-mutated tidq->el.
>       Pre-context INSTR_RANGEs get the post-context owner.
> 
> The same race affects branch samples via tidq->prev_packet_thread /
> tidq->prev_packet_el, captured at packet-swap time from
> tidq->thread / tidq->el (which may already have flipped).
> 
> This is independent of PERF_RECORD_SWITCH_CPU_WIDE, which is
> deliberately not used to assign sample identity in this path. The
> bug applies to any cs_etm capture with in-stream CONTEXTIDR
> (PIDFMT_CTXTID or PIDFMT_CTXTID2).
> 
> Effect on downstream tools: branches that should belong to the
> previous thread on the CPU get attributed to the next thread. When
> the two threads share a binary, leaked branches' VAs land in the
> wrong thread's mappings; samples whose IPs land in r-x mappings
> silently pollute that binary's profile, while samples landing in
> R-only/RW mappings show up as out-of-range / non-text samples.
> Either way, AutoFDO/BOLT profiles built from `perf script --itrace`
> output of system-wide cs_etm captures contain misattributed samples.
> 
> Concrete example from `perf script --itrace=il64` of the same
> captured branch (same timestamp, same IP, same from/to addrs) before
> and after this fix:
> 
>    before: launcher_multia 2638146/2638146 705897.219172: \
>                fffcda6b124c 0xfffcda641958/0xfffcda6b123c
>    after:  ws-tcf-sr-io13  2736581/2741587 705897.219172: \
>                fffcda6b124c 0xfffcda641958/0xfffcda6b123c
> 
> The branch was retired by ws-tcf-sr-io13 (tid 2741587) but, before
> the fix, was attributed to launcher_multia (the next thread to run on
> that CPU after the context switch). After the fix, it is correctly
> attributed to ws-tcf-sr-io13.
> 
> Why not "drain on PE_CONTEXT then switch" (deferred-set_thread):
> tidq->thread has two consumers \u2014 sample emission needs the OUTGOING
> identity for queued packets, but cs_etm__mem_access() needs the
> CURRENT thread's maps to fetch instruction bytes for OpenCSD. The
> two needs are temporally inverted; a single tidq->thread cannot
> serve both. Keeping tidq->thread current and stamping owner identity
> per packet is the only design that decouples them cleanly.
> 
> Fix: capture the owning pid/tid/EL on each buffered packet at
> cs_etm_decoder__buffer_packet() time (before any subsequent
> PE_CONTEXT can mutate tidq->thread / tidq->el), and read them at
> sample emission time.
> 
>    - struct cs_etm_packet gains pid_t pid, pid_t tid, int el (storing
>      an ocsd_ex_level value; typed as int so the struct does not
>      depend on OpenCSD headers, which are only included inside
>      HAVE_CSTRACE_SUPPORT).
>    - cs_etm__etmq_get_pid_tid_el() (formerly cs_etm__etmq_get_pid_tid)
>      returns all three.
>    - cs_etm__synth_instruction_sample() reads sample.pid / sample.tid
>      from tidq->packet->{pid,tid} and derives sample.cpumode from
>      tidq->packet->el.
>    - cs_etm__synth_branch_sample() reads sample.pid / sample.tid /
>      cpumode from tidq->prev_packet->{pid,tid,el}.
>    - The separate prev_packet_thread / prev_packet_el bookkeeping in
>      cs_etm__packet_swap() / cs_etm__init_traceid_queue() /
>      cs_etm__free_traceid_queues() is removed; the per-packet stamp
>      on prev_packet now carries that information.
> 
> Cost: 12 bytes added to struct cs_etm_packet (~12-16 KB per
> packet_queue with CS_ETM_PACKET_MAX_BUFFER=1024), 16 bytes saved per
> cs_etm_traceid_queue (one struct thread * + one ocsd_ex_level).
> 
> A residual gap: cs_etm__copy_insn() reads sample.insn bytes via
> cs_etm__mem_access(), which still uses tidq->thread (the current
> thread), so the inline insn bytes for an outgoing-thread sample may
> be looked up against the wrong address space. Fixing this requires
> threading the packet's owner pid through cs_etm__mem_access and is
> left for a follow-up. sample.ip / sample.pid attribution \u2014 what
> AutoFDO/BOLT consume \u2014 is correct.
> 


Hi Amir,

Can you test the patch here to see if it fixes your issue [1]?

We thought it didn't make sense to store the thread on every packet when 
there is only one active thread for the decoder and one for sample 
generation. We also fixed the other issue mentioned above about 
cs_etm__copy_insn() not working.

Thanks
James

[1]: 
https://lore.kernel.org/linux-perf-users/20260526-james-cs-context-tracking-fix-v1-0-ebd602e18287@linaro.org/T/#t



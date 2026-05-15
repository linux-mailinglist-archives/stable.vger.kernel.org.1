Return-Path: <stable+bounces-247311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEOZJAWDBmqdkQIAu9opvQ
	(envelope-from <stable+bounces-247311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:20:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A45548B11
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B550E302207A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B8311942;
	Fri, 15 May 2026 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="A/WENgJx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743C1A680E;
	Fri, 15 May 2026 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778811493; cv=none; b=gsmGPYSxnXw44/UX0wrE6OJJ+gFGkTxgWYfWOwehBkRPyGWett1w3DUK2lUL1mgjXm0twX+sSFwLmosxzzfW8B/8CtaT0fePCrc8YDs++pQbE7DxHlARZCFZHyhbnAYi2bmdSzXCVFX1zh7DQBsHYxQZyf3hUF74JMfrsEBjV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778811493; c=relaxed/simple;
	bh=G/HLAujxOGZoKY7T4N7zmJwowPqnhr1WI5Ll+ZCdcEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HHZAnVcISSV5jP1sOFQZbqq8dzKWoArqij0HVVX9cCOpnFZGgk5JJcixHcu8epaUQbeYI08/m+11OLo3PuDHZCopSBhysuCYxVV/Flr2SMEVm7V8ZP/8GL67LqKgOkhLA68cJ2wYRTM8ajiL3GTzBWphzhEgZhLEMsR+hm8P1XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=A/WENgJx; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ENYY142903672;
	Thu, 14 May 2026 19:11:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EwBxFjX1eavIj3qPyP
	29Ph8gfareLfDf0+V/+gO2k4k=; b=A/WENgJx0Z3Xn4gFaQXDJBViV+sdb/cGmd
	rp6n67IOmM56E+APhaVVZcGqe1mELqqeHD6oxF0Qql7Ex328NwFCPX5OUiNQqUoJ
	hsStdh4AXJIwd1rXzBHxehnwMdjKBHkVetF//vRWB584bCMIanUhDu1tGxzZsll9
	fLvVnBn515A0XB4NperGkV1hzty1cc9NGHY91pC7nxYG3lHr+D4NHnpQhPaMoJRR
	RieeQE+Pl30Z1mk6Ij8lJb8KFTS6Rvcre8f8pN0R8D4MPKDHl8RFTCIRwC5cuNkR
	YwNlUGbc92v3nsiLj+PsipNwoFEsfvqqrU1hNmUzfRooiZXpOcpQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e5m75j84c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 May 2026 19:11:58 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Fri, 15 May
 2026 02:11:56 +0000
From: Amir Ayupov <aaupov@meta.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@arm.com>, James Clark <james.clark@linaro.org>,
        Leo Yan
	<leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH] perf cs-etm: stamp pid/tid/EL on each buffered packet to fix cross-pid attribution
Date: Thu, 14 May 2026 19:11:34 -0700
Message-ID: <20260515021135.1729028-1-aaupov@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAxOSBTYWx0ZWRfX9hmD7U+wvoDJ
 VaSw4HTnE+2BoRlmvFfInqETYXkdrC4s8TmW3HycNbIBWrSGNXXWSi3LNU9cfmAQKAA2FiydvX1
 OoPVNZM5+mOM5zxP/YqT72GHG7ioA2eokcofmCZ6PqljAxuDMMP8B2UKQOUQICqYgO+SHYh3t1h
 IUfAJLsOayBJKPwraxWF0ZkjXru81P1FpsLuFIWoE2otAnobeBwSaVqQO83Xl7/8ybh4Og01m68
 fE2SKijUwhRNn6jF+5VYl4bH7I4pTdmPo2msP1+QXiTI/p+R5Htp0nejgmVVqbP4nIwC+1+s3N0
 eeTTYo0sZVGWjM8XyR4Ub17++QC4sMfvqIpd7bwsym7m3Yk7Ynci9NzIGm1ZMPN7F1WgjJSsleb
 1pvzLCa6QjFuw3VqXF5QMHk+rRTfihMTfQ4i2gBTrJoKKT3nhHzLsmmf68xbRbnlKlaA7dp2UDZ
 EtO37VzACzKUov2FuMg==
X-Authority-Analysis: v=2.4 cv=GuZyPE1C c=1 sm=1 tr=0 ts=6a0680ee cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VabnemYjAAAA:8
 a=FOH2dFAWAAAA:8 a=oW9o44teytli3FqwapYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: tXaccQsMbZEfzP8b5T8xt9eYVIL6PsGu
X-Proofpoint-ORIG-GUID: tXaccQsMbZEfzP8b5T8xt9eYVIL6PsGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_06,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: E5A45548B11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247311-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaupov@meta.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,meta.com:dkim,sample.pid:url,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In a system-wide `perf record -e cs_etm/.../u` capture on aarch64,
synthesized samples emitted by `perf script --itrace=il64` are
sometimes attributed to the WRONG sample.pid/tid (and to the wrong
EL/cpumode) for the chunk of branches that straddle a context-switch
boundary on a CPU. A branch actually retired by process A is emitted
with sample.pid set to the thread that next ran on the same CPU.

Mechanism:
  1. ETM emits CONTEXTIDR/EL packets in-stream when the kernel updates
     CONTEXTIDR_EL1 on context switch / EL change. OpenCSD turns these
     into OCSD_GEN_TRC_ELEM_PE_CONTEXT elements interleaved with
     OCSD_GEN_TRC_ELEM_INSTR_RANGE elements for retired branch ranges.
  2. cs_etm_decoder__buffer_range() queues each INSTR_RANGE into
     packet_queue->packet_buffer[]; packets carry start/end addrs,
     instr_count, last-instruction info, etc., but NO owner identity.
  3. PE_CONTEXT goes through cs_etm_decoder__set_tid() ->
     cs_etm__set_thread(), which immediately mutates tidq->thread and
     tidq->el. Queued packets are not drained first; reset_timestamp()
     is called so the next TIMESTAMP triggers OCSD_RESP_WAIT and a
     drain.
  4. By drain time in cs_etm__process_traceid_queue() ->
     cs_etm__sample(), sample.pid/tid is read from the now-mutated
     tidq->thread and sample.cpumode from the now-mutated tidq->el.
     Pre-context INSTR_RANGEs get the post-context owner.

The same race affects branch samples via tidq->prev_packet_thread /
tidq->prev_packet_el, captured at packet-swap time from
tidq->thread / tidq->el (which may already have flipped).

This is independent of PERF_RECORD_SWITCH_CPU_WIDE, which is
deliberately not used to assign sample identity in this path. The
bug applies to any cs_etm capture with in-stream CONTEXTIDR
(PIDFMT_CTXTID or PIDFMT_CTXTID2).

Effect on downstream tools: branches that should belong to the
previous thread on the CPU get attributed to the next thread. When
the two threads share a binary, leaked branches' VAs land in the
wrong thread's mappings; samples whose IPs land in r-x mappings
silently pollute that binary's profile, while samples landing in
R-only/RW mappings show up as out-of-range / non-text samples.
Either way, AutoFDO/BOLT profiles built from `perf script --itrace`
output of system-wide cs_etm captures contain misattributed samples.

Concrete example from `perf script --itrace=il64` of the same
captured branch (same timestamp, same IP, same from/to addrs) before
and after this fix:

  before: launcher_multia 2638146/2638146 705897.219172: \
              fffcda6b124c 0xfffcda641958/0xfffcda6b123c
  after:  ws-tcf-sr-io13  2736581/2741587 705897.219172: \
              fffcda6b124c 0xfffcda641958/0xfffcda6b123c

The branch was retired by ws-tcf-sr-io13 (tid 2741587) but, before
the fix, was attributed to launcher_multia (the next thread to run on
that CPU after the context switch). After the fix, it is correctly
attributed to ws-tcf-sr-io13.

Why not "drain on PE_CONTEXT then switch" (deferred-set_thread):
tidq->thread has two consumers \u2014 sample emission needs the OUTGOING
identity for queued packets, but cs_etm__mem_access() needs the
CURRENT thread's maps to fetch instruction bytes for OpenCSD. The
two needs are temporally inverted; a single tidq->thread cannot
serve both. Keeping tidq->thread current and stamping owner identity
per packet is the only design that decouples them cleanly.

Fix: capture the owning pid/tid/EL on each buffered packet at
cs_etm_decoder__buffer_packet() time (before any subsequent
PE_CONTEXT can mutate tidq->thread / tidq->el), and read them at
sample emission time.

  - struct cs_etm_packet gains pid_t pid, pid_t tid, int el (storing
    an ocsd_ex_level value; typed as int so the struct does not
    depend on OpenCSD headers, which are only included inside
    HAVE_CSTRACE_SUPPORT).
  - cs_etm__etmq_get_pid_tid_el() (formerly cs_etm__etmq_get_pid_tid)
    returns all three.
  - cs_etm__synth_instruction_sample() reads sample.pid / sample.tid
    from tidq->packet->{pid,tid} and derives sample.cpumode from
    tidq->packet->el.
  - cs_etm__synth_branch_sample() reads sample.pid / sample.tid /
    cpumode from tidq->prev_packet->{pid,tid,el}.
  - The separate prev_packet_thread / prev_packet_el bookkeeping in
    cs_etm__packet_swap() / cs_etm__init_traceid_queue() /
    cs_etm__free_traceid_queues() is removed; the per-packet stamp
    on prev_packet now carries that information.

Cost: 12 bytes added to struct cs_etm_packet (~12-16 KB per
packet_queue with CS_ETM_PACKET_MAX_BUFFER=1024), 16 bytes saved per
cs_etm_traceid_queue (one struct thread * + one ocsd_ex_level).

A residual gap: cs_etm__copy_insn() reads sample.insn bytes via
cs_etm__mem_access(), which still uses tidq->thread (the current
thread), so the inline insn bytes for an outgoing-thread sample may
be looked up against the wrong address space. Fixing this requires
threading the packet's owner pid through cs_etm__mem_access and is
left for a follow-up. sample.ip / sample.pid attribution \u2014 what
AutoFDO/BOLT consume \u2014 is correct.

A workaround for users on existing perf binaries:
`perf record -p PIDS \u2026` programs the ETM
TRCCONTEXTIDCTLR/TRCVMIDCCTLR registers so the trace stream itself
never carries foreign-PID instructions, eliminating the leak at the
trace source.

Signed-off-by: Amir Ayupov <aaupov@meta.com>
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 12 +++
 tools/perf/util/cs-etm.c                      | 75 +++++++++++++------
 tools/perf/util/cs-etm.h                      | 25 +++++++
 3 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index dee3020ceaa91..ed99dfc7b0f8d 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -402,6 +402,18 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet_queue->packet_buffer[et].flags = 0;
 	packet_queue->packet_buffer[et].exception_number = UINT32_MAX;
 	packet_queue->packet_buffer[et].trace_chan_id = trace_chan_id;
+	/*
+	 * Stamp the owner thread (pid/tid) onto the packet at buffer time.
+	 * A subsequent OCSD_GEN_TRC_ELEM_PE_CONTEXT element will mutate
+	 * tidq->thread before this packet is emitted as a sample; recording
+	 * the identity here keeps each buffered packet correctly attributed
+	 * to the thread that retired its instructions. See
+	 * cs_etm__synth_instruction_sample().
+	 */
+	cs_etm__etmq_get_pid_tid_el(etmq, trace_chan_id,
+				    &packet_queue->packet_buffer[et].pid,
+				    &packet_queue->packet_buffer[et].tid,
+				    &packet_queue->packet_buffer[et].el);
 
 	if (packet_queue->packet_count == CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8a639d2e51a4c..ee3437488b753 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -86,8 +86,6 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
-	struct thread *prev_packet_thread;
-	ocsd_ex_level prev_packet_el;
 	ocsd_ex_level el;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
@@ -614,10 +612,9 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 
 	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
 	tidq->trace_chan_id = trace_chan_id;
-	tidq->el = tidq->prev_packet_el = ocsd_EL_unknown;
+	tidq->el = ocsd_EL_unknown;
 	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
-	tidq->prev_packet_thread = machine__idle_thread(&etm->session->machines.host);
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -740,6 +737,26 @@ struct cs_etm_packet_queue
 	return NULL;
 }
 
+void cs_etm__etmq_get_pid_tid_el(struct cs_etm_queue *etmq, u8 trace_chan_id,
+				 pid_t *pid, pid_t *tid, int *el)
+{
+	struct cs_etm_traceid_queue *tidq;
+
+	*pid = -1;
+	*tid = -1;
+	*el  = ocsd_EL_unknown;
+
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	if (!tidq)
+		return;
+
+	*el = tidq->el;
+	if (tidq->thread) {
+		*pid = thread__pid(tidq->thread);
+		*tid = thread__tid(tidq->thread);
+	}
+}
+
 static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 				struct cs_etm_traceid_queue *tidq)
 {
@@ -748,23 +765,15 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
 	    etm->synth_opts.instructions) {
 		/*
-		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
-		 * the next incoming packet.
-		 *
-		 * Threads and exception levels are also tracked for both the
-		 * previous and current packets. This is because the previous
-		 * packet is used for the 'from' IP for branch samples, so the
-		 * thread at that time must also be assigned to that sample.
-		 * Across discontinuity packets the thread can change, so by
-		 * tracking the thread for the previous packet the branch sample
-		 * will have the correct info.
+		 * Rotate PACKET into PREV_PACKET so the next decoded packet
+		 * lands in PACKET. Owner identity (pid/tid/el) travels with
+		 * the packet itself — it was stamped at
+		 * cs_etm_decoder__buffer_packet() time — so no separate
+		 * thread/EL tracking is needed here.
 		 */
 		tmp = tidq->packet;
 		tidq->packet = tidq->prev_packet;
 		tidq->prev_packet = tmp;
-		tidq->prev_packet_el = tidq->el;
-		thread__put(tidq->prev_packet_thread);
-		tidq->prev_packet_thread = thread__get(tidq->thread);
 	}
 }
 
@@ -938,7 +947,6 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		/* Free this traceid_queue from the array */
 		tidq = etmq->traceid_queues[idx];
 		thread__zput(tidq->thread);
-		thread__zput(tidq->prev_packet_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
@@ -1570,15 +1578,24 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	perf_sample__init(&sample, /*all=*/true);
 	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
+	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr,
+						     (ocsd_ex_level)tidq->packet->el);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = addr;
-	sample.pid = thread__pid(tidq->thread);
-	sample.tid = thread__tid(tidq->thread);
+	/*
+	 * Read pid/tid (and EL above for cpumode) from the packet's
+	 * stamped owner identity rather than tidq->thread / tidq->el,
+	 * which reflect the thread that is current at sample emission
+	 * time. A PE_CONTEXT element delivered between buffer time and
+	 * emit time would otherwise misattribute pre-context packets to
+	 * the next thread/EL on the CPU.
+	 */
+	sample.pid = tidq->packet->pid;
+	sample.tid = tidq->packet->tid;
 	sample.id = etmq->etm->instructions_id;
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
@@ -1586,6 +1603,16 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
+	/*
+	 * Note: cs_etm__copy_insn() reads sample.insn bytes via
+	 * cs_etm__mem_access(), which uses tidq->thread (the *current*
+	 * thread). For samples whose pid/tid were stamped from an
+	 * outgoing thread that has since been replaced by a PE_CONTEXT,
+	 * the inline insn bytes may be looked up against the wrong
+	 * address space. sample.ip / sample.pid attribution is correct;
+	 * fixing the insn bytes requires threading the packet's owner
+	 * pid through cs_etm__mem_access and is left for a follow-up.
+	 */
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
 	if (etm->synth_opts.last_branch)
@@ -1631,15 +1658,15 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip,
-						     tidq->prev_packet_el);
+						     (ocsd_ex_level)tidq->prev_packet->el);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	/* Set time field based on etm auxtrace config. */
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = ip;
-	sample.pid = thread__pid(tidq->prev_packet_thread);
-	sample.tid = thread__tid(tidq->prev_packet_thread);
+	sample.pid = tidq->prev_packet->pid;
+	sample.tid = tidq->prev_packet->tid;
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index aa9bb4a32ecaf..6ba47604b8c52 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -10,6 +10,7 @@
 #include "debug.h"
 #include "util/event.h"
 #include <linux/bits.h>
+#include <sys/types.h>
 
 struct perf_session;
 struct perf_pmu;
@@ -184,6 +185,20 @@ struct cs_etm_packet {
 	u8 last_instr_size;
 	u8 trace_chan_id;
 	int cpu;
+	/*
+	 * Owner identity captured at cs_etm_decoder__buffer_packet() time.
+	 * A subsequent PE_CONTEXT element will mutate tidq->thread/tidq->el
+	 * before this packet is emitted as a sample; stamping pid/tid/el on
+	 * the packet keeps each one attributed to the thread that actually
+	 * retired its instructions and the EL it ran at. Read at sample
+	 * emission time by cs_etm__synth_instruction_sample() and
+	 * cs_etm__synth_branch_sample(). 'el' holds an ocsd_ex_level value
+	 * but is typed as int so the struct does not depend on OpenCSD
+	 * headers (which are only included inside HAVE_CSTRACE_SUPPORT).
+	 */
+	pid_t pid;
+	pid_t tid;
+	int el;
 };
 
 #define CS_ETM_PACKET_MAX_BUFFER 1024
@@ -266,6 +281,16 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 					      u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
+/*
+ * Read the pid/tid/EL currently associated with the given trace_chan_id.
+ * Called from cs_etm_decoder__buffer_packet() to stamp owner identity on
+ * each buffered packet at buffer time, before any subsequent PE_CONTEXT
+ * (CONTEXTIDR / EL change) can mutate tidq->thread / tidq->el. The stamp
+ * is consumed at sample emission time so that each sample is attributed
+ * to the thread/EL that actually retired its instructions.
+ */
+void cs_etm__etmq_get_pid_tid_el(struct cs_etm_queue *etmq, u8 trace_chan_id,
+				 pid_t *pid, pid_t *tid, int *el);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
 				       struct perf_session *session __maybe_unused);
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp);
-- 
2.52.0



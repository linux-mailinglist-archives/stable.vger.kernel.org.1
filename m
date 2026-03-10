Return-Path: <stable+bounces-223851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH4SONHvr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:17:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5112493E9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13E07308D0D6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA744B69C;
	Tue, 10 Mar 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DKl+8A9L"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA243DA2B;
	Tue, 10 Mar 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137674; cv=none; b=iGfEfv8zu7kW6uMsHHlFrCRTh9/HhT+9QZNcMi7MnT6jvH3kXJJBapFFB+cMsc3d8bN3QswToobxVUm013omHiYhrMUmn0LaLjEN8Q4xyaixhUWKo4wGW/MUZ0i0bRE2U9BWlC8Je5AV3zf9LjbcX/BSGEdriXgwaVb2E2SfQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137674; c=relaxed/simple;
	bh=kTvCXDglSMMQvrZ5eq2/6jOsZYTsvbROi36DsOdkY+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=raaMIK1jPswx9HnORLSCU6rW2Q34s6Hhho9jLLN6tirS/ZLcXLNz62cxg74KDQ725NC9eiFKpuPtFsf7YSrsv6GlQvAG6qaCekcQqGr2TBzDd4EMdSlNZUgQpFzyqpgsHnoS+ibxTWX2ua0Id8RRUB0DpH0qxEX7B1bgGKtktMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DKl+8A9L; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=2ku8YpBCRFl5lmli1qzDWV/ZYCmF2JRzCMFWRdL9mEo=; b=DKl+8A9LxG8O/Fvs33AEvVMga8
	0+cJpsQpec2iZXwxjdmvV5zFY/2A+APzzMMcZNWf75R+wi//pU9iy6RijjGAnMtxrM3jLuTnqzuvc
	2YcJiRtmfKlm/ErmBXsFzi0RdTzKKscelN9bceenTvnLUQB2e8lmLvIS5UvM2e49PAPLj5orD6J7B
	ZfHE6mkhQ/Hca97a0SWJ5fE1VKg9YhE0JXo7Rmt3ApHAmqVaDqeC/+s2tTZcomJwT65s6GOMGVOvo
	9UgIdpyzxFqQi2HPV/LwAUuvyo0N8VkgN+fuDa7Y/Xw/OjNDSBjftd6eLuVTV+zVKYe/4t8dxW6Ug
	m5U3Duvw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzu6J-002vDH-Ml; Tue, 10 Mar 2026 10:14:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 10 Mar 2026 03:13:16 -0700
Subject: [PATCH v2] perf/x86: Move event pointer setup earlier in
 x86_pmu_enable()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-perf-v2-1-4a3156fce43c@debian.org>
X-B4-Tracking: v=1; b=H4sIALvur2kC/12NQQ6DIBBFr0JmLQ0DqVVWvUfjAmXQ6UIMWNPGe
 PcGu+vyJ++/t0OmxJTBih0SbZw5zmCFrgQMk5tHkuzBCtBK18qoVi6UggzeaO+UwZtroBKwJAr
 8PjWP7rfzq3/SsJZvISbOa0yfs7Nh4f6UG0qUtcIQ+qvBpjV3Tz27+RLTCN1xHF/jPWCSqwAAA
 A==
X-Change-ID: 20260309-perf-fd32da0317a8
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=4412; i=leitao@debian.org;
 h=from:subject:message-id; bh=kTvCXDglSMMQvrZ5eq2/6jOsZYTsvbROi36DsOdkY+w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpr+7qKzw/BrvD33/WOk0N8nLCfWzEDfTOIrflC
 Vk12NMTFj6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa/u6gAKCRA1o5Of/Hh3
 baDsD/9J5ucGltT5P4ckOvQjyUztdnkI5TLnC/IbwHqM/6F21UMv6nRU7hyOdciptIgaF8PqKvk
 KGRk5RCquq01gBqgufJFkf7De6ArQPbDC3xaty0CjXTFbTEiuskpNxXqNdXjXFTx6Z05nyveL3V
 PYF5hRgNVH8Qj5tKz3cfFpIb/DJWtfuudofFCnG+vLJJlYaHyhSYgpPhKvFMW2YViiiunGlfeq2
 M8DZaNVyVjOARddNX6IhWZWdHPw0S8fUqF/WagyxMv9RRyz32KY6motyByiJtQ1OZe0pQWUo0aO
 y14z2kmcg4OjbjaCrEBejfffhCK4oLJTMbAQfh5SSqzXB0dHE/GspI19cZE5ai2txtsB3sYRfub
 Gcz5QYE8AIjUxDGoZnKonzw39FH81sV/dnY+xaYUp6OEat9rJcoy34RcYcoh9nDUO5JG3KgDQkX
 6Zt8QTqsPA4i+X90xIo1Lup5qx/CbWgquVwHNMkvkeVrZz+4IVV1yJSNWaLrkfMSD+sx50uedTZ
 UmXNUkN8GIRtuY3V6ClUQeMh20fGrcr47JIriaCpX150NlKMalaOOdh8Qc7O0a9g80c/aVp8/sv
 uNf50jL0/cX3dq/lw/JLrI+BYA7Ajon/iSa5mMDOu5U2W0JLF4jRy45y4FgjE6QKnwV/nNo6+LY
 GG6GlCpIm7YbrNw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 5A5112493E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223851-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

A production AMD EPYC system crashed with a NULL pointer dereference
in the PMU NMI handler:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  RIP: x86_perf_event_update+0xc/0xa0
  Call Trace:
   <NMI>
   amd_pmu_v2_handle_irq+0x1a6/0x390
   perf_event_nmi_handler+0x24/0x40

The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
corresponding to the `if (unlikely(!hwc->event_base))` check in
x86_perf_event_update() where hwc = &event->hw and event is NULL.

drgn inspection of the vmcore on CPU 106 showed a mismatch between
cpuc->active_mask and cpuc->events[]:

  active_mask: 0x1e (bits 1, 2, 3, 4)
  events[1]:   0xff1100136cbd4f38  (valid)
  events[2]:   0x0                 (NULL, but active_mask bit 2 set)
  events[3]:   0xff1100076fd2cf38  (valid)
  events[4]:   0xff1100079e990a90  (valid)

The event that should occupy events[2] was found in event_list[2]
with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
(which clears hw.state and sets active_mask) but events[2] was
never populated.

Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
showing it was stopped when the PMU rescheduled events, confirming the
throttle-then-reschedule sequence occurred.

The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
and potential PEBS record loss") which moved the cpuc->events[idx]
assignment out of x86_pmu_start() and into step 2 of x86_pmu_enable(),
after the PERF_HES_ARCH check. This broke any path that calls
pmu->start() without going through x86_pmu_enable() -- specifically
the unthrottle path:

  perf_adjust_freq_unthr_events()
    -> perf_event_unthrottle_group()
      -> perf_event_unthrottle()
        -> event->pmu->start(event, 0)
          -> x86_pmu_start()     // sets active_mask but not events[]

The race sequence is:

  1. A group of perf events overflows, triggering group throttle via
     perf_event_throttle_group(). All events are stopped: active_mask
     bits cleared, events[] preserved (x86_pmu_stop no longer clears
     events[] after commit 7e772a93eb61).

  2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
     due to other scheduling activity. Stopped events that need to
     move counters get PERF_HES_ARCH set and events[old_idx] cleared.
     In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
     to be skipped -- events[new_idx] is never set.

  3. The timer tick unthrottles the group via pmu->start(). Since
     commit 7e772a93eb61 removed the events[] assignment from
     x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
     remains NULL.

  4. A PMC overflow NMI fires. The handler iterates active counters,
     finds active_mask[2] set, reads events[2] which is NULL, and
     crashes dereferencing it.

Move the cpuc->events[hwc->idx] assignment in x86_pmu_enable() to
before the PERF_HES_ARCH check, so that events[] is populated even
for events that are not immediately started. This ensures the
unthrottle path via pmu->start() always finds a valid event pointer.

Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
---
Changes in v2:
- Move event pointer setup earlier in x86_pmu_enable() (peterz)
- Rewrote the patch title, given the new approach
- Link to v1: https://patch.msgid.link/20260309-perf-v1-1-601ffb531893@debian.org
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 03ce1bc7ef2ea..54b4c315d927f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1372,6 +1372,8 @@ static void x86_pmu_enable(struct pmu *pmu)
 			else if (i < n_running)
 				continue;
 
+			cpuc->events[hwc->idx] = event;
+
 			if (hwc->state & PERF_HES_ARCH)
 				continue;
 
@@ -1379,7 +1381,6 @@ static void x86_pmu_enable(struct pmu *pmu)
 			 * if cpuc->enabled = 0, then no wrmsr as
 			 * per x86_pmu_enable_event()
 			 */
-			cpuc->events[hwc->idx] = event;
 			x86_pmu_start(event, PERF_EF_RELOAD);
 		}
 		cpuc->n_added = 0;

---
base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
change-id: 20260309-perf-fd32da0317a8

Best regards,
--  
Breno Leitao <leitao@debian.org>



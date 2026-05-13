Return-Path: <stable+bounces-247054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH/TBngNBWqBRwIAu9opvQ
	(envelope-from <stable+bounces-247054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:47:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329553C1D5
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 111EB302CD32
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 23:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C53CC32B;
	Wed, 13 May 2026 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="q2fHdaNe"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C73C379F;
	Wed, 13 May 2026 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716017; cv=none; b=NCWgg52Oamy/Ln9DYUFucUuKMqrbBH5kWW2ctvxxaDp+JwaNkZDUcjh9hcHI+oZbDtp+LyVY/3doddcpme/O0prwAubmc53pSA56ywRhvCviVOUys7KU4iZaHpASmR0Apga5Jw7vtWVvjF1n7OeSYf9K9jPUXFMT07h/xmoBxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716017; c=relaxed/simple;
	bh=3oQMkvB3FkReZMC7ysGeRCf19BoB6AjENcmXeyYlAGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a51hs0xIiaGKzpOm3m01ZBEc9abKFysQqJImy5hOLZEMzG96jhyv8jhefc8TgUC5nQPRvTtLB0vRbBClqqopAjlU+jyUfr3V9c06UnRVpYHipaWTdb76U60EihCSeSN8d4MZH89Yl4hBb0c5sublriAvidlRwGlDoiSQn5hAOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=q2fHdaNe; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F2BA7C004D01;
	Wed, 13 May 2026 16:46:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F2BA7C004D01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1778716009;
	bh=3oQMkvB3FkReZMC7ysGeRCf19BoB6AjENcmXeyYlAGE=;
	h=From:To:Cc:Subject:Date:From;
	b=q2fHdaNedi5Oh8aEfHcssLEMTnbkmBYbCvpOXQUzCzONEK5ZAqRR0C0cVlXutNpZf
	 3IDH/eS685AXN9E0TurmQ/ivoVuNWSu8cllP/G5V/us0ulaLPuaxw3peXjBdDvx2Wn
	 ulY3KK0Rq3JnUA0nLx6CUDc6qzctKliMYAKtsYVo=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id E9E59AE80;
	Wed, 13 May 2026 19:46:47 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Markus Mayer <mmayer@broadcom.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH stable 7.0] perf build: fix "argument list too long" in second location
Date: Wed, 13 May 2026 16:46:38 -0700
Message-Id: <20260513234639.128528-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8329553C1D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247054-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Action: no action

From: Markus Mayer <mmayer@broadcom.com>

commit 97ab89686a9e5d087042dbe73604a32b3de72653 upstream

Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
shell and cause it to display "argument list too long".

Trying to quote $^ doesn't help.

In the end, *not* displaying the (potentially long) list of files is
probably the right thing to do for a "quiet" message, anyway. Instead,
let's display a count of how many files were removed. There is always
V=1 if more detail is required.

  TEST    linux/tools/perf/pmu-events/metric_test.log
  RM      ...634 orphan file(s)...
  LD      linux/tools/perf/util/perf-util-in.o

Also move the comment regarding xargs before the rule, so it doesn't
show up in the build output.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/pmu-events/Build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc5f94862a3b..dc1df2d57ddc 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
 
 # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
 # of a build step.
-quiet_cmd_rm  = RM      $^
+quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
 
+# The list of files can be long. Use xargs to prevent issues.
 prune_orphans: $(ORPHAN_FILES)
-	# The list of files can be long. Use xargs to prevent issues.
 	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
 
 JEVENTS_DEPS += prune_orphans
-- 
2.34.1



Return-Path: <stable+bounces-220086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOKAJ1wno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3741C4F02
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA6630C2EC2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F90325714;
	Sat, 28 Feb 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzhBQx2y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBE343D7B;
	Sat, 28 Feb 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299979; cv=none; b=Likia65YzqdDZzDwiwt3hyk9O6riC1d4RHp7q8YMONdAR8CR/ufzb6j+O944dYkLsmIurnMKqFYMi8moTr576mkAuvyk2c4dUYY9RLwcRIrT8SoD0m3uDSB7Btevx1DEU5UWFNJRfB4rYQ5FsGhxlAmDqk/vryGzkfPy3tgHthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299979; c=relaxed/simple;
	bh=JXmZxW8aypecdTK3JC3PR3n01rbBlYd6dg87U+ITZNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK4OaiUFATde+YmacT6Oj5HQJ9HrMOfaWiOYDFMR1Mt5IAIA3vDJBuQXv8InZ/+BFAb7WN4ufMnchSL7Fwvm/bTI+UH9Qr7VaxGuUjjpEjAxYqXM8lAXgz9igLBoeaZcM78QqFrNBTwHONOahN/Wac1T5fkyM5a2BhTaqWPh368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzhBQx2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B20C116D0;
	Sat, 28 Feb 2026 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299979;
	bh=JXmZxW8aypecdTK3JC3PR3n01rbBlYd6dg87U+ITZNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzhBQx2yELtticJs3v9P1FKRKIFrIHYpBTm9k+2Kdot6KblfAkC50OIBfjZhTnsbh
	 SmKRR5ls9B5IWfoRhJFVNbb+zjjlgQfwJV0PHV2rVK3xWGObEaRErUeWUlGK1lvi63
	 Q4RgQIHBWoMPlrLVmjdUQLyYE18bzKeEXANwvDd3fcCEM5MB1fEmXqfeDS5TrsH2du
	 SAYk4joMn2btTq/QLvLp/w8xKhCmQD/rQf4hdxU+Uu8AkmyqkiTsnj1FX6Bi/RKfBa
	 y/QkEeTMTAKmDjE4SO5opWFmpVSu6pjQCVXjdVzR9ixn58QJW8g84aXhPt4l6LZMq8
	 8qeMGkpkEJpRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Tony Jones <tonyj@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 008/844] perf callchain: Fix srcline printing with inlines
Date: Sat, 28 Feb 2026 12:18:41 -0500
Message-ID: <20260228173244.1509663-9-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linaro.org,intel.com,linux.intel.com,gmail.com,redhat.com,kernel.org,infradead.org,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220086-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,oracle.com:email,infradead.org:email,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: 0E3741C4F02
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit abec464767b5d26f0612250d511c18f420826ca1 ]

sample__fprintf_callchain() was using map__fprintf_srcline() which won't
report inline line numbers.

Fix by using the srcline from the callchain and falling back to the map
variant.

Fixes: 25da4fab5f66e659 ("perf evsel: Move fprintf methods to separate source file")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Tony Jones <tonyj@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/evsel_fprintf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 10f1a03c28601..5521d00bff2c0 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -185,8 +185,12 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_dso && (!sym || !sym->inlined))
 				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
 
-			if (print_srcline)
-				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			if (print_srcline) {
+				if (node->srcline)
+					printed += fprintf(fp, "\n  %s", node->srcline);
+				else
+					printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+			}
 
 			if (sym && sym->inlined)
 				printed += fprintf(fp, " (inlined)");
-- 
2.51.0



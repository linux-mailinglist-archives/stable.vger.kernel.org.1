Return-Path: <stable+bounces-220095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCmqJpsno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414021C4F3C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B810309ACAC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E9353EC8;
	Sat, 28 Feb 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZpe8fi2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698B352F86;
	Sat, 28 Feb 2026 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299998; cv=none; b=DwhElVWnK65T3mvw+QOoUwaklEtbFrDFK1mnHVxh738hINXirUBz2eOWbRyGQ+tONAOuee4fBYHjROVtfxIr5QePPTgndnpuV1sx/QXATFXFJIza/XIXzF4ZJ+WhO8e8E4PN7o2BvFfbZ5K8mvsypOChZq0KPLFquVSyE2czFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299998; c=relaxed/simple;
	bh=eW4hqNf92B1OlhPszuKg7mUbAKWHuynd9my3GOZaESQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYuctf1Ic7mk+AwIUd7ZaXxpe1cyavm2plmJeExLTKsyex5Vj6YVD9BCMB5d+8JhlquZ6ORW+wE/QTYCL1vANdklfas0N9p2j/bwzWfgksvEzf4GNaS1AQYO1dDEWYbPsN6kvx1vtm1CR+dOh08uCllthLckZlEsU0ASkH9uq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZpe8fi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370E6C19424;
	Sat, 28 Feb 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299998;
	bh=eW4hqNf92B1OlhPszuKg7mUbAKWHuynd9my3GOZaESQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZpe8fi2idn1DMWv49MUB64B0lYl2OgIrQVSCyzFTElhHhIHsHzf8F0ghPMD12Wvd
	 Y8S9vM0rFYJh0Ld65ohDZp3NVGZqVW0+fIDwl7iqQBjjuG31JuANsvdCHFrLb490J5
	 HK6nAm1fqf5LVws3ZLkMm4r67q590ysQ29aoLMS4QbGzdsHKW4nvKozaeDZNqt2jmC
	 ZWCXZeyHa2B44X2MfFaqvDO4KpfpqALgfVRpRqa8Tjnp/FeI4q2rDRy5/AP4tCp1Tq
	 LP+uXD7zmEp4HDupAen+Jv/WF1c5a1V+gd+BvLPpU65D85Y2TI/CnxNnPGeYSym2cy
	 J2wwkn81slT1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Bill Wendling <morbo@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Guo Ren <guoren@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Krzysztof=20=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergei Trofimovich <slyich@gmail.com>,
	Shimin Guo <shimin.guo@skydio.com>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Tianyou Li <tianyou.li@intel.com>,
	Will Deacon <will@kernel.org>,
	Zecheng Li <zecheng@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 017/844] perf maps: Fix reference count leak in maps__find_ams()
Date: Sat, 28 Feb 2026 12:18:50 -0500
Message-ID: <20260228173244.1509663-18-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220095-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,linaro.org,linux.ibm.com,intel.com,eecs.berkeley.edu,linux.intel.com,ghiti.fr,treblig.org,kernel.org,gmail.com,redhat.com,oracle.com,inria.fr,linux.dev,dabbelt.com,infradead.org,skydio.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 414021C4F3C
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 6fdd2676db55b503c52dd3f1359b5c57f774ab75 ]

ams and so ams->ms.map is an in argument, however, it is also
overwritten. As a map is reference counted, ensure a map__put() is done
before overwriting it.

Fixes: 42fd623b58dbcc48 ("perf maps: Get map before returning in maps__find")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Aditya Bodkhe <aditya.b1@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Dr. David Alan Gilbert <linux@treblig.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Krzysztof Łopatowski <krzysztof.m.lopatowski@gmail.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergei Trofimovich <slyich@gmail.com>
Cc: Shimin Guo <shimin.guo@skydio.com>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Cc: Tianyou Li <tianyou.li@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Zecheng Li <zecheng@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index c321d4f4d8466..8885c95f02b3e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -676,6 +676,7 @@ int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
 	if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
 		if (maps == NULL)
 			return -1;
+		map__put(ams->ms.map);
 		ams->ms.map = maps__find(maps, ams->addr);
 		if (ams->ms.map == NULL)
 			return -1;
-- 
2.51.0



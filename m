Return-Path: <stable+bounces-220090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKHBK8Yno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 638251C4F7A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4471930EF33E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4733D4FE;
	Sat, 28 Feb 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbTNd6/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA3338596;
	Sat, 28 Feb 2026 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299986; cv=none; b=ZZ9PZYJqwTikxaY1Fy+WIQeoEVpiLdidisclSe5OVBx8DNONo10qA8ZD8kR8Q/wx7A5hDjYN2SCp43ztSxUSq24pl3CdaQ+CwgidNFWganzljQHgUdsLox6fnVqwkzb9QUlwQzwf/nMAC6YgSOD9CgC+X1qnM+lL24II1HYk94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299986; c=relaxed/simple;
	bh=X2/vC+9xwl0u42CuSal+ggvMlJF6drvzSnUvW3RqSrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R55K15i6V/16h1czstlwrEeMZjX3SkxOBpYro3ucATZm+bfIlwQiO8IcYLOEA11NNE3DUuK+bNww8xjYA5T4TSeINOU3Q1woLwJ/FIxxzSJbOhuLKE8jRZ0pnJfNns+voSG0Jd3GZDJb6iHWUUeXcNaVab/CRz6fHnzRXnF1hGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbTNd6/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1166FC116D0;
	Sat, 28 Feb 2026 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299986;
	bh=X2/vC+9xwl0u42CuSal+ggvMlJF6drvzSnUvW3RqSrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbTNd6/W8P//B6B7e7K4Rf94LHASkv4Cj5l18taFX3FCjN59C/P/qy3b/pqWL8yrH
	 TQonB268XY7jR0SZUqp8B/lzRUEloow4GGG3P34TO258Ac4KQtzVsh5rQfv8Sx+DlL
	 zspLBcyWYFr7rMZfC3HkAeof0XyepYc+DEjfqOhoei/fiUI0SYr8wPuGSehfv0sBN8
	 pjNI5yx4uYlglv22KT8ANE3/AOFsAZHp+vPMpgP+V0IUbVH33/i/FQH7BElYfDAuNt
	 0hsVgh/MS5ISLlG7oXtehCebqyVNymLsbhyF0+1OeLQ0ixqJ3wcTLoY9Y5OD50vrHb
	 wN0b9HsLdogDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Guo Ren <guoren@kernel.org>,
	Haibo Xu <haibo1.xu@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	=?UTF-8?q?Krzysztof=20=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Wielaard <mark@klomp.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergei Trofimovich <slyich@gmail.com>,
	Shimin Guo <shimin.guo@skydio.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 012/844] perf symbol-elf: Fix leak of ELF files with GNU debugdata
Date: Sat, 28 Feb 2026 12:18:45 -0500
Message-ID: <20260228173244.1509663-13-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220090-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,intel.com,eecs.berkeley.edu,ghiti.fr,linux.intel.com,treblig.org,kernel.org,gmail.com,redhat.com,linaro.org,oracle.com,linux.dev,klomp.org,dabbelt.com,infradead.org,skydio.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 638251C4F7A
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 92d65d9c31621befe0a5f7c0bd43bd217613c6b6 ]

The processing of DSO_BINARY_TYPE__GNU_DEBUGDATA in symsrc__init happens
with an open ELF file but the error path only closes the associate fd.

Fix the goto so that the ELF file is also ended and memory released.

Fixes: b10f74308e130527 ("perf symbol: Support .gnu_debugdata for symbols")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Aditya Bodkhe <aditya.b1@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Dr. David Alan Gilbert <linux@treblig.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Haibo Xu <haibo1.xu@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Krzysztof Łopatowski <krzysztof.m.lopatowski@gmail.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Mark Wielaard <mark@klomp.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergei Trofimovich <slyich@gmail.com>
Cc: Shimin Guo <shimin.guo@skydio.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index d1dcafa4b3b80..439f252937b89 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1173,7 +1173,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		Elf *embedded = read_gnu_debugdata(dso, elf, name, &new_fd);
 
 		if (!embedded)
-			goto out_close;
+			goto out_elf_end;
 
 		elf_end(elf);
 		close(fd);
-- 
2.51.0



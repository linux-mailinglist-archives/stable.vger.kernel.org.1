Return-Path: <stable+bounces-113132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD5A2901D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D926B1883872
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFD155CBD;
	Wed,  5 Feb 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avhk+v+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B2487BF;
	Wed,  5 Feb 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765929; cv=none; b=pq+Zgm3dnBdH8GkhRw28i+1pLdaK29cY6eiFBx9fk5sBDroNFRz4GEXGLBXWCflC0OR+LW7QkbYAT2jdfmClcGcJheskImpk8SFvSdRb7GlliH/JSJD3vezQulol/SgsFCvkvqr9DAmjh5+RzKWkq+dkSrUpAJWwGdA1qU0UXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765929; c=relaxed/simple;
	bh=bEQlQnZeCGybdHrWxr40hLZnQ9EfGW0UA40iVN3ofyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjos+d5OCrkf1KGyUlLXrfR5ORSpHnlATct+5mvCPMqhGJx55bc6W/qMH1+rRYOOuGnVcsE3GqqW2L4lmgqmXyK8smiLXst1GzwyjhBxSdNwQ+O1NXjFA/ivF1OFE7oZ3cfmrUxStqusRT0YtmFqnUwZTjdX3i7ax3EDJdIn8i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avhk+v+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2635EC4CED1;
	Wed,  5 Feb 2025 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765928;
	bh=bEQlQnZeCGybdHrWxr40hLZnQ9EfGW0UA40iVN3ofyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avhk+v+AiCUMzixr1aqGYlfhRz9jRLIbELBASvReZgXEVTwzIMDV9lu7a/JRJHmVs
	 pGWxLWuqTKbw5VR/XcI75g6JOeFDQpkadb48+nwFp/b55uI76LktALDsNdur/gx0ZE
	 MPXnG5FJ879tX5/h7kvlGEIzaOLVxcw9O2pVyqx8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 268/590] perf top: Dont complain about lack of vmlinux when not resolving some kernel samples
Date: Wed,  5 Feb 2025 14:40:23 +0100
Message-ID: <20250205134505.527447357@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 058b38ccd2af9e5c95590b018e8425fa148d7aca ]

Recently we got a case where a kernel sample wasn't being resolved due
to a bug that was not setting the end address on kernel functions
implemented in assembly (see Link: tag), and then those were not being
found by machine__resolve() -> map__find_symbol().

So we ended up with:

  # perf top --stdio
  PerfTop: 0 irqs/s  kernel: 0%  exact: 0% lost: 0/0 drop: 0/0 [cycles/P]
  -----------------------------------------------------------------------

  Warning:
  A vmlinux file was not found.
  Kernel samples will not be resolved.
  ^Z
  [1]+  Stopped                 perf top --stdio
  #

But then resolving all other kernel symbols.

So just fixup the logic to only print that warning when there are no
symbols in the kernel map.

Fixes: d88205db9caa0e9d ("perf dso: Add dso__has_symbols() method")
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/lkml/Z3buKhcCsZi3_aGb@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 724a793863212..ca3e8eca6610e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -809,7 +809,7 @@ static void perf_event__process_sample(const struct perf_tool *tool,
 		 * invalid --vmlinux ;-)
 		 */
 		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
-		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
+		    __map__is_kernel(al.map) && !map__has_symbols(al.map)) {
 			if (symbol_conf.vmlinux_name) {
 				char serr[256];
 
-- 
2.39.5





Return-Path: <stable+bounces-97805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4189E2616
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F92416491A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B61F7561;
	Tue,  3 Dec 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KoH9Bjnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6823CE;
	Tue,  3 Dec 2024 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241790; cv=none; b=HK8SUEmmYsXFx7Y0carfBplkHRoeKoL21MEe16PHbFKrumGY1K8pYGafkEqx5dceYIo7nU+zXU2xwBlzZgpbTnjidWe6NSIjIWGzGfAt7YqTBvx8CoBmUHbsYj19jPbeLr86CmklAD4RicRyq/KQQUHycyLruBVbYg47rD097ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241790; c=relaxed/simple;
	bh=MTbmb9oRf9jBx9wozJb2hest0lu48vf3No9exIRhmco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8dpZt+usqt9F9yo66faUd10NHWBv/+nnwqJxxMYFGEvf/oup0+r8LbluxrbwELDGWDuoij2/Fh8n04+6H/JaBO5+pt1EFmbhPNzbaBO2V9Jc+lnPn+AbXfqgsoegwM6yGUV1CEfqpiAgruXOpcF6KmKtBjJhzy0/zUXmOySrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KoH9Bjnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3992FC4CECF;
	Tue,  3 Dec 2024 16:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241790;
	bh=MTbmb9oRf9jBx9wozJb2hest0lu48vf3No9exIRhmco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoH9BjnwoJ00AkicPi4MtRqX4WVES3vzcgn/jRk3Lq6hTh9Fyy9Ny+2ESE+i1pDWz
	 5ogQvNkzVTYu0dFTtwVNScZW7tfmtHoXvFe6h2mhAXi58qHOLfPo1YEBWiEkPQlSQN
	 HdZXwg6mPGgYftYvGAdSkajKHLEiunEnRspgAnkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Peterson <benjamin@engflow.com>,
	Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 510/826] perf trace: avoid garbage when not printing a trace events arguments
Date: Tue,  3 Dec 2024 15:43:57 +0100
Message-ID: <20241203144803.651453693@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Benjamin Peterson <benjamin@engflow.com>

[ Upstream commit 5fb8e56542a3cf469fdf25d77f50e21cbff3ae7e ]

trace__fprintf_tp_fields may not print any tracepoint arguments. E.g., if the
argument values are all zero. Previously, this would result in a totally
uninitialized buffer being passed to fprintf, which could lead to garbage on the
console. Fix the problem by passing the number of initialized bytes fprintf.

Fixes: f11b2803bb88 ("perf trace: Allow choosing how to augment the tracepoint arguments")
Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
Tested-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20241103204816.7834-1-benjamin@engflow.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4cc942f7fec7d..4f47fe3b211d9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3087,7 +3087,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%s", bf);
+	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
-- 
2.43.0





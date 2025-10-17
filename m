Return-Path: <stable+bounces-186759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94931BE99FC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 397E135D33C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EB3328F0;
	Fri, 17 Oct 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbOVjdTV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648E3328E9;
	Fri, 17 Oct 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714155; cv=none; b=OxrT9I1u9Kzlavi9cktsXLiHX+DGUuIMZtB6r3DUsn4Ot6+xWtTdwlkVHlslyybXA9qjtpoQPlLls6o/964rbVZmUfBTQj1XcqAXyArEmEJEQ7JHg9rEaZykutHHSi27pUkNqw1YiSzFlHzw2dmS6FSsfkAvovimsTqn92FwLEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714155; c=relaxed/simple;
	bh=BVHcLPYGokpV+gH5NixyWuq47mSQyr/S1Rj+RkPgePg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJNHvxzyxJERajAv7lun0ymQjAhafhGESX/CYx+kLmWGzBwHohBGb36FYgxUfsF0BxUWKUzGv+4SCjAEd+xaW9mGmXbb1U3Ouma00ZC67gL3vMbmxPDHmEAAW3yOtN3eBLBZOyPECiMhtz78BiEYhArmuZmP51G9fNc06LUNvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbOVjdTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58147C4CEE7;
	Fri, 17 Oct 2025 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714155;
	bh=BVHcLPYGokpV+gH5NixyWuq47mSQyr/S1Rj+RkPgePg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbOVjdTVkbDLey04DSkc3JEahhX4Sn6C9uzUdzwUJrDRCzhlJ5IIWTOQfnlZBPYXr
	 hJTaa+He1u/MMefir/U0Z7WozyoeKrxdt4Gi4LibSta1j6UbnjqqfhCUHr6qF2vo2m
	 BtdYLvCB5/HZopc7i2+w03er3wuhTai2OMST0ftw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/277] perf session: Fix handling when buffer exceeds 2 GiB
Date: Fri, 17 Oct 2025 16:50:36 +0200
Message-ID: <20251017145148.211708753@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leo Yan <leo.yan@arm.com>

[ Upstream commit c17dda8013495d8132c976cbf349be9949d0fbd1 ]

If a user specifies an AUX buffer larger than 2 GiB, the returned size
may exceed 0x80000000. Since the err variable is defined as a signed
32-bit integer, such a value overflows and becomes negative.

As a result, the perf record command reports an error:

  0x146e8 [0x30]: failed to process type: 71 [Unknown error 183711232]

Change the type of the err variable to a signed 64-bit integer to
accommodate large buffer sizes correctly.

Fixes: d5652d865ea734a1 ("perf session: Add ability to skip 4GiB or more")
Reported-by: Tamas Zsoldos <tamas.zsoldos@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20250808-perf_fix_big_buffer_size-v1-1-45f45444a9a4@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbaf07bf6c5fb..89e5354fa094c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1371,7 +1371,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	struct perf_sample sample = { .time = 0, };
 	int fd = perf_data__fd(session->data);
-	int err;
+	s64 err;
 
 	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
 		dump_event(session->evlist, event, file_offset, &sample, file_path);
-- 
2.51.0





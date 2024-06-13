Return-Path: <stable+bounces-50630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50116906B9E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAD01F21A67
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AB8DDB1;
	Thu, 13 Jun 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYCwpDYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9114389F;
	Thu, 13 Jun 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278929; cv=none; b=EhWKkMcJPhBaRHcIBlWsUiMCCzXH35VRiP89/sHojXjTaZaPwmH59PWq1dHK6kjFNT6K9hh0LwghEiBM9AEsDg8Ffj5+WDQhNNzPsHfkKAtWyV4uq6cjcW94mEtoxrAdIkwujDHnD3LPGOpwYui3HY0tuAzVLwFjjwak0WBt1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278929; c=relaxed/simple;
	bh=nIRuTaYYm93QeyJhJv1kyNWfbuh7i9NIHIXdqMWETsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpmgL1p5R/B8askblkj1vDFdfx/uW7bXZw3WUTpcGCkDUw5q6cXJw3+DAQqHZO3Eq1LElE8zJ2OQvaa/xyhfdaapDU1BS4Mln+/ndr7tgjf9WkBwlwIQDVl9AR1DzkEvEj4DmQXnxi7pPS+Mq2WsY3l8eHapeclLvLHYFkyb2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYCwpDYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EE9C2BBFC;
	Thu, 13 Jun 2024 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278929;
	bh=nIRuTaYYm93QeyJhJv1kyNWfbuh7i9NIHIXdqMWETsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYCwpDYcAC5IQLuCnFeod5qG4HpcgUOEvo3y7SpaGj3Y7daOmmfYGhp93fixYyB3Q
	 xESDTrSstT/QgGtkkUr/R0EvktG62/Wr9cF8Y3/oYDTs04ds86DcIxCdBMoq4ytncU
	 2MdVRKHQDHQY6Of21BksXSyQP396+rDVeBhB6MUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/213] perf probe: Add missing libgen.h header needed for using basename()
Date: Thu, 13 Jun 2024 13:32:15 +0200
Message-ID: <20240613113231.366016926@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 581037151910126a7934e369e4b6ac70eda9a703 ]

This prototype is obtained indirectly, by luck, from some other header
in probe-event.c in most systems, but recently exploded on alpine:edge:

   8    13.39 alpine:edge                   : FAIL gcc version 13.2.1 20240309 (Alpine 13.2.1_git20240309)
    util/probe-event.c: In function 'convert_exec_to_group':
    util/probe-event.c:225:16: error: implicit declaration of function 'basename' [-Werror=implicit-function-declaration]
      225 |         ptr1 = basename(exec_copy);
          |                ^~~~~~~~
    util/probe-event.c:225:14: error: assignment to 'char *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
      225 |         ptr1 = basename(exec_copy);
          |              ^
    cc1: all warnings being treated as errors
    make[3]: *** [/git/perf-6.8.0/tools/build/Makefile.build:158: util] Error 2

Fix it by adding the libgen.h header where basename() is prototyped.

Fixes: fb7345bbf7fad9bf ("perf probe: Support basic dwarf-based operations on uprobe events")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/probe-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 4aeb3e1399010..c4c72d5c82ccc 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -25,6 +25,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
-- 
2.43.0





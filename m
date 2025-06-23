Return-Path: <stable+bounces-156225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98ABAE4EB2
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D73717D465
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969B221FBF;
	Mon, 23 Jun 2025 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y473fBmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9431ACEDA;
	Mon, 23 Jun 2025 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712889; cv=none; b=J0esm5EvsluOgB/9anAoHwvAj8jx0VLAa1O+LGSt70ViEJMxw+xKCNv9KDVD7KMCKE421a3QpzrwLTNksi9zPHdN+o9Cas+FPr/ClwWjDoQRpuVmBdogGAPNfvyzZmvWeATAKGAAJiwMzXbO9sPwJHhJnZjs/jFRIaQjNFnN0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712889; c=relaxed/simple;
	bh=0R/rGtOUOLw60ntKXIcdHRg9qQT2/q58xHcjVyikjrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJBNoPQeCwShFMkCo/6cwJ7RTgHo7RD1eJSmu29FXI2AOq0lgOsMKKjSj36olOQBfcUfD5lm5zwJzMbkLNavYrBBjDiAhjBhwX0Kz3DYFfwKVPKhMGuF+7Hdb8e247I9vVspsvom2LzUP6YQfa+tO352/yuXW8NM8R5XTDs5uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y473fBmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E752C4CEED;
	Mon, 23 Jun 2025 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712888;
	bh=0R/rGtOUOLw60ntKXIcdHRg9qQT2/q58xHcjVyikjrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y473fBmEpeszXUI3nEwltrHsmbFQsDzfLpJx4XAvqdksjh2oURNNLGarIFKJox7wL
	 LAbT8SJwSS/AFzTG11V5tByfTLdaUJnAe3m30SQy6zpL/hxThk3m7DFNnyTsgOU0mX
	 saoiuC02l+Zw+OUm0m4h1IZUv0BHJg3W9jfZ+N1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Tony Jones <tonyj@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 094/411] perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3
Date: Mon, 23 Jun 2025 15:03:58 +0200
Message-ID: <20250623130635.832167216@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 17e548405a81665fd14cee960db7d093d1396400 ]

The script allows the user to enter patterns to find symbols.

The pattern matching characters are converted for use in SQL.

For PostgreSQL the conversion involves using the Python maketrans()
method which is slightly different in Python 3 compared with Python 2.

Fix to work in Python 3.

Fixes: beda0e725e5f06ac ("perf script python: Add Python3 support to exported-sql-viewer.py")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Jones <tonyj@suse.de>
Link: https://lore.kernel.org/r/20250512093932.79854-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 13f2d8a816109..99742013676b3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -680,7 +680,10 @@ class CallGraphModelBase(TreeModel):
 				s = value.replace("%", "\%")
 				s = s.replace("_", "\_")
 				# Translate * and ? into SQL LIKE pattern characters % and _
-				trans = string.maketrans("*?", "%_")
+				if sys.version_info[0] == 3:
+					trans = str.maketrans("*?", "%_")
+				else:
+					trans = string.maketrans("*?", "%_")
 				match = " LIKE '" + str(s).translate(trans) + "'"
 			else:
 				match = " GLOB '" + str(value) + "'"
-- 
2.39.5





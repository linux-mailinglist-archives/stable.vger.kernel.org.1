Return-Path: <stable+bounces-156687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE896AE50AC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EC87AAB9C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20E2236E9;
	Mon, 23 Jun 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JMit5sfJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CD222582;
	Mon, 23 Jun 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714023; cv=none; b=SBmq2wD/mpH9pHMKfKjMm7RLNetnOVRX3GqhzaHkPuRnOJVbAN0iYl0Xmjy08onSXCwWu767rMNSfABtxQpxURMgIPdK9Q40FHSidVPYgAqmzmFxq3UYHVo/Ziq0aGoptvhDhukIdQEGPQfUZuJQ/soDd8kXRL+fNU5B8LEYLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714023; c=relaxed/simple;
	bh=dBelJU5cKbSVEJSJ5IYiTlNQMvU2z3IpVHm2L00YJIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpdb0MKTU6xbU991bFXaFQCzB9ZUh3WG5Mu/0kvCGEeLHKDkm+jTovHH/bfCQX3arRpR1IbPb0FXmctvXSpw/r2l8QzZgGbACJUcebJ/NifkufDxDDR58lG+qedXCogWWXwhp7SPHl26meAWFb8dT3Lk7EeSdvAdr1Lgq0XvH48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JMit5sfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFFC4CEEA;
	Mon, 23 Jun 2025 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714023;
	bh=dBelJU5cKbSVEJSJ5IYiTlNQMvU2z3IpVHm2L00YJIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMit5sfJaeQ3aJ4e1OeAi2/ZK1UYCC99CowjbbNKizF6zKFTQrrx43bJscsg9t/+B
	 Spi6lSf8fPZu48wpK5MRlxs46+20gAyRicgjaskE7yJtsTc4FOB3S2n0DlKENlJQmr
	 EF3Ih91sh/qtDr+eWLLeQu97O0IMF8VffPZmtg2g=
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
Subject: [PATCH 6.1 140/508] perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3
Date: Mon, 23 Jun 2025 15:03:05 +0200
Message-ID: <20250623130648.732031054@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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





Return-Path: <stable+bounces-153754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E13ADD652
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5CF16AD0A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F992E8DFB;
	Tue, 17 Jun 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VAsmVU5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC2188006;
	Tue, 17 Jun 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176992; cv=none; b=eeka1DItlBM/JHIRuoJXe3UR0TmwtDDwnBSdIPzxAM1YfWZ12xG0s74l1zrTan5XwSK0l1nQz4NNAvKuT+spHN5r1qQx/FyBkhv2cEme4RBHca1RjnQAzrSOFuI5ML+x6kcr8wCBAg0WuL7I97GtXTbokNb2DtsHf2rse9FdDGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176992; c=relaxed/simple;
	bh=GyPi8rt8FHLz55kILKNJZM43SETKYenr3K6n0/SrXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcjDfRhqmMssg5dyal9MWz0sn0Jw1EqspaYV5RwPrAMGDJpsemcpCPXdGES/t2UGNvK6XWBkLljRoYp6dapU9ntNulfjh15yYYVYhUfBD9hi8EztoKIhe6JxCaz3WQiOBF19u7MmMdc6lvONp04KDXVQbBtDzR0UYYLd171KjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VAsmVU5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D06C4CEE3;
	Tue, 17 Jun 2025 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176991;
	bh=GyPi8rt8FHLz55kILKNJZM43SETKYenr3K6n0/SrXXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAsmVU5Rw42ZQ1gCZDWXQWiQPRTpos1bYQXVuVvKYhJ38e9nM9svjFF+jz1AHWusn
	 iMW/KnSz1c6LSg2+yffVw6iGdZgFQlvZrUHa1meOnwRbg1u8Wvha2BMoffBBlouKv1
	 r7ihCuMYKt8SCtFhu/JavHa2K92InFswuXl3qckc=
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
Subject: [PATCH 6.12 286/512] perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3
Date: Tue, 17 Jun 2025 17:24:12 +0200
Message-ID: <20250617152431.182304936@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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
index 121cf61ba1b34..e0b2e7268ef68 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -680,7 +680,10 @@ class CallGraphModelBase(TreeModel):
 				s = value.replace("%", "\\%")
 				s = s.replace("_", "\\_")
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





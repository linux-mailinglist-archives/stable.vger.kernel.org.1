Return-Path: <stable+bounces-131483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D6A809DB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 007957B4400
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC727BF84;
	Tue,  8 Apr 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcLmGr18"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4527BF7E;
	Tue,  8 Apr 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116522; cv=none; b=Xm1x4EIiwKN/o7Yp9JkEyH4b/SaPjLbxkyOh+5eZy+rnJOnwYxnGXjDUYrHD26AuLBEeJ6QGxqlBu2AszNke5aD8QNSD2yAHB8vGcZFkIeI85PQOfnjgwN1pUCBK5K+Y522rQR8vtlHaqwGG4WY4Fz23eDNOOLR5M864M8N5+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116522; c=relaxed/simple;
	bh=iQg2dHmwDanPlu6RS6vd6OrHZZA4++d/rleIKoIjvz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXdULIncWXZ2ECBJTukgXyDlbjq5GsnHlwuhRz0cWDgaLa9h5qCS20gBByz17DR/SOsFEMY1X8JNbdgAax2rm2cLJwKfd4++w9B51NC5ftjMe81D+aGr0aMuCm8PkvalOguKXQJBRSSJKHE5Q+XEJuYJ+J41TPSdjY8sSSbBRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VcLmGr18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64942C4CEEA;
	Tue,  8 Apr 2025 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116521;
	bh=iQg2dHmwDanPlu6RS6vd6OrHZZA4++d/rleIKoIjvz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcLmGr18hz6YFuCDANb/+0ijZd28eiMSTnUlRxIPQhcE2JB3pOHumqNauof5hq4fO
	 ROnzftlE4/UkL7ZMTOXha2GP1oYXKtO6zitCTb+sONUVHKba8Es0KRm3zd4FqHCuJb
	 TLkZ2MQqG81agutB+Iahve9AX9Zo+lzBskPUrozM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 169/423] perf report: Switch data file correctly in TUI
Date: Tue,  8 Apr 2025 12:48:15 +0200
Message-ID: <20250408104849.678267835@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 43c2b6139b188d8a756130147f7efd5ddf99f88d ]

The 's' key is to switch to a new data file and load the data in the
same window.  The switch_data_file() will show a popup menu to select
which data file user wants and update the 'input_name' global variable.

But in the cmd_report(), it didn't update the data.path using the new
'input_name' and keep usng the old file.  This is fairly an old bug and
I assume people don't use this feature much. :)

Link: https://lore.kernel.org/r/20250211060745.294289-1-namhyung@kernel.org
Closes: https://lore.kernel.org/linux-perf-users/89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org
Fixes: f5fc14124c5cefdd ("perf tools: Add data object to handle perf data file")
Reported-by: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 645deec294c84..8700c39680662 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1551,12 +1551,12 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
+repeat:
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
 	symbol_conf.skip_empty = report.skip_empty;
 
-repeat:
 	perf_tool__init(&report.tool, ordered_events);
 	report.tool.sample		 = process_sample_event;
 	report.tool.mmap		 = perf_event__process_mmap;
-- 
2.39.5





Return-Path: <stable+bounces-16290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07583F72E
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20671C21D56
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFF04436D;
	Sun, 28 Jan 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN+No4Uh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02C6311F;
	Sun, 28 Jan 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458426; cv=none; b=oW+4djFifFb29/Olmh4k+cJNu3UQYqFzW1jOnbG4iyNnaUQgw8gOpRtHifb4JDSH8RpHXTRyv+Iyh+H2NtZAwG912Aktg3k7LPsY/VUekaeME2tALLaEYFCSDmpDwo/BIUcgOvV8WIqvu1yJBFFLp8JHxfXZvLkVm1ip5tE0h+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458426; c=relaxed/simple;
	bh=UgVPDJioGERvTSvTyY6/qpVX6AWXCKIz4tazoTvzyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXhABzPzwvMmRr/N/SSWb01KFnYC1tYvphnR5T1ePm3y4w/6+igwJ9sBgDQtEIuvUaWZk16nAbDm3zbV+hGIPu0GoDEx2Cut1jfan/kAdn7opcz25FAvKyWZlkexAESh1jzewBEKYPElY+CoFOh3c88VJe3YIj703dolteaTHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN+No4Uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D955BC433F1;
	Sun, 28 Jan 2024 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458426;
	bh=UgVPDJioGERvTSvTyY6/qpVX6AWXCKIz4tazoTvzyew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN+No4UhZ4GshcBA/4VgdhOxJ5NHj2iWUrMK5Pp9WscnSRDgWQfFUcwxm4W/WCiaX
	 oMT5S/tm864ZQZNrPlh5f+k/HpzdKKNx8XpAepGsF+lzQvVY/QoloJWN8Cz6/uIqQA
	 WVmP0wpxKU/fRiLa0iZ+tJ7XWp5TifUw1wTGemdlZeUH2/ga/hECMGEy1ht0ym7PXW
	 NaENxz0TYICPcfFrQHro2QUyDeu+JABNc7BS8eo/0GwPdx1jPqr6NdHZI12Q6WhFhF
	 GQqqJlIHRgttBRdmIDdm+jPBXXtMKNtapyo3TKNWvoKXK/6ZILtCwqLsp04GHeU/Tt
	 /tkD3UQ0Ix0Bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 18/31] libsubcmd: Fix memory leak in uniq()
Date: Sun, 28 Jan 2024 11:12:48 -0500
Message-ID: <20240128161315.201999-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit ad30469a841b50dbb541df4d6971d891f703c297 ]

uniq() will write one command name over another causing the overwritten
string to be leaked. Fix by doing a pass that removes duplicates and a
second that removes the holes.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chenyuan Mi <cymi20@fudan.edu.cn>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231208000515.1693746-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/help.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index adfbae27dc36..8561b0f01a24 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
-- 
2.43.0



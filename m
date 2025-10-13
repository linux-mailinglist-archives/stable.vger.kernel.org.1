Return-Path: <stable+bounces-184262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20FBD3D4D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22884F4807
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B88E30DD12;
	Mon, 13 Oct 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1pCDm9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2477030DECD;
	Mon, 13 Oct 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366928; cv=none; b=dMD8KYTWuKy5KObcG0/TLksnPMOAWhQU8++kVQR8SQp07ADrwVdZNH1zpebWC/kH86y0PV674M+Xq/gOdzOvcME9jc75p7NGc+fiFBM8UQmBkHxBvUDc+eSpYbxbGRG1XEuloUCNDVq+m/NoQpV1dyD+55pKbc5oIyem0iOC2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366928; c=relaxed/simple;
	bh=5f0wgzGvDpZrOqtq062bTojOuGOf57zUcWFS7M5DCu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOUA3drec0N/4w967+Fda2KZRV5FMV3qN3B+0a45qR8Q0d9b+Z0RoTZWCzyxUeAWtERMzawqD496xkVfXQqdWgCmH9T2atL0t7p+S4vRVBoqUrcAUnkNR/hhk7zM4MmF+mGfS83ZS79JXWRWxN5tQJ/UGUprZh7Qp4bSEAs+LME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1pCDm9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396DAC116D0;
	Mon, 13 Oct 2025 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760366927;
	bh=5f0wgzGvDpZrOqtq062bTojOuGOf57zUcWFS7M5DCu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1pCDm9DvhIow+nKtx50lboElB9KgLM3zIXreuqFJmFkvS4BZu9+PNBnHQkpYKJ0e
	 nxmCHT/7thHi49mvw88j99jCN8rPwEaUw8HyBkygOEVqf8pSfzqu3ORO63UGP8+4lg
	 VruBXo5aU83XLnFkE+cVhryuAlJxRvgFLduhrd5o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hupu <hupu.gm@gmail.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/196] perf subcmd: avoid crash in exclude_cmds when excludes is empty
Date: Mon, 13 Oct 2025 16:43:26 +0200
Message-ID: <20251013144315.786706724@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: hupu <hupu.gm@gmail.com>

[ Upstream commit a5edf3550f4260504b7e0ab3d40d13ffe924b773 ]

When cross-compiling the perf tool for ARM64, `perf help` may crash
with the following assertion failure:

  help.c:122: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.

This happens when the perf binary is not named exactly "perf" or when
multiple "perf-*" binaries exist in the same directory. In such cases,
the `excludes` command list can be empty, which leads to the final
assertion in exclude_cmds() being triggered.

Add a simple guard at the beginning of exclude_cmds() to return early
if excludes->cnt is zero, preventing the crash.

Signed-off-by: hupu <hupu.gm@gmail.com>
Reported-by: Guilherme Amadio <amadio@gentoo.org>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250909094953.106706-1-amadio@gentoo.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/help.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 42f57b640f119..687307f2fe0f7 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -72,6 +72,9 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	size_t ci, cj, ei;
 	int cmp;
 
+	if (!excludes->cnt)
+		return;
+
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
-- 
2.51.0





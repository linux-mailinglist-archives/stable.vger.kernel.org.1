Return-Path: <stable+bounces-170355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21236B2A3A6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7086618A66FF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D05320387;
	Mon, 18 Aug 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPjBej5n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8531E11B;
	Mon, 18 Aug 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522369; cv=none; b=I1P+zxmAnE/R7AlhI44Pn3Vyykb/j60reR1e3el/EC8d/IJbeIGKBzyct+r3CCs/j3yAuLjjSQCB3ceaToDHrhiGSZ4WgDnN0G8ZFbjWiBcAgCv17Cuje/DrVCPwcTEIDADAg6P0b8IWpeNDnpXJnKufyoJX2pc2vskZEUduDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522369; c=relaxed/simple;
	bh=ArUQ9OAMWZ4dXCCG0v7cVsbNI7ZN1sYegbxJhlPPzxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc37JVtGGwt16yXALC7VBSeANF+dlDjPOwvIs7SUaCfjMtcBm1kFzvp/HHke+Jz0aB5au/PGVsE96J2dkOBwKtgi7jy6t5ZeJl/9DTAacOYyh+md5Itd8Vjj2w3SboRlrxmCr53JuYiL2OnMjZIxdp0QNo3SqiVc5EF6Ycdu+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPjBej5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929FC4CEEB;
	Mon, 18 Aug 2025 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522368;
	bh=ArUQ9OAMWZ4dXCCG0v7cVsbNI7ZN1sYegbxJhlPPzxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPjBej5nPYECYOpx3BBFTSliRGSgYcWweh/Ux8JJz7TgwmsOKJj1bBKR5dWk3tptb
	 O5suLzTXXthiBUrGuKJOmhzEY4ENqfDfPI1gS7VZsep/nZU49AKbPrG+hNDzdWBVuS
	 AV/Uj51UUo6/B8ZdP8UOUGvn6zogbpDnP69lanhk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Monnet <qmo@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 253/444] bpftool: Fix JSON writer resource leak in version command
Date: Mon, 18 Aug 2025 14:44:39 +0200
Message-ID: <20250818124458.307927958@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: Yuan Chen <chenyuan@kylinos.cn>

[ Upstream commit 85cd83fed8267cde0dd1cea719808aad95ae4de7 ]

When using `bpftool --version -j/-p`, the JSON writer object
created in do_version() was not properly destroyed after use.
This caused a memory leak each time the version command was
executed with JSON output.

Fix: 004b45c0e51a (tools: bpftool: provide JSON output for all possible commands)

Suggested-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250617132442.9998-1-chenyuan_fl@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..a0536528dfde 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -534,9 +534,9 @@ int main(int argc, char **argv)
 		usage();
 
 	if (version_requested)
-		return do_version(argc, argv);
-
-	ret = cmd_select(commands, argc, argv, do_help);
+		ret = do_version(argc, argv);
+	else
+		ret = cmd_select(commands, argc, argv, do_help);
 
 	if (json_output)
 		jsonw_destroy(&json_wtr);
-- 
2.39.5





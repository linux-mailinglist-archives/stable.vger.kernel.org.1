Return-Path: <stable+bounces-149962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF0ACB57B
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34CB1BC2FD4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4722E3FC;
	Mon,  2 Jun 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yR8GKypC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A615CD55;
	Mon,  2 Jun 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875596; cv=none; b=QMFRHMwFlScWSWyS7HZYHOMbMo1NgK5SWSte/tUyhM8HGb6UEM1d2oIxBslavizV7V3dpVJlzphzJHmnxlXIs5YaFWuGymf3nCNt0MFhOA+RQbJUj9fHQRnoBmsMCEzziSMcIRP/zMV1f3LQOBwfPNK770uF3dA2KNjC6eTpVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875596; c=relaxed/simple;
	bh=Ny7cwlE4B0z6ohmnNldJ7nJBDNj2zDfpoQAMkMnNFeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry5hkXzh0OCocC5wBG+/rNC7zmrl5e8ONvAn/bNvcXzu+0xC+ozsggGomHcWvmTXHQeVI7FLe1eNJLUiHmmEDsNLU3WpKeD+RuXJ5aY9b2aFkMNIZYnDtifAKL5zFF0NhJMfqdM1ZCRepG07gqXzZXcD1Q3LrYEBN+Lx2Zv5alY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yR8GKypC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225F6C4CEEB;
	Mon,  2 Jun 2025 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875595;
	bh=Ny7cwlE4B0z6ohmnNldJ7nJBDNj2zDfpoQAMkMnNFeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yR8GKypC5I1InTuzC+PWB7odhxXrfYU/ikiO345pBcYSQKQOCVZ5lGuwMO2HRNT65
	 yrjKoxuCnMddq87y8wSV0lNqTWhsCWq9x9wsknDfdJWtQdSNFfAvT4TGICSI/24wdS
	 g2Q1DZzIuQsYctWp10yOw0skO9XMrsjlCpO/dP+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nandakumar Edamana <nandakumar@nandakumar.co.in>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 183/270] libbpf: Fix out-of-bound read
Date: Mon,  2 Jun 2025 15:47:48 +0200
Message-ID: <20250602134314.693351906@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nandakumar Edamana <nandakumar@nandakumar.co.in>

[ Upstream commit 236d3910117e9f97ebf75e511d8bcc950f1a4e5f ]

In `set_kcfg_value_str`, an untrusted string is accessed with the assumption
that it will be at least two characters long due to the presence of checks for
opening and closing quotes. But the check for the closing quote
(value[len - 1] != '"') misses the fact that it could be checking the opening
quote itself in case of an invalid input that consists of just the opening
quote.

This commit adds an explicit check to make sure the string is at least two
characters long.

Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250221210110.3182084-1-nandakumar@nandakumar.co.in
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 33cdcfe106344..f65e03e7cf944 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1503,7 +1503,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
-- 
2.39.5





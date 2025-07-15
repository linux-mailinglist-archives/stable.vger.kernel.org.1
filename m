Return-Path: <stable+bounces-162812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3576B06001
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED61316CB09
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7052E92A6;
	Tue, 15 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IlaGmsAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AD22E8E1E;
	Tue, 15 Jul 2025 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587540; cv=none; b=GLmRZvWQ+XUBvaxLJgkCOF/kXyrpPtunvqu2dgTOZLqQA7TFYOpTJLHRnUyWZoRL+QSuYKESaFwCTH/hZfBulqw4jueJQtccd+z8qVZvhkd5SFdPmr7aPgVvc9asCMSLHShI0fbxPw7ze6eCz3imw0v2obBkmXwBivMmryTxu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587540; c=relaxed/simple;
	bh=WLCXccYGIaiPDgXueAkkLZJ6/bq4H60U4bvmo0TQWTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emPGa3L/4oAiDhDGPp0U+zNfddTCtFMh48NhBbvgtCCvfSwjNDGGEfVGtFM7YBBjwABk5H70x6rFqlHZbGrkdzwTENZBm9I2ZRGjCxxoCpFTZnhIB97DxusDsJskxkQ3zGwTM+5s5zMQIa/eeYjX2O2Da6qgB45uOe5T6wCQqQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IlaGmsAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1C2C4CEE3;
	Tue, 15 Jul 2025 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587540;
	bh=WLCXccYGIaiPDgXueAkkLZJ6/bq4H60U4bvmo0TQWTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlaGmsAkvQfHooRVffoZ7aibBn8ZvKRZ8I4Jx/TUiPGW0gYpNc4zRolofjd1qwJYR
	 pba74le7h+DFAMMY9LOhrrTHgSMmWj3JM7vbOpKb7VNk4qdy4P1KSH2BgUs9pTb+bS
	 fPbEKCm5UoddvZ8uj8gPGWP1Yb5x+ujYY2xbwzP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Chen <chenyuan@kylinos.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 050/208] libbpf: Fix null pointer dereference in btf_dump__free on allocation failure
Date: Tue, 15 Jul 2025 15:12:39 +0200
Message-ID: <20250715130812.958454382@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

From: Yuan Chen <chenyuan@kylinos.cn>

[ Upstream commit aa485e8789d56a4573f7c8d000a182b749eaa64d ]

When btf_dump__new() fails to allocate memory for the internal hashmap
(btf_dump->type_names), it returns an error code. However, the cleanup
function btf_dump__free() does not check if btf_dump->type_names is NULL
before attempting to free it. This leads to a null pointer dereference
when btf_dump__free() is called on a btf_dump object.

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250618011933.11423-1-chenyuan_fl@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 2342aec3c5a3e..d6818e22503c0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -193,6 +193,9 @@ static void btf_dump_free_names(struct hashmap *map)
 	size_t bkt;
 	struct hashmap_entry *cur;
 
+	if (!map)
+		return;
+
 	hashmap__for_each_entry(map, cur, bkt)
 		free((void *)cur->key);
 
-- 
2.39.5





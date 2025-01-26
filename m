Return-Path: <stable+bounces-110600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85FA1CA77
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 661A43AB2AF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF51D90DD;
	Sun, 26 Jan 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHUVnDfs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C52036E2;
	Sun, 26 Jan 2025 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903445; cv=none; b=PqXyUFIWYou9YcXPK3Vtel7c+N9QMjknaFscYjYg+DfvD4JRyB2PsUN/Rf3SgXIH6WzFv7UsVfCwmezC1pEyz+yDh6jqj0WKsy6fCbrsGf5a5OXxTMKteaiIVsdA882YOHyxKngZhHf1RSr0bML/9MYng7LtZyfMU1VZlDkVems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903445; c=relaxed/simple;
	bh=ZYvqdzhrVmnNO+3ORASNZ7xcgMmpgeqgf3QL45CbMQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rmA5BPwLQr6+F1UtIJEKuHgMPXehpnIFMFJNkfkaMIMFxCGs8NwFsr24g5knOk911EXsxmoSARKWrHrjQi2FetWW/5PbJMAObg3OshYwIZk+uB6WG+SkdvE/B8DcHz8x3Dhy2ggEMXhBIejeo61kGIk1rTdi0yzsjF4Bimlitm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHUVnDfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC0CC4CED3;
	Sun, 26 Jan 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903445;
	bh=ZYvqdzhrVmnNO+3ORASNZ7xcgMmpgeqgf3QL45CbMQo=;
	h=From:To:Cc:Subject:Date:From;
	b=PHUVnDfs5uYC1ALG+RwdzUgbYRkT2yePZ5idT+06SwcNYO+p2HIJezOeFLIEEYr71
	 bz1ebpkLU5JlOSdBTKiCv6aj7RsgvLvUIDe49f5MM95qFRGVkVgk6luWRCQZMyw372
	 Sm+9VgvoXJM/5BwcK7VTHD3iCYU4cGMpFM12q7B6YFG67MtqtoHOikuL7eCFHBtHKP
	 4iNrMgYya3AlflKVCHRp+9Z27gu/BswS/lr8rrvQZk3hSVxI4VbDqxuF+wX/KVQ9hf
	 an6Ojis9VXXN64ImlaGxNMfq9Ia5k9EsAht8HVYKTKok42KUewOE7D35QMihyzzKSL
	 hPwLU4FckJXwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 1/2] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:57:22 -0500
Message-Id: <20250126145723.947855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a ]

Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
leads to undefined behavior. To prevent this, cast 1 to u32 before
performing the shift, ensuring well-defined behavior.

This change explicitly avoids any potential overflow by ensuring that
the shift occurs on an unsigned 32-bit integer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240928113608.1438087-1-visitorckw@gmail.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ae1a97dd0c3cb..f6e1e154d9c18 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -457,7 +457,7 @@ static u32 clear_idx;
 /* record buffer */
 #define LOG_ALIGN __alignof__(struct printk_log)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
-- 
2.39.5



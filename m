Return-Path: <stable+bounces-33574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E73D891F6C
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2AEBB263B6
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C05264D63;
	Fri, 29 Mar 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2oUB6vh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1912609F9;
	Fri, 29 Mar 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716398; cv=none; b=SPdMa0QnEjCFR1c1T+tIaZdo6mtViV9mI4dH1Dxis03WXFhLWoDF/AGbSsqvr+XUALYoiR9f/vzPkq+S8CeAanRYkMZt0nj6QXbsc8/kUo/MMHG89p/ogxoZoUt1hQqc+bdS/f9tw23QGeME7M7x23FOcCqy7qmaVXJHPMK0pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716398; c=relaxed/simple;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa+rOpWaPjMejwlwLo/2LQwEFYhuPeEd22T45zEQKacJXx3KTxSzFfYOrwKyqvzBN/haAiXgPDptpvcjtCIoBt3IyZF8meYdrKOWanNhlAoo6HDm7i8phfrnIrjOw0VJFqcgwxOgcxUzLVVK6tzLtScih1pZBJUuOdfSeAX8pUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2oUB6vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF06C433A6;
	Fri, 29 Mar 2024 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716398;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2oUB6vhxvoZZE8o+iEJORPxeB3X4UmoibrVcdrvwq8/W9hDCnyUK/KXekOmIMito
	 Ily2227tNUGOR/DddUHGFTEX0Ox1MNDpSf1Esw79YTiIWCf4UP+4WfEGygBKeqs516
	 0a2g6ZjT2MFLfniMSz8JNEcTYtMhmZxe79IDf2FKDJEU/zIRdo9xEt0Uh1ozoSl2Q0
	 qGZB1b06lJy5I6bLqeizWI5v+rY6N308R27L5SOkYnuswzL84zBLUSb5yqIsMbLINw
	 a3TgPFkLLVKMnDt5SXtArSvR5ZriyqvTn3PI57HKGGQ2zfo+D/E0ByR2axDAdMXCJj
	 xgj3NT/TxNe8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.1 18/52] Julia Lawall reported this null pointer dereference, this should fix it.
Date: Fri, 29 Mar 2024 08:45:12 -0400
Message-ID: <20240329124605.3091273-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

[ Upstream commit 9bf93dcfc453fae192fe5d7874b89699e8f800ac ]

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d7..4ca8ed410c3cf 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -527,7 +527,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
 	if (!ORANGEFS_SB(sb)) {
 		d = ERR_PTR(-ENOMEM);
-		goto free_sb_and_op;
+		goto free_op;
 	}
 
 	ret = orangefs_fill_sb(sb,
-- 
2.43.0



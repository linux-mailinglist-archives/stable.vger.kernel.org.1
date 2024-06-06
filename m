Return-Path: <stable+bounces-49541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5958FEDB3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D74B293C4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDD19E7D6;
	Thu,  6 Jun 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifaQxfAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E01BD027;
	Thu,  6 Jun 2024 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683517; cv=none; b=EciG9N/0VaThjnSj6nfR2a22COg9MLxMGLk63H++juENh1/A4OF6x7vDzldj1flVMB8+X8+SiIQRzORbcvMkb7UgTLMvPIQSbzbd0i8fZ/WmzaXvcUgw6KXOtRmnThd+1oUsS2DRYMVs+ngOly945nVSIgOxHu9fm1VxtcfW818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683517; c=relaxed/simple;
	bh=ETyZZ3wjZh+JW3jYzAxkjHp/fkWQ2vUWiDOjslcbCQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtPAoNmrUti6jVm40KJ+KHblPsn2foMay1XioT/+5PpHicu400rrcJQF2d67/0vK2hInm6fPV+UoPMwylkEqY13cSWHu2chMq0LTS7jV/UFSb928iqKeXNpiTYf4FhAdqd8Qyhe1Jq1qV5HsdnpiZ6DYtzor7bfFFQ7uhD5/5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifaQxfAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187B2C32786;
	Thu,  6 Jun 2024 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683517;
	bh=ETyZZ3wjZh+JW3jYzAxkjHp/fkWQ2vUWiDOjslcbCQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifaQxfAPVc8pu6/SKYEQK9cJJM8ccK9+dc8p7OkvttT3lRxjDoVQ3WqHcYoLCF1uU
	 vMKGv8SSqBjG8EJ8h7DohGOpifcfec8Eup7R2C0P41UGX4S7UJ3+W/swFX+0owPXMu
	 LiXI4XRuti+MnYunSn4oUOuPFtre5QHuR/fJ6OFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 376/473] fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
Date: Thu,  6 Jun 2024 16:05:05 +0200
Message-ID: <20240606131712.308267197@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit e931f6b630ffb22d66caab202a52aa8cbb10c649 ]

For example, in the expression:
	vbo = 2 * vbo + skip

Fixes: b46acd6a6a627 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fslog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index d53ef128fa733..a2d5b2a94d854 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1181,7 +1181,8 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			struct restart_info *info)
 {
-	u32 skip, vbo;
+	u32 skip;
+	u64 vbo;
 	struct RESTART_HDR *r_page = NULL;
 
 	/* Determine which restart area we are looking for. */
-- 
2.43.0





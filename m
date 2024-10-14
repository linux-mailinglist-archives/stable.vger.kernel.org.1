Return-Path: <stable+bounces-83663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6499C99BE68
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178DF1F2267F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176813A25B;
	Mon, 14 Oct 2024 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwQH1PdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1D13AA31;
	Mon, 14 Oct 2024 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878260; cv=none; b=OCNp5zmtNRBG1fVupaWssM2cP0h6purnG9G/L7dy4PjOaUf8vbNx2Y7uJiM8KkokZrXpX869/EvpN2DPknzLTzdBD0Iyma9Jp/EFd2OKOOFPqFd0e5i8pGj7vgQoAg6yudy5gsb7X+tmCus9KgazhzLkzOJoVgrcB04JlqppYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878260; c=relaxed/simple;
	bh=5J3S3I4uxKIik66iPMpZkFxzvvtYWR9H4xsj/Q/IKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwgeozIO7G9/27YgO0huhPE2dVsF4Cb0Mp1fTFhvtoXSf4a1IaZoZROVGTEKWhgEvg+3svRzUYkNTMKQdfBJPklVw9f1DULazhMbqScMwo/xXKcZwW7rFTuOmXJmIdlblDAz0zRgodNGoJWVabK32bpcSNZfxp+fZ3meva6Tfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwQH1PdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC82C4CEC3;
	Mon, 14 Oct 2024 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878259;
	bh=5J3S3I4uxKIik66iPMpZkFxzvvtYWR9H4xsj/Q/IKwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwQH1PdQ094v4ZMU1tBL+b+AIE0EZbHwEZsTsHb1zGZPvxbc1LznYLgpqoa7YTBD4
	 LRzFAfs0dn2yxb9L80Ym43KJiC0scHJ3aS+GccF14Y7SJgzsU7g4UOUTmesF4WcxwR
	 TU0N/Gd1mYgdIWa57vuyqUME8TLm4LSNaYqywi0xIHqAt1efr6Ongw/I26zTS4WwA+
	 Oe7iK3l/efBrLgGZtBjtTbXFd+TrJ3taRCQHiU4BpU/Y5jNVh3JTC/U0MlByFpYje5
	 t6YBir0odMmkqYkRcB1bMGyh9cggTGYSxyU584fAp1smit4fOqNG/1g0yE5IEaHF4H
	 rHWmhRTa62Brg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 05/20] fs/ntfs3: Add rough attr alloc_size check
Date: Sun, 13 Oct 2024 23:57:07 -0400
Message-ID: <20241014035731.2246632-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c4a8ba334262e9a5c158d618a4820e1b9c12495c ]

Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 2a375247b3c09..427c71be0f087 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -331,6 +331,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 		if (attr->nres.c_unit)
 			return NULL;
+
+		if (alloc_size > mi->sbi->volume.size)
+			return NULL;
 	}
 
 	return attr;
-- 
2.43.0



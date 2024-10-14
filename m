Return-Path: <stable+bounces-83666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C699BE72
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6302E1C220CE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA71465BD;
	Mon, 14 Oct 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCFxEwB5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDA130499;
	Mon, 14 Oct 2024 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878263; cv=none; b=MMU8D45yXn4I7Ve7L4gvNVtmA6Q+dV06JcGvq03FdgAE0/DIusbjuVNlWaanl+LhJTpHPy9YBIFYkmVU9X/uQmGfgLwxFE73mLmYD48k7XU6sJOgFQ2qpR0uEtQPALjX4UnKDDw2xz39qT9E2hodl9HRGSnFv3awzBiNLbrkuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878263; c=relaxed/simple;
	bh=djygIBjiHX1kmMUojVkC4jMuh5SVOwQHFhzueWxPMLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vqge0Ni+1plymYqnVjZYQew/flfTgnLpqMr74CWZ3BhFKtfYTaabRkybTvZbti9MRoGG5rvcAXh1GRMoa2PLKefGLHbqjIogvZ6M1dRXjbok48T4Sf7rf+KP+RIEH4DS9lCHz5dFaik81a0nTKXbJDZhbbkjQuYbwL2eL/mQEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCFxEwB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729B7C4CED0;
	Mon, 14 Oct 2024 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878263;
	bh=djygIBjiHX1kmMUojVkC4jMuh5SVOwQHFhzueWxPMLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCFxEwB5ukvCqX+4WF7g0roXxgnUxcddKBWXrVeX4jSSRCUgpVw3fMM+B9UsUIEpB
	 kUKZehkOYm9pqCH4WD/Ls5TWncdhVgL3XHuCXF0ggTlIEU5uMaB/MiFW9ozPIg0zp6
	 0EMGHoh0SwPpDdgOMLiI5mU4oSMM9s8uA31M69cgecwbMJeqLdyOxdWwvIDFsVRPwR
	 Aj35LofzmY0Fc5sp8v/EygmmUf2EXfYxTlZhbGwIRol06JPBCoUyh82ydAFX913RHW
	 ieiImKTojPPK+cEyhQKrq7NtlsbxWJDgt3zxgB++w/Mc3YGRvZ/a4fRk8N7mEteWY7
	 DvUt3ACCZADbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 08/20] fs/ntfs3: Fix general protection fault in run_is_mapped_full
Date: Sun, 13 Oct 2024 23:57:10 -0400
Message-ID: <20241014035731.2246632-8-sashal@kernel.org>
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

[ Upstream commit a33fb016e49e37aafab18dc3c8314d6399cb4727 ]

Fixed deleating of a non-resident attribute in ntfs_create_inode()
rollback.

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 56b6c4c6f528f..4804eb9628bb2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1717,7 +1717,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
 	if (attr && attr->non_res) {
 		/* Delete ATTR_EA, if non-resident. */
-		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
 	}
 
 	if (rp_inserted)
-- 
2.43.0



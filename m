Return-Path: <stable+bounces-48117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2D8FCC8B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3201C23DC7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E651BD4FC;
	Wed,  5 Jun 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxhBIwf2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF51BD4E7;
	Wed,  5 Jun 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588581; cv=none; b=KmcczOm7780XLTe5E4uPEomHCT7GKt3O3ogGr2yMqLAgh5Iaof+N3c9QycR4CPPA71uyb84V3BLYmqMgpcj1T0BDm7B4AhKxVlWjzGfYR4XhdmxNJ+Ah5GJOo2MYbF8bBZ6Yy8PqIwKpFdDN7yOCarO0CPbUAjgIOYmNBCSClEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588581; c=relaxed/simple;
	bh=ceeJCzGk3tRd6y45nGAz6nA6y/fUYC7C7+ndgPabfS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XY3KJKhNLF1R5XiPoIxigNSAMI2ZO6l5c2/N6oPx3zDcGOR9lgH4otIbm86CZ9i2iNkVClHDMOd5PJHMUVIsy6WV8x4J9N3drIyW/AwKa3/iZiI8CCgqMIFBaTI8YZLG+RFrqpO0tgiu4edIFAYfpk9drcOT4hSEub1KdDiynY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxhBIwf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF0FC32786;
	Wed,  5 Jun 2024 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588580;
	bh=ceeJCzGk3tRd6y45nGAz6nA6y/fUYC7C7+ndgPabfS4=;
	h=From:To:Cc:Subject:Date:From;
	b=HxhBIwf2Ie+qS69nc5uUBUbnI0LESNbnRHW6sxC2zvUWyjydl6axttB/9IPUMSgDe
	 Uefn4pCTQHd9rTLTJGgCsRhACrzW/1HTaFpNJapRyFhvS989odvF1MGM3HarB+dsPQ
	 36iNao+2UtrTvQ4HTQgpOvTiU88JHbc5R0myZW+IFd5IMMn0PzM4SGxbKbk6BNieKQ
	 y9te0+j0+N5j6r0luORRsirVfET+PaRHkHfRm8f0QV3Al8hFDpE1dUTR0d1EMtuTcA
	 7WzIOgfaeS4jLNYfrKUOlAfYJn9k5iL7ALuFjD6MIxKmQ1f5vu6gmsJUsSz2nW1Eh8
	 3de4zUH/nEeMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 1/4] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Wed,  5 Jun 2024 07:56:13 -0400
Message-ID: <20240605115619.2965224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 24f6f5020b0b2c89c2cba5ec224547be95f753ee ]

Mark a volume as corrupted if the name length exceeds the space
occupied by ea.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index b50010494e6d0..72bceb8cd164b 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,8 +219,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
-		if (ea->name_len > ea_size)
+		if (ea->name_len > ea_size) {
+			ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+			err = -EINVAL; /* corrupted fs */
 			break;
+		}
 
 		if (buffer) {
 			/* Check if we can use field ea->name */
-- 
2.43.0



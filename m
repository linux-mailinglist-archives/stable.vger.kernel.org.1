Return-Path: <stable+bounces-83664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95399BE6A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D911F228C5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA9142903;
	Mon, 14 Oct 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Fzschf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C40140E50;
	Mon, 14 Oct 2024 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878261; cv=none; b=AHpLJzJOG/qzAZdaIByiNy6JKM+4kcp8HxjOj6LoIXLeq7vXoe2PKW52pPi/plRa9+ydv76iszrUZ68Q8JfS0uKVIBb7yrgHe2TndOglHiTF3Jo5KCBgBUPcgNOPRWMyKlGXgYp7lNRMBOj0vvByKySvdENGI4yBmPoInRKcLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878261; c=relaxed/simple;
	bh=eZeSjJlD/4k9AeVKAZQH2nECx3ZY5QhMcMVl6Demf98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikBFZAwyV1sJaqZenlatRRZ2V+Gb5fmivEgnRKmVlqSJ1R+LUTeX+wTDpDxenA9bcKEiphu8C9buI+BiCTfrzcmN76mTQnIPe9QhZOopoLLVk0X+vzqnnKgy1M8TunYeMCXOd03mbXMuTkV0AW8pR8yXQBoPYnph8E0CzJ6j1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Fzschf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2247C4CED1;
	Mon, 14 Oct 2024 03:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878260;
	bh=eZeSjJlD/4k9AeVKAZQH2nECx3ZY5QhMcMVl6Demf98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7FzschfVIoqQOhGUwcagUpmAz9xHlAclIThtPTV0+ZOoJ18WMTacP7Hv0ABpQH1u
	 tECErqGoovkjbC3f0NfifNMAeUFMfld6qNRlpF0Qsaz1FV5GY4sXkX+1iqazvtIdJw
	 sUYrIK+aWgFwJbO317F43sE1PrSk2NTIM+3YaEbrgKZ8rG6mQeaNGCBNvdudnk2mSH
	 X7kSQcqx8RJjqsCOktaOZIeGS3Od9jfMmuPeZ892HWSQyVoSXBn0PHikIk86ytZA7j
	 C8btfAm2+G1h39rPj+U/LK4AqknQQ0oXT0ICgGT8tCEwg+QCkpxydA/502AFmSG9Vz
	 UlatHVOPsi/3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 06/20] fs/ntfs3: Fix possible deadlock in mi_read
Date: Sun, 13 Oct 2024 23:57:08 -0400
Message-ID: <20241014035731.2246632-6-sashal@kernel.org>
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

[ Upstream commit 03b097099eef255fbf85ea6a786ae3c91b11f041 ]

Mutex lock with another subclass used in ni_lock_dir().

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f16d318c4372a..6c49a5606ac8b 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -81,7 +81,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
-- 
2.43.0



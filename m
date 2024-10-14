Return-Path: <stable+bounces-83708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6399BEE6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DC21F23154
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43891ABEC2;
	Mon, 14 Oct 2024 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqvjTDwR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FC1494A5;
	Mon, 14 Oct 2024 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878375; cv=none; b=SenriJHNakokdMNUMJZM+cZY1SRkkbhba9pIchsnsm/OPet/AAi5o2kKmxOfKukvJOrwA31K1eufhySyOOhAGhiqxOEQce4FG2M7GJkzyWunX//+Z1zqXlNNUmAPQhSp5BxTa7cqDidpiRykPHsaPjO6jaK6hdm/3cxXWq+8b5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878375; c=relaxed/simple;
	bh=eF0NmXKcdsd0cXv3gXcslyPKS5o0r4vpVq1ASmr3GQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqbAv6GFz/4WpN8DNlA50kk1hq9TjJInSIAtjfv75xiezaUqOMr4eA3eYcMjlEEx1s/HIkw2DRPC3qjsqhEHpkJ/MKUQw2y2FHS8X9cKz7RxZ5r+9fanKf/FUS9fcGpCATj7gEv/S/OouTDoaPrIhDQVPNYTTHVDjMvo9s8AQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqvjTDwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDB6C4CEC3;
	Mon, 14 Oct 2024 03:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878374;
	bh=eF0NmXKcdsd0cXv3gXcslyPKS5o0r4vpVq1ASmr3GQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqvjTDwRBG4qm5p0BpkXUlFcN05AVQkhYQazAfMIvbyXcLGvt4Y2QrOHzEYdDgffI
	 JIXB/GsUui+HVmVAzvAmnxFh5VhULIQkJI+P+ueEQPDXrOYjUFFdwXgz5bm8POEPB1
	 V8tmOD3oiB4Jsg8MVI2ZaI/3bJkuoB3wCWWitTmROOrylgejAN+Ign7x3kOmK7fAB2
	 z6XaGMZxbgshPx1GY2yJAziGJVBbrxbChHwwK9/2y76+M2my7yvj82BjDOkEtKyFPb
	 mdn5Y+wzuPVckj79vLwPNjo5uoKif4Vw3nr6RO+65UN9p8O4fhRiSmQ4vG4gz9M8vw
	 oYXztZ0mPG+nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 3/8] fs/ntfs3: Fix possible deadlock in mi_read
Date: Sun, 13 Oct 2024 23:59:18 -0400
Message-ID: <20241014035929.2251266-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035929.2251266-1-sashal@kernel.org>
References: <20241014035929.2251266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index bff1934e044e5..c1bce9d656cff 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -79,7 +79,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
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



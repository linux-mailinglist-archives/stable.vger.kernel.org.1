Return-Path: <stable+bounces-83683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1521F99BE9E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F881B23835
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F181586CF;
	Mon, 14 Oct 2024 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn9QQnvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53BD158DC8;
	Mon, 14 Oct 2024 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878302; cv=none; b=AEgMD3Vcf+m7hBx/TDwXcsn+ZWZ+iOEIyrYh0c4m3ohpLr+48qX7NGe5peLCh0HW7KL4x8vXurTOw8e+FHSm1cAYq0HpIh1Xj6Qzx9kknEWqNcsA0yoTs4uJcB+oBS8vcNLvAChBae1Gz5Y3sy9XS4BeHVh7LDARFk4gHjT3HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878302; c=relaxed/simple;
	bh=5J3S3I4uxKIik66iPMpZkFxzvvtYWR9H4xsj/Q/IKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eALkwZRvgzEahJQaZdR0YevGXiN3EiBn/5Q97N2uLGEiCdW+en0030w7r1Hyu4q7XteI/ql5xkk4HId+Ewzf/bmCzv8fXa1WgZexeV1UmosvhD9AXiUKph9LyxbEqx95P66NDd2J0NiU68DnVxB5D+my0clFvzENBWH9AkHy6XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn9QQnvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21EEC4CED0;
	Mon, 14 Oct 2024 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878302;
	bh=5J3S3I4uxKIik66iPMpZkFxzvvtYWR9H4xsj/Q/IKwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gn9QQnvAaOjAT4ABF2qpHBhtVFKSlxU0b5ZOb5WeIUsS71BSegNJzHizYROmlDX5G
	 tk2yhzZwwy8b+Lu2Es0gxuAZ1vVbT+vX6693BF+PVHS33BfH6NVrGEvaqzTbb/7q4Y
	 mBULhpiIeZgzRgQlU8fTNYGTrHl1wZH3pPlD6eiSusxcS+4rOdBhYzeahKdgZgIfSd
	 8zvEHce9upau5qRKoVU/X+HujN3gwlFWWqONgKeBDipcjkOIn8RHPFv7/WSU4kPEbI
	 q3luvNTs8fhkx6cjQQXJHbVDWLXB2TeWXk4We5LBgvgp2dHLVwcJ9suS923kULhadJ
	 pRoc3SQscBWTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 05/17] fs/ntfs3: Add rough attr alloc_size check
Date: Sun, 13 Oct 2024 23:57:55 -0400
Message-ID: <20241014035815.2247153-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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



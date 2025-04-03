Return-Path: <stable+bounces-127739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32F1A7AA39
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED7B179B2A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B52580FB;
	Thu,  3 Apr 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZWNikCe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27490254846;
	Thu,  3 Apr 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706990; cv=none; b=OhQlnHmp7GmOPviJfYsky+AHg1sTugTyroxgsOLnor6uWICr+GknYx3MIqJ0rQ7ruk/pB2VT8aPkVsRB2OuTVS0Gyrm6sthuUvdWOvpdFmh8YsHUYo0ClbA0E2Ed83VXTjDkmCtswbCjfyCv2WaBB62X5y5SVVIAZmlwqrIu1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706990; c=relaxed/simple;
	bh=DKtMNqkGSl3Jk+kOCm2sYF+Agp8jjR0lL5uamaFFRtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZ6J1LUTB5+v3vBgPTpHFsYeXjWIZp1JUTdqgsVDlcYT3i2tYJON60p55Y7CStBJZDE3DMosY0oY+q+q3nI+RK6pptkc0lh0XzOJupqttltoGmL/MTfQg6wIn42rmQa2F9qhLE8DuQCEvANwER7QQbPpS1zj7te90qCDWjSU6x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZWNikCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF1BC4CEE3;
	Thu,  3 Apr 2025 19:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706990;
	bh=DKtMNqkGSl3Jk+kOCm2sYF+Agp8jjR0lL5uamaFFRtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZWNikCeRp4gJaunCYA8w5UKIUDRJVxmnvEw9hE9UPYzd4/SPwwgYWi5taePP2Vsr
	 vIdMDrMB2okHjQsRkrtaNtmz8VttTVL0YjafUSI3/fb3Cb5iYqCpmheUSzKSy7eBhC
	 fIoY2T+A9hbINCUTCI6lR8MJSRaw/yj4MR44uKYXQjZQA4edWiq5vCLOTSK0hxEnm2
	 Iwk7Mxe64sCO7HMdKg0EmpABGcGJzeH+5/R4AfqBHAwKUQTbEUUX7mLNCbt7h8avTv
	 8F32S9JcdKCluce2v0l/18YO30EGCQqIGkIoD1z5TIvZOs3wJ2XRrzfhO57ML/CPeZ
	 Hok/Ou/lMVSBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+7c808908291a569281a9@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	rand.sec96@gmail.com,
	ghanshyam1898@gmail.com,
	aha310510@gmail.com,
	niharchaithanya@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.14 24/54] jfs: add sanity check for agwidth in dbMount
Date: Thu,  3 Apr 2025 15:01:39 -0400
Message-Id: <20250403190209.2675485-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ddf2846f22e8575d6b4b6a66f2100f168b8cd73d ]

The width in dmapctl of the AG is zero, it trigger a divide error when
calculating the control page level in dbAllocAG.

To avoid this issue, add a check for agwidth in dbAllocAG.

Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 9ac1fc2ed05bc..0e1019382cf51 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-- 
2.39.5



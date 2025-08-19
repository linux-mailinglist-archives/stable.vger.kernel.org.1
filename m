Return-Path: <stable+bounces-171706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA97B2B5DA
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115006202EF
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B341E1DF0;
	Tue, 19 Aug 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7PfWcF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345E1DF258
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566407; cv=none; b=HLApciJUY6S9DyTBP9TPmEGDDJEeKNWNXPdcaotyzlwhCCHiUJIYJI3etuJpuLjN2hGfdMkjCQuYN/Jx2/gR0SvHQMruDyDWdyWIO3n4pdtlg7roZMOKKwpAJZRun9MZA7TgeP+m3HSXJvq0bWlU5p3U6xpAdRB7sEgrorxpHgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566407; c=relaxed/simple;
	bh=7VaU94EfsGSLkec9Kw9lmC4LDHmldWl7RLsk3D66Zk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UH1n5VrixU1B86I8zhf/++L7cxe9374fpb7FoG1IHx21Enq7cNQc06Y9ceCg6XL3ajJjgBl+0ScjvB1nohmoaFOQ05lgp/Yh/qiNxxqn4JTzNfbwguOBtGeqXo0ODKn+J7qN4EJxcz7o2g0PaYwLyhQ8XJ8wthVmVD6rrO2oyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7PfWcF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218B5C116C6;
	Tue, 19 Aug 2025 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755566406;
	bh=7VaU94EfsGSLkec9Kw9lmC4LDHmldWl7RLsk3D66Zk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7PfWcF3p+AlQZqsjRlMwE4pZBpMI20ogRUOPsC4xVC6mjcw2OyiIuLGWdb4FhzfZ
	 JpzyoLYzYy1pSLz9Ids14ng52g2C0fg0BC3U85BkYV/+ujtj5Px4hh2X38FsSyeYUJ
	 nRLcBmUqdNy0FX9njtnto3a208Coy1ipDB2B90jlsDlnfLxmCIG5FSJ8E3TIt9MYap
	 llOzlQKbbY9TtvxTmWijW0T1JJoHB3jcklt+Vcl9PCfa8E7kPUKnK3ECU8x7wiLMn8
	 dLKPZN/dI/VFoIVg4WV0QnNxiVFtEIdcytcBGl0SVgQGRk08tDAt6vUf1uwR4t2BO+
	 wojP20uGnrxog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alan Huang <mmpgouride@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 5/5] xfs: Remove unused label in xfs_dax_notify_dev_failure
Date: Mon, 18 Aug 2025 21:19:59 -0400
Message-ID: <20250819011959.244870-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819011959.244870-1-sashal@kernel.org>
References: <2025081857-swerve-preschool-2c2c@gregkh>
 <20250819011959.244870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Huang <mmpgouride@gmail.com>

[ Upstream commit 8c10b04f9fc1760cb79068073686d8866e59d40f ]

Fixes: e967dc40d501 ("xfs: return the allocated transaction from xfs_trans_alloc_empty")
Signed-off-by: Alan Huang <mmpgouride@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_notify_failure.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index fbd521f89874..fbeddcac4792 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -350,7 +350,6 @@ xfs_dax_notify_dev_failure(
 			error = -EFSCORRUPTED;
 	}
 
-out:
 	/* Thaw the fs if it has been frozen before. */
 	if (mf_flags & MF_MEM_PRE_REMOVE)
 		xfs_dax_notify_failure_thaw(mp, kernel_frozen);
-- 
2.50.1



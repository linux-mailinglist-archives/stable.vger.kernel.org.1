Return-Path: <stable+bounces-208123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D553D132D5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE648301BB3D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD2D2BDC34;
	Mon, 12 Jan 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3bhp31E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4428B4F0
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228024; cv=none; b=h/MhsA3dGRi3UdeiUPtQYKE2oWpbXwm8IwvOEGDGlaCWr9LZTII22gka1pIqNf5VrJhTywYABwffLurr7ox7OqCLKig0+ag/WMgXoa+HdBvhrULULYUL614xrriyLcGcUTYtTBWxUBr7/l5vwWiOCUEx29HuEvyeRqc0RJYpJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228024; c=relaxed/simple;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwsyayjwRWmrUaHAMWoW7LUt4EMFfWs2HRRzm2665hepbq4ZA2gLjb8W8YRWRTEt0xAbAJVXfL38VsSkFRD3REnh4wlrambSV8iH16BnR+5hT0BxYrYc94yUhPR4BCORtQjQRLQNPrHsNul4udP+sEyMZSQi8ifxmpYa+79Rc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3bhp31E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60777C16AAE;
	Mon, 12 Jan 2026 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228024;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3bhp31EhFe90hS4GnRSdEyx8+1rjoM8AmPYkGXFeM8ZJVLTS2AGIofFPk/8qjyYL
	 AyYSgLiEMI9SdkSFy4XaVG4jRAztU9PcVE+UQrzvBkan1oU1Yz377F9t102ztuWDxB
	 grIyeXnFItL7InwU/UAmzyT9NZd+4WehvHdafvrvnSKkg+fKjEQKtrravHIUS6lh27
	 szpedzGSrTFv0ZJFRcWe7sGsDT1DQbO9DH2k4dr/0xe8zGZL9isYVIR8YOegHLEO6W
	 hhxfxhhpAIlCprYXkcM4Uv9qANaBxDtf8QvvewBTne2rYTQj87LUlFAbdULHsRUdzw
	 f6Xj1o1CUhCYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] NFS: trace: show TIMEDOUT instead of 0x6e
Date: Mon, 12 Jan 2026 09:26:59 -0500
Message-ID: <20260112142701.711948-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011222-giggle-goofiness-bbd1@gregkh>
References: <2026011222-giggle-goofiness-bbd1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Hanxiao <chenhx.fnst@fujitsu.com>

[ Upstream commit cef48236dfe55fa266d505e8a497963a7bc5ef2a ]

__nfs_revalidate_inode may return ETIMEDOUT.

print symbol of ETIMEDOUT in nfs trace:

before:
cat-5191 [005] 119.331127: nfs_revalidate_inode_exit: error=-110 (0x6e)

after:
cat-1738 [004] 44.365509: nfs_revalidate_inode_exit: error=-110 (TIMEDOUT)

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: c6c209ceb87f ("NFSD: Remove NFSERR_EAGAIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/misc/nfs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 0d9d48dca38a8..5b6c36fe9cdfe 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -52,6 +52,7 @@ TRACE_DEFINE_ENUM(NFSERR_JUKEBOX);
 		{ NFSERR_IO,			"IO" }, \
 		{ NFSERR_NXIO,			"NXIO" }, \
 		{ ECHILD,			"CHILD" }, \
+		{ ETIMEDOUT,			"TIMEDOUT" }, \
 		{ NFSERR_EAGAIN,		"AGAIN" }, \
 		{ NFSERR_ACCES,			"ACCES" }, \
 		{ NFSERR_EXIST,			"EXIST" }, \
-- 
2.51.0



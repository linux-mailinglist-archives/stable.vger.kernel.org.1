Return-Path: <stable+bounces-208127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BCD13518
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B9E7312401E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EBC255248;
	Mon, 12 Jan 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twjWKI3m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050A1E1E16
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228753; cv=none; b=WduKymR4pLQII6UTt5qbdX/nytDqs1N1CPE/mSzNt7HcCunLjHfjJU0lfQKahxf6EsZ2RYAeU8FRg3lcmO+sdSSxYAMTn2rGXRJxw0RclZfggFTJs8YxAdAmMrdvyLbgGeLMDlyNQ2BN/FJqeRncHV5mIFTH9OHI+5Zg+LvHViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228753; c=relaxed/simple;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/nLkZc30+B/ALGnls28sytI47eqIdIsSvQ3HPwQqMO2oS/H5MfyuLH+kR3eb9JrXU8jSN2sd170hATqKeSJCdK6+AVHDWwfaBGYoJVKjoz3MoBNN09o7f7HtoCc+m7FGBm1KQ5VREZs6ra5UmVtFomXFv6omsJkyQvPKYobtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twjWKI3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE43C19421;
	Mon, 12 Jan 2026 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228753;
	bh=viKfekOqMFULzRwcGUu0rT/B89xSJvALGBme0IWd4AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=twjWKI3muOWt1dOApJb0eAwl0/rrfMSWIvD6aLUB1di/8kbnyeXGTGEJpBZDAhbTD
	 TTDiKIUIakh23BXd8Kf/+2GZSmb/oiG7HTvdKKiZGj+5pp9lXvs756vxsASQES57Z1
	 UmPgoOeSTwTZyBI/UDZsWfuh/PVus++saM8mi5QwEV01NCueh6QcIu81Y4JBOaJJeb
	 4dmH+7pcUsHt7RuedzbXBFfsJZE6/FjEurGyGeCkWtof1cM2XPnRARywMt8Nzlqd/n
	 nI3pjgEjD+MGrM8wd8/1OTN70bZHzP1F+kVb8cmd9LM5BrJ1ZJhJqM4FT9fayIf38u
	 1IZ+9aH41qhOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Hanxiao <chenhx.fnst@fujitsu.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] NFS: trace: show TIMEDOUT instead of 0x6e
Date: Mon, 12 Jan 2026 09:39:08 -0500
Message-ID: <20260112143910.714632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026011223-dash-veal-39c7@gregkh>
References: <2026011223-dash-veal-39c7@gregkh>
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



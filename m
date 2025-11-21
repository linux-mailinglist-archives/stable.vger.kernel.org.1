Return-Path: <stable+bounces-195772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B25DCC79691
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80D6F35C71C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02753176E1;
	Fri, 21 Nov 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/7kwins"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753532765FF;
	Fri, 21 Nov 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731618; cv=none; b=OSQd9MiQyScVRtquQuMv1HVB9xch/EuA/ynx73ibchvuEsw7w/YMJOxSePVq0MlQoJ7c/vnrDlzzHxchO5lzHkcVTMFrNMO+O2tdL0fIi5XbfwbS/9ooGpSU5A3ZyfHgMcTVeQkFMHZXVwBXtDDK92n6W9OB3RrWx5a6wBqYOMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731618; c=relaxed/simple;
	bh=s+mpWI+znLBSZSjH0Y+Z9mKdfVZrQZ0nCDBA2KSSkAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQA0HhclbBSLlYd/Wtbl47yLUxAidLWYe8wpmUPd57VD0wnSW7G5QqESgoSDWMr6VddJfLy5CbnNQakx9GODDva10NKpH7e8J+tllpwx6owV7rQuTW2xL8Hyac+g3oFDU9GcjH2IPbSRxs7WHrUJNRQ7056fjP99U6Lg6Z4K7lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/7kwins; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E2C4CEF1;
	Fri, 21 Nov 2025 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763731618;
	bh=s+mpWI+znLBSZSjH0Y+Z9mKdfVZrQZ0nCDBA2KSSkAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/7kwins9cIlJa3VMaa/kiXRLByUY+/ok8x5A94e+kW6/AhOeIupoxf7XM6olAJVJ
	 OE6mAsKHAznr5XZOs4nsSZfFR/7mRgmNCqDTaldgfNN42cLUwlcun4JufLpGXtPeNC
	 PYku/YIWGJ/JLjhLuWZuNO5ppyngb7oteFMcmJT0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Mayhew <smayhew@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 023/185] NFS: check if suid/sgid was cleared after a write as needed
Date: Fri, 21 Nov 2025 14:10:50 +0100
Message-ID: <20251121130144.711425672@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
References: <20251121130143.857798067@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 9ff022f3820a31507cb93be6661bf5f3ca0609a4 ]

I noticed xfstests generic/193 and generic/355 started failing against
knfsd after commit e7a8ebc305f2 ("NFSD: Offer write delegation for OPEN
with OPEN4_SHARE_ACCESS_WRITE").

I ran those same tests against ONTAP (which has had write delegation
support for a lot longer than knfsd) and they fail there too... so
while it's a new failure against knfsd, it isn't an entirely new
failure.

Add the NFS_INO_REVAL_FORCED flag so that the presence of a delegation
doesn't keep the inode from being revalidated to fetch the updated mode.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fd86546fafd3f..88d0e5168093a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1577,7 +1577,8 @@ static int nfs_writeback_done(struct rpc_task *task,
 	/* Deal with the suid/sgid bit corner case */
 	if (nfs_should_remove_suid(inode)) {
 		spin_lock(&inode->i_lock);
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE
+				| NFS_INO_REVAL_FORCED);
 		spin_unlock(&inode->i_lock);
 	}
 	return 0;
-- 
2.51.0





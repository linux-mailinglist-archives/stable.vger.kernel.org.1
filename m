Return-Path: <stable+bounces-199416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE821CA031F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED0133047563
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8943559CF;
	Wed,  3 Dec 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VzFB6aCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AB35029B;
	Wed,  3 Dec 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779729; cv=none; b=PQkqCHMdr/DJCphDFB8xikaB0X5ZjEaDAxLVT6gv/gIFQXN97rs3fbOwUjvFcMbxK86ov9fxJ7InXqGLCFsrQQ7JCKfFWFh4bopiAortmRe/mpD9ctuyvxb2+9fR9UxXE41PdtgZYfDTncdzBjll5PJ9/ulma2CXmDZbDI19Wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779729; c=relaxed/simple;
	bh=TJ3oFH5bXx1lN+h/su4uCy2OlNWpsaUwxEqm1kP/HVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE+kAr7vIqtcGsWXVcn5ZJQww4xxLOnVlJHgboacoHIxD7egG1Q3dx1lj7mFuKsh75fo7SR0aLL3OlOvl5Kb/XsFfURvXG7lHHUCZUm5xJAL9A4vxTO9J+uxRn1/mA7zUtzthF517wflB9ONMnuEyMDkApMMwyPOey22NfEStnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VzFB6aCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754ACC4CEF5;
	Wed,  3 Dec 2025 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779728;
	bh=TJ3oFH5bXx1lN+h/su4uCy2OlNWpsaUwxEqm1kP/HVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzFB6aCftBDwBFMokajNlWZyuVlCzQHYFRkE/eDgoH5wFwZt026Md0ryq9XYeP56R
	 D4UH3ZrKAntMYy2WTj4r3QyWT2tw/eXPe+LzPNqazQW/yS/1XyZY8GLhqQmu+VmHJG
	 R4ybW1ShxlsIUlJa539kbH3coOKFS1ZNFFzNaEHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Mayhew <smayhew@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 343/568] NFS: check if suid/sgid was cleared after a write as needed
Date: Wed,  3 Dec 2025 16:25:45 +0100
Message-ID: <20251203152453.268153167@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index eb1fc33198be8..a20a381efc5df 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1633,7 +1633,8 @@ static int nfs_writeback_done(struct rpc_task *task,
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





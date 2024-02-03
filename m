Return-Path: <stable+bounces-18254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489118481FE
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E564C1F2353E
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF243ACE;
	Sat,  3 Feb 2024 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNsqw3n6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4612B89;
	Sat,  3 Feb 2024 04:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933662; cv=none; b=DcgKnoX7t4M2wTR4Bv7LAFSSdvQuvMJ98qJGN6kptGh+hzlScWc2H5njHZr9gktYg3NJZFAt1BHIyqXXlZLeSh7ErO2XawUd9GZBeSpE4WLGv8WS+Dy9R0TVklhj+ObwjaJXpszAoUQIDb7yMLBJ52E9kZfiVNsCYHVM4wK2nYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933662; c=relaxed/simple;
	bh=RROPyBK58BNDutCZh328bTmQMX+1nxZGLuTGZuFm5fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWuYzqUOfrpuUmU0l9Ph0cQwyvdCgxobM0F36kTQ/nPThdG4zjrpLPovGRAuwpyZ7jOdEV8923mCybMJ2nEc25ZN/YBWHj9zgB7/rwnp++8AxQXWoWrFPmSdKDajw0p1sWCKOsJOXpkpvksIbV6K090jBg0Esn7z0T9bZZxMjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNsqw3n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC0AC433F1;
	Sat,  3 Feb 2024 04:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933662;
	bh=RROPyBK58BNDutCZh328bTmQMX+1nxZGLuTGZuFm5fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNsqw3n6eiIjqo/zL4Lc+/EcfAZgrZMveFKWfyXcrvroGoO2hZaThZNMcvYT2I8Ld
	 iSH+wJIgXU5iQ5ObY6VTsywjIs3LGipUwpEy5ocP/iCunZTt4cak3glclfwJTeSHsc
	 Iemq12ugHhm5J7ZPrEK4qyk6CBSFDEhutbmPgqLA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venky Shankar <vshankar@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 250/322] ceph: reinitialize mds feature bit even when session in open
Date: Fri,  2 Feb 2024 20:05:47 -0800
Message-ID: <20240203035407.238819451@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Venky Shankar <vshankar@redhat.com>

[ Upstream commit f48e0342a74d7770cdf1d11894bdc3b6d989b29e ]

Following along the same lines as per the user-space fix. Right
now this isn't really an issue with the ceph kernel driver because
of the feature bit laginess, however, that can change over time
(when the new snaprealm info type is ported to the kernel driver)
and depending on the MDS version that's being upgraded can cause
message decoding issues - so, fix that early on.

Link: http://tracker.ceph.com/issues/63188
Signed-off-by: Venky Shankar <vshankar@redhat.com>
Reviewed-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 293b93182955..6d76fd0f704a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4010,11 +4010,11 @@ static void handle_session(struct ceph_mds_session *session,
 		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
 			pr_info("mds%d reconnect success\n", session->s_mds);
 
+		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
 			pr_notice("mds%d is already opened\n", session->s_mds);
 		} else {
 			session->s_state = CEPH_MDS_SESSION_OPEN;
-			session->s_features = features;
 			renewed_caps(mdsc, session, 0);
 			if (test_bit(CEPHFS_FEATURE_METRIC_COLLECT,
 				     &session->s_features))
-- 
2.43.0





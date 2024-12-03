Return-Path: <stable+bounces-96825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA49E21E5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C716C16413E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48F1F8919;
	Tue,  3 Dec 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2QmvGg7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7A1F891F;
	Tue,  3 Dec 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238702; cv=none; b=oHQz/xcPwp+KXq7dKu1iqnVOuGhhGWnuUtAAjC/ltyvG2YtqMSE4h3FTyFTx12pQXV+AxueDIdqldwTAv6hZwu0n53dWhQDYzBA2REpV0YsLISa4fx8lGTqCTkf/WXZQRfpGlDxFfMqN3oYqTh5aMB+28om3r7ibF47cfmV4iTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238702; c=relaxed/simple;
	bh=HC/gv9KseHHs7nFY/LGjZ1uU0vVtrAwYuoCSSLE4USQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD0kuLXzfn957RxcjkNDn+cQg1zUIoddvAFvhm7/6CNWUkro7vCnanOMP/vOpH+HFxB0nEf6e4eEC6iQjzvLKZvOjZUAYOEq8eSIvs+qMBr6nR147ojPXbzAMphqSCtOSCLTr2d4nEKTQVHFtYwKv0QP8OsPxHltmZVj0aHQJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2QmvGg7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B98C4CECF;
	Tue,  3 Dec 2024 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238701;
	bh=HC/gv9KseHHs7nFY/LGjZ1uU0vVtrAwYuoCSSLE4USQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2QmvGg7pX152ccXxkNV4ghhTezIYMORvxLhrqocJ/n5sIDsyM3dsnwhFyl3URNgZz
	 AY25+xy2J/CINgOxElq1tIkJfp7zNUKB2b9JRXRO9Zhb5CQBZ49uI6eRLGp0nOpwXz
	 MKNtppTDdOgsFY4LXIeA8+IJq+6lRvue3HwQTMA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 367/817] dlm: fix dlm_recover_members refcount on error
Date: Tue,  3 Dec 2024 15:38:59 +0100
Message-ID: <20241203144010.168203855@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 200b977ebbc313a59174ba971006a231b3533dc5 ]

If dlm_recover_members() fails we don't drop the references of the
previous created root_list that holds and keep all rsbs alive during the
recovery. It might be not an unlikely event because ping_members() could
run into an -EINTR if another recovery progress was triggered again.

Fixes: 3a747f4a2ee8 ("dlm: move rsb root_list to ls_recover() stack")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/recoverd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/recoverd.c b/fs/dlm/recoverd.c
index 34f4f9f49a6ce..12272a8f6d75f 100644
--- a/fs/dlm/recoverd.c
+++ b/fs/dlm/recoverd.c
@@ -151,7 +151,7 @@ static int ls_recover(struct dlm_ls *ls, struct dlm_recover *rv)
 	error = dlm_recover_members(ls, rv, &neg);
 	if (error) {
 		log_rinfo(ls, "dlm_recover_members error %d", error);
-		goto fail;
+		goto fail_root_list;
 	}
 
 	dlm_recover_dir_nodeid(ls, &root_list);
-- 
2.43.0





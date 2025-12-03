Return-Path: <stable+bounces-198601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04002C9FC5C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF33C3012CD8
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B032F745;
	Wed,  3 Dec 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRAmJpAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035332ED5F;
	Wed,  3 Dec 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777082; cv=none; b=UOLHLFo0TAn5aab1cgUZhMh4puMTlqhw21NotJFKw2ySWxhw31amdf+2dT3JeKNFf6RzCnGdsa5WboOOIvbLGhNV4cpmcTwbr3f5dkaDAhzYgThLntWKPwtn+2VKMOAIa76dhvt0hry5Zg8eW26kjxKMzKCsU7nOmdvl9szQjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777082; c=relaxed/simple;
	bh=Eoyd0UThvTIO/oLqgzP3pfWycRm1GukwzQRw3oJJgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6hyBhb5+Muc5fGtqgSF7HQl5sXVlYr2iSNHYecaBuouHYj85UVA0WCdDlbDOk/sX9SihBfusk7pBirhlVcHLBJzlQ24PBg+ZGaVdKwlqeAPcRwI6+kwhFdchhqpmOZW/Tq1aDmUkg4CdpXRqYeoLoNK9nFlznqt92mfnn3K3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRAmJpAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EBC4CEF5;
	Wed,  3 Dec 2025 15:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777082;
	bh=Eoyd0UThvTIO/oLqgzP3pfWycRm1GukwzQRw3oJJgG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRAmJpAzr8IOUITFsUPIyZieCE9roJk1ITRcSg4NFw5vI3z1tfMxeGSXbpAnR+BoE
	 zSjJnz08xSPdafhF4wbFBpomtpidKX48mzF0hcxZXIy0Yc9dDSAtEEU9DAZa1+8I9d
	 JZMZ669UzWZ1peXB81cstQSFKLNlQm7kJIjZX3NU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+bfc9a0ccf0de47d04e8c@syzkaller.appspotmail.com,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 043/146] ovl: fail ovl_lock_rename_workdir() if either target is unhashed
Date: Wed,  3 Dec 2025 16:27:01 +0100
Message-ID: <20251203152348.051323475@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

[ Upstream commit e9c70084a64e51b65bb68f810692a03dc8bedffa ]

As well as checking that the parent hasn't changed after getting the
lock we need to check that the dentry hasn't been unhashed.
Otherwise we might try to rename something that has been removed.

Reported-by: syzbot+bfc9a0ccf0de47d04e8c@syzkaller.appspotmail.com
Fixes: d2c995581c7c ("ovl: Call ovl_create_temp() without lock held.")
Signed-off-by: NeilBrown <neil@brown.name>
Link: https://patch.msgid.link/176429295510.634289.1552337113663461690@noble.neil.brown.name
Tested-by: syzbot+bfc9a0ccf0de47d04e8c@syzkaller.appspotmail.com
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 41033bac96cbb..ab652164ffc90 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1234,9 +1234,9 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *work,
 		goto err;
 	if (trap)
 		goto err_unlock;
-	if (work && work->d_parent != workdir)
+	if (work && (work->d_parent != workdir || d_unhashed(work)))
 		goto err_unlock;
-	if (upper && upper->d_parent != upperdir)
+	if (upper && (upper->d_parent != upperdir || d_unhashed(upper)))
 		goto err_unlock;
 
 	return 0;
-- 
2.51.0





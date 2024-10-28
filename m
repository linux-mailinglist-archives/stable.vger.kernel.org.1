Return-Path: <stable+bounces-88484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478489B262A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B951C2128F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DC18E04F;
	Mon, 28 Oct 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGsgtbNI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4543A15B10D;
	Mon, 28 Oct 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097437; cv=none; b=KvOaKcbTkUBydgcGdDIVJt7HyYZVusjnwf73dWreaCbi1kN8ObpWeAQ3FtAUCqvLidmY0D58FxfiHLbgiOfiRVyZWIaZQhSt0qXsM7mCV7A2vmaTJdNv8cm6W9xJyxXwB3snYnY28/wze/yfchlipfPxu4Wa1GrwBRrqDgsvRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097437; c=relaxed/simple;
	bh=ggNBlSLoTsCK3KifO4bcsK3eHccGxAq4qSQfJ8JZcEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMdOLkKPyKe+DvfPtGJ0ryCALqVzSCHw/sy+WKsggajZSdkLa8jDJ+uMqbfH0j55jbsXFXnbRR+t/xMxZv9i16ZKKn3O6PCIIALEGxRHC4ugTQHh+Rno89Xw7ZYdrFc1lJQF17Jy1JRZkfIR4dyQB5dTfN0DMkN/4YcNIRb0NnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGsgtbNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506FC4CEC3;
	Mon, 28 Oct 2024 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097437;
	bh=ggNBlSLoTsCK3KifO4bcsK3eHccGxAq4qSQfJ8JZcEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGsgtbNIF8OSLfBCJkLGj4g8DlmOkzSzNF0MThQuyIZcc6hQ061NumktlF7+GeM6s
	 yIMjiL8oB8jjJaG15dftA1q6uAs2oeDsg+YtCafmcqrMdHMeKdi3SdtkaP8u4yP2oG
	 pDyCpk1x6xwJ7viNtvUnLVDHRCV+XqQ61JYFJ5ts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Sun <samsun1006219@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/137] selinux: improve error checking in sel_write_load()
Date: Mon, 28 Oct 2024 07:26:07 +0100
Message-ID: <20241028062302.335348124@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Moore <paul@paul-moore.com>

[ Upstream commit 42c773238037c90b3302bf37a57ae3b5c3f6004a ]

Move our existing input sanity checking to the top of sel_write_load()
and add a check to ensure the buffer size is non-zero.

Move a local variable initialization from the declaration to before it
is used.

Minor style adjustments.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
[cascardo: keep fsi initialization at its declaration point as it is used earlier]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/selinuxfs.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a00d191394365..ab804d4ea9117 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -621,6 +621,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	/* no partial writes */
+	if (*ppos)
+		return -EINVAL;
+	/* no empty policies */
+	if (!count)
+		return -EINVAL;
+
 	mutex_lock(&fsi->state->policy_mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -629,26 +636,21 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (length)
 		goto out;
 
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	length = -ENOMEM;
 	data = vmalloc(count);
-	if (!data)
+	if (!data) {
+		length = -ENOMEM;
 		goto out;
-
-	length = -EFAULT;
-	if (copy_from_user(data, buf, count) != 0)
+	}
+	if (copy_from_user(data, buf, count) != 0) {
+		length = -EFAULT;
 		goto out;
+	}
 
 	length = security_load_policy(fsi->state, data, count, &load_state);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to load policy\n");
 		goto out;
 	}
-
 	length = sel_make_policy_nodes(fsi, load_state.policy);
 	if (length) {
 		pr_warn_ratelimited("SELinux: failed to initialize selinuxfs\n");
@@ -657,13 +659,12 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	}
 
 	selinux_policy_commit(fsi->state, &load_state);
-
 	length = count;
-
 	audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
 		"auid=%u ses=%u lsm=selinux res=1",
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
+
 out:
 	mutex_unlock(&fsi->state->policy_mutex);
 	vfree(data);
-- 
2.43.0





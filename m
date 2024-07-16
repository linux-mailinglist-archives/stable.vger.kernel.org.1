Return-Path: <stable+bounces-59528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068F932A90
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09611C22A7C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B55F9E8;
	Tue, 16 Jul 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xo7kon82"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183CD53B;
	Tue, 16 Jul 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144121; cv=none; b=Y3QMKvvatvkn3SdmOJhfiAr/wUIeEQYTcgHBwsfrtrYiWTxHPG1HPlhIyUvgnZfcH+dzZk32yVfLBxZ0B+KdJt+0+Mx1ioxoZJJSj9fd/AiT1KXtxQ7o9owIh62zDwHILJ/LyHQzaAbK5z+iC/gjlZ7jO6ep1fi8J+QliLCP3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144121; c=relaxed/simple;
	bh=CGRdCNdYWrBZDKEQthtaKPzVdshCAlWJo29KmEZcwj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhF/Ujs8gNAJKwnCYiIHaVMhG5GosIKAeeFvJhRtDUuDJmkA5UIPWSmIN9cIfH6/AA3654J/QYFw7hqJH4hddY0Q8taYpTOfllAIoEuClN4AjBXLSGh7Qos5IOwX3UlRpLW4BTO2BaAQEc34kHuT+YPYIp1zB34Fi/mckXvmsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xo7kon82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E257C116B1;
	Tue, 16 Jul 2024 15:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144121;
	bh=CGRdCNdYWrBZDKEQthtaKPzVdshCAlWJo29KmEZcwj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo7kon82x31UQaAz9AlPSzKwC8TRTDy99ig0q3CVxM8sYiF7FBgTEFh6ILfjBg3T9
	 dVuEsN09zSiiFHEzTniNeAEyK/xNddMRkUVab3dlF+BHxyLfcYZlEtdC2/+HGpuVPE
	 IAUsvOUqb6I5Y0klayQanoRamR/PY1E408EUhTX4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 4.19 34/66] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue, 16 Jul 2024 17:31:09 +0200
Message-ID: <20240716152739.469038370@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 702eb71fd6501b3566283f8c96d7ccc6ddd662e9 upstream.

Currently we will not generate FS_OPEN events for O_PATH file
descriptors but we will generate FS_CLOSE events for them. This is
asymmetry is confusing. Arguably no fsnotify events should be generated
for O_PATH file descriptors as they cannot be used to access or modify
file content, they are just convenient handles to file objects like
paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
file descriptors.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240617162303.1596-1-jack@suse.cz
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fsnotify.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -34,7 +34,13 @@ static inline int fsnotify_perm(struct f
 	__u32 fsnotify_mask = 0;
 	int ret;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 	if (!(mask & (MAY_READ | MAY_OPEN)))
 		return 0;




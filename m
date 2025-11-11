Return-Path: <stable+bounces-194172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CCC4AE23
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1BF189738F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E9337BB4;
	Tue, 11 Nov 2025 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLM1hz/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECD189B84;
	Tue, 11 Nov 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824976; cv=none; b=qgA+q/I7ku4StWmbMNKeLIGSWJzxjU3m6vzqT5ea0qD4jLPAY+q+7NSXjUwV50K7jUfcvFyx/VkI+pwSkbU7k4/XvrTqVPrcb8VhIXssTfGUJ9OoEjxf0NQRvXwP9YHLWPwrUD1Pqwt3zjUk5SAd4D8y3klNYd6mHWWZ0wVIz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824976; c=relaxed/simple;
	bh=oWH1eIlEGD8fzilm8dhRcs2leMx6so2Jowkyfp09ajE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffwd7nFSG+/veysDN4UUda1JO+5t4RgT0aEJq+7uZFMTvkzBtryKx39hHY+0gzUACe8IyFAHRcxMBNATtvMQJJvtYHcP+aHeDThpc8hVMJ1rx7OOBNTC+ITOGvDf6p96ErHaUGTTDx5njZ0rzc75jyrAWwe6SnLyXH8foEuSm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLM1hz/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B639C116D0;
	Tue, 11 Nov 2025 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824975;
	bh=oWH1eIlEGD8fzilm8dhRcs2leMx6so2Jowkyfp09ajE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLM1hz/E9pQ4G+q1Irc5p0Rfaw977jqPfFzsYyHsx4y4DnUD5YvFwhxLN9JYfQk/2
	 mEC0wBRBHYTL4mZXvXXbe8RiL0UI0i7cVtRuCazDEl2N8h5J96hHmckOjkcHZWOaAw
	 J9e6G6VGk4e7dLQqJYHbBtmuoFV1jCa2SuF1KDU0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 608/849] vfio: return -ENOTTY for unsupported device feature
Date: Tue, 11 Nov 2025 09:42:58 +0900
Message-ID: <20251111004551.122922518@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

From: Alex Mastro <amastro@fb.com>

[ Upstream commit 16df67f2189a71a8310bcebddb87ed569e8352be ]

The two implementers of vfio_device_ops.device_feature,
vfio_cdx_ioctl_feature and vfio_pci_core_ioctl_feature, return
-ENOTTY in the fallthrough case when the feature is unsupported. For
consistency, the base case, vfio_ioctl_device_feature, should do the
same when device_feature == NULL, indicating an implementation has no
feature extensions.

Signed-off-by: Alex Mastro <amastro@fb.com>
Link: https://lore.kernel.org/r/20250908-vfio-enotty-v1-1-4428e1539e2e@fb.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5046cae052224..715368076a1fe 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1251,7 +1251,7 @@ static int vfio_ioctl_device_feature(struct vfio_device *device,
 			feature.argsz - minsz);
 	default:
 		if (unlikely(!device->ops->device_feature))
-			return -EINVAL;
+			return -ENOTTY;
 		return device->ops->device_feature(device, feature.flags,
 						   arg->data,
 						   feature.argsz - minsz);
-- 
2.51.0





Return-Path: <stable+bounces-193861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661CC4A8A0
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F183B34C4EC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE4345740;
	Tue, 11 Nov 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o32rClUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04595274659;
	Tue, 11 Nov 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824179; cv=none; b=ZDeDdyUjq9aUN/hiqD+19WIv5vM4nfAUE8VMgk2GTPu18eqUMR42n/duGqHKVVvbqAXLtUhihqCsJUStsoluX19UuOS1fhp86mrkPyjzVl/cmilOsgN9MXYTMCHJGnZ+RpkQKFjwhFpXBWN6VSnRWHUGVhcTPLFe8kd3jxtfrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824179; c=relaxed/simple;
	bh=g65qthNIyzBrw38bAwpnA9KIluwyyyWtVnkFsV/dzcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsyZyehWX/p6WISplV2g3TO1C+vQTGtMxfxLA9VsbpOVzCOFQ0hae8S76ZjuvzyS/A5oxoTP8D6LEpyhwgn3eCcbq7kKmpL4Z/I40cE3Vjfg+xkCclMaLTrUzqq1u99+AoWOyz5/Wn4e018Y2rTvclH5I3+PcIHHC2imjN+CTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o32rClUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96585C116D0;
	Tue, 11 Nov 2025 01:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824178;
	bh=g65qthNIyzBrw38bAwpnA9KIluwyyyWtVnkFsV/dzcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o32rClUYeHbARMUg6XNtRY5pgviRVUetNc7hP9jyLtxQoq3/aeH+FouLDKHMXtOkf
	 jJWhGECBuo/IkVtqywFbeDHQ+kn1rt8ACHAM0Y3xzfzexmpqpdhFba5mwhtK1NJv0M
	 zLUvSct4dcllmU8vOLqKVdiQmeaToLcR59SO+qSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 405/565] vfio: return -ENOTTY for unsupported device feature
Date: Tue, 11 Nov 2025 09:44:21 +0900
Message-ID: <20251111004535.984138762@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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
index ae78822f2d715..0ed42769742a8 100644
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





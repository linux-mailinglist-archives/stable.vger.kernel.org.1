Return-Path: <stable+bounces-23108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B7385DF4F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9550328375E
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7817BB01;
	Wed, 21 Feb 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XH//7BSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6F78B73;
	Wed, 21 Feb 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525601; cv=none; b=ZLZ2fw5aWrLxAvBlMYDd0d/EzD2UZPMq1gqbJp3nL55tlSrnxl+Be0P5MfxywXug67mq78tpA5d3Ikz7BJhkRkQdh0EEmySz5pCQWSqfDiCOvy7kqMKWBgx2x+7JVxEKbszzZnhJ47IUh/x81emolkQG1pzPhFVY4jkCLC/Ku34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525601; c=relaxed/simple;
	bh=xiYW76gwzki4L249pSFrDneJLNWzZGz/kdAyResKxqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSoBlOd+YUh0yTS246CfwBHj1a3rECR+2VWA9qsppQespt7wTARgIJhBKwORWuc/oLScjVlEXzHQEFgiNrW1VCrh+hkmsNeJ8+CISu9ovGv9ewzVUVsFEFU96AEx/+67oVHr3EhB/lj+4UhukRvmbta8ELZ0DF1YB8LZKCCIsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XH//7BSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B162AC433C7;
	Wed, 21 Feb 2024 14:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525600;
	bh=xiYW76gwzki4L249pSFrDneJLNWzZGz/kdAyResKxqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XH//7BSJo40wHqG2xynbh0aNTNKyICGMBYJJWCS2XzTqyCtAfYUm4d4jx2jNiZraD
	 PWcn4fD/eHW1Y35Zhh69WQ/pcJBuFUGgfcnu5CvqZ0SNT0TayhM+KEeAw8zYJL1pbx
	 Hrkjrsovcknj6SQPzqzqEUg7i45xmqxIT4Ftn2gs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 205/267] btrfs: forbid deleting live subvol qgroup
Date: Wed, 21 Feb 2024 14:09:06 +0100
Message-ID: <20240221125946.613805866@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit a8df35619948bd8363d330c20a90c9a7fbff28c0 upstream.

If a subvolume still exists, forbid deleting its qgroup 0/subvolid.
This behavior generally leads to incorrect behavior in squotas and
doesn't have a legitimate purpose.

Fixes: cecbb533b5fc ("btrfs: record simple quota deltas in delayed refs")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1561,6 +1561,15 @@ out:
 	return ret;
 }
 
+static bool qgroup_has_usage(struct btrfs_qgroup *qgroup)
+{
+	return (qgroup->rfer > 0 || qgroup->rfer_cmpr > 0 ||
+		qgroup->excl > 0 || qgroup->excl_cmpr > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_DATA] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC] > 0 ||
+		qgroup->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > 0);
+}
+
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1580,6 +1589,11 @@ int btrfs_remove_qgroup(struct btrfs_tra
 		goto out;
 	}
 
+	if (is_fstree(qgroupid) && qgroup_has_usage(qgroup)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Check if there are no children of this qgroup */
 	if (!list_empty(&qgroup->members)) {
 		ret = -EBUSY;




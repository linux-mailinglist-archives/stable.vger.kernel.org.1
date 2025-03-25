Return-Path: <stable+bounces-126130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0004FA6FF97
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A4841D3B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1F266B4A;
	Tue, 25 Mar 2025 12:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/oFvdcO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830B257455;
	Tue, 25 Mar 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905657; cv=none; b=Eo6BIX0Kd/QpFth0PvQyUrQ/qPBp4VmRDc5wlsQ8gwvR38c2I2ux6IBkiCGkXT3Ywx0QBCE5raECOzYfHTpfNm0tiBGFvlmMButNvyyPVAHaYSaP29a/lAP+1toSDsg5gFkrd62yKUCdKRadWSuxzzS13jLYa9yFDeykTjkpIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905657; c=relaxed/simple;
	bh=Q9oL8wboPKkUrjV4kbb2NL5ClHZ4WLvXfISlA9cyVVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTVX2mm971OzldWTfqD7KfIPTsQI8fzJgEDJx0f8CmIS2+S6M46BBhKB92QMAolB03OtLtgRFe0JLiAgyEpEJsR4rqlW7VZbVcOqstpUEjbVbRcXgdv+nC7pcvkPIz2AlvsupGfSv7C/NC2hp/Y0LIoM3mvEAl58ZLAhKjOMU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/oFvdcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76713C4CEE4;
	Tue, 25 Mar 2025 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905656;
	bh=Q9oL8wboPKkUrjV4kbb2NL5ClHZ4WLvXfISlA9cyVVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w/oFvdcOpIUlSA1EQ+x2ZCnFingvAkwBaBLkOVpBMCOFBS3yWtUscf+bthb82Hjjh
	 HXNNPof6qAWQ/IvzbT47nyepFGnBl6uD+x3dKWCNjGoGUS9mgXSzKPUziAfT6rchMP
	 6mMbGtulbgzHdRcdd668l6TuUekwaU2ZXwaz+2mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 092/198] xfs: fix 32-bit truncation in xfs_compute_rextslog
Date: Tue, 25 Mar 2025 08:20:54 -0400
Message-ID: <20250325122159.062800870@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit cf8f0e6c1429be7652869059ea44696b72d5b726 ]

It's quite reasonable that some customer somewhere will want to
configure a realtime volume with more than 2^32 extents.  If they try to
do this, the highbit32() call will truncate the upper bits of the
xfs_rtbxlen_t and produce the wrong value for rextslog.  This in turn
causes the rsumlevels to be wrong, which results in a realtime summary
file that is the wrong length.  Fix that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/libxfs/xfs_rtbitmap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -1133,13 +1133,15 @@ xfs_rtalloc_extent_is_free(
 
 /*
  * Compute the maximum level number of the realtime summary file, as defined by
- * mkfs.  The use of highbit32 on a 64-bit quantity is a historic artifact that
- * prohibits correct use of rt volumes with more than 2^32 extents.
+ * mkfs.  The historic use of highbit32 on a 64-bit quantity prohibited correct
+ * use of rt volumes with more than 2^32 extents.
  */
 uint8_t
 xfs_compute_rextslog(
 	xfs_rtbxlen_t		rtextents)
 {
-	return rtextents ? xfs_highbit32(rtextents) : 0;
+	if (!rtextents)
+		return 0;
+	return xfs_highbit64(rtextents);
 }
 




Return-Path: <stable+bounces-34738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDB589409E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD99B20B71
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4CA38F84;
	Mon,  1 Apr 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qzD3nvoT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E81E525;
	Mon,  1 Apr 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989132; cv=none; b=FsXLLJv7GGOPQFXmofYi2DE2NNNRvhC7UqpB/u4/dDwIvbSoswNklSuwRlouMOEsbrgHQ9nQ+n2aJ4lwNH3CJRXakO2X3xI/Ud2ptnqdw7pc10RSUBuxq8KDIjRNE1q5BtlJgneoiCZzLoeg9HgeRg1wz83YPOEWQCnwyBYUPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989132; c=relaxed/simple;
	bh=B5PPOuraEp3mkjcSuNKl5lCSGl3x80jY7lEKUIcsp6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH1wkhv+e3sRH42FDEpumRBn7tQyFifl4Yv1J05dVj4QcymCEwQIPyxVSP1VYKrEZUz711/N5CPL/PltvUGtVZihn15scHfv55wox2V2dc06sXBS4rfjbSZLyVgE4bXTlO6W1+ouIK9dS9HbNLFV7A8wCZyFKrRshwFfvMuF+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qzD3nvoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15097C433C7;
	Mon,  1 Apr 2024 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989132;
	bh=B5PPOuraEp3mkjcSuNKl5lCSGl3x80jY7lEKUIcsp6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzD3nvoT28PIY1VmOtQHWvLzO0TcKQRndmpgM5EsTjH6sGo09pdE0EhowpDoc2VuK
	 ZW6Un4TCyulgLCnO4XjlYr1oZkUDrevqDAfkEId79b4yXfdGrAzANQTyfcICW3s6WZ
	 iamu3m1XQv05f5aNNp5eHiREP4Y22rKU8vUXlFro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Wetzel <Alexander@wetzel-home.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.7 391/432] scsi: sg: Avoid sg device teardown race
Date: Mon,  1 Apr 2024 17:46:18 +0200
Message-ID: <20240401152604.990635757@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Wetzel <Alexander@wetzel-home.de>

commit 27f58c04a8f438078583041468ec60597841284d upstream.

sg_remove_sfp_usercontext() must not use sg_device_destroy() after calling
scsi_device_put().

sg_device_destroy() is accessing the parent scsi_device request_queue which
will already be set to NULL when the preceding call to scsi_device_put()
removed the last reference to the parent scsi_device.

The resulting NULL pointer exception will then crash the kernel.

Link: https://lore.kernel.org/r/20240305150509.23896-1-Alexander@wetzel-home.de
Fixes: db59133e9279 ("scsi: sg: fix blktrace debugfs entries leakage")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
Link: https://lore.kernel.org/r/20240320213032.18221-1-Alexander@wetzel-home.de
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2207,6 +2207,7 @@ sg_remove_sfp_usercontext(struct work_st
 {
 	struct sg_fd *sfp = container_of(work, struct sg_fd, ew.work);
 	struct sg_device *sdp = sfp->parentdp;
+	struct scsi_device *device = sdp->device;
 	Sg_request *srp;
 	unsigned long iflags;
 
@@ -2232,8 +2233,9 @@ sg_remove_sfp_usercontext(struct work_st
 			"sg_remove_sfp: sfp=0x%p\n", sfp));
 	kfree(sfp);
 
-	scsi_device_put(sdp->device);
+	WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);
 	kref_put(&sdp->d_ref, sg_device_destroy);
+	scsi_device_put(device);
 	module_put(THIS_MODULE);
 }
 




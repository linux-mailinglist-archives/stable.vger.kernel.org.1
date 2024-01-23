Return-Path: <stable+bounces-13592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AD837D02
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930B0290EE6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C71315E26C;
	Tue, 23 Jan 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEDGGAv7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6815E265;
	Tue, 23 Jan 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969764; cv=none; b=naCKP2TvM93QhcHgi9zPgBncmOzwK3X7ZbJdWiaJ594/W0K5w6uS6ttEVLf4lL/wqud89B+WCHq4HC/onlfgY5DwEdjxb6BTtTUGW8VIJXO2OisGJFjzAePQIF1jCxb17LshK+NOsvvAxvC6CXOf0sq0up9mXQMs6xeEIIiWkfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969764; c=relaxed/simple;
	bh=25pfj5bKD6fLtqcoAmzjpsjm0LS+NzAtdIpxkfmjAXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHP26Ekq/GufT5jpsys7TALMa2Zij7HYhe0uMXBQQGz06TjXP1Vdq9rbuRpkPQuvRGdpjicPGhj7pLSorQ5KThZBAxcJEOuysMmJQpj5EPhq7ZbiZElCZbzkIJz1tnYvPx/fYwmv1b8NFFKH7kGDXu56BC4QRHlGxy6QaawH33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEDGGAv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC00C43601;
	Tue, 23 Jan 2024 00:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969764;
	bh=25pfj5bKD6fLtqcoAmzjpsjm0LS+NzAtdIpxkfmjAXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEDGGAv7gp/NSKRLmzEwcyhyn8hYgiat4dA1dPWJLhulOYYsAwhuN+TQXD58+9hBk
	 hCx3H5tuQcS4uJwIGDgVM/4hT8HGM69lmPdsnWIxevCqIQ9uyJ1B+5QEy/S7VrfVj2
	 XYFpQhhs5KSl52XiuGQ8gjrwfZ52qLAoBGxDuG9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.7 436/641] scsi: mpi3mr: Clean up block devices post controller reset
Date: Mon, 22 Jan 2024 15:55:40 -0800
Message-ID: <20240122235831.638714642@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

From: Chandrakanth patil <chandrakanth.patil@broadcom.com>

commit c01d515687e358b22aa8414d6dac60d7defa6eb9 upstream.

After a controller reset, if the firmware changes the state of devices to
"hide", then remove those devices from the OS.

Cc: <stable@vger.kernel.org> # v6.6+
Co-developed-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Chandrakanth patil <chandrakanth.patil@broadcom.com>
Link: https://lore.kernel.org/r/20231126053134.10133-3-chandrakanth.patil@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -1047,8 +1047,9 @@ void mpi3mr_rfresh_tgtdevs(struct mpi3mr
 	list_for_each_entry_safe(tgtdev, tgtdev_next, &mrioc->tgtdev_list,
 	    list) {
 		if ((tgtdev->dev_handle == MPI3MR_INVALID_DEV_HANDLE) &&
-		    tgtdev->host_exposed && tgtdev->starget &&
-		    tgtdev->starget->hostdata) {
+		     tgtdev->is_hidden &&
+		     tgtdev->host_exposed && tgtdev->starget &&
+		     tgtdev->starget->hostdata) {
 			tgt_priv = tgtdev->starget->hostdata;
 			tgt_priv->dev_removed = 1;
 			atomic_set(&tgt_priv->block_io, 0);
@@ -1064,6 +1065,10 @@ void mpi3mr_rfresh_tgtdevs(struct mpi3mr
 				mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
 			mpi3mr_tgtdev_del_from_list(mrioc, tgtdev, true);
 			mpi3mr_tgtdev_put(tgtdev);
+		} else if (tgtdev->is_hidden & tgtdev->host_exposed) {
+			dprint_reset(mrioc, "hiding target device with perst_id(%d)\n",
+				     tgtdev->perst_id);
+			mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
 		}
 	}
 




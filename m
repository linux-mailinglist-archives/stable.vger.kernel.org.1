Return-Path: <stable+bounces-15280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389F838591
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A19B29E53
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2E745C1;
	Tue, 23 Jan 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="He0ZIDNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED87318E;
	Tue, 23 Jan 2024 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975440; cv=none; b=m2FIvhkKoWjlAbUvDbPH5u7Ljf4jxBjfZS8TgmZ1UY/OnabK4MFTt+6ftPfxaBDH5u4IfM7mobpUYjJxNkeWLOJwq0uX2vOZ7wZFcyZ4XSZ2HsYwrE1w1fgAzhGEu+ZKSQysPpj+HYYy5XGfrvd1NFz0aF6YCaB6uqBTLL52sWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975440; c=relaxed/simple;
	bh=LetyzKnkv85dJs0nAxbhwzCI1IMxMt1igl8ctua4Kh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udY9ZWEvtfJqiSsn72KGIs6pMBfJGEK2LHaFRrHP5lMZytLml9HbD2A0/WSeTTWkXeFQQngj0Z6t+JQKLwJDjrb2gyowZMA+hK61yfqrmqkThp2noSY+yeW2qro492HPNHp7Y3gfYFwGvddlLJW9UYj/llPriLG5WArffDLwWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=He0ZIDNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0DC43390;
	Tue, 23 Jan 2024 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975440;
	bh=LetyzKnkv85dJs0nAxbhwzCI1IMxMt1igl8ctua4Kh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=He0ZIDNN0r/aJSdrCWriz76QAbACBI5PZ8w0M5Fl2qpIIF/vOXjpD1DY1MDlfyfjy
	 kgeAizJyAYjRA3cGpGBSSq47yPNyO7pTKr94dThUhReoWNaykakMFDXp/CgwhZWKqt
	 9yxRJaH/oG76APbHmnqh4bLf0BsEG/124Ggx3PkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 398/583] scsi: mpi3mr: Block PEL Enable Command on Controller Reset and Unrecoverable State
Date: Mon, 22 Jan 2024 15:57:29 -0800
Message-ID: <20240122235824.162058737@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chandrakanth patil <chandrakanth.patil@broadcom.com>

commit f8fb3f39148e8010479e4b2003ba4728818ec661 upstream.

If a controller reset is underway or the controller is in an unrecoverable
state, the PEL enable management command will be returned as EAGAIN or
EFAULT.

Cc: <stable@vger.kernel.org> # v6.1+
Co-developed-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Chandrakanth patil <chandrakanth.patil@broadcom.com>
Link: https://lore.kernel.org/r/20231126053134.10133-4-chandrakanth.patil@broadcom.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpi3mr/mpi3mr_app.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -223,6 +223,22 @@ static long mpi3mr_bsg_pel_enable(struct
 		return rval;
 	}
 
+	if (mrioc->unrecoverable) {
+		dprint_bsg_err(mrioc, "%s: unrecoverable controller\n",
+			       __func__);
+		return -EFAULT;
+	}
+
+	if (mrioc->reset_in_progress) {
+		dprint_bsg_err(mrioc, "%s: reset in progress\n", __func__);
+		return -EAGAIN;
+	}
+
+	if (mrioc->stop_bsgs) {
+		dprint_bsg_err(mrioc, "%s: bsgs are blocked\n", __func__);
+		return -EAGAIN;
+	}
+
 	sg_copy_to_buffer(job->request_payload.sg_list,
 			  job->request_payload.sg_cnt,
 			  &pel_enable, sizeof(pel_enable));




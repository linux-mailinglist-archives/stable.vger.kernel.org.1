Return-Path: <stable+bounces-132226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D684AA85B5F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED2D19E5DEB
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124020D509;
	Fri, 11 Apr 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iItvVO66"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC7278E4A
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370359; cv=none; b=FdPws1/SUziPz4yoMb+lO+8Ht605oYr3LzWSAjT1FsQyICCYT8O0AD0MXoceQy4sIDL1B7odatIxB/307TVs0byAOlCBwukYA1HXEbmU9zwTD1sBD5PlmIxsnx4Z0FFrXG9oU3a4svly54q3tABx9lY/5mPLPExgulDMommrxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370359; c=relaxed/simple;
	bh=0Li/qqcuMF5C+sKteXxSetwme8NCv2hfNLGDfl1J4Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnJRcH6UgyeFXseVOXQqATSwirL9RcY4yWAN5C2a732PWeFgjmt58KnhuvrKpyMagO0z9+5pVxSzxnYbLDdHL6JOggK/Gds17RQV62jniORrG0utaONAtiuAPjrHt8nsAPOWMpjn5Mt9V805c52S72ElMOiXrz0PdM/Xau/4svk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iItvVO66; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso1876577b3a.2
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744370357; x=1744975157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m/3d3TtE5r56N988VKyJ5gOZ77ZQPrrPQjrW9ZMYPo=;
        b=iItvVO66uqzMhK+/Qp4Ni8+tuqzhsxLXnB41nqDGLGTD+CxfuxO3MKF3Zz6sU5NWVV
         X4sdf3a4YamsKPirNR8O6juV20SFz/9TdFpjizZcY+K1LNiXPK/AfxeHTKqXmh2xFlBW
         zfqNOeN9EYCuPicHoOqqZvTKW33zmEjEAvZ0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744370357; x=1744975157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m/3d3TtE5r56N988VKyJ5gOZ77ZQPrrPQjrW9ZMYPo=;
        b=B0gUqxNAyotuqC5U0r7Q92xWV/MszczYY+1/YEFeQtHghu0e7eNksHCZx20ATgPT/f
         tMb+pprocvyXNdYQf+Oc0/lwFEnXO4QZ0ZH2tRqk4G958hgPmgcL15qDDZx4WtYMrOis
         80leU5KumU0Gg70IvP+ikSwUc7zwCOiTwlA9U+renevvD5qSTH43cew7f0QN9igpwRfL
         mjbOLo8PAg/QCc5ELZW9FlqljPjwZpO1i5PmS22sZ2Hn20bUDjY0u14OpVbiUq3TZ/jG
         YITgmGqW8pka0NlNs2bcb8K69RBpQzWk228W2YNo7+PjBKUul2jyyf4m4NauO1LV8OUL
         jSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVpg7pgdiQfe2rhIjAb3d3NpFkb5+1V9Vz3MvBVa1MAuFHVPMDi8YAuq0aGR0IVR1dHsbH0U2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynvaVoW2aEvhn1l6pRmucMcIb4EEyKBGisKzKXZfMWJBCYzEg
	TO3uD+oJO7FoVTP6wxMnNdzliqngp3kWnOk7y8D7x4TUyvJ/N7soBYknb9btqw==
X-Gm-Gg: ASbGncvhcJMLPnzj2pj+WGFqwRZNOJdjpIn+/95NBfrRv46dmA3E0YPi+2gt5OYTyEA
	Jj+0yZAGXJNScpshVA9THs6xGqcl6/5kt2/u+YXLgVOUrA9vxRGnHKcgxff/Di7sdPUC8GU0JGK
	JwuGAHg6/GLwTx3c7UI5QACBVv/gELNOdpzGJkop2lJQmLLtkmj8tleh8jp/XQ0cGYsQOm10Nif
	v17ES0UD6pIOPap5zly325+YzuJZFptK/qLuwbU8qPgB0lidKByEKS0+XK1pSIFTflFbqd5oGXY
	7RCPZIf8b+muzNFoLxkWshfYI497s3UPEbXWjxaTgs8WAlu3kyR1h8NNxTaxsxOXAnLlq+4p6mL
	w8+8QtLuI
X-Google-Smtp-Source: AGHT+IHdB7cuaz+h6Nd3nw3MX6wsA00yUMF4he1ZUzS+zxMceGqPQacHi3ZzkELiHzuL2/A+pkFjzQ==
X-Received: by 2002:a05:6a00:a91:b0:736:62a8:e52d with SMTP id d2e1a72fcca58-73bd11fe733mr3546676b3a.12.1744370357057;
        Fri, 11 Apr 2025 04:19:17 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c65c9sm1266920b3a.61.2025.04.11.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 04:19:16 -0700 (PDT)
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
To: linux-scsi@vger.kernel.org,
	martin.petersen@oracle.com
Cc: rajsekhar.chundru@broadcom.com,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	prayas.patel@broadcom.com,
	tadamsjr@google.com,
	vishakhavc@google.com,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] Regression fix: Fix pending IOs counter per reply queue
Date: Fri, 11 Apr 2025 16:44:18 +0530
Message-Id: <20250411111419.135485-2-ranjan.kumar@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250411111419.135485-1-ranjan.kumar@broadcom.com>
References: <20250411111419.135485-1-ranjan.kumar@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 199510e33dea ("scsi: mpi3mr: Update consumer index of
reply queues after every 100 replies") introduced a regression
with Per reply queue pending IOs counter was wrongly decremented
leading to counter getting negative.

Fixed the issue by dropping the extra atomic decrement for
pending IOs counter.

Fixes: 199510e33dea ("scsi: mpi3mr: Update consumer index of reply queues after every 100 replies")
Cc: stable@vger.kernel.org
Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 3fcb1ad3b070..d6e402aacb2a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -565,7 +565,7 @@ int mpi3mr_process_op_reply_q(struct mpi3mr_ioc *mrioc,
 		WRITE_ONCE(op_req_q->ci, le16_to_cpu(reply_desc->request_queue_ci));
 		mpi3mr_process_op_reply_desc(mrioc, reply_desc, &reply_dma,
 		    reply_qidx);
-		atomic_dec(&op_reply_q->pend_ios);
+
 		if (reply_dma)
 			mpi3mr_repost_reply_buf(mrioc, reply_dma);
 		num_op_reply++;
-- 
2.31.1



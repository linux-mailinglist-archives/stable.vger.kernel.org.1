Return-Path: <stable+bounces-187331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1635FBEAAD7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7247C136E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272DE330B22;
	Fri, 17 Oct 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MnekKmeC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6380330B04;
	Fri, 17 Oct 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715776; cv=none; b=qytAucO5IrgdKPvSsx9JZjD1jyWHeGcvgrWGrk0qcnA3mXQYCl81fQGculykddRYWkR3yUr11kPAUaQ95R0YaTI3THlPdE/ciekemjnrUZzxEMSAliNQ3FJq6MmRt3uH0jUU9KI+0wkP6uZO7Fs/M12i6x4SPLPF73PLSADGMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715776; c=relaxed/simple;
	bh=SxjNYCoRdeUvoL1JbVg16zVtASsTNvuHi7/3uiLhy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCHfjSRZ8GFDfyBNZkd1J9xgEghMQ5iqNYJkwc9Ms6/BtIruK3xOnYlJO3/sB31PbI96UwBhTdAjrgdKudBppxaLs+xmcz5pxsQO9WfTrXS4Ulu+RW+T24FWFbk2mvhJAtl0VDKVzvoRqHgXGZvkpTJvIu3FAxjjWxE42k5xLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MnekKmeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F50BC4CEE7;
	Fri, 17 Oct 2025 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715776;
	bh=SxjNYCoRdeUvoL1JbVg16zVtASsTNvuHi7/3uiLhy8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnekKmeC9p/JZRdpy1BzeISXR0AHixoPDfGJ7IJcZlKsBsUbRhV1vwV7raqGaxdxR
	 rU1Uvii9GWdRA19gSQNiRDxus/+0j5Vt1rWSEKEFAYLHYbMPAzLGsItt2XDnLzgD9p
	 IeTJAM8OZc2WzAWL3aGKn1Rvr5aH36ABbLrZ9H8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Haberland <sth@linux.ibm.com>,
	Jaehoon Kim <jhkim@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.17 306/371] s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
Date: Fri, 17 Oct 2025 16:54:41 +0200
Message-ID: <20251017145213.147582351@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

From: Jaehoon Kim <jhkim@linux.ibm.com>

commit 8f4ed0ce4857ceb444174503fc9058720d4faaa1 upstream.

Currently, if CCW request creation fails with -EINVAL, the DASD driver
returns BLK_STS_IOERR to the block layer.

This can happen, for example, when a user-space application such as QEMU
passes a misaligned buffer, but the original cause of the error is
masked as a generic I/O error.

This patch changes the behavior so that -EINVAL is returned as
BLK_STS_INVAL, allowing user space to properly detect alignment issues
instead of interpreting them as I/O errors.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Cc: stable@vger.kernel.org #6.11+
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3119,12 +3119,14 @@ static blk_status_t do_dasd_request(stru
 		    PTR_ERR(cqr) == -ENOMEM ||
 		    PTR_ERR(cqr) == -EAGAIN) {
 			rc = BLK_STS_RESOURCE;
-			goto out;
+		} else if (PTR_ERR(cqr) == -EINVAL) {
+			rc = BLK_STS_INVAL;
+		} else {
+			DBF_DEV_EVENT(DBF_ERR, basedev,
+				      "CCW creation failed (rc=%ld) on request %p",
+				      PTR_ERR(cqr), req);
+			rc = BLK_STS_IOERR;
 		}
-		DBF_DEV_EVENT(DBF_ERR, basedev,
-			      "CCW creation failed (rc=%ld) on request %p",
-			      PTR_ERR(cqr), req);
-		rc = BLK_STS_IOERR;
 		goto out;
 	}
 	/*




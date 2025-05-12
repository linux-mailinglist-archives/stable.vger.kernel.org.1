Return-Path: <stable+bounces-143148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECACAB32AF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABA41781A8
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266661C8631;
	Mon, 12 May 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sgA5o1S3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9967433A0
	for <stable@vger.kernel.org>; Mon, 12 May 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040652; cv=none; b=GH3aRcR7H87o2PO7bgXayXSmRfcaKXJ2J2vBvVhf6sN6A4ShMIWyw5HVOBjU5Gu83RPZ1i/yAtNump02egvwwoFgleg2lDxNfm1RwxszN2X8Byj/v5HQa/ubgIDDP82Nibsiy6andkQEXI1HvOiWYwyyaYJa9XVz2+en4PpwJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040652; c=relaxed/simple;
	bh=yl8sxh+Be/3psoxfTr3zkzBj95unKBqw/OwSqhNd8lU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hdhvffg0NwPLxerh5c0XzxDfpUQUGSjhz5GXVUU6STvKYMmMp/hUy0QZQcTmV63WjPuBuSQ1KEzwjAa2pHDLD3Yt+uLVQS7CVHUur5X36FrAIybTvnqJE0EJVx/Uw2eAFmkIm+6OCGn/pDitCHQ+bmxtQ9M7fdMzCsqIGD3CuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sgA5o1S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2170C4CEED;
	Mon, 12 May 2025 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747040652;
	bh=yl8sxh+Be/3psoxfTr3zkzBj95unKBqw/OwSqhNd8lU=;
	h=Subject:To:Cc:From:Date:From;
	b=sgA5o1S3KnccY9Vvpv+YnTzSTbjOCdMip/hDU0yu5P56N9EmpwIlQKVqqaxXr1Z6y
	 tjj3CQMd3+S57Tp7W0qldcnWnY1Y+7T6jnx3edC42PlX3ZO9XKsEgXNm0STLb7XcMQ
	 JohOtTT+LZbGKB4KLUJjaozyKVHWLqboPXPxb28M=
Subject: FAILED: patch "[PATCH] staging: axis-fifo: Correct handling of tx_fifo_depth for" failed to apply to 5.4-stable tree
To: gshahrouzi@gmail.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 11:04:09 +0200
Message-ID: <2025051209-visible-hassle-6995@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2ca34b508774aaa590fc3698a54204706ecca4ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051209-visible-hassle-6995@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ca34b508774aaa590fc3698a54204706ecca4ba Mon Sep 17 00:00:00 2001
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 21:29:37 -0400
Subject: [PATCH] staging: axis-fifo: Correct handling of tx_fifo_depth for
 size validation

Remove erroneous subtraction of 4 from the total FIFO depth read from
device tree. The stored depth is for checking against total capacity,
not initial vacancy. This prevented writes near the FIFO's full size.

The check performed just before data transfer, which uses live reads of
the TDFV register to determine current vacancy, correctly handles the
initial Depth - 4 hardware state and subsequent FIFO fullness.

Fixes: 4a965c5f89de ("staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Link: https://lore.kernel.org/r/20250419012937.674924-1-gshahrouzi@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7540c20090c7..04b3dc3cfe7c 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -775,9 +775,6 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth -= 4;
-
 	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");



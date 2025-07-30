Return-Path: <stable+bounces-165324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAFB15CBE
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1BE18C3E69
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8B157E6B;
	Wed, 30 Jul 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cCCcxRHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F9270ED4;
	Wed, 30 Jul 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868677; cv=none; b=Rcm4y1U+PN7EFhrkqj1nA4PIGq327E6+4bVSRDWI+irKfM+DL/Nw66+tk91NmUECUUfmd94lNggrRJHUtJqhxvnQNBaS5h4b9Z2FuF0jG7o22ljkQZeS5iGcAazDyy9z+orpFkM+8jDArGlhZ2hbRGh00ciozyfs9Y6gE0wTBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868677; c=relaxed/simple;
	bh=IGqxl0XE5/g4ylj9Ksi04pybJQpRhtvsC+iCPECE3ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbCz1rsREG3bsrOeZ2gQ3Jo/bVS5XSiG4pse110Nly7qkrEH+nFjUfYN5/oTZNDShD2rnYswSXprmXgNnKasNkKk4XqjUIAh57410T93FcCiktBjJ+TkdjHzWQ2qe9/SSC5joMDhoSdQsM8TJZvchCsaiCDu9CqsmW/gAg77xsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cCCcxRHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB63C4CEF5;
	Wed, 30 Jul 2025 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868677;
	bh=IGqxl0XE5/g4ylj9Ksi04pybJQpRhtvsC+iCPECE3ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCCcxRHMNA+nAn4RAxO3/BkUZQrWMggqDBzGF0/RRZlEUX5m+gyUYAwpUdWR0zxSM
	 H8287LquYLM7x2VReE/WIEZx/tgoxrlb5TUleELl52roJt3+Dv4UHd6wxsyr/xHI3S
	 oJ3vgQxEuTxaVx6kHTOURE6Tu/PG+CiU8pDd+T9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.12 048/117] i2c: virtio: Avoid hang by using interruptible completion wait
Date: Wed, 30 Jul 2025 11:35:17 +0200
Message-ID: <20250730093235.425313466@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit a663b3c47ab10f66130818cf94eb59c971541c3f upstream.

The current implementation uses wait_for_completion(), which can cause
the caller to hang indefinitely if the transfer never completes.

Switch to wait_for_completion_interruptible() so that the operation can
be interrupted by signals.

Fixes: 84e1d0bf1d71 ("i2c: virtio: disable timeout handling")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: <stable@vger.kernel.org> # v5.16+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/b8944e9cab8eb959d888ae80add6f2a686159ba2.1751541962.git.viresh.kumar@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-virtio.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,15 +116,16 @@ static int virtio_i2c_complete_reqs(stru
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		wait_for_completion(&req->completion);
-
-		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-			failed = true;
+		if (!failed) {
+			if (wait_for_completion_interruptible(&req->completion))
+				failed = true;
+			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+				failed = true;
+			else
+				j++;
+		}
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
-
-		if (!failed)
-			j++;
 	}
 
 	return j;




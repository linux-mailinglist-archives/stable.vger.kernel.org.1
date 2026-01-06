Return-Path: <stable+bounces-205537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AECFABA2
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 880D73002D09
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC633D6D2;
	Tue,  6 Jan 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkAlwwqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B533987D;
	Tue,  6 Jan 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721023; cv=none; b=tZ/QA/eAHbVBDRGgxMKAAHJQxNykSsXBpMfWeoWV4catA6QG35onSSbjX/K9TBGfojSNYCcEiJ+vvSHqHxt0oNOxXve0JssBg/b9pRD034MfDi8raxPL3JBahB3rnb1Icah4fGkLNFP3EUPqu/Dphrvh6K1YJ1yMWxcy+qN1ee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721023; c=relaxed/simple;
	bh=HomahYILYSnV+q/06P+i36ZuNuXu/wl+JHuEalVj9vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMlBP8btnlgEwbI/z8863ZPQgUGXMKrsdBCl3vo3RujGHgpl88ckZ2nqTuQ6b7OVy3zEaRJY+yqlXIHSAsqcCzgZq6HIYrgISyAzkYHywzLcHJstLBDXuPTF2ZXmulJb2TfjoyEv1yQsrMHAx/BIJHlSb5WJg4s6077ZYtu0MLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkAlwwqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D42C116C6;
	Tue,  6 Jan 2026 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721023;
	bh=HomahYILYSnV+q/06P+i36ZuNuXu/wl+JHuEalVj9vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkAlwwqf+dHyjhB9RzhD+IQ+EcWLV5INBDY2LkDBOC1MKnG2Xw4OW5u8V2mXQUVBE
	 6EIWVzzu+KCI9AMFYL4fNIUoA6unUmTuThibaHG3naWnnLvE+N1yz+8Vomocbn8Z03
	 WwARBO4RHvk+zCUkD3BlNQ08D6vS1BZwsXVO///0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Qian <ming.qian@oss.nxp.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 412/567] media: amphion: Cancel message work before releasing the VPU core
Date: Tue,  6 Jan 2026 18:03:14 +0100
Message-ID: <20260106170506.586079587@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

From: Ming Qian <ming.qian@oss.nxp.com>

commit ae246b0032146e352c4c06a7bf03cd3d5bcb2ecd upstream.

To avoid accessing the VPU register after release of the VPU core,
cancel the message work and destroy the workqueue that handles the
VPU message before release of the VPU core.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/amphion/vpu_v4l2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -698,15 +698,15 @@ static int vpu_v4l2_release(struct vpu_i
 {
 	vpu_trace(inst->vpu->dev, "%p\n", inst);
 
-	vpu_release_core(inst->core);
-	put_device(inst->dev);
-
 	if (inst->workqueue) {
 		cancel_work_sync(&inst->msg_work);
 		destroy_workqueue(inst->workqueue);
 		inst->workqueue = NULL;
 	}
 
+	vpu_release_core(inst->core);
+	put_device(inst->dev);
+
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	mutex_destroy(&inst->lock);
 




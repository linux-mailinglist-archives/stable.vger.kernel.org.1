Return-Path: <stable+bounces-15534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A37838ECC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 13:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787761F2546A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72595EE7C;
	Tue, 23 Jan 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hg1fVGkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633921DFEF;
	Tue, 23 Jan 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014223; cv=none; b=j+QJ1TspBPGMFI/y/sd+S5xWBP5OT2a4T4gcVKC0dU5NtsCchliyaGGDu4TlIj9FeK6+xSpM9mYlYpI44o9Nx8tZlMwwBRyOkGNOkmsTynhEhbY7WFfK+kfNudLwkw4WfZfILVkjFqo8fFKKxxei2DVmOQrqXU8WT5qhB7nNpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014223; c=relaxed/simple;
	bh=02NFEf3aVfW9LZO7jgaLmo8FSq8LShd9hyM8wZXVW7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmqeYvcLFjKsiurS6Iq3+vTdQr+Z7a/WWxEXLXFmpOea6V/AheW3osGmdmbGWhKX+ksiGR6ORrreRfJ7xlDWK+HKwf0ZSoaX1yYRfsov256QAXssdfYcxgz63PSl6P5oAlQM4bQ3z4325P135RwIsag343rDpvDFGuXNDChcsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hg1fVGkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE2DC43390;
	Tue, 23 Jan 2024 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706014223;
	bh=02NFEf3aVfW9LZO7jgaLmo8FSq8LShd9hyM8wZXVW7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hg1fVGkXGHsRtFie935K/ydh+jp8+kq0z4FEqGH3gKW1ZQM+oCmdEnreoreI26hFL
	 VgoxG6xFiWzUVuplj3vHnouAlBIBYvaQ0hBuHGzbESGtuP4jui/nfLua1qv5eIf3cq
	 EC2WVRyhEfqNxRi9t135o+CoNqOuNxYbBLumanlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagi Grimberg <sagi@grimberg.me>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 504/583] nvmet-tcp: fix a crash in nvmet_req_complete()
Date: Mon, 22 Jan 2024 15:59:15 -0800
Message-ID: <20240122235827.468485143@linuxfoundation.org>
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 0849a5441358cef02586fb2d60f707c0db195628 ]

in nvmet_tcp_handle_h2c_data_pdu(), if the host sends a data_offset
different from rbytes_done, the driver ends up calling nvmet_req_complete()
passing a status error.
The problem is that at this point cmd->req is not yet initialized,
the kernel will crash after dereferencing a NULL pointer.

Fix the bug by replacing the call to nvmet_req_complete() with
nvmet_tcp_fatal_error().

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reviewed-by: Keith Busch <kbsuch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3d171061cc0f..7f7fa78f0698 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -973,8 +973,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
 		/* FIXME: use path and transport errors */
-		nvmet_req_complete(&cmd->req,
-			NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
-- 
2.43.0





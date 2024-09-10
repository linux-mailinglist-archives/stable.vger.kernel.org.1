Return-Path: <stable+bounces-75160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF69973357
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38779B2AB69
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5D198A22;
	Tue, 10 Sep 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbKnYlnL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E689B18C340;
	Tue, 10 Sep 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963923; cv=none; b=JkMQLa27cBzbxZgVZMJ7TKX7l6spKuHqkBRd7DWnfwwESxzJRCjE0qbZXIZRmfnqEC1zVz0ZJaDJoc2N18MlnIGDnkRoXlQ3C92+804+jcI1uo4M9zLc+HI0jYKe/PjRYydseochlGA9MiyxGqPdX+t+IiaclI/Gu87QNlh3NO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963923; c=relaxed/simple;
	bh=DHRkT8q+lQTwzW9RXOplr3xgtPg9BAItMSXXdKReKHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uM49twDRTmin6zNjYCDafq4pzuqAfc9cfrip2g3Vieb/EhrLUqjoYtdBICHElzdaFe8SaOYoQfZCzo4yWDgUBY++0Wa/Po8oZ0k+AVx2kUkxxPTatrvm1yme0AWe9UKVIl6RdHUAVly8SfFSRvWWMBaSg5d0T3I1DCi4J9hwVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbKnYlnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCC5C4CEC3;
	Tue, 10 Sep 2024 10:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963922;
	bh=DHRkT8q+lQTwzW9RXOplr3xgtPg9BAItMSXXdKReKHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbKnYlnL2xeqdS8+EFpZzkJ59KLBVOXi+UOKNeGLGIqHTfb/BXq0paj8QyUDiUseR
	 8C6AhsId2P8Wr1wca8OqKvF8qK2r6z8ZWFPGyTtwk1TN5ZqZwwFF5D7DCpvfvRHGHJ
	 IYsF20Mf54eXy5DaPUWIwHMlGjFHeZve4KM3/MGI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 201/214] nvmet-tcp: fix kernel crash if commands allocation fails
Date: Tue, 10 Sep 2024 11:33:43 +0200
Message-ID: <20240910092606.771513795@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 5572a55a6f830ee3f3a994b6b962a5c327d28cb3 ]

If the commands allocation fails in nvmet_tcp_alloc_cmds()
the kernel crashes in nvmet_tcp_release_queue_work() because of
a NULL pointer dereference.

  nvmet: failed to install queue 0 cntlid 1 ret 6
  Unable to handle kernel NULL pointer dereference at
         virtual address 0000000000000008

Fix the bug by setting queue->nr_cmds to zero in case
nvmet_tcp_alloc_cmd() fails.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index df044a79a734..809b03b86a00 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1819,8 +1819,10 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	}
 
 	queue->nr_cmds = sq->size * 2;
-	if (nvmet_tcp_alloc_cmds(queue))
+	if (nvmet_tcp_alloc_cmds(queue)) {
+		queue->nr_cmds = 0;
 		return NVME_SC_INTERNAL;
+	}
 	return 0;
 }
 
-- 
2.43.0





Return-Path: <stable+bounces-7502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A44E8172D7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FC12884CF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914964FF99;
	Mon, 18 Dec 2023 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UA+KPlaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62642363;
	Mon, 18 Dec 2023 14:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD97CC433C7;
	Mon, 18 Dec 2023 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908640;
	bh=7Ypuq7Ij1b06X9PtJ+LH1P4OtlATnO7pJfakxrNg9aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UA+KPlaNh7zhdNoUTxuDlHw5JkGtkQcWiP3q4+q6Lr6oHCHKuYjYun1eK6s72TzHo
	 YCLnOEANW8Hdm6axAFhf2JEuqS0Yi9PqQ8lTxJZxMBROfdLJTX05F+/ihKLIy2FDzf
	 hIIyIoWbmAX+gsTqO2OJyix001z9m4t7sk43c5TQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 13/40] vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()
Date: Mon, 18 Dec 2023 14:52:08 +0100
Message-ID: <20231218135043.196873565@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Kuratov <kniv@yandex-team.ru>

[ Upstream commit 60316d7f10b17a7ebb1ead0642fee8710e1560e0 ]

We need to do signed arithmetic if we expect condition
`if (bytes < 0)` to be possible

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20231211162317.4116625-1-kniv@yandex-team.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 93c11ffae92bb..e0bb83f5746c6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -372,7 +372,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	s64 bytes;
 
-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
 	if (bytes < 0)
 		bytes = 0;
 
-- 
2.43.0





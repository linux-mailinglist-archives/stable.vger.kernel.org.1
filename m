Return-Path: <stable+bounces-43330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD98BF1C8
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF1282EBA
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13341482E2;
	Tue,  7 May 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBdHeOPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84F147C9A;
	Tue,  7 May 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123401; cv=none; b=l4WQo/b9MWac5PMqasYY13QOq8bIBNJkm7YK2YmIuORZxnNKmN56DXTM0Bpf6R6oBgGKaUKPRTK6UQNnE5YtFo3AML3oAk/86VimJslKivPCqmioY0zWylaRdsfJaFzUfHwg+Nlny995NwhHI5JB7gH+/hKCor8g5U7SSijEuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123401; c=relaxed/simple;
	bh=eo1c5Avq+ijbEULoGJKldihoAOoaAEFxOcxVHPr11w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNFzFNeCxLAzWx/M9qBnSIwA0LciWg7nwEMcWVa9WM7+lD54UX9UDOGSKEVsxma1L38oFqDPBrr7c6rmff6hF/u2Vy53cMXAGEqc+LLjM37QKVutP9dKTlTiAJI59Ulfyhm2okIYcYiOg29ffukKFrz7iFEfrvRSbRE2DpEwlyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBdHeOPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A46C4AF17;
	Tue,  7 May 2024 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123401;
	bh=eo1c5Avq+ijbEULoGJKldihoAOoaAEFxOcxVHPr11w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBdHeOPpT+Zf6ZyyvqF/BOykw7hJomq4KZ00JQVGUazh2/i0SpWFCqLP5OWZfZeuj
	 UiYtkOp3/GP1+ywWtkWc+lzJU5qcvT89fLr2tNC+SNdeDjLqjZpNrPn49m9N+h6Sb9
	 O+VlEIu3k0dzT1QUDucED/dW4gTyfG3cFVZtssfN4/3M5/3RpljRlRKDphVi5tZfEL
	 GlVjzYSFTdzx5NMjkwnAWlR+zkHcEt0wUkhngH0n2wrLJTtAb8uc/LX97lIWN9fFvz
	 KU+6NCsyeNi6Y8bIuj7KJ4QemGqbK04DiZ93S0oT6lJ3tfnoI1FxYiF2qAG5sLI7Up
	 59F4N+8DsrNJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 51/52] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Date: Tue,  7 May 2024 19:07:17 -0400
Message-ID: <20240507230800.392128-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 50abcc179e0c9ca667feb223b26ea406d5c4c556 ]

TLS requires a strict pdu pacing via MSG_EOR to signal the end
of a record and subsequent encryption. If we do not set MSG_EOR
at the end of a sequence the record won't be closed, encryption
doesn't start, and we end up with a send stall as the message
will never be passed on to the TCP layer.
So do not check for the queue status when TLS is enabled but
rather make the MSG_MORE setting dependent on the current
request only.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a6d596e056021..6eeb96578d1b4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -352,12 +352,18 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
 		!llist_empty(&queue->req_list);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+		nvme_tcp_queue_has_pending(queue);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -378,7 +384,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_more(queue))
+	if (last && nvme_tcp_queue_has_pending(queue))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-- 
2.43.0



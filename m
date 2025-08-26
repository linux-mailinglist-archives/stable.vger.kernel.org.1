Return-Path: <stable+bounces-174490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A01B36398
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996BA8A4EB1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D83534166C;
	Tue, 26 Aug 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etMVQbod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E223D28F;
	Tue, 26 Aug 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214530; cv=none; b=J0hhnnt4GveIIoqEj0RFk7D+tge9t9Q6KS4QNNRVs5tfQc1ZEQEZoiKAfb7JxkCDQXKHpBkxSmq9wX9VNviz48hWqQAj+e2CU8jm6QY8MLJRw173CKFg3rGyX3sOfYrncYkdK5BO1ECDdGef3JXsnt8PfmppxklL3vTTFVx0qVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214530; c=relaxed/simple;
	bh=4SJnDnBPN+Q/3mifwuFNKp4uFJWIq89pJGti1DZh/GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRwERt6996zBgC5F3pdzvyRvFKkVmmD/kUPSTCPfnKcC4kKI1xTofZkWCPOQBr+oQflSiB6pimXfhie7MHkMpsfVcITTlXNjza3QcdJiGiMt4IRSYGwI89J0mtUjt+dM2+CvL/Zvia1VX/v6c06p0g8RqCRBoiW3xxaEwxt12eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etMVQbod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B002EC113CF;
	Tue, 26 Aug 2025 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214530;
	bh=4SJnDnBPN+Q/3mifwuFNKp4uFJWIq89pJGti1DZh/GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etMVQbod73uA8p4aAwGR7BEW9QOQJM6RRu33YJPdsRSUPzPh9jG9+JAl40F5zAcbC
	 lDec1+FSj2R2GbFtwZis3ggnwdMNqo7dQB+SQcDYNAuQz9FFdoZCUQ1AB7jyYeoHWR
	 TgvaElecJoBPJh03pavMLFaiCHNJJo98J22tbkUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 172/482] vhost: fail early when __vhost_add_used() fails
Date: Tue, 26 Aug 2025 13:07:05 +0200
Message-ID: <20250826110935.058684296@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit b4ba1207d45adaafa2982c035898b36af2d3e518 ]

This patch fails vhost_add_used_n() early when __vhost_add_used()
fails to make sure used idx is not updated with stale used ring
information.

Reported-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20250714084755.11921-2-jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1b00ed5ef1cf..0db46b016004 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2426,6 +2426,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	r = __vhost_add_used_n(vq, heads, count);
 
+	if (r < 0)
+		return r;
+
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_used_idx(vq)) {
-- 
2.39.5





Return-Path: <stable+bounces-170330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8AFB2A308
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807F17B4F18
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447B31E0FD;
	Mon, 18 Aug 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WIbdinPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC831E0ED;
	Mon, 18 Aug 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522287; cv=none; b=lnUa6YD0/BZ2fNZhPtywrfb8kFWNM5JjU0A8jZBX36eQd1cXG1qEu0B2xEoPUFJN1sxH33UyG4SKNWhFYSjf/xaYYNXgTSgfvcousQHFNuPoHFvYGxc2CMrclzSQ+MvBmJJ++E4bKBXquVO4q22rchELgHLdTP26sfDOG9OrluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522287; c=relaxed/simple;
	bh=EXZNpPvGW7F9TUxGHXUqEGYn7RBg9ns5fsu5nMHi4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+LS1OdTOu7tcNphLdT8DF9PojsTHwchgsq8nJDjsbnO/2/7hhLM459OS+oE7C96PFk4fWxfSxcH8AScF0dkb0DbqNrLMe3kUATmzbTmVurwTAabUdf6gnDnZxSidLQaJ/9bdN9PDupabfgb2yG4StZu0uqA6/kIr8OfzN/hsIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WIbdinPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C5CC4CEEB;
	Mon, 18 Aug 2025 13:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522287;
	bh=EXZNpPvGW7F9TUxGHXUqEGYn7RBg9ns5fsu5nMHi4dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIbdinPOl/xOWhwkv9A8oRIzkhxymXUK0inVpiOFZShCRiUD9yoecQUZUb+bC0dys
	 x3Fh+zFk21XbSYCGUeAYChd06VmctcjC1ST7+7HcpgCvjQoX9G3V+m44HgvPTv3qf2
	 7xTJ431MtjTkPo2mANhMsUiP36TyKkz7mhCIlPzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 272/444] vhost: fail early when __vhost_add_used() fails
Date: Mon, 18 Aug 2025 14:44:58 +0200
Message-ID: <20250818124459.175014273@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 79b0b7cd2860..71604668e53f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2971,6 +2971,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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





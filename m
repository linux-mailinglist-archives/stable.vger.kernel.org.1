Return-Path: <stable+bounces-192084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A0C29622
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 21:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2209A346C1E
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981F61C8606;
	Sun,  2 Nov 2025 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gobWzA29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C3208AD
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114490; cv=none; b=BNMe4bheyhsPg52oiEOQnR6FXTpF7khRfonJMJ3gA4Kp5+NjTOz408X0RHIW9zLgahGD52mL85Vbvn9/S0SdClWBd4etEvShc2l8JVppZdL8wK97wqDtOjiN3rsjgLY098101qiemSoOUqq2SaQbRQuiPBigvtx7oRO5Qi9K/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114490; c=relaxed/simple;
	bh=p5Cd/JFiD83Gz7vNr2oeS85gi2QWP2BsO/nXFpL+Igo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8Xu3F+vGghgtMzlaFjM8/qgBMi8hWz/Apnj7T4C4DrguCi6sN1MW67AOh+WniiVvRETfvrRJlCR9SyR+ei1NxKxtbG+1JW0H4C1UxyPN5DjjcnbcAgFJ4+FgWMlK0ThzCvdL2uD+6POYA/021/DNMmVDB7F2/nnEL624/mYkNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gobWzA29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05991C4CEF7;
	Sun,  2 Nov 2025 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762114488;
	bh=p5Cd/JFiD83Gz7vNr2oeS85gi2QWP2BsO/nXFpL+Igo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gobWzA29nrEUenuT6lBwTuDzGw2oloDtgbdMYQ0iaXO4nU0lQp1BMdyecTu6L/9u5
	 1LXsgnRLSs1s3VbnkUyhiBbny0m3HXuBRWwaoNaqZCzq9zUajpgf8PLsOi1cITXJdi
	 DhGD2a6GlMc7eRlrH37YKi4udnJxhrfBlR91EQiFxG/ccPYhAOugdY3krLyudiRugL
	 k7nIM+wZfAj9iVn1cciH5M62QTUeoRDR5KkV+8ycgKJoSCaUx9XstAlmNJDzNf6F7d
	 kEXVSal/REKNAqTSrxJ6gsoZGlHiC9hO2BXZlWsq/qSsg0pklBicjTTJf2obH7aZ8N
	 YS3OVpzxAHH2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] mptcp: leverage skb deferral free
Date: Sun,  2 Nov 2025 15:14:45 -0500
Message-ID: <20251102201446.3587034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110207-deafening-secrecy-80c3@gregkh>
References: <2025110207-deafening-secrecy-80c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9aa59323f2709370cb4f01acbba599a9167f317b ]

Usage of the skb deferral API is straight-forward; with multiple
subflows actives this allow moving part of the received application
load into multiple CPUs.

Also fix a typo in the related comment.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250927-net-next-mptcp-rcv-path-imp-v1-1-5da266aa9c1a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5e497a83e9675..80ec82d802934 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1929,12 +1929,13 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
 		}
 
 		if (!(flags & MSG_PEEK)) {
-			/* avoid the indirect call, we know the destructor is sock_wfree */
+			/* avoid the indirect call, we know the destructor is sock_rfree */
 			skb->destructor = NULL;
+			skb->sk = NULL;
 			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
 			sk_mem_uncharge(sk, skb->truesize);
 			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
+			skb_attempt_defer_free(skb);
 			msk->bytes_consumed += count;
 		}
 
-- 
2.51.0



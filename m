Return-Path: <stable+bounces-156111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F630AE4509
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401D67AE854
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E4253923;
	Mon, 23 Jun 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMuUVvsh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35124A067;
	Mon, 23 Jun 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686175; cv=none; b=AcjC6YNGYDso9wFCeExBB0hOMHfyoMwIOA1y9hle7h3rLZIZn/GtgYgYkjEK+VqM5SukKze1r3e8GQa2Hb3s/hDpN7acwDVMt3COi6l+ARg1G2xlMGtkBUB4HUdCAT+T/aLXFzP9MTAvy8BUer5owGxO3vtTrXfW5dMy4/pd3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686175; c=relaxed/simple;
	bh=3zqEMFV8EY3Ular/z+xctuv9Vh2qwyT+d0DyeEHLyto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lohLmz3pVOE7EmScSEwp8w2J03pNM7/YtiMCBakSQfjAsMTTD/ovJ8ECk9JxiTxO/LOIDi3+ptyFJpGh8nay5yrRxLrMUZrqSmH1cIGm0mV+EI9YfaXO/V9ZVvxsq9smku13dKXGy77svaUSyOKwbVopNEWDDgpdZGMdplxkhbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMuUVvsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DB1C4CEF1;
	Mon, 23 Jun 2025 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750686175;
	bh=3zqEMFV8EY3Ular/z+xctuv9Vh2qwyT+d0DyeEHLyto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMuUVvshvm/aj51IC8V1W2u51OsY3QapdMGlBommnkkLGhhWc4cIuIZI2TKKGDrAG
	 4BMw4kkSPhwWW9MIZ4c7fpc0z5XQXtCIcN/UyMyFa1LM15NzQC8Hwn/V9W7xR7Fu54
	 YTOpRoIY3zQA65nW54GIN/cP5Oy7mSuuvbYlTCeM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 162/222] sctp: Do not wake readers in __sctp_write_space()
Date: Mon, 23 Jun 2025 15:08:17 +0200
Message-ID: <20250623130616.954128491@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Malat <oss@malat.biz>

[ Upstream commit af295892a7abbf05a3c2ba7abc4d81bb448623d6 ]

Function __sctp_write_space() doesn't set poll key, which leads to
ep_poll_callback() waking up all waiters, not only these waiting
for the socket being writable. Set the key properly using
wake_up_interruptible_poll(), which is preferred over the sync
variant, as writers are not woken up before at least half of the
queue is available. Also, TCP does the same.

Signed-off-by: Petr Malat <oss@malat.biz>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20250516081727.1361451-1-oss@malat.biz
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d7257eec66b1c..1ac05147dc304 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8946,7 +8946,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
 		wq = rcu_dereference(sk->sk_wq);
 		if (wq) {
 			if (waitqueue_active(&wq->wait))
-				wake_up_interruptible(&wq->wait);
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
 
 			/* Note that we try to include the Async I/O support
 			 * here by modeling from the current TCP/UDP code.
-- 
2.39.5





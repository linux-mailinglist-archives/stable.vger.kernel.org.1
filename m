Return-Path: <stable+bounces-95277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF59D74CF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097A01680F6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51810247770;
	Sun, 24 Nov 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C33Uf3RW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3921E7C32;
	Sun, 24 Nov 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456568; cv=none; b=PHhHkPgOZZj8kibwC+uchpiwQbpMElSoabJF5SzRh/DWTXw1uiDguOyWP/4jX7pGZv3XD0wg32oLJA2sfG2dIq0n95m+cM8gbyEQfhk6qu8ME+fKz8X7BKKBHoFUqP7oGe6JSrN8w7p7W39ozAW1rDKfMOD5qizDVQdTVMdxaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456568; c=relaxed/simple;
	bh=XBwAquzttcfFYdMbhb8CVN/ODG1zDl1Xg6KEJFg0NsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgpJ4cfn7fTxqvd8it68bc3H4fepGNyY5Scka6vDpLtVMVALwMkC1REFwMNVCawzKg0pajeVwNiKuHOtcEnm5iVDqNL3nmI4JrLRoHpajTA3XLln/Q4GEkvNFMfyUzbP8BAbSPbzva8VIoR3a6av8BOcHBNatA0hCECPV+pm8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C33Uf3RW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5366C4CECC;
	Sun, 24 Nov 2024 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456567;
	bh=XBwAquzttcfFYdMbhb8CVN/ODG1zDl1Xg6KEJFg0NsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C33Uf3RWVWolTx7RoSgeKQrreLATS7Pxa94Ck9K3V04SryutEC/wX3q5iUDoVAuo+
	 Gbo5sViMtQa8NEvF3reUKUyipHnwwypcdff+oBmGtgMreK1ClRRUxlyQbPLjlXOrmU
	 uF0rSwWvoHDzu+xPaYJggOQ5LiHfwDRT6jQ7O6TyAcfwzIgCfoDbmBuyuEnCe/gMjA
	 ryHWqmZd2Scn3pndYoVgtIy9/6ggX1tbJedoxJqRbPHlRn86//Sd2G4nE9uYTfaclu
	 tOI5EjjKcXK0I1dbcZbW8bnRuMkMcPOcke4rd5cH1VFjyj10QIk/rq4o8rUPcMnkqO
	 USWg54iRDof5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 09/28] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:55:09 -0500
Message-ID: <20241124135549.3350700-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 7c4f78cdb8e7501e9f92d291a7d956591bf73be9 ]

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-3-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9eea2af9a8e1c..6ec6f6a06521d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1678,6 +1678,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0



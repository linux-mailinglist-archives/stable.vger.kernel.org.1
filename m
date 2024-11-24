Return-Path: <stable+bounces-95037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FD9D7617
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367DDBA01E1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF91FBC91;
	Sun, 24 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZKsTEdI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CFE1D4610;
	Sun, 24 Nov 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455784; cv=none; b=U+M/MARVvQEhxU+ioM8DQubVkM36eLB/d6CQbF77C0mmN8ouqUl5+ZIvcP/2KM4Sq4q9t5flCdPbyZcvd7F/H9AscG+SiT3hqkrzHigGTIWlOv0DliH6sTLPM50O/fspcScTpYWsTiqPINz4p3v2IKxggnCMu0/dGk4+yjZ3HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455784; c=relaxed/simple;
	bh=fd3ZinV+jCcg103teRjr3y+4tPqCObl0riMq17VT/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRrpg2L67bV/9IXz0teDy+RLzs2H8bQHRhIp2yMIvmgDe6NyGhmS6rUfv5nZeKn7DQ/Mv2+nWqe5uPKFp/qVV7tRAsUMpsB9z6R9E5rP0dFGwcmWYGVeEc9iZjyPs0mSE0xMGE+KGvx0u/MoesJVioCjV10rK0bbTe7887ny8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZKsTEdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE52C4CECC;
	Sun, 24 Nov 2024 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455784;
	bh=fd3ZinV+jCcg103teRjr3y+4tPqCObl0riMq17VT/t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZKsTEdIiUjRdT90RmnEHuiPb027deecIX8AOdkhDeDwU+4EB5wbM67+7YCvPeN9Y
	 QM9MH4uv/0gTEwSgheQuJYIsZMq17ZETxTSQSBlnWkoaVZWHVtta2Nh7Ih7+FPutBi
	 rpCTJqPMBfDqWWnW9bZpvCXM8FLCezAYEmLfp63nxzfp9nFETbAq/oBj2iXXee5EK9
	 CjOB/NXPTKEpv9YpksjxuD0qXUnT8aJGrJsfVY9Z1R/bNd6H+ljdi7hCVRRzSIhWbV
	 6QAO70zkF5itW6NcMSYmJpAvqT5KEo40qZ8ihhqFphihD6yn7x49L0jdnUNySKfleu
	 NkSxzN54ZyCxA==
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
	axboe@kernel.dk,
	andrew.shadura@collabora.co.uk,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 34/87] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Sun, 24 Nov 2024 08:38:12 -0500
Message-ID: <20241124134102.3344326-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 3945c799f12b8d1f49a3b48369ca494d981ac465 ]

bt_sock_alloc() attaches allocated sk object to the provided sock object.
If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
dangling pointer in the sock object, which may cause use-after-free.

Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-4-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index f48250e3f2e10..355e1a1698f56 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -274,13 +274,13 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
-	if (!sk)
+	d = rfcomm_dlc_alloc(prio);
+	if (!d)
 		return NULL;
 
-	d = rfcomm_dlc_alloc(prio);
-	if (!d) {
-		sk_free(sk);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	if (!sk) {
+		rfcomm_dlc_free(d);
 		return NULL;
 	}
 
-- 
2.43.0



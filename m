Return-Path: <stable+bounces-77182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6359859C3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF80D1C21228
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765751AE84F;
	Wed, 25 Sep 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jONKxp/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F718A6AC;
	Wed, 25 Sep 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264408; cv=none; b=abgVE06W+2a7HqZNXByPriUWOoTWlz1gQP6w7TrEfyG+Ecn1W2FBweO95wlQTD5uoUSxzp/sC25mD4XNV3xfa1gsS4z0ADo5vTV740d0rQVAmVtbRkzfW9aDBv7Foo2MGB0kZBP78wAo5at+tFy17S3yGKnJcNdLlO9tHFfPexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264408; c=relaxed/simple;
	bh=IUv1tIoJR84HoODyOk7lB+rahWRJkrUfc2DKrwX3hnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJIEu9kQ3cQpF7Ckyr3UIyl6LrtL5uXK5GhukOHXg23pBiMmkNhH9dxMXuqR1TybawS+pBkU9kQ0l/EWbtIrzPZ0qIKP5qzv4X07IpMmXb7gNwf0tiuwPxgqJjDQt+PCfu8iCSCLQ5xrI/UA8hJrvdi+0OqwYm81utXj/7ffJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jONKxp/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757DFC4CEC3;
	Wed, 25 Sep 2024 11:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264407;
	bh=IUv1tIoJR84HoODyOk7lB+rahWRJkrUfc2DKrwX3hnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jONKxp/aBfSgZEJNufxSRUA3edOktZmI2+rzg1dN+lS3P5zZAVsDC42c8zrxOO58O
	 85DtAXQGR8f+ksq7yEg/GB8PBRcjSyZLWnEnPj4fALLV+WzmulJ39jv+hvtkMN+pqh
	 9jZ4gofTF14oGLyjFCYBFCKkzMMJqfHSe+V6YBYZqcOZnv0NHCcQjXF7rI0lWBrhmV
	 ok9CIRpAVPtti4T3cXnvznTJMZgV5Ez56+VmhBSVirzEJZqp9vFYzOLU9Uw25Wjg0d
	 i9yT41ZGFShNW2JS1ZpNsNk376wcdFQAKZYpVArSQpeOeGU0HRNMLFBe7wWS7NDsNp
	 Icat/VlpxvHKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 084/244] net: tls: wait for async completion on last message
Date: Wed, 25 Sep 2024 07:25:05 -0400
Message-ID: <20240925113641.1297102-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 54001d0f2fdbc7852136a00f3e6fc395a9547ae5 ]

When asynchronous encryption is used KTLS sends out the final data at
proto->close time. This becomes problematic when the task calling
close() receives a signal. In this case it can happen that
tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
final data is not sent.

The described situation happens when KTLS is used in conjunction with
io_uring, as io_uring uses task_work_add() to add work to the current
userspace task. A discussion of the problem along with a reproducer can
be found in [1] and [2]

Fix this by waiting for the asynchronous encryption to be completed on
the final message. With this there is no data left to be sent at close
time.

[1] https://lore.kernel.org/all/20231010141932.GD3114228@pengutronix.de/
[2] https://lore.kernel.org/all/20240315100159.3898944-1-s.hauer@pengutronix.de/

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://patch.msgid.link/20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f50..bbf26cc4f6ee2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1201,7 +1201,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 	if (!num_async) {
 		goto send_end;
-	} else if (num_zc) {
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */
-- 
2.43.0



Return-Path: <stable+bounces-83197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE39969B7
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07561F24642
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB5192B95;
	Wed,  9 Oct 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b="h7ScQCpu"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58818A926;
	Wed,  9 Oct 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476090; cv=none; b=AS0Hz45F5UKcIZOTe4ge7cRC1scWO60kBmz+TgphgOXyQi30rXTV708sN2fxAtIUZp1ngd8oN2KhO3UKltEW4YAFmCxKdxpFnCpwyETbxsQx2x3DhSZnW5DSaFHGJ+hClj2I2o34RJp50Cjp2MBZVB+Tgy9c6jbjddlVsbUWj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476090; c=relaxed/simple;
	bh=LsV5Ls3aLgnu1lHx+SowYUTiTyqH5sytnonRh0RytuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VMGjF9kFDpgY/OdIpa1/sypS1ndWqBwcNhjZQ3yEllkTRsMmTS/bSotKD4UrfwW9RE1jR+ZTglfdhNs+E6UMltQ0CiQNeIATIzs4CmjIf/s+wP0qvh1ohqWNZkZeddvUKj4ye8uVSQg9XxAupBTvKtFoLlr8b4Q72Vpn2m5XgOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b=h7ScQCpu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
	s=mail; t=1728476085;
	bh=LsV5Ls3aLgnu1lHx+SowYUTiTyqH5sytnonRh0RytuA=;
	h=From:To:Cc:Subject:Date:From;
	b=h7ScQCpuTUDxM/b6v1JRW4BfguG45IoDD3ZlRqQr7C3xWFuPP8o/Dg4TPH/r4sdiX
	 /tjpDWuJqR2GFlG2zCqDFNLFhJ2N2U/q3/KyvjqvdpR9wG1uCYiRxpnDgTFF6/63of
	 IdY40bAI2kI7Lb6kMXYDl8/H4fW61nRS3ouz3oioqhPESpXs/Iq0C3jZgIsQdtiBhY
	 0vX1rHaz+/6kdd6sxpePxUwBDkZ1HVrIdkk9icgVJspnlA03yMfhUjRsQ9/4I4MSBa
	 JSIOcmESLGebgxbFt5n0YF8QdDQNAa/HHva/s84NcUYKX7cVyiiXe+dmIcZDSeP0EO
	 v1nfiOWFad7Gg==
Received: from localhost (unknown [IPv6:2a01:c846:1a49:2b00:2e9b:3549:c501:9b22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrewsh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C9D5317E35CB;
	Wed,  9 Oct 2024 14:14:45 +0200 (CEST)
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Aleksei Vetrov <vvvvvv@google.com>,
	llvm@lists.linux.dev,
	kernel@collabora.com,
	George Burgess <gbiv@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()
Date: Wed,  9 Oct 2024 14:14:24 +0200
Message-ID: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9bf4e919ccad worked around an issue introduced after an innocuous
optimisation change in LLVM main:

> len is defined as an 'int' because it is assigned from
> '__user int *optlen'. However, it is clamped against the result of
> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> platforms). This is done with min_t() because min() requires compatible
> types, which results in both len and the result of sizeof() being casted
> to 'unsigned int', meaning len changes signs and the result of sizeof()
> is truncated. From there, len is passed to copy_to_user(), which has a
> third parameter type of 'unsigned long', so it is widened and changes
> signs again. This excessive casting in combination with the KCSAN
> instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> call, failing the build.

The same issue occurs in rfcomm in functions rfcomm_sock_getsockopt and
rfcomm_sock_getsockopt_old.

Change the type of len to size_t in both rfcomm_sock_getsockopt and
rfcomm_sock_getsockopt_old and replace min_t() with min().

Cc: stable@vger.kernel.org
Co-authored-by: Aleksei Vetrov <vvvvvv@google.com>
Improves: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()")
Link: https://github.com/ClangBuiltLinux/linux/issues/2007
Link: https://github.com/llvm/llvm-project/issues/85647
Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..5f9d370e09b1 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -729,7 +729,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	struct sock *l2cap_sk;
 	struct l2cap_conn *conn;
 	struct rfcomm_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -783,7 +784,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		cinfo.hci_handle = conn->hcon->handle;
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
@@ -802,7 +803,8 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 
 	BT_DBG("sk %p", sk);
 
@@ -827,7 +829,7 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 		sec.level = rfcomm_pi(sk)->sec_level;
 		sec.key_size = 0;
 
-		len = min_t(unsigned int, len, sizeof(sec));
+		len = min(len, sizeof(sec));
 		if (copy_to_user(optval, (char *) &sec, len))
 			err = -EFAULT;
 
-- 
2.43.0



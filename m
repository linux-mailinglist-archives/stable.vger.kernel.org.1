Return-Path: <stable+bounces-79743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC598D9FE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87E50B234BF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD91D12E3;
	Wed,  2 Oct 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b="P+qUQ4/k"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E31D0B8F;
	Wed,  2 Oct 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878343; cv=none; b=A3INKPKJ4gHg38qR2Gq0uwipVLELWdEb2sIic2dxeeSexcW9nS6gxqlertuqKqj0mv4WW6LcdBwkiLolgGG2CH8mnjA8aJkUPuQU9r55zDdi9SqCW09Q1sr6xbBBis2/08aqVKCy3VfSvfJNtiv4NWAF6CP23yRUZhdwMNw2+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878343; c=relaxed/simple;
	bh=F8QQ1CRP1srRVS+/RcTww80KFPP6Z9TA1vUUI8Xjp5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIVnjz0AaG/1Bx1P6kXm0cT3RhMaUdV2ZpEoltnp+aVhSNlgGbSafu50bPEa6OXliLVYwOABZu2ZPd/5gKZ+++upgedtgHUKy1ac8QzaaAlO89D+6YrHVlRwgJvHdK4/oy9LfzccSwNfA+gowK4jSlphFZSHIlkRhOpbuGq44iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=temperror (0-bit key) header.d=collabora.co.uk header.i=@collabora.co.uk header.b=P+qUQ4/k; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
	s=mail; t=1727878339;
	bh=F8QQ1CRP1srRVS+/RcTww80KFPP6Z9TA1vUUI8Xjp5w=;
	h=From:To:Cc:Subject:Date:From;
	b=P+qUQ4/kbxMeIsue8fx7CiSR7C3QvKQRO0dkj6UC1F7qYjsmydp7xO9OchEBwPVeo
	 q3qEGi3wmiZVDfmpr57KnqdROObLmc8qt2jtT4ezP3jJ1mtrF+eFPb8J/l3uYEF+dM
	 Ki2gPkp5JLeUuxReY8mZglrJhLIrnMDnF/LGfNqxfGTJ7O+j9abWKqv3OqJ0u65bMa
	 TiW8Di0nsRKMaIreJaFEJHosdfSzaPMKwRHJluOl5VJm97pldkg6BKbJBqiQ9UV/wU
	 5VvQlDXGPrQjCw+KCK53evIy5cZiClMXd8lgZ1xSNg7Uf+fTpcfNkxKvBJ78qxDdmN
	 1qYyXBR4ZnVQg==
Received: from localhost (unknown [84.245.120.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrewsh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3957E17E35F6;
	Wed,  2 Oct 2024 16:12:19 +0200 (CEST)
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	llvm@lists.linux.dev,
	kernel@collabora.com,
	George Burgess <gbiv@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix type of len in rfcomm_sock_{bind,getsockopt_old}()
Date: Wed,  2 Oct 2024 16:12:17 +0200
Message-ID: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
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

The same issue occurs in rfcomm in functions rfcomm_sock_bind and
rfcomm_sock_getsockopt_old.

Change the type of len to size_t in both rfcomm_sock_bind and
rfcomm_sock_getsockopt_old and replace min_t() with min().

Cc: stable@vger.kernel.org
Fixes: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()")
Link: https://github.com/ClangBuiltLinux/linux/issues/2007
Link: https://github.com/llvm/llvm-project/issues/85647
Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 net/bluetooth/rfcomm/sock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 37d63d768afb..c0fe96673b3c 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -328,14 +328,15 @@ static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr
 {
 	struct sockaddr_rc sa;
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 
 	if (!addr || addr_len < offsetofend(struct sockaddr, sa_family) ||
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
 	memset(&sa, 0, sizeof(sa));
-	len = min_t(unsigned int, sizeof(sa), addr_len);
+	len = min(sizeof(sa), addr_len);
 	memcpy(&sa, addr, len);
 
 	BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
@@ -729,7 +730,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	struct sock *l2cap_sk;
 	struct l2cap_conn *conn;
 	struct rfcomm_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -783,7 +785,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		cinfo.hci_handle = conn->hcon->handle;
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
-- 
2.43.0



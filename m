Return-Path: <stable+bounces-104967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BDE9F5417
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BE67A26D1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E61FBEA9;
	Tue, 17 Dec 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVuk73Jd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFD1FBE9E;
	Tue, 17 Dec 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456670; cv=none; b=AMvlqDw0aiRj9gYk5oz/rDj+dolv21b/HykQTJypliyM+otiSicE0XjYmiHE3LnxL+E1ftACGdZetkTReKgGcNpNMWiBaEera3aYPdUWP7QOdtzrCeOQWomPlUlOXmzpKlk8AJ/vgQf8hOILMILMy97tkLx786y/dnEtlZ1W4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456670; c=relaxed/simple;
	bh=+osRh5gb6ibLTHH2uOlg44IiadE/APgGlGfDlh0IaD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHxmeK/+lPWdl2xKxBEW+9RNp3CGOv/CQU5yfVq6Tg8HA/AESSCS46+NBV2dk2VexdsJw/v71fRyn8dS8A9agCQPwXEee4z4Ft8Sp2LF0Uklgd+Ur4oTDS6hFJSHBTUdbBP7c2ADRd0bo7WUgKotdXHdQAYaeoe6dj4LBAr6l98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVuk73Jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F5CC4CED7;
	Tue, 17 Dec 2024 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456668;
	bh=+osRh5gb6ibLTHH2uOlg44IiadE/APgGlGfDlh0IaD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVuk73JdUnWSiPAserX+7W5Mgov/wTYd5bRVBz3h26OnYz4Z109o4hPgAoR9+MFGT
	 Ofij3WlPxeDTOqVfEZFbOaH3c6EnGFX9GOAonV0jPnt2QTvM6jP4dW7v2HFNEpFsUg
	 ReT8n219HbiUoDq22Z86bY0J8mkzKoMdPcSYUjrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	David Wei <dw@davidwei.uk>,
	Michal Luczaj <mhal@rbox.co>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 129/172] Bluetooth: Improve setsockopt() handling of malformed user input
Date: Tue, 17 Dec 2024 18:08:05 +0100
Message-ID: <20241217170551.689817992@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 3e643e4efa1e87432204b62f9cfdea3b2508c830 ]

The bt_copy_from_sockptr() return value is being misinterpreted by most
users: a non-zero result is mistakenly assumed to represent an error code,
but actually indicates the number of bytes that could not be copied.

Remove bt_copy_from_sockptr() and adapt callers to use
copy_safe_from_sockptr().

For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
scrub parts of uninitialized buffer.

Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
and hci_sock_setsockopt().

Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reviewed-by: David Wei <dw@davidwei.uk>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/bluetooth.h |  9 ---------
 net/bluetooth/hci_sock.c          | 14 +++++++-------
 net/bluetooth/iso.c               | 10 +++++-----
 net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
 net/bluetooth/rfcomm/sock.c       |  9 ++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 6 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f66bc85c6411..e6760c11f007 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -590,15 +590,6 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	return skb;
 }
 
-static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
-				       sockptr_t src, size_t src_size)
-{
-	if (dst_size > src_size)
-		return -EINVAL;
-
-	return copy_from_sockptr(dst, src, dst_size);
-}
-
 int bt_to_errno(u16 code);
 __u8 bt_status(int err);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2272e1849ebd..022b86797acd 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1926,7 +1926,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
-				   sockptr_t optval, unsigned int len)
+				   sockptr_t optval, unsigned int optlen)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -1943,7 +1943,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1954,7 +1954,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 		break;
 
 	case HCI_TIME_STAMP:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1974,7 +1974,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 			uf.event_mask[1] = *((u32 *) f->event_mask + 1);
 		}
 
-		err = bt_copy_from_sockptr(&uf, sizeof(uf), optval, len);
+		err = copy_safe_from_sockptr(&uf, sizeof(uf), optval, optlen);
 		if (err)
 			break;
 
@@ -2005,7 +2005,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 }
 
 static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-			       sockptr_t optval, unsigned int len)
+			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
@@ -2015,7 +2015,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	if (level == SOL_HCI)
 		return hci_sock_setsockopt_old(sock, level, optname, optval,
-					       len);
+					       optlen);
 
 	if (level != SOL_BLUETOOTH)
 		return -ENOPROTOOPT;
@@ -2035,7 +2035,7 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
 			goto done;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, len);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5e2d9758bd3c..7212fd6047b9 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1566,7 +1566,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1577,7 +1577,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1596,7 +1596,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		err = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
 		if (err)
 			break;
 
@@ -1617,8 +1617,8 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(iso_pi(sk)->base, optlen, optval,
-					   optlen);
+		err = copy_safe_from_sockptr(iso_pi(sk)->base, optlen, optval,
+					     optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 18e89e764f3b..3d2553dcdb1b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -755,7 +755,8 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		err = copy_safe_from_sockptr(&opts, sizeof(opts), optval,
+					     optlen);
 		if (err)
 			break;
 
@@ -800,7 +801,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -909,7 +910,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
 		if (err)
 			break;
 
@@ -956,7 +957,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -970,7 +971,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1004,7 +1005,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		err = copy_safe_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
 		if (err)
 			break;
 
@@ -1015,7 +1016,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -1046,7 +1047,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		err = copy_safe_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
 		if (err)
 			break;
 
@@ -1076,7 +1077,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		err = copy_safe_from_sockptr(&mode, sizeof(mode), optval,
+					     optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 40766f8119ed..913402806fa0 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & RFCOMM_LM_FIPS) {
 			err = -EINVAL;
@@ -685,7 +684,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		err = copy_safe_from_sockptr(&sec, sizeof(sec), optval, optlen);
 		if (err)
 			break;
 
@@ -703,7 +702,7 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1c7252a36866..700abb639a55 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -853,7 +853,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -872,8 +872,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		voice.setting = sco_pi(sk)->setting;
 
-		err = bt_copy_from_sockptr(&voice, sizeof(voice), optval,
-					   optlen);
+		err = copy_safe_from_sockptr(&voice, sizeof(voice), optval,
+					     optlen);
 		if (err)
 			break;
 
@@ -898,7 +898,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
 		if (err)
 			break;
 
@@ -941,7 +941,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		err = bt_copy_from_sockptr(buffer, optlen, optval, optlen);
+		err = copy_struct_from_sockptr(buffer, sizeof(buffer), optval,
+					       optlen);
 		if (err) {
 			hci_dev_put(hdev);
 			break;
-- 
2.39.5





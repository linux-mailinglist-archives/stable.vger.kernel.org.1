Return-Path: <stable+bounces-39843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7258A5500
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC63B22933
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D567D3FE;
	Mon, 15 Apr 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xqbssgJ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031A762C9;
	Mon, 15 Apr 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191982; cv=none; b=rSLS1RdYpDu80BExz9t2ZnDuP4lHOH4iHEXh9BYKVRFjtgCHKn8vvdpIeKQu6Jjv73cWpCUnFUOrZviRDomA/NVr4V80YIU3UqdR9uuXstDDVQYWmQd9M7V6aYf9xcmOC6mRP0+hpEnVzbOhAAjhrGOLonj9IMbPEnmNT0u7nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191982; c=relaxed/simple;
	bh=5qIbok063h/yC7qm0MDjdnaQl8w6/ab1DtI4h8Ctp3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0JZ28zoTGs/pHA7NFiYKHv/vVbQp2vanwUQB/07nckiSxRog6hysNTfMcDg4S7wO5LBIrGlhRcI+Yqtk7ggr6Uz2syJ01Xp+8VjkvlP8LM0zbBFnr8+r107981BHoljWJAP97EwWrrHvuwHJTUWAh/i/HP6gOd2UmnBXKZhimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xqbssgJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BB8C113CC;
	Mon, 15 Apr 2024 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191980;
	bh=5qIbok063h/yC7qm0MDjdnaQl8w6/ab1DtI4h8Ctp3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xqbssgJ0ojfgMdRkFXcEMfweEQQJtbaBBXsO3FtE53s0Tbat/rqytqJKKaMqnrobU
	 sAiA6fMQTDWEYFMuG0WOFu4izw3pHKRISPF/I4UesIaf9RoHAjIuVy1ePQIfXWpjU1
	 bjjIHVDiWu01FWnlwmEt0NTZ63RYZDlCWVzJ/Eoo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 27/69] Bluetooth: L2CAP: Fix not validating setsockopt user input
Date: Mon, 15 Apr 2024 16:20:58 +0200
Message-ID: <20240415141946.985183405@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 4f3951242ace5efc7131932e2e01e6ac6baed846 ]

Check user input length before copying data.

Fixes: 33575df7be67 ("Bluetooth: move l2cap_sock_setsockopt() to l2cap_sock.c")
Fixes: 3ee7b7cd8390 ("Bluetooth: Add BT_MODE socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 52 +++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 947ca580bb9a2..4198ca66fbe10 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -745,7 +745,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -772,11 +772,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_sockptr(&opts, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opts.txwin_size > L2CAP_DEFAULT_EXT_WINDOW) {
 			err = -EINVAL;
@@ -819,10 +817,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & L2CAP_LM_FIPS) {
 			err = -EINVAL;
@@ -903,7 +900,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 	u16 mtu;
 	u8 mode;
@@ -929,11 +926,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level < BT_SECURITY_LOW ||
 		    sec.level > BT_SECURITY_FIPS) {
@@ -978,10 +973,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -993,10 +987,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_FLUSHABLE_ON) {
 			err = -EINVAL;
@@ -1028,11 +1021,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		len = min_t(unsigned int, sizeof(pwr), optlen);
-		if (copy_from_sockptr(&pwr, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (pwr.force_active)
 			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
@@ -1041,10 +1032,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_CHANNEL_POLICY_AMP_PREFERRED) {
 			err = -EINVAL;
@@ -1089,10 +1079,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mtu, optval, sizeof(u16))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
 		    sk->sk_state == BT_CONNECTED)
@@ -1120,10 +1109,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mode, optval, sizeof(u8))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		if (err)
 			break;
-		}
 
 		BT_DBG("mode %u", mode);
 
-- 
2.43.0





Return-Path: <stable+bounces-87749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A952A9AB2D0
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5BB1F2117D
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A9E1AE843;
	Tue, 22 Oct 2024 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tVu5B3a4"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBB1A0BE5;
	Tue, 22 Oct 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612386; cv=none; b=uK8xFLnRh3KGj352mY2dERoX0emVIDmOjAq5roVomcDUMNhRgscTYrShayfZt++Ig1VxnoD+gLVAVKCapAAZZICH9onFFZRS4VM25NoaOztJhLK9m9WlNG0xzgfDG5Rx2rAhlFCRz2/t6Ge7kKnbT7jwWhI5IsDq6pH3j7a0AdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612386; c=relaxed/simple;
	bh=E/UAvka1n7z9ij2CuqhFm1AyT+Zu8JQCBOu4+xengb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxPMib+M+t4y4uM27oWdOynzmQw2Qq/Rjw9CfXqlAvsXP/d6km0DF6xXXwUFcpYlJwgTKcaFunuKQTvr08su0mcqsaZrzQDNUbjzRgBBGwoFUJD9bI1nXlmhmV0CglEJb3PzzYqpdavZp8ohFHZ4BBl1mRUGBWkxRhsJKEEs8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tVu5B3a4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729612369; x=1730217169; i=wahrenst@gmx.net;
	bh=RV+ln9RGgJV6dhIgZJMxiS/O8xy7NYZZWNSQrK9dlaU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tVu5B3a4hO1uvcZmMsYRlNxvJwK2YBjEjdaeg5pW8rNmBCzf+a+e8PAMiXqVRK4i
	 8WBjBT7Gw7Pi6cnXuexPRsjd+Ds0AZ3c/pE4/Ic1JuOzt7w/3goXZBEbXhj77x93i
	 k9pjVLRlCRJgtkJ4UHKjd0hzuL96zNnwXV3teTxB5uMTGr52UjiH/H21v+K1PMWvW
	 u+rgKVIKDJY+0rgRsEP1xcQ7Xvy4lbS/AGzZwNdNeRbCSD10Ku1H14zFq4OodTWcb
	 z1VEHFo9Kd/4EBmLMjaYFvFdVho9uhR3VdczRBv52tzt4PUejdpQKIhk99KjVV7eQ
	 ZNiIwOirTUR76mMftw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7QxB-1tz8k13EBp-017oWp; Tue, 22
 Oct 2024 17:52:48 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	stable@vger.kernel.org
Subject: [PATCH net] net: vertexcom: mse102x: Fix possible double free of TX skb
Date: Tue, 22 Oct 2024 17:52:42 +0200
Message-Id: <20241022155242.33729-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o83L+zdpzDcAsGb4jmD8H3bd7YA7xy9pYJ14zviwmE10SMBU6Is
 /iq8zpfZhIax1pJXkSDWCYjBMbzD9WKH5yCoFfHcCYDcmXd4qfyTvtUcERb16eEsp+ZZXa4
 c5PWdeKog5LdqrE91aHwS+mR9aDTn0f8sRI+gV7eolijdbgZKQHRwfdDj59fs4adacVoPz2
 LwRfapYGqyFroPzCYFRIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cyO25HjhE4E=;4E982vO7r9/m6NXJli9arVBGaIZ
 ihfyKkQQ/wt9+LYHqnF2SvgHUFjlPrdMPElew01WddJM6d4Ti+lJNtrjHA2eywBT8N8W3JMSh
 NeTkiiI+NdUWeGv8424wggTFLH/vXcf6t77HAXY1J5BpSJmuMQgLpZIxKBlUbBxZA9rvkzDd9
 hUVUB7fligv8fxfXDpJCThRArnXSueiCXIxAVGCUk1xofl2rwE3OsAabxBGMWrqEx0kt3CRZT
 vKO82SUEhmRN+ZQ47EDakCGdXbl1Wu2Wn+AVyPzcT4au6g6lEECnPLBRA0ZE15h/UMnOxF1Zz
 aePagNC5VMtcnJ2MsvB6hDO5x8MvMj5VERskISabawfR1bGpcrlPrvoKK3fiwiciBiK2jRIGm
 qNhVbg7zWUF7u6DuVWlFDvucxon8nkChJa2eHeH256OWjCxxD4/x0TuRswdwAc/6IExI4i5Gh
 ydf1ZEfko9tmfuBT3Kfo5sTg2VLcMUZlOzZ19sEaWZ/SnAA6hComN93OmxX/u3VtYQwIBVpwN
 DhJm9Grx7ipYaW1Rwqwk7DHxSK2yDWcShNn0oXWe7cjC8xC5ncsSOz3m5PYOmFIAoqRjv0Czv
 sJfGM9ZXcUHOwsujqw/KFbehpjQjH1YLu/g18pO3GBN+AovB96/w8EtRRl32buj3I/xUYaG9B
 zfQFYFPncnpYfPwNPOKy20glD02yoZJgYEYf0xioI4NGqHnSkGA5AIal/2qqVSlgFLCocP6dm
 G+/Z5n34bMn8GHHrtgsADoNti+M7+IPaz+Jx4PhuUz74XgZ1qw2/8WBJy0LEcgqxRaTZTnNYT
 VtPbupeGfTNBa+ioIbe3NI7g==

The scope of the TX skb is wider than just mse102x_tx_frame_spi(),
so in case the TX skb room needs to be expanded, also its pointer
needs to be adjusted. Otherwise the already freed skb pointer would
be freed again in mse102x_tx_work(), which leads to crashes:

  Internal error: Oops: 0000000096000004 [#2] PREEMPT SMP
  CPU: 0 PID: 712 Comm: kworker/0:1 Tainted: G      D            6.6.23
  Hardware name: chargebyte Charge SOM DC-ONE (DT)
  Workqueue: events mse102x_tx_work [mse102x]
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
  pc : skb_release_data+0xb8/0x1d8
  lr : skb_release_data+0x1ac/0x1d8
  sp : ffff8000819a3cc0
  x29: ffff8000819a3cc0 x28: ffff0000046daa60 x27: ffff0000057f2dc0
  x26: ffff000005386c00 x25: 0000000000000002 x24: 00000000ffffffff
  x23: 0000000000000000 x22: 0000000000000001 x21: ffff0000057f2e50
  x20: 0000000000000006 x19: 0000000000000000 x18: ffff00003fdacfcc
  x17: e69ad452d0c49def x16: 84a005feff870102 x15: 0000000000000000
  x14: 000000000000024a x13: 0000000000000002 x12: 0000000000000000
  x11: 0000000000000400 x10: 0000000000000930 x9 : ffff00003fd913e8
  x8 : fffffc00001bc008
  x7 : 0000000000000000 x6 : 0000000000000008
  x5 : ffff00003fd91340 x4 : 0000000000000000 x3 : 0000000000000009
  x2 : 00000000fffffffe x1 : 0000000000000000 x0 : 0000000000000000
  Call trace:
   skb_release_data+0xb8/0x1d8
   kfree_skb_reason+0x48/0xb0
   mse102x_tx_work+0x164/0x35c [mse102x]
   process_one_work+0x138/0x260
   worker_thread+0x32c/0x438
   kthread+0x118/0x11c
   ret_from_fork+0x10/0x20
  Code: aa1303e0 97fffab6 72001c1f 54000141 (f9400660)

Cc: stable@vger.kernel.org
Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/net/ethernet/vertexcom/mse102x.c | 34 ++++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index a04d4073def9..8b9e700a1e63 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -216,7 +216,7 @@ static inline void mse102x_put_footer(struct sk_buff *=
skb)
 	*footer =3D cpu_to_be16(DET_DFT);
 }

-static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *=
txp,
+static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *=
*txp,
 				unsigned int pad)
 {
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
@@ -226,29 +226,29 @@ static int mse102x_tx_frame_spi(struct mse102x_net *=
mse, struct sk_buff *txp,
 	int ret;

 	netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %p, %d@%p\n",
-		  __func__, txp, txp->len, txp->data);
+		  __func__, *txp, (*txp)->len, (*txp)->data);

-	if ((skb_headroom(txp) < DET_SOF_LEN) ||
-	    (skb_tailroom(txp) < DET_DFT_LEN + pad)) {
-		tskb =3D skb_copy_expand(txp, DET_SOF_LEN, DET_DFT_LEN + pad,
+	if ((skb_headroom(*txp) < DET_SOF_LEN) ||
+	    (skb_tailroom(*txp) < DET_DFT_LEN + pad)) {
+		tskb =3D skb_copy_expand(*txp, DET_SOF_LEN, DET_DFT_LEN + pad,
 				       GFP_KERNEL);
 		if (!tskb)
 			return -ENOMEM;

-		dev_kfree_skb(txp);
-		txp =3D tskb;
+		dev_kfree_skb(*txp);
+		*txp =3D tskb;
 	}

-	mse102x_push_header(txp);
+	mse102x_push_header(*txp);

 	if (pad)
-		skb_put_zero(txp, pad);
+		skb_put_zero(*txp, pad);

-	mse102x_put_footer(txp);
+	mse102x_put_footer(*txp);

-	xfer->tx_buf =3D txp->data;
+	xfer->tx_buf =3D (*txp)->data;
 	xfer->rx_buf =3D NULL;
-	xfer->len =3D txp->len;
+	xfer->len =3D (*txp)->len;

 	ret =3D spi_sync(mses->spidev, msg);
 	if (ret < 0) {
@@ -368,7 +368,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse=
)
 	mse->ndev->stats.rx_bytes +=3D rxlen;
 }

-static int mse102x_tx_pkt_spi(struct mse102x_net *mse, struct sk_buff *tx=
b,
+static int mse102x_tx_pkt_spi(struct mse102x_net *mse, struct sk_buff **t=
xb,
 			      unsigned long work_timeout)
 {
 	unsigned int pad =3D 0;
@@ -377,11 +377,11 @@ static int mse102x_tx_pkt_spi(struct mse102x_net *ms=
e, struct sk_buff *txb,
 	int ret;
 	bool first =3D true;

-	if (txb->len < ETH_ZLEN)
-		pad =3D ETH_ZLEN - txb->len;
+	if ((*txb)->len < ETH_ZLEN)
+		pad =3D ETH_ZLEN - (*txb)->len;

 	while (1) {
-		mse102x_tx_cmd_spi(mse, CMD_RTS | (txb->len + pad));
+		mse102x_tx_cmd_spi(mse, CMD_RTS | ((*txb)->len + pad));
 		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
 		cmd_resp =3D be16_to_cpu(rx);

@@ -437,7 +437,7 @@ static void mse102x_tx_work(struct work_struct *work)

 	while ((txb =3D skb_dequeue(&mse->txq))) {
 		mutex_lock(&mses->lock);
-		ret =3D mse102x_tx_pkt_spi(mse, txb, work_timeout);
+		ret =3D mse102x_tx_pkt_spi(mse, &txb, work_timeout);
 		mutex_unlock(&mses->lock);
 		if (ret) {
 			mse->ndev->stats.tx_dropped++;
=2D-
2.34.1



Return-Path: <stable+bounces-89872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA09BD25D
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D1D2867E8
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48417BED0;
	Tue,  5 Nov 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="qVaOjrcF"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B22C190;
	Tue,  5 Nov 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824281; cv=none; b=EcuL4cywhAfpvl9D1Gp6G2NLUyINVRfo4XnAVivOpvhi5j4QUI8S6ziqGCAhB6lirQic4CVCna/77E0SxBUtYh2fKbMe9+X7zMhLZfO+BtC7QeEe+c97vb3rLZdLfslrPJI42yWkFP49bUBaayiJdbtRvdAQdKE99iewqv9gon4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824281; c=relaxed/simple;
	bh=MDmKggEi6kmApuIt6Yt8mPHClxb1p8lHzd+eGxHmbHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7QnGFV2oNP6FITCWCAo8tPP+MV+Rjg5nyEHs2ZHW7hSJp1PiwP/fu0jJm2pQx7/ZElZYhq9TdK79/8JYIGzypQmCVUa22GCWaDe5Ry4CuTAL547s2mPRAEZDR5gkbgl9PqOz1qhTxQGhd89Hmyzc6ZE18PlbCQgJ92C63MAzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=qVaOjrcF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730824263; x=1731429063; i=wahrenst@gmx.net;
	bh=uZMKt13pgpTh6sAh8BdybJCwC1878gT2xjYhwHNe3gA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qVaOjrcFZrNaf+cL8MfrYvZPZizl863UFQ7ALzP7jbkaWmeSledl592a5OETRGXd
	 GXGJeVDFKadlJoHUxO8C7uagjAUCtmiSqGScB0D09DunkYInEtOyfLPsB0qQ93+G9
	 OwbtOomtAlnbFOdMQ4I/Bkl0W9AfIbqHUnLpLnbxU5pBZC74ihIr5dk8YD0F5PIZ6
	 BRJtJa+wQeXe5ToQiIu0feKMbY6AzzYG/TQMBN1V1tiBBF7qTsvVbfeQ3RxjD50F2
	 M7fy55gYLiBL433wYInqnVZhdX+hZEVBKpkPwSRrrOyImSCePcjD/HvOLZ7z7Mvv5
	 /qJ74o4RAJUVdb4n6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1tRGss2Siz-00SA0u; Tue, 05
 Nov 2024 17:31:03 +0100
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
Subject: [PATCH 1/2 net V2] net: vertexcom: mse102x: Fix possible double free of TX skb
Date: Tue,  5 Nov 2024 17:31:01 +0100
Message-Id: <20241105163101.33216-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XOmPgdJnJw9hThL2W2DfrsocRWKKuXAA12CFCzpFkyf+cPMtIO2
 QHKBs1yiBmnaITpQf+0rnpbY6U5l8lfkPnL9E/vTtz71BEypwDJKfARBVCm0BIbnzqW3Xdv
 S5PMYHiwqGxRtKEB3CRSjkxBK/4N3oqBDoaALlU6kqbXjgfw7CW9/dLiqj85+r3EBqscHti
 D9oQPloGIwR0qoBqa2h/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sFhgYPjpdIY=;hK9vljsUSLRNjW4hVeA57JWASOv
 3z6CKhwYYmWYmXOSISMxsJAIUG0Q8/Ao9I2whtNlkTF4ubUj3qus4x2fwhdO8ecyO3pzWS1FX
 MK1rgAcxdCtPfwtzH9aTDw4PWapRKd9Ba+GD5aSmm7BKy5m/GZ++psx8uOtYBPxl2FYoCefHh
 J1jhmT4MYmpZjbq3Lrrb/Aw3nTV2WtIFS/RwnidukVGCd2b1MY30poJzRAKbe+kA99EuH6Hcp
 Mxa/XPPiL3mBTtpclsuKLlz+qvkng4MJy08Yhq8SpMGIMxnDK7kHYcsLCcVCjlpw+mjExY4hA
 6C4Cy5XINfsc5KoBcsbfeMMqVecZ9k1CP9LKkikEvC+iDS+kdcqyx+7tAQ0W7I4zmSQVDMNGj
 I3uG94kRRZSRAn6+Zj44GrnK+edqljhoMAHF4g7GU4RI98I0UqNB6HV5A2HJo406Gsa2fESYD
 Vhu1i42GrpiVaK77S3xOvUB9ywLpwho7vjAqoUiBN1U7sxxO2m3vcTfTDQzprvda+zmAKv+qX
 3u9s/i6dA0YF4TaRy6GGF9AIhKtC0Sww11AClea7uWX1L6nnIYitDYZS7Yv4QRAAJzbmK1xW7
 hSBHX9DeGvLahLm1TSvp/3FBORB0OibyI04MkvsMzyr9VVHyoHEypYXZBJQQA32Vt9RmzB8F9
 R3OgbhLJQoUNN+rqfOOE3JTrn6TQGcbkd2CFrGDkNVAR3OhxOSOp5FpoDwv4yl15K8QtGOaHp
 8/q5OQn8LsZeYH+z3ZJzPVos7gk8AdKVEypNTlh5xOaNVtZV6umZ0CbUWYkVL2nG0hU91NDTq
 ihWA4X493x0v+vNsc2Nr6yHQ==

The scope of the TX skb is wider than just mse102x_tx_frame_spi(),
so in case the TX skb room needs to be expanded, we should free the
the temporary skb instead of the original skb. Otherwise the original
TX skb pointer would be freed again in mse102x_tx_work(), which leads
to crashes:

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
 drivers/net/ethernet/vertexcom/mse102x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethern=
et/vertexcom/mse102x.c
index a04d4073def9..2c37957478fb 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -222,7 +222,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net *ms=
e, struct sk_buff *txp,
 	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
 	struct spi_transfer *xfer =3D &mses->spi_xfer;
 	struct spi_message *msg =3D &mses->spi_msg;
-	struct sk_buff *tskb;
+	struct sk_buff *tskb =3D NULL;
 	int ret;

 	netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %p, %d@%p\n",
@@ -235,7 +235,6 @@ static int mse102x_tx_frame_spi(struct mse102x_net *ms=
e, struct sk_buff *txp,
 		if (!tskb)
 			return -ENOMEM;

-		dev_kfree_skb(txp);
 		txp =3D tskb;
 	}

@@ -257,6 +256,8 @@ static int mse102x_tx_frame_spi(struct mse102x_net *ms=
e, struct sk_buff *txp,
 		mse->stats.xfer_err++;
 	}

+	dev_kfree_skb(tskb);
+
 	return ret;
 }

=2D-
2.34.1



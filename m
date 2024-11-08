Return-Path: <stable+bounces-91920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DAD9C1C67
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 12:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275191C22F36
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15611E5711;
	Fri,  8 Nov 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QjEFxrX5"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565111E32B3;
	Fri,  8 Nov 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066275; cv=none; b=frwZsQCC9HaM4jZ8F3lRtzR3ob120yWzUlPafNiftKpCra9GalNhOOE6cqR6zorCohvBtrK++fQXeC4O++6uXuqNiw4aCgzdHtWPQapJAT4PJj+oS/+pLCVAUQjDb7FDW+ar0Yn5wpcCniySuqSx3DsORINH+Wipcs3k9E/2Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066275; c=relaxed/simple;
	bh=MDmKggEi6kmApuIt6Yt8mPHClxb1p8lHzd+eGxHmbHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeVgl1bJqMUCgMSzpv4VIyAVehavufuiMHASxNeQjYcjQaipwNqLcb3Ph/OqR8QKf0v94bxepYlhdeJSCinMHrTf3kUuN10n6rJfbKkhw2cZLkMZOiWiA02g2D4Mj82HOTy9SEAycHJVZoPsQgOA9RxydEzpiXIhXr/RGn7h2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QjEFxrX5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1731066258; x=1731671058; i=wahrenst@gmx.net;
	bh=uZMKt13pgpTh6sAh8BdybJCwC1878gT2xjYhwHNe3gA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QjEFxrX5FAcqKle00Mk6QvAy4zGYwSuvwG3a674lDsujhJssD5sSoF6e7fBQqRJc
	 7zrFJ3O8Kvzhqkexm80TM63XXJ6NtNTgpKD3c7FWf3dqfpghMsGd1dO6Fq4LmCVTR
	 LBrFYnV68fhy/fyMR/OLTr0NmKagbOvaHuAUDZ/iYw6mWoqCpea7+aBOVxiG7P5wh
	 myC16ou4hpSzWiFHWlM6jKMSRLSeYhv1Mjvlk5ibsKLJZ9JSSUcgiNyIhoQHfrF5b
	 EsaLvrt7DCCSDz69VJmOlpfjfHdZX95x5Ph6AgRMzxa6EBlY1hep/8xD4lwZp0G5f
	 zmzI7dJgR5smTnKdyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1teGFl0YLL-00mD2y; Fri, 08
 Nov 2024 12:44:18 +0100
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
Subject: [PATCH 1/2 net V3] net: vertexcom: mse102x: Fix possible double free of TX skb
Date: Fri,  8 Nov 2024 12:43:42 +0100
Message-Id: <20241108114343.6174-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108114343.6174-1-wahrenst@gmx.net>
References: <20241108114343.6174-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SO7gY4fbJ/cAlEVxUg0/CUTKIBsYiOPG7sQoNN/rLyZSJoibRhZ
 kGbPnudNZzHaD/S9tcgm0WOgovu3t96zeHZBXefQiC2PGO7Xx3O+5kT4PHSDN+/SHe/x4xm
 pwpJIycBsqxr/fJj1kyN7egZ0cOUT2t8/pGfelzHV+90f54/zs/1GgCB37pEXB8mT4yIti4
 4JtrRzWuk988oipPCFf0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TZ+NoTfk9Wg=;gNBz0Oy+eb54xxV9QXmC3Z9cS35
 x8ojWD1vVfCec9YcxeixyyaiQrhcR8GrRM00z8Z47RVqCpwNJvlr0q4lIWqk3GFI7nFodxdXj
 7zuX2p5+18rNB1L6MuMZkcd+9d07e+eN1gTYDlWOS82ZPCcfj6j/QVpvtEPaJNeRbUWeR2hNX
 SdjCSTsmjVDcH3PjLRB4E96vIgrJ2Ufq6JH8vWzkXvri+VNdForw+CVNvyGHyg5gUgZwZ48+c
 bWjCiRgcpwHms3IMkSNlN17xiek+JK8C5iPMi2U1dykAlHxAO48+mS/zaEf0Gih5pNEBPlVzA
 IRTrDs7NuSrLOyQYQQ/3/W6Fwyz44wz7x9ODr4P/32JngmmVcNfp9TazVuYvFetuQN1h0SRtk
 uhbk0iKYkwiyPyamkmnFpYsTdVyYWq0fJAiO57C560uu4fmQStgNi+dV83Fpqtl2T/wblxmqY
 bEi/9ROCSnU3B3W3PoJPF1wTVyYUnk89J/UxBms8SWwlUdjGaFTatYO+E4ZGhgCkzGkHTLWiK
 JbzdoAEeCZIGvUtVXJkSQjvuutvsaRRx+M5k4EEUqxn2JuecVHase9pgcsaE6kbOeOrJ/I8uc
 eLH77v+6sScSngwYeMXIpCAWHRFDuV1TPYGWEdoY7lK8iYEAY5pwozGtVDnhBQm6MYhXCyi7X
 ys1AKfdTyokiU2jG6NnAO7CdJah3xyAaJVCgAHQcD+60zudRdtFZhCql1B3kzMPc3GSwoB5eW
 lEnflMrTWS7Goy+ikRT713TmwUqx81hD9Xq/5sQfgspS8SnYC5FlilgvzvKh6Qbz2ArFMq5j/
 2cZTvseOLFk8GJkDfMWcoHSA==

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



Return-Path: <stable+bounces-58937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B1E92C43C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6256E282580
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D4182A7C;
	Tue,  9 Jul 2024 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="bF6r8sxH"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAA154448;
	Tue,  9 Jul 2024 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555190; cv=none; b=CinhRf2vLtmddntdiIGVN1jBt36YNMei8YWhmaO9fWI20NzoVibBZWnOu/APpfkGp3jsyz8NptJSYLXR3jUH6eTaAnYXqQS6POtH79IdsJ03N7m8f9whjvW33H0V/a/2kg+bFLtLN1BZEfm791HjXJOnFlBuAlhjXFsA4u5/F3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555190; c=relaxed/simple;
	bh=ia5xC+ecBVWZ0FipUpsBLw3GVOBOdErVf/x0noHwav8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPpR7L5ADZjKnDMGLtlhbwTpe/M/YbEGSkPIjXWYw2bGKNRnlzVUc+LefVRMQdDSQsZkb93CMRi0T6NgYnCA6lvAkOe0njQL1+iXWgzHcfLIpmnW0jPxhwURsDQnIk1ebyNtbwGUmx26Qw6uumSN0xkzZFgxVyd0nV0ENDGp5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=bF6r8sxH; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720555170; x=1721159970; i=rwahl@gmx.de;
	bh=oLWIKi2YruH31s1xfJ8O94o6BuLnWzPYqx2FxLCSGDI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bF6r8sxH34ZiZlxxyUGaHWp7vg0abCUkVraHJyEfH9XEUUKKnOwpj6ty11PEF8NF
	 Btkv52yt5bGQJtFYiNxhDeya6BULSZKAZpqK9XY2RFkx6QfkKoUtU79fG8baV+4It
	 wH1zK18wScbBKDvyZx0zEAXI07mGFAQYhvBtNIgMt8EhsJEnb/7aIpTz/Kt+HksuI
	 boGvaRK1YT4/FJgthmPOjf1eOZ47hehiAnfQKomY8kAnpuhE6d+qEtJB4/cBh3GBi
	 zOWEdd2Ce0poNUwTPv5aFu3vm8wnuUH6Qaln05Se7nDXzZ9smo7a1Z2GGsy4atL+S
	 M0lCm7PZu25cPWMJpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.156.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1ru82k0kem-00jg5g; Tue, 09
 Jul 2024 21:59:30 +0200
From: Ronald Wahl <rwahl@gmx.de>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: ks8851: Fix potential TX stall after interface reopen
Date: Tue,  9 Jul 2024 21:58:45 +0200
Message-ID: <20240709195845.9089-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z0LkCphRNhEB6gH75M/sdR8Fn60oktJ8ZbIbzXW1EpZB0FgCajV
 xbmOj0z70jQpFfG3EbQyhJJXr4w4YWzfjMB2GmNFPZIqaKpZAArGG5Mgc1zaagoNWj6oP4t
 QFl3yxM9Ocn/8OQwBjZw1ZdxidRI/kCO5J5FGKnH3pAsoQZua8SLyFkrDMUaotQOzZbTwzj
 MZAEN9/+fEFiKg8jsUTIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ED/DXoQZ2v8=;ejD0eWUwK3jR8+bCJcuPxNINu7d
 tc6cb5OkOjuq2Ah3hSbD3mAq4H00AWmoebb9PzRuCrPA6O7hRQ1j5RIAiIlhDkH5p3oMOCfHc
 LotoKpBfyJRYiGhW/nYPMah1mZZ8BUAOdRunw89B570NL32nP24uimtij6P0cqr0zxIH6EX8K
 kQLjnILTtr4DfTkVJH4rWTHkK/pFEAKvUP7tDCIVbYII8VViWlSTBZsvhVQLbc3L4mhil5DK6
 8O98LgnyM6/N+wo/LYiw8QvkzDOfLSNAUbKEPiAMvOFTL8R7BCiaElriDhpf0nhFLrxxaN9hX
 uisrvqEZ0gjxC0utNGKNu/idhZsowXfRKqIUMgHrPH6E5TMZam10jTDpxNRcKsGFskYy/TDaB
 ZalsFewy+hGkri4/yXOdEvNDgVb8I3vBkt95JNnrkhipaProj+tGJyWxIfDCW+cie01GCBpxd
 4oyW3rc07vYxD1ZilhAOifgkGftcId7VtkBFDh9/ZJVJ4lSrV1OVaTD0B5QYQkP+vA4F1R4w+
 V3avv3MD4VvDSpJ9ivHP8zGE3l/nnpjykn3hg2G3l88wxWwDVn+mnMdCmVEeVW4ZNgJCaWfbQ
 demhr+KDZxHX00nWMo5ByyNirITCdq3Q2eX2UqFqqI1Rzi85cewo165NM7sUcxZooO5xc6pje
 WLWxMzY5714xoWLP+ZePGGhHtJYYHfdNUUjHBhjDpZkjJw6/BMZFjXsb2+WUdOj1zCdfgr2zn
 VH36ow4alHtlDL5y6E66QVMK1TyuPnZM79be0trUFW7EOlrvGmTeWYfX3rWNa/ZHgGYVvuJsk
 XFwKh+Pg7xV7k03JsG7grgkWxVJOcxARbJi1k9o5nAvnA=

From: Ronald Wahl <ronald.wahl@raritan.com>

The amount of TX space in the hardware buffer is tracked in the tx_space
variable. The initial value is currently only set during driver probing.

After closing the interface and reopening it the tx_space variable has
the last value it had before close. If it is smaller than the size of
the first send packet after reopeing the interface the queue will be
stopped. The queue is woken up after receiving a TX interrupt but this
will never happen since we did not send anything.

This commit moves the initialization of the tx_space variable to the
ks8851_net_open function right before starting the TX queue. Also query
the value from the hardware instead of using a hard coded value.

Only the SPI chip variant is affected by this issue because only this
driver variant actually depends on the tx_space variable in the xmit
function.

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overru=
n")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/net/ethernet/micrel/ks8851_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/eth=
ernet/micrel/ks8851_common.c
index 6453c92f0fa7..03a554df6e7a 100644
=2D-- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -482,6 +482,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);

 	ks->queued_len =3D 0;
+	ks->tx_space =3D ks8851_rdreg16(ks, KS_TXMIR);
 	netif_start_queue(ks->netdev);

 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
@@ -1101,7 +1102,6 @@ int ks8851_probe_common(struct net_device *netdev, s=
truct device *dev,
 	int ret;

 	ks->netdev =3D netdev;
-	ks->tx_space =3D 6144;

 	ks->gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	ret =3D PTR_ERR_OR_ZERO(ks->gpio);
=2D-
2.45.2



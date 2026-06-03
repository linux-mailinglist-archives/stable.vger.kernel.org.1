Return-Path: <stable+bounces-259949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id inSMK+GdH2rrnwAAu9opvQ
	(envelope-from <stable+bounces-259949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 05:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A96633D8F
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 05:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=Cf1qUr5S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259949-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259949-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED2C3001BDF
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC239E18E;
	Wed,  3 Jun 2026 03:22:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787683BFAE0;
	Wed,  3 Jun 2026 03:22:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456922; cv=none; b=R2VaKKUISIvKNFy3GhOyqOWtL5TB07SCl2zSua0tcnV774HrwjhkZz4Ewaw9h9MsTNjuf9qYV7Zk1G40nM398YI6brs8v567ub6F0XHuZlOkEijkEJM3p8vVEVzWRCEHqhWWJN2peRoaKyRgNApfdK05z03TsBohN3Ym/mEsyuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456922; c=relaxed/simple;
	bh=UOEQOqzF35+j0gD7uxzopNKhH3u8zS+4OwJyHdT9tvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpAC8cPmJf9jYq67EGfapy54ti8WlF23VAQYSgSwPq6Aip0ue/vuRzW0x1NCi9ZGi440XF6uY62CXMbQ3r6Q52Yd0Nso00vNCwnfr7IpondeJ1Pbn+mAZIe5Snis6yCRW3yd8mnHaUdz4MVo4WBVrvgEqozbkZj2I0T20WTpoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Cf1qUr5S; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6533LYBO03517759, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780456894; bh=5mHtVvngkDWAS1kZCG2hKUnpX7JTm+kX8zY/EccChfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Cf1qUr5SiIa97XRZpGyOsiDbbMJ9LnDC+gwwY9zon2DkDwbN4Jrh5EO+ASGulLaze
	 qKXIapPf8Jdn5zj3L1RhzbJM/yMrsnhyrUjoLRhlj3tsHuhNMQ38Sk7ILBkgM1xwj1
	 ZqPdHVWO/rXe5Q29zx157uM+LEQ69kW3eZ8vAnDdaAAtCc3ZWkt5wtPSCFtlTAlyzZ
	 pyFww0VPEOmvc52CRaHMc5tHXwwMFa16l12J2L/nwUIEObMduVRV13ohAGEqvRrA4/
	 aAQSTgWkF3rsQZDAR/Rx+WCS8Yld98sv0NoBKhNqTm0MfTqfcnioR9E+0P6AiM3iNR
	 8fyKXdUMjW3mg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6533LYBO03517759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 11:21:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 11:21:34 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Wed, 3 Jun 2026 11:21:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v2] rtase: Reset TX subqueue when clearing TX ring
Thread-Topic: [PATCH net v2] rtase: Reset TX subqueue when clearing TX ring
Thread-Index: AQHc8oWGE6UBwhenOk2ArbYiYx+rYrYsKrjA
Date: Wed, 3 Jun 2026 03:21:34 +0000
Message-ID: <29f4493e45cb43aebbfb2dc6b93eb4c0@realtek.com>
References: <20260602114659.12335-1-justinlai0215@realtek.com>
In-Reply-To: <20260602114659.12335-1-justinlai0215@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259949-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justinlai0215@realtek.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:mid,realtek.com:dkim,realtek.com:from_mime,realtek.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35A96633D8F

Justin Lai <justinlai0215@realtek.com> wrote:
>=20
> rtase_tx_clear() clears the TX ring and resets the ring indexes.
> However, the TX queue state and BQL accounting are not reset at the same
> time.
>=20
> This may leave __QUEUE_STATE_STACK_XOFF asserted after rtase_sw_reset(),
> preventing new TX packets from being scheduled.
>=20
> Reset the TX subqueue when clearing the TX ring so the TX queue state and
> BQL accounting are restored together.
>=20
> Fixes: 5a2a2f15244c ("rtase: Implement the rtase_down function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
> v1 -> v2:
> - Target net tree.
> - Add Fixes tag.
> ---
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index ef13109c49cf..6ccbefb5acf2 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -239,6 +239,8 @@ static void rtase_tx_clear(struct rtase_private *tp)
>  		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
>  		ring->cur_idx =3D 0;
>  		ring->dirty_idx =3D 0;
> +
> +		netdev_tx_reset_subqueue(tp->dev, i);
>  	}
>  }
>=20
> --
> 2.40.1

Adding Olek, who was accidentally missed from the CC list.


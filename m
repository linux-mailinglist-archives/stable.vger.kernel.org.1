Return-Path: <stable+bounces-241790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BMbArdI8Wm/fgEAu9opvQ
	(envelope-from <stable+bounces-241790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 01:54:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9ED48D97F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D25F326C947
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8393AD53B;
	Tue, 28 Apr 2026 23:30:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021139.outbound.protection.outlook.com [52.101.65.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BC3A380C;
	Tue, 28 Apr 2026 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419059; cv=fail; b=nExcCU8rU5wmbsrQKr9tJjnmNzBiwFB/Yl+B12MDOEQpMLJaH/FOwuoP9rKekNpRQYvvo7/nQFQ+m50XLCVNDAiLHXhwH+ofvqPyKAPkdojxIYi3BBkwQCsew3E90TOgXXFT4mAHJXv7FpKySSytO6GHEbAkOKRJS0AwwmHJ5yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419059; c=relaxed/simple;
	bh=X+UzRd+Al7Tn25ibbYH2bU7dNVKgSD/stW4iwQcejFs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J4deJOIBTfsM0uNVEDRZeSqvuJ1mZOr9FAsKm0iux4hKOuTqwUxrIOGWS0rljfGQdgnSksUzFzD2IcoxqYv9wuKST7BebRFDLLPkzV9mfmH+wjKi+oQxMPhncuytDWpMsxwymRs1Ev/x/cOYkUbd/lUWhTxHZdDZsoM2iIIB5Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com; spf=pass smtp.mailfrom=secunnix.com; arc=fail smtp.client-ip=52.101.65.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunnix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunnix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfE985oCNof+YJeRaVBzG9WC2kqDGuZeT0kQNzQM25FX1yBuhAoFe/F9DUFvtm55J6K40v9MwE3wrglyblvSL8UBu7Pe07H7tKNngB+Oh+HRTDEtfmluMzu5FMMML1ohLC3u0uts5blKtiKgc9xFMXQRnB5M9GdG9wMxF1s/FYDRBW3KbxDxvuqDDZL/laxByB7EuEOwInJ36vOWe1IvMo/iik6aSo5npzwesgpT/Y7uIuEjw5BflB4ylDzMV38FEjgrFuogXfrsUUQw27383wkJ+xtJ15a1FfNQf8dYa49ndXmlWph+U5p4/G1fS3CkPiA1K3ccJrNEPZWbvkEBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJIhvImcqo5OpCGQhL5o74aqwyzGlVTc2AGy8x4cjjM=;
 b=YeAc6Bc6GIzfUVAJJC2QrA4rvNaWMWuT94usk4HWXeICOYHKjFHs1i/E0f9LOqth/o1TKXCvPyEDt2nYAJBOSOG/rbxNRAUFchfQgUtqOfm7kxd0B4CL426ZIrLw0+nguBxp8irYqPp/gGk4uygvWtYtuepur35Pn50kWIFvgKJ0jK2Y6R8CLSskvo7AEfhrUxCiBqqgE3xpjWijNI182bV3vywZN3q8v7Kvl+i11IhmbxR3wbxDQb9J0GwRg/3vg+xG8WBNJYaVeTcTpn+hsiJ4vJaTkdhvz5+tqnYA2WfRi8cyTXRh2Re5mEPOBuMM9cYawQ7epYYvYpGOORe2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=secunnix.com; dmarc=pass action=none header.from=secunnix.com;
 dkim=pass header.d=secunnix.com; arc=none
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:570::14)
 by DU2P250MB0256.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:27c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 23:30:53 +0000
Received: from AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1]) by AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
 ([fe80::8627:43f7:324e:6aa1%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 23:30:53 +0000
From: =?iso-8859-2?Q?Safa_Karaku=BA?= <safa.karakus@secunnix.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] Bluetooth: l2cap: fix UAF race in l2cap_sock_cleanup_listen
Thread-Topic: [PATCH] Bluetooth: l2cap: fix UAF race in
 l2cap_sock_cleanup_listen
Thread-Index: AQHc12bQUcf9F+DfREGuGIM7vEv6kw==
Date: Tue, 28 Apr 2026 23:30:52 +0000
Message-ID:
 <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=secunnix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P250MB0791:EE_|DU2P250MB0256:EE_
x-ms-office365-filtering-correlation-id: 355d4684-fdd9-4020-fff9-08dea57e3073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 2IDHqE/Qrwifwdl9ExDIDby4Xg7tefekfIN9C0zS7ZA/gT8qFtCG+YGdmztvlsQZYpQOFTqJNxbgACttI17M+Bs1ekerQ5VN8NP8s3/5aoIhLHClsIzm8+xHJQmP1WA8XdwklDOunN9T+Ws6l19QbjKARGNNKp/sYozVP0nWlWXRDbDf/LH2KetUEGylixgXMxrPCs99PaADut18fY2jJK/uTafhpbgpMULssH7wFPVcFq+Km596OXDYgC/hT4z91e2md7KTJYMFMSiFREpvGB1+f7xTvfKrx3683SpQ/Iq/tmVJvtfRKuOZ0B0Dqg7djKVLcXKxTg9cGCuJMVoxAzXE3Ux/fl9nuWm3jyRZtyID38spezx1jnHEw2LJvE4XdjQsmjc2D/Mjkpzx8radKeVpFLOjB50Exj45EtJsJz+EnDmD8D8a/F1RgBAoiQdZvYwq5YYUz+6zeT+bCQk2yM8eeBYSrIo49v3KlaU7I3OgE0FSZ9cOBT5PVgaQ3t0bljKaEgj8CQLfzrIj7AEmxR5CwXaccHW3DLwqec8Rj/T+/f7/4UcVWSrafP4aWFu7e8jxH5UTpc/Tk/DN0URAJPLnuPXV304gusMH3IqTG5vTO5oKCAnguWqoH/gntnJbJOZYsvxfh1PfyiRUOILYN/qNZ02kVB9QjIadZjPkQ6Q6qkeV0ojDUZ8kh049jln89yXZNg7FZcN3xFuKrjBbybH5AapIPym05PrZ6tiNkFkXdqeWgFBRK1uooNgSHpHYMyehI2sP71S0ANBXmp/tOtGAzogQGTvEvlp4tmu8APo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P250MB0791.EURP250.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?KS8oabF9Y+bjR0I1OeG6lXQIn+DHtk4V6LzyvE1a99vYJdK7smaQKvJKRY?=
 =?iso-8859-2?Q?HMPHCmD4vbf+JfkGCFPtzknIkQoi9uLyLEcdKJ3JE05+St0Ktb2VuSVB72?=
 =?iso-8859-2?Q?Lxk3qcVQgoTQFNIoqvgFirDNnOMm0YSsEPk3uRBpsIveyAplrcqboxJ3sv?=
 =?iso-8859-2?Q?OJNJUorc40hxDjOvof+THWGTJoeEsTWpd5j5qCqs0IAK4eF1LTlb5rg5sE?=
 =?iso-8859-2?Q?qxMCIDgMs9idVuiJEsWzqARLwwAfsIYXYDWKi2l0V2EaheuG/UqmunWm+k?=
 =?iso-8859-2?Q?NyNmzIXP8uzQkbklo67XHizYzWQEICkZYSfF7ZjK6nOe6hVSxdq7v5fr8K?=
 =?iso-8859-2?Q?aTPAHrVM2VDY4Nkku3iNsEd1vOV/GSZFgxEeTY50LJQi+BFqt5KSenXuNi?=
 =?iso-8859-2?Q?OZPnMvd7CkXIQAEU3l2nXmB2T70s2SXLnay0WPvTSmCI7QU4Z8KJwBjPFv?=
 =?iso-8859-2?Q?+BdFawPaVGl/1/lYZS6Ug8L0aYKD23D7g4APPOaktMjPK2TJ22dqM6UEDP?=
 =?iso-8859-2?Q?kezR7mjF9rBtYJ9GSTrwsT6VdQs3sciojvs2BE3U2QlTFcqlXezS4Z4y1o?=
 =?iso-8859-2?Q?U+3Ty2LcEaSM/RNABRsqFXu1eTRifHINo2QSKmLo+17d/t7fMLh2SCfoe+?=
 =?iso-8859-2?Q?corPrC3aPuQFPUwcUB6GiLCZavtwhruW+v2xKVfrDbrS2aP3ENlIu88gTo?=
 =?iso-8859-2?Q?RnAe+acKZfQeFLSgDNVw0FpqvEbAL5iqA56+FF+Hd1UPz1HVSLxhWG8b2s?=
 =?iso-8859-2?Q?fZvdvVwvtiFaK1aX6MsuCzktsArcDBW9jCSb9nWXBcBmxQbX5MYeUl3tCa?=
 =?iso-8859-2?Q?aO1OGGpyI+zLZTrzY48ycPwmULkL/mEVZngf69WQ9iQ6/zChIuNMNAXE35?=
 =?iso-8859-2?Q?BN4RzQ6Iht644kuR3GzEVr+wiJdkPrJn4WaLglfSfNuNbEJ2YQyXc65zNR?=
 =?iso-8859-2?Q?m1D+2rxKXFTZF1+MeGBimH4JbxIX0C4DmO5V7WBoStueek+G8k+gHFlDOe?=
 =?iso-8859-2?Q?xqQvflHe+vSvYjnE9FETlF5YAwIHR36JbHhrxafOB99sFcBWNuB//AQ2ws?=
 =?iso-8859-2?Q?pLXIAdaToIPf1hQ0MzFoE19WumUTasz0kVBxD0qtWy3FuSU57xFG6s9CYF?=
 =?iso-8859-2?Q?Rs4RKP4bkVqteaJZUOaX0mUf6ARauNZdW9BCAuKuzZBUz6/iP4fDsrJTgr?=
 =?iso-8859-2?Q?q1ySo5uAf9Dob3b55xUWCKabVJx7ozIB38Dw0j8soiLdwfKGYIG9drCceP?=
 =?iso-8859-2?Q?6jEcE1HE1Ufv1M75KAXwQPbvnitx76SWe1o4ZFPEqo4kWWXi0ekNK6q0Nv?=
 =?iso-8859-2?Q?BzBhs/v6+iewV+DTiYggLH2I2UZrnXQYa2C3oMCtwrhWtOF5MYvHwKaM46?=
 =?iso-8859-2?Q?DDnRXzx8qkQxs8m1ZwknIqLWvZwj23QnHH2P8Ci0ufoFM0+aSk+4WNtExW?=
 =?iso-8859-2?Q?nwWF1pr+FXEzsyKWxPmAaRWGA4b4rJ8KTWuGDLf6ltpvPgSsJJavg6BgwM?=
 =?iso-8859-2?Q?gdMeLp67bXoi0b8tzS978u5A9JD7eQ29DwX6MggtkKPMTBRrk/gydyj0Do?=
 =?iso-8859-2?Q?9rNE2LaX68ZmZjNr5SCEzhvSg3I56L5kq1/FwgCpdNURXLsduu7/qWgN1M?=
 =?iso-8859-2?Q?ZUz/zYZIaJJaT1qzbN9IEX6DYW2pqWp/nVvjPPxagKAaKGRWsCfPH1kLkn?=
 =?iso-8859-2?Q?ZIKewYR8lzVcpVhLzSEesDGPQS/Pf96OiGpg0gVcPMf3Z7Eo70FGsIjZxo?=
 =?iso-8859-2?Q?/iPj4OEx2wrtDxS6RqS2Zc9/3mdT7eJKd9L6/wjpvosHFT3NZ8YxG/nKef?=
 =?iso-8859-2?Q?vJogjNB1xQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: secunnix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P250MB0791.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 355d4684-fdd9-4020-fff9-08dea57e3073
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 23:30:53.0010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2eefc8bf-b417-4556-be78-a3aa096a840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNEpx94rUtsyVeljiOToOf+56L28EtFwZGneO2g9cLDdznI/NLjbwLVBC+PFKclVXEdK2sEfMGJ/hX7T7PW+1NDAhkiHDgksHXencLjqc3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P250MB0256
X-Rspamd-Queue-Id: 5B9ED48D97F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[secunnix.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241790-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safa.karakus@secunnix.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.943];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunnix.com:email]

l2cap_sock_cleanup_listen() dequeues child sockets via=0A=
bt_accept_dequeue() without holding a reference on the returned sk.=0A=
A concurrent HCI disconnect can trigger l2cap_conn_del() on CPU1=0A=
which, while holding chan->lock, calls:=0A=
=0A=
  teardown_cb  -> sock_set_flag(sk, SOCK_ZAPPED)=0A=
  close_cb     -> l2cap_sock_kill(sk) -> sock_put(sk) -> kfree(sk)=0A=
=0A=
all before CPU0 has a chance to acquire chan->lock.  CPU0 then calls=0A=
l2cap_chan_lock() on the now-freed sk's chan (already safe because=0A=
l2cap_chan_hold() was called first) but subsequently passes the freed=0A=
sk pointer to l2cap_sock_kill(), causing a use-after-free read on=0A=
sk->sk_flags and sk->sk_socket.=0A=
=0A=
Fix by calling sock_hold() immediately after bt_accept_dequeue() to=0A=
prevent kfree(sk) from racing with our traversal.  After acquiring=0A=
chan->lock, check SOCK_DEAD: if l2cap_conn_del() already invoked=0A=
l2cap_sock_kill() (which sets SOCK_DEAD), skip the duplicate call to=0A=
avoid a double sock_put().  Drop the extra reference with sock_put()=0A=
at the end of each loop iteration.=0A=
=0A=
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credi=
t Based Mode")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Safa Karakus<safa.karakus@secunnix.com>=0A=
---=0A=
 net/bluetooth/l2cap_sock.c | 18 ++++++++++++++++--=0A=
 1 file changed, 16 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c=0A=
index 71e8c1b45..4475d3377 100644=0A=
--- a/net/bluetooth/l2cap_sock.c=0A=
+++ b/net/bluetooth/l2cap_sock.c=0A=
@@ -1477,7 +1477,15 @@ static void l2cap_sock_cleanup_listen(struct sock *p=
arent)=0A=
=0A=
 	/* Close not yet accepted channels */=0A=
 	while ((sk =3D bt_accept_dequeue(parent, NULL))) {=0A=
-		struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;=0A=
+		struct l2cap_chan *chan;=0A=
+=0A=
+		/* Hold sk across the chan->lock acquisition window.=0A=
+		 * A concurrent l2cap_conn_del() can call l2cap_sock_kill(sk)=0A=
+		 * -> kfree(sk) inside chan->lock before we acquire it,=0A=
+		 * leaving a dangling pointer.=0A=
+		 */=0A=
+		sock_hold(sk);=0A=
+		chan =3D l2cap_pi(sk)->chan;=0A=
=0A=
 		BT_DBG("child chan %p state %s", chan,=0A=
 		       state_to_string(chan->state));=0A=
@@ -1487,10 +1495,16 @@ static void l2cap_sock_cleanup_listen(struct sock *=
parent)=0A=
=0A=
 		__clear_chan_timer(chan);=0A=
 		l2cap_chan_close(chan, ECONNRESET);=0A=
-		l2cap_sock_kill(sk);=0A=
+		/* l2cap_conn_del() may have already called l2cap_sock_kill()=0A=
+		 * (setting SOCK_DEAD); skip the duplicate to avoid a=0A=
+		 * double sock_put().=0A=
+		 */=0A=
+		if (!sock_flag(sk, SOCK_DEAD))=0A=
+			l2cap_sock_kill(sk);=0A=
=0A=
 		l2cap_chan_unlock(chan);=0A=
 		l2cap_chan_put(chan);=0A=
+		sock_put(sk);=0A=
 	}=0A=
 }=0A=
=0A=
--=0A=
2.34.1=0A=


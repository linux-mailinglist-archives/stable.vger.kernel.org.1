Return-Path: <stable+bounces-227491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAVjEOILvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E12FB2D7967
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67D59300DCDD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22661375AB7;
	Fri, 20 Mar 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Zcx0/FLj"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9ED2D7DE4
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996998; cv=fail; b=Rm1317E7z9lPXa10OhIcKgllXo/TrSp3uC4vp+1VgSulWpnCUkKnJytkEnnTbCP9wLPhY+rWAgzQDDu3yEW9eVMg3fFYP0t7A2OZBXimaTlpRQZ+llwxWocCQW9+RxEX85e6zCCZbqjlJpgdzHoFguRzL1JdM6F1ZM71DPXzfIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996998; c=relaxed/simple;
	bh=V03Izz1xzB657yqPJcO/xLuXiczoWflltcsOmELdn1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBKcbsBH2LnPbTVA2psW4ldL557Y+lpvoIjSH8VPOhwJ7jB0vmZJ7W/9kALPsoDwgQtSWFj63M1gIFSYbQ+ya5MygjOh3zRHuEpw/was2BLNXC8qmJgnAd3iE5FMXK4htw8gg54Irn+O9BoxTuKQxO4nRuCUQPzNv2N5MA1WBqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Zcx0/FLj; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deecOqItFw/5tO5Oc79im+MjKc0biX3e/pKuOlxTy8T9o0eW7CcTyvM8MeAByT4bZ7g6CO56+euzkV0vLdsY3sIwpOcU7T+B/DmQsS7BgSNWE3BcjhU3gp9/lXZvJhGnj30SXBL4Ql2W2EjXjGY5HST4wDvl1jZIHaSeqVuq+ce7YF2ks89IifXTSG9inL9x5g79ORgGJ23821rxMStyrxb8fx5ypX3oUkojf4nfHD2JA0gL7nAPROy+snizJjgTONqszijVhaHJo2aiu4sT8KIh8q7HCR1d8kVgrLEvwgPhtsqLSq7F1lzWxqTFsgTu89jk88NzZTS5oMmbV18GgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR3aIgasBW5c5+YgG6ZuB0Iv8ruXBCgjEEgtzC7Az9Q=;
 b=E0EAqy5BPX+Q4APDw46gsgFQ/RGzfnd0+/NVYtIH0xR0mvzZN6lsJMslNbGSbJPbRzN8JU9C8wr8fOjF48X+BppHWXg+EBHTbEbjY0Rix/EL7saZFEVT5rZWBiA5slvzbjQaNjp00I+P/3aWQwlvcPFmiKMRcSgJeggase7RcYxQ7m1ZjI12deNcL01QozXyZOAzNXEu/l/zVMyBvrxaiDODuiVkZ39tRbiB9ap/unTGY/OnCXpVAdoGzJH3wvVr9uKzPZs1H6exCeKaiKcsupsSiY7vvr5HWE3NVRuXIWoRkWQRoxKmvmUyiYl1R+Qr6ABDg6CBdip24E59bNBhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR3aIgasBW5c5+YgG6ZuB0Iv8ruXBCgjEEgtzC7Az9Q=;
 b=Zcx0/FLjpY4TE6J4LuCHK4WGtGieR2l8rcMxpLadnLznKnV8gf2GrFUS7bRDFDwzJdqPqwT5bPIHuIle5/dkgd2vbgmdwvxJOlfuFugs1J9T6j+2xDdu5iCawul4axQGTr70T0yVuTZVVAwqVITZogWvFsdpQRx6gjrdUcBx4JTqj1c7ttRf0enfA+CYp6aj7OCY8NILd5Z3mE8iGBdcw9704hM1yowCREafC0Og4faZPRbXbJyqgOkIxMoiqYjyByDGrHsUtPZfKin9NP02hNiKbKnzoPmFrKbJFxEOqwq7kncaH9fT/BOTszYI7gljL59OlUR3jZ3yHdZWrbwrUg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN2PPF94433AE8E.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::1be) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 08:56:34 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 08:56:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcuEd0/wOFsdNRC0GHsf42bL/1IA==
Date: Fri, 20 Mar 2026 08:56:34 +0000
Message-ID: <20260320085628.1274-1-gargaditya08@live.com>
References: <2026032048-canal-smell-2ad1@gregkh>
In-Reply-To: <2026032048-canal-smell-2ad1@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN2PPF94433AE8E:EE_
x-ms-office365-filtering-correlation-id: 33d97839-092f-4386-7ae7-08de865e967c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|19110799012|461199028|41001999006|25031999004|8060799015|8062599012|15080799012|31061999003|38102599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
	=?iso-8859-1?Q?euacekrATd4tv0gFX2VpPAHy/A7q6ruNofLNRaYhr1Sk2nx8ys1nmt2hLv?=
 =?iso-8859-1?Q?ehT4wekKxVSxgzqg72t65/AWXe6D3s49U2c8R5PEbClAfklDAyuWOuuL6+?=
 =?iso-8859-1?Q?odbHHioY+FbTWskAML0gSpzjggLDMrUM0Z6XMbKoe8UK5l8N5Z0IqMBIGU?=
 =?iso-8859-1?Q?GLfDTXQ6J2Ri9BTovfigb3+9hjGeeyBANHsgo4IaGtaAQjsJBFr1Hpeaf9?=
 =?iso-8859-1?Q?k97WQPT84DDWdwh+wBIkE/iWHyFMKZOHciEotd8AQ1EM3VqJ6gIwZvsvOt?=
 =?iso-8859-1?Q?xDp6Zo15uE9DD38HmQIxbmUrs7sRuGywUMgRx58RcmevZJf7JorCgI97l/?=
 =?iso-8859-1?Q?o9fnwcClDm7A0mCQVeszXAoWTrdUOCFRNNIOH+MwvwOZDZT+hTtggSkYWW?=
 =?iso-8859-1?Q?Vvx11NeAiGsRpXfT/sI2VaiMXUWW2QRQV96iemomgbWXODrbrpmBRvp7At?=
 =?iso-8859-1?Q?a0CUa/NZfLduHZN3RtTW/re3byi1BWzIv5qgAHJqnLeuIg+akvJZkrk3MB?=
 =?iso-8859-1?Q?rUVkDbSuiDbSU1mkkRPd8GK8pCBabERmD6kQOqmWxP7HV4RjrWqxbNY9my?=
 =?iso-8859-1?Q?7Uxm8c9Sk/Lfz1QwO76BA/XuhaZypmT40PYz3HIYMuLx0wSD62hB08SIqt?=
 =?iso-8859-1?Q?qFA1pXG3FoH3zOQxYVKGzCLFVB39uygYA4KHYg24dg9BlyQMLqZbqGG0+6?=
 =?iso-8859-1?Q?CpG2VfayUAkEzVE06ZEz4yfl0L1rp7AkTJyjyWCnv4v5gY7Omn4kmKMSkR?=
 =?iso-8859-1?Q?E6PfTX6IBrX9JUR3iIH6qF8N1KjN9AIVrVy8sPsD64G0YJiXj4aX5KkX+d?=
 =?iso-8859-1?Q?+GrmekPUdpQczmVGM4UBbzgTxhvIUgX+KC9I44dZOlB2koWVWvdLQQe1wF?=
 =?iso-8859-1?Q?edI9ol1EkB9F2woBwnAjPPQZkM3HJl10caoBiMoCgvj3uiSHByyYal2soK?=
 =?iso-8859-1?Q?bmpxiwB9yUe+hLwQXtrq8Hnw/TSPzLwJFQHxjZRbXjeieUvFSh4RbQ=3D?=
 =?iso-8859-1?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jrgJCmFYo9natJto7z1Tnji10W3P3jhizuf3R5L69MGRLH031FGmjZ+ZCs?=
 =?iso-8859-1?Q?/ue7WlvT0pclcUWoPEu85m25pULEIPb4qRWvg1pABaxaZo2G1/4gnPKTNU?=
 =?iso-8859-1?Q?iqd4dsdSOmWIT7GsMbnGuFvLjsU4D6Jo4vFT39Yctt7TagU30klsVfOG67?=
 =?iso-8859-1?Q?RNgZyNkvvg89RQW3+8xLtEhMYlQW2ILbmERSLhA08/k97JLugQoSM72jY3?=
 =?iso-8859-1?Q?QHW8IUpeT59xiPcJNkh1s2ktMsD7L2RIMVWR6aPrv3XKeMurpJFBlvNfTd?=
 =?iso-8859-1?Q?xGGTQTJQQKF30pCmNPAtWw4mMszANvgECkG9W1dZh6bniyrrTKGYOLQ+Mv?=
 =?iso-8859-1?Q?glAvKFzia6RbJwS6QcVIP1K8Q92Wtf3P7mG06wirlCU8q+uAqwLcOaJEVJ?=
 =?iso-8859-1?Q?ty0tdzp9sNfx3YOa4qRkFw+MUlKBBAGCu+8x+OFohEJ1fQvRY31kNSeK4Q?=
 =?iso-8859-1?Q?xbNkxijRmCDDgHDch9ngIOEEnPwKo45bVNFwZEzJPVwClityBIPX6QKqy8?=
 =?iso-8859-1?Q?jgsjPqqZw7o93ctSLRswRQDMWMHjD+TqE7DuvixTe6bg2g/j8Fjy7zU8uo?=
 =?iso-8859-1?Q?8Qb2j4xdRaNO5n8NK+8T6DzLxkqzdgQf0ZXql0KrAKtbYCQrd6PLU/RQlF?=
 =?iso-8859-1?Q?eWM0elu5iHAduh/xYwTCm4X9PoHXRChbrrBNjbAX84JSYnoyPyWKfpNrH9?=
 =?iso-8859-1?Q?jDNqJxoQPoD/QCeSQ+yPhrt+We5HPkBdt6Bv+r0LUSt0ip04Naqkz29gQj?=
 =?iso-8859-1?Q?/R4Xib4ezrdUaVZTDwL0Ni2lWHeYW/qwqlHO0ld5QcvMmhosbxBXH3+ZSe?=
 =?iso-8859-1?Q?vyghGh68agkY9PIYRVVqf6c2pP3hcYWBom8bw5P6P0EXdFSfI/20e78ROP?=
 =?iso-8859-1?Q?LWToxbP4CZWly2q0o5tFABQshqK408uFkp9EmXjhAHLtfKC95dfNQzVw6Q?=
 =?iso-8859-1?Q?Y0mAtfzcV+DrJP1H3EZ0gioo7QmbBgHMUaHgJ/e5fmgc4ODxlOXLL1taHw?=
 =?iso-8859-1?Q?2nCUDhw1Dz4QRtu7LiUbYrX72CyW2x1qNPhbKtuVnFEO5f/ten53fCpVP0?=
 =?iso-8859-1?Q?k0lhcvbLCgSPG3x8ffn6IFOORM9notqz/JH9Ghfe3Az1SIMxw82YiMehkW?=
 =?iso-8859-1?Q?Bq77QY1JaTRz7s61IOIABeutb/lPE2IJhzz18V7vPsl6mPp15ohmOxdWPU?=
 =?iso-8859-1?Q?kl/vYyRM4Qdy8ZGtIGk5UJoMEQhHXgmxnw+wn9Ri1d0g/XzS5XUmEHVh2o?=
 =?iso-8859-1?Q?Ca50AKofdwHY3xkvLaX/IJS7ROXR6LIL58srOCvS5QF4D+iTcEne5WRwKg?=
 =?iso-8859-1?Q?OHYlNp4UW1KfO1Ondi6Uza87U4crPg3fvN+zNaCr3XZZRDNDbcWUgN0aaC?=
 =?iso-8859-1?Q?UlAQMyPNKr0qVFKTau4D2VTRC62rQHEu+VO2Q26WRRtsDFbHQPFPUMPYHY?=
 =?iso-8859-1?Q?xZj8oaQbESo61Nz6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d97839-092f-4386-7ae7-08de865e967c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 08:56:34.2884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF94433AE8E
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227491-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[live.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E12FB2D7967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Upon resuming from suspend, the Touch Bar driver was missing a resume=0A=
method in order to restore the original mode the Touch Bar was on before=0A=
suspending. It is the same as the reset_resume method.=0A=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Aditya Garg <gargaditya08@live.com>=0A=
---=0A=
 drivers/hid/hid-appletb-kbd.c | 5 +++--=0A=
 1 file changed, 3 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c=
=0A=
index b00687e67..0b10cff46 100644=0A=
--- a/drivers/hid/hid-appletb-kbd.c=0A=
+++ b/drivers/hid/hid-appletb-kbd.c=0A=
@@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev,=
 pm_message_t msg)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static int appletb_kbd_reset_resume(struct hid_device *hdev)=0A=
+static int appletb_kbd_resume(struct hid_device *hdev)=0A=
 {=0A=
 	struct appletb_kbd *kbd =3D hid_get_drvdata(hdev);=0A=
 =0A=
@@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver =3D {=
=0A=
 	.input_configured =3D appletb_kbd_input_configured,=0A=
 #ifdef CONFIG_PM=0A=
 	.suspend =3D appletb_kbd_suspend,=0A=
-	.reset_resume =3D appletb_kbd_reset_resume,=0A=
+	.resume =3D appletb_kbd_resume,=0A=
+	.reset_resume =3D appletb_kbd_resume,=0A=
 #endif=0A=
 	.driver.dev_groups =3D appletb_kbd_groups,=0A=
 };=0A=
-- =0A=
2.52.0=0A=
=0A=


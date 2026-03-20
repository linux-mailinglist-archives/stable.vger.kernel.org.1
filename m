Return-Path: <stable+bounces-227497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L80M6wNvWkO5gIAu9opvQ
	(envelope-from <stable+bounces-227497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:04:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1492D7B42
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9884B315745F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0D37CD2E;
	Fri, 20 Mar 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RFbEefi7"
X-Original-To: stable@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AF375AA0
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997132; cv=fail; b=pgMUq1S2Gx8KDTL8jsyabEQj9d+jYN2o2pOY8/l0/qiW1vnoDVdaiFgUK8BgADH9iB3qFRJxkl4ZAx+VWDQLqkp6VS9DX9ZoLGfGyjcS28dcVhmxLIljBMOnatXVvVtyzakOtc8pO5iaAITkiUbqADaHkr648Q5xJbyobyN0p0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997132; c=relaxed/simple;
	bh=V03Izz1xzB657yqPJcO/xLuXiczoWflltcsOmELdn1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2/iL79Zn/dj4E2M37kn5xp8gpf24bd/9P3wgA5beDAWKjGz2cz6IM7se2IGFhS7EdxJK5osh35v0/DrN5RSn4AVnyWcwweNqL9ZUheJZovzPOxv9eldsI5Qk51lmLDPFVzuRkm+lj9NrSYcUGQbxzUetEN4u3Lmo3wRjsRIJ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RFbEefi7; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgsrEbq56LLeHjtf5qEZBgo+iGNpT5IkEtW1iiOwBS8zC8xK3gUuVMe+LQJgLC5iCAjwmD/tJbxaKuJh8WtVeUKqlrKILppbpxaK9waKh5NIW6aESiZSQpqgC/SnC4YfH4ylwx95/ruW9lcYaLaqoYXqWnGMxGuLVgZVGPXo7LjrVUS+O7lXu/j7w7zjoL0cjU8FBTxrPjGdPmSSLc7OnLlv0lA6w6Ep4OudA4qDxb1tMepsuK82Nr28FXvnaw/mlBO/eWxriHDVaYokmT/suFDi/oPBWFKqxlkyuNcQpgZWDxLvlIJmiEklL0qVge/EHUfx09rUR8Tuxp4bt1QeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR3aIgasBW5c5+YgG6ZuB0Iv8ruXBCgjEEgtzC7Az9Q=;
 b=iBw/irUeJ09lXlQoH7Sw+bX02PdA+LfUGVVChefhHa9p5Gk8DVwfDpCpqcNAeVs9D5HtYWY2ximrDGYB6gyJGAKAX9QPf8BBKH9dX9tPGmI4wqJ1/8sJUMhZv1dDs0gTC2puZBMb5dWLbDziLmZyb9FvDpPLbeKBCywDMIgBWuTOhf9SPsIMhakF3SQLIAMisKspdQ+merxLqSd2uNLrVYcpREzu1Nud5Em2XPHnM5cvXztFCeHFrfGHMke0jwwiL4XXEWPiuBYhXR1gr5/ruTFZXzyBzOMOz+FKhGyoFHWHcUeRnzfYoJB16PWollO0u2swdpaPUC7whjFfPwE/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR3aIgasBW5c5+YgG6ZuB0Iv8ruXBCgjEEgtzC7Az9Q=;
 b=RFbEefi7fhYFweRlqJ4f9lgkL7/VLGd7CjOLdshVmICyBMAzetAB/MRoyD4uq1iko75YzzXABfT80WiGzISN9oIKP8RfwELArMIHN1wy9QIo3HuhWHmynTjAYfl8YzZ++axZ7gMlYXbtB7KIZOGSvTTQohi9J6P+6YnQTQouV+YLYe6Rac4BeiJn6LPDZuAycJN4dOqBFEMA3335+aby9oIgvLqqwKLNIx5brFpf1prKqlExfcTQR5DG5HmvCOJ3lXwBXgMlmsjQZoSE6CujGcBy70oGFL4IBsGV+nyQ/cDvHBlqoyWauZqYRaNZv98qhG9PZQo5cpPJkO5a4b48qQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN2PR01MB8790.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:118::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 08:58:47 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 08:58:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcuEfDaI8i1D32akiLbFfObzRjGA==
Date: Fri, 20 Mar 2026 08:58:47 +0000
Message-ID: <20260320085841.1407-1-gargaditya08@live.com>
References: <2026032051-flogging-glade-d6d9@gregkh>
In-Reply-To: <2026032051-flogging-glade-d6d9@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN2PR01MB8790:EE_
x-ms-office365-filtering-correlation-id: f2c93761-d7b1-41d2-4c4e-08de865ee611
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|38102599003|41001999006|15080799012|461199028|19110799012|25031999004|8062599012|8060799015|51005399006|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FZScO/nT1hMUIXYw87fNXYxUIrCR8V80SSmB102rm2PHvNawke7dOUZMrQ?=
 =?iso-8859-1?Q?pzm6UKmFjEd4/nHHDq4GOHlPcD9CiaBbNs+qrMo+AcKOIn8PChQqJqUFGq?=
 =?iso-8859-1?Q?XBrqQE98B6Z0JJiVg1mEmnzbYafzKkaeswN+GR05J+qyzfE41dETNUbSwF?=
 =?iso-8859-1?Q?XoVdoJOh9SDE/JSc8tl8CbxGGVNMRX2O8meBxGeroiVEbXC3m7qX2ZR2Qn?=
 =?iso-8859-1?Q?TH0fIdY75B24ktNprOdL+lHwRJm6J3CfFw74mhhGj7WYiT7bwHC37Sj4P/?=
 =?iso-8859-1?Q?2VjgFD2HcBBTS4C38ozWystIEr/9opjtS/yv70UhINXKesRh3lEesg4SZX?=
 =?iso-8859-1?Q?sCM3AdKufPwCFN3LriS7xNFW19xajovCRP06qaC0F5AygUxrpYf5Ede6Jt?=
 =?iso-8859-1?Q?Y2/wQ02Tab6U3fYRHrgY2nwrrEZ32OLBBrSNBghJqoyWa/KIGuy2yaBwBg?=
 =?iso-8859-1?Q?KfGUsNiPxeTO6PBKFtl8s/78Bep8om4MyuxHplFFPmmJEGzGQSBX9rAR2y?=
 =?iso-8859-1?Q?1HDerPvLAImeOZeUyWDfrTxl7GKY4K/yIn/KCNXX8xECJU8theM651gZlu?=
 =?iso-8859-1?Q?XaSDt3KO28yrtujSVl95B6BjpG8fGflRRJSTMyhm5qgycD4OlEIUGhRRrf?=
 =?iso-8859-1?Q?GjZhhfM8SzrOiulWa2PvZCFrqZ2tP89pH6aP9OlgCU6t6MraFTfrUhnu0A?=
 =?iso-8859-1?Q?mbNz1dgE5QAV1ndONwJ5DMBf/EK++Y7IRxZJnJFSzN0Q9tI1ehVTbgwehC?=
 =?iso-8859-1?Q?EHs8qQn9laROthMRZuNws2KGFdLIf6MrLHgmNnp0isSYmDTY3gP9AuR5T8?=
 =?iso-8859-1?Q?vLVcKVausfhRJibTqyCsDy8CT1Rbzf7EYCjS+zHh9nIhVvWaek0t7GMnLS?=
 =?iso-8859-1?Q?Lv3O+tHw2OwAxd5x5yEJASYRwfUc3mI9NxM88gtLZNpojR1whtMQi68F3v?=
 =?iso-8859-1?Q?Evak4SOEC9APxHWBWHZOlXVyEQd0rGMbpUx0nPpsOXylb38qK0Y916kV0L?=
 =?iso-8859-1?Q?JHOovirpRklftok4uaKShm/yRkfDxZLgG1lk3H?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xv6qhVcft1dbg+PPPocTEiCZJPhiOK6t8r2aHjm6bNsKfD4vulZScMPnW9?=
 =?iso-8859-1?Q?wciCeCIL7CFa7xA/7SjD0dqqzHL6T9OMWtjEZaKLS5Dcebh9mWk586e9Og?=
 =?iso-8859-1?Q?/RM5wVB9Fou5gHULLReDt455hJ7fjB6un2i5k/8loQGdyElXVV3ucRHUue?=
 =?iso-8859-1?Q?OBKRvduDFxmW/X0iIjPC1KCoqFn13O+CZdqmkthSfb3hUqkhaF3+DxMDkN?=
 =?iso-8859-1?Q?iKO/QvUw6isEokR8XAvKxkzVKNuZdfeZvo/bJ7FPx2rA3JRUmZi1GM5C7T?=
 =?iso-8859-1?Q?cvCQoLJk5uxdKA7CLO9swG5fUkIQHhwIhQuoWwSW/qHnA+rPJZkV/cqGiB?=
 =?iso-8859-1?Q?PeMXSHRjQLssQTbkTJjk4DCTQOU2GItHcaruEykJmFeGWqKC7Fb/OnemRG?=
 =?iso-8859-1?Q?WC4TjF0r4+ybFoCkqwGrez8uBCgGCrbrbl4fAQ88XbGbx/dS93kPRsTpe9?=
 =?iso-8859-1?Q?AuteIWCze2LWL/2RqKKN0ecSsp8Sx7uhTJYBesUOU/nsw/WcAhxJl3P47v?=
 =?iso-8859-1?Q?1rwpEECRfcfn1FKP4hEXtw9vA4++1QruBkbVD0hblM+o3r194uc+IzvbP8?=
 =?iso-8859-1?Q?2+MlG89s5+KYMAicKOJ1UIGpNBejTsudSKt0NpMWiNBObfPdBBkwDxU6jM?=
 =?iso-8859-1?Q?mZqG93ZIfx+HfRbxsUJ/pw1DO9nXu0Ut+2gAEc4lJUrTzP0305t94PtTmR?=
 =?iso-8859-1?Q?2uzTRLZbsWS80osce8nLKKM14+al2TeNjXeYRdx2Z+P8S06qdSQfzc63cp?=
 =?iso-8859-1?Q?QP1BSL7rWWwYFeQtjy9HRcZ++VP6sHADW1cEQc/u5K0+a/xDadxif+Ohsv?=
 =?iso-8859-1?Q?R5BAqQgt0OUEZuhzy9xBBgQ9/qKbASdQY73/GqaxqFjXEZ+3LX3kw1JfwZ?=
 =?iso-8859-1?Q?qUEnZIs+pdpOoeEp46RnQ6cs9bVDNh6/9EJ5eFV+F73YvNpsYL2h3xMSQC?=
 =?iso-8859-1?Q?zv7HMPZURR6vLuSPvNqwmxBLdCHfdzTYAQ45hifQ4D2M/j6Swu5gegnkG+?=
 =?iso-8859-1?Q?CrcUgam/XpaTd7KfqN6avJZfz5gcnVnP6Ds0KG0PGWP5VP2Q6B5RTgZmkn?=
 =?iso-8859-1?Q?1RUw0fUZgfSBtB0mdF+klkjCYwEKAgsOxD7oQzEl1CfCXGgQigNNIkwHel?=
 =?iso-8859-1?Q?eoLwD75waiTOyLfSZeK/s8KN9q8U0KKsOKrIyaQ0Drh9Xmqd8ibhbFcJSS?=
 =?iso-8859-1?Q?E/QS6dPECuL3Sy8XAnKkBTYCCLwS7vTnsHfBVGIRVlEJI/Z+Nt5xje5Ybl?=
 =?iso-8859-1?Q?A2E76+hH7t4Th0FgP9pFmxw1TFyc7UFxtCI5lDeyjgESvGNc3wDLTII1o9?=
 =?iso-8859-1?Q?FvF/2J7TSQbRRUyHaON9G+OI4H+WTQ9TRhN+sjNqFw+CN+nbyjVGGw74z7?=
 =?iso-8859-1?Q?SIk74VA64eLykvUWQr92IoaQfQ8/qACgKZtRnFbo/XnoFIck+kJ4M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c93761-d7b1-41d2-4c4e-08de865ee611
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 08:58:47.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8790
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[live.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-227497-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[live.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.com:dkim,live.com:email,live.com:mid]
X-Rspamd-Queue-Id: 3A1492D7B42
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


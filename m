Return-Path: <stable+bounces-216752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGDSET+Lk2lq6QEAu9opvQ
	(envelope-from <stable+bounces-216752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:25:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7BF147B4B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E96301AD29
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 21:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDA2797B5;
	Mon, 16 Feb 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uWFRB5QA"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8B5B21A;
	Mon, 16 Feb 2026 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277112; cv=fail; b=Q4qKnBkFrNvMwoBJV/vO5h5gPa9VCWPpUz1aQsIItFAlfjXroc58mVJ3aMDFjI3CddzG+0IArpHMPWJNYifNxt7BziyGX4AqCxTgW3E5nXpwa5jLx73Rj8I4ADJu98/Ux3mvgPvKsSLL7pHCuKZ8AsYcqO5yeccBpVus0EW4tcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277112; c=relaxed/simple;
	bh=7cfVAfXxozA6hrN3WSA8qXyQv91mKc5ETezZsym3cfM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lrTA1DsrU76qGJCe7GOLfHVXWq3T+f+KUTH1eu+1D9VBoZ25qIy8LXkvc6RzBJTw0eZbipqUryx1+hNnGLsNkdB2HQ6PojdpaTSibD1lkj3WXz2xPwP1kjgCkWlebNJ434WNd4yS0DzjZQ7tIPviLdfJGXS73E45Vcaylsn0ofQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uWFRB5QA; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uut2QgVokyUR3K8sZUcbaUJoIwSnviXwnOwphMbOGCSFh3+YKsaTHs9E2pPXNGAqrq9Vp8BV2kwxGUhhJMPg/suMWDr/+DYmG6gxvA/nRugcjYjDLLeyi9g6CxF9LqpP+TqMBCorWJu9r94NLaJbtdPijLGQrJuZ6f8r4VuMmkZsIvGrNADPJUiA7FoG622OJqZY1aGi25Tuv/UqxByoWUqLOHBKXqmosWQw3sBx8PF4k34sOJtoYGX1b9ajxurq7DldfbGs8niZcQFL9MMJ3V0Pmcw80xtWLjSg0CNBD+BR1+97aQmokIZVbb9cvJ2UqMZjUKOQr+LAlB7oUSHoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbfOETJEEDCdddZ6X8Q9tfWNNEtUHC4HnDwim6vXwwo=;
 b=Acn8hNUwYLkSjaihvuW1Hwta0mcOPyb1rLVfwBTWjL4rsTuhkMuCrbsHynCEYqDpdHtP2w6fpr6CR5sRNFCl4f/4YbqdoVS3QXgY8lKsu2QvLgbJF0IqU/lqflSb/RgdXFi38//y2XbIcU0SU0WgodIx5ApSKZGLOK83XJhjjyKdq20OzKZ69VyR4LbIeGRxnJ02Loq6JP/Zcua7ec2C+uRtlf77vEVtHJGdrY4dHtKckJrvY5K7T0XuJ9CbT5xcd/krLGLC2suCu7thhh3plbIG3mtsM/YUxJCVbyVrrVpew2bx3imondBl/NTvZlHwCBr0Uo1IGWliNMUFVLDgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbfOETJEEDCdddZ6X8Q9tfWNNEtUHC4HnDwim6vXwwo=;
 b=uWFRB5QA06Ypt5fPQWu7oaLqXxuHfSHxMsdKdO5A7qBwuQjDkOYQ657nWAwvGpq8w6PqpUItegoncsR+3VgHWVtuazZLTM1qHK+4tj6uMVhnttqLI4V2R745g4FJc0DYZik++0Tp9MS/ERqunhaLATTmiMTxhHFei525LmyXiB2EQtr1OSoH7WxSd+U3xbADs9XC8HWfc0gaPZOqLIKjtMbrY5NmJvoCDWqrp2Hh1Dlg/iLslsSJhghPawSbWYNpiGsTJd0okTUmcXBR4OR4WmtCNd0g0Ytcm6uNHJJY+SwkKnspsNgwmtbuG3HPKSmOhdmNMTeJJ8x+/MxLvPjO6g==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA1PPF8F457A31C.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a04::9f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 21:25:06 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 21:25:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: appletb-kbd: add .resume method in PM
Date: Tue, 17 Feb 2026 02:54:46 +0530
Message-ID:
 <MAUPR01MB115468D46765D7DF8C2882B4CB86CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <20260216212446.1520-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MA1PPF8F457A31C:EE_
X-MS-Office365-Filtering-Correlation-Id: 926ebc5a-30f3-4efa-3fd0-08de6da1daa5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|41001999006|19110799012|8060799015|5072599009|5062599005|461199028|23021999003|440099028|3412199025|40105399003|52005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Qykz0At91H7NrXPbT3tvg3s3au3InrrEnedRZGU9oorPJ8ik+Wa7JAquRsS?=
 =?us-ascii?Q?vQFc+WMPQWbkwowVoeK3F/rWR+g39lAM8ct+5XJZ2RNcsHgRaWRK4btur535?=
 =?us-ascii?Q?h8WaXPULkFNnhFc+ZIKtCi9BdTJ/5yRekp6d0mZgsB0btt6o4mJxLVouP9r1?=
 =?us-ascii?Q?LT+VpRShYWb8N8ire+XLVr6+TijvdChQ2hiNYgBrL9PaYthNtbO1oLYEf8wY?=
 =?us-ascii?Q?VJ8TZ6IHyWSXxFd/U8veQlbe4AqcnhUxdMQkOepdxqUZWRhtwnKXrkLEAZcF?=
 =?us-ascii?Q?kY6p74GOWq2ARiIprOdz0kuEHzsqeczPWtJTvsnSu7Sasr1MVjsnRWvd+tdE?=
 =?us-ascii?Q?u40BcJ7wyAgVABb+uGHwuttBaXqDFTYaPxqGZ3BhrCrEAAE4m8LO7r79P9mg?=
 =?us-ascii?Q?Zvb84pKaJ2ZUXmcIUY05JqewcndodkTvdJB98nQ2SlqD1QQaOjb1h6mz8LRZ?=
 =?us-ascii?Q?J9RWkFOHTYouCRnzltalkG6WSlSCehMCrqrBCfXZ/xVJIFiaf3s6kKJlDAVO?=
 =?us-ascii?Q?wbyUWQtSDOOGX0qLGa+rWfoePPG5l1gf4WJT7mEZXzVpAKNaaL5hihvclYxH?=
 =?us-ascii?Q?iNG+un6P0D2PNQDutxXqiYAYbES+HoZb/gNY/YJx7b3KAV58SxwIIJ10KoSl?=
 =?us-ascii?Q?ECDkAzQ17izttNVi+yiSM8HhJL0XeBJcgQmjhREL62r0QmHck/4Xjat4Prbz?=
 =?us-ascii?Q?lJve1/XtjwlNVzivXJ/1CDHue3CqmOrJp/mVLpcGTERgJWp6LdiUoMD6zH0F?=
 =?us-ascii?Q?0IBU/icJW8Kfh2cinsShGl8ZWmctK7xNVXa8IpBqSF0UHQGFfEH2Fu0TpHLW?=
 =?us-ascii?Q?omASyKxSvjLgUn87NwOwfL5wTIG3pNpXaQu2PTH+4sR/oNyOasTxlvf8Gn8V?=
 =?us-ascii?Q?yG7j66v96bXuPQ6Tq46n4Is7DAGA6EyVhsvV7LDlAZhzhuUBKP1KJHHoBMwv?=
 =?us-ascii?Q?1jyU/MN7vJgmXFFV6cT469O5okFOX8KIzePJjRcdlvyA8UFiNUCB+DvkVTFs?=
 =?us-ascii?Q?OmLoAkLms1p2erdLwEV+o/+NwIn6KJD3Reyj6jYjkSLNPQo8biNwup0qKjyP?=
 =?us-ascii?Q?LB6riQQjNN9UcXPSSJuz7/KoAyOlTt8dywu7vagkwi+nD+mOVgXl1nwE3QnC?=
 =?us-ascii?Q?sFyWnho6D/wQPWZYmcC4e0gHvr3rleYnGOrIYccHJfEBSzbm4oK7urdt1qfh?=
 =?us-ascii?Q?gELjd6EYttxzWED9zO6llYED84L70WelJwfus9dH7GpW2GxliSLQ9rbLsB4?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwhvZa5OiPPxZnjB3lKvuQ4g515pnibPqLIbtsE4fYQuw09NPp5swxnQSFte?=
 =?us-ascii?Q?QuEkfk5u5HcghwMqP+6pzakkAS5CPvtG2wzexLLbQXISW0eFVpAOKbJcYrtm?=
 =?us-ascii?Q?foUpT4rzSI8srWt7yqXKN8zD7KrXWpdYN8TC/HIfzmJvjGdxbFxgDjYm/6Xh?=
 =?us-ascii?Q?EW2lwMJvDjDFJhfV4UuKXz/byk+Zuy1GL+Zo83Tl2yKwuS2FJF1RQRqVAL74?=
 =?us-ascii?Q?keFfPYWsdJp47IlaaGx/LeZk8G9aD8lhFapjtT8HEnO9+R6Ss/dsSogAB3Qk?=
 =?us-ascii?Q?QdEskhoGTPUtI+xOyS/hOSJnLedCAHYbpLfAD/3d0hXfIaV77oqLi/HAHRZu?=
 =?us-ascii?Q?VqBE8SGFbi9FAEtRXYeYt7V/TQSpCl3XAIHz8pmJHKRNbVXmR5YJ/Xdl8T++?=
 =?us-ascii?Q?Rv7GuUHs7XZpweDVgaMR3iAFYzRSa1weBU9u57/jZULNVroWWAEqj1//M/hX?=
 =?us-ascii?Q?9WZHKQWYHnGoEyt8hSJaZMdVohnb/VWQBEfdK72L4kMqjs9HdLWqHWqtBXvz?=
 =?us-ascii?Q?UDtqjsiOJ5ARTAYumFaM7rdW7tTvKMOVeQ3SiLCTUIZzY7WCZS+LRXrnCov2?=
 =?us-ascii?Q?F1n06WS9v4tZUIJCyYHZbqF60hq11XIe5Em5ztvRQJKikVAW/aqHn9feEtmn?=
 =?us-ascii?Q?FN138Phrl1r5i65xeLLxJB2qu8h1fwAsfqLTnuwgi2u7flOgVUbvjzl4O4cv?=
 =?us-ascii?Q?76OOoIevKxh0heKgyrv4QuHpNsScyKR7n6IekOnwwG6TjdmLPplmhoUWZ0D1?=
 =?us-ascii?Q?n5z3JQAEqvqlRjy2uAhUQTwBW6tMLsxaA5s7CZR/FdJIz2G7REVThnrBS8jP?=
 =?us-ascii?Q?EQlf0dkvsXxXCmh+MpAlIBRT7lKtVTqlk+BLt9BXFszX44GROjMeWm67z9j2?=
 =?us-ascii?Q?f4KmSmfLJPIGNyacHD0odml4CrPqV1q4CGHO0AAxmajF1aNufsMklIhKacF3?=
 =?us-ascii?Q?oW7/4YM4li7RanNrni4dXXQ32VRP1usTDGIo+TD3BXmCGZNI61rlN2QdCEFG?=
 =?us-ascii?Q?MAbA5ElOGej4Tp4Fhp3x36e7+CEGXKprouaWV9tOlhpr409hGn1A6NiGrBUo?=
 =?us-ascii?Q?Ld6yAn1Oi9vSc+B1VuiBzBEkwI2Rl5G9PVCZn7qOGAqb7X+Cx9ATu3IInrAA?=
 =?us-ascii?Q?pECyCXmc/Oc1R+egHSGGVumAvQ3kjbey5HT/zqPpQILHOccokyWCI4ySZy6K?=
 =?us-ascii?Q?UtV4ntNj6LvwWPOs9ylyN0ZxZSg+Ttzjwl3jLI3MmfM56aZKLG9Kl2iHwSpA?=
 =?us-ascii?Q?8qHciEUaDg8EtVGLhd/omLOOXVaZSUDREHweo0ass8/zEsjX4fopCjmKV8wr?=
 =?us-ascii?Q?DMdfugNY2LzXBWduUc3Kyg6MR55Lyvnyse//MI1GdMAYdXi6IFJM30/PClgW?=
 =?us-ascii?Q?jWNBp1q/B80W2jf/RJAliEAzp9Jahan+u3HH9Sm8iQjgR5ctj/x7O2R5y5N9?=
 =?us-ascii?Q?pe44MSvxTj+7KBTSMjw1LH+T3bgGz/9y?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fecfb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 926ebc5a-30f3-4efa-3fd0-08de6da1daa5
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 21:25:06.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF8F457A31C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-216752-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[live.com:+]
X-Rspamd-Queue-Id: 8E7BF147B4B
X-Rspamd-Action: no action

Upon resuming from suspend, the Touch Bar driver was missing a resume
method in order to restore the original mode the Touch Bar was on before
suspending. It is the same as the reset_resume method.

Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-appletb-kbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index b00687e67..0b10cff46 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 	return 0;
 }
 
-static int appletb_kbd_reset_resume(struct hid_device *hdev)
+static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
@@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
 	.input_configured = appletb_kbd_input_configured,
 #ifdef CONFIG_PM
 	.suspend = appletb_kbd_suspend,
-	.reset_resume = appletb_kbd_reset_resume,
+	.resume = appletb_kbd_resume,
+	.reset_resume = appletb_kbd_resume,
 #endif
 	.driver.dev_groups = appletb_kbd_groups,
 };
-- 
2.52.0



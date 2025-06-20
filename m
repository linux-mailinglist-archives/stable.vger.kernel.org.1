Return-Path: <stable+bounces-154929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D8AE142B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968DB3B164F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77423223DE7;
	Fri, 20 Jun 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b="QF2ZydTL"
X-Original-To: stable@vger.kernel.org
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020093.outbound.protection.outlook.com [52.101.188.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CA22259B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402084; cv=fail; b=lNMGofHsGAxG5eyO2+yN0bAva/hmB2kWM4XfhCe18abDnq1ZV5pb78qV+aUFZn221E+O4J1AEo2ADFAta6DhGYMtvLVr6e8dbj+OBX0w6OHU2wvzhP9laxh1OJQTeBRsr6yPBjy+vHGtFiI4Al0aCpZTb3fiqKO3BBJCOtBY9Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402084; c=relaxed/simple;
	bh=wMagYfGZs0IU1iRC9/xIcZKokR6HNGcAy1Setxa4l2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UjK5q1JKmcFrQ+pynyvMY8Bmy9oCamFf+/gF+fjuw5NZ/UnHXTnqmFjNjN7x1Si0ggSnoZOFT+eH1jdc+wYL7S2ETn5K2hYVIZps02w6WiTO1OjyWrCDZ9sQuio9Vg5D82G1LN+p7MjJXT0xgb21zrlF5iVuv/GsvzhNR87usHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com; spf=pass smtp.mailfrom=konplan.com; dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b=QF2ZydTL; arc=fail smtp.client-ip=52.101.188.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konplan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBBoA/ec+ml97z+Fdu1Tf0gCFLKHOAq/RbxNsi3kPuOuJ4qcxwXYQ40d+QtcV4s94cFCfZMEOfIuL7aHPGkQ4e2I2oPy2GHGQMSMLqAgl/CDZ4KvqrdJCF6D4LmMkfM//NOk204PMXqQ4Y7IMlrpQqK1SSSXNH9vQ5WcZ2NKXLpWtO6sgw8ml7uiMl+qFAvRNqVbw0pYwLUJhYeyRkd6T+Y2DsK8ASHqRZjP4/gkLqPr1YfTwsoNXmsnJK1f8iWpbjweU0AcIRE8Cjm4D7z+yaaWYQ7SKOj4SMlPWqtPx6UybsEXxeEOke6lU6pdsRrkkeLPCQgkpM8WBYpNLOh8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMagYfGZs0IU1iRC9/xIcZKokR6HNGcAy1Setxa4l2w=;
 b=SylgOltHMog7cbuwaCyq6ibU/pYTGUOY7J/OFwco0VVD6HTtBIU7S/F2uFszi4OX7GNvvE42v9k57DAxtpwylptSwbdDStUQVn1Dje9o0H7Y++KLZIV+Rfg6XDPzLlQQQshL99wI10tlQuWBfZdMAleKxOpxFI56vNigRj+o6OI59eSiS6NmvQS654Lyv9MJ3Mz1/7ZnPmxsDyxx+euGw+qTFppzGyt2+VvB/TYy+/L1AXqH2xhhmUxP0H4DJpngVf6mQtfxMWbwJ+pTzPOfYnQYsaiOOPbu3egcIosYkOeoP2JGBGOHwQrozaJbOTD6gJWZE+CeXVQdYtl9kKtE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=konplan.com; dmarc=pass action=none header.from=konplan.com;
 dkim=pass header.d=konplan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konplan.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMagYfGZs0IU1iRC9/xIcZKokR6HNGcAy1Setxa4l2w=;
 b=QF2ZydTL0lqVAt7NLGMl8AUwQdaqRiLDhhTUKTY3HRbiTK3avA0vKXKOIHqJ8JcQKoduU+AUN3GsWqVGMCdURsrIS4N5US4X7oHT7NBtcDmxIaNVq2tOKcTu/JlSTb19Oo3Sy/G9HRVKjxGELdA4OtdzmH2BQX2btG2IHGgtcow=
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::12)
 by ZR4P278MB1885.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:47:59 +0000
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ddb:a69d:c7e6:28ab]) by ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ddb:a69d:c7e6:28ab%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 06:47:59 +0000
From: Sebastian Priebe <sebastian.priebe@konplan.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: AW: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Topic: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Index: AdvekB6VDQOyY8zdQ2OLKqU1kdTP4QDHpWcQ
Date: Fri, 20 Jun 2025 06:47:58 +0000
Message-ID:
 <ZR0P278MB097420DCEF0AC969D89C37979F7CA@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
References:
 <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To:
 <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bromium-msgid: 2e621219-df30-432e-8024-39525bb83e16
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=konplan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0974:EE_|ZR4P278MB1885:EE_
x-ms-office365-filtering-correlation-id: f6773e3d-2234-4ce8-d6d0-08ddafc66509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/Vr6oWt2MspZukiZ7MzAZlIy7qgYRLBtlKkmArYDzQ9v3club8uXGzTkxM?=
 =?iso-8859-1?Q?H6Zt8rpP5Gy2ZUs4G/XVuvdClgpqhQ5Rd7lC8/eoOWfwV6VXz2bjNDf3ct?=
 =?iso-8859-1?Q?2w5Kz19HFhWOiHR25whvnkbIxjvTWpe72SAVLHFTBwfYIt5uSjeNCsmtHv?=
 =?iso-8859-1?Q?tnKN7LVikea+SuhPzftJGIpJzkBs58tqSIzvDg3Dh3WxLt32YtO2ak/321?=
 =?iso-8859-1?Q?wt6QPiMreUztMD9L/IY7qELzr70d8N1yRduduOK65aeC72WW3ONb4jJsL1?=
 =?iso-8859-1?Q?mzh4AJOjuQqKvlCsO7udpA2LyEPOvr/HFdQNQ8Ca6as+YuIClFnRy058ws?=
 =?iso-8859-1?Q?RWr5TYxIe78mzvV3cP5YasOMkY/hC+bEeug3PxSdDbXw8xCTsam+PE/+RA?=
 =?iso-8859-1?Q?CSFY8YX8aUbE5AlODAQm29h81PBiNgLdPdZv2yAXz3BZGwdqsB6dmtgiUM?=
 =?iso-8859-1?Q?8yFfOxk7KhUSRlyhgvfwxnjHGGRVA2bLnE5SjxpuR47Z3/feIQoR9pgSd1?=
 =?iso-8859-1?Q?UqB78axy4YmhMk+Aq+5LcpHPsas43r+B5tD8MQDW25XCrXpKo01iMBaaaE?=
 =?iso-8859-1?Q?6qCOfGtEecuY/TtUR5xeiwwa4/6+hzKCbtuBxh4zfex7GpvOQEjJuNIqH+?=
 =?iso-8859-1?Q?YAVFGiAEhfhf9H32TDFgUGOyyuXxwiv5WunrZn9JymqzNL/mUsQNqcW7uW?=
 =?iso-8859-1?Q?EeD/GNwNb7Mm01NB84rxMDRwi8jKbRB5/HF6+4g+p9RyLh3OqA1rIu8fcR?=
 =?iso-8859-1?Q?bK9JFfj2b920vrMfHrC02Kc9uNsFOgv2V85pe6/YDVuZuIi1WMfoqbxIK2?=
 =?iso-8859-1?Q?9CyjglpyqlMbuYx+Vng5s8fuEeCYIbBd1I3yLvHSzWqi6IXPei4en0v1yd?=
 =?iso-8859-1?Q?ZIc2lvgTBniQGAix6hCSu3SiVBAzBVRVUOkLbmfi70/yqwdHEsyqHUs1z6?=
 =?iso-8859-1?Q?FPAkMrEpYvEFSLdjYHSrFh5i2jM39xwKTlkkiO+w5Ur6kszdzoQdA3f3a0?=
 =?iso-8859-1?Q?5okYR3O6Nt4PtgMCAi/h1n4nyDI/CqvlDE4Ng26Ev0Xxbkb8HW0DJZ/DtN?=
 =?iso-8859-1?Q?p1HdPMVB2R2wACYZOmeBZFnqXo8DoYLBs6nQEWOpwyvkzW93iYpeQkdY7E?=
 =?iso-8859-1?Q?+ypDj+6KnfaMDrJ4B+tW5KAsR7nR52MnlmiT72w04Uqdc07mFVXCxcR9qK?=
 =?iso-8859-1?Q?rVkwNvuxrueyDa7Tm7zRi/JQVNvIoTJsrp/zJw2/ln570Urc7IM8axePhv?=
 =?iso-8859-1?Q?9sEdPAUmCYz7YyQBGDECTndPYyS+OhEUTrqjf6DgtuApDqq4K0Gw7NRdft?=
 =?iso-8859-1?Q?EOTzz/tV9Sg3HJbLfVspPrd/QbKeg+83xFcS2gfGjl/lUwcQ0e58g40oWc?=
 =?iso-8859-1?Q?J62MihHZKHeVXSphxVy0uDfnnj85BTx07kfh992jXoIR2c/QzLUoS1AeaP?=
 =?iso-8859-1?Q?5iuQiw2EqGbbVKL5FqI9MH2NwFkV1fCo2ESh2oageLPfyPtsBWxUYxj1pD?=
 =?iso-8859-1?Q?w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/guhaTCL3TdqEQkTXMuo6ajutgl726uLMtLXPoRi/mLVMJX7Hsyi3FVmn2?=
 =?iso-8859-1?Q?SYFZpuXtMPg71CSXMPaVCIgxkProDf0uny3Ip1QdzPWVIen3RnNFTF1etg?=
 =?iso-8859-1?Q?Ki28EZBJPRorfpM2uVFmz0OO1ZYY7c91zaM3hGb6t3DiDJ/5gpEG4R1fBR?=
 =?iso-8859-1?Q?5RO57ajAj1qMQr6wxX0ENIloT69c7LpG3IQtt+rhNcaOaxG6FMseshvxt7?=
 =?iso-8859-1?Q?kt2Nnjp3sXPdn1VczW8wldfDrJT3o1Y72EE3B9QX1k32BRKsTnSaYQcty1?=
 =?iso-8859-1?Q?6QygeksTUiKh/kEOZENSJ8GwkdOF1JKrWRVTvn9nwlmA2i3XO0SLmtH3wY?=
 =?iso-8859-1?Q?M+2REvFvQIxctxAAR0CK9BO5Ll+zbhOHEC9FdsvFU/R+Xm1iM5sjwtitt+?=
 =?iso-8859-1?Q?60RFK7FaJeyPeO3wOrD5gBkWWbpa90386XLPjVz9JmT3vVXBp3NVk1uIQi?=
 =?iso-8859-1?Q?pQBsC/hm2DHjSpnOAiaHAQlkwNfYL7tUYblGlzsU2oG9PueZhZ863HyK0Z?=
 =?iso-8859-1?Q?Ua6FR8DvXYee0+Ss7UdiX2P0NdPsOy6t4EQcXZw9nnYdnbxuquIlSzTj8U?=
 =?iso-8859-1?Q?cYcbq584eBz26bgH6K6rGf0p2UkkmuRD+zgHs1F68ddZNS9n+qPyqqk+X9?=
 =?iso-8859-1?Q?V3OpGVPipz1rhG7nVAjoLGJytJy79/xVRYkPKtGiwXsAAKrVju5ih/lObm?=
 =?iso-8859-1?Q?N6Bx5VOC4lZV9j580v2XyNDuh55x7yyzMJvXAd5D9EpcD/NLuiLQkiYqwt?=
 =?iso-8859-1?Q?uoXjfY5E9iAzGjxD5XII5Ch8zde9SUBc7QhxHcLDDkBnBSOUM26bitgZmu?=
 =?iso-8859-1?Q?5Q2Z7Pt34PSVeOuCh8lD9rdzCtic8eULwdpWv6D/mzYgVU+yjMJpCB4P1m?=
 =?iso-8859-1?Q?NnY5bq+OaOzzQlCrSByekKSvMMDnKQRPREuXgCMu5nw4PPyCYZHsKgSNcC?=
 =?iso-8859-1?Q?oFRqIvuRZgga+P6P/tkd3G9DmHLBVodMKTjTlid9+cn+XYD2zq77YYc+Xt?=
 =?iso-8859-1?Q?bs8lPoqfPa/VjyzYlyDmaals+cSYbccyTIvaLhW6duaGE5LxVCwM6VvHbR?=
 =?iso-8859-1?Q?n1IpjUoenMRstxYxeAdfSbid656tL65L1YvZwawA68UMIXIeFaiVPvkbul?=
 =?iso-8859-1?Q?7E0gntrvmEuNxtRXBJIQ8F45aA9Ctm4+NuezDQySdkPv1DXkuB3ZTlODDb?=
 =?iso-8859-1?Q?g50ZnDan1L6bVRoNUFdXXrgMWjsLfZcEGgIAr9O4RCMGDQ3AzI+1Nk+Kr2?=
 =?iso-8859-1?Q?shqkTVkP78w5nrZ5kLS8wy1YzYV62/sRIH9OSih1TKSbIIjPmRQQHJr0Ar?=
 =?iso-8859-1?Q?LnzMsWoyyOndR3Li+9bMVGVMqHCM5AWf2AV5EBT4GbrrKv5GlD9y2AGHRn?=
 =?iso-8859-1?Q?AekrYBUkhWPluXslRolafh5FMybu7J8MR9nxFnx/iykkBGhVUduVkRMo5i?=
 =?iso-8859-1?Q?C15bbL0dmYKdyccfL8DN1YjaGcihv+ENhctxqCTgBg6xG+xd5bigk6UuyL?=
 =?iso-8859-1?Q?2M9zxk8bUm6E/zTZ2QLDXD4B0XK7LX+vF4SZMG4J7epMTrPD6yoKXKmnTb?=
 =?iso-8859-1?Q?SNl0Lp4PkAN75uuZIY5qJrPUNH62JWhJKSTfexWQ6kj0N6XieLD5tTY9v5?=
 =?iso-8859-1?Q?WWWYirC+M0HkFQWlzznXIa0OoldcsZMfcLqtkPtp5NtedS5zWxwaMTeFTL?=
 =?iso-8859-1?Q?q8+6DVvHb1u504pLl7KpWFpbkJBGDH+w5A844JGiGtFGOhUu6JEXw/R5Wv?=
 =?iso-8859-1?Q?hTig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: konplan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6773e3d-2234-4ce8-d6d0-08ddafc66509
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 06:47:58.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b76f2463-3edd-4a7d-86dd-7d82ee91fe05
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9fCsh/A8uxHuxXtLoMSW15vwIfA8mZ1WTBmktbjKNCeykrG38UHE1ewB+0/5P7mDWRfBugjSe9tc+rxrOzh8ybVmrTzPx6x5fhnNiFkSUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1885

Hello,

Could somebody please have a look to this request?
As I mentioned in my last mail the config option BLOCK_LEGACY_AUTOLOAD isn'=
t default y in 5.15.179+.
This deviates from all other versions (6.1.y, 6.6.y, 6.12.y and mainline).

Please merge 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default BLOCK=
_LEGACY_AUTOLOAD to y) to 5.15.y.

Best regards.
Sebastian

https://www.konplan.com
> -----Urspr=FCngliche Nachricht-----
> Von: Sebastian Priebe
> Gesendet: Montag, 16. Juni 2025 09:28
> An: stable@vger.kernel.org
> Cc: gregkh@linuxfoundation.org
> Betreff: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
>=20
> Hello,
>=20
> we're facing a regression after updating to 5.15.179+.
> I've found that fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296 (block: deprecat=
e
> autoloading based on dev_t) was merged that disabled autoloading of modul=
es.
>=20
> This broke mounting loopback devices on our side.
>=20
> Why wasn't 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default
> BLOCK_LEGACY_AUTOLOAD to y) merged, too?
>=20
> This commit was merged for 6.1.y, 6.6.y and 6.12y, but not for 5.15.y.
>=20
> Please consider merging this for 5.15.y soon.
>=20
> Thanks.
> Sebastian


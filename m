Return-Path: <stable+bounces-227578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEpxAnKAvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:14:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703C2DE64F
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2709E30293E5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05493CFF54;
	Fri, 20 Mar 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YTNkNTpi"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA453CD8DD
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026563; cv=fail; b=rhooIL+Uxxm+3BO8TDiD8HQsShvogjS0g3gvUr0vSraHszmAemQ+JwAWDNZGUNf/hTDUgJ51R1d+puUIyLiYUkUjrDACn/9g6vBldlgtgda1ZCLdn3zBooM0nJbysXVeRRWPPv7Htm7s934G0v5JRhY41MonG8eyIch3/Ui4Gj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026563; c=relaxed/simple;
	bh=JdNjt9Mroz+49rFhsCs7mW7WM5XylsYGqQNA0ZG0VWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HULuniNvJ2UGK9+m5JzazGgnwG13O0mISxGlZEy8MUxCMT9pMZKEs38TK4Dfq1ozYL4ojjJAQEp4ngxxLIrz553k0mQcRhDW2EQzjHovJ5cfIeKW6dsWEAyBEIKzeA9YwFARFxkeYA55gWdgllGTz2XN7XfQ5RFkD11um/LkLks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YTNkNTpi; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+11JxpnBa3zwPaGXrZNGu8Ugq0047js+4bVcC/AN8UNCd/IQLtm0uh1R7mfBEz9tKcpbCbO2QWnVRhqzakqN6gl2h4AZaNykfkiD9Mur9sfkpEsw5tdEEwJlenQoPirUPBas9qLJG4gg8wdl6PnpnRJjiNhj51E6UUMrMYsbbb/aK0aVIeHmoeC5z3brWmF0fml5gAJ/P4d/Ljj+8GSGwz0PPoxZaTalbDQ91Snpjt6MDauh4xBAP8gtF73b0iFK8gvp9Qp1q/bf/Jnsn7Jk7UShaMI7g5vdgNtVoi2ue2UhR0haDqDJQZl8PK+xp/dU/Avy5gkW6md+dW2ggVrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdNjt9Mroz+49rFhsCs7mW7WM5XylsYGqQNA0ZG0VWk=;
 b=eVh5sN64XhoFqq6kAQcfgqXvut59Bw6IvIrvKdrTK6nopnKHG3+RVJVhqfPz2cDxYwwNXuohddyoLBbaPSigLy3J9KZBg/eEJyTR88iN6aBUCEpGwDTp6CmHvGW+MAojwcZJMPxPpH7tEKK9PTqh5UVjxZWhq0+aF+ROh8A6P4tIf3EPktNlelBVGoMHjE4bcpXlg7z5GK9Sol7uU4hD94jlVZEo1ioLN7pbcCN6Ys4tVnSGErCON0yQ4vzlt0DMzW2nNjScjpmc8WYo9hUIIPmhOmtXB6RVLkizUnbiOJuzI545x3VItYHVmJdOypwum0bOGFzqWCFnqpwlVTuIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdNjt9Mroz+49rFhsCs7mW7WM5XylsYGqQNA0ZG0VWk=;
 b=YTNkNTpiCrDXmjNFKvOBpo+Bl3+kTGy56SBZAvvI3kj4oEfr/2z6YZuXeHoqo3BWfgdJT/gMK1SdWET/oVR7qJPz9oI7gVZMa5ngsUKsL4AXo+Zu8H31a4ruuktqn1glkOaoDSQSGwVTw8lUIz021jnTBA1+7d5MgXH99tHrLJF+Kb3cORc48snYmiMhXVB4f87S7/GNNJ87AOzabfF5Y8snT6lwMo0HG6Caz2mvkDOcvMmXqQ50hFH+q0Il3BIcayLtwnt7ditrF7vk2GlWnu6RcLsvth6msyDOT6Mxb0BxfGKfFFBmGB6FdhU2UuS8HbOVMDL+Sa0YrjNiO/YNKQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB7707.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Fri, 20 Mar
 2026 17:09:18 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 17:09:18 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH 6.18.y] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcuEfDaI8i1D32akiLbFfObzRjGLW3pnuAgAABhto=
Date: Fri, 20 Mar 2026 17:09:18 +0000
Message-ID:
 <MAUPR01MB11546AEFCA1DDC192B4474D62B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <2026032051-flogging-glade-d6d9@gregkh>
 <20260320085841.1407-1-gargaditya08@live.com>
 <2026032041-scanner-appealing-996c@gregkh>
In-Reply-To: <2026032041-scanner-appealing-996c@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MA0PR01MB7707:EE_
x-ms-office365-filtering-correlation-id: d784eee1-9738-4e69-695a-08de86a36be6
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|19110799012|8062599012|8060799015|51005399006|14091999006|41001999006|31061999003|15080799012|461199028|25031999004|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1hFTEwzb1EwZHdBSHZVelVXd2VoTG5WcHN2VUd3eUhqZkhuUFY1eDl4Qzhv?=
 =?utf-8?B?WDdQWk91emlKVGhuVFFuRWNCUGxzNXhDVEIzL1FqNW8vNkdpUXd3WEtxTmRn?=
 =?utf-8?B?NDVtZU1ycE5JMEtFejZzTi9vZXB5SXRYYWVwMG5sSTIzY3hPaHJSTXI0MTNL?=
 =?utf-8?B?ek1hWmZlNHVPQUZFZHFMVFQzdUErVFdkSHdLZlpXNGtESmFOY2paY09XUml6?=
 =?utf-8?B?NGlwVXVQSTJpMFkrRVl1ZTVpd3ZBaHNpc3o3emhCM1llRUVrTHJZUUNxamZ6?=
 =?utf-8?B?TDRhV1dPL2ZDRUxMRllCN3ZENHk1R2NmK2VQSnN0RnJteVdaRkhRMWpJV0Fk?=
 =?utf-8?B?aFg4UkNBNG44c21VNFhWRHFtdjJHYUxSZXYzTWNwZUVEWjZPaDM0OWtqK2xL?=
 =?utf-8?B?SVpRaXdobStiODJHVnhvVmFPQ2NURkdJamx5NDNvSU9WQjBGck1lN29ITWg5?=
 =?utf-8?B?cDBvaWxLU29JYTZ1VlRvdnpIcE84Yk40R2RGVkEyVGtsaWs0M1o3SFJXa3g5?=
 =?utf-8?B?YTkzZlJrUEp2Tmh5eFY4dnFGN2l1WHhwd2RSM09JMEEreVZ4QThqTm1SbklG?=
 =?utf-8?B?Y0hRdUJheVpibHNJdHlmTE51RkR4NDV1cllQQ0JyUEwwTU1PeXNDSW92RjJO?=
 =?utf-8?B?ZDlwbDdzWWpuN0dhQTdEYlE1cDFYdXpmYkxsVXBaeEc2R2tZVjEvZ3NacXg2?=
 =?utf-8?B?QjMzVmtBeGlJYTlKbHk1TndydFJXQ3hrSzV4N3MvM0RjeWs1V3dqeDg4cTJD?=
 =?utf-8?B?aTFDNkZaRUdONGV3aXNBVThOM25GbUxmcXJPeHhva0ZDakE2em5Fd1djRWZv?=
 =?utf-8?B?bmxnODdXUmRmMmZ1ekd6NWd2N2tFWkNsVk5PazdXWTc5RUJEZUxsSHhUYXVX?=
 =?utf-8?B?TjJpdlRKejZHNUxERCtnMmx1RFJUVXhmR3VpbFUrb0dGTFhrMldVNHNpdTFy?=
 =?utf-8?B?aXVMYjlhcEJOaGVQRjRIdzlMTnpMSzRSaU13dk9HcytzakVOdk5DMkVmVWUy?=
 =?utf-8?B?cjBxajM1TjFlZlBaMjV3bUVONHBaM1VGZmp4d3pFaDQzdzMwdzhtQStPNkhZ?=
 =?utf-8?B?dXdERXNJS3E4VjBhWGtpNHNhai9jYmNPSFpxU09JRnBFaFNMd1J5NXZNU0VE?=
 =?utf-8?B?Zlc4OUsvWFhyOWNzWkRyUXcvN1BwSDRmcDhIcWFRR2w0Zm5aQ1l0c2dNZUxJ?=
 =?utf-8?B?SVhnWWZhZXBGVkJ3aEl0eWV4SllPMjl1bEs5SE9YNHNPRTN1di9BMzZobHBa?=
 =?utf-8?B?N055bm81WU9nRURCZ1hzN0hqZG9tTE9lWU1QT2R5NjFRRXFTb1IwTGQ4RDVo?=
 =?utf-8?B?a3ZOb0c3cGRrVWp3NXNMSXNYcDVabjhhV2ozTnJYbGZqSzJGN2kzbk51aWpi?=
 =?utf-8?Q?NCkxKRVbheWY7f67m7RtPi2j7nr1t4po=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3JZQnNFU0pJU1E5a1VoYjRvQzM3YWRSZnI1cUk1akJOUTJuRjZLdzcreEZ5?=
 =?utf-8?B?Y3A0VVhNVmNqK2dBZDBtelFDUm5RWFBuY3p1bXpuckF1QWFXVTZSWkVNd2pV?=
 =?utf-8?B?WHU1OWs2Uk1RSDNDKzM4TVNsTCsrRzdHeW5WSE9Kam5sVkNVVzh0OUV3Umxw?=
 =?utf-8?B?VWREV2l3bW10YnpkTythS3hJNjR5eVloYXA2QS8zdDFHY1cvYWNhUFVrdDhu?=
 =?utf-8?B?cWpYMFp6UVltOGNuTTZORW5VZzdwM3M4eDlxWkNCa2s4ZFJhWTFmdjhhWmRE?=
 =?utf-8?B?TEhoU2NhRjdnOUpyQkZ3SDh0cHZFMTJsZlR2M2c1QTVrcVl5V1NjWDM3WjBo?=
 =?utf-8?B?cmt2TkMyYkxreWRpOTNVejNKd1pYL0VnVzVjWUFzZWIxbWRFSWdGdXQxRVdt?=
 =?utf-8?B?SDdHRjRUL0xxd25EWFR2SjdySHpsRWFLSmR5UTRZeUlhak1MNTZSM1FUNlg5?=
 =?utf-8?B?QUZoZDc4WHBJMG0waFVZR3pwQXh3V2kyTmE4TmQzNURFL2U1RGV5Mm9SdUNo?=
 =?utf-8?B?a2hDR2Z6ZjFkOFk5bUtheGIwclRTU21ha25lVkhDZExaMCtTUVgxR25BUk1E?=
 =?utf-8?B?WmZHVEtyM3g2Zy9XY3R3WU0xeFZlUXNheW5WWFB4U0xNOTNqTWk2c3g1OS9S?=
 =?utf-8?B?U0Q2YXZCWWNTRFBrUy9tOWNmSm9yWDVjb3dQUEJWWEdHSjArM2hpdlJGZ1g1?=
 =?utf-8?B?aHU5RzZMcVRNU1J3aUYxaEZHVk03UTRzSWRjaG0zVVIxNksyYjFYdjVnNTZH?=
 =?utf-8?B?RWRaTHdnajR0V3pUbUZoUVo3cUIva0lDNXlWRnR0NGtueEQ2a3Btc3Z2UkZx?=
 =?utf-8?B?T0FwK1JvT2NacVoxSGd2dm9XRmxaUjFDeitWTCt1T0piTUVWUzlKQnRqdDUx?=
 =?utf-8?B?bnpmdVFXZ25CYmlUVWo3Rk0raE9DNWRxbXIrelFBTkRWdExMZDVCUG9Ucmxw?=
 =?utf-8?B?Ynp3T1FVbWtQS2hTWkVpVEkydVBrVHU2Sm81RU00WnJVaytBbVpMR1BXcUZl?=
 =?utf-8?B?NWIvWFgzMzJqQUgzaTBsWGpYV0tzdGYyb2tKWTZ5Ti9BUEV1VGdpV2VweVJj?=
 =?utf-8?B?Zm1UVnpLSGJUbDZyWWQ2OHlLZ1FCcm5XUGtRbjhDTmhRTjRTdjBueXVuWWdF?=
 =?utf-8?B?Zlo4eFgrc1h3WEpnNittUHROWFpCbjZYOFRpUXRjNnBBWHRvYUZaRkJZSEpo?=
 =?utf-8?B?a0tRdHh3dXpHT3pEMVVOQTJpOHRtaXo1SGZhRzlhV0YxWkxCRVlWZ3VOOTQz?=
 =?utf-8?B?Mnpscy9vYmlMZHhOZ2ptYUxRejZiUHlkNFJjVTUvczVLK29NK3ArQ2doc1Nw?=
 =?utf-8?B?RUF3Wm5EL3BzaVhuTktJdGJBOFl0ZFlCaWIyeWRtRnFBMWx3MEJiS2xJNzA1?=
 =?utf-8?B?V1VDZnlQcFpwRzdwMUhFYnhVNUdnSlBnMEp4S0JOMGE1N3FCUnJEWWI0OUJv?=
 =?utf-8?B?aVFVU3F5U2hSTVJwVGZwSVRwY3RNTFNONUZESEt4VnhiK1Z5VVhwcWtLUWRM?=
 =?utf-8?B?dmVIczF1N2dxMTAyV2hGMHBiUlU5a1ZWUDJETjFpNGdoTTVDY01LYWUxTmdu?=
 =?utf-8?B?dDB6Y3NSbXhvUkhmeE8xd25oNDJ4ZHpIQVRkakQ2Z1EwdEk1WEk1bTNKQ3o1?=
 =?utf-8?B?eTl2QitMd2RlRXdIUW54aXhxTCt0amVtQ1VsKzZWcUtQYmlRSWZFUmZTdXk1?=
 =?utf-8?B?b3FOanJaYjgvWEl4ZHJBT0tkZFpGQ1pnS1JlMTk0OVNWcWtGWjh4L1B4a3d0?=
 =?utf-8?B?WHc3eDE5M2ZKL0xSbmxVSTJ6MWhkRjJENm9VcmVsVGNOb21iR1k4VXdhTWdw?=
 =?utf-8?B?eFNYS2MvdkhUMkE0aTc2RUd3WU1YaU1qelRGSXlaRFNQckVkZExNSk5iZWhC?=
 =?utf-8?B?bVFCM3F4YnBCOGMvSjlmUW13ZjNaQVlXRHNidlN1d0VSM0tzSEFXTFFtdGpu?=
 =?utf-8?Q?A57MGdXX1Nqyor5Je2c/JW7FwH+EU+Eh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d784eee1-9738-4e69-695a-08de86a36be6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:09:18.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7707
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227578-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[live.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:dkim,live.com:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 4703C2DE64F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMjAgTWFyIDIwMjYsIGF0IDEwOjM04oCvUE0sIEdyZWcgS0ggPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIEZyaSwgTWFyIDIwLCAyMDI2IGF0
IDA4OjU4OjQ3QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gVXBvbiByZXN1bWluZyBm
cm9tIHN1c3BlbmQsIHRoZSBUb3VjaCBCYXIgZHJpdmVyIHdhcyBtaXNzaW5nIGEgcmVzdW1lDQo+
PiBtZXRob2QgaW4gb3JkZXIgdG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgbW9kZSB0aGUgVG91Y2gg
QmFyIHdhcyBvbiBiZWZvcmUNCj4+IHN1c3BlbmRpbmcuIEl0IGlzIHRoZSBzYW1lIGFzIHRoZSBy
ZXNldF9yZXN1bWUgbWV0aG9kLg0KPj4gDQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
Pj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4+
IC0tLQ0KPj4gZHJpdmVycy9oaWQvaGlkLWFwcGxldGIta2JkLmMgfCA1ICsrKy0tDQo+PiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWFwcGxldGIta2JkLmMgYi9kcml2ZXJzL2hpZC9oaWQt
YXBwbGV0Yi1rYmQuYw0KPj4gaW5kZXggYjAwNjg3ZTY3Li4wYjEwY2ZmNDYgMTAwNjQ0DQo+PiAt
LS0gYS9kcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQuYw0KPj4gKysrIGIvZHJpdmVycy9oaWQv
aGlkLWFwcGxldGIta2JkLmMNCj4+IEBAIC00NzcsNyArNDc3LDcgQEAgc3RhdGljIGludCBhcHBs
ZXRiX2tiZF9zdXNwZW5kKHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCBwbV9tZXNzYWdlX3QgbXNn
KQ0KPj4gICAgcmV0dXJuIDA7DQo+PiB9DQo+PiANCj4+IC1zdGF0aWMgaW50IGFwcGxldGJfa2Jk
X3Jlc2V0X3Jlc3VtZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+ICtzdGF0aWMgaW50IGFw
cGxldGJfa2JkX3Jlc3VtZShzdHJ1Y3QgaGlkX2RldmljZSAqaGRldikNCj4+IHsNCj4+ICAgIHN0
cnVjdCBhcHBsZXRiX2tiZCAqa2JkID0gaGlkX2dldF9kcnZkYXRhKGhkZXYpOw0KPj4gDQo+PiBA
QCAtNTAzLDcgKzUwMyw4IEBAIHN0YXRpYyBzdHJ1Y3QgaGlkX2RyaXZlciBhcHBsZXRiX2tiZF9o
aWRfZHJpdmVyID0gew0KPj4gICAgLmlucHV0X2NvbmZpZ3VyZWQgPSBhcHBsZXRiX2tiZF9pbnB1
dF9jb25maWd1cmVkLA0KPj4gI2lmZGVmIENPTkZJR19QTQ0KPj4gICAgLnN1c3BlbmQgPSBhcHBs
ZXRiX2tiZF9zdXNwZW5kLA0KPj4gLSAgICAucmVzZXRfcmVzdW1lID0gYXBwbGV0Yl9rYmRfcmVz
ZXRfcmVzdW1lLA0KPj4gKyAgICAucmVzdW1lID0gYXBwbGV0Yl9rYmRfcmVzdW1lLA0KPj4gKyAg
ICAucmVzZXRfcmVzdW1lID0gYXBwbGV0Yl9rYmRfcmVzdW1lLA0KPj4gI2VuZGlmDQo+PiAgICAu
ZHJpdmVyLmRldl9ncm91cHMgPSBhcHBsZXRiX2tiZF9ncm91cHMsDQo+PiB9Ow0KPj4gLS0NCj4+
IDIuNTIuMA0KPj4gDQo+PiANCj4gDQo+IFdoYXQgaXMgdGhlIGdpdCBpZCBvZiB0aGlzIGNoYW5n
ZT8NCg0KVXBzdHJlYW0gY29tbWl0IDE5NjU0NDVlMTNjMDliNzk5MzJjYTgxNTQ5NzdiNDQwOGNi
OTYxMGMgaWYgdGhhdCdzIHdoYXQgeW91IG1lYW50Lg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3Jl
ZyBrLWgNCg==


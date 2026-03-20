Return-Path: <stable+bounces-227583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLLxCl6CvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:22:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E552DE86E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8104304AAE1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA13A5425;
	Fri, 20 Mar 2026 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pvzWdCrM"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F227372692
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027025; cv=fail; b=ZEn2Ztac4Y548n55M5G2Q4cGY65vTSx3LMv3aG1pEy9HlMJj5sSRpQnKHvyEZL8GkPYWjsmtkSlk1ItMw9gXHB7w1tFAAa8w2ahyF+l8tmlsxT3rneyDjYPjAsMnkPxSTOtUSugpvPbc5bsXsrGkgm6nsoYlVNvejs5xJLPkt8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027025; c=relaxed/simple;
	bh=9h4ZpBfWQ8493Hj6Y4oo3LbiIQdAxuMbLRlyvp/WXxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ic4lNG4YONGf1ZqpX/NnGm89eo/6kl7dbVS1NR1Pw+Hd6R6IXr9dskRAHSsgaNv0Lgcwx3C+akNkAX/BGQkB0mTSbHrh1JH27KxW49SX+pOdb3GOSeKzpg98eIRQxQZkk3sInNRJ060zqwJwJgk5qHxTh5RWavtvHM7+oympjr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pvzWdCrM; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGh+JI7QIULvZ9qeiVbsNM6RONsVacJV5YhgQByrpaLi8sIt6cH63Oq3gCMBOKvAbEA917wjQtdwRc56LflGtuAQQ7t0dcVFpHPaXXEXOWtnt2ihpS22YqiEJ88AFG5b4tr8TC4f0wq7uldh8RxInjQP8KMV5uFvM1aiGyk2lG5kGXfLRdHl3GGnR/qDg/G9U0lg+u08+OFm6QPgxHDA7P1aZTWgfJhfasc5atUDn2dazEMcfCOALIlhjy04ID17+fCgt/l2u9j/uCIRwCGl3VYVKLRJDlamS2cDzTskgyd3WHbxBGU49WGJH9mxDRpRTOCNzFh2nosu8w8qPW2lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h4ZpBfWQ8493Hj6Y4oo3LbiIQdAxuMbLRlyvp/WXxM=;
 b=xT4lrM3t68TB0K2I1K29VebYy/VJ+wpTogIW2UrhNaDQ9QgfRzhYaSrOvSa68Fw7l3qzKWDKiOwZ4sJX7oWryrvsaG/SvjR/922/RrzV426vzvIjdkJtR2jtOABkxtCAFQwSHAn3Zxfd9LWvHMUwuvjxcK/vB9c8UVoaBJKGK46lom7Zf75d4P/P8IWPTthxtdj+V1vz3xJutyXy/xc7xF9pUltXASS28o9kHa8v9qHg0N5T60RaCf3dh52aOIb9OludM7JxoocEOK45T2c3ApMgUDe0TJV++zxmtE3sHBEDrYx6JMuU2I8Md+/1kAwX5Zqv6vBzqagaW+MSqi/3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h4ZpBfWQ8493Hj6Y4oo3LbiIQdAxuMbLRlyvp/WXxM=;
 b=pvzWdCrMz2VdjJVVhKxXD3hffo3qgZGuHtVnd8fML13oUi+CnORzsn/jtjCohxRKpCtm8TQrYbdWcGPkn6M577TeTfU8yRtLiKOWmr1CGJr7Pfi3hp3o4GVSERDtXwq+xxNSD1a1b9h6O/6Rqj63/jMulAsKIDYNtHHsJuZxuSjA/crMTPwQLruJGRlPAqkIBGmdzdtjQmQj979nNVpMYURbG5OCVQcMUje1RjNT250Um407y1xDsroMzXtITOtY+0HFOCb1iGIYvr2H2Hr396q58W5AlG8GOPwGtgC7FwL4QiiFR3e2sNljhvpflIc1koj9n+fiNuKuicuXGabzsQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA0PR01MB7132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:34::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Fri, 20 Mar
 2026 17:17:00 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 17:17:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "jkosina@suse.com" <jkosina@suse.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] HID: appletb-kbd: add .resume method in
 PM" failed to apply to 6.12-stable tree
Thread-Index: AQHcuEZFMnHMxcnPH0iDBnLXjcuWY7W3H7WYgAADzYCAAADL3YAAhOSAgAAA+04=
Date: Fri, 20 Mar 2026 17:17:00 +0000
Message-ID:
 <MAUPR01MB11546D3BF5B8AE4715111B467B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <2026032053-reviver-stock-9da2@gregkh>
 <MAUPR01MB1154696DABA7DD9EE0D6E99D3B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032039-rosy-playmate-f405@gregkh>
 <MAUPR01MB11546A98F8C38646ECEC2FD77B84CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <2026032013-eggbeater-glamour-d06b@gregkh>
In-Reply-To: <2026032013-eggbeater-glamour-d06b@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|MA0PR01MB7132:EE_
x-ms-office365-filtering-correlation-id: 80c92a54-9a81-41d7-5169-08de86a47f7c
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|51005399006|461199028|8062599012|8060799015|19110799012|14091999006|15080799012|25031999004|31061999003|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3ZSZjNrdldDYUJjZ3VsNFpvRG54Tk1tbytucUdaSXFuY2htQ00vVmxxMXJq?=
 =?utf-8?B?NStWdk0wL2tFb29zcWgxNUlFZ3VwM3ZVVTVITjJNU1ZwdXdUWFAzNzB5RHdN?=
 =?utf-8?B?ZDl4MnNpL3ExOVRlY0dEMEkrbEd4d0FIcms5TlhFNlByQS9FbmR2S1JjYjRP?=
 =?utf-8?B?SUJxQkRvd01qM0xMU1h6K3pZSWtLMDlacFd6K29BTTJXN3NIdEMwM3NPT3Nh?=
 =?utf-8?B?Y2dlRGVrYkRWUGVoQjJhRVpBWmV4MFRkbXRES1ZRSzJQeSttV2k3REtmYlpt?=
 =?utf-8?B?M2ZLR2FuTjFmbkw1ZFA2ODRPMEdpNEdmMzJFUytwMCtvVlRFRWgyK3BkVHYz?=
 =?utf-8?B?RzlTS2RSZUgwelhTakFOd3pZTDZQb21GbTUvMFFSY1VPY01uNDMyMDN5dFps?=
 =?utf-8?B?Y284RVFjb25NMGdjb3RKeHp4blFWRmU5d3hid2VYdExxU2pwNXBUaUhUTHJi?=
 =?utf-8?B?Q0wyekhESWtISDdjaGs1Vjl0RVlkUkZKdmxSRWp5QklBU0t2bUtrRUs3Z1g5?=
 =?utf-8?B?U1h6dE9PeDdYdHRSbis1NWlKLzU1bGlLZyt5U01BSlBhOStON0pZd2U0UHNZ?=
 =?utf-8?B?MjRiRnFOZ3d3WEovNm5OQUZnTzNpcE42aUJPK2NXQjV2ekRTWWpBN0EzMVg2?=
 =?utf-8?B?cXlJbEZtREpLT1UrdythRUZIeTAyVmdKRGUvOWcwNnZwYzJmV2xvOTVYUGpG?=
 =?utf-8?B?MDJHRUdoT0VUOGQxSmxnbjdVdlB0TGNHYXFpRUdPL1pyVTlFemVpSm9VZWxw?=
 =?utf-8?B?RGhaQTdmS3NWbnFkcEJYRUpOMlV1U2RvMEhuL2h1ZmlDZFdoMHpvWnVMdjJw?=
 =?utf-8?B?SmtnOGlrcnhSUXJ4QnhQc2ZURTIxWGRrZjd6b3RzbHRTOEZteXMvQWE0VFVo?=
 =?utf-8?B?YUxMRldCV2kyYm43WXJHWFhwUGNtUHJzV3N2WEVyZ01lVElIVVNRUlV1b0Fx?=
 =?utf-8?B?ODl2RXF1ak9ROW16ekgvMjY3U2Q2U1FLek12bEFwaWJPM3BFNHIwVWsraUNW?=
 =?utf-8?B?bVBnR2FVZHdxK1B3Ujc0UUNTWXhNYmkzRnhWdmJEQWFFVHFMQ2NwaW5WWHNY?=
 =?utf-8?B?dTFENGlNMk1rK09KQ0IwaE5OQU1ZRGpWWnphdzA0L1dCL1MxRnUxMExBTnor?=
 =?utf-8?B?TzREb0h1OXJYM1MzV3ZWaVREeW5rS2xsQWlQQlgzUGF6NWNwcjg5aTQ0TUNz?=
 =?utf-8?B?ZXY3cXUrSnBiVHZmUjVuOXFxM245RW1SQ2tYejJMRUtaOE5nNExQQkhzaG55?=
 =?utf-8?B?bVRQQUV2aDRLZG1uWjJLSFg0NmhId2JDOE1TaktIMmNGc2ZnbERseUtKcUs5?=
 =?utf-8?Q?KER2N4H/cRUVtJvua95t1wGHrGEHYAzrNV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWYzMk05a2dEc2NwNHU5M0FMSy9qeU5yNlYrakhZUC91VENYdEh5MVVxb1Yw?=
 =?utf-8?B?ZEJVODhwZlNZcjJ4aUZSNExqbmkwTzlia0NNbEZwNjhpRmo2WC9UWjBxQVFW?=
 =?utf-8?B?SUJTL2c3ejdxSHMzQTU4YVFwR1FGK2R1ZnhDN2dOTGwxVEF2TE9Od2tVY0Vr?=
 =?utf-8?B?YzAwWTFjUHBQTURFbXRzZFNiL2l5SklSVzE5RVYrQUQxS0pRd1Q0dEJhVjZQ?=
 =?utf-8?B?SVlnaTFLU1cxaWFGR2twUHhuanNWQ2o2RzJxZndXQ1ZmcDNwam5YdWFLamtD?=
 =?utf-8?B?dWhCZ0lnZDYvd2VxYisxUzhndmR0T2M4WHBXRnJwVExQTVpvTUtsNEtVTUxX?=
 =?utf-8?B?M0FIZ1pWMGEyQUZnQyswN2dBOWE5S2JPR2xyTUFKYkZYMjc5QldVNWw5Wjg5?=
 =?utf-8?B?MGJqSU5nYWFMWFdGYlZMZ0IxSmVneS96dldMY1NEMmI2dzVYK1NzeGVjVytW?=
 =?utf-8?B?VDNnVFRWc0dSV0J4dVYwY0F1akNNTDZpVnNmK3BYNDh3SE9BdFhlTkFHR1pi?=
 =?utf-8?B?M1dvdktCRjkybDVxY284T2ZyamVXcU1JRDhFdWpqMk02aE00bE1UdFNtM3Jm?=
 =?utf-8?B?ZWRXa0xZWVp4UWFBV2Z5OGh6dFJRdTdqUmlOY0Y3dWZ0bWpaZEhTd1FJeXd4?=
 =?utf-8?B?NEZXVFlnd1VjajljSEFmcW51UTc5eEYwVlRVdkpVWitsK3R6aUVpS0VjRWJh?=
 =?utf-8?B?eU5QMkkyVjFsczcwNE4wZkord3p0TVBwemV3UDNydFR2YVBScVZOMHAzSFJX?=
 =?utf-8?B?bkl4WVZtN1E5dkUxSFpGWEE4SWlhQ0RmTmhobE42SmJJV2ZFNEJNUjBsbksx?=
 =?utf-8?B?LzU5d3hPa0l4dDJ5ZDB2OC92QnF0dHVZdHBjN05DMUVBeWNZRmlVYkFVaUJS?=
 =?utf-8?B?dXVIaVRHVHYwR2dLVWRFS1pCYnFvSHBWeGQ5NEd2Q0M3K3UzdC9RRXhrWVd3?=
 =?utf-8?B?L1hUSkNTY013UXgrY1hPc2ZVMDhNOHhQSFZBOFhXc2J2L21waGF3TWJiU1Aw?=
 =?utf-8?B?R25rT0VMMnZhSkt6a3FJcGg3Z1dDK3VLVExycXlIM3N3cVJ1RXUxWjNDcG11?=
 =?utf-8?B?clVCUHgvWHdvVU5HUHY2WUlkWDZQVHBSbU51Q2lIWGFHbUUxM0t6TmRrd2tL?=
 =?utf-8?B?cWF5elM4elZIbVhpRGpMUkt5WkFTNHd6UDh2aktTdmJNUEx6NHZJeGdvM2Jm?=
 =?utf-8?B?aGZFRzQ0ZEM5ajhwNXJ2QWdEdGlRa0hZblNkRXdpZmRKNUtjUFlKQzQ0bmMy?=
 =?utf-8?B?dUFrQTQrY1l3ZE9TVDFBazEyL2Y1cVltd2xtYVduVVRIZmV3c2xyZzdkanRn?=
 =?utf-8?B?TU4walFrRVdUTnhKWERtSFdYSlY3c3dmc1E0UkwxTW1IQWYyakZvTHFFcXlB?=
 =?utf-8?B?ZEZBM1haLzRJOWkya0s0dHhnSklBbkcwQ2xmOWp4L2VHNGROWVFpditSdmZ3?=
 =?utf-8?B?K1IydkNwakp3bVNEQ2pGNVJjRy9XS3pXaG9FR1JMNFhmcEhYM01yaGNwSzQ5?=
 =?utf-8?B?QStwVVFaWWVIOFVyT3RVQTBCZ3U0TWZUajZWYVNCMzVsQU9YSzd5eDFwVDQw?=
 =?utf-8?B?ZnYvUGplZG1oYmpReVFSQjNKVm0yMy9ZK1hqKzhKZmpNN3lqSklXcWV6enNi?=
 =?utf-8?B?N1NhMG45NStjSGhxQkZneFp6WlhEakd5Z1cydURFUTBpb1drS096SCt2Q3d1?=
 =?utf-8?B?MUFBTmplUDAweTM2c0JteGdRTS9VbUlIdDBKWW5QVVN3VlF1VkZoUkt1bThD?=
 =?utf-8?B?VkZyU3RMTlZvbk90WUZtYkxkZ3hjQWhUTjZWR0RZYy8zbDg5K0FRZmdvNXE4?=
 =?utf-8?B?TjJKbVVPQ3ZjcWNkbDFGbUVSbDVTTDBqVkI0L3JFcHZ2YWNJKzFtTWFmZkhC?=
 =?utf-8?B?SmIvYTQ0OWx5UTdIZzVMMnFRNmJWUmRhaVd0aWdVUlp3cGhtVXVUUzI3OTVw?=
 =?utf-8?Q?/5r9aqQz1YEBVwqs26UwCJRYpsHwKc5T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c92a54-9a81-41d7-5169-08de86a47f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:17:00.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7132
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-227583-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[live.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[live.com:+];
	NEURAL_HAM(-0.00)[-0.891];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 85E552DE86E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMjAgTWFyIDIwMjYsIGF0IDEwOjQz4oCvUE0sIGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnIHdyb3RlOg0KPiANCj4g77u/T24gRnJpLCBNYXIgMjAsIDIwMjYgYXQgMDk6MTc6NTJB
TSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiANCj4+IA0KPj4+PiBPbiAyMCBNYXIgMjAy
NiwgYXQgMjo0NeKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiAN
Cj4+PiDvu79PbiBGcmksIE1hciAyMCwgMjAyNiBhdCAwOTowMToyN0FNICswMDAwLCBBZGl0eWEg
R2FyZyB3cm90ZToNCj4+Pj4gVGhlIGRyaXZlciBkb2Vzbid0IGV4aXN0IGZvciBrZXJuZWxzIGJl
Zm9yZSA2LjE1IHNvIGl0J3Mgbm90IG5lZWRlZCB0aGVyZS4NCj4+PiANCj4+PiBUaGFua3MgZm9y
IGxldHRpbmcgdXMga25vdywgYnV0IGJhY2twb3J0cyBmb3IgbmV3ZXIga2VybmVscyB3b3VsZCBi
ZQ0KPj4+IGFwcHJlY2lhdGVkIDopDQo+PiANCj4+IEkgaGF2ZSBhbHJlYWR5IHNlbnQgdGhlbSB0
byB0aGUgbWFpbGluZyBsaXN0IHVzaW5nIHRoZSBnaXQgc2VuZC1lbWFpbCBjb21tYW5kIG1lbnRp
b25lZCBpbiB0aGUgZW1haWwgaXRzZWxmIDopDQo+IA0KPiBJIHRoaW5rIHlvdSBmb3Jnb3QgYSBz
dGVwIHRoYXQgYWRkZWQgdGhlIGdpdCBpZCB0byB0aGUgY2hhbmdlbG9nIGFyZWEgOigNCg0KU2hv
dWxkIEkgcmVzZW5kIHRoZSBwYXRjaCB3aXRoIHRoZSBnaXQgaWQ/


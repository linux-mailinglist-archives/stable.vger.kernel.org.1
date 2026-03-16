Return-Path: <stable+bounces-225533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLMJIpf2t2mfXQEAu9opvQ
	(envelope-from <stable+bounces-225533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:24:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E096B29971B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5AD302E316
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1010393DC8;
	Mon, 16 Mar 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KwROChKV"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487B234CFA1;
	Mon, 16 Mar 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663677; cv=fail; b=X6OcuNNjBq22yBA3hmEH56ssU624SsKs77m49KI+k72Xbfl5kzJ+w66lbB4oCgkcLfZId1xyG5cERVgtnuwCjDOfBQwMqP3njXlFAW1eei27eeuh8m6SEk4vo3tLFNztQW5YK8qvGETdeq1Mfz7Kz/5zp8ORROv09yZntI61fF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663677; c=relaxed/simple;
	bh=sD3Q89Uo66rZL2UzVAXaJWa7cuizfAUNzoBq0twwPQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FdlT2SbOfjiJl02gr4f6P6GOOaNYxK4fIsfkKH9/pSbIoRw2cpv0qLCj90AOBk4FHSUD1uUraw5g38USQlpMYb/VAaRz9r87u6jQFzgb2cTMLj5aKnFYrZqJNaOrpoWXx+6ASuU4hwDWoO4DfFpa/Wfu4acANNACzmijhPB03i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KwROChKV; arc=fail smtp.client-ip=40.93.195.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+MQPxHHzrrdO3iNmicgS9hAIFRjrmLnQ/G/WmXrqOhgWWfdYUG1CkHLroE2qFRDgjxIZEdKM1xVa3V+oYFUArrwmyzfd1rUdUsQ0r4dnovvw3imbNIjzDNUNB5Muc8br2FJivebpflTQtKlUYgdvG7+8TRzENq4ygo8R3MGp1MrtHahv2BScIYJIPZkDjUtEV2mM9eJwzPQk+DdvKk2Ezz44fUufEOsx8wlnYZ2AhsX4YV79oI4nBdCHZUXChqVrjmc7sZUCbdReBbr3FfKVpTjfS1CF6gHH8zg6ovdyhkvVDmvpDO2/B6ptdS8BhTQE1nC94+ITSg5ZupZ41ll9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD3Q89Uo66rZL2UzVAXaJWa7cuizfAUNzoBq0twwPQ8=;
 b=mtkKYSJ2cA/ykGP696FyjuG3Y5SBWu86071uIq8lsZk0AkEYf8Ney//4xorXJ+e6F2xeVYAkTMz/EDAKxTO5BqB1J9/REvCtU8yJnJcYO4Ncaoe4XQsxEIhtEvGHJy7XvqvAzNq/ouu1ZZPlLfk23pgiHlbIOl2cEqUUBSofekwTsgUzUgMXOP4nzYNh23A+zxb31JhPe2NMIoLZHbQIxEZiIlCXs35Yzo4wULpXQZglE62i82bBh5QO/zIRqesiyZsN8tDtTaWi3eWyc1gjv50B610YjvVyKUCkyAyJWWGgNODfIvnqzYd2dKKhe52xUgUU/FNYLDId4dmDc3aahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD3Q89Uo66rZL2UzVAXaJWa7cuizfAUNzoBq0twwPQ8=;
 b=KwROChKVxRlIPHOdsTKX3xTkixloX+0Qv1K7s45c/dUIaNefQoUB6zo1F5iyu2EAnIyC8h7p1o0Ms8J3703TYzz4fPZiMzXgtjUyjNl4ZsFC1BFNF8BM6yQTdAjxZZbEu4jwzjmO0X/YUDNLHz8NgyW9mRIdOQKCNWR8LwtUPUk=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 12:21:12 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 12:21:12 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Junrui Luo <moonafterrain@outlook.com>, "Markus.Elfring@web.de"
	<Markus.Elfring@web.de>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Topic: [PATCH] drm/amdgpu/userq: fix memory leak in MQD creation error
 paths
Thread-Index: AQHcs8hNugauCCvVHUGPs5pxhSEgSrWwgedAgABww4CAACCHkA==
Date: Mon, 16 Mar 2026 12:21:11 +0000
Message-ID:
 <PH7PR12MB600031D610E93F9ACB7CF87FFB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
References:
 <SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <PH7PR12MB6000A8C0694949AA83702AE2FB40A@PH7PR12MB6000.namprd12.prod.outlook.com>
 <F21AC290-0B53-40AF-A0A0-0647B86AD2C3@outlook.com>
In-Reply-To: <F21AC290-0B53-40AF-A0A0-0647B86AD2C3@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-16T12:06:59.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SJ2PR12MB9211:EE_
x-ms-office365-filtering-correlation-id: 03505160-974f-4987-3c69-08de835682d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 Hlbi6Q+Mw7dZ3dWjhliUeAoBk9zHfYW+U/ctZv5XqE3dT9jW4BpGyvBlOM6Iscw6tiO2g5n/eCL8uIjdXotCPuV3b3n31cywqun0NMlQl6cK2Y6nHTWADVEwHlKgLqGiR+fes5hWpYcbB5otFrIf9lycm9NuRenEZEPiUPIEOnaVu1K4qZW2dFwWFhkjDX6SsDdOboSdDFxeUoJR1uxGmJ2Ffb8Tud4Cru8YI2ZlrkVP0ESu3onSoTQaRT0XLJCMxwEafLQLVMKZnrFde+LDykstDltzh6M16/63iInS2S49YJf7Tnzp5iZvoKhv+fTefEVxVkqq/EsnTVvSCRtRgHq+n8OK/NzpLeCM3jr40FV1a0XPwdeg82wtjp+DAa0DnKw8VclDBlvqc9vLDzSne/PUJUMKQNPQ+s4DUn5QoFbm7Wwov79c2j0YKhuXkB1d4TJ+Z685cX9R01d9hDgcKq/zKkig2BlDGFAzmeCfwJLv27t1inNAoqaxHonecOJauIj04Mkpt5b7oJwulNPk/uQEU8J95u82RlfI0183DlSwVDRFjPO0wMDvMBbZ7PHeakb9ItKVaGWdmzqXKdVA0J7K3yCCEEMKjbBBA1SOhwWAQ3nGXWuB2EjNBliqzNcUke3Wse9jVRAUlYr5f/dPykJAnfB/n+0lvgExATLB7Ht0tlagie8WrJ5erBvuI5hfgGlK+fgX5v3agZeFEjDwpj2W/rTnq9IA4jOzsJhdwY9VJNZTcM6aG7GCKeKUSXyhe3VWw46e43OdSavz1WzFoNOqtc5/Wnhvpd/40JL3JzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6000.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFJxRHlXUVB6cWtSaHdieHhZbDl1MkFMVGhNMUZJVmFCdXNnSjNPTHBkeVZR?=
 =?utf-8?B?ejhBTVJRTFJQdE9qYkg3R3JzNk1nZVdaRG51WnNOemVPRTByWjlyNWt1cnlv?=
 =?utf-8?B?OGtLMnh3OGI4dGtoY3lqdnNwaWtCamFYRGY5TXVvY2dOdmx2Z0N6R3hKdWth?=
 =?utf-8?B?eGNlUko4YWJxUGhEeWszY2xpZWtZY1JpYXNab2lrUjRCV1BPNjMrSGJZdEQ5?=
 =?utf-8?B?MDM1Q2RxdVZEbnRsTW1DeEc4ZTdyWlp3Z1pPNEVMbUxxeEFFYVNpdUdQZkdP?=
 =?utf-8?B?Q2hmNVNZcFVJdDlyaXlxa1UySGNuMzNjcVJUNXUxT1ViVkVWdW0rSUFKTXdJ?=
 =?utf-8?B?RlpqN3JiODBVbmpQSFNvM0lLVHJnamdkY1VHWmZ3ZFJYVlgyNjBPMGVwOEFt?=
 =?utf-8?B?M1ZONWVxVUhvOFdwSUNjSU5tU2FZR0lPSjROd2RUck5PQWM4VzRzblRGQ2RQ?=
 =?utf-8?B?Q2E5Q2U4UEhtOS9RTU1Sd3AwWTQvdDdTSVAxa0JNd01uL0NQYWpTWXhLYWhl?=
 =?utf-8?B?NUhoNWJLR0NEci9VMWQ2blFpQ3dod2dnNDlUWDBIQjQybm94WXhUNHgrbUdR?=
 =?utf-8?B?WGdGSFMvVXhBcjdtbzA3SnF0Z2JtdkpvYk5xUnNORzlaWWlxalFWVVpFVWF6?=
 =?utf-8?B?czlvRWErK09xYVAxZTV5bERDSXkrTjdsV1JxRjJ0MTN5eTZSVjFNVzVaeE1z?=
 =?utf-8?B?L3p5b2x4eVlMSVM0WjFTcmVna0RjeEtSekFmWVh0amoyVWY1Qzh4SnN3WnpH?=
 =?utf-8?B?TC9POXcyM1AxODVqTXJ5T1dwTzNDOXZCWmtOTlFBSzhCQUVUZllTa3YxbElV?=
 =?utf-8?B?b0s0aEZSRjl0bGFqT0RXQ0I1eU1wZCtKN3M5K2RVV3d0d0wvOG0xWFlNVllo?=
 =?utf-8?B?MGo4ZjVHTDFrVFdHM1BqUFFnNjlST0ExUG5sZ0pKZm5tR1M0SUd0b25pTWI4?=
 =?utf-8?B?VmtDYWpUbmlTL0xJTXcyaCs3a0JLTm5UQmZ1QlRxeEVLUnZoU3pjUEdzUUx2?=
 =?utf-8?B?aFVDSzZmR1kvRE9STWRFMTFEN3U4aXh2aUc4MWdIR3F2dSs1SHI5Nk5KSXQr?=
 =?utf-8?B?cmM5Q010dFlKeHdKQWlXTlR1ejhPQXY2VEFmbzV4Wk14dG9zTUlzSWNLOGcr?=
 =?utf-8?B?bHM1YmNUSzFBVytUM1k4Z0EyNzROUnFKK0NmbGw3clA2MDZPOWhVMDREU3B3?=
 =?utf-8?B?L3kvZVpIVTZKeDNjN2NsdklXNWE2S3BzeEY4aE4zK1pnYlhDU1NJT2w5a3Y1?=
 =?utf-8?B?eWRtaDQ5aVkwVFlDMnRua25GdkpkTU1XVlZaNE5Mb0hVaURTSTN1WmdyRmxt?=
 =?utf-8?B?MDlWeDY5dTNrUkV6Yk9ORG1nWStJanpMNlhuY3g5RUI1MnRaRzFpWi84M05H?=
 =?utf-8?B?R2VOczZMbkM4NEVnSnorNUh0dk4rbm0xQ0tqNE11ejlVdUZCQXZqRTYrR21v?=
 =?utf-8?B?Z014amc2ZU5IM0JZT2ZzQzRQZ2xPN1hLU1FObFI3eXlnaFVqL2FQaEI1Mm5F?=
 =?utf-8?B?ZWJyZmg0dUEvcmVSU004MEozZzZwa0FpeCszVGdhNkJ4ZFhRYXJWUytxSFpo?=
 =?utf-8?B?Yk41Uys1WHNKOHNHYTBaMEhkTTZqNU5wRHd1eXNIQnhSSThjN2xsd3dIMDd3?=
 =?utf-8?B?ZCtlSURFc2ZNQ1hqTFVkaDlYbTRGR2U1UnpDbUdmVzVLU0dHRE4vYlBMQkdW?=
 =?utf-8?B?QnVDZ01FOXc3V05zNTJtUk1JSkt2MUw5Y0loMUl6ZDRmbnF2Zyt2MjJmbXRL?=
 =?utf-8?B?OHVyeWE2WTFkTkJCRUhkWVIyeTNlNUpER0MzU1duYnNzeHN1bFBmUUR5TDBS?=
 =?utf-8?B?YUFJZmNmcjgvRzVSdDA5S2xMc3ZKMWppSTQvZWEySU5YRUxKZ3hNZXkvbUFD?=
 =?utf-8?B?M0Npa2FTUVlsQzVFOUNraW1WOUZnTlYyWk5WOVBycTVlek91aXhpMXZ1UTFV?=
 =?utf-8?B?eUZKVjRQUEQ1ZWJSMDA1dXQ3eWJRRjV0b2pMU01hWUVmVTBEdUE2a000Q3VD?=
 =?utf-8?B?aXhPRFNTeTRRdmhVVlhiWHBxclBZU0RHY3lWRVk3VklVTFhaVVFpZlhOYzNS?=
 =?utf-8?B?WC9ZMUh4SDF1aVNtVGpwN004ZllqUmpqUW1QbCtiL1o4dko4aWxtQ1BqL0Iv?=
 =?utf-8?B?SlBvNzhPV28xeHIxT1pGc09LUUg2TEwzcy9mOVFsYjFkYkVBSkVFV0NKejEz?=
 =?utf-8?B?OFJPZXhkMlM5TCtHNWk1QWZYRWxJUHVDa2drOGNwcklBNy9RMnlwT0luUkZP?=
 =?utf-8?B?RjQ1YjJqSDkxcmFJYWsyWkcyeTJyTGhMRVM0T1Yxcnk5YlIvYnMwelp1bG9T?=
 =?utf-8?Q?MJgt7SvSzGzDSG/38B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03505160-974f-4987-3c69-08de835682d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 12:21:11.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyaZP4HpppPBhaVnSUBmzfasfx6CptwCxQCcB+8X44XhbEairrVWTZ32MV/7fgzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225533-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,web.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Prike.Liang@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,lists.freedesktop.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ffwll.ch:email,bootlin.com:url,PH7PR12MB6000.namprd12.prod.outlook.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: E096B29971B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

W1B1YmxpY10NCg0KSXQgc2VlbXMgcmVhc29uYWJsZSB0byBpbnRyb2R1Y2UgYSB1bmlmaWVkIGhl
bHBlciB0aGF0IGVuY2Fwc3VsYXRlcyBmZXRjaGluZyBhbmQgdmFsaWRhdGluZyB0aGUgcmF3IE1R
RCBkYXRhIGZvciB1c2VyIHF1ZXVlcywgc28gdGhhdCB0aGlzIGxvZ2ljIGlzIG5vdCBkdXBsaWNh
dGVkIGFjcm9zcyBjYWxsIHNpdGVzLg0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdW5ydWkgTHVvIDxtb29uYWZ0ZXJyYWlu
QG91dGxvb2suY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDY6MTAgUE0NCj4g
VG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IE1hcmt1cy5FbGZyaW5nQHdl
Yi5kZQ0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERhdmlk
IEFpcmxpZSA8YWlybGllZEBnbWFpbC5jb20+OyBTaW1vbmEgVmV0dGVyDQo+IDxzaW1vbmFAZmZ3
bGwuY2g+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWXVoYW8gSmlh
bmcgPGRhbmlzamlhbmdAZ21haWwuY29tPjsNCj4gc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3VzZXJxOiBmaXggbWVtb3J5IGxlYWsgaW4g
TVFEIGNyZWF0aW9uIGVycm9yDQo+IHBhdGhzDQo+DQo+IE9uIFN1biwgTWFyIDE1LCAyMDI2IGF0
IDEwOjUwOjQ0QU0gKzAxMDAsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiA+IElmIHlvdSB3b3Vs
ZCBsaWtlIHRvIHN0aWNrIHRvIHRoZSB1c2FnZSBvZiBnb3RvIGxhYmVscyBzbyBmYXIsIEkgc2Vl
DQo+ID4gZnVydGhlciBwb3NzaWJpbGl0aWVzIHRvIGF2b2lkIGFsc28gZHVwbGljYXRlIHNvdXJj
ZSBjb2RlIGZvciB0aGUNCj4gPiBhZmZlY3RlZCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgZnVuY3Rp
b24g4oCcbWVzX3VzZXJxX21xZF9jcmVhdGXigJ0uDQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvdjcuMC1yYzMvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9hbWQvYQ0KPiA+IG1k
Z3B1L21lc191c2VycXVldWUuYyNMMjc1LUw0MzQNCj4NCj4NCj4gT24gTW9uLCBNYXIgMTYsIDIw
MjYgYXQgMDM6MzI6MzRBTSArMDAwMCwgTGlhbmcsIFByaWtlIHdyb3RlOg0KPiA+IFRoYW5rcyBm
b3IgdGhlIGZpeC4gV2UgY291bGQgZnVydGhlciByZWZpbmUgdGhpcyBieSB3cmFwcGluZyBhIHVu
aWZpZWQgaGVscGVyIGZvcg0KPiBmZXRjaGluZyBhbmQgdmFsaWRhdGluZyB0aGUgdXNlcnEgTVFE
IHJhdyBkYXRhLg0KPg0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb25zLg0K
Pg0KPiBJJ20gdGhpbmtpbmcgb2YgYSBmb2xsb3ctdXAgcGF0Y2ggdGhhdCBzcGxpdHMgdGhlIGJy
YW5jaGVzIGludG8gc2VwYXJhdGUgaGVscGVyDQo+IGZ1bmN0aW9ucy4gRWFjaCBmdW5jdGlvbiB3
b3VsZCB1c2UgX19mcmVlKGtmcmVlKSB0byBtYW5hZ2UgdGhlIG1lbWR1cCBsaWZldGltZQ0KPiBp
bnRlcm5hbGx5LiBUaGUgbWFpbiBmdW5jdGlvbiB3b3VsZCBvbmx5IGRpc3BhdGNoIGFuZCBmb3J3
YXJkIGVycm9ycyB0byB0aGUgZXhpc3RpbmcNCj4gZ290byBjaGFpbi4NCj4NCj4gRm9yIGluc3Rh
bmNlOg0KPg0KPiBzdGF0aWMgdm9pZCAqbWVzX3VzZXJxX21xZF9yZWFkKHN0cnVjdCBkcm1fYW1k
Z3B1X3VzZXJxX2luICptcWRfdXNlciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IHNpemUsIGNvbnN0IGNoYXIgKmlwX25hbWUpDQo+IHsNCj4gICAgICAgdm9pZCAqbXFk
Ow0KPg0KPiAgICAgICBpZiAobXFkX3VzZXItPm1xZF9zaXplICE9IHNpemUgfHwgIW1xZF91c2Vy
LT5tcWQpIHsNCj4gICAgICAgICAgICAgICBEUk1fRVJST1IoIkludmFsaWQgJXMgTVFEXG4iLCBp
cF9uYW1lKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gICAg
ICAgfQ0KPg0KPiAgICAgICBtcWQgPSBtZW1kdXBfdXNlcih1NjRfdG9fdXNlcl9wdHIobXFkX3Vz
ZXItPm1xZCksIHNpemUpOw0KPiAgICAgICBpZiAoSVNfRVJSKG1xZCkpIHsNCj4gICAgICAgICAg
ICAgICBEUk1fRVJST1IoIkZhaWxlZCB0byByZWFkICVzIHVzZXIgTVFEXG4iLCBpcF9uYW1lKTsN
Cj4gICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gICAgICAgfQ0KPg0K
PiAgICAgICByZXR1cm4gbXFkOw0KPiB9DQo+DQo+IHN0YXRpYyBpbnQgbWVzX3VzZXJxX21xZF9p
bml0X2NvbXB1dGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdXNlcm1vZGVfcXVldWUgKnF1ZXVl
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX2FtZGdw
dV91c2VycV9pbiAqbXFkX3VzZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBhbWRncHVfbXFkX3Byb3AgKnVzZXJxX3Byb3BzKSB7DQo+ICAgICAgIHN0cnVj
dCBkcm1fYW1kZ3B1X3VzZXJxX21xZF9jb21wdXRlX2dmeDExICptcWQgX19mcmVlKGtmcmVlKSA9
IE5VTEw7DQo+ICAgICAgIGludCByOw0KPg0KPiAgICAgICBtcWQgPSBtZXNfdXNlcnFfbXFkX3Jl
YWQobXFkX3VzZXIsIHNpemVvZigqbXFkKSwgImNvbXB1dGUiKTsNCj4gICAgICAgaWYgKElTX0VS
UihtcWQpKQ0KPiAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG1xZCk7DQo+DQo+ICAgICAg
IHIgPSBhbWRncHVfdXNlcnFfaW5wdXRfdmFfdmFsaWRhdGUoYWRldiwgcXVldWUsIG1xZC0+ZW9w
X3ZhLCAyMDQ4KTsNCj4gICAgICAgaWYgKHIpDQo+ICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+
DQo+ICAgICAgIHVzZXJxX3Byb3BzLT5lb3BfZ3B1X2FkZHIgPSBtcWQtPmVvcF92YTsNCj4gICAg
ICAgdXNlcnFfcHJvcHMtPmhxZF9waXBlX3ByaW9yaXR5ID0gQU1ER1BVX0dGWF9QSVBFX1BSSU9f
Tk9STUFMOw0KPiAgICAgICB1c2VycV9wcm9wcy0+aHFkX3F1ZXVlX3ByaW9yaXR5ID0NCj4gQU1E
R1BVX0dGWF9RVUVVRV9QUklPUklUWV9NSU5JTVVNOw0KPiAgICAgICB1c2VycV9wcm9wcy0+aHFk
X2FjdGl2ZSA9IGZhbHNlOw0KPiAgICAgICB1c2VycV9wcm9wcy0+dG16X3F1ZXVlID0NCj4gICAg
ICAgICAgICAgICBtcWRfdXNlci0+ZmxhZ3MgJg0KPiBBTURHUFVfVVNFUlFfQ1JFQVRFX0ZMQUdT
X1FVRVVFX1NFQ1VSRTsNCj4gICAgICAgcmV0dXJuIDA7DQo+IH0NCj4NCj4gLyogc2ltaWxhcmx5
IGZvciBtZXNfdXNlcnFfbXFkX2luaXRfZ2Z4L3NkbWEgKi8NCj4NCj4gVGhlbiBpbiBtZXNfdXNl
cnFfbXFkX2NyZWF0ZSgpOg0KPg0KPiBpZiAocXVldWUtPnF1ZXVlX3R5cGUgPT0gQU1ER1BVX0hX
X0lQX0NPTVBVVEUpDQo+ICAgICAgIHIgPSBtZXNfdXNlcnFfbXFkX2luaXRfY29tcHV0ZShhZGV2
LCBxdWV1ZSwgbXFkX3VzZXIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1c2VycV9wcm9wcyk7DQo+IGVsc2UgaWYgKHF1ZXVlLT5xdWV1ZV90eXBlID09IEFNREdQVV9I
V19JUF9HRlgpDQo+ICAgICAgIHIgPSBtZXNfdXNlcnFfbXFkX2luaXRfZ2Z4KGFkZXYsIHF1ZXVl
LCBtcWRfdXNlciwgdXNlcnFfcHJvcHMpOyBlbHNlIGlmDQo+IChxdWV1ZS0+cXVldWVfdHlwZSA9
PSBBTURHUFVfSFdfSVBfRE1BKQ0KPiAgICAgICByID0gbWVzX3VzZXJxX21xZF9pbml0X3NkbWEo
YWRldiwgcXVldWUsIG1xZF91c2VyLCB1c2VycV9wcm9wcyk7DQo+DQo+IGlmIChyKQ0KPiAgICAg
ICBnb3RvIGZyZWVfbXFkOw0KPg0KPiBXb3VsZCB0aGlzIGRpcmVjdGlvbiBiZSBhY2NlcHRhYmxl
IGFzIGEgZm9sbG93LXVwPw0KPg0KPiBUaGFua3MsDQo+IEp1bnJ1aSBMdW8NCg0K


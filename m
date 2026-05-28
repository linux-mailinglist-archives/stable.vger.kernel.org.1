Return-Path: <stable+bounces-254977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODp9ONI+GGo1hggAu9opvQ
	(envelope-from <stable+bounces-254977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:10:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE2C5F2803
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA357313CEAE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8210C3E0758;
	Thu, 28 May 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oje7mhDd"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5C3E63AA
	for <stable@vger.kernel.org>; Thu, 28 May 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973549; cv=fail; b=ixHSlYDDrL6ZCfpCnSt5VtKorcr9GY6/fs2bQB75dWW9hXXaLT9meqmwlBfsbovG/cBPJ3YK2Ghh6YhaJaDYCRdR6GeXDO0OrIDnfnXlCp7WHoxo+6AvBC8LzsiFO4uCOxV+xseA7OLLo06YhMvKufr00Mc/P+rfPRof02sBmWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973549; c=relaxed/simple;
	bh=MVJ4wJ3wmVX65m4RvPABYTrdGiKbfu+xADWVzRnDBNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iESluBLqHgX5LbiBdEjuArvbRP/eLod7jAQ6MaqRBcdrAja+FrPwbtlUAt1jR47/EnBv/U63fQP9W0Svuk6kspIij/ZQ/8qJ2DGzVNP+cEnFlWmwFGvpFblTGNC0gIWOH0x7vRve+7CPSofF1QHjdExdXkL6xN7ORaKSPy4lKCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oje7mhDd; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbxItPjkFDoI0Pua82hKwsUh1/ORVMKL8YCBs3TTHi98PQ3Y0YaqTS8WXle9ZKO/Kt30t4DZhHA+26RH93dLPMcBQv0hxujzeProdeHuTqcRQxNBZzuow61dFl+7Tj1Tia5bIn+oPFe2ea33gBPad4BBbCd5YTPIXqCVk82qWfknkoAdF3iYN0WWLxzU/lXjv8qfbnYx9l/2ss/O8rVUmVgai9RaTFZ6XYNH/RgHyLyZxEC8gzikzYisGmLjb0RgxYG5Qps5jZ2YBJz6pwIpr/xTt5vxsM0FbDCyg5VHMG9ybmDzjjhVg/IhnN9cFOz1JI4zSFoqWl0DApOFVvdMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVJ4wJ3wmVX65m4RvPABYTrdGiKbfu+xADWVzRnDBNg=;
 b=tq3chEO8Nnm7Rjde6eYcuB8iQ8J8sWDyzrj0MfqMqSquVGCdMEMq3ZDJaED8ZC3mOFSzFq5I3JAo8F7+vaM0UupZWRnpCcSuOA/jUYdvcze7C/4HQhkYcoOuAudjIQhHQFc7MkIcQEzfIW03RrYwlb8m8sJTHfwoEjlT15b/ugcEX4KDseV03pE0eBsIVNhWKs/ppp2zlusiqx69ocM07QBGnkUDhcobMt6+6R0eU/UYDY/99q8GXyUR9p1oNu9Swq8pLSSMe+WGIPLXC9L2DnMO0IQG6adkbBmC+mPstYGIF8J/sBpMFb2eSVTKqz6pBjYrjnp/kpIKLqLFWEJpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVJ4wJ3wmVX65m4RvPABYTrdGiKbfu+xADWVzRnDBNg=;
 b=Oje7mhDd9wZdAiRyOewmAgXZ+gWE4wH6ZFraB0x7+xoNfvIowB660yjsu/CcqGt+vKlFJLpcveMObLT2hUwLrZGPn2JXepzENbA1HcLVfpAbCEOGkOmJghvUTCYoMMP7RQ2P2SFkptr+u/HNG7JRZ0NuZvOXRTKn7JHjR+lRFhE=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by IA0PR12MB7553.namprd12.prod.outlook.com (2603:10b6:208:43f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 13:05:44 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::4c39:c452:1296:e09b%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:05:43 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu/gfx9: guard fault IRQ puts in hw_fini
Thread-Topic: [PATCH] drm/amdgpu/gfx9: guard fault IRQ puts in hw_fini
Thread-Index: AQHc7hp4Ya8lrpGw30ONnwLgLQlywLYjCqKAgABdCVA=
Date: Thu, 28 May 2026 13:05:43 +0000
Message-ID:
 <SA1PR12MB8599A335F391E5E0E074EB02ED092@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20260527204940.1741202-1-Yunxiang.Li@amd.com>
 <9164ec6a-ef61-484d-9d52-92094fa28f7c@amd.com>
In-Reply-To: <9164ec6a-ef61-484d-9d52-92094fa28f7c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-28T13:00:50.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|IA0PR12MB7553:EE_
x-ms-office365-filtering-correlation-id: b696f7cf-cfff-4d7b-8059-08debcb9d378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 vIZfrhuTuRPllCJv4Xrz+/ih+/DW0MYu6bFHaWthSkyuxi/rPv+Y8VeVJrdpUC0IVyo2Oq2iuYGFo9VB+/uMUtmmoVI46lj93U/4UuV75sd1WqC2dH5HM1pLAqAKahWpjSEGeanh1sANlYZwcJTeHJ1oLyBh/pzb21TbGIZen7eUz6sIpbGuY0PH3At6dJBExH3UniCBGWL/0+3gVmsLvCG6tI4eGdAeeMpOz3vp2vYl8bk438JMyA+86gxjfcf18HqZVqf0+YyqHMIUNaWN66eKI/EJFnLs1b9QIj1NzHl1lS6uJfCap2QBqF2XDh6JXtvk32OOuP5V4d9iwdedyKdw/f5c+bdXMleYRZrX5/7zeATVV7RYAN6itY0rFHR++gBaX+Q7M8EEY1qWrcSBCNzNKLXqV8SACJeCvh0Nbcam4a0TMJ7LBVTMDy2qjrHnvF+hbxuNOsqmQX0IhkNJmiVF9I/+Ekp/UiDM/6i68cZFSk+pLVSfFUw+QKtpyP6OU45ImGeZ6v2RFAHy5HXAGyCH8S2jHwNM1C6/7F/GSsetF4iWzXmAu0rYfh93NLvER47M1YzWJQVsneFelESAguuYWG82Ul37AcERpFwoV93EbPsAsyK0bo76P9BV5N12MXdvelfvynje9CPGg87RJXhC7Q95kACda/1Y3Kblv4lF3L1/mLk+ePrMOjcGZ4JchoZFWbTgOh6fm6/tFPCr+Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTVDc3MyL2hxelhpTUFuL2dGUlBMNG9jSXdXQjl2L3BUZUFqUHNLSFJyQWcz?=
 =?utf-8?B?MUFlaERnTXVPbGp0TG55RDRMSW85UGZWVnVic0pVRkhlVnVHQ0ZSZ3E1RUZP?=
 =?utf-8?B?T0JUUzZkUld5VzlHOXB6bTc3cmZSTnZraHJiZU1yU2FpLzN0RzVtSFQ1WVBv?=
 =?utf-8?B?MWJ4cXlKeGxEODlxa0EzbWtnTUhjZHhMTmFUc1BHdU1BRWQvemJwSkpqcm1t?=
 =?utf-8?B?UmxnbTlpYnkzc1kzbmovR2xuVTJzNHJiYmhvSWhidnJHYXptcEZ3a1dDT0VH?=
 =?utf-8?B?WFUzM0ViY05aTnBXZEg5Zm9MMkxWUlgvZE5wbmVQTWp5UDVKak04OUVqdXc0?=
 =?utf-8?B?eW82U1M4V3IrVFI0MTJWQjJxU1d6ZjBTelVrbUllOXJUSVlnUXRCSzVFQytj?=
 =?utf-8?B?RjFxMytCN3hlcEFaWTYyamorUk45ZDJJdkswcGRJVjlhOWpqUzQzZTFIMThB?=
 =?utf-8?B?cEFjZHpuWVdTNExZWjBiNUx5cDZZVSs4VDlmbUtEdWtpQzIyYzBZWER0Ni83?=
 =?utf-8?B?VkNBdkhodXpzWGZmL2taTDkxQlhCaTU2WWxvQ3B2NURTbGV5SW9RZHE5UkdK?=
 =?utf-8?B?N0hHc2drSHYzYkhFdmRsTmI1bHlDV2ZudnhKSlpnUmdaSUxEZzhhN1N5aEtj?=
 =?utf-8?B?TmhQbHFnZ0g4bzJoVE5VbWVjVmNjYjNLSVpwUVJ6UEhiaVpjSDlnRTRpWGdr?=
 =?utf-8?B?VjhuNWF6b1NLT3FVNXIvZnRPT2hHUG92aFZUTUhMQWw1VHRGZWtwQmUwYXlk?=
 =?utf-8?B?Rmh2c25xVVVWTG13UXhtMDNWUDVZcUsvNWNYS0VPVSs0RGpqTEVNNk9zbUR3?=
 =?utf-8?B?eHJPb1FrZ2VWbDdyNzBlTUppTEFHM3JWdW81VE0vUG1RNzBKM0FmSmxXRmU5?=
 =?utf-8?B?WnR0c0NxTGh5MnhXYVk5b2tCWXdxUSsrZzh4anFUdEhFWTltTnZMWFRIajlV?=
 =?utf-8?B?S01qQ1pBY3FOajZuMDZCeVhldmpBYW1vOWpVQXBINGNqdkduQmcrVDZPa0M5?=
 =?utf-8?B?K0hVN2xERUxFVk95MmlaWVY3S2dKd3R4T1p3U0dnU2c5Wk5yMkRFZTZDMXcr?=
 =?utf-8?B?ditpbjhsempKbmNjdmFhKzhZM1kwNnFxZWdVSGpzNTFXMDVvZ0Q3SzhZVTYr?=
 =?utf-8?B?VUFxK1d5TS9KTldXTHRsVzVFRnlaY0RGT1dSRVBjWVVONTN0UzhUUnVRTktT?=
 =?utf-8?B?U3FVck05RE1lNWxPdTFlVHBoR3dBVmxrbmVKVGJ2WmM3U1hRYWR0Yy90NDFa?=
 =?utf-8?B?R1FvTk9oWFEzQXJ3NnAra0x3L2FHSHlEM2Z4WGxqYXBQa2xmZlptVi9JQitE?=
 =?utf-8?B?ZmMwWUErN05FQ1RCVlNjYnBTT0kycE9zczFYdWVDVS9tSkxIQXR4L09ibkly?=
 =?utf-8?B?c2ErblZVWGtsakdBUnU5eHBYMjhHSUdUZ0orN09HTXBkWDl4eDRiWHJabENx?=
 =?utf-8?B?VEo5S1NBOGVTUkhUZURnbE5XbG4yeVZUNGlyc0g4YTA3SFEwdHkvUlF3a1E3?=
 =?utf-8?B?S0p6QldtSXR4ZkxUZGFPRFpDZlRsb1ZhdUFVYk9rZ05abmdLT0ZEbXZYbndG?=
 =?utf-8?B?SGM2VnNWQzlrVm5DRnk5OFlQT2xDNnBKeWRaRll4QmJGdzJocnc2QWZlaFBL?=
 =?utf-8?B?eFpNRTI1ZEhqOE5NK1V3TFU1K01rdHQvc1lLMzJDdGVRVVJCVHh3MDR4RDkz?=
 =?utf-8?B?MEk0REhZdEJUN2gxQm5tNnltc2IyTkFjUE5GZnVUV2ZjU1dKVE1LYmFNQ3dl?=
 =?utf-8?B?SWRqTE5wZzdXYVV4YjQwZHBGbVZQWWRIR2dIS3U0THNsWk5PVWU1ak5DU0dh?=
 =?utf-8?B?R3dyMkZQeE5MWWJQRUh5UUpXd0svSTBvVmx5YkQ4akhuRHVPN0x2UjR5R2Nj?=
 =?utf-8?B?ejQyUG05RFU2NnNab1p1empPbnRKdU9DUVBEZkd0WWRVSVQrWWVyNm1BWk9u?=
 =?utf-8?B?cGN2VnlWUFJkTnljT0Q1RFlsemRSeDJhQXcraVNkbHBMQlozOWV6NjBjV0Yx?=
 =?utf-8?B?ZDRCVUYyWGZ0WkFXbVdNd2UxOWRaT3o4eDhON3dXVDVnRmdhbWVJSElXSEp3?=
 =?utf-8?B?WkhPdG9sSmdDRUR3Z0U1UFBCd2EzNE5XNTFWVnNhVkhqTnBYMTlQa2hhZU4x?=
 =?utf-8?B?QWZ0NnZhTXBXUmFCdkNaZzhKa2ZVdncrZWNMcTRWRDl3YUxDRkwyZFYvZE50?=
 =?utf-8?B?NEo2Nit6STcyRUM3Ym9XaFVKTFVoNVJRLzNPbGlqMGlUWDRSUVZhVXkwSlp0?=
 =?utf-8?B?ak1NODRRNDcxOFowQTMwL0UwdFJRWkFiZzhYRnF6U3RuTnZ6OXNEQUgyVUlO?=
 =?utf-8?Q?kY5x3aLR86sO5PrUex?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b696f7cf-cfff-4d7b-8059-08debcb9d378
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 13:05:43.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIMHpn3Jq88JztAa0Wl7GrmviBlhSSSWDdz5lLmnprOeezIsqMu861Uqah5vQje2NlYsQ6JpKiPhNik7eCICpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7553
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254977-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yunxiang.Li@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 3CE2C5F2803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

UHVibGljDQoNCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4NCj4gVGhhdCdzIGEgY2xlYXIgTkFLLg0KPg0KPiBUaGlzIGp1c3Qgd29ya3MgYXJv
dW5kIHRoZSBwcm9ibGVtIGluIGFuIGluY29ycmVjdCB3YXkuIFRoZSByZWFsIHF1ZXN0aW9uIGlz
DQo+IHdoeSB3ZSBoYXZlIHRoZSBnZXQgaW4gbGF0ZV9pbml0KCk/DQoNClRoaXMgd2FzIG15IGZp
cnN0IHJlYWN0aW9uIHRvbywgYnV0IHRoZSBmaXggSSBjYW1lIHVwIHdpdGggaXMgcXVpdGUgYSBi
aXQgbW9yZSBpbnZvbHZlZCwgSSd2ZSBzZW50IGl0IGluIGEgZm9sbG93dXAgaW4gaHR0cHM6Ly9w
YXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3Nlcmllcy8xNjc0MjMvLiBUaGlzIHdvdWxkIGJlIGEg
cXVpY2sgZml4IHRoYXQncyBtdWNoIGVhc2llciB0byBiYWNrcG9ydC4NCg0KVGVkZHkNCg==


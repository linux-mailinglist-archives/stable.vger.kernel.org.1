Return-Path: <stable+bounces-69599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E57D956D3D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3199B28369D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0F172777;
	Mon, 19 Aug 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pgDVKrov"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0216F900
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077778; cv=fail; b=OPiPiLenq3CrsJV0vDsnvLKRt4ApEkKKPvlLKIEYklbnRksjK1YzYx21JFxFI2GnkxAdTVYAsWV59DJHaXTd/r4ru6T67ac8iFCBFE/75IELjTS1igATWspt0VdnptMsnW96+fihPbvv/WnGDnB+FhUR4j4h53iCqITGrF3IlLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077778; c=relaxed/simple;
	bh=96NR2cYQ6ZfFfKjL00AIkCDsRFsGrwZUGhpQ0/DDbYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FveEh2SBefcEU2/SE43MqyR+F0gemCS9zLGDqoiETOyPyApsZZe4t3LeYICvO+4mi0NfHzNSLwbj03YdV6qsAqISSuNSZ3w01edho83C+KPNpr3ZIrxvhGhZZPFJR8DZuJpHAvHyLwvpSpIeVluLKigTVxCbfmac/R5yTf778ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pgDVKrov; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5hsrIcKFI8S1M5zqjpjSb1cOqfOwiQVKpT1+Yxmr2chJsXSZOr5XYp7Bv5RDTw8Q6iX6d1QUGhK6OfnbQT+qVpgxLAR8RUljbNep1qbxYPtdp7aqGLQVCXLf6dkqb3T0o8bYcFy0LhHo8AWv8S7azGMKFcTBsOcsaicW0xSflyxJdjQJZ/cmyChL+j+O+CgvMUgeu1W65VrbdRMVImoDax3tyGm6LeS6TfiGamw43UvacxAIVkxN3MA4GAwDbh3XEzxl34r7if4mhk1gwzQ3kq+Rkf+6ij2nyiSLm6eQI8J7w8AfQs0dBJPdDLTUAZau1Re11cFRbo2UdTXdfnhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96NR2cYQ6ZfFfKjL00AIkCDsRFsGrwZUGhpQ0/DDbYo=;
 b=bHDzW5cat/W5/GN6NcEH0zY6WSP0YReq1KA3srF51MUOEQClwwJN98wuRwNN//aGnMjL5vhjRkmR05aMiNiR+74gedNXioxFx+WyB7Bi0hUepI/2fsHqgPfzKHnDaoMECRfgp0S3uCfq2J2UvX500Uyxy3YeSHtNKFLd2R3vD244O9/mA0OxvCHlV05oqCP3bQhZuQvGxyNt451fQp5PCIloNGTm0i7Nk0oPCuR+uKBfeNLfAjwlGb2xdGlQDMBHmupR6iaE6DivCavkelAwGI7Jf+BcWPIVq1dDj+tc3sBScnP13CLa33Cq/f7fDWu9gZdt56zXRQ64av1qpekB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96NR2cYQ6ZfFfKjL00AIkCDsRFsGrwZUGhpQ0/DDbYo=;
 b=pgDVKrovooiN9mo8q6TQtTdSgatL3dQmOmLnNcBpQ6M758+A1ISlpi6euzpEKOF3WvKeT+YcNwI9duTalBnXQnl24nkzwqqxHeWxqjRv6aVAwseWoJyr2PBi/J/yis/pUmsi1HOpWUtfjDEjs5xUWCfVBVVwjJVlNhTdeMEaFLc=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:29:33 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::9edb:7f9f:29f8:7123%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:29:33 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Jiri Slaby <jirislaby@kernel.org>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
	<Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne"
	<Wayne.Lin@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
	"Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry"
	<Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Topic: RE: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Thread-Index: AQHa72Tn5iMMWSqT/kqbFxnwVwSGXLIqRbqwgAQBcYCAAF6z0A==
Date: Mon, 19 Aug 2024 14:29:33 +0000
Message-ID:
 <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
 <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
In-Reply-To: <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=5de93699-8200-4610-abac-a5796794b846;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-19T14:16:17Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|CYYPR12MB8939:EE_
x-ms-office365-filtering-correlation-id: 99752bb1-5fbf-405b-7f48-08dcc05b580b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnE3Z2xOYXBsR0V6OUZ5Y01qd0p6bUtuSWdxalM2cUtiZlRaVDVELzlhME5i?=
 =?utf-8?B?UnlMOG5jQXNCZVpFd3ZrWHdZWndOWk1TWTRaYU1rMSs0RGtzemVoUURscG0x?=
 =?utf-8?B?eHp5elRJQ0JYeGhZQUVpN25zNGxPTHRPRWRrNy9nOTV5NTZYL0syMndDak1k?=
 =?utf-8?B?LzVCVkEzTTkzZ1g3VW9GQUdydkYybjJ2YnN3dVFDUnJQeWQwalB6ZExyeHlV?=
 =?utf-8?B?b2VoSENWYTh1cUNXZVRnaEl4T20xU2VYYmlzQXFaRWdRaDRwVUxsUHk4T2ps?=
 =?utf-8?B?YUlKU0lTY0dWWGFxV2FqTTJzaXBQYkV1Y1oyRGZxaXZiVGNxZkc5c3JqZ1JZ?=
 =?utf-8?B?VjRZMHBkSTRlTHVFcHJuMXNVcEV4RFVydHRUeXgrMTZWMUQ2NDdEdVJDdEpt?=
 =?utf-8?B?cHpTWitTdzM3eGxSTk05ZFBvM2VxNUhpM1BWMHRsOU8rdlJTeDNHTlJXREp6?=
 =?utf-8?B?QXFXaVg3MDg1RlNXU1pTcitvZDNYcTdwSUMvcDlUdEJGblVuKzZodmlNRE1C?=
 =?utf-8?B?YmY4YS9WOVd6bWFja29pY1poVzN2d2pnZmRCL3M3d24vVmhGMVBHT0xzMS9j?=
 =?utf-8?B?ZG9KbUR2QXFVVkpQeC9yamVRSEZiWmFvTlpuanAyTFN0Qy9JUVQwQWJzMjI5?=
 =?utf-8?B?c3BwK2VkRC9PM3VObFZKVWpTVlhnNmZvVldLMFZpMndrRkFRSTV5YUhOaHVF?=
 =?utf-8?B?ZG5lRmVGUzhWY1BGY1ZCZmFUZlJGL2xUTUc3WEpXOVJMdFN3Mk5UMlN0RVRU?=
 =?utf-8?B?bHlDUStFS0tCRlc1VTdHeU90YWhaWlREQW5OQXNFYk9YMURrNTdabXhSTG1m?=
 =?utf-8?B?b3dVaE40NUtDTkdPT3hhaVI2MFFtaFZtMXJqSHNtajBvSUlLbGFadUFsNzlp?=
 =?utf-8?B?RUcveFlra2gyWjR5ZWpieHBNQ1RRNVRHV0ZNTzBVakdUekovbFNPUnpMOUlW?=
 =?utf-8?B?QU1sOXA2Ui9KMm15ajFnMHpTaVFFVFFlK3daMkxBaGpmcUQ1SFJwa1pHekhF?=
 =?utf-8?B?OEJTeDlzSGJUVU1nbU1ic1NyK3JUT3Qzd2tKak9IWHVqNEhZb1ZFWEZlbUV3?=
 =?utf-8?B?NW1ZSm14UzE1NVZzQWFPZWFqeVR5ZjF0dkN4NWlJS2xjRmE2Nk12VlgrdS9X?=
 =?utf-8?B?aEk1OE9RZU1YdVhlTFF1cld5V1Z6QlZjR291amlRd0NtaitCUWJtdkdUUTJq?=
 =?utf-8?B?SmVLVWREakZVaGtJOFdxTnpNdGZaSk42VzUvbGRvcDU1b25sU3hKY1ZWN1Fj?=
 =?utf-8?B?RGQ0Sk1lbFkvK1h6Wnp1eHBJM0N5QnkwMDMxbzBjTkR1d0JUdTFnMW8raFVD?=
 =?utf-8?B?VFNwYVVPdGlOdFJwZytUL09xVGdSZkdUaWZSNVBJUTZ6OXNDVzhpTkZCRlFz?=
 =?utf-8?B?QnlZTVhkQkgwdFN5NHpnaHBqbDNPbWozS3F6WTNrOVVxOFJzRGczdFRZejhY?=
 =?utf-8?B?YUxFRUV5MDdJSm45OU9SZHMvV05EL1ZMS3pxYzVlcHBMTnEzdjZsUzJpTDNY?=
 =?utf-8?B?ZFVrRGFFay83ZTVma0xqZE5BWE9RS3J1Ti9IMC9sRDRGeTVlNEFzeEZrU09s?=
 =?utf-8?B?RzljeFYrRHVERzJDU1hRMGhKc21GbmVCcjJHTk1xR2dyeEpNdnNtWjJqRlFW?=
 =?utf-8?B?UkNmNEZ0SUY2Umg0d2s0bWROS0hURC8zTjJ1VnE2ZldGSjc5Q2JtMGhIQ0lw?=
 =?utf-8?B?TnpqMzREWS9PaVprNS9yTW1HQm93YmIzZkdGMk5qSGNoUkdoRmhOcWdPTnRY?=
 =?utf-8?B?NW5ndmlMRHJxTytxQ0tOV3lLMkJGeTRUcDBXeWhxd2t5SG9meUUzRnQwdnlX?=
 =?utf-8?Q?eSCpr8XOeTOqVV9wdzx9YycmQE8OkBUpeJxg8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3FnNHpXSFAzblNtUHJjNnlVWDNST0psNFYrNE1lV2VJeXdMSW54ZjVLK2VN?=
 =?utf-8?B?R0Qyb2dtcDlIMkpGKzU3Y2FQRGJ2QTdhQzBqNjRreUhEcmpHRlJSOVhtdnBS?=
 =?utf-8?B?N2hRZWszZXJsVU1hamR1elBzblV1aG5WempmL3lsWmxUZjdVRzUwZUtLMjdY?=
 =?utf-8?B?Sm1WNndrT1UvU1ZzS20vRy9kOHQ5V0hxTUVISGNad3QwRHlRUFVIeEt4SVFp?=
 =?utf-8?B?MFRpWm9NSWdPeHdJZkpXbmEybzBzTTJrMjR2WXhaYWlRSS9lNnFBVVE1TFJD?=
 =?utf-8?B?dzQ0S25rQ0sraWJuQzNNSWE1RlAydnZPM2VtcHlYR0YwNE5iUDJWS3JzVEpM?=
 =?utf-8?B?dmZXemxXNWI3WW5WZWcvUVdFVnR3OGhXczRka2VRZmY1N3hxbThWREZZN0Yz?=
 =?utf-8?B?YjNza2U4VVRVNmQxYkZSOXk1RFExdTc1b1NnMy85aE9jUHdTQS83WFM5YkRp?=
 =?utf-8?B?Z29pWUpmTERQUlgyR0lUTWx4eE1ESVJwcUZUTlB2b1FMTGV6VUpxNDVVeFY2?=
 =?utf-8?B?aGk5cWNCbDdTaTZ5dUxCQUNjSE01RXR2TDVqdXc0Q2tzTUQ2Wmk1d3pTRnc1?=
 =?utf-8?B?UUtWM0VqYnEvdFZmREgwYmhud2dicFZpQ2QwQlhuZGR0ZUh0SmZYdWozZGxi?=
 =?utf-8?B?VnVCckYzSUVWaGhKbDArOHRSbVRSdGJIZU55ajBKenExaUZ2TlU0VnU0ekhU?=
 =?utf-8?B?NU56TXFZRkU5TlhpaG1oYzFuMkxMZnZhWmJESlZLc285SWNzWlVkWENja0pU?=
 =?utf-8?B?R3hkandwS2JKRWliT2pET1RqQ3BEWWJuemZtVFJSK2JBcW9KcW4wSFU4eWRa?=
 =?utf-8?B?RE9UWlgyOCtQbC91VWFqalhkTnZMYU85OWx3bkpMNXFLVU9RZ0hnaU5pcHdw?=
 =?utf-8?B?dk9pWFNqNEtCdFV0WG1jQWFLajRrcHNzV0lJY2J0bnREQUZwK1pNUTlkTW9t?=
 =?utf-8?B?aW81bGJXdXhCcFh1OS9XSXNnM3RKUEdkVUpqR3JrMDQyUjJXTHY4TGt4Wkhl?=
 =?utf-8?B?ZGxBeTRpZEJvRkhXbjZwY1grTlRmazVCazhnUy96aHFrOXRNeGpGZlNKRTZq?=
 =?utf-8?B?RzY0UWhZTnpoajNFYU1LZkJObXRDRWV5eDVXeHo0UDIrK1FleThlK0JtRWhX?=
 =?utf-8?B?bkRkOS9ScHdiNE9lMksza0dYRGpzVHZoU2NNcVpmSGVteGNtYU1iZmN4U2RH?=
 =?utf-8?B?bmphR1FML3JER2dsR3hLcC9mVzRLZVQ1TXdBcXE0eWxHZ3YwYkEzaU1lSmVW?=
 =?utf-8?B?RGx6N2tYaHB3OWg2clJUdXZxMGhadlYyZDE0U3hzRngxa3NEWnhQaGU1b29T?=
 =?utf-8?B?dHdKVHBFelV1d3pERmt2RnkvZ3A5YXUvbFdTK0trUllQOXFXekJib0s3M1Q4?=
 =?utf-8?B?cDVZTDI0amFzdFlRblkwS3gxbE8zTzdBRS9HTmF4cVpTZEtUQURwVGJHTnAw?=
 =?utf-8?B?Z0FOcGlaS0w3VmpNS3FQK3JzYWNzQktZcHVtVnpENitURktyTDZjemUxZ1RD?=
 =?utf-8?B?L1B1WjNqazkvbUoxZFNhUkx5MDhZZEY2R285a00vRFEzZXM1TlAzZ3RIUEt0?=
 =?utf-8?B?NDhSWDBYbjZKeXVNVWczNGR2ZEJ4aHk5SEQ2b1gxeXpmaXIrVFVSYmNIL21E?=
 =?utf-8?B?S0pJYy9scFRVRjEydmJpVnJiQ1VLVkVWaVhxTTkyZXZwSE5WcndRUUlXWml6?=
 =?utf-8?B?U1hMREhLK0htTGlwNE9VSUNvUlVwYmgxTW9sd2tVOGY1bkZpYllWVzhEdE1I?=
 =?utf-8?B?c1U4NlJ2bjlFS2sxNVROWkNaVVVYRlBwMDFLYmtMRVRSNlhJVzJGNHdOWGlU?=
 =?utf-8?B?SXBHbExGandBZmRobUpCblNWTkpFZmg0TmxLREJNRUNYQ1hBNU1kWkQ5Z3Zt?=
 =?utf-8?B?L0wwNzR3WHNaZjJIQ0tJRi9nM2RJT1J3Smo4K1JodkM3R01oblYvZ21tVktB?=
 =?utf-8?B?ZGkzZ3NZTzczbTdvRWUwaFUweXl6NUhPbWpLU0N2cXAzbWtjUEVEVktMNjFV?=
 =?utf-8?B?QTAwVmdVNVRPUnNlaFFqWHowWFBSNHl4Tmt0V2NESlRlL1BZcE81R21vbUNq?=
 =?utf-8?B?UUpXd1hoK3pLNnZBa1hFdHZENmRVNUZHZDRaTlVNODZFbmVlQTRsQU1mdGJX?=
 =?utf-8?Q?3E4M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99752bb1-5fbf-405b-7f48-08dcc05b580b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 14:29:33.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HconWhPZpXCjhL9UUIndn3OqJLJESVXdc1vXph8sKb56l9Nb/lHqujMQT05qeteb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

W1B1YmxpY10NCg0KVGhhbmsgeW91LCBKaXJpLCBmb3IgeW91ciBmZWVkYmFjay4NCkkndmUgZHJv
cHBlZCB0aGlzIHBhdGNoIGZyb20gREMgdi4zLjIuMjk3Lg0KV2Ugd2lsbCAgZm9sbG93LXVwIG9u
IHRoaXMgc2VwYXJhdGVseSBhbmQgbWVyZ2UgaXQgYWZ0ZXIgeW91IGRvIGNvbmZpcm0gdGhlIGlz
c3VlIHlvdSByZXBvcnRlZCBpcyBmaXhlZC4NCg0KVGhhbmtzLA0KUm9tYW4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVs
Lm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMTksIDIwMjQgNDozNyBBTQ0KPiBUbzogTGks
IFJvbWFuIDxSb21hbi5MaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gQ2M6IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4g
cGVuZyAoTGVvKQ0KPiA8U3VucGVuZy5MaUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJv
ZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47DQo+IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8u
UGlsbGFpQGFtZC5jb20+OyBMaW4sIFdheW5lDQo+IDxXYXluZS5MaW5AYW1kLmNvbT47IEd1dGll
cnJleiwgQWd1c3RpbiA8QWd1c3Rpbi5HdXRpZXJyZXpAYW1kLmNvbT47DQo+IENodW5nLCBDaGlh
SHN1YW4gKFRvbSkgPENoaWFIc3Vhbi5DaHVuZ0BhbWQuY29tPjsgWnVvLCBKZXJyeQ0KPiA8SmVy
cnkuWnVvQGFtZC5jb20+OyBNb2hhbWVkLCBaYWVlbSA8WmFlZW0uTW9oYW1lZEBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogUkU6IFtQQVRDSCAxMi8xM10gZHJtL2FtZC9kaXNwbGF5OiBGaXggYSB0
eXBvIGluIHJldmVydCBjb21taXQNCj4NCj4gT24gMTYuIDA4LiAyNCwgMjE6MzAsIExpLCBSb21h
biB3cm90ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gV2lpbCB1cGRhdGUgY29tbWl0IG1lc3Nh
Z2UgYXM6DQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tDQo+ID4gZHJtL2FtZC9kaXNwbGF5OiBGaXgg
TVNUIERTQyBsaWdodHVwDQo+ID4NCj4gPiBbV2h5XQ0KPiA+IFNlY29uZGFyeSBtb25pdG9yIGRv
ZXMgbm90IGNvbWUgdXAgZHVlIHRvIE1TVCBEU0MgYncgY2FsY3VsYXRpb24NCj4gcmVncmVzc2lv
bi4NCj4NCj4gVGhpcyBwYXRjaCBpcyBvbmx5IHJlbGF0ZWQgdG8gdGhpcy4gSXQgZG9lcyBub3Qg
Zml4IHRoYXQgaXNzdWUgb24gaXRzIG93biBhdCBhbGwuDQo+DQo+ID4gW0hvd10NCj4gPiBGaXgg
YnVnIGluIHRyeV9kaXNhYmxlX2RzYygpDQo+DQo+IFRoaXMgdXBkYXRlIGlzIHdvcnNlIHRoYW4g
dGhlIG9yaWdpbmFsLCBJTU8uDQo+DQo+IENvdWxkIHlvdSB3cml0ZSBzYW5lciBjb21taXQgbG9n
cyBpbiB0aGUgd2hvbGUgYW1kZ3B1IG92ZXJhbGw/DQo+DQo+IElmIHlvdSBpbnNpc3Qgb24gdGhv
c2UgW3doeV0gYW5kIFtob3ddIHBhcnRzLCBzb21ldGhpbmcgbGlrZToNCj4gIiIiDQo+IFtXaHld
DQo+IFRoZSBsaW5rZWQgY29tbWl0IGJlbG93IG1pc3JldmVydGVkIG9uZSBodW5rIGluIHRyeV9k
aXNhYmxlX2RzYygpLg0KPg0KPiBbSG93XQ0KPiBGaXggdGhhdCBieSB1c2luZyBwcm9wZXIgKG9y
aWdpbmFsKSAnbWF4X2ticHMnIGluc3RlYWQgb2YgYm9ndXMgJ3N0cmVhbV9rYnBzJy4NCj4gIiIN
Cj4NCj4gPiBGaXhlczogNGI2NTY0Y2IxMjBjICgiZHJtL2FtZC9kaXNwbGF5OiBGaXggTVNUIEJX
IGNhbGN1bGF0aW9uDQo+ID4gUmVncmVzc2lvbiIpDQo+ID4NCj4gPiBDYzogbWFyaW8ubGltb25j
aWVsbG9AYW1kLmNvbQ0KPiA+IENjOiBhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tDQo+ID4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBSZXBvcnRlZC1ieTogamlyaXNsYWJ5QGtlcm5l
bC5vcmcNCj4NCj4gQ2FyZSB0byBmaXggdXAgeW91ciBtYWNoaW5lcnkgc28gdGhhdCBsaXN0ZWQg
cGVvcGxlIGFyZSByZWFsbHkgQ0NlZD8gSSByZWNlaXZlZCBhDQo+IGNvcHkgb2YgbmVpdGhlciB0
aGUgb3JpZ2luYWwgKDRiNjU2NGNiMTIwYyksIG5vciB0aGlzIG9uZS4NCj4NCj4gTm9yIGFueSBt
ZW50aW9ucyBpbiB0aGUgbGlua2VkICMzNDk1IGF0IGFsbC4NCj4NCj4gSSB3b3VsZCBoYXZlIHRv
bGQgeW91IHRoYXQgNGI2NTY0Y2IxMjBjIGlzIGJvZ3VzLiBJbW1lZGlhdGVseSB3aGVuIGl0IGhp
dA0KPiBtZSBhcyBpdCBkaWZmZXJzIGZyb20gb3VyIChTVVNFKSBpbi10cmVlIHJldmVydCBpbiBl
eGFjdGx5IHRoaXMgaHVuay4gSWYgSSBoYXZlDQo+IGtub3duIGFib3V0IHRoaXMgaW4gdGhlIGZp
cnN0IHBsYWNlLi4uDQo+DQo+IEFuZCB5b3Ugd291bGQgaGF2ZSByZWNlaXZlZCBhIFRlc3RlZC1i
eSBpZiBpdCBoYWQgd29ya2VkLg0KPg0KPiBHaXZlbiBhbGwgdGhlIGFib3ZlLCBhbWRncHUgd29y
a2Zsb3cgYXBwZWFycyB0byBiZSB2ZXJ5IGlsbC4gUGxlYXNlIGZpeCBpdC4NCj4NCj4gPiBDbG9z
ZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM0OTUN
Cj4gPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEuc3VzZS5jb20vc2hvd19idWcuY2dpP2lkPTEy
MjgwOTMNCj4gPiBSZXZpZXdlZC1ieTogUm9tYW4gTGkgPHJvbWFuLmxpQGFtZC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRmFuZ3poaSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJvbWFuIExpIDxyb21hbi5saUBhbWQuY29tPg0KPiA+IFRlc3RlZC1ieTogRGFu
aWVsIFdoZWVsZXIgPGRhbmllbC53aGVlbGVyQGFtZC5jb20+DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBSb21hbi5MaUBhbWQuY29tIDxSb21h
bi5MaUBhbWQuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDE1LCAyMDI0IDY6NDUg
UE0NCj4gPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBXZW50
bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+OyBMaSwgU3VuIHBlbmcgKExlbykN
Cj4gPj4gPFN1bnBlbmcuTGlAYW1kLmNvbT47IFNpcXVlaXJhLCBSb2RyaWdvIDxSb2RyaWdvLlNp
cXVlaXJhQGFtZC5jb20+Ow0KPiA+PiBQaWxsYWksIEF1cmFiaW5kbyA8QXVyYWJpbmRvLlBpbGxh
aUBhbWQuY29tPjsgTGksIFJvbWFuDQo+ID4+IDxSb21hbi5MaUBhbWQuY29tPjsgTGluLCBXYXlu
ZSA8V2F5bmUuTGluQGFtZC5jb20+OyBHdXRpZXJyZXosDQo+ID4+IEFndXN0aW4gPEFndXN0aW4u
R3V0aWVycmV6QGFtZC5jb20+OyBDaHVuZywgQ2hpYUhzdWFuIChUb20pDQo+ID4+IDxDaGlhSHN1
YW4uQ2h1bmdAYW1kLmNvbT47IFp1bywgSmVycnkgPEplcnJ5Llp1b0BhbWQuY29tPjsNCj4gTW9o
YW1lZCwNCj4gPj4gWmFlZW0gPFphZWVtLk1vaGFtZWRAYW1kLmNvbT47IFp1bywgSmVycnkgPEpl
cnJ5Llp1b0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMTIvMTNdIGRybS9hbWQvZGlz
cGxheTogRml4IGEgdHlwbyBpbiByZXZlcnQgY29tbWl0DQo+ID4+DQo+ID4+IEZyb206IEZhbmd6
aGkgWnVvIDxKZXJyeS5adW9AYW1kLmNvbT4NCj4gPj4NCj4gPj4gQSB0eXBvIGlzIGZpeGVkIGZv
ciAiZHJtL2FtZC9kaXNwbGF5OiBGaXggTVNUIEJXIGNhbGN1bGF0aW9uIFJlZ3Jlc3Npb24iDQo+
ID4+DQo+ID4+IEZpeGVzOiA0YjY1NjRjYjEyMGMgKCJkcm0vYW1kL2Rpc3BsYXk6IEZpeCBNU1Qg
QlcgY2FsY3VsYXRpb24NCj4gPj4gUmVncmVzc2lvbiIpDQo+ID4+DQo+ID4+IFJldmlld2VkLWJ5
OiBSb21hbiBMaSA8cm9tYW4ubGlAYW1kLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRmFuZ3po
aSBadW8gPEplcnJ5Llp1b0BhbWQuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBMaSA8
cm9tYW4ubGlAYW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgfA0KPiAyICstDQo+ID4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQNCj4gPj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9tc3RfdHlwZXMuYw0KPiA+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jDQo+ID4+IGluZGV4IDk1OGZhZDBkNTMw
Ny4uNWUwOGNhNzAwYzNmIDEwMDY0NA0KPiA+PiAtLS0NCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMuYw0KPiA+PiArKysNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMu
Yw0KPiA+PiBAQCAtMTA2Niw3ICsxMDY2LDcgQEAgc3RhdGljIGludCB0cnlfZGlzYWJsZV9kc2Mo
c3RydWN0DQo+ID4+IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlLA0KPiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgIHZhcnNbbmV4dF9pbmRleF0uZHNjX2VuYWJsZWQgPSBmYWxzZTsNCj4gPj4gICAg
ICAgICAgICAgICAgICAgICAgICB2YXJzW25leHRfaW5kZXhdLmJwcF94MTYgPSAwOw0KPiA+PiAg
ICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgdmFyc1tu
ZXh0X2luZGV4XS5wYm4gPQ0KPiA+PiBrYnBzX3RvX3BlYWtfcGJuKHBhcmFtc1tuZXh0X2luZGV4
XS5id19yYW5nZS5zdHJlYW1fa2JwcywNCj4gPj4gZmVjX292ZXJoZWFkX211bHRpcGxpZXJfeDEw
MDApOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgdmFyc1tuZXh0X2luZGV4XS5wYm4gPQ0K
PiA+PiBrYnBzX3RvX3BlYWtfcGJuKHBhcmFtc1tuZXh0X2luZGV4XS5id19yYW5nZS5tYXhfa2Jw
cywNCj4gPj4gZmVjX292ZXJoZWFkX211bHRpcGxpZXJfeDEwMDApOw0KPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IGRybV9kcF9hdG9taWNfZmluZF90aW1lX3Nsb3RzKHN0YXRlLA0K
PiA+Pg0KPiA+PiBwYXJhbXNbbmV4dF9pbmRleF0ucG9ydC0+bWdyLA0KPiA+Pg0KPiA+PiBwYXJh
bXNbbmV4dF9pbmRleF0ucG9ydCwNCj4NCj4NCj4gdGhhbmtzLA0KPiAtLQ0KPiBqcw0KPiBzdXNl
IGxhYnMNCg0K


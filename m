Return-Path: <stable+bounces-213071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDjTAq6zgGl3AgMAu9opvQ
	(envelope-from <stable+bounces-213071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:24:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359BCD4E0
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E298308F2B4
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB536C0CD;
	Mon,  2 Feb 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wqvIWvz6"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CD1F3B85;
	Mon,  2 Feb 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041849; cv=fail; b=Qj64+3QWvHz6ky+w4uiQQ0ICWOttIZGw66gFvkxQVl4Ec7N7/EpO6cTSm5FDD4QbrLdnBuzWJrJ9IJHMIVO4bkwxw95GuUVifvTfDPnIiSBi847+xR3sKNiB3/iFfahhGAr7dGTlrHcWncdjqEtOE6x2pmvRaZhELsz0fy73Pok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041849; c=relaxed/simple;
	bh=0CKzzqAjSP9nmC+mCFVls08jKx7d1z9vUlxjxeNuHGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fs8UToa+eJzcwwIll6LC310LIkMLCwGuVbgbsNjn92WLI6aT/nxQ7wIZZzIha5NMa+T7bhlSi9UeFTGPpX4xVid7PRWnHrunyVGFch7nWBQ91MHMM/jovCQ2AmMZVWwY5EAUUX2qUFihfv/w3zA/NDwnkRNjo6ZoKkywjrFY+BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wqvIWvz6; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syUiygp5Zf5lWJjy4MIicaMja712br6W4fjrgIk9pBTkn1FE/KxP+dFYFpckMoelaS1J4MvGPgGMUt3BLoW6E1LcL1sWXon+vQqAdDVWL32mGCeAa7sfpECTmDfRTv+SHPqyEtyQCJc7475L71Y/z+y3yVOZlL/RTmOxHgp+gaI8jlf7VFq0l0aX1i4orHKEnv6w8Kg/37n/AArDdQu3mQkupEAoQpMiDuKx5uYXEboe/DBDU4bmNKtIi2RCFdoBvuH1mS3nEJtgaHpoChptTF2re765QkaddniOYhqL6J46YMadJ+BXwBqE+GKYczIKwn3jq9YnTh/+1G9AqLbfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3KRrjBxBxgAnzp9aKYq+WKAhQiYOWXudIyygH/A/UY=;
 b=XZYhZxdI36yqYFn8Gt4iR0/XC7+90KAUblwCbUg35BBhDhUpo4kXPpDeMgrz9XxoXJpTbMrMy03JI4sj5k9FeodT9TyOTAi9nFjYgskxZMxq4eP2Uj7kUsookI9FR0DoQZwDEwYXpfeMmY0bqAx4ymlrVjSg87ZVON4fKQYwNaBO/qt9n5+w9dNSamLiXV5VLrsXMG9mHNjyQQNqrX7YjCj9Uj2/TODk4FbrZqyutFfyn4VWcHCFxK+W4/LGnUWWyqZruTJjXB289rIJVGGvqnUtgjlJx96+F3dv98lA/OLBe80sug7Pe4kE3blFmmNsQvI1DWkTKV+k04Ld+2bQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3KRrjBxBxgAnzp9aKYq+WKAhQiYOWXudIyygH/A/UY=;
 b=wqvIWvz6h6EuNJHHn9v4Av5xqeWSyhwUm8oJjk/w0CSiE93vZ6QelHsw4ttL17G9mCED2u7ncI2pUuv+ZHaC4JHvgjfM/uXx5IiKQTqPyu5Nhbx+j3QRKhz8/olV/xw4cFak4FQG+OpBqlTHypMim5tB7TSGUBdNamoXxj+KH64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:17:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:17:23 +0000
Message-ID: <9bbeae98-279d-4b8f-bc52-f535851f497d@amd.com>
Date: Mon, 2 Feb 2026 08:17:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
To: Kurt Borja <kuurtb@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Olexa Bilaniuk <obilaniu@gmail.com>,
 Dell.Client.Kernel@dell.com
References: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:805:66::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f17aa3-b9bd-4757-b31f-08de6265c8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUNIY1ZFQkJpb1pVVjhhMlZmeDZubFZMekFwMk1PMjZQQ1VqdWorUDB2cVln?=
 =?utf-8?B?SGN5N2xJOW12aDgwNlN2MS9tbUtsVXowMEt5RGlMeVlnMUV1Y0lId2xvNlFX?=
 =?utf-8?B?R1k4WWs1OS9QK0dDTDQvNHltY3FJQWlaN0Q3TE15ZzNZMkd2ZXJudE1uS0x6?=
 =?utf-8?B?ZjZyU1R4RlZ5QXFzYXd6UWlKWk5FY2ZqT0tPZDlQTmNuek01OWJvT1ltaTdi?=
 =?utf-8?B?Y29RS2hyemZoS09qQkVvRllINjJqd1EwTmNOZHdxRjhYYXZrZldSanlHWStZ?=
 =?utf-8?B?MzlQMVY2cXEyTzd0T0QrTHdWc21CMUxZYjkvTVVCTTNsTHBOWjJTNElHVmRS?=
 =?utf-8?B?UXYvMmp5QS9iTnpycjJBL3BCQzkvTEg5VFMzYlJnU2lmUkIyOFBvYVhIaEhD?=
 =?utf-8?B?dHZxckhFTFJqS2tPSUVKYURTZEVMa2JYclNGU1BCdkFGZFh5bWFYNDY5TTFQ?=
 =?utf-8?B?cTMwejdrd0tkWi9PV2NYcENuTXJjZnlGeWpSc2JUdnBIVDdURjd2Q3Z4aFhD?=
 =?utf-8?B?MUhSQUZjNzNzSEozN1g1Qk51WXVIaktEcHhtNUlOYkJKbkNSZHQ2NlVqSmpC?=
 =?utf-8?B?TEozVGRRWllrcmw5SkZ2WjhDUHhEajc0NmluSDVNUFpRbUNYNWx1cmo5Vm41?=
 =?utf-8?B?MGtoREhlWHphYVA0Rk8vWmVrRUNjM1M1TTIzNzVWVlRnMzc5Y0xZZzJnd0J3?=
 =?utf-8?B?akVDZkNXSXBpVkNRSDE0dGQxNWZuR0ZqWGlZaVlCYWNoSEVTTWxHd2dIZmlY?=
 =?utf-8?B?S2xmbnNsM0Q4U0kzUFF5RlVjb3NJaGRLaGhMMjYzVnlmS1ZSVkdpUDExWEsx?=
 =?utf-8?B?NDF6REp5VDZTVTlUaVY3UmdPOTIzeXN3NkdxOXA3TUZDYTJBVnBQM1Q2N1NU?=
 =?utf-8?B?Wm03TGhiWUJxdzRIbExkNlJPdEdack9CNjFRTkNHRjV6a3hFL1daK2lvb0dv?=
 =?utf-8?B?UkR1MDgvblBrUFBNeHp5NVRYV1lpdTlwY1lSTkE3WDIvZlVZeGlJUlkwc0Nv?=
 =?utf-8?B?TjZMWkRQYm9tc0trbXlQWkxWUFI2K3JESlZraEFWMGhqYVJ5U1dKVWpDbVFo?=
 =?utf-8?B?RHpsZnlxR1VLcWluN003MTRwblNBTjhTUllKQkZxeDZMOTZ4cTRRMy9sSll1?=
 =?utf-8?B?b0x2TVpSeDYzbVJramRGSmtHeEYyUDJ0ZVl4RU1iMERIbEpuclJ3bjZvUHdB?=
 =?utf-8?B?Qmg0cGlqdnVvREpyWU9GcGV1UElhN1dCd1FvMUptOHVZMWtqc1puRmNkSlBX?=
 =?utf-8?B?U1pxS2NjRDNDbEI4QXU5MFZHckN5QlNrUGl3ODl6RW9uT1FqWFJCM2pqMXVW?=
 =?utf-8?B?c3JpNjNucGtwbGpiSWwrbURNZ05LQkhSRnllZVo3bEd5c3RmUGF4WXQ4d2tI?=
 =?utf-8?B?RUROck0yOFFkT2Y3Vm9lSUY4VEN1OUY3bjlLTDRBenVFdGRBc2tlOTdmclVw?=
 =?utf-8?B?M1Uyc2dncWlxRE1hYW9zZDBUelFwdDZqNGVXd2JQM2R4TXJlYUY0UjlpOUd2?=
 =?utf-8?B?eFk5Qk8vbTdKb1IvOVh1NHE1cnlNU2pLYjRib1AxWnp1cXdHUFoxdk5LQjJu?=
 =?utf-8?B?Uy82elBuZG81QWFjOWNvUFZ4ZUhzbzBPN2w3c2ZmSGJtenUzMkdsMnpUS0Er?=
 =?utf-8?B?WXZXRDJjU3lYRm9kWEtib0hqZ0gzZzAzUHBDZldBbmhGL21CdjJTc01GVEV3?=
 =?utf-8?B?WU5BU1JtUWh3ZVRnQytva2dPR24rbHlTU0RPZjVTYXk5UXpaM1doY2sxN09D?=
 =?utf-8?B?UjlLWEZiaHliMG1FK2ZXQ0o4TFk0bGxSN3h3Q2I1MXVvLytpNW9ValFoV3dr?=
 =?utf-8?B?U01VaTVSWTRJeEkrZnVNVURIVTNvdUFxQkZ4UTh1dkh5VnNxRWJQUk1rQjJN?=
 =?utf-8?B?NWFMdGZpWWRIRTJpZ0psZlVOY1VKMW9yM3huRnRFNUdZZTNzYWlyaTlUV3hq?=
 =?utf-8?B?ZThSNTkwVGxKMXJFdXhJclhHNWlaa2lVYnR6NitBZUsvcTlHWG9GcjlGSVlj?=
 =?utf-8?B?akI0SEUvNXJPS2pWUWpNYm9iRnVscENzckJCUmVmNXRnMlI0OWp2SzcwNmZW?=
 =?utf-8?B?WHJtUlF4cUMwT3F1eWJGL2JDMm0xQ3lFSTNLeGhrR084a1JLNjBjRE1YcThp?=
 =?utf-8?Q?+Nn8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFvU2RoQ0tJWDJxVlhVVWVTeElUd2ZHWTl1M3BOV3FLaXRNN0JTNGJZaGtv?=
 =?utf-8?B?MHhOREpqaEV5S0FRdll1TThycVdsTndjNDczVVk0UldqUE1lWGRmWitFc0RK?=
 =?utf-8?B?MXlIR3JhYmt1QVlMTERZeWxoT0tvelQ1ZVpPMTlIQUp5a2VXNGFjRmpKSDh2?=
 =?utf-8?B?Zk80MjR2YWpoTHVqd05MUEFJdFFZUnhrSisraGMzSTRKQm9obUllV1RJaDN6?=
 =?utf-8?B?UmNGT2N3S3JMZVkyNjRWcjFjaWpibjBidHVvK1NWYnpvUlBBTkZBUEppbjJt?=
 =?utf-8?B?RkJuMzMvTWN5NEgyd0hTSythY1g3aS96T0pZZXZUeWg0VDNvUHRISG55amNM?=
 =?utf-8?B?dWFCMEsvZnQxaXRYcjU0SE44ajlnMTVCTmcxdjhBWm1lRWZ0czRGa2F6WGpP?=
 =?utf-8?B?OXI2L3JtbzVMUjZWRERBalhBOEUyUDhnRFI3OTZ3bTJxRVU2UitaNUZWSFUy?=
 =?utf-8?B?d3N3bEN5Y2J4cnROVDZUdmJtSndIU1dLdFp0K0o0Y2dnRWljQ2N6bnc4azBl?=
 =?utf-8?B?c1RpTEdJWVRxTlRwU29XcEN6NmlETkxGRjE2dXNGd1pIOGt6akRIRWJWMnhy?=
 =?utf-8?B?VTRMRU5NMFJ4MC9WenBxY2V1cXlibm12aHR2b3RHVkt4WUxjbFIySStrNXVa?=
 =?utf-8?B?MFVlS2xqeHJBVDNKdk52Y0grZng3YUlONDVmemh6Yk5BR0FEcU15UFVjUGR1?=
 =?utf-8?B?SEtGUlV5Q0VuU0NKSVFYdlJIVFNNekdFRGlJZFhDWE1GMytYZHdhalRXT00w?=
 =?utf-8?B?TWJlS0NlNXRKOEliV3cvWktvRHNCUUNTVm1uSzUzWjlCVVUwZndwUGVEaGdh?=
 =?utf-8?B?QlgwTis4UDVQRDRyNnBpa28xck5Jakd5UGdBZVFDN3I0bk1mWXlWU0U2bmFq?=
 =?utf-8?B?S3o3N1ZUU3R3K01odWxWWEhMaFAxMzhHTWxERkpNM2NHUW9hT2tJVGhhbXFZ?=
 =?utf-8?B?dFgzTGdOSVJuRUdJbmJFYW9Ma1ZweXdwdzAxNkI0Nng5NzJ5TExYcnc0cDZm?=
 =?utf-8?B?ZXk3aUsxQVJJb2VzaG16TzlLM0wrd3RDQVBwL3B3RFRWRTRGNTUramh3NlhE?=
 =?utf-8?B?YUdmQkhWUFVhRUROd29oK3NsMzdGVzl6TjZOeGVYSUlWd0VtSGtRWUdMRGtD?=
 =?utf-8?B?bVNKbk1FUnNnNWFDSExTWXNxL1dCUEU5aG11dGVQNlpJYzBJeDFseVNTSGc5?=
 =?utf-8?B?aWQ5VzlGcHNHcWY0QU8vcjh3Qy9oZDAzM0NVV2dQZjUxdGRPM0hyeERIeURC?=
 =?utf-8?B?Tld5QVFCQ0lJZ2dYTVAwZjFGZDN4M2UrOVMySjJIcTVGeDZHR0d2cEhmMjNV?=
 =?utf-8?B?L1hCN0s3dTI2aGc3aUVwcHVCYzdUUzRQZ3dtamVpbzJUaWQ4RkR4VTZtL0pL?=
 =?utf-8?B?cVFFalJBUVpPRUFVRitwRi9hZm8xbTR5TlR4VlIyYWgxNjRmNFkrS0lYSkNB?=
 =?utf-8?B?N1BDQkdPZ2lCc1FFSFhjSlBhYVRSVDJvb3F6cmFENmVPd2wwMmd6OCtwbjRW?=
 =?utf-8?B?Y1loS2h2TEs2UTJQYlNjTEc3VDdqTU03bjNOVUVIS2NPTTNXaUMweldVZnl2?=
 =?utf-8?B?ZmpHcTN3S05EeXYybHc3ZzFjOW1RY1BRa2xHaHgzWWFOYk9qSXBLU0MvVThK?=
 =?utf-8?B?UGliLzgrMHhWNGpKK1FobDlYcVlFYnVWcEdUSWU2alJDMWdYbjNTSVltL0Zt?=
 =?utf-8?B?cXhaT1ZUOTZidkI2RmpYZndBUXBpOGUzNUdya24xL3Bra3d0c1ZOOVdtU1Jr?=
 =?utf-8?B?aUU3c2IyaHUwaU9WU3pzeE04dVpBdnBXbXFxWjdNM3c4NjJKaWMzdnNZQmt2?=
 =?utf-8?B?cEF4aWdSVWwvd1ErbjF6K2NrdmtFY3NSR0FhbUhFckphUGdUL3ZqSEljWkV2?=
 =?utf-8?B?UDZpQ05UVFpNQWxNYlM4WnZPQmRtV1FNaUNSOHI5WnNkZFM3UFU5ZmFiakZ2?=
 =?utf-8?B?d1lFeWxaNHlxdGdPTGxDblNXUTdNY1BsUkd1TnZJYmJaby95SXVvSzg1bllX?=
 =?utf-8?B?UlJYa25oajI4Q3JqQ3ArM0lmdzUrUUlNOGphbVlRcVU5VjdBWnAvUW9CRTA3?=
 =?utf-8?B?clc1YkRZQzlCTmJGN3NKcVduZTBTV0tPcU11S0I2SWdsVzh3RGU5RXI1eUVi?=
 =?utf-8?B?R3hTcVhUdjcxRUpvUkhTSjdZK2Q4aEJzVXhtSnhFK21uY2tCWEsycTFVQkN0?=
 =?utf-8?B?TXYzVmszWkhnWG1zUFFKUlFJMFRDTVVsQWNsU3pyekM2N1E3OSt1VFVKR20z?=
 =?utf-8?B?RjErUW85U2RkUDVkbERKMWdWcVJudGhheXMrVGVJOWxFZlpOdWhoUXBXREoy?=
 =?utf-8?Q?TY8EG/PvJ9EQvlYM42?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f17aa3-b9bd-4757-b31f-08de6265c8a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:17:23.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnPFQDK/QQ0XOaGmBRduxRfy0nGs4EsW3j4/GJ3VIqduwgJKHAASSxQf+USIFLJtKWaiLPNAPiwtunEDDaoQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dell.com];
	TAGGED_FROM(0.00)[bounces-213071-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,srcf.ucam.org,kernel.org,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6359BCD4E0
X-Rspamd-Action: no action

On 2/1/26 10:37 PM, Kurt Borja wrote:
> Add audio/mic mute key codes found in some Alienware devices.
> 
> Cc: stable@vger.kernel.org
> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
>   1 file changed, 3 insertions(+)

Make sure that you include Dell.Client.Kernel@dell.com in case they have 
any comments.

I added them to CC.

> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 28076929d6af..62cf28d1fe19 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -86,6 +86,9 @@ static const struct key_entry dell_wmi_keymap_type_0000[] = {
>   	/* Meta key unlock */
>   	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
>   
> +	{ KE_KEY,    0x0109, { KEY_MUTE } },
> +	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
> +
>   	/* Key code is followed by brightness level */
>   	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
>   	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> 
> ---
> base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
> change-id: 20260126-mute-keys-7f8a27cd317f
> 



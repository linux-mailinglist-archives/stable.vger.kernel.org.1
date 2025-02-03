Return-Path: <stable+bounces-111995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BCAA255BD
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BE9162A71
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9EB1F5428;
	Mon,  3 Feb 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ghdK8bBs"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB47288B1;
	Mon,  3 Feb 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738574587; cv=fail; b=ksx5a+tuJIlNTKLJGh/O5w1RqiuFolrX/01QZc2+DDkwKWo2Ky0pDrhUuOLiJ3qx8iJjsMnrr7IeXpcS+6M0gM7alHCdQ2P4xPX8+DWLlxoBWnKF+OvpW5ojA3tVco65H7rb/Q16TdVF6ZBi9C4Z8LXFJJWFUqEjVHDEaKbg6ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738574587; c=relaxed/simple;
	bh=3tfAbTX0Ge3h6wiNZAI6wEmiq4wZIwoizQUYG+XFqFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtDHCMXkIlY2q6EjF2nAglaHSNstwBOHYREuO3hq8TwdcHcX2so3Y3Hk+Ae1qW35ZxJqEVxdSRZbvgh6bfPjtVzfCr7Q7cTohawj5fKziGx3Qdf2lld4kDf4fatipGy7RYa7GcqLUZLgm70/RccURO6ihxcoLPTu3W7bVdEdwYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ghdK8bBs; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2JvWb0WO9gwuF9PEl2A2+ErK8AGUMnNTvyA4qC3Jo+R9v37TTIX6oWHPKZUUl6gShTOfdhormC9A0afBEPmXR9nbzYi8KyyrBm7/WOrd9Apceg6L73WWTogmNTBo6qNzhuzsmjsYH7kapWWo937K1gKF4h3fj7sRB5UUeQCESEvq+f43GsTzX1X3+e4kcG9xQF+lxb0Zxvuxt/METkweOarX80LJQBvh8eqgqK94GqEN+E07oW6Fi2D1nXGvxFdR1iBSx33uPmb+meabGqwLj5w0wlROfgxPwKzSjrjOSDluNUphGK2y3xwonCP7LBt0TyqVNrwVG9sbsNMcBIUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryc2bSU7lfId8jO9v/AGx+Fx2lAjHkzyRL64MHgEnsA=;
 b=nZIAii8gJGjo5xkfbLCVKz9KGfEYYvEm2ucqcMMl3gD/d0gE61dS83XWFvoDmzsfROGZJSwZt2NKMql5Jp3B4kOscs5/ALz4laH4xeijXIkvGeCaMvradvnh1DhmFlCD35VS+XdwXkJypWGrWfq9GR1rbicEV43Rjbg7HnzSNBGsN/aEsXQAVFX9qrz71nCTRsHzKiMeMOJJUWrSbKE8jIQHd6kwP/rwx5uUUpS+6Yri6tStrfiyhpYnFlCkn1puaYxzHM0ZKbg2K4I3nVQ1SwTvgKQjvcPyWSAZFk8Z6l5ZvXekAEncaBB/L4RYI7gpOT8RVmz18VlnXsAtAeHagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryc2bSU7lfId8jO9v/AGx+Fx2lAjHkzyRL64MHgEnsA=;
 b=ghdK8bBspe4Vcr3W5P2CLy9PM7pS8s2ky0oH0zmpVy2/a4TIUCLSFBkbePc34SzEhAP2rbT0wdLuBqDs5jg4LOk/JO3TE+hlbU0Djro1+fagTdP9ogcgjZsKwCZcPs5DpOXbjQe7Bl84jUardAIqXTVN3mLo3nLWPfFsogKn9vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 09:23:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:23:02 +0000
Message-ID: <36c6750c-6bc1-4b56-bc9b-3c27ca23b8b6@amd.com>
Date: Mon, 3 Feb 2025 10:22:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "drm/ttm: Add ttm_bo_access" has been added to the
 6.12-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 matthew.brost@intel.com
Cc: Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250202043332.1912950-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250202043332.1912950-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: dada39a7-7e6d-496e-b40c-08dd44345bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkpCK3V1a0l5U3I0dVFtVHIycWdrYnhsdStTMzZjNzN6cjM2SzlSMXVIZ0t1?=
 =?utf-8?B?S1M0OCtjcTlLRDhwakJkckppVTNDbzl6bnlwT3pIV2hyNTl6bWhJdHNHT2NE?=
 =?utf-8?B?TmJycUlsRExzZGxZLytWcS9sWEZLNDg3MUFla1YxV0ZRelFkRDJGSzBxT2Jx?=
 =?utf-8?B?cW1GT3Bnc0NSWGxrd3J0WVBrWmsrakRrcG01MGdkczcxMVlFSzRRWmpscHNi?=
 =?utf-8?B?a2gzMEt5UllwbjQ1NGRHQmN1S1AySnNPODljeGgyTC9kN2prWFEzNmhROVVZ?=
 =?utf-8?B?WUlnVHV1ZjFVUDNTZmhBTTNSK3RYc2Q3WmxlSFMwVHoxU3NUMHJ1YVN1RmY2?=
 =?utf-8?B?WXl5ZlR3U2tVbVNKT1hqSTU3SkRjYXhHL2c1bVlOS1JrV1lXaWpJbWlud29U?=
 =?utf-8?B?S2EzL3hhbnZRb04yZ09Qd2M0ZDZtbHlDNzd5K0RyMmc2dXFTV2ZCaWhkeXBT?=
 =?utf-8?B?dEJLOHdZY2VLSzNkR01PWUZGSXowbWovSzVxZGFmT0RRVkNlN2s1TW44UzNW?=
 =?utf-8?B?cGIrbTh4dEtmc3p6SDJ6WkEzL1ZSK09zdXZEanArajQ5eTVKN01scVdaUnFn?=
 =?utf-8?B?MUNaSy9FT0tLVUhLUEl6cmQyQmxyZ3Jpa1M3ekxYL0ljbWxUSlhEbUlZcWVw?=
 =?utf-8?B?VnhsYk1SWFVYamZSc2IvMUU5UmdWYkcwUC9IQzN3YzAyWGpZY0FjcXBrcGJB?=
 =?utf-8?B?UHdTa2xUc0svZWdUQjJUYXhBSmRzRXBOK1JtVDJEeTZvQjgzL2lPL0JvTExO?=
 =?utf-8?B?WmNCcU92c3BSZ2FIcXptRmgrVmxnTm1iOVlwM0lqOWIxTVFGZS83VGtKTFMx?=
 =?utf-8?B?TUJKa1RoenA3Y3NSR29sZlJpbVI4WXBFY1RDdWJTNHNIdE8rZUgvdzBQS05W?=
 =?utf-8?B?ekFsNkk1MlBMNXFralZvaFVPMVBCYjJUdndULzhkZFlUUU1tTXg5WDBHRmoz?=
 =?utf-8?B?ZEErYTZVTENYNGdRbDRWTHorU0J6VHhTMklsUXAxWGFSYTNsemVtZG5lZGR0?=
 =?utf-8?B?OVNUVDQvdWFJOGk4MGZ2L3ZPc0d2SFM3bWp6dUU3TkJWK2padlJJZnRQOTNQ?=
 =?utf-8?B?WVdDS0pNYzFsdUtOdWFVSmxGZ2RiNDZscGJZMG1ySTNLN3NCZUNsQmd5Q3dH?=
 =?utf-8?B?MXo1eFAzRjY1ajB6MmZoTlBjdHYrMDdpSURrSk1lMGlTRUNhNmRPVXdFUkd1?=
 =?utf-8?B?UlBqVEVtRFBBOWZSMWtjdGNoZWtwWjN2eDZNY0RHeDRCM2xOR0dCb0kvSEFh?=
 =?utf-8?B?Q25PaDBlQ3BUSUxtb3dnb3ZjZkowb3VEU0R0TXNXUmFYSUpTNlJsR05qbFUw?=
 =?utf-8?B?aEJVZnVtWUVuQUg0eWovZndjNW1mVkVjbm1nUmZVTG5IWkl6V29GZmZVSHdE?=
 =?utf-8?B?ejVYMzR5aEdtc2tDV3NBN1RaUU1BUHQrZVBFY0dxc1N2M09zdDZmS085cHMw?=
 =?utf-8?B?OERpL2NWcENsclArWk9CVWwyNXdwNmpvRFZ2UDMxd0xZd1lUQzU1SEJ5Mnhm?=
 =?utf-8?B?QTRsdVhrcWIvdENYMitxSkZ2RDlyeDJEUmZCQlJ6TkEvS1RtamV2NDBDSnRn?=
 =?utf-8?B?eDZuMVEySkY2eWR2VnozYWRUL1dMMDRjVE02U3duUjRqc205bGlNd2FHWUZG?=
 =?utf-8?B?aUJMWjhteVJNWk5jQ1pXOWVqN1ZVM1c4OC93VWFrUUdHMmxObmNQK0hZVGpo?=
 =?utf-8?B?NHBUazBySFk2LzlPMmFZa0hybWZoZ3NOY0U1dW1NRGtEQ0ZkanV4ZlI5djhY?=
 =?utf-8?B?M3ZBZHZTUm9LQU55RTQzTGREZWRDVWVycGFUcDRsQ05SWVI1bnovdEMwdEo3?=
 =?utf-8?B?ZzBKRUp5VzFKb0h6R3BSdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnI3cWFQd0tZOWJ0VHRxKzZ2L1BjTEhhTlh0Rk9CRVQybWk4Y1Eva1V1VU9w?=
 =?utf-8?B?RzBzc0hpdXpOK1BKSjFodEJBNE5KUTZOeXgyaEhMRXU5QWxFK1l3SjQvd1dw?=
 =?utf-8?B?eXZkbHZBZGJzTnpZV2RmTVczd1E1QWlBU0R5RXFad2RGdjBCQzU3UnZGWURS?=
 =?utf-8?B?N1NGQVNUK2k2NWtvV1pVQ1F6dFFyNGg4TXZMRVZNR1J2YU0wQkFNYlBLY1NF?=
 =?utf-8?B?bURtZllWYnhRUWpsd3ZrbzBMYkNCVkY2T0Jzam1LQUJtcDZ5a3ZSS01SSUtW?=
 =?utf-8?B?ZC9aV0ZlN1E0KzlKS250MUtkaXR1YThid0VxcUR4SFNXUXJaZjQ3dTN0QU0w?=
 =?utf-8?B?N1MrZU5vTm5qaFhmUndyVTErNDNnL0xxT2JQWXR2NTVjZXpBU0tHbWZkMUhq?=
 =?utf-8?B?VjU2WDREaWlOa2xRM25hVEt0cFJ1Nzd4YW5nbFJJTStUNlpLdWFTRWxPWHcz?=
 =?utf-8?B?YWVlaDFqNGl5VDl1bFd5Q043Qy9ZakFmOHdjYkRNWWVIYVdZNVd4RFRVb1I2?=
 =?utf-8?B?MFlNcS9UUkcwRUVXYjd6bzJHVndMZ2h1R2FtQThLb2ZIZDMvSlhRU01XRmp0?=
 =?utf-8?B?eDcxcmxYbGMvQzVWeU5tRVJadXFicXdGbGRPQTNUM1BvWXQ0L2RqSjFWeGpp?=
 =?utf-8?B?bWtsU25KeFl2Y3ZjZDNZSldGaThwWm8wT2NwSzJJZ0wxU2ZFMGp0Z1FNRU9w?=
 =?utf-8?B?NjNaRmo0TWhMVWQ2UVFvNG5yT3hrVEYzV3JrQnFsNGg0ZWVkSmdpSVlHRUtD?=
 =?utf-8?B?djA3eGRHL3IwdFMyRGg2alBTVjFjeUlZTEN2UllnSGdTSmtjVVh2eWd4TXdw?=
 =?utf-8?B?em92clRlYkFPYUNobkxTQVJLYmJ6VWx6V2tIeVRGM0VJa3ZuNHJ2TldPNXc0?=
 =?utf-8?B?UUh2Rldvanl0UnpiOURuLzFkK3JzMFI1RFFKeU9hekV4QnlaYWs2T1Q5alNN?=
 =?utf-8?B?dERlRVQrL0thMXlRNCtyVW9maU54ajN2TEFrVGhnTEVndGJ4UlhqVlloYnpZ?=
 =?utf-8?B?M2FCMkdWdmRoLzJpMFRLbUl1Sm13UjJGMHppdFp4UVFNM2JrYms4eUVxZmdm?=
 =?utf-8?B?aWJZRXVaOXQyNU93blZZdk5qWTZLdVkyUjJZUWxjQUFmU2Z0VmRCZVdkY0Zq?=
 =?utf-8?B?NWh6ZjRsc3BPdW44ZlhaNU1peFF1TFJqVDE2TEVHbWtSdkc5Q2ozZ0NER0tL?=
 =?utf-8?B?MEJZcmZ6VjZpQUVuTU8vWWdzYndDTXlBR0dtamVmUUl2SWJTWitGQ21RNzhP?=
 =?utf-8?B?VHNMcGpGN2RpWjdOVnJKenAxWGJLQmNKdjBhV24rOEFmbmVramxqZkU5V3BZ?=
 =?utf-8?B?TmNTUnlLUzZKNmMvN0UzTkxWTWgxN1E1OHV6UERVTGdxYUdLWXh3YzNZekNC?=
 =?utf-8?B?WHBEc0xrbTZ2Tk5ZU1RseHh3VkhVOFZGRmxCWXFZdDk4djNPZEpobmQrY1U4?=
 =?utf-8?B?REc3UThNNGF6QWc2b3Z3bW9GOUdNMnphaEZ5TzA3S1o1UVBLeC83UCs4VFBW?=
 =?utf-8?B?a2lud1hrdkZMei8xa003TVFDallwRTV5L0ZBbFhsK1JPdUhuTmF3eW56ZitO?=
 =?utf-8?B?U3hscSt2V2I5RGZ6L0FBZ2tHa3RKT3hKK2h6dkZRMnRBK2RBOGZ0eWJSaXIv?=
 =?utf-8?B?TEJsZGtwMFpPTWZITWpZWWcxR3pWb3hxZTZ4RUhXUGNEbUdoeTVYNTVwYzQ0?=
 =?utf-8?B?RkI2Nml4Y2tJOFFLQVcrV3BSMVFrUHpYTURSVVdUcHJHMEduRnBDaXlOS1V0?=
 =?utf-8?B?U3kzUldLTlplZXNVQ0hBT2NwaWI2Vjk5U2E0cWczNXp0YmY3c3o1Nml6aHkx?=
 =?utf-8?B?YmZCZ2I1ODNZQnRacVBoQ0l6bk5MTWFxaWlaaUFtMm4rMlgzaTBwazNnN0I0?=
 =?utf-8?B?S1Y2dEduemVjRThsSU4wZ1ZkNDFZVkNEKzM5L2s1Z0FZY2Y0blBRaE02MzIv?=
 =?utf-8?B?dVRnV1pMTytzVFpIOHNrcXliM1dWYnBDNkhVTUFyVHZ1blpValZ4cW95azVz?=
 =?utf-8?B?UVRFMmo5eVRhNit2MTFqRWM1U3dWQUJlQjJ0RFcyc1p1c05MVERPSmszZ1NB?=
 =?utf-8?B?azRsdlN1bWhzaGJwVUVqcWNyMU5HRkpZUElKaWdZKzVzVXNyOFVzOXJ0Q21a?=
 =?utf-8?Q?LJT+HSh+rOVdoYSWpWFUZPx11?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dada39a7-7e6d-496e-b40c-08dd44345bb1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:23:02.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACKeRH1/P7WuxwVuWa1ygRc8cEaYc7vqvZBOBIIV7dg+0hSDF7C9n45BPlxjNkX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

Am 02.02.25 um 05:33 schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>
>      drm/ttm: Add ttm_bo_access
>
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

This isn't a bug fix but a new feature and therefore shouldn't be 
backported.

Regards,
Christian.

>
> The filename of the patch is:
>       drm-ttm-add-ttm_bo_access.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 73b922f15552bb5b47cbcca4b4d2b131b89b786d
> Author: Matthew Brost <matthew.brost@intel.com>
> Date:   Tue Nov 26 09:46:09 2024 -0800
>
>      drm/ttm: Add ttm_bo_access
>      
>      [ Upstream commit 7d08df5d0bd3d12d14dcec773fcddbe3eed3a8e8 ]
>      
>      Non-contiguous VRAM cannot easily be mapped in TTM nor can non-visible
>      VRAM easily be accessed. Add ttm_bo_access, which is similar to
>      ttm_bo_vm_access, to access such memory.
>      
>      v4:
>       - Fix checkpatch warnings (CI)
>      v5:
>       - Fix checkpatch warnings (CI)
>      v6:
>       - Fix kernel doc (Auld)
>      v7:
>       - Move ttm_bo_access to ttm_bo_vm.c (Christian)
>      
>      Cc: Christian König <christian.koenig@amd.com>
>      Reported-by: Christoph Manszewski <christoph.manszewski@intel.com>
>      Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>      Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>      Tested-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
>      Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>      Reviewed-by: Christian König <christian.koenig@amd.com>
>      Link: https://patchwork.freedesktop.org/patch/msgid/20241126174615.2665852-3-matthew.brost@intel.com
>      Stable-dep-of: 5f7bec831f1f ("drm/xe: Use ttm_bo_access in xe_vm_snapshot_capture_delayed")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 4212b8c91dd42..17667ab31ad4c 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -405,13 +405,25 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
>   	return len;
>   }
>   
> -int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
> -		     void *buf, int len, int write)
> +/**
> + * ttm_bo_access - Helper to access a buffer object
> + *
> + * @bo: ttm buffer object
> + * @offset: access offset into buffer object
> + * @buf: pointer to caller memory to read into or write from
> + * @len: length of access
> + * @write: write access
> + *
> + * Utility function to access a buffer object. Useful when buffer object cannot
> + * be easily mapped (non-contiguous, non-visible, etc...). Should not directly
> + * be exported to user space via a peak / poke interface.
> + *
> + * Returns:
> + * @len if successful, negative error code on failure.
> + */
> +int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
> +		  void *buf, int len, int write)
>   {
> -	struct ttm_buffer_object *bo = vma->vm_private_data;
> -	unsigned long offset = (addr) - vma->vm_start +
> -		((vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node))
> -		 << PAGE_SHIFT);
>   	int ret;
>   
>   	if (len < 1 || (offset + len) > bo->base.size)
> @@ -429,8 +441,8 @@ int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
>   		break;
>   	default:
>   		if (bo->bdev->funcs->access_memory)
> -			ret = bo->bdev->funcs->access_memory(
> -				bo, offset, buf, len, write);
> +			ret = bo->bdev->funcs->access_memory
> +				(bo, offset, buf, len, write);
>   		else
>   			ret = -EIO;
>   	}
> @@ -439,6 +451,18 @@ int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL(ttm_bo_access);
> +
> +int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
> +		     void *buf, int len, int write)
> +{
> +	struct ttm_buffer_object *bo = vma->vm_private_data;
> +	unsigned long offset = (addr) - vma->vm_start +
> +		((vma->vm_pgoff - drm_vma_node_start(&bo->base.vma_node))
> +		 << PAGE_SHIFT);
> +
> +	return ttm_bo_access(bo, offset, buf, len, write);
> +}
>   EXPORT_SYMBOL(ttm_bo_vm_access);
>   
>   static const struct vm_operations_struct ttm_bo_vm_ops = {
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 7b56d1ca36d75..e383dee82001e 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -421,6 +421,8 @@ void ttm_bo_unpin(struct ttm_buffer_object *bo);
>   int ttm_bo_evict_first(struct ttm_device *bdev,
>   		       struct ttm_resource_manager *man,
>   		       struct ttm_operation_ctx *ctx);
> +int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
> +		  void *buf, int len, int write);
>   vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>   			     struct vm_fault *vmf);
>   vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,



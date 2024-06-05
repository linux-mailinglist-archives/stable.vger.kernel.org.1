Return-Path: <stable+bounces-48237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9073E8FD2CC
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CE2B24A0D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E415F30A;
	Wed,  5 Jun 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="uBvvVeiO"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2092.outbound.protection.outlook.com [40.107.236.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148314D28E;
	Wed,  5 Jun 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604401; cv=fail; b=b2pl9iWk3vv/EPhNtdvPsD5Yvbfmo/xTrreNCLyw4ch6v61ayaRyAjiv+YAcVBV5ijz3+XCNx9cTYMfxUKprx32apjbLVdGNwy4TV4stp6hLEf9BbPmSg8eOTeINi3swIFLR8Qvqj26iZM2YQGsi9Rh2pb+D8xylw4zZRrK9bt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604401; c=relaxed/simple;
	bh=BoAPr8PtDuqHyugB9//aa6jZHCdotpCA3tkZfJQSjLo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gyciPkROIGeVaI6JpxAJYGqW0v4dT9Vy4nk0GZApT1Ci6TOJE5czoNXoQaxTUzZWUCXcLJziWleXD1ra2pXc7ENvOKBazUXB4SKOMzWZOYjvxr2z4PQRGMeNbNV7jAxlQMpDkFzBgWURxInhmZkSy4l9zqWvs56n6Pmhnf6Ds6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=uBvvVeiO; arc=fail smtp.client-ip=40.107.236.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC9eNr1AdnBH7dhY9DDj8LJaJ5SyGA47K1Fuk9zCOxQYt1mPQoXRfP/7sjbYeD2M465UI0wGFLyYv+VprzpShX4ML68fRYVV7l3FgSoTt21jOcINm9zEkcjw8COrr8UEXfeiDh/p1T0lsRBmmaEZWTgh8PDOfR9zVMLUVQC/bEd0v09RnMi73lobSHjohD5Wv57lt9p/rru/akXf6UohNilOGrOqvaAcJBv8KDEFrLVG7Br/Q3qXeFMPqAs6ML5BxHESMuj6bQ+wAzdXNrusPe+u+29IHEEpwQrw4bnxpFC1rnOkV35P55MHRN8rNUpnHydV+KvdQUvv5JtsrLHkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTWo67b4fkgQZBjK4Uxj0NJUzI5cHpqBf7YBhBcLUNo=;
 b=e5bNdVDma2I5/hQwtr8wjJcQ+ut/Ra4W1LVEEIzZQvVy3r0E0ZTJmked91kvUkxFisF+iKWx4UTHSbwTjWNOs7CdBP1AR2hlrtNsYNCtBSKHbQ+mZpCNui7zbsklo/gO04Tj7gXfJaR9KJv7EPSUU20vdKnGAJ8vzqpgkLrzT/pXg5bNtv0lSZJKfb9H2dpI/WO4gjhBsGcUAswPJq4hmmR7JUSRPntCkbCPybs8eJtwFvc2veKQewxMnmMALUyS6dM1rTP1KkMKLjTdaO4RbYjplh4BzwV57Cq2i+HFCo/kAKPy/txt7IMm+jxFx+ogecfuV7Bl8OZOh3vPlI2dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTWo67b4fkgQZBjK4Uxj0NJUzI5cHpqBf7YBhBcLUNo=;
 b=uBvvVeiO9/yO+cn1wgfpnYGtV3R8EB1M2Skga7JhS8R40Ud0dkh92HhpSevSiHDL7yCGA7yWgVl04j2CDbWVjcV5wm9KksYla0lQyMZS73oGZeUxYBw0YXnp8OO/nRMYKlrCdprEWuqLG8YpGV2qeWb8TTQupTZ0mV1+6BCxfiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 PH7PR01MB7679.prod.exchangelabs.com (2603:10b6:510:1d6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Wed, 5 Jun 2024 16:19:54 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 16:19:54 +0000
Message-ID: <dd7f2213-df8b-4105-a20a-bbf1f9e0a0ac@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 09:19:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
To: kernel test robot <lkp@intel.com>, peterx@redhat.com,
 oliver.sang@intel.com, paulmck@kernel.org, david@redhat.com,
 willy@infradead.org, riel@surriel.com, vivek.kasireddy@intel.com,
 cl@linux.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240604234858.948986-2-yang@os.amperecomputing.com>
 <202406051039.9m00gwIx-lkp@intel.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <202406051039.9m00gwIx-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|PH7PR01MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5cebe4-218d-4986-fd6a-08dc857b5585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGt0dVFSRERSUFRTTmZJTlZ4ZWtqMi9maHRPTjFDdUNnZnlWY2JQMG9KNkt6?=
 =?utf-8?B?TUg1RkNtSnNsTjdnT3NBWkY4M1RxRndMZXVLWC9YVnZlTnNSa1Z4U2ZNMEw2?=
 =?utf-8?B?b0RBWjdyTUZ5UWNtcWQzY0lNMmRPM3VtWThJajZhK1c2TW1iOE5Ld0tsOFBl?=
 =?utf-8?B?cENJa0VkNnY3ckFXSTJVL3poai9ZOTRMeWJzQ0NiS01WcVhPL0VQR1JCZUlt?=
 =?utf-8?B?NEQvQlRTOVorRUtEUFNLSnRIaVVHeVd4aDBwNzh0dHlkemY5YWdQTWljeEVB?=
 =?utf-8?B?cndGc1lQZ214bCt1WERKakFzY0xUYUhFRFg0MSs1OUhrSHlhNVZFVjE0Wmxu?=
 =?utf-8?B?RVV2WlhKT2tFWXNORVphRGtCazIrNno3c1dvSmFLamgrWSsyNVN2WjZHbUts?=
 =?utf-8?B?clRINTlyb3IxRnczUUtyT1ljY0ZsbTdGVDkvZTlCaFFxR3h4bTl1NFpwZnFC?=
 =?utf-8?B?ejFYME1XNWgyOFprYjNzWE5KU256QzZkQitZb0ViVDUxTCtJVEhRMy92V1NQ?=
 =?utf-8?B?Q05kb2dPSVRMZWtRNzBMVjByRDNqSURzRVlDUi9CMHlpWitQYy9JS3R4MGdB?=
 =?utf-8?B?Z3hidG5pZXhPRTlzbG1WZ2llRXhXbjlmRWllZTZLR1JQTVplVFNDMHdoVGdX?=
 =?utf-8?B?dHpJT0FCaVZEUzJma0U1c0s1UU1tVElXV1hPTm9lTzFXdHJzTjUyWHpIQm80?=
 =?utf-8?B?ZlFXc2FMa0x0UDFiemF4a3pnVTRIZUloYVBEOG1ZUFVxOEp1VDFlRHJES1dh?=
 =?utf-8?B?MjhMcHRYdkVtMGhRQVFjMlYvWkZTUmtmL0l2bXZFWTRhY1dYd2l5dmJEc1lk?=
 =?utf-8?B?TzZacXA2UERMREpZZHh6LytnVzZkK0k2ODA3djlBMDcyVjl4WHUyak9haUhN?=
 =?utf-8?B?Y2tPSVk0YUsvN2xNSHk1MnIrbDVyQTh6R3BucDdIWWlPRnBGQmNWQTJpcURv?=
 =?utf-8?B?VGhBaGJHRlBPSU1uNHdMbFpJRmhOM0RLaEpkdFEvZFJzVG9oSE9OdE11bGU4?=
 =?utf-8?B?M2RreStZK01pZjlNYzNTdDlEaXZCTkEvZG96Q3p4L1FKNlB4QUNMUUVEZmww?=
 =?utf-8?B?Sy91RnZja2VlWmVzUXZwcXAxY1JOb3dJbXg3SFVQODF2WEtaZnhBbU9lOXBz?=
 =?utf-8?B?UnpTZDN6VlRSMXJMTUdpWlRzVVpaaVl0ODJVZ0FTS1NWM3hBUEYzKzNuajE4?=
 =?utf-8?B?RnV5MURNeEhBU3JpM1ZpNTRUdVV3UytuQjdQWm5JbEtwR256U1pVcWVDazd1?=
 =?utf-8?B?WUY5clgwQjZ5ayt6anRpNE5nd3A1U3pkcVJRamJ6U2dZVFlSZ0hCWHVTUnBw?=
 =?utf-8?B?Y3ZzK2o5dk11SXVXZG94OTJuVHVwZGZGSUVpWW9mSU1ra2NUQTNadnF1OUta?=
 =?utf-8?B?ZVJpQmFTVWN4cGpjZENobzNES0U4aVpadG9JQU55ajAxdCtIUHp2c3p1UVRw?=
 =?utf-8?B?OVlKcGd1dDZySGluVk81dWorOERTMkJRZ2ZQVkpaVXMyaldzd29GZ0VudldQ?=
 =?utf-8?B?Qjg0UWRhOXBzSnNiUDdnZW5sZDd3czlTdmY2Qk9TcHZQVWRQWW9zakNYZzZM?=
 =?utf-8?B?TWJyNmx1WjVmbkxtU3VmcXdBQzZ2Rk8xcU1Yem41cDlhTmhaS1puaGQzbVdC?=
 =?utf-8?B?V2RrOERsL2hoa251NmdsZ01HRjMrSTJHTW1nNUpBUFZZamoxRVZhYVhzZHJi?=
 =?utf-8?B?VGcranpCdnMvc0kzYU5Zd3FFc25Bd2RsYzJYZDBtTEZxRE5VMDVuand3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDVQNU5rSGZBbjU0dnFtRHNlU3VyMTAyMFhHaWRWbkJuYldjSXNCUTJheXR4?=
 =?utf-8?B?cVl5T3lraEN4cG16aUh1T21GWVNaNncwUXBkaDhGcVZIUGVZajZOczVNSkor?=
 =?utf-8?B?YTJsc1NVV2xDaGZ4VkJRVUF2UTlzZ3p2Yk9SMjRiL1ltNGQ0SnBhZGxDbjNT?=
 =?utf-8?B?Y2xpT0w0K1Q4dXZ3OEwvaG1Nbjc5OHg5R05KRDhzbFlIdUZzZlg1SE9mVWdr?=
 =?utf-8?B?ZXhMd1pickV4cG04VmxqdTY3RzlTR0MzbFVzQUF2UXRNZHlQdVlKZkVPSmg2?=
 =?utf-8?B?clBzNzhwMDcrZ0dKb2svZlhVcHd1SnJ3SFdyN1U0N0JDZmJDTFUzU3h4UUZ4?=
 =?utf-8?B?Y1dpTC8zdHdod2tRTFdoZHR0L09UVjVWNUU1TDltdlJDRm9UVlcyaUdpZDF6?=
 =?utf-8?B?RWtYLzlIUEJDcVNzNjFaU202MHdGdG9hVjEyaW0rbWVrL254cGs3Ukw5cTJh?=
 =?utf-8?B?M2MzL1VMZGVJWk5EbUN0anV6OHBUTnlSdzJBMURzSHg4VlZCeG1Mb1BiQk5C?=
 =?utf-8?B?dWNIa1drbWRNV0FYbjdnOFgySVhwdGp5eCtOVFo1SDdlM1pOSDFRSXFObkNF?=
 =?utf-8?B?alZHcTlPTUUvYjFNeUZvN2hmaHZWaU5KamdTTEtkZk1OTjJxaGJ2Ti8wemN3?=
 =?utf-8?B?WWxzSmFmWmxwbmZqZUhKdTkyRHl3Q3o1Z29JaEYzcHhtaXJqZXhlY3RrSVVo?=
 =?utf-8?B?MUtrb0RvWU1McWJSZWlBSWpyU2dvam5qTldJYzJUVEQ1em1WaC9KbzBlUGM4?=
 =?utf-8?B?dkZyVVlJMzdycEU5YTRqeFZlMWtCOWttZXc0Y3ppM09CZndXV1laUTl2Ty9u?=
 =?utf-8?B?UVNjTGg4RVlnRUhDL0JwcFJNSWt3dnhGSWVsWVFSS3BnMjdaUzVONlp4Tkpy?=
 =?utf-8?B?SVZnQjR4bUxvTjlNekYyTXRHVjU0N2phWHdzV00vNEdyY291cCszRXZDbTBx?=
 =?utf-8?B?cWVnTm1oWEdtL1BEc1FUZEFsRkk2S1l1V25LVXZxcHFZdTVWZnJ5cU1vaVRT?=
 =?utf-8?B?K3FVeURDMCt3Y0pYL2MrR1ZWYmxSSXBSL1ZDaXJHTU5ORFg4SGs1YjdIZ1FR?=
 =?utf-8?B?MlJSMHFYQ0JOT1hrWFlOc0RjanF2N09HYXR2elpWR1JqbWRnZm5XMU1tRGZB?=
 =?utf-8?B?eVVMQXg5aEQvQVVPZFpTS0NTd2poV1pXc1JxYjgxNVRpUjhWeTJLY2JjU1Nq?=
 =?utf-8?B?dURjKzgvREJ4RUV5OTBBa1UxRFM3ZE92R3VMdHd3UmtXMlBnTVZGVnNqTlp3?=
 =?utf-8?B?RitYNWNTK09ZYjFnWTJzcDhmMm40ZFRPa1FyWkRRTzFONVVkTm9yQUorNUxR?=
 =?utf-8?B?OFZ6OER3QjJVeC96N0xIMnZUcVNFOWZpNE5DanQrSTVjWFA5eEhjSFNwTE9V?=
 =?utf-8?B?L1BGQmJmNE54dnVxRWttSFlLVVhjcDZ0bDJDUE5ydklGZStOeWtEV3dOVXBR?=
 =?utf-8?B?czBpMFlHSlVmeE9WcWp4dHE3WHlrMlIwUzJsdFZGOVlJelM5SVdIam9jN3Br?=
 =?utf-8?B?L0dyRS9Bc3ZvUTVyUGlHUU1kQWQ3VDJ1U0NJUTZVVEVBZTMxSHpiVm1FcnMz?=
 =?utf-8?B?UStEekJ1cVd3bkJjelJqZjNtcjY0ZEgvQ1hWd0lOa0NSNzdFQjdGOWp1ckhS?=
 =?utf-8?B?d1Q3SlVkSkEwMVkzRXFzYTh4SlVFMUJTOHRUZWdmaXZTbW1nbjNlRVh0TE02?=
 =?utf-8?B?enJ6UjVBL3lrckYrMTN3OURDMnZoZ1piekxlMFlSOXVGUDd4clJBQ2tmVzRJ?=
 =?utf-8?B?WmhWUmliZ1VjL0YzSEROYmtDVDlLTHdzbFowT21RaXJhNmd4NHF4MU4vWkkx?=
 =?utf-8?B?Q0wzdmFveHhYR1R5NmNtUW5GR3pPbktneUNaR2ZzY1JPbzdKYzFZWGdoaTBr?=
 =?utf-8?B?OW1lbG5RZ0paaERnOFpucUh6QVNjYnZpY1FGVU9pRlF2MUgxdmxZWWpwMlcz?=
 =?utf-8?B?a1RHd0N5ZTZhMFRTVFQzUy80R3lHVGhPcTNlMkMySE5hVSsxY2xic1hYbU4r?=
 =?utf-8?B?SkV0dVpGcUNzeFJhekFYNjFZRDl5WGNpQ0ZnSG5ySTVLNi85c0E2YmZpRFVY?=
 =?utf-8?B?eDlVcGpWSFl0TE14ZEEyREJWQlVYcFFabWRvWUt4S3h0bUcwTWZyRFFmWnor?=
 =?utf-8?B?aCtrb1RFSlZiTnd2SFcybkxsSzVQZ1lSdFowSWZHOWFoNzZOMk9UenZScGlK?=
 =?utf-8?Q?JHCsUt5eBzZYYTpQo/26wUI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5cebe4-218d-4986-fd6a-08dc857b5585
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 16:19:54.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUriDdethi0cJg4E8KyPvvqDEo7dvU1him1hgJk4Qe0w/b6YeLN56GLk//YTLpkt6Vnwdomqv0BRklAK9klRLuX32cDyb6HFZP00S3BSaR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7679



On 6/4/24 7:57 PM, kernel test robot wrote:
> Hi Yang,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-gup-do-not-call-try_grab_folio-in-slow-path/20240605-075027
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20240604234858.948986-2-yang%40os.amperecomputing.com
> patch subject: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240605/202406051039.9m00gwIx-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051039.9m00gwIx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406051039.9m00gwIx-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> mm/gup.c:131:22: warning: 'try_grab_folio_fast' defined but not used [-Wunused-function]

Thanks for reporting the problem. It seems try_grab_folio_fast() 
definition should be protected by CONFIG_HAVE_FAST_GUP, will fix it in v2.

>       131 | static struct folio *try_grab_folio_fast(struct page *page, int refs,
>           |                      ^~~~~~~~~~~~~~~~~~~
>
>
> vim +/try_grab_folio_fast +131 mm/gup.c
>
>     101	
>     102	/**
>     103	 * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
>     104	 * @page:  pointer to page to be grabbed
>     105	 * @refs:  the value to (effectively) add to the folio's refcount
>     106	 * @flags: gup flags: these are the FOLL_* flag values.
>     107	 *
>     108	 * "grab" names in this file mean, "look at flags to decide whether to use
>     109	 * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
>     110	 *
>     111	 * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
>     112	 * same time. (That's true throughout the get_user_pages*() and
>     113	 * pin_user_pages*() APIs.) Cases:
>     114	 *
>     115	 *    FOLL_GET: folio's refcount will be incremented by @refs.
>     116	 *
>     117	 *    FOLL_PIN on large folios: folio's refcount will be incremented by
>     118	 *    @refs, and its pincount will be incremented by @refs.
>     119	 *
>     120	 *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
>     121	 *    @refs * GUP_PIN_COUNTING_BIAS.
>     122	 *
>     123	 * Return: The folio containing @page (with refcount appropriately
>     124	 * incremented) for success, or NULL upon failure. If neither FOLL_GET
>     125	 * nor FOLL_PIN was set, that's considered failure, and furthermore,
>     126	 * a likely bug in the caller, so a warning is also emitted.
>     127	 *
>     128	 * It uses add ref unless zero to elevate the folio refcount and must be called
>     129	 * in fast path only.
>     130	 */
>   > 131	static struct folio *try_grab_folio_fast(struct page *page, int refs,
>     132						 unsigned int flags)
>     133	{
>     134		struct folio *folio;
>     135	
>     136		/* Raise warn if it is not called in fast GUP */
>     137		VM_WARN_ON_ONCE(!irqs_disabled());
>     138	
>     139		if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
>     140			return NULL;
>     141	
>     142		if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
>     143			return NULL;
>     144	
>     145		if (flags & FOLL_GET)
>     146			return try_get_folio(page, refs);
>     147	
>     148		/* FOLL_PIN is set */
>     149	
>     150		/*
>     151		 * Don't take a pin on the zero page - it's not going anywhere
>     152		 * and it is used in a *lot* of places.
>     153		 */
>     154		if (is_zero_page(page))
>     155			return page_folio(page);
>     156	
>     157		folio = try_get_folio(page, refs);
>     158		if (!folio)
>     159			return NULL;
>     160	
>     161		/*
>     162		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>     163		 * right zone, so fail and let the caller fall back to the slow
>     164		 * path.
>     165		 */
>     166		if (unlikely((flags & FOLL_LONGTERM) &&
>     167			     !folio_is_longterm_pinnable(folio))) {
>     168			if (!put_devmap_managed_folio_refs(folio, refs))
>     169				folio_put_refs(folio, refs);
>     170			return NULL;
>     171		}
>     172	
>     173		/*
>     174		 * When pinning a large folio, use an exact count to track it.
>     175		 *
>     176		 * However, be sure to *also* increment the normal folio
>     177		 * refcount field at least once, so that the folio really
>     178		 * is pinned.  That's why the refcount from the earlier
>     179		 * try_get_folio() is left intact.
>     180		 */
>     181		if (folio_test_large(folio))
>     182			atomic_add(refs, &folio->_pincount);
>     183		else
>     184			folio_ref_add(folio,
>     185					refs * (GUP_PIN_COUNTING_BIAS - 1));
>     186		/*
>     187		 * Adjust the pincount before re-checking the PTE for changes.
>     188		 * This is essentially a smp_mb() and is paired with a memory
>     189		 * barrier in folio_try_share_anon_rmap_*().
>     190		 */
>     191		smp_mb__after_atomic();
>     192	
>     193		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>     194	
>     195		return folio;
>     196	}
>     197	
>



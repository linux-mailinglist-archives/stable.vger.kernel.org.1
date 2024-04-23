Return-Path: <stable+bounces-40758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 634318AF79B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6620CB25995
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E113FD67;
	Tue, 23 Apr 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oV3k+qyU"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EC13DB98
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901884; cv=fail; b=hjfI2NEH6yg6zbX3yDa17zsrrG0Ubgf3UvMI494RzNEWRVMHZJpuzzP56pUs8a6M4TSzW66XPDLzChCOH9rvsCTkP4l2PLluUeIo0vRV89oWKzVOqj55AaFYl/QJG0TUXRjsbHo1nyhpt46DL3ArGW6TBWJWN6KYHE+PCWb+M5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901884; c=relaxed/simple;
	bh=SPxghzEuqJa9EEbZ8vo4o6sl5yD/gtcgSABL9vxxzHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mukthUAs9kFJH32fuhtwrZh6O3t868bzkC/turSMwjxYBkDEuCdHFD/jFuIn2dw+cBn3ca6VcZsi6YyUHNIsEa7tAn0Of2D04fyhCM9kM438XHYouElP537MKNo7GaJqG5np60soi9k6VL6U5rpfIfgzU+Wr8csdQLicHpBO92U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oV3k+qyU; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3GofCI+Z5PlP5Gz90aB8qzvePHoYF5ETJ3htWiiDjRbhDZOcuP3AtUJOwbDpoz5QRA9SsEF9eecO8YtIMWjIrSPzwl69XUdjXUm3h5tsFQCLxsQmndOsT+Qm2xcAfU3A9lPUfc3Hf3YOP+bEBsD4xgjQu9h8BRMPJaup/h+NfKga/6CptzED71iZ0s3W3yiH7J8CDuG3a2JYedri/4ddk2R8BAmAWLN9/rsKYPQuF6rVYACFKMf895oWAUc/1u6/iRX2MMFhJhCQxPABwvYtyaMWBwT8IVY+8E2GO3yU17qMk+1Ukd4w6PV17T9rDr7jPzmKiy0Qe8KjgFQHzDcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S2ICIm6/RdVZCdPLQWxTBNSYsehdMYC22Xq9AFisqs=;
 b=NwcqxMtDbaHRXbISio5adlpyr/JWVYsuPwNR3xWWNx6cRQz7GQIAfpIXjobh4OprWcbFBjFbiHoCTxWcdoW+KuP2bDNLJfshBIJN6HvYHH5WrvzIlgFq//jaAbM55+zO4c8v2A8kELwDcE+n3MFg0ARcJD+zmtqFk9dLhQC7kstsoqlrnzoDlRlL+xZ8fDWfUwx49zIOzizHN3d0dsAjhl15THAz2kCT4cEKOPVhqdfBUJHBFCUD51FYl/a6DqHZU/ljvOroHNjlYJ1QiD//VAnbqx0EpUelC1vsm0Xj+ULlg3nGE+0XnZTTuPjtRN8GPWYZ/3d37hVi7Uj6iqtjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S2ICIm6/RdVZCdPLQWxTBNSYsehdMYC22Xq9AFisqs=;
 b=oV3k+qyUxXTqGyc4zSQmueaGFdbkG3PXP0alZJ3kO1IBH6Q/nfbNNZwbT/18l2qpYE9e/W8jqKHspWKBumoata6nEA0NtrJ3yyLXIg8lEMVNW4//V7LhM4Z3z5NNTFRGAgTvnrOnM5RVvJEIiiBia9+hPbeBTvnk8JtsbSBSKKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:51:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:51:20 +0000
Message-ID: <f719067a-9b96-477b-a011-1d32597f5794@amd.com>
Date: Tue, 23 Apr 2024 14:51:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Reset thunderbolt topologies at bootup
To: Greg KH <greg@kroah.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>
 <2024042347-humongous-unifier-5375@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2024042347-humongous-unifier-5375@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:806:125::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dc2448-0cec-4c3e-b6fb-08dc63cebee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXR6YjR2LzB6WUJsWUdQeXY2cGdxWlhSM0h1RnY2bnBuRUdVc2h3ZVpMTXZ4?=
 =?utf-8?B?V1pOeEJCM0JzTW9UVUVFU0wwQjVIWDVOa0pscmFScVlkbVhtNFRwQndhRnJk?=
 =?utf-8?B?d2NYTXNsMlJRTTlEWDFibDVlSjEyejZQdk1WcFlMRk9DeVZ6TkliR01helFm?=
 =?utf-8?B?TC8zNnQvSWJjS05UbFA4bDRoekgyaFdNTm8wZXdJOFl1REZZa2RwTWFBTkpR?=
 =?utf-8?B?RXNrbzB6cnJReFJ0enYxZEh0WWNrT0k0VjlreWd4WUFCMGZDNlQ1RnpkNjll?=
 =?utf-8?B?UEFSeFF2N25ZckFTak5BUWxOcDkvOFB2T0hDRnRhZE9Ub3hrNExQYkh3N3VY?=
 =?utf-8?B?aUhNdnBMdERiSUFQVVU5L0dNMmZtYmRPQm9iOEM4cWVPUE8rRjJ5WXNab3ZD?=
 =?utf-8?B?WENadU9YYTd5eTBKWXRFMlV5b3JNc1U0Ly81VDdEOWYwQU54Q0FpTUJZZDVO?=
 =?utf-8?B?V2dtSnpzVEthWm5UcWFSQ1VqV3h5VVdWdTh3STlLaGxTQW1KU3lyaWpBeDJj?=
 =?utf-8?B?YVhEYSszUGZEMzBOUWs1Q2dVZ3JaMUNEZVM4NkR3V1MrNWtxUHJWbmkvWGty?=
 =?utf-8?B?RHJzRHJ5RUozOGFVTlY1UU51Ync3OTJ1N29XMXRFeXk2cHBxTWpCckt5eHBY?=
 =?utf-8?B?Zlg0MDZ2c00rVGpUSVVPNDBGaXdMNFFURHFOZHBMTm15SG9GLy92UmRiNzR3?=
 =?utf-8?B?Mld2NlJrMk9RZ2hwanpwVVFZMEtoMnN6UUdyVEhuM3VkZk5za2pSakJ2NXJD?=
 =?utf-8?B?cEx1dk53b0x5QmJ0azE5TWZGcXY1VFpLN2JqV0hNdEI4Y2UwSVNWNGdmUER4?=
 =?utf-8?B?c1VLVEwzTkZwQmh2dWIrY2Z3cTFrcTdmY3Q5ZTJseWd5RkU0MThtOVZpcmJm?=
 =?utf-8?B?WGd4WkhLby9rMWdmdnhUUkV1Mm41QkgyWmxHWFdCd2x2YWJkQjQ1cWNXSlNz?=
 =?utf-8?B?Q3VTNDhmSjZTSDJhTHc5dE5iZzhZbFFBTjYxeDlXczNja0VYTTRnZXRYVzNs?=
 =?utf-8?B?WTVFREpYWFNvalk4Y1JWVExOMERYVnYwM2VqWjN0YlV5SDdRKzBTVWk0RDUz?=
 =?utf-8?B?ZEpsc0wxWVlKeUFkb3gvZGpXU0t2TGpKaktDZ3hkMkFhZEZUVGNzcS93WER1?=
 =?utf-8?B?blpYcHZ3YUdOeDlMcFFzaHBEYWtuRkxiQXZyNFFXb3l0TjVCOUd3NGZWQ01s?=
 =?utf-8?B?ZmJ3SHBOczdoZlRvdXk1eFo5djRaNVhCUUF6VkVoTFB1WGVySHcwczZDZTVs?=
 =?utf-8?B?V0FIY25xQW5MUFZ0b2Fld1lnTExVblV1Zy9NSjgvN011QzMzQlJDd1A0OHFJ?=
 =?utf-8?B?bjRHME1hd2pmLzlTM2huTGZpYVRyRkIwbWUwcFRWTDJnS1pIM0lYNVpFbUZG?=
 =?utf-8?B?MGY5UTEyenljVXRvUnFSL2R0Wm9XbUFJMmUyTlEvMHpoV1BHcEJUTTZTSFVm?=
 =?utf-8?B?QkFhaFpkV1lDTkFXNzNLbTR4UFRGb3R2RmFvcUxBUitxTTVpNlRJU2pzM1Zw?=
 =?utf-8?B?LzYzbkJsYitCOWp0b0JPSzdBaVpOVlZZQ1hVVDhHSitmaTBoaERsdHZJaEVx?=
 =?utf-8?B?bWxCSWxXMXNrUlMvdUxQTitjTStLUXV6bnNzcXRCUFoyM0xwVTZKeWk1dnRs?=
 =?utf-8?B?emJnZUhaUlJMTjV6eVErTjI5bXFMOXBUNDNUMW9FUE1mTVlhQ1F6WHE0cnZ6?=
 =?utf-8?B?U2dDRzlaY2ZTeGRFWjdnR1UzbUh6MFh2UDhWSnBwc2xnSmw1VTBmcFR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzA3dzRtcG0xLzgwNlR6dGgrcmpRZ3RPQ2hOY1ZqeDRjZExwY2pHSFd5S0Vk?=
 =?utf-8?B?SjFaTW14WSsvV2MvWWE5V0h4WnVnem1FTFFvRFBwdzVVRnRNaSsyQWR3bE1x?=
 =?utf-8?B?VmNyNmZQYmFNV3A3bGdJYW9Sdy9JbEFqM0k4UFowcytTUHdLbzlHclNseXdU?=
 =?utf-8?B?aXhaNkZLSms3RHhiS3dzdTZMQXBvb2d6cC9nc2pTVnREb29MbHhHc1UrMVZo?=
 =?utf-8?B?RXlpQjF6Yk5HWVNrT1lmNVlmV2NGZzBrWjZGWjdXQ0dOWHBLSFpGY1UzQml2?=
 =?utf-8?B?eUl1SEdnZTBzeHN4WnNsV21XbzUzbzg4bVovdUx6MnRybVVzUldmZEpGSVFO?=
 =?utf-8?B?YTRrWmZWOEZqYTNJaVd5d0tIL3libGhZU3RLNVNmSlRhRTZ3N3NZODEyR0Qx?=
 =?utf-8?B?MTZ6SE5YYUxxVm1GbWQ1VHhkdThYQjE3RlR5SEpiK2RrczVIRFhlT2xqbGt3?=
 =?utf-8?B?b3c3SUs0Q2gvT0d6b1cvQXd6d3ZtZjY3cjFJQm8zU3ZCODBKN2ZuNzFjKzJo?=
 =?utf-8?B?amFBL2o1MEJNbzIvUnlNZ1h1MG1xR0hJSHZIMHV2MVQzQXdZb3E0ZWdoMjZY?=
 =?utf-8?B?czc4T0tqZkZXYW5NWnRTNGxscUNUUk53cGRUR0NRbXYwdXUxZ0xzSTJDL0dD?=
 =?utf-8?B?MXlrZFRsWkNieFN1aWIxYWcwenpJZWMrdGVUNmw1bHh6SkljMzVqd1hDYVps?=
 =?utf-8?B?TEZ6TGpHMWRHaGZ2dmpaR3NkQ2pFNTdUOU1nck1zN3RBUnh0bzAyN0pYRURn?=
 =?utf-8?B?MkplU3pMeGpiY0VKK0dBR0dqaHdTSWZJVEZNVTQraTVKRkxmbVljdlBWQXZM?=
 =?utf-8?B?N2pvaFo3TGwvbU9IZUN3dHNtVUdmSk5MWU5QME9xSWp1SGxEdHdISUd5Qk5m?=
 =?utf-8?B?d3AyT0Z6dzBjYXA4U0RUaTY5QitXdjh3TmZoL2dZTS9MYXdVVkJpR2Jzd0xn?=
 =?utf-8?B?Y2FqRGlZeFBTVThTZzJFRmxPZ2tZbXJ5WlFxTjVOUjQzZ010ZGJPQndmenpq?=
 =?utf-8?B?UjFWQ0pmQUJlVXdzbFpJOGczTVpjWXRsVkZXQ2IwTUNVUm5KcHBGcGtGYjg0?=
 =?utf-8?B?Vmo3a2diTkJiV0oyS0ltdXNKVHl1R2lNSEdtWXFTdkFzVVF4djRIRXpWbmYw?=
 =?utf-8?B?UG5HQ0FhVy9FbDM5WXdlTXpYN2FIb0NrU2ZzdEdOQWdjeDQ5dytyNDBvNEFD?=
 =?utf-8?B?aEs0bEdFdHl1aWRMUG9jWFlvcytLS1YxLzF0RXJqc2hSdUtydUloZ3g1cDhy?=
 =?utf-8?B?YWlPZmROZHVEQzJzU2FFRlFrZWQ1ZWYxbmRmKzVRWHpoN2c1MTdIQW9yQXBJ?=
 =?utf-8?B?d3lSK24vTmg0SGhRQWFRQXNUWU5kTjFqVlluMmtEQUFDUXd5VEFwNldGOHp5?=
 =?utf-8?B?cUJoRlhZUkd2aGF1NHhMTVp1TjJUamhuc2lWWTJIUkowdHVTOHV6bVNsak0z?=
 =?utf-8?B?VW1LUFh2bngwcXhKaFRTd2o2MTh2LzlpakhJNDJQWFFJSjFoZTA3RnBPVTd1?=
 =?utf-8?B?S21NSzFibWZLcElqMlg4VUl3enBFWWNxak55M3Z6NE9obDlWbHlDdzh1bkVy?=
 =?utf-8?B?aXozaFFuZG8xZ1pmZVViY0h3OTZaSFNCVTBiRnRzTFFRQUxEUmJLREVsaHF4?=
 =?utf-8?B?ZGFCMzhhcXBOdnd0RlFUd0ZMbC9oWDFJU21jaUgyekNkZ0xwTkNpNUtJTmpI?=
 =?utf-8?B?bCtQL2IwbG85MGIwN3VmTjZCNGRhRWlaYXV1K2xGRWNweEpBNUtlWlJDaTMr?=
 =?utf-8?B?TFg2dG1iTDRMdE1XWStQUmgrLytkU0toRHIzVmRKcmFSR0F1eGVFano4MU9X?=
 =?utf-8?B?U0p4REZKS0pZOXkzd0g4dmY0Um03eVJaOCswRzBKclVKQ1k5b2lIYU9BeEta?=
 =?utf-8?B?aGV0OXZNMnBpd0Fpc2l3TC9EVnhMUk9hNW5ONWtqQzd2ZU9JRjJxTUI4a09u?=
 =?utf-8?B?VXB5NVNwTjdweDBJRERkUVZtYnNFeUFXLzZLc3FsOUY3OExSc3JmWSt5ZmU0?=
 =?utf-8?B?SkZTR3pIajJlTjc0M1BJeitTQmFPK3BCN1JGSUFqc0FsNkVLSXJnRVk3SU5V?=
 =?utf-8?B?Y1pwOUs0TzIwdnRQZHNWQUc2M2YzY3hMa20xeTBEM2lIc0RRWCtjWHlnVjdP?=
 =?utf-8?Q?kelBnX8tqDTPkXUdS0ufpfvlW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dc2448-0cec-4c3e-b6fb-08dc63cebee9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:51:19.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouxK87wXxnmpvKr3fhqbtPY7yc0f2YxZAQ/OwbWTDk2vW8EzE5bQxGf3C58MGMt78sAUk+VRjPKIo/w1y66dkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

On 4/23/2024 14:50, Greg KH wrote:
> On Tue, Apr 23, 2024 at 01:54:27PM -0500, Mario Limonciello wrote:
>> Hi,
>>
>> We've got a collection of bug reports about how if a Thunderbolt device is
>> connected at bootup it doesn't behave the same as if it were hotplugged by
>> the user after bootup.  Issues range from non-functional devices or display
>> devices working at lower performance.
>>
>> All of the issues stem from a pre-OS firmware initializing the USB4
>> controller and the OS re-using those tunnels.  This has been fixed in
>> 6.9-rc1 by resetting the controller to a fresh state and discarding whatever
>> firmware has done.  I'd like to bring it back to 6.6.y LTS and 6.8.y stable.
>>
>> 01da6b99d49f6 thunderbolt: Introduce tb_port_reset()
>> b35c1d7b11da8 thunderbolt: Introduce tb_path_deactivate_hop()
>> ec8162b3f0683 thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3
>> and USB4 routers
>> 9a54c5f3dbde thunderbolt: Reset topology created by the boot firmware
> 
> The last one seems wrong, it's really
> 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c, right?

It sure is, thanks for catching my copy paste mistake from my local test :)

> 
> thanks,
> 
> greg k-h



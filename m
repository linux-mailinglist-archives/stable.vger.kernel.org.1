Return-Path: <stable+bounces-232746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMrDGpnszGknYAYAu9opvQ
	(envelope-from <stable+bounces-232746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E147937821D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C373C3165C2E
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206A3DBD67;
	Wed,  1 Apr 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rdy+tIWc"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17A3DBD59;
	Wed,  1 Apr 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036535; cv=fail; b=bhvkh81hebZejgUTe4abkPHkINxxJaV1Y2nFw/Y7Uj0JafMtjoq3CMQnw8NL/QlOpI6bfsT0fuM4dmjZCjUEjd0onxLDcT2KBNGLfjC0QqtRT2yT8WAhE8DD9ygD1S8mvv7vzm4ZBAmDZWsQju2EET919iM2GULf+0ZvhpXHOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036535; c=relaxed/simple;
	bh=TR7felgVYASV+RNdNRQkdtxRseBV0Gqv6m0y6aGBXLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tivkbjReWyzOs+sKJjKr7Wg5D3JsjeI64j8sSeETzQORiWbFdZjJaFWvRFyuMnmAcI+UffpuimY52kS6eakRn8s/6ZWZYC2pOgFUXo9bEi5cVRBZL2euh4SfRCFMWnFcF0c+BgJm+QpJFFVE8AxnxT05OKjODTCQz0Z+2TZ0sds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rdy+tIWc; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPdO/+sEadtLEVBcgr/GoX7Ar/WJFFKp3lOt7gL5qBNDA+LU0xmkOfA0AETX5jBkgF2Mdukkutvj73uaqKs7MOYZLj4mL7+lS7YbyLvBw7tRCwXMCSJKw93gVSH4jZZBd3zVbhQtk6f4jjnSbp2Z67KS02zHZ9uzyRZXZFOpvf6jJPXawVp1BR7LDUk6mpDOUXigjH9mxw1g6fOxjM0jrPNI1HQEcBed4asAnbat8kg4GQcE7WzOu3OpHRcy49BFYMyE/+c7WdCrK7JMgn6s2SQUc+q2ENqD9znn0uIm+ogQuttRSuXE2nAAW/Q8BzX/jgFUMSW0g7On50zpAESmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNM/yrGFTT3H/pw1UorpFtFHYBjyHLjNNuw/ougvgtE=;
 b=lbI4kZQAyWeLKvf7nZiOgbwYlb03SVFiR2kF/e7+lu3n324yBTqt+tr4EIVM9KpHDQtjMGtGyUAbD/1uT8yuuvmV3VjZYrJ0o5t1+Qen3c7oKLE988LYtz0ImZv8NRFfBNxgjxBYrR0EoVf3+mC48cl2JIv7RNM3mHlfE9ks3/MZ+POiKq3BnzQ/RUVs/Bt+49eeitdGJlIcDkE45hQ40MWfwCLZTAa8VHJYLeC/XV7MDl4GlxmNVYWS3YPxijzF2BUYlS5rEGbqowpJqrw/MW1OOemRveiKfMgTsWspBzqBtuxz/wgGyOes7mIsosDZNqnz1Nudsm3g2fpyKEzVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNM/yrGFTT3H/pw1UorpFtFHYBjyHLjNNuw/ougvgtE=;
 b=Rdy+tIWc0MvpdjWwSC4WegYwolCius/WeFD73rRt0ZK8EF+W2u/WgFeLgagZWJeTNL5fHKKKxVtU0h5cgwEIeGrlFSCWet/f5YNCQlpdifSANrLEJOqCIAI8VVw1/EIOG4JdslfPSu32OShM1nQqQKwmh+Fh4LQXsvQ3OKuT7W8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:42:11 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::9e02:c4dd:e87b:5a74%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:42:11 +0000
Message-ID: <c67594eb-7e3a-9fda-858a-a9ffa4e3d190@amd.com>
Date: Wed, 1 Apr 2026 15:12:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] cdx: Fix double free when sysfs file creation fails
Content-Language: en-US
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>, nikhil.agarwal@amd.com,
 abhijit.gangurde@amd.com, puneet.gupta@amd.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
 <20260320102117.1554548-1-ptsm@linux.microsoft.com>
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20260320102117.1554548-1-ptsm@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5308f27a-f443-4bb8-6698-08de8fd2f2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eCk4hy9JWJ6rMF1eY0ewt4X4fSreo005xEuZhrbygSdn+SLzhlNUlGz+bd+CcaApDpJdSIXQSOEuN4A/iKWQZMtvkAoctoyljSJSxqX/PJVOi7sS6YKNvUZlRhBHEq8XH2aJ/JxHrRPoY5lsk8HhnF9kf1ihNbmr/z9HuWbf7rMIrzH/HeM9gFeHcAByXxybnRE1MbrzBpUdcbYfHiujT5iE1BOjDrf3H9F1ppA7+6mmf+LGm2evQexMswChldKrGCI61iY4h4BR4jxh4WRwBvSXa9fYG8pWvdC8B91Bf6/tM/lxmNJaCautzdfP+j2rz65Uer/Q9BNOdCwOs23N4QAnsXzZ01+kKwWS9Gt+QigTPL9UAjlKlwu2sF7tdyLNGqpGotrUfOROjPxcGHxoiut1StM+qhOzePL3praXotQ+jbhjKUZ/wAPg5fX0JR8DBU4XehsH3+ooSXvvVaJpbYCSPMvfAPzVfwyChfyFi2+XyiQFdMLEJ3Ip9SRpVPneNlOJyWSFQ/djLg0/5DETxG4c+enFSU1g11YUAqeXjYT25lNZgm3XLImGLa+yUdaIY6xTAMSYdSnNGZTK+D7kiXl+gZfj0xG7RL9YgUCD2OitgUonHMMH1QlfUWfsLLC0Ve6dnql3k09x/XS/gA8fjOcMLcjpZHr699vC7Z74ihIUd+Ickz57KXnMZHAd0b0vF8QdOdGADcyIpokZTBSvvuuiWe95Y1nJR0Y9r1y6r64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U092enc4NDZ3REJFRDVOaitHWXQ0Q29mbEI5MzlsMktkN2J5dG5sQ2ljUkQx?=
 =?utf-8?B?QnpNQlZhZ3JLT25oRTNKb0tBbTducFJhUjQzeEkxSG1WbzlmSW9oL1RDOWd4?=
 =?utf-8?B?YzA1NXFmaDNDWDU1aHpFVHFFNlQwTkFPZUJhbjVpYUtNcXI3bzZrbDg4b1dm?=
 =?utf-8?B?bXBOdFpoVmdzWnJ6eGRmRmtLR3RLS0NHbjhyWHM2MEVpdi8zS1ZQQmJjakUz?=
 =?utf-8?B?MUF0bW56VXJKRDJxNG9lNlRtL3k1OXRxS1paT2tDTDlRQ3B5VHRFUVJ0dVFx?=
 =?utf-8?B?WmUzRXJqSEkybGplWWtaR1M2eU5zWkl1TUJ5Y3hvM2lVSGlhUnRORmNrSmQ0?=
 =?utf-8?B?ZVNxR1BTSTYxdzh4aFJCanozSXlLbjBpNi9oM0VXV01PazYyblhvaGV3Q1d5?=
 =?utf-8?B?QnROZEdIM0I0NElNaVZ5NzJYUTBFWERVakJyQjI2OG1SaW9BWTVCSnVaayty?=
 =?utf-8?B?d3I4SEJyWWFMYTMvNmRSd1J3WGJRU2wyMWJVTFU1MC9NRnh6UWJUendGMmE2?=
 =?utf-8?B?cFcxYzV5dDlFakk4em9Jd2Jva1F5azdiLzRkYU41M1JwemU0WEtxTTJkYVZK?=
 =?utf-8?B?bkNObXRIeXR5TWVnRi9QdWxuSVdqWGhTRW9uMDExNW9iWlNYNnR5VlRHQjBr?=
 =?utf-8?B?bWNVVXhMWGhBU0dLMEVNdWJXNUZwc0dBRHRjdVl4U1Q0Z3QxSHlhcnorclhU?=
 =?utf-8?B?L2tZNVlLZW0wNFg3T0Y4K04rU2JmSDI5SGVnVGlDcmpXRzFwTkhkNnZIVGdC?=
 =?utf-8?B?bUJ0OUEzRTJSVTF3UmV4Vk5zUHV0KyswQnNlLzhxQVZJY3ZobEVMRkpiSGUz?=
 =?utf-8?B?UHZUNmdhNWFkTDdLV0VnbEJVci9ESHZ6SWtGenFaQ0NVNU16cXB3YXZRNUVy?=
 =?utf-8?B?T1VxSnI5TUFQOE9taG84djlhVUMxN3RETUR2VWJWVktpS2hEckxldHY4K1h4?=
 =?utf-8?B?VWpNT1JIUDNtc0pyZGNXZE5sNHlvMjZtYmk0SXpPTjJxS1NhaEJ0TWxKTnRR?=
 =?utf-8?B?c29TLzdoNFYvSm1Fd2lXcVV1ZHVaTHVWZXNORmxVV1Y5UEVTdGdwTnE1WnRu?=
 =?utf-8?B?ZlptNkgveGNFVUN2NEV1MG1ZemRNNGVHL1lTTFFVUzMwN29kbUVBTTVtRFUr?=
 =?utf-8?B?WDUyNEEva0JDSXJEOW5ZOS9WcHVsU0dnTEUwcGNhK2duUkpaWXQ0L2YrN2JZ?=
 =?utf-8?B?eTlCc2hHVkZTdHJMekYreGxqYTFFSkRGQ0VET2FDbXRnNGZIU1NiV0VaVU5C?=
 =?utf-8?B?ZjVKYXZvTWFScGF5dWhUTWdLVlhlZWRHQklONGoyVVJXODB4em1hQkJwNitn?=
 =?utf-8?B?S2tsVU0yUlZUQ2lZcWhhVmpQZU9OUTk4cTlURnMzeE56V0ppWnA0QUUzaFdn?=
 =?utf-8?B?OGFxUE5HNHpZUDNCaG03RUEzeEFRaVRVai80SjZOeXVSTGg1SGFRdHZyZVlp?=
 =?utf-8?B?T2o2djgwUEtjckhYVm8zcG03RkRMWWhHNkc1empyVjdCR1gvQUlzVWJIdE1Y?=
 =?utf-8?B?VVo1dFI3cDNScEQ3ZXYzbDFWUFJLc1BYSGJBRWZ0ZFUxa2Q1MytGeWJNSTRq?=
 =?utf-8?B?UEtHQkQvVCsrVGUyMHV1K0haeitDaGxnSDFlYnI4NUVGZmpTalhQekx5QUxB?=
 =?utf-8?B?R2U2dFg2UzBXSUpxenpGMS9kU1lBaldVdTdhQ0pRRW9RQXI5akxPMmNUK0Iz?=
 =?utf-8?B?RDh6ekoyOU0welprakM2R2RxbU05eWNXUlg4dFFUQTNDMy9uY3Nuc0QzeHo0?=
 =?utf-8?B?dFQ0NUltZ3BTMlVGbU84K3VQNDNwdDFCQU40WldpUXpraUZlOW4rejdncXh1?=
 =?utf-8?B?UVBQWTRXYXVMQTkzeTZ1OHRVbHJNNy9KK3d1dWdsUm45MXlORjdtcjhpU1oy?=
 =?utf-8?B?Ym9DY2NrOW9FUGkwWlZRZndQR3NYRmFZZFlhNlV2b08wT3BpWHQzRTRmUWVl?=
 =?utf-8?B?SXR4bzgrUmtzTWtiK01ndS9EN1hGY2V4blRiS3pmRlFkQ0hMZzU5d25kRExz?=
 =?utf-8?B?aWsvdlZnWUdEUjRsbkpLbHB6R29FdzBZTUt3WDJVZU11M1drMnY0UGFDRTZH?=
 =?utf-8?B?L05LMGw0VStQMEJUT04zM01wY2Z1QXJMejJocHZyM3R6WWZhbUd5T1BaTXRC?=
 =?utf-8?B?cFp6amV6UWNHN0FVZFBITlUrYmtyaU9VTm55bkVhc2pBRFdzVFErSDhiUTZ6?=
 =?utf-8?B?OUs0TzBUa2srOFluYlpQdDJmVVd1TS92TU5QL0JqMWozMmphcGpUd1FSNlVU?=
 =?utf-8?B?cmtpN2s1UmhSZzZpR3YrTTdoalMwbkVsNElnTEpqaVk5LzA0U0o5VDI1MWhG?=
 =?utf-8?Q?5aly1bs4qEwVplRLy2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5308f27a-f443-4bb8-6698-08de8fd2f2bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:42:11.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mu+gpZ7nubxOncK85Th6qqFxn8oLDqYN1OIrpet8VQd8C1PltHcAQYRmEIfrABgV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232746-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nipun.gupta@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: E147937821D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 20-03-2026 15:51, Prasanna Kumar T S M wrote:
> In cdx_create_res_attr(), if sysfs_create_bin_file() fails, the code
> frees res_attr but doesn't set cdx_dev->res_attr[num] to NULL. This
> leaves a dangling pointer in the array. Then cdx_destroy_res_attr()
> frees the already-freed memory. Fix the double free by initializing
> cdx_dev->res_attr[num] after sysfs_create_bin_file() completes.
> 
> Fixes: aeda33ab8160 ("cdx: create sysfs bin files for cdx resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>


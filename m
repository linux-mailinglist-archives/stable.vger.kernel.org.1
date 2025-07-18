Return-Path: <stable+bounces-163362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F336B0A3ED
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C61A80B53
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6A2D94BA;
	Fri, 18 Jul 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yymPqLNw"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B862D948C;
	Fri, 18 Jul 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752840884; cv=fail; b=ExN5Jcf3VDSzsAs1lreuN74D7waX17nL8sa/n7NWCRfuwECZtExSgRHioWLjedctjhTxWpGQCiCS3gXz8z6pgryivdqddQ3OHmqNMDkU8Gc+wIgpTk6evndLFXY8je/oCmjpWc5d8I+qBPj+ECwBcLPvMEOI0Gdv5L18JODrlbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752840884; c=relaxed/simple;
	bh=RSLe4B1k96W8iHJEtHUlUJZv5Fp12xv3rZ59FwESoNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEDje0N40rnPR9Od2mfSwvsXE0SBMDH3f10Feisph1LSb4vQm3leCB/RzHTRJcl4TAWg7UPjG1xXPAKkRHV0VUq4+iYjcxPNpuDqdWD2EN8hs78WOaRrZLOrBg3QIyD53O7WrSzxgWxwuHlczmR0F3Iy6d61k87/lFfJsv/n4Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yymPqLNw; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Ao2euqWFSFtXJ9l0P+BVmaV3pfhAUcaB+ZCGFxf/sbZ0+rL8SsJeOQ9BrJGbazQMFHkbyVXACcXy8DtlxPE52jPo8IcaiHl1xIFKq6OyUUvPaZOPD/LQVwJHHGPuyO0IMdohk98vqY+dTGrnV7XUk80Aj9hz7+8QqKGfskK+5ctiisqBRKi4RC9BUZApbFYv0EyhDg58QCdInMpnkdZoIHGAJGZ2wCHH4HN0/Dw2TY3E67Rc7fj9Ae7rE/JHkesqsIehuI9lhlfzx8f0doL7SiyauK8m4+PWpgSXhYTAGEj3nCi/e4zE8ljjMbwknKMN1Nu1OUozladosBrFl8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70bMX9fbXRvKBkCldTfz+bwsCAAtxPyXLBbQuDR4F7U=;
 b=PE17/Lk9Bv7MwcET/1kTII4cjubzBmsa2rftnxV/C5eBCZKmPphrQsL9H7xpIBYxx0HdsGyyu1k7juKc7zGx5qrB8+PfZT60VuWtHOFWSPCrWxlyMPfoYNNbu0jwFLHZmhDzYw4Z06EirwTux/VzFdUFBUoFDg5R0UFflocWk3ladxmByhRCr6aMb5wWXWGmVeeloCnlUp/9pY9cyDMJC+WS6w65+CABNqo4edKImafBhKrnsDpgPYSFvf//E9HtVMpdMXQIvxepmFQXK6qzCEkdxjm7HbRjjADH5QTuR2ZCmYX2Ux/RtwT/NYXgYfW/R4FT6eTiG4YgRx5oWmtFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70bMX9fbXRvKBkCldTfz+bwsCAAtxPyXLBbQuDR4F7U=;
 b=yymPqLNwVgxJlrFQkUEtujjx03slGg0QFAiaPhGGYIhvYi0RrC7h3dppAtMJanzydW0kAvg4GdB8KcrXpYd8y4l+KITfuv78zo+qCsvCeLNxDrbFIwojQzrVdiClWVR5Sn8NH3BvARVvzH5vrzB7hEcAEIJdzKW2M2Dk2VveQTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS5PPFFF21E27DC.namprd12.prod.outlook.com (2603:10b6:f:fc00::66b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 18 Jul
 2025 12:14:39 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:14:39 +0000
Date: Fri, 18 Jul 2025 14:14:33 +0200
From: Robert Richter <rrichter@amd.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, ming.li@zohomail.com,
	bwidawsk@kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix potential double free of region device
 in delete_region_store
Message-ID: <aHo6qXHUubfq9vKL@rric.localdomain>
References: <20250718022940.3387882-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718022940.3387882-1-make24@iscas.ac.cn>
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS5PPFFF21E27DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dff22bb-3d19-499f-389a-08ddc5f4ab1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?510CmSkJu6SldPH+VzVr5UkJYPIEpqRjn/3Ie7vBOPhEPXtlRjwkppVQsaVB?=
 =?us-ascii?Q?B4scdOBDaDDbo143heeWV1NIPZFOonF0OiObOEPjAyOwNtv8h2gVZ2+PEQHj?=
 =?us-ascii?Q?ozXCcWV9hp10MALeOsFwXHp/q4X/uVIq0jGu5MjPQHZF9SxHZtqamb3dSiSJ?=
 =?us-ascii?Q?i5Ei3gtjsoEZ30vWFIDIXFRNsLTaHN/HKEsoB1t4XjN/mkyl+feJr45x37Za?=
 =?us-ascii?Q?2cCnIiuhfwJ56hc+5c9jxY1OjTB7sq63bKx/g4Ufo1AfXYor323mP2mOkgEe?=
 =?us-ascii?Q?q+btzI0Q03h/yCBWhETznXK70AbMOYQjfGb8Cxfmw+uByQfF9uZQ94o91pXh?=
 =?us-ascii?Q?BARjZ3rFHxViKIXjt8vnBvWHyYxXcQELFF0HnSA0qD2mi7aSQIOtFM4C0+7h?=
 =?us-ascii?Q?NHZgn3yRSltI0x6PgJC9SODVjD6gwrZnyn2HRDwL0EKF0VfSLN5VtlqnQdwz?=
 =?us-ascii?Q?zSwNj5IGgI1aULfItQWJnGwzIbMqRX/qh4tk9NihvTujgIlURSoT0Taip3bH?=
 =?us-ascii?Q?xr0ADyx7n+BXoskMoWl0xVeRurSxS5wDfNuQ514MxSxuNqzNUYwzEOy6XLcH?=
 =?us-ascii?Q?YQ7/0XzYHLfwO6hnacl5F+Xir8epal6lvtGQyCnr/CC+MiiClWt61TmvK64A?=
 =?us-ascii?Q?TtXsl7I1rg88n2LfPYKGq9KuUSH5CPQZgD9ZV5ddt0ksxs4XXLZHanAlLzYK?=
 =?us-ascii?Q?BVvLH4N+bbNvB1QrJRASpH66Jy+Pqs6D3BuCNMdttaGE80uwSGKL/tjuFosD?=
 =?us-ascii?Q?Q/g9tFgkoDSD2qEpVsYng40DADlhdqEYI4FZhsGRuyJJYvMsCBJEk7b3s3Fh?=
 =?us-ascii?Q?W29yUcOnxtUCeeqeJt1woXuCRfT65gO/Yf/13UFbnp5myRGyLdEdyKl0JgUJ?=
 =?us-ascii?Q?+h87Eo8/QYL3j0P5I2AZE4SeyX7ReZd3/j31P49Tugf4wy1tqPJQlJ+vYV1D?=
 =?us-ascii?Q?/xDJRCCoS9iMB+o3HObNLV/hajxKrUfz2hNUPXMFkBhJI3URdUKiNTlUWD0Z?=
 =?us-ascii?Q?+qUjvGbVCj5E2Uvs+voOVFN7FxWdNX6Vcq4BeOiR6JccpI3TCT9ceRq/XUuC?=
 =?us-ascii?Q?Ez1YuoqhtESLRctPNg0bPt0VYxDPzG85eoLxGUl6YWEZp0lwAInoLHWQDLtN?=
 =?us-ascii?Q?SVTXgqs0Xd0noBLCpD+1tv+2yWT8ZYmzilbYfyNdQiZ4s6yr+ZcYZp4IDhqw?=
 =?us-ascii?Q?ZPeNL3Isa0GYb65Y7tbbfUmMP1diBEV+KA7zinpgPKXT7vz4vrIXcZz72m95?=
 =?us-ascii?Q?qVrn2W/M4DJXX/5bx1NGmCTiX8Im1rVGx9Xh/GeX+b2x7o4n2VUfookNlveD?=
 =?us-ascii?Q?EdSyEyOpXEExTxO4tab4PrpqtMyrn9H7Llm9uMtnZ+qJKvmUa+ye/tCbb5f5?=
 =?us-ascii?Q?Vr+fZ5jFvUUXG1ngOPWJHn9fHbtxtvelATOhLOMntOyrrdWt/2hMskdy4b79?=
 =?us-ascii?Q?LS/aMasnZq0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kshuPw3tS0cqKB140ztmSCs5RxO21Ei92X7VolBtVybVaGAYv+akn1ADoB8m?=
 =?us-ascii?Q?cDTWJK62x1BofUUKzbxr4mXtWHRzampdFKaJXEVXugn7odWwaBHLH9jya21m?=
 =?us-ascii?Q?Hv2/1WIjHqJtqJ9SGMXsZ/YItf23wvD3nGJV3aBhp2pEr8n3qWcUks83IDfP?=
 =?us-ascii?Q?vS92Ho+mQWZTi4m0PM15PUnuTS2GBLfZ5EDkvyl7INKUu7EmGK588r41aKzk?=
 =?us-ascii?Q?QwownWqmNgcx9oUX++X73qpKxmSAC4/B7RFOxOkYeU5l5Kn4XdQE11TAbrla?=
 =?us-ascii?Q?6TA4jIPYI+PhzNbCaeJQm/7s82iLzFlPaNQqEvoqKx+GX0e+cWX8MT6Rh+nF?=
 =?us-ascii?Q?L1xzvu+adodLKmMZDq2J97USxNE1tmP3Dc2idBYtu+lFxGLJQo2u9mpcmE7x?=
 =?us-ascii?Q?7yCFntbOOAnl8D1N4U+DbJ+jKptit5HZdtnVVChwUCYtPem9xpef3wvWQXXD?=
 =?us-ascii?Q?p4CD88sHcj5tlaw4SiXEQ8UH51F2VzzgSr2Lmu7NIJ+2KbobNUmQC74iC91I?=
 =?us-ascii?Q?wEHVT4q+1kCIdVGNQFIPpaOosCtTvOVjZZne6uEEGJDvENasIBB1QeX1jVe6?=
 =?us-ascii?Q?C7a5NItS5srmC5Dm5rsFTxOfppif69U7SIAb0GTajGWOdKPLFSe1SzrJUKWL?=
 =?us-ascii?Q?kSf3OQJITi9TcdVS1KhMZdTwzGSGrHkaEsb3Ko38FzF8FQSd4zzF5fNt6Xqw?=
 =?us-ascii?Q?uLZYHXV7DNrGCr9et72H9kxY3J2e3f2taDdWNf2Pe59HdRthpjltxFx+zID5?=
 =?us-ascii?Q?V3dwsJfJVQBytqrxZFTPSB94nDAGYXADzC7/BkSb7jTJsluiK17scRVwl1TP?=
 =?us-ascii?Q?3SJqlv39ZJGrDTB45JBBcqC++qt/pTVkrab8fX4vKCSZge2FFNA/Md0R0r+j?=
 =?us-ascii?Q?Z1CRGRGM+zl3w6KKuT0cDnYaoV/UUanPj9nAEP283GtEvObBbpm4RHIKvz3I?=
 =?us-ascii?Q?/o0JbraorV9fc8SeQS0u1xgy3BS9qQ/J4lq6XTX/G7EMXoWdbgWm8KiA85gU?=
 =?us-ascii?Q?gek2GIzRaibrBUDTNZ0OsrwSPk+ZlHcl11xoDHTF0ahSZOiWNN2wxGhVpk3/?=
 =?us-ascii?Q?au3mgZq7Ial+Q12RkGTvx4api7cZwUsddXJX5BUYSlOsZglBDKq+qx5xiWds?=
 =?us-ascii?Q?n0STUMMJpFmBWK6JOoE2kOm/8PycstTA/HcGY/ZfoVfuZYHMNvv6hyZdR2LF?=
 =?us-ascii?Q?jjJv7/RxZ8kbVooE41gx2wDLKRDyv7i0n9AjjpF1WXs4EUOh8qtxmY3z4KQe?=
 =?us-ascii?Q?/XgY4xNBuBOwXmOj3yVHi9rKb9mga2khlXYiLWH5a6dOL3+gtw0+fuqDGhoW?=
 =?us-ascii?Q?y6AUsZeYTW2hkOd9fp/mhG7NhMk+THXtDliZHQ8maNEHblJHbwX6cm4KqV/F?=
 =?us-ascii?Q?xy+ojQjIP/tqiECCLahpk3o0O6wwYXOZyXK89HPA8yBuzeVmSlo1ro2zhqKY?=
 =?us-ascii?Q?5F5ReqXtGfYkem9XZDpg48KNsAmK87RbkfdM7dx4Tl3vQ62uYrRporvoX4Y6?=
 =?us-ascii?Q?dRm8kfMt5T7E3S4DdvRvzj5IWQKLtmu089TUWMf/I5srD2VG7jw8092/piXV?=
 =?us-ascii?Q?i5IbYeOeHoJNnwBTrxZRvp7uV7s1sT+XksRWn+KY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dff22bb-3d19-499f-389a-08ddc5f4ab1a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:14:39.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44CNVHcvqtkbUBdmmkHtMowP1VBZzrpScyrQjDwOQlGRFRzxaLnst4WxxSJgUKxkuY93xc4yWahX8qaA1ehLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFFF21E27DC

On 18.07.25 10:29:40, Ma Ke wrote:
> cxl_find_region_by_name() uses device_find_child_by_name() to locate a
> region device by name. This function implicitly increments the
> device's reference count before returning the pointer by calling
> device_find_child(). However, in delete_region_store(), after calling
> devm_release_action() which synchronously executes
> unregister_region(), an additional explicit put_device() is invoked.
> The unregister_region() callback already contains a put_device() call
> to decrement the reference count. This results in two consecutive
> decrements of the same device's reference count. First decrement
> occurs in unregister_region() via its put_device() call. Second
> decrement occurs in delete_region_store() via the explicit
> put_device(). We should remove the additional put_device().
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/cxl/core/region.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e5e1460068d..eacf726cf463 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2672,7 +2672,6 @@ static ssize_t delete_region_store(struct device *dev,
>  		return PTR_ERR(cxlr);
>  
>  	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	put_device(&cxlr->dev);

cxl_find_region_by_name() increments the ref count in addition. So the
ref count could be e.g. 2. This put_device() here only decrements it
once to have the same ref count as it was before calling the find. The
put_device() in unregister_region clears the ref count, which causes
the release function to be called.

So, no, we need both and we may not change the code.

Thanks,

-Robert

>  
>  	return len;
>  }
> -- 
> 2.25.1
> 


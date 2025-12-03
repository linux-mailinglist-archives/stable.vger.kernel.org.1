Return-Path: <stable+bounces-199924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5714CA1997
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 21:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE8FF3008D50
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 20:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E532C0283;
	Wed,  3 Dec 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NDl1hT17"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE627707;
	Wed,  3 Dec 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795276; cv=fail; b=oLCmAp310hLmFVLaYoTfCSYwn2xDarpNkiS816QBp+2qp2SaVWYSVMRWvG8CKScfawwePkiOeCNrJCJIhh40vRZdP+rzvWYYSWbp7gWvmrhA63wf/7Wf0Zt7I/c0vjLcvjlW/IwjPwYjg4D4sHJ3KMSovAsVdkB/gEqimV6u/KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795276; c=relaxed/simple;
	bh=rLakKR6YYqOByfsZrr51b8KsgpgMluV3Y7kbfUOZXg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZzwT/9XBb6q0UDGHwtA0vZyAbqDt6wIstC2ukRWztukGNYMg1e64/yHKWsEEAyELwBZQNlh8EOhipt6DADzquH+0Y6078gIl7ki/d6uffxBOVFgp3nZJ5RajA2LPNgo3kBNHn8DM8LMv1zStBz+a7TVJ2w9EhYSzLJm1JBMPdkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NDl1hT17; arc=fail smtp.client-ip=40.107.208.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9jHTci3Z9GJ5h+BVjg0eUiakWUt18RBTA48oW7DdtsSIhtNyF5TidPJNd/JW/jKfOX4QvSMcpJShE3B/NoyxAQnrT+j9aHzGEl2qhaQgchfem/SYnE0qLRnge8jxliXXIyTLdmumli3ttKjG/FzxoGtPOidcOW1WD9Pvm9AoU2JPQKGWOINgdOHRAcwkcU5cpjGS5u2o3HEltuN0aE8XnBjxoYt3px53umL4wtUtoxIdrLflGa0V9XszQAbxIb3X5xNtCvSAGRSoobLxioynyKms3duW+gXhwVDkEs5dyZ0K6Zsn9b2wXfSH0Mh/LTLtFFPcG0nakIEm8uDtWImrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar/e9ShwNgmJ5zVkpkDW2YUiHaFJOk1TG6h5971Tui8=;
 b=heQsj8yK2XQM82gieoE7ZeEpo3itWGfQPtw7K/x72fzWdhLDTAJnUvxPj7fKogFFBy99Q8PuexLxJvnmIeyUnVcdxl6eCBol1FxPu6BI3Rjde7xIYXySYnNox8gw8+QasViAhIrxhYr8zzkl8yg6U4kB9l8lVwFE6wTexECFbYWPqf4KE0NBu0f/FXsjDxtE61pLWF8aOVtbA8oDnqLxp2u9+fvqaVFevQQ1j0ItROJM5prg9ehn/6eOXk3eEggSvHs2Z2iFKB0+MDuUf/x/9qYCrYud31w1hciJobyget8wn3fLasjsfpUJeQ8Ve6LiJV2N2fSZ07fd2cXABnb5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar/e9ShwNgmJ5zVkpkDW2YUiHaFJOk1TG6h5971Tui8=;
 b=NDl1hT17GFIYiJxkIRyvqLGKQhh7qmi9itP45tjo0gEkcBaBj9slavnd6mR0kmV5Eqp94RGMb48ndlORCNGS3/ZDXFJOnUvQiqTE9+cbnu09FXyaXw9vf+g+zI2F89K5ICZ5Y6vN0IsGX/jDBQMoHyrFDqNCdKiMjN8zy2hQrE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Wed, 3 Dec 2025 20:54:31 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 20:54:30 +0000
Date: Wed, 3 Dec 2025 15:54:27 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Steven Noonan <steven@uplinklabs.net>
Cc: linux-kernel@vger.kernel.org, Ariadne Conill <ariadne@ariadne.space>,
	x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/amd_node: fix null pointer dereference if
 amd_smn_init failed
Message-ID: <20251203205427.GB741246@yaz-khff2.amd.com>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
 <20251114195730.1503879-2-steven@uplinklabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114195730.1503879-2-steven@uplinklabs.net>
X-ClientProxiedBy: BL1P223CA0024.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::29) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9b7659-b1d5-4470-e595-08de32ae27d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27ZgxiSeMKUDRy/kPLud1JY/OrBxUsPe/EbpS4g9GW/sgc6+s8dBBuwI7IWS?=
 =?us-ascii?Q?eeYr5R3tYcjr3w5XNUCO4KWjl73eihHTqYVJ7vTJbnEcxtHweeizeXveNztZ?=
 =?us-ascii?Q?v0kW40cHOnuRbm2QLRmtPx2v6mQgNTQ/ZBZsdTCSCFN04IdM6PF2JhiiRs1W?=
 =?us-ascii?Q?wKzN+o8+jXgkUklsBq7Y05xPFi5Le0X1ONow+bQpb3Vy71rmJ2Q/MOOlskYj?=
 =?us-ascii?Q?oWM9vwi294BP4Hjnmc7u9/M3QHCS9BL9aA68ux4N8YvtzCL+9cUp9iCKOkGG?=
 =?us-ascii?Q?hYQKPB2t98NTwMQn9b9f1YX4P7Oov9rlJ7eQSia+O1C+4ChvLIyZEL1p62d4?=
 =?us-ascii?Q?tb0MlPplWx2SEVVKGjbreihbusBgRLRqQxz54HVVxxEu2FRgEbzbCn9+LG3K?=
 =?us-ascii?Q?RXdOlWmHnxKjwOqYnrWCwLm/PZgJrDANZVMnljct9ZPmAXCVSWSHijuhjA1X?=
 =?us-ascii?Q?6ltYGB2KjjkJ9KgbB+TGG63e7injb364J3PHp0KJ04QlUABQt7Nod/WiLRpE?=
 =?us-ascii?Q?v2zurNMw6d6Zov17ogFh/vt48k8m0DtGwq5zjYPu9V516+U1AZ+Gguk3BNGM?=
 =?us-ascii?Q?50XkTRM6Dq99zCaRcaepQ7460gnR27B/9Nrz3+1ZpscNMiIQIQUVAKhGZqXK?=
 =?us-ascii?Q?L/59BWvCLZd8+GpvN7VuE66tdJ3XJtW9D+JQ7ANfOZEDYnUAcq/Xsy3lwEYq?=
 =?us-ascii?Q?dJhaE6zhVSqz+tv9XjpOlOQ8OqlY558LKyTic7n7v9clcEsLNLsypqJV79bp?=
 =?us-ascii?Q?vkuv8WT90YsQ5pfPJI6zIMhSH+XlAd5J7GXbNqRukWGvv/Lqx82W/i/a06o2?=
 =?us-ascii?Q?/mpf93kBQB1rNrITGsB10mazI3h6NXklp/VTsXz/Zi9oaV9zqz/Fdb4PjeMQ?=
 =?us-ascii?Q?R5WcB/jnGdRplFe6OgxjizjZ6t0juE1PuADts9FTOxANZ+eHbKXBuZBLXbLo?=
 =?us-ascii?Q?vTE5PwU74BhcXA3MjBRv/o/aenRgIF2AcRxsr9ED8lB3c4YtK/a19KbOhsXz?=
 =?us-ascii?Q?0Cmub0SEFONUPu5/Yuv6So9ZpJojfcYyPzk/A0EPiQGTlxijOxRIrJWMrKe5?=
 =?us-ascii?Q?s0Dco1cOzfLapSl7JNyu7Mgvdy2rze97HZjOaPsAnhn0HAdD7rPVd2WnyHJf?=
 =?us-ascii?Q?1gMW8AK1CIOqb/1tM+sUAH7pV7ZznAu1zmfH4szxWHKL5O8AF0ohAjZikwNt?=
 =?us-ascii?Q?BYpWXMh4/qmqArNv+8fiA+lwI4cBJlKW2yaoh2UhW6aybCN5/J8RR1b+UI5s?=
 =?us-ascii?Q?N0vnaiZckZHtcyoe+l9EmEIZ1MJ4BEzvln8fgAmwjDzFNDx4sFnN/rSnSNeL?=
 =?us-ascii?Q?gs6pW0C6/s0P3hjoxx1mBcfQIUgFslNfAfRWoz5KTfOJQB0zoMCM3HFmQgNs?=
 =?us-ascii?Q?Ks6Jqqve9HCHQEAuGUmyctSkQo92BSoLnsZG10e4E3fWfy2VNl0rd1dgCY6f?=
 =?us-ascii?Q?p0rLIYI4Bxg+fHJZDGe06zbFrFn5le5Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYsAxXCstZBrVVF1uI2yvTNFeS0THzO9LIS1reiv5/Cl1IYAbPDqTwppdJXV?=
 =?us-ascii?Q?fEifdl7PZTlPpZDJe6hntHOvMYN1s3pU9qccFMvNVQUga/H5fuLU7dS8sUG4?=
 =?us-ascii?Q?x+U55azK6bu/8wcYU+aa+GCdfcbaHEMzaHQeWQfulA1JwqPAUaeh5tLiokXg?=
 =?us-ascii?Q?tGh7Gy8yKJutopOS6R5N4Z8BvsW+UuPPgYZyK/ZlPo91jivmxW5iBkry3seC?=
 =?us-ascii?Q?zhjiNI9Tw7Rjfmnv4zNHWjp35gQTV7QgmwBs0xekOXEuJReKPI0yJ20G8Tep?=
 =?us-ascii?Q?GzVyleaXebP8tfEDb14jlVCsDhJ1Bdb06q4HyhxK+GK0e+iGdYp0j/1MwlTD?=
 =?us-ascii?Q?g4bLlBA6QFrcTA4CZ1Xzbt5w7OP7rWwu+G33HIDGdBXnK9yP3Uu5YSJjdWfh?=
 =?us-ascii?Q?ruCTfRLJpAbGq5qhEdCG3KXGUTmbV2lUFKni14UkIac5ayu68RQf2IC0PViE?=
 =?us-ascii?Q?orTgPaC0r6JfuJcMXHFXDTLthSi7WtCE9s7zlk13wIKhRYGzNgMS1xSuUT1n?=
 =?us-ascii?Q?gxV3mevgJO9gNKV9feaiV36uKgkWwDi6dRSs4Cn8kezVnoIarAGcax51BIFG?=
 =?us-ascii?Q?6O3CzKJkh4loEJHwPJeyAU/GCRGwRAoe9vssGVnSro74m3eKhfWov949XM8i?=
 =?us-ascii?Q?VEsl8d6Zd2pS7sCxgnDFx+O4dp3hFyBCv6YpxaQnA3DfxTpBQJR4W1dbJr15?=
 =?us-ascii?Q?W+KuAvn7WgqOIGQY2AemRSNMYNCxErbN1hs1ubR0h3+dcsqn47hIPwjDA+eO?=
 =?us-ascii?Q?gUjlVeZ7fYVcqGgYMjK0/WFW7sIQlVHkdY1MniY5nLlr2iOWvbtVGht+Jd3C?=
 =?us-ascii?Q?ioez+HiQ8cT6LuMb96Sl9LuVGJdsrL5xw5KSG+60HJiTIJgcci7EyT3juGGo?=
 =?us-ascii?Q?Qa5Hm63LHCTMC+n8M3MkiOKsBCuFoWUUQxHXX3xNE/0f76pQ9PUHBhaTrqYF?=
 =?us-ascii?Q?AnvqjYBqaEmaKe12XEmLaDJjrSL0uei7q0evioO+IG38ETNkM479cUrkyGUb?=
 =?us-ascii?Q?64vtsPmDZMyx4Y1vrI3avXh7iJ79V9MJynTYWd1OXO8EYZuG7R4DqnZ++nnq?=
 =?us-ascii?Q?k8B7Ul967U604MUHH8vAjx8+r2cD7jO4XJCHIQdkNcpPRJXiBMDXi9oe2dKf?=
 =?us-ascii?Q?WeS7hWzHzk2vS7QWL3FdefxIWpjRgyf320AFPqm5EgkGHRyppVjGh3ym7s+M?=
 =?us-ascii?Q?LVn5tHdeWFF8oIC+UDnly/7XXLkYZWs7cBfdX1xRCkIzdR9wznIh43zR2Gui?=
 =?us-ascii?Q?G1yDjhHz+HXg2ecErD7fjNPua4kUN0jzRra/FmkY9XNiGZNSvySI3Pkn/F9s?=
 =?us-ascii?Q?Q1mbUctJblhjc1zGd0H96UiEeOR1wBsf68DMvVBAWHu35mIk155JSxZ7kKq9?=
 =?us-ascii?Q?puUX8CgS7BeAikiMp9ethfOnG1GIs0BngIM1an+P0mriABvY4BD24kPggnwC?=
 =?us-ascii?Q?ZtS/ZqDPKpQ3dVm5+3J3hZjE7RCZx2funHvu+BFRYvhVsqbc5RfawYWDTPIS?=
 =?us-ascii?Q?GURGma9wkx2GwcQ9FGse+wIFivQe347alZgfEE2k02VjCemJpM6LSXNK8Ery?=
 =?us-ascii?Q?CEdTb6i77pK+QYo24Hbfh+gboLAf/D+t9rb3zZ4Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9b7659-b1d5-4470-e595-08de32ae27d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 20:54:30.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4p6N28gqjBHeIqlff6RRIGE047kXCqaWt8iESXh6rwu07/WTumPzfjhmOG6Mlpn2FpIWd2QmaBbRgD/Thh5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

On Fri, Nov 14, 2025 at 07:57:46PM +0000, Steven Noonan wrote:
> We should be checking the `smn_exclusive` flag before anything else,
> because that indicates whether we got through `amd_smn_init`
> successfully.
> 
> Without this change, we dereference `amd_roots` even though it may not
> be allocated.
> 
> Signed-off-by: Steven Noonan <steven@uplinklabs.net>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> CC: Yazen Ghannam <yazen.ghannam@amd.com>
> CC: x86@vger.kernel.org
> CC: stable@vger.kernel.org

Same feedback here as for patch 1.

> ---
>  arch/x86/kernel/amd_node.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index cdc6ba224d4ad..919932339f4a2 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -88,6 +88,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
>  	struct pci_dev *root;
>  	int err = -ENODEV;
>  
> +	if (!smn_exclusive)
> +		return err;
> +
>  	if (node >= amd_num_nodes())
>  		return err;
>  
> @@ -95,9 +98,6 @@ static int __amd_s
> mn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
>  	if (!root)
>  		return err;
>  
> -	if (!smn_exclusive)
> -		return err;
> -
>  	guard(mutex)(&smn_mutex);
>  
>  	err = pci_write_config_dword(root, i_off, address);
> -- 

This change looks good.

Did you encounter a NULL pointer dereference? Or did you find this by
code inspection?

Thanks,
Yazen


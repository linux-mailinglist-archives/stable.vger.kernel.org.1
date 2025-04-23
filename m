Return-Path: <stable+bounces-135249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4234A98241
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4821C4412CD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08826E140;
	Wed, 23 Apr 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="kdcABI/y"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2135.outbound.protection.outlook.com [40.107.247.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E222B585;
	Wed, 23 Apr 2025 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395230; cv=fail; b=NOs8X5aONHyJXTKVtZ9mQ8+UzL1Qpn4sqN5uTQSSHb/DZndYgrvX2HNOqWQLzSl92gGvK/4lohxomBEXJIEIEUfPteA05HU0PoASvA/r4SdNaQ5HWcJPRgEjAQ0lSZnZWhgvmRje+2lZQi8dY7HoycLsAaFgUrUwSWIf+8kg08c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395230; c=relaxed/simple;
	bh=HDV6B7FibzbojvODWFGP0Yw3+qFOfCVqyw9mzCkAs/8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WcmurQobJ+wkCheop7OBpRRERgl1f7js4vSi0NKotpjie6fbfkiM2vSoYfsOe54p/Wm0H+3Sym8BpyevON9tEKwX6bNXq1Y6WaY/JevmbNddETK5m3AOCkRZKhuozLICh3XV+Rsh/B6AEvDZkqhm8z91VgYMf5YV++1pmAicOak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=kdcABI/y; arc=fail smtp.client-ip=40.107.247.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+mz9daa2/Opgp/TDM1h0FkQWwPvsq7iyOK1BbE6hDJm66EXsZdCL64V2c64dmc59gatTV+MjB1nLWBlipHbI5RMXX2B7V2+c/CWadRUXf6qGFcvWd4y/MvURHNNydzfE3E95HEnqdpmCgReM1vQF00+RpWJnuAKp0qkUlIXmBtR3g0ItbDooa4IsRZ96h0Ma10G67ZsxBP7CkngTf76lzuEqAgi6Ghdnhsx9/aLtgcg/murFatTnBf3uJhHO23UjCjFc8i8wG+XCMd/KAq6b3kCxZHjjh1JWG7+vGHFtwCTqUHdw8v0HZvBcFmk45eHVefoY4XyFQTL2FqnOGgh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93F5jFu6TMTPDkIaG/a7mGf4rSgu0cwn4wPfWBA73xM=;
 b=Pt7ZjJJ3jTIsmg+0zF3XwtQ/SJpjEbLr1LEldzVQvAiO6+HCJ0zzxh7o246Om9c0sXCqvgaXgk1BWF3c6Ch+DAQSxf0ZifmOhcWnacN6g/mGkGxU7J9LF6emEsm8QKk/LoldaZ144HN92O7yNcJP0RWWGx4HK5wSvj+eEfH0Ky8G7gfB9eQJFT9fAOyQNs09beF5opPaJHyBUzinfw74Bbyy3AOMv8Of/xfHsL6n81wiIXFpAx7W70rjAaUTyMWumxyq+wwHDir8lDG4A1IFCm1YPZU24zynaOJhR6wqNh8Y1TT8FNWAcUVw9BXSFjH5Cj1gQIWJLjsEjFPcbg6H4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93F5jFu6TMTPDkIaG/a7mGf4rSgu0cwn4wPfWBA73xM=;
 b=kdcABI/yP+INzJhKmdOcyDd97b+YumJ37ur5CZkV6ZLew2vEgu4X0tLgd2NTQDQbmYgFzmcvKJ2iu9R3LXHEIF47bRbQRIHCN4ASomkb4ziYhBEIQAqb0f+5nSV3iWpo4jj1sgbRY7nrV2VqFve68p+5KUYhJfrm8aNvye1GmdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB4PR10MB6967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 08:00:23 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 08:00:23 +0000
Message-ID: <17ec22a0-b68b-4ac5-b2bc-986837639a37@kontron.de>
Date: Wed, 23 Apr 2025 10:00:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Philippe Schenker <philippe.schenker@impulsing.ch>, stable@vger.kernel.org
References: <20250422124619.713235-1-Wojciech.Dubowik@mt.com>
 <522decdf-faa0-433b-8b92-760f8fd04388@kontron.de>
 <20250423070807.GB4811@francesco-nb>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250423070807.GB4811@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB4PR10MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: bf07a17a-5662-4879-618c-08dd823ce6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU14T3FTQWc0WXRKUUYvWGdKcGphUFhuT1BUZjV1VTZsR1N6WldZSFllZW5V?=
 =?utf-8?B?aHovZkVOM1pMcHoweDFscVhwWWp2dmZDRUNOSlR2NUgvdU52NlBUZGxla3Zt?=
 =?utf-8?B?ak1sWVVzOEtJZThzTktkUzZ1dnFHbUhPUmZlQUtRc1k3TStiZW9WME8wdXNY?=
 =?utf-8?B?dDM3dkhkUVIyd1VIcklLMHpUSXQ5ZGRsU2FGUHZqazJ2VmxvZGwzNkVMcXJn?=
 =?utf-8?B?TWhPb1ZwTXJMTE5neXlyMy82R090aHlRNnJnOEtETTducVlpNnNSZEtPT1Fu?=
 =?utf-8?B?d0FSa1RWNUg4K25lRmJid3c0Wk0veUQ4ZEJ2bGo2RWp1TGFmQ1pJL1lIZXp5?=
 =?utf-8?B?ajlXZ3hLWmlac3JYTnFDQjN0czRWSllHNU5QcXVON3RNcERXN0g1STAreDdO?=
 =?utf-8?B?RFpwd3QwRmo0Y3p5S2s3VjVyeUdiVkM0M24rUmYvdDBSa3l5OS9SdU03cDd5?=
 =?utf-8?B?THo2NElKZnArU0Zzc094Sk5lOHFBKzNWY1cyUXZDQnRYME5CQ3JLNzFoUEl1?=
 =?utf-8?B?a3phTnN4RjFRZjlvREw1QVpGOFJlK3pCY0pFQ3pkNGczZTNqNWoxalNEbExh?=
 =?utf-8?B?YXk5ZnJtZjE1U2RhUlFwWUZHRTFHaDZaMkNKcHhkNnBKTlE0NUZ4N0pCelFy?=
 =?utf-8?B?TCs5Z2dScW9kaGtFeHptdzZtWndyTEd0THFpa2F0elpSQ044RVFyQ0tIYytk?=
 =?utf-8?B?M09QTE80cENhek1PeG5KQVY3V2ZsZEF1Q0xLaEx2SzdwWXlTQnJJeGlTM0Zi?=
 =?utf-8?B?Q2l3aWU0UERtSDVKNWpIc0NhT0RnMVdqMmN3amt2RXRVR0J5Nk1ldmpNcGl1?=
 =?utf-8?B?UWxNR0pQY1FRQU5mVllUZ2ZYWE5zcXBHSTVrdzNyNTdQS0E2U3JWMkcxMkJ3?=
 =?utf-8?B?dHNEOFJVV2kweHhSVjhUOWNoaWJJYis3a0NpVGx3ZTZEdEYwT0s4RTQ1dng0?=
 =?utf-8?B?b1FsZ3g3MHZMSkpremJhRVFoNW83T3k5RjE4cjJJYnNnaktFUmJGd3pTejVt?=
 =?utf-8?B?UXFRbXhyQnRIMVJYNlBCYkplMFFVRmVKWUtNQldSalVyUnM5TUU3SzZ1cG1r?=
 =?utf-8?B?NC9KOEkrYWEyQldPSTd6TlEzZ1R6c0JVRWJjOThRS1dTcHk4VjNScWFvNlRS?=
 =?utf-8?B?NTFkc1lhZVRDSTJCODFtb3hXV3VuTFZPdmFvcVVURDVCNE1KUGdFUHZFd1lI?=
 =?utf-8?B?ajl2aU8ydDZzbGhnU2NxZWRPWHYrZFVRVUVHc3VWRFgzdXBEVi81SmZwTkR3?=
 =?utf-8?B?ZGVPK1F6SzVCb0ZTQjUzR0FrMlZzZzc0WEFQNjZ5Vm10Qm9DZFZNOTl5MHBm?=
 =?utf-8?B?TWVkU05JUGdqTUJCNkVkSnRkSm1lQVJoayszaGJxSlg4L0g5VXFXL1I5VTFk?=
 =?utf-8?B?S1g2Sm9lcVVPT3g4ME4zdnFlc29DTjllUnoxbGdJdjdTV05iZE5MMzJvaHBp?=
 =?utf-8?B?L2lnaHJWZWR4cVJyd2VGU0lXRHZUT2FXUzgyNzlQbEtpa1E5RFRpZmE3N2lI?=
 =?utf-8?B?ZE9pRXc0MWlkRlZGbHJYSEhieGI5bjRic2h0UHRVa1VnUHdsaFZxNFlHTXlK?=
 =?utf-8?B?ZEhiNzB4RG5GcDV1dVVKM0VaWDdzU1BZR1R3NUd1cmhhWmpJQmcvNDF0Vk5j?=
 =?utf-8?B?cysrUXJ2VUF4VVdYckVkUGJMWmo5ZUQxK0sxL3VpdGsxREFUVE9LdU1ySHM3?=
 =?utf-8?B?UENseko4U2tJaTlmeUQzYWRvWnlneklyK0JUMVp2K0dReS8xY0k1VFhxelUy?=
 =?utf-8?B?eUQ2NStkM21UTHdlY2EySEFVdmRCSFJDWnIvaHZhV2FaZ2NpK01uNTN6SmRS?=
 =?utf-8?B?TEpScUp5OExFb0lLUzEzd0JUenorNnFoV2poRlltRUUwbWhMUkxKV2grZ3ps?=
 =?utf-8?B?ajlDTnZnd2RWODdzZWt6S3duMURHNWpMZ2RGMkY4aUFhRzhpcXliU1dxN25L?=
 =?utf-8?Q?eX7n83c/ew4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBUai9qdy9QSzBRWXd0eW8wVjQxMllJMFpHTDhVMTdXSUpOdktOSTR3Y1lu?=
 =?utf-8?B?QnNqb3FxSnR4UHN6UmttQ0Z6VzhiWWdyU05RTklTTzlFQ0RUSjRFaENlWjQ5?=
 =?utf-8?B?SWNXbXdqTitHY0lYMnNDTnk0MTVqSjk0cFZnWjY2Q0dCVUlaY3F3WTRpcDRI?=
 =?utf-8?B?YnZ3TWIyby94cVdwc2RkdEQ3UFZybEFtT3Z0MHRnekgrYmV6R1R3azR2V2dq?=
 =?utf-8?B?NEV1UG5WRFJtcTNaMUJrbUNsU003VVJuY1ZyNG1ibHloRjZEcDVXYlI2VFk5?=
 =?utf-8?B?NzhXaUU2U3JJM1BjWUtvZjI1bmpza05aN1JOKzZwSEZZM2Q2dmgzSWhHMWpV?=
 =?utf-8?B?ZitZdUErWkpHSUUzQktkdzU1M2ZxWWdGRmpVaGZyUGtGQjN6WFgzbktCT1lQ?=
 =?utf-8?B?Tk5FNXoyNDR5eWFEeDhjcS9sNTBJbllHUWhnUy9lNjI1Z0ZnY0FLVVdBZlV2?=
 =?utf-8?B?R1h6WGdPSXlXZHo2bGJRWEI0WTREYmc4REJqbElpZ2lUWVhlaFJONGI1SkNw?=
 =?utf-8?B?bnFjVG9CdDkvN2IxYTJabU9YV0VuS0VHcHdwS01hdFUwT0pqSjVEYkN3RllZ?=
 =?utf-8?B?bjVveXBCRUtKcStjQzBZRDNPOTRMaWgxTWwrQ1gzck9uRVEyWWFaUUl6WGhh?=
 =?utf-8?B?NDVHVHE5QmxvaUplUGxNcU1TaHh4Y2MxSFZKNFF4cVY4K1dQWGdES3hRWFdF?=
 =?utf-8?B?bVlnZWgwbEhiT29ndjJMdjh5emgzQTBJcWN4REJMRVZyVFJIRE04ekZDZVZD?=
 =?utf-8?B?QmZRcWlYYndBSnVpMzQ1MmJSWmJsSUZTL3kwNHNIUUNxMzIweUI2bUpwLzgx?=
 =?utf-8?B?dGRhUkdpZFN5T1RBYXhscG93VGVCM0g4MzdxYjE5dEtkSk8vN1d4TUZpNzBv?=
 =?utf-8?B?eFdBNHRmVTRPREFjNFU1NUVmTGZXWkE4ZU1TZG1GT3pRK1lXTUw1M0phTmUx?=
 =?utf-8?B?L2lVS01mUGRwRGErOWVRZHpuenM1OG1KSlJkMitLanBxRmRIdW54dHlxVU5u?=
 =?utf-8?B?N3R4RHhUbjBkWnluMlpCZ0Z4cThYTUVUNlJzTU9YbktBc2M1NUJJRmxUZzN2?=
 =?utf-8?B?VWpUSVVvSEZENER1cE05M0M0TFNiUFNXYjZ6eXFwczl3eWR1VWphc1dOYzEz?=
 =?utf-8?B?OTg2dDBiZ1FZMkY4YzhOVzRjMm9rd2U1ZUVmZUlyVkxjbk9MNTFFdkc3M1BW?=
 =?utf-8?B?M0ZXQXExM0RiSWtQdWNQUHU2RWVEV2VmdHNhcnVaRlFoS3BTN3NrNlBjRnMz?=
 =?utf-8?B?ajNnaHF6L1BKRml3cnN4b2lxb1pBRFVEQlNwZ2NQMk5vdEdwL01kUTk5MzBO?=
 =?utf-8?B?UXNSQmNIWFlxOUgwTEFSY2dBVFFTVkZtSWEvM2duOXdqUjZWNmROSnRCY09E?=
 =?utf-8?B?ZGlIazlMU0gzQVBPSXJ5alNjM2tzSTAxSGdwTDBUYngyNEJsNDlBQ1Y2aHdo?=
 =?utf-8?B?dnllNGRnMDVmU1E1cDdubzM5YlRjYnU5aFVJaHdQeEpQclRGejhMeWhDcGdm?=
 =?utf-8?B?U3pDdEdPRXVrYlpkd3VVeTZHemNqdk1MY1V5VlRjMDdwd2xiWGNBYmlIQnBj?=
 =?utf-8?B?Z0Nxa1A1djgyVEpobzg4OEJOTFhDZ2dtL2NpNERMd3hGc1YxMFBaUFZndURs?=
 =?utf-8?B?WWxtdmNwVXZGbmJWeWVITS9JUlpFUlgyM2tPT2U3bnZqTGhoOCtEVjNiL3Qy?=
 =?utf-8?B?L0lXRnFZNUZudU9wL1JrQjRSbG15QytxWVJiaTl4OEdNTFdsQWhDc1ArNWh1?=
 =?utf-8?B?bC9NSzg3bTRTRFBGNHgwTldGQlhENkFSVGd1Q1J5clRMVCt1RTZlN1FXOU0z?=
 =?utf-8?B?RVVoL0RxK3RvTmZpQnhuTUwrRTlwdjM2cDNwZTMrVmJKRm1wZm5KWEx0bWdC?=
 =?utf-8?B?VHBLYW9NUkFhSm0zb1VVOFBCWU1qMmE5V2N6TGNzaElsR2lYeFltQ1RYZFl0?=
 =?utf-8?B?UEsrSHF0dEpGQXFvdUphanVCalpMSmp1S3BhWkxJRmdyaG9STEl5MERySTVE?=
 =?utf-8?B?Vi9keHJ1V2VtVU1xbnNDSzlKcTFBT1Q0MGFPditxQ1F3Mit0REtzN1poTXVk?=
 =?utf-8?B?djVwM05SM0tmMFFhM2lWWGVjTEo1cXo1Mm1jK2FlNXlnUlB0ZXlJVk90dFpy?=
 =?utf-8?B?bk5rTThFTWk1cEUyTEYrZHFtTGpYVXMxYTZsRTN2Uk1iUURJT1prMnc5cW1a?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bf07a17a-5662-4879-618c-08dd823ce6a9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 08:00:23.7708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O53trp1u31ExbOWg2CYfZZ8mMoai/Y72/MX47a8jtcu2vop6o86m3qqi+mQSvklr+roxtd12M8SzUogoWbPKvhCsUXnPxrd8D6N91KEqxxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6967

Hi Francesco,

Am 23.04.25 um 09:08 schrieb Francesco Dolcini:
> Hello Frieder,
> 
> On Wed, Apr 23, 2025 at 08:50:54AM +0200, Frieder Schrempf wrote:
>> Am 22.04.25 um 14:46 schrieb Wojciech Dubowik:
>>>
>>> Define vqmmc regulator-gpio for usdhc2 with vin-supply
>>> coming from LDO5.
>>>
>>> Without this definition LDO5 will be powered down, disabling
>>> SD card after bootup. This has been introduced in commit
>>> f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5").
>>>
>>> Fixes: f5aab0438ef1 ("regulator: pca9450: Fix enable register for LDO5")
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
>>> ---
>>> v1 -> v2: https://lore.kernel.org/all/20250417112012.785420-1-Wojciech.Dubowik@mt.com/
>>>  - define gpio regulator for LDO5 vin controlled by vselect signal
>>> ---
>>>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 23 +++++++++++++++----
>>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
>>> index 7251ad3a0017..9b56a36c5f77 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
>>> @@ -144,6 +144,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>>>                 startup-delay-us = <20000>;
>>>         };
>>>
>>> +       reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
>>> +               compatible = "regulator-gpio";
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&pinctrl_usdhc2_vsel>;
>>> +               gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>>> +               regulator-max-microvolt = <3300000>;
>>> +               regulator-min-microvolt = <1800000>;
>>> +               states = <1800000 0x1>,
>>> +                        <3300000 0x0>;
>>> +               regulator-name = "PMIC_USDHC_VSELECT";
>>> +               vin-supply = <&reg_nvcc_sd>;
>>> +       };
>>
>> Please do not describe the SD_VSEL of the PMIC as gpio-regulator. There
>> already is a regulator node reg_nvcc_sd for the LDO5 of the PMIC.
>>
>>> +
>>>         reserved-memory {
>>>                 #address-cells = <2>;
>>>                 #size-cells = <2>;
>>> @@ -785,6 +798,7 @@ &usdhc2 {
>>>         pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
>>>         pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
>>>         vmmc-supply = <&reg_usdhc2_vmmc>;
>>> +       vqmmc-supply = <&reg_usdhc2_vqmmc>;
>>
>> You should reference the reg_nvcc_sd directly here and actually this
>> should be the only change you need to fix things, no?
> 
> If you just do this change you end-up in the situation I described in
> the v1 version of this patch
> https://lore.kernel.org/all/20250417130342.GA18817@francesco-nb/

Thanks, I missed that discussion.

> 
> With the IO being driven by the SDHCI core, while the linux driver
> changes the voltage over i2c.
> 
> I was not aware of this sd-vsel-gpios, that if I understand correctly
> should handle the concern I raised initially, having the PMIC driver
> aware of this GPIO, however I do not see why that solution should be
> better than this one.

See below, but I'm not totally convinced either. Your solution didn't
occur to me. I came up with this series instead that is now in mainline:

https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/

> 
> BTW, is this solution safe from any kind of race condition? You have
> this IO driven by the SDHCI IP, and the I2C communication to the PMIC
> driven by the mmc driver, with the PMIC driver just reading this GPIO
> once when changing/reading the voltage.

Actually the VSELECT is driven by the USDHC controller, but as far as I
understand control is still in the hands of the MMC driver using
sdhci_start_signal_voltage_switch() and ESDHC_VENDOR_SPEC_VSELECT.

So we actually have control over this and therefore race conditions
between SW and HW shouldn't be a problem.

> 
> With this solution (that I proposed), the sdcard driver just use the
> GPIO to select the right voltage and that's it, simple, no un-needed i2c
> communication with the PMIC, and the DT clearly describe the way the HW
> is designed.

Yes, but your solution relies on the fact that the LDO5 registers
actually have the correct values for 1v8 and 3v3 setup. The bootloader
might have changed these values. I would prefer it if we could have a
solution that puts the LDO5 in a defined state, that is independent from
any external conditions.

Also I'm not sure if two regulator nodes is a "correct" or "good"
description of what is actually a single regulator in hardware. Although
I see your point of describing the control registers and the IO on two
different stages. The problem is the dependency between them. A simple
reference is not really enough. To fully describe it, the GPIO regulator
would have to fetch its voltage setpoints from the LDO5 registers at
runtime.

Best regards
Frieder




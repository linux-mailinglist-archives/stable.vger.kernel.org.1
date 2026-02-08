Return-Path: <stable+bounces-214867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIjYGS/TiGnLwgQAu9opvQ
	(envelope-from <stable+bounces-214867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF7109D9E
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 19:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127C9301CDBA
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2AD2F3C0A;
	Sun,  8 Feb 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNycbosH"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1082E7F39;
	Sun,  8 Feb 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574359; cv=fail; b=F6krpmvC+/M/8YCrKSKWSET01GJFFMOLYBsqG1lLGHTwojJ7b3kDy+xOh3IfcGO0gYv1gFMlGSsQoTgEMC890hyByOBmHOFQbq1dDLnrcjnlpj1QKOUEStVhTyLTNWIXZjE0Hi+39r72eBizcaWE+kfGVkZ1wb3p3c/Gtw0Tjfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574359; c=relaxed/simple;
	bh=hhVwOA/cnEkHe+4IuIMQ5FRe2UX9s3DSGhEoAlS9ScE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YPnPeDE3VMFdPpPUNNB7XefzHH16ILS2kLUkusEHib3tWsbNR8xtQW6dD1RXITOewIIBnpfAL4s6JU2kKBPZ/pdhfHedIlXexOcmjv3EdUKxrGJBaVFs2oDOH0tEagiY9Jq7/aBte7EPoeC8VFGjah+IJpPsVTef67BrToPvI3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNycbosH; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US/jHTC7zv9ELXljfE9rYn9EnU6jHmJANvhYi/oXOsd8qPwwlWGkTYIFOYM9AQHg/YW2J/wWue5OegUXvuPvD5M//bpPwx5AMPZxDfAFR2t4dlLYPQ+FMbSe7ku1k4vqT/U2iG4+xmxuGxGd2iJW/CEKWdpWbU6c/6RxM47H/FFhVMeuczj9iXbQ83HRY9scDeFUo4m2XKgp24sPPSjQXO8Qddp9T5OqC/NMr6+8vdlv0smyaFhctnvwJwgNwPi7g6snQ5bqbu0KWZHhEfTuBhKUktl2/gnrp5mfj6TSBYRClPiMh8Iflicaw7TlVnQJ9+VgUWm46nfiqzntMBZ2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUVBWtrU+t7YucXzp4yecSgEcRpC0GBv5lfsBeNtXoQ=;
 b=Cok9Rv8qN8vFBmV6NKh/ule1BbdTc5ocNvNSYKV+Tq3KRXFZbRFk7k8/7AlMqmmTYduberdauNaqWYDzLQTmSsoaHv4O1rAd8x5ItESduZV9AR++wiajKduM1ryBLFElB8xw3cKR2j7YA56c7d1hMNbPWpeOzEMF9DK4XDEiI3SOixHzoFoAHNnHC/3jFW+i9mHnEs+P9HKYjkQUVv8PGheuwJ1xUVztuJD+y/gvw66At1W/+pNZJ/Vlxnz/P2CXLS8km616jEAqWfRuzL8kGoYMUUDs6NnNXiA6uYcMJCJruYQkQYF6P8IlzeDrSEN/zqv0n/KMlTLjXKcI12o0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUVBWtrU+t7YucXzp4yecSgEcRpC0GBv5lfsBeNtXoQ=;
 b=qNycbosHUlyC4FVE/GEWj9iO0NGfe9ZSCPHdfUgRQBS/G6YxyfNtATOr2zV0IJV1f90jbChwhvr1oqCIlaCt6SQQmzoEgujHvcnRe+/IlyUd4alvWlyohKkBUkQbZLSJTN7rU/zQzMbPBJHN8HkhMqSBYn3NoH8H1YUuWHQ39qTz+TdY9ot6KjKf4BQ9b5lSCTNhTGp1L4tRr2jQmM8YH4tuBrb/76Xnn9QMsi2otcjYGuv02tn6YzOK0E4QycMLO50iZtyhZoHFKrWnxiz/8+BO/xPW+6D5Rs62r0SyEmNlUJRYs+7xwxpXXFBk/2M+mwNeoa7SYf13v+teG8h5BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:12:35 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 18:12:35 +0000
Message-ID: <2fedf28e-83ea-4e51-b1a1-e45f0e928509@nvidia.com>
Date: Sun, 8 Feb 2026 23:41:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: tegra194: Reset BARs when running in PCIe
 endpoint mode
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-7-cassel@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: nvpublic
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20250922140822.519796-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::8) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: b026af84-1f60-49a7-80aa-08de673da26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGlpYjU1OHRqNWp6d0o1NzBLZGsrbXFWS1haNUFOY0JxZmUya0hlT05NT1JF?=
 =?utf-8?B?TENlWnBscnk5Q01SOE1KcVQySGg5UmVGYmxqM00vUjRMQ05SM012REduRDI2?=
 =?utf-8?B?RjhoVUFja0JIeWZ2Z1RzRFVLTVRqWDNhMzdsNEk5OXNOd0lTMkZtcFZ2UDk4?=
 =?utf-8?B?UkFKMXhkR1Z1Ykwvc2pZMkovQ3VZczZYWkRuRjZldUdHaVV1cnZ4MFBObHpl?=
 =?utf-8?B?Nk5VSVRoUmppWTdtUnBPWXoyaTNoeERKaHRscTJ5UUhxM0dxRlhVd3g0b054?=
 =?utf-8?B?ZHBXUWdrQTYrSzMydlBhYjJjTkxzTURhM1dDK0JWS0Jmd254VDRqTkI0ZmRy?=
 =?utf-8?B?TXRHU1VJaERUTHFMM3d3NU5zUzA1VWZRMVV1dEtaUFcwaXpFOENyTjZ3UkMx?=
 =?utf-8?B?T0JNdWMyT1dRUWRROUNEWThvM1BtNGpZSDYzWkp6YjdnYWZkMk5jZmlzd3dH?=
 =?utf-8?B?bkMwa3ZqdjEzdmlJYkpMSHFmTlpDeGczUmVBSG9YUTN6Q2NVc20yZWhoeUIv?=
 =?utf-8?B?dytpUXRXblBzT24vWENIbHlFVGUvOFNCdVphQStjeTNPcStza0xhV0ZUUWxp?=
 =?utf-8?B?eFNXd1Jtbjh0U1k4WklrMDZVNjRoYzRnaTBibEdFQmIrck1TUzVnTzFJVmM1?=
 =?utf-8?B?OHE4Qk5WMGQ1aG9jYmZtZHZ0UWUxTEpkcmxqVDk3V010RnhGd0pqMDFUMSti?=
 =?utf-8?B?SVljQ3ZMNjNRV3RwSGs2MXp3RWZ4VVRjanRNV0dTM3RjcTN1N0tiVDB0eWhh?=
 =?utf-8?B?UC9sS0tOM1o5R3ZrbVlGVmhQMFdBb2F6VGw3cGJEcHplcVhxRjhtVk1hZEEv?=
 =?utf-8?B?bzBsb1JBWi82VGdQV2RWb3ZwNTJUM1Y1dGdwb2t0QTN5amExZ1AvS0VSbWhz?=
 =?utf-8?B?Q2tXZjdmZ004QnlkemdVcnF6WVpkcTFaL1c1ZmxJY3BUUStFVVloNlRKSlBK?=
 =?utf-8?B?bHBuS1JlT1pvTGdtMndYb2FVT2cvWkRDMWtqNEpLaVdKMGo5bncvTktmcFZo?=
 =?utf-8?B?YW5zUHdtTHFVNjg5NzFZRk5tcUNIRFFuN2hONGNXM2I2TlpSLzhOM2x6RFV1?=
 =?utf-8?B?YVZTbTIrUjAyUkZQVjByeDZJcnVWTHhxVzg0dUd3TzZlS3dTZEV6TU1aVU81?=
 =?utf-8?B?YnJrTk1Dbi8veCtLdXI0NzlCZE51V0JqT3Bhc01WWGYxT1NrWDBtRVNDVC81?=
 =?utf-8?B?cG90YXkwL2RGaWVtTkVQNGlUNGxMcjNVZmhLVEZ6R3hKVVZZU0VEaVB5OHVK?=
 =?utf-8?B?VnI0Qzdrc2dYRFBNN3h2NVc4R1Q1VmJwS3FORm1XczhacGxNYnFzTkcvM1U3?=
 =?utf-8?B?cUk4Vk94VSsrajdvd015Z3p2Rkxyb1dVSmFodDRJVTJjdVNJelR6SGFnMWNS?=
 =?utf-8?B?YzBkbEt3eXArVWxmSDkzTE5rWjNkS1FPVjlCWFdnUkh3YjhFSHpBNjFXK2pB?=
 =?utf-8?B?NnhVQVkrR0NFVXJBYjRhUERDMGJxSnUyRnR5OXpiZTVqLzlTWVZndGVQN3RW?=
 =?utf-8?B?UnE0NHcvR2NnUXZ2K3FGTU90SWdnUTVFcnpCWlhaSlBqcVNxR0RBN2dmWU0w?=
 =?utf-8?B?Wk1SbWpscFUxWlRyTWFZZ3lHUy9uNllRaVZvZVNwSVNLV3JLMGoyT0dzNkpZ?=
 =?utf-8?B?QmpFaDZPMlNxL2U5dW1VRXNKK1Y3N081WUZIakJnVUFjb3k5alN5aEtnKzJC?=
 =?utf-8?B?clN1SkQvRWI5TEtUait3MW41SlphQXVXcFk2LzlscDF5c081SW9EMU5tTEUy?=
 =?utf-8?B?dHhacUNCNXZ3WThZYmtRWmlNR1RXUGpnZDJIYlFjbEROTmE3SS9RQjNQZzFz?=
 =?utf-8?B?NG5hZ09xVGczR0ttTjZiTUkvTTR3V0lOL3BBWHNaK2NyVmFoYlU4N0hTcnRo?=
 =?utf-8?B?OWJWaGxRSDRpdWFVbzYxdlJReUtCNDRjWlVCNEk3NVVSLzl2N1UrNkNzR05X?=
 =?utf-8?B?NGVmelQ5bjR0VGU3bjA5SXZheEFVUEdlbnVtM3hwR0NWUUphMWpydlAzeit2?=
 =?utf-8?B?dW9DYjZMWUN3SGVJd3FjQll2V3loUlEwUEVIcDEvUnFGNFRCcmZGdXZUanBR?=
 =?utf-8?B?NThrK3dmWlI0VExXK1ZtZUk4eUlkUysyamVuWjIrUzgvRnNwNGpCOEZNdHhX?=
 =?utf-8?Q?KvTk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9WNExDWUZvZzloa1Rqa29qTm45ampqaVN6TzFUblRueEszQ0M4YWxqd3hP?=
 =?utf-8?B?WFFHeldZRUhnVERVTjJJSjdhTVB5VkxkcU1USVhmREFXeW1vYmJqbzdjRHk2?=
 =?utf-8?B?WENXUE55bjhVRlBsZ2NmVmZDVUN1dnI4M2Fub2ZVRXZNZGxGREg4TEhKVkFP?=
 =?utf-8?B?NzBScllib01MWkgvd1FOSExKOGM5Y0h6R1B0NXU5TStmaEJWNmZBYnF3U1JN?=
 =?utf-8?B?M0dKbVN2VHF1S0ZKbWdJL1NZd3hDY2VueUZ1bTF4RVkzZHZQWDlDK1V4R3c0?=
 =?utf-8?B?bnFFRTlkKy9PdXZJYzlFUElMbTR4K3Z5OWhnTmZBL3cxZHZCQmZwb3pNbHlx?=
 =?utf-8?B?ZzdmWGlOS3ZmZjhnVzFFaW9NakZSNGpIeTZwUFU2VUYwMGV6YWRleW9ERFh2?=
 =?utf-8?B?RllmSGM3U2VPMFFCZ1o1RDhHRFN0enhQNk1ITHdlbzliOEhNbFBxbEtnYXZB?=
 =?utf-8?B?S2Q5MDBvVjU1YlRzMndLcFpPMUNaVlVsOWFxd2ZxUVJETlF3Vjk2bHJvWmxF?=
 =?utf-8?B?N25FYk5FVUtGOUpvUmYwcHI5VHh2eE5aMUorTGFZb2crZTdITXJ4SFFjZDFE?=
 =?utf-8?B?WHVmb0VQMTFWVytrRlhqWmhVbExiSFMxcGJZVTZpZUtvcWpDeTJyRWFXS1hS?=
 =?utf-8?B?U1hucHE2eDhpaG94K3RIRWQrMnR6TUlTdnlsWEt1WHZhU01wMW1mamZQT2RW?=
 =?utf-8?B?NnVPL3I0MHdWN25hbkQwZFhVd1RTZ3IzbWlIYWYrb012THA3NVBDWjd5RFVC?=
 =?utf-8?B?TDQzNzJxQVgrUkJUNWR6eTlIakEwcUEySVUxMWozMWpqeDZ1ZzVNZTAxR05R?=
 =?utf-8?B?Q1FvTHpmb0JSb01YRUxJRzc0bjh0MVpyckZiOVpsWVdsMWtCano3MXN3dWtP?=
 =?utf-8?B?YnZHenR5Tm9nRWZYcWxrK0k1NVBtNTAvRkhQR0ZGRW96bXp3U2tZK2l2Um9l?=
 =?utf-8?B?ck42em5rYmJ1SzhWU3ozSVdWYUlMekwwTFNUdVpLOVh5Q1BtVTdKTmhYSWYy?=
 =?utf-8?B?bWNlbDRrdlJGbjhBZlJ2aHcvcFFDei9wSWZ6YlV6bU8vNlJiUEt1UGx4b1ZS?=
 =?utf-8?B?bHB1OW1FdW1vYWQzRWFnTThZZ3BaUldoSEM0SzVTamxBQWpIRzROeG5IKzA1?=
 =?utf-8?B?VzB3c3RtOVFMbU5aSy9QTWFxd1BaS1I3MzlLM0xvUDM1S0lrNGlhWUVnOWk4?=
 =?utf-8?B?TXNZNTg1VmhrQ2hkdzNWOGdQc2daRzB0WEFwTFZGNXU1MzluMlFIN3RXdXZl?=
 =?utf-8?B?UEJHVWRWMlJnQUZUNDZGWEk0K2ZDd0hDQXcxR1J5YzlsYmYrczh5TUpocWs1?=
 =?utf-8?B?WmI0TDU0UnRBTHlHNnRzUkxiWkNTWDREWDhGV2xtenhOSS8xSi9mcEVDc1F1?=
 =?utf-8?B?Vi85WFVVT29tbFUya2xrN1F2RzB1ZVBzUi9EVnJ6UE5PNDlrdnNIdGR3MHdu?=
 =?utf-8?B?Mm0yRXEzTjMwMHJFS3Y0T1hhdGJFcWMwc1VCbUdEc2xzSlZHS0QvTk10Y3JH?=
 =?utf-8?B?Q0dIbU53d1lMNUYrOWRMN3VmeDE2VDVmcDNvaFd3SGdCbDQ0QVFXTDBxSjFV?=
 =?utf-8?B?VjgzM0IvNW4zUUhXeGtnZXlLOHRjYUI5MnFtQVB2cGFaWTFHSjhwK1RSZDI3?=
 =?utf-8?B?NG5PSTgrMHhQbnhTa1lFN2dQL1hDbERKZ0g3NVlWZ1JGd0s1dG5RbExsei8x?=
 =?utf-8?B?eUowUjlibHpjbTVEd3FzZVdPeVdkMXIzdTVGdWtMQWt3M0R5VXFXdHZHTlpY?=
 =?utf-8?B?WFAzUjcwNnNSOGx5ejhncWo1WWRKckRqVTl5RmRJamRXcG5EMWtyeGloOXd5?=
 =?utf-8?B?NVM2RFoyK1RxZWdYbkMyaVhDc0czZ2pOMzVGdjFiV2R6cXpvN2xERTI2eGFp?=
 =?utf-8?B?V2pCU0E0bEdHaS9mMHFNVVlwL0ZrK1RocVhOWDNGVm1QaVFKZCtBMEVGT3Vm?=
 =?utf-8?B?UVJ2akdqUlcvcjZMNTJ4amdrMzZGQ0lwblZmaG5scmk0aEZMQisrQ1cveVQ4?=
 =?utf-8?B?ck50b3E5cG1xU284VkUxNUl5c1FUSDh4UDNneTBPOUc5QmEvSVJmemlJT1VC?=
 =?utf-8?B?Z3pteHJyT040MW1pK21zYnBLMExZYll3YktrN1lyZ1hzMnZEb0ZwMXJHKzJP?=
 =?utf-8?B?M3NHeEU4SmVxd3JXVWRHeVIxOGNqajlUQ1lzMnZyRzM1cENkQUFWanJQV0RG?=
 =?utf-8?B?L0dkOERreWI4TWMyOEM4UEdEdjU2RDB0V25KSG54amVFWHdoLzRpc0lSL3NX?=
 =?utf-8?B?dnR4QUZtRTJMSFpFc2ltd0RtWEFyd1hPSXNVU0VNanJTWXBhaHBnSU4veVVo?=
 =?utf-8?B?QmZsSVFqL0xaZG1BeHdBcWZTMVRUUlhUaHh6OXlNeGh3YkVFSXdVZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b026af84-1f60-49a7-80aa-08de673da26e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:12:35.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAPKlliHAWHgt4STv1Ykc/dBe9F1uQlPWZvUb0mnglMFgyrJJ7RK+UKZpvZiggHLpta//kU5kOTyYTvjZO2LKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wdc.com,vger.kernel.org,nvidia.com,kernel.org,google.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214867-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmaddireddy@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CBBF7109D9E
X-Rspamd-Action: no action

Hi Niklas,

Tegra PCIe exposes only DMA register over BAR4, not iATU.
So, the issue described in this commit message is not applicable.
This patch is disabling BAR2 and BAR4, after enumeration I see
only BAR0. I think we should revert this patch.
Please share your inputs on this.

Thanks,
Manikanta


On 22/09/25 7:38 pm, Niklas Cassel wrote:
> Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> This is sufficient for pci-epf-test to not allocate backing memory and to
> not call set_bar() for those BARs. However, marking a BAR as BAR_RESERVED
> does not mean that the BAR get disabled.
>
> The host side driver, pci_endpoint_test, simply does an ioremap for all
> enabled BARs, and will run tests against all enabled BARs. (I.e. it will
> run tests also against the BARs marked as BAR_RESERVED.)
>
> After running the BARs tests (which will write to all enabled BARs), the
> inbound address translation is broken.
> This is because the tegra controller exposes the ATU Port Logic Structure
> in BAR4. So when BAR4 is written, the inbound address translation settings
> get overwritten.
>
> To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
> by disabling all BARs (pci-epf-test will later enable/configure BARs that
> are not defined as BAR_RESERVED).
>
> This matches the behavior of other PCIe endpoint drivers:
> dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and
> uniphier-ep.
>
> With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST
> (which was specifically made to detect address translation issues) passes.
>
> Cc: stable@vger.kernel.org
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 63d310e5335f4..7eb48cc13648e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1955,6 +1955,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> +static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +};
> +
>   static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>   {
>   	/* Tegra194 supports only INTA */
> @@ -2030,6 +2039,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
>   }
>   
>   static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.init = tegra_pcie_ep_init,
>   	.raise_irq = tegra_pcie_ep_raise_irq,
>   	.get_features = tegra_pcie_ep_get_features,
>   };


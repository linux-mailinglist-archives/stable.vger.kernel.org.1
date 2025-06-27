Return-Path: <stable+bounces-158727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8EAEAD81
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 05:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485FB4A4A86
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 03:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4EB199FD0;
	Fri, 27 Jun 2025 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVRleTtu"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC115746E;
	Fri, 27 Jun 2025 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995891; cv=fail; b=mgsOaRAI7SdHfpW5wp/TyJ8oPJjqx0jiyaCasXA9ZFBTfrHvZuzFQd7t/7KGQW2/xjWES7jcd6SaKXO2taUKolRwbJl2ZYOVs+vgUfih3EoXbGyeVDRI96mqAzoy9S9RmZTZEp3HmIEWNpR0ev9jJjlcaYTRCJAqyGDf6j+qepw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995891; c=relaxed/simple;
	bh=VJkKv8ZsRyzFio8SOugo1OrIJ4s5O7Qy26/7lJIOBV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTD4NsX/OK3pkw+GTojHdh+c4eLDxuPlm5E7A2Xs6oBaprvan8K5EwOtsk6wOhzion+WW39USJJf6ivsscRyiwQM82Gop46l7AK62cm2lTb7kyqqPwMKIiw5leCbfkjzKLgCyh3iXkjSxwOvbGiLDRJJ8k/grv5deNfogj1Ress=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVRleTtu; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ2fCBnALUWiiE46t+gpcVA+lkbple3xPMSuUAhDaixqOMOZ4ECXP1GT7mLL5M0vLfwxnMbYZSB7AgDYsWzWNpqBIfCivNGxoYPHwyF2tCRsLtMXTIEmfbPXqWdYR12o5ENlBCV3pQ+Dq6tik69/kgZv/zPCSNhWE3vMonYZOg/GxvDA3WUqBVRp8rQh67hpXcsVlWwD3TU9x6ABOcD2E0Xhp1ymGwCynNk/sf2NdnEKD22nG59HUMaxLscOXV1V62AsSQp68Vdn9uOm/R1tmowtWBXrmRRPUvl8/yhAn2HXbKn38sNR3Abm1yFtDowkhjEBdQ0qzB7V21U9qMDVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LA2jxf4Xkekbo9EjIvEp5EOUeltDYFJgEb8htNcLz4=;
 b=PyEtatMyulJA/pTGoRM44xrzJVoxIY5772lhIl7hna5gwA/S0O0+Dl6bpwVPUmC5FI3/k1sIwDfDcBJvxKYgj0Nx8EfXumFesDwhBGTeavwkkDZ+uaQsCtz2DCfF9aS3EGhWvDFolZnZ3KKU9y/k6nGuKNQb01XZh5TXYabTV3kkPnmi2yrrIrvrBplVmSyE2xM6WWyDT8Lr/6U1XFbtvaBHpvj0kR+HWBlqxlFDdY0AHMS8839Lnm6lcAiOHTubm6GUTFv5piAwHLMXP+dlF+lwwsl7HCSQ9iQQbYSoQjaKujDTI7FAM982ZmoSf76CYJTGNog/YrKzN7XmaLTwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LA2jxf4Xkekbo9EjIvEp5EOUeltDYFJgEb8htNcLz4=;
 b=LVRleTtuV3z5ffdkeLoHvDZKVj8q5DEqjBFTWja77M4/WoxtABAwCwz8MjkwrUQAVACZJh5fDIYWsPjKHXvTqgGl8BQ8TB544/LWjkxo13Q8GQ0nVkWXJPQPXfRwCjNGWo8a9uRpulYqL4+6X9mjrfJPSNMMqanR9xpCjnoQs2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4SPRMB0045.namprd12.prod.outlook.com (2603:10b6:8:6e::21) by
 SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 27 Jun
 2025 03:44:41 +0000
Received: from DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78]) by DM4SPRMB0045.namprd12.prod.outlook.com
 ([fe80::3a05:d1fd:969c:4a78%4]) with mapi id 15.20.8857.019; Fri, 27 Jun 2025
 03:44:41 +0000
Message-ID: <482239bb-2b71-4175-ad33-772856eb8332@amd.com>
Date: Fri, 27 Jun 2025 09:14:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/sev: Use TSC_FACTOR for Secure TSC frequency
 calculation
To: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, x86@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 aik@amd.com, dionnaglaze@google.com, stable@vger.kernel.org
References: <20250626060142.2443408-1-nikunj@amd.com>
 <aF0ESlmxi1uOHkrc@gmail.com> <f2292bcb-ccc5-4121-98ce-bf65c0590131@amd.com>
 <069049ff-178a-6d94-d161-5a7b90b6245c@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <069049ff-178a-6d94-d161-5a7b90b6245c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::8) To DM4SPRMB0045.namprd12.prod.outlook.com
 (2603:10b6:8:6e::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0045:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: b4606dcf-7182-40a4-f5c7-08ddb52cf2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFJlZjROZGphQjFRUHpkeFhFWnBGNmtEeHltS2ppRVl5QURmNnlkNUdnRmts?=
 =?utf-8?B?ZXF4L2llTnpuZ3VObWRvNGFnajI0R3lzMG90UGQ4RkVNUXl6cVJ4RTFOekxI?=
 =?utf-8?B?elZzZ3hQV3NoNVhwYzBQYmh3Tks5OHpaRmYxZ3RtOVgxNTlRVEtGZFc4T3Vx?=
 =?utf-8?B?TGR2d3lXTnJBUTFPRjZ0RUZneElQQ21Yb2g0bEJ2cldQNGt5bWNveFdKWnFE?=
 =?utf-8?B?Y3BsSEtMYVhuV2Z2d0FROWlxZ2F0Q2R2M0JxV2RBWGVwZnI0RS9RbzFvMVJv?=
 =?utf-8?B?eWd0cXF0akdyZ1lZMVVvc2hzUHlEZWFWNUs3R1FBWEZNa0t0VnBOVzVaOGlF?=
 =?utf-8?B?UG85aXZPa2NNcG9JbnNsNWpzcFpHay9XaFlnSk82ZThVMlJCM1VnV2VIOFVT?=
 =?utf-8?B?bWhtcEswYStRbFljenAwaUhIQ1M5czkzSmR3VSs1VEFNOFpvNlp4OGVzZkJI?=
 =?utf-8?B?dmZIcGpYTHQyaHQ1KzcrWkdoZXM5RWFHWkpKb25Ea24ycTJNSDRISUdXZW54?=
 =?utf-8?B?Y21JbzNqbTlrZmZuZ1dOQkpTN3BlZ2llNVJYU1g3RElYYmMyb2Z5TnRUZG5J?=
 =?utf-8?B?NlRNZ3g0Y3A4K3FKS2lOZXhzN2pkM1FMMGRkQzJuMUR0U25Jc0pTMzJRZi9W?=
 =?utf-8?B?WUZraVpDaCtKUElEbGxwUXhOM0NVTktzRlpxWEhqQ0FWcm4zbUJyNDd0cFR4?=
 =?utf-8?B?cmRxa3J1bTYxekt1c2lkZFBUVnBUZXBEWlFlRGZxa2d4VmJPK0dodDdMMnFZ?=
 =?utf-8?B?c0hNNVNCQ2dRT212ZnRoNk9LVlpucE5xUi9GUU9WNmZxM3dzK29vSWhSc3la?=
 =?utf-8?B?YlFKNXFLbEFHTWJYV0N5YXROZS91VDA0NXhJVm1kcFoyWjY2NFR5UXVkOTlK?=
 =?utf-8?B?WVplUWc4NXRvbXRoN0JiN1FGRW0rT0xmb1dobWtlY1BDRldQRWFyZERueFcy?=
 =?utf-8?B?VkR4YjgzNDJtS0NmRVlXaVR1ajc2RFBCNlhIM2JhR3R1Ync4R2YyYU9rN0JK?=
 =?utf-8?B?akNqQ2JybXhheVU5aEd2NjY0Um5EV0FkUGw0eTBCS3pQUDFIRjhsTXV1RDJr?=
 =?utf-8?B?Z2hURWlXSjdVdGtJMzR6TUtGUHdjZGxxM1crTVNKSkhiRVBLRlFuWVpLYXBh?=
 =?utf-8?B?STlHbmpkdXdZNlhHUzJRbUhQL3BtTDZiTUZxMmtiMTRwb2MzZFNsUTNtenQy?=
 =?utf-8?B?T3k1cDJWTkRJcUF5eDBNVUxiWGJwUWt2R0tjWEthb1VEV0k3cko1emxYZVp3?=
 =?utf-8?B?cGlkSUxTcFpZdy9pYysyOE1VTFJ3ZFg3MEpjYVFLZ1RUUDhna0R6KzhnQ08w?=
 =?utf-8?B?WW1xd2lhQ3M4eWR4ZmhaeWVBdC9TN2JRSHhGVVRGK3Z0Z2U2SDNyT0dITWNz?=
 =?utf-8?B?eStDdTZTWXgyUDE1cmxQcldJL0FIVkdKMGhDd3BEWVNuQWtxRm1UMGJBSHZP?=
 =?utf-8?B?TjlYTXRZcnNEdVZhSWxvL1pSV1lxRGFhQjY2WE51OGdLbVl0NEQ4NnJlelY3?=
 =?utf-8?B?R2IybldhMzkrWGFkV1JwUUpqRElDS1RhQ3RoT2J2blZSTk04cGJGQkJTcjZ3?=
 =?utf-8?B?RGpIamRMOXlVTVNQMnlmZFFKdk9PcHZiUXdkdUdsdzU0NW9KYnJzMnFuT0J6?=
 =?utf-8?B?MzBuYWVqNW1DNzJmRTdIS09Td24xVWlXQWdUWGEzQTZkQTIxZS85U3Qxd2xJ?=
 =?utf-8?B?aWQ4YndJMEgvWVVxNk11Rkl6Yk5hd1lkYlVXNm1wQXJGcU1IWlpaSHpkbGpx?=
 =?utf-8?B?V0ZTZDdzMzdkeml5cmVPMUxFVWpVbDByaG1EZ2xoRHVOZnhJV3lQTTNXZWpo?=
 =?utf-8?B?Y2Y0V0hZNXlTdDk4L1RkNVltenpobSs3U3U1Z0dXSm50em1hTE1xaGgybUEx?=
 =?utf-8?B?akFqSkUrTjNZMGdUTmg3aThnU2tLZ2lsSERIcDM3MkJ0cHhMcHdLK0NmS0NO?=
 =?utf-8?Q?BhsrHJIRNS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4SPRMB0045.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjNNaXZ1Y2ptM3dJL1RsVk1VdkloR2xna29VQ2dPeE55ZFpHSGRZWlgvMTFx?=
 =?utf-8?B?UFd0WWljTG9RcXJJSENPOURoL0txaVlOTHkyVjMvejIzNHdBTlQ2d3haRWw1?=
 =?utf-8?B?WTJtSTBlVC9wVy9IUzJRNjdYOFpMS1RHV2xIMkNheFh5REZ0MUt3N2ZrTHY0?=
 =?utf-8?B?WWpMSHh1OUhIRG9YQjZpcDQvRnJPNkZ2RHN3RGxUelRySXM1eExNUG5mK1hp?=
 =?utf-8?B?L1BFNDhQRHpQbjZUUk9MZW92czByWHJjemhVNlU3V3NIZ25hZ1FWVXBjMzRy?=
 =?utf-8?B?V0xqa0ozQWxVSUF6Ym1yQmFGYWVpd3o1SGd0YllMYTRQQkpPS3JCUUN3K2ZF?=
 =?utf-8?B?TlN1WHlaQ2luakxUYUN4aWMxRHhXdjdPMDRna2lKZlBxT29oZXNBcGZmR2tw?=
 =?utf-8?B?VnhNT0czUXYyaWMwM0xVYXBDVkxjYThEU2plYzNodWs2bFpqOU5Nb0ZSZFJD?=
 =?utf-8?B?WGN5MGU0TDFqc0lyWVhJS1BYSEJPRVlxWlgxdzRGU2hHeHU5Q0tNMzlIVkFL?=
 =?utf-8?B?am1ObmMvOGJqbkh1R2pCWGozd1JEWW5zZUFOUVpjQ1N5VlE1RTRDTEluYUxh?=
 =?utf-8?B?NnQ2eUZFNFdkQ3Jxd2xUSktWdWpzZUhadURaR3IwclpIRnZBMDg3ampHalRw?=
 =?utf-8?B?a05CaWFDMEIrZExhdWpwakRxQzJ3Qml5bVU0eXl1MGxCaWF6UWthK0gyaFZH?=
 =?utf-8?B?ZmJadmgwZ0VuZjBVSUdyL0hzdjVic2g2Z3ZIZzgrWExMMWtVZ3V6Q0RqRzlB?=
 =?utf-8?B?OTVaTCtwcWhFRXYvbWZjVHRiekUzVndwcmlqaktJTzZlMkJwSnVnVG9qWDVU?=
 =?utf-8?B?R21GQS9ELzlaS0NMQk5tV1ZmQm5MTnVKYzZLWlA2cXJ3MXJnby9DTjZwZGQz?=
 =?utf-8?B?alQ2SmthenVKUUNObVZQamdROVArTnRmR2w4clp6VStIVUZ3Qjd4YU5MYlNG?=
 =?utf-8?B?aEJDc0w5RTNaYm9odkk5bW1pWThvL1lndzU2em10Z2RzSlI3U20vK29mZ0s1?=
 =?utf-8?B?eEpHdWtyMnArbjdDQUJ6MzJ6ejMyTWR4YkJQaGtvaTFHa3BjYkZvTGYxeWx6?=
 =?utf-8?B?M3BoRWFEL3JzTy9kNUk5Q056Z1h2aG1hMEgwSGNsZWJSUytGT0EzakhhZFJ3?=
 =?utf-8?B?UlNDbVE1YWJya0hxZE56ZFg4ekI4NVlxaFRaV1VHMTNzaGpab0ZaUjRldHZy?=
 =?utf-8?B?ZmdmVWxLeDVuR05YckNIRzM4YmFvZzQ4elRObTVEWVE4SjMwSG1NRGxWSzJr?=
 =?utf-8?B?YytWUGFBbGRKaExISC9heXllRU56UHJWYTI2bkNML2V1MnZYekczQkNabDl6?=
 =?utf-8?B?NFYzcXJLNVBSaHBPTkd6cVhaZXFPNk1vMHBVblVzRzFFZE12cnhKYmV1SVhz?=
 =?utf-8?B?VnBiek9hcWliZEdack5tL0VMVlFoN2ZjYkdMUDljS2cwWE5iNTBReXpJelhC?=
 =?utf-8?B?NGNEdFFQbWZodmlhNExQMk1XcGpzSGJRUnR0UTgrM1JyT0MxN2huSDdrWDhY?=
 =?utf-8?B?elczS2xaY3AxcjVNaVFETE1RYTNFNWY1Nm1jZmhscy8yMzh4NzZJN1NFQXpn?=
 =?utf-8?B?MEtyMkNzZkJ5Y3VyWnpPMUxZZ0s4dFlVMSt3cTZSb1pQcTk0QmM5NFJqYlJL?=
 =?utf-8?B?azk5SjM2UENTN292TmdwT2pFSFVaV0wrNlBxUHBhWFp1dHBwVFpaOUMyMmNv?=
 =?utf-8?B?T2xVYlZ6S2JNMTFPU3RXLzFxQytTUGtvRTQ0dFBCUDFvNXhlUXNMV3RObnkz?=
 =?utf-8?B?N0ZDV1RRanhvNGZMdDI1aURoeFo5NGdvQ1hRT2tkMXlOZG1DR2hZOCtyejR2?=
 =?utf-8?B?Nm8xQ0t5dGYrYnluRTJyQ3phSVIyTkNwS0dmK1hzdC80MmxlaVpGQU9VNlZy?=
 =?utf-8?B?Qmk5NEJXOVNtMUJHQ3RwZnAzRUVPRzFiU0lRenRIWE5XTitFZG9HbVM5eXJL?=
 =?utf-8?B?MkNFaENKRUh1RkhSaExCUkxEdVJ5V05YR0h3M05UMHc3cUJrVVgrTTJTcXNW?=
 =?utf-8?B?eEtzN0Z1cmc2MUxXY0VVZjlUakJTcU41bUpQVnprbHpmVkZXeHRXK29pNExy?=
 =?utf-8?B?eW5xdExDVU9jejU2YUZUWFkrK1NwVE1WaWtvbklka2lFU2JHZXgvbURWNFd1?=
 =?utf-8?Q?Y++wP+0jCvflqolbkQuI0xxk/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4606dcf-7182-40a4-f5c7-08ddb52cf2af
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0045.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:44:41.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVOif3JlnkERVYvCWeflyV8o/NclPeWyMOTYhb7C6cFZg50VCh39m55MTUYggeqBsbpiAqk7A5hsfvat7VqAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784



On 6/26/2025 7:11 PM, Tom Lendacky wrote:
> On 6/26/25 05:01, Nikunj A. Dadhania wrote:
>> On 6/26/2025 1:56 PM, Ingo Molnar wrote:
>>> * Nikunj A Dadhania <nikunj@amd.com> wrote:

>>>> +#define SNP_SCALE_TSC_FREQ(freq, factor) ((freq) - ((freq) * (factor)) / 100000)
>>>
>>> Nit: there's really no need to use parentheses in this expression,
>>> 'x * y / z' is equivalent and fine.
>>
>> It will give wrong scale if I call with freq as "tsc + 1000000" 
>> without the parentheses?
> 
> I think Ingo is saying this can be ((freq) - (freq) * (factor) / 100000)
> 
> in other words, getting rid of the parentheses around the multiplication.

Ak ok, that should be fine.

Regards
Nikunj


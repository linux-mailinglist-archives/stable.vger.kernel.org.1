Return-Path: <stable+bounces-116609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761EA38A70
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 18:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16881885953
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7066228C9D;
	Mon, 17 Feb 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5Af+4+q"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5515666D
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812452; cv=fail; b=GMqlcDGPB1maePW3zS3NVHEFYgVW88sk1dLahxG+M09KFe6BbSUigP+8Fh0AstLnH5uopEgE2R72OklDQ4oYF39LDn0UvgdEZztaaihfSdsx/fMbro+lcHD1YvzjekN+XkFFQV+hGFT03qvPT3dJRRuPLULOMfSyW7aKYEqsM6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812452; c=relaxed/simple;
	bh=a2efVVCPtQX1w0iHWEjcPn3f/IFuBtz72q6UtMFAa0Y=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=dYT34YA9bfcqpM4IypioDJ7STke7+AbQB8YjiSf0BCIrcnxF7kGAcAY+ZgVyEjaREIn/DHn6cqAXG/9BiltEsWusw9AFeGjQopUcDbyZachkAcKV0c6wo4lzhggtN17IPrXE9C9N7ux2mu4kjeEZulCROPDqaORLjnmwGGtyBCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5Af+4+q; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC4HJIMBzuyEtLCcNSAiVY/BOUW/HLqxVB+X9Y9O9ENGe+5gyMa+exbkN4jCK+HS2fVIhQYI970kdQ1If8jP0hSUBMnRjoFiXFdavNY9ARV/9E/kDA1B5cLXCBf66clk7fwfHaG1uiwTA3EgkW9I0E4rcsXVXcIS7X4JbRG2cQfZemKnJd3CXljebJ7oUQ8aQRqdF/2tQG4rfWJQaNZ9C0P9Z+3gx3Srys2+F+EAdVX08UPW2zxXyP5FWvWwMdSsN4ipID5x5fCKGsvMUkk/DkoO4roTafOQrPCdke5iRbjpNuKHUFXQzgYb4YFCaZIRzjgNotW//0BI43wYxZpbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CemaFXq/WEN/BAHfvcrufciZ6GOcgnmAdi2mbErJYE=;
 b=YLjZhjGqS8EBpqpjf25LFwYtpdM76J2ZMRSoUp9+iLOXWU7PlYlsETZZEt4f9Z8vcVad8rZ689EE+WbL5EJIsczyh5G1FjmNECrU4jLFhY1CnZg7z1hHh/GuUsCE1V20wBcdWTQz+m5GO6Zo/P/GqlvZXJsDgbKVHoqrSOdpx5rZ11jDIlyxoP0XNDn30hYwKITH6U5gqdAs6ELk/GC4YF/4ZqsocvlC3q9WBs/8fwWERJkcM2OVYbsg2zL/89gubG10mK18ZnAFZFkSGqL7NhyPXWYGV/z8SfDLhuYPJ+LZEYSVWIDYDhRtwIlI+DgVYrCz9pyyisaesO4/0puDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CemaFXq/WEN/BAHfvcrufciZ6GOcgnmAdi2mbErJYE=;
 b=M5Af+4+qXwULpIlich3CRwd4/fEO3PLlllnxUxB+x3Jh5+j7BjY65iq2JF0iIpufknTi2towLTgOomH+fw2z/Zb3Gv1pb/Bre5UnkESRGdk/XMFh58xGzQiJk5owlacLKGE/N/Jo4+Pw616sH3MxezJoa7hEAgqjfrMvVZ9ARLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Mon, 17 Feb
 2025 17:14:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:14:07 +0000
Message-ID: <07d0418d-c33a-43e2-abae-d204b223b0d3@amd.com>
Date: Mon, 17 Feb 2025 11:14:05 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Backport fix from IOMMU regression introduced in 6.10
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cf665d-0dbe-4413-a48a-08dd4f767c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDJRMXU4aGg4UkxuT3BQbXBEUzhBclBkalZsMHNxeWd1bjZlUHprVlhsRU1r?=
 =?utf-8?B?T3paVFRNaGlwS0ZZTEZtRWZVY21MU0dHWTZoZUNBRmkzRmpieWppRjZWSnc1?=
 =?utf-8?B?ZjFuc05LWlpMOE5UU011YWNUZW9BVGZUYytBdTNnQ0VUSHBSVHhlbllzek1S?=
 =?utf-8?B?UU9zVjk1ejRycUhJMWJzc3VTTnljT285STZOTzUxdHB1U25RcmdmaXE2bXNQ?=
 =?utf-8?B?UTFVdGsvaHNMZ0ZjNWI2NlJMdkpzenhkSE5QS2YxMEsyNzB3MEpSd0xKbjVI?=
 =?utf-8?B?Q1dKcm5wR2l2a29EUUpkY0FPRWlLcmkxc0NzYXNEZUw5ZWNjL3NwTnJab0xS?=
 =?utf-8?B?SERkSXI0VGdsOCt5RnVPd1E0dXRTQ0lPRER5TU44WG1mQ2l0NWlOTjhheStD?=
 =?utf-8?B?c0RtWGF5YnVYN2VJeGo4ejU1ckk5bWd0WkpyU2xER0trQUt4Wk5pd2lESEhU?=
 =?utf-8?B?WXFCZ0VVdjcvZGJMNkxVZ0NsSEdmWlo2dW54SWJUcXprR3dXQzNtMjJoNmQ2?=
 =?utf-8?B?dDVncUgzc3UwaFdMWkFuWDFwbk1yR1NaMFFabTRreFFIaFowcEUvdm1KRnRk?=
 =?utf-8?B?Q2s2V05MckFha0JtMW9KSWZOUTFSVExLMXMra3lneGtjZHNtMTJuOVFWZ0hy?=
 =?utf-8?B?MFRkWlhFdDNYSWdjdzhwOXBWKytPeEFpczMyVGJkQzNocTFSbEZzRysrUFVq?=
 =?utf-8?B?RS85Y3BIMW9LL1V2WDdLbXFCTFVsdjF5aGs2WGhPUUgrMGFYY3MrbWQ3WEs0?=
 =?utf-8?B?c3dCd1V2VGlVdEpWZzBrUncrTkI1aDNnVHV0WEJndVlWQlFYYVB5RWl3MTI2?=
 =?utf-8?B?aExFUTRxQlFJSmcyWlpyK3JVc3E5b2dDQnRYVVZGdEV4S3RrWXRITElXUHVN?=
 =?utf-8?B?TkVzUkRxdkduR0hDeE9IcmkzM2xMbGQxU283TTMvN3Y5bmV1UU0zMzI2QUMy?=
 =?utf-8?B?TGw4R2RjdWNBWlVIMklFY25TQUx2K08yRHZWRGUyYU1vM2ZGV3BmSXZkQllo?=
 =?utf-8?B?WndvdXdXVFoxSzhiT0FlVjVIeWhHaVphYWNnbDRHQnRmcTdXYlBUbjdIY0lL?=
 =?utf-8?B?S3Jnc1dqTFFHSmRFZEEySkJ0WkxGOXB0ZENQdlVlVE03T2x0SXJHUlFpQm9n?=
 =?utf-8?B?c2s5NGtzWXNRTEpnQkhuNmpZTlROSWZDdm5TcTBraXJYM1NLR2NUMSsxRHZC?=
 =?utf-8?B?Wm9UZmxDWitqVlhUWktxZ3NMbEI1MWxMc3pmV0RsYmRDYXllTFhyekE2RHZL?=
 =?utf-8?B?TUN1Q1l5WWdBR1U1dWRoMkhzYkhLUWUxTmFZeStqdi9CWkJqaTFhcmpMdGMv?=
 =?utf-8?B?cnRuYnJaRGpOcXEwM3hGRHJtRmxLWUdBemhRNDI4YmxIdzRFZnVUUWRDZ1dX?=
 =?utf-8?B?Y3VIN3pXRVBEaVN4bGsrUGkybzEycjAwWlBCcmZXeFRlcUJzY040K2RXL1FD?=
 =?utf-8?B?RzhFbmp4b0ZkUXZQQ1IxRGVHYmFzLzhOMzdmZjM3MXB6WGIxRWhaN2FXR1Zq?=
 =?utf-8?B?ZlFwK1R3NGwvL1JUVnMzMXdTYTRSRWI5UG1sYkh4eFFFMjJnS0tYUG9IL0V0?=
 =?utf-8?B?RHpaZzMwRkNZWkRTRzJzLzFlRW1GT3d4SWpsakRQcFY2ZjBsZDNyNUxKYUhD?=
 =?utf-8?B?UVFHUXQvVzdId3U4b0J4anNZTnJRVGN6eE52MUZ2UjNjVG1hRXVTejBMaDZm?=
 =?utf-8?B?V3JpcDBJZnpIN3owS3ZrbkRRb09zdlhOS04rRGg4T0lPMVVCT1J4NXd4R2VI?=
 =?utf-8?B?aW9yejVnZTVPWGs1dk9vdGZudXpLdnlUMWpKVE9OU3p0V1BNakJqRGFYQ0JT?=
 =?utf-8?B?RkhqcDFBREhnRXJhU1Fkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2ljaXlnRDlDSzlDS3Z5SkxlVll3c2xBZ1VJTkZOWWZ5UEhEQmlqb0NBQzZ4?=
 =?utf-8?B?Z2hqSFN3ZDNTSk5SYzIwR0lXMEhLVVRUZGhKTGM2ZlBTOTBDZE1vR3JJL0pI?=
 =?utf-8?B?OUhGTWVnNHl0YjU3QmlxVEZZdExIMTM0YzcwOFYxM3JmZVYrOXJvam5BS3c1?=
 =?utf-8?B?N2FPYjVyRXpMeHBhSHpZc0ZvYnQ5SURHeXY1djJ1NjZjbTBJd1JEY1FzZTBL?=
 =?utf-8?B?amFUaDlpaE9KNlNhekMzdjFmUWVSZlc3QVVUdHg0L3lEQkdWZkg0eVNUWEdw?=
 =?utf-8?B?N2JlYmViNVNVQW9MUXEydEg4Smp2Q3NHM1F5bTdoeWhvUkV6cG0xUUpmZzE3?=
 =?utf-8?B?RDAwc2kyaDBYMTNBOTJ3c0NYcWF6MHFxN2txK2VKcC85SFpuOGVlQUlsRkhh?=
 =?utf-8?B?NUxraVBNYlFKS0VQYWpNdGRHMjZLeDZSbDhieFRkeTVRcm9OdHlYQzlzMUNu?=
 =?utf-8?B?MjR0M2xnZXpQTWZDVEFHdWVFRFhCeWxaVFJaUnNMNDdhYjBibUMwTWg0MU1Q?=
 =?utf-8?B?ZW1MblVueFhBRzRXNVc2NDV3KzNxYjlLRUk1VTR4TDcyNFg2ektaK053NUZU?=
 =?utf-8?B?TDhRRjE4b0t0ZjVsNTVjdDB0UjBuOUNJbzE4MlhCNE9KM2xIejViU092M2t0?=
 =?utf-8?B?RGtVRmpSajR5Wjloa1RsTGluSEFSUFd0eXVsdHpyRVk5Lzh3V3Rpd2lVWnRv?=
 =?utf-8?B?YU1sc2ZOUjZYTFFNcVgwMHQrUy93eC8vM2VwN2xORmh1WmN2WUJyQ3dmcld2?=
 =?utf-8?B?TnR0SUxhWVRGL3Q5UkJtVFNoY0tkYlZRc3lvemxLUzBnRTVVTmM2RzlGOVEr?=
 =?utf-8?B?QWFRM2M1MG03ME44NUtHSmNxYVZZVWlhZStvb056UGtFcWtMbzRHWm50T1pN?=
 =?utf-8?B?QWhidFpDWkFjWDBGbEdXb1pUMTFSYmJ3OUE5dUVLa0dEV3RYVjhRdXZXYXJ1?=
 =?utf-8?B?NFFMVmJTL2Qyc1NMb01hUnBoQWdES0IyQ2RNOUhCSzRVa1djdnFvL3RxbXdP?=
 =?utf-8?B?K3k4YlhXRUxFQXFlTEYwY2tvaDJLbGRSc3MybXZDU1hUTEFqRy85aUR6L1Mz?=
 =?utf-8?B?QjJ5NHZqbDhOYVFrVE15akhBdEJmQTZVZEF4ZDN2L0xlOWE3Yk1lOVh3ZzZB?=
 =?utf-8?B?SGMwNjVucDZ5VDVYVklCcHlsekEyOVBYL1U0eWVsTzFPQi9HcU9tWThEN2p6?=
 =?utf-8?B?TlpINlVsT3BjemJBaWgwVVhWeWVqYTlGa2VWeG03OGllT1llcnlHeTIveDM2?=
 =?utf-8?B?c1JqTzhXbWlKOG42TFZzK1hsaDRMc2pISEpFSk5EVmQ5TG5oUytsODVzU0hF?=
 =?utf-8?B?ODlRNGVZcXl0MWdsVHBIcE9nelRBS0JHcXZNS1JxMXVsVEp5SmxuRnZFRmxo?=
 =?utf-8?B?Ui9JV3EwOE9HZEtITDczOEVzMlhibTRMdVhpc3NjR2w2SU91TmVUZlgwcGlY?=
 =?utf-8?B?cWV4NDdrd2RVWGRnODhuQXB4WjhHNGI3bHJ3a2drM0s1ZzJsNkpiNS9EdEdR?=
 =?utf-8?B?bnpNQzJkMDNsb3VrY243bjBBQ2dONVR4SW43dVBvZXRNTmlMQldsTHhWaU5o?=
 =?utf-8?B?VWFmRFZ1MlhMZUF1blZuTlVhNTRkTVJzT2gvUzdJOFJmVkk1Nmk5R1BkZSsy?=
 =?utf-8?B?clhNMzlCQ0l2VzJybW40VUZEc1NWSWluVkF2K2tsQ1A3dWpDckpvdll1bGZz?=
 =?utf-8?B?Qkh2VDg0U1J0aWtkeUQvR3hMVmI5N1pTSHJyeDZSZnVTY0tHREVuWUZ5T1I4?=
 =?utf-8?B?TUpseC84RjliSVdjd1A0QW9PVk51YmZFdnc3S1NDWktlRUxZQ0dPaCtyYUw2?=
 =?utf-8?B?Z1czK2hqNGM4aFlwbytTWDdyMm5XZjROdG90RkdxdGRieWUxNk0yU0crcnNK?=
 =?utf-8?B?UE5tUjVrWnJZTnpKYWYvNGxTdy9VR1NOODIvc3RTNWJmcGNHL2Vqc2U0OXpL?=
 =?utf-8?B?R21adFZ0SmxzZVZDZDhtK3RFSWZjWFRjMzhhblZDOGpmOU5WQTVFc29mRlVH?=
 =?utf-8?B?M0M0RUxBUWNUMWdEUVZDL1JnRnFjTnBNMFhhSVBhRVI3SjI5VytuempUQkp5?=
 =?utf-8?B?UmFVZFpnbTdjQXpvM1U0U1lNZ2RKV3F4bjNMQWJMTEpKK3l4QThlN1prQ2Ix?=
 =?utf-8?Q?3Mia7C/HrXugn7x0BkB8HJYne?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cf665d-0dbe-4413-a48a-08dd4f767c7a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:14:07.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqa9sUVmuPcaseBlbQI5ORuHifBeDHr+NClTXISgMIyjXXtwUe+Xt9TYyS079M6blWhvXyDGf80lL1gfswvSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

Hello,

This bug report was raised on an IOMMU regression found recently: 
https://bugzilla.kernel.org/show_bug.cgi?id=219499

This has been fixed by the following commit in v6.14-rc3:

commit ef75966abf95 ("iommu/amd: Expicitly enable CNTRL.EPHEn bit in 
resume path")

I confirmed it backports cleanly to the LTS 6.12.y kernel.  Can we 
please have it backported there and to 6.13.y?

Thanks!


Return-Path: <stable+bounces-225699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP5YCPJquGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:41:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 912622A04C4
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60EF9302198A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5A3EDAD8;
	Mon, 16 Mar 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="QlAku5Tj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B52C0F78;
	Mon, 16 Mar 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693677; cv=fail; b=LNr/rh1wqbLORDHFnBlGRDV/dknZFnZKX/kIoR9J7litvkBJfudjED0WxOLjTlOFuNoX18nnkzez6aXsx2RCAZobCgHIjZYut0tuc4aPVHxHtHG18eHhbZRBC9S0/h0adRPZJzhKoYVABFz1Tqb9/iXZIt0Y+z5R5lS6N0XIKwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693677; c=relaxed/simple;
	bh=+qq1EG2mD5jtKsUdxmM/Uz7qWfg6wOKqK9VSGOtjOVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQAkeSq89JoUVtn90cxCmVvifu1b1ZUyQRy0qEDwZJURoaoyFToJirQtR4Yg1Oi5y++1W8jXRp0ftuzYlkumzdTvUBXY7CVuwyx4/kIrNxPwb8CA4VHlRT2Q8k+e4wVYdgqeHlmFR7cjv3LqaGM7SRgcv3VhGP3P+SLI1fxclVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=QlAku5Tj; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G5j3op2333367;
	Mon, 16 Mar 2026 20:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=GOa0r9K6usw3NGUWEJsjQdwj3w+utnZktg2K+sDxZi0=; b=
	QlAku5TjCEXeyIevIoI6RksoDYK8GLanMPkTbL/NbftXuUfn5lBUQC2LmT6H1Lkd
	whkROTOMEt1cOMtB74g1tpz0YQxzV3KI3awwz1Zm9HWuOwiGNCM4L6lUxURff+LO
	YmI1o9nbs4lemR+9Z6WPG6PjNNt0CrF6/IX1w2cktKiJSOwOXkMSbVtHJ0NVN7AL
	2sgZ+2z5UqGHnqCTANtPIzOWgSFp0dd+ft5aZzisygdtRYjWzj1FSJZuyhi6oTsd
	MCC1bcPURu/3zfooVkgCnm6K7PSquPrdu/hSq0RCyzqdxr9GAPfbuUxV3W2UYjsu
	ypTwCBjZLKKVG5iErDSsEw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cvvvyjk5h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 20:40:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBZMTxr6S4mnPUmc4NhgtnABTnlZmLRQ8y0X++fvrN+kx8VO+zjmw1E54dOwdOd5epwRU0k87KRREww+wSN9b5min21GPC0SAivFGRRlb+NJ6Hf1sE2W9QNBgvufqPmWQX49Zb8wmVZY+fmza2GVgBIhQItRtMrcYf6UqVNMkqxFmxyF1YGNat7duyKHyXWOS0CUvIirNr6qBJYemVLBJPgLpyuPDQwf3KXJ5kUxFoiXC2AyYbnADgkKiZMX0Rv90vVThuDSBVQhVTU3uUbUY4pewcWKurvR3Hzok/DM4fnh7sBzpxl6G59Wh1HDb1yZxcmTG84GeyYG3brib+rHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOa0r9K6usw3NGUWEJsjQdwj3w+utnZktg2K+sDxZi0=;
 b=OFjylRsGR+QCuJypzXIcJug+tbtOCps/UYVnH7+pNprQdDvVV8KATGrDgrMwo5+xBiHnWJ2x8FXuXWMq1F1VU5o+rk08iZz7QjieDRVgKD/5Is8hfC8VAX8l0iAex2XMtMx2In1/UJflxJn+fFOTenpLN421qP+KkCpjNaWhZ4thhkMUTNXQIrfh13eJyJ5uFlAH+zHP48pUh9Fy0FJ2gFdDC/N4lCteY77YrhIcP/1siOAkOWbCk0lKunhzW471LEdX3IotNEqfjVZLzpavZMR9F0FXu9QD4+I/byZ+8iJQETyIoZGyKPXf2ZBUXO/1PnzjwBnIVWHoPwGl/A/qQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 20:40:23 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 20:40:23 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
        ahuang12@lenovo.com, iommu@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size() returning 0
Date: Mon, 16 Mar 2026 22:39:56 +0200
Message-ID: <20260316203956.64515-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316203956.64515-1-ionut.nechita@windriver.com>
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: df7497bd-90ee-4ddf-475a-08de839c3f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/Wh1xO6+BgUoBS5j+p3ooLBeJOkIf/HhyK9gG2M6wgY46N4pIZhURvjkpo/As5EYL0srMYzJGsytaklGAuPQgkBJ3yLCYaKUQ8adkSFyHHc8Mlo55Qr7zqVH8azHutEWixeB73KpGTb3bcVhJPtWQ64Ev0MJBmhp6YAmBhAxT1k96gdH/N5AUHoWm/yD6+SkWMhtmojYilLFN+Bc0IImTZ/oiO/DIE/77BoxnpCFstcZDhyC9bFo9i1Mbg/KkGvaLDNsW8GJmfpV+TPsQ0KckyXM7kBrvN/kTuz+vXCq0XkhVToF3I2DpBxXtcQ8j/3+f6PC37cJmCpwtRqlW9He/Y6yI4vnz7Yw3svEte5dt2p6pvk5cn/r62zf3dyrPkA9iJK4g2AmBR5QgagE3cAv0q5+WbA8dXOEw2DLy65arAcsSQxr9jrlLhnqMFUR9NxZU/O7bk6J0UNtQbgjEHXhVweDHmeu8dCDLRySla0Bm6Yb+0BIXFcTebnXN320c4a2agcWqpw26yB+3pmzq2/t/WvMOCJa00/24ko4UcInHestB1QW20zm8wmjI6XzwNXRKAniwu9jiBep1u+ZU4XqpCB/2uEqYbeVaN0EmAuY1PrDtjlR04S9hruLQZykM5vLpNKKTYylm64mclhF+8AgdMH1iff/37AYZlisT/Tj4yAOSpyT64Nf8tx/9t1J3rafOkwyw/ia4IfGQkkudHAnaYPZ0q95Grh0ocR4hxMu3cY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/P+NgM/K2+H+4A2/UhZrY4g/DuX4Lf9Ds/cAvpiYFdCmEz9DV45T6jb8x8D?=
 =?us-ascii?Q?wXfnF3g1KayJzyQ0NFyzCnPiTUME9KpNRelT/WglE52LZKf/YvrFLBxZD4ei?=
 =?us-ascii?Q?FVyfYiIXLNfLJMcKH8GVqFGn7U8h+tubgn/7DEuEJlvNiHm8lLn/CsMmSBEr?=
 =?us-ascii?Q?HB8vomNpZ2SYE1JV37Ndl5virxMh+A5chFWtY4+dS4sfLwicb5zBgoii9G6F?=
 =?us-ascii?Q?O9utww7i64kOL4wF6ohobMn3Ssd4C9nXjijhMDLKusWYFLw8m9C2deTGPDC0?=
 =?us-ascii?Q?A3t4V3Xp3HaYrtB1w1b81+ryYGze99fli88mzPiTdhqWCdt/1Sl9ZHBF9rsr?=
 =?us-ascii?Q?FZUKd+YYQku2r/p+t+/r63lGQjkUf5rlX/ZrIOAvN7MgcaVnSB3eq9Wm+uft?=
 =?us-ascii?Q?OyX1gkBqENIqL72BAPt0Ij/ypjyI+nHuWQkwKWEfXApmC/nz9TWKlmEUO9QJ?=
 =?us-ascii?Q?OGfi0DhGZJTRAS5cmKR/4LLr9Y5taJv/NbukkKhrlLCXsEtGq/InpCEBQwCc?=
 =?us-ascii?Q?pBOM8XH3OiIzyKIscrT65K5DnzyO94taqcPG1ztAAx4FPFdGvQBAlmiGsjqm?=
 =?us-ascii?Q?6P2VxGUs5J8xQKNAdInzTM4KezWe89BzyTk1iUDWVOhZEbgw1k5mMhMCMvBc?=
 =?us-ascii?Q?XD3pyOpiExo9+YRxYGbrTM6CpTdDKt82hAGUU9h32Uk5uBtVk12i3UX3GH6z?=
 =?us-ascii?Q?WRKcXXJa5ia5Kh1FxH6A1z90+w8CeELVvu9xi0TQLvx2bVkzSPAP97wNHrXL?=
 =?us-ascii?Q?/m0QB7C0dWOUaz4RHBsH3XHm9Ll2iBHXltUaiLhOvF+dIuiMPcjyCPTwZ3uH?=
 =?us-ascii?Q?lzbs04sACXSzlOvJGmyLKLzfTek7g3p5wUO6GWttMBKFFGeemOQTEgsN53hG?=
 =?us-ascii?Q?0WPzWksnLHM/jt5VsdKtycXQXgfF9C41gM5qVsVwiE0K92wI7NmCRiKij4qe?=
 =?us-ascii?Q?Bnj0VrpniqylYT67v8TD5A3b9SB/IPywzp0sLDO9pikL9eY1IQWovk7UlQZo?=
 =?us-ascii?Q?biVSIuvChjwf37yWItV4uokTE2M59/9fAuvbA7x4v+ZEske+BYjE68zCohn6?=
 =?us-ascii?Q?z/y6Q1YwPbkrpKRdlDV2BtxZ8as1GMhSw/sXqknZ1ET25c15NelPp5A30Tdo?=
 =?us-ascii?Q?Rh4JSfTsG8FOaseXI8rnjAQujI2JNLLLkKy8pI0mlCHO/7oHQOexNdmnPRZv?=
 =?us-ascii?Q?Kkikk83n5R1MDoXQsf5kDwrvMm+4GQto2SiVcvUo2p4IO23DvMpXf8ysqjYW?=
 =?us-ascii?Q?pAHTGJpfG4Vuc3p3BABb7d5yU9s/xZUfnfD07etjS7vYZCOKJB4We0jtHsb3?=
 =?us-ascii?Q?HJj2pivz7uZ9K32cj3dlyAnpe1D3+ShfK03Jyr3HI6A6F0gRbKo0VDDlmOfu?=
 =?us-ascii?Q?m/T0pC20DHXInnClgy+0aqVCqrGeqmt4/8kDEFYV4v/Z3X+1JwbgbOzXbLB5?=
 =?us-ascii?Q?8mOMevX76/yszHoNNePzc61ejZfvITigeCXE1IymWJ+wT0dstsvl41f4OF8h?=
 =?us-ascii?Q?p8f4IXmOh7AcSTJpLsTBisVbClopt2RSnwwXlnxSdnt5hxWpJo2oSSeAvRh/?=
 =?us-ascii?Q?Ctr9rBKusJVKwI0B1qSCknygLsCvnrK18O4cLvTmddFOjgN//cdWms1OdanA?=
 =?us-ascii?Q?6Cs3q/n+KxaF9BafvhipHkioK6WZFOJucKYtkPlY1TFJbGsCKihwLxBydC8o?=
 =?us-ascii?Q?dGn+WtT2H+h6i9zc0d0gQAw6paSNrj9Oje6RNdHBlY4NYuLZX6bTGt9lzUpG?=
 =?us-ascii?Q?94wL16eClToU44Z0AOACd0tS4vi2a7BLJNW0yHe0GaLzNkl5qwQTT6ucXHtL?=
X-MS-Exchange-AntiSpam-MessageData-1: JjbZRYA1XAmqYI1pB4FJAdxluE0j78JLPUE=
X-Exchange-RoutingPolicyChecked:
	M8SsuC2UvLewvYuilA9hMVM0cJHboGfQh2cVMhC35oOGM41LqcBsOA32hgAjc8qYUUv5qNjPitIe3h7wWTbwOA1HlPbj9tww2HrRICWVrHUHknHGbTWs2S2kC25s3pzIE5ygPvwxT9zVlKzF+D9gSHfn65tyxk/7JWyGuovhMXbqYplR0L/vCEL7UE+GcWHIWKy56Gy/GleFzNawqcA3S0ViHSGoJrit4x8swnzwIg8jlWrMxL7YposuKf4LZvJQ5uNPY3Hvv9ssMhf5HaYGPqxZu4JK7TxE/AePH72hlicOwjEjMwrJVdSTPEPb8M8XsKKFzyO1V83GQOYoeHJq3g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7497bd-90ee-4ddf-475a-08de839c3f2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:40:23.3407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTibEWmCUvIg0a9zzqzPutM6AozboHVU4mUVOrZRHbDPOYA/MzVPUloQ10T05oNcIDVaQEXHiNh95N6CtAfsyNkyh9MsgTRoTPrqNQnWhRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-Authority-Analysis: v=2.4 cv=E4XAZKdl c=1 sm=1 tr=0 ts=69b86ab9 cx=c_pps
 a=5B7wOmkMoK/13lwMvlsh9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=dnKbSBSUX72Y7WJDjeIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2NiBTYWx0ZWRfX9Kzq9PXqDZYI
 DJ0xaWA/+d60I6UrxOv45qAEhY4ub5Mq+ZjwQGuG6eiUaoYceGa+vF8U/JxjNtTVY2lnN3HyYvX
 yqemDdvxyT13SRO7rtDxki4HgSMxjBUrYcYg2B33sM0upy1/uJom/vgEF9ezVk5LFnFhFW5/Dv3
 mW3wdTnNmahEOJZUx3s+f9YCXvSrNV8xbf06xXsrtBMxNf7XmwqJQqUIKlvRI/9f/xgvD35JV7S
 7iuQ86tkzzEeZ5NqaDu+9zj1Mr3YYnKqm32VsLT3Q7BYkDDEZzflXFTg6McSO5IW4HRrhUdX18n
 mo5KleTXYJnAKrJWO8av8ZzmFeUHLgQLe69gdDQL+wEBXjcGOcY3PZexexK85qqHG+qqqF1LzQL
 D+g+IdMFugiNtUsmZsdp7Zt1uT7DloQMTuYlIQWB7XqC0d3U3ENs2lwTsfe7aQFg5Ob292XF/xd
 EtfpnrVNrp7cyguTiSA==
X-Proofpoint-GUID: IDo2n5wLFnW47zqRzt9RFr33cuSP8mqZ
X-Proofpoint-ORIG-GUID: IDo2n5wLFnW47zqRzt9RFr33cuSP8mqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160166
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com,windriver.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225699-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 912622A04C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
mode with no ops->opt_mapping_size callback).

The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
value this would set max_hw_sectors to 0, which is invalid.

Guard the min_t so that max_hw_sectors is only capped when
dma_opt_mapping_size() provides a real hint.  When it returns 0, fall
back to the existing NVME_MAX_BYTES >> SECTOR_SHIFT default.

Fixes: 3710e2b056cb ("nvme-pci: clamp max_hw_sectors based on DMA optimized limitation")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/nvme/host/pci.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b78ba239c8ea8..dc148fb6eff28 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3640,6 +3640,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 {
 	unsigned long quirks = id->driver_data;
 	int node = dev_to_node(&pdev->dev);
+	size_t dma_opt;
 	struct nvme_dev *dev;
 	struct quirk_entry *qentry;
 	int ret = -ENOMEM;
@@ -3691,12 +3692,16 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
 	/*
-	 * Limit the max command size to prevent iod->sg allocations going
-	 * over a single page.
+	 * Limit the max command size to prevent iod->sg allocations
+	 * going over a single page.  Only apply the DMA optimal mapping
+	 * size limit when the DMA layer actually provides one (non-zero
+	 * return from dma_opt_mapping_size()).
 	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-			NVME_MAX_BYTES >> SECTOR_SHIFT,
-			dma_opt_mapping_size(&pdev->dev) >> 9);
+	dev->ctrl.max_hw_sectors = NVME_MAX_BYTES >> SECTOR_SHIFT;
+	dma_opt = dma_opt_mapping_size(&pdev->dev);
+	if (dma_opt)
+		dev->ctrl.max_hw_sectors =
+			min_t(u32, dev->ctrl.max_hw_sectors, dma_opt >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
-- 
2.53.0



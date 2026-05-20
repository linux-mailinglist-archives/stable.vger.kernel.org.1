Return-Path: <stable+bounces-249788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOC4M3V7DWqfxwUAu9opvQ
	(envelope-from <stable+bounces-249788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:14:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44658A7AC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5700A300F7B8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F933630A3;
	Wed, 20 May 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DQ4d0rQR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B33BB105
	for <stable@vger.kernel.org>; Wed, 20 May 2026 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268460; cv=fail; b=UADy0SkNPYhlePpGdA2oC2iNmTQLnzm59Ztbk7HDR4nZmYfx+PFqU54jPKy0r2KcnrKL1JNE3UN73mKJPIIhOMVEPTWnDYbQHHhHT3inbvITyEs78562O1caTEnnGI83LRWmSftgpHNI3QjcXZP9asdjK8oA4jidbtqCMq0P/WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268460; c=relaxed/simple;
	bh=tuaq7ZoTk+xw8mu4udDsfKUztraz4frWHq7Fx8cxWTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6/GCGS3qp6/4y1TAs3IiS3nI/HQkDuasAOEzaU1cLZgSJ86iuqZRxnry9G9gRNzojNg8SI2xUj6NDi80ztVjvV3KBUvqHlxnh3w+qTr0XdYCQiAkt+EqwUITsdtA/XLFWaHLEpfRsNpT6eIDRHFyt2oLgtKmxeIJQRqu/w8CYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DQ4d0rQR; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K4465i1274576;
	Wed, 20 May 2026 02:13:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=55utNSFhjh29bNFHnwislOv0CkY6UtMu7fHICkJUOec=; b=
	DQ4d0rQROR+Z+Xcle1jpAhI7Xyx3DW9nQwvSeZWTOIdcMuQQm+agMw4Yw+WtWnDS
	g4MB+ct42P02TkITvC132K2o5MhR5Hq+1rRoTlN69nWFrNhNNRgGZCRGzSO1faxa
	OW3rajBZUOA/SDbqBLq/EvrApNIwjd/YCRzjo/0uUSxcr7g8CDksi8PVLlMHoEdH
	ZhTIokUfC311DMErEAkxAfk1QwguAOJR8GDGhxInGS9sFpqTEhvVEaw9Xtt7SYI7
	1474NFDqo2f1wItbJRb9qiVND9eRE2N+YK2JUqEdXnujCA4mZUArn/iTzOqGb6WQ
	dCEDF8dMgq66WFaheCWnsw==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e6r3gcw4c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 02:13:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6eXx6DK2S/zw9yjeRitWqNat3dJzsilglAzoG42DPm4GLCv+ya9J7fT3gF6lLElmRvfzwyY0LEWLx7hP+THm4gAd9BxlKfhd9q5Whr4kcoa8rI1BQ8DytAq5POa23Rz3tvf7U2cB2UfK/wFdsmR9gXYXtGyFlxRW55E6D1TqfH3SXUqYgdywr8rItMNzzly42Z8HOseyrEZ10XxrLzUwUDxxeWJxlQ/BFcR1VGzhCH9xebEwLZ3Z0Z7zDA1fmTD2V90Ip9Aq3hJ97Tb8tWuSVP6SIave5OTkIPxPe7/UI4J0kF9zrr4eEu5vhEpPGgkQpVCQVjW7BBBMmSOWIB1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55utNSFhjh29bNFHnwislOv0CkY6UtMu7fHICkJUOec=;
 b=NlFLrPQGt4PbnYhq3Jo0F4hXCJniimeLBihY+YFWqwUbXoioP3Kch76ZGqSrKOBzJYQGUWJWPM9Fd8CBQ11LYCpAbYPF4Fh0USqElEUR1TcLox7htuom2osJEm/nU0k9pzxtzvqi1zn02LMsWX9HYF+Uxy+SuP5hNBpYsw7UemTHeWX11QiGr2z1JtWXb1W9iG9+SZNncEP58YM2Ys5gmrj5MwYfbZTXGt0oaAlytet0ROz/O0fmBKvGy7MDkCHiW6XbREso/85Ra+lWOEIh7hI94hnBAuXxoBdh0MOrcj4KVihhRut8N+QrUx5Bq8inQ974uLjmZzkPQIZINwE+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by PH0PR11MB5175.namprd11.prod.outlook.com
 (2603:10b6:510:3d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 09:13:54 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 09:13:53 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: will@kernel.org
Cc: catalin.marinas@arm.com, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH 6.12 1/1] arm64: io: correct user memory type in ioremap_prot()
Date: Wed, 20 May 2026 17:13:37 +0800
Message-Id: <20260520091337.3799553-2-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
References: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|PH0PR11MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e9835c-a794-46bf-2405-08deb6501d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|5023799004|3023799007|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YXpLa4skjDqYW1L/8fWLXx6Fbo1DPAm/n/EoT4NZ8qT4T78ZdF6LVnr15yDgoEdgnEbG0zroOK0TTa9fR88+dKHl6pedzkvkdMMgdM3/eZ3zDfsZnfPLBt7dIExsZnOWUrH56xDSHChRiEWeCmVJfqqqLJTSjBrY5LY0A9wveZ/1Y0lJleIfnJkDfEF56ORE08669jHKzbj7QBdAEufRE11d/Z5zfGtmXu4XScbiYlFLBo0RPDsB1AnO1nvr0N2tUM0mKBAZqFYg59+SdIpphYVGVSHnRK70e2Of9t5SzkxCsABTdus+8Z9+Xkw+OjGZE+0V2J7m66HrsRDPbFfGPa4L4tRpAy9fzOAc3JDr0qVF6rbijBdLtM6WvY/5toWH+skhK69HY2dnXTlm8O93MSi0bwH1mQGp8Dq1+UFJ8MDYBkfCq2Npda3wNltcz4dIuv0xtg2SSK8ozarv7ZStpi6HBnuziSMxLQcUWtofgvtp5GBn/C5Ojr/jmJiXf6Tht+glQdzVu0WLki3R6rI3av0y1sI8gaCasHpkRAMdUPJ04UTjFB2hR0Yw35WlLE0/L9yx9m7XZ4fCHmGqXwODnSKNvmpAF3mWssO4CAqY4AOqvuzY+LsEToFA0F+nzjjfmGHmboAFlUt3p8FLiStou+npBy0vwi1mweftPSL70AHL78afIzTfN/bRw3O1Ul4PPjaNVr7uGlwgOmsqjTfe3BRlKM9uliuz87TQ/njbE2Jpbbxp5N6dI5a7YJxkjQz3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(5023799004)(3023799007)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fk0az8Jhn4uc0thwveZT9jczTUI9gelF2gtT0DwUi6pkgdrbubtXbc6wflHb?=
 =?us-ascii?Q?61JBBLXOJSjDZzEE78JRMbj8nSiIY3IsozApaVcaEAMptpgrtM8OlRfYzjuG?=
 =?us-ascii?Q?G5pXjGRkhbdFCUFvLub50WabmA5C9pXr4iabmZvXVfJv29Nr8WBy0okwhd+C?=
 =?us-ascii?Q?zaq/GfmtT4PJ0gsfh+LLJUstMmDwe/nxgliOqBS/yMQ869xBZc4Sk45J1hcn?=
 =?us-ascii?Q?aLEB82stOiOe7AteRvQx0cq22w2iyoMwzoq0sQfUtzG+HG4lboWR1tC4b/QY?=
 =?us-ascii?Q?VyJsHnVqGjAUnpD64p242WFak/SAQ+7ImRaChMgBptmhmlwxvIb+RLagbQKj?=
 =?us-ascii?Q?aBMkTlY0aLERxafWX4N2llFiFQjG+mvVEq4/I+FY2GBf8naGngN1szKyKE0o?=
 =?us-ascii?Q?MopB5FN/87QZF/EmOsB38RiiM1FgoIGPLCxYuavEwBtob51XLDMiJvIRfVTU?=
 =?us-ascii?Q?NkgGPcPQPKPeHeJLhUw/i+Ra81iYMOCcYAOdgTrn28IlKR5lgGa4SXuuZYcT?=
 =?us-ascii?Q?ERTYbaLF18Jz30WnnaT1syOhFPBvdzokhGvBjn3gX63S6uLK4Q23kuUhABMw?=
 =?us-ascii?Q?OP37TgVA3FtqOUy4+0Iw78S6bcYfQzRtBw3WkXybLgymJopnalLENPY4N8kn?=
 =?us-ascii?Q?CETpAE+1+F+rUFOYXqP8fSB/Fuls7yfw6arVQcG9hVvQdDlHhsqpLQ3hNLFx?=
 =?us-ascii?Q?MTXDVqCzEdoxeudSs2nJnrpuV6fw5IrrS5DxqbS0xVIKVxnYwxRoSw6GF3m1?=
 =?us-ascii?Q?qShWFnnyUtrUtQEK7Jtd4wuUmycV1moIF7cuUYOp+VeHGVlUgr1+ydBljNMW?=
 =?us-ascii?Q?PQH5Mf7uezlQD9wfCWE897J5EY7xnQCha9QFhwBSjMtxvQBKUMkKXorf1tMq?=
 =?us-ascii?Q?QPyYgg3PIG75GSBSGQmA/KZ1E5FFAfZJUqV53oQpcoi1c8ZZGsAYXJNNoLhx?=
 =?us-ascii?Q?xjCzyXXk2gZfRqdhys9aEonbZHY+ViSbEeJRa+fLeUCKlXioImYEL93JuYxH?=
 =?us-ascii?Q?Sz0BNeHcryCZDPiTr+GvbI6eFMM6aoaDZfnUOWsaFwZyqReWPxph2wbZzBnV?=
 =?us-ascii?Q?FVo+jxQbEuYftwm1llvkSLQZDmbs/bP01L610slkWntlL80aLCdpenZENMye?=
 =?us-ascii?Q?3ansfsQaXmRauwX5F1qfbXnm+JqUIWsErIQALoMBCelmsKspZkvuAUqo4G+X?=
 =?us-ascii?Q?rVTSBHP5crtdQ4ZaOVCQQS97HWEG3BcK2WiXAnPsbiRgFI/BjDFoHggfvYEA?=
 =?us-ascii?Q?bvOGcaWP7oK56R2T26yNZTs2LoxYmlO9P79dIG1HXJ8sXcj3hE0o2WTpzp9O?=
 =?us-ascii?Q?NqoHT0diC70ZcgnH7CUK9XIqXWSRFZumM3m3EIvd8zenCSspMNR8DtCSL+E0?=
 =?us-ascii?Q?aqkmqtUwpmyNtep9sFu3lX4NhytEyYsiaxBVbAj3BJEZ0872N+fRTkmDOGt6?=
 =?us-ascii?Q?g4Ouhc/g/yuoIu8wgTvf1vLvjBCFagPb+I+zsGKEw18uml2/jxWZxKbtqFgv?=
 =?us-ascii?Q?eWAW/BCm8ga6aaRESjr62xQJx0d+3UuyEXY1ZESJCacTt2m5cNxdGydlndeL?=
 =?us-ascii?Q?Pml3yA/3vy9AxE6X7yeHn9oGqkaUV/4zbrSh82x+zajwLCYPDb5nYTGG7Bqs?=
 =?us-ascii?Q?goPgcjrS3zSGyq/RFoulFPW2aHV2HEa3AXCus8VnW/nk4w+qZr8bNfIi9w4L?=
 =?us-ascii?Q?HYcbvDtKX1RSaWix3/PaUXGST9TXt+aaj5LKN4lgwu74dmei5gKTB7czMCMj?=
 =?us-ascii?Q?mByUdZg+LUowWkbjus+zQFb5CmlA0Fo=3D?=
X-Exchange-RoutingPolicyChecked:
	s6loHeTsw3m7R4gvBiNjjswqT0BJpYVmG9I6hEcpYH7D6bcnaRMzJ+TfpdtUOJjey8suAWsynewquFi4wFeBezHyGc0cboDWYP3EIU687bRcIFRnQXSZ9CJCu/4riHKKJg32GVgzsxS9FfjbtONCHpYp0gDcyDPPPW7Ga0KZ6aCIpFN81IW+T+JkQ9WH3X5nzU9ILeFPxnIjRq18L3INlaigK7YbtpS4GIgwB2puxGimQqpkP5QFaxI+5WD8OloTvnhm44BV1VKVczt4HO9BayobD1+3kO1QrCfPNWTwZYvy994uzY+BmwYOlrbESIGnCZ1/MahRK9ddYQXqvUve9A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e9835c-a794-46bf-2405-08deb6501d02
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:13:53.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOEBQaXOunF4VNexy1hkyuRAN4xlvKHV1G+39AeLXLuV9r+h/XgcEbQeDaqQ1MtGGRhy+p+FdAQhjAcjFSBJpXQM2gyoRiKjZ6LwK3T6ADY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-Proofpoint-GUID: nAqS9yDq9nDsCPB97dwitp6Dxij2qNn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4OCBTYWx0ZWRfXz5XdMnwO0r9A
 OSYR6bERMWt2R0XV23AeZaeLKYkMpyELBPRXGjQ6Ed0UQQB8j9utrgwcjqsmPMM7ig1YCbA7dh9
 UPxY4VPLBBrVUpFtFXVpkSntp2s0wvfanIqLq3C4DBJNXOMMC/fDpyQxMF+oBREY2/PzHGcjcJ0
 M7zNhKqvgEYaNyMfdCcPZn/S2dNvwgg8D+Z/J17qaYPwj9kUKOdpKcOgmL3c8CJ5jb49Ij7hLJq
 vzmR95HuZDiBQX8LVixIPhl2M8US04ScKf/qi+VBKIeFla2tRggZQdwXXnaZuPBgCpjKeuSWcic
 UmV16dRiFzGY4R5+xVMq/Vws4+gx9WPv2q5eZrK+S4rWU29gE1+uQ+V6t+4XDejkCl5fSKZde2B
 cLiWo39yJTKV+7VwVNA2JFBGjFX2HpbD992tnRJg57TITatVHzsL0qZvQoSYL2pEcFUX14ANqKQ
 VJa/13yyLfVBq6N1Vrg==
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a0d7b54 cx=c_pps
 a=tYtg4CXWOAG754Cl0Lh34g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=DbrluD2zgydQ3nY6vfAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: nAqS9yDq9nDsCPB97dwitp6Dxij2qNn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200088
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiangyu.chen@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1B44658A7AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

generic_access_phys() passes a 'pgprot_t' value determined from the
user mapping of the target 'pfn' being accessed by the kernel.
On arm64, this 'pgprot_t' contains all non-address bits from the pte,
including user permission controls (PTE_USER).

When a process attempts to read the target memory via cross-process
subsystems (such as reading /proc/<pid>/mem or via ptrace), the kernel
re-maps this memory using ioremap_prot(). Since the PTE_USER bit is
incorrectly preserved in the temporary kernel-space mapping, it triggers
a level 3 permission fault on systems with PAN (Privileged Access Never)
enabled, resulting in an immediate kernel panic.

Upstream already fixed this issue in
commit: 8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")

Directly porting the upstream patch's macro changes inside <asm/io.h>
creates circular build dependencies due to the architecture-specific
GENERIC_IOREMAP refactoring introduced in the stable kernel lifecycle.

To bypass header dependency traps safely, this backport confines the fix
entirely inside the implementation layer of arch/arm64/mm/ioremap.c:
1. It uses pgprot_val() to safely unpack page properties into a pteval_t mask.
2. It introduces a targeted safety check (if (prot_val & PTE_USER)) to
   selectively strip away volatile user permission parameters.
3. It maps the memory through pure kernel attributes, leaving standard
   peripheral device drivers completely unaffected.

Tested-by: QEMU ARM64 (Cortex-A55, CONFIG_ARM64_PAN=y, /proc/<pid>/mem read)
Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 arch/arm64/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index 6cc0b7e7eb03..48a16a360b42 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -19,6 +19,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 {
 	unsigned long last_addr = phys_addr + size - 1;
 	pgprot_t pgprot = __pgprot(prot);
+	pteval_t prot_val = pgprot_val(pgprot);
 
 	/* Don't allow outside PHYS_MASK */
 	if (last_addr & ~PHYS_MASK)
@@ -27,7 +28,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	/* Don't allow RAM to be mapped. */
 	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
 		return NULL;
-
 	/*
 	 * If a hook is registered (e.g. for confidential computing
 	 * purposes), call that now and barf if it fails.
@@ -37,6 +37,15 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 		return NULL;
 	}
 
+	/*
+	 * If this is a user mapping (from generic_access_phys), extract
+	 * only the memory type and drop permission bits to avoid PAN faults.
+	 */
+	if (prot_val & PTE_USER) {
+		pgprot = __pgprot_modify(PAGE_KERNEL, PTE_ATTRINDX_MASK,
+					 prot_val & PTE_ATTRINDX_MASK);
+	}
+
 	return generic_ioremap_prot(phys_addr, size, pgprot);
 }
 EXPORT_SYMBOL(ioremap_prot);
-- 
2.34.1



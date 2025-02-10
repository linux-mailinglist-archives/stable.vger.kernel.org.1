Return-Path: <stable+bounces-114685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC3A2F3A1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A994D1628E2
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF642580E4;
	Mon, 10 Feb 2025 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="pYC1b0bm"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2109.outbound.protection.outlook.com [40.107.247.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B62580C8
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205177; cv=fail; b=AlBwM4dU67afAvGI5Wg14VZN/Eem8aUsSQ969CovfjUTiOohBSOJyYyUhLrUxHn3mdDpAY/5OJW4gKNgvF1TGWUA3jA+mGfX8azt3mG5SnQb9UemvODObnDlGOEaU/2juEVZZrCR5xSxw+ryg17c7hWlib2xoxRrGvgIv5rznoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205177; c=relaxed/simple;
	bh=NzLgXcIElykJZ7bNvnKuvtaOC58C/1x0+BRVfNusIcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCDd1UhM1wUlLfox3AOVC5hhiXrKMi1Vo8dwX1X/yawk1FX9LHFGUSZKM6mVZJ9zSwjaYtGHz4APyk+0twZS4nWL3GDsmnKaZDMAMe/V/jcwjDC0fkfP62WG7cxGfqHsyxb0AxmWRs7YZTxwS2gI0gstVQh+4Xcy3PVORwPyZ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=pYC1b0bm; arc=fail smtp.client-ip=40.107.247.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5c/hGVHl3VphBMFoJLZSqGZFvfEwUME798Bmr0S88Xb90gLy4XO9d6XqQpsLucxkUiH1+pf6Qmyn334tHLMxa0P+p9mhtpUiNbONaYD81GN0xBda+nmzQt7EJxrnvjzoMp5CzTDrdlBnhgPY7Qd5ig5tFsqj3WSAyeqobeWOBrLDQueGVMavutlzuigf5bsxXz1F96Dre+68TcnpSrKpk0Y3Ow5Kg9JraZ4YCDMN0ScCStNrRak9AVfh0uPavHwDsVRe6QX6ta3Sp2jCYinSCUoZKQKA3EExEjo7w00hY05KYebb/jE8NoIJGDJALGjcY5RWVLh2Ce3r6nWXEy0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3kJGvPeVxEeOiSVezIf/DjxDhr9X2RcmsUUxUK0JEY=;
 b=hwOdOqOrKXk5rHWF+68BLuqRJMcugpYhj+inNBFnDbejxTokX0zT+0i1aLOvN+WfriH2V7yq9CLIPFhuI+8iSA548ZItRrUEoIso3mJc8Rmte+jtMfkgsXfjREQ9RHYKykLFIT1PoZRwjFAwnNRsHZ1NqEgH0L42osK1YOSv6W4Nz9ecBsodWTWn3VmOkIT4rntNxJRb5Jolb0+wpPV9mUbrD2WNLzExWyY+GxG6vzksZu/h1TEVmTzLvVPxVNGNJRL1Ping3nlPjPtqkyCvBmSFVXMPbxud3knaGNk5n/ONQ3EuOllFxUcfKs+JNfDW1UWr7TNqHK6EtauvYnxh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3kJGvPeVxEeOiSVezIf/DjxDhr9X2RcmsUUxUK0JEY=;
 b=pYC1b0bmgAG0JcxLH7BwVCSvipD8fPJvERMmEHfdZZNuGoTd0c+aov8ftmvC+Tegd4gZVzoTStMhApSjjCXncpauES7uGT9O0X5GlP5UVVUOv4b8zMVqoNrKw/R28aj2+VCmdVNRW+cPfWco9wiKFo+9W1FSA2KvEu9idmy6Ymo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by DBAP192MB0938.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:32:50 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 16:32:50 +0000
From: hsimeliere.opensource@witekio.com
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bruno.vernay@se.com,
	hsimeliere.opensource@witekio.com,
	stable@vger.kernel.org,
	xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Mon, 10 Feb 2025 17:32:33 +0100
Message-ID: <20250210163233.6445-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021027-repaying-purveyor-9744@gregkh>
References: <2025021027-repaying-purveyor-9744@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0254.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::26)
 To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|DBAP192MB0938:EE_
X-MS-Office365-Filtering-Correlation-Id: cea5f30b-c37e-4c3a-d588-08dd49f08edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVOwplEFnGJQLwPuuV59RTBscW0B+yPg6bzUkEYyJgb1eZcL+n9+QMZU/21p?=
 =?us-ascii?Q?suU11+VdNyQu0+o2Hp0FJyrbC6TNTIrJ++zTRss+VieJrmPNObhzQn0LGAbc?=
 =?us-ascii?Q?lYmrXb3k980xgfECbLk2wh2KJV2QE7UP9NFym40QfzDTAD2gtiFSUKd5kx6Q?=
 =?us-ascii?Q?SRWd1S40VrEO+IqyGQQmORCjtadO4NZ76Njh/IGEAIQTd90exVQcaIRWZ+R/?=
 =?us-ascii?Q?xXPuMpu5uXvBbl84T45zq4pspln/aPBQUk4HI3dC5JH+0+h4mzXfe5zShvPI?=
 =?us-ascii?Q?+Nq0DZ5ZZrUBVfkJFz7BSBecuC7qf4xd18whaZ1vttOgr1ge9z7PFzP9WvUO?=
 =?us-ascii?Q?fYA9yB+UaLAc/2TuDXQtWaWMzKAGm7M/USTK8FZi6O5ee+rAlHaClFUJMir3?=
 =?us-ascii?Q?RkvZcES83QTaxf98SsgotUakfUZshqLSz61Yx0NbrnkJ9ASL2D6glmw6tCpK?=
 =?us-ascii?Q?1bKYry8s7qvpkBTUrNtHjrS9K0kYit4MSlhutG08J/SsGytYW5DLUADfoXzr?=
 =?us-ascii?Q?nDyPRlmdlaoXuDt9hzF9yA1DCE2179TgkjO5xZSLjB/dA/Ajq60vIXomtoCS?=
 =?us-ascii?Q?rqXMZCsEkhYWbNuD4tagydzc8sOHHA++54njgZO8pJe4aQ9F2OrB0UW/sKmS?=
 =?us-ascii?Q?JiHTNZfUjs7U9Zp3fYg+Jnnm2uqrlt8hVXxlUTnkH6qsngjUXjWppdevbEfq?=
 =?us-ascii?Q?xQJUYuOt2qg+aiwgnPduvF8Wxhjb8FbpC4GkzyktGxq5iEzlEmtLE3CPpXHR?=
 =?us-ascii?Q?i+Qu5M4QuoCK0MpeIiFKCT+CyiiyYmiivuqkHCMWg5SX6ThQOPXHXonzFDc1?=
 =?us-ascii?Q?fcYQ0uCQ228f6tlamW4QiaDUqQjepBxDEYDovvGmRbTtaC8am4y7x2SAZV/K?=
 =?us-ascii?Q?R5cZkE9jUiujjSdGvWFWo+ZcsQpnb5jMTiOTQbIJTW8vmDyL0vew+pEVvBmX?=
 =?us-ascii?Q?TmesLJgCzoZreNhCB2b7J0raFk3/mNmk+4KsOdY44rBlBmYPiX5tvAAp/gFm?=
 =?us-ascii?Q?pR2ifJ4shQtjkiWLgfZU3w33vV7O0DjCMwJ7w7+YnqpDW+nYS3oV9YV0Ad8k?=
 =?us-ascii?Q?c8OhcVfN7Ul60ZcXMkUKNiAx1XmX5PSSPdxVJcAaXeSvnDmIapOeUDOccaWv?=
 =?us-ascii?Q?gxwr3i6mvHhkuafNh8dC0hqOggNVMcdel71nwyuq5FhQw/vJbXRVBLU6WtVH?=
 =?us-ascii?Q?N9OpHOERBXUpjgeROxMGLxpGZEj2lSjzzDoWLuoNPYXJ5+y44ho05C5kMCwu?=
 =?us-ascii?Q?C5m0RDkQUTQ+7d6WYLFDad1w0v3Mqp+SDRckuxzYpY6RQG6iyR4CGaDc8kZX?=
 =?us-ascii?Q?5nXTGva4Y6ZWt3Uriakvi9fzQpktKm9gyk3HY4LgnETvXWpXV6/OHEgcqLy8?=
 =?us-ascii?Q?0TPquJwMcqQLll3xs8l2+Lki09NWu3fFEqkei7d8YlaBikLIN2q7XMbLbE9b?=
 =?us-ascii?Q?eJDDujAe8fPQwwj2WAHW31ioepizabQF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j4bEB0f6RTdvZg4it8hkSGlTLfIJxORQheIsnje+n9oVtS2/vxbg9OI+SG5H?=
 =?us-ascii?Q?ER6wKWZxfwZrLwPUPZ0oUGjDWZSDMq2y/wz+NN3q2UYjRCRsxiKBzPFRg9/Y?=
 =?us-ascii?Q?TCCzSJsQxl8N223kaxSdyiYY7rVPBJH2SwxhlDslr8AiT/3acIVgh66Sh0nx?=
 =?us-ascii?Q?BaDhTe26vpZxDJhDsLiP+eSqfP5sPhR+tGk7SQmtW0jmp1l9Ms5lVo66qVMN?=
 =?us-ascii?Q?KR7M5S1kCz2EjMFN0VsewMTejHNPZDXZkAcPIPD/cEBZbGC5V7d91maipsNx?=
 =?us-ascii?Q?KBfwn+oTqo3fFPvbiLxYiIru1ksWvZCIItxRnWdhV0Je2UHw10geROwFg3t4?=
 =?us-ascii?Q?ErPyTAK6l4zBfV8P8wiQSDKYM6C62CviFYIkulM3FECqypx7aqKtWJvMeVVS?=
 =?us-ascii?Q?7Nm7/qb0Zq4OYGSCftSAHiymlHDcQD8n8PIx5Lhs54LUrLrM9tfhkvmmXCVZ?=
 =?us-ascii?Q?u19Xb4uSj5u08HdSFNAGwQxgjfM0MchoN+UlFlKDIis5xKCXwsbZMBg7yMH+?=
 =?us-ascii?Q?WUyVQkQUzd2MsgyAOtFS8Ilrab8UdfgFRjKCx1tQLPFJULq6aEDhgfSmunNk?=
 =?us-ascii?Q?QOCGAFYTS3rZR3wImwkcb2ayWS1OgYl9xwrGRc0xLYbpP7VCEl3FkUrwtMX3?=
 =?us-ascii?Q?bpo7Efk2ZwC7hBXfW+hSnw1wQSM+6xALcueV5KSeEVJh/25u1segNm5rK+MC?=
 =?us-ascii?Q?qyRj5B7cqFNLqnmapXDDjxRl/+TyUPlNPrpHc468PBR56HzTm2leYGTOhqjO?=
 =?us-ascii?Q?iqGixb3EFTtLuSYgI3OWKwZ+QJyupzKaDSI+uvvGyY895mUua9/OXBVI7T+W?=
 =?us-ascii?Q?8mg7Q3zNnhkLZCp+JvpmM4koi0WMXKHlmVy+6YrV2wLpNcg74e1LZx/VwgEl?=
 =?us-ascii?Q?yALwBr6X6YFk7O3lU+O59TOFsnxSpE2dBua++AKhxw/voefgssNqw8d1aZkI?=
 =?us-ascii?Q?ggkgmvqHGXVMKy6rBk+bZddo6bhqcGQk7RvNOMYpPd29gLuh6ku/v8aunxKg?=
 =?us-ascii?Q?TzfxhsdLG2/clDEr+RYcUMvIur8+0/E0aZenLT+MiJOVjOLo8qX4YtBI0JOH?=
 =?us-ascii?Q?oi0ZuKtr2hAdjLgi7tJrJ5U4aON5w4QqYkSsNerpGUYxS+MNayrrHA+i0vRY?=
 =?us-ascii?Q?LfAHilUZOBeNjKUepRotKptz7T5Trh1DBJwAvdSQaOE1+VA1dyOal0BJHG3g?=
 =?us-ascii?Q?v+IaqVhmGk6IM0y+AuCzNf5abOLGwQvCvu6Z41DxnY7sy2f3huUg6zet4a0j?=
 =?us-ascii?Q?QG3prmHIDkd6zrdVv/iL7QwSqYWRTEmLlAgWKlzJik5u+8hBVwT9x0qg6AYR?=
 =?us-ascii?Q?lj0XWyW9aW9trXwmp3mSDr0RVSVeIX+wS9Gb7O+VUAvtRecQUSiPqvXVmNr9?=
 =?us-ascii?Q?Vn9yagMthSKa4/vtZGeQyq2VNQVWKBQvaj3Z1vSg85HgfLqGnexcVR6d+Pxz?=
 =?us-ascii?Q?22Pk2tGGY9DaSR8zL3xSU31Duf+KtGeh2BfbbYdT5+ytxcb6wx1Jd3tvF3oY?=
 =?us-ascii?Q?bwiKusxmx/TdDEsJifWu5ZkCWZzlQqldh0HdRYDCo1Nc6yJJbVXymsGj+j3a?=
 =?us-ascii?Q?fSTLVyD0kce33Md+IBS1OrbkOWUF3w442QriFwNaBenG2Aue7v8iQu5Wt+1J?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea5f30b-c37e-4c3a-d588-08dd49f08edd
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 16:32:50.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Jq8wqSLDt91dqW/qbQ4doKulZrJtUhCwZlHsWBjaIc1ubQuRFgfg6E2eaHCNvwjclBOImyzHxaP5YRCltWjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0938

On Mon, Feb 10, 2025 at 10:55:07AM +0100, gregkh@linuxfoundation.org wrote:

> Never link to nvd, their "enhancements" are provably wrong and hurtful
> to the kernel ecosystem.  Always just refer to cve.org records or better
> yet, our own announcements.

Thank you for this information, I will take note of it for our next contribution.
So the CVE must be under a CNA or CISA score for the patch to be required by the kernel?  
Where can I find your own announcements? 

Thanks,
Hugo Simeliere


Return-Path: <stable+bounces-114605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0AA2EFC6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C03164632
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819822528E6;
	Mon, 10 Feb 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="eWfP4YF/"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B162528E0
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739197771; cv=fail; b=KKlFfnBIl4PMlwlYuC/JaLeZxTCeNSeOIDrEa9n/KfPcWkXJi4JHKGfYtpTtIAGXp+n2yFnm6Aqp77A7+5f9l5Zr3fPERsojk+xUjqh+gwPoO5wKCDU5Ao3g5hGSg/X3HUUE0AmlQArVaRfJ+P0urWVbeGUWUmvURpdUPjwzyQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739197771; c=relaxed/simple;
	bh=dHQ8qo+iZlcmQak7VvvLQHnfttjUId/p4Rms+phAUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGb40htLMN+ozrPejpATLLCSGDdcfIGLCHaB9TvcoElZoOUAvbjJTqycgjagTS1iBe3deeXBdgJOCTDAuuerZRoahbb1gNyTq3s1fcM7LpguVfXdwxFQOtoEGabcsfZaaOqsnwvse0zx+gEe0RjcQEI89ksFMhSNp5xeGXIsP3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=eWfP4YF/; arc=fail smtp.client-ip=40.107.22.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDwAFzgykEmW2aYGETCdpzVvbMp8bpZwBTKku/xJ32a5zCLkagmGQqxhRiJrIKF3HGUk0c/c+V7lr25qTRzcU7LakC1MQIMyQ4u79w7+v2rw/biCppU++bkDck8iDMW/MAdtyeUWxU4xv4vFPstt6QiA3PDQkP0WFlylXp4rU0e3zMJwTHwL9k/r4F1YI54clMAgHay6mosnj3PTJes2qmoS8yaajVmJ0FCtkKiHSl5DmJGdtdygHygMnkI911Bg8QD4jnWP/y5MaK1wv2uuonUDrUO9d2I6LI/ldXQIn8TB4F7g+wRSpBo+x2nq9O4rApXjlmBtgD9oGf8CqS41pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXK8i6yXPfMJpTaEXju/+j8oyx8+o4yWHA8g0lwgEuc=;
 b=mOvb2q4z5cCXQ+0Z1eZtpofzmm4+foejfaoPb7UdxaBnl2gveAtZWO1OKS2ysYGd44ezpccQPe9CCYO66dhBTpeLCaeZ1VVfMg1TpVPboB5r8xSeNXApjG1pqG/dDIxowqyj9DoyWUBp9XeSk+UWIo09uUJw7q6QBBL2bCDakPpD+3wP4cp32e2TvD1p3NSH/cVI6UkgkmBu20pFS+xc5s4oxdyzUteQlgUhIpQad9xXPxI+gakyRsRfTdSJ7+CARUgEqz9aDfJSkMP0YBgSwdPywcYXTlKjU765mhIf4xaZsaInrQHk2plt0Rd0yXQ4EDwnuUAfM+2q0hcA0S8jQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXK8i6yXPfMJpTaEXju/+j8oyx8+o4yWHA8g0lwgEuc=;
 b=eWfP4YF/GlBIqKEuepNdzKsqgso16QQvrNNC0dHEkLHLH32pBuZ2e6A8kPfi4drAoNKUliousx1b5AqUW7GGCEdlXNWLoL8Qt0byMv+CKq4nGKAiSd3resybl0kR6JrhObHkp4tElcmDilMSCUCUX9F4eab1PiqYC2MQWYxf+3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by PAWP192MB2208.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:362::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Mon, 10 Feb
 2025 14:29:24 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:29:24 +0000
From: hsimeliere.opensource@witekio.com
To: gregkh@linuxfoundation.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bruno.vernay@se.com,
	hsimeliere.opensource@witekio.com,
	stable@vger.kernel.org,
	xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Mon, 10 Feb 2025 15:29:05 +0100
Message-ID: <20250210142905.220005-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025021027-repaying-purveyor-9744@gregkh>
References: <2025021027-repaying-purveyor-9744@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::13) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|PAWP192MB2208:EE_
X-MS-Office365-Filtering-Correlation-Id: 819947a9-536f-4031-1da4-08dd49df5098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmxBRhpwBn/RiCYJhGKnvjIz8EWFf5HbMoF8H7ztvy/0bRUIS1AlYG0djD9m?=
 =?us-ascii?Q?jx7y7FJwYHmtcfGEEu0Sjhb0euUA0vVVNOhah715qGhzMvI781UxQv32QcEg?=
 =?us-ascii?Q?vfyzEOr7I01cvoJIzR7FQdIBQEw5rmWl1S2wePQgJTqkVT5UW7Ck/2wquRn7?=
 =?us-ascii?Q?HZ6veAW0Hv/SGYde7FFZ6nBtAjOED6qlg/0vNg6YHXW/sz0wHrtFvrMJizEp?=
 =?us-ascii?Q?/q3LeZBQk6iLfMUycL+l3Id2WhLOw3bnG+Bh7pZ9tbuBG4Y2uJ8jGkOltHYg?=
 =?us-ascii?Q?C32mFiDWWX9yv2w6PM22zgQupYC7ID72IO86QVOLayGBluDaitKbbP/jt+y9?=
 =?us-ascii?Q?JONeUYo7NoZG6dFfhmv8PiX95/v5OAj+ZcFvbqvk8XR8XBKq2ZBWognyhEZV?=
 =?us-ascii?Q?Igqhc85d8uj9gavUVGRzmBsDFSKjH1ip2/9oaPw2tvY+7Fpct3hNGimNrlPK?=
 =?us-ascii?Q?VeId9HNP/vbiQHd+BpnY1TLz4dFRTyZO9gSVjFca+M08+dzypWheChlHXF/L?=
 =?us-ascii?Q?6+yP+dR7VB91RI3mAe/OFn0nCmO8Cua+kPjAdrE0spswA1Ox67VTJjaB0eeB?=
 =?us-ascii?Q?BwHvlokit3G2ReFAp5/3EiUd5Trz1KADS97PUoO9kxuKtbK2DpmCYqFAirAM?=
 =?us-ascii?Q?5HadKoG/i7KWVFaz9VM99wZRC+YaXT4dYM27qT2aFuEz2KZ1/aaVuNq80fKY?=
 =?us-ascii?Q?xPiLL9NGKCnbeHuYf82vF3jh9i3mTCv2zys9ZjreUPgeXPuj/2GtbmWynbuM?=
 =?us-ascii?Q?8yhEySf+sRM5qH1Sw7T8Jok7vYqz5I7/zSTK9gh67JwZMcnuMyg4ll43SkuK?=
 =?us-ascii?Q?ljPhs9guZqD8XOtYg1fs9LjglmNkWTDoKP7Yfgh4/4xAEbu7YGW4HZJ/uKuM?=
 =?us-ascii?Q?ZK9Qt5Tdpr6zcvQ2uVd+/ch6PmaXmtQZDS5bPK6FTsY7yme1rd9NwW38flms?=
 =?us-ascii?Q?9xyrhfm/BRiMOhSswQI2NwoRqIwZfw9OFMfPRXBINMyHi428nop9q5BN/ua/?=
 =?us-ascii?Q?urNUgax8feCmklQzFp4YLP+Hno2PPt0M57CIm8pBeBGaNAR+a/u0gw6+7NQn?=
 =?us-ascii?Q?FtN+SUllpzTEwqtOy9oiGEFFeWjwGQraDcbtg0wl3Tas/bdGwriVuxkN0AQ6?=
 =?us-ascii?Q?XltkIeIlruvhS6wYE8IYf4/IQTr3pxtb80Jl9uAfVAjg4179YLl0Ew1+MqRK?=
 =?us-ascii?Q?mO1a1WONiwKhJPcofHxSVVFCzAfmxl++/N6ntgiXQtqLF6B/UKzEYgrYknQx?=
 =?us-ascii?Q?19VTCp9Z8p3rX6FwVDm25uKETZj9qwUir0BE0slXb82vCqqfVmKqW5n4ApVn?=
 =?us-ascii?Q?9sjK2IaAjjXamthwCnhFK/0tr23CHZb/vyHay/tW/isuGI4qh+eVmYj14IWB?=
 =?us-ascii?Q?9ioSQhTqobza3pG8QpdxrFkgNw2JVbAwEyMNtXemvkYNVWwI0+5RFYwsMi6h?=
 =?us-ascii?Q?5t5+Lq0tEVWI6kIdfu/oe5qF81QtMrre?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77qMpSik07EjOPp9VlII9p/mabZWljG6+yZQGcmxS1sCsQnfjPKi1GvX25o+?=
 =?us-ascii?Q?IrQayNg/ojihekToaEDqxRj4naAUZPHEYarBhe2Wjgu6WeoVN+gzI4RaBuEH?=
 =?us-ascii?Q?SYJm1QderUJch9hNMaNfzy3cM7txKUPJL2sgPQDWx3bDtH9ox7Fv2z+BJLWo?=
 =?us-ascii?Q?ak9Xblh7yWyeCbKPURerGY8OBEfnYxWim9aybqPFVW0Whw34TzFXhfxaJMM1?=
 =?us-ascii?Q?/B9LvWgbROx/4dL758hjPFg4pyHIU+NtT/bY+p3DLxyHxwXMymbBClolMsw4?=
 =?us-ascii?Q?qcAa+orG2Xj+efw3f5tafdi0/PjImzS7YyV/WbwTM9goDaRC6nKLz7BkN/D2?=
 =?us-ascii?Q?I0mwtZ9twIe1r4bXvL+oZGHl4yu13GOZ0fbwiH7rbOBYJUoDD6L2htxGKCc6?=
 =?us-ascii?Q?R0TKXI/MlQVVpuqiX0U2xQUTEQaNOH4z7VF683BotCAxWX35DO3BL2mScAhk?=
 =?us-ascii?Q?tGibBlx/yh/+sNKoYAItDwQG5EStph7A/srpsLBiXtjkelVEoMVS9mA++fhb?=
 =?us-ascii?Q?veQiq3UNUMlb3RVwng/g4iWE0nl+y5wvQvKPwGQ9LMxpy7mOFxLX9UPhmwG4?=
 =?us-ascii?Q?HixQEjQdAPpBQiFRyFXapgxJM2DAjOU8SlLJYdQvW95NmCugp5iUeDLmVC/h?=
 =?us-ascii?Q?fZK7wR9yujtCvobFB2k1Ak3tEgEbhSbZ+A0C5jUT83I4BXgrfdGmAN2HCKZc?=
 =?us-ascii?Q?N3A/9OH4sms9YarADGtuCGDwzEEHzy7PzMef8DvLT5SE8KIXhpa254aHYtmC?=
 =?us-ascii?Q?Jrexm/Vu1VjtcQhUOm63zv/xui4aFrt32ejldZIepo9gsBbEquPOklI4cXWb?=
 =?us-ascii?Q?/cL6k0L8fTrorlaqudRIYtFknfk5suXWxthUQisMst04fx3hjH7+gd7erSKu?=
 =?us-ascii?Q?9xOfjreN+C8XeSYSXYbeXu+9xUAUybXOfJlUaRKEhrAzP2ZXVFeBRzOLwyOy?=
 =?us-ascii?Q?HpLx0iMjEICqc6KDSmzuZX2/XhV78eHcDmALbrJbEksJjy52KkhtJT3WWyft?=
 =?us-ascii?Q?u7diXJRLNolaYP8KAAX+AKA8FqOERipK+0IKIvreAFEbIp30W7ngNP47Mw/7?=
 =?us-ascii?Q?ApfdluUSeCTPNmRiyzNqIZxF1NvTXfdn1FNFRzTdAW28m46679NiruhVYWSe?=
 =?us-ascii?Q?b26+4WblzxzXbO6oS6ORye/uYwBeV13w9QLjyQKrenA5wQsawOZE+ujrwdze?=
 =?us-ascii?Q?QSqzjviRJf8r4t8fztOtd2EtiLQsFSbsrRkRdfRLmTTMgEuOQ3qHjOlJfiUB?=
 =?us-ascii?Q?VGTWd6OX0kMRPCFW9F1Vf4u0Ap9AmiQuytyS3KT/zztVLVlweLFgfGGfw78E?=
 =?us-ascii?Q?42CLr24lwz9W1cK9H9SGBComIY4zqPMWGFi4D2sMn5uD/sWZxpsTx5KpG/J7?=
 =?us-ascii?Q?OvcNqYDVMNA/mODdKkI2WE4tcw61jEzisvBe27IleSeQxuw+QJ8gLJigg9Ju?=
 =?us-ascii?Q?4+UN9+bSjOiTpOt6NJ3rQ9AU5UWlKWMDlYHaL9vKeSEXPH6AV9eHYi1d7pYp?=
 =?us-ascii?Q?gC9VcfD+jOhvMSPaefxPPUEUEjoKTd927IJragIdxT+5QPprJQzg3yzfqu+Y?=
 =?us-ascii?Q?qIBCY8is/07P9g6cSP8o8HCCveuHL1wQAU+do/mEDICh4e0lWGk8ZIG5Gqir?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819947a9-536f-4031-1da4-08dd49df5098
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:29:24.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B+brWWMF8hscRcJxcPzE1j1xocWmnMZVkm4Y4wAk+wVpJlp4WQAhgwvdwV0sbZ/CiYYCpIiwMsxCKrt5SZEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP192MB2208

Thank you for this information, I will take note of it for our next contribution. Does this also apply to more recent kernel versions? 

So the CVE must be under a CNA or CISA score for the patch to be required by the kernel?  
Where can I find your own announcements? 

Thanks,
Hugo Simeliere


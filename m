Return-Path: <stable+bounces-222817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJHEKBCYpmltRgAAu9opvQ
	(envelope-from <stable+bounces-222817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:13:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236B1EAA12
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1753B302C6CC
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC62386C3C;
	Tue,  3 Mar 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Lh0AyI0p"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45059386C0A;
	Tue,  3 Mar 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525369; cv=fail; b=LTXJkGeDxfwlQ93SgAClnf04AidOsaIR8YCkIM7Jo0zK8sO4suoQ8TfvtBTtpHI6Px627uyfrWpv4Q07nwhYfCC+KtyGJEju9O8X0oYINzkEhbGgE2jyS9lRBD+v1SLpM/r2iF42EVy06uwP5QsjaKQ14qqEfdaSzA7DzyXk0kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525369; c=relaxed/simple;
	bh=NSVGzTRZQ6k6vWVkbYM05BLtUjKJiDXEsL54yz8JQB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtbZYDEwreZU1+j9W6nEIncoNmDSx6TaHSEbfHQSMTe3C/AjVVL2ucB/RJR1Zfqk1AMozejdp0QA1j/qBzHogl/EgWZwMAMp+Bg6nJpzqsij+eoZSrk5nIRAbneXdbIiz6NDvGAAElSONMhLNncDxmIcmjJrv3Lk4TgJwryGSAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Lh0AyI0p; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6234Tvi61495135;
	Tue, 3 Mar 2026 08:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RKBrcMTKuy5RJuAVebn+y4AvP8k9/R5BWG/qJk/DIAs=; b=
	Lh0AyI0pAEfW0DnCFdtta9iAmwkNFxIIOXqTehcgQJ8k4xkQSRZ+Lp7Bl1bOhIO8
	SagaDin5s/mGhYCBuEckIBgj91iUQZno2XwTXQF8uasDPKwdQx/kn3cM+8LWY5To
	TNSqwaBSbu5rgwKAGgRXvvdhus70rHCDN7rant5oRwJ2C8mzgzq6mfdtnUewAd+b
	4SD68QRAtEyDxIcyLjaIH9KckbUclPyOaryvWicyE8+q2iImJIUJnj4z15oSJnYz
	UWqWs/4mv2p1q/5j0mkAIz5t4UkWjLxDQj1lmM31vBsO8IwSYfM+ValRHz+kFZ+4
	0YVpx9JKxZbnDxlK7Tuc6g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckqb4kcwy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 08:09:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxE2OV+/qtNmaFHJnDrPP9oWkIAdx8NfVs+9R1fH9sFWrE5aPjqyuV3PeRDzGoSozPD6pr6LpVhs64QgXbRawZez8XK6biMxYWZ+QJxnvv6woRIz2WfBgbFu219oYrp9qyIqM7SNkMS1WdgRpxMtJ0v1EXFk2HHr5Y3WfmTsCesel9q3SsnmMUUuf8zjfqHZIa+Kw/a5GNOei6OX0J9buxmtvkFBdoBcY9fnuRWN98eAvKeyBt+PpXKWS7gQf+mi+hLm+wE6Dp5rDocqi4VQK7a7KFfFhj20M/MS7YUuixMLuAPHNU9fagqG6yDWJN/d1KqRBiVTlt6KvTtjwlpRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKBrcMTKuy5RJuAVebn+y4AvP8k9/R5BWG/qJk/DIAs=;
 b=wQ7dqg3bo1Zc2dy87z8cmkp3Z1owvgaO2Gch3GzkC9w7bWSWWB26hiEeWp4KMEd2qtIKs+0VuNQXgxqN9itcHvGDnSs2VYj0pcWiP9SXeLfSgSZb7w/9FA5YcJq/Fafm4kL2BQJAc5K4ZxuXVga4aAALTRAHkAZ8eSGCyJdB/1rkAX5shk+Jqd3BM/nHi51eScN7hVNAYoIsjHE7S085yRxuDy9gQKGlPnRr27O7hUaNqg2zUSTk7QVY2QlewYQnWFBux+boQ1rfBL27tO7oQx5kHyeKybpR2PLhtZNr8rcFykFUm0QjYGWYkrs9nYytJsyJzbh1v8DWT2MbLvMoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 08:09:16 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 08:09:16 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v5 1/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for complete serialization
Date: Tue,  3 Mar 2026 10:09:02 +0200
Message-ID: <20260303080903.28693-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303080903.28693-1-ionut.nechita@windriver.com>
References: <20260303080903.28693-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: e055899e-df48-43ef-1227-08de78fc299f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|52116014;
X-Microsoft-Antispam-Message-Info:
	5p62BEhvM9QATerYB8l+wqIPZeOjjrAfZIKbOlsQeQJxnx+GiIvxWIdQns2reTY9oSkj+UAn0CdgnQQVPAH15o4bIyjOLtlslXG2PjNFnM8iAEnpf6IXv4K69yuO35RQdMppGR1qjbIMKdpJApoXPNFeLm0ugGbkKm4ncsOqx+3w0v/NC9b8rm2uy2gkwcCk92E7bchblpMNqnlBXFZWLhF3c+wo+7kN1oyjlPz14pLHgCEU6Od7XkObfwnDdEGy4K/tjR7m/xRq9dXGhnfUjibuhxRs7VX65DAaYCZjYLfJOZHBP3GJDnsUwXE2rXdrTrbkpPZ0wgh1DhelXvLyU7l1X/+gnXEMmDj8eZUezLt65xEVRghflUXlCNegnSlwS+aTJjZIVmMEKpqzv/EMzHd9lpWRJVNRBj+XB6IA27J6nCE3i4/eKFX+CTF4nn83op0qK3a4Ab18AMaeetGz4aF1dQjgZVjebe76DKUjfWB2EaHkfGjmz6VjK5QfWEVxF+X8TB41ad1/dSReeW8Pc45jUlf2wRbulKxTX5GTJ21L7DyI6NSfqdbYUt63s0RPCyjBsvPfGwUqiQVk2gNveND/nZYTio1fpPxZOlK4CQjcy4NxIyrrNO9QvmMp4DKsnR4FJNMq4hJDobTzugE5o+2npO4gfbnO79mtWbcTq+u0WbxmmiCLX9ZT1+Zwy9Xy4XtKO1fFztsAu9GEBNlmVro/EAcpDoTAJct9vsEZOjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ymy5LNqBUzu/m0ehCfqJhqYNmymrswqk+ucSebyCwdZ5JsV6jN9eO2+l9Fid?=
 =?us-ascii?Q?yjrDTszCFZm2183RbuiuvUk3f1MudXTPG6OgAg94MyzXd6weEEkwUXDRtAm1?=
 =?us-ascii?Q?j8iX/qLDrYD/0g3CR/bqKZDkUd71bZlCUyyy3xrMEgEHX0YGA8D08jvxpI3s?=
 =?us-ascii?Q?9vV4Gluv8fRIcG7O1BwP1Tg4pl+7IccPumeEnSRQ817XKQpHNjqeAZj2diik?=
 =?us-ascii?Q?7tLtXa6hI6WNIYIMIJNJNlSZxIUCpLR/h9QNtiK4WECCTxoWM8hrrylzlOLp?=
 =?us-ascii?Q?gUNGtHuqaD/OzEeYw/wP+JnQYlpOXsanOlC7hyBuT9x1CfTJR40Ej1LjiXK5?=
 =?us-ascii?Q?El9xkdLLnYNJeahzRgfXEAEyv7lQGBBdXVNtJ8WykRHpbE/yg+/yAsZwcjnT?=
 =?us-ascii?Q?PeS8MQv1ol3oh1rqF6lxcQNNNtabH3TwAX3RCPhsyGz1+cFUkrNzlrUgXW7q?=
 =?us-ascii?Q?HkyrKeKAImga6rBmOzFtwOLobkupOYaKZWXS2qd4CC4//MxgtjctnM0Jy3th?=
 =?us-ascii?Q?R1O/ksiVu7Z4fyU6g7uIVoKEarXq6VwjLDRNR30E9T29z0he2QAjk3U/Jk2F?=
 =?us-ascii?Q?qRdAQgMYqlUMYMoo9HSI/4RKIs3ErEA0Ht9eDIsqL+prRofyk8YoWicsV38N?=
 =?us-ascii?Q?uXSceSnKxMS1+MMAtgWuEXKoZ7caDlGKVJDzYXeYn6j8QLfToyqVwFP1WqNG?=
 =?us-ascii?Q?uyW2NvkTVA7fAmsGKQCqew8pIBoygAESgKDoxcCms9gv8nSUOuk/m5QHt6eD?=
 =?us-ascii?Q?ImY+mQQATiTA0uOrBmdPu0uivMP9s2Z1YQJOx4ex8iDypbdSdXrjDMnCgYV7?=
 =?us-ascii?Q?owD5F7nkyaB5GpUgwXwoIWQJWiEeqbVTe4mFZbAUQD/Wa1Gr8VkHFFSB/hr3?=
 =?us-ascii?Q?cfcg2fQFmlBB+5LSW5Rq2mb2w/hBfdWYpO2wU4QIrTqv8rmYeONRDOlXvUaZ?=
 =?us-ascii?Q?xkASnPn7WFc7ZVzqgNIV1xgNzAE5zGvo47066qYPdAMekiKO5FkH+j5kGN7Q?=
 =?us-ascii?Q?Pdkw9qxLrLrZhl0btQ9MOlnRSfscfbhGP2AT/0sXoGT0rZw+wgwcnQH8ljTh?=
 =?us-ascii?Q?coGuXRJiOvv6vOApQRJQBWl+ixiz0BzT+N9XUtTvt9O48K6utXl7W2BiFSRn?=
 =?us-ascii?Q?T0Gs4ALpsk2xXeIBVMY19Dpx0SNDv+FMSQqla4IvGgUVqLP657GQr47zdkdf?=
 =?us-ascii?Q?SBoBcE7bOo7D1/OSkfpM3owS/hHh5VNj2foC+ymdvWjpuNcNk75V2b7iuzHF?=
 =?us-ascii?Q?AEWsXN4UtuULwq+xAEPr4M2CS9VxgUPTHaXb5EjaVhhFOsdN6mkP/Zcg+G7i?=
 =?us-ascii?Q?3/JsT+ZCqb6MnpqqNIrpZ06K2cX3lHOGF9TZ/cRfG/8n4EB1b7EvK+LcSXjM?=
 =?us-ascii?Q?NvrdZzTSqsu6NFBbIlaTmZI/z+1/Q0LiIa5ok07GK/Kj7oFasfxm4svtGjkW?=
 =?us-ascii?Q?Z8G3yoPtpfjPRw6U9RAGWpizIRdCyk3Tg7P22lj2uQP2G3cV/Uue6XPa2dGo?=
 =?us-ascii?Q?jGlhKgrm6eYrlJKgoFLLg1ppi2Xr6XKWTaHHB8n3NTd15pR7njnZgxKvCJ0c?=
 =?us-ascii?Q?wA7+HRk2rDmeO7VygiwPsnriL3Q1ZM6yq+1J1/xCxAhJvAywQylZgB2ldrVw?=
 =?us-ascii?Q?x9MJ9t11KxY1+q6fSyZRhzgDKPr8pNRZA6tVy1ltm3Ud/miaN3tK9yhBJ4Ra?=
 =?us-ascii?Q?z87Bk1VacbIgrHrx6qJVmGxBOxd18OPe6H4CQr7zWhsz557ioEHfA50V8ms/?=
 =?us-ascii?Q?oleJ0B+3wsYFciZYbUyjyzYs/o2MncQxdJyllTGJ7V3QUI6WDhp6Z2OZC/PW?=
X-MS-Exchange-AntiSpam-MessageData-1: Kmd6p1MbE3LpYwMrmLxeqWvGjo8KInvEFoU=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e055899e-df48-43ef-1227-08de78fc299f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:09:16.0378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ryy/70IXbqnVwS2lRfuTgO/6b0EQbSA4GADyKtEETDl+ylnZo+kPHTjueqw3aUIu5uqUJzkkF7xvXp0uD57oHHs5PisO5LClk9jtZcQlksk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-Authority-Analysis: v=2.4 cv=LqWfC3dc c=1 sm=1 tr=0 ts=69a6972d cx=c_pps
 a=7hCjIaGjES2TrnZcIlaVSg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8
 a=Ea_S87Vdr1rjus-4YBkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Oiv1Fd_qC1cYt612mkxBNZxIhb_W0U1R
X-Proofpoint-ORIG-GUID: Oiv1Fd_qC1cYt612mkxBNZxIhb_W0U1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1OCBTYWx0ZWRfX6h3Z1N3LWaZh
 HhwrgFo8Vx1ZSBbnzfefStPqF17ur5AS5d+unWR12mvrpiYxPJt9rTa3jFyN1mtfgdIKc7kVlzc
 giYObgj+R2fejyapJ1//kitmoOneJ1rOTKMgSZn5o21NVFphvrduDqDDxhZ4muY2EpRKswmHq86
 6EsLXkJX8eZeljnvhxRlab6nzYqHr1JHB8gzxAFxpfh/kp+YXcqArD0jEweHj6/jBtggmz2UHmR
 z3OWcjexHGTXCX48SF81EQokDyXkxhwOQcBbYf73VJGCWazvWAXyoIMwZ8rsorUG3f/sH3Rn7ZJ
 fTufcoed0WZgorhiJb9tAuYvi8cNEdz7uwbvscJvYOes6fPpvsIapSzZocdJFFS0Nqx/gy1M+xM
 qmN+jxooWRdnT869Ef2013gwbWU62WADxdObTIVMwJ1Rgx83jGmOBVP/DBiYmZG79V/xFdViY9k
 UyRPNGQffLpAC4impzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030058
X-Rspamd-Queue-Id: 0236B1EAA12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222817-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Instead, introduce a pci_lock_rescan_remove_reentrant() helper that uses
mutex_get_owner() to check if the current task already holds the lock:
 - If the lock is not held: acquires it and returns true, providing
   full serialization against concurrent hotplug events (including
   platform-generated events on s390).
 - If the lock is already held by the current task (reentrant call from
   remove_store or sriov_numvfs_store paths): returns false without
   re-acquiring, avoiding deadlock while the caller already provides
   the necessary serialization.
 - If the lock is held by another task (concurrent hotplug): blocks
   until the lock is released, then acquires it, providing complete
   serialization. This is the key improvement over a trylock approach.

A matching pci_unlock_rescan_remove_reentrant() helper takes the return
value of the lock function as argument, so callers don't need to
open-code the conditional unlock.

The "reentrant" naming is chosen to avoid confusion with existing
mutex_lock_nested() which is a lockdep annotation concept, not actual
reentrant locking.

The declarations are placed in include/linux/pci.h alongside the existing
pci_lock_rescan_remove()/pci_unlock_rescan_remove() declarations to
maintain API consistency and allow use by external drivers if needed.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
Changes in v5:
 - Replaced local pci_rescan_remove_owner variable with
   mutex_get_owner() to check lock ownership, avoiding the need
   to modify pci_lock_rescan_remove()/pci_unlock_rescan_remove()
   (Manivannan Sadhasivam, Benjamin Block)
 - Rebased on linux-next (20260302)

Changes in v4:
 - Rebased on linux-next (next-20260227)
 - Declared pci_rescan_remove_owner as const pointer
   (const struct task_struct *) to make clear it is not meant to
   modify the task (Benjamin Block)
 - Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes in v3:
 - Rebased on linux-next (next-20260225)
 - Added Tested-by from Dragos Tatulea (NVIDIA)
 - No code changes from v2

Changes in v2:
 - Renamed from pci_lock_rescan_remove_nested() to
   pci_lock_rescan_remove_reentrant() to avoid confusion with
   mutex_lock_nested() lockdep annotations (Benjamin Block)
 - Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
   to avoid open-coding conditional unlock at each call site
   (Benjamin Block)
 - Moved declarations from drivers/pci/pci.h to include/linux/pci.h
   alongside existing lock/unlock declarations (Benjamin Block)
 - Simplified callers: removed negation of return value and manual
   conditional unlock in favor of the paired lock/unlock helpers

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 16 ++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..adbe4ecc587c 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,19 +629,23 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
 	unsigned int i;
 	int rc;
+	bool locked;
 
 	if (dev->no_vf_scan)
 		return 0;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove_reentrant(locked);
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 
 	return rc;
 }
@@ -764,10 +768,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 static void sriov_del_vfs(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
+	bool locked;
 	int i;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd79..86c8f593e0cd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3522,6 +3522,22 @@ void pci_unlock_rescan_remove(void)
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+bool pci_lock_rescan_remove_reentrant(void)
+{
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		return false;
+	pci_lock_rescan_remove();
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_reentrant);
+
+void pci_unlock_rescan_remove_reentrant(const bool locked)
+{
+	if (locked)
+		pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove_reentrant);
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..080950f0bab3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1535,6 +1535,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+bool pci_lock_rescan_remove_reentrant(void);
+void pci_unlock_rescan_remove_reentrant(const bool locked);
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.53.0



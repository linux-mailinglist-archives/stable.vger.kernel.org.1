Return-Path: <stable+bounces-215565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INgcNi9KimndJAAAu9opvQ
	(envelope-from <stable+bounces-215565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:57:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3089A114A62
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 21:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D703044A77
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847D33A6FB;
	Mon,  9 Feb 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kCHT8/ej"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BF331A6E;
	Mon,  9 Feb 2026 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670558; cv=fail; b=SjOpE4oTGANsfRKt11ylJAwQ/Pn2iG3rtmSTNyiak2NhovMe9101jOgUd3bAPGzgSPmg/vWPhvnaOYdJDlJsPPT+hk1VdCp/D1v9axpoLRAuNPHmfW2WcoJG1Ic7VznA8tEDy8ckUoqbHpk8oXDQJhQCdTsRO0ImyhhESzoelzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670558; c=relaxed/simple;
	bh=ZfEYHNui5Slmfvc95ONGXUYMN1toaKOAcgy2c9jdPso=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=XV9cXgxXRMSk6YMsknbRreNieWaeYN8wJu6z21ExwwGEO9uPOx0jgxmjddSM/dLAg9tIaTlAMj206ZBN/FkGVeDzyoPToLmvvI8bTBo7Kw7ORq/J9kaQjE0ZZT5Eh6X2ufyIctA1HgOPQpEnhpzqqnnWR2tUx1AuDij7ghz3ZEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kCHT8/ej; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9kVXkCF11CKMs1Z/ZGy5vUiZVmeQN9OzARt/mU/66k3wIAiVSrFfEp24dT9t5w1PwowBzhobzqV2OgIrDZbuF+7Qm0yro/YlX5wfBWyyGtDwrRtVzWzeM9dgv6pumCoOMTNwt6YAxPXsLF6UADigPGF3HpLCX6I/kPAHyaUGWdeW+mtsFYkkKKbFvEEOG2ZGdUyonQfDaCnrnqqNFe5KN/qCNdfgtPBF+j75K8o6MUtfS5ghROlrGb112B9J3bLlBn9f1ED8aQdn7hRT2KTEbm8ohH7crWkLmXyHGy93EHb+iygAZ6tp4cz256UloHaaduLQo7+RGHHKJq3bcjZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OudY9dCKjvXIDXOo+BabGUyqelRXF/EGTYEaOO0GGh0=;
 b=WeQeLfkCVwo/dJ3+EYmoGuPSY+tfrUr+hTgV2YHJs6P6PcbCA8ke0WrMJUr77y6RHTRJXSbKVOqFZbPg4lcdioFzKHbfbw3DT70p/UgTSE212SRCSxkpTyqy6fzXBiB2urxb9yuBeMaD7KAGr67H0Y7SMeYcOhJFrPpqZEG4uMs+FASH83sQ1XGlK2EhYKnGYqzc5lNutn446iCKmzWAXHzLvVEnXejLHwoo+i+VpiqlfHwG5GBzu05SnSjvNA56Cv83Z01lNKzFcDd4xAsv/E+Pg/qQpYybkzO1xF3ky1rYYYsBdy3pOLYtQpAKohpJac1jwK44xPO4GgQSlqLS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OudY9dCKjvXIDXOo+BabGUyqelRXF/EGTYEaOO0GGh0=;
 b=kCHT8/ejI+AUdeiIwIxFHJl7E2d3xwgPEZFEZPEWtepmr/bRQx/TE9IEcLT/Lj/htco7XbE1w2xj/s9Y2MY+/c74L+2c8RyNMTW/bTQveauaVkOMaGFKwYQl2fWZxCIw3GyzqVV468SySToHhCxCp7EybZOdqjCuIozABt8+DeleLf2iOcKhpnCjhpZW13GxXfMUv3JaxJ23wWhKBvWL6fTxukJYnYr/T/YsNemes8nB7uEwTevNmFfzSruzwrocvB1SEnnSt6qCe3ljfJoBUuo//uJDT6T1u2iOGzajmljJrPBtpdMC+xhZZWZVGb6JHo4bPr5vsjGtFjRQ/qb1Kg==
Received: from SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::24)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 20:55:47 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::a9) by SA9P223CA0019.outlook.office365.com
 (2603:10b6:806:26::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 20:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 20:55:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 12:55:24 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 12:55:23 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 12:55:23 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@nabladev.com>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3e9d8cf1-7946-437d-ad8d-ac933e21d654@rnnvmail202.nvidia.com>
Date: Mon, 9 Feb 2026 12:55:23 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 351761bc-4a81-4430-fa41-08de681d994b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFh4U2V5bXRHalN1eXRyRUVndUJZaUovejBOYXMzcitXdUg0ZE5KR2haWlNz?=
 =?utf-8?B?Q2tmbWtyLy9BOGh0ZU9XYmdIMFZ0UjNjS3lnVFNEbzBpcHZyN2tCMkVZZDBy?=
 =?utf-8?B?UGpaNzJYK1AzdXQvYldxNE50MHlDdXNwa1BEdEdJZXJtb2dOTThreU9oNG9C?=
 =?utf-8?B?c0xqQmlEazhCNk5ncEtTN2VVQ0Nid1ZwNDA5bUpucUQ4U1cwaXM5QjVWMHVz?=
 =?utf-8?B?VkJTLzJGc08vS2loL3ZPT2t3WFNaZGU4SWpnYzRMYVljQTRZZmlQWktlK25M?=
 =?utf-8?B?TFNPK0VORVo2NG83OWlZZFkvZW4vaVlSb1lHdmNFRHZYTXdwbFY2dy9KZFcr?=
 =?utf-8?B?d2tSd0doVzRXMXp1bFVYWjJnbnZldDE0OTFqaThoY0NzQzY1azZMZDFmOE9x?=
 =?utf-8?B?L1pOb3pXd3d5aWRaVkk1bjJEQXF2VFJkWHdyVU1yTzIrd2wzVmk2OThKeERt?=
 =?utf-8?B?RmNJS05lQVQ0VHJ4WkZzSUJmRGN3SEYxN3M5YklTcFNWRE52a1Z3L1pPdU5j?=
 =?utf-8?B?d3VmdzhiSTMxa0c2NjBGQ1VOQ0M1bXBWK1k5Vk9iLzZuTFZZVFk4QkRMd2JP?=
 =?utf-8?B?OVhnVC9mR3JzL3I3Yy9EMjAzUnc5QVJFTGVpa1RRTjhQR3FWb2dyN1J3R0Vy?=
 =?utf-8?B?TjFKcFZ2RFZGWldXWWlwZWk2Y29KbDZtL3VuTUZvclh4TjMveXBNaitONGxr?=
 =?utf-8?B?cm80KytFMHRydlZERDR2bHNqOVJDRXVwckR2WUYwcjZub0dhY1p4U205MmhC?=
 =?utf-8?B?Nm9IVXpPTEVXL3JqK1NjcGh3SGNzRkhTOUpZQTZhRUdTdGFDUUJEMXRVY1VP?=
 =?utf-8?B?S1QyWWJ6OVQ5S3B4ZXBHZy93a0tMSkFVWU1Db3gzQ3FBcTJPNUhFSjB0Tjc3?=
 =?utf-8?B?UjdOT3FaZVBDWkNSbWNMS3FCaWpZYlVjYngyTGQ5Q09EcmxtMGJJME8vOHBF?=
 =?utf-8?B?T29tUDRVNjhVQXRHdHdIZ2xPRkp5QzhIQUltbjJIVGFKY2h3MEpwbUJjN3hG?=
 =?utf-8?B?TXVQT0pUdkVPMUI2Q282Um9KOXZsQStob01VeS9PTE9sWVdjRDZ3bHR0VUpC?=
 =?utf-8?B?YkxqZVlIMmJyYmY0Y2ZrTms3WlVKWkJhRnlRU3hWbzk0ZUZBeGtkaWdpMXN3?=
 =?utf-8?B?TU5IL2NYK0hIYWswSWV4ZzEvYXJVbytaNCtxZ3orNTNHVlR2NFo3eDIrRDR4?=
 =?utf-8?B?OW9WSHcwMDFqN1Z1WTJBV1pEUTlwbStCZEY3OGgxejlVaU8xVnhXcXRsMHIv?=
 =?utf-8?B?azA1TDZXTHlHTnVmQkpBam9FZWZPUVFlQlhlaXJldFdwamtkaDlHMXJnUy9n?=
 =?utf-8?B?ZXNqT3FKUUxBalErYyt1MnJWQzFGWk9zQ2V5UFg3YWFsMWw5YzNpWjcrSWpU?=
 =?utf-8?B?NFB3QzhXY1Q0WGp5ejhxR1ZraFFVaFdFS1VoN1ZFSHpyUWpjc29VY3RYVGJR?=
 =?utf-8?B?WVpKam5JYU9hbFlBLytuUTFDcnZYeHYvN2VQVUlLaHVvbjUyYk85ejUyczI2?=
 =?utf-8?B?NldvYTAyWG9KTi94MjQ3VkFaYk52bmo1Y3l1L3ZrbG9GUndKYi94Y3EwMkRo?=
 =?utf-8?B?WnVHTDdxem5IZkpPb2VRam44TUwvZUU3MVpVVjQzVlgvZHdHVlBzWnFoa2JE?=
 =?utf-8?B?d0pESGVuQnlPTU4yQ0FiWG1nMkFRUnQ0Q0NQc2R6bG1PckZEQTcwQjdhZjFD?=
 =?utf-8?B?VTRjZ1FoNmtUK2RhRDR6YTVrbG1yaWM3UHBWa2haZ0ZpL0Nyd3c0QUVxM2FI?=
 =?utf-8?B?dWY5S3l2SjN1eG1pTnUybWw3bTRBQVFqbFNQYnByLy9KZE5IV3czZ1poYUIz?=
 =?utf-8?B?eHowamNBTVJhZlI3bzIrRjRnU0l3U0traEhTVGhBUytBYnhUbWllTmY4Ymlz?=
 =?utf-8?B?TFdYcWpWVkkxVkZGSkw1cEF2Nk5jMnFkc0MwNW5Pc1Q2NURSZEJJSHR3VWg2?=
 =?utf-8?B?eTR6Y05MRHhUY0N3Qk1nT2d4RC9EdC92aS9lMWo3WlpRQmZOa3BlcU05VU40?=
 =?utf-8?B?aGNnTWNyTS9nTm5GMDhjMlZRNnAxd1BMQ3hSNnVhQkE5dkhiSWQ0UGhHc0dO?=
 =?utf-8?B?UWxvRm5xM29SMGZqM09Bejg2ZVR1dmtBQlc2aEcyY09tbFlqdUJqQ3d3eENI?=
 =?utf-8?B?V0ZHcHQzcGdYd3h1V1h3V0hPTFU4aU1TR2M1NmFFWHM0ZDRSemorQlZFZVFK?=
 =?utf-8?B?U3EwNlZlNkJabFZHMnhVbStIeE44SzIrR1FTOFpZbkdnQTdVTHpKYWg3RzNV?=
 =?utf-8?B?MTA5YTNKakpEbG5RbEZhbXcrVjJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n4VPNo90G1qi2MOF3Xdo2XWkWYUWhdQeTURzJ0LRPFijRyO6XSmn2CXzaSSJkmG1NqM1IcFQQhgV6YNP5lQ8gQeeesVkXS+VFct1NKpG+HiAacW759E+2j1tY/PV2YO99hW+AmpJW7UDYilfloAbm/ywCFfqg2WT7qNtVYsRFVSKcDiafvnFxje/8RTAWpgmCfBRIdPJdyTbXiu04q9f5cks+IEozLoAoFW9TXyILWUr3uqyr1sHyyYUuq2AtL/Q3K4d6gZ2wGJyOtPOK5BEFH49+xJM3e2Xm0+unA9/oiGBgOHWJ6UA6MtpsjGQvJ/zb6MCEAo954AptjQFIsLrV2GBwC4ThjApmNsSzRggKoyA7HdsaLNC1/VFdSTp053e1uV7jrtlrsTQkjpuCL2Z++ILHevYXpk3Kd5/DoUnwIbklOZn/dCpPk0EsYx70jAG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:55:46.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351761bc-4a81-4430-fa41-08de681d994b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-215565-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rnnvmail202.nvidia.com:mid,Nvidia.com:dkim,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3089A114A62
X-Rspamd-Action: no action

On Mon, 09 Feb 2026 15:23:23 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.124 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v6.6:
    10 builds:	10 pass, 0 fail
    28 boots:	28 pass, 0 fail
    133 tests:	133 pass, 0 fail

Linux version:	6.6.124-rc1-gb4030a6c83e3
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
                tegra194-p3509-0000+p3668-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon


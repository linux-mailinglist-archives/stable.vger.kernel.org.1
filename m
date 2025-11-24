Return-Path: <stable+bounces-196659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BBC7F622
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72698345448
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EACE2586C2;
	Mon, 24 Nov 2025 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fvhZVUp5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FF248F7C;
	Mon, 24 Nov 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972862; cv=fail; b=eUh/YTpmk/6HQgUJ6BXxrLQmLz+bFLhYDVVCBsxkyV/Il/Mx+NZevO0bu5ZrL1PuwPfZDszAIaSFl/69ryv+HbiKwzlIpdqtwHJvVIV+5uxkZiEt/RAXO1GvzHBXBEOQt3ATBernMYkMRqg4qmlH1FXYbY83PWuyqm79Hv6f0zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972862; c=relaxed/simple;
	bh=y/4ouwQoMPcOyVqnaYPpJ9weG4/E9UT+aIjo6k8VI8o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SwBt1fe21IhD9pqI9n9yaKA9q+456njW2P64TVJxuzpFJ/P6j/IwPERmntf+v4trQO+923Vsb/8nsjyOWU5l3CuyJBhbrv25YtHwnLm3vDZybBFnuEmkIaHUAM1EvVQsG18tPIAdGwnDLG+/h+yNEZ3RWlQv2uwoIImB4MUL++w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fvhZVUp5; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO5Rg9I1808586;
	Mon, 24 Nov 2025 07:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=zsJOtEJGu
	xMe+sbEqi2JTMxzb1Rkq42r3D4bQX8RZfk=; b=fvhZVUp5+gAK3wHu6PH75csrt
	kQuB/DZBMHsr76JDuDF2oatIZj2QTCmBaaY2yYO2L7rqF0tosu2hz/Zn88iT5RmT
	6vmODdoxnNeMjBwDrZY8+K1OGbjwV5ez3fDYAPEYM54IQHADwVXNrbcM6oUP1X9l
	zWuUUd1lmS1gIGVGet9q2rp+2j+MErHjAGko17GohF3DKVfvdXzBC2+gDhiUFH23
	nL8WFhLuNgWd/H1CQSD0DO3MmW7RKcUbvmsh2NeSDDPy8contp8kltmG67pK55f8
	5o2iFjxS7b1SeYhu052sW4fu13Bd6rHZj0YhE/BGvLxqE5H+D9BD1VHoIezBA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455hncq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 07:58:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJzbVqDaLxBf+Wi4SvYNH+n8kg2FUSQEUV9jzMjsrM9wq5OG5yzdTx1H+4qzs8ewZS4DwYYMMDywd5uDgluTNWEEfJlgUcS1rKbx7rKeCIimXxXFkHPFQTv9ls6yfpv8M7DLW21aSrtIxEoA2c8p9NQqhUNf4jYbNP+MkLM9vFF6HeCYRbTpKDH/p83XVVrRL7DcEWoitG+tfPVkpU1oCUqZ4C9zQVPle1BMz5QbhXhi9LWCbwKYdc1uOIpHc1RmZG2ZL/j3FWf8UnUx6DW1kCNs8sa3m/u6aZKzqjrptEQJ42bwyhKYcAXhuKVuQ0f+rjH++M9lyca5rmkyBVM4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsJOtEJGuxMe+sbEqi2JTMxzb1Rkq42r3D4bQX8RZfk=;
 b=K3rPGAAl4A7d6HdbL/4zc3I4QPXW55sXBd53OMq1pZfMzOGfWpyFcJGM1VVG/nqk49I20w4XPlW/OYcSunUqfbXVjL1xgTA1uktf6dACJVpYUdu7sdkQEyv8kT4G9grYqbGA0Gy2Djvn5J9sTzCp71QSGzyE9zOp4EmlE62JSVUY/vXm4mgfWk1lHH5+rA3AL9Ud8xdETxuKtfNDXaT0nNWPBgGL2+cg2tR8h+ZPdTbJJJ9tPn6gT5Bb/x6pcBsalxLJfdSf3veFYc+HyVdi02PzREx7qoUaUYBCp6S3hIjCfPtElUhPMKG4faPZuaVyrTa5bgDchUgp08WgX4Qp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by SJ5PPF57F27BA08.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::82b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Mon, 24 Nov
 2025 07:58:21 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 07:58:21 +0000
From: yongxin.liu@windriver.com
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        david.e.box@linux.intel.com
Cc: ilpo.jarvinen@linux.intel.com, chao.qin@intel.com,
        yong.liang.choong@linux.intel.com, kuba@kernel.org,
        platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
Date: Mon, 24 Nov 2025 15:57:48 +0800
Message-ID: <20251124075748.3028295-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To SJ0PR11MB5072.namprd11.prod.outlook.com
 (2603:10b6:a03:2db::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5072:EE_|SJ5PPF57F27BA08:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c8da03-5046-4bde-495d-08de2b2f3c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZNZe8eD6U6G0ziYFe016vBdRfvJDX6X4KpEo7BzIrpzet4hciFBHMy+4PALP?=
 =?us-ascii?Q?gqD9u8vaoeEqkIHh3mv+49WQ+Jf/LQbHIlwN+zTKKESWwvgOHW68RM8cf9Hl?=
 =?us-ascii?Q?4oqm5qiGNcgvCXCBZ+khFUD0caagUiGhvpOnQ2EH/M2r+zDVdtcw0HclK34C?=
 =?us-ascii?Q?Y6XP05o7GKY2GAVikNxenEVHRn+yMVLNcPPUi4N8cTIDcvTfB1+t3IUms3Je?=
 =?us-ascii?Q?Ezq5LnzshzCYJ1ihjH5KrHagsoactEGBMzviBfWsLA9rZRovMu3tmCRl8pJz?=
 =?us-ascii?Q?4lu+vUZK8QhlCYPUmrLUY4m71BhpC8dlzuSBZyFgTWUDg8Nk53Q+nHiCOSsa?=
 =?us-ascii?Q?bemjwsYVJPItP7FcoTYc2Kzb/HP5RpVrJQZBQvqRtNJm5xt8fJjH4s5jehUf?=
 =?us-ascii?Q?xInRCsxNnniHDGNrMfdPkGHotLIBBFI8IE65ZHg2aBWrFuEk9L0PrX4kkwk3?=
 =?us-ascii?Q?KutGxdPulQg5KfYfmvlFRV6buOhYEyynIGHnC5Vr5iNz0ogi087Wl8Qw4rj1?=
 =?us-ascii?Q?YcoVjthGFaAL6TyiofaOOJ9EbDLUdpCpB7/h7BrK90MaN4UQJI2+j9+ns+kj?=
 =?us-ascii?Q?SeK2v2KAfsGA91pImKFpN1sJIJZDNMKcbK1Em+g3sAOXQo5mrP7fl1oH0+Uj?=
 =?us-ascii?Q?1WAZPI6zWEo1tJ8EAk3W5pI8FdYBHPFACNDmPxVs92JFBWU6/rYTaK/aEL8l?=
 =?us-ascii?Q?Nk57YrarNRyVeMOUvuxsStzs5jFAODplSC3YfkMjKPw0V/paMVWwKJyQ5b5J?=
 =?us-ascii?Q?pf9PczAN/s7tHXpE2C3DZ71DIx5lYQGbPQajRf5jGlMqbf762EKwnOBldaq7?=
 =?us-ascii?Q?IMMmczsB2zxE9TARZb/cKXiyRRadPEb2P9EcE8iqLd50XlWfWnqh4C9DaQet?=
 =?us-ascii?Q?ztcDg+YUwz4WPsBkhDfe+gpGVLlE4Sd1CMctIZcXQWVyAwnmEKQPhBptYV9K?=
 =?us-ascii?Q?1ez5enY3QCWT6yEsB/JHQ96wwvH86OcLlxMnEMXEUJUAJUCUcd3BAeu2PqrG?=
 =?us-ascii?Q?vKweMDcKORJHjrYBTzq0ftpoFHdjcWzTbWzTd//L2oHxccNDT1jtvrVHiGHG?=
 =?us-ascii?Q?N0YLaTFX6hrJshDBm7Y+TV0QG8DvNtV4hN6ZDS8TsWd15jZs4FC3vHLX8nh2?=
 =?us-ascii?Q?cEq76T+2+sZPTvbirsG+69kOGvR7H1O7RrgPo9683tWma0UOJ/kqQxvkFGiL?=
 =?us-ascii?Q?tzXVsxVVEQhWp+N4KtCqjdM2mJqlNqeqrSvLaj2iGujbDhpgi0Z403m+pFYu?=
 =?us-ascii?Q?txsyEcIp7r9qYO1VubvcfRrgXzpxhH9S1ZQGMvVOZ5WR7Q2YPoOxvI+RNxlW?=
 =?us-ascii?Q?dXof3Y+0EMW+EBMKSEVbXTCEJsaCBGf+pK0uIz9vc8k9fLAFYtpeTVo9EgrI?=
 =?us-ascii?Q?tqGdwv0n4uZ4akPbrhiP0ZDCorxha1dgoIC/zvHxHQDH6utrUAVNY0it54sm?=
 =?us-ascii?Q?nM0E6u8dR3/lx24sg9XEMc0oIAhA/2e/XzX2+hE87Jf0Yfl0y/pstQe4uzgr?=
 =?us-ascii?Q?l5+7qbVmww/m+jlnS3//RJVU7Nc5eiyKNzlz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4YJ5Y7Kl5+Q/rr+ErRMhfAlaOTQ1ChLvy4J3o+CRvdKBidQ9gH+W4o6hAik?=
 =?us-ascii?Q?xu8YRsTx8fRXdt3YUibMV4wZ35wlw8iB/U5oD9FeYgGD8SwL/lBfeCMa9CsZ?=
 =?us-ascii?Q?lequOMbHVW5N8Mct3rO1eQF6nhGIFptOeTW9MQ+Mps1aO0Z51t+9+xgg1cBM?=
 =?us-ascii?Q?aEEw2CMuIoPRy0DB4Sr7aSL+ib0Gp6EC0yUP5jqP+C0fGTDq7y+MiDc8PXhl?=
 =?us-ascii?Q?42K9vGtlazk80Um5+7mgbb/CmRQCOIjjHBhrJ8Jroq4IHsj4pIM3qaxfCsEC?=
 =?us-ascii?Q?tiuA0/nDrD6GUAFDCzDAwgtQ3a9i4O/Y4J4FQFGBNIYdJ73KQS6CbATNkY5y?=
 =?us-ascii?Q?t03b8GE7QeUcJdKh3TFR5lhaKLKWjN1xFgagl1MOM/ySkjiL0krl4gB0jXmB?=
 =?us-ascii?Q?2nWMyF5UQn2Yh6g4C0JeIcjVWHYLuqBI5f2zSkrOC4pu0cc/zD+A7sHlI4ph?=
 =?us-ascii?Q?Fc8xurPcqpW8XCpFFQQVq8qrSQEMRvWikF6g/tWOPBHmEG+USwb3Wi/PAOK+?=
 =?us-ascii?Q?nP+TFSJ/EQS8K9Jo1+UNWd6zJt7cHs8zgiVMiDK61qn2ade0kG5NylIW1bQz?=
 =?us-ascii?Q?GLMXWG07eV2LZYSzzqaYEQdGeRmTbmwiB3sg7ahWPQywr+VAxttcMTMrzYyf?=
 =?us-ascii?Q?1KHmcrBOjmxEW9tslaR9OgurwPNYRShdM+bbvX66i27iqYivsTQXlqwyjLa4?=
 =?us-ascii?Q?Bc/r6as1HobRV4NbEs7VkyYqOm9nLuts3kQOTeB6L2Lv4t4GY35c+rAxCT96?=
 =?us-ascii?Q?jqSNim+8FbB70GnKX06Jrl3BpejIKNrKvDToupzVX+teC908rxT4mvLP8ZB7?=
 =?us-ascii?Q?mMbebyRIK8TCKvleSD9ptmJFjhwf3eaPS2bxWaOAbLzEeZ1nUHrI2j8sF/r3?=
 =?us-ascii?Q?0vv+D1OykkGzITYH/trKGBi4bmvcqGoLBygd0+ENuVEfSg7TCisIf27uP4ob?=
 =?us-ascii?Q?QE90zjOH6ry6CamkGWbwJRBYG9BoObR/2hb3U9UgOOD4Ppj08UYkxUiI3Rzo?=
 =?us-ascii?Q?2jBm1DRgi7nLmsuyLVAStv+xxMAHUWhSS72eBd07plSkGSbnDPUneHH8igFU?=
 =?us-ascii?Q?aYuuNI8g85et8wIT0KhXmuFznAs6Ih+jNInZzSBO3u6uXI2ITm2QgkaRVFij?=
 =?us-ascii?Q?RKH9Zg4WhMpOBmlmt7bNfT+dwtn2t5I9JpwyGaVTzkCoYvKGvfYEiU5czIyI?=
 =?us-ascii?Q?9/M6i0FmCXZN/Y97Ar6jqs1C01VINIbrQfV2uz+L4Qcl/UFXFeBXmc8RukvF?=
 =?us-ascii?Q?T9W9gW7r5LoxZnXVGfqtlQ+BWaYNC32rnvOIGkqo5LOB72StEjcuI3jBI4vp?=
 =?us-ascii?Q?4zqzGh5EwsK4sxPCyn7TESzP3GrT5F3xS9FNh+Kfd2UyXuLMpvlNkQpUrE4U?=
 =?us-ascii?Q?OaZ2mOUcih9gPE1ib0srWSVnBUQWGpjbuLXHAo45bZCuXIFBKA/1bZQmTyLv?=
 =?us-ascii?Q?SH9iYe5zJIjggBWVsIv2Sh11NXsARLQAdMVJDMnIX3QzrAgqCsTxfaKsWTjV?=
 =?us-ascii?Q?+hONtYO2CK/lGeV1PSGVJPKjRa2sc7nYML3PcOPG7q81uzW4pQ3D4EKAmDfQ?=
 =?us-ascii?Q?9pQoTnVIs6UyOTtCJQZ7KrzsLXSc+rOAh7iZXcKGmsVyxgXD70zUsYMyuill?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c8da03-5046-4bde-495d-08de2b2f3c60
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 07:58:21.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qHFF574M8T/tqxO3bEjNe5spYOkhCcXxgynJwoNB/Px7nNF0QBaEHebAgjVpe0NNlK+ipP5Rpqbu65JcEIo8migNLemMYezMhCLh6JdbRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF57F27BA08
X-Proofpoint-ORIG-GUID: L29UYZdApCrd0_cMAy5DgKvdma1bMceP
X-Proofpoint-GUID: L29UYZdApCrd0_cMAy5DgKvdma1bMceP
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=6924101f cx=c_pps
 a=8mz6MTC2HIKUG4doMpATJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=-7MsO5uuUq9RY7GpknoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA2OSBTYWx0ZWRfX1VYTvAp43lcm
 yEEWf+8QGXgN+zBG9F4fJRIpavjtDamofxaJ4Cg2GkpmitevK0FwiD23aKxbevwKtQmDJDPnAuo
 eDAljDZ/dd1fPDmPVnPseZLMNVvYw/mjTcLBCsF5ESaA4iiPy/pX6vP56edj3gTBBccu5EmlTGJ
 WsrlyJL0/i169+vpe5OMhSFrGrHUHF1RtgzHBx51fp84Wy1Hx1LNxvVD92Vtn3cf38XjQK4qui2
 qDBXNLAD8Ef1IMP7i0nsm9ECSlfplA6nspGnZLDWi07f1uqXYLIfGcGz6+fMnz7MOvjCnIF0seU
 jnscspvvBXfm5XnvkWvnF97FB+73KCiNdihcpuALiNpzMZL2pEvxgqvFh7AE2Keq3ONxwuRO33u
 4wKhe2AHNd7MOk3L9p0BKJULrWMizw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240069

From: Yongxin Liu <yongxin.liu@windriver.com>

The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
for the ACPI evaluation result but never frees it, causing a 192-byte
memory leak on each call.

This leak is triggered during network interface initialization when the
stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().

  unreferenced object 0xffff96a848d6ea80 (size 192):
    comm "dhcpcd", pid 541, jiffies 4294684345
    hex dump (first 32 bytes):
      04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
      00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    backtrace (crc b1564374):
      kmemleak_alloc+0x2d/0x40
      __kmalloc_noprof+0x2fa/0x730
      acpi_ut_initialize_buffer+0x83/0xc0
      acpi_evaluate_object+0x29a/0x2f0
      intel_pmc_ipc+0xfd/0x170
      intel_mac_finish+0x168/0x230
      stmmac_mac_finish+0x3d/0x50
      phylink_major_config+0x22b/0x5b0
      phylink_mac_initial_config.constprop.0+0xf1/0x1b0
      phylink_start+0x8e/0x210
      __stmmac_open+0x12c/0x2b0
      stmmac_open+0x23c/0x380
      __dev_open+0x11d/0x2c0
      __dev_change_flags+0x1d2/0x250
      netif_change_flags+0x2b/0x70
      dev_change_flags+0x40/0xb0

Add kfree() to properly release the allocated buffer.

Cc: stable@vger.kernel.org
Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 1d34435b7001..2fd5e684ce26 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -89,6 +89,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 		return -EINVAL;
 	}
 
+	kfree (obj);
 	return 0;
 #else
 	return -ENODEV;
-- 
2.46.2



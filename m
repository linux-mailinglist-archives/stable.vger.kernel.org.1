Return-Path: <stable+bounces-200498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 502B1CB1771
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 01:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26F3D3030DB8
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C05661;
	Wed, 10 Dec 2025 00:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Xae9aNtO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0A10F2;
	Wed, 10 Dec 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765325129; cv=fail; b=obFihiktJcEEgxbWl6zuIl4zHg+KXynNkMzljmYB6lJiaGxQ2DX3NhX4DU3+Eh/JNepUOZ7uh0Dr0K2KFrSWG5CLXmBA6L+00F8SvNzbbD5Olp6jPFXfanTLX3Rlbohf4rF3WLC8/ep6nSI1PhuDxGdSfy6aHnA3SkBIXizPdbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765325129; c=relaxed/simple;
	bh=QPEFfcF1+O9d00e6TA8msiTwwIKyTbhVjwRhfUkkDtw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R1eLslfRrQWj7l29VM225SNJUMcwgxg2rOIwUUEcThHFAYxavDv1EwISMiE4tbAMA7O+UFRlgtwz4rzZlsjhk6Qu3KB6pgHDAVHzK8+EtxqNJ9XDqHqrP3a6ha2R/mF/qOEgJYT0AzND5lFKffv9h7/lsRt5RxrDyB3PaN3cW4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Xae9aNtO; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9Ne5Lf2223782;
	Wed, 10 Dec 2025 00:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=fHRyosIQy
	llaVoGC/Sfc0nFOJ4mzYr145DUly99Qt2M=; b=Xae9aNtOjOUFrcd9MJxwXIIhC
	hdKSMmblOv8fxVnV+AQTD7hGEf400Jkwqotee5ztDr1OgKvrVGgr3o1yyn83jndE
	IjhD8W6TAvWCh1wonQe3I6HZTIsKXQZgtZwdghbpho0MZ6ZsYLIM282JLqCiHDs1
	vshqcMKmhDYzhc2OV92eHiLShwJo8iN04pRkf8j8wgQssYbUp8sfFA+/DKDIi0ce
	iRWRM0wyio6FSJSgB+bfy8VGgabojUbKatNBnqg/TUI9S/vreSvmXa361+H9bstA
	nuxJv5CG2CX6SfVnmHzAL0hlTobzjH7MKhkJs2K4/yH/MUB73NVKC9KFL3A1w==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4avbf6uvfu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 00:05:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y296dXR5QiJkH67uzEOTIXpX8uKSrTfIYw2kEkx+tZa18398DwTjtXVxszm0ZhS98+ySRqnqWFDG+6w3saVErQp5a0YlSGB72dTf9riJAcybGsdmgD/HtyexeWtyzLzfXBmcw/IrTkDZ3LfvFeTTrqU1pEV2Rrcs4kWblD9zkrJzPI6wgAfmVPJgTibC9Nh60MF/i+kssJgw0zVOIzsHjatrpa+uZCLmgvsIMpDkXLYdmIloh3ww+Qj0uFSPeM7ke3sqtqHwybUxSzbhQuPUgqf6OYmTb7kAdTvyUjeeN27XZDIitxjBhkX/mtztepWjunJUXhxErZIafPAAGS563g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHRyosIQyllaVoGC/Sfc0nFOJ4mzYr145DUly99Qt2M=;
 b=Syu/oGk/Uxs/yLa1b29QS7ab7de2lXL/yjh6eB/7wJ32z0IzSqZt8b8Bbm30bMfaO9SrtqtU76bVhFPUAYS4BsKJCcrbC5As/BuoopQaGQmZT2fLG0QJOqTIfYagb3m80gV3tKmSE7UTHSQcWYIFifhtr4I06YNnIPhA5eaNq7O0S9pcp9NZDt9MpRVSrbkNzDV3pVIIibeSfx/X7tapm3SOrlMzS5WNSx2J9MyX5y7gQFINvaeqxhYtXZJ4uXy2LGlFVTYSSrV6PRHmhHKmpQz29hnX+wo5HEV94lTvDD+itwwXfkCylFogP3iVRzf4uDSrjJ0WSBhQ4sDpiwDG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 00:04:55 +0000
Received: from SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8]) by SJ0PR11MB5072.namprd11.prod.outlook.com
 ([fe80::a14a:e00c:58fc:e4f8%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 00:04:55 +0000
From: yongxin.liu@windriver.com
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, vigbalas@amd.com,
        stable@vger.kernel.org
Subject: [PATCH v2] x86/elf: Fix core dump truncation on CPUs with no extended xfeatures
Date: Wed, 10 Dec 2025 08:02:20 +0800
Message-ID: <20251210000219.4094353-2-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5072:EE_|PH7PR11MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: b2071743-5b85-4915-884e-08de377fbf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jvD7+2ih/SFxRlr8IvDNKpGtCFRdpR954fQb3nBCki/IXrIlTCl9CyBYhPtm?=
 =?us-ascii?Q?BeJiGnc9cz5E3NYDcviJV8eNRTLrxQvoBXRfJKsxvvC6MGYVnTxIwyiiL0Jk?=
 =?us-ascii?Q?NliF2LfEFgz/zkKvrLFNA9PDNybHGL+NyTncXHOZsruKRuaz3AfWhku8rJXP?=
 =?us-ascii?Q?TBfI5P+bPHVnUnFHqRE6BVdS8cxs+g/Q5FXiE8m7OzkJa2m/tnsNDkS83USC?=
 =?us-ascii?Q?4euHotoCVOdYFxO5k/uRmKBxBMv+tcbb3qJU+4Psa4+jaUEQ0VmMSLpefzFy?=
 =?us-ascii?Q?QOufsBLFnTbaWUqqio2vKSuRkraJHXPegYePv57veq9E6vV+WEJCcfURbHyU?=
 =?us-ascii?Q?2GPQHBEI168bsKbklNnt7RsRPjaRJ6+tjCzs0PE8kNOXivCYf3b7K0e6pAC6?=
 =?us-ascii?Q?arE/jncLVkNvqhE6jLEkXDlphJHLgfgKK3YCZohmk9r38Jswqvw4TCpZeSSQ?=
 =?us-ascii?Q?CZJBZT2Q0UHzo8Ts1mRR2qCUVazylfC+hefkI06Et8SIRSMZE+XqUdPx7QzM?=
 =?us-ascii?Q?/yyt8ENFwdNagLZnNeIWp3tROUncf/w8G7+Pblled9B3km8cJg5PIwc5luEO?=
 =?us-ascii?Q?ganKhGs5G9e9WY9XmyKZDWWCMBCxd2Fux3hiCLTGMyHmMzdw2mGO7owxaQil?=
 =?us-ascii?Q?SxTGPX5CRdr5+nVvHeCvnYa+hIPLzqd1WoZ/sG7MERMCxDdDpBvec38K3Nmy?=
 =?us-ascii?Q?WkzBmFHBuhmI/Kl/7VhCfT5g1rO/OM19FasEkaX1Jmlm1Klw71P6lSkqaxDL?=
 =?us-ascii?Q?0VNFI6f1MofOPctxV6FyjZcnRrvXARHsAdw6LK9Husp4AkwTaqV2agocsqhx?=
 =?us-ascii?Q?4S+34sAfNGdZmM9bca64PtTyBHkq63uErzWBMikXKCSlbt+2nHNzHAdB6eZ8?=
 =?us-ascii?Q?73/ctrouXjR/CubUaca8esPLrDjfdusAb8qxBojbJFyTkbUV3+SiTSKNla5A?=
 =?us-ascii?Q?FikNB8QTKb+Y8KB0PNrpL61sJFsQevPMqbBxonZ+uO2VePPonq5DI9hWBqWd?=
 =?us-ascii?Q?RFMzcCfUugmR7ww6/fUFaAbaCWOlP39t+IK3u4C9PTDQFoNzM1V4ndDemtRw?=
 =?us-ascii?Q?sMLTqavYMbN1EZmuU+KWAYydkyCGaidu8zFXfJmFdPXj8HmsOGXuQfP5ZDtz?=
 =?us-ascii?Q?uW+P0EgrBvyQotZWlvZysuWLXfUIynkcUT/5niGF5jHIZK0i+EpqO7YD13IB?=
 =?us-ascii?Q?EKtamHD3vl3FAMuIAFRvx45ug+1sRE7cYnJflSHWCVsh2XrDb9arR8DonLWH?=
 =?us-ascii?Q?d+zcEp5a4BXcsvzs3gLgPvnvkQpVfLtg8K7Bgq9RyBTHvPp3Uy4ckQrtTQzZ?=
 =?us-ascii?Q?Z8JsojiGJJSYqjxN7vUaMJCxoNTohQk2uRz82SVeMo4pjiw9SvrY3bHUhNgd?=
 =?us-ascii?Q?D8WYrFGujwuqWJ0WcQTfKmZv7+rsRkr0p2NtedBksIx8yqi5sfI3pp0l69/n?=
 =?us-ascii?Q?D1mkn0JWot86Rut4E416ROP7OJxTBIRCkje7N/yNhqMki4dVshj8qhNpSr6w?=
 =?us-ascii?Q?9jadT6WqWVlgQAYGz3bZ9sOo8iVyYGTHFAB4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5072.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iazcz1k9g5vV/y1zEGc4UTKLODCUgYQO6rLOkSqPWA/fiRbg9czSHf0PKcOL?=
 =?us-ascii?Q?ksL7z6YH13OiKhBrUXYy6FexWs388FbivOogw2cUEsBYeqwMsocfp5Hxh2w+?=
 =?us-ascii?Q?tqSBrFGHV9QOnsShgA+QUMDznWAL5TqD1RTZdb2pbX8mWJ7nrDKXvvoCeKQB?=
 =?us-ascii?Q?NwPj3kaWMDmW6U6AXL/+OQo1U5vjzil4r4eK+rsswevwZ8XNYF9VnAVqUzea?=
 =?us-ascii?Q?5bNRJjBRcIhiU/qGs87MjxTiTf+eWKY6Yl8EYrKYM2r8AeDzTMKNZlZ3a2Aj?=
 =?us-ascii?Q?NGqjVTFHQFPMA3m6p5NIBx1OiCKaJL0Mi9lGHVScgLhwbOMNiKvpEo7+I9hf?=
 =?us-ascii?Q?Phs6PhoJ1Xru5b50cGuD8947xTUi7+xl5fhQPpiaBmik1VoSE8fXjCGSF7F7?=
 =?us-ascii?Q?xaJVsBIFZco7lonupLh+X7OBJ7akJv3rzPx0GYOnW/NB/MumSUriZEDzDzxN?=
 =?us-ascii?Q?kH/4SQX4BFUpAcqqg9iRDpRmwvJES0a6iW6OzjY9yE3EpX2xSJRG0xlMhRu3?=
 =?us-ascii?Q?Seuf0cwOYhcA96EgMfX4wEmMY3XOxV5R+NHPTnqFktZpkBvAuHPciw14LfTP?=
 =?us-ascii?Q?5ubCOIn3ErinG1WYQs4j0CJrUt1sUR+vsCMBlsIztbNkjFp1ZbAusmyYfLcI?=
 =?us-ascii?Q?af5DBufbNFhCcuvEk+eQdOA43kA9p7YxHDH2sodhTy5Y4TKNIJBg57G7y6r8?=
 =?us-ascii?Q?nCjTc9KQSMb5R0b22d5yytX9aQ5kCL0UsoZaOwGvnaQMJVpBmpe7lRLOXqRm?=
 =?us-ascii?Q?y+pVk3ARVy0am/LGcA1m9Y7Oc3Mp06MxsXBkJHcAKLdF6TMf6OeL5Mb0CzV6?=
 =?us-ascii?Q?fESRRWqrnDgUh0KOZw93ylGLNYsItPXe8bjST64Bb/BI3mUtCYVjswdVHbAq?=
 =?us-ascii?Q?aiB4FP4SlCcbph2R9/o5N7Rpr8yswB4FJXm+ZN7GFiHeCKR8zRY7dZ6oaOBH?=
 =?us-ascii?Q?IRr9aInwAOCam6vc3a5c2SWNj8nPwTJJFadlmfY8Xy3MK5iuwr1+QnbVJtu4?=
 =?us-ascii?Q?wGFGsb601F7gohfkB/qewEuHlR+Ym7PMLqEsRfHul4vxX+tZCtV1yGyhfFNY?=
 =?us-ascii?Q?sKztYd0IH5RVpkZGHT3gDgT9OUxan0ypg3qcjJhgyBKQ/EaXliO0W6qQYQla?=
 =?us-ascii?Q?MejQC8XwxTy6ep9qS4IC75lKeELgY53WYdV8DMfRukVUm7X6b++3wZN9t4L4?=
 =?us-ascii?Q?voUbfa3guutwji0AL77jJ73CPQNpk4Hb0nX+zV4bqknTTLWbTA9QPMttjNsL?=
 =?us-ascii?Q?dfmkA02WtgqyKN2H1D9whmcTP4/ZjrPqgH2FmqHMzdDoOyWVBH6EdSM0+riJ?=
 =?us-ascii?Q?4NhmAU0HC5MoZLkK7zgniRjdLrUmK20+7XD3h9qoOKJa+w3GbgnsjfplebkU?=
 =?us-ascii?Q?16oTJqnccbiT96wmdbw1WPKyuhP0I0Kghcqk1LQpfsHpPgOgfCW6rz8IZVPl?=
 =?us-ascii?Q?NITYej2sb8jy+Cz9Usw/pcHS2Wp2XcsfPY8ANJDJR81JgJtBKY11j3afju/w?=
 =?us-ascii?Q?CLFne75XqCZkwGX4ErAjL822cNs9EUU5TuP0U1N7E+Kt4jzvJdfVdEMZgeYN?=
 =?us-ascii?Q?tEyhoV6/DKR6fbZdPY5murNOn7Ks0JM4ScHXMlCsSkJkzdKGom1z7nqsWDz3?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2071743-5b85-4915-884e-08de377fbf9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5072.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 00:04:55.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RE52yettlAS/x1gOxMZSV74hNUT4NU/lczFkFOlljtnCWJ3lThVc215eYgi3G+cnfPnl68/9eqiHLANOETCGmfwgbbLOiJ9sYgkqq+28wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-Proofpoint-GUID: RFjTEiv3IvrFwikRNm0Zcq_jrfeFIOOE
X-Proofpoint-ORIG-GUID: RFjTEiv3IvrFwikRNm0Zcq_jrfeFIOOE
X-Authority-Analysis: v=2.4 cv=Io4Tsb/g c=1 sm=1 tr=0 ts=6938b934 cx=c_pps
 a=mniIB+Hk/8HPdz+5sH7poA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=dRNmwHmv9jWgsmOPPGEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDE5MCBTYWx0ZWRfX5XQAO1iTktan
 PjtLehdJUoArbqLfAYykzT/x+p08wkK+bBN40hVjJP3nxxTCQ3xVEqtLg8ggEdXR1wMtNhzpD6x
 i9nwQj0Qdca1m9o0zxAAzsrBBl2TPQIb3wWuK3oZekAj32ofgLDTsOgOPTDh7+qgGd3OjX+EXWc
 zzksjIKdA5lHM0tSKsmPXSVUJQDh5mN3/RIALRnte/ll9f4tZ7cXwCehPhChJHlTjH0psr1Aaig
 VHJaC6rpMD9+E7+cj5VlomtyU9YaXKtqpd5KLpKez/UkEAsHeXknssOHg6UDuSFJIhQJNUmE0kO
 cx3Z7kXePD3oHgGlafM7owgNY+YRd30CAlqNo4BmMaC/n9j/wy5ugZEbOtRTp1dqpZCjlS6hpaz
 Tue4YQV0pwSdBxLXUgRg5CTcbUCQ+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090190

From: Yongxin Liu <yongxin.liu@windriver.com>

Zero can be a valid value of num_records. For example, on Intel Atom x6425RE,
only x87 and SSE are supported (features 0, 1), and fpu_user_cfg.max_features
is 3. The for_each_extended_xfeature() loop only iterates feature 2, which is
not enabled, so num_records = 0. This is valid and should not cause core dump
failure.

The issue is that dump_xsave_layout_desc() returns 0 for both genuine errors
(dump_emit() failure) and valid cases (no extended features). Use negative
return values for errors and only abort on genuine failures.

Cc: stable@vger.kernel.org
Fixes: ba386777a30b ("x86/elf: Add a new FPU buffer layout info to x86 core files")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
V2: Keep error checking but use negative value for genuine error
V1: Remove error checking entirely
---
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 48113c5193aa..76153dfb58c9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1946,7 +1946,7 @@ static int dump_xsave_layout_desc(struct coredump_params *cprm)
 		};
 
 		if (!dump_emit(cprm, &xc, sizeof(xc)))
-			return 0;
+			return -1;
 
 		num_records++;
 	}
@@ -1984,7 +1984,7 @@ int elf_coredump_extra_notes_write(struct coredump_params *cprm)
 		return 1;
 
 	num_records = dump_xsave_layout_desc(cprm);
-	if (!num_records)
+	if (num_records < 0)
 		return 1;
 
 	/* Total size should be equal to the number of records */
-- 
2.46.2



Return-Path: <stable+bounces-132042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F4A83963
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3891B81986
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 06:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2422046A8;
	Thu, 10 Apr 2025 06:32:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53871D5AC2
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266721; cv=fail; b=OR6Wcc8oCjA/3HYfoH9tDMdF3d+NcF0oNu6B0okaEX88I7Og4onTWiCayH6m2tPeL+0lGGlnJ/tEEZxMhvlU6AhU82moGcRplYuiT8vrCSKFC5l2ZOtO36S9fEv8whN/GzEh/s/HpSaklr+z9R2/a8390UeQ31gaEiwX0WlF67M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266721; c=relaxed/simple;
	bh=6Ye0gzsZ9DdtAQ8wM+qvBbPF5I+KPG2nOC+c36aZSyg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pS4r2LJ8gi/C+ruj4Tg+xxDcccjqKHE63PRjfucJEHqdfHQkDIwl5zpfMmSRU5dMq3QPzAiYiI1+C12ha3D6mXGYNwr2QR7xiWmEEVxJKBjTnOPRKbxSDLACeSpW5QivPyrSrOYZfttoAxTJsu/gUuTrYZRah69nmSCnvTmTcDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A4u8sn019481;
	Wed, 9 Apr 2025 23:31:49 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt4e892-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 23:31:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlBMRARYajXFv0+PQenuGjUcOvOoHA3wDL/Zw9HrpEcj2uiP7gXafKlvlINWRHNGu0I0m1+5RocvFbwCk6GIFbvAeTCpG+dG2NJaHYGYjJOIOGBBlgaEIoQRPW/zrfuHBpaTnK/wjIQg50CuFCsxu/nuQWFrBma8AmA4sVyUUZ0KoOxN+keJBU9/qZbQHnZJfl41V0l0yfdho9Zu3JxU8RbAaevQwtUpkFAyHyQpmed2mSpoFdbAYvu24RPBuIuu9KlhSnRrLD3aLpY9gC2YtTlqArSq1FlXoOL33RBJOpMO56A0qooswS67lO92Xu9d7SkQlgvbg2oHwqaFdjmNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IfiDqoQEb3ruTIaYYAa3P8Byyr7VeREHS2ivc7Mo9E=;
 b=RzgHXBsFgjcHiK/2udyfiyzOURBgY3jlFFN6GrWbubuSeDcbspMyO8Eyk/BRrHV+6iV2rRZTGJDD6CLioXQAuy6cMZdV3+/raoT4EKnvH12EPyHD9zzOiCfYAjY7rGp6EmDaAYZMAmoBjW57J82keBvNNDXkFZ5sjSiMvQgdj01ae9HkJioipwDDZV4LzK4IEWgHQXg639Ch8UrMVcpwWju4i6mdqygz9EJ5yZfelDAVQcxKg6JP8QsuZMMigsg7VOEkMmdG0nK5erreDZGee9+k/Xhdm9bQQLtT75jJLs2s1ONUXDr5QwPJ41VcBo5pkrBFWhA0fQoYZlBUhcOD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6485.namprd11.prod.outlook.com (2603:10b6:930:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 06:31:45 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 06:31:45 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: alexander.deucher@amd.com, bin.lan.cn@windriver.com,
        Rodrigo.Siqueira@amd.com, hamza.mahfooz@amd.com, roman.li@amd.com,
        chiahsuan.chung@amd.com, harry.wentland@amd.com,
        aurabindo.pillai@amd.com, alex.hung@amd.com,
        srinivasan.shanmugam@amd.com
Subject: [PATCH 5.15.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 10 Apr 2025 14:31:25 +0800
Message-Id: <20250410063125.3055855-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ec446b-38c2-4c3c-cc22-08dd77f95d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vC7WW0n/4+J5aV4BihBIofWXHwJR9S9Zse4486m0/EJmoPknfiDru7i7fVoP?=
 =?us-ascii?Q?h5l/274UkzKbJryRgNRkDluiAIGGqSkMwItxU5ImhryBw2bscGtqtVW4pdu3?=
 =?us-ascii?Q?2VUFkFAHBWSYENKlkPEh5w39tDs1BKciRJcAoKZSe3gvmntLRRc+xWhKDZWi?=
 =?us-ascii?Q?q/sL32gCdIjZcw0qdrtBe8Fk44fZKt7vE/FslC7mIiUc8ll9ME50iGf8uJUX?=
 =?us-ascii?Q?r917OutW2FlXzF/uJ/yRglNUk80MsLINFTo3iiielh6eLn83fsW8BzIFwCM6?=
 =?us-ascii?Q?td9iVWR8RTrkgV5oNTAKzENUL70uBp3nd+i2nb2pJzfoVdv6Sv3Uc74jPUrK?=
 =?us-ascii?Q?MqgUa5lLnfqqzBElu/LDXSDn+A+W76VsU49mBLlvvfiL8GkmRA6hamMOrJM/?=
 =?us-ascii?Q?y+AqhrqGXFmsDHl2Lgdfm0HYVE1LcSAg56ObqBKoOXT39h3KErt3DIi9h41W?=
 =?us-ascii?Q?qJC+kwdXoxURHf96oZSD5nXRgix1+I6/W+O461nV+bHT7zp6kYD3X6Y9+z1m?=
 =?us-ascii?Q?O1yH4xN/vmD+xql6id0ZiE7s2RtEqvqEC9MjbFuObkByG5Bhc83RpBOYEB8T?=
 =?us-ascii?Q?L7+klF9MsDnjTBdrIxWk9+Wrda247kekvvJy/z2yWAc9sPoulTQYJwNbMGa7?=
 =?us-ascii?Q?nBcXQ5HRXk+4Rkit8lVNTTePt5xqeRTpXhjAbYqlrx/QOj5I98mm1EHynL1a?=
 =?us-ascii?Q?Le1wKGTsyyEii7oIbz7b71vqSZgnFs45s4DNH5axxotj3natYJCuO/CJ2E4x?=
 =?us-ascii?Q?SCHXo6WdK0oz+Oa3tsoY5kS9HXcNqE9DFub1zaB6tIJRYSBh4uTT/pY3qwHX?=
 =?us-ascii?Q?z9ow00XAe+l+JnASE/H1FgMpzKp/hxOc+D6NlK8yxUJ43EewLPjlHmrFBSof?=
 =?us-ascii?Q?k7m7aM/Vn/bRCNazX/2JFDp+n0wgJaK0CzQRaFIkz/q9E87/J0QsskK0MSHK?=
 =?us-ascii?Q?+Xdxp7fqwFfNTJArDoQyn0sDbsFukhZkpCrtC70xXNcYzcr+NYRKan+m3ugY?=
 =?us-ascii?Q?BUkFhePWuYeYO7Jv8okJ95/MMMOeIKtHzO+/WtTXjCZJtFEOm3D/82J06ny5?=
 =?us-ascii?Q?NAOtr8A3Jj9fZlnmDaUMi4dvwQ1tbAZkWIgpbqCurKeJb0RgBz39sDXtGCTS?=
 =?us-ascii?Q?bZ9olVhNzWaN7q+KBvhXXy+1uCDF5HStHodBjeSVCiZW2xDIrORpbQ7gSNek?=
 =?us-ascii?Q?9hHgi021CKA74PZimQIx6qzhuCEZc6YMdD6LXTA6cc1GEM1ajnY5XnfYJ3V0?=
 =?us-ascii?Q?crEHfp2fF5TnkScKXV+Yu5+26Uxa2CoFtSuf5foQ0Oiopg1TbR4ytUy8qjBl?=
 =?us-ascii?Q?Xm5XGaDjPmK/RbpScyqLuxdfBI7Nw4i1ku7uXDKztFCykOmgaPzdNWW1EbMC?=
 =?us-ascii?Q?KrhP61GtXTWcWQXletoDmoICrQBulBCtkYtddD9dUQdHlzoa4nvCxpMpA5AX?=
 =?us-ascii?Q?5qlAxEnwPtWa5isPAKDZOGqBAlqKD+COL1FgjBOQ3fjTBTVmCm0BVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjUU54Iwm5lkZN2MZBR+7XYM0gVHjYNvL0SUnQ5DjzZj/ge587u/rFcSfhrf?=
 =?us-ascii?Q?NBFQERvXGyO5nVUAI0KAKdCGEgY55dsFMeICF74l+NUxYeTyvz4jH2K+9SfY?=
 =?us-ascii?Q?wAnEVCoGa6m4uc4EW8ZdaTYazueLQA8EepTFERknMStZbTx0+1jaoklJ6ln+?=
 =?us-ascii?Q?vC0KjYCDYdQIXkXO4U+C3eOqKWMz73sUbO7GxikhiJBr29/ML+g72AvHYZyi?=
 =?us-ascii?Q?DZB9NeKkI7QtSMQgBeroZhfRUkL+DlDEc73+0CMh9wFkWQDXFbfecimg0v9g?=
 =?us-ascii?Q?5bfS3po1MdXVkSKGcZfcH83L2eu1BNI6ykv1Yb8QlwYcsu2txYCi/j6gn/be?=
 =?us-ascii?Q?aKg4fo/8nxUlm75iSfcNmhQ1ktEtYUnAo3amZC54ttNkBzwQ2t3RUW8UfTki?=
 =?us-ascii?Q?TWmHI7Pgne7r7r52nHXXkIX+IhK9Yd6aLZ71DOOVMNrVL1mUyA6RqckpZwdd?=
 =?us-ascii?Q?pbMqITVBWmkO4Q7oIvs126+SsnxHTdWp40B6/lgSTmK67xak83V4qCa9EF+j?=
 =?us-ascii?Q?YaJlgD1yg8J2UjHq/WFU+hhrlPuIU0No1cmLp50cnS5MPX6O8KOoqoEemhnl?=
 =?us-ascii?Q?KyxmD43aQU2XwYMLtD4+82Xzz9F2USj0Qy49x8YFTwDWUsAS6bg6xw/vVtDe?=
 =?us-ascii?Q?rYPt8eJifahvHPr1QiGxYk+UylSH5A6S10bykGSzJLPuNlaDTyU7UupvGga1?=
 =?us-ascii?Q?TyWzQL8KprI7eiop2IduwoYs4CXM8BJxx1imibCdQGbDpIuRsvO/XOC8YG0P?=
 =?us-ascii?Q?y4nRPUKpvg4LFoRIb9NxRZlrW4/reIvSyGAnSbace3QYiErjkh0W7Fwpinb5?=
 =?us-ascii?Q?w+0zODAIRTdgU0DSrZcYaOD9bBtJpjn+YLD79MW5umXjW7YtY7yB1kNxM9en?=
 =?us-ascii?Q?wWOlaq8HmlTBkqWDXtc42vUnvC5hxS8rfZv4UlmBbuuLN2puw5IhQQlpF9bz?=
 =?us-ascii?Q?1BXet6hMaXk5PWRdWmJLe/BsuPFLsHm6AJhtOYIUKxM0WCrs+8OjbdZre2nf?=
 =?us-ascii?Q?fxNdRb5R8phTM3r9JIetE9UCOCIlM+ARRD2MuMSPoQMGv5piu1zFs1iYe4uC?=
 =?us-ascii?Q?ln0rKxvr65BrluLtvgcyqE3eU535T+G18ZojWxDLtYhmsiZJUHPnbx3zCS10?=
 =?us-ascii?Q?uJWElH+Z2UhU2CyI7pDCYrXHXWFI2RB9ynjfvM2XMc1gS95HbOTYQuaqYj7v?=
 =?us-ascii?Q?WewEGOYsqvEhVFJnEi+JQFcZ1DKpqMRO2yxA8FbW8gpXKWP11nrssY8IgDgD?=
 =?us-ascii?Q?5rFyk/VYyXHgzJ8+pJ/2u2JxyYOa1oYWLVQnmXPtYxRKi1q/OmeOFbcXYPH1?=
 =?us-ascii?Q?uDpShN8TcjViRHP9Le9Xopq90mr0xo+OxbKgBIjV1Yv0AhYFQGkkMjFMHX3W?=
 =?us-ascii?Q?oX+yHI4EHb7i5G1c3pq9Wkf/F9YwFMdWVqNjTNLlrPCCR7xkFJT1S80Z5AoA?=
 =?us-ascii?Q?07XnptwbRD/QavaL5B70stuZfncrTrebgPMxVZWZX8JV5kxN0UxWkpBP3g61?=
 =?us-ascii?Q?FFsq/hd63O2zFJ5ge55gJRNA2ahvxhtvl/D+UGMk7oW0Ow7dNdeEBxi/hdas?=
 =?us-ascii?Q?QL56hhzhrJ2hTF8wRuNc/dhfE7MGNR0ThrDtPFZfLRmodQmDSP7CNlwW7WFF?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ec446b-38c2-4c3c-cc22-08dd77f95d12
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:31:45.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tmYRlyHbI1VJUy+Tay7OeBwxdRKSr7+8SCRPF0Xfk8N53G5fCwxfhW+fnX0Bd6VSBii+fpFz5MX4iH0A7cfXWZT/NB+GKTLQNBSOFuUWQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6485
X-Proofpoint-ORIG-GUID: KYG5mBeRipENHmf-OByO_LKyUUiDUgm3
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f765d4 cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=zd2uoN0lAAAA:8 a=t7CeM3EgAAAA:8 a=EfeH0R799gOdCVKhDY0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: KYG5mBeRipENHmf-OByO_LKyUUiDUgm3
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504100047

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 63de35a8fcfca59ae8750d469a7eb220c7557baf ]

An issue was identified in the dcn21_link_encoder_create function where
an out-of-bounds access could occur when the hpd_source index was used
to reference the link_enc_hpd_regs array. This array has a fixed size
and the index was not being checked against the array's bounds before
accessing it.

This fix adds a conditional check to ensure that the hpd_source index is
within the valid range of the link_enc_hpd_regs array. If the index is
out of bounds, the function now returns NULL to prevent undefined
behavior.

References:

[   65.920507] ------------[ cut here ]------------
[   65.920510] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn21/dcn21_resource.c:1312:29
[   65.920519] index 7 is out of range for type 'dcn10_link_enc_hpd_registers [5]'
[   65.920523] CPU: 3 PID: 1178 Comm: modprobe Tainted: G           OE      6.8.0-cleanershaderfeatureresetasdntipmi200nv2132 #13
[   65.920525] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS WMJ0429N_Weekly_20_04_2 04/29/2020
[   65.920527] Call Trace:
[   65.920529]  <TASK>
[   65.920532]  dump_stack_lvl+0x48/0x70
[   65.920541]  dump_stack+0x10/0x20
[   65.920543]  __ubsan_handle_out_of_bounds+0xa2/0xe0
[   65.920549]  dcn21_link_encoder_create+0xd9/0x140 [amdgpu]
[   65.921009]  link_create+0x6d3/0xed0 [amdgpu]
[   65.921355]  create_links+0x18a/0x4e0 [amdgpu]
[   65.921679]  dc_create+0x360/0x720 [amdgpu]
[   65.921999]  ? dmi_matches+0xa0/0x220
[   65.922004]  amdgpu_dm_init+0x2b6/0x2c90 [amdgpu]
[   65.922342]  ? console_unlock+0x77/0x120
[   65.922348]  ? dev_printk_emit+0x86/0xb0
[   65.922354]  dm_hw_init+0x15/0x40 [amdgpu]
[   65.922686]  amdgpu_device_init+0x26a8/0x33a0 [amdgpu]
[   65.922921]  amdgpu_driver_load_kms+0x1b/0xa0 [amdgpu]
[   65.923087]  amdgpu_pci_probe+0x1b7/0x630 [amdgpu]
[   65.923087]  local_pci_probe+0x4b/0xb0
[   65.923087]  pci_device_probe+0xc8/0x280
[   65.923087]  really_probe+0x187/0x300
[   65.923087]  __driver_probe_device+0x85/0x130
[   65.923087]  driver_probe_device+0x24/0x110
[   65.923087]  __driver_attach+0xac/0x1d0
[   65.923087]  ? __pfx___driver_attach+0x10/0x10
[   65.923087]  bus_for_each_dev+0x7d/0xd0
[   65.923087]  driver_attach+0x1e/0x30
[   65.923087]  bus_add_driver+0xf2/0x200
[   65.923087]  driver_register+0x64/0x130
[   65.923087]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[   65.923087]  __pci_register_driver+0x61/0x70
[   65.923087]  amdgpu_init+0x7d/0xff0 [amdgpu]
[   65.923087]  do_one_initcall+0x49/0x310
[   65.923087]  ? kmalloc_trace+0x136/0x360
[   65.923087]  do_init_module+0x6a/0x270
[   65.923087]  load_module+0x1fce/0x23a0
[   65.923087]  init_module_from_file+0x9c/0xe0
[   65.923087]  ? init_module_from_file+0x9c/0xe0
[   65.923087]  idempotent_init_module+0x179/0x230
[   65.923087]  __x64_sys_finit_module+0x5d/0xa0
[   65.923087]  do_syscall_64+0x76/0x120
[   65.923087]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[   65.923087] RIP: 0033:0x7f2d80f1e88d
[   65.923087] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 b5 0f 00 f7 d8 64 89 01 48
[   65.923087] RSP: 002b:00007ffc7bc1aa78 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   65.923087] RAX: ffffffffffffffda RBX: 0000564c9c1db130 RCX: 00007f2d80f1e88d
[   65.923087] RDX: 0000000000000000 RSI: 0000564c9c1e5480 RDI: 000000000000000f
[   65.923087] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000002
[   65.923087] R10: 000000000000000f R11: 0000000000000246 R12: 0000564c9c1e5480
[   65.923087] R13: 0000564c9c1db260 R14: 0000000000000000 R15: 0000564c9c1e54b0
[   65.923087]  </TASK>
[   65.923927] ---[ end trace ]---

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 7c5c1414b7a1..257ab8820c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1852,7 +1852,7 @@ static struct link_encoder *dcn21_link_encoder_create(
 		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
 	int link_regs_id;
 
-	if (!enc21)
+	if (!enc21 || enc_init_data->hpd_source >= ARRAY_SIZE(link_enc_hpd_regs))
 		return NULL;
 
 	link_regs_id =
-- 
2.34.1



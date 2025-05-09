Return-Path: <stable+bounces-142971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EAAB0A6E
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DA63B3876
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0926A1D8;
	Fri,  9 May 2025 06:18:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF826A0A7
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771487; cv=fail; b=OyXBL+U4kpGHIShQZ2aa3R4ivjhWNzjLr8XtIYikFZZywN24moNfP2wbwTWueUWu6i0lBpHhrKfmL/TxGZ2eMnCZypcqlLITJ0XhiUF0UE6DSiInNoqvhZW8K055V0LOTK2Izbab/XVOxP5s3Xvn4iHbh8kZNLo0tRRGn/HlquQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771487; c=relaxed/simple;
	bh=SVU4SAIP37uyJUnQmhbTh2ZLEMUXA3jJ/0nw6e/QoQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2KgkdfXxQqrc0qLQ5vtJSLg+A72jrxQgUN2+YvDcccpr2IFTIYhOAoEh8noJk5Of6ezEPmDzB8OM1fruaqtSGxApYkfQWEKFltWSR6VOISzjJ9trryV20ARVWdewZspVAyhEAFGpJTyNHBeQNTXSLcx8qZINvHeTzOj+HsB3tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494OUGk007414;
	Thu, 8 May 2025 23:18:03 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46djnjxs6m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 23:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbQhg6rdxWXqxMujjdB0KLbT6rdLcUcXz2sN326pm3BJuiRX7X11PW5gnlg39lgOMG7qsus9e1VfOf+E854m/hFjfKH+Xvwnp7t83ILscjXKBD0175GnjYdUfmvg0RTSyDrj+Fdk0r2TKBSqZepwExV8Eyz7gabM7U/SIDmcn3PsCemPRpv4FhUj1A5ZXyDJuBTezuND73F2J0jM7TE5B6qM7kTd0j/jGbOQNPHL4x6Wqn3m7VMDy/sIfdlvbsfA9vb8V9NCH4E6DBdwLCcXrslSvpKNoRWAKAcwg/+W1OT7tSucVroWifFdh0odDKxdScL91FmGPZkxcNL4DJRrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puXSrw3SKzXkCPfNsbdbEa65t0u79DsXl+rOcY78tPQ=;
 b=xOevrAY/plSV/92pvABOr1xmkemRsFFLCBqU/TciriiovvTINX/4E/UuAcfgXJn+UL5MKVOFKhhC8MZTaitwz572Tq68S5BrLPMg0PThSRbPKWDXwFq6Ts5re1B/od0wnWqzoe+yLmnTNWycUw0wqxgp+enHaMalnZeeJ5qOJgt0Dfla9liOM4IeNj5cwx7R4wGgG+nRqrHxGq+oLEHtBCCPjt46J35soe/7MPlzwUFaJcJ9t+qZLL9wWx3/ZJRmcVE3jFC7XYsDtWyNIRZqU4LHMxINCOgZgXQHLkKrWC+rOV7yCEvc7C/0moTDZHAJ6HerqbvfRSqnsHMww3RyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 06:18:01 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:18:01 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: dan.carpenter@linaro.org, heikki.krogerus@linux.intel.com,
        bin.lan.cn@windriver.com
Subject: [PATCH 6.1.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:17:40 +0800
Message-Id: <20250509061740.441812-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509061740.441812-1-bin.lan.cn@windriver.com>
References: <20250509061740.441812-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: d82d57fa-b34e-42c9-868f-08dd8ec13ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30RyulrrVxFovB6j1GSXb+gfwnwMWZT2k3rqpf4EcqSa08SLqRqVjxnNywJN?=
 =?us-ascii?Q?506ytCvFELM7wIVSW2UcyG/wL2WNvWtE3E3O6JJm4jZximdnTC+2sEXaBwgR?=
 =?us-ascii?Q?ziXQVmDpygoN3YvRQtGs7EBvWfRXPxKUnnlsPawRPgM36j22KvT+zNPLeM3h?=
 =?us-ascii?Q?ot5KkGRFvkOZhV48bxjyJZ2km3YoGaWMqyYsXZ9UCkevGz6TmdJhEULMtSsp?=
 =?us-ascii?Q?sKC08NZ5DfMe12sOO4kBcuQJPhgyKYyTm9I/y5LEqGzHZpQDVCXGDJC7NDJN?=
 =?us-ascii?Q?oh6yLAirkd7yKYdI6w2KM7sQW36D/yi8dZ1zjYOftr3hYqeLgn8lW/AjaBmU?=
 =?us-ascii?Q?qD38RlG1iSZ4TCzCBfQS8/ZparvYisvVHaHmI8hEFno8n9+ggkLPErxmY0K9?=
 =?us-ascii?Q?4IrOSWsGag93v1IHZauHJltPx3XlyoO3w2tbBpqIjfnBqiD7LGCpvTTPuOn1?=
 =?us-ascii?Q?0IMPgw7KLvlNV3xpXtQ35HIyiyA/3CYm2tnkb9SGQQ1SpRo+6C3ve1ulOWrf?=
 =?us-ascii?Q?3akM8zcl0cKdf6ms1PWgD66wEPSchRymjEb4L0W1oc1N6aS/cvFFEMgIc/H+?=
 =?us-ascii?Q?fYz9OuVVJLDyHsVXBjXexwwoF4asSl8wbp/lkHyks4gKfQzRSPc10xWe5Uvf?=
 =?us-ascii?Q?UvTJBpefL59plsH73tp0+eGggx1uZ2UPbQj2iRi2UFis7IJvT60jcH3u4nUT?=
 =?us-ascii?Q?8NUz+DDLxcpQi8Eq9EcZIduXxKAYEnzRW3DoebEMjWILY0/F3p8B83cQX825?=
 =?us-ascii?Q?pXFp12/A1TjQ4y6OnU7K3/6olvVRLpwvSOaDAuB8W8u3UvrKhckO4JJWH4q/?=
 =?us-ascii?Q?2dtSGJJineAQ1uMsurf2O1P9WetffnQikOwAMGd5K36mVerfGl2ZpAU5nhv4?=
 =?us-ascii?Q?LYiQgMMuE7Prwq1dyKoEpqTiWVDFmRw2uPvzmVZ/lfRgWzlwQXUhtsI/6CN6?=
 =?us-ascii?Q?kuCZxyQJL9+1e1rORibIIiCEVZOZV2lnVqnLbA84/sZcZqzbnZjn3o1lmQup?=
 =?us-ascii?Q?c18NP4xFySaq0TSC5w4vQDW+3sPO3MjL/Wcd6HrlQaQE/dK2DLz+yxw99eDg?=
 =?us-ascii?Q?6WEDOzhbDZ4VW0wjUuIvZx45vmBrUQVDXehYtE3ocJ0Ak6AJLCRgeolWi2JN?=
 =?us-ascii?Q?5qSLDzpcoVPmUwvNh5uCqC1JytlvMcgQLHSXHYxNyWv2VDqJU47GT73WsBtn?=
 =?us-ascii?Q?K47CseQRDT87gHw0Ufy6FtajRjn5facVMgfnHjpnCwU6Ybnd6L7IQ2mzXuvV?=
 =?us-ascii?Q?yOQiMoaxZc+m0UMU+2blsdrCjLLHssX9qLMyOeoE4VtXkXuEOm92opEKyQvE?=
 =?us-ascii?Q?6XwDjc4koiO5031jnJ0LEVvcC2yu2Mkzt38sz80I8VFjKU8HVt5PpzgRBt4R?=
 =?us-ascii?Q?pE7GyMKv1jdQKzRZB/iwEJFW05IiDlon0wq6xB7QgSxWyckb2yXumvnRinC8?=
 =?us-ascii?Q?CGIqigzFdjvVVzo8YEtmPfn8JwCv/MEL75rbfdLYBPUDjCEjKEbfR3y8Pth4?=
 =?us-ascii?Q?L7rO/Yoc82a8b3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ZLCGrSZKhlSsgTT1lvYZYOAx3bIP8gdHvmknFYg8dm0oIW/fSFevucpd0OQ?=
 =?us-ascii?Q?GvMMunph6IbMVlhd4oAvq6QsIiGYV0ZtGhWh661+PgBVloG/TJCBA5kyMPMl?=
 =?us-ascii?Q?YtXjzeajV3BJw77pMoQCoDUcA086asv3gSWGMnHL8sAnyhFblwMx+BAiTpu2?=
 =?us-ascii?Q?0cWdKvgmXNnmjoj1D/qhDQqXoG0xY68wGw82/rsYSBHCDqGGkdgPTyQhhfD+?=
 =?us-ascii?Q?mvYjL6kL5/mEYapF8VB5MFponKXqLg3tZUvrbmh6s13POsMweNv4MyTW9bqC?=
 =?us-ascii?Q?dhk+H6wV36K3GC5/3YZL8U0pz/NpY5H5noPTTfDfs54aDkhHeVF+Q72llQwD?=
 =?us-ascii?Q?sf9HJ1eKthLHD1WYqFm8yvhIVmmbG/VUeH3D/NssGNoKo8jPKMp9geXnV1LN?=
 =?us-ascii?Q?T7gyf3HGGyca3dpWNyaqKZh/2FN/Dit++ZkUiOt/MTDgnLK6qFWiseextOi4?=
 =?us-ascii?Q?H22T873t6Ah6aSgofy/xEKOVtcoTrfy7O8cihf1Yywe+DVPhJ5WDB8OO0clW?=
 =?us-ascii?Q?RSmI444yYD8f/eAM9Rv731tPij50yZU3puvyFCVLJk5b5A6UAKXcj1/iy7rN?=
 =?us-ascii?Q?SOSGfw1CdKLm4BVq45Q4KQ5ZTl/cUj8cRPe9tuFIP8+rt7ILzLHwQ91WCYD/?=
 =?us-ascii?Q?A46C7UYYuFasIaW2qb7PBvkiu3M9ehE07BYLYGFCB1atiyI+sRCBDUQ/Lphg?=
 =?us-ascii?Q?pbwINAaywvAFB6QfZjng/azg0LtXi1yllJAJ+IbQBeu3y+0yqWhT5449u/xs?=
 =?us-ascii?Q?+kVcoYV0Fxidp61NZGxHkLyQe+X1lhDcN0sGjYlkxm05y1RZRHvbaFvH1jZW?=
 =?us-ascii?Q?d9ryIegIAqF2EmnWVHixcNV8I4bNLYyh8afniWtT1LF6io1qDdm5wgdK4m/N?=
 =?us-ascii?Q?wsB4y1VeBP1D17LURYUVzJOrSU1U0iFDGhkTOwOAwA86ctpwK4oF3b7mA3zc?=
 =?us-ascii?Q?MOOs76doZveE2tOweJVDG0pWoNhXOC3ps34W0gqCTnYrYTiCj2QDH8+5i8ZN?=
 =?us-ascii?Q?C6NAUJewh5N53rvv1rngpr5MH+nnObeX4g9Mqi7fhwIJ2pEEmDXdLFMQxLQs?=
 =?us-ascii?Q?NPecyH/VhMz39KxL1DbNlVVkqKbiJbD8oItsdAgmbt40XA3lGPgeIRK0Rx39?=
 =?us-ascii?Q?33VXKMO3pNvnlntqhvYz09VuOEVC9qbarm51Wg34v8YLHOx6NGFXm88BdfX8?=
 =?us-ascii?Q?GaT1imgqpMSaN+8aiZEaKnRcVMEt5SauG2tEKxp6nnnnPPlGQB+LD0t6ZADg?=
 =?us-ascii?Q?JRrmkoGjSlvGpUSDg+JLaykZD0myjhctCX3UPTjfW2Ko+chsdquw4xnhj6XU?=
 =?us-ascii?Q?PFkmueZSCdjIWdqlERhOzF/Kc7XdGnuRsbyaIYG9iey6xdV2kzqmCMdj6dQE?=
 =?us-ascii?Q?HyRBs/KYVjd2hljEkp86HLPHNATVCXwBhp4mYesRym0tTE7+o+oEQxhNa77h?=
 =?us-ascii?Q?2Wmz/F96BZ35aWDfBW3gMDOIBUOHcIgfvXy6svnY166/DMHlrNdwPPaq4YK7?=
 =?us-ascii?Q?ZedNIU5HRlotY89d6KIab6E/jGxzII5R0KJkN1SeQfaMOuNrsHFgweP8kUcX?=
 =?us-ascii?Q?Zrw1G9f7+5XaDEOiaWojkeaFEG+0ibnbix0Ll2DFqOcLLnz+eFI3Pgj+8hms?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82d57fa-b34e-42c9-868f-08dd8ec13ff9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:18:01.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d7clc72votTM9p6eWFR1wri2UMkltOk7FdcHVnPsYSZPs7vH9cCXJBGCvRdJpaz6r8lUHXteJoG/XOtSNPrHfFJKoRTOIikobLNmc/4nNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA1OSBTYWx0ZWRfXw1N9LbxGWfkd FceYa/SSln3Ts4V0/nAeC3G6RsAaccdqLlYwhd+BcP4YPnVNMMfQGlDmqPz5UFdI41PowmBMmMe hoPlPbUx0QzOiNzor/Toinp08ArNfAZ4gkbc8X6PV94KDrUoctO4/V7S7GFcKpIQ3sXEs369SyG
 NgUggOsqXb1SyZKQ++BrcPr8pNfI3I3RbK5pLaM9DPEeTI7Q1t3rblOIs8l9UD4MBAxu+UE3eyi mmi3lb8M+fvTegy4FNeZJOdX8TuH+PPn14/SOusSieBFxVFdcifgoYtj1oDrz3Hu5uXDF45DT+O C8e3SWS/e+64k4Y2n4vmwp8JgOqWWjrN5TiRBDAiFRPXK6q56kClJqw8mJdlhQFoYwnnfNb0Jr4
 863Sh72s2MCnFyKy/gVPo0Z9cEMExhqMQLrs0MZ1KT+E1Stm3pCEuCZRCAKJ6epoPrY97DDZ
X-Proofpoint-ORIG-GUID: 6B09AK_u2_V2BCuP5yHIMvpvqRqHkKMb
X-Proofpoint-GUID: 6B09AK_u2_V2BCuP5yHIMvpvqRqHkKMb
X-Authority-Analysis: v=2.4 cv=KdHSsRYD c=1 sm=1 tr=0 ts=681d9e1b cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=CXR9pdGyltkxUn7QIsEA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090059

From: GONG Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit b0e525d7a22ea350e75e2aec22e47fcfafa4cacd ]

The error handling for the case `con_index == 0` should involve dropping
the pm usage counter, as ucsi_ccg_sync_control() gets it at the
beginning. Fix it.

Cc: stable <stable@kernel.org>
Fixes: e56aac6e5a25 ("usb: typec: fix potential array underflow in ucsi_ccg_sync_control()")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250107015750.2778646-1-gongruiqi1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 4801d783bd0c..e690b6e53480 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -587,7 +587,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 				    UCSI_CMD_CONNECTOR_MASK;
 			if (con_index == 0) {
 				ret = -EINVAL;
-				goto unlock;
+				goto err_put;
 			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
@@ -603,8 +603,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
-unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1



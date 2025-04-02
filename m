Return-Path: <stable+bounces-127397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D468A789D5
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BD616CFAC
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D34A235346;
	Wed,  2 Apr 2025 08:28:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540823534D
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582521; cv=fail; b=AziEGyGeNGxUkBlzUASMHL8omKxOlgUkAuHFrbYmVPje2jfF8+BSNo6GWAn+6m7WEGYV9ZrbcmBFSWLjZGki5kR0/ZYlY2MymDiocB2n9EKHl/cpe+svthDrFK6zAc8rZSDoaZXhsvXCgUAqoEvoU2xzfGw+gj52MMgJmGHG0kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582521; c=relaxed/simple;
	bh=Nd1m+JU6znorr9Vz0CVuX81dqf01IlyfAXIHtFSWhtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kc92NbH70dOSF44pwow7z4GO7MBwdjMXng6euy/BbQcOZCcKbs547vi//dpbhGzW2t3T0WqASgOk8IE96ofRrvtHLxf8HqI0+ytsmBWKpno1AVU5YLXI+ntzdbWGE9sbhnCwdy1+F/9Z5qfATnISiSWPrl1oEpZ9T1j2qJC7oe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53268T8f022315;
	Wed, 2 Apr 2025 01:28:32 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtf2ggqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/FhJ3PPYAOspkLfZOGBVwTK71vL0kOgxvv5idlsEaBlDyZBPZptVzw889c0tpTczAAAXDl8v3cxYvyKI/yBA6GAKOM9lI094g29eHBoPk17naK7iJSMJ5qh1OzJFR5a8+59IBNXsR2xptwaGNOL8l5M7vOI+5SKpMAgwX7l/SIy1kJW3CxZVzHDJy7jkHkie5Qg3ye+xR8DY/4tmvq4WQPlYWPeLABicC6CPXM0T1OU7Qa0ygwxMPl83mdlyN7pkcZ0QLP+osPLFCrRIM+ISZbVotH2FzANV6b41GwDXLkoAUqpw7yDy4dA0nIgODP40ZHatXCpYIU++qI8VgqHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MF6pN6HTe+igCZhVZL7T6FM3uO38J/oS40xw16cqNs=;
 b=Iekwez92V3X9EmTjksJoDzlteeB8RLEtnJtUMtByCYTkexepuiYVXWpOzEcIm2+Yl7Wazrp0qoBPeCXSbQmknQtF2sArazsGoCOEsXVnTYrwAQhug/M8GJVcDIP5MbclxCrhaGbTRuzUd1S6USZ8dXjPiaIrvmTbEUlDQ4pG6XdYIhoCsCB2++kVr9CFbOeBCOXlps/q978YusSserryyUBa+XYhXQ/LXFFYd9rnqk8MfbWPLJrUSq5BwvPa+u39aIDmarSEo93JUnY1BbnBWJdJGJ8GgNHTmQCke0HystQK71K/e2en0HQF/7LIShvwJpgFvvOneVB4ettZa+x4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:30 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:30 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 4/6] binfmt_elf: Use elf_load() for library
Date: Wed,  2 Apr 2025 16:26:54 +0800
Message-Id: <20250402082656.4177277-5-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3769cc-4f8f-48de-23bf-08dd71c0597b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4yceR3bNOJlJzQQd6AIKgHOadBvmfXdcB7eBZK6h9gD1fSLc8Zh3BwvGXUO?=
 =?us-ascii?Q?N6P6mmLIt/JJh6cq9Ozw4NtbiDveKGCaJE8VS8SOozqbm9xrWeu7oAeTaNgQ?=
 =?us-ascii?Q?yskAatiCnjBekfJUDcgYUHPliH1+I0kCrs04QTAhYAAAakiZvuEYrRZSOa/N?=
 =?us-ascii?Q?mueEcmhgVqkN00TU7cq9PCodThvbyjVQD3NJWpXgxelFEf0UWpN3vmj8ZrFn?=
 =?us-ascii?Q?4kC4hnXS2QNSzOktRjzOIAUQ6CijMoiaVEdUGrAFrDMPAIKk7ZaLVoyO5ShB?=
 =?us-ascii?Q?KhOv4BW0MkH/ZWj88unV+KT1fsYqvMReyJo1MP2aXJqMdsJjZG0FWdR1YH3t?=
 =?us-ascii?Q?T7xUWGrFf/1x+BnRP764xGtw0SpKBgX6ElHw7ClVSknGxEvwYlPKn+BddoJJ?=
 =?us-ascii?Q?Zlr9ytSjRs0feZzYrnQXsiHFuprn6/SZdSFRivI4Xuk3Lp9ehv5yKnYKq3pc?=
 =?us-ascii?Q?Trxotsst0SQNYLnRswPObQvChewHLOo5phBtSH0caG4ekllohDmpx0WDLJGw?=
 =?us-ascii?Q?48ftVL26iss0pZ3MbqxZipmEk9TaN6kZ6VfgdCs9guPZxspjDtsZEMzVFGAR?=
 =?us-ascii?Q?ydejRI/04wmIslJXPqZYt5NUj6KYy9kfNPaIqoy+jnZOSAp2q0xb9hdSOZwG?=
 =?us-ascii?Q?bUVy/VJ92o1VSKW4gPewhT3YHhAsm++QH1KFCWLlbItS8H7Xmthg2o0x01EP?=
 =?us-ascii?Q?YHimoT2aTABrXhUmblYxFGskOVEOYc0+J40Av0ZbHJaHzkuR5w7xY5YuzWti?=
 =?us-ascii?Q?KDgb5qyvSdMs+P6aX1ZByI6IYsOSgIISTFTJqxyT73djIir3cEGKARtQuWAH?=
 =?us-ascii?Q?cTv93n337WD5HMFOPoEbKF+cPon75F2Ktai6cZR1n9cbdLIMLXLybwg0r60O?=
 =?us-ascii?Q?AYqXwbC31FGby+vvKOWbzL3ZCqc0DHWvykcUJ7YdneaVFDXNlas/0Nf/j+sn?=
 =?us-ascii?Q?edSIjxUMKq7X+fazcF/Q2M8v1aLofoY/P6bKlcq5obMXPeJL6vITXs+VIMnQ?=
 =?us-ascii?Q?LpYbmEL/zGjLSjkgdw9PL7FhuD4ujiNFAF5UlfGR2qk5ADLcU4XVv8bYA2JH?=
 =?us-ascii?Q?ccrdHHEEPIOKBHI7HrgKYCC6+BTIrLDPDjUcPO34V9Mbz/Z8zdegQDuMeqbD?=
 =?us-ascii?Q?6eAfnpqpjjApobl6BSjgcYhkHIS9F+JsIi0FjMNfsZ4r2haO0BObpPVwx1+h?=
 =?us-ascii?Q?YLw+UValrUMf9Z5No7l0G/AQzeVpME77WKuO6gL/I1yAcdBT1giAwMTY/Ail?=
 =?us-ascii?Q?6qp+ZgVpQICWwwCSAY+JKaVPABHq8ILHZF4Fx7C7lbfyYCDS7jVqUtxkrKOf?=
 =?us-ascii?Q?4WAQ47ALbffQCJXH0KOl1RfRJktckKA4Q0h7nxj57MBIvW7DdQ5+aae6sQrD?=
 =?us-ascii?Q?Z4+OGzpKJCAZTzrvKjDGdXQeiZ52H8LVfu0l/8GqYoyr/+cv+RAwfxS3IjT+?=
 =?us-ascii?Q?A4J5qqQEPnCR2YrJoWqF8HhBw3JMnEJHP7RNqmLc8p7L3WgREJzwHjLDbBRE?=
 =?us-ascii?Q?jL0CwZj1y8rBMGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+coe4G7dstgWfW6lOGB9hKKZNwYuNkQuN7C2nJ/YP7tZOCYtXuO4OXpGHdEu?=
 =?us-ascii?Q?q8pnYnHKzoMALZPZSFfT6GKHsS2Q+1hCE42Ax1jI06rkBtGX9EOSrZ2WP6PG?=
 =?us-ascii?Q?FP94RI5+QZuaOoILmwVMX4pjsFzCA8n00eI6q041eKHVoNFx+vc3XhtjgA8w?=
 =?us-ascii?Q?ujOdsRd1MmoS25tv16A8M4G2Ph+5+dQjJl8a7/1dnSLvBjvSUWuBfZPEmdSq?=
 =?us-ascii?Q?sfmOtZnPJJuhVWzZ51bugtrQ257ewIUTj+HEODjlQCz/8e5GP0kcx2lRYRYQ?=
 =?us-ascii?Q?E+7fxhEr8ciC642BHECWziiXLiGyWDd1ZC4vgGkicIzfZqyuxXKoEGHXevE7?=
 =?us-ascii?Q?QiPPkbBstlcjgcCW8sbXM/G6gHcktMDWUQiAGHllDemqee0FXT9tRSOrDPMN?=
 =?us-ascii?Q?ahI+qmYFl9PLivpIPDd8NyRKABwKTfyzWobZezcRZ04f/sRiM1AwhoIEg4pP?=
 =?us-ascii?Q?z0xn626fejOKy1IenG/Z3ldIOXzJNUVi9u2o0aFv1Ucx/0ZucF7xxCifP7wn?=
 =?us-ascii?Q?LALDY9rsIYMohzAmRv6o407bNe+SoW+5A992QG7fJyMk72N6ngr2a+PxaswW?=
 =?us-ascii?Q?bzVo5B50cVFaTyFphhhcvO3Aq1CM69xF2S/xv19Sa6l+orL3q+H/IJwN6kvx?=
 =?us-ascii?Q?54lzZfr/tyhIvgqTtastZ0fVBtitO/d3xk0bvtGjfF3MDuOEkN8oyeuvPUjZ?=
 =?us-ascii?Q?CyQTfnJWiY91U/cbHi/hZWuGWICfmv20EI50NYFP+IN0WrAUReRNR0T0fPmc?=
 =?us-ascii?Q?Kjt8gLYCW4ZBNGSV7V8HFvhctjwaEcPEjYx4LSmdftN4w66wk2OpUVkUOo8B?=
 =?us-ascii?Q?ywe49//BY+G0Y/ndx6Ez/rNKXww6d4phvDWjZgrLRkkqYPSX3o0ubb7KwiGG?=
 =?us-ascii?Q?PskqmpQ/VYjmOm85U420hGGxZuo2VZwE3TnfK/zCYmE0Jp8+A5l68KbJAfg8?=
 =?us-ascii?Q?0NJEgDHlo5/t5353atXXCn0uhY2nk59M0SgzPNYVCokPZpAXV7AOWFjznLiq?=
 =?us-ascii?Q?DAFTbJDH3zqVsWP7UWPY1r4KqY6kOi8tnUZ+5qtWrC/MSNMMwtVsSUd5eHEa?=
 =?us-ascii?Q?GNg6OLWQ2BMKrVIj/IyPIJtrVaA84XqNbyjUf+KRLZsIWS1BqSPF0mbBeP5D?=
 =?us-ascii?Q?Rg/5yAM0yXYllhUO/uj+3ns7+PseJ0uPKCOoHMEVTze3dIufWEF0pGulWURB?=
 =?us-ascii?Q?uWiqxUvyqI9TrpkHixpaagRePPuQARGa9Vx8v+tB1V81D/pXpesLGM0VOl7l?=
 =?us-ascii?Q?5/U3awcUz4X2cEU9dBvLBW71m+br20tCXsGv+SZv1hlCW8On0b0MQbzJJtqI?=
 =?us-ascii?Q?eiQ1BJob+vv8ML9VCF+OMxKrLovMf+3l2b9jENqhmCKalksnqNuHI9wezyiy?=
 =?us-ascii?Q?y5e2k9l9eTqRKclAQsCdERY1px0MFbQEym/jqG+tBwCiFKHNr57pUh0wTzMt?=
 =?us-ascii?Q?9s8ki1nYn+4eJgm0i5E8AbbdEbAdhj2jK6ogUAy6CQMcm4+C8DZ8ILzQ8CuB?=
 =?us-ascii?Q?CgqoqLzD9Bha5OvLHNWNhEDcp5bJWl2wL8aqn2jzL7gcPjB6XmWAGSM0KImj?=
 =?us-ascii?Q?iwROPxdhwEkUaanxbVXa4BrQIzYIvzmYg70nFVAf4GoIFffRpm4EKLfynngc?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3769cc-4f8f-48de-23bf-08dd71c0597b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:30.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1zVM7Hrn/CV5nSJsNHpeXFR4o6Bn5SadSIinBwVDo7RreqocK/O/nQqh8OIRxr0j2GDSm6K2MtbfSz7dguERaWUDZXDZq8fe5rem8yGOnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: 4WGKL6jk7htdwKdTCMaVl4MKj5zB6vHR
X-Proofpoint-GUID: 4WGKL6jk7htdwKdTCMaVl4MKj5zB6vHR
X-Authority-Analysis: v=2.4 cv=fM453Yae c=1 sm=1 tr=0 ts=67ecf530 cx=c_pps a=F+2k2gSOfOtDHduSTNWrfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=PtDNVHqPAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=nZ8kGeCxs_7PGkKCuCgA:9 a=RMMjzBEyIzXRtoq5n5K6:22 a=k1Nq6YrhK2t884LQW06G:22
 a=BpimnaHY1jUKGyF_4-AF:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: Kees Cook <keescook@chromium.org>

commit d5ca24f639588811af57ceac513183fa2004bd3a upstream

While load_elf_library() is a libc5-ism, we can still replace most of
its contents with elf_load() as well, further simplifying the code.

Some historical context:
- libc4 was a.out and used uselib (a.out support has been removed)
- libc5 was ELF and used uselib (there may still be users)
- libc6 is ELF and has never used uselib

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-4-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index bed3c0cfb63f..a6508c56f418 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1307,7 +1307,6 @@ static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
-	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
 
@@ -1352,30 +1351,15 @@ static int load_elf_library(struct file *file)
 		eppnt++;
 
 	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file,
-			ELF_PAGESTART(eppnt->p_vaddr),
-			(eppnt->p_filesz +
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
+	error = elf_load(file, ELF_PAGESTART(eppnt->p_vaddr),
+			eppnt,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED_NOREPLACE | MAP_PRIVATE,
-			(eppnt->p_offset -
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
-	if (error != ELF_PAGESTART(eppnt->p_vaddr))
-		goto out_free_ph;
+			0);
 
-	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
+	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
-	}
 
-	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
-	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
-	if (bss > len) {
-		error = vm_brk(len, bss - len);
-		if (error)
-			goto out_free_ph;
-	}
 	error = 0;
 
 out_free_ph:
-- 
2.43.0



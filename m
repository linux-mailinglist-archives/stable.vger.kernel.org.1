Return-Path: <stable+bounces-144106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA74AB4C21
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDA51890F37
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15861EA7E6;
	Tue, 13 May 2025 06:40:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68B17578
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118441; cv=fail; b=iPlBi8vFpRadFUt/FP2a2SZjAgnnTH1Ms/n841aPUJIuC0pWVHgISptXr4Fkvj8LYhkFFGRmTwx2802gvNU9SiWqgU9pAmgPbiU5muYOlLA6k6EOP9ztp7BS5zeh8G6RwVaBdjpK4trtM/s//o64YUcGue4Zu1Ml1UuMU+AOJUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118441; c=relaxed/simple;
	bh=nnkwRfqx3f1UWYJj4E8G5ETf0GKONWFg2rB62OwYXKM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=koar61Uav3FFgsc+n1KLbB0L2GKmFY8+wP8nYURNA4gF7AaUV8/Tp9i+tfl7YJtAF4e3sdwBNYd1Xh0HEqN3Rfr0WSAeJs3U/Hg7LNU+H0KBcNwXDbv+hBwEeBZqUPl+EUfMwW64QxFcYmZBYVCfUNcdcMrH8xAi6RO6f5ZXLpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4xixA013322;
	Tue, 13 May 2025 06:40:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46hws8anqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 06:40:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ppRf96S9AMI+fb6AK6nV2TPpVtKgM4oqQ+p+xKP8FvozTewx0fO1CrVMCwA/qatoKkugppqPzNrrUxB8sww5HnbwsKeA8lejn0IRL5jqfZaszPZfLFGb6lu3EhwgVBaKA/ewAq/pW0FGdeXr1zJ0PLh8ekddvAp8M1HtGDIonVsgTCx0V+i566kR1ga81CO52iuHxjRktR6NFYMVEioHt144IT9OLInehOKvroHnUm0dnxrzFPSsocvnNAv4FeZIIADVxlAmyKUETn8ynEbk1vkMQqoDKMfgUr9mDVt82oC2bdUU0y/PHp6eLoVl3vdadNVYT9r3b4CG5ebhbI56xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH8V3XXUNKWRzf/gt9n05MDrg73BKb8d4kPSCKQQSVE=;
 b=d7fh3pUh1GHuNQORWW5/pLBtP3c0nPkSHH8Wtsvrw5TSUjHzqGipwmOjyFwlaJLVtoj2r/pQ4NeEXSrGPw1zIfrELGSG3pNK/Y02f/vyqwArPUTj1OPp5DC/v5JSv+wFyLYBZT641OjYYmLueJFknwtc2rNZ9/3y0pdgMwDefvK9zASeirvPGJNR7q0XLyq87U7VFkEaZXPUfza0b2e2IlwV2zrTy4IrFuMmlkloxcw8VTiCKikEGImlaM+ImwlI2gsRl2icGsHmjZ7A75Ojdbsc/X6tDvfpQdcsejrkZrULK9eGmiQbYuaCI5Rk4AZvenodcPgRiSNqd0t9VPb4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 06:40:14 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:40:14 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: tytso@mit.edu, bin.lan.cn@windriver.com, jack@suse.cz,
        libaokun1@huawei.com
Subject: [PATCH 6.1.y] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Tue, 13 May 2025 14:39:58 +0800
Message-Id: <20250513063958.1276890-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::15) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a67233-b4d6-41ba-9e55-08dd91e90476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NPqvEOU0+/OXAMjz0S/8dlT/FKiaWiR91cNNRems3NYIlfjmJ3dnwhiDCrTv?=
 =?us-ascii?Q?MIsrng5noREtOtvhJ8ZJCY3k5m/iWAlGKoHbmZQVYPgnNcgNPrbr5qcuhHvB?=
 =?us-ascii?Q?wIRjQ0UErgIjPu5aC+9SNjFCbSDU87dZ5pj/MWzgL1be/P1oAFXiqxvezFXn?=
 =?us-ascii?Q?TzPFAwfcZD5NoWXaeW4l8cDaLxcgLKJlUWG6B/FS8FFFHwm6JhIbuNKN8k50?=
 =?us-ascii?Q?CgpBG3GRieJaZk4yj4PgaeIXXp4FBgjZAqb1lXvs1rEW2LPSxqA4rCDcubtH?=
 =?us-ascii?Q?cg2+lig1XwSIMLhB6Rpxs+0XkWcUJN9GHj+h2jn9fWx/G4kKDh8O4ljuglWw?=
 =?us-ascii?Q?kqmkf/naJxWa/Z0lsLR43FcSKJeyAAInQHKMTZnQOSlESIVR06cvspkOTelM?=
 =?us-ascii?Q?BGRRLWV7W13k2REj2vXD6LNBme41zvrkiL6davAzpsviHi1qxVUhWzQkvN0e?=
 =?us-ascii?Q?cG/bndntIGBp+vs4otWn7BJh7d9mRjtATabrhUQ1rxgWbph+igCi0H2Y5eJr?=
 =?us-ascii?Q?i1uDmdXWQgc1fEtAmG3X3i2RfbyZey9VkawKQJ30ERd0IjBCOMj1uwcaNu/T?=
 =?us-ascii?Q?pNafeiTih4WOIvpFi4ANkmV96UbMePlhtJTk5tYDU9adfb3AcTYK3fZdN5Nj?=
 =?us-ascii?Q?3nY07EvkGS4uhPWIGCkNXOD24nm6RAd5cQAbk6+c57nlocVb0yeYzs6BqVse?=
 =?us-ascii?Q?MX/sWByy/i/5GibfFBkoBwl7fa6pjVt9oax8BUrZicVq4rQycgITMXv64UJ1?=
 =?us-ascii?Q?6fukEFy22Hguqmxl+IbUal1b/gHx76H4oEgFV8WB1OLnUk5XIpkGC22uTIAj?=
 =?us-ascii?Q?+RSDrQOHTas3JBXs/Qej/tdmeJWv0Mw8KwVjZJ/Hljpe12OFUCp+6OM6/Yxt?=
 =?us-ascii?Q?d2/21uiulGgFmdOvmkYgkln6iyATRx5gJ1jM+NXVnYeTnvU1KjniO007AVod?=
 =?us-ascii?Q?whqvuf1qlSOjZh9NUzd4VEmlDbv+iVy/hza2lm9AVQoxY5/iVnAO9AbFx1UV?=
 =?us-ascii?Q?pzZ3DIaLhQsR74eqNf7NTKcjXequk0WQvZOWper24eqo1qOX0KijvzoZBwUJ?=
 =?us-ascii?Q?R600O61yJyODYRu+0lIkTOIfptET1GDbGvJC09uZWQYQV8ZQZrdnPlzBJSxI?=
 =?us-ascii?Q?w5U6E0TnWvkAWfUxfWPtPGa02/LlHFBv5j63SKZAHL6pn0BZVDdSPufP+1zA?=
 =?us-ascii?Q?ZDNJBKdiroUUcG51ZsmIw8pbapAJ7y6+seIKXE+COMk0fHq6pK9eBGk2vXEg?=
 =?us-ascii?Q?Z1VFA7A2Bfzp4WGPkL1ioznNPywN0y9+fHtxUBydF+ALcQHhYS8aUdSH/oAo?=
 =?us-ascii?Q?Ski9Y5rdEtn9BDZwbXSzo7TG2Cwp+7l3O551v7GOozx2hPSUyCWwOGeOvH5f?=
 =?us-ascii?Q?88H8QiU8S4fUAIMLbRCyW4HXTEpEP5WVpTeP3ujDct66zWkOCtYE6OavQHkH?=
 =?us-ascii?Q?u2x6kUirdXl94m52/bsf1nBfE9IGjcApRlg/PcfGKbEsd9qQ6ylN7N+02IK3?=
 =?us-ascii?Q?kbQ3ZbdcVzdPAa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vbSiEvbtCaJMOW3AxeOviZLAABZGNFC/nyH4Ll5pGxWFSyRaowYWcmQcgygY?=
 =?us-ascii?Q?1JCCGul9+CnINa81q8vROOco0PplrNrtPBn8DG24SP0Vv0yYmZ5RZd105EMK?=
 =?us-ascii?Q?O6o5CRF5RFMbCWQDisu4s6q6SshzoTSPoELnVJxIRjRy4jjiQoQIGdZ+wRrN?=
 =?us-ascii?Q?KAS/XCFGylUPDawZVYQTZlfdqNknKv6+J14Z7kt9hwzRHlpH+ZLtFUkK1z+2?=
 =?us-ascii?Q?KWrXakHNnU3LGPwaepuCf/kIEpcq7GTt+a7mxvbghf329g4iQFP6vJnEMFwg?=
 =?us-ascii?Q?z7VjPuJRbjGIS02EIvHJEN8c01sa39cgEYkefdx9bsuOzYWuyf8eczQcb02D?=
 =?us-ascii?Q?M2Uptmp1DVMD1QWE4b0hOx0Yi2BZTeXIfdrexu7h2kfcjnVQ/fttPf0bIyPr?=
 =?us-ascii?Q?iRIrwRaypqVkEgg81dQABZwrVFqxu5QfQrZIpOf4pG15XNhJVbajbRW3C7PV?=
 =?us-ascii?Q?LhUBbYjtGNfmgEUAWOcjsOti7yBpsH4wFobazFzacQxAOEXfJVgmlxC97yZv?=
 =?us-ascii?Q?tQNxuYK7THZvD/uSxenhHdlb4QIo1mFmoPaM33xKOk4FPB226Cm2mYbnBpMp?=
 =?us-ascii?Q?ggdLEGAgoi48dvYnLvxYRCktIzjtLHzgv6huUU2oQPW3Nb8KJdSyMhBepOAV?=
 =?us-ascii?Q?LyMskZ+ZsDk55ZlrUjpclp2gNP+LeUGIWW8cN0/1wMh+vJSryR+6J/4vtxW9?=
 =?us-ascii?Q?6DtgW65MdorkooTXV6JgTejmax0/MvKhO+xRGmQgzuhSd8+Mxg1FsyOf+MHn?=
 =?us-ascii?Q?Sjk2ND9EeO2ABPApzwlYslvCB43O3Szqi3AO0ndMn5U8miflWsyk6YRWg08p?=
 =?us-ascii?Q?Xt/MQFFsbTIeR//53PTC/mNTE7bdmA6kxkgCDEnUC+ysQD62w+tLG7VGQYSJ?=
 =?us-ascii?Q?MPizQto5mw/Vav2KxB9R3SJXQQRdiwumWfCYJWjGsVhwiZgj9tlLhlbnyJR0?=
 =?us-ascii?Q?NolVt0PJSNb//pthJFsCnLogZ9vxUqSvROeY6JhtoiTTYq/3ACu+gCMxbDc1?=
 =?us-ascii?Q?7Ug/zlBKr1MKEqhkZmu7ID6Kh9lKk9cMTaw8qVrzZfV2qGPTQmNzX07pYlP8?=
 =?us-ascii?Q?hNMwOzJ2CNrtMVNT2lRfltrezuLqIjseKaKeSaxsBPEFDSI5+7gc1IRHC71F?=
 =?us-ascii?Q?rWTtVmt3uQMYpTWMcMB0+nHQ5WtJobw6gWCAimSR8UzUK4nrXc2/wgd8nVBa?=
 =?us-ascii?Q?kTorpyL4ckxyt0aI2eX5S24H3Af66o/AEee3DwaqGeK4NAt2qJQ56dUcK/1m?=
 =?us-ascii?Q?BdiCb6O2c4s8QUm/gEgdV6grQyB3+jCDji2BZANwTl1r1SQkStG1TiQEY5m1?=
 =?us-ascii?Q?ygnWO/H2oNXvp7WgH8NOFwTZ+HbqBRRhqpp6+AYJW/unoXyMvLWXK0m4dA6k?=
 =?us-ascii?Q?32r9SiQVuiY0uuxcAW5iQQx8DkDs+Eksw16QlLRt2hlCkclkanGO36tJMLw5?=
 =?us-ascii?Q?DXzPN3D+biViJNJhhttnzJiVUZQS5aod/A35DdqFBdhyuNH+DTg+QdWtsBU8?=
 =?us-ascii?Q?tYdAqB08LGP3VEjZb3PGbixX93VznSHEGebwEQ8GhJB/CUYwcF7EiDuKGTEz?=
 =?us-ascii?Q?9GQZw+iQ93jeZX254iosBPG2UbBmT9zijWFQq+8Dzf8YbUJUHR8+PdTv4LLV?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a67233-b4d6-41ba-9e55-08dd91e90476
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:40:14.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8f2Zm0Japc4oyLlqLFPm5lJKmBcWTd4AihdtcbfZfvKVOtoOLD+f/OnSHwWCUQgv8KJBd0SRLPaDBtNXn6Ryy0gklpRYDI40D3L+xwd3bzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-Proofpoint-ORIG-GUID: Kk2beMumQKlysbtimFgkpfTyvB4Wy97R
X-Proofpoint-GUID: Kk2beMumQKlysbtimFgkpfTyvB4Wy97R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MSBTYWx0ZWRfX3XqOOYK75Qxi IvwrV6Gq+u1SThl0tf9DQ7M9qO/V3sUkhQWs0t5YKe9U+dyXPnO9g4hvqxDtmH6CUZn0NeBHhip Uv0BgyppcmFx9Kn8xc1J/YkjjeRKfHySBsERCCg1hiGGxTvJzaEdxGk8nDQkWfCe9NPWwkYK254
 77+tC2ouHn6WgMOSbYmphEvGF+CUwVaplHIX4PLEcfOPKWKe1ZqgUNCGsQV6H7CxiJn5A7wDktn D9aPCej3dtOLTghMQwm8I5IxBlfvWugHFwDj78O465cDz9EjYwjALJSVMP52Adi5DeKPnQzQpRb BrV613W6/8dPwpwOalu09a1+amEbkVmHAFqy0xcfcXIC83eyVESyR6VuJAzWkvIAcsYsFMt6qnX
 RcsLk5JFEvkOGOM6eW7Y56HjOYol40a6PyeckJiHP4f4ftSn4Om08FWlRT/l/2HJwOXISuFn
X-Authority-Analysis: v=2.4 cv=Q+HS452a c=1 sm=1 tr=0 ts=6822e952 cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=prOnV4MpFAw84sU4cfwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130061

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]

In the following concurrency we will access the uninitialized rs->lock:

ext4_fill_super
  ext4_register_sysfs
   // sysfs registered msg_ratelimit_interval_ms
                             // Other processes modify rs->interval to
                             // non-zero via msg_ratelimit_interval_ms
  ext4_orphan_cleanup
    ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
      __ext4_msg
        ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
          if (!rs->interval)  // do nothing if interval is 0
            return 1;
          raw_spin_trylock_irqsave(&rs->lock, flags)
            raw_spin_trylock(lock)
              _raw_spin_trylock
                __raw_spin_trylock
                  spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
                    lock_acquire
                      __lock_acquire
                        register_lock_class
                          assign_lock_key
                            dump_stack();
  ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
    raw_spin_lock_init(&rs->lock);
    // init rs->lock here

and get the following dump_stack:

=========================================================
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
[...]
Call Trace:
 dump_stack_lvl+0xc5/0x170
 dump_stack+0x18/0x30
 register_lock_class+0x740/0x7c0
 __lock_acquire+0x69/0x13a0
 lock_acquire+0x120/0x450
 _raw_spin_trylock+0x98/0xd0
 ___ratelimit+0xf6/0x220
 __ext4_msg+0x7f/0x160 [ext4]
 ext4_orphan_cleanup+0x665/0x740 [ext4]
 __ext4_fill_super+0x21ea/0x2b10 [ext4]
 ext4_fill_super+0x14d/0x360 [ext4]
[...]
=========================================================

Normally interval is 0 until s_msg_ratelimit_state is initialized, so
___ratelimit() does nothing. But registering sysfs precedes initializing
rs->lock, so it is possible to change rs->interval to a non-zero value
via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
uninitialized, and then a call to ext4_msg triggers the problem by
accessing an uninitialized rs->lock. Therefore register sysfs after all
initializations are complete to avoid such problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240102133730.1098120-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/ext4/super.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7f0231b34905..8528f61854ab 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5496,19 +5496,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount6;
 
-	err = ext4_register_sysfs(sb);
-	if (err)
-		goto failed_mount7;
-
 	err = ext4_init_orphan_info(sb);
 	if (err)
-		goto failed_mount8;
+		goto failed_mount7;
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount. */
 	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
 		err = ext4_enable_quotas(sb);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount8;
 	}
 #endif  /* CONFIG_QUOTA */
 
@@ -5534,7 +5530,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount10;
+			goto failed_mount9;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5551,15 +5547,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	atomic_set(&sbi->s_warning_count, 0);
 	atomic_set(&sbi->s_msg_count, 0);
 
+	/* Register sysfs after all initializations are complete. */
+	err = ext4_register_sysfs(sb);
+	if (err)
+		goto failed_mount9;
+
 	return 0;
 
-failed_mount10:
+failed_mount9:
 	ext4_quota_off_umount(sb);
-failed_mount9: __maybe_unused
+failed_mount8: __maybe_unused
 	ext4_release_orphan_info(sb);
-failed_mount8:
-	ext4_unregister_sysfs(sb);
-	kobject_put(&sbi->s_kobj);
 failed_mount7:
 	ext4_unregister_li_request(sb);
 failed_mount6:
-- 
2.34.1



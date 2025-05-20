Return-Path: <stable+bounces-145015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D2ABD06E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DB73B2339
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75F19E826;
	Tue, 20 May 2025 07:30:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE04B1E7B
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747726240; cv=fail; b=jK2oYV+YQzHYdlkxyl9ODyP41Ken4ahTtZHekuY/vLOycHH1lcj8D84FdUHUhUhIAhUDICEJ5elJ8sun1ECfC8LdWAzm1tUnmXRcdnd2XIMgHAiNO3mzj5fQgs9SWy0nmBY6UE/4JdrlWXhsltwC5Zvs0GDnhkq4nzbVy2/sudE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747726240; c=relaxed/simple;
	bh=6g0HkbexSYU+m1tbL29ffrDDKlSqIX3pKUxbEAKDSak=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aGHIVuNRrMEC/aPWZaSiGwzpo7xLkrbuu90yFqAKXW419bb/+D1GzYC1i9khjeVR5EJ5tpe98Aajskdj6CNmazz5H53EwwAT8qndIS+1W5UKA487B3RlgBVZNNHhDoL6MgRuO9tAJCrbx9laQpyaJu7G241MNxkR0r6D0T3yYYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K5YQCX019614;
	Tue, 20 May 2025 00:30:31 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46pnr3jrt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 00:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHiz6wuYBA3j2Di5MmUQVhm1f7Ks0qc2ZYOTbR5zQInl3UdBq2U6Z0pLC5dFqhbe5BbeWlf/31hMRDkoZBTnu+tSCibpVhTBwF3lfwMx62YkhZ1KL/pCQ+7ExENfD3/ooNpCR3SgaM/7kM6CBGB14UXFCgi6fSzCmMMM3SsLC27msj9VrJqQtybanbOyJrxvrHxBsHlcKE9nhQfvlagYe/Bh+oBCr/EQQwuUrA6mZSfC8UlRLwEv+P4EB+vfL5sIi4aV77MJuzA48v9otDjanLF1sppV829bsO0TlnVjpgvmxjpOumpbeokkLf2NX+IBhPoOhyCo3RfjkOD3kMrN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISrIU++bBZ1rmBd7m0C9n0w/WJ8/+s0N//94IfqxF94=;
 b=B6wGD8u0dyRceUBSgqdEtCBl/GAvTkHKftopqxZzUUcsrgfATa18+Lb4tNG83w+O3gIa71qkSA+Rkmx6OGeMTe5ITX7HrmasqQOnYJV9hb6WLlRfDpxS65+gIxajRPzBIgJyUoEEqVaK+J/laOKRWe5SGLQZhjqFhdtQkeVdYP5lUaSJzmNaqlhLr4yQ7i7ME5zoeaRUlYEjtgd2sRENclb8YZiNQZclvpfuLkTy+lyqS51iVsl25Cx0NnXvKx1oC9N6v3oJOmSKlcx3R27gZlEU9P9qxyU/vrcwpWpfa/XUe3rcEbrvvCidW/QI1m2IWluIuK6rzHohwgcRQeodrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 07:30:19 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:30:19 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, luiz.von.dentz@intel.com,
        neeraj.sanjaykale@nxp.com
Subject: [PATCH 6.12.y] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Tue, 20 May 2025 15:29:58 +0800
Message-Id: <20250520072958.2053271-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0285.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 9251d3bb-dc50-491e-ff6b-08dd97702c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+gqJvp63fNLoLjhqzDx4swY1j/HeSNMAb3MaPrku0jorS3/CabqbMBYxumw?=
 =?us-ascii?Q?aXDkUUwRmhouVmacNKPr/hDpzBULocmg8Wvxldiskae8SniVJ+P2wGxHm0mn?=
 =?us-ascii?Q?4YWCp+TmG/IDpbSLx21W1BcywJtm4/YKe35S+tYJNrhx0uQQiLdc55hItHtd?=
 =?us-ascii?Q?uO5sqlJqZNMu35g/JRPMtd80T8Qtp727anFaiOqh5KIv6NUIi4Cj/9hWj61q?=
 =?us-ascii?Q?j/goizi7kxoH55xB9urqAWhx6QhKza/HJ2NFVUIqaoUXptTdfQZSWP89bZa6?=
 =?us-ascii?Q?sTodRCsdmMvRPsk4PuhvNYlSl647MHeQV+nODbrsF3AYZEb5+tKLHd4cwP8Y?=
 =?us-ascii?Q?vrYXYejok/6dXwm0aAOLELRyB4GXyc2FJB7xBE9IxOE+/wBN8M7cdYUtkVrV?=
 =?us-ascii?Q?rp6f5FQxMXXXPqby7JuvESSwabmpEm3rj+qMlyx1vFpwsRKemjb/2xAVpRlT?=
 =?us-ascii?Q?8nTlIewsDZQWXjKme2z0zSAzD2OkbC4cXlWQYvcq3Nfk89bm5UJqIeohUD/J?=
 =?us-ascii?Q?oXuSS0glRNci+PaxM54NtwhQTV9SxefouOzN6t1O+h+fE9dq9X3f3S8ac4/S?=
 =?us-ascii?Q?JiAu0H9K/Zm5dKzJKL6RbqW3TyFKdspagxHqpwRQjcT+8gxpulHqfSHCuIQy?=
 =?us-ascii?Q?YIUagkxizt7wtGDxYugT+zV8Y4mmByCSMfHA8c+paRUiRSixhSFBvrYesvWd?=
 =?us-ascii?Q?bXxz8BGDNgp4rzW29pLHr7SBNAGnzXGy6nb4iTwd9NO9/OYpXLwpyGl/jn8g?=
 =?us-ascii?Q?am1LBHGH9u1ba2KHcF2hRcA4U/qxHTHGSzDedXSqSFB5aOEfGF52qA0NfZYG?=
 =?us-ascii?Q?KHmBhK8KCByu6InjubDnKIDvRPRM0PgAGc47rFKKgwVnABHSfe0IS2RKmXjr?=
 =?us-ascii?Q?VUpQ7SCYlaY9GDDcgTAy3KemdLdXSy+5OHOLlJ/HMcct4Pypj1aa3RA7XUW7?=
 =?us-ascii?Q?zAsq4j075fcqxLVU55/AcPOhgCVgeRC2RUGi+yUfDDpJXlpC+t6/mdHo94Ej?=
 =?us-ascii?Q?2EDv7lfHu17vXhRH5vLXDbEd0mxZZbMImOlmYr8nmr2vMVPshJcpgoTRmXg7?=
 =?us-ascii?Q?mmlrD+b9G8DM7gERhQ3zEtduxkqBqrvK8+YQvnW00PMHIq4mT/ZHU6jvwa6k?=
 =?us-ascii?Q?it8TQWLJzjWKoLi+XcSrlAGHhEQrZsq2VBwx0exOzptJNrGW443dDzpj6E2j?=
 =?us-ascii?Q?Bnqkrs0D85aSEUS4Goo36wfqrjQMR5m1n4/8Tdbp38qpQAHqT/pRgTDdRxyn?=
 =?us-ascii?Q?87qBbk0Z3V6vQRSgECZ4Tg25KYOR4XDudLE/7DwLtx07fDuin5kcvhlUUKfv?=
 =?us-ascii?Q?Xyho7TIvd3e/kE+g/1Gui3f7ZMf1znq1yR3cgHDsfqy/VzESBehSyq+NTz8j?=
 =?us-ascii?Q?WM49jLiXsP4eQWRCQddiok3LAPJtoQNsXEwQErW+bQknD/Jl6yc9XqsImEpW?=
 =?us-ascii?Q?213fqFw49j9xy86RrOqixuLpmmOjdDNAyubPqGjBEeWPty3bu6DU9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rai6mad8CeS6/IBxfJRjW2fYfaSRmFgYtcRCUlwATS3YAQevzIFpcVw1O8Da?=
 =?us-ascii?Q?Hk9drxRlXFlRBEMr+FQJsOcVCc3dcpMWnC1yOYOyNtDOWm6M4difmKfUbk4N?=
 =?us-ascii?Q?mfHeXWuAvMW/Ly/kds4u3MOTJuP7f8hd7fEiABkIU79Nhfw74Znxx1UOXwJd?=
 =?us-ascii?Q?Ri959UD9Kfv+t+cOHqVdA1Zt5nRbhcvHeGqQp0O/l5atrqfkiN7uOnyJbmKX?=
 =?us-ascii?Q?MLxzuSVm1rijJ9qb4hWMaAkawfJRN/rtn1aMCtCj6hzPwYYkuObHuPgCnSQj?=
 =?us-ascii?Q?5t0Ntr4Z1Id4Ua4F4a3q3T81o86IPZ+pp/yMGR3qQrT83lslp+AM26cZpBbc?=
 =?us-ascii?Q?ml1dsQk7uWd5f7gJsAm6GKZP49NW8vdug49DbDRD9ktL0yOtg51KdvOB8f7Y?=
 =?us-ascii?Q?CvkfnMk1xfzYtR055kYnElA8HspvCICZVacTpiqNiFJE34pY1PPPCAvHxTRe?=
 =?us-ascii?Q?SViV5D8tvHnGrjgA2bhV746EyhxGdsAV0F86kL18NzpugcM5spDt7Twqy/iR?=
 =?us-ascii?Q?0CdZSG7EY3cjBL0+K24It8BiHYFRuOxhE8Fh3gUikix7DDF0HaLjZw1pQmAw?=
 =?us-ascii?Q?TeCYvL6ILUyQ9R6r3hqA0Qxlf9HPmBRcLDQzWOmRoSlbbc5oWlPeYJ0CREYS?=
 =?us-ascii?Q?s9Qlghsu8lelguWsueSlggdY+pg0w1udVvQiBcYphAXlIEfHOmgnDrAzAGlP?=
 =?us-ascii?Q?I246uWEHz/bDkWNeg2x+cDI8BugZFcPwX7CyMEoSzdPkY8IPuoU0rQTdwfMc?=
 =?us-ascii?Q?q2Pl3i4gd0QZeel281M1AXBSgavV5abUGiayBOhq3Un0D2vhM3FOMN/CeMps?=
 =?us-ascii?Q?MnBK+xevuYCulz6SSEa4OQzEH1stzD11Jt7onLLZ5pWmkDTcmI4gQew7bQDK?=
 =?us-ascii?Q?wzrdTTNGvhZ1C8yITQ6UrQeXdMa7MYugUF2yP3lK4wtm8AGL6un9oC8gRhen?=
 =?us-ascii?Q?IxdG97NlZb0avMt+Rm5gaiweoc4rGMoshfbDeLwzwHG9jg3DtyQCMzgRdUNF?=
 =?us-ascii?Q?pxTQ7/0c5Y6TBtGwIoXZpz+5v4NUYpzTLCHUZs+MPTYixWxTEH4j8UjHowXG?=
 =?us-ascii?Q?jtvAXLuHBPxoYNmUIQPRUaROZN7Kyq7iDmh0XKmL3reyCqfRw4yZAwyuX/47?=
 =?us-ascii?Q?zAusHtBdqNV0Fw3+/ObWOg3Ic/QtW/4Ds16mCQQvTAqhRaSIOX7phpI//AGR?=
 =?us-ascii?Q?KCm/sFHCLe8IklV2oT2C/b6YX+M644GpL7ZrUbPZXbPCPGiYZ5P4Fmo27FcK?=
 =?us-ascii?Q?5RfhrNbd2wG14BhOxoQ2vwGRLaMUa09XkbwScOQ2mselnYuCCheoUklFQDD9?=
 =?us-ascii?Q?Gs0VZGPOThh6YYkOALkG9M1UCRDZUMnU9I8WWekoeyh4J3ZLP/Bbg0j0pHiH?=
 =?us-ascii?Q?VoTAL4Zc1/iAGA3UH/3+JJ8neOHef5sSds0hhhN7aV8UEINIrZPaWWcoLUQA?=
 =?us-ascii?Q?olYW7j3mUXlrhiHdN35ipBqut6snN/bVmB7mWrMKKIWQnMTClAuIhD2Qzsre?=
 =?us-ascii?Q?bZ3OHtCaRHeySPOk0n5/7l7AgAQf+zj00QWaVGWjET3DfZO05LfQqop30yJC?=
 =?us-ascii?Q?2+0VNOu+7ot7pazV0v1FFFyYiRMRwjdh5sU0ucS5G2WfANNC1ajyfOcbvybk?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9251d3bb-dc50-491e-ff6b-08dd97702c24
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:30:19.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpXp734PqoGrRMb1WN3k0kBDJtCUMGExazbEUP1+E46RVh9irtcst6EkdPHUjZVS3sK3CTIaKzHMBr2UXTsaQxtaUqIQPiEXHyyuzoYbhQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2MSBTYWx0ZWRfX1iNFdUPAnZeE T7g10nyEaQrYee17h1DyQnX9jyzDuJa7YpKt3Q57/aRbMQe298RKIsKyaBVR3b03gESZRpeoFQ/ saDLmr1lc47oRqt09uBQ390ZQfhVvpIRynnmwx/J4cSQLND5RkRhOA/ppvQwZoZ3GmtyCRM9BKG
 8SptuXLp5giKjSmClPekxhYhHwzjqGacP/YhQWMvDKu97hHg2slST1jMg3yz6RDzX4+4u+U2Deh eSvrpDj603Ciq7yMEl/FlBhWG8KhkfH64ZWdxGsHb6zcF0DHPJL9Cz/IXsWMxTSQ3AuypC0znES QA0TqaP+gurzyaW7Y5Hex8BKbZVkvl7BGpNwkvxLenySLKGHfMr/DUNZ6lIHkpRW+HBPwpC3L1j
 4ilZJGILOuX4cSDUl1yYSdRC4feJVB+4E56SRuE4Bpo4MmG9IsV81/R5hSyvOky0083txGU/
X-Authority-Analysis: v=2.4 cv=Z8XsHGRA c=1 sm=1 tr=0 ts=682c2f97 cx=c_pps a=c8UlD/aNTkVRGuk1JCy5IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=ejepizUdJjaCFj8ohFIA:9 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: xDsnHqlwHUBLKVwAvZxyZq3tzxKkF8CZ
X-Proofpoint-GUID: xDsnHqlwHUBLKVwAvZxyZq3tzxKkF8CZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200061

From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

[ Upstream commit 1f77c05408c96bc0b58ae476a9cadc9e5b9cfd0f ]

This fixes a kernel panic seen during release FW in a stress test
scenario where WLAN and BT FW download occurs simultaneously, and due to
a HW bug, chip sends out only 1 bootloader signatures.

When driver receives the bootloader signature, it enters FW download
mode, but since no consequtive bootloader signatures seen, FW file is
not requested.

After 60 seconds, when FW download times out, release_firmware causes a
kernel panic.

[ 2601.949184] Unable to handle kernel paging request at virtual address 0000312e6f006573
[ 2601.992076] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000111802000
[ 2601.992080] [0000312e6f006573] pgd=0000000000000000, p4d=0000000000000000
[ 2601.992087] Internal error: Oops: 0000000096000021 [#1] PREEMPT SMP
[ 2601.992091] Modules linked in: algif_hash algif_skcipher af_alg btnxpuart(O) pciexxx(O) mlan(O) overlay fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine authenc libdes crct10dif_ce polyval_ce snd_soc_fsl_easrc snd_soc_fsl_asoc_card imx8_media_dev(C) snd_soc_fsl_micfil polyval_generic snd_soc_fsl_xcvr snd_soc_fsl_sai snd_soc_imx_audmux snd_soc_fsl_asrc snd_soc_imx_card snd_soc_imx_hdmi snd_soc_fsl_aud2htx snd_soc_fsl_utils imx_pcm_dma dw_hdmi_cec flexcan can_dev
[ 2602.001825] CPU: 2 PID: 20060 Comm: hciconfig Tainted: G         C O       6.6.23-lts-next-06236-gb586a521770e #1
[ 2602.010182] Hardware name: NXP i.MX8MPlus EVK board (DT)
[ 2602.010185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2602.010191] pc : _raw_spin_lock+0x34/0x68
[ 2602.010201] lr : free_fw_priv+0x20/0xfc
[ 2602.020561] sp : ffff800089363b30
[ 2602.020563] x29: ffff800089363b30 x28: ffff0000d0eb5880 x27: 0000000000000000
[ 2602.020570] x26: 0000000000000000 x25: ffff0000d728b330 x24: 0000000000000000
[ 2602.020577] x23: ffff0000dc856f38
[ 2602.033797] x22: ffff800089363b70 x21: ffff0000dc856000
[ 2602.033802] x20: ff00312e6f006573 x19: ffff0000d0d9ea80 x18: 0000000000000000
[ 2602.033809] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaad80dd480
[ 2602.083320] x14: 0000000000000000 x13: 00000000000001b9 x12: 0000000000000002
[ 2602.083326] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff800089363a30
[ 2602.083333] x8 : ffff0001793d75c0 x7 : ffff0000d6dbc400 x6 : 0000000000000000
[ 2602.083339] x5 : 00000000410fd030 x4 : 0000000000000000 x3 : 0000000000000001
[ 2602.083346] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ff00312e6f006573
[ 2602.083354] Call trace:
[ 2602.083356]  _raw_spin_lock+0x34/0x68
[ 2602.083364]  release_firmware+0x48/0x6c
[ 2602.083370]  nxp_setup+0x3c4/0x540 [btnxpuart]
[ 2602.083383]  hci_dev_open_sync+0xf0/0xa34
[ 2602.083391]  hci_dev_open+0xd8/0x178
[ 2602.083399]  hci_sock_ioctl+0x3b0/0x590
[ 2602.083405]  sock_do_ioctl+0x60/0x118
[ 2602.083413]  sock_ioctl+0x2f4/0x374
[ 2602.091430]  __arm64_sys_ioctl+0xac/0xf0
[ 2602.091437]  invoke_syscall+0x48/0x110
[ 2602.091445]  el0_svc_common.constprop.0+0xc0/0xe0
[ 2602.091452]  do_el0_svc+0x1c/0x28
[ 2602.091457]  el0_svc+0x40/0xe4
[ 2602.091465]  el0t_64_sync_handler+0x120/0x12c
[ 2602.091470]  el0t_64_sync+0x190/0x194

Fixes: e3c4891098c8 ("Bluetooth: btnxpuart: Handle FW Download Abort scenario")
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/bluetooth/btnxpuart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 84a1ad61c4ad..56b875a6b1fb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -612,8 +612,10 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 							 &nxpdev->tx_state),
 					       msecs_to_jiffies(60000));
 
-	release_firmware(nxpdev->fw);
-	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	if (nxpdev->fw && strlen(nxpdev->fw_name)) {
+		release_firmware(nxpdev->fw);
+		memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
+	}
 
 	if (err == 0) {
 		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
-- 
2.34.1



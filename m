Return-Path: <stable+bounces-93888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87A9D1DF3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C9DB20B54
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 02:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB4136345;
	Tue, 19 Nov 2024 02:05:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E58537F8
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981953; cv=fail; b=MACXdB2vcqBDmpVt/nYqcX1fRTLxMOLrjs4E/7h1oRCv0CYPRab0wE8UNqIjSERWkOTq2BsfMKQ7+/r6ztDEO9xChGyTcNEUaxezYHVtaCgoN7STKWN8cql6/rUtq2R/ohLSq7z50EFRZcdid20eonJWZlH0Eft1Ez5uG5/rM/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981953; c=relaxed/simple;
	bh=lhko3whu3HV2ZP533fuevLJjKEIb0918d4LZB1+p+sw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZCTz/cLdZ6HGPCGBAW08uMCKMptCpgtMGMZQjNO17tCc0iSDEPKuzsdwNBG1eZyvqmx44In+wMdenup3inHXWEFDKb7HCqwi0JfIqltdOBQMZN0dSi8MiOqsDObvxxjGwW+sfp+w4ELQtrqZPAliwdlbe+0QeAtWKM5m/AGHEJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ0LZrW017413;
	Tue, 19 Nov 2024 02:05:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xgm0jkdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 02:05:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmHFtdJS13ZIy0oA6tVpgIN6pw2eDmTHazhBuBjkKX+7RLUV/7dwv//BZ1UbejxykqqmUrWzBiBwOzhURuqFgvdOykkGZGJh7UznM9j9eOAN0gLge1WEA7SbR80/HC89PIrHoBy2NXuG/EMBA4psVJe0mz7FeLuGPUvkhBkAR0a0vOv0kwiIsGLRDj+oOqxQCEUbqRfi8Uc9/kyIMS6dRf8Tzuj6IoVKCi7ul+VzR7UysjdtBovvG2b5YNEwkCZ2friD0NDHEUAlQ4MEvqRPjRff5uFgQdSmX4wQT31wpH/4m2HI30nXwkIn8/CsMssOhV2XoayYaD9+GdmxKVgZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJohDOL+32oIvDRJqqYe04YoI4VTBdOoKyPefdbqmFM=;
 b=g7rQ5WaoCOmbXcYmuAuearvZ8XEX6WL1GIPpxLBkPzON2+7hl7U5tYVE3+rOHYbIfPH3L1iV61e6bBNjLGBzgSBatXB9MoAzQ9jDjujjYJVN/BI1fYALyucwP6oN50aHMrK8FXk7Am7IS9DJxP7kbBbgDhjpEanHzzQAUwabDsd/kHvVoSTqwXuppEsV7IRuFW7PXNuVOmL94HoSy+wS8aLV4QTHOailISaBKGFJj4cdlhomkm0g1ACU8hhQC5+dDfLndpOiLEgM9VMrXQEC5BK5Cl8QfnSaLJjGVAplQsBgXzpfx6eES5xvf32VCvvSqEFqYD9FrwtWlkaALlvfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 02:05:37 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:05:36 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 0/2] Backport fix of CVE-2024-36915 to 6.1
Date: Tue, 19 Nov 2024 10:05:35 +0800
Message-ID: <20241119020537.3050784-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::15) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 24cd2c5d-7dea-4169-b45b-08dd083ea84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfEJ8V3CSR/STZnEU3Dj84aDCVNS6zmYaTjhCy0MNVl5hdMz+H0ghJAgkkUb?=
 =?us-ascii?Q?fdpF6rNaZid+rWfirqtGwXiYHgT7pPz97HPyE8CMYCpUchCaV5LZ1t0e93BB?=
 =?us-ascii?Q?yxWPxFVELMbOnBmO8jkjHILz+ZOd1ZY7xyc5rqpNcWb3JZHsX/zUW4/4XjDd?=
 =?us-ascii?Q?u50pK7FxvRNluuDx6ww6QVOuIKyqSodLMMze9lmautzzyEphb8j78IauyjWY?=
 =?us-ascii?Q?u3TyBoLTSQr19TeqHdTgZ5hZ4hYr/cHyOfSc2Tuu7JMqj1o/5Ufpy+6KeHhZ?=
 =?us-ascii?Q?rNflouWCOANDuhBaUk4w+wmaPxUMgTjmSgcSNmTPVy16i6CAvim1iy5vctFW?=
 =?us-ascii?Q?6TEgsWUNI+Dd7bXDH2CjFCUPxBGH38fcPZAlt1Xw9wGZCr/j6IOkWHgDLLMH?=
 =?us-ascii?Q?6YOSdyoYiTcVdRPgAjIomniyXfXnaXUs1e//rF1+6syG6GkzOjO5WnrcJo4M?=
 =?us-ascii?Q?MgRM7PT+RI7azKwrSuxJT6rYUm5cFBq6CpcPFLU/aLHycHlh0gcVcg2UwB6A?=
 =?us-ascii?Q?G/ldVZhlGYqTE5hB9iMlzknrEyX+rT5lu0R7oOAtoXSF6GzjtCA14777D7U1?=
 =?us-ascii?Q?3tyimZo1kcEFqFH7z7zB2Qa0Kwt3O8sGVHPVtV5uEL5/QlXbiYlpK4HKGGU2?=
 =?us-ascii?Q?i0/yzRFqe5Pi5wfMoaAfnrhO8t1iAx9HIkMVJ8o4mJqN8yWHBf0XO+234dab?=
 =?us-ascii?Q?fS3Tcstz0e7PNQQ4niB5gCcp0hiNYxe4t9RSRONGbUf5rsJ96Y78Ip+8zyGh?=
 =?us-ascii?Q?BFfC9dSHG7a0AG7o1x8hKA/YTUK8exEF+xtcKQHGfJrEuCkP4Q5QWBou3FG7?=
 =?us-ascii?Q?knpuTTqPOxeS7rkqWlTIfsM/oO04cSWQWbgOVIQiLkiUZw1BcsOC0Qutdsct?=
 =?us-ascii?Q?/GnW+fww0Rf98dflhJjxDZAc5pelhHduYMzQtHinPi5ft4174em4ZFqhhost?=
 =?us-ascii?Q?kEu8zUP0lDbOJ3Qmw+sWNjnyyIYkQqKgGr9Zgh3DxH+rqyL+xDG4f+tDPRVv?=
 =?us-ascii?Q?gWxqA+1zHepfAa+W+BMMC4vepTsI9E0noeSDkM8+3FTuY0aD/umXXPrwE5U6?=
 =?us-ascii?Q?jwxjeBldcpH2mxYR9euUw62UltHFYsSHmJ465+24FiskjB5/61z+5H73Uuvw?=
 =?us-ascii?Q?74N4A4BAjFsnpfRiU50mL8AGzqX6XDe2RIClQTeNa3FYRdgoLgUoEDq99v1T?=
 =?us-ascii?Q?X86H0Mrjzr2fZVkTaPcgHenK+lJ23TPVrIfZJL5rmeDo4d7wYFjQDqh2uqtr?=
 =?us-ascii?Q?b/mQqwuC6bSRhtEqmtjuBXfpTGxbOhDs/TU+8TDCtqbf7+063Iem/PWvyLma?=
 =?us-ascii?Q?Wj8LCadjMpKKMDG1GM7n8afcwMmW39BLTUx1F/4yTmrcB7D2f3yfpiftXn8Z?=
 =?us-ascii?Q?IAWJaaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1k5YziCjOJGpjWgcLqyuFrzr+tvjo1fp85/SAyrJrDN5Y/NbrgNoh/AumZe?=
 =?us-ascii?Q?XTKfD3azZUazIOxvsYAx6MVrTKK+v78OTvqF2sGBh5QsLJxAwl+9D2xhpd2W?=
 =?us-ascii?Q?pWfFKUGvdM1bNwV69Z/37JZXRkqDSjdx/StK5bVWSDo1C/f+1p/UUpSlW4ni?=
 =?us-ascii?Q?0QJAu2zbA8cksXNE4eXObC2xW8113XqswmLFd470fE1ms4oroOp4CFinYfdX?=
 =?us-ascii?Q?UdJ/t42gAv/9qu1mi7ZtYIBT573vXrL4SnmS22e2kHRZ1tiKDKRv8cyOe+a+?=
 =?us-ascii?Q?DQpZ5D2uEVbPHoW2u+EK04CRazEENn7Q96Sj0Mgp6GW1MCKY1a0gJlBnWrVU?=
 =?us-ascii?Q?oEwXAYw8sPv8RMrzocXOTFZmxqjtfECr3QE+8crsEQUP1SIBXP12bp7jzLAI?=
 =?us-ascii?Q?XBxRonkRRFENO5FALsFd/6thLkOGXDNfZ+zPpd8YsHzPvmoRi8lsHaIwk5fw?=
 =?us-ascii?Q?cq9sMZeKTK9xdJ3kI0N5jVvz/WLJDSu9z7OGxUbSMBZBKApCtdDqVzLSCisv?=
 =?us-ascii?Q?xRM7J7NonbVcikB/41vAbskbdy9SkglqiuV2k672up0iX48GVAPEFqI8Cf6I?=
 =?us-ascii?Q?lVlpM0wPN3BW9DZyZDCoMXzGqBMPTBWOaOYPAEbbt7gO3oezKPCORbsTzITS?=
 =?us-ascii?Q?LCyhTNw97aaKtweFmV2IAROVgOcYWQhRLi1FzxAj5zP/PIlj+011DQlIb4KH?=
 =?us-ascii?Q?Zh5G8HTedcraWgpYWFQSNmE9MXZwqmP4OViwMrFuDblnKJB0yUGsiKUhSsMj?=
 =?us-ascii?Q?ooc5CJEBEVkDQQHatE1eDvO+IC5lT93rp+jwDlA3MPITNgLPeM7dluDqYK3j?=
 =?us-ascii?Q?SavC8lnnLkyjr7nwZijOOMYqAU2PURmt+sdA4PrjingMMpzveasQZ7hYBYDr?=
 =?us-ascii?Q?3LJhyqI74RZq1KTuKSxf6dPcLZT0EQrw+hrVJgzUS4sEMi8LR4gnSnr/G1y4?=
 =?us-ascii?Q?uimUnOz9OvoTfFiBSKHLjVIfTfLQOJ2sMsgV7MZtDewl4EaDVQpL1/W10pz2?=
 =?us-ascii?Q?xljlEbd1NmUaJvs8p1PYph9Yt0TMxdNb/JSKXAD4ds3/r40sZKcd65HFG/LQ?=
 =?us-ascii?Q?bo8OA5o9/cpBI9OF/MiwBIQdaORpm9yFqmPh7csD+VTtUqx9zKwyoYrMxthy?=
 =?us-ascii?Q?n9ZjYUISO58qApcIOmUbCwhH9/NtU2akFTll2n2s+uQnl1Gp3gmS6E+UugsS?=
 =?us-ascii?Q?63htPI/5rZyR+JDTkzscXVWC47v1VK57Lb8nylRZ5yLJK1Jy7c6PDkN/O5Iu?=
 =?us-ascii?Q?NYsaY2QvvXFusvPcS9AVqvhm4eq4XwFp5axBja8DPjz3p5Zl2MX79yxQmnVc?=
 =?us-ascii?Q?NoM6y+pgERPSYo7EY+XWu+YPyt9JKfTeEWbUdi7MP3bRS4j2pvyMuVEoPrtc?=
 =?us-ascii?Q?7AGfSFsUhBDrLFaV2IaN7eRAToBy4N+HC9p+QmVQevVwgiqXB6upJymltCBa?=
 =?us-ascii?Q?yjECEj8xYvwKKgOkba6+HLmkR99Bj9hruDLTLGxJ5L4M8SNqgUyNteyFyZ4E?=
 =?us-ascii?Q?Y9aNYOE+vILX34ljLqhgJWVIDHMwMuRS9VahytI/VoUcX17vtvoybE+IcndL?=
 =?us-ascii?Q?F5RExJfiFyG/JA1utWg+wpGyIiSvJvq7SpfD8JNYZMII1Ll6kxWopLELrAra?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cd2c5d-7dea-4169-b45b-08dd083ea84a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:05:36.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSyyC5wmGpMPTfmqYg1rYIxBDAKhBWP+PyzU9pcNXwzKhCg9bEgQdnaEKVXlLa1yilI2RsyrFO719FRp1FkLI6n71LofUkUPw+B0a2jfjcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-Proofpoint-ORIG-GUID: M1h--qLB7VFCzupuIuDtiJxGeHBufVu8
X-Proofpoint-GUID: M1h--qLB7VFCzupuIuDtiJxGeHBufVu8
X-Authority-Analysis: v=2.4 cv=E4efprdl c=1 sm=1 tr=0 ts=673bf274 cx=c_pps a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=_bMs6Q3VZnzGop1yXtcA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 mlxlogscore=583 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190017

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Following series is a backport of CVE-2024-36915

The fix is "nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies"
This required 1 extra commit to make sure the picks are clean:
net: add copy_safe_from_sockptr() helper


Eric Dumazet (2):
  net: add copy_safe_from_sockptr() helper
  nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

 include/linux/sockptr.h | 25 +++++++++++++++++++++++++
 net/nfc/llcp_sock.c     | 12 ++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

-- 
2.43.0



Return-Path: <stable+bounces-95342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8BA9D7B47
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8123D162EB7
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 05:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471E13CFA6;
	Mon, 25 Nov 2024 05:38:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4754765
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513103; cv=fail; b=AQyk7uqpB+gaeYEPC+ZtGyDCkZrguAlHKmzin0+TWnBOdWgkMXCDY/Z6mEAnmnYAaotF9rHcBIEML/Z9e2EMAKLIn4uMC7YtwK1Ht6zFsoZX5Arzizu4P0i0tjPOX0uTe72iKlc8gH2HVGr3ueLERwIm/vtr4vNLT+qfY+bsBzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513103; c=relaxed/simple;
	bh=LEf7ZCZ8SEUFUNe7M683XtiQsuHK4cDuJlbJzzRWMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvf9LUmdj4VZJromnxKKCV8kfvWT5C+VzivU29ye/l8glST8EN/nUBZSHoeQuijo6v7zOpb7QruG71jMU5H7YYlLeKAxnf/T+rdmYQMtU+gt24i8Nyudmke9+O75mheY3zp74etX4Am3Id/WGLwoeSZokEBscHfU9qv+gjXs1TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP40lrS024079;
	Mon, 25 Nov 2024 05:38:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4336189mgy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:38:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJiQNTG8zLryZUXAXUDYTtbNS1y1b3Iu1wnQ6GC+M9eieh1pjJYbXYIorDloAJLHGXhbzfxc9gAU4RG4dEsjsy7ZYYeAcDx0/bMTftBDazPGn6y6P0fjqH9wn3xTbQsaFPAT8F/l1pZfYTcZbuOFcAIxoRQ4OCKiEA/ueUFkMWGJCUTySmgjP5fgP2M7+gPbVT5XMJcxLidbBYwMoX9hRxFZMSgg+btCclcr/3Qv5k6DkAiisCtX7Q1mqStq8TBElBE19zQGhci3a1gcnb2osfchC8+OYXeypn0KwIe8qF+KppYWXvWdqnjh/KL+LU/RHVXJtG7Zne1xr7iR2g+lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3IQBzuBcWD5B57N/iiwHl32/2+3QGyhEMrfGb6TsRY=;
 b=WoqpG9Tz8W7/4bmLvbN5rbPiBg+w5EnFDAXA6nmlOJbA9rh+KXKH2xbDnklNA8FwwH6Gcp3ddpjaxYfFjr9ccSefXJhTz3XIVIOoTwqNBY6yHilg5o9ArSx64rmVjC6UtLbeFTcTkyPsiAEOQym8js3K2wmk47a/OE6RJTLxtVbuI0ZYfgM+QQRE55icUQ7Rxtg4BwJ9XoOQxNymJVwGudoBxg66Sm2N+Ntgbz32bXR8SIBJTSwQufQd+bK8qC85S5IpBlRqv2hN5nTfP38HvL+52NHg5GGSNXRb2a4Xn15SqiICkjQRn83ccIdKqtA9bcB57Xgy6GMR/B1aC4Vi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 05:38:12 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.024; Mon, 25 Nov 2024
 05:38:12 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: marpagan@redhat.com, yilun.xu@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1 2/2] fpga: manager: add owner module and take its refcount
Date: Mon, 25 Nov 2024 13:38:16 +0800
Message-ID: <20241125053816.1914594-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125053816.1914594-1-xiangyu.chen@eng.windriver.com>
References: <20241125053816.1914594-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0340.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: e905760d-b54e-4456-e2bc-08dd0d1359dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRyF8AgFQJin6CBdxqeAqTuc4VEEI/AHK+OYlEg53wBVdRvAuz0GMWq7PzI/?=
 =?us-ascii?Q?jyguw1eBQq202+dUn1E04/BlOR5LOfDf9NnEFXi1c4Zai4RXvy0CMwmWHEQ2?=
 =?us-ascii?Q?yOdujERzu46o+NO+U/MQacmo7x3ELzam28e0KDDiYa/t0bV0tj9AtsK5AbTX?=
 =?us-ascii?Q?ULAGFxTV6AXDE0COEua76Gj5QgIuQd1pRNyQrD0/NT5l72vpJAiw5YkaJSkp?=
 =?us-ascii?Q?yLyha85f1nhrIZWRj3ywTJ7vSDkvIfWDolmF0A/tjL3dWy/6kzI/DlfnwDcO?=
 =?us-ascii?Q?HfGp8MvTQVNE62t5+LQ0vWhsP/1Pw9ouQ5pgOZ0En0cHHl5atYSKom1tFQLx?=
 =?us-ascii?Q?sh2Rke/yKMYoTOjv+XFth+4w3xLIKnWtOOHYCZdCycHhv6KFrctt+xq7vDyE?=
 =?us-ascii?Q?uN9h85VcbIzkWvPm9VhHOQdRvrhslPCOTJZ0Q/zslaXnzd7YqQRHKNcps8Ws?=
 =?us-ascii?Q?uOFoWZk8cOWLqyetJR+NnFWG8JabvoKURwCU4ffJuMW8ug6AEzyNi0drztj/?=
 =?us-ascii?Q?6Q5Bh9rgndHMLvMD+x2Nxq3fpZOF/clxmWxkjU8Yf8Htvf62OQHjmkz3Rnlx?=
 =?us-ascii?Q?DHHmssJw081c9U0V8rMuwrXc1cJ2hkymbSjLv4sYlf8nSyeG4Uq3/JG60hlu?=
 =?us-ascii?Q?BLXF5pQyh21sBxqdSbBV1sjcJyeI1VmKZBnuW70o1prubGSTCiQ++sTsj51M?=
 =?us-ascii?Q?l5s1PNZay6DsKsfgV53BcQEJobdS94X54a9uunim7m+rTv0Lh3WdHIWnvs6j?=
 =?us-ascii?Q?kZbuHKTUzl93RwEBRrTN4UVsykeS2BX7oC9LArUT0Pro2xkw4eNuyYyFL24Z?=
 =?us-ascii?Q?/2Op7DPRogCqlBOGHpEwZ+EDXkgnDf51jXT/xdD9f24f58l/EONSg8jttca+?=
 =?us-ascii?Q?c7Y9jXIPkkfHV/8tvJWx51dPE9l0WBrEZWfqBOnBUDZR2VEXo2zIf0vZ8gB8?=
 =?us-ascii?Q?SqF2IPT/wEdEXEuONZqcK8pg+pCwqWf6DWhc4/g+U2+igW4uiTP14fopQYZl?=
 =?us-ascii?Q?n9+QYbaqjS/XawgD3uF3mj3LLHjhN7VbdLY5wzNiaDvy+rdXKs0wLf8kEXn9?=
 =?us-ascii?Q?3WaC8OKl28fU/lDpIqVnXJoId57TlSp1fF4+N5hNVQ3JEXjd0VwhPrKHFaCN?=
 =?us-ascii?Q?DdVenoWhKg7uOq2QhFZKVr3LYVOTjyJ6K0UNvgVM/BkwIHZxaQoJAQZSUmVf?=
 =?us-ascii?Q?O5gGgf43+H7OmN4zzCNJWzKtCpGd27is5B9IzgYeh7RaM4bjfLCmo9Wyw0wG?=
 =?us-ascii?Q?mgA/A4/O/rrral02c5qOmJspwYA4PbKXfF242zNetKWEPh4xJMC8+bPdantm?=
 =?us-ascii?Q?JCsFZhWl+CW1Cz9yxZ75jCmQ+KRWzRzXRJLlSKQs1JSORCsxFer7grxemtyP?=
 =?us-ascii?Q?OzpmHkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fc5+xKMaZzMLeZjkPfv+u+Pbiqiyrufu7knyP5jgdXBN8PoVkaqCqRO3q34?=
 =?us-ascii?Q?W1R+4DlsdzRDGhH7UaDulhlbOJyydeHTM086jSBY3CVjjgiQb8qGePnpSYZP?=
 =?us-ascii?Q?9nNqocCdsPoHUgMOszVtjxmGkWfd+aGVx37OOJDPv0VVUWZqEH14iCfWACnS?=
 =?us-ascii?Q?oFah9rDu3IoXR2JBaZBtwzyDASLyMIHn6O0RCL0mnpQPUmIP96ymlaUfoyHq?=
 =?us-ascii?Q?vclVXgcsPmx1ltRdHB/pZT5r1ww2zU5a3YFRauYka650ajH6osnXB6ON7scS?=
 =?us-ascii?Q?rJ4B3Ona763MfIROZfq3PZQPkKxfiZg55Dr8RWxlWJPEQvfARzUyiEcaQy6U?=
 =?us-ascii?Q?ZPzFz1qMvz7Y6tGZ81hWBhqCRtZ0b/bJUcfq3e96U7m2+U/yJ7ZxcChxUFyP?=
 =?us-ascii?Q?q4W2dZ9q7Z6xPXNSPopY6FJPpsvkvRHINbKCtTBX4n3JJA6YY6VdUt+Jwvq4?=
 =?us-ascii?Q?Spk7xJgf7tE40E9GY0UI0N6R+iZ9T/8k7f9h8Tk9utXLZkqi6+astoIoQdl7?=
 =?us-ascii?Q?T7gh/bi4deCoBxkggeH5nj9iqJocGZfHXjgiCkQ7qESP+d/nyhc2N2hZm8c0?=
 =?us-ascii?Q?LYHAYlIys9dN+MGFzIrCn+3UEV+5nHj4erP6OhbsK661pYoHLq7Ilz2lfJNl?=
 =?us-ascii?Q?8Z7WWgOHzQ0rj/+OyakbPJ6M+F7VV4UW0YG10yIg2VfAqGJSYwfnliHpqAAI?=
 =?us-ascii?Q?tNocs5d85weaUY7Q+PtzWf5YHpfLws+Vz0Xotz2Yyl8kEQTatyzK72Z7xuZL?=
 =?us-ascii?Q?SgmifAxqDMi1jCROnTUM6lkxHUG8fGxbppHRE964ZEoDe2Ji9whKvN62DAdd?=
 =?us-ascii?Q?GRblv6p+37RE1CJO/VjUOSX3XwlyOi5G8WK/3iUkIphjQfxHijlNbjLG5DhW?=
 =?us-ascii?Q?+KN3ZA6ZwWtODOSiX4bAkv6cGX2MIi15mrrLjC6gIZ72c7CiJvOx+czZ/Qpt?=
 =?us-ascii?Q?p/7joACPVpOCkuRzOInVAf6BBhCErRDOScwAcz0dKDpmjsbZPn7BzrR0ptE9?=
 =?us-ascii?Q?i15QpsvI8XtrxU0tudMwVt8eGuuQjvVGwHDkSssNnFDqZb8tDBqYTXRgRtJ4?=
 =?us-ascii?Q?gp18iy7cvSAZF52vU5HHJsqCaN2SmUA/7x8Cj1zdBKgVeiAtTarMEAqF6wGK?=
 =?us-ascii?Q?/nguYkqJ4Ij7n8Qu885CY/B+e0m2P4uH0KPcxyRWTTr7v4nF7Gy1wa5dNMcL?=
 =?us-ascii?Q?uredh/GuWaqKd21zdxYdCXMlap5Pp1rtOUnThzAAjHdmJw2xuH2dvJA+ZwiE?=
 =?us-ascii?Q?vJwbH2/ybKYTzoHSRekszfk0N5aSqjnnZZPNMrtw8j+V8RhLp1h+n38eh7YG?=
 =?us-ascii?Q?RXHGSUQO+lxLPhN+NktR5cy2XjSmmvmttld/yxJ9UdQIrhgHtxQgIGUomf6J?=
 =?us-ascii?Q?FKZdeE31dqGOKIt10GyY1neJ5TOu6qbuM2dnQ2CQVqoeGlFUN1V/GwXKBSr9?=
 =?us-ascii?Q?jPgTykms8tNmnrqSl4opeAyOKYmNCXgjmig+BI20jG1/3xETcoS1ODwc6OKX?=
 =?us-ascii?Q?9SoqdwWjVgkmfgdJ+cY0SpS5+pEgfV8ZZ8Sr5uDVb0xmFQXo9lJ2I7YzbQ0a?=
 =?us-ascii?Q?BhCAo6rWT70f0AgF87mv9ejCj3H3uN0vws8ORIXfS9e6mwuVAr6gz0CWzZt+?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e905760d-b54e-4456-e2bc-08dd0d1359dd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 05:38:12.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ljq1E9G7mX6JuA3mlTrHXS4n2SUPevKsRxufX3+0g8w5WZsU575AYVokpHbp4+7Lz499ibmsnJVmIzjFDqM0JIofxTm93Ivr0NKHL3inuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-Proofpoint-ORIG-GUID: WD_SLhVuwJrJadBrdsCYNI6ZateFzBBk
X-Proofpoint-GUID: WD_SLhVuwJrJadBrdsCYNI6ZateFzBBk
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67440d46 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=taNDE3Rm5Uk9AQPKupkA:9 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-25_02,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411250046

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit 4d4d2d4346857bf778fafaa97d6f76bb1663e3c9 ]

The current implementation of the fpga manager assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the manager if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_manager
struct and use it to take the module's refcount. Modify the functions for
registering the manager to take an additional owner module parameter and
rename them to avoid conflicts. Use the old function names for helper
macros that automatically set the module that registers the manager as the
owner. This ensures compatibility with existing low-level control modules
and reduces the chances of registering a manager without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga manager.

Other changes: opportunistically move put_device() from __fpga_mgr_get() to
fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since the
manager device is taken in these functions.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20240305192926.84886-1-marpagan@redhat.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 34 +++++----
 drivers/fpga/fpga-mgr.c                    | 82 +++++++++++++---------
 include/linux/fpga/fpga-mgr.h              | 26 +++++--
 3 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 49c0a9512653..8d2b79f696c1 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,8 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
+probe function calls ``fpga_mgr_register()`` or ``fpga_mgr_register_full()``,
+such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -69,10 +70,11 @@ probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
 	}
 
 Alternatively, the probe function could call one of the resource managed
-register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
-When these functions are used, the parameter syntax is the same, but the call
-to fpga_mgr_unregister() should be removed. In the above example, the
-socfpga_fpga_remove() function would not be required.
+register functions, ``devm_fpga_mgr_register()`` or
+``devm_fpga_mgr_register_full()``.  When these functions are used, the
+parameter syntax is the same, but the call to ``fpga_mgr_unregister()`` should be
+removed. In the above example, the ``socfpga_fpga_remove()`` function would not be
+required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -125,15 +127,19 @@ API for implementing a new FPGA Manager driver
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
 * struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
-* fpga_mgr_register_full() -  Create and register an FPGA manager using the
+* __fpga_mgr_register_full() -  Create and register an FPGA manager using the
   fpga_mgr_info structure to provide the full flexibility of options
-* fpga_mgr_register() -  Create and register an FPGA manager using standard
+* __fpga_mgr_register() -  Create and register an FPGA manager using standard
   arguments
-* devm_fpga_mgr_register_full() -  Resource managed version of
-  fpga_mgr_register_full()
-* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
+* __devm_fpga_mgr_register_full() -  Resource managed version of
+  __fpga_mgr_register_full()
+* __devm_fpga_mgr_register() -  Resource managed version of __fpga_mgr_register()
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
+Helper macros ``fpga_mgr_register_full()``, ``fpga_mgr_register()``,
+``devm_fpga_mgr_register_full()``, and ``devm_fpga_mgr_register()`` are available
+to ease the registration.
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
 
@@ -147,16 +153,16 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register_full
+   :functions: __fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: __fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register_full
+   :functions: __devm_fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register
+   :functions: __devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 8efa67620e21..0c71d91ba7f6 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -664,20 +664,16 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
-static struct fpga_manager *__fpga_mgr_get(struct device *dev)
+static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
 {
 	struct fpga_manager *mgr;
 
-	mgr = to_fpga_manager(dev);
+	mgr = to_fpga_manager(mgr_dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	if (!try_module_get(mgr->mops_owner))
+		mgr = ERR_PTR(-ENODEV);
 
 	return mgr;
-
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +689,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
+
+	mgr_dev = class_find_device(fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(mgr_dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +713,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
 
-	dev = class_find_device_by_of_node(fpga_mgr_class, node);
-	if (!dev)
+	mgr_dev = class_find_device_by_of_node(fpga_mgr_class, node);
+	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +734,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->mops_owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -766,9 +773,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_register_full - create and register an FPGA Manager device
+ * __fpga_mgr_register_full - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register_full() instead is recommended.
@@ -776,7 +784,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner)
 {
 	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
@@ -804,6 +813,8 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	mutex_init(&mgr->ref_mutex);
 
+	mgr->mops_owner = owner;
+
 	mgr->name = info->name;
 	mgr->mops = info->mops;
 	mgr->priv = info->priv;
@@ -841,14 +852,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
 
 /**
- * fpga_mgr_register - create and register an FPGA Manager device
+ * __fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register() instead is recommended. This simple
@@ -859,8 +871,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv)
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -868,9 +880,9 @@ fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return fpga_mgr_register_full(parent, &info);
+	return __fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register);
 
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
@@ -900,9 +912,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -910,7 +923,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * function will be called automatically when the managing device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner)
 {
 	struct fpga_mgr_devres *dr;
 	struct fpga_manager *mgr;
@@ -919,7 +933,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	mgr = fpga_mgr_register_full(parent, info);
+	mgr = __fpga_mgr_register_full(parent, info, owner);
 	if (IS_ERR(mgr)) {
 		devres_free(dr);
 		return mgr;
@@ -930,14 +944,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 
 	return mgr;
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
 
 /**
- * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -946,8 +961,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv)
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -955,9 +971,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return devm_fpga_mgr_register_full(parent, &info);
+	return __devm_fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..0d4fe068f3d8 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -201,6 +201,7 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @mops_owner: module containing the mops
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -210,6 +211,7 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
+	struct module *mops_owner;
 	void *priv;
 };
 
@@ -230,18 +232,30 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
+#define fpga_mgr_register_full(parent, info) \
+	__fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner);
 
+#define fpga_mgr_register(parent, name, mops, priv) \
+	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv);
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
+
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+#define devm_fpga_mgr_register_full(parent, info) \
+	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner);
+#define devm_fpga_mgr_register(parent, name, mops, priv) \
+	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv);
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.43.0



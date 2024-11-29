Return-Path: <stable+bounces-95780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9AE9DBFBB
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 08:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC72163E8D
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4607156F20;
	Fri, 29 Nov 2024 07:23:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FF45C14
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865014; cv=fail; b=Fy+fup/yjDsSAihq1lS9oIO6ZJzcq5gIaMgn3qgBFbLIcAjPN0HyVC3HEHrcsQylgCYinyT+FGIEVNZlg0GjBNFkZ8przrrLkyG1tLFY0GQpAH6xtOea7gAH7MuMQBSrP0MZ/l0n941uqcbZ3f2VjRJQivq8/2Cxgo5c/B9uY2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865014; c=relaxed/simple;
	bh=+uiTCHfMF/9+1Uq3Lug840+oYdAh0AZEMWXt53G8Pzs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lDavenyfI8lhTbtjsw3LfAzxeq2WfvoPTLgCdgOWWMtTp8IE0deEf9qaYCiMMGl4JSasb0vHb7C0BvNfzUGvQT4jbzvZZidnjbL1X0K10+6W3WZ6TVlP1qGoiH+b7gB1lkpZIDy/7gHjbUgdQRI16GVD+sjVAbPcpN+PLpiOcLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT7MEXi013053;
	Thu, 28 Nov 2024 23:23:28 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671c9sp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 23:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlcEL5LVkyXMmoHjiYWzPMl9YllOql03EW/DxZMI/FZF3XVzp3Nk+97RCPe9QM/NRCUurNPSjzeBrrt4cYOeE/eeBGJTmXmAstQoFRZQ/tKEaM4BAV3Sd0xMOrUFkZDmZVvEhoWRdoCauzPTeA4/nQ8h6dH8mhHEB0P5VSziyGqbAfGQ1suKDco4vps4iqXOC1Dx87THT+sHbtxdpexbt3uHInEeX5YzP7SY5zsPF7pH5VUurl/86Ux+lnAzVMQyLn4N1rECRsT8lDPu9+83IDmVi4JHQR15LfdiOlWmA7u8ep6UYJSnzNK0yoTrin4YE58Krx8Ls7+UpEMg3nIpyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Hu2LeymQpK/ICFPFVf2uuV/MB7ETKdKSHXTqImzs4=;
 b=YFONDB0dhJnZfYpZP/+QPvPxjWB0qRGnXsLfNr/t6j3007dNlUsV0inBkaC7/o25LjayIuPMWaxSd+kP5jLUbEVea/0ZZny3Tc2OHqqlNh2IoEBhiQ2F1FpgjzfobSKnnIrfoT/N6T35mjq1Tq+aWIo9zH4tYilAECK7PXcFB4m28n7RC0NqQQYtMLVRem6hl4EraqBlSBwkNjhntl9CSiKCupZ/st0WSJhBTzHtZ4ha5Wc+BR1CIK518NXkwel0JJa6D9VDNRnJN3K4yT6onukM3OGOj0/7WZfrR9paQigWBhqCeOLHpchsRxOHY/0o/oweDtsf6bb32vNtBF0rMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Fri, 29 Nov
 2024 07:23:23 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 07:23:21 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: boris@bur.io, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
Date: Fri, 29 Nov 2024 16:21:00 +0800
Message-Id: <20241129082100.981101-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::18) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1b1ba2-0497-49e9-571c-08dd1046b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C04WVNDTP4sdNBmZVqvG4VT0QovwMczxoUy25jFvErHRPPL8upMX6bfP77GU?=
 =?us-ascii?Q?Fz3d+pP0hY8wgpSIiSrY6WbiHyPG1RjieIrt1yJkkrKmBYKXSh3iHIfeYfyb?=
 =?us-ascii?Q?HkKozToBZs7tcQ+031CUTmKTCkQLOqTr2jBujhIV//sazBX6Ki8uiggwEeRk?=
 =?us-ascii?Q?ciIB3kYOf5OvFlHZVyo+I8qdu1ayOOkPIONCzgaanJG/8gd5CSQ+JgLy5WOf?=
 =?us-ascii?Q?i4/JbRWSnLOPYH521qE41j/0q2/KegNTuCX67CTtLC9if/C7lFzH7QKIkv1S?=
 =?us-ascii?Q?DiAJ15vw65YVyJ+TzePLMiqnyXQ7lKhS4RTaPcuHq8FvwX0aMOgUGh0hN6CB?=
 =?us-ascii?Q?79b/FRerbe3yPZrXb4Hic9wDTiGHnWfSEU8PL9fiuWpIvB/ytzD88oBAoDTV?=
 =?us-ascii?Q?FRfjW92+AgRQN0IRVRdVR0HF/PUTW6uEQnWa1DmPnlGW3i4PK31nHOr7+De3?=
 =?us-ascii?Q?PtGzdcPr0TeKjgjPQAOSlHEfHuQmhW6hw1aKLenrCypH9XbD8vxWjq2/WHsR?=
 =?us-ascii?Q?0Xf2qQ5Mt9EBWfFgHOa6puwzrqVz8iVYcHsLfyn74F14BRun9bDnLi2Sobky?=
 =?us-ascii?Q?PjAzowjpnKutxLElnlNQcPchWaAJM3nViJh/XAgkPnPMNSMuWTcxeS8r5vhE?=
 =?us-ascii?Q?1eUHByndkJlmLH2Y67vMY7Y7z54alRZg6uoXHBQ2V3Uge0iE5vNK+bBivMKJ?=
 =?us-ascii?Q?+wbLc6mCE4bODypfhIpKmpWfK2q5rLOn/4SfQbbcxKld0PPinw2pZUzaNvn1?=
 =?us-ascii?Q?jRBGt/ajRzBnRJ0btIqu5auPDwVzpIpeCqH9dE/bgOWznjKtmqDzPmC95fuj?=
 =?us-ascii?Q?sxry8I8fHP4eBMdZqfQLmQP3E+u/h/2HSn2XLBQOfVw/nq437snDL3Ccm83Q?=
 =?us-ascii?Q?Q1vBQI9tCfSUPTfKkDeASmef/mV9wIFFhe/Mw0H44fhn+y4c26Vey4X1X/04?=
 =?us-ascii?Q?OO2iPcbSat7eP6TlwmPGOszfXiClwydKLYdxxmqAsGzcJzbZKh8GcX9MwRNg?=
 =?us-ascii?Q?TtaRON4zCIXnu3gbvwWGGvk6FPqN7Ro8nqXqxlGDLJp0iPXQUVdTBBDXd+4V?=
 =?us-ascii?Q?zdwHTxbSL0YCoScY099Lk95eXfWO3/Itbo4QZ53wyejH+burrwvhA5FRNdE3?=
 =?us-ascii?Q?JWUMHZefZnVeT5FhqN5rIIq72j7UlaiZSAjXgyfsNzHfJl4qvbNZlgRNjGlF?=
 =?us-ascii?Q?oV1dEn+EVj9pHcSjlNSpT3zuQVNHWhiOVUNJFGD8AMYZYn8ab6dyPOtX9FgT?=
 =?us-ascii?Q?Jw4scDTKB4TW+9LxAHSH3gzFj6UBYwRp60IeVYeI1TivWOqQECDqa1qout7q?=
 =?us-ascii?Q?cIfDT70L/qC9BE5cb8/zRmF05+Fl54EXuoVkb/IHVHXjs9HYWHM/IR42Z2Gq?=
 =?us-ascii?Q?x/fU++QHtOfJLrMK4tflaY9Q0Karb2jgQwYE3lpCALW8Jz5WOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lCDT/5Mw1Gt7GPq19BFX/PZe0j2RJFN4C7ZKHB0ttQrsLkmNJY/oDNuG6mFE?=
 =?us-ascii?Q?NrYUfy6o8DbEJTx5jwJ8YIFPTRUZg0/vmpRDHpFFTLf/SrzZStPg1tgr5u+y?=
 =?us-ascii?Q?6Ow6H8/i4GxWCE4JAci7890dN1qxmnypAJ5rC5zC/wqwdBO2Oj2CKUsIa820?=
 =?us-ascii?Q?fxYcnV2rZU6WVtKuFGeSyo8A+12aSgEd9RX40f8LEoqb8b2XoxNHJjVFGvjn?=
 =?us-ascii?Q?voFkqXOPV4VwTBmkpxUD0g6uj0N8w2S1Ju3O73laSFHhk2uNjsA+mCNahktC?=
 =?us-ascii?Q?2IVI3kA8tJ4Ok7QkAHlxo+ghcKkd6vF5SGyBGsklnO36YFJBcyk4y60nd7//?=
 =?us-ascii?Q?nFKmSK3N5FpqWjZqMb7OtEc5sw5E+Yly3Yqs+MQxGd09zyIIdFqUw23ESACZ?=
 =?us-ascii?Q?CUNlOmSPdu+d895JKRznVpMHlyx9f+MIvoHbP4vfiqxhqIv9xvHoMaaDBXln?=
 =?us-ascii?Q?kw35eE5afh1IiwpAswX1R/8FETkdY2epe4ADOfa+8H21E7O0qQc7U0fKiju4?=
 =?us-ascii?Q?ioKzKEONNoN8QUObztrWsHl/xOpQnEMI5DzjqBVRRDfni7tad/Ue8ORhqlHT?=
 =?us-ascii?Q?2Wy4il6ENeCsiwYMuQ/FkvL4kmkgS/jIMoKUCIryCQzlX3hQxa/fhuIBMMWd?=
 =?us-ascii?Q?NA+ia1BuBXpYRHEQBGfMoPv2dQkFoKVkuwBpdE0bfJhrO2Tg52MFrp8GjuDM?=
 =?us-ascii?Q?/7XFV+FU886CZV/W+Dg5jjldPOmUsgbV50CrSAZdplNxhZB8cV/zN+cWPSF+?=
 =?us-ascii?Q?UhkqR/XXUwuMTlWgq0QKIVpvAtpZMTBkC72x7JE9C9Bs8KrTCPteuuhDml72?=
 =?us-ascii?Q?oEsMWcljpKO0OoyWJiQMo30uozU4nHA4GTab7D9dbSPYHZZ4ihkz3lHDjqBD?=
 =?us-ascii?Q?DzZZoSt9MdTo1SPP/6iAfwUejyxT/Z7Eqc6fS11b9Z9E0wML7kUSstNAB0dl?=
 =?us-ascii?Q?BdMvP++UCBMfsr3HE5fOxzglM+0OcWlaBoJGDR3omsVX+qOhg4rIpLjoCoWq?=
 =?us-ascii?Q?t6m/TBNbi6GdiKJ6AfBOkBfg0H06uQajwxq0SHHM7Clk9+iS08FYzrGTcDCm?=
 =?us-ascii?Q?EsIyObanRo+X/O8iUfcdva8Qek6a+ywcsT4r2JAt3lV7rzbDTb/aP9ZrVRaW?=
 =?us-ascii?Q?1Dil2jYZqDAccIzFlRk3G5AaArrhlp9VjiadiXt+0QDsmmuh0YmL3+IDR15t?=
 =?us-ascii?Q?QPcpI2v/86qZSMZZpFrSahRlNaBq1/cPrml9OqfZs31Uj9DnQodFfWYPyvR7?=
 =?us-ascii?Q?YT7C1HSgFa7BG0TADHX5u74zfOREemeR1OiZKIQvdfsMJgR7CRd58Md7bm8S?=
 =?us-ascii?Q?GmfQ2iDrElyPHx/0g8qH2NQlHpDp+oksLRu788eyYWjejwrGg3bf9sJ/7zGr?=
 =?us-ascii?Q?cEmEQCfjggJug3xb5/zR2lP0HfvRBb0c01fyFmgdRE+LxeoiYoJu9Mal1+Z9?=
 =?us-ascii?Q?NCujyiim1HWL4yZ7/zxbTlqILzSNpURzKqhMWjlbfvMDkcMML77SdRTfXnAO?=
 =?us-ascii?Q?y6Yho80/EKYT3pkQanMmMK5nO+ECs+47BdOKTb+goWK3Jl3GZN3KIq9yvRJ2?=
 =?us-ascii?Q?DW0eUJ+BeeytBOcqiKTzS6TT5lMqnbzSb0ahUlDnmpyEDjj7QDNr0QwodIID?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1b1ba2-0497-49e9-571c-08dd1046b45c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 07:23:21.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvxAnmARbZmcRKJ5wJsiL5/q0/aud5UNa+kjNzJUInCoOfFasFoRISrnBnTsS3Ci64tPfYFwyx53bc993I3Pf7bq2UChmAd59BmiPfoEFlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
X-Proofpoint-GUID: 7QfxXOWkLy5rlobuu_7JiadNt0c-489O
X-Proofpoint-ORIG-GUID: 7QfxXOWkLy5rlobuu_7JiadNt0c-489O
X-Authority-Analysis: v=2.4 cv=QYicvtbv c=1 sm=1 tr=0 ts=67496bf0 cx=c_pps a=clyc6YhGvfCRRXf4btgSWw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=-cTog7_gaXWioZdrjewA:9 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_05,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411290059

From: Boris Burkov <boris@bur.io>

commit 74e97958121aa1f5854da6effba70143f051b0cd upstream.

Create subvolume, create snapshot and delete subvolume all use
btrfs_subvolume_reserve_metadata() to reserve metadata for the changes
done to the parent subvolume's fs tree, which cannot be mediated in the
normal way via start_transaction. When quota groups (squota or qgroups)
are enabled, this reserves qgroup metadata of type PREALLOC. Once the
operation is associated to a transaction, we convert PREALLOC to
PERTRANS, which gets cleared in bulk at the end of the transaction.

However, the error paths of these three operations were not implementing
this lifecycle correctly. They unconditionally converted the PREALLOC to
PERTRANS in a generic cleanup step regardless of errors or whether the
operation was fully associated to a transaction or not. This resulted in
error paths occasionally converting this rsv to PERTRANS without calling
record_root_in_trans successfully, which meant that unless that root got
recorded in the transaction by some other thread, the end of the
transaction would not free that root's PERTRANS, leaking it. Ultimately,
this resulted in hitting a WARN in CONFIG_BTRFS_DEBUG builds at unmount
for the leaked reservation.

The fix is to ensure that every qgroup PREALLOC reservation observes the
following properties:

1. any failure before record_root_in_trans is called successfully
   results in freeing the PREALLOC reservation.
2. after record_root_in_trans, we convert to PERTRANS, and now the
   transaction owns freeing the reservation.

This patch enforces those properties on the three operations. Without
it, generic/269 with squotas enabled at mkfs time would fail in ~5-10
runs on my system. With this patch, it ran successfully 1000 times in a
row.

Fixes: e85fde5162bf ("btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Xiangyu: BP to fix CVE-2024-35956, due to 6.1 btrfs_subvolume_release_metadata()
defined in ctree.h, modified the header file name from root-tree.h to ctree.h]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/btrfs/ctree.h     |  2 --
 fs/btrfs/inode.c     | 13 ++++++++++++-
 fs/btrfs/ioctl.c     | 36 ++++++++++++++++++++++++++++--------
 fs/btrfs/root-tree.c | 10 ----------
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cca1acf2e037..cab023927b43 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2987,8 +2987,6 @@ enum btrfs_flush_state {
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a79da940f5b2..8fc8a24a1afe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4707,6 +4707,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_rsv block_rsv;
 	u64 root_flags;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	down_write(&fs_info->subvol_sem);
@@ -4751,12 +4752,20 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
 		goto out_undead;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_release;
 	}
+	ret = btrfs_record_root_in_trans(trans, root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
@@ -4815,7 +4824,9 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 	ret = btrfs_end_transaction(trans);
 	inode->i_flags |= S_DEAD;
 out_release:
-	btrfs_subvolume_release_metadata(root, &block_rsv);
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 31f7fe31b607..a30379936af5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -592,6 +592,7 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 	int ret;
 	dev_t anon_dev;
 	u64 objectid;
+	u64 qgroup_reserved = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -629,13 +630,18 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 					       trans_num_items, false);
 	if (ret)
 		goto out_new_inode_args;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto out_new_inode_args;
+		goto out_release_rsv;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret)
+		goto out;
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
@@ -744,12 +750,15 @@ static noinline int create_subvol(struct user_namespace *mnt_userns,
 out:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-	btrfs_subvolume_release_metadata(root, &block_rsv);
 
 	if (ret)
 		btrfs_end_transaction(trans);
 	else
 		ret = btrfs_commit_transaction(trans);
+out_release_rsv:
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
@@ -771,6 +780,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_pending_snapshot *pending_snapshot;
 	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_block_rsv *block_rsv;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	/* We do not support snapshotting right now. */
@@ -807,19 +818,19 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto free_pending;
 	}
 
-	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
-			     BTRFS_BLOCK_RSV_TEMP);
+	block_rsv = &pending_snapshot->block_rsv;
+	btrfs_init_block_rsv(block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
 	 * 1 to add dir item
 	 * 1 to add dir index
 	 * 1 to update parent inode item
 	 */
 	trans_num_items = create_subvol_num_items(inherit) + 3;
-	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
-					       &pending_snapshot->block_rsv,
+	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root, block_rsv,
 					       trans_num_items, false);
 	if (ret)
 		goto free_pending;
+	qgroup_reserved = block_rsv->qgroup_rsv_reserved;
 
 	pending_snapshot->dentry = dentry;
 	pending_snapshot->root = root;
@@ -832,6 +843,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		ret = PTR_ERR(trans);
 		goto fail;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret) {
+		btrfs_end_transaction(trans);
+		goto fail;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 
 	trans->pending_snapshot = pending_snapshot;
 
@@ -861,7 +879,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (ret && pending_snapshot->snap)
 		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
-	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
+	btrfs_block_rsv_release(fs_info, block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 free_pending:
 	if (pending_snapshot->anon_dev)
 		free_anon_bdev(pending_snapshot->anon_dev);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 7d783f094306..37780ede89ba 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -532,13 +532,3 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	}
 	return ret;
 }
-
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 qgroup_to_release;
-
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
-	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
-}
-- 
2.25.1



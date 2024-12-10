Return-Path: <stable+bounces-100286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE99EA495
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 03:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A028165E8A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 02:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94CDF42;
	Tue, 10 Dec 2024 02:00:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95C233129
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796044; cv=fail; b=PJUV3DBxOtfD++BZFAQ/AYozF4iEElGaYiGkMkiTdD78/ps0rGLFK7vZnTCJhd5uq4YyYd8Ny8eEW8cIc5HjHpQw7xYa2Lo+PiqH4gU0W6q2WwVYmTsVMUO4eckRTF90M4CMN2FFi5pBX4R8cff46gq1x5ebWw2Rhq7FJA1CLUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796044; c=relaxed/simple;
	bh=tiI2Dpmz6vj1uo/I7fOcUmkOOJQC2H2aeEpCc3osC+c=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BlGIlJW1bWdCo9dY0xdUTt9BcmWdbWhXQOb3+dM8aU0HVQ+jR5NbgewpFFYQt+D8HEvDSudLnEkgct1PJKgGvWcerfwpcnO78AduzVKIpdRXkX22vvy/9AYpN61POdz+Nu0sSFXhs+rcoo25FQGG0zTVVp3DQv2zT+yR6reH2Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JKRLl020407
	for <stable@vger.kernel.org>; Mon, 9 Dec 2024 18:00:39 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1t5tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Dec 2024 18:00:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErPj9g8ewydGrEzH+oS96ZmVEt5PIhqzuOZHCu/vVAPXe3+Z5aAIuNMA9vIwZkN7fZIgxL0fC1E5BYmksDVDyz+3zo598snds4NoLIHEii+nf+b+77rLAHrqOGWt0Y3QilS6kyDWi0zQ8qJcgYPSaRjYKle5UpefsRd6K8dcQOFU5w+cKGK3ctrfdU/qU5oirgflVTvWsR3mD7tE0iU5uy0ucXodFgGvjXkVK/sTQ/ZubVBZZRGz/By6uIefYoAgqiry8moFYTgOuJR50h6EdgKdPcEbD92GUdcDqtrG3mex8jELJDSelZf43twV3/YCcF1c5ecD3Ll0AEFitvfNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjfyLR7oUUWln7wLLoCpPxlkWI1nJhiGEMolrkMpqIM=;
 b=wNBkuxk1yxFSGRknhtv1HqwcpVa+D6xOPSa0axb/qid0Quvv6aPDLmR4cYeD+H66wE018GWG89xgvh70A7/vZZ7HpVC4Dprj13tOK2inPkNe08eR8br/dkzpZPp7XmrTpU9nElqD5O5zVsxEyNqFWv+yz/z7Ipzuj7h0tLozGwOdW5/iROghYL0eWyBZAlR+JCNj3kipCr3hze9xzU36ptF06h14bXU05Q++Un7kL7R7PMi6e2lKmu7wYL0pMNvPXOR+3D/S4RvAPlbfh1/qU8XpTKYb2+gD7U9NzDhIYK+f1IHqpgcEYQk4QMil0ehGoYIIzZZc8PxrC49MQXqeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CH0PR11MB8236.namprd11.prod.outlook.com (2603:10b6:610:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 02:00:34 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:00:33 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 6.1] net: stmmac: move the EST lock to struct stmmac_priv
Date: Tue, 10 Dec 2024 10:00:43 +0800
Message-ID: <20241210020043.2545261-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CH0PR11MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba0ab8e-0da7-4f45-a193-08dd18be6e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lwYUM13TdQ3o08CIVgW6rBXT2BU0TK3uCoHeb2LW72sRsk1giQjhacI38qcP?=
 =?us-ascii?Q?ZM3BBYHec/uPiPdSc9ZfO5my8NVJWqIt6Kkz95uRP9R80gv8GWyGc/501WsH?=
 =?us-ascii?Q?OdOdWUIXAmzod2ORwIHftkDof99gHRy+06eucZjwWGEK1Yl75lexajryHo/v?=
 =?us-ascii?Q?F7CEOx2WyzRV7TYU9VB50d6T3XysKVly2xyTQgmkQx6oMkPBEJ8BY7dW7L/G?=
 =?us-ascii?Q?VjK+HYwKnhhxQ4NqnDZMR82o3dwkggwy3tFiRvYtMKRU7W46p/2dY5bwcWDI?=
 =?us-ascii?Q?tkP6UZIRPCKs3jiDQQl+/RPrUUsFiFi4Ky3KjP1IKT67jLH639qQmhKbqf3p?=
 =?us-ascii?Q?i/83mu4w4L0KD4xNlLGb0zbjeCgXl9tpW9VvYazgH4mhM+4Dh0FzyiIur74k?=
 =?us-ascii?Q?e0hJvfol0AQBUiY79JQsMrsZou8xtOhgkftj/YJDXufDlipRWFXEsHNnGCss?=
 =?us-ascii?Q?/R6SCOLusHf32BrHgT2trbB8aD4CvfnxIuf/JJaJ+y5j407Hxp0JAOTAJhtB?=
 =?us-ascii?Q?coHLeE48JccMEHmDqyTLvrm7yi4LD+O8YGqpqbs8bkNxKAIRVjrrNB5/GVim?=
 =?us-ascii?Q?5s60/RPw8CZergkX88ng8GavqWwBjksZCn31gExYWhnZIZFguPUXcfQ0+X4W?=
 =?us-ascii?Q?zvRjQ/g7wGVHxgQC/w1hKxClEdMJ5gajXOl34C7QEkLCPu3hV/LM/ICNjfYA?=
 =?us-ascii?Q?Ixyd/vI8dOMmOI6n8IynK7lzn/OvTzcgAl1DQj83MjBWkAU9tZGX7ZqOaSDu?=
 =?us-ascii?Q?qoL2uIWDXVA+IkYwQWIix89c5BM8p8HmZFEvYtIUQMUW1nVWYC5G8ELzhEDE?=
 =?us-ascii?Q?8MU1n1rJI3Es/wOklPaSbgjPqSyCS9wYEuTty0nbDu2wt6I1Irb7hSMk1bag?=
 =?us-ascii?Q?Pl16lV9Grsp94HhVhnCjPz9oZnEloueU13ZxkNOSjXUAfbYM1VTdw7r+/NcI?=
 =?us-ascii?Q?blZDBfYYuvuj0pWeaMww4P96gXlnRArwDCFDn6IFRbjUFsKPN9MbjzzQ+8Rd?=
 =?us-ascii?Q?S2vsC+v53bAo+K3a3I5r1dxLwEveksY/+TNgLRJvAmKQbqQ8XFoaTJ53J6KF?=
 =?us-ascii?Q?YNpprvjXjMfTkNEFLbSalMdaLEAuD3gaPuQOo4ulkUywxwe4ydT+VO64Zd4d?=
 =?us-ascii?Q?gHsaixTGEjx6HwgbI35mQQToKkGzBViDW36LE2Cn+jjR/J492gfacAHzsmKQ?=
 =?us-ascii?Q?jvpuIoAxH6/cJtUeNYxc9ynj18/SIXSPuJMoop6HGbEv6o5X3YOX+gzxkPsi?=
 =?us-ascii?Q?7qwlmHGNX8tiCHz8oAPneZleUI40hxtsVlzAunsRM1foVN5LEVSRuhnhGgsR?=
 =?us-ascii?Q?5t7y18hfjl497nNq8mXDe9dcfSNoi7Z+HX9fRrJcbcXCgcHtCQJA5mh19LWR?=
 =?us-ascii?Q?1/EsuHlsPYxfldHcr4YY6Nl+3YU6jDm8O4LYfWUaKVDbQw36fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhMUPAQQL/qb/s4Ih18iOBGTWJBoEbS4qTi8AI1WPs+oeivws5b01iSKvFmL?=
 =?us-ascii?Q?IMRykCwDd5r+MG5K5L6LrxiWKm19Lm9eM/FHpVSOmRjHmVoefDIR/XqnbnMz?=
 =?us-ascii?Q?4khqO0HPc3Mis3Evga4j5AP/7ACBsuvuaVPKv6gBKUfvgNdF/NPOyHI9mGMS?=
 =?us-ascii?Q?mowtCX9fi2cLARv5pnZV8klvyi/w7XHUIIbSYSXzpWg8hP6gn2L1KLlvY7go?=
 =?us-ascii?Q?M8nL20nr7R2HjsXjmGl1gChdS/pq3N/IVOKYALA0sdXq01vYgMc9dfG+G62I?=
 =?us-ascii?Q?w6g9fSgRc56ITfEnM9nnm//bVg4QimcJAGplVB+X1YsIZxwZ55VL+2XWFGNL?=
 =?us-ascii?Q?rl1Q5KNfbbsx/a+a6Qf+oKMkMQYgTj3dnM38fdNBJyEBq6NzJhPmBq9x1hZx?=
 =?us-ascii?Q?9j6ZYtsVPRFhwwLx828CKqnvcqsK3c+FPCLocJHWntabDIkSZ6xatOhRbTT6?=
 =?us-ascii?Q?AdjzT25N2st7OnfSI6jAyTxxwJt5PRCPjRt0VMbMDRkk7Qa0GU6otokg3jbo?=
 =?us-ascii?Q?6BYmHaslyYZiL7GgD643aqYejw3M40F8Kh5QlmOMdeTsUbLYdKeiDfNu+zju?=
 =?us-ascii?Q?CGRn5XYUHLwrGrUvffw8vyfhv431UGGs+rgydGEsLzcEmq/vo6Ev9tdHtndg?=
 =?us-ascii?Q?5nnB634Nu6Bst+GI/94UqS9Mvbr/AtKeZVB71TpcK4xMjwr1PRCFfZVfM8kz?=
 =?us-ascii?Q?ASPSGSbGK6qc3JeDdLzx6BbEdOWDyrEqyZ1u/6DABlXwCF+YRy7CYS8VpQyF?=
 =?us-ascii?Q?r6z1LsqVRGZm+7znMBkHuxPj9VjuggoAU4xhM0nRH+9dUepwXczD7RFXfwmV?=
 =?us-ascii?Q?jZp/DUoKYIK5r2g2Om4lH2ze39YLeusux5aWEhgsocNWEHjG8Hv35GbJtclQ?=
 =?us-ascii?Q?4sgTCn75mMrBm0oLPUkvCwd2dQD1z8WxJ+yQS7RYG+g+E8tLdtrBYfm4D4iB?=
 =?us-ascii?Q?mNPV4yLGT+jGXQRm8NuG2hlmfuwqN7ppx7LoaPXg14NYFn+jWFN3VePw+Nnm?=
 =?us-ascii?Q?NsDgFTKqjUip1Y3Nih3aXGhZppH5ZBqUR0AldGdg8P8TUGbqd/F0b+b8bA+q?=
 =?us-ascii?Q?val37IXG7HBBPDNorHxHHbFKzT/tATD1ei3D6rFSrbU3EYXP4KQ1mIvrnNOI?=
 =?us-ascii?Q?eMKiJbuWZm3dRME6R7Un2aTk/gTeib/6qWTtJNoWSqtLV4mcBeZZdxPTgzhH?=
 =?us-ascii?Q?BsMb+83bGQ9Dvv6yXmyVX4vn7Hbvta3v9C/msPdye1YUJKAXObgAHLNaxQDb?=
 =?us-ascii?Q?q5VK6bI9Isxv+YXNNLhS13rVtvdw7to4iENUnNo98AkMTda4G5WGSN4/Ckda?=
 =?us-ascii?Q?dx9k/AKMcPep17sYoSnLDeyEamlQg/oGpf3fIG4HhdQTKFXix5Z6ewRCsjuI?=
 =?us-ascii?Q?UR3KvPVc9MTRmoUCbEmLjEqc8FWgwOZdLAMPUdwug+AAVYtt1gbHWioK+XKG?=
 =?us-ascii?Q?mq5k5E7MHbAupIuqTawa1e33WMQZkD0mR5QYw8IQ/JJKvjaWxeV+nSTu/poY?=
 =?us-ascii?Q?SPMmiBORuhzKPYTvJFncchJTLaEv+Htq4WXgQJiSZrsQIKsSGYWOSVoP7u0p?=
 =?us-ascii?Q?vHHkqYv+QSfgM5iqoBQ+GyFbzyIeQRQrFzVsBmU4dCMkxMMFn7dHhACfz5WZ?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba0ab8e-0da7-4f45-a193-08dd18be6e89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 02:00:33.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF0tZmg0E5EJZWsTFWNcvCIEWNG2wiyT2/valELhKZHiWDUysdwBoQcQ2/eJ56y3FV3VLhDXxsIjDMEzPznWUG9Lk6bdTN3Lvuxvn8xcX6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8236
X-Proofpoint-ORIG-GUID: pZtEfqjGqspvzScT2TvMopBTEY5n9Ncw
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=6757a0c7 cx=c_pps a=ZuQraZtzrhlqXEa35WAx3g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=qGFVN2VuUZR7IEeReTsA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: pZtEfqjGqspvzScT2TvMopBTEY5n9Ncw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_22,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100012

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197 ]

Reinitialize the whole EST structure would also reset the mutex
lock which is embedded in the EST structure, and then trigger
the following warning. To address this, move the lock to struct
stmmac_priv. We also need to reacquire the mutex lock when doing
this initialization.

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
 Modules linked in:
 CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
 Hardware name: NXP i.MX8MPlus EVK board (DT)
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __mutex_lock+0xd84/0x1068
 lr : __mutex_lock+0xd84/0x1068
 sp : ffffffc0864e3570
 x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
 x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
 x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
 x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
 x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
 x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
 x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
 x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
 x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  __mutex_lock+0xd84/0x1068
  mutex_lock_nested+0x28/0x34
  tc_setup_taprio+0x118/0x68c
  stmmac_setup_tc+0x50/0xf0
  taprio_change+0x868/0xc9c

Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20240513014346.1718740-2-xiaolei.wang@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Resolve line conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
 include/linux/stmmac.h                         |  1 -
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 46944c02b45e..0a4edc9bd246 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -240,6 +240,8 @@ struct stmmac_priv {
 	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
 	struct stmmac_safety_stats sstats;
 	struct plat_stmmacenet_data *plat;
+	/* Protect est parameters */
+	struct mutex est_lock;
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 9c91a3dc8e38..0e5a84694793 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -79,11 +79,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	/* If EST is enabled, disabled it before adjust ptp time. */
 	if (priv->plat->est && priv->plat->est->enable) {
 		est_rst = true;
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
@@ -96,7 +96,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		ktime_t current_time_ns, basetime;
 		u64 cycle_time;
 
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 		current_time_ns = timespec64_to_ktime(current_time);
 		time.tv_nsec = priv->plat->est->btr_reserve[0];
@@ -113,7 +113,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->plat->est->enable = true;
 		ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 					   priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 27187f528620..e4ca722dd2c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -978,17 +978,19 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		if (!plat->est)
 			return -ENOMEM;
 
-		mutex_init(&priv->plat->est->lock);
+		mutex_init(&priv->est_lock);
 	} else {
+		mutex_lock(&priv->est_lock);
 		memset(plat->est, 0, sizeof(*plat->est));
+		mutex_unlock(&priv->est_lock);
 	}
 
 	size = qopt->num_entries;
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	priv->plat->est->gcl_size = size;
 	priv->plat->est->enable = qopt->enable;
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 
 	for (i = 0; i < size; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
@@ -1019,7 +1021,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->plat->est->lock);
+	mutex_lock(&priv->est_lock);
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
 	current_time_ns = timespec64_to_ktime(current_time);
@@ -1038,7 +1040,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	priv->plat->est->ctr[1] = (u32)ctr;
 
 	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
@@ -1049,7 +1051,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				   priv->plat->clk_ptp_rate);
-	mutex_unlock(&priv->plat->est->lock);
+	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1066,11 +1068,11 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 disable:
 	if (priv->plat->est) {
-		mutex_lock(&priv->plat->est->lock);
+		mutex_lock(&priv->est_lock);
 		priv->plat->est->enable = false;
 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
 				     priv->plat->clk_ptp_rate);
-		mutex_unlock(&priv->plat->est->lock);
+		mutex_unlock(&priv->est_lock);
 	}
 
 	priv->plat->fpe_cfg->enable = false;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 9f4a4f70270d..216a146c8f22 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -115,7 +115,6 @@ struct stmmac_axi {
 
 #define EST_GCL		1024
 struct stmmac_est {
-	struct mutex lock;
 	int enable;
 	u32 btr_reserve[2];
 	u32 btr_offset[2];
-- 
2.43.0



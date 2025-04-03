Return-Path: <stable+bounces-127479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC01A79C46
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62B43B09DA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AA19B5B1;
	Thu,  3 Apr 2025 06:48:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFB136E37
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662887; cv=fail; b=d9bhCV3GJrJJjzBCK7JW1HWw4DmPUR/fEvTILKLRG21PCJf6NT9k5pIU7/0Mxt1MHO49uGRRXWXDD/bUDu0Y8fiCVJ6GjEQEgVxyjiLx0/lhIxU84I3QocW7pLtml+8+sLmGObx4B4sKSaujxl3btZZ5O+/y7KkVFMQwNc0Ccjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662887; c=relaxed/simple;
	bh=zbv/4iBzJAgnoQwKHrhoseRUdxcn1w3FpWm4cALxEVw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=grijDQzffvLMcwLxytse/fsNIrAtdsSE+kCdK149lj7yrdhAQVBWRXGIHdjf3v71plGuy5UkH+7adB2byJlcwjs8iT0ru+i0dh0+AUskGprgKrh89WcnXQb7+lqKiXMLluW/irl68D0scYt5TeqvpmNdxMSum6o1Q+KRRCB5hgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53354Bx4030773;
	Thu, 3 Apr 2025 06:47:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg0q8ayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 06:47:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7HEspGOULhuQdagv5hTnY4/e1iteYl4a8O11vygchmfXzqLO0i+Qx3n30p+DUJ6GKATYEGLspxIK37XcFUdtD08g0WsYUnfIcSvNU9xeIhvA/biAp/Ey6QJZ/2KMThz8kyXlPat2s7qfE5Hc0tFmZNlqetiqQ4fJbIdNqtS9dJcJ2+aNQntdarYJ/b3EoMpI5lwmgoxGa5DDQe6eZyfn3V9ehvkI1ygqH6IHK4t50gV7ONegg7TMXWGtIRZFcNCj/vPgsU3osXlhFjRiLo1tEKLWZHQNkgkxjwHzLjwwyPqTNuBwLm1a1AuxFzS31CrxjkP3h39IB2Ex6EWeMr1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH2fSxIR4mVnAwIrxEkO9bFk9fzCCd4YsAdhDi//GR8=;
 b=hBxBtVV8OaEBKBun7L2TtN7MuW4kCyRXSwGe1Cra+SBXZhcHzHiprnNodxe/k/pO+BDRweNXdJVdKNcLoi4cMbgmTBIREAlByBZcNqSKV3wjeVs40HxyTwvM7VKmWr7QEFzjw6D5G26CPHyLRsVTdMw08uBlTnYnVylmwz6J+WFah9u0AHAleSwf1ee7NUPfmH9V36EI9jEzooMaCYpr5rGQMNoX8NusZoynIbWHxBIrXI4SU8fwFpmB5KEfgulCkQuDieUpCVjiwxcJ1+k6OoA9RrPO8Dum/Kf5uHHGw6wluS+NiOXuyenB3+QP4czWnqeTzFkIsoI3Ul8wH0RZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Thu, 3 Apr
 2025 06:47:50 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 06:47:50 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com,
        tom@talpey.com, stfrench@microsoft.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/2] Fix CVE-2024-53095
Date: Thu,  3 Apr 2025 14:47:34 +0800
Message-ID: <20250403064736.3716535-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: bcee49aa-1980-4e2a-d611-08dd727b7352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gD/mcj+s242ycA4j2uuzOb51EEzf/Yd545elwSXmM+v3cn3EL3lEFHqV5igA?=
 =?us-ascii?Q?I0d5MFzhKnOn3hIY+/7rmaGu1XgznESp5SbhAmUc68L7ygG6UJNuwmJZjk8a?=
 =?us-ascii?Q?Cr+KRuWMkudOaiE7GYknA4VaWMcL5Trr9jpQ9pAr1QtkghGPwJhW65k/SYSI?=
 =?us-ascii?Q?Lnp2hm50n26VJLGADhskWdnpxPmuPaFqy/RCr1KhCAQ93DCS02NpPpncCqjV?=
 =?us-ascii?Q?Qjh3D5moJ5MosSuU87ojXBpT/29/sTYgKyIkV81ahSkBK4PvIHKBGvPwhEZE?=
 =?us-ascii?Q?GJfvmMFGjbTr3JjiR3Ag8sbAFszPesgrl4lCT7d5nS48rFp5KY/7hN7AZeHu?=
 =?us-ascii?Q?CWTRry3MdqstKrxq/P15f28r9vOBMXK2mKm+JXYANnF5U3YqD6gzoJ5QvBOj?=
 =?us-ascii?Q?ynVFYkW/+wokcHC5Vey0VSGWhpi5ioKqXmT2Q4cJ7Z0mZh/wvrNnMqJISdRY?=
 =?us-ascii?Q?ieR8PuGuxtCIANwcuZBTIXDVOUQqQzViNBqll6XvUmrvEm1Q2jywXocBGecN?=
 =?us-ascii?Q?tlNvkO0MeQllSksbJJZHwC+wO0PXbiw1COOW0cutk29ViuTOtXqb1Rwr7YYv?=
 =?us-ascii?Q?Gs2cukNl8Q4d3QJRC4CrgcONfy1iymQOuWDMeVDijaS1owmoQtjrgWoFkkB0?=
 =?us-ascii?Q?HCU6BgSbGBb7WMvG9+VUCPt27pgbW6PlIOg96K4MaMu9T81LWTNAte4uO1MI?=
 =?us-ascii?Q?NSTaCHvgjk05ZJmCK+5uDq0UFX7p68P3es4dmHVTXkLc6HwFkAStqK78lmO5?=
 =?us-ascii?Q?+4jLG+iqjZLI5wUZtBgTWgaHQNETcIgCzGCfc+T8dE9qVgE/zw2xiK3o8Eme?=
 =?us-ascii?Q?8Q/4ACw67nUfpet9GexoUo3qxTNNDbBV9SsLoX4EWlEIymRqtBC/8qW3acZY?=
 =?us-ascii?Q?mhBxOwSZTB1sX1GA3GE2nD1UKQPOkEoM5StgPug/EZFlIcRWspuiP5Kw+g3h?=
 =?us-ascii?Q?ajoIRCSREv1u37T7rA8oKiVNWhYftihzNrzf2vXaga1bhrqIt20ctFv1Znmt?=
 =?us-ascii?Q?SxSExuvMfEW5VSqliXbld9Q2xVWe1T6XjYzzmychHXoEOauToVx2bdro7oCb?=
 =?us-ascii?Q?XWTMlRLV1CdEkIJLjEjmGYZMWBDOgEoYu6fvB923QI+Fyif4pxOYzvjufWHQ?=
 =?us-ascii?Q?nVJujCZNtYITavWeBCisVMp2hvuxHjwKvVbGnFUqBAjs83TeamZRJWTG06qz?=
 =?us-ascii?Q?B0O6+3jwprRtG46A11vjrh2joqN87Qp0e+TanCxy070bvIU9Z8xTKGp67uIO?=
 =?us-ascii?Q?/lKxsNggTVWKa6Fq6y9A7GJixS7wvggy7NNDJxGQsWffr9iZVkA7WD79hvqz?=
 =?us-ascii?Q?FU+AYbvaUOeMNR1k8ZRTCvRzyBDLYkaFDb3wsW/ISRI8WBogtRYzlRuRHQLW?=
 =?us-ascii?Q?uErYNyc6RmmLtUJTZUfIBOk75wTfpeJpcLA6IK4NxAiDb0z1SsgG874AAJCN?=
 =?us-ascii?Q?G3anMvgEDAEJJ5S1CkuLuBD9qbAMWsw2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6dRvsYaS3OPJmn7alRrkju3iMJgwj0wGYPiZx2d7zgvI9HzLFQ3oOSq2a+b?=
 =?us-ascii?Q?95DNqpD1SXiy07XYMQAN5mnok/hjvdvUipBZ/GVtrb4/0a66Cx5IL1iP07xc?=
 =?us-ascii?Q?3JhjglqTW6HQlvPEDX96b5Nog6VxrnZEzE71rncn0wLyvhMhrDoQXrmh5XmP?=
 =?us-ascii?Q?pRbLJ/EO74vplkl48iKA4h3sT+wJPz2PDSjhCe1k9iDVi51gM4qdVGN3H10o?=
 =?us-ascii?Q?p+CSAXTK+GmYeKaSnwk+yYZ5CTCYqfKNfzjZ1qnCvwdFrEipufhXg/ZIF3eo?=
 =?us-ascii?Q?FrUnWlDM/dH799v7vxDx8SwdNk3CY/sBIsgwSWZUDaUSIVBb7XP/M2UbQN8v?=
 =?us-ascii?Q?GK4rM3dhCPmcSCZb8b5OOPbQ2KsvUaAUxw1ztNoZqM6fdeTb0eJKfdX8DbKj?=
 =?us-ascii?Q?y8Nwvutco0pHtubYG4MkjRTGfdBONZaus+BXvyzltBa4M58dTQSuL3KSiVWl?=
 =?us-ascii?Q?wxN+pNcBMEtRNsjWEvHSOoiFavaMmZBs/8D1VyGLhQrhNMoCB/9ImDFXq8KZ?=
 =?us-ascii?Q?CNT94BN7BGEoXWLuWzK/vuy02rDM9g8V0H0MhXjz3nT0q1BRvWScu6hnnuTG?=
 =?us-ascii?Q?tLdkau1mZ+CHWKX4lqF3N3JET7B3UyTHeVoSDbKmaguXhyJoGedpyoJcvTND?=
 =?us-ascii?Q?dPY3X/Y+HUdB3D3GKNqhMot7BNbA5bMU13IzkzysXBXNz3OIJ9cAG5NCKTNo?=
 =?us-ascii?Q?OdKY6IVwSbpgIiNuUFK9orXlGZFjBttlyTtE2CrF6HnYMt4qNTkISPHL0l+x?=
 =?us-ascii?Q?ngpw2UghUsUEDlcBZ9XaHHhCvXNNy4s/cFNVsbWfgo3sO2gk0vXunp5Mw/An?=
 =?us-ascii?Q?4qCFD1sdXbet4F2GMMjUWJBqJURDEwV3guk9s8Cp/wWjfvmWXfgBFmT1kPsz?=
 =?us-ascii?Q?fEU6T7DDj5AqmU55vdQGQqe3UYur6DjwTFhuMPbxglTPx6OLJITx4cBJIQnZ?=
 =?us-ascii?Q?CY/FoyJLTaQ8gEZPvUWvtlRyGQKB7Z3jTSNnZhQkH6NN16JnUMxz2d179UUM?=
 =?us-ascii?Q?r9va6CMDSHW0t8Qqc8s9vuj2cq/9SI6T4T7pgoBqIs2yJYK3njv2/CGDrFkz?=
 =?us-ascii?Q?TEcsD/Uvf9+NzmEqlOhwQS/ms6PqhFB5hS+JR/drYQvh5EXo4tm0GRebLdj6?=
 =?us-ascii?Q?H6g4KrJ8A5+qZluxUOOYccL7zo4ehuMnqszZp3n7uMXaB3Go1vHuyjh09icJ?=
 =?us-ascii?Q?JWAiXx4KBZ3EYCSjov9X3F5tzSBebZM+RbeSC1LMW4+rnsn2J+brx4+fVMHY?=
 =?us-ascii?Q?f8sMUmBVj2R4ZbWun25SgnUALv4VJC9nyn+2f4t2dTQfuJXQt1w4PMZ5FHhQ?=
 =?us-ascii?Q?LEsVhPhA+L/9H3zehL7NBV8H3LM1YkP0+G4gKoZWL/z9U5RwFZ/ScfOTATpK?=
 =?us-ascii?Q?IW8BIl9wB3kS77fDRmUVr3K45/D7Bg7wo4sNtjEcorbSK0s70+M/PMT5zmT5?=
 =?us-ascii?Q?Bsiz49xb/N/1/qhRli5FMggikfYsb9xpP7y3U4i/k2UByIjhjzC6TXlBRmw8?=
 =?us-ascii?Q?GXFoCeJ3Eq+PXUNXMrY2zR0onfTbj4zU/WVsaN5LXeCuKmtJ4rUMQAt8jI3T?=
 =?us-ascii?Q?SY+GWlrPMZz77Kda2t/H0Th+xtNFNDKU8VON9QVNSqq+QAHfTZNcgJjjN3OH?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcee49aa-1980-4e2a-d611-08dd727b7352
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 06:47:50.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z5GTQDmSnx4+e1cwX2EhK37BsrUtl2LZJZGI8wED9qJxVNT/K6OF6IAI90TpyANvunPpDlyGYma6gHwP4uP+dvztyCdTyN8jrqDbwYJbGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-Proofpoint-GUID: 98zyGGAG7TMnZE_WRd55wVJd_pxJNbVS
X-Proofpoint-ORIG-GUID: 98zyGGAG7TMnZE_WRd55wVJd_pxJNbVS
X-Authority-Analysis: v=2.4 cv=G+4cE8k5 c=1 sm=1 tr=0 ts=67ee2f19 cx=c_pps a=TJva2t+EO/r6NhP7QVz7tA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=PPzETAhNNP6vXz0zdBwA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=619
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030033

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Backport commit ef7134c7fc48 ("smb: client: Fix use-after-free of network namespace.")
to fix CVE-2024-53095

This required 1 extra commit to make sure the picks are clean:
commit d477eb900484 ("net: make sock_inuse_add() available") 

Eric Dumazet (1):
  net: make sock_inuse_add() available

Kuniyuki Iwashima (1):
  smb: client: Fix use-after-free of network namespace.

 fs/cifs/connect.c   | 13 ++++++++++---
 include/net/sock.h  | 10 ++++++++++
 net/core/sock.c     | 10 ----------
 net/mptcp/subflow.c |  4 +---
 4 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.43.0



Return-Path: <stable+bounces-95489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678FD9D91B4
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DBE285ECD
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BCB7EF09;
	Tue, 26 Nov 2024 06:25:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DF3208
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602336; cv=fail; b=az9P4POGrzk3ETe5blOc0M9uWikSCoJwHT7h1o5yK1QKWSfminD4os2tPXEbLBvVE7jIrAUHl1M1YZCC1lckU7K6c+tQGellT9cSv3HWhmwvmzoLGdqeyJ0ky0Tb1bXTOyh54C2qEHZ4ma+4LS5Qfxniba6qLCI3yRukDx6QJrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602336; c=relaxed/simple;
	bh=SS/0bUHBhMXt8B42x+1iHtQw+UAhZGZcBUatWAq2Kjo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FV10x7HU/Z9K2bF/P+49opwZMcZT4h55YwMnojwWSm6Eesag+P6GOcwXr5Jm8rUd/NdLrWs3CEaCxaNIAkSbFaKenUW8ayHw17Pt6k5mJM0KTMEYVA4lXF/kkdIMLv9OO3vBaINuH+UWusyNSgzFCiqTo06UXKkJGIjANYsKzn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ526GY009296;
	Tue, 26 Nov 2024 06:25:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491axpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:25:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdkiuXZd+qkOw7/fuYwhbv7fBtnc+NUt3CMl95s/4W9NBpFGgg6L3QJpcQHwdOj1+qrvA+MYvhKJIKp/lJre43aEnnH/89vQcX2g2rRFhtS69Gw/jfZmIl5DG39P8y5Q9VW8Bbl/SiJcJquJTgk3o48y02+GO+tagKarvNvtoIzwFY8+PFhuHQ8MCzZILdxgW2tGE06/ltgoQFKjpbnAIloN6KDqKvgspHjbZwaoCwGHlkreq1+CoXLM68fA9QcFgtVBVzSwFd5KI+fPQWLx00cUrOoxx10moaYGBcVY61Gs29HRRGRCcvQnpxqhzZuHAmH10rn4OuKR6lAXDE37aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNqYPJUpoQD12C4+uCbbMd2ICxqrX4Mbg4Uk8kNpNEw=;
 b=jkPZ+7wlTT1WD/gLzElh0iGxoqzse/azdE/PD21ZTUsr/yf4HLKG44wJvJ0OMMyMGvYT0zRb+ayRGZYSix+oOJXR6hcx8CUWHT2Elo4rPIiS9Yz50XqoN/F/fXNp8lKPcuiPFcD/U2wERO66Ts4Yx7aezowv/0IK8jFkXjxGUeUBThwTamawPXTi7L9c1afmZAZ1HTzQHxBm3Ukq9LmaPFMxsxvKKoO+fnGC/1bakqtoFcZX1DYhmnI1s1RhVLeX8c/5ibEGY35A+9hsvA4yoPXyldiFYuzQ4ucZKBA72yXXT2d1pfqwt6ljbmgEEcKSM1MbtmnEcV2UQg/I3sqYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 06:25:26 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:25:25 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 0/2] Backport to fix CVE-2024-49951
Date: Tue, 26 Nov 2024 14:25:35 +0800
Message-ID: <20241126062537.310401-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8fb41e-fc34-4ec5-bc0c-08dd0de31d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n/SC0Iy6XzaqmXcQ63/3d7pPRnceVliSJBv1xpm/WOHd1OQpL1jZo4qu7m1t?=
 =?us-ascii?Q?xykUFXJ6HNrz5OL9fk8l345xbwj021yyh5YNYuRaZ1h+N9ol71cq2igSbBjS?=
 =?us-ascii?Q?eRA3gkcJVDEB0wuNCNM9bxqpYzFSPnU9FFolpQx/jSTC4fQy9t/yo6ERyhWe?=
 =?us-ascii?Q?1JeF3Vpc3V0d7h19XEw+NHGHelrY7dvDUUFdKpuuWxkR0WaFDBIMIX77klr5?=
 =?us-ascii?Q?+Z6f/t6KirGVYtcMq1Meson+PTX3U1BZ9C6vKJ8HEkViBFSze4Afghy7HTzV?=
 =?us-ascii?Q?sns95onYt6Eda8Wl0t/6FoXeCjKjeUj5fuxpvs7N817OjWRZhgvq7NYVI1UE?=
 =?us-ascii?Q?rfd1Q5qvRkdJZlJMG3tOdmbPgD1n8mEE7UZ4G9WwAL272LxrlLnAraVgnLzp?=
 =?us-ascii?Q?GxGDyYobATJUh0NYPnvaujDaCmPNOMPIYZwkIaaYUEP+D97MVuq9j1ujQ1SL?=
 =?us-ascii?Q?V/+mtrZUJY8F/bR4QNXO75VjhisGNPrIzyH5eOp3w2X6FYglOmyOMvtIZO/I?=
 =?us-ascii?Q?a38bRnUYWem5tTiHbFmpyuYUljdbGd5rlslAzi+qlKu5E7iJoAovXyKPk8O8?=
 =?us-ascii?Q?4AjHr2xBkKATSbVYExUWl8uuNYDRcX38OqRkxWDuSC+DbW4Ye7DjryE4vOnA?=
 =?us-ascii?Q?IaDfCo/jnVA8ZvMWdwJx/LVTq+UZkuhy7ibgMISxkLBj+40kc+Xuu/olPRCa?=
 =?us-ascii?Q?JpXr/mm5mU1R40HSk8nRkgkNFhQxXN3eqdMfMrqjcgkYzmpP/lk626+OIaRX?=
 =?us-ascii?Q?QDxHfNZ3YyMTSQoXAKIXt/V/+xU2gPxApL0z3YRScP5wrO6dUGnXCILqH8wT?=
 =?us-ascii?Q?ceDQX0uiFJodjKqTND/d/FWE8agX5yQKKubda+4TCzqdGurXrg1Rh8c74w9J?=
 =?us-ascii?Q?rJ6PCn8qwp0lNgHRJp7sdlBFIDOSpjczaSSnWuUJdVabjjOpVfymAjgIKPdG?=
 =?us-ascii?Q?7Pwl1D4hom2nq/fQF0vvi6soK/NfP/q28ODjQVgQ2aqi5VexIyWtjjIu1UcW?=
 =?us-ascii?Q?ccU4bKXfeTcUy1H7QgW3SjqPQyGZaRVju4uK+sOI2icMIbAZRxBxUNYcVc9/?=
 =?us-ascii?Q?pclQICJS3cie3w9RphiOBd0bABADFU2O8Wom6ZhO5nnhuOrzAftg1xvqnoR0?=
 =?us-ascii?Q?MuQVSWriVMdIicvAJqSOim04G9XRE7hJbqC1HKNLxjnCeDTCraqSpLqXTGDn?=
 =?us-ascii?Q?MbrSBPCDCvGPRkMUq+NI6G12AEPyjsqOMUhhnmXkHLjs+OkWdJFy8Uznct/5?=
 =?us-ascii?Q?eMdttSWO68/nz7NA44GZagR2s9x0FgMzNg9oky7QgPaA2J/usq27o1MC/2n1?=
 =?us-ascii?Q?mGMmdsTHQZVD9+piBIjo+5c4tOih0QpDbz2gge8Pca7ZUwK1zcYX8dmbXdo1?=
 =?us-ascii?Q?1SsCRBkFm6CAtBY2hnZkPWyVnGTKs66R3MgtBO1u/it6CiIkkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9ZIaXQtfYwu5kPAjgSCDCjwAfexLUMrQOjM9hVJVeJ0hIoKUBEWTRaCGR1x?=
 =?us-ascii?Q?w6qafLE5D41lcwsXJGLlXWH+jc2vLnTTRc2cUCMqPl7R86uejoXlEcQbn8VA?=
 =?us-ascii?Q?dpTziaqVs4yvPmlk0f9t2xOFIr0Ug64gnbXiKUuxf+E1WSFiiIcmL1ey9rMX?=
 =?us-ascii?Q?Qe3PIDmYap3pmcp9wHYtCfhaEnCkwTOymbMvu+43OXp6l4uti32MDPWay1yO?=
 =?us-ascii?Q?8K4YiE0PSzNpDZV5XMktTCs8P2dW5uInkpCTLNkyk+RiQiG21qlhhHYpdeR4?=
 =?us-ascii?Q?XKIH1yx6bocFxju7pF7uL5g3yK/iRVENg4mkfEd/U4wQX7X/4i6YsikRpa6h?=
 =?us-ascii?Q?6/WWPUoaBmkvqfKP7fjzvCkFxBUldvmhKkaFvTyLJ2lPXFQ0mZHgClOK9U1E?=
 =?us-ascii?Q?Zokh8CQyYEM+ADvYPj+RP62FV1C20JUleyWd2clt1APTkAs0MibLm55XhL93?=
 =?us-ascii?Q?Em3EYIR8EPP9gOOYENuptNm0BPS1fxrQd+2D8My/iXxprin3MBBVdKOA7xO7?=
 =?us-ascii?Q?kI5kFv1IBJcJh+Jx9HrPJpSjRa0k1gY8CX2rgQYXlvvxUd5RC+eIrSOUBoqu?=
 =?us-ascii?Q?d0PWp51Y1tFJ5nU1iu1AdKMYp/au9/zRCvu8or13Th3RzWS7fYZJBl4pPyyu?=
 =?us-ascii?Q?JADCgyQ5+y58bRlpNPGIReonA2jHG707ZYr6XMH68SVVgff+zydzD8gR0SGG?=
 =?us-ascii?Q?o7sDy0WhqaOQJY0ws/XzHYCFgEUDIsnmtlca5EFD95993bYHr/w7c+AvRTBy?=
 =?us-ascii?Q?P5d1XCv0MJEyOFfyJz7E1xM/TzzS0BuBOcE6ngurcdYVmTka/HXUavCqtDnx?=
 =?us-ascii?Q?p6/Yr5mIo26/Zz9FjRBPyAPKkX4L/uwfgUeZoMdXc/NyUYiKO0jMyAOZSBFe?=
 =?us-ascii?Q?xjua75i4Veo2JMUg6tP068es8G13QVeeB2yY5MCjRYyOsHMxxaFQR+6nRTZQ?=
 =?us-ascii?Q?VzO5rj1UFXZpvN45F3aX/Xe0dRP82AaJ9cJl0QTMP4iAqbSGTz7iWizTk4OG?=
 =?us-ascii?Q?+dL9+S9WhxkU3WOMhi2aC8YAhQrWeddyL+pSRG7wJoJaJrbPIAH9lpWTCjTd?=
 =?us-ascii?Q?lKImDhUaD5gBHV4XOkFjloIJPVduDsw9sSjOUbfwj2YJEZqJRfuQlNMiLgN7?=
 =?us-ascii?Q?SMsI1TV9nlgllLAER3rq/uZN88hRruiLKIl47/F2KWB14JpitxonpTAUBbxT?=
 =?us-ascii?Q?LLdfdUzQ1Pg/Oqk/FycoLg72mhdfCWXCFwN+xnAP+IZajsNA1KFYh1z3TekF?=
 =?us-ascii?Q?NRO/K4fUkkl3ORX5O15VTIOiZ4XpGOEGmLATTe6f2ESEiFVX1UAZpyNrEk5p?=
 =?us-ascii?Q?o4Ec+uirSfsxf6nPr40QeOj2riNNfMPb3rdGoVh3vA1sM7SBroDqn6KxZiqV?=
 =?us-ascii?Q?4T/eC+2BdCCDL43ifpQ9p9U9yxwSDRV0M8WsUzLdgCJxSoELN5QFQy+od9ku?=
 =?us-ascii?Q?RmTDEsaU9PVc8B0TAUOMj1tmrELSR53d3c4g1n7nc3FoukeLRUudeVWc4VB0?=
 =?us-ascii?Q?VfxD6d78jdT+2541MkK5oI0gVnIQI9geAj+Rad6kCfs/CRaszV0qfI1vzNFh?=
 =?us-ascii?Q?R74W8dUX2CrIWpg/AdkxNPQqe248Kb4gERwfajn3BY61mGdDISdCENBgyRrf?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8fb41e-fc34-4ec5-bc0c-08dd0de31d34
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:25:25.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYR3dDuW9dex6oS3Pod+D85+CL+67QBYtfiACd8ZbnvOeR3jjCQh9OonoUP6vC8b3GKRjlTG8HPHIABIF1fk49dt8Hmf5DkmCYGl8P2fbKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=674569d9 cx=c_pps a=ybfeQeV9t1qutTZukg5VSg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=IMvOzFhTreJvxDIduB0A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: Q707HcDBchsHBTinnRpc0mvubVUamCg4
X-Proofpoint-ORIG-GUID: Q707HcDBchsHBTinnRpc0mvubVUamCg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_05,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=929 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260050

From: Xiangyu Chen <xiangyu.chen@windriver.com>

Backport to fix CVE-2024-49951, the main fix is
Bluetooth: MGMT: Fix possible crash on mgmt_index_removed

This required 1 extra commit to make sure the picks are clean:
Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue


Luiz Augusto von Dentz (2):
  Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
  Bluetooth: MGMT: Fix possible crash on mgmt_index_removed

 include/net/bluetooth/hci_sync.h |  12 +++
 net/bluetooth/hci_sync.c         | 132 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             |  23 +++---
 3 files changed, 150 insertions(+), 17 deletions(-)

-- 
2.43.0



Return-Path: <stable+bounces-93770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A249D0A5B
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 08:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00931F25160
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 07:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4F1474AF;
	Mon, 18 Nov 2024 07:37:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C72907
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915461; cv=fail; b=JkOVl+YKBdenhf1fbr/C9VrmlGts5Kp2kGWrpTxNVEXdeat2lYR2P6FU8OKR+iYTiJjWDR7NiA7xKOpYRf5S9Q6vJLTUQ34szunycEiZ+HiIcaK+njXjkhN7duw79bbkTmiqNv5OJAW8ZgcdgTn6mHpKcvBFeqvcUDOn9niHwY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915461; c=relaxed/simple;
	bh=CW020Mgn/0/dt18vVlPxt1DHJr+kFQmPLFLxiXI/bu4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rnEn/LmcAwf1d76sTQifIpfwvYXkz+t4hrRQ/UaWCLhLTIjBTYRDwPg0W4tQieKwi5eYFe/uFetAtsGe1k6684Cr1wS1pBWMSYxrSWWQumvfU+fcg5iIJaHdkO0icmGwm9KqMcV8SVrA3t/kIdwoMxdAjBVqjRN5KslDx0Txj4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI5mq2J013280;
	Sun, 17 Nov 2024 23:37:33 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7sa5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Nov 2024 23:37:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAta8Uta61mqa52nLxsTzl1o/1TzYi/ghaHAlrgeFKwNr8iUIuPWhBVjwDxSX2wBUTkWQ/vz6NbPDdFsaeBrRhFAp94rUH6uNOMDyDAN68j010k1P1NsAEhmHX7NX895JMS8fRkWpsd2nOs8c6ICwvEAsgMtdkIeMxflvEp8C8r5QkwssAuQ/GxvwSqDoRbCiopVLy6YIzN6fStw9tMtQQHSXXCoMOYfhoUFnyT4fNlqJYw/iASc9oI8gUOM4hiniypPG+HtyQQtnC7la0pqP3UdJRU7ad6wjShqzso9Z57ALDR23yFbyuW1HiAEnlVHYkp+jk4K6Izjsc5LRcgPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puhYL+fokfOgxrH65RSB7bZihXy5NDs2jrSWJ1cbY+w=;
 b=tm/v68tLFidJkSRbgvw998PpcifDgEyuK4lqKJwZToKDVXwMw+p6DNW026W79QtZgU5Zt8e1Yua0tyO1/zn254XHzjotuzBhNUhiB5lNwB/ZUlo6elNCMp8QLSGGBdeTh9en90HqgiXFb6LBOqYirLUEO4EKiabi7RPn/3dXk03ztzaQtJu0rZdjwWDvHAY/vyW+12XFqxfQmV/qOLvCEB7LS8jTiKpj85zTiZWoGaQ2v1HLmSnqqv5gTwIHjCplsXRUrkIZdl+mHw/m5qqoOvqCUNR7tIlGwL+aIlM26xEC0fXv3N/3l4vJwEJkvZODkbN80VYUa21PM808RtKFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by CO1PR11MB4867.namprd11.prod.outlook.com (2603:10b6:303:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 07:37:29 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%3]) with mapi id 15.20.8158.017; Mon, 18 Nov 2024
 07:37:28 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com, edumazet@google.com
Cc: gregkh@linuxfoundation.org, xiangyu.chen@aol.com, stable@vger.kernel.org
Subject: [PATCH 6.1] Bluetooth: ISO: Fix not validating setsockopt user input
Date: Mon, 18 Nov 2024 15:37:26 +0800
Message-ID: <20241118073726.1726166-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|CO1PR11MB4867:EE_
X-MS-Office365-Filtering-Correlation-Id: efccb313-16e9-4e02-1d20-08dd07a3daaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6pb3EcLTBEg+LPg5lU5Nn3YHPb73nxXnlxJmZeIFWaDXtVvH1T/UjMRSxD8p?=
 =?us-ascii?Q?GwKkTxXlNtqVAGZri8CrJYi1NbqqOOlMbFDgtmfeUgnR7gIasYtlPWnBclkq?=
 =?us-ascii?Q?WtiBCoyIlUXCSbHppOdIjrQ6c/0RrZYAQpCxPj/TIowSfiUGbStJPGQ2mWLv?=
 =?us-ascii?Q?Wt4dUxGlqK4xKTW8NiBfg+imRMlwntR7qALoFiPrwhEqaI//j1yxL5l8NMVo?=
 =?us-ascii?Q?gOFgAxjKo04hEZlfSopIrutFBhtYIP29bH9j1qt2eDHIg4UTKjAS/mp3dc9F?=
 =?us-ascii?Q?2ti72DChyte8heh0WVwkc49MFW8UX+zfxWQos75WIQ+DV+2OiJZAPPfNHVTX?=
 =?us-ascii?Q?Ax6IwDBmyuDl2vtipHFc3Rv9lfje2T55Pvd30rEjP7hoOiZDBsqKR+Zcrj3Z?=
 =?us-ascii?Q?wD7y8TmjEeQ/+RJFHinwYJUtduMGEVpKY/jg9xaiN1fOumPN8reVKqG0ODG+?=
 =?us-ascii?Q?v6cw+2rvjsCuXduL/76boNiruXhGz/3aCZK3uXid0dCpJZJJDwdTLKLRJt0I?=
 =?us-ascii?Q?/MYmdrjJwhBUaag+ZrgUfI9w6HuZFUMkvdyE45htD3NkE5Yy7dbWD70Yj9QL?=
 =?us-ascii?Q?tRRhEuYui1EVDn3JvZffpmMCsKUZY7NPrdvzzZmWtYNKXFA9s15feqq/Nfqo?=
 =?us-ascii?Q?v0K1YYr/j8KlLmARNbwcMPcRC3RkkGALbMattEIpZ+5AXiqcpuwmTVg+TaQO?=
 =?us-ascii?Q?zNEoOaqlGA3kukqNN2WcK3TlEyOX92QzEy8+HBgkkAP/nEqcdfI8lCGdEF7Q?=
 =?us-ascii?Q?EDgSWpFSRx8jDyia/MupDVmufgQTv0k/VUKSdeIRUIPfMmAPmrslcGphk8Qv?=
 =?us-ascii?Q?Z4kvGoitbfA5s2pAgc8NAPpt5OUA5WgcA6nSJ7CBvT4GoGJ3CmVahC6sGOI8?=
 =?us-ascii?Q?NHqtacqMbSAtf5p10muL4HpBbvfHBQoYtZmOj6OTzsTvN/J7Kj7KcJjS6Uq/?=
 =?us-ascii?Q?wAZ7yYRRP5xiguBlC6QkQHmX5j1oG623cFx78IYWg06QQilVdpprV1E4eu5p?=
 =?us-ascii?Q?bUSZtwkoX3yPSULJ2TObRPU25JbXOt63seO4UNdQff6zoQMZDZ9miex2Jx5c?=
 =?us-ascii?Q?RmATvcvS0zBIuw37jhIP8gPKmiLQu7EkJ3OXTEy8Gv1MgLGtakmQcUuOlUA3?=
 =?us-ascii?Q?5k5Ne5ZWAStAealXB/FC0+feq0PnR/458rOWzP6Ym8zlTcVPxFrKyTHiV81/?=
 =?us-ascii?Q?v6UoPmXNRPgO3xZKKdQRbyov35E/hmCDLvr3XAn/mF41hqZdJ/EyaUhp9MTp?=
 =?us-ascii?Q?HI1td/pwo/Ha8HzMBJOuuips7666kecZqZduG9dSxbZdGREx1v1Zlo1uFf3J?=
 =?us-ascii?Q?6CT1befYuGutCba24rAmW40R/hCa542pm23+W+PduGU8RU1YRGQoCy23GBVa?=
 =?us-ascii?Q?VawnPSI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0+gPlYJ5QtF8gayj1qv56Ys1UalIGdK/7j4HqLpUuYVfAaYI0lWS2AYd1GZt?=
 =?us-ascii?Q?5GmkzO6oARcqjOgiMUn885XSgBaFj8fqsy4OU5KAFzyZgZaVPe+rqeyHEk5T?=
 =?us-ascii?Q?S0F1ClcyM5ntQMARqYtaBQlIzFeYdxNaa9SQfGaTbUASE18iYM7C+y2PQFSE?=
 =?us-ascii?Q?2//6YtQvyHpx/McCuYaGrUSdHSU33MUz8+YOA9TM9Jd1Eaui2GrfM5gz74Qj?=
 =?us-ascii?Q?PYPrw6ZdoD9qvccr0a/H7eJ57MCw3GUuSnJrghefL5sXTbnxUpM7vVXCZSTK?=
 =?us-ascii?Q?P2tAzj9lidirK9u9tKssgQZwWY5po9/nQYr6h1opgEYNSXOJ4bXyH9VstX/9?=
 =?us-ascii?Q?T79vWCiRjl7TSziBkCRDTL41kJKhLLHgH7toM3Fkif2EBxfV+5J0zu0FUiSE?=
 =?us-ascii?Q?k1vd1GNmyDyBMEhqm/WWjJJS2uNXLgYw0oQzk47kUgEl66Z0abzGuBBgOpHS?=
 =?us-ascii?Q?QaHtY2ZjgGSWOVcp5LT9GQ+h9V/HBAndr3LK2f5G9nv4tds3fBG/BnPYDQZX?=
 =?us-ascii?Q?MvVfQV1EbQ55XoTxTLLCEoa2b6M2rBmvOvfdJDMc0gdafcvXGWj6aN7erBt+?=
 =?us-ascii?Q?DIxfbaOpiBMqKuL2s0cwCTp+k0GhIPhV5hA0gnTKAsMZ93nSfcz4pP2VD0OL?=
 =?us-ascii?Q?kw0onACi0XagJw92YogroBXcQlDEI+ka4Y3pflDhnoLAjFXWHFyoXXGzaVwe?=
 =?us-ascii?Q?p9HdtEZxtIoaMruZH4ky2nmL5O40dqNjCZHYiL7Qu99Lat9glXldomx1oVbY?=
 =?us-ascii?Q?ax61Ya0/UJOZ9YcmFfRl9PVH42rV7F+QKqMmXk5VxuwMXN3wvTlqRPpwtiPK?=
 =?us-ascii?Q?CtCobB3woJjpEQjMi08FoFmj8YzTnSozWId3/0Jozxb+zI0YVljfC1EzzZy6?=
 =?us-ascii?Q?zs6T+yR5ShwKxO0b6dUWeI2wgHT0lFMAo36gUmBwQfUJkma/OMJTN8ZDxA0l?=
 =?us-ascii?Q?sCVB1x6eaYLFMp2Hb9+TTJt8YHJjB+v9m0bu50btyCFOzHv6V5Cbg4b3Rlfq?=
 =?us-ascii?Q?FXFHLvisvLM/LzdivZREdGAhDDBCfKkF0c3qIFpvRdgvYe660p+uUQ8ud65a?=
 =?us-ascii?Q?pV3w4Mafjo6YSCh1RbCer61OM3rRPf1fkQWWEUSsWNatl6L6VdB6O8VuRNfm?=
 =?us-ascii?Q?QVa9xp1+SLOSHXHIRi+2DnINNC8jKLNmwEkcS6bMyCR4cBgyYvtkfcvI6m+T?=
 =?us-ascii?Q?IwSaTb7WNit2BmifZfbGi22yrrjNoH2y3squWzhEZ+OJTyBQci1Drq+I/QMG?=
 =?us-ascii?Q?Kwt5f9M2Wo4NhrtTQUvvG4emqIzVpaBbg6Xvf9nUor5Hrimzl4YU+bStNrV+?=
 =?us-ascii?Q?Shdjtw4YuyU8ZXQIoyB8DOEbB5OfDJFVIx4vm9dBShNPSKTI3vOaRqm+J6Xg?=
 =?us-ascii?Q?WrYpI/TsLoNpkRZAM6C+BIG+ZfTFur8v99tmY/VizY8ut6RiZb8wEX6Z4GzE?=
 =?us-ascii?Q?PVBCoBZkp2xiPNOgkmDtod0rj8VOWAKTemSjNTSbMqiY63gIxCpdB35UzfUq?=
 =?us-ascii?Q?Tmr6E2R1KXYl0SdCOzh+htQBmhyk5Ijm3OABEJuALTmBj487PkIoRxSHxq8f?=
 =?us-ascii?Q?g+FeOaYGnfV53cAbMZW8ahNnGwMv6eBDVthR44y65ik8GGgq88S97ErJRc8X?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efccb313-16e9-4e02-1d20-08dd07a3daaf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 07:37:28.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6VoQdYHE1SHUPjU4Ekhlkrcni/zbpGDEGcODdE8geWi9Awz3kpSSD9dCJ+LS7/B/kysS/OfkPL3RNGNbJKVcFpnoscwEmCxiXs0FRG3Rq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
X-Proofpoint-ORIG-GUID: EBumK2HqNjl6aSi_ygUKf5seI5Tpdrps
X-Proofpoint-GUID: EBumK2HqNjl6aSi_ygUKf5seI5Tpdrps
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673aeebd cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=mFO_foe95_PysOB2XO4A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_04,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180063

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 9e8742cdfc4b0e65266bb4a901a19462bda9285e ]

Check user input length before copying data.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: 0731c5ab4d51 ("Bluetooth: ISO: Add support for BT_PKT_STATUS")
Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-35964 resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/bluetooth/iso.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 27efca5dc7bb..ff15d5192768 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1189,7 +1189,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_iso_qos qos;
 	u32 opt;
 
@@ -1204,10 +1204,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -1222,18 +1221,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(qos), optlen);
-		if (len != sizeof(qos)) {
-			err = -EINVAL;
-			break;
-		}
-
-		memset(&qos, 0, sizeof(qos));
-
-		if (copy_from_sockptr(&qos, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (!check_qos(&qos)) {
 			err = -EINVAL;
@@ -1252,18 +1242,16 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (optlen > sizeof(iso_pi(sk)->base)) {
-			err = -EOVERFLOW;
+			err = -EINVAL;
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(iso_pi(sk)->base), optlen);
-
-		if (copy_from_sockptr(iso_pi(sk)->base, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(iso_pi(sk)->base, optlen, optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
-		iso_pi(sk)->base_len = len;
+		iso_pi(sk)->base_len = optlen;
 
 		break;
 
-- 
2.43.0



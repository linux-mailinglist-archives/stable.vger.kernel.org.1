Return-Path: <stable+bounces-95617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A849DA62E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 11:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87421282BA5
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251051D5154;
	Wed, 27 Nov 2024 10:52:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3B198E85
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732704758; cv=fail; b=SNNpSveBelSlNgC+X/EfUMFGeCGRr8ReX42u5zMbB0u/IZLStVom/qf1+ot6B2KY/7P69kq9kevnC0yXrNId3UXaVMuX9SrPaSYmAcR5OrKSfste5gE5CoeNg86e+I3qxB8xiW1p5n13+j/TQortaJYnqugFkLus/HXxZMAN3i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732704758; c=relaxed/simple;
	bh=VnojQD+gYHK+OjyfgT4AzMQeZ5umIobpuV2yghkH8tU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GQISY8ohqEnNHGCWVBkrsPDNT7LTU5eJX5mE1juiJvKeq2E7SDZJV4SqTrKUJGvkiRuk6W1vihlCmz++luAXUX5vTev+rD2Lro1wnddlfD6heQ5XMW5qSsRQO+A4jHlXqrOcm5yk69bfEl7Qw9Z+6U7nwqqcdidQ9HKTOvrBoXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5QbGP006567;
	Wed, 27 Nov 2024 10:52:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491cffe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 10:52:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1b6WTtLfJpRzOyV9sgfZEIs6OQYr3n6Z11VC6XSm0QNKD/D/QJZCa0hAvmLxvVkBw5K7CfaMxDXi3MQm70PXt4mRtO3leBThWLu0stIgnds6sndHzcBrveTFvV8HcubAo3IjmfAmTuS8ZaJF2aIMcYzswKqn3Fxo8yQ8xzx3LnknzhTC8ml4SBwb21FY9Z2Yr7m2uEx1m41dASMrEkRKST3/Vuj7iA4aq267ww1nBXOqr+U4BgPjx6gtYdDb2avJUzy1E5SdwM9x7sUYR2u3roLuSO7+drqfmtIVdROW/VFzWMR4ZZgkm/vj2GPhZdJ3rt29HHLdSTViAp5rxnaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecpWS08vFs4y5ju9ABswhJi3HVYuvZ9c/6LOqvbESb4=;
 b=sWqNBoPtKsh3dF9wLJFPlMDQyOiFpobZfUFoOPAVDHxDQHXecrpN0MgJEbkpZCYvSen/K6EWoiEsdrko9Z1zdgBSQUE6OdOD0y4qLZ6q5CkgkGCNyPQFdt0j/bPDeJZt3JVUSa2iyAfTrJPMFCz0ZiSVcmcZitwXiXgy4/iOy1miTmjg2d+FCfW4LVVeYkaW7uWfWOzOg5O/vBo4TyMNqNf+Hxfgfuxjfu5/OZMYaLFr9+Gl/feIOIEEBsRlUb1h49u9pCHG10Qf8Yk7tw9FsgvEho7kAJQEbq0thDm4GMThsHseaAFp2Y38mWpBmkVKw/vkgnwyO6Pj+s2921QedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 10:52:25 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 10:52:25 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: miriam.rachel.korenblit@intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] wifi: iwlwifi: mvm: avoid NULL pointer dereference
Date: Wed, 27 Nov 2024 19:49:59 +0800
Message-Id: <20241127114959.1859460-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|DM4PR11MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7a73a7-ef1a-4206-538f-08dd0ed1941f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qC3Cxof9nZndJASSQU926fkBDK2U/9N/5rgzBigHj06rO4mF0l9VUZX1+2P3?=
 =?us-ascii?Q?809aOPppr9fN9TdUHKlW6emhYY/Zopopn1GEwUvBmRVUxUT5InyU36Y/ug65?=
 =?us-ascii?Q?nSWRuL+zIclAE2ehVvDIj+wF+nYvdE3mpoLfOKwSgXqf+DIRXZQSWErbD6io?=
 =?us-ascii?Q?enil6yWZBVgkfGKw5SFYn5gvSSiqAPpqufJ9R+pfnDZo5yeoP3UR3efK+0CU?=
 =?us-ascii?Q?8Vva5nQND54u81E/ebE9/5FoPX0X/xZkULqHEguUcpFHemIp/4gYZHuMFlhI?=
 =?us-ascii?Q?1pbBRc9bnKYWsiTWivLWPS/bT7WLJI3IbXwpZ0H3wrUFRVZsttU3FJy1oFZ8?=
 =?us-ascii?Q?osANElNPWbi12Vi8j44/ocke2K6Ag2ffNFE1U1PQ8rWBRcGl26+JTcP4uJYS?=
 =?us-ascii?Q?TPh6upkB937dy7qssY+sWWYh9Wyzf6l92Ec/8VlR/kfWydm9aIwZiQ0BsFrF?=
 =?us-ascii?Q?a3+Jg4GmcEAC0IlNbvoIAhLDfkekA6LI+rpq5vthwVbJFDNuZuOGI/SzMDEq?=
 =?us-ascii?Q?5dKA16s8TEhKQyflQUnCOG2J2gu85b5ILELyK1J+9Flvf8lQ5D0loIQf629y?=
 =?us-ascii?Q?KA/di8SRZFdWBSC2+fX/ptjy53vvrtkvnRgoJHNTwnRPW+pZpvM49IzQSNAn?=
 =?us-ascii?Q?R5XvXeO7zmDuy9hJjWfPLXjWtNzTQdm71FEnNGcLKDi5N6jprJMx+AxBVdKs?=
 =?us-ascii?Q?6ezT0BC7rtRDtWhPDZeHx4iryPJ2x3PGw0fOsgSFTvKlQ9luY6G7pSozrROT?=
 =?us-ascii?Q?zQym01/svahU/N7sQFEIxZPssG8DMHxbho2a2U7X29gpfdr8qKZeG+VcF4Rt?=
 =?us-ascii?Q?jLgg4K1iKuvtUhyvbvKjB4035jAbFXGAJxgFWr0gaGMQuJqF9BQ67Ve2botQ?=
 =?us-ascii?Q?S+E3DpQXXVBt9Q1z07cEl1HHVCOweIBdMQduCdt5576OwGluZWmGePbNrsij?=
 =?us-ascii?Q?smfDt9JJsVt/qTORkf5mA7/3aL8AKf36UPBzJE6wmDHaLNNW+NJkEskaNR1I?=
 =?us-ascii?Q?0tzA49CBZIATefYqxQN2lM1tSjxcJ0Yb4/igEpmb10q6anubQTnHFTp+rVnE?=
 =?us-ascii?Q?N64WVk31RGg+jQXbG/ikPTZ+sPXdA1uDLiVfb6TxLs9gBcHoUcJxC+S38CM5?=
 =?us-ascii?Q?Yv1Zf/0TzMeQBhtuWe6VE72AWGZTSmFm9OJOZdvERQ1jane1+qQfJqMCl9BA?=
 =?us-ascii?Q?PlSkfIfsX9PFp918GtfZAtE4hkk+qt+JwGQlZdQVe2yJ1GfrqT82yAwWYsXB?=
 =?us-ascii?Q?tdeJfcH7DyVw5fnTfHtSsfWAR8qxXvVuSTYqA1W2MLmfdegZSSlIZw26GKpu?=
 =?us-ascii?Q?t3cxTQyH/gIYu8zJvnkU1nNfmCE77H3GPbQH1ob/whpbDPGF3T3Gv7cMwFZO?=
 =?us-ascii?Q?SrPlGxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+/5w2UHZo1wkmFlD4T34SrjMVsOcHT8ezpeiHmjgRb5VgDLg4/ZV6OMRpxC?=
 =?us-ascii?Q?5zQzCqzQd2JztQ044Aqw3rSkZwuRbtKc4baoVpuJtz+viBHJdlO/tlh1bu5H?=
 =?us-ascii?Q?WUVCoKSRI6tepLOUo5J3APgLjnkoGZftOQYKFtFDZVklSa/cLGRGBtBZIaUZ?=
 =?us-ascii?Q?IXpQ3Nkm9tfw7mEjDvAEs/WBev+FYykZvQ26JDXjcy1vtPkVl+51+XvDCeUv?=
 =?us-ascii?Q?sj2k7475/+NK/2q5dxvX0zMDWvaTqIwGMUPa9XkojSVC/2DsDEcTpbASCOly?=
 =?us-ascii?Q?QkNcqOsucj9T2vUrYSoUfGZA58GDt2QsGsjTxkxtVrfXZmTV7crJFOd48b0z?=
 =?us-ascii?Q?ey0r8JWdLD8Vd7fMCAehtBFdhY1tEjiTPo+N35AJAGmTbfpiyV6slbDY0CAh?=
 =?us-ascii?Q?KLZa7ismlPl0K3fDjxCIdQwcOd5g7sId/eqK7tm3rFApujxk8aNg75bE4h6A?=
 =?us-ascii?Q?ARhI26T7plTlOGu+KjIDfUpTwu4dAbuG3JmtPp7Xn5aA8BN0JJCfGy7OpCM/?=
 =?us-ascii?Q?bpiM3c7JWLQtT3R3aEX4YITTM4c33Egf9gXTZutVyqY08Ks3RAiwrS6nWlaG?=
 =?us-ascii?Q?NpQQfRiygp556qESgaMCIRdGQYn/xGJSTXVa+7WBN7bRLH8SlKVMdmhQqtHE?=
 =?us-ascii?Q?Bl8Wlo7liZk2S2AYBct+CA4433D4mmJlkf6Pdxa68YNQzgkGPXbMKkJ1Q0uh?=
 =?us-ascii?Q?vXg82chM4jeejF0HL9uCMgTK1ooMeupoSqokvNPPfn51jaUpJjf3sLGN6Dnp?=
 =?us-ascii?Q?pstDeGVWX6XTvJBbJRYECm3CUdFwOILOZB4trBz6pmk8Q3TKq+Aq9hEMaiEp?=
 =?us-ascii?Q?OevTQEKAex2s4CMMrkaoFFqKfxpUzV+eR+EZSWGFA07yQrlEMvpybsng+XYC?=
 =?us-ascii?Q?vTbqycr3OtiYVzC9UnUujPAtcysx5BtaaOFxgBe39DAMvwnOiQijJYlAOyxT?=
 =?us-ascii?Q?S06R6W0uqrAzfLZqSxnsOxQZUyKnKCSEGfeJtwnUISgeJTk/D1hxFZl+2MPG?=
 =?us-ascii?Q?FxlSCd835lslHjSa/sEHf8QL6QCMedG8+Uwp/xGDy1pyveK3SmA8ils0e50l?=
 =?us-ascii?Q?FAcLqFAbTFJBKV3eXI0kADUWnAf4IISTnJ+zXu+9mkFM9q5x3yneXqqYlDVO?=
 =?us-ascii?Q?nKw9CUFdQGfaaACnPh9ZSB/uttlw1Czan7RSwICh6Ug6HQ5rw8rs2U+Ph+gn?=
 =?us-ascii?Q?lwIw1kkGHwDBUrHAHpa0vLV9m+FWd1w7TYO7OOxlLq6VdKaYTTuBMgwbNp5n?=
 =?us-ascii?Q?PJnIoqyCtDmTCCSfZjR/9MpaXG4Y7RgkXLWgxBjla1dPPoTAX0Q+eICpxBvh?=
 =?us-ascii?Q?eSsWlarjh/dX+SPsnV9gOiANAF78B1/vZAPiHRBMo0/szFTAsBz+82jpW6G9?=
 =?us-ascii?Q?EHqzIbwIZ4ZL4gbOgTgLZRx4zl3yNG+tPtYTwhtKnavQOYMiASETMSF95dzw?=
 =?us-ascii?Q?l6R7TtF89s/6GGu07PFBVogq06OCI8U1uMEhJ0S2CEu3N7u/U351p+gbl9qM?=
 =?us-ascii?Q?y12LfRYpSCAjrxwcWBbiO7ud+sm3NBM/qc8kmrZIyl/c/GTWLtArMtjTxi7x?=
 =?us-ascii?Q?O9drpwFwOz0Q8qYctJz1eZUYtoHtqZj1+UTKUoAcM19XyHMM+EVbQ18D7BSN?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7a73a7-ef1a-4206-538f-08dd0ed1941f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 10:52:25.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFLg4b+Iod3JoyKwEfAYDjlV5a8QPdN9fVqL7iaaEnI0F+aFpZA+VQWVcZVNDwzJPIiL3eXgeyW7KrTQkOZyCXyJAqZY2AGAK8ckGJLG+yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=6746f9ef cx=c_pps a=kqCqMoaEgQjRYYKBKtAp1Q==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=bC-a23v3AAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=qwBZaHO80BPb-i7lXrEA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: OqEF-4_Puy3dj-KzvpHuwMjankah7WBp
X-Proofpoint-ORIG-GUID: OqEF-4_Puy3dj-KzvpHuwMjankah7WBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=883 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270089

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 557a6cd847645e667f3b362560bd7e7c09aac284 ]

iwl_mvm_tx_skb_sta() and iwl_mvm_tx_mpdu() verify that the mvmvsta
pointer is not NULL.
It retrieves this pointer using iwl_mvm_sta_from_mac80211, which is
dereferencing the ieee80211_sta pointer.
If sta is NULL, iwl_mvm_sta_from_mac80211 will dereference a NULL
pointer.
Fix this by checking the sta pointer before retrieving the mvmsta
from it. If sta is not NULL, then mvmsta isn't either.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://patch.msgid.link/20240825191257.880921ce23b7.I340052d70ab6d3410724ce955eb00da10e08188f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 76219486b9c2..43a732b0c168 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1105,6 +1105,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	bool is_ampdu = false;
 	int hdrlen;
 
+	if (WARN_ON_ONCE(!sta))
+		return -1;
+
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	fc = hdr->frame_control;
 	hdrlen = ieee80211_hdrlen(fc);
@@ -1112,9 +1115,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
 		return -1;
 
-	if (WARN_ON_ONCE(!mvmsta))
-		return -1;
-
 	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
@@ -1242,16 +1242,18 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_tx_info info;
 	struct sk_buff_head mpdus_skbs;
 	unsigned int payload_len;
 	int ret;
 	struct sk_buff *orig_skb = skb;
 
-	if (WARN_ON_ONCE(!mvmsta))
+	if (WARN_ON_ONCE(!sta))
 		return -1;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	if (WARN_ON_ONCE(mvmsta->sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
-- 
2.25.1



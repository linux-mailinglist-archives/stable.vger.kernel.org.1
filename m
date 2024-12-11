Return-Path: <stable+bounces-100572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BCA9EC767
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07241889BFF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87311DC9B0;
	Wed, 11 Dec 2024 08:34:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86181D88B4
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906063; cv=fail; b=UZ1ZMYt0TX+xohXSRCbRQtAMQeSOTw5Zc0jLgIrhykt4NLi11aPM4EFi1EwskByBeu7TAQ9FifLK4kQIFRcOPJQy0oaKAftvCvVakzL4M2QNCgkAvwxjpEClyQj6hvDX1x4HnA0LfnDPcIlHLKaqAIMK7+b+2W1J5unTFoIv8a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906063; c=relaxed/simple;
	bh=WVrbJdJP7dmUUcOe89ATAJIyrMtMJ/QX8ZaD4INdLBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GPatLgUpvXxmLWbUj5bkoQpRnOIjWp6EXeQxXtTXvUDZ27ZvEVVU+p8ulkmTXLp95xu8B7yaHVLP2k470oiiPaWtJcD82a6Nb3aq6/SHfJk6Te0/yE0ywgzy3nNbAuI4vq2doOdNGxqZpIdipk/K6cMplkces3ofoujLQ/Ozw5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB5e2Oq018795;
	Wed, 11 Dec 2024 08:34:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xbx9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:34:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKGHlo7Nn4OxLszlaWejfHXQpJC2DzI4t79R/aVo608jxuUkUSemZYBbpaRDnOvKSctmpnJLmuxWIioRu8yggKzOY9KTU3X9Y5gO+FjdDKmETbZDPNNgfPZkaKg9RLOV31fkzybu+ew6k1MJ5S0X+SoxKjHv+TUFc84OY1bVHfqw4p0SOAUaDScCiysk+af4XyLeyzfTOKTiKTclNPfwo+xPahRaE3uiUv6ftWV7uVNCp8RWHQUDO6EJekG6FzfpPuwYmcKnzDRP/SDYpv9HsXtUmHwPN/hjSMl7Y6HwD3s0Qc125kbdbHcVpKP6ExQJMZWXwq12ovI4riOUv/MxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHwCrrfFyFJOEEgar7OSwX18gys90GJdhHIuURWMaZU=;
 b=GmCf9LDY9+AJ9gwFelG+eMb8oQmX3iwkGHczTx/GT+qFqyPE7XCGd8M1Qs0xhcw4lAShgcTWhJdzMiH4cyK8xhvb/DGfxWSzAhcLUZmqyGNLfOXWVFMJC2f8gJNGjgXYOl+lP5acIk96crKVAmyWziXNbrw69sW1SwpwDo22SqEryt8i//S5gdeFsB26MBdJ+ywkgecrtrcwrSVOffae+5HcJol7y1zpwIN3zaepvDGlX4gb0aCk/BEI7VoDN14H2ymjIXkQvai9Y4vxd1qw0I+4hZxg2MBEgChQ1F5JEyFBun66ZCwJQuLG+7qTfHVsdbUl/30eKFsR1y0V0O+uOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by CH3PR11MB7179.namprd11.prod.outlook.com (2603:10b6:610:142::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:34:13 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:34:13 +0000
From: libo.chen.cn@eng.windriver.com
To: stable@vger.kernel.org
Cc: willemb@google.com, edumazet@google.com, kuba@kernel.org
Subject: [PATCH 5.15.y] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Wed, 11 Dec 2024 16:33:51 +0800
Message-Id: <20241211083351.235475-1-libo.chen.cn@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::36) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|CH3PR11MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 779f1b6b-eb8e-413a-21ea-08dd19be9739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eHRpp5aJ7mJj29q5jW+F5AxqQf5xy7Xj7xQMBtjrU7knuk677bt4sAa4I6s9?=
 =?us-ascii?Q?Q8WmVku2civPcB0e5d5uaPxfIWhnepNT8DtA0/7UrkPBffioy8UQwc1LE+ne?=
 =?us-ascii?Q?qTRpjnoKiA/SZLO3kXKxraOFF6nqPqTNa4zmmmwEQ1rHNYMenHGygM17Ihla?=
 =?us-ascii?Q?o8jmhgFxWKxN0d4dxmFVasr5otAp8dJQ6g722yUjjxhyPKDZw1y33Ui+T9sd?=
 =?us-ascii?Q?UyjfJu9RHyubkhDE2PwjfYeDYdUde2Wvjab1AWU+5udQjFinC6CPKL4FkzYc?=
 =?us-ascii?Q?+cTsWhJv5T8CMixPMFCEc2/pCneZL9vsHq4K68L1D7X/pMwlTe27Ovrvzxdz?=
 =?us-ascii?Q?gI5hdt+MCO0ZuwCsYtJOO+CJIXPpoKByGLY0GSOArZc43CXBbtM+4VnR1ps+?=
 =?us-ascii?Q?05/r6FPE0rqdOZqeYJNa6OXhXEejLEPMZ1EUyhZCq/fia1CBFJUf/u6rzUT1?=
 =?us-ascii?Q?2sGqYqe5e8gEV2AetZSpbG7/gtpnEYjXKysdnk6SaaskbbpxrG4lJRnWA/Hl?=
 =?us-ascii?Q?swVVIKy4Upv6LOBD1c0MJATxhZzmBxoxmEYJOFIDj5+bND14sZBZ18I3J0PU?=
 =?us-ascii?Q?OyG+zxwh9SUzHDuxdrrcwQJrLWBpzrSFNCuuCuPLEZr9/7ObqXVWVpzz/Pdk?=
 =?us-ascii?Q?g0uHA9zQp8eNSs0EmW1SmvywBBwSlPmcNnGn2Sen3aRBr/V7d+rI/px/fhi/?=
 =?us-ascii?Q?4G1RbSNIAQeuedF8rvUcA+R2YebXXn17h4cDLYXBWKmNH/e8S8aKRLPWE7Vt?=
 =?us-ascii?Q?dC2Z2qoffqM7QP6RfhfFzRVkeGNbeqgm38loWd2rBSkKgPYHTar4/tvNYflM?=
 =?us-ascii?Q?AdyGXSnFr8vQEJ59Ns58dk8C+89yL28HYDUYso5cNKsH7FKJ7BZuZxV3pcYX?=
 =?us-ascii?Q?9h1NuHGEK/DjtIoNsc8KMgb05rEwrlyBTSbN7TcNRybj933fhgEdK3KQ1ryn?=
 =?us-ascii?Q?nWdp7UDTWedZcwD0/g2wHYfJpBWO/3Q6wrM9C/WD/BVMzXHJWM4mbzG/I8U7?=
 =?us-ascii?Q?eSgeR2w/6YIYCaes/FwHScym8y/+e+BJi4EeYjT/U9E3+/4vc4YtQnY1hMPo?=
 =?us-ascii?Q?XNxDyfF/Q+4V1M0FgPqo+x/cm2MG3SzaqEQE/lRi3Pyzs97ORv225qCmQr2y?=
 =?us-ascii?Q?KQecTi55Ps3U2DbPk7HkrlwNLd3KXlthfuWtfjwBJ0RkIr0PZ0CIj5/uDZr2?=
 =?us-ascii?Q?n/NOSx3fPlc/fs3SyB8AQwibvjpBB4acvRPVabZSkyJL+dYS62/dT59RVGx5?=
 =?us-ascii?Q?SoTARJDu/gcGORiaj7WTuP92qOL/nkbSTKuW2FKwrDrcWQlg0UQY+5oeTBUa?=
 =?us-ascii?Q?WdhDr2qw1j97huWniKw6WtHIIpO1KF/X62uJ1eATG3NsHjjoaXqS1BOcBlbR?=
 =?us-ascii?Q?MZ3BFjodaA6eeXEzg22L7b/FM1UTaPZPVcn6RuBprhtb6IAyug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqp8mKlvQqxHTSRU5/UegBxT2s77FTDyInhlA7VjVN40QWpduBOtMxxWOhYB?=
 =?us-ascii?Q?Kmj6aCLZD/T9w0DnTnZUOSKEUIvWuOQ9BHSKDJ5Vsz1KJeYH/K4o6LusmIVG?=
 =?us-ascii?Q?6i0HqoQA0dU0wm9tkWUFUzfuSz6MmMMaubTyCO5FGralaBlKdd5IB4ngPd6I?=
 =?us-ascii?Q?IvKrTlx9pF9rBKg1Riwxun8o4lVMbJPsv92RkE8J/Rp4R8qG2F/HvYG0+CIF?=
 =?us-ascii?Q?rCACymki2dbj1SjNwJv24UI99WvY3W69bZNaMZsWRJ/JPszvJ7ytNmGX98Pw?=
 =?us-ascii?Q?awTy5GfTKiJc4ODm6dRhONgbRp1TbVb7S9KfuyUmvHQMKnUQ22pow/GknErV?=
 =?us-ascii?Q?2utf9Zvtry/D/xBTRVdGEwGs7i3OxqDpK/IaYtR7CSKASUjaF/Dcz1Vh+6ab?=
 =?us-ascii?Q?y60nZiKIFXND2pYtf7ychGDwuSkPPO9QojwuyliCqNOtSy4YP3YOvFOzHgmK?=
 =?us-ascii?Q?9MdWjHOGx5Jhtlr1sRXylU592Se1BjqcKpPW54zuTGUc8jUFToS6PpsKFyww?=
 =?us-ascii?Q?o99q/z1uRxR8SYmRGTbWNMRr+KlPiSUSzA4XxT638hbymuLEK9GjG6e/JT2A?=
 =?us-ascii?Q?CTF8J5/1X3aeFEVOmlJMqO9iLM/Ux7S2tPwJIDQjznNoknhy89uervaMmFSq?=
 =?us-ascii?Q?FGyF+Sn4iQerVZ4BNj7CWeXbZzqG7Ul9D23ZuyiZhxb9qLceub+hfky+4g5R?=
 =?us-ascii?Q?fiHk2trv3kEy+/p+Vru6UzDYNIg0g+9Pnt04pSJ4nVbUujadz5QG/WFEo9BF?=
 =?us-ascii?Q?nSDIqXrJzH7rNkritjxuYIdLn2nqW2n7SdefDYa2qgl6JWRyAAi64DQm+qpt?=
 =?us-ascii?Q?l2jTy23+hr6r0pASlQfK33Edz0fdTLUGEE7aN9AhgU9OrojZrQIVEARqqCgg?=
 =?us-ascii?Q?1TmwPMu1Kyk0DPNWcT37n/ChJZ7iYiSE+P5zc+gXLLX64kT91V5c8GGywf8y?=
 =?us-ascii?Q?QuZWIwogAltU1bu8UoCWNaPxku17nEskHLog77U3VvFu1gYC4yEEq2zNRVEE?=
 =?us-ascii?Q?t7v2LPuKSpaGNg8SIrvRKzYDvlvxi3ZSI4SjIv9xQI9e1oPUb0xN5SUx9TWq?=
 =?us-ascii?Q?yYONgqDzWXU+epEVP/9nff4eHmvAJdVVr7yKN58koZvmCrYac13F7R6v5GpG?=
 =?us-ascii?Q?IwqzEpkYAkmX2KC48KmxbkzpMx8QCppVJdKEqJEjrrky9mj/6Ta5dONy8R8X?=
 =?us-ascii?Q?wXNREnVdyC3AwwMs/NzUMtGjYfL5pnK1+g+5EsjiZKKQeOdKNhmIRXT6UP22?=
 =?us-ascii?Q?+NFpR/PaiXejE1SFVREoJphyFHcA04iDc7c++bZt22Hn4JKQYbAviG9eNqgN?=
 =?us-ascii?Q?95m1T7EtVlXjXkIt+Aozbxe4EOXj1xWXzPCoNvqKAysG+Dp+Ors+IP8AE/U5?=
 =?us-ascii?Q?f9OPZ9PzUUkDubEgHU1Mxk6secLJZw+YZZxdJZWKNU5/5rf7LiN/gkVJtTdJ?=
 =?us-ascii?Q?Uq7ixCtMFtPhb3Z9PZ8HET27mXelV4xbmVZntwMQLGXO1SS7ojRGPGBbp58q?=
 =?us-ascii?Q?700uYUGVWJs2F2qAwFL3+XGfKKx+0izKydHAId3gnZbSjkYlCer8rR7XTlU7?=
 =?us-ascii?Q?Cu5AkEdO2jimwiQfFcMIUqJYvim1z7i5AO6AG4iVsTeXyNsKixo9bIqT5JuZ?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f1b6b-eb8e-413a-21ea-08dd19be9739
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 08:34:12.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIGZKcJTNeG6DjgsO/9H90qJEgTPXsCOENnXHrSFCeuZ/GwTL1mbmUbz0Kd66ZomHVQ8VJWur7sU0CqfQnze88+QZd18yWWv/cBG0bpXWmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7179
X-Proofpoint-GUID: fiSBY1Hxjap6xjleudHXUQGlOBfVoANV
X-Proofpoint-ORIG-GUID: fiSBY1Hxjap6xjleudHXUQGlOBfVoANV
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=67594e88 cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=FBNtR9VHoQ_K8lOUHnoA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=972 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412110064

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]

Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
not known or does not have a GRO handler.

Such a packet is easily constructed. Syzbot generates them and sets
off this warning.

Remove the warning as it is expected and not actionable.

The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
proto callbacks").

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 net/ipv4/fou.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 1d67df4d8ed6..b1a8e4eec3f6 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -453,7 +453,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.25.1



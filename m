Return-Path: <stable+bounces-132680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE06A891AE
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 03:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60D43A3535
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 01:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D01F4CA8;
	Tue, 15 Apr 2025 01:57:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C61EE03B
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682262; cv=fail; b=A0GE3Nb2RQacRhquGb+MgwOBQ4dRZQytXgR1eBL7xLk7ma02AscZK4T7sPn6XDXCP0hnrGkBl7jwhdGV2xEh5i8fuQdQOCKCfJoOUsYlsObY711s4MM98tACUBeycjCTXMbr2iUgLimQk0qMpguYT6j9OWtl55p/ppkiD8gMmMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682262; c=relaxed/simple;
	bh=CDDEoeTcrmsCg7BnxFomNnpbwnNldJ6m3T5W0Udy8bM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s0zT/wz+ePpHaeH8T78MskVJ9PsW/8YBdI06+a6Za2RNHuNH+V9sQuHyHewTWBUbpFUjRZ577qMfzYlRdCW6o1iJJI+76VI9AyxylX/NFayKqJpFR2QdcWvZzCi79IRdhhSYqVFrxTrDIYFhkyXfFhgXd+X7OfWEb2hqB/LwsFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F1TB3u032176;
	Tue, 15 Apr 2025 01:57:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1jtae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 01:57:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEb53yM+/dDjdW/F6LZmYiUhQDLBMGbDrtp8uHPmPjygHkkWeSJvsThpyWPXRhVEX+2EyXGb60vgCvPgF2tihPlpwjFXKaC95TyyO18PLnA7GdcWNrpFHiWoiN3H2ofKltFO2dZDPsezANogG4IdIJpBGA2ywdDsyDS0Qo8UmaumDblml2RxoWPf3FsadsdTed7nQ+viowhAKmoki4UCENVKv4y/f10s2XlMOVyxod/56hhEWo1mSySv6SS2S/67Q5dqHk/Y3Qslx+9FEmYLBwFnyVidtIXuIP1EKw5HTMytyHAnah1T2/xwPLtwARP+chSvAeJJBkv/pVgJHqFfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UFdheROo5BXRRS4v+fu91AeBT2cdY4sW8oqCu4wITs=;
 b=Sgk9A1iuAEEhk25VV70GsFWl59L4ArJg4DhDmhX0MQXjVZ8xzrGtzaxQ+U03HvVLS5jt0HuMntAX66ZkU16zicxdgUceRiP6sY8+0UDp0mDo6ar2qowdKfi+PQZqQ05YLYGo2jiL2PoTwkyKXZmAF/5Ho2Jy+4dztjpwwEDJerteFudU0/dUgjiS8hO1NGAbZQU7RwhRwqsTzB0T304CpCW1K/K6E1A34lN4P97aAXZvHelTRc5qMdvTx3Kxk+UHkpBzXJXU4rOlB5Ga6HboTj5Y5HVSWwIuN3LFR7gEhQ0WnqcvjynokzFqg8+l5XfTK692+dKRfI2lHRlaJ1TPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 01:57:19 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 01:57:19 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: dan.carpenter@linaro.org, stable@kernel.org,
        heikki.krogerus@linux.intel.com, bin.lan.cn@windriver.com,
        gongruiqi1@huawei.com
Subject: [PATCH 6.6.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Tue, 15 Apr 2025 09:56:58 +0800
Message-Id: <20250415015659.312040-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: c95f7fd3-d5f0-448d-7b57-08dd7bc0dab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eQD0A8fb6ik0Y7iIzpyXcv0g5my3PmLf9nFHLNMG/YHQxq7oDX92ZHmpOkfj?=
 =?us-ascii?Q?TbM5uiHEdcMBXDc1JGQ0wxda0Ni01MkcwsxLmOWfWIIoDVPVpK0lARlMgAgI?=
 =?us-ascii?Q?B3fo+0+AToWVg3X0Tw90LEaNehvSS/zw2BbbjneLhYfltMREU0df01rQu7K7?=
 =?us-ascii?Q?7tBNsmuNsrQBIgwA3Flnv97ll2v7zDPPvjTqqVUVep+eGVU+XSj/GSC9RfkQ?=
 =?us-ascii?Q?EvTmfUQiR+VWDkjMtuBBBvgZsdlNfo/qD8itiengIg/I/MKpFESIISeovkxS?=
 =?us-ascii?Q?LUW44YLDk3bQcd6gNgaqni2t+zd7edtJme5krApQRtACM2Fcj6Nod+oiugFN?=
 =?us-ascii?Q?GDfl/ThqSspQbfi5WgvVMqq/b3wVkiVE00tTPZtzjGcKpBA5X7MxLJokyP59?=
 =?us-ascii?Q?eSAyunAkLXuuyfeOZ6oZ9Jb0htWR0FwA+lqs0hQKvEFIlXVNslmQdeu24oaE?=
 =?us-ascii?Q?nsUc7dktYIimaZEoJOCml8Y6OYyZOX/7P9L3lOtjZhQc2COukB1B4kX/ZNpa?=
 =?us-ascii?Q?Vg4eMOr2rQcVwFACxkb0kZw5ZjsGJoIE3rh4L4cwFGmCzaA0zQPnmJi3VgWf?=
 =?us-ascii?Q?p5CPSWkIR+s/PgdqEiEemqPmthUeimB6f6hM2e0iD8PJHAV3ezMYXVcKz0uy?=
 =?us-ascii?Q?9+jFRa2MA6yyG3VSvAd+zZeItC6KXpHUJChVcUmdHos3yaf6SqJ0Jfpsrmly?=
 =?us-ascii?Q?jBs0pXQLJdd28Ca1D7jHFMt3TQ/Ex9ZTkkt7dFkm0qtrtd6DT620hvpQ6WGM?=
 =?us-ascii?Q?ok/s9Y9ekFNlImFRJor9Hpif47oL9CymwdujLxIm3ltlLevteoFH8WyCHkZl?=
 =?us-ascii?Q?8Ri/KRN8ZEmd0cyYjPj+KiH/Uy/lPI/jr2BXHmg1rAAk/oYK7lZ0Y/A30+Hi?=
 =?us-ascii?Q?sdkQE2bSfsmZu1OCc+Ghg0mO0bFbppKUF6qZ+eI2pdYtiGL8KiWelpT21Fi1?=
 =?us-ascii?Q?fM5S8L7yZM5N3FvZrmwtfAkM3QW50zKJykh30UJKuzesiyuL7R7eFp7Tlnxg?=
 =?us-ascii?Q?Eu7c9o7T3c31H0uAtBMWddaHGdItYwFYPynCrOb8NwqMcF/p+olEvyNSvFAf?=
 =?us-ascii?Q?Qo25jHI6Gsz0Cv5YpetbHtXZ3FziWE2yzEpx6dNj5MPa5GtfxybJ4ncPNdtq?=
 =?us-ascii?Q?1Gw9zZVN/Q1KF/NgkNiA08aPmJOEbaL3WwXXUZZJ5x/fVy4Oa7Zdl6rP08uE?=
 =?us-ascii?Q?i0zn8cdgOLVH56ia6GjnTr/EtP9PqmFDLEKkgkc4LIA3B15DZtWGtr+bHYNq?=
 =?us-ascii?Q?HQeqI1qQ1KOFU7pd3aeG9Yg3xaByYV9HW0N+EmKl4m7jmaETv4qR1KxzSsZx?=
 =?us-ascii?Q?8bo3WaJh1fnNNkGd3tm/PpM7KzYXvok56hrdwIZKsXE39Gf7p7pI7rSkuJQO?=
 =?us-ascii?Q?h3wTZ4+/hVpvdNZ7WDdsBRVBrsTeDTM6ys1S334Tb3qvsr6/QUzgePgjvGGG?=
 =?us-ascii?Q?aPISN+KxTxTqtEE6794rkaxn2jh4MvnqyZ7W38p7Q847gBzpn0xbLCiIq7oJ?=
 =?us-ascii?Q?VEAeDo3z13a3mFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqH/YA6byg/K5tFZO6tcf4tsic+OZtD2Ja3kWx5SQg74QSroXXSIZJJHFgPu?=
 =?us-ascii?Q?0B9L7myf1RXWikqztjyT9N+OeRxA7MBaY59r9a64LIroWpmmRSfPxKrxOAPl?=
 =?us-ascii?Q?m+kPOXkBig683MW0zKWUpMWNMfk401m4SVKnZVjRFslC+1bJ/adWTvFv8E+k?=
 =?us-ascii?Q?KwvmOv3b5FRc6d/ZiFqxjegX5qiOwgyVrt8j1Is6IRbNbEYzNI6GTRbF1EzZ?=
 =?us-ascii?Q?WJjF5R3mYD3ePEW10tZOrBlS7Vbun2ThKd2nsXo6Y/lu1TDU0J0HXkQpxc90?=
 =?us-ascii?Q?XQCTDVFTf3SMLHbYy7VPrhSe6DAROJKbyzdhcfNFs8B9pIvAOGJ39SK/D22V?=
 =?us-ascii?Q?rskGW1BkB+H4y1udZaTwejPBgUZVZ390jComyyK9KOCcDXLeS+bVRUGKd9F+?=
 =?us-ascii?Q?+8UPfNCd5kkeIXe3cQlDPiieIcgcFQVIETuL9y8/Ww2QupjJscPlEjEqFhte?=
 =?us-ascii?Q?X/q15LfKlJcrQKWTrETvzP2yaWiv1JrZXhi8ZlwfuPaO7zs/u5aEeuyAyeuG?=
 =?us-ascii?Q?/d5CI7sjQL/V2OMZlc1Bf23cTEaD1eNWsa7vrtfaIlowTg3zSD6/j/Qw8tx5?=
 =?us-ascii?Q?1nqe20v5gYBfRqBsFoEqhF8NnGgetlAmRy6sHf33nsqXJg7iQvSh7wKANC9s?=
 =?us-ascii?Q?KkX/LVccgxe0UsIyxlUi4kcyoBArokkVdRCgrDgbMFo2q997KrnNTEJH+9Jn?=
 =?us-ascii?Q?GpXXRnqpXU10V4hu0wNN/iLBrT2h4U+H7bgcfHLkXDAKG8s5/taNXqD3WCGt?=
 =?us-ascii?Q?+eybE12QCjwoyPB5nYJLM1B9lN5PBCEdAyU35F7mu/vfBqCoBiU6uOhet45j?=
 =?us-ascii?Q?xkKrWla9iVu1jZ4+9ukIxqVdKM+v49NuKB2nzJXzlIguUEtrI2BLeOPhLXiF?=
 =?us-ascii?Q?xQma5y11CU7uNxnZsCaB2QgiY0pUbR6TKXrFjK7u49rLIOeU/fS7iiiOPtFl?=
 =?us-ascii?Q?IottrpJkFJR3DLPTPuCkzw+ofBhqfXErhFXcb10zw8I5qf7oFWv0vwvdEvrJ?=
 =?us-ascii?Q?2HF7OGUtPLHfHci6vteBKH3ioI5M7L+0pEsS1zGEiJVMg7FIfIArRYq4rQh3?=
 =?us-ascii?Q?Zz0zvZHj5Qig10wJQ8x/70GvZVig/nZqOJYlg4zqtbDjGDELJCvx3iNXyFy4?=
 =?us-ascii?Q?jLxpqzh7HMpJJbYpO1wbor+ic8twE1XBrMKR/Fs5rMivwn5at9RsNaRUb+5b?=
 =?us-ascii?Q?0jZljTYQDn0yEMESwk9wow5R2w5F+ILUARe32Toj0jIvVOAnUnRevfWUd/Kx?=
 =?us-ascii?Q?IjUDS+BoGvBwPkZFq1sTUJYnExjLJq1E84ThJj8JUGhBNmVoxb7GTx9dR+cu?=
 =?us-ascii?Q?jhpTwokl/ORagowNXvMQhmOgeMEeo/f0pMEdMADUVmCYz4qvw+2dsp8neg5j?=
 =?us-ascii?Q?Ajsgu0sezbswY1E7CJWpvx104K3NxRerGX0kF5g9t74hQ1dhRUz4TWS0ppl+?=
 =?us-ascii?Q?yukfDetPoYD5bWEEAJ3TOk+CodMlo5XytzSkh8tO/7BM/7nhXNq5Gr/D3yIj?=
 =?us-ascii?Q?ctEXy847VCQcncBwg9GsbFZLeJC4vLNa1Bs9WVmhmISWk/hSMudDwHPmw6Ae?=
 =?us-ascii?Q?0bzwHw1rNndlgNtdkes7qQZTZkeR9duRRtCjvNE11YnMusLt3AltH5CONhmC?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95f7fd3-d5f0-448d-7b57-08dd7bc0dab4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:57:19.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmUMcWxjDeFzGwa0Ax0cXGv/qTlDewZzwTXps0KXjNjwvgmZ3FdOGQVwGRnRlSm+q+JNBQwSOwA8iCWYMNC+gSpFxML5A/UlBVQiKk7G/7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-Proofpoint-ORIG-GUID: FNVw5wCvk61W-b2aWqRJJBYIf67ud3b2
X-Proofpoint-GUID: FNVw5wCvk61W-b2aWqRJJBYIf67ud3b2
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=67fdbd03 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=uc3al3VmiIQHG6Bas5kA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150010

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e56aac6e5a25630645607b6856d4b2a17b2311a5 ]

The "command" variable can be controlled by the user via debugfs.  The
worry is that if con_index is zero then "&uc->ucsi->connector[con_index
- 1]" would be an array underflow.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed.
 13f2ec3115c8 ("usb: typec: ucsi: simplify command sending API") rename
 ucsi_ccg_sync_write to ucsi_ccg_sync_control in v6.11, so this patch is
 applied in ucsi_ccg_sync_write in v6.6.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 7c7f388aac96..3ef02d35bfbe 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -585,6 +585,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -600,6 +604,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
 	pm_runtime_put_sync(uc->dev);
+unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1



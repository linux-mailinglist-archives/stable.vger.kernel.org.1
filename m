Return-Path: <stable+bounces-144138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2AFAB4E7B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BF91B40FBF
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B8A20E01A;
	Tue, 13 May 2025 08:48:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB41E0DFE
	for <stable@vger.kernel.org>; Tue, 13 May 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126111; cv=fail; b=XHRP4TSFIVKUojvy1L9y7nbHsk5xaS6/wTKr6JevD3HROHpOpO6xM6ABtfWBoIyZGVL438S7ddWhFK2xuPyE/kpN/KebbguBGq3FGVNn0c0Id16n9Pl415ceVxvjX4PYbNOSagQVGc15vxe6jMgV6GaRurj5F0ewRieM1x8VBa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126111; c=relaxed/simple;
	bh=vkG5MItUF1mYYRsi7fxClhTNIBePW73+NS5ezng1f9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBpAsIcquEct1zcR/IRtD+lUQ74YgJASSCjPpoTseIDU82G0AIfkbaXjQtJuuXiELi2/8b6I0cUR8U8A9r9d35ULRXSEPEUKj8pdqavvZPpT/V5PMCJ4c4KmtOoLL/2bGLjFQZJ6ECxc9m+4MtgqMYfEsbmUQy801fx17gal0Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4fq7R020492;
	Tue, 13 May 2025 01:48:18 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j233jn0h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 01:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv2cPXJQc3h96eG9+N9JKHmLxwNVaqAMyT2jIei4vqzKUiFLTR7qkaz75bHmAxhbpbhmPdxDsouA4tcuT0T/Mh8hshrsjyhNFrG18OGB9I2UDHM93cvnzRVGbDzDkSWHY1om2ySZ2Ln4peM16maHw1ha13EKXQ7gYzxBHbB+qbnJi4cErD0RREVhPYNixTnEARNrdzm580W1ApHRNwdzN6CDtDdFNkNONcaMQMtuDEW3o4+R2fjzDDmdtJZn6unNVYoS9ZFK6iSZJ7TA42nJNGZC7o5CGCQmJ/LUvgXeklORLHlC9AAlSau9234e4HfVkB2vahvwuzLKlcoS5tp9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUWxCDZCKigXNSWogKdM67nIj+MmJQwVazBwXiu0ylM=;
 b=PurAN0wtltT2g6Znp11J94hQIaHj3D5MxvOJTjkKKiiafA0O6loi3+p6m++GFNt9rbXSTSQeu90yDwAGcb1pDTfj20m3Mu1t+fFysypyfKtw7UOtw9Az+im5+eP4WEZipgFBlU4LgXudTBDv9F4YHKTMMbvrVkwBywUEw7VEgRvkaJDs8LDdQjVreZBT3bHO8tCd5jgFWHP+X4ScEGuQpvnl5VsCsK6R7bzwtdUmoUl3g/AWoTGpiAQoDbTX0+XrhQ+HegYCNnfox+oolVYklcuOnRWRSuXVjttTJNcAKuTVDbFozCE4myLGMscuoMiIG59o8ZUB4Bx+gwzoBF0MGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by CH3PR11MB8209.namprd11.prod.outlook.com (2603:10b6:610:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 08:48:16 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:48:15 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: wei.fang@nxp.com, kuba@kernel.org, Feng.Liu3@windriver.com,
        Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Tue, 13 May 2025 16:48:02 +0800
Message-Id: <20250513084802.1705121-2-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513084802.1705121-1-Feng.Liu3@windriver.com>
References: <20250513084802.1705121-1-Feng.Liu3@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:404:29::34) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|CH3PR11MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: db15e195-aaa2-4a26-6d2b-08dd91fae6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFEK3AACXu8xK7LtWPDIIkRxrZFfN0xwc6pJahdMc/cN/PZcU8H9aAAQ6Gzt?=
 =?us-ascii?Q?52bQlniHHCwzry4PIA8Jvjn78CF3MgxcO7J1Jgne9JjaK5e6JAXEKl78sNts?=
 =?us-ascii?Q?zxTQZRviqiKkt/0GaPcenHCileiCilTTVlM9MiQEM5ydAJmRirEyPPcwEoNL?=
 =?us-ascii?Q?SjgZll9gTER8uMuO8yurQ9/zhxCFxE6ai52DSn3K8Vw0YTxpbNw9l4y940ko?=
 =?us-ascii?Q?bdkRPJH0FFo/yX6RQNAtLLWc69K2JyU/XMkLSThkGqbGYr4iMU4ZCeJ07/0r?=
 =?us-ascii?Q?tnFp2XeDgkjNiAAKD9am9xCe5HqhsLrfyI6Sg3/StL039R0eCX5PE0LBrnb0?=
 =?us-ascii?Q?4XTEjz81Mxb7XjGi6pWojh20Pq+Ykiba1jFS7Q+ecrosqMFyZ5nWVi23WMeq?=
 =?us-ascii?Q?m0GLmXLHSSyBCKemmaFe5nnMoni4/+Vu/uqvP1ER+rWxCBpMx2krN28axqVq?=
 =?us-ascii?Q?NVaVGZr8lzbikUTKJanltfPP85izoHz+IQcFVBO+9aGiozQIZZieKeZQGq6m?=
 =?us-ascii?Q?TBiYcnZ7Cn4jmegdT7zOGAtAqTu1vGgvWrf/G1F74zG8AGhsm2W/q175gENv?=
 =?us-ascii?Q?RkRIACv+th8JzE4u/RBgTd2MxegvIYo5K0H+Zr8y/4UreF6y2USKhJsHbX1k?=
 =?us-ascii?Q?1jvK2qKnuZr32crcCOGWb/t+BgbP8gYcWsof93s0UDjK6MPMvFZ4np96VlVp?=
 =?us-ascii?Q?UpXbXlXLMoQrevccQLIccwZXsV5G+LQD6jSksCvb5h7L21a5B39AQHNou/iv?=
 =?us-ascii?Q?iAMvNOxduLw3+FlLrQC+y9ev3gZm9yxDqnfHHfoPmQmTxvWskiQ6/fs00g3A?=
 =?us-ascii?Q?2Z5HJPPatAmtiqGG6NkcOxL4kP9rtJxXsI/7bFiV/Ob+DMKz4taqvvuM9g1L?=
 =?us-ascii?Q?ng2nPk3mqYUm+SGHSf2ST+NGdJmD0DbkjTkxij7sQTWHBpUT01MW9h74Nxhh?=
 =?us-ascii?Q?YUmw+fzOtg6l8oRvWJk6w2DtidVJ1T0KbBQQyS4LpDYIZN7XPEsC6oGG2yQJ?=
 =?us-ascii?Q?LNVxEkTaZ5WCLCB7o8CfpmHsgKkav+bJtwIWN0nF3P8RGaxd430qKpRukCPO?=
 =?us-ascii?Q?VJv+pV1Igh0AECs8HfhSMIVPiPV/nLlD3tcDgJoM3lBup2PCiD0bXp6og9P8?=
 =?us-ascii?Q?gFQGKuT6tr3ComTZudbu8MfCln9EgqHcAgqCS/DOFMDM878+osJV2X47M8Cy?=
 =?us-ascii?Q?qPVQbzcLZ2tgC8EItpcNQpQdKnPjsjIeyCklHsT98Kq2tynCOZxUAkyA+EaD?=
 =?us-ascii?Q?VUs0/tlGTcsKyffNcQfqJKFOnY0KqNJViAENO3rNvnYCVro5ahska7SQN9yv?=
 =?us-ascii?Q?O9JIIUriFUXTb1n1+6sBUHE8irwOHlTwDrmvcYRxhOG1XOyG1oELW1aSIBk8?=
 =?us-ascii?Q?2hsBy3TYBqmcI3fDGiGWzrw9o59ubMsJNy847I1Ajg8/QONTwBUJPTY94Hqg?=
 =?us-ascii?Q?72z+KpQi9p+rq9zt5e96ViB6+buQnqxq+NsktDZJg0Rljz8YWXr9dEg/B8Zj?=
 =?us-ascii?Q?aC0QG9a/85x81v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SIDeiMfmQmuGYr9+UuGVfWhaAGS7VB3kxbwy5jKZhSxdKBqZ9iy30bRR8VQ8?=
 =?us-ascii?Q?okz00uBPXBgh+44Rqf17Gw8tv6MsHIpQuPqiFCiTQcyNeMIoRm5uF+OuXlCv?=
 =?us-ascii?Q?UL3bIId3kfyoAewEGK9inbmQI5u2oD6GqRxHLs2je4W/yvvkcOgNrR8DHQqt?=
 =?us-ascii?Q?RhIDQF08iJuGC5NFyL6InX6YCETX89t/z0c5BExkZKnM99nXGw91i/Pptyii?=
 =?us-ascii?Q?HqUPW3GIqzorvE1zwltObu3TqcBg7gcDwzIyP10QUabHmEA6XXowGb7kKWeH?=
 =?us-ascii?Q?7RUTgxUKU5rSaK6TD9pVxPvhHAHgInM/QgeneRJjFAYlmAm/KuqFE19cgQzP?=
 =?us-ascii?Q?tQw4gLnihleEvxz/eqdhi+yGXJUmwvOalD7x0I6BgYdmJw5/khYlHu/75Nq8?=
 =?us-ascii?Q?avUCvnwRpEIYR1pE6o3nPXAPZvP8hEZS8IxdyjGNUC+YB56DqkEJ2sF6jPGU?=
 =?us-ascii?Q?67Oy5cAt9v/HaD27tlAyxtYAj484Cz5JGR/so6vnki7uIODUC8jZ+krSGNTt?=
 =?us-ascii?Q?HIOKkdSWlIVKOiUplHLKDeaiwm0A76loQiduo9hGhn0mm6CkTUGuNX90Zvja?=
 =?us-ascii?Q?1PFGk4ufpKaBcCpLZgLjE165akvBb3NfHP5DLlKfEsktRqsGY8wOGbnBh3Fy?=
 =?us-ascii?Q?sN482cFt8nzPnm8UmC74i4ELIOmouREuUJzKu2cijRYhAw9Mg1YKZzIZcUpY?=
 =?us-ascii?Q?wjrthLSJA9X+g+tBgWj28gDn5S+3N9vx68HElXHe67tWS4Ia3KmBJWq2fdqS?=
 =?us-ascii?Q?H3h0k5gtsnGYyl+zkiCx88Ry3Rq3WRZHWTk/LbCUnp34uT1HOvF8eg92M1D3?=
 =?us-ascii?Q?rpJjG2b4hs+59Z4/JtzrHeuMA5WajYZEXHMhvbEZ/BtofT8rMaFHcBqJTGoz?=
 =?us-ascii?Q?pBrSb/qYdx6f+RFS9uEzF3sqJZGPQPne8uw1eJw/gP7nuLklQ43F5P3nemAP?=
 =?us-ascii?Q?vP/Xt8cVSFsC8da85DeCHkHYzM0wxqAV8YKZ4ycDRL39/vKmrLJLWsDgT5wY?=
 =?us-ascii?Q?l/ndaUgCaMXAFabnvEoIRf+Zumj3k0IFh6wXXKzORA1FL8caFNQe0jp3Qx9s?=
 =?us-ascii?Q?9Mh3sH0qu/tLOrI3br2DU+R+p1SatuaQ1EngkMWoZkCFVQGID5EocdkHwjej?=
 =?us-ascii?Q?+hSpsGTeS+b6xZwsp7RqNxksEk6GboBUpg2Z6c6GVeVSznLV5k4ecJ0UZOrI?=
 =?us-ascii?Q?C0mptND7TgFUwuwAmidLFckJoh0Y3zpxW9Z4wuA0/bl7OazG8yUcknGUinmh?=
 =?us-ascii?Q?vZBfrOKZb8zTX8Ovo84T+WxkDVTczHQp2WRF8foYcCN5hyhQZszX+tmP6mTc?=
 =?us-ascii?Q?2zic24eKsKFpNnWtVYYa8p4wZWw3hJPRAw+GaLQRWB16xdmxxCVMMpR/BEDx?=
 =?us-ascii?Q?MW+jmdrnoHSfIXEHrO3haYgIBumx5mZTsGi7tJ3+Wh380TJDcQcB5eCPtlRU?=
 =?us-ascii?Q?gzeuMDDHAFYcRwpIt7sL9M3Z/dijd37EkYHgRzApWbc8BC8Q9CB9RWx+54Vx?=
 =?us-ascii?Q?Ldj46pfKKTsIbvQYf/q/LQAEH+pERlHr2N7UD9L7qyvL7AwHZkh/rI3zh6Xs?=
 =?us-ascii?Q?t1vs9yBCi9pdmRVvujTLoFAYvRVyNkgpU6vgowzmF8nTyOs2hweoDxJbRitI?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db15e195-aaa2-4a26-6d2b-08dd91fae6d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:48:15.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qw6cYEZby50MBRf6f3009eMU3Opr9wVqe3g0UNWzeJuurzbJjTVFbxDSdoUeMt1JPh/PyHU/w9OKJHFUVRQesA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8209
X-Authority-Analysis: v=2.4 cv=EojSrTcA c=1 sm=1 tr=0 ts=68230752 cx=c_pps a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=t7CeM3EgAAAA:8 a=IFCpX8b_31d8Zp-CglUA:9 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4MiBTYWx0ZWRfX9BubEgX+EFwN qbyePPk8AgWXl2bf+tz6SS0Ehq9ZV/FFjNx7zyYAIlnROctBnpJFHwx0sD1wzv6XhcNRp9qrHcn N9H2z8yaepIHcFKj7Azl79Wj3YZkDCDlieOQZ199kKtBdjIlcWEBPI3QjPgHNAGd+O0f29f9tdr
 2DrUJvliaxpKSSUFYofOM7pkHBCijE0RWdJ2hbfUUmwNrG3esPX7H8liNBRRoLF2IzzMFwVNVg6 FsKIHbhGspGykWRWsat4sXh+GlSMkfXUwE7D5KtEh1N6Qp7vWMZUkKwAelyQnq9qNA45s9R++Hg 1OOsMgJMdT+xh2LplfFmDqCaUPj4XjqqwztI40p8rH1txN+AAeRdaf2v+tWxy5asVjMhxst4ag7
 FA703oK+KwcftFx03OUWUJsVw1e7yWzgw7H7niQa812aytd8+ikrzC9yzjLe9dFvAZ9ce44n
X-Proofpoint-GUID: 4pINE5bdIUe7ZMhwnYE33cZT7HIN09SQ
X-Proofpoint-ORIG-GUID: 4pINE5bdIUe7ZMhwnYE33cZT7HIN09SQ
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130082

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit c2e0c58b25a0a0c37ec643255558c5af4450c9f5 ]

There is a deadlock issue found in sungem driver, please refer to the
commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
deadlocks"). The root cause of the issue is that netpoll is in atomic
context and disable_irq() is called by .ndo_poll_controller interface
of sungem driver, however, disable_irq() might sleep. After analyzing
the implementation of fec_poll_controller(), the fec driver should have
the same issue. Due to the fec driver uses NAPI for TX completions, the
.ndo_poll_controller is unnecessary to be implemented in the fec driver,
so fec_poll_controller() can be safely removed.

Fixes: 7f5c6addcdc0 ("net/fec: add poll controller function for fec nic")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Link: https://lore.kernel.org/r/20240511062009.652918-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7b5585bc21d8..7a74a765784a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3432,29 +3432,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -3528,9 +3505,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_eth_ioctl		= fec_enet_ioctl,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 };
 
-- 
2.34.1



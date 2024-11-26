Return-Path: <stable+bounces-95491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD69D91B5
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D1285F71
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12871149C64;
	Tue, 26 Nov 2024 06:25:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EE4C8E
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602338; cv=fail; b=MepynvsXE64LQE/8z0E7KtlXDH65td1fCxCD2dwrCaDbWI7no6dTuJGdqxhgOtPy25SsADgaIT847e4oSo7pNJLvaSQZw+rwVvMtQIJrNrvXu7DyVPYLnggah3Yx2Uo6+6QHzS0SbLdQgZmMTc/V0K0b0xcpWF1y6p6eqgC7h6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602338; c=relaxed/simple;
	bh=TtS/G52t50n21SFusI/ZbMxvb+ovp44McNCgp/jLW0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6qLo4ndaIzIdb0GfXs9aarFUAwWf9vWSmCmB0Fk8xB/rm8PQGPfEFvAJcjFKcs39+6U8qsd5jfdtuZ20MkwTXTtmS76pU3f3FDFgbDGZfKleVbSiD4ROtFQ2pOSG6sL6HiEZlePhW8YSQ7L8tqk4VB3lX8R6hlyQsgEo358aMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ5BGXX022318;
	Tue, 26 Nov 2024 06:25:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433491axpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 06:25:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5E3WvymVVM85rsD62bees1/pcMOc1qpcF3eQmNpBMD91Lzcu3ckBnxVpKTYSGxrhY4HqMs1B4dJOynKyiTls9PBXAh+NQih6tYHMQW+JD+R2MGZ0PywkczaO4ToEyAiA3lMwz5H584+WJxX+i1Y55Vlat0CkaJdiod0dbc1BPYoKSfI3cYTlTeF+hQfTXfSH7Hr1w/aUaBJT7aCb2H+UoS0w8GQoU3kVl8fONj+bq+2RNwbL3GfuKc7YwPA0sZHvHWWu+OioZebWFZ7H8YRkGGW3Uvj1MKPzi2yXjUSGgyRmDNPGoZ75YhQUefs4hVs9iUdPfQM2+/xMMNVzBdcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgwTgDrnwYMv7yMAKc8yA7TEd2rNNBNZjqaEVbTfKIQ=;
 b=PHfgu4bmmvZNfbfi4LynvGGkfuKZbS0L13jinJVsdUc1OcWET8jpL1qEm5206E/GZZy7XYuhNkGYdxExkjfM6nlYgm+zbN2zsYeJuZSDFp5W5hGl0VGl0RwJSkiFTzfpxGrDlPUUprnGU5pWBqDpM+Ojvg0J53RRPddOfiTp3dknTTRp+LDmCKz8q/nY4ND6CiLSAGKm8GF0CaI4Mxl8PlRhWOVLqGqFemJFqWBwMaTn5Bo/QMgA5RG5cNQ3uw/r9ZXiKw/LbRVdoA7d3AwX3LaTk2ECvDIcdei4qGVlpIkQeiQYA+n+aw+xsBWe48Nnq/fb5QiB4r4uOIqVVC1sqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB7171.namprd11.prod.outlook.com (2603:10b6:930:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 06:25:29 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:25:29 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1.y 2/2] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
Date: Tue, 26 Nov 2024 14:25:37 +0800
Message-ID: <20241126062537.310401-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126062537.310401-1-xiangyu.chen@eng.windriver.com>
References: <20241126062537.310401-1-xiangyu.chen@eng.windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 178fee18-5199-464a-665f-08dd0de31fa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YnD/zklXR/30bfrVP3lWiTzs+GyTkq0T/KH3hrKaU6ujae7j4tr/YQgkvV35?=
 =?us-ascii?Q?BbbKKd/WTil0neb5jz2dfnO9Vmw5vrQRye9AvRDBcwgEsYtnVeY0x86mrrb7?=
 =?us-ascii?Q?YilHLLhxayJrqNnI1W+n3znpNUQL3suHhV/NggLWfbrJYoXSe6aBFAgd+I5g?=
 =?us-ascii?Q?LXYNAdPWADW0mtD8PmeYByHBKGBJoIfzxK8QUwNNVKcd5OV4LmwBdB6w5kNa?=
 =?us-ascii?Q?igJFQx7DO6NBpc1IT7CpyWxq/mwnVmf8iNWlIUO1xmDTs176JLQsp4AgljGi?=
 =?us-ascii?Q?lJacYEKcuhYkck/xtX/dmtJPS0eyhTI4InHbN6/S1+VtDixOHaySuWKSDkqF?=
 =?us-ascii?Q?bvMyWQHE4UsrWLyG2ze/dcOqHnQor0gLEpsOihIzEMdnHXtD2GhQ5mlO0DZ3?=
 =?us-ascii?Q?iEW588tCd4ijDaioIpJIvM/nEK8pKy8QbyF4KhbHuDxTnLzP3mU/oJOYgkN7?=
 =?us-ascii?Q?vYoCOmt3UM9IG3fcoG4V1+KAbs/8P1dm3cgj+I6SYGGDIfl3OsNZA2AZDo2q?=
 =?us-ascii?Q?OksbUw402Ovc7BhGZS3umQeKZ7lsI26TVGra646bBxJXEVlgHvYKpoe/9xSr?=
 =?us-ascii?Q?dN5MHZJGKcYqkKB18WkZUcqWTGVzyfx7qlyWF1A58K8u64AM4nU/ABgJplVe?=
 =?us-ascii?Q?sNh9EGvgiwr5gtvp1x4ObQt+oHmU8kYOcr73GYLyJrxr/Kz60q2cJgRyYhjH?=
 =?us-ascii?Q?+xVILM/ke2bEoiLJJCn6mn/uK+WqikIHecR2O+P2MsLiahZcuVHThXxLpkyb?=
 =?us-ascii?Q?D6poruBbZ4kIz94tlDpCFaoL7hjhnRPhwpHSc4IqV8DvSnMNk389KIAy6ZQv?=
 =?us-ascii?Q?hhrTW5uDBPhqDHYAqbQZurGFRPgESOeCc2APOuVPp7AIFv2qFw3PTaoYUj8N?=
 =?us-ascii?Q?788KmsK6xEXI3B8Oy4nA1gLjaToyuVVtzK9A96QrWeH0F6MJM4hZlOh7k/Kj?=
 =?us-ascii?Q?fWB3LMs6r4tlcBjhXUw9/eULvFcRShUo+S8/0Ac/M3IPfiYNOmed8ysYhqFo?=
 =?us-ascii?Q?PWeacTTgEsLRMScBxrVLNSrkLt3GMBR3RwUCWHC4akvaX+FJKO6/N3DGKlDG?=
 =?us-ascii?Q?p4d2gr7zZDYafQqFcylTH2lKI3Ahs3klMwYiuzoUvQ6hWpsP/DV25wUr8tnW?=
 =?us-ascii?Q?83Gn6VyotiWr3GgSNwBaVShgJVubFBOxu98MB6bN/lvqA+nRfRnhSyLuYS2V?=
 =?us-ascii?Q?KX2W0rsSTorNfT4bgrYlRH9ojLWC3rjS/rtij1uQWMsl0QU8p0ibqiBssI5a?=
 =?us-ascii?Q?PN3B5/EXH3EWNnFX1BCfzSoEG6FCh+XoUQIcKoCgMryrbKsufq9A4z6Rfk1N?=
 =?us-ascii?Q?rDIy4ej8J3p/31f7IVCmDyAEGIwXt8q3FFX0Dkzm7Z+LvO2O7JNJgWUlx+4/?=
 =?us-ascii?Q?gobhqDWV20T9/V/CcYgRp20ssK650O4lhyq0PY4BjIXFRi2b9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ao4bv2aFZjPPlPmTDxmdWsNtc3savDknN1/TpnezgaKO+TV/o6/W+Tq1IkAm?=
 =?us-ascii?Q?Azx+6wLnRrBSkw3f+YJ3ogaGOTashZ85zBv6bdm1FhDtJPFvWx5SIe93vrz8?=
 =?us-ascii?Q?mVo4YjytlyGahHtqCFkk3/6IKMoYht+BU1agycD09U+zgad0aIRRQOOMBIn1?=
 =?us-ascii?Q?TDKCt+BnsMXAnL8Q5PX4hcWqCYY28UrAUaXNJsnYlrn2/864MicwZ5hejprD?=
 =?us-ascii?Q?bYrHdceUFNrQvMVvewZ3G4giEBvsez/U3fQD0j4DuoPCkb/hno37aZm1Xsg1?=
 =?us-ascii?Q?yDHsRpCXa/DuXFO+GwvOv7wL+ABXSjJ/ujBosHnDDLT+NxEe4cSZmR9nGxXi?=
 =?us-ascii?Q?30D9IcKBTdOCuC6AO8ZLdafLqrKOQ2JMnYSkdZcIjG9Z02TMNio6rGe9tBQJ?=
 =?us-ascii?Q?teZ7F9ouxwfipa8FGs214LqpjzneTpCBUL1KjgyzChX+xIuG3FpB3qEF7JXd?=
 =?us-ascii?Q?1ppgADA9XZJtsAuzfRC0LcaUxRPHvJmNMt4Kkw7w3ox49CVYPtrBaQztwcR6?=
 =?us-ascii?Q?lI0SWXVlQ7q2pRs26NWurEZj6OyHEJE2FA9AOEP1k1ypBwqU+ec4OcLsblcQ?=
 =?us-ascii?Q?oXdcF1iKWpiOCSpI/r+l/Pkjqtgih8ZpqwTTUIjjN4+9Du4nlLRLnjtFGVFl?=
 =?us-ascii?Q?k9fHPwV1ERP+8eFFd7GnRmDfnDYXeWPuv83pnnLgPbG2+KvHLvVabRk9dooo?=
 =?us-ascii?Q?xbsv17lFSYGTNrfKlL7G7q8FD3SXR3ESC72R1X9ogKwdEmwJTXFPBiQZWczR?=
 =?us-ascii?Q?htXqnjTxB2sfQAP33UNGYNlmQsY5AzPf/JQJlgxEKnUQV5hIA0Ra82MQ4Wkf?=
 =?us-ascii?Q?/RG1ndkdTLny6N9jOjLFP0DUN9LciGYvYcmvuwvwt3gD9rn49TOGml33Twxc?=
 =?us-ascii?Q?5LdnUOANa5vOvc5F0zg5xd5SnfYdhrvHDNwOPxl4dA2eX9N8skGOowRGzGBI?=
 =?us-ascii?Q?5lkRA+7RYHGuVqLgofgnGjU8ZFocH/LCRETu713N6r8I0GtvM8jrsvEi5tuQ?=
 =?us-ascii?Q?XEWuIH0c9nfMNWSqG66cCnCu+TL/fFwhIzuJKrh0Y6hQogRtc6a8NJ8gek0P?=
 =?us-ascii?Q?G9xatGzmou9fGqFfyVtgbpncXDltpyz4BFlftFDiitM3ddHmmlscm1bqZjbs?=
 =?us-ascii?Q?ejvni+F0KPjE4ibEo+RPPRm6Zj1zBE06vWyJA0nx9VWreLAuQ5KYY7uyvC9x?=
 =?us-ascii?Q?QoCgou3vlrD4tlpg8oOzToCL2bvnIpHtCAT7U4YEXxzGPnX0/bEa8aDJKyyM?=
 =?us-ascii?Q?Yya87O8lQX31XAVnsBoZBGUGhoTlsXi4g7uwWTQZDExQsU5IWHQcYDCo7R6U?=
 =?us-ascii?Q?X6S4x2VozdDuH95sBeoE5K+yS/NA/QVwai1sKjFKmynUrNHT1+i8RyFqRsZm?=
 =?us-ascii?Q?uDwZuU6BETQ7Cjb5mnVTGicYF8BWX/H87KQG6cJalCEH+/mA6Q8RojWcgi/6?=
 =?us-ascii?Q?S+k/foGc5ZSisqpxOo8JUxc8rtRcLRh6J2RCDGGpejWn4jNG9rMQX5uYvIuf?=
 =?us-ascii?Q?tVv/uPQa88gNS2IQ+ya7Ad3G2QnSyr8xoi4R5Orsaxb65c7YCaZm7caeKiiz?=
 =?us-ascii?Q?IGGr0caWe8G3+Swd1qv+ukSJkpn/FsQ3pZUY03AdP4/u+MmapLiwUQiJx6fm?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178fee18-5199-464a-665f-08dd0de31fa1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 06:25:29.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl3DLx+i9GhXPI6kXUZgRvODiLrTR+i8xK5hickoxEILtJb81P0QWlHp7sTSAbxFH19UYxyHydWPw/r4TbklTcoWZTj8pqfVUlD6GlxPr30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7171
X-Authority-Analysis: v=2.4 cv=W4ZqVgWk c=1 sm=1 tr=0 ts=674569db cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=QyXUC8HyAAAA:8
 a=COk6AnOGAAAA:8 a=t7CeM3EgAAAA:8 a=Qngnf2NrlJ0sP2dl_mQA:9 a=TjNXssC_j7lpFel5tvFf:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: jH910txCU8JULAy0uOc2t0JV0fJ584wb
X-Proofpoint-ORIG-GUID: jH910txCU8JULAy0uOc2t0JV0fJ584wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_05,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260050

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit f53e1c9c726d83092167f2226f32bd3b73f26c21 ]

If mgmt_index_removed is called while there are commands queued on
cmd_sync it could lead to crashes like the bellow trace:

0x0000053D: __list_del_entry_valid_or_report+0x98/0xdc
0x0000053D: mgmt_pending_remove+0x18/0x58 [bluetooth]
0x0000053E: mgmt_remove_adv_monitor_complete+0x80/0x108 [bluetooth]
0x0000053E: hci_cmd_sync_work+0xbc/0x164 [bluetooth]

So while handling mgmt_index_removed this attempts to dequeue
commands passed as user_data to cmd_sync.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Reported-by: jiaymao <quic_jiaymao@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[Xiangyu: BP to fix CVE: CVE-2024-49951, Minor conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 net/bluetooth/mgmt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5a1015ccc063..82edd9981ab0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1457,10 +1457,15 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
-	if (cmd->cmd_complete) {
-		u8 *status = data;
+	struct cmd_lookup *match = data;
+
+	/* dequeue cmd_sync entries using cmd as data as that is about to be
+	 * removed/freed.
+	 */
+	hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
 
-		cmd->cmd_complete(cmd, *status);
+	if (cmd->cmd_complete) {
+		cmd->cmd_complete(cmd, match->mgmt_status);
 		mgmt_pending_remove(cmd);
 
 		return;
@@ -9424,14 +9429,14 @@ void mgmt_index_added(struct hci_dev *hdev)
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
-	u8 status = MGMT_STATUS_INVALID_INDEX;
+	struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
 	switch (hdev->dev_type) {
 	case HCI_PRIMARY:
-		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+		mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 		if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 			mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev,
@@ -9489,7 +9494,7 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 void __mgmt_power_off(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	u8 status, zero_cod[] = { 0, 0, 0 };
+	u8 zero_cod[] = { 0, 0, 0 };
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
@@ -9501,11 +9506,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	 * status responses.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		status = MGMT_STATUS_INVALID_INDEX;
+		match.mgmt_status = MGMT_STATUS_INVALID_INDEX;
 	else
-		status = MGMT_STATUS_NOT_POWERED;
+		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-- 
2.43.0



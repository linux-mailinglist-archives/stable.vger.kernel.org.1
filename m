Return-Path: <stable+bounces-98903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 306329E6361
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9021884CF6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F613AD2A;
	Fri,  6 Dec 2024 01:27:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C42F855
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733448434; cv=fail; b=dSxMNiU1W1r9yzuJ00/5+usWZSCS8rv+5ZMd6oa9HUIciOL70pDnRx3ojzRppqExmnYuS6rQg93Z9YRzj5pormipNqtDRQmyxzWgX0d/ddqExtaGW4PRw+8WawMHJjIg5r1zRVYNrwZoPb9MLPW/JP6MQdj9Kl5Khpk/UudAbrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733448434; c=relaxed/simple;
	bh=nbT/xUnSyczPWoJR/ENuvtmj0bfI/ngGiHBmaC8+Hi8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QGg3bPPWhaeikbnafnoPXzGezEX1ZCiJt6G24aQSEPTNDpsrk5yEHfyIWbd+YWQV0aCaHDEHam9EPWk5KoCa6t+ey0EXyhyI4WOLEStGvGk9SSwNVI+w1mOpj2rx6IwhCaJOmLwt7cmTkycxt01cPvdet26vNdfYuHbb0rnRRPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B61KYuG008169;
	Fri, 6 Dec 2024 01:27:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 437sp76s5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 01:27:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDzXsov1Jp2ywmsbvf6W7bEr8wxxNfTDXFnEzOgnL7NQ+FIvIbfS+1fb7lbdJAPHxJPHvUlP0FvmoQr5qPegxrReBVjaZnU1Nv7/WR6X5CqNyso7CvtO2bx+YzKhGg7wfO5uhA8cO9V8mj4UC5zGZTjK01hdKkIZMACpkjxpeJpeEj3H1rz7TcKPjbRPODBysOClBrpbpyjriN0b9JKShV5uf15O3pmxykRK5o+0emDNkGL9iWjj1gCb1JJNp+t7dZgRCywSlzP0Cy4ZUZxm/Q0Ph/GPL9adxzqFnWfCnFF0QW/u7Lfp+BYwHy8C8NiAzrIG4iYRcjclw/hpwiTeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koFnB8ikFrdE37Ruco3wihI0mb7snXMYfJcotowdbAk=;
 b=wmmPx9zqQ7yIfm3xxJPwxTGfKEl7WT+/AJY/w6VufHa9ZSbKl45+IiBHaKFZPQZQwTOpLj0bNfT0FoZYlHU2Zrnmb2qhDwadAFs07G+PTWyiWqGXai4VSmObAGPPShVPdLtNYsUfvh3GWfAVD1zuLmkLhfsD+2Aw2DGxE5bZkUD03jdnrTG++F4PZyD2vk5gsfynvaLtJgIPUzLtklbu6yfRtcB0nXHbs743QiYgTA5x9oNeNaohG7NFNmWQq992U2xnPVyIsBXtofluo6m7+/nnt+8yVlCbZpFTq3oTEPrmcSvHUDviBvmfxnMIvRUW5wEAp11eOW9Cg8ysQQHKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 01:27:05 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 01:27:04 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, irui.wang@mediatek.com
Subject: [PATCH 6.1] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Fri,  6 Dec 2024 09:27:12 +0800
Message-ID: <20241206012712.593884-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: e0dc0a28-aad1-43ae-b6fa-08dd15951735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uvxxb2MqqXmyZ7f4R9+Y7NamSm8fwCtPu2a9+COB2eCC3p363jfG8sIi/gL9?=
 =?us-ascii?Q?MAlDiRMw7i159qMSd7dA0dv0RRoAHYkNi7tx7Nd7fcYHlZqwOJ7MNS3ulczG?=
 =?us-ascii?Q?LrNrD7GdIz4nbjTS0OsOPmcC1rRJ+wLvdwZl67dhTjDWyY8m7VLW3LhoUmcw?=
 =?us-ascii?Q?rvWbK4+ly0ds/EaKtFzFzoZQXBDBWJA8eFPVZqBA8zCCOSd4XIlZC2o/TH2E?=
 =?us-ascii?Q?ZLSFY9V7v+Ka6qL841rjji7HiF9LsGT8B3wY1wCdijC0ILgoRXOBuOwMgfMh?=
 =?us-ascii?Q?ko5Ly8ralqmxrVwkZ7GxLZAJzFJ/gsw/x+2NwA0UjS4ufNjhbpRIBwnKIPFy?=
 =?us-ascii?Q?qOubELPRo2Cz0zWaRti0mviJlNmOjR359qVm8WmEAF6iomskqKPv7zurESC1?=
 =?us-ascii?Q?4qkZG2BNtqwAta+4KYfOcvLx4UC73U4ZfrDoI0H7mTSee/wv9RSlCLkec7SV?=
 =?us-ascii?Q?RE/ft0TT+IBkmDhHk5x9Sekpxb2T+G5NNGuZzFw6g4oxSwVRlKFkHvmXCmZi?=
 =?us-ascii?Q?lHHpHpaq1hlnLjJhlGXiLnb8JTu7Xq81MRQd46dscg+//CAD8cmCkRUtosKw?=
 =?us-ascii?Q?5hFDGUqpmKjdBW3GkSDLjR1zb1cPAylMJBX71f96JoSt+iaw1QBFhwOJw+9x?=
 =?us-ascii?Q?qf0nX+ZHsNzpID/Ydlg3VashWzih4Rfw2bD9pNU82XM9XQBkBc1uX+1iB/DJ?=
 =?us-ascii?Q?7Z38cf7r/NukyCIiU7gcIzwkHpd5JMwJMHg+2hMylqreLxUEmN782S8uhOtZ?=
 =?us-ascii?Q?0hzTTNI2l/pg1wp1Ha0EsvPV3MvOrm7agFO4A2HEljqIelY+ryQFx5+7/v22?=
 =?us-ascii?Q?0LPvI6W1E2lKpf3oPO2ywRYRScvl3az2bDvycuM7L49mCMTQyMYD+XPMaUJp?=
 =?us-ascii?Q?cqZfxLQRaRfszAY2U4fcr5k2xJopR0ZoGfxwo6XZ2Sgew0CYDZwz64/2OIN2?=
 =?us-ascii?Q?YE5oD437IvCdAHK0XRmnYIp378nXxgR5BZLbRXnCZSSmvdGsZqmjyhMovNHt?=
 =?us-ascii?Q?Ok9ELVFWUVmnfe9ehJDNgk+N/v/z5BWMv5Y7yn7C98Aujfe0gSJQC7yFTg4k?=
 =?us-ascii?Q?8qKauuhsfZjgeWUNe6rcQ06ul5c1cNMs/KUhqJmX9jp6va6VYLAcyoi8qIac?=
 =?us-ascii?Q?5/QU6R3aWW5aw1MxofbQjohZEOkosMhOxhLJBC9e1rjkIa6NW6j4IyPp0IYQ?=
 =?us-ascii?Q?t2zCMNC3DUR80XOtdqzw1TiA6YbKyyz/l94DwBoVybQ8g0NLOumDduTmfaNF?=
 =?us-ascii?Q?Sd231t0h4AFHRI5bRn2ae50XALSg2LsdidtdwfCxYYqD0sC6ldBjxk3Z4tXu?=
 =?us-ascii?Q?hHVjIeE0h6nw07N4SEoPRrQrkgiiUG36VzWtZ7tN8WZ7U9qu3USX4REDoDbA?=
 =?us-ascii?Q?LAhiGQv/dFtDgGZId95W4Ekex7O4jKBLRsrfbCtfx6g+H+G6uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ltoZYOkXxqf7gz12wN4TzZIeOCs01Cmku3ECT0t51NAGi8gG/xvWW89KCjLP?=
 =?us-ascii?Q?e70jvfGXET0aV0iVWwp0tzfn7l79swaOuW84DGBVQlzeGeP1rD7akRwa+efV?=
 =?us-ascii?Q?7nhqwU2aHRt8DyhOqRudnzfOt1Fj4WEBleoxcozj+WpbXy8DPU940sfUhVfY?=
 =?us-ascii?Q?fnTja1VaVqni8tav7XojOTDr/f6Bkcdb8q/9w7zFeEKzpOxr+AUwKtKr/I5J?=
 =?us-ascii?Q?QhBwzUoRLiXc0HonT61bJiKlu/5sE2g1cCBnesmShu8TsmdpknTKZzJ3phej?=
 =?us-ascii?Q?lpYGg55pnn1lVaSM5tU+YQ/JBaxJ9iGtxsdWAx6z0z4HmMCnEn7o3y4vjHrL?=
 =?us-ascii?Q?gA22m7+P1MRVSNofE70lXXzN04qc81yctG6Ayx+twdTSfs3pd1NQP6gxeksO?=
 =?us-ascii?Q?tZAVM9IQkVgQYgz7JPOJGv0uIim9DaC1yKF06m6nZ1li0z3dtQYkMONz50Cv?=
 =?us-ascii?Q?GUM/W6sB4qVItxaWI7zw9yhY2qvdiNhl0JYmFTBNYBpg5iKZ2cJM5bVXl3np?=
 =?us-ascii?Q?OrQ1QXINFXIFgWoCU7OHT2GFDGavwAi0TZZJ0QTezjHhKDnU6CuCWdMZDYdj?=
 =?us-ascii?Q?HpxT669o5bVCxvm6ClQy/UfTYktzSybLXTGWzVARpauCy6rjMs9ec1k9320p?=
 =?us-ascii?Q?ANjX3nzgbgcGgVrYWZcCeYoCLzwFyL/p7CvNR/bGjamf++eHyFOjOU5kpi12?=
 =?us-ascii?Q?zPiE5XqedI6owUhXtB7GQp/sVbxiSy1GA3ghFboevFGENI0SJjMBrVjyxCr4?=
 =?us-ascii?Q?+ihUvQ7fJy1fKBZ6qLuJHAIrpsw4c0+uz1+996LZYY6XVZm8GS7vKmzva4Pp?=
 =?us-ascii?Q?+I4upZR4AfDLJp8ygFGeSECA+7Y4kqizJX/ZeiTT3Vh3uGVJsvTmi5WwgAMZ?=
 =?us-ascii?Q?B60+9AbSbXTBjYkQyKd8qmB+ABECIUHN/JMsyDUepknpV8NmBeVk2sh4pOtp?=
 =?us-ascii?Q?RftYQt6eja19WNEPGP1ggFhrcyARJm6V3NOUkASOUyvvO8wTp3+95wcMGqDC?=
 =?us-ascii?Q?QTBhbrEVas9Xkn+TLddcJp58xdel+F2NiJni1uAaC3FiX7lL+3WfVyaWLtae?=
 =?us-ascii?Q?y1m3VShh3W7GMj2g/yO6bo2Mh5/Nlj7QUGmncq3gDrPtvNsI+gxlGg4sF5f0?=
 =?us-ascii?Q?ekAnvDqf5pK2hWtFpMylDGW8zqaYcFkzJMH3oojnQAoMb5fB1ZCGBl0AFWVC?=
 =?us-ascii?Q?uGCWjPV4NYsDNDADapxtGbYU6jVHQCKn2BN9J+uR05/XGCIZBDf5ZapTkZUu?=
 =?us-ascii?Q?USiKWx9JxvMwuoAA85WHYaqCml1AWF0tVm5clbghfJ2LLdhIZsRjHXc4v5pg?=
 =?us-ascii?Q?2QlPARKIumrgoXZ8CCewsRTaeb63KovHisei0AZN1wQnllnb7Ym6qsjPS7cr?=
 =?us-ascii?Q?iu9iq0bekqEEnqdA/D1Dq0DeexDi7CiYAZlKhIc004KTc4+QccuboiNkirP3?=
 =?us-ascii?Q?rXAI7NWre34GBrkNzxyFB14KGwumYKgWKRgYCXf3OuQd1mAkfCd2m67OkZEe?=
 =?us-ascii?Q?brfDFfdhBTuBA+Zo1LGQmSkKRQtOR9NLj8p+oJ9zlO66xA1JtQPpj4oWoSL7?=
 =?us-ascii?Q?hTMWYHD3+W7cOpKq2SGnHXGhQoEnyZXAJb4W3gLpGrNXAfi7iuaICKABUUIj?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dc0a28-aad1-43ae-b6fa-08dd15951735
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 01:27:04.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qz8W3qhc8zgez43F977TBihgo79tXpyPR9/SOxrMCDO5y0c9GiBdZycQQCGNEe4uao/piFEIJN4YV8KD1s53TZGc2A3OoB81CdROy4l3z3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-Authority-Analysis: v=2.4 cv=Qvqk3Uyd c=1 sm=1 tr=0 ts=675252eb cx=c_pps a=6L7f6dt9FWfToKUQdDsCmg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=mpaa-ttXAAAA:8
 a=QX4gbG5DAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=vig7P1nWIU10b8H2HRIA:9 a=AbAUZ8qAyYyZVLSsDulk:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: zq4rFWpMl-vJfOSpIsnLM-UpJa89pxZs
X-Proofpoint-GUID: zq4rFWpMl-vJfOSpIsnLM-UpJa89pxZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412060011

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 59d438f8e02ca641c58d77e1feffa000ff809e9f ]

Handle an invalid decoder vsi in vpu_dec_init to ensure the decoder vsi
is valid for future use.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
index df309e8e9379..23984cfe2b7e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
@@ -213,6 +213,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
 	mtk_vcodec_debug(vpu, "vdec_inst=%p", vpu);
 
 	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
+
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_vdec_err(vpu->ctx, "invalid vdec vsi, status=%d", err);
+		return -EINVAL;
+	}
+
 	mtk_vcodec_debug(vpu, "- ret=%d", err);
 	return err;
 }
-- 
2.43.0



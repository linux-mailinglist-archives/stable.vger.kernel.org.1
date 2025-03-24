Return-Path: <stable+bounces-125858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D48A6D54D
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F318852B6
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FA257451;
	Mon, 24 Mar 2025 07:41:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5B19ADBA
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802116; cv=fail; b=FXjjnOY98u4Igz09Kd6pz4x60TABD+jxP6wsk57h1l22ipqx3y1o1Br/ct1ESuhJaRBB6Ppx87YAtweE0Ilww4ZUKHeY/Ct1nT+iUBjbkP8PKXhOfa3ECHDy9X1nTgNxyz2Dox6+hRmhdlqu5eFPC830zfYfsloRmCfEJxFQfC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802116; c=relaxed/simple;
	bh=6JFU+/QRb2JrUWjA4iPg2UPKSz6nQ+Bt6IbZZCmzGu4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YbJRMv7ij07CAaDaQvY86AeRYGH1IZyAWXOwLhXU7qVqO2nd7MBHqPDh8uz2zMmVDaWAwGYIyXpdd4PrcYt/25D/7XTmRwHYABjHGaOeOsMX0YPmvXd01hxPi3AY+e6TUkwRHsRFksKv8pE0AdU4kv1QtEd7llxwVOs+aRZ0UFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O603k9028482;
	Mon, 24 Mar 2025 07:41:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hje1hupw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:41:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq/zC67QH3onlbdYs19bdqlkbkYupwXVJvEjSPgJfA0VH3/ZRoaqUGXny5SNOIgwrYFTWYPgURnSCP5xhL1O3wI8L/MV/vDmcFPtUTNSzqwLvasdRaThr8HvJj2/vT5ILU2JNvIOYu64jaTUTtOMR+B9K5/kcE/vkblxZ54uvEDNq71MxIhX9m0eumaXFk85BHOEi7OLePiJK8SOjS6vRFpuJzXtdmLxbJKksD2WszNppUVzyST3O5jsAKE/xr0DkCj8K6NRrFdMuvo1VCjjWlR82atbd8xxaN6FRXjyN6ZRsWFK4i+9k1Qo35OtfdtZorhuFnIoHCY54pNogfjn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYnOK0h07bWEsdw8J70RywQCS8j73nfI8qRbQDM77vQ=;
 b=hvFCUYn7QMm6YdmlCQVi/TeKAQ+DGo4d0H0ERDb26WvbHSJzXzkmUdcx9jWNlUFnrdxegFdF+NFIgylVZBMEx68qn+B97HqOg+Jx0K0nItZyibtei9hrXZkhqXuxMhGGLVr1veYY5VqTzKBXrGTs9JVP/+AsdENfA6QYuEfs9HgKg5nEO5Y+yNs0CxHQee2EoXQyxui9nR/4GhHiF99QpOUjPOq6Va7KxzfiHoFjIzPOatVsJnalNx25hf/LSVRiApHcfG8qh0CQh1BIyThLdkd5kAyH9WZmEE4JHqDA4m1q8GJv68uVHxWGkFGGLzsCzRbQtRhgctTptiKItxoalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:41:45 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:41:45 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: luiz.von.dentz@intel.com, kiran.k@intel.com, bin.lan.cn@windriver.com
Subject: [PATCH 5.15.y] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Mon, 24 Mar 2025 15:41:29 +0800
Message-Id: <20250324074129.1066447-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c898dd2-2b97-4625-1915-08dd6aa753ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypNQW9QYXw83F79TgPGyT/3phQ+58uoV7fY6yxwuipbDqol9NYy1s1kuem4G?=
 =?us-ascii?Q?2dIS+fdnWyOf0U8OfDWzJdDBlHeKRlQeu+dXouZE5K58+eMR1Lr4F/e+f2KF?=
 =?us-ascii?Q?sC0NdD2+IUxOZLD5K6sltltmScbLFwgDfJeaYLvS0y4Imkjj0kjRw3oG8p+w?=
 =?us-ascii?Q?99JS/7o9LRvVOMMzDXy9vk5OYrrDClo/P0krSC4sh3DPvNpu+ZRHg9tNILcJ?=
 =?us-ascii?Q?B+Qpt9w65l3V9RDT/vQzhj5MXeovwC/qwp2xUCEZju4QUTjG5LMrtXRrvZ/b?=
 =?us-ascii?Q?hcOCKLulIc3ZoUuXXRToDasFRD3+V8gXpCuHklgo+AX90B1LjaSteSW/wWnr?=
 =?us-ascii?Q?2Hm3jnhnQQV/uX6UoOu5NJmLLkCKEZ5j8I3K0WJzxDtbz99JJkIw6ONpnano?=
 =?us-ascii?Q?IWEKfjPa505V2XEsAMvGyUEeETb/24tYhSZcghaWHh9A74Hqhz2k2DVhm/Jn?=
 =?us-ascii?Q?vQsnHC2ZU+2SUt5zA/20OPcXJCIPe8Ft7FFG+pnEEoLp1tIfMtAnAQAfA8VJ?=
 =?us-ascii?Q?wT1KyJ/Z8iEDbeqKqJk6IXADq/iwKbU4gY+LNyTmC7jBc46iHxo6ZVIuHaOE?=
 =?us-ascii?Q?wlNl+RHL4NpknFaCbiH0BOYhANgIxNwQZhx53h20bQ526axPkYKZXMC5mzUS?=
 =?us-ascii?Q?kDNEK1vk9PlObaNf+bnL+wn+ZJhnGUNhccxfuobKUUjfRSH2HY1YVDMf0iMG?=
 =?us-ascii?Q?WYTOsW8Nr6nUj+JtMHXgdo2Fndq7q1cWHUIZ2xBfaOOgNt3qN1gfg+AvTkD3?=
 =?us-ascii?Q?FA1MlkE/ob7GUFQ8S+anGTzN96KRG57M7SO2XNPT3QYH6WymsYoTu2puHZSE?=
 =?us-ascii?Q?IrSwizKQEgX3hwQg0vC7W2sBylg/oHz8wCKbjQlC8pQOYV1SIYaO+NcQZdl+?=
 =?us-ascii?Q?0gSgCy7smqsJZQLNm7JXJqmBAklAV0wXk/nFdXNG29qR3Vdr3kFxavl+T08U?=
 =?us-ascii?Q?oNx+c3vH3wHDtz0TcFbUfKLTtMu7Cvd302CBtS/6rr9iyvcTGXMnsLESoJK/?=
 =?us-ascii?Q?od8ZrYpNsMPIwax5GInypoRfQZT7icsNP5PH9rQE+AqSb9XUSud4kANacSA2?=
 =?us-ascii?Q?w4GyjDHlFxSCraS5jI+g7mgqo82zilr5W73dVgJ5vrW/jDuUkMtw5Px430Xs?=
 =?us-ascii?Q?9lF12TYsKZgJuwwss/UcSijzOhlo+2/e00AxqVY9PCfoZYDIYZZssDDE4RM2?=
 =?us-ascii?Q?E/T6GUAOH2LskFdQOwSzLMuMra38Yy1xO2wvfP479qUWJfhmkKLfuCdtpxwa?=
 =?us-ascii?Q?e13197K0OEvHF2ubxKYlbscJ/stIehE8ITFRtbFDl7uxPZxUGon4UbTJBf9V?=
 =?us-ascii?Q?KkFdNsKy/mSoZ64v11JCapq5983BEgaa+8iDYwJAvO2EiSjJDmm1rtMh8fhi?=
 =?us-ascii?Q?eTC1C1m2QZtfIhQGigfg7qLBZPj8lQgKMHkw7FQ7Ok8GDcV05bYS0yDeUulu?=
 =?us-ascii?Q?OQrltR2G4W5bXiBN2+23I0ESWuAnBIC2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pmkJnk2jPW53Hju5EC8a+vLH21iSIVYZNN3xdtS1SWKqn4syO6OKfNTu7di?=
 =?us-ascii?Q?7DsK/n3ix5Vam6sE212dqvsZBKRwyxlTFEbDDcs45rnYdLX15j6pjr8fFY16?=
 =?us-ascii?Q?lOaLbBkbpEwc2BmEcPfMkjnzsL4l3fTf0FKqAUPaDwvLBADQ5g0npX57X4JA?=
 =?us-ascii?Q?d8EPiz4EXcdvqgI/KooJTLpXmic4297fnFDL1uRYOP3Ig9EPib7wCTZDipCS?=
 =?us-ascii?Q?qCbGiYLeDicpgs6ALMrrIGVn+5OBd7Oee1u+uxZQ6+hQXbcqONjCFzvk+OFU?=
 =?us-ascii?Q?2ZYtAMArMJaJkTMRCb1WrhxR8XF3kQMU+LxEZtN25TqyirvS55HYMdZxNHpi?=
 =?us-ascii?Q?FS3oDNd1k2qkg5FU06QsUtrlauyworyGgVZjWx8FxedU7oYoXvAbhSOGLyrb?=
 =?us-ascii?Q?nIFDhCYsUc6SECLswgCSsQm1+gjcGCvbkfnY3+EQELv8R6ulK5cE0qmKaiOZ?=
 =?us-ascii?Q?TRBorc6R//lm+mZW78OPQrwJs3R8NbQQyK+dq+Uf+JLVKHfWW3Pw1v+G/+NY?=
 =?us-ascii?Q?8GUB7BoQhkiiOFkpzXvzi94SfxwjAnuvJI0WdtVXHo150Q0u0s88ViqN7tx2?=
 =?us-ascii?Q?FBzk3F+tduvVmZ/42yXVZzCAgpRMlOA2uJZeMZ5/2Kuj/mlfOlhcj1pJZwOX?=
 =?us-ascii?Q?d4QSEXgZ69bVSS8ACSiVyL24tKQofAK716OCZv3pO5NqqIHmypV0XZUMh9m/?=
 =?us-ascii?Q?zQwVLO803itdJwJhn0PKigivilD7heYO48AnU3+NYlbZWq9pQFAySX4raiuv?=
 =?us-ascii?Q?uX4MJ0jVXjq+rcM/fGPLwc9HrchKASFs00k+SZ/D70ysod/YmPCNDJE/9R7+?=
 =?us-ascii?Q?RLjZ2idfR4d6+4iNCs7+R3jQEYTZFiqtDSNq2xK2+A3kzYh6leIuaGX9MeUN?=
 =?us-ascii?Q?jupV1RuFuQY8Sl69nci2pUauIHFpIdYOUO+gfWBuf3kbxVWxXgniNoaoJGcm?=
 =?us-ascii?Q?gHAIAUWbcZnxhGcS3o1zFkhif1VSv6zSVJTw9mwBt3VGeoPu2enNGYQgXhg1?=
 =?us-ascii?Q?sm3nGKKNinDvp4lyF2lWZpWnA0n+jhEciSjZH/1zlISjiNmE+hJVWJr666qd?=
 =?us-ascii?Q?OFwvstz5UgIYNdl6+mi+2h83RKQfKticnQ6m0yVDBM2C8AeetytCcKk+qOaa?=
 =?us-ascii?Q?BKWTTvWnzsfsHb2pGqZFtCsLlMKBosoLFSBMv6Yh19ogVCCXkWXmk+z29zwx?=
 =?us-ascii?Q?2YYMAqhVnj3oDPF+RrZReIyb4mlF1Ka17kGsl7aiijopgHb/RpsLWKv1FhHZ?=
 =?us-ascii?Q?/nw46UPdTrIETPPGNSdT9+uQDPtx/GPjh0vnFuYrORDA+z79CL1Pxb4IWJxU?=
 =?us-ascii?Q?WTmyb+0HABaUGxcm0eNDNkO+02IJPu/SeYakK0NBdcGE9SUXjNsoBBlKbDbr?=
 =?us-ascii?Q?52bVqRN4dy9B4o83x/07ktBCthh84UQCyYalQp/NZTyisJ7dcnL+dQh5bu0p?=
 =?us-ascii?Q?a+V9TJKGs4NVwS44D2i/GWWKlI0rZ1DaStD/B8WK7jTySRVT3nwBh0YcUNLD?=
 =?us-ascii?Q?G3FpCKskspvM8pEZhTVV4aSkLVChDQGJn1UZadywTP53fY61MjNieEoVZNr6?=
 =?us-ascii?Q?aOdQ9DUyNiR17YQYhfBjea+21kHHGhuQJEE9V7q+DeB4TnxgN2HA5loJDM5/?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c898dd2-2b97-4625-1915-08dd6aa753ab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:41:45.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h161V4rSMQh+9Qtm2Y5/UEGmjzWLIA7JpiaoggwROVzsKfIvNcRapw0/w4TuM6TgLigD3S4+s4dm+plsqVR6NA87HgrWlQPuKdO3Fb9ouKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-Authority-Analysis: v=2.4 cv=KPVaDEFo c=1 sm=1 tr=0 ts=67e10cbd cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=hN8hb0Oo4Tne0L3IsIcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gNwhQZgr-7asCeI6KcuRqN4ok-Cy-rvO
X-Proofpoint-ORIG-GUID: gNwhQZgr-7asCeI6KcuRqN4ok-Cy-rvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240055

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit b25e11f978b63cb7857890edb3a698599cddb10e ]

This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
("Bluetooth: Always request for user confirmation for Just Works")
always request user confirmation with confirm_hint set since the
likes of bluetoothd have dedicated policy around JUST_WORKS method
(e.g. main.conf:JustWorksRepairing).

CVE: CVE-2024-8805
Cc: stable@vger.kernel.org
Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 net/bluetooth/hci_event.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 50e21f67a73d..83af50c3838a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4859,19 +4859,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
-		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		/* If we're not the initiator of request authorization and the
+		 * local IO capability is not NoInputNoOutput, use JUST_WORKS
+		 * method (mgmt_user_confirm with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			BT_DBG("Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
-- 
2.34.1



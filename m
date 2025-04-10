Return-Path: <stable+bounces-132068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A1A83C22
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954F17B341A
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C606E1D416E;
	Thu, 10 Apr 2025 08:09:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABB381A3
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272579; cv=fail; b=oU6kf5877O/C9tDAlkypghbM6wxbSIin5SGFjXhf9pPW/4IrhfzcB4lJfKhGNOOMoV9ImiRilfdJ8bPUgGFmRplFn0d1RNRKbeasxgjp3cbW3C1UfkEwANY8XVjlLdm1zAm1C0EJ8IHDCMgShwUT0lec0jq8+TBih103sztlPzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272579; c=relaxed/simple;
	bh=gWUPLjgjjGfJyPJkDOjxy8/Uvh5PQYv46F0cVOAMO6E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Oeelww9pyp2eJZ1QboWB4Lb+VA4NsdXNRryy0jn5EtyQY87CTvZhDLuKqifUcZJdmu/wgapR+5wbe5qhSOGswlzWx4bsD94+VYumiOuVgrDXFZQ2F6GHPZYj8Ssqf3kbtD5IvhzaHNWN/SOcj1Mvd4pt4GFMKHB41SHotowlMRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A5JE8G018232;
	Thu, 10 Apr 2025 08:09:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tug8pk6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 08:09:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYX5VWfnhkqCdIBY8rpW4RWcGHzpEQ2LuXU9dompTq3EDEcMqRYPiRszPuXE4V3TFOjoki0L5w5MTn7J8Q92VVSeYqZWpKbHjKmPTLEx3Ii8H++ts80BQpKFMo7R8Xo/q81zhP7euss29/RJ87/scJIF92yTbxOz74gVG/D/5DEQ6TrnuYN04Oy9BaPYBrBaM7MXLy7pmqKSn237OPKr0Z613azPwfJ2KXiC93EPA9hnThShRE8ivVJggfK2vKGDQVDR3xiM4OXls2n/Yqb/kvbQvcb/iYwGiiHdZljmWZ22GGfuhtEeCYWLEv/FQ0GpiQ2Uw4/cjajAJDFjyZp/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dfLyxJNiY3/lGnaLex7hiWK5DtTwI5OPrthXcjT3po=;
 b=h3dFsohMYw0om3X9ZfTkhkRxxal+QINkbKAZgpzNLPczJzInz6EnneL2iK6lSbhpz9KZwOd0zk450xYpnq41MYE/gCZjef33nzZlyC0yj1Dm6j47AnbBNZPrdJ8Mn5vvKZO1F6cKf8EiSTE+Gatk2l/JtfB89wrjJU1PFISx6udVkij+eiv2gX47IySYf8uAXVzFzwbUquIwMgmOHEEwgBElxtLdMMGtYgiwej2cgCKq2KcQ1T3HxjFAM1uDDMUgrCTrZC0nyqEJ1hSuwTNARHsMZ1Q1WHvQboq5QRkoyxl1h8s9cZDZtgzu1RO1oe9PlNemZ28v2eANcwx8wfRuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 08:09:27 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 08:09:27 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com, kiran.k@intel.com
Cc: zhe.he@windriver.com, stable@vger.kernel.org
Subject: [PATCH 5.10/5.15] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Thu, 10 Apr 2025 16:09:17 +0800
Message-Id: <20250410080917.2121970-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0311.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 198388d8-8f20-484d-db52-08dd78070359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HsTdHyI9Wr3XPiQHg1KDZpmU/mSduNEoJ31Kicjx2dJ6vMQwzD4Qi7/MU8TI?=
 =?us-ascii?Q?p/doD7wjGuLDFUGaGSsuBXRYDDxxeDKwKMYyoV5uG/TWQOsqpQyiaO5nAMZ/?=
 =?us-ascii?Q?jNGYEOQ2y0IjmQa/fYA0eoFoF2I2UHUM05OulFMBr+C6zgGHZz4XLJ/Bo8Qm?=
 =?us-ascii?Q?FZ1KUKgsJUIHbiqz9C4OwnwaKrmaGXP/W1pMAt3Rd4t5QH8czIAc5PQzPxZF?=
 =?us-ascii?Q?vMLQUG/C+G6cR2FF/c628prhXKQ5Vojer38rkmAecGa4EX2/OvL54CE2r64I?=
 =?us-ascii?Q?fhjcDP4UYmz5gJ+opmITMLDLupnFNULSOvcbDYB27hcZ9SJ/BvGGtqC52syi?=
 =?us-ascii?Q?0/CQ+rsQq5dS2Q0FUw9HaQQWURAFP2rfy0nuy8IJvH+DrJPSZM1Rqy74vBwL?=
 =?us-ascii?Q?91eToN/7WrLdQnH+INN1NHHrOLpz21vTlSkXTwuqhEkptOVpUsBdY4hx5ieU?=
 =?us-ascii?Q?OVqdms6x5uD7D6d/AOKs58bvC/E/JujZ7X0OrnikXAzj0YKieLs74uKuynHm?=
 =?us-ascii?Q?Ajc0vXPaAeo6R2X7lLmnMarFUyGEjuSLo3vy6T6Io0AJiPdbru3tehOXMxy4?=
 =?us-ascii?Q?VmbamkYZjx80w3NSnK1RruVxWsPRicvZCVPe8uQapYF467/QLEgVLrAyKTYu?=
 =?us-ascii?Q?D40zN0xkXblOFz0E4JghBt1KqTgRImnEvfvCbEP42a2nQluK02Uxykq7ABXd?=
 =?us-ascii?Q?CaBWvoWwILbjiEtI/V2NQKnh6eiUf1B8rDPvglY+S2oEb62f1GtoJfvxBYm+?=
 =?us-ascii?Q?rOv8COC7KjNYPoBCjM4ULZm2VHF4I+eH14qtIdTzILqhXhQOBOIs+UIq6KNS?=
 =?us-ascii?Q?vm9HFtn4I2Q3LIR+EvrEPYtNmOSaV3EMK9XxqipQPZM0tyPQcU4D57vLngPQ?=
 =?us-ascii?Q?Mm4LKGor7efou0DuL4omsrPBD/RQyDbLsY4YHUMjjSRNU6+e589PKM3hHXni?=
 =?us-ascii?Q?HdBX/Kpot9+8E5Q09S+pIL8YuD3DiUPswMkSz14dpGwBOcPyFE5OOgkqcD3B?=
 =?us-ascii?Q?22Qk70aiIYUMAzyWWH43WVL46hiDxyECzO6q7CYv0MuaVpGEaDKF9MBdqBSY?=
 =?us-ascii?Q?hPmCDxTaztRFgxPSUf7gNAIq7kov8pZffaxc4EQNPNlc0GWJrW0jGkNeEQhk?=
 =?us-ascii?Q?HLAFs6ljsu9zP7PpzBoGRj0bTzDDom/ZywgpO2lnUBZ2722q0QTf2x8AdMJ1?=
 =?us-ascii?Q?XHJR9irPN65cbabRIxlCsC461A9XiTnNnQFm1A9AM3YWKPeM1j8bRuAOr/v1?=
 =?us-ascii?Q?njz1FmbVaNpAH3cZsmnP2f0LbniKsMsr7joowYLcI9f+EDqdiYUSRMuoWIg8?=
 =?us-ascii?Q?vU7mGAwwYwsic+IM7Ng3/rMCBKmkUwp4CuxxbAD/iO9ql1bhLsd68ZB+1uHh?=
 =?us-ascii?Q?0Yji29eSkN1rwHVxF/JrVkdAaTKt151RmKXdWNi5oJXfj3gSMgAlOohVKNhU?=
 =?us-ascii?Q?S1JQeBE9HNUinm9tr3pTtjACvBx03c+/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJGxmFhRLZgRJveVmH/1hh9VHCnAapulNbYkOb4Zw0cLvzO8B+a108nT9xU1?=
 =?us-ascii?Q?cnB+Hvu2LVyNtRo+HqC4YJwgzi9oFIMhIhDB3Bod/Dg9eOqQO+adZP3JLbNR?=
 =?us-ascii?Q?g79JHKUrOpluudl3gpyBG5Jzrb5o92tiEKr+tPHyfhF7Nn8inaVwOmnJBSea?=
 =?us-ascii?Q?Ug7Fn6ydE+t6I+f0IBdvrwAiBn2PVWbFIOXdVZnjR8UrmS2Q8B9Ep7NaqN5X?=
 =?us-ascii?Q?EwURxHpziCwi8EhFD43OkBX7deGYWu65F8htdiqArz8PE2IFkXHhVOf1fKZs?=
 =?us-ascii?Q?Lof86eUs5Jp96OC7a/AOKjYpcdWxDBo25ZlqNcxVGWdwrC4Oom33kdrAlZUQ?=
 =?us-ascii?Q?3kRFpbT8cx5sR9ki00+KaykrGk9HZYQyKMgGcamzsC5sj3OuW76yeZSIlT8l?=
 =?us-ascii?Q?zIFGm4q2xI+oUyS5BTgLc9lJNKVdQuA745MT2g9Q61MgpnqhUdiEcCgQIS62?=
 =?us-ascii?Q?rwcQigrKmTfBUxqizXTgNJd6YWB26B+rAJypVewtFUkfB8GDrsqu6mBAZvP2?=
 =?us-ascii?Q?tEaQYQf6WA1cGptjihBHZD3dyQG+VTL2fsmKytvBoXtdDkrG1Lqpio1dBesP?=
 =?us-ascii?Q?nuq1kZkth56fxht+sVxZz9kMBjg/RAZi9P0V3HxdPfk/scvwv4mX8L0bpNRQ?=
 =?us-ascii?Q?Y2T98Bq8Slo9jl8uiy88yFqHSIGL2BcJPnTjkUO8eh40G7LKPi5Ug3YoXHaJ?=
 =?us-ascii?Q?SDD6nfM+Z0OcoSb9oFNswEa3C0i1L+6yEcdxTAQzYvqwabrdZOCZ/7cqJ3P2?=
 =?us-ascii?Q?O3xIrfr+K3NL9+J0YidXadssmQsIUF3GjXaXdpSDsBLpmiWmvVqVQlwgc1OB?=
 =?us-ascii?Q?3l0yspn02bmny3Vajiqq+XsV/vh2FFOh9JJS76lpUhoiPJGtCdH5ow9W9QrL?=
 =?us-ascii?Q?ytxUrz1Cj8QjszlqeW5yB5NRFbZsjdw3lTyNAjfuL6MJYPdc3KdUiKlW0DBq?=
 =?us-ascii?Q?IDpInI2VCqadYWLZ5KkupD1aefQ6SMAnhY5Krp/EQJvyiujekhnvfgXhpwBn?=
 =?us-ascii?Q?mcb8udgn9Twwu4QDGeXFXlMQ7fq8hEllvkIDPw/y0xrSpoYdKLeW9fZPAAEr?=
 =?us-ascii?Q?7fv+nXXsbqPsN/O+z7NuUDULPoYJG1W5ByTuIs2HIbYUYmdq+euMCh3J/6x8?=
 =?us-ascii?Q?9SwpKlbyIwfmyYyPtlqdTz4f3msdomz54WyvpPMme1O7mj0W4h8uIrfZvecv?=
 =?us-ascii?Q?O301Fu7mhhPCMwATXD4TQPj1ng+HGFnUNxJ48pGpcRH2m4fSz485RMY3b1bI?=
 =?us-ascii?Q?GPfOa7MH2qj+EufQz1eCp2tqYJRZMHqUDE8J3DFwzUYUUMrg2wjaEdrbeO2l?=
 =?us-ascii?Q?yNYu5rrYpgTK4D9AZJGyNrCzJpCMUOyGkJweJf+CYmTRBSgihNRNEeADSIw8?=
 =?us-ascii?Q?Rbjps4HdZwiCDddegoYwv6Vg6DkZbP8Be07hIP69j9MXohL3hq9EshrKVRmH?=
 =?us-ascii?Q?4Zr7m6rhPav9xmOSLjMtZSPR+Xrao379Bs74Xl+lZY9tRbogPt1v7618Rj1F?=
 =?us-ascii?Q?p4z8jJjYYOkW4elSOsYPjkfaPB90zJ379azCGIf0olM0jhTd8Tqf32I4s5bh?=
 =?us-ascii?Q?OX8YyRUwy46w0KsJ9I+HH8S0sqs32opQH+ewuC5N9Pwu2iuMF26zGLbchSfb?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198388d8-8f20-484d-db52-08dd78070359
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:09:27.5136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIb/Z/OyZlp3+G38JcPMEccd/yTuC4NJIxV7qL8L33m+CLgFANG34ZpyfWnnBpX53z3l+4F452DNAZD6grdH+zoo0Q6fSANak/K6S24KNoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-Proofpoint-GUID: Kgd5VEp6GvfmrKFD-P6HYBwDeTJXF4Ao
X-Authority-Analysis: v=2.4 cv=YJefyQGx c=1 sm=1 tr=0 ts=67f77cbc cx=c_pps a=2TzYObwzRp/N0knVItohZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=hN8hb0Oo4Tne0L3IsIcA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: Kgd5VEp6GvfmrKFD-P6HYBwDeTJXF4Ao
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504100060

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit b25e11f978b63cb7857890edb3a698599cddb10e upstream.

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
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
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



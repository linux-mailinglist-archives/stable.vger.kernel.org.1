Return-Path: <stable+bounces-125859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3CA6D558
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FD93B1B03
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84461257448;
	Mon, 24 Mar 2025 07:42:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDD25742D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802134; cv=fail; b=NMPhpzh5Tx8+YTfpard3CX5/DOqVBsI5CTqnh9nuuW7Wr4fZyJGpMMLtvAXv7QZqic6LIVxdorxp/tazN9cUGYOzF40UDnXWeF4prA2rWNwT/JB+9kQXZ1rBgX9s3Qc1LZjNrZlQiI0cvbawjp8mU3FyuquTt/Fou2McTEBmzR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802134; c=relaxed/simple;
	bh=5Sszi9/IFgXEf1AVvrXnZgz/z2/cVsHI6y+BovpwFiE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jgGu8hPKZ/R4P/NCwMYI5Y/TYw6hPSQiEw2Wl974RB/IMPYbqoBtwLAnAicT0X5GX1RvujtZgBLEwfz6/r3n5/faaCQnlQvILrzJzZisFukEKkWKXhUKEcVV6qDS72yJ67u0wJw5jkPj4pqOmWlvYiuc+BRHB/pfWQOajQgsbUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O61L00014970;
	Mon, 24 Mar 2025 07:42:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68ht2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:42:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yobGe6YQFRZA7z+IlE/EJ7QSAhP7nHrLtFfgYXOxDhSG4IMNRVuik3aAoDD1OQ2iOOwZDjXxohOPzODfTq4Z7yUCr2FiOgplKM9GA/xK1VrzRzpBQLE4nBZ6CAaXeZRlm+qPX2m4fhuEaOjrHo3FG9ZC5JCTOOxkhX/j3MBm/c8qEHriLLVuKmtQvgLnO76WVwzZztwrKfAChC7lV48oy5jHHxSCj1Ey1mnLSz6eb8tdpLxWGrCUvMyQkG8gxmTFa5I9/atCFYtAepNbeqOVbCm7rothOB9yA2bw0YKZytXgEfpkWs6q8a8XFFW/AHFB9A7V6i35vAf9Jg5H/11a5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BQn0g/GI7KhbGwzGLjKHJSEK+6TaAIhfHMaWLAvJVE=;
 b=hUR1rC1Rl8xIfkSzksqgUphRDfk6aQtZC4ynFWcQxP6vIyC/OCrmzgfUySOq0fVhX9zctY5tRcNFgWfD7mD3b6jeBoWq2QgMcNFrIrRdDbL27oU1wpQ5So9YnHnR/dyycy7QoAVx5eO0qA3U/nBQj+YOJMDUqVrTti+9B0yqW1DjmnpWzoq2iLi+lHIdMmFZFprSSUYyVT8fg5pCWeT8DH9aPS2lnzmP/smjpivIM7ZtZr08gMbXg9x/D0X0bhUJFRJkh3rFfS4JY79UxkROhVCrqZf1GVVqK5aI/Lo04CqNFz/+j4cFwpber4kF5w9q6KkTQdC7r7BS7SLFeZR7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB8449.namprd11.prod.outlook.com (2603:10b6:a03:56f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:42:07 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:42:07 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: luiz.von.dentz@intel.com, kiran.k@intel.com, bin.lan.cn@windriver.com
Subject: [PATCH 5.10.y] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE
Date: Mon, 24 Mar 2025 15:41:50 +0800
Message-Id: <20250324074150.1067219-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdaf88b-ed3b-4b28-2bed-08dd6aa76090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?biotWYa+xEM2Ed2I4lPpwKAE6OlRXvXKM2Bm8WX0w/C6+63LaugbhkWtaoJS?=
 =?us-ascii?Q?tVceAf90Oh0BPg76JttFzZl2AH3MIyeUGiRnXxzdmWXLiAqDTkEmjJHuf/i0?=
 =?us-ascii?Q?8IrkWq3r6F4K/6V2TAdl4XixyOTYbGJ22TB36RQwupVUlI18jaqhdwhpUPAy?=
 =?us-ascii?Q?DgCshqNI5syg2iwBpi/V10E7o1mcCdvfJqCaa3uXdC+gcud+ZLNiuUOqlkhR?=
 =?us-ascii?Q?OiNt4obJvsYfYxi/BECTGWCFuZqer8lTbYRV38i4IU8F8Mm9nxGnQ0005vGE?=
 =?us-ascii?Q?QSCPvo0fhg3Bb/csKdro6lgUjq1Eo0ossacT2mPr2nHMvlthCM8awwuTMEx+?=
 =?us-ascii?Q?laqCtd0skKAHWM/MZWOUxx+knvPOapt1Ur9Au2GrQ++oo7UgA98LB28OOR12?=
 =?us-ascii?Q?pUPl90fUI55UHdph+3p1qr9vBA+ViGN2Z+5p/OuXanGfcfDxjOsxEvcEy6l0?=
 =?us-ascii?Q?SAdGXveUMXhs0iw389lZ2bfuG0KPWf/J0ZdH7trGa21Os9eYXT6ZvuhRex69?=
 =?us-ascii?Q?3bNUbm//Mx2rDEW2jeK0aAVlZa7HZ4o52QdHO8e1hkm2/ecv3D3hlGFmJ+EB?=
 =?us-ascii?Q?KoR7OGANZOy0eQcm4yOui5U/hnoRai/dGNVSqtj1ZpO4ujBaWkgDIShvduZ3?=
 =?us-ascii?Q?zVGfhVKQ8hrPYAY5RolaM3A7VCLUPt7N5tkBQh5Lme77R1t6m+Anrr7J07Gy?=
 =?us-ascii?Q?jh8J8mNeAUWXTPexxgp49dXQSkbd0JX4MyCOr2D+OSAn4lx+UlRSSyl3Dz3N?=
 =?us-ascii?Q?oi0fo7Z0V1eeMLtczr7mLk1sD0+UkGYXZ1D0A6qPwk4M0USOeFUMLA5yrXW/?=
 =?us-ascii?Q?L3HD88acKQ3Xy7l/wHo3tsZsBUFhh7v1hQXckaeKUJPAJb7AZev1Kh+1T89j?=
 =?us-ascii?Q?r3YKaAqbcIEFtLCYmR1iDJUPBUJVLHlpraVfDvtSO9bOe4zTCEDci/gaSPd3?=
 =?us-ascii?Q?RHP79jfRPKe4QGnXhdpbyfTFveGw/F8qvFIMGEwBdhNmqw34MTKt/z7soTWF?=
 =?us-ascii?Q?HSGRrizU+LT8LZGfFAADh1t+yfJTuUz2fQnXVcxL2vJXKbw1lCIR1mj+lFYX?=
 =?us-ascii?Q?TbrSKldTbo3wo8JC5V5SpM5vtPmj9SDLHl6erXNXDdNzTabVKHRuW1dtH2KT?=
 =?us-ascii?Q?gaL3nWBfWfEjdMWrNohf4N4mrNf3fDUu37Z2Lu2UOP5sGZcr1fhYl83tdgfT?=
 =?us-ascii?Q?4eFfwVYciOHZRVNgPgD6oawwUgSES1ouHeGUUa57pWFF5ntigaVE/nW7PQkx?=
 =?us-ascii?Q?DT21lwNhuyodoAHhWoayPH9U+lkcSalAIXbZL8lnFQB+HDEo+oTKmG9/MC8C?=
 =?us-ascii?Q?8HJq/s0Wwl9R2BkEUbIPXPwGXx0MvTNP+6rUZ2cpPXJXUjVmcwpiDhu3s8wZ?=
 =?us-ascii?Q?Ml24o4QMTp7dSSDaHouDsunF2FDAc9ANT3FPKbbSjGYBafbI5c1hIDuso4uz?=
 =?us-ascii?Q?gIibDa/9AWCWk6LksP/XZWbwHtrHZfG8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8LCL/ygH6cGFlNq6xx7IEBL6/IBN4RFUxWG+UKZHDSyhEeQXgt/godnmI66V?=
 =?us-ascii?Q?/iMJFCKKgJc1kqDx7MOaVvNLl7Sdtcx0BPN8J9zFLWfCDsv5+ZPrZoQRQn8v?=
 =?us-ascii?Q?n4QpeXXX1R34oyZc1TKs2s+yH+A4olLWtDZzyLI9B1JKemmMMG8wxIWO2x2U?=
 =?us-ascii?Q?kQ56wAA8JmaWPDLr5m9j/5/1OSramY7bU2IwM3QnjzWGzCD+cqYq5uJfUeiS?=
 =?us-ascii?Q?xMocOsxuzuqYf1qT0eaKz06TJkgeAKtkWam6vnNWjCTjPP5MPO9qG1ij4WT8?=
 =?us-ascii?Q?brYyAvg/C5vVgcHiu+OfozEZqcsPNGK36MChIb6vTAlKTXyZJTD0INo19aK3?=
 =?us-ascii?Q?jdfDSxDWT5zDnA2kS4a3QntQ6qY5Jox8jGG3frG1E2ecrSkMk5q/Lmk477rb?=
 =?us-ascii?Q?jA71ahUsViuODSZkfV2CQB824x7zqyMFKnjfO74Uq72FalkWaA8KM4ouO3La?=
 =?us-ascii?Q?GehWX3i/ghaQ7tHC9pe8TxJl9jUZDvvhuwVUe1nAFQqPCLn/zbQsYAE3GIJp?=
 =?us-ascii?Q?kUyObGoTszo2r7PxWU737icuwOrnWFQeoLhhiPVlCGpEEZafwuN1dBwMio53?=
 =?us-ascii?Q?fxDjANYhe6wdD2jimLlLxR5ISCoELTohqoU7u/kAVMWYiCg9h4xK8IzYvIxV?=
 =?us-ascii?Q?HWiptUPAsBpWCKVdMdZvt03S13oiv0uUOxfuzfXaPJywx/ipzlBcoe8WkfyZ?=
 =?us-ascii?Q?LAoWcUQApNSMw6YJxRKzrkFUbw7NwegBRK3y71T6wRxVGCquxgMy6zi4XQ11?=
 =?us-ascii?Q?E87xa+g45rZED5WWWiwsn/xSltDZJa9goDRdCRrYMC3Jl8S5W4TaWZmKEKnZ?=
 =?us-ascii?Q?wyjI1tD/Xi2+QLOtj41AlL1002Vo0OnUVOV252o52H2R1tIA8bbhY0ot+Or5?=
 =?us-ascii?Q?UrqkmWEnqKIdzLtOgOir+S0iHTyX/uNySo/rhcp1yx4efbm9hV206JPpddf6?=
 =?us-ascii?Q?suVVmNDWRRXki6ov6GhzMnYeajoUtJXRpZKHVoFoKoIKYMeqdsKC32tDUBtD?=
 =?us-ascii?Q?GW3mKK6xau6+g0mzog3ztGxzU+iT4ggWg4vRlnNipzvtTdnoSp1WQycuamR3?=
 =?us-ascii?Q?uTV4h/uKC2fhGVZGLa7YUGsNySFmjIS2S5jjhSIkrTEHCsAkRjaQYuRfU4xA?=
 =?us-ascii?Q?fVr2WQtlt78L6Yupw7j9JuhI/lzyxv10m9yTem+HQxFrahpMCBnbGCzXulg6?=
 =?us-ascii?Q?nmYs35sSeKFyQdRjBzRXkGVz0HGzEjgJH29jmim1C6t5ydcFt7zfc52QRXJk?=
 =?us-ascii?Q?XgA8tsHMCf+2EatSoj0S/KmFp1TrGiLyg7Io+6yM5JBx/8hZ7dPUKy2s8rgn?=
 =?us-ascii?Q?f2G6SnKDGDCdAw+/EDjO6owXfYr5U1d50Ss7h7KpUw7Nvjktt1qfCJ5HKYLc?=
 =?us-ascii?Q?KT5ZsvVzS4ddlJzaq8Gj1lNa7jWZ2+z06Kd8CXKBJkVLGwLkLz1LsUgoP3fJ?=
 =?us-ascii?Q?Q28q1Eu2s49/XTrHOOjKhNi7zu3jLwFiZNHczemMvRnufWxNlyyfzsc5cVvS?=
 =?us-ascii?Q?ruoClQ8C7613kauprpgzNkGB+Sg8S4SNP8A+GLnWQ44eHMMHZi40u9aZrnFX?=
 =?us-ascii?Q?mEx7WAahzjsJLegeIkRlnZ9PUUyUCtzP7xUW50HnrwhSvH0GzXGHv5R5OWU6?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdaf88b-ed3b-4b28-2bed-08dd6aa76090
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:42:07.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts/A8kwOs3Jt6JmD2F6vac3C2kHkeHEXUQzkl23IhomPHjy2imh7s2/YeetwovehnNWdN7LtW8AQqFUP7lpCIdbalbVL7ZiNcEYqbKk1qP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8449
X-Proofpoint-ORIG-GUID: BNA-y06-Y_yiU-YTXfv2hVYCHVhkMBUB
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e10cd1 cx=c_pps a=6H1ifQWhBrriiShMtbI+RA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=hN8hb0Oo4Tne0L3IsIcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: BNA-y06-Y_yiU-YTXfv2hVYCHVhkMBUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
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
index 58c029958759..546795425119 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4751,19 +4751,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev,
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



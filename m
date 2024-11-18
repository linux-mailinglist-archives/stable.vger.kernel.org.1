Return-Path: <stable+bounces-93759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 241819D0829
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 04:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC11F21DF6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 03:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F9C5B1FB;
	Mon, 18 Nov 2024 03:26:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278338FAD
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731900364; cv=fail; b=gCBn1d4p1RcXwo0Y2k4dmVDZRtPVyIyXJLufCDpSGuQSp+puhu7BAdQBIjHJ2ei9FUsBpfUeojCNQeATO15fe58jkpl3455n+mNtRaASJp7JGY97K0zeoj66rB2rOC6xWMblxO7FBQE7s0DT6JhpsZ9EdkcEBvIKP4woRz232uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731900364; c=relaxed/simple;
	bh=5Smsq9aZ1uhijjIKQgvsevYmJGRgSqWJ33vjzeO3Ze0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uGdesIaJBWJI4tOTcmF+/LQXfz0h+AjIB0ki19sZovQ2SrP6OwdY5xh5NwSOlC+OH/TKF8Z2DqivY5XfY3/WarcV4q+geHzWH1/gc4IdgScY2rMdkZJ+/mzVyuqI1YuiYoeePlCmkSOhzYbMH3IDI6rpdkwX7kPMTGM0nIl/+Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI3L8n2030070;
	Sun, 17 Nov 2024 19:25:56 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xusq10gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Nov 2024 19:25:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quIkOU7sq/de2ZyPLTtUhPzXL8TtzTPJQVIm8uPBhl6GXtvqpf0bq8rK/bXo2lPYFHTK/fwVry/aqhDNuOVg1JKN6PBivjJQuGhpoiebtWcUpUrWe5NIiBpdX9Rt9KQXReP3CJWqDzkY+lfB1NSLEh/XmNBNRLMJR1QdCOqwv5ON1R53rqlvMIMds/8oaOugRN/A9OmTsbjYXlcbInKYm+F++qH/YaK44dId4lWRGv85Zqh5NFOuhhHYfmn5hqismCvYmxPOMadyBChVBOfd9h447vCS5Og5CWs6USTjdqqXea8ECRB85lJ05hfy11vrOKFlsacG+39LcqRM6MRfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X62FiYwBLhy3GwLQTRhTj1YrHtN/5E6wu6n7SHkMroQ=;
 b=s0tmanjFPPAysX5QhPP7e1UXBhiV4xji9iqytqZfP5dEPvXK3MDVm7ReZqJ6rdyeMCQx3HhIGyRrWa3wK7S7HB4a9Q1v8CKGAsFOzN/Ni5Psnzn2pvdUgON1jbno9AB+oiEvenGCbwC2wDYOVIUVzwK5Vww7/WiBMog3pbIZLYEA3jGJVK7C7zoTxbcroid2Oggg5fvBSPCOABco8M4DNHVvfkXyqaNdntSjuGVX8f4el/GCLDO1CXGFFs0mHmfRFCYtcNuF5fYVWolX15TD9Et/5E3+atCpIJQJxhSnyiIvDkmgVkG8goauHmF0K1tDYsq4azkyQ5tQAlAEOZwxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 03:25:53 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 03:25:53 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: stable@vger.kernel.org, phhuang@realtek.com, pkshih@realtek.com
Cc: gregkh@linuxfoundation.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] wifi: rtw89: fix null pointer access when abort scan
Date: Mon, 18 Nov 2024 11:25:51 +0800
Message-ID: <20241118032551.298969-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d15fda-de5e-407e-4da9-08dd0780b4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfkgwuatsq9bVdIXZwHSOhTsyUaCl7iLORrCeVvtxmFc76jsFSiW3nMTxTie?=
 =?us-ascii?Q?NQwy9fdkCVYORTytrdaJA4eEGkIotuqIvgQnZHS+yZ63USw18Gk6fC6T4wkf?=
 =?us-ascii?Q?FOW79Bxpr0JG3H3gPASbBCByYx9YPfG1B6aPOZxM9orGFy4SuG6OZmMSDcmK?=
 =?us-ascii?Q?hqEy0l1p6uQ8yNI4+wUvccfBVZbwmU66FmK1qXFNjOsHyy3wA9yXW4F8J2vy?=
 =?us-ascii?Q?pAm5DEojbh2Jfzwp8STFoD81w8YQl/3G3EQdEpgjXDefyF3OfFRqMp/4pXli?=
 =?us-ascii?Q?SI0TN5O25Vnolqfkb+54zTTJEtYiCPdWaE7qKhzBYugamupUTQlooZ+tqJpQ?=
 =?us-ascii?Q?9Ix/UfVX7Sj2pr3JzWQPBfw4Sc+0X6r/ntyugZJQBxULdlG179CUty2lxEqS?=
 =?us-ascii?Q?jXi+aJafxt/3WsEIGwa4T9GG24qCgwDct7H1pz4wZl9PnwwMgjjtETEG4FXh?=
 =?us-ascii?Q?L7Pw2+e7MuTnyq6uFgtZlSTMWTfgpq81XHNuCBI17V3quMlrxQLb8pyTKYyK?=
 =?us-ascii?Q?AAFDWk2E+qWqiOmuBbzj9aZfcO8LwI7j7z0/peZCp+PasUaDl3TJV5zV7q9H?=
 =?us-ascii?Q?FNPLJFKAurwlGFgbh2OYEwYwuM8KJ6lGxbVRayC+eiGVpCfUG0OrmDKDtU31?=
 =?us-ascii?Q?Qfms8R6CEiTGxiwXf72DlQ69zUdJ7VrvTKOwJD9QptQsJg1H+DXmmJ6xdV4g?=
 =?us-ascii?Q?8uDOuwaHlYmc57Lrecm8Xq8Bw27azFU0q0ahCTzuQC4M8cKKjnPzE45XaaZd?=
 =?us-ascii?Q?/GlHbiEKy8Dnvo5nISDf9GyEkCardg6fo7dZael/fU6kLAIsB5ODbC+zDeSQ?=
 =?us-ascii?Q?/4ZUz5Gz80FF/yBwYTkxgnW9O6NK0xvoKgEEmWF5pUCwLIKInIpaAT3sMw0j?=
 =?us-ascii?Q?UzwDOy0Ipuc2iYA82a2uo94C74SK2XaIJYzEEzU1GQ/3PcpbUV7EotmShshc?=
 =?us-ascii?Q?6VHw/styyfm2pwgiL3RKe0nAyDBpj02LAzsf23s3z1FUb/TzZBWCWPNMIWRV?=
 =?us-ascii?Q?0eGbGgw3jTQ/xSl5LKnu2GM9ReKu/DSQDXQD+OeYQZ2okVKAC6sUzdHqN0fi?=
 =?us-ascii?Q?obI0nP3jnVD6q6QYHZhv2reys+8nJ29nuZ22XSenhPvjlJy8TAs8k0F6RdA6?=
 =?us-ascii?Q?FoXNadfFzUjXwDF34bwPXviDnAKK4RPp/wSe9BymasPwNplGdeO4gky0Heg7?=
 =?us-ascii?Q?tVRt2M2kDvqu4fzJb/9x6ZNb41suXS2YOhS7h7OLhBKt51aOYgIChEBQdIUs?=
 =?us-ascii?Q?uZyAxs7nSDgL3yiaLqq0qXrrWOt9H/mxqDsLJU3IyGrGnOKwh3bpc+NLuhfm?=
 =?us-ascii?Q?GkLkl2R9OwJGfHw1L+V0Cz5P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?beIu1JTMrZaG8dGGIjlq+RIK3j7GIsRmafAnlTa0Sly6IxTY3U2w1SZ53vmM?=
 =?us-ascii?Q?WTzaxFNzlbE7EUMOggFpVgW858Fpr2PCrlCmJMgmY2WdIbqTBpw7b8FAy+Dz?=
 =?us-ascii?Q?H/2AE0ef/JNFr9b8yURq3JYd9NDir4DVoWfBJI70DqZE1TiloxIroy/WlZbk?=
 =?us-ascii?Q?Lmr5VAZxgV4HQYaB6JBeDxv9UatPcrumhs4kLj5ciJZ0/i1SP3JqYAJ3fUlu?=
 =?us-ascii?Q?gO3gsG0H2TgwPUKjVqfuYHT+h/Sb6ooRluLvYDYWuRNUTqCFYvbZusXJ1xFP?=
 =?us-ascii?Q?bZNkDyjF3hltepiDlnAgNIFaPvqXS9+3P5vMQkHg4nfKHZzRuMbrFPYPPb1D?=
 =?us-ascii?Q?cJi9CN5MskJfprI3x4eVBg3ZM/v11Ab7HcN2XQiy+Ee4jGYdHZrIM/CS+Tm1?=
 =?us-ascii?Q?1xIJh23w+GyJ6aBQMJPvA6ASegDK+V/owJ3XkPE1FIuaNs3iDam1q6M3IqnF?=
 =?us-ascii?Q?Kq9m6x9NWti713UGJvm2lhFXl1sBcWdv1/ZxbDvKspStI03nbE6Wau/kaI7/?=
 =?us-ascii?Q?xCif9NXJp09d5HBQc8vc/EouCzwe1MNoksFtxz1wzg2Q2JKh/wNfz0voCxF3?=
 =?us-ascii?Q?+3Xgh4g6IlP4gSg8Gg2QUBsiB1lFRyzDrd3lghH2Dsz5jjkfokdgGcn+R7Jk?=
 =?us-ascii?Q?wOE6sy9oNtzCywd/ccpPIi2Cu0PxsEM2yLZAXO+a/zRiCAHBlw61XKfEiJq3?=
 =?us-ascii?Q?QcvRhRVOSqIOhNAAgR2FQcJ80XCegsMROeFE8l8nR3ALXJZv0QUbr8irVRqZ?=
 =?us-ascii?Q?XitbbSf+zB9mSVWI+gTi0aK9pwG1nVy3jI+epz4Dp9Bir7SvO0JAKUJ/XeFL?=
 =?us-ascii?Q?P73e+LGrYkIjJU2XuDNLtqZQoXCMTMhP3q5TytsXOioaJwl04YOH2r3E57mH?=
 =?us-ascii?Q?SRXl6NPpa/hNJX3Xd1mfq0ZoGmoqt98CjH+nV4KArIMVLobxQMXscxZVokDL?=
 =?us-ascii?Q?mCtkXqhv3u6WiBJz6qyYPxSqfvBfjcFVG4xIW+qDgOxoFn9695XCJrrWhz5n?=
 =?us-ascii?Q?eoaHV6YUETIkSBa/uR6aAjHgUXv1HhaR7p77RZH8aY7aYFFqM4n/EZWuAFbJ?=
 =?us-ascii?Q?t0XZeHH32vedag5+nC11Mul6O8LwiNf+lOpWRMCi5qcNhztDwd8/i6VhFVIu?=
 =?us-ascii?Q?niajMcyqzu8dtsIlhANRpT6evl/SS4Bat53SDO6Ik6UFh1O7b4dP2sJe3iLE?=
 =?us-ascii?Q?bjdWN240ttF0dWZmbcClQg1DmF0ubt/STI4agb+wpbeWtR4EIUGg9Luo2sMk?=
 =?us-ascii?Q?6naZ8bw1vn7PYKpQTxSSNAN6tJfvpEEpRzAegtlCWxhaA5wby4Kft5cO+POe?=
 =?us-ascii?Q?7mcedjiOjm58QJ1lmB2DjcG/RIH6C0syNTxyirAwNwhugzL7gOpkvB5JHQe6?=
 =?us-ascii?Q?HGel/xlR6YPIVdEee8ASR/AkqInuDqwxmfkZq1NJ8SXKEyWVU2Uv18/wbbQT?=
 =?us-ascii?Q?mlNcjJWiJZ8NLBC842zZnORTcA4hpQ6E4MM2eE26O9RM0pQrEQuh0Xes4FAr?=
 =?us-ascii?Q?XaPvqyjzzKdeaHvsGTLoHvcVThOXh/NQfZUT1KXILKI2SSdAsMEZtY0QVLK0?=
 =?us-ascii?Q?GNp+I+5OLyTYSsSzbweb6z8v3DQI+KAeFyKaeDYTlXODN4Hmmju2fliJBhLU?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d15fda-de5e-407e-4da9-08dd0780b4df
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 03:25:53.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxBTl5k2PjrxqeBgffKLNWMcemZqmsKEeBmsNqhGZ7vM1Vgi1Wq/68YlVIoUu8G2NozjvRPx9rymr5m0wxR7g7Uiyu+8VMl6+5QkmpoqXks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-Proofpoint-GUID: ciTvLU3x6g1jvtXRI6nnu9TXE4lxEuzE
X-Proofpoint-ORIG-GUID: ciTvLU3x6g1jvtXRI6nnu9TXE4lxEuzE
X-Authority-Analysis: v=2.4 cv=d9mnygjE c=1 sm=1 tr=0 ts=673ab3c4 cx=c_pps a=LxkDbUgDkQmSfly3BTNqMw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=bC-a23v3AAAA:8
 a=n9Sqmae0AAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=S0fjjMTt8FKBeKMgx_EA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=UmAUUZEt6-oIqEbegvw9:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411180027

From: Po-Hao Huang <phhuang@realtek.com>

[ Upstream commit 7e11a2966f51695c0af0b1f976a32d64dee243b2 ]

During cancel scan we might use vif that weren't scanning.
Fix this by using the actual scanning vif.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240119081501.25223-6-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-35946 resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 3a108b13aa59..4909de5cd0ea 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -381,7 +381,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 			 * when disconnected by peer
 			 */
 			if (rtwdev->scanning)
-				rtw89_hw_scan_abort(rtwdev, vif);
+				rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
 		}
 	}
 
-- 
2.43.0



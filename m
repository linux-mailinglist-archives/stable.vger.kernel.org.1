Return-Path: <stable+bounces-125993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7CA6EB21
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B3F169558
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20D1A5B86;
	Tue, 25 Mar 2025 08:10:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCA19E98A
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 08:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890221; cv=fail; b=LRjwYPLk7C2ksEBIZmiJ8QUIWEmzRHExtUPIP8LLoq0NCczJvH2LA4Hcc9s8Oxeb0QMkfmIic/XuobJtXF1hmHZ7anAGdHD05C8Scd6HYEhDLJ9YH6S9vA/AivVKDqtTq0XK1Tw30+v44Wh+Pvni1b7ylIPkr3hdQXtBSFRqEeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890221; c=relaxed/simple;
	bh=7SAKyEE8qmibs3SSVwh50eMIkHL5V+D4IUqQ+J4iWNY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aPZAKz/DIsTT9XGCd2+Jjw8HxPWgyOc9SXQt+wg6Lod7CG4RSSRXpOFD8ub72O1CWRTmYrZ0jMqyPXJV1en5QSP2jZGQJ5X4KnB67bX9eLetM7Vuc5cX0B35caxAc0/ZCVRIvRs5J2pEMkoobueyxZ/GcTIduLo+Wfbqk+qMykg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P6v2At013972;
	Tue, 25 Mar 2025 01:09:51 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkap7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 01:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hsp1dxuGXY4hmqW22LYyxeXR/pGoJbe5aDCRmaZf6tb0brWOm/H77qc3llIUyCQCp7CtV0BrZVlmv1gx9ZJ5jjPvFN3yu3IMCFkFeI0ByrXXNzWAGIHorEf0CAT8e7YN2J8gJ7w3jjcIRkfFaikgcQ5LV2n2vbha9M/J2cLQdI2stKNejfv6vD54YiqboEmkSW/k05YEn28YTElSdCsXhrBD++Gbdq3ZDd2QkYqA6y7ZJjjteeAxtuOOv9+wRDyc87J/69PqKDxu7y42YlN4LoznsAX7eexpVwEBPcnxjNU8FxO57aq8v8tHd6cPHb6MZYbOmBzS/5+0xy+uCweHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haEEytFu8sZhoF6UKlvljHRlzxT7FjrdqwjELH52dPE=;
 b=e11P+nDwAY1aTIxaVGo95DHuhtKNyhKOYimJ2qtat8z9Y6Y7lTDLol9QcUdpy8RMCXNdNX/2OltvsMjrnCTXyHQBEt3LDa67ARNfMOtyTU/g6iLwpbWPecbJJfxV1VWY4Oec3vUAeE6DXMUsWQ4OsBueL3r48z6PMzI0Ge/5celYvO5XjtrXUFproV56PIty66EixNv+QOFA2eZlrbSNi4sCtHK3HwedzMAWKR5vqohtUg4ZOM+zwRPXKagR1J4zfVWBB8PhdYYZ260rpuZm7esD+AG1TH755t3Y0MB/xPvZyHQTKPbz6xs/8RIHf8DuwiLbSltVWxJqlLwzFcycbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6568.namprd11.prod.outlook.com (2603:10b6:806:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 08:09:47 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 08:09:47 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, john.fastabend@gmail.com, mhal@rbox.co,
        daniel@iogearbox.net
Subject: [PATCH 5.15.y] bpf, sockmap: Fix race between element replace and close()
Date: Tue, 25 Mar 2025 16:09:29 +0800
Message-Id: <20250325080929.2209140-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:404:a6::35) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d1c759-f87a-42c4-b367-08dd6b746861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wu1vO2f80ArFSsUCdnVZ4ZaTFWM4Cc0wBCMezYmzAy6Qrt8zoa9sExNWzuXb?=
 =?us-ascii?Q?J5syo2L34llhakyyWz8WNuI0Nu2mywFdsnzhRupwIgjtOIylGUeMi2WKv1Cq?=
 =?us-ascii?Q?hoDafg2JquzWGttmUeKLKqxyhSGgpK8fkbrJ99GJkeZm8jO7QHJm2o0wYt+6?=
 =?us-ascii?Q?TbXB0YhzzorCX7flv7mwd7F+61SpbF4EyU6AtvxkE9E9rPXXcnggumELnThj?=
 =?us-ascii?Q?pxIG8OfUACgxb9M5ICV9n+Xt5NNdvO6GzkxHXcasbtYUGAOuGuH0kTHZDhYz?=
 =?us-ascii?Q?OyKBmfXiVBgfPpBtcxjSI8IDRId/RHUVcZYD8HEkQr4u15oUeAFSqv7xAkvi?=
 =?us-ascii?Q?9372b/1Nj0BS3P7/iN5l+hZmVezUIywGflBLzlouFEhPmj89XCm4lHhdryHF?=
 =?us-ascii?Q?7luy4sp39YmqOGa8ODm8dM92c/OwqKzuOV96S+fWTPz4m6UrJeFuJ84zzl19?=
 =?us-ascii?Q?GwDp6+F5e/chkwpAj1Mc2RWzC41mz3vxulP6+zNb4url0ws+VAmj7pH1s+9u?=
 =?us-ascii?Q?SwJCcg5oOPqA/vrZpaTs+8sFBalU75usvxRQCUV82NzufiCTVSD1szcqMsjl?=
 =?us-ascii?Q?6MJnMAG/UGu0t3/R0r8twcCyKHAdmOjqdmPvrEndTfrgrN1W+ls3HQ8UHAzM?=
 =?us-ascii?Q?4THSoXfd+QGaev/bYHRRzFkaD/IWCaTIoa9KvgscsXVH35gQqwuja6ViKMS3?=
 =?us-ascii?Q?z+/u94ypzwp6VUaonaX2HblU5bV3dlRLE6FE36IIOTfUI7rssXbyu2xlppi1?=
 =?us-ascii?Q?Nb9O8ySpyRbIir+gBsF8quInRviOGixlhbKVQD1w/PrgUf8DwV/By42Cb7mq?=
 =?us-ascii?Q?l3mcVhqdIdqpKng17/WNEoKOQvDzMKxP+polaixKkM0ArfijEeI6r5+Uda1k?=
 =?us-ascii?Q?HbZ3pSUpTUgQz6GAAZ9h6KnNCyogGGZAMJM4gnWW5Nz3qIb7/IGuThslEsJS?=
 =?us-ascii?Q?ceM/lw/RzLkTu0hUzlKjlaij+/8GGsIXMwi4+LW1iX7enBIKCxu+ocfjEZvH?=
 =?us-ascii?Q?b+5llIsRS3GtYd1m3A9UNVidD67u/+yTMeuVL/MxvucPhcYSsauOtP1AVvJm?=
 =?us-ascii?Q?kSIWc//dvvAcOxXa/fgdw/XXLyvIDXLyZ2f+VJ0EjVyn1uEjveDG8weLWZTW?=
 =?us-ascii?Q?Zhpxbv+DKWEbZdcLNtN2cL4L5CYgKsP9pDaOxOXMN4mTHZL4Bi02/Rw7p8kr?=
 =?us-ascii?Q?gqYM2o7ztoUUQjUe5I9WeVn+UDqYf5zk6HpAGhkgfRZeWnPCBG4jucCMSfLR?=
 =?us-ascii?Q?W7NYad0Xa0lEpMfBfNwc+tAsPCO+w2JTDETgcyPuMKNzDCqzkxh28itk2cd8?=
 =?us-ascii?Q?TmdKb/qWNmymxt+X/BjfZKctG9f6Sl0tSkxS0viS2yTVE3d1os3KnjZ/mhGA?=
 =?us-ascii?Q?Nit3v9WiMYUK8wTRc9VtS5VGkKNqFmpPodAsJuXoDxGOu8vMUAm8v3PswJ9h?=
 =?us-ascii?Q?8mzvSErK2Znn/B2edm2Hx+8Ioh1N2Eid?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZdr00BB2gJ32GpvWqfpXb8x9kD9gD+hCo43KVyaf1MAaTKgSta637Rh9sAB?=
 =?us-ascii?Q?8xPo9D+JxOlQyzMfRntsXSsrYeFsPnaBLhqqeu/Mal6A7zxj2MZAc9lKS2xb?=
 =?us-ascii?Q?DKt+MGtPXvd543azp9ClbbHhR62L3TvXUXG/dlAhXaK7o7YUbtgupVY7QGXx?=
 =?us-ascii?Q?uELS/rYHV97Ns2Rt/CIRsxvOmY7Yndo/chcSSl7yc/UTfeEvRSzBEFFmaNhq?=
 =?us-ascii?Q?2O41v/pcKP3DHnkr/2VOagrC3m2y3jn7m70ryyNt9Ul+zh7cW2xSRDsbB0xB?=
 =?us-ascii?Q?m31DedjcWBlQ2GGapwmbXNiXiA2b5a1uhRAlAfeJLKhXNvdpq0tVjq7bVTvn?=
 =?us-ascii?Q?GxGWL5FzYQwRIZQMl96O47Whhqj3VNZr3btdovgqi/069cb+h48iiNP92hB5?=
 =?us-ascii?Q?VPXkiFHTP/QaiXqzySW7vjMQhnL3t0gmcpyI3FQuC1r+iepZBQxQnK1fh95a?=
 =?us-ascii?Q?rlHNAT6s3rljZA2iPuP7Sc7ik3eovm4mWdOV4OqJo67yqxEO88OG4eY7EEuj?=
 =?us-ascii?Q?xhJ5QJno377KhzPRLudJGGsTYPzCXhD+KfRLK6JPwaBVoudEW5CbeLUnzO1b?=
 =?us-ascii?Q?tJRUCN8k17MmM/j9kcmwLl5PztD4bNVK01XIkZ85aDs8SBCXECM+TUXpVvkX?=
 =?us-ascii?Q?+ldem0ykMPzbqfXFmL75N9suayaE5AYwdW3NFm3mnDEAyFe3KhoQkxKBshU3?=
 =?us-ascii?Q?3sflb3EfnrxYtNRmZD+hLS4ZZpXg15xgBesRSipU2r7tPJ0poFzzzQak6da/?=
 =?us-ascii?Q?r7AuCuEQY8GNFNM/JZ66mdttrZIox7wy4732tpzyvk4kmIsK+LGypgYSJZX1?=
 =?us-ascii?Q?YWjkC69E7A7U1tBLRrKE+mUA5VOcCxTk4puXWN/h2mjtgz3owH29oBE7SLd9?=
 =?us-ascii?Q?BSWrSHFbap0SHp6hrJxg9/P4pQACAPraeZquKOaNkqIMfMY9LpI5XRKwA2Ck?=
 =?us-ascii?Q?fGo/V6t/g3oa2fKqY5XBHqVX6CkPCS476Jk7YqqsAqnWJemc/zqtA1SoHkN7?=
 =?us-ascii?Q?jnMHDqFlPCHXmh9nCEE7FwqQCowm/Fi1b977G7oyo4RAmfxQDCdhSSXzYqWs?=
 =?us-ascii?Q?XwBkVY+AR+ZLda+MmHtfbguKXu5oz1REzayWcNqtrslP+RDOa5lFDzyvWjFr?=
 =?us-ascii?Q?SmTF7a/KQbBtLcSddpTXN9X0gRlmPLL1TasF7cVOKxgXmwhxcyGXXMyLrcsO?=
 =?us-ascii?Q?TeIeXqCpWA0YX9FFcV5dmqIGFI2QOQ4S4KgXRHCfsuFKYq+N4UlTXaCoicK3?=
 =?us-ascii?Q?cVxFAAp43hKkTsWO2XI/CnMZSUeGTC2apP+uNdo7pb9aS+6U11BdvdBzL+87?=
 =?us-ascii?Q?W/WimBQonJkcD5CKf1gQP6D6Bqjf/JeYRjwIKs+1MVYYyUI1EQCux7woHGtL?=
 =?us-ascii?Q?AO/txGQKvKhQl5DYuVmg4ztisQP6604KD2QMClOUtFfFjMJbWgdeQJ4/tGf8?=
 =?us-ascii?Q?ULk6Lol59A7gq+IVpvRn1Ggaih4avyovLQPk7E3khuTfRheNe47hPofR43LZ?=
 =?us-ascii?Q?Zs7WSzTOpW9GJ3T1SLhG1XXU+JKmWNRXQ8H0ma5hYaGDRZGDm4IrRo8sK2wK?=
 =?us-ascii?Q?qI6y1IHPOfZaWNG9BR6SohzV0GcSFf/Egavzr+pVwCyJCYeG1IhdiS7Uy93R?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d1c759-f87a-42c4-b367-08dd6b746861
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 08:09:47.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNfGcgLlyfal14RfTevbTpWQdYr807rR4BbTq+3X1EYpDuUrjZYQZ6MZPzrzyRgBgpZEeUIEOPVaQZIPu7/MjpFtniZoMAIm88kDxZ/gU5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6568
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e264ce cx=c_pps a=2TzYObwzRp/N0knVItohZg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=jWF0KBuXk48DT8NqCIAA:9 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: E5J3OwAmiM6Vb0ByS2ujcXAfp2kG5qfu
X-Proofpoint-ORIG-GUID: E5J3OwAmiM6Vb0ByS2ujcXAfp2kG5qfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=600 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503250056

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit ed1fc5d76b81a4d681211333c026202cad4d5649 ]

Element replace (with a socket different from the one stored) may race
with socket's close() link popping & unlinking. __sock_map_delete()
unconditionally unrefs the (wrong) element:

// set map[0] = s0
map_update_elem(map, 0, s0)

// drop fd of s0
close(s0)
  sock_map_close()
    lock_sock(sk)               (s0!)
    sock_map_remove_links(sk)
      link = sk_psock_link_pop()
      sock_map_unlink(sk, link)
        sock_map_delete_from_link
                                        // replace map[0] with s1
                                        map_update_elem(map, 0, s1)
                                          sock_map_update_elem
                                (s1!)       lock_sock(sk)
                                            sock_map_update_common
                                              psock = sk_psock(sk)
                                              spin_lock(&stab->lock)
                                              osk = stab->sks[idx]
                                              sock_map_add_link(..., &stab->sks[idx])
                                              sock_map_unref(osk, &stab->sks[idx])
                                                psock = sk_psock(osk)
                                                sk_psock_put(sk, psock)
                                                  if (refcount_dec_and_test(&psock))
                                                    sk_psock_drop(sk, psock)
                                              spin_unlock(&stab->lock)
                                            unlock_sock(sk)
          __sock_map_delete
            spin_lock(&stab->lock)
            sk = *psk                        // s1 replaced s0; sk == s1
            if (!sk_test || sk_test == sk)   // sk_test (s0) != sk (s1); no branch
              sk = xchg(psk, NULL)
            if (sk)
              sock_map_unref(sk, psk)        // unref s1; sks[idx] will dangle
                psock = sk_psock(sk)
                sk_psock_put(sk, psock)
                  if (refcount_dec_and_test())
                    sk_psock_drop(sk, psock)
            spin_unlock(&stab->lock)
    release_sock(sk)

Then close(map) enqueues bpf_map_free_deferred, which finally calls
sock_map_free(). This results in some refcount_t warnings along with
a KASAN splat [1].

Fix __sock_map_delete(), do not allow sock_map_unref() on elements that
may have been replaced.

[1]:
BUG: KASAN: slab-use-after-free in sock_map_free+0x10e/0x330
Write of size 4 at addr ffff88811f5b9100 by task kworker/u64:12/1063

CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Not tainted 6.12.0+ #125
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 dump_stack_lvl+0x68/0x90
 print_report+0x174/0x4f6
 kasan_report+0xb9/0x190
 kasan_check_range+0x10f/0x1e0
 sock_map_free+0x10e/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1202:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 __kasan_slab_alloc+0x85/0x90
 kmem_cache_alloc_noprof+0x131/0x450
 sk_prot_alloc+0x5b/0x220
 sk_alloc+0x2c/0x870
 unix_create1+0x88/0x8a0
 unix_create+0xc5/0x180
 __sock_create+0x241/0x650
 __sys_socketpair+0x1ce/0x420
 __x64_sys_socketpair+0x92/0x100
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 46:
 kasan_save_stack+0x1e/0x40
 kasan_save_track+0x10/0x30
 kasan_save_free_info+0x37/0x60
 __kasan_slab_free+0x4b/0x70
 kmem_cache_free+0x1a1/0x590
 __sk_destruct+0x388/0x5a0
 sk_psock_destroy+0x73e/0xa50
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88811f5b9080
 which belongs to the cache UNIX-STREAM of size 1984
The buggy address is located 128 bytes inside of
 freed 1984-byte region [ffff88811f5b9080, ffff88811f5b9840)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11f5b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888127d49401
flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
page_type: f5(slab)
raw: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000040 ffff8881042e4500 dead000000000122 0000000000000000
head: 0000000000000000 00000000800f000f 00000001f5000000 ffff888127d49401
head: 0017ffffc0000003 ffffea00047d6e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88811f5b9000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811f5b9080: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88811f5b9180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811f5b9200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
Disabling lock debugging due to kernel taint

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:25 refcount_warn_saturate+0xce/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B              6.12.0+ #125
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xce/0x150
Code: 34 73 eb 03 01 e8 82 53 ad fe 0f 0b eb b1 80 3d 27 73 eb 03 00 75 a8 48 c7 c7 80 bd 95 84 c6 05 17 73 eb 03 01 e8 62 53 ad fe <0f> 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xce/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xce/0x150
 sock_map_free+0x2e5/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

refcount_t: underflow; use-after-free.
WARNING: CPU: 14 PID: 1063 at lib/refcount.c:28 refcount_warn_saturate+0xee/0x150
CPU: 14 UID: 0 PID: 1063 Comm: kworker/u64:12 Tainted: G    B   W          6.12.0+ #125
Tainted: [B]=BAD_PAGE, [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
Workqueue: events_unbound bpf_map_free_deferred
RIP: 0010:refcount_warn_saturate+0xee/0x150
Code: 17 73 eb 03 01 e8 62 53 ad fe 0f 0b eb 91 80 3d 06 73 eb 03 00 75 88 48 c7 c7 e0 bd 95 84 c6 05 f6 72 eb 03 01 e8 42 53 ad fe <0f> 0b e9 6e ff ff ff 80 3d e6 72 eb 03 00 0f 85 61 ff ff ff 48 c7
RSP: 0018:ffff88815c49fc70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811f5b9100 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed10bcde6349
R10: ffff8885e6f31a4b R11: 0000000000000000 R12: ffff88813be0b000
R13: ffff88811f5b9100 R14: ffff88811f5b9080 R15: ffff88813be0b024
FS:  0000000000000000(0000) GS:ffff8885e6f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dda99b0250 CR3: 000000015dbac000 CR4: 0000000000752ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1ff
 ? refcount_warn_saturate+0xee/0x150
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? refcount_warn_saturate+0xee/0x150
 sock_map_free+0x2d3/0x330
 bpf_map_free_deferred+0x173/0x320
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x29e/0x360
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 10741
hardirqs last  enabled at (10741): [<ffffffff84400ec6>] asm_sysvec_apic_timer_interrupt+0x16/0x20
hardirqs last disabled at (10740): [<ffffffff811e532d>] handle_softirqs+0x60d/0x770
softirqs last  enabled at (10506): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210
softirqs last disabled at (10301): [<ffffffff811e55a9>] __irq_exit_rcu+0x109/0x210

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20241202-sockmap-replace-v1-3-1e88579e7bd5@rbox.co
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 net/core/sock_map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f591ec106cd6..487a571c28c1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -411,15 +411,14 @@ static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
 static int __sock_map_delete(struct bpf_stab *stab, struct sock *sk_test,
 			     struct sock **psk)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	int err = 0;
 
 	if (irqs_disabled())
 		return -EOPNOTSUPP; /* locks here are hardirq-unsafe */
 
 	raw_spin_lock_bh(&stab->lock);
-	sk = *psk;
-	if (!sk_test || sk_test == sk)
+	if (!sk_test || sk_test == *psk)
 		sk = xchg(psk, NULL);
 
 	if (likely(sk))
-- 
2.34.1



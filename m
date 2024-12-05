Return-Path: <stable+bounces-98707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3B9E4C3B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 03:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9873B18802E4
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 02:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017D16C687;
	Thu,  5 Dec 2024 02:26:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480AB22EE5
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733365615; cv=fail; b=eqyvPieyNTjQPopzvGwi3Mx6uWU9al3GtllstjIvtOdYwD9bwNeQXHLSm7jtbAoEE22Zj8KvieFCCV8Toi9B1F4Hm3CpbebqggMGgu8s/ul3ep176Ps0O24kpZaCatdgyQEhKkiw0vZx9r7E4lSWMuNcF5jYgN5ExqtiI/eDdKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733365615; c=relaxed/simple;
	bh=48C9Q+isHjCV3qdrFAQxFTVHasrK/98Hbm7QRU7Eei4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TXE1gdxnA4A97bCRm/jcJ7BYibfhQegzEvPvKLYhkmaoLYKDSxaohZnwyWNrFYbgF4FpkSiKr3MalKvEjkMWp4S9JGqZ1FcezjNQiwubaHMQ9SIlZoR8BtSPNAxLNQX8CxAaAqx034nknIPMEptn6dJJ8kEA/E6mE+JdR/QYGdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B52MvXq027367;
	Wed, 4 Dec 2024 18:26:50 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43833q5715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 18:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv/KrLih7OGYlTOMfZSgJXPdUg98BM8eK8N3IAmeEA4gYPsYjaLJoE6D4NTxomFgXBFQaLIr+qh90CNoryU6HlWGg5icZ4Qt1+O9HWsYmRC8+KLyIoR9ik5DepDjPTyEY3b6VG/VybVbdsi8c3RRUxFoEDNxKfnl41RlqJtGWB4ctRkZwxdYW7aReZLRLr+xRmBmDC2ItzDdJKLwurc6CLvXJhyV+gl9C2eRLVe3fSlOaplO5+4TsQaP9YeS83XXC11hZKVWnTMdQH8s6lV79bjXFC4wZIQgHzhBUKXE7n0rxXz8W1nBuwicYNVEG5stqJ0iCLcqbe4pMlL1F/HDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuKYtsI6MYQvvZMyEOUinaJX3rHa9RxJCCa0zb3sN/U=;
 b=pwJd2KZ52b/2f4xIOcKN53XG07yGRIipERNBvqIfUmvFaCCNrtqe4AUGwQ/y2ivnRNx5O1TSFfstJXAFIk3FHFyWIVmIcXUV/Dug1b3ICSJCtjddfoETErSx6UDBJ8+bVtX9+oUpvSaxsr+ZaaS88IMs+qIA7R3G8lrFmsruZgIHLNTMJ+I4CNsm7jGJDnxzx6oiQY6D4/acqeyWTFNc0N4IDGq9Ls3Gh+DwOtlYVUtjcGwecGej6XaFNWwF6KOFawUQljoBXDDJ0dJqe0/fpo6TM695VnLlIJ+eqdhGfyPHx3KEvlAHRCKitUwLKk+HcNhcF+6qdd5IOQSmkCOlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Thu, 5 Dec
 2024 02:26:46 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 02:26:46 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, jarkko@kernel.org
Subject: [PATCH 6.6] tpm: Lock TPM chip in tpm_pm_suspend() first
Date: Thu,  5 Dec 2024 10:26:44 +0800
Message-ID: <20241205022644.164941-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::8) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 320e8089-3163-46e9-bd26-08dd14d443ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cgPoiheYTe0KBMRe2elUz6Ljhk5+hy8VdiHGGOg41/eenWXKIBinxRGVqL/?=
 =?us-ascii?Q?WYinQHaJHeOh/ssM6UvpYGoculerMiTtDyvIGu7LhAcFZoOWli+HJd/oTLc1?=
 =?us-ascii?Q?u+b2HGaIHBOKzr7u/toJrAGdN5Js/TXGakNnvJ/AqXBa3Eu0FCQttCbhuaFw?=
 =?us-ascii?Q?Qk2zYAd+ztaYM49wA5HDiV2kVxypcPdFLhAZGlSXcnYDc33UvruJPkRZrDf+?=
 =?us-ascii?Q?8iOaOABONQe/3TmAm+Nlwr+yZiONdYORR+ckMrOrVmYddlkRov2bckekgFT7?=
 =?us-ascii?Q?d2ycpcMmBvIxFXL3s2KvHttSrRHjVV8tNRngK+pXbJY5VR33efno/depK81R?=
 =?us-ascii?Q?XzA+XzOokniANUPH5d3RLnYXiu8yv4S4apkv3yv+3Q5t5NIDdtP/G7NnrAmQ?=
 =?us-ascii?Q?GDlEYh8hrU48COvda2W37/Xbggm+3wSZr8VCtseaTp1KI4ButWktWaR4j6IR?=
 =?us-ascii?Q?8WnPruVzU1R8CQohKv6AG8vP7WJgchTo7/M6Y4AaytTBkmw+hoQzuUyzrnmb?=
 =?us-ascii?Q?LdgZunBT6CTF9EybW62VWnm+GbYPSCnHb9qaqH8T9QnmijeBfLz26xa7X7n0?=
 =?us-ascii?Q?Wxkzm7qJztOxeE3RRgQIdp5e4g6rAF6g8b/HGySCu/AkgFKYh98XLM3NGCXX?=
 =?us-ascii?Q?NSnN1tqqot+m3uesmi9vlBrLRGMvS+/69NllRhyrzEpdll+qGuonF6dabwC5?=
 =?us-ascii?Q?CIf2+ZDUHqGxrLc9mONP5WkH1RXPBkvsLOKSoilM1ZonVke/QtKE6AGWNyla?=
 =?us-ascii?Q?/ZTflLPkjv/dCWks9K6JjGslfffLYz0f/wAJF8KhW+J6JHi2GEv0V6NYJvEe?=
 =?us-ascii?Q?tIyX5uedbB9nrmH65lAq6i34QQdZrH4W/ewCUQq2+5KPHlhyBUuSrfQLnskk?=
 =?us-ascii?Q?HNgR44MS0/dnjHWAL6DSUyE+Ty8vwRlnqr2vXzLUfI1QMcJPh1v8Xecx21eY?=
 =?us-ascii?Q?4RxFS9NyBB8cujIOKrdgaNZBQFevx7CyHq+xbuOSxTTE2bYY7wCoGEEgoV7s?=
 =?us-ascii?Q?IYjWHk5rnygvsf+ruEgeb+eL7Cqn6MlrDl2nrJ2xOkRuoNTgyirCxbaf8vMY?=
 =?us-ascii?Q?zJcq8uGS/cFlhEueAf18ONYxbYDTXwZ1+fLz/dzcZ1aZD8yCjn3nRv7P6CPj?=
 =?us-ascii?Q?TDKKFhMXOvQlyQuXlXWQWdoQX5syn+GeY3XHwtCz7xSctMNmJ6T81tQl6fZJ?=
 =?us-ascii?Q?1HKcITDas4Mgt4SMbKz9/0XrzbrMPki/kVAUe+5IH0ipiKS1BR1r+b8uzU+w?=
 =?us-ascii?Q?KNeY2EfyiLV6TWoiVxUdXbYYYzDLsQ5AENv4k/uX4587beSxwm1mKAuy00gA?=
 =?us-ascii?Q?6eySeMaRGpevgLv6OQBQQ3MO0cm2PVKQ8X+R+jhH9OKKcMRp+oEQMv6DSM2Q?=
 =?us-ascii?Q?xnMHkpgt1P57EsxVEIGUMUzFqOrorWEf2RGt1s4z3GTQ5p24bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mgjhU53A111wBqRScl+ZZhmWLzM8eJtXuLLGDkTuYcLAGHzR7u6shYGrg/nM?=
 =?us-ascii?Q?xJpgJl5orG++a6V00ZA+3pXzuDhRM/2YdH0MlfKQ1RBaveQUyKWyemwphrHx?=
 =?us-ascii?Q?RKoq6yEGYL665Zbe67nV2hr85iDUfqrtQBE+HrIgWqHClDC9VjAVfN/u06ru?=
 =?us-ascii?Q?OhHimJb4Gt/mkTiI+lcmkU7KVq/I1sgwiE3rK1nmg9KikGd4tOtkQyJ1kyRM?=
 =?us-ascii?Q?N3i+Xxshb3SqyPfS2Y17imWZ2VGYegVV0Eru5AiHNMiFQDcMGwVeHQeY5vue?=
 =?us-ascii?Q?DiZ3/DFOsR2VR7+8yAup91gjfK/KRRPrfNQJff+NgGOEexuiV8tvTengLXaz?=
 =?us-ascii?Q?km4FPTu0iU2t9KvkONrAHXfwswkuI8+kcNaYJZpmcaVu4nSLmR2QiKvdZZ8q?=
 =?us-ascii?Q?ErRkfXWMOCbprjxVanq1zvbigUgPwnTrt5MEYOKII/eQ3X0K7Rr905BDhje3?=
 =?us-ascii?Q?0SwZeapFI245b526H9obn/xqrVBadYzbS5XF/UmNiL7C4yPXXPkMDmqFFoAG?=
 =?us-ascii?Q?SS+lJPOtHJihJINwqnLMLoUNytSvrGN2BlVxC3ZHzfmtWPdrKKBrjbKdBXjW?=
 =?us-ascii?Q?dAFMLffmpM5KmP2kPcNeZT1ObfjEOnaDex5zcDshAm5IZw+7AEfoydWhcwCO?=
 =?us-ascii?Q?50Jlmju/PHU3gfgV6TRd6bURx3TOKqERFiEHv/ArE+uEMyt5wtIFgh6hq6di?=
 =?us-ascii?Q?qFqIHXyNRgYu3VeIPkStsAQ1pQlCeGVhcf8rQFZJXeA54MSrHTMveP0fxvE1?=
 =?us-ascii?Q?25i9jiSmM2kI5VSO/dbMaVb/1i5u6C5VMwletF+2h9OTVcoTWz9mmEMRWbee?=
 =?us-ascii?Q?F6BC+ygGXAdIg5yHdnQT8zQj4wRUeQZfQMZlr7M2zt3gdLvZoRjBUlFK6vjb?=
 =?us-ascii?Q?enDDm4skwdQHNcENHg9GA47CzntPX2nIlSRuCgEWmwqFlcaNR47qVofRPeGf?=
 =?us-ascii?Q?k6YDZ6bU/DgurQ+3fvO6b9jnhfz+dWcTU5sGZHREPsmZZTiM0McHtcL6HC1B?=
 =?us-ascii?Q?gkk7+smzbKQt1f/H8NZLQ7jSCTDU677mc3z7DspvzjdVsncrH3AB8mWsHH3l?=
 =?us-ascii?Q?zuSscBWlOxVepaPd3u4xNXdgrLQKTJEZM8ZybvwgWYl3ZOVmWVyjvojgdrqX?=
 =?us-ascii?Q?6fsjCXoLqK/DYjskDi33Di+6kLlu8Oi0J/iRzzBVMbL2cSYsBdsEU8pWNox7?=
 =?us-ascii?Q?O9dX9e+yxkOTrkrlRk6BPKzYWKIkoD0397M3LbUM82P/FBagyKuwzdxWY5W6?=
 =?us-ascii?Q?LKv5oTeJLahoiY+0GA8hQt8xGLmqJBYB/n4qg5CHKNmvG4AI4S9j+puQSHIf?=
 =?us-ascii?Q?WOlPsZVt9vpcAhPKMFPEqDXCWffGgNw0eNNiwvpcmbvNP8qJyqsj1VzzH2W1?=
 =?us-ascii?Q?Znp2rLoXLXzG248CTpvJb8DH/EoN5E8XN2idmmiZ+wowd7LAcaPpTu1irrL0?=
 =?us-ascii?Q?DMXNNdJ2l0X+eFdB06z2BJvp8bdUgNwO7PeVZsthmhU3U7r1YQQsM1O6/NLP?=
 =?us-ascii?Q?gG6m7g1o3WM1F6i/dX/jGjqxs9ROSnewYdJNlInXNPJAwj67pbKJUA9fDJT2?=
 =?us-ascii?Q?fNfmelniFNeIuAVt0pSoECmH4Zb9ReD9NySWfl+AoJs+oKoUGzFsjzlv1w6H?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320e8089-3163-46e9-bd26-08dd14d443ae
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 02:26:46.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38R693EQNyHQcifKQAtAnuzwEpSekqLl7/ae8OfoexTtXMZxkDEMGT5nXquVg6OTcKqn+oGdWvei2A+E9d8k6Qs5yCyF5wMe4ZGa34tNb1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-Proofpoint-ORIG-GUID: DZ-_IpXUOYOZ_fUDvdQKpmULCbdQAqWQ
X-Authority-Analysis: v=2.4 cv=bqq2BFai c=1 sm=1 tr=0 ts=67510f6a cx=c_pps a=+tN8zt48bv3aY6W8EltW8A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=HnrRUrCFPnVDIgNgg8AA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: DZ-_IpXUOYOZ_fUDvdQKpmULCbdQAqWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_21,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0
 clxscore=1011 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2412050019

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit 9265fed6db601ee2ec47577815387458ef4f047a ]

Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
according, as this leaves window for tpm_hwrng_read() to be called while
the operation is in progress. The recent bug report gives also evidence of
this behaviour.

Aadress this by locking the TPM chip before checking any chip->flags both
in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
check inside tpm_get_random() so that it will be always checked only when
the lock is reserved.

Cc: stable@vger.kernel.org # v6.4+
Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Mike Seo <mikeseohyungjin@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ Don't call tpm2_end_auth_session() for this function does not exist
  in 6.6.y.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 drivers/char/tpm/tpm-chip.c      |  4 ----
 drivers/char/tpm/tpm-interface.c | 29 +++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..78999f7f248c 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -519,10 +519,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
 
-	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
-	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
-		return 0;
-
 	return tpm_get_random(chip, data, max);
 }
 
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..c8ea52dfa556 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -394,6 +394,13 @@ int tpm_pm_suspend(struct device *dev)
 	if (!chip)
 		return -ENODEV;
 
+	rc = tpm_try_get_ops(chip);
+	if (rc) {
+		/* Can be safely set out of locks, as no action cannot race: */
+		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
 		goto suspended;
 
@@ -401,19 +408,18 @@ int tpm_pm_suspend(struct device *dev)
 	    !pm_suspend_via_firmware())
 		goto suspended;
 
-	rc = tpm_try_get_ops(chip);
-	if (!rc) {
-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
-			tpm2_shutdown(chip, TPM2_SU_STATE);
-		else
-			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
-
-		tpm_put_ops(chip);
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		tpm2_shutdown(chip, TPM2_SU_STATE);
+		goto suspended;
 	}
 
+	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
+
 suspended:
 	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
+	tpm_put_ops(chip);
 
+out:
 	if (rc)
 		dev_err(dev, "Ignoring error %d while suspending\n", rc);
 	return 0;
@@ -462,11 +468,18 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 	if (!chip)
 		return -ENODEV;
 
+	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
+	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
+		rc = 0;
+		goto out;
+	}
+
 	if (chip->flags & TPM_CHIP_FLAG_TPM2)
 		rc = tpm2_get_random(chip, out, max);
 	else
 		rc = tpm1_get_random(chip, out, max);
 
+out:
 	tpm_put_ops(chip);
 	return rc;
 }
-- 
2.43.0



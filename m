Return-Path: <stable+bounces-197551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42997C90C81
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 04:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D013A7E05
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 03:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668AE2D63E2;
	Fri, 28 Nov 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="d1V5jVur"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75E9288C81;
	Fri, 28 Nov 2025 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300963; cv=fail; b=LIWuFbX/HJDmAKn+pYhglAX3XkX+wg6ZudEbcw7sq7ECnEoy5838iEG0FslWBvu9/Iv0BElNSPYcHHl2246n533LzXnztFxq52ALFKxJh5Fv50E5t4w9tj+4ys4yr4DvVreXoBd+TfHNxUjXgHibZRWzj8tjFt0R+deCEEZuR+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300963; c=relaxed/simple;
	bh=jB0U2gulf4sAtjFakoCLX+Se3u+OoKaNSyw4mZ0L1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a1jsrVGFqRx5VPJYZplWMT9j257IQwJlZb9aoWW2PrUuLEMMKTUrNdn8Wr8/KL9qKqMMhv9Y4/J84bpqGQ3o5sCttspla1XsCN2HPNGf44H4JoAJEzn7dCh6Kkr9cy4Icuq1+/qwB2qBmnmOmrmejMQmDLcABZOFnu/gKxP2InY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=d1V5jVur; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS04eXe4144873;
	Fri, 28 Nov 2025 03:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=wiq8OL2Mu
	JPbR3z5xc8KdDK8MoPfVbmf9q0xlH2bMME=; b=d1V5jVur1+Q9Gf82bayeioVYH
	gG0mA/fLODbxCSUhfZQNYO2/EtgDC4Cl7j8o9gwAzRaAesRSF2jJvP7KpyvxZkcy
	uTEDgm7T6w44m1M2rWYzqJQf7UuJ2xMlXeqPI485vPEXjoVjolzv3gHPYoIYD43w
	nBpTv4NCC855ujpDwKbSvx2ZzKVvhe+wZxQhcVsfF/Mz28d7fKtwAq0W2q6OnYSg
	l3bYSkWckJW/R34mamTnfjSJFeTdH8ZRJ9Vp34/izzZ3j+L03sgl7lxx2ollPKnL
	Dzm1SgKsQ0vNAvTc29bvyE21VH27wZaZYVrMCYfRFRrd8shmQTuAHqFstM0xA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak2d0xj85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 03:35:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSTD5lIP8l+fQNITuVkcc0dEf2RNbaH2+OBEySJmdvZCFb6/WLAAyDLp2gGgHn92BJ6TUHeavviFiy93yMJrqs3z90Po7WGC8YvrMbYUNBVnBhVjTXiwbjuD+y9FGiPl6hRiRQdRKhalwrxIJrLYiK3EHIMOa0bHFOIUmCk52aZhXlbgVeBkiN4KNxt2tLedC3S66wCNHlSc4qxIVVCk/GXEFDS0VoR1sHxBvE4JA8RlgQl5afjYvPBV2LD95KdPL4o+TSmB7gaecby5tsB2ehwmGRHXK6kyqI4pkYdiEp/6FidBmRRJztArDRXAicU8lH1QwUkjSsC99Dzynm+cVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiq8OL2MuJPbR3z5xc8KdDK8MoPfVbmf9q0xlH2bMME=;
 b=FVeY1p+QbjT1bCLwm+VscBPH6lS6jBqfXNaTF49MVvs+JqhL1ZPhyQaivVIOaBl8Ee4ibuv84EcTcJ4812eIhfC8J5BMFn9vFqRc5RvUryem3mt02wOEf3hNcCbjM+45/yL4PW+UzCFFCrMiEjXX7FoKBG6s4F6W8iFEBaBtLWz9SxVz3jgeVxUY1qQSOnPxNxgyXlxELhuRXYVXIONXX6Gb31v5sgJQgdVPCoIhcF7EV6jAyQqu1rA+ysIalEoxXsVptZbM52CSg6j1aDEeoGh/n5hCwteUWgYWyx2rynqPvcjMg0ViJAlDS8M7c2ESTDr/vv6sI2DYoDMpDazwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 03:35:42 +0000
Received: from PH0PR11MB5061.namprd11.prod.outlook.com
 ([fe80::2e23:904:be29:f4e9]) by PH0PR11MB5061.namprd11.prod.outlook.com
 ([fe80::2e23:904:be29:f4e9%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:35:42 +0000
From: yongxin.liu@windriver.com
To: platform-driver-x86@vger.kernel.org, david.e.box@linux.intel.com,
        ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, andrew@lunn.ch, kuba@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3] platform/x86: intel_pmc_ipc: fix ACPI buffer memory leak
Date: Fri, 28 Nov 2025 11:32:55 +0800
Message-ID: <20251128033254.3247322-2-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5061:EE_|PH7PR11MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a29ec29-902a-40fd-c742-08de2e2f3529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KDukw3wcmCCsofPJxUxYVAPH8y0Cihr5urUGT31Vi3FM9nUUE4nRfVQ3wHGm?=
 =?us-ascii?Q?AdDak3vp+PU9jDPbYhffgDXQmX/R949z/TvHnOqbzN3yN0oIfanvNJkdOQfY?=
 =?us-ascii?Q?IsoDU2gC+pVE9sJ9GOO/GvD2HNKvwlOCPKtuBI6fcFGB2eqxrlE9DwPocbnH?=
 =?us-ascii?Q?lSvyzyJAzZ0fyk0VCkXKIXEAIp6fNTwhvmzbOle+/rLRnsSYFxBMr03gKfxD?=
 =?us-ascii?Q?Y+UAx1pgSK5LliAKpCFdtF7atzZR8E8Oo3qarx0ONq57Ricm4a0nHbaFDYuQ?=
 =?us-ascii?Q?hltiRsTbL6AncyC4nptdzGcxOTdic21Tkh+Ds35Xw/aa8WfvCijzILdU/obK?=
 =?us-ascii?Q?/LA/QER66UIPA6sHZg3qN59tyCGqNIQYhIEHYXTKtqZi46LKeOUSUA/Q8c/d?=
 =?us-ascii?Q?yTHiaMcyMNph2bOIsiqoLqFZ8zwBfUlWxjHRNKuIxInvN76SwVJkW8A/fnV3?=
 =?us-ascii?Q?YT+ltGKsmUfAYm5+86B0eY4IVYBoBR4DQKCm541p9pDCC5hpBUMGNL0hE0rw?=
 =?us-ascii?Q?4dw5P8pX65skYwqiByF9Xk4Nou/jBuoB0OkJTtyP8IKtnDZnZFIvbPqyZRy4?=
 =?us-ascii?Q?YLcs6nLnVbOOnQLRnaa0llLw68/1HUxBWGae5JXvR0BvdEJuqdkAPBmHUSpN?=
 =?us-ascii?Q?3uH8WQ6REm2umABFH1fxLu8uJcDYNanuyKfR8nhgfam9T0AFDHVVzBCdG3Op?=
 =?us-ascii?Q?x9NGCI45r84lRQlb6Ls8T6rwCa3gk6ZTnSjNKdDF9YZjjF/1p/2nI5TeL0Pi?=
 =?us-ascii?Q?4b+qHy3RG4CLmvNZsOdmWi/iLxo98e+abNxaf4KHzj0bgX3dFMx/SSUKSRGQ?=
 =?us-ascii?Q?o5j+XtCVcHJgdMvobtlpEDVB0258phmKSmVN0aG36cYqeBJFGK95sntN7/15?=
 =?us-ascii?Q?tILtCP2we1auxRpb9JrT582BVdNreeZ/mgMgWMe0cLzVPnHSOogLyoRykqX9?=
 =?us-ascii?Q?qduNAfmBQtc5LNTUBYdWownz0r9MybsBjIzXw23e6AQPvzq0acgKZDG1V9K0?=
 =?us-ascii?Q?J+eUM/4+K2zUQi2eiQkvo7COJ+SMrpfw4/2EjuzHpEyA8EM91cjOth85hwe/?=
 =?us-ascii?Q?uxhdVaQWJTfDsjV6ujZKW22DgF94dtSuuGFUodg1TWpJMuApfOPZfdJ6KhXu?=
 =?us-ascii?Q?MQ+ejwKR4egXJ+N40jCZ0zW+pr859e2bccrA90d7l7yEuZG7vDOuPJirFAA+?=
 =?us-ascii?Q?sbpi1rmIJbT74sFASw6z/ffAhCvHsLkdTvFSQ+1TlwlO+jIN7qLgJKbOkCDF?=
 =?us-ascii?Q?+vaNLsVqIB1YnPFNMZDUppQoZiu4D2kBSGWGLsOrdinq4VVYmBH5ir7P1j4q?=
 =?us-ascii?Q?5xmxZocblUvpeS8kJq1QCg4I7sA8wSby3yQF3iTYGvNmM8MgStGvjhflJg0E?=
 =?us-ascii?Q?oLNK0DzQLk26xE6lYZOna2hLEGfMZtnTgiCfJ5KDSiEdRXdAcSXQ7Wdgd0JF?=
 =?us-ascii?Q?u4GRHzuTmTRM2+mPqpiYOwfVzsmbITNRWORSsWED+wcE+cp02kaxgjwfbMEk?=
 =?us-ascii?Q?QxOAJ/eNd5+q3GUV5Y4PfNlnSUk22+1IeZgY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5061.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?diBIEDxzWHWbZ8c6aNOEPrIgUKuDSVUh+bBDaYpj6FPLZGtKtne5L8zE2N36?=
 =?us-ascii?Q?Yd6yhmk0qL6W0mm0O6H7C/lbtaZCax4PM7fO0Qz4mr+ItqFxcpG4LN21O/NY?=
 =?us-ascii?Q?oqXE759aEfnrpcPIRPelfXXmi1NY8AvqdtR+YJV17BpoZe9HhSVmYQtlx8pk?=
 =?us-ascii?Q?p0SZQ0HM48BLTRRkg+GjBYZG3C/zv9j9qYuJ/LImSoVTMmab71U12trD4Qlr?=
 =?us-ascii?Q?GIYcFzHsHzHfPiv3LF9nwnTItv0VuFNTaspUxORdZvQiaAQN27jssIHxcDpb?=
 =?us-ascii?Q?ASBwiCJy03soEoWhnSUm/7A5f48pm7oSay+Me/0bkL/ez10wzmydiAeoUp6m?=
 =?us-ascii?Q?/WeuGXOi+t1r9YQ5ShfKP9x2xraLOgqDqg37+qTkVessrWwdIPTCeL8DAWqF?=
 =?us-ascii?Q?vRchsOzDDHpx+vNQowClnfTp70z+b0dXrUzbPtT8NRPCM2H8GEDkqYxzvBwl?=
 =?us-ascii?Q?+eoQ6bQc44ipLhIyvpbnI807REP1MjwLnfkF8WelZk+ikAHhIaFqmO3QWldQ?=
 =?us-ascii?Q?QG6nmTHkOYqNBCsE/p2mEDwvR3aSb0i2nDDlbPLu/TOJkEn/wDxIYbhcd0Cp?=
 =?us-ascii?Q?b3rHSoZCP3gBl1EFYJHkvH/J/epm3nfpjgUT8DYjfPbz+nJECWxi5dkmzfU3?=
 =?us-ascii?Q?aIlhonQvDKDDgk23wbKqdN71nQ+ReTrgqIpS9B9J/p7rUrOWFDvPenk2WhFk?=
 =?us-ascii?Q?E4L5IezMqp7NH9WjgHWNTM2NoRTILK9QAELEGnj/OoZmZAlWS/mzs2SBG56Z?=
 =?us-ascii?Q?9QmaZF0APeH3Oml1p3sWzcVWzAzi9xPFNBD5099TOKZckdCZ3AMcYScZUkeH?=
 =?us-ascii?Q?ERXQ0H8+1EntnMQejJOdtvQh3bOi/MO+hpIc3JiMaE8IXjkxyK5DB+NNf6gZ?=
 =?us-ascii?Q?LfM/lU3oSnaSvCvOnGz3MBGl5SnoM56U8UMCGSPasiPzgoSeOZrY2Aqu6wml?=
 =?us-ascii?Q?iZEJR56roOoV9vEris/pohV/63ngrKZlM/KdRKu9NeqKNCUCsiB4pnX3Iwgo?=
 =?us-ascii?Q?oxoyolv4OO8Yj6c9+n6Y9ak3oNg1L2r8gYS1Y4lu/hyuIqtjq5LWiQhtLtr5?=
 =?us-ascii?Q?C4zTxp3tFHgPtgKzV/37jsrNcnQsluFrSlGIbeXbXV15JiBJcN8jalPWd/XZ?=
 =?us-ascii?Q?0bf0h+j/8FuAW4AFvG2o1GFUu38DWfVTY+THaaWahAredzHHzh7+hAV+HsT8?=
 =?us-ascii?Q?Zxt+fR3CN1todHGyVT5xIKFt7enHD6ofaSlXaWkF4sFrR2h2x3poHiIsUQ6Y?=
 =?us-ascii?Q?C/cLk85kKnZGGuriTBxB7uNDsqcJ+yHlqUHuSCqoaTLhxL5c5qPK0TbkqfHl?=
 =?us-ascii?Q?t1ZoUABPX8hcnmT4vTOoimiNGoI1YwHjlIldhv3IzZHxieJgEP6jzEf0BQzx?=
 =?us-ascii?Q?U0fob/R6F7vhlG0xkfnOd3gDJgYzgNWo5eQ3BbWju4/RYvzOnHTeW6yyOiXM?=
 =?us-ascii?Q?7bgufeXdZ3nbYq0/jfQLxtzlaIqUDa1MBlCQjPj89DmPyzHTCwQXhKV0iWE2?=
 =?us-ascii?Q?jG+1k8KauQr5tx5EJgw5am3ZGcjEZS245dpvnZCjUZzishf3t5aIP+fpq2t/?=
 =?us-ascii?Q?v+FVvr/UUqW+cUVVpmN0RjeBxGx+rNC5VIFuPJAGMrGmXaLnjF3lrsdy5rJA?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a29ec29-902a-40fd-c742-08de2e2f3529
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5061.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:35:42.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFLozyOHJfA3rSpQ8dBDJBhdUEHitDU+3hqn3aQYrgAoLnvswmOP/F309tSghKbmTwivmyCtVJ4a2kHRtR8vzF8gTN6FbNLF0x6QW5nf0hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAyNCBTYWx0ZWRfXzuM6l9eZxqXo
 t45SjNjnn9+PI5y2ZJWMuFiospSh5VoB7D8IAMlyAqMmJ0u+mhzWgdpkzwgScY7Fsjwcbl5dVLQ
 I8CJp7qhMsgQZbeMNNfwY8Y1Iqm6S+PU1DrEFVWWwJesdOIEyvYGzoZQS81IPH5KtpLvL4/T/QY
 dJcjKzIQfk9OGnf0sYBLLBwaS0lYOLNKVDiIn3aoI0YNE0gTMaAQL0V7/7VBLDs74X2wA2hBggz
 qbLoHfaL8OUbWJO+h3pFs4zIuZJhwoSE2L6IM2w7w311HPQE2TVbbZuKmpwaPo+bJAFu9AuUo64
 6Ij8EKzU8ZIywwqGI9RgQzcRkJBWxLIZMW1si8/9FVI/yQj+I/nGj1YoZ3zabmr+TCOu+Jg5Nhn
 /ng+uerWYeXPoa0yOZZxdpfyjVNI3A==
X-Authority-Analysis: v=2.4 cv=JcCxbEKV c=1 sm=1 tr=0 ts=69291891 cx=c_pps
 a=HCsVV3dTzGSkd59CkKbNuQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=GLtnJ_i9NkFmi9gY_58A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: DHnITfYPsyeuVshH3mKGcC-pr5RArxQt
X-Proofpoint-ORIG-GUID: DHnITfYPsyeuVshH3mKGcC-pr5RArxQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511280024

From: Yongxin Liu <yongxin.liu@windriver.com>

The intel_pmc_ipc() function uses ACPI_ALLOCATE_BUFFER to allocate memory
for the ACPI evaluation result but never frees it, causing a 192-byte
memory leak on each call.

This leak is triggered during network interface initialization when the
stmmac driver calls intel_mac_finish() -> intel_pmc_ipc().

  unreferenced object 0xffff96a848d6ea80 (size 192):
    comm "dhcpcd", pid 541, jiffies 4294684345
    hex dump (first 32 bytes):
      04 00 00 00 05 00 00 00 98 ea d6 48 a8 96 ff ff  ...........H....
      00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
    backtrace (crc b1564374):
      kmemleak_alloc+0x2d/0x40
      __kmalloc_noprof+0x2fa/0x730
      acpi_ut_initialize_buffer+0x83/0xc0
      acpi_evaluate_object+0x29a/0x2f0
      intel_pmc_ipc+0xfd/0x170
      intel_mac_finish+0x168/0x230
      stmmac_mac_finish+0x3d/0x50
      phylink_major_config+0x22b/0x5b0
      phylink_mac_initial_config.constprop.0+0xf1/0x1b0
      phylink_start+0x8e/0x210
      __stmmac_open+0x12c/0x2b0
      stmmac_open+0x23c/0x380
      __dev_open+0x11d/0x2c0
      __dev_change_flags+0x1d2/0x250
      netif_change_flags+0x2b/0x70
      dev_change_flags+0x40/0xb0

Add __free(kfree) for ACPI object to properly release the allocated buffer.

Cc: stable@vger.kernel.org
Fixes: 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add SoC register access")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
V2->V3:
Use __free(kfree) instead of goto and kfree();

V1->V2:
Cover all potential paths for kfree();
---
 include/linux/platform_data/x86/intel_pmc_ipc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/x86/intel_pmc_ipc.h b/include/linux/platform_data/x86/intel_pmc_ipc.h
index 1d34435b7001..cf0b78048b0e 100644
--- a/include/linux/platform_data/x86/intel_pmc_ipc.h
+++ b/include/linux/platform_data/x86/intel_pmc_ipc.h
@@ -9,6 +9,7 @@
 #ifndef INTEL_PMC_IPC_H
 #define INTEL_PMC_IPC_H
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 
 #define IPC_SOC_REGISTER_ACCESS			0xAA
 #define IPC_SOC_SUB_CMD_READ			0x00
@@ -48,7 +49,7 @@ static inline int intel_pmc_ipc(struct pmc_ipc_cmd *ipc_cmd, struct pmc_ipc_rbuf
 		{.type = ACPI_TYPE_INTEGER,},
 	};
 	struct acpi_object_list arg_list = { PMC_IPCS_PARAM_COUNT, params };
-	union acpi_object *obj;
+	union acpi_object *obj __free(kfree) = NULL;
 	int status;
 
 	if (!ipc_cmd || !rbuf)
-- 
2.46.2



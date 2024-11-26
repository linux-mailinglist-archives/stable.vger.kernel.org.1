Return-Path: <stable+bounces-95518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4C9D952F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 11:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B33C281E7D
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A31BC063;
	Tue, 26 Nov 2024 10:10:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687E1BC9EE
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615845; cv=fail; b=pKZJVd3pe7YJdJJ4OYpkcxNPN9wa/cAjf+rwVbgXc4maxwDiwhsYX7zwmdH5HtmRpNGoZ/v3ht/sAbahsKsOinI/GKCaNnpiFwd7kWFFDLxv29/rlGreDkC8xWQvnp0iOxc5RImqj7VbMilx76Ou/c7V7dqM+PSnoY7QUgL5PK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615845; c=relaxed/simple;
	bh=zfP4corh5XS8tyiKRoyEsuCZMDYXd7PUGVW0DC636E4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KdwGnASOsDgmPGLgU5t8SVtCGWCfwyzXA4XI30scvcFceZpbErpSwOgJLhJNpfKfCc6whrFcNaiook9hDYRLM2QRPuIAr0QzNzlp5yFOv8Y6WTpjBtEvMP6RYPzytRJ5OgIjBCx42Ybta9SUQ+m0ZIHT2wftD9iXYuew7YHahrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ6hNfu019390;
	Tue, 26 Nov 2024 10:10:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618b2hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 10:10:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/vyhM+iOdF7ga+0gZcscIOtARB9oEXGNjDGqKaazS7HbY3URgFMasTMbJZYFmLejpDRSNT8UfU/bumonp6LUkFKd/cyYyv5HD8e3UYZUNLsIoJsJ2s8xIm3iyCldsDAqyioZiwQm2oDISdLZWIUHWLmhd+Aoi9Q6cU5q4EMHaVXsEY8C+ti5ms6Us1kYG2RjzEhaZKK69bpICCziLb2kVsbegzhjE50/kimqFL18+1hHCIqiWqlTAPDNTtSsMDrwKdUQ9ViNFxSaWdv+h4RvhAsdDifewg+8pHqcZVW+xJW/z6Mfs2Lz55LjdQOpNlAdZ0SduGbFx8EOlp/C1uctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6HyaLTXs16CWfGxFfEIs9HZkdz69xCywz6VIiI+K94=;
 b=ZVqWWA+ceO1rPJdaiIUAklgA/Wrm/PTRj78v7kzeaxcd9cw8C4dgY2txhajucDp8Wrknsvzt1YJdXOqYpvf0ju4GvWX1jNP3ipiMYdQ0zIGzpzi0sGvaYq1xIFtFWSJKX5jKtsxpfXyVCKfW/+hnD/CStwUO5Wf+40v4ylo2DKhUHctlTVhpT+X37GgGuvdZ2GjlRjMPqqiG8VdggnpKUgkKjjETNm5G1rCxbnI1UN9gKqz/BM/HBE8+tsxJIyEjbfWgz9uQ03yLM+jSekzp60L9SutXi01ChjuNivDy3PRlEBFSgRuKop1xOXJlRUFblUFJLYIkzx6enoewrhdAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 10:10:35 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 10:10:35 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: srinivasan.shanmugam@amd.com, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1/6.6] drm/amd/display: Add NULL check for function pointer in dcn32_set_output_transfer_func
Date: Tue, 26 Nov 2024 18:10:51 +0800
Message-ID: <20241126101051.2749602-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 816069a4-68c7-4922-38c9-08dd0e029195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eV2Lm1iZeutpBOQDmmJWiAn/9u65Abqj1bscksoa1ZgITV8me5Im41F7A76?=
 =?us-ascii?Q?pv5ehO6KYNxStT/SZPTwOZ7BF5qv0rFoyqsmQG1rpoBMYnDQ713IvEfqylLd?=
 =?us-ascii?Q?aoUjhiJI1yw63BsWeykyTwt9QrH8KcwBVPKIYReHkiCrNbPvGj9SWSyweQ1v?=
 =?us-ascii?Q?kWCGDKu+Ikl664vjI1chhHhuNx8vGER7TfNBxO2tZ88MrLLzbu2+xxoBKIRx?=
 =?us-ascii?Q?O+oxnCeKnGPiV05/juas0q5Io60/37tmjNXb80Lmt+6NE6QJVHi1EwT9cvcF?=
 =?us-ascii?Q?Pb+TTpvwJ5p+nwZ4zowN6b4WdfWgijGCHUGYKf2QD/CLLRzW87GoeSm/xlVB?=
 =?us-ascii?Q?Jzoqnr2UusmKYy+S27Gfy5JSkeliqRmrBUGVWdesn4IrqklcqCFVGzN5TpQE?=
 =?us-ascii?Q?lhDOvwM743usLBPpWyfbJjclzb5REQJJBi2h/9rw9iySOWdXu0eFJFFXidGX?=
 =?us-ascii?Q?pxdHDhdUO4+HiY+lWwekUuB6YEkqd2jyWOXO7vF1UprkqlmItUbuyCa/YiVo?=
 =?us-ascii?Q?yJj+JCXgAra31sPm4yGelNhNmU7uRvTioQ8E6hSHm9VOutT8f27ig/DVQu9g?=
 =?us-ascii?Q?biUhaZ4JOcxzU0VOXxnqEVnoeEghB8ep+Ju7u3FnUJ3Jozrum0dPmqzJb1Eg?=
 =?us-ascii?Q?ixy6HivZhnHMfTAbEaKaw40jmBcSOc9/rFlnJzRW+PLxldaqN6yBB9dMSKOU?=
 =?us-ascii?Q?HRkSBt8dl5E2OlYNlyZ959K7FjhIhY1wD48j8dAnfUH94B/8quCk+6DwZZW6?=
 =?us-ascii?Q?N1bJlPZhu7A0vcAMQmblb15EJv5s9BG/KKqLJBgX/qH9eAywg1BEN1eIoCNB?=
 =?us-ascii?Q?Zx3vIJC1b0Yvt/Mvt++QkaXyCfG5Mx6myNEytS1q+TF8qC4QiDEW0VJKeE8O?=
 =?us-ascii?Q?00qpSNmmS3+2ao8gf3lle1xlBuNXPy9MQqDjqkVC67kzu7SnLqQpuUmnB4S1?=
 =?us-ascii?Q?kizAgVWRA0GC7Wr1PqI0c6f+zU/1lsb2YV3jdhuorHgQDqJ4IH/KBqQ6qWzF?=
 =?us-ascii?Q?rVtgHJtJN4zodsgtts9JT51p/wwbFglrOsI6xQKMO+RDeaR/g6Xh/3wfxcw4?=
 =?us-ascii?Q?GM+aJifvWNEpVJFjehWkPMw41xHEo/xV1it89L1s0qqi8mlN8k5GIibUxSIz?=
 =?us-ascii?Q?kmwyQ39QdJgKkyTLeKLwqj0oQplxk6T5hArPJx/hw3Rc8eRG0M4oXn5Do7Ei?=
 =?us-ascii?Q?GP3J/vH6Zy9Ijl8rw3/BkRP/4tkuBxaDUA29t4jSoFDxS/ScdLdutb91E8NC?=
 =?us-ascii?Q?kR2Xis9dGVSLJXye4UxYPSRCyPgFjJb3U4bbOtTheD5Yk5QfQHTta3+PpHGY?=
 =?us-ascii?Q?EAumhpzCEApVvW/rQhMd5BsWyvQSNDeYp2Y3f1WewPMqyUWHnXT1pNaNnf1C?=
 =?us-ascii?Q?WgL05tu4h7Oz+Ih/UprEPDX0T9lnRMsbD2wWCqnBICOdd24SRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gAVN7wIhI9jacydxKO34FuR/mab6uCEvOjNoGPKF9wSEzCSwcocnbscCDcdn?=
 =?us-ascii?Q?4ZGE89l/KfiGL+naoz+IGx55uI07Pc0KV3bYOvC8SnpIM2d+QcLY6KY/3pZW?=
 =?us-ascii?Q?G0oJFSq9rjPuebXoo1N7IjSpW/TE9/hJ+VKA+P6jYhA+fOtJ5dk+LxN9QkhV?=
 =?us-ascii?Q?M63D+Z27Y4+jWVfFQmORe42z8L8gDDhLXbn2d1lGE03t5rALz7EbDnAGEJyx?=
 =?us-ascii?Q?P7S14z1SQHEzkNXbgF334qBW07nZYtGi4bsGOSuWajPRj0eL7MB3es3qP+uC?=
 =?us-ascii?Q?WeT0Kjz+bFFn9ygPqV9do11Z15uTYUaOc1PtIVlbGmhoBYT1znXcCaZM/cwt?=
 =?us-ascii?Q?p8soRrYwaAJp5Tmv6gJAJKLrEu9V1lTyaq8jD3cz2a6fOCII+FYRZ3U6ZKPF?=
 =?us-ascii?Q?x2g73uOuz5VLvYOzyMvycDtqm9HIO+YZ+NtFKHmRjW/Ot3chYYHqpzAtsqsX?=
 =?us-ascii?Q?qUcYJTV6WPoS5pgWNru81GYW8BeIxPw6S0lVKTS5Qgqv6p/E+j6vYvo9h/yQ?=
 =?us-ascii?Q?S1Mr04rfwQ0d6KxWmdjavr/w/lSeEvdYNFzh3TppdtRf8GtPn7SdjDYU536L?=
 =?us-ascii?Q?Po4WgW6qiEJ2AbLbX8dYkZrQR49dtAiDRp5e/xTNv6uOrTW0I4lNY9iy6By5?=
 =?us-ascii?Q?azxeJNfJ00nfpmyxQpPjfwbFe/aR7sJM+AvnXq5KYQyDYDQL2OvnNbaruJN3?=
 =?us-ascii?Q?E1opMsu04Ubz5KXcRj9pk+2kwYkgsNXDrmG0F7CFPpCkt3hqcKm3+4RGYIFQ?=
 =?us-ascii?Q?PYiYnK+lLUgQLnu6Wt8/9o1RqrYCNXxKJx1dMfqqHx5iW2HmRr3RGv5DR3Yi?=
 =?us-ascii?Q?71P9jetIZxr7cghHBLjQO36LS7BRobU3/ONzgQSqBVnO0EdK7YKCkTvHgvbK?=
 =?us-ascii?Q?EhC07cJIZYf6PaqBEdDOityKoNSzW7wxZb/hERKy25Gc+B71k/9srNOHk1UZ?=
 =?us-ascii?Q?GyweZbGbFK3VsTbjwEl3JMSaAtj7pHW+SwBhVWX3tSGw1Ae0tEaOtVLE/mBN?=
 =?us-ascii?Q?gWfQFSf8v/neLoyMaAipPgOkGhe9uNHDO8Q0PZL2tWLLx1P54Dyqh8Cz0pQP?=
 =?us-ascii?Q?teBW217oJnSAzcDY913x7vape5IoOzR7rh4o9EFeWPREENBgORS4hJnd5Wjl?=
 =?us-ascii?Q?FpuDnlkqrJ1nniCq7zmBRoRfATYNhQJc2+IVS0QYf9zMKBqsMTIxhemP+XA5?=
 =?us-ascii?Q?lWE4ECqxlX6Nr9kt5c1NYNf3PbE1hfdwSPAheR4ufBALjV7D4EJrK4wmTOUC?=
 =?us-ascii?Q?RR0IvJoh2BdzRIp+dxJrHX6Rqb9iELTxZGI/sH/Vxf9O1Ki1sJ2QNRmHDdNP?=
 =?us-ascii?Q?DfWLjq21nK9PQunpGh0QM86q7AwDhlq1aups8Az/9yCMUYvi1JMj8RMRnZPo?=
 =?us-ascii?Q?7FYqTtEZjZqBuNozWaO2MSJ8L2p7bxuXn/GkyoCXFdLjzZArERXYBsab0IcN?=
 =?us-ascii?Q?5ZQOeYbKHTj5pSY0Ln9ooE43YRna6ltCIPRXc5FULju/J/rwHLJP2f1H+02+?=
 =?us-ascii?Q?ocKKsAaMh5Ju8SPLpuyd5tSLjOZUNNW9+XZidDyvT8E6W3gBKizPfyBpr/Km?=
 =?us-ascii?Q?uDxSrkPukyAUQeT1OFuelzGZlI3Yn9OALZlNe1A/WRLrJXOAmDM+zicPmsE8?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816069a4-68c7-4922-38c9-08dd0e029195
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:10:35.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVPveB4nbx3AlbCH78+LGa0tfoaPgRyLYEpzNWN7P2en6PZS34DGEoq5QcUckDDmen4g38Abel0oiL+iS3A21hlihx0lMp5ckLOB+tCiNNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-Proofpoint-ORIG-GUID: k1sy51AJ19MZedGAetPaD_rJmvVNkAzv
X-Proofpoint-GUID: k1sy51AJ19MZedGAetPaD_rJmvVNkAzv
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=67459e9e cx=c_pps a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=R5svnZXgCsaE2rmGVfoA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_08,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411260081

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 28574b08c70e56d34d6f6379326a860b96749051 ]

This commit adds a null check for the set_output_gamma function pointer
in the dcn32_set_output_transfer_func function. Previously,
set_output_gamma was being checked for null, but then it was being
dereferenced without any null check. This could lead to a null pointer
dereference if set_output_gamma is null.

To fix this, we now ensure that set_output_gamma is not null before
dereferencing it. We do this by adding a null check for set_output_gamma
before the call to set_output_gamma.

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index bd75d3cba098..d3ad13bf35c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -667,7 +667,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
-- 
2.43.0



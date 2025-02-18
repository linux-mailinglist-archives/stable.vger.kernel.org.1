Return-Path: <stable+bounces-116673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA7A393B4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5674D16E248
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 07:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD211ADFE0;
	Tue, 18 Feb 2025 07:17:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167B7E1
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863038; cv=fail; b=E0gjRXyM6BjhAJD6R8ciMe6EBqV5Vxa0MBVrWJ4wvKbqLc8ynfD+UXglmyBLPBR2IUInkLODS+UFP1y2lw8ztE+EMkPraryZDH/ZfIFi/uNGo1MJaxlLKx94+x9pKF7eOjeUbohHHO6xWDSvI8UqsEemVoAHYuXLiIaWkpHUiLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863038; c=relaxed/simple;
	bh=vojXCzMDiaf5HUwHluwDg6sR48iFYNgPnW8vLYIQkvs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XU+Ut3tNYF/wYGqdTnaVRXLkXqkSwNbB/mI4/ynbayP8gSSk/BlrBae7XU5tzJoRYnL3n6X6kMo/BEiSJTjGn3NKWbknufyiVr3/gEhX5ARrRt44VjmRFCvKV9dbXTC6/oTkI0MfqYiAtSA2ggUW7G0OVIROyDIVqpodJ+xGtqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I4GbLd003822;
	Tue, 18 Feb 2025 07:17:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44tg51js33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 07:17:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+0Hu26bUPqELGOED0adpez0EmQWtS4N9mZdW3WPswjLcbT9CnGBV9/DMzeHfEjVjPxjEm2pjIlHygxw/Feu6rQ+qwKU56B1DdL9Szc5Gv+AKQwXQeWVGOCd9RHe5ZTKmb1Hc+/TXJx2n6LhdFqQKVs5VGnZ7wvB3cykY0MXzB5ZMIZQQfkQv8/LF9Ve0o3Zf16Qp1WXsGLG+GnyYl+ucQWH/JE0HzcyC3b2wxdSR/OXt3+YuOdtA2+afoGMWNpXWDh4VPB0T2yxu4RdxNOMCSqWMrP4d6A6eRh+vxqpJXlOGJV6D28y3o9cr2rQk6Z9HURqe4n/XyPDj8z7e8uB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGvAwTQok4qElGzLyQauAcPTqCdBiZ/F75qS64nOjqY=;
 b=XyTo72Ef9phZXRtkVQtqe+KN16sk+LrB72jycbNUb+XfiZoPIzgiNzlRXp/YfDMODG2hya1X1GFc0II4RAJlxM/LZzN9xJSKqirQ/z1Mubj5HU/h25i6VwapVAvICfW+rnKIdp7vsW8R59yTQVGmFyv+nFoOzTy9z5NavgJPGNeJNqeCzRew/1DGz0U6U2q2qjaCl8MaTOjC6n1TlTpLnmHreaoT8F7rCO1n0yRaattRo7PLypIRrL9xEB+Ub5k4KamPk2kQUO/K7OcB7h/TNc2/D7NpDNXcQMt+zAMrl+SGyL/jXvrb8xCRHhg6Yb8auJVz1GIoLyPlOOjkoNopnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 18 Feb
 2025 07:17:10 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 07:17:10 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: rodrigo.siqueira@amd.com, jerry.zuo@amd.com, alex.hung@amd.com,
        daniel.wheeler@amd.com, alexander.deucher@amd.com,
        stable@vger.kernel.org
Cc: zhe.he@windriver.com, gregkh@linuxfoundation.org
Subject: [PATCH 6.6.y] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Tue, 18 Feb 2025 15:16:59 +0800
Message-Id: <20250218071659.3696692-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:404:14::32) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA2PR11MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: 128c99d9-cc2a-4388-8a6a-08dd4fec427c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yTYau0xXVFPGUv25GPeP3UoAZ3O6Vt9M8HgOV/BkeIcqwo9Z1H3PG7gT9pg?=
 =?us-ascii?Q?KTKiwy6J4Djm5VCy17QjdJP2UKlyJYQH0A7juYDw6o+MjvbY3k2a7G/02HEM?=
 =?us-ascii?Q?UzvYKQ+yqChAqD1v0cvSXz4TCoMEfg7FwQByGF5f0tJlBhApI8YtjVX9OJEL?=
 =?us-ascii?Q?o7xV/+jdfShJjELkmDXS8oCMuZ4iSZbTInTiwynVz+bWzpvUZ6/PxZpQKRb1?=
 =?us-ascii?Q?3HFEtYTD4oE6Yqt7Kg8/jqw/AIGDERtDmfCYJvmCvFZDjfs7LHFwWj6Lbxjk?=
 =?us-ascii?Q?GIHdDSVeOU2C0ZnuSwQ9XoqMTd4XKJn8ag3kaFovk3C/v/jjybAM7BguTB4v?=
 =?us-ascii?Q?NPuuYN8jNmNHrGfHs1H24EuYzHVA4fIE8Rf8tTm8P+9om2aURKA2XsExmowr?=
 =?us-ascii?Q?QKZKyGoTTvPjOwnit4mX+5+juE7zeWLXYznRnZFk620xtwQKp0cPm2xMLdZr?=
 =?us-ascii?Q?VPGpdKwuIbgO2DnhLhYcirEKAlmDdsvbO1P94pSkiacdyMyTjgdhjzs9Mtx5?=
 =?us-ascii?Q?j4dSFdW+U3CJzl0QC3h4Gz7JFXiQ6oxtr3kmf6/bktPgZHFGP+5Sf+VsZE8x?=
 =?us-ascii?Q?voyM3FCiU9n0Qi7KCzfyMZJicu5gVnam1CIcWP0GuDiyhiSzahSefsqgLKCW?=
 =?us-ascii?Q?zSTLwUCvZ4UQX6gWKReERoaeFgnAPCpFHIkDPZbDvESXj+eK9p/Ibi2KXOHv?=
 =?us-ascii?Q?vOqP1Gzpe2j02NDXjVJyspBgKtrKGdy+wOQXk2tRPVuglsiWFlLqaV59oM/l?=
 =?us-ascii?Q?mgHN67xUr6pFoebYvJhuM3t8jQZ4w3yvtMMbjJ8pPMgh58KSX6Sv0vKDzdYz?=
 =?us-ascii?Q?5o0ijJ2C+ImSX/6WoOMAWVDAAUiOkAyIOZ5YaNd0U4Pv71ZNn42S8tyJHlEi?=
 =?us-ascii?Q?2cdQ30DdMdp8/8XTvqxV535+0z+283GJrHb+4/ipFvcNc1KtMo56rpT3vD41?=
 =?us-ascii?Q?5a0uSj9MYsl1ddUH5iKGO5XuRvV+xNBJqBOjmjSxxZXVtSOjL8621vAwFZSl?=
 =?us-ascii?Q?5cm+dszDai6tpove66pDDPoBre3V84+mlBm3jLAMbMTXJsR/xaOXTS/hQNwh?=
 =?us-ascii?Q?yEPq5xQf/ppAcJWziz5ygAvE7z+Iqb50xAkA+SFfAGUIoVs++ae2a7VyWssH?=
 =?us-ascii?Q?q9YxnIf8T/Wgr6ZTK7cUhZw/9mUaw9rn0HO86bJeKvvbAQ74Z5jLfbqQvxxr?=
 =?us-ascii?Q?1bRoFPnv31KM4F2Zvkq4+qBw/Xuo70/e5ksk1y5Uty4VMiFjoMt+QjoVpdRa?=
 =?us-ascii?Q?0MBABG/TPP72TKa8IMsXzuRnAp5H5PWioPeHwZ6kt+1SOZvbC91eNiLJAM2g?=
 =?us-ascii?Q?AbUSoCeZI8Ele9FeWzFy+6d6lDZm0rVoySdzIWS5u04pn0xr1gUDx+C5jQ+F?=
 =?us-ascii?Q?e9T47gbXQiLH22lqOp53gNHZgAZNa9yAsPnnJafssDHuJf8LMJRPGqfhnIXh?=
 =?us-ascii?Q?/1wQuMNhf3+Nvg/TvZPM4XAV3FgK4kK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j6IALZhQFM0iDQJpbYTHEo1oMhyC4XB+C5sDYq7wQTHjrjZogZ/oz1oETJIO?=
 =?us-ascii?Q?fN6t156qDJWWAdOHAnxXMXFLh8ZApn6im4gg7aeKfg4q0JHWdmqn2rLUrvtO?=
 =?us-ascii?Q?Vn4URDVwAabgGpqAO96zyRLPK7iqMXVc+X/22kd70xjpoYNZPT2wpG/zLzwo?=
 =?us-ascii?Q?YGeXA+WTjdkchkfqzSLGak9YSAhCOXgNtbmIUpsujD5vGY61jnTI5t8u722E?=
 =?us-ascii?Q?69achNv06kvImlDROAEYcG198bpYrzgu5SN6X8NzPfStpX1o2AKuGL14eMs0?=
 =?us-ascii?Q?JI/8gSH3hRzx3/aZ8rmnMDF7m9txT4ymMfMKcKmkatiWm+CajaDdVtloUw4Q?=
 =?us-ascii?Q?UuJ397RnOCYreeSVrGvE53X5t5+69waCSI9u7T1wankVriEo+S21hE6P2eJf?=
 =?us-ascii?Q?0Hc1p+Gkzi32Io1sYm3acnUBaSIpxwILIRhR/VRSF+VUYPdNqUxg6261Q+dB?=
 =?us-ascii?Q?oVJfJGS7FHJUqjRr/tuReoIyfHfRiixXkdJNgig1nCzQ7rQ6XukNasO7smOJ?=
 =?us-ascii?Q?1Jg4raG8pIYVYDNt4QjI76WW028Hw08aAA+PSrZq+hNDIvyfE0PgtUzsV9ll?=
 =?us-ascii?Q?dgZuM/Wpz8rAJwrru5W4or4Mt4OrKIRrfxlz92CncAylk7j1YJNODljUPH1A?=
 =?us-ascii?Q?2ZMq8HdDwf7lLu7mkzws0WOk/R+uq7yulIHLoD1BHB2bKxg8DRJ3YktQbiji?=
 =?us-ascii?Q?O733G+9OVTEfSfIeIzuyFjKdO3WVZoki30/bdaP8Kl4AiwZ9KSsEEFjPpbEk?=
 =?us-ascii?Q?DSE6bVNGu1frAZCGFo7ZHA7L67tHEmCDptsHhf1F0men1/EJl1dXj7+mjvKw?=
 =?us-ascii?Q?BgTYDR+J3mG+Rez9f+s7FdUpPJDs8P3lMM44e8EeP8AVwx5yJTXmsYT7eLPK?=
 =?us-ascii?Q?waYEzaHH6sQoe/8gzAXiBQAfiT8SSFXiaBAOHaClaZq+jERHjVkXN0bW9YWV?=
 =?us-ascii?Q?ouZgv6PojOPMPWO7xs/IX6mPTDX9BbIk7/5G+ep8ebKk7cxx2kDoTwIDutiz?=
 =?us-ascii?Q?al0LlFX06dmkP+lKWfFQDkM8E0UjixhCNYDGxdpDAgNP55toQguSuJLW8JTP?=
 =?us-ascii?Q?TGNrgrjJQEpUv4Jz0O5ybvxxuDZ5L7+Q9qv4OTBOb9tEvmoWLnUYrAjEdHgm?=
 =?us-ascii?Q?OVUslDr4QLSWNxo1bsNdjG+UCdyd7KyqGIZyRvy/A9FzNXViHxU6oE04m4u+?=
 =?us-ascii?Q?kZ0SAxffln3XafAW6pAksSSst/SyQ8j5efK9d1J7ntjlgQfLXd4cg8zeUjsO?=
 =?us-ascii?Q?W5gTjjzFPNKP5DCUDCvBcmzjHmf5O8By87mHX+VzAdpnHxoCPTMLoqu4pjnD?=
 =?us-ascii?Q?Y6wt9mxCTuSq8miEwYR5ejLGSAZeIBn+eFnIwP9jN/a/jgdDOe4wP2rBLqJE?=
 =?us-ascii?Q?Ik6kE2rUVKgcZhQoyx1MTKWexxlIfF2KQpH7v+uVYJKs27R6mXTNPom4wdz7?=
 =?us-ascii?Q?6vJFJxfKmual8hXwHi4fmvH+IZMdcueRwszlGE39z93g8kBEPNa9nhc0rTQa?=
 =?us-ascii?Q?+rV6y4Duy94T8mzwZCAhthEM5+4k7Ja24olcZWg1P9in6n3Bcwo4zzuuB3+W?=
 =?us-ascii?Q?3QPyuPleF72X8Xz8QVMz2CtRdpNi6gCZfKCn+azWbNdg02DVwCtnAczPuecK?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128c99d9-cc2a-4388-8a6a-08dd4fec427c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 07:17:10.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkuEgQFcE1sGVE/3mMc2EMnqxoHEUtOvJ3q6OHcZQN+eXCICCtU671LLF0Of5LpfLPdSAa09vZgIHmP/NnU62RiQM+zflaXMKybVtyijsCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-Authority-Analysis: v=2.4 cv=T4B2T+KQ c=1 sm=1 tr=0 ts=67b433f8 cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=_Eqp4RXO4fwA:10 a=zd2uoN0lAAAA:8
 a=t7CeM3EgAAAA:8 a=NH5Uys3y0s3xEj-p5_YA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: eVyx3xN8V5MBc_6qeFqN1mwFhHzYa5ix
X-Proofpoint-ORIG-GUID: eVyx3xN8V5MBc_6qeFqN1mwFhHzYa5ix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=795
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502180054

From: Alex Hung <alex.hung@amd.com>

[ upstream commit 5559598742fb4538e4c51c48ef70563c49c2af23 ]

[WHAT & HOW]
"dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
cannot be a null pointer. Let's pass a valid pointer to avoid null
dereference.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[dcn20 and dcn21 were moved from drivers/gpu/drm/amd/display/dc to
drivers/gpu/drm/amd/display/dc/resource since
8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
The path is changed accordingly to apply the patch on 6.6.y.]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test only due to we don't have dcn20/dcn21 device.
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d587f807dfd7..294609557b73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2026,6 +2026,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2050,7 +2051,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8dffa5b6426e..24105a5b9f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -800,6 +800,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -842,7 +843,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			goto validate_fail;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-- 
2.25.1



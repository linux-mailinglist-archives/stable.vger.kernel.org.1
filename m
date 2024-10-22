Return-Path: <stable+bounces-87676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3269A9B2A
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D236CB26169
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6114B976;
	Tue, 22 Oct 2024 07:35:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58B14E2CC
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582539; cv=fail; b=RzZp2qLLCch7z6+JdtocM7Hvs7vu1bISrWqg4gwlLjaOHk2WeRLpGHcrVN1wWHUjiYHUJWCb0N05Ucl11eHkuLAngyAMpDpaHLUge699jjB11fxxWb2qnm2NKpXODPJLltLI44/PDdvyvyUPEv9sHeE0TcztbsWiO/qtpopuMiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582539; c=relaxed/simple;
	bh=mZ63U210qbwgz18qMy55upTh2Tr1OrkJbZskUnHT2AU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l+9gGKhTRr0idZWWyYN5TEt5Z8kUG9yx1KqFZBzA+wxwj8CE3d2HzJitSiNgT+KtxSOJ0XcEeJ7e62bl4E4kmy7j+ZOSaL5O488DENQXVlfy5A0RyjmOp/9hmg1sJSyeZDTrVAfJZmwQ8xoRYItuy7uuSHT3C1zCJ1LG+5dBcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M60P4H020948
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 00:35:31 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42c823tym7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 00:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYtDQ+noO9caI8yFIIRU+Vh5wtyOwChwONxllt7i0rnrr41HMl/sRKvsfrP2fVsnE8UdUJhbLMU0Y/KalJt6njPRISncX3d0fLFmZVXsAOjIdzJDtWWriAS8PnqxrxPVnBaX31+Z2TkY03ph1E47mLD9kKKerRPw2WP1uwcHyo0BUSsWdVIxaYYAIAEX2tZvSPQtDO4WQnxaCZP8vrY3Pzf8h3koZRl1DhHMr5hjpj4J1qbmNk60gsI2/cYPwbx4E7df6mYAj0YM1WpppSLS2Ax2zCjWdfngy3wqSx9W0FsRx+PVXmmwO6b1lOnmbFNcSzhMQcqe1Q1eDu/3kaU+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nYeMQUjpw0s2CB4f8eBPi9/gESWo95j8dxcHaFIzrk=;
 b=gPnASCWoHVTkcyvsiSeHWM3FgyHDLT1i3OkXthFPA7T8tzpVXzHJ11LDiXTAl8CWqnu62tQ6Xo/LGVFIlAZaX2V1PFu7QAAqznmaLDVuvyL7ZZG2EFrD2iaju/vBazPfBrXiuqkhXz0hocGs9icax/PRKXzi8sCRrS/CDm8tzrrRlOyyWqrXtPQv67mJTd8Wb0rZA/JZuDX30Nz4UmV90xMxvREOtm/+qJslil/caDX+nm85OIqjRHt3SplNwZaObt9NfP+vv9i7cwZomXzsB9WUsKEdqtVdPuv0vb0b6me56t9EaeltgK1T4juJTyHipj4LamIw+SrCnl4qGZHIvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 07:35:26 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 07:35:26 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] drm/amd/display: Skip on writeback when it's not applicable
Date: Tue, 22 Oct 2024 15:35:17 +0800
Message-ID: <20241022073517.3092989-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DM6PR11MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d87f79-acc1-4fe6-52dc-08dcf26c1854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TxWryv+HXbCsq2FHneFtSQNdvIYHfA3rZNzJgIpx2/p4FnPtSONmkXB3r44S?=
 =?us-ascii?Q?s6bklo8PeuYCAdYG+20K+zspVf6Ck0xaDt9N8AnnZrw5vaNuq6Jb53/uniba?=
 =?us-ascii?Q?TQXTjIaVaqre52i05Sc/o4/6pywedlKv4C6aFHwhfZk3C9QgseLW6zxExwMv?=
 =?us-ascii?Q?PsXFry2ucAEQzC7oCqpCobKUk31dTIJ5jCGdCDne8HAFZGqQaZ7TdxPw5izu?=
 =?us-ascii?Q?BDVN4VUqyBKrBYaW+H8/wu8Nn1KRHdlPVsxIZVOKNZEqp7Ou/APzniS8BdO0?=
 =?us-ascii?Q?MR0Gqnt55kiwZSEgJv1aFTFO4dojsM/oxxp53jgn3SlH36ABSDQbh6MiFMeo?=
 =?us-ascii?Q?mHFA5Kp6/mgWOxrwjqXbQYCsZTjim60+LbD3gMHUBW+5XR8ODn2Hhakq/r+B?=
 =?us-ascii?Q?PYeV8bYhOoCG3kSQBH29gJL3X3Zny7KiYezUsUZVdiYqR+YO5w9A9TMj+pvk?=
 =?us-ascii?Q?YodgqrVTIUAe2AAu8nAx8pCCBC+RU94wETL+5OkPO5gcps1lKJPn1EikOPtJ?=
 =?us-ascii?Q?QppWWGrxlmrWmZ9VVRCyPBgEaThBE3B2npjA2hv9K1mbbcZILa63xS35hwiY?=
 =?us-ascii?Q?b9t4dflElBZaTx1z2NPgfSNibYJVoSgvfvOE3TqXsLl1og+zpTIOsnoOpHst?=
 =?us-ascii?Q?cpPSYOfhPt31EtsAkS9PY0ydkuROh3wMOwWNGcClnEHiaK5SMYkFg6p4nxPk?=
 =?us-ascii?Q?4Zp2jqUMmXvE6PRg+HZHeTnlkAYumfS5LznU2nVZKwQgZ6ID1LhQTnTRhYvd?=
 =?us-ascii?Q?fq6Jy5vFeWDrIXQNfKUsKHX5YX5zgWq8zRQ9NspzUppNCmasVBMZMfYvzj3a?=
 =?us-ascii?Q?VT4kyjWLlHMI4yBjttd9flfYfqy+XDgE/Flnh9V/icrQ1My7UQ/wQKDepTpu?=
 =?us-ascii?Q?EbcVlvJK0PD8AbhIHG5RSvDGxqZYhwWiQuA20TGbc9vhbDgw7SvLPL+FJuOk?=
 =?us-ascii?Q?KBMZbe7Z19QFm37eqXUAnsnyQbpa0XjqXAbUgXEsAnsxV3jMzq3sWIelJc5v?=
 =?us-ascii?Q?43r/ihcXfIPXsg5pkIUQDRbTrmWrGqzzL+dVqIhEqaGGvrpetMWslJJ1b2IB?=
 =?us-ascii?Q?w58xEwX5N5ubToMIDQ1P3tYW5BJhb0sDSHHbVzVdiQrripYorshYYtQg1JuZ?=
 =?us-ascii?Q?OZRnronknJM3EabvbQ2+VDDNrTb2/9E5lc8k7n0WhzPYP6VvmcyTLf5xcgHX?=
 =?us-ascii?Q?DFgHIGSEojYf9SCiX3X5gntLqp7iJEjy4ZRNPjBPHCt4LtMXdAQcuhtSExbc?=
 =?us-ascii?Q?Omlsu3V0vAxrMaDELT52wcRqn89+xp6pxsOL44Gai1SgCS0G2MGoZRMmJfmP?=
 =?us-ascii?Q?FfH8NlOfCMtFrMIt7+GtgPuU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dfsCQzdo4bd7p3kAIqkmit4JcDwzJjtQjBleHZy6dLhqPHl4+saEgc7NPdYl?=
 =?us-ascii?Q?fWMGXNwWLutaNwWG2foV9NNbIoxlzNbAqBbJJHufpssGLe1MzZC5E8GsQAs/?=
 =?us-ascii?Q?qEeu9uRCskgzcdfKJf1Lq/9t462VmOzBuEEw1QwEcMXoJ+dh5WQVpjqQ9wLh?=
 =?us-ascii?Q?uLGmZzrJQw6S23hPmbcIXg0RszUiPbxCyN5RO9Zhz23fmXDTI7rr23W8dL46?=
 =?us-ascii?Q?fR0jrTNbmBxu91fY9INmIktTf9QJdE/R3mNZ8QCmL5qHpfFrwcWrPewlc+lP?=
 =?us-ascii?Q?qE5yr2/4DT1d9S55NQDpLY0AHYEaZ9SftToqgKXoc6Y0D835QPdWbcvy9tS7?=
 =?us-ascii?Q?eP6d74esSa2mbQ9ixylnTvLZN1t65cn1XSjdisYiDzoXGwjmQeq8se9J/Dxh?=
 =?us-ascii?Q?8C1WLDarKDZAEZS3aPTtzqn8ovwlKazoCSZdoqqZGWKwIKG9YuL6fLdAjp5n?=
 =?us-ascii?Q?4e7r1kcTczDrtd/MV3fmnjxf8JETq6jYnQmBVpdSjEh5AaCaiGP2be6EHlsQ?=
 =?us-ascii?Q?l/BS0lj6giZ7jPiGZZ5DcPfj7H8W5fnqV8D/9cAUMGCmGJUL4wHXCrtXImUh?=
 =?us-ascii?Q?AqujkcVBf2h02CdzpTFH9I2E4bBBiXsf5vc8/gi4dRc8uC+Gei49tIlvOIDe?=
 =?us-ascii?Q?PFo/fPGlZ5LUYlN0FBMjHHo82F+WLM8z1spg7A9y44g6uatXlfhf0YING72e?=
 =?us-ascii?Q?/qwprvBjTSl+exQc6cyUsnO92yUpUDUrLNU8Vks/hS5zkm1qzU+tx2RYiGXW?=
 =?us-ascii?Q?VHNIGtGDWc0HHXymL3g961076DiXXqNn5wSVp0rAGzxoMFaH3QqucmEv8w4F?=
 =?us-ascii?Q?xNdvPHJmo7gWCLIMopr13xknyb+Pxwp3K+S3tBU5AGsJ87HUBmoQK9rn95AS?=
 =?us-ascii?Q?b1vdgBSMKAsWr1a7Xos6iInnD5i3nxKNy7/8DRwn3NcjPVc+SYYlzYmx3FwQ?=
 =?us-ascii?Q?g9sComplkXANOFwiTtHIl9OPADmMBl0XT8gj8X0oZ1fSgMt1FzI/Fuxk9ihJ?=
 =?us-ascii?Q?vQ0g3jsuwkBT9KXF6VYVY0bkIPFozJTQMmp1yLe+SuwxjiVt92Xio2mVtNR+?=
 =?us-ascii?Q?ag7X18EdvoWGr2ndU8HoS3Yj1YUqdmEzgqk1/IDxBFbnaUcu8WEGg3EMunSq?=
 =?us-ascii?Q?vkhYkG4rxYl+iiE2PC0REDNfCzkJP2aMWIgV4/L18LCAfy/JLMtxa5nQUkY/?=
 =?us-ascii?Q?ABGlFApoHRkoVQ0LjoYLk9kXKpnbMrtR4ntf5/tuPDVjONW5Y8WJZT7Hiond?=
 =?us-ascii?Q?hJhtix2kF0LnFpM4rk7XCRGjGfG9+oU8FtCTcCIU6stY9/k/NJWTEFeD+F7L?=
 =?us-ascii?Q?ow2Wo1y+81HmDTWUC43A+znk1B4gOMz5ZcOKrth96Ot95TTAI+MwTHhdJMmN?=
 =?us-ascii?Q?RPmK41tjf2BywURX1+a/0Pp8tedy2AxZklfu2CdVC72lVKrALGGvlKVjo+CR?=
 =?us-ascii?Q?A346rYs3uuLVPxVv+3nNe31udPlmQ83EYsPAUsdMqQApK5wpKdEwgB9VeSHp?=
 =?us-ascii?Q?8PX+DLf79X2KRFD9QlqJOmacGNtFkGjVb3bci8GGzH9Q+lqaI7Kem9E329U3?=
 =?us-ascii?Q?S8rmyR6qWLihRpsqli436WpxcfwAqyFJLU6ScRvVi7d0LwX3Bu7FROZoZURQ?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d87f79-acc1-4fe6-52dc-08dcf26c1854
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:35:26.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVOJ9RADLtI/xc1/lbCt2ef70DFm0iYhkFWHEilaNoc96yziK9OngY6cjb/11k+Lld6k78foY1xlr/QLCFslw1FryF8nOTh8XSGVu3YZ2bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657
X-Authority-Analysis: v=2.4 cv=UrgxNPwB c=1 sm=1 tr=0 ts=671755c2 cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=t7CeM3EgAAAA:8
 a=Q3N-MD_Z_iPBaTEwXZoA:9 a=Vxmtnl_E_bksehYqCbjh:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: DH0OD9HVTl9pdqhfGpUTck5mvpSV51tv
X-Proofpoint-GUID: DH0OD9HVTl9pdqhfGpUTck5mvpSV51tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_07,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410220048

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ecedd99a9369fb5cde601ae9abd58bca2739f1ae ]

[WHY]
dynamic memory safety error detector (KASAN) catches and generates error
messages "BUG: KASAN: slab-out-of-bounds" as writeback connector does not
support certain features which are not initialized.

[HOW]
Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3199
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CVE: CVE-2024-36914
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f7130f7d8c6..8dc0f70df24f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2990,6 +2990,10 @@ static int dm_resume(void *handle)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_port)
@@ -5722,6 +5726,9 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		&aconnector->base.probed_modes :
 		&aconnector->base.modes;
 
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return NULL;
+
 	if (aconnector->freesync_vid_base.clock != 0)
 		return &aconnector->freesync_vid_base;
 
@@ -8242,6 +8249,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 			continue;
 
 	notify:
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
-- 
2.43.0



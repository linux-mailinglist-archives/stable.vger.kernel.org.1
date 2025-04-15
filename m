Return-Path: <stable+bounces-132679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57404A891AD
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 03:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD4C1898E08
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 01:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF091A5BA8;
	Tue, 15 Apr 2025 01:57:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219431F4CA8
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682261; cv=fail; b=NCM/rkW8F+Dx3I1rEwO8ePIRyEPL0SHmVythIUUIMaGDfiKex7AFfyaQCiKICsFfeFA8wE+LJCFB8b39onkdjw6HLU+u2g2pXZY7jorFTF75chmAnO7MaUJpZoFX1tmLuUw1xzMMwIMH0yHLLO93U9roliVO0ilzUDDFVVDQmss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682261; c=relaxed/simple;
	bh=KnrxkPyw42CwcT0fsAoDRWqR/AsHifzd9alqLS70Vso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoShbuMfsa56SSUMt77vE3+l1kPtl2XhtCt/Kz441ZPUJwYxKzsqpZVO3eooVmnrS0TZ5grfONsiUbBkS/VSp+m48eLDu/wMiGJyMVGYH4CrEkg9yFAE+ckxtFYBs3Wflzic2iV4wKpn4x+TKiSc96qVfMYYW1T7ceGXo7y7AnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F1TB3v032176;
	Tue, 15 Apr 2025 01:57:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1jtae-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 01:57:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUM06oEItpoNjyssgGzgHe7dCEBSP2v7U8pt+pdMdPF7aLcxH0ih4TnozGeDm2N9vHltthmjYPZyjrIfiU2f8WSHISShLF70y6+NMvjZAQAjXpFRWPRCXKbw4ohKKDFWqJI7wjkRaLrG0jOo0qRWNfmY3Dffw9Pj1OS6FiqRxQqqV2QFcTZKJjnnB6iB1DoMtoOGW+qyEHgsb+3gXzJ3MzDjSsoPjymdHUk+RUKiAXGBJTTWqJ2fqTBagRKzWqVC8/MYVshdvMXb8MGNW9JnkawrqrY4lN+Eu43QgGZdubAHjWGKBwK6J2DjqaTkWBa1FQL8U6bNMt/smBZ6JXWsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9VwXMvt/b0urrP0skl+/LApEXvHLkoYOTTGeBSdm+k=;
 b=p03A9b8AShxgOQwk4eQ36zzFD59IuCy74C3nVu7EI9TsP+nliBn6rJcBFZIXFM0bmEUyCm+E9GskINi+0m+hEBu4xYgrbpV7AGqit79yACEHqaHn4CxmShHN8fIqnHmrsSKmq4KpCsV+If6DwnREM7t0r6fdyBQLgoCdLI/aI9qJmXT9Sw7EVS9pJjE9udtwOnHS+ukHEerFnyJQ4hBGM7IEgd2FNclV1MgZ4Wpd6qyt7NznhsxaEpinkKCcpr/6bt4/jKy1P9B4hviKuKMRvYG82AJwKhAUm5usAwc//vqZi/0EKaWLuGxvpdpxj894hQ5T6OQUx+TM8fXeA0Twdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by IA4PR11MB9277.namprd11.prod.outlook.com (2603:10b6:208:55d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 01:57:21 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 01:57:21 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: dan.carpenter@linaro.org, stable@kernel.org,
        heikki.krogerus@linux.intel.com, bin.lan.cn@windriver.com,
        gongruiqi1@huawei.com
Subject: [PATCH 6.6.y 2/2] usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()
Date: Tue, 15 Apr 2025 09:56:59 +0800
Message-Id: <20250415015659.312040-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415015659.312040-1-bin.lan.cn@windriver.com>
References: <20250415015659.312040-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|IA4PR11MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aef9737-8fd8-4be8-0a86-08dd7bc0dc40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WKwhVZAQ6Zl04ix+66pmQw/h5F7WT2m/1MADOwBLeN7SlG2iCiAE6U/brzM0?=
 =?us-ascii?Q?VFHdKfDFp8LnswfAEH7QIiAYQFBNpph3fc2wL2DpQJUgQFxwn7/tvK/1nkIk?=
 =?us-ascii?Q?u10arCgXmUbBL4zHtyvUbV1hwSd2+jp/pFDIoEI7yD7yOwIal3Xt0Sl3OPvM?=
 =?us-ascii?Q?Clx9DUyaczOaKChs85ehWImcDCpfN5kUMKzGNqBV1s5yNhNXAOz+ravqfikh?=
 =?us-ascii?Q?mxIxLs2V6g3aLQ/fuMbUF4kEhL0XF97wqZZaIbjA2NvrybsQ+TeDKdQdrfk/?=
 =?us-ascii?Q?TCL7bctKnj0kImo/gIi8iu7P9xarhDqVsEmPA1dc9J5aWukeooyV1wFB66JU?=
 =?us-ascii?Q?XG6805om3UCD2C3Ay2/KHFPlHRUSzklKxbcUadG1wlME1Fbz2F7eUpP/F6Y2?=
 =?us-ascii?Q?V4c2ZAeVDCfuN2N46VkOVXA49UvR+gZrxeZvXjBTggOgq3F/EShbsHzecjr/?=
 =?us-ascii?Q?hOLSWjx4jLz5fpc+oWJVsjmEdzjMcYt2hd3l5+VoCG52fgi6kRBbCf8/C+7M?=
 =?us-ascii?Q?7Mg1XIZTvCf0fqIPcuAVQ3JUcrqZsTT8HEGOx8vvQnfj3mpmuU6dA68UnVGq?=
 =?us-ascii?Q?BjNWJ19A/Ti1ux3dXd+5pDIdV4uIsBpOZu3+7Wj1tsAx0Wxt/Ua3wSCrp52G?=
 =?us-ascii?Q?LTubq5J7zuQJw2BHztSiYOsV3UjmydxKNUnKEXPi9CnQ9nXS4kwfvGT2zo3d?=
 =?us-ascii?Q?ERZClb9qDZkrgqWD/MCoEsMKPLWcdmKf5TEMHifU8R8cDrI7IlSCKo8q5uly?=
 =?us-ascii?Q?RQZESLmgeRcZqRaeMC2mEnlSsxgaTfVRgnV2NPiMCa8aPjXdCwt58N+xeXuR?=
 =?us-ascii?Q?rTE+AiQs442zeOK7P5EG4ZKIRi8uRZn12ElxfMk9rrdnyO0yZErmxUqq1GVg?=
 =?us-ascii?Q?9GrysOIuihj9IKLOpsHaibaPkE1P3Ug6xlG0/PU8PhG8tLXEkUL2CRWI3SS6?=
 =?us-ascii?Q?r+iVZ9+kgOhAnPNVKQ5ywyvZjYsGHF6khvMgjx8C8pcgUl4tsCH5nom8FQXR?=
 =?us-ascii?Q?9+E87HBKjs2/Sh/1kGg9iWVjxmuNGSUOsJiVUcNZreLibcdDHNiKSlJH7SMt?=
 =?us-ascii?Q?M7jzhCS9Z8/gvRpO8VNxwSYM0A8G50nJJJ/Ei2/TjL1lrRK0REt4nHxPHYtc?=
 =?us-ascii?Q?0idYM2+ID40/XJ1ZGpOXM48MHqPREw51FdFScQ6X4FYJWOkQgJdYf5nbOLQa?=
 =?us-ascii?Q?lKFRbuCB2KVPKjti7AbY5oPLTz68OZ5erkrUjAxnLbLGn5puCnhH8IJV81pi?=
 =?us-ascii?Q?8UzWgSWZbYrXsGMs7ZDVm4rJRnSFRe+XJCQSciHojfINXjzTLKX8gE05Lb74?=
 =?us-ascii?Q?ZKmnilSzmpFdogjC+SRgoAXVmLiDcBvrLhYn8WQ3N9VRM9gm7OxG8M3Fp8o8?=
 =?us-ascii?Q?q+8KMbascSz5Tp2QNfn0IhHm2K2SQmlVcprkRJKWYEeWEKIC/WiaB+al98cR?=
 =?us-ascii?Q?HjPq+UQikMA+Sr0CjUOeeiZgc0hspXDTNspwWfmRJr3nkR1LUbpj2GcpZg05?=
 =?us-ascii?Q?jlh6isQPxiBuXV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMFopo02NPlT/j9+A98+rf3P2Qfc8v2SRXLNT1OBlQuxNE4qpQrT5b1n2RRb?=
 =?us-ascii?Q?r2MXu67Q4W1eUCnswOkzLSTK3Sf+NmCWLLxK8y5X3Y6SliChWM9KG3rcEii2?=
 =?us-ascii?Q?GXY3E+ew1ADES5Ya3gMhDTOW5UXMEQlyAFsA2OonmTJgdFw0xLVGdmfxZKvD?=
 =?us-ascii?Q?V40ZaYOxhSkj6kqeyStVMKYJlkfZhCNLCqG8xqh+yhsW6FrcjK7LjhthrJgi?=
 =?us-ascii?Q?rMfU4u1wnGDRWxhuUEI60HgIrnXYWJ57fCFkZjUA+Hz3ZVTz9Th9UE2HQ19z?=
 =?us-ascii?Q?iJdAv9wrC5KZZ9/Vh4CF4jSB6U9OgYnRlx7Qix0vipGW5e5TCy6QS+BChkgk?=
 =?us-ascii?Q?Y0rtSp1kLMDMuhIaG9PSjsM1zytwiMcE++u9RoHNSaPdP5PwTf/EepgLnySl?=
 =?us-ascii?Q?Wdb3qFdnv6cNFQszOx24gcroK5DMclYOucD8X1qLxetBK+xXqTEzL+DIiOOw?=
 =?us-ascii?Q?vlk4tNtBCWzJFzClcLnoEk50W3hn4QRTlFBzFbVEC+9khvstOeWmDgHxhdBE?=
 =?us-ascii?Q?EJwpMluTRyIWfW39bhzy6rjfLULqPvPvXMujsd1rqBfyabxLrmtxFi074bGe?=
 =?us-ascii?Q?rptNiwCx5lUTDwxR25gnHSk5LNLDji0FoWIUUPfmvi8OmlE8LtDBWPUeyDpV?=
 =?us-ascii?Q?PaSdp1+YW7Gto4Hw+HSaA2vWw1Y1kbVlE208CqemzdlyYqXICAOUcabrd7cj?=
 =?us-ascii?Q?Cpz56K/1y1E+yLuT/hVlsOYcW2MdNrzeymswV2PLUYebu5jtbUHhcMoPByB5?=
 =?us-ascii?Q?jMrdjoEEA5Cife1+xfRRt6voD4XgGngaB7AkDM7zprGz3WvlbsnlTG2spvhd?=
 =?us-ascii?Q?9+p/y4MUdLxnHhMfKdhC6fUpxbDzjjL/TdoY5UD/9OH06ZepeqoMSypIparT?=
 =?us-ascii?Q?51NWHvgmhmd6kTKJBXDyY7zRHEJo9aQnPtdm51L9aGN8V15syGFzyc2hUiPn?=
 =?us-ascii?Q?Ri48zOXyMfISqSpccKeSnMCFsDiFe+nkAaa3fSZ1du1k9ML88IOzC/2lR05f?=
 =?us-ascii?Q?yo7l0EyYIm4lahXy6TQL6TIx4mSFA7hj8FLJHp+qwMKihAw5GWnXl+p953Vz?=
 =?us-ascii?Q?aDBdwCxsAEUurOrbM2LAA5ga5+Oyofqz7VM+zqhwJnSMaxHg/Y18kqFjjVQV?=
 =?us-ascii?Q?rpjgTh7uPPBPvKny9tZHGpbSu/vwGiNL6hZzonS+jgauTpzCWxY4lLScC3p3?=
 =?us-ascii?Q?bRwYkwLy6R8xtU2R2dP3y12ezO2T5I0H8OsJUnd6UXygucKKb7Lc9PU6DHlO?=
 =?us-ascii?Q?77yffikpRmeuJ0Gs7dCYFSy1QqZyZSYW5DArvfCHjW4WkVF5U+4SoSyJ7Is5?=
 =?us-ascii?Q?TJVy0XNgqSc2v5hxrkbXVlRj5zyCf7XdOn4V5nah6z66qp/briuClQ+AugV1?=
 =?us-ascii?Q?OcWcnK4+DwMxJDw/OJNB+5uuMell3e6o3kbOfoA38ifUxJDkHogtdd7y8Trx?=
 =?us-ascii?Q?8HRGFRkvLXQxLBiHJMP1txGe93XhpsNXFleDD0jtdoTpjQPxC63MSy4jS6Bu?=
 =?us-ascii?Q?DERd31QapmXNIQAEi+cpV93CXrLmLCI1FaeJf+VFPhc3QxbnLu6wKICUB6Go?=
 =?us-ascii?Q?5FBMA1/hC25sNIhqxJruTv6UnvCFByjFx+FO7eMffstTA+zYZXcs0rWD130D?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aef9737-8fd8-4be8-0a86-08dd7bc0dc40
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:57:21.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgy38ipe2lH/w6Rj666+IuzOTS59HBXw7BKaidWuBZ9nonn78yamaaPvoVH7hrH4IgPVCqRMZOH/n/O431NifZ0S1NO2WAUaNJEqRI8HQrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9277
X-Proofpoint-ORIG-GUID: xbrpaznOl_4hdFnxy-B_Ne9iwOSmBSvo
X-Proofpoint-GUID: xbrpaznOl_4hdFnxy-B_Ne9iwOSmBSvo
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=67fdbd03 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=CXR9pdGyltkxUn7QIsEA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150010

From: GONG Ruiqi <gongruiqi1@huawei.com>

[ Upstream commit b0e525d7a22ea350e75e2aec22e47fcfafa4cacd ]

The error handling for the case `con_index == 0` should involve dropping
the pm usage counter, as ucsi_ccg_sync_control() gets it at the
beginning. Fix it.

Cc: stable <stable@kernel.org>
Fixes: e56aac6e5a25 ("usb: typec: fix potential array underflow in ucsi_ccg_sync_control()")
Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250107015750.2778646-1-gongruiqi1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Minor context change fixed]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 3ef02d35bfbe..35f4c4482fca 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -587,7 +587,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 				    UCSI_CMD_CONNECTOR_MASK;
 			if (con_index == 0) {
 				ret = -EINVAL;
-				goto unlock;
+				goto err_put;
 			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
@@ -603,8 +603,8 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
-unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1



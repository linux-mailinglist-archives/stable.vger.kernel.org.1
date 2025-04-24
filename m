Return-Path: <stable+bounces-136514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05060A9A1A4
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72D4462AEC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67181E376C;
	Thu, 24 Apr 2025 06:22:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34E1B0F19
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475724; cv=fail; b=b3KIjK/hEPUKQ4peupuiAl41dUzS+/acSrnw7PgRNRVqPGxv2rmq1gSSs+ZeZQBK5MnM5/VylC5UT84YcONHlTKuC/UxSqZNznmDpKPX2TSCqb3y5AL3+fy81rzhzsD2xi7xFZrS5SyYLqfjUk8FI1dxrfvsKlIUn8HBJ+Nyohk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475724; c=relaxed/simple;
	bh=w7ypHq0TNLGFKX6Dnvtz94i1AYgu7r09hARXfQtBefk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YwM2UY7Xl9IaPsQR8KIbO0CzM2V+51JPwDpIjD97/spD2BjeNULBhXeXIWwQB8igsVrb1SFgeulStzhi2q6iUDvcLq5poUfQ1lnTz8jrvsUGFsGXQg39xPUzYSS0vWEb4x1sHCX/FZpMrdUExQVn4ekfv2AaeJJ/UeVSAAPrJwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5bDjC005132;
	Wed, 23 Apr 2025 23:22:00 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhd1uh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 23:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDC/g9xQNSm9izDodOGV0pEtTqRcf04KlZeT9ARJ/ValtswEu/EzpJ+HBVEqySzbwj+Hg9pJWtnJMUbfMT4iPoWHUmDz+M+fCAyfx9mXjFCYBaB0bMGLvi+D8CdN8n63OZTCLQlDVuJg8QLT4MenEzkHAmlSVRgd2XO858SGKqf8WQ1t3+iZlOEm7S3WIBIGiPSh2A2W4p+kpMno/F6h//9HSSDjk/L45cblLcWOYu6HbGIawk+zYXoI5dFAFGmF4l4HD0lx1ty8mYYCUpRRzfwB4+6bC5PjJ5D9OYv5gDJ5cpCvPFTBOdHuyVa2ARAqvba+q7RJtxnLp73XWxWWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6x3NAiFSsVdopqge7Rb5AhBS4ZVxJ3tB7in21Lcyqc=;
 b=bLbgv/4I0HmiZ2TBPUlMSvaylkhxvSaYRVpluu7E0pXcv/syP/YNr4XO3pHyXawLfXDvXZmiyW2KnRAb4/6i55p3Rh244sQfyxVoQBYWAEsMrJVyvVMNM0X0L6gOvhzBACeZdsQDkOVFnfniBcC2DKGAQrvrkijpXpOmdaY1Zm4gwvnQnlU3mv0lH6Jg/anCImw0oLAiHGCuJBUYv5UQLVSzrOQq970Um/AjRR3jeVtrbZNc8lT+bHYsK8l3v2DlRhuOHBJ6VAzoDF3+km7avrZbgmSJFG5LM5SuVdM8cTfRp5oP5Syode421mvZ/4VzFSWuDJMxcrdU7HZCM8+0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV2PR11MB6070.namprd11.prod.outlook.com (2603:10b6:408:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.24; Thu, 24 Apr
 2025 06:21:56 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:21:56 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 5.15] Bluetooth: SCO: Fix UAF on sco_sock_timeout
Date: Thu, 24 Apr 2025 14:21:42 +0800
Message-ID: <20250424062142.3054734-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV2PR11MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc43edd-6f3b-4ebf-7a72-08dd82f84fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSgDyIDoJjBGB80CBIJrUDIVfA267x4c8cXlfGQ1oHJowA865oFmoIf/QVBP?=
 =?us-ascii?Q?HPy+wXHwFmQfFB8NrSNun2UuRiQxUsbCOIvreCYxra1DhT+jVQII7YRHA17r?=
 =?us-ascii?Q?om6D369Zgcg6OiMRqQ9bWhMPDPH16bPQyaV7fwiMKdA6FovYdEoWMkvwTvED?=
 =?us-ascii?Q?Wfbs4aKBfoUTte4w7oGzZVYu+CXl5ilTL3w0zOIT19zPc/vJYvkMSi8k7tuF?=
 =?us-ascii?Q?MRNDCmAXexdiLLmefGyG99Iw5eWGZiv5XOgH7wQqYLJ6/JjJTFN5eVSorDRW?=
 =?us-ascii?Q?+FABfpl0yi1Vt9DSlw1B8sRJ1cqcTT96N+3Vb31W56Z7hzYHfZ3J/CMfnZ5i?=
 =?us-ascii?Q?Mgt4lV8XJ2PDiHJrZifmXoaXHwUI81B8ZpgluGoXZkNz26u47r+O7MNlO4Dp?=
 =?us-ascii?Q?XHr04zh81vB2GKe/nZB+zp7AiiKOky2TdNvytZgeBuxeD42jSitt/QNKIuJh?=
 =?us-ascii?Q?8NetfCgyiynpeR9ARFS+7t8wmlszTlOyW/U6r0UXyvXJHQF8AVfa7m5WAzU1?=
 =?us-ascii?Q?s8otnXaVGe9/IEFwBjLynqtr2LcC1SBkn/4TpCzej2gHM/HQFtMUP3aXpbpz?=
 =?us-ascii?Q?ntOXfvE8hgfsu6GzxgnDbVtzhoEcAw6zljAhLAHtn+7k+hecDBrDiDwcd6jb?=
 =?us-ascii?Q?eKoIyCpwtXSjffUXJRkS1vrJc3zt1tXZQGkGz4oO2jAkpV75ISsCIJR0ysnf?=
 =?us-ascii?Q?LELorbxfHmHMFGTGb9ObwwhjOrfzwOsGwtwhGKLofB0XhCbl51OYj7BCZdX2?=
 =?us-ascii?Q?mXp2nkg6jM82MRKupjprs43mBBZ+Ji7CF85tMTh34bBOIJFz2FoUT3z6iunE?=
 =?us-ascii?Q?Z0Qj3m3ND0lk0ZVfs9r/hfxT3a0w9D8XpBULBLvc8BVcA+gJh260UtzFOAdW?=
 =?us-ascii?Q?SneHplG0LYFXCaWGLEWAesmbOYOZGsyQ8t3ddRLF3OLjnZfoUkhnjCjSC7Yr?=
 =?us-ascii?Q?LQRYWlIq3mVb8z4eKfTh3V8F4p58cIBUd4ZTWM+cHkTyIBIesqrTGWz9dp8B?=
 =?us-ascii?Q?b3152Hx1wqwSnn/jExjRm3AKbH0RvFTYB3cC9zhKQtrpfeX/jM8HhefsrSwC?=
 =?us-ascii?Q?i0nxtVcxjphjkxVPn0mtBltrF3cIAYbJSCArjTTD2lQW5oSIo0iCT2rQrpkt?=
 =?us-ascii?Q?ZBD2R3sg4sUMw7wqX1yosNYNHC5Mz+DNqofnfppUf+xWqVw73YMkiQn6S0NH?=
 =?us-ascii?Q?J8iB4r/SrDhiiI4wUNQqtRz9jSVQCxRdZ17xvleSFFmYmB8yRNI99MD5lEbj?=
 =?us-ascii?Q?UbH8yhkSKYTxLvubYauh/glsXMMyoTicoQOewPeNKskov/AzNC/bcrA10uiy?=
 =?us-ascii?Q?Xv6QXZNdqrW6vKtBLjWIKuyCyCOmJf8qtvkrJDHzq/fRFSddS/n0YTdmIKG8?=
 =?us-ascii?Q?DGaLWGVpelRWYQvK2P+h7eOYT+sYWkHWIudB4iMj62fwWpNuCrDm0k1K7t6p?=
 =?us-ascii?Q?+115cmlpzng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoUsqTRBC8xxq4jelgFKuNekh4zruDUtJ7jbEY8lmjxE72xqFdCQ3613DqcE?=
 =?us-ascii?Q?JCgG/3IzVuASF5YSF730cPiks8moAQxJf7JM39KtJoJn45yemYt2CckVpEHA?=
 =?us-ascii?Q?txDOQ7VuYj9Yt4sm0VjMbUgDhO8GSF0MQhl2dnFEPNxUYucqT6u+GdU2/Z/b?=
 =?us-ascii?Q?DmP4UwAxzDiCEmfnhHavDwMRdx0NqmelGK8U2MVlLa8Ufkc49N1HXFK72HFw?=
 =?us-ascii?Q?/OQv6TLqgsb7g5/XAvwyhjOpdYTIQctnR2WZe0yHnF2tkIaSTyZhuf1F7WgL?=
 =?us-ascii?Q?aSaIcAb7xiGuYjK6mNQ5PZEdHRIiMG5Z0kZwPe5sRIxxYU7wmv1sZBmO8Ii3?=
 =?us-ascii?Q?thhFgR4Spsep32qBDX1mCq9lwozNi7bzQ+yxFWGwugPV2S5RirTQWXbVKPIw?=
 =?us-ascii?Q?8xYthiNc1vX6t/j0n7bJgMXIvL2qHGbg2QAFw3rbdzWqoCopRN/E4l9COlld?=
 =?us-ascii?Q?ilIrfiuA4o9CB+i1nyYZVc5SovoAspCe5KFr9rVONwNOyO6PK7LGnGaVIPDd?=
 =?us-ascii?Q?iWnUCSPpgFB+6u9e9+2ZxcdiKszMuRgMl9sh9SugXOdWGC6Gmhj4x3ztl1P7?=
 =?us-ascii?Q?Naz9yOwdc6HHdpQNH7BOkcENWIYca3b5zBJAg8zX5SFQCXmfsJd67MNYdcSp?=
 =?us-ascii?Q?FBmNO+FFUkvPc5HrIqWDoUjS6YhQOxvvsurGmk4NtbPwxAGWTXLvu62/BDtQ?=
 =?us-ascii?Q?Q3TybQTZRQncFLN/3vLGoYRcUJLqQmZGOAIA/yWcDdqwIbg+Rgm79TumlTQT?=
 =?us-ascii?Q?R+iDAqRthe/+AaHIfT9slRukVtJ61SaAouUk5rb8rHI1SFYBNn7AUkEycbCq?=
 =?us-ascii?Q?krXS4xZ5978RaiTeoMgKGFJ4VfoOpVZ6YcajIRYEs4z5aUFt3fuoIZdmpzIL?=
 =?us-ascii?Q?0gcQQ6scmIP7BqeS2Z5OJvh4M7VrbUd9OaI4AhKwbKrWl9/3KF/PVMVRFJ7I?=
 =?us-ascii?Q?wsL4pLuOgIfcrYnj2bFrf5Si9ozWs/60NECtAXN+QS//b6H7lTr2DA+g+Hqr?=
 =?us-ascii?Q?mquPHM8+zlowxo4oWrZbcsVR3sfPnrWbMnrd40JiU7il/Q807FGxlCgRob+z?=
 =?us-ascii?Q?/12R4RB9JU0Yd5HOTMPGzZtavOH1QW1XqKnrDB+ET4heMY8BhASXOVjjWQXR?=
 =?us-ascii?Q?qBMVAPfQstC2SpPnSCsnyG6PiwslB31PgU9BSkH40h+iGBKMxZM+XC9ciBL6?=
 =?us-ascii?Q?o7pHU3EvJ77oozEqzS2chkhKqTteffU3OuvRAIJsgt7SnaymK30IaVbSgBPw?=
 =?us-ascii?Q?KwDIrL4dgjQzUzDDmLmzpUEnIIOIKAzGWL1Q8MQQCS4PdmRJrOw0OxMD+oL0?=
 =?us-ascii?Q?6g1wiTwoEHsI5opE8eqWgXsEYaVjfuUSyr17kHuDXG/MATGvkaDBEZQQQmLW?=
 =?us-ascii?Q?H+DkGYAsqiQV5G9+gCfBCgpXTvl++cZgXsYcXSambryqhtA19sB/E3aQYFsW?=
 =?us-ascii?Q?V1Z3IyF9GvWqKNaYFnaqkNgcXBCCzo956eCw9ZOAC7t3zxMoSWMnHE8NB/gO?=
 =?us-ascii?Q?emEArt5iUuF9Q5UBmeXdWrEFhi7+3/98Ps1tNUAPn0K1stZhXTGviCzI7a1f?=
 =?us-ascii?Q?BqOqbry+UXDlZiGPeY7kpgzNC1hOnS1MrNhbfO8Qx2v3Eb49ZPXSZWKXZwKU?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc43edd-6f3b-4ebf-7a72-08dd82f84fa6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:21:55.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2wYIPdxRz1iL5N8Dt/yt1eGl0ZPF3Q+bzatLBhJV9i0+ajV892JtWLKQXFJYVYFfQxnxvyerek/q4KU6YbcbPg+pREa9pB277FwJNT5BMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6070
X-Authority-Analysis: v=2.4 cv=ZNDXmW7b c=1 sm=1 tr=0 ts=6809d888 cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=edf1wS77AAAA:8 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=9nvqKB2Eg1ZCVVexwvIA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: t7eAreylvCMEW6eMn-SAfwXMvetWjoqX
X-Proofpoint-GUID: t7eAreylvCMEW6eMn-SAfwXMvetWjoqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0MCBTYWx0ZWRfX+ImQvzi9Aewe av04K7WvLEk2oysArW8EDPZbudolse7KbRZz0K8w1eu7FVz/bL+j6eut3WF7PHRdR8E4u35tw8t AmVBEsDPufIQeIcSW/D4F8twAHf/hl3vl8knRmdRglVQYkEa4BdllWqVLmYZ6aKGyVHoep61ndC
 N/lBVD2pkBHiWKaFz/Luujq2Cwp6ZGC/AOnGHIBVqatL3MMrEr1h/uk4YLCSamKr6HKUJ9XJmuf tHt3OGs08b7KnGMCNY0IFQi+rz4XYpXUC42WWvDojtvbHcZSVj72cb/hw5NuUgg9f1mvoG6HnqE 8k/WvBb5RViXYrxhTr02c65aH9tEla+Nyx8myIj8m7E0kkzWpwDUrLb5s3WFKiZiw3Bm5b4mXDk
 YQy236rbRFp6FYaA3okCjP3y9R+/a2xBt5t6VymcJOcEwapCtzDmor+hNsX6dUzvm6hxolgD
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240040

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 1bf4470a3939c678fb822073e9ea77a0560bc6bb ]

conn->sk maybe have been unlinked/freed while waiting for sco_conn_lock
so this checks if the conn->sk is still valid by checking if it part of
sco_sk_list.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Tested-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified on the build test
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 22 ++++++++++++++++++++++
 net/bluetooth/sco.c               | 18 ++++++++++++------
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7d2bd562da4b..b08b559f5242 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -314,6 +314,7 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9c9c855b9736..aebef5cf12d4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -154,6 +154,28 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
+bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
+{
+	struct sock *sk;
+
+	if (!l || !s)
+		return false;
+
+	read_lock(&l->lock);
+
+	sk_for_each(sk, &l->head) {
+		if (s == sk) {
+			read_unlock(&l->lock);
+			return true;
+		}
+	}
+
+	read_unlock(&l->lock);
+
+	return false;
+}
+EXPORT_SYMBOL(bt_sock_linked);
+
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	BT_DBG("parent %p, sk %p", parent, sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index f5192116922d..83412efe2895 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -76,6 +76,16 @@ struct sco_pinfo {
 #define SCO_CONN_TIMEOUT	(HZ * 40)
 #define SCO_DISCONN_TIMEOUT	(HZ * 2)
 
+static struct sock *sco_sock_hold(struct sco_conn *conn)
+{
+	if (!conn || !bt_sock_linked(&sco_sk_list, conn->sk))
+		return NULL;
+
+	sock_hold(conn->sk);
+
+	return conn->sk;
+}
+
 static void sco_sock_timeout(struct work_struct *work)
 {
 	struct sco_conn *conn = container_of(work, struct sco_conn,
@@ -87,9 +97,7 @@ static void sco_sock_timeout(struct work_struct *work)
 		sco_conn_unlock(conn);
 		return;
 	}
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -191,9 +199,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill socket */
 	sco_conn_lock(conn);
-	sk = conn->sk;
-	if (sk)
-		sock_hold(sk);
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (sk) {
-- 
2.43.0



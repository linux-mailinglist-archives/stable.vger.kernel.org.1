Return-Path: <stable+bounces-165710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629AFB17BAB
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 06:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31AA189BAB4
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E47148FE6;
	Fri,  1 Aug 2025 04:07:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB323AD
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021264; cv=fail; b=uWDScq/L4C2VQXyOqhjg6pKwKx2qQ0Vfqg1Ic2XQVV2Sk9FkqU9YrIs0wJro8isRfJwFG46aRqOeRt1z74L3N1MAjKO7Vg+6iSS5yybLxrKGmFgbokqMtbNFO2Jt0QQLaiuD7PfiDUFw+4tU6fMPqF59tThlXm5dtOAFdfOSfYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021264; c=relaxed/simple;
	bh=+vCrbdiZzkffksmpbxIQoxhQ9DhxEnPNLRam5F31Q/o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rMKcIAarkq4g4NgizLt+dMTkeIM54kBoV0OSWS1SpmN7mMT875Huy4r1hYHGPJklVI15VTGCmELlNM83kK4gkj+TGah9mGjTAqCx7uD+Tp1Y0z2bH9Al8xJdiobDHJO7h2Avz4rCCZ/fdFpw190UntsJsJD1Ck/IEsy3Us0ISX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5713mrDn3119337;
	Thu, 31 Jul 2025 21:07:26 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4888hggs2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 21:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANjYB2bAn/atYgDDOh0xQq62oAUhlJSp80WRYTNphzGrOzTmWcReKyYtXuGjf+m9QYDVCX1PZAYxmnSjy7zrVwuoTVOS3tptF0o2Xaintj0F8BLbc7RpcMj8hlan6YxfmHm9Vid5Ke/WePIsZRjFJ8vgZ4qTwcFNvO73/t/NcLXRmturF+QhQ4eGgOdnyeKpQFbiEO9atH4JEi+Nl+0B8/6QRCmd2/PD8AqkeyJOYzKCHM/AOKOKcn27NdEWTsTfZFQP6Im4pnunluIVV94zBkNv/Eu1wE1pMclvxA/LL/E+mihwnEXgr+xUJv4Sn7NBqsENNVDioiwy1jlWwH9YEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkn+rPvJXG6eKktpR/Vjd8MUZUc7VfM4tJyiTrBkhCQ=;
 b=cNRSaaZse5z0su7fn2Wnd0GetMFwMMxREkzCOTtdaXJpMb0kqaTPUNA5g3H0xFJe+QI7WX6YIoQTeePhtzTFT9Iayw5IO92oJJVhbz2zUAlddLEwGULRfVWq+Nv+rx69Lm4HdhSvIUvGWsmneTiPRsir2ZBuPQo/mO1BWOoBTX5+/mIZDZsgi4exVKy1FIj/Tp/MnwnXYiZgDZ0FVhG3Tfh7ulsJAR3zF979IiYjMRoeyLQcox5qZ+Z7v0a9dRUBBK8PVDpN4R9BVF7vs/9VdxOJMu+UlJEhzTbdBdNeROsSKPldOJPIfzHCa3Ry69oD8ReXWBLr307lWW10UqdwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) by
 SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Fri, 1 Aug 2025 04:07:23 +0000
Received: from DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b]) by DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:07:22 +0000
From: Qingfeng Hao <qingfeng.hao@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, qingfeng.hao@windriver.com, zhe.he@windriver.com
Subject: [PATCH vulns 0/1] change the sha1 for CVE-2024-26661
Date: Fri,  1 Aug 2025 12:06:34 +0800
Message-Id: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::13) To DS0PR11MB7959.namprd11.prod.outlook.com
 (2603:10b6:8:fd::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7959:EE_|SA3PR11MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: f3089d13-ed92-433d-940f-08ddd0b0ea9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXRhe4VT+2GMhfpsjoJsFiY9sZajmE9d2VdVXiKXZNJOIb6TIkX7G0vOCv4f?=
 =?us-ascii?Q?M4XmnSJXtSFoklQ4SGwWBFziyF95kVzIm9uHtaVXVni3dLvHC/8chj6Ykico?=
 =?us-ascii?Q?sgomQtxBJvL3QcoMrLqNs4ABDXKoLal5pN6In18ZTII8XHGUinEsRS67lKLi?=
 =?us-ascii?Q?uGBOf4+Y2CzOyCzzyJyeydt/1Ji18mueOelZtAQ4nXIgGlDZ/OKB/s863+sY?=
 =?us-ascii?Q?nC5m4sy3HStKtx7AZMyi19lRqqxPA6mck2yxZJg3AYuxb2wEwyIkQc+IskJB?=
 =?us-ascii?Q?94VPi2yS5uPoR0BMNtDVqFwCNijhykpcBSGvIf4Klc5YG0F5rm1NWIftknWM?=
 =?us-ascii?Q?HqZxjBs0VQN3BH2vhvw2jp/vHsGW1h1RX94tkGH9rdnzMp69n7OtomymLjIZ?=
 =?us-ascii?Q?Hh3tBXfsO1DFCZ42HGcG5Hubx/5QgkAk96ighB4wh6EpH0uRG4rIDHuDna0b?=
 =?us-ascii?Q?9jPAlE3uCqEIA9dEp9nHOQm8KrjljPcO3Q6KP/XL2i94yYvOkWLXYhclgzVB?=
 =?us-ascii?Q?qDocWRDLXr327l3aozjOew5Zy33H9d7GgabPtcT35SGKmNR5hEqTkZC2TqfL?=
 =?us-ascii?Q?R1DLwqQK1eGBOCk58HOf0cft+F+h3OSRRbdkfol2i5V8qqnv+M9QXVZqrpGz?=
 =?us-ascii?Q?aia8WhLZ0an+sALl5ZZKw3FZRsS4ACLlrMnxfLwHuzLkeD6dICajSSDx2k7w?=
 =?us-ascii?Q?Q1L5rffZq0HJJJuzxMKZ3zVdP4xk/nPBxC4MdoUQtMulfZCDSD5XroD4wa45?=
 =?us-ascii?Q?/wH2sibf5T+iJTATyV/hgQaDP3F80Wq9PMGQdlmB+IxGlLpkP5BsoHC5CYL9?=
 =?us-ascii?Q?SlHFFnZimbmcVVlf0lziLkKSwiF8diLkq9PoTf057CKeHAhWVNXiNw24qUZ3?=
 =?us-ascii?Q?NSRitqvF+QF4Azgo6e6k6zSv1hTZtOt9B496PbtZpSfqc90hhuCwuvOJ+kQb?=
 =?us-ascii?Q?aJZ3L95TdqMTYgIf0a/wdHlj15YnHhzlxRtq89iiU1Lg7kx9h7d4zY78EFmU?=
 =?us-ascii?Q?p9Ndh58Ue0LT6MQCrSJVPC0qBwJk20FE/XqQ7kTDFfXMJ3Gz6Aibdm1WgUnM?=
 =?us-ascii?Q?S5eSYVhreV2YIMmX2dftcVu52g/R4Xmd2MVg4KFDgqq5at3fKxQx7wkzARoZ?=
 =?us-ascii?Q?NzgrRtrA2lfyXIbwajrrP2jcMNuqqgzVpS00XamKf1KfUCijcnkamdk+v+ql?=
 =?us-ascii?Q?vScv19Nb6E7gpEiZMiC//guOf79fKZhzMbNmwh1R4YXtLWe+NhHr8Bv6rn84?=
 =?us-ascii?Q?Q6+MbJsNW39n2nFUywfODR67UEMh997oNarxtkKm2z0ERzDlbSDoYuDkMcuT?=
 =?us-ascii?Q?C+kem4c8maT7gavoNEHddOHG4BSJoddTriBxohteXxhWPIxskxfROKyAMxxt?=
 =?us-ascii?Q?fTu1cES4feas+sK8o2xEgQbLL/LHXN+Uy5jMQKrOQNft+uGL8usn6DYloZMN?=
 =?us-ascii?Q?tLvMYCRmP8EDjPo0kEd/7RWtKXKD3xO0c6dWYrL2xZ9aNpYz8wv6fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7959.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2sFuEDgWvRXdilS9eRC35ykvmrINy5FJ52aAXfhzmqbqwQR+xrLILVEUvwK?=
 =?us-ascii?Q?teNkrFzTCtHAPOJZq9VFDi9EOrO5SGWA8HDiH89/PnTLDaDRPTUXaYibZH2j?=
 =?us-ascii?Q?3OiP/A87TRqo7R8uVu4f9d63vvwIOpq2gYtxiXtE54KPysWtZQgG1+UwiXIq?=
 =?us-ascii?Q?80wfMigucoqKa+w2worzFU4crLT5zg0irQfLHRUPQtwY9pB7pCBUhlXhXMqj?=
 =?us-ascii?Q?v4B6/KqlR5xWbkH0kKWYgNkWIlhpxK4EzETxEweWA8AQUhmlDHG9n+NSJELM?=
 =?us-ascii?Q?WE83sRCOzc5eRmc9fTXRoCTWTsRyCU8+LsfJrB5nwQ/ZgbegULG+FRtsrSfx?=
 =?us-ascii?Q?ONgMx6AAG7zM3vvztfcz1kiX2KFdw5+AJHk89J8md+gRq+2KfOVZLvScpeRX?=
 =?us-ascii?Q?XCcta8zZ92jb31R4MmddBb4xlNQHfkUTcVJgXzhWDe9ZcIYfeAi3G+ke1U4b?=
 =?us-ascii?Q?A4DMKk2dWuoDuVZfy3oL5MnCHFLymKqa82XLcNJfIYHHcpBLuFNf2k/boiL/?=
 =?us-ascii?Q?TSGM2nnP4jITPdlLIzLSikk1iV4X+r6+MVBe928rWrvD7Xowg4ABGGU1KHiV?=
 =?us-ascii?Q?Ww87aH0ETrdWT3s6LMVsc2NMe3S5dExKrcPfzuw6oYt//xAp9fcLYHjMwyva?=
 =?us-ascii?Q?T2Ge+S6oKWx/WIfqCSXw43S+9zK85tADrAUX/WI7xewAcWEnBQXWdl9mAnvY?=
 =?us-ascii?Q?yb8Ss7VvluawThj2GNyrto2JoZmdRgt0uxmidJBvYl2xgyMS261KOpPTF6eG?=
 =?us-ascii?Q?qYt82S8SSTEgQQejE7PJiIhccX/XJvFfVfu3TxWx820wZheq2+/NB1jN/qLh?=
 =?us-ascii?Q?Gs6yrcrqolYEDattVOESi1a+hWnDfWDDjcj97Lmx+4WvFq1u2n7f3iOs3Eaz?=
 =?us-ascii?Q?m9kLaaPpU51QiSTy+1AyS1eiM9hrWmvluvF/mp27TVAWXCC84O0b6wFQpH7i?=
 =?us-ascii?Q?k0nKgKsDeBJsBU63VLgf0jB+VJTZgliboTSYRF6r+88nl6vsfT7H6VaPUWzZ?=
 =?us-ascii?Q?QccSRTcQnMO3kffnm3MU3Z1PVhCrLg6NnCHl9j7Gd58I1ujejqpUgwRH/9B7?=
 =?us-ascii?Q?5ZwRzhVKT8m/2/g++25BFRKsBtmgi8jj5YO9Z99AoDArt0/kmSrhgTMGdk4d?=
 =?us-ascii?Q?tK6mZJsfexKzJ1uYtz7y2+OTvyJoFbAadtP1Tdzf2DctMeu9rWOncTrfBfIc?=
 =?us-ascii?Q?8P56k6qkv2u/1m9jP5O7VNfcSOi0c8ANC6kTlS2pbwLBG/z9Snt1bK2AK6AI?=
 =?us-ascii?Q?Eaz7AzQoDi7erVLVs6roV7mFgKYPIa4rfGOj9uUz/42LLxY2DpFpn2rgHX5T?=
 =?us-ascii?Q?h1U3/Eo61iPKnPQiZ9o0FpQK3y6molV/39MtWkPfIKGmjewPX7m4D2U0EKx2?=
 =?us-ascii?Q?cHpMwMaQioy2gt4b/gHdRRs9H0WbjZX1CKpkEo4olQdIfOsznGNM6cTEsrkf?=
 =?us-ascii?Q?H/0DKiQ7Wn11LFNVKjEWFmeXEgXLlRJmJ6ND7U6wtXOimpxkVDiov2kVVDMf?=
 =?us-ascii?Q?W6TdKset03fFhkqBAlClnizpWzUkxEm8Wba53Wl+xO0uZzWdRrbi5j4mM57c?=
 =?us-ascii?Q?mqJmeSn9Advv49WcbAAZqjvJdhHucy6jYWhtjeIwhFUMFXLC8fXcuUXS12u7?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3089d13-ed92-433d-940f-08ddd0b0ea9e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7959.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:07:22.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O0+zRk7+ISjHW0ZOu5PqrqWSthXkcCNj/fsjMPNtz9ry8//JzGAZ8pq320JAql/y3eVpkOXKOxWtxFl9ccMnrDJY8Xo5fgztydfLgNxurY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-Proofpoint-ORIG-GUID: cNV8SPXytbPOX1phOIfLB_ZCRlEDnBip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyNiBTYWx0ZWRfX/G0MoOcbV+eg
 VuMDykivs16jt4Nj1Lh3H3AwnzpndJOO6EdbU0402TKjWn1FaSKGlcjjhDzYFMBiXrm7w/Tj96t
 vJZNZKMqKGYggZ0u0XUISPIINTcMqHJdK/2oR+IzcBtkFglbsayA4X4VXSwLjCLH/91mUm09eGi
 rXPegRTR8rwY46p7vRuR3/Bdm2GgqcHRD67UZpBRX+ERMKMitP3ri+D9oQwYI9E+nrvBURMpu2D
 pq0qLxQ8/eUzdEmDFIH2ClXymw1ZiM7vkUeaFOafuEwn3zFO/fW97yGDiMSmefTuzpx0HShrSN6
 Eof8SVF+475rfw+5XtXZSvZAJTjd/uuG8MNSKKAxgJHrdz4XjMeXJXtMef709Cn0okIpBwMEcwZ
 XcHP5WwM
X-Proofpoint-GUID: cNV8SPXytbPOX1phOIfLB_ZCRlEDnBip
X-Authority-Analysis: v=2.4 cv=SreQ6OO0 c=1 sm=1 tr=0 ts=688c3d7e cx=c_pps
 a=degLZM9eBZQX9z3fM2se1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=RdrffxUBXpdhaUOeRwQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507210000 definitions=main-2507310086

There is a fix 17ba9cde11c2bfebbd70867b0a2ac4a22e573379
introduced in v6.8 to fix the problem introduced by
the original fix 66951d98d9bf45ba25acf37fe0747253fafdf298,
and they together fix the CVE-2024-26661.
Since this is the first time I submit the changes on vulns project,
not sure if the changes in my patch are exact, @Greg, please point 
out the problems if there are and I will fix them.

Thanks!

Qingfeng Hao (1):
  CVE-2024-26661: change the sha1 of the cve id

 cve/published/2024/CVE-2024-26661.dyad |  6 ++--
 cve/published/2024/CVE-2024-26661.json | 46 ++------------------------
 cve/published/2024/CVE-2024-26661.sha1 |  2 +-
 3 files changed, 5 insertions(+), 49 deletions(-)

-- 
2.34.1



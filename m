Return-Path: <stable+bounces-121379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35202A56870
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFBC7A187B
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2521766A;
	Fri,  7 Mar 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hn3sqhdP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RLgu4gx9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E62940B;
	Fri,  7 Mar 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352717; cv=fail; b=p7Geb+CFkJS3dYd59BOXoML9bG1vbi8vjzlj9TdT90jTuxwOMX+U2qGd81bnLltRDNkTksBc8gBMf0TAF1aBvx0ALseXX2h3d0fIMRka4MZQzpqwUXX3IRxiFNTBjMQjXQ0K+DLbsWHGR4pjiXPeBThHeRtJkTWqQvqbLI0EuRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352717; c=relaxed/simple;
	bh=UpczWxtzVPwsRYLsd0Rbl4bzWLRy2rCylQSQGV0bZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jn4kknH9WGGJuAjeDA+hXBB+lJfQSueZMwG7prI2whELFP15MJvQ5r8c5+qHE3Q7e6rXABthMkdaogBxg7lOLZutb+GzmkwhW+QILC2sC3ek52JmYEn/VPuC/2wErPCNwcWV3mpTCe9YGasj2F74iV0XeBK97Zx4Z+pm11q2ci8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hn3sqhdP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RLgu4gx9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271u2NH031499;
	Fri, 7 Mar 2025 13:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=n0fwKgudzheSlnzVGC
	u1yzcMSow1KyEzps6AIzbk/Z8=; b=hn3sqhdPrmidnvjW5tQKJvCen5saxQl+YI
	sXLabLQBC/AqSO9a7/ccrxByAjruLiHlvOC9SwbzWR6Yci5YZwHuCckyOQaqkRME
	HmbD8jgTFs2vUwcaty2gWj/yUNN8KGyWttGu2EnkWVLByzDeHl3rBN3HwGC81pj5
	EMVOvaDcBc+tvYz4LHuNJusLIGSgE8xkrYA/aOVaAihR8/8jcUWYqsQvTG6H3Twi
	yeeNzeHNRXGX+QklP5jVMH+lCGYjfqbKfz6wkAB6eXip6/abaK38twBHIfVjCu+W
	Yeig3eVQg1N0/N2xiArUPNTcFv2CZvu0viUG/1jKr1uufmf1YOlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86v3ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:05:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527CO9bG015762;
	Fri, 7 Mar 2025 13:05:06 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpek28w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XECKonIU/8sSgOZ4gScPw6p2vvT+Iv+BK6dq0WPK+RkSPyiOFWnuhiG2BGhlOEuKue/mWhtXSQbhjgqeEJp6R+p4bDdyKjc7zYiyIaQg1RzhTBnwkWun1cJ+xnxSEpYl09SwpA3whGqzoL75qAOqDL44O1VNRdBtBRcByyndkoGd8u/9I285lsTia1Q/ndXH1MkhFEGyVZcAkOexU0EW+X/4riQ5SrblOMHvgQkR5P2XPDgedsAA4oILS2fnu6XtmLTfAK8lXF+JhTf1fmsflFdwa5p6+/BAF0E14vRIluze1yuNdjZHHJAA4sD8NrrgqXGxYrj8ZklkxwLsBnjYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0fwKgudzheSlnzVGCu1yzcMSow1KyEzps6AIzbk/Z8=;
 b=H6QkQz4HH+FIDaq6IJDXuYzIemTGihhI55PLryXcxZG+bK8kU7AzTn3L6pxcKZJ0ZnCmP0o6y29B9OowZPOn5nrO5LFdhQ/5UROB68+4eGdcJeE0bhBKTu/WXvDVRsv/cdyaobbCDF+htO1ZJf8VcrLdpsmQvE+zldfNIfj4gJWQ5K1ajc0sIrrGFwkyBp/6sWZfgGbM10Yq1jqpc1zsURJVWEr56wUFZGm0EX3RCRQUjsSnF86VztWbDp6rJ010QB+2rKUEUEPy2FnpiOO+BTx/dND1vqh9zqgXh7fn9vG0Zo9hv/UFnxF07vdVwqY9LCa0ztRwiid/TPId0XCRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0fwKgudzheSlnzVGCu1yzcMSow1KyEzps6AIzbk/Z8=;
 b=RLgu4gx9qZE5wdUpWg/v4oxobrgkGTY46RARmRRRPnXIonIztx1wgefHXg71Mmefaq26k1ixLuxUu95V80hBq4Y2OdyekgIbT6XJgiexNmAieNCpMSn+6DjUNYuZeu3itARFWIm8UqW44N+hLxbCV+X8zURyDzbSMED1DOXgn/g=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB5565.namprd10.prod.outlook.com (2603:10b6:a03:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 13:05:03 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 13:05:02 +0000
Date: Fri, 7 Mar 2025 13:04:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] mm/madvise: Always set ptes via arch helpers
Message-ID: <dbdeb4d7-f7b9-4b10-ada3-c2d37e915f6d@lucifer.local>
References: <20250307123307.262298-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307123307.262298-1-ryan.roberts@arm.com>
X-ClientProxiedBy: LO2P265CA0405.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::33) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB5565:EE_
X-MS-Office365-Filtering-Correlation-Id: 44af6571-318f-492b-1a74-08dd5d78abe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27xAqfx4WLtWTSuKqSdfuwIOzsNh9Q31fNFVqCwL15X2yxmvr+pGrAm43ESp?=
 =?us-ascii?Q?DdI40J/+OML+gX6yvXaH5YwWut8z8IhUPrFHWcgqdMRcgVf0eP7APeWpYTA7?=
 =?us-ascii?Q?pobTG2BDlATFwHcou3OVSKElRouvsgzYCGgIxrZoXHds2Moyf6YrHUVQ58VY?=
 =?us-ascii?Q?3mLAa+bfEi/ZgOfWoqcatlxaiBphDPqNJ1BQC4n+RPXI+36QZXJRMd9tvNm+?=
 =?us-ascii?Q?F19914TIJalH/TltvlehBYam5P0wpw2vctAiUuspCO1I1lNu2KlVpYtcvcE3?=
 =?us-ascii?Q?hREu9XzOOZrVucttAA+HZ4e81r/GQK/tWHfRU0sLWIkL1IJLfuMUg8ST/kJJ?=
 =?us-ascii?Q?uoQUDSZ/rlKOn7hxMV+KnTrtQ2L4AM3OWDJcer1EAnA0xc0FsszcWYMIC796?=
 =?us-ascii?Q?Mvxd1Dx8MvdVxVodvxsOH3eivbFngBSI6bORAGErw3mRb0jku1FbCD8ds2qH?=
 =?us-ascii?Q?1KKP+xSbS1+xWhKbnpWQ4mAQR409gwUpQJ6t6XRKStd+godVM2gbs2uTr1IN?=
 =?us-ascii?Q?yt+pzP08gMrFFX7DOC/X6ntMTEj46r5rlvSj0bwEVCOTa5k9DvaoWqqrf5Kb?=
 =?us-ascii?Q?3BuvuWlrfNyzrLhqIZX0Cmsk2YzXnjDjmv1DGDmsnp68134O6x07C5mMsY3y?=
 =?us-ascii?Q?laWQSwagcfXfMNyeCm9kZEUerumb6ZdgzkshS73Dv9Au7wV5sqzQSerPQmdV?=
 =?us-ascii?Q?ENKyQ1CEy3X3U+y+07qD2s/j8uO0pJR2onb38LIR1MGuNIk8aG5kHWP7V4Wv?=
 =?us-ascii?Q?l5Bb9qt9wWeI+WL8XAxOcx3loUrLWyEGomFaY3M/euK88Uc1LMhx4pTK7kJK?=
 =?us-ascii?Q?fTyXYHksyOa/335U4UMJcYR8Nulb0eDw0lvzBJbtSii0r8vwSNVU2ntvqFRe?=
 =?us-ascii?Q?rI65Kgr0YV+sH9CaO7Q6TZCYfUxyym13lmaJXc0T3ug8rtK9AecicMp4LlDn?=
 =?us-ascii?Q?d/C/UatRAKChBbIVDQBd7aKhjHVS+kEpSs8gBTA2ZrxHDDCHZ2ePR/xs4D53?=
 =?us-ascii?Q?X54rDOmD79daT3fMKNkS3x1T6aULfyxfQwy1/ze6+/VUaHfuGOIXBT1PMZKT?=
 =?us-ascii?Q?93EhUJ1UmPFl7LEIwwVAIKuEvQOKbHScEWwY4C4YbC8ArY5sZW4xLaCVYkMD?=
 =?us-ascii?Q?UKDfd0Y241t06hzBlRfVwBncPZKj1+3oAxWTzzpWWZtl1lyVHuaVu+IXFmyJ?=
 =?us-ascii?Q?LcA3LhFLYDcct3Qu78G5UVjmjastlKMZm0nYEUpl849On9GfeDLI4+93E5l5?=
 =?us-ascii?Q?tmarW0qMPu3SmyzopEREygietj3SYYG+9Gp85tOVnE28z0aoJ2kJYmpDO5A4?=
 =?us-ascii?Q?V3Quk45fD3VuomEK8S/xFfpZYDf0+Yljxd1xl8fGWiFzRYelpPmPbhA1yiIb?=
 =?us-ascii?Q?m8KpKSOxgRQ2eU8mQ5H4tixSeNpz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5uGcnOX6A26K93UHMq0Y4TqAQSBOcd6Dpwsk0nhVO+bkPm7L1r32X1QF+sG?=
 =?us-ascii?Q?HFekWKuXe0tcSDM3Gs346iq2vdInnFrVqQQn7gz6fv6ECeNmDJ1agzeY8oS6?=
 =?us-ascii?Q?AS2pD6eLICbR4rTuPQIdlnwGraAJCcOLVl4faPzhgzzq+mZNoAh3HUuFtSkv?=
 =?us-ascii?Q?BpVulVLfkB+D634Tf9bWKwyQXk41rUbKRCuqBGO1rsAcdEMA29Ky8VIbxF0N?=
 =?us-ascii?Q?VMWybCBSiKd7nH42InxdakKoHebHeCtFClCU5kw0TRMiR/il+N8RO5IEjA9A?=
 =?us-ascii?Q?vMZNFZM7U87fLpktjT/QkJs+YzvA1n234DQoX6M9fs1me0ArPU5nuGA86T2d?=
 =?us-ascii?Q?dnfCdj57ho/D7UJUCGiOkaD9V+Ody+c8YOnZayMdivH3+JHu/rjs+5kN2rAE?=
 =?us-ascii?Q?oL4Hq2EYGFbj/A01u+5TkMbnsp/9NwB24d8nTSTKpOdLRAOrEgEl9lZ2azp/?=
 =?us-ascii?Q?VKwU4U0+5a+VS4VwAN9FYKflgklhJSZZgbF98GH0RUVZYYHU06zH3FUWosBu?=
 =?us-ascii?Q?wEHb3C6SIoEaaqxN3Km7ZhaeJ0RoTdXaHFjooTQbYFnNArRsU1Z0K0cTWy7z?=
 =?us-ascii?Q?AjoJflqcmZWSjzbtDn1+NNet7daVuHsvgb+1Ab2gBKIcjFfxpRv+i8tnfR7I?=
 =?us-ascii?Q?ddlEmBZ/GVqXX1gmVhSyxQ51zkSH8xPcyfCE8cIzQ/7jRzLoiwigKiXQuXR+?=
 =?us-ascii?Q?aklpLGzQ4LwxBHhBPMFkP0ZcRoTmnwhW7gfR6z57KFvOHWdeozqUUBcsD+XG?=
 =?us-ascii?Q?MDX0CNXzPQ1/86UKknni9JAUR4PFTt2tOa4uF36pbWJkRuIpxtV/SGTh7Nwz?=
 =?us-ascii?Q?qx1rlb4fjRksl9s5QOum6VmGtbIamCpGkX3jklFtpyMgW/8g6H4Jz5/eh9eg?=
 =?us-ascii?Q?EmlNojAqWiL+9xC/P7v1ZRd/gqFT+Y+HY6O89nz1Q9knCg5GQAQI8CoAcJnm?=
 =?us-ascii?Q?0M3FWB5Izc4is/wVJZFsK3ONyZ2Q+eTUZktH+aQwhjwNJtbonJH7EhKnNDqs?=
 =?us-ascii?Q?FcgP1isOuBUjSWUsX0jFw77gROPsAocPF+Ct0VIy/FnVlvdrwD1B4aHrqZ5c?=
 =?us-ascii?Q?6ZDn0ILf7lpGQlcctdKfwdgcdr/FoLZ1ydOa7PebnmkqUNcsQWuDudp0NN3G?=
 =?us-ascii?Q?Mo5YzpzjWySTLdQjyKGcpYniNjCOrmJF4p6iMFeae5Q470ZOZIv1hmr8bPYF?=
 =?us-ascii?Q?pp1r3TJq2amJ2kg8Me7e+9Q/rXTOGnGWtI55pWI3RkG5RTdpGQD7aGBDttUC?=
 =?us-ascii?Q?8yiVdvn9oP5ABNJ9V1UF93OiVp7fYbbtPiy6ZxHcK9/2eDmAQQPWre8nrJEF?=
 =?us-ascii?Q?2wzEfEaeuKG5qW0sxamOh8EnlvuPrNkyqXLya5wbH5jZRhD3CHTp4lPve/3n?=
 =?us-ascii?Q?QQYUNJIgiZxZ9sA3jN7XcxXtCdMsxHTQKUS4fuEekwR27B9SsOlZxUPAd6aX?=
 =?us-ascii?Q?OzjdYZJVZWcTQ/QpiXZOXq0P6Jm0icE4y96MYqIk1B4YM9LnjiuR2XXhMIxJ?=
 =?us-ascii?Q?+blnJe0XpHpsIJlPFzjze5qrbye721RNomE2/Y34YvmPuVHJMaSgiYcmbMuj?=
 =?us-ascii?Q?b3h2bvo3/55pQt8n6dVNvjD19+aJ2WftrfJe1VEz71p7GHIkdbihKX5R9N0+?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yf/OYizKzo5VHw3xKA0Cn2ZRC/DZlUEAkSeT83hVVak9rRkZHvR5c76w4wOnpfrRLPoP0Oox0O3WM8l7BLQkZRUrd2oGpxF9bdsJJ4BttHE2yq/labhlLezDxWhmh8SlGAtnx54avNdDEUucmfR5L60o5u0dIb8lPp1C4oOGsgAzyx6buWKOkKFnoG0vQ4ArkJEiHYF6Ktt8YIBcbZJDIxtDoIw2eV/VGbyEO5kvgTTRhVSeiFx67gBHqd2uibaPyy8Kh21X0U9Av6uPSsoSXez0nOCK4wpqHUG2Znx4FUsYHUm/B/RsQIu5D/zSpwTbXK7SNAdNcxv9yZxlTVE+mKXGL0aFMQ2gY8KIWKynqlnQuGVwjcK4hOH3/H+bDF9EE/jzTcVb3bAmEeQpUDiZRgrA8AMBGJQWX5XXpduSrqLwXbL/iSCVrLj2EzKe0+Z4eiEEk6blPxZI+XljfSjWZg2+60VyOvByLcyEX/dBsVBPsqjsACnIUeM+8/NiTEhOPB5uRfslHxICv34zrXHV3KY185vXE/eyyQi4GJF7gtX9GcT62W+2q5SoAXPoKE/SbrrkwlQFTh3yUUZIazGoJufpm5fJQQd19RnLSnjcbk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af6571-318f-492b-1a74-08dd5d78abe4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:05:02.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvfX3S7rHLyBLD2Dz2OrtHdoqgqzBeJLfEGLjwvs3W3pQNFBMD2uqB3G/2dP7OzGxqbDsrBBfob2cJe42HHYYQT2U6t650g0pxRnoWs6bgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=845 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070096
X-Proofpoint-ORIG-GUID: qrX43TuLFdw7XJ7iyV14QnrArFU6CmJQ
X-Proofpoint-GUID: qrX43TuLFdw7XJ7iyV14QnrArFU6CmJQ

On Fri, Mar 07, 2025 at 12:33:06PM +0000, Ryan Roberts wrote:
> Instead of writing a pte directly into the table, use the set_pte_at()
> helper, which gives the arch visibility of the change.
>
> In this instance we are guaranteed that the pte was originally none and
> is being modified to a not-present pte, so there was unlikely to be a
> bug in practice (at least not on arm64). But it's bad practice to write
> the page table memory directly without arch involvement.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/madvise.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 388dc289b5d1..6170f4acc14f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1101,7 +1101,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>
>  	/* Simply install a PTE marker, this causes segfault on access. */
> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> +	set_pte_at(walk->mm, addr, ptep, make_pte_marker(PTE_MARKER_GUARD));

I agree with you, but I think perhaps the arg name here is misleading :) If
you look at mm/pagewalk.c and specifically, in walk_pte_range_inner():

		if (ops->install_pte && pte_none(ptep_get(pte))) {
			pte_t new_pte;

			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
					       walk);
			if (err)
				break;

			set_pte_at(walk->mm, addr, pte, new_pte);

			...
		}

So the ptep being assigned here is a stack value, new_pte, which we simply
assign to, and _then_ the page walker code handles the set_pte_at() for us.

So we are indeed doing the right thing here, just in a different place :P

>  	(*nr_pages)++;
>
>  	return 0;
> --
> 2.43.0
>


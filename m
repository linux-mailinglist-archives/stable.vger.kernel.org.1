Return-Path: <stable+bounces-93526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5A9CDE66
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D9DB23BFB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D431BE87C;
	Fri, 15 Nov 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/DDeoNm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6MdOwnY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD41BE251;
	Fri, 15 Nov 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674347; cv=fail; b=Ajs/0KD87VjabkU+aT3s903AvadkgDUZzVFVBzm/FRH02XlPztYyCpE9+2avY7CAKGsgbIfxhIFZKo1eAa79eis8JjoIbB4b/sPoLicKNlA59Ly1PVnM4jDHlPLqre9gZC4z2dimGwuD253qZ3mSqhZkc2DUPqIlSYk/OEXlSls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674347; c=relaxed/simple;
	bh=Kti3uNG7aFoGpzHXxfC7eO87Vzr4kHUrcn7f4Sa/hNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHhvuPs6MqFQ70R2fKeJ5b6QB2sLCu7f53ocn7hCyDLd41ck/41SJO8Me4H/l+pkR4sDAXk1QJNSt1toyRXrvKlsJMkd8+BfPYC2aN+P0EtkiggGQfa5rxtysaemiCFcnrgCEjDpLmCQOXncjqEJPayWSzGX9K+GDbHS92npDGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/DDeoNm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6MdOwnY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHJXb000670;
	Fri, 15 Nov 2024 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2hzJyGd7ND7ALeuDMST/ER3oYgX4pWOPUyctcPhuIyI=; b=
	X/DDeoNmCV/yVvjp+KNdjE4YqXBAdXO/F4h3u9GT7jNtMDnVFFAzF+en9m7zT7KS
	RYLXKd3EQjxsafCTFY4DO5Yu7jGn45UunTbGnGsEHP6rVdlbrSpTrFblWIQjmMNM
	giTceEUgK95vTYePN9hpAgpP1TMtvWGDV6Lt61yDdtfPwqF/IGWt1tBbOHnrwmLm
	VNQgo6n2/cM4nDIqAmIEDXClG/VhJJHgnO/gg3ozdPS0/jWWoCg3d0SdxfMrv3no
	Ec74smptQ7DXc0+wK3sDh21ZsDURQlNm1F3ZnB0Scd0/se0Mr2FMtP48uCgpFbRI
	3gncWvrWmbZOdjZrESkmIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkd8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFCSLMg005652;
	Fri, 15 Nov 2024 12:38:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ckrk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7jJplQw2gPo/LTrXjn/aTsnSlZ77TjLpaDn5g1Suoebb+idack3BygnEbtc8Jq0PDoK/lY19YYtIHUubwHyqxTJk5fRR+9+M6YpEgS5wkZkMZ/1eCUQQ69+0B4iU3L6kzEEZp13b1IhqaYyKV3f89xRXBGioMd4Jyi/cYHspK0kKEtG3gu84DZqc/9u4SJqqmJxsP24IdIaz+HU0D6IJnUk+wvWW1SU1U4fZDzUZmjD1/zuopMWQzg1bEZ/Wlcz/XPcULNtjwdDItilgl9iHemrkMUff+VNV5cpQB6ycq7zPcFAyGRMrGsVr0igGyYlK9wzkPi5X4rFkZn+0aZz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hzJyGd7ND7ALeuDMST/ER3oYgX4pWOPUyctcPhuIyI=;
 b=cgQgaU55ZrRKhinXW7HhxrtLUu1ENynQyVjzxcJr+W2hpIAS0ajHGv+LN/UuN6Ojp5ELZ0gwwi/wc6L1fpmiTmlgGCzfP+/1lvLoCizGcNUj9prMjaxrfWHKqEX6tikokPslEWFUUufYYBRdvlELE5T9dh4Iycad0lje9eL1dwgqJPyi5/WMGH7PcNmR3HYXJ3NewyEaOoBN4qnUd/wNgLrSElW5M6KRBeGttvI4OdyhSYt1Bi4XDMWvnCaR3FEo6y9Tx+UWohDUKJgX034KNOrrMs6PZ7FTifcJSSWAum0CAm2IEN3gneScUXVn3QInDPOIs+r9kBxetuE1UkQZ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hzJyGd7ND7ALeuDMST/ER3oYgX4pWOPUyctcPhuIyI=;
 b=A6MdOwnYAuiThhEskYA5OwVyfz+FCAhviu9pQwyPuLMbVxF2/YQf1C3G7dy8lIz1hNIsJmJq6BbrgPH7IHGa6w4A4kMPVS9ekVz8hJsS1IGXfD/Hz5AyVhl5/uhASbSFfVUkgU9AUH3OnGzRWuflPUj7JG5CbhUzqLbtIpXbK1A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:38:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:38:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.15.y 2/4] mm: unconditionally close VMAs on error
Date: Fri, 15 Nov 2024 12:38:14 +0000
Message-ID: <9ccad1c5a53af878459f32ae3efaa3d12d33e4e2.1731667436.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
References: <cover.1731667436.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a9324d-82a8-4efe-9053-08dd05726e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4n8N14UzQVWNUv+8o3on9hFj5b1tH/5rVdModFiOHYUYtSlUptbWla9ewpXH?=
 =?us-ascii?Q?oMnzlxfdW9LYmrVlg+DVO3nwvBwTzk6CfipNhtIBleFAcoNZA1VhA7p1B4lX?=
 =?us-ascii?Q?FZJuXgwg6yY7MOAQA0myYdizowlIYPaZlGGNY9KYLfgfWVx307PSo7E2N9DQ?=
 =?us-ascii?Q?s0GUk095Cgr9lkIJcOmyOGE9FmoQLVZ/A3brtDouHBjCl7JNEoVnzX3KQhUI?=
 =?us-ascii?Q?DtEbG2oFmZrrZkSeN43L5s3XR5N2bs31NsaJdFBym7p4nz4Pkx01ZZkU8dCk?=
 =?us-ascii?Q?4upoWrNFcFhLzQObwtsOwzrGdSH+9H7GHmow7JJvKtD5B/UAoxWQIgX81R8R?=
 =?us-ascii?Q?bj6ByUYEdz/sw6wimuO+UE3Q+9+VPuthdnZWa7040xmscrIe31P7b+CehFuT?=
 =?us-ascii?Q?Ecf78hKrVEaOV7Cb1Jo/b14igcG3TTjujAQBiocMexFqye7lhNtpY93x5ORD?=
 =?us-ascii?Q?DRwMAL0WllZAQywr2OvOyJGJcCTkabDfP17628DgA9WAJa/zFrTVNioVaKgz?=
 =?us-ascii?Q?c7oYlhCRRKOUdFb/ztTrgrkG8IFMPn1D4Ky2PSQdkhGQKEsDu6eXkcJMKjLL?=
 =?us-ascii?Q?OZJ2LxfAtfdB85Pb2kzr0vP5UEhAKBJrvKESPnoumT5MBEZPQz56Lc1/0RPE?=
 =?us-ascii?Q?K8NUXIJz8aFs25xoCgoD9ntcTUpeM806F/OdHRGs6N6FHms2F/VwqGD2YpXS?=
 =?us-ascii?Q?ikBnKLKBJTJSPPyIEzyk5fMKzXQJUZhvq7CT/raunVp3hceNCrmWLXK+29DK?=
 =?us-ascii?Q?TD9hZPHNS+uE1Vg1knSejI6FKZcfqI1Fm7q7o3GqyY7xm64Uj7O5gg79XMNy?=
 =?us-ascii?Q?DRpyh7tXqsMepIyx6YuIwkaZQDeKIgWl32fm4UhyJHpbNU2zgD2zIdGs4mSd?=
 =?us-ascii?Q?eYpQoghexRuOeaIdE7XYxasLXI6+RstLLNLy0G/zjEQKvGypyiU3R7PDF0eD?=
 =?us-ascii?Q?kp8w5ZAIhRchB3Ee3JMJR/gMrnq9HcI3IAoujLI7OKFGN0gimFKPLRdbl0DF?=
 =?us-ascii?Q?t/sNPdkr1x1IHdz9RpFJwywHyE/k3ZKXyYm6g2jyI9k4zOuQ/LPRkPj99qAR?=
 =?us-ascii?Q?HDTOwSIT8tAIgBQumKTexIhdAx+SMYqzKdk2JRKsuSifUroxnH1eAP4mbSfI?=
 =?us-ascii?Q?iD4+Jcq/r5FxSEORVXtFBfEF5fgMAE1fYMSjzEZllTfDPvrHhB7xXk4bIp3H?=
 =?us-ascii?Q?deQ5fUaJIr5/QZue8fv0X+8P0qGGvgx1zao8SVGvbkupNUEW673vBmivbymb?=
 =?us-ascii?Q?EAiFp5UWw1IX/k/MGAzAguLh/VHskpjBLXNNcnW17vg71JPuC9+Ba5SPYbjD?=
 =?us-ascii?Q?mj4BfmqgaZHsJShBZse9+aQi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYXyxdEAs2iN+EmJxpjuA95uTTsVIbNrXUHbSsX9ENtGfP8YUwTTjIPgKKON?=
 =?us-ascii?Q?Fo4ltDa3rrvPQ0GxyRy9RBAXSY6Y/3mjAahYMvZjbgZ2j9TVW1nTMcs+Bfdy?=
 =?us-ascii?Q?h8spKKJ3Oo9O9tq61+zF3EpZBxLuwX1q/7YNQAVocrov1cZlGR3mpOzSdmYx?=
 =?us-ascii?Q?ObD8g5tyBd4wPhA0W5Gbtf1yVl5eE66WOAiWOC3YWVSFzGXaC2G0x9GifBI/?=
 =?us-ascii?Q?A/RL3ARIu0JSzfOoLoz96XoOZwvKLkS3QDzTTP1wfuSPkfvuJYipAQeIKRqp?=
 =?us-ascii?Q?I/kOw5EjNLqpLIiE26prKnwgiK3ieSWLpeIMd6sPOdjZ3Te/lXYM7nPtPq09?=
 =?us-ascii?Q?akaz30PZKP4w8OZJwiPVX2s4iGLY1aigyHW4BW910mMu6Spth19BOwjDlM/E?=
 =?us-ascii?Q?X4l2rjT79JcuwdzBnCMWtJogiqAqa+iIugr4v6Y7UZSE3s89g9U71UaVF6+9?=
 =?us-ascii?Q?peHVqcUDzsA7negQ7QhOIUIgKJXumjM6g/bRB5L7uyApjIx6GF74nnQmG8oc?=
 =?us-ascii?Q?xPXrIMSuRE35TIiRWi4mY1X/AGssbTKsvPwshreDGKR+JEYYlIimgXUWl/aK?=
 =?us-ascii?Q?Svf1u+az7c9jVUghtKPaZMwH67agw+Z3U/bJRguVNtylTNswiMQDbMfvPU2b?=
 =?us-ascii?Q?bFUS6i81YftMMkpu3+kapekcFxPVtjCQl+ll+MPrfluUiyfJWBMmoh2OL5qd?=
 =?us-ascii?Q?F9Ct4T0nX1b5/YQ/bOxbd0kH9o4ttj1TLrXd0Hh2irm/4DoPl9FIj+/CCSDx?=
 =?us-ascii?Q?eK4WykWIiBHoXehKhv/t82VrZis0UBntau70h6D+PVy77CGGY0W7U86PqXf2?=
 =?us-ascii?Q?33mo2e4ZsDjzDjhmQmplC+bbIOEJ7ftLrcCaSksuYawO/aIJIXyOkWUMHKWl?=
 =?us-ascii?Q?SvtBVj9hV7pg2GPmINVr5UH1ogGYHcJ4yEi+g21Y3KBlxRDLILTcsXpqlu19?=
 =?us-ascii?Q?x2MLz5iptjndr2lNAA9nXEsJ3ERGw/bw98P7cMarOZrQ+koVRDTNAhmj/1jn?=
 =?us-ascii?Q?wKpcaavJYDPMdrKGhO5Wt+y9gySs8xF+TA+1iO6HJoIK8HukZ+AMtZGShEJJ?=
 =?us-ascii?Q?/JodxzjCz1vSV0zsHNegY6ofQOu5M2178daVHgvRx9BWAvD/2J+PJpdlZm97?=
 =?us-ascii?Q?8jgVADOqESQRn2DKNtdkJ/2lpjG76aQfaIMuiXSyO6BgL8VsDpCFwqkp4SOD?=
 =?us-ascii?Q?q+unX6vRqZ893X7/HYoqV1bmT+pDOf851ETRSLi/YSc8JYE6SUp82ib2nZ8f?=
 =?us-ascii?Q?YYUwpqJimeVKRIFQQB+Dbci+18n7F59fiXpLGAbbqrCsKpq/JNqgyuEar3w6?=
 =?us-ascii?Q?pZ5y5OOdWOpUu63mjyqzVlrMLmWCAFC+gdTKykeT+pwrAIV09ZguHYVZTKM7?=
 =?us-ascii?Q?hKJYzXkINlKxTmMxYrWOCpkwM/7weU5RE3tEj5CoF+wvWLMIUuI4yIj+fGso?=
 =?us-ascii?Q?hBVlDGjgfqXy9uT12oDlA1riJlXIBUfsrZONosxfbd7xn3/T50sK4IPMMQLD?=
 =?us-ascii?Q?Tmdyz1t2xhievrr9h7Q05jniY9rWPCdGzcGJgD6z7erDAsVjVY9DN0ydGFnH?=
 =?us-ascii?Q?KaM3OfMOfwu2Wvm/v2nL0R2eNb7Da0xulbb2KQghb3MHhcPCIbu7B9i7XYrR?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mt0exN33bw7ylLY582OgbW0wBTh+AIleWkjgU4YJymM+v3oFg/7rXp+T+wtymA6b3kYBkJZH2uW6AEJhBRhncOBxAPJNVgaP75F6ZpKDpluozIJItyIU0Zq4C/i3/P6ug8viLdaQvig5GSIcZObusHVlIY45Vmdkmwxs7e0cCzx3Fz1/YinaZNvhvpMRRRqW7cRE1Uumy4tZwX8zy4VUoQ2La2jV1t5oHaQrAyrwl7St06wAT3F3cP1dNeT5NvdU8F57KSxQgb3cL4GISpOhaVs9h2SE2fbw45OKZFqPJ19aqfbHGoOkaQhpyPzaVVjYWREVRuBwopyQCr9G/bCVTx1NK7f/NYTtJwrb4rqHlrF2cUihGYB7L/53oUH2tjdFbMZoH5v7pkv3rwSOyL9yAk59hO+jlmiWViY7hd/be87xUpljBEDp7Hc/jmq0c6H2sPla8V6mFR9oXgcNotvQ34mTZBXEZO+VAc64ddL0Pxo24O6FIWl4uxD7MJit9hHH7mxAvzkoRAeMqp8PL7Jg56GVEG10qexvwO05N3kMr17EQZTSLjXdVBm+3LRztOg8cKOHZZ/EOdwlyplgQtBc9JRlTrumnI9AcQWZAHCDWLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a9324d-82a8-4efe-9053-08dd05726e97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:38:39.8749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLbdxDrRFMM9Mw5kbFee0vE79mQlHWQJ0sBAWoeFouRxffKPSwtVEBZmgEirIlW6rd8jZ25LAR8UBfGMfkqJv2iY6XY/JBvlUrixPUusMe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-GUID: wh8wQ_Hw_9pJaiqJIOVj1fBgzh5hjuFV
X-Proofpoint-ORIG-GUID: wh8wQ_Hw_9pJaiqJIOVj1fBgzh5hjuFV

[ Upstream commit 4080ef1579b2413435413988d14ac8c68e4d42c8 ]

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 4670e97eb694..34b3a16aa01f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -46,6 +46,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index 11d023eab949..d19fdcf2aa26 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -180,8 +180,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	struct vm_area_struct *next = vma->vm_next;
 
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1877,8 +1876,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	fput(vma->vm_file);
 	vma->vm_file = NULL;
@@ -2762,8 +2760,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
diff --git a/mm/nommu.c b/mm/nommu.c
index 2515c98d4be1..084dd593913e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -652,8 +652,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index f55d7be982de..af6c9bce8314 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1104,6 +1104,21 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_PRINTK
 /**
  * mem_dump_obj - Print available provenance information
-- 
2.47.0



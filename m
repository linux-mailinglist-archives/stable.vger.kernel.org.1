Return-Path: <stable+bounces-232660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDrnOQePzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:20:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D464374361
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E47A3076AE9
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A43815C7;
	Wed,  1 Apr 2026 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GE8md3st";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnUze79U"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D636215F;
	Wed,  1 Apr 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013366; cv=fail; b=lBsnd3VCZe36MF7MfKCq3KFA/0MjkZw310DQZfzWQSBn2X4H6/aZo9a7kG7lg+uJgOCj2w/O4JC3blAihlTp2KhK6dYVsmkiRsvej0BJur0lj+Uct/MGbgzDFIGOV6fvUQrIV2vUaq0TRZCKKVcG7w8UOEnH1kqNhDprAY3IvII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013366; c=relaxed/simple;
	bh=jSm7s0Sl8RHyT699+yLJNxt0DRKtcYQtU5+PDWMu2YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCdxgutwwAcyyCgrtzaw9GKMk8uCbdc1yLjZ15cyPLd+tVC4JMUfaA494xkUnBwpof4udQ0JKHy3hAC4TaZoTn3J67mm6I6fKB2lVRFs+NW18W1KI+d8GNZYl3QbykTjPfryfh0mGLDcFgtW5cr/An+G+mh2vazrmMIDcEOP/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GE8md3st; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnUze79U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311ETDo2191269;
	Wed, 1 Apr 2026 03:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EenmjmGNpbQ/ijtpwq
	Ux7tVq7AaN5UGcFcHcohzz8ls=; b=GE8md3st6YOmkM4Q/BTgllTHGmQPXh7whJ
	m5zdGumvsV0yAnH2NASl82ROfQH8m9dwg4P3iCnTHjdNShpjq69OpA8HNuIU1P2v
	wcSbwFf76Hlq2TNPRuLcqM0ocDR72twW+oXn3UAljPgpTKQzpOv3EXNm3ekz8QGI
	X5eqjLT027b5It4aNeGWCqrW73x/7h2IBiMW29O7wIZVwqxlUE2I/hY6aaIhVOor
	WQtfsz6g7U6lxXdm70+ium+gxbr6G7ypKDlBCab2+4VQUoYyWj0N7A9J3tmQCqoV
	t4VqzjvnSdZ3EgeePgshvQrM8DS04ZbV9GhjU0DJAqYtQ/El7RLA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d66v5nmm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 03:15:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62VNwXbC020821;
	Wed, 1 Apr 2026 03:15:39 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ehb6u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 03:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhtlLisCr57BE9YR+Yz1IXeDb6SGCLtMYPV9eqWTb5pPTX77aq0DjvPF22wHS8axVOUm9snYEy0CeJDk4cNWZZYovA4lF74K386VTgN9IE5V+FeDmEa/v70K/khzfXkTj/CXBOUnKXjbQmioPhiQ+sTF3zA3SIEanCf6PVAdnp5GI8+ErwTj5cBC0FdD3yvciX+H5QG3bxxz8RkjvY/pErTA5bWw1QuZfnwx8u3exwn4V66xCRmjCeGpVKkVd4AgBs/QpAx9y2dV0B1uawwqoqDlaQ8sitvanBy7EYKwG+Z1dZrv4f3rdHSXWMmkGT7mAKRVXXZZJR5yyp+0Grbnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EenmjmGNpbQ/ijtpwqUx7tVq7AaN5UGcFcHcohzz8ls=;
 b=Rv52ai6ANQGJfcI3sYZcxCAJk25+1SafyWA1wP4VnDXS3EyEIKrqvQvOd1j9pUfMaHnlO1QUCAbYCuKbAHI3z4sVTyk/nmHoGVafk+hUrlzlU/Qa53x8nOFrh0DhYhBKu3PYvrb8+TbeubbmkO12Sw8x7l9BMuoqwWGByD7DOS35tozQDLKiSRWdpcbx+2WYIepvkKHejDxo3vqwBlN4+3lLDfox/L8yAIXalVtPCe7uFQWrwEZCzP4asrwgOub9hqsUG/G8BTbkDp3veID/unJpCjw38aB2f0B2IHVvsWrojlEOiBIfxzQes8KiWDd6k/yxK4XBu4Uyx0yQKD1zjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EenmjmGNpbQ/ijtpwqUx7tVq7AaN5UGcFcHcohzz8ls=;
 b=mnUze79UL5CMj7QYNeoZneFSEPZwIjaf7LeURrJaelWift1J4UFHIL8LtQ812BxjTVtjYDztEA3eSzHbikvHbR5LGkPLV/0qXKN+ymGCfyu0FooCFnRwLhCDdmVFOHAnB2oHm0Bvoz6nxI7TytADWR2u4iKny7ZbYDQLhHH7+q4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LVUPR10MB997809.namprd10.prod.outlook.com (2603:10b6:408:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 03:15:35 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9745.027; Wed, 1 Apr 2026
 03:15:35 +0000
Date: Tue, 31 Mar 2026 23:15:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Josh Law <hlcj1234567@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>
Subject: Re: [PATCH v3] lib/maple_tree: fix swapped arguments in
 mas_safe_pivot() call
Message-ID: <6oylc45aeb2dm2253jc7kgtf675jsy43x7dwokdcdrxxypxxz4@ztb7plykq6g2>
References: <20260306225849.2824409-1-objecting@objecting.org>
 <cfbe0037-00a0-4837-9a70-575010c201de@kernel.org>
 <20260326114447.b5df309ae13ad5f92e9e0102@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326114447.b5df309ae13ad5f92e9e0102@linux-foundation.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0091.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LVUPR10MB997809:EE_
X-MS-Office365-Filtering-Correlation-Id: 395d38f1-8a6b-4ec4-a503-08de8f9cf10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7vgo1OY+ZnfjZFz0iYw000Y5rRMP0MhRIL6x+TaHm3NLBQGw6eV6P6sAtPfG369Erkl6mAqvDCqgVn5EMsKMXKwzTwfyK15bFXatleJaY7xCXJsy/WJU5zG0BWOuKqYNGLSLf3qoPzdIo2nOmlsX+jIxCBvppt97pxrHpmJMGDZLwgtI6C8LY8SJ4EpYwPnAi4129bBe7oTAKrDX4BR2L2zpgzfRRD6jFcndkrZQXJZXRyC3Y0ugottDVI4r3TMK5OhXEMsSJZpZPgokDVIqkzJ1B8DUyWiQGRVC57yO+mXGl+sD22fLLYL4Ro+sVjYs6qURkGmCNjJDF81yzL69i2kEGS4xVtsiCdIcDY0DoFUsC1YT3e2bsTdmIxrdWH4gSSgyF2lBWKLcxcv94QB13V2vtEWg1XHoHw1GlcluVO9CA67bs98SPMowgr2SJGRH51pwY1sR4DN1GDfmLKU7M/NeUhLv+aeey9ChqLj0EHBSq0mYB0QLypmPv4u7a4Dv9GeUluOr6vtufNhVVqBS28RQUUQsaGYH5Qhg10cwvoFeqbA4bDD/kyC0Sgshj35npGNxWcq26u/QGiDd71Gq8qeuCvkMDAswim/e0XTo5aU8MKV4Vd5b4nb3D4DDLm6l7WZhIrhHXF08oA9UgHRL79uI+1e1j6B+EsIXrSADVkQVHk8TY6hZQoy9Mt9J2k5R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5SSW7andRPTPrGFJqSJvXWce0PhYljUB1TT+BX6FFYtof46NrcJWG/O388f?=
 =?us-ascii?Q?FpIvG2N2elyMl/J/+9+XG6XAfx85IHuepOVVvpnjD+diO9j0gNlKNl59KYxI?=
 =?us-ascii?Q?YiWPhm72/ErifDshWITICSmOQDuBqYEkgQbhlzrnMg4osAqWVTv2XGAwDt1a?=
 =?us-ascii?Q?HbNgeagJzzzXb+TYe52B8lHIZz1kQ5smw8c2DLeY3hehgFX+/vgTUPXpOyqp?=
 =?us-ascii?Q?m57qQbCGH/o0PMSTxPHPkYN3KN67b0fF/zTIEswzrb2VpJBG0dbY/7YSrvvR?=
 =?us-ascii?Q?tWhh+Zlls4FBF3Kj8NTaNU5GWX1OQOiq0uDaNd6b/KU4F16M5/AgaZcSo6ci?=
 =?us-ascii?Q?WjEJrhbXYwIBQyEiLZ5/tEPjSCf5us5y1xkWi3g2EUt7CuHHZfiEZlMj6ECG?=
 =?us-ascii?Q?ExNN5Nj70BOGi7aV4oViS1ZE8ubcVACaDr3fUmw3kJF0LaQulHNYY3phJq//?=
 =?us-ascii?Q?YG/BFjxZgkK9JSX+9htJ4c7B657sy98hnzUKdWxV3yK2oIemNmGb90sER6mT?=
 =?us-ascii?Q?2s/oSX4Q6nFUked0EcHOg8U9Jz+SsE6OAEa7mBleIK8Z98sSazUKRRvjY2hz?=
 =?us-ascii?Q?I9L4qtRNZgqcdtYvswJfwCdR0L85bXBl/CCajqx6tYfnpZfYbaztwraTVdQE?=
 =?us-ascii?Q?573peEcQ1VpJm1/TdWGF1dKOt2Bl9lO295sF1fRRmgoTkhJsiMPhP0kFZU0+?=
 =?us-ascii?Q?sDHsznKPeeWhbLTxrmOU9QQVpBjrtZE5CWZnPL/n3NIrDrJtPA8grF8dploC?=
 =?us-ascii?Q?zUDQAcruj9JNk7dSr+gM12kSclUxv/Kx60lz1Pfaig6QUrRU3tT6GpOZpJT7?=
 =?us-ascii?Q?cjJ1Q/pxsz7ddBls2UkTtNVwk7oSQX1pSFu1BvmMHM2NqsOScMXFj0deMpQC?=
 =?us-ascii?Q?UAGHgEoDuGtLMnumWuKkzTD6idbSFgIliSk9Y6ClKmvoXDqr4keoH4qQIRRM?=
 =?us-ascii?Q?fplmU8awRWu6Inbjt/CQjvHuV2zvH5FyLDHqcL5YSQkY6gNb1mQToIvU29g1?=
 =?us-ascii?Q?lmcW8y7RactSy6qMj18rA/HMKwodsB8+TMjXqpPX6fGT4p6q5RD8pbPdT57L?=
 =?us-ascii?Q?2tS2Z0wDAZ2pCvowLKh6f0rbFZ09r59Z+wjUbfkesVKTCq5X4nPilTm70xG1?=
 =?us-ascii?Q?1+nUeAmQoKEZqM41ceWm/CiooMpGQOwluVfg/En/iFIOf/5szrW68g07eesr?=
 =?us-ascii?Q?eALBFwrJ8moSqdLP+Iu7+8oaBpzVtGXunG9icJhyVw5xNFxqjsdz3esVb3Te?=
 =?us-ascii?Q?zd8emWkOGPSLnyIjyRAlJNRFJQspu9WVv5t2Z7el0hCnDP11B66SaYpFNy4V?=
 =?us-ascii?Q?cr/Rvtq641kWu0pjDvaO3ZY1bG1DAYirsGTapgSQMsOBPkIkdjzrDWFoCR3r?=
 =?us-ascii?Q?bseglD9UM+yJscjqLZCWSE0LAuG89KcERmTO0G/OAUoDPQqSFe09BcB+EZZb?=
 =?us-ascii?Q?KYY8CT3LbSQw2oP4XNiSYsZlVXLklHCkNxC+wgzl6duFA3pK7YjAsI+Sr4mI?=
 =?us-ascii?Q?xp6UH2/mbXsT7VtSFKFOUbskcVnvAIkzN1QGXw1k8+yIJbOs/UQ4Z8DwBc+h?=
 =?us-ascii?Q?mpKoJ43y7Relf5TSKdvyIYARzmkyPTfHP3p4CHgbkIgCoYd/tdRZIkuP0MUY?=
 =?us-ascii?Q?GNm1imMBfDXChaS6ScmgjN7nIDEOAWbI6Ha0RXPp2FDwQceVFubMOctAKiHB?=
 =?us-ascii?Q?NXIFKUamUBNpk3wilMw7SlOBtupiyr41ejSuGyZ4qMDs8tfweeqQKgu5jwKi?=
 =?us-ascii?Q?Q0/ERme9kQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	mcxeBwWHUaXShnvp2cBBs8AR3sUcwC8DljbvaFbjJI8IgEulM0D+xe+EbG/d/kfFlih7hDZ3yiAG8pMBnR9dwAT8Yir3jEDLA/1eEV73rposzz1thLQ4ka7kGZOtpTffR3MXQH7SNQ3HCzGcYJme14FxMNQ2x2Ty4ppOSzCMWeemh1Y+Pqs/rZ9+yulwCwwNfRfYm7kd1hj+A5SNta7SxTo4svMKJVhpPEc0JQpExtCNFL6kijnUee6PJx3T0khSZJQBmqu87F+u3lHEpj70H+Pqs9OZpk0rMGh2xP7E98OLb/liT6BZZ1pycnZR4Nyqj/HRqXcs2kdr+DGvTOp8wg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gYEoVHP5k5k0lbK7iySmF9prXJA9/4LymElpnW1KxGqaaypejLHv+XjgTDpmSvgFeXIcjmZ0hpkUkFCJTXHRtd7eiDh5CQOqU8t+dITqsruzAkKSxuXCkIhKsgPR1AsSXEq5kXcGC7pEimkBX8/LUa7WaPzoyqSrT4YURubtTolbhhMBCsbJJyvCu/cWvdLbj39YaE4NwwEr7WEYS7pxoJ+cKwix4Bp30sm0/ExVmSByA3HwSuqIXvWEAAKExzE/oiHNEz5Yf4To8p5nrZsnhVljgkCME7J/W/9RQTSGRTEDYZV4CZ/Y/X9+oFXddk9J5S9uVKb+lq0CjfBe1zRspeJLDKMbqr2f7Z4uxE/EQVAR4R25P9aEjCioSouIdoOjtpIjMPsui4XxxKk32nBknH13pHlDamXLfTqnOyhE0mBVvKyRHApsJwyQu9VBJEVL966DqrsO76Myk8QWYq0la6OEweK6CiuNaafMiWt3HjuWPnzxLNjR6b2MHgdem+QAIb8hzHWbpg9ma0KB0vmwCQ0E6ujkMvR/JKYUf5Hhrxne8uWMXijOiTBxv14sjGgugDDK7Q4hOU2Xn4b8O2Zsj9yzso1cRdRIAfaQ4UcNrKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395d38f1-8a6b-4ec4-a503-08de8f9cf10a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 03:15:35.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0QC73i5uYpV1LHYYbX9du2CaS3y0STo7gEx/ZIYdXCNqIxDppsNkophH9V52yb7pU+64sgnIFXRb0e9IjLBkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2604010023
X-Proofpoint-GUID: JhFzPp4aqMlDrVtOO_kVVaNYSKbZbEWv
X-Authority-Analysis: v=2.4 cv=G7cR0tk5 c=1 sm=1 tr=0 ts=69cc8ddc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yD-zjvGMAAAA:8 a=Z4Rwk6OoAAAA:8 a=PGClfyamByCsfEaiBUIA:9 a=CjuIK1q_8ugA:10
 a=kLuJvYmyrWYxQwIM_9hz:22 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: JhFzPp4aqMlDrVtOO_kVVaNYSKbZbEWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyMyBTYWx0ZWRfX7+5po/uglUc6
 S4OwoICI9/Txavqq9rnRAwRR6KMLmL+ha45MKhAQyn+xn6R/AfzJWVgkN0MqWfdtygE/ZxFu/bh
 JJV94LNG2wk1WREXz9y5B2usXRoeJopKfoMCgnw5S991+KHxtn739ULaqkPhU/MizRYc5INhE8b
 6Sgi4BnjbJzUy8wRU7H4jijy052lG1gWw0iaUwXNYGBIysMiu/D1KsmHAor3qG+YYcXM+3Aw9i6
 i4B8T6CrUkcRfHOge4zKLQIq4WerigxjhWRNFJhVDChbxgJVkATAAMVxjYKjor76knU5dmZJvyQ
 hSOwEBtg3MNbfETHp4pzg1dhrt1vFf4dtaCnm+VIuI15HPRrpIav7L9//SKgonMmeSahs5YcEdq
 z3C28ZQLMYqwc7AiGwsXH7WpPmlH5cnVZmGE+Fg2hhFjrfJDXJFrHD8ePy74WNW7plYkf5uXykA
 9B1yTuoBcBtfPP2iZJLNe3ekUWHB2b0iOR3jT3Hc=
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,infradead.org,google.com,vger.kernel.org,objecting.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232660-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8D464374361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

* Andrew Morton <akpm@linux-foundation.org> [260326 14:44]:
> On Thu, 26 Mar 2026 19:02:35 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
> > 
> > I'm not a maple tree expert but this looks obviously correct enough. So I
> > won't speculate on the impact of this bug, but:
> > 
> > Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > 
> > I guess since it's old and not in mm-hotfixes, we can afford to wait for
> > Liam who should be back before the merge window.
> 
> Yup, I'm keeping this parked until Liam is back on deck.
> 
> > I'm not sure how to
> > handle the fact that this patch has been withdrawn [1] however.
> > 
> > [1] https://lore.kernel.org/all/E1A667AB-DCE4-4034-A36B-DAA458780A81@objecting.org/
> 
> Waiting to see what Liam says.  If he likes it then let's proceed.

This fix looks correct, but I'm not okay with taking it for the
following reasons:

1. It does not have a reproducer to catch this bug showing up again.
Although unlikely to show up again, it certainly won't with a
reproducer.  I have a strict policy of requiring a test case for each
fix that should either go into the testing module or the test framework.

Every regression or bug has a reproducer as the next patch after a bug
fix.  This allows for successful running of the test cases without
failure (git bisect still works), while maintaining less overhead for
backports.

2. The reason given why this hasn't been triggered does not seem
correct.  If you create the test case, then you would know why it wasn't
triggered instead of assuming what you stated.

Maybe I've messed something bigger up and that code isn't reachable.  No
one knows why it hasn't showed up because proper care hasn't been taken
in analyzing why it hasn't showed up.

It also means instead of knowing what's going on, you're making more
work for stable.

This is just sloppy.

To put it another way: what are the user-visible runtime effects of this
change?

3. The SoB email address; I'm objecting.

I'm not entirely sure what's been done about these Josh Law patches.  It
seems some sort of bot is involved without proper oversight.

If these problems are not addressed, I will rewrite the patch with a
reproducer along with a note pointing to these interactions as credit to
where the bug was reported - since I have no idea WHO reported it.

Thanks,
Liam


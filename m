Return-Path: <stable+bounces-214691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIIvIlkihmm/JwQAu9opvQ
	(envelope-from <stable+bounces-214691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:18:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BCA100DC8
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE06D30160E6
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC436C0C7;
	Fri,  6 Feb 2026 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XtyAW3tx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tUJPMBj+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD233B6E8
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398092; cv=fail; b=ZvTK3Ez9NBAHG6SW3lPYhGTEk9RlrdnICc4b9WGMzyPqb4K9/W0TByldS2iYD8m8COV6ZR5l3TYpn2BTJ/pRgLI/EGmlkNZr3oGBuyIXVXYf3GsZZNREEsQgGkf4cwwbpVyE8muiv/uIDof2dBaSBpfi8vhQ1Sye6Mbkv3veNzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398092; c=relaxed/simple;
	bh=V0KrOiYyARHBzmENH49KUi6o9fh4mOST2OGly50Hfz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aB6OabUP07silLfGPg7bCfwlcsb9CyXGmYFfJBO1HBT3QJ7+AtNLPKMuGqwlq/rDPg8beZg4nqBN1yQYQbGpLdFodDYL0tOyhc0oSkw89X9hf7cv5qYwA+F4TFzwPiVwa/VeH+B9bNAQHdswEqU5PZGva0hncSmV+iVX0p+PoI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XtyAW3tx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tUJPMBj+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616EvQ7R3420324;
	Fri, 6 Feb 2026 17:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/AGHap6Fvn75DyuibIEmGJoY5q+5MW8uVPGp/l70j/w=; b=
	XtyAW3txHv6GtdoiXCuoiXfpQxF7a58UgGjpZC+s2MGbotDKnxsUlg3e5AeWaAks
	DWWB6HVfktnocUqZ/Cv7x3O/SPNzsORESm1JLYCY2JkwoPNHn/QuBTSOTrZt9JsG
	m9jIX0KHF1dntv885nxR1zlrP+5Mu56RJFg2JjuoL9VZJt68VtLXIryXJHxfpM3J
	8fR9g8MQZG94r+HDNW3hTTJOsOzSQEx9Gh2HGqxAeW8bxEuvnecNVr+coBOmjHnR
	EKUrQijRhFs+pRPQVuVe8uCIl4poG5q8lYBAeTZ/kNF5sR31CAEWUjGcSSj/yzg7
	XTfytpKmWGZQ7ZrUGKaLfw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4dc3u6nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 17:14:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 616GT1rL003165;
	Fri, 6 Feb 2026 17:14:34 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186scm5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Feb 2026 17:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWaOxO/dbea85aCutyLY8t1m1Sd/sDF4LN/9Qm/F8kqa+V/IZpkaxknhSQQ6cKLwh7R/p4qbGiCvRv83sx3gxW/vpEKbH5GbWsBi+MhRB8jwWQPOvGDSY0Tl4djyu0PV6OuTV0g96BlwzohZNBbydW/xeHHYlz4+rx4mjVdOCPJ1ozIrA6VvTEI5OUsYaGds2G8vfpwBMuJIw2/mKekF7J6mrZx0lk1qyAqi3dGupmWVBGvGVllurIj+NtbAo76GW4Fnq55u65XpZR1blOLViJgpfjkHieyExzWqNZLmNery+bqtL0BsZhzJO3q+HQNoqF4WrqEHwWnB7ds/WLVWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AGHap6Fvn75DyuibIEmGJoY5q+5MW8uVPGp/l70j/w=;
 b=sub6NYX+bSfQuigthBtbJF2zj7uDTFEYaX4j50MNMM8x0rWurCRcIrKcPCwu+hzsSDTIVoqaH3aqd/+LOo/Cnd+VvEsmpL2KJy+Dps/gaHBKKVEAnA2e3VbWTBvSr85efsZ1F18sOJXcPbNtKUTLcAVKDsRip7Lv9g1yQzSmnFfnvYfYDxOnGkX27ovB/5hqFANaMV7k1IAhsoqfgrIV2JrJreTlsirC5Z/XyhGLmHtiYMoP/OFiz7Pg7QyUQrHY2xyecLTKfo1/QQQQCvLKuPI5PLEUAH5arj+4TdtqgzFsWAkeGS5mspLJL+rzd3szbE3/UKhOIfjs9A/OzPczLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AGHap6Fvn75DyuibIEmGJoY5q+5MW8uVPGp/l70j/w=;
 b=tUJPMBj+AQTcgDkoepuLwdGOdqWq+XeGGp+aOmEbBnFU9ssZ54UOPtH1+hCw8Lq8FGhjdnLtZPR7I8wvhO6VGTYDjH69CzmlQRu6a9JkarZPeQypdNoTzeGtBuDoaoz95JBlzR9cz/a/sKBEkUYsbFm50sR/9W2DN3MMfO4ntUQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB7579.namprd10.prod.outlook.com (2603:10b6:208:493::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Fri, 6 Feb
 2026 17:14:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 17:14:28 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>,
        Hao Li <hao.li@linux.dev>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 1/2] mm/slab: skip get_from_any_partial() if !allow_spin
Date: Sat,  7 Feb 2026 02:13:47 +0900
Message-ID: <20260206171348.35886-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206171348.35886-1-harry.yoo@oracle.com>
References: <20260206171348.35886-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0125.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: d43c6cfb-9c2a-4b97-5329-08de65a32f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/7YiBOQnkqjo0td/I/z+RQZNycelABvs7PcxZEZDu7nLdXwnhYGnBHhbFfO?=
 =?us-ascii?Q?CPqhQWOu7DzcVYUhZbV00oym9sV4r1QapC6pWn9fCmoJyHabqkHSQ8fkDHeF?=
 =?us-ascii?Q?KCzy5QnpJqDeN06/JnTI4u2Vc5IdTRMpomr9f/Uj/0tNLOSs6CYskfIT7Pdp?=
 =?us-ascii?Q?Pktm6MqR7O9XnPokPtFDziTq/PW7K+waH2XZ+kpzm6a54KEtvmdyTXYTO20R?=
 =?us-ascii?Q?VfZRlsV3YJzYrfuWORx4+uzw0z/bKuYzkzJs1tOJskzfF+GvmENp1+vV/2lB?=
 =?us-ascii?Q?i4OcZ7iirWTkZC+tDX0YXjpbKCNV1u6Xv8Bp7DH+61NObRm6XdkyOR8B0QYp?=
 =?us-ascii?Q?3kbpS57Laux9Kgvj6Krk9Yy40IyAY6gFa1zb5W+VabJtjOsdB9UXjyGHutjF?=
 =?us-ascii?Q?bibojktwbDz+qv/zSJeZpU2mH+3B84+YfiWjAxlOxzwOX/NpmYHoZ9lnvzUQ?=
 =?us-ascii?Q?wm1i2LaoI2SDNWiYhBpxJeUkjVc0n4ReJ1NMe460KDQefbGyBfu3ZJNLy9yy?=
 =?us-ascii?Q?pt5f446LsRX3yUBOHx2ljQxo+BNTYVU4Uw+eBIy36iM/br3qn06QArk0bGLZ?=
 =?us-ascii?Q?iOUuNpSgN+ixixIA26S4WiINtHwfFbbXC1k9PFgYx2qeHF2Jiiby0rxdZR2r?=
 =?us-ascii?Q?6OBQDUllQnd/SZ+rFEP4+p/6XQhknyYbdMh55rEEaYD9KMEq/nalFoUdcMBe?=
 =?us-ascii?Q?YGqQvkjZlcgigd/728aIVanUVXy6AFoq5KTlYpzId9XneeLZsd+LH/s67SBd?=
 =?us-ascii?Q?Se42aF223B9xc0KF8DVyDBCDu/e+12BijQtDwnAtDh959IAZRRlIsUB5OYvz?=
 =?us-ascii?Q?G/ig4B1rrza79dMhnXGQUrsBmdbpZvm4j/KFryM/Zd922hkpgptAujWA1fwB?=
 =?us-ascii?Q?c7ib8U5jD2flR115xnn24G7d5o/oq50q630xzXuq6xKBleZKIryCgn80C+iN?=
 =?us-ascii?Q?dKgNRFLaRNDaXSbGR9U5O7tDRq0lXSykxyq5j1FYRHtohLrcFlnqjgPWon1X?=
 =?us-ascii?Q?75BidrrxQxs2RazRNj5lvuJxxa/xrZzGSulRgZrNfIfqaMLZrXMe9JXwkIUC?=
 =?us-ascii?Q?fWjgirgbuXHuA5X0iqCT6XxtxVjTs0DAdpnC5zc/7GfiKUIQSVWtLUa3RIPS?=
 =?us-ascii?Q?BcA5GYhHxzKp8LYhLz/MXj4RBXjJq+FmtL5QiKZTCaedkgYbsbjloqmEfQv0?=
 =?us-ascii?Q?GttIb6jYxQH3HTH7aZbxSwhd1mvxyiauG5+DKLhGlNCS7Kz2QlorJEi9OZ3M?=
 =?us-ascii?Q?EExjoFxDcp85tEi3c6xYuDbu1fUQmsKKlAEMOj7jZViJztDJC3CnU6M8OagZ?=
 =?us-ascii?Q?1RHY92H6XT7wxD882DapUU0oaqkoRkXFLJ+uzFSmbqN1iPMtsfOAhs2vHgPZ?=
 =?us-ascii?Q?aUF82DUoFgPInmYJ3MtBuw5f42k1hQ0OuTqRYE++A57dxys99R7bTzubsDv8?=
 =?us-ascii?Q?StBKIxAIAMGjJjXOK/fLUJ/afdMzFBCcUCkfMe+tvbYoDVcR525LzUvlzvJj?=
 =?us-ascii?Q?ukf4FD/6fRsM8TihA3gkogWsiA/YtK3PMSdAPoEQUDb4EqZQF29xhF464E93?=
 =?us-ascii?Q?2izeXXDkkpmw8j3mgDU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Snb078zHNqcOSw+fp9OhqgNWgGWLM7jiq3eT/uMkZjZ9LwlWUoGLqyk8Y1D?=
 =?us-ascii?Q?CcFncudWMQALj13YTDT806OthyrHT29Sh0E286Pbi1bu9hPPYsPOSVs58lH2?=
 =?us-ascii?Q?kEKAd2Lae/gXkTsPXU8WNraFR+VPY0/e8vO4t0sr6wFJRr0rKVPIYWymaJcS?=
 =?us-ascii?Q?+auVVOrC6AUb5qZvGL71WQuAI5djhQYiMpff5shkOMapfkBYTJYIPghn2K+0?=
 =?us-ascii?Q?tRxeBhhnoWNCNRg2zUhJQKuIug5s8SENGkeSiUjUGqlBco9LZGHNyLIK2b3d?=
 =?us-ascii?Q?hF/aA7inaQRPcmGwPD3X1xUCeF0Eo7GMbbmJX3xdttLt3PrScJdtl8mL3fTH?=
 =?us-ascii?Q?Np//FQpINbvEg33n2CgEBTvHs8L9FocmkD/pgbmDyaK+uyRkcZ4zfI7YI6Cs?=
 =?us-ascii?Q?ugNQUreR3hAh6p9fCLm1MoJKqtna6pENQbrYqbBU15DNBwU2qhM+z41GGdcZ?=
 =?us-ascii?Q?x/It73mjTgO135GxOdcXMaW76sE8tZVu4Pca158sUDEDEKmdter4fsyaRO2O?=
 =?us-ascii?Q?nmRmm2j39l+MpJ4oPFVoPkNjACeTRi/+tiODRxHpucSEEbsVMfPmYA5ZpdSd?=
 =?us-ascii?Q?dsgbssrwzr421ujoThfxmd+qIF9CmLhIyR6u5pSUNZjEcyKdSC5RX/mv5+Nr?=
 =?us-ascii?Q?KTL2ysxzdfiDuG7a94PwXPYSSE9shJ4iLxJpKzwTd8p5pyC4E1SKHoofO1DA?=
 =?us-ascii?Q?YWKKJQYddcZ1QUrj6SnszWr+HeTlBB0P5ZGDOPNPauWA3A2oQj+YIQqUAjyf?=
 =?us-ascii?Q?njCBQzbWl8apxihlR2dTECXD0wkDgHOVURyOsRKgcbkf72uoiO4dv6rKL9aK?=
 =?us-ascii?Q?54xEdCM8gmtep6RsG6TXiC6aXLCvRAV0DajK0jjtDJTJxxdcXDwUwcsh+qAc?=
 =?us-ascii?Q?GKfxD+GXvLWFgzznUJDvYJSJhn2esqYrJ5hFgrmhf29pM83EsDT6TwjkaUha?=
 =?us-ascii?Q?zF7/y13VoNUpTxWC+oHss0ItegJsDhxkWOrsj+TSnFVmll3SlfNNbf1vu97x?=
 =?us-ascii?Q?GgzA30/QgtVLJGpywvSqgKElpT4Xsp/Het8AKwFgY+1vJvtQWbtSR+CF/r8Y?=
 =?us-ascii?Q?b29O6ybehTOdVpeKZQdsK2xVL/Cvmo/yBWDE7aNogdgviL0grsZdpx97VuxU?=
 =?us-ascii?Q?oalDnHZgNeEer46bmAyhv339HnZE9wAnGtP7RwPwUpyh8JypbehRIrYcgTTp?=
 =?us-ascii?Q?3W1MuPE4/tnF9Hul8R+yMUNbaO5Eqz9kuAWXgtwZB+F32YThdoPMgJWcv/E1?=
 =?us-ascii?Q?uppMMXFdbSykFuVeXooMXAzFojL82p03hYaSKQjc9IxIFqN8gBO6Znwgmm67?=
 =?us-ascii?Q?qJMDUi8mpEE7rUAp9AsJt+Wlftv2BVc3yhWVBZ4U+CoBm9PkAIBzymtlKfT6?=
 =?us-ascii?Q?HQvAv5hFksMO+TpPY99+MZUiQ2EbfXNtbKgx1OGMgHcob2wMVpEwMXUviGUY?=
 =?us-ascii?Q?5GgQC9WynUfbFayqMr8OjrEouVwP3vsLCv7FMsXMwmR9r0UCP+SpLvVHF/96?=
 =?us-ascii?Q?dIj5mMS63YGRHV/RggmqPin6Yv1lfBj5eesYo/I7tZvrAKCG8GXLOpLmWORz?=
 =?us-ascii?Q?+OWlArV3eMBEHXxwYsCPEzvJsU/bCQjkyfw1ke5epUlHBFTRgYaRkMCt0G2T?=
 =?us-ascii?Q?tIq4kpnaylPxW2ueOlUt1AdGjPCclUpVWbGDfCnTNiRJFuvIAAqEnS4waxmG?=
 =?us-ascii?Q?CxSvP2z+O8WkQhgO6Z5IbOZbdcCOdbVHZMxWvrZJREF7QRnoFA/OeIh6nH3x?=
 =?us-ascii?Q?dzkmaeVA3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b9ta++Gem9w0iAxdCGvuFjfkw4DNpvUE4QbKSjbwnv4zy4hM1Xty/ct456kKJ0eaXBmHWd3SnUwnJ+ecv+Sj3SXU7gi2Z3zKEq8CypQ1l5jc2/5I08rI85MzzSNIer82E4km/kcX/m10n+wLBkKv1OpRbrCiDMdcNP8QEsLDFOX0d50FlNyEO1soRkVPvqilmTZwb/uQaLp55vebyXQaYV5I0+b7JzOCVrgdUC7lSpm/0Vhc1HR2uAkTmN+F0DIrjKhMH2G/gI65nUSD7ESjVDZG31uUsuRoSCFarwfYd4yqg0M1LOnGkGwn24n+E5wfiTET6V2E+912+r+UWwfiK6ZgQ0RfPQOH7O4Xc6i1sESJFaT4owNejtkqccMWhCnJCF4D4vqZWFBlvz7O/n4Ja1xoOnDJaMVjKxp0B8YA5S6B3GGkMjeNlVWxe9EFHAd7Blxc3PGk6a2d8KxvmLmvM6WNY/vHZd859Xh2laLxH/qEqIpmOeUXASYEj8Y+CEGNsaxE/xBzMxBX5RonAxHpYLuQnAL8rcszhKdMxzCBDLkfA2UfN5d75zzpbNhdwBH0yFN3XuF+su8ArE9LEejV7+E2TjmxnvVvdkG4f32AsgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43c6cfb-9c2a-4b97-5329-08de65a32f51
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:14:28.2134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd87C3Hz3jew1GGcEOsZ3qxc0wfDMqk0ANbNmNuRXRl6B7bPK+1+q7NNctBDcJlRClvXwBquLWDRRGNKHTzHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7579
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602060126
X-Authority-Analysis: v=2.4 cv=SMtPlevH c=1 sm=1 tr=0 ts=6986217a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=PBXtZJV1hk8zmrDaOwYA:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: h0rZE-GEMmVmBgUeY2_E9lvSJXY03M3q
X-Proofpoint-GUID: h0rZE-GEMmVmBgUeY2_E9lvSJXY03M3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEyNSBTYWx0ZWRfX5DyA+FRjPeEH
 +CcZ1V0bfVyKQvu+KRgbWsUh4BGHXi0COiv+Cpi/eh+psE5eciwu3JI5eSurKGzK5CD5EMMMk8v
 Lr8Mbe+68JUOPxR0bR58LgSU2esgQZlOfrSyBf8nloO/y30fDnFRhkVFQ+QPPCIC0rN5gzXJOLx
 yhkGslxgVst6c7TXdaADxQm+63+vLba0n1va6llxB3zVlrlFZG+2luO0Yn0GVAc1ofiuceWh7ei
 wBMJIlIeZ0mh1Oc1PZRMfhOxJzCXpdRz3GDwv22+4jS7Dqrww+wg83sUozAElmOsLuQqKGSr/Tn
 Af/ikpw72rV/gHNe+y4TF24dT99GAtDu4063PuYQZOkKG8FK2KFjtBBXqFZzbH3EgrANpTgk02v
 Ympa2fQv+Ya1djICmyJ6/T4my2LQLDmirMh9fNnRdTsdkv5+8YCqycOj6H85zhPnaUbk+3kzH4T
 fynrreqJWq64lw05QtGGLTRqectviHUpiRYLAyDw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214691-lists,stable=lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C2BCA100DC8
X-Rspamd-Action: no action

Lockdep complains when get_from_any_partial() is called in an NMI
context, because current->mems_allowed_seq is seqcount_spinlock_t and
not NMI-safe:

  ================================
  WARNING: inconsistent lock state
  6.19.0-rc5-kfree-rcu+ #315 Tainted: G                 N
  --------------------------------
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kunit_try_catch/9989 [HC1[1]:SC0[0]:HE0:SE1] takes:
  ffff889085799820 (&____s->seqcount#3){.-.-}-{0:0}, at: ___slab_alloc+0x58f/0xc00
  {INITIAL USE} state was registered at:
    lock_acquire+0x185/0x320
    kernel_init_freeable+0x391/0x1150
    kernel_init+0x1f/0x220
    ret_from_fork+0x736/0x8f0
    ret_from_fork_asm+0x1a/0x30
  irq event stamp: 56
  hardirqs last  enabled at (55): [<ffffffff850a68d7>] _raw_spin_unlock_irq+0x27/0x70
  hardirqs last disabled at (56): [<ffffffff850858ca>] __schedule+0x2a8a/0x6630
  softirqs last  enabled at (0): [<ffffffff81536711>] copy_process+0x1dc1/0x6a10
  softirqs last disabled at (0): [<0000000000000000>] 0x0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&____s->seqcount#3);
    <Interrupt>
      lock(&____s->seqcount#3);

   *** DEADLOCK ***

According to Documentation/locking/seqlock.rst, seqcount_t is not
NMI-safe and seqcount_latch_t should be used when read path can interrupt
the write-side critical section. In this case, return NULL and fall back
to slab allocation if !allow_spin.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 102fb47ae013..d46464654c15 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3789,6 +3789,14 @@ static void *get_from_any_partial(struct kmem_cache *s, struct partial_context *
 	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
 	unsigned int cpuset_mems_cookie;
 
+	/*
+	 * read_mems_allow_begin() accesses current->mems_allowed_seq,
+	 * a seqcount_spinlock_t that is not NMI-safe. Skip allocation
+	 * when GFP flags indicate spinning is not allowed.
+	 */
+	if (!gfpflags_allow_spinning(pc->flags))
+		return NULL;
+
 	/*
 	 * The defrag ratio allows a configuration of the tradeoffs between
 	 * inter node defragmentation and node local allocations. A lower
-- 
2.43.0



Return-Path: <stable+bounces-93519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907489CDE54
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5ECB21511
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360A1B6CE4;
	Fri, 15 Nov 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfB6eSMD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zv2R8pbr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9B3BB22;
	Fri, 15 Nov 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674253; cv=fail; b=uSA4i1ZZA0ay+jv7DiiDlCV8YDpN4Og+74H0AO+LlV6hsiH37zIhcg0lv/dJfo+Q81uJ9TAmfK/AzwnbuIUWI6PTDjelhlQU0/WKASSTX4KGrQZrBUFzs4XTD4mRGv8dH1ofn6ST3BgyY9H7Lxv4lb6dskg9fYloU5d5wQDm900=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674253; c=relaxed/simple;
	bh=t9v3E2Nrkq/0XIHOpeJr5+26mlbWKUhgllINyIaC4uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dAK5CzmOlOz8KrAfJSYD8rmkQFgR9hV/nyVZfEtyH/jtma5Q+k8XY87HNgUC22CyiRi2oNY+h3CZuEyEH270ukonmCrZhjyAwbeja/Z4RpYyPlusdghTcIwVkU1xhx+D09+qe6iiwzxnsptIIrdiVHYi+BvCBGLhCU1PZ0aksfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YfB6eSMD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zv2R8pbr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAHUwu000703;
	Fri, 15 Nov 2024 12:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=9gHrl1XejhAfXv8X
	mrMN1N43hg6mIRwsTQBCZfRqvGE=; b=YfB6eSMD25IF9V8cwhIxCmymo5Q4DLIE
	RY73iuVTDw+pmfzl9P+t0fZ/FRQEnX4pJhtrTvMMdqvPxzI/2qhWV8gXOgZNZiDG
	7J4NW+yJMIfHSJyw9TYyI8zW+lhmXUjmfZM/jvU4qUQmM3jGWh9GREIJ2rZkb9nP
	jJXcKQfZBdnRv0XCUFXOcXJt6TqVkdgcSz8ZIT/+Z0kwtZR7suVNthRA4rYNtT80
	TM+qcGP3Ukr4Siuwx+Y2vqgFDL5No7JVt1xgfmPViomT9yvKGDZqTclbnldax7C8
	h9S2q1PbWayuGhak3LhshJGr8As1ksBEB2tDw6JbmfMx2K+RSVyFjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkd6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFC3aVL001157;
	Fri, 15 Nov 2024 12:37:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ch2kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6lcbkEsG9drApjn13E6GcxO641+zMNTxd25WGUOtU2iBUK+5OlFkU/nAZ6HVjqKh14B1liQKWZz4WyS/kjgK0q1XImf8KEW1gpqvVM9VC8ON2ivZWaMS8G8RnPi78q4uZwnCxAN5rutZHLSBbH0WeLQy8CFxSOPB8S0m7tuzfHKRJDh50+d9fKacmo8CyB+12aDH2Q0p3w62S9e6iSwj4z7xEeSh7aj/V7o47nFbEmVtNt2Wd2G9X1ZmOObsGHj6MZuMWFLdXhdfVohloWiV/MGzzdkdfGicSybX1OtJyqoCUzxKtVM3Un4FyFaMPqa9kTmykS3u2ihGyXLgFqFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gHrl1XejhAfXv8XmrMN1N43hg6mIRwsTQBCZfRqvGE=;
 b=t5s4+uPRllKha8tZAuTAegLBEDXTg+dSfHnefJik+Zyawa7UaYsSECzh8zzAgr1CdE2wzQgKmSUCZtHVgobUhtJKV+A0+d5ZuQJOpnp5CVVCr4HKc4u4fplbiYrVxdCOFWJHNKT47lL57HDnf9pVRg4agZAapYfKqHhPS1By6XASa6qVh38UKg9AgKK7zsnzlftrQBVlr2LyPoLNbPUnvJ9voOSVokVi3+jS3VynRc5o/DcBSXDV4r2GrjmTjAtCVQK+Qsxvt3fwzreapMXF8/i9eDWnp4awAP/Zq05H0wz124+lcNHkKv/h5h62ZzK44l3akdJTmk2TZ0SwNblyhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gHrl1XejhAfXv8XmrMN1N43hg6mIRwsTQBCZfRqvGE=;
 b=Zv2R8pbrAl15H/AgyH9O2bKWf589rJNmIwe16/RSTfe+yvbpy+cNNBUxGNG/SICDfWAcDZYf5B5M6wHeLY0UByJA8Mk/6r+CI6wL/j2PgjakhhyFPFZMXYSrTYoNz8h0XsCpbCO9aNeXZtXM0LDVC21YDctQSBvUXR3VcJXHIGk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:37:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:37:01 +0000
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
Subject: [PATCH 5.10.y 0/4]  fix error handling in mmap_region() and refactor (hotfixes)
Date: Fri, 15 Nov 2024 12:36:50 +0000
Message-ID: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbaf16e-75aa-4064-3747-08dd057233d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TTD/f/tJTI+NNxAET08lpy8UlcczSyAhoFUXLlfm9TviFpnLKNVwvJr3Bq4P?=
 =?us-ascii?Q?XofChmr/LoA3sUPoLAV5n5RYHCmr9V4Y543Lm+19hvnCQYcgZGxc7Uc9+PZo?=
 =?us-ascii?Q?mIxjitlg5mcVleq9tH47c1ypDHeFkFYombUi6sOAqypr8FIRCi74e1XKH9Sk?=
 =?us-ascii?Q?Ce8n78c5wDcXmNCE8lEFi4zH8frSBgc0ArCNtrLFob5R2lk6dtHGly+11Va2?=
 =?us-ascii?Q?l9KB5YdE3/KjEmhtj9u2A70M0Uo5o+ca+EhtAQ4imRmrIgDOTYVqhvnkp55W?=
 =?us-ascii?Q?drJEe6UQhscqEpZyBu6QX0mrp3/ONpeFsBI/eKZStxGxImrvgXBir3gF6DDa?=
 =?us-ascii?Q?cqOJHBOAz1tq6ebKzNk5xCyrfSeBKfxh6Mk59qCaZbMQKk9WwmX503T1NDqR?=
 =?us-ascii?Q?TxDxKtQc0PtugnSNdnntVFNyvX03chFi4mHQiPp8WCS3geZJhWkmVxcemc1J?=
 =?us-ascii?Q?7/OnbYcP3yf/xxRbr9EHdIYydhF89yEflGTQidA6RS+Abv99AEBf19uL2Dr2?=
 =?us-ascii?Q?Hnx6Fff8rvbeHjC4oiMTTwGKq4kAd3v4pGmejs8kycKdzpStHOW1OSq1g03k?=
 =?us-ascii?Q?vYlg0lkiLZCstYyppdwoegzJgIZ5o4+hCyJyNmejo/W/uG0fjnZulOYIDgXK?=
 =?us-ascii?Q?wG/sVYrbvbKNZujVEYQDkZExBEo9CX+yDZ56njmfxtPx0DYjrCdPlokGjePE?=
 =?us-ascii?Q?MxjXEz6eC4tnTJsxdBJmU1K05Ka9B3/SMossyPLXnLPPUIFzbKXf3aolm8pZ?=
 =?us-ascii?Q?Di7SWRl847qCPm5h4pNL04qIU4xA4ylpI5w5pMg3FaxdFJpwv9sqRRGehps5?=
 =?us-ascii?Q?oJMd6ht7+ZLQdQMoWp1hiUJipJBJiHeD1f0JcC/cPLN+LQpxcdmwWr7QV42y?=
 =?us-ascii?Q?4LX7WiZv6AY/sbkXlRUVw26egebcTQ9H8YOZ21m5GLfVlXLNny2dujMJpxUb?=
 =?us-ascii?Q?OY9jbmE+pIEZ80GXjIPIp7isCzAg5UfYiMj1YBbCQQgszFdeDk2vhRdbIaDT?=
 =?us-ascii?Q?ZbibGlHcE2E2dhYX6bSlF88p93falQT5vh4S1PK6otihOHallYbGwNduntU3?=
 =?us-ascii?Q?tJGnOEO463qKklukFUvQFyASHe56NFLcFhz6PU9vwbxj0YBAgw/vYyVB+4rs?=
 =?us-ascii?Q?QVi/YL7Erdhnrwap1vkb08iH8hdhH0+QkQvfwC4Kc03oAMid9xxJUGdseH0R?=
 =?us-ascii?Q?m5niaqn1NfFZhE/lzvnSuxO/VWh7a/LSlqUI5OhBBM1Krc9Iggeq4lEBpZF7?=
 =?us-ascii?Q?6Ps2IV7ZT+u/pfpjY1/3a/1e6E9dXEvHNJcQvpLBrAoYuIEeyi4L2z9PXggA?=
 =?us-ascii?Q?+amiq2KRwE0Vlp2lddLrq9hs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKnTggh3CqjGvJIL0ztQaeRqG4KJo2N4J1ikRrtiCTKFQ0Me+z9LvedPYYX3?=
 =?us-ascii?Q?thpy6hKgF0mwQz6Ufg5gbvt+Y7wER6CVM7x07rbSIv9uPFhQPBiBRnCHhDDX?=
 =?us-ascii?Q?3BeMZL1sxNq+L9+JoLaJBxZRjJO9Mb6/noPXoS8WcBt9G9IxppIz9gMBAVLe?=
 =?us-ascii?Q?Mofym6JLa1MF75ZGPEXEzKaI2I25k9funCduq9R5dn8HC4euB0pMw09kfvGy?=
 =?us-ascii?Q?MSA5oqEZ6wY7GTFQ+V4K5vVSeCtPecPu8nRBw7CDS1NR/xcahy6tlfAUvZwC?=
 =?us-ascii?Q?qCzZo52is0MInTvtzC4WoqJyqKg6AMPsmw2WHxceg7kRp0yZE2fwobxNIdpn?=
 =?us-ascii?Q?DUHR7iwBtC2Xy20S35juLVu2iOkcvjj9UcGe8xhsevjmW/atdBJks4Sa2lWc?=
 =?us-ascii?Q?7wuTM3QKzPFB2nJ3Lia3KijtTbBnpKn4DtBsUmDtBSwBz/d4kiIJXEqlU0pz?=
 =?us-ascii?Q?NiQbmo/t3kojlEUva4VupQVRDQGeaFqRB0IHuqHyTPAWLUlELyUUp7nyMfQc?=
 =?us-ascii?Q?6vbdb8XYhEU8GKhnrPlokzib+CCDAVZJIjCpCj0qzUGtmIvWBBX0ng8nzIXU?=
 =?us-ascii?Q?G+PbJF76DYhZV0xZY7SQEkQna2ZfDAiUJVQsxo3xCJTgVwjoT/WX+bAGvhsq?=
 =?us-ascii?Q?XJmz8TPeRS6RXVQMRiUS/C9/vItWsQK9+HTNbTVkI2qiAgQFxv4XTicTVF4Q?=
 =?us-ascii?Q?GPFdDJbKsCbs+T7MkRj+o5i6Wk3O9RMZKHUNX0P9WqW//sD3cP+xd8XxTiAq?=
 =?us-ascii?Q?b5eNRkhO43PQ3CX2ClG7Cdd0iX7VSGJjrIS3rM2dOD1wh8cPZh4AfUs5Yqha?=
 =?us-ascii?Q?LrGuxraYB4NSQJdmC595DhE8uYcx1CBDeyVluRKDnAdkHDRrHeNA3dpjTN7H?=
 =?us-ascii?Q?qkldAR9rsMJJ4nvDHTnlmOGGFNigsVWN8HEhNu3rLOv0uHMuvq2IgWrENyzn?=
 =?us-ascii?Q?le0uoSaxW8M3RWJY4MSXk1SpmGGByeoaoqAfQ2Y4kE9PStpzT4SsTU4Dr59L?=
 =?us-ascii?Q?zBmh8gk8uglCnbR4dl+oJn1+2A4XUgOUbC9UnmhdwRhFm8ECFzBabWOv+r/F?=
 =?us-ascii?Q?VPVCv5IWozcxg0ZyhSFeC3ItbKeiK5ncItlOeiQe1WljjzGOaDbMrjO4h2q8?=
 =?us-ascii?Q?yZzewVIfExiozc4k7v3JojRVD1pJo0QzCC1ievxKx28O2PysF5Ss00rf0pRJ?=
 =?us-ascii?Q?8TkuCZ0eTbcpi65d71KxwP3UM8TV6wzGdKVE52haxHtItx1S915VGaDIdhGc?=
 =?us-ascii?Q?cHNeO4sNZq3dtKR9OOnu/0srfQaYUEZlTf18M9JWrCafYmXCz0jaH1XjPImP?=
 =?us-ascii?Q?2v/P9qjzup1dT4bc9V830TUBWqL3kTqueR12rk6LVD0SZVvuvj3iv053ALFp?=
 =?us-ascii?Q?OAeQJjKYHpbVaoPaGLc3IPOD/myPvCapjvvkehVh6JNTEZkMu1INYHer4smw?=
 =?us-ascii?Q?9Zu5wtqm1PUTMYIXj9pJbSCXXQlqFx4z/5j9anyeapf6fLgwrUZWE9ygQ8Ye?=
 =?us-ascii?Q?bBUdFjr78YbJz5jY+Ch/b7kXj2ZWTqbdEwHIDq3ZP7OHJJ+w1EEtH/7uDOOx?=
 =?us-ascii?Q?GRo+U5DLDF3QXo8bKq9hfdX4gIdexeDjlCpTCxr2Nx6VznQRj3ckcxLHc3cq?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/4fnoR/OIkf3c+XbzrghPLmvt5dAk7lK5a5xwyNLun0vD64GVBUX0aV53fMBmprKnpXmYvsuHtxUfX3CDuCatO45dNZnilbkob0ZwViRTnpFvlSWz9txnXhSrW0tzbaMnwpyGY7YFO0IhYSSQy+ECDrEQ53wtjMzCHxJS1GwpVEQNaj40uC+0LbpXc49AEO0UFy/hSDXyA0Zi5Bfthbf1b3VeHRDJcWZ3trZoLPc4xHmOpS9Pyam16h8gsbIp8Pn8oYhjgLYVPAqpHDsrJzPlmD5tzixVO2tO0H9SasAgXHxNcRhBnLjRHPwEq/WMg5y38VhSNHzepu0D9AYjF5COg6ZOvqRh/wyLzIET0mQVCFXD+1yvG1ftFYu1oMZs0tufDM+x1J6I4+YgrNQMaakfGV6mvMVn2qa9G17HFoAQv8STpsX77r50DiyRHfSONOLRuc/VoIoIPNifYNzIpWqRikLKePCRPrXBtU0MGyusH2Js/HBW1TitwbEP/UMZZ1v76f0st+6DkF4EVZwyaIehfEz7h/5zDcsRGTT1duzWDIFRKZyEg5+BFfsllKbG4JYCCeex0qUx/qmj2uBlU9MfAgtPZW4vIil5mIN6lSZEI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbaf16e-75aa-4064-3747-08dd057233d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:37:01.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Os4PTn50ga6qbX8yV5VzOTRjUPPlIrCIK0rAloo0pw2rqSkhGJGqj06S6tkwVtyLeqP7fGbqI0axaEOi0zMcchfFPa1PjTgaH1nVGgeN2ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=646 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150108
X-Proofpoint-GUID: lvIiO2g5qGMWgv13lmeS7gHR5loc90zE
X-Proofpoint-ORIG-GUID: lvIiO2g5qGMWgv13lmeS7gHR5loc90zE

Critical fixes for mmap_region(), backported to 5.10.y.

Some notes on differences from upstream:

* We do NOT take commit 0fb4a7ad270b ("mm: refactor
  map_deny_write_exec()"), as this refactors code only introduced in 6.2.

* We make reference in "mm: refactor arch_calc_vm_flag_bits() and arm64 MTE
  handling" to parisc, but the referenced functionality does not exist in
  this kernel.

* In this kernel is_shared_maywrite() does not exist and the code uses
  VM_SHARED to determine whether mapping_map_writable() /
  mapping_unmap_writable() should be invoked. This backport therefore
  follows suit.

* The vma_dummy_vm_ops static global doesn't exist in this kernel, so we
  use a local static variable in mmap_file() and vma_close().

* Each version of these series is confronted by a slightly different
  mmap_region(), so we must adapt the change for each stable version. The
  approach remains the same throughout, however, and we correctly avoid
  closing the VMA part way through any __mmap_region() operation.

* In 5.10 we must handle VM_DENYWRITE. Since this is done at the top of the
  file-backed VMA handling logic, and importantly before mmap_file() invocation,
  this does not imply any additional difficult error handling on partial
  completion of mapping so has no significant impact.

Lorenzo Stoakes (4):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
  mm: resolve faulty mmap_region() error path behaviour

 arch/arm64/include/asm/mman.h | 10 +++--
 include/linux/mman.h          |  7 +--
 mm/internal.h                 | 19 ++++++++
 mm/mmap.c                     | 82 +++++++++++++++++++++--------------
 mm/nommu.c                    |  9 ++--
 mm/shmem.c                    |  3 --
 mm/util.c                     | 33 ++++++++++++++
 7 files changed, 117 insertions(+), 46 deletions(-)

--
2.47.0


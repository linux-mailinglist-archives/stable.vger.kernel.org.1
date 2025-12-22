Return-Path: <stable+bounces-203178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDEECD4892
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 02:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88CA3006A65
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE01320A04;
	Mon, 22 Dec 2025 01:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="S5sTXqAc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D125FDA7;
	Mon, 22 Dec 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766368658; cv=fail; b=p+o7mv9OQqJY5HjxQ/4I2R03zogClh7v3M19Kypt9bUIjhU8w+Qm3yZHld4j385xS5tOh+aOgsC4YvhrDcjV9uF7o5tQNYUY5KQA8bQsO+T0D9A2jUPkMgHMH1wcCYO2p6BrvCuNQTLUUTWJXd5N/utXDyBHBsQrJzO3aijB/bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766368658; c=relaxed/simple;
	bh=DuWuK+TWX8DSWC9irEceB8pJN7QZjXaYLyKgtfTjS7w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=psGkxHyIMxSeRitVIyBgGEDUJjoeZbYNFGv3uGlgk0E1/4fuQKQP1nGB00EtrqWNw+sMiLeMSlzIXB5IDxIW9xDeUMqGFfKe4lxN/OIJ4znDVyRhFi7IKr1A8I0R8aU0JaQdpfWUOWWZWPmAwdhDYRBH/hrNrfaNw6446yAZHjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=S5sTXqAc; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM1K2LS3273546;
	Mon, 22 Dec 2025 01:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=50G/gfPHb
	2yvf4y8B0nim7qKAKZa7I8+hPmWuv5v90g=; b=S5sTXqAc9OTLfB0mbZWjZDqil
	+AksDZtGj4jvu9V0i4xgkp+Xbo4z3XUz5jF1iVfn1K1PpIbk3zwy7m5ZcHgpWQRd
	Zdh0QdvdNB93bDtX770d70OGcDgx4s56ChjsfdVEOKyRpcrVGPv63p7cVBrRxUWC
	E1CP+Bxr/6M+XtMi00uXNvwrdNiemu8IS6/y7vNdbyXmpIhJdxa+FbzSuhXg4/qm
	3WXDB35hlhTLeyFJvS6exUJWmLmmXKf2kKY8gjkuXPNcJWdqVig+rOstvXQXbKNc
	I/O2CaZpW/j6T/rvwEMx0g8MCTVzYeKiqr5TyGv44uP47P2LvWgobsEBl2hjA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4b5h0vhcs0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 01:56:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2bBJFZfsBTlSkqaZpYAwU2D7/OgobZl8TtWwTbvulB9wUxvq/m2ixHrBdxE2ed420YGBb4RbUG3gy0aptLZvqncRVnzCAofWRbIEO3HUfJnbgizOfNnOmSyxWoGiA9CIC9ewpFXJjd8HNFs7zY7/4dXcDa4HzSRkeczekvBKzJnyYtq+kxBKzFBPDXS879FPEUh9ynuvgoZgZDdOmTp9gcAM1+l/KojslwrK4wdReAu0rjJ4XRff0d3yOzOJi6HBfglsQEKrYBwTKOJAOm9k6ww8NC+zgzA0qNxID3yf7HkS8VKzQr794ge7N390YD4ziEyVBlDd6NGyWhYhaadEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50G/gfPHb2yvf4y8B0nim7qKAKZa7I8+hPmWuv5v90g=;
 b=woT0c/hWcRZcEEld9xzx7M5Gwy1aTLFLlSOZPyuOyEnlW+bWqgiPkmWfupTnTanML4W7PKsElKAX35VCoDjZpu6+cUKmhyUP38h0XskAYy9WRxupI+GVFPoGJwedxcEVzpN1FSKmrnkHze3WXMUeQ/3fsSarSy3kb2RNuE1vBRK6mil0fqrmImPTP9BZRsnhHxtv5qeVIzm4KW03FM0NJrNuiHdmoT6X7sGKidbpTldR3GPt0mNMLRBnl5Vmjb9gABTFbRz3X4oVH3hSMBmJFbvHiFpbt0lSwDEde5r1Nj7kx7Xi1NngxsJacAhOl1buAmE7se0h/+HA3nzDgUzmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by MW6PR11MB8439.namprd11.prod.outlook.com
 (2603:10b6:303:23e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 01:56:53 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::56cb:3868:6b6c:193d%6]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 01:56:52 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: pabeni@redhat.com, nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, rmk+kernel@armlinux.org.uk, Kexin.Hao@windriver.com,
        Xiaolei.Wang@windriver.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: macb: Relocate mog_init_rings() callback from macb_mac_link_up() to macb_open()
Date: Mon, 22 Dec 2025 09:56:24 +0800
Message-ID: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:4::32) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e60f74-17b7-4ec3-bf6f-08de40fd606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P8wueKOGfEc8PyP66vCmKMwHyFH9TsbAz+QfR6E7AFiwNzj0aUOBOCK8c4zH?=
 =?us-ascii?Q?dIT22JPaEUs5trqwV7AoeYgC0wjle7kRDztuQqYn1VkZ5Keyje4igqhswUSH?=
 =?us-ascii?Q?U2kjubkWA14D97glgt6ubI+vcNeWse9VVt12S2auMcdX/updpY017zzPiiSh?=
 =?us-ascii?Q?T27Cy2AAyXdeMtID+Ntxn3uMqgSvKPhorbLT5UCZQJjTDVqbl5iv7HEq1J8v?=
 =?us-ascii?Q?Vn8Ny+e6UdQ9PBrZ3GtfbkfsWZpI8GMby5ajbNNPb2ajvwcsT0yZgSIKZAxI?=
 =?us-ascii?Q?AcgS+MK7Q7WmCFHcfrJtHG6kLJeClH9NpZLK2KFHrpxAfRsVd0XwSH8nutki?=
 =?us-ascii?Q?gsVPlq/3RD6ulCW+Y8enzjUZhBjHij3F1zRmt+liGpq7G4G9gUmoLuIREjxH?=
 =?us-ascii?Q?sH8U+W1qRMN27zdEWvF1/ALYswr2iFdCVl0FtLArnBfCH9h5m65xTyUQ/Iso?=
 =?us-ascii?Q?MtdW+CKS8VPxtBtujERp0SdsXUjjEoFZrOE3W95fkkqlyL3Gc/AKKleUimvJ?=
 =?us-ascii?Q?0AN+x3b2Bx2RZe/FNMAdyyhtvr1QSz/jC1iwNNAlYKRYvssPdcwtR5bwa74X?=
 =?us-ascii?Q?PBd20aB8hNFPrEnAKK/ufoBhwN+Ol91r8FP9b7ZozzrURiQVNoJBxvtIfePx?=
 =?us-ascii?Q?FlQLEZN85SAVEgvE5N2sV84gNst9hL0njEeCaqyZD6Gjx1JkxO5vcndLvQVg?=
 =?us-ascii?Q?TFSUjg7o6VKPMwWiuELSsrKXwm8LQzLUXnl9+XXiHC4vjoGBdw/kr4qaSzsp?=
 =?us-ascii?Q?NXQEe82KQe/muo5bmtx7xU1YCr2dMjw+K4WRg2gylQ6gBlt1/p9uvnQwBhfp?=
 =?us-ascii?Q?1bzhGHtaFdSGVQ/8SHYXTbZ21eBzq8sBwF0eerijSxMUWyG7MrRBA9ARuwHM?=
 =?us-ascii?Q?02IfgDUO74dOun/Mh9bi8JL7d1aAFYjnTiSiVxw+/uOgDsT+4Gq7XxUyi4Em?=
 =?us-ascii?Q?fQgd9vF2fZw/a3Nr8r+fURCNJVOj3aZ5KgKd7M/K59X78wghNSRXZFLovc3R?=
 =?us-ascii?Q?r6/Soqr9R6qlQMj6ggcaDoJGP0aH1m0JbAyFG6ztbS7fWoniCuHy/jyV+Ape?=
 =?us-ascii?Q?4FAW49yiJU6fv8XWdPJsSBDwILkXaoURz/t69T89XcdCZ+6xxgfSGUIiVQT9?=
 =?us-ascii?Q?1X3X6rYjLLc60hnZH/dYIDIMvOa6tllJ4RWRxCA54B0Go6n1cEKVPZGkHqTS?=
 =?us-ascii?Q?AO1kiyhBoZEXqG8NlpVvBygQO6jjWTeOzi5qq8tE01hVndr2mGb4qqSUrxJK?=
 =?us-ascii?Q?HRCQGaFCvY6WwJj8b0/EVzvqHhrLRg6gbSIgJciOLePcYE4DKKMOBzYZ7Gc1?=
 =?us-ascii?Q?UMTkSScOVNgTrtsRZiADSnnyi9DDyHv/BeKzmvql5XfmkOo0/YLCrbQOEaOj?=
 =?us-ascii?Q?933g1kDXfavTNfUcslP6Qm+DmFlG0SPGzxXodAn/Mf8PyFQEUMPxmrefr90+?=
 =?us-ascii?Q?vyMqSdspiiDucnGm5FKEbFZ1QWewDPbZYfqe/TjDRsex8cMm0SHeZ+WshZf9?=
 =?us-ascii?Q?V4AkVY0mRESk+MtwXOBSKj4gAEvbtuwm09UEMIpW+8+a7boZ0nx0W2XqHQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgvnEoktOnHK7zIksQEo3e+O38ZqcntD04nbIRud1ZuIbjopPuOf94veMMdO?=
 =?us-ascii?Q?MMQl92Ss2tPPqp3unpmBLnlRDb+wvgoTe/9pulwTVbOgMlvPspjBJLuU+ZlU?=
 =?us-ascii?Q?JJth1ve5XJAr52z9Pc3QzlpMYlTMzxs0jmVh8ToqpKILuJD71ql6RVK+8kNR?=
 =?us-ascii?Q?Qc3MrtvFPK6OPr5Y1PFD3+M42s2Zi19yK28W85qXCwzZZqBN/aOUuVYtASAB?=
 =?us-ascii?Q?87ghphHs93zgw6MGDQ4+8rdIJy3ECHa8u9RqI8tv95yR4i183F1/DJYewNbP?=
 =?us-ascii?Q?b72sCo1toRKG/IlzJfUSppCcDvTpP8YsQgkEjA9ncFtK3X+U2v+x36I5fmWH?=
 =?us-ascii?Q?3sggkjdKxJmWHTEQx44ihJ6z8AOue/Ynov1GPycyi9imdxRXgPZ548M+KO3l?=
 =?us-ascii?Q?x5entvMdZkl9f//B9neRPex3mzursWzSvYAfA9YvESjyYEQl+fqDzyaaKXR0?=
 =?us-ascii?Q?umVc89j8NAfA/74D7MwpqjOkLi8qjNScoloufBfHF+8huC1viJYVUdKYzmpK?=
 =?us-ascii?Q?TuT5iQlBkp5QvtIYPf6ufpG19Ba5G3Jyw0aHb1oHQWBWFg8tjUXYiPiq2So7?=
 =?us-ascii?Q?4S25EYFuaLhY1e3EwWh6/+jGkiDgw2sH/VY8jYBODnYQEqf1m7aK+cDY7QOC?=
 =?us-ascii?Q?E8ZudcO5pbPZrEWvIGZyzxUrJL7Mc3QAhk91/f1l7HWGcP+yKH7W/ClJKBs0?=
 =?us-ascii?Q?yMpGPrEkNcfXOisQgm4kjZlZS8OJZ7XYNnz4WIrkdZAxp/6n7mYokpu7REE3?=
 =?us-ascii?Q?e0++lhXInu06AN35ms/OQp23UZdYgTUJRoO5W2SQ28P7ms+JdtXLldY8UcbW?=
 =?us-ascii?Q?vlyZpGMv9UA0Qmg110s23IJxu3KG3Q9gorLK/x/r7Nchol7rKSjP+z66bzrh?=
 =?us-ascii?Q?ReVyil3Uk0BQfXds8kXJ8ApKOESqnAsHGpgWP5GYelvc2pccX+Zd5WBnTEe0?=
 =?us-ascii?Q?BJMhJNABUWhoD7v80Zt8cD3sKDtOPuZe6YneadjjPwGmDHC/nFjNUYkVxCnn?=
 =?us-ascii?Q?Ymc9elEF/Kl69VzFnJJ5naE1D66/cyMI2tN7RnjTJLdv/UXmLF6ztY5Nvnwa?=
 =?us-ascii?Q?7kuHotfQVkFc7IFMXhNtmwUmjqmyjjOUJBNIh2m3qcGGC7Kiqoru/LZiu8u2?=
 =?us-ascii?Q?xwdIpZvrDgxk7YXIreBQW66eDdaZVPEO7X3EVFEfoP9Vadgep8xpjuujWDlB?=
 =?us-ascii?Q?YOpSSnmOpB6bRzSl9ETFz8CuwdoLrZ5vNIJktYmbm+A7CRvssYZkaIPLfWLJ?=
 =?us-ascii?Q?kOSInpoQx9BWE+lV5MvNfKisqj8dchUNA2TR9NwMAdK/kUxSJnuSzk6v9LVB?=
 =?us-ascii?Q?NeReg3ABM64p+hLEM6hTELdhv/o03LT6mYUvDRlJ0Xq1Z83b5J+IyhjuGWXN?=
 =?us-ascii?Q?53CEAntHRtfX0r5nahERQiNJOy+60f3RdAp7fPaqR9r3WSqMZxOhs1aJiMbd?=
 =?us-ascii?Q?1j4b10XdKxo2+uu10Cy/otKkJrOa4iZLz3S+aBs013EbolZXKFLlsvi4Os+U?=
 =?us-ascii?Q?kgAgltcL5JJtW4grkF1ojB5AWsf6yW3uKkL1ScRwUKvhYGJUTLHTnrwNJCCM?=
 =?us-ascii?Q?S/Z7E81O71acExYI3zz9J4lYsj5VOXOeOO4CWypMsF4eHXWYR+oxuNKftRB/?=
 =?us-ascii?Q?MEW26IbbYkUP5FBQiJDhkpL0SBnWcyDVv1QMU4zM1ge6DbWtFNEPi1JT7uaA?=
 =?us-ascii?Q?QZhqD348wC1+EU0AuNkW5O0L8MkIJjzrfQvpv2Nsy63nTh2W6wWUCp3PnW4M?=
 =?us-ascii?Q?a9LThL8mKvcLoPmKot5VmUWhuB1OnJw=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e60f74-17b7-4ec3-bf6f-08de40fd606f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 01:56:52.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC4YTa73aPbK7jWkB/illR7HrMES7jVnXzV9u0SCK0Ed0KESmjq53p7fgWEd5YXgbRT/ruJDtkoGAwkL0y/4J/NY5CqI1wdkyQQc/o8WlWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-Proofpoint-ORIG-GUID: dBfTsaclKqJWJuBTSgEf9LEheQIaDm9h
X-Authority-Analysis: v=2.4 cv=I6Fohdgg c=1 sm=1 tr=0 ts=6948a567 cx=c_pps
 a=O2ROGSCZJc1UeeGV/dUHAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=j85lDDQFGdePOMqiiWIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: dBfTsaclKqJWJuBTSgEf9LEheQIaDm9h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAxNSBTYWx0ZWRfXzh4CSXuelvnq
 +L9a+ScPc8BdYA6e/8p90if0yWj+bkCFHbGjnyUne2CYSyIvzWPq2y6EmT4XAZa8OTaYT0RQjS0
 0lx+1OXrXsfb1zS8QY44DUCqFip1/XPbp3xyyYtWpS54TCs596Tz/q/b7o48uZkmHLwWAtIyJ5O
 Ul4HI7+KHtAGBAju50XMGj3kqNgdKw7yqf76mAwM+cIHQnrXw1tExCuvv941CiYhkNRB07xWc2Q
 Sj4vUI5GrB5Zr9cqoMz8HnJ8C9SFdTxpNPzZcVhooJolPzSEYNJnO0jpmAloStidKMss/p7UDN8
 Dcnkh8FefDkvnDNiIyhdifAJtu8mvN/QdmV4bMcfBFAUo+gbXPHUykSy0hfx2yk8efwPlc1nAIa
 XzqaVUj9T0i5I33qEG9xtsIv4OEK38p19jJsQ5z3oYLoDg9oaJh02No3GOFjphfk0ovo8Zz2Elx
 HmZDQxZR3Tn71CDrpWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220015

In the non-RT kernel, local_bh_disable() merely disables preemption,
whereas it maps to an actual spin lock in the RT kernel. Consequently,
when attempting to refill RX buffers via netdev_alloc_skb() in
macb_mac_link_up(), a deadlock scenario arises as follows:

   WARNING: possible circular locking dependency detected
   6.18.0-08691-g2061f18ad76e #39 Not tainted
   ------------------------------------------------------
   kworker/0:0/8 is trying to acquire lock:
   ffff00080369bbe0 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit+0x808/0xb7c

   but task is already holding lock:
   ffff000803698e58 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit
   +0x148/0xb7c

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
          rt_spin_lock+0x50/0x1f0
          macb_start_xmit+0x148/0xb7c
          dev_hard_start_xmit+0x94/0x284
          sch_direct_xmit+0x8c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20

   -> #2 (_xmit_ETHER#2){+...}-{3:3}:
          rt_spin_lock+0x50/0x1f0
          sch_direct_xmit+0x11c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20

   -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
          lock_release+0x250/0x348
          __local_bh_enable_ip+0x7c/0x240
          __netdev_alloc_skb+0x1b4/0x1d8
          gem_rx_refill+0xdc/0x240
          gem_init_rings+0xb4/0x108
          macb_mac_link_up+0x9c/0x2b4
          phylink_resolve+0x170/0x614
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20

   -> #0 (&bp->lock){+.+.}-{3:3}:
          __lock_acquire+0x15a8/0x2084
          lock_acquire+0x1cc/0x350
          rt_spin_lock+0x50/0x1f0
          macb_start_xmit+0x808/0xb7c
          dev_hard_start_xmit+0x94/0x284
          sch_direct_xmit+0x8c/0x37c
          __dev_queue_xmit+0x708/0x1120
          neigh_resolve_output+0x148/0x28c
          ip6_finish_output2+0x2c0/0xb2c
          __ip6_finish_output+0x114/0x308
          ip6_output+0xc4/0x4a4
          mld_sendpack+0x220/0x68c
          mld_ifc_work+0x2a8/0x4f4
          process_one_work+0x20c/0x5f8
          worker_thread+0x1b0/0x35c
          kthread+0x144/0x200
          ret_from_fork+0x10/0x20

   other info that might help us debug this:

   Chain exists of:
     &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&queue->tx_ptr_lock);
                                  lock(_xmit_ETHER#2);
                                  lock(&queue->tx_ptr_lock);
     lock(&bp->lock);

    *** DEADLOCK ***

   Call trace:
    show_stack+0x18/0x24 (C)
    dump_stack_lvl+0xa0/0xf0
    dump_stack+0x18/0x24
    print_circular_bug+0x28c/0x370
    check_noncircular+0x198/0x1ac
    __lock_acquire+0x15a8/0x2084
    lock_acquire+0x1cc/0x350
    rt_spin_lock+0x50/0x1f0
    macb_start_xmit+0x808/0xb7c
    dev_hard_start_xmit+0x94/0x284
    sch_direct_xmit+0x8c/0x37c
    __dev_queue_xmit+0x708/0x1120
    neigh_resolve_output+0x148/0x28c
    ip6_finish_output2+0x2c0/0xb2c
    __ip6_finish_output+0x114/0x308
    ip6_output+0xc4/0x4a4
    mld_sendpack+0x220/0x68c
    mld_ifc_work+0x2a8/0x4f4
    process_one_work+0x20c/0x5f8
    worker_thread+0x1b0/0x35c
    kthread+0x144/0x200
    ret_from_fork+0x10/0x20

Notably, invoking the mog_init_rings() callback upon link establishment
is unnecessary. Instead, we can exclusively call mog_init_rings() within
the ndo_open() callback. This adjustment resolves the deadlock issue.
Furthermore, since MACB_CAPS_MACB_IS_EMAC cases do not use mog_init_rings()
when opening the network interface via at91ether_open(), moving
mog_init_rings() to macb_open() also eliminates the MACB_CAPS_MACB_IS_EMAC
check.

Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---

V1: https://patchwork.kernel.org/project/netdevbpf/patch/20251128103647.351259-1-xiaolei.wang@windriver.com/
V2: Update the correct lock dependency chain and add the Fix tag.
V3: update commit log, Add full deadlock log added explanations: because MACB_CAPS_MACB_IS_EMAC cases do not
    use mog_init_rings(), we don't need the MACB_CAPS_MACB_IS_EMAC check when moving mog_init_rings() to macb_open().

 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ca2386b83473..064fccdcf699 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -744,7 +744,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
 		 * cleared the pipeline and control registers.
 		 */
-		bp->macbgem_ops.mog_init_rings(bp);
 		macb_init_buffers(bp);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -2991,6 +2990,8 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
+	bp->macbgem_ops.mog_init_rings(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
-- 
2.43.0



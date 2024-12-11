Return-Path: <stable+bounces-100628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A679ECEFA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512F62838EC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E700195811;
	Wed, 11 Dec 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="YMbZX4tJ"
X-Original-To: stable@vger.kernel.org
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE92246342;
	Wed, 11 Dec 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928578; cv=fail; b=T9koLINJyIbX9nkyvsqTDr5OV4sqThcf8Lg8QwoufFAQ8lsNztgCL/4uihiW+hp7APIbGr8WEk8V3k6STRlbLb8vbSiyPPwKyVRY6EyXvZ6HhgKelStyyO5khjaFbcZOKqy6LWnHKCeaOjZz3doV08MkafjO0Q88CBTvrLWYMBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928578; c=relaxed/simple;
	bh=hAycvSR0W+4PdAY9mog9WwtUwoBWPszeWSQcU6FdX+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RxBhr26CL6IJ+PmKy9ca1DgaZkcyOB3s/S1AlzuRhCyfh8jkYCOuc+4CM1xr9ESAepV/MtbqbXyhCM7WSl5LCwUKMLL/ICstNzxZOH2p5FsNWesU/K/bwLl+iPj9Mo+jXTG/Ip3HnwagfcFfd5tLQSO8YaXtz3LiMiSP7+Pm6Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=YMbZX4tJ; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41]) by mx-outbound11-143.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Dec 2024 14:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jwx5ggQxIg+cxJaoNA7QqybbMEWQqrYSK2q1Ia8T3uZ3zJiW7EmfTpxqfQnRw9B99O4p4r2SiR/0JgnDka8M8lf8UKFQY5lVQOjLwfQpZJNQ2NGT6qa66SoXujFUgdr0EgYHfIPzZ5ykSvnFI17/aqXEHPhIllB4EjQZUklo3YicPh6UcLruMuaqqbMOhj6xHf1MdQL272Uss63XkOFw6nKNysxmSm3AbfKaAM22HIrNFaPXwyZgErFUlIzEBFUugoZESKMWp7rbsiZvHbloQj1bag2l2XnXXzog9YIicW3cpdkQXtSAxeHHefKw007AtNiXL2ZA8vQZUXt3xe2H8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy6NEAgxSeht72ZATl7vQEEpQJL3sho3skWOSNR2GjE=;
 b=otcUBpk1UjtWr6J4ps1NqlrDlDOBa2VqE5fkw1LUBf07lABySYPb6YsWTRVAIFBkoX1jfNLaE5QYfqZPrq8J2QktAamk/fT7OOhIVrs9huT7Fzzlg8XCVE2eTrN3yU6QVx0/V0ex98ByotK76UnW9hDxIbslhDHbUaPvfXrXB++kgOhQXicvAcT3o3J5ygQ76GJiLQbLfP3i769nJC8kHfL3rvIM093b0NAdJUgyunnecZ52ywN7zQRmMYPj3LxT/fEKAaq+xtogKZ3+9oDXoh4X+KKmeWXOqKwnUnAdUD4JYWBvPDKptqNTNbmcSycn8UIOq1z+c234ZPcY4lbdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy6NEAgxSeht72ZATl7vQEEpQJL3sho3skWOSNR2GjE=;
 b=YMbZX4tJX7dkHQteFKuFO+JVPACc/kF5XbAqSfoB8c8e7OTYolvVFueHZlEfJteEFdGIQDXx4OyYXUvKXSo4plnWvc+lwahJFLN5QWAnGgrBz4kvBw2Fz1OXjwKFiYpbbBAczibuz5g3CsROBWn5T0QCbrlnDqGBk1rllINFtgOuzx17L3GdekqG2T4+niuM/1TG62C//MU0WaDx6xHRiWBZx6wLK7Tjo/udX3X5a9vT5mxY2h3nlx2iK9r7wG3N8cDCMVKbHaxRLEXEjS+2d75mtgO1JwfHffCd0ePNgUZICLGsKodvEkBTBhan07+RC+VTJpRjz9fRKFuGBo9wIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by IA1PR10MB7540.namprd10.prod.outlook.com (2603:10b6:208:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 14:32:28 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::ecc0:e020:de02:c448%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:32:27 +0000
From: Robert Hodaszi <robert.hodaszi@digi.com>
To: netdev@vger.kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Hodaszi <robert.hodaszi@digi.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_ocelot_8021q: fix broken reception
Date: Wed, 11 Dec 2024 15:29:32 +0100
Message-ID: <20241211142932.1409538-1-robert.hodaszi@digi.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0023.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::9)
 To CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|IA1PR10MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ba0de4-cc5a-4f60-198c-08dd19f0a338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wmvVk41cOrhNl3p024W/0N/WQ2GfE6ghlcnFA2gkV4tNYHNVUDSzbbOgli7E?=
 =?us-ascii?Q?vPkFBY85tJq3cV/kIRmJ2RIPJyYCOf9YUZV9zkJILXJiNLf3sY2TlSxomZBl?=
 =?us-ascii?Q?WkzFwLew9osLE84uazfoeHmwUPKa3kaqT5Bg6mRkX92J2S/fB52xjtDS52Lb?=
 =?us-ascii?Q?G1+47RLcPUXcLDztdaEOhvH6IGF46fhirU6KpfbgeBKJ/tJ7CshAARZE/pE3?=
 =?us-ascii?Q?rFgFA9jdihWg0WhrryIcB3Q7mtGxjFfQK0VqYu0YOhAHW8kcOGt7aAa0Cp3h?=
 =?us-ascii?Q?qqdDXnuENp8PdnSv/lQ8zXKhPzPehfW6NEeTlyRznpTTyjTmgTXeFB5IVb+B?=
 =?us-ascii?Q?9AJtseavfX+bcX3zqeBAl4C/8MfGjuCvQ3nYkQpIY0G2TPOF7KLutKFNJY1z?=
 =?us-ascii?Q?lRp/tLZcCDR/3C3xaDAFUtt8UnpsOVJSOLC1OGQh92EX8MF9WfHxzzF/pgk0?=
 =?us-ascii?Q?tZvNbIvMubjZ5YV0JBLja/l5OdZ+kslPrCELxrz6Vrqyfzt7Kzljri3dpNRi?=
 =?us-ascii?Q?Kx2Zju7tjD8lxAVJKOQ25zNCsLe5sJZTQBuhNnzrMt4/mA+hlRE9li4E3BS/?=
 =?us-ascii?Q?qv3nJ0Z4mLhqWr9rNtVFlh8h6Pnljh0h1HbciZ3h8C3kyobXHJ/LUgntC+pT?=
 =?us-ascii?Q?Zv+ACeBl26VyqNvh9h/EoZL9SKe2PJOUKY/vPbuwoJMAoQqFdK9n4z1E0JhT?=
 =?us-ascii?Q?FRZtkLXvUWnG0pfGMRnypRm8qaxU2hb2LYsFVzmnf0vmqFW/PiO6p/X2AWU7?=
 =?us-ascii?Q?J0YVK91UudYrYGYTbX786mWJ0N5qQ7DS/B0GsKnkWovH9u4FsjXaEuHNA/hn?=
 =?us-ascii?Q?S03LTHh/w15IOpUdMZEN7kLgObG2zIaEk8bWhZR5ZoFH3xJs6U3SQ/NNpELB?=
 =?us-ascii?Q?FNukumoUoRyYLjAPQym680J4pc1s4+Z+LaIv+N6ucRsGI6sho7sZe8Fd/Gep?=
 =?us-ascii?Q?2VrqZmP0XkmEL8o6llZEnYTNphFUNSsH5soQUZNnrcH94pkiSsTjW/MqR7Dm?=
 =?us-ascii?Q?Bd/LVnzcEh+agCHheZ2iSUohh4NVRHcuQeqwOzWIHpQexVs3CugXQA36V/dr?=
 =?us-ascii?Q?FDmodlXb/mP8s8AKhaJ8bCip/cP/3H90mvpg/APuQF3ta2HfOlpSlmbeRf61?=
 =?us-ascii?Q?xQZrt/n/H/z1MXAca+VsyqMGXmI0Bx1Q1WH40vDcIwFArZYkSfgpuW5eYLja?=
 =?us-ascii?Q?fSWsu6rKLVgs4biC09GAmSG0rKINZ3HCcTzuc/0PHIt/bTRHWgtaC8ibJ0Mc?=
 =?us-ascii?Q?CcTBh8grsxPuLmjASqIWvXoK1YZP7n7LiIzdnpRojQeDD3kNjZ7d9nR66J7N?=
 =?us-ascii?Q?xPsog61Kqp0BEnaLvlv7qPzgr85PjlgWgeuovquhiVuojo+kHXyEVWczbUrf?=
 =?us-ascii?Q?XNPyrPCZFR2x1hdUCZ+wW8Z3K9LXpdKZVZOVHdYub1F0FwmEAl5+UEfBGaCV?=
 =?us-ascii?Q?Ier8o9iT3DU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4WD0VSkb1nw2hIGg2vXx1joLRhjhtE0joLQMcAN9jJwhxkMq8phbfcBwDtc?=
 =?us-ascii?Q?seHTNHvHPVSETy3IPWXOdHz7axg+eZgSwV7YCq59wX/dCltjhslj0X8mFFLv?=
 =?us-ascii?Q?+rD0eFRkvchHUf2d7pbdjs9nPXnjvlpizVb5KR/JRKJzXzALS0td7tvplMZ2?=
 =?us-ascii?Q?2igu5HXPh41HdagfBb9sWzdIwNePhxmE0FyFckLxPIyBIn0ngcEYr+7aBeiT?=
 =?us-ascii?Q?f4O5gTi5fVa1VdrvWG6D2Rh4IDNPgq7uOLac+v+p+WjYjJ7D/SQUEZxgc1sc?=
 =?us-ascii?Q?R5XjEzOaL8FR57lXpKtB3YrwFdeI0CGt9cSTe9SQ+AokSLphYLEkfwoMs37X?=
 =?us-ascii?Q?2IX69JM/9Vo4Wu+92N534ngllwgarkexNezUL39D7ZXlfXH9C9bQxzMt/7m0?=
 =?us-ascii?Q?E2w9qaQeZT5x/MAKgZn659tRiCw49T7hHjX3Fmhz5InChI+iJQ7ZgM/4YFv9?=
 =?us-ascii?Q?EJey6Z+aA84E8w5czmo8nN1nuuNqtleNeW1axR/UoOK4PKUPLc5j2BnzqAi8?=
 =?us-ascii?Q?ku15cTkLuiRYaUSV2WQl9gFec6QdvARcXi7MzvgmG6a25YX7uRFaO+jRDbbR?=
 =?us-ascii?Q?7adKrIfCKhmHD9vzLdr0TNjkfaRHxZrXrduJ07qsMsmNJdRbnnJnhO8tD3dZ?=
 =?us-ascii?Q?X8K9SOA2Q7mKGcVSrd4OzWnsLVwz2RDKEkDZoAErJyIUem0zf9y59vjkwzfg?=
 =?us-ascii?Q?9dJTsBxHDsfJHY/WmSVqW60B4svDTBnya+ghyjwh/1NCltsMw7XJ/oT4zyne?=
 =?us-ascii?Q?BOsD2GFVrDmczScbbo/+9rmeOQ4+4aJv9fXNvGYng6os+Th3K0SNUurKl/tt?=
 =?us-ascii?Q?NV0qRIJbMO1qia4Dbag/lSY+jYKNr/ouOHjGAoIUhV7FYIN3SproYPhk7zKn?=
 =?us-ascii?Q?Y7JCw8vBkRi9HERCalFhd/h/LkBTi6YmzLJG4VblxbDvrToktxLP/tnvXr6y?=
 =?us-ascii?Q?rgt9F/kae09lIkh/lo63HalLwuCm7ehPLBlxL1sK7RuLVL2b/6qYWVJ35X02?=
 =?us-ascii?Q?BLk53DUrNMW2YdLI2Nkiw2Zw5WsRLtdCjZ46XT7+TtVjoJKIKm2+MBbD1z5r?=
 =?us-ascii?Q?G7Kh6BqXnJDl1o3KaWadnaT1S2TaRTKFDQJcGquJuf0ax4xKcy73jfI9U2hm?=
 =?us-ascii?Q?6NntYQRI47jAkJXbc4BqRuQnCsRUDFwSjN1x7rNMb6sEIk/5jD9KcplpyCO7?=
 =?us-ascii?Q?bDel943+eap5Iup2z/V/icj2Z8JYq7HmoQ+nXuJ3Exa8nSNpT11H/ROJZjfA?=
 =?us-ascii?Q?QwXV4FbDnJ9qvSn101UHlSkeXJNAff/fY7TsVtq2BKRN+ny2a1Eqv+sk+pWu?=
 =?us-ascii?Q?nuvj4l7leudkdLl3STFZH+aXoC3wiGCqqjySQSkXVHAKlbOgM7WkljUDm8zn?=
 =?us-ascii?Q?0W7V6beZ8RQvcj9f7miVezGydf/N6gA50ySxJTHOBrcHEARxlkoXCpLjIyeW?=
 =?us-ascii?Q?g0Z1s3ZSkV46qLrSDEkdGwXsgSF+oiqjgMi1XHB4y2L+trHpgQzpnOpxGDu7?=
 =?us-ascii?Q?FiU02C9isJxSDBbMh0XEGKBWRQWejFS/top+P4GsMachromziq0jQFkwJekm?=
 =?us-ascii?Q?tS+17a0Ex96j0K8wsthNtqARM0ahdd9jGkgGTRNM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ba0de4-cc5a-4f60-198c-08dd19f0a338
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:32:27.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6UxQUQO44JVjYW8Pcy4cVcsTCMMPLnH9ohNBQOYPv+cE3QD+lvHxMCwx0jHj9TQTo6hyM+JJuOLfMZXHGLWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7540
X-OriginatorOrg: digi.com
X-BESS-ID: 1733928530-102959-13391-63-1
X-BESS-VER: 2019.1_20241205.2350
X-BESS-Apparent-Source-IP: 104.47.66.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobG5kZAVgZQ0MwizdLCLNnY0t
	wo2dw8OcU4NdXC1MLUNNHUPNHQwMxQqTYWAE9kPk9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261038 [from 
	cloudscan19-160.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Commit dcfe7673787b4bfea2c213df443d312aa754757b ("net: dsa: tag_sja1105:
absorb logic for not overwriting precise info into dsa_8021q_rcv()")
added support to let the DSA switch driver set source_port and
switch_id. tag_8021q's logic overrides the previously set source_port
and switch_id only if they are marked as "invalid" (-1). sja1105 and
vsc73xx drivers are doing that properly, but ocelot_8021q driver doesn't
initialize those variables. That causes dsa_8021q_rcv() doesn't set
them, and they remain unassigned.

Initialize them as invalid to so dsa_8021q_rcv() can return with the
proper values.

Fixes: dcfe7673787b ("net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()")
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
Cc: stable@vger.kernel.org
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index 8e8b1bef6af6..11ea8cfd6266 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -79,7 +79,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 				  struct net_device *netdev)
 {
-	int src_port, switch_id;
+	int src_port = -1, switch_id = -1;
 
 	dsa_8021q_rcv(skb, &src_port, &switch_id, NULL, NULL);
 
-- 
2.43.0



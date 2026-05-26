Return-Path: <stable+bounces-254442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OOHFMz8FWqkggcAu9opvQ
	(envelope-from <stable+bounces-254442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:04:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0F5DC33D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 22:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC92E3016C68
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1193B27FF;
	Tue, 26 May 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="bPZPckyr"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010003.outbound.protection.outlook.com [52.101.84.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE46347BD4
	for <stable@vger.kernel.org>; Tue, 26 May 2026 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825865; cv=fail; b=rkqvGZmZyeDnZ/h41bwcvQ1DzjAi1FekgOKegdbnkyrQcglqJYOhGHDjIk5hufTXH8cme3hJALJAeDOlPQkMQr2T3pPafMCAvogDc2P4HIXMZn44GY3tq5w/nqiSk6If2nwKIxkRSAczZMy9sheh4Ww+xEScfkLAv+srRl6Qxx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825865; c=relaxed/simple;
	bh=td9y/sD8PNqMPEXvT4ITf8PyLyo19+hvJLIriAAz14A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PFOGhdWGKvugIMMg8bILyN7pLHJ0O6YH7q75JuRZV47RB759PihzUdSdJAfPX5BwkiLNlzjxoP7LWs46b6cS0x5u9RNjiq0SEo3OxFjPvoNnzcrHflnYESCZLPeeTKQ1DxxtUJMpNxxUC/mE3mExC69AGSqG/NZ1y1PTg4Pa0Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=bPZPckyr; arc=fail smtp.client-ip=52.101.84.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+kHNLDHkZBGKiZ/vQx1TetUwA6LMVmLoPyRi1Dspx1LxQvcZ84KSjndFfj1Miu1CMafhPIbZMkQvvT3Cc5HnDlQDTnxzer8wfnrG1wqKNPCTdo5I3YiXUigmtvPHEbxMkNFdhqfutahphAkbub6sqhk+aXKZOCDENxQkarWfU0aQx5pzReiWw+H362T2ISiyck9BMaxErxDnGGkXH7vqIuqevjLyS+aMOwBJBNNn9WVdB+CZvNG0E6pscqANOX5W/vbPGMWjFyIWqFxRsDr5ceR5nM1bmbw6IuBMiDvLht5vrqJIAYYc9bMl5riwGxue3c+/31sSRIv35jvAwrvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td9y/sD8PNqMPEXvT4ITf8PyLyo19+hvJLIriAAz14A=;
 b=cWldgdkBvnV7KFf4kwaSLjUgZGok+TlEYHpNC8fr7198nHNnUVrOZVphx13T+2kxEAiywbYcfY3Dj1CApftcuZX0+zizwpjWTCHmEVVgbRT4Ap6ZFny32xMTGT5icuBAiPVAokgRb4ABb8tJG3LD0n80lePSFE/IfZuSSdt4DGrTAFKEKkrI6SEdUuM1TMdtMQ8SoC+LGxXxAW+jGvWX7THFX9QwSS56IwSscAQ3+a/DdQ+k18MgapYecP5M2HXpc3ZDLN8QuQ3DI+ZmIU0yfecudFyaM3f3HdFU19s9W3DfTd8vfdAQNjDW/o35/HQVd/hUCU5GA3jvZ/FCl0VfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td9y/sD8PNqMPEXvT4ITf8PyLyo19+hvJLIriAAz14A=;
 b=bPZPckyrrhxepjS2HAn/OC+DWeMfz+aJxQ+Odl7l5kGJxLuLcAfIaeejP3Cwh+yrg1SsGIdv4y06Yjcstxe8TgubbcFRSKCaqlntoiT9/5N5pMPQHiP9qk43Qt/AhsrYaNzpTYfAd/gvmtDFMGRhXaQBDxluLGI+mveYAp/+8Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by MI3PR10MB9872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 20:04:16 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 20:04:16 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Stanimir Varbanov
 <svarbanov@suse.de>, Florian Fainelli <florian.fainelli@broadcom.com>
Subject: bcm2712/raspberry pi 5 watchdog node for 6.18.y
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 26 May 2026 22:04:15 +0200
Message-ID: <87o6i2ey4g.fsf@prevas.dk>
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::10)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|MI3PR10MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa90b36-2a43-4a94-165b-08debb61f70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|11063799006|18002099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info:
	G6k4cUaRRlLjNsUGKOwYYC4M4bGALMAvP+qgcFtNe+kPJWT/S712KKJaQ9cE29XcF7PP36T82CdnsLyjQGaDDoGbiv+Y8oHqfaMfTC+/AQl5rmFq8VxGgkvMC0629CCvPCm+nTxtY+PIUOKe/hgkQwqxgdX1dGHo08EN10R8g+vNc1XkVz6La5aGA70ec9+S0cyfZWCcj4sFmCFE+PyuJHONjBJe2/7kBGI/JXI+UBA7Hq5WgUa6TjYoFx/9zf/eC8q05NfJOpNL5zG10x1NuPSLrTZkBl9xgpIIQtjdRhAd8JSGVvLw8CGIf0IinOv8aMplopHAxalAy+pVu+nxV0c+Tg6fe7FZMfXcHh7Pc9ApAq4+n4/P5DNDOfCyoOJnvwEZRoi2ulLG2uQpWW+unzLFwAjxB7/5DONFSCkn1ui0nMOIarr+8X1tuNhKr9ycUnIkUIldlYm96mwMztU2PmpaMHvAcSsZVqiM6UcawQyy44VUJ7MptRJLtxnbIbIkPjY76RYKBb2BeNBx4bamklKg/FydzIcUN39LULzXMKTNXylQxQCU3klX7F69BVzSLjSWk8kLdWCYVY9J98G3IkfdMDSOW1b2vl8t9ckFClmFJYtMGKnznG00PfGX8yTmj0Mf1A9h+sCV6p8siy94hilfxXl6U+xC4DahCe0abNSqk4cEoLP/pc7uTiAY5x5eW5pIgaGIBsJ2z3aX7CUt6K+FehaDIrdj337RGk1PT8cpLZHLSC7Hok3/VpYhvcv7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(11063799006)(18002099003)(38350700014)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bn0Tmv88q2jw5prHQEUwpaoDnJZo51wvz8BY18yhYC+jPJWouwABnvlenjhl?=
 =?us-ascii?Q?G1H5mat8mh2nHWPHpZkdxM1zGLRkm85ZX98H75UoNceHH2blwjZ5xH+89ils?=
 =?us-ascii?Q?eulnQAk52SvnX2GTGMwVTyaPHWgWwTeHC9UeIDaCY61pyl82+knadxBCQ1W/?=
 =?us-ascii?Q?iCbl7RhE+50JXdYK5CRtsCG4j1NUNtIBm4xVsDNbGifPggwJR91DvaUCRTfS?=
 =?us-ascii?Q?MHVXbVpNpG2FaqBU6H4ZRrIstj0bpz8BtXmow95DbiwlgK15cXG1git4CS/G?=
 =?us-ascii?Q?2cn4nHTi4Z+axXTtDAlzEmFLmVfG38tHP7vu6qEk/0QQQatjhKyjMcKVZNEW?=
 =?us-ascii?Q?v6RbvKVOhs07gPxpyGyLmaXu3tDqAfh7xVGVUd2IAQDO/1a+ecKEFyMt+c8I?=
 =?us-ascii?Q?Js4JNZi1WniHUin+RQ3F542BRHXUGmbyHBL0rMn+qr0Zsf/4Mpv2512tCbbN?=
 =?us-ascii?Q?NltRXOz4CDmBbyNAbOgKuulLZQmby8Vll2H+F2abgEjCeGCcvOPCEN1PEskR?=
 =?us-ascii?Q?L6U/6uFnLKaX6oU76CU/M/7S/AnjtoIwY3spY1qcjxExDlDc80HQaxstxZsX?=
 =?us-ascii?Q?3auKbqVBuNhUN5mTcuGkKqiOZqY5etB/etkr1RgfLgJUroGqRsCD1P1r9OII?=
 =?us-ascii?Q?PBkODl2UneBF9RkLMKiT+o+wBm/Iq4c8vI4vqo2krhdlQ4LIgGNAiprRYxVQ?=
 =?us-ascii?Q?Qm/uCXFc9mWwdOuYyUdNSfoxNoeiIpxPk3mrh2GKPgebG/7IGtCSHgSDXAJn?=
 =?us-ascii?Q?XiIgbu1DmLhPbK2ZKH2z88eW+pxJHMy+yXrkKgN/qABKnt8A8DJ3gDtj6acn?=
 =?us-ascii?Q?Xu6F/F5GpPBqQeqVE2JyfG0E9ASvVbD8kyEpZjrjmIFYFQ/XOYkKWX6HRu3f?=
 =?us-ascii?Q?q+d0GRLDcDjCJYdWNLpOkVmJgE07v604XSmRpmoGI9EvYypvoxEFHvKm0nDh?=
 =?us-ascii?Q?oSEWkdVnhiS5kzAEppqoLoNMH4k1hTo6tsSiSFdsJ+eYKwfRFgl23/yg2e5r?=
 =?us-ascii?Q?yWe7UVX58j1Zav8upVvBN6XOWc+B9DhWxEZ6/JlaJ65hSyp3OzkDGfJUN3Nh?=
 =?us-ascii?Q?lUtUSrInzTQGjzMTV3Y5bvLDCTSfv54VadDnKdUoZjnj1ZGn4H7y3A6258y4?=
 =?us-ascii?Q?W35sQ2WWQzyti3TLN60LFBUBf7wINa5jl+kTChD/bpMAihvFsRfXmXzmeHhR?=
 =?us-ascii?Q?yjm8KVNopwUuE8LTUhoyvz7r964r02LDqePxeNG+8iMfuwFEmZKwBuWQPIGa?=
 =?us-ascii?Q?HQPdElq+tlKQZjxb1FHrIpHgU8V0yFROBUjiKhRl8Ec+ux/pE9N+QBsnSvwB?=
 =?us-ascii?Q?E2dG968TUTl6VK+MbSjEqBQvfbXbekzDQJuVuf2oW7yii5AU+kXdv/INXV3q?=
 =?us-ascii?Q?A6+qE2E0K3FnhcRnI5rcCmzVwp7foiJpUAKKtw1q4lT8f42r+/YTmgwUwSq2?=
 =?us-ascii?Q?Tc8GBG21Gukq13g9E7BjEqE59b8MAX1vXj/7M0mSxinJ4TB+p8js0MnrLSSR?=
 =?us-ascii?Q?IWSb2sXPuG6pp1simYugwIP5HPeee453p5C8ifDOI5f9L4qU0W7WM1ZJ6L+A?=
 =?us-ascii?Q?5ogWjPvKq4TgFpivgW55OL0wAdbAU1/QjaFFePy1sL8HCWUc3MJDyzXq6m56?=
 =?us-ascii?Q?82UCSTQxVIlqhMWHwJw94MCNypoLas1e5lNlsSUzQIl00KnU2pWPVWPxp0rW?=
 =?us-ascii?Q?F+Fe1vbPqytNi/YRH7qEH2CTKK7EcLDH6E0lbxIALXEqHAgUp4qf1Y4BwaAM?=
 =?us-ascii?Q?bxFdBMOIE8aAwjfGRPL9KgO1Qe5J7hA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa90b36-2a43-4a94-165b-08debb61f70e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 20:04:16.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFAh79AyIhFwDhs4RKTI6AoXEX8sgFYrEzGvO+uLmE1JATidw5r9ju8uK8hiJeQ9ONnQ/tt0Gpvbl59kbz3G7MTZGoXwZgtsQL1lz9KoIMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB9872
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[prevas.dk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[prevas.dk:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254442-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[prevas.dk:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ravi@prevas.dk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 72E0F5DC33D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

Please consider adding

34194cb38503 ("dt-bindings: soc: bcm: Add bcm2712 compatible")
37c3a91e9730 ("arm64: dts: broadcom: bcm2712: Add watchdog DT node")
30ed024fb076 ("mfd: bcm2835-pm: Add support for BCM2712")

to the 6.18.y stable tree. If the bootloader or the ROM code on the RPi5
has enabled the watchdog, the kernel must know about that device in
order that either the kernel or userspace can keep petting it.

Strictly, the middle patch is sufficient for that (as the driver matches
on the brcm,bcm2835-pm-wdt compatible), but I suppose at least the DT
binding patch should go along with it to keep the documentation in sync.

Thanks,
Rasmus


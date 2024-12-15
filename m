Return-Path: <stable+bounces-104231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5A9F2282
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 08:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DE1188545E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FE1CABF;
	Sun, 15 Dec 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VQB5fUW3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OaTFN8Dv"
X-Original-To: stable@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467B156CF;
	Sun, 15 Dec 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734249029; cv=fail; b=ssRLa4M+tgqDFdqLiXqhAcTCZ5Ov3t+B76hoSlEr9kHmFnOAtYDEfj5Bg3skl0zeyYvig0zGfEbk6pUV2/pgAoxv2JxfledvlcP8ymGRnqtYPB6refVexDDHThkCoHfgcvt+C1QVDqFXc3NIDbGAUtDMEkNHWP6OcAeD4dU4J5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734249029; c=relaxed/simple;
	bh=6iMZLFagvr+X0U7osy4uiUUhVeqWBmo1aKjWrTj6zhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pQJkytvXaX/ioYq2+1y00D+YPQmkQZBiw1FO2HM8m8oOHM+N1IK/bFYc7rUPyQ22Ya3QLyZBUJYmSvHz52ub/1VVIn26/bINctDHR/74AZchaH1lLcZF9JjikPsrTd+OQpY3DKDZK5gjDVjlKbElAZ1Tm5YYn0Kn2LkggCcDRZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VQB5fUW3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OaTFN8Dv; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734249027; x=1765785027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6iMZLFagvr+X0U7osy4uiUUhVeqWBmo1aKjWrTj6zhc=;
  b=VQB5fUW3I18JMt0KIIPrlwkXNwrw0MMtW61rOGLd161wOsv68IXeEB4v
   BtIojziEflSB35X7Wzju9RXV0tZN+JZbxSdhMz/6/Vb9FR4cAn46WuWG3
   6DikMs8k+Ax5c2OhFNTnI0OCs2cqyXJ3AYz00hqSEWRnWnE5cYryQd404
   Q7mgZ44VuYWncNNYYO/ct2oGTUjKnacrmM04g8gGAwooRk+etO/dPzZw/
   S5U7WqFGY0Q1YxIhI0myVYNJMTKS/SEdItPsrHS7LWnp32bPVrkzKHEvF
   gJKLoPhAWQVPsh6sVeoUMYWJbvvSUwYBg1GUEHiOKxCoLudDLrvaOhjwh
   g==;
X-CSE-ConnectionGUID: ZWsEVNfZSb2x4IgkujPdLg==
X-CSE-MsgGUID: h+tMyE1MQ6u8FZsekNyMQw==
X-IronPort-AV: E=Sophos;i="6.12,236,1728921600"; 
   d="scan'208";a="34378262"
Received: from mail-northcentralusazlp17010004.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.4])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2024 15:50:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mO7xKo0TtIemxve4mcdKFzQm/OVGOEYnHygG0dY3LmDK9oDFDdjSZWNp8NRKpCSOPFSnyjiNBGjPJvqjJXqcE2UyEddRYMhPoAwIcivlYdNtQav4RbY/UykwhXJtAJoBE1h4+xILfSvHpAr78AqjD6lPgzwtC25iZk1CV/OAgltUqrJtA63ZrrQlJ1Fq2+cuHW1OdPs4Oa52UVUOxmZencpOS0AwPX61beWpu9yMzx0pdGPkdjXWb0XOV+no4P4mp7KNolrqbnmpY27PV13XiBG94BpT5DBgx6AGNFnGATpr2lHLrNA4fPUBIghuK4ro0bqtmIlUnmK45xFomFKMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx5Z7AQMql90JqZdcHpbSJeLYskLVCqRGCGt2kc07hc=;
 b=QCWxm+nJtvVxb385f5NV5dZPTnfcJSzpO6bnfjS9S7IN23mBlRwOiTlKweoGI/D9B+vU/UgRNplUR2D4UjSVEF0EaB9dNeLMwRdGlypCY8HWUPMR+ywla2DWZccaF42NkysvjeR1NkkOW4QnkWIKPRv511eJqpgeKjntIx5XtHS92yS2m1AJnetMq50TDIJcfzM/9AsOAMGJSc3dvjA+rCUkfqFh9BimT6i0paLH/jPzPr/w4rlvhSQd9oHG0Np8zUEUd3HDVjJfK1OV1emVMReg1EwVoZanQqS3zVL1UcKY51JVrJeRZy/z5iSzLqorE2mahEIcxzXZ3SerqOoITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx5Z7AQMql90JqZdcHpbSJeLYskLVCqRGCGt2kc07hc=;
 b=OaTFN8DvM05+h06CgRJuiSbIjW+Hy4w9py+ett3wgA+Rp+k/u6TR5VfgbUnWRSBfdSXjZN8kcn38cspZDjZ8WpHYq+Hg+FSBLdI3k0iYLQbQdbbpATgb0f3bZspidaZMmaSxzgvipKFhRwmwlbk0hTo5ysUAkuIkyb4nd8ylP4s=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7522.namprd04.prod.outlook.com (2603:10b6:303:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Sun, 15 Dec 2024 07:50:17 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%4]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 07:50:16 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: Patch "mmc: sd: SDUC Support Recognition" has been added to the
 6.12-stable tree
Thread-Topic: Patch "mmc: sd: SDUC Support Recognition" has been added to the
 6.12-stable tree
Thread-Index: AQHbSiyekHK8CM2S10Gq51lP9at/ZbLm9pog
Date: Sun, 15 Dec 2024 07:50:16 +0000
Message-ID:
 <DM6PR04MB657568977B5831FAFEE0F0BEFC3A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241209112214.3159219-1-sashal@kernel.org>
In-Reply-To: <20241209112214.3159219-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7522:EE_
x-ms-office365-filtering-correlation-id: d201c492-2e61-4bd2-d714-08dd1cdd1d94
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eevkjhKmSm62qJYxg4ARNrOciSoGdJqyZiP/gRyZJUNCRuxf1/Aep/XaaYpo?=
 =?us-ascii?Q?WnRPGyPrgIAjr8Aew+p0sVXgcEF2LAWNyS/msvTXCCbh9CRWaSQnZB8pQXLY?=
 =?us-ascii?Q?8B3Jquy/xwC1SgKlViE7czr27xfAEZHaHE/SnpThOpYnLpLbFzEIRVm4pOHD?=
 =?us-ascii?Q?If6EFEOIBzYVvV7w5myLxhyBeKvsC5YRsWmgWGUPDtQK7WOYznmJiwmVkK1W?=
 =?us-ascii?Q?NZx55cz8dGP8/ne9N8NzQKJ4PC7lriVIxI1XSN+jQN+OInnAWGdf1/M6B16P?=
 =?us-ascii?Q?beKArKp+uNLgzff9OsStuS0Y5T4iaZBcLCkBK0JOBrouVY8k7khqsXXSsQN0?=
 =?us-ascii?Q?0hwnK3fFnajgWqH0/tq9v4jloSPapRoV18rXL+6wjPK24r5E5lNXby848MWI?=
 =?us-ascii?Q?cho2tLf9EkSm6JzcwdJXsnNNW2mR/udAo9IM6c0vxRwbNaCKQLdW/GwelNhH?=
 =?us-ascii?Q?Fb+9r18uIPXgi8z/hMMXSpSqCpOOQQoXWY5djjZMv/Vlsa7wumHeINP4ShH3?=
 =?us-ascii?Q?zKwO85RKibQ5Ix4GanDvBx40uOjjBT5bvP1pIV128rxuGzXz3hu5Vhr9iflO?=
 =?us-ascii?Q?y3DVECSwHY7ZpCBIbVskfpwLFKmNKKg8jbPCg/dHElydVJWW1hfiFcM6A5Fu?=
 =?us-ascii?Q?9gP/gmpz4A/VLvxa54TusRA6o1ZKxk/i9JmyIpOdvn0TodFmD28mACr++ead?=
 =?us-ascii?Q?W7nANT9I+6ChNVCfPslNEqTxWPSARzBlyAjV2sSHG6TKqeneknUjdRf1YrRp?=
 =?us-ascii?Q?HacSVMsgIotjBQrCVl45rhe/DHbOg/byIj4jLIka6XgvYxSYErQ+01DGtq2s?=
 =?us-ascii?Q?7EYLTzsUiXVs3MCSHu0+KzIY/lW0u1PLyyWXgudVxfCkzun6KY9iAopB6t8X?=
 =?us-ascii?Q?50M4+8LoacBovMAJK/mHYvlYfU9m6y+U+Nuh1zBgKiCPy6HyIEuSAYVKo38w?=
 =?us-ascii?Q?i5MPpjIt8Or4gTLiXnyt4IlZJ2pbTFmYuL5w+TuljjhrzxTiyCigp8e6jf1a?=
 =?us-ascii?Q?eXncUia+tQEmSmOpVJ1S19s7sq3+k08xNoGuGgRDlUHFJZo28WJrMQrlVuxL?=
 =?us-ascii?Q?B/2gSlPtXV6AX+yxcomPq4mL6dxze2igrpcaJZ4XKrvFY7V8i5OHSggVjdLm?=
 =?us-ascii?Q?puDaAJT9+BMgYBY1YpjeaI7R273xVYpSigF+uy1xBbplxQePCJX7tmiM/QZR?=
 =?us-ascii?Q?PHIstQpev09T5KFS3WFBIiQyf7qvItAQIX/j1p/oxI8P/QMslQjU2rUN1qiT?=
 =?us-ascii?Q?ou9XfG6HylB3kyNE/4go/InZ2/CngC4DCYL2waWXimlm8OqjkxuWhnpeYWWB?=
 =?us-ascii?Q?tzUCasBaq16j5vlqO3v3wt8FtAiG3Ewkl2EtRmFBL8tP3iuVtZkItzs0XvtX?=
 =?us-ascii?Q?iVHcP2x4V6mMjKulC8dZwqS3CVRU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tRP/fU9KHusAJOL14UD/oUmLWXmtTQWUv/6sV+eN04/xBmdSHe4xCrxgejtt?=
 =?us-ascii?Q?I4OiplFWZDCfK5YP3IMQeOcURv4iJbm3SabBUMuQXUWUjxjBdCIz0xRmqbDR?=
 =?us-ascii?Q?RekctHnj7d9hOXcem5S0oJaniGqZEs8N+JZL454VlfpYCwi7yLYRCke07aR8?=
 =?us-ascii?Q?crgb03B+rpe35YstkpfS1UNlyxre6WdDAraRB4pkhAO865uLz1+SDpiL2QPu?=
 =?us-ascii?Q?fr4fejfBIEX/eOuzfhN7lv8zfNqGZGxEv4Jcl8D4uILD2aqA18RVBAzPXgpE?=
 =?us-ascii?Q?2P3I6ccEcykWFwV07xVjpmKBG6F8waKIQe/vbGIBYRnK43DPfdtol6P4NNKF?=
 =?us-ascii?Q?cUAM1eQKLhlE/ljCgpHlWVYjGkD0B4pGhi9UCBp+CDVzI1mejpS4e1sQVeD/?=
 =?us-ascii?Q?OqZRwJT8siN3fzYGn8/Lg9oUOECBmoCp72kH7+Ys4AEVDq8NK7yaEa0ihhwU?=
 =?us-ascii?Q?D4lnOSDohpSRsL1kQR3heU8pzMpSiYKr0hR6v7NrOiFXw8K5nukOv/+OTrKz?=
 =?us-ascii?Q?Z2c0REm89UzxX4KF8DyLpdXw3+Kv2Q3C+4ZndtpZ0N6Yoy7bXu/0g/Ey/rIA?=
 =?us-ascii?Q?0hj7EzfPHwppfsaFuwdvUImqhP0T4L2qrNuw/I2EtWIj4kyedhF2v7nGsWFU?=
 =?us-ascii?Q?nxWSoUw1gM/+720AhNtil0/PWmF3uZX0TYDnnwZ7aW6hzSpeHeaFW2GGKUe+?=
 =?us-ascii?Q?5zyHt3jiDcQyuPnERYV1Mfwd6fi7eY1LB+emqOFbcC++8KmXqV+6iDt0pFlp?=
 =?us-ascii?Q?GujTFQ3FzGSM85TJy5Drns5/fRnn4Q/OCbU4vVnvd3E8f2nKOaXas4XCUZZd?=
 =?us-ascii?Q?oZ/uH9fZtfekzT87MJmMJaf4qM8ydrzRO9eNwdJ1MulRflNRObexjxLDC3cz?=
 =?us-ascii?Q?pVb/8QvnulLYdp+ZAEJUw2oliwVbiP8dewm0Gk+M7B/2JGfq+wPQduArvs2w?=
 =?us-ascii?Q?xSBYQwgpSTQ1JmSOBIKnPamaxcnI8jpW/e1mQINxVN/0hnhVwmb0XPI8gFXM?=
 =?us-ascii?Q?TWhVALyEd5KUAmThLq/6vPosgBMh86v9ugFFHusjG6TCgkMDxkjS73jbpxwc?=
 =?us-ascii?Q?8CSd1sj3h1uN5TfGTrOwO7bS5DpRN3jAvx8Q3Di0ZCv0YSlFVn0i7TNjbjRg?=
 =?us-ascii?Q?aI8gb1XhEAVFDwdZA45eZlIIkiOwG2l6FkNRcsrEBL5fIyWfhoeVRtIQhIXv?=
 =?us-ascii?Q?dADHNTxU81/AxAKCttUj7CZOiLN4tY+k/VU7MWxH5wZvMvVPSuD7FZM9kIpn?=
 =?us-ascii?Q?cxUwzOvOcHHpVKXxoiVuHIn4mfBwFp6td9c76XOl+zJx/xY7wPp4SqaHZqxW?=
 =?us-ascii?Q?pFMwsOSWOvuqBSOsGJoQjRw9RCzUGTAX3lnQAYO/zK1sjNdwnqVP+BcXICn+?=
 =?us-ascii?Q?c5WUqa8dsqX0Lv0IOH6p42xYI+rdRau6XYgwvFYSpPsL569KG+DWNvAJ91ut?=
 =?us-ascii?Q?3JhqREjy+MDViG6t8jOq1mCMNv2iO8QGfDUpuVN5v3gt1zyTIEgli+RnjuRb?=
 =?us-ascii?Q?J4sy47x3XJCRnF0PyPFEiH+vrQyGmigyYsSC/NeLnMvHl+59pkSzRcBydg4x?=
 =?us-ascii?Q?DzT1+QHWIrw3MTfr/JYK3/2W9OkEfx2T2lhFhlEU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5NMic/DZUfX6Zfuxzzh7CHxEQDGJzKAlHgGdCvWX6uA0DAHHe69fm/1eLNXHDtXps4oYbkhNqmnGCIaY16YvCIc3T1AodrXrQQ8Q1t1oSLLCkuX7mPmW6h4eq6CALR1JdwX6IqnDaXDH27UZO2cpWmi/UlNuD3sHNowS16GEv7WPr2VbKjGKzxSdjuhMPqkFlKAie2iH+3ZLcX6L6+kUrAqBE8ztmwCJMMVgCJFUE4wJWIAjui+vApYjeNfDJaWLkKL6KgDLDsEZ32b2LVTQTJV5xs5WqIO7e/gJod4DKHsnD18M8GKshgVwYDBH0XdhvZAnODdg5Y0kvdhp4PEFPX7LhKye9B5GwN7rtia16MpWScxt9PVFK/6B2tXt3vf/AJb0NO7FBH3L5CPzl/aSq2Sksin4lWlQcQXO/vPp4L9koq+mrud3GsGHP4W4MT/TbzOUlKrkZMznvntREKF4QyZ4EC75iZRXdAKbhFrUGzDjefEtW64pIZiHnQQjAM2UhMUokK+++FV5aorfeCF7gaLlcXLa4iJT5OBGUSabcxeUr35mQEAVKdF6HK4tDva9htMy+qMq1uKJazi6FSYGpM8moL8pf9mI009wfd3BQWwYyMtqmCHNsqJbW/GdcJbY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d201c492-2e61-4bd2-d714-08dd1cdd1d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2024 07:50:16.6045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+sIfTvPs5pJZ4g/+fy1w0YfW6LYGb7Z6u3uO2vs+68SWtcusKeJzkMESZ1BtMACCTLJNOQhRsa4ld+eADOG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7522

This patch is part of the series - https://patchwork.kernel.org/project/lin=
ux-mmc/list/?series=3D895924
This is patch 1/10, looks like the other 9 patches are missing.

Thanks,
Avri

> This is a note to let you know that I've just added the patch titled
>=20
>     mmc: sd: SDUC Support Recognition
>=20
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>=20
> The filename of the patch is:
>      mmc-sd-sduc-support-recognition.patch
> and it can be found in the queue-6.12 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree, =
please
> let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit 67bc965d660760bd68981c067932c4bd807ebf95
> Author: Avri Altman <avri.altman@wdc.com>
> Date:   Sun Oct 6 08:11:39 2024 +0300
>=20
>     mmc: sd: SDUC Support Recognition
>=20
>     [ Upstream commit fce2ce78af1e14dc1316aaddb5b3308be05cf452 ]
>=20
>     Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Thos=
e
>     cards support capacity larger than 2TB and up to including 128TB.
>=20
>     ACMD41 was extended to support the host-card handshake during
>     initialization.  The card expects that the HCS & HO2T bits to be set =
in
>     the command argument, and sets the applicable bits in the R3 returned
>     response.  On the contrary, if a SDUC card is inserted to a
>     non-supporting host, it will never respond to this ACMD41 until
>     eventually, the host will timed out and give up.
>=20
>     Also, add SD CSD version 3.0 - designated for SDUC, and properly pars=
e
>     the csd register as the c_size field got expanded to 28 bits.
>=20
>     Do not enable SDUC for now - leave it to the last patch in the series=
.
>=20
>     Tested-by: Ricky WU <ricky_wu@realtek.com>
>     Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>     Signed-off-by: Avri Altman <avri.altman@wdc.com>
>     Link: https://lore.kernel.org/r/20241006051148.160278-2-
> avri.altman@wdc.com
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Stable-dep-of: 869d37475788 ("mmc: core: Use GFP_NOIO in ACMD22")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> 0ddaee0eae54f..30763b342bd36 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -321,7 +321,9 @@ int mmc_add_card(struct mmc_card *card)
>         case MMC_TYPE_SD:
>                 type =3D "SD";
>                 if (mmc_card_blockaddr(card)) {
> -                       if (mmc_card_ext_capacity(card))
> +                       if (mmc_card_ult_capacity(card))
> +                               type =3D "SDUC";
> +                       else if (mmc_card_ext_capacity(card))
>                                 type =3D "SDXC";
>                         else
>                                 type =3D "SDHC"; diff --git a/drivers/mmc=
/core/card.h
> b/drivers/mmc/core/card.h index b7754a1b8d978..64dcb463a4f49 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -23,6 +23,7 @@
>  #define MMC_CARD_SDXC          (1<<3)          /* card is SDXC */
>  #define MMC_CARD_REMOVED       (1<<4)          /* card has been removed =
*/
>  #define MMC_STATE_SUSPENDED    (1<<5)          /* card is suspended */
> +#define MMC_CARD_SDUC          (1<<6)          /* card is SDUC */
>=20
>  #define mmc_card_present(c)    ((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)   ((c)->state & MMC_STATE_READONLY)
> @@ -30,11 +31,13 @@
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  #define mmc_card_removed(c)    ((c) && ((c)->state &
> MMC_CARD_REMOVED))
>  #define mmc_card_suspended(c)  ((c)->state & MMC_STATE_SUSPENDED)
> +#define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
>=20
>  #define mmc_card_set_present(c)        ((c)->state |=3D MMC_STATE_PRESEN=
T)
>  #define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READONLY)
> #define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOCKADDR)
> #define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDXC)
> +#define mmc_card_set_ult_capacity(c) ((c)->state |=3D MMC_CARD_SDUC)
>  #define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_REMOVED)
> #define mmc_card_set_suspended(c) ((c)->state |=3D MMC_STATE_SUSPENDED)
> #define mmc_card_clr_suspended(c) ((c)->state &=3D
> ~MMC_STATE_SUSPENDED) diff --git a/drivers/mmc/core/sd.c
> b/drivers/mmc/core/sd.c index 12fe282bea77e..1d09f0f2e7697 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -100,7 +100,7 @@ void mmc_decode_cid(struct mmc_card *card)
>  /*
>   * Given a 128-bit response, decode to our card CSD structure.
>   */
> -static int mmc_decode_csd(struct mmc_card *card)
> +static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
>  {
>         struct mmc_csd *csd =3D &card->csd;
>         unsigned int e, m, csd_struct;
> @@ -144,9 +144,10 @@ static int mmc_decode_csd(struct mmc_card *card)
>                         mmc_card_set_readonly(card);
>                 break;
>         case 1:
> +       case 2:
>                 /*
> -                * This is a block-addressed SDHC or SDXC card. Most
> -                * interesting fields are unused and have fixed
> +                * This is a block-addressed SDHC, SDXC or SDUC card.
> +                * Most interesting fields are unused and have fixed
>                  * values. To avoid getting tripped by buggy cards,
>                  * we assume those fixed values ourselves.
>                  */
> @@ -159,14 +160,19 @@ static int mmc_decode_csd(struct mmc_card *card)
>                 e =3D unstuff_bits(resp, 96, 3);
>                 csd->max_dtr      =3D tran_exp[e] * tran_mant[m];
>                 csd->cmdclass     =3D unstuff_bits(resp, 84, 12);
> -               csd->c_size       =3D unstuff_bits(resp, 48, 22);
>=20
> -               /* SDXC cards have a minimum C_SIZE of 0x00FFFF */
> -               if (csd->c_size >=3D 0xFFFF)
> +               if (csd_struct =3D=3D 1)
> +                       m =3D unstuff_bits(resp, 48, 22);
> +               else
> +                       m =3D unstuff_bits(resp, 48, 28);
> +               csd->c_size =3D m;
> +
> +               if (csd->c_size >=3D 0x400000 && is_sduc)
> +                       mmc_card_set_ult_capacity(card);
> +               else if (csd->c_size >=3D 0xFFFF)
>                         mmc_card_set_ext_capacity(card);
>=20
> -               m =3D unstuff_bits(resp, 48, 22);
> -               csd->capacity     =3D (1 + m) << 10;
> +               csd->capacity     =3D (1 + (typeof(sector_t))m) << 10;
>=20
>                 csd->read_blkbits =3D 9;
>                 csd->read_partial =3D 0;
> @@ -876,7 +882,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr,
> u32 *cid, u32 *rocr)
>         return err;
>  }
>=20
> -int mmc_sd_get_csd(struct mmc_card *card)
> +int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc)
>  {
>         int err;
>=20
> @@ -887,7 +893,7 @@ int mmc_sd_get_csd(struct mmc_card *card)
>         if (err)
>                 return err;
>=20
> -       err =3D mmc_decode_csd(card);
> +       err =3D mmc_decode_csd(card, is_sduc);
>         if (err)
>                 return err;
>=20
> @@ -1442,7 +1448,7 @@ static int mmc_sd_init_card(struct mmc_host
> *host, u32 ocr,
>         }
>=20
>         if (!oldcard) {
> -               err =3D mmc_sd_get_csd(card);
> +               err =3D mmc_sd_get_csd(card, false);
>                 if (err)
>                         goto free_card;
>=20
> diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h index
> fe6dd46927a42..7e8beface2ca6 100644
> --- a/drivers/mmc/core/sd.h
> +++ b/drivers/mmc/core/sd.h
> @@ -10,7 +10,7 @@ struct mmc_host;
>  struct mmc_card;
>=20
>  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);=
 -
> int mmc_sd_get_csd(struct mmc_card *card);
> +int mmc_sd_get_csd(struct mmc_card *card, bool is_sduc);
>  void mmc_decode_cid(struct mmc_card *card);  int
> mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index
> 4fb247fde5c08..9566837c9848e 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -769,7 +769,7 @@ static int mmc_sdio_init_card(struct mmc_host *host,
> u32 ocr,
>          * Read CSD, before selecting the card
>          */
>         if (!oldcard && mmc_card_sd_combo(card)) {
> -               err =3D mmc_sd_get_csd(card);
> +               err =3D mmc_sd_get_csd(card, false);
>                 if (err)
>                         goto remove;
>=20
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> f34407cc27888..f39bce3223654 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -35,7 +35,7 @@ struct mmc_csd {
>         unsigned int            wp_grp_size;
>         unsigned int            read_blkbits;
>         unsigned int            write_blkbits;
> -       unsigned int            capacity;
> +       sector_t                capacity;
>         unsigned int            read_partial:1,
>                                 read_misalign:1,
>                                 write_partial:1, diff --git a/include/lin=
ux/mmc/sd.h
> b/include/linux/mmc/sd.h index 6727576a87555..865cc0ca8543d 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -36,6 +36,7 @@
>  /* OCR bit definitions */
>  #define SD_OCR_S18R            (1 << 24)    /* 1.8V switching request */
>  #define SD_ROCR_S18A           SD_OCR_S18R  /* 1.8V switching accepted b=
y
> card */
> +#define SD_OCR_2T              (1 << 27)    /* HO2T/CO2T - SDUC support =
*/
>  #define SD_OCR_XPC             (1 << 28)    /* SDXC power control */
>  #define SD_OCR_CCS             (1 << 30)    /* Card Capacity Status */



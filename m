Return-Path: <stable+bounces-223856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COm4LRXyr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D482495C8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11B8306D8A0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D7423A85;
	Tue, 10 Mar 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="curTfLvu"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966B36EA8D;
	Tue, 10 Mar 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138347; cv=fail; b=KJ/VwADjplu4Kk471ZNv3gVZ2eVc/JNT9KsLieuhckhfFtLhlal0DZ7A4fZi6MSq99kZA4PldZfiQ10FEEc8J3DQRgfiOh+NoewByp3sfVRKbYjeSbuTr0Vl8uF4UERnkw9SLA5Ljdkt9mA/36VYpYBdSLAMkmyvOcIv8YS/VXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138347; c=relaxed/simple;
	bh=jS9TA4il7Uo7c2NkjYoHKKOBRU2bwfaI/e7LkPrR4go=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DUyP1QrOca1mJPljczLDlXpIGFBYniCxkcvZBaZfYc67P6tqmnEyyB0BUGlcc+XZqBawDM5jDyQ8CgLvQp6ATgqbdJhIGaoInpCDtkidvigIfiiGbpeSTzdFkG4WD8yRTPRL7AvxSsZDtMt6don29s6qTKMAldvZ2pF5pXz9pJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=curTfLvu; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7ldkBKWb1kHImQ+Kc3RCc1Kt/p6Xq+2zC6JsRRmxeac4Q22GBuRkGmmtYen1zOjCzdiPn6kDDmCRlpaFpAIs/Nbe5x6hurKdXIQrEn3naxc2/Md473jZtJEOSmhjwIdALjpSVaPOhhIRzY9O3tUtbmWQQHtYYKci5oMPOxHprG0AlGHO6ON9+BHa3yme/0YxRcZqRT2QUHi52HDPj7SFEH3xL13ixDm65TAO3JhwtsIuJxne+gbHx1MtkLvsg0V+K5PDC/ymKnDLJ+Ca8+GB9q6pyM/YxqjOI3PWhcPgeFGvaBK+3NKTmCBE/dkG3GA2mu23BRQIBpA00sgWfPT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ezt7r5MPZcpZqnlMod22aGxAG5DNKkRttNoQ3zj5LA=;
 b=j8cSu9H0nNOUKpfTbNqFCclEiiiOfqMmmkzAwDiuYUgVNAIOVWE8reGBTmmgw/Q7kVUz6Z3sQ88rzYoNh0XZIwVH07u9z7jZfY0WkmYZD2PA9mMAXv8jFAqzKbd6XlImGkOtN798oxgrKT61gyLSL7A8FWUmAup4QY8QAW3becmBZUbOMIxVNJ2/6YF3O5BIqcfCc+jbvRrKwovoB/pDQUKTcEjT6fVKNR1UYX5hpIvIlyNEOmDVjot2LNsolHMW4i0cWhUljDLrUhvOq7rXpYTfJZEs3y2KJIj2Rgmnt7Y9+JWnD2ebBHhP1t/5qmCag/CA1mkSqGXUQNdRX9S8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ezt7r5MPZcpZqnlMod22aGxAG5DNKkRttNoQ3zj5LA=;
 b=curTfLvuH6/12XZP5MKV/JxCV2X6Fvdn8pu7AlMwnPr5riTwdLMYr4xNtRhhEjz+FHE7IUwBdZmoq2IABpVFP8bpGFtBAwlxS7eETB/L9l1f6SCZX6C3hg6X+t4m7i+l2DJyXPCxvjWywBaqK7S77zwU6oeDLXgqLyOMFw/NMtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11802.eurprd04.prod.outlook.com (2603:10a6:102:521::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:25:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 10:25:41 +0000
Message-ID: <df1cf96c-cbd9-4ea7-a5da-9e69b91db2c1@cherry.de>
Date: Tue, 10 Mar 2026 11:25:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: rockchip: rk3588: Don't change PLL rates when
 setting dclk_vop2_src
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, zhangqing@rock-chips.com,
 sebastian.reichel@collabora.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andyshrk@163.com, macromorgan@hotmail.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>, stable@vger.kernel.org
References: <20260304121426.1184680-1-heiko@sntech.de>
 <20260304121426.1184680-2-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260304121426.1184680-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11802:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e44a52-8704-4744-c431-08de7e8f6186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	XxQOqre+9J63qcpbv29APpRLK3I00zSdcMyZPX4uKteQasHyEiBVRla5hFDm3DGLAOM6DpnzrMmjMBoyZVfNFSrUdNNbr4fsl68QdsGrfjF2KAz6El2VdsDbD3sqAqbc0CAAP1DosybtiDoRTsaaUwBi3WuIJZPGTczoyZP0WOwaxYeyj+2Y8HSjOJr3DwDABq0Tw/R6ztBwxe6dGeKOQBMjMTgYYkj5y4WTbIqtEFCItc370+8J1p8GcDhoQpR/GXHdnxjs0ASlDK101a4ZKVXdublFEhofRxRo8zKGnInM0NOtlR80qEMtvLUJbBclc1T7FdICVOwPDmQoYCjjeYItbM4tPDmzaQKUddqKMphws0YU0TWP3GB8TZmM5P6J5wzQGa1yJWFd6CkAGP6q78DVVzSofgJcRFbTwqSwla942IUdZkVyvG7CVQHOjw0hZrSOW1tOuk4KzxTe2h0bDKPrV++5R3KiAKWWxs/WtYmawVzYHinPyTtZBC1bhMuTkpcasYyU14/EM1wdpG1VCWXnjwLCF637fDnk31L/OJIlkuGXl+F39hZ7lePmQThxo+8TmocLFu9ylPTWZiDqOlMYRmXqxr2cXixaTBdmn03f3Lt58RUfmbzyRghsCmUErDRvEWibDd19uXw1/HL7PFstgeMx5P2p/N7I99ZWG3+7cMUCWwm8za5tehTXe8G2WfvBB0yc25l+M0Awh22WL95AKu2i/yi0/AnIHjjvGs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDh6eERpdzFXcmpvQWEwVGtxdTVRY0o0T2M1MjI3SGs1eVVxSlM3amRMR3R1?=
 =?utf-8?B?QVdDOFFucW1JUmlramw0UmJzbi9NNFlBVnhyUFgvZjA3MXlBR2lWSTBzOFRT?=
 =?utf-8?B?WWc0SU1yNmo4VHB3OFV3RG5Wci9uOEFYbks5ZHdxZGdsc0dSaUFTZGFtNHhs?=
 =?utf-8?B?dlpCbjlsMlBpQ01ZMHhhTVVRaWs2MDJJcUUveGN3S2RiQ3MwYUNzTllWWlh2?=
 =?utf-8?B?SnpocjNpY3kyQzVKaGJ1bnN0bjFGVTdTTnlsQnZCbzFjd3g2WWlkV1kxck5o?=
 =?utf-8?B?TUg0OUxBOEJvalJ3UWtDbjhrdkR5T3MzTExIVHpXK3kxeW9tNUU4TExNS2dD?=
 =?utf-8?B?VStUaTNQTmgwYkYvVEZublBVcjJTS0RwaFliTVJmS0VTcFZkYmFXcTlybXpC?=
 =?utf-8?B?T1ZPdU5EVU9YaXlmYWZrUkRDN2tKMVBSUGZSRmNrRi9rcXV1OEI4QXlSUmpl?=
 =?utf-8?B?ZVRoTS9VamJPUmxKTnF3eGZBMk5XSDBXaURLblBvencyMUxmNWZudVhyWEd3?=
 =?utf-8?B?SHRBdXE1THVHMENMcEY4MUVMRkdmNHNBQngxeUdpNEFObU5NRHBoZUdJRnI3?=
 =?utf-8?B?Z1Bic1Z0SzREV29IbE01SGwrOEZjaldObTZMSEd1R0g3NFc5bW1TZkFzZHA4?=
 =?utf-8?B?V3g3dTc1ZlpzRERZTmwxSGxJWHpUSHlZTlNJa2lDdURzbDBRcTlkdFZGdzNG?=
 =?utf-8?B?UTI2NXNpWk5oczIzdksrSXpxMW1OQ3JPZnFPbXVobG95eXNoY3VZQXhUU1RY?=
 =?utf-8?B?bStZZzcyTmtiMHY1RTJ5TldoS1VpVm53U3gxWUdpREoyQkxRNjRPK2V0aGVv?=
 =?utf-8?B?RlZ4dGVleGJxOFZuZXRlVks0NXRaNjZ3QnBQK0JaeC9aYVZGV0xZVnQ2U0Vt?=
 =?utf-8?B?SktJdndvKysxcjU1eVJoU1l2VlpyUFVkME5VUDhvemlTSEowL3ZtZDA1QU9z?=
 =?utf-8?B?eU5Eb3dpckxaUEpDcjdyd3NUWnFvQUhRMHkwMFVEdlJlK2NwOXRsbURrdHVm?=
 =?utf-8?B?aVJJcUdveXF3UGMwZFpUNmcrd2ZSWlRIMTlpUFkyTUNKS3NubndIRU4rbU1M?=
 =?utf-8?B?eU56a0lVRkQ3ODhYa3V2dGZ0cS9rdEh0eVhMcUFpbUJVbU1SOTBsVm95UzVL?=
 =?utf-8?B?VG5HS3p5MFVST3hZNjNpODRSVGVvam80UVBveDNLUElJbzRFck9PQ3pMaTlk?=
 =?utf-8?B?UlJBUnpKZHF4d1ltRUNIUVp2RmdVZjVIS3RlWHdhYm1WYjA5anJHQVNUbWlF?=
 =?utf-8?B?S0tGUzBKS0FKU2F2MFJrUHdlVHlOR3ZLVGpMemVxcnk4VTN6Z05wMzJzaVYz?=
 =?utf-8?B?NXo3akhaRVYrNk9ib2ZiOTFKUW9sZ2JkaDZqcDhJSEN0b3Z6V1EwUHZNRXlJ?=
 =?utf-8?B?WnNJcXhZQ1ZnbXZ2dHQ3OFlKMURpc3A1OUg2K3hobVFCKzRCN1NjWkF6N2t6?=
 =?utf-8?B?YUJpZGtEb0NFTFVTaVlyTXcyRnlzc2FIMzh1N3ZhbnErdVBsZTk3d3FiMHJo?=
 =?utf-8?B?TS9sZmZJTmRtNnBGQzRRUUN4c1BkY1JqYUhCd3hpTm9uNUc1TnlXc1N2Tity?=
 =?utf-8?B?UHE3UnpyMTVFUW4vMnhIVTJJY0dmSG5tSElsMkZPbnc3dG00Ui82S0phVjQx?=
 =?utf-8?B?MVRqa2RnRlpIbFc4WGFDNDdETUlEbExiUUZjcmo0QjF1d0VSYnN4N2tSY1pG?=
 =?utf-8?B?NUhCVFJKTlQxN0FyOU5PRnkrU1FGZ3JGUHFMdnVIWmhXSkNZM0tvSUtaZXBC?=
 =?utf-8?B?cmk2VERqTnVYSTdyWDRBdXgrYWtJRlluTmhXVUJaTXNEV1k3WjFzcFVMQTRw?=
 =?utf-8?B?VTFKNGdyWVIwYVlpeTBPYzVjaGlLUjhXMTlyQUwyRzBkSkdjVWhUQk96R2Zt?=
 =?utf-8?B?TDZZVEdZb0hnLzJMcyt1VXp6RWxwbHZNdWhBaWRvWklMZjZpM05GTDZ5NEdG?=
 =?utf-8?B?QURaZmpxWDU3Q3A4L2xVVWhQcVozNEpYOTN0d0E2cm1DTDRYNy83aGN4Z0h4?=
 =?utf-8?B?RHl2TE1wd0pIWUJDSVdidUd5a3d4VitXbnNOMmY0M211ak0xQlJxb2QwTW9n?=
 =?utf-8?B?YlNUNmF4UHhEODFyMkdUSlptZ0FGdUdhdWNiTjNBZC9acXZnMVVoUkxISmVv?=
 =?utf-8?B?bFBGY3p5c29JUUtPdnN0TjM5MFVEZjZ4UUZaTmo1UDh5cTFoQmVPaEdVVEdW?=
 =?utf-8?B?SEZPMG9pK1hiNzhMOUM1M3FMTnNoUjJuRHRObVJ5VnlmeFVmYklGcmw1MElp?=
 =?utf-8?B?bnJxZi8reVlsa1ZhSzRaVnJIbnR2VHNhcHhYK2F3VUNSQ3NlcEVDbUNpSnEy?=
 =?utf-8?B?VGREc1VpbHpmaWNqYlZUZEo3TGxOeXFkbXNqWkRoN2VzZXJMWVZDdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e44a52-8704-4744-c431-08de7e8f6186
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:25:41.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXgcy69SQXASqc2mBhpHY8aSKPlyzhdTfnX+TjIV9nOqTy+YX9/TeRITvHIgIVUikZ+m/lOsnz14HUY4OLPilqQ5YdDGD1ncJLJI+En4P5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11802
X-Rspamd-Queue-Id: 44D482495C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cherry.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cherry.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-223856-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,rock-chips.com,collabora.com,vger.kernel.org,lists.infradead.org,163.com,hotmail.com,cherry.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quentin.schulz@cherry.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[cherry.de:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Heiko,

On 3/4/26 1:14 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> dclk_vop2_src currently has the CLK_SET_RATE_PARENT flag set, which is
> very different from dclk_vop0_src or dclk_vop1_src, which don't have it.
> 
> With this flag in dclk_vop2_src, actually setting the clock then results
> in a lot of other peripherals breaking, because setting the rate results
> in the PLL source getting changed:
> 
> [   14.898718] clk_core_set_rate_nolock: setting rate for dclk_vop2 to 152840000
> [   15.155017] clk_change_rate: setting rate for pll_gpll to 1680000000
> [ clk adjusting every gpll user ]
> 
> This includes possibly the other vops, i2s, spdif and even the uarts.
> Among other possible things, this breaks the uart console on a board
> I use. Sometimes it recovers later on, but there will be a big block
> of garbled output for a while at least.
> 
> Shared PLLs should not be changed by individual users, so drop this flag
> from dclk_vop2_src.
> 
> Fixes: f1c506d152ff ("clk: rockchip: add clock controller for the RK3588")
> Cc: stable@vger.kernel.org
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger w/ DP

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin


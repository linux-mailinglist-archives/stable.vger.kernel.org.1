Return-Path: <stable+bounces-207876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19BAD0ADE4
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0AD030617D7
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1D3385AC;
	Fri,  9 Jan 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="BbmYiHkp"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7333B6EA
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972208; cv=fail; b=Ex6lyPlkXcZ7ekCGI87AspNrfrX45OA6gqUn52Dp/NLuchA3Jwwaen2FT+2QNye4vkXuTumbLBb2T9qsBThyihuuzvw7q0CkzvOmymloxS4H5DH/9u0q7y+FIGrrgveclUvV2pIR3YEMm8YL57FjmVX0Aux1fMdY1pZRg62ZnME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972208; c=relaxed/simple;
	bh=WYcMVYIt3ktcH3VpgOj5dQR59jqkXuANuc9gCEbIKyw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E0SbYxVBRNXjHkzXnZTVlkt7tHAt7JRV/j8+CqEntmKM2yuTvQtxHmRX5Nvo0CFaoHIvWuSntswTTp5uttf0Tfp4eVzFQfs7w4DnXpPuywPHdLKZ1EYKUrkM5u069h9smIh5ZDuTI7EfnbmHM7JTtBOyu8PUDnRLy2/nLHLOenk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=BbmYiHkp; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFSNfpbU9lTq3n8WZNmQo/Z/QAPXbOuCjiisUmDhsLfdsbakXbu0bQtmk97yIlCUuRES1w3AV5hMaaf4PZPpjCrjkzeZysqvlZzcwEoeUOKwJ3ezB7w9Z31VfBOTzrE5KT6a7FIkjtj7Zao5uUOI1tPbY6O/rm0iXQLyVKNb1IrZqlIoW1eGvh7e4v6YrYRrWwG3+/13+mMNvxcQHsMoBDDJB8QGn57E5wplG56EFqPIjdsPFhEUZhGPDlL8HZHb/2tGclUVEV+I4WWyj4XDySLgIXUZLTcxh9VEN5VKOOJ3x6Lol8FoV/78eP0eI4Y5mcxOyyrHSeH0V/NukhQwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVwVz8+BcIN3KQzYL0T61UR0CN4pqzaZvZ7nMwtgm1U=;
 b=C+92knVHkCNOrVLnFyv0SP/XHM2lCS0lRB4GYQPyr/5T76B0zF5RJnMDcpgjH/Q+QmvUCo89U1tsn+2FjSP50zAFAuSUdcjrlRiugFCZdE1C9QlTzg/atx/W9dsjywpOX0u8+k5TB3Ci/UBMuN1RBmrhKBE0JBuYE+yLFZ1taAlrwsq2h9AlF6DF/GU+rkUFqnYV1ORu/YgPrLVUxo3XP6bjU1m6aCMKeS+tX/RYYUaFIyuCgfCouU7gZK/eA5M4016/uL3PLhRfmgpRSMTqqP8dZj7dG/ZOlJnrfeUrkNt+j4u8Ve+K3HPy8vwDEW1pa2DA4pHAiwRlLflgMdq7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVwVz8+BcIN3KQzYL0T61UR0CN4pqzaZvZ7nMwtgm1U=;
 b=BbmYiHkpRwc6BNtZnos5y+6N8lGJyXfi3iVydFgba9JYXMuCH2XJxG4F6l/b8phJR241VRkGDGZLGJMw/C0j+Dtyj8mDglAdqOvtpRRSL5gTJZlMIL/Rvk0ABSgkVDETgLUejF9iP4YKKReN5ju9io4DLigMpR/mA5X7OWHXjN9wwL2VDUBiAOZsTNtAgw8xaX/vdgEgEO/QWwWE54AsN5NH65eyRD1k2OyYdnlkwgi5IMx0RbRjBryYgPFxUZAnscxNmhHdUgfX7M2TB9q2NgXbiWM6ueS7Jh/w6ENiOW/2SS2x+g4qmx4i4AqI3rupXmwGNAUEi1ew8osQKtO07g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0916.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:170::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:23:25 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:23:25 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Fri, 09 Jan 2026 16:23:13 +0100
Subject: [PATCH 6.2-5.10 v3 1/2] ext4: introduce ITAIL helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-ext4_splat-v3-1-bb8dfefb8f38@est.tech>
References: <20260109-ext4_splat-v3-0-bb8dfefb8f38@est.tech>
In-Reply-To: <20260109-ext4_splat-v3-0-bb8dfefb8f38@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972197; l=2980;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=/Kqh2cD4SnLglcAVM2G6mBrIOfdjq+IXHsfnbkuRFD8=;
 b=wYFzyCd3G+JIAMOTIl9h0nkxuwr7sbT43SfzOjXbLnh9fuBQm/YFa7MK5L/WVTJ17t9lIN03M
 9iR1Ost3o1TBhJZvWvam2sn35lwqipfHx1rLPxGRNmO/LqjTOR2mSQ0
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: LO2P265CA0455.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::35) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0916:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1b3931-719f-4749-c83f-08de4f930835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjdlaXJoT1NnYVFaUDllUlNkaHNQTnc0eENCVUpYN3hQbDArZkpJNWFvYmVi?=
 =?utf-8?B?YStXVVZLNmVTeWdRMGxZSThLdUMxbUdQS0ZIa2dDQ3QxMzRPMDdQSW5oZ0da?=
 =?utf-8?B?QUtqVEdxSXQyd1YvOS9SSGF6Vk5YcER5bStkWDQ4MEZwekFRRDU4ckQ3b1VD?=
 =?utf-8?B?T0l6aGRaZ0J1UXVPcjhsakQwOWhBT2VMVzYxUkxFVTh0amtGL3BmcGJIUU05?=
 =?utf-8?B?cWxJQWVmSDg0MmlxaUNpOXozU05zdXFiT0pSMFNwc1Q2VDZSUTF0Snk4K2hS?=
 =?utf-8?B?dTQ1akZrUldQY0NjU3BYZ0x1K0Nnbm1Pb2kyL2krZjZjZGZUb0lobUVpT3Av?=
 =?utf-8?B?NHFQa0VnQTBXekhCbDZGWHVGbVdLM2U3dEVjNjV2NjhHc1U5MHdEOEpRNGVs?=
 =?utf-8?B?RjI1UTEvZTE5Qi9SSUF0dUIrNTd1Wm1lMXVVbkZvK3FadFZoU0tNWDErd1Jy?=
 =?utf-8?B?L21sd3NTTEtPNi9WOUlVOWg1N2xzNW0xUTlvRGdWcXhpTTJ2UDM0YVhiV0hh?=
 =?utf-8?B?OTM5VU15Q3Z5dm1waWEvRCtPWGd0Z0RYdmNyTklZQ1RrK2FZTnNtdVdCek1n?=
 =?utf-8?B?V3FZcGg3NGI1QUdvcldqYjZaY0UrTVFUaVFGWkU5UVFrR0o5VzBOekIyZUdS?=
 =?utf-8?B?L0RpMDJGcmpWNjVPVmtZRzRMcjNzMlhxMkdqZ1VyQm5uRlRGbEloSnVDbW5r?=
 =?utf-8?B?OHRXOHR0RWlRSFJPamhRbG5SdDdTWWNhaUlKcko0S2VGQVdWcmd2bHkxMEJW?=
 =?utf-8?B?TTBWU0p5QzczdVM0Y1JidUVpV3hxdkVrMVM0ai9jMjZBaHlRQVJJRC9DbWNt?=
 =?utf-8?B?VVpXME05QTdrUXkrcTdKdnVYNFA2S05POUk3YzYzYWs5L1lvZkRSb3NUOEp4?=
 =?utf-8?B?Z29XZWNuamJwVnN5eTNOamxtYStFSGVOWUNjdHdNZElrZHY0Nmt4NjFaMEwy?=
 =?utf-8?B?Y2EvaENMWFJlREhMYTQ2eG03cldwanRSTVhaYTlIZWNyYmx1SHQwblRlTTlS?=
 =?utf-8?B?a2JXWWovRHBnVHJnbzM2enRwdldEOUhva1lRUGt1QXRhNm9wRFlJakVwdXpX?=
 =?utf-8?B?RzNvNkpCM3E3NHBpNDVBVEhXZFptdmhqa3FML2p2NDJIcmN6SkxqL0haWi8y?=
 =?utf-8?B?UWRyVEtOaTJDdEhkcmkzcTdXY25aRm5aYTk2a3JCSzBpTFBKaE4yN0xFck5q?=
 =?utf-8?B?Q25RZGJieG5CTXE5S284NDhEVmlRN1VMdVNBSXEwUVRjTmRtdXhSS1U2c0t2?=
 =?utf-8?B?emJZUmxhY1lrQkxtNzVDb21lV0o3elJGUUtmNUZHcytYSlZJNUFENVg0QSta?=
 =?utf-8?B?dHpoRzYyeEx1eU0yRXlaeWFrK1N3bzZFb0pFamg1MHlKRjNwaDRNbndoZmxT?=
 =?utf-8?B?OCs4K1ZISEw0NC9GdVZzSENQbjVkOFJsU0YxMWYvckRpK1M1aGVGVmJ5TFJw?=
 =?utf-8?B?SjUxZlRqRi9UT0hsOEZ2R1VTWUJWQnF2SXhGZDRuVGJxREVwOHFiK0ZndWVl?=
 =?utf-8?B?dUpwdFl2OGkwUjVyREV6K2xVNGs4bmVMUzUybnhscUY0QkZ6ZHNKQXFpRVox?=
 =?utf-8?B?YmlzbExUS3BXdFdXSk1sSUpCeGc0bE95ejRRMFJFWjE2WVFpdnhnUmtLeFc2?=
 =?utf-8?B?aFM4YlBmZXBMbWtTaGEwNU9qcitXSVRmdzFZUVNPa21rL3RncHNpNWRiczNp?=
 =?utf-8?B?S0ZmeUt0S1NGbWZaR0cyWlk3WTVsNVlxT2RIUHVjWStGSVdqR0JNajY2RTQy?=
 =?utf-8?B?UzVBQlpXOHlEOUNHUFcrMEg4WFIyczhoaU1Kcmd6eXNWMmFZL1lXTVdJS21S?=
 =?utf-8?B?S2FmaUQrVzBZNm1hOW1ZWCs1MDZIcWRlbjJOeDhLckhFZkpxN0dDMTlqbWZq?=
 =?utf-8?B?cHBKb2k4eXFnaGVOV21QWjMwOUx0SmNwSXR5Nm5pbjVGMVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkVPWjZab3V1UFkyeDZ3bTNlaHRyS2hSMlgyUjJJNmU0ajVoY3B0aVVOQXpJ?=
 =?utf-8?B?bVBVanIwOUUxQkN4MDBLMUNxU0tPc0dPSGhXMFpWSk92aCtuZlJCeUhZYVA3?=
 =?utf-8?B?Z3oyZnYyQWRlZ1hNWVlOWWdpVjUzZnQxUDBrVzc4YVpsSG8zQmUvOUR6NkRz?=
 =?utf-8?B?VjFxVEFIQUxIRksybGJHajhwQ1QvOWdza29SYWJCNDNCRUM4RWZ5U0M0NGpM?=
 =?utf-8?B?V2crNGlmRWdEdUl1TDNXSGJWY25zRjRtaUhKSWlBVEtLZ010bnVNYWZXcUhW?=
 =?utf-8?B?cnppNk4wVWlPWWlTVitXay94RitaL1hqTUtvVFJMREk5VGpNTHF4L0RMSGNP?=
 =?utf-8?B?RGNVVGRwVnVxbm1haHBOL3R6NFBOTXozcGhJOFQyMHpndW91VFIzRmY3Z3gr?=
 =?utf-8?B?Qmx0TmdDdllpK0liUnVCMHh3R2NMcFY2QVNlUmt1WWljdEpoY2FUZWN0NjdH?=
 =?utf-8?B?NS9IeWZSUk9nVTdINmcwQnM5UGplQVZjazl4ZjcxMy96L2IzTDJtdTBvVFBL?=
 =?utf-8?B?Vm1QLzJiVTBLbHFGM3NBQXNhUXIzM3YvVlFZNjF0ZGhaK3czdGFXZVhpb1pK?=
 =?utf-8?B?dlVIdDBmZ2RQbDNIQWVGNktJTnRaUVZOUVMzUXg3ZDJlTEpsZFlNMHV6dEFz?=
 =?utf-8?B?VjEzeGxuOFAyaTNZZjFpQUhhT2VJc3R4cFZZOVpEekRjU0FBdGsvYm5JUHBw?=
 =?utf-8?B?Y0s3RFRRbTVvaFdXUzBLODd3RFNuYUhFZU92RktzQ1lGb2xKa1NKMWVVdjJE?=
 =?utf-8?B?OUtQRGxLRUl3RGg0MXdFSC92VEc2dUlVMHNVT0t2SHNyQnNsMG5tUnRxaU0y?=
 =?utf-8?B?N2QxY253aXdnVWpkdTE0VkpaZTlKTGNuZVgrMVFKc2lQait5d1ZIMk15Q3ZG?=
 =?utf-8?B?YmxScW1UckliOWU1WWdyeWNucHplbXlvTFdDd3JldklXeXVQejlES1R4TkdI?=
 =?utf-8?B?TWRvTmJtTU5nTzRndVlYamI1eDhkMkhaa09NY3NyY2NwYzJHdFBKUDIzL2da?=
 =?utf-8?B?MDJxTXZaUm9NL1pzbnpmVW9pVU9wYnlSQk1zcGJLSlhtcE5Fd2V4ZDY5bW1T?=
 =?utf-8?B?WTlkanUzcld3SUcvUWM1cWRSMHJhQzRKNGZiMjExdUpqWVdReTMvK0lpTFA0?=
 =?utf-8?B?cDRCU2ZKSFppcklwT1UydkxpajdZRjNpQlVZTS9HU1hTR3Rwcnh1Ylk5TGdl?=
 =?utf-8?B?S3BidHZEU05vK3lLUVd1aEFBbnhxRXdCaWRwYUdnMURlYTFyMXU2YWE2Rmt6?=
 =?utf-8?B?NXZLMk9PRlhOT3JBYWU1NDBFK1RHSnQvTGRhK3E2N29STk1CdDVDcUtKZnJ4?=
 =?utf-8?B?VXBCRm1rb0pNV1R0Y01DRm5GekxVYm5DQVVBU1cxTnI5RVAxaUhOR0NpRnMv?=
 =?utf-8?B?NXpZdjErZ0lSMG1aTmxKWkhtQnBWL3U2T29hUTYxTnFpZXU2THUyV2k0dE0z?=
 =?utf-8?B?WWUvVEtpMHUvNEd0ZDRQMzFRYjV4WHZOWFNTQkNaS3V6c1htOXlncVZqdWM0?=
 =?utf-8?B?V0doZHZ1dWZZd1JoYkNjZkhPRUN4U2NYUmRnTjUvMmdLcGZPQnBoYzhBSFlX?=
 =?utf-8?B?SjMzaUpaNUtwWHMyeTNLOFBpVWwrRnkxVzkyY2V2eW9veDNmUVJoZ2FneXJT?=
 =?utf-8?B?a3N2ZnJEUzlmbEhkc0hJdG44bE43WWw4VjlqeG5FNXA1Y2V0QUoxL3hRM1dx?=
 =?utf-8?B?b0tWU3cxQ1RwM1lYaFdMNUIzVm0xWmlkaUE5aDIrYVRNOUE5SXo5QUpiTVA1?=
 =?utf-8?B?MzN5dUtmdWtmUDZNQXR3eXo4UUdaUEhwSjlMOG5KclQyT2Y2SHVsNENLWWJN?=
 =?utf-8?B?MDI3aU44WHVpVzNod1N6YjNMVWUrVW42R2szSmxXRDF5UGsyWkR6Z2IvdURm?=
 =?utf-8?B?bWY4VDJVNmZtVTN0VGs1aGhxUk1Ea3IrWlEycVd3cVNHalJKWmhaQ1lPOVpk?=
 =?utf-8?B?dCt2aGhHOEhDOGtmMytORlROd2ZaY0pZeW1rdnQxdDhqWnFJMk53RHoxd1lV?=
 =?utf-8?B?TWtjN1RXL3NQeVJKUnZkSUVSbXdRZGl6cWIrcEpwYUVLWVRUOXByN0ZNYlgz?=
 =?utf-8?B?T0FIVzZJWnRSQ1hhYUdrVU56ZFdxVlBGVEdCRzJoOWczMFA2ZGQzRVJ2MWpm?=
 =?utf-8?B?Z2hPZFE0SXlPKzVxTVhmSHMzdEZmNWE3WmIwb2V3dncxWDEyeFpzb00wVTNW?=
 =?utf-8?B?MkdkTDkwZzBuQUlZbXpjb1U5Nm1lSVNsdHBRNSswdUh2Q0JUZG5Ncmlpa0xv?=
 =?utf-8?B?OEl4N1lZcno3UWhhQzNMOWNORm4yWXBPdkNhalVVd0YyZEFxSnpvQW1wdEQ2?=
 =?utf-8?B?bnF1RS90TjR2bU5rVU5uakV1eUxpYjQ5VnJJUDZBalIzb05JL0RKZz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b3931-719f-4749-c83f-08de4f930835
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:23:25.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OP8ofDTMvPps2Z/pzilsXUfm3gJoNp9J7ZFGoZndTrdBk8uivFADp+lonk9w557pYS9oHwDa+Atsud6bO3MpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0916

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 69f3a3039b0d0003de008659cafd5a1eaaa0a7a4 ]

Introduce ITAIL helper to get the bound of xattr in inode.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-2-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/xattr.c | 10 +++++-----
 fs/ext4/xattr.h |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index fa8ce1c66d12..73a9b2934865 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -599,7 +599,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -744,7 +744,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -826,7 +826,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = ITAIL(inode, raw_inode);
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -2215,7 +2215,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2739,7 +2739,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = ITAIL(inode, raw_inode);
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index e5e36bd11f05..9a596e19c2b1 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -68,6 +68,9 @@ struct ext4_xattr_entry {
 		((void *)raw_inode + \
 		EXT4_GOOD_OLD_INODE_SIZE + \
 		EXT4_I(inode)->i_extra_isize))
+#define ITAIL(inode, raw_inode) \
+	((void *)(raw_inode) + \
+	 EXT4_SB((inode)->i_sb)->s_inode_size)
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*

-- 
2.48.1



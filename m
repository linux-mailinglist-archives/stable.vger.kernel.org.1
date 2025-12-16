Return-Path: <stable+bounces-201151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB8CC18B5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7493B3095768
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB933D6C4;
	Tue, 16 Dec 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="z9xVZMiH"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9A33C521
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765873244; cv=fail; b=O0I3OhG7wxICqb9m2/dQFEVKGE4vlUZ0H/pPuzOBtnmsxXiKtvUGa3iyfzgKHysLAF2jU1r+H9xB1EUwVybGrXaZhDTQ+m8wHMTjb6MVhrMG1+AXAdFCwE8jfUGRbm/HQ8eut8wJAV7RCm2O9IxtxR9mPTqGJ3WWNi8ob7fQags=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765873244; c=relaxed/simple;
	bh=Cd3rxsIO4QwgpScCTgjvXJALqZd5tXDIs7WJG8gXeOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YGolxLZaXsaF9dtX06EzkjluXtsdYCki2F9S0MfzRizucMWVYDgGNLvjwJ1qci5X0Y0vPe1/m39XVCyuK5/Keq4CclQ+5K+4oU8tTYI7ZUtRymuaam3ZcxAm+vkzOZS3d10E46t3hP56BwPKf9GsJnE1AvkurAz6V2HyrvJAUXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=z9xVZMiH; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjB73uUWegH2g35r34jr1n/OPCWUc/8SwQwIPznn5ufa6pfww4DDcxueH/0zRNqTtC42FZOSb2/vjY/kJ+GycpIR9ae4bCKGbWjALEevFuL4rYXpJSPFv31omD4vqMmDtK5apWq3yUrDOf8e6V+REkCAfQjEkmQvU+TRYKnbv7V3OlZqJ04GRNPa9/tuQkFbqm7NR7OIasMsI26Yz0IwFBfMHSJVrdwsncim8xu1Y8BpeVEDkrYxSncWkz2atTGhQVZ/DKE0iA7ziJWsNkjAdtEjl8f9z3ZRKmGMiCmtOsWtnZ1msTq8eu9ekpRDNJqV8o0O9tHRFravqBGaZjSEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7imds23OAPNE4G5kyvO8Mh6z9IpTqwhcrOhHLeF/j3s=;
 b=bTygrzTgA9F2HD4cGxiQwJZs+ScGxJ1rnRrK91Vua0JtUsihzx50x+MEdJJfhomx0oCfc9GIFdXRKbDRySSVx3HJjWfaOAbzlkzssRyzFGBAn/izU6MU/gCc0oJKO8/EaUaoRccOud0Tx9IPgA4o6C7eI5JJa7nT75le7AkEua0kWKD/6r8+82+qirL7bLZj6fb4je8WMCmSPig/pwdT0VPfl70DJdGRROoEDibewVzOHxPPeffyO1VkfcmZEnzsdGQh1FsLc/mPadxUtq7z/x1wT7KnQNr4qGRyrN5KCO1oRkqvtQATWSjI6/9I1NGYyJQbq3zhsLoY156FyYFg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7imds23OAPNE4G5kyvO8Mh6z9IpTqwhcrOhHLeF/j3s=;
 b=z9xVZMiHmz2ZDHMesZYhpp/EHzPb1j3A7z2DyYddR6cfDSOthros8B8Euhx2g9QTfIrRNvs0hiVKLs2fbWQt9aPy03UwK7Ry0I0oB0rM7fRR0ZRFKwA7Chl4w7rvp2d7AhekAFgABXkPtfZhwW1o/xvEQsAwF8qNc49cuIxtl0jh9wXndEKnfNomh+QPW6u/T+qR2CggDnCWGc7OCV94WCSUT124fiaA/YuQK1TKB8Cy2DD6txU3UDdY2W3U0gt7TDgrfu0S6WPV2yD+ImEEmvCNOHnPsBwJrdi25Fq1bE9oheRtW/OGkhoOrQrT81L5kLvQhSQ3CwtGmF2ftPb/lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by GV1P189MB2836.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:20:31 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::bc3e:2aee:25eb:1a0b%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:20:31 +0000
From: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
Date: Tue, 16 Dec 2025 09:19:36 +0100
Subject: [PATCH 5.10.y 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251216-ext4_splat-v1-2-b76fd8748f44@est.tech>
References: <20251216-ext4_splat-v1-0-b76fd8748f44@est.tech>
In-Reply-To: <20251216-ext4_splat-v1-0-b76fd8748f44@est.tech>
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Ye Bin <yebin10@huawei.com>, 
 Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>, 
 Jan Kara <jack@suse.cz>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765873218; l=7470;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=lZEpHN2+NBtT5zUEluD8OH672ozSoy+Rlke83AjUxrY=;
 b=rwpXkuW/jUk3curhdLntRMoXvK1r+VoqurtmZBp/E/IVAA9Yb/U5dJElJMWf2hdf5iahYZ2gj
 G/7POuBOEWjBWayet8/m79+UuZtwRNe6e/msLhL9X+eh3PygMBPZO1V
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GVX0EPF0001A050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::49f) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|GV1P189MB2836:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0aac33-a5fb-4fa2-84bc-08de3c7bfa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1YwYm0rOW1qM1lsSlVyTk1lQm8rWnM3TFZVZ08zZnEwZVAvNjhldzNFQVZK?=
 =?utf-8?B?VXhQK3gra0JGRGdmSnNkVUZ5U2lQZnptMFRHZ3YwTmdMMDJ6S3pxUkVZQlB2?=
 =?utf-8?B?Z2J0OHdnK3JwTTBzVW9vN2hOSmpZclhqM3BFL3Z4eTlnSnlxVy9uK3JXTkZZ?=
 =?utf-8?B?TEk5dUlIUVpidjVQOTdZdXcvRTlXSElQejdCRmZ1ZmxCRFJreXA0TERiNSs2?=
 =?utf-8?B?ams3bHlFUnBRYTNCMWRzRkxMYVpNUTF2UWZPeEZiazExRWp5cmdlbVdaRktK?=
 =?utf-8?B?aEYyVGt4K1JnN0E3ZjhTL0VJaExnNS94QlF3TTd3TWJ5SlBrVGc2YlowT3JD?=
 =?utf-8?B?M29hbHZheDF1aGdKbGdDUkR6enNFbWYwa0RHTndnNWxoUk11LzJJYW15eUFK?=
 =?utf-8?B?NGFZSllZdG85NFR3RWZzVnBQcHlGaDl5U3RPMEpidWZKZkIzN0JrMHMxZGJK?=
 =?utf-8?B?TnN0eU1uMkV1R0hmVkU1NWNabk9vQkFCbjFBS05UYWliTEgrblB1SXJhZ2V2?=
 =?utf-8?B?TW9jZUMvREQzRlVXSDRIbm5qcllYUzJOWXpWOEQxTjcvY0JzSGdnRDRSTng5?=
 =?utf-8?B?NHBNUUR2b2dRcG9rdEdDa1VkTWhua1VvRzM3em9wQ1cxOWJRNGxudnIxblh4?=
 =?utf-8?B?NGlvaGxzcFZkcDQ2aElaQUtrN1ZKUEpySlNxZ0NKa3JFN0hsL3JZazdkd2ZY?=
 =?utf-8?B?emNIQUlSWC85alRwOTBaYzZ2Mk8zZ1JVWWVyY3NpMFV5V3RKUm90RWhpVFlF?=
 =?utf-8?B?azg0bDNoeVZCZGZoR3FycURqU1hPRUM2TUxYdmQ0R3F6a0I4bnc1VXBPa0pF?=
 =?utf-8?B?TlVydWhUNFRsbXlBSTVyamorRmJhTEV3dS92RUdLQTBGNVA3NDdWZ0FVdEdj?=
 =?utf-8?B?aEIrMHcxMjlHdVBzM2s5Nmh3R2s4TjZBdDBTRlBOaUJYMkljYWhJMUM2UnRK?=
 =?utf-8?B?eTl3OWREZjdQWXM3SHB3THhscHJIWmZuSTA3WmlmVm8rcXkzMGtnOWkrVjFT?=
 =?utf-8?B?a1Ztalcxb2FvR0taRFprakN1MllrWjM5SXM3blpvdG5ZTGpVS1A0MSswVU5P?=
 =?utf-8?B?cHRaZmxNZE9lbStzdlRBaWxpd3Q1cHNWY1JUc2pTNEdoSUFBcW1ZZmdXcURR?=
 =?utf-8?B?ZUpVSUp3QTNEU1FWcDFNaFo4UVc1NyszVGdPV0JkcWRySFdiRmRLSjR5TzZJ?=
 =?utf-8?B?dFd4cFk0TG1ObjFmM3VpMmhJU1Bwc280L21nRzEwMExrek9ldjJCZFMrQmVQ?=
 =?utf-8?B?TGJBNExzMytoRTBLamdiVVVreWRxWTRzVzFqOFZlWUdZaTAzbURucU9WYUp6?=
 =?utf-8?B?WXh0YnkrbEhtenJObkgrcmJKOGpFWjgwYTN5RE1JVXlmK1ZZUjQwQ3gxc01w?=
 =?utf-8?B?ZEl6dDlReENHaUx2QWJ4OWdjREhnRFg3VlBZdTcrOHUxZzVHR2s0YzkxNjcv?=
 =?utf-8?B?TENidnpHR2lKQVhHaTFYRm1OQU9ObC9WSXJXQ2tWRjVvVk02UDR5cmFLNi9L?=
 =?utf-8?B?ekI4ZldmR1hmdFRXZ2RILzhkYTQyZEFvRk9IRkdvNnROSURhUlRCRndLYnM1?=
 =?utf-8?B?dXhtWmJqVjAyTENZM0k5T2FJNTFaOUpOYlRZZVQveWxOdG9JWjg3TGdqU2Nt?=
 =?utf-8?B?dURWcnl0SUxnWmhXWHkyemQyR1RJK1k5TVJSWWQ2RUFpTkNta081R240TUs1?=
 =?utf-8?B?NC9vaEJGNHdzeVZqbk1GclVVemYrdTBTaml2N2lRK3RiaFVYaDlGbVcxZlQ5?=
 =?utf-8?B?ZjZ2b3lMNnFkeVk0SVdyVXRZR3ExSkl4UitpZFFiOVExU3J5Vk92aUNpT3M5?=
 =?utf-8?B?RHBKb092WUtwN2IzVU11ZTVKaElVSGZYVTNKVW5ZdzVPbE8zckloZGtwbnNw?=
 =?utf-8?B?N3ZYaVdkdWVQRjB4Yyt4RVo3b21FdkVuK2IybmxXZkZMcFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW1kWHVaZmdyRkQ3N0FVUkwrUFQ2S2I5NG1yeW14K2ZsN2pJNGM2b3VCclB5?=
 =?utf-8?B?NVVMeGZaVDlxOU5odGtKek9CZnJHbEVKc1EwSzJ5QmszV2pLZUtSN3dsaTB4?=
 =?utf-8?B?Q3VmMW13dG8yYk42UEd3SVh5RDFxVnV3ZmE1MHpSQUpwRE9aMnBzUjE5OFg3?=
 =?utf-8?B?L3dIejBXeWlQWmkxV2N3Z2h4SHZUVnhnMHBGd2JBc1RUTno2c0pJSDJuUWhL?=
 =?utf-8?B?cnBqSWp6Q0d0UXliNDhwM0htZnRITENkVERtakFFVTlaa0RzRXBobS9RanVp?=
 =?utf-8?B?NjQwVjA0UHk2VWNZcGNobmFZWG9wbUFqd3ZXRVlLWklGQ2ZkOXo1L1BSL0pX?=
 =?utf-8?B?TitNWFJEUjVXT3pOQWRqQXdLc3ZnNzlKWG0yQlJsRzNocmFqbXNIMUpkSmtS?=
 =?utf-8?B?QkpocjI1SFQ4RDFtTk92T1lIZE5XYi82Z0Q1ejBIZFFEMzV3UER5dlhhRzhT?=
 =?utf-8?B?N3JnYzF0bXNMb2VYUEZDSGZOQitqdGVFM2VuQ0I2RVU5UndiWWFSc1BwYzUw?=
 =?utf-8?B?aXl4bEQycHI2WC82dXB0UzhwMmJQVGVUQlV0SjhGOXhXTEJhM3c4cmI1SEFr?=
 =?utf-8?B?cUZrV1N6aHUvSTBMS1FnaHZsSmx5dE5UN1N0cFJSbjBSY3BzTnByS2wwbFlm?=
 =?utf-8?B?N2dIaGRZVFg4THI0SU5xT2lNakdHVE82ODFMWk1lRUtjQ2pnQkNnU2RybDZF?=
 =?utf-8?B?ZTJtaktCZGVnU1kxTjF0Q01OS2NhNnJGQ0J4S0laaVMwUDFwRjhHSi9vdFB4?=
 =?utf-8?B?K0VqN1Blc2VlbE9GRDRlMGxsQkFtYW16eU9SNm13YWtZeC9XZ2ZHQmpCek16?=
 =?utf-8?B?Y2dOcTAxcEpuNGRwVS9NNndaQ0RuRGxyaWdZTVdBTXpRSkladDhpcysyRVlY?=
 =?utf-8?B?Q1Z2OURXYTdtTnE4SjJublBkYnEzMFB1TWhvcEtaa2tiUllXV3RVYjl6OGdZ?=
 =?utf-8?B?QWJPTnZpNi92cTlkcExxeStLNGgyWVlYenloZ1kyMDN0NU9hUXRSSnJkV1kr?=
 =?utf-8?B?QVVLdFBFMXpkRStCc0hBczRtbm1lMHJBOWFwQzBHdXc4SVRkcVhWaW1KbDU3?=
 =?utf-8?B?bko2S0cxU1RBZGFianh6M0lFYlJWb2RCK2hiNTBySURFdWlWYmE5NVZydjBP?=
 =?utf-8?B?TXZhOVRTVVdoOW53dUZPYlcrazlqbUp3TVNzdHNiV01ROTBMZ1JabHpic3pO?=
 =?utf-8?B?aml2c1Q2UVdRMjNWdHdac0tqbWRpTTMyek1hanZULzRYYTM5ay9mdGg2OXZE?=
 =?utf-8?B?SmZYWTRHbmRvYnNyR043Q1U4T1BkVGxjMll3UVE5TlhoeWVXZEhXTktKbnd1?=
 =?utf-8?B?NU5laUIwTWIwS1JqVTI2Sm1SVXRFcFQ3VDdxMS9HbmZXYVhNb05hbDJpNFlt?=
 =?utf-8?B?WEIwY3pDMWptZWkyL05CNzdsSUpBQW9iQ24yb2ZiZG44U3lDUWJVWXVBRUJX?=
 =?utf-8?B?MHlLZzV2eGF2Wis4SUs2T0lsVlI0ZjducE90aDJpQktYZEJudE4xMHNlNFZ1?=
 =?utf-8?B?Z0xqYzc1b0NYaXFYdWJSRTBoazZuSjdQSXZhOU5hRkxCN0w4aDNmYlA0M2sw?=
 =?utf-8?B?YUxDMVlpQUpJc01Wbk1uMkZGRVVzK0JSZ1hXdlZaNlFDd1lRNkYzWW9oeHJN?=
 =?utf-8?B?OUFHOU51UGNMcTI1dFdXbmozMGRydU5hTG5ubG42Q3I2MDc3N0FmSDNmVHRl?=
 =?utf-8?B?QndGcUo3ZVJXODhBMFV5L3JRRmIwQzlyak1lRTJKeTI3QUExMWNrdENhRzUv?=
 =?utf-8?B?Z1EzK3ZEcnVZYlFrODlxV1JKRmZuRmlTOW5MNG92cGVOZWJidlZNSFRlYmw0?=
 =?utf-8?B?ZitOY2tibW40MWhRNWtMeFlVVmxFQm5qc3lLT09oZWJFcVNYemNlVjdPb1lY?=
 =?utf-8?B?R1ZXMFRIQVZXSjQvKzdlZXBTaHRkSDc0ak9DeitVU0sxbGpPLzZubmZ2cWxV?=
 =?utf-8?B?QlMxcFAvd255VTQxdHBEVWRhMXF2K3pOdk9RQjlia1c4SW9FSVo5WE9pVDNw?=
 =?utf-8?B?ZHpwSEQxdnFrT1lKUVNwWDREMDZlWUhSUGplWWhYb0RSSVpLdWpGSXdlLzhy?=
 =?utf-8?B?RHkyeFFSaHVCRnRqbVRTdkVrKzN4cUN2UGdLV1hUL0duV3BKVW9CTGZ1VFBM?=
 =?utf-8?B?RzAwY0JaVEU2YnhjVHQyQlRtNHY4ZUovVnZBSkN0R1o0TzNScktCNDAzQmpo?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0aac33-a5fb-4fa2-84bc-08de3c7bfa7c
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:20:31.4988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSATg7ewZkg120Ecj6qO/T3YmKemq11uTivMakKD3frDqqSikSsqfylINOZUaa+XrCbPgtQkRf3s0/FeTU18Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2836

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
(cherry picked from commit 5701875f9609b000d91351eaa6bfd97fe2f157f4)
Signed-off-by: David Nyström <david.nystrom@est.tech>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 97f7cac0d349..719d9a2bc5a7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4650,6 +4650,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 73a9b2934865..16b9c87fd3d8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -263,7 +263,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -280,9 +280,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	return error;
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -600,9 +597,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -734,7 +728,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -744,14 +737,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -815,7 +803,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -826,10 +813,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2217,9 +2200,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2743,10 +2723,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 9a596e19c2b1..cbf235422aec 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -210,6 +210,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);

-- 
2.48.1



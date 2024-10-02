Return-Path: <stable+bounces-78660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8698D400
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BC21C213EA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE011D017F;
	Wed,  2 Oct 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="BwnMV9ks"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2090.outbound.protection.outlook.com [40.107.22.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BA1E487;
	Wed,  2 Oct 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874465; cv=fail; b=VDLN5BTh2TNRKUMmO2rp9GLFAqoqpXI9MUze9e/K/YsnMAtLgzFtY/wA0WFHJ8fh0DAWEMjF5wZBiKaV7NKHwR+mYnPankmpVIYefzy1O6EcKItYq4edMCWItGPvVz9n4AFhWdriPEucw0pQa+Gc6pf1HPVmxSR77XWQIn6JHtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874465; c=relaxed/simple;
	bh=mNcaWdrMDR/fuku2fR+KFW5Vf5MGKSCqN0FNvRhzPO4=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=oUedvpxpRe2C0TR4UaY5m2DpqhN083a6qbxHth4qAa9tjgJp/a+5oNXEsLeeeSyewcii6xEoV0QCdfzInyS1TZaxX8tDt9dXm/Si5jt0p4Y5rUExvTIxr8uEMkNYz8m5+Y4IJazHMcc7Fwart2mlOUQ0xWhD4R/QUoypEvwvPdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=BwnMV9ks; arc=fail smtp.client-ip=40.107.22.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXOLxniCHdFk7Dm6EEFnUjBEX49qBjqrvtfpPxPLfKy6Tp28FOpAHRzmBq69EpBBnEKPB5qDyH7Guj1b3eqJRkdG9DX2XtR8Tg1GDOVJsOFmnuoGqEbjWMDah/Z56KnzlLmlSVm6HKUtlNYsHFqywkaLPNu/8X6BbrLi835QfSZ3WtWXCSuDCfsp8TiwkbWVVyCbsr9Bk9r21W4dvv/OZ+DqKMiwS1og1o2810haDCarQLc53lEzs3wgyOQF79tCtmEB7tCgwVNDiDmDbi4cdb4WFLmbjJJpu0CxJjMlgBYgaiVOzO0ZcMewsxcyR79vJY0lgmCpcZFvDvWlRxMYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERHe5MiP41CDwHdd4B78/f9IMtJ0A5VrzTFQx+9vjuM=;
 b=tvQJvX3ecF6RXJfnnYBf7W4Bw99CQe0MiEa/TguyPXUs4u+e8bCZxgld9aYML4/gYJBZ/YBgY1e0MPSWaVtgmcda1x+5xsaG5/5G43/s33FuOQqURqhC5vIWwUtb0IpHUziXBBG2vbkZwUOQ5sZ8r3o4OrnPr+CpeVItUQ0lHo6BPwiEGTIXkizhZMwSGfpBhARcQpAHbncQQk/mhnugB2LESmM7WvtxI1JY1scLZ18TesVydLTil/We0c8x9nxP0fFKIWloHEMUQzLADvq0YgUSUylvnH+UmyAZ+E0VkJ7xREM51LH8z7Ph+QzlELbPqFcIpSGC92K+KFu8YtwdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERHe5MiP41CDwHdd4B78/f9IMtJ0A5VrzTFQx+9vjuM=;
 b=BwnMV9ksk7K2npLcXdIP21JN0TEHZANn/uHsdNZrXwUUUbn4zzwo8pLbJndyNDEX9dpZyF9eFZB2Ic96dVli1umQU1u0SAumhrIIvv5JCEEwkMdRFOHTxU2db9wquIspoe6mYPMubgJOpY8qIUfsRVUdHr7K2DpH3eeDIUkr/dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10588.eurprd04.prod.outlook.com (2603:10a6:150:21a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 13:07:18 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 13:07:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 02 Oct 2024 15:07:16 +0200
Subject: [PATCH v2] arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin
 numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-cn9130-som-mdio-v2-1-ec798e4a83ff@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAINF/WYC/3WNQQ7CIBBFr9LM2jGAoMGV9zBdVJjaSSw0oETTc
 Hexe5fvJf/9FTIlpgznboVEhTPH0EDtOnDTEO6E7BuDEkpLIRS6YOVBYI4zzp4j6sFIS0fvTn6
 EtloSjfzeite+8cT5GdNnOyjyZ/+3ikSJwmp1I+2dMeKS44M9plfYuzhDX2v9Akw7rjiyAAAA
X-Change-ID: 20241002-cn9130-som-mdio-4a519e6dc7df
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::9) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB10588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd362f7-8811-48d1-116e-08dce2e324f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFBGODBnZDBXdEJDQnRWdWpqQkdPanl0K1Y4THdpQXZMY2hmMTVkcThjVUZ3?=
 =?utf-8?B?aDNxNVFNd3dOek1salBwVFpPeCtHSlRndnJaczVpd3lrTUpRdTAvZk9lOTJi?=
 =?utf-8?B?MzB0eWJQeXovNTVFNm1DR0Iya3ZYYkFqU0RwWEJ5RFhKSFNLeHcrK1l4K2hQ?=
 =?utf-8?B?eW56NVRyNVVPaFRlNDVjNklSZW9UYVNGU05WZnhuV0JYcUFZN2l4VlF4UzVT?=
 =?utf-8?B?cjQ3bC9GZ0NRd0FkeVBzTEprTGFsUVV0QkxmKzAwSUVOU1ZZaEQzZldOQVNF?=
 =?utf-8?B?NGZMRk5sbEFLdUFKN1JnMEFyZndQMkdianVueXVVU2NmZWhsUEpwdWZxSTEv?=
 =?utf-8?B?dk1NTUl4RWNnNHRKMVNHNUx5ZEN1L2RRL08xNXdzdHIwVEkxcysxSEgwZGRs?=
 =?utf-8?B?Tnh2U3lxQ3RIdEhNc2RKQ1ozSjhCVGc2bWFNd28xQWVML1k3U3hKV0VNM1RG?=
 =?utf-8?B?aXdNb1VFZ2hDcWI0L0VsaVVyaEdMREt3NUtyQ1lJa0g0anEwSGZSRmIvSDFG?=
 =?utf-8?B?N3I0dytFMjhRbjZWaWFzcE52Q3g2ZzU0NDNiL0NqbVA0cHFGYThNNkw3MlRk?=
 =?utf-8?B?aW9GVlB4YStFZ1ZDNjV6cXBpcyttQmhuNlhBenQzdnMweGk5cTFhSlpLY05j?=
 =?utf-8?B?aEd3ZzBDN2d4cnk1TFNHdjRoMEpBODJmNlp2cXpjOWdnTjZmdUcrU0N3Zkl5?=
 =?utf-8?B?RTR3SHJNUWk3VXdZU3hQcFFDOVhHVlIwMjQ2UGZ6MW5lcnR5dFE3N3VFeDY1?=
 =?utf-8?B?Ky9FS2p1a3IvZWNTNDJSWDk3ZUgzUTBQWHFpSkFKNEVzTHp4OUc1MVdUcFBi?=
 =?utf-8?B?QTJjUkdCcnI4M25WWnc2NmtnN2xpSERNcCs1VE5INjROVnppbFF1Y0dzVlpR?=
 =?utf-8?B?QUFZYWxvazMxY1ZKT3haVGFNT08rN0JIK1BQeHFXVXVWQ2xLSmxWSlVPc0tE?=
 =?utf-8?B?ZWRIL2dYK0ZkR2Q2T09QK2hnLysxOVVuS3JPTHVEQS9vK0pmTlcxcXozaDVJ?=
 =?utf-8?B?Q1FRV0Uya0NMdTZCVTR6MDEyWE9kR0xQaHlBQnMyZUhqaWVsTXJBTm92SCtt?=
 =?utf-8?B?a2FDR09xVy8rWGtSYXQ4SWRCS09hN2UxbU55VU42RDVUUis0WHNmOW50UWRY?=
 =?utf-8?B?aTdCcy9IUFBSajYrc1B4dXZmV01EVExRMjJ3dldTc0hpSUJFS0cwdWQ2Y29h?=
 =?utf-8?B?NVdnYnU1MktMZU9iRGt4RzN1NFNDNUtOS1hkQ3dMT3JPTEorcTY1TUkwN3pZ?=
 =?utf-8?B?N3Jaa010N2g1MlZhRGpEcVROVzdKYjBsVERQRFgyWHd0VnI0NTBmK2dKcXhX?=
 =?utf-8?B?NVRieXJWRnBpMklESjEwRUZXYkhUZS91L1VXSlF6Y0FRS3U1ajBDSFNJaWZS?=
 =?utf-8?B?bFlmV1BtZ0d0dWVlRmhtSHdkOEZlWFdJNWxvRzErR1lvWHRzQ2c0Zzdzb3pB?=
 =?utf-8?B?dHpGRStFdFYvNmlaUjVXNzcrRVlvclJ2ODkvcjkxTVVXY3NpWk1meVFOa2Zq?=
 =?utf-8?B?Qmp1TEVvR0M3K1ZPR1ZycUtueHNIM0RmeVVPRDlzbXBDYm9HT2hlbmxlUlRN?=
 =?utf-8?B?WHhIRlVrb0NaYXA1NGZaaTBDVmJqbHlBamdqNkZZNkQ5YmFzeG5qVUFTcENT?=
 =?utf-8?B?eURlOHpCVU8zbDVjdGZwcjBNYlhob1NOd2lwemxlNU1YTitkajFxM2Q0MnFx?=
 =?utf-8?B?cDlzWFJ1VDJibFVNL0EvcGhMWHNyUGY5emplSTJHY3FzdndZVkZYQ3JETzIy?=
 =?utf-8?B?WjQzQkpDa1lTbmI4T2tpa0NPb2xSSzJodE1CQlBwTENGKzlsamtOb0RXVXIx?=
 =?utf-8?B?NEVNeDVMejZSa1ZHWmpYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STcvVjk3OXB5MlFMM3FML3BVc2tESHJBRHNYa1FrZE5lMnQyK0FFYkt0bC82?=
 =?utf-8?B?VjFUL041WTI5VnN5Y1FBTkJMM1d3NjZvUk5zMDhwaFF4Wjg0ZmlNdTVSSnJh?=
 =?utf-8?B?eEF5RHJYcmI1WkQ1YzRvU281cU9jU0t0a2dLZEV4azAvTWEyL3ZUZHRndFRF?=
 =?utf-8?B?SDhzdWZFSjV3ckNrVytqclVwRmZDUysrZ3o3YnRISzZsRWZtQTAwbTdKV2xp?=
 =?utf-8?B?dU9Yd0g2TWs0aVZyeFNTcHpNOXBKNGFaMkY5aVRSNklxU1dmVWFQODVuV24x?=
 =?utf-8?B?bmlpS2JhU2FGMHJORXB4eHUzMlp3RUYyQkZINDRnSDNtVWR1Tk9YeTRhaFRV?=
 =?utf-8?B?VXI1NFNuMDEvQ2NFMDRwb2VselBBWm5DTzQyeVpxV09BYXByRGpYVG0raUZs?=
 =?utf-8?B?MDN1UG9VNTZZb2ZyTjNBNTYyREt5aWdzMmFMRWx5M2V2YWlFeDlhMWJiU04r?=
 =?utf-8?B?dnBIWWdPMmdJZXZRbnRBdy90cmV5R2tBUnd2VUhZcjBVT1JZdGNySmsxbFQw?=
 =?utf-8?B?OS92R3Z5WUMwb2VvZUpSVHgvb29STENWSHl3dUN4Tkw5QnBZeE5tUXFoZHlX?=
 =?utf-8?B?SXpDTlVOZk12M0NjN21oQXlnbFB5M0tkNFBwWkRZVHhsbkZ2N2xyanNQdERO?=
 =?utf-8?B?ZjVENEl0ak56UmNMRG5uUVh1WUlBQkZON3Y4M2dDKzlLdXNsZnY1V2t5Y1RK?=
 =?utf-8?B?aGhJWFVkeEY5S2E1UEhZMHQwTUpLZHhMSDk2blJzdElna2ozOWtGNHhrYVU4?=
 =?utf-8?B?bTdRaThpQUFOZGY4MWt1ZGhVdE9EOE1HSWIyZUlKNnZNWFVBaFhmRUVhcjh5?=
 =?utf-8?B?QnVmd1pHY29oMFZrbHdFOVE0cjYyVHA4WUlWYTlqNTZMZkJyNlBRb2dEbFFh?=
 =?utf-8?B?VHRmU2hNSGE3VzVFT3FsNldsaXNmWkljc01rTkdKekNrcHJLMzNDNmFEQ2VL?=
 =?utf-8?B?UnJmSm1PN2hjZGZFdUc1cWdNRjVYOEgvL0U4NnVjd1RkcnR5VlM5NEdyVnBW?=
 =?utf-8?B?TElHYWhaS0hRQ2NYaXZvbFIvUG5VNmEwZDdjaXJOWDA5NTFUckEvR3B1c09H?=
 =?utf-8?B?QnJJNExSZFl2OHJic3dqcVVzVHVwRFR5V2JNZnhFd2NQQ0xZUzlLdVZ3SU0w?=
 =?utf-8?B?RXNNUHNKU0tMV0JqYzRteDBlQXRWYmRQdC96eG1WUTk5ODljT1B6WjVTSVor?=
 =?utf-8?B?TTM1c0hHUW94UzJDQTRSMG9GdUw2SmdvazViNVozVTg5VEs0bm1EeERhejlv?=
 =?utf-8?B?Ry9yZDArRUdvWGJQZXdvaVh1aFo5clNWNGpCK0VUYU0zTVFWMWtJUnhhb2Uz?=
 =?utf-8?B?eEd0ajNiRkFoWDJBMTNyRzVyejEvclhvcmw1aFR6bndMZ1VicUQ4REdScjVC?=
 =?utf-8?B?M2lQZUlKWkVPdnlyNHI5L1VBVnNoTHJKeDhTdmZmYmxYMEJSRjVOd3dpVVNP?=
 =?utf-8?B?SG1GQlZjZVJlc0wwbjBLRXVzR21GaXRiQ3pkTklrUENlTWhoR1c3aDh4eTI3?=
 =?utf-8?B?Y1NjUkdveU5WUGl2QjhDdW9ZdUVXK2ZiYzZFbDB0TEU2Ty81VThVYytUdlBy?=
 =?utf-8?B?Sm5LU0dsNlllbjFQYTEwMGpDcSszNGRvaEVGa3BjdHY0bG84Zlh6MmRaUklU?=
 =?utf-8?B?Z01WakJ4VmdJTm44RnBJN21uSHlsQ2hLWk82V2tIcS9GQVVLUXd4WDJKWVpV?=
 =?utf-8?B?d0E0SWFBWklrTGdrWXY0ZDIvYkNDME1UOS9kNEo0NTZhYTFFN3NxWXBlY0pO?=
 =?utf-8?B?cjJsWFBmUnZWRm1leXhXS3A2WlpjaE1SRUthSEVRK25idGoreWFZeCtIbjB5?=
 =?utf-8?B?cXNCZlFSYS82VEc0T053d3JEVlc0R1Z6bVdLNUF6czBTUDZsNVFuaFI1U2NR?=
 =?utf-8?B?SVNGWVpnNDNnVjd5VENDVzZwYTMwTkREdlN5cjJXU2FaNGZkNVBlZUVBQVBU?=
 =?utf-8?B?UkhWUHhUSG1YdStwem03UWowVFU1b2dTRTh1bFRlbG9mcSt2SFZpSVF2V0k2?=
 =?utf-8?B?NlRIbW9UZnkvZ3VUMVo0ZCtScjZFcGcwYmQ0RHVaVmIxaE8yN0duWlVJQ3o1?=
 =?utf-8?B?SS9QMHZvNHhnTW5vZ21ibnRJMDVGbUNoSi9NY3N2U3BYUzByTThOUEpWWUl6?=
 =?utf-8?Q?1E2vgpPMqAx6fvM3qfELwvEvG?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd362f7-8811-48d1-116e-08dce2e324f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 13:07:18.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L2yGTAHFMAfz9bJxbDule35T6m3fTJiDt7LXiODNFAWbAXCGo88aqcXlpkNCdzbldKRm95qZQoX68GuzcfSxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10588

SolidRun CN9130 SoM actually uses CP_MPP[0:1] for mdio. CP_MPP[40]
provides reference clock for dsa switch and ethernet phy on Clearfog
Pro, wheras MPP[41] controls efuse programming voltage "VHV".

Update the cp0 mdio pinctrl node to specify mpp0, mpp1.

Fixes: 1c510c7d82e5 ("arm64: dts: add description for solidrun cn9130 som and clearfog boards")
Cc: stable@vger.kernel.org # 6.11.x
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- corrected Cc: stable list address
- removed duplicate "mdio" from commit message
- added Fixes: tag
- Link to v1: https://lore.kernel.org/r/20241002-cn9130-som-mdio-v1-1-0942be4dc550@solid-run.com
---
 arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
index 4676e3488f54d53041696d877b510b8d51dcd984..cb8d54895a77753c760b58b8b5103149e21e2094 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-sr-som.dtsi
@@ -136,7 +136,7 @@ cp0_i2c0_pins: cp0-i2c0-pins {
 		};
 
 		cp0_mdio_pins: cp0-mdio-pins {
-			marvell,pins = "mpp40", "mpp41";
+			marvell,pins = "mpp0", "mpp1";
 			marvell,function = "ge";
 		};
 

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241002-cn9130-som-mdio-4a519e6dc7df

Best regards,
-- 
Josua Mayer <josua@solid-run.com>



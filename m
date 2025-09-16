Return-Path: <stable+bounces-179691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172CBB59030
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AD93AFD63
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788091C3C08;
	Tue, 16 Sep 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="LCwVwflS"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2102.outbound.protection.outlook.com [40.107.93.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC5158545
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758010635; cv=fail; b=lCdGPy5liEbjpiFCupd50HPufG2PltYijHUf66Y1BZBhMzxzEZBotCxBzZmwbLRixF47FtMAlduzj/1/YwBteeymyh8sCzLBXVDAQ0ikKgDi8Gs3RuD1Li/d0sbvgMeh3LOccE1Sw+ijr1Sx1WXhzErxDVC8W/ht434wMhovsHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758010635; c=relaxed/simple;
	bh=uIJFl7Q3U2fEiMRRpSI6XJ+Uu2J4cX7ApT0meGzvmE4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bVlwcBC/CvSnPomK6EBMRIxYMg1WjmRjVltRu2Ur/zqS9uNId3HjqjQna9uzuHXeTddAUAVbrQC8KMH7PSPjZuhRERW5HU7Hm3BWo12dvGuVs/sfmYg+rxr0IAYCIJwiwckCm3nQFLoQyExQHSAHRhXAOa97oGQc8acVh9YcvfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=LCwVwflS; arc=fail smtp.client-ip=40.107.93.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytO8Y99MqtI8KgjuxFgn1hqsXuqLHElgvs5Ot5IYHWq7T+mg456NSdfa/UUaIygV/i/mF4jMGCq9oLm//jD+saNYuzpeknUCyEgCq3uSBUCPaYuMSyP+NWkLRZFSWFpWQxkbAqoaFkoR111iEXGd3jQSH1k5/+61fLfnakYMsJzEgXNrlZ8YCCrlscolRgCFZLmFNojWrbVmhMPR7k4VBgkWz1FQWmgJUn93wpwi14tE7hJHI8+3SIQA2+36JZOYL8bmChXN4PfXKHgtN1MfngdGJyllNYcgCdm2Y/Q67rPQKJtkcOoZC12u+xzolFQuLEi2k7JZWigPFEh51zR+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIJFl7Q3U2fEiMRRpSI6XJ+Uu2J4cX7ApT0meGzvmE4=;
 b=P2ZQG6NOlVBvp5gpUDZ/zxSIWO2WLFuCnCuVzBmKXUidoKfnSBWSD2/tAuqPSbb6Gz3+bcG2dNhGTxnlCsiwZWqqK/UC2Kt7H3tm2HN35uMOWD/Fav6H6i01q767Hg1KCBhfloTPYHBVByFezK2Md9T2AmO+D+mNnOXuSmEW1fyHCZISzqlI+9eLhoqS7BJPZpm9+Z6BvfmBU+NaXpe6NPUNbiWxmzmENCthPCzXG5WmF3AOSFIlgPEHrPcPQqR+z671FHO/kijnanxcVf5IVZf8D8UXaCXhT4BP9laPojJolt90r2J5WGxKcBXWZpCokEWU0ESMUSwss/37QPL2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIJFl7Q3U2fEiMRRpSI6XJ+Uu2J4cX7ApT0meGzvmE4=;
 b=LCwVwflSuFmDvKSAGiVzWR3qXphRD7MV/YXz9tN+HAYHTce0U9fRWuz1oVlO89v618Uj2Q/UUqGuKgogLEUevkxqWiDajf5HCqUYGH+w9ODOxwaGALmp5CxIoQjb/nmwcKlBFLscjadoWiUOZJjKaaZMYVJPsIgYzv4epEU/L10g665nJ3yzAfzaB4rnVdr538Pp0BM7/IOsBPrV8LYKEGDGK11XrS6fZQ9KbAPbNUbOAUDLKfKoPoBasc3Digh38/8VF0h+cL+r70HmTXX5mk/A/BUUEOpPYPKlQ07NwuZcZuPjRIbcxmgg74n1hhh0Y0UPqOzoiC1UATXv23LZmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from MN2PR18MB2605.namprd18.prod.outlook.com (2603:10b6:208:106::33)
 by DM3PPF260D102EA.namprd18.prod.outlook.com (2603:10b6:f:fc00::694) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:17:11 +0000
Received: from MN2PR18MB2605.namprd18.prod.outlook.com
 ([fe80::e620:d653:8268:5542]) by MN2PR18MB2605.namprd18.prod.outlook.com
 ([fe80::e620:d653:8268:5542%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:17:11 +0000
From: PetarStepanvoic <axiado-2557@axiado.com>
To: xu.yang_2@nxp.com,
	stable@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com
Subject: Re: <subject of the mistaken mail>
Date: Tue, 16 Sep 2025 01:17:03 -0700
Message-Id: <20250916081703.255759-1-axiado-2557@axiado.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916073905.253979-1-axiado-2557@axiado.com>
References: <20250916073905.253979-1-axiado-2557@axiado.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To MN2PR18MB2605.namprd18.prod.outlook.com
 (2603:10b6:208:106::33)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR18MB2605:EE_|DM3PPF260D102EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be0e474-92ff-4891-661b-08ddf4f96f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjVhSlRRUEVBekVtUFA0bmdzUmtNaDJmMllDY1RXd3dVTE9JdVZqQ1FFMEhB?=
 =?utf-8?B?bGh1d1VXM2JuVk5CNHJvSmViY29MWHdURTg4djJIczdXcE9JSzhHL05EckxO?=
 =?utf-8?B?YTRWcDkrMnJKWW9IQTNvcWMvc0hQb3FMR3NCM1d3V1E5Uk1qREtxRVNJaldF?=
 =?utf-8?B?eEIxcmJEU3FJWGc0RzFwbEtWbUJ3NnRVRWRPQmJaRmNDMnNHMjRIOXI2d21i?=
 =?utf-8?B?UVdEbUJTSDhGNi9DRjZERlF5THIrM3ZkYW9aSUJseVkzZlBXcFhvWHRiZTM2?=
 =?utf-8?B?Tm5RbmtUTldMUldYemJWNk9NcmZFbis1VDFEVzM0NmNBTGV5d2VUNXcwZFVK?=
 =?utf-8?B?ekJKOXhuL2JkejVSaTFaZklrSjBCUmNES0VBcjVOQ0dzbHNQMC9SaEZLYzlz?=
 =?utf-8?B?dXhmMTZHTU5MZTRlaDlVQWkrRDlmd1ZxenFuV2NJSXFWUnZ0cDNFWVc2d2Q4?=
 =?utf-8?B?c3VMUTlQL0VFVDlBSDh5ZjFRb3cwUUd1NlB0UTI5MlphWWlRZUplMGVrQTFH?=
 =?utf-8?B?VG1mRDNNYm51b2ljT1FaN1h4OVhBMXhPZGFxdkxvQ1RLTjRvc0JobE5HVG9y?=
 =?utf-8?B?S01pYm1iODFMQ01aK3JKVW1RNHZVb0dwbFlkMEZYaS9idDdsL3FGVlB3dXMv?=
 =?utf-8?B?OTRRdkhZdEl4UEdtMVBMVjV1OFJ2Z2RCUVFodmRRdFJEa1NYZ1JPSnlyTmFQ?=
 =?utf-8?B?bFBrN2cxeExjMG4zdTVmUHo1aHhKL3BHMDBlQmdPaVdwZWdpWjY4VyswTzhr?=
 =?utf-8?B?SlNhNUJTY3Z6TWxhWmVDZFR4N1Yybk5TUmRsRitwcTB1RGNpK0NJbFFQOEhm?=
 =?utf-8?B?b0JlRGZ3UlBvb0diY0M4WjdhaXo2S3BROUkwcnZ0bUF0SlBJaXhFWmlVMXJU?=
 =?utf-8?B?NS9ncDhMdWVhQVNGajE1Q0FSdndvdGMreGFaZHlHRUZxY2xWcFpMbFljb1VC?=
 =?utf-8?B?WG1xaDBYT0krMHRlZ3BVN3lqMys5bFpvVytRTlVaZTJrQ3dnKzVNZzI1Z1ZR?=
 =?utf-8?B?L1NFU3Z5OVpCV2JWdmw2ME9ZVi9TZzJ2aDJGUzU0UUZMQ1ZuWVpHTG5XWmhy?=
 =?utf-8?B?b0g1SncxTU9BUG53U1FsTGpvR0hZcGhWVjJaNGxEOSsvREJySFJYOExqOW4x?=
 =?utf-8?B?TzdmYVR4dnlJT0xrQmNNUGVkTGlBV0NESmF4ZCtPVlJxL3ZCNy9kUHhVR3cz?=
 =?utf-8?B?YUx2dGRLYm5MK2ZhMEJLeHM4SGpiTlc0OHJIeW56QzJrZjZVOGt4c3RENWlY?=
 =?utf-8?B?aUpiWU5ra1VPajlabFFUQkVHK2lkNE90ODRURUJmdDhQUFloMzMzSjE5NCtz?=
 =?utf-8?B?OG9HU3FTMzByNU9CZGZkWCtHMGxlSEtEeVdLQjJiNHVUYjB4dmgvREc3WXZF?=
 =?utf-8?B?YUtZR3lyOURFR1hYUWpGMi9oaC9oV3ZqeloxaWlNYWJNTGY3Qm0xcHVkcVRW?=
 =?utf-8?B?Vk1TUFVuQ2lCV0k2OUhpb29OVURjV2VHbUZCbU9iSmNrMFpFM1pNb1hCVEJi?=
 =?utf-8?B?ajJEVXZOaUdLL1pQa2VYaTZsYldvN1VicDQ4bG9BVTZaVkYxMVhyYlJZclI3?=
 =?utf-8?B?TGlKRzZ5ZnNIVllTaDl3VUs1b2VTcUZKZmFyYnRzWHdSQTJ3VUVPMzVQUjhJ?=
 =?utf-8?B?T3BUSGNKdFNFU3Zmdk42Rlc5Ky9VcVQ4bTc0Vlk4bzl2UG55eWFZbFhVK21r?=
 =?utf-8?B?MFZRbjJZUDJzMkhFeTNuY3I5ZHpEQ2RWTXp4cHB4c05TcG9ibmRtUEsxS0w0?=
 =?utf-8?B?VXNLN2VoUE9IREVYMFdLeGZIZ2pENFhJZDl1TThab3NIWGY2aW5vRjVIQkRZ?=
 =?utf-8?B?TjZ0aUp5aitBMTFtby80RFdYNGx1b2plQUIwTHRJUGdmdStTTEdvUFFkbmNN?=
 =?utf-8?B?dVpISENQRFpxYWN1aDY5ZWdmL09rWVRiQThnNUN2TXhUYXdiWlpuMmtOd1dp?=
 =?utf-8?B?dkRINEk5bjE4N3hZN09GZmpoZTNUQWZCNVBTQW1HZ2MxODVNcEZQb2tINk5x?=
 =?utf-8?B?K2F1andZNnhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2605.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aStYTVI4NkhKbDRaUmNNMUxiM2FQaFhHOXBGc1RUS2xndjVtY0UwT0RVNVpx?=
 =?utf-8?B?VkdPNWFBS0plWlVtdkpqcGRLa0RWV0VRL1Nka2dZK0VvVEFXMk0wZzk2QkdF?=
 =?utf-8?B?ak1IUDdCNmtKaC9EbllHWUFSWFJTdllMOGk4dVFDZFFOaWd0ZUN0RHRjM3BT?=
 =?utf-8?B?ZXJIUTlvZHJwaG9lQTFmclVPdXFPLzNXdW5hNGVPSWIzYStrTnRKVHNhc1pM?=
 =?utf-8?B?R0JDZXpMSFlER3lURU9XRkM1ZlhJbHo4Ylh1QUk3d0ZBMEdGelJDTVY2RkRj?=
 =?utf-8?B?RG1sNDJpa0FLd25NdlFQMnI2VURBYTg5SjF0eWgxdGZoZVBqQ0JPeDRUdVp1?=
 =?utf-8?B?a01lTXpXb3BrTk5kR3d3THVSK1htOVVHMytaM0ZoZ1hYN1UwWVdrbE9BYTRq?=
 =?utf-8?B?c3Y0b0RDd2kzYUN4Q1FLekJsa0NmWG91VUlpTnQ4bHRMOHdLV1RUWDlUM251?=
 =?utf-8?B?RzB2TytRYmJTOWVIZkQrQUwrTXlvNElBSGxFN2Iyc0xNRnpxbWpwcHR0cGdR?=
 =?utf-8?B?UGZGU1lMT3NCbFIxS2dmblh5Rzc5UkxuWGVnRDBMdW9BWFc4dGNrRWd5RE1X?=
 =?utf-8?B?N1QzWU5WSDcvcE5aRGdETk8yV0o5SS9YOC9zVDlhYit3VVZPMFR4K2RzZEJW?=
 =?utf-8?B?bkNVYTN6aTdlVFJCZFNjbmROdUVtSjZBMEE1cUJ6NDA4bGppVnlhU1JhQ0dj?=
 =?utf-8?B?M01wQWNueHljSW8vdEpuODBIbHRiSDd5cURwNWxjTVJIN09WWDlZWjVuS0FL?=
 =?utf-8?B?TkRqWTY2RURQdlp4UytDVFp4dUFMU2Z5NHU2aFoybXQ4MnZ3QlFGaUxESWM5?=
 =?utf-8?B?VzBFTUdKa1BINWZ2cE1OQ2dKak5vVWZ0NjRhNmVLcHNkdkVCc3RpazVqY0dQ?=
 =?utf-8?B?TUtTYlhZOE8xeXlla3VUampUbURBSlNWZHlYbUhhRGtxY1ZZYXVCU1NUSHdX?=
 =?utf-8?B?anVDZElJWWxmYzJJWExORC9CdmZFRzNhcWp1ekRSVm9lVHdWVXYxOEk4UHFz?=
 =?utf-8?B?c3JnN1dIbUVuM0V1QmptWDF0dkU2VnB5MUhpNk9WdTYzcUNvS1FNTlBBZVRp?=
 =?utf-8?B?SlpJT0lpQ0ZOZEpOOHpxRUl4eGN5TVNmV3pEN0Z4VWRyeWptU1F0b054L05Q?=
 =?utf-8?B?czF6UExQME10b0Z2ejhwOHNLM2RvbXVzbHQvcVpHQW1GRVY0elJZK3Z4VFg3?=
 =?utf-8?B?aDRCKzlCb0lDMWxtRGY3NThkRlQySk9rdWt0bzRDVDJJMklwVWdsRkN2QXRi?=
 =?utf-8?B?d2JwSmlpclByeE81NGw4aU9UTFNudkxpbFJaQXZWMHllMnJuVFFid0VtL2w1?=
 =?utf-8?B?SmRuMnlqUm1Db0Z0M3BmSlhlenh0QkNNYSt6RlQ2THJ5K1NoTExZSDNaTkRj?=
 =?utf-8?B?b1ZkVzF4ZmRBVGxFSlU0RkIzZDVoQXNLMUpyOFlwWnhuaExoeWdaRCtoak01?=
 =?utf-8?B?ZWNBZVlLU0huL3Jrckh3N0V2aU40WkptOGhoRjJJdk5lcjdrYW10SFdZbm9X?=
 =?utf-8?B?UmRicDcrdTR6QmZ0U1VDcG4rY2ZIWTNYYWY2VjQ0cmhhbGNZNGZkLzlKNE1G?=
 =?utf-8?B?K0ltbGwvcEtYZ09TeWJiL2RWUW5velp0OVIrdlB3SnBaOUl1TlMxYmNBNEZl?=
 =?utf-8?B?dlU5OWo0L2pyblEzYUFjZVlPbm0vcThBanlOazNqQm4yTkpVRlZFK3ZPS3kx?=
 =?utf-8?B?RW1hWnVkUnFRbzdzVmZPaURoZ1pGL0dycWpWUE4rbDJSYU9sQWRjcjY0Q1gz?=
 =?utf-8?B?YTBRR1FWdlAwckJac0h0S21hZlVvc09PeXByNVhWSEhhRi9WZHN3MFdES3RT?=
 =?utf-8?B?L3lZS1RxUy96V2dPaHJadGUxVFpxOVlNY3ZFVU01RmpFQjlNbEdkWEJaTmdP?=
 =?utf-8?B?V2VkMWRoNWcvWEpxQm9sNjlVcnBvWFB6enVxQklqcnovSEdVdFJnY1BnNjQ3?=
 =?utf-8?B?eGIvazR4bENzY3E5dFY3ODd0VzFhUzA1OS9nVGRKSWlWeEIwcUIyZWpxZFYv?=
 =?utf-8?B?QzZWV1lRSnN5dVFBZFFBRSt5Z3ZuN1E2aTRCNHlmWk8xSUk4d2N0b01PSGxt?=
 =?utf-8?B?d0t1bXlhRHlxdXRNdFM2ZWpSd1VvVWVMcm9RbjZMY1IrMGNjWVl5bjQ2SVpw?=
 =?utf-8?B?WXFSYUVhdEVTY3NHb1Z2VWRYUVAyVHpqTFVWdGNmTE8yUmhIQWRkaUZBNTRN?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0e474-92ff-4891-661b-08ddf4f96f3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB2605.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:17:11.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKKQsV20hQW0YZWVEktXKBBf+HohMJZ8i4wAB8gKKSHGfGi6WhcIpC3VGZeGdklrTB2ZzL4Ar/zp6SBu+vjhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF260D102EA

Apologies—previous mail was sent unintentionally. Please ignore; a corrected v2 follows.


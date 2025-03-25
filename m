Return-Path: <stable+bounces-126570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46EA7041E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8633BD62E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3542571CD;
	Tue, 25 Mar 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9KLtByF"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E0EC4;
	Tue, 25 Mar 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913802; cv=fail; b=f038Ch4pql6WbVuD/18T8V75Wr3rohGPMUgFfI3SxwngXKvyL+t1Oq7tL6rKA7DKixzk0LFxnXW0PBLX5ADR/OVatW2mQ4umhe2WQP54iNlDajSosjn15PN8YpplQf38WVWPOTsc4kWRNnXp1P4ZZpXy58yS2so3wWN7tx4k2e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913802; c=relaxed/simple;
	bh=eO+G57Nd+VErSjJEAz15WeTlagA97ACS/w+Tk5GznDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lErEecDrIU7AzOqGEMuPFGb2bUcLDiIjE6sDjb0emdtxMFO757vfBWKTVNe8Xu463GH7/+ace0fW6Qnq7YCG0cNTZmScW8NkIsYnNOID7RSh9BqH4H3vwDUaiYLefV+tuVPjl3xjeBff3d0r7cUvAqGrjOSMmbJMLJOd1E7mi8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d9KLtByF; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxRnDSixXAy31Npls5K41jmOlNVqBNmu0ex+Y/8NNAT4ZxYjNiSQezjaKZUjqpWle1/E1e4E67kJNTeyom95uLcJhC7VqTZB5ObPZZ+xiANSoj/ir4Q3VhLrJuGNLtRT0ahnSELgENW8T5MmK5SCjOtgWH3BKuyLV4MCcRXgrRrr0fSUhYPCfTFAeRrUnLmzj61wK6lX9SrIQsfSCHyhVVyxr0Gc4tZTmkZ4MlRILzBTQBvsw8X9bnRp9Od9XJPD4nKcyFPu1B8ttbTsa5dlqLl1ZDTgWkZUxcqwzBed9l0b2kT7ObCMcHwzRwomvCAQ6Txb7DiKqjmvjpKgUDMCSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqLieZararY2a89MGSOnnaZ+l6/L2B7Svm/AjzSn0MU=;
 b=Ee0rwVtZSIvNP90tJ7UAKyRXyaNKR6hjWiu5JpDlNzUGt33n3rxQkbwhkRcciuvYUkGbPAxYrk1ggJx75Z6wakCE2XtTF2h8V5ANN+RdqcEkeY2kYmyHxXFPObfF9Ut/hQEjintWFpfu4O/V0SPa9avqw55A8ZtAtAn0n7u2yucDymPaZFnQN/MWkcxWaquAwn/wjkAEZ2ZoUV11olZFRrmxSgqNq0+kIW2hRwvHcbnchHjRXcnPQDmcRH1ytE1ME0G58RlnCFykcZCG1UdCTwYf4Ez4/uOplFzMbouSNt0AzxOe1NysQ9wQG3kZ6fDM/ZLN22OlyGeMELVmRB8UBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqLieZararY2a89MGSOnnaZ+l6/L2B7Svm/AjzSn0MU=;
 b=d9KLtByFEfSWurVf/sIO+gc9+HDAnbjdxP7v883us5guz4w3jtW/Zzf8XYuAI1+wf7lW5wkO6YIdCu1zeQEdq7sYZwLndIBDJeZ40Ytkdsfk7a7d6lOBZ38BKsQDcHv0FNVWeCIt95h65mKHCMxg+NgHUg4XyRjAHhkAmqBuKao5fHVqNBSffutkSW/F0Fq1TPjpu5aSw8yx/oExhhDK6oj+drWSRpgtr0Vuj7yIZoA+c/ME1MFw4Ai/xHRxfezcF6OcSM2sXg889pgiyCRjTjsQG/N1E0BY6UWzbrEOkxRTj4l5aqZQ8y55U8cq73J4xG9Z6fPu7tazrYuj1SCKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9300.eurprd04.prod.outlook.com (2603:10a6:10:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:43:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:43:14 +0000
Date: Tue, 25 Mar 2025 10:43:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, bbrezillon@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	rvmanjumce@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v5] i3c: Fix read from unreadable memory at
 i3c_master_queue_ibi()
Message-ID: <Z+LA/GASTPMMcVpC@lizhi-Precision-Tower-5810>
References: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325102332.2435069-1-manjunatha.venkatesh@nxp.com>
X-ClientProxiedBy: PH7PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:510:174::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: a557149b-8307-447e-84b6-08dd6bab5fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzFJelNHT1J5U01kZlVNNnN6U044R0tGSkw2eFpOSml5NDRHMEpEVFNaZTN1?=
 =?utf-8?B?ZDlYNlRaVDdLdk91TXVsTGMrYjIwVWE1ZU5YYWpIQ3MwUlJHMjhNVkh1Ulho?=
 =?utf-8?B?RU9RbU1SMTNMaXF6Mms4a3h5Y0xPc1hWeUNXNHVza3B3VjZjT1pRbHFMQlZu?=
 =?utf-8?B?MXd6dzFQdi9zbHV2S3RaQmJZSG1rV2g3MEVMZEVTTlQweDhCUGV3MUtXb0c0?=
 =?utf-8?B?N0dPTU4zYlo2NS9hMWNGSm1wZHNUSDVWSEJRUTJaN0oxa1N1L1FiYmZHQmJH?=
 =?utf-8?B?UWFES0w2SGtkQVJadmRxVDRBMXFmZE9jVG9kTm1FUFFJNVRCZ2VVU2hJdE9v?=
 =?utf-8?B?OWpQSnNvQXJETE9vODFhVTJ3OVYrR1BtbmJTMTVVcXlZcnpxUStJZXNzVjhv?=
 =?utf-8?B?RHQrbHRjYzRXQUYzMkNBaEtUWVJSc215N3pIOUpvckt0R0RlMWxGRCtxM0Y5?=
 =?utf-8?B?b3NvNjJHM0dvNWlYenY0SEFRK3lEWWxKNk50SlQyMlBjOXVzdDFTRXJqeDJP?=
 =?utf-8?B?TFI3T28xVnAzeTFpNFFWOGkrenJSYkgwaEpKdTI2ZkswRXU4MUJFam1QUkJt?=
 =?utf-8?B?QUZLWk4wUnRySGZPelBzdXJBK0ppTGZ3b0tDRmZvUTk4S1ZnZFFwZFFLYW80?=
 =?utf-8?B?QVBMQ2Ezc0Y1aFB4N0I2TmJXV3JoamdYSlptQ0VIL3lMU2l1SGwxbFo0cmh0?=
 =?utf-8?B?Rm9NR25vNk9qaWh4Um8yS2NKQ0QrcDRQdGlYMXd3UHVSQjVKN2ltejM5cU5N?=
 =?utf-8?B?TmJBN3c4dVZ4NlhvVWwrbUJwYlJ1VlpGazJtb1JvUGhJTTBPTVZXWlh5SVdJ?=
 =?utf-8?B?UzJIWVRnVG5FMWFuZDMyQi93NnIzVWQyWWg2d1FoSzJZQ2RHcGNvN2F0Si92?=
 =?utf-8?B?U1RyRCtUWHJQNTlPbFFrdkplWnlBLzZZei9GdURjMXRxNWVESHVQcEticVd2?=
 =?utf-8?B?cTk1eGxWc1l3TG5HTlh6UHZiRkVOVEJWekRhenFRK2JOT1B0aHpYS0phaWgv?=
 =?utf-8?B?Vm9QbzltNzdCYUlJamJTQTRqUHk2WUxQMGJiYmZhUDlEZGNpYW9FWE9HWW5w?=
 =?utf-8?B?OVVrcVYxMnJraHRsYytOdnI4T2NibmlTOFh6V1VyZmpnejJ3enhLUG93VWww?=
 =?utf-8?B?Yi9KY0d2YTBNZGJzdWRTSkZLVDNWM2xBUlY5ZWNKL3gzYVFxRHhuVndVMnNO?=
 =?utf-8?B?UFFZOXNxT1VuS1JrTTVuUDJCUjJwMWgyYlg1Y1o1OVRDTXJJcHI3V3dZVXFU?=
 =?utf-8?B?Y2VCejh5dlhnTzZkcW0xcHd4VmdLS0lOdGNEdVVQckRCanlvVHB3dXFZdU00?=
 =?utf-8?B?TlZVaGlpM1pTSUZ3VXFDM3pCeG1xWXM1VHNDUkZ5MHR1T1ZaeVBSL3RCNG54?=
 =?utf-8?B?MHl2Q29FVktoVW1aRlA2R3FhWWFkTXB4YVFKc08xYnUwT2hTRW5PSkc4ZHN6?=
 =?utf-8?B?NXlVSzltYitKZjI2NTNqQjNBZm1TWUV4MlhUa2JMQmxGbGdlOXc2OGp6WnBF?=
 =?utf-8?B?TXE1bHFMcCtEN0lsREhDeUs2d2krL3cyV01vYzdtRndlRStYRUsyYVVHYVhP?=
 =?utf-8?B?WVB1Zk9tRENYK2xCRW40TEFaYk9FeHpDbnkrdlhPc0VMbGcxMzZIakNlcE5i?=
 =?utf-8?B?QzdjMllhVmlKSklGa0R3U1RSUHVFaHhvTDQvUDRucFdtS2RRYVh6c2UrbFJP?=
 =?utf-8?B?VVFFdWhQNjN1alhDYTZtSkMrYVFTZStZendYeWJ2QndNRHpKSkRWRStkV1lL?=
 =?utf-8?B?WlVSVWlsRXk0TEFYdUhWa3VZSGhBOVNuSHMwNkdqZmpFbS9kNmZkT0grUjhB?=
 =?utf-8?B?SjFqQmwxQjhFMlVuS0QxdG80c1F2NTllR0M2MVBIeGRBbVV0TCtUUFlPNlZq?=
 =?utf-8?B?WDRpRGxwRlR5RUxUcE9pYWllMWpLTEhyZjZLU1IrMmZ1SmpidEFYeUcwTnYv?=
 =?utf-8?Q?LIcJPHz4LukyYmHqGcaBESHpU49/rktN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXg0Q1BvVlZkOFlpem03S3FEYWdyWktrdmpKQndIamhwcnd0MWRlVXBJNFE0?=
 =?utf-8?B?SkxwZFdkdjVwbVNYOFBpQWtQM1FYR3B6N3FGanJzNWFKbG51NnY1bUd2em5K?=
 =?utf-8?B?WFVJMkFhaDhLY0VoTXhIeVI0aFd6RGd1SkIvUTkvcTcybTdCU0xONUVJc1VU?=
 =?utf-8?B?MnM4czhQS0NwYnI1eXlGd2FCRkR2NUF5RWxUUm9MMElvUzZQdWRMaGxOeVRz?=
 =?utf-8?B?d3IzNjdqRnA3dHhwdmtaaG5pREUyQUlpNTFNRkxEaW9IVEU1bnZ0bTNMY08y?=
 =?utf-8?B?OVN4alJ2ei9iY3lzZjVsR1FxeG9pc2cxNzhEZkFGSjNKRE9ldVZSTjZBeWJR?=
 =?utf-8?B?ZmpGbitCcGJJbXBsU2krblZraXRGeXJ6NDF3TkdHMU42UmY5b0ZuRzNHZkEy?=
 =?utf-8?B?b2lVMlFoWHZ5Q2dWQUM1U1A5UjdQN2VFcUxLZTRNYUJEb3h5QUQ1aytKVXFy?=
 =?utf-8?B?RVQ5cW5jSGhHMVlOR09EVit3ZHhQc0ZkbFBEbHJpeEk1Q0ZYWGhkaDFTeGF3?=
 =?utf-8?B?ODhVLzVWYTMrTW9jY0FmWk5TNDIxNDlCUEJER3U1dDJhWU9ZUTRzVW5yZXdQ?=
 =?utf-8?B?MDZ3RXVxWkM5QS9aQzQydFBUQkpsMStqeFlRQUwrUDYwQ3lXcVhOT3RPblJj?=
 =?utf-8?B?MXZIR09IeE9qdmtnUlZJdk9yd1NvQ0srQ0ZGMklyRzFsUEVVRmhESFBqQzZq?=
 =?utf-8?B?dWJMcGxTb0I3cWpwa05qMnVaRUpzWmpxWlBYVVBFaFZHamJWRGlMT1J3ZkVG?=
 =?utf-8?B?RDY5dXJ1bCswTVZUV0F2am1EMmZQZ3RXSkFCK29NUXBlMXg5a3U0VzFZMWpR?=
 =?utf-8?B?Rms5cGN5M3FBRlBYeFpQVk1ObUlUYTRLWlhNeGh1QUhpMVBHajlWdjBYbnlU?=
 =?utf-8?B?TmJDSUdPKzNBZm9yYWpmSzFVenplY2ZSSTVqUGFrOFBzb0QvQWFZM1lQaDZ3?=
 =?utf-8?B?czUzeURwZkY3Rmo3WEtJZVNyVFg1TUhrcGhqMVEycFlVRmhsa2RuYTFJVkxQ?=
 =?utf-8?B?N2hYbWNMajQwU2xkMW1WTVFsNG90TGVRRGZHV3lFM0pqTzQ5NDhkdXJNVWg4?=
 =?utf-8?B?ODEzd3ZQdnBLdDZ5UXBUZlBBSnRNR21tcWFCS2JpMjl2MXJLbDlnWFJ0TlpI?=
 =?utf-8?B?Z24yZ3R5cGE2WU4xRkpjYTFCWWFzUW43NlJiVHNkSHZLc3VoMXNMS1hTMDh2?=
 =?utf-8?B?Z3JCNHV2R1htSnZmRTFEODZlRHNVa2lNYkZEbUp1Y2d6N1ZLY0FNU0EzTjVs?=
 =?utf-8?B?QUdhL0FudGkrejcycDBYRGxFMGVzU0ExNUEvUG52UzlBeVMxZDMzWjhjdUxY?=
 =?utf-8?B?eGFyOGlralJBNmJPUklQNm94Zk5aeHU2UTU1K2M1a1BjeDRqT0lVMVFwUFZV?=
 =?utf-8?B?TjhPd3dNZEQ0THhvV2RxUThwYmJpMWc3VWhtQTJDM1ZEbXJudlk5MWpCRkxn?=
 =?utf-8?B?QWFKa1ZsYU93MmZieEM5UzdXT1BrazlYeURJZk9RajR1MzVYOUZlRHBsVjhS?=
 =?utf-8?B?TUpWQzRST29NNmQ5WnA1eWs3VGUwa2ViYVY2OE9zWlppTHlvUjZPNnhLUXlC?=
 =?utf-8?B?ZkRQM1l3MmpFeGFrRkJFb0kxMktJNENBZ0JPSU9qaHRmN0wvVlJ4MzdOZ1Ru?=
 =?utf-8?B?K2xaRUVpVmg2ZTljd2ozUW02d2xnODhCUHR2cjZ6WDFCK2puTlpsL0JUWUpY?=
 =?utf-8?B?bm95UlFBMStNUjN1M2ZTTnp1LzlEUjR5OFRLY1pQbTdXbXNibm5Wd3dQMmFm?=
 =?utf-8?B?cERlMDltejZWUHpZclRxQ0RjN0Rnd0dFNllpN0MwYlN0U0ZtN0pvSmdSOGpT?=
 =?utf-8?B?NWsrcDk1eCt3cDVucSt2M2tobElKa2E0ODE1VTBTNkY5WDM3RlM2OXp6WTRn?=
 =?utf-8?B?dlR2aDE3eG83dGV6dGJOV3YycUpwaVdESThKaUtGbWd6cmdjTGVtSDg5eXF5?=
 =?utf-8?B?MmU5U05wWCtFdzEzYld6K1FSM2psbVc0TmZPWWh3dWlrbXhScjVETlhBYjQx?=
 =?utf-8?B?TEpIZGQ1NEFqTGJ0U3JvMXZYQWJ5amJNdEtPUUJta0xSbE5rRDlQTGhXalhx?=
 =?utf-8?B?ZXM4blh4Y1ZldDg3dVdKZUEzTElIb0UvOHArOUtBQkNqS2FVNWltYUpMZXRk?=
 =?utf-8?Q?KWYfRfmvwKFCyW/l+qH2YiJtg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a557149b-8307-447e-84b6-08dd6bab5fb0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:43:14.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9opJ5ZgYyW4NN/fgy3+qNq/kyzANsHw2pml7uumBRXHSAZfyaaAIyC5dqTfNPwfNPXZxONeF2A7YXhcdTdLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9300

Subject should be

i3c: Add NULL pointer check in i3c_master_queue_ibi()

On Tue, Mar 25, 2025 at 03:53:32PM +0530, Manjunatha Venkatesh wrote:
> As part of I3C driver probing sequence for particular device instance,
> While adding to queue it is trying to access ibi variable of dev which is
> not yet initialized causing "Unable to handle kernel read from unreadable
> memory" resulting in kernel panic.
>
> Below is the sequence where this issue happened.
> 1. During boot up sequence IBI is received at host  from the slave device
>    before requesting for IBI, Usually will request IBI by calling
>    i3c_device_request_ibi() during probe of slave driver.
> 2. Since master code trying to access IBI Variable for the particular
>    device instance before actually it initialized by slave driver,
>    due to this randomly accessing the address and causing kernel panic.
> 3. i3c_device_request_ibi() function invoked by the slave driver where
>    dev->ibi = ibi; assigned as part of function call
>    i3c_dev_request_ibi_locked().
> 4. But when IBI request sent by slave device, master code  trying to access
>    this variable before its initialized due to this race condition
>    situation kernel panic happened.

How about commit message as:

The I3C master driver may receive an IBI from a target device that has not
been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
to queue an IBI work task, leading to "Unable to handle kernel read from
unreadable memory" and resulting in a kernel panic.

Typical IBI handling flow:
1. The I3C master scans target devices and probes their respective drivers.
2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
   and assigns `dev->ibi = ibi`.
3. The I3C master receives an IBI from the target device and calls
   `i3c_master_queue_ibi()` to queue the target device driver’s IBI handler
   task.

However, since target device events are asynchronous to the I3C probe
sequence, step 3 may occur before step 2, causing `dev->ibi` to be `NULL`,
leading to a kernel panic.

Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent accessing
an uninitialized `dev->ibi`, ensuring stability.

>
> Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---
> Changes since v4:
>   - Fix added at generic places master.c which is applicable for all platforms
>
>  drivers/i3c/master.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d5dc4180afbc..c65006aa0684 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2561,6 +2561,9 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
>   */
>  void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
>  {
> +	if (!dev->ibi || !slot)
> +		return;
> +
>  	atomic_inc(&dev->ibi->pending_ibis);
>  	queue_work(dev->ibi->wq, &slot->work);
>  }
> --
> 2.46.1
>


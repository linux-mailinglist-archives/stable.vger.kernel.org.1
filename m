Return-Path: <stable+bounces-126796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D96BA71FDB
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E011899D72
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678524EF97;
	Wed, 26 Mar 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PMnRfrbZ"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7101CD1F;
	Wed, 26 Mar 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019582; cv=fail; b=VEDgPtjNWmb2Bs3DQeSxZ8M64KF7sjotIa9NH/eI4rveJ+umjQ0XDTyX6XeJbqa8t190uY4rkrIGgnkQaHnl2iNV66BaX6vPk0GSgtz5QupmT0mUeaoFxxRm/btL5YlOQW0btbf69hCRtlfnwaNg3uLhoXq/hCZzlrRGzOAOEJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019582; c=relaxed/simple;
	bh=fErX9VVD0mNJ2ajDzHCWTmZGDJi+81N5nGFepC6exyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=idVmntH4ykS6pqu0hK7xDAaIgu432BL47KVB9unk+7eh1RIqSKRD5WAwdCbPG+h7Us2unwg+fnyE9x87AQKnHgPH3dgwRuEAwnpgNn80NalHNluDTTHHe8IUKRt9Xw7OGIlYWo3a5NDNFxplJtvPyfNXSV2HkoIrwVGAFgCtrrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PMnRfrbZ; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEZhR2ZXKd20SfvB4T0FZWVpYgIsoJzIrWPJXYuQjcHBwwcqZODGHXNDUx2JepNk0wDwFHQ5bBOkvkSbc7f+M7nI+eLStthpkSGu74/8E3vJ2ShpCFmquFD2ma/EI08tLfTF3jihbPrcNaFY641asxZl7Foh6AWZJCvMDVKC3ZiBB5LgrGBV1VBitsPV5qXlfNz0G/4mjJz1Lu9hW/RAMeNF27qVhehCcgJeAgwR2bmrcbTlP1DPbaPkpwmLvC/kJsBDk7Ce4/MR6Bs6nYLU76qBq/nif3bvRcnv/+PavmWmDlYWYARxh5n5kHCeMBl1cUq3N9nmQF4LmxrX5BdhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NJu2IVfhhSc18koQvK1JOq2ZD+SvJ29r0KrZGVBvFE=;
 b=R3RKtg9aq45nXiFdrtm8u8Uyoez2WNOAewUY1eJtvdKhSEycNxKXZSW++uix0xfWDNSEUw4Tti3LlPk8FJOCzSQ6OUPAt9gZJFYNyBtKCvTI937C966SuAwoKJvUNsWgUjjzHd4JtRcHpntN5Moi2a9ojfYQDd3KT/Xl7Dch1+5hFYbwJ+ZULZR/fWOoieaHGVTxRur7LY9FlMa63EZVSKvXLzSa0UZu39dmHcAgVcDjHwHZQU/NjJ2kSGJMwUzERkarVrssNWTgcOXmLXP2AuvcR1H6QGMzQdNB0TkELWkWADpZjDRPrQxQGoQlKDbJDHSLfvr8IvPhgGxZsXokaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NJu2IVfhhSc18koQvK1JOq2ZD+SvJ29r0KrZGVBvFE=;
 b=PMnRfrbZb5YaQsSMM6CvV6PCKX1kFwQxSe856BIVr7DzkPTEOil+3Xkh6I5GFO1VagkgBw28KN7v+rGMgHBeIeGnHZud6tgQkF53SRH4bqGM7VKPQzcY5SqdXrCSerpPA0Slf75YMsrxIJxknD+RJDhqe0RSsJg776RNFy5YFL967Mz5KN7r8/kmrpil7Y7XhMHHX3xa2OnbJQ/nHKelTlJ3UAJbYL19zx4sLOzS0UND54ul2qgF0X1HN77Frc8M07zXZXYRdb9ohRVvcoeCZ0GbG5zoF3t7q/sikuLJ0rbbcPsv/LXXYx9qROAAp0jSO7sjsCMpupsUa7Q9+22V9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 20:06:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 20:06:18 +0000
Date: Wed, 26 Mar 2025 16:06:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, bbrezillon@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	rvmanjumce@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] i3c: Add NULL pointer check in i3c_master_queue_ibi()
Message-ID: <Z+ReM0MYKuIz06De@lizhi-Precision-Tower-5810>
References: <20250326123047.2797946-1-manjunatha.venkatesh@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326123047.2797946-1-manjunatha.venkatesh@nxp.com>
X-ClientProxiedBy: PH7PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:510:339::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: d349a8b7-1365-4221-764f-08dd6ca1ab59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3B4cFZKa3loTmZHdHFRSlB3RDExZk9SdnRhM2ZEN2RibHNnL01yRmI4UVVa?=
 =?utf-8?B?elpEbnovSTU1YjJIeWlkRDdFdTd0TitMSWxGdmMwZ05MUE5xdEdRZ1Z3N1ND?=
 =?utf-8?B?TzVNWlc2VVcybksvc3RNS0hUZnZDa1FvU25qc1c5bEdnd3JlYnZqN3BjWGc5?=
 =?utf-8?B?TUNWQ1hxM0lqR0hQNGVQMHhqa0lRdk1yanpaV1drTkg1TGo5d09hNkp4bGRu?=
 =?utf-8?B?ZlRhTGY4azR5U1ZYV1N2UjJiUjBFdS8rK0VMQkkxK2J3TGo5SUlBemNuMmJW?=
 =?utf-8?B?dkdyeXRoUSszKzdzbEFXNm9IVGFPOWNsdEpOR3l0bm1vVUpaZ2ZaWW9VV0sz?=
 =?utf-8?B?enBUaDY4djVReFk1R3lRUVpKZW5PYXc3aFpSUU1samFqOUw4eUFGaGFrREYy?=
 =?utf-8?B?OGdieVFoaW9rd2EwQjdPa0hZWCt4dlZEcmdEaUYxZ2xNN1BlQlk0SjRtZHk2?=
 =?utf-8?B?Q1MrQjdoRUQ5a1JTMFBQSWNFRW1GMGQxdGordEpDRWFCTm9BdURrVE5TRnBP?=
 =?utf-8?B?eERSLzNJclN1Q0szUW1FTUd3QzFsSUQ5aHdHNzlBRVBLa1lXaDROQnYyOWE3?=
 =?utf-8?B?YUFnMlFRQXVkSmRTdEg4c2t1YTFRREZUdGh1TzIzOFRzY0lGWllMR05SSFNL?=
 =?utf-8?B?WXF0eWQvbGRHSVpjZkkvWGdXTHVYTXpPRGRRNGhpY29ZeUkrcVJCYzJvK054?=
 =?utf-8?B?UzFIQzIreVpvKzdqMU5nVW84OENJdVJsa20wY3JLbU9LRTFVWC96WG9SdFZ6?=
 =?utf-8?B?MzNaMCtudVFvdTFSbEdvN0Vnc2dwNW4ybnNhemRmN1g5S2gxcmhpdVRuWmZy?=
 =?utf-8?B?VnNDelkzVW9sOW43ZFhKbnQvZzRsYzNGRU05N2VrckFIeDMvbWhuZURxRUpZ?=
 =?utf-8?B?NjVqZCtFLzlCUk0wTzl2eGlxYkNPanlqeWwwZFNQNmEyaWhVSDRXYXNJSHh2?=
 =?utf-8?B?a2htZXhhb0xld0RTRklpRXlVTk5HdUJsRkd1WkZYMjUwZEl1MDVnVnNLdWNE?=
 =?utf-8?B?WThUeUJ6ZWhRZ3cxZkhITFQzRzl6Rnk0cWc4Yi96VHhGdkFuVjcyNUEyOUNy?=
 =?utf-8?B?KzdDeEZVOFZZNzVUd1htYXo2cW9HbjNDUlU0eVhJeGIyVm9pOHVwQ2J5Y3Bu?=
 =?utf-8?B?Qy9kWmo1N00xcVNhSFZWb0I3bDBmMlQ5N0toa0RSUFdzcnh3blkyUGs2Rm9C?=
 =?utf-8?B?OXBlSzdpTDVkV2ZGbmlaMmR4UFQwTGZFVnVwVjY1TnUvUTI0aVFiQXJudkIw?=
 =?utf-8?B?dnNCMlJOeXRsb0N2TEo1SGV0SUJHMkVwWnhBSWRnQVladGZzOWwzMmVVWEJl?=
 =?utf-8?B?N3ZKT0p5WjZPdjdZaUVjcEZDNExSejFCUG5vWkcxOFNrZ0wycVlXeHVrd0I4?=
 =?utf-8?B?MXErcE5CMDdpQXZndXdxNjd4Z2Zmamp3ZCs2WUtlNHA1MVBySmVPNHlacHY2?=
 =?utf-8?B?Ymx1NVdWaCs5cGpLWHVQcnBoZ2kxaDMvU0ptUHpvTkljTXhua1ZnRE5IWi9G?=
 =?utf-8?B?ekt4dngrOUhhbTMwNzJGd3h2SXRIODNWRDVsMk9nU0hOaElGM2FTUWJUOHJh?=
 =?utf-8?B?eVk2bUM3K0JNbDhGb1BEV0xXSWFMZkhUOE9RVWJKdVJRNCtsVktteTdUUTk3?=
 =?utf-8?B?bnArU0d4bzQzZTdpaEZsK08zaDZCT2tDZ2ZkaDdHY25hc2xTSGd1ajdxT0Ri?=
 =?utf-8?B?bEZhck5LUHFodVZDV25jRy9yQ0hldStxSmVJZ2I3ZHJWaVhRM0ZCTGl5b2M5?=
 =?utf-8?B?SFdMc3dCQlRINmM3NHFGZjVNNndyVWZXV1JGSHNNWDhUZS9rVEUyYlI1Nnhq?=
 =?utf-8?B?WFBIcE1LaWEwS1J4cU9pSnZTMm1MMFM4Ty9EVVJGTFdvWU5BNGNCYmpKRXpt?=
 =?utf-8?B?NFBjS0tvWlVNbURnYXJycWlBOHNJNkJLM0ZyMWZPU01VTWpRRUFZZWZYdUpW?=
 =?utf-8?Q?7MbE9t/cEYrQqDn72k872Pblof6vM9wR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXRUT3N5NlJSWnlkZVZTVCtwSmxYRm14Ym1LNTF3RFZzVXEybitGamdNSUxV?=
 =?utf-8?B?cjdJMng3cG1TMXhvRk0raGZtZ3VRdmdlTW41cFBtdjMzY1gxK0VLK24yRTRE?=
 =?utf-8?B?N1lTd0ZYWjBkNGkxZTBLcEZjcE1BcEgxaFA5ZFpWb1ZJVWZPcmZnajdQQk9J?=
 =?utf-8?B?NGZ0S1h3SFBvUW5meGZ1bmlxSUNnNm9HWGJSYXJ5R25SZkZJRTdoalh5eWhU?=
 =?utf-8?B?OVNsQlVMN01tL1hnWFdhYW5WNmMvZWptbTB2NjZZMy96U1lQUCtscEtvTGoy?=
 =?utf-8?B?ZExESENnbWVCS3BLSGJEWW5YRlRMdFZ4L242ZGtmd3pSVE51SDRYV0JUWGti?=
 =?utf-8?B?eXN0RG1DNUJ6OUROclJrYnl5ZmRoWnRBWC93TWswdG5nYmJGZ3N6a3ViUytS?=
 =?utf-8?B?ZW1pTjNMVE5pZ1pyNHhiL3JNQjRCT296c04wUWxzbjF6ZGRGZWk0dEt3TVo5?=
 =?utf-8?B?RTExTDNKbFp5RStZYjQ2WWR5elp1TEQrUksxd1o2aE15QW1DL0Q4dUQzYUMx?=
 =?utf-8?B?S2w3Tlp6SmdBbUtnSWpmc1ZKRyt4V2Uya3Vualhtb3RQc3VJdzBjbDRJTnhY?=
 =?utf-8?B?M1ZhdTE3cjBNWjkxQ2xCVkIwQWJKUm9lRHpyRkFIK1dZenk1YjVraWlGQi84?=
 =?utf-8?B?eWJoY2tlTnNzZ0JTQit3cHcrUEhUZ3pJUktmQ2E1NjNCdlNnK290Vm9Dd201?=
 =?utf-8?B?MGtCN2FncFJiV21saHJHczJJaUczTWhJNm5qOXQ0enM4V2hNUDBPQ1l4cCs2?=
 =?utf-8?B?RUN6VmhPZzBNUVVEdlVzLzJFZDRtUWVFZklYMFh0V2RVWmM2dEdOS2plbVph?=
 =?utf-8?B?YmRlam1tTW84Mi8zTGtJWmZIUlpyL3dQc29uOWNjb2E1MHl0ZWRCZHEyRUp1?=
 =?utf-8?B?cXNlZCsxUisxc0xnWmhmVnFibEYySU0wQlJIaFJxOWkwTHEySlh3Z1c2NFFs?=
 =?utf-8?B?S1Vxa3RwdlVnZm95dWVyMkpJVU5qbmdLSU5BaWJ1UnlseWVGRk9BemlOblFX?=
 =?utf-8?B?aDBEbEl4bjFQRzE1a2NJOGdBQU5mMFc5MUxEeWxNQS96d3lxb2FJUjkrcDQ4?=
 =?utf-8?B?cTIwU00zTi9ndUVCUWRiM1dmMkxzc2pkajh0NEFkQUNtVWd2SU1TWXRCY3VR?=
 =?utf-8?B?TDFSK2tjWTdqRVhZVmNDWDRNTmd4eGNwaHJHYmRqbEJTaDlRY1RNZ2J5U2tP?=
 =?utf-8?B?U2RuNStUTk1YKzd4T3UzcjZKUDFWc3ZDckM4azQ1b2xxdlAvL1lLRDFrRXBU?=
 =?utf-8?B?YkgvZHQ3ZVF4RWw4bUgwYUJyeURlbHduaU9WcjJnN2Ewb2NpSDZNT0ZzQTRn?=
 =?utf-8?B?VXJVR1pieXdZQm54K3VadGNObXZGSlVNbDdDTGtRTk9lcTJLTHllNG1HTVE3?=
 =?utf-8?B?UnRNYkttUk9VL3lCN3JVZnhFTnRxOXhQaW1DZG4rMzk3SVc5c0NERlgxZFlq?=
 =?utf-8?B?YnMzY0JsNjlUMWRWTWl2c0VUbEp2dDBpMWpsOEY3aHBpaHg3b1hWMFNQbDF0?=
 =?utf-8?B?OUZqUHlwSGZCTk5TNXNnSlVib1cwNDNTZ1Vwb0FsT0dyaTNKODdFcVZHL1la?=
 =?utf-8?B?RjEvTXg0bldrV3lpUjh4cHJjWEdjNWw1SlJ0VHZLZithYVdkbFhDV1JzTXNX?=
 =?utf-8?B?a0tFVVk3VWFtMVhPcXJNaU9tejdLUFhjenNZaDNMaENDK09aOElVbzcwdG9M?=
 =?utf-8?B?eE8vWjlNbU55MUtyd3BiWGVyTE5VazZrVURUdU1XTzlVOUFVL2ZjWFp3Q3VG?=
 =?utf-8?B?dm5OTnZTcGVkOTVZNEtSb3dSL0FPYWpHSWpyUnFWTWRkNHVVeEd6OXI4Z3lr?=
 =?utf-8?B?ZXNlUmdudXloYWRTTUx1ckxhc1lVMVBuOEViOGluSGRpdkZyZm1oY29iWGla?=
 =?utf-8?B?UEFoUnI4RllEdnJHeXdZT3duS2lRblBRTzZVWmU1TDZxRmpzRmFMNStnRWIw?=
 =?utf-8?B?MUFSSDJHc3dhd2cxWCtPRGdIS1QyNlhYSGY0WDRzQTM2S21NZlE1L0NhWE1t?=
 =?utf-8?B?aDNxbHdoaGU0Z0JlaEd2VUxxRFZDWDcrQ21UWFRPKzFWU1QwTFdXODhOUFAz?=
 =?utf-8?B?OHZwa0h2dFJoTURCVW5UN0hDVkFJdEJ5cDB2MlBmMUt0WGpiODVTeEg5TEFo?=
 =?utf-8?Q?G9/hW99YvWEyHHaaavsiqOmng?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d349a8b7-1365-4221-764f-08dd6ca1ab59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 20:06:17.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKdNkwbZHhwiCYa6q3mYo2egif8BMd5TG70LYYPgjnkN3JORe/1kwx2YgcMrZ0khLPCrCNR5K+6sPO3Ryu53Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079

On Wed, Mar 26, 2025 at 06:00:46PM +0530, Manjunatha Venkatesh wrote:
> The I3C master driver may receive an IBI from a target device that has not
> been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
> to queue an IBI work task, leading to "Unable to handle kernel read from
> unreadable memory" and resulting in a kernel panic.
>
> Typical IBI handling flow:
> 1. The I3C master scans target devices and probes their respective drivers.
> 2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
>    and assigns `dev->ibi = ibi`.
> 3. The I3C master receives an IBI from the target device and calls
>    `i3c_master_queue_ibi()` to queue the target device driver’s IBI
>    handler task.
>
> However, since target device events are asynchronous to the I3C probe
> sequence, step 3 may occur before step 2, causing `dev->ibi` to be `NULL`,
> leading to a kernel panic.
>
> Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent accessing
> an uninitialized `dev->ibi`, ensuring stability.
>
> Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
> Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes since v5:
>   - Updated subject and commit message  with some more information.
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


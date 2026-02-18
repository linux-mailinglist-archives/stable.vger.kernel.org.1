Return-Path: <stable+bounces-217217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DEByFjNglWnVPwIAu9opvQ
	(envelope-from <stable+bounces-217217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 07:46:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA2D1537E8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 07:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82D72301E7E0
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 06:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8233081D2;
	Wed, 18 Feb 2026 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AoRI8eul"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625C1A9FB0;
	Wed, 18 Feb 2026 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397168; cv=fail; b=Q4uLO17RJGPLszKKLEFX2o/m8vkl0RNeCSvpRUzhlbnF5osINqKQFR3RMgXe6/lQp2ayGi60CPLwApp4rI3ODmJnbufshdnd3dmGeWXLjgxD1AQAIXc93QV0PBahq3EXg3JyiBcnMXKehfCXQRfY8cU+QHh9wLVQumSnEozYUhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397168; c=relaxed/simple;
	bh=GsFuW04w+oI6M7HaB0wKRn/0ceakXijCm6aUVLqqI8Q=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=rGJPInZr1dsDa1g+Fe6pLKS7SpNm3YRPScGY5QP0N12nHqo+LQO2S0w20rva/75DgY+GuZh5VHoYFRQTr4sqjsJ/8IWLsuZusSN+JCAPPElSFcOczpnRsPVJtFNWOFrnXT0S3mMkq4mPrJLqwklgjlf7vhMlqHvAxd4Aia/VvJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AoRI8eul; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix+3GAsoVziOM9vxcQYr79K+as5Go238RVKxJVmwjKbMpUJ1rxWQp/yC0grk98A2mSnc+ZLbgObeIDdLSvmtbIISGEZPFKS1bfJucqwp3QkHTPJGPfKoOxAjsmwat7CGfyPArOBkoAQ0nbs6kl9VChDk9UZiRI46bw6tIA/IWNYwP5/l3rjJ40tJU2v8V4H1gVGtVYQJN8U2cwQEm7YAahyueCV1g2zVuWxa1VLaLNdcM9AdCy9P3biz6hB3xYxEIQFU1ICHt9zuU6ZUxpZV+skIbVm4VgKJU1+L2v2pWoxuMAQA+1m4pY7LBa4DKg3HvnmZkfoUVGF9kxnA0BBuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl1qgNLvbt4/zxXKmYcubGdFlExZV9MNrFK8BZsOJVM=;
 b=IGLWlF24S3+cBrYISyxH+Pb/eWmGFilTTxSdXPNbWDLfmb8i3V8HXoC4y9BIeza6w3jT4nNPCFC3XIINwg5jpYrAP36fI5N5+js85NGzThG5/6G+J9kXd5Lk7cfkQjHmG/PV9D8CK/4qBrx57irQ5M2g5ukStO1FSbhnCoty4pY2EOrFLru/SLCkpBzvOBAzmruLHRMyP82NEnDuMLFMdt4GbEXFLguRF2y6ZvyjsrIi98nbwgRtqtMoQRY/HiX1fFT51wmwpn84LodACtcLU1uu2fEXPDbghUq0VMymhFouupszzrPgyHdBk05gBNIJJhX8ryxY+kNmMVMJ3vjfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl1qgNLvbt4/zxXKmYcubGdFlExZV9MNrFK8BZsOJVM=;
 b=AoRI8eulkKs9ok6u7r/5xN2K0mqJvjJzEiY++/XcYfSovzFR5TJuyPw0XSbAUNrBjYD3k7XGo2x2r+IfqdyDBQjVNQNu8xgwprB0h6eInrzWEukrDo+522TQuWmNDKDublmmFTHyx15CT+wOjaH/YdQucFqvLWvjwiRXADj8mm+RZmRzVlsUS13AxqiDW6jebuWPlDchzzgfQeeTanvXGV8DVJsY5mGXGxNEVqdAD7h1NpQtbAmyVl3+d1AR4w6fXEp/iW4hXZHUpS5RakMMn/H4EvUp7AtAIMBWUFOmswoupz1yRGlXcndOy1MMb1U1TGGe64uk3Qi4l1+mN2Hhqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Wed, 18 Feb
 2026 06:46:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 06:46:03 +0000
Message-ID: <05ae6b87-0b53-4948-a1ed-2a3235a5f82b@siemens.com>
Date: Wed, 18 Feb 2026 07:45:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.1, 5.15, 5.10] net: Handle napi_schedule() calls from
 non-interrupt
Content-Language: en-US
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Jakub Kicinski <kuba@kernel.org>,
 Francois Romieu <romieu@fr.zoreil.com>, Breno Leitao <leitao@debian.org>,
 Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>,
 davem@davemloft.net, pabeni@redhat.com, kuniyu@amazon.com,
 bigeasy@linutronix.de, jdamato@fastly.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: a0abb498-8949-408c-03d6-08de6eb96218
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXkyUHdEWkQ1VG5lZXl1TFdTN1FMeFh0M2hUekVMV3BtQUY1eE1Xa1FmanJl?=
 =?utf-8?B?cVJWSzFRUThQMm5DMndJOXEyYzlZdWk1K3ZBVVNFSyt3eTdBa09yWHI3TVlw?=
 =?utf-8?B?ZjNJQnpCRFRVbUlsd1I4cm5CUEZLWS9objN0ejdxUXBjUENpNjZjSFBFRWZk?=
 =?utf-8?B?SWQ0bTFod2YwL0VyMzZ5dGRZcmxqV1JyQ3J3eGFuUy9TaDJQYjd4b1RWa2pO?=
 =?utf-8?B?bnNmMFU4QlFBbTYzOGVKWStOZDlPSXl2c3pDQzhha1BQOW9GWDBFL1lGSUxF?=
 =?utf-8?B?NTE5bXBUYVc5TEVMM244WUx1Z3kyQm8zSFB6ZWNmZ0NGdWJUTDk5OEhZM2R5?=
 =?utf-8?B?aS9aRjh2b3FrNW9sZkxNd3VNemJ6clRHRlAwdHhReFQraCtDQk9kWmFEem1T?=
 =?utf-8?B?R1NtTVk0ZmZXczdYcXdMVE1IVTJzTG9Pd2tLTWtPNUpQSjlZN3h4ZXMzbVMx?=
 =?utf-8?B?YlROY0NVZVJlOVFVZ1NPbVVPdWI0cWkraVlENC8ySzhURjZqaituS243dDRN?=
 =?utf-8?B?VWUrY1VIdHF3d0JCZ2pnMElWQVFpcGFPUHo1N25iWVJhWGZFM1FMQjRVUlFE?=
 =?utf-8?B?WHo5bmxVQlE1ODBJbTZKTWlTTDc0VVZoL0w3c1hkVnRjcGVrZWR2UTluWlJL?=
 =?utf-8?B?em9OblZONkpRZnRNUFRha3VpVEcwWHpYL2N6VDFPeG5iYk5TbTBsK21UTmlT?=
 =?utf-8?B?KzBHYU5SL0xoOVZKZytubndtR3diNk5aUm1pOGRTS2tUSC9NRXUxV0tGcFZT?=
 =?utf-8?B?QzhPaVB3Zk5VWHFLQnFZZDJsMEhYMEJlOFlJSXpiWjdOTkMxcVg5aHo0QTlQ?=
 =?utf-8?B?cnpQYndCNEdDTFBDMWhLSzR5UVFNOTZUb0NWcHBtYytOOThyNDQ3SWpKbHNP?=
 =?utf-8?B?UzBVZmVrcFFrOHliVGpDc2wyQzMwSHZ3U083aVNaMzNuNmlCUDNZUFlNV1l1?=
 =?utf-8?B?Qm45ekdVbUhKZ0xtMU9Rd0NCQ2JDR1puRHVkb1liQjQ4NWpoR3d6MHpDUTZp?=
 =?utf-8?B?bjNCMFlxdGkvbmdMbThidDVYMmpUMEtaZ1RXdmFEZjcvZ1lIblNhb3ozR0pE?=
 =?utf-8?B?V1AxdytqOUYwRW1iZW1zOFB3SnNSKzU5UTNOQzI5eW5MUThyZUthckZwbHhG?=
 =?utf-8?B?ZUhBMlRueTljZmpjTkt3Tkt5blJVZTVZZ3ZicWwxSlJYU0taeUJZN2E5TWFS?=
 =?utf-8?B?YXdMY1lCQ3MrN244RWkrL094c2QxRHRLRXBwT29MUUxIR3E4SmxIVWNFOW9X?=
 =?utf-8?B?WGpLUFVFczdpS0k3NFRSWnJESFVjNFExbzVWYjFnOTh5UWRZbWxjWVBvR2pV?=
 =?utf-8?B?cko0VEdBWGkyRW1vMEZiK1k5Sk1TZ2NHeTJ3clVLMkZXTW92TlBpT2lraDZC?=
 =?utf-8?B?Z1pTcmsyV3ZXN3JPVkhmVUZMejh1MEVlR2F6WCsrQ3doaHF4NWl0NUY1Nkk5?=
 =?utf-8?B?UlpodlBNL012QjdzUDZiMnYxUUI1dFFaWUNMN01xUmpuY1BLNGN5NnhUSm5a?=
 =?utf-8?B?Q21FNlE2YmNzeHdLSzVXOXE2MytVajdFenE2YmIyeHhpWXAyT0hETytaU1cr?=
 =?utf-8?B?NG9Sb1E4MlRLcnBxMEVrMi9zNTBERU81Y3ZwRzZYRytFdzVFWlpLMDVLMkMy?=
 =?utf-8?B?dktwQldRc2JQTndNZ2ZUQlV2b1gxQnE1MENTK3hCVklQekVrUitabGJzcmZj?=
 =?utf-8?B?RTdIWkxKNEhpR01KUHczTGJoMzNZV2k1cWJmeWhUaFFsNituT3R4bVE2bU1H?=
 =?utf-8?B?ZWphZnVxN1RUY1N3NituZlFtSy9xOHJScmF1OWczUUdrcE9WTFVCejZnV2NC?=
 =?utf-8?B?ZktIditGTFlLRE9iNzdUTEl5T2o4ajFZSi9Wbzh4ODFGcXg2UzliaEx4Tlpp?=
 =?utf-8?B?dFlWeUphT2JPWW9yTkRTSFBJUjFFM3c0RjB4cXNsQVNBb1JzZVpDdFArTXBv?=
 =?utf-8?B?YTYvdzVtVzNUSVFTanZtN0dqTkhBeWdKam01NlBZT3lwTE1FS2tjM0FweG5J?=
 =?utf-8?B?VHBCREtweTBuak0xZHViSEdWem9sSHJhcUlZQTlXWHM3QXNTb3VyZy9UdDh4?=
 =?utf-8?Q?hJC5Xg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2dnbzhsbjRReTI0NW53TVo0cUx6bkVlOXhGRDQ5U0dqSCtmalNHRGZZTU1V?=
 =?utf-8?B?bXQ0eVluV25oVUlKWTBZWEM1cUpTbFd4Y0hvbjlOUitkcVA4cjFYeHRJS29N?=
 =?utf-8?B?cHAwSDJvRUh5bGRCb1I1MGlIZDJVVEZoaTRGRk9LQTVONTQ5QytORkJrcmFk?=
 =?utf-8?B?bHR0WDJ0OUZLN0N6emVNUmhTNGNwVXlBQk1XSStGcU9SL0daYzJiaW5PdGIz?=
 =?utf-8?B?RkVJVyttOTB2cVRETFV6YVAzZXd4ampmWFNJYS9CQ2dPcWNNV0VvVjcxRjFW?=
 =?utf-8?B?L1JFWGZWalZHYVg3dERMWnpSb2duMFJSbklnNmFrWEEva0kxQmpXZTVBVDZq?=
 =?utf-8?B?c2ZVTXYyQTMrdzNTMkZwN0dXSWtCV0xrWWNqOEc5VmtOZUZLMnJqVmY0S1Z4?=
 =?utf-8?B?NEE3Q3VrVmNJZVd0azViNmw4S3JLZUxtRGsvUktWVVZTU2Q3NWowemdUc2ZI?=
 =?utf-8?B?OGpSSFU1bmIya3krZW54dmttd29XTUt4Q084cll1SWJOVzVTSDZmcG5sUjhp?=
 =?utf-8?B?MG1lejlaSzZGTnBTcUFPNFp4cE14clZQRFl0RTRJdTNrUU5nVzNSeFFlMGE4?=
 =?utf-8?B?cnovaTJzZmtzRjJ5M0JNdlBsMmV2WXkvS1hCMkVpNm45UHYzMGE2Y0JId2dO?=
 =?utf-8?B?eGFXRW9paW13Mm80TVJGMTBDUE5kWlA1ZVpvV2pkeVB4QUNyWFRDb1lYeWNB?=
 =?utf-8?B?Q2RvNlBnQmMrSUVkcytpZEZGZEpmK0ViaThKdTRJN1NjQktXMHVVUTNQSk1G?=
 =?utf-8?B?ckE4a2FJZ0o5bjZVY3lkVkxDckIrM2ljUFczRkJFMm80SEN2TVVGbGdMb2E0?=
 =?utf-8?B?NW9pTnEweWFid2wyaStjZmFrUjF5U091bGd0T3F0MHNzVlF1Ymx5N01nd0tz?=
 =?utf-8?B?T1F1WXg5UXZlSy83L1NOUVA0SGplQW1WbXRaOUovY1hTbDcvTC8yeGlWQWI0?=
 =?utf-8?B?clRQWEdvQ3FBMnpTN3JmcEdDNjd3UFhmcExHQ3lzS0dubGdseGxNSm0yQXNu?=
 =?utf-8?B?VWljR1pTQnN4VDVVbXpGZko2SEtibU5QR1AxUG80VzRpdVVSUVRkMGtaQ211?=
 =?utf-8?B?Wlc2N2w3cDErdGE0enE2ZVEvbFdZS3YzalNTNEZ3Z2VyeUJYMEM2T2dENndZ?=
 =?utf-8?B?VjVHL1VOaWNiTXpKVnpBc2RrNHhzOHVSWmplNUVKMVlrNUVET0RJaEJqWVBN?=
 =?utf-8?B?c3lYOE5hSkxyeFRJRTU4OXB6Q2dzdlF3cDJOT1V4Q2ZGOGxNYUxsNm9WUDVx?=
 =?utf-8?B?eFNyT1ZKbVBjRXR2dklEN3FsREhDS2kxZ2VNN1hsMHpWZjNyWTdhTlYvSy82?=
 =?utf-8?B?WDlLTVBLYVJmMjg3bndTNTFwc095U1pxUFFGOXVBY29hNzFVQW8zZVpGU245?=
 =?utf-8?B?S09jSUpXVUZ4SGpzbVJSeTNuZ1FxWDhuYjVtZXRxNjBMSnJKQVU0dlZIVzNL?=
 =?utf-8?B?WHk5TEoyOURNUXI4a1F4eEc5SlplakhjaWRCdzZrUkErcnkzUkdEVk1nTFhR?=
 =?utf-8?B?Zyt2L0pVSThuaU55SUNLN3k4ZWNGaXlTQ24zemNOTjJkRnlmWUE0K3FRV2ZR?=
 =?utf-8?B?d0k4dTF0S0pQUUJJRVkxbmUvSW0rNzJhTVFvMlJoRTB5WEtGSGVlQ0pHckFs?=
 =?utf-8?B?YnNPUnlabHU0OUtZRFBTcSs5NTZoK1hBTlRuU0Vrb29KQXNnUVlLRUVIU1BQ?=
 =?utf-8?B?OTlPa2FSV3ppU1hFSWZOS2dpOGVnUXBXWmNsRDYwRmppV3RwblNpbThlVDRI?=
 =?utf-8?B?M3hMRG5hM1JPd3p1RjV1SGVsbncvTFpKMXZXUkE1TUtDQWg0Y09WV3lsTll3?=
 =?utf-8?B?RVZtZzdxaDl1MjB1VzRiT2lPSDMxVzAvTHJUN3JHMlNweTZIL1lzUm4veTJD?=
 =?utf-8?B?U2hBeHJGditaaEhzZnJRa29YTFhqNnk5SDdTQlRORHdYcmNSY1pMYWNoSTdZ?=
 =?utf-8?B?amZPR1ppYU9XQ1JLcGdzSWxZK1g1TndCdGU3MVl5bmc1UFA4OTdHTi92RWI4?=
 =?utf-8?B?aUNkem1lOXVhZ3FSR3FhbTNWajJwQU1hckFDWjdBM3hGc2ZWK0hjdk8xQ3Zw?=
 =?utf-8?B?blFvakg3MTVzUitSNy9GdjVWVk1pRk9UWm5kQUg1blBDb1B4VzJxaDN2cUNj?=
 =?utf-8?B?UjN4UnFZNEEvWm5GYTVBMHdJNHBzNGRUVHp1ZWZyQWxpckp4eFNjdE4zcjlw?=
 =?utf-8?B?YmltNGhqZmZnK1BEaThUcEZBU1pEcWhkL3dNSlJ1TWVEWDNVMVR4WEF3dDJC?=
 =?utf-8?B?K0taQ01Yb1FGTjdXanJGdk1qc2xhaU5yQkJJb1RiSWZqdU9hYjZ4SG96OEkv?=
 =?utf-8?B?c3RUMkhsWWFLZmFYTE5qNWNnc2hKbWFWdktybU9IT2loeEtzVGIzZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0abb498-8949-408c-03d6-08de6eb96218
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 06:46:02.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iH6idtvgTw8r6nDync50/Vi/g6BWoCojdYqw61LeqR31Fh0e8kaxcAJFNeqIvLqRhPHSlHEYBIUuLZ+UVjtEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,msgid.link:url,siemens.com:mid,siemens.com:dkim,siemens.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_FROM(0.00)[bounces-217217-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Queue-Id: BEA2D1537E8
X-Rspamd-Action: no action

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 77e45145e3039a0fb212556ab3f8c87f54771757 ]

napi_schedule() is expected to be called either:

* From an interrupt, where raised softirqs are handled on IRQ exit

* From a softirq disabled section, where raised softirqs are handled on
  the next call to local_bh_enable().

* From a softirq handler, where raised softirqs are handled on the next
  round in do_softirq(), or further deferred to a dedicated kthread.

Other bare tasks context may end up ignoring the raised NET_RX vector
until the next random softirq handling opportunity, which may not
happen before a while if the CPU goes idle afterwards with the tick
stopped.

Such "misuses" have been detected on several places thanks to messages
of the kind:

	"NOHZ tick-stop error: local softirq work is pending, handler #08!!!"

For example:

       __raise_softirq_irqoff
        __napi_schedule
        rtl8152_runtime_resume.isra.0
        rtl8152_resume
        usb_resume_interface.isra.0
        usb_resume_both
        __rpm_callback
        rpm_callback
        rpm_resume
        __pm_runtime_resume
        usb_autoresume_device
        usb_remote_wakeup
        hub_event
        process_one_work
        worker_thread
        kthread
        ret_from_fork
        ret_from_fork_asm

And also:

* drivers/net/usb/r8152.c::rtl_work_func_t
* drivers/net/netdevsim/netdev.c::nsim_start_xmit

There is a long history of issues of this kind:

	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	330068589389 ("idpf: disable local BH when scheduling napi for marker packets")
	e3d5d70cb483 ("net: lan78xx: fix "softirq work is pending" error")
	e55c27ed9ccf ("mt76: mt7615: add missing bh-disable around rx napi schedule")
	c0182aa98570 ("mt76: mt7915: add missing bh-disable around tx napi enable/schedule")
	970be1dff26d ("mt76: disable BH around napi_schedule() calls")
	019edd01d174 ("ath10k: sdio: Add missing BH locking around napi_schdule()")
	30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new  function to be called from threaded interrupt")
	e63052a5dd3c ("mlx5e: add add missing BH locking around napi_schdule()")
	83a0c6e58901 ("i40e: Invoke softirqs after napi_reschedule")
	bd4ce941c8d5 ("mlx4: Invoke softirqs after napi_reschedule")
	8cf699ec849f ("mlx4: do not call napi_schedule() without care")
	ec13ee80145c ("virtio_net: invoke softirqs after __napi_schedule")

This shows that relying on the caller to arrange a proper context for
the softirqs to be handled while calling napi_schedule() is very fragile
and error prone. Also fixing them can also prove challenging if the
caller may be called from different kinds of contexts.

Therefore fix this from napi_schedule() itself with waking up ksoftirqd
when softirqs are raised from task contexts.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Francois Romieu <romieu@fr.zoreil.com>
Closes: https://lore.kernel.org/lkml/354a2690-9bbf-4ccb-8769-fa94707a9340@molgen.mpg.de/
Cc: Breno Leitao <leitao@debian.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250223221708.27130-1-frederic@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This already went into stable down to 6.6 but likely got dropped further 
down after colliding. It's not limited to PREEMPT_RT usage but 
particularly relevant for it.

 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69bb7ac73d04..ec5dff37fb76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4473,7 +4473,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	}
 
 	list_add_tail(&napi->poll_list, &sd->poll_list);
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
-- 
2.47.3


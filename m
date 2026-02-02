Return-Path: <stable+bounces-213041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHmpAtdwgGkw8QIAu9opvQ
	(envelope-from <stable+bounces-213041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 10:39:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF20CA302
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 10:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED83A3046DAD
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436112D6E6F;
	Mon,  2 Feb 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FtmFpixs";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FtmFpixs"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC21ADC83;
	Mon,  2 Feb 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024913; cv=fail; b=EszIT8sgEjvxPWHP4E4Kr4GjtwCtUd8WDM7uEO9BfSflB4mBeAaYdGOh+fODdwtsRfhSsev4fOJ0RGGS8uNEUHAPp1OLYHBKtlQcR2gyLvbgEa5XAvsuqU7dmm80p6KE691HsZ/rdKp7/Go7Z5GFqieH5JeAlz2RyJBuzZADB94=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024913; c=relaxed/simple;
	bh=7SQp5jjOr6zqcn/95ieqG/NqQwhvpYpygWNOBSmDUgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VCusd5GhylJ8by5wC1/HkanwK8TGlpO01XXLDT3n2edoSkptbtEfi+6Yi2yhJ+LmYapr37TUAJAiHW1IcLg23rywy573W0DxYldY6kuEiSlMYGKU5juhj9Fcy4aIvV6Bfv4Frg/VtgV39bT3cItN511jFvQrlzAfbXEKCO4/mAY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FtmFpixs; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FtmFpixs; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GaAnr2Zi99uPrERA2+XfN9s54N0JewWKrHhjaBYPMGFB1Cy6UyzP9oQgRyvNpgvwEh8hxaxN594ES4uPAJMmsIkvE02afBCGcXmY/+WlOu12y2TuxOg70PGQNgrDX5jo11wvo2rA4NxiuiRkP6V8cc4DvYRNWBESNWV8lSI01chIPctufRRZnxBRupcMbJc8fp7aN5wIZ4Tfg8NYTXYL0Vss8wU1kT4sHTzEJkW35u/UDPGO3V65vsUixZ+G2juEUPzvJON47DY9YmD+inygfLJ1xV7eDiZZ474X5IfZjLjdcpqb74WJFvUgxJsOXOWgY6c5u7seaKlzHvSYULl+Sg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBkze4gcyehuSlgBwjj0rmPLXgG2pGmw9DcRAJW58HM=;
 b=uhm2rNvvFNh6j0wPMUQNr9MyrVajr18Kta03xC4mhc1dKLVHJ+zUjfIdBWxBJ99aHPvvqQpZgJ/OXsCP7pNz20dqrTH0cvVmTn/xd/cij+eDp29PKdi35RudtkaACnbVcNPXhaS5kC/t7jFb25YLyBp9f3X9WvHy64Bzm3eEedPaamLnf/kxQ9u1GZwKAH/Jg5psSxrx06i/IGIqZoApJIrmi8RR3+6RG1XKEymh5FuOWpqIOSRT1UTnRvkiwa8Bgh6BAKjCbFfYrMZmn2oKFJBCLTJoIdGIokPzspIL4g7BGpsdKDin35+ciF6hLBem5pbHlc+8JIVeX4mIE7w5eg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBkze4gcyehuSlgBwjj0rmPLXgG2pGmw9DcRAJW58HM=;
 b=FtmFpixsle06FT2PT+2S+EeYUD0vN+ZzOVGMOvwoRi6TQkwQ338zmhS1KWlbLb/NKzvlNW/N4/lvp2VqLupN6/ottVrijmkTSQ5fY3DRBciTPppTcMPuGsncZWGC7lTj6bqFeBfR+IbaFolSQOQ1uOCOWqcXHbccNcBq1uM8R2E=
Received: from DB9PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:10:1db::26)
 by AS2PR08MB10036.eurprd08.prod.outlook.com (2603:10a6:20b:64d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 2 Feb
 2026 09:35:04 +0000
Received: from DU2PEPF0001E9C1.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::b9) by DB9PR06CA0021.outlook.office365.com
 (2603:10a6:10:1db::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Mon,
 2 Feb 2026 09:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C1.mail.protection.outlook.com (10.167.8.70) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10 via
 Frontend Transport; Mon, 2 Feb 2026 09:35:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj8ovVaGSqU7tFdFGQSfXYAQ1PU5DVoHjkMpf5g5Cvp31trLuY+Dp24ELScVt0N7mhV959s74kyqM+7XFtsshkLY15O/y0DdMa8RyzzBGZWEFkym5XPfKMRyN+e1cYQB16w8MJgR8SlujVVQW9BvMtVxvBJ0QIqtuP2/9LYrH6mwAnntwl08xQOd8IgeqjvJwNi6vdf4fs0WA3TivPYPYVgI0s39ZwtmjrgL2xe/n8uwsH1chaifNHZM85XmKbW3LFPjA7JCUybbTEW3qeAl7oWrOlJohTjnOmHGMRY741e6J/suWywn2bRPDqzoQiZqvN0M+s52ZJ2eDlyzoYR36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBkze4gcyehuSlgBwjj0rmPLXgG2pGmw9DcRAJW58HM=;
 b=CRMVW1Sdtgz3REK6oLEgXgp3VON0zZO1wtTRZ9aHh4OQ68Hu4jNewxYw/JWWLeFgNiux7YGLsl1icThKrNUTbFPTH6nCCuQnaSzhVdCUEmUVP9DF+EJ4YErvJBzvQ0X/4AoYdfvGjO4Bt53yM27uqtAauMM5CHwYfTarwF0Lq2z0R7lE9v6v1DUFPtoRE3P58/ozyCqpAFQmc2gLnqUTlbxCESVHpeSyTM+GmhkckgGKfBIFJ2/Zlh7Ja8YprdluAv/oI2CprGeGY9ShGs1VNqpj5rPXZ5+mOC+RlBOW1KY0juDOBGTJAdIW6HXDyZliQktpQD2BObtLjcKbPE+2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBkze4gcyehuSlgBwjj0rmPLXgG2pGmw9DcRAJW58HM=;
 b=FtmFpixsle06FT2PT+2S+EeYUD0vN+ZzOVGMOvwoRi6TQkwQ338zmhS1KWlbLb/NKzvlNW/N4/lvp2VqLupN6/ottVrijmkTSQ5fY3DRBciTPppTcMPuGsncZWGC7lTj6bqFeBfR+IbaFolSQOQ1uOCOWqcXHbccNcBq1uM8R2E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com (2603:10a6:10:644::21)
 by PAVPR08MB9257.eurprd08.prod.outlook.com (2603:10a6:102:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 09:34:01 +0000
Received: from DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f]) by DU4PR08MB11769.eurprd08.prod.outlook.com
 ([fe80::d424:cd62:81a8:490f%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 09:34:00 +0000
Message-ID: <bb521240-ab53-4c5a-aa1d-6b140ed4262e@arm.com>
Date: Mon, 2 Feb 2026 09:33:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior
To: Kuan-Wei Chiu <visitorckw@gmail.com>, James Clark <james.clark@linaro.org>
Cc: mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
 gregkh@linuxfoundation.org, mathieu.poirier@linaro.org, leo.yan@arm.com,
 Al.Grant@arm.com, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 ericchancf@google.com, milesjiang@google.com, nickpan@google.com,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251202082613.3265761-1-visitorckw@gmail.com>
 <3bec7ceb-61a8-4b38-a794-02ee2fc9e68c@linaro.org>
 <aYAxbbkHslAP9RBN@google.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aYAxbbkHslAP9RBN@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::27) To DU4PR08MB11769.eurprd08.prod.outlook.com
 (2603:10a6:10:644::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DU4PR08MB11769:EE_|PAVPR08MB9257:EE_|DU2PEPF0001E9C1:EE_|AS2PR08MB10036:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a912d51-61ac-4f62-7133-08de623e586e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?T0I2a1dDalNqRXZxVjlKVnM5bUdrZWtrZ1BHaU5vVE9FbUpqWmJaRCs4NkNJ?=
 =?utf-8?B?QVVOblRNMmtSaEpTMjA4RCtTOTBEM0xpYXJuQXZ1SFgxMTZtMVJxazQraVFl?=
 =?utf-8?B?UlJPZ3k5Q0d4K29pWjFrc1BYdGFERTk5ZDJxQ1JiaG5sVDlLY1BBa2gwZ0du?=
 =?utf-8?B?TDUxU29mUmZPcHpNN0E5eThWVWlkL0FabUxSWUo3c0dtOWtVMHRFN1pUSklG?=
 =?utf-8?B?N0pkUlR5OTlyNW1qL1hlcEg0cTJjV0Zkd3RwYjBQZVVrWloxNmU3L0xjSExO?=
 =?utf-8?B?ZkpwT3htQU0rL1hrVk10dXZUeXBGZ1NwZjVYSXBMSzZPQitsZDVSUW84dDJh?=
 =?utf-8?B?akdENks5cmRXbG1TeXRnamV5VTcxU1pPVGdXUHFCZnp4ZTNNR2FaU2Y3TFcr?=
 =?utf-8?B?aUsvK3Rld2hTVUdpT1ZpYXFVMys2dFpDQStZVzNYK3YvclpEdFA3eXU3cUg2?=
 =?utf-8?B?QUMzRFFQU1AvL2N2cDFoWFNoWmZWR0RSUVJRYjFoWHVBNTl0OWJPY1p4WlZs?=
 =?utf-8?B?SlE3WngvbnhwdG96MDJDcUk3THVyd0szdzRpQlR0cHFxbUhBeUlidVVoUnBX?=
 =?utf-8?B?RkFqcHV1NXhGL1piMWVKMThFREp1dllaZUp5NDhERldsZ3VuRFQwYWYvWTVo?=
 =?utf-8?B?MHY3RmZFSmxNMG9WWE13OUlhblA1Rmt3ZCs4QTlqeUlhbkM2b3NzL0FoSmVV?=
 =?utf-8?B?bGZQRWNyWWI1b0t6SXB6dDhmbWhVbU5sYzRxMEE5QndwZjY2eXRNV25kZ0I5?=
 =?utf-8?B?eTdGMHppUTMycVRtbndMWnVMNGozSEMzM2pCNHJGd1VydEJQUkpEb043SC9M?=
 =?utf-8?B?V3grNmJ0TnpneC9PNmR5a05oVmZKdHdZWitNOUdDd0RGSlJsZjNqbUNlMTYr?=
 =?utf-8?B?anRid2ZmQ1N2RUIxbTh4MnFNbnQ4OWE1eGh1Y0ZZNmhLVmpqVGdSWTBOMjc5?=
 =?utf-8?B?WnBQQ3luNTdKbVdKRUJHVktpRWxLN3pVR1dKWVNibWxUNkR5bW8rUTViNHJz?=
 =?utf-8?B?clIxcmF1MWVPTkRvWlVCS0dIZXFRVmJOVTRkT09veDdnQ0hQL2pIbTBsZkNh?=
 =?utf-8?B?Q1h1RFVYVzNFY2ZFcmF5UlZiRU1KcENsM2thdnJCbmJFTzUwN0wrWTg3dFc1?=
 =?utf-8?B?OEtrU1c2T2tPNUpNRXU3cXBZMHREYXJFbHlJNXN4MDQzZHNDWGhPTVMzaGNv?=
 =?utf-8?B?SGlEVk84d2VSakc5V0dubWxrU3hEQnBRNm9jcHMxazFNQUtVUlJXa3dSTlRq?=
 =?utf-8?B?cjJsMjY2d1YzQmRCZ2NWeU1GY3BycXI1M1JST0RrSHFhVTM3a0lVMXhpWnNX?=
 =?utf-8?B?RlpmWkJVcjkwYmZQak9IOVAvUEw3QW9PeENhZkxES1l2OHluVjdFb3krdWFV?=
 =?utf-8?B?aTFtUWRNMEUxK2FzL3VVRWhMRlR2NDRKSXRSOSs4VXkrcUpraFJwM3JkVW50?=
 =?utf-8?B?RWFROWYxVWdweXkwV2haeXE2RGZRRVNTeXJZUGw4NWpWZ0hjT3VGektGZWcx?=
 =?utf-8?B?SXRRWlJlakljWTF2Z3UvVkErNEQ3dE9VS3BmaG9MV3liZXF6MHVTN1V6Q0Fh?=
 =?utf-8?B?R2JIZytCaGpjZjIwRjFyZFhrZGtGYXNIbm85WTB3dThseGpwbDI2cWFtK0xD?=
 =?utf-8?B?enBKd3ZUdlZuNG45NTJscG5TSjJMRzl3S2NVUGI0WkVWUEROZ0hIc2NFNUQ5?=
 =?utf-8?B?N3NGbGVRc1FtNkpVWW5naUtNUGhZOFllbzhmNHRTbEYzdHBORk1SMllTL09z?=
 =?utf-8?B?V0NDNVY0eGxVT0diV3dSdVgyNFMvb0pDMzhWRXlVei9vaGZ3TXltZnJaczNz?=
 =?utf-8?B?cExnZTVuZ29kZTB5MjIxWTdlNHAxa0NxQ0xYWXplVE5KZmlpYWFXSnhKQVk3?=
 =?utf-8?B?S3dkdzBxcWFLaVJ2RVcxWTdOaThBODM4UHIvZFowK1pUZ0hpczd4dUR5dm1E?=
 =?utf-8?B?WXUyeVRHOHlIOWNtYmJETXc3eGp0eFFXZDRhN05RS3BtNEtGVmdIazVvaVBN?=
 =?utf-8?B?MHhzb1JzZ0ZlVnNmRGIwYmdzOTZVcU01MU9kTUxJeTA3WXRYMmI5VXRja2Yv?=
 =?utf-8?B?TGlvN2FQUTFldkIrTm1qbWFPRWVnMlZqWUZIWUdyUXgxVnhlRFpLWjZZTmhs?=
 =?utf-8?Q?tV8kECjC1CYaF8RW/abOTJVoq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR08MB11769.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9257
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	429b5e0d-bbf9-48f0-ea90-08de623e325f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|14060799003|376014|7416014|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ni9nWFJuRjF0QWVaTEdVV3pZYVBmaWREeWpzclZkaW9OSU1oZ2pYRXVsZkhp?=
 =?utf-8?B?REVTSlkxd3ZFODNwRGYwRGQ3L1AvUW1xV0VqcW9icDBnL0FqdjRjbGZRRGsw?=
 =?utf-8?B?dFpvNS9IYUdETUs1ZHZDc3d4amdGVzRrcmtXUmVzenpqWkFBbUYvZHFjUEdR?=
 =?utf-8?B?bllSWVZVak1hQ0s2K0FycHhGRXJsNVQvOXZVSDNnQVJqZDR0TWJZRFR4dWh5?=
 =?utf-8?B?NmdrOWJsVzRXN2xwOHVRNTh1ZnZHTFBiclJqakRjeHAvaG5MbXhMTXJoM3Jo?=
 =?utf-8?B?Ti9tUzdPWU80QTNaYW16WTFaYTJqODR1Zlo1cFROVndoaVUvZ1Zkd0VrNnRK?=
 =?utf-8?B?cFVkek1WU2wvZC84TVhQeExRcXFPVG9QMG5LNDVEZ3FDeUhnTVZqUU40TUda?=
 =?utf-8?B?ZEFSQzVjRHNjN28vdFcyU2lwSGlqKzNqRDlNRjhXclRFVnlxc3dQcHJUQzlK?=
 =?utf-8?B?Q1QvUW5WQm1jMG1VMWFpOVJzdzMzclcxWVJSMkZ3NU0xckdjL1FldElDbERq?=
 =?utf-8?B?cUtoSSs5c0Mxc0pYaXcxTVJydHhwOXIxbW96dG45TWU2Q2NLamdQSGI3VDJZ?=
 =?utf-8?B?Z0N6MnY1akxDbFdNNFowVFVPVDJ1bzFZTzVmQ296N0xteFNpV3MzNW9sb3k0?=
 =?utf-8?B?K1lDQkR6a2h5aU02Qkd1eDJXUWQzYVRCckNrcmVSbFoySmdxMEJ6YXVRbW9o?=
 =?utf-8?B?Szc5WERtS0ZBdHp3dHJVdUNCUGx5aGpwc25aZHpEV285cmZpS3RCRlE3cWVq?=
 =?utf-8?B?WUYvWDAyR01DUWdJdDE3R1p3UVV3RkRCSWlwR204eWRnREVoRWp2ZXZIYXNG?=
 =?utf-8?B?R3QwV0UrNks4bGk2Z2xqZkcrb09SZTZRTmlVeVRpcEh5UXVNaGh3c1NldUdP?=
 =?utf-8?B?dkduOEdVZGRselBaQlgwYUtKKzVMNm5VMW85ak8xcE9ZY2RmSEJLTjd2U0R3?=
 =?utf-8?B?NlRaeGNDRlFwU2xVNDJ5TkNmRnljR1l5Mlh6cmV5S3hyNWUrK29uTVFuUmpQ?=
 =?utf-8?B?bTA2c015Z0gxMmEvdmZIUlhsT1krVWlMUzdQc0FWN0o5VHUyRTBRK21acHRs?=
 =?utf-8?B?ZDNObWRlazRZSW9NTmZldklxUC9BWExBVFRFbVRLME9EWkV0YXgybnVVU2Vt?=
 =?utf-8?B?RFJvdnZ5ZUFFQUlDOXlDS25iajN1TnoxWnhsYXJ2L3c5alJnWXNUSjZZRTcz?=
 =?utf-8?B?VUtuQXdQRHhKelVGTWltNVhvVVY5dWRtZlE0Rkkxc01MRU5KWDN2bmlkTjg5?=
 =?utf-8?B?ZnE4eTR2dG9hbmg3OS9QelNFaFJxb3BWM1ZqYVBOaEl1bTFrWWdEZDc4TWJD?=
 =?utf-8?B?cWx1RW5nbVVZaU8vQkYycFVlR3VWVGFkT2pFc3lUNStrV1ZDZkdNUEtUN0tI?=
 =?utf-8?B?VVlLUG9kMmtuR0NvS0c4TDY2TFY5STl5MW5FNlVjSCt0SzJPNExMWFAyYkYw?=
 =?utf-8?B?RDFuMmVRai9qSFRmdFVXcDhBNkpjdWpNczBYS0h3bFRnR1E3c2xSRExBa0Vk?=
 =?utf-8?B?ZFEzMGNDVXVDU2M3TytEMWNaVjFvWjliWTE0NTVoL3BWcUhTc0ZlVXNoVmxY?=
 =?utf-8?B?dEQvU3VQREVzVkpMdGhLcGlQLzNlY0c2dE9DUCt4WFFoVHBZdkdlZHpOQVBZ?=
 =?utf-8?B?UHYyK2tmSHVFSWFaTG82aUx0a1dIa0duMVk3aE9mbXNGMHRKdWpDN3grSE5I?=
 =?utf-8?B?Q3RtZW1NOU5XMCt6QzlzeUNJcWRPWjQrejNSNlJWVXZ4Q0R1QmR1d2lpYUVE?=
 =?utf-8?B?WlVQYm13SlpoQ2FXWGdYL25YU1N0QnBoQUIxK1hMTW9MZ3hUSW9CV0F6dFNC?=
 =?utf-8?B?SEhmNS9ES0VKS2JBaW9Dbml3Tk5NeHR3OWtSWklNVEYvU3VwNXgybDRqdmpX?=
 =?utf-8?B?bnhPWkN2UTFlTWp4YWZQdW5oK2swZGtoV0lmN0RTUVZicUZrTHFzRnpqTVQ0?=
 =?utf-8?B?T2t5OHFVSWlyTG55WEMySElOUFJKdUtIaVpEMFRUbU1ub001ci9aRVlmQStv?=
 =?utf-8?B?cGhwbU9CMERqdVFGaHhNU1pUM0p3NXpHdWUzc005RW9xVHhRSGpMSmUzRjN2?=
 =?utf-8?B?M1pKYnVCVUlxZW5pTDhqUW5SQmJMclY1STNiZjFiL1NNbXk1aUhUSkdsYnNs?=
 =?utf-8?B?SzJtbkJ6ZFR6aWRLRm9Kc0pvRnc3b3FKN1JWNzZsREZVWDlYUUJ4RGRuNDI1?=
 =?utf-8?B?K056Y3AxZ2t5Mm9UN0R1SUJsRjdHRjJXMFR5WTBMT3ptVVFEVEhVbVp6aFg2?=
 =?utf-8?B?dnJHVi9pWFBBclFyOURWQVM4R25BPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(14060799003)(376014)(7416014)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GWR3Yf06H9x/NUrrEBXgUIRschq56GLeyHPHKukdHniDq294O6NFmAvCS8rtLt8xR3aGx/1i+UGS4iaNINO4wrrGx5K/MFqKj4gOtvKl5r7CpuILGv8G7D5GtLA6NIJQRckeLzRufhBzw10LXLZRpLO0nNXvnHNAL1KuolgkB8nRQ8/DglEfL8o1dLIJPXsTY4rE6If9QbhoEFaXtkKAhuqHszfRIdy2DGuTt6cGVNdJnd5VqK5MVbKQ4XK6/Vsg+AOD3AKykKgGsFHXQveigx5pOJHL/tmImnZOmd54fo04Ph9Ba5xesmKlrW/wq1Ia1gl3vmEcZCg97q0Og2IP/FakX6RQTNmBieXOC8wML0ALzaWy1uyuIfukPw84U7nPh8xHs6SPDPwt48ypPXBwi6T4hqPLHkMtjrEKPNLkHXEBdKH2Z+6dP8GtsEUekbhl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 09:35:04.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a912d51-61ac-4f62-7133-08de623e586e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6FF20CA302
X-Rspamd-Action: no action

Hello

On 02/02/2026 05:09, Kuan-Wei Chiu wrote:
> On Tue, Dec 02, 2025 at 09:26:19AM +0000, James Clark wrote:
>>
>>
>> On 02/12/2025 8:26 am, Kuan-Wei Chiu wrote:
>>> The cntr_val_show() function was intended to print the values of all
>>> counters using a loop. However, due to a buffer overwrite issue with
>>> sprintf(), it effectively only displayed the value of the last counter.
>>>
>>> The companion function, cntr_val_store(), allows users to modify a
>>> specific counter selected by 'cntr_idx'. To maintain consistency
>>> between read and write operations and to align with the ETM4x driver
>>> behavior, modify cntr_val_show() to report only the value of the
>>> currently selected counter.
>>>
>>> This change removes the loop and the "counter %d:" prefix, printing
>>> only the hexadecimal value. It also adopts sysfs_emit() for standard
>>> sysfs output formatting.
>>>
>>> Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>>> ---
>>> Build test only.
>>>
>>> Changes in v3:
>>> - Switch format specifier to %#x to include the 0x prefix.
>>> - Add Cc stable
>>>
>>> v2: https://lore.kernel.org/lkml/20251201095228.1905489-1-visitorckw@gmail.com/
>>>
>>>    .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
>>>    1 file changed, 4 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>> index 762109307b86..b3c67e96a82a 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>>> @@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>>>    static ssize_t cntr_val_show(struct device *dev,
>>>    			     struct device_attribute *attr, char *buf)
>>>    {
>>> -	int i, ret = 0;
>>>    	u32 val;
>>>    	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>    	struct etm_config *config = &drvdata->config;
>>>    	if (!coresight_get_mode(drvdata->csdev)) {
>>>    		spin_lock(&drvdata->spinlock);
>>> -		for (i = 0; i < drvdata->nr_cntr; i++)
>>> -			ret += sprintf(buf, "counter %d: %x\n",
>>> -				       i, config->cntr_val[i]);
>>> +		val = config->cntr_val[config->cntr_idx];
>>>    		spin_unlock(&drvdata->spinlock);
>>> -		return ret;
>>> -	}
>>> -
>>> -	for (i = 0; i < drvdata->nr_cntr; i++) {
>>> -		val = etm_readl(drvdata, ETMCNTVRn(i));
>>> -		ret += sprintf(buf, "counter %d: %x\n", i, val);
>>> +	} else {
>>> +		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
>>>    	}
>>> -	return ret;
>>> +	return sysfs_emit(buf, "%#x\n", val);
>>>    }
>>>    static ssize_t cntr_val_store(struct device *dev,
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
>>
> Thanks for the review!
> Is there anything else I need to do for this fix to land?

Thanks for the patch, I will queue this for the next release (v7.1).

Suzuki

> 
> Regards,
> Kuan-Wei
> 



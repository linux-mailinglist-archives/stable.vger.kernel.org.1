Return-Path: <stable+bounces-167120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9989EB223A1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A00503C30
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615A276058;
	Tue, 12 Aug 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="c7deg1OZ"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023139.outbound.protection.outlook.com [52.101.72.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279F1ADC69
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992016; cv=fail; b=UcBFhQDz67cAxuurtqDncvwVHRAQPdih6cXHgZT67pBxm+NyRkwZX4Ix6GFvj/fD1t6aNbuoEDavossUhb0IW9ZWWrCgAt6Oc8zrelAIqBljyvfW2Z6QfsSOXhEJUpNWiFL6JveEFIvVfW8L8Ztq8dMBan8F5JwcdFcP3V0wbkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992016; c=relaxed/simple;
	bh=oaaQO1eEwZZj9PGP0wtfllFlTTp6F4P4uXbMxdLpzb0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLKcJPGRd4mekNurv5HJJDv1rk7kc5NEChJ/+VdleCQBIv9cov5gCzq9ngk0ypS7ooQuvC4gZJzoqrdi1t0nJNjLziHfmy8xN04GPGIdadz4yiHT0shT725tH09Hjo/yQTim+XHdRmRfYdnpsQdIIH4Wg30/SOGI+lvcmJLi5Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=c7deg1OZ; arc=fail smtp.client-ip=52.101.72.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npuRZ1AjzuoAxUHkh59Psog9Bu9nXOcPG7V7nsJVcDW2xotyFKj76ciWH3155LAumZibUKbQzgahfccURnHQD9UJEX10Y+wXu+5DYPYglfRdzmTykn8vOmWd8Xi6/GFbcqhUleCDWnfgqepESmgFmpas3DiGZrY2Gce6ucWOMRALZDqSLOtXWLcob06vdj/PDIwXsWnS07OgB4AM7e1ufNz+yAzLFE/L6WHEPa19+Pvza4RdCRGuU2b1YwSHNpk+4BwtHAlFUgYj5BBea0I8MQSp4/lgNSnfLSMauTD4Rq/3q+bMyfrcmdumKy2JDm8gMN/EKqbg4cNE8bopiMWhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vDHeonFgY+Kiliv2GficfgKKRUmhiHreHJDIZf/ql4=;
 b=WadzkFhIjWJchTNi8qCJBNvWpwq7Za0/r2Reh3VAqYFeks+kthu7mWBWOoGsRGDfCtvBVaNrI2tSGtwJXPPnXnfC8psKqJ0uml+sID8QqDgjov6G4oM2hVh3ihxT3Jj0rpaWb6JBa2/0LJL6JzRQNMRW40PuETg9M/979xwr0ZWkOdqkw0Ci4XVNcp1dTgyHqKdkq9xBZAUoZjvztpJFhFvXELnLy0yoEothnqjECfgCe3CpgqYuF7IkKuTq+D0PH1gXVOMbH0JIkx3a/wN4L/0oULngbwua0uZIFWgj7A1kBCL3TN4E0GJ0zKpNcuxuBLynuV3lohlh/eANmIkmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vDHeonFgY+Kiliv2GficfgKKRUmhiHreHJDIZf/ql4=;
 b=c7deg1OZqRgWx8HCICEDq3Ia/ewWw0alSXkUcmkIYt4sXG2g8HVbWg8YjBZZpumVVsoeiWhoDPle78DvnE/MxBEJYfG7kZQUxUB4w6EEVqs8RpgnhRiVoZxzWujV4kNsXf61iic6iaKCZguBqqH7cdwxfiw2kqmJHC9hpOldjkV/nNknh8NT1JKp2PFMVUllZptcUpO24Qd73gVm0ZVt3QM7tPslRDXQVp5T2zKyNHRZvQYJO0+bq3mnM1VCPk4BRDVxWUJztx506Q4lXYJ1Kgd9I38PrUQTdcE2RDY93UseRpqcMsz/NFMufhOq8wXnRYPQpY3/DQa5eCCLMnMSgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:46:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:46:51 +0000
Message-ID: <22521cea-90a2-45cb-a704-d9f0db667405@kontron.de>
Date: Tue, 12 Aug 2025 11:46:50 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 19/24] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, stable@vger.kernel.org
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-20-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-20-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f894a30-b19d-429e-387d-08ddd98529dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkQzUloyRFlTY3BPcmFvUTVzR3ZLTW1IQS9sWW9ucGYxaU44VkF3aGVicGpC?=
 =?utf-8?B?SXdQb214eGMrSmc0TWVIeVpHdnZ2QlJ5TE5XVG5wWk9MRWFrZkV2OG5tYkhM?=
 =?utf-8?B?dGhCSkhza2pTSVMyRGhMTUQwbHZmTG1Jd2N6Ykxxd2IwWTlvMyt3TkEwTjA5?=
 =?utf-8?B?cEJzNTAzUGlCcXRZMUkxZFVtZGw0K21HOVZNQzYxTzdMZWc0N3dQSXIyb2Vj?=
 =?utf-8?B?WTB2V0RRbWt0bzd5aldRR1VySk0ra3JBdkhJL1RKTTZGME9TMmZJZ3dpZk5D?=
 =?utf-8?B?T3FyYjJGUUI0SjNRY3crSHo0YVk5RDgxeHNWNnYrZ1NNOExVK0RtSTN6d1pO?=
 =?utf-8?B?U1BHb1ZRQmdPMVRvUUc4YitVaGl3UkRRMzQ0OHRGN1V0bTN6WTlPaXprNmkw?=
 =?utf-8?B?SGJocW5PS3BvYjdtL0F1YWpScDFPd2JCQjFhK1JEZmxMYktIdUcwUWlVci9W?=
 =?utf-8?B?NVhRYng4aGsxVFFTdnlPaFhzNzZYM2x4a3ExcHloOUxZMitlanpsVlBrRTlk?=
 =?utf-8?B?MkRyY3Q3NGcrczZGalFKNlRuQkJMNDQxRGFrRnZUV3RYcVpMWGc4bDVqeVpZ?=
 =?utf-8?B?NG5aaWpvOUFzcldIRDc0ZVlLbWlibzZTdEJKSmxjczRaeDhqa1ErNG9DaHpq?=
 =?utf-8?B?bU1qdFFSUkxabzQ0aVJQOW1qMnFha3V5TU45cWQ2b29pVWxOZER2Q0h5ZXdU?=
 =?utf-8?B?d1Z5UTVnZzJZQ3hITW1QYkRiWE8zVHhlWlliZ2kzTHZKYzViVFA3NjBrUnp3?=
 =?utf-8?B?WDhDZi8reDlNSHJWRVl1Y3k5MUJQblRBeEdpWG9WU04zNkpTUGk2L0ZEL3Q4?=
 =?utf-8?B?eUFzalU4U1owTVY4dnNDQSs5REhIQnVMd25ydmdRYk1NV1dYWFFxenNEOEZP?=
 =?utf-8?B?L1UvMFh1WG9NeWJDOVByNHhOenZodzQ4Z05QK2hKN1U2Kys1bFJKeUQ5ajVz?=
 =?utf-8?B?eXVoUWQwd2VlaEhENTFNQW4xbGplZmxFYitjY0c4Rm1Ha1YyTkRuTDhqbWc2?=
 =?utf-8?B?Rlg4aVFYNnFudVlKclBmVEJGTVFlMXlhcnBPVGJ4RFV4QTI3VC9yRXVtVCtO?=
 =?utf-8?B?TUlsd2xDWmVrejZWSUlaUnI5aVBuNG0yVEVvNlFMOG0zbHdUS3JJVVdZeTJL?=
 =?utf-8?B?NVdYWmhLTmtXNDJmNkw0YU13WWhpVDlPRVF1a29OSU5NbWE2c0k5RmpJeTVw?=
 =?utf-8?B?cHE3ZklOVUNwWkZwaEtScmdOZ1V2QTU3OVJsb3BsVW1TdkY5TE5hSHlXMFhp?=
 =?utf-8?B?OUU4M0FiRmtUTmloNlhCTHgrNHVTSG9QL0JvSGtnNmE2Qi9XUHFFUVpvMkVK?=
 =?utf-8?B?bFZGbSs4NTR1ODgxR0ZGN2VEdExzSWh6Ylg0WDNQcVpzQ3h2eVZmdytBNkMx?=
 =?utf-8?B?YmdqWlg1bEtpR0MzY0krNU1EMFdpLy96cksyREZtdjBLNklpcDlCd0hsRDhq?=
 =?utf-8?B?Q2lDcjFzNEEyV1Z2dERnajlkc25DVUM4MWpCckdQUUdaMGM3MDkxZlNXQ2Q2?=
 =?utf-8?B?UmxHcFpIbWpmT2RWVVpBbWpCSUtBalNDK2wzWlE3eW5TOFF0SW5BTEVRbU9N?=
 =?utf-8?B?VFJ5ZUVVSkZTUkE2T2dvVktZaXFDcU14a2NvTmRqS1Vnamc1NkRKYy9JLzJl?=
 =?utf-8?B?TXRoekpMS3pNeWNnK096VnA2K0V3QmFuYUtveFl1SjlmNWFjc2h4QllhVnZj?=
 =?utf-8?B?Y011N3dmekNPSmFYd0pWbnIySUw5ckxCZTlCQ0t2RWJydjFnREIxUnNXUnNj?=
 =?utf-8?B?bko3YXlKZ29JSGhueXQyLzN5NGp5b2tRL2lCSlhJOUhRUVpFU1U5Vk1MRDd0?=
 =?utf-8?B?dWtqcHgvZGZMdHBsTlpmcEh2SFM0QWt0cWhtN29DRnAxQjRFaTJibkFNbjA1?=
 =?utf-8?B?LzR3WklUemg4Z0Q1VGxpNDhUd1Y3QTgyRDBJTVlYMUNVNnZMUEhsMy9QSmsz?=
 =?utf-8?B?d1hna3ZRYi9FYktseDdza0dvUFFPSUEzTEFPaXpzRG56ditmVXZiMlRuZ3Y2?=
 =?utf-8?B?MllEUTdrZEN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1UvaGhobU5tWnROY3lmenZZcUFPYTZoVi8wd25CL25wblovUFdnSHI0bVFD?=
 =?utf-8?B?OEZnWi9JeEQreU8zRzlVS093V0NZTExiR1lOVmNwMzdEcnhjUWI0UFJuUGhz?=
 =?utf-8?B?QzVUUEdMalVxZk9QdnJsc3ZUYkJlc1dPb0dCakwyWDh4TUdaK0w1RzNWbVZk?=
 =?utf-8?B?d1lZcHcxQU9JN280UUdDczd0ejhGUm9EVnVLWEdCajc4TXd3UmdyWURtSEox?=
 =?utf-8?B?OTY2OXZrejAvSVlOUVNzNDJkL21vdXpsNHdodU1qRWhPWXhSSzNqTEI0czhF?=
 =?utf-8?B?alFJM0llb3pzLzhlT3hOQTI0RHd1MzV0SjNpWDI1QTN6ZGZJNlRMaXhKZzZG?=
 =?utf-8?B?cVVrRUVkOGlTYy8zSWlHSVJQRTJ3NzZFQUdqTS9zMnBrSGZNNmxWMWs3VExB?=
 =?utf-8?B?Ny9YL1RuWXdTc0RFNm5UK2ZuRUNndCtKUGliYVltcW1rV1RkRWlDVHBWTHhi?=
 =?utf-8?B?MVZpU3d0V0d2OFphQVBwanF6L3VZTHBGdmx6VGxZL0dVTXBTd3AzL3VubHY1?=
 =?utf-8?B?TGVWYms2ZVVWVjUvRTNtZGt1ZkVJNW5RWDhTSEduN3NsV2g4ZGdEQm44WEIx?=
 =?utf-8?B?N1RFdE5pMXVjN3paU3c4amlLaER2SWIwY1VBZ2JLMUR4MFM5LzRRdGVmUUM4?=
 =?utf-8?B?V1J4OFZ2RnpEL0pCeVgvWlFwRDFTUExpTnAvZlM3aVJQOTJCWTZ4bEhnZkF1?=
 =?utf-8?B?K214Vi81clNHOU5WMlFIN09SWFphWGNvRGpobTZLa1FaVkdoOHJRczNRR00r?=
 =?utf-8?B?bi9oTER2VjdoVkhiOHIzbnlEdW1hSVNvdTNWZkV0UlhlM0ZpNi95TEUxZWVn?=
 =?utf-8?B?NWVhZXRub1JiU0I4MVJDUWFFUUwxR0Z3SXAwdTZMYTQrY1VNSXJ1TlFMRlVn?=
 =?utf-8?B?OFZ3d1pUZkY2MFA1ekRYdWdDQU5hSGNidzk5eUs2cG54NHVIcHAyVW13VUk3?=
 =?utf-8?B?TGd5N3MvN0FaWU1oaURlQTdZRm15WnFRZExoRm4zNmE0aHQ0WGQzSHRPbEtB?=
 =?utf-8?B?bUFHRlBzcHNqK0pjNVNVY2JtUElSVEphY3JCR2xIRTRWOHptblpGbGFBY1Zt?=
 =?utf-8?B?WVNOMzVIWnpnbHJTZHFkd3YzVC84OW9TbDQ1d1paWjQyajJyS2NvYklwdUpV?=
 =?utf-8?B?VC9ocnpPb0t0YjM4YklmWlRQZmd2YmRHa0hLMk1VNE1nYm10WWEvOUpiamd1?=
 =?utf-8?B?aFprbWVtRkdQdDlIa0pNbTNDRk9scWI5RWw0MjdYNy9UTWUvTGxvWTMrTVl2?=
 =?utf-8?B?YTVwekN2MmVLSW9aK3BNUktUblhNazVHa0w3OVRVY3Z5VElTdVYvNXJneU85?=
 =?utf-8?B?Z01keTB5UEF0YmU1QmFFUGRhOHhrMGllYVM0ZlZ0S05OZkZGNFZwei9DcFhY?=
 =?utf-8?B?T2h4M3ZRVUNCeWQvaCtUajNXWUg2L2hNL1R6YU92VnpUbTE5ays4MnBxM0ww?=
 =?utf-8?B?U29qL1RDdTJHVktvN0tsd0JIVWlydlB6eC9VUFVicWMzSURYY1hram9GQ0Mx?=
 =?utf-8?B?THRQTlROa1VGaXE2YmtTRUQ3bmdMSVVWd1lucE56dmpRQ3FSeitkL3AyV1dm?=
 =?utf-8?B?OE4zVE0xZDNtSjYzNUxFUUFUeG1UU3ZsMjJ3SXUxS0lqT0VuVlJyeWlROTJY?=
 =?utf-8?B?MGs2UjM1MEJyWEhGNXZBTmZGWmNWY1ordWZSREtJNkhCQkxYaXc5aUNhaHlp?=
 =?utf-8?B?UlU1UXdnWkN0UGp2K29tMytVMHNjWnk2dlpiRklxSXllOGUxcmN2MkhlOWhv?=
 =?utf-8?B?OXhmTVJZdDRaOWJ1cFBOTWtKNzZxM21FTUJrV0cvM1lzMStSQW5JN3pNdVRT?=
 =?utf-8?B?MmI1Vm0zckpHSDNZMGtFTjFPVXludUxyYW1mSnUzVENMMUtrUGttNGg0eHBl?=
 =?utf-8?B?OVlMWE9ROTRqczRtZlFLYXV3SHFaTWFjRzJpOGs0QjQ2V2FDaWtCeGJJV1la?=
 =?utf-8?B?WEdrNG9NN3o3S3k5OHF2T21nQkltd29ZSG1kY0diSzdUMmJSdkVDWkw4Wkh3?=
 =?utf-8?B?NEhKL0ZMcHZjWVN2RFEyWEJ4ZUtzZTRtYmhKL3YrRW1WUUdBT2lPekVnbmpv?=
 =?utf-8?B?ckt3TURoRjMwczVhTko2YUs5d1NmRm5KdGVNYThqaW4rTnBCeVhlR2NKWTZ1?=
 =?utf-8?B?VW9maVZFd2t2dkFyRkRpQnpQSHlyVmN4RlZudUxVdUZoZkpYV3M1ak4yVFYx?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f894a30-b19d-429e-387d-08ddd98529dc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:46:51.5058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+H12ndBqnYFuKT/Ect73fVjAEKkdnI3Lbo03LaJJfXYfJkll0yXLQDz6qBEJ1z0BWRTEb9654qqXfJwHS3lavoYd8ghx2X67UhtI+E7TQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> From: Gabor Juhos <j4g8y7@gmail.com>
> 
> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
> logic") the spinand_write_page() function ignores the errors returned
> by spinand_wait(). Change the code to propagate those up to the stack
> as it was done before the offending change.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3d1f08b032dc ("mtd: spinand: Use the external ECC engine logic")

Not sure, but I think you should drop the "Cc: stable@vger.kernel.org"
and "Fixes" tag here, as this is probably only relevant to the kernel,
but not U-Boot.

> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

You should add your SoB tag here as you are the one porting the change
to the U-Boot tree.

> ---
>  drivers/mtd/nand/spi/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index daf6efb87d8..3e21a06dd0f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
>  			   SPINAND_WRITE_INITIAL_DELAY_US,
>  			   SPINAND_WRITE_POLL_DELAY_US,
>  			   &status);
> -	if (!ret && (status & STATUS_PROG_FAILED))
> +	if (ret)
> +		return ret;
> +
> +	if (status & STATUS_PROG_FAILED)
>  		return -EIO;
>  
>  	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);



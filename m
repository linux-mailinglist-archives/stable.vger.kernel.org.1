Return-Path: <stable+bounces-179004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAA7B49EF9
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABDA4E057F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CB223BD1B;
	Tue,  9 Sep 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ScrUz5N2"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECEF19E97A;
	Tue,  9 Sep 2025 02:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383871; cv=fail; b=KUg0Dyj9h+sR4nINM8UnVDEkeHnoqU1pyOpBR4Eo/WWmFO5BCKf90N3mIUZiqLXmOnSoxIdvrN7m2c8qy71DtFtwQP4MiNYJCTMVFRIRJLQOr4RHEkfe4u0GLreXlE9CH0Pu2oWCCKuVZZz1g1KGT+3SCylHP3FKH2cYveIK7Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383871; c=relaxed/simple;
	bh=MUeYy4h/sPe3cLwnOEh3zZWkmTI0ZMzzF2ZYdvTCDqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bQ8uxt+cVgfbJiXrhaQaO93wU4XD33AUToTJoqmlSXIlM5Bo1xygSd54GiqyYUaWWf+icmiv6kK176rKFbPOgTQ2nEQvG0kEPGyDfKWq4ZZqF7zWd/p2eqRHrXmow0OaMEnyhp/+1LdkFUnV3+6X6mIwR1/EgDpBYtFnCege3ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ScrUz5N2; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=caJHIyT60sDTAH0CsDXOFLVqj+FEhdTI5bsQZGAFGBTmwf5Vp+P/yxm+69wOmgEVvqUELL9Hpg7rAXeEmmpzARg1ta1SYsTUaBAhmYqjk74i4Lfvt7LKBAidkuabA+IpIB0++QkKzQzvoMYeRdMH4B9p4rKCti0H/8BvcoMHSY2O2MW20ERKLX4QNfJGOGOuCVV1dU+AGGL7KnRYOzN02dIM5yP6pzYV9romZVxq2lS4IZVPzwwsysQvIKSZhtvnce9e2Ln0Z8A6dckNWC1YQKzqAGB3EcnEVtUApdbeDG8KL1PVKHzW8gm58NK+gkk0kib5iBJ5CNdek6R0V8NM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDyruwuDbFxJvYdlj0puBxVcXM9UPMmrERS3K3DtlNw=;
 b=fwo0N2hHwBxyZrhHyIi6nVZsfXaTUF2ixht8443FFRWua9ZUFinkH6ij2H6SAX3gdLtUm74YbA0SHCHEIbcx2nNS+L3j4/83v8l/4h0owRnorEvI3+i2rJs2Uz3V1NZtUvaSt0KmnDVJChPT1av0E7U2fN1+IOIzjQ0DQrlgNtFjmRQ5UVsA+mqJvyRacHc2maIsEz46GLSLhgjGuWAQC7+UlXy5T6kgqNzFuqKtWNQ+3dsOXphHSnBtwcFwR+BB+qTK9btWpnDcDqGpAZeT8jpwF2eASgqfQCnCb1KTt5BX3LQmDHPge93lFff7hZBNmrfk8RKmS7eeeH4m/vkHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDyruwuDbFxJvYdlj0puBxVcXM9UPMmrERS3K3DtlNw=;
 b=ScrUz5N2hUC3XuPDfiI9ElXcRtvViatkHupz9ox63MWZCT149+fLsSbsaKdwoOavDz0KQyq8OmyEr2fZ37eG/Hk4aGTx8jBQpxwbu2LL2yXaYfrhJ3SNoHYvWXn0fI+7xW+GpGkUS2hKGLWGq0R/N0uSEKm/s+dsGbjCzuk6J5BEFpE9w/XAG5vrzAyeSX/eXLn5HLTPkNoIIzI5mPZmTVnn+q5rpX9yCgHBPDQ4Gouqr3vge6kGUZsA/3JSawKflg6eNXmkyVAWTK5ju2z+v0VQMah3hfWVfktuYDhfjgv/erOeyickE3ogJiGcs0hsr0uJ18XTxgN5CSFvkAoBkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VE1PR04MB7424.eurprd04.prod.outlook.com (2603:10a6:800:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 02:11:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:11:03 +0000
Date: Tue, 9 Sep 2025 10:05:05 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>, stable@vger.kernel.org, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	Russell King <linux@armlinux.org.uk>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <ebklwvw6mttgrj6srez7dh52elem5xohgm4t6vqai3hq2hbzeq@y6mhzhkfqkva>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908112619.2900723-1-o.rempel@pengutronix.de>
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VE1PR04MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2283f368-737c-4b23-bcbe-08ddef4620a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mk5Qc2ZJUDB6VzdwUkZhTHpxdkM2STZzOTFZa2dIVFNnQm9rd3FJdnFsSGZa?=
 =?utf-8?B?eTYyTHE4d0dseXgvcFg3cmxvMzdsejdxUjM4UVgxckxuOE4wZ2JwZ1pRU1pv?=
 =?utf-8?B?UWJrZDVtd0VJZGNMbm1IZ3EyaGxXQjJkR0NzUWtyNVBuVHdvT05Fam9Fb2M2?=
 =?utf-8?B?YnZaVWE2QWRTUTM5MUxuM1NOUEtLUU1YbHpyS1RBTWdkTXNwQjFaTXlyUW5x?=
 =?utf-8?B?RVM0cEhiWUVHTE5MQ1hmeEw1a2lqaHJsaUVFeTlzWmtBWXZEVnAvQzMxeVJl?=
 =?utf-8?B?aVNRajl6bmQxWDBlY2JZSytJVW9CS0JNNzd4M2VocXF1S2ZkUEpVdVcwRHVI?=
 =?utf-8?B?ektPSUluYVpQSitXcndLaTVReTI5Q0ZOTzlRbmNPWDJNSlc4RCszMXhOQ1pM?=
 =?utf-8?B?OFhKaUhGVUhwN1pGVXhRMkNLREdXc3lLVmRWbEZ1QXhRVzhGTUN5ZlpDYXdS?=
 =?utf-8?B?QWRuQmFFMklFK2lWcjRSYTF4cXBER2NacStPeFRTU0RKZ0E5Y2J2KzFMdU81?=
 =?utf-8?B?aVB6MG5SM0syTisrdjhveHAxWitCRHVMSWljNVF1UkZoOWh4TGk4eHFEdDd2?=
 =?utf-8?B?K3AwNU5XdG95UzhYMVdCditjM2lxRFVsc2NLUmpBQWtjY0tEUWkwSUc3UVZK?=
 =?utf-8?B?RHU5aFN2QlJ4RnFDUzh3U0NjRWpDSnR3b1l1a1ltbjhwU2htOTVDUm45cU1L?=
 =?utf-8?B?dkltN1NZRnBQTzdwSWkvVDMrOUIweFRhRmQzdXZHY1lKbTRmaTU3S2RKUVh4?=
 =?utf-8?B?MVdxNkZMTWg4bFhXUEV4eVpzRWh5c08vS2ZGQzhhQlBUQTVmK2JrRmgvMWt2?=
 =?utf-8?B?NmFQNjhQRUZQWXlEMXRpbk1Uc3I0ejRyOXdOSkpKeURMOTlIajJBME4rM2xW?=
 =?utf-8?B?blp3U2dISVBQaVg1VEI4aGlpemFtMFppcVpCdE9mbzZGWDFKdnRaSUZiNGlZ?=
 =?utf-8?B?VndUaVUvTXByOE9KbXd4dis5YWRSY0Fjc2N0UVlaNGtCczk3QWNWbG9JRUtt?=
 =?utf-8?B?U0RnbWZEU3FvSXhNU1BkWTBiVVNmN0NIaEc4TlJwNStJZXBhVDZYZEFlblhM?=
 =?utf-8?B?SjVXblhTMityVGN4WGUzci9ZSDNZRnNVVElaY3VabDRjTDllcmdzL1RNL2dF?=
 =?utf-8?B?V2t0WHYwT1RmM1NVbmRxSStrcDlKY0grZkI1dWlxSStDcmdWSTZwMzBkSFRY?=
 =?utf-8?B?OGo1M2EzSUYzcC81bmI2T2JxU01hd0RsK0UwZlBTV1FmZFhKeHg4Q2V0bjkz?=
 =?utf-8?B?SDY2NThMUlUwb0hwOUhVV0NrSUxTLytIWHNwSVg2QU5PZUdiamJtdnFHUlBU?=
 =?utf-8?B?SUd5N29MWnpPL2xuSjVwYlc2T3dhU01qdmhMUU1jYS9IdUZTelFNMWlpa1Fl?=
 =?utf-8?B?TVVIdzNPWHIrNjVPM2RScmx2SHhQMW55VDd0TUhkbjY0ZVNPVmVwb0MvRDJ5?=
 =?utf-8?B?VHU0QjdoRVVzbVY0L0h5MjM2T1JpazRWYTY2emNnakoyanBvQzRCZFphYTVR?=
 =?utf-8?B?cHVQODZIaytWdEFYaDh0dWxQMVJiaUhwQ21TcElReHkxb3B2WlZLK0tzWkF6?=
 =?utf-8?B?QXJzSDVzcmZXcTY5RGptMzdFNlF0Q2w2WHJSOGVNU2pqb1ZQNjJhSWRRdnpS?=
 =?utf-8?B?SlZiQTJOWWRETnJIYy83UGI2ejJ0TnZXdktMSkZBdFlWeTVYUkN4V21oWGlx?=
 =?utf-8?B?NWRlUG1RNzJjTk92bjUxRmRSMjdJMkJIQkE3aFhQUndFZzVmaGRMektkS1Nj?=
 =?utf-8?B?czFpeWoyQWFnV25nSGgrNWFZY0lpTm1hZEJ4MzZkcTZmNGNzVXdHZXlLK3Uy?=
 =?utf-8?B?K1NtdXFBNGw2Tll2ZlE1UUY5VXZqaDV4Y20rbEpBenhUdFczQXo4VGhORjlr?=
 =?utf-8?B?UUtudHd3YitQbmxWUXRSRjk0c1lkL3YxYXh1bG9wYkxVZ0VEVDdHcFhiNmI4?=
 =?utf-8?B?N21CNUhWNUtRTGp3d2duVTVKYnJCczkzbjFvUE92eHVKWHJMVXZWYzB3eis1?=
 =?utf-8?Q?R7PYM/tM3jYmDYx0R/Jp5Gw1/AxH0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHo2cVE1STNhaVBiVjhoeHlFaTR6eFl0RENSMEhjL01PY3R5dDJ3NlJXc201?=
 =?utf-8?B?YmRCVWpLRHdYZkJRT0hpSTBtdzlySTRJcEpQL3JhLzhmdGF0Y2ZZV1lYYm1Y?=
 =?utf-8?B?RnBNbGNMZVJrcmVDdENLZ2tGSEs0WHc2Rkh0bDFnV3QzL0ZzZkpUYVZZLy9v?=
 =?utf-8?B?bDdlZ0dFb1puWklYMVg4QzI3azVJVStwQ0NTM2VDVThpamh6eEFqakM3NkRu?=
 =?utf-8?B?NEo5bTVISVo2R1FMNit2WXo3S0FhcHY0bGY1aHEwMm9WaEtxOFZhZjY5N0Np?=
 =?utf-8?B?eTFKSFpFWjB3MlVQUzlod1BMOGp3ODF0ZmFTSUJzWU10NHJRWHpYQXl5MXRG?=
 =?utf-8?B?L09PNTduV3Z0M0krRmRURjBTTXhYZkhuVFg1dDNxRDFqTm5hN2MrNzB5NE1M?=
 =?utf-8?B?dWhxWVhaZ08wRXNJWVhhbXVheXNPTXlQeTU1U0djb0RGdDJneDFCZ1dkTWw2?=
 =?utf-8?B?Z3BNY1FGUmpRK1NIOXFvT0tWcjR4Q2hUSU9XRHRnSXU5ekFWZzNzSUo5THVm?=
 =?utf-8?B?bHNwMVJZZTdvTjB2Mlg1djg0bWp0U2Q4dDdCN3hxazVoMDlzNFZtNC9pOFlv?=
 =?utf-8?B?dHd0QnFidXpQdE5BV0RPejVzZHloOU0rRWRzT0ptYTd1RDR1SE9zaVdUdEV6?=
 =?utf-8?B?bFZWQ0J3aG4vVXNqY1dUUlRPRU1lbEVFYlNlZWl5STdnR0s0aDhsNWJQKzRr?=
 =?utf-8?B?R3R3aDNVWGE5a3pBb2YrNFM3Sy8wQVJSK2Z4RSt2MWFIWWJhOWRncURWUlhR?=
 =?utf-8?B?cGRrVXJqV0poekFWVnVjRFhnSDlGUnRVaDN6TkxPaDVUcGxlK2VmWGZzWDZN?=
 =?utf-8?B?SmNPekg5U1ZGYks0RDYrRzNaKzQ3MU0yR2hYTGZQTXlUUmtHRmlvOGxvWHFY?=
 =?utf-8?B?bTVtaHhkd2s2V2VER0pQM3JJWENsT3ljOWR1d2w0L3dOUTY1WHJ6SVZyQVRI?=
 =?utf-8?B?aXpoRXNZK0xFeHFuR0h2WlRsNEI2OVRvL08ySEpWM0JjMWtLSGtsd1VRbWx5?=
 =?utf-8?B?OWREZUFTTW50RDROd3hYTWtoczZ5MjVZZG9HVGNuQTJJNW1HaDZ4cFh5Mm5X?=
 =?utf-8?B?N0U2bmM5cVlHeEJvZFE2bWFwV1YvK20rdzZPTEFmalp1cFFmbkZVZmloUHg3?=
 =?utf-8?B?V2hNemJQZU82c2NuY1daQnQwamtDa0hQZzcvbGt5czFlKzVJYkVidDN2WElH?=
 =?utf-8?B?d2xlYVUrRmFLTCs2NGI2d254UnF4VWZGQ1RpdFlBbVBHSStGSnQ2NEFhZlZp?=
 =?utf-8?B?YVk2NjBhcHFrQVFFWmN1VFhSQzB3RXBWSkI1TmRLMENxclo5aVpkQ0ZEZkdy?=
 =?utf-8?B?Q29jK0VxQmNubTU4M25WcEJkSkVZRGlzcVp3ZTYwUWx4aFpUSG9YTjFWM3JH?=
 =?utf-8?B?bUk1YW5FQVRyWm03anJzb1JLNFBjeEpjUnc3aHdYcTJYUU03TkFCY3g0bVl0?=
 =?utf-8?B?TG9sajZMN3h1WVZkYUt3OXZFTW9CMkFvK0QvU0N1NHp6QjRPa2djZHc3QkpO?=
 =?utf-8?B?ZXJWVUVzLzFhdVQ4dUJtaWdtcHVNUzRlSDJJaThuYXlMV2d2T1hhZzM4dWNU?=
 =?utf-8?B?NVhPTG8yZnVickdnbjAyY0NxUW9RODZFdnFRMGcwMXFxcmMzZm5MbzcrUWZW?=
 =?utf-8?B?SVJFaDNhRVRDM3ZGNXF5WVp3Z0ZYRzd4czVaVGI1RkxISXo1dndvOC9EVzA4?=
 =?utf-8?B?NGxiWmpodVFVLzhFeWwrRllGVVRISnFvcXJBa29RRXdRNFpYQ0t4ZHZESi9m?=
 =?utf-8?B?bGNoV1l4UmZ2cDNWRFVNTFZkUHZvekwvM1QvSjJtL3p4Ly9RdGF6R0lDU09S?=
 =?utf-8?B?K1ljQVVTVUdjM2VRUnplTUNhTmMrNnZXME9NYXNHRnk4MnNtR05HeXFITzIw?=
 =?utf-8?B?dzVFdlRtd3o2WlZ6TUdTVFZ4RUxTV3phK3JYTmdCTms1VU9vSHBMbHlUcWw0?=
 =?utf-8?B?SXFBL1d2VkZkU014citpd0xYczhKNUhWaWtOSEJWcmtGM3puUnhDeGVuL1VQ?=
 =?utf-8?B?dUpGaGcxT3M2VkdRYncxMlBaVTVFNVA2Z2hHVGJNc2gyQzFlZExDSW1OcnJS?=
 =?utf-8?B?TUE1WlgzcUVRQVVlNUJ4dDBEYWhCb3RXcjd6NnBJd1FrSmFwTURaTHBBU293?=
 =?utf-8?Q?PfywDi4cOEYHOaBJzfKxrAySv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2283f368-737c-4b23-bcbe-08ddef4620a2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 02:11:03.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYT9w5E2TVOcHUER4PvhMitQqQoo2H2j7QaAqTgsj609kg3BlXF0g+RIKJdP4Xo4nbWjWM4l0Aaz9hZxX4F5yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7424

On Mon, Sep 08, 2025 at 01:26:19PM +0200, Oleksij Rempel wrote:
> Drop phylink_{suspend,resume}() from ax88772 PM callbacks.
> 
> MDIO bus accesses have their own runtime-PM handling and will try to
> wake the device if it is suspended. Such wake attempts must not happen
> from PM callbacks while the device PM lock is held. Since phylink
> {sus|re}sume may trigger MDIO, it must not be called in PM context.
> 
> No extra phylink PM handling is required for this driver:
> - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.
> - ethtool/phylib entry points run in process context, not PM.
> - phylink MAC ops program the MAC on link changes after resume.

I just meet the same issue. It fix the issue for me!

Tested-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang

> 
> Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> Reported-by: Hubert Wiśniewski <hubert.wisniewski.25632@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/asix_devices.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 792ddda1ad49..1e8f7089f5e8 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -607,15 +607,8 @@ static const struct net_device_ops ax88772_netdev_ops = {
> 
>  static void ax88772_suspend(struct usbnet *dev)
>  {
> -	struct asix_common_private *priv = dev->driver_priv;
>  	u16 medium;
> 
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_suspend(priv->phylink, false);
> -		rtnl_unlock();
> -	}
> -
>  	/* Stop MAC operation */
>  	medium = asix_read_medium_status(dev, 1);
>  	medium &= ~AX_MEDIUM_RE;
> @@ -644,12 +637,6 @@ static void ax88772_resume(struct usbnet *dev)
>  	for (i = 0; i < 3; i++)
>  		if (!priv->reset(dev, 1))
>  			break;
> -
> -	if (netif_running(dev->net)) {
> -		rtnl_lock();
> -		phylink_resume(priv->phylink);
> -		rtnl_unlock();
> -	}
>  }
> 
>  static int asix_resume(struct usb_interface *intf)
> --
> 2.47.3
> 


Return-Path: <stable+bounces-230791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFnKFhbrx2nQewUAu9opvQ
	(envelope-from <stable+bounces-230791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 15:52:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0192634EB98
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 15:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30483300D746
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C303933D4F2;
	Sat, 28 Mar 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ppv60R6t"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9233F8C1;
	Sat, 28 Mar 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774709512; cv=fail; b=JukysjtE68IKMEGVNebwDf+TpNnizDyWYJNc0EqqJCdfI5kIbiSBQa0gybGBXXX4xkAJ6gZq/AsCxnFyBeLWYGtn455+g944ByFG6/yX61p9SZaWCgeJnVue1z99/i7ZkJ+/mf2MuEnmex/iIcHGSArPaeklkidOV7dyjO7gSU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774709512; c=relaxed/simple;
	bh=I/obI7rxkYkUgxotp4gBaOHHPB+l5pLSATYFMpTBVUs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fwip+njmG0u1TRE9RJqIa8prI4RBYpoWGzxdow8VNvt5GmUS5VygoBNDHOJm+LlobX9lbCVBoBrdg6IytvAyc0Fo5Xv+jV7LuevYtDQOsE/O9M3kU5+kmwCvCVmgPw1AkIYUzIUNC4LfhoJA0friwksvPoxu6h5mqDirhKbe/S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ppv60R6t; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhFdQ9cu0Pa5VUJEzG9TWF+bH6dBSq+0btU322LOAQDz9jB/gFqC0iAyQdjdD2OWs8IdIK4TROjYev5ZDk1EoFfokFG955agCZYv+1F3oFudKk69dClulhksOT/MuzSpU8tCyp91C8Pm9fATUqOY62x7k0Lno5X6SBfzmV45Jh7DGhwsSRnsYv2iu2+GtwdVecooDvg+x9YVa7ss9Q4Yul2WaZSql3Fq7p1tvLfXQXutT82wtrYSpUKeKEG3HYAWgI5muS2VenqUvVhFI3hyGkKi3lcBHtqi2uCl0LUeWhJbDoyuKept07BY0N/wlqhylWn2CM7flyK5csNwJfWhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/obI7rxkYkUgxotp4gBaOHHPB+l5pLSATYFMpTBVUs=;
 b=n4bikQsqTDALv2r22YWCeSlDxdtkO4sMYFeX+uTJscrxLaOnm7QzyVIs4hFxk2fUhNfVC5t9422UPe4KFrliI4g0RFNN4hePLEqPlT34nNwiUw0KbezoTH4AjiSp7GyI8o/n7TgANjsspd73JzcHZYJfraXl9jN96koH514nqiLgJtyuzTEfw4D6ewbuIfYKHSiLV34NyZJlWE6z6oDaAzmgeVoTw+tZp0NwALbGbXqnVVSIiLOy1FB8vqT74mwt2RrvXTqfZmk7Mnj2HoLd0VFeaRIKXBXkfzEPS1mJTH+qB68prqdXR6gZA1BzwJp59I5uOWF9/PnFbKYO3JI7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/obI7rxkYkUgxotp4gBaOHHPB+l5pLSATYFMpTBVUs=;
 b=Ppv60R6tSiRHJn9buECvmBl9pkHlFSaqieGdWnU1790l/YnMSVuJ51uK6tWMJ2lVoIHB/gEl1QIBtKodPNes6UOrblJ2MzC9XJ4XDUNaMI9h41tsZRdb8RxWMOpys08zomK1K6LqPXw89KvGumGwCbVl+9znN9o3If7WDfOyMSTOyCS7TfEvQyeZnQgp1v50eDDk+7Q8FCXJ8qsJCJ1hAvoFOlDEPeHPuLeFiPpRJ+3cIEOem+dQ3zn2QX7gDHpplyj75pl5lli/d/KUkUXJCU1oWulPIchfSUC7HUIcn+ltwWCfnB99ArYTmyUQkA4UANmg+PhOsv6ts62pwORxTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Sat, 28 Mar
 2026 14:51:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Sat, 28 Mar 2026
 14:51:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Mar 2026 23:51:40 +0900
Message-Id: <DHEI0HCIIWBG.3GOZM9R8EFT5X@nvidia.com>
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from
 public attrs
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260321172749.592387-1-dakr@kernel.org>
In-Reply-To: <20260321172749.592387-1-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:370::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 76acfae1-5e91-4fc0-7a67-08de8cd98718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w5gTt9yo9QTR5uvUp45ah+nD/DMThvQf+Em5+Luz0yFZTcFNPnYyVJHnGWYU46cd845CvHlwIbpsCaEdnk1qMbOs3ZOQTiGth1LIysrVtcu2aExx3ojgMgKE/lTL32uDTTbnnSm1kOOTVGyyJHl2vaubC+y7+Rxx4i2FkJF6tfLG1pgdnHetNv/FbRGS3vNwmAqdd2Vi+CzWAnedauItkEbRyhpwLfLunR/BSTEuhDv45Ecbf5MmheATZfRC9btPSNOL2QSaHISTsUkzGThnBCLZ2fogJUKYjQvnXO5YTM4nsSRlxdLMyZTIE2B0kTuE28RuUPisfAFdzRAjqs6ukIfytx7x1DQEvwA2/3ml8BhK5hlnmRVcVzUPlM/WKAJ5yd4HsEhbn5wj79TJXq34s/yBTjjyTUQFuHfJChF2DWbjDIjUF2Z42wiRsAsn48xlk2wcid3c0tt5oh8gv5NUrO7/fyHj3i2gDWr7gpNoDIPyS1YhnNjWAPpZVvQLPxt9YZtDCm2PkvCPyjC5R0MLNBd9oUNYDxGeFT13AUe87hzw47yhOtGGgn1dAGHk07D5MY0jvR6m5BahCLd1yuVlTiQR0O6pF6XfUa4rqftfiZHr5VV236u3kyCo3AcNc0vsk73utKqCJa//U1DTmCD1yt5PzMlIAe9suwzOu0dpsCl9OdQ0vuDHoGRKkzAnTFqrQHRU7YYW99C9LlfCi2mrQMO1QIKCwmxeVNgLbuQG7RI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdTcmdhREdSMWNkWVV3MC9sNVlnS3hhZWUzNDE1a1RGSlhYeEJiMWQ3UE9Y?=
 =?utf-8?B?cEtXZ3NCWDYwWDAwZ1RtcjE5MDJCWnhwM1ZONFdncnBWRjBiY29NamdCSXhF?=
 =?utf-8?B?UVE3czZ5NlFGWEo0Ti8vVmVJaFI2RmtxaHhjalFVMmpDK2dHS2RWeWxiN3hE?=
 =?utf-8?B?QzlZQW1uemE2SzZlbHNoY0poN21aWjNlRmEzOFFEd3lrSzU3QzQ1QUhPYnBY?=
 =?utf-8?B?UlJDZWsrL2drdnR2VzZVYnZGd3dEUVBBRGVIaFkvUW9Rd0g2SDlnWXprbFBI?=
 =?utf-8?B?QVVibkduOVc2d0hmTW8vSUxiMlBJTVF3aDhhL1JpblNHa3FKRXNJeTRQdDJs?=
 =?utf-8?B?UzB6NG9XREMrVXgvWkNyM1orUVJ2Smh4dEJPZFp6OURCQVRhLzJlWVBRTjBx?=
 =?utf-8?B?NlBEVnpZU2g0UFh5eHlIbFpmODBGUjRsTkRtazlFc2JDRVlQVnVNcHV0T0cz?=
 =?utf-8?B?V3BTUnFQQWtUNnh0aElmY1UwTi8vdFNsN3Z0MG1vZVI2SU5IRUU1QTVabkN6?=
 =?utf-8?B?aU5zTnUvQW1lakJHOWhmY1JFVTV5dHVwdUozMllHVXR2NVg1UlZPVmVQYTBO?=
 =?utf-8?B?dG9RdnhyWWtkQXBRSkN5QUdNUzVoVXV3aTR3b1RLYUhKUGM4VG9VcUVsdnBZ?=
 =?utf-8?B?OEVzanNwQ1h4VjlsVjhDUTFrMjI0WHd3VEVIamxQQ3F2bHBBa3A3M3NNN09y?=
 =?utf-8?B?WVF5QlQzR2VBaStsWFB3WjcwLzdueER1ODc5SUtKUXF0UzNNcVhnRFFRT24v?=
 =?utf-8?B?KzdQVkFhQXJneG1CVTFvRVVjMWxWbDFnSW1NUDlBMEUyWU0rb3FDUmtnWTNJ?=
 =?utf-8?B?VEVmT242NUpYQStUcTllQm5JcFJnNFYyNE13cHE1djR2aG5pZGNyZktZUUdM?=
 =?utf-8?B?emtBODN0UC9NT1U5MXFjSWRLQm5pa1l4TkVGR2ZEM0NWdFNTVnB0RzAzMjlO?=
 =?utf-8?B?eWlaazh5VEtCSllZcllMcTNVZUtxWDRJaTdVQXZtSTFSUXIxWmFZbnB3WU10?=
 =?utf-8?B?T3RvRHNBa2srUkhuZnlKa0RLNHJVSWRLYWNhanAzbHpnSmg2Ui9POWdUUENi?=
 =?utf-8?B?NFhCQ0Y2WkZsakpMVmQxOVdCYVVRUk1tb0VhL01GYmRvUExrT1c5RUNlSFdI?=
 =?utf-8?B?RTNDQ0pHejlMdXRINWMvU3BkdXNZck1PekNRZy9ua2FRZk5XOEpWRUxFbThP?=
 =?utf-8?B?TitkNmtjR2ZpL0t4cVhBMVZVYWx5eGJ5NDUxTFNlcElIWXNxTjVvQnFkNWxm?=
 =?utf-8?B?N1QwMnczZVFuY3BOb2c0QisyUHM3cllFRlFWbXI5L3R1RHZ4VzBzMU9KWFZC?=
 =?utf-8?B?c3k2QmNqaXhadVRqeVJuSU9qQUNuS0MzTGdpbnoycmF2WlNLL0pkWmQ3eWJt?=
 =?utf-8?B?UFZLdkJiWUZjVVQwSlIva0hmOW8wQlRablhOM0ZiS0wwYlR2dldGQkVjTm9w?=
 =?utf-8?B?NERVOXJaaFBDV3IwZ1hrVjVQNjhqOXRJZ2RwZXJieGtiOHcxOEdrSDBCLzBD?=
 =?utf-8?B?NGRNL2FpblBzUEJDTnk4K3NqcFFJYnp2bC92OTZJckNvSkY0VnM3bndyK2FL?=
 =?utf-8?B?S2R2ZHIzaUREYjRIRmlYeDRTeDBiMkk0Rzl5NnIxZU5nNkhGTk1RSmplZzB0?=
 =?utf-8?B?Y2lXYWZhU2t6d1dERmw3ZkNEVHh3eXNxYVgwSGZBb2JFRHdkeDZjdWQ4RndF?=
 =?utf-8?B?bWdtNlVRUlVHSEs5TTJDa0pFekNtNTV6SkFkTDYwUFM3b0NRRHNVNWkyd1ZE?=
 =?utf-8?B?UzNrckRDMDFQOEFNbC9uUVNOQUZXUWF2OUFPNU9xUlNxWmk4NUtnQm40bFQv?=
 =?utf-8?B?NlRIcEMycHdScWJrcC9XbGRBdUJBN0xPdXlGZk9GYWMzWllaQm9ER0p2Z1BH?=
 =?utf-8?B?TWtaNFZGVzNzVm5LVFdqUWNJNHh5RkhjU3JZaE1jdE54QjAvSXZjK2k4Sjlk?=
 =?utf-8?B?dGo5SG9RT29JOC9TUXhWaG1OY1J6aDQxSSt5dDJxZisxTXpFWXZuYVBtTXVj?=
 =?utf-8?B?a2pwckthbWZ6U3p2SjF6U0dZcDNZdTdhZys3cDUrT1ZJSExweEZuQWhvV24y?=
 =?utf-8?B?Ym9uK2hMeFdFOGdoTGxjSmtvSENrVjhkOUltZFVtUFVoRUVJTEtuSXRURTVt?=
 =?utf-8?B?Q1pzSkk2M084VGl3TUZJMTBIR2kwRmhvQlhuMmx3Y3BqaWJDTHpNZzlLZnZx?=
 =?utf-8?B?YzlVdnp3Rng4RGE2ZHRZMVZrb3FOeVJValNNaGVIT0c4aWVnK1pmWnZRSEpW?=
 =?utf-8?B?WXRGL1NYcUNmVEFNS3FBNCtmaHRVbEtSU0ZSY2FCck0wbTlRYjBPZ0wyMUpw?=
 =?utf-8?B?aFpBKytoNlV0UldxcTZ6MTBvMjRFN2h4TVdFalMwY3orRjlVMC9jODBJQ1dG?=
 =?utf-8?Q?92BhY5ryK3vkxajLLPw6eSZWc3dyqxO3DQTQpd8whRKT5?=
X-MS-Exchange-AntiSpam-MessageData-1: f7pWUH5Wei02QQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76acfae1-5e91-4fc0-7a67-08de8cd98718
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 14:51:44.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uww4NqVyzr7a/Et/dcocLsGFs7qPKxkqtXRZ3CvUw65Cva18Xk1/FlVTWmDrkHEkNjOeB9Hw1g/WWG6yobZz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230791-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,arm.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0192634EB98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Mar 22, 2026 at 2:27 AM JST, Danilo Krummrich wrote:
> When DMA_ATTR_NO_KERNEL_MAPPING is passed to dma_alloc_attrs(), the
> returned CPU address is not a pointer to the allocated memory but an
> opaque handle (e.g. struct page *).
>
> Coherent<T> (or CoherentAllocation<T> respectively) stores this value as
> NonNull<T> and exposes methods that dereference it and even modify its
> contents.
>
> Remove the flag from the public attrs module such that drivers cannot
> pass it to Coherent<T> (or CoherentAllocation<T> respectively) in the
> first place.
>
> Instead DMA_ATTR_NO_KERNEL_MAPPING can be supported with an additional
> opaque type (e.g. CoherentHandle) which does not provide access to the
> allocated memory.
>
> Cc: stable@vger.kernel.org
> Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

As agreed with Danilo [1], pushed the series to drm-rust-next - thanks!

[1] https://lore.kernel.org/all/f7e39810-bcf2-419e-af2a-2ae0c4d5ab67@kernel=
.org/


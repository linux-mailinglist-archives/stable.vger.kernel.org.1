Return-Path: <stable+bounces-165739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92AB18228
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628E47B07BC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EAA247284;
	Fri,  1 Aug 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RF4hG/+D"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D923507A
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053627; cv=fail; b=EbTjvtw/wuTS+k0UAZXFVTT3QA2NNWx/zX/E6XLd6Jg8KgLPxNsFTc4IV/F7bSGDpWTYwm3BAU6kZDOxxY68tqWAvdnwqkbZBeOMTbhDjtHsUGC7orOfUDKmHXnqtK/1RdLuCLjnquSGlHRZJs6ahkALARtII2QIRfgZ4st0E8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053627; c=relaxed/simple;
	bh=y1urh1L3YkhJ03EA5yvdkArV+p/29QsNqNr0Y6GRna4=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTLEVvwFx+hef2ytLcPfBRR8Xs83NpbTLl/RbOlaf4HH2bgN8zLEPOgBxI/fkqiA5dHx6YNjusxoZXsbpP+2wpZknIYwvTivOJy+Irrp9m58R1GmUVa40+hGYWftO/EMz+lz0BHWeXcFn1gfXpOx8UlW0w4DQe1Z79by+Z0P+to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RF4hG/+D; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htiZxUMLYSFKZnbKqqFjJbp0j+XYDegXkKTz5R5vJdVAl9zTUznyab/dAPM6uUVsbPj7cSeRFh1aEAbPkLQ0XjGZa4kU9ovWnS86KJ+00UK8A4HBSOQ0DMvV4wjeWEzJl0/hx53bQ/cmFIalWk9xs1wFsP6fzYfXOUGY0Vj4AqA3vKtZ4PKhnGHh6SZEmPjIQJTURtp41iUICln/WQM7T90f3CTPt1mrx///jh0DHVNNXkTAQ+q86J2ToqbmYdCA/XOoJgjcNNEitFoxXDhXKYO5Lx4RzdKa9ZKW3A52ZGskQmxslx6p9yz0qBntTq0f+6zD0H51kz9MKjwwl989Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wModLj+/8IuY2QRLSmEaamhsD9kw2mMBd5KQA1M3Oo4=;
 b=TbgIY2S5RKbhHv+Xcj6gPG0j9RRS7JdUgGA+sGMWMYAUKMplYc+8wVCMMhc69ZhZaQwjEXmpkpLmbhiFrjKMapJzRgigUyxthGt4u+k1Wzkq2ot/buQAbNwA/0OKLr7Dmizm2Tt/+kC1RJyKgpToSQ7Rw+6KHKIzkEpVnTPZEYifJNbiJNHpqAEwWNr5VYUgX3NNmF1lmjmpgFdQt4D3AAk2DFcLt6gLkZ6AfP4WKcHPqLVPHG6K/oLVYhFiHJxx3eTW3y7DHHrHftJcLUBCi857ZDwu6AvKeytjo2AKp8x1c8C3KvKPVQ+x0IjQvFAOdQJ2YSz0F4/Y8AQSxzpokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wModLj+/8IuY2QRLSmEaamhsD9kw2mMBd5KQA1M3Oo4=;
 b=RF4hG/+DQEv0C9VHwpcNe8mUNywQRvAXH2vh6bzahIZkoVPiSN9AqBGfu/O8g+Wt008tY3VhPTRdcrsV54vJB3eX2yAiNTj8zK9AoGC4GwIoXrvQXU9vanNkddPBxMRxRUBM++57X9Enp0I88aPkdh6MSAO6huLNTgFT/7TikZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 13:07:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8989.017; Fri, 1 Aug 2025
 13:07:01 +0000
Message-ID: <3590cfd1-9d99-4781-bde5-0ace736b2158@amd.com>
Date: Fri, 1 Aug 2025 18:36:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Adjustments for pinctrl-amd debounce behavior
From: Mario Limonciello <mario.limonciello@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <9469816e-6ae8-476e-b154-28c78a79bac8@amd.com>
Content-Language: en-US
In-Reply-To: <9469816e-6ae8-476e-b154-28c78a79bac8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eb9ee5-85b3-41ef-0bab-08ddd0fc4d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUxJUXlxSkdPVy9MVEpRKzZtRmR3c05wQWFUN3Q2NlA0OVhFM2tMQmZ3M2dK?=
 =?utf-8?B?ZThpZmxHdGN6aXE2ZCthaDA4OW4wZmpJelVKeUluNXFVVEFaUEZHV2duSk5r?=
 =?utf-8?B?dkxUdGtFdWtkUGxqWURDMjQ3Q25SR3RMS3hlc2c5MXU4R1NUMHhyZDY5WGtG?=
 =?utf-8?B?VkhMQmh2Z2kyUnVwYzNuVXdxc2tGZU5PZmtuaEdJQk1zZS9aMXdmTTl4a2ti?=
 =?utf-8?B?ZVpibE1oR0tXdGwxRUpsb0t3RnpuamxtMlVFaXkwYjk3U2p6QnNZbDNFb0x6?=
 =?utf-8?B?cnIxbWFsWVJVbGJ3dUpIZ0lBSFFIUmVpdEwrSXA5NHJ4bGhuaWtTWCtQbTVG?=
 =?utf-8?B?cFdDRUVJUlNMVUhUazZBekRFcDBWc0o5bTRJYytGTzlZTlVXM2dUUGdWWHcy?=
 =?utf-8?B?c1R0ZUV5clJGdk11UmhIRUxXMmx3aTVVbjV5cDlQUTc3R09mckg0T1c0cmhm?=
 =?utf-8?B?cG1rTkFnQktnVCtpczFkSmlZSFVZMkJYZ1dKQUhBdEZwbUtMSXhvazFZSzBz?=
 =?utf-8?B?WU5KUjBmVDVBSHQ4Snp0cjAxSkdCZ0N1NUNuM0VlSW5NODdLQVV3OTAvSFBt?=
 =?utf-8?B?ZkZGWU12bm1renNnNS9QaFpZTTBqNXdldk1Bcjl2MlpMdHRwSGZ4UDNSdG8v?=
 =?utf-8?B?Snljd1hpa1oxMkRRQlhYZjJtdHNQQVQ1N0wvZjQvSVl2dHNoaFJsT05oQVFl?=
 =?utf-8?B?Y3BHR05ZMmhieWl5UTZrL3BnSmFiL0FSaDFOOXJWWm0vNTRUbWdRUHNaSytt?=
 =?utf-8?B?ZXNLYzI1NFIxUkJxOGJuVGtjRENwMWJWczdYR1NRdnBQTGpoSmtqLzhUVmFw?=
 =?utf-8?B?VHhMN2p4WktnQUIxcW9VZTVsZnBPVk5IckZUQlFBZ3lqM3lwUDFSZ1p5K0dh?=
 =?utf-8?B?R2Fvb2dsM2lNbSt2dDZoVW5BMng4c01aZlRzK09ZbHhoZGZmdUZxOFIzUnIw?=
 =?utf-8?B?bVRSaEQrQ0dYTFB2cDQ5cVFMMzlHK0lJcHdNb0EvUnNSTFpNcUpVTStYTTBI?=
 =?utf-8?B?OGNhS25jNHd3b21aQkxhZHFsOUdlM293Y0hEWlpYUXZJbWZQVHNxSUFISmVI?=
 =?utf-8?B?Z084TU1MYWJhQmFwNHFwNkJSUmpCR2pnOGUrZFcvQzBCbkRna2hOY3J4cVVK?=
 =?utf-8?B?Q2JSTEFXNk8xWExnTFpHMGMveWg0ZXZ2NWgzNlJqRFNnc0IzcWpNMlhoaVUv?=
 =?utf-8?B?dE5hNmphcnliUklrc3oydlFzYlh4Vi8zNFVXY0g5WG1xV3k0UEoxUHc1RkU4?=
 =?utf-8?B?ZWp0WUVac1BCWXh3c0tvdmtESXUxUnFWM2YxVHc2OXM2U1ZvMzRWbS9wWlpn?=
 =?utf-8?B?QVRNSFdDdzQ0L1NJaU9ka3E1Q0pibVhPak1OdWZlbnZMZmgwU25SQnhiNUZC?=
 =?utf-8?B?Y3EwVmRvNGJsU2Z0Y1kvMUxUNFRKcC9ZalhxbWZ5NXE3RFRPeXVUWVExQnln?=
 =?utf-8?B?VXoxWHhhM2VUS2tEd29yNk0wT0JweGgvYnVrd2ZRaU14cjNCK1JsVm5BOW5E?=
 =?utf-8?B?cDRkb2NwNHJGdGlPTkFJUXQyUUxaMzVYakNqSGJYc1NWNjFHV1ljaU1pOGNT?=
 =?utf-8?B?ZGhsRFZzWHRlK0tjZ2ZYeHl5VWxtY1ppYWdpK05qY3Y3VEovb3VIaVFzVndB?=
 =?utf-8?B?TVhOamlvRWhjNVZuMFRuZzdYWWZNU2lQeXFFbzBEOGRXc0k3aTBnekQ2eXEy?=
 =?utf-8?B?T0VrY2UxVWx0WFFJZjlzaE9XdkdGT0h5bXF1dDZNYVNWbGdXVStCMFVhdC9M?=
 =?utf-8?B?cUhZQXJjMFQycVE5RWFheCthbDFmWWZkS1E1TUxMakhJWjZTOW5zeE5tWkMv?=
 =?utf-8?B?N0RmY1I2UmJXZVhpWU9qSk5xcktGbjJTQWRpNms0dTRlYVdybWhFYW1neGJB?=
 =?utf-8?B?YWUyU3M0cUdUOGtXV05tbFY1TWg2KytJLzc5Vjk4SGJER1ZNV3YxVEJTelJt?=
 =?utf-8?Q?MFThrGu2lzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2ZrdEVDYmp6UjJHYmx1MlV1eFZtUWpSdm9hRWducklBeGlpeTJGdzdXa1N0?=
 =?utf-8?B?MWNWd0lSd0JCdU9lOTd6ZUVqamwyQUVNVk5KRjlyTFNuK2RoSGdJdDEzK2lt?=
 =?utf-8?B?MjV0eFhRZk50eW9UZkx4cE9vQTZ2aGxSNzVTSzdmT0VFTGgydytId3R1N1BR?=
 =?utf-8?B?bEl5R0NyZm1Ca1cwVC9ZcVhVOHhBSTdRaktJc21zM1ZmcmJTOEdxbWp5cHBY?=
 =?utf-8?B?Sm00cGNlNnIxRm1BZXVKRVB5VUR2QUNEdi82Z3FGUi9PRWtIc3k4TndEditq?=
 =?utf-8?B?MHEzYllYbGdMUTZsVHNGRlNvdEQvRXNwUVloVFBhT1h1MkN5Sk1BUVkzdFhy?=
 =?utf-8?B?eWNsUUNPUnkyMTJIRlBLVFpEYm4rSGJjRlZzZEZYdVhKWHJ4QVorSUhZK2xH?=
 =?utf-8?B?eDVBUHNlNTN4d0NVVUxvdGkzdFFuWWp2UlpITXVGb0Fhd0ZGbnYxYk9FQ0Nu?=
 =?utf-8?B?T0lnVEo0bWE3aE5kZW5PNGd4U3AxUjAzdE1Xa3lNMkFCZ2VOTWMyNkNaRUlR?=
 =?utf-8?B?d3RIZVRvbzkwQmpjbmVvUFViSDlUVndZTWhzb2JJNzloYkI4ZFBCL0pJcnAz?=
 =?utf-8?B?S0hXUHZrMElhdG16UXNqbS82bkJhRnFoMGpWLzM3Yi9vZXhuelYwUzlkZG83?=
 =?utf-8?B?QWNSUVRDUnNwTm1zcHlmaC93cVcvR0Zwa3FJMU5GL3FaM0hDaVR1dFM3WDdR?=
 =?utf-8?B?a2lKVkNQaTVpSUduZlMwa0lOei9ZQ0hvMXRQUE9CeXJTK2VtOFdKVUppOVp4?=
 =?utf-8?B?dlEzME53K3o4R0lLdHAwcmptM09HdnUzWjEwaS9vK0M4dTRXbkdvV2dESzlq?=
 =?utf-8?B?TDFueU93dVVKRDA2TW5Lemhuc1J6VURMdFpFYTVZN1ZtSlZIWjJ0dnNBMmVN?=
 =?utf-8?B?aDhPc3FtWk04bUJpSndnZ2tQVmpPWmtDSmdIYmtSSlZRTFg4b1Y5YVVhbDJK?=
 =?utf-8?B?TmVUZFF2STJrNFdmaVd5NnV0Q3NVQXVkNEJBQklVSVY2YXlEY0tRVG9ydDdB?=
 =?utf-8?B?UTdzY0lyZHRnSXVDWGFNVStmQmZocGJIL1NjMG1Vempxc1VNYTZ1cDBURDBY?=
 =?utf-8?B?QjcySWYrSzN3QXhnV3VBYjYzK3UzUmxOT0pOUVgzUDdOQnA3eVI3SXpQWllx?=
 =?utf-8?B?VmFGZW5IZStwYnN2RkxOTHYvSWdQVmx4RUVOdkZCNUNjYm9zT2pYbE8yVmN4?=
 =?utf-8?B?bjd2N1BxcCttbHBxTHpLY1NMOHNPY0ZRZFUvN0hUbmpyQVVKbVhBdzZLYkZ1?=
 =?utf-8?B?TVRHZnhwek55N2ZEZzR4WDJJelVjOStPdUVTVXdmYWFEYjl0YWltR0pzQngy?=
 =?utf-8?B?Q202RHNsRVpESHozaFRWblU2OFUzQlIvS0FRZ1M0MkFYcXJGcm1keWh6aW1I?=
 =?utf-8?B?LzU5dytmK0NJMCtyY3pRNlM5OW5nQ3hEQWtMeHVTZVREcTVvb01mMFI3SC9V?=
 =?utf-8?B?ZmhCL3M1aHRKQ1FpVHQwM05XMWxPUnNKNUlzU3ZXTzd3Sm1sMFNKa1dON1hn?=
 =?utf-8?B?dTlLam1NNlpnZUliYXZIL0Q5b2svazFMcTZlME52dEpwdkFLZjhWRmhhOGpz?=
 =?utf-8?B?QUdpVllpVEs4Z0NBTFk5MUZDT0VnNll1RTlLSDBWQ3VtZU4wbjVQWldaWG5r?=
 =?utf-8?B?ME9oQVJlb3RuUHhJT1JtR0pCVUNoRURCM05ycWo4S2dQRFVrcWdDT0NXeHBY?=
 =?utf-8?B?bUZiUjI4YXVzZkIzSFVUVm1DQ1FpUXVoYzVhYjhKYmdMQUhmNytNMkwyajJZ?=
 =?utf-8?B?S1VDNU4xNEJva1hZenVmUFVibW9oTE50L0RRUlhuQnBTZ0owQjl6Y2h4ZnlR?=
 =?utf-8?B?S3ZvZDg3MHZFc0EzTjcxbVZIZ3pPVWtCd3N3S3A3TVE1c0s5S2p3NGNFRTNo?=
 =?utf-8?B?eFBJRVJqNWpXcGt2U3BzSW85WUlHS2x4VytEWjdySEVFMGh3RWNQMmZUK09h?=
 =?utf-8?B?MWRFODlWcWZtZnZtOEtadjlqK2tRQk1RaTg0QkVxcWY0R2dxdFJBU3ZvU2dN?=
 =?utf-8?B?UHRKVHBjNjR1YisyQTdtK3FDS3BtWTRvY0kvMERPVEF3THpQamF4RU11SUpx?=
 =?utf-8?B?MmFkQm1UOEFsZi95VGlpT0hINjNqa0Z1WlByczNxb3V4WWxvTHdLV29Uanhw?=
 =?utf-8?Q?ktlarfi42REil9ffx5JO+ASBn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eb9ee5-85b3-41ef-0bab-08ddd0fc4d6e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 13:07:01.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq2c5fMWuEH5QYYmBmiV8w/Cugn6gcySMKWBleyX+ZIF1HAbKfFUlUfTTcF0iJgBF14EWuCFC2UAFMN0CxbBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

On 8/1/2025 6:33 PM, Mario Limonciello wrote:
> Hi,
> 
> The issue that I originally fixed with
> 
> commit 8ff4fb276e23 ("pinctrl: amd: Clear GPIO debounce for suspend")
> 
> I have found out will be a problem on more platforms due to more designs 
> switching to power button controlled this way.
> 
> I think it would be a good idea to take it back to stable kernels.
> 
> Thanks!

Actually, I see that it already came to 6.15.7:

dce86a4d0d5b9e416b3787d624b711ffb3e03a52

So never mind!


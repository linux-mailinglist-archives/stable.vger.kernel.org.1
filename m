Return-Path: <stable+bounces-217502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJKPDdF2l2nVywIAu9opvQ
	(envelope-from <stable+bounces-217502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:47:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87C1626AF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021C6301E94E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDB53090C5;
	Thu, 19 Feb 2026 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snYK23jd"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357026D4F9;
	Thu, 19 Feb 2026 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534013; cv=fail; b=qjR7ji4kfU5VZAXKWzEhyWYdpfUjHtVyxuv7EKmCqzzK8t+hlPUGEjbUSiYZZVcF3v3MHGIWOh0CS+RQ8r7p0ennk/sqsImIUNmVafi7UYc9y8v37Cn7T6Jrq3/jaCL1EtDBBNeCqAavPrRfK4W4o9FZWn9FEQbKj05ZA7FcSrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534013; c=relaxed/simple;
	bh=dHBfBvbxnkPqG+UvOZKPCSqxc8tgC/rO08r/kbHmCmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryy/m8EZWMxx5Sd+K7k0BiwqvqFU7ZqzJ6ZkqN+NoJtBe435f1bCyl85vNyBrxLvqlUw2mqDXu/Nkyqx46V2vhumqOrSmzh5IOINLAxynQS+HlhYeMQTUQI+RZkqMM+utI62aU5zwp59/gCvQuNi+XujPWyvAMIttF7rB8bmrXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snYK23jd; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF8vtl+fiw5a85uzjmg01/38mQrY6D6M3m9x5D8LwDX0TW5VFSN0BOo8metCi1MAQJK/oVq5QSjC807Bduv4lBwXJnZ9ISci+9FXhE8Ing3u7g+X4Ia6zKrmi4S7JUl2bAc3UiocoEmQovUndCLnKqqloLtW/J7ogI/ol2UtKZe5JBPd12X+xLfW/x++fyspfSbj2VPuFCS0L5Q4kFk6t96UKy4NMKP+h+sOMAokN3RGuBV7XdWnQzAtMvWf2+tAoiDE+jGMpRXRe/IPP1LwHzDaxjObEHW5AGwwsANWazTv9J2rflqN3wQ0KyIxir2rvF6JYbyzSIeFkM+H5xqHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hR40OZrUhgq71sc7dvZkNpnGb7ZD/47kmWd/1SuBVU=;
 b=rNdo0V7xKSnMoxlOYkw0mWy7qB1jS2AT2x3pxF4xTAqsAT5TjcylyoXhh1lOd+81xamF6AOEk1m6kmivN/Xep1BCpkBEYouEupOu/R8rqp0yTfT6IchPnL3JYZn+ejgDi5+D+0vn9py03MiSNYIxGbt6H57rG2XgtI+a0nr9okVxiITYJ1qXPJgQ7gLKys2o5EqSmfN6DKURCERLC/j0VWnaRpjKI1pFb45fyT1G2j0DMaC3tOy2KEIBswKIICMcREN1pA6v5+9LO4EX0HfN3UYUeXXeNwjhlTClNNodJUaYt0yqO9xXodB0oxS7QT5LtqLSWwyaxwQ2uJuRaSoo1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hR40OZrUhgq71sc7dvZkNpnGb7ZD/47kmWd/1SuBVU=;
 b=snYK23jdrXrYfDYNLbkSNb+VyYzQ3krSuPcMCHy/H5f5X5wpXFIloY/iw01OsMOlMKUwUIGVB13L3l6zdM10g18Hn+Bp/xZaSzimT5qpetB4w5JHvEQyuoXSeayPzB+xK6Vtk8VLi+DzoH/McMu4tThHD6IPkygmU16hWspzUlvlS0byIydIlCMQCFHXMPQSfWXc4rUY5xYjOsuOLIueQo9GNClh5lHSqB+qyufxYnWGukAaP7sOGw1a+oOXLSBEWQYO5cYvKZvYOM+dIUaxQ8gzBguP5yT0PEBr6apIJLRHEQlWO/3l+q5moqiTfs2nXyF+Q+bRzT4/XCRccPDC/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 by PH7PR12MB7140.namprd12.prod.outlook.com (2603:10b6:510:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 20:46:42 +0000
Received: from CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f]) by CY3PR12MB9630.namprd12.prod.outlook.com
 ([fe80::cd62:8049:5d73:ae2f%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 20:46:42 +0000
Date: Thu, 19 Feb 2026 15:46:39 -0500
From: Penghe Geng <pgeng@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
Message-ID: <ofm4ponamkbjz3etc2rk2ufzcuu3s3uuglzcot4lgptdqqxphv@zemi642o3te3>
References: <20260115214648.168365-1-pgeng@nvidia.com>
 <39569ebb-d9a2-4f81-9abe-aec98f3c9f67@intel.com>
 <lxp6wsa6mgx3km54hpdqaeoe6gery54ad6ulc4k2futkmiod77@i5sutp3dpdjd>
 <2d04194d-ad91-4dbb-ba1e-4b8fb395c007@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d04194d-ad91-4dbb-ba1e-4b8fb395c007@intel.com>
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To CY3PR12MB9630.namprd12.prod.outlook.com
 (2603:10b6:930:101::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9630:EE_|PH7PR12MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: 1619f434-79cf-40b6-1ad5-08de6ff7fc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFp2QVBRVldtdjlWUDVJc2s5Z2xMdE5hQUpvZVVUZFR3cis2c3lyY08ra3Vw?=
 =?utf-8?B?WnU1UmpWNVZxL0RiczBFMXZaTVZydnNac1ZxQ0d6OEhEWlJvZUZlVm4xR0Zi?=
 =?utf-8?B?bFVGQmZMRTVhRzVOZW9iU1gwaDRpaFY2Y0Z1eHBuOVJ0WEV6R0dyRWw2d2p4?=
 =?utf-8?B?NWJFQ3NZT01WcnVlNk5JamV2NmQ3cGNrUzBNY0thTW9HRGx4Wmc1QUJrdGZP?=
 =?utf-8?B?VlhNNCtKY2o1NGNRTmM0VUh6OVoyb1RIb2tmb0tnNkZFczRJV1FuUzVFNWp5?=
 =?utf-8?B?ZjMrQXZ6V2k5L2hncWVCUS9ScE1WaFdVcWNwTWIycDBJanV6bzhLcHdpMUk4?=
 =?utf-8?B?ekZlY2hIem83eVlUNEsvQmU5NjFnZmIrYWx2ZDdyTmNKek1HRjZORkNhNllw?=
 =?utf-8?B?aUU0cDd4R2d1NzFKbW9mdU5qeXVOT3AvNWhrKzA4RmNETGsxTFh1b2k5MEd6?=
 =?utf-8?B?cTJHVm1IRmpNak5xbmpyblVsWi8zT1Y2Z0VqWW91VzhSb2ViUUJNc0FjUXFm?=
 =?utf-8?B?djErSERlM3E5bnkwam53aDhTS0pIQVdPZHFRUVBKTmlWd2dQUFVyTFNlUitl?=
 =?utf-8?B?aTFndnl2M3BHcW1DL0R5aU9NbUZyMFRsZVZKbEtGbmMyZUgrMnBwbVdWR3Fw?=
 =?utf-8?B?RUJXQ3pHRXVKVTQ2QmxpRUlBQ0FuU3d6OFI2c1AvQituNk5wSjREeDdjRVlh?=
 =?utf-8?B?MTNPVXZWMEJRYVlSN0hWZnZXZXQ2allOaTF6OWI3SlI1RnJjS1Q4NDE0MDRT?=
 =?utf-8?B?eng4WUNZT0kvZTU2Q2d1dno2VmtUMVA4dFdYQjZMcFJwRTd3RW1zcFprYWZP?=
 =?utf-8?B?c3U5eGkwdXNKelRYVkpxcWo2UjlTc1BCZU85L0VQR2FGRzU3MTh2VEhxaFRs?=
 =?utf-8?B?S2lkb3Y2VjM2ejNIWTJZV2UwRGhzZ0Y4R3hkZlhoOGhLN2tldmtjOVBzVGxr?=
 =?utf-8?B?RGlMU1cxTWFzQ2JVaVhlcm9sNUd5cUw2MWZhb0N4YWlXQjdvT2VkVW1tbjlW?=
 =?utf-8?B?VkVlT3doeHY2SThMUGVlV2MzZXRvM1ZaRWZxc2N0NGQxVitPdWpSNUY0a1FQ?=
 =?utf-8?B?aXJOdjA4eXFMS3lYNnlPRjZ1NHc1Y1QrNVg5U2lPOWFvZVN1azhSWTBFSEhP?=
 =?utf-8?B?bWVwTWdWTGZEMlFOcUcrRTF4U0ZhRno1cHFEOTBSRHlwRmdkZVc2azlVMm94?=
 =?utf-8?B?QnRIdG5WYVUybGpYMzVqL3B6VVUwL1lBcWJNRlMzY25xUmxQcXJOKzgyVHRz?=
 =?utf-8?B?NUhqRXdjNmVUdDFSYi9OWjBMRGRMbGRQUGZjem8xak9LQ3RjRlB4dWxnOWRu?=
 =?utf-8?B?OTBnTUtPZmxXVDdzaDUzSTk3LzFPbkdLdEsyMXY0MUlwSGNPZkFzT0ZBVERO?=
 =?utf-8?B?K3lKYmhENHRKcHkxc0hCTmN1d0RjN0FISE56ZHhvYnFLczZMUkhPUHFiZEFm?=
 =?utf-8?B?eXhvMmJHNFNvTmZsK1NqbGhMNGx5aDVtbmtxRkEwZ3FzSU9hTjVROVlmOUZE?=
 =?utf-8?B?R0xlTnhVWE1hTHBUVFpvbDh6YlRIcHdGMGtpcjNqQXd1NEJ5MjlKbVE3Qytw?=
 =?utf-8?B?Q05UUDhKMC9GUC81SVVMWHlGZ1l6QlA3M0tPQXRmZHVYS0E4M0FueFNrWWIx?=
 =?utf-8?B?OC9VenBFd1EvbE42MHpmQnhwWVY0WTRZa01jV1A1eFk2OGF6ZW1qOEpVTGZ6?=
 =?utf-8?B?T0xmN3J3SEJsYU1rakxYWStkQVVNUlpVWUNoaVArSncxcnR6ZmpGOXdReWYw?=
 =?utf-8?B?YmpkQ1JlK1NobnVhL0sxcHI1cmEvWG9QRVRoSHlCWGVxTnJkN1QwYUJodzRX?=
 =?utf-8?B?RjBGVE9xNE8wbXQxcWlzaWdDdnZBZ2hrUUtEQ3FsZkJVL2Nqam1HM1BKMnhx?=
 =?utf-8?B?RlZvK1I1QkE4emlhbks4aWpSZXVoVjd4VmZtWDRlYzY3a1A3M3Y4N1Q0eDF0?=
 =?utf-8?B?U3NZd0hGUkU3N0ZNY0x3OW1ObDk4ME82bDNReEV6V0JWLzQvbWJUSjJCUVRM?=
 =?utf-8?B?bjZ2VXJpdFZaM29jMkY1TU8wUnJHNityNTdLNEhZNHpDQk5pRFFUTlFXTDBC?=
 =?utf-8?B?QU1zMUJaRE93bThmTzNrKzBmcHRKS1kxeGl4ekpjM1l0R1NBajlSb3I5TENC?=
 =?utf-8?Q?B1oU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR12MB9630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEtZU1ZZSkRxYTV5TW95dW5HWE1LTkI2eXJweDgzMjl0eFZBV2NKOHVQTTY4?=
 =?utf-8?B?V3hFRXAwNUY2dTIxNzN4bnNhcXMxNFpQbDZEdEdQMkV0TUpXQ0xtRTY5N2d6?=
 =?utf-8?B?Nzk5K0dINHIrS0Nzay8zN3JtSGkwVnBmVTB3cHMyZFpBbWgyK2J4cDlWNWFL?=
 =?utf-8?B?YXN0Zy85Q0gweDE3bHo2dXgxQmJMYmwvTDB6Y2FPenZpa0VJOCtKQVkxejM5?=
 =?utf-8?B?WDV2c3JhMkVzOHEwUmZ3YjBLeE1mVG42K0lNZ0FYbDhMSDFpWEErWEh3cS9r?=
 =?utf-8?B?aHZqSGhwQzdXRjMrSGN6RVVCcFZuMU5lN25Rekg4c1dCNzgvUkVQZmFLWXZ0?=
 =?utf-8?B?VWN3S1FINVFpOW9KZHpDZ3JobXVJYVN2YTB6a2doelhOUUYvcldETEVaK0JQ?=
 =?utf-8?B?M0hac1NoY21NcVNCUlRoMXJtRVF1UlppNURIYjhXc1hmQVllb2xiWm1nZ3RI?=
 =?utf-8?B?REZwYzI1YXUzdVdaS0U3blF5RjlrbjYyQXVSV1p6dDZsTlpYUHVPNXd5U1Z4?=
 =?utf-8?B?Vk4xZXVkdkpYcFFvMWtMUUpLNE5SdTEyVllNRTY2Q0lCZXE3NlljWm00UktE?=
 =?utf-8?B?Z0JKclIwNjdiWUhXZEtEcGkxdnFLRFBWdGdQUldQTTVFZEptdDh4OWhrZ2RI?=
 =?utf-8?B?d21LMVlEdTFTWU5lclJPMnBCZ3EwSVE4VktvMlRrdGV4VURYOEkwYlJXMW1T?=
 =?utf-8?B?cXUzQ2R4ZmZVRHg1bWFaVTBleGZlSFFBNlZRK1RmalFOQzErUjMzVnZCNHdk?=
 =?utf-8?B?SUhlckpKanhOcUJyNzZQSlRUcnFEOXZoWUF4eWJBNWM5ZlNmUGE2aHUvUHZR?=
 =?utf-8?B?WmpRU2FqUkhZNitSMjcrNk9tQUNPTjRYR2pUNEtzRDNUVkxRSjF3eC9SdE93?=
 =?utf-8?B?UmVCU094WitXK3F5ZDN2TlVQMzBDV0JUUjdNMS9HZDQrenZQTnZrZ2NKMlIr?=
 =?utf-8?B?Z3JXcURGVG85VVFMYjM2cU90SWdUcUxLUG01a1BDNlpYbU9pbExmazRoMTF2?=
 =?utf-8?B?b05CZ2FXakVzcVlzRWpGcWNkTnUzQ2J3N255dkRYSWRnMkhNbVlIV29Zdnl6?=
 =?utf-8?B?RWg0NDNBV05rcXlhRllET2UwSlY1WUtYK3ZwdHpIbkwybVc4RUhWN1FRK3Nn?=
 =?utf-8?B?L3pkN1plajZ0YmVxS2VmdG1lYVJRTFAwTkV5R01BalNJQlNvcmlKcm81c2R5?=
 =?utf-8?B?YWtwQU1BbzNkL2NLV3MzMVdXTHRRaDhDampablNSVms3ZWszalZFQW8vcmdR?=
 =?utf-8?B?M3RqV3dXMjczMlI2OXhmZ0VEaEVBWk5WeG1HbzFpTjYzY3VKZ0NHUGhhTmJX?=
 =?utf-8?B?NktQU2tWRkU2c0E3QWovWENza2lHcUdzdVo1d0tRTS9qRk9ZMVUweFpkUEFp?=
 =?utf-8?B?QllIczU4cVA0YWRoVXJiRjVaaVY3dVlxL1JtTmpZVlpZaXA3YVk4YzlWMDZH?=
 =?utf-8?B?d1JGZmNsRnRzR2dPMm1GV1FsRkdjOHdxN3lOek9oY2Jld0pqd3VoTHkwV3pt?=
 =?utf-8?B?djNhdmRaejRoSEJFZDc2VW11bFpnRW40c2ZtTkdxN3JVQTd4WnlWVEpGSnFr?=
 =?utf-8?B?eXBYSEUwNTRJR1ZkdnJUSUVtNXZ0dDZ0TGU3QzNwU0RkSHlRelNHWlVRZkJO?=
 =?utf-8?B?L1Nwb2M1RFpqUFEzSVdublc1TmttL1JBeWNrSXJwR2ZSYy9TRHU2TERIWk4w?=
 =?utf-8?B?QlNKak8xd3FqT0xVcXo4S1NXbkpoQko1ZUZCUjEyQWQrWFNucGREWHdvY1c1?=
 =?utf-8?B?c1JFMG9ldDR6YVZQWU9LQi9NYjlCMy8rMnVKM3phaFd5UGprQzE3WGYwUEts?=
 =?utf-8?B?U21XUUdCdW9RZ1pBWHlCUCtmMzJGRjR4NGo3a0l6dTN6bFRuTjRmUjU5Rlhx?=
 =?utf-8?B?ZnZpVDVrSU5TTzdJS3FxcU1KdTBwUHFTNkE0aXgrSUZzQVJ1ZFJzczNOYm04?=
 =?utf-8?B?azhpNkVUeWplcFdmRFhtajBnTi93RFVsTGdhNVhtK2FQUlQ2SlNZTVU3eFJP?=
 =?utf-8?B?RFVSZGFuMGREaDliY1N6aW5vNEk2UDN4QnJEK2c2V1NSMzJYdjk4UXc3Ymsw?=
 =?utf-8?B?K3ByT2d1Mnlrc1lYbnVkS0dKQXNHYlh1RnQwS3dxVE16RlZpQ2RkQnZ6OHVC?=
 =?utf-8?B?NFZvakQ3bnBiT0RzT3FGZ05QaXpMVmNOei91N1puNVRhN2E5bytZVGxXdWJy?=
 =?utf-8?B?cVNONG96T3BiN0ZZcE93Y3FhUkIxSnY3WHJlYjVycENCNWVxZWNXVUNjeUJV?=
 =?utf-8?B?YUpYYzJoT05Qa1oyRjkwWWM3WittcFl6YWx1KzhRYmVqMVpOeTdCNFVXZmhh?=
 =?utf-8?B?WC9kQk1GT2p0L0ROT1lYQkJGZDR0dUwwUHA1bVlFL3BtM2N5QksvQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1619f434-79cf-40b6-1ad5-08de6ff7fc8d
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 20:46:42.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk1LJO51JWzWV7x4ULat7utQbonprKIMVRYLkRG8GIG7/OUzflymDw+ZCkRo/PpWF6nB+a6Ckz/ocPRyJQN/0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217502-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pgeng@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 9F87C1626AF
X-Rspamd-Action: no action

Hi Adrian,

Apologies for the late reply, and thanks for the analysis. I’ve sent a
v2 patch that moves claimed and the retune control flags out of the
shared bitfield word, per your suggestion.

Patch subject:
[PATCH mmc v2] mmc: core: Avoid bitfield RMW for claim/retune flags

Thanks,
Penghe Geng

On Fri, Jan 30, 2026 at 12:44:52PM +0200, Adrian Hunter wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 30/01/2026 00:47, Penghe Geng wrote:
> >
> > Hi Adrian,
> >
> > Thanks for the feedback. Below are the details you asked for.
> >
> > Kernel versions:
> > - Seen on 5.15.120.bsk.business.6‑arm64 (custom tree).
> > - Also observed on 6.1.0‑11‑arm64 (Debian 6.1.38‑4).
> >
> > Media: eMMC
> > Controllers:
> > - BlueField‑2: Synopsys DesignWare MMC (drivers/mmc/host/dw_mmc-bluefield.c)
> > - BlueField‑3: Synopsys DWC MSHC (drivers/mmc/host/sdhci-of-dwcmshc.c in‑tree) and also with OOT sdhci-of-dwcmshc-bf3
> >
> > CQE:
> > - Not enabled at runtime. CONFIG_MMC_CQHCI=m.
> > - lsmod | grep cq is empty by default.
> > - modprobe cqhci loads with 0 users and no CQE/CQHCI enable
> >   messages in dmesg. So CQE is not in use by the active host.
> >
> > I/O errors:
> > - None observed around the WARN.
> >
> > Repro:
> > - Intermittent, mostly during boot under stress.
> > - Roughly 0.1–1% depending on distro/platform.
> >
> > Example stack (BF3, in-tree sdhci-of-dwcmshc):
> > ------------[ cut here ]------------
> > mmcblk0boot1: mmc0:0001 Y29128 31.9 MiB
> > WARNING: CPU: 8 PID: 240 at drivers/mmc/core/core.c:349 mmc_start_request+0xb4/0xc4
> > Modules linked in: crc16(E) mbcache(E) jbd2(E) nvme_tcp(OE) nvme_rdma(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_core(OE) nvme_fabrics(OE) configfs(E) nls_ascii(E) nls_cp437(E) nls_cp850(E) msdos(E) efivarfs(E) nvme(OE) nvme_core(OE) virtio_net(E) net_failover(E) virtio_console(E) failover(E) mlxbf_tmfifo(OE) mlx_compat(OE) virtio(E) t10_pi(E) sbsa_gwdt(E) mlxbf_bootctl(OE) sdhci_of_dwcmshc(OE) virtio_ring(E)
> > mmcblk0rpmb: mmc0:0001 Y29128 4.00 MiB, chardev (245:0)
> > CPU: 8 PID: 240 Comm: kworker/8:1H Tainted: G           OE     5.15.120.bsk.business.6-arm64 #5.15.120.bsk.business.6
> > Hardware name: https://www.mellanox.com BlueField-3 DPU/BlueField-3 DPU, BIOS 4.9.2.13576 Mar 18 2025
> > Workqueue: kblockd blk_mq_run_work_fn
> > pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : mmc_start_request+0xb4/0xc4
> > lr : mmc_start_request+0x68/0xc4
> > sp : ffff80000932ba90
> > x29: ffff80000932ba90 x28: ffff000081b3b308 x27: 0000000000000000
> > x26: 0000000000000001 x25: 0000000000000000 x24: ffff000082aec000
> > x23: ffff000082485800 x22: ffff000082aec000 x21: 0000000000000000
> > x20: ffff000081b3b3d8 x19: ffff000082aec000 x18: 0000000000000000
> > x17: 0000000000000000 x16: ffffbab212913c40 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000038 x12: ffff00008f06b000
> > x11: 7f7f7f7f7f7f7f7f x10: ffffbab2144acbc8 x9 : ffffbab2130ad368
> > x8 : ffff000081b3b548 x7 : ffff000082aec000 x6 : 0000000000000000
> > x5 : ffff000081b3b458 x4 : ffff00008a4b5e80 x3 : ffff0000824859b0
> > x2 : 0000000000000000 x1 : ffff000081b3b4c8 x0 : 0000000000000020
> > Call trace:
> >  mmc_start_request+0xb4/0xc4
> >  mmc_blk_mq_issue_rq+0x310/0x8fc
> >  mmc_mq_queue_rq+0x154/0x3e0
> >  blk_mq_dispatch_rq_list+0x13c/0xa44
> >  blk_mq_do_dispatch_sched+0x2cc/0x33c
> >  __blk_mq_sched_dispatch_requests+0x154/0x1b0
> >  blk_mq_sched_dispatch_requests+0x40/0x80
> >  __blk_mq_run_hw_queue+0x58/0xa0
> >  blk_mq_run_work_fn+0x28/0x34
> >  process_one_work+0x1f8/0x4c0
> >  worker_thread+0x180/0x580
> >  kthread+0x128/0x13c
> >  kthread_return_to_user+0x0/0x10
> > ---[ end trace fc3df73f08f7c8ee ]---
> 
> Not much to go on
> 
> >
> > I agree the bitfield usage adds complexity. I can work on a follow-up
> > to convert the retune-related flags to bools if that’s the preferred
> > direction.
> 
> There are 2 suspect cases that I notice:
> 
> 1. host->claimed in __mmc_claim_host()
> 
> The block driver allows more than 1 request to be inflight, which means
> __mmc_claim_host() could itself overwrite other bitfields in a asynchronous
> context if the host has alrady been claimed for the same ctx.
> 
> int __mmc_claim_host(struct mmc_host *host, struct mmc_ctx *ctx,
>                      atomic_t *abort)
> {
>         struct task_struct *task = ctx ? NULL : current;
>         DECLARE_WAITQUEUE(wait, current);
>         unsigned long flags;
>         int stop;
>         bool pm = false;
> 
>         might_sleep();
> 
>         add_wait_queue(&host->wq, &wait);
>         spin_lock_irqsave(&host->lock, flags);
>         while (1) {
>                 set_current_state(TASK_UNINTERRUPTIBLE);
>                 stop = abort ? atomic_read(abort) : 0;
>                 if (stop || !host->claimed || mmc_ctx_matches(host, ctx, task))
>                         break;
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 schedule();
>                 spin_lock_irqsave(&host->lock, flags);
>         }
>         set_current_state(TASK_RUNNING);
>         if (!stop) {
>                 host->claimed = 1;                              <- overwrites other bitfields
>                 mmc_ctx_set_claimer(host, ctx, task);
>                 host->claim_cnt += 1;
>                 if (host->claim_cnt == 1)
>                         pm = true;
>         } else
>                 wake_up(&host->wq);
>         spin_unlock_irqrestore(&host->lock, flags);
>         remove_wait_queue(&host->wq, &wait);
> 
>         if (pm)
>                 pm_runtime_get_sync(mmc_dev(host));
> 
>         return stop;
> }
> 
> 2. host->retune_now in mmc_mq_queue_rq()
> 
> For the same reason as 1, host->retune_now update can overwrite other
> bitfields in an asynchronous context.
> 
>         if (host->cqe_enabled) {
>                 host->retune_now = host->need_retune && cqe_retune_ok &&
>                                    !host->hold_retune;
>         }
> 
> I suggest changing bitfields to bool for the above 2 cases and also
> in cases that are relatively difficult to fully understand:
> 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..ba84f02c2a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,14 +486,12 @@ struct mmc_host {
> 
>         struct mmc_ios          ios;            /* current io bus settings */
> 
> +       bool                    claimed;        /* host exclusively claimed */
> +
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> -       unsigned int            claimed:1;      /* host exclusively claimed */
>         unsigned int            doing_init_tune:1; /* initial tuning in progress */
> -       unsigned int            can_retune:1;   /* re-tuning can be used */
>         unsigned int            doing_retune:1; /* re-tuning in progress */
> -       unsigned int            retune_now:1;   /* do re-tuning at next req */
> -       unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
>         unsigned int            retune_crc_disable:1; /* don't trigger retune upon crc */
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
> @@ -508,6 +506,9 @@ struct mmc_host {
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
> 
> +       bool                    can_retune;     /* re-tuning can be used */
> +       bool                    retune_now;     /* do re-tuning at next req */
> +       bool                    retune_paused;  /* re-tuning is temporarily disabled */
>         int                     need_retune;    /* re-tuning is needed */
>         int                     hold_retune;    /* hold off re-tuning */
>         unsigned int            retune_period;  /* re-tuning period in secs */
> 
> For which fixes tags could be:
> 
>         Fixes: 6c0cedd1ef952 "mmc: core: Introduce host claiming by context"
>         Fixes: 1e8e55b67030c "mmc: block: Add CQE support"
> 
> >
> > Thanks,
> > Penghe
> >
> > On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 15/01/2026 23:46, Penghe Geng wrote:
> >>> The host->claimed flag shares a bitfield storage word with several
> >>> retune flags (retune_now, retune_paused, can_retune, doing_retune,
> >>> doing_init_tune). Updating those flags without host->lock can RMW the
> >>> shared word and clear claimed, triggering spurious
> >>> WARN_ON(!host->claimed).
> >>
> >> Thanks for finding this!
> >>
> >> The design is that those members are protected by the host->claimed
> >> lock itself.
> >>
> >> mmc operations are primarily single-threaded, protected by the
> >> host->claimed lock, although the block driver does allow multiple
> >> transfers at the same time in some cases.
> >>
> >> There are also other contexts like interrupt handlers.
> >>
> >> Can you provide some information about when WARN_ON(!host->claimed)
> >> is being hit?  Including the stack dump?
> >> What kernel version?
> >> Is it eMMC, SDIO or SD card?
> >> Is CQE being used?
> >> Are there any I/O errors happening also?
> >> What controller driver is it?
> >>
> >> In any case, the use of bit fields seems to add complexity unnecessarily,
> >> so we should consider converting some or all of them to bool.
> >>
> >>>
> >>> Serialize all retune bitfield updates with host->lock. Provide lockless
> >>> __mmc_retune_* helpers so callers that already hold host->lock can
> >>> avoid deadlocks while public wrappers serialize updates. Also protect
> >>> doing_init_tune and the CQE retune_now assignment with host->lock.
> >>>
> >>> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> >>> ---
> >>>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
> >>>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
> >>>  drivers/mmc/core/mmc.c   |  6 ++++
> >>>  drivers/mmc/core/queue.c |  3 ++
> >>>  include/linux/mmc/host.h |  4 +++
> >>>  5 files changed, 94 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >>> index 88c95dbfd9cf..0b6b4a31f629 100644
> >>> --- a/drivers/mmc/core/host.c
> >>> +++ b/drivers/mmc/core/host.c
> >>> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
> >>>   */
> >>>  void mmc_retune_enable(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->can_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>       if (host->retune_period)
> >>>               mod_timer(&host->retune_timer,
> >>>                         jiffies + host->retune_period * HZ);
> >>> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
> >>>   */
> >>>  void mmc_retune_pause(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (!host->retune_paused) {
> >>>               host->retune_paused = 1;
> >>> -             mmc_retune_hold(host);
> >>> +             __mmc_retune_hold(host);
> >>>       }
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_pause);
> >>>
> >>>  void mmc_retune_unpause(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +     bool released;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->retune_paused) {
> >>>               host->retune_paused = 0;
> >>> -             mmc_retune_release(host);
> >>> +             released = __mmc_retune_release(host);
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>> +             if (!released)
> >>> +                     WARN_ON(1);
> >>> +     } else {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>       }
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_unpause);
> >>> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
> >>>   */
> >>>  void mmc_retune_disable(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>>       mmc_retune_unpause(host);
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->can_retune = 0;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>       timer_delete_sync(&host->retune_timer);
> >>>       mmc_retune_clear(host);
> >>>  }
> >>> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
> >>>
> >>>  void mmc_retune_hold(struct mmc_host *host)
> >>>  {
> >>> -     if (!host->hold_retune)
> >>> -             host->retune_now = 1;
> >>> -     host->hold_retune += 1;
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     __mmc_retune_hold(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  void mmc_retune_release(struct mmc_host *host)
> >>>  {
> >>> -     if (host->hold_retune)
> >>> -             host->hold_retune -= 1;
> >>> -     else
> >>> +     unsigned long flags;
> >>> +     bool released;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     released = __mmc_retune_release(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>> +     if (!released)
> >>>               WARN_ON(1);
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_release);
> >>> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
> >>>  {
> >>>       bool return_to_hs400 = false;
> >>>       int err;
> >>> +     unsigned long flags;
> >>>
> >>> -     if (host->retune_now)
> >>> -             host->retune_now = 0;
> >>> -     else
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     if (!host->retune_now) {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>               return 0;
> >>> +     }
> >>> +     host->retune_now = 0;
> >>>
> >>> -     if (!host->need_retune || host->doing_retune || !host->card)
> >>> +     if (!host->need_retune || host->doing_retune || !host->card) {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>               return 0;
> >>> +     }
> >>>
> >>>       host->need_retune = 0;
> >>> -
> >>>       host->doing_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> >>>               err = mmc_hs400_to_hs200(host->card);
> >>> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
> >>>       if (return_to_hs400)
> >>>               err = mmc_hs200_to_hs400(host->card);
> >>>  out:
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->doing_retune = 0;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>       return err;
> >>>  }
> >>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> >>> index 5941d68ff989..07e4f427fe15 100644
> >>> --- a/drivers/mmc/core/host.h
> >>> +++ b/drivers/mmc/core/host.h
> >>> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
> >>>  void mmc_retune_pause(struct mmc_host *host);
> >>>  void mmc_retune_unpause(struct mmc_host *host);
> >>>
> >>> -static inline void mmc_retune_clear(struct mmc_host *host)
> >>> +static inline void __mmc_retune_clear(struct mmc_host *host)
> >>>  {
> >>>       host->retune_now = 0;
> >>>       host->need_retune = 0;
> >>>  }
> >>>
> >>> +static inline void mmc_retune_clear(struct mmc_host *host)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     __mmc_retune_clear(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>> +}
> >>> +
> >>> +static inline void __mmc_retune_hold(struct mmc_host *host)
> >>> +{
> >>> +     if (!host->hold_retune)
> >>> +             host->retune_now = 1;
> >>> +     host->hold_retune += 1;
> >>> +}
> >>> +
> >>> +static inline bool __mmc_retune_release(struct mmc_host *host)
> >>> +{
> >>> +     if (host->hold_retune) {
> >>> +             host->hold_retune -= 1;
> >>> +             return true;
> >>> +     }
> >>> +     return false;
> >>> +}
> >>> +
> >>>  static inline void mmc_retune_hold_now(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->retune_now = 0;
> >>>       host->hold_retune += 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline void mmc_retune_recheck(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->hold_retune <= 1)
> >>>               host->retune_now = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>> index 7c86efb1044a..114febd15f08 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >>>               goto free_card;
> >>>
> >>>       if (mmc_card_hs200(card)) {
> >>> +             unsigned long flags;
> >>> +
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->doing_init_tune = 1;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>               err = mmc_hs200_tuning(card);
> >>>               if (!err)
> >>>                       err = mmc_select_hs400(card);
> >>>
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->doing_init_tune = 0;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>               if (err)
> >>>                       goto free_card;
> >>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> >>> index 284856c8f655..5e38759c87f5 100644
> >>> --- a/drivers/mmc/core/queue.c
> >>> +++ b/drivers/mmc/core/queue.c
> >>> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>>       enum mmc_issue_type issue_type;
> >>>       enum mmc_issued issued;
> >>>       bool get_card, cqe_retune_ok;
> >>> +     unsigned long flags;
> >>>       blk_status_t ret;
> >>>
> >>>       if (mmc_card_removed(mq->card)) {
> >>> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>>               mmc_get_card(card, &mq->ctx);
> >>>
> >>>       if (host->cqe_enabled) {
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->retune_now = host->need_retune && cqe_retune_ok &&
> >>>                                  !host->hold_retune;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>       }
> >>>
> >>>       blk_mq_start_request(req);
> >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>> index e0e2c265e5d1..e7bddbafd1da 100644
> >>> --- a/include/linux/mmc/host.h
> >>> +++ b/include/linux/mmc/host.h
> >>> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
> >>>
> >>>  static inline void mmc_retune_needed(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->can_retune)
> >>>               host->need_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline bool mmc_can_retune(struct mmc_host *host)
> >>
> >
> > On Mon, Jan 26, 2026 at 03:43:14PM +0200, Adrian Hunter wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 15/01/2026 23:46, Penghe Geng wrote:
> >>> The host->claimed flag shares a bitfield storage word with several
> >>> retune flags (retune_now, retune_paused, can_retune, doing_retune,
> >>> doing_init_tune). Updating those flags without host->lock can RMW the
> >>> shared word and clear claimed, triggering spurious
> >>> WARN_ON(!host->claimed).
> >>
> >> Thanks for finding this!
> >>
> >> The design is that those members are protected by the host->claimed
> >> lock itself.
> >>
> >> mmc operations are primarily single-threaded, protected by the
> >> host->claimed lock, although the block driver does allow multiple
> >> transfers at the same time in some cases.
> >>
> >> There are also other contexts like interrupt handlers.
> >>
> >> Can you provide some information about when WARN_ON(!host->claimed)
> >> is being hit?  Including the stack dump?
> >> What kernel version?
> >> Is it eMMC, SDIO or SD card?
> >> Is CQE being used?
> >> Are there any I/O errors happening also?
> >> What controller driver is it?
> >>
> >> In any case, the use of bit fields seems to add complexity unnecessarily,
> >> so we should consider converting some or all of them to bool.
> >>
> >>>
> >>> Serialize all retune bitfield updates with host->lock. Provide lockless
> >>> __mmc_retune_* helpers so callers that already hold host->lock can
> >>> avoid deadlocks while public wrappers serialize updates. Also protect
> >>> doing_init_tune and the CQE retune_now assignment with host->lock.
> >>>
> >>> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Penghe Geng <pgeng@nvidia.com>
> >>> ---
> >>>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
> >>>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
> >>>  drivers/mmc/core/mmc.c   |  6 ++++
> >>>  drivers/mmc/core/queue.c |  3 ++
> >>>  include/linux/mmc/host.h |  4 +++
> >>>  5 files changed, 94 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >>> index 88c95dbfd9cf..0b6b4a31f629 100644
> >>> --- a/drivers/mmc/core/host.c
> >>> +++ b/drivers/mmc/core/host.c
> >>> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
> >>>   */
> >>>  void mmc_retune_enable(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->can_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>       if (host->retune_period)
> >>>               mod_timer(&host->retune_timer,
> >>>                         jiffies + host->retune_period * HZ);
> >>> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
> >>>   */
> >>>  void mmc_retune_pause(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (!host->retune_paused) {
> >>>               host->retune_paused = 1;
> >>> -             mmc_retune_hold(host);
> >>> +             __mmc_retune_hold(host);
> >>>       }
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_pause);
> >>>
> >>>  void mmc_retune_unpause(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +     bool released;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->retune_paused) {
> >>>               host->retune_paused = 0;
> >>> -             mmc_retune_release(host);
> >>> +             released = __mmc_retune_release(host);
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>> +             if (!released)
> >>> +                     WARN_ON(1);
> >>> +     } else {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>       }
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_unpause);
> >>> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
> >>>   */
> >>>  void mmc_retune_disable(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>>       mmc_retune_unpause(host);
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->can_retune = 0;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>       timer_delete_sync(&host->retune_timer);
> >>>       mmc_retune_clear(host);
> >>>  }
> >>> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
> >>>
> >>>  void mmc_retune_hold(struct mmc_host *host)
> >>>  {
> >>> -     if (!host->hold_retune)
> >>> -             host->retune_now = 1;
> >>> -     host->hold_retune += 1;
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     __mmc_retune_hold(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  void mmc_retune_release(struct mmc_host *host)
> >>>  {
> >>> -     if (host->hold_retune)
> >>> -             host->hold_retune -= 1;
> >>> -     else
> >>> +     unsigned long flags;
> >>> +     bool released;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     released = __mmc_retune_release(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>> +     if (!released)
> >>>               WARN_ON(1);
> >>>  }
> >>>  EXPORT_SYMBOL(mmc_retune_release);
> >>> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
> >>>  {
> >>>       bool return_to_hs400 = false;
> >>>       int err;
> >>> +     unsigned long flags;
> >>>
> >>> -     if (host->retune_now)
> >>> -             host->retune_now = 0;
> >>> -     else
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     if (!host->retune_now) {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>               return 0;
> >>> +     }
> >>> +     host->retune_now = 0;
> >>>
> >>> -     if (!host->need_retune || host->doing_retune || !host->card)
> >>> +     if (!host->need_retune || host->doing_retune || !host->card) {
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>               return 0;
> >>> +     }
> >>>
> >>>       host->need_retune = 0;
> >>> -
> >>>       host->doing_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>       if (host->ios.timing == MMC_TIMING_MMC_HS400) {
> >>>               err = mmc_hs400_to_hs200(host->card);
> >>> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
> >>>       if (return_to_hs400)
> >>>               err = mmc_hs200_to_hs400(host->card);
> >>>  out:
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->doing_retune = 0;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>       return err;
> >>>  }
> >>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> >>> index 5941d68ff989..07e4f427fe15 100644
> >>> --- a/drivers/mmc/core/host.h
> >>> +++ b/drivers/mmc/core/host.h
> >>> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
> >>>  void mmc_retune_pause(struct mmc_host *host);
> >>>  void mmc_retune_unpause(struct mmc_host *host);
> >>>
> >>> -static inline void mmc_retune_clear(struct mmc_host *host)
> >>> +static inline void __mmc_retune_clear(struct mmc_host *host)
> >>>  {
> >>>       host->retune_now = 0;
> >>>       host->need_retune = 0;
> >>>  }
> >>>
> >>> +static inline void mmc_retune_clear(struct mmc_host *host)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>> +     __mmc_retune_clear(host);
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>> +}
> >>> +
> >>> +static inline void __mmc_retune_hold(struct mmc_host *host)
> >>> +{
> >>> +     if (!host->hold_retune)
> >>> +             host->retune_now = 1;
> >>> +     host->hold_retune += 1;
> >>> +}
> >>> +
> >>> +static inline bool __mmc_retune_release(struct mmc_host *host)
> >>> +{
> >>> +     if (host->hold_retune) {
> >>> +             host->hold_retune -= 1;
> >>> +             return true;
> >>> +     }
> >>> +     return false;
> >>> +}
> >>> +
> >>>  static inline void mmc_retune_hold_now(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       host->retune_now = 0;
> >>>       host->hold_retune += 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline void mmc_retune_recheck(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->hold_retune <= 1)
> >>>               host->retune_now = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>> index 7c86efb1044a..114febd15f08 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> >>>               goto free_card;
> >>>
> >>>       if (mmc_card_hs200(card)) {
> >>> +             unsigned long flags;
> >>> +
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->doing_init_tune = 1;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>               err = mmc_hs200_tuning(card);
> >>>               if (!err)
> >>>                       err = mmc_select_hs400(card);
> >>>
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->doing_init_tune = 0;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>
> >>>               if (err)
> >>>                       goto free_card;
> >>> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> >>> index 284856c8f655..5e38759c87f5 100644
> >>> --- a/drivers/mmc/core/queue.c
> >>> +++ b/drivers/mmc/core/queue.c
> >>> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>>       enum mmc_issue_type issue_type;
> >>>       enum mmc_issued issued;
> >>>       bool get_card, cqe_retune_ok;
> >>> +     unsigned long flags;
> >>>       blk_status_t ret;
> >>>
> >>>       if (mmc_card_removed(mq->card)) {
> >>> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>>               mmc_get_card(card, &mq->ctx);
> >>>
> >>>       if (host->cqe_enabled) {
> >>> +             spin_lock_irqsave(&host->lock, flags);
> >>>               host->retune_now = host->need_retune && cqe_retune_ok &&
> >>>                                  !host->hold_retune;
> >>> +             spin_unlock_irqrestore(&host->lock, flags);
> >>>       }
> >>>
> >>>       blk_mq_start_request(req);
> >>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >>> index e0e2c265e5d1..e7bddbafd1da 100644
> >>> --- a/include/linux/mmc/host.h
> >>> +++ b/include/linux/mmc/host.h
> >>> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
> >>>
> >>>  static inline void mmc_retune_needed(struct mmc_host *host)
> >>>  {
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&host->lock, flags);
> >>>       if (host->can_retune)
> >>>               host->need_retune = 1;
> >>> +     spin_unlock_irqrestore(&host->lock, flags);
> >>>  }
> >>>
> >>>  static inline bool mmc_can_retune(struct mmc_host *host)
> >>
> 


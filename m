Return-Path: <stable+bounces-88276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1739B24CE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E201C20A2A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01E188CC6;
	Mon, 28 Oct 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W1lT52ba";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Iy/JUUzV"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8F152E1C;
	Mon, 28 Oct 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095344; cv=fail; b=ccd8Y9Fa+JkJV0CSvKeRtfHRcAz6/LqUzfHB3rZh5XiNRCIzIML9L0PGHk/T9LpfgNBGLld7i4oVa8Q6mnCCdfjrM11qWtGLFv+UhyFkY610tdrBZJ2Apgn3ljA+IPI3OEACp+VtlpwKxCQnq3n+C/FSMqXFlLWvH5sq8URB1UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095344; c=relaxed/simple;
	bh=EBOkoIX7wpSWEGDbP9RgZbP2NFHfzpLJYeG8TvgHAEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IS75yukxdgEL9MMDqcraJ7z7Wn4kgJKtaqlVtl+/x2y6jGtA4DHRhmaphHEZDKYD5iyAddpd6IneB3rKMeVi/A+dtYydbVr8nZa+xIMNLyVvJz13StPpRL0T7s+g3F9Y3MRAzJ1u0eWY7G+PYsoTHOUJQA/MGShV3pmzOyRm8XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=W1lT52ba; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Iy/JUUzV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2dee5f4894f211efb88477ffae1fc7a5-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EBOkoIX7wpSWEGDbP9RgZbP2NFHfzpLJYeG8TvgHAEQ=;
	b=W1lT52baMkKOW3sa+REUBg11Snz+bSKXTSjnRU7wDDSfg8gbTRagqfMTiayCHzuDmMBq4PfWrPmBh4XjuAwCEoEJsG3jf5KQjk6dubprEuYMS6RUVan2B9ANoqUJZm2kuwmtSN5dULeLfMn4dGgKpOgfTRhoyrKHCi+gJD/2hYM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:ae0c762f-f2f9-4ed3-b8d4-7e8d40430e73,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:10ed342e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2dee5f4894f211efb88477ffae1fc7a5-20241028
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 491387363; Mon, 28 Oct 2024 14:02:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 14:02:13 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 14:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM2ZoyVPOmdVl1BYl8eOyp5XoCCmEI8fqd432DkqzVuwAqbxuzK52+IjjlzBYluBee61S7hWP5xYNDqgYqKYgT6X6UWU/2dxeOc/Kqp6M+twDmsbNpW4Zwz0FmIg6/573GzK5OTNCT7tgeJHEplEpMO9k6tcattxH9ojdoN1ejvd8Ctexka5cCGmpyCQ0iE1dzaAfqA2d++dsEHJ1qARqnSXOpPe8HLhSdSlg+cdSLBlOdOhFvm2t0klFq4JvyahdLtg5C1X1wsYSP+w9pYF8v1WxKDPSFJCPOpmCbPZHHQZ3RngBbSrM42jlgScdzvslUDSaa6mKHtr95+FvBenpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBOkoIX7wpSWEGDbP9RgZbP2NFHfzpLJYeG8TvgHAEQ=;
 b=M8fGnA1LW4WP9FtT6LOX5BruIcqpakLOCIC0GUhx7QM9xHQVZdMut9h2NShiUvaa2wkbEakZM0DP1TiYeMGMKBmbVV0oIQTYKwspYYgpEjPFHTiHMTx6+wRpGXNq/nkL50VsF2A7qWVffcyVzYwj1dnBblx8FBhgx8sNl0/Bv+AomrBRfooTRJuacknSgERbh13H+ibUTvzhGiu/MN9PPHoVo0ftcJhLXfCQmXXmOBsShTKQ5myogETmPJ8FS0fkb8VwRehXVHiEId7pufxBpRx3Rvrl3yNaVwihmSDz5m03SeLCzkcijPjM+XwdI+qJQMyNmoHX+1fNX+B4SqT4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBOkoIX7wpSWEGDbP9RgZbP2NFHfzpLJYeG8TvgHAEQ=;
 b=Iy/JUUzVVcUGXJxvzeFpSYm8HvwaBMZt9uopyTIcnR/4KOtSGL0pYhT3hC33S4IxUykaTeem64ojto1DCMua61VKhXP5gIxZVtmW1cukJScS8fNjSiyJrQJlPE4Bz5RxSZp2P+vw9Ysim3Xb6FS8Qb2zHcQ2tFcTBZD7M2DFlss=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8749.apcprd03.prod.outlook.com (2603:1096:405:67::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 06:02:11 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 06:02:10 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?=
	<seiya.wang@mediatek.com>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Thread-Topic: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for
 mipi_dsi_device"
Thread-Index: AQHbJfiKpGmIlcb1JUuto1yu1g4WFbKVp3wAgAAKRQKABfZRMYAACdWA
Date: Mon, 28 Oct 2024 06:02:10 +0000
Message-ID: <d295d1c384f4af46c2c4a11894fbdd8048984b46.camel@mediatek.com>
References: <20241024-fixup-5-15-v1-1-74d360bd3002@mediatek.com>
	 <2024102406-shore-refurbish-767a@gregkh>
	 <88f78b11804b0f18e0dce0dca95544bf6cf6c7c6.camel@mediatek.com>
	 <2024102411-handgrip-repayment-f149@gregkh>
	 <ddc5f179dfa8445e2b25ae0c6e382550d45bbbd3.camel@mediatek.com>
	 <2024102855-untitled-unfixed-2b9d@gregkh>
In-Reply-To: <2024102855-untitled-unfixed-2b9d@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8749:EE_
x-ms-office365-filtering-correlation-id: e0cf0fd7-366d-420e-f73a-08dcf7160fb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFBrbzVqcUtpa0h6TVNEY1MxcG5kK01vZFB3RnVtbzVmME5tRGwzQ0RjaHZn?=
 =?utf-8?B?aktZNytsZ0w5SWh1Z242RDRoa0pTTDl2bC9RMitEMFoxc0puc3F4V2Ryek9l?=
 =?utf-8?B?VzEvT0NBWjFaRE5hUUNkSHIyMkJUWTR3dTI3SHhFLzNpM2ZuQUlGSS9QbzlX?=
 =?utf-8?B?MUE3Y2I1c2toYzJSZmdkaW9qS1BLTnUwT3ZBUXFOWnhLbWpxODVBNkE2bzll?=
 =?utf-8?B?RE00c0JRemwxNUR1UUh0U0hUUnJIOW9COXpwcDVodnVmWUswazdnTDJVdXNa?=
 =?utf-8?B?V0JhQnd1eENrRERaVE12dW11ZVU0NWp2T2x2UlJidDB0bm52WE1Fa2t4aDB2?=
 =?utf-8?B?emxJZ0NDays1QVJuTGFGVVdqM08xbis3TXd3bVZhQVhHcHFDTm9Od3VtVzRw?=
 =?utf-8?B?ZURmYzcxT3hNNFZjaXVlRjJHa1UxWmwwVElJMDZkODZXMmFlOExoRnZzR3Nk?=
 =?utf-8?B?ZXczTHZQbmVuUklFNnd3MVZ5dk5MZGxQaVhNRmM4eVJTV2Zja2ErL3J4ekFQ?=
 =?utf-8?B?RnpZUkZuTmJSYkpwUmhWRzdFWUVzT0pjdVM5cXk4QzR4VzdzeEVVZTVnQnJR?=
 =?utf-8?B?VmRBckJRdThBeTlJbTZnRmdkV21zZnNtalZIQ0c5ZDNQKzBTajZjWk84TzIz?=
 =?utf-8?B?VEpPYVZCUGdYdGVqYlVDQXJpQ3ZPSm5jZ2ZUTW5TK0xWWTg4L3h2SkwzLzdp?=
 =?utf-8?B?cUJvV2JpLzlFUXhFeG5yVXIyaHFSbElkK0FLcU5Ba1N3K1JVQ05NZS9ybTd6?=
 =?utf-8?B?cmdFNG4xa3R2Z25iaCtTV2FkNXdGbHBYSldId09kTXVqZ3VJazAyWE1qcjY5?=
 =?utf-8?B?b3JTQktYNW9weDRlREpUQi9nZzE1cG05Y3NzRWxIcG1LUlJlb2I2U0xLQXR0?=
 =?utf-8?B?em1KVk4vSlQyRFAydEZCRzA2ZkZobHZDdUpuRW5zZTNDcWdKcDgrWkRWZ0NI?=
 =?utf-8?B?WnptT1I2OU1UMmxjM25sQWZwTlBvblVYTHFVS1Q3WWNOb2hYQy9neHhrOE5S?=
 =?utf-8?B?cks2N2U2RGRocy8rSlRFNnlKM014NnEwNWE3T1Z4ZjJLT3h1UGdLUTRubE5S?=
 =?utf-8?B?Ui85cTNSZWxXaEdQYysyeDJoS25mMWxpdCtVK0hVNDRrRlc0bXlQVDZEVWgr?=
 =?utf-8?B?eE00dFRKSEpvb0hHQTJ0S21CQ0RjY3FwYVRjUXl0VUFRaTlaL2pJc0wwQzRJ?=
 =?utf-8?B?SnFVMnp4OG9VNGFqUkhzTDNFdmIyNlc3VlcrRlBnY25wdlh0UjY1c1ZmK3Jv?=
 =?utf-8?B?aDJ6VjFzMUkvWXRYbENWZUpvZ1ZnU0pzSUNVL1dQejVzNlRLSlNhTE4yT01U?=
 =?utf-8?B?cEpDVjZoanFwZ0VWSHhEbXdSc2l3REtYbnk1MktNL0kxVmdhZ1E1a0srNlcy?=
 =?utf-8?B?dEp5Q0s1aGxZNmVnb0g4YUdpWGxkdWh5aVRYV0cySklTaXh3MUtVV2tLbEVr?=
 =?utf-8?B?VFpiWld2anc4bFFqRXk1Q1lPK0hNaS9KQnBtUXIzUGplK1pQbENzV1B5aXNB?=
 =?utf-8?B?U1RUNGhzUU9LbTg5ZmYzM1c3TjYrS0NVWmIxdEx3TEZVUVRTUU8wR1BCZzBj?=
 =?utf-8?B?U2FEc0ljVmhvc0xWSldkY3FubkFic3lFU2NjNzMxNTdIdU1MbDZoazJ0UXdB?=
 =?utf-8?B?VVgrVU8wNG1HS1kwcWNpQVM1eW1FMWp5UHNOSmdzMU1yT1FPVjRhRlgvWExO?=
 =?utf-8?B?cEdzOElLclpZK2xmTlJnZWVtTGpjNE1tVnVZbWZXeG9iVFR2b0tydXdpUHg4?=
 =?utf-8?B?VE5zZlV0cEprbm1sK3Jyc2hUK0xPMEJLMWhuN2N2MjhreGdXQlBhVkxYbmdl?=
 =?utf-8?B?YSs3ZnJ2Ryt1azBwU1NGa1UxY2NrVnFaaHoxYTFGbzdnM0h3dW9aYmcvc202?=
 =?utf-8?Q?sbIy93tKmUUgx?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NllXZTZGSFBvcTlVUEtQbkFXQjVlZytydHlEeUJkYkZBUHRJUUFFVVZIZVF4?=
 =?utf-8?B?REo4N29wcVRBUDJOb2t3SU1EWnBNS3E1dEtvRWpsekFvdE9YTGViOThCeDhG?=
 =?utf-8?B?YlVVRkZ2TUZwb0NqdXNET1JYRjRlSnFpRWt3YjlVS1Q5WndlYkxHWktvb05r?=
 =?utf-8?B?VndabFB3bUdhT3BLSHJERlhtT0ZsOTlVVjZRbGM1OGRkYjlFVFltUE1ZUlQv?=
 =?utf-8?B?ZUhwMzFVWENjYmgyYzZHT2FlSFIwM1F4UXZaNlBzS2FYeHUyajkwbHhCaTk1?=
 =?utf-8?B?eHI4OTNUK1VFbFVETmhZQVF2ZGw4YXUvN2h6QTZod2dxVkFIRGVZRzdCMWF4?=
 =?utf-8?B?OSs1aGNjT2JlbGp1bEp4Z3dMUlpyUjhJY1dxQVJvWCtPL3BxKzNMa015QThN?=
 =?utf-8?B?U0Z6b21LSWF6M0xZLzVvZ3d4b0tGNWlkK25nZC9Xa3VVQW5INnZkZlRwSjNm?=
 =?utf-8?B?bE9zOE9VcVo2ekNMM3dZZFh1TGNibTJKb3VTNTJaaXhjd3pqM21TeHR2VW0x?=
 =?utf-8?B?VWJPNE9NaTVSYmtrZXRzd1pySVU2TmNhankrdmRaQkJrRGRVcjNzUU9MSVZF?=
 =?utf-8?B?anQvMTUzandJbzluclYvRG54UVVKTEFJTmtFWHFmRk1VZE9FWEJRLy9uSlhI?=
 =?utf-8?B?Vjh1S0FLNlhtUUViYTVDOVpNZlZwWnVBMmZucis2MXdxV2xXUksyM0JIVnFD?=
 =?utf-8?B?NjlSOFFEV1c2TERGSm1hdWtVc0FZbXBxQ1FMZ3E1bDFCMWpKZlRaS2pzanMv?=
 =?utf-8?B?YWhudU1jVzA2cW4xWjRuM1lOelRxc1IwVWVuL2MvQldidEtzeVl0bDNncEtv?=
 =?utf-8?B?UXYxOWlRcExmTW1ReXNxSzBWV3FpUEhtQzdZOENiK3JYQk1jQjFNSVE5b3VC?=
 =?utf-8?B?ZnNoemVPSW04UlBTUlNkQnBtTmFrckRQOXJNQnZMa2tqeGZJd0tLNWxRSW9M?=
 =?utf-8?B?RTY2UjdYYWZFUjhkejB5NTc0VnRDcS8xYXdZY1Q2b3NGUEVmWmRlcHZYU2d2?=
 =?utf-8?B?VXZBSEd3M2hqclcrN1F3RG9IQU1ILzVjY0ZYWDVncUhmVEk5Uy9MdWN0cnFK?=
 =?utf-8?B?TUZEc2ZNWTZEMzVvOHZsTUczVkpCUFdoLzFmeENwL3d1Z09LcEhWd0c1bGNz?=
 =?utf-8?B?cHNJNlNLaFBxaUgwMFFEZzRlamhacFdoellUakNpOTBBYzQvR1I2SnNyWWNp?=
 =?utf-8?B?WEpYWjZFMC8wb0F6aUxydi9vNi9OQnRvREp4L0FqdEFEMFcwb2Zub0YrRXQ4?=
 =?utf-8?B?UGJtaTN3RmVqU0Q0eVRiaEdndEk0YXorSmVEZThYY3BTWjVxUDY3Z2l4VG9K?=
 =?utf-8?B?dmI5eVhQU0U1d2tNeHpaVlp6Ly83c0pCcTJQdDdGQ21KcjRCc2lSWG5uSHB4?=
 =?utf-8?B?RUhjYzlOYmZrQmFlaTlqaTB3OHRBcTgrazd4L2xqL0l2d1NhRUhDOENhU0Rs?=
 =?utf-8?B?K3padTEvajN6K09PR0J4UXoxVGJ6MFlhMG5aaWxIWTlhZ3Rob2gvQnBYVjJ6?=
 =?utf-8?B?S1hUdDBiYjVobWsrU3JTaVM4L1E3N0MxbG1PejBXU1Fzb011aDFRL2RVNTJQ?=
 =?utf-8?B?SWFDM3pweUZGNnlKS29lSGI5NlRFSXFoazg2QWRvU1pYZ2lKQlA1NTZrSWtq?=
 =?utf-8?B?T0llZ3hiYXg3OFg1TFd6MDNHSlNNaTJxSlV4TGl0azlyT3dSUUM5NUhrWXlG?=
 =?utf-8?B?TXNGNkV4SFFod21RYjZ0ODdnTTFITGQrWjRON1gvelAwNmp1M1BTK2xQNFRn?=
 =?utf-8?B?bnczTlhPcXNvc1Bob3hGSzdIb1I0YThmVjhMSUIvQ09KQTYvZUFoREgwRlNm?=
 =?utf-8?B?VHZWMzFIcFZTd3ZpUysvYkdlQ0FXNTNJYm9nT2pSRklDMFJPK1VYeTZadU9R?=
 =?utf-8?B?dmZzU2F5Vzh1YUZzNVl6ckplWXJxblNWcTlQOXN5S25NSkRoWHZsN0FnNVdm?=
 =?utf-8?B?Mm5PTDFZa2lFbU9tTHlwcVJ5aFZnek11MHdyT3ExN01LMmRneGhuTEhkenRx?=
 =?utf-8?B?SlpXQU8zZ1J0NXBhYi9QbU1pYzI2L2FLSUxNalZyUEtJV1hLcW52a0Y1STZS?=
 =?utf-8?B?MGEzODR1eFR0bWM1R2l5cVZLMDQwSy93Z0RGdnFuTGVnS1ZJelI0Um9Tek0w?=
 =?utf-8?B?ZDF0MkhaQlc3aGxaeHRtTFo2MXg1a0orUVJHMSswUHo1TkR5c2llaVdOT3Ax?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED014158783F814DB108521EA46104D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cf0fd7-366d-420e-f73a-08dcf7160fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:02:10.3961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryFRIgwMLAV6Aw6ZDr96aXAHmqCjCF/qg6a495gu29bUUceyitlkh8wfRmNPz3CI3cVPhsFIJTWP54Rar89hUB4EjSOB2CD7tML8wXlookQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8749

W3NuaXBdDQo+ID4gPiA+IA0KPiA+ID4gPiBQbGVhc2UgZG9uJ3QgbWluZCBtZSBtYWtlIGEgY29u
ZmlybWF0aW9uLg0KPiA+ID4gPiBJIGp1c3QgbmVlZCB0byBhZGQgdGhpcyBsaW5lIGhlcmUgYW5k
IHNlbmQgaXQgYWdhaW4sIHJpZ2h0Pw0KPiA+ID4gPiANCj4gPiA+ID4gQ2M6IDxzdGFibGVAdmdl
ci5rZXJuZWwub3JnPiAjNS4xNS4xNjkNCj4gPiA+IA0KPiA+ID4gWWVzLg0KPiA+IA0KPiA+IEhp
IEdyZWcsDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbmZpcm1hdGlvbiENCj4gPiANCj4g
PiBJJ3ZlIHNlbnQgdGhlIHBhdGNoIGFnYWluIHdpdGhvdXQgYWRkaW5nIGB2MmAgYWZ0ZXIgdGhl
IFtQQVRDSF06DQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDEwMjQtZml4
dXAtNS0xNS12MS0xLTYyZjIxYTMyYjVhNUBtZWRpYXRlay5jb20NCj4gPiBXb3VsZCB0aGF0IGJl
IGZpbmUgd2l0aCB5b3U/DQo+IA0KPiBCdXQgaXQgaXMgYSB2MiBwYXRjaCwgd2h5IG5vdCBtYXJr
IGl0IGFzIHN1Y2g/DQoNCkkgdGhvdWdodCBjb3JyZWN0aW5nIGZvcm1hdCBpcyBub3QgY2hhbmdp
bmcgY29tbWl0IG1lc3NhZ2Ugb3INCm1vZGlmaWNhdGlvbiwgc28gSSBkaWRuJ3QgaW5jcmVhc2Ug
dGhlIHZlcnNpb24gbnVtYmVyLg0KDQpBbnl3YXksIEkndmUgc2VudCB0aGUgdjIgYWdhaW46DQoN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTAyOC1maXh1cC01LTE1LXYyLTEtNDAy
MTZmMGZlMzgzQG1lZGlhdGVrLmNvbQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQo=


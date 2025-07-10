Return-Path: <stable+bounces-161553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABCBAFFFD8
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 12:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0286C640AF8
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3972E0936;
	Thu, 10 Jul 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ADej9YMM"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2524501E;
	Thu, 10 Jul 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145037; cv=fail; b=MWL4x183urSu5Ffo6GWH3u/ng9GbnoNlk5beWvXE26AHOpMvGMdRavv6WkohpM2yx3F+MSiu7WSF2wXvice3l4DyhzXoB+c9C6IQbjMEW+is2RfPFRvU2JjwAYU0twEcvW/m5JO6RZBklahf9WfBDbvVvWj4vP3SKG3mk4ZahOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145037; c=relaxed/simple;
	bh=HL5QKUIEaucCMEDOmUEaLH+kX+aJBvmgdPxnfL2I1wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rxNiZAlsq1kN3D4w6zzt7a3PQbiWpUtk7NVUTXOMzFzOoWlxoizitoD1urmT86XvdH+tejY5y8rLzRR7kULjb3Gjbcfd6MNi/jOkrE+l28swa+B9FfqGK8S4urA6wxSPBKEH1kdQ6IqvC6gwaaHChmolX2nHoD16vRbanEe923o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ADej9YMM; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1752145035; x=1783681035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HL5QKUIEaucCMEDOmUEaLH+kX+aJBvmgdPxnfL2I1wY=;
  b=ADej9YMMgmFpUf5tAw9+U7M0EHdLsn8XMg/5qiKR33GGrv0tmrWHd8s9
   N+tlcx2feVPabvaynCjSo6c0SanKMRJ4jkS7ECK2uQzrOQnTSa3K8ma2H
   G9Y9+X8wbVf59G+DhfcN3TFd+VDcyvnYeXszoJ5qCeCN/nfnnPQ02sRxV
   0vjhcgEi0MF74sMayRMv2ZwTm1TpGaNP7F3u8a6GO/dPYweeMJXrgwhhs
   w5orHCmZ7FiY33tDK4ixPgmy/sMFcSk1E07jW0A4qGO0Zq9mtSS78KENL
   oW4+OKFKL/PIiuyH9nOt8jD4iOceOeTGM3X9f93222UmGydq3xihaQ9KN
   w==;
X-CSE-ConnectionGUID: AdUAVui4TIys7715RorEHQ==
X-CSE-MsgGUID: yGcA+xRiQlmtJQgc7HJ55g==
Received: from mail-co1nam11on2090.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.90])
  by ob1.hc6817-7.iphmx.com with ESMTP; 10 Jul 2025 03:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnIu8yXhC/TdzfExYJfK0J80vQUcisK7pUCcgyZ6wPSyv/GuOeej0vvFFxt3Y02gZQG2kGGRNV30N0hxPrLvy53cT8NcCjnrEGrZl6OpRT/Peet8uXePxIAvWtisTX5rsZgsBEr66lo4B4bnWquYchtiGqWeQmgRAld9ly6KqdMp76hjE+/vf1skMyttO2jPTiKHRzj7nHwetr9rw70Nn+FWTMx8mNhPyyPPZFbKxE1/OM+BSTLpi1fFv2M1T8CS48oRDWXKbDQJWOtUcP9WF6nIuGS359rT2jAMgv8o4M2vMQkwxn65jDsdmtWIx2p5RH8J34RBFhGXvIJkr2MZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL5QKUIEaucCMEDOmUEaLH+kX+aJBvmgdPxnfL2I1wY=;
 b=u2l75rQ3V3tXLXjis6CgPdmHdWo2LbErzLPvhZLWNB2HxDl9DT0aXQMR+7qqDkeqNeyi6U7I98bvW77WnetUWX0T8jUpZekc/air3Zd2uw3+1IK/d1DURbaH70ZlT+JOLBesy1w87E9VDTdhgYh7foEo/RSX8g8qdRpD4fbv0DqL25LDgIv5eHxTxamDfBYuLrOomqWZGPFaihVIXFPhgZH4KjlDtJCdj190td17kr/IH7bUO0aRqbaVXFvmiKYnn/FTp7R5wqxsyk1uQTsbchriLqchezUJIkWy5qt0SRqn1AwoEgL0m4ydR5u+xs7X5dfYUnBRnS4kAZoLGTOO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CH3PR16MB6351.namprd16.prod.outlook.com (2603:10b6:610:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 10:57:05 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 10:57:05 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Sarthak Garg <quic_sartgarg@quicinc.com>,
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>,
	Bibek Basu <bbasu@nvidia.com>, Sagiv Aharonoff <saharonoff@nvidia.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit
 handling
Thread-Topic: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current
 limit handling
Thread-Index:
 AQHb4PkiFMMrOw3qa0usXaEaGtyRPrQofVGAgAFjF6CAACN9gIABE+JwgAAW44CAACHvkA==
Date: Thu, 10 Jul 2025 10:57:05 +0000
Message-ID:
 <PH7PR16MB6196E1A6FF2FCD0E7D86905FE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-3-avri.altman@sandisk.com>
 <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
 <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com>
 <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFpiVFHhQwp8gyUMi+FHX6sWMqZdB6imOeGB255qpbK-KA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFpiVFHhQwp8gyUMi+FHX6sWMqZdB6imOeGB255qpbK-KA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CH3PR16MB6351:EE_
x-ms-office365-filtering-correlation-id: 66f8e496-4766-45d1-9357-08ddbfa08232
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUJWa0VJMVBJWHdGWkpKMFFGOWZFN3JXelh6NnIvcE9YbEk3azdLdnJ5Q1pK?=
 =?utf-8?B?MnJNNjM2dGQraENvSGxha0hhdDZmOTh4ei9Rb09oZzBvaUxFak1CS2kwekJX?=
 =?utf-8?B?OG1FeEVyWjhzMk44UUxUSXdUVWNvOWRUbCtVTFYvbEF2VGdaVVh5eDJJQUo4?=
 =?utf-8?B?QnlMTGZLMzVGRG9VT3RGTHRVMnl6Z2szWUhSeE9Hb1p4eFdQRndoeXVaY0hV?=
 =?utf-8?B?YWhPRnFGemNyOWNvTVpBT2RORERtRVJMU3pybHNNTGFFOWFvUlpoWC9QamV6?=
 =?utf-8?B?M3cxanQ5SW1QUUpnTzNRb1lxbzFidVFjYTQ2UExYNjV4anZQVHN0NUt1SmpJ?=
 =?utf-8?B?Q3IvN1ZkZ2tkWC82TnZkOUFmNmVzbkI0TkZGdE42VjRPR2cvUHNtUkR3VDZ5?=
 =?utf-8?B?dzJFUVhpb29BL3Bsa25lWFJlWDhOaVA2aVlBS1F2dUhKbExjMHhYa2pvRGxs?=
 =?utf-8?B?MWk0MWREOVBzZHhsR2tMQW5PU0grbm5IL0VPUWNsVWorajAzYk1SNU9iQkVX?=
 =?utf-8?B?S2JDSXNabHc5alF3SzZYZnhNaGNuNG9JNWpvT0dtamJzdkhOeUIwaXdoeU9u?=
 =?utf-8?B?S3I0WHhlMi93b2RaSmRkajhuaEJOL3RFeEpHMTFVcGFPNVovZDAvRmFDbmY0?=
 =?utf-8?B?WllUTk5ndCs2eklvOGJ5ZUEvUWpwTS9wSE5rNDFIZWIrUEhjM1BoeE1SS0Ru?=
 =?utf-8?B?MFM4TE05d05kaVlVRXdBRkNOZ2ppZ25ycHd3KzArT2hKVGdGemVKS1dabjR4?=
 =?utf-8?B?eUtzZ0J5d3FmUGF3VU1neDN0V2V3Qm03Vi9DellDTzAySXNIaUJjdzV6OFQx?=
 =?utf-8?B?ZmVyU3NTZlJhbHpCcWFEdDE4NlUwTUp3SHNzRmpEWWFLNXpjeng3NnYwUXEr?=
 =?utf-8?B?aUxLTk1Zdnp6NGlPcVB1d25Gcm1YcmJIZWRMVCtxREgzWWlheTlVZWwzcldJ?=
 =?utf-8?B?U3NzZnE3c25GUk5zelJBdVRrUEx4ZFJsd0tVYm9MSWtKV0N2RDNTUlI2cDJw?=
 =?utf-8?B?cE4wR0pCYWYwVC9ycDgwTWdiS2RTaG5xZjI2SXp6b0hwc0hNYkFBU0IwRkgy?=
 =?utf-8?B?aEJ6aC9OZTdCYVpvQmxKY2tQSzdiTVBRZXpLeXZTYXVBRDZGdG5YS2RIWmpM?=
 =?utf-8?B?SU5RNlBpY1ZFa0xFUTBpWk1kR1VzVmR0a24vM2hLbkEwN21JN0FBbW45K3Vo?=
 =?utf-8?B?blZuQnI3cFowTmpqM0FrMEJtZXFCUy9lUFVhbTY2NDFoYnVmSVgzT2dKT0tl?=
 =?utf-8?B?WWQwOTVnREp2aHgxd0FSWTNqK2p3aGNud0ZSNVA0TWFGOUI4R01obm1Kd1dr?=
 =?utf-8?B?ekRXQWdEY0pJNEdZTXFEbUNsa0ZhRm4xVmdmVlZzdmQ1bGN6b2hPZ3oxNlR2?=
 =?utf-8?B?bktCbFBRanNucWFDaTJRVGI0bm4xZmRPQW13ZEpPRXpOeWRPM2dzdXU2dnl3?=
 =?utf-8?B?NFU3bVBMNFVqNXNtcnRDVW5hbmhGdmpFdlR4TzFURUpvM0RiOERYbWpjditX?=
 =?utf-8?B?YzBtNFR6Y3A0eWNONFlpZ1h5NWVKMVdRVFRLbklRN3c4T3lSbkxZWWhXczFy?=
 =?utf-8?B?Ui95SG5sKzM3YXpuL1VPWFc2bjkxMVF5ZWxHNUZtOXF2TGVpN0QvM1dSNWg1?=
 =?utf-8?B?NEhTZGpqNCsrQlVCcm85MGJMUE9wN1ZWd1lFRGlWQ1M3dGJ5Zkp0bmlGSGNW?=
 =?utf-8?B?bmFPQ0R3U0hDTmR5L21nMVRxTmVXYWdVZkFURU14d0RiWXBQM25MTmxJZGoy?=
 =?utf-8?B?TkczcWZWdWJaOGFJVFNORzhxWVZEUWhMUDRRRFdJVWc3WmszZHRrVE5NcVlY?=
 =?utf-8?B?YmQvaEpCcWk2N1JwOXY1N0xQTC94eEc4S3dkaWU3dHdKUTlQQTFiQkZQSURy?=
 =?utf-8?B?Rm1OUmVGVmlXMFJ6Q1lEK3dKUGEwbDErYW9JOHdaaEtURnVudW5iaTMxcGZ1?=
 =?utf-8?B?RUR0aElqVS85R0ZRWDYwZUFGNFoyT3VrKzl0TndSem5WRHhoRklKR3creXgr?=
 =?utf-8?B?THRCa3NtU1V3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3h3K21KQ3ZUUWg4Qng2dFVGUDBuNWgydUFBK21QNVl2cW9NL3lLUCtUV2RG?=
 =?utf-8?B?QzR1V2Z0bXkvekVWMm14VzFGSVp2UFJ3RjZRNVNBR2JiZ1l0M2w3eEhESnVk?=
 =?utf-8?B?RW9oSUhSdHk3NVBUSFhLTGxqT3JKaSs1cmZwVGxaOCttRVVyZ2lvSWplRmZB?=
 =?utf-8?B?L0ppVlB1c2lKcWNvQmZ6N1ZDL0taU21wM2lBL1oxL09qZUdFREhGbzFWT2Uz?=
 =?utf-8?B?RkZPYkFQVE9LWERqTDhLZjd0SU9DTmRVS1hHU2pFZ2h3WUVHS1poQ3plV1JL?=
 =?utf-8?B?OGgvTHRGa0RQbDVxRHJTMmEwTUhDVm5sdzBPc3NUMVFteVZXUjB4OFpuQUtO?=
 =?utf-8?B?S1pXcEpwVVJHYUI4a3doNDRudFZrZ0Y5dTFsU2hCSzRsNFEzbXZySWdpVlBF?=
 =?utf-8?B?S0RjakFpYmhFcWR3QlBTVWJ3MlphWWlVR29jODhSTUxnQVBXOTZoa1BTTnR6?=
 =?utf-8?B?WDRZR0RXU2NaR3FUV0dsVEdGYW5ZbEZNMUo0OTYyS1BwQUhrTHNPN3ZSUWYr?=
 =?utf-8?B?dk1JY20zc3FlM0dpREJGd1FEeG5GRTAxckdISTI4Zm5GcE1nYzNYOHV3TUZM?=
 =?utf-8?B?cVRkUUlXOUlRMUExSlFXMVZWQnJJYUlRT0xwZnNDSDQwQlNnRzhMU1Q3aXNk?=
 =?utf-8?B?aThSV1B0NkUvZVhJam1PaWUvZjVwVFo2VWxsc1F5RGZMT29yQ1ZiZytWZnhN?=
 =?utf-8?B?cmJLQXRmMVF6TEY5OGQ4bG9JbUFpb2dXaURZSUYxMmg3MTh0dGN5UTd6cnNE?=
 =?utf-8?B?TENPVDdlOFFSZ2hPVzR5SjQybUVBM1Z1QzEycGNraUtYZzN3SGhqR1pWLzNp?=
 =?utf-8?B?WkJHZUhjVnVNbjNwdVpxNW0zVHp5R1F2MHh1VWxPcUc5VEhrQTkzSkNPT3N6?=
 =?utf-8?B?c0l0eGhmWG13SytyRjd1bGxnUUFPQS9SWGJmT0Y5ajVhKzNJd0FCUEVtQ3dV?=
 =?utf-8?B?eVBneVVjeXZjeUZUc1dMa2p0ZEdnZU00NC9UWWkrT0hPRzZQL3M4U256YnRT?=
 =?utf-8?B?elZYc1hmMUMrOHByUnR0WGhWUDdGQ1FBcUJVZjdYSWpiVFUwMURRMWJVc0ZM?=
 =?utf-8?B?ZFRFNW5kR0lsbHBlQm5SdzMxeFJJRzBOQU5jMk53azd6L25kbWM3YVFPUk4v?=
 =?utf-8?B?dFNiaGJ6VzUrdk9sMnRtUm1WcUZ3Mk45eUJ1UDdIQlNNVkszcUZreTA4UWRt?=
 =?utf-8?B?TUV1c2NCQ0ZnbkQ0ZGtIYW1FRmxEd3B0VGhBN3hacTBEbnZFczF5L2VwV2t5?=
 =?utf-8?B?WXhLVFFKQ1pDeCtEanREZ01xZjJnd3BiV1dvL3JWbnRXalRFL0VmTXdYRStr?=
 =?utf-8?B?QldSdjRmMGFjMytVWnhlZUlpcEhyUW5wa3JjTnYxa2o4TWY4Tm94OERTaXVt?=
 =?utf-8?B?M29SRHcwOW10OGV2TG9PdUEvM2twVFB5WkkwRzBqOXVwam1WZ0U1V0FFNDZk?=
 =?utf-8?B?ZTh1Nkw2ZCtYWkRFSVdtK2FBMUZTQ0Y2Y1FiWjNZOE1jNWJoaTNiY201VmVF?=
 =?utf-8?B?R2o2bk5lcHlHaTh3dVYyZGZESzUwdUhJNWtYdGxkMnVoNG1ra3BOcFE4cDNh?=
 =?utf-8?B?YUdhKzhEY2lJRGt3cHorWEJsVkhENVdKVDFzUFpqaWRZa2J6QjEweHJZY0hW?=
 =?utf-8?B?ZjFwRTNvdXpLcEh5LzFyMDIxRnJWVy9ZOUxtVDlqTmVBdVFCOUlVaUluOVZR?=
 =?utf-8?B?SXVkQm5LOGYyajd6T09yUGtsZ2p0dE9uWGQzTFIyRWkxa0w2aE9wQzREZnpr?=
 =?utf-8?B?SllrV3YvdC93V3gyWlBkRm9CL3lDMzMyOXdkek5wTVEvL0htQXhycDZlNnFu?=
 =?utf-8?B?QzA1RmxIQUlLRFpZUEMyeXZIVXVhbnlXcjRSQ0J4Um53UmhGMHpPbXNNTUxs?=
 =?utf-8?B?ZEg3UVJKN2h0cTREeE94R0xGYlZCeEF6UmYzdk42RzRFNGhxS0t0OU1EUFJD?=
 =?utf-8?B?YUJ2SDV5bkc2WHB5UitETE85NE56SFpPK1BwcWRmdVQwNjZ1c1B1NHAwaEVw?=
 =?utf-8?B?ZVJqelpoZHZEVXZyN2dqTHNxUHEzRjBhZlJBYVh4eDROZjlZczB3d2hKQUQ1?=
 =?utf-8?B?TldNZHBJakEwMFN0U3VqRzFiSmp0SDZCbDU2MzAwd1NFbTNpSGQ5T0NGa0Yr?=
 =?utf-8?Q?RBlKwBIWqvY2dCqBk4p2hFC0K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iU0EaW9sE6THHvp5fsnV3n3bSd7CqmaJJIN1YamgXMgVym0SyIpxHpiKBoeloc98Sddm/83C5CyisFsxpGtSyY8KINMZ5W/VxXJm52SUX6+8KXhDCDZaOMgD8XLX9PEPF3mt59kToCLrBvzThUUYFhrLEJNWWS5Smh8PqmDQ2JnUr/9+LJTqm2FyIznDgymspqYliDGYATfEVab9ME2JnXQmW+ANOtPz7ixKCmQioRVo2uUChQtKByPDR/q+n6zSAfF2FhQCvkhHdhV2nUF2pjrfXIkoP58ADJ7i/TZJrJ/wTUvEpjNQZWw1Zh+o972UZn8jOfKF82LxPbCwd7LZ9K+v8X65FsztJ9KnOsNdkOYKyz+ZHcWkuBCUX3o3XJJ5H1BlXNSyWfUr5ptX2oEODUdUqN57uYN3wVH2bhL+/aZey3PhOjFj0L0FXQ8MOTvzPJvlNPajrSNxC1xkca6dwtq25JUHCYiM5fE77XTjFAiDZihSc6G3e3ckaw9aidp7RhojJOhUGgFEO+RdQhLDe8QxqDkkWDxxu2xe4derx1NY9bsctoAGin93HTvZfLJBSW0aCfIK5658JVwE2P0a5MZC26is10ii4o98ZknpT8bIO6QHDOo2iUrGQwiUjpMcL/9VTxNDSU6X2azwj5Uc5A==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f8e496-4766-45d1-9357-08ddbfa08232
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 10:57:05.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGvYjcY4PjTXjLRZ1l5xyJmAmcXYT7r08nsqx4OevoBalz/k7QD1CKhuhysrLF8XaPsw4b7K8tFLL6JVO74T6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6351

PiBPbiBUaHUsIDEwIEp1bCAyMDI1IGF0IDA5OjU3LCBBdnJpIEFsdG1hbiA8QXZyaS5BbHRtYW5A
c2FuZGlzay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gICAgICAgICAvKg0KPiA+ID4gPiA+ID4gICAgICAgICAgKiBDdXJyZW50IGxp
bWl0IHN3aXRjaCBpcyBvbmx5IGRlZmluZWQgZm9yIFNEUjUwLA0KPiA+ID4gPiA+ID4gU0RSMTA0
LCBhbmQNCj4gPiA+ID4gPiA+IEREUjUwIEBAIC01NzUsMzMgKzU3NCwyNCBAQCBzdGF0aWMgaW50
DQo+ID4gPiA+ID4gPiBzZF9zZXRfY3VycmVudF9saW1pdChzdHJ1Y3QNCj4gPiA+ID4gPiBtbWNf
Y2FyZCAqY2FyZCwgdTggKnN0YXR1cykNCj4gPiA+ID4gPiA+ICAgICAgICAgbWF4X2N1cnJlbnQg
PSBzZF9nZXRfaG9zdF9tYXhfY3VycmVudChjYXJkLT5ob3N0KTsNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IExvb2tpbmcgYXQgdGhlIGltcGxlbWVudGF0aW9uIG9mIHNkX2dldF9ob3N0X21heF9jdXJy
ZW50KCksIGl0J3MNCj4gPiA+ID4gPiB2ZXJ5DQo+ID4gPiBsaW1pdGluZy4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEZvciBleGFtcGxlLCBpZiB3ZSBhcmUgdXNpbmcgTU1DX1ZERF8zNF8zNSBvciBN
TUNfVkREXzM1XzM2LCB0aGUNCj4gPiA+ID4gPiBmdW5jdGlvbiByZXR1cm5zIDAuIE1heWJlIHRo
aXMgaXMgZ29vZCBlbm91Z2ggYmFzZWQgdXBvbiB0aG9zZQ0KPiA+ID4gPiA+IGhvc3QgZHJpdmVy
cyB0aGF0IGFjdHVhbGx5IHNldHMgaG9zdC0+bWF4X2N1cnJlbnRfMTgwfDMwMHwzMzAsDQo+ID4g
PiA+ID4gYnV0IGl0IGtpbmQgb2YNCj4gPiA+IGxvb2tzIHdyb25nIHRvIG1lLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSSB0aGluayB3ZSBzaG91bGQgcmUtd29yayB0aGlzIGludGVyZmFjZSB0byBs
ZXQgdXMgcmV0cmlldmUgdGhlDQo+ID4gPiA+ID4gbWF4aW11bSBjdXJyZW50IGZyb20gdGhlIGhv
c3QgaW4gYSBtb3JlIGZsZXhpYmxlIHdheS4gV2hhdCB3ZQ0KPiA+ID4gPiA+IGFyZSByZWFsbHkg
bG9va2luZyBmb3IgaXMgYSB2YWx1ZSBpbiBXYXR0IGluc3RlYWQsIEkgdGhpbmsuDQo+ID4gPiA+
ID4gRG9uJ3QgZ2V0IG1lIHdyb25nLCB0aGlzIGRlc2VydmVkIGl0J3Mgb3duIHN0YW5kYWxvbmUg
cGF0Y2ggb24gdG9wIG9mDQo+ICRzdWJqZWN0IHBhdGNoLg0KPiA+ID4gPiBJIHN0aWxsIG5lZWQg
dG8gY29uc3VsdCBpbnRlcm5hbGx5LCBidXQgWWVzIC0gSSBhZ3JlZS4NCj4gPiA+ID4gVWx0aW1h
dGVseSBob3dldmVyLCBDTUQ2IGV4cGVjdHMgdXMgdG8gZmlsbCB0aGUgY3VycmVudCBsaW1pdA0K
PiA+ID4gPiB2YWx1ZSwgc28NCj4gPiA+IG11bHRpcGx5aW5nIGJ5IHZvbHRhZ2UgYW5kIGRpdmlk
aW5nIGl0IGJhY2sgc2VlbXMgc3VwZXJmbHVvdXMuDQo+ID4gPiA+IEhvdyBhYm91dCBhZGRpbmcg
dG8gbWlzc2luZyB2ZGQgYW5kIHRyZWF0IHRoZW0gYXMgbWF4X2N1cnJlbnRfMzMwLA0KPiA+ID4g
PiBsaWtlIGluDQo+ID4gPiBzZGhjaV9nZXRfdmRkX3ZhbHVlPw0KPiA+ID4gPiBNYXliZSBzb21l
dGhpbmcgbGlrZToNCj4gPiA+ID4NCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBHZXQgaG9zdCdz
IG1heCBjdXJyZW50IHNldHRpbmcgYXQgaXRzIGN1cnJlbnQgdm9sdGFnZQ0KPiA+ID4gPiArbm9y
bWFsaXplZCB0byAzLjYNCj4gPiA+ID4gKyAqIHZvbHQgd2hpY2ggaXMgdGhlIHZvbHRhZ2UgaW4g
d2hpY2ggdGhlIGNhcmQgZGVmaW5lcyBpdHMgbGltaXRzDQo+ID4gPiA+ICsqLyBzdGF0aWMgdTMy
IHNkX2hvc3Rfbm9ybWFsaXplZF9tYXhfY3VycmVudChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpIHsN
Cj4gPiA+ID4gKyAgICAgICB1MzIgdm9sdGFnZSwgbWF4X2N1cnJlbnQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICB2b2x0YWdlID0gMSA8PCBob3N0LT5pb3MudmRkOw0KPiA+ID4gPiArICAg
ICAgIHN3aXRjaCAodm9sdGFnZSkgew0KPiA+ID4gPiArICAgICAgIGNhc2UgTU1DX1ZERF8xNjVf
MTk1Og0KPiA+ID4gPiArICAgICAgICAgICAgICAgbWF4X2N1cnJlbnQgPSBob3N0LT5tYXhfY3Vy
cmVudF8xODAgKiAxODAgLyAzNjA7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4g
PiA+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMjlfMzA6DQo+ID4gPiA+ICsgICAgICAgY2FzZSBN
TUNfVkREXzMwXzMxOg0KPiA+ID4gPiArICAgICAgICAgICAgICAgbWF4X2N1cnJlbnQgPSBob3N0
LT5tYXhfY3VycmVudF8zMDAgKiAzMDAgLyAzNjA7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBi
cmVhazsNCj4gPiA+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMzJfMzM6DQo+ID4gPiA+ICsgICAg
ICAgY2FzZSBNTUNfVkREXzMzXzM0Og0KPiA+ID4gPiArICAgICAgIGNhc2UgTU1DX1ZERF8zNF8z
NToNCj4gPiA+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMzVfMzY6DQo+ID4gPiA+ICsgICAgICAg
ICAgICAgICBtYXhfY3VycmVudCA9IGhvc3QtPm1heF9jdXJyZW50XzMzMCAqIDMzMCAvIDM2MDsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gPiArICAgICAgIGRlZmF1bHQ6
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtYXhfY3VycmVudCA9IDA7DQo+ID4gPiA+ICsgICAg
ICAgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIG1heF9jdXJyZW50Ow0KPiA+
ID4gPiArfQ0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgaXQncyB3YXkgYmV0dGVyIHRoYW4gdGhlIGN1
cnJlbnQgaW1wbGVtZW50YXRpb24gaW4NCj4gPiA+IHNkX2dldF9ob3N0X21heF9jdXJyZW50KCku
DQo+ID4gPg0KPiA+ID4gU3RpbGwsIEkgc3RpbGwgdGhpbmsgaXQncyB3ZWlyZCB0byBoYXZlIHRo
cmVlIGRpZmZlcmVudCB2YXJpYWJsZXMgaW4NCj4gPiA+IHRoZSBob3N0LCBtYXhfY3VycmVudF8x
ODAsIG1heF9jdXJyZW50XzMwMCBhbmQgbWF4X2N1cnJlbnRfMzMwLiBUaGF0DQo+ID4gPiBzZWVt
cyBsaWtlIGFuIFNESENJIHNwZWNpZmljIHRoaW5nIHRvIG1lLCB1bmxlc3MgSSBhbSBtaXN0YWtl
bi4NCj4gPiA+DQo+ID4gPiBJIHdvdWxkIHJhdGhlciBzZWUgYSBtb3JlIGZsZXhpYmxlIGludGVy
ZmFjZSB3aGVyZSB3ZSBtb3ZlIGF3YXkgZnJvbQ0KPiA+ID4gdXNpbmcNCj4gPiA+IGhvc3QtPm1h
eF9jdXJyZW50XzE4MHwzMDB8MzMwIGVudGlyZWx5IGFuZCBoYXZlIGEgZnVuY3Rpb24gdGhhdA0K
PiA+ID4gaG9zdC0+cmV0dXJucyB0aGUNCj4gPiA+IHN1cHBvcnRlZCBsaW1pdCAod2hhdGV2ZXIg
dW5pdCB3ZSBkZWNpZGUpLiBNYXliZSBpdCBhbHNvIG1ha2VzIHNlbnNlDQo+ID4gPiB0byBwcm92
aWRlIHNvbWUgYWRkaXRpb25hbCBoZWxwZXJzIGZyb20gdGhlIGNvcmUgdGhhdCBob3N0IGRyaXZl
cnMNCj4gPiA+IGNhbiBjYWxsLCB0byBmZXRjaC90cmFuc2xhdGUgdGhlIHZhbHVlcyBpdCBzaG91
bGQgcHJvdmlkZSBmb3IgdGhpcy4NCj4gPiArQWRyaWFuDQo+ID4NCj4gPiBJSVVDLCB5b3UgYXJl
IGxvb2tpbmcgZm9yIGEgaG9zdC0+bWF4X3Bvd2VyIHRvIHJlcGxhY2UgdGhlIGFib3ZlLg0KPiAN
Cj4gTm8sIHRoZSBuZXcgZnVuY3Rpb24vY2FsbGJhY2sgc2hvdWxkIHByb3ZpZGUgdXMgdGhlIHZh
bHVlIGltbWVkaWF0ZWx5LCByYXRoZXINCj4gdGhhbiBoYXZpbmcgaXQgc3RvcmVkIGluIHRoZSBo
b3N0IHN0cnVjdC4NCj4gDQo+ID4gSG93ZXZlciwgZ2l2ZXIgdGhhdDoNCj4gPiBhKSB0aGVyZSBp
cyBubyBwb3dlciBjbGFzcyBpbiBTRCBsaWtlIGluIG1tYywgYW5kIHRoZSBjYXJkIG5lZWRzIHRv
IGJlDQo+ID4gc2V0IHRvIGEgcG93ZXItbGltaXQNCj4gPiBiKSB0aGUgcGxhdGZvcm0gc3VwcG9y
dGVkIHZvbHRhZ2VzIGNhbiBiZSBlaXRoZXIgYmUgZ2l2ZW4gdmlhIERUIGFzDQo+ID4gd2VsbCBh
cyBoYXJkLWNvZGVkIGFuZCBpdCdzIHNoYXJlZCB3aXRoIG1tYywgYW5kDQo+ID4gYykgdGhlIHBs
YXRmb3JtIHN1cHBvcnRlZCBtYXggY3VycmVudCBpcyBlaXRoZXIgcmVhZCBmcm9tIHRoZSBzZGhj
aQ0KPiA+IHJlZ2lzdGVyIGFzIHdlbGwgYXMgY2FuIGJlIGhhcmQtY29kZWQgSSBhbSBub3Qgc3Vy
ZSBpZiBhbmQgd2hlcmUgd2Ugc2hvdWxkIHNldA0KPiB0aGlzIG1heF9wb3dlciBtZW1iZXIsIGJ1
dCBJIGFtIG9wZW4gZm9yIHN1Z2dlc3Rpb25zLg0KPiANCj4gSSB3aWxsIGNlcnRhaW5seSBiZSBo
b3N0IHNwZWNpZmljLCBzbyB3ZSBuZWVkIHRvIGhhdmUgYSBob3N0IG9wcyBmb3IgaXQuIERlcGVu
ZGluZyBvbg0KPiBob3cgdGhlIGhvc3QgaXMgcG93ZXJpbmcgdGhlIGNhcmQsIGl0IG1heSBuZWVk
IHRvIGRvIGRpZmZlcmVudCB0aGluZ3MgdG8gZ2V0IHRoZQ0KPiBtYXgtY3VycmVudC9tYXgtcG93
ZXIgZm9yIHRoZSBjdXJyZW50bHkgc2VsZWN0ZWQgdm9sdGFnZS1sZXZlbCBmb3IgdmNjL3ZkZC4N
Cj4gDQo+IEkgY2FuIHRha2UgYSBzdGFiIGFuZCBwb3N0IGEgZHJhZnQgZm9yIGl0LiBJIHdpbGwg
a2VlcCB5b3UgcG9zdGVkLg0KVGhhdCB3b3VsZCBiZSBncmVhdC4NClRoYW5rcyBhIGxvdC4NCg0K
VGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUN
Cg==


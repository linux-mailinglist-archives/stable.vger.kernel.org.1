Return-Path: <stable+bounces-87585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F519A6E11
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F0A1C21A9B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED942136328;
	Mon, 21 Oct 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HiTUGUwy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UEEwVnQ0"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945312F588;
	Mon, 21 Oct 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524397; cv=fail; b=rsAugikNvVoCTh4X7tmLSjtoGoNk5QnRMHwi0q3gg0BGADPO5Sx5vTSlyIReDB2IrhpkEIOEzJGB1pssWs1RD199csSCZSB7/mw6IvaNTwrOba2e9UNLKklsItPwbQgDklES3he7U3ci2ZstcjKDwZJ5f/+Xqvm5Nd5ro+TcQco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524397; c=relaxed/simple;
	bh=gV6VkqCmroRB6Jqh1PMyYjUgUIB6TIssvcazCShin4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PjoEYIsviIccYtr0dXyfMOBSw9BuwtWC8zAjJvlXXYQ81wvaU9CwxQTqgbWzUVpfhqXlIyUaYVXDe4J+anKiY7g88rEcfJOZ9QSAg4Q+vG73hZXU/bEPDS2OF0ZVZClSCncLarL0fswaFQSYe8hzvHw8wJ3DbjyMmYiWpvjhRGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HiTUGUwy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UEEwVnQ0; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729524395; x=1761060395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gV6VkqCmroRB6Jqh1PMyYjUgUIB6TIssvcazCShin4A=;
  b=HiTUGUwykfirKl8LPltEpKnCEX6Mx2fdZzjl681sG5ZErUM1TlJ1KL4T
   1TpPUZFyLS/U+RjzEnEGUm/P1auZU81a7SsOZZs/IGi0bnf5+GFUXOPAr
   pRQloLJelE8VtUmfjmDLuZrZhMZ3QLLK+ln8GsqP2p6y25rTF8rengxeY
   +IeQYfMsjtQPohoP3fXb45IU3nuJGw08MqU4canvDi7XE+GTIqjWLcObP
   GDpNZBRNGxw2cG9eF9BZqcwd0bB/wzGrBCEVX0pnozeLWpKZn9GZ5Ma6A
   wcxhpUJgMY56Ed9yC8d1X8pDnpDSFz3yQ5SWU12RnImo3d2lWTcAOHyJ0
   w==;
X-CSE-ConnectionGUID: TVq9RQU3Qi+GjV6zlHrulg==
X-CSE-MsgGUID: YX8AaY2NTBWtiKZ+T0OHKA==
X-IronPort-AV: E=Sophos;i="6.11,221,1725292800"; 
   d="scan'208";a="29505105"
Received: from mail-westcentralusazlp17012037.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.37])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2024 23:26:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICsEUeVSNVoQ0DwXAkz4pfg6VzRz27GU25AHIGgsM5vUBBg7h8IfRuwFPOmxxCEmwxDxlZdwrpQqZzna/qkE/r4kmZB7oy3rsQJSw0VY495qbTShEW6ZkRPwLygFJ/4QbI9+lIHf2cCNQYSsCu1+4AtM4rn3VaBp3Xw54gkuWERcVdOQNedJ9ifk3V87KUQaRZPF0Y9fCYI5zrmqs8o6h72zoYXPTQUfsCTNhNZHUAE9BHOForjTe6j7eReG6q+lnAhfySxK3KWoDhmkU+r8ITXyuvZAkq9IceB8t30xywlTASsUDqc2Fxg94nlyG4KPw3cGjplwJb1xpdp+ZC5wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV6VkqCmroRB6Jqh1PMyYjUgUIB6TIssvcazCShin4A=;
 b=rwnjP4iMrKWwWMwoELrSJpOZRrN2mvU5qXqB64YMPqxAdQ5ssVigSiE3zv3xhTooLUv6TGNsCT9kNVUz6xrpWT7n+tCaHsbC0kXmWk/scfXOqDtHaJhQNtwRLZvA+mvariSWDxuwQVfxkiwae2CVWlkuz8Gy6fv5fhxD1NiJzheUlR72VkBJd+/fPwWaSiT1xfXzwVSq7LreV7K0WV1xhY4XJ2sngC+juGQi990GfUOs5q3KD7zAJi8ByjeLAPIaCRqRs5AizSxulCcMpVab01y3JUDGQXPkf0enw59yAo1At6SAywtSOfJV5PUgtw4h2IMiN+qdQ6B5uW51IWTkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV6VkqCmroRB6Jqh1PMyYjUgUIB6TIssvcazCShin4A=;
 b=UEEwVnQ06o/zHd3QFwEuVJ7HBhWrxKd2VXqw+mT5nHCpJhESyL8CggBP2nLvB4XNfpAqCiEwd4oZ7TeLnzIUbbJOY7RSIzwMzcaYuIfzbwCFYVTN9FZTht0eHaxKCtFnxLZtO2A5H7QRRnrOzusX4yEMGNcG+RoaSRAL5bRWSzc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB7540.namprd04.prod.outlook.com (2603:10b6:303:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Mon, 21 Oct 2024 15:26:31 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 15:26:31 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
Thread-Topic: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
Thread-Index: AQHbIR7z/IHDru1ufU+CK8sxs4Vgg7KRCvWAgAAaFTCAACUjgIAADpxA
Date: Mon, 21 Oct 2024 15:26:31 +0000
Message-ID:
 <DM6PR04MB6575B9ED410D7A869FAC7E20FC432@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241018052901.446638-1-avri.altman@wdc.com>
 <59f6c217-d84e-4626-9265-ce5cd8a043f4@intel.com>
 <DM6PR04MB6575EAADE9A5C775C0837361FC432@DM6PR04MB6575.namprd04.prod.outlook.com>
 <0ead8466-a068-4e1f-93aa-47dc269b5b62@intel.com>
In-Reply-To: <0ead8466-a068-4e1f-93aa-47dc269b5b62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB7540:EE_
x-ms-office365-filtering-correlation-id: c8d429d1-a6a0-4af2-4c95-08dcf1e4bda8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVJVdXFPd0RGRjF1dmRJWnJQOGFwUmFuQzcyaTNqM2VEQ09mdnBibm1JRW9L?=
 =?utf-8?B?UmNpWGU5WGREUnlRWGR0djZ5czQ3TkI2NUhWWVFpWnRSS1N0YzZBbmFTdnpn?=
 =?utf-8?B?Z2tmc0RZQ1NFSlA2bkJtRGdQbFdYaW5YOUQxbmdGeHBwVDRDcURTNmhUeWNM?=
 =?utf-8?B?SStpRndZdmJHWktLRlJaU1A2Q3ZjZ0dOK3o1UTFkS0puYlFnUTQ4S0tUR1cw?=
 =?utf-8?B?OGNENVBsUFNkUkh0dlI4MmNCZ3pQZmFPK3cyV2VHUFpnOG5KQUduSTdicG4w?=
 =?utf-8?B?eDdrSHh6WDZaQzdNY05KZnZ6cnZBTC83Mk0zWmN0NnhEclhpREtjNlZuUFQ0?=
 =?utf-8?B?NVI2c1IzK1lVbGQ5bTIzMktGUmpTNVdIbU9xRXB6MlVvRlpPcFI0dXFCekxz?=
 =?utf-8?B?VHNaZXlsbXRnNmI3aHRrSExCVWFDSVZZMkptM2Nyb1NMQ2ZOcEVtQXUwU0Fz?=
 =?utf-8?B?UGJHaG5RYXhHUHVaNU9xQWY4ZXZOc29GTWhLYVZOSHdLWUEzbUN0dGtVWGN0?=
 =?utf-8?B?RldmMjlwQ0FJL3hRNVZ0bDlYazlobm45TGJRTWdsRnVUVzFjNThHc2VvV0lS?=
 =?utf-8?B?ekJWYzl1YWJOTGJsQjY2a0tMSlFPVzFjZGtNa0Jrcy9Mdzc0Z254VFdhbmh5?=
 =?utf-8?B?VWFudjg1VXlISXc2K29QTExQK3pOY1NackJSd0xod2lHcVluODRLLzNUMjZY?=
 =?utf-8?B?Y1NQZmxsSS9iT2NwdWdHczFsTEZjWDJON2R0c0RPMXNUR3RFNk5BOWxQcWxl?=
 =?utf-8?B?SmNLTEU3TUpPWHJZZC81S29yVmRjL3N3eURTKytkRndGbEs1dUIrSEdUVDFq?=
 =?utf-8?B?TUR4OEY2ZlcvRlZzaHdBU04rbElWTktxdGI0L3RmbzZGZm1Ya3VDaGZ1L0hv?=
 =?utf-8?B?TEsrd250Yy94US9CejQ4RXRqT2hXTmpxYWdKUFpMUGJsdUFHUE53eFdZdFFQ?=
 =?utf-8?B?R3JONG4yZjRRVWpUMTFYaTVZYUljcEFRWEpPdUVubExGRWdiTmJQdW9MUm9Q?=
 =?utf-8?B?dld2SkdpUVZNeGNCaGhTaDVybkdaUTZBNGQ3ZHJWcVYxK3pvc09TSzQ3ZlF3?=
 =?utf-8?B?M01uaDIwYmxxNkpOcjdvaExsc0JJQlliY2ZyZXh6L2dKNG9wSnZJZUhKeG80?=
 =?utf-8?B?SVRGcUlmcXhEUlNoU25qOVBJZDVTaHlHT2VHQWw0azIvNmNZeXpHNlN5bk11?=
 =?utf-8?B?Ym4wVVFWcFZMUkZLNzI1RC9NYnYrd2FnL0pCUCtzQWdCVjA2cjVPdG1qcHN1?=
 =?utf-8?B?MHhuaFVDNEg4VkpIbEp4amZGUDk2clRTVEQzam5rbUVBT1UxREo5QzEyRjdB?=
 =?utf-8?B?bzBUK0xCUDFad3c2d0QyZzlYR1RvTUErdVkvL0ZydWhWOFJ2Rjl6bnhHcHpD?=
 =?utf-8?B?VG5UNXh0R1A5RklnY0JnZHlxdlZIc2trSzRuVll1clNQVHQwdE9aWk11RzFN?=
 =?utf-8?B?dVNzK2Zwb3g5SVlIVjEwNm95d21TZHpuMjh4VXp1ZENwZGlWY0psaUpBMito?=
 =?utf-8?B?OHJRY1VadHRYOXBScGYwVk5xVGNDTHhRTEtDeUhIU0tuWFJKZVhyYUR0Y3Z0?=
 =?utf-8?B?RlY4YUJHdWZOYmhoNklFRU84cVBFZm1NQUNuTVhhalZZVUxscitpR1Avb1JN?=
 =?utf-8?B?R1RBREg5Q2kxV0pQcUVvMU90ckpiUXhsK0VWclllY3VDOEpzT3UxN21DSG1k?=
 =?utf-8?B?UE1FcDMrbjBRK2cxbTZQM1JHb1dPcTJ1T0didk9Fa1d4S0dibmZKbXVuc0la?=
 =?utf-8?B?dGlPZkRYeFNtZUNsY2lrNlZlUkZ4WEFKL1V2dEROVnYwUzZpQVdYNUt6VXRh?=
 =?utf-8?Q?qsNLUnTSa14Fsl9C2YYvZG6GlzeEkIdRUacsQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vy9zdDIzZ0h6dzR6dUpvQmhOUklBdVZyR1owRWN2L0NvdHp5VUZGOFJxWjRO?=
 =?utf-8?B?QXhkSHQrZkNuSUNDS3dQN2l5Ky9NdXpKOEN1K21kaHJWRnQ0OEhERFBKb0F0?=
 =?utf-8?B?amsrazFKZVQxczJZVnNLcW5PY3RJZy9oL2o2bjNBdloyL0pIczQ3UXJyS3hu?=
 =?utf-8?B?eFNCaXhGZ2hhR0tQRGlwRmd0QjZ4anpMaU9jL3NPMFJtQlFPU2JEY3dVTWZn?=
 =?utf-8?B?dFFWM0pUY1M3cFZTS0FZcmQvK0N0OVR2TVVsS2JtTEpPck92WGFySE95QlI0?=
 =?utf-8?B?Qkgrbm1RWHhDMFJJZXlDRGMzSTk0RmUwRyt1bHBqUVQ2QzA2VkdWbENFMVFR?=
 =?utf-8?B?OTFoQTR2SzZNNW9YSXE1OCs0VnJ2TGFka0RLU1RtTi82bWxGbmxqdmYzc3By?=
 =?utf-8?B?UWl3cFRKNGxkcWNlN3hHVjhPRit6Z2kxWkFXK1c5NkEwU01TWVZBbG43OGx0?=
 =?utf-8?B?RlY5dE1hUytXVktZWmp5U1YvOUVnNi9ubHNyUzhXRFN4U3J2TGZKUTEvY2Yv?=
 =?utf-8?B?MWUyUUw4OHY4NTV0SUVZWWpDdllyN05obUMyelF6bXArWU45eC9qL3N2b0Iz?=
 =?utf-8?B?TEVWcCtVQmQrVndUNENYZUV6NjVOb2V5SnhBcHRUQzMvM1FSc2lLKzRsallU?=
 =?utf-8?B?Z1lKdUo1ZmM2QkMyL0h2UDFLVUR6a3VlYURKKzhNZFk3YjNVSmh6TVJOeDEr?=
 =?utf-8?B?QXFLR04wMTlQdU41STJnei9lSVpINGJmNE9VQzArYkhYelN3cHNSdFZHYity?=
 =?utf-8?B?L2JxNEk0bUhaTUU3TFkydFVhblVad0hXMGI3U1V2UkM4WEx5L2tHcitwdVZE?=
 =?utf-8?B?eHlYYklsZ2JIQzBGWjZaRGhubEdlZ2F2L3ArbW9MSlQ1RzFyY3FobXRsSkl0?=
 =?utf-8?B?ZjBGVDJpV3BFS2VGcFA4VUVNWENVY05mRFZzbG55bGUxL2FyMmJ0VEFMRTU1?=
 =?utf-8?B?UWV6clk2U2VwOTFnRnQ3L3lnYy8zK3BmWWxGWUNoT2ZzeVFXZy9ycjQ2d2o1?=
 =?utf-8?B?YUtjTSttWjdjQkp6MFNDSGVXU1ZhaEJkZmZCbUYwYWwrY0NtWTgzcTBDZVpW?=
 =?utf-8?B?MG5QNnNDRS94TkJ0dFNZWXJ5d3FzNFRJbTVyWmVGTU10K2UyTGZlaERURCtR?=
 =?utf-8?B?OUhwbDhzeUtUcnIvOWJId1orcS9Jdjl2ckk4SExCdVQwWitvcVZlTHFuOWNv?=
 =?utf-8?B?RUFPT0l5ZnZMZml0TDlwOGdXb0NVVUE1NDUwL3hCQURuYkZRTmFvS3hSYUl6?=
 =?utf-8?B?WnA0RnQyOFRGWnduYkt1VFNlVTl0aTVzOTRNemJGNDQxMnEyTUtEQmFiN3dl?=
 =?utf-8?B?bk05R2dja0I0M0IzSzJuWGt0SE40emNkZ3lKaEtaVWQ4UmJZZk9pTFkxRFpO?=
 =?utf-8?B?VXM3RlBlT21YZWRCcHhTMlQxZGNUMGpvbk9rMVBWQktMM3Z3NXVQcUZYYzlv?=
 =?utf-8?B?OHhXcTc2aWo5SDIySGFUdStGMjZoNG5HSU1MQzZ5OFVTbUYrNFI4bE1QVFhk?=
 =?utf-8?B?L3dzVHQyQ3E0V2drYUtnZS9lNjgwSmxCZVRJSGlKMnFpMzV4MkJHeGZQTmNj?=
 =?utf-8?B?T0JWOUZVT2s0NkZXckVLb2tPaVByVS84dnBMdHAwZDRUbXpCNzV0QUpaaFdm?=
 =?utf-8?B?UU9vRGhqSGlmY0ZHMGtLemVEMTEzS21kZWcwTzlsdnIrZTF5U3h2S3NqODhV?=
 =?utf-8?B?aGJISDlSWjVnNm12KzhMN2pBZ0hTYjZDYkxsR0NiRFR6bWZKSDRiTm9EZTRw?=
 =?utf-8?B?RWJ1WmJONWxURVJrU2psN3ZuVHBKN3BqTndmMUppRkNNRjNmY0lvZy8xTmlQ?=
 =?utf-8?B?L2xDZUJxUnFWeG9tNzVodXQ5L1J6a2w5MmZjUHNkZkJabWkxcGhRNldVc1hL?=
 =?utf-8?B?b2x0SUhWR09WNG5OWnNDV3h2NUNUZVNyNThjVDNGSVNFZlRnUFJiMmI5MGt4?=
 =?utf-8?B?QmZhMmw4K1p6dWVLbjdnUXdEUllXa2JiUVJjaXE1U2tNOHJnZFlPMVUzYjVa?=
 =?utf-8?B?d1EyWW9CNHgwZVhVSGlCZVYrMEp3ZTIxZTR2eGx1NWFMa0t6dWM4REtQTlJE?=
 =?utf-8?B?dk1XZzd6V2FFYXNsUk1hTWVHMlk3M0lRclMyQUloUksyTWNtMnNDMFdGN09E?=
 =?utf-8?B?RHlpV2MzRjFDWURCVkN5bUZmTDA2dXVub0k2TVRtaGNpK2M0NzB4Z2RjVXdY?=
 =?utf-8?Q?Wp17CT5KK2JfGtWiq6GraD/2zMXqQoXrh1w3ICDUm+CR?=
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
	YU4yL6j+d99ISKAQq/QsQJ8PMZXg4IdXKa0AxjRrXpmJlBg7B49A4uJpNGvWkEky4OCwZ7VZg5b+Rq0CR9DkBUcfrD3OjIBpTtSpcTRWqltbAeClks/2d4IgZDMf3GaVNbAKYDBoFt92Pt/ZT1wC4zhT/bETmuLGUllpoYn1WjyABerY0fOy+lb7dt/2PRqMP0/AfcILjf+rPDKLFkdiQYeSu6KdgR6+jfGYUpOQgEbGaIUw53AUM1xXia+eDBEFXEYWs+K68OqhhVjZc4Y9FDcIk9NC5J3N2wWvLGYgYiRaFovovxOTdc3yUUJI9tPx9kmAIAyvBVK3XACagzlNBJT+Cw3CyPFq+KF53BohAUHqnKeNC4cWKgUDuq9uKNMzQ/Cam64ESEBoAbxdBWNpkMfoLxbvPRUJ8EK/tzepNPO/nphdcha34t9uBYxSrtdVkrOikSkT34d46o5IHK60Ed49oJNuydjx/HWaA4uYOMvN605XTTjqjK7J4ap/ABUfPS0NnY7v96NApXuUIR56Hezq+O6WP9bGMt8EK+yeP9s6cXwOYibVN4mNlklrcFM+6K0YV189dQt5HwLQaJesSm1sd8FfAOM1T6ZNYael/ojaJOmm3dMUtbBStlFjdCPK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d429d1-a6a0-4af2-4c95-08dcf1e4bda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 15:26:31.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDBaf99ULg3tolwlXJM18yvQz7PwsT+FWVTNvz1Mdi5Rb3WjPJOhid36nrSbbqIkKi+XNK85A8CbWLarKUDm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7540

PiA+PiAgIFdBUk5JTkc6IFRoZSBjb21taXQgbWVzc2FnZSBoYXMgJ3N0YWJsZUAnLCBwZXJoYXBz
IGl0IGFsc28gbmVlZHMgYQ0KPiA+PiAnRml4ZXM6JyB0YWc/DQo+ID4gSSB0cmllZCB0byBsb29r
IGZvciB0aGUgcGF0Y2ggdGhhdCBpbnRyb2R1Y2VkIG1tY19zZF9udW1fd3JfYmxvY2tzIGJ1dA0K
PiBjb3VsZG4ndCBmaW5kIGl0IGluIFVsZidzIHRyZWUuDQo+IA0KPiBTZWVtcyBsaWtlIHRoZSBm
b2xsb3dpbmcgaW50cm9kdWNlZCB0aGUga21hbGxvYygpDQo+IA0KPiAgICAgICAgIGNvbW1pdCAw
NTE5MTNkYWRhMDQ2YWM5NDhlYjZmNDhjMDcxN2ZjMjVkZTJhOTE3DQo+ICAgICAgICAgQXV0aG9y
OiBCZW4gRG9va3MgPGJlbkBzaW10ZWMuY28udWs+DQo+ICAgICAgICAgRGF0ZTogICBNb24gSnVu
IDggMjM6MzM6NTcgMjAwOSArMDEwMA0KPiANCj4gICAgICAgICAgICAgbW1jX2Jsb2NrOiBkbyBu
b3QgRE1BIHRvIHN0YWNrDQpHb3QgaXQuDQoNClRoYW5rcywNCkF2cmkNCg==


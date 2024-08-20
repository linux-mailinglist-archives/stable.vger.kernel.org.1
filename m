Return-Path: <stable+bounces-69695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDBE95821E
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12861F210E6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 09:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555DF18C343;
	Tue, 20 Aug 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QlNF57xI";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zKltV3u6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AF18C32C;
	Tue, 20 Aug 2024 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145941; cv=fail; b=JQQz8u7Ra/ejzyq8dUOpt9zVMSAxJeBgWKUZYM/uORs39y7aqExDCEyEupLYp9Gvrt0LqXb22AQ5oOKKOLNrf8V1w5i2K9HrNMq6/SdFYoSW2Kkrpo27yKknAhCmgNsHWTl7yMood2QpiXkfW9pqIXPbWWlege1/G0Pg2R7oJp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145941; c=relaxed/simple;
	bh=DH8/waVyNHsMn90dKCVRyDXN0BApNOW4LrSdqhDd6Fs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vFrHgjECY54ko6JQJg1+RU6KyaHQfizTkJg60iY8dF/i45T+Lv7FX/WhmkvEAWMYU0hel2LSoPBCj2qzdeOAg3Xm69Y+DuG8ykPWemUlYrVdpAEM2t3k1sM5MqR125fKUvQcviqwfxRpuvogLBPPxKKi/5HRYd3L2VaL6n2Jw98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=QlNF57xI; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=zKltV3u6; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5GGtW023416;
	Tue, 20 Aug 2024 02:25:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=DH8/waVyNHsMn90dKCVRyDXN0BApNOW4LrSdqhDd6Fs=; b=QlNF57xInrUP
	5O5T5v/iNrfMq1DPHRfUJ6uTodkMIIxgG8GlYSG3gYXeGf4+wBcGjRrDbh5SYUln
	9WsMXb2ZpFJIbir3O0X34mB2t7wrd0kRwlRLIV3eq9PhYTfy81WXgpYoVun/oLTm
	2wK8OrZPr2dZ750U6fgFkMVLYc7L62VrnuJ8xViCRG2s53/jb3+tOr9W6D4PeFeI
	GeFRUCsYoqu6bokqHYhI/GHMzRFqQsDVrsRTJgjbL/hK45DffT0g0sZ6inKomRR0
	ExlGbyhhdb/CMDmUxtNv4EmsNmkOkthrkqFDVY4ACfAjBr1pLLxrShMVZbYADjhX
	baUWQiqNFQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010003.outbound.protection.outlook.com [40.93.20.3])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4147uauexq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 02:25:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiN/JkU4bHMp/rADNmq+JLZgOM63fiweLTl0+iEBB65/3yKgkhEUhp3hZmqHzRpSQVJetlNEGsbuihJlbHPv3yc9FRQ19lkuWk6sjsKdVdygxid5DFMPz9gdz3yJedr1ShoYIPqa7dYP9mEaI7X2CoWfYXa/uzcFDJkBR6tPXJTpL8efqKJ+Aa0F3ZX+kNH/pRwo0yHT2xozliCgX29+zhRaObOhXTby9OATK1zxojPnuz56ddX6RmQ+vtL2d2DaO6tTTDwADz4rg9y4Nbkg9VyL95jcxNM5o9mQP4Dk7SoyXewCnUlQcpaBHE098b7SoIDEwOkdzSuYiP7MTFUH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH8/waVyNHsMn90dKCVRyDXN0BApNOW4LrSdqhDd6Fs=;
 b=gtiBrTZMDgCDAueNc9HGQsCwnIOtbpyFnCttLRf2+bFfL2yp5fyhoJd7TUYS1h9dl2DZciR2nyXLg4iwdidRU/EVW09aau7rI1XNuSrfxbMR9jbuN9BhIBPFg8n5yTeDSJIxIqcA59o3Yt2/a3sQ9CmfHLxr5Ds+TMmM4BkebsgetPA9TDvm64beKOqqW4kbbu+5W/EuNHPydmss0OpINLkcdw87liYQk/luXNntlLra+lZ0Qzot9p807ckVLb3HTP43+Wk2mQQ4JVkuCL11SbGLoMYZJjnpUZqgnXe0CcJebGJSB4OWxmXz9KVcAojocU2PxM5yi6B54vjQQbrE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH8/waVyNHsMn90dKCVRyDXN0BApNOW4LrSdqhDd6Fs=;
 b=zKltV3u6cwH076oyETJnFDeKeAPElGYK7PPnBw8i08NPsX7C1Gl2YUrmByHL+Z1lYobm1PpDB4R2o4x1vo6/pAE3LrtMnRW1NKgiQei7QSlzEZm5bG0KxzOWcrNahFv2mlGGhfRKlOe3bQJ33riy2rjufpUH/PwAqgBKWufClkE=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CY8PR07MB9596.namprd07.prod.outlook.com (2603:10b6:930:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 09:25:29 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 09:25:29 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com"
	<mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Topic: [PATCH] usb: xhci: fixes lost of data for xHCI Cadence
 Controllers
Thread-Index: AQHa8fQPQBbEkmW6/0qefp5BtM/qt7IuBGuwgABpnICAAWlG8A==
Date: Tue, 20 Aug 2024 09:25:29 +0000
Message-ID:
 <PH7PR07MB953853EB6AF92AD5ED02A304DD8D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240819045449.41237-1-pawell@cadence.com>
 <PH7PR07MB9538B91A187B4EB8654BB2EBDD8C2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <bb592346-7a71-436c-ab68-62701e38015d@linux.intel.com>
In-Reply-To: <bb592346-7a71-436c-ab68-62701e38015d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTIxNjJjYTczLTVlZDYtMTFlZi1hOGIzLTYwYTVlMjViOTZhM1xhbWUtdGVzdFwyMTYyY2E3NS01ZWQ2LTExZWYtYThiMy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjkxNzIiIHQ9IjEzMzY4NjE5NTI1NzkwOTQ5MSIgaD0ic0hLSkJEaXBYYXJVdSsrdHU3Y1l3dVh0WFhFPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CY8PR07MB9596:EE_
x-ms-office365-filtering-correlation-id: 3e5068d9-622d-4af8-0ed0-08dcc0fa085a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlViRUZxazRPODg4czFtNXBQbW93OFR0TThKSnF2TGNOOEc3R1V3MG5XS0x0?=
 =?utf-8?B?Vk12M2V2dkdYWFVsNUJYeHNpeDRDWDNoTXoxb2RQNnQ3TGNMVmx1Ty83ZzRt?=
 =?utf-8?B?aGhudzlyODIwRExoTDBudXhDR3lyQWp3eGE3QXRML2RyT0wraG45dnNncnFU?=
 =?utf-8?B?UmtyMWJ5OHJnZS9CbnZqMFhRM2xpSWJsSG5yQWlqcnl3SUF3Q1VSdlgrWkZw?=
 =?utf-8?B?TFJHWVNpdksrdVdFbGxpNEhtR2RKeTZrMVZJelBJK1E5OG1mUGRQUEJBKzFC?=
 =?utf-8?B?NERSNjlIRTMyUi94aEl3aldPTnhLNi9zS2VRSEpiVHZ3OE9ySUtnektkcVRW?=
 =?utf-8?B?MXRFZmtRdHBCVDBtRGROdTNlSWhPdnczSDRxREp3VisvTUNPUXdiWWZYNVVv?=
 =?utf-8?B?Sm9KNDBubkVpUFFJU1IyS2VEeFVUcUhCVXpWRTdrRUdWaUp3TDM2RnJnbmlU?=
 =?utf-8?B?bmlqRVVSUnoyNjh1aGw1S2xHSDloWVl4QWJMTm41N2RkRlBGeVpXQmMyQ25q?=
 =?utf-8?B?ZU5ZSzdqVmxyTkpJOUNoMmZxeHh5OUFZbWUzaExMSUJ1U1U1YmZtRkVFRGhB?=
 =?utf-8?B?SWNmNzd6Zkhvc2dZdW5Kd0NoL09ndHk1by9KekJOMHl1MmlBMmN5YURSY05v?=
 =?utf-8?B?S2ZndDB4SlNjYUtPOHUxSGZOWStLOEQrUDYwVHAyVUloeU5XUEJrZ1VaVEJ6?=
 =?utf-8?B?bU4zMUFFZnl6WUVtNnNRbk9ONUxSeUVKZ2IyeEZZaWFxZDJoZkRWc0VIa3Z3?=
 =?utf-8?B?MEEvUnpVNTkyYWhvckJoY2JUVk1WR0pDODkySnQxbkR0T043YVVZWndvWkNv?=
 =?utf-8?B?ZFEwTUp3dk55dkFSODRNajR5bXA0U1pTeUpMSDFIcDJSb1ZsdThMdFBrbG45?=
 =?utf-8?B?MkxFeVY3N0NucG9VcFFyT2c4WndHTVMyRnhqQUJqQytqdjFqL1VOM0FYSlpp?=
 =?utf-8?B?dFFoclVJQ1hFd21nRTE0Z2k5V0pKT2RJTDFzYkQ5Rjl3YmEvc0FIQlltSmlo?=
 =?utf-8?B?N01oekZWZTh4aFZPbVpBNVVGc0x2Zy9pTVFBdDhWc3RFWm1VdzZlcEk1NW95?=
 =?utf-8?B?MkpPVHhQQ3JJdk96eGFVM1BVUjRWQVA5NFplWUYwVk9nbmcwOU53ZW0vR1dR?=
 =?utf-8?B?NlBzK2FEVXFhR21GZGpTcUtocENISEZ5NFRBNjl2eStTWkZZRGdjU1ZDdy9P?=
 =?utf-8?B?dFRwcmcySFBhRDlWM3VPb1dpaFZnazN0ajA1bzNOUnpDVmlDSFFHNzdkSk0z?=
 =?utf-8?B?eFZTVHR5bW40R1A2cS85Tm8wQ1hMcEdIV0E1dmRtK3BTeG1JTkFHdE1VT3E2?=
 =?utf-8?B?c1NUcWFuMkVKendvMDdTWis1ZXJnVGZCejQvUUtZaStnUHFnaE5Tc3lSTW9M?=
 =?utf-8?B?UWlwdnQ4MzZkdE5QelhWS1djUWx5TnU5WHBPMHlnTDFQL1dybjFsdEdLcnRU?=
 =?utf-8?B?aXJFRHV6eGV2TkthTGJ0bmZkNVluQUhtVWlLbVNaeldrS044azZROUVTd1A0?=
 =?utf-8?B?cjA0SkpaNTN3UmFiaFV2eDF0TWcvblFhRFZSdGhUdGJEYzBVcTFSUlBxOCtS?=
 =?utf-8?B?WWJEVjBKeTRrMU1Za3ZYM210eWV0VzV2Uk5uRXVyNXNIRmJValRjY2pKZ01W?=
 =?utf-8?B?K1VESWdyZTY0aTZPWHliczdFdGtxbzBRZloxZU1vWGJza3ZiUXRyR2FLL0dB?=
 =?utf-8?B?NkxjS1VKMDN0OVVybHpYbkpVZVU3VVAzMUtwNVBjMVVVSlRJTnZRaW1JRFJR?=
 =?utf-8?B?RnBvSnU3NlRONUdxTUdvR2JOaVkwR3RDSTJiWDlEclE4U21sT0pGWEcwWFlK?=
 =?utf-8?B?Tm5GWTZoUFhzZXM0Ums3MVVvaHhkMkNIUUdWMUx2VGlQYVBZR3BNMlFlcWpX?=
 =?utf-8?B?eEFnNUhmMzQ5UE9vN2NpSjNreGRLcHJoSk5hZlR4UGw5ZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzZ5cVRSU2x6M3BqR1Fjck1ERE1YaUduNUFoUkgxSklLUmowN3ZKNnhyV2gv?=
 =?utf-8?B?VDYzOGN4L0g2akVJVzNZRnhoeGRldURWc2JSSkZPa1krTUhnT1Z2N25mYkxs?=
 =?utf-8?B?ZFEyMXRCRXNTZzFVWVVRMkRPeVQzS0d5NGEvUGhQUzdhMHNteU5mc1NrTmQz?=
 =?utf-8?B?dUFSUUszWHVDbkttT0JaYWk1QTJQeUx5L2lhVk15NGNXK01mQ3JNWnpFZ3o4?=
 =?utf-8?B?Nm5VVFNiZzJSU01SR0MzRnlVSUpCUnZ4SlQ2aXJvRjU1dlhZNUtJK1Fzd2h6?=
 =?utf-8?B?R3dhRTBUZ0F5Z1d3b0IvNjNOT3g4cytGSTB3dzg3RytkdUlUcTdma3BSMzlO?=
 =?utf-8?B?bjZFbHNEa0JJbjZ4QWxwOVNMb3JLandUVHk1WDZFVE95MTFDTHlOVHZlZkN0?=
 =?utf-8?B?M3V5Tlk1ek5VeE01a0JRM0hvWnFma1lrWnhEV2txVncvT3g4VWZJR0UxeEZn?=
 =?utf-8?B?RzJsSjk0ckFublBBOVp6c1Uyem1oUnU5NFRGcWRVRG01TFQzaXIxSVRtY042?=
 =?utf-8?B?c096dm9YZStTVGJkKzRJMmdnTE5DVHJNV0ZGRkU4M1o1WWVYcHFlUUJoYzlr?=
 =?utf-8?B?ZzNKT3lEL3lsNWcxQW5UNzFhVUducGhvOC9lY2RrRzRKVVkvaHlvMll6ak5T?=
 =?utf-8?B?d1RHWjZ6M2Rxb1F6WVBSZVVqV2U1aVdNb2lVVlNkc2FzelJtWk5QTFNKLzJV?=
 =?utf-8?B?YnkwcEpVMVpwdS9NVUk1dkMzdFd6Z0NzRFI0TklIUlBBZzVvQ1crS0hqRnND?=
 =?utf-8?B?WWpuemw5d3NBYnF1bGgvM1kyclM3NHRtdU9UT1VnNlJOaUpFY0NtL0trMVJi?=
 =?utf-8?B?NEl4cWYvbXkxQTF0aTd5elNpSkp5VGVGZUxRN2ZNRmRXbmRRRXNZUkJ2ZDFs?=
 =?utf-8?B?emJ3RWdUaXo2aFVuNVdjRm1aeFhoSTZLc25sckdSUWlPcmJVWUxqSTUzQmx3?=
 =?utf-8?B?Uk0wS0FRamp5VjZ3UFM1ajdsNlhNdjlNTC9vcjJlbHhmQnlQWkpJall3ZEJk?=
 =?utf-8?B?U0VCRmhHQ0tVcUlaRXNiZ0RBVzR0UFhoc1BkeVZtdjVkYUhDTkwzVnNkWWI4?=
 =?utf-8?B?eTJpb1FyNDlZTnB3ajZhc0VKYjRzNU1PSTlYakVCd29Icm14QzF4VVcwVmtD?=
 =?utf-8?B?c3JpVVo3NlcwNVBVSWxhSFFvTXFZZjdDUU50VVZvc1Ryalh2VDdzc3JLbmkx?=
 =?utf-8?B?aXoraXBOUG9RTU1NengvRlNRM2UxM2xveHdBTkxlYWwxUWJQOFhhOHBPbjd0?=
 =?utf-8?B?ejRJWkE5dnNjTFp0YjJxemxzd3lkK1o2aVZlMzVNS2NKRy9kZ2k2ZHRqR0tu?=
 =?utf-8?B?dXM1bGt6b1JFbm1XbHB5WWJXdWZKcEhFRVJUeGh1QzBid2FWM0NtVlhmUTI2?=
 =?utf-8?B?aDVhWXl3czROYm80N0cycDA5S1IyMTd2QUMzVlFyRnpQME9pd09ld3c4cDRG?=
 =?utf-8?B?QTluL2REQUhqSUM3Y0xvVUpFMTE1TmRpb3FEVXZqRlM1NmVXQTdvYVUxNEhs?=
 =?utf-8?B?anRKdUxYVHN1UzU3a0R4cTRnYnAxeWdMMTZpZDFBOVpsSUNvRTBadGhORkM2?=
 =?utf-8?B?V01CUXlEdGJHRmY2UExuR1JTTVRySXU1aWM2TlBDT3RKSzMxNkpHVjZkTGZS?=
 =?utf-8?B?S3BWNktUL1RqZW0xUnNMT01tVldDV3VaUXl0cUtqZUFZWXptcjJ3SktnbWMr?=
 =?utf-8?B?VXFHVVEraEU4OHBiKzBxOHZ5elEwYmN3TkgzcWFCZXEwQlMzM2hPYnpmbElZ?=
 =?utf-8?B?VTREWGZudDlvZFliT2d1T05ZU2pmN1haK1dYK1dsRmh3V1ZhN2tsNGxhSURj?=
 =?utf-8?B?SUlnVitFYVBTRDlwNnM0QytiQ3VlMFV6d2t1MWZnTmgzejZscElMTGJoci80?=
 =?utf-8?B?eGJTUHplcGNQeGZQaWMzT3o3TGEvNUpTSnV0ZnE5Vm9tbU5mNzNPYkxMLzRS?=
 =?utf-8?B?TENxdnRuUlJEVDBLTkRxMGdXZTh0eTBEOVBVRlgyeEdzbG5vc0RmZVB5eG0z?=
 =?utf-8?B?WnZBUDRqZ21Md29XTHprNjdVc2gvd0MzeWFWMFdtU09iMXY2eWNsZFNEeWdX?=
 =?utf-8?B?eEZSMDFaeDd2cHN4QTcyNTU0WC82Q1RHcVZjcEl2QklGYURIbVR0Slc1RlJa?=
 =?utf-8?Q?ESS72DbOOCykfoCFz76jRag0e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5068d9-622d-4af8-0ed0-08dcc0fa085a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 09:25:29.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKoBZa16mUEniJ8Mr2P3+Lw69BbckDOWYpYn2cFezyyxNrrpf7JfpV3KyE+Hd1MihowXMsksJFAClW5+lHniqmszUnjAUy/fSMiR/j642Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR07MB9596
X-Proofpoint-ORIG-GUID: SVbZJ3mwnK44KkwFHAd5Mv-EHFA01dXk
X-Proofpoint-GUID: SVbZJ3mwnK44KkwFHAd5Mv-EHFA01dXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408200069

Pj4gU3RyZWFtIGVuZHBvaW50IGNhbiBza2lwIHBhcnQgb2YgVEQgZHVyaW5nIG5leHQgdHJhbnNm
ZXINCj4+IGluaXRpYWxpemF0aW9uIGFmdGVyIGJlZ2lubmluZyBzdG9wcGVkIGR1cmluZyBhY3Rp
dmUgc3RyZWFtIGRhdGEgdHJhbnNmZXIuDQo+PiBUaGUgU2V0IFRSIERlcXVldWUgUG9pbnRlciBj
b21tYW5kIGRvZXMgbm90IGNsZWFyIGFsbCBpbnRlcm5hbA0KPj4gdHJhbnNmZXItcmVsYXRlZCB2
YXJpYWJsZXMgdGhhdCBwb3NpdGlvbiBzdHJlYW0gZW5kcG9pbnQgb24gdHJhbnNmZXIgcmluZy4N
Cj4+DQo+PiBVU0IgQ29udHJvbGxlciBzdG9yZXMgYWxsIGVuZHBvaW50IHN0YXRlIGluZm9ybWF0
aW9uIHdpdGhpbiBSc3ZkTw0KPj4gZmllbGRzIGluc2lkZSBlbmRwb2ludCBjb250ZXh0IHN0cnVj
dHVyZS4gRm9yIHN0cmVhbSBlbmRwb2ludHMsIGFsbA0KPj4gcmVsZXZhbnQgaW5mb3JtYXRpb24g
cmVnYXJkaW5nIHBhcnRpY3VsYXIgU3RyZWFtSUQgaXMgc3RvcmVkIHdpdGhpbg0KPj4gY29ycmVz
cG9uZGluZyBTdHJlYW0gRW5kcG9pbnQgY29udGV4dC4NCj4+IFdoZW5ldmVyIGRyaXZlciB3YW50
cyB0byBzdG9wIHN0cmVhbSBlbmRwb2ludCB0cmFmZmljLCBpdCBpbnZva2VzIFN0b3ANCj4+IEVu
ZHBvaW50IGNvbW1hbmQgd2hpY2ggZm9yY2VzIHRoZSBjb250cm9sbGVyIHRvIGR1bXAgYWxsIGVu
ZHBvaW50DQo+PiBzdGF0ZS1yZWxhdGVkIHZhcmlhYmxlcyBpbnRvIFJzdmRPIHNwYWNlcyBpbnRv
IGVuZHBvaW50IGNvbnRleHQgYW5kDQo+PiBzdHJlYW0gZW5kcG9pbnQgY29udGV4dC4gV2hlbmV2
ZXIgZHJpdmVyIHdhbnRzIHRvIHJlaW5pdGlhbGl6ZQ0KPj4gZW5kcG9pbnQgc3RhcnRpbmcgcG9p
bnQgb24gVHJhbnNmZXIgUmluZywgaXQgdXNlcyB0aGUgU2V0IFRSIERlcXVldWUNCj4+IFBvaW50
ZXIgY29tbWFuZCB0byB1cGRhdGUgZGVxdWV1ZSBwb2ludGVyIGZvciBwYXJ0aWN1bGFyIHN0cmVh
bSBpbg0KPj4gU3RyZWFtIEVuZHBvaW50IENvbnRleHQuIFdoZW4gc3RyZWFtIGVuZHBvaW50IGlz
IGZvcmNlZCB0byBzdG9wIGFjdGl2ZQ0KPj4gdHJhbnNmZXIgaW4gdGhlIG1pZGRsZSBvZiBURCwg
aXQgZHVtcHMgYW4gaW5mb3JtYXRpb24gYWJvdXQgVFJCIGJ5dGVzDQo+PiBsZWZ0IGluIFJzdmRP
IGZpZWxkcyBpbiBTdHJlYW0gRW5kcG9pbnQgQ29udGV4dCB3aGljaCB3aWxsIGJlIHVzZWQgaW4N
Cj4+IG5leHQgdHJhbnNmZXIgaW5pdGlhbGl6YXRpb24gdG8gZGVzaWduYXRlIHN0YXJ0aW5nIHBv
aW50IGZvciBYRE1BLg0KPj4gVGhpcyBmaWVsZCBpcyBub3QgY2xlYXJlZCBkdXJpbmcgU2V0IFRS
IERlcXVldWUgUG9pbnRlciBjb21tYW5kIHdoaWNoDQo+PiBjYXVzZXMgWERNQSB0byBza2lwIG92
ZXIgdHJhbnNmZXIgcmluZyBhbmQgbGVhZHMgdG8gZGF0YSBsb3NzIG9uIHN0cmVhbQ0KPnBpcGUu
DQo+DQo+eEhDIHNob3VsZCBjbGVhciB0aGUgRURUTEEgZmllbGQgd2hlbiBwcm9jZXNzaW5nIGEg
U2V0IFRSIERlcXVldWUgUG9pbnRlcg0KPmNvbW1hbmQ6DQo+DQo+eGhjaSBzcGVjIHYxLjIsIHNl
Y3Rpb24gNC42LjEwIFNldCBUUiBEZXF1ZXVlIFBvaW50ZXI6DQo+IlRoZSB4SEMgc2hhbGwgcGVy
Zm9ybSB0aGUgZm9sbG93aW5nIG9wZXJhdGlvbnMgd2hlbiBzZXR0aW5nIGEgcmluZyBhZGRyZXNz
Og0KPiAgLi4uDQo+Q2xlYXIgYW55IHByaW9yIHRyYW5zZmVyIHN0YXRlLCBlLmcuIHNldHRpbmcg
dGhlIEVEVExBIHRvIDAsIGNsZWFyaW5nIGFueSBwYXJ0aWFsbHkNCj5jb21wbGV0ZWQgVVNCMiBz
cGxpdCB0cmFuc2FjdGlvbnMsIGV0Yy4iDQo+DQo+Pg0KPj4gUGF0Y2ggZml4ZXMgdGhpcyBieSBj
bGVhcmluZyBvdXQgYWxsIFJzdmRPIGZpZWxkcyBiZWZvcmUgaW5pdGlhbGl6aW5nDQo+PiBuZXcg
dHJhbnNmZXIgdmlhIHRoYXQgU3RyZWFtSUQuDQo+DQo+TG9va3MgbGlrZSBwYXRjaCBhbHNvIHdy
aXRlcyBlZHRsIGJhY2sgdG8gY3R4LT5yZXNlcnZlZFswXSwgaXMgdGhlcmUgYSByZWFzb24gZm9y
DQo+dGhpcz8NCj4NCj4+DQo+PiBGaWVsZCBSc3ZkMCBpcyByZXNlcnZlZCBmaWVsZCwgc28gcGF0
Y2ggc2hvdWxkIG5vdCBoYXZlIGltcGFjdCBmb3INCj4+IG90aGVyIHhIQ0kgY29udHJvbGxlcnMu
DQo+Pg0KPj4gRml4ZXM6IDNkODI5MDQ1NTlmNCAoInVzYjogY2Ruc3A6IGNkbnMzIEFkZCBtYWlu
IHBhcnQgb2YgQ2FkZW5jZQ0KPj4gVVNCU1NQIERSRCBEcml2ZXIiKQ0KPj4gY2M6IDxzdGFibGVA
dmdlci5rZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2Vs
bEBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5j
IHwgMTMgKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5jDQo+PiBi
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMgaW5kZXggMWRkZTUzZjZlYjMxLi43ZmMxYzRl
ZmNhZTIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5jDQo+PiAr
KysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5jDQo+PiBAQCAtMTM4NSw3ICsxMzg1LDIw
IEBAIHN0YXRpYyB2b2lkIHhoY2lfaGFuZGxlX2NtZF9zZXRfZGVxKHN0cnVjdA0KPnhoY2lfaGNk
ICp4aGNpLCBpbnQgc2xvdF9pZCwNCj4+ICAgCQlpZiAoZXAtPmVwX3N0YXRlICYgRVBfSEFTX1NU
UkVBTVMpIHsNCj4+ICAgCQkJc3RydWN0IHhoY2lfc3RyZWFtX2N0eCAqY3R4ID0NCj4+ICAgCQkJ
CSZlcC0+c3RyZWFtX2luZm8tDQo+PnN0cmVhbV9jdHhfYXJyYXlbc3RyZWFtX2lkXTsNCj4+ICsJ
CQl1MzIgZWR0bDsNCj4+ICsNCj4+ICAgCQkJZGVxID0gbGU2NF90b19jcHUoY3R4LT5zdHJlYW1f
cmluZykgJg0KPlNDVFhfREVRX01BU0s7DQo+PiArCQkJZWR0bCA9IEVWRU5UX1RSQl9MRU4obGUz
Ml90b19jcHUoY3R4LQ0KPj5yZXNlcnZlZFsxXSkpOw0KPg0KPklzbid0IGVkdGwgaW4gcmVzZXJ2
ZWRbMF0sIG5vdCBpbiByZXNlcnZlZFsxXT8NCj4NCj5BbHNvIHVuY2xlYXIgd2h5IHdlIHJlYWQg
aXQgYXQgYWxsLCBpdCBzaG91bGQgYmUgc2V0IHRvIDAgYnkgY29udHJvbGxlciwgcmlnaHQ/DQo+
DQo+PiArDQo+PiArCQkJLyoNCj4+ICsJCQkgKiBFeGlzdGluZyBDYWRlbmNlIHhIQ0kgY29udHJv
bGxlcnMgc3RvcmUgc29tZQ0KPmVuZHBvaW50IHN0YXRlIGluZm9ybWF0aW9uDQo+PiArCQkJICog
d2l0aGluIFJzdmQwIGZpZWxkcyBvZiBTdHJlYW0gRW5kcG9pbnQgY29udGV4dC4gVGhpcw0KPmZp
ZWxkIGlzDQo+PiArbm90DQo+DQo+QXJlbid0IHRoZXNlIGZpZWxkcyBSc3ZkTyAoUmVzZXJ2ZWQg
YW5kIE9wYXF1ZSk/DQo+RHJpdmVyIHNob3VsZG4ndCBub3JtYWxseSB0b3VjaCB0aGVzZSBmaWVs
ZHMsIHRoZXkgYXJlIHVzZWQgYnkgeEhDIGFzDQo+dGVtcG9yYXJ5IHdvcmtzcGFjZS4NCg0KWWVz
LCBpdCBzaG91bGQgYmUuIFRoaXMgYSByZWFsIGlzc3VlIHRoYXQgb2NjdXJyZWQgZHVyaW5nIHRl
c3RpbmcgVUFTUCBkaXNrIGFuZA0KdGhpcyB3b3JrYXJvdW5kIGZpeGVzIGl0LCBzbyBpdCdzIGxv
b2tzIGxpa2UgdGhhdCB0aGlzIFJzdmQwIGZpZWxkIGNhbiBiZSBjaGFuZ2VkLg0KDQo+DQo+PiAr
CQkJICogY2xlYXJlZCBkdXJpbmcgU2V0IFRSIERlcXVldWUgUG9pbnRlciBjb21tYW5kDQo+d2hp
Y2ggY2F1c2VzIFhETUEgdG8gc2tpcA0KPj4gKwkJCSAqIG92ZXIgdHJhbnNmZXIgcmluZyBhbmQg
bGVhZHMgdG8gZGF0YSBsb3NzIG9uIHN0cmVhbQ0KPnBpcGUuDQo+PiArCQkJICogVG8gZml4IHRo
aXMgaXNzdWUgZHJpdmVyIG11c3QgY2xlYXIgUnN2ZDAgZmllbGQuDQo+PiArCQkJICovDQo+PiAr
CQkJY3R4LT5yZXNlcnZlZFsxXSA9IDA7DQo+PiArCQkJY3R4LT5yZXNlcnZlZFswXSA9IGNwdV90
b19sZTMyKGVkdGwpOw0KPg0KPndoeSBhcmUgd2Ugd3JpdGluZyBiYWNrIGVkdGw/LCBhbHNvIG5v
dGUgdGhhdCBpdCdzIHJlYWQgZnJvbSBjdHgtPnJlc2VydmVkWzFdDQo+YWJvdmUsIGFuZCBub3cg
d3JpdHRlbiB0byBiYWNrIHRvIGN0eC0+cmVzZXJ2ZWRbMF0uDQo+DQo+SSB1bmRlcnN0b29kIHRo
YXQgaXNzdWUgd2FzIHRob3NlIFJzdmRPIGZpZWxkcyBuZWVkcyB0byBiZSBjbGVhcmVkIG1hbnVh
bGx5DQo+Zm9yIHRoaXMgaG9zdCBhcyBoYXJkd2FyZSBmYWlscyB0byBjbGVhciB0aGVtIGR1cmlu
ZyBhICJTZXQgVFIgRGVxdWV1ZQ0KPlBvaW50ZXIiIGNvbW1hbmQuDQo+DQo+QW0gSSBtaXN1bmRl
cnN0YW5kaW5nIHNvbWV0aGluZz8NCg0KWWVzLCB5b3UgdW5kZXJzdGFuZCBpdCBzbyB3ZWxsLg0K
DQpJbiBmYWN0IGVkdGwgc2hvdWxkIGJlIHplcm9lZCBhbmQgc2ltcGxlIGNsZWFyaW5nIG9mIHJl
c2VydmVkWzBdIGFuZCByZXNlcnZlZFsxXSAgc2hvdWxkIGJlIHN1ZmZpY2llbnQuDQoNClRoYW5r
cyANClBhd2VsDQoNCj4NCj5UaGFua3MNCj5NYXRoaWFzDQoNCg==


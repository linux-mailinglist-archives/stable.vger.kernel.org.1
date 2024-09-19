Return-Path: <stable+bounces-76732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A71897C600
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECD21F235D4
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B3198E89;
	Thu, 19 Sep 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="fghmRYBT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E361CABA
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735142; cv=none; b=TLF2wdRFSBnjVhDNTzUAc5gpzLq2rPehjFwsv+AaOcgWXg+E9hoOpHSLkFDNTYh88/AjUQmm02QoF8WQ5BgZx4/QKA6P/4E8oDGNEoiL9rpdwgV3U5sJNFIAE3Bg/WlpyrnHYb5PaJWR0XaNnVQi1GxsPHp/iHIv9rOkwUS83CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735142; c=relaxed/simple;
	bh=OFNgAGy1TeNlhQE6k1jGw63UliBafqB77O50VdAxs1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=CvFjzbljMnprRPxUWspXw2EgCqgAAy9TOP1XifqZybZ2ZmvWIw3/ed1mOOb8Z8oI9hLwXgOsmTlZiZR705g0jVjzNvJzBP04NycfeV0k0j3wUvCJYMTmUNx7ovkIZiUi9VEggOC49ecILj331uDG8Ia3quHRtrfHe6gwhDXJL/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=fghmRYBT; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1726735138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFNgAGy1TeNlhQE6k1jGw63UliBafqB77O50VdAxs1w=;
	b=fghmRYBTL9shYDJekbKSBQUirqZy6i0tvOMAoIubfRf6uwWbPCeA1QGvNOLWSrWYS1kRMN
	9w+TmbOI9PmYdwVNPpKt86SmcttG6rrDEwHBB+8MAtNmikB1Yg6MTrHMksYeB9DIeqO7YU
	1cJjvOnJP2PrUjESscQJlNnt25R9yIo=
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-YsFYe8CkOuuAjy3bPmlcCA-1; Thu, 19 Sep 2024 04:38:55 -0400
X-MC-Unique: YsFYe8CkOuuAjy3bPmlcCA-1
Received: from MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::12)
 by DM3PR84MB3658.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:0:43::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Thu, 19 Sep 2024 08:38:52 +0000
Received: from MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b2f4:886e:d0c:a3e]) by MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b2f4:886e:d0c:a3e%4]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 08:38:52 +0000
From: "Wan, Qin (Thin Client RnD)" <qin.wan@hp.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
Subject: Request to apply patches to v6.6 to fix thunderbolt issue
Thread-Topic: Request to apply patches to v6.6 to fix thunderbolt issue
Thread-Index: AdsKaZsxzTqSxJ2iQ8ayNu/urw5mQgABY/ow
Date: Thu, 19 Sep 2024 08:38:52 +0000
Message-ID: <MW4PR84MB1516C1E8175FF8931ACF8AB18D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
References: <MW4PR84MB151669954C1D210A0FED92128D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB151669954C1D210A0FED92128D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: e342ea8d-840c-4f3c-bfb3-624278536769
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB1516:EE_|DM3PR84MB3658:EE_
x-ms-office365-filtering-correlation-id: af050b4c-eb5e-4596-eb3c-08dcd8867db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?QXZTeHZFWmFQeTJZODZ5bGMxMlBQRHNHYndqb1B3b2xnWHF6UUN5ZDJsNDdu?=
 =?utf-8?B?TmxVd2o5SlFwZmkwZC9scVFlRUVUZjBZNDRkU3I3bnAyL2dlT2x4SkpzUWhr?=
 =?utf-8?B?M00zTndwN2l4emhQUmp2ODBJeGtkUGExcGc3UEhITVVrS2RTUnp5akRoNnRG?=
 =?utf-8?B?T21DMFFxdmhXNVd0c2d2TStVSkx6aDA1YTMyUWdna01iWmhlMk1zY3dRbDN1?=
 =?utf-8?B?RWJhYlhjUmxvOXd1SUlTV3RVT25IWjVzb2tDaXZaNStkNkdVZWFqV1BLdmQ4?=
 =?utf-8?B?K1VKaVhndmx5VzU2aHlzdWtVOXptU1FySjhvdEx2OTludUVwQzFQUUw1b0xj?=
 =?utf-8?B?QXU0dlowaHNjdUZZWVlIWC9kNVpxOEFwQmt4Q09iTFUzMGtWdzR2QWZSbHBn?=
 =?utf-8?B?RmdVTGNORmM4VmYxQkgzUXFRZDczeEVaVk9QT0tqakR1MGVYb2ZXVDFERnpP?=
 =?utf-8?B?dGIxS0NhaUVmY0pvMVM2S3RxbUgwQlkrSVZYWXpZL1FGSHRpVWhrdHJzKzgx?=
 =?utf-8?B?cjJWQ3h6M1diL0ZSVEprZnJDcWR3ZHo1TTh1WFlGdENaZVpFbTRmcFR2WEU3?=
 =?utf-8?B?dUs3YlI5SGZoS3ZuL1dxbE5yc3pHdWpVV3I0YUFYRjU4YmVSa2FNOGo1KzRs?=
 =?utf-8?B?VG96OGZtYi9uN2Y5ZWs4RnEyS3o1d3pDdzNVVUJGMjBuMzExRTlzOG5vR29w?=
 =?utf-8?B?M0RCSkNockhTVXVPRkpqeTZseFY4d29PNGRTU2ViemRrdHZBdmZxa3RTQjc2?=
 =?utf-8?B?Lzd6Wk96bXRKV3FzMG9odE5yRkRFSzJSemMyT2pYcld0Tno4czJXQlNIeXh6?=
 =?utf-8?B?NFBFMFZNaVloV0NCUmlNTVNSRHBhVDhKMko4VndOQlFhNW00aTRnOC9XdWJZ?=
 =?utf-8?B?dHFHakhEK0loUVlRTTFBTEt5Qzl6RkxGQklDc1UwbjJPSFJFVXBiKytKUit3?=
 =?utf-8?B?OHlyOEZpS2NaSGppNENMU3NtSitCZUhDWjZoOFZITUp2M3Breisyd1kvc2pj?=
 =?utf-8?B?ZzBSSUQxdTVTZ0lvZy9iUzlsNU9hYms2SDVnaW5uUWZsb0JMV3ZRMlYvWUF1?=
 =?utf-8?B?aHlzaTBMV0RjeDRiWTBuNnBOaHZ4NU1CQ2t3Rk5XaXdMQ2RXM3dudEliOGgr?=
 =?utf-8?B?R1RZTEsweEtHcWFyLzl0QkZ0V0ljbXV2dTVDenkwem5FajJJeGhBckl3b2N2?=
 =?utf-8?B?ZGFJVHR4U0tIVWVCemRsbHIxa01qRUc5clQyMFVlbkJIcGJYTHBvajhxeFc2?=
 =?utf-8?B?UE4rbldFa1RhVXlrOVlvSXNucXZjNmNXaGloZlpPd2xVNnozT2xWSlE3K1h0?=
 =?utf-8?B?SlBTbHdIbDFwQitRQTZSRTJ3N0JzZE9pOWNWQ1ZNdHZWWjNPUWFZUmMxMEZD?=
 =?utf-8?B?b2NmTm9Qek5OckdSMEdZZEExVTFJZThFbVBtUlZHNWVtR2cybHg4MDlwRkxt?=
 =?utf-8?B?aTNSL3RoNUJqNU9hNnFCQkppZDVlK216ZkRjRDNMa3dJM2NvTjV5TEZjQThL?=
 =?utf-8?B?SEEwWUFPUW0raVdPdXRObS9mOUtMTVRWbGxYODlrWEZEL25iTGRQZ0RTdk5P?=
 =?utf-8?B?U1VQempSTUdLZHNjd3FVQzhCT1NVcE9pNHJJdG82dFVabitzSWxEUHVQYkw0?=
 =?utf-8?B?U3hVT1FDRlZJelI1YjZzbWpkb0VnWGREUXQrak4zN3BIZE9SUXptTm4ycXNB?=
 =?utf-8?B?RzJ0bEFzTWdQa3Vpd3J6YXNqS1VPcUs0eUIwYldaRmRQckIrbTBKSXFtZFhD?=
 =?utf-8?B?aWQ5NW4vRzJaVkxMRDVabHI5M2xjQmNlZkdGRU1JcEdhVDFEVFZ6UFhHR0tQ?=
 =?utf-8?B?cUc5bE01MGZrRGM1ZkxyYnlhaFgrZ2hWcG9OeTZITkhBbzZvd09aZ0xNQ1hu?=
 =?utf-8?B?K0JzL01NYURUaXZUOFhmaFZUMmJ4S0FRWDVERGxSSHRmVEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEswKytlVEE5eEtscWVuR0dkekE1VVI0bi8xWmw0ME9hOVdGMzY5dnZSSW1q?=
 =?utf-8?B?ejVhbE1VOGdRYzRtbFB6WFdFcERJcTBxZEhaeENsZkt1VGdROHcrdEhEWUZz?=
 =?utf-8?B?V3RKV3RiMEE3MXd6M0dpZENoUm1hTkdvSjFPZWVLL2ZTRzZ6MnV3ay9MSWJz?=
 =?utf-8?B?djB0VzRmeTBuRDBFcnJseDlJcnNaNG1YZ2Z5L2Q3eWQxMnhHQmIvS3lrRGV4?=
 =?utf-8?B?czM0ampwTVZnQXpQSTdIZW9MNXp4Zm90T2pMTGorVFdpbGx1ZklQNUhIZkVp?=
 =?utf-8?B?T0pIVGpGckdDZFZxZ2JiNFBXODlhc05OS3BNYXpKdXJSWm8vOC9EMzBaSGdq?=
 =?utf-8?B?emExM20xbmovWm5abDN1NFlzdksyQmIybm1kdFhUMnVCRW1HSkFGSmdtUjR4?=
 =?utf-8?B?b2dEOERpa3NrclcxNlpsbEhkZzlKdVdVOUxVSHRaWW9XNE5IZnFjK0s3eVlq?=
 =?utf-8?B?VjZZTHcxUktVK09meWdtb05PcEtDVExlVEwxYm8vWGtMZWNtZVYyR1JjbVg0?=
 =?utf-8?B?V1ptY05JdTlkblZqSXh1cjBWOEM2WnVpcGxwSDRKZC9YaC9QWHYweFVoSWJC?=
 =?utf-8?B?aVpJSVNWZjZlajdTbzEzSEV1b3RyaStCdERtd01FVm1GdWFDcmQrRXJ3L1I5?=
 =?utf-8?B?ZTFGT1BxZmNiUmtRcllNOHU1aldqQ3crVEpxWVZjczBOQXNqRlJESFpuRVdU?=
 =?utf-8?B?MEptNlRiM3RvcG05dzFSZmFSSlU5MzJOdnQzUjJnZFlHRGNOVWczMHFyVk9K?=
 =?utf-8?B?Y0xGakVVbzh5WkR2aGdWZ3lFQWlkeFd6S0ZxTzZaSm9kTWJKaVozTTZUWGND?=
 =?utf-8?B?TDNvdDBQWk9vRXpzeDYreUs4SFJjRUFpbEExc3JRNTJ2cGtsM3Y4OG1oVUtu?=
 =?utf-8?B?Z1lYYVE5MzBnZW1pbFJCNnZ6aWl4a3Noam5oQTRDenJJbVVlNkJDZGxwUXIr?=
 =?utf-8?B?VnlrZGJFVjJYWEdoTmRXRDR0K25PNTIvWnF2NkNqUzhqSEoydVFjL3YzMjUv?=
 =?utf-8?B?UCs5aURqT3dZSXVNdG5KaUJaOEIwYk5iMVBuVWpUeFJUYUJEdVVReTJET3pz?=
 =?utf-8?B?aHBkQk93Z3FkVmtpZE1oL3pGbGtuWUVFUTBBbXFJZG16eSt6bUl6QnVhTUJi?=
 =?utf-8?B?UmorbEZQWnc2cmNwT3FvcEw1YmN4QTVTUTVEY2JnSHZYbWVBT090SkllS2hy?=
 =?utf-8?B?bVhkRVlnRmlxZ3NaT2ZiaDE5OG1HTTdYSzJrSDBBcjZqRmNkZURHNVUrbnVX?=
 =?utf-8?B?bDN1QjF3RXVzOWlabm5SSVBUdER0YUJKdHRvdFgvMnZ2elJEZFlVQWY4SUNW?=
 =?utf-8?B?TXVPeWNaZUlYdHM0a1JUSzdxL3BBWmJaZXM1aGVkZ0NMdnJjRmkzYTV0NjRm?=
 =?utf-8?B?RlZCdStsRDh0dGd1R0pMd0MwQTJNaHJoRlRaekZKZ3RBdVJTSDJHUWlnRzk3?=
 =?utf-8?B?b2VhZHlwQ01ESkVoV1F1eFU3eEl3TGhiT3oxQTNNTTM3RWdUWG1VQ2NzSmNu?=
 =?utf-8?B?RTFuTktyQlNnaXNERFlRYXJMUWUzaEtkZjNzeVdVVlhDTFF4bytyOVZGM0hr?=
 =?utf-8?B?cHZRSmM2R2VvTmZUcVk4dkwyeVc1REUzcklNcWJadDMrazVSM3JBRnRQSEhN?=
 =?utf-8?B?Vit2MUhRTmQ0Smo3c0dqUGZnbGJLZUFTSGtGTzlNS2J4NE1zd2NtZEMwOEFJ?=
 =?utf-8?B?TWFZS1NqL25tSXI3S2FrWmwrZ3BiQmpMMVo1Q2xwLzZxVUduK2JJY1hKally?=
 =?utf-8?B?bXY4cEIwcVE5L0l1ekpRalQ3ak9QV2xjMC9IdkdzZ25sS0xpUFB0cUNybjYx?=
 =?utf-8?B?dTR3QUJzVWxibEtVb3VUUkM2TVJDRFUvWkJqU0NiVzAyNzNRY3lzbGtiUWFq?=
 =?utf-8?B?RVZIdDlhdjhQUzJsNDV0c3g0TDYvMWJhRmx3RUVNaER1dyt3ODdmdmFFa2ly?=
 =?utf-8?B?VUp6OHEzaittd0twOTFnTkIwVm1WZjJEbE00aVI0Y0ZWVlc4NFlmZVBncUFo?=
 =?utf-8?B?UklhWExxZWs4cm5qd3BsNzRQcnZFSEJvbytVQ2FWV2RXcTNlVENDelNON3dY?=
 =?utf-8?B?TnlQSk5LTlBTbkFhak9ZdmF5UmxyTCtoNzRHVnREeFVNNGNaSWNmY3RvdDhl?=
 =?utf-8?Q?jiDM=3D?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af050b4c-eb5e-4596-eb3c-08dcd8867db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 08:38:52.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBSeoJJsgYCcAgCbDntPreUtgVMz0P6RxffQwPO9dg/5baU638BfNjGvG+NCzfZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR84MB3658
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCsKgwqAgVGhlcmUgaXMgYW4gaXNzdWUgZm91bmQgb24gdjYuNi4xNjogUGx1ZyBp
biB0aHVuZGVyYm9sdCBHNCBkb2NrIHdpdGggbW9uaXRvciBjb25uZWN0ZWQgYWZ0ZXIgc3lzdGVt
IGJvb3RzIHVwLiBUaGUgbW9uaXRvciBzaG93cyBub3RoaW5nIHdoZW4gd2FrZSB1cCBmcm9tIFMz
IHNvbWV0aW1lcy4gVGhlIGZhaWx1cmUgcmF0ZSBpcyBhYm92ZSA1MCUuDQrCoMKgIFRoZSBrZXJu
ZWwgcmVwb3J0cyDigJxVQlNBTjogc2hpZnQtb3V0LW9mLWJvdW5kcyBpbiBkcml2ZXJzL2dwdS9k
cm0vZGlzcGxheS9kcm1fZHBfbXN0X3RvcG9sb2d5LmM6NDQxNjozNuKAnS4gVGhlIGNhbGwgc3Rh
Y2sgaXMgc2hvd24gYXQgdGhlIGJvdHRvbSBvZiB0aGlzIGVtYWlsLg0KwqDCoCBUaGlzIGZhaWx1
cmUgaXMgZml4ZWQgaW4gdjYuOS1yYzEuIA0KwqDCoMKgV2UgcmVxdWVzdCB0byBtZXJnZSBiZWxv
dyBjb21taXQgdG8gdjYuNi4NCg0KwqAgNmI4YWM1NGYzMWY5ODVkM2FiYjBiNDIxMjE4NzgzOGRk
OGVhNDIyNw0KwqB0aHVuZGVyYm9sdDogRml4IGRlYnVnIGxvZyB3aGVuIERpc3BsYXlQb3J0IGFk
YXB0ZXIgbm90IGF2YWlsYWJsZSBmb3IgcGFpcmluZw0KDQrCoGZlOGEwMjkzYzkyMmVlOGJjMWZm
MGNmOTA0ODA3NWFmYjI2NDAwNGENCsKgdGh1bmRlcmJvbHQ6IFVzZSB0Yl90dW5uZWxfZGJnKCkg
d2hlcmUgcG9zc2libGUgdG8gbWFrZSBsb2dnaW5nIG1vcmUgY29uc2lzdGVudA0KDQrCoGQyN2Jk
MmMzN2Q0NjY2YmNlMjVlYzRkOWFjOGM2YjE2OTk5MmYwZjANCsKgdGh1bmRlcmJvbHQ6IEV4cG9z
ZSB0Yl90dW5uZWxfeHh4KCkgbG9nIG1hY3JvcyB0byB0aGUgcmVzdCBvZiB0aGUgZHJpdmVyDQoN
CsKgIDg2NDhjNjQ2NWMwMjVjNDg4ZTI4NTVjMjA5YzBkZWExYTFhMTUxODQNCsKgdGh1bmRlcmJv
bHQ6IENyZWF0ZSBtdWx0aXBsZSBEaXNwbGF5UG9ydCB0dW5uZWxzIGlmIHRoZXJlIGFyZSBtb3Jl
IERQIElOL09VVCBwYWlycw0KDQrCoGY3M2VkZGRmYTJhNjRhMTg1YzY1YTMzZjEwMDc3ODE2OWM5
MmZjMjUNCsKgdGh1bmRlcmJvbHQ6IFVzZSBjb25zdGFudHMgZm9yIHBhdGggd2VpZ2h0IGFuZCBw
cmlvcml0eQ0KDQrCoCA0ZDI0ZGIwYzgwMTQ2MWFkZWVmZDdlMGJkYzk4Yzc5YzYwY2NlZmIwDQrC
oCB0aHVuZGVyYm9sdDogVXNlIHdlaWdodCBjb25zdGFudHMgaW4gdGJfdXNiM19jb25zdW1lZF9i
YW5kd2lkdGgoKQ0KDQrCoCBhYTY3M2Q2MDYwNzhkYTM2ZWJjMzc5ZjA0MWM3OTQyMjhhYzA4Y2I1
DQrCoCB0aHVuZGVyYm9sdDogTWFrZSBpc19nZW40X2xpbmsoKSBhdmFpbGFibGUgdG8gdGhlIHJl
c3Qgb2YgdGhlIGRyaXZlcg0KDQrCoCA1ODJlNzBiMGQzYTQxMmQxNTM4OWEzYzljMDdhNDQ3OTFi
MzExNzE1DQrCoCDCoHRodW5kZXJib2x0OiBDaGFuZ2UgYmFuZHdpZHRoIHJlc2VydmF0aW9ucyB0
byBjb21wbHkgVVNCNCB2Mg0KDQrCoMKgIDJiZmVjYTczZTk0NTY3YzFhMTE3Y2E0NWQyZThhMjVk
NjNlNWJkMmMNCuOAgHRodW5kZXJib2x0OiBJbnRyb2R1Y2UgdGJfcG9ydF9wYXRoX2RpcmVjdGlv
bl9kb3duc3RyZWFtKCkNCuOAgA0K44CAOTU2YzNhYmU3MmZiNmE2NTFiOGNmNzdjMjg0NjJmN2U1
YjZhNDhiMQ0K44CAdGh1bmRlcmJvbHQ6IEludHJvZHVjZSB0Yl9mb3JfZWFjaF91cHN0cmVhbV9w
b3J0X29uX3BhdGgoKQ0K44CADQrjgIBjNGZmMTQ0MzY5NTJjM2QwZGQwNTc2OWQ3NmNmNDhlNzNh
MjUzYjQ4DQrjgIB0aHVuZGVyYm9sdDogSW50cm9kdWNlIHRiX3N3aXRjaF9kZXB0aCgpDQrjgIAN
CuOAgDgxYWYyOTUyZTYwNjAzZDEyNDE1ZTFhNmZkMjAwZjgwNzNhMmFkOGINCuOAgHRodW5kZXJi
b2x0OiBBZGQgc3VwcG9ydCBmb3IgYXN5bW1ldHJpYyBsaW5rDQrjgIANCuOAgDNlMzY1MjhjMTEy
N2IyMDQ5MmZmYWVhNTM5MzBiY2MzZGY0NmE3MTgNCuOAgHRodW5kZXJib2x0OiBDb25maWd1cmUg
YXN5bW1ldHJpYyBsaW5rIGlmIG5lZWRlZCBhbmQgYmFuZHdpZHRoIGFsbG93cw0K44CADQrjgIBi
NDczNDUwN2FjNTVjYzdlYTEzODBlMjBlODNmNjBmY2Q3MDMxOTU1DQrjgIB0aHVuZGVyYm9sdDog
SW1wcm92ZSBEaXNwbGF5UG9ydCB0dW5uZWwgc2V0dXAgcHJvY2VzcyB0byBiZSBtb3JlIHJvYnVz
dA0KDQoNCuOAgFdoZW4gZmFpbHVyZSBoYXBwZW5lZCwgdGhlIGtlcm5lbCBsb2cgcmVwb3J0cw0K
U2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDY3M10gVUJTQU46
IHNoaWZ0LW91dC1vZi1ib3VuZHMgaW4gZHJpdmVycy9ncHUvZHJtL2Rpc3BsYXkvZHJtX2RwX21z
dF90b3BvbG9neS5jOjQ0MTY6MzYNClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRmIGtlcm5l
bDogWyA4OS40MTQ2NzRdIHNoaWZ0IGV4cG9uZW50IC0xIGlzIG5lZ2F0aXZlDQpTZXAgNiAwODox
MDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE0Njc1XSBDUFU6IDAgUElEOiAxNDUg
Q29tbToga3dvcmtlci8wOjIgVGFpbnRlZDogRyBVIDYuNi4xNiAjMTA4DQpTZXAgNiAwODoxMDoy
OSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE0Njc3XSBIYXJkd2FyZSBuYW1lOiBIUCBI
UCBFbGl0ZSB0NjYwIFRoaW4gQ2xpZW50LzhEMDUsIEJJT1MgVzQ0IFZlci4gMDAuMTQuMDAgMDcv
MTkvMjAyNA0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDY3
OF0gV29ya3F1ZXVlOiBldmVudHMgb3V0cHV0X3BvbGxfZXhlY3V0ZcKgW2RybV9rbXNfaGVscGVy
XQ0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDY5NV0gQ2Fs
bCBUcmFjZToNClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRmIGtlcm5lbDogWyA4OS40MTQ2
OTddIDxUQVNLPg0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQx
NDY5OF0gZHVtcF9zdGFja19sdmwrMHg0OC8weDcwDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZj
NGQ0ZiBrZXJuZWw6IFsgODkuNDE0NzAzXSBkdW1wX3N0YWNrKzB4MTAvMHgyMA0KU2VwIDYgMDg6
MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDcwNV0gX191YnNhbl9oYW5kbGVf
c2hpZnRfb3V0X29mX2JvdW5kcysweDE1Ni8weDMxMA0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThm
YzRkNGYga2VybmVsOiBbIDg5LjQxNDcwOF0gPyBrcmVhbGxvYysweDk4LzB4MTAwDQpTZXAgNiAw
ODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE0NzExXSA/IGRybV9hdG9taWNf
Z2V0X3ByaXZhdGVfb2JqX3N0YXRlKzB4MTY3LzB4MWEwwqBbZHJtXQ0KU2VwIDYgMDg6MTA6Mjkg
SFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDczM10gZHJtX2RwX2F0b21pY19yZWxlYXNl
X3RpbWVfc2xvdHMuY29sZCsweDE3LzB4M2TCoFtkcm1fZGlzcGxheV9oZWxwZXJdDQpTZXAgNiAw
ODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE0NzQzXSBpbnRlbF9kcF9tc3Rf
YXRvbWljX2NoZWNrKzB4OWEvMHgxNzDCoFtpOTE1XQ0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThm
YzRkNGYga2VybmVsOiBbIDg5LjQxNDgzMV0gZHJtX2F0b21pY19oZWxwZXJfY2hlY2tfbW9kZXNl
dCsweDRiYi8weGUyMMKgW2RybV9rbXNfaGVscGVyXQ0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThm
YzRkNGYga2VybmVsOiBbIDg5LjQxNDg0Ml0gPyBfX2ttZW1fY2FjaGVfYWxsb2Nfbm9kZSsweDFi
My8weDMyMA0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDg0
NV0gPyBfX3d3X211dGV4X2xvY2suY29uc3Rwcm9wLjArMHgzOS8weGEwMA0KU2VwIDYgMDg6MTA6
MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNDg0OF0gaW50ZWxfYXRvbWljX2NoZWNr
KzB4MTEzLzB4MmI1MMKgW2k5MTVdDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJu
ZWw6IFsgODkuNDE0OTM2XSBkcm1fYXRvbWljX2NoZWNrX29ubHkrMHg2OTIvMHhiODDCoFtkcm1d
DQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE0OTU2XSBkcm1f
YXRvbWljX2NvbW1pdCsweDU3LzB4ZDDCoFtkcm1dDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZj
NGQ0ZiBrZXJuZWw6IFsgODkuNDE0OTcyXSA/IF9wZnhfX2RybV9wcmludGZuX2luZm8rMHgxMC8w
eDEwwqBbZHJtXQ0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQx
NDk5OV0gZHJtX2NsaWVudF9tb2Rlc2V0X2NvbW1pdF9hdG9taWMrMHgxZjEvMHgyMzDCoFtkcm1d
DQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MDE5XSBkcm1f
Y2xpZW50X21vZGVzZXRfY29tbWl0X2xvY2tlZCsweDViLzB4MTcwwqBbZHJtXQ0KU2VwIDYgMDg6
MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNTAzOF0gPyBtdXRleF9sb2NrKzB4
MTMvMHg1MA0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNTA0
MF0gZHJtX2NsaWVudF9tb2Rlc2V0X2NvbW1pdCsweDI3LzB4NTDCoFtkcm1dDQpTZXAgNiAwODox
MDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MDU4XSBfX2RybV9mYl9oZWxwZXJf
cmVzdG9yZV9mYmRldl9tb2RlX3VubG9ja2VkKzB4ZDIvMHgxMDDCoFtkcm1fa21zX2hlbHBlcl0N
ClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRmIGtlcm5lbDogWyA4OS40MTUwNjhdIGRybV9m
Yl9oZWxwZXJfaG90cGx1Z19ldmVudCsweDExYS8weDE0MMKgW2RybV9rbXNfaGVscGVyXQ0KU2Vw
IDYgMDg6MTA6MjkgSFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNTA3N10gaW50ZWxfZmJk
ZXZfb3V0cHV0X3BvbGxfY2hhbmdlZCsweDZmLzB4YjDCoFtpOTE1XQ0KU2VwIDYgMDg6MTA6Mjkg
SFA3YzU3NThmYzRkNGYga2VybmVsOiBbIDg5LjQxNTE1Nl0gb3V0cHV0X3BvbGxfZXhlY3V0ZSsw
eDIzZS8weDI5MMKgW2RybV9rbXNfaGVscGVyXQ0KU2VwIDYgMDg6MTA6MjkgSFA3YzU3NThmYzRk
NGYga2VybmVsOiBbIDg5LjQxNTE2Nl0gPyBpbnRlbGZiX2RpcnR5KzB4NDEvMHg4MMKgW2k5MTVd
DQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MjM2XSBwcm9j
ZXNzX29uZV93b3JrKzB4MTc4LzB4MzYwDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBr
ZXJuZWw6IFsgODkuNDE1MjM4XSA/IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQpTZXAg
NiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MjQwXSB3b3JrZXJfdGhy
ZWFkKzB4MzA3LzB4NDMwDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsg
ODkuNDE1MjQxXSA/IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQpTZXAgNiAwODoxMDoy
OSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MjQyXSBrdGhyZWFkKzB4ZjQvMHgxMzAN
ClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRmIGtlcm5lbDogWyA4OS40MTUyNDVdID8gX19w
Znhfa3RocmVhZCsweDEwLzB4MTANClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRmIGtlcm5l
bDogWyA4OS40MTUyNDddIHJldF9mcm9tX2ZvcmsrMHg0My8weDcwDQpTZXAgNiAwODoxMDoyOSBI
UDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MjQ5XSA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8w
eDEwDQpTZXAgNiAwODoxMDoyOSBIUDdjNTc1OGZjNGQ0ZiBrZXJuZWw6IFsgODkuNDE1MjUwXSBy
ZXRfZnJvbV9mb3JrX2FzbSsweDFiLzB4MzANClNlcCA2IDA4OjEwOjI5IEhQN2M1NzU4ZmM0ZDRm
IGtlcm5lbDogWyA4OS40MTUyNTJdIDwvVEFTSz4NCg0KVGhhbmtzLA0KV2FucWluDQrjgIANCg==



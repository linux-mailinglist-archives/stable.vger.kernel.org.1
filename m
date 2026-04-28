Return-Path: <stable+bounces-241787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMaXJoo28WmfegEAu9opvQ
	(envelope-from <stable+bounces-241787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:36:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B7848CA66
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD04430055FF
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA323090E2;
	Tue, 28 Apr 2026 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIS2fmI4"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CBE3B1B3;
	Tue, 28 Apr 2026 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415811; cv=fail; b=sbdNrigx0KLN4PMOql37XaB0FJh/VsIlr7igbJj9BuSOCOz3i0yDPyMvH8RvZp4NXufr7nn+2bE3s91/ndmjywXUg7YokTomfUy9sYqQQFY/jwZkG5VpzYbTbnB3k6FbvLbSzbvv+4VARC89nTbOi+8iFx4Kp/gaxOQZrCQyPpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415811; c=relaxed/simple;
	bh=SxIQA504hip6mnG7svtrMKsf00bKYXX601Y8eDYATZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5VVA/ciQBAxFKVbEURUr1oCduvl3OkQPiq6eERjQG+HlIB+B+8ID7i/2agiBIcDCmL9twzfChpu9uII+dTx+/0ABh7S9ZVB+Xep4wxMkYYEcAr37C0h023r1c82TlpTI7Vf2ncw67ppPooAF+pBsvzJNMYMvmans0AqKwxJVcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rIS2fmI4; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3ddbfKvxqhnQBFBG8z4Bh8njLa4yEPQUQOxjwf555yiee8gwLL7zevAVhims784irNtBat1MZCp3WiPipLvM10GKwyBSoaH4pZLYU3BXEXeVhSvkX9O2mWl4Hrdoqv+llvIS3TlAUUhMlBPD3M51yrQ0kZFHMejyD5AExZWoQpo/tAtIcWduqbryZBiqszbUHSafjRKZiUa+X8vw6Q386/zAqpYNAkh5qb/atYea09cfKY2hjbpmwkqoyg5V+Umqzr0k64K6P3+lKeDQMp5JMpM6Ctu2kX1UG9XWtnawK0qZf0Ehjug0T+7YOHkU7WkzUx9nwJYFIOPbzyq3/isMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxIQA504hip6mnG7svtrMKsf00bKYXX601Y8eDYATZw=;
 b=DdK79MdguMgUKFc/e7Pvoqq49rkPCaLXOlI18E+vTO9OjHE2wUDbsXkWsYJNWyVuehPnpwcZd4/3qQ4gMYjPrQ95V2UTWGDriE4X7KDiNzFFVLZNLYgpGyx2ZHfMow4+WPnEdjFYSJENbXGIj/Y1McIC94HUqPMs+qzvp0LsYE5F6hHjY+5DxAt79UDtzhcDLkWikey9mhoXpatvMYBYm0Atxfsnv7uQQXo8KOGLYASplyQzf/bRuMJhzp64a4qLHiiammeQ8x1jiFgrs9Tv5iD9OnaWLP3W52GHl1rulN7W2eqq5G2GVP+yGoeXlxRZsBB07F15kt2K05l2fH+bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxIQA504hip6mnG7svtrMKsf00bKYXX601Y8eDYATZw=;
 b=rIS2fmI4Fgdg6kjfqUl3auG/4FoFLi0brK7ZCIbtYvpRFCFsppySdWrJToYh+MzHVkXH2G0UirsEqkXSA3uQZA/DO40JCHZ2628SxI4l+bpEG61fSPZZ68B5o1u6btp1Pac6Io1MDkdkOJUzhPT04ZoGX6/s7zCVrMXf2vMGBYiUwCM70WO8rg7brPW4YhLjxIstxyp/93oaDz/R7Hs+GpN4Jcny0ch1WjDPFEar1QgrgEnrzVGzygUSc9TqKxENMY+54LC691YWeaaWt5IsSRN/dm7bOqxrKydSOJ0uVN9BJD+jh0ig61sKJwK78/6T1yP8uG7rUJgBGrb+hjhz8A==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 22:36:46 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 22:36:46 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] fuse: do not treat unlimited readdir count as a buffer
 size
Thread-Topic: [PATCH] fuse: do not treat unlimited readdir count as a buffer
 size
Thread-Index: AQHc1rSMighJT3Mvr065eteq/+op6LX0c4EAgACeBYA=
Date: Tue, 28 Apr 2026 22:36:46 +0000
Message-ID: <B851F08C-3A33-4366-A114-0CC657097B21@nvidia.com>
References: <20260428021304.2338592-1-mochs@nvidia.com>
 <CAJfpeguzUDE1gegKA3WXCORZZRQrWCRsKe_sdLKtGHqRd_vyyQ@mail.gmail.com>
In-Reply-To:
 <CAJfpeguzUDE1gegKA3WXCORZZRQrWCRsKe_sdLKtGHqRd_vyyQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|MN2PR12MB4061:EE_
x-ms-office365-filtering-correlation-id: f7e3aa09-4565-413c-47b2-08dea576a148
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 HYbCmRNjY7TFlqsbDHBHw7jPfqoEs5/t1lhuXmRQCdQoAts47ae6aME6bbIh5NFJGq5B/jR74649e/z/xLTCkv0P7lDzhJQkeMoSVU+xNsZTywNUcMwwSYvXaPlLHDB9eLpPtMfCP+/jVHiaBPfAyf4dRUAjz3C0j316LAwK5Jl5gcysJjenx5SenxgpbbVYlj03QznEkiNtRQJsqSpFdfQubzF6gSptUvLReeSID7KW/iL063tonm9Y1ci+b0iKyKeOkkrBvwX+Wk4K7ygJutk3VbYitgza1cCRxB5YsI2zuP+tij+XDEaEg+qvvLH5+/sMwXjmG1sdZIAjrXfTj0FoE5+5283kcUAiPlkp2eTTEajf0aN5Lc9on+utr+aokrHyBCstcfyS0kA3Aj80er76VlW5dUodLFlIMGQrVYkoCERMTxU2IbkPxDQzKoMH+H8zOPKYYCdDN9d5PPvbiIGnQa0c7Rf+5eYtUrjbeOFfXeciLQD4zAlWzJnbeFUAz7ufF1jHO6arArFtxkLn78OWd4U05yZtTNlpYuJMnzOkUcq0zpepUhwJjhWi2MwzDDun2h4+7NissgrKBZOjTUv0//fnNKksWyZL6MSadjI46KBivcDFcPzFy9qb8GKA9JdLPfm+fNrlrteTy+qkZzTWdu/OWxhb47zstCmKsp/8wi9FlkjhfhwgHBkJcgG6A6WDWbRVR4CeTTiCZUgwnIcvfGzJWHP1jXnypPOEsS2TiOC4fDOY2qU/aKafbtfzyyYlEik9J4EYGNE38QGJMEB9bWR/y77bvKOm/0k6Yxc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tlp1MXlBYU1VUXlzNVFKZ1FlZmNaelJDY0NucE5QTDRMS1VCUFJMVEYyYlBS?=
 =?utf-8?B?cWFrZ2tMZHV6cVY1bkNuOTNQRlJTcHpmYUs5aXJRTHFZcGFod0g4dlNQSnBO?=
 =?utf-8?B?bHZnbmVKdmU2TlVHWmVLVXZsSEpJcmVNTElyaS94RkMrTC9vYk9IM2FYUGEy?=
 =?utf-8?B?aXBvODI4a3ZBcnhGcmt6RTZMam9TbmpnQnpoUDhYVGJxWUFzblJWb2MxL011?=
 =?utf-8?B?VlYxUVZRbnRWam5OTHZFc3gyNm80WnVSSldiWUpYVVh5QXMxSUhnbm9yRWFL?=
 =?utf-8?B?VTFEWEU0YlNhdzZSak5xRmVzZTdDVVBtVTBQR2lrL3BDRE5Bd0pmYUFDazVV?=
 =?utf-8?B?Nk91UW9qNDAvN0NHdVpGY0NIYTFQL29yRWRwQnNobWRjbXpsOGo4VGFuSnhC?=
 =?utf-8?B?aEtpNzdoY0xncFo5V253dTEwRVFrQWt0NzFzKzNJdGxKQjhhQlZ1dnBnSEV2?=
 =?utf-8?B?eDVJVHRRZzVUVXNTTkc2TXhGODRsdHlmcHh5Q0hKa2VZSkV1WTgrc0VIOEl3?=
 =?utf-8?B?RmZYS3NGUDJsOUx6eFZObUQrL2JqZUtrTTJQV1k1bld5Yis1aEJDMTlYZWpx?=
 =?utf-8?B?UWsvS0JyUVNDSXoxbWJWSXZtY3hpcnJmeld6UGJyajJBUXNqQUw5c2xwOFUw?=
 =?utf-8?B?QVQvdnhqa2dTOVBqaWZMRXY3MlArYTBkZUZ6OS9DR2NYU0J6YUk2dTJBZDg4?=
 =?utf-8?B?bUN4N0NOL2xKZDUrdStYTXBXZ3Z2Nm5FOWs4aUZQc2ttYmw1SnpLUUVKc09q?=
 =?utf-8?B?ZU4vWlhpU2c4V081WUQ4UjE0bDQ2WUc4elQ3cnY5d2pqdDNkMTc2UVRIZmxC?=
 =?utf-8?B?eUhpbnFycW03VmhtaHhCdVF5VXdmVmJXV0hUaGxVc0Z0MkhQdWxCWGJxM1N6?=
 =?utf-8?B?K0xyM0lQeUlETnUrMU5JRDhOQ0RjOGxyc2xpbVlRNmMvcU81YXJQcmlON3JT?=
 =?utf-8?B?K2hNSytubk5tUVFzOUVMQVllcDhHcWg0Ni9UYkhBLzcyMEZyWGFXYXpaV2VC?=
 =?utf-8?B?L1RkUGNhVnhXdUE1dEFkWEV6NVJHUjhDdkRkV2VUenp5VVd4T1FhYWFxK1N2?=
 =?utf-8?B?SXJHUTNJb1Z0MUtQUkx4QWNBWmU5KzlTMmUwbVBrak1GRGR0cks1WTJQSnE3?=
 =?utf-8?B?QVNvM2xGUXhuZmkyNXQ2UTNwbnNvYkZhaGFlM0hVek9Vc1R6c3BZTnZ4NVMz?=
 =?utf-8?B?YytmTkswN0lQTTJZcDc2NEpGMkhSOWl3RVk1NURZNFhsaGk0QVp4WENqUEox?=
 =?utf-8?B?WW5ocy9hVFdXUUJwQ0d0VFBXY3JJamVpTkkxemgvYjNPMkI0blRCUFU0VStU?=
 =?utf-8?B?Uk4rOE4xMG9iU3B0WXFTNzZzbFpSem9GaWJld0ZvWnNld1dsWnZTZTBjbmQv?=
 =?utf-8?B?SmZsSndVRU40L254VkdlWTNIVWJ0Mld0SEZCc3JhTDFkajlQc1dkNjJIVGpO?=
 =?utf-8?B?SDljU1BlQjhPY3drV3NNcW1iOU80V0w4Q3hHNUNyTVU5bC9xQ0FBb2lGSldj?=
 =?utf-8?B?R3FQemlOZXlETUhzbnl3Ly9kVUcvOWV1N0hRRllHM2NZdUhFSjBGaUpVajFN?=
 =?utf-8?B?T0c1cjhYQWxuczd2SjZVOGZUNGJWRWVFdi8yMGVHOXl4L1p6WSsvRHpQVWFK?=
 =?utf-8?B?bHJseG1YWUJTUGhGdjlQdkQxN0tCWURiT0NJeEhsK2JTa0RqaTFKVVF0eEs4?=
 =?utf-8?B?OHN1TmFDUjlzSnc3NkFPYzZVaTBHckRXYzU3MklIT1F2bU94TkJaMzNrNjl3?=
 =?utf-8?B?b0c5eERjMTcrM3VhYXRLRk43M01tUmZ3SFprNE80QWh3cDJJUGM3bXZhbUo5?=
 =?utf-8?B?VzlCYTlwSXVhenFqMm9xL3FaWVdFRTltRjJJWHdoam0zODh1anpKOUpFV2ha?=
 =?utf-8?B?OUIvOFlHWFY3VTl5ajNqQ3ZtU1RxUFB0Nk1abjBUY2hlWHJlY0xna1Y0UVdI?=
 =?utf-8?B?K2VVNjlxejJ3UTlrL2RGcG1TWEZwZDI3cE84alVQY1QxbVZVUDE0TDhQeFBL?=
 =?utf-8?B?Njh0U1lLdGRqeEU5cWpyRmVJbHA1WE5DSll4VEtQejhZd0JyRlU2QlMwcHMx?=
 =?utf-8?B?QkkydnE3dXhHbG9zS1AzUmVlR2kySEd1UHhnTStDb2xaNVF5RGd0V0UzMXRW?=
 =?utf-8?B?S0xoUWphcmdGRGhhL3B5RDZudnNidmhOdDRCWlphR0NMcVpJS01UYVB4eS9Z?=
 =?utf-8?B?N3AyL29nYTRzYW9EZ2tuRDZWVjk2UEJ2MTQrWkc4VEtoWk9YMjFKd2lFdGlx?=
 =?utf-8?B?U1k2N3dVMFFwYUEvcDRGRHBmY29kRE5HM25QbnFlcy84bDFPQld0YlduRmZG?=
 =?utf-8?B?OEZGRUNRYytZTUR1OHZLSkpYVHhrTUlMOWtsOE5Gc3VhNmZzbUdQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C51771064D82248A68F91348287066F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e3aa09-4565-413c-47b2-08dea576a148
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 22:36:46.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgWPvdWjocHPw6lVrxPisYI/5ZVFRVZj1ltDJ0iYjCr5/1ce+LOAcQamr0Ly1+ubxyEp8VRnzv/C9vhgdgV5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
X-Rspamd-Queue-Id: 33B7848CA66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241787-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mochs@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]

PiBPbiBBcHIgMjgsIDIwMjYsIGF0IDA4OjExLCBNaWtsb3MgU3plcmVkaSA8bWlrbG9zQHN6ZXJl
ZGkuaHU+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAyOCBBcHIgMjAyNiBhdCAwNDoxMywgTWF0dGhl
dyBSLiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+PiBGb3IgdmlydGlvZnMs
IHRoZSBvdXRwdXQga3ZlYyBpcyBpbmNsdWRlZCBpbiB0aGUgcmVxdWVzdCBib3VuY2UgYnVmZmVy
DQo+PiBhbGxvY2F0ZWQgYnkgY29weV9hcmdzX3RvX2FyZ2J1ZigpOg0KPj4gDQo+PiAgcmVxLT5h
cmdidWYgPSBrbWFsbG9jKGxlbiwgR0ZQX0FUT01JQyk7DQo+IA0KPiBVZ2guICAgVGhlIHJlYWwg
YnVnIGhlcmUgaXMgaW5hcHByb3ByaWF0ZSB1c2Ugb2YgdGhlIGJvdW5jZSBidWZmZXIuDQo+IGZ1
c2VfcmVhZGRpcl91bmNhY2hlZCgpIHNob3VsZCBpbnN0ZWFkIHN1cHBseSBhbiBhcnJheSBvZiBw
YWdlcy4NCj4gDQo+IEl0J3MgYSBsaXR0bGUgbW9yZSBjb21wbGljYXRlZCwgYnV0IHdvdWxkIGZp
eCB0aGlzIHByb3Blcmx5OiBvdmVybGF5ZnMNCj4gZG9lcyB3YW50IHRvIGdldCBhcyBtdWNoIG9m
IHRoZSBkaXJlY3RvcnkgYXMgcG9zc2libGUgaW4gb25lIGdvIHRvIGJlDQo+IG1vc3QgZWZmaWNp
ZW50Lg0KPiANCj4gSSdkIGdvIHdpdGggdm1hbGxvYyAtPiBhbGxvY19wYWdlc19idWxrLCB0aGVu
IHZtX21hcF9yYW0oKSBiZWZvcmUNCj4gcGFyc2luZyB0aGUgcmVzdWx0Lg0KPiANCg0KVGhhbmtz
LCB0aGF0IG1ha2VzIHNlbnNlLiBJIHJld29ya2VkIHRoZSBmaXggYWxvbmcgdGhvc2UgbGluZXM6
IHVuY2FjaGVkDQpyZWFkZGlyIG5vdyBzdXBwbGllcyBvdXRwdXQgcGFnZXMgdmlhIG91dF9wYWdl
cyBhbmQgdXNlcyB2bV9tYXBfcmFtKCkgb25seQ0KZm9yIHRoZSBleGlzdGluZyBwYXJzZXIuDQoN
ClRlc3RpbmcgYWxzbyBzaG93ZWQgdGhhdCB0aGUgcmVxdWVzdCBzaXplIG5lZWRzIHRvIGJlIGNh
cHBlZCBieQ0KZmMtPm1heF93cml0ZSBhcyB3ZWxsIGFzIGZjLT5tYXhfcGFnZXMuIGZjLT5tYXhf
cGFnZXMgaXMgYSBwYWdlLWNvdW50DQpsaW1pdCwgYW5kIHdpdGggYSA0SyBob3N0IC8gNjRLIGd1
ZXN0IHZpcnRpb2ZzZCBhZHZlcnRpc2VkIDEyNCBwYWdlcywNCndoaWNoIHRoZSBndWVzdCB0dXJu
ZWQgaW50byBhbiB+OCBNaUIgUkVBRERJUi4gdmlydGlvZnNkJ3MgYnl0ZS1zaXplZA0KcGF5bG9h
ZCBsaW1pdCB3YXMgMSBNaUIsIHNvIHRoZSBwYWdlLWJhY2tlZCB2ZXJzaW9uIHN0aWxsIGZhaWxl
ZCB1bnRpbCB0aGUNCmZjLT5tYXhfd3JpdGUgY2FwIHdhcyBhZGRlZC4NCg0KSeKAmWxsIHNlbmQg
b3V0IGEgdjIgc2hvcnRseS4NCg0KDQotbWF0dA0KDQo=


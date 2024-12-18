Return-Path: <stable+bounces-105147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8EC9F65E9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B22E16975F
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2518A1A23A7;
	Wed, 18 Dec 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="cpWjBsJa"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E919CC20
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524936; cv=fail; b=ubxxI8aW3+JHtVDAd2MW3jJXDSLX0/I/XA5E5DTqio6HyMswycYHazQQVh8QN62FGG9HBOPvAH0iZ45c1kL+ewxmKO/GneaTlwY++FxOrTChqCF8O/aMQxV1MgTbjzLvMqQ1ED0YUl0hGP+SWsZ/Eftcw0hgR5GB6hx62wSe9Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524936; c=relaxed/simple;
	bh=o1j16jl3LLRg5ISivfseT0iOIepQguHpO6a4SjiIGU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8QUUhRT3He3fsoFtne0Vk3nv38Niv5DuS6U+EfvOgCjKkj4MTnQwe9vDCC4nYgdyk3QQVB+H3v8fNSP3bwn06RRAMNZ10NybtYhuyXtm575T4n6BWembBV4jDBZ7+m5TBUxHqcPkgam2AGgcDWQSISjEdUbNGPmU0IoR/25ELg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=cpWjBsJa; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgr/OF4Q6F6APmrBPX1I7Mgcoj4G68APRvyr81OuT7sxYDVjE6PPNw31PkzbzzkW1qxX+akdUckDy7GKlzumzoBgqfu4xCIar4Wgj29BwkMO7vRoByRtfow9T1lq4QvWS/Bgr/SB3aw8FWsWF3302dRZLGvQnVbc4sOExk9uhJ1u9oCjyjpjr3tASTbKK4ABDVmOZP/OMgtxuwjlM4PTAdonhEXydGrscCjM6lSpDK6muaMn+dmMjoo/M0xJqFtMmtBf8jl8U7qZFpeeOOF4YaN5m9JJ1rBS5jdA6B5m5mEG6lvI6i7Ulsciybo56Yj+s0PNCdxFwBAlMBzX/PR8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cqXFchCy+8rauvbdgpQd9Ce2PzIq8CnqrW0/akQPGY=;
 b=MNRgVp+MJ37/rcU4RUcsu4NVU1jf+NS6HzJx6L/I7BnnayIoGOOvoej55p2EF2TVxhjOaWMBXIvvoUTQIwjNtTwFK1mhes6L4HhyRCiTjlocCaf41juPiqWUlhUAJOInmMvyaxNT/Q5D8/TFfrJAUsnhWV+JFLCU+NWxPIKGVUBaCA+XOIolJP3l4tP62q54Dz7QnQampE/iy9PnpM6sG8vt+YEXG4jmw96+BTR3Pml7oSn72niyV6bvEddONhK5Su5DQMp+C6rRyc6gviFi4j561ETjQO1ZN2zSy0IQ6yrTz2u2+kEQyfSjCOEwJdfGPOHHSPKYJUUNG/9SM9FOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cqXFchCy+8rauvbdgpQd9Ce2PzIq8CnqrW0/akQPGY=;
 b=cpWjBsJatPtG6zIYBXXHq3tZ5pLWK7aa6OYhiMmeB9ffA8jM425rAgJYryxhpQ/2Mt1GF2Dh5XLztw6cyFxvqqE5DHM/kQ7EAmo9t6IxHivCxUn8e5nHoARqngowRs0W0qowwBi6yJCq69rckCNWZDL6ndX8xo/P/gYROvmY5IJyjBvJAYpAPSjDulf50sk5LWX1o+JNG49Z+kBGHw1f02srwK3YoaW0+N09QN9O590xikMecWZks9gdWfVQrwpbhv2cXP0JVNxdauAHKX3vs5vhJ6ImcYJ6hXHSShstoQUmdwpkK+6HNMaxTpTl15FxnjBDdIb5AZgVQmdQZdRHsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com (2603:10a6:102:368::9)
 by PA4PR07MB7373.eurprd07.prod.outlook.com (2603:10a6:102:cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 12:28:51 +0000
Received: from PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf]) by PAWPR07MB9579.eurprd07.prod.outlook.com
 ([fe80::f88d:9d2e:618e:55bf%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 12:28:51 +0000
Date: Wed, 18 Dec 2024 13:28:55 +0100
From: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Cc: stable@vger.kernel.org
Subject: Re: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD:
 Flush patch buffer mapping after application")
Message-ID: <Z2LABy6mqCSdvBge@antipodes>
References: <Z2GZp14ZFOadAskq@antipodes>
 <2024121745-roundworm-thursday-107d@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024121745-roundworm-thursday-107d@gregkh>
X-ClientProxiedBy: FR5P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::18) To PAWPR07MB9579.eurprd07.prod.outlook.com
 (2603:10a6:102:368::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9579:EE_|PA4PR07MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0f423c-c243-4114-94cb-08dd1f5f87ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29XYWJ2MWk4OTAzQ3hUd1A2SXdkanhRTWtacHFwWkNwYXdYamJ3aUlQSWJo?=
 =?utf-8?B?V1dEbTY3WUhtbUk3SmgxLzc3NzlWV2ZLYW41NWVxQlZSYVh5c08vUmhOd09F?=
 =?utf-8?B?NEsycm0ydjB5WVRxRUtYZVA2cVZoMUpwQ09yeDdoRjNjQ0w0Wkd3dkhSZVh2?=
 =?utf-8?B?YWZwdGFYTlc1V1piU2ZNemFLZFo4YzRXamcwOENlTTY4U1Y1T0xjcEFyQzM3?=
 =?utf-8?B?YmVlNkhPMGZxNWJGZ28ybi8wK0ZRR2RqRCtPVytJRjFvQUZkdGxIZDc5ZlJy?=
 =?utf-8?B?dGhDRHpTNllEWUM4WmV0TXBpTVlrV21WbGlJQUNMcUFSemFyQVg2TzVrSU5t?=
 =?utf-8?B?TWlHREVwT2hnSTZ0cVFmM0tLUXZnSjM1ZDBBMW1pakIwYWhoOXJndklWN2wx?=
 =?utf-8?B?aXVKSFIwVyswYW96RFZrc3FUMlhtYUVVNDVPTzZ1RXJVdGh2UUg5aUlvaXhm?=
 =?utf-8?B?emk2UHptck1FZkw0dDdTNGp2WGJtUm9vejB6dmlDSzlCT25yR0tuVm1abTRR?=
 =?utf-8?B?a28wVlNKQzdyY3dMNFdZWERxbFdnck9HWTVydGMzY0hpK0ZSWWxWcmRHTmls?=
 =?utf-8?B?amlPZVhhT2ZiUGczYjVuQ1RDTW54L1RWbTYxMW9haWhyenhHcE8zeG1LV3Rl?=
 =?utf-8?B?RE5pQXc3WVJYS3A3dlV4ZzdoOVRqZ3hxbTVTOGtDeU4rclFSTlRaaU43aUZx?=
 =?utf-8?B?RGdWSWtweVhwYStqdXprK3o2QTVVU3VDM0o4bm1xZkUxVzhyWnpoUERnTER4?=
 =?utf-8?B?WHovUW5TMjBMcmY3emhEclZBZUtNS1JMUW5FWVovRStxQTMzS2dlNHZTekQ0?=
 =?utf-8?B?TlJpZUdMclA5eDA5UWtidkJtQUMvaVVLVzRVa2l5UG42dG9PZThaMWM4cGtv?=
 =?utf-8?B?Z2pNMDV0dDFjRU1yV1Awd3hZMnNtbjFJbG5KRVBhMnNZRDcrMFV4dktCTFBM?=
 =?utf-8?B?WWx0TFpjYktVTnQ3ZERJd3BVRGVKZFFVcnlFRWRtZzNuZHR4SllFWHltbjdD?=
 =?utf-8?B?YU1ZNm5DV09mb3J5b0VSall0U3hSSWx0MFNBZU1OR2dpc3RsSmlZdHkxa29J?=
 =?utf-8?B?YUJVRnU5YmwvNThJb1ZGaDhzR1F2bGV2UGJ4MVJmTEZxQkNjb0ZMZDdPL01O?=
 =?utf-8?B?L2dMWklUVVpyM3NPVGlsZmlscVBvWFhod1FFOVJGWVFHWDU1ZjlkaFlWVXhi?=
 =?utf-8?B?Z3EveUx5cFFya1huU3lFTElMWEpQV3RjZTgvdlRkMmdwc3lNSlVSMng3c2dk?=
 =?utf-8?B?aFRYRHAwRlRUd2RzaUJtaWF6UEZ3QUx3MHpVd2d5WTdTNWFIZWM3SzdYVytI?=
 =?utf-8?B?Q3FHbmlaZ1VHOXY1UmFVS244T1AydkNjZ1M2eU11dERaL0dKM3NIdUxNbFNU?=
 =?utf-8?B?YUR5bW15NVU3L1llZWlUVGdrbm1RY3ZKajhYR3FaV05Eb0cwYlFjNTNXcEhu?=
 =?utf-8?B?aWRUSlAzcHNsWGFqbE1CSlJwdFlGVjJHSTBFcmZielI3WThYckJ1SWxsVkkx?=
 =?utf-8?B?NkNWQThIemNKYXE2ZUtWVDRkTktmRWtLbG15ano3SXA0c0VXWDUyUUVGblFM?=
 =?utf-8?B?ZENpQjdMR2hqR2ZsTjV2WlR4c05qWFZXaE1TbWIyRXVyb012QVZXSjhsYWov?=
 =?utf-8?B?eFRjaU5HZ1VFRXNnNUNmdHZQY1h6c0xiOWNKeVhDaTRaNHpuNjlRQ3J0Z1BE?=
 =?utf-8?B?VEZxMFRsR2owKzdyZGRzNCtuLzNzak0rL1pYTzIxOU9MMjBPNU1XZ1FyckVS?=
 =?utf-8?B?d0JZM0h2b0NRWldQSXVJMWlXS0hqa1JNcmdNMThFMVZCeHRGbTQ3N003MitP?=
 =?utf-8?B?aXA2c2FuSFh5R05sdW9xeGcvUnI1N2xLaTlwakpTYWlkYUlJTWpUWmJRc3FS?=
 =?utf-8?Q?e0DdFcRI8BMpc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9579.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDgyZzZibjFKTEhIUExEaHlDQzFEb0Z3N2l4MVoybGNnZTVqSDNyWUtoejN6?=
 =?utf-8?B?YlQ5bkIyWXdySms2LzRaUlRKRUd2OXNPeHhFditEajdwWVFnQWR6WWdJa2lt?=
 =?utf-8?B?c1ZuUUlDenBoUXNocWhPSU1ucjhpbmZONmZIcURSd1ZJY2tkQ04vQ1Bxcmov?=
 =?utf-8?B?eDNTcXFxajZsRFBlMkVNVDlWRWVSYkt3MHlDRnpWWHlyeG1WUkc0UVNlSE5Q?=
 =?utf-8?B?M3lJOVZITm9IT3hocyt4bU1pYzhoY0k2Z3NXYkZUTEtTMU9Dd25zQ2Z5THlC?=
 =?utf-8?B?czRiN0ZpdnMvWko5dmlCOWY2VDFlem91SDhRZGhuNXhzL1VZcXNXSVJNUjVF?=
 =?utf-8?B?MXRqd3RBWUxBbGFPMU1DZWF2YWtDRklsdnpFR0xhczNNOUNOVjlvdE9UTFo1?=
 =?utf-8?B?enU0OVkwT1lTczU3T05ObjFzcFV4THpTWXNsZm04aXlZdG5ZNW43eEtRYnFR?=
 =?utf-8?B?bk10VkFRZDY1R2dYYkNLaEZQMGlmaGlkMjNPRFErc0lyMUJZMW5QUkhrVGNu?=
 =?utf-8?B?S25XQmI5Y3VYaGY5RzhoSWh6cUozc3FiQUVncHlRVjAvaVFCc0dyazNrTmF4?=
 =?utf-8?B?TGxDdzJWR1NlZ2ZYQys1SExRbTFLQW5HSFZzMVhPQUdDamtNYWpUWHRYc1ls?=
 =?utf-8?B?Y2c1azZTckZmc0lSTlUyc21XSlFDc282MlRyelhBOG9FWnczZVdCQ0NyZUp4?=
 =?utf-8?B?bWh6SlNsZ3JQQkEwVnlZRFhIOVlLWndwOFVNNnpUdzRzV24yUXhxY2M3bzBp?=
 =?utf-8?B?OTBVMzR2UFJzRHN4QTFMcUwyMkdUZFJxckJGbGlHTlZVTWFkT0VTckJrcFh4?=
 =?utf-8?B?aWNmYW5NN1hZbmxlU0E3VlVDNFdBblZ5bEo3SWdWOUwwa2M0R3ZPYnMzM0Ru?=
 =?utf-8?B?Sm95YWlsVnIxTktaVkg0T0dLYXM1MEJpY0srTVhnL0ZnV2xGMWJwL29DWFJK?=
 =?utf-8?B?Mk03bXdzS0RCV2NHVFhqZTF6cENsRlBxOXp0dUEyZUxXZVY3NkJIRTAzVWVD?=
 =?utf-8?B?YjFYRWl5SnV5c0VCSUM4dHowWlZJY3N1Ull0U3Rqd2pLNHQ5L0Y2MlVxQURP?=
 =?utf-8?B?NDJ2bjFhUkpSeWh5NkRpbHZiU1dWbThZdVFKZmd5ZXgwNlVmVk1yODZOMkxx?=
 =?utf-8?B?dFVDQXlaQmRXeDlyNHVaY2pZa1hzTHpCRHZtTWpjMGxHT3dvUFVOOVF2a2tO?=
 =?utf-8?B?cGxMYjV2Y1piamVtVG04anNBdlJCRGNqZThMbFIySUZKdzlJREdrNWJ0d0Ny?=
 =?utf-8?B?N3F2UVdEY0s3RWR2Z0E2aUtaSVVHMmV1R1REWjR4RXI4UjdpL2JaaHJod1h5?=
 =?utf-8?B?d2J3NzFtS1lyR1JRbHBmRHUrbUNSVnBCYis0SXZHalpYRkVHS0ViejBRMko0?=
 =?utf-8?B?YVFodmlrYmNZTFlkN2ZmVVBnUHdTVEUrR09LQjBQMTdsZlE5aXIyWXJ2bGtW?=
 =?utf-8?B?TzFwYWxacWZJWS9sNnB1dXk1NnhYVjZybzFYR0lOM0NUcHZaVzFVNUNMY1NH?=
 =?utf-8?B?bUJSMVlLUGpldUFUTE9iYndKV3c1VVo5WnBTTVQvakltWGsxU2cyTTRZQndq?=
 =?utf-8?B?blVOaElaNDZpN1J4TmQvdHdWUGw3MVpYT2dEblBiYWMzNk1qUEErSlFROHpK?=
 =?utf-8?B?S3RwOXRaOTF1OUkvTTR6ZzRqQnZQZXYyaXhRV2JpbkVXbnNENU5CWWwxMnpl?=
 =?utf-8?B?enIxSUNWUCtFSHNZcWV6L21jNFUwRk50QUxHSkF3dDVsbWdiaTd0SzJoVGdV?=
 =?utf-8?B?Z21Ba0ZZVk81cUdLWFdDOXR5aUVzMXFVSUdOTUw2MVBpM1diNlZzc3J1SlZh?=
 =?utf-8?B?aHJHczQ5aDJ4dWdwc0dFb1c1YytKdEFMSEdDSFRBMXdtT3Q2OWlpd1pZazh1?=
 =?utf-8?B?L1hsbks3b1ZWbUVTY1J6U1d6TDRIMWxQdmNRQWpkamxiSGtEMm5tK215dDhs?=
 =?utf-8?B?VTFOVng5empOUkxTaWwrZVVnWFRsWktYNk5vSTN4L1FxMTk5RHEzeXE5TTlV?=
 =?utf-8?B?M21OUVBKQjdhOXNTdmozT0QySTNzd1FFN21nMTgzdEFwdzVtbmlWam5ZSGVO?=
 =?utf-8?B?RUQ3WFZVTElnM0d4UWZxN3U4K1cxV0FhR2JqVlJHdU9BZHN0eU54Z3NzZno5?=
 =?utf-8?B?N1N6S2U1NkxRWUtBU2lBS1RwaWk5ZktRRkZJTGI0dmI4NVAyVDhab0thaWRi?=
 =?utf-8?Q?0sdHUQd0hiqYlhw+EqgUHpU=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0f423c-c243-4114-94cb-08dd1f5f87ad
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9579.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:28:51.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBgCTFtH0auEdKMfJy77NZMFO8cUAnccEHMZXcFTVObSnTaELthPB3RZIfbaUEpaTepAlOqqIu+fzDDbQ6GaBjBY53vTdasrPezyKBhmrdPxbvHurXEK2pvy/eAYG8cZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7373

On Tue, Dec 17, 2024 at 04:53:43PM +0100, Greg KH wrote:
> 
> Please send a set of working, and tested, commits that you wish for us
> to commit, we can't cherry-pick stuff out of an email like this for
> obvious reasons :)
> 
> And whenever possible, yes, we do want to take the fixes that are in
> Linus's tree, otherwise maintaining the branch over time gets harder and
> harder.  So just backport them all please.

Thanks Greg for your input, understood.

Borislav, are you open to preparing the required commits?
While I can test the behavior of the main patch, I don't know enough about the
prerequisite patches to handle patch submission.

Thanks,
Thomas


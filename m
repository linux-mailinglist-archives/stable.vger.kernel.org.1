Return-Path: <stable+bounces-203275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82888CD8661
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B63B301986E
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B423D7DC;
	Tue, 23 Dec 2025 07:39:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo12.lge.com (lgeamrelo12.lge.com [156.147.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D7288522
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=156.147.23.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475557; cv=fail; b=goh6fwm6gz+2JqTslqm+xCVv2viAiZsXXeFmxmmI1500lixLRkkluV836ZBd1p9ZCWumxUaWWTnoQT5IzQDCsrDKvuC/J3dmuHdBN/6N4I3pLFUcrDbTlE5nCm6rjEKfMZbftERiYtEppYPpb99A0AzF9x1xxEOcgMocbaemDLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475557; c=relaxed/simple;
	bh=re/MTU+KOy7iWIKCNKB9gLd6evePFTH64+tpebD3B/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8+BSPYJBLOHHe7/XbmSwQbXA+X5d6SAmXzls4NPC3aCPLLIJphXCcXCWq1GFhzxO+SnzI+uyyGiOtZyqIRupOWaxUgh9tAwq8/KWc5Yn516owCJ2QIoxioXAaY6Skq0KurgN4Gpi/Ha343FEJBDFvfsTusteIf0VqD9RiPJIgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=fail smtp.client-ip=156.147.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.52 with ESMTP; 23 Dec 2025 16:09:11 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO sniperexo8.lge.com) (165.244.147.19)
	by 156.147.1.125 with ESMTP; 23 Dec 2025 16:09:10 +0900
X-Original-SENDERIP: 165.244.147.19
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO SEVP216CU002.outbound.protection.outlook.com) (40.93.138.53)
	by 165.244.147.19 with ESMTP; 23 Dec 2025 16:09:10 +0900
X-Original-SENDERIP: 40.93.138.53
X-Original-SENDERCOUNTRY: unknown
X-Original-MAILFROM: chanho.min@lge.com
X-Original-RCPTTO: oscmaes92@gmail.com,
	stable@vger.kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfVuKDI82hZ7J7u+RPjfHIjyxXX4/XkRUauQefX/gmJzO7NjpVaBg8Vgd86ilx9UwyhACRkKpT2Do4YK/eR958e5mAuxVdP/N1AoaSENHl75MxgNVkHkMCr0b/Eo8VU1Nkwv9RsT34sLGSkICPVcwZ8cLeFJrTDYBvKRnG1ZTDyGaKeMSBjoZCvWgIegmNCfKTZkHazKSEi1zOzUQKCvMlbcmoh3FYIMLat3RqC8K79X4ibCKJdXj45fVyuU5fnQrw8gETJ/7bBk3Bep6oLt2zVy9SanvDqugmtQDAeXlUpcRJcwTBScbxBBwDTM4+UWVaWcF+r5ZlNIgaB2MPxnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re/MTU+KOy7iWIKCNKB9gLd6evePFTH64+tpebD3B/4=;
 b=wnBmv5Wu4OLTCFDMuari13094GBOlatpOGpi8aKhvHzVRS84Wg0oOSjDgkN7v7/qZVeg7JeFtVarezwuj9fkLxhRKOpHb6MnMnQg2h3nQM8ovJhHlOzkZwF7ggbgxcwHtWTQLQCDH1QLreEmOfXv9E5trHpuAZ670DFw6qWM9GCmQBGRECPTbzOTDTm4WpRtkDmW/KIaDbaGA2QwIWa7QWaxt7pICeAM4GMc9AMlJa/b5jzDC6RWtgyRyGRwJqR7OrqMms4A3sCXe9FeL0GyCPyrN6hTxnnKXNF+LCnbd2joT300tjK63FGpYOTupwMOpF07KnphiahoCH5GEiL0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lge.com; dmarc=pass action=none header.from=lge.com; dkim=pass
 header.d=lge.com; arc=none
Received: from PUVP216MB3499.KORP216.PROD.OUTLOOK.COM (2603:1096:301:164::5)
 by SE1P216MB2066.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 07:09:08 +0000
Received: from PUVP216MB3499.KORP216.PROD.OUTLOOK.COM
 ([fe80::3b08:c052:5304:7627]) by PUVP216MB3499.KORP216.PROD.OUTLOOK.COM
 ([fe80::3b08:c052:5304:7627%7]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 07:09:08 +0000
From: =?ks_c_5601-1987?B?uc7C+cijL8OlwNO/rLG4v/gvU1cgUGxhdGZvcm0ov6wpQWR2YW5j?=
 =?ks_c_5601-1987?Q?ed_OS_TP?= <chanho.min@lge.com>
To: =?ks_c_5601-1987?B?uc7C+cijL8OlwNO/rLG4v/gvU1cgUGxhdGZvcm0ov6wpQWR2YW5j?=
 =?ks_c_5601-1987?Q?ed_OS_TP?= <chanho.min@lge.com>
CC: Oscar Maes <oscmaes92@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sasha Levin
	<sashal@kernel.org>,
	=?ks_c_5601-1987?B?wMywx8ijL1RQIExlYWRlci9TVyBQbGF0Zm9ybSi/rClBZHZhbmNl?=
 =?ks_c_5601-1987?Q?d_OS_TP?= <gunho.lee@lge.com>
Subject: Re: [PATCH] net: ipv4: fix regression in local-broadcast routes
Thread-Topic: [PATCH] net: ipv4: fix regression in local-broadcast routes
Thread-Index: AQHcc9moq2zi/CAlTUuYQ8N/vfIMkbUuzZkQ
Date: Tue, 23 Dec 2025 07:09:08 +0000
Message-ID:
 <PUVP216MB34993FA21853E042818BD5D79CB5A@PUVP216MB3499.KORP216.PROD.OUTLOOK.COM>
References: <20251223065911.11660-1-chanho.min@lge.com>
In-Reply-To: <20251223065911.11660-1-chanho.min@lge.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lge.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUVP216MB3499:EE_|SE1P216MB2066:EE_
x-ms-office365-filtering-correlation-id: bdf5c271-01a9-4d21-df83-08de41f22a90
x-ld-processed: 5069cde4-642a-45c0-8094-d0c2dec10be3,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?ks_c_5601-1987?B?YXBYMXpqVVNRdU43MGtVWlFXWFlEcHF2Q3JvT3lsTU9pbU1mUFR6?=
 =?ks_c_5601-1987?B?cjc5bUpQZnNBcWY5ZE5IczBkajNPak9aeEdGdEF6NCtIcjlqRGRh?=
 =?ks_c_5601-1987?B?Qlo5ZG9ralVqdlFqQ25nS3FaOElnTStqWXUxZWJ5RzdjdGVwbHBE?=
 =?ks_c_5601-1987?B?QS91TmluR1JRajNzQzAzbjFKcm5FaDFKaWNXS0dJdzVDdmc1Mm0w?=
 =?ks_c_5601-1987?B?RkZ6R2hlbyt5ZmRxTGdHNlNJR2RDT0RHK3poOTBRVlpDRTdKWDZ6?=
 =?ks_c_5601-1987?B?OU5QZXdDZXVFRmlJQ3dmcFJXdzhWbnVsY3JhdlZlcFZkSzdaNHpw?=
 =?ks_c_5601-1987?B?ZXdzZkk2Z1FtNVdPcExiajFXZnUxaGlmUGhSbVdDY3RpWHoxbko0?=
 =?ks_c_5601-1987?B?dFkvWGdqVmJDS0FrVlYzbzVUTElPOWovRWdGM1Z4UjlHMVI5cUhB?=
 =?ks_c_5601-1987?B?RU8wRit6U2hqQ2dmMG1EM1kvYkI0N3QyYlBtd3hPTldwNzE5SExh?=
 =?ks_c_5601-1987?B?bDE4WklGVk9NWHlIZWJxY2F3aEpUWkVSU1BXanJpRkJ4QlJhY0ZT?=
 =?ks_c_5601-1987?B?d01Ea2R5cGpoNnhKMitrWkVZOWJpZjBEUmxtNWJFWXVxS3R2eFEx?=
 =?ks_c_5601-1987?B?Wlg2Q0RrVlRkakk4TTEvbXFvRVhyd21MemN6UldhYXREQlN2VHVO?=
 =?ks_c_5601-1987?B?VDVYRnpVeUFCSVpid2RYV0dwNHlDM3BQUUtCQVN2VFRQMjIyNitZ?=
 =?ks_c_5601-1987?B?bmlxTW52TW9pdmI3OEppVkpPZjFzSkd0bldtWkxyTzBObWtLa21N?=
 =?ks_c_5601-1987?B?S2xRV0x2MzlNZmEvQi9ZVUg2ODJHUDdLQVpKbUdtLzh0dkdlakQz?=
 =?ks_c_5601-1987?B?QW15d1llaGpoeTZISE02SjNvWkMxU1BGNVkvWGxoRDc3S2M1c0pN?=
 =?ks_c_5601-1987?B?cVcyWUJzTjd1MENEbmg4Vi84TnZoVGRSUCtQT0ZXYnhqQlpBNCsr?=
 =?ks_c_5601-1987?B?ZjN3dVJDMS9RVDI3aG5RN1A3WjFiWWNXYk9QRFdkQXhGbGJvNTlB?=
 =?ks_c_5601-1987?B?Ni9Zb2U5YWY1cjlIOG8xZHlsSzBqK0NYdllZdkhCeXNhc2dxY3BQ?=
 =?ks_c_5601-1987?B?YzZTKzlmQmloL2VnZ05rZHNPSDdObnBUNTY2d0hOemdNWlFYaGFi?=
 =?ks_c_5601-1987?B?cjRZeVhUZFRJeXRmY0oxUlRDUnlmTEQxOTNHRlNmZ2dWWTVXb2Z2?=
 =?ks_c_5601-1987?B?OW14ZWt3N0FVb1hPT01oanVsWXJGam9zOHV0NzFHZFJaTmtMckJj?=
 =?ks_c_5601-1987?B?SjZGRUpmQjhQVlVWd2xwM3A3YmkyaTlOQndjWm15T2dYd2Z3WDBT?=
 =?ks_c_5601-1987?B?SzJjYmxPS3cySVFXSU5Ea1BhY1c5UWNCSk5uMk5jaFNGYXF4dXgx?=
 =?ks_c_5601-1987?B?TWJXRlVqSW0vYjZpTGVrYW5TekZlNDY2VmVtbzBKdjBsWHNzTnpF?=
 =?ks_c_5601-1987?B?YzNJZHBvNDNUK2tia2RrazRoTEFvV2dialdtQlE2dGFsRWErWEpL?=
 =?ks_c_5601-1987?B?R2pYc2xGdUx2bnZ6ZDFkQjNYVmdGQStqMXMzOUNUWTlnckdSY0lS?=
 =?ks_c_5601-1987?B?NHdrOVpLQVJ2ZjBRdEo3dG5uOGtxL3hHclFMZEE2cS9JdVBTRlVu?=
 =?ks_c_5601-1987?B?MWpkSk9BdUtkaEx3MFdkNklHVEwzd0l0SllEU2ptRll0LzkrRzNE?=
 =?ks_c_5601-1987?B?b2R3QmNnTjFoSDNOSFNTdlAxSTU4ckl2WExpUmxjVHNMZ2V2ZHdM?=
 =?ks_c_5601-1987?B?eVhBVjBVYlpuNEZnWHphRGpDNnBaNkhpcTY2RENYM01lbkNudSty?=
 =?ks_c_5601-1987?B?a1FRN2dWbHJqTjZFa0hMTnNIaUNxbkxwdXRNUGs5VHkrSmJINU1a?=
 =?ks_c_5601-1987?B?R1FTUmwwZzJKT3JzRWcrNjgyQklNdTBtNEtpbURjTDU2RURnVFQr?=
 =?ks_c_5601-1987?B?NjZPTzlFdmlSSTdUN1gyTE8xNGVYQTJJeUVMK1RSZXVkS1FYTVFW?=
 =?ks_c_5601-1987?B?S09CS0JvQnlxOXlOQUJXM1BWN2FoKy8wRkZNM1hxdHFnci96dmhv?=
 =?ks_c_5601-1987?B?T25QMDJ0VWFoOHljS0hmRjE0RmZKaEdJako1aFVHZmpLbDFtQWQr?=
 =?ks_c_5601-1987?B?WDBtTUpOZHY5ZVF4MStQZVBZazhEUUNxbzNRMUhGNzk0M1I5VDVY?=
 =?ks_c_5601-1987?B?ZDdEK3RzNHdkMjNyUjlZZFo2cm8xVm1WMjExUXl3SVo0Lyt2SSsw?=
 =?ks_c_5601-1987?B?T2FkWkdGby93cFFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUVP216MB3499.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?ay9QaFQ2YkhOcEpmQ21YV3VVaTZBejVlTGlSajlTVFV2NXpDZEtC?=
 =?ks_c_5601-1987?B?VVZxNXFyUDdnc0YyNVBIMkhJYjlZOEwrckw4eCtMZXlEdEdncE5P?=
 =?ks_c_5601-1987?B?TmVEQm03RUNsMW9KdGlJZHdZUEs0ZThLQ01iVlRYamkvczFnUFFB?=
 =?ks_c_5601-1987?B?aGxwQzF3WUVrMDgzSWduaDRmSG5Nc2tZdVhkQVFlcXdRT0t4K3I2?=
 =?ks_c_5601-1987?B?YmY4c05PR0xEVVVqSTlQdkt5MjFVTFR6S1FrbXY1SWFtcSsvZWJx?=
 =?ks_c_5601-1987?B?QVd2UmNiVzJMcEZtL3FxRCt2U3BwUVpkcmRyRHpEUHJpUXdvWXdw?=
 =?ks_c_5601-1987?B?clhlVnBqZEJ0RGhNcnpobHFoUU02bkRuSm4wSXhMemJNd3NsTlY4?=
 =?ks_c_5601-1987?B?T0ZBNS9tSmJZQTBWaWdYNzV1b0pIdmtGbTF5QWVWM3FSTGJJbG5q?=
 =?ks_c_5601-1987?B?Q2JMeEprV0hkVlN4anlibG5CM1VsMndkbUdKaXhLaXFMRnNGRjRT?=
 =?ks_c_5601-1987?B?YkNMQTZnK0xsckhoWjhQZjE1bGhPMkpidkduckkxK05BUXdQaG01?=
 =?ks_c_5601-1987?B?emVmZGdrSWRKeTE2dXM5MEtSeWpTK1VFV0JKZDFFUGQremkrcks3?=
 =?ks_c_5601-1987?B?ZlR2TW9yMlFSSjZMM254MXNsOEhZZzdISGlnY3pybGNjN3QrQzF3?=
 =?ks_c_5601-1987?B?amRwQXc5K0pYMXpjMTBacFB3dCtHRGh1anNybVpQYXZQazZrdW82?=
 =?ks_c_5601-1987?B?OTRYaDRxbWo5WVlsYjRBc2szWGFacXNEZnRaV3hwNTlSeTEzOW1T?=
 =?ks_c_5601-1987?B?RFlCZ0lNdG1xRUZtMjZjUVVPY0M3VFEyMGVZcFY1dVQvUStxVWI2?=
 =?ks_c_5601-1987?B?N3NrNlQyNVNxM05tOFNMVVZ5cVdiZUM5Y1dkd1JYYU54TE5GcDVt?=
 =?ks_c_5601-1987?B?VU9DdVVuZ0RicTVabC9WNlZBbGl1S3gvQll2cFVXVWVZNE5VOER5?=
 =?ks_c_5601-1987?B?KzdEWmhuYjNWVzdaOE5UbWdxSmZFRS9hTDYyendYK2VwZEJUQVR6?=
 =?ks_c_5601-1987?B?aFZKWU5VRHN0NXpwRmFHY2hLTVFDZUhuWWp3QnBqekh5OXJJcTQ0?=
 =?ks_c_5601-1987?B?bWx0MzhvZ2pMUXgvOUhuMUY3RWFQTlFDRmRXK200T2h2UWhNbHJj?=
 =?ks_c_5601-1987?B?NitETHE0eVIvR21IYTNFUTVpbVJxWkFMM3Yyc0pjcE9JcEQ0UTRk?=
 =?ks_c_5601-1987?B?ODJ5TDNPMDNyYlBoWGJpUkF2R0ZkT1NSakRsZS81Yk1Lb3NZcmRN?=
 =?ks_c_5601-1987?B?MkdjWXNnaVdiUWFtSG0weGxRUzUvNENvUFhrMFplNDhkK003K2Vz?=
 =?ks_c_5601-1987?B?c2FhQngxTEdNZHpGVEZxVnNLN0tvcUtBdWJQNEZpdUJMYlprN3pa?=
 =?ks_c_5601-1987?B?ZForRmdWSkpSNWxoMnQyYm9LMTlGTkx6MzJobzIrYmQ2K3RLN1Ju?=
 =?ks_c_5601-1987?B?Q1lNWGJUZFlVaHJQQXJjb3g5d3l5MlJ1ZXp0bXpDVkVwbEh5MnlP?=
 =?ks_c_5601-1987?B?VEswZVlYYXc5RnkxeU56Vk1tQ05LUWJCNVRrOEQxQWF2YTdvdG0y?=
 =?ks_c_5601-1987?B?eEFObmVLOS94U21LRjNEVFkzMVFUVktTYTZCdnhTUGw4bWU1SnFY?=
 =?ks_c_5601-1987?B?SWxFSk1qcytvc0llY2hueVNtNURuK0R5THF1VjZGWTVDTHFna0pD?=
 =?ks_c_5601-1987?B?MEEyT0hCQ25sYytpY3MvamswYWhFSHFtR1RoTmovWmFLT2Z6SXhT?=
 =?ks_c_5601-1987?B?cGRTME1FSEc3TDdZSjJZUVZTSTl0Ulg1VkhYL09zQnhJdERES3BI?=
 =?ks_c_5601-1987?B?em5vNjI5WTJyQUVFRFJuZTNpYWtmZC9rSGlDTUhrdnU4bXlCVVJn?=
 =?ks_c_5601-1987?B?MDBuSFlRS0F0YURmOWJ0ajVJU3FWcmpMUFh0NWtXREh0Y1BtTUto?=
 =?ks_c_5601-1987?B?ZXM0RCthTDY3cHVMc3FpOEZpN3NIYVhCYmNaTG5QQ3lvTm40R1FJ?=
 =?ks_c_5601-1987?B?TmVaVFBmYit1d1ZsRndIQkJGeW5OMlpNcFRXMyt5cEhnRTZFL3lX?=
 =?ks_c_5601-1987?B?VnkrdHJaZmJzM3BiQ3JiYWhBVnRGZ2hqcENuYXhNbENGckNGWC9t?=
 =?ks_c_5601-1987?B?VEhpa3hyY3hHNVNkaEpJNXQ3ZzFtdVNrVHFqeHpLYW94T3dMVTdn?=
 =?ks_c_5601-1987?B?NGFBai9CUHlsbGlqdW5JSFREUmNPSUFQcUplZlNwdU1uL1U1dlgw?=
 =?ks_c_5601-1987?B?MFV3ZDU1TjRFN0ErNENSQytteXJ2cnNCU3pMVE9DRWltTWJBMHI2?=
 =?ks_c_5601-1987?B?OXZUUmFNdGR2WlIxNkRCSGFyMmFHT1J6dmlqVHNqYWFUajQ3amRX?=
 =?ks_c_5601-1987?B?SWZTb1hiWVI4V2FMTkdtNUpDeEJIWWdBUGFBY1F0MDBiaEt2YXJV?=
 =?ks_c_5601-1987?B?K0g5VWhEOE94QnRLcEk5cnlYb21SOERQUWl3VkdOaHU4Z1RrZDF2?=
 =?ks_c_5601-1987?B?dHJoRWd3aGt3MTRrV1hzaWZWTXIzNy9SQzRUTGlBUWZJQjhUWnlT?=
 =?ks_c_5601-1987?B?a3h0YXFOT08vYk5wOTBWMVoyREN0Z2MrQk9HbmVpRXhLVWZjY0hV?=
 =?ks_c_5601-1987?Q?itML0CPH0cPJ?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lge.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUVP216MB3499.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf5c271-01a9-4d21-df83-08de41f22a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 07:09:08.4621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5069cde4-642a-45c0-8094-d0c2dec10be3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4semuAj/Ibj2EsyFY1c0/xpJOVaHpTEgtlxZX8xtHlj/VouOXPIlgn6R22CevKrigWyrLr1UIcgOvZLCjhJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB2066

DQpIaSBhbGwsDQoNClBsZWFzZSBpZ25vcmUgbXkgcHJldmlvdXMgZW1haWwuIEl0IHdhcyBzZW50
IHRvIHRoZSBsaXN0IGJ5IG1pc3Rha2UuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UuDQoNClRoYW5r
cywNCkNoYW5obyBNaW4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0KurizvSC757b3OiBDaGFuaG8gTWluIDxjaGFuaG8ubWluQGxnZS5jb20+DQq6uLO9ILOvwqU6
IDIwMjWz4iAxMr/5IDIzwM8gyK2/5MDPIDE1OjU5DQq53rTCILvntvc6ILnOwvnIoy/DpcDTv6yx
uL/4L1NXIFBsYXRmb3JtKL+sKUFkdmFuY2VkIE9TIFRQDQrC/MG2OiBPc2NhciBNYWVzOyBzdGFi
bGVAdmdlci5rZXJuZWwub3JnOyBQYW9sbyBBYmVuaTsgU2FzaGEgTGV2aW4NCsGmuPE6IFtQQVRD
SF0gbmV0OiBpcHY0OiBmaXggcmVncmVzc2lvbiBpbiBsb2NhbC1icm9hZGNhc3Qgcm91dGVzDQoN
CkZyb206IE9zY2FyIE1hZXMgPG9zY21hZXM5MkBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IDUxODk0NDZiYTk5NTU1NmVhYTM3NTVhNmU4NzViYzA2Njc1Yjg4YmQgXQ0KDQpDb21taXQg
OWUzMGVjZjIzYjFiICgibmV0OiBpcHY0OiBmaXggaW5jb3JyZWN0IE1UVSBpbiBicm9hZGNhc3Qg
cm91dGVzIikNCmludHJvZHVjZWQgYSByZWdyZXNzaW9uIHdoZXJlIGxvY2FsLWJyb2FkY2FzdCBw
YWNrZXRzIHdvdWxkIGhhdmUgdGhlaXINCmdhdGV3YXkgc2V0IGluIF9fbWtyb3V0ZV9vdXRwdXQs
IHdoaWNoIHdhcyBjYXVzZWQgYnkgZmkgPSBOVUxMIGJlaW5nDQpyZW1vdmVkLg0KDQpGaXggdGhp
cyBieSByZXNldHRpbmcgdGhlIGZpYl9pbmZvIGZvciBsb2NhbC1icm9hZGNhc3QgcGFja2V0cy4g
VGhpcw0KcHJlc2VydmVzIHRoZSBpbnRlbmRlZCBjaGFuZ2VzIGZvciBkaXJlY3RlZC1icm9hZGNh
c3QgcGFja2V0cy4NCg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCkZpeGVzOiA5ZTMwZWNm
MjNiMWIgKCJuZXQ6IGlwdjQ6IGZpeCBpbmNvcnJlY3QgTVRVIGluIGJyb2FkY2FzdCByb3V0ZXMi
KQ0KUmVwb3J0ZWQtYnk6IEJyZXR0IEEgQyBTaGVmZmllbGQgPGJhY3NAbGlicmVjYXN0Lm5ldD4N
CkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcmVncmVzc2lvbnMvMjAyNTA4MjIxNjUy
MzEuNDM1My00LWJhY3NAbGlicmVjYXN0Lm5ldA0KU2lnbmVkLW9mZi1ieTogT3NjYXIgTWFlcyA8
b3NjbWFlczkyQGdtYWlsLmNvbT4NClJldmlld2VkLWJ5OiBEYXZpZCBBaGVybiA8ZHNhaGVybkBr
ZXJuZWwub3JnPg0KTGluazogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjUwODI3MDYyMzIy
LjQ4MDctMS1vc2NtYWVzOTJAZ21haWwuY29tDQpTaWduZWQtb2ZmLWJ5OiBQYW9sbyBBYmVuaSA8
cGFiZW5pQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+DQotLS0NCiBuZXQvaXB2NC9yb3V0ZS5jIHwgMTAgKysrKysrKy0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9uZXQvaXB2NC9yb3V0ZS5jIGIvbmV0L2lwdjQvcm91dGUuYw0KaW5kZXggOWE1Yzk0OTdiMzkz
Li4yNjFkZGI2NTQyYTQgMTAwNjQ0DQotLS0gYS9uZXQvaXB2NC9yb3V0ZS5jDQorKysgYi9uZXQv
aXB2NC9yb3V0ZS5jDQpAQCAtMjUzMiwxMiArMjUzMiwxNiBAQCBzdGF0aWMgc3RydWN0IHJ0YWJs
ZSAqX19ta3JvdXRlX291dHB1dChjb25zdCBzdHJ1Y3QgZmliX3Jlc3VsdCAqcmVzLA0KICAgICAg
ICAgICAgICAgICAgICAhbmV0aWZfaXNfbDNfbWFzdGVyKGRldl9vdXQpKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQoNCi0gICAgICAgaWYgKGlwdjRf
aXNfbGJjYXN0KGZsNC0+ZGFkZHIpKQ0KKyAgICAgICBpZiAoaXB2NF9pc19sYmNhc3QoZmw0LT5k
YWRkcikpIHsNCiAgICAgICAgICAgICAgICB0eXBlID0gUlROX0JST0FEQ0FTVDsNCi0gICAgICAg
ZWxzZSBpZiAoaXB2NF9pc19tdWx0aWNhc3QoZmw0LT5kYWRkcikpDQorDQorICAgICAgICAgICAg
ICAgLyogcmVzZXQgZmkgdG8gcHJldmVudCBnYXRld2F5IHJlc29sdXRpb24gKi8NCisgICAgICAg
ICAgICAgICBmaSA9IE5VTEw7DQorICAgICAgIH0gZWxzZSBpZiAoaXB2NF9pc19tdWx0aWNhc3Qo
Zmw0LT5kYWRkcikpIHsNCiAgICAgICAgICAgICAgICB0eXBlID0gUlROX01VTFRJQ0FTVDsNCi0g
ICAgICAgZWxzZSBpZiAoaXB2NF9pc196ZXJvbmV0KGZsNC0+ZGFkZHIpKQ0KKyAgICAgICB9IGVs
c2UgaWYgKGlwdjRfaXNfemVyb25ldChmbDQtPmRhZGRyKSkgew0KICAgICAgICAgICAgICAgIHJl
dHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KKyAgICAgICB9DQoNCiAgICAgICAgaWYgKGRldl9vdXQt
PmZsYWdzICYgSUZGX0xPT1BCQUNLKQ0KICAgICAgICAgICAgICAgIGZsYWdzIHw9IFJUQ0ZfTE9D
QUw7DQo=


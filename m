Return-Path: <stable+bounces-190022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBCC0EEA2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C420A4FCAE7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CE230AAD7;
	Mon, 27 Oct 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bhi2PhwF"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7629C328;
	Mon, 27 Oct 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578195; cv=fail; b=ZJihYCb8AcbNqQ1kV544uZg9xpEFiVkOplb4tSQntwKH3foh8A1Jje5UGamDms+Izm26eT5DpBteurNZjPLBijub49PGykWtgfnyXX6Ln8SZoypipN9nGzKlN8aFYxuQap3JpZVawMHxGHUM0wLFYh5C0nYMN8tgGBc/f7lQTHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578195; c=relaxed/simple;
	bh=GFI+PhxRTqEO4YWD0UvTV4Bc0vk/o22p8gwA1EdPg/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IUTaizWLeCMidbrdMuLt01LxdBBsjpIDk+1chMl1yrTcVm7BHhLt1exhpFUT6JNae7nJLXfuqe1q74bpWIjRmeYiLQH366JjtGXpRZt9AUlc11TgxE8KIlJ16bXGZNdVypgCaGjxX3QXusdFvS9qdkhqxpbyykjwZojq6v6Kmjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bhi2PhwF; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUYZEV5KcGWZI7Vw2z0EYArpZqpZP1vU74kTcq7SyJoCBwixBM9HNmAg/12f1KlpzcdaRmrrGSaGylwodjLDIKJT2vkT2jT/ejVex4G0/S7QLkRFqjKoa528XcvQDQpiztyZHwrLxb/cwKhnBql0AQgWkG+8FpWWpu5mDy9oXys4ScTGV/k49Kr/xtxFYlybZEXpIrknmcw4CY/yWjuveRVuF2nNn09F2Nl0zs7URxP+ycfYmRGbepCr9ce6WjOWQjv2rraL3clywus0hsZQiGVykgqQPGp37QeLr0LJ2WM4MdvaMFMLl/JnPPjmqSZruDI7rwFYw5Fs5HmlN+Duhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFI+PhxRTqEO4YWD0UvTV4Bc0vk/o22p8gwA1EdPg/s=;
 b=aC2rbjUxbfCMx+3M2z9gAtna4HXXSAUixu17A6UG042CIWFk7jB6+DhUPdOD4KVOnyN2soIt/5kkUFaBJXvrXFeb7DQ3QUY90cT4pQ0ULiqXuKHW+pukOhPSFnVKX8tNPpI1mrmwa/gUla+q3STPmcNLBMmgdvVC2ip0sGW7sgDne36JNrUfke4gl3JfzxjRljihyt7Xfyzc8I/yqcPZ8uu2RVwCIfSn/ec4/4utkffhz2obwAoz6bC0lVwMwa8FCo1gxl+2bjMkVAqgoT4OEKYyiguIdsHd+/So3/teRZLalw2wDaAG8D+0KbVfwu4c9SkwOektBiyZ8QtfygWEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFI+PhxRTqEO4YWD0UvTV4Bc0vk/o22p8gwA1EdPg/s=;
 b=Bhi2PhwF0zGjpQOwE6jN1YwBBSKcpsamqvmP+6O5HkultKgcM9KuIkR7rP4igVeuZyJisAmYxL3zxZoMPDTmQyh4IDjr3WSiiOAdpYe99M6YhMbb98o2Iffs0ErHupkFbYJoEABxzv8+BkuA4M50aC7vyv+z85Vrx3w1nEoWpw0bPjJowH8vC9szJI8dNrCeoW4V8XFq1RhoO+hmBaHzo3TkFyMTO34EXOxxtJo/r8LsRbKMvRs3Mt6jmv91O/g9JEfdbxpeojlsRHxmp2wxdkT4Ijr3zebs4g9GlELZky0U51vekUxp6Nkj8O4t0QhX3toNxkpew/6A9KqHKq6L+Q==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 15:16:28 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 15:16:28 +0000
From: Parav Pandit <parav@nvidia.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Minggang(Gavin) Li"
	<gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Topic: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Index: AQHcRPgJwKk3Q45MeUGTanh0wr8u4LTSclGggAOldQCAAAGUoIAAAxiAgAACs8A=
Date: Mon, 27 Oct 2025 15:16:27 +0000
Message-ID:
 <CY8PR12MB71958D2281DFAB75D5602C9CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
 <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <e7e05a6f-1995-4c49-929d-3d8ee7b0ac5c@gmail.com>
In-Reply-To: <e7e05a6f-1995-4c49-929d-3d8ee7b0ac5c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH1PPF73CDB1C12:EE_
x-ms-office365-filtering-correlation-id: cf3c0150-9d53-40f4-5e21-08de156bccc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b25JQThzcGxldnJGMXF1MWsxa01IaVJxNmRMY0IvT0FIM1ZTY3BuWk5UZGQ2?=
 =?utf-8?B?VSt1S2JhZFkwZ3N5NVpIUG1zZjRETGkzQXJBMXUybUovVE5lNSs4dUF3ZThQ?=
 =?utf-8?B?MGZ6cmJWYnNna3VUWnRNYnc5Mk5BS1lDZVZrRWhlRWt1eTBwTEs5dWg4RkxI?=
 =?utf-8?B?ZmFubWFrZGE5L0pGRzZkeGZFU2VQc0VoOGdBR0t3dC9Ec1krVUZZMFRsdGIy?=
 =?utf-8?B?SFN1ZUMxUFd5ekJ3d0plekFlV3JJWno4dW9mbDNYTllNVHhxS1FwcGtCM3Z3?=
 =?utf-8?B?cHhBYUIvcCtxK1lyci9LN0ROSDN4ZWpkb3d4aU1xTXVhYXVsZFZRNU1BbnEz?=
 =?utf-8?B?bjZzZzVGOXQ0YzZHZ2hwZ2xPU0N2MGhZbXhSYU00T1N3bWhrRkxNaUZKVkRB?=
 =?utf-8?B?RFh6TkNpQllFd2FZVk50SEFuZ2lUZVRMemltUGdERHFwT0JvdFNLV1VsWHE5?=
 =?utf-8?B?R3VMM0pheENBUmszeWYybGtPaUpiNENJK0pERmRSSWFDdVRaS3h3RnlRRWFQ?=
 =?utf-8?B?VGQ3UnVrcHAyYzdIM2ZZTVI5a1JYTWdjWkNVWWZMaUk2akRCaUs2NWJGRUNB?=
 =?utf-8?B?N0Vla1Y1RGo4a3hkSWQ1R2MwVHk3NVZrTzBPeFRpZ29xTXlNK3l1NTY0eTZ4?=
 =?utf-8?B?bS9ocFJGVW5vTkZ0Wk80dGJtaVAxSTVaN2phTExhRTI1bVBNejN0MDV2ZkRa?=
 =?utf-8?B?SGF3a295aVZqTkFGelRGcGJTZmIwK1ZNZzhXbW9od1lZRkx6Uy9DQW5GZXhq?=
 =?utf-8?B?Q3ErVFp5dGM4bkNJaEQ1azRzTWFxdVlJMVRnYkRLUEVmNzk1aS9KalFwNHhG?=
 =?utf-8?B?bEhOWDJXZWJZdGVrZ25BVlI1bmpnWGR4bzBpbkNZanJoNm50YmcrN3p5bGJF?=
 =?utf-8?B?TkNLNkVIdGxMQTdmYmNRNi96aEEvL0I0MHhHSGVGWityWHFObEFPZGQ1dU9W?=
 =?utf-8?B?c1Z0QmpIenoyalExQzVmK2NPL0F5NnA4Uk5ndWsrZGFxeGxtdVJRTm9BUkVi?=
 =?utf-8?B?anhGbG9WMXZ1M3RGbDdVaFJvd2pRUnZrSVlXTkdZVXRhNEFtN2NjS2E0TjN2?=
 =?utf-8?B?UUhlUW00NUwyejRPZUgwYmdkSGlIRXNtQi92b0FzOFRjUmdTYzhneHZJMjBT?=
 =?utf-8?B?TVFEOW1BcVBLRnVDeWR6ZHVhK2d4Vi9nLzVoTXQ1RlJJTGNrSjRXOVUzV3hi?=
 =?utf-8?B?eTl2VmZtRklxRnJOZTd4eCtmcEwzQ3FtbEcxUkdZb0VFNmcyTzFEeUQ3a3FJ?=
 =?utf-8?B?bTZEOXYxQ3R6N3VNb3JwejZhV3ZKamloZG85cEZXUmhjTFZSVkdLRFZUVVRy?=
 =?utf-8?B?T2J2OU4vS0lIcUFXM3dGRVBod21OWG9oTXZWcjd0REcwUnhnTE5YaFZNK01N?=
 =?utf-8?B?elM4cXh4ZnRpTENEeVpJakxaaVB5bHZFNXR6cHUzMjVvTWNaM0VMSEt0OXNE?=
 =?utf-8?B?MFhlczFUWUNyeHJVbnBVaC83Nml2d0NIMndVN081YnF5clEreVBXUGxRRjdu?=
 =?utf-8?B?WjA4cFlWaHNnOFBibFc5aXFkSklBNHUwNDFUZ1p2cER2dHY5dmYvdDNBUjBZ?=
 =?utf-8?B?b3hEUk9NTkRDMGNBa21UcExSdjg1a0poZmdyR29udVQ5eGhrQllJZ3ZjNzRl?=
 =?utf-8?B?c2x6UXBmMytqTDJscDZEVStublZDZzd1MkQ2MEthYy9Zem5ZNmpicUZSMXho?=
 =?utf-8?B?UjlsbkZrQ2FCak5zNkFyM0pTeTNiRDdxeVJjK3VyaEptM2pCNXY0eWg0ZG03?=
 =?utf-8?B?RGh3SmhjcTFkOFBkbGVVcmhSY05qL3JRelVzR0t0N3dvR0ZvSmtSOWo3YmJL?=
 =?utf-8?B?aEpzZWhxdnVYUEJxNWpMWXVYN2xXbjNVekJiVlJFMG5uc0FxS2VPNVFVNVZk?=
 =?utf-8?B?WXRWV1MyeUMwbjFuVzJrOEJ1ckdyS0M4YTBaZkJCZE53RWh1Q0lKQ0c0RG5q?=
 =?utf-8?B?VjBOU0JUSXRONTFQSG40dEpuRlJWZCt4MmF6QVNnRExLai9rSHZSZTFXMXEz?=
 =?utf-8?B?WnQ4SjI1aGNLQ045R3JJK2F1M3dWVGs2VFd1L2p1RWZJZlUwelVFS2xIbWFY?=
 =?utf-8?Q?QSOngy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2MzMnFyVXFoMGJVY0p5OFh3L3BiMDFVZmJ3T1pIaWE1QVZsS0RwT2p1Zmxu?=
 =?utf-8?B?ZExHcVhGM0kyRnJISVRlMm5QK1N3MUplUWVMbktpTTk2SjlWY1E0Y09HVkZ4?=
 =?utf-8?B?TnoxNXpTYklXb011U1BXaU1NQzlPZE1LcWtobFJCOVQrQVNuL2phbzYya2ZK?=
 =?utf-8?B?M2J0UGVQR01haitrMlJtN2hoU0Nzb0hYV3gzQWVSTEJHcFFaMVF4L09vaWtN?=
 =?utf-8?B?R1dVVEUxNzVjalZHdVd4M21xQmFFcEJQOFJXelVPZDAreWJkL00rUjVGdnhZ?=
 =?utf-8?B?WW9tZHhwN2dpT0pnYTlQYnp6eFhvUWxxTDg2RzdhUTUxNVVNWjBKOSttbmFD?=
 =?utf-8?B?bEE0aWlvSzhSdDBoYnNYY0htR1RCSUtRN2srUlJNQzlDakIyR1Rnc2RnbVo5?=
 =?utf-8?B?aWUwaHRWTWdGd2xZVHJ6UjVaVEJkR0RIdUFIdnlTcnE2RVZOQjVoMjBxSS9G?=
 =?utf-8?B?M0JvcUs4bTQxRDRGRFRNNmVlM2h3WUMxNHd3b1UvZFIwZ1d0MW4zMlQzaW1U?=
 =?utf-8?B?dzhBZng5enhVTHhuK3BaR1NUQStkQW9rSStXVkdaRmFrbURzMXdDb3M2K3Fn?=
 =?utf-8?B?dzI5OTlBclBqTUcrZGRPS3FhT01FMEhzaDVqeUdrdVZoaDd2clhGeFpqT0pO?=
 =?utf-8?B?ZkdYZHBlbXNjUEZzYVZhdTVzS3Urc2Y3VU1ZN3RDSkV4TURtVU40Y3ZBb1hD?=
 =?utf-8?B?cUphUjZzemhGM0JOcHVmZDJtMTh4ZllrOWl6VnVlTlU1TG9rVFp6bVZwSXVl?=
 =?utf-8?B?OEFaa1lKZCt5Z2lZRnlWMTJBZlRIM1dneDVwVHJjYlVXalQzaERCemE1WktM?=
 =?utf-8?B?elRaVnJ2YVZxd3JtSC94amFqbzJpdnprU3l2OEdTcUNBd1JUS1pIRXR4S3NN?=
 =?utf-8?B?emJJWnY0Kzc5Um1zRFQwSGdUMU5pd0svUGNLSEthOUcxUWNHWU5VVm5kTVZS?=
 =?utf-8?B?WjlodDdnSUFDZmd2T3V3bXBKYlV5SVdRQ003czRDdkcwb1BWZXJmanY0eGRN?=
 =?utf-8?B?NWhTakc2VWhqaVdhK0RnZUxqTjMreE1Yc3dBby9mZzBuejNIbnZ2cUlqUjMx?=
 =?utf-8?B?UUcwREJ1L0hQc2RTS1hhWURncjU3K0JCdmwzQUVMNzB2R3o5YzVGWi80SmV6?=
 =?utf-8?B?WGg2bEVUdURYSUd5MUYyeTdjMEZMMXJsbzg2Q2xSZmk5K0JUNmZScWJYZWlS?=
 =?utf-8?B?a0RnbGpyYmNQQmJqSFV1SFl6OGNtN1EweDhJYlZGTjZXVHhhYzRTUzdYZlF0?=
 =?utf-8?B?czJpVytNdnR0NHB6WWhHQ3VZWUF2RzVOeHRtU2dpZUxPcDNzTXJWZEJvbEpa?=
 =?utf-8?B?RU9sQmRLbklrdmJ4VGttV216ekJzWnEvVmZ0d2ZqcEgrdkFpTitoWmZ2VjlY?=
 =?utf-8?B?UXFGZUdQSEhGSnBGaFhhajQyMXZZSGp3TzlucEFlSjNZSHhUNndBUmRsNnls?=
 =?utf-8?B?cDFMTlRhL0J6d3BVWGYrYzlkWFRzMkhQWDFtN04wQkdvclppRXZLRVVDMlJk?=
 =?utf-8?B?UUZZemRoejdwakJUSGZaR2FQK0dXWHNabnhTeG90Y2VZSWp6bExCdUpCdjV6?=
 =?utf-8?B?RjFGWER2WVlTMThsVlJrcndCMkE0ektDME83U3RtOVJaVVJMRENmdy9JZTd3?=
 =?utf-8?B?ZDhrdmd0eUozUlRHMEJqM1ZlbWdocFVXNEp1elJSZ0VvbGdYRSs5Zlk5TTFQ?=
 =?utf-8?B?U3lRcTJubSs4Y2VlQXhlTTNJaisxYU52YWhBYktKYm91aHRkaEhkUy8za0tD?=
 =?utf-8?B?SnBVaGN3MkNCdzhaV3I4UEV0bk4zY0d2c3V5b3l2aDRqWVpUUlJsZlBzdzJ2?=
 =?utf-8?B?cWhBY1ZtWUdQQzJWYzV6ZUMrYlJMS0tBUkx6S3M0dGVId0lkaU45WWVjS3hW?=
 =?utf-8?B?TkU4N0xSQVJqTlZsaWw3bndPaW9RNUdkaDE5UVh5ZXJjZGJzMUdGaTAwY013?=
 =?utf-8?B?S1ArY2NHTXlKdmtVaU5YTzZtZGgxM1VLREhHWmRGS2xXZ2xIU3lLbHpadS9s?=
 =?utf-8?B?bkJJdWtZcEhxdStVZGhyS3F6c2ExMGVZdnI3Y3FLcWZENy9FQ3A3QnpBV2hB?=
 =?utf-8?B?K0ZWSWprSWRjUE5rTnExUHJWTkF4T3hCOUdmck8wUTdmelZtcW0wQ2tONVF4?=
 =?utf-8?Q?wmJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c0150-9d53-40f4-5e21-08de156bccc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 15:16:27.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeacuP03wUNaNmat03yzjGrGM/ctmRFgMY+2+qeJ4K2jwt7jD1r1XBAJNqH//25hyJ1K1Ekokj76+UIXx18yRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12

DQo+IEZyb206IEJ1aSBRdWFuZyBNaW5oIDxtaW5ocXVhbmdidWk5OUBnbWFpbC5jb20+DQo+IFNl
bnQ6IDI3IE9jdG9iZXIgMjAyNSAwODozNiBQTQ0KDQpbLi5dDQo+ID4+DQo+ID4+IFRoZSBjaGVj
ayBpcyBhbHJlYWR5IHRoZXJlIGJlZm9yZSB0aGlzIGNvbW1pdCwgYnV0IGl0IGlzIG5vdCBjb3Jy
ZWN0DQo+ID4+IHNpbmNlIHRoZSBjaGFuZ2VzIGluIGNvbW1pdCA0OTU5YWViYmE4YzAgKCJ2aXJ0
aW8tbmV0OiB1c2UgbXR1IHNpemUNCj4gPj4gYXMgYnVmZmVyIGxlbmd0aCBmb3IgYmlnIHBhY2tl
dHMiKS4gU28gdGhpcyBwYXRjaCBmaXhlcyB0aGUgY2hlY2sNCj4gPj4gY29ycmVzcG9uZGluZyB0
byB0aGUgbmV3IGNoYW5nZS4gSSB0aGluayB0aGlzIGlzIGEgdmFsaWQgdXNlIG9mIEZpeGVzIHRh
Zy4NCj4gPiBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiA+IElmIHlvdSBkb27igJl0IGhhdmUg
dGhlIGJyb2tlbiBkZXZpY2UsIHdoYXQgcGFydCBpZiB3cm9uZyBpbiB0aGUgcGF0Y2ggd2hpY2gN
Cj4gbmVlZHMgZml4ZXMgdGFnPw0KPiANCj4gVGhlIGhvc3QgY2FuIGxvYWQgdGhlIG93biB2aG9z
dF9uZXQgZHJpdmVyIGFuZCBzZW5kcyB0aGUgaW5jb3JyZWN0IGxlbmd0aC4NCj4gSU1ITywgaXQn
cyBnb29kIHRvIHNhbml0eSBjaGVjayB0aGUgcmVjZWl2ZWQgaW5wdXQuDQo+IA0KPiBUaGUgY2hl
Y2sNCj4gDQo+ICDCoCDCoCBpZiAodW5saWtlbHkobGVuID4gTUFYX1NLQl9GUkFHUyAqIFBBR0Vf
U0laRSkpDQo+ICDCoCDCoCDCoCDCoCBnb3RvIGVycjsNCj4gDQo+IGlzIHdyb25nIGJlY2F1c2Ug
dGhlIGFsbG9jYXRlZCBidWZmZXIgaXMgKHZpLT5iaWdfcGFja2V0c19udW1fc2tiZnJhZ3MgKw0K
PiAxKSAqIFBBR0VfU0laRSBub3QgTUFYX1NLQl9GUkFHUyAqIFBBR0VfU0laRSBhbnltb3JlLg0K
PiB2aS0+YmlnX3BhY2tldHNfbnVtX3NrYmZyYWdzIGRlcGVuZHMgb24gdGhlIG5lZ290aWF0ZWQg
bXR1IGJldHdlZW4gaG9zdA0KPiBhbmQgZ3Vlc3Qgd2hlbiBndWVzdF9nc28gaXMgb2ZmIGFzIGlu
IGZ1bmN0aW9uIHZpcnRuZXRfc2V0X2JpZ19wYWNrZXRzLg0KPiANCj4gVGhhbmtzLA0KPiBRdWFu
ZyBNaW5oLg0KDQpHb3QgaXQuIFllcywgbGlzdGVkIGNvbW1pdCBtaXNzZWQgdG8gY29uc2lkZXIg
bGVuZ3RoIGNoZWNrIGhlcmUgYmFzZWQgb24gdGhlIG10dS4NClRoYW5rcy4NCg==


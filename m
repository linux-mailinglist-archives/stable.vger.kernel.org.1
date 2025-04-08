Return-Path: <stable+bounces-128932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAFFA7FD1B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18604236ED
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907CB267F67;
	Tue,  8 Apr 2025 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IuB8RL/i"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25D22B8CE;
	Tue,  8 Apr 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109217; cv=fail; b=q8uE17sGKbFrxDw0oZHyKGLMS1aBcGcYnchRwnMz5+PMG4ddxZZKxUcgKjBHXbhH0pZ40rlttGHtnJPTFpMULWLN0vDnp70mbO8FSqrK1BnGnqh3k2SGvgWVdL5gs08q9JwLJSppIMSg+ESYrqRAgxwqm0eJ0bMX9kn5sqyx7bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109217; c=relaxed/simple;
	bh=XK15lSS/MQyTJulfshl+Q9e5Zl6PqUK9CeDyafHGJH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPmaKc7FcoK0wQUIsb/T8dDF2qgLgk42qH/MdUh9eoY6Sir77kCeEDQSdyqDzoE9SATPJ6j8DIYR1O2pKMzmB6/TMpJ3fjTGCWbe/2PnD+WKmmdoBo1CzgqTdYflmryeEjxGrKCoc4WORzwCrzUK1o42JIUa30BwEcAjmqD9PRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IuB8RL/i; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTNOENDIQnnA5ChdmBlQkDJxRjQ8xw4ZMsrvSy+HMwrb+DXm/JCxQJ1ITC0a6hHa+E7vZjLc5GMDardViG3xd8YVOwvqH2Uv+KcgtKcmM4+jfFznuKDxfsxih2e+2knpPi7vQoab+yQ9WaUG/1Iy31nIgHPFNR/QeIz2DDIC8qeEzQEr6JCIgA142zIOMPGedihxaAN+kYo/4T2PCrA8Ea5R+flnogljXp9aEDEfDbCDcmHUsSFSKqY5DoSO/zXfYw5x6S0BuZYc1PlWHrIpKy/zTG0TEmezDsUc5WojUrcPVvK12v3RKTlODs0YqlkLjpsq3SJWjUiKoP+25sjuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgMY0tmuJRZiOasFYIQ+FT/0mkt8dW8ZCPpPfk1ch+k=;
 b=Hqz7Oosmem2Aad5rr63bNDMUxjlcNkjWkyljOibAWcoZkK/6c3+MT8D5LLDmwo+yUb8cyRkBBA8DRnObo2wmDDUE0u2h5ObZ+KXO7WkNS/f8Ov1wXPwkD0t6bcP27c84DjDk+jEU4fupbyC42AmPJRBIe7TbukS7OCDHAGs3DnTct7Jnv+4gZiSTLU+HgVv7Wmg/lnv2Tbhv0S4E408ux1fJeQ2/DGYuL+0LxBixjGhF9ELjL30Z6MD3U7EYenSnGlYQnl6NnY9QvVyWfiyUWuWSdCh8yCLpRK60o43jJKFwweZUvqSkvtqkwDtxRX/qZhwoT23rSPgtSOyuU0jaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgMY0tmuJRZiOasFYIQ+FT/0mkt8dW8ZCPpPfk1ch+k=;
 b=IuB8RL/ijiZdBdp7dzFbx2VZUQ98oR6YVFMIeO6BJ7c2aj4QcaL+uyZgq9N9rFoT9DyDBMCAO8Rcks4pIbSjFa5sJWrmJloGTXcYjvgu3IhlgXXoRIs5EuSyr0SmIS/phbk2Bsq8cxlT3Knvd9ksr0mrroyFAWP7iMIizNVf4VVx/mY7+z7HgFxPqJz+paaSkExt6qD+qCsApooNmuRk4g/CAf+P0Es8g1LGCIVuJfXOZu1KUI2orl1tR6x31pIr0UBHgA73Yfd3qHsIglCXUPxyR7aHdgp4O2/Ota2gVFkJCARaMBJaImH5gG8PiqCmRBCODNtDT3+hEw2v2kwDTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:46:50 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 10:46:50 +0000
Message-ID: <be4980f1-ebec-4c69-a3f1-291d3ae08249@nvidia.com>
Date: Tue, 8 Apr 2025 11:46:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/1] phy: tegra: xusb: Use a bitmask for UTMI pad power
 state tracking
To: Wayne Chang <waynec@nvidia.com>, thierry.reding@gmail.com,
 jckuo@nvidia.com, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250408030905.990474-1-waynec@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250408030905.990474-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: b45d003c-8316-4afe-780c-08dd768aaaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGdYdm9SV1dReVdCS0NVRFhnY3p3dFk3bnQ4MC9RMlBYelMrQmt3OUhweitX?=
 =?utf-8?B?c0VHSFpTY0xPaHN0MDUycXJxYm5uYjJrNzB0TDY3UXhYc1VvcXJBeFhESUk0?=
 =?utf-8?B?UXVySTFRQVY1M1g3bFViQkpKa1ZFT3FiK29KNVZqek5vSnRxenFobUdYM3Bp?=
 =?utf-8?B?MzRBVTZHMzFjRjk4czhaRUNKanlqRDcvcGNuYWIyaDFoVVpEQ2ozSFJnd1Np?=
 =?utf-8?B?UWx5RlNGMGlsR1JUVTUzdk1YRWtPT3JWOW10UnRNdWhNekJGdXIvOUVBMnhi?=
 =?utf-8?B?MzlUeEtjVklrZUFBbEl2cUJLLy95UWUyME9MRjNZTmVndjFVUlBSQm11ZVRo?=
 =?utf-8?B?eXNCMnRCdEREcVlnTElLNzhrS1FtVjZEcnk2b096a3lJOXUvL29UUTg2T0dy?=
 =?utf-8?B?OGp4eUlpMng0cHY3QzlobGx1VU1mTnRCeVZDdERvZ2J6WjNKbHhtNkNkMWhW?=
 =?utf-8?B?MVc4UFlSd0h4UjNZWkllMDc2VU03OWYwSUtjNUtTQ0lEc2xCNFA3QmdnVFhI?=
 =?utf-8?B?VnlxMEhxVXAyWDhOV0d1REZySGlNdTEzVFJGNno1ZmtNU2ZsRmwxV0NXaUlM?=
 =?utf-8?B?L3FwUGJuOWlwRytua2xGaUdGWDFoMTI1OWoyNS9YMnNlcU16Z2ViaE1TbEFp?=
 =?utf-8?B?NW82dU5HdXdZNkI5M29MRUpBQVRLV0oyR2JCb2xKVWFlV3BlUW5zNllEd3lr?=
 =?utf-8?B?UDFHanJsbUZpOGZ3THlqQSthMVlPL3BYM3doZ1ZxTHkya0NOaG9Eblc3cTgz?=
 =?utf-8?B?WWM5aUpkcTJHZlFEaU9wQml4K3ZPVnJQY3J0T05KekUvUWpDYnZSdkNFNkg1?=
 =?utf-8?B?SXI0ZGJCaXhTMTNxZmpxYVNGa2Y5cU5zV2lnUFVrY0VGNHQzaVoyNW9iNXNR?=
 =?utf-8?B?RGtFL3Z0dlFLRGt5RkJXU2labE5ETXpScktNVzE3dGZRNzlyWXYzUnJ6RzY0?=
 =?utf-8?B?dkxJSDZ1N1NFa01SUlFONkMxUzJKOEduMnF0M2NWckpZc1NreWZjdmQwNkJU?=
 =?utf-8?B?dmJNNlc1VW40RWhnakpCanBJWjhGTHhTWFRFWUhBTzVlQWRoKzlSRSs0NlFP?=
 =?utf-8?B?VFZmRmFoNGRzbTQ0RXk4N0tSQm5sa3NlRHhTSC9SenlqZWhPSXRPMzhCZ1Ev?=
 =?utf-8?B?Uy9TVHUvTm94djhIU0hGTmpxM2EvWG5RdWpjQXBYSWljNnRRRzFRS01Kak5W?=
 =?utf-8?B?Q2RSc2tFazFCbWZWSVFSZXVIV3BlY0FlbHYxTHBFK2VmVDZneklxakVscjdF?=
 =?utf-8?B?WFhBWnJVZFgvNFdkSWRMTmV0dTZpTmtMN3JtcmNXVEk2YTNldHFFUy90cnBZ?=
 =?utf-8?B?ZzZGa2JhLytMeXZTcmZvTGFueHZSTGdNbDhSVC9BdUsrZmNGQUljQTBwbGlU?=
 =?utf-8?B?T2xNVGJQaldPeVk2UjkxamdNaFM0RElhMDhzZzUxZHY4Q2xVaWFoUXpyRUNl?=
 =?utf-8?B?WGIxQ1VmQzYrWndlL2VnemJhL2RIWElhcVJiYnc0T0MzaXZUWkkzbXJiK0xR?=
 =?utf-8?B?dFVyMHA4UWRQRTR3V0Z4SWhVdU5qWFhiOFNyRDJOQVRhVzZMTk1nR3pDVnQy?=
 =?utf-8?B?ZUFZeXBlWmg2YkJhS1RBb3dOdTdxVmVLRjBhTllJekRPR01yVURDLytyeklZ?=
 =?utf-8?B?U0loRWpCWm9BNGg4ZWUxRXNSWjhJclUzRW5uTmd1VFc4U01NbDEvT3JHSDJs?=
 =?utf-8?B?OE9xbHpOdk5NdWtFZnhidzFtaWQ1aW0zYmVqQ0U4SnJUVzlka2xpR0lKTTAv?=
 =?utf-8?B?MFhYYU1oVFNNTWdOSXlvL0hCWUZsMEQydEt1ZWVJRGZES004RU9ETzRDK3ZK?=
 =?utf-8?B?bU9ENG9FSnpwanByZjRuS05CYmpUZjBreXUyRnBWMHU1ZEhaZDVLUTBOWXNN?=
 =?utf-8?Q?7mEF4D2Ut7vY2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFB2bGQydE5rcXIrMlg0eWg2eWZUUnlLQytHZjhkYnljYzNodWxISExja0VN?=
 =?utf-8?B?bDh6OHpvYmIwdDA5MEFJY2Q3YjFTOHRqYnlrWVNvNGJ5OC9PVUhydlZ6K0VQ?=
 =?utf-8?B?T3YzU0V5REZrM1RGTGZkaVZtRG4wMXY2UUlUYWhDSURoekEwTU51dm9xdVo0?=
 =?utf-8?B?S2VtdFlqRFhLVm9ORmpzTHZqeWlkVlRPejhJZFQwVUtPTkZyOENWOFc2OUxJ?=
 =?utf-8?B?NHB1TXpjMDRJaUZkNnd1ZmtjdzByd1NqaS91YU1WYi9YYkxtaGZLaDJ3cDR4?=
 =?utf-8?B?WUJCUklrNCsxUDVJTkkrSUpleGoyZ1dIaGhwK3k2Zm9rV05nV1B4ZFNZV1h6?=
 =?utf-8?B?TS9uYUJ3KythWVgrNHlJUndTZnFwMnpoOWx0a0Y5dnNOMzJIK2crOWtQUzFL?=
 =?utf-8?B?T1pSY1BzUVYvMU00S3lsTWYvdzJ3eEFKZ044WE1YYXZsamgrZDZad3hTRWdr?=
 =?utf-8?B?cko2cDEzbU9WZCtyZ1RtSlRkY0RPYVU3UEprajA2L1FtNlFTYjROclh1OVBL?=
 =?utf-8?B?WHJuYjV2N3Z2VE1VNzMwU2dRWStheDR1TGpmSXg1Vlg3MzdRdW1ZUGxhUTlJ?=
 =?utf-8?B?SGVlbWFSNWQwdHlyeGQ4dTlpYzAwMHFpUXhOSnhZR1p6RlNCcTlrbmt3TzdI?=
 =?utf-8?B?M3pzYWpWWnNUTEpXcTN5RFU2bzBDSkpBWXRIMEtzYWpCdUdpeHNoYlgvUkhZ?=
 =?utf-8?B?ZnRlaDJVbGQ5ZXBvalBuVDVhWWNxcmNZSlQ4ODBwK2tidmgrMjFpdDZiZk5W?=
 =?utf-8?B?dFpLS3cwYm1ldFBFeCsyWHpLUTh1OVF5Qzh1Nm13MnV1TEtab2k2aHBrNXhT?=
 =?utf-8?B?VE1HNE9KRUhlYzR6czJhQWQzZ2JnZWFuQlhZdkVKcE5QZjNxYWFpY3VKTkhS?=
 =?utf-8?B?VFJWWUI1RW8rL1pyZzNzRTFUVng3T3ZOTktwK0gxaElFaklJa0Jjbk9XelUx?=
 =?utf-8?B?OW5WK2RWbTBieE9TQXVRb2tzRkQrSFRXQjlCeEdxYjliSnpndWhSc3dER2hp?=
 =?utf-8?B?YlBwTVl0OWMrVG1ia2UrTitlUm13bEdTc1FTMURFSHhvNXBmV0Nwc3JkTy9r?=
 =?utf-8?B?YStIcFVod0sweldwalhVNVIyWW5TVEQyWk8zd2dzcDd0d1ozeDhJODhiSTNV?=
 =?utf-8?B?eTRsSnZLdXlLUi9DcnBFZEhJbnI0ODVFbmYzRVpJMGZ2dTFuOFJFSG5xRjQ4?=
 =?utf-8?B?REF3VTFGWXFhYzZ1SVA5M3RiR0xnQXBabTdmUlZxNnZLT2VtNlJESHVERENr?=
 =?utf-8?B?L1FraGFaS25UeFR3UDN4NjQvS0d6UjdJblRDakVqcGRCRGdiUUxjRFpMU3g1?=
 =?utf-8?B?d1RoQ0t3M2c5UUNJR1E0aGc3bWhXSE1Xb0VHbWNUQ3NYME9PaXZGYkxXeDZ2?=
 =?utf-8?B?OGx3RlZuTTZKOFdmT0VVbHVaWHRpNUtMR1kvUnpyYTNHcEFVT1FqZHB1V0tI?=
 =?utf-8?B?Q2Fkbmhkc2plbFE2THhiTmJJTkJWYWF1OXlTS2hBRE5mcGk3RmpjSlZOQ1pl?=
 =?utf-8?B?aU03aElTZ281S2J2d0JRSWtSa2pjNXFzQmlpNzBCU0lSRStCVEw5VjFrb0U0?=
 =?utf-8?B?cUVwV21KaTdDZFhqMmhuTGRRNnU2SDkvRFhGdXpyRitsSEZXclQzN1pXNEQz?=
 =?utf-8?B?Yzlaa0kramQ4OW5HTkd0NGNmYnNYYnRjRjlrcmdsc05PbUZtRU9HNWFsUUIr?=
 =?utf-8?B?UTl6QlkrcmFkelNVU1h5VkdWYlJlUmU1R3g2a2twR0hTN3lWenNKQXJGN2hU?=
 =?utf-8?B?dTlCVys1Q1VaUXREbjBNanlNUjhmN1g1aGVQK3VDM2pHeDh0L3dVS0d4b1g1?=
 =?utf-8?B?c1hQbVFJdHAxNWIxNWJnREtCWjk4Q214VWVkYm9BTkF4aDFySXJzZTZ1aUQr?=
 =?utf-8?B?RUdCWHZ4bGxKUkNhaElzQy9rVnlOVytJVE9XUFNzYThxVytxVkhlUk12T3F2?=
 =?utf-8?B?bmR5M3ZzNXFMUHE4MG5wZUhVWnNZYm9sM3ppbzhPdVBVcTYyRS94ZVZ0bWxF?=
 =?utf-8?B?MHE0U1A3TkpPS3NYRXNlbUwyVkl6eEZiMXdqcmp1SjI4ZmkrSjRlSTFMdDlT?=
 =?utf-8?B?ZWVwTmx5MHNKTDFzcmVmUlFNcVFOaDZXZWxYNGdmc09ZOVNHSTlNOXRzS2Z2?=
 =?utf-8?B?bS9saFVUZVl2WEpwNitxbHVDVm5WR2FXcEk5cUl5eTZxRGJCdUxzcElLZWhQ?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d003c-8316-4afe-780c-08dd768aaaf7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:46:50.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHblQflFgLnikO+uAepF5S0BHvukbV5uqKE8x2eAAur1VytU8e94gkZXc1tcfEi0j3J9yTIjL8Hv48ApZM9hXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786


On 08/04/2025 04:09, Wayne Chang wrote:
> The current implementation uses bias_pad_enable as a reference count to
> manage the shared bias pad for all UTMI PHYs. However, during system
> suspension with connected USB devices, multiple power-down requests for
> the UTMI pad result in a mismatch in the reference count, which in turn
> produces warnings such as:
> 
> [  237.762967] WARNING: CPU: 10 PID: 1618 at tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763103] Call trace:
> [  237.763104]  tegra186_utmi_pad_power_down+0x160/0x170
> [  237.763107]  tegra186_utmi_phy_power_off+0x10/0x30
> [  237.763110]  phy_power_off+0x48/0x100
> [  237.763113]  tegra_xusb_enter_elpg+0x204/0x500
> [  237.763119]  tegra_xusb_suspend+0x48/0x140
> [  237.763122]  platform_pm_suspend+0x2c/0xb0
> [  237.763125]  dpm_run_callback.isra.0+0x20/0xa0
> [  237.763127]  __device_suspend+0x118/0x330
> [  237.763129]  dpm_suspend+0x10c/0x1f0
> [  237.763130]  dpm_suspend_start+0x88/0xb0
> [  237.763132]  suspend_devices_and_enter+0x120/0x500
> [  237.763135]  pm_suspend+0x1ec/0x270
> 
> The root cause was traced back to the dynamic power-down changes
> introduced in commit a30951d31b25 ("xhci: tegra: USB2 pad power controls"),
> where the UTMI pad was being powered down without verifying its current
> state. This unbalanced behavior led to discrepancies in the reference
> count.
> 
> To rectify this issue, this patch replaces the single reference counter
> with a bitmask, renamed to utmi_pad_enabled. Each bit in the mask
> corresponds to one of the four USB2 PHYs, allowing us to track each pad's
> enablement status individually.
> 
> With this change:
>    - The bias pad is powered on only when the mask is clear.
>    - Each UTMI pad is powered on or down based on its corresponding bit
>      in the mask, preventing redundant operations.
>    - The overall power state of the shared bias pad is maintained
>      correctly during suspend/resume cycles.
> 
> The mutex used to prevent race conditions during UTMI pad enable/disable
> operations has been moved from the tegra186_utmi_bias_pad_power_on/off
> functions to the parent functions tegra186_utmi_pad_power_on/down. This
> change ensures that there are no race conditions when updating the bitmask.
> 
> Cc: stable@vger.kernel.org
> Fixes: a30951d31b25 ("xhci: tegra: USB2 pad power controls")
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> V1 -> V2: holding the padctl->lock to protect shared bitmask
> V2 -> V3: updating the commit message with the mutex changes
>   drivers/phy/tegra/xusb-tegra186.c | 44 +++++++++++++++++++------------
>   1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index fae6242aa730..cc7b8a6a999f 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -237,6 +237,8 @@
>   #define   DATA0_VAL_PD				BIT(1)
>   #define   USE_XUSB_AO				BIT(4)
>   
> +#define TEGRA_UTMI_PAD_MAX 4
> +
>   #define TEGRA186_LANE(_name, _offset, _shift, _mask, _type)		\
>   	{								\
>   		.name = _name,						\
> @@ -269,7 +271,7 @@ struct tegra186_xusb_padctl {
>   
>   	/* UTMI bias and tracking */
>   	struct clk *usb2_trk_clk;
> -	unsigned int bias_pad_enable;
> +	DECLARE_BITMAP(utmi_pad_enabled, TEGRA_UTMI_PAD_MAX);
>   
>   	/* padctl context */
>   	struct tegra186_xusb_padctl_context context;
> @@ -603,12 +605,8 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
>   	u32 value;
>   	int err;
>   
> -	mutex_lock(&padctl->lock);
> -
> -	if (priv->bias_pad_enable++ > 0) {
> -		mutex_unlock(&padctl->lock);
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
>   		return;
> -	}
>   
>   	err = clk_prepare_enable(priv->usb2_trk_clk);
>   	if (err < 0)
> @@ -667,17 +665,8 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>   	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	u32 value;
>   
> -	mutex_lock(&padctl->lock);
> -
> -	if (WARN_ON(priv->bias_pad_enable == 0)) {
> -		mutex_unlock(&padctl->lock);
> -		return;
> -	}
> -
> -	if (--priv->bias_pad_enable > 0) {
> -		mutex_unlock(&padctl->lock);
> +	if (!bitmap_empty(priv->utmi_pad_enabled, TEGRA_UTMI_PAD_MAX))
>   		return;
> -	}
>   
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
>   	value |= USB2_PD_TRK;
> @@ -690,13 +679,13 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
>   		clk_disable_unprepare(priv->usb2_trk_clk);
>   	}
>   
> -	mutex_unlock(&padctl->lock);
>   }
>   
>   static void tegra186_utmi_pad_power_on(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	struct tegra_xusb_usb2_port *port;
>   	struct device *dev = padctl->dev;
>   	unsigned int index = lane->index;
> @@ -705,9 +694,16 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	if (!phy)
>   		return;
>   
> +	mutex_lock(&padctl->lock);
> +	if (test_bit(index, priv->utmi_pad_enabled)) {
> +		mutex_unlock(&padctl->lock);
> +		return;
> +	}
> +
>   	port = tegra_xusb_find_usb2_port(padctl, index);
>   	if (!port) {
>   		dev_err(dev, "no port found for USB2 lane %u\n", index);
> +		mutex_unlock(&padctl->lock);
>   		return;
>   	}
>   
> @@ -724,18 +720,28 @@ static void tegra186_utmi_pad_power_on(struct phy *phy)
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>   	value &= ~USB2_OTG_PD_DR;
>   	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
> +
> +	set_bit(index, priv->utmi_pad_enabled);
> +	mutex_unlock(&padctl->lock);
>   }
>   
>   static void tegra186_utmi_pad_power_down(struct phy *phy)
>   {
>   	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>   	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
> +	struct tegra186_xusb_padctl *priv = to_tegra186_xusb_padctl(padctl);
>   	unsigned int index = lane->index;
>   	u32 value;
>   
>   	if (!phy)
>   		return;
>   
> +	mutex_lock(&padctl->lock);
> +	if (!test_bit(index, priv->utmi_pad_enabled)) {
> +		mutex_unlock(&padctl->lock);
> +		return;
> +	}
> +
>   	dev_dbg(padctl->dev, "power down UTMI pad %u\n", index);
>   
>   	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> @@ -748,7 +754,11 @@ static void tegra186_utmi_pad_power_down(struct phy *phy)
>   
>   	udelay(2);
>   
> +	clear_bit(index, priv->utmi_pad_enabled);
> +
>   	tegra186_utmi_bias_pad_power_off(padctl);
> +
> +	mutex_unlock(&padctl->lock);
>   }
>   
>   static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers!
Jon

-- 
nvpublic



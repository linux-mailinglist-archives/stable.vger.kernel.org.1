Return-Path: <stable+bounces-76173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5943979ADE
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E2F1F21C2C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A5239AD6;
	Mon, 16 Sep 2024 05:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sbTjPAFA"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699C6FDC;
	Mon, 16 Sep 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726466178; cv=fail; b=pRwGv2pixckdt5HbAPj6JajFH5LOZjWq/GjUHROIvmZfuxmj/yAdXvOzN5iZkCvF7hf8t8mjoyOaN4VGC4ojXkFBLh4rpT89QOLIp3yb1Bc67ihIbpyLjbut9wxxIdu8G3uV0L/xxYDqUxoI96pgWgZJEBtdDgsPFinefxmApeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726466178; c=relaxed/simple;
	bh=hgnRVeJnoUOZQ7tAVx7O8BPg+jzyl4VbQ43HFWt+xCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oIZCYi6GZ9PS5s7iXcssDcDfr9PRPAAoBrTdxzfjXrpoYQtKvsNrLK4qyXunyznv3LEogQBvLF7C4r/Nq0Nw59nSI7g+iQ2HAvb9PkUd3Y94KG0KxOkucVLrKJJgJP0bCE5Gukzg+SDJWFHaFVPLX5yoHLHs/s3FIiKhOKIFyMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sbTjPAFA; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbPL2fCnCR/jugjG63Ryar8UAVomN9KZH+85GEFVtPhN9hCXcsS/q/k+aeKp5fT614Wfmd/tTwEAOAo0wuJksBLKv4407HFH5sdPMx2Si/tBQjDyYd2PXNpfgNVh+772uRe4npPiS1s4mXqLgHPU48uUD/zkahvdBwoemZGbEViFmT033MPwCb0JHD0idIF7CEQifnhRhdn1CH+7KbbfDCI9t5W8lbtOHxQFfNDvPuYyctJVUpnNq+hcIb6myKLDnQNeRB53uNEiNZs3JfCnsjqN7BjEINb6+Bygz2Pki6w/g73bA/KvmVLZ9D4T1RDx8C8qYjTDraLDvQ6M/jRxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IW4lMszDgJcuhLs2F6hkZ43KtPPR3lDAfbPgVEUXzg=;
 b=Zy8NIclfxEZjBls5zKg7LixacptOrXtl2+sRf7aKA2Vgv34iUfjnzLr4YheiSXGg02MeM72db3wgTbppB2mZkNAeUYYXT8ljD0jfQLvnZyqmx4gW6hI3P5Dd9r899e5WitWVQ549JGldcN+ajwkizplMSNbpbqJaTtMbgDTqwTgdkyMH0lHDVRkuwH26Y+Tw/SnQpvRR1sqYp9dnSelN2woAk34jP6Nqj7osVX1IyyzTfkp17LRL5Td0oxnUh84SGC+vT5AAUi025iQM3jMtSPiRPjFCbFsMjqSl2HfZ6nQhkwHChWPkrioI0NQxXiGjOe5S6vRfvRsc0TF4l2TNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IW4lMszDgJcuhLs2F6hkZ43KtPPR3lDAfbPgVEUXzg=;
 b=sbTjPAFAdpuPT//fjIxOvOnHlzEVnnTiTey+pA23i4lflhgpeQoxyF0U4HCgVezh1IvsWVUsF8yX9bzImhzKczbH1QOOCBYngu2bdmkNBboPKD1ZKNvS5VwhjRwqhk8oAlKesLt5SvncZ3fNv9ccK9ERI9uvb3ksbW5v1uq/nFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Mon, 16 Sep
 2024 05:56:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 05:56:14 +0000
Message-ID: <6e832247-f6b6-49a2-a76a-17467c3243a5@amd.com>
Date: Mon, 16 Sep 2024 07:55:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: serial: rs485: Fix rs485-rts-delay
 property
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, stable@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>
References: <1b60e457c2f1bfa2284291ad58af02c982936ac8.1726224922.git.michal.simek@amd.com>
 <20240913-sulk-threaten-79448edf988a@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240913-sulk-threaten-79448edf988a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: a54481f2-d0f8-453a-454e-08dcd6144628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHhmb0ZGeHRwNnhGa2t2R0tXREMyRXozSHBSRTlCOHc4dEo3Q0dNK3RaNERW?=
 =?utf-8?B?WmR1N0puSUNHOGIxKyt6SldzbGRsMXNWWDh3N0tCL3hmSEFpeDkyTlhBeCtT?=
 =?utf-8?B?ZjlJczlsSXh0bHBjNkM4YldyZDlwSHd0dDRjMThEUW5mK0pCL3dXM3lUc1NP?=
 =?utf-8?B?TGpGYjZjMkNFeGluVk1SZW9DcEYyZGJMYXVwbS9BVWdMbFNqcFpRWnJiTTQy?=
 =?utf-8?B?akpNZkZZUlA5RDRRc0VQTDlUVkFOTktxZWVDczRwNVd5eDg2VE9VTWovQmc5?=
 =?utf-8?B?UWI0M0tKdVZ6TnlJVjd5cDVmT2JPY3RVNDhrYU5WR0FERUw3THJQTDhsMU5i?=
 =?utf-8?B?d2lMb2JiT3JvaUdkQktiVkdjWStSNVlONExiMm1vZEk4WFd6VzU2YStBRWFi?=
 =?utf-8?B?WXYxbHgxRlNRTjYwZGFWV2hZd09zTUZFdVFBOEZJN0U0M3BKRS93aUtRMzFH?=
 =?utf-8?B?cElkYXNjb2lySStEakJPSTlnZnNFM2xNQy9admd1dUNFV2VjS1hmSGk3VXJT?=
 =?utf-8?B?Y2F3TFVHU3BOdnVVNG1EQkd0clJHMHRwamJ3a0tZRVNnQktyamc3RzVmQzV3?=
 =?utf-8?B?eExoNDBvNW5WSm9TVy9vT3dmcENUbkhXcnl2eldQVkRSY1YvWDBvbjQvZ0RT?=
 =?utf-8?B?K0RsTllZa0xDenIrTHZ4bjFpZmVNR282MzhKM2NWWXNTdGxZL2UwM3pPblVa?=
 =?utf-8?B?VEhOdmcxeFJHSFdaTnNnL2FrUDNYOStLT1k4SmEyWk02a3JiNzNsYzh2QXVj?=
 =?utf-8?B?bnV3TEY3RzJnSVRlMW1yL2hFaWd0SU1reGdPY1EwT2ZrTUxGeEQzSkliOGIy?=
 =?utf-8?B?dFJjQmVVdUFKTXJPSlJNbWJzcTMwTHlDb2hQTndpbnZBUm9HWXpKQ1FaR1lu?=
 =?utf-8?B?Zlo1cTZrcWtYSmJYQW5vdXlDV3hJT3E3UVR4SW11bnBFZkZSeVhZdnFrQlg4?=
 =?utf-8?B?bmwxRWtsdkNnNDJaWC9qSkNEMk96Vm1IVTkyWXd2bGF1QlFvQU10ck52Y2Qy?=
 =?utf-8?B?KzFhQ3NWRllWZy9tb3B4Q3NuKy9CejNyeHJ5TFBkOVBlV3NxZDdaZHJlZy8r?=
 =?utf-8?B?NjZzc0VjR1dSaFVMakxwVnBuRm1iRTJadVVxQXV5VytrZlpUWUFEYVB3blpH?=
 =?utf-8?B?NVMxS0gyTERtR2NManY0bW9SQkQwUGNvc1FBc215R3l6OGlXeFdrYndQYkow?=
 =?utf-8?B?ZmJBeGw1NTZqZi9CVzMxalV2bkx0RUlOSjRjYVQxSCt3Y2owVFJuVEZ1Ykc5?=
 =?utf-8?B?MENMUUlNWUI1R1NtYkthd2tqRi9RRllQV0Y1NFIyc3pmb1dGeXNibWZqc0d5?=
 =?utf-8?B?QjhyNTJ5VlNNYjhuUFhsL2VGY0RremNUaThNK3haYVZvSTZFQy9STWdieEd6?=
 =?utf-8?B?blArSk5EVG00aHZTb2s4c0FjM1RaMjFwK3RyK2VPVGFFdiswWjd5MThIb3VH?=
 =?utf-8?B?L3J5WVVjWUU2T3d6NjJDV2ZZamxDeDRKYW1vclpzMDZlUDczaldncldldU9W?=
 =?utf-8?B?SnQ3K1VMeWZlaklQWFlvRTdtZGp1MURMcEpMN0RiWUhuaFV3Ry80bmoxQzVF?=
 =?utf-8?B?T3E5b2xHZVNPMEIyQ0xPejQ1SldsVHg5eTVlNHQ3cVJsaDhsTFplUit5VVRm?=
 =?utf-8?B?NitRMGJ1cnNZM0RYcitwcXVOR2dHUmJrOWVwNTRCR3VxOHd1WFJCKzhiMEsx?=
 =?utf-8?B?V1puYWlod3RYelhycitPM1YzWE5Pa21LY2h6azI5WHduVEwvdTAxOXZpaDFK?=
 =?utf-8?B?VFlDZ2E2cUVCYnp4aStYZmtxWTkyMmE5VUxWUHp1dk9BemNHUXpRQXkzeFRX?=
 =?utf-8?B?MW9GekpKWTE1WGRtWFFLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0dhOGpoRHIzTTFGbUpCQ3IvMll0VWJIMHlQTjg2RlBseWRTeGF1RkJBT3o1?=
 =?utf-8?B?SzE1dWw5S0p0eVpjVUJSWnd3NG5GSWZONlA2QVdKc05Id3ZWYlpmdXA5cnJL?=
 =?utf-8?B?REF5eWdUcEJZSGdac0VkZXdOeUtaQ1h4akhxSjh4YkxTd2tWM3liYmFUdnVY?=
 =?utf-8?B?czRDTnAvTTE1WlZheGUxSXBWNUpoOUNxL1RsWWpsYkxNeXRTN3NWUDlMQmpu?=
 =?utf-8?B?WmJ0bnBtN0diTHA5dkV4S09HVXJkMHYwemlwcDREL3lFY283N2d6MW85TVVp?=
 =?utf-8?B?ZnVSSlFjeHZYQ2o0M21lRWtQSld4cU5KV3FoYU83Ly9Wam5yUWJSeUdDd1Fa?=
 =?utf-8?B?cStIa1RKa2RpL3BmbkxaemFsbVZ4bmdjZXRQc0FGS1NUblQweHNkWEVvNEx6?=
 =?utf-8?B?VldHSEJwWVRpcGxBRzB5bU41OW5kK1ZKdkNBYmVCbHNsNWIwaE1jUG5kZ1dj?=
 =?utf-8?B?T2FuSll5K2Z4OGxTenZQRUUxQXloRGxxS0dsNm1RMmp4WGxLeWl3MXhWVytU?=
 =?utf-8?B?Y2ZYVDdwcGk5dm5SWHgwUG81MUtKUFQ4N2ZUaDBOT3QvVEtKbVBwSk1LTkts?=
 =?utf-8?B?Z0VraVBOTW9rWExXemdNTjVvUzZoR2MwblFMZlZNVU9kWXBsd2xxandQbjdt?=
 =?utf-8?B?eURCcytBRGQ1VGhyTE1mZm9BTHl3VEFTVURjRVp1dm1pNldnOFh5QnhHbklP?=
 =?utf-8?B?SGtHMjJQblhFMHhWN1FEU082a1BMWnNUaWQ4dmF1aG9MWnF0UXJsSDNIMzZv?=
 =?utf-8?B?N2xrNTFyY2xkdXFITlNlZHNvY2NVSnB6M3ZDK0Vkem1FeGpDejEwcFlPcWNM?=
 =?utf-8?B?VTZRaWhlaW9IQ0pIdk85dWNjUWxmNTFEZHdHMDQ2M0hLNFNybG9QaWgrNUht?=
 =?utf-8?B?K1RUNEN6SjgreUV6VnhNQWt4VXR0bjVjM3Zlc2lqcTU1YlBvSDJZL1B5S0V6?=
 =?utf-8?B?TlRjdCtZY0hsME1ZL1UvZ3kxUmNoQlhBWG15MlJDVTc0Z2puc2tJWUFtbFk2?=
 =?utf-8?B?algyL245bTBhZjY0RTR5NjFQUmFqTnVvTWdCN3dybUdYdENuUDIrZzE5VFZ0?=
 =?utf-8?B?c1ZGZHJubmROVXYwTUNla01uVXkwRGx3eTBOTXd5dzdSTGFUemZLZ3FEWXlv?=
 =?utf-8?B?UlFSSzFXYzhNL01MaVV5Q0FCMWZTUzhTQzdBemh5dEQwS2FKcHdPRWh2RXdk?=
 =?utf-8?B?ZUZBdFFHZ3ZuYXlMVTU3L2VaTDBIRnJVUlk2OGdqRG11UjdKTEpBVTVhVksy?=
 =?utf-8?B?MWh4RkYwVkpnOEVZbzVvZ1hOcHdXNlNYRXgyUjFmeFJKQUxVNk1sRng3OWtr?=
 =?utf-8?B?aHI1Rk9GYTJrRlVkeGJGbkRuT2lZRU93ckFMeWlRMStoejJxdnNNYWVUTXMz?=
 =?utf-8?B?TUcrRFFLcmpycndCR3kycmxDOWFZdENwaDZFS3RPZmY3bTFyOTJPRXBpMDlY?=
 =?utf-8?B?UG9zUXdtTHo4bU51aTNaaUd5VEg2bmdHdWk2SFg5M3lOM2dDQXFodjFSZ0xQ?=
 =?utf-8?B?dFJDdUpOM3dibHhMYWVHWkhYT2NQZzdJTkhzU082UUJxWnU4RXRaZmx1U1hS?=
 =?utf-8?B?ZVFhZTdBb1Bkdm5jUnNWclYvNzQwTFRMTW1sRnQrQnNEeXQ3Ym81M0Y0a3dE?=
 =?utf-8?B?Mlp1YzVpMVV3WnZsRTQwMEtqWTVSU2VsSkduYXBBWHZmQkgySmdSaUJ1aWc0?=
 =?utf-8?B?aGV4TmxFVEl5Sjh2UDluVUxqWnc4c3NKTFplOFlDc2FwKzJJTHFkU0FWMFls?=
 =?utf-8?B?VTNJcnhxK1ZnTEpCVjR0STBzZ09SN2hPY1VabDQ0RkswNTVJekpzSU54VUZI?=
 =?utf-8?B?anNZTDQzQzI4aFJjZWFwbHViS3NUblFyT01UcUtqcE54aGFMbGZXNVRiYk5I?=
 =?utf-8?B?KzMwN0c4YkRqc2d4RUx4U1dvMWtkQk5vc3RKRk1ES2ZWQkJsNTJLZm4vVmEv?=
 =?utf-8?B?T2lqd1QrMkxPb3FTN1JwK05PZm5LdTlSRGhsalVEV091S0FkK0NkVmJYeDkv?=
 =?utf-8?B?eVY5WmRwME9SNm45VGxmVW13cm5EUnJCN0VzclZsc3N6eVN2WlpsQW82WVhY?=
 =?utf-8?B?b3JyNGl6YTdEYXUzUDR4QXJWdjZ0Wmttc1pTOW5pZUtRVkxyTFZ0SXViUXFC?=
 =?utf-8?Q?LkK7myhd/tN+0TlEEUEPuaJzu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54481f2-d0f8-453a-454e-08dcd6144628
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 05:56:14.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZBSDpCKXgwcnSaepyMlyDQGrRUmxIDnXkSd9BQ66Bd4NxXZZGelP51MRlS1GwN8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943



On 9/13/24 19:24, Conor Dooley wrote:
> On Fri, Sep 13, 2024 at 12:55:23PM +0200, Michal Simek wrote:
>> Code expects array only with 2 items which should be checked.
>> But also item checking is not working as it should likely because of
>> incorrect items description.
>>
>> Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>
>> Changes in v2:
>> - Remove maxItems properties which are not needed
>> - Add stable ML to CC
>>
>>   .../devicetree/bindings/serial/rs485.yaml     | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
>> index 9418fd66a8e9..9665de41762e 100644
>> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
>> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
>> @@ -18,16 +18,15 @@ properties:
>>       description: prop-encoded-array <a b>
>>       $ref: /schemas/types.yaml#/definitions/uint32-array
>>       items:
>> -      items:
>> -        - description: Delay between rts signal and beginning of data sent in
>> -            milliseconds. It corresponds to the delay before sending data.
>> -          default: 0
>> -          maximum: 100
>> -        - description: Delay between end of data sent and rts signal in milliseconds.
>> -            It corresponds to the delay after sending data and actual release
>> -            of the line.
>> -          default: 0
>> -          maximum: 100
>> +      - description: Delay between rts signal and beginning of data sent in
>> +          milliseconds. It corresponds to the delay before sending data.
>> +        default: 0
>> +        maximum: 50
> 
> I would expect to see some mention in the commit message as to why the
> maximum has changed from 100 to 50 milliseconds.

grrr. I was playing with setting up different values and check if checking is 
working. That should be still 100. No reason for value change.
Will fix in v3.

M



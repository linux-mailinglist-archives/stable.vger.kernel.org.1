Return-Path: <stable+bounces-142064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDBAAE264
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DD852433C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F941FF601;
	Wed,  7 May 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MqNgCLjG"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441228A413;
	Wed,  7 May 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626324; cv=fail; b=B4mh4M1bRdhLrBnwWvgozfn5GWhqd7df6+9lTO7flIMd9sWyZzFZQENxShHtby5q5KyViz57vm4PWlOZb0LvdlLy8qyOIqrzQPnOvji5eKim56VT/eOOcPmIMM/IEFZUq+XBfa+zHzC5Lr1WrFcBmkt9X0bFpxsAjJHYpQuoBBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626324; c=relaxed/simple;
	bh=HocIH5CQQwLfefFjQ54+Nkmbka7YcMoNKhU5r07r4CQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdLPhrCAytqPx0ttaydXmmu5jhyAhn/MdZBo1nQjicB8/9Hauu3Vl9Y8rtcs1MZvKINp0OqI9bmozW3VNinVc+MnS9DjUpuvf7R0R8YFaoYsZqrQtwXz/QaYmQCiR4WTtH2ukH6z1zc9BSDYT5GsIEJllQiG/sgN5aAFJBz+sAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MqNgCLjG; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u08Fj31PVHOBDSnnU0fZLGrbx04IzNYCihsqm66wQc6DqvSy3vi7bDVDRk47/bW1tlugFoJJtqLCABLCv7kIsuLc2arzEEs5TrxR90eoVnt/oAWmdaZATneK5Y7HJVTnGs3n73t30imw8likxq8KQXrm38COefewm7IS4jLpUsAITe6jxL9eT9ltdwhxXC7iMLXhNmhYbAVEOrkg/cAM0PX4wjkNuQqM+2Pa996Lyzf9ZxlFoTNwJCJvl5HSyK7Z+AE0YYlImdzgztOM56AOuts5IoK2ECB6OkndW9i1Oa4jI5hq21VhlDQTq4GmBOG5+7CeGhqEKvCqrQCyRgAnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5SBRykJrYb/Ax0Ny++v4ufF7QXeidT5G9lAutsv0wM=;
 b=AE14+E+q0iqxXUxfGRGp3YHWQiffejv2c3xZuq+ExRHr0o3KFCYtIZeIHYejJGNKqS8f9eDp4jD8Btc+EykzkxfiYuaoqmNV2g/9yYzfsK1Hu/6v4uqsmzcKzJD2BuN40jDvHuqqK3lG6Sspzf5aBDdH7bk9LZKBQl5fu9wurn00DoHYVr43f7unZvWvUtdZM7Tq/p9O5ePXR2yzlxR6ZXLxDe3wW0af7+zyH69oADf98MGtqrg6F+zJjoftDe25Aodm6n3/f3aH7pvzH73zyN3s5aE/wbNrJre4ndmo+m1ZYgVR7ozrSq0DyzAiNp8qCMTVTsYvPBTpXsOI8gm0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5SBRykJrYb/Ax0Ny++v4ufF7QXeidT5G9lAutsv0wM=;
 b=MqNgCLjGAuawG73KKhF42Y0rBtIIxTrL0zbn/h18HbcqKFUlZXgwn3zkZXJla4coztlZs6Pi3tfPCE4A6MYWE+0Ili5KZgEeWdffmt2kE0pTWXE/9cJiDmd7HaiepdeRXi8vBxwtk1iwGkrs5fuTGHH2ZQ2ZgLxLcbd/ZgsQe48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 13:58:35 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 13:58:35 +0000
Message-ID: <71aecbdd-aa6c-6136-7a5d-c8cdc9cafb30@amd.com>
Date: Wed, 7 May 2025 08:58:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5] x86/sev: Fix making shared pages private during kdump
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250506183529.289549-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250506183529.289549-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:806:121::31) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: b613452e-ed67-465b-1301-08dd8d6f4241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmNlM0p5a1F5N2k2MEdmRjd4Sm5oZmhicWJqOGk1TEo3V0ZwdEx0bnBPd1dk?=
 =?utf-8?B?MDZnZDBDa0VhNHJ5VXBFTzFZYkVrMlZ2UXdGbFJOTTJNRVh3a0cwTlNjRDJm?=
 =?utf-8?B?YmFwQTBEVFF5NDRRMWZTNjh3Y05uMmFhaXhmNmlZZlB1VlNubFhUdzg5SmhL?=
 =?utf-8?B?L2NrWFR0NThuYitXTlU0ak1MYjNMbkFpakFrNWVhcDBmbFZvdHc1TDhZZE5p?=
 =?utf-8?B?QWRUa21jVG5IQVJ0SzNIcHF1T2gwRVhEMmY4Tkk2ZDdKRnBJSTlUNGQ5MW5a?=
 =?utf-8?B?LzlVS3MwbldtQkU3VkIzUmZITGI1b1lEMkxlcUljNldqTFlWbFJoMHBPeDNN?=
 =?utf-8?B?MDgraVNKN0pyN01vY2EydW1NN0t1MmFPTkhnMzhZbW5Ca2lISWVnbTVER1VH?=
 =?utf-8?B?N1ROaUNyMW1sL0dDaEVnTktEZHh2WUgyR1ArRXRIbkFXSENLVmxPajdGc2E4?=
 =?utf-8?B?ZjdtKysrcUZYVVQ2Uk5CeG1jVEZqWks2TExRQnAwUHpwN3N6OXBmWS9YeHhV?=
 =?utf-8?B?TWRrZjZEUWFUV01ORHBXdFVPQ3dEMTZYV280Z1BwdTY2R3h0MjVjZCs3NmIr?=
 =?utf-8?B?Z2ZsZkgvMHY5Ty82SVMyOWNTQngwOGtQWVUzbWY1UGlTNGEvTWpiaVVpeTFw?=
 =?utf-8?B?Y00rNkNQQ05tU0ozNGRQS01NTGIyblVmaFFVWUFES3RvLzh2bzBGck92RGxP?=
 =?utf-8?B?eXJBdTZhRFlQWU1VNDcrZExIUU12V0wyRDZBTmxMUVNoVWdON05KVU9waEVC?=
 =?utf-8?B?dG10VmpXTTNiU2x1aW9lSlNFTVdBdTcrQlMyRUhOREd4bDVEUTF2bXJ0MERG?=
 =?utf-8?B?YjN0Mk0wcDJUQmc2TXltOHdQK3o0ZjBGVXI2SWNuRmtldm9JODVLQ1dpNmp3?=
 =?utf-8?B?aDd3YW1hY2EraTYweC9CWTBVZWFEK2hSZmVGNEJhQmMwYXh6L3dRK2NrTTUr?=
 =?utf-8?B?ajBncVJ1djBaMEJDTXB6cmFjMmMrYWxGQXlnbWJPemJNcFREMWU0YXBhcjh3?=
 =?utf-8?B?aEhjQkFZcEdLcUxFaHRCZUhWQ0djcTVOcG13WHlhajVvcnFxUkFFUVpzMTNT?=
 =?utf-8?B?d1JlSld0LzNqYktXNWNCWFNNa0JoSGRWZVVhWjBJYis5MGNjakJsVEtKc2hX?=
 =?utf-8?B?Q2d1eHI4Z3RQUUEzSmpaSUV6d0JoVVM1TktsRmZSZFN1L0xJeEwydnFzbERa?=
 =?utf-8?B?anFFMzBweWFjR0R0V1NhMlM1Z1JZbVRrVXR4Y2FJTDV4N0d1enBvSmxLRlRR?=
 =?utf-8?B?VWNQU0x3MnRrM3pxNHhOYWZhcCsvZ1B3SHVESlF1b1FCUm5Od3h3TkFheXNC?=
 =?utf-8?B?TzIvZVZmNUxNdS9aQWFCV083cUsvWTRwOWtTQ0FPak93TEZmbWRScWFmNmtq?=
 =?utf-8?B?UDcvaWNDNlZqY0R2QUd0TUU3YVIrWENqQm56c0ZTVk1DY0xiQjZ5dTg0YjVu?=
 =?utf-8?B?VXBXSXVoYkZlYUk0d1UrSUdzTHhLTFNEeHRmN3JxWDBjL1FhdmorN0xFdDJl?=
 =?utf-8?B?aHk1Yzh6NW9vK1g1b2QvUUxQL1RJdytGWkw0YzVOWDhEbUs5azFtbk15QlBK?=
 =?utf-8?B?SXJYR3Zpa2ZmdGpmZldHNktOYkNsQ0Q0MjNwejEzN3FEWXV0aHl1RVAyejdV?=
 =?utf-8?B?bHhJZWRQTlZURk9oUmpRZmRVK1ZrMW9hNmlYQnRidTFUSmM4U1M4SmJHckZo?=
 =?utf-8?B?cFBhTXBhU2R0QVJtU0hoWXlEQkdReUJURCtPUmxCdGF3b0RaelU0ZnNtNWsr?=
 =?utf-8?B?ZTlRbURpblhCbUovQUMyUWR1L2VzSlVwaGZIaTJUN2VMQXZyUE9DdmtuMWRa?=
 =?utf-8?B?VDhIZk1QUU9rWGk3NlRVMHhMQUtBZ0JlT0c5cU8wOGdORURZV1pCUW5Ham1X?=
 =?utf-8?B?SEllZ2JELzV5NnJ6RXYzZlZHN3pjWlgrbzU5RHhqOGhTakdKK2xkQWJtQ1Ra?=
 =?utf-8?Q?/3H2RdNa+7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1VN3VIZ0Ixc3QvZjJ1N1BKNWZac0h2bjhieHpZSTZpMWxtWThMdFE2Rncx?=
 =?utf-8?B?cjN4cnZHNGdWdFJSZVloMDdSejNhOEhXaUZweXAyTzdSeVNsWmEydzFrMllz?=
 =?utf-8?B?dVNXMTNaN3ZXZTBnRklDNlZQL2dTWmlaNzR1RlpQUnhUaWZwVlZEVThpYWd2?=
 =?utf-8?B?dVhjdkwrdnJZUnIzMnhCYllPOE14NmdDc1RHWStrakZuUFd1OGc3Q0pFVVlR?=
 =?utf-8?B?VGI1bllGYXkrRHFYWFhqeVJXc25QVFBxRldrblIyQVQzVmJmc0FieitpU3o2?=
 =?utf-8?B?VGNZdHdiKzVHaFp5MGR4R0E0cjVzVVZzS3NTb2dzb2xwQ0RLL0dsYjNmdmlL?=
 =?utf-8?B?MmNobjZXRDF0QVVTTU53QmVqZFU0Q1BtWkxZUGJjT2Y0UWpIbXk2RkpzWVZp?=
 =?utf-8?B?czBha3FzYUU3L25PQTlTeXI2OGd4dmhweXVrTXl0U3lkTjJhUUgxdzM3NUZp?=
 =?utf-8?B?OWRoZHdRdGxwdVlRT1JGRmVxUVBueVVmREd4alROR0M4NWZhSFREVjJJL2kz?=
 =?utf-8?B?TnNqSy9mMk4zK2xsZGk4cEd2UjEwMTVxZWFGaGl0OUJhY3ExN21LNDVaR2FB?=
 =?utf-8?B?SFFWSXhWUlVHRTBKclQxckhzeVhjd3ZUV1JZc3ZBU09kQUR0dThSZmFFTG0v?=
 =?utf-8?B?M2l2Vm9CcWx2S0dCOExHYUVNSUxFQ1gxWno4VjljOTBGZEd6Q3dLL0htL2pv?=
 =?utf-8?B?OTh3Wm80Y1dOODZzVFZyWStuR2dpcGpudHdCZ1NGZnVBT3ZTNEhpL1NjWko5?=
 =?utf-8?B?cDljeTE1ak1CSXhWbm9FL1hsMXh4SWZJL2Jub0g3SUdWZzNndXlsY0FCL2Q2?=
 =?utf-8?B?QVBvRlFrTjY4aFBxTVdlSjdQWnorcU52SURUeUJzb0hiUi92WkRMbXVnMk54?=
 =?utf-8?B?RFpuaXd4VFBxaHZsdC95YU9yLzFKZUtqV1FueVJjZGpVYlo1Y1JmSGhxMWc4?=
 =?utf-8?B?N3lQVnBIY0hUZUhDdjZyT3ZUdUtHVXNGTVFtb0RvRzNhRnBERVNmRnZPRktC?=
 =?utf-8?B?YXZHekVFNFR5MlFTUWM0QzJhQlprcm5FZEZWUnUxK3lKNDIwWVUyWG9rTzN5?=
 =?utf-8?B?S21nZ2tDenBvN2tWTVFJbUUwZ1V3ZytKWDF5NWtmZU5CL0VDMG9OTmpjRjVT?=
 =?utf-8?B?ck9yUEpWSDVTYlFRVktKSVIzOENLZTFYRnp3am1MVXhVcVkyRlcweEw1VkFy?=
 =?utf-8?B?TWNZNVdhVU4ydWhTNGZ5bjl3K01icHJIRUtJMUtZT3YzS3JLZHQxbEZYcm9L?=
 =?utf-8?B?Z0lzWTdVTi93RlhhVmMrblR1a25LYlRMcHI4THNRQVk3THA2SDkrQlJqL0RV?=
 =?utf-8?B?MmlUdkV5eFNRam81ZXIvV0tYR042dElvSEoyWmJONU9GWVZrUEFlNU85L3Ji?=
 =?utf-8?B?WWgrNmlFUjhqc3pJdXVUYmVWU0J0ZXJTbldYMXhqU3YrUFlEVGpVUVBEN0tT?=
 =?utf-8?B?MDdUMzJnN2xya2FmbU81N2VkdW9yQklMVXRiMVlYMGsxM2ZLN21SZDRGVUdK?=
 =?utf-8?B?T1Jxa1l0b1FTcFF1SzVWZktPbUt2ZWwyMjlhWU5WbGV6UHBYQ1U2WXNzSmlW?=
 =?utf-8?B?ckVjSDF3Mkp6K3FZR09udWpwWVdFWUd3YVVnOVM3YUJ1S3c1M0ZJVE1sdFBU?=
 =?utf-8?B?d0g0Mlp0Yk81ZEVnVG05bjFYNGd4WWJ2anpNc1lTWkEwN1Zqd2lDZklqM1hD?=
 =?utf-8?B?ZFBFNnJwN1k2T2lTNS81L1RFQ3ZGQk5qOTNJYUdWT2gzYkU3UWpGa01iV2xn?=
 =?utf-8?B?UzI2NThVZm1rbm5NSFN4M0UrNnZ4TEJKUDRSL1hwdENPZWV6Skw4SGNrNUto?=
 =?utf-8?B?bFNlNkJyUE5sL3M4Tzg3TmNnSHU1TmxLL2UxYjdhdDl2blFxVU9yS3ZWQmNP?=
 =?utf-8?B?Vjh3S0x4R1h1Wjc1MGtWZHZVbjFFNUNIS1dTenNTc3BVdkVKdlhEeXpKdU9p?=
 =?utf-8?B?NHNZNFVUdkxiVVlGa09UeHVRdjB1QXhoRG1TTWQ1V09yeWFNZ21iaENRRi9G?=
 =?utf-8?B?bHJKQ1VlcnR0ejBITHV0anJaN2VDQmF1Z2EvaHd6NmIyMnRCNE5JMithTUdY?=
 =?utf-8?B?RkdkWU1HR0V3Nk1pU2RyTnFmcmoxSDBQM1pId1V1eDgyU0NwalNZYW5hcGtM?=
 =?utf-8?Q?bNNBoj1Z5HkhQimK4NrW9C1RZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b613452e-ed67-465b-1301-08dd8d6f4241
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:58:35.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEKL/FCZyiLRjGhEHTxVujN5hfzoR9nzHHLX7aEVpHNVfHmkGI3wpTVBRGNFAA9Vkok8FfRq1PUoJ/LfYnfSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221

On 5/6/25 13:35, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a huge page.
> 
> The check for handling the case of GHCB contained within a huge
> page incorrectly skips a page just below the GHCB page from being
> transitioned back to private during kdump preparation.
> 
> This skipped page causes a 0x404 #VC exception when it is accessed
> later while dumping guest memory during vmcore generation via kdump.
> 
> Correct the range to be checked for GHCB contained in a huge page.
> Also ensure that the skipped huge page containing the GHCB page is
> transitioned back to private by applying the correct address mask
> later when changing GHCBs to private at end of kdump preparation.
> 
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/coco/sev/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index d35fec7b164a..30b74e4e4e88 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1019,7 +1019,8 @@ static void unshare_all_memory(void)
>  			data = per_cpu(runtime_data, cpu);
>  			ghcb = (unsigned long)&data->ghcb_page;
>  
> -			if (addr <= ghcb && ghcb <= addr + size) {
> +			/* Handle the case of a huge page containing the GHCB page */
> +			if (addr <= ghcb && ghcb < addr + size) {
>  				skipped_addr = true;
>  				break;
>  			}
> @@ -1131,8 +1132,8 @@ static void shutdown_all_aps(void)
>  void snp_kexec_finish(void)
>  {
>  	struct sev_es_runtime_data *data;
> +	unsigned long size, addr;
>  	unsigned int level, cpu;
> -	unsigned long size;
>  	struct ghcb *ghcb;
>  	pte_t *pte;
>  
> @@ -1160,8 +1161,10 @@ void snp_kexec_finish(void)
>  		ghcb = &data->ghcb_page;
>  		pte = lookup_address((unsigned long)ghcb, &level);
>  		size = page_level_size(level);
> -		set_pte_enc(pte, level, (void *)ghcb);
> -		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
> +		/* Handle the case of a huge page containing the GHCB page */
> +		addr = (unsigned long)ghcb & page_level_mask(level);
> +		set_pte_enc(pte, level, (void *)addr);
> +		snp_set_memory_private(addr, (size / PAGE_SIZE));
>  	}
>  }
>  


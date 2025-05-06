Return-Path: <stable+bounces-141934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91212AAD0B1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4E74A624E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8EE21858A;
	Tue,  6 May 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SI0UXvxi"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648B219319
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568921; cv=fail; b=QBoLwHZwgmXbvYusNfn1S/nJ1kdxxAVVz3obXdXX7CKuPWRumqveftUlvf88+NeD+rPxYno3chen4QgQNTQEYSg9yQUvk/aOD9r7e/jXM7lpj7bgGR8jNheeKrr4WAXiOhNjhzo6DTOHjf6pm35FJafz1s0mFtlBqavik5v+1RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568921; c=relaxed/simple;
	bh=x+Y9Qru+OpDYrOcr7FW8ylNiGcSLg2/Rphvm+O2djY8=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=j/GOwFe/HR/PMXS/sTRTI0G0lBTHOG82m1oVlTHMqrgUke154ZBGTYEaEXbUfaSBTYb+/fEDTOchfs52byoybvxICrK+iINtsoBJzOzEMDgYvn4tuGNERioyITLoiJquujV6GLisrJsmGa6s2k/XdEP4/Be6MpXHk9WkHEY97xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SI0UXvxi; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUbPBF8lAzzeOzCrbyUZ8n+4weB9vJGBu5pxKMl4/iORIVraVG9gjiKMON+aPh/uYkFAbuklYcGGPWN4nUMHvL1yW0/ZQSZoMD/5CwiCt68ZKordERm5+lDZXfs1LCHL1XocY7TRkWjASKkWahFZ2nYD4SZLKHHrYrEym92gD0x6LEo/Q6xjvHqreC1fox9zu4HyWdfDRME7Aixl8g7EH5oqajwbBGdNQjDNxbF3+sUokUfUT6Mn+CDEQtGMnAJn3+nH9D8B0o4XmkPf0PdtfyJMdXford6MeoKe6K2hyjiHGutaWzw4vmMlQu7LkcoV6uAFd2KuG5kJffN9PJOSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGTcpZJu5sUdHQ77vx3mhYB8R0iqKxhTogi/HVyLx/o=;
 b=ueb0SMMbRr5LCA0ueTAPnGcH0HxXnPeniPp2UMhYcpAioqo7r0xdRfXi2+NX61TNDxqZDPXT7cxn2JnkyQJc9m1vT3ckDi+zEfSa5C4QOmLxfYWylXlLeJK2OQjCYWW35TA4FVlyiwGhehSSJaiXGcr6+zu39xyl2v0dii76uPTvDa2yH/e+igVfvBGs48aRroARX6VuFybbotg65RwRYdCvBOWEnwFIMEvLGjkx5ll78n3c2+FFagUJ0Lxk0HmH2bkltzUE6z4WnwtU5mIOI0P1Rs/+0npvvHyrxEyqibIUVUcjIigMcbiCH3FgZzMjM2ORfd8I9yIaitTVX939HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGTcpZJu5sUdHQ77vx3mhYB8R0iqKxhTogi/HVyLx/o=;
 b=SI0UXvxiyt8sjcuLCGFW1q7mcjb08aeZHkA5A89EpzJYkv5sWDacLx0lQCmro1MgtcDjn9QQvB+KKHrKD+cyDoHLrarrckTcLTuRqG9SivoAGAWsF1vVacrKekap0JnqAFCTM7VfU+mrZAhun3MVlasELUPR8kcXudgg8rOsYWsT5/5WljembpHT5eDE0E0ADQUyujBCnDukwenjIKShZAArBLhEFZ1PrzGKe15ri4pp/Fzg9jTecs6PqHx7kc0j8YLKUH9D6K+rg69DbSnIBKOQ/sWOCIUZFmwp12T/k+J6/MuioVTFOqcApN33k6GLa07NOQ+gIW6u63pn+MNGYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 22:01:53 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:01:53 +0000
Message-ID: <0b8cdb67-c838-46fb-9863-4ec6173ccdbe@nvidia.com>
Date: Wed, 7 May 2025 01:01:46 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 1/7] ublk: add helper of ublk_need_map_io()
References: <20250506215511.4126251-2-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-2-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 188ce9f3-bdce-4be2-da9a-08dd8ce99bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXNtd0dnQlpKWGgxa0NvTm00OGljUmhTVXhsYlloR1hlSE82QzdFc3lFdW9Y?=
 =?utf-8?B?QjJHcUtrVzFONFpVSUFEU1hNWks4YStFWlJVMk43d0cveVlwWERRSXdpK3VV?=
 =?utf-8?B?UllHSTdUOUJyVDdzdmpIOCtFU1p6ZTJqL3RLTGNaeTlpcmoxYW9Sc0JUSUdO?=
 =?utf-8?B?YUFFZTZMVkRKQWNpMDNHaldETndCeEQrTmhRc3ZHcjdqdGFodklUTkpMQmw1?=
 =?utf-8?B?SENxRWdLUGo3WWNzd0Q3K0swNG83NTJyY3BybGpMRGJqR2d3aU9GRjEyenQ3?=
 =?utf-8?B?QlBhV0RLSkllSEs2WFc5bTY0UHhVWExkY2NCTnQ4eC9RWC82NXhEaEtQMjNy?=
 =?utf-8?B?bnVFQzNWR1p2bUVWdHd4YS90Zkc1bjJFMlJWZ054MDc1WEt6NGRISFFvbEZk?=
 =?utf-8?B?ODVNc05JV1p0b09kUU4vR3JIOWRRa3dibnRkWEczYXN6RDcxQTV0WE9UWTlE?=
 =?utf-8?B?YWJ6YVRSa2REYk9HaWdBSnUrS2MvRWdRT3lKUU9DSXNPR2twc254SWF3SEc4?=
 =?utf-8?B?MHRsTjEzMjVjR1VSdXZ2YWZrZUNnOXU1NjNzUmh5NnphM3prYlZFWXFsUzFT?=
 =?utf-8?B?Y20ySWtjenNXcjU1OUZKYUQ1ZDRyRlhGSTdFQi9NZFEyUVRCeU9kb0ZSVVU0?=
 =?utf-8?B?OWRBTUpoU2N4V2VtNHhUWG5IS1pxTlNwK2pzNGJXUjk2L2RNQ0FvRS8yWTFY?=
 =?utf-8?B?OWxiYm8rUElrZ0g2eUlwMEtVaklIY3kwYkc2SS9LYmNEQm1DN3RJckpVNWNa?=
 =?utf-8?B?cVVCQW9KZFRKZ0ZvcWUvK0NRa1RnWERmcVVjVndSNW52Qm5STS9NeitzMStL?=
 =?utf-8?B?bmQyeWF1R2tLNldJRGhsdGo5eUFvRTFCVTBpa2FXNmpnTVhpL2l6a0FiNGM0?=
 =?utf-8?B?Mk9NTDRWKzQ2eTFBNm9DMFNWM2Raa2FMQ3VKeDE5dmxuaTdaa2prcTdKZDQz?=
 =?utf-8?B?STNoSmFVVnl5QnhWR2F6T1RkVzg4dHBXYlJCSzRxbzluRG9UN3g3SGtVZ01T?=
 =?utf-8?B?Vnd2U0NnREpiMzZDOFdxZXFGTUtWOFkvKzVWRWtKSDdJQVU3elV3K3BIUEQx?=
 =?utf-8?B?YWF5bzdNTFRNRmM4V0VWallHeXMwaVc2TVg2T05rWXdUZUljMk4vUlhwUlBK?=
 =?utf-8?B?Z3d0VkVIaWtyS1pZQ3d0b0x4eG43eFdaQXFTUkpEQ2JoVk85SnZmOHllbUlK?=
 =?utf-8?B?aGdrZmZNWlNRaGI3cjRHQnFjY1NYcEloQUJoNGZkbEZMKy9LeHY1ZEdyNnlh?=
 =?utf-8?B?MjRVQkt4Vm0rZXlGa1hiMkpHdysxTFpvcUYzaTB3Z0Z2Vm1ZTzVGaEU3djV5?=
 =?utf-8?B?QU1acDRmTW5OVHVZVGNWa0dpR1pOcjVnYkFYMHZQSUdjYmZZaFpDZmRTQnRG?=
 =?utf-8?B?TjRxbVpOUVp5dmlJNUwzK0VQK2cwM1NJWHhDUzBpOHlVamdUeWR6ajRKdW1u?=
 =?utf-8?B?ZUpVVlgzZFhDSFJoYmFaZi9vMHdJY1hVRTQ3UWtoQlRTVkdRMXRBaVNIbUZY?=
 =?utf-8?B?ZzdQOTB6MzM1aDRIcGx4eUV0RmhVcTdBN05yVWwrdnQ3VWRkZGM5bjJrQ2c1?=
 =?utf-8?B?MmxzTnpRVU9vT3o5aC9UNHRBazFPRWJBbDJ0bEtVRXlxbmhaNC9kSGQ0eXFx?=
 =?utf-8?B?MFc3eXM3dW5YdmJPTGw1WnptdlUxc0JvSzkzWUJwa3dCWUhXZkFvbDBNZ0Q1?=
 =?utf-8?B?Z2pCMFZGSVNrWVZ3L3pycHdONXJlS2F6SndTNDRreEtQZTNiSFdPcG02RzhE?=
 =?utf-8?B?T0F0M25od21SMk11b2FFWXVTakNBbitBeUNDQ3ZXWjRLMXloeUFrSDhRdWgy?=
 =?utf-8?B?OExhaHpxMXg2M0lpcEwzWVBVYlBJS01RUE5vcFp1UGs2VVlqUWhvZkNTNUN4?=
 =?utf-8?B?WlFIbkVwOWcxbkdRTHdkTW42TURva1BJYndhQVRLcllvQ2ZXWUhGemNOTXRi?=
 =?utf-8?Q?IL3Vx1IigNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1vdERPOXlZaFcxdTErNkpqTlFBTGtFdGRJUm84MDVxOGRaR0E4eHR5NE1u?=
 =?utf-8?B?aHZ2SzRHZ3B6TzVSWlBGSWhaOTJXMmh2cDl6OENURGpFZjl4OGR1bzArK21q?=
 =?utf-8?B?VFVTbkdzSlNKSlRDS3dwbGNTWEQ2TEtEbm04R0FGWHo5RWJReDVuUDUrYXhl?=
 =?utf-8?B?R0F4ai96cDVyNHJ2dVdoTENCMEx0aUYyY1kwdnF3dksrRVR2b3FZanRQNVFr?=
 =?utf-8?B?VFlQSEp6K3l4ZjRXRHNpMzVVd1NrZE9GSzZ2NDQ2YnA1ejVoY2tldE1Palll?=
 =?utf-8?B?cUxIRVN3WS9GSGRxVlYwMXhiTXZqR0lyUFNTZmdTZmU2UDdJeVEvNjN4b0Vo?=
 =?utf-8?B?MUhIQmczd3RZbUcwcUJ3Vmx5akJHdE9FMy9hblhmUVZyS2dEQ25MTjg4QWt2?=
 =?utf-8?B?ekZBWnQxSW5NQXNOVy9yMzZUckh1NWx2L1dGUCszQUxwcm9uN29XRE9yNkNH?=
 =?utf-8?B?cklQb3dVOVRuYWVjYUZwbGZ4Z095TU5ybHVrTytEeFE1VU1xMDNEMVlwVlZ1?=
 =?utf-8?B?em45dFBOcVdiM3NydXBjUzQ2akdROHU5cGV6Sy91bzFqNzRhc3VLUXJEYkpG?=
 =?utf-8?B?UlhrZVE4a0VnY2JYUm91VmVUUHNpcm96WkJoSWhxTUlrdlE1eDJjdWRRN1lV?=
 =?utf-8?B?T3RybTBJb0hscHh1bW4vOXdDdEZCd3hVOVZUMFZIVUVoM1lVa3hyTXgrOU13?=
 =?utf-8?B?d2c5dEJFQ2VjZFBCNGwxUVBCNzcxWG94QVoxY2dEYzFPdDhhenJRdzB6OTg4?=
 =?utf-8?B?VlJXam5BWHNDdFp1QmVDVGJNV3pWejNFTElzQkFZWFdaZDVzSzBna2VZK05F?=
 =?utf-8?B?YXFOWnN3ZUFzbmk3a2dFVHVmc3JHZmZXQU5hc0lBaHpxN0V2WmhIUGFQNEo5?=
 =?utf-8?B?cTA1MTE1aWpucGxTNlY0SGtDWkNiazhOdllUMmNjcUg4N1dNNVJjc3VIa0g4?=
 =?utf-8?B?aGpGVXhQODQ1Z2NkZGFqWmpWWDg4V1Jrdit0b2F3TDBjTkdhOGYrOXlKdjc3?=
 =?utf-8?B?K0ljMWRKbjlUS2laM1YxWDdNeXBiaXlxTXppaWgzbk53cks4RkRtQnJWdThz?=
 =?utf-8?B?c1hNNTErZHRtQWpnM2Q5dms0VkMydlR1VWVkdWl0OWUvWGU2WU5mUVkrR0dH?=
 =?utf-8?B?dnlKaXArM2VvcTV4UWQxcjBvQTlvRXFxOFNSL1FOWGZQYWozYlU2ZmhZNyth?=
 =?utf-8?B?a0NJQUdiNWp2V2J1T216Z3BiOUFIcHhhYVlJTGUzN1RwQm5qeHdrb2RhQUIz?=
 =?utf-8?B?Z2owcTJuVzhnQ3AwZExLS0IyTFVkbE1CRjBXcTJYd1lPL0xyYzE1SmZrUTBa?=
 =?utf-8?B?bFRUSUgrL05UbnlsOFhUOFM3MlcydVNzcTRkSk1NUktRcDBoZFdjelhPR0xu?=
 =?utf-8?B?UGJGVGtmZUZGYm5hRG9zSWozMHJIWmdNK3N0OGhSS0xlVDdveTA3YnEwTzFG?=
 =?utf-8?B?Y2VFOWFGQ3NUQjlLT1lDUEczSnNwbnVXeDI3R2xqbmk1L3FQekRwK3JQbDdW?=
 =?utf-8?B?cVFFelc2WUlOZG5FYnQvR3NSWm5LWlBYQlVYL010VzB0eWRUNlNaY1RLZGox?=
 =?utf-8?B?ZTY1eTVwSlZUc1NTUWZvSkc2ZnAxZzJLTGlwVTVweVNZOThGL2REck5HbkI5?=
 =?utf-8?B?dS82QkpPWWE3ZGVreHh2VWJDeXB5SDMyVDJCVVJqQTRjNUZXUGkyYklZQ3o5?=
 =?utf-8?B?VW5ING0rM2FFTFpVcEc1Wkp0WEN2RXM5Y29zMGpuU3orQ09hUStKR0dwNTZh?=
 =?utf-8?B?NktzMDRPTklxc2Z0cGZaOVJ4Z1NaRGZ1R2l0YlNNQ2l0WUxYckdTSTRNeE50?=
 =?utf-8?B?QUtyNzVYYXRiamhTZXZiLzRyNHFoV25qWE1FdFhHbEJlK3JHUjZoWHNxVi9L?=
 =?utf-8?B?RHRzdWd4di9XQ1lMaE02OEVGTjNxMkpjNG9LMDZRWE1wT1FOUE5ZUFJWVW5C?=
 =?utf-8?B?R0JzQVZZTlRNaEx0WG9jRGZ5S21GVVMwZ2pMaktLbjVOeGRhMWFObVpEakc1?=
 =?utf-8?B?MXNyRHgxWEZ3ZGxldjdsY1JLVFdaMmpteWFMN1NpaURNQ21jeFExVUdYREZ4?=
 =?utf-8?B?cnI2U24yd01JOW9weU1DUi9RWThoWjNuRHIyOGJVeEF3MVVnOThicXdILzd3?=
 =?utf-8?B?VEhxNnp2OE5rdVFydEY3OHpwZ0lsd3pBbkpHREJDaTJueWNNMUVtLytwNGRD?=
 =?utf-8?Q?OngVXDisaazhsFn5muPDqRSAX/yNrCbDGMxqZQlCCSEp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ce9f3-bdce-4be2-da9a-08dd8ce99bd0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:01:52.9132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXZaH3ywRbYfQ3X08c2iNXDY35JZA86u8DnPrcEY0onoiQBRGJ62JDSBlzX1gvAoElZKrOv1ZABXhV6TQq0SPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528


From: Ming Lei <ming.lei@redhat.com>

ublk_need_map_io() is more readable.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250327095123.179113-5-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab06a7a064fb..4e81505179c6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -594,6 +594,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -921,7 +926,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -945,7 +950,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1914,7 +1919,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * FETCH_RQ has to provide IO buffer if NEED GET
 			 * DATA is not enabled
@@ -1936,7 +1941,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
-- 
2.43.0



Return-Path: <stable+bounces-77066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B991985094
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 03:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F29B21106
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 01:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3D2AF03;
	Wed, 25 Sep 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLmDpLlZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C8C125
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227086; cv=fail; b=m84h8+0Xr/Lpt1VQwIoBmH9tpoqS7ivgvzn/QkFEal3kdUcHgEefa+ZHU8wLfE4R/E8OvnE+YbuEaRjwi4VLh9jlUphm7JrcXE4P+Hip5n5bL3yyCT2SextlnDIoGekIavHlx5x/JSZ/OBOLp9OoW5dBDc5MZEqYgeFtbBtcQ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227086; c=relaxed/simple;
	bh=tWSOEsLAIrmgupYbu+WSVdVYukQeUdtaNqT6qC1SPWI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=R8jmIkxHjclZXzFqvLH30mQsnCgf6kJJGK1weBcExsQ/cQtxEuyGEXZWqsEFI7OhliFCh7LO4J3McJt/aJwsO+e0ZLWK9pYkqQeb6S8sGiwDP94CVp1zKM7gjMt22xMuhD/Gx/JrzmP7fOvd8Kbl0mp2prWMF/ikCNVWzB0inaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLmDpLlZ; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3LpdyQQdyFU4kolZz+qTmaKf5oyQ2m3lXGke/NXcZ1kbfuNurFZest8SN2cHg5KLvsBeIoesyEJj1Fw7KCR/mxdrEW3yWZI9ZNcy7CRq6J1RPumkkAWyZV+TBhsGiYRKRNzLYYI6EsFZ7Gm7ATpv8ufPtDHp13p8h/yjzXs02cGpIp37n13+SnX4KTejqgaQ+yJ2RhaSv1La8zKamokuWCPhZ3A0a5BO+jS+ERJ+X3Get+LedB0tILHb0Ufk18/qDrc2FHWp38ZaVO0iYD0WFgqV/lfuIOSXZB7DgR9d0fpm8MXvDdrlaJYocMKgCEwvkLDblLGfLe+k1uKZTOTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uYM7atqBXmYCFUvmNdQA3xNZo45v6dz9VOn52vkmRY=;
 b=RVHXbWRZ1LqaRny7Jz22YvlgET5SZRtuH+07/iYkBlNmHCXCmb2LHDQg8P7a1EIaqC58bpoJFvj6Yf13tEFIc9isiWLD/k00jAFy36mlfOdYoI5Fk/pNZ56JhLr4YswRI7MNCjKbveFwVHxmFWc7jjy4toao1HYR/dUhoSE/lFo7JtUhr75QZ66Ob6UqG6vzaTL/mmscL8bV70yKsYAbKIScUDsFlt5TQw+WfN4QPuZSf+zg8XxCAxyvLiruUfLM8vL170zLcjorImjafA+IEi2G4QLKLAvp2a0XBJl61AUWiQyVWm6ptnvN7rI8/iMTJnHjZm90ZnaMqGxSNwniIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uYM7atqBXmYCFUvmNdQA3xNZo45v6dz9VOn52vkmRY=;
 b=KLmDpLlZl67VOWFD/kc502926/elavSmP7KbaDp766o8VLBkGE5tscv5M5Rx0kX/yTY8/GDk33HbtZBW4PUREaIDT69Ubiqmw5dHu/AfXzaQEN49JObnKbNZDbObZhkCrO2QKVM18oDor7GNmXLPjHtRqEqDGNV7jw3vYCPPyt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Wed, 25 Sep 2024 01:18:02 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 01:18:01 +0000
Message-ID: <ec0891d9-ac9a-48f5-ab96-4cdb428897c2@amd.com>
Date: Tue, 24 Sep 2024 20:18:00 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Power consumption fix for ACP 7 devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0195.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::8) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a82eee-fffc-4eec-cc33-08dcdcffe617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVQ0MklvclRvb0ZUTm02Sk4yU1hYZ3VzSFB5QTFsdzVheU9Sa0JwSWJXNm55?=
 =?utf-8?B?WFpJMG1lM3RNd0xZQ0F5dmt4VllQNjNTWjNaWlZGOTREWll0TCtKNS9ZZUJk?=
 =?utf-8?B?M0V5bTNJSlVXcUVxNEhDSVI4azdBZVNoWWlxb3FraHI4elFkUWQ2UkdaTkwy?=
 =?utf-8?B?MVZrVHN2U0R1K3JLV0Y3ZHpIUUdIc25sZGtkODFTT0VzalhjNGZkc1djRjFk?=
 =?utf-8?B?RHVNWlFaTW1kSVRRaHVDdTcxR3FwMklRUFBIaVdBY0dEKzJ3WG5JUVhLanhx?=
 =?utf-8?B?Y0hWZ3J6NmJJa2JUMHNmdk0xaUk3TjZjMFZSZXowYXVPenNndTNCOEJuWFVu?=
 =?utf-8?B?YUpPVTI4NXNoREhkNVY4NkJpVnlQenYyV1p3QWRnM1Iwek9sUUFyUHY0K0p2?=
 =?utf-8?B?RzdZZ1lsM0JPQWJhSEdBcENFTDZ1TGVVZGQvZWJmL2doRHdLUHpaZmhVa056?=
 =?utf-8?B?WmlqWDRnNWo3YWhvWFRlU2VTaWRXdk9WakxIOWEvb3Noa0M3eU5SaU1UMnJj?=
 =?utf-8?B?M3pDK0ZLOERiY0NtdXRhcGR6d2lEU254WmU5Wi9lanlNT0tFQTZGQ3pNTWl6?=
 =?utf-8?B?em9vNW0wMkVpMlkxYjRaR2k5aTBhV3grZTZHMFlpUFZyYkMxbk9vN0FRdTc1?=
 =?utf-8?B?R0JidWE2NmVKcFZkbC8rQi9oaWNkVkVxYkVab0tiZVFycjI0VnhlUUtFS2Nm?=
 =?utf-8?B?QWhzWitmOTJHT3FBTHdhZDNaempXb3VFcTJBaWZGWGRkYnVlUG5CZ0hvQzhh?=
 =?utf-8?B?SUZtQjhWV3ExaHQzVTVJazRTTk5hVXNBVzc0TVNjQkVNZTVIZXNOeUwwbDY2?=
 =?utf-8?B?LzNRd0hTalZBTUhwZnExdzlhTzhRT1YvZGtIaFE3SGlZOVFFVTUwUHJLN1VB?=
 =?utf-8?B?SzNlV0tkNTVJbjBUSUQrVkdwajZjQTlLQUNneEczTHpuN2NQa3hIR0lrTmUy?=
 =?utf-8?B?aVo2Tlc3RnJBbU9LcUpuSE9SanJDVlJwTVlmdWQ5SGMvTDVpRWN1OUhrVkR4?=
 =?utf-8?B?a3NxZ0puQUwwMXNSRytmNlhuSGhQR09GRE13TE8xK2ZleEFlcnJ5RHlGdXAv?=
 =?utf-8?B?MHQzdEdzVktrd21nT2F5NlhLNTViOURaWXc2MUVtSUt0YWxVblFTMUJPTGF6?=
 =?utf-8?B?OXJLcVl1VW8wd0ZENUVaVkhlTlFOdm9XY3RPTXFINllIRlhURDlhUHdGRVNY?=
 =?utf-8?B?V1pubGtXTE5lc0w1MS9DZ215WVZQQUtGNVZXeEJCeUoySWxKSmVrMm5KcFJ2?=
 =?utf-8?B?TmZrWjlKcEhYcjY0Zk1VV1FqS0N2RkNPMzFtOU81bHlSaGpvTGtaai9IRGg2?=
 =?utf-8?B?Vk9wZXdNNlMvaldCeTZuVzVQb2FlNVJ1MnlqQWhjQ2gvbnpLaEtXcC9QYU9k?=
 =?utf-8?B?c1F3b2VDRXp2aUtKUDduTGgvMktUajhDa0VaK3ltOXN6dEJyYXNqYlUrN2Rl?=
 =?utf-8?B?SHpHZ0JJekwyRFoyMGtoaVhOTDFiWnRDZ3haTUYzcDZwNm9NeTJ0Vm5zNG5T?=
 =?utf-8?B?dXUzWDVjRXRWd24zMjRpWFNtWE9DdGFod2FXeDh2bE5sN3R0bWJWZFZqT0Zh?=
 =?utf-8?B?em9kNnN2cXozWmJqZHhoU1ZoeXZLaFMvbzQybU1ra3crWnlJcnJTSVBCMExK?=
 =?utf-8?B?czJiV3JmdWM2Q2VSU3VRNmNOaUxCeTNDVmFmUEtEbzAydlVLb3JpYXhqUVN4?=
 =?utf-8?B?a1E5bmV3N1FHY0liakNLOWtVaTQxcHdrQmNQVlUrRVFNWWhyOGxUTm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNiTmxLR1BQaTlibkZWWm9Nc2c4Z1hDUDRUbmRnU0JOZEdqT3VrWjh3TzRO?=
 =?utf-8?B?MDZxZGd4Q2g4UG9hcDlaZFJJMDI1dkVUcTVkL1RlMVZaWFlJejFEYzVCemFr?=
 =?utf-8?B?a2hQNENqNWN2QlZuRVBZMHIrQ1BoQTJOcmp3WFN4ck40di8wQzIzV05BOXR6?=
 =?utf-8?B?WVZqc1p0cjBqLzZDYTRDWVRDZ2l2Y0hoUEhUNVhLdUxEQ2dmZGlXZkFuV25Z?=
 =?utf-8?B?NFBiYnRhVVJHdHRNb29zNDVVbTNLQmhTZDc1NzcrZnRQSktFN3g4aGFwMFVR?=
 =?utf-8?B?aFJEMnVUQUhodFJrYkFWaGE3bFR6U05rV1Q3MmRMT2xJaloybzYvWkFacDQz?=
 =?utf-8?B?VmZoUWtyUHlteWE5NmlRaVFrVlZzU0NIM0lNTTV3WVRtdU1WK0EyZDZvZ0Vm?=
 =?utf-8?B?b3ovcU9hdHVFTFh0N1FQa09jbmhpOTc1YjBWV2RkM3lZeDZLK3gwemNFbTIz?=
 =?utf-8?B?dmVsK1BYNElvcmczanZsbmNQZzRiRUVINk1EdHpzd2N2Sk1lY21ybHRSQmxw?=
 =?utf-8?B?MWRFMUxwV29YWE5hN1ZURkJLRTgxUktZUUN3ZFhGSzFER0Rtc2pJUHFEbTNX?=
 =?utf-8?B?Wmc5clkrWXVVdTh2N0hibUpDaHQxU0FFdkxrNGFycURkc3RhSWFXcDdpeWI2?=
 =?utf-8?B?cjlBMmYrYTBDZDBHcVpwQzJ5MGJtcjh3UzI4QlFMbFpleVB5bE1wZktHbDlP?=
 =?utf-8?B?VXAvcVNrRGUzbEMwQmtrZUFnTE9yT1MwOXY1MjRKY2IxUnozdUhBZm81WnZm?=
 =?utf-8?B?ME16ZUNZN1BKalVad09YSmNmalp2Z1VaZ1hZdUp1MnlraE1qbWZnQTdqazgw?=
 =?utf-8?B?SXVEVENaUGVCNjJraEZtWkZVTGN1OXNBOHFsQ0ZiekNIWFpCMXVWYjFTaHZR?=
 =?utf-8?B?My9KYzFCVU1PcFAvZzZwa1IvQm1MazcrTEpmcFV1RGhYOXdLcVJEZTVzMk5L?=
 =?utf-8?B?Q0Z3ZTRUdjJTSzcwdVZUTjRNVEFqSTBuWXE4N3ZaTis0ZFltTGRkZVFtUWxW?=
 =?utf-8?B?K0IvQzk5WmwrMFlHNER5R1Z6d1l2MUxSQ3RuelpIMWl0RVlvN2xtOUNVZnE5?=
 =?utf-8?B?NmxmM2E1ZTJPYnoxR2lkV05CYUNNY0hNS1U5VDc1c2tLUW8zZm9TcUtFMjhK?=
 =?utf-8?B?UVhod0lEMHVQaCtuWTd3NU1ZeXZYRndacUlFNk04NmJxdHRRd3hqNm9GMTlF?=
 =?utf-8?B?NHpKM3NKeWNMV05wcEE1ekRObEd6aVYvWkhQMWtxOFVrb256eFJSUkJGa00z?=
 =?utf-8?B?VXFDTmp1Y2daMGc0bDJkWDNNbk5XUTNRZkFsZTdsSWx3M3RucTgxYzhManBo?=
 =?utf-8?B?NEFFcWpVdXcxYWlxalNZQzZLWEZ2RTYwZ0pWdmRZeWxlTnVsWkRKSGtvQnRi?=
 =?utf-8?B?Mks0YkxucGJXZFByUHVBVkk4Uk9DU0FyWHZZUFZxSk5FOVQveEkyOWhXbXBF?=
 =?utf-8?B?Z01IRmhWMFJZeWlHeEhmb1F5eHJWdjc2L0EwbjdGT0JhVnNUbnptaU5pN2Q5?=
 =?utf-8?B?clNpbEZicTRlb3RHWlJXcGFCdTRJazl0eUtjcGJOT0MxK1lISDhsZWZObWkv?=
 =?utf-8?B?ZTZlUlVTbWhYWkNic0RISHVBRTI5cFEvOGRxVHFFZFpWYzNqcCtQR2RJaDlo?=
 =?utf-8?B?cm01R3o2R0VwV21ycHBXZ0ZlNFNxNjJmcnJFeFVDNTBxYzBvN2NmaEJ0TFM4?=
 =?utf-8?B?UnpWOExaOGtTcHRrRU1Ud0JUeC90Y1lKMUF3RDBjbFBZQW1EOVZSd0VSd3J0?=
 =?utf-8?B?ai81dG5HWVpndVQ5NkFtVURlVUhnTUIrRDJCaXBHOWp4bkNvRTJsUDFlcGZ1?=
 =?utf-8?B?cmZVSXo3cncyVHgvakd3TnZLZEdGWXI3d2U0MHFiQ2FlZlRIYjlKYTl2RHZ3?=
 =?utf-8?B?OTBOODJWaWowbEdtU2tsc2tReWt6ekJraEt6N0UwRHpMWHVWUWYySThGUmhO?=
 =?utf-8?B?N0lSa09BN1E0czZ4NFZOKzduTndzby9hQ3c2T0ZSWHNMSDVSTzA0cUtoOFVk?=
 =?utf-8?B?bVdTYWJKbjR3ZmNGaERkU2o4d2lJMkhqS2ZhQlpxSFN2dnJ5UXNEbFJBeWcx?=
 =?utf-8?B?cFJ5OTJLV0s2QlpKbWtsZHBQbEIzd0xRWVZUYlhsYTQvUEpJRGxnZ1k3NXh5?=
 =?utf-8?Q?+7lEjSpkSDchadZaw/84TgaZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a82eee-fffc-4eec-cc33-08dcdcffe617
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:18:01.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRQzweCDr+zzAgNgQyn6f7dco4RXZ9nmnMd8Vv3Bbf3/B3n6dd4YEWx9CMy7SQoPso83LFY4kUGu6pk3Ng0tgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

Hi,

Can you please bring this commit into linux-6.11.y?

commit c35fad6f7e0d ("ASoC: amd: acp: add ZSC control register 
programming sequence")

This helps with power consumption on the affected platforms.

Thanks,


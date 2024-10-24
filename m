Return-Path: <stable+bounces-88029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C49AE2BB
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF31F2170D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D11C75F9;
	Thu, 24 Oct 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qZd3KgmH"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C01C0DE2;
	Thu, 24 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766214; cv=fail; b=udwTPkTooxTi+8X9yAtfwKlT9Ww4WJhn+BZvaViAlm8n3dlCX00lxWOw/dK+hjskPRfgucgL3C6bjAEYn7FRyYv1RlZcxuEKo6Jrk1AK0bdRKeEQhlXd3cBGOHUfFwxZEoMAy3XuOVrvAWE2CAoBQrQ88WCveEDPLo5+hurPAn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766214; c=relaxed/simple;
	bh=hZSWsLnVghWn8Zih5mplfwSZ4kF/5c6zFnzJa/byZ2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgToGm5o9/h311OScn3+uIt0ZeEWYD9nTjA3SbgXMox++fpUd6wiYeDPZB8BxITKauhx0vNHKL/YURc0vyppuur650Q5okD1EL3k+fksfTJJZlL7IJOVQa1pC3ViLoHyxRy9RAiypwupek9ity+Zx6j+06HukAPslrt+ELtBbm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qZd3KgmH; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb8Z1RaDSD4mqpMxFaMmCTqmHDXv2JodZp0XKT69cPpM5KNXJsRYuyd/XNqNjKkfTgf9CSQsPRmbbKjsGaXjgjTay7qwvE/pHOdJN7hO5ZZeo53jsb80iy+1HRgPxr4rGXIzH40UKg3THnkvaUUThRmAApPfrz8G0HqRY0G4vtY/gTqA6KeAhHIQgdvweo94KqAspxl99ickNNW/9cAwBHRcCP7RN0VjSgvEXgreyio8Y7eQmXU/ff6wy/cmrTVmsVP/i0Fu5BE3RSQOtN093uIHzZmMnh9h+Uy99PBfRE8nO2YLp+vdFZyjDpBjPvpNMCdXBkxVnXCV2wUM51YYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA45p1yMZgVu//hnf9YwiXTDwSMKIlVSljwe8i9q4fs=;
 b=V1Y/B/JyzXT2YDFP0w91Oknj7hZ8H23qEIgGoUR0ZjuE9Fq9I0D6OB1abcJUkyD6QBG5lLHFqEVMVy8EF3J4KTfTT1F8I/obwFvsb3dxadc2AZFsHstFdl65boU0XDFqH4r2hqUcKQ2asYOS0FIZT8RLaWhhsunsXxq6D+kmqWnM2fX7oeO3mUunfl2fy79zk/OQvrb2HCMjN2+5iyl9sFOS3JRNc7fNFWhMxuvUaHyY1ytp5uC7GKMnF1Mgb4Z4bcQjE4xvMKbg5ZDWXml8drw/RWPlJF7QRLeZUjSwgfW+qMGWohg81U6xHitcCPtt88NnVUgJZEPhGnFe2WUFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA45p1yMZgVu//hnf9YwiXTDwSMKIlVSljwe8i9q4fs=;
 b=qZd3KgmH07FYqLu11P6ZO+DxWCwC+tfNtr0BWW6Ph0gBVS49wV9ifE079WE3TOPWIUa0Wvc3HWliAH/GYKjcD68k7MT5ZrWkRIz+NrCMAH4gWcXt7u9/4qYfclsmJ9crMRv0zhNm/f4AmAoRFor9FNgFWhScZNxsrtH2N7LhwuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 10:36:49 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:36:49 +0000
Message-ID: <00e03abe-1781-b2e3-62f5-97897093eb5b@amd.com>
Date: Thu, 24 Oct 2024 11:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] cxl/port: Fix CXL port initialization order when
 the subsystem is built-in
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com
Cc: Gregory Price <gourry@gourry.net>, stable@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
 <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <172964780249.81806.11601867702278939388.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 5909cd6c-d51d-42c8-0aa1-08dcf417c3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkV4TU4rbzNja0w0Lzd0Rm4yV3B5cEZvYzNvdXZqdkptSVgvK2dGakkvamk1?=
 =?utf-8?B?aElTOWhRakNENkdRb3dqR1IrUFJISW1Iam5NdThSUVNYMUhybUUwWVZBd2pq?=
 =?utf-8?B?SkRvcXB2VVBnd1NNSkFLZUpkUy9CSXcwV3JQSzF2K0VycDdPMkxpcjJhbjdk?=
 =?utf-8?B?WWR2NEN0T1JzSllKVmtEWld3Wmk5eE1iSzRGL0Z1OFcyYlh5T0trWGJHRWJr?=
 =?utf-8?B?MW1nYlQ3V2NxZS9HUmJ0T1l6V1YrZjFlL011NDJDYm56aDZKQitOQVVnblc1?=
 =?utf-8?B?TkhXaTRyTnV6dVZMVU9JSGwvMnJhVDlZSitBSnloWTZMYTlqOGt1WjROcUZt?=
 =?utf-8?B?N1lpZUk2TnlLT1VXMUtWeUw5c05XZjJwbExDRzl5UnZ2Y3R1SkR4VmNCckFF?=
 =?utf-8?B?MEMrNTBhWk9oS2RETC8wY1k4azVldEJCRTJ2c0hJdGZKdDlHZW9uZ24vQlRI?=
 =?utf-8?B?U1RqVklOOTBDYkpxYUsxMTBVOWtJOHZLSzIvR1hBQ0lWSitpYXdZZ05MTFZS?=
 =?utf-8?B?Z1d1RHB4Z0Y4dzZJRUdqT2Y2V0k1M2N2ZUdSc3JzdTErNmpoQlhLZHpUUzgz?=
 =?utf-8?B?Z1QwYlpkclp0WnNkeEJWZkd0cVNpbjdGS0dETng3ZS9yUGJhb2NuVjRkMHlK?=
 =?utf-8?B?UHQycURTNmtZOGdJb3ViREhjNnVzNmwwN0poRHMwMEpNRnpRNjBWSW93b0M0?=
 =?utf-8?B?cTFXUy9LQkV2TkhobzgwMnZSV2JORmJvYVhYNFBMQ210Tkw4clFWVHZxT2xP?=
 =?utf-8?B?OVRjSFhkRUZXd212Y0oyMTdtK3J2aGthNVNPNWVRWFZicDJRSk9UYStNcncr?=
 =?utf-8?B?RE50d3lmVUc4VDBzZ0hmQmREOWdrc1NTNlg3L2FZNjk1K1lheHRPSkNYdDU1?=
 =?utf-8?B?cHVCSkdyRzM5ZEoxZU5oUS9TYWYzelhySC94ejRrOVkvalR4MnVvZnJkTk9p?=
 =?utf-8?B?ZVdMS1lyeGZLZWRETmlNQkhDZHlOWlhpeXBhVmhneDVDSGt0bjl1UnF3VW9R?=
 =?utf-8?B?c1E5c1grVkdZcjBaeFZFdWRGMFBUSGp4dWNIRUFrS3lyekd4bnJsd3Z4N2Uv?=
 =?utf-8?B?K0tGUmJjVkFqYzI5ei9kSENnMnNhZSt6RVpqYUF3eHBGV3NMWkZXTlE0K2V3?=
 =?utf-8?B?b2RNeU5rZlU4b0hVNXpiUVJ3MVFxU3VQMWU1WXVFT3VLRVhJOWZMa25DM2Ja?=
 =?utf-8?B?clF0dWc4bkVhOGV4alZ4bXEyRkNLTjQ2S2lWRnhreEJkajdSck5TbCsvUFph?=
 =?utf-8?B?NGFKcTc3djF2TC9HNUd2eXlKTjUzU3pNcVJ4WGt0N3Y0ZG00Unl5ZzlPdzcw?=
 =?utf-8?B?dy92MTF3QWFtVmk0aUNJRU9OSUN1TzBtWk5kU2VGSmlFaEZIM2h6VHFsb1kz?=
 =?utf-8?B?WHFrbXJrSGwwdUw3TmJDYTBrZmoyZFBqbERrZkJaZ0pyVnM3NDlhbUhSSTVw?=
 =?utf-8?B?VVBLN0ZidUFlV3MzTkR0UXlQTng5WGJCMThBSU5FSE5EbXB0b1dXb011alN1?=
 =?utf-8?B?VVJZMy91N05iK01Pd21VS3lvOEMyc05mQitVOXAzdkg3MlJwcG1wZkxRYm1s?=
 =?utf-8?B?TCtxTG9xYkdZNm1hQkJrSHBPNitXUm5YWWxJQkdQQlNrSzFBS3NGTjRMemJt?=
 =?utf-8?B?MlRUaUh3b1BwTnZaL3FzcytCWVN4N1YvdXc4bmx4bXkyNm5sYzFFREsveFFG?=
 =?utf-8?B?TUs5U0diOFpmNU1kN1hrVGxlSzQzcFVBL2pua0ZTOVN4ejNuRzVUbXRWV0E4?=
 =?utf-8?Q?fw+VliXdNRLqR8pym4qaRxxgBmpvMVC3nbTKJzf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUdJeGlDenM5allnWlpncHM0TWV6NkdSMjI2UWpVT2FpZFkyQm5OYWZoK1hN?=
 =?utf-8?B?dUhPM2dtbFdLdlV5YzUyNmc4WFdjcWFPSzl1M0ZPWTViS2czcURzRmNRYU5I?=
 =?utf-8?B?ZmZYVkJtK3JFZlhPaEoranlad2ZkOWNFQmdoT3ZFZGxUMVlsUzFqeWZqcmp4?=
 =?utf-8?B?a0dpSmlhZ25TeCtyMFhMblVqT2pWRS9kbk8xUHFwVDlvTDFzUE1KNi9rcnB4?=
 =?utf-8?B?M1ovV0tZenFpWDlSWTZiV1NRa0NkL3llenh4RHVQYzdWWXNTTVFVVVFTakZL?=
 =?utf-8?B?RVloSHFxVHVrZGNXZWs4N29DaVNMVW8ya3JTYlYrWmd2R1RBckFtNzVIanNQ?=
 =?utf-8?B?WVo0ampudlhRQXkyMnNsSXVuNHN2cXFJOGZHc1dUMnJCeVVoRU01MFhpUEZm?=
 =?utf-8?B?VjFrOUdwRkswMlZ3YWpSbUJlYWNjUURyaVBiMTFWc0x0dDFPakN6eTNoUTB5?=
 =?utf-8?B?YXpwSUJ4UHpoR1lGSlBEMk5Ka1p1bFNhNzFOdVNHVFhNMUxoRUg5dUQ4K0Vm?=
 =?utf-8?B?Nm9sT2ZsdVhPY2UrOWxVaCt3aG82bjlOSXQ0cDBXa3U2V2lTQ1JwdWg0aFAx?=
 =?utf-8?B?QnQ5RWhnWldjeUZybzJFYTdtUDYzR25rMWhDODBjWEo0eDBSb3J3bXlVOTVC?=
 =?utf-8?B?YnZUR2UwRVRLSHYvalZiZG9ZdDBJWGpZYUZEcjVyMFpMZFVNSW00amZvWGd1?=
 =?utf-8?B?RnhGdUxJL0F0ZzREL3E2UGlkVFhtVy90OXdvNWUrZzV3cGF0RzlIYW5zbDhr?=
 =?utf-8?B?RDJvMHJlYVZFYXJDNnFzK21RV2RqQWhicTVFbkRhZ28xQmw3d0pxYm04bmQz?=
 =?utf-8?B?NXgzdit6WXJaWDVySDdQekNWemtxeUU0N3Z2NkVyN2xaTWlCTDhEUFJkanpz?=
 =?utf-8?B?QTVTd09FWUgyVU85RmdadlcxcFRwaHdFd2FhYVJqUlBmVVdKaG1IUFJLYS9x?=
 =?utf-8?B?dHpLUmpWYkNCRTVCMXFWN3RpQmJieTQwZ2U0UWNLT2c4YlFzTlB5Vkd1emN0?=
 =?utf-8?B?OHp5aVMvNXEvS1JHN2pDMUVvSkF4UFJMRGxUclJMTXk4UVQ0SUhjbDRXb2hw?=
 =?utf-8?B?MEpsU2RFUVVVVC9SYlRIM0MrVzY4RFFMNy9VbkRoZFpiRmMrMS9hT24vcWxv?=
 =?utf-8?B?S1JhTnlTelhhUU9JZjFoRjBFZUtDZzhINWdsVEdYdHNxQTEvU2JET2g4emxL?=
 =?utf-8?B?VFhpYjFkR0cwMEFmSm1TYUw0Y3ZJLzFFNGJubE9UMmtpOUN4akUrU3phQ1Vk?=
 =?utf-8?B?cnY2NUEyY2xmdGZENUJGTWNiSEhXOUdmZHZaSVM5L000TGhyd0F6VVp4UXUy?=
 =?utf-8?B?dzZHcFh0c3RvZjFpWHloaWVMajlNSzRnSTJvTjZQb3ZLbC9yQlJKZHl4K2kv?=
 =?utf-8?B?ZFdYVEFlaDd4UzFEZ3MrYjdBZHZOS1lHckJ3QlBYWmtrdHN2ZnVhbzVwQWxw?=
 =?utf-8?B?OHpFM29qU2ozRjYreVZac3VjbFY3VWVWUHZoRTg2YWtaelMxOGRXQmE2SWpQ?=
 =?utf-8?B?UklmSHh0bGVTYkpqSW9QNWhhQVJyMVVaRkFLYm83RmJUZk5BU2ZJSjNUTnNI?=
 =?utf-8?B?RlNIaFd6SGIxdDB3cVB0V3l6SlN3aHJaeWNERUJDem14Q3o3RlZtUUJ0Qlh1?=
 =?utf-8?B?WUVObHYydUJySlZuQlkxakp3TjJtelJCV3BjdnIrYlp4UWQwdVZYZW1kaTlN?=
 =?utf-8?B?cVh4QUJHWE43UVpRYjVmM3UxSjU2ck9NRFI3QS80OGlYeHBHZm9zcEx2UU9m?=
 =?utf-8?B?bjJPWGJ0VWI0LzgrR3FYVlk3SU1FK1h4TnUyd2lmd0h5ME8zUytIUEt4eFdD?=
 =?utf-8?B?bUM0RDhXM1paNW9hR01SOUxLODRFM3ZlZktDSEhWcFBSd2czbis5Wk1Bakcy?=
 =?utf-8?B?STBwWWtuZTBEMFVnNlZMY1FJWkIycUIxYytseWZlaHozdGJJclJ0aHZnNHo1?=
 =?utf-8?B?UHlQaG42R083eWcvb3gvblZPVzk5SHAwL2hKYlVESGQ0c0NjZ3FGMEV1c3ZI?=
 =?utf-8?B?RFlJYzhTYUFqMFdBdlJJTjZpaHRQM2Yydyt1a1VsU1lqY1U3UW50RjgrZE9m?=
 =?utf-8?B?OU1KMTBEb3JadWxTM1BkNEE0a293dmt3WThWcHlSdzkvaW9QZWJGelBHdE53?=
 =?utf-8?Q?yw+6NOuo2UiylXt6H3f/niWq0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5909cd6c-d51d-42c8-0aa1-08dcf417c3fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:36:49.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su+Rq7tEP6Ybwn1JyLwx3amoC+Q6UbsHyGYVWphQOj0Vb/2CO22+3eDwarUwNEuMFJEuB6LQZKaxtmN7Wxsgpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384


On 10/23/24 02:43, Dan Williams wrote:
> When the CXL subsystem is built-in the module init order is determined
> by Makefile order. That order violates expectations. The expectation is
> that cxl_acpi and cxl_mem can race to attach and that if cxl_acpi wins
> the race cxl_mem will find the enabled CXL root ports it needs and if
> cxl_acpi loses the race it will retrigger cxl_mem to attach via
> cxl_bus_rescan(). That only works if cxl_acpi can assume ports are
> enabled immediately upon cxl_acpi_probe() return. That in turn can only
> happen in the CONFIG_CXL_ACPI=y case if the cxl_port object appears
> before the cxl_acpi object in the Makefile.


I'm having problems with understanding this. The acpi module is 
initialised following the initcall levels, as defined by the code with 
the subsys_initcall(cxl_acpi_init), and the cxl_mem module is not, so 
AFAIK, there should not be any race there with the acpi module always 
being initialised first. It I'm right, the problem should be another one 
we do not know yet ...

> Fix up the order to prevent initialization failures, and make sure that
> cxl_port is built-in if cxl_acpi is also built-in.


... or forcing cxl_port to be built-in is enough. I wonder how, without 
it, the cxl root ports can be there for cxl_mem ...


>
> As for what contributed to this not being found earlier, the CXL
> regression environment, cxl_test, builds all CXL functionality as a
> module to allow to symbol mocking and other dynamic reload tests.  As a
> result there is no regression coverage for the built-in case.
>
> Reported-by: Gregory Price <gourry@gourry.net>
> Closes: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> Tested-by: Gregory Price <gourry@gourry.net>
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Cc: <stable@vger.kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/Kconfig  |    1 +
>   drivers/cxl/Makefile |   20 ++++++++++++++------
>   2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 29c192f20082..876469e23f7a 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -60,6 +60,7 @@ config CXL_ACPI
>   	default CXL_BUS
>   	select ACPI_TABLE_LIB
>   	select ACPI_HMAT
> +	select CXL_PORT
>   	help
>   	  Enable support for host managed device memory (HDM) resources
>   	  published by a platform's ACPI CXL memory layout description.  See
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index db321f48ba52..2caa90fa4bf2 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,13 +1,21 @@
>   # SPDX-License-Identifier: GPL-2.0
> +
> +# Order is important here for the built-in case:
> +# - 'core' first for fundamental init
> +# - 'port' before platform root drivers like 'acpi' so that CXL-root ports
> +#   are immediately enabled
> +# - 'mem' and 'pmem' before endpoint drivers so that memdevs are
> +#   immediately enabled
> +# - 'pci' last, also mirrors the hardware enumeration hierarchy
>   obj-y += core/
> -obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> -obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PORT) += cxl_port.o
>   obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>   obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> -obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>   
> -cxl_mem-y := mem.o
> -cxl_pci-y := pci.o
> +cxl_port-y := port.o
>   cxl_acpi-y := acpi.o
>   cxl_pmem-y := pmem.o security.o
> -cxl_port-y := port.o
> +cxl_mem-y := mem.o
> +cxl_pci-y := pci.o
>
>


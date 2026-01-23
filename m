Return-Path: <stable+bounces-211433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMmDD4oHdGmE1gAAu9opvQ
	(envelope-from <stable+bounces-211433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:43:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D07B85A
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDE873005596
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86142D0C9D;
	Fri, 23 Jan 2026 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mr8Gs8Mx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q3VVRDXo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8423EBF3B
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769211783; cv=fail; b=KdX9VzhUP7athsLpkJds5oC3W7HxlL5gtaJgP4Ika5TBWIKRk1e7OFonRLihm4STcKV+Gdr9BxkkjYp4ii/6/BY5lVMhJDB6fcrHiyJ++zBGiz5ttntKEI3gBfXv5EGK1ScqdNtBmxUg85+HOfjxcE5H3LBylCfxLAUbeTyfZuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769211783; c=relaxed/simple;
	bh=krUUjKSG47Z+pjHooGWPBNps2GxMq+YSkEs0EaG+m2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NofmG5Pe62Dw7B5H52LSYusCzbXppCZPGnZ/zbYyWC7k7+YDJULKHJpAGR6b1npMsu5nANntGtmH4iRT+AAuCqep5OCgg/BYVflaIDVVai/9I8UfiIgG1fr+GfSYJQ1QQIbdpfP+U3oppB4jJDNG3BQztHcOs+athM3Q5IQvsB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mr8Gs8Mx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q3VVRDXo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF89ka2270644;
	Fri, 23 Jan 2026 23:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ruyuVFFvdwBTwhWpxjEOhpdf0XCZwMI9yPhy2Hd39Vk=; b=
	mr8Gs8MxsYDkmF3yQQuAAtv2qaDzJ0eFR2I0VyZ6tlKdSV4oQd7dHCnCozE3kWIu
	d+iSf5xtw91qzifsAx0ZG8uTfqwuMgf44Ro5RUV8HaA5he9yfWpWnRd/XkuxwaLw
	t+NrqgAo4/PJu3QTcWtmBkRVRw9Tm1FVtPMqeJv9c759+k0onSvPnQVgbnm3UqfG
	iiBmXGziqx3jxM2wBqKJMwPh9eaFdzaJtCwNgyckx0UW4iwY+TwuK1r03ceLYFHJ
	skv7tMmaV6mNq6dAPaXNf3iIWo6Inq2cu/Z/gySknI5I7XFlh45QQXtpzUd54xLw
	GuKaoEG9N3dWNJhogfODXg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br0u9udra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 23:42:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NMcQQZ035808;
	Fri, 23 Jan 2026 23:42:40 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bux4ywu91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 23:42:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXBpT22speuvA6raIWNp/DkiIcXA2X8Az2flHIkIFdPTVxKtPn6wkKWYU/+Dy4/eKepfud76hu1Ypacqvvigzz2PmbeCeFRk9r9hcuLEcpZfCx0HDpptJD228PqFXn5f1U9OPSgQqe8xdILIJmu1hJtv7GeT+FYKW2jvn7ZZvolu+7+3ux6DAbken4owjkHdgHw/4h+sqGfpY6Rp0SYviotMGkkJl38kyDhAmDl583f+taN7rDazFz0J2MNr7pgvNtoah6/bdd45eiQ86/obCyeeBWbL4IQAHxPFg17vK30cDcnKJVW4skRQ1lguk/vMh9O+IhokbggYa2WGsjm+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruyuVFFvdwBTwhWpxjEOhpdf0XCZwMI9yPhy2Hd39Vk=;
 b=LiemzIAx1uXb8ywlZMmLHDMAsLCm8J8MbAKfxiT/7eHjyGzaP+OspeikkA/zBlgDeYn7GIHibftbfY6G9vIP8rj25v3SeKtD1G5FLx9FvqaMadZQejvpxVYVBoFgDFrmSI8Visrt+i73k9cONgNp8J6L3c3zgcom8lG64aL65G+BOZZDWFQCMj3P8bnk1U2apyEK+sq4Calk1i9zMGVTCxVsLOtbyMLzk3ij5it/fUViiDfKEPz2EBcHei9oeYDwmA5SBsVReJRywHryYEPZyJwRd28urwRxMManc31kwaShPrYhpc6caaGVE4HzPvmyMWPsgpyqEZ2iLKbS2crFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruyuVFFvdwBTwhWpxjEOhpdf0XCZwMI9yPhy2Hd39Vk=;
 b=q3VVRDXoEJ2jn7TVYTB5rj4FrNf2ox3Vv2NV9CzONC7+J2NYl63GiJcM+yARbeP7u2hMB3t0KFppM2/DkP5nSzTtc1EjGFkXagX3NuCojDjBDprHMpULN6qtn0/P9wBumhwk9FBjLBGIzlBA/MsjHYC+SCI5MHvuCfQQxGxRRS0=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by DS0PR10MB6246.namprd10.prod.outlook.com
 (2603:10b6:8:d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 23:42:36 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 23:42:36 +0000
Message-ID: <0286a6fa-d767-41d3-8c61-c0b34e9a9b47@oracle.com>
Date: Sat, 24 Jan 2026 05:12:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Do not allow userspace to trigger kernel warnings
 in drm_gem_change_handle_ioctl()
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
        dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Zhi Wang <wangzhi@stu.xidian.edu.cn>,
        David Francis <David.Francis@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        stable@vger.kernel.org
References: <9bde8c39-ba4c-49c5-a0bc-4e78338f055a@amd.com>
 <20260123141540.76540-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260123141540.76540-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|DS0PR10MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: eb131096-7156-4af6-9f05-08de5ad91644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODF5SmFnWFJIc2V2b0l1NWFTVDduNGRwVHF6aWN4RUI1Q015LzJ6aFdYL0xD?=
 =?utf-8?B?dHFpNFZURDdsOWhYWWZ3RzVoYU9RdWxHZW10SzFBWE1sRzQ4UDVXZDZVdi83?=
 =?utf-8?B?Q3V5amg2TkZaZkNoZ09majM2ejU3NE9QM1BHS0d2QnlHL0NpNHlad1psTEhX?=
 =?utf-8?B?NXJuU1hYTzY1QVZocjFpOTRwWUdsTWxyTkRuZHRWRjN2Q05WN3N4QVNCbnlp?=
 =?utf-8?B?RmNqM1hCRlAxQ1hKOEl4bXlwOHVCejRDL0pPeHdVYTQ5Y1FxZmxNUERqKzd0?=
 =?utf-8?B?VGMwT1NCeXo0M3paYmJOUHE3YXdsdDdaSWlwWFFPT3ZQNy9qN245bW10dEpR?=
 =?utf-8?B?S2MrOElrWGsvUjc0QlZ0QnhVOXhxRTVMUzd2MnZlN1Q4V1BCZ3hpQmRpZHMz?=
 =?utf-8?B?VUhaMmdJOE1qOTdqU2pCYmd2Qzhac05oYUtJNkV6K3BhWHUrd3J4VmdaUkk1?=
 =?utf-8?B?c1NrZnV3M000VzJRbFh2VkNKZWppTFpEbkIrZmorb3A5aXBBcldiT1dmcTlx?=
 =?utf-8?B?NTEvaUR0dGIycXQyZmFMbWtoMTJXTjhKR3l4NmdmWjErNzJuTGhaUmFkNnV6?=
 =?utf-8?B?ZmxpdnZRUUQxS0JHU0gyS1VpdUlSajdUa1Q2eUNyWG1aN3Z1LzJDSDVuaWxm?=
 =?utf-8?B?cGpYNUlrUHYwN012WFltYVJMODh1N0dRemxVbkxUeHlvZEErSUNNVUhNZGlN?=
 =?utf-8?B?UzduanVTa0RUUFdjeVdhSHN1MFVsZXd6SWhXU1ltZHpDQmUrY1crakd5YWps?=
 =?utf-8?B?RURvUDhjN0hjRHYyNGNGYkJJcytwSHlQRVNEUzVWc2xMZjNuTjd4V0QxQVJW?=
 =?utf-8?B?cXZUbWJ3TndQa0ppTUJuRGhORUFsOWRxeDJpSlFzRFI3ZmN5dEtlNlhtVUdh?=
 =?utf-8?B?K1RFNzFicThBamo5UklmYTVTTmp0cUwrNTJHaXR5aVFWSFo5TTZzZ2dpWWht?=
 =?utf-8?B?WXhZV0JBampGeU4zZGpUNk9wTFJzM2xEZkFWYVFWUlQzeFNBWTNFWWczckhK?=
 =?utf-8?B?TFIwK2czd2IrRCtyQVdpL05uRGhEdmprTjM3V3V3LzB2QUpVUkZCYzhISzRy?=
 =?utf-8?B?VVJlK3ZrMThOMDNsWjM3eldWOVdENkxGVU0wT0M3bVBQSDJTOC9aYXUzWUJy?=
 =?utf-8?B?ZEJQTkRKS0dwM3A4V3hCTjZOTjFhblBFVDU5T1paWm1Vc1lFbHZxajBOU2Q3?=
 =?utf-8?B?dUJTYjRiTEN6Y3FGem9NMVdtMTZiUmU2blJzQVdKZUJlV0pqc2JqUFBNNnk0?=
 =?utf-8?B?VlVBWjhEeEEyaXBJZ1pDVnMwTmFaVFZ0a2J4cWJsZ1g4UkpLY0FtTFNiVlhp?=
 =?utf-8?B?VmpUNzNML0dmNmxwcC84bEZ3QVhtQVhCTzBLVXlhSFVuT3Y3TFd1U00zTHR0?=
 =?utf-8?B?ZnhoaDBvMitobnVobEoyN3BjeWZpNTl5dVY0YjdlYThmMGJiUkdaNlJyWHZW?=
 =?utf-8?B?U1h6Z2FuSi9DS3BhdkRLNDNOb2hNSTdSSWxyK0VGeTEzYitEQ0dTZXI5NDVG?=
 =?utf-8?B?YkM2STdoS3R1dDBxbzdsYWdhTGZSZ1h2V0wyMi8rRmlhMU1zQ1EzZU5UTzJk?=
 =?utf-8?B?M1hLeG9tcHhRMkF5Z2VrNlJKRjZPMFdmVkFJamc1T1BpS2JQSEtQeDg2NjV2?=
 =?utf-8?B?eStlWmhMelpFU1M4dlRaMi9DdHE5eEJaQ2w2M2lMMU5Rdld2cnphd25RUVJz?=
 =?utf-8?B?dEJ5M3dLd0NKMDlXUHNNTXRCaFNRK09kVFZlNVVtNDhIR2RxTUdIVVJxZjlk?=
 =?utf-8?B?eXFtMlpCV0J3c2ZmVWwwYUN3RWxJZk8vYkVnOW5WWVFuZDRQWTk1Rkl3MWY0?=
 =?utf-8?B?VnMzL043WHduOVVKVTgyTHl3c1V5OTI4ZGFRanhrZU1MR0hQVmRpNVhKWHR3?=
 =?utf-8?B?emt1NCszRnFIemRYTld5REVYNHIwOXdWOXpCUWVlR0N5QVVHWEpzMXZnSmFu?=
 =?utf-8?B?V0E3L09EU3B3WGFSYlh0Y1M4VHZoZVZZSXdiQjd6dk5Sd0lLMkRqM0JqQnQy?=
 =?utf-8?B?ZW40YzlLN21La3lwV2pmWDBQQTJlZXBjOFVOWlhiTTNOTG9CNWI1dHhFSmJk?=
 =?utf-8?B?b0RJQ3VMN2M2ZUxZbVc5T1lCaTRiS2k5V2lxMm9MSm9vaDBVYlYvLytjSUxl?=
 =?utf-8?Q?l0Cs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDhMSmw2TzBGYnpZMHJudEdVNUYvUUh2NEpFSVF0ZTU5Z2dsZVBXNTlJTE1j?=
 =?utf-8?B?a3ZTZzlDZmlXQTU5RDNYcWxRMWcyTmVib0d4YStnVnd3WG14blpWYTZ2NEsr?=
 =?utf-8?B?WEFRWEQzMCs3aFdiZUdPajVBd2Q2SHV1NXZ5cUZkR2FuQm52bjVReDVIUFYr?=
 =?utf-8?B?M3NYcFBLdkI2dEUzM1dQdHFXQ1M0blcxN3NxZXBoNncyVGw5VE1zSVIvRmF0?=
 =?utf-8?B?S1hCVG8xQ0lvK2syN0kvZFlsWG1yRmwzNmJMbm01YXl3NndjeFhPN3NKMGow?=
 =?utf-8?B?R1E0Zk1URlc3S1JIc3VlZ0paMnZyVHp1aDVyb3lSUmViaGNYU1JkUlByQXFn?=
 =?utf-8?B?S3NRcURrY0dVRXVjUElvTE1kZzRvdFJhVUhUNEl4OEM0ejlJSnpYT0NaUkdl?=
 =?utf-8?B?ZitMVTE5eG95MXIyOFFsNnlhYXZ1ODJsSmR5dEFtVEx4Vm51Z2ZZQjIrQUFC?=
 =?utf-8?B?QU05Vy9qaFk5SUZhS1FCUDJINGpJQTluS2ZsN1lUL3NHUXhNS1NjZjNVMlpx?=
 =?utf-8?B?bC9qZGVuMUdxcDdtSFFIR1VlaDBHbVRhKzRnL0I3OTRIU2cyUlVUSUJpQ0ZC?=
 =?utf-8?B?ODAwWURFMlBkbXdsclAyZzhuVG9XTitWTnJzNlBCN2tSczdYai8vaTl0Wjl2?=
 =?utf-8?B?c2lpOHVuSjFlRGFxNHIwVjBtRzVxYzQ2WVFQb0VJVjlzVUxjdWZNR1lOR0FL?=
 =?utf-8?B?WkdBQkZXMDJBa2tWNTcrTmRuLzNIL2x1WEsxblNVazRIWG5KOGlIMThoeXhT?=
 =?utf-8?B?SG43dGp1U0FqSFc3VDZRZ0luSFV4OVE1NEpyUEJSZUZLZ1lxVmlxQlRhZmNh?=
 =?utf-8?B?L2lrYTN4Q3JodXZCUnFJSEp2eEQvU3BLUlVOUjVYcXNLdkZrR1dpaDJEUU85?=
 =?utf-8?B?V3JwZGt2d2Uvb1NSOHV2eUZwaWxVTkFVZHhBSXpwcGE5QjhQbkp0azB4dWll?=
 =?utf-8?B?RkNtc2I2L0twdHJpclRRL3RSTGdWU0kvNU52dXNCQ0VMQ0R3S01UVzlOTlJ6?=
 =?utf-8?B?K1V1c0RpZ3hrY2YwMmJuQk5TZis4L2ExTUFqMkd6M1E3QWtTYWhyMnNLVjhh?=
 =?utf-8?B?VW1kUU8vRW8wTzM1cCtvK05TenRVbEVqeXpJeTUweGwvM2w3MzBzakZ2cjEr?=
 =?utf-8?B?MDhCU3daWWhRbGlQVWtDWWN1MDJQZ1paaVcyc05uYWlpQkhEMTBweHZyUGVF?=
 =?utf-8?B?dFZyeVRMWDFWU3dWd3BTNHlMOVdlT3NBV1NkbTBKU3dSS2p5R3dsSHI1MVFN?=
 =?utf-8?B?R3A1ekd2Wlk4QklmdjlyTWRldGNoZnI0anRzanpJU0N6NGhhd2hJc2RTdDhj?=
 =?utf-8?B?SmFPNm9Tb3d0ZFpKQUIrcFo5K0dLeEViMEE2YVpubWk1REozOEE0cVFUdjl2?=
 =?utf-8?B?am1WZ3lObDVwV0hWZjlEblJrcFZLaUdPWGYzaGFhYkl6cnZOaU5lZ1RKVTNQ?=
 =?utf-8?B?WmdIMGpCeG9za3ZTUEluUUdEQ0VPQk54ekU4cjY5SHVYS3ZZaHI1RjRmSkZG?=
 =?utf-8?B?cXdHN1l4UWs4bkFZQTF4WWUrSjN6WnNtREVHbFE0NzJLenpUb01qajJsSUsz?=
 =?utf-8?B?dFJ4ZFFrNlgyRnA4dytzbHZndXdweTdsUHUvaVFFa3ZZSEF2eGtHbTFWbk80?=
 =?utf-8?B?bXl3V1lKY01XeVBjYlYveEYrdytmRExMOHJpbXFVUHhoNWhjY2dvWTFDa1Zs?=
 =?utf-8?B?T203cXN2b2IvbytCU0dSb3ZabzVoYXplRFZSTmExQU9xck1iamNuQ09KTmQv?=
 =?utf-8?B?MUxGVjJRYTF4ellmY1VYaEdENDRBK2luUHY1VjZmRTNmbTRLMXdPRzNDeUY2?=
 =?utf-8?B?MlgzMUdWYlhTNmlUcTNxMmI5SVB6MUhiNFVCR0FVdytQM0VCTVhFVjFpaDdK?=
 =?utf-8?B?bnVkRXN3TVB6SmZvbmhxQzZlbmRRN3ZrN1V6Q01NYUFFR2d2V3FmQ1cvOG1k?=
 =?utf-8?B?dWR1NTdrZk5yYktWYVkyYktKQWt0MmFIRmllZkZ1d3hzSi9UMUhXRkN3WHlv?=
 =?utf-8?B?M01UMU81SnRaWlJtUnMyeFFyN0tPQVRXYUJGQUdkNXdmK2c1K3BGMHpoOWRX?=
 =?utf-8?B?U09rak9Mamd3V3hvMzVkVDdRQmlua1NkTkpTcVdwMmRmdHQvZm5YOE41ZkU5?=
 =?utf-8?B?NE9mZGFiVnV4TlEvSFpZa0llMkt0ZzJXTjV3Rm5hREpvUkQrWnlJL085Vll3?=
 =?utf-8?B?cG1GRmI0VFFrZUdXSEZOMHpkREFtZm5aOHo4YWM2RnZSK1NicTZxSkF4ZzFX?=
 =?utf-8?B?dGZOUkd2QVRGZzQybnpsR2xEdlVYbXN0U1Y0T1BoTXR0WnlBWjVnOFlSSVR4?=
 =?utf-8?B?QTJuZVRiOFdjbzZ1Q2x3WmFUcEMwRHVIbUhWUWppNG5XOE5idWVuemE1MU91?=
 =?utf-8?Q?/r5UumNn6z3UeV8t4BWQuh+SZ+zHZHYl7PHNr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sRvSiiXm+uEG+nyh8ih0af35SAS3Qhpo3N3+zvansgxaD8KS0mi48WWXlPjuQyF5aJQgLyMIthFPlN7CUA430ckM+M3I5/Uqjn/k+r0ZdbaJbdTsuN0qQQCm2VcEXgHRE3RV2LL4zU2W/6rAffHx4bRmRXR0tlvXk7J9qzAodiajtZWQhxW1f6QylgoWvSrZ9Nb5l+Cw9pOUXwf3zkoKRUKlfNgxxLMVqTXZF/vwdhXoRTYgadK6Bn/D8AqSZ0gKsDFPkKT873hEm1ILgSEjZ3sN21pu0yBi+DlyWj6PLC6Z/Nm8Qv0fRa53gdRsC7NZcCJ2ujNzvwzxaTyR8P3ynBI2TV48vYLf3EOSsY/PQKqrsIA5GhX31liCwyC1FcEuGMpeo7JJrWYSm4ZJ4GSr/sqfA6DvPIjJinKOfPi+BVcEmuMK5cgEfhorzfcEwm3Yx72WWQuAQaNRijp4vzA8ZaTm5Qhxfge6Ez5SEH6fxr9muqcBFoxSwUh7M4ne+Aljg3OAM60jiYRht63yBWUJ1U7Pu7Wo986AGmZdZVfcq62FmBitQhPHreY/bsHH2u94OMbdYBwVP+WD7IHGqRHddPvdODEE1OviHUeXZrmhiBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb131096-7156-4af6-9f05-08de5ad91644
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 23:42:36.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObdGN3/Xrw0gBrmy+KujBF2Eln/D6/DwWhD8Ek3Y9HpuZzsSRAPfORP34sd08ISTFEo9SZK0WUQgrYxj8orCSH0D4PEEtowI4Njdr4FTQAWEHSF1UDsKtuqLC9jrHnfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230184
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69740771 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=V2sgnzSHAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=mjqYIZQbW5vEZSSA3hMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: dQBlTKaCyPAn4f81j6AWEoUqPhW7bAQX
X-Proofpoint-ORIG-GUID: dQBlTKaCyPAn4f81j6AWEoUqPhW7bAQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE4NSBTYWx0ZWRfX57il1wI7W/6P
 jLrPzGPaXqUP8x52hGWiWro9aWt14roCaUzW7sTc29cWLmPKHLL+T63lWrxTnchNzGSdLeL/alK
 wM06GkbhwPkknRUpxcvzExCjR2MDDvq+UYB4U/omjUNQQ6Iic0W2U1lkg0LRvsN4VeOD5yCgSDH
 ENSZpjz0qSvWYwc9I6d0Fwz43+BEUVFQ1+sG8zjkyJzXqhel+s82oiajNAHbvVOBwEwuplOd4kP
 XtG3SMRbV2/wLpDvH+ig8Wfn8HOsE7bYd8UQXSjF2Bu4nB1Kt0qiCtQ3nrfzbzdRfLoAxYdQfPZ
 pT61RIhTbx5JQkIbXeILNlFWuMQwB3lqqkLbCv1X3AXsvDy5WH8Y2fUM1AaTbC+pJzKQKtjeKqH
 oH9suDZL2nQzl/tf2D1bf3biccgJ+HpHXEw/lOlR0Hp/KdJytf+jES5gpI4X78uIUiYKmw+BXmK
 5nWA3E2+uRJmjFN4aQQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211433-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,igalia.com:email,amd.com:email,xidian.edu.cn:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CF9D07B85A
X-Rspamd-Action: no action

Hi,

On 23/01/26 19:45, Tvrtko Ursulin wrote:
> Since GEM bo handles are u32 in the uapi and the internal implementation
> uses idr_alloc() which uses int ranges, passing a new handle larger than
> INT_MAX trivially triggers a kernel warning:
> 
> idr_alloc():
> ...
> 	if (WARN_ON_ONCE(start < 0))
> 		return -EINVAL;
> ...
> 
> Fix it by rejecting new handles above INT_MAX and at the same time make
> the end limit calculation more obvious by moving into int domain.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: Zhi Wang <wangzhi@stu.xidian.edu.cn>
> Fixes: 53096728b891 ("drm: Add DRM prime interface to reassign GEM handle")
> Cc: David Francis <David.Francis@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: <stable@vger.kernel.org> # v6.18+


Thanks,

I have seen this WARN_ON as well and I have tested the reproducer 
against your patch and it works.

So:

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

A question below:

> ---
> v2:
>   * Rename local variable, re-position comment, drop the else block. (Christian)
>   * Use local at more places.
> ---
>   drivers/gpu/drm/drm_gem.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 7ff6b7bbeb73..ffa7852c8f6c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1001,16 +1001,21 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>   {
>   	struct drm_gem_change_handle *args = data;
>   	struct drm_gem_object *obj;
> -	int ret;
> +	int handle, ret;
>   
>   	if (!drm_core_check_feature(dev, DRIVER_GEM))
>   		return -EOPNOTSUPP;
>   
> +	/* idr_alloc() limitation. */
> +	if (args->new_handle > INT_MAX)
> +		return -EINVAL;

INT_MAX is allowed.

> +	handle = args->new_handle;
> +
>   	obj = drm_gem_object_lookup(file_priv, args->handle);
>   	if (!obj)
>   		return -ENOENT;
>   
> -	if (args->handle == args->new_handle) {
> +	if (args->handle == handle) {
>   		ret = 0;
>   		goto out;
>   	}
> @@ -1018,18 +1023,19 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>   	mutex_lock(&file_priv->prime.lock);
>   
>   	spin_lock(&file_priv->table_lock);
> -	ret = idr_alloc(&file_priv->object_idr, obj,
> -		args->new_handle, args->new_handle + 1, GFP_NOWAIT);
> +	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,

handle + 1 here would cause a signed integer overflow ?



Thanks,
Harshit
> +			GFP_NOWAIT);
>   	spin_unlock(&file_priv->table_lock);
>   
>   	if (ret < 0)
>   		goto out_unlock;
>   
>   	if (obj->dma_buf) {
> -		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf, args->new_handle);
> +		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
> +					       handle);
>   		if (ret < 0) {
>   			spin_lock(&file_priv->table_lock);
> -			idr_remove(&file_priv->object_idr, args->new_handle);
> +			idr_remove(&file_priv->object_idr, handle);
>   			spin_unlock(&file_priv->table_lock);
>   			goto out_unlock;
>   		}



Return-Path: <stable+bounces-200096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B6CA5D0C
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E907300EE71
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8C1D130E;
	Fri,  5 Dec 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H8TuppZF";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L+Eko6/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oP+sZhA5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A97196C7C;
	Fri,  5 Dec 2025 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897533; cv=fail; b=TcSIoecIEnboeDLdJJMC4kfV07wcTLsN0Z7QD1SdDYTb8pm4KFG1BeSguGZx0kbVFcwy2BKnREmSU6uKNennTYkj36rw3gEwEj4HJKO54eyDRArnM0NtTaCRuhdhI+Fl2DX0d+s4T3epkQ9FMp0K0LcwQ4Yx4xoamdo+r7eoC+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897533; c=relaxed/simple;
	bh=p2fb5VcwzK/sxCwtrZVcIY3yZSWEJi/jsI5u8rt9bnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCUGGsNW52i/RDiorNeiH9DpKeXJrOlxc/P3oUPye/+dljwoYpvZhEWenGxZd40LK8Sy28Z6P9xDGIVi7Y1ZfSJ02UUAVsXvClJ3TfdH8Y14SkUu9qXHeWZEv5upOKmiJc/cjhouSndCW/XAuLVfPIOxYvaRYxr3SOgEU0va8IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=H8TuppZF; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L+Eko6/J; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oP+sZhA5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4JfdU13490798;
	Thu, 4 Dec 2025 17:18:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=p2fb5VcwzK/sxCwtrZVcIY3yZSWEJi/jsI5u8rt9bnE=; b=
	H8TuppZF8n9MoWCxtRPggQXOgnArGR/AO78J69fVLwxOSavOCLiXEIRcBRH6I+c1
	yGPCNV4ngjX/2+rHVRR6JTDaelcmRh9QJYzWIhyuw+PuXdd3OaemG/BgoxkKpZ9t
	6JaYs6hZg3GFMYrFg2bfwyjQEQGDHm4o7hcyN99iDkToVi7vEFbhMW8zIzJ/nSlH
	rFdrfCfiywNN0bvI63yc5c/KBqiu2RWTuIf/EY35zjHPjZ/0WtRgyShmBX8ip3UT
	p1vwSFV3wjsXnQbzB4m1uCSEXcQpdQeKdHb5KBi4qbd21PHX0VyEm5uGSDVft8F/
	R1yd+mu7WyOZzP7iTX017w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4aucr9amw9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1764897518; bh=p2fb5VcwzK/sxCwtrZVcIY3yZSWEJi/jsI5u8rt9bnE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=L+Eko6/J29ZUMNwxYAsQeKaZxNUTQEuvzFIpx7fG443QdEWqeXrrp0CXsuc2e5UVz
	 S8lzk4nS5rL2nW156D+Ga44wgtYKMGj3XL4VyC5B42JOdEojrjognDYdAmdbeYgqrR
	 UVjqsNzmGDXA4vjcK8CwBJN79jUBDDpe/2moLcukc9bL5cLatn4IdzeJ3BcW8GTpbL
	 Af7XUs6c3/wKujAC6PsS2OitB4+LmLeSBlAVykpyX7gHHxRlpRe0KSKjbR0/PAcF3U
	 ZMyWlAX+TMGdgV/9rnaOcJcSGsIIoW7SmnoqOfUk2ypFZ4VWVD7vGemYQYpKR6qO7l
	 gmhlkWqyyOcVw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B5B6840343;
	Fri,  5 Dec 2025 01:18:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 06665A00DB;
	Fri,  5 Dec 2025 01:18:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oP+sZhA5;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00603.outbound.protection.outlook.com [40.93.23.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A49AF40992;
	Fri,  5 Dec 2025 01:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZlQEXwwHRao6gKKvU2Osy7IrLSWhk5zcgVONumtVVEPmI5FrX5yxN9wYeFYgUlYDNA4OspFzUs4uOAok0zibYOhqaHfiulyO7UU4sCP618+V7ZAAY5zgyJezjFZqG1BJelsEXJqgbttiKKGgIxiUW4kCw7AjvtBNKBoATkluvd6QiATUQfldBgak+LcZ8oVO1wg+uwJUOB1nFonnrQICan/C0/0EVNyUt2crKCyeVBJcNggFA+0qytyhdq4jjKRffjrn/1diy8ODyNCy1AM+1HlFBc32g4GBsWIodivCv67Tz08zTkIUNWRf8debM9GcFDB+1dq9JpxmD4Ej4aX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2fb5VcwzK/sxCwtrZVcIY3yZSWEJi/jsI5u8rt9bnE=;
 b=RErQsY+njtLmGCsIVrtPaSLO+050t5QES6OMjITt6bRaL9WwQEG22Uk7aALtHjp77kYOprh2KVWgR+M5AZQdW5PucrgEdXEBfddipqs5ELY5J3Q+8jhMq8csXI9EjWp6Hq/IRYwFS8c5QM50+BVfidRNsWqyQBaYlcqc0tEXJJJWbu5eCnWxg8xCyv5fq1uGaIlYJ4w6BmGtqLGwm4s3LDJzyVD/s6uknsYpWmBCRIhd19/Uw2XBkaqq/3xE+zsUFIO6LKZnKRqyzQX1+O7PHydJ0C8nTNwnUZcgfR86JzcIFqa4t987LsWdljdllEsXcGVWcnDj8qUHTQ8fUGnNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2fb5VcwzK/sxCwtrZVcIY3yZSWEJi/jsI5u8rt9bnE=;
 b=oP+sZhA53MTNSi2YkOdeNG8pvDVDZzQNF3fLRtt1t1z9oX7EJ9AyR19oIsUC+xpBUcMySwNdXeO9j4LYsLauZxhSyHazzgvLsfdh1ERgRMnnVM0yczaAf/ZkcGUA3TIhW1Ym9wbmAyEmlQg8jCB6Z8vpUHRSeeWEZG/buUJAIvA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 01:18:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 01:18:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com"
	<jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com"
	<akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgAgAAM6ACAEwJnAIABVnmAgAC/OICAAL5tgIAAC3WA
Date: Fri, 5 Dec 2025 01:18:30 +0000
Message-ID: <20251205011823.6ujxcjimlyetpjvj@synopsys.com>
References: <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
 <20251120020729.k6etudqwotodnnwp@synopsys.com>
 <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
 <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
 <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
 <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
 <CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
 <20251204015125.qgio53oimdes5kjr@synopsys.com>
 <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
 <20251205003723.rum7bexy2tazcdwb@synopsys.com>
In-Reply-To: <20251205003723.rum7bexy2tazcdwb@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9128:EE_
x-ms-office365-filtering-correlation-id: 2ca6e251-1f07-454c-48e1-08de339c338a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cURDd2VCTkxhc1NVN1h6L3NNK2ZZOWxVOUtzaU9hWkpZa1BnTE5hczVJTjBV?=
 =?utf-8?B?dHFYYjFGc2l0alJvTXlabmtTT3VmR2w5Wjh4MlprOGJhOE5UaTFsYml4NHFT?=
 =?utf-8?B?TFdCWVRibmhHOU44amEzQWM4RUVoeHh0Qk9URXNMRXBvc2pGUGIwenlBcUIz?=
 =?utf-8?B?Z1VCR0ZiQ0Q4Q2huU3diU3dDSXMwTU9mOGdDVjVTdFpCSTNoc2E4YTJDT1lB?=
 =?utf-8?B?NlpKQm5aeTJyQ0NKSzJMVVBhZ1JKNTlCamY2VURqUHM5WDEwSDAxdkE0WWc5?=
 =?utf-8?B?NVAybXI5Y2hoR05keGN3cjV0YndtZkRkbCtJMGxieWtZajZ2OTJtVldZa3VZ?=
 =?utf-8?B?TjFLb3hwbmRkQisrTy9Md1NyUi9ndmk3UmVPbCtMd05EaXcwNHVrbWkzN0JN?=
 =?utf-8?B?Y3F6MXBTM2U1bWdPRFZvQnRzM0IxbjZudWdweTVxL3VUZVU5dUxwbjdPTmFl?=
 =?utf-8?B?dkRnQ0IvNC9qOWRCTG5CcjBpV1JINUZoeWEyYVFlM1c1YWliajIvbk8rUHNy?=
 =?utf-8?B?ZW1SSjgvcGc5bzBQYm92TWZKMU9IYzM5OGxYUWxJYlRGR0k1Mk1uZHFDUngx?=
 =?utf-8?B?UGE4eldueDkrRGhFUXZYWVNvV2hIS2xkYUtRODRyQy9VZzNEUTZnU0lBaTlw?=
 =?utf-8?B?QkRmNHppU2g3alhlempLOEpuaXRQRlJuTEgxamhlU25pa1A3bDVJaTlPd1dI?=
 =?utf-8?B?cUpoNEhyaENmaDRieW1DbE11TFZXeG9PTzhmRFRuRDNOR0R4bGFoQnZQYU9l?=
 =?utf-8?B?VElIbUpsNEFyeUZFbys3K1pudWVhZ3Rid2FiMjkvYlowNGg1ZjhMT0ppNmRq?=
 =?utf-8?B?dXhCM244QnByYWJNOHlIWWFtVzIwU2wyb1JOV0syY2pTMURiWEtjMTI3NWs0?=
 =?utf-8?B?U0Foa0d5L0ZVSUZwRHNERE9jSTljN3A2aDdZTWRkeXhCeTNOUnhhaE5nczJG?=
 =?utf-8?B?TzZmUFR5OU12bytaTnZJVUxCUzJqK0ZLaG4ybUMwbTcxUm5LL013azQ4T1d2?=
 =?utf-8?B?cUJ3bitnRm5iaHNDWDdiTWVWYUtLK1FUa3hTM29jZ0NFcUVJSk9oNDJFdFlq?=
 =?utf-8?B?K2hVMmJLVmUzYkRVT3U1NUY1Z3BzWnUxcDJ2UzJmQXRNakNOK1F2UVdLaW9B?=
 =?utf-8?B?T2czSTU0V0ZsZ2NrTUNMQUNKbnBHcERiSitkUnllalpUWjlvOU5OQys4QTNF?=
 =?utf-8?B?TzhubWd6Sjk4NVF5OWY1V0ROUHJsd1Zha0tTMlViTmtYRE9sdkhuUm5WK25I?=
 =?utf-8?B?UW8rRjluZnR5cEZqcGZPdlZsY2JsMDQ1cXBnY2ZSdnpBd0ZqZkJPL2pJaUtt?=
 =?utf-8?B?ckxQZmlwVEVBajdLazh0am5Ea3BwNkgraVJmNFJiays4SDNqM0hwZk80bWsv?=
 =?utf-8?B?MDFSKzE2SlJhanF5eXdvUExXcW9ETXdUcS82R0tIZlN2SGJOVERHU3pNMFFW?=
 =?utf-8?B?UWZ1aEV1LzBQWjdhRGxhTUYzY0RJSWVYbnBjLzhTbTk1OWo3Ti9VU0RIMlBy?=
 =?utf-8?B?V2NBbnVEcHJQamZRUzd5NzBpRXFQRzVNSSs1S1NHRlR0QkNEbWNSUWU5dzhs?=
 =?utf-8?B?NnMvbzBmS3NHRkxPbm9yOVhjSWMzdTc2NE53NnZjZXNobGc1VFkyeXZ1YklS?=
 =?utf-8?B?WUVmQTVyS0F2YjZFTHhDdSs0TG0wNCtPelhqblkwU1dJN2x1d0dIWFJPZjFn?=
 =?utf-8?B?MWVnRStrMk9WTTRDZDdjODhMcEtCR3RQOHFvdk16aUxTd1BCbTJiTnp4LzZv?=
 =?utf-8?B?UEFLYUkzNjRTQklMSUo2ZUVpRUIxQ2F6dm40Nkh1YUNUS29mb1NPYWpUZGhn?=
 =?utf-8?B?WWNGbzM4cGJ6N290U01SSjFoWE4zWkpPNkxHN3VKa3E3dnJOV0U1WFYrQkl5?=
 =?utf-8?B?RUxLbHVwTEJqeHVSOUxIaUlrWW1CS25DeFNTWWhNZHcvQlJRT0ozWHltbkE2?=
 =?utf-8?B?SXR0RmhRelFjWXBML0Y0QktySGN5Q3RGOVZsZUNPdW5tTHhLVDhNbWcvQTRJ?=
 =?utf-8?B?c0VHV2JXQXlaTGpEWkYvKy9IM2dUaHRrTzF4U3kzenNPMmxVNnpaNU5PQmhD?=
 =?utf-8?Q?1dtNlf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlhSbytVdEI3TnJ5OStYdm0rUHFGT1pxaGlxYjd0aDZFNU9wUHVUck41WG5H?=
 =?utf-8?B?TzZ4ZEN6Yyt0VytJSG1IN0xzQXFoc29lSkJGM3ZzRkJORzdoVlFSa0xudGda?=
 =?utf-8?B?a2FTV3V6citnYXM0YUdoamIzVWxJYTdBWE1heHFVQ2V6UFFzcjVQRTY1d015?=
 =?utf-8?B?d1dhRFA4cnFSUUk0aXRWbGw4eXVJanFzZU5KYVN1Y1puNXdQT1k5aFBMUWV0?=
 =?utf-8?B?cUZsbk9kS2FQT3FXRFNzbFZxM01BUEFDaEUzbmlJV0NFckUySHVUeEF0NVlC?=
 =?utf-8?B?SStJUmFXVGhwK1lRdWZ1MmZ1bEp3TlE2VUFOS1JrKzR6bFppQ1AxSElYb0V1?=
 =?utf-8?B?RnNKUVhzU3VkenFCb3AycTJ5RUtVUDdOeXRDRUcxcFJEdS9JUW92Z1JHU09u?=
 =?utf-8?B?VzU2VmgwZWltV2l5K01NTG45c2VMUU43MXJ4NmhwUzdUMndMb012Ri9lbjVv?=
 =?utf-8?B?cksxZzV0VndiR2xvVnU0WUJPS2RWMUQvY2Z2RXhMUktYVmNtOW1JWTM2d202?=
 =?utf-8?B?eUlrZjVoTEdIRUJuOXBsZjVrdmNLaVJURXZVRGg1RjNSQWk2dGE0TFQ3dzk0?=
 =?utf-8?B?dytpcUx0QlQwdWhVVHRpOWN5cDJaWmIvSUlzOW1heUxXWHFRWnZYcmNJWXov?=
 =?utf-8?B?Q2tLYjdpUDRmdHRYVWVqRnlzbmVFc3VpOTI3dysybDkvRGVmSXN2Qm9ENExq?=
 =?utf-8?B?UDdjVEVJK2hIRS9kYTljTlBBRHk5REVORWJZTGcvSElwL3RQNjNmS1ZRTFU1?=
 =?utf-8?B?cjl2dlc5TGw5V1owdVMyS2poUnUxNEQrNFc3WmJNVThKamhCbm1Ibmc0Uldr?=
 =?utf-8?B?LzBrc3dIV2tKVEpxQWJRWGlWbDc0N3V2N0NlN0hZNzlxL3hxKzdoYWhNRHNT?=
 =?utf-8?B?SXozT0RXRDQ5MFRObE1nN0IxWjgwczlyRGxFZUlodVl2VkN1WWgrQWdaSmNN?=
 =?utf-8?B?N0hhVmFVbDNYS3FpK1JZdG9NeTBFeEQvTWNndUNPRE5BK0RSMTY3ZW83S1BL?=
 =?utf-8?B?VXV5aldaTjBDZEhFYUt0MlFqc2dyVWRqRUtsTm1uWVplYURsVURXbmVsZjJM?=
 =?utf-8?B?T1NublhSSjFzeUJNRFRiM3RFZjlQNjZ2RnAwTDQxM2diRndoZU1SUThoV0NB?=
 =?utf-8?B?MFR3ZlNQdHU3L0NaS2xtMFhCSzRZSjBIV2pqS2g2V3pGWFZITHJZeEdmWk15?=
 =?utf-8?B?dDVkS2lQQk15bXJYWElydXozWXNUY1hQaFFxdmdOQ3RsaXpxUzI5NkhCSWpa?=
 =?utf-8?B?RnM1UzU1NFRHK0tYZm5vWjJLWTVaZGE4Q3RkZDREdVdFRkpzNm0zaU9RT3pj?=
 =?utf-8?B?T3pKa0E0SUQwZTFsQlY4VHFmU3VoamQySDRuQThEenRPWDA5R3FqaDYwRFQw?=
 =?utf-8?B?RTdjUTlHckdCSHpBLzl6Slp3dUtKc3ppVWIwV0NSMTZZdHQvTmZoV21aalI5?=
 =?utf-8?B?eFBFc01FVnlBNFlLM0JQcEZYSVpXYzJFQ2RWQXVxUWQvVmZzYTY3RUJNTWJM?=
 =?utf-8?B?S1M2ZjJvVVQweG5oSjdDdnRCaXVHK1Q1SkVCMENQWkpDVTJrakIramhyM202?=
 =?utf-8?B?U0F3a3c3cGU0NXMwWmNONXU1N0h2Y1hUNWhUbk1rdVZuZHN4eGJEcUkzbmxZ?=
 =?utf-8?B?akpJZklYd2UramdmbkQ0ai91TWxUTmF1bDZGVzVZenU5NERmRU9pTUtaYkxX?=
 =?utf-8?B?bk9kQjBzMmR1aGJWMklRWnZ3MzdqNWNGQTRqMnQ2d1k1ZHJWaXhBUmhPcGht?=
 =?utf-8?B?dStjS3QxdzJYMUNpaE91Kytoay9TTG40aWxZUm94NDdZRzd2WjJnMXIybHlL?=
 =?utf-8?B?am5YZE1xTlp4R2RaKy9UcCtWYWhpWXBQM0FNWkF1N2xDcFBIRGx0b3g2WDdr?=
 =?utf-8?B?eEo5YlNEUXRLWDdZMitUOWJhY01BUTVxNTJFb3BaNFNCR29TVElucDIyaDQ3?=
 =?utf-8?B?b0FBR0ZMYTI4QkZzYlBFWkNOd3QzNVk0S2JjcWY2RzNxYlpjVWlKVDB2QldZ?=
 =?utf-8?B?eEEzNExTMElRbWl5eHl4U2pSVVVKK0dqSHVxUVByZkt5cEpibVZRTllPNktS?=
 =?utf-8?B?NDRadzZESUI2V2RVWHBUUUJyejJmT2tLM2JuR3pnbS9UZ2lpaGxwNG9VbDRE?=
 =?utf-8?Q?KbMZ0WccEhaf8lOZ/mwr3zvcp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F080559547CFEA4499FFBA584815F0B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tyvYHAK++k2cTbvF85ZmdjqVSudmjaUaQ7H0ZYWoTaf32Bf7VPLY4MrYgny1RDwX/sbJA07SepnhPCkQVqF/kqmkscFpAWzwKK6uaEqS1pA6p2orVz6gs9DNt3gRYYkeWHtcbldGFJvjew63aAPHxoBVOKJxQNiy46mqPW4SoiVMWobZUod7DP0f+ui/J4hrlk6KM2vTNOToJK4RpUwMWbMRBhXdA8sz+hiMIuIaPcyF5TOlaGo30+C5MRk2H7pMxoS72R2Rup+LFhksX8RA/gVuzc8hf0HM+ADOsWUkj7nYSaYbz8jw8j6OZRMX1mLMKf7+yA9p237vwmYWBqvdwbijpARPF34pgSf1Ositf40mI3KFczz+pllB7md1N5wtyCp5qJ3rcO4KTDf976E/0uE00XsYED/u7NYM91ECDACoKnfvsIpiVpK/w3oxARX+Z1ClHJGqdS5FGzl/cr5YVVaefRvWZgrlMd86UntMtjjPSm5U/1iVJCu+oVxxskvmZkIf74qkj8Nu8kOHMWmiabQuynLqOjF6aU8y7wRaC7rYCAo/LveTHriTwuQZr/rSOJ4vXsqCPNyIPZCw6GCk0WsJ1An3HC6OeFZgRmGxtkUvrCrDVSp0yfIofNrZrl5uzpvYeuLiCwcDk+YXOttk1w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca6e251-1f07-454c-48e1-08de339c338a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 01:18:30.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T33fIInVUgXJ7X7L1+lRIYPbhQGFUHgUa0YXQ07B6hWuhVcirXDK0QJ/8NKNHJjkkQRckjEdroYDjuNglZg+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
X-Authority-Analysis: v=2.4 cv=EeHFgfmC c=1 sm=1 tr=0 ts=693232ee cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Cw6nzIPcP0VYEUOisU4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nSPMCILHaRxXWAIOrey-qTk5MeI3oVPu
X-Proofpoint-ORIG-GUID: nSPMCILHaRxXWAIOrey-qTk5MeI3oVPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAwOSBTYWx0ZWRfX+JyXpRIi/me+
 ux16vs5BlEQTcqZtPbwPOcli/rT5mIZZI60X1RXuk9b9/IAVewdzDxDhegJ0ilQvzWvywiUgbuf
 EsZMgM1Io1cy/pGtVDsi+6tMNmwK3Fmo4kVWlTsNH/dMBp/uegqNrJB/ZuMtkIN0iAXrAdzKfrh
 ZD7jDuvzrrDuVuibcqcSFw2nGk5BEPgkS53uyS25ScoVOiiQ5FNAV1vnyeXNvNypkO/rO0deKUC
 JLtIX3iaQTVR3+dtmN7yfjSJHyqnjprpFU/NEcCbBbEMR0L/XqSrNsWRJyrgMoqpcVx+W9bG8DP
 rVlbxw6/+xf8gplWS+pO+3dvdWSqtPeMVpvV2F4nzWjXfI7obnLX3ydZQ4jE3dDc2u3XNd8pamH
 LWPX41cgVeYQtL55shRG5lUsE5Mqfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512050009

T24gRnJpLCBEZWMgMDUsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MDQsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+IA0KPiA+IE9uIDEyLzQvMjAy
NSA3OjIxIEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gPiBBdCB0aGUgbW9tZW50LCBJIGNh
bid0IHRoaW5rIG9mIGEgd2F5IHRvIHdvcmthcm91bmQgZm9yIGFsbCBjYXNlcy4gTGV0J3MNCj4g
PiA+IGp1c3QgbGVhdmUgYnVsayBzdHJlYW1zIGFsb25lIGZvciBub3cuIFVudGlsIHdlIGhhdmUg
cHJvcGVyIGZpeGVzIHRvIHRoZQ0KPiA+ID4gZ2FkZ2V0IGZyYW1ld29yaywgbGV0J3MganVzdCB0
cnkgdGhlIGJlbG93Lg0KPiA+ID4NCj4gPiANCj4gPiANCj4gPiBIaSBUaGluaCwNCj4gPiANCj4g
PiBUaGFua3MgZm9yIHRoZSBjaGFuZ2VzLiBXZSB1bmRlcnN0YW5kIHRoZSBnaXZlbiBmaXggYW5k
IGhhdmUgdmVyaWZpZWQgDQo+ID4gdGhhdCB0aGUgb3JpZ2luYWwgaXNzdWUgaXMgcmVzb2x2ZWQs
IGJ1dCBhIHNpbWlsYXIgYmVsb3cgd2FybmluZyBhcHBlYXJzIA0KPiA+IGFnYWluIGluIGBkd2Mz
X2dhZGdldF9lcF9xdWV1ZWAgd2hlbiB3ZSBydW4gYSBsb25nIGR1cmF0aW9uIG91ciB0ZXN0LiAN
Cj4gPiBBbmQgd2UgY29uZmlybWVkIHRoaXMgaXMgbm90IGR1ZSB0byB0aGlzIG5ldyBnaXZlbiBj
aGFuZ2VzLg0KPiA+IA0KPiA+IFRoaXMgd2FybmluZyBpcyBjYXVzZWQgYnkgYSByYWNlIGJldHdl
ZW4gYGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGVgIGFuZCANCj4gPiBgZHdjM19nYWRnZXRfZXBfcXVl
dWVgIHRoYXQgbWFuaXB1bGF0ZXMgYGRlcC0+ZmxhZ3NgLg0KPiA+IA0KPiA+IFBsZWFzZSByZWZl
ciB0aGUgYmVsb3cgc2VxdWVuY2UgZm9yIHRoZSByZWZlcmVuY2UuDQo+ID4gDQo+ID4gVGhlIHdh
cm5pbmcgb3JpZ2luYXRlcyBmcm9tIGEgcmFjZSBjb25kaXRpb24gYmV0d2VlbiANCj4gPiBkd2Mz
X2dhZGdldF9lcF9kaXNhYmxlwqBhbmQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQgZnJvbSANCj4g
PiBkd2MzX2dhZGdldF9lcF9xdWV1ZcKgdGhhdCBib3RoIG1hbmlwdWxhdGUgZGVwLT5mbGFncy4g
UHJvcGVyIA0KPiA+IHN5bmNocm9uaXphdGlvbiBvciBhIGNoZWNrIGlzIG5lZWRlZCB3aGVuIG1h
c2tpbmcgKGRlcC0+ZmxhZ3MgJj0gbWFzaykgDQo+ID4gaW5zaWRlIGR3YzNfZ2FkZ2V0X2VwX2Rp
c2FibGUuDQo+ID4gDQo+IA0KPiBJIHdhcyBob3BpbmcgdGhhdCB0aGUgZHdjM19nYWRnZXRfZXBf
cXVldWUoKSB3b24ndCBjb21lIGVhcmx5IHRvIHJ1bg0KPiBpbnRvIHRoaXMgc2NlbmFyaW8uIFdo
YXQgSSd2ZSBwcm92aWRlZCB3aWxsIG9ubHkgbWl0aWdhdGUgYW5kIHdpbGwgbm90DQo+IHJlc29s
dmUgZm9yIGFsbCBjYXNlcy4gSXQgc2VlbXMgYWRkaW5nIG1vcmUgY2hlY2tzIGluIGR3YzMgd2ls
bCBiZQ0KPiBtb3JlIG1lc3N5Lg0KPiANCj4gUHJvYmFibHkgd2Ugc2hvdWxkIHRyeSByZXdvcmsg
dGhlIHVzYiBnYWRnZXQgZnJhbWV3b3JrIGluc3RlYWQgb2YNCj4gd29ya2Fyb3VuZCB0aGUgcHJv
YmxlbSBpbiBkd2MzLiBIZXJlIGlzIGEgcG90ZW50aWFsIHNvbHV0aW9uIEknbQ0KPiB0aGlua2lu
ZzogaW50cm9kdWNlIHVzYl9lcF9kaXNhYmxlX3dpdGhfZmx1c2goKS4NCj4gDQoNCkFjdHVhbGx5
LCBuby4gTGV0J3MganVzdCByZXZlcnQgdGhpczoNCg0KYjBkNWQyYTcxNjQxICgidXNiOiBnYWRn
ZXQ6IHVkYzogY29yZTogUmV2aXNlIGNvbW1lbnRzIGZvciBVU0IgZXAgZW5hYmxlL2Rpc2FibGUi
KQ0KDQpSZXdvcmQgdGhlIGltcGxlbWVudGF0aW9uIGluIGR3YzMgYW5kIGF1ZGl0IHdoZXJlIHVz
Yl9lcF9kaXNhYmxlKCkgaXMgdXNlZC4NCg0KVGhhbmtzLA0KVGhpbmg=


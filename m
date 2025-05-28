Return-Path: <stable+bounces-148004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C18AC7291
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 23:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CAC1C013FF
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C420212B3E;
	Wed, 28 May 2025 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nMVCqIVm"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645A6AD3
	for <stable@vger.kernel.org>; Wed, 28 May 2025 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748466587; cv=fail; b=c1YjRGnhHQyRxiMQ2w8P+OUUmXUj5D7nLN9hua+qL/G21KWY4t9dy3uZVnHRKz4mjDSqCtkzqa10Rb9kayDlH2WAchJqV7LgBFgBS+wR+OAkw9kEVhQlNHwBOflIacFj9NHsTewWNcOM8Ec47WawHeuoVnuzBfU73C2bkAdHMNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748466587; c=relaxed/simple;
	bh=emga9UwS9nTA8iAuQb1t4OHJ6R+5ZjsA0S+DYlCj5TU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hzRFSfdwIf05xhXojkqN/tJ5EFW2CThuxa+EHL3//0fTPcf44UwpkCCtEL8JNYatWSDdCvUadohsYZJBp+lhXqwgPM94P3bD5ZfbAO3TstSWOW9r1JCmVvsuy5Dvdu1FmlXO3z34n9/GK7KJcKgKDkQI5U8a2oUiorxVsvWghAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nMVCqIVm; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avhNCRRi3J5b0blQqXpvanUCRITR1ja+cTK+wDYDitd/Q/07MbMpdAiZuin8PCvXuMjZ2AfErh1ct7d5dPxrcO3N0YvOqfI1tolsTkqOJn4g6e5mwuOtLGxQ925/bPlESfrwsASTBAAHRuwyp3NjGTtrtuHa38O/MQBkXFTxx3KPkTFffwa4uKfrOg9sFAhchWg1IfuY9JTxAareNICF7ZWUeANQ+OXmyCOSh3LjL5cd9XkW8BDyiQW1Phu7qBOR4eSO1TsbSAa7v8p/mhxlWS27d/zwvA2LWxBVpODUfcur6akloy9ll836vbFSQ6FHazuc6YppnLfzcbYMi9KrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emga9UwS9nTA8iAuQb1t4OHJ6R+5ZjsA0S+DYlCj5TU=;
 b=jKUrvj7vHIin5zSAt76PMBXyCrhZtvyMz4XXIK6GNgtiBqQovuYgQdMTep8FlmTzDqQ9/rkVcVj/il9T05uduPSpmcuT1EgqRXt0umCSez1VzaByB4yAhterBkCxn/30ObA1SUE04hm3DbHQJU7YXzJyzcejcUNmgaZZpvEPajgZIRY4rGASlIBRWysC+aQyvkZE6Rn+0jsHj1GIEa0T7a0NHZA6362L/dGTnmWLBmc2EixfduFr9x2Lm6TbA3+mVgQgXKzsenqg7nQAVbB8q4mukvpkN/sNoob3VTrOFr8c79A3F1r/s9wvKWtYM/LIwm+vrbk4Z5qJ0jl9dPEo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emga9UwS9nTA8iAuQb1t4OHJ6R+5ZjsA0S+DYlCj5TU=;
 b=nMVCqIVm/vTxfTjgndPREnQZdeMvqteIZOupf1L3VlcJTgv2dV1FE3F0Io/NhKhP1qyK3kcV3Nay+nHRzOAePohwGylMDv3JvmdWk5Z1X5drMh9CJoU0iDyoRU/8eAxT+WSXSXOh0LkAsvsKqxQcx/TD+sHBaZZVtFs6/IeKuu4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 21:09:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 21:09:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Rainer Fiebig <jrf@mailbox.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: 6.12.30: black screen after waking up from hibernate; bisected
Thread-Topic: 6.12.30: black screen after waking up from hibernate; bisected
Thread-Index: AQHbzBx6VYF7tJnCBEqvRymxGO9i+rPokTQQ
Date: Wed, 28 May 2025 21:09:42 +0000
Message-ID:
 <BL1PR12MB5144454EC2C17C206CC68992F767A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <884d3e56-1052-0ca0-2740-f597ba7031c1@mailbox.org>
In-Reply-To: <884d3e56-1052-0ca0-2740-f597ba7031c1@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cb8f98c3-702c-49bc-87ee-fab014dee582;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-28T21:09:01Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: 2dad7d89-9e65-4459-6a92-08dd9e2bf6fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1ExSy9ER2VBRHRpeXVmZ2dweS94b2Z4OWZvMXRrOVZ3WXZ5ZU9UNSsvUkpn?=
 =?utf-8?B?TVZFTmhsR0JaU3N3bURMeGZpRnZHZEliU0F6RGp1aEtRWUFIMXF3WEFFN1hT?=
 =?utf-8?B?cm80c3M2dWsyaUt2V1JMSmxRaVhkM25QellRenlGQ1llWCtldUtZajFyUEdB?=
 =?utf-8?B?OVJwWXdsV2wyOGs0Z0dvL2J0YngwSmxZdDUreTN3UjJYMFRwakVQM2QwZk84?=
 =?utf-8?B?SUdnU2FPNmpXTUM5Tm1vOFh1aWdueTZQMkdvb2FxcWtRMVFDM3NqaGxwaTg2?=
 =?utf-8?B?eE53L0ZFSm9wSDgzb1VjSW1qdlFMTGRpQmpxSlRuZUoraDUrV2o4Wk13QThF?=
 =?utf-8?B?a0dGTk5xUmxMZ3MwOURzT0t4MHIxRmJMdkNQSUVuTExXdXJBRnIzaDN2OHRU?=
 =?utf-8?B?NHB3aTEwcUF0dWx1L09kNGkxLzc2YWVabzgwWXNNSmtNM3dTcGM5ZkllWUhi?=
 =?utf-8?B?b1AxNm91OEcwVHp3cDcrVGdwZ1BSaUJzVWZHbnVFL0xaRU9hSUZBUmc1Z3FQ?=
 =?utf-8?B?NXpwOVFWMmY4dVBIblBsUDJhOG9JUU81cVhIMGJFTXF4WTFDeG0vT0s4RDY0?=
 =?utf-8?B?NHYrY09QbDBKTHJsM3JkYkwyeTRxbFFicDhMcjFoVWpUY3lHRFYvTUxUMmY2?=
 =?utf-8?B?ZlhJZ0tNWStCNEZFN2RydUNYQjk4ZUc3UXZ6dTdLMFNacjQ4ZXE2clYzc01K?=
 =?utf-8?B?Sm50cHQ4R3JwNk92UXArZENoSmdYUGIzWW1hYXdvcGNwcU0zMjVVN3V1c3JS?=
 =?utf-8?B?VGE2aUZvQmYxWHVvUHVUWUk1SkU1UmhqM1o2UTdrQ25NeC9rZEZlWkI4c1R2?=
 =?utf-8?B?MjJ1L0dDNUVqWUpKcmpGVjl4bzlHcnFlSEt4MXZLZ3NZc0YxVTlVZmNSOWM0?=
 =?utf-8?B?eSthd0pWbTg4NEpwSkQ5WHVxV3o0UWlZTm1pajRvMjh6NWdMdlY3YmVmcE93?=
 =?utf-8?B?eFpxZ0VMOFNKQ0htNzg2cERkUThsT2FOSEIyRmxNbjdDVnI0Vmc0QVRWMUJW?=
 =?utf-8?B?NVgxNmlTa1hPb0ZUZk9CYW1MdWtmcmFidE4zRmxuYlh0SStJQ3F4Z1dsa2JX?=
 =?utf-8?B?NC8rQzlnWnZlVHJ0a3RYbnJWUHUxenA3ZWVyamdtbmowa1l3cCtBeVp4RllN?=
 =?utf-8?B?NHc4OWpoR1lHYkNHcVRlOTF2SUlzdmN1T1RXb2tQbjVXVFZHVU9VeGxyeEQx?=
 =?utf-8?B?SEN1UVFKSCtyeDF1SGtabXJPUzF4K3loTmhiWllzZ0RuWlcxYUUxM1V6Y01P?=
 =?utf-8?B?WHM2Ly9SY1NINm5YR2drb1g0QTd0WWUvNm4zelJCcXJZdUxBMzhaZE9vYm5I?=
 =?utf-8?B?MzlQMmRrcFhpY01TKzBieHhqUHJZMnh6bkc1WWNHY3pyaGJLZUx0V2lLdTJ4?=
 =?utf-8?B?OUh6MWpmN2tTTWdRdzJIQ0FJNGZjOGY5eHNnOWJxOHdwc3NDYi9UeEtBM2FV?=
 =?utf-8?B?cldQMml6N2xVR3FWaWVranl3bVFUUkpmUllnUS9SSGR3WVZaYWs5Q2toSGd6?=
 =?utf-8?B?SHV4Myttc3o3TUJXcjFmUTdNYURxM3VMVE1SM2hCWXRJM0UyY3IwaC9MdmNq?=
 =?utf-8?B?ZGtPWUpUVVQ2K0lZUFZHeGNRN3hYMkZDSDY0U0tHbWlTLzRhRmh3ZVkrLzN6?=
 =?utf-8?B?VERCMWc4WXVQVm56cXp2TVU5MzVQUGpJZVAvMkJRaytzNlhUMVNaYitCdnlt?=
 =?utf-8?B?UHNiVGVMcjY3R3VxWnVlKzBLWXk0ZmVmeHF0QWtMYkFzbDdXZmZtQVJISHJi?=
 =?utf-8?B?dXF3MHZmNC9BME1vNjdrQVlKNjFlUkN5Z3hSOFlDRDNhY3RWRFhxblM5bkFa?=
 =?utf-8?B?RDVlOTJCN1lGR3ZkYUdJZm9hcnRRekpScnVhL2R1Z3BZVVFzYVFLZTdtK1dI?=
 =?utf-8?B?NHBhakdzZ3JGSWJIKzhhNFBkbG5vdDg5TC85czhaR3NxaWU4Mldtc3Y4V08v?=
 =?utf-8?B?NUY0c3VyYWZjN01uTlYyOEJaNWFyRzNlSWxXSEJsc3dPK2JreVF2bUoxY1Vq?=
 =?utf-8?Q?LhpI3d8JS827uOqKjhsnyL8SpJ6no0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnBmNFNVM1hxa253ZUE2ZW1mWUdmMElORGhvYTMwUktDb09CL2xaQ1k4SGtG?=
 =?utf-8?B?RnhuNjU3Rm9aZG5QTGlxT1pIUDRCQk15cVBwcTVFVnVkcWxVYmJjYWFGcHpm?=
 =?utf-8?B?SW9IRm9BLzViUERwbUZoRW5lbHZUNGE3ckpIYmt2VUNtUWRWUWxrOUJDUGcr?=
 =?utf-8?B?M0FCZ1gwbHhsNmpKSTd5dG5mRGNDR1ZZbFFOc1YrclQ1cjhYQ1pNVGRFR3RP?=
 =?utf-8?B?bFhFdWU1Qis1UzdRZDBFUGZFM0dQOTBnQ1Q5T0o5Y2hDdXpPbzhGeUdvMHdY?=
 =?utf-8?B?Q3pkcGtYTWhFZmFpblBxSGsza1FXZ3JXQzYvYUVISklxbW4wVCtxWiswbE5y?=
 =?utf-8?B?MUNkOGYydFlNRGVwdU40bTVpOVE5Ny9lSm1IdmVRTW45ajNxamQrdjZtczhN?=
 =?utf-8?B?cUFHajZpakhCYjBxZTlybUVxS0g0ZzFSNXdvRFd0QWxUdVN2cjZFZjBYWDVI?=
 =?utf-8?B?OWUvaVZxaDBHWVloK0lEQlc1cHdyWEJFYk13dStUbFFhQlhlV0QxMVZyM2Rj?=
 =?utf-8?B?amNWMGJxU1pJUFlCYWJiOEs2eEZOSURtSTBqSjh3aTJlUUVYQjBpczBaL3dr?=
 =?utf-8?B?MzROczZMQzFUc3Q4VzNiTTFvbDlzNERmMEZWZDBIcTIza2xqTVpRM0VGS3NX?=
 =?utf-8?B?alpsTmxYQWtvY1A3eUdEdTdqYmYrQnAydjc5WmRzelUvZm1ScVhPWXhtUHRK?=
 =?utf-8?B?L1c4ajdYWlJ5NGlZb0VVSmdJandDOGJtdTlpd3hvZ2NEbFVZY0E3WDByYjFP?=
 =?utf-8?B?NUpENlFBcjBIZTdSOC9ReXpNSDlBS01zWTcxTnZib1QxZDZkUlpxbWZ2bGU5?=
 =?utf-8?B?ajBLL3hzTm9ORVVQd2JlUzZpS2djKzkwVFJtRHBYOC9hUENnYXQ3Ym9mMzYw?=
 =?utf-8?B?enJ0RWg0NkFpSTJzWnZudzlSSkd5TThuVk5GN2pFUTh5ZjBGQzhIcldiSVVo?=
 =?utf-8?B?aWc2TFg2cDlVdFpYZmNMUGoxODlLdXlZQ2xRd0VMYXpZa2R3VzRZaGFoMWxh?=
 =?utf-8?B?VkV4ajlPN2xFZlF3ZEhlc0t5ak9TYXNaU1h5dWxqQmxUeUE5ZGkraW90U0hE?=
 =?utf-8?B?WEZ5VkRvS3lwZTZibHBXZUF4a0JxQW5IdkJNc3VRemlmM05hT2RKaVJRTDlM?=
 =?utf-8?B?T3VlSWlIWStrWEZHNkZwN0R1ekhKb2xxcE44Snlia2l4M2RQVG9LREg3ME4r?=
 =?utf-8?B?K1drbHpmcU9yWERMV1dHOG5nNnlUZkd4VGNLeEZJK2xOdXB0Y1RkMWs1UGZE?=
 =?utf-8?B?VXIyQ01MODNWT1NhZFJqZDBSOGxjbDJ5TllLU1ZMalNuQ3J6dStHNlJ0cEZa?=
 =?utf-8?B?Y2FrWENpb2FsOGxQQTlXWnlqL0FVcU5IM2FpRUtiSmpPK2t4S0h5VnlvbnE0?=
 =?utf-8?B?cFBlSEI2dVhHN3huRVVzWExjMStNd05Nc0IzRU5DUWUwVElGQjAyaG0xWjJD?=
 =?utf-8?B?bE43NnBMZmNtS2JhZWlYTjg3WkNFUHNuMXkwdTdTVTdzMVpuak9OYllwbmp2?=
 =?utf-8?B?QnFKaExZT3lOUmdkNVBYaDRXTmhIeXczOWZrZkswcWJqelg3UTV2MHd1MEdj?=
 =?utf-8?B?T2N5RllrYlB0RzVhM3RrT3o3RjNjcVQrN0krVTRwRjVOamlRaXRySXJmemRJ?=
 =?utf-8?B?SlVOejlacm1YeGpNTkdoV2pyR2x2KzFBMTNjYjRqYS9NQVZ0NjRNdGszc3p5?=
 =?utf-8?B?eFRRN0d2VmdYMklJaDJQNEpvMHNBeTVjU3R0UjM3YUt2T2c4c0poWE1pZzhi?=
 =?utf-8?B?MHBjc1NEOC9BSmxHS3lIZjdwZDRZZnpxUGFjMXFtdVQycnk5RVJnR0hkYWw3?=
 =?utf-8?B?TENPeVEvcVk5MTVVRlppMW5IYjk4aGs2UUtwK2pHejVNakpVRWVoa1JkeVpT?=
 =?utf-8?B?RjFpVHNxYnE3UHBxWTBKRVRWTm9xeU5VYStoVzRKQlQ4MEF1RVoxUXhneFR5?=
 =?utf-8?B?dkNabDhtK2hldTUzUm82dmxidDBVcHlxeTIrbjhFM2wwZDdYY3lLdTJWS2Qy?=
 =?utf-8?B?NWhNQmF2alAwWDMxcURHUDd6QVc3RDJvc3JIM1ppRVVPS24wekxaU2FGckJP?=
 =?utf-8?B?alE2bXJ6bGhJWE5YeUVmRnFiek9mVFNBUDJiVnU3ZXA5WmkzaFdMcFpTLzhy?=
 =?utf-8?Q?kIOQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad7d89-9e65-4459-6a92-08dd9e2bf6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 21:09:42.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71QDGimRnKoBs/uPYBFVQWT27++Uu3iFJBKdxKWCkmEWMlh+2K7IG6ZSlWAWr+UwjeKh/w/ux5eZd5JK3x8nmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWluZXIg
RmllYmlnIDxqcmZAbWFpbGJveC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDIzLCAyMDI1IDM6
NTQgUE0NCj4gVG86IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogNi4xMi4zMDogYmxhY2sgc2Ny
ZWVuIGFmdGVyIHdha2luZyB1cCBmcm9tIGhpYmVybmF0ZTsgYmlzZWN0ZWQNCj4NCj4gV2l0aCBr
ZXJuZWwgNi4xMi4zMCB3YWtpbmcgdXAgZnJvbSBoaWJlcm5hdGUgZmFpbHMgaW4gYSBSeXplbiAz
IDU2MDBHIHN5c3RlbSB3aXRoDQo+IHRoZSBsYXRlc3QgQklPUy4gQXQgdGhlIGVuZCBvZiB0aGUg
d2FrZS11cCBwcm9jZWR1cmUgdGhlIHNjcmVlbiBnb2VzIGJsYWNrIGluc3RlYWQNCj4gb2Ygc2hv
d2luZyB0aGUgbG9nLWluIHNjcmVlbiBhbmQgdGhlIHN5c3RlbSBiZWNvbWVzIHVucmVzcG9uc2l2
ZS4gIEEgaGFyZCByZXNldA0KPiBpcyBuZWNlc3NhcnkuDQo+DQo+IFNlZWluZyBtZXNzYWdlcyBs
aWtlIHRoZSBmb2xsb3dpbmcgaW4gdGhlIHN5c3RlbSBsb2csIEkgc3VzcGVjdGVkIGFuIGFtZGdw
dQ0KPiBwcm9ibGVtOg0KPg0KPiBNYXkgMjMgMTk6MDk6MzAgTFVYIGtlcm5lbDogWzE2ODg1LjUy
NDQ5Nl0gYW1kZ3B1IDAwMDA6MzA6MDAuMDogW2RybV0NCj4gKkVSUk9SKiBmbGlwX2RvbmUgdGlt
ZWQgb3V0DQo+IE1heSAyMyAxOTowOTozMCBMVVgga2VybmVsOiBbMTY4ODUuNTI0NTAxXSBhbWRn
cHUgMDAwMDozMDowMC4wOiBbZHJtXQ0KPiAqRVJST1IqIFtDUlRDOjczOmNydGMtMF0gY29tbWl0
IHdhaXQgdGltZWQgb3V0DQo+DQo+IEkgZG9uJ3Qga25vdyB3aGV0aGVyIHRob3NlIG1lc3NhZ2Vz
IGFuZCB0aGUgcHJvYmxlbSBhcmUgcmVhbGx5IHJlbGF0ZWQgYnV0IEkNCj4gYmlzZWN0ZWQgaW4g
J2RyaXZlcnMvZ3B1L2RybS9hbWQnIGFueXdheSBhbmQgdGhlIHJlc3VsdCB3YXM6DQo+DQo+ID4g
Z2l0IGJpc2VjdCBiYWQNCj4gMjVlMDdjODQwM2Y0ZGFhZDM1Y2ZmYzE4ZDk2ZTMyYTgwYTJhMzIy
MiBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdCBjb21taXQNCj4gMjVlMDdjODQwM2Y0ZGFhZDM1Y2Zm
YzE4ZDk2ZTMyYTgwYTJhMzIyMiAoSEVBRCkNCj4gQXV0aG9yOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IERhdGU6ICAgVGh1IE1heSAxIDEzOjQ2OjQ2IDIwMjUg
LTA0MDANCj4NCj4gICAgIGRybS9hbWRncHU6IGZpeCBwbSBub3RpZmllciBoYW5kbGluZw0KPg0K
PiAgICAgY29tbWl0IDRhYWZmYzg1NzUxZGE1NzIyZTg1OGU0MzMzZThjZjBhYTRiNmM3OGYgdXBz
dHJlYW0uDQo+DQo+ICAgICBTZXQgdGhlIHMzL3MwaXggYW5kIHM0IGZsYWdzIGluIHRoZSBwbSBu
b3RpZmllciBzbyB0aGF0IHdlIGNhbiBza2lwDQo+ICAgICB0aGUgcmVzb3VyY2UgZXZpY3Rpb25z
IHByb3Blcmx5IGluIHBtIHByZXBhcmUgYmFzZWQgb24gd2hldGhlcg0KPiAgICAgd2UgYXJlIHN1
c3BlbmRpbmcgb3IgaGliZXJuYXRpbmcuICBEcm9wIHRoZSBldmljdGlvbiBhcyBwcm9jZXNzZXMN
Cj4gICAgIGFyZSBub3QgZnJvemVuIGF0IHRoaXMgdGltZSwgd2Ugd2UgY2FuIGVuZCB1cCBnZXR0
aW5nIHN0dWNrIHRyeWluZw0KPiAgICAgdG8gZXZpY3QgVlJBTSB3aGlsZSBhcHBsaWNhdGlvbnMg
Y29udGludWUgdG8gc3VibWl0IHdvcmsgd2hpY2gNCj4gICAgIGNhdXNlcyB0aGUgYnVmZmVycyB0
byBnZXQgcHVsbGVkIGJhY2sgaW50byBWUkFNLg0KPg0KPiBIVEguICBUaGFua3MuDQo+DQoNCkZp
eGVkIGluOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9N2U3Y2I3YTEzYzgxMDczZDM4YTEwZmE3YjQ1
MGQyMzcxMjI4MWVjNA0KYW5kIG9uIGl0J3Mgd2F5IHRvIHN0YWJsZS4NCg0KQWxleA0KDQo+IFJh
aW5lcg0KPg0KPiAtLQ0KPiBUaGUgdHJ1dGggYWx3YXlzIHR1cm5zIG91dCB0byBiZSBzaW1wbGVy
IHRoYW4geW91IHRob3VnaHQuDQo+IFJpY2hhcmQgRmV5bm1hbg0K


Return-Path: <stable+bounces-145934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3128ABFDB0
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 22:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A794E2468
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 20:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37728F522;
	Wed, 21 May 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M24de6wQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308D19DF4C
	for <stable@vger.kernel.org>; Wed, 21 May 2025 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858004; cv=fail; b=a6fgjX4qGLmsgHnOclcVACbHjHkIkpP83uSDKGM/PTYqqbSG5cVs2s9pxTbbkenO8K/8wgt5GVDuBqy6x5AtHIx1wKIVsqlxbF7NeLWbU111YsBIuD6NaV3jfY9AuLLGxgYrpZGKhDGykzlCnb7Pv4qYVkWXLiz4CuOnkO2KfP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858004; c=relaxed/simple;
	bh=AkDzO4nipjKQJfH5NTXlF0hPE48sTtPZ9vcbXinYpe0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M98+UYugFcm2UPyyEbXyIfBqpDAyoRxz97edbtfc57AHXvupIpyn8XQPs67mV2j9jT/7bzBV3x2mvaTlX35WC/kSdnsubbNqPZXQG9D0wRBa/lXxTNynxMyzeEaMsV0thZVaBYkG/8mL8e3Gm73NhxSBKRF9YCyvszKgfZPwR1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M24de6wQ; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCFzlt18GjNmryqbqpsBYnPh4BttmCZksSJZKH6fs20s1jKxVfuCJywcf6/eEMg4zcgQQNSzsfHUg6C7OGU2hA2i2QvoimXpcQeZCn7VlrNBjWRxbp8afRXsPmGvfHh8envtrjNVDt90tgzc9bAe4tSytRXC8rLL8NqWrLNhAj7Y1AhLdR25yKKDUq/lvUANaqMImUF7iF9n4k24AVv8tqKjLULWttwURJUzu1GgP7TTloj6nk2fK1Fv9oIfe/Eo2/+pqeWL/Sw1vgntvTylZT6Pq6Z7MuR957Gj9aBIRFcAdwmad4C8NMzSwPlhgCUr2QPlEPFy3suLl9cj0N3jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkDzO4nipjKQJfH5NTXlF0hPE48sTtPZ9vcbXinYpe0=;
 b=afOFCrEZ+P7rRwk8Ov0J/oc7hgwcQp78RVpBVrc78S8nGeVo+VC/5l2Rnzetb93xlRaptlwVxekH6zajN66Yj2vZw34mkI3t7SoyGJbaC06DHHO+8XhLrGZYYNH6mylFuNkQ4f2+itvyjR0JR2qfZcdL5aKt0v3N5EmR4SHjs4kGKMOOY7Aix5rIJTNkB1J+LUEWvAQXBmgSX2XUFdI77oQ7q6T3/fOgmrbLt8ntDPNJrrICKIIq3zHg0NSCb0PjJqa7H9i+XdXZLFt/zqd90m7sobOTPFOc3+ivuaCCWlCsW9hNFsAdF/qyrG701GkLBEKrl12bLeLFP3JhM5BNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkDzO4nipjKQJfH5NTXlF0hPE48sTtPZ9vcbXinYpe0=;
 b=M24de6wQCvcTQ7cmFUAhsqIr40mKzdNpeKIM9O5KlorJVDIc6g1raYDVN4pHeWPMOnvBJVEY3xaTwqhKEeGmwVMPvXTXogZatLWX831s/Yyeh2QbN4HFzFjWgPjBfsNMWCOggE52rRAacfLCKCIyKjbd/BOXFvZher9y5qeKzjs=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 20:06:39 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::b111:2482:eb49:3186%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:06:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Rainer Fiebig <jrf@mailbox.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: 6.12.29: amdgpu-related "fail"-messages during boot; bisected
Thread-Topic: 6.12.29: amdgpu-related "fail"-messages during boot; bisected
Thread-Index: AQHbyXLSL16F+hbMvkakzUyZBUYGEbPdhFQw
Date: Wed, 21 May 2025 20:06:39 +0000
Message-ID:
 <BN9PR12MB51468394BEC8C062169C4380F79EA@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <e5faa1de-6a41-5259-6f69-66ff875ed9bf@mailbox.org>
In-Reply-To: <e5faa1de-6a41-5259-6f69-66ff875ed9bf@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=93b11326-cebc-4956-93df-907f0fca26a8;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-21T20:05:00Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|CY8PR12MB7337:EE_
x-ms-office365-filtering-correlation-id: 6f4168d5-58ec-4e21-0523-08dd98a2ff43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K0xvdTNxK21OczlxTjNScytsdTN0VzErLzhNeHNGUzljc0RsQXpVbjM1TWZ2?=
 =?utf-8?B?Q09nK04yWGxuWnJSWUJ1UTFXdThQbUZZcGZOUmtGZ3pYNkpsVlJmbitaTVQ5?=
 =?utf-8?B?dmZBcXp3UVFDMWhZT213dGlXRjF1VTZpUDEyRkc0dExQQVlHZlV5Y0ZqeFA2?=
 =?utf-8?B?d0FqZVJQMWlmUTRSN3FEK2VVNlI5L0p5SW42MnJnWWZhQ29ybGlKOTRHaXFr?=
 =?utf-8?B?M201dW44ditiVzVaV21iSnJDcHhyTmt0elJLZWN1Y2R1RHk4TG5STTFxME9C?=
 =?utf-8?B?SVVQUCtCdWI0VkYwdEsyWUZYOWpWZVJaRVkycys3cTU0L2k1Q2FVZkMzQ3dK?=
 =?utf-8?B?NHAzZlltZVpRL1Z6cVdqV1NJdWsvc1lnN2JUVi8rKzJXVmtEUVVBYTdWZFVr?=
 =?utf-8?B?NElraDVOU2UwRTNvT0FSZXUycWNCY0xYU29ZV0ZlM3lDcDFaSUZwOU1iMUIv?=
 =?utf-8?B?QXlnMG84eTdDdVBvSG1reWk0ODlYTDhHZXZhQlgrMzVSc2kwQytzbnl6U2h5?=
 =?utf-8?B?dXZlYWtpVVZDSGlNWVZ6bU9WM1BMY2NlQTN2bklsdTJFVWI0MjBlY21tSTRW?=
 =?utf-8?B?TE1JdDN0WDlGc3JCeHQ1R1p5T1VMZjFNaHZTMjFZWnhaK1FKdVk5RWpNRUd4?=
 =?utf-8?B?NTd4bVhiR1FtZGdYQkNJYlVxZFJSa2R3T3NFNW5sWkxUTTVJcEUyUDAxQ2tF?=
 =?utf-8?B?clgxN2NpWDVkRHluL2YxR2g5RVl5ZjlKN3M4cmZaeU9SdnorV1c3R2RvOWNs?=
 =?utf-8?B?SE9NbTJ4RWtaU0JSTkNyU042Rk42eEJWbGlLaDZEakYrOFRiN3F3aysxd0dE?=
 =?utf-8?B?alMxSnFGVjBnd3BVUVlnd1ZtTzRPaVBXa1RlOWRSSUpXM1E3SS9sem9TbHNY?=
 =?utf-8?B?K0lNbUgra3BXa3NLeHU2M0FEdzR6UjZ3MFZlY3htUy9VV25LclhEMHp5YTVJ?=
 =?utf-8?B?bm15d2tYWk9rcjdrbkJyUCtOL1ovNHF1R3JVbVZKYzNDOWM4VTJ2ZTh0RlJy?=
 =?utf-8?B?U1pZbVhvYWhxWEhBVHNMNVZVR3ZOU1FGUG15R1FvZUIvTU1jam9oRTRJSjlK?=
 =?utf-8?B?SWNhdTNFeWJkN1BKVjRYcmdpUUQ1VEFxMXAwYTI4U3dUUXZDdUIweUtweXdu?=
 =?utf-8?B?SHJxbWRRWThoVjB0NlBLZlNPTnR2SVFKMDR4QXF5RnlDeHF6V3dlbUtZTXV0?=
 =?utf-8?B?NVg5Ym1mZTdMS0ZuOHVhWW9kUnB1K1VjZ1loaE1uYlRpT1dBZmZCMVdZTFA1?=
 =?utf-8?B?NGNtYzRxajFGTXNrV0toRldoMzErck5scEs0NFFIalh4T1hCb3dWY0FzSGE3?=
 =?utf-8?B?Z1FYT1FvWXNRNEZzWThPQWliRXdFQzlqUm9XSE5VK0w3T3Y5RkQxUXBOTzRs?=
 =?utf-8?B?cmo2Nlg4TlMwaU5aTWNCVnd6SjBrNnd6b1RGbWtGSUJ4NzhVNm8vQ21qRWl3?=
 =?utf-8?B?K2dRaFpoSEVYOE1Cc0k1azJpSHZaMk1BWk9jUW1wbi9tWXoyUWhSZlZUUVlD?=
 =?utf-8?B?ajNpMzZqeVdKV2x4dlpmL0QrRXd3Ulg2VUVlQnZxY0RnNHZ3R1JNejNidDJs?=
 =?utf-8?B?TG9odkF3dWxnSHR2QzJUTi9pdVVmeVNsaERna0ZiZ0REejllOVh4MnpjYkR6?=
 =?utf-8?B?LzZ0dGVBT2E3M2h4L3ZRUVNLUGh1UC9CN0xrYWd2SzBaVjRuOVV1blBmVkNY?=
 =?utf-8?B?cjdWRzVSb2NpWkJMMUxmZzBldGYyYm9zTnJWYzFhY1M0ZjJJdUR1REhyQ04x?=
 =?utf-8?B?ZEVEa0tyakNhRFJ2VXdlenVpVFV3L1llclNHK21BQnBqdlJtWHROY3k0aUJx?=
 =?utf-8?B?c1NhaTVxZG5wNkh4Qi9FM1FqZDd4bTRVaWlTeVRjaFB3UVVtUFc3eVJ4UWp4?=
 =?utf-8?B?eVN4NmdUb3ZobTkzdFhzdlhxY1RET1VzUWttTFZDTTNpYXVWUGsybDEwelpu?=
 =?utf-8?B?dkRPMUwvbU10WEpteklLcVdGQ0tRZ0dVeEVndm9HSEJzL21GZGJubWFyRjJO?=
 =?utf-8?Q?hVplXo1l8UPJCw8Bq/snFkrZ6qk02I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzRUKzUxTXVOTlo4SS9CWE15OTM5M29yRzJ3VFN0cHJqZ296Nkg4dUU5ZDNz?=
 =?utf-8?B?RUFjVUo4OExUSC9Db3pFTG4waCtKdnVJQWZ6QXMzMEFwamNvSnlQWjNWUEF0?=
 =?utf-8?B?dWloTlB6WTNHY2Z5Q2JoU3N1UGlKWkVHMm5YcnpEeFY5QlJyeFEwaGFSMThB?=
 =?utf-8?B?UkdqVWdZVktEanlrbXpjYjIxMWdOSTFQWW5VQi9BYkV2S0oyUWI2RlNDZng4?=
 =?utf-8?B?ZW04T0FmaUJPZjFHU1NhSjVsZFNnMkkyYVlEeWFEaE84cG1pbVdJMFdKZUlv?=
 =?utf-8?B?cEpyODBVT2FmTmd4UkhndG9tTnl0SWgrR1dad1p1ekVIRkg2djBvNmJRVVVx?=
 =?utf-8?B?aStxb0hBc1lEWm92QWNRTVR6cXJvbFJDSW5iTWN1MzR2Snh2VWtoandpd1ZW?=
 =?utf-8?B?bEYrZ0ppemZKU0xKSHQ2c1FiekM3Z2JIS2l4WjlaTklaaEVkbkZNS0swYVhi?=
 =?utf-8?B?MkdhVDZNYWk0Njk4OVpiUFBFMG1rNnp4WlErY3YvbkhTaWxodDZkaGs0Q05L?=
 =?utf-8?B?dXp1cDdoSjdjTjZkZ2dFWUFscUtMbWVtNWVtcElSSklCK2o5VlJFSmlQcHRO?=
 =?utf-8?B?Ymo3K1pQdk0rblZtcUE5QW5tcmhWMnI0UmlNcGVuZ2VLT0Y2dzEwRVVGUEJq?=
 =?utf-8?B?dU1YWEFtbEt1RUdKUURRU2hKTm85SnVJaklnZVE5aVExVHdIWll1VDhmaWtm?=
 =?utf-8?B?Vit2akJFMU5MWmQxbXJoS0djNTVNd3JrcGpZcU1MUlY1bmMwNUI5YmFLMTFu?=
 =?utf-8?B?MythRlIxbjVVZEdmSGhCYUNCblBkMXFhNVpBVHE1TnIvWm5JazUrTG9kYm1L?=
 =?utf-8?B?ZUszdnNUSXdnYWhwWkNwcFFCbmVKMVloRmpZUzVsZjdmNEdjc0YwUGxiTWxw?=
 =?utf-8?B?N0VUTXJkb0hsLzE0NFY1amY4UGJIMDY5dnlVSHd2N05XWGNJOGg1cXhSeHhX?=
 =?utf-8?B?SEtwL0RzVzF5WnhnREZDbUU1U0VidzBRbGNLYWFrMTBkaTBPZzBLTThpaXZE?=
 =?utf-8?B?MWNndktuQUdNejNJdGlOdFZuODIzRzUxYW9NK1FFekZGK2xsbGJYNER5MnZt?=
 =?utf-8?B?cExkbzJWWGVZdVdiZnFVTXpGL3lMcnloRXBnSXFnc3VndDBoUlFkSngwakR3?=
 =?utf-8?B?aDZtZTE3b3FGY2NiSTlydWxwZ3EzVmRibzJhL1NkdmluVUttcE1DdXVWYm5i?=
 =?utf-8?B?MFZtZXZMaUkzRkJLV3ArN0hSSU82Qkl3am5ZWEV0QmI5Nk9JUU44a0tQTUdL?=
 =?utf-8?B?aWxncFVDTUNIMGxxdWdRKyszK0ptY09kNmp4cmtQbTFUNHZwVFYrbDkxaFdv?=
 =?utf-8?B?NkpkSTZpaldlYzRpQmQzVEtFa2d4cWVDMHJmTzBOVzlkWWcwWVFzMTlxV01Z?=
 =?utf-8?B?RklEV2NQZFVlVlgwLzFnRFdwRTZJdXVlcU53TXE1MDRmR3hJQmV5UXZSS2Vs?=
 =?utf-8?B?Q3EvbDREQ2ZWV2NHYWxUa2o5MUdyMTdYQ3FiVlFVRHlLYmRuMnBQcDk2WStl?=
 =?utf-8?B?WXRGdWhxbkRjL2J0Wkc3OEtwRVZjYkd4N1NxMFlEYm5NRnBnTHlqNXIyRTBn?=
 =?utf-8?B?UGhTNWRUR2dmTTUvbEx1UllzRk95WW1ZL3YvSFU3dENKeWZNZU9DajZXeWwy?=
 =?utf-8?B?RnZyTmFtcmoxaTZGSzN3RW5XRkhJL3VNLzk4cTlXSHZkS0RWb2NkYUlEaEEy?=
 =?utf-8?B?aVZNamRoVWk4OHg1U0k2TFkyMXZGRnhrbnZWQzMrbUVBVnFrVU84WGM4blhN?=
 =?utf-8?B?Q0ZIMWFBQitRazRPSE9kbkhaMk4veXMyUmgxemdIclhKanJZcm81a09lTVVo?=
 =?utf-8?B?YXliNXIvVE5PYzZDTnA0ZWtSNkI1bE4xOUxFK3NncnY0ZVRZc2Q3K0FNbDUv?=
 =?utf-8?B?bjlLQ1NCWitZRGJmdVRJN0Y0V3dqYVlKRVhJWTBndE5TWFdNMjBPWnJVN2Fk?=
 =?utf-8?B?TGRudWw4Z2VYcEpjZUtSanpBa0ZEOGhuNmpMYVlPQ3RZNVVOQXRydzhNZEZi?=
 =?utf-8?B?aTJrSUt6ak9RazV4d2diSUlWQitveHorSGJFRTJjK0VvNjdOTkFRR2NtWUcw?=
 =?utf-8?B?K05iZ1hLRy9ORGRQbXhEVkFWazQ2TkRtdWhQWm1TclEraUhFa2gxTlVhZlBi?=
 =?utf-8?Q?08qg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4168d5-58ec-4e21-0523-08dd98a2ff43
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 20:06:39.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbsB6ti/SbOk3VCDXe2keyH3kFjwy3AjZ9Cv57+7TjP0q4ptjtEp4E85Eoel3tf6CTyHZFkX6rNe3Pi2c85K4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWluZXIg
RmllYmlnIDxqcmZAbWFpbGJveC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMCwgMjAyNSA2
OjM1IEFNDQo+IFRvOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBMaW4sIFdheW5lIDxXYXluZS5M
aW5AYW1kLmNvbT47IERldWNoZXIsDQo+IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogNi4xMi4yOTogYW1kZ3B1LXJlbGF0ZWQgImZhaWwiLW1lc3NhZ2Vz
IGR1cmluZyBib290OyBiaXNlY3RlZA0KPg0KPiBIaSEgQWZ0ZXIgdXBkYXRpbmcgdG8gbGludXgt
Ni4xMi4yOSwgSSBzZWUgbG90cyBvZiAiZmFpbCItbWVzc2FnZXMgZHVyaW5nIGJvb3Q6DQo+DQo+
IE1heSAxOSAyMzozOTowOSBMVVgga2VybmVsOiBbICAgIDQuODE5NTUyXSBhbWRncHUgMDAwMDoz
MDowMC4wOiBhbWRncHU6DQo+IFtkcm1dIGFtZGdwdTogRFAgQVVYIHRyYW5zZmVyIGZhaWw6NA0K
Pg0KPiBCaXNlY3RpbmcgZm9yICBkcml2ZXJzL2dwdS9kcm0vYW1kICBoYWQgdGhpcyByZXN1bHQ6
DQo+DQo+ID4gZ2l0IGJpc2VjdCBiYWQNCj4gMmQ2M2U2NmY3YmE3Yjg4Yjg3ZTcyMTU1YTMzYjk3
MGM4MWNmNDY2NCBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdCBjb21taXQNCj4gMmQ2M2U2NmY3YmE3
Yjg4Yjg3ZTcyMTU1YTMzYjk3MGM4MWNmNDY2NCAoSEVBRCkNCj4gQXV0aG9yOiBXYXluZSBMaW4g
PFdheW5lLkxpbkBhbWQuY29tPg0KPiBEYXRlOiAgIFN1biBBcHIgMjAgMTk6MjI6MTQgMjAyNSAr
MDgwMA0KPg0KPiAgICAgZHJtL2FtZC9kaXNwbGF5OiBGaXggd3JvbmcgaGFuZGxpbmcgZm9yIEFV
WF9ERUZFUiBjYXNlDQo+DQo+ICAgICBjb21taXQgNjU5MjRlYzY5YjI5Mjk2ODQ1YzdmNjI4MTEy
MzUzNDM4ZTYzZWE1NiB1cHN0cmVhbS4NCj4NCj4NCj4gVGhlIHN5c3RlbSAoUnl6ZW4gMyA1NjAw
RywgbGF0ZXN0IEJJT1MpIGlzIHN0YWJsZSBzbyBmYXIgYnV0IHRoZSBlcnJvci1tZXNzYWdlcw0K
PiBhcmUgbm90IG5pY2UgdG8gc2VlLiAgVGhhbmtzLg0KDQpBbHJlYWR5IGZpeGVkIGhlcmU6DQpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvY29tbWl0Lz9pZD1kMzM3MjRmZmI3NDNkM2QyNjk4YmQ5NjllMjkyNTNhZTBjZmY5
NzM5DQphbmQgb24gaXRzIHdheSB0byBzdGFibGUuDQoNCkFsZXgNCg0KPg0KPiBSYWluZXIgRmll
YmlnDQo+DQo+IC0tDQo+IFRoZSB0cnV0aCBhbHdheXMgdHVybnMgb3V0IHRvIGJlIHNpbXBsZXIg
dGhhbiB5b3UgdGhvdWdodC4NCj4gUmljaGFyZCBGZXlubWFuDQo=


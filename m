Return-Path: <stable+bounces-240324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAFPD0i66GkHPgIAu9opvQ
	(envelope-from <stable+bounces-240324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B7445B6A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 287303013872
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103BE374170;
	Wed, 22 Apr 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Zoc0bniP"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1B175A6D;
	Wed, 22 Apr 2026 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859714; cv=fail; b=g4hXOc+QsAajrIPVbIgf6gHr4YukzyAbpAWZjlwGDbS0fbOU4zLjA99J2WpayJt09ePoXi8gwaFUVnHmgrWZQ4mqHGrOvRDUdnGXamsgibNL+HrqAw1+EHnOF2IMsLsJHMIhVSfZrJhYOj9z1EGQkraEoddoa0SjlD/Fh3hienM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859714; c=relaxed/simple;
	bh=NhT8TVxZ9C0zJcHUQXoovGzO7UJfhQ9AWNJsmdf6TDg=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8z0ouF94jbseBAJDezEeTMCpCh8AdnIkzjmoMnKG3MvZ38Kbp83Gvj9S5EyFvovFIumEKhrEL6DdlryRZn1nDsLe7ZqAePjfnQi0sU/pezt/77BhYHWpMrLv+hfaz+JAd8TPc9XTSO6M0cMw0pRRu8IADoyWdbe7D53m4s8Cao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Zoc0bniP; arc=fail smtp.client-ip=40.107.209.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWbxgxfLTA5fpmYIab8+u6UlYUiTCt3k6ziygoycHWZQGqENS/akFqdQgRND7i4ViaMwQwd5k6rrU3vYT8Cq7qFBEOWsN7bXnAmbNTnOn1qd13TgSiqZe7YqR6DQ1/a8yK40aIcbo/BmyuZjIk1Bf2aMAs/iLQu+6L+5ls/Em3Q7ZuVa8G/1uDrx5k3ppTZDH/PAQUqgy6t9eIsBcjVPIeWKd9Itf4tWRedZWG/SZcLg7URN5SXPWWiMFd0tLKgoRKB1oCCxClI3LmxlBjFXdrkoEvcFSm0A6dFj7iJg58RRHVLS2djm14CuBjBdErvUzuCu0wa0hGxIocQPnNiRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhT8TVxZ9C0zJcHUQXoovGzO7UJfhQ9AWNJsmdf6TDg=;
 b=IcKohKU0EZ3jFNYHqaE8iS6TM213T8+a1VN16kd5+04c7bNkcb9zmrsYd2fHNgKYjg3pyaoTlsKIuVHSHJfRIokH7+C2uCulbCzeS77bmSuhE7FCafWc54jdHyYjAl9jjEh9kP16/wN/cUgYXRkH9B3twAmBf4zcAe90GlABcfPGcIaoJIB+dS66gPq+aCHJcy6Loy5uQD4hZasIQcFJDGwwHMKDY4nvISPQz9luSfnrjUr56AjZaKt/tWKP4ArHdblQvoAedsJEr0JoN8OyhpEkHYfYfjmhM+mGAAfSY1liIoqWHHSDKOOi/xtURpcRJ87s5dMh1bYrtVhoLNMsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhT8TVxZ9C0zJcHUQXoovGzO7UJfhQ9AWNJsmdf6TDg=;
 b=Zoc0bniPOphQpSWoS4eKODYl1IwwteayN6BhRiXvrormF8E/bJDJvgFBaefUef5tFA00SywyoRWNsjSLuTJ+hDRCrhNXyfEcfD6IjcdfyHC96HN5MlVLIINZst9dUIyQJOiYuZ+lIRald0k2dAIT+wQtkKd2G2EflaSeh45tez0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by SA5PR03MB8428.namprd03.prod.outlook.com (2603:10b6:806:476::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 12:08:31 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 12:08:31 +0000
Message-ID: <1297b82f-e677-4cba-9c5b-ec40b0fe0c8d@citrix.com>
Date: Wed, 22 Apr 2026 13:08:27 +0100
User-Agent: Mozilla Thunderbird
To: dave.hansen@linux.intel.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Gayatri.Kammela@amd.com,
 bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
 mingo@redhat.com, peterz@infradead.org, stable@vger.kernel.org,
 tglx@kernel.org, x86@kernel.org
References: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Subject: Re: [PATCH] x86/cpu: Disable FRED when PTI is forced on
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20260421163136.E7C6788A@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0510.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::14) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|SA5PR03MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 66099ff5-bf20-46d0-6b99-08dea067ded1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	i4r4t5nldZtkI/ceLHBiJZiyoSNaGh3SMiEeo+UbWMOvvoqukNoiLIepxoBvTzmsErfgjWoObedVIsUGJ5jFGQ4//Newqk+468n9ncMKCRSuy34WCsI7HYsZQEWlHIgtmcY8agLhMHWxUYlmn+0utgmb66Uv47ALN49mWFv6X+rIkaLtbkiz8mcrTHC/vQ0h66jgvppZk2sZ42IhYILEFpk+et1nYCE4R4yXj1ZKYqOysLFdNj66IXpIjByJvIuUI3rWyjEAE72wABrm8WI67v5G9oa8zg/aI8sFnOf8rGsOLe3vvjg+2LcR9mgSiwv5dnYNQNzuAJdhTAh4Ms6ghATFyt2PsjahlBkurAYz1humvY0QlASnHkBytvbRWU3p4kfin8pIqQDttJXScNfSg/wypgZLrqGasylErU6wpXkxPpZAjbJWk8x+2jeD1iEH2Qgzp7VFqjlrU2FRQIGdNtEevVG7z6EF6xTBth9MqJqHroNOwK3xPRaLOj1fEnLp7XmePYxorWHoMIvbVeN0MSLwRtfNfcgrrrCFnyI+PNnkhdk854CfhIt9m6fbujOx/Fg+zpiB8OJbwoofvf1NAQEeyzbrTb6FaJsRmXzDOfJ3d6M4jySFeanb/iHmezDRRwbvNRJIE+4DbN9hTUQ80tKjiGl1AB0meQMBWSSvo/39OcqF+sBAOt6ZqWF1UpGzJdAUSWE1/nziU+JWesiW7OEser/OXIDIhvb4+a1ukkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(22082099003)(18002099003)(56012099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am5GcGlwWHhaQ0ZQbWUxV00zMXkyNmVGQ2VqY0g2SHN0b0VNUmJMU3NNOW1a?=
 =?utf-8?B?Uk1PbnpsRFNrOFpjWE9qcFRsR2NVcHJIRk5lZHRMZUZtY3RzSWtGUkRkeFpV?=
 =?utf-8?B?TG5UMlB3b2pqQXBJSFE3Ujk3bVBTM3p6K01BMFo0SC9mWDVycHhkRTBva3Q3?=
 =?utf-8?B?V1U3WXJtVjQwKzF2TFdVYUIyeHp0eUNQdWtCY2ZhQUEvVkhtazlqOHQ2Q2hu?=
 =?utf-8?B?MVhoaTNlQmN1TTQ2aW1oM3NsT1Nsdm9NcGpBTkluNS9qcStiVDZuMk1uZHBo?=
 =?utf-8?B?VW1KS0NURW4yMk5LdXpLWkRoV2FFN3FZM2N3M2RnMlZBQ0RsazdvMHN6VlVW?=
 =?utf-8?B?dUc5QS82bzNIazRpeFF3dUhlTjRIRVJHOVJLK3FSR21zNERNMTY3dVBvZjJm?=
 =?utf-8?B?WjgwOTRJcHJCc1FhcG01UTRtUXpvTTY2NEd3T2diWGdWN0wzZENmWVlGTVgz?=
 =?utf-8?B?TzI0d3dLYWg4WlFZTFRGdmppdC9na202bkhUQ3Rwcmw0MzV3SUJTcExIWWZJ?=
 =?utf-8?B?Qm1HbVZlWkYvOUdKdFdFRW0yZHhtYjRnWUEweG11bGo5dk50T3RSbFlYU3VL?=
 =?utf-8?B?OWxZaUJFcnpmSVRNdG9QL2tPZ3dCZTF3ZStZbGx1QTdGaVBsYW8zTGpIeWxm?=
 =?utf-8?B?ZnZYSEQzWk51eEt6dUsxTjB0SXA5ZTV5enQ1bERoMXBMTzc0VmZpb3gwRjY1?=
 =?utf-8?B?U2dPOVEwendhZ1Rlek5JbjRJaGxXZEJHYWx3Sml4a3FIbGNxeGdtbjlVYmRF?=
 =?utf-8?B?NVdpbm8vWXJpa2VLYksyd0lZRWw1VHVwR2thb0RtVlVoeHFxUlhXc2FEMmVB?=
 =?utf-8?B?RVRRWmxXQ3IyQUw5ZXZkTWNMdGwxTGhmSGdzQXMyN29zVGRDK0dUcVhyTGFw?=
 =?utf-8?B?S25hVnk5ZkxLck16L2V0MDlIWGpkekFTRE5sRFN6OFg3VmowYVhRZXh1NUhp?=
 =?utf-8?B?UWNvUWVleUFxRkNjRXBWTDd5QVNvLzZDbnBRR0pPMC80bElPOFRXUUp0YUs0?=
 =?utf-8?B?eVZ5Y1BHbk1XWXVJUll5dElBSXlsZUM5UU04UDRjMlZZLzQyMkFMT3VBUUYv?=
 =?utf-8?B?SXFxQjBodFFqemRSclJUTFk0ZEpXc3RIc2hlSkdTcVMvNkdTbGs3T0FHN0Ji?=
 =?utf-8?B?bTNCRWJ3MkZTUVlQaXBUMWxmd0JHbWQ3TGJHaDFabWdqRG9yS2kwZ3J2RDRM?=
 =?utf-8?B?QUpxSzR0K3hUakxtZW1meWs4OXhVbW5nMmE1eXpKNlhSNGljSXVnZ1NPNWZa?=
 =?utf-8?B?dllucXN4RVpJVDg1OE5XZGVNOGdwbmE2Zkt0d0JSQ1JrOENOZzJnbU5WeWgv?=
 =?utf-8?B?VHowejJpZmg3V2NGdW5nWG5DWStxcUE3b2FRMkgwR2VVTWIyRVFTN0tERnRa?=
 =?utf-8?B?d3FhVm9LMEtwUmZrYmdhb0ZDK2MwWUpPL1dMdUFaM3ZtdUgzNUF4VnBNUEVR?=
 =?utf-8?B?RlF3K1lHTlZPdm0wa2lOOCtkNUs5UTRWK21JTEFJQm9pRzdyd2ZrUzdqWVlL?=
 =?utf-8?B?dE4venJiYjdaSHNsTUFNVGxkTVd4S2loTmN4b2Z1bVNzSVROMytPVG1HRHdB?=
 =?utf-8?B?WkljMWdXU1p1T0FGdDIzNHJmaTBrWnJaeTQ0bDU1d3dJQjdRSDdhd2ZYN2hk?=
 =?utf-8?B?YXhVbVNQUGk3bnFCT040MEFBNHhRYWE1MEJiaUxGejNJVzFrZUxkMUo1Tytk?=
 =?utf-8?B?WTVibmVzd1YySW5iZDM0WktXck1HOHhBeTZMcnYwc3Q5R2tjbURwMnVGekUx?=
 =?utf-8?B?YnVkaENJakQrVjhrSitySWhySm0rT1hiZ0wzbVNkd3NuSFBMMkJJZzBCeG1L?=
 =?utf-8?B?RnhySEVlTWJGMi9yWFBMYzJLNGFDOHR3TEtnbXlqMnYxVVdYVStBM2k5ZXd4?=
 =?utf-8?B?azQzdml5MGdDcDJTRlhra0xUNUk5dW54TE56a3BiRmhQRUhYdXk5K0loL29I?=
 =?utf-8?B?cWlnMTlJOGZWNWlMNHd2OGIrQzJ3YmZrSmJod1N4UHAwTHJ0R201enBTdTkw?=
 =?utf-8?B?cWVYb2tBdnFuWlNIaVlyaXA2L2tLVFM2TEdSczc0d0dOTWhCUjVmUVFDTGls?=
 =?utf-8?B?aU1vM0VJZndFQ2R4a3d5bDBRRHpoRG9YV0xJRjZEM2lieEp4c3RkVXVxeDkx?=
 =?utf-8?B?OGI5RkJNcUdrMkpsWTZ1cEYvS2dETGs0THY1Nm54RmFrN2paZnVOQk41L0JZ?=
 =?utf-8?B?aFhrVG9mcjhmN1Y3MVBlN0hGVmwwN1JvWTlyZ3lFUHc2WWdxWlR6b0dpTW1D?=
 =?utf-8?B?TktvVFFEYVEyMG5ybk1yanhMSDhPTG10S2xKK1FjdnZvL3VFSnFkY1RBMk1o?=
 =?utf-8?B?U3orL1pNckM3ME05Y1V1aTNIZU9jaVZ5SlI2eVpmQUN1TzRqTGY2TXRTQi9a?=
 =?utf-8?Q?7ddqOJpD3NJkZt+s=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66099ff5-bf20-46d0-6b99-08dea067ded1
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:08:31.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTfbO7RqiC6RVKhM1AHFz3rKk1+8YB6Yum2+6sOQ4G2V7vrmwz587WfK0bitltIY77WqgsoZuX7CUBVZALhLJmiBuJ7970b+zfSZQKfA3Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8428
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240324-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[citrix.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[citrix.com:dkim,citrix.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65B7445B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> FRED and PTI were never intended to work together. No FRED hardware is
> vulnerable to Meltdown and all of it should have LASS anyway.

Careful.  All Intel parts maybe, but Intel is not the only vendor
implementing FRED.

~Andrew


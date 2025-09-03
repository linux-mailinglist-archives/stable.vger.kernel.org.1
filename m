Return-Path: <stable+bounces-177644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9C3B4272B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 18:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569213B7D42
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5BF307AFC;
	Wed,  3 Sep 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hudbM3g2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MYjor0jh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451D307AE9
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917867; cv=fail; b=nUzyhxK4wC9ys+NATo+zF7R9ECPkHPewgyIjioob0RdCmvj6FGQftX+7GVwwQz6NMWENC3eqpIzFEwJtNPmsghKEk69iu3aDCOXEuZ+6Pxby9yyj5LZXDm6jgVT6ji0j1XM3gol5ZjB7Et+AuiaZLWPVKyhXRlvjPmKbQCuB7sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917867; c=relaxed/simple;
	bh=AFREfmfPJyp9FUzCRV03yzKla68DNnQDSMiO8SGJ1bo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oIX/jq8Zg9KfyrQN3DxIP9tK+QqPD7UEnvoSXC7wZk9F/9aX+WSLwr50pHcDCCaimxcKDZLZOtghEnyOtEld9lx2I02rTHEPEAQrd6h+DnXsNhE5ALOqdGFv5zd+1h7iErl9Xj37+qOl1s9Idjg4NheNo5HLbX/L9OCXL0SB21Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hudbM3g2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MYjor0jh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839NHn5002460;
	Wed, 3 Sep 2025 16:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ge8NemV8FejgiJ8HHIbguhFhh+pYT+J1M121WT9z/+M=; b=
	hudbM3g27/5g1gM4AeIV2Zmc4LyraHzLfpIUlViAN1aNKv52xMZSA0CwSvaH9MPx
	qKkalNomTCtePsbqmRH1WXLd9KSQafNVYrEQKnGtrVI6BIc6R4VKgw/4ooIq6K0a
	CKTUEB0YrDQsYO+oWVGUCwKlpgilH8jm0q9wnDThY5wOaQojTFHVkihPKiW5Iody
	+3FQLLtr4oRE8cla25H7yQn6rgeqm5snlIOGBdKepikDSb4gPhD5oI8gphO3qrww
	FuYx6y5bhi/79xCoQ7ULRIAgMlMtzxQFiadUarKsm1ojMhf4Dy4T0bVImje6LKZ8
	rfKjs9G/Aen1wRchsXFY+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvxusy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:44:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583F7Tjv036094;
	Wed, 3 Sep 2025 16:44:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrahwvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxX1rEvMD8P9riyTZHoWQuaiiyLMqWCwitT6nr1d/Ftf7LB18MPKmSAMhM33r04G7NTZK3GxLyq0fBrsCGH4y4e+Dzh9orCVcfQx+L7a5lvxRe7Noq/q9oddwOt4iw2U5J1dxXR9vhSE5dO3cbu287GoNSlXnuCBBpzTLwgsyHNBcy3XUYINcjo5FONN4iaUPiKo6APwUCBEJm6i6uLBLn9Q4rdN7GeyW2Hv2B0+gq06/50klYUdHnV3GHyx8G+ffkR9DoYXqwXU9kZO6Hgt9JLvv1GjjedyTa5xrKSNBKqstczNgaxlt3C+qlijniNItgIrt4JKPdveQYKqaWKHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge8NemV8FejgiJ8HHIbguhFhh+pYT+J1M121WT9z/+M=;
 b=IONjd3k+3nPGSi6g7GPPOTEKN6MsQC8q4VYmsUGx7Cz07BJ60VZ1Yfm/D/xz2PO+qrtOg7MmVAC7YZZ4MlBxA1JIkKrFBy2V39xoHnB+cmXUMNjJf2DXJN5XLx3CcNG1S/zUWS5vq39XAm07ddLGDRaPSVBQ0GvXl4TB/yVJFuGCoU8mx0Os9LDP/CWQVhF72az1Us7x5r4aAcBG4Sp1eSrSsinl0mvKgsH8Ux2BEtEEliOKePl7l3JsToDoOiIPwbbdZdLfk2ah+7ZFt5WvUQjuVKJGQ39mbPEzBLYo2STzU3s23BGIpcg6DWOuhIECP0oebtR113FGYnNMie2SoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge8NemV8FejgiJ8HHIbguhFhh+pYT+J1M121WT9z/+M=;
 b=MYjor0jh0bGGThR2R9EUlYlbRF+DVcCjj++5/Q24K2rwXLTqytMWXhTPwzxFtY8kEkyWYpdXxR7OiY2tAOT7RGXJOD8PUkwUbn7baHXtuV4NsCt+QjPCgW2xRPhQsNAy8cZ4WA4UGJK/xnYZsd/LYjYD1MV60HgnySFbZRAYjWc=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by PH8PR10MB6670.namprd10.prod.outlook.com (2603:10b6:510:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:44:04 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e%6]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:44:03 +0000
Message-ID: <dddfe42e-31c1-4bf8-b15b-b7585b708a04@oracle.com>
Date: Wed, 3 Sep 2025 12:44:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 2/2] KVM: SVM: Properly advertise TSA CPUID bits to
 guests
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
References: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
 <20250827181524.2089159-3-boris.ostrovsky@oracle.com>
 <2025090235-washroom-twine-5683@gregkh>
Content-Language: en-US
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <2025090235-washroom-twine-5683@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::26) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|PH8PR10MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 644115e7-1b7d-4c94-73cf-08ddeb091766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFLMWxLT1hScmhRU0N3bngvSEV4SGJaTFFERnZwd3oxbmJLYlF0TFR3OU9U?=
 =?utf-8?B?QXhNSjJKRG1SbzJHeU1ncTFra0M1MC9XaHRSNzA3aXd1Z2xoT3o4NFZPa1lX?=
 =?utf-8?B?bVYxRGNtL2pTUmsxRkt0VDBCVmcyNlpHRHhtRnFPUi9RSXozdUJSM0wxa0F1?=
 =?utf-8?B?T2FNaXdYRDhFR1NEL1VSN2NmV3F1L3lOUHJySCtGVHRQdnVQbUd1WUhicWx0?=
 =?utf-8?B?RVQwQUVZZHg4SjFtWEwzUXB3dElZc20rMUJ1OVcxTE52MjZ1d0ZVcTliOVBp?=
 =?utf-8?B?WldFTTY4eEhBK2UrYkNUU1U5ckZvdVIrYS9oV3ZWb0ovVytmeXJwb2J4Z2x4?=
 =?utf-8?B?dlpxMkJpSEZreEl0VU1PSTJzcHVRQ0pYaEtIai9EeEwvTUcyS3J3VFN2QnBu?=
 =?utf-8?B?Ti9ZY2ZnZStFWkRYK0daUG1PREJCSWJyaXhZMGJzVkdPRXZxUWd5bHhIeEdN?=
 =?utf-8?B?OCtYK2NVQTRMVDlJekpiclQ0VUpMcy9aN3UxSEdXL0ZONW9vdlRYV1d0QVdG?=
 =?utf-8?B?VWxzREJMOS9KNzBoN0RJVDB6OXFLbmNSYW83UVA3ZVppNHpDdklkUjdJVzl6?=
 =?utf-8?B?KzFSaVJPUUNncG14UjdMK2orWEJwcXJVdjlSOE1GSS85YlEzMjh1UHFCTmps?=
 =?utf-8?B?Qlg1YWExOU1pZ3h6K2VCVUxKZVQwQkp0T3djZThxMkw4Z3NkcFlQOHo2eG9P?=
 =?utf-8?B?REg1clZCTkxtN2wxalpvTlFabDdSWGJqNDl5alRDdUJCVzhzZDFqMy9IUklG?=
 =?utf-8?B?M1J1MGwrL3I4SHVGN1hlbzNkOEhSZnR2Q2dvV0dPclVIejIzSXIyUGVnQWhC?=
 =?utf-8?B?QkI3WnczSEllQmZUZTZvNjR6a0VBZ2xnZHVPTG1yZ2pFZE80WXdQWVJ3TGNr?=
 =?utf-8?B?RStDc0tQelA1UW5kZmJRQ243M0tOMHRHSkIyU0p5UnFrTUhTa0d3T0lEOTVZ?=
 =?utf-8?B?SEUwaGVUSnhBSW5ydXN0WVUvTktObDNQdEg1V0MyZUhNZFdVTitkK2YxTk83?=
 =?utf-8?B?TENJMGtkQ01xZTQxOFJjazQwSk5TUlZuNE80Y1prWFlYdFNuVkxmUkU1QThF?=
 =?utf-8?B?TGt1ZjdqZGJYczVDVm5rYlF3WEIwZElQNlV6MzZERllCcEwzR0NuV2NYSnpk?=
 =?utf-8?B?L0lJZDg0eGF2bmU3QWZBYVl2Q1RpTlRKbG1WSEZZb0xCNjlBR0prdzRBRVFQ?=
 =?utf-8?B?RXQvUHE2KzZpNDZ0Z3M4bnlVczNpVzFQaHhMcjExRWZ0MDdsZ3JMdTdKNkZ5?=
 =?utf-8?B?bE00a1NueVVKSW5OaVRFMnFyQjMvODUrUENodWsvbU5EWEl0eU5FQzE4dkVq?=
 =?utf-8?B?ZzgxdWFjYlNCYm5iN0lTQ3c4ZDhIR0NZVVV2VnozV1JhVU80eCtFU1dnSVcv?=
 =?utf-8?B?TUZWY0lnaWdTZy9ETEJ5QlVBM0FEdk9IZUhZeU9Jem5ZVW5kMHJvUDY5V1dZ?=
 =?utf-8?B?MWhSVEdJckUzamJ0eHZYTnpJQ3BiQVM1VnV4M3g4NjRCZEcwQ1AwZHRUaXow?=
 =?utf-8?B?SjBrZGhkSG5Rc0wrZFVWU0RhSFVuMmJjNFJjdCtkOEJUellGN0pZK0xPTStZ?=
 =?utf-8?B?UkNyTUdXNGJSZnV5dW1SV3BOWVVKdWNEMWJ1VEdjbjREa0hZcTZySnFJc3By?=
 =?utf-8?B?WGJaME1TRmFMYUk1VTU0NWJ1Nmpnb0NROG03bEZDaFFCTXFLMnhPZ2ozQ3RY?=
 =?utf-8?B?M0tCZ2pkY0Vib29nSHRWcDhsRU53TjArb005VzdsZGFHSWdkaTJPREtZZzE3?=
 =?utf-8?B?cEJKSldOUUZyVzhsOGEzTDJlMFdlbkloc0M5Zi9ZSTVvTWpxTmJMUU1vVXJE?=
 =?utf-8?B?MW9NSmUwRUN4ekJJdVd3TnY2TWZoYTBHUGl4d2ZtRTJ3dmRUMlg3THdkY2xh?=
 =?utf-8?B?OTZsYUh6RG9SdkhXMEZ2NVNFNjRJNU9EYmYvSTM0OTZ4SWZKWmNKc1hkR3Jk?=
 =?utf-8?Q?AkJFAX4kHI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUtTRU1kOHA5WC9MTzBnRVljbThpcUY2QlR2eEVudmFkUENXbVhVbTFLRHhY?=
 =?utf-8?B?ZzJ5eGd4VnZuMDFjSVZzNWZ6WjBOWFhOdmpXTkh2ZCtqNUFyRDE5NWdTelIy?=
 =?utf-8?B?a2FwZmRtQnQzdkFoTG9aSU0xd2xVYk1jWUJXSTNMUkdIMVJucEhMcm53Q1Bk?=
 =?utf-8?B?ZmNIbzlRa0x3NzJSSWErTTlvVXpJemNOSThXNlJRTTZTejlueWVWTkNObXlC?=
 =?utf-8?B?SUF6N1hmOFRoNk9peGRnQkdHMjRFRWtCblNua1lsd1gwSnZlZVJhSFJDdUVF?=
 =?utf-8?B?WkJoM0NzbERtN0lFQ1RXTGxVeUlOSXF6bDB6TzA4UkVRM2tXNVNoY0NGRWx1?=
 =?utf-8?B?VXl3c3lIcnJkYWVYVU8xdkZrN2lLc2hMV2x3Q3ZERDNPUmFaTmR3enFuY3I0?=
 =?utf-8?B?N3MzbkJvNDJUbWhFUHgxWHFtTHczYktqUm1Od0tUaDZ1Y2IyVzAyVExJNklW?=
 =?utf-8?B?VldZTkxYZzNyVmh0bThRMmN4ZFp2UmN2Qkt2UzFwTHBFSWpXeTRXSEgvOG92?=
 =?utf-8?B?SHFuYmNwWjAzT1J4OVltZWIzcnBod1dzL1RQdzZ3UWhpaUxOQmIvTWZRb2Ex?=
 =?utf-8?B?QTVHWkRXMWt4S0FGeW1qaWhTQ1BHdnVRU2tlVmJXb0hEeDVPZFBGU1ZSNzR0?=
 =?utf-8?B?QTM1ZGcwZnB0RFowT2VaSDRUSEx3MUsxMnBSNitNeVUwaXNEQlVJWkxkMVJv?=
 =?utf-8?B?alAyNWFuZnRjMzV1N2Rtc1N5aDkrZDJJY2lBaVp0dEdkMWU4VFVYMFVscnl2?=
 =?utf-8?B?QVMwU1haT0pHV0FwTFdCYkJRM1ZRS01aRzlKRnJlSUNGT1NoR0I0bjFybi9J?=
 =?utf-8?B?NkNleFV5OXpCV2J5UFNZN0kxS29Dc0JwV3J1cXBTWW9QNWQ0TFFqUDV5cFhh?=
 =?utf-8?B?OE9paU5HVFR5UXJyRXppR1dyT1E1Mi9GQVM5bEpKd05ITFMrMzdseEtYVFNE?=
 =?utf-8?B?S3VybG1rN1ZtdEgrZ1F5N1RLVE4xanNaNFZqaDFaeHBUS1ZmNDV5WmNqUkhB?=
 =?utf-8?B?YWxUdytKYUhJRExJdjBmVFFETGk2UHdJb1lqdWF4RXFhVnBjbG00OVk1Z1hX?=
 =?utf-8?B?dUxLWmw2eHROTlU1KytEYWJoTWZYZCtnMk0wL1ZRaHpLMlBaUWs0SnpUYk1z?=
 =?utf-8?B?R3BFU0h3MExsbW9vV1JwU0szaUphc2tnNU0vZlAzcjc4c09aVzUxVXFMM215?=
 =?utf-8?B?NlZheW5YUy8wN3g5bUQ2VENMdmpLQ0Q4c1FlRDA1eitMQk4rOXRuT1lWVGVM?=
 =?utf-8?B?RmtaL1JqekdHS2I0RFptajRLZHgyZFF2alRJdVNVTEhGR1lkK0gyTm0xL1JI?=
 =?utf-8?B?RnNydytSTjBMUnhrM1drQWR4cXpDMlh1RklOUTVoVVI4bFI2azU1WGtzb1JQ?=
 =?utf-8?B?TTZFTTA0YmM2MzBtazRiMTRLWXk4ZVNsMFNML3JCQXFxbVd2YXc2UTVpVHdl?=
 =?utf-8?B?cmREQ0hMUnVXakZuWFI1N2V1SzJRRmhZWCtOR25UVVBWMEdJaDNQaUVrdzVm?=
 =?utf-8?B?dS8rK25DcmJXWHFjekMwZU9mZG1LcVB5VFFiVmNyR2hzUU9nVWRjeWRvSlpH?=
 =?utf-8?B?Sngvdjl3OGJIWXpjNWJCcGxjbEgrN0JLWmdESi9nL1ZCeE8wQTBvTG50bHJu?=
 =?utf-8?B?dEw2ZkI1eUY0WFNMUG5TTGVVc1Z3RUpmZzhMNGZwZDlsdHMxRXJWZ0xpdlpB?=
 =?utf-8?B?cFZSQ29CY21nMURRU3VtbUxKTzkzNWlER2NndnI0R0dVWkZMUW95M1lNR25n?=
 =?utf-8?B?RTFrT0ZEeGlDZU1mMXpYdW13WHdkU1B4WmpZdUF6R1RkVXFCTEdGRVA5eHB5?=
 =?utf-8?B?SnVwMmc4RVYrR0pyOUIvS0ZQZk0rdnFrckoxQlEwZjZEdEYwdHZHNE4yRGt3?=
 =?utf-8?B?R1g1ME1taXVTSExiaWJ3c3lUR0lKZFdoNHRKR1l6bVBSZzYydGE1Z01VYjJI?=
 =?utf-8?B?RHkrM01lcWpHdWNsVTB4WHcwLy8xWDJjd1lFZkd6WHd5OUZNQW1zOXpwRFBl?=
 =?utf-8?B?V2FxaWhZQU1rNERGSURpd0tFNzh2NWxNaUJCMmxBWGFTcE5CUmZYcG5aT2My?=
 =?utf-8?B?Y2tBZXo3QURxVHB5VkZOSjlSTFM3OXFiR25ySWRwb2RvS0xNOENwNEZPNFp4?=
 =?utf-8?B?UURINnY3VlNiR3dRbTJPUUZndEVjWTBIQjl4bzhWL2NWRVZBUUxUTC9VZWpW?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hEbAdGdWSjPMsMeFpLzXEvp16anCyjgbylw1pqz/YWYdcjTJ7CeD7TcbZUvqUJ/yVLjFQvYNLaO6UxgJBQuOlgapxE6B3TmnlPkj6nqnreUxRZCJf/a0VJOM+moFLi2WzbRd01cdnOywlAMds5PltYum9K8JRL6cFbq4RUptlQpurhi0rgrh8pIKw2Q8wrNbJrunqeFfNX0R2DLz2qj7EGgiT1VBoDE81sVuH8VvXYn0jVHt7ROg+BqwxvEpIDYfgtgy0EuOgaOzXQWTg52HDbopX8fMRmAOWo8JuZ6tFQTeX6AgX9fyRp5/jkdIoBJwEU1bixy4SJ4sd2RvsPWpFMabeoA1MJQE7wTT0awYTOBRVhUPKpMBdOW3fNM5xD1napFSdG313WM2Srtq6wtaiIDoGxWn462lDLFq+7SZy5ATzr7SD4TBiXygCcm0YwVLc4tf31pHHJWsnfCkVOt5DhYEqmVg32LFPrt6/IBEPDCqB7ib4EbWRCL6ftpnNMIeqjLinTzTGHPGJy1dg83nvcuMt/zTVao/d/P9kUrWAzFTFBz3YFhGGbPXmNqaY6UANa/qkwZcZBa4Lbyx1pPs/mV3PIpgvz8ys6JT7eGRr0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644115e7-1b7d-4c94-73cf-08ddeb091766
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:44:03.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZvopB8316tqgSpxUqpRlPANCYWTpkPRu4wXDVCdBdXoTqoBcfT1l15u6q9i/odkknWqU2qtkWLhx1N4OgynMSvPSOkT8/n2mrv+WoNrRn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX5NOY6rAkwJOm
 zMWDNhsbyFgh4NTq1yonJatULTBfTQZF82r+8ewP87V5ba+vWis8OUPfcT+IOS/FCgGJuOFCKff
 xTGkaxheACTCtQ+szDO5isehW09BEJv2V1BJfRuf62qdTAcgU6Oz6o1nY3lYESj8bBPQtK5cEAs
 58X4a8vaGPGojfR5okXLpXssq3rsr29O/h4ezZJQKqHkKYCNbMBuN/xnV1lPnYMJXPGk0U15yEh
 nE3S8Z0j3Td8ByptkZrNQPcfbp0sPG9Zpf+hIGUqbSriLib3hmHrJjywwd2TC9obRdo3CFvKbEP
 xVePPK/dFH85+6q2yCPc2a5rmd3glGxIMb5sFXJm+A0gE87WP7NEczWrIGEtUM42JBy3r89GGAh
 A+A//Ge4
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b87059 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=dhwBlYXZeME7KntqIEcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GGbkc117m6UNjxm-Fqxfok-Bs362_LWN
X-Proofpoint-GUID: GGbkc117m6UNjxm-Fqxfok-Bs362_LWN



On 9/2/25 7:42 AM, Greg KH wrote:
> On Wed, Aug 27, 2025 at 02:15:24PM -0400, Boris Ostrovsky wrote:
>> Commit 31272abd5974b38ba312e9cf2ec2f09f9dd7dcba upstream.
>> Commit f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 LTS
> 
> How about you just backport both of these independently, as this change
> now looks nothing like either of those commits :(

The trouble is that the first one was already backported by 
c334ae4a545a1b1ae8aff4e5eb741af2c7624cc7 and it missed a few things. 
Some, but not all, of these issues were corrected by the LTS patch (the 
second commit above).

I couldn't figure out how to separate this into two patches so I merged 
them into one.

I suppose I could provide an incomplete "fix" for 
c334ae4a545a1b1ae8aff4e5eb741af2c7624cc7 as a separate patch (but the 
code will still be broken) and then do the LTS backport.

Or I can drop these two lines and simply mention these two commits 
inline in the commit message.

-boris




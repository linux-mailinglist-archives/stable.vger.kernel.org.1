Return-Path: <stable+bounces-165108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F8B15217
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48D67AD4F9
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6F126F0A;
	Tue, 29 Jul 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hR2XjKCg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8xuC0Y6"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674F215773
	for <Stable@vger.kernel.org>; Tue, 29 Jul 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810312; cv=fail; b=FlV4I76a1d2jyn9UzaV6OAZ84HG3F68Qnh+EfRs1M5wqJ0HhPwpz8jiyVcHGo3caDIbW7faGN+3cJaq/L09CWmSkee2wvecgoYf6YwSO4OmDVWqYcWfWmsvQwgNM+OGp7NPb6xXVr7DIDDyi72uqb4bl8m7UU/qrK0mZIzIwu/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810312; c=relaxed/simple;
	bh=1qHsfbeZ5xVmc+NdBihiNkGqUE0QxXz1MJzXmwNdqts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ab0QQlCQxZHUIGRnljenX3MkfSeAFYlVhtjn6iCmtuX++t3Gh72qlsfVp+bV0+j6UGN/+4RIUAYtApHhEdxq2QBMK1pYe1xrxfOP49dKnMTAqkh6OYVXbfDMXn5iq6oQI574ODxbRxX13VcoRouaIlryc00fOPjKgQieXahNfhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hR2XjKCg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8xuC0Y6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TGuDFp030255;
	Tue, 29 Jul 2025 17:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JKF0GNoISGIBP5xw+0ArFDvFeIc7ahIQKkof508WTXo=; b=
	hR2XjKCg0WAsZe9vYYBawGCAV4cGDP8RY3xNu2/4zESfMOayVfqr14cb1LqYUeHe
	/t0XswxRP4Q5B/ooy/uL/LZB+7Hp/bshY4Yt169WNaXJTf4EWTbihK8aG9JoAjw+
	nUmhdQPZFo54y+mC+EJ5akBMUNQvtyFpgNj+9eEhta418bd2tNe3/nO4kJwzKfuL
	LWalg1H+AE/mPSJywjI6Sv1dqJ1SekG5Ei/CDH5ofE4zPphRja8M3HuSnI1dZlA6
	nneGt/qyJjYZIkaqJgoBl7jR9mrCczZjJ5CM1EPWpqblMP/qQdpfxA0gTOr6fkDx
	Hv2T9MtqPqAHcm0R2kVxYw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484qjwr9dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 17:31:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TG5n1S038558;
	Tue, 29 Jul 2025 17:31:41 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazon11011045.outbound.protection.outlook.com [40.93.199.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9xshc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 17:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C26hUE+lxpQNssXqk+4cXQ2AsoTcQFzkE5O1x0fo9lGttlWYPmuaom8v8XU1rl1H4xJ76ZLRg6CukAVybjOe66Y0KWBi4r7SgTcyYnmXRaIHNpiEli6WO4pSg8UEZQoVOzUoSNq+r2U8VnupjvAwBWR0X/mq37smJDFk8UA9yzBn82jF7AuKmBxxQk6yA1BVhswuRnO6CJXUKyqOz1xZ63Puk6bHmhlY6lNCg2AiG0aPOS7K3T6Q0OJVMAxav0x4IYTOsUemL7I8sPlP8h3X8WFZZtQndpABjrFMCA1xkE7Fe/VBbWFK6+bunPCYwjyqnGehE63xCBRsev40flol9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKF0GNoISGIBP5xw+0ArFDvFeIc7ahIQKkof508WTXo=;
 b=dpERJq2eAFtDLJoDdorBGWw4IHyc6KBHR2ecC9gLdy45s6heQrRxm0sT366kH3I/K8nHVa6cNQ89Db6tAe15jTZPrFVGATBZmrKNRdBTbyejmIlGzTiNgIldRaNnvSoJhCt8Xzi7ijAa7hFgVB2dawOKLzmGahVjk4r3xjenaSNfiTapC28MeTe7ovwzgjOu8xYSFx2Dt4InwshOQl3jMUkpY7qxyDJQxLnmTE58cqpVHGty/mAekjGZWFxVzh6DwizCpXCSYuvdstLNPduy2ldw8sMssHH0fHBtKV4qgKQfRVWP1wu/giD2jflxlWW9e7iVGTVhks5DQh4cv2g8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKF0GNoISGIBP5xw+0ArFDvFeIc7ahIQKkof508WTXo=;
 b=w8xuC0Y6ub0o2d0HUihwENe5m+cPIFYHNv+q9zZkMWIVvWdHX98ZMjxFld7X8r6yF4F1358ycx+d+lZTp4AESZSNbVxR9SvTcGJw6WGmqVauQgJ7ARSKkW1GmfjImZg6eefj2br7knyQvv+k3H8JiHaDWzFzisYfX2zjZ7xyTkE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB7028.namprd10.prod.outlook.com (2603:10b6:510:281::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Tue, 29 Jul
 2025 17:31:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 17:31:38 +0000
Message-ID: <bdc6b98c-1441-4fb0-9ac5-96ae7ce732c3@oracle.com>
Date: Tue, 29 Jul 2025 13:31:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
To: Olga Kornievskaia <okorniev@redhat.com>, jlayton@kernel.org,
        trondmy@hammerspace.com, anna.schumaker@oracle.com, hare@suse.de
Cc: Scott Mayhew <smayhew@redhat.com>, Stable@vger.kernel.org
References: <20250729164023.46643-1-okorniev@redhat.com>
 <20250729164023.46643-2-okorniev@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250729164023.46643-2-okorniev@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: c167e3b8-a7d2-400b-7448-08ddcec5c5ef
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bDh0NXdGMEkzU01YVm1WYVMvaHkwN05WdUNYeGtHbVVZSFVwTDRRM3dNLzZ2?=
 =?utf-8?B?TGRhRUh1ZHNiRjd0cDZJd3N6VGsvWXhnNkxmdjdMMjJpdCtWdDhkTDIyc2s4?=
 =?utf-8?B?MEVOMnNUY21XdzlCK3htTmErV1lzeDZobEMxMDVZOER1a1J5SERnVU1VWHVi?=
 =?utf-8?B?K3p5dWM4RDVqZmRvNHN3eTNkeS83Z2dhOGZJNFppcUtsUmR4VlcvSGFzaU94?=
 =?utf-8?B?YUhKczd1NmthVTg1cmVkVVc1dG5lQzZGT2NNVmlXS0k0QURpUmpBQXYzeUlX?=
 =?utf-8?B?ZWtmQ01JTWw5Z0Ztb0xBSEQ3bUZmTkpqbmZwZ3FKUXlpRVUzYVFpN3ZDd0x6?=
 =?utf-8?B?Qk1hbTlEM0lVckJxWXhTRnNSZDVRQzVhMlU4MmRaNXVUWGhqMVpQaHcwR2JB?=
 =?utf-8?B?WVh1aFU1VUJ1bStCWXdJM2xLNUY1Q0h2MDk1ckloRWxXM0pMQkhkUTNIMGZ4?=
 =?utf-8?B?OTZRU1Bnay8vQWY3Q20ra1lPamFhTm54QjFaSUZ0RUhrcUJ3T29Oai9MSXAx?=
 =?utf-8?B?NUdMM21zREtXeU00dU1CSjczUHVsN3VNU3B0SEJ4VXB2RTZZY1dPeTEzWlg3?=
 =?utf-8?B?UEVuYTg4WjU4NndNMTdIUm1Xd2kxODBDSkNaRW1rOEhWdmN3bmRVVk15UDFn?=
 =?utf-8?B?YWl0YzVIZTA1NHowS04rTE04cm9nTVluKzI0ckwzTWV0ajF5UVV6NUZBYTNG?=
 =?utf-8?B?SHBpVk9NUUpFS1NDeG11bjVZenloZEZPb0xod3YvckRzQ0NZMUtUZVFhNGVh?=
 =?utf-8?B?TWs2UDBqbVNTVDVNWTVxTjZiK2RQZnNlREhCNEIyTk1DbDRVSXNGVm9IVnZ6?=
 =?utf-8?B?ZVI4UHJJMXdzQi9mWllDS1VYVTgwd1VJZzM1cExVd0hoYXdNZTYwcFNTZit6?=
 =?utf-8?B?bFUwYWRkc3ZDTk5udWNnY3JBV0ZlYzJwK0VVN3NzdGw2ckxKdjl2YmRobVk1?=
 =?utf-8?B?cGJCOE5JZmRaM1ZnWEdsczBlSzNwdEdCdmdTTTdKQ3pnRXk0OXBRaWlJeFB0?=
 =?utf-8?B?R2p1eURmcnQ5MlFNVVRUcHlqVDdpS0dmOXRzVFpXU2d1aHZXOFhqWXRDcDVQ?=
 =?utf-8?B?SzdZWk5ad05GS2g3cm1vZm1TV2YxWitDUlJjWjJVMk9yemdDWkdncmZrL1pZ?=
 =?utf-8?B?VGZLNit5ZVJPV0pSRHAxNndzZ0NFVWtDR1lnM25pVGtKQkdoeVpZbGkyemFY?=
 =?utf-8?B?QkhqZGVtQ3Y3b0JDQUN3WVB6V2tDdStQaGN1YU1oSFZZVFVFdmd2SElqN09B?=
 =?utf-8?B?c3hkUUlHZEdYSlNmSWlpU05LMW5lVVFlejFsUVY0Vkx3d0xialIweUREZ2hO?=
 =?utf-8?B?QXNNRkhsQlZhV3Nmb3NrZFZSbkkvaHlPU0VvYjkzdHRxb3RTcEIvNGg2MHlF?=
 =?utf-8?B?cCsxQ2x2L3ZiQmVhOUZnQ3hRdEIzWGFTQklncENDeGxJWitabjBMNTd1YW5Z?=
 =?utf-8?B?alR0Y2RQYWFEV1B5bTVscmxlOTAwcVBKbTR2MEpBZ0xGNlZOS0h6NzA1b09D?=
 =?utf-8?B?cVhGVzVzOGI4dnN5UWhWK1NDdGpZaHdmNWhyblRhaHVnNnloOXBvTUR4bWNE?=
 =?utf-8?B?YmZBYmZYRGFidkFJR2tDYUdReTlXaElJTzVVU3c3aG5PVkFqLzJOZTkrUFNC?=
 =?utf-8?B?MHNlZTh0amtOVS9NaGVYOEk2MXI5MURnYlhqR0dSSkNlenpUUU5sY0JyZ0gv?=
 =?utf-8?B?amlhSUxaNGVMTzZEWDlaa1JuZmtOTllzeGFxS3VmcXJSU1VnZHZlaTgzVEp6?=
 =?utf-8?B?VzZiTUkxZmNkZWlMWXUyM3g4c0xvNmVydXdGcTNvQmZzZVU1R1FyUllTWVlv?=
 =?utf-8?B?aTF2TFRFNGtNUlVFK1AvNGdyWDdQY3pNSm5kUndtekhrTjNkSlkvN1paZjE5?=
 =?utf-8?B?V3FjNnQ4OVExK2V5dWFFMkY2SEYwUGlGQllMNkMvaE9UajAxbWtnQXo3L2Fm?=
 =?utf-8?Q?s9Z7xYjB6wU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z25ycld0WUJXdlBIckZjcnlXSGRJY2hQTklwblFISDhrMXZPdEhMUW9UbHJh?=
 =?utf-8?B?L1dmN2EyVFNQd0FtaFNNZVlKZEh6dGRFV1duM3UzTjh6SzRSMGgzbUdsa2FI?=
 =?utf-8?B?aEx2aGxCa3pkMUNBdHpuc1h1MC9PWW9jcE1sS040YWVkbEFOZWlleXIwbVBC?=
 =?utf-8?B?N1ZyUVR6VkJVWms1eWhNRURxUURkQ1BLdVRBZ1BhZithNWRLQjliTmpwOXBq?=
 =?utf-8?B?NktsRE9vZ0NNMnNQNmVuRFFRUkIza3JWUmtUam9BTGQ5TEJrakk1L2RqR3dO?=
 =?utf-8?B?YUZmMXdrNTJNY0E0ZlQvZk1qalZ0SG5SU3pzd1l0ckN5NFRNaVc4QURabTlv?=
 =?utf-8?B?ZUJTZHFOaDlLbFUybkpqemoxcDNOQUhrUFhsZEZZMFY4SzNPcVo4bEdCbzk4?=
 =?utf-8?B?RnhEUGdmQ0tRT21qTzdKVm10NVhkbllnYjhTVWF6R3dBRCtrOW4rWkRPVmRY?=
 =?utf-8?B?SWRzV0VHY3FweU9jZGdEUGVSTm1pSHVmVEpKb3cvQkFuYVhqeGNvTjIrY3Av?=
 =?utf-8?B?LzNxSTh6SXdZblFod1Nxc2FBWjlBK2FvajBVT2Vmc3NOL2ZYZ1A0VFFBTHQ0?=
 =?utf-8?B?MXhXdWpIbFU1NHZLeDkyYTVQUVY1N1MvNzJ0T29wdDZnSUVrWGdORStNR09C?=
 =?utf-8?B?SmlSR093alFSOCt2ZUc3aHYyb3FrSW1MWVBSekxqeWtSTTZ4TU52dGxYQVQ0?=
 =?utf-8?B?SnZNU1pQY3FuMzliOG5OVSswcTNqcEpiVTRBRzNVK3ZoWmFHUjM0bitRaHRr?=
 =?utf-8?B?ME9pOGZNemNDSkhpblRZQ25yQ0VmOFYzcG1xb21CanFwazVWTXZCdHZkMHM0?=
 =?utf-8?B?S2cvYWZiL2xrRU4yQ29VeDJQNldERW1SM0d0VlhkakI5Qzl0Vm5VNGQ1OVFT?=
 =?utf-8?B?VVRaaHVhdXJDTGNiTmlRc3d1a0dMV1RuYU1IeVFrdWc1QVViSGp6Y01QQnVC?=
 =?utf-8?B?Wm1zRzZGaGxxZ0h1RkdMZ2dQTWk3akQzNUlwUExDTzNKSEJoS0NjYjR3OTJh?=
 =?utf-8?B?L2FOdUVIR3MwTnZtMjhIdXk0NHJucFo1VzJoWlBHK2VQeXBRTE9pd2JYemdS?=
 =?utf-8?B?enczOG1iZitGSVZidkZoanFrTThLVWQ2cjRJajJGaTFOdTdiRU05TjR6UFlp?=
 =?utf-8?B?eDI1NUN0VEpaVWp5bEh2K2hSc0JQdTY2ZVhpbkFCZExxREVUakdUR3BvZUg5?=
 =?utf-8?B?cnA1RFM3eDhER0F5dXdsdDU1dGhhOEc4Tng2NGJkYnlUSk55N1hDd0M1cUps?=
 =?utf-8?B?OXhVOG02UVZRN1dWT2xaNUg1eE42Z1RMQzlqZWtxZFM0SkhpWXZtYUhLam5L?=
 =?utf-8?B?dFo5VjBWVkpnd3Bkd3N2RnI3eWo2R0FVa25TVU5nWFdtckM5RlQ2VlkyMjlL?=
 =?utf-8?B?eXVXTnY4eEMva3BRRldWTklHd3RGS3B1OXBCWDNHOEJvYVdwVVRVUGFzL1ZR?=
 =?utf-8?B?Qm1VNk5hL0R1NHdOcE81VUdDUWpNRzQrT3lzREVBN2VUYkJQRUJTU3VPQVVG?=
 =?utf-8?B?Y3B1cmhOd1I4TkJxSUVwVGVjbFMzY05uV3JLRTNaR3pWdWM0Nm40QUNORXdt?=
 =?utf-8?B?YnFsZjJKMStPK09OeFlrWVVBUGtkS3pTRXM2NmZ1WWIrQ1NZdTA3THFXcElt?=
 =?utf-8?B?azh3TmRDcVk3eWxWbDkrQ3hsU2JpZDhsV3pCK2xrSllHWWg3d0xnOFRJdFRZ?=
 =?utf-8?B?WTl5SEIzWldxbXpzclVuTFdGM0ZEbDllOGllcDFxMEFTZEhzckFOSURzc2w4?=
 =?utf-8?B?TDZNMFFZanZoRzl3RGd0aGhseFRFUHd4NS9ITWhJSTZMcFJBVFV0YlRYL2h5?=
 =?utf-8?B?Rk1sbThwYUN3MEwweGpOVnc0bG9zUXhoTGI5V1VRdDUza2d1ZnZxRWI2MVVS?=
 =?utf-8?B?Vk15aTJGdE1MT1pMc3E5dG14OFBEb1cxTkZTeXZGTVVaNFVtL1BnR2h1WUVx?=
 =?utf-8?B?L0ZMYy9rWENENkdjN3FubkFWaXpRMHRZYVExMFZxOUUvSFdnYlk2dDNrOFlB?=
 =?utf-8?B?OUpEWmJVV1Y4QmdFa0h6N09tVHExMEhCOW40SmlIZmpjRzBvL3BMdHg0U3dp?=
 =?utf-8?B?MzRiZkczM2FyYjlOMEZsWkx5ZS9QVjMxT2lYVkY4bnN2dG5aSnBDYVBjWG8z?=
 =?utf-8?Q?lWpdiMtTIdJD1Ew4/qX+xfyM4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W1U0+no+iiw5VboNsQ/l268VB7XFdx1aqPMi3YILbbgMqodF5Hkcgt6+5NX0FMPo1ES5WFeiT36RXIKwJ2Rhabz3m89je8DcGf1cjZ93vjUIMPBxwNMBnkTsc9TuWBd6c+PNG0p477f2qSPAtwRW5FEhQL1VO6t7CdHsXm3EKMP5kRdLefqQBZdth1wz2KuZJumLGVQ6uY5j90yoCnSq0CPIOJO2SXDzA9fessQVwIkRV+6YfxoNt890tuWUYrmb0GL7xsfNP6GY2ITh9zoD0u1dG/0LW6xyRY7ZjLetSn3FclS5Oe5QIf4ahwDsy7p8sP/YTmAnC9HbrkkTITWbuu6IXcRgmmlHwaFfC+yWeVLj1WmceUoX9GrTN4xPSNZd/2HFbEQi6EbV8Hy713tBjEUS+epyXNn9uVrFfszFCbf69oCexf2MuRPSHMmnE0E6dte0KU8vwdCdVE/P2Yt34yRElaESLa4zcI740qGbyM6HLs/Mwei1L0+0Wh58Zabh7JMFLJXS/QMKZBsm9UKgDGZH2cclEO2DRgDcooBi7vYPp8Yhv0X9a7xADywtWnttzqwsdE/zjbN00aChDtX13ixrQ20cL7q4fcA1VPvAnCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c167e3b8-a7d2-400b-7448-08ddcec5c5ef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:31:38.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpWCILqx6QuEolMSYn7e7PSlsMvhAqONQL5ZhD9E0/pwPndaN9u4Qx++Y2loyXZpsuc2eYjU6NewvqWZGFAjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290134
X-Authority-Analysis: v=2.4 cv=OvdPyz/t c=1 sm=1 tr=0 ts=6889057d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=SEtKQCMJAAAA:8
 a=VwQbUJbxAAAA:8 a=Oe8qZgXGpKxJ2RTk_AYA:9 a=QEXdDO2ut3YA:10
 a=kyTSok1ft720jgMXX5-3:22
X-Proofpoint-GUID: sNkor7TyRM2PUZGhdV3Qasb-DYSlR2vX
X-Proofpoint-ORIG-GUID: sNkor7TyRM2PUZGhdV3Qasb-DYSlR2vX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEzNSBTYWx0ZWRfX0EBycEN9klrE
 FEcIYY4TzWoJcJ/+4Ghzq4oOAF5Yj4ZQWgJVOktL5C6NX7b7geaikIzgpSb/JWFVmEyTZTeSq91
 1tf1ctvSv1lFxSMG/OhNc/9icjPTF7l1C/wZvb20uCV+T0HYA4a9gwrFUmUp6/oV2MZx2JZF57a
 BGz0wJwYg8I7NBziJWKULfhbyhtaXHCvpOY6o8uvHnJTi/sQ4LD0b9GMmXNj2w2S8RMYcCeVKu1
 kXoGgvGZZooQ0OoroE+R5LVCTPS2dcO9Fcdus/AvDeRnHXIoQvA+U9iGnPd9sYZZ8SO+tW5B/5P
 uGPZY1GLpHiv9I2jA+aKvI+3tSBDbjuKlLwMn8FWELN4cKD8/sWa4TdHTB9e3jh+uBmTG48twPG
 YnRlLKXp8jvbmdGFGPKNgBSm8UHlISwcJCC7odqcaFp41iZJUffxqPwuCWURYLbl6kmO+GzL

On 7/29/25 12:40 PM, Olga Kornievskaia wrote:
> Scott Mayhew discovered a security exploit in NFS over TLS in
> tls_alert_recv() due to its assumption it can read data from
> the msg iterator's kvec..
> 
> kTLS implementation splits TLS non-data record payload between
> the control message buffer (which includes the type such as TLS
> aler or TLS cipher change) and the rest of the payload (say TLS
> alert's level/description) which goes into the msg payload buffer.
> 
> This patch proposes to rework how control messages are setup and
> used by sock_recvmsg().
> 
> If no control message structure is setup, kTLS layer will read and
> process TLS data record types. As soon as it encounters a TLS control
> message, it would return an error. At that point, NFS can setup a
> kvec backed msg buffer and read in the control message such as a
> TLS alert. Msg iterator can advance the kvec pointer as a part of
> the copy process thus we need to revert the iterator before calling
> into the tls_alert_recv.
> 
> Reported-by: Scott Mayhew <smayhew@redhat.com>
> Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side TCP socket code")
> Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 46c156b121db..e2c5e0e626f9 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
>  }
>  
>  static int
> -svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
> +svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
>  {
>  	union {
>  		struct cmsghdr	cmsg;
>  		u8		buf[CMSG_SPACE(sizeof(u8))];
>  	} u;
> -	struct socket *sock = svsk->sk_sock;
> +	u8 alert[2];
> +	struct kvec alert_kvec = {
> +		.iov_base = alert,
> +		.iov_len = sizeof(alert),
> +	};
> +	struct msghdr msg = {
> +		.msg_flags = *msg_flags,
> +		.msg_control = &u,
> +		.msg_controllen = sizeof(u),
> +	};
> +	int ret;
> +
> +	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
> +		      alert_kvec.iov_len);
> +	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
> +	if (ret > 0 &&
> +	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
> +		iov_iter_revert(&msg.msg_iter, ret);
> +		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
> +	}
> +	return ret;
> +}
> +
> +static int
> +svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
> +{
>  	int ret;
> +	struct socket *sock = svsk->sk_sock;
>  
> -	msg->msg_control = &u;
> -	msg->msg_controllen = sizeof(u);
>  	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
> -	if (unlikely(msg->msg_controllen != sizeof(u)))
> -		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
> +	if (msg->msg_flags & MSG_CTRUNC) {

Nit: can we leave the unlikely() here?


> +		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
> +		if (ret == 0 || ret == -EIO)
> +			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
> +	}
>  	return ret;
>  }
>  
> @@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
>  		iov_iter_advance(&msg.msg_iter, seek);
>  		buflen -= seek;
>  	}
> -	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
> +	len = svc_tcp_sock_recvmsg(svsk, &msg);
>  	if (len > 0)
>  		svc_flush_bvec(bvec, len, seek);
>  
> @@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
>  		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
>  		iov.iov_len  = want;
>  		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
> -		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
> +		len = svc_tcp_sock_recvmsg(svsk, &msg);
>  		if (len < 0)
>  			return len;
>  		svsk->sk_tcplen += len;


-- 
Chuck Lever


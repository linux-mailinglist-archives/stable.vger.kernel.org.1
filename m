Return-Path: <stable+bounces-211694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMl8HBXwd2lQmgEAu9opvQ
	(envelope-from <stable+bounces-211694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 23:52:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC18E0D5
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 23:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5A43018D72
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2392DC34B;
	Mon, 26 Jan 2026 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UArTn0wV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365446BF;
	Mon, 26 Jan 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467916; cv=fail; b=hH4E8lKIaVlBAV3GgjqAeCk77m9Q2uvf7tiUxOpCGNTsm1hiVhlgJlUhYMaxtIAKGqw/8LkkpiSM1tz55JOlNSFctBscCPj1LFvBFG+NzrTwdKeMQkGTDLe+JpIKP6rcm1zkGWUME4cR8YoMlklzmSENBFkPiTxpVgeRIvL9e6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467916; c=relaxed/simple;
	bh=C1Cj0BEaPgA6yzIb9y4ZWC5BYM2MeUrBJQxdZahbOMA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HCS4QNp2AQTgT+h2oYAEY+x1oWqoQWxkfgXO1LBHIkTnMHoSCyCw66xFoiT0qW6raOXFoYiZNgc514aTDN6HddVAc2LulyucV4gtdXcsFlf5NgJ15BVwHTx3vcBdppPA+jAwbmIzpSJb8Yxl5K2OE5weNNfTQKsZf7wzTvhSHOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UArTn0wV; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFU0pq029764;
	Mon, 26 Jan 2026 22:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=C1Cj0BEaPgA6yzIb9y4ZWC5BYM2MeUrBJQxdZahbOMA=; b=UArTn0wV
	0Nl5WGLn8c/KtuLaVkVS6mop9FY6BSFzTNt9cNXlkwzVjPWYlTht2Yw+oZ2aC/In
	uEdulnvn2sC8Au884qNt8AqBcA3YPyxrhajAAuqfy2UzfahImjIGC7YwB0klN3Ki
	/PEskC7Mn8HPS0RNrkbk81xnrti3jy6YuJf6ziLzqHjfLpW/zsV6MLpNXlcIyf1D
	GAkGEe7crDOn3PQUkQjE4Wyelz9BhmaVhM5sSeuAUc4zX0ABjiwulpTw9+n8YYtH
	4adGxvyxBxy3zuvYnQ/vflgSzZdOFcI6T30mXEdg17T8Yb0CWedhlrDs1xAFvaOZ
	05rBEDPJbCkKig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7jdtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:51:51 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMolvD002297;
	Mon, 26 Jan 2026 22:51:50 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7jdtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:51:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3ymZwyQA1Er6esENUc+Yp7SwTgDi7gnnE/ojerY4uF8nZOBIAxHpVHUv1g/z+uhdE64hsWdUOXXd6s+Carn7gFLVWn5gElihdbzxdO8/F2nWF+ZZtxpsYhIOTaNWe2vAHuq/pL2FcxSFhzyA2l9CJrWCnbOhNh4xhzuYU8ocb8tBXDzbY04rQUFH6Ra5xJGc4JbHNea6kk5dQMK0mzj/09Hu/+bw85ABQRJbElhlUk1jSzLhVWnSCKLdFu8DlOPpYEJmJBsVWX7oS0mqTKBgFr2nSqV7MeGkH/Eu5irvnn/JKzrZegBElo+3Wn6cK/kpNhnpRubS5s5Yfqzx/4Z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Cj0BEaPgA6yzIb9y4ZWC5BYM2MeUrBJQxdZahbOMA=;
 b=DYCO8Vy7X7cHcyXD5Xv5gNVmkWrjqVyw1BJqdA0l81fRdB4e/qitoUd4g1/NeJEZYe3vQw/6kpzJWCjrfFKlsOYoqJKSmPqod+y7qJDir3eZaojGm8D3LTd392UT7XZQDa5u5V/43WjExFD7u3HZe/JK6qn+gYJvzSJvUj1KJap/7I12xLMisLAAtk21iF+IEuEowidvYEzNzJfzn2tTOcMfWshvxg4uPmiZbc1y0klInRfOVOxLuRl5iHSwlw41psPNL5YrE8rGzR0Ob2TVUBXEerg4GO0iHR7BeatFkdpL/CHB1RdoLzXhHnvyJAJ1VztvwvFZKQeox+nXuVfltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH3PPFF728655EB.namprd15.prod.outlook.com (2603:10b6:518:1::4d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:51:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:51:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>
CC: Milind Changire <mchangir@redhat.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 1/2] ceph: free page array when
 ceph_submit_write() fails
Thread-Index: AQHcjmtgHcJrPVSjBEOaVGvxnLXL1bVlD9yA
Date: Mon, 26 Jan 2026 22:51:51 +0000
Message-ID: <f351a9235ec9da785af840beb28db0513aa66ba6.camel@ibm.com>
References: <20260126022715.404984-1-CFSworks@gmail.com>
	 <20260126022715.404984-2-CFSworks@gmail.com>
In-Reply-To: <20260126022715.404984-2-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH3PPFF728655EB:EE_
x-ms-office365-filtering-correlation-id: 5b896f78-8899-4fb0-5f0d-08de5d2d7e91
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SXlmZDVtdnVSdEtxSFg3UFUwWmZWOHRPL3JsZ0xUclJLdDAvdzR4bXJhUi9M?=
 =?utf-8?B?V1gzejZyZWM4b1VTSnFMK2xwMVdqTGJ5MlhXZEZmb2gvd2Zjbjh2aE9SSWxm?=
 =?utf-8?B?NGdIRFBDRnF1ZFhXM3U2Uk5yQlFZUm51Qmx5cmdlUFF2MURVUk1PcThpT1Yx?=
 =?utf-8?B?a2Y3cGkxQWJNTlhlRHhFM3lSNlhPbzRRY0dxN0h3K3RwZURDZG05ejI4dnk0?=
 =?utf-8?B?OU9hcSt1NkR5VDB3LzJBWTRRUHMxU2h2dmo2Wnl5dUFqakxtN2YxeVRhamw0?=
 =?utf-8?B?R3ZFMWsrNkJoT3g3T3BWbEF1VUtBZXd1OE1PNE9ybFkzbEVtSkpjeGJOblp1?=
 =?utf-8?B?QmNQa0FhdURsZVZtOTM1QXBYamtqcmk2TkdhWGlwUW4wTnozTlRmS0h2dm1t?=
 =?utf-8?B?Smg5b3VvSjQvN0E3aS9tRUN5cUtSN2NmUTFyRUNTSVdxcnhRZWlaTlJ4UHU0?=
 =?utf-8?B?VUFQc1Y1K2dxZ2ozUm11aWI3eUU0Rng1MEVLUmt5eVdJbmpTb09mbGEyYzlr?=
 =?utf-8?B?Zjd4L3hjbmJQZEtyVDZuQVN4SGFaOHNWZTBhRFk0endCei9UTSsyMnhzQUdq?=
 =?utf-8?B?bmxRb25zUWhPZ2tYVnJXNXpvK3hiL3ZUeTg2TThoQnZSbkpGOGFXU2RkV3RF?=
 =?utf-8?B?c0NiWWRXUXMwSE5KdXNuRFh2UFRhbHlZaWxqUUJBYmx3ZWh4U0RGeWtkdEtW?=
 =?utf-8?B?L0tjZXNOeUw5ajJlRlBjNi90aUxULzdnM3VnMitSWjRzYWh2UnYvbysrblMw?=
 =?utf-8?B?b253VFloNUZkSEp1RWRKS0RMZ1FEeVY4ZWlySTBmRTNTdjlqOTJZOURBYzk3?=
 =?utf-8?B?V20zbmNDc0phKzVGOC9CWSs0cm5sUGlFRlk5VTR5TWpyNTFJSEtyeElIM1NF?=
 =?utf-8?B?YVBhajNBeEdRbDdRQSsvbTZJeU04dUV2MEdsdnEwWGdxKzErd2hvUWZCc20y?=
 =?utf-8?B?VSswUzVUdU1iZWFDR2l1OU5TaEpUWVMvKy9FZFZhZVFHU2NRWlZ4cDI1R2pO?=
 =?utf-8?B?azY4eGlIZ21PYlZEdUdtZHQ3UXY1MVZEWDRKWEhDSTF0U0RLM2F4bDloSGUw?=
 =?utf-8?B?QUdzekNDU29LMzIxRjZ5QXVrKzBjTmZyK2k5NWtxSkJ6ckdoM0RXZmpIUEh4?=
 =?utf-8?B?eldTODI1eTVtTXBPTm1adGkwU3c1UWdvSEpYZndoZGpXdjNzNjJaTXk4TlJ5?=
 =?utf-8?B?N2ptR1ZGcjlzK3dVVk5MaUJpVmpPY0RObkJJYUV4MGU3bDBxYnE5NXJsaGpY?=
 =?utf-8?B?Zk9PTWQ5SU1KanZrVVowNkpmYjNUeHJuRDl1cmxuNU5KRkZidUd5STgrcDY2?=
 =?utf-8?B?RUdOV1pVQU4vdmNGeWtORU5yRWVBd2xjWGVnUUFvTWxvcjZrTjdKeE0rTzNC?=
 =?utf-8?B?a0RheDVHaHJtRW1jNzEwOC9xRHMvam1adCtzS2Z4TGxoMjlUVGxrSEMyYzBy?=
 =?utf-8?B?Y0JrQlR2c0k5a1VZbXBYWkJEaFhnSmlwVXVVU0xjNXJQVXduY1hndnRtbmlE?=
 =?utf-8?B?MWdCY2pGK2s0eExjalYrMWQ3R0l3aXpKdVRYMVFpYkFDQWc2OGNVTzhzOVhS?=
 =?utf-8?B?WEVXdDJWU0RPWW41bWlMRUZMbVF1b1huVnpzRHkyU1NPdEZXQ3dpcUF4YlY3?=
 =?utf-8?B?eHF3QkIraERqZE1xeXlQeWtSRnJ6Qm1COFkrcTlrOTJmcENiMjJ5S1pGZGdr?=
 =?utf-8?B?WGtCTThBc0ZoU3hOZ0NJUEQ2STZmR0luWFFFL0ZOanlwRzlsNDcwYWJBQ1g3?=
 =?utf-8?B?YUpjeXdkakRSWWplMXl0T1NpanBvUDc4TUNCVUE0d1JjanNybk1GWVBDYWpi?=
 =?utf-8?B?Nk9lNFVCTldFZitIVmp4WU0rWnQrV1daakpUQndJRlNySjVNcUFMQkhsY1hy?=
 =?utf-8?B?SDhuWTV5NElpazBXZFZCYUpDeS96L3dLbVZjS3EwZzhtYzArMXhWN0k0RC9w?=
 =?utf-8?B?ZndhUmdWRzViVE5hSytaZW1qajlLOElPcjI4emJod05peVJyQ0prbCtraUd2?=
 =?utf-8?B?d2tyYy9laWs0UG0rMUJhZU82VjBRZFVJN3dkQm92dkJhSUlFRXpybnJSY0lE?=
 =?utf-8?B?Ujd1SFZRcGc5M0EvRExEY0hHa3cvdTAySW43MWd6WjljV0ZaWGJ0cGhqelpT?=
 =?utf-8?B?aXY0MFlUUVNtcWM0Um1EVDlHekFEbENjT3RsSzJyUkhmT1A5ei9WL3NXRWkz?=
 =?utf-8?Q?Jc8Ipw/HsgG47pqI5aJhv1k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjA4T29SQi9uVU54K0JiZTkwRHFlSWtEb3RRaVFhMktZZGU5SmhqSTN1Z05K?=
 =?utf-8?B?TXhlb24zdGZmUEU4SDY5Wks4TGxWT3BncWFOQWdvTUhFNjJZSm1ZZGFSNGQ1?=
 =?utf-8?B?NllXem02WEdUWERacERlQmJFbkZ2T1ZxYlBCTDd1ejU3MitFb2xVa1o5YlhK?=
 =?utf-8?B?ZjMyRU5OQkhmOE1ZS0N2ZFdxQlZTQ3ByUnEvWWRGMjhyaEJFdnhSUmgyYU54?=
 =?utf-8?B?QnNMWU04K2srd1JvcUMxOU5BZWV2emNUeDVFMnA2M1ZJUlNkYTJZdTlqa210?=
 =?utf-8?B?TkZiM213cHNUY3RhekZqMmxWQWE0VkNZNzkvWEo2cENYdlczWWtLc1hmUTR6?=
 =?utf-8?B?NlloR2VDMmEvSGtZb2ZNOWFpV1FjZllERWFkYktTTXFFYXBDTWJtcG90WW1r?=
 =?utf-8?B?WWJhamx4bTJzNFhxK1NVc0FoTmJHVmRwenRjTUEzdGtxQ2J1eW5GeHc1ajlk?=
 =?utf-8?B?aWp4TG5RK2pET2dRdVNaYmc2azV6YTJkYzY1V3ZGNE1DNjhrQXpOK0VXd2c4?=
 =?utf-8?B?bVVNRCt2SFpIZHRaR0R3YU1JbnlPL1lRZ3hFZDhIRFJNdDdRbnY2cjdQbDcx?=
 =?utf-8?B?MDRLRkU3WTlYcDkxaWpSTEFJbXJuRWFNYnFJVlNzeTNVOSsxeko5akZsNGxv?=
 =?utf-8?B?UmxVN0U4VEhaOUtFays0RmpuUFdUR29QK0d4NnZZQmROT003Tk04Q3h0aHBB?=
 =?utf-8?B?dGxPQnpSbzZYUVlueDNqK2VsSEFrU2dSWFRsK2lKWTd0T3ZLTHRuNk9NN28r?=
 =?utf-8?B?d1lNK3AveXU3SXhVODdqeCs4QlVXYzNhNDVPRTZ6c1FYVFoxWTlRUzVXaHVm?=
 =?utf-8?B?azBHNUlLZStWMHJjcXMwMDgvNDRjcVNHOUZ4UVBORXN3WU5CSG9jdjdXemFl?=
 =?utf-8?B?clZKc2czSHJMZ0V4VFdZejk4amlaWEF0cGlNV28yV1dNbFZUZUdxa092bFVZ?=
 =?utf-8?B?VGY0Z2ZnZTNDZHMxdnBKVHM5MWpPbHJ2QVNVYzUzbWYxSTU2d0srVUVURWJt?=
 =?utf-8?B?K1dlZThyOUl6d1Z0ZXBFWDFlTGlTcUprWkoyWE85ckQyWUFFdlpGdElqWUlH?=
 =?utf-8?B?eUFxL2RkMFU4cXRnRllmZHRTNXlDWkhoOFdTekFGeTlLc016VldwSzc0Wmc5?=
 =?utf-8?B?L2pKcmN2clVqWHRKL0ljWEMrQjI5ekRiRmY1M1Q4V1hDbkJIcWh4bmx3UEQ5?=
 =?utf-8?B?cWVUNktaOFVydlB4bXdCdkJvcncxSEdaU1R3YkFUZ2djem5CNjRDTlg5cDFD?=
 =?utf-8?B?OFArNHdsRmRtakpMVXh4UEZGbm1wNlRsZzBqVXcwazdVN3JGSnRobTJIVDBF?=
 =?utf-8?B?ZFJCUjFNcVRIaUYwd01NY1E5cnY5WEtGQ2hQSmM4Mmk3L3dHNlRaNkFGKzVH?=
 =?utf-8?B?NHBSY3hHVVlNdUU4bVdBR2lhM2pidWJyQXd5L2JEczZUcXFnUmgzM1JrMGl5?=
 =?utf-8?B?ZXp5bC9jY2Jmd2ZXdERFZTA5VkJsa3JlS3E2NStFK2dEWW8wQkxTWWw3SEYw?=
 =?utf-8?B?a3p3VzdFM1ZKN1ZYaVJCbEFtYTRjQ0wxb3RRTzlxeTVIZkhubVBHOUQ0UEVC?=
 =?utf-8?B?THFlZTlZUFhYK3dxUE9jVjIvMzdGS3haVG5MTVZKUFZOVGk2Y1VLcENRb1Uv?=
 =?utf-8?B?L2c1TnZSM2t3R1l3OW8ybjk1R29UdndiSk1keFkyc3p1am41T3F3T2M3Q0pz?=
 =?utf-8?B?M1gvL3VWdXJjRE1tak1pcFI3eUw4OHNJam1DZU85WXRkbzdSc3hBbDZ2aWRD?=
 =?utf-8?B?cXFWeDc1S2xpOEtVSFVpK2svazdKTVlKcjZQVS9yNTIwQ3dGb0F1ZTZFN3Q0?=
 =?utf-8?B?Nmh4Q0VBWVZUTjhMcXdtb3JibUNoQVBBSERWVDkxVXNoejJWMDkzay92dGlm?=
 =?utf-8?B?ZFE2ancvOWNxM2grUndWZFh1U0ZRRUM5aUhnZlBQMGFJSjBQNFdYSkd2SWxs?=
 =?utf-8?B?eU41M2lKLzNhVWkzajhwcHJpZUtLdEprV0J0eEpKalNobWVSZmI4YW0zVE5s?=
 =?utf-8?B?Zi9PY1k0cTBlZXVEeFNPZ1AwaUpabnlmSTQ4ZVFONm9kZGFWZmEzTFNhTUcr?=
 =?utf-8?B?aS8rUHRjaEdFZndzSFZyY2JCaCsxTHhCSERVT2hsa2FWN1lEZCtOL2NJc3VB?=
 =?utf-8?B?Tm40cnYwMW1sVWlXRGxwcm9uQTl5NWlYTUwyeFRJbWZHQ0hSMFE4a0tuaVNJ?=
 =?utf-8?B?UDF4b2pqT01zdnhMdVZmT05yRS95YWVNSzQ4OTQwR204T0t5LzBpV25wa2lv?=
 =?utf-8?B?NGRHeUE2dUVLdGhJZGJwdEcrUFVCZE5pN0c3VDdhb0Z0Ty9PN0Zlc2IvV0FY?=
 =?utf-8?B?VjZGbEExMWVVY25PSVJQMTVxUTdpUXhHRDYyL21yK3d0S2U4L2RPeHYrdzNo?=
 =?utf-8?Q?h+rnpCXuKaefZxLSdvPe8qbrCH4/AnPN13tBm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF44EE58AAE38C4C9BEB113319AC887F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b896f78-8899-4fb0-5f0d-08de5d2d7e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 22:51:51.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz6S4kRKGmW4du/oPoyjzOFzI2Hyc5rDGSVHQF97q1R3c7lvtnyzcNdtpV2xE5TavuR2mAEFtW1aT4PAIaLxsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFF728655EB
X-Proofpoint-GUID: Q1-adL43Bu0UZx7Xv57gMcnvkkrz8exo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5NSBTYWx0ZWRfX9qxsdNdTwTkS
 5O+rHcmWZBIWb3+XKgluqFjc8Njq4t5CiXTfAGXLEBPnvPfSmsl3ZEz5MfiGr+uHmWvV5pexFFX
 r9gGapjcLWUsoC5xO6QOHfme4mOBPRATWHE5fVNlvBf5L/6Bnk31+1lcR+Y3/iFVxg5vwoCDS5g
 mcJNAxzChvywSLGnD7IMQ5v6WPJ1+2aEipbhAsnPWoA4GwAwEY2/DJRqF9LobIurHiDY2zXd7ZI
 w1bB4xm6QX8rzzvi34nCKJVM7227reGZ1vnnfwlEt96zDH+TSVay1wm1T6nQa3YHbT5Mi29FcAr
 xwKy4+aGfdjsmFWkjid/FliVy+NL1BwrWbrat7QJ6E30GdFY287qab9nu3oAB6emrnCXyNT54UY
 hpllRBES3ZVAhIcHX+6/FG9397bYPf+9i9wp/sV2gbfDCwG0phvPeTv0eH3U2k0g+IvIM60VaBq
 +11PrI3C5EvDnCPoRvQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6977f007 cx=c_pps
 a=9jlK8eo7xmF8zH0m+f/LEA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=YmilIr7NCERtBiXX2FAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JOU2ioMWOmZa1qPNCFm_mXGet3YFxYBc
Subject: Re:  [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260195
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211694-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 13CC18E0D5
X-Rspamd-Action: no action

T24gU3VuLCAyMDI2LTAxLTI1IGF0IDE4OjI3IC0wODAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
SWYgYGxvY2tlZF9wYWdlc2AgaXMgemVybywgdGhlIHBhZ2UgYXJyYXkgbXVzdCBub3QgYmUgYWxs
b2NhdGVkOg0KPiBjZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goKSB1c2VzIGBsb2NrZWRfcGFnZXNg
IHRvIGRlY2lkZSB3aGVuIHRvDQo+IGFsbG9jYXRlIGBwYWdlc2AsIGFuZCByZWR1bmRhbnQgYWxs
b2NhdGlvbnMgdHJpZ2dlcg0KPiBjZXBoX2FsbG9jYXRlX3BhZ2VfYXJyYXkoKSdzIEJVR19PTigp
LCByZXN1bHRpbmcgaW4gYSB3b3JrZXIgb29wcyAoYW5kDQo+IHdyaXRlYmFjayBzdGFsbCkgb3Ig
ZXZlbiBhIGtlcm5lbCBwYW5pYy4gQ29uc2VxdWVudGx5LCB0aGUgbWFpbiBsb29wIGluDQo+IGNl
cGhfd3JpdGVwYWdlc19zdGFydCgpIGFzc3VtZXMgdGhhdCB0aGUgbGlmZXRpbWUgb2YgYHBhZ2Vz
YCBpcyBjb25maW5lZA0KPiB0byBhIHNpbmdsZSBpdGVyYXRpb24uDQo+IA0KPiBUaGUgY2VwaF9z
dWJtaXRfd3JpdGUoKSBmdW5jdGlvbiBjbGFpbXMgb3duZXJzaGlwIG9mIHRoZSBwYWdlIGFycmF5
IG9uDQo+IHN1Y2Nlc3MgKGl0IGlzIGxhdGVyIGZyZWVkIHdoZW4gdGhlIHdyaXRlIGNvbmNsdWRl
cykuIEJ1dCBmYWlsdXJlcyBvbmx5DQo+IHJlZGlydHkvdW5sb2NrIHRoZSBwYWdlcyBhbmQgZmFp
bCB0byBmcmVlIHRoZSBhcnJheSwgbWFraW5nIHRoZSBmYWlsdXJlDQo+IGNhc2UgaW4gY2VwaF9z
dWJtaXRfd3JpdGUoKSBmYXRhbC4NCj4gDQo+IEZyZWUgdGhlIHBhZ2UgYXJyYXkgKGFuZCByZXNl
dCBsb2NrZWRfcGFnZXMpIGluIGNlcGhfc3VibWl0X3dyaXRlKCkncw0KPiBlcnJvci1oYW5kbGlu
ZyAnaWYnIGJsb2NrIHNvIHRoYXQgdGhlIGNhbGxlcidzIGludmFyaWFudCAodGhhdCB0aGUgYXJy
YXkNCj4gZG9lcyBub3QgcmVtYWluIGluIGNlcGhfd2JjKSBpcyBtYWludGFpbmVkIHVuY29uZGl0
aW9uYWxseSwgbWFraW5nDQo+IGZhaWx1cmVzIGluIGNlcGhfc3VibWl0X3dyaXRlKCkgcmVjb3Zl
cmFibGUgYXMgb3JpZ2luYWxseSBpbnRlbmRlZC4NCj4gDQo+IEZpeGVzOiAxNTUxZWM2MWRjNTUg
KCJjZXBoOiBpbnRyb2R1Y2UgY2VwaF9zdWJtaXRfd3JpdGUoKSBtZXRob2QiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBTYW0gRWR3YXJkcyA8Q0ZTd29y
a3NAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvYWRkci5jIHwgOCArKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2Nl
cGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMNCj4gaW5kZXggNjNiNzVkMjE0MjEwLi5jM2UwYjVi
NDI5ZWEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvYWRkci5jDQo+ICsrKyBiL2ZzL2NlcGgvYWRk
ci5jDQo+IEBAIC0xNDcwLDYgKzE0NzAsMTQgQEAgaW50IGNlcGhfc3VibWl0X3dyaXRlKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPiAgCQkJdW5sb2NrX3BhZ2UocGFnZSk7DQo+ICAJ
CX0NCj4gIA0KPiArCQlpZiAoY2VwaF93YmMtPmZyb21fcG9vbCkgew0KPiArCQkJbWVtcG9vbF9m
cmVlKGNlcGhfd2JjLT5wYWdlcywgY2VwaF93Yl9wYWdldmVjX3Bvb2wpOw0KPiArCQkJY2VwaF93
YmMtPmZyb21fcG9vbCA9IGZhbHNlOw0KPiArCQl9IGVsc2UNCj4gKwkJCWtmcmVlKGNlcGhfd2Jj
LT5wYWdlcyk7DQo+ICsJCWNlcGhfd2JjLT5wYWdlcyA9IE5VTEw7DQo+ICsJCWNlcGhfd2JjLT5s
b2NrZWRfcGFnZXMgPSAwOw0KPiArDQoNCg0KSSBzZWUgdGhlIGNvbXBsZXRlbHkgaWRlbnRpY2Fs
IGNvZGUgcGF0dGVybiBpbiB0d28gcGF0Y2hlczoNCg0KKwlpZiAoY2VwaF93YmMtPmZyb21fcG9v
bCkgew0KKwkJbWVtcG9vbF9mcmVlKGNlcGhfd2JjLT5wYWdlcywgY2VwaF93Yl9wYWdldmVjX3Bv
b2wpOw0KKwkJY2VwaF93YmMtPmZyb21fcG9vbCA9IGZhbHNlOw0KKwl9IGVsc2UNCisJCWtmcmVl
KGNlcGhfd2JjLT5wYWdlcyk7DQorCWNlcGhfd2JjLT5wYWdlcyA9IE5VTEw7DQorCWNlcGhfd2Jj
LT5sb2NrZWRfcGFnZXMgPSAwOw0KDQpJIGJlbGlldmUgd2UgbmVlZCB0byBpbnRyb2R1Y2UgdGhl
IGlubGluZSBmdW5jdGlvbiB0aGF0IGNhbiBiZSByZXVzZWQgaW4gdHdvDQpwbGFjZXMuDQoNClRo
YW5rcywNClNsYXZhLg0KDQo+ICAJCWNlcGhfb3NkY19wdXRfcmVxdWVzdChyZXEpOw0KPiAgCQly
ZXR1cm4gLUVJTzsNCj4gIAl9DQo=


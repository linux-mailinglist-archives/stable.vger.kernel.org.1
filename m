Return-Path: <stable+bounces-196966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96FC8857C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 08:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BC53B3487
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38D1DF26B;
	Wed, 26 Nov 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZoXVBMp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HaKYaSe4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010E36D4FF;
	Wed, 26 Nov 2025 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140478; cv=fail; b=oHnEOb3tozUXBwEuS0VFCjvGo5pjM4MOCmmTZROYtE+S2ojVNLOfG/FYlio4NRntn3GFwYuK0H7noQkG1CO4WiALMlCg4d7uqhOOrTwem5qVf3dhriy8FR28LLjjtLfOQ6E1mSu4tSl2HAiQd1CcoAlNYe8bcVRKESjKrSiKOzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140478; c=relaxed/simple;
	bh=s5DC8N6gEn7ri+9c7Zmtw5kCXD/kBxoC7ClWlsCzVqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EqCAyzjqhPdwPXMwW4Fr1jyWbrDi30pyOwmTLMnVMr+UZJxwXBmHhYhufu0ALJBoZ2uhwJYniTJ4mzfuYzZUHeAiVEcu50ZRMHAhTiboPpYCmM9KD+Jze6Nu1d89SrfsOSV5AlSW2gkDMEEInmi4w+N79qsalELgxhEyP8IXvGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZoXVBMp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HaKYaSe4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ5uAll1478299;
	Wed, 26 Nov 2025 07:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TzLJe664qgCWukdP73ChClD19781KDKtyJdJdbbEmac=; b=
	FZoXVBMpSzcOTfxp5oGR2krVfLFSjamQuqp34WOYr+31wgWSJpiSS63CxuMMHP68
	WgopjWNO1P06krxlgdmci8pVG7boAnx7NgOCERxlgt17vVe56ezYXMY1kSqYSvWO
	hQoOHEceqtZH+VD+xrvsx2W3gI8DCbLnbk6AjlalW1lGn5U1MvIJKa4lasRdmAc2
	L9JHtjGT2ocoPtU1Gtt4R3smfDy18kFc/Qj5kYLisCcGKFXkvQiPXfCFNjc6t//K
	miVqKGg9SH7VgxXR0N9aTkKStxi5TE0/zIoAjoPyJspW5tER0rW1+VDtcGmOCqsU
	SZWQBNTGvWT9ZmRY3/Us4g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkjqfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:01:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQ4iSqH018823;
	Wed, 26 Nov 2025 07:01:10 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3makhua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 07:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQJ38ahkyWWzqgm5ZKPRUsChSZsxMWQShM7HFK0HXK1ES8YyxiWg1IGuiGpm+9iSJsxvvMeAO5+b0Dxv6CHtXf3AkAPhNLlx+pQi3hnL9y6UUsniWgpBPCTfzLXDs64wD+mso1VusibqWCbt63FYvLFOu6Eg4yhXJH3EVpCWnB08fVk5y2nPknPZFx3poylwKdUBiUVp+T4cicJdVB3qmr/K2rxwoxyftI+YvCCM7qyHBnyjOPkNKwpDbLsY1vqckK/O44uEq/OQU1Tp5HqaOOyYUVxGEtK+jD9/bRw15tbnSjr3OJ2/jtnNSGppBDDcZ26N+MZuTQtvEcSiAo8eQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzLJe664qgCWukdP73ChClD19781KDKtyJdJdbbEmac=;
 b=XWCGLEtffeCv262BD+79NBuioPGmU0clFbIzE/2q+YccElV0jOuFdFfMH8C6hzdJF5BF7CJV38s9zjeMUZ++OCK4zzXxpAuZu9vfwtMD93MjP/3Li+sg+Jvd25x+OMtg7MClWWLGSkOQGuB7q6wVkyYRXicuKZPT+sNocA8caZ/8piRVzXso0SHOQlu0hch3Epyn2gIVZ1uLVp+QxA3DynHarLj3xfz5Amj3bqwlJDHHejBHAgU5UQh8q0VlyEKPRw3xxx1o1H9+2/8KK0P63NqBMCqCJ3ozlYyCHr7tLLfJNW8NEkvXvLq3HR5a2o5ypbb+II4t7hA92/CeX/7t1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzLJe664qgCWukdP73ChClD19781KDKtyJdJdbbEmac=;
 b=HaKYaSe4LRq9eqSdg/oVYUnpLum80eqMA6ygWDtgX5gxzxSNUT9awyY694DnLQ0ZImYEe45tgO+o+uADLqUb+aXpDUYKOPNJHVEFYRx1vhslBdBTeXVEzl7zWXsG5C5Q7l3S7jSy3MqOmGHuXB5gSq6r4ePKnKr41tP68p+bxZg=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by LV3PR10MB8178.namprd10.prod.outlook.com (2603:10b6:408:28c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 07:01:07 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364%3]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 07:01:06 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Topic: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Index: AQHcWC0EXEJKAooKnkemT7DWcQ8CSrT33tiggABD9ACAAACAAIAMcN1A
Date: Wed, 26 Nov 2025 07:01:06 +0000
Message-ID:
 <IA1PR10MB72402686A48E3FBC159EE5D698DEA@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
 <20251117174315.367072-2-gulam.mohamed@oracle.com>
 <2025111708-deplored-mousy-1b27@gregkh>
 <IA1PR10MB724026C01ABF778B9E9EA10698D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
 <2025111848-gusty-unclothed-9cc5@gregkh>
 <IA1PR10MB72403125E25B4981BB77851498D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To:
 <IA1PR10MB72403125E25B4981BB77851498D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Enabled=True;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SetDate=2025-11-18T09:00:44.0000000Z;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Name=ORCL-Internal;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_ContentBits=3;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|LV3PR10MB8178:EE_
x-ms-office365-filtering-correlation-id: 356c8174-0df5-40ec-acab-08de2cb99239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?Si9Fci9zVkZNNGV1RzQ4ZEY5SlduWm1KdjlVZGh3UkIxRk42OXZxM2kvcGly?=
 =?utf-7?B?QUVzUDNHSWlJaVRKcTRUR3dQUzF6VGJyZkhFVXJFWHUzalJrbWYxdERCY3ll?=
 =?utf-7?B?dVgyd21xSnlOMHI4ZEl3YWhocWtoMDF2UzBZNDZqeWUrLXY5OHdTanFnWWZ3?=
 =?utf-7?B?Z2p6YlRaN1UxVkJCVVJiOTlLYVpnVFhicC9QaUloTE9ybXk3L0U3M3B3VmtQ?=
 =?utf-7?B?RFd6ZExFTk5WalF3SlNxdDBEMkJzTHJpZ2E3QUxWUjRiR256dDl6MGVxYkFV?=
 =?utf-7?B?alJWNDZUZ3kxQ0JKVzBLSjdtS21haEhWWFBXTm1rY0lvRWxOT2FiSEo0dW5Q?=
 =?utf-7?B?NzdjTFMyWmJrMVFRS3lMcHkxcmJpR2FONUlabG5YVi9na2UrLW1vUlVPQSst?=
 =?utf-7?B?aVFwRTY2UjZKOFZzQW1pa1hrTkc0enNONm9Bd3RTbUhLaHprL2YrLWhnTDV2?=
 =?utf-7?B?aXQ2TnNpUlhZUi8wcjBYdmdYckp6dDRKN1lmOVh5ZXV0ejVUcFdJamN5M2p5?=
 =?utf-7?B?MExuVTI5bXdtTEFCOVNZS0tqZUk2aEV1T2w4aDN1ME1lODc4RWpxRXg0anA5?=
 =?utf-7?B?cFRQcXNWVHdyRDA1enFIZ3pnbmFuSnZSa1ZpanhEaDlpa3R2RDdiWnhJd2l0?=
 =?utf-7?B?dDFldmVKbE9pTEVLODFkbnc5Qzd6TTZrbFN6Ky1HYS94OTVJUG54TDZ5Ri9R?=
 =?utf-7?B?ZzlPSUVGZmMvbkZaQzZNQkNFbUNibkcvQ2VPaystMi9jYURkTHc0RVoyN1d5?=
 =?utf-7?B?R3BKNkx5MlVhUjQ3WnkvZystYTBWbXdwMDBIY29XS2ZPdjM1eDBDSkVxUVUv?=
 =?utf-7?B?VUloQ2pGd2lUNlhzNDVEWEtveWJWRXVZL21ydVNhc0tZNlBmbDcxbGRITXln?=
 =?utf-7?B?MDc0RTc1ZDc2RVJrTXNyalZUN2huU3RvYVhTakdMM01tS24rLWpqMjVmQWFT?=
 =?utf-7?B?VWRpaG1IWHBZSHh1clYvMU0rLXk4MUVqOEsybzNLa3grLWxlV3BFTUhHRmFM?=
 =?utf-7?B?VGlKYy8xQmFtMEVBTkg2cTFPREVwME5vNmZ2bHdWRDYxblpTcnFFVTczcHI2?=
 =?utf-7?B?eXBsWnViMDV4bWVWSUpvcDhWQzlndFdYbHl1TlI1clkyck43N2ZYT0NTc1hv?=
 =?utf-7?B?bERXMmtYaUFOQ3ZGWXliZTVuU1JVVkprazBqSmJ5TXA3ZUVOaktmcXF3VHZs?=
 =?utf-7?B?ZEp6RDZ4cXR0bHc1eEZqVjF5WXkwTistRFptNE4yZnBLZktaSXVxa0gwTjk1?=
 =?utf-7?B?UXVyQ093dzVna1d3UlFtalBGKy1EWS9qc1pFY2JWajREMHBySDhlSTFKNU9r?=
 =?utf-7?B?N0ZwL0VkNExCUEVZelB4d0J3cWo2TG52OS8vSWlFdGhLM1JzY2FyMU1OazBn?=
 =?utf-7?B?Ky0rLWNBRWMyWnBRcEgxcjNzSjVsSzAvNzEwNzBIZjVNazRzaVprWVB4QVVX?=
 =?utf-7?B?RDFSWlV3ZmwwUEVFWlJscWZXUGszNzF4YlhwbG5RNlNsV1hUNm1zN3FEZ3hW?=
 =?utf-7?B?dmpCc1UzaHFDVWJ1V0R4RmFxWnlHN25OOCstUkNGYmFQWXhvcGlsVTlLR1Bj?=
 =?utf-7?B?RnhaUXVkTXpOOVFZSmlWUUxTNmx4UlFlMmptdW1SODhhbGRKWk9yelFBKy1V?=
 =?utf-7?B?dnRFakoxNi9MZW11VE84MVdkLzR2MWJPSGJkbFEyUnVkRFRzcDJkQVltUUVX?=
 =?utf-7?B?RWNZbXFIM21uNEFrWkxPanYzRDJacU5xV3A1ZVc4N2Q2MTRmdkhVRm9yOFpP?=
 =?utf-7?B?VTdDdmxSNVZZZlh2Zm5qeWlSWnpuWmlML08xOWg0UGVZRVovbHlBeHBkTEc=?=
 =?utf-7?B?Ky1nbjFrRUFHUHo2VVVWa2F6ck1LLzlBT2dBVistbDF6SmFtRGNoaWxIdVBM?=
 =?utf-7?B?SzBhcGlocWN3YVlKWHZaQS9CWDVQRzZNdlN2bSsteFR1RERoNmE3b2RQanFU?=
 =?utf-7?B?ZU1ESkM3R2dqajRtTzY1L3RiRjVpQkY1dENGTUVHUnhjTTNXTVo2UlZoV2U4?=
 =?utf-7?B?THo5WUJYcktKZkFKSkhYMWRGMENmQVhJQTdTUHk5T3hldmJBbDVGNGhqTist?=
 =?utf-7?B?RW5JazI2TE1ELzVWMHVFSGZsRWdJMXN2eXpE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?NDdsVTV2T3NsT1Nud3B5SmtaUEVmUCstRTVQWDlVYjNzWUpjUjN4ZloyKy0=?=
 =?utf-7?B?Ky1QQVROVjVORHkzQzBEWnJFeUVOMmpLZ3gxcEpETXJPSjFUSzFFQ21KTHdN?=
 =?utf-7?B?d0VGd01mcistZDNST1JLejFSczNxU0lscXI1ZXE5TDFjeDdvMW9ZWUJFRm4z?=
 =?utf-7?B?cTV6UnJJeVJDL3pFeWRoTDNxbU9zTm9SVUhiTFMyWGxyNFh5a2NIdE9DYnQw?=
 =?utf-7?B?bHpndTA4RGpXU1lvR2hXTmUvWEJhTTBrMmdDU21ESm41eVhBTWVZUUNJdktt?=
 =?utf-7?B?MjdCdDFmTXArLTNrbE04bHU4UUxROG9ma0RWZGxvMHJraFkwKy1XaistVzFD?=
 =?utf-7?B?ejZ3MjRKRnBvRXlVZ2IzRSstUnhYWkpVeHM5elJ6bmN4c01DKy1OdzBFUFlv?=
 =?utf-7?B?cFAwdmFPUUdhSVg4TFArLW5iVTBQU2RRRlpYL2JEOFkwOXVuRTlLajRTbDZR?=
 =?utf-7?B?TFpsT3ljWUhmNEtGbFo0ZUVqRFVPUkRJWDNjUjcvQ2NQUnQwNEZpNmtWbWFG?=
 =?utf-7?B?Y1RXakdHVDk4ZXZTeE9mYXVPMXNHWVJBbnBjakpzZlZFQ2FnNmNGZFVMajR5?=
 =?utf-7?B?bnRUZmQvcjVSUTRXV1U3bnVzempVdWM5cndOS3ZoTWg5QmFGVmo1bC9VKy1X?=
 =?utf-7?B?aktPU3R2MENCejEwVUVjMnFVNm5wa3VOQmpXTWpwZzEvM0hoTFFvT2x2bjFv?=
 =?utf-7?B?NWNVU29Db0lOeXhFU0g4MUF3LystL2x1Nmk1eEd6SWFpS1ZHRCstMWd6SWQw?=
 =?utf-7?B?TXJRZ09Kc1hYcjdqcG9ieDNMRnluMEl6Ky1DVkJuY05SMEdiREtrTSstMnBK?=
 =?utf-7?B?M0ZxRVkzL1grLWlyOG81djVaWDN2R2pNRGd4eDY0M3BiWGllWC9YSmdMRFRl?=
 =?utf-7?B?enpvRm9hSUJJZ1FoemY3UngwVjlhVTM3ejFFWmduZldmWm85REFoeC9od3Fu?=
 =?utf-7?B?UFRqbjRtanQvdkFqMFNMdTkvelFodFAxYzUyKy1GRDNiMG5PaWx1OTg3ZEY3?=
 =?utf-7?B?ZCstKy1EY2RCbE16TnFOKy1yc0t6QmxvVlVxbDRiclFhNlA2YnZUbElkYURR?=
 =?utf-7?B?TE1hclM2S0I3R3V2SHV0R2FrWFdDdXdvVDc1M0JGOXMyeDI5a0NqdmJGWUhu?=
 =?utf-7?B?ZEREb3o1bistNFVzeHRUaGc5b2xWMHk0YkhDS1l4TEdmcHc2ajBmSDZLQjh1?=
 =?utf-7?B?eTFIcWxoTFBIbDdJOEo0UXQxVFVNV1hmV3crLUFmNXBrQm9acXdhVk1ENnBy?=
 =?utf-7?B?OWZQbktHTVRIM1RlbjRWcFFjODIwcmljNDA2aUtDNWtPVysteDZCQlpGN25Y?=
 =?utf-7?B?UEFob3REdjQzb3JZdHd4em1rVGNpMWY1QXV1R0c5NEZST05hQlQ2bUorLUhh?=
 =?utf-7?B?VElwajR3SFBvdHJ1UUxHT1VYWi95clVnZjd1SnlQcldOYXFnZC93U0lOcW5W?=
 =?utf-7?B?Q2tnU0Q3bXRhUmJoZFBUcFBtZVNxR2hvMistMFMxRWk5MEJmTkpFUTB1NVM1?=
 =?utf-7?B?VTVWdVFucWlZL3hwb2cvQWxTRVFSTzVGUWNUQkQyMktRbm5qbWRxM2ljdEtk?=
 =?utf-7?B?cystYkdJdkJEUm1OZWNlRnk5SmsvR21RR3ptdS9vaFNzTUk5aXJPM3hIdERO?=
 =?utf-7?B?ajZIaVdZYS8weUtSeTVUOXMzZDV2anZmTWRtTFAwVkpwRFBFUmljM2ZpWnVJ?=
 =?utf-7?B?SWpIbTJkdWtBT3luTW53YWZNTFIxZVZHaDVUUTRHT0JYYjdTN2xRS3ZGcVpV?=
 =?utf-7?B?TWM0dkYrLWV0MkV6c1hZbUZGQWZiY1I5N1NtQk1CcCstWWFsRUR3Nkp3Q1Fm?=
 =?utf-7?B?LzQwMkxsZ2IrLWhENystbHJ2ZW51V3JSdW8zUEFFM2hWNXMrLS9IWGZUaDVi?=
 =?utf-7?B?M2FBS3NWUG1zc1owL0ZjMERYV2VpTUdSNUg5VVN5Tzg2M2M5ZXdtaC9mYThC?=
 =?utf-7?B?MUViKy1BVWI2V2krLVo5VmxYM0F3NTVvNUZxbk5aL2RrT2MzbVdVbHVDdVVS?=
 =?utf-7?B?UHpVSWxRMEVyQ2pFcystNWZzKy0xM1hMYVowWDhibGY2NGpEOE82dkl4ZFU2?=
 =?utf-7?B?MmJ4dWdrYzNPNEd6NEFHWGoxNENGWk53VTZzV2xuNTlHL1NyWFJTZEI3SHZw?=
 =?utf-7?B?Ky1FdVEzU2ROWGtQZHFnSnRaRktvRHpObE01NWRaN1BBQ2pjMUZjbC9hWXhN?=
 =?utf-7?B?eG9oNCstKy0vV3phckF6NWZySg==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gDjmE7ZhKts5ok/68VX9Wk0zHyuiDx5WjCx/vlFgWVhVLzLDSkhRzkkJ1Yq1LxMnbhokJ0XMTkwpb1+L3JOwd8YMHJW8/0EAOaIDNukr5qC1icRFO6ve5i3z1E+ELKQc1FBKrfcFtK+/0K1H3KQLjTCWdsg1Hs1vdRW8AmK6JiByHjiBxyZBWh7rbB/79+DdTo6Lz4RDfo13XIBG18kDvezxpgRaKQH9ny1GWcNdQH/W19nLyIcKfzyrQWjQnGUvz+Z7Hf56EAnlLaGNM6JcdJhl8J12z45obDYNGCGR8KaYcL9x7TKUw9U8ustzEDQA/jVxGxGsvxpcjorMPknotxYgqq5vKA9OJvsyR7otOWZ8VvYnaBrUPKaTWqxiPw4ZvfXJl752G9Y65n6XZ/83qfW/wm6wNKMXBQX8aFL2Qc+gRtZYcNYON5wcd9jf16QerOIWWZ8/1sqjSumtSCChdv1niIWhspC1tslXqLHp+f5XXj87L5Gx/oQqaTvfk1F2rhpmE2I/OUXtj242uv7Lu9DiveNKDTQHU8dQGRvKj0ZHinlPH24fEmYJh6l8xsvKFiakAvZVoX0+7B6Af2JEVZUEJjuFQN1E1FTNs+pFYms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c8174-0df5-40ec-acab-08de2cb99239
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 07:01:06.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ9+3TIB8ckisLLaWrz2/8POpA5u5w8tGpophRjCD8LB3oJrPJVUhJthz5A895kPal/ekZ5a2UgBrQmFBSoE8exgk7dXto9RZiJAU7lwNN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260055
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=6926a5b7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=WJJPNcJBAAAA:8 a=mQvHCebiAAAA:8 a=bB85FWjIRDQpNnePsAsA:9
 a=avxi3fN6y70A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Orvq6HXzVWGNNdQUjdZg:22
 a=wsrb8zZI_WQ3QAEBCXTy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA1NiBTYWx0ZWRfXxj2Bsb4nepB8
 +WHGUV6tD0fXfBwatpx3mSWziLPOpwPcHjqKed4K3sQtAzcoTQcd2BeVCmywrpn1dEjv3RRHdRO
 n/d90CEut1GIvje26E1zRMrTvJCUNjPTBs1Kbf2Zjd62jQy88huQaYaZSSprNSpqGyRjY3PEt6A
 oO79SUHGPrINYPmlyb1fl2dM1N42ABD1/QbihxS2+ULS+qRky5X8xlKjtJuPB8TCgrBu+QEPeJp
 6CQox6z3kOCXMf9gYNC/k+XQmBSljnObDkiJIdfirN/lA9cmiA7mTtolVO59h0hvKh24zW+5Qi9
 25HsK83zHm4aZJDNOFhJD3KeGF+Qx4ymtpjLvL/Z1pfY5TBXY6wwh4Drtx5/bOVwNM3NJvNnor5
 bv5Meij9sdVdg/3i8rIIXTncu8N21g==
X-Proofpoint-ORIG-GUID: q-NX7iXHrk2YWr9KC4lALN2O1V5D9oZ_
X-Proofpoint-GUID: q-NX7iXHrk2YWr9KC4lALN2O1V5D9oZ_




Confidential- Oracle Internal
+AD4- -----Original Message-----
+AD4- From: Gulam Mohamed
+AD4- Sent: Tuesday, November 18, 2025 2:32 PM
+AD4- To: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- stable+=
AEA-vger.kernel.org
+AD4- Subject: RE: +AFs-PATCH 2/2+AF0- Revert +ACI-block: don't add or resi=
ze partition on the
+AD4- disk with GENHD+AF8-FL+AF8-NO+AF8-PART+ACI-
+AD4-
+AD4-
+AD4-
+AD4- +AD4- -----Original Message-----
+AD4- +AD4- From: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- +AD4- Sent: Tuesday, November 18, 2025 2:29 PM
+AD4- +AD4- To: Gulam Mohamed +ADw-gulam.mohamed+AEA-oracle.com+AD4-
+AD4- +AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- s=
table+AEA-vger.kernel.org
+AD4- +AD4- Subject: Re: +AFs-PATCH 2/2+AF0- Revert +ACI-block: don't add o=
r resize partition
+AD4- +AD4- on the disk with GENHD+AF8-FL+AF8-NO+AF8-PART+ACI-
+AD4- +AD4-
+AD4- +AD4- On Tue, Nov 18, 2025 at 04:58:24AM +-0000, Gulam Mohamed wrote:
+AD4- +AD4- +AD4- Hi Greg,
+AD4- +AD4-
+AD4- +AD4- Please do not top-post.
+AD4-
+AD4- Sorry. I will take care from next time.
+AD4- +AD4-
+AD4- +AD4- +AD4- Thanks for looking into this. This is the 2nd of the two =
patches I have sent.
+AD4- +AD4- The first one is +ACIAWw-PATCH 1/2+AF0- Revert +ACI-block: Move=
 checking
+AD4- +AD4- GENHD+AF8-FL+AF8-NO+AF8-PART to bdev+AF8-add+AF8-partition()+AC=
IAIg-. I have mentioned the
+AD4- +AD4- reason for reverting both these patches in the first patch.
+AD4- +AD4-
+AD4- +AD4- That does not mean anything for this patch, you can not have no
+AD4- +AD4- changelog text for it.
+AD4- I will add to this patch also.
+AD4- +AD4-
+AD4- +AD4- +AD4- Also, this is for +ACI-5.15.y+ACI- kernel.
+AD4- +AD4-
+AD4- +AD4- Really?  Why?  Where did it say that?  Please be explicit and s=
ay that
+AD4- +AD4- somewhere obvious so that we know this.
+AD4- Sorry, I forgot to include this +ACI-5.15.y+ACI- in the subject. I wi=
ll include this and re-
+AD4- send.

Greg,
I have resent the patches by including the kernel version +ACI-5.15.y+ACI- =
in the subject line.
Can you please review the patches and let us know your comments?

Regards,
Gulam Mohamed.
+AD4-
+AD4- Thanks +ACY- Regards,
+AD4- Gulam Mohamed.
+AD4- +AD4-
+AD4- +AD4- confused,
+AD4- +AD4-
+AD4- +AD4- greg k-h


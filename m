Return-Path: <stable+bounces-83483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDB99A939
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC74A1F225DD
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CB19FA9D;
	Fri, 11 Oct 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgZ8HHpW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B6nKrGJb"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88719E994;
	Fri, 11 Oct 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665733; cv=fail; b=mxwiROo8I8lCZXNRCp3Xmj0pQqGDhxzWdQVMkZNve/UW8Foy2X78GShXXfc8ZvGDsuejKJJ7Hdjrj9GFHwpHyTAg1XVoDG7dFdOFfhVsi1p8hkVMK9Q/MmTzwjN7FFg8Pen7u1UDLg+8UrBAryksBvriOGiK3J4YKrnDhR8QNSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665733; c=relaxed/simple;
	bh=zOhehSp5WlwN3wbSv7Vz0B917R6o4M+RUfkkbEZgZVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kX7Z8cxOx4j7afVDlBIPyWdCPBQxTsDorJLDcTSnERo0SLtc/M9AG1l6Q3DoOvN/fu/m1ilqEX1CIjeQyWi+3RMBlh0eueCg2JDngDv5B91QTZXLrdr3AA0/gY/f4WUn1OVf+emOt3cWPHrv3lbH1B32wG9Y7dZxHy/AYO1UXrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgZ8HHpW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B6nKrGJb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpY2T025422;
	Fri, 11 Oct 2024 16:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zOhehSp5WlwN3wbSv7Vz0B917R6o4M+RUfkkbEZgZVc=; b=
	GgZ8HHpWWvg1A6KDKGzABRubJq89Don7fCOKw8jOfd6W4O1wYj5zJcFMa59QMeqA
	2qmzpX2eD09q/Yq0qnJvA2NswrnxVV0FtJYt+/uiG7+sQ9z4ZY+uyUUxYRfidlVD
	VF7SJgjpC5O6/umuR5adEfmsD7W0MHofo8NySJa0zU9gIyWmYRDgnTVDC8fpsoXC
	2T71czHyQHV+z6ZpM4p+VGjjz2Ya7/rra0SmIDx5QlPOyTPYvhd2mmvonx2QgE4A
	7ueRiu33CT80XlBJAlpSkBYUn8UcvnziN1ZFDQSUBMfkYYKbrYzPUkz2x6tDapqg
	hpOiRpJE0PmSUZPmtedSag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pn713-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 16:55:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BG9oJF027926;
	Fri, 11 Oct 2024 16:55:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwhu6e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 16:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt1fqjgYQrjRCW//+1omqfqzgkXmDL+OcCvgTgMnOrGNgMdxtgP09joGir27IxP2ukKm3Sqo4Eryv7w8avEsT0UAJHxk6Tv1BSrpCCpvA0I2+ft8d/U+fhZVibwf9blVvrTvGkz3fhHnL9d6xzguXXywfaIpN8UfbRHU0R9YvwZd0CkC5UgatztqGjo9MN/V1/nVYlhXXNwkz/XGod+UWJdIsNFbETnlLsc5qa6ybn4XFuG1YuLAE9XSq6bAVdLu126JX/ZOypH2Dr00ZP6koTzChm85N0CZi5179f7REegXB99YTGAKSESXTPeZqDbxGuyyauqWRergZvmQF1jNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOhehSp5WlwN3wbSv7Vz0B917R6o4M+RUfkkbEZgZVc=;
 b=kslB2FNRy6qFUQXJF5dm96ekKej81z8G1WVkjIA2E5CicDINKUl7iCFrvWuKjWBZYoN4ZjSb2/JDgyTGHp0GIQ32xan6oP6F3NTkvFhfYS9pXa857jkSmsxCSk0LAc84zYraYHovea6oGSIqHGN+1qbL4r3HhjuJ/SMy75bDgRBfmOBvfBWMiFLs6kxp1aNJbVenh82SSjwgTN1Yv2HcDvhafkG9LtGVya1NgKraRU0V7ji8DukmmMJXnVlxcgRfnGoiREe+M62YzLUbREVaDo0AI+tjyejuoR5YoS2fhEZPC3KW9dcuKCCGmNb19Iz99YBC3gXCuCYKV7dxtb9tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOhehSp5WlwN3wbSv7Vz0B917R6o4M+RUfkkbEZgZVc=;
 b=B6nKrGJbvGpL/MTz9y4Yfc8YrsQpxCMOOOwncO0vOH7bOfms7uQt+R2sAUWsntEu+jlFMJ2I45ZZaDdDJ9dDyGfcmFhFVXVPjICBH+25VsaUNB0eaUu10HyGzXIOtiOYiA7v4TQ0k2lQORZrwz1Jf44bwdWRU0clkw+RlcgxeMs=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Fri, 11 Oct
 2024 16:55:15 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 16:55:15 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Thread-Topic: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Thread-Index: AQHbESZfxhsCQZNU0EGMEMnW3kWfErJxkNwAgBBJegA=
Date: Fri, 11 Oct 2024 16:55:15 +0000
Message-ID: <D99F1DB5-4DDE-478A-BCB6-C510CAFC1C67@oracle.com>
References: <20240927214359.7611-1-sherry.yang@oracle.com>
 <2024100111-alone-fructose-1103@gregkh>
In-Reply-To: <2024100111-alone-fructose-1103@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|PH0PR10MB4502:EE_
x-ms-office365-filtering-correlation-id: 9c2ac7d4-62ee-409e-1f02-08dcea157ac4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWNIcmhSQVNhbldlNVRGR1FPb1lSMVV6TEsxeFdxMmJHQ0Jtc1lJZ0toZE9z?=
 =?utf-8?B?YWdNclgxOERsd1Rqd1NtTTlFMDMvK0ZjT2dKSDNyUG1BNmdOekpJbWsyZzFV?=
 =?utf-8?B?Y2xxRi9vRUtVVnI2ZEZHTXQ4NEpDcWdKcnRFN3c0Vmd3Yk1EeEZSVmsyWkZs?=
 =?utf-8?B?U2pWVGgvZmVBamJ3Q250L0NMRFdrMjJGdUZ3dEtmZnV2bEhoR3ByeWc2elI3?=
 =?utf-8?B?UmVEdDJtMCt0SUlSamEzZXNYdHhIQ3ZaK0VPVkR3di9KdnRDMUNySFc4eDk3?=
 =?utf-8?B?WStST0N2bTJNcUtmaWVSTlI4MUppOGlLWWxrK1J3QXE3T0lIYjNDbm1lbUxI?=
 =?utf-8?B?TXpkQ2tvcHluWmhyQVpIMHhMQXA3UnlpN0xCK1dQRE1VczZ2YkEwRUtUdXJG?=
 =?utf-8?B?cXBOM09FamtuaTV0dERaL2U0ZXQvR0dITG4ycjNUMlBnZUkxZlc1OXpXSjF3?=
 =?utf-8?B?YWJHTTUxUC9mZ2kzRG5iekEyYzNNZlhPT0JsNmFoN3BncU9Ud0VKVXhaMnFu?=
 =?utf-8?B?aG5PdG0rTkhNZFBPL242TFJpNDl3aHA2cE50MTJKN2FCWXplbGIySDNHWWo3?=
 =?utf-8?B?N0ZINlRhS3RCRXlTOXZYMld2Y2RRbUl6MmF4OU9mbkNGR1AxVWc4eElIOEZj?=
 =?utf-8?B?OGxOaXFxWnpaQXJ2dGZzK3dLaDBaWEk5YXZrWTRzN0kvVnEyMDBTblhIT1g0?=
 =?utf-8?B?Zk1BaERxb1VUVEN5clpsa3BTQ1ZsT2xXZm51SUVsUkpjbHBtK3RaRm5pQ2lD?=
 =?utf-8?B?S3I0ZEdIT0I1MG1US0FBT294KzE2SXR6R3VYd0cvZ3FnTjdGRGRkZzdjd3U4?=
 =?utf-8?B?WGFrR3lORmtXZmFZRDRONTBTTmtoRTlDTjlvb1VGZGRid2lRWVgvQ1VLU05X?=
 =?utf-8?B?SHlwclRUcVhJM1c2TVYrYjlmYlhmRkJkSG40aTIwOCs0MlRsTG5XdUkrMlBB?=
 =?utf-8?B?dmNVZmFYNUkyYXJYSi82c09sam1Lb0VKakdmVUttaXkwWittaVhxemdRS3E2?=
 =?utf-8?B?RnY2RE56T1lXVXNEcFpmVnV4UThVbXBueEJjUnZBVEZ5d2h5L1dvWUZjV2d4?=
 =?utf-8?B?S29ZK3k3NVl6bkluMms5cFlCaFZJR2VVbXE5eUNTaXdFQVgwZFhRb3plb0tI?=
 =?utf-8?B?WXFVUi8zVWhINTBmcG1rWnFMZkRSNHF5V1dING1pam0rNDVJU3ZBT0ZXMVJB?=
 =?utf-8?B?aldWNHpkNUEvRTFwN2tvY3I4dDduWFZoQXVuWkxXandmQUdWNlIwcmlZNldE?=
 =?utf-8?B?ZGhZNlJCdWVycG1zM2dJcDRsbWE4Vko5S1N0SFE2bFdxK09JYlRsMUJpTTEr?=
 =?utf-8?B?VkZuaThvTjNkU2ZEc2ErM0MrOWxEVU5nWkNhNmkrSUMwNEszZW5PNnMzMUEw?=
 =?utf-8?B?UVpCYVBRUmFTbHJGVzJvdmpVcFNiWGIyZ09sQWIzU1JYeXhhUUQ4dG93Zis2?=
 =?utf-8?B?aUg0U3FPM2ZEODVMNXhqMTQ2UDM3Vk01STBnL1R2MlBvaVByTUhKWGFQTUVr?=
 =?utf-8?B?T3ZtbFJGWUhyMVpSdkc0VGpDQm5VUWdzNFdkdEwvc2ZHSXoya1pDUGZ0akdO?=
 =?utf-8?B?NWIwWGt5MzRyVjZRNDlIUFYvMlRIdDdPeWN4dVpKbHc4Wm9UQUg2TnZJd2VV?=
 =?utf-8?B?UWlGNXkxRERHaThEZ0d3OUMveVlULzBsNm9URjZaclUwQTRHbG5uVDN3VVEr?=
 =?utf-8?B?Y0RKckdmM1hQSVlrKzVqVGdTSGNrUEo3K0s3R0pNcU5FM2pNN2JIOWt5bW90?=
 =?utf-8?B?ZFhrOGg3bWRCWXZqc3N6WWw1NGNVTHJuclMrMnR1UGhpYUxQbDd3dlpuUjVu?=
 =?utf-8?B?NmtpZVRWZWdsNnRCN2hBUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWdIbldGeVAydGhkSi9MZTJ1V3MyS0UvYjdnMmFmNVUvZjR5SjQxRXBIMVky?=
 =?utf-8?B?RW5jZGRoUVZhbFMwLzNRVFZZdnh3ZUd5bXpaREJTYzduSEFwckMzQVlYczJu?=
 =?utf-8?B?clZ6SHQrUGszZmZRZEc0ZEpPTUxJZlM3MDJBcFI4dGNUaXZZeldrQkNTKzBB?=
 =?utf-8?B?d3RWSGt6WVNFMkVwbzg1UXk4bWtHYVhxemliYUxBZDRVSEcvSmxveGpJaDI1?=
 =?utf-8?B?bHdsbkNzOXpUdDhoMWpESG1idjNVWDdJdS9aVERUWmRibnpsMFU2VytmcWNr?=
 =?utf-8?B?WFEvR1puSG5aRDJqWWYxRDlmOGlXM2szNm9rbkxtd3hOdzhXS0xqZDQwaC9D?=
 =?utf-8?B?MmZUbjRtNUpmTjUyeDYyS0RmbmN5ek5tdTNZM21zQTR6bHR2Z0JZMzBjYTcy?=
 =?utf-8?B?bVVndlF0RlMvMktqeVVESlJ5TlNSbG9FUHpqZ1o2d0NmcFdiS2M1b2dEcXJ4?=
 =?utf-8?B?VGJkemh0eGFLcGcra3RsbWhiRWVRZVJGQiszUlJWeEhLNUpLRGxFMTBNbmtU?=
 =?utf-8?B?dVFvekkwWjBYK25QVU42VDQ1QzJWQWdzZVBkYzg4UncyZ2NBRHFwSnlBOUJJ?=
 =?utf-8?B?SjA5ejNYTURxVHY4eFl3cU1hZ09QK3B5elpSeFlsbDQ3OXc0RmFjbGR3ZkVu?=
 =?utf-8?B?Tnhza0J4bnZRQ2x6eHBCUURDZmo2VXFrVVdCNUNWaXowb0M5RHVtdDFCWCtP?=
 =?utf-8?B?L1FoWDU3SHdOVk41TzdBbU9YNXR6TlpsemQxYjE3c0hCRUhBajBBQVpNWXgr?=
 =?utf-8?B?aGtadjU2WDVnOHlFMDJsS2ViZlRaUUttaVQvWTVtYk1PUHR4RWJDZjM5Lyto?=
 =?utf-8?B?bUpqdWN6N0FXUXpBaTRlQzZOalB5alJRZWc1NUM4UThwc0tnYURGRDdQNEVz?=
 =?utf-8?B?Vk9SYU5MTnQraFhFZ0pIREI4dkcxS1VPVXQ3cGExK1cxWXJ6SUNUZnJqdjBw?=
 =?utf-8?B?UzNCYkdJZ1U3dTgwSS9KY3ZVZ1ExTVFKMVY4eEFJMHhpaFRwWGFZbmZrd2xN?=
 =?utf-8?B?disrYzRvQjhQR01Pdm9yRkxVRno5alJiK1pOR0cxcU9oUE1iNmFjNVMwNHRn?=
 =?utf-8?B?WWFERGZTbXBYQjBTOFB5UHRkZ2Rxdk1JdzVRTHBiOUFNV2paSkNCMHVKMUxr?=
 =?utf-8?B?bW1laVRCdVcwOGUwOTdHay8vc1dZd0VyaHFVSDFuMWpoSi9wQ1ZMSGpNOTJG?=
 =?utf-8?B?VzU0TmR5T3haZDJXMll3aEhNeDJpY24rQVhERXhncnBmeU9aS1JiTDA2Tllj?=
 =?utf-8?B?b0ZyZlByNjFISmdTRlZqb0lsbnY2V2wyVzZRODk5YWw4N1VzdklGSWlJSUdo?=
 =?utf-8?B?N0c5aXQ4bGUvYWNQYm5jbS8weGQ1ZityY0E0a2lQRUExWDhSMFdCUmFvOVY2?=
 =?utf-8?B?c1E3WE1LbklpQ1A2MHB6S3hueFlvSmpiQk5NK3hKblhldHh5TlBVMUQ5N1Q4?=
 =?utf-8?B?Q0pKL3dIeUl3czF4RzJzdmJNbHJMVmROTnM0bmk2TXRuN0ZqZk1lbFhGRFVj?=
 =?utf-8?B?UGsvNERBQlFKYnNsWktSNjZ2VC9lNzhoWjBGVkpFZGU0ZDlBSGpCeUhPVVBE?=
 =?utf-8?B?VFVSVk9rb09QUUt3cEdNTXFoMnlBdjNhWnBiM2dkUTB4d0tHaXhGSGYyZUwx?=
 =?utf-8?B?T21lalhVVktuVXdRcWJCeDVxTERoSElKb1AveG1SRHdRTzlpMzkrZm1SZ3V0?=
 =?utf-8?B?VWsvcW9hUGtJaVFrSEVOUVZKN0hFSkprbDNGOHZtTFJIRDdoOFpxdmZIVTdm?=
 =?utf-8?B?bkpWZ2VZZ0lPTG8wRVBDNEdYWFdmeS9ja3ZuQ3NPaWxOMnc4TElIeW1rTXR6?=
 =?utf-8?B?UmUvUVhIaGQ1Q2cxZVIxMVRZYzVHSFBUZkRoVnZwN1BDV1puNDBqT2lhY3lF?=
 =?utf-8?B?Y29aR2czNzk1VDMwZW5UVFhWQW1ERFh4VTBLdk5sQjk3b1pVb3ZvNDBXMUc2?=
 =?utf-8?B?ZkZEVG42UDkzcDI4S0tndE5hRVl1ZStyQkQ5WFc0bXNpQmhBTTFWU0dyaUsr?=
 =?utf-8?B?aVJvdElrS1hGUStTMGloWG5DdWJnOThDdkZwNldXYkRkWWlCeHlXV01WNTFr?=
 =?utf-8?B?cjlGU0xSb2VXMFowemFXbkkyTU52RTJ3bmtRZXMwZUlESkYvbndPei9IMDM1?=
 =?utf-8?B?ZjE3Y3hxVDdYWG8zSlF6aUhtQVFjRWVqSHhrQ3B2MVFjVXNwRnFlVWlvdmYv?=
 =?utf-8?Q?JA0SJxpkDFA8rJmbA3rwsBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <776AEF731A37BB48BCA811CBB715F5C9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BIY8sopku7K2WLa2YL1boaVA91Dj+Qo9VmE6NOqnv1vx0x6Iv42CFy9Eng2Eqq4GxdyCzkHbv+5eJq9LIp1lce0ptmkLqpQShkMSy4qAso5rSdCbTU2Wm++wUAyF25L8QY9n7MLRsHxcUu0gl9wjBpwHXcBgtUknvwsh6y2Ue7FYRHY3qv+A6Ia52ScpAI5835oNdoqLnL2SWkOqa9LojIfPRu7Xp+H1Y1KFTTG8l1jtxzo7NkABQdZc+Y1YP9UexNBRNlu3TK8EuDxTPw0lIWWrrSQEcjYuQq6SS7VYvIPl+b4opgBXVyYQ5z0u3MpN1GAYbh+7LyGQr9M5BXlZKQtbQSsBwWAYx0wIRAc6FCUbOWxAmvLL26YV4JQ0CwvkRz+6fKn3xcd/8Gp6LFpQOZVkP3df3Ij6nYU7Uk7jKGfJaeh8P4F+EtDj5WKvEe1H/t49l3rFO4Nwd+PpaI93OQVu3RYo3I367RmbsC4q81lEGavNzD8uEOgqkDYnqWMD3I2W44JbYtz11fz5SoNwcu6lgSOvZzODq58kR3oNiKmbdutASnLEbuZW/6ZNG4+QlSwOfrklHcV2GcBU05ZO6RXkoV6cPhGybBLKaLNJJgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2ac7d4-62ee-409e-1f02-08dcea157ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 16:55:15.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1isewDKzAODsWhoSqWn7vhOBVomubzL8YhPrrkv9/cWb1KmwCyAmo66KDnMBZUcrXGgidakJx1uXwO43LxoxLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410110117
X-Proofpoint-ORIG-GUID: SasKft7ezIhaFVIwOn42_e6qhBb2fBkv
X-Proofpoint-GUID: SasKft7ezIhaFVIwOn42_e6qhBb2fBkv

SGkgR3JlZywNCg0KPiBPbiBPY3QgMSwgMjAyNCwgYXQgMToxMeKAr0FNLCBHcmVnIEtIIDxncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIFNlcCAyNywgMjAy
NCBhdCAwMjo0Mzo1N1BNIC0wNzAwLCBTaGVycnkgWWFuZyB3cm90ZToNCj4+IFRoZSBuZXcgdGVz
dCBjYXNlIHdoaWNoIGNoZWNrcyBub24gdW5pcXVlIHN5bWJvbCBrcHJvYmVfbm9uX3VuaXFfc3lt
Ym9sLnRjIA0KPj4gZmFpbGVkIGJlY2F1c2Ugb2YgbWlzc2luZyBrZXJuZWwgZnVuY3Rpb25hbGl0
eSBzdXBwb3J0IGZyb20gY29tbWl0IA0KPj4gYjAyMmYwYzdlNDA0ICgidHJhY2luZy9rcHJvYmVz
OiBSZXR1cm4gRUFERFJOT1RBVkFJTCB3aGVuIGZ1bmMgbWF0Y2hlcyBzZXZlcmFsIHN5bWJvbHMi
KS4gDQo+PiBCYWNrcG9ydCBpdCBhbmQgaXRzIGZpeCBjb21taXQgdG8gNS40LnkgdG9nZXRoZXIu
IFJlc29sdmVkIG1pbm9yIGNvbnRleHQgY2hhbmdlIGNvbmZsaWN0cy4NCj4+IA0KPj4gQW5kcmlp
IE5ha3J5aWtvICgxKToNCj4+ICB0cmFjaW5nL2twcm9iZXM6IEZpeCBzeW1ib2wgY291bnRpbmcg
bG9naWMgYnkgbG9va2luZyBhdCBtb2R1bGVzIGFzDQo+PiAgICB3ZWxsDQo+PiANCj4+IEZyYW5j
aXMgTGFuaWVsICgxKToNCj4+ICB0cmFjaW5nL2twcm9iZXM6IFJldHVybiBFQUREUk5PVEFWQUlM
IHdoZW4gZnVuYyBtYXRjaGVzIHNldmVyYWwNCj4+ICAgIHN5bWJvbHMNCj4gDQo+IEFzIHBlciB0
aGUgZG9jdW1lbnRhdGlvbiwgd2UgY2FuJ3QgdGFrZSBwYXRjaGVzIGZvciBvbGRlciBrZXJuZWxz
IGFuZA0KPiBub3QgbmV3ZXIgb25lcywgb3RoZXJ3aXNlIHlvdSB3aWxsIGhhdmUgcmVncmVzc2lv
bnMgd2hlbiB5b3UgZmluYWxseQ0KPiBtb3ZlIG9mZiB0aGlzIG9sZCBrZXJuZWwgdG8gYSBtb2Rl
cm4gb25lIDopDQo+IA0KPiBQbGVhc2UgcmVzZW5kIEFMTCBvZiB0aGUgbmVlZGVkIGJhY2twb3J0
cywgbm90IGp1c3Qgb25lIHNwZWNpZmljIGtlcm5lbC4NCj4gSSdtIGRyb3BwaW5nIHRoZXNlIGZy
b20gbXkgcmV2aWV3IHF1ZXVlIG5vdy4NCg0KSSBoYXZlIHNlbnQgdGhlIGJhY2twb3J0cyB0byA1
LjEwLnksIGFuZCBTYXNoYSBxdWV1ZWQgdGhlbSB1cC4gQ2FuIHdlIGdldCB0aGlzIHNlcmllcyBp
biB5b3VyIDUuNC55IHJldmlldyBxdWV1ZSBhZ2Fpbj8NCg0KU2hlcnJ5DQoNCg0K


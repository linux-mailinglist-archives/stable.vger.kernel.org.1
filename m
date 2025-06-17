Return-Path: <stable+bounces-152864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA1ADCE9B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F713A3346
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2193E28D85F;
	Tue, 17 Jun 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nFaEyezp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gAeFnbIk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB442E717D;
	Tue, 17 Jun 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168593; cv=fail; b=YstXUVYAHHpmbYCyJVY3rV/LOHUrWM3jb+wOATVxnacsUJUX0rf0wfB+kEjYhTkz/6dt+SlGbyXouLpE2OUT1vlJ4gdq+45QHMFSHHq+JNyXicWC4HkxjviwPzn1WjaF8DZnaJzbyYXeFbp/c2kGFCW5niwjQ8u8iHHm8siIjME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168593; c=relaxed/simple;
	bh=jYYyfLdoHLq9yMZJDDd+Ww2JO/8qaKTAyDpWOEiwTe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oO6V4ga2twxXEcxZ9YrgGrq4v+TKseUEZ8m5uDP3IRsWOHk23Uno+iidaT8Sl99XLoFSybDl1EXnF7YErZNSqM+sCncha65xLF6oH9USCQpyR6nrEMWslwascErpkk5cJpC4iLuk+Ur66Hzb8YmA6+gD0lYqZKEoTty7d5Ug3O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nFaEyezp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gAeFnbIk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H8tZch026743;
	Tue, 17 Jun 2025 13:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=s1XoxTfVpeEDUnG1iMKWyRkuc738x+14YU/2Q9pO0Vg=; b=
	nFaEyezpvK2UGgooCzDRiHK7/30NMFFgrcwkbM5dhs/kdCJcYrGAlrvxvaoC5IOA
	B5Z+4jZl9rXrAysrlUOnST0nKOIKDDAU61DAbmSWqQsoADAKfQS+XsySEdv+za0m
	iUrZpWpfPoObalWUneKkZF00jUYM7AV6b9xwDLnTtI5Y+XaLEkr+IdRZr/IZEkeU
	MJTIZRXdGt765B+200xxnqDHfK2YFNaais8zcbzhehAQ88VBTZUrdtd/r6f17H9W
	vaucWs4Y9M5sxEnFHDkb7/aYmxlrRhyqdcWeO9Sgaedmi3FOhg8vNsIpROL9vHeh
	JNSXA0V611it2SIZwfVCeQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914enacu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:56:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HDVUXM031700;
	Tue, 17 Jun 2025 13:56:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh91360-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOF3eXpfQ4l8FiSnoKuD1BhMqoD7mMrBk5l8l+u7JFTgpeKWO43V7iRBL+2fsDetxCaVAfUFpqvMXZQnPye5AngPHRMJo920fIp/4rv/ZSb4JMZXXIz3E8mhffVidVWQFjpRZRQ6wde1L/yfvXrPdXvIvzdsiOQoegptE3YTql4aPCQbFIYFTd0olqffqDYJLw12PRjuHgY5k8w0bsJb/4PW7co9eGyYA9r5uFYZJ10rmsr+Wlr0GTbqRtkvRTGualyYiCSnjhZx0ys3Qz0vN77SsNQ5/dXLGTZAYR8tG+s7mNcpnEYD4r/0xeTsqVeBp/EUCimeb//+723g4btGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1XoxTfVpeEDUnG1iMKWyRkuc738x+14YU/2Q9pO0Vg=;
 b=eHe8MyqmyVfVyXpL4fCSQdhDYgZQPLeYi0m6U2elSBIZMWLT6IeR3el22+8TikBNRytRVyVK6fJscR2O6PxR5s0X2ONfy3TALdIVLe40k3YiX+VtCpLwaBuH+ZcCYRLzZ2P0bsqfGMzbOZwwpF9HYcdXcBBSJaSQiD4X0QWJT/QNLkpLaH2HH9/PVfgpu5MektFcLDsGsXr422RpliXlVwIaLlL23aYp0WUQPaQKFzw7fDexSaKpNSeP0hwysGsYeOP8BY0bTJVIgn7Opi92TxskwTf6VmUSpWi71+RbkyWyrHeHG9D/1XDOaJMyqXvApTQFHP7HtRyEhc8329FRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1XoxTfVpeEDUnG1iMKWyRkuc738x+14YU/2Q9pO0Vg=;
 b=gAeFnbIk1xB7JEo9+JChJK9WKonC6mZcBcP9zjDR2m1oAhbYxYpSSIEIVJnV/gaSlV+bKBHG/l2SI6ICuuLw/p9XDORsuxog58xgsv8vzndwCcu8aMuA74mtq3X7Q+1gXTpzazqAzxZuOSnZDzHb8FS51l4P2ua6hUfKS8jHfD4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8325.namprd10.prod.outlook.com (2603:10b6:208:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 17 Jun
 2025 13:56:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 13:56:22 +0000
Message-ID: <d3378e71-1bf1-40d1-a1f4-3a7fba6834cf@oracle.com>
Date: Tue, 17 Jun 2025 09:56:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Request for backport of 358de8b4f201 to LTS kernels
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
References: <612fbc1f-ab02-4048-b210-425c93bbbc53@oracle.com>
 <2025061709-remedy-unfreeze-0a29@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025061709-remedy-unfreeze-0a29@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:610:118::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dc2d5f-2834-4bbe-cc92-08ddada6bdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjRuTTV1elByUkhVR3Jnd1dKUGd1cXVPR2t1cnBjNWlNc3gxQjBvaDB4aXZx?=
 =?utf-8?B?NGsxWkVxdFFmUmhwanBrZFRWWVdaR3E1TTluSXdFSlpnUzQzUWpuRnlWYzIz?=
 =?utf-8?B?eHdIN1ZqN3NkUGVqUk9wN01pTDJ1aU1kOGVjRmNxeVQrUXJqYW1NMWhEcEVH?=
 =?utf-8?B?US9LUlZQNTVPNWlRQkZLQk9iTnhhRGZJWEovRGtpOGNwcitrY0FLSWNmWjFn?=
 =?utf-8?B?RFArQWNqaC9qaUFSOVM3SFROOURPV1RaNFBPb3JhN3Z2TloyQmI2SnQvTFlt?=
 =?utf-8?B?bUVzNzFjSVV1RjVIWC9UVDdiMXAvMDkxVzk0S0Y4K0NUdVFnd1Z2aEs1czZs?=
 =?utf-8?B?NE9vdk1xRVg4K2FsUGZNUHNpQ2ZTdDZTeno1dTlrVXJkYkNGRGxtVHdUVjB4?=
 =?utf-8?B?RllUcGJiZVVDVnJjL2tUMnVlVlNBMjJvVVJpMEhzMXJwSW94NGtSU1ljcGgx?=
 =?utf-8?B?clVDeEd6eXpYWEc0YmNBUU5ueTFYelEreFpnNE94L0p1WTZLamQ0akJTRGhy?=
 =?utf-8?B?OHZjMGlkL1doSktoQ3NsZGJueFdTMi9QSlJMdEQ3UndtOTJLQ0xjckVyd253?=
 =?utf-8?B?S2tzQXRhYXk4MTJsdXpYNnpuT0M2cUVVdUg0ck5QVG5JL1BieHRVNFNJKzFq?=
 =?utf-8?B?RThCa2dZdk1UVFhEQ3VTRzJwWGtrYVp5NVBlZnZSdXNvQnI5Yng2bUpLSlBk?=
 =?utf-8?B?WmxEaCtPYjRYbXZzU1dtSnp6bGJxTldWcE50cGpnY0R1bDA5N2RKSzRHWVp2?=
 =?utf-8?B?QVZKemRtZDZHb2c5Lyt1WnhkQldrMGNhSG1vVU0xS05JNS9HbVFwQThBVmpU?=
 =?utf-8?B?Z1RMQVlZcWozZVRvWkhadUd4THNhc0VHWVFUN3dIeEZacFp1dVo4TkM1MDVN?=
 =?utf-8?B?bnlaeTBqSTRUM2gwQTRwZDZFNWFzYlVLdzMwcG8yT1p0cWFaTmtkaWFRMkla?=
 =?utf-8?B?YnpqQ2p2TzNuakV3bG5FR0lnNlVVUWQ1K2p3VUhLVnJEcUJsc3VwekZMeUxm?=
 =?utf-8?B?WXlMaTI0cFpBV095SjR3cU9LSHNIT3Y5amZUQWZ1RWlQUzRML0xMTG01RnhE?=
 =?utf-8?B?cHlBY0xHV2ZEaEFpcE8xbGcxUVdQbzNzTHg1U0ZLb01McERkck8wa1RhUExU?=
 =?utf-8?B?UE0wdSt3b01adEV0cDdtbWVMNVMzOW5YTW5vTlZncERwQkZuTXhpbDJaM1ZF?=
 =?utf-8?B?WHNkNXJDZ2tZSUlLV1B0U2xhVnF0ajdvSjRtK21PQTVVUW5NRy9takhsVC83?=
 =?utf-8?B?MUhYOWh5MEFmUUFkZEpjQVNBaDMxTmVzeUQxMUMrUXZHYmtRSkNoVFNhSGp0?=
 =?utf-8?B?dHk5cnN6dGNiYlRNTDRvZmtJZjhVOEhCbzF5UCszY1lEYmx4VncxeGJ1L3or?=
 =?utf-8?B?Z1NVSHlHa1Y5cjYxeC9pS21mOUxsODF5a2dNS0pPYnBCZisrTjRRQytuQmxF?=
 =?utf-8?B?OVFHSGpDL1VSelFVNnRxamJWdWdJR052Y2tDU1d4dEZZbEVWcVQvT1lIZFlQ?=
 =?utf-8?B?NWRodmlrMTZVdmRYM2cvSmhHWTlWa1BTVU5xeGJGMXBCWG9rMmFnUVVINE1X?=
 =?utf-8?B?SHBDWk1hVUM4L3ZTZGkvRkNzbk4wOTdhbUU4QzJBUGQxZkFnamlybGJkbjdH?=
 =?utf-8?B?Skx6MkREUUd0NFhieWQ1WmNvWjRXZnBjRnkwMUhlOUozNlE4dXk3eng1dVMv?=
 =?utf-8?B?U0dQTXBLakJnMCtFcCswYU8zRzJQZHpCdHpQUGUrYllMc1NOQUtjSGRZa3Fr?=
 =?utf-8?B?NEZ5SEh2VE51M0p3YnFTL3VaUU9KaGx3OHdnR0M5NU1XK0loOXdyb2x1cmJN?=
 =?utf-8?B?Rm80cHhXbGdBeFFtdXhtWUhjUFkzZ1BQT0VGL2VuUm5SbHlyOGZua0xna3dt?=
 =?utf-8?B?eG5zMnFZZEhjaml3VzZxeElsN2lVRnFhZzZLMDFzVmcrR25YQ0NTeWt3OFgy?=
 =?utf-8?Q?XRBVC/0Cy7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBEOElndk9jWjhBWURqS1RQdnJmVWdXanRpYmVjWTRjZGhEZm5jUHNHdTRR?=
 =?utf-8?B?Tzh0U0xldTFFalBQTlpxQ3dCNHI2bmdZNlVGanN2NkcxZjNBQXZaWmtJcVdu?=
 =?utf-8?B?UUlob0hYbWVUeE0rZVRtajY0R2VRUjMzUDV5MHdoV1duRFFnTTd2MVlVT0VC?=
 =?utf-8?B?VGU5UlpwcytiQ0N2MjlBZHU4VWc5UThOeTZuSXllek9PemM1MlJHRE40TjBJ?=
 =?utf-8?B?N1p2ejRKUEpUZ0dHS2dab0ZKMk1DSDhlb0gvVS9Xa2NRS3RSMUtLMDNvZkVi?=
 =?utf-8?B?eHJiaEpISEZ2bzFqVGFKQ1ZGeFoweXNyZkM5VFh5akttZG1yOWVCeHlsSXAr?=
 =?utf-8?B?bEpyVzVGUXNwRFZZbS8yclNuRFhibXZPcHVSVG5aUmJqUEFQZlJtZDFWSVJW?=
 =?utf-8?B?SXgvZitaRFpBQ0FtNldlM1NiM1laNG5EdDczZkUwVGZNbk0zaWRac2dWVWgy?=
 =?utf-8?B?alk4cVdPeWF4QjdyYnNRalUzZEY4WlFYbXczMkFjdFJ1TmhPb3lnZ3ZqZlJV?=
 =?utf-8?B?c1o0L2tpQ0g3RmJORFRSS3F4TEc4NWJQTkc0SmoyYk9FYk1TWWlJOXUzaml5?=
 =?utf-8?B?Y09nQXFVZVNBL05PWnFsZWNQZFhGTStPMm1YWWgzQlNNdmZIL1J3OUtsMVcw?=
 =?utf-8?B?NWIwdnV3UU9TTnFIRHZ0cUZHYXJ3NEUvZ1NSbUg4S08vQkNrU2xBbGhmZS9Y?=
 =?utf-8?B?K2dWeGxJWVh2VFJYNnF6dy8xaitVMnVSWGpYenF6SU1vTjFIWjYzR3RDQldH?=
 =?utf-8?B?bDZ6R2twdkVueUZNbERDTzNRNkVvZjZiSFliRkVBR2JSQlc2YnpvR1dsZU5F?=
 =?utf-8?B?elFzdC9qMWkrUGhGRFNqUUtKQmdYK2hidGtnV0ZTd0U0eXhCZE5sWGJSMDg5?=
 =?utf-8?B?ZWJVRWdqc2U3Y3ZNOXRBOEwybnhtMDRQcjVGbXVTeHB1M0w0bWlHYkZzMVBP?=
 =?utf-8?B?U0d0VUFUQmxONzVSMEM3NFpGMzlQcUNMbFhIMXcreTM5NnVrL250cUYrYlo5?=
 =?utf-8?B?VGJnQWFIVzZMbWl6Y0NMUFNENWY3aDJrOFZQVEYrOENESUR2QlVDMlNSQ2s1?=
 =?utf-8?B?TmhyTVA2c0lOdG53ekpSZGRVZDd2QkJSckxVd3k2TlljWlJ2MzVGeGZXcnlm?=
 =?utf-8?B?VHNmaUpqN3JwV2NhdlNOWjNQY3pyN012bjVFWE9WK01zYldKWUZKSkhuQUFK?=
 =?utf-8?B?R25uaVJzc0JxQkQ5NllkcS9zSjBrSnNwK2JQUUx3UVhKWG9qZUlZU1Y4bmEv?=
 =?utf-8?B?cm5yWjRQMFdSbFhVVlhUbCtWU2M4TEFzSUx6Tzh5SUJOZ3Fhc2lRQkp3cXVQ?=
 =?utf-8?B?aExWWkVDdUxEMU9PTFJMdG5XUkNxc000dWptejVnQjJ0L0JDWUlLOVhZUXhO?=
 =?utf-8?B?YW1NQXpZazUwdTdiUElZbkhwVnZzcG1FQVhudzFiSC93ZHhGSEU3U3hoQ2Vy?=
 =?utf-8?B?L3M2cmR0cVM0b1M0b29mTEhsSFcvM1lNMlFraVZ6RXhpOHdzME14YW5Sbk9B?=
 =?utf-8?B?U1lSdmFlLy9yVkRjeGZCOVpDYWNSTm5PR2RudlVtKzdCenM3UXM1NnlKMGVq?=
 =?utf-8?B?Z2xVMHZpTzVUSG80OXJLdzEvdmZJU09xeXJENnJVWnhlM01QbFI2cm9rd1BG?=
 =?utf-8?B?MWJEd0xmeFN0c1dYUHg5elBqeEZtc3Q4MVpSaUFGSTlwMUZ2V2pYTU1YRHRU?=
 =?utf-8?B?bkNNUm1RSFU1dGdPSmNzQkUzTkdLUE8wclFFTWVTOTcwWnRZOW5RTE5WbTFT?=
 =?utf-8?B?aEhEYXN3ZFFNZWR4VXB1dy9rVTVhR1o2LzFwUjYxajVxTFNrSTI0c0dlTjNS?=
 =?utf-8?B?VFgwRmhPY2tsRlRSUVhJdlNUbkc4eXVFV0I5b095YUp5N0t2cE5aSWxWMUxG?=
 =?utf-8?B?ZTZBbVRHcEhGZHlvRU1iam9HdG1MY1M0OEtidU1CaGN6a1NEbmFTclEzeWhD?=
 =?utf-8?B?TUplNEZ1SlY5RlY3SHhqYS9KU3paVEFtQlFIM21XN3B5cWF6Y3UwWFRMb3BU?=
 =?utf-8?B?OGpZK0J6VW5LTEFpaGRCRFdITTR2OUx1b2pXdVJWbXRKSFQ4Vys1M2xBRldi?=
 =?utf-8?B?WXNpUDdvZVMyRVRQaE1PYnpSSnl4Rk1BT295ME5mOTV5SStueWxUK3BLcEFu?=
 =?utf-8?B?S1FmaDRrUEhVVU54Z2RWQys0dnkyVEJRUEhHcUQ5L1JsWStvQVN3SC9JdXZl?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o5wpe/QHNY9UxBSfy6LbhvSQZq1P1UvKeQJQUmWe8rdwVqyKv4rLB8si13NO8X99XP5z0UTgR4TZwjqhcCitjcOIfBEKRtrT9cfJAdpDRQAgo+o/XYbzudzQvtlcS3UTn/peVYSmZlVojnSGJuHLX8uyU71GSCLSMCWcSpixjk4nysAROSuIja+i6gZtR6p5YAcNbKAg1wV/V0lUKiO+oQA6YFy0zZ1CDECjV4ncHXeBI6+OjD/bgcqJblcrN1T4wZcEB8R/qF1pF9XqfKPIsLx/LJikWbFRpcYzlp19SixLSgD0/M2PhC7r6ufaE7KA21Du457QY+/CjjVhljOAb1o9UZtWo3c6w+2LDCObAo/Tp3MXlIS5xJSmdTqw2S2XicMY1B79x6E/80aE2/Tkt3125zcLy8MnOFvJUo8WXe+iyS4pogimNIZO0TxoPvCcI2SFTmXpkYOv+8H+jPT3mhrgPT7PBG0CloPse3a16Ef6cOsgfAEMRD/gpmhcg31c4JQ4Cs+5kqXnrBaw8pDcP3nGZBdHnx+p9traneo8/gheiMGdgAiFxN7XLUl7LKSl2BXmHoaKOToRW2GRhXq1bdn9eXa/MrjTJzwAN7IXDBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc2d5f-2834-4bbe-cc92-08ddada6bdf5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:56:22.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EBTodSxXlOajxh/LJz95qxJyxGyOWpCyI97baONLLEsIpDL1215q/ouKNsFGJ+Uid5Lgq8UGXLOr9YbLXKW+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwOCBTYWx0ZWRfX+lJTSgtsQREf oyH8AoEAdBy7nQ9qKmf/MccQmxxIP8Ujn9F7KBysqSgyZE2ZsdtSbwEH0AopST39CRGnb7F94Bs 80MgBMTf84jQWmXDw/yT7w0cxQpWq8390Y1Bm+pBeQ8hPBzsOw4IB5FDel3p13bfWPa1JL6d+61
 GSo+9IBqwgUoufDORXpal5acSE39M4SVu3W+PFxJrlXvp4VhffrMcwX/ee62YKTG00wJEhpOHWP Ozh0aMe/WFZjidhXB0GpH6jDQKicHzi/InTy/UYFyyE+KpUnQ28cGS2/Bt5Rwwn73L3+qTJFnai PUTtNOqOi8nOnp7qV5at8k99vRp3aVJlIi/POa4dRHGuf48PHmUVNj2+12Dr3jXIZhbJMdCEU/4
 33Nt0FbtBwK9vK6YvReYoZM1CeOdsi0mWlbb2k2NTfKb0erb/CbwKEbbCytrioxRX5Pa/HhY
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=6851740c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=wiZAANI22Tl_EigMMeoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C7m3lNyVvr_YAz3ZZocQDZZigKs5XLdm
X-Proofpoint-ORIG-GUID: C7m3lNyVvr_YAz3ZZocQDZZigKs5XLdm

On 6/17/25 9:51 AM, Greg KH wrote:
> On Mon, Jun 09, 2025 at 04:30:19PM -0400, Chuck Lever wrote:
>> Hi Greg & Sasha !
>>
>> I ran into some trouble in my nightly CI systems that test v6.6.y and
>> v6.1.y. Using "make binrpm-pkg" followed by "rpm -iv ..." results in the
>> test systems being unbootable because the vmlinuz file is never copied
>> to /boot. The test systems are imaged with Fedora 39.
>>
>> I found a related Fedora bug:
>>
>>   https://bugzilla.redhat.com/show_bug.cgi?id=2239008
>>
>> It appears there is a missing fix in LTS kernels. I bisected the kernel
>> fix to:
>>
>>   358de8b4f201 ("kbuild: rpm-pkg: simplify installkernel %post")
>>
>> which includes a "Cc: stable" tag but does not appear in
>> origin/linux-6.6.y, origin/linux-6.1.y, or origin/5.15.y (I did not look
>> further back than that).
>>
>> Would it be appropriate to apply 358de8b4f201 to LTS kernels?
> 
> Perhaps, if someone actually backported it to apply there, did you try
> it?  :)

I didn't try it (laziness). I'm happy to give it a shot.


> 
> At the time, this was reported:
> 	https://lore.kernel.org/all/2024021932-lavish-expel-58e5@gregkh/
> 	https://lore.kernel.org/r/2024021934-spree-discard-c389@gregkh
> 	https://lore.kernel.org/r/2024021930-prozac-outfield-8653@gregkh
> but no one did anything about it.
> 
> thanks,
> 
> greg k-h


-- 
Chuck Lever


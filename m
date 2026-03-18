Return-Path: <stable+bounces-227072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIJsEW2oumlpaQIAu9opvQ
	(envelope-from <stable+bounces-227072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7672BC1AF
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86B9B301E7E1
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7F3D7D80;
	Wed, 18 Mar 2026 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="KSCQ7RQ4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FA3D6467;
	Wed, 18 Mar 2026 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840489; cv=fail; b=FZxcjTyWznTPWQzCODXzYKsyiXlP/DKnk9y0VUd3VTNgqT6NFElDtlZxhjrehlQjeslNkYiIuOr+43euxj5sl9MohIarzAOvmeE6OdJNW5EJNIqB05yX1P64ojd3X4FRzAnX9XlDdmGINCP4BwnYCRSXySmw4E5KHqwzUW8FA2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840489; c=relaxed/simple;
	bh=k4hWeWazJjNSPBdLch3FbWUIMZarEAXiBLo3DgjLptE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nFHPgoFDdn890XWD5NoGk9qL1onahYsGNEoRMqDq2/q6qU5cnFcPWYYJEDYpYcHAuHnUqv5ER2ooOj/PR9FwF1wXphO8ncoyIwTa4GVxdpEa3BM4g79robJoI7jRa44OCzGQS6t8ZmQrP0vLplbPbBoq0OqPvVrZHetkAAGT6zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=KSCQ7RQ4; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62IACxKI2511865;
	Wed, 18 Mar 2026 13:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=JR9dX4Yux86vENPKcOGUP9
	CLqZix2xlf2rQ/aXIK0qg=; b=KSCQ7RQ4mpSMtWiX4LyVE8VK7PoWGtlZzPknFU
	n5PDe0AuC0xStH3Tb139UeBnLR3BSj4t8s/jnGdRGuIopSHmS9qFcLZG366ns0Bt
	VAtQREkXDue5ouyf7RJyGuyPXkUhd/1cbnOshMF7Sgziwfw8uDWDHX3NDEiFIhbg
	wpwSgmHQ1PC/eIKTI7Qhe9EqbeiIjQ7Ur3efM/y5py+F3uTcCawCMp4W8KEVRrS9
	5NFxZUjx8zOCaOoGDHcInPqBBSogCi9oKSaaabH1cQVVF/6KkwxJrNyYzcGEohxY
	Y7pAJM5nopU2IqeVUUJAJ2BlRYv80tx/u4lpYbGQB4mdNn5Q==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4cwhvrq56y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:27:44 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDJkGK024661;
	Wed, 18 Mar 2026 09:27:43 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4cw30x84t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 09:27:43 -0400 (EDT)
Received: from ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 06:27:42 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb7.msg.corp.akamai.com (172.27.50.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 06:27:42 -0700
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 18 Mar 2026 08:27:41 -0500
Received: from CH2PR17MB3797.namprd17.prod.outlook.com (2603:10b6:610:80::18)
 by DS4PR17MB7880.namprd17.prod.outlook.com (2603:10b6:8:323::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:27:33 +0000
Received: from CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2]) by CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 13:27:33 +0000
From: "Boone, Max" <mboone@akamai.com>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand
	<david@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Vlastimil
 Babka" <vbabka@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Suren
 Baghdasaryan" <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Topic: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Index: AQHcthbQ53vDINHPrkGROmzcGUn1MrW0QNWAgAADlICAAAVQAA==
Date: Wed, 18 Mar 2026 13:27:33 +0000
Message-ID: <E9058409-F4D6-4146-9366-17E87FAC9812@akamai.com>
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
 <7ded426a-0cb5-437b-9634-8d806b704db6@lucifer.local>
 <719CB417-F511-402A-91E3-8A696ABCE0D5@akamai.com>
In-Reply-To: <719CB417-F511-402A-91E3-8A696ABCE0D5@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR17MB3797:EE_|DS4PR17MB7880:EE_
x-ms-office365-filtering-correlation-id: f77b1e4a-5b66-499e-5e32-08de84f21ca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|6049299003|376014|7416014|1800799024|38070700021|4053099003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /SJk6PD+47CvDz4UlduTZRwxGhyPrgXmYrL4g50rlYVDhsMHoczAEpYna3N44JAVe2dJQmWw/JOY0UN9Kk57tdcaU9PYV4T726BGt0lC0Rf1lVdcEvASxHA+KgboK2SCLMlH0wiv+MTUKFheDlW6Vgy9mDISO+y/S61Hmh0iYIxxiJ+A1uOfC7pUHCxhBRv26XWcmLgXZemGxwnngc9oCXHqW8cIJnLEs/7NI3yIMyJ21qg+TNICp4Y4Gxyy1x67h89KT/c4dv2Pc3ZPCTDe6spwK776zvhAmzVVcTTg/1qEhsMDvM4SCgbD8g3KFTKmTwR+RpjbtFadjmeSemJbBEjqqljhzaix6oKdYuI8vJvsEKw76fIzqwPA2+sjlp043iTfJXxQ51MJ5VHy7vgqlf+8lY8bVZ1daHz1+vT8syVbgNWJtnimoPgWvsiDS/lN8cwmJ++Vlwj+Can6PGAMNulb+UG3cQFWzPTWZqluHcRpwIPcIza7fPZYqP+tRT9c4BfYisYjbe9z2ACb93woiPdqR4TmGZLZXr0weRtKYlfZg90CgXh4zU9rhRnXq0HgkItCk7l5gkgXYpegeCwZz8VQMwsud0+bFbmOoMKK2ZEUVWurhzJPMl97R8fRFPBAtwr53iE9bbsBiL4fpzFYXUJKqw/dTEW+T3g+Z3GeYu/tf/qN0V05lOC/MN2pGrJbVzw7XXqdq0wDpUDrTvnB0oRGja1KoO2w+9r/HtEG++2bTu4UeyyZ5b0lK0Nqvh9y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR17MB3797.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(6049299003)(376014)(7416014)(1800799024)(38070700021)(4053099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDZ1S0taTldkZzNLNXl5WUw0NHdDWWdoWEJZcm9IUEFZUjRMQVVKNzZiYW1u?=
 =?utf-8?B?YjRyU2UyV1hjSUZCZTZmblJEN0pjRTZMSi95b1hTWE91aGZUcEhWUFp1cm9K?=
 =?utf-8?B?VXluRkV2Z3d4VlBRQ0paVTEzWTFqODN6ZitvQkl3WVovQndocGFPQW94UDNM?=
 =?utf-8?B?dlBuMHZWVTk3UnZQaFdjZE9OZlNqekR6bWsxenNXSWJmV3dTa3VyZzY5YjZS?=
 =?utf-8?B?NlR5dFkzSkN2VzAwV2VIb09LQlA0dWo5bFl1eXoxUWdJQm9FMDRxdXAwV2Fa?=
 =?utf-8?B?d08ybzhCdENoZytXUXVWMnZzV0Q5S1RQclo2Mlg2a1FjYzhnN0oyRWtWQ0Jj?=
 =?utf-8?B?VmloRDJiQnFPdDdseEhucU03Rm0rYWhrTWRuRGlZRlJzVWlSV1IwRnpyVnVu?=
 =?utf-8?B?QitpdTd0NW9xME5jYkRkdkt1a2pzRlRsc0cvOTN3L0NZODByT3U2bnpka29R?=
 =?utf-8?B?dTdDeWVUU1RrYTByYk9Ob1I2cTFGQ3RTQ0xDcC9pUklNRlBFUnpjT01TY0d3?=
 =?utf-8?B?VE5OZ2xwMjlUVFFhbXpzWnZ0Y3FmSlpobFAwY3o4ZHBucXg1TUNUM1NvMHln?=
 =?utf-8?B?K3RPOEtTM05rQk9ibzlKQTEwVDhjT1VrM09PZEtrZkcxUWlGNHFDZDZtZHVx?=
 =?utf-8?B?YUxjV2pybzMra2pUcjZFK1ZmQnVINjBxaThDc2gwRlZxZmtRSTZoR0JnbVF2?=
 =?utf-8?B?RnRpK1NRLzZDbTd0dUlsb243VjdleHhFNHBNVE1xRUFWNjhqdGhpL0R3djdC?=
 =?utf-8?B?WDNpUkUxbVEvSTBEeEtkbTk0S2hMd3lvaDVGMUdST2FYNDZPZ2hhTFVTLzdH?=
 =?utf-8?B?WTkyNElVUjhDVkFvaTRXNVoyK1JRU3FhNG1sOUNIVjF1OTAyVEFxNDBhS3l2?=
 =?utf-8?B?enFBbDdJUmpKR1VwbHNLeVIvbFhvTmdLajc3dlNnR2Z1ejc0Qms5a2JxSWU1?=
 =?utf-8?B?WXNyb2hHRFFkdTdqWDR6d0hQbW40RVRINlBXNmQ5ajhsdDlPTE14SzlnRTl4?=
 =?utf-8?B?amZzMis0Mm9rT2tiV0hxUzhEN21nUzIxb2k4SllVejNLc1h0Z0JnSzNQamFS?=
 =?utf-8?B?SzV3c0t5UkZyNjNVenZ1NkVubXYyNXArb1ZKSHZxT0ZOVkFxWVJoSW9NWFE0?=
 =?utf-8?B?a2V4UWR1UzZGNlJCOWMrekhHaVFyd0E5RUQyNWYxaXVEK3drbXlmTXJkUmtu?=
 =?utf-8?B?Y2hYME5aQ0oxSmtRZU13bW14MDViamp4TUtTMmVhbFJDWC9pM2paWFpzaTA0?=
 =?utf-8?B?Uk43U3JBKzdWTHpQN2xXbmZ2UzVnaDZSREFNU3d0T0JVb2J0RTUvVDdyTkhY?=
 =?utf-8?B?dGRFSnVxY1VydHU1K2RUQlRtd0N4WW83WEFZK2JRdnI5ZFNLdWRUUGQ3RWho?=
 =?utf-8?B?K29ZeFF6T2pUL3NuTnNySU5RQmlGaktHOWk4MWVydnZlckVNaDFwcGZRT3RZ?=
 =?utf-8?B?NThDYlVpbjdhTS9zdzg1aTdTQVY0bTI3TjN4dm5DcHYwL1E3aWZuRmlrQ2dE?=
 =?utf-8?B?c3VYd1pUVFY4Q1QzcHQ2MWp6QTMxRkZFcEpWWEpyWDdrYzI0b25GZnBDejdK?=
 =?utf-8?B?RFNGbEZBeGJCWGJ1Vko0TVJITFF3WEdqQ1ptOU1PcXFJNGpPNU12TVdUN3ZX?=
 =?utf-8?B?VWZOcGRMYTBSUzByZUxqbkdyQjk1SWU5Wnp2aXg4Y2ZwQXVxcDNOdkQ1SDN5?=
 =?utf-8?B?Y3J2OEdyb0lsQk9sc0M1YVo2Z2t0YWlWb1J2WjVVZ1FDa1FmUWRYaDBWOSsv?=
 =?utf-8?B?WGFNcHByZTF5YW4zanh5Tkd5aWgvUndnbzNYVWdXZnZRZldUUExzbGl0T0xK?=
 =?utf-8?B?TmlGSTYyYURjck1ZTFppYmZ0dmZ3cU1ublluSGc2Nm8xMWFHSlc3WWQrQ0t3?=
 =?utf-8?B?S2kzRjdxRzliRzVVditEQjk2WDZtNk9HTURtRlFWK3VMSTZiWk16THhkeS8y?=
 =?utf-8?B?ZWNNN3MwRUpOV0FtZDVyOXd2Tkd3dmEyMnI4MHRzYWJwaU4rdkRhUlVzQWEx?=
 =?utf-8?B?L0pMMFFsREExUDJHclNLdmQ1aUJxT3ZjVUkvVkpQWTJNT2ZyejlLWU5KOWd6?=
 =?utf-8?B?RGlsYng2ZXQ5WFlyeCtyTzlyME4wV2N2TmZjUFJ5RkNnekphQ0pEamZjeGVQ?=
 =?utf-8?B?Wml4UGVEaVNleE9kQ0pGRGlIcGVmK0dTbmlkdFRsbW1MZGhRNXBZLzNJRFlF?=
 =?utf-8?B?NWJ5OU5reVdCZ0ZRU2pFWi9YZFFZNW9wVWhoVUZMM0RHZXdLemVHQmpmOXA2?=
 =?utf-8?B?YVhDYlE1MkVLQTJScEo5UmJUdEZ0SlZGc3p4TUlicjBuMmxHWEJiWVJJMEo2?=
 =?utf-8?B?YWNLTWZpOW5ONTBWNjVudWtiOXdUZ3JNOTQ5MHVYcUxRZEV4em54Zz09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/5G705XPNWQ2BMIFmjumrJlK68d7dAyvZrqdUGFPsdNrtkKLU2+kUpgbly6wEpSyPwoW9tjFRq21OwB24CIi8USR4P4DDnZbt4zvIc7+ANLRkT2r1VH2R8O61WisEF0DNLfHZp9oPw9Y+7rR/Splq5FjZDsoJLBUUIhtubFSo7mZmHSLI2qI1q4tH7hVuf5Z5otiUpFsH+d+AnRJSc62akX6LoNdKVX/LhjyO07ooD4ZL0orq1nuCCEPOxDDG5pwtGAOWve5x2xPbekS8UvKrnyF4B0GRoSzYpx8XnFMqO27+EL5bCHDzxwg9byaohShPe4euTLgAEga/tz3O2z6w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynJigstPn3vD9KGA3kAUiAUE1uhLkpe/n9Dj1CFcIOs=;
 b=ysaeKN9A6nOsKL02a3GuqztwFVvablCq3jxHxOAOVcObrxgQr1GtbLaLEwAoWQQl5i/qJEqZ8O+SxH3MDr052/dU5dv3UR499swGuPVxD6IApyhmph6TrmO12kq9eXu68SWEsbZHNuWPL/z2x+an0m+EDwew2UmSnlmr668EBroZeob3jX9DcVPsPJr8JSGvhHB14gcY0xCemixDnE+2BxUWvJ1AIsPQrhRb1OzmQvYHhTh6fq0kmbrgw4DwlcxYEZoeZy/kjydmr/k3R9j+DiXbom8G2tOZXAK+FddqwWn5ivKAO+YY5q0vidSZhvT3XEbAsm/FqBR6rkeGZqI0hw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: lx4TzIoeywslWZE91XWuc+tgzqhj5OhbzcRii/0pEDOh3yZm4sATj9YDge0S29f1FiRG0fqs0wy2vdk0pAhIiDvsvxbgHJ3hAl6rJpF8yXmuLMQUqYIsH3ipN1V9xZvDDFGyKm9AEcJ+8yHFb42ezTdEL2zMPo/nogwXmLQ8UgBxoyzS63xwbeqCif3FJp294U4CSu8D7rPLfoyQ18UXLoLNg6OzEI/MypJrIYoJorzhNHv0yTed0D5mPl+2zUJQTnpdVrMzf/71hwCYxC6yxA61v+CECQFsgsK859dGWx5VstgeW4wANndBekobGhH/Fd1tSGOc3weO4Z5ySSofbg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH2PR17MB3797.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f77b1e4a-5b66-499e-5e32-08de84f21ca4
x-ms-exchange-crosstenant-originalarrivaltime: 18 Mar 2026 13:27:33.0220 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: MpxTrpHR91eigXqiIjsc4V2SWsipaCRRENQBe/zkJJ5WaP0beWvHW1LiFQqFiCyrq5KeFxUw/zySRk/57gCmsw==
x-ms-exchange-transport-crosstenantheadersstamped: DS4PR17MB7880
Content-Type: multipart/signed;
	boundary="Apple-Mail=_863A8661-2090-4949-AF2D-477FBBAC09FA";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180113
X-Proofpoint-ORIG-GUID: 6JhQ_67nv33cPHRHln-74pbEaHMxcC9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfXxIaGa+hLoecr
 45JF2QAuO38ksAUXDe8UI40hfU+it8BRT8DDlvlR/IjubnJK7s4l63KsQbhz/h5x+com9AMXn9j
 wFgjPOIh/LQYNz6NEQkqkcBkh91vQ59bChA0O7ZHkP6wUwREnbE6OeFf1VRXt+H6ZJ4IblCUdlp
 SAGJ8SLE1Qmd4gzSrrW0h2qaIYt84n/S8iRW98zykiXTOvK2ehsVCPr5l1abJdzddHI8mE7XRop
 twjzTsjH3v0PL3MwECSwVdUDdjqXnoOVSjRSxCaIEifmHbhY3GKxFYPJRKT0pYClO3em5YKMXHf
 BJJR2qmDOmGbe//8g4vZzqCqYpd4q1VnoNErzddoK+tiyt9oPes+yp//66qkDByvGPxOllIT0XU
 pv8w48m82/F7liv0dIfV7F6qyVt88AN4+4uFpA4o12aN/W83RTsmF4ZcdpdrBoWx8EHSGlytVLW
 d4fgDPbPrWpK53uZ6aw==
X-Proofpoint-GUID: 6JhQ_67nv33cPHRHln-74pbEaHMxcC9R
X-Authority-Analysis: v=2.4 cv=DeQnbPtW c=1 sm=1 tr=0 ts=69baa851 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=TTBIr9FR-UdC54aaq7Eb:22
 a=Qm8iP6mkAAAA:8 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8 a=dWpWz7zGFzcUla2OvKAA:9
 a=QEXdDO2ut3YA:10 a=9EZRCfYBL5QmIGs5UOYA:9 a=ZVk8-NSrHBgA:10
 a=30ssDGKg3p0A:10 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603130000
 definitions=main-2603180114
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mboone@akamai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	RCVD_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:email,akamai.com:mid,proxmox.com:url]
X-Rspamd-Queue-Id: 9E7672BC1AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_863A8661-2090-4949-AF2D-477FBBAC09FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 18, 2026, at 2:08=E2=80=AFPM, Max Boone <mboone@akamai.com> =
wrote:
>>=20
>> Yikes, really? :) This is from 2017, I'm a little surprised we didn't =
hit
>> this bug until now.
>>=20
>> Has something changed more recently that made it more likely to hit? =
Or is
>> it one of those 'needed people to have more RAM first' or bigger PCI =
BAR's?

Forgot to mention, but yeah, we=E2=80=99re seeing this on Blackwell =
cards which have very
large BARs, so probably seeing it first because of that. But the window =
was already
pretty small, it=E2=80=99s not a very logical thing to poll numa_maps or =
smaps walks while the
firmware of a VM is remapping the BARs of a GPU. With regards to that =
specific case
there=E2=80=99s a proxmox thread and mail from the same person =
presumably [1, 2] that mentions=20
the same bug.

[1] =
https://forum.proxmox.com/threads/walk_pgd_range-crash-pve9-1-on-6-18.1798=
95/
[2] =
https://lore.kernel.org/all/5948f3a6-8f30-4c45-9b86-2af9a6b37405@kernel.or=
g/=

--Apple-Mail=_863A8661-2090-4949-AF2D-477FBBAC09FA
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzE4MTMyNzIyWjAvBgkq
hkiG9w0BCQQxIgQgCSxnCPqmkwB1oC1XJdxUVPbQS574zvpzxBcvtBJ6EkYwDQYJKoZIhvcNAQEL
BQAEggEAt+wwQ48ibupDE27Qu0YjMZViWJ26WCDhOQdPUJhhZuKccIy49ds7RqJseM9c1uk8JycH
fYmrVOEzCqKS0rpypDnlla2Q26UVpv8f24XXMghMbpd2Nm5mlSh+RTEyFEacUMFdgDO3/zxRgw+f
efYkPMGhV1XffUJMbNiuF4i/IjFa6hE9vbOzPARAZK0aj9vqOM/YD7fbvMzGm2ec8m8/iX4zlew8
Qiq9HtiVRX1PYyf/d9/lnztLWMg0ZRy6GlyDSRhrbZ+oZjBV2qmMlA3HhFfKNlKUmypROK2bNQe6
oAMYws9Jk4BxnSu5oqEA/r47xcJ9MSAtTOMJZ9k1ji3fugAAAAAAAA==

--Apple-Mail=_863A8661-2090-4949-AF2D-477FBBAC09FA--


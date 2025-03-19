Return-Path: <stable+bounces-124896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE78A68973
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39037A5142
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610D253B50;
	Wed, 19 Mar 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MyLAby5I"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811017A311;
	Wed, 19 Mar 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379783; cv=fail; b=blPl0mfQtB81jHVixQvl8CiWbH8H0kBxoiuUCxWu5sT8KCHGiis74QAKZVRcFyfLHp/u9hF6Bz2Oiy381ueZQueyI28AtoYndnloG5hfhu3SuB8W2oq1oyPrAXfhFHIJspHSise6IdokQPjD0/bUIFT5saOCX+Qu8jOKL/0701g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379783; c=relaxed/simple;
	bh=itFmWrBZ63/ZHCSS5b0Z9q0Pph1CD/tsWM4Ulyelb1s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VEqKH6YwI+WR9Pav/bqpE8d0+kOGwSb/wVvA8l563vmSapE+aYy4ewwA35OLGszKFEzESnnkagMkfeWFStdp6bZk2My+xW8qf3lQkl2ryzf+t5pjc7LNSVMWcbLwmHoNQZbWEYAirtnw3sMWByfQthEU1/DENVW8TZV6vb6fgxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MyLAby5I; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IviVE2Y8QQxxkhnz00uTXDHCLEpBjIzcfHoSvWW++C54yJF01GteXpZL347Pg0kG0v710wJOWs9AhjWWv3qOI0b0jPCMSjWrscRHb5IrJYrua3G4falo2oYt3TCNxEb1ab11q8CsrqIZK0v0EH0hf1GiMJyC39rSguHPP43uy9Ij3uOAWTzcwjx6J9qXgr8bjNdTtgfaZCY6Y7LPrG0t4hB2IqVJUzxeS5tRMu4k8l3bKgZXPOlqqOIYM7fepaaGWjn8Bck0ZnmpAtV1Yrj2aMRb2bApaxyLUVgyD9w3PndWPeOD6IHu2HEEwCszP/NpOXAxmOx1M5fxHBekXxQ9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itFmWrBZ63/ZHCSS5b0Z9q0Pph1CD/tsWM4Ulyelb1s=;
 b=FuMhhvNqZJ/gmqXT8lzmVYkH4+WTlPFGokV9BL53l5b+rwtsTbv7ChBVR2Hy5plZpWtVad7mWyhqGY2KoKywCE1fQlMO+DU0iFWrlB+Msmfp0hXtE1YzguM9NW4PYoU/GqJSr05uKy+ySw/Htq6KkBrR1yC8sDGdZQ3GtfJQKQHEwEwzceEs31AQ+Gq4y0fU/eDFZMLeUCID/ERTBkX60fup1rr2DuyTl0yYHV7Q5p+vFaE6qqqc/47a/A0A2rBdY3IGAitYfDg4QqHvvRi+Zhv0lFQbj/mKuDVXqvpZ/nDRW1OnmUGb9XuLUjFbo1zPgpGPRem0+Or1EPBlUgDy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itFmWrBZ63/ZHCSS5b0Z9q0Pph1CD/tsWM4Ulyelb1s=;
 b=MyLAby5Ic8s9izcvOEd3v8fzaETIkVW4rnllBUgNlWrUrIQnLMYhT2UKcWTIurLLeGdUeX5ubtVKlV/qbrW6i0CREmjlMZBVlQv7h5032K396oRf1Rhp3/sD1E2qrePMg6GkeKxk86opObr6fkqLunDZJ9SceFX0RLNzBx6lNOAfypAlmXxtAaAeDfC3bYMZriB1KJxjGEPY2BCDhPg8qr6TCk6GUWp7jNdBPQs6HUI1Gt5DuHWxC0QElcjnb+QGq9EuzbZ3Q8jIBeP02iuVRccHAoepRkUGOG+EcbQ0eXIopq3D7A+tNafSSp131HY26j4uWZLERDKQ1J43l571gw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB3565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:22:57 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:22:57 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "jm@ti.com" <jm@ti.com>,
	"josua@solid-run.com" <josua@solid-run.com>
CC: "rabeeh@solid-run.com" <rabeeh@solid-run.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jon@solid-run.com" <jon@solid-run.com>
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Topic: [PATCH v2] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Thread-Index: AQHbmLjihaETI62MZU2zGRTv5Js1gQ==
Date: Wed, 19 Mar 2025 10:22:57 +0000
Message-ID: <5c6e447ad9633f969cad7ed6641c8f6cfcc51237.camel@siemens.com>
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
	 <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
In-Reply-To: <93d7e958-be62-45b3-ba8f-d3e4cf2839bf@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB3565:EE_
x-ms-office365-filtering-correlation-id: f824a0c1-86ef-4afe-83c2-08dd66d004c6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFQ3SmdvU0I5dkFLUTZycXllaExWazhveDV4SW9LNmRTN0FYSjFjQlVlMDc2?=
 =?utf-8?B?S05uMUtiOWdXZG5OQ1dZaU1WUnpvWk9GZlF1YVdHRlkyZlFFN1dCRk1kR0p4?=
 =?utf-8?B?SlJCOG03VXhvRW1nREZZcVhYZkNGdERyaC9PdndaNGlXZjBiWStyNzBpemM0?=
 =?utf-8?B?bStIS3EzUkZvTWxKeGdtMVF0QXVCNXRZdnFpcmxaeEcrWXZxWTVTa3lLMXpZ?=
 =?utf-8?B?b3RWTThad2J6RzhnZm01cmJXaVZKVXZOZStOVGNSQnlmaDhaS3gwZkZrYWZN?=
 =?utf-8?B?TGNxcWtWdUErcUtqY0ZVemNNSjFjN25yWG9kT1QrSm4vUXJrOW5wbjlkcUla?=
 =?utf-8?B?Nk1vVFUwSkhXZTVmenFCY2lmbTZpWGl4WmtkakZqV0M0UUxMamVzckNYbnVS?=
 =?utf-8?B?ZU5FNVF4U3k4NTZJcS9KSnV1UFg0bkhsejl1VmEyQ1MvUHNTWGJUS0JNR3Q5?=
 =?utf-8?B?cGQ2WXF0TDEwN1hMditzVEJOZXk2Y1o5TTcwTnF5SS8xMHJUS3FHL3FxSS83?=
 =?utf-8?B?NmpVcEY3NDRKaVRRemM5SjlraUVMeHJ2TElIaXBKRlBkQ2pGTWovakc0SEgy?=
 =?utf-8?B?UStHaDVWbDN3aHpQeGIyZVJ5bGhXMmYzSEhrMVl5WHNRR2RuaXRzM2J5TTJy?=
 =?utf-8?B?NktJMlQ2bHpuemNRSmU4SW81RThzcXR3QnQvbVFQU21uWTkrZEZaYXFsOFJm?=
 =?utf-8?B?N3BUUUJYOHByQnlUY0J5aVQyVWxka1lGWEVxSVJhUEZiQjhYTHZuK2NJWHVu?=
 =?utf-8?B?VmYrYUxqOExUQ3BkUUYxN3lyUnh1YW5KTmdqVDc1UHUzR2Y1clhQbExhOXMw?=
 =?utf-8?B?aW5xU2lGVmxlY1k2RUk4UW1GWlg3R0tzbW4yUXBuM2RtSmI5bjB5ZHFrTk9y?=
 =?utf-8?B?aEJlZk9RYUcxSk9ta3VYWE5mZFk1Z09pU0RwSXdXOWxaSEpGZnc4VUxpbUF2?=
 =?utf-8?B?K0RNOStUQmpvSTJ4Q1kwMUxFTFU1dzlxdGxXdDdWcGQ3NkVnREVQYVlxZXJV?=
 =?utf-8?B?bVFRZ1J4MVd3K0JXQWhDWmFnNzVTTUhBTGZFTzdwUUFoMXFqWG5iOElhTDF5?=
 =?utf-8?B?ekh1VU1SY01SNktiSmhvKzg0c2liZ01mMlpFS0NsSDFFZ1NYTU1jaS9Kd3d3?=
 =?utf-8?B?ajNKQ3lubWRKZ2Ivd3RBTHNxaXY0d3loQisyL1NXdk4wMXdlcXpmczdWbkZJ?=
 =?utf-8?B?YU15RnBGbE92RTdETDIyU3ovbHNwcXhNaUdIaWVSTk9GSTg5OEQzRlJoL0Ja?=
 =?utf-8?B?ajZRSnZacFJoa29nZHF6UDBkN0NhSVRyOFJsT0Zxc2o3cFZ5TWZTZG1NVWZq?=
 =?utf-8?B?ZUJvQVRXcjNpWDZRbmgyUEc4Rk1qRHY1NzZRNy9BTWQ4cnZiQ0NTdHZMbGxy?=
 =?utf-8?B?a29aN0tOWUFOOHNFc3RJMXpwamVTdGhUek93R2xnVFZ6L09VVXRvcXZscVh4?=
 =?utf-8?B?LzF5RWcrZloxNU0vbENhckF2blVwcUZFT3E3VmcvRGJNcmVHb1RPeEc1bkdD?=
 =?utf-8?B?Mm13VHhMSFFVTmpIYWYyUnZFNVJnbTN1b09udG9SOC8zWGl5UmxoTkt6VVl2?=
 =?utf-8?B?UnR5MHhuaGU5UmdiQ0RQd3dXbHVBUDJvS0JVbk9uelU0c3A0QytDQ1lFN1Z0?=
 =?utf-8?B?UUF6OUdJOFpPcEZQTVdRSDlXaFRUdWVqTWV4SVEwQkFHMWJhamxodzBzRzlh?=
 =?utf-8?B?TFlvRVhyQnc4Q05yRkp1VzMxZE5QaS9aUFRwRE1kTFczMEIxZUx1MW5NMGRK?=
 =?utf-8?B?NUhGVjVlVHVuZ0ZmV1B2SzgzNWhNT1hhTVVHc3ZvZjdKWjJRTUJDNEkwTjFX?=
 =?utf-8?B?VFRYcmZROWllNXlObGRORTVIMlFuanBHSXY3eDJJTXlRMzBVQmdpbVpOMnBW?=
 =?utf-8?B?OEdtYWxFenBHQnVTUXlZNldBYyt5R01HNkxqMkVUUXp6NVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXdienNvTHJaanNCNlFIMGJpSUVSdnU5aFpDbE5IL2YwVG9nblpDOEpvTXM3?=
 =?utf-8?B?RU94VER3T1BwemRUYUdqUHdVMG1OLzRaTFFJOHFHNVhEenlMMnNjQnNkK1E5?=
 =?utf-8?B?dzBPcHFibVJDVGNWbFZFYmd5WGxOSXlLeG0yWmE5VTdCeGVSNjlXUGY5UzVn?=
 =?utf-8?B?MGRxZllrM3ZiOHNFREFDQ3RFekh3TWIxSDFiVENQc2tMZGtubUFraEFCdDhR?=
 =?utf-8?B?VDM0ZVJ6WWhmZDdGM0pxVzBLOTQ0UlhoK3NyTWUrN2h6Mnd0Vm1jdy8yOG5p?=
 =?utf-8?B?Y0djcmJDYmhOd0hMRWZZRXpySU1zQjIzVzhHSkEwUVRzWEhMU3hYUzZhUWkr?=
 =?utf-8?B?bHpFU2xrYVpkdDZHSGE4OFNvUlBNMTFyYXlIaTRoVUd2aVUzM21FODdtNllT?=
 =?utf-8?B?NEduN1ZYVWhWbU96bEF0WHBkL1ZDL01RWDY4TXJDREFObHkyaFVGa0xzN0Ir?=
 =?utf-8?B?dDdiV3BQbVI1OW9xNm45UHJmS1A2V2RhVE9TRllCUitJeFRVcHc5cXdzclVQ?=
 =?utf-8?B?bk5WMHNGbjE1MUdITzIxM0FFcUhETVdoRlAvU214N0tRcGVwWjVyR3FsQ3ZK?=
 =?utf-8?B?UEc5SEJwcVIvbDdVYzB2RzFRSlg0TFdJMmhjcWE3WVhCcWF4ajQyZU8yRk83?=
 =?utf-8?B?QmpaeTdjTDZNM2luT1lQamtOWlVWNVBKQzJvcUhpQzA1UGhycm9UNFNPOU1w?=
 =?utf-8?B?Ulk0Y2l4a3plN3dQZHNiOTVGVmEvbGU5UTlzci9HbUplRXBxMG9PRlZEVUJ2?=
 =?utf-8?B?KzhkaHl1dWFNRlNPQ3cxQmErV0pBOXJJZDVYK2NtMVgxM3B6ZXdkYTg0OWQ4?=
 =?utf-8?B?N0JQWjlhdkxOSzdBeGdORHBkckZ2OFkvbUlQYWZnc2RQSG1UaEViTWxKeG1q?=
 =?utf-8?B?WTRjcmEvcC83K0VlUG5YblJnc0xML1UxdDVoQkhmSlphR2tWcGVTMDBmMFdh?=
 =?utf-8?B?MzNHa3NPVXNRbG9mbGlTOGY5dkxDODRqd2lTM0NwMmRhTHJhOEwyVU9QTEpT?=
 =?utf-8?B?SkF4Ny9lZlp1WUhhVlJ5VVF2bHo1eG1zQVFkN2pmR2l1MW5razJKblFpVnFa?=
 =?utf-8?B?bW9rM1NGcElsK1Z4dlpSellqN1o4MGdwMjMrTVAwUEUrYlFjTE1xUUpNQnZH?=
 =?utf-8?B?MitXM1FDdVl0L1RyUzg0azlhU3NjUTRqMUNlQzNHaTRvT3FFZUR5VjhMMGY1?=
 =?utf-8?B?MUNSMy9JZ3JrMDNpRkNIOUFBOE1qRUdXMkh3T3FlWWVubWFjMWxTQ2l0TFJk?=
 =?utf-8?B?ZG82Rm90VHg3K2lEeXNhTmlseS9LZ2llVWVrM1l0anBPMGI0ZTZZYS9sbk9W?=
 =?utf-8?B?RFBwNnZkRzh3OHZDSis1M1dFcUdsSlF6MWRUNC8xVDRobkRDU3FPTjBxblBi?=
 =?utf-8?B?dUsxd01GcXF1dyt5dVRpOUMxamVvSDNicWg1N3Z6Znorb2FKOWd1a1BqeHZw?=
 =?utf-8?B?dG11alRoOTRBSWdabXB6VjdDSlMrYjU1YlN0Ri84aGdERTBMcEtITTlyMGlH?=
 =?utf-8?B?alJrRjZCb29kdXZ4dTNGMkhBdStZR3pYRHIxVlZ3VU1UbWwxMjFNUWF6RmNR?=
 =?utf-8?B?MnlzdWRvWDlYRWxJN1BNQlNoZjQwTjZ6cGFiSTZNd04zYmVpL0l5TnRrcitV?=
 =?utf-8?B?STNHUGpKeldLSk91cW1Bb3dXMkYraTlsSTlVd1pzQ1RqdFFNWVhhREw2OHlk?=
 =?utf-8?B?SURSR1lLa3VoOER3KzdLMlBoRWhXNGMySmdiOFFxcGZiRDNMKzBkUzdYazFW?=
 =?utf-8?B?cHhxOStXRkkyZ2xFS3VJellrNkEyTG8zOWZwaERHcEYrUy9HR0E4OUtOTm5l?=
 =?utf-8?B?cXovTmVpRENiTC8rTURWdWNCcU55Q1pMOGtzNFlhRXhidlZFeWxjMmxXV0Ix?=
 =?utf-8?B?K0UwR2NGSmd6WjByb0xVM0ZIYmlicnhjV21VanVkVlNXdGVkRklvS2NOZU42?=
 =?utf-8?B?U0FyR3NpUzJMN3k0RHlFa0lwWE84S3R2Q0IyVDB3NlFVNGlEbE1OQkdBZkty?=
 =?utf-8?B?V2Fua2xUalNWcU5kVlVReENVNTJCMGJZNzVaaHhRS1JjaStHdTNyTkUzY1VE?=
 =?utf-8?B?cE1iN0cva1pPcjdvL1JsNmxLZXZtSnpDb05IcjV6Qy95Q1VkakMvWHJGSlNJ?=
 =?utf-8?B?TUZicTF2bWZJMHlGNjU2L2pwTS8vdkJZRUhPdmxLNFJlSEx6Y3htSUpNaTZv?=
 =?utf-8?Q?239KxJ/h0AdQ5cfJ/PCGJNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6625A7482628CA4BABF697A129A799CD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f824a0c1-86ef-4afe-83c2-08dd66d004c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 10:22:57.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eum7TExnZ0vcBzMC9OxaFhilkQpP3iP+iG1lVVJOlAwrTtL6HhKM7x7rPbUVK+st9YVuwT0aw5gXoyTjFZHb12rYVkTMdj1rHhrJwmx2z4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3565

SGkgSnVkaXRoLCBVbGYsDQoNCk9uIFdlZCwgMjAyNS0wMi0wNSBhdCAxMzozOSAtMDYwMCwgSnVk
aXRoIE1lbmRleiB3cm90ZToNCj4gSGkgYWxsLA0KPiANCj4gT24gMS8yNy8yNSAyOjEyIFBNLCBK
b3N1YSBNYXllciB3cm90ZToNCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IDk0MWE3YWJkNDY2Njkx
MmI4NGFiMjA5Mzk2ZmRiNTRiMGRhZTY4NWQuDQo+ID4gDQo+ID4gVGhpcyBjb21taXQgdXNlcyBw
cmVzZW5jZSBvZiBkZXZpY2UtdHJlZSBwcm9wZXJ0aWVzIHZtbWMtc3VwcGx5IGFuZA0KPiA+IHZx
bW1jLXN1cHBseSBmb3IgZGVjaWRpbmcgd2hldGhlciB0byBlbmFibGUgYSBxdWlyayBhZmZlY3Rp
bmcgdGltaW5nIG9mDQo+ID4gY2xvY2sgYW5kIGRhdGEuDQo+ID4gVGhlIGludGVudGlvbiB3YXMg
dG8gYWRkcmVzcyBpc3N1ZXMgb2JzZXJ2ZWQgd2l0aCBlTU1DIGFuZCBTRCBvbiBBTTYyDQo+ID4g
cGxhdGZvcm1zLg0KPiA+IA0KPiA+IFRoaXMgbmV3IHF1aXJrIGlzIGhvd2V2ZXIgYWxzbyBlbmFi
bGVkIGZvciBBTTY0IGJyZWFraW5nIG1pY3JvU0QgYWNjZXNzDQo+ID4gb24gdGhlIFNvbGlkUnVu
IEhpbW1pbmdCb2FyZC1UIHdoaWNoIGlzIHN1cHBvcnRlZCBpbi10cmVlIHNpbmNlIHY2LjExLA0K
PiA+IGNhdXNpbmcgYSByZWdyZXNzaW9uLiBEdXJpbmcgYm9vdCBtaWNyb1NEIGluaXRpYWxpemF0
aW9uIG5vdyBmYWlscyB3aXRoDQo+ID4gdGhlIGVycm9yIGJlbG93Og0KPiA+IA0KPiA+IFsgICAg
Mi4wMDg1MjBdIG1tYzE6IFNESENJIGNvbnRyb2xsZXIgb24gZmEwMDAwMC5tbWMgW2ZhMDAwMDAu
bW1jXSB1c2luZyBBRE1BIDY0LWJpdA0KPiA+IFsgICAgMi4xMTUzNDhdIG1tYzE6IGVycm9yIC0x
MTAgd2hpbHN0IGluaXRpYWxpc2luZyBTRCBjYXJkDQo+ID4gDQo+ID4gVGhlIGhldXJpc3RpY3Mg
Zm9yIGVuYWJsaW5nIHRoZSBxdWlyayBhcmUgY2xlYXJseSBub3QgY29ycmVjdCBhcyB0aGV5DQo+
ID4gYnJlYWsgYXQgbGVhc3Qgb25lIGJ1dCBwb3RlbnRpYWxseSBtYW55IGV4aXN0aW5nIGJvYXJk
cy4NCj4gPiANCj4gPiBSZXZlcnQgdGhlIGNoYW5nZSBhbmQgcmVzdG9yZSBvcmlnaW5hbCBiZWhh
dmlvdXIgdW50aWwgYSBtb3JlDQo+ID4gYXBwcm9wcmlhdGUgbWV0aG9kIG9mIHNlbGVjdGluZyB0
aGUgcXVpcmsgaXMgZGVyaXZlZC4NCj4gDQo+IA0KPiBTb21laG93IEkgbWlzc2VkIHRoZXNlIGVt
YWlscywgYXBvbG9naWVzLg0KPiANCj4gVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcyBpc3N1ZSBK
b3N1YS4NCj4gDQo+IFdlIGRvIG5lZWQgdGhpcyBwYXRjaCBmb3IgYW02MnggZGV2aWNlcyBzaW5j
ZSBpdCBmaXhlcyB0aW1pbmcgaXNzdWVzDQo+IHdpdGggYSB2YXJpZXR5IG9mIFNEIGNhcmRzIG9u
IHRob3NlIGJvYXJkcywgYnV0IGlmIHRoZXJlIGlzIGENCj4gcmVncmVzc2lvbiwgdG9vIGJhZCwg
cGF0Y2ggaGFkIHRvIGJlIHJldmVydGVkLg0KPiANCj4gSSB3aWxsIGxvb2sgYWdhaW4gaW50byBo
b3cgdG8gaW1wbGVtZW50IHRoaXMgcXVpcmssIEkgdGhpbmsgdXNpbmcgdGhlDQo+IHZvbHRhZ2Ug
cmVndWxhdG9yIG5vZGVzIHRvIGRpc2NvdmVyIGlmIHdlIG5lZWQgdGhpcyBxdWlyayBtaWdodCBu
b3QgaGF2ZQ0KPiBiZWVuIGEgZ29vZCBpZGVhLCBiYXNlZCBvbiB5b3VyIGV4cGxhbmF0aW9uLiBJ
IGJlbGlldmUgSSBkaWQgdGVzdCB0aGUNCj4gcGF0Y2ggb24gYW02NHggU0sgYW5kIGFtNjR4IEVW
TSBib2FyZHMgYW5kIHNhdyBubyBib290IGlzc3VlIHRoZXJlLA0KPiBzbyB0aGUgaXNzdWUgc2Vl
bXMgcmVsYXRlZCB0byB0aGUgdm9sdGFnZSByZWd1bGF0b3Igbm9kZXMgZXhpc3RpbmcgaW4gRFQN
Cj4gKHRoZSBoZXVyaXN0aWNzIGZvciBlbmFibGluZyB0aGUgcXVpcmspIGFzIHlvdSBjYWxsIGl0
Lg0KPiANCj4gQWdhaW4sIHRoYW5rcyBmb3IgcmVwb3J0aW5nLCB3aWxsIGxvb2sgaW50byBmaXhp
bmcgdGhpcyBpc3N1ZSBmb3IgYW02MngNCj4gYWdhaW4gc29vbi4NCg0KZG9lcyBpdCBtZWFuLCB0
aGF0IDE0YWZlZjIzMzNhZg0KKCJhcm02NDogZHRzOiB0aTogazMtYW02Mi1tYWluOiBVcGRhdGUg
b3RhcC9pdGFwIHZhbHVlcyIpIGhhcyB0byBiZSByZXZlcnRlZA0KYXMgd2VsbCwgZm9yIHRoZSB0
aW1lIGJlaW5nPw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNp
ZW1lbnMuY29tDQo=


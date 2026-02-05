Return-Path: <stable+bounces-214523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QADjHT/ShGk45QMAu9opvQ
	(envelope-from <stable+bounces-214523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:24:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9D5F5DE3
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A160300E71D
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267EC2FD1B3;
	Thu,  5 Feb 2026 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="jDmv92jm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C221A453;
	Thu,  5 Feb 2026 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311994; cv=fail; b=G6az4zA4kvItW4DilzCOfi+m8RtOgG5eZVKW5LekHDobPIslAykmCAopfcLdmIdABPkI41JzAXJuPMBfWDt18x046ST1CNVstf6OmPA8YU+hkVDV8UMZZENQVG+RZKGBgrkFcbKJN90AfOdSuqmuLvwVS4aFoJxjn/pgyfRNcVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311994; c=relaxed/simple;
	bh=q0z4wLcUU7mEgtE5Smd3g3AdUUdbv9Nmpmkv0T+CNvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dHCaBJUG0tixgkH1w2a79jK8/a5IsnUQQ518VnpOFKnvmz7LRJmWThfPIUfmzrbA4hhPV1SYmrxXOwv44Juz5UkDmaiSaysRNhzuiISSjhBX6hZQv97w8Wcr6VR7bmEsud3UEXeMyN6/LPM1MpYzjnH/Hc67Odm37JjAJ/E8EZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=jDmv92jm; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615GatIa1410069;
	Thu, 5 Feb 2026 17:19:35 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazon11012043.outbound.protection.outlook.com [40.107.149.43])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4c1b3h45ym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 17:19:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwaNMhLTByxPP9eOBr7o3+NNPsBOlB0Cu1Et0fx+/w1O4dNAioIIJR5SmeuLsjc8x4whjFXdIP2Y9pYtzb/oqvrOVmk+OrTLs2dJC9MdoU8wst8v9gANKrzf9deVL9GbsCBJ+6yMVf2D4RegpZvJxveA1tli0/phQ1WdSoT7l7dDJtmGqnxGsn3f9/YUSXxI3EBNPfl70KNLNQpfKpk0aIE/K+9pbllNysfoNzdVMWydORABFJtgHbNSgQCaqtri7SphcxmFAQ8sAnnPXjcZqO5hwsyQhcAVJbqCu3NdEdCnA3L65OqPBIiCId+9F7mvbrnFz/iE1gKH0IQqxHKrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0z4wLcUU7mEgtE5Smd3g3AdUUdbv9Nmpmkv0T+CNvs=;
 b=kQ0fgBAdHL+KfIWJHQ+jCaGG4cxNHiRpBTFN3lCRKHtm8JP39+XmDL5xdHmhysapeJlyUJUoht65d8tWbYOEAlnzZWYPim43WFw9XBCOcNQMEKDbQQnhC9140vr11GJifNmR2BN7TlvNa6ttE9D0qSvlZ1ARJJb+bwpK9w4NWi41NULk1yAseAVIF6banH9iclNSLieiAdM/TwgrqrNQg9JZZKCmaweJY2Bmtv4FiETDytayd4GRKSV/juTu/VlJwNszgP6UPx9Xrx8DeBLtZvGqaODqhXht8kKSYn3QjQYF6Bx2EpGBe+GQT5Idm9ga2XH81q2TjrVHijTJjElgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0z4wLcUU7mEgtE5Smd3g3AdUUdbv9Nmpmkv0T+CNvs=;
 b=jDmv92jmAxOlO/sbZVk1EO3xVmoHXeR6+4nsUJmEgs3nRSG7A/JyNcqHZJjUZPZt7y8dgMlbM05gtWdBWxMSL10Utc7m+z9k6uhPWZaoqaNKTsJnhKt305vgFsywuUCOAuRi4uiyYIEc2dEmvJ3uOJ4QoJi1hPYmPkIkw0rSdGtjMg5gt65aImBB0heOFGeFRb1yTZ/Id4MY/dThJlEibPnrPIU/fUh0NyOBQNwL6/QOq1Aj9wSwGqHeE3pkgwODTt/H9iRnEEvgsFDqTQQ+oqPC2QhMUWPYLcXAlV2CUb0odLD4e6XtbYBQuHVA3mQyXH2FFqghh+BpLgkrakL9aQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR6P281MB4490.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:12f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 17:19:29 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ab9e:1ff7:9dd1:d0d8%5]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 17:19:28 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Remi Buisson <Remi.Buisson@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Thread-Topic: [PATCH] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Thread-Index: AQHclqRajd0VwaXuq02I4Pd9CQyS/LV0SSaAgAAFAI0=
Date: Thu, 5 Feb 2026 17:19:28 +0000
Message-ID:
 <FR3P281MB1757021D0A44A69C2940FC07CE99A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com>
 <aYTDF9BNwzXmd2J8@smile.fi.intel.com>
In-Reply-To: <aYTDF9BNwzXmd2J8@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR6P281MB4490:EE_
x-ms-office365-filtering-correlation-id: 1523347f-d7fa-4a50-2180-08de64dab826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|10070799003|1800799024|376014|3613699012|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NEhiUVhtOHJKNXExcDBCb2R1U2FGRmVQbXdQSGtYRGw1OEJaekZXcHRMNy90?=
 =?utf-8?B?ZVBYczBpTXlxYTB5VHV2U0lzc3ZZek9vUStvd0cxSW1yWDlQRU9FZ3NqY2lw?=
 =?utf-8?B?eUZUa2NyVW9yZW5hQUlmN3JScCtzeC93S0ZiVy9BcE1SZE5jODlDYTNIUE5j?=
 =?utf-8?B?em5GVFVsT0FxTmd5Zi9zMnFOR0xtOGZEWUpuWW85SkI3THdlRDNmWG5LcFhW?=
 =?utf-8?B?QVZjRkZrS0hTSnphZnFlaUk1Vm9QQTRXUlNoYXZlL3hOT0h3ckNjZ1d3c2dz?=
 =?utf-8?B?cVpuTDQyNTJYSG83ZGVKSFdNUzZZZkpaNkV2amtMdkgxYW1MdTRhTngzaUh2?=
 =?utf-8?B?UkdhSGl6OElvdjUxeFZwOEUybFVNdFlwcjNWQnBtUEpLSjRZSXVUZHVncCsw?=
 =?utf-8?B?T3JHS2dhTStUTFdtTnZEb3pHRk5JTVArQk9WeGd3ZG9hckNoRitKTGQvYzUw?=
 =?utf-8?B?Q1NhRUNjbnhibWtIQ2tmNGZ4S09rTlBORkxZU1BPWUF1YUlOUkpldGY1ZkpZ?=
 =?utf-8?B?eXpFRS8wVjlVK2Vua1E4UEtWQzBhNklUc2J6UTFJT2ZYK2JxdWo1V3ZPd3Zm?=
 =?utf-8?B?WHBuUVh2QzgvdjkxeTJJeEtvY2p0V2xyUUFLQ0xCeVNnVWZ0M3k5TGNEbWh2?=
 =?utf-8?B?aURWbUxVOWt6ZlljcjNjWmZUUkNCSXI1ay93LzAza21iQkIvdFJGbnRRbGg5?=
 =?utf-8?B?c25QVTJoRUI1ZmNUVTBlUmNsdzJWbXBpd2dRZjJYV29EOUptMGVoQmNseHdP?=
 =?utf-8?B?anYvZmtqR0t3UzJyaVlhc0wxN3AyZGp4dVF2L2d2VmtaNFJrUnpEaWZvUVVV?=
 =?utf-8?B?b3VlL2o1cGY2Z1RzdGxUdnRaT1U0N0g4R3hJM1JGQzl6ZlpVN0FaQVVtUStI?=
 =?utf-8?B?c3BaQm9RQWxNM2dGYk1tcFAxWmhWNTZZTzZUc05TNGliL3ZnN0VRSE81MzV6?=
 =?utf-8?B?NGtCNHJSdllZaElqQTMrN1BmNEVVa3Zua2RJdXFVVWhyNnduVm5RS3diTHZy?=
 =?utf-8?B?cjNveC9BYWZqSEZjWGxuOTNYQkJGczRIUUN4RHJ1SjFSY21LcGlmVCtmSjdM?=
 =?utf-8?B?RW1aVmZUWUJka2lzQnlCL25URXA5VnRtcFMwRWwwamdUSTNhLzlvKytlaUJU?=
 =?utf-8?B?ekFCOXVIaCtMUEtwanE0RG1YZWQwTGsxc0I5ZmJ2c3NtLzNMZkVnVjlQTVpj?=
 =?utf-8?B?VnJ4SWxXaE05TkdwcWs5OVB0aDlScG12TjljckRGYncwWWhtYjJCelNMTW5t?=
 =?utf-8?B?ZEEzdmY3eXdzZWpRTTJIZGxsMHltWDFseUJ1ZDlBWmpjSktmMWJxNWVVQ1dr?=
 =?utf-8?B?NUo4aGJScXJPR3d1VEFqaXZYTUozYTh4M3IwNGp5ekRwMHJ4cW5UTmc3MU9C?=
 =?utf-8?B?TUZFbjlJYS9CSjBXeVExTVlDZTUxb2pkUS8zdmFKNWlTMnIwVTZhM1BLWnJR?=
 =?utf-8?B?Y05xWGRGbDhsSE50Q0s4UHd0dDFNU3VXR3dUSzhJR2RUQWhLeEsxWXNTWnRv?=
 =?utf-8?B?UG5uR3VNMjFwU1RYTlc3enJjUkZuL3J6UjVLVlZRQlFlWWZOdmZuQUUwc1hp?=
 =?utf-8?B?RjI3ZW5TRExMamFJcE0vRWNOaEVMYmR5UnNLUC81aFhJTS9BekRMOFNESnR6?=
 =?utf-8?B?Q0lueFQzVkczaG54NTc5QXJyU3oxYVAvMFoxLzFCbjA0VFdXU1B4blR2RTRo?=
 =?utf-8?B?RzdzNGc5V3R0b0kyaXNibmduT1lJSGdvR004TnNua3hTYWRKSWJlUUJpaG51?=
 =?utf-8?B?cDFUYXVES2xBSnZsaHM0V2c1SEhnSUdSeXNUVjNadUdPYXVOTnhoaTlhMjl1?=
 =?utf-8?B?QS9Hd0RSZjJiYjB3TG5Yd3l6enZlK1JxVkYydGE1Ry82L0JmNElBVkxLV3N5?=
 =?utf-8?B?NHBlWTd1cVovUTZ0SjI5N0lwT3hLRklDUGc5NHlSajQ0cWhDcXdneFhKS2xG?=
 =?utf-8?B?R0piWWFxSnYwZEtSYnRiMXUxUTlQM0FNV0Rpcmthb0dOSUtCZzNZYlVIdnNX?=
 =?utf-8?B?YW15cCtzOHZwTGJYaW9PR2JNd3l1ODN2SnB6cm9PQmpuQnhDVUZNdzlxUXlq?=
 =?utf-8?B?M3lmOFFGR1ZIV3VYbFNCS0xQSXhiYlZHVUJwRlgrNEZMTGxvWUloUk1xSWZ6?=
 =?utf-8?B?ME0xY1ZUbnlncnFPUk53VVEvUlJuc3NWN0pDWlVYOUZ3dDJmVUg2SXdqNUxG?=
 =?utf-8?Q?ds12gXOkKa1u1dNn1MPfqKh5UFNHHL2gZBrxN5sAJeXZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(1800799024)(376014)(3613699012)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEQzZStKMTRBOU1hRWM3MEFBc0p0NTR3OHZCaFVjcWU3Mk1zNVZqVGd6UHVS?=
 =?utf-8?B?amNZWVpaMCt1c2VWS1NJalNUWDNVckMzMS92YzNsTG16dmpMZlZOd3d2QTdF?=
 =?utf-8?B?eStPT1FjUDl6cGF4eklaN2ZwOVQrWXMxS3cxTWN2cjU1OU1JZlk4eHJaTjFz?=
 =?utf-8?B?WnBycGRYL1hDbWtlSHhzS3RjSXF4S3BBbkpKR0pyakRvUjFMMEtNU1MyK3hS?=
 =?utf-8?B?TzRlYTJ5WUppdWFXWHNNZkE0YXJwbnJjd2MvRmg3NTROMkZDT1Uvb2NUM3Rj?=
 =?utf-8?B?d25raVA0NnpHUDY3ZCtJUkdUTTB6WUptd3JXRDdBWXUrbnZSM2c1UlV1bWZh?=
 =?utf-8?B?aDVkbjVwTUNLaFFhaDFodGZTbThkTXhYcUtvbDRpZ2FHcVVubWRLMjY0SjFC?=
 =?utf-8?B?NlpSNElKeUNQVnpJYXdCZEtwdURYTlVwQ3N6WjcyenBQTVNzdDZhdVpuT3RJ?=
 =?utf-8?B?R08wWjR1S1RWMlBjZFA5VkphWm11cG9oOWZPUk9kMncvRUdKbUx6T01mQURG?=
 =?utf-8?B?cXZ3WkFtR0djUEJueng2TE5uREdmSjVMdmNJczI4NmRsRm5VdkR3SGRkTW1w?=
 =?utf-8?B?RDM1NzR4SU5LcXJKeExFQUYxeko4YVVrdUVzRzEwcG5ZQm5uN2YxMUtvaHNV?=
 =?utf-8?B?VXJzYnlrU0UvZktDM1RxcHZGUlJma0ZQY2h1TGRQYy9LY3lvcUpFelVVcUNv?=
 =?utf-8?B?QWJKYWFDL3d3Rm14a1JYYzNOUTNpWXlrN3VqWm1BR2FJZjVCcWVkUFpIaUN5?=
 =?utf-8?B?bjVwc25RaTZCdlZrZWY3QStvR2IrSW9JOWt6VlhQYk5WMGszeUgxT1psaGlV?=
 =?utf-8?B?U2llcmc2dWxoY1lNYlN1MFJvVmF2d0lTUjVkbkFrTjBrWE82RkZoN0dLMk1N?=
 =?utf-8?B?RW81QURDN1RYU0RDdStIRS9PazlKTVpmcTNUQU1MZTBBYlQycVlhM3hscStr?=
 =?utf-8?B?dWdCc2l2ejF4d3EzZmozeUVWcFdQT0hDeHhYb2tjV0xRT282NWZaYU1jNDlY?=
 =?utf-8?B?S0JEeHdtcy9FTDBIbVpRdnlSd2ZFZitUd29GS0hBY0lsclcyUTB3dEZ3djJW?=
 =?utf-8?B?emNyblpUdVNOaTU0N0pXRmp2TDRvMXl3b24yNDM1elZTdFVaZDBIaldPVVF1?=
 =?utf-8?B?NU9BVHFuYzBUZjdLYXMwOVJpZCsvOEpyVUdIZXFKWUN5bXlObnVDYzAyRjZ0?=
 =?utf-8?B?Z3V0VHpEOEZPZVdEbmkwK0RrbFZhejhwc1VHdDBRK3ZVL3FkWm5jY3Z3cDBv?=
 =?utf-8?B?QzU2TUdCME5YS1V4alJEZTgvWTZsNVVuWEw2YjQvNmpLb2ZhWitsTlAzbmpr?=
 =?utf-8?B?WHB1Yytnd3BzL21DTk1RbG0yWnh6MDkxaEM5dzh6Z0dteW1wRzRXQnZpZjMy?=
 =?utf-8?B?NnBMcG5SVjZKb0FydFlLMGhCRU5hYnNaTHpiLytqQ1pLeGdybGkxd3MzaUNF?=
 =?utf-8?B?SklhQy9vMGt5cTNUWGdESGx5NU9YWlByMExVc0pQMm1yUWJkR0RCeTRvYTg0?=
 =?utf-8?B?cWh2V25QOVhQMDBqM1phSjduMDdmenJ6cnkydmJKQmxPMGVqRFRaeVo2S3h1?=
 =?utf-8?B?aFBoZlkwS25nVFJnMnhPbzBzamVHa3MxclBQNndJQnVuWHlESkowQnJUT0FF?=
 =?utf-8?B?V0RZVFl3NFRucGwxSURwRTIrcDdEcUxqVVFjRDRDRWpMQkY5bGY0c2N1RGhZ?=
 =?utf-8?B?aHdUWDVwcVQ0ZHJoY0RNUytCbW93SUhUTnZIUkExMWNDZlRqSGRKSEZ0SS9L?=
 =?utf-8?B?OWFiNExaUUg3TEVYbHFBVmovdWkveEZNeVkvWW1lTlAycVFYaytEOWp2YVJh?=
 =?utf-8?B?ZWtkSjBPVTh5Q2pWQTN6ZjFhRnYvKzZiL0NXRzdEVWZYUXR4QW8xcHRpb0VN?=
 =?utf-8?B?aUt3VzRGWHhUcmQyZ25OQjVMNmlMM1d6NFFBZkpSbkNZVGhwd0JJVmc2bzVC?=
 =?utf-8?B?dGd6eE9ZUWkrcWQrMU1RaXdodjZnOHJWcWpwSGtyeW1rcitvRTA2R2x5MVZV?=
 =?utf-8?B?Vm9XVGdYSm11VEFPUjFiQTEydGpKQlFadU54OFcxZmFqWGpQL2licWZieFhs?=
 =?utf-8?B?OUdSWnBuUUczMVNJNFAxaXZiRmZkWDE5NEhtUlByQXdWSFA2NDdJcnN2Q1cx?=
 =?utf-8?B?ZVl3MVdGR29IQXBaeWsvMmh5dCtrdmtoT3RwQmlFSUlvQTA3SE54b3FHN2ta?=
 =?utf-8?B?VVlFb2NjTXlKQWk4VHBYS2J4QXlKUG1OSVVmMlczenNjYlJVMmZJd25BcXRZ?=
 =?utf-8?B?RFpoVXBUWnJVcFYyZnFoNHpVOCtXN3VIZldKL1Vub2lua1hWcFNCM0FOc3pY?=
 =?utf-8?B?Y3BEMWFyalRoQUlTTXQrVDFidDZFdXdDU2Z2Z0pwYmRsay9STXlJT1hiRTla?=
 =?utf-8?Q?MyGqrx+JXn6iJcertVgPPepxsacIUEsVN3Qbi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523347f-d7fa-4a50-2180-08de64dab826
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 17:19:28.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgNCneKG2HCR+JGo85Q7zhEkDLLPBRjOhBj5yiCb8tzvs4ENpWnMJMDqD8blmIbGotQi8VZ7sU786TkyqmmssZCWFovP2knk0Fk332o3XLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB4490
X-Authority-Analysis: v=2.4 cv=Y431cxeN c=1 sm=1 tr=0 ts=6984d127 cx=c_pps
 a=bAoKWJo6pcMwaXoz2TTY+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=i0EeH86SAAAA:8 a=iVWca9L5PgDtnhJB0mIA:9 a=QEXdDO2ut3YA:10
 a=EFfWL0t1EGez1ldKSZgj:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: osD1lNJrHDYdDQHjSpHFFAeXqi0rkXcw
X-Proofpoint-GUID: osD1lNJrHDYdDQHjSpHFFAeXqi0rkXcw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMSBTYWx0ZWRfX5jjq+QkPaJsU
 S5uO5ZlmGOjHsM7XWSztOzxAtmMPCtLQFEv8s6wkpp69v6+XeaNBHtXwxZocgf+di+/e76znS+3
 Fs97jeWGjeuPAWHj+5gCelb+RdNw5hn2D1AQdOMB/WG4s48I6gPhlkXZ2I/tu9FWz+IJwVg+MYE
 0c1E4oEOjrpZkHL2Ido0Y6LjXntSZUeYBM6KclC00tfGuq03O0dyPPit06ulw9S2/BOPx+7mqbY
 MYcnONpG/QSrXsIMb24YNB0couaxSJeeGoeA+b9Z33gzCAjfAM9qG+z/RhcgW0Qs+X6lz3YX4Ca
 PNpkJKGmrIS66wGc13r5rqbpddoLBqxMCE+2c4XA2IEKtdeEhpwXzECZyH426uadUd2Se3I/hPg
 liXQMHQl/WI7AK4wmV5FFJSrJaLu5gtVOcvddS+JzX94DmfWA2Ko9ChscHwHdJrJKtTqCoqNtoY
 U1T+cRs282xKmD57YfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050131
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[tdk.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tdk.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214523-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,huawei.com:email,tdk.com:email,tdk.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[tdk.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jean-Baptiste.Maneyrol@tdk.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC9D5F5DE3
X-Rspamd-Action: no action

PkZyb206wqBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4KPlNl
bnQ6wqBUaHVyc2RheSwgRmVicnVhcnkgNSwgMjAyNiAxNzoxOQo+VG86wqBKZWFuLUJhcHRpc3Rl
IE1hbmV5cm9sIDxKZWFuLUJhcHRpc3RlLk1hbmV5cm9sQHRkay5jb20+Cj5DYzrCoFJlbWkgQnVp
c3NvbiA8UmVtaS5CdWlzc29uQHRkay5jb20+OyBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJu
ZWwub3JnPjsgRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPjsgTnVubyBTw6Eg
PG51bm8uc2FAYW5hbG9nLmNvbT47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsg
Sm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPjsgbGludXgtaWlv
QHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBzdGFibGVA
dmdlci5rZXJuZWwub3JnIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+U3ViamVjdDrCoFJlOiBb
UEFUQ0hdIGlpbzogaW11OiBpbnZfaWNtNDU2MDA6IGZpeCByZWd1bGF0b3IgcHV0IHdhcm5pbmcg
d2hlbiBwcm9iZSBmYWlscwo+wqAKPk9uIFRodSwgRmViIDA1LCAyMDI2IGF0IDAyOuKAijM1OuKA
ijMzUE0gKzAxMDAsIEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgdmlhIEI0IFJlbGF5IHdyb3RlOiA+
IFdoZW4gdGhlIGRyaXZlciBwcm9iZSBmYWlscyB3ZSBlbmNvdW50ZXIgYSByZWd1bGF0b3IgcHV0
IHdhcm5pbmcgPiBiZWNhdXNlIHZkZGlvIHJlZ3VsYXRvciBpcyBub3Qgc3RvcHBlZCBiZWZvcmUg
cmVsZWFzZS4gVGhlIGlzc3VlID4gY29tZXMgZnJvbQo+WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0
Cj5UaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBj
YW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPsKgCj5aalFjbVFSWUZwZnB0QmFu
bmVyRW5kCj5PbiBUaHUsIEZlYiAwNSwgMjAyNiBhdCAwMjozNTozM1BNICswMTAwLCBKZWFuLUJh
cHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheSB3cm90ZToKPgo+PiBXaGVuIHRoZSBkcml2ZXIg
cHJvYmUgZmFpbHMgd2UgZW5jb3VudGVyIGEgcmVndWxhdG9yIHB1dCB3YXJuaW5nCj4+IGJlY2F1
c2UgdmRkaW8gcmVndWxhdG9yIGlzIG5vdCBzdG9wcGVkIGJlZm9yZSByZWxlYXNlLiBUaGUgaXNz
dWUKPj4gY29tZXMgZnJvbSBwbV9ydW50aW1lIG5vdCBhbHJlYWR5IHNldHVwIHdoZW4gY29yZSBw
cm9iZSBmYWlscyBhbmQKPj4gdGhlIHZkZGlvIHJlZ3VsYXRvciBkaXNhYmxlIGNhbGxiYWNrIGlz
IGNhbGxlZC4KPj4gCj4+IEZpeCB0aGUgaXNzdWUgYnkgZGVsZXRpbmcgcG1fcnVudGltZSBjaGVj
ayBpbiB0aGUgdmRkaW8gcmVndWxhdG9yCj4+IGRpc2FibGUgY2FsbGJhY2sgYW5kIGhhbmRpbmcg
b3ZlciB0aGUgdmRkaW8gZGlzYWJsZSBtYW5hZ2VtZW50IHRvCj4+IHBtX3J1bnRpbWUgYnkgZGVs
ZXRpbmcgdGhlIGRpc2FibGUgcmVtb3ZlIGFjdGlvbiBiZWZvcmUgc2V0dGluZyB1cAo+PiBwbV9y
dW50aW1lLgo+Cj4uLi4KPgo+PiArCS8qIGhhbmQgb3ZlciB2ZGRpbyBtYW5hZ2VtZW50IHRvIHBt
X3J1bnRpbWUgKi8KPj4gKwlkZXZtX3JlbW92ZV9hY3Rpb24oZGV2LCBpbnZfaWNtNDU2MDBfZGlz
YWJsZV92ZGRpb19yZWcsIHN0KTsKPgo+Rmlyc3Qgb2YgYWxsLCBub3RlICJyZW1vdmUiIHZzLiAi
cmVsZWFzZSIuIEhhdmUgeW91IHRyaWVkIHRvIHJlbW92ZSBhbmQgaW5zZXJ0Cj5tb2R1bGUgc2V2
ZXJhbCB0aW1lcz8gRG9lcyBrbWVtbGVhayBoYXBweSBhYm91dCB0aGlzPwoKSGVsbG8gQW5keSwK
CnJlbW92ZSBpcyB1c2VkIG9uIHB1cnBvc2UsIHNpbmNlIHdlIHdhbnQgdG8gYXZvaWQgZGlzYWJs
aW5nIHRoZSB2ZGRpbyByZWd1bGF0b3IKaGVyZS4KClRoZSBwcm9ibGVtIHdlIGFyZSBmYWNpbmcg
aGVyZSBpcyB0aGF0IHZkZGlvIHJlZ3VsYXRvciBkaXNhYmxlIGlzIGhhbmRsZSBieSAyCmRpZmZl
cmVudCByZXNvdXJjZSBtYW5hZ2VtZW50czogbWFudWFsbHkgd2l0aCBkZXZtXyBhbmQgd2l0aCBw
bV9ydW50aW1lLiBJdAppcyBuZWVkZWQgYmVjYXVzZSB3ZSB3YW50IHBtX3J1bnRpbWUgdG8gYmUg
YWJsZSB0byBkaXNhYmxlIHZkZGlvIHdoZW4gdGhlIGNoaXAKaXMgc3VzcGVuZGVkLiBBbmQgd2Ug
YWxzbyB3YW50IHRvIGF2b2lkIHRoZSBtYW51YWwgdmRkaW8gZGlzYWJsZSBkdXJpbmcgdGhlCmRy
aXZlciBwcm9iZSBmb3IgY29kZSBjbGFyaXR5LiBUbyBwcmV2ZW50IHZkZGlvIHJlZ3VsYXRvciB0
byBiZSBkaXNhYmxlZCAyIHRpbWVzCndoZW4gdGhlIGRyaXZlciB1bmxvYWRzLCB0aGUgbWFudWFs
IHZkZGlvIGRpc2FibGUgaGFzIGEgY2hlY2sgb24gcG1fcnVudGltZS4KQnV0IHdoZW4gdGhlcmUg
aXMgYW4gaXNzdWUgaW4gcHJvYmUgKGxpa2UgY2hpcCBub3QgcmVzcG9uZGluZyksIHRoZSB2ZGRp
bwpkaXNhYmxlIGNhbGxiYWNrIGlzIG5vdCB3b3JraW5nIGNvcnJlY3RseSBiZWNhdXNlIHBtX3J1
bnRpbWUgaGFzIG5vdCBiZWVuIHNldHVwLgoKVGhlIG1vc3QgZWFzaWVzdCB3YXkgdG8gZml4IHRo
aXMgaXMgdG8gcmVtb3ZlIHRoZSBkZXZtIHZkZGlvIGRpc2FibGUgd2hlbgpwbV9ydW50aW1lIGlz
IHNldHVwIHRvIGF2b2lkIGFueSBkb3VibGUgZnJlZSByZXNvdXJjZXMuIHBtX3J1bnRpbWUgd2ls
bCBkaXNhYmxlCnZkZGlvLCB0aHVzIHRoZXJlIGlzIG5vIHJpc2sgb2YgcmVzb3VyY2UgbGVhay4K
CkhvcGUgSSdtIGNsZWFyIGVub3VnaC4KClRoYW5rcywKSkIKCj4KPlNlY29uZCwgY2FsbGluZyBk
ZXZtXyooKSBmb3IgcmVsZWFzZSByZXNvdXJjZXMgaXMgdmVyeSBleGNlcHRpb25hbCBzaXR1YXRp
b24uCj5UaGlzIHVzdWFsbHkgbWVhbnMgdGhhdCBzb21ldGhpbmcgaXMgd3JvbmcgdG8gYmVnaW4g
d2l0aCBpbiB0aGUgcHJvYmUuCj4KPkNhbiB5b3UgZmluZCBhIGJldHRlciB3YXkgd2l0aG91dCBj
YWxsaW5nIGRldm1fKigpIGZvciByZWxlYXNpbmcgcmVzb3VyY2VzPwo+Cj4tLSAKPldpdGggQmVz
dCBSZWdhcmRzLAo+QW5keSBTaGV2Y2hlbmtvCj4=


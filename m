Return-Path: <stable+bounces-65978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B894B4AE
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 03:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CDDB23737
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 01:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973B524C;
	Thu,  8 Aug 2024 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ltPl1DBj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RSYeiQ4E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cuhLjYQO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350DD2F23;
	Thu,  8 Aug 2024 01:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081090; cv=fail; b=MyjCbKrpboOIc1MyKnMoTybFQA9/5Zs4JvwgIo6mGyox4MG9e5SCj8WsXLlyQQGrQ1jJmQtQVdlQxlWBD0DNeRlbjzpn0+dol87HDrxVbwAC9X5LwJWnGrfIKFbz2nau6Uv2EGEnZWfd/hPza3qhv/ouAanUEAA68NKaXoFs5yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081090; c=relaxed/simple;
	bh=vY1a0UwEUDlkW47d6bo8UfLYVYbnoqXDcgELYQddXN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D9HYj6sXOKTd/GIrzTYRa1sJ9TWijjScKlDtzQifMuqAw0FCq1WGACuxbullzcT4f+2vrLyAOdmijNPmY/TMZCn/eV7lEa4riq3ag/jc2234874PS66Z8npolG3CvfSOM6HETms4xNCw0SzMmlbPrx/9JQQqHrt8SZxBFTmirGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ltPl1DBj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RSYeiQ4E; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cuhLjYQO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477MmfYL008843;
	Wed, 7 Aug 2024 18:37:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=vY1a0UwEUDlkW47d6bo8UfLYVYbnoqXDcgELYQddXN4=; b=
	ltPl1DBjTXvqowGVI1+y/EUBefgbpsAir4g95GYJLhXr/J1768QVhVtaHd8vbu6x
	0qg3U8g5ogy075Qd9YFKaEzzUubslRC1oRBGibOfb/HECTsRlDiZKGnVQv2GjgDs
	MV/m09mhhyRkgiJEa5Y4i4L1hgdF+PMWphQfLxA14+5NRh7CdqvhDVh828S9/OIv
	w9DjH2teLblM2NWBuVYBhyuQOEsG7jRd+Q2Y9snM9hhSBhyOMQdk8BiAg06KuRvH
	jnSCOBysVlf2mFLftXqvXjHvDd7SoxyvgO2M1N3X2EacPYF9E8qnIiaQ6B1gK5yR
	ghTCftWXx5Tv9l8YX8ebAg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujberyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 18:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723081071; bh=vY1a0UwEUDlkW47d6bo8UfLYVYbnoqXDcgELYQddXN4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RSYeiQ4EADDtuB/1+Ded5cn6qSHOf5T8MFBgxjrzNi6bzX+CvNiAKIWu2OQ7bYtcm
	 VxbBuaBpumBXcPizEEdEOsRc/XV8gzfLeCpaBobRB6Mt7t2K8SQ2FAlhbQw5RRGHHk
	 osmfrL2KBDgTbY+gcmHvi/DYsRjHTKV58JuQMLISmPrlnfib48zJ019dhQGWVDx9Fo
	 zuTolTNhjowpHKgvKxuMmiwWcUVdnh/ifCu1GjK70kd1p62ONaUWkhJ5VvwDJKuXN/
	 cjpboJLovnTtxqlSr/e9PBVGsdfo6VywjUbwFX4/z7nuXLUYNYlVJw0gAMvIGX3JBV
	 A5/Cvu9y76KSA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 79C1A40130;
	Thu,  8 Aug 2024 01:37:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 29C12A0266;
	Thu,  8 Aug 2024 01:37:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=cuhLjYQO;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 74BF540235;
	Thu,  8 Aug 2024 01:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY2k+X6MCp6/4CCYC2TjhpqMv8RDIezDcjyqjSlWlM/oHqFQqfljpQnSl/FOtDfVyR/DY0a8bs5auKny1MpHbBB/eA8zsQ4C5GMtE52xnbOTlpBKtqXpjJ6V+wPTX8oHEjvKLS9GwIvY+rjchQWWzbz3oTWvg1N83IuUDca6yKR61rpAZMfO0HMpOLK60HsdjNbHgCqsTtFXz6YRr8Dpti0JKvvw2rrZT+PcAXB7XdUsXC8Od7gFfLUpZV9z7m0DSYkMEIj6vSesNcusSQt43BQWjUTgMU93GyWA/2H2p/4EjSId3nwX4fr4Xl1gHqWnHJlArPL5i2gMZUCl3hahjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY1a0UwEUDlkW47d6bo8UfLYVYbnoqXDcgELYQddXN4=;
 b=L9vLPukiOjc2fQt7kBYB6ic2UpgdahfC2VGn0aaKgvFXHuj4tldggKTEM6X/VgtQ3Vd5SwRpHcrvC8KnFDoTiF84+rdpE0fBmwS3htOy88XT+1fDaXRbZaQD2FN2qJRJAgD/K5RqosaQ7CRv0diXVgsffPpBxOTqdQBhnkt+F89+e3zoTpdW+73FSw/WRUkMyOZ9v2ppaRyYjoaoZw2xIKLOjXm11b6WjSHubjqtZL9fICO5mRkJPSolxU8WxJzH4rwA/v4qqy9yr5AXTg1ug+VEpjd2loOUmKbKI02J+0xLEQrPEYlj2xd+gafj7ma5c+VcaOBdup1vYDiVozQ0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY1a0UwEUDlkW47d6bo8UfLYVYbnoqXDcgELYQddXN4=;
 b=cuhLjYQOTWbET3ZoMDzEC6AMOhmals4oTGrqbC9iqYRVjgvIRfLhp1+kLErBj2Itet1EIs1bHcon+KT16Z4nzcUNlsMFEB8SKcvOXB9Hx+OxTPPeuuHd5tvgRSMBIQCytGq+OBUY5wgx2lt3Wt4sc9gagTcq8+plbbjWZOqbtfM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 01:37:47 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 01:37:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kyle Tso <kyletso@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raychi@google.com" <raychi@google.com>,
        "badhri@google.com" <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: Runtime get and put usb power_supply handle
Thread-Topic: [PATCH v3] usb: dwc3: Runtime get and put usb power_supply
 handle
Thread-Index: AQHa5krbJOjr5sXVeUWyTPcKNhufO7Ia5CIAgABVFgCAAWFSgA==
Date: Thu, 8 Aug 2024 01:37:47 +0000
Message-ID: <20240808013743.tgvfjqgdtxluz52i@synopsys.com>
References: <20240804084612.2561230-1-kyletso@google.com>
 <20240806232836.52rkn7u3g5uiotn3@synopsys.com>
 <CAGZ6i=1v6+Jt3Jecd3euNnumVK781U9DQvRz7cHWnxi8Ga6W=g@mail.gmail.com>
In-Reply-To:
 <CAGZ6i=1v6+Jt3Jecd3euNnumVK781U9DQvRz7cHWnxi8Ga6W=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BL3PR12MB6451:EE_
x-ms-office365-filtering-correlation-id: 06fcd06e-ce9c-4fd1-c5fb-08dcb74ab502
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3lGVmRleEJKWE5iejk0cU96T0hlN1ZuY1lrZGYyaCtDMTRDQ2R5eTJYNmNU?=
 =?utf-8?B?MHpmdUJRRHk0U3RGZjVES29UamJkRUlDYStLT1RMN3dXV1hKL2VQaXJGclFk?=
 =?utf-8?B?ZzQvL2hpMk1WdGNRSDRrZlo1S2dFUWo5RmNJVnduNFhLTCs3dmU5Tk03VzJj?=
 =?utf-8?B?dTB3Mk9yb2FxT1ZuTnNMclF5TEhNSStqYUJUTjVHdnl4Rld4c204TURWSDl1?=
 =?utf-8?B?Z3BuS0FkcnpNdjF4Z04xamZieGM4K0hHZTBjTzJBdGlFVDlqZnRzL1cwUGZj?=
 =?utf-8?B?VE5MWGNlUmowZWR1VDhISTd6NlNVV2ZPdTA0THZVSDBHcXBMT2djcDFlT1l4?=
 =?utf-8?B?VVFhTUtDQklhRjkwYzh3ODRjRXFpaThVNnR2ZitmZUh0R1F6WmYrU2VLUWFV?=
 =?utf-8?B?RlQvci92YlVKWVA2cVhKWElIbHNvaGthWlN3NVdXcitlYkE4MXJPQ0lKNzhj?=
 =?utf-8?B?eE1ma0tvQzZSZnM2VjRvWTkra1gyMm8xSTNwcDNrQjBxd2hvMGo1VWh2WllX?=
 =?utf-8?B?Q0VXMmNMbnlxZWpzVmFUS1ZzNXB3K2NOWlJXZ1UvaGdoQnRIQXlNMWNXNi9a?=
 =?utf-8?B?aHFYYitFeE5MRTZyVG1Yc1NvR01pTW5udk4vbU40OHJtQ3pXWVE4a3BmR1hi?=
 =?utf-8?B?dGVpMG9XMXVteEZVWll1a1FqdGdXQ1JJOFRCZVRUZWU0UHdZRUJoanBHa1Bp?=
 =?utf-8?B?eFkvMmROM3Q4UE8wOVlNcDJrRVRqZCtJeDNXdWxYbGZZZDBOa1oyZk92TU40?=
 =?utf-8?B?QlIyU1RERm9UVGtjTmxPbnVSRElsSEM5YW1zRDVqditjR0NaTDV3aGRkc2gx?=
 =?utf-8?B?UEhTa3o4OFRVMmFEMGpjSVNha2IvS2o3MXpiQWdQUHR1YkZPU2o3dlR0QlYx?=
 =?utf-8?B?L1V3Umt3K25HaERaRlZOWkEvY1ZGeXdQOVdvQzllWjg3UGFzbnNCaStXbk1C?=
 =?utf-8?B?NWhOb1A2cm0yeTRZUUw1Rnk1ZVR6Z3I5TXBpY3pCRXJBRFFzeEoyd0pheUFJ?=
 =?utf-8?B?R2tubGJDRnBlcGZicXZPdlZKSnJrZ285MmdQVm9UZThOSFMrQS9UNi9oSUc2?=
 =?utf-8?B?Rk0zdmxHY1crYmlURHFFWkFkU0lrZXJSaWFqWnNEY3hlelIrQmdHWmhXVE9F?=
 =?utf-8?B?UzRxK25HSVJXeWF0V2lvVjk4MlpUeXlIa1VMWGx3dmR0WWtQaTZGWjVnRm04?=
 =?utf-8?B?eXU0U25CK2loTkJ0WWdUczZhY1BmZzVWa2tqZmZjSVlFUHdYOVhsaHhHRWhy?=
 =?utf-8?B?VTFIbklSbEpzNWl4WTlOOWxEcVNqZlMxdG1saVBVV3dVNzlRaExUaS9PVTht?=
 =?utf-8?B?dk5vQm84dTE3VU9wcDlIUzJ1RTh6aVlmb3Rnb1lMTDVtR3l2Q0YvR0c0WkJZ?=
 =?utf-8?B?eU40QmUxMThZdTNoYm5qTlhVMVFTdUpaV3JaajZMbG8rUHpVVGJtYlJCV2c4?=
 =?utf-8?B?MmVTd3c1ZThWVkxObkUwbVgyNmJla0ZOOXNKZFU3WGNlOGd4cFljKy9ReFdt?=
 =?utf-8?B?elNMbTFCcHVJb0d3M1VJcm5nc3hjaFo3MkgzaWZUM0p0UkI5bG1HZ1dIZUg5?=
 =?utf-8?B?VVg5clB4V0RYZFlEWTdFaDlIdmsrM3RLYXA5SmwxMnRBTjdyQkZ4TUlJKzF0?=
 =?utf-8?B?NnNtT3pxdUMvd0paRzVvREFIUkpKZ1UzQ1Iyc2c3L3dhOHVjSFBsek8zaW9K?=
 =?utf-8?B?ZmNOWW9ENnUyQVN3SlVzaGw0M3JYY205WWZmendxQXJOR1cvQ2N0MENvdmpE?=
 =?utf-8?B?TzdUNVVwWTZFVHZVclFpWTF0S3VzQTFReVZ5aC9hRVZ3VW9hcy9qUDV4dTUz?=
 =?utf-8?B?ditvWkZiUkNtZS80MG05UzZDM1lQKzFGanVYS1RMUkJDUk4xWTczLzlPa0RW?=
 =?utf-8?B?ZU5VWC9FcUtFODQyU2MzanVIYmtDZmhYaGpUMzJpSDZqS2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHUwV0s0dmpIRk9ud0p5Y0t6UnJVU21OTEhLL2lGVlNDM09NTjNNN0tLR1l1?=
 =?utf-8?B?aU1tOE1kd3puRjYwb3JQZXZNcXllL1lQd3RWditlTUgxTUhsaEF1K2dJOC9t?=
 =?utf-8?B?bHhqdmVPRDNlZlljZHV0emtzT051ZnNrazNCNjBtam10OStyOUJmRldWQnNT?=
 =?utf-8?B?ZHFURC9kMlVqaWt1Q3VGQzV2YjBjUkphRW5Lb1ZTSUQ0N09nRW51S2Z5Vyta?=
 =?utf-8?B?VHpKcnoyeXJRb3FIZ0dhYkhLK1EyT0pjMEhEYWNFS1A2WXV4SkhwaS82c0lH?=
 =?utf-8?B?a2J6MWRXeE80Wnhla29BSzdSOFMwUkg2VUFJNzVqTmQwd0FaM01zaVpySzhE?=
 =?utf-8?B?Yi9iamZmUnNvSGI2Mm4vYnJuM3BLRG42L0JGM01KYVk1R0dxR3pUa2lWYkF3?=
 =?utf-8?B?bXhDb0k5Y2g3TE9HcmFYcUJVYnk2NFg3bTFBSFg0bHc4Y0JHQmY1c0VnVklI?=
 =?utf-8?B?U3VoSkk1Qkd2dS9tN0k1UGY0Q2pmSEtpL3MzdVp2VjRESXVwY3ErUmVVeTgr?=
 =?utf-8?B?YmR6QlZCeHVWc2VKSWhNbm9ubVNtVUJncWdYbncvM1licE5RblVUMFRHVHky?=
 =?utf-8?B?MTViMlc3dzVPbW00c3BjcG00UXp5bXVHS1ZGOXdUZERjWTYzZDM1bHRaK0JG?=
 =?utf-8?B?UlRnbVp0UjFvdXg0emRuMHZKWVcrUGI1dDJLcktVZVJUWGFHL0VBaWV3N2JZ?=
 =?utf-8?B?TUJKamVwbEdCdnl6empWemkxbXN4Z0ZJWlJhT3pCazRYQmhnWTdjTmtvMHJ4?=
 =?utf-8?B?SENBbDVLbFdJUm04MFNBVVlPcFM4OC9iSUcxQ2haZTJwNWdOaTRiV0c5OHpI?=
 =?utf-8?B?Y3cxYS8weHNqMzhIMEdsQW5aZnlvdlI5bndITVFyc3EreFF5REJGVktRY2ZF?=
 =?utf-8?B?azVFNEZtZk9NWTZ4aWZxL0RYL29rZ3FQdGpNWVlFUllXdCtFLzVSSGdrQzBn?=
 =?utf-8?B?cEVDV3U2S1FESTZUWTlnYmUvb0lidmlWWlM3Tm9BZHl4RU9hWE5qVXBmTnlo?=
 =?utf-8?B?eE5veTg1dHUrVVpmMVZTM1V2TzlpQ0JnTVFCenFDTFBld0Z2dFovV3MrVXhS?=
 =?utf-8?B?eGZpbEthbDRHSHlaMHBmclkrQ3pqa1ZSNm1DQmw0Z08yRTArZ0haMXYwaHQ1?=
 =?utf-8?B?czBwTDJjRjFOVEx1RndIWTJCRStGVzg4OWhUTWVvbFhRVkw0NFlxcDB2VTI1?=
 =?utf-8?B?Ny8zMnZ1N2ZWMllNVkFWQkU0TytrOXJXZGdPajlhWm5hdE1YcUdvcjV3Mkhn?=
 =?utf-8?B?ZGZ2V0IvbWlucDErcnBUQjRTWEw4NEhlVGZvZ2lVWlZiWVF6bU12VXhXbzNs?=
 =?utf-8?B?Uzg2V2prMm5rZHlZUWFnbkJUeXFDTWNtUG9WSWc5TFpoZVF3czBteVdqb04w?=
 =?utf-8?B?U21WK0cwVHltUkJzTkZQZjl2SWU1dmJHeVBPREY2eGk4M1puVVZtbFB6WSta?=
 =?utf-8?B?eEFkcGtIeGk1MlBkTTYvbFo2S01Bb1F1MGxoMm1iYStGTGVlanJKSWh0RCtO?=
 =?utf-8?B?YkYrQVpFUnZQRVlVY3FnWFZ5aTBwM1A0NVNjR3dkdG1sMEg4TFNFMisvdTV2?=
 =?utf-8?B?WndnendrenFocUdCNCtwUm9ob0hycFphYm8vNFgzS0E4S2xaR21wVDkvU2RU?=
 =?utf-8?B?b09QQjRWN3FGV1VXWjJPTmdaOGxBd2VOVU5XTzA2aFk0VHpMWTVBcDJUeXNx?=
 =?utf-8?B?b0l4SnkreHZmNEY0QUhLYWRJWXAvUVdUWGVkY1YvbEtEVVNmaEJDKzFrb1B3?=
 =?utf-8?B?Q2JLanpPRU5kNDAvZTlJYnpRUVZQZUUwaWdWMWJBanBMMDlFMWUrSThMRi9C?=
 =?utf-8?B?U1lFODhOZldLdnJGOS93VjZkSjRta0tvbVlMd3E3REhqMU9rd0dVSFhRbE9x?=
 =?utf-8?B?QkMwU1Nad2hPNVVwb2g3aUJlR3A5Z2FPSXlDN2JGeGVmakpYWkhWSEZGM01l?=
 =?utf-8?B?bG13THNzVU9md2ZDQmtFNWFReThoUkxWL2lEbk9yVDF0alk0Sm9LREMvRm5W?=
 =?utf-8?B?SGtUa05saW82T3YxK3o3blRJWEdqSHpSaFc0MUFPbHR6MHo1dVVtTzZQZUtu?=
 =?utf-8?B?ejNwUXBYeWxYRDhsanZJUThWOGxTdHR5Z0JCanIvc2xuNUtzZWoxYjl5S28v?=
 =?utf-8?Q?AjrgTLVRyaFzi9GfZk5uTI5lk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DE73374270BAE41850E9C3BB5AF4AC6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lGJFW1gNkWchzkl8pCW3oAlq0v/O8Smy0YfyqiyI3MuOnCytDengzmf4A3v3hl1dYcKv/5l3zz+YXI0rM7NwzFd9Wu08UlBBq01teMSCWlWOghbvQEM/pNZ6+jK7lGgeB8djInVZbOJiiXiUNN11Quc79nTOq9hCVqJkLIc/xWBNJnVFvxW6hGABP+CmsjSnhed5++R+6qYW9TlIQ9mmTuvqJTErRknGmcbQml7VonjQlcqkAiZTS0gEsAPDMwkG2UJV0vi+gimf7sFdE/0jb2Qk+iyvGhzdlpMpYN0X+3QOUhvADzCarIdj7pnOoMlg6IZUGN3Kfk/1PehIMPaIMtgGUpd1Y/TAeh+GWWXBo+QV5263YGI6auspHdmq1T88OPgx4MCDW42QfHZpL0sm/KfIWlpGexBf6yK6aiITl9OR1BjL09atxEyceF6xOMW+5L1j9M9PYxKSEKznFyKQj340f11khsr8cnaa9jnsB07PedB5o8KGyM3N4WGByIze9Y9i8W3jSu3WdHOqzrsfEElFpNJUHTpWuEmtNn8zMbB9JwQYjlSaWSMPw1ZvMH7iXVB5a2ss7smNMPX9R2oS01ThbjORepzexcpi8aRUdjP0Ns76emvWxivDpAW0bsVLSE75bxqlNkjJe804ewH2hA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fcd06e-ce9c-4fd1-c5fb-08dcb74ab502
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 01:37:47.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HpVOkmSmx+Juk4611bmNbQ2hxBHtN0bm6yTAW4PpgySEk2KieKIdJo7GkIvkPr/XeuKr8t3U0ovU+i+UYO3Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
X-Proofpoint-GUID: sJ4RLeLVU_xMIHsz3kdLmKrYhJtPKnCv
X-Proofpoint-ORIG-GUID: sJ4RLeLVU_xMIHsz3kdLmKrYhJtPKnCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_15,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=858 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408080010

T24gV2VkLCBBdWcgMDcsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0KPiBPbiBXZWQsIEF1ZyA3LCAy
MDI0IGF0IDc6MjnigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gT24gU3VuLCBBdWcgMDQsIDIwMjQsIEt5bGUgVHNvIHdyb3RlOg0K
PiA+ID4gSXQgaXMgcG9zc2libGUgdGhhdCB0aGUgdXNiIHBvd2VyX3N1cHBseSBpcyByZWdpc3Rl
cmVkIGFmdGVyIHRoZSBwcm9iZQ0KPiA+DQo+ID4gU2hvdWxkIHdlIGRlZmVyIHRoZSBkd2MzIHBy
b2JlIHVudGlsIHRoZSBwb3dlcl9zdXBwbHkgaXMgcmVnaXN0ZXJlZA0KPiA+IHRoZW4/DQo+ID4N
Cj4gDQo+IFdlIGNhbiBkbyB0aGF0LCBidXQgZ2V0dGluZyB0aGUgcG93ZXJfc3VwcGx5IHJlZmVy
ZW5jZSBqdXN0IGJlZm9yZQ0KPiB1c2luZyB0aGUgcG93ZXJfc3VwcGx5IEFQSXMgaXMgc2FmZXIg
YmVjYXVzZSB3ZSBkb24ndCByaXNrIHdhaXRpbmcgZm9yDQo+IHRoZSByZWdpc3RyYXRpb24gb2Yg
dGhlIHVzYiBwb3dlcl9zdXBwbHkuIElmIHZidXNfZHJhdyBpcyBiZWluZyBjYWxsZWQNCg0KSSdt
IGEgYml0IGNvbmZ1c2VkLCB3b3VsZG4ndCB3ZSBuZWVkIHRoZSBwb3dlcl9zdXBwbHkgdG8gYmUg
cmVnaXN0ZXJlZA0KYmVmb3JlIHlvdSBjYW4gZ2V0IHRoZSByZWZlcmVuY2UuIENhbiB5b3UgY2xh
cmlmeSB0aGUgcmlzayBoZXJlPw0KDQo+IGJ1dCB0aGUgdXNiIHBvd2VyX3N1cHBseSBpcyBzdGls
bCBub3QgcmVhZHksIGp1c3QgbGV0IGl0IGZhaWwgd2l0aG91dA0KPiBkb2luZyBhbnl0aGluZyAo
b25seSBwcmludCB0aGUgZXJyb3IgbG9ncykuIFRoZSB1c2IgZ2FkZ2V0IGZ1bmN0aW9uDQo+IHN0
aWxsIHdvcmtzLiBBbmQgb25jZSB0aGUgdXNiIHBvd2VyX3N1cHBseSBpcyByZWFkeSwgdGhlIHZi
dXNfZHJhdw0KPiB3aWxsIGJlIGZpbmUgaW4gZm9sbG93aW5nIHVzYiBzdGF0ZSBjaGFuZ2VzLg0K
PiANCj4gTW9yZW92ZXIsIGFsbCBkcml2ZXJzIHVzaW5nIHBvd2VyX3N1cHBseV9nZXRfYnlfbmFt
ZSBpbiB0aGUgc291cmNlDQo+IHRyZWUgYWRvcHQgdGhpcyB3YXkuIElNTyBpdCBzaG91bGQgYmUg
b2theS4NCj4gDQo+ID4gPiBvZiBkd2MzLiBJbiB0aGlzIGNhc2UsIHRyeWluZyB0byBnZXQgdGhl
IHVzYiBwb3dlcl9zdXBwbHkgZHVyaW5nIHRoZQ0KPiA+ID4gcHJvYmUgd2lsbCBmYWlsIGFuZCB0
aGVyZSBpcyBubyBjaGFuY2UgdG8gdHJ5IGFnYWluLiBBbHNvIHRoZSB1c2INCj4gPiA+IHBvd2Vy
X3N1cHBseSBtaWdodCBiZSB1bnJlZ2lzdGVyZWQgYXQgYW55dGltZSBzbyB0aGF0IHRoZSBoYW5k
bGUgb2YgaXQNCj4gPg0KPiA+IFRoaXMgaXMgcHJvYmxlbWF0aWMuLi4gSWYgdGhlIHBvd2VyX3N1
cHBseSBpcyB1bnJlZ2lzdGVyZWQsIHRoZSBkZXZpY2UNCj4gPiBpcyBubyBsb25nZXIgdXNhYmxl
Lg0KPiA+DQo+ID4gPiBpbiBkd2MzIHdvdWxkIGJlY29tZSBpbnZhbGlkLiBUbyBmaXggdGhpcywg
Z2V0IHRoZSBoYW5kbGUgcmlnaHQgYmVmb3JlDQo+ID4gPiBjYWxsaW5nIHRvIHBvd2VyX3N1cHBs
eSBmdW5jdGlvbnMgYW5kIHB1dCBpdCBhZnRlcndhcmQuDQo+ID4NCj4gPiBTaG91bGRuJ3QgdGhl
IGxpZmUtY3ljbGUgb2YgdGhlIGR3YzMgbWF0Y2ggd2l0aCB0aGUgcG93ZXJfc3VwcGx5PyBIb3cN
Cj4gPiBjYW4gd2UgbWFpbnRhaW4gZnVuY3Rpb24gd2l0aG91dCB0aGUgcHJvcGVyIHBvd2VyX3N1
cHBseT8NCj4gPg0KPiA+IEJSLA0KPiA+IFRoaW5oDQo+ID4NCj4gDQo+IHVzYiBwb3dlcl9zdXBw
bHkgaXMgY29udHJvbGxlZCBieSAiYW5vdGhlciIgZHJpdmVyIHdoaWNoIGNhbiBiZQ0KPiB1bmxv
YWRlZCB3aXRob3V0IG5vdGlmeWluZyBvdGhlciBkcml2ZXJzIHVzaW5nIGl0IChzdWNoIGFzIGR3
YzMpLg0KPiBVbmxlc3MgdGhlcmUgaXMgYSBub3RpZmljYXRpb24gbWVjaGFuaXNtIGZvciB0aGUg
KHVuKXJlZ2lzdHJhdGlvbiBvZg0KPiB0aGUgcG93ZXJfc3VwcGx5IGNsYXNzLCBnZXR0aW5nL3B1
dHRpbmcgdGhlIHJlZmVyZW5jZSByaWdodA0KPiBiZWZvcmUvYWZ0ZXIgY2FsbGluZyB0aGUgcG93
ZXJfc3VwcGx5IGFwaSBpcyB0aGUgYmVzdCB3ZSBjYW4gZG8gZm9yDQo+IG5vdy4NCj4gDQoNClRo
ZSBwb3dlcl9zdXBwbHkgZHJpdmVyIHNob3VsZCBub3QgYmUgYWJsZSB0byB1bmxvYWQgd2hpbGUg
dGhlIGR3YzMNCmhvbGRzIHRoZSBwb3dlcl9zdXBwbHkgaGFuZGxlIGR1ZSB0byBkZXBlbmRlbmN5
IGJldHdlZW4gdGhlIHR3by4gV2h5DQp3b3VsZCB3ZSB3YW50IHRvIHJlbGVhc2UgdGhlIGhhbmRs
ZSB3aGlsZSBkd2MzIHN0aWxsIG5lZWRzIGl0Lg0KDQpUaGlzIGNyZWF0ZXMgYW4gdW5wcmVkaWN0
YWJsZSBiZWhhdmlvciB3aGVyZSBzb21ldGltZSB2YnVzIGNhbiBiZSBkcmF3bg0KYW5kIHNvbWV0
aW1lIGl0IGNhbid0LiBZb3VyIHNwZWNpZmljIGdhZGdldCBmdW5jdGlvbiBtYXkgd29yayBmb3Ig
aXRzDQpzcGVjaWZpYyBwdXJwb3NlLCBzb21lIG90aGVyIG1heSBub3QgYXMgaXRzIHZidXNfZHJh
dyBtYXkgYmUgZXNzZW50aWFsDQpmb3IgaXRzIGFwcGxpY2F0aW9uLg0KDQpCUiwNClRoaW5o


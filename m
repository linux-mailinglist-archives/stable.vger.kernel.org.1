Return-Path: <stable+bounces-91882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E641A9C12D5
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 00:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725B62837C1
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798C1F4FC1;
	Thu,  7 Nov 2024 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O/DetQYi";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ES4RFOPv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W4Q7tR0y"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60E1E261C;
	Thu,  7 Nov 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023988; cv=fail; b=sdAYbNJQ9OQuWj/iD64XGdTGOW2pwlmRqkpXO+IiQvP5dxwHUiOzMn5lslaYazhf9goD1BNXX5bH/DBffJdrHpu/G2Dp+WckeYvm9oLUurKf8tOkwI/7A13aGOKlGrdQ65b7GkuYN3lTmu6D8mGmBtk0snPKdW+poyPpq/qfJEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023988; c=relaxed/simple;
	bh=Y6ooxiTISUkmSpHJ3uDutmyRAy7SK+UaMc7PVGOaQFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uyuj1HFbKggZl/5DW8o5REg7R57zrb7jQ2XRA1aYlmrADJdvA0hjtSH65g4U4BRvqne1LUZGSbr1p68t2npWi8oGB/6nvCP5lnUdXzdx4mUpUnTr96YR5MKcFPeJz/2g1Xs9Y12dBNvO3VXEpF20iNAkiZz70OKJs6EdJokmzRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O/DetQYi; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ES4RFOPv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W4Q7tR0y reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MbA8H017571;
	Thu, 7 Nov 2024 15:34:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Y6ooxiTISUkmSpHJ3uDutmyRAy7SK+UaMc7PVGOaQFA=; b=
	O/DetQYiau3/IlBCApZYtBbWWWLemdyDLWf7q/pC19n4m0GhMKueoyRJ1bAzSsMh
	PEcIwCZS9QjTChf3WfcnIRxqixExSZs+27cJsRqoTLRk/SqSjf36K89UY0LgVeY+
	i8rWDIERHqEkDlE0Dm+QXB8840zRI08zVC6Go3mFDgz1pH5mjOK14BAd8d4xC1xr
	x9bHhXK3Np1FlLRAN7iCIhymXVomKCWTUNlrwSRwonzuXGtxRcPUus8X2xtNjKXS
	f9xA0opwwMIxAPE3TAiSwdM5HDXpvg37NQnJdNLvDFGWpyYfIYFJvmQwqEDnsC7r
	e+PdJeAoJTLwwxSbBEbECA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42s6gjg80h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731022459; bh=Y6ooxiTISUkmSpHJ3uDutmyRAy7SK+UaMc7PVGOaQFA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ES4RFOPvKq3u4FHug1HPHmZ4Cmgb6xF7eHMhYg/7ZJTqQjDGb73CRzi8kAGTpZkPi
	 wpeMTfEXA/yV0VuHjzBawyaNSNoQDOyWWEMQ4m9SCyMBU/oRWY83HbvgxnRJOHqnEu
	 9VPiREl/UAuU8lYRU3pInuu/DwIAwSpliFlQQJSRBy/H78CPJNKxX9zIFBtgObs2cn
	 PNrc+xD/M31uqVK6i361wYl+SUr7e95G48GxxHB4yn/YpfNt0N0JHuXpZFOpwP81sG
	 VqGsdwxsnoalXs5lZwEfRYsciMO6/GQ2lkMSLLnHceqxiIDszW+yrSvJcMa4Qx8OPh
	 h9iRlE88NMwrQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CDF1440144;
	Thu,  7 Nov 2024 23:34:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3F22AA0076;
	Thu,  7 Nov 2024 23:34:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=W4Q7tR0y;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4FF3C401D9;
	Thu,  7 Nov 2024 23:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYLzgOdT7+waIFZNKKFkG1/CR64KXKuBlpajPPBZWDUMYad+17mxkOYjmCPY3ES0S9SdxXn2lNDM7nAZB68OXRAgzYkWxuE211/xJbEOwFbYWKVRkTWL5qdAaahbbjvDGHnzkD+dI7b3oU5ibZbICNGrBvmuLjP5jHOf2yKPATp0/wf1QnoEtIOaaKrKVZAiOjEtAROflANXly0JSZ6JQ/dKbfX5PrfnzKba9MTD1A4EDAzwQjRLOyIGlj49sXRX4u/FmuSTAy2OZngrPzqVBC2CU+Bbq/H78RDcsy6+3GXbW2xVQ10oJEpA6ifG26lGN42hwzCqFa/Q57jjM5HWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6ooxiTISUkmSpHJ3uDutmyRAy7SK+UaMc7PVGOaQFA=;
 b=Xa1jZI4/Y0/I6MqLV3Ffaa7vLWJc89WUeLTWysyCNqz7B8lywV5y7xcaEjeDVOkKSiyoIYurzVWOe9cWsYkyi42/bkwmxXOt8H5Tmv3gFc+cHj1fY/aMAqNOoqoNA7sPeGExf5FZcXCEQAeSAbGXw0qngFDCb/rGT6MPUkjv3aXeXinQVwttsqit4T83pe50n4DB53bDmJHYtK+oeCFk1wHSS4/4BLEPYXmSk4QvHUmznMsreZw04V7QS5PABAXgNpQdJ1/46Q8acSlTesw9G9Epzzsn0bN5T9oMfP+WmJk11klFHCRyiYMcT0LshgiKFSw+Dg06mjznFdjHe6wj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6ooxiTISUkmSpHJ3uDutmyRAy7SK+UaMc7PVGOaQFA=;
 b=W4Q7tR0yh5lQo5xzLg5X2j/E5RU1G46cxRhgK/gUXqU3O6yoAp13ENeso7cOiM/z7xrWDvC0UrvPQlrtO790031wxg6ldaPHtNn3n5b1m2laRXo4gEf0yuc2KXVPGLhxVBdWlU6udBiiQh1nTbJLd0fU6QlzUE6OB3nxNmTUm4w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 23:34:11 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:34:11 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Topic: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Index: AQHbMQHbau1m5SPRoEuLkzV8BIeusLKseQuA
Date: Thu, 7 Nov 2024 23:34:11 +0000
Message-ID: <20241107233403.6li5oawn6d23e6gf@synopsys.com>
References:
 <CGME20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6@epcas5p1.samsung.com>
 <20241107104040.502-1-selvarasu.g@samsung.com>
In-Reply-To: <20241107104040.502-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB9323:EE_
x-ms-office365-filtering-correlation-id: 85a7df64-1ffb-482c-e676-08dcff84aeef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dWZ0bkVLYjFHZXcyS0U4VGdBUnlRSDIvN1JkN1MzTlhSNDNBUCt5d3NyYU1s?=
 =?utf-8?B?QjFLck9yVkNpc2dESjV2UXYxbUVySk9YcEZiM3FPU0YwUTBocmg3VFk4RDIv?=
 =?utf-8?B?T1JhWEhzMlloeEZNMnNHSnpNbHV5dFBFTWxYaTQxZTgrMUhBbENKUjNBTklY?=
 =?utf-8?B?ZHNxNEJHejVNelpHR3BZTWJvK1JZa01TaFZyR2RvazZ1Y0FxWk1mTzlUREhC?=
 =?utf-8?B?cmtubTd3Q2lETTVZZmtqeXpyWFJQZTJjUnc0aGx2c2JrM0VLdVNNdncrUTc3?=
 =?utf-8?B?ZkNtN3JqU0tlNFpmeks5RmR4UkdZMUdCc3dYSTJ3eXlLK3JHWnVjR01nY1pk?=
 =?utf-8?B?cDFmeWY2cmF6WWdPbGU2UFpoR1JXUWVFcjZZaU1QSWhnaFZtdXovaEJWdm5u?=
 =?utf-8?B?SlliTUhpYjlrZ1lkK2huRkFaNC9YQU9GeVgwSXJsWWE0WGJZVER5NFIyajBM?=
 =?utf-8?B?aUFNVHlSdmhtb0xFQ3BUSWZQbmlyVU5Wa2FqdkRFcllqTnV6cmdlWEdxME9G?=
 =?utf-8?B?K2NocGdTSFpKUnlxcFhZaTJVdCtucEh0bUtIV2phWVcwWkNtTENvakF4Y3ZY?=
 =?utf-8?B?SnhYdWpWTUY3VzdPSnZxbHlNRjNSNE8wRTBULzRtT3c5eFU4dktUNTdQM0E2?=
 =?utf-8?B?RldJR0IwUWVTL0JkM1BWakY0YUlwN3dzcFVPZy83SnUwQi94MTlFOEFaeW5M?=
 =?utf-8?B?Snh4V3FvdDJCTnVySzhkSlZCZU5qNERLekhTSTcwaWJNUmgvZFhHSTNiQThB?=
 =?utf-8?B?WHBhYUtZTVFPc01sNW0yNlExS1pIdDYyWVBuSHgvQUYxY3hXbU1qcFVYWldj?=
 =?utf-8?B?WGgzSXcwVGVwazBZSEtVb0VMNGJTUUNQa01XcEt6SzRlL0MzaWw4UWFLbW9h?=
 =?utf-8?B?Y0UrUyszUk1mckU4WWd1K1RYODFUZE13cWRxT2UxN2RheUhIaVZ4Z2E5TWQ5?=
 =?utf-8?B?WjFrdENDNVowVU1kUFQ4d1k0WGRPVXdscHZTaGNUUlVTaDJ3VzVSQW9ia2tS?=
 =?utf-8?B?STJibDBhZDNjckxVS0U0V3lsWnhvamduUGRZRlNyVzk4dkN6bUhaM3FObXRw?=
 =?utf-8?B?UU02Z3JJcXhhNDZFWUpjV2RZU1E2b1JGeHMrOTZFbjgrUm5NeGhWSmR4TVpS?=
 =?utf-8?B?VnA2bHNhOWZ3U0MrTFh4VTJyUUZTM2d1b3BRdm5NTEN1SER2UE1uV25NUmFG?=
 =?utf-8?B?N3h5YkZ2WlJ3OVNMMVNrdGgwQytBM2FoZmZlQ3pIdTB0NDNQdEJScWdDZmdS?=
 =?utf-8?B?L1Q1cnByT2h4a3hPWG1IOXRwbnpuQ1pXTmhGM1FZSWJoaWVabkhGMmNrRWI1?=
 =?utf-8?B?VUc0TDYvQVBBeXRWY05tWUVwcFhqL3F2djFiejlLSEFaTkhPMzE0RkNsSTFZ?=
 =?utf-8?B?a3ZZOHNWQkVmUmNFSWRXRGdET0NGK3FNRUFiQmZDTENsYmFhS3hxYlBUaHN2?=
 =?utf-8?B?WkY5eDJzRDhLbmVCQWh1K3FXTUZVS1ZacXplSzhuSFZhMzJZUkNTNXNsZGlF?=
 =?utf-8?B?a0xzbzEwYzJiditnRzFlbmpDdTFwaytnK21qYnlLd0FRbWlrUDRvNmdnRldq?=
 =?utf-8?B?UlM0MU0raHdYZUFGUjR1ajFEcE1OSjl6aTNrL2FlVXN1Z2pxd2JxWHBYa1Ra?=
 =?utf-8?B?c3ErK3VFZCsvU1V1UDU0R0FsT3YzKzJ5TDZLbnhVV0RKQkpSSWJMdzJvZTlD?=
 =?utf-8?B?TWtPMGNsNCtzbGZVSU9rKzBXNXVsRXJISnE4dW5rZ3dBN2xYM1J6TmxvU21S?=
 =?utf-8?B?aEZEUDdrZTNWWXlMTGhwV1BqeEE2a3dKeE9LQlRod2RFZjdmdFVXNFVnUUR4?=
 =?utf-8?Q?VfD0cfEzoNMZ0W2GEWfNtYoOkQUPLop1hKW0k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFozUm5odHBkVGNPQUNxeW9kOHBrWEpFL0RQSGVuUCt0dGdSSzJ4d1dEUnNP?=
 =?utf-8?B?Q0FwRGNhdGtvSmlyZXd2RFNOSDRvRzBDa29ndS80ZkpPN2hBYXJSUFpCZHRz?=
 =?utf-8?B?ZC94M0t5UWJsQ0d1Y1FzUzhUV3dueW56cWVMbFVwZ2xLdDJ5dVl3OGNFY2I0?=
 =?utf-8?B?RmcvRE4wQUlRTGM3SFVBalJtYUZDbzFjakVwN1BocWRJYTRVQXlnVTRJNFZ4?=
 =?utf-8?B?RE9nWXdoWlBhS2lKTnRTOEJ4emh1WDJHWFBweUxVaC9oUkR2dUxTaWdmTU04?=
 =?utf-8?B?Z2kvRnU5N1BFMEpCNmJZWEsranhmRlhLeW5IWGxpR29GSW01cURKSys2VzZH?=
 =?utf-8?B?NVJWOVBEa0hwazZWaGI4eC9rVklneVFFMmV6cEFHbjVia2NRNmlaZDNla2Fm?=
 =?utf-8?B?ak5DVEF6UUZjZGU4YmZwWjJXU0lESnFMYS96cTZua1YyemkycG1uYlcyeUJn?=
 =?utf-8?B?elNTMHl1S0RBWkdWSWQ5aDNHNE42eHFTeHhreGtBNEZyR0tJL1F2aWM2NzJK?=
 =?utf-8?B?NTM3Ti9FbjIrSmhtN2tQOE5CTm5lalZFT1ZlSVBFNEFpWDdiQlRNNnlkczlR?=
 =?utf-8?B?dTlzVG05K2grN0t4YnRBRWNHenYzZTlhcGp0U0dZYUxxK1gxTHRJWXRvUlNR?=
 =?utf-8?B?NUloOXIvaVI1eTJKN2haY0lKSUxXTlgvMXpNK0NkS1NHZjRtdllsVm5wcFF1?=
 =?utf-8?B?dWlRVlpsNUFXSG54V2d2eGV1ZDhhTjUxVGNRQTNSVEFlUys2RXRBWURPRVVS?=
 =?utf-8?B?YVN5RUdOUkFqbjM2SldCMjd4UTlyMTl1TFBMTEpOdzFCR3lOdTllYng3dnFv?=
 =?utf-8?B?ek5EY3pFOFp6NklyZDFJYWJMazVlaHJJejd6VmtiTlpZRFNZQUhGL2IzUUt1?=
 =?utf-8?B?bU10ZkpBRlZiejhhM0Vmcm1XL0IzK3pZK0ZDVXFqMUN1VnBnbm56eDc1TExz?=
 =?utf-8?B?dmYzOWtVVnlRTEEwQlVyZWZVOEZZSkoyVVZ6NW5nNnBxOUd6M2hWSFRoY1oy?=
 =?utf-8?B?NXNybG16cmJLT2QvZVJOTW1KTnA5LzlQSGIrUTc0VjgwNGVndjdybWZEOVE2?=
 =?utf-8?B?TWhDMXBiZ0REUG9xS0k3ci9Jc1c1aUU3eGp4SWl4bzExRDNyZUZxTXJ6M0VN?=
 =?utf-8?B?Nm9QeFBTN2xESlhKa1UyWUtKVTVYdkFCR0FlOWFxbnJuMzZqSkJBYndram11?=
 =?utf-8?B?SkhEUEoySTZERzRock5UOFVDU3pDNFh4MGdMd1pDd2JhYXF6b0xjOVZiMnRk?=
 =?utf-8?B?V1Z1eDR2Qmh6T3JPNUZOZk9yVWRJN3RYUWJZR0YvcGdvWU1ISnczUFlxVkJM?=
 =?utf-8?B?SWZ5bjhya1dlVDdWWjNjM25SUVUvVFVHSVRrWmRuVjZBalZVMDNTRFIxN3ZF?=
 =?utf-8?B?Wkh3c3E0TEN6WDdDKy9paDlpdHIzK0lqa1c4RGpBYy8yUzBpTGxEc2wvMXRW?=
 =?utf-8?B?TmVqYjE1ZXA5dnlYdDJEZUx6c3FhRTRnTVJtb1R1UFJpTmltOE5oeS9mLzJ4?=
 =?utf-8?B?ZU1kNGdqM3BTaUYyREJ2ekJIUlV4cmxZRDRRL0NUek9adC84aWxPR0FCam1K?=
 =?utf-8?B?RVpJalFCbmFuTDMxNHJpcDFpVW8xUlhNMGREUWtqbFdNRkdobVpESVc0b0VQ?=
 =?utf-8?B?cGRDRDEwb0dUV2hsTDhkVGRvUnNwd0I2YkRUTWhXWlhtM2FDMzdXdkY5YUJi?=
 =?utf-8?B?QlkxZjRPR1Vqb3hwVkZ1QVd6MllxV3FXalhEZlpsaHB3S2FpTnNZUjhlZWpp?=
 =?utf-8?B?SU4wR0ExY21KUXlES3RvaEhubEh3SEIreXYzZXZ2cC8wQno3L001aDd3ckJl?=
 =?utf-8?B?ZGw4cnNjVG9RZUlkMUxaYk5NY0QyK1RrWWhBZmVLd0pkWC9wOUIwUTVhTFgv?=
 =?utf-8?B?WnFNcnVXWkFlcTgwemt4VXNQVUZ4NEd6WWNpTWsvQU1EWE0vbXBWOFRCQWZU?=
 =?utf-8?B?TzlGMENaMlhZaVY1c2t3VTgxaG9RdXQrMWVmdGUrL3VOM2xNNzNaS0U3ZzFx?=
 =?utf-8?B?SFJjOTk1b2dudkxTdG5DVFpqdVFSZ2hXYktDNHNYOHlFdW9sTkoyWlR1bWx3?=
 =?utf-8?B?QmR3V2R5elZWUWpHL2JaZlNNZ1R4NGM2QVEzV2lXWEc1dm9aN2c3bndaeTdi?=
 =?utf-8?Q?+dlWxSVWlX8XmzUGYGH8F8B+v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FC2A6BDDB0DF4439E6A6A99C7A0221F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vmcio3/Y6ugQFK1f2OaKaZnZPcmAqAqvb5k7kEgsfMwKKmi+nRAFjlqW2kBOc3QdD2rFMv6O7M0DjnhMj/d9/0xFH8XshRhPrBl/nQKFYijsBKllofw/YTD60jLEginAov1KuvDPB1X+BpOrcUGc+0ZernzpMrsKRBn8nmC1x691vbKJGBt+gRrwLxoERwUnGzCwkNu38ezs0CUh3LDJBM4GBlGL5TRk8pdt830F49NKdV1sywn9Pp939I8XEqn7BIUtT7LgR7fsEaeQ0+K8DlZPdTUxX5m95qfYouaq/f2LP8k7mdcMQXZoYNqH6xe96F32zoVbyCdRB9HrYwMq/juhN5oibDX4eEml7Hi+sBv3dBHkM8bVmYp67ujy4vFfoygk6qPyZfB+2YkWbbt+z0RQiWc5GemM8lzF/wQjnVjJ42PaCC3QsBu+bPUOu+9lgTvPOy3ZCprL7uNbXIogPfDas3sJSQ7SyLPbMelXHAfoTeGXBHlYetBjPsmNCa1iGCKgg8GtJG/fE+tauzX8u0xi90NE+KKIluS3qO4DRy4J8LPlM68N9wmvcuSZNQDeqTVSBc1RXFjcW2FmG1GpLJCXwxwNh2j/uPOUHL0Vmxb9ay85V5Ktuvr79K2qhzwmJ1WecTrUwAWSEWODbwNz4Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a7df64-1ffb-482c-e676-08dcff84aeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 23:34:11.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9MwTNIbGc7QlJdj9qbAb/n0nzNPsCIVbIg5P3efbNk7W00fPQMdBfRQImMi9C7bVbIjEkpoqtrQibJjLTqgig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323
X-Proofpoint-GUID: JqozDJ-8-DEvChZouRM1thG43dPmg1Hc
X-Authority-Analysis: v=2.4 cv=e9lUSrp/ c=1 sm=1 tr=0 ts=672d4e7c cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=es7jtOQpjM_ZVYCrN4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JqozDJ-8-DEvChZouRM1thG43dPmg1Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070183

T24gVGh1LCBOb3YgMDcsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRzIHN1cHBvcnQgZm9yIHJlc2l6aW5nIHRoZSBUeEZJRk8gaW4gVVNCMi4wLW9ubHkg
bW9kZQ0KPiB3aGVyZSB1c2luZyBzaW5nbGUgcG9ydCBSQU0sIGFuZCBsaW1pdCB0aGUgdXNlIG9m
IGV4dHJhIEZJRk9zIGZvciBidWxrDQoNClRoaXMgc2hvdWxkIGJlIHNwbGl0IGludG8gMiBjaGFu
Z2VzOiAxIGZvciBhZGRpbmcgc3VwcG9ydCBmb3INCnNpbmdsZS1wb3J0IFJBTSwgYW5kIHRoZSBv
dGhlciBmb3IgYnVkZ2V0aW5nIHRoZSBidWxrIGZpZm8gc2V0dGluZy4NCg0KVGhlIGZpcnN0IGNo
YW5nZSBpcyBub3QgYSBmaXgsIGFuZCB0aGUgbGF0dGVyIG1heSBiZSBhIGZpeCAobWF5IG5lZWQN
Cm1vcmUgZmVlZGJhY2sgZnJvbSBvdGhlcnMpLg0KDQo+IHRyYW5zZmVycyBpbiBub24tU1MgbW9k
ZS4gSXQgcHJldmVudHMgdGhlIGlzc3VlIG9mIGxpbWl0ZWQgUkFNIHNpemUNCj4gdXNhZ2UuDQo+
IA0KPiBGaXhlczogZmFkMTZjODIzZTY2ICgidXNiOiBkd2MzOiBnYWRnZXQ6IFJlZmluZSB0aGUg
bG9naWMgZm9yIHJlc2l6aW5nIFR4IEZJRk9zIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcgIyA2LjEyLng6IGZhZDE2YzgyOiB1c2I6IGR3YzM6IGdhZGdldDogUmVmaW5lIHRoZSBsb2dp
YyBmb3IgcmVzaXppbmcgVHggRklGT3MNCj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVz
YW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oICAgfCAgNCArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1NiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwg
NDggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBl
YWE1NWMwY2Y2MmYuLjgzMDZiMzllNWM2NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTkxNSw2ICs5
MTUsNyBAQCBzdHJ1Y3QgZHdjM19od3BhcmFtcyB7DQo+ICAjZGVmaW5lIERXQzNfTU9ERShuKQkJ
KChuKSAmIDB4NykNCj4gIA0KPiAgLyogSFdQQVJBTVMxICovDQo+ICsjZGVmaW5lIERXQzNfU1BS
QU1fVFlQRShuKQkoKChuKSA+PiAyMykgJiAxKQ0KPiAgI2RlZmluZSBEV0MzX05VTV9JTlQobikJ
CSgoKG4pICYgKDB4M2YgPDwgMTUpKSA+PiAxNSkNCj4gIA0KPiAgLyogSFdQQVJBTVMzICovDQo+
IEBAIC05MjUsNiArOTI2LDkgQEAgc3RydWN0IGR3YzNfaHdwYXJhbXMgew0KPiAgI2RlZmluZSBE
V0MzX05VTV9JTl9FUFMocCkJKCgocCktPmh3cGFyYW1zMyAmCQlcDQo+ICAJCQkoRFdDM19OVU1f
SU5fRVBTX01BU0spKSA+PiAxOCkNCj4gIA0KPiArLyogSFdQQVJBTVM2ICovDQo+ICsjZGVmaW5l
IERXQzNfUkFNMF9ERVBUSChuKQkoKChuKSAmICgweGZmZmYwMDAwKSkgPj4gMTYpDQo+ICsNCj4g
IC8qIEhXUEFSQU1TNyAqLw0KPiAgI2RlZmluZSBEV0MzX1JBTTFfREVQVEgobikJKChuKSAmIDB4
ZmZmZikNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMmZlZDJhYTAxNDA3Li5kM2UyNWY3ZDdj
ZDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNjg3LDYgKzY4Nyw0MiBAQCBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X2NhbGNfdHhfZmlmb19zaXplKHN0cnVjdCBkd2MzICpkd2MsIGludCBtdWx0
KQ0KPiAgCXJldHVybiBmaWZvX3NpemU7DQo+ICB9DQo+ICANCj4gKy8qKg0KPiArICogZHdjM19n
YWRnZXRfY2FsY19yYW1fZGVwdGggLSBjYWxjdWxhdGVzIHRoZSByYW0gZGVwdGggZm9yIHR4Zmlm
bw0KPiArICogQGR3YzogcG9pbnRlciB0byB0aGUgRFdDMyBjb250ZXh0DQo+ICsgKi8NCj4gK3N0
YXRpYyBpbnQgZHdjM19nYWRnZXRfY2FsY19yYW1fZGVwdGgoc3RydWN0IGR3YzMgKmR3YykNCj4g
K3sNCj4gKwlpbnQgcmFtX2RlcHRoOw0KPiArCWludCBmaWZvXzBfc3RhcnQ7DQo+ICsJYm9vbCBz
cHJhbV90eXBlOw0KPiArCWludCB0bXA7DQo+ICsNCj4gKwkvKiBDaGVjayBzdXBwb3J0aW5nIFJB
TSB0eXBlIGJ5IEhXICovDQo+ICsJc3ByYW1fdHlwZSA9IERXQzNfU1BSQU1fVFlQRShkd2MtPmh3
cGFyYW1zLmh3cGFyYW1zMSk7DQo+ICsNCj4gKwkvKiBJZiBhIHNpbmdsZSBwb3J0IFJBTSBpcyB1
dGlsaXplZCwgdGhlbiBhbGxvY2F0ZSBUeEZJRk9zIGZyb20NCj4gKwkgKiBSQU0wLiBvdGhlcndp
c2UsIGFsbG9jYXRlIHRoZW0gZnJvbSBSQU0xLg0KPiArCSAqLw0KDQpQbGVhc2UgdXNlIHRoaXMg
Y29tbWVudCBibG9jayBzdHlsZQ0KLyoNCiAqIHh4eHgNCiAqIHh4eHgNCiAqLw0KDQo+ICsJcmFt
X2RlcHRoID0gc3ByYW1fdHlwZSA/IERXQzNfUkFNMF9ERVBUSChkd2MtPmh3cGFyYW1zLmh3cGFy
YW1zNikgOg0KPiArCQkJRFdDM19SQU0xX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM3KTsN
Cg0KRG9uJ3QgdXNlIHNwcmFtX3R5cGUgYXMgYSBib29sZWFuLiBQZXJoYXBzIGRlZmluZSBhIG1h
Y3JvIGZvciB0eXBlIHZhbHVlDQoxIGFuZCAwIChmb3Igc2luZ2xlIHZzIDItcG9ydCkNCg0KPiAr
DQo+ICsNCj4gKwkvKiBJbiBhIHNpbmdsZSBwb3J0IFJBTSBjb25maWd1cmF0aW9uLCB0aGUgYXZh
aWxhYmxlIFJBTSBpcyBzaGFyZWQNCj4gKwkgKiBiZXR3ZWVuIHRoZSBSWCBhbmQgVFggRklGT3Mu
IFRoaXMgbWVhbnMgdGhhdCB0aGUgdHhmaWZvIGNhbiBiZWdpbg0KPiArCSAqIGF0IGEgbm9uLXpl
cm8gYWRkcmVzcy4NCj4gKwkgKi8NCj4gKwlpZiAoc3ByYW1fdHlwZSkgew0KDQppZiAoc3ByYW1f
dHlwZSA9PSBEV0MzX1NQUkFNX1RZUEVfU0lOR0xFKSB7DQoJLi4uDQp9DQoNCj4gKwkJLyogQ2hl
Y2sgaWYgVFhGSUZPcyBzdGFydCBhdCBub24temVybyBhZGRyICovDQo+ICsJCXRtcCA9IGR3YzNf
cmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dUWEZJRk9TSVooMCkpOw0KPiArCQlmaWZvXzBfc3RhcnQg
PSBEV0MzX0dUWEZJRk9TSVpfVFhGU1RBRERSKHRtcCk7DQo+ICsNCj4gKwkJcmFtX2RlcHRoIC09
IChmaWZvXzBfc3RhcnQgPj4gMTYpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiByYW1fZGVwdGg7
DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogZHdjM19nYWRnZXRfY2xlYXJfdHhfZmlmb3MgLSBD
bGVhcnMgdHhmaWZvIGFsbG9jYXRpb24NCj4gICAqIEBkd2M6IHBvaW50ZXIgdG8gdGhlIERXQzMg
Y29udGV4dA0KPiBAQCAtNzUzLDcgKzc4OSw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcmVz
aXplX3R4X2ZpZm9zKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMg
KmR3YyA9IGRlcC0+ZHdjOw0KPiAgCWludCBmaWZvXzBfc3RhcnQ7DQo+IC0JaW50IHJhbTFfZGVw
dGg7DQo+ICsJaW50IHJhbV9kZXB0aDsNCj4gIAlpbnQgZmlmb19zaXplOw0KPiAgCWludCBtaW5f
ZGVwdGg7DQo+ICAJaW50IG51bV9pbl9lcDsNCj4gQEAgLTc3Myw3ICs4MDksNyBAQCBzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAg
CWlmIChkZXAtPmZsYWdzICYgRFdDM19FUF9UWEZJRk9fUkVTSVpFRCkNCj4gIAkJcmV0dXJuIDA7
DQo+ICANCj4gLQlyYW0xX2RlcHRoID0gRFdDM19SQU0xX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdw
YXJhbXM3KTsNCj4gKwlyYW1fZGVwdGggPSBkd2MzX2dhZGdldF9jYWxjX3JhbV9kZXB0aChkd2Mp
Ow0KPiAgDQo+ICAJc3dpdGNoIChkd2MtPmdhZGdldC0+c3BlZWQpIHsNCj4gIAljYXNlIFVTQl9T
UEVFRF9TVVBFUl9QTFVTOg0KPiBAQCAtNzkyLDEwICs4MjgsNiBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCQkJYnJlYWs7
DQo+ICAJCX0NCj4gIAkJZmFsbHRocm91Z2g7DQo+IC0JY2FzZSBVU0JfU1BFRURfRlVMTDoNCj4g
LQkJaWYgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVwLT5lbmRwb2ludC5kZXNjKSkNCj4gLQkJ
CW51bV9maWZvcyA9IDI7DQo+IC0JCWJyZWFrOw0KDQpQbGVhc2UgdGFrZSBvdXQgdGhlIGZhbGx0
aHJvdWdoIGFib3ZlIGlmIHlvdSByZW1vdmUgdGhpcyBjb25kaXRpb24uDQoNCj4gIAlkZWZhdWx0
Og0KPiAgCQlicmVhazsNCj4gIAl9DQo+IEBAIC04MDksNyArODQxLDcgQEAgc3RhdGljIGludCBk
d2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIA0KPiAg
CS8qIFJlc2VydmUgYXQgbGVhc3Qgb25lIEZJRk8gZm9yIHRoZSBudW1iZXIgb2YgSU4gRVBzICov
DQo+ICAJbWluX2RlcHRoID0gbnVtX2luX2VwICogKGZpZm8gKyAxKTsNCj4gLQlyZW1haW5pbmcg
PSByYW0xX2RlcHRoIC0gbWluX2RlcHRoIC0gZHdjLT5sYXN0X2ZpZm9fZGVwdGg7DQo+ICsJcmVt
YWluaW5nID0gcmFtX2RlcHRoIC0gbWluX2RlcHRoIC0gZHdjLT5sYXN0X2ZpZm9fZGVwdGg7DQo+
ICAJcmVtYWluaW5nID0gbWF4X3QoaW50LCAwLCByZW1haW5pbmcpOw0KPiAgCS8qDQo+ICAJICog
V2UndmUgYWxyZWFkeSByZXNlcnZlZCAxIEZJRk8gcGVyIEVQLCBzbyBjaGVjayB3aGF0IHdlIGNh
biBmaXQgaW4NCj4gQEAgLTgzNSw5ICs4NjcsOSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3Jl
c2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAgCQlkd2MtPmxhc3RfZmlmb19k
ZXB0aCArPSBEV0MzMV9HVFhGSUZPU0laX1RYRkRFUChmaWZvX3NpemUpOw0KPiAgDQo+ICAJLyog
Q2hlY2sgZmlmbyBzaXplIGFsbG9jYXRpb24gZG9lc24ndCBleGNlZWQgYXZhaWxhYmxlIFJBTSBz
aXplLiAqLw0KPiAtCWlmIChkd2MtPmxhc3RfZmlmb19kZXB0aCA+PSByYW0xX2RlcHRoKSB7DQo+
ICsJaWYgKGR3Yy0+bGFzdF9maWZvX2RlcHRoID49IHJhbV9kZXB0aCkgew0KPiAgCQlkZXZfZXJy
KGR3Yy0+ZGV2LCAiRmlmb3NpemUoJWQpID4gUkFNIHNpemUoJWQpICVzIGRlcHRoOiVkXG4iLA0K
PiAtCQkJZHdjLT5sYXN0X2ZpZm9fZGVwdGgsIHJhbTFfZGVwdGgsDQo+ICsJCQlkd2MtPmxhc3Rf
Zmlmb19kZXB0aCwgcmFtX2RlcHRoLA0KPiAgCQkJZGVwLT5lbmRwb2ludC5uYW1lLCBmaWZvX3Np
emUpOw0KPiAgCQlpZiAoRFdDM19JUF9JUyhEV0MzKSkNCj4gIAkJCWZpZm9fc2l6ZSA9IERXQzNf
R1RYRklGT1NJWl9UWEZERVAoZmlmb19zaXplKTsNCj4gQEAgLTMwOTAsNyArMzEyMiw3IEBAIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfY2hlY2tfY29uZmlnKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnKQ0K
PiAgCXN0cnVjdCBkd2MzICpkd2MgPSBnYWRnZXRfdG9fZHdjKGcpOw0KPiAgCXN0cnVjdCB1c2Jf
ZXAgKmVwOw0KPiAgCWludCBmaWZvX3NpemUgPSAwOw0KPiAtCWludCByYW0xX2RlcHRoOw0KPiAr
CWludCByYW1fZGVwdGg7DQo+ICAJaW50IGVwX251bSA9IDA7DQo+ICANCj4gIAlpZiAoIWR3Yy0+
ZG9fZmlmb19yZXNpemUpDQo+IEBAIC0zMTEzLDggKzMxNDUsOCBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X2NoZWNrX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdldCAqZykNCj4gIAlmaWZvX3NpemUg
Kz0gZHdjLT5tYXhfY2ZnX2VwczsNCj4gIA0KPiAgCS8qIENoZWNrIGlmIHdlIGNhbiBmaXQgYSBz
aW5nbGUgZmlmbyBwZXIgZW5kcG9pbnQgKi8NCj4gLQlyYW0xX2RlcHRoID0gRFdDM19SQU0xX0RF
UFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM3KTsNCj4gLQlpZiAoZmlmb19zaXplID4gcmFtMV9k
ZXB0aCkNCj4gKwlyYW1fZGVwdGggPSBkd2MzX2dhZGdldF9jYWxjX3JhbV9kZXB0aChkd2MpOw0K
PiArCWlmIChmaWZvX3NpemUgPiByYW1fZGVwdGgpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiAg
DQo+ICAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoNCldlIG1heSBuZWVkIHRvIHRo
aW5rIGEgbGl0dGxlIG1vcmUgb24gaG93IHRvIGJ1ZGdldGluZyB0aGUgcmVzb3VyY2UNCnByb3Bl
cmx5IHRvIGFjY29tb2RhdGUgZm9yIGRpZmZlcmVudCByZXF1aXJlbWVudHMuIElmIHRoZXJlJ3Mg
bm8gc2luZ2xlDQpmb3JtdWxhIHRvIHNhdGlzZnkgZm9yIGFsbCBwbGF0Zm9ybSwgcGVyaGFwcyB3
ZSBtYXkgbmVlZCB0byBpbnRyb2R1Y2UNCnBhcmFtZXRlcnMgdGhhdCB1c2VycyBjYW4gc2V0IGJh
c2Ugb24gdGhlIG5lZWRzIG9mIHRoZWlyIGFwcGxpY2F0aW9uLg0KDQpJJ2QgbGlrZSB0byBBY2sg
b24gdGhlIG5ldyBjaGFuZ2UgdGhhdCBjaGVja3Mgc2luZ2xlLXBvcnQgUkFNLiBGb3IgdGhlDQpi
dWRnZXRpbmcgb2YgZmlmbywgbGV0J3Mga2VlcCB0aGUgZGlzY3Vzc2lvbiBnb2luZyBhIGxpdHRs
ZSBtb3JlLg0KDQpUaGFua3MsDQpUaGluaA==


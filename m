Return-Path: <stable+bounces-145925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2873EABFC26
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429541BC7E83
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBF927FB11;
	Wed, 21 May 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="p2pDPEru"
X-Original-To: stable@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61821D5B0;
	Wed, 21 May 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848063; cv=fail; b=rB7zl5FTdHwjITMPJjaebOL/bgwX2wXovX2PwJkqnkjLSX9RtJ/bvrQAhh/dxUDvhMXvkCjDsrZ9LIvB+fO0A69hGM0gAOqBsq3lOAG7bcif0X1zqe4XR/rD52O6lizH27UIxu/PwxRgcVX8LvMhHnrMHkABJPsHf6aER2jiPzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848063; c=relaxed/simple;
	bh=QkCJZYhZiIYYbngYl5jTqazHyLdFM7w76p/MZPYbrp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPQOVuZE0t399cGuQjrfOXsWKbqk5sP2VkZ0xTQGuxh3GqMN8VAElD0khHBYem1PaKldNM6OBeaVxh2kux+UnlZJmXqD9tYgqhcsXbGvRl28iFyUcIaPrNNYNtHeqyGCLUuvp4eDn0mwVcxL6V5RYpXgVkmtaKzt3Zj0eI+pKD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=p2pDPEru; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1747848061; x=1779384061;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QkCJZYhZiIYYbngYl5jTqazHyLdFM7w76p/MZPYbrp4=;
  b=p2pDPEruK3Z74vrgsbnWLs7K0FObO+ikqPLnwextgFI7KMgeQ7oijYm8
   /z2OHkIMKXWhwECk9VCyo2966T7c+lVdcSFIH5x7oFDQP5SS2LKhrhfDv
   e7JPC5JwOlqV1736dvgRfl+VxzS0McESaQg/BXawVKkbyTZN21jRkEaoD
   srYx8mT8GrwUl4afuxlbD+g7itLxPU5Fa34qIariR4jmcQNHH5O7yRfOx
   n6xM635xH2VkSMsgp1cuvYCnI9z0If+37TVcDKAQpjjHMk1XLJfaSlXmr
   xGuaH2bTATKSNa+6rC1yast1zlqVyWtyPmjZt/dD7rH+RUJXSnBzmr5oW
   w==;
X-CSE-ConnectionGUID: repQsnZxRxWOrZi2wdEYTg==
X-CSE-MsgGUID: UTaVl8mZTSqhKxHHr7MEAA==
X-IronPort-AV: E=Sophos;i="6.15,304,1739808000"; 
   d="scan'208";a="88684731"
Received: from mail-mw2nam10lp2042.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.42])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2025 01:20:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8ZxYARg3AFR37RlSvzrPdQ93RmAeFjwFmV9fa1ZMMDwqlge9F8CILoCrYCuPkrkbKEgYRHBLKHjjxKH4HYKgF86bukJwQq5vocAq5NjAlx3SPL3r2sooZgbyypkDzrhFUADwUMQav2onqrW6YrTS/RjWNTkVDWYoX5B68avVArmFEeB3E+UB0himQciWajAf+GhvsrUC6/7Z4ITGDPoBTYssAr+EdK9ecJxXVjxG8ryMDIcp8Mf8ZYG2ValUaOl1KdxRJgSABrlCchff6EZUZtMWz8XCVm5gIineHdGb/urm6gyYPebIM0dslnxMScm5oxl1rM0TRqY1Beom8Lzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkCJZYhZiIYYbngYl5jTqazHyLdFM7w76p/MZPYbrp4=;
 b=h73yP90lBPSpurjcvip2O5Us/fzhmjGc4r+Svw7n956AHvCOPK+WM1WDQhR1d+VT6HskiIyNwFz9FBlmpi3mvgsasXfX7LT/GA3wnF/k9xtgtj5gFcmbOGBGXDzQcZDBoCBK9CDEKb2es7LRRksuwb+yDNdudD4wP410BWGffSHAtShrv+7nJ/aV0zvTh7hhtPpQfJ4zt+3i58ydtEq+HWB1BDdl47Fh28TwBXoZNY65ExRkV0Zb0lU85fO+F6si1WCpM8EwbE3q/HAPOOiT3onuqWYmPTrhUzQW9K/mI8ic5c3LFcPynIGFo2tiI4EV3Qhs18XmsE/TzAsTZC+ivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CH3PR16MB5427.namprd16.prod.outlook.com (2603:10b6:610:162::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 17:20:56 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::436c:8204:2171:b839%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 17:20:56 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
Thread-Topic: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
Thread-Index: AQHbyk9gMf69PSrSlUqEnH/KutyM07PdGVyAgAA7QSA=
Date: Wed, 21 May 2025 17:20:56 +0000
Message-ID:
 <PH7PR16MB6196F07DFC8710E52C364ABCE59EA@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250521124820.554493-1-avri.altman@sandisk.com>
 <CAPDyKFr31jm8+DKLkmoQ_jfJ5q30x53t+SOmggjWtNsFLZdzQg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFr31jm8+DKLkmoQ_jfJ5q30x53t+SOmggjWtNsFLZdzQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CH3PR16MB5427:EE_
x-ms-office365-filtering-correlation-id: f3455216-ef4a-4af0-a2ec-08dd988bd8e4
x-ms-exchange-atpmessageproperties: SA
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0taQXB5WDVoZjgwc1NVK0JtQ0h0a3czWi9ndVUzMll6UkRhNHE4TEpTWXpr?=
 =?utf-8?B?QkcvZER0dHU5REJNTEJISy85Uzg1SE1zZkVMMzNVczRwemlLUEdGMlBDcDRP?=
 =?utf-8?B?RDFuV21hMjYzZ1ExekN1dXFGekRMT0NBckRKQ0swMmkrT3ZyanpHYnRaS1Bn?=
 =?utf-8?B?OTd1VjJwM21zQ01iMTZvbG1LZ2h1a1B5R0FqV00rdVR0VStwNXZTNUlQRkxJ?=
 =?utf-8?B?ZEdvd0l4KzZOUjZZT004amVxWkVIZllHa0EzYWRIb3lURjdsQlI1dlNQdko0?=
 =?utf-8?B?cU1ORm16dUNSOExaek8ySGJONFFFOGI2cFVaOXJGQTQvNjdjUDZIWEtZTVRq?=
 =?utf-8?B?eE1GaVpPZTZtQnpkU2hITnRuczBYTXlHY2tqbXA4K0tlNTVDQzBvMHowZExt?=
 =?utf-8?B?UzVEY08wTFd4bi9TcWFFTUxZQVpCMkpCbVhYM2I4YVhmMzVUNmpFRS8xVitE?=
 =?utf-8?B?NXJPdVNNSldTK2I2R1B1cmNUdjRYd254cVRDb05XQTMxV1ZTelRmbllEZUVt?=
 =?utf-8?B?UEhqR2dmMVRLUUtqMjZnVzVHZmU2MWM2WnhnaysxREFWalIzR3RsbmttM253?=
 =?utf-8?B?eVlBdTFlNi9pN1J6MjlYblMrMmNrRk4zZ3VWd1M3MVg1UUk3aE9FU09oWmlw?=
 =?utf-8?B?VFFRL1M4bkFvdjhKQWQwelEvYWMrZE5JYjRCVXV3SzRMTjdRdnZpVG4zQlhv?=
 =?utf-8?B?c2I5cks3QURnQmdqblV0Z29oUWFVMDZlWEhDV2QvSklXb0FlQXpiUHNWU1l0?=
 =?utf-8?B?OGRtNUhvVXFIMWRlU1JOem5SUEh2cTlwQW9pdGVrVk83L1VlSGNVbEVtTG03?=
 =?utf-8?B?OVIwMEpncnRLN3IrWU5xZ0MyeVR6TVdyYWJTTnNiMS9tZGlZY1VjWkdFYU00?=
 =?utf-8?B?ZGdKZjVKWHp6Y3EzNzFSNHhjV055SHordWM5OExQTGlhNDU5ZGJNMGZqTis2?=
 =?utf-8?B?dUZYR3Voc0xvYzNwdHNzQzAvY0o3cXpFRkU1bm5ITk0zT2ZoWUIvWEg3ekdR?=
 =?utf-8?B?aHZ4L0dhdXBEYi9xM0toL2p3UXFrMnBWa0JLenZicXpqQUdHUCtwN0t1cjFV?=
 =?utf-8?B?Y1RSRk1kdGV1Z3puV0tzemRBTy84WWd3YUpadHFqeHZWWTg0N0tJanJEZ1ZT?=
 =?utf-8?B?YWhwbVVJaDdoQjQ1RENhUC81cU5ndTQxTTRXdnFaSkY5Uk0zM1JVNkRJUFor?=
 =?utf-8?B?azQ4NFRYTTc2NmkvVG9aVHFYWmxPbnVzWFZmdlZlcERMVGMvSnd6ZnRsUmFS?=
 =?utf-8?B?cGJMYjgrTFNJVWYzeXZ6SDZ5TGdORWtkaEpGQnJoRXhoMXlYaDN2eUtYK3Nw?=
 =?utf-8?B?SnovL3RHeEhOS2ZkQVN1VlNYTERHQWZJM0xPRHRoN2wwZzZLWXlFVlI5Q0M4?=
 =?utf-8?B?ZnVHK0tPNlNvRmdNU3YvYnlOZ2huc2JkdE1aSkNXTDEyV0ZuM09yZFRIb3Zi?=
 =?utf-8?B?N1hCNjlpTW9iankwYWxGM2MwY0ZCUE5EaWpReFowWWxnRFozMUkwZDV1V2Rj?=
 =?utf-8?B?dE85V1hBTzlMUDFzenhYNHIrN3RuTFhDT2dKeXFOd2ZnTmpTTGVnUmxya29w?=
 =?utf-8?B?cDdiUWZYSGRpK0RSeTduTlBFT3o2aS9PREtBRGtDdTUwbDhHOVN3UndTZDFY?=
 =?utf-8?B?TG9mcy9Lc3ZkQ2dMRVZMWi85Y29GN3BOaFlIV210ODhYb3dDUE1OYktQVEls?=
 =?utf-8?B?TW1KTUJMdHBPSVhDUXovM2pLS2RwN0JjdVNJamxORmZvMzluZWlTSi9FdHdo?=
 =?utf-8?B?MEd0dEowUWhJTktycVM5MTZ6dHlUNURjelNGWHRpVkYvem9hRjJabEVnRnox?=
 =?utf-8?B?TlRmK2tINnhPUGlQMVBPSHNJVGxhVU5XczluVDNlVFRBSzRZWW5oVll2ckUz?=
 =?utf-8?B?T09BRGJOcmNIZVF4MWh0Ny8wT0xORU5xNlhRTGROallMZkZnRVZQa2pjV014?=
 =?utf-8?B?ZmpseEJxRVpKN3I4UXYxSkI4enVXdkdVQnFlN1lmUmdzQThsL2ZpblNNQ3Fu?=
 =?utf-8?B?Z003VlE3ZFdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHZ1QmlZYkRvay9YNlBhOHZvWnBFdkpIaFRxNENWd1V6ZTJNZTdVOXZqRy9j?=
 =?utf-8?B?NU5ERUREeE84VWRJUUx6NUQvN3R3TjZDRmllWFk4akZNRlNKUHBObjkzYjdt?=
 =?utf-8?B?RUZ0VE8yYUdSTXkwNGRpbDF1djhRYzBodXdIS0NlR040T0lGKzdrQ3ZYWEJE?=
 =?utf-8?B?Z0JOMVFFTnZsZWdOTm5FZEVxMkJSUUhoQ3IyU3oyaWFvNTNiRjlKZHZRS0dL?=
 =?utf-8?B?c25HeHZIK0xBNUVQZ1lvWWhxTnNxZDJiVnNVL1VOdXNZUi9iYlJsSjhYS0g2?=
 =?utf-8?B?TUNkN2xCRjZFclJPUS9hTXE4ODVkZk5QUWVuMUdKRnRzdmx0YlJ1MktOUWta?=
 =?utf-8?B?eWJreEkxR2Z4RUxBK3JyVTd3akc5RGNsVGQzRzdIWUZpUzZacFgyM3BzbFNp?=
 =?utf-8?B?SVBTZ2NYY0ZtRW00RHlJc29VS3BnYytGUzFDUFczcnA0aVY1ZnpGWEQwOUls?=
 =?utf-8?B?dnR6bFl3NDk1akR4cWJkcklwSWRuRDU0eHlpQ1NKeDZsM0VPWURrQ2R5TVdB?=
 =?utf-8?B?dUViMlBVOEY4bEtEZGJBZGJaUlI2SHd2WEpXTHJpenVMcUFaZElCckx0VDBM?=
 =?utf-8?B?U1dOcFdxR1dXOXBtWjJrMGR3WGtrY3FFdVpRbFJ0bENGRmZROGlTd3BCMEV5?=
 =?utf-8?B?UlR2SHNuQXNlQXN0TDNpcUtVOEtWcElLOUIvT3VJdGh4ZjJtMzFlb2xTTTlm?=
 =?utf-8?B?bGZqUFFkSy9kQXYxNHVyT3BVanZDU2w3YitPWEhOb2FPSnV0V1JRaVdIRUY3?=
 =?utf-8?B?SkdNYTNjQVZ0eGhBWGpGeFF3TE5hUnFNbkd0aUlDaFFQTTVkMXJNYnYvWTBX?=
 =?utf-8?B?QUJyc2tNbDZVeVl0UnJneUx0eHIyekR2UWZRbUJVVUd0NnprZWpDYWwya3Bo?=
 =?utf-8?B?QnVaZ1JZVG1jNG5RYWlWb0ZheGdCMmZ6M29UVUhmMHB3a21udEptc29nQXI0?=
 =?utf-8?B?NkprMFY4MGRwUDFrMTdOOEJPZUNrN1FwVmovdnQ0VDRvMElRNGIrMGkvM0FI?=
 =?utf-8?B?MVQrRngwMXlCenB6OFNLOVg0M0V1UFBKSGRJLy9VMDIyVytMN244dzJZY2tt?=
 =?utf-8?B?TGZDd3ZjTVFwaFNubFJnWHRVTXZnbkVhNm5JMkwxY3lzRDlWb3YwdXE5U0du?=
 =?utf-8?B?UUhWVXp3TGJMK1BHNjZNUHNRWjl3MU5TdHluenhoUVpjTGIyNFhld1h3NzdE?=
 =?utf-8?B?cnVVODdxZFFoM296Nld5MWc3aUoyMlJCVVd5dzRaWHdNZldMV0NWTmNwdWZO?=
 =?utf-8?B?MFFmdFFVdjRUU0t1Wll0WjVkQWx2MlN6NWVaR0NBV0gwVFIreFVIUDh0eWR1?=
 =?utf-8?B?a2ZDL1FRNGxxZWFYS1NERTNlUFVXMld0TmJRSmVLVUZOeDVZc0wrSTIwQkUy?=
 =?utf-8?B?S29JUGZyY3BiS2hUQXo5bTRxTjNFVjZ6Z2dzVm1Ic244UW9XeDBjK2t0NDFw?=
 =?utf-8?B?UGZFRm5yLzQ3ZFN0Z1k5M3ZKckEzbytMaHkzd05pR2xMYmRGakswOGw1V3JJ?=
 =?utf-8?B?cXkzWEFnN0xENU1jMHdLZDkrSllDamcvU0lCb2dRY0phOG1rdjUxRmJod1I4?=
 =?utf-8?B?TEFzQ04rMGI5Vk5TaGptM2U3MU8yUHo5bEt2QjJLUVZQaVJJL2F1V0RVTTdI?=
 =?utf-8?B?VHVnMDcrRVVtMEhWTkFTOTJCWXF0RHRjZDhIcTBsTk5YajIzT0lMaU15dExj?=
 =?utf-8?B?dUZKMXFmZTlhQkV1N0c4WFltSFBhS3FuaFNxNytRWmVXenRyWU9sV09pWVh4?=
 =?utf-8?B?aU85c3h0SGloWWZQYVVNQlh6c0tZb2NzK0hGbXkxeGFteFZqL2xkeG82TC9x?=
 =?utf-8?B?OXZOeUlrZWpnU2tYOVdpSHRNcWZzdVhJRkQ3a2p4ZDlKL28reWUwbkJ4OUVI?=
 =?utf-8?B?ak0wblZSSzZiS0g0TXhSWU1yTWVPczgxeTcrZm1XK2pibFpwQllJYXlKU3dv?=
 =?utf-8?B?dGFXL2xnSndIejU3WjBKeWxNUHNUekNVK0xlU3E5VlE3ZXBRQVFBZG1VRXlZ?=
 =?utf-8?B?WkxmWHVoMU5jNXRnMVprMXBIVWRLVWlqdEFFLzlqZkVXSUJseWFYdWZ3N2NZ?=
 =?utf-8?B?YkkvbkIyTG5mV0JnSE5QT3p4L1kxVURsT0t4NUdjNU9jL2Q1ZjA5Sk9acUQr?=
 =?utf-8?Q?CYix5aJlWXydoWu/B1U7+PCUW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	buO85Sq0szR5f71PCH1hXQvIkdmHH9D/JY9FfKzboChPZhcU6d4BrP2FsLOz7rT9K+jB79Sh8eoeayj1lNbeibXuxyDBE2dw51mlPVTODWj1nqq0+YzcWNea+9ZB9yORHGidfkpXH6pxgGymPhgUe0bc8qj0IlKSm9k2yMLAik57LV5ERDXYadCAzuSfroeQ/ORD08HWCpE0yZ8vWLYnYM8kfiERVFTcBYXVhKob5J1PTYvSyYnM4ccC0aV+aVoYiPyyORxqmGI4Du9OmC+jsy/0WJv6mHj3psOafaM2NtK6wFYAwy3qREZaTfIDQZ31mGEjuUgP+96oAN5dEO4Dn7FEpHLxGL5+h4Knl/45PpmTsG1mRAbuP3iMGzDbn680FpfhZavih9apg1xHQd6LTHKbBeK2YDsJkyaHW28G4T7XgHu80/8uJa2S2eZQ7MBHzlw0tEQ9Gxb5ua4nVgWouPEabC4Z7FP4wuZEp6MUvu0cZaWJXuXIFKDHKmXsSf0jaalCcFpEc1sYwCp2cn5aTk+EZWqHDN5pXgOUWsex4xSS6bSaETOaK7sWsmjXq9xX44CCP6HE/JYj2gMVHmELEc7NhDKc7iqFzKslUpN3IIiCfSuv1WJ68rX59BHuHjSmhzM/RNmDiqVZeDdbr/DiZw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3455216-ef4a-4af0-a2ec-08dd988bd8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 17:20:56.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CRxobw2YYAMfxGKSxbptAp4Poh5QXLDKN8TJw8+YBIusEVsOeOZJ7drQ1gFZghA5hMESE4uKTP8lgU+WHRdjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5427

PiBUaGlzIGRpZG4ndCBhcHBseSB0byBteSBmaXhlcy9uZXh0IGJyYW5jaCwgY2FuIHlvdSBwbGVh
c2UgZG91YmxlIGNoZWNrIGFuZCBzZW5kIGENCj4gbmV3IHZlcnNpb24/IEkgZGlkbid0IGhhdmUg
dGhlIHRpbWUgdG8gcmVzb2x2ZSB0aGUgY29uZmxpY3QsIHNvcnJ5Lg0KU29ycnkgYWJvdXQgdGhh
dC4NCldpbGwgcmViYXNlIGFuZCByZXNlbmQuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4gS2lu
ZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvcXVp
cmtzLmggfCAxMiArKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9j
b3JlL3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiA+IGluZGV4IDdmODkz
YmFmYWE2MC4uYzQxN2VkMzRjMDU3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUv
cXVpcmtzLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4gQEAgLTQ0
LDYgKzQ0LDEyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVwIF9fbWF5YmVfdW51c2Vk
DQo+IG1tY19zZF9maXh1cHNbXSA9IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgMCwgLTF1bGws
IFNESU9fQU5ZX0lELCBTRElPX0FOWV9JRCwgYWRkX3F1aXJrX3NkLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICBNTUNfUVVJUktfTk9fVUhTX0REUjUwX1RVTklORywgRVhUX0NTRF9SRVZfQU5ZKSwN
Cj4gPg0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIFNvbWUgU0QgY2FyZHMgcmVwb3J0
cyBkaXNjYXJkIHN1cHBvcnQgd2hpbGUgdGhleSBkb24ndA0KPiA+ICsgICAgICAgICovDQo+ID4g
KyAgICAgICBNTUNfRklYVVAoQ0lEX05BTUVfQU5ZLCBDSURfTUFORklEX1NBTkRJU0tfU0QsIDB4
NTM0NCwNCj4gYWRkX3F1aXJrX3NkLA0KPiA+ICsgICAgICAgICAgICAgICAgIE1NQ19RVUlSS19C
Uk9LRU5fU0RfRElTQ0FSRCksDQo+ID4gKw0KPiA+ICAgICAgICAgRU5EX0ZJWFVQDQo+ID4gIH07
DQo+ID4NCj4gPiBAQCAtMTQ3LDEyICsxNTMsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1tY19m
aXh1cCBfX21heWJlX3VudXNlZA0KPiBtbWNfYmxrX2ZpeHVwc1tdID0gew0KPiA+ICAgICAgICAg
TU1DX0ZJWFVQKCJNNjI3MDQiLCBDSURfTUFORklEX0tJTkdTVE9OLCAweDAxMDAsDQo+IGFkZF9x
dWlya19tbWMsDQo+ID4gICAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1RSSU1fQlJPS0VOKSwN
Cj4gPg0KPiA+IC0gICAgICAgLyoNCj4gPiAtICAgICAgICAqIFNvbWUgU0QgY2FyZHMgcmVwb3J0
cyBkaXNjYXJkIHN1cHBvcnQgd2hpbGUgdGhleSBkb24ndA0KPiA+IC0gICAgICAgICovDQo+ID4g
LSAgICAgICBNTUNfRklYVVAoQ0lEX05BTUVfQU5ZLCBDSURfTUFORklEX1NBTkRJU0tfU0QsIDB4
NTM0NCwNCj4gYWRkX3F1aXJrX3NkLA0KPiA+IC0gICAgICAgICAgICAgICAgIE1NQ19RVUlSS19C
Uk9LRU5fU0RfRElTQ0FSRCksDQo+ID4gLQ0KPiA+ICAgICAgICAgRU5EX0ZJWFVQDQo+ID4gIH07
DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=


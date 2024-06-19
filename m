Return-Path: <stable+bounces-53793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10AB90E67B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240B81F21D10
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFC770F5;
	Wed, 19 Jun 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3T16FTz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945907E0E8
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787821; cv=fail; b=WXQ3d3U3pSQIeZvrDTy8KUy4jOQ6MHXuTi64tjdtNlXwSAEpwRvOTUR2Mtcj3RX7JTslJme2jLHjJki+XuvJ36X6sLuN/Hpvsvh0H0fFz8A/DXjzw30e9b/uJaxgvkV3JP0176Y/DfVwLx6G4dMglah8sVa8d8DLHDytV7DMq7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787821; c=relaxed/simple;
	bh=J7yYyrfqVcHlUbjTxbWBjbr/uTuFU2idU562c1gBCQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAXPpYhcxIQxegPi6fFsSw3PqZ7l7Rxq54cHN1FtxFq5c9ye8gd/T9+zGWopHlpi5iaTA89R7XsQTMHRRq9BNhPyYEKMqxVa//wtf9iWxHRV/MCNeXN7zpj/s4L827/3Mt4TGCFnYGTS7rHk62/ygwWBSy4sgg/bGTRqAwnIhuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3T16FTz; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718787819; x=1750323819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J7yYyrfqVcHlUbjTxbWBjbr/uTuFU2idU562c1gBCQo=;
  b=K3T16FTzoKV/6Nt8FlhCBJqYs0y0VQl7YD3b7vpEbzvv1HP+jJgkr93z
   WWEroy7+2JCMTFduNXzPMAFAa3tqcellmt27wrcqDARXtR5d9bvltDQ2h
   rhTxetCN7ZyfRXuusmSvWPcFTG5n5uUM8aF1toGyKgtln58vUBeoPFFYR
   ZgfAmrr12a37NTLIb2TDDRchFfvJVsfnC5g334UXC6D4cL7PHDLb8rOEL
   Fpl7Yu3Zst80lJwBCrbmd4aRiEXQz13bNCmibghX/9mvqDRFBfWqLGu7b
   F8ZMhXwNGsaxk5RKwzCLakJ47nZ8AMRuN77ibVZwOLZr9TGaZR7ulQrjL
   w==;
X-CSE-ConnectionGUID: YBfXAANzRQax6fEDUCH9aA==
X-CSE-MsgGUID: gLVeHxvqQZW6A2GaaMA7Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26394079"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="26394079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 02:03:39 -0700
X-CSE-ConnectionGUID: V1qPWAreTnyqHpPeM9mfmg==
X-CSE-MsgGUID: l74kHqolSt6Xu5P1v5eZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="42560932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 02:03:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 02:03:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 02:03:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 02:03:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 02:03:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwYy4QI60Ji0VEZyyWdeqREFH3VihMgtByLGs2mJuCRTcyzqN3I0CEWGz3iO83dAE1gqgHfK4vC2se+oIHZEmmFQVtixN7pN7R1LpJ+X23YMU6u24gZfE7/0e/ROFjVK1x5gw2+0LQRcyCsd9K0t8CL0fLxcJyk8/ohDF/grYNXL5gAdhjSqTXSwS5nH3raQGfi53R2xxaAovY0VLQp25rlbW3hTtBkPJ75O1QuV3Axa3yTNmnL4qlkuhce3GLYfdGQBkzLb01UydBGuVOnbuluaVYFa7OnqCwhKzE1VSV35sHYc7/dtntm53EhihHqw+d2JN12kV45q5Xi+AvEPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7yYyrfqVcHlUbjTxbWBjbr/uTuFU2idU562c1gBCQo=;
 b=B7s5PVxf4OaRVu34NAGEA6fbSbxfJIFXbZF4zY3X/HA7q6tkj7qqFFZYFistCeHNqIt0bAScI3PK5qhsuv5n1ZjS7wPgIFYcxo18IZAnSn3pSB1FbJC9x06lDjEtGCpJx29YauWa2qCACAa7B/lzYyGOyk2KU0vEEpozaoDsDeFQkn7uaBZdzDn1Naeh+Ww6J7D73SU7gPnYzOVj62gUpMfCzjvYl8NL9UMyCwXSKOrjR4oSxY9qntkz0UUqoP5N2gXaL9TDgiCA7Q7NH0rvdRWWHcWtSaZTHOLv6UgNhXnyFRNpwFtVhOmHkxxiyNzivxHjSj+LYes0hb8HVzc7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 09:03:34 +0000
Received: from SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b]) by SA1PR11MB5825.namprd11.prod.outlook.com
 ([fe80::41f9:e955:b104:4c0b%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:03:34 +0000
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Korenblit, Miriam
 Rachel" <miriam.rachel.korenblit@intel.com>, "Berg, Johannes"
	<johannes.berg@intel.com>
Subject: Re: [PATCH 6.9 1/2] wifi: iwlwifi: mvm: support
 iwl_dev_tx_power_cmd_v8
Thread-Topic: [PATCH 6.9 1/2] wifi: iwlwifi: mvm: support
 iwl_dev_tx_power_cmd_v8
Thread-Index: AQHawXAQSGe6xIJCJE28fwoHbeszNbHOyN4AgAADV4A=
Date: Wed, 19 Jun 2024 09:03:34 +0000
Message-ID: <832c8e0030465c6356097eb04a98f922cd152ab0.camel@intel.com>
References: <20240618110924.24509-1-emmanuel.grumbach@intel.com>
	 <2024061917-kinswoman-nylon-c35f@gregkh>
In-Reply-To: <2024061917-kinswoman-nylon-c35f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.2 (3.52.2-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB5825:EE_|MN0PR11MB6302:EE_
x-ms-office365-filtering-correlation-id: d7177649-afd4-41cc-5d7b-08dc903eb2dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Vk1IcmY1VlJzNzVQMjR3UnhWTGhHYWlOTFY3WmpqYmQ5WjlsaTBkd1NzQWxQ?=
 =?utf-8?B?YVJncnVqV0Uxd1RTSTQ5SDd5Z0lnbDhiNjJIZ3ovTVhVRFRGL3NwVXRZMWMr?=
 =?utf-8?B?akxGWEVSNVNIL1h4bU1IMFhmczc3a1pjdFd6WDFZUERLM1FnT0J1bUVHcTdR?=
 =?utf-8?B?MStuamZ6R1BGTExISTVnSmdRbVE0RWx3VFFONGhGNmVOWVdRRHNoRDJhSE4y?=
 =?utf-8?B?UFFNSTMvVGdHVXZ0VmZYclBMWVAwdFpGa1RnMjRkMHhlR0N6QWpoTlZ3OUJx?=
 =?utf-8?B?SkJ6dGhrbTVvUlVVS3JabGplTktQR2s5djNwR0c4cFZQVUJDNVBPSFZhNEEw?=
 =?utf-8?B?akNhT2lLbzRyc3pIVGhjVTJlU2x4anpUUW9QZ2ttRW5lS3hhSkRqcHo0cllq?=
 =?utf-8?B?VGs1bmlaWHpuOW8rZDVMN2JTQ1FTQjc4aFFpa3FJbkpzTlJVZmlvZGRYbkZS?=
 =?utf-8?B?ZFRTTEpaeUYrbjFnOFBIaWZxRS80K1prazFmM0RUK3I4STBGckNlUm5vZkhZ?=
 =?utf-8?B?Smh0Qm5UajdGWFhZN21NYnhIeU80VjNOVXJGVmVwQThiRk03Zm9ITGJXbDBD?=
 =?utf-8?B?YnQzT1djM2VtNVZENzdha2lQempZcGRVL3AwUTVvTFJGc3g4WWwwdit5YzZ1?=
 =?utf-8?B?NVdSb29hQjQrZnJUelVsM09KZzRBMXlwRjB3aVh4ZGFNTUcreXhLYi8yM2V4?=
 =?utf-8?B?QktmYkFGYm4xL3NYTjc0ZHBHbDcvK3FYUHNSbmFnSXBZalZDaGx0T0ZCL3Nr?=
 =?utf-8?B?ejVVUGlsMkxNM2lHaWJBaUphY3lUSVkycTJLV05TQnJNNjJRU241bGFTMDUx?=
 =?utf-8?B?Y0x0OXJxQUlzZVIwY3I4bk1iaFYyWXMwcGplWmk0TGlUQ1RNQXdVRUFyMC9M?=
 =?utf-8?B?U3NDR1g3aVBVbnV4VzFJVXh6YWFmWDdFSDI4Zm9OTVNvSXhWVzhNMC83dklN?=
 =?utf-8?B?Um1pWitPcHkvMDkvOGg0QUREcXFuYldKQW9Qd0xzcTd2UWFoajk1aGs2Y2Zh?=
 =?utf-8?B?RTd4dFZaQm1WVU9PSVFmVjgwdncxT0Q5Sno1aEVXME9WZWxWQTQ5TFRLcU51?=
 =?utf-8?B?UXBsaFBPMGNyc3JOS0lLSGZBd0FGVVVJQWNvVFY1V0N4VThiWFEyR1MwSk5R?=
 =?utf-8?B?YWhrc2VyZlVqTTdrckQ0TWpHYkhMSlZSRlVvcEFjZzFibGNBNFBWTy9qMXIy?=
 =?utf-8?B?ZWRnVDY0WmZmS0sweVVuM0M2VHNNQ1dNMDlmNEgxSytTbWZmaUh6THRNY3N3?=
 =?utf-8?B?aE1GSVZDWitrdzdpaFRFOXV1UXJrZm9UbDZPOWpTOFkveHpYSGJNdVJna1Vy?=
 =?utf-8?B?aVd2NjdiaGlCMGg4aHA2MGJLSkNDbEI4YmJlUXdZTUd1YU0rSFJWMWNwQXpJ?=
 =?utf-8?B?d3Ard2Y0OU04VlhYNUJMbWRLK3ZxbkxOcTQzNmZqT0grVm5ZejBsb0k4c3FD?=
 =?utf-8?B?VGd0QTJ4bGJhVUIwSm5BMDFjNDczSWxCU2dZaXJ1NXZOSDFLa01xZnVXbHdP?=
 =?utf-8?B?d2plM1JDYXdkOFozc0ZORCtWazAxZGlCeWdROW14eUwxQ2hPbWwyUGlGVkpq?=
 =?utf-8?B?Zk83MVNzVnYzOU9obDFJLzhsVXVkVHBmNkVmVnRyS05LZ3Baa29MT1gyNkIy?=
 =?utf-8?B?OEMwdCtsWDJONkJHbFFWNnJkVUpJK251czVQcnJ3S3ZCNHR4eWRmblVBQm9W?=
 =?utf-8?B?VG5uZFJQbkwvVTFyT0lDbDZPd2F4Y013ZFAySGQ2TzltMC9idHdyaE45bGwy?=
 =?utf-8?B?NWJ6TzNxeGVvamxmNm5uSG1wNDRQUVR6dmNYYzl6MEJGNmIwTk5PSDZWMDgr?=
 =?utf-8?Q?3AxoYLXYubGfXDmWhuAkMdwgmXdMKdy4pOsZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB5825.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9hc3ZFQUVkdEpJR0NtS0dpKzhCaWR4T1hvYmpYV3JNVloxZ2xYTGo2NEpD?=
 =?utf-8?B?VFlON09jUUdNWkVGV3FNejhVc1BhMFBvUXRXQTNnSTFxWDJZR2d1YUVndVk4?=
 =?utf-8?B?QlFnSUZ1N0hFUnBDU0p5TG5mNDErL2cyWEsrUXRwc0lDSkNhWHpGa2JYQnZT?=
 =?utf-8?B?YkRkZUppeVR3SURWdzFnVDBTdHdtMDJ2WFpKWHFUWWRXMFZTUTRHS0dzWTU3?=
 =?utf-8?B?cGUxbWdRTGNsamtrSkQvNTdjdUdYdlVnNkNIOWY3THRwK3RIYlQ2WTRFRWYr?=
 =?utf-8?B?N1BXakVoNjZXNlBKRFR4VUxVbTAyUURmZ3ZwVEt4U2ZZbE5ScG40RFU2aEVm?=
 =?utf-8?B?ZE16Z1MwQ0g2SVJSbTdPcFV0R3VPdjM3cGFTRDJqS2JaNGFFUk5HeDFFa3hz?=
 =?utf-8?B?bTJKYVVuY3ZBS1hvVmpacVA0MStoQThVVW5yTEVVdFZDTHhJOGlybU9IUkcx?=
 =?utf-8?B?YmcrbWxvRVdoMSs5VkU2d0pBS2h6NHZKOFhad21OczdxazFJUGFOd2F6cFBV?=
 =?utf-8?B?cDYxL0ZVSXJ6NGxJeTFYdHRkdnBoQXVxUmdudnR2Q2RubjVMQ0p1N21aSk5o?=
 =?utf-8?B?ZUZCZ0NLTEdqczQ0Vi9NQ2hrNFJMeDNGZkg5OEdIcVh2ekRUbmo4WGdLN2Mr?=
 =?utf-8?B?ZFQ1WVE5SHJYenI3K3hISFpZN1pndWNhU2UvUHl0MzJPMWZKWVEzUnp0b2RQ?=
 =?utf-8?B?b1RhUG15N3J3cWJWS3EwQnBGTnBPMkJ3L2c3VWZhSmpyalpTd1JtSnRKdU1F?=
 =?utf-8?B?QTgxRHkyTm1uS0V2b2FwTVpURENkZjRDZXVRK1BxRHJMRkJpR1dQWVdUREU1?=
 =?utf-8?B?MEtPTVk5ejBqbkNEMTU3dUhjUEhaWkt6emt5MjYwUUd3ajFER0NDRWtsMXFs?=
 =?utf-8?B?ajJtcmU3U2NYbkVlcXNGbDVaTTlod2tTQWo5M25Hc1NOeDYreHZnN1FOMCtD?=
 =?utf-8?B?QnVGWHJGZ0Q5ZGt5SWhRZU11b01wOFBjYWNCWFMwbWs0bmhTR29sN1lZaGpM?=
 =?utf-8?B?dEUwVW11T2YwSUJ2WFZBQm9WNmV4dlZXcEJ6dHQxYkNmV3FBeG5FeHlUcllV?=
 =?utf-8?B?d1c2TkxNejhZTW1Sa3JNVEpxellvOWx1Vk1tNXh4TnhPT295RUIzcWVWT2dW?=
 =?utf-8?B?NjNnekdqZmhjUjI0OTljL1JHc2JoQlBPNGsxZERkZlFMVThtNDBzejRnNWdn?=
 =?utf-8?B?MHdUN0haZTFLcHBZOG5scVppTWFwSzcvVXNDYXF1KzFPbEdTVVV4b2NobWRr?=
 =?utf-8?B?azlONGQyYmtUcUpIVk15cW9tTkkwQUx4ZFBSWUt5dmlySlJCTUZWcTF5V0kw?=
 =?utf-8?B?d0hFSERKL2tmVHUrSHA3QWp2bDFPUHhNSDJNSjgxTFZ2M1BKYXY4WWhQd1p6?=
 =?utf-8?B?b2hJZlNCRTdKcjFpcmNrN01QaTUrZGttbFIvUU1VQ1hXNlZLUVowTVNLeHgv?=
 =?utf-8?B?K3NuQ2wwWXpxNGJvcVQ4UzZJYVJtWWNzbkZTZkgvamlnMmd3WlBORXV3bGdF?=
 =?utf-8?B?SmFXdGRpVmp4bnNPU0lKMnpVVmp1OU5LTmo0QUw4TlpSTGJyQXNSbzdLTEls?=
 =?utf-8?B?bzdRVEp6MUpvaWRWZkoydXdWNVl2ajhINWV3emN2VTlJam4zRWF6ZUFLVDU5?=
 =?utf-8?B?ZURpUjNjZkpObGMrYVJyUFNhMURnUVhpME15aTFFSzFtcEdmRVBNcTN6MU45?=
 =?utf-8?B?RjZkZDdKYTVBYnJGRzdBMjFzSzZjUzVlZ09CYzR0Wm1lYjluNVpTWDI5ODN1?=
 =?utf-8?B?VG05U1AzRkZIbVpERkdjTklQTjV4UG11ek5GaXZrL1ZWNnRVLzRJWi9qY1di?=
 =?utf-8?B?SXNpVUtqbHpkcU8xdVhiVU1hZGtMTG1xcDdybUpiYUVtd0hrRXNzdWs0NDdM?=
 =?utf-8?B?dmhvaXZLSW5ITVA2SmRzL2JoS3pUTWpRMzAvd2lGTXBsdys4SVFuTkRFMDkz?=
 =?utf-8?B?SjNXSStLQ2NrRmZZZVdjbHpERnBkdnhJcCtrS01YZHdmN1dvUkhVanI0aENx?=
 =?utf-8?B?UExoeDZNcmNtR3IvUERWdCtuWEgzS3pBaFlBWklLNTBTbmJmLzRqVklCdkJT?=
 =?utf-8?B?d2JIb3ZHY1JjdnZlKzI4YWhkaFZqNDVzSUpLTTNvWEVhV1JVVWxKaGZBaG1t?=
 =?utf-8?B?c0dsamJwdXZWb2VLUjVkZVZUTkNzY3BBQnZHSTNkZnFiZ2hEWGh3SkRqVEZB?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE059462C2DEFA47A5F2864FF49A80B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB5825.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7177649-afd4-41cc-5d7b-08dc903eb2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:03:34.2704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTV9LS3cdXEZBsCTMwveuzjizVvDYwde38POl4EJ+fOWol9+edYETSHQ/sNUt/zg00rvqkC5uaGWvVEc/x0gbXAApZFbwqmcVjigpcbpXcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA2LTE5IGF0IDEwOjUxICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBU
dWUsIEp1biAxOCwgMjAyNCBhdCAwMjowOToyM1BNICswMzAwLCBFbW1hbnVlbCBHcnVtYmFjaCB3
cm90ZToNCj4gPiBjb21taXQgOGY4OTJlMjI1ZjQxNmZjZjJiNTVhMGY5MTYxMTYyZTA4ZTJiMGNj
NyB1cHN0cmVhbS4NCj4gPiANCj4gPiBUaGlzIGp1c3QgYWRkcyBhIF9fbGUzMiB0aGF0IHdlIChj
dXJyZW50bHkpIGRvbid0IHVzZS4NCj4gDQo+IFdoeSBpcyB0aGlzIG5lZWRlZCBmb3IgYSBzdGFi
bGUgdHJlZSBpZiB0aGlzIGlzIG5vdGhpbmcgdGhhdCBpcyBhY3R1YWxseQ0KPiB1c2VkIGFuZCB0
aGVuIHdlIG5lZWQgYW5vdGhlciBmaXggZm9yIGl0IGFmdGVyIHRoYXQ/DQoNClJpZ2h0LCBzbyBJ
IHRvdGFsbHkgdW5kZXJzdGFuZCB5b3UncmUgY29uZnVzZWQuLi4gSSBzaG91bGQgcHJvYmFibHkg
aGF2ZSByZS13cml0dGVuIHRoZSBjb21taXQNCm1lc3NhZ2UgdG8gZXhwbGFpbiB3aHkgdGhpcyBp
cyBuZWVkZWQgZm9yIHN0YWJsZS4uLg0KDQpUaGlzIHBhdGNoIGFsbG93cyB0byBoYW5kbGUgYSBu
ZXcgdmVyc2lvbiBvZiBhIHNwZWNpZmljIGNvbW1hbmQgdG8gdGhlIGZpcm13YXJlLiBBcyBleHBs
YWluZWQgaW4gdGhlDQpjb21taXQgbWVzc2FnZSwgd2UgZG9uJ3QgbmVlZCB0aGUgbmV3IGZpZWxk
LCBidXQgLi4uIHRoZSBjb21tYW5kIGdvdCBiaWdnZXIgYW5kIHdlIG11c3QgYWxpZ24gdG8gdGhl
DQpuZXcgc2l6ZSBvZiBjb3Vyc2UuIElmIHdlIGRvbid0LCB0aGUgZmlybXdhcmUgd2lsbCBnZXQg
YSBjb21tYW5kIHRoYXQgaXMgc2hvcnRlciB0aGFuIGV4cGVjdGVkIGFuZA0Kd2lsbCBjcmFzaC4N
CldlIG9yaWdpbmFsbHkgZGlkbid0IHRoaW5rIHdlJ2QgbmVlZCB0aGF0IG9uIHRoZSBmaXJtd2Fy
ZSB2ZXJzaW9ucyBzdXBwb3J0ZWQgYnkga2VybmVsIDYuOSBhbmQgdGhpcw0KaXMgd2h5IHdlIGRp
ZG4ndCBxdWV1ZSB0aGlzIHBhdGNoIGZvciA2LjkuIE5vdywgaXQgYXBwZWFycyB0aGF0IHRoZSBs
YXRlc3QgZmlybXdhcmUgdmVyc2lvbiB0aGF0IDYuOQ0Kc3VwcG9ydHMgZG9lcyBuZWVkIHRoZSBu
ZXcgdmVyc2lvbiBvZiB0aGUgY29tbWFuZC4NClVuZm9ydHVuYXRlbHksIHdlIGxlYXJudCB0aGF0
IHRoZSBoYXJkIHdheSwgdGhyb3VnaCBidWd6aWxsYSA6LSgNCg0KTm93LCB0aGlzIHBhdGNoIGlu
dHJvZHVjZWQgYSByZWdyZXNzaW9uIHRoYXQgaXMgZml4ZWQgYnkgYW5vdGhlciBwYXRjaC4uLg0K
V291bGQgeW91IHByZWZlciBtZSB0byBzcXVhc2ggdGhlbT8NCg0KPiANCj4gSSBjYW4ndCBzZWUg
aG93IHRoaXMgY29tbWl0IGFjdHVhbGx5IGRvZXMgYW55dGhpbmcgb24gaXQncyBvd24sIHdoYXQg
YW0NCj4gSSBtaXNzaW5nPw0KPiANCj4gV2hhdCBidWcgaXMgdGhpcyBmaXhpbmc/wqAgQSByZWdy
ZXNzaW9uP8KgIElzIHRoaXMgYSBuZXcgZmVhdHVyZT8NCg0KU28sIHllcywgaXQgZml4ZXMgYSBi
dWcgYXMgZXhwbGFpbmVkIGFib3ZlLg0KVGhpcyBpcyBhIHJlZ3Jlc3Npb24gYmVjYXVzZSBvbGRl
ciBrZXJuZWxzIHdvbid0IGxvYWQgdGhlIG5ldyBmaXJtd2FyZSBhbmQgd29uJ3QgaGl0IHRoZSBm
aXJtd2FyZQ0KY3Jhc2guDQoNCj4gDQo+IGNvbmZ1c2VkLA0KDQpJIHNob3VsZCBoYXZlIHJlLXdy
aXR0ZW4gdGhlIGNvbW1pdCBtZXNzYWdlLiBTb3JyeS4NCkkgaG9wZSB0aGluZ3MgYXJlIG5vdyBj
bGVhcmVyLi4NCg0KPiANCj4gZ3JlZyBrLWgNCg0K


Return-Path: <stable+bounces-225510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOVmNqC7t2mpUgEAu9opvQ
	(envelope-from <stable+bounces-225510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 09:13:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB5B295FEF
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 09:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1D2300EA8A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72756355F3B;
	Mon, 16 Mar 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2FPrWiM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA334DCCC
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648796; cv=fail; b=sQOe8LiZkpXuYT09Y7RoVsoGrNgbO0YtBB4egQrVlqaOt5L1wqDbuA8B8dpgWNOW+d9gUUq1zxHk64Cbl2ZugauOWP4ZWhcv/QW3U99aYTZr+Mfib4ktbq/tSDt1DLfQr8+M4yG3Izcyic/oW5yNg2WYhQxDpZQ8HWnzJV6EVdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648796; c=relaxed/simple;
	bh=ey2khlhdwk+D+Y5RhWI6obHYQfmiCbVICckokWTN2xc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lqgj8iZ9kxPpJdIlSboQd/hpnKDQFEdfOxeSaeDrp5hcPcn3J0f4/t6HDeiy/0t6oAjEGMciu9rkWN6lZXr5a5kZzdYjfEq7GL+nyulBiBsxEzynE2V93Pbg6e73sroK4mRRbhXqJVRofhZNmIJL7IC+MmKb2QurQsKmgZfavs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2FPrWiM; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773648794; x=1805184794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ey2khlhdwk+D+Y5RhWI6obHYQfmiCbVICckokWTN2xc=;
  b=E2FPrWiMJgHF80foqlEzTIUDq3w94FrL/JLI9BNIkUyrFbTTZ+ilGpSN
   fkCD0b+J+owI1fptpj3rti7wExZSfq3cHxx+r4DSRYc/Duq/t5RKBEBAG
   4rlHehWc2NTwR547mNJfFpecspAr1cVCvtpDDVB5YNNohrsxCb8E86Hy8
   4MZMQ4iAbOX/8bucDDTyzk+jWeE3Vpjfm3JG1HH2N4jKMrJYcRS9yeew/
   DwOielJrVM8xWh+AzopSi9Q1jYzJYiAtBjLq/9MFVaMKdMnDnaZAEp/Sd
   gJlqwHPswSd4sEmjCnwY3nqkiw3KG4ZkwMMkYFELsoflOlSFWHhuB4/kT
   w==;
X-CSE-ConnectionGUID: xyRdGNgRRamNHL9tiJv1Fw==
X-CSE-MsgGUID: HsDnjKVHR+m3peEb/qF5IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85358578"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="85358578"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 01:13:14 -0700
X-CSE-ConnectionGUID: dynEwn2ZTTOV/tinMUaKwg==
X-CSE-MsgGUID: lkv2afo4R2aqjKVngFVR9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="220884348"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 01:13:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:13:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 01:13:12 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 01:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo8Yug6/WkIQCvxfTW/s2Vlo1SPJJG1sjCBn3yi305mMeFxIWZj9/q5hbYs4bQargoz51yVZzCKrcQ5AlNvocA4ADQLHlV+HF9ligQEoSvSzQXL/YaODqWGpogMGYxxShrw30zIElT/bC2QwINJYuCGiTuz94m25xL1668SBMyLGNcVttKctXRTkty9ZEHjAfBQbiGoogoZS8RHUKbDSWRldwF9RTMVlPjWFxUNsvHHIwuAdCkvvsaKhSVCvLaQma6zPFrnRvnROz+6h3s/6rJyqibPkl0ef59Q1oDHwlM1Lte+zhGMN+yxQPnEAEXKzrl/d93xcRiOFI5dtHW1vRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey2khlhdwk+D+Y5RhWI6obHYQfmiCbVICckokWTN2xc=;
 b=b8XbIq0YpW20hFVt3yolKyAOc3w3Lk3RHBj90BIxfK6p5R/aUFMVkeEMmLESK2GhAcIVRY2dXh11QeEogbO51tvLelhASpuxe5hKN71p4YAbWC03d+IAxXZi1Ihh2o7ZY+J+1cVwoO8Cb/AniYBdKQ2C4EGi1P2iy8K0/W021XM3EXfsU6jYDw+e6mRNUP25aE/zypPMrwqOD8nXT6J8jcoFkejJu0VKIF4hTBvFE+ItvCGQWOzpCp9Diu5DhSTddp2n94bryiyvFVJdabCq+YRJKHBLhlwt8Th9yNWqP7VE7qXUFKfdTY8MJu/jkfaZ9OdcF3s3reTEQ8hPjN9x5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f13) by MW3PR11MB4539.namprd11.prod.outlook.com
 (2603:10b6:303:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 08:13:09 +0000
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::21ae:7048:11eb:3faa]) by DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::21ae:7048:11eb:3faa%6]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 08:13:09 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Hogander, Jouni" <jouni.hogander@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Hogander, Jouni" <jouni.hogander@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/i915/psr: Disable PSR on update_m_n and
 update_lrr
Thread-Topic: [PATCH 1/2] drm/i915/psr: Disable PSR on update_m_n and
 update_lrr
Thread-Index: AQHcsf3keObfOEsVW0movMWqIQ6/V7Ww1Saw
Date: Mon, 16 Mar 2026 08:13:09 +0000
Message-ID: <DM3PPF208195D8D344DEBE27C4DC65CE946E340A@DM3PPF208195D8D.namprd11.prod.outlook.com>
References: <20260312083710.1593781-1-jouni.hogander@intel.com>
 <20260312083710.1593781-2-jouni.hogander@intel.com>
In-Reply-To: <20260312083710.1593781-2-jouni.hogander@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF208195D8D:EE_|MW3PR11MB4539:EE_
x-ms-office365-filtering-correlation-id: 149833ce-29f9-46c6-d22e-08de8333dc3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: BBsjbYSg/nqcyT/vwm0NmtyuYE6gNRo+YUgtlCd9HCmMKnPVYWJsRm+MAXXnwhn1NPlCWNTn9y2vS4OrJBNU8CJjdNp/iVMB5HxmoEmTkl4Llrw4xc10uLXKCS6YFetwA+08O/sPuHrK4nyI3KJJa/PmkIwrSojWwpp9DQyTQqtOSxX3IBmNU23nVAvbGbyQL+EW85ER9obUbWZtnKopzS5e6icbMANf3q6ELeyA4/RO5wOodcsabMO0ZgOYGdNRWTNxCUDTY8AqC4BNmBWbNEQk2tZ8/LOEKjTuJ3VL4DGeiiBvKvkj51/cPDoWgo8NLgOdjGrQYapIpxpTumf1S/WdeEhEeN31jaU1pe2Ch5DeNthDBZlbw58g+h0dBwGR/1F96hyIVzTN0GPJFso+qpb15apSuGFWqIZ1oEkZtWmBTzKapSQq4gVpTWTWXyjvhtNdM4nYY7QDcjW5UihzU5yxqtixAS8Sj+xzWGaCHHGYIWUoSQ+PTmIjuYIm68GaNAqrhz1kSQrd2e+udOVwo7y5fqdBkaw+Gz+IziZzPVVPmA2L2MXFYmmswkRh+FTmW2EkBaZOBizTSfrOZRKmzdD9z+wsvfRGIK5W6LlhHCIt5t/wQPRp/vhYOdcoz1N1B1t/QDnVwmRoIeAGD1ixP7SUQpLMADvNTo04eCsTIQmLX+N3AGX+QcxDQijEqL+xUQwFazAf+a/WgxktIPvI0z/7Ppj5oPT8CQTCXzP9OwM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF208195D8D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hxNmpKVG5KM2c4TVhoT1RXMFZna1NVMXhYSWFYa3NoaTEzQVp0RVFxQ0RP?=
 =?utf-8?B?b1dkNktOQ0NnYnJkZE9Lek9lS3JLd2dOZ0VnU2ZIYWZLYjN1b2poM2F0V2xW?=
 =?utf-8?B?eXBLVjd5UVR3TmVSa2hnWGJsempXTGVaMVNMamZ1VzlBR0NnYmFnL3lEdllR?=
 =?utf-8?B?bFN6ek80VG1oak5ROGlCWkRoOEdyWWw5Mm9xYXBNd2JXQ1Rma0Z1b2JheXZn?=
 =?utf-8?B?NFIrRE5wSXdvMkJKSEFEc1ZUWmhNaWxoQUVBUytyeWgzSC9lcVZXa1VUK253?=
 =?utf-8?B?VFAxRFB2dXdDUjJaSjR0c0hZbXl6NGNVWWk2Wlk0b2ttc3NjUTFvSlBaT3h2?=
 =?utf-8?B?VllGQjVYU3U3RzN6NFUzT2dhM1FpZyt4Njgrb05tWmZxMXFNbTBiZHZML2tX?=
 =?utf-8?B?TFpXZjV1bHEyTEpBVHlNejBpL2VQL2d3SXgwRjJaUEJEdkJGTzlyTFhxSytv?=
 =?utf-8?B?czdrQWZCM3IzSXJkNUVXYXhwdlhWRTBiLzNZMnd6azRhQjkvQ0p3WFdva21S?=
 =?utf-8?B?SzhCNDlYa1c5a3dVdDZ3ZGhUK2hnUmFwQ3NrRWtWOTZ3K016RzF2SWNlVXRh?=
 =?utf-8?B?aTcwazh6UXlqSUhCbWJ2WGsxSVg2T1ViTWR6VUYzQ0E5VnZsK05GN3g4R0Nl?=
 =?utf-8?B?aWxLVS9TSE5uMzJOcjV6cUs2bVN6ZTVlVldPdVp2UFNiNGNHd3hEUUM3QmNm?=
 =?utf-8?B?VVVLTmNOOFJicVprV2tzVHoyWTFOVTROa3lOV0I0a3g4RUp5ZE0rM1ZYUFNl?=
 =?utf-8?B?bno0VkZIU0VucmhlSU5nUXBnQkJzb0FkUEhLVVk3YU9oOWJNNURUbkthRHlh?=
 =?utf-8?B?N1N3RE1IOHRqZml3OFc2MGU5ejNBSkZPYS9vL1JJMGduWVRhUzdkVHNJT3Zy?=
 =?utf-8?B?bzFZTllrVTlsS0svUEsvc3ROdEE5UndFRTZEeWwzbHF0YVhrbU5UaUQrRlA5?=
 =?utf-8?B?VWhadnc4RWJyamVoK2dXSnhNZGxTVnh3dTJ2cTByWWhpMXMxMGRIZytpZitX?=
 =?utf-8?B?eXBheXBPRkprNVBqU3lXOEpzREdJbHZEVmZjRmNZMzdpM3Y2WC80RzVWU0xJ?=
 =?utf-8?B?Yk5tcUlKZEZvMHpHREZNY09nZHFUMENjMFFqZnJwNFl0Vk5pWkx6MFdjUXlL?=
 =?utf-8?B?eDdVcE9sRFRodThZNStieHR3SExHU2UvTjliKzBNdnhmRzdsTlZRYWdGbnov?=
 =?utf-8?B?SzcrbHVBNy9MTTVjUkN6Z01za1A3NTE3NXBEdDJ3VzNaWTRyd2V5Szc3QWxi?=
 =?utf-8?B?dnUrb0QzdDFFVmhFM25ZUFBId3k3aC8zaVBGdERaa09PeEpmN2R5dThjK05L?=
 =?utf-8?B?TWFTdXl1VkI4OWRWV3hBU0VKLzRZL2M2S0NiQ01OVVl3Z3k1dlY4K2k1Rlhs?=
 =?utf-8?B?MkdvOHduTCtudkpXTHJ0ZW8vMHlxQnh4MzVMNEJHZU5yVG92M2RsUUV4bys0?=
 =?utf-8?B?czliQlRNcjRyU1RUQjdlRUhaYWFTeC9rRXAyVHRkaXFzZHZmZm5ZVVg2Z0w2?=
 =?utf-8?B?MUowS1hKb1g1Mng5TXBobUE5dnBqdEJDbDE2NXdxQ2paMWFyQTRxOVREY1Ex?=
 =?utf-8?B?RzZXY3VyeWxwaG10aFc0SWY4TjRYb3ZYaElRVFBlN2haY2ZOSVM2SEk4blh3?=
 =?utf-8?B?Y2hTYjI0TGFQbzBNUWZnY3RFMmdiQ0wzZTJlbDdSd2RnU3liN1lVWlhtdGRV?=
 =?utf-8?B?Z3F4UXFnSFhwdldKVWtpTjhoeFdJclRYK3lnM1Q0a3lXVlNSVTUxNURabm9S?=
 =?utf-8?B?OWVGU2dlWXE0Z2xaL1lXVzRKNTllWTNVK3V4clRSRUtkbTJKbjl1cFpHd3Qr?=
 =?utf-8?B?K2FFOThxRWZyUm1nWW9zQlI5YndpMko0bkZHa2x4ZWUxZXBoUWhiaWEvdVMx?=
 =?utf-8?B?MWNuK2xGNkM0QTR6ZVVTY1gzLzNjOWdXVjRVMi9mdGNoL1l5ZzhJVi9LZWMv?=
 =?utf-8?B?THRoZHNRTzE3MGlHMG9DR1NFODZGMkg1eTBZUFVnazZwUFNwOEpVczV1VzBT?=
 =?utf-8?B?amwyWHJNY3owQjVSR0k0b2p3WVpYZUwrbit2ZXNwVW9WbnJXOWNreThKaTVp?=
 =?utf-8?B?blN0K0dHQ2c4V0lsOGc5Z1gxZ0NRd2VtaVhXTU5pT05VTE1GR28yT0VhbmVK?=
 =?utf-8?B?N2pmU2VJaFpqdlg3b2o2M2RaOUVnME1RbjBBYmRWY0o1R2NZZk0zdWhUcTBI?=
 =?utf-8?B?OGtzQm1HcWdhdkc0dHJIV3ZTZFRWZ3dIUSt6aDEralc0Z0lvUS9SWktNeFFW?=
 =?utf-8?B?angzeDJvYTViSVhNQU1idlJXdkE5VUZRcVhqYmVzYlpGSXRGVW8xS1JFczZs?=
 =?utf-8?B?T1NOTU5va0NCaDUyTlZwVm1oNFIzZkFOOGtINU5MUS9xRDdqa1V2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BRzoGDlG8yOEf34FVXyjcd6c8SEv8fcsqHc3Qo/oJdKrxUv2NpyzKhSYB8ktBzldNOtOqBzoW+cHvgEkcdkWAjndlvDBCkYTXdjbmvav8hxEZxVQIhzPZSDP9abnJ8AuqVJAvL4RsVoyjaEjGh9ChjC/u5nyH19HaMT3lmcSItnbtbjJ5l6pzwmDHLJYoedohloCAAm/Qei/DxaFKBPt2LyUnME33ycNCKlmS0p75PbyXhZHnPhTSrOf5Rq7iV7F+EVQ83UyH3bNdgJsV3GsdwQCgZSvnEmUxm4nKRpqPa7dwUWwhATY9gmk1pND3fQ23RPLokH36N6gE0ENuydrdw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF208195D8D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149833ce-29f9-46c6-d22e-08de8333dc3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 08:13:09.4168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyM4C+6OZSdoY5YS9lgbyHSgSY5M/32Zr7HB/IhXj58VFplfTeYWJQ6+ZqNZWW/0EGksQZxM5YGw7BZ02XTqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225510-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DM3PPF208195D8D.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kandpal@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5DB5B295FEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkcm0vaTkxNS9wc3I6IERpc2FibGUgUFNSIG9uIHVwZGF0
ZV9tX24gYW5kIHVwZGF0ZV9scnINCj4gDQo+IFBTUi9QUiBwYXJhbWV0ZXJzIG1pZ2h0IGJlIGNo
YW5naW5nIG9uIHVwZGF0ZV9tX24gb3IgdXBkYXRlX2xyci4gRGlzYWJsZQ0KDQpOaXQ6ICptaWdo
dCBjaGFuZ2UgYmFzZWQgb24gdXBkYXRlX21fbiBvciB1cGRhdGVfbHJyDQoNCk90aGVyd2lzZSBM
R1RNLA0KUmV2aWV3ZWQtYnk6IFN1cmFqIEthbmRwYWwgPHN1cmFqLmthbmRwYWxAaW50ZWwuY29t
Pg0KDQo+IG9uIHVwZGF0ZV9tX24gYW5kIHVwZGF0ZV9scnIgdG8gZW5zdXJlIHByb3BlciBwYXJh
bWV0ZXJzIGFyZSB0YWtlbiBpbnRvIHVzZQ0KPiBvbiBuZXh0IFBTUiBlbmFibGUgaW4gaW50ZWxf
cHNyX3Bvc3RfcGxhbmVfdXBkYXRlLg0KPiANCj4gQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2k5MTUva2VybmVsLy0vaXNzdWVzLzE1NzcxDQo+IEZpeGVzOiAyYmM5
OGM2Zjk3YWYgKCJkcm0vaTkxNS9hbHBtOiBDb21wdXRlIEFMUE0gcGFyYW1ldGVycyBpbnRvDQo+
IGNydGNfc3RhdGUtPmFscG1fc3RhdGUiKQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
ICMgdjYuMTkrDQo+IFNpZ25lZC1vZmYtYnk6IEpvdW5pIEjDtmdhbmRlciA8am91bmkuaG9nYW5k
ZXJAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfcHNyLmMgfCAyICsrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9wc3IuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gaW5kZXggNTA0
MWE1YTEzOGQxLi43ZTBlNGMzYmY5ODUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9p
OTE1L2Rpc3BsYXkvaW50ZWxfcHNyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlz
cGxheS9pbnRlbF9wc3IuYw0KPiBAQCAtMzExMiw2ICszMTEyLDggQEAgdm9pZCBpbnRlbF9wc3Jf
cHJlX3BsYW5lX3VwZGF0ZShzdHJ1Y3QNCj4gaW50ZWxfYXRvbWljX3N0YXRlICpzdGF0ZSwNCj4g
IAkJCSAqIC0gRGlzcGxheSBXQSAjMTEzNjogc2tsLCBieHQNCj4gIAkJCSAqLw0KPiAgCQkJaWYg
KGludGVsX2NydGNfbmVlZHNfbW9kZXNldChuZXdfY3J0Y19zdGF0ZSkgfHwNCj4gKwkJCSAgICBu
ZXdfY3J0Y19zdGF0ZS0+dXBkYXRlX21fbiB8fA0KPiArCQkJICAgIG5ld19jcnRjX3N0YXRlLT51
cGRhdGVfbHJyIHx8DQo+ICAJCQkgICAgIW5ld19jcnRjX3N0YXRlLT5oYXNfcHNyIHx8DQo+ICAJ
CQkgICAgIW5ld19jcnRjX3N0YXRlLT5hY3RpdmVfcGxhbmVzIHx8DQo+ICAJCQkgICAgbmV3X2Ny
dGNfc3RhdGUtPmhhc19zZWxfdXBkYXRlICE9IHBzci0NCj4gPnNlbF91cGRhdGVfZW5hYmxlZCB8
fA0KPiAtLQ0KPiAyLjQzLjANCg0K


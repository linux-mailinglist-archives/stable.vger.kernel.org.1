Return-Path: <stable+bounces-192931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B5825C4648C
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 364D1348042
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019330E849;
	Mon, 10 Nov 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOgCc3Yo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2B30B533;
	Mon, 10 Nov 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774319; cv=fail; b=sqfF5CzYdwkUePXRGH0TGGpwY7FovkmsC2bsZYZJnTGKl1ypBcxmck/pjok8Bgcob7eJKiFB8ZkQzhFs5A15Hnb1OC2e3j3KZd43SgrU1kSl3EnyPA5LUURaMMQxsBHhrHlwac2YPcrxWk2XJG7JAzz9bnHV9M9FsQitGXE1lEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774319; c=relaxed/simple;
	bh=2GU/DLEoi0e7EsOQ0mM0rk4nY81pIhrS0GIhkMmfzfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZ58F4/dpnhcOjCd0DEhxFC1/aJhI03EMYotYOMmPTc+Q5B4xH+Sw8yvHEN++Cfnx2RtBqsIoKcQ5+9JyVaIeQ74ro6DwdfMP5NdbRaKNYKTJD1Fei9KLv12nF61JfFDMCcQnFHvTnL8ZRIkYxFL0S6d8Wh8pYeUSEqHPBPDnX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOgCc3Yo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774317; x=1794310317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2GU/DLEoi0e7EsOQ0mM0rk4nY81pIhrS0GIhkMmfzfY=;
  b=KOgCc3YolQJdkgXDNv99wPQ5QA3vTT8D0XFc1kwq17rHs+E8mNUt8Ju0
   Pn9aXW3dlWT53qZgCOV/6h7OCdBFy4P4dOSOFz66rpKDu3kNUSi4udwQq
   ZI7ru3bXHfZwtIPsAtex80l4xWDVTUzUUApwgdPmhjlU80Bo8G3+5ekDM
   xEl1V7uekLudJh8Nqh8tMmFhbUmTHwUdO7KI4FH0CgeFDMK1gQTRptyBt
   xKaw9txfDvGgobrtKkeUPnIvLwrBiA63JoMYi9sy+MTid7H9RWSJjD3+c
   RS3ccoeRitMvzw/3qVFuGJBHRZhX7CMWwnmGk2acw7gL1rEQPR1xQ2Roj
   g==;
X-CSE-ConnectionGUID: XjYFCdKzRFinqqmykDcdVQ==
X-CSE-MsgGUID: vN9mTnaaQ/emRGX1h7sO5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="82220424"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82220424"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:31:57 -0800
X-CSE-ConnectionGUID: GikWg80cQjmQDE8BwcA8Sg==
X-CSE-MsgGUID: X8KD46SAQw6QxWW8ENTYWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188394900"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:31:57 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:31:56 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 03:31:56 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:31:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmspxunUgaWaZZT45MwNNjfI9VqtL01K4SOhxvf9bh/LpL3mQfWFofAOBxOedCc2GQ7wAWxb9ipYzckyzH2kES3uhfWifTCGMXnWHIHZfHRmSB1o35wR2I7g1b7FL+H/IC/0lLVmv6tKn8WZf0zLUczxxnkgq/H+IiQF7SL+Yt9ICcNt1uOUdPuy5lstWlC3XtOByg6NpgBxMWpCXCZ4yxIVS6y4ML8ohhrGIoNpmPW/CabGcXDyxdDagt1G3ClougqMJBNz5upj3UBSRpy92FrWrxdr1GijkiPnjecHDlRF9WVFA9dSfweI2a45Dw3VdfQiNfCwpT4C3MfEyz0DIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GU/DLEoi0e7EsOQ0mM0rk4nY81pIhrS0GIhkMmfzfY=;
 b=sx2M1iT+Iam1YsmIt+0GmQtEN4JiElNPy8Mq6Z5kc7MibZB3eHIHE8+skcU08unD0doqXf6fskGka/fKxhAMmZy9rNVIlw2v2gxrMWYArc+5I+EC/I7aIZoXlq6ih9LG6okSW24UaGDuTPDGnmD309GtfaT9fqHK8Dr5in5RajzeOQDqg58kRH0356to4PORVWiQybyHUoz69j7VfI4SEYFbBA6yI9BdCBf/rBcOK+vRdpeEdEhFUw5QZRE9qY4Z4zyBoq+3KQMU1n1mURwl/L7XWqTprxXxlbgrOs2djKYpnUnjRawk5ve806X1wFgTkDRExV0K7qwtARKfFrOWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by IA0PR11MB7934.namprd11.prod.outlook.com (2603:10b6:208:40d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:31:54 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:31:54 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, "arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mei: Fix error handling in mei_register
Thread-Topic: [PATCH] mei: Fix error handling in mei_register
Thread-Index: AQHcTS8EwGubr+8Kc0CiA9fzKU7LhLTr0KQA
Date: Mon, 10 Nov 2025 11:31:54 +0000
Message-ID: <CY5PR11MB6366D9CA2C95D23DD1BF3D9BEDCEA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20251104020133.5017-1-make24@iscas.ac.cn>
In-Reply-To: <20251104020133.5017-1-make24@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|IA0PR11MB7934:EE_
x-ms-office365-filtering-correlation-id: 14b06319-6975-4195-1e20-08de204cc019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N3dxOUhTamF6bjJ0THVVTmM1cHhMQkVrZ3Z3blVlWlBmNzdPcmEwOHdoUzZR?=
 =?utf-8?B?MEJtbjk0MEVwWHUzUnh1Mzh1eTk4R0tpS2FFRnRRQmFTUDFvRzBhcllYN0dx?=
 =?utf-8?B?TW5zckhWZVZKQmdjTjg4cFY0eWh6T29md2hHOEpESk40NmM1d2dKU3FsaU5l?=
 =?utf-8?B?bFdoa3U0MTlqZ2VIYVc2dHh6RHBDd1NsUFI5SU1nYjVndnpnTEM3eHBDcFdK?=
 =?utf-8?B?cVNHaDJ1VGJsSlVpQ3prRlp0WXd0bkliMjY5WUpodzZWSU53b3VYenRKMDZl?=
 =?utf-8?B?MjBMOVpXcTNDRDMyL2hXNXB2R28ycmZBeWl0QWJrdUc5WnNoeE16a3dyaC9x?=
 =?utf-8?B?UCtVZ0NoYlcxUGdPTVpGMVlHeVZ2V2MzZ21sTzY5OW9vNURuQWhaL0ZtaTNo?=
 =?utf-8?B?TVVoRTJDLzBFOTRzUzB2SmMrRDhLZ0xWd2IxL2JZYUtKanh6ZERRUjNGTjhO?=
 =?utf-8?B?YjQveS9lZWREZXkxZnZ6OFFRUlE2ejdnT01GWThHVVJJMTV4dkNXUGRpUFAv?=
 =?utf-8?B?Q0JQejlYYzJLc3l4MnR5SWtHbWt3YlVyREZOZWJyUUY1T05oRmZEakY3UUFT?=
 =?utf-8?B?ZkVSWFZyYkVnVndBUFo0aVR1amFYSm9GYytETkY5UlRHM1phVU0zQmNhWnlL?=
 =?utf-8?B?Y3FSS1Evc1pDYys0eFNYNm5venZES3FzaGJjcWpQRlQ2Y29QeWdtVmc4aVRT?=
 =?utf-8?B?NStFZWUrdDF1ZVczY2duSmlORm1GeXhNaEpuUVZuNVNUN1FmZmZ4QTBNdmli?=
 =?utf-8?B?UnNvQXFpdi9KYVAxeXBZbmhOc3ZpVHUwZUtSNUlQaUJ3cXJCNEhaUmUxVWRq?=
 =?utf-8?B?N1hDRmVCWnlBYSt3UDBDN21RK0hpcDFrUE5mTW9UUWpoMUtIVTJZWFJ0Y2Zj?=
 =?utf-8?B?QnNwakxSRWFGUXJDV2tmK2ZpTE5nUGdHVW0vbG9vYWtJV1JjbTlGU0xUUDhL?=
 =?utf-8?B?bFJqTEQxNEVjdXhXWEpsYXJla2dROGNOWjZTaDNTQ3lPYk5kWXRJZGtmK20z?=
 =?utf-8?B?QjZmWUxSdGI1ZVJkSkZoUTBDR3FjTFlQNk52NXBrYzlYVFBmcGsrVUhWR3By?=
 =?utf-8?B?SC9ocVlTMXJKOHF6SHorTWFvVmYySm9lVis0dXJmME1YcHNrOUNUTmpvUktz?=
 =?utf-8?B?VkVmY2ROczAzbDJDOFQ4bnVTdUE0V0p2azhWT0pWdEU5MTFlODZYY2sxKzZw?=
 =?utf-8?B?NEhPYzZhN1oyc1NsdkdSSDA4emYxeVM2TDc0c3lCd3h1cmJGbFpTTHZmN0RL?=
 =?utf-8?B?N0ZaZzlqWHBVM3A0aUVkTlhsTmQ3RGVNUDVISGFCUGU0dE56SzcvUzR1Tmph?=
 =?utf-8?B?NTVHZ2ZreVcyVWRnN2F1QzZWN0JHV2VoWlpRYUVVLytFK2kvOE92ZkVEdDB5?=
 =?utf-8?B?UzIxVThNMVhSQzJEaWkxTERlMDBodjdRU0FhbHJwdHF5dWFQMEpET2ZoYVFZ?=
 =?utf-8?B?QUM1UWdMQjF5WkNoWXM2V3BUbFM1UWxDTEwzSzgwbzBtMHp6OTc0M093SDdT?=
 =?utf-8?B?UzRaWEozemVqY3N4Tk5USkdHdkpnQXZFaXlTWGpZU3ZLUXBQeHhjSUk3cWJ3?=
 =?utf-8?B?TGtoUVorR0dLU3VTa3c1OXB3OFQrU21HZkVZV0NWYkxObnF5VldSYUd4aTdM?=
 =?utf-8?B?bmIzaG93Uk9PYzMySjRkNko2ZzhCN0xhQytwZGd5Uk4wTlNxOVdNSE9PcXFL?=
 =?utf-8?B?YTVILzBSa2dNSzV2bi9OQWgxSmNqVnVqaHcxM0l6K2RWSGFpbDdHV0lpcU1C?=
 =?utf-8?B?aVhEeTVZREVhME1SRUxGbkRlNUp4YTJDYVZCMExGTW5pV0JIb3M5U1pIdDNT?=
 =?utf-8?B?dTIwZy9EYXluQlRtb1p2WTIyNGhWT2lOSE5lcTVleWlKbjY1MFBjZ01Ed1Jz?=
 =?utf-8?B?T0t4dTBla1dwU3U1a20yK3NZM0hCTU1EaWMrVi9CRCtSZGxLc2RJc25XallK?=
 =?utf-8?B?bzJkRUhiem9qRDAzY3ErakswTW9zMXFZV0d2WW5yNnR0dHBxRTJ2VXFJTlha?=
 =?utf-8?B?ME5rVGNyYWNkV2ZLbllpY3pySVlZWDdoc3ZOamJqRGpXYmxIWVB1cVBiWGg5?=
 =?utf-8?Q?pD4Rlg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2UyWXhhRllrOXNWSC81OFIxQVpnd3dQbTRSSUpPUFdFS0lKOXBFcjM0TVVy?=
 =?utf-8?B?b1FwcXV2UXA1TjNxT1c4YjR6ZG9IU3RrOVM3d1NWM3lIZjNkTkVNd3d4dnJ5?=
 =?utf-8?B?Ti9DSVRvcFBPcDRWVFRZMkc3UmlyaXJNWXJhVUdEOEpvNFhpUGlUUUlNSTN6?=
 =?utf-8?B?ODJUQklBWXlsYkxybE0vM3hxakVNRld5MldtbzNUaE5RTS94amNHRFVoSlpv?=
 =?utf-8?B?aHFLUVpBRUFkbjNEUms2WFp2eFMzWWJDY3FhbHV4Q29qL2dCMGFxUnM2S3NE?=
 =?utf-8?B?aS8rMVlCbmJvaHluMjNGNVZ5K2RBclVoaXB1Rk9hZXdQOEl5WnowUTJRSkpM?=
 =?utf-8?B?ZjQ3MXFjZlkxOVF2OGt2K2QxOGlKZExvKzhmNXAwdW4xVTA5eFZ0Y0RKQy9o?=
 =?utf-8?B?TitLV2Rzc3ZNM1JCSmRNaDNNWE42YjczaFpXWm5uQkZFNmlJcGNIU2tWd2ZC?=
 =?utf-8?B?eCtQQ3FMTCswRjJVdjJjaVRJdldweTByaWlWOUpXclpYYktLYUhObUYxZUhR?=
 =?utf-8?B?aHA3ZC9nMzFHVXRVeFRoQXRSWGRNRzBsRCt2K1M2ZHhGNjc4eCtiY0NlT3B0?=
 =?utf-8?B?N2JvODNhb3ZCbUN3WGFETDBjQ2xsa0ZlYXc4a2tHWDh0K2NtdnVlS2hQTnQz?=
 =?utf-8?B?akxXVmZwZUJHUlc5bExlS2FtNVpYSzFub2VYckhSd2hYZ0tQTDZsNm9lWEcv?=
 =?utf-8?B?a2ZJZmIwd29wQnY4ZkRmTGRrTG5laTlvQmJVM3VqQlJrcGpub3ZWTnJZd28r?=
 =?utf-8?B?VkVWZ1FZUXJkL0lKeDBJUjdyVGp3cEkrbjRaTFNGN0YwRlN4bmtFVGtaNDdK?=
 =?utf-8?B?b0FxUldGdHNYTDBnMG5nSFJtcWcwUVhmb281YTF6ZU9FOU1iNkdyeTVhS1Zp?=
 =?utf-8?B?MTdFOVM2NzRQZU1SZ1pXSE54WURjUDVUaUtMVDdSVitpOWU1aVNpUlhrZVhC?=
 =?utf-8?B?cVNOK2swQ25tQVdIMUJGeUZjdG85RnVVVk8xR0h0NXlzekNRWFVxUDZ0dVVy?=
 =?utf-8?B?RGtTNDBacEZwZmVzeFVwandxcHEycDJheE1UOXd3QmcyRW14RTNzd2pDb0I0?=
 =?utf-8?B?SGlmUXRKZVRnQTJCMFVoZ3l0cXJFZUxWL3dGUzJTQ1N1OVE3a0R2U1hoQ3ds?=
 =?utf-8?B?SkNNaFZqd0xubEJVNjMwR0VzMkN1WUdxYzJxT3FXZk4vWmNoSGtkbnBVN1Ni?=
 =?utf-8?B?MlVHN3hXNDRCTEpFTlhvV1F4aWk3T09PQVp3bCtrUmxGUjNraXZ4YWJYUFRl?=
 =?utf-8?B?R0VkZ2t1SWtNYmFnVG96R1hDSUx0bk1iNWJVZkZNQjZzUHVGY2lRL09xUzNB?=
 =?utf-8?B?NVpGMzk5N3lvc0Y5aEZjNHYyaUVGMXN1ZG4yU1hkYXRLait0NXhQd1BjTXc1?=
 =?utf-8?B?VStlWng4YlRQTkkxTjVHSFdicktuc3d1cUhxczhtd3h1MHZCaXM0OU9HNGNr?=
 =?utf-8?B?Mm9ZVVVMZHZXeW05RVhVSzY1aXdZZlhNVnltWkt6K05haUlkTEpkNDlGMDNS?=
 =?utf-8?B?dkgyQ3l3UjZ4ODllRFpjYjF5bHo4SEo5R01nZHl3Y2tRcHNZMkVYRWxlVDQ5?=
 =?utf-8?B?TWllWlZ2Q1YwZ2ZaWHdjdC9mVys4ZUJmUDZuZGVnY3dxeFZtbnRxT1pIdG01?=
 =?utf-8?B?WTY4aThRcy9nSko4bGg5Ui9mRFFScVVQaXRLbmI4YUtpaXozcUwwN29Ndytx?=
 =?utf-8?B?eElqYXVuM3VSWGczdVlKUU5RMllXTWhkNmY2aWRjNkx3M0dxUStvZHFzS21m?=
 =?utf-8?B?Wmo1U1BsSU1KczMyQnBHQkQxdGhnaXM0R2NQS3RSZC9UMEpETHpwWENlcXN2?=
 =?utf-8?B?MTRiNHFELzhuSnYvVjdZU0hWeWNxcitpalBpakZHa3FPVGR0MUZJay9JdVpl?=
 =?utf-8?B?SHhZRXlTWVIrRE5yVGp0bm5PSGkwNzQvRnVZVy9BTVR4QXRFYkVWTk9lL1BS?=
 =?utf-8?B?U1pINmJpUEFLSkRBd0M4OWc1cmEyUEJ1OCtrWXFMMG5BdWRNK2lOL1JOMGNm?=
 =?utf-8?B?eGhiVVQ3d3o4WHVNM0llZE8vaFB1ZkVWM3Y5SS8wM241UTIrTC94b1ZtcHMx?=
 =?utf-8?B?RzVxamJSbW5qREJteXI1UERZVGFXYnByUFpsZ0c1ek1JM1pvcVB4Y3RLUDNw?=
 =?utf-8?B?ejZsbDBEMk8yMW0rTjJsTkgwbjZMSUc1Q3cyRmpJRmNCbWNLRmhIcFZBSmRU?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b06319-6975-4195-1e20-08de204cc019
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 11:31:54.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UT6PvTqaDt2zEHp2QKBhKXrk8g5d3j5Zmxeq0u/aj0Un9cRqpWQP2suNvUWzEK0iXgQTYeFA42kvuegz6iFt+lIjXzT8pNkb58WZzEFmDCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7934
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0hdIG1laTogRml4IGVycm9yIGhhbmRsaW5nIGluIG1laV9yZWdpc3Rl
cg0KPiANCj4gbWVpX3JlZ2lzdGVyKCkgZmFpbHMgdG8gcmVsZWFzZSB0aGUgZGV2aWNlIHJlZmVy
ZW5jZSBpbiBlcnJvciBwYXRocw0KPiBhZnRlciBkZXZpY2VfaW5pdGlhbGl6ZSgpLiBEdXJpbmcg
bm9ybWFsIGRldmljZSByZWdpc3RyYXRpb24sIHRoZQ0KPiByZWZlcmVuY2UgaXMgcHJvcGVybHkg
aGFuZGxlZCB0aHJvdWdoIG1laV9kZXJlZ2lzdGVyKCkgd2hpY2ggY2FsbHMNCj4gZGV2aWNlX2Rl
c3Ryb3koKS4gSG93ZXZlciwgaW4gZXJyb3IgaGFuZGxpbmcgcGF0aHMgKHN1Y2ggYXMgY2Rldl9h
bGxvYw0KPiBmYWlsdXJlLCBjZGV2X2FkZCBmYWlsdXJlLCBldGMuKSwgbWlzc2luZyBwdXRfZGV2
aWNlKCkgY2FsbHMgY2F1c2UNCj4gcmVmZXJlbmNlIGNvdW50IGxlYWtzLCBwcmV2ZW50aW5nIHRo
ZSBkZXZpY2UncyByZWxlYXNlIGZ1bmN0aW9uDQo+IChtZWlfZGV2aWNlX3JlbGVhc2UpIGZyb20g
YmVpbmcgY2FsbGVkIGFuZCByZXN1bHRpbmcgaW4gbWVtb3J5IGxlYWtzDQo+IG9mIG1laV9kZXZp
Y2UuDQo+IA0KPiBGb3VuZCBieSBjb2RlIHJldmlldy4NCj4gDQoNCk5pY2UgY2F0Y2guDQpBY2tl
ZC1ieTogQWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCg0K
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBGaXhlczogNzcwNGU2YmU0ZWQyICgibWVp
OiBob29rIG1laV9kZXZpY2Ugb24gY2xhc3MgZGV2aWNlIikNCj4gU2lnbmVkLW9mZi1ieTogTWEg
S2UgPG1ha2UyNEBpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MvbWVpL21haW4u
YyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9taXNjL21laS9tYWluLmMgYi9kcml2ZXJzL21pc2MvbWVpL21haW4uYw0K
PiBpbmRleCA4NmE3MzY4NGEzNzMuLjZmMjZkNTE2MDc4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9taXNjL21laS9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL21laS9tYWluLmMNCj4gQEAg
LTEzMDcsNiArMTMwNyw3IEBAIGludCBtZWlfcmVnaXN0ZXIoc3RydWN0IG1laV9kZXZpY2UgKmRl
diwgc3RydWN0DQo+IGRldmljZSAqcGFyZW50KQ0KPiAgZXJyX2RlbF9jZGV2Og0KPiAgCWNkZXZf
ZGVsKGRldi0+Y2Rldik7DQo+ICBlcnI6DQo+ICsJcHV0X2RldmljZSgmZGV2LT5kZXYpOw0KPiAg
CW1laV9taW5vcl9mcmVlKG1pbm9yKTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAtLQ0KPiAy
LjE3LjENCg0K


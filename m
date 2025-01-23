Return-Path: <stable+bounces-110273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA6A1A4A6
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D86A166359
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89EA20F088;
	Thu, 23 Jan 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="AkS8C7lH"
X-Original-To: stable@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35920F081
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637738; cv=fail; b=LePggOoAq/xhgQnaLsJZh2QKqwpO3IlGdEDsReZTl9Y/0wRy4LV8TooGlBFNfgrCfkrkxLxKfaemq6y0XfvFtjrj3JmfnMTp/XzkDx7iZS6vPmuX6WUS8/v+efzE0y9cBMMwE3LcUEDSNVEDkQgXD4+1P5Xv1JzxB0cfgyuXcdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637738; c=relaxed/simple;
	bh=rnJt+NG/oKaLPuXtaao1MpFqjvVZwnHEx15nwqlG74U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sQ/SUCZD7dmeTNoCVRvMdjqDCRJlhF8qi5jpZ3PXQu0aGPJoMWRkwHPZ+AUw7lxGLanEflLEvGDbWKs8DaOQNTsfFA27wZjnfqOR+adtCKNmgJMYZ36+FCOMdHOztR2epzPXN5QuVscgJI08fy0R0B1xa8GaI4gdP94U5hR9BCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=AkS8C7lH; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3906; q=dns/txt; s=iport;
  t=1737637736; x=1738847336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rnJt+NG/oKaLPuXtaao1MpFqjvVZwnHEx15nwqlG74U=;
  b=AkS8C7lHcHYFiie1q00FAOxwZiwjvqlP6SYXg9gWhOtgWKdycfmBkNNB
   wm5GbaRxHoCfRfzmalMT00eDK/beP//QmbK+IUpP+VypSUxfEOf79qmK9
   hL1qIhbydogWXtixamDAGmdADANHMgNUicEXbjwH5FHPE4uiGW2oXfcgp
   0=;
X-CSE-ConnectionGUID: UL6WrJSlTPm+19wNh0pzOA==
X-CSE-MsgGUID: l/7wUf3wS7KbMzm+XNPlGQ==
X-IPAS-Result: =?us-ascii?q?A0ANAABMPpJnj40QJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBcVJ9gRwZL4RVg0wDhE5fiHMDhXqMVRyFUIVdgSUDVg8BAQENA?=
 =?us-ascii?q?jkLBAEBhQcCFopdAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBA?=
 =?us-ascii?q?gEHBRQBAQEBAQE5BQ47hXsNhloBAQEBAxIRBA1FEAIBCBUDAgIfBwICAg4hF?=
 =?us-ascii?q?RACBA4FIoJfAYJkAwEQqXIBgUACiit6fzOBAeAaBhiBAi4BiE0BgWyIdicbg?=
 =?us-ascii?q?UlEgRWBO4FvPoFSgQ8EGIFdg0SCRyIEgi+BdAGDP6AJCUl7HANZLAFLCjUMO?=
 =?us-ascii?q?StFSAOBNw+BFwU1e4INgTI6Ag0CgkBwH4RMgj2ERYM7gRaBZ4N0ghSBaAMDF?=
 =?us-ascii?q?hGDJ3kfgQIdQAN4PRQjFBsGPZ0MATyDMSYggQ4UGFCBQwGTN4QFmiaVEQqEG?=
 =?us-ascii?q?4wYlg6qQC6HWwmPcXmOBJp/AgQCBAUCDwEBBoFnOoFbcBWDIlIZD44tDQkWi?=
 =?us-ascii?q?Fa7ZHgCOgIHAQoBAQMJkV8BAQ?=
IronPort-PHdr: A9a23:LRcDABNNhFowz5h3W3ol6nc2WUAX0o4cdiYP4ZYhzrVWfbvmptLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:vZviqKALMScViRVW/yjjw5YqxClBgxIJ4kV8jS/XYbTApDsghWMCn
 GIWD2qDOa3eYmugcot1bY2wpE4A6JfRzdA2OVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZsCCeB/n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gWGthh
 fuo+5eCYAb/gGYvWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE/tEwM1sUBokkwuM0WDBR0
 /xAMCIqR0XW7w626OrTpuhEj8AnKozveYgYoHwllW2fBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWMHgBfoO3WjPn8bAZQ/keO3j1H0ciZTrxSeoq9fD237kFUhjea3aoGKEjCMbcESwVmlq
 DnZxDvaCDQIMZ+v7wKB3Uv504cjmgugBdpNT+fnnhJwu3WI2mUZDBA+S1S2u7+6h1S4VtYZL
 FYbkhfCtoA78EitC924VBqirTvc4lgXWsFbFKsx7wTlJrfoDxixO0xacSRjU9gajMp1HG018
 F/Rh8HOLGk62FGKck61+rCRpDK0HCEaK24eeCMJJTfpBfG9+unfaTqRFb5e/L6JszHjJd3nL
 9m3QMkCa1c70JJjO0aTpA+vb9eQSn7hFVJdCuL/BT7N0++BTNT5D7FEEHCChRq6EK6XT0Oao
 F8PkNWE4eYFAPmlzXPWH7lTR+3yuabZblUwZGKD+bF8p1xBHFb+LOhtDM1WfRkB3jssIGWwO
 RGP6Wu9GrcJbSX1NMebnL5d++xxkPC/To66PhwlRtFPeZN2PBSW5z1jYFXY3mbm1iARfVIXZ
 /+mnTKXJS9CU8xPlWPuL89EiOND7n5lnwv7G8ukpylLJJLCPxZ5v59ZawPWNojULcqs/G3oz
 jqoH5XRkE0EC7WlMkE6M+c7dDg3EJTyPrivw+R/fe+YKQ0gE2YkY8I9C5t4E2C5t8y5Ttv1w
 0w=
IronPort-HdrOrdr: A9a23:rkKZVKiVy9vTHJC9gBp7fAG6nHBQX6Z23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sde9qBPnmaKc4eEqTNGftJGPghrnEGgQ1/qS/9SGIVy+ygc979
 YuT0EQMqyLMbEXt7ef3OD8Kade/DDlytHpuQ699QYRcegCUcgJhGkJaHf/LqQ1fng7OXNTLu
 vk2iMznUvaRZ1hVLXCOpBqZZmlmzTjruOUXTc2QzQcxE2lizSu5LTmEx6e8Cs/flp0q4sKwC
 zuqSC8wr+snc2a53bnulM76a44pPLRjv94QOCcgMkcLTvhziyyYp56ZrGEtDcp5Mmy9VcDir
 D30lUdFvU2z0mUUnC+oBPr1QWl+i0p8WXexViRhmamidDlRQg9F9FKietiA17kAgsbzZVBOZ
 BwriSkXqlsfEr9dePGloD1viRR5w2JSLwZ4LUuZjJkINEjgfRq3PwiFQtuYeU99WTBmcMa+C
 0ENrCB2B6QGmnqMkzxry1hxsehUW80GQrDSk8eutaN2zwTh3xhyVAErfZv1Evo2ahNA6Ws3d
 60eZhAhfVLVIsbfKh9DOAOTY++DXHMWwvFNCaXLU78HK8KNnrRo9qviY9FqN2CadgN1t8/iZ
 7BWFRXuSo7fF/vE9SH2NlO/grWSGuwUDzxwoVV5oR/uLf7WL33WBfzBWwGgo+lubESE8fbU/
 G8NNZfBOLiN3LnHcJT0wj3S/BpWDAjuQ0uy6AGsn6107X2w9fRx5nmmd7oVc7QLQo=
X-Talos-CUID: 9a23:JJigxmGfdP9hY24RqmJa0BArAOIedkHlyTSJclCeCT5xWpq8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3An3t05A2gBoimAM53KMgDnMF6czUj5+PxF30Dyoo?=
 =?us-ascii?q?95OqOED51eAe7tDCYe9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 13:08:55 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-04.cisco.com (Postfix) with ESMTPS id 3FBC0180001A6
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 13:08:55 +0000 (GMT)
X-CSE-ConnectionGUID: BCB3ATQJSzKXd6Zyw6Sqmg==
X-CSE-MsgGUID: Gfl+uWFVSySd/QBc3QvSgg==
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,228,1732579200"; 
   d="scan'208";a="22919628"
Received: from mail-mw2nam10lp2043.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.43])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 13:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnSQ68B1yc1WNOVMFBf/2v59DrG9W2lcb0nFN9RIDPRxzUbb7QZ6VZZHAc786LcDsGUKAU5s6UECnEFzTtVUcMX5FezXA4IZIu63ryqcAe8Vep9yd46Qh9It/iWyP0efKfz1tizTnuuK2qp1GzLIlInO3srohJwagv9Kv0q5fRUANYEmXKCt2HZIUyoyuNGzdIYN+3hToHTn4tsvs6KFlSFiRogmXdOujcVgtF+2xbP5gUQhfeTPNvXRYyuseY9F2VOI2/Dc7Esq0ved4jSwwVecls51ueFf50opiMBo9zbCCY3g1ppes9ThcK0nBo7ONXez6OEnFCOPqR/tkTBH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnJt+NG/oKaLPuXtaao1MpFqjvVZwnHEx15nwqlG74U=;
 b=aZLt/NglsXPaiqsdOYa3SRr+47gQ2Lqx0xDuKPu6ClxaRigBIBIEYLsR26ijG+4JvT/Etxyrz/bUUW0Ukt2twn9KFU++yqeOKEonwrgKyHq6IwHvb2/6jqUbzi9pXuGuBGa12w4jIe8zW8tTlafmtD6PfCUp18fM9cQhmL4NmgDYQYwjpicNWSR/lrHLLglpeIJ2Qe7lKwpq6KodXulgAXeSYJCKDfCPKLKBWjXtyxEDERis8ottqOt5NSe/xyeeGUnnx7V4tHaDKSXgELjhZGiEB1WgzAo6u0Uob6b+KOV+knBIubQTWRJVnUOuY3r8vBarNtacg14hi+SBwy+wIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 13:08:52 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 13:08:52 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: "Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco)"
	<spushpka@cisco.com>
CC: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, Zhihao
 Cheng <chengzhihao1@huawei.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, David Sterba <dsterba@suse.com>
Subject: Re: [Internal Review] [Patch] btrfs: fix use-after-free of block
 device file in __btrfs_free_extra_devids()
Thread-Topic: [Internal Review] [Patch] btrfs: fix use-after-free of block
 device file in __btrfs_free_extra_devids()
Thread-Index: AQHbbZfygv7iEYM2yEuhxEnfkgU18Q==
Date: Thu, 23 Jan 2025 13:08:52 +0000
Message-ID: <Z5I/YsJbzLaTBZ/9@goliath>
References: <20250123114141.1955806-1-spushpka@cisco.com>
In-Reply-To: <20250123114141.1955806-1-spushpka@cisco.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|SA1PR11MB6782:EE_
x-ms-office365-filtering-correlation-id: 4f634e99-198b-44ab-24fc-08dd3baf1566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEZucGVUeVdmQ1A5M0pXR0hYRmNPUmttUCtoYUgrOVJCT0o2UkNDdFlBWFpn?=
 =?utf-8?B?L1dRNDhxdEdYR1Q4QW5pakZVV08vMlNrbHAwVzA3Y3A3NE9ER20yTG9BSUgv?=
 =?utf-8?B?SmFkL0hTZW91dEpzbWI0RmVGcmMvdVRZQ3RCN3pvRGs2NG1yWldOY3l1V2la?=
 =?utf-8?B?djBOaTdOTEtydFdkM05KaXVOODBuRW54THVxVDdBalF2U1J0T2FpWTRlVG5E?=
 =?utf-8?B?RG5nNERvMUlFNVJRWEhvN3lkOTZGU0FDRGwvVksyNGczK2VqQXFpUWY3dFlN?=
 =?utf-8?B?VXFNODdsdVF5d24rL05QeGx4MG1sREpNYm9uQmRSUzZDNHpDaXAwUFBZUkd2?=
 =?utf-8?B?WEJrUU9lTW02S3JwUW0rTDdCdDd3M2RyWUh2REZoRTcxVHZzbjBZbUdwVzNi?=
 =?utf-8?B?bC9LdVRBLzdzUVpDbEJzVHhYVm9aTjJNWW9ITFVTWnNnYVMyVDNMZm05UE01?=
 =?utf-8?B?a2xjSEFRbDgwMXZaUU91UGQ1ZDRxenVyeHBOT0NkcVFoQWlnMlRWMC9YU2I2?=
 =?utf-8?B?KzJoRFN2UjhXdDRNTjIrNGFwblI0OEVReEdVSExIdFFqVGFNVVRrOSszcmFI?=
 =?utf-8?B?N2Nub2o3bllla2V0R0hKdG5wQ1JpOFhubjl0VGF4Nm5yZkdmQlVMbGVvZlFB?=
 =?utf-8?B?RXhPR05uUUtqQm9EYkR1eEwvNzRWMGFHaCtWaTlOb09qQjRORy83a05nQ3FX?=
 =?utf-8?B?VHk2YkgxQStYYUd2YUNSbXFFVnJBKzN0NnBUaVVvckExUnFkSWI2WFFVV3BT?=
 =?utf-8?B?bnZtU2tCRCsxamQ2aVpFdW52bnlkbWhpRzIvOE9GSmlvWDZCYnBrWWpaeW11?=
 =?utf-8?B?RnBzcVhCTWVjTUFIRkhzOFFQenN1bjdDZFRkdGg5RCs0M0ZONlZpTTNEVjNP?=
 =?utf-8?B?VXl4U1BSTTlCZGFYV3hQT3lURk9TcDVwNWROeURNTis3VEVIYzdvM2kxYndI?=
 =?utf-8?B?SWpoLy9BNDcrZ1k4VVdIQjVBdjJTQUFvN1FQRWZGVTEzVW0ybFdRWnY5TVk1?=
 =?utf-8?B?QU1IaGN1K1VmMy9EL1pmamtRT3BMSm9teUVEaGZ1c0dSdkRiTFVzb1lOWFJC?=
 =?utf-8?B?SEZHSkwwTVQwVW5JY00xUmNQNUI5YXkyNjBXNFRROWsyOEVRaE9aNklBRUh2?=
 =?utf-8?B?dG05NHNad3liNFg4U2xpMHUwWHJCVWZHOTFMam1wY0hKQ1d2ZjFuWVlNaExO?=
 =?utf-8?B?WnBaMjQyWXZtdUtJQi8weGdjMEM3NHZ4cDM3RzJPeUkxbTI2ZlQyLzQ5enVi?=
 =?utf-8?B?eHNhbEV6RFNBbzBmQ3NDay9HY3hGOWNnTkVQdXlYSENiNW9VbUpKaXdhdXg3?=
 =?utf-8?B?VFFtVE5zVXVyTmk4QlBzRW10ams3K2VsbnBRMnUxcHJhcmZGUjhiNkgxOHFB?=
 =?utf-8?B?WVdIcDRIeVJYWFpBbTB6WkhPWHFYbXhKK1FhVUQ4QU9tODFDWHFrU0lUVHM4?=
 =?utf-8?B?TjE5cmZuMzdQWk8vSVVadEhzOStRMkUzMmsvbENobll1U0xwWVJCdUdFUTUr?=
 =?utf-8?B?Q2Y1RERaU0YxY2tMYmhVbWVJQlZjMXNYM01rTmU5QmRHeFpBTkFXVEF5U1BP?=
 =?utf-8?B?dmJybExTcHdYT3RUZVRJSXIzeWZudW5PdVVvMzQ4NHF0Qkw3N1V2ZzVBNG53?=
 =?utf-8?B?UHdNaHdHbldmc2tHT0dsOVhyYVM1ZnRTTE9qeE5wdm1RRmVVVVoxVDV2K09l?=
 =?utf-8?B?eVNlc2V3QW5GVXpxd28rZkM2d1RJaFZNZVpaVkY2eUpZS1AwMG5CbUttKy9w?=
 =?utf-8?B?bUhzR1U5SFIrQUJ2WlBkOHo2VHdsbkhJWEFTcW9mSVBwb3ZBVjlHQmF2VDhD?=
 =?utf-8?B?YUF2Ly9UZ09KWEt6OXRrSTNXNFhLV3hQbzNEZ0wya2Z2YXhJMTZTcmJqWGNv?=
 =?utf-8?B?U2U3bEtyVFYzVXVDRWV4ekFDTGo4M3E0YkJMUFVNb2hyNnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHoraldQaUZzSktFV0grK0VPT3RLZ3BrSUlBeG1vL3JPS1pYRTJnQ2ZOWURX?=
 =?utf-8?B?SG4vRm9uYXgvTEJXZWJKUXpvbkJYcVF0SEw4YlNnZTRDRWdUY2hVQ2ExNHJV?=
 =?utf-8?B?NXkzYU1jQ3NBbjh0ME9nbHBNaXhPd3RrUldnQ2ZxakUxbElzemlVdHF5NkNh?=
 =?utf-8?B?YTFmS1E0WU5iblVDb0hmeFNZK1RSczF1aUN6bEk0NnFlaHZFK2dZUkZCdUxM?=
 =?utf-8?B?T1plSjdUVnJhNTJTSldwY0RTcE5saXFyMzhiaGdqYk9tSFNMdnl5WnVQZm5V?=
 =?utf-8?B?ZXJHakJaQUhMRTU4MGVUdDdCWEVwdlNvbE1RSklsMHFBUlFLVmsxQnF6MHZI?=
 =?utf-8?B?WDg2ZFRrT3J4R2c5MWdlMk1lUTFEWExLZGVQWXhDekF6QXF1bFBwVDcrb0Fz?=
 =?utf-8?B?T1BGelVOZERHR2ZWUjg0UFloeXdwL0VqUDFMaGZxR2cxQ1V1K0hQTHdHNW1F?=
 =?utf-8?B?eUFjazc3Uk9QU3hER2ZId2V6SnR6Z2U2aDdVTm9pakpGMEUybWVESk1QajVi?=
 =?utf-8?B?OXpIQ1l2bUlNTzl3amhVRUFqMXdELzNaeWY3YStjdFFIV09hT2RwaUo2Zjhl?=
 =?utf-8?B?bW56dFQrNlBSQWpFTHFsVnJ0QVVEa1V6a2pINTN5ZUxzSkx3amV3b1RxNGY5?=
 =?utf-8?B?d3A5a25KV1lCUzJmMHVEbWxpN3pJWks2YVZHL1hibFNCcW5PUnU2OXp6bW1G?=
 =?utf-8?B?VmFNWU12ZkF3eFcvbnNFTTdQaHd5OW9zMU1hTk95cDJCWGxpaGxoYUZpRlVL?=
 =?utf-8?B?M0FOMTdxazVLSFJzQ3ZURnpPZk9BVUxLYmpwNWtUdFY0dTMzY040bmR4UzlC?=
 =?utf-8?B?cFVERUNEdVJZT1lMRjR1eGg2eGhTcXNVbzVvZkdGaEZ2Y09QSGl0VFJQdUlX?=
 =?utf-8?B?eWVjSzRxZTdzWmVZNmdPV0IvY1MvczVpRitQNDJlL3hkYi8xMHJ6aTFpT21m?=
 =?utf-8?B?NzBGcjZLWXFJZ0hUR0NYU091VDc5RW5pK2FIUzFGSzFOY3lWQjE1ZzhsU3Yz?=
 =?utf-8?B?d2pMZVJmRzRQaGZ3T2dkQ2p2MVpDWDZkdk1lUHpaS3BqMnRYQlVlZ3J5ZTFB?=
 =?utf-8?B?VGc5bjlUNGdrNk8zcTltNHcwSUplenFWQTdCRTA2ZnQzcEEvWFR2d1JBOGcx?=
 =?utf-8?B?YXh0UmRQWVNOTENuam1qV25uQi9qM1U4RE5vMjhMT29kWE1IL2w0SlhSL3Jh?=
 =?utf-8?B?bFJpMmlvQkl3M3FCRzFQdkZGWkpnYzlpQW96aHVLVDlSQ2o4UUJQVmRoVjdW?=
 =?utf-8?B?b0k5S21RcStOZW5aQXRlSE9COURieTQycmVOTE4ydVo0L0J5aEp2R21LVU1L?=
 =?utf-8?B?Q2dsSmZiUDliRlhBZU1YcWNyNFV0aXc3ZE1ON01QVmMxL0prMzBVZFdWVG1p?=
 =?utf-8?B?dWlycitZajk5UzJXKytHSmNLUHUwejRkUVBUaWZKV3RrK1BFdjZoWlAxb2FX?=
 =?utf-8?B?ZU55ajZPSEtQdTBLVFZvWUEwblF4eWtzY2NLOU5USGZON3RkcDhOVnprU05E?=
 =?utf-8?B?MjVnRVRDMWwyaytrZmxDU1N5Z2pDK1RPYVA5OWZpQi9rRnM5NWpDR1l4UWg3?=
 =?utf-8?B?bzVYcTV2RmlhMVV2YUxwQ2psdFpKS3pIRTg2WnVqNkJTczh6cFFlM0FjOVhV?=
 =?utf-8?B?NE5rWmxrWGxxTlNtVzVTbzdLby8xMGVHNm5WK1NJS2x2SS9hdnZqOGszdzQ1?=
 =?utf-8?B?elFtVzg4TDIyMVphRk5lK2t3aUJ2YnZudFVsTlhqaXVFMlhodTNjTUJOQmxY?=
 =?utf-8?B?eGpCSGFNTlFSUEtOOEFvSHFLeHpQQzFvNkt6NXhHL3B3SlA5WW1FQkdnTXJV?=
 =?utf-8?B?SC9BclF2MFB3SEdVemlqcXc2RFlENnM4SU5rajNDb0hLR29qVmsweW1SVm1H?=
 =?utf-8?B?Y3ZMWmdDSkplRGhhL01GVFJrN3ZXMWRyMXphT1FQd2hlZDFrdkhUVUttVHph?=
 =?utf-8?B?R3RkRytISHBUdHkrdFdqYXV5ZUdQVVRmQStXeGlxR00zdURXQitGR2QxR0VL?=
 =?utf-8?B?VFV2VC96cUZaZVZlZGpTSFdtWUYwYUZLRmN0RlVFVVB0SG1wN0JJWi9kbVYz?=
 =?utf-8?B?bzIyMGJIRFRYWjQ1Y1NpQUREcjdjTTc5cXg4dHVKRTlud1JENXI5ZUhqUS8z?=
 =?utf-8?Q?YhNOKLeiYP9cpNyPeyK2FmAdb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82410E8674416F40A4A598FECEE426D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f634e99-198b-44ab-24fc-08dd3baf1566
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 13:08:52.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSC6bDodKOHI5WZilGc6rrytRM5yi3Aa3+7EmVr5MV3h/eY9xK+NBJBjhGDJ1ZFHsvz8K5Azq7h5eskAiSvgjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com

DQpMb29rcyBmaW5lIGZvciByZWxlYXNlIHRvIG1lLg0KDQoNCk9uIFRodSwgSmFuIDIzLCAyMDI1
IGF0IDAzOjQxOjQxQU0gLTA4MDAsIFNodWJoYW0gUHVzaHBrYXIgd3JvdGU6DQo+IEZyb206IFpo
aWhhbyBDaGVuZyA8Y2hlbmd6aGloYW8xQGh1YXdlaS5jb20+DQo+IA0KPiBjb21taXQgYWVjOGU2
YmY4MzkxMDE3ODRmM2VmMDM3ZGNkYjk0MzJjM2YzMjM0MyAoImJ0cmZzOg0KPiBmaXggdXNlLWFm
dGVyLWZyZWUgb2YgYmxvY2sgZGV2aWNlIGZpbGUgaW4gX19idHJmc19mcmVlX2V4dHJhX2Rldmlk
cygpIikNCj4gDQo+IE1vdW50aW5nIGJ0cmZzIGZyb20gdHdvIGltYWdlcyAod2hpY2ggaGF2ZSB0
aGUgc2FtZSBvbmUgZnNpZCBhbmQgdHdvDQo+IGRpZmZlcmVudCBkZXZfdXVpZHMpIGluIGNlcnRh
aW4gZXhlY3V0aW5nIG9yZGVyIG1heSB0cmlnZ2VyIGFuIFVBRiBmb3INCj4gdmFyaWFibGUgJ2Rl
dmljZS0+YmRldl9maWxlJyBpbiBfX2J0cmZzX2ZyZWVfZXh0cmFfZGV2aWRzKCkuIEFuZA0KPiBm
b2xsb3dpbmcgYXJlIHRoZSBkZXRhaWxzOg0KPiANCj4gMS4gQXR0YWNoIGltYWdlXzEgdG8gbG9v
cDAsIGF0dGFjaCBpbWFnZV8yIHRvIGxvb3AxLCBhbmQgc2NhbiBidHJmcw0KPiAgICBkZXZpY2Vz
IGJ5IGlvY3RsKEJUUkZTX0lPQ19TQ0FOX0RFVik6DQo+IA0KPiAgICAgICAgICAgICAgLyAgYnRy
ZnNfZGV2aWNlXzEg4oaSIGxvb3AwDQo+ICAgIGZzX2RldmljZQ0KPiAgICAgICAgICAgICAgXCAg
YnRyZnNfZGV2aWNlXzIg4oaSIGxvb3AxDQo+IDIuIG1vdW50IC9kZXYvbG9vcDAgL21udA0KPiAg
ICBidHJmc19vcGVuX2RldmljZXMNCj4gICAgIGJ0cmZzX2RldmljZV8xLT5iZGV2X2ZpbGUgPSBi
dHJmc19nZXRfYmRldl9hbmRfc2IobG9vcDApDQo+ICAgICBidHJmc19kZXZpY2VfMi0+YmRldl9m
aWxlID0gYnRyZnNfZ2V0X2JkZXZfYW5kX3NiKGxvb3AxKQ0KPiAgICBidHJmc19maWxsX3N1cGVy
DQo+ICAgICBvcGVuX2N0cmVlDQo+ICAgICAgZmFpbDogYnRyZnNfY2xvc2VfZGV2aWNlcyAvLyAt
RU5PTUVNDQo+IAkgICAgYnRyZnNfY2xvc2VfYmRldihidHJmc19kZXZpY2VfMSkNCj4gICAgICAg
ICAgICAgIGZwdXQoYnRyZnNfZGV2aWNlXzEtPmJkZXZfZmlsZSkNCj4gCSAgICAgIC8vIGJ0cmZz
X2RldmljZV8xLT5iZGV2X2ZpbGUgaXMgZnJlZWQNCj4gCSAgICBidHJmc19jbG9zZV9iZGV2KGJ0
cmZzX2RldmljZV8yKQ0KPiAgICAgICAgICAgICAgZnB1dChidHJmc19kZXZpY2VfMi0+YmRldl9m
aWxlKQ0KPiANCj4gMy4gbW91bnQgL2Rldi9sb29wMSAvbW50DQo+ICAgIGJ0cmZzX29wZW5fZGV2
aWNlcw0KPiAgICAgYnRyZnNfZ2V0X2JkZXZfYW5kX3NiKCZiZGV2X2ZpbGUpDQo+ICAgICAgLy8g
RUlPLCBidHJmc19kZXZpY2VfMS0+YmRldl9maWxlIGlzIG5vdCBhc3NpZ25lZCwNCj4gICAgICAv
LyB3aGljaCBwb2ludHMgdG8gYSBmcmVlZCBtZW1vcnkgYXJlYQ0KPiAgICAgYnRyZnNfZGV2aWNl
XzItPmJkZXZfZmlsZSA9IGJ0cmZzX2dldF9iZGV2X2FuZF9zYihsb29wMSkNCj4gICAgYnRyZnNf
ZmlsbF9zdXBlcg0KPiAgICAgb3Blbl9jdHJlZQ0KPiAgICAgIGJ0cmZzX2ZyZWVfZXh0cmFfZGV2
aWRzDQo+ICAgICAgIGlmIChidHJmc19kZXZpY2VfMS0+YmRldl9maWxlKQ0KPiAgICAgICAgZnB1
dChidHJmc19kZXZpY2VfMS0+YmRldl9maWxlKSAvLyBVQUYgIQ0KPiANCj4gRml4IGl0IGJ5IHNl
dHRpbmcgJ2RldmljZS0+YmRldl9maWxlJyBhcyAnTlVMTCcgYWZ0ZXIgY2xvc2luZyB0aGUNCj4g
YnRyZnNfZGV2aWNlIGluIGJ0cmZzX2Nsb3NlX29uZV9kZXZpY2UoKS4NCj4gDQo+IEZpeGVzOiBD
VkUtMjAyNC01MDIxNw0KPiBGaXhlczogMTQyMzg4MTk0MTkxICgiYnRyZnM6IGRvIG5vdCBiYWNr
Z3JvdW5kIGJsa2Rldl9wdXQoKSIpDQo+IENDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNC4x
OSsNCj4gTGluazogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MTk0MDgNCj4gU2lnbmVkLW9mZi1ieTogWmhpaGFvIENoZW5nIDxjaGVuZ3poaWhhbzFAaHVhd2Vp
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERhdmlkIFN0ZXJiYSA8ZHN0ZXJiYUBzdXNlLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY29tPg0KPiAoY2hlcnJ5
IHBpY2tlZCBmcm9tIGNvbW1pdCBhZWM4ZTZiZjgzOTEwMTc4NGYzZWYwMzdkY2RiOTQzMmMzZjMy
MzQzKQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaHViaGFtIFB1c2hwa2FyIDxzcHVzaHBrYUBjaXNjby5j
b20+DQo+IC0tLQ0KPiAgZnMvYnRyZnMvdm9sdW1lcy5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmMg
Yi9mcy9idHJmcy92b2x1bWVzLmMNCj4gaW5kZXggYjlhMGIyNmQwOGUxLi5hYjI0MTI1NDJjZTUg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYw0KPiArKysgYi9mcy9idHJmcy92b2x1
bWVzLmMNCj4gQEAgLTExNzYsNiArMTE3Niw3IEBAIHN0YXRpYyB2b2lkIGJ0cmZzX2Nsb3NlX29u
ZV9kZXZpY2Uoc3RydWN0IGJ0cmZzX2RldmljZSAqZGV2aWNlKQ0KPiAgCWlmIChkZXZpY2UtPmJk
ZXYpIHsNCj4gIAkJZnNfZGV2aWNlcy0+b3Blbl9kZXZpY2VzLS07DQo+ICAJCWRldmljZS0+YmRl
diA9IE5VTEw7DQo+ICsJCWRldmljZS0+YmRldl9maWxlID0gTlVMTDsNCj4gIAl9DQo+ICAJY2xl
YXJfYml0KEJUUkZTX0RFVl9TVEFURV9XUklURUFCTEUsICZkZXZpY2UtPmRldl9zdGF0ZSk7DQo+
ICAJYnRyZnNfZGVzdHJveV9kZXZfem9uZV9pbmZvKGRldmljZSk7DQo+IC0tIA0KPiAyLjM1LjYN
Cj4g


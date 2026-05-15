Return-Path: <stable+bounces-248503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLzPG/xPB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE15C554309
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A1834440C3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FE3E7BAA;
	Fri, 15 May 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZDDUFPR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC23E7BAD
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861895; cv=fail; b=Gj5qRDissvcg8HZN6PUf2WEQVtSUFD10L5DojRM2KGZXrJtbt8y8BgcgjnFBb9AO5vhfV7B//rkqUkcspJMajPnuQBLZdIfqZ3+JxP1LglQaeWrSmVwWIyxpTTVcDSdrk0I6hJBzyFrhtg0S3Um9sNOKw/WJM/MNjoRRGH8MYng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861895; c=relaxed/simple;
	bh=uNRG6A8XBUZ/LYrzKSxqF4VkeCV3oGGc9NE60ujlsLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PyMCJ50vfIRQI7EQnR6PWusKKJNvsiDFZayuODkyMvo65/yVIAdBPcJ3TARxPhxKCSfxuwwmCU/Y/1QWDs2msN5wV0xnWhUA1NcREilYIiDCMpC2ArJq5BjteByirLvbe8GrmOYTlZhY/GRHk0kn062MInqcp9oXtVMezhcMJX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZDDUFPR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778861894; x=1810397894;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uNRG6A8XBUZ/LYrzKSxqF4VkeCV3oGGc9NE60ujlsLU=;
  b=OZDDUFPRuutR7kc3+g1J7wDEtzayUFc/pAg4vzX6Pq++d7qp7781FCBC
   PUtYY9wE81IPaWWhd0jyTEkbA2vh82USE8wx646eesQnZfU44u8wzfk6m
   YQZwOQyPbrluJCF2gfcHWo+vtBORZRx5qK1ilbRxgj/jb1Z/J4RfLQhAb
   Ng74m1qbjc8j3WsnyPodK7ODGttVOZgs1Dcn7Rsu55L1twIeTJP65qYZW
   egO4bDWCn06e879O4MltmJl32uvPvlryVwt//FRhjAPX8rwurrtD3bMJB
   shcCBdNCWYXCiMip+qDTS6W51qq/J/oM23tUuG/ovQlZyaG1VOs351Qt4
   w==;
X-CSE-ConnectionGUID: UZfhaQscT1yPQBVPtHS9NA==
X-CSE-MsgGUID: eMxj21izTgOKjmaKXHTBzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79784256"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79784256"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:18:14 -0700
X-CSE-ConnectionGUID: x//khmSJSdy+BQWUENTF5A==
X-CSE-MsgGUID: jrj4qV8tT7SZyMMQ+tkGSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238853483"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:18:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 09:18:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 15 May 2026 09:18:12 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 15 May 2026 09:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My7l7kn3kmnXtcNuOAXwAOcFXCDNfDE0mQWcZ/2ROh4Uu5tcXlT08d9eg+M9LHILEcIkBXYugTfAw78qumviPGFHrI/m2UreS7Pycxd8e+0Upbo7dgLZbc24FtzOgJbTwMpO6d1mn+Lnh/c1F3X7FFLPrW6FnveHP2KU+iIJbjCzr7nRvfvOXOsOqghnPVaQ/MxogFohBTKVExx0jiRXMdLsrnQas/z7vvcauUyEM3fy15kD2mbrm8LIMd+20wL+j4YTA2ZeKVs7rjTtukBtyLnlQDpxrTI2uI53MGHUV1qcQ4Vi9sRmXL3udhpfaIB5OVuYzs23M4H7kbc7Wka7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaAnQwDNT3b0QQdn2SmIOBaNTKzaLGSivrlZiQzFZaA=;
 b=knG046QKlzLskc+4ulqJQ9i42FUsRGZeOeHWaqS3daBjmYtI/ERZbXiYZGAP+CJd1czzXYmrNGKahJbA8cyABSIwgiLiDPmStihGzpkckRPqh3SwI7xKa+4bgG3N3qVqcqqlo7et/g3whpuAVRTXbAFfjwrs+vm4zu2bSoMoNmIXe1Tut6740MarKhOhryZVBeVg6dM8TtCrJGpMUVSCtjMJ0uW5eNHU5Dl0SuEdpl55J+AEbCGv86wFUQ+/oyqv3bX7+2Ou2YEDTPNTT3zi2xKz9wMBpmH5SIenT6G4C2NgdbmIp07Yg7Wwu/lg7j7O5bB+swz4tCb4J4S0D4BNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f13) by PH7PR11MB5766.namprd11.prod.outlook.com
 (2603:10b6:510:130::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 16:18:06 +0000
Received: from DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::308:3508:f7cd:9717]) by DM3PPF208195D8D.namprd11.prod.outlook.com
 ([fe80::308:3508:f7cd:9717%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:18:06 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Nikula, Jani" <jani.nikula@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Nikula, Jani" <jani.nikula@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/xe/display: fix oops in suspend/shutdown without
 display
Thread-Topic: [PATCH] drm/xe/display: fix oops in suspend/shutdown without
 display
Thread-Index: AQHc5IVB7zjPTRlkq0uBWWzBCC1FJbYPQ5gQ
Date: Fri, 15 May 2026 16:18:06 +0000
Message-ID: <DM3PPF208195D8D504F655566B2A718B650E3042@DM3PPF208195D8D.namprd11.prod.outlook.com>
References: <20260515160920.1082842-1-jani.nikula@intel.com>
In-Reply-To: <20260515160920.1082842-1-jani.nikula@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF208195D8D:EE_|PH7PR11MB5766:EE_
x-ms-office365-filtering-correlation-id: c9145f46-08a0-4f32-25ab-08deb29d8bf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|11063799003|22082099003;
x-microsoft-antispam-message-info: PXC7GRlGpVw0jHfDL6cQSYEA+5ck2eVwR76Qc+hSNGvrTcXFD75UM5WZeGDBkK9tl3BXbq92mNJaOGHio6y9wTEEnZshnczNjmMzJtfveP9HNUVZxkeht0rfuKxcwjXY9ar8+7fuvM7c/KebfNjB/DE6WFSmeioVHdAAvpGMU4D+V8+kYqGf81LOG9sUEfU1ETYl4EcyEeg8WqBCcpuK3ugURv20vyEecRF5K3CdOGsxv8NI9O5TN1UiyJA/sBK9ezFw0IVfB5poe/1FemWr/xl/e8TUMIg4eSfzkDQ5LkblPZp3papzgbIH5508VpaDMcxt0AFS2FPE0vWaGfH73xnPDGmVSKsuv0c9rUXsubxwRb0EK1T46a20nUpVm89RDJACPpwTk71KAQUnih3m4DfNNUFytDCQ09Jki2KhZGbnVMDG/wInwEmpgzEaXL32Rm+Mx47x+bZXnekI90g9Lja8c8Aq/G9ugRBfalA1CSxW1E68KRdQ48hAwyDPxU6ec2nvyW91ClC0yM1mnictQy9PC6Xixy+ki+pr1NVxkhl6A5bVlA0q1H4w02WU88LmmkK/hxsg8YEwHxl42jP0IQlXqisX0C3qOwFQ+n20aJ4ucP0bUpYtnVMbfVnPprPqgresqUuRhCOuzVchqIjutwXoPTSH1UykxVlI6NW8zlEHGJHwcB9GSbKuGGYTYak9PHBa44qHXjubepPkvVxazA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF208195D8D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(11063799003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?01+o9krvFDa8z30fZ+ZGdRuw+ESZZhUu+i2ToODS3TuiAmdR2T+Y4mWrhnYm?=
 =?us-ascii?Q?W/ErwKYtSWr95uzJGIPNQ0z9FO2UT7JmH7IfYAbD0GGcJkXhiCtVodmgy6sC?=
 =?us-ascii?Q?V3RixzDEW8Yher9cFLR3ExI4sI1RZ3ZBiAW9z8Ah55sctV4HbPF5RZZqf2Xv?=
 =?us-ascii?Q?0Jr7cFsS6m/dS9nwQcc2OVacyR48e1w4Zm/qbwAmbwvbZVOucWLCXJCZZTgG?=
 =?us-ascii?Q?T4xa8KqRECzD3gEyneJrKEU5bW7a9ijaW0YssRxHlIMedCMTya51kcILfX3M?=
 =?us-ascii?Q?YhyROBUkLtBR4nUbhvkGTeR3nmJomOUMfb2Q1lLrrDmANXHNVUJ1JFjv881N?=
 =?us-ascii?Q?MPKEJShjHa0plGHw30jsGugjWE/2dEc2mTbCFE2nQknXFzjZCmhWnWNJn8aZ?=
 =?us-ascii?Q?ZTHoUF97DGJBNS2cAKNlChHzAeEcE7x0oacs7tDuJuViC4ikftaYRtcuZPY6?=
 =?us-ascii?Q?I66GlQT2oO6RD4J7cN8bb/O3YhdJKVfYzGE0N92U0rF0gCqWIRzBQa0WVDY5?=
 =?us-ascii?Q?mJHrwRwCSRrNsxnJj5SYqCuQmrAIjoA1QHnTUTMncCmIUQwmwEtYvZeqjSFS?=
 =?us-ascii?Q?5Q+y1ua7RXHAjjT3QZCC/Lv6TnxhiI09gvViPpEGAG3tKbCB7GuMlaMIC7cT?=
 =?us-ascii?Q?nhbvMGswRmKuaBbsa/79tAhHGUr7W7RBTK2w85AHdYqlAf89LPlo9o4tDyPn?=
 =?us-ascii?Q?5TYgs//OKYKAA/RsG6G87wBS5Gnhzvb5SCmwrsx0jDS10I+NCMiRj4TwEElH?=
 =?us-ascii?Q?o5LwbyxWpd9y/1qLygu0iyUFl5lSSEN7nrPSHjm3eLkpxeYaJdfqk+r8JHqo?=
 =?us-ascii?Q?cuxGfxkzD8YuDheu0AUneb4FvXQ17nyBoovpvFhu8eNx0hKFIH5nZnetLfsY?=
 =?us-ascii?Q?WawjNzWnLL+lVSuNd278xAWgXTf9sYkseclZ4BPGjzeqDwZPOInMFsvDR8yD?=
 =?us-ascii?Q?5ek+8iXC0x0QXDiUj9zc2/tAmdRyDXmwM8J2XGguT/UBS4RfH0wWZZ1N/c1P?=
 =?us-ascii?Q?ofBqSrxcvU9ZlBB1XVsOKPKCVk0bBJjoooDuh+70O9iqAX49uEU0z/aiAtR6?=
 =?us-ascii?Q?1Dyvb86yCeRTFXlLz9UzLltuxdpfdXcQpmM/0IJdM228gfqsRoGeRKGh40M+?=
 =?us-ascii?Q?/3/QwcrvxMbcgscmqwTz6YNIktQJse1qe2VnwPDlQ+wPUGSVbdaKwTc9nqma?=
 =?us-ascii?Q?lNTG4Aw5TIM2sprwzPPhMONobIRGyuvrNUIhgp0Twu+XHKhnapr1Y0poDNpd?=
 =?us-ascii?Q?3TU23KethZhXshL2UOLqCJGc2V6pPUKla+IG5vZuKsdogiNbt4f+PvMv92Ww?=
 =?us-ascii?Q?6PUYN7kQ+bMrF2hJhafV1twgL0Y/hMRhitJGPAxO5Yie/NaQ8oBJ2RPrdCpy?=
 =?us-ascii?Q?p81Ik7pvEf637kVqhPdYd6IT6aAV6sNyhWIvFAgZV3iY4x+Uj8ECE0RUqxqO?=
 =?us-ascii?Q?BbNmYYJyspbl5k4Em99EvMchUtvrsb2NNqFU97dsGBUR1FzbjEVMMjBLqOPE?=
 =?us-ascii?Q?O6mVdqVafuC+M6kBB10dK0ky2elxVfOxV8ndRlMp+yGhYmM2S+1m4dkQHtRR?=
 =?us-ascii?Q?6pObdznQCEaiVmuXi4YVNB6R2M+5R8Ec9ZAdUUnwJyCJIUyf3go2SaiQ0fET?=
 =?us-ascii?Q?dxoAN/20aVGcDJuwDgdzp03Wt347or7YR+ngZVOYIugMkQwhjc0jVga4OaZl?=
 =?us-ascii?Q?Ty8loPyV7H60n23FdXTV8uAgc9vaUFuh4dg5spPaHN8uB/2XxRFuhVpWr835?=
 =?us-ascii?Q?KtThzVuMCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iM13UAycD4WXkHx+FMI99B17sYQYStl7AjmbzvgS56FEtDrvFoUockkb7NZjIoVnT+lZ38vrp5EorTinFyeBU5djvYtKuYOZ5wQi+5ZuZrSgBO30K7y5P0nCOXRp4qKmi6WehyAuNNike1W5FwybifhU0vWOZHK/m4DzYb33WnFQoN12CHNfe2Kt/V50Dao/nJU4MG0/U1kbgMqx7wEyJCq5nMg6kU1SN8sn7RMRBVl9BU/qH0XCmrQOw+USMSd8YnkkhfdQDF0QXmZ4Z4kntUVPWLxvt6tJQo1SBb4S3UsKiKiTJ/aB7sk+1qDdFCtiMWMFQEtChlGkH0cIHpId+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF208195D8D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9145f46-08a0-4f32-25ab-08deb29d8bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 16:18:06.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FyGeohRIjZLPWvNoB/hBbZyPzxGF1MZ760e1CLcwwjh9CbsP9kvCab2NM/Jv6my28o4CWdTbYnp0EB5W3GGYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5766
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: CE15C554309
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,gitlab.freedesktop.org:url,DM3PPF208195D8D.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kandpal@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

> Subject: [PATCH] drm/xe/display: fix oops in suspend/shutdown without
> display
>=20
> The xe driver keeps track of whether to probe display, and whether displa=
y
> hardware is there, using xe->info.probe_display. It gets set to false if =
there's no
> display after intel_display_device_probe(). However, the display may also=
 be
> disabled via fuses, detected at a later time in
> intel_display_device_info_runtime_init().
>=20
> In this case, the xe driver does for_each_intel_crtc() on uninitialized m=
ode
> config in xe_display_flush_cleanup_work(), leading to a NULL pointer
> dereference, and generally calls display code with display info cleared.
>=20
> Check for intel_display_device_present() after
> intel_display_device_info_runtime_init(), and reset
> xe->info.probe_display as necessary. Also do unset_display_features()
> for completeness, although display runtime init has already done that. Th=
is will
> need to be unified across all cases later.
>=20
> Move intel_display_device_info_runtime_init() call slightly earlier, simi=
lar to
> i915, to avoid a bunch of unnecessary setup for no display cases.
>=20
> Note #1: The xe driver has no business doing low level display plumbing l=
ike
> for_each_intel_crtc() to begin with. It all needs to happen in display co=
de.
>=20
> Note #2: The actual bug is present already in commit 44e694958b95
> ("drm/xe/display: Implement display support"), but the oops was likely
> introduced later at commit ddf6492e0e50 ("drm/xe/display: Make display
> suspend/resume work on discrete").
>=20
> Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7904
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/6150
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
>  drivers/gpu/drm/xe/display/xe_display.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/display/xe_display.c
> b/drivers/gpu/drm/xe/display/xe_display.c
> index 053abd6f6514..5f25932730f4 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -104,6 +104,15 @@ int xe_display_init_early(struct xe_device *xe)
>=20
>  	intel_display_driver_early_probe(display);
>=20
> +	intel_display_device_info_runtime_init(display);
> +
> +	/* Display may have been disabled at runtime init */
> +	if (!intel_display_device_present(display)) {
> +		xe->info.probe_display =3D false;
> +		unset_display_features(xe);
> +		return 0;
> +	}
> +
>  	/* Early display init.. */
>  	intel_opregion_setup(display);
>=20
> @@ -117,8 +126,6 @@ int xe_display_init_early(struct xe_device *xe)
>=20
>  	intel_bw_init_hw(display);
>=20
> -	intel_display_device_info_runtime_init(display);
> -
>  	err =3D intel_display_driver_probe_noirq(display);
>  	if (err)
>  		goto err_opregion;
> --
> 2.47.3



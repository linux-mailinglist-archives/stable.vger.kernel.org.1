Return-Path: <stable+bounces-224735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FiwEqaqsWmzEQAAu9opvQ
	(envelope-from <stable+bounces-224735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:47:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A09268358
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88E031692D5
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2F3E3DAE;
	Wed, 11 Mar 2026 17:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCTi2pc1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B93E6384;
	Wed, 11 Mar 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251114; cv=fail; b=KIL9PiKJF7YpIvd1m99aZZTH6VGdhOw0xROQx1r71tq/oR8BH+qJrdGZ2+3yw1Ofzy75TUTpr5FpRC7ENcgAQy0Rvjv2eqPy8A4JjMvO8aNtNG+TYu3RDBmyVH4virBo1kzW7HP4mGZPl83W/qE9KgioVUbDJfdHKpePVxE5eww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251114; c=relaxed/simple;
	bh=XDOHZCkm1dy4kq7ozjyHMQO76rgxMmlnp+P5icmh26M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7g6UHmYUEPqFHm7PjI+HpB+ila9FwYuSUAtfPoqtJKZZguysrz5XBj0vl+l4aDuEOC4DNi/Z+qm3Aj4SkL+sv3lbQDUeLrYVELlVbL3iVkHNxRXM0YVI5o3w1eRO1Wm6NeJxbjIIjoKjoUHNZhQwH3JkE+ph5OnheOIJCCUVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCTi2pc1; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773251111; x=1804787111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XDOHZCkm1dy4kq7ozjyHMQO76rgxMmlnp+P5icmh26M=;
  b=PCTi2pc1DfZO6Uv2Z7x1IvBnsFLR4EpkliVTegJKMKMAZUQYUOX/N54a
   HQ83x1DH+ga2WvQIoIP7qrdYFQRX1vmqZ66twOROQPx9UgxtBsSLJT0Z5
   hNoRhZDttZCd4HrpBvfoLMkIFrfCwnMbuY7EsJNvcqfkndkGv8thzt038
   aiWc595UzjQRkXSSeTXOKW25x24Las0BQRlv7uIpKi+ky9LlwA1xWhjZt
   Ld5HjGnvJF47TqXtnW+4nNSy8BvclewWvq06rVAubp7iXkd8I3pofzlyD
   6rtowm2aBxke3KExVV2/1i4Ki0jbLXCEWppJ9IKw+6Wk0lSFcW3lQ9ZYV
   Q==;
X-CSE-ConnectionGUID: hrgNGHICSyqSXI3IDn3baQ==
X-CSE-MsgGUID: qiWyI0OcSk+rbiz8XrFuhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74207274"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74207274"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:45:10 -0700
X-CSE-ConnectionGUID: H0uMV1YjSaqmvHDOdPExMg==
X-CSE-MsgGUID: NjY0uaUlQzezXQNWPgGFbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="223061459"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 10:45:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:45:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 10:45:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 10:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1gm9ZDoD7BmGOnI2Wusu4MHFvUQvKZwR/ACFtciboioRVBKGI1les00JwDTKy5zI21G5CU+Yz/yIsWuofb1c5ljJaZL/hSOnyNFtG3od4w399SzcMt1kazhMtu/FSeN7knAk4Ax/SFpyW070P40iee7XwTyfxka3NQ+OW3wBwdvghvd6fDnVGCz8pq48nlW33XXTFt41E5Nx2Fjxo5ODDTPJgGxCWGPnHr5NlhovZ1xjHbgwQHxWHGfzj4znFx4S5eq3KTRhE420x+5dlWxvdmAVW9isTZ0HeAVcCPhhMMuTl9b0EpFT5MVOTokiOZWWyXLPT+4vGcVzvlwhJnS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDOHZCkm1dy4kq7ozjyHMQO76rgxMmlnp+P5icmh26M=;
 b=eAKFzFequA63p8C1lOLaGQDnSqnTFbboJAUDxwx3zsYfWfSkoJS9DyEiiDPG2xVZP7gp9iH4153zbS6cCu9TmFMzYiwSkgXS/SAkK28EhqWWQtMC6Xggf3rllL/5pENVcKNX+MIsSSVQXNtVQ+6u74aNvyPNY6q/kWv72tTsDzOnpDIU6/Mevps1YAGNrnC6OKgzTHVH++LsYkkAxWhb89wHZAduIOvLnhXxMBRLLRkpYxnOcfrE6yy3Y/2h4Sj8uF3AEghof86xqvcEuJB6tkEXHMpm00qlbwA1QKBXytcHxgUshkyLMt0KR7ILay5n7T3yxpmSgcsIJ/BRpnKGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) by
 DS0PR11MB8737.namprd11.prod.outlook.com (2603:10b6:8:1a1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.3; Wed, 11 Mar 2026 17:45:07 +0000
Received: from DS0PR11MB6542.namprd11.prod.outlook.com
 ([fe80::2d19:4946:e592:2afc]) by DS0PR11MB6542.namprd11.prod.outlook.com
 ([fe80::2d19:4946:e592:2afc%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:45:07 +0000
From: "Tsai, Gaggery" <gaggery.tsai@intel.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
	"ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
	"mstrozek@opensource.cirrus.com" <mstrozek@opensource.cirrus.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Thread-Topic: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Thread-Index: AQHcsL1mnDkPTOwZzUGANjm8AekoMrWph2+AgAATqCg=
Date: Wed, 11 Mar 2026 17:45:07 +0000
Message-ID: <DS0PR11MB65421FE197235CDBEF721D848647A@DS0PR11MB6542.namprd11.prod.outlook.com>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
 <02cd505e-4635-4d81-8c70-166bbfeaef85@sirena.org.uk>
In-Reply-To: <02cd505e-4635-4d81-8c70-166bbfeaef85@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6542:EE_|DS0PR11MB8737:EE_
x-ms-office365-filtering-correlation-id: 3d805557-ec13-4434-780d-08de7f95ef5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rbTy+Z1WUkor8TiyCY+B1eIarYPhZsWCG/LdV5SM33CSV+lkjdi7ZC9+7Lrk5m1CDwg/3L17N9j2CPjqFlG7OHNTlkTPPZeigpK+23aJjeSM0qSvadpl6LCtIy/KzvMoq+LJd9Feve7+CrOeSgoL2jaeIss4Dxzd99FjE+HxzvRczSPesC3ElT5ISl4sKnTiFtX/5OoHg2XPP6nbXkXu5aZerFbDvHw7p9iJmYxw1mFDyFi0p9ufZzhbeQ5BO8No1MFQ7svrW51NEjZurm4UtmlZ1vW00HBLMHFkJutVKuqpC9AueeMOLer16/xi9ZQntDn+F8iL+aj7iNhUR9BC0DSn8PvtG++h3xKYbZBgGSEX140nmN/x+bZc55f8Bowp7arRgJE9JCYFWV82bIsZrDky66dfKo+P5UXgJ/ovM8oWHKj4jRV/wiJMjKmzeyK2IWj9FHbfF5xQmsSdZKfSGQ6rqdFbQdfUdT3Xv6zY8c+uP31ZY3tU7ewgQi7p8+eILdU3XBjNIKj6pPGaEeaYqIzSrqy7FWoFr6XnX9qVwatcjDxm2Fkwdgruml0IEmGK3N41fprpezQWiCvrxmX5u/Ex9vBbjjmsijnacXkT8FeCKI0NCIDg4XX2thjz1Xdp3IP5Nyq/+kh+vv100GxjuoFzH5DGNfFqW8Qo8QCh/rpDjMUcckIFmfEKvEvHu7nfhl0uMUgxVTw00MPwU6wRlPB6B7GEDpWhXMmDHzm6t+i3gbsTZPCldzkSQLPCZ4TtzebthBUTzvzYbv2hjEA16ssNcw6irVT3SB4Slx7L96c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6542.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2AclF9fe5Mh3iKugKytmgCsUoH1Yc6TxjTiIeQ8xMkLHqzVZuggSY87Xaq?=
 =?iso-8859-1?Q?bfIZMNBA4tlZmxnPQvuay9HrHnpOiihags9tqbjKXg7vqtSdukfrLn6+EP?=
 =?iso-8859-1?Q?40RGSyd3/KygUgrkdQvm7H5R1TSA8nDWnXstdNNCms+u0IWFzWqqcQ3Hs3?=
 =?iso-8859-1?Q?xJ6T5F+367LzyZEXho7M6Kc0LV9zZon74UBpFRe1UYn3zAiMySD7XjcWdy?=
 =?iso-8859-1?Q?I2aYo5qe3LJGK+dFEp2vKCsZ+oWeheLRvQq4b04EjV7qf96W02bm1eGFS/?=
 =?iso-8859-1?Q?OAbPqwYtJLod8PKwkL4r0hjyFx5uRYIoNoN5EmqWPIEkgf39JE+Si7q3UC?=
 =?iso-8859-1?Q?kKo8GigoMHwgBfSafSmRL/y4fdBQRU8plUjjuru9QP+01oxj/PlJ/aexzz?=
 =?iso-8859-1?Q?dD0RlF1e7mHla50VA3wL1PBOfAWJ3vl+CypVR7fv2eDKE45SYwPsf4zlO5?=
 =?iso-8859-1?Q?/UlAERyHWGp6yKUhwSkZqJ/SEcHQ7pMccIQDW0GUOL8Gs0msZeL5DggB9n?=
 =?iso-8859-1?Q?X104PsWMcQFgxgwMM0/S3/lW1sziyY4+OQ4Qw5tsA5+5aHYZ781II9DlPn?=
 =?iso-8859-1?Q?BtaNI5shI4ZWCsaefhr4D6mz44TZzFU10JcwLQVqZJf2PHLoicEBQkWFWC?=
 =?iso-8859-1?Q?99wMEHTMNu7P3YQbXfu5d0k7cWnY193Wa//dVlw9mppxRuuDhrs3tE2l2O?=
 =?iso-8859-1?Q?i6eQ40IxqAEo5ytpZXXyM+vFcOUNAIkcPCCB9TT9403dX16ti/f0D/NcD7?=
 =?iso-8859-1?Q?HeezCJOFCT1vOzM+/3hgkNDwCCZsvrbl1jUjuJr09p6GFeqQhmVmAW/mJm?=
 =?iso-8859-1?Q?bl3ueRVSe3e8zxkwM511SaF99I9m1WYgk8yGn9o/GpyupPxl/yvrf2oGs0?=
 =?iso-8859-1?Q?ny7P16MmRzMx94w3GEiikzg5g9bdAwa4eWODwZkBPvWLY5o/YoWH4uAQCw?=
 =?iso-8859-1?Q?bp/AGG+r+r8o7NwpXEQ95CSUE8VobU/omNVQwOHUE/rKstFtM3Whu37/Gv?=
 =?iso-8859-1?Q?DG9hq30C9HdFyRNpsW4QclvQg6SSuZo7yTORglLoKgNzUik10JjFRdEStB?=
 =?iso-8859-1?Q?M277kP/ErZ6u9o7rMvpHyMzut3WmHhprbLcpFBil8OxXaQvNSOM0pf6YrD?=
 =?iso-8859-1?Q?fOKGX86F8iT3pz5aNLDVCFvVEbW91IsEbIeBhvidEf7MzNMmi4m4XCOs1u?=
 =?iso-8859-1?Q?iYMq7OHIxhaNn0IM72oOU/83xd/52im9javjn0S6adRO1bqwz9v1MQO0DC?=
 =?iso-8859-1?Q?2+OllVegQPe+n3LpAnmA9w836ngpR0JgBPuM2rwB/bvOzsq8Xmluu+J8XP?=
 =?iso-8859-1?Q?6KCSKUPYH9kFPg2G5Y7dFEPp2vY0iiB0JvMgM9ZBQfPfOSwvjOedpMt/dj?=
 =?iso-8859-1?Q?YgYqzifum+r63SDxgwbbF2R2EMw+NeTlGh07jfKGVb1Dq0Kpq6uelNXaUo?=
 =?iso-8859-1?Q?s1sqW9sDRkcZVv2vEQ0c5VqhB98wqKzNA6ZYKkV369+l6D9P/J0pXfB5Ft?=
 =?iso-8859-1?Q?1GhM6cC3YVMSJOlm6qfAMxTA7yz6eMKNc2rGLOEe5DEkFUh5iIVFnVZvHn?=
 =?iso-8859-1?Q?W7hY6lPNxZEQRmsCvYJ4KOtL5FJ3xWtVH/jZcYVEU6S/kgFQrpOzuOwodV?=
 =?iso-8859-1?Q?YG/NvIE5n9kCquZ/1JsZD9o7Ro/rwM8x02G9wn/gQ5LkbOMxAx9CEX8Xe3?=
 =?iso-8859-1?Q?cvOAxrgtCfs8Dh+h6310wQgkDWkqYb7gTJH57u/47A0ewyX8sEbE0VhvDU?=
 =?iso-8859-1?Q?wUw5A4I8wQOA3NukHyK6ECTc8SPwZg6MYERpECmWolaUM0pIETKmqk9sbK?=
 =?iso-8859-1?Q?KaZR86Tuyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TUIgp1Op8TzOAaM+zSkdhBtB+IIrWGpTnZdl2Crd5t1zG7On2/fE/5P+YNATM9Ys1pItN5mqMs3DmCi0/ImBTQPRepLzPGC9ndc5nCSNrHn1cPxJTn3nPT9dhEKB0ioE+2yHqw1TeZ/c7aBJJ1LKWo9/21d7LN4U7Fa1eeFzKrVTHANWg2KUe6DcsoTi156XiK2wJaUz54JKKIQICVXH3MxC3ifbeZGOvpt+ML1OmXrdDqj0eFFx6t1XuRzD8xjeyrZdMMxKyygrZma2eczcHhVJio8Ok+mHw5CPFsJoO8zVAdld0fSVzT2KuKpfYMDVKWBRTyj+/d2WpxGBvSXddA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6542.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d805557-ec13-4434-780d-08de7f95ef5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 17:45:07.5447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5nmFIPC6tvLDulAGnUAjm0Nv4KT9+9UJzd4s8q+EHe6qzfmDMerIDt1syTpPhBtHbwqzT9JxCSZ9hkQKWKYNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8737
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaggery.tsai@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 90A09268358
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review. You're right, I'll send a v2 that also disables the =
SDCA IRQs in the component remove path to close the TOCTOU window, keeping =
the NULL guard as defense-in-depth.=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Mark Brown=0A=
Sent:=A0Wednesday, March 11, 2026 9:31 AM=0A=
To:=A0Tsai, Gaggery=0A=
Cc:=A0linux-sound@vger.kernel.org; patches@opensource.cirrus.com; ckeepax@o=
pensource.cirrus.com; mstrozek@opensource.cirrus.com; yung-chuan.liao@linux=
.intel.com; pierre-louis.bossart@linux.dev; stable@vger.kernel.org=0A=
Subject:=A0Re: [PATCH] ASoC: SDCA: Fix NULL pointer dereference in sdca_jac=
k_process()=0A=
=0A=
=0A=
On Tue, Mar 10, 2026 at 11:38:29AM -0700, gaggery.tsai@intel.com wrote:=0A=
=0A=
=0A=
=0A=
> sdca_jack_process() unconditionally dereferences component->card and=0A=
=0A=
> card->snd_card at the top of the function. This causes a NULL pointer=0A=
=0A=
> dereference when the SDCA IRQ handler fires after the ASoC card has=0A=
=0A=
> been torn down.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 if (!card || !card->snd_card) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dev, "card not yet bound, d=
eferring jack event\n");=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 rwsem =3D &card->snd_card->controls_rwsem;=0A=
=0A=
> +=A0=A0=A0=A0 kctl =3D state->kctl;=0A=
=0A=
> +=0A=
=0A=
=0A=
=0A=
Don't we still have a time of check/time of use issue here while the=0A=
=0A=
card is being removed - do we do something to stop interrupts being=0A=
=0A=
delivered after the card is unbound?=0A=
=0A=


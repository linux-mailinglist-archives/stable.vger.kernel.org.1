Return-Path: <stable+bounces-219920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ALzM1M0oWmFrAQAu9opvQ
	(envelope-from <stable+bounces-219920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:06:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A601B3070
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9601302C725
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CCE3E8C4D;
	Fri, 27 Feb 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZnAdFzX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CDFAD4B;
	Fri, 27 Feb 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172368; cv=fail; b=MHe3SfsZdctTRhBQOLE/CaqQpPjy9x/tEcycY7P5fTUN1oUAaqwZ97WiSgJZ7W+IVhhhu45Yub7Zfmw50Hx2uclSoN7FO/2F0igQzx0m631AAg0mDYek8ZjwGDxuDOVDzCO6fJi7oYvynLTfuxQ4/sDX5Ci32EZWRprTV/8SMYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172368; c=relaxed/simple;
	bh=4/P8GqMkd05i5ai64r0+QzPvl/RnNesQSebwvUWAzXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uOnw2J2bDOZCpJaVKHukEBd7rMTx6EX+EFlH1PXzZ1a53sDOzuWcUn38q179n7Wh+mbntv/CLiaR2veGgfUlgcQXh88P3/S4cDjoK349bNw0GwXTloY6idNFI+WN1K5ljECoW+M+hXdLTbenmeFylq1Tsn76OmXR2Ud6AhSW/uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZnAdFzX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772172368; x=1803708368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4/P8GqMkd05i5ai64r0+QzPvl/RnNesQSebwvUWAzXg=;
  b=TZnAdFzXUCEvYU0oygT7P9IK+xeshz6OYxe6oeoOijUuEK9zAFiZQOnb
   S3R0HdArn3gCxquWMkOo0+2ONYfCbH+3vIdhdsugBrQ68UcMs1qnBiqYr
   SlUk1OsCutCiJ0E/iLcZNFUDQGBBeALts9fkCtkHwt7GYaroMds/ZUWZc
   ypQa2m8Epq3peJHaxXzItVOUTqtFlf4NhTL+t1rPT0sW3+rzxfPvGJc6d
   bs652yDHlPnbtFjLHdMZyZis10fTSLU7EBAEGthJrU0ctpnYBwDOy0scn
   kd2Dr/ePi2CfSS7PrYe5Enaoz+utQq6wgPMZP9Ov5xtOsHlcYgACIdzoS
   g==;
X-CSE-ConnectionGUID: QGXjvP8gT0eB5yinOQQkkg==
X-CSE-MsgGUID: zaqT2ax4TVa6YjH95TCRuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90829152"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="90829152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:06:07 -0800
X-CSE-ConnectionGUID: gUduI9aAQiuteN7GgrXGYg==
X-CSE-MsgGUID: Bi/mlEM1TBKuw0P2WcRzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="247322752"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:06:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 22:06:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 22:06:05 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 22:06:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BexMlVdWNDch305JRqWW56MRerh0NrHb/5hsMWsPc+8p62cQwkBpNAvKYXjMcFZD6OSylmSpr6+4++CIdTycpQgi0lA9JquqWFURu+EkFlPQWOYVJ20Dkxaz0HLBgz/018Wzxdja3kDVXj4PizUAesKA+GLI11yklgX0vPX3WaOmUqt6w6Y263joxzn4M+WrIK19XUn536o2dYTJVK9wjvku4W6zOo4QWrHahxFOU3n0jwuHSk6Q3QztvmMgR1jXYK2YvGArkEIhLABUARPJK7NOQPbTQUMUN4U6T6/KHhafYgpG7/IYHwrxf0t8Cns06qStSaTsMy86Y9yLpI333g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHCbPUGHh86CcOiZ78tH3xTIUIzVHrECh7NNg3jk+3U=;
 b=pUE4+X3EX/eLL1axd97DyiVZRGypyd/tr9db/Y3/R/gV6eZse5YHxCdAvOvuxK1g5aQGtu+siufzzBCj3TMY7yb964sFlhbwVeGrSTU158OcKeam+3mbx4/8i3upCYeYGP2ir46cirpNYmJ0h9mBUAidvdaVqDDi1jeR2WYxHbOhZ1Qe1HQjrlsHS+RB4NeDcytuOgzI5krVMoVJxH4zhp5aDMbnL8pl548OhqhZtbye47GInjNQdA8WqNFeSzqgnqcKU3tz7TNahASnZp5N1F/Nt8GPl9zqvHRdJGbjhp4G5TgdupMHy9N79HLxProqSZKT5CuPL0NXO0NERumOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 06:06:03 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 06:06:03 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Staniszewski
	<jakub.staniszewski@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix retry for AQ
 command 0x06EE
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix retry for AQ
 command 0x06EE
Thread-Index: AQHchMRPRct0kk4B4k2mXMt8oUJSdLWWS3AQ
Date: Fri, 27 Feb 2026 06:06:03 +0000
Message-ID: <IA1PR11MB62413EE5341BE2AD7BAF7B618B73A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-3-dawid.osuchowski@linux.intel.com>
In-Reply-To: <20260113193817.582-3-dawid.osuchowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|BL3PR11MB6433:EE_
x-ms-office365-filtering-correlation-id: 615fd2ba-42d7-4cbd-9d86-08de75c6499c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: hBQbdE0UR4B0Xd6bPGGW/aQ2FAU6dzcTRC33Cvi/oWkL4hTAyQYrQ/xSiTP6nMDZi2ADcy0lWd0Qchsok4NrXV6fZ82+sdyabLNY0FpCqU5lG87XdtUuRpgeLy/FOTTFack8Z5gF9IBASjqxDh0XjK/KDulbW43RUz7xfrjXHAmEEK6xocsUf6mZ8gg6/RRes2UYDvZpbmDcJJvDZz8L0QT6/reWluiC+WABlKxmTCnckSaKoUAoaS77WZUcK4gRYITjhOxbBf8WeZ3gwppRphUD/Lq4bk+RmGLd4aDU8lST61TC+wnufMKrDkFSHGZuFfUm97qSUbIrFDAcxm1XcQDIQTHzamwAlbc0xpNFBTe9lLbpf9AMhZ/tKa/C0Vtbj2UUpAnuVhIXtlCAOXwQkHAyMKleu6liIjR2hnh2Xzd1U2tgiJ/PDnoX2tbuQTp283Uhrr4hCEfJRlwqnQE09cLi+PD9cFlVUo0WZeFdkuz71yVRctLHprv7o2/NT23/ByVRbtyRXMVSn9Cd5pEIidodr75aSKNYGsEYrDludNoFhahI2NWzpDOPWX58lYwBqsX6eWe1ScHfXRLU3yWse5SWLtqALCJPcB4Lr2h7+txmw4NSbdtvA5xyhx8thvXagD8LnbulhcSRVt9xtcaEjjZ+qq1SSguB2QwWxRt/UNy/po31ibF5mWJF1zWs3RUPYGlSGVtmJY5e4kNZiMSBzzaWvvzEngGTAyUyGA+2hXjgKzU/KTFqAa02plRaOqV9fveBNWDrglbRTZhqVJ6UhAovddZ0XRVOYYseQeaD7lM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmOZc3XEQQRbJ2v6JDDBexUI+XtpkSyypBp0siHAdXJVURQRMsPx7ogyVyrM?=
 =?us-ascii?Q?h8lvrWYOG1BlOSVNC6EnxSnGcwdzdvJ/tylLmP3FuymbwgUXbKVdAVOzQCAO?=
 =?us-ascii?Q?LFv9NA6HWmyoJUgZKflJVohi5ROrMRdVIO4NhTJ2Exb84yEaaS4Az8Rgf4kk?=
 =?us-ascii?Q?LA0Tnl+5JINegfNUpIRZtfGyIChe+6GMQeixIn4LGJ8P5VM5JFB588xGtRjj?=
 =?us-ascii?Q?xvoEaCYm6KIGagQ+1/uswONaP30lVpNhKIuaxBS+o0CrP8HxRvq6rD0r4ddX?=
 =?us-ascii?Q?/vQRlkhyrFgHz1sBNQTDFVnnQ1r8mD9DeLVUzBiY3hDRH1ehMUNryGqVL/N5?=
 =?us-ascii?Q?vmBPQELPuHWGnnhnnzpASnwoaYIUAihqLYllB1oG0E+dTeIvFA6xo2UIG/GH?=
 =?us-ascii?Q?fWdVRdg9kelYC1ZdTGkk0eqyE/RyNOrcahoqaSEyxWBdOADQikVdw7BnF3jD?=
 =?us-ascii?Q?N0p+X+XoW7scdfMNv4uKCPE2/qc95ptTSa8D46wjITNWz/hEmxlGSFw60DH3?=
 =?us-ascii?Q?Nv4FkCYwt7c73NzrcLP3h5WBAY7ZXGYBMSz52rbRvyA8bBhTCbrTKAoUMO1t?=
 =?us-ascii?Q?Cdvv706TB5OEsFtwsZDeMMAIS1Fkjymp0r8YHzEJViUWT4cs8CDpy6giCqr+?=
 =?us-ascii?Q?G8Hd1KE9KxhcCGY+FBJQX4iKfTg7dXY5ditU80Zb7izdQsU8X6/6bUwKuFoW?=
 =?us-ascii?Q?quY93ASHz/ninTUxl2TETny+TSfauFKXpDgW+zfplnnp2JYK0Wb6EkP9lfLe?=
 =?us-ascii?Q?cM4QgaQ93j1VzeJhvxH1V7ZsVOXfN91EU9h8Qx4A21CUK+aB0aa/Y49PpxAe?=
 =?us-ascii?Q?qP5W2vjv+BUaAAefEiONHX3DKIkPgGavuIjXXjENn3wzk/+gLx7r7HS7d7BW?=
 =?us-ascii?Q?tE8dDZYKzoxUmegkMmqrGpWxsuI4okvCONEI8QSl7w+Kf3u3jLbqw7WcYU6L?=
 =?us-ascii?Q?f8Z39Dc8KL6ksFX4Q2HfDTZCf1wC7I+HLz8FoZk6wiHobvLAYdNzVzloeP1X?=
 =?us-ascii?Q?rWQucRVtqsH0tbRHqaCD/yEgmTxu1lsvIwZZGM/uWU6CDYnza5VoyDZHwbjC?=
 =?us-ascii?Q?4xLNsfbXabPMXXT6XRdtkIVNC2nAcAhoOy6h5SxAea59RNR+qn+Xz2ASV032?=
 =?us-ascii?Q?FAAs7lsRD34fhOcFXOKjd8s/cAQjnsS8wSFktrFeYAZ5Tz5USRrUqxoNFkqj?=
 =?us-ascii?Q?Z008qCsT0iIz/2TVrr9aUS4GtiuMvb34VoKEX/ih7lZOfBeEgBmJJocKW5Wk?=
 =?us-ascii?Q?5Wn93QPHnYN3RYGkuxya7yV/BjaqRdfpSA9M9NafkuocYkVLv+Z2Opop5kos?=
 =?us-ascii?Q?gz3ebMVARdmAOJBbwqJ9kMpAjx9pwXNyGL5Zk6jcGFwEG0BXBwVC2VyBlmJ2?=
 =?us-ascii?Q?0GXN8V7QH9HlawJ0eOd3A7AxES6ZxIFeijnHBCzDjeGCq7mh4YqcMRUstWnt?=
 =?us-ascii?Q?l+dl1A7iwbH+u/sspNh2i1Ih3IRzk1OwtVACpKUsS8Wb4NkKgofA3al+3KHs?=
 =?us-ascii?Q?M55xkGI3RZp+IVfeqa6sJIEBF0rOHhs9MwnmNJWQndoYfqyQdmMZC6gHm5Kq?=
 =?us-ascii?Q?o0ZHIx7vdScL6ISKtnDvJpJHNm72H55EtY21DumMjZrTAM++uZxYXDNqDrzT?=
 =?us-ascii?Q?eHN9m4haD0npi7xDYMYdXR+HXaejVU4D8C9iRVj9QDF0Vj1asjJo4tKzSxVH?=
 =?us-ascii?Q?G1WXZvW3y2DwNMmoehCqAn6xv1bOfnjm8+Gkz/tne1NeS1/SLTnsF5QYvN0L?=
 =?us-ascii?Q?HfnbSgK7qSwZyszQuihJRvSheHcb8C8WAod4rIXhlI+bU9mguxK/jim4YoYi?=
x-ms-exchange-antispam-messagedata-1: b4aVquQYwuVm3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615fd2ba-42d7-4cbd-9d86-08de75c6499c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 06:06:03.1547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4p8MexihNjiFR2F+mdnRvSutkpfjoselMuaQq82EayJ6iWxXalmQRn37oGt6dRzDvzeWDSrajSAnLWHU+kNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219920-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:url,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 75A601B3070
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
awid Osuchowski
> Sent: 14 January 2026 01:08
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Jakub Staniszewski <jakub.staniszewski@linux.=
intel.com>; stable@vger.kernel.org; Dawid Osuchowski <dawid.osuchowski@linu=
x.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitszel=
, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/2] ice: fix retry for AQ comm=
and 0x06EE
>
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
>
> Executing ethtool -m can fail reporting a netlink I/O error while firmwar=
e link management holds the i2c bus used to communicate with the module.
>
> According to Intel(R) Ethernet Controller E810 Datasheet Rev 2.8 [1] Sect=
ion 3.3.10.4 Read/Write SFF EEPROM (0x06EE) request should to be retried up=
on receiving EBUSY from firmware.
>
> Commit e9c9692c8a81 ("ice: Reimplement module reads used by ethtool") imp=
lemented it only for part of ice_get_module_eeprom(), leaving all other cal=
ls to ice_aq_sff_eeprom() vulnerable to returning early on getting EBUSY wi=
thout retrying.
>
> Remove the retry loop from ice_get_module_eeprom() and add Admin Queue
(AQ) command with opcode 0x06EE to the list of commands that should be retr=
ied on receiving EBUSY from firmware.
>
> Cc: stable@vger.kernel.org
> Fixes: e9c9692c8a81 ("ice: Reimplement module reads used by ethtool")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Link: https://www.intel.com/content/www/us/en/content-details/613875/inte=
l-ethernet-controller-e810-datasheet.html [1]
> ---
> drivers/net/ethernet/intel/ice/ice_common.c  |  1 +  drivers/net/ethernet=
/intel/ice/ice_ethtool.c | 35 ++++++++------------
> 2 files changed, 15 insertions(+), 21 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)


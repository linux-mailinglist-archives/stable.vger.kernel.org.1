Return-Path: <stable+bounces-161538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3FAFFB72
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 09:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93271C84008
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72E28B4E2;
	Thu, 10 Jul 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="rVPQrj77"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1659286D60;
	Thu, 10 Jul 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134235; cv=fail; b=YVhUYYPZV2IgzGLzJ8TcESeV1pzsq5xMGYXQodBSetXR40nSqgoyyI9MyPL6dNUyotdxlr7zqskOAZdNU+YYLQhPFlkUhfcWeeTEGEXNPPLhTurHwZQ5TInU+QLi6C2AwrLKBy+y4tjmtxmtdd3Xy796qVWOzrKCHEwYxl7PDKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134235; c=relaxed/simple;
	bh=OjB9FPFQhVv4KLeTGZRNpKq81GG4wUeQCbT02mlUSos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvgKKl1tvBD/JdHYgmlSOai8YCdH51pMeSQIwCDlUkVoSKdxHDmcC2nrl4Mn64Kp9G10JxsIDN+GF4ZPYr7lQB5bfnZVhEFb4LfDieUQXSLdfdJO0aE1rq+dYuzfEnEvkXYPdOgFz8Oy0Xpa0RcXKp04LmD/yv/ut98GbYC+784=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=rVPQrj77; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1752134233; x=1783670233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OjB9FPFQhVv4KLeTGZRNpKq81GG4wUeQCbT02mlUSos=;
  b=rVPQrj775pL/MfEhRNpnUumWKGJ1bOO9YQRSZfJUHM50uHSYLu1na3qk
   y/EzZ+Md4WV44rVRBJNEjDQekt99YlvseRH3sWEHZCGYaAXakv+r9eGV7
   YHb/rPi8jq3CimxYxfCTTyBPUVyUJI5c0OdZxROcZ8n5vILMv9k4MvPk1
   iwxlQ5uVX3sVEv3JBfwJiisc+TyegMjOURdLCdyLLyWqh+itZgKALkUWJ
   MVyU4LhvYRBXectM2lmFKtGDntItjc3Q9ZT0Nk8SgHC0hjaaf3uOBeeD4
   FnxM3xLuAq7JaCbGIM3Vu3h/wJBzZam0JKcwFpwzPV8DAXw8i7sTMLdxT
   w==;
X-CSE-ConnectionGUID: Py5Q+y+cTReiKf0bjbeHNA==
X-CSE-MsgGUID: U6WSoyIYSg+ut8RAkLPqxQ==
Received: from mail-dm6nam12on2130.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.130])
  by ob1.hc6817-7.iphmx.com with ESMTP; 10 Jul 2025 00:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW67GF+h1Mnl+SoB2Fq+AtfGkwjJZOft9BuY0g3uI6piOt1e4RfgFDYAn7OgAv30qRzinSROxCDlgPD2Q78zAh8xTCR4g2LQS3vntKUYkvwXyUYj2fT2cGp69Cf9ZuEHM7wV00KfasIdAVD4uTQePLMS7i87EZ5JliF9Kex2q7HbhS2C+ZMaKiBUaNTf318OItmLo+lfNWBA3gvAg6nrp28F0p47fcYA98jomfZt7ZOPrynKUuJfD3hjc8BDpS2ulofHQuQ6Vto/Y92pFFiHCk8N7pCQ34/bZF3Ay3iPETbDGrvNq1MgckuvBSFwWrLmMXIO+G3g1Mf+864Ntr4sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjB9FPFQhVv4KLeTGZRNpKq81GG4wUeQCbT02mlUSos=;
 b=Zdw8uVFF/IWm2VC6x0i6sIb594yUDe+xP4E9BY62VS6foVfbI+RV1EjLcIGXLNvnIddNTBanyqrrzTgRWFov/PpLt8YDkZmh7bHUG5Abq5+d2X/T+Yveshq3fyt5pgYIb8tteVxvPWqhw8fKQu0PQ2Fcd5y4v5yilh3Sa1GfQqnb4fM0PFpyL4LPhG7xlhjreSCIhS6Nw39J+zGCbORswLK4waT5qvyxZIePVYCpV3O3WJX8Y4Gpx36dQTQ3Kmf6F7V/ei3W2AHfR2OGcfj/vlV5tnxiE1RoaPQ/JCS6fBURMj2L7pVG+dKdm92Q7QE5/k+ltKvBkq+7cpJbOAAQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SJ2PR16MB5192.namprd16.prod.outlook.com (2603:10b6:a03:4fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 10 Jul
 2025 07:57:03 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 07:57:03 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg
	<quic_sartgarg@quicinc.com>, Abraham Bachrach <abe@skydio.com>, Prathamesh
 Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, Sagiv Aharonoff
	<saharonoff@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current limit
 handling
Thread-Topic: [PATCH 2/2] mmc: core: sd: Fix and simplify SD card current
 limit handling
Thread-Index: AQHb4PkiFMMrOw3qa0usXaEaGtyRPrQofVGAgAFjF6CAACN9gIABE+Jw
Date: Thu, 10 Jul 2025 07:57:03 +0000
Message-ID:
 <PH7PR16MB61968C1EEDFF40E26DF191CFE548A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-3-avri.altman@sandisk.com>
 <CAPDyKFrbjCi4VdEdeUoVG7wbgwXS2BcOZV4yzh8PiTc_V+rxug@mail.gmail.com>
 <PH7PR16MB6196923468505A9E81C72A69E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
 <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com>
In-Reply-To:
 <CAPDyKFooHB5b9YXhifr8XLbw5OB-Nk=eik0smtRbKLYkEOBRog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SJ2PR16MB5192:EE_
x-ms-office365-filtering-correlation-id: bac9a7a7-ecbe-46d0-5fdd-08ddbf875ba7
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUJrbDdaek8rcndkcjdUS3hHSUJTL0IyVmxXcXhTT0czWmxHRWxLU09mYnFP?=
 =?utf-8?B?cDhVREJlbnVoUUMyV3I1RmNmWXAzL05MczNjZ0N1Z2huWGhRMTE1NWF5QVhm?=
 =?utf-8?B?d1dBb0FiU29JbE11SmJ0V2M5bXVhUncwdUIyemZZRkZSVktaRitOdkJWUGVF?=
 =?utf-8?B?R3lUbDQxalFJWFZBZHlOcFRNR213Z0VXKzFxeWxoUUVTa1JVaTJiQ1graUtH?=
 =?utf-8?B?TXc3cFU1LytoNU03b2FMMnArMndDYjdiMytvNk1pYU4wbXJleHlWSzRuS3V3?=
 =?utf-8?B?S1VIM1lkTUk2UWZqYXQ5YWk1V3FNNW1Bc1NlWkJZb0lXYTFSV3I3YzZWaVNU?=
 =?utf-8?B?Rk5KVVZHeng0QWp6anhDa09KTEUrVGFkSXdtek1mdlVVYWl4UUR6Qms2eVM5?=
 =?utf-8?B?MTVndFZkUStCYUxoeWZIVm03bjRtY2JPMDdoTmpNUVhiam5XVE5rWVBVM3dI?=
 =?utf-8?B?SFA3eWZBRks3MGJvZ2UybjR4dnlsNTM5MEZGdnZzdnR0TzNCbWNucHo0MVQv?=
 =?utf-8?B?TXViNFZZLzJXU1dhTGE5ejUxR1EvczQ2RGpmdDFpczNCNlBLYUZJM0lxdkI0?=
 =?utf-8?B?Vm9UOWpOTVVTU2pTUmk1VlgyNklLelhPc2dzQzBZNzRJSGpzeUtrejQrN252?=
 =?utf-8?B?TFQxMXVGZW56MGNMVTh0LzBieTVzM3lTN1BIeVNJRUx4dVVseEtUdFlQZkkr?=
 =?utf-8?B?cEYzSXBac3FMMldQemJ3K2t0MkdKQlVPY01qVHREazQreGtZZkR0a1dHZXhu?=
 =?utf-8?B?QWdRZnhaNG1qMXlUS2M0L0dIV3lHZWNncVZ4RmFKNUFiYnFnbFZpNGNhd1dt?=
 =?utf-8?B?dm1YYlkxSm5mcFUwTGZ1RkNxbkpqQ0QrRDhDbm1NRHhKZEplQ0tMN0RPRHdV?=
 =?utf-8?B?Y3daQ25DdWM5cy91S2R0ZkRYdk9VY3FFMmVlaDZ4VGQzaWkwcUdLWnJBTk8x?=
 =?utf-8?B?a203UFRlQTZTTktTL1ZEK1J3NzdWTi9PZnphdGltWUZZRHd2MXdJakNpTDRl?=
 =?utf-8?B?VUNPZnFlLzhEMUtTNGJtNG5nUkk3YWJqcDlxMVd5b3NzOXlyZ2RmSXZDVU92?=
 =?utf-8?B?ZktLeWluSXY5d0NNc011VEFkVTdSQWdVOWZmVDF4VEo1WEo2M2c4b0JqeU5P?=
 =?utf-8?B?ZFR5aHllNFFUV05EbTVveEJCOFl4ZWdBTy84VEx2NTA5RDdiLzFOdkxFOVNW?=
 =?utf-8?B?cmtIWnNCWW1ZNGFBTHM2TlZ4RjB3Wml2aGxLbHNnVngwdmVNdVRydTlTTy9y?=
 =?utf-8?B?M250RXBkQTZCZno2cXBYTXVmY1pSL0lKbmdmZ1dCUFY4THZsVU9WWnZkN1B2?=
 =?utf-8?B?V3NENC8yU081VkUxZTRGcExzN2I0dHd3elY5TWlRR29PQXVTcVFEVU1BOHpG?=
 =?utf-8?B?VExBMjExYUVUNFBaSXd2ZXQvSlA3UllFUlNJdTQzbGtROTdaQTVjbThlUzlJ?=
 =?utf-8?B?S3pZZTVaR05GS05VTWVoUEVkdE02L3lvM3dhbkhwVEJkSEo4UWtSdzZWazVU?=
 =?utf-8?B?UkRaeVBLdGt6MndGTFJlS1ZUTFdiOTE2bUNia0Z6bjd5MGtzMnp2cDA2MEd6?=
 =?utf-8?B?UWNHWGg1aXFNeVhoSVRRZzVHaWorYndwaEkxWTVydU5PUjRzQWxJemZleEZQ?=
 =?utf-8?B?ZlFDZTN6ZGE4MkJ1cmR4MllSbHQ3S0RFMVE3Y0dxaDBXTzNnWVZaYVNRYVJY?=
 =?utf-8?B?UXFWdmZ4cE9teUZibSttVzlSdGNaNzVuNGxPVzNOa0g0VkRUSWhsTENVMGNi?=
 =?utf-8?B?NE9NMnVYNWN1dHNaTFk3MUt1dURxQjAzVHlBU0l1YWx3OVpKaXFXS3lNa3lZ?=
 =?utf-8?B?MWY2MEk0ZitYRWNpYUtKQjRsV3VHb0NrZEx2eEJzenJXdzl0NWtnR1pPWjdu?=
 =?utf-8?B?MVk0YlN6TkROaHBOdXFQVzlHcUZERnpYMUpFTkl2ZS9xSm11eWdiSmNyRHZ0?=
 =?utf-8?B?YlRENVdoQmZhbnQvVFZmaDhuM3FRdjIwd3dOek4wWTYrRTgzb0dBRkNydlcy?=
 =?utf-8?B?RFFmdmVMV2pnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXBtcG00WVdNYkNlTVNWQTJhQk84OWlCQWRnK2tDOXBLeFVBR290K05tLzcr?=
 =?utf-8?B?ZWhleWdwTUs5d0sxSURhMzQveU5nOVNCQWZSQlYyRHdsTm5KNHkzWmQ5Uzgr?=
 =?utf-8?B?SEp1bHJvMTMyQitvdWdISm14VzFyRnU3aDc5MVZXT2o3MEM4dC82b0ppZEJo?=
 =?utf-8?B?NTlDY0lHek5NRk1mbjBNTGlrTU53NmFTU09HeUdKUmxSTmpaaysyNVR4WERO?=
 =?utf-8?B?SGFZTGRPTWc4TWJXK3dBRUF0TURoQ2Z6TURnK2I3aU9kbWhrM0JKcmVXenh5?=
 =?utf-8?B?OGlhc3ZoR2tpeWxEK0FmTWRZYWtWR3M3ekVoWjk1T2hHaWt2V1JzOTVoOWFk?=
 =?utf-8?B?NHZXbHMzR2h3U3pJQnRqVUJ2ekRkQXZmV3l6dERYYTBGMWtjWTBXTHdkdXFk?=
 =?utf-8?B?aS8yNWdmTFFJOXJWSTNZOCtkZW5wcTBZZ0cveXlPMk9ycUlsa0ZWanRQTkY0?=
 =?utf-8?B?UFA5N2l1dHd6Rjh2amFDWWhKeCsyNXExQ3VKQndGMDBzcjNROGhyUkVtQkRJ?=
 =?utf-8?B?YjhsQ01uMlhPREEybzdjZTdMMGptSnA0REJUem4wUUdhMGRQTS9iTFJxcVcv?=
 =?utf-8?B?TXk4UHJSUDN3V2tDVXhTQmltWkdRWEUrT1BHelJqbExVMXpyeXB1RDV2NlVT?=
 =?utf-8?B?TVVYdjRBanQrczc1VXRra0I3ejdkemczZGJ2bW1tbURQT0VtN3V5ZE1JWCt0?=
 =?utf-8?B?OEV3enpwbkVOWmtBRm1oZWt2MGxQdjdySENWYnZvb24vSXhwYk9yaWpUdkRL?=
 =?utf-8?B?NWNZM29sRldEVHdFRDVvdUhyMU54L0JmbkpPd0VOMEpBV2lkemNYMEJxSFVi?=
 =?utf-8?B?aGxORFljeDlCZ1hkbmxTQ2RDU3dZUDA0NVh0eWhQeG4vOGZMY0dzaEsxVnov?=
 =?utf-8?B?bHNQZTlEOFpVQmhYamlLYTdYRDZCUXdFZXRsYVQxU3NHNXlZNHdEWTU5dVB4?=
 =?utf-8?B?cWxOOEkwSXB4TmdzVTVHS1hiNFNoN2xJQkI5Z0pNZ2FTMGdhdGNkYzgwaHBo?=
 =?utf-8?B?YlQ1UjJGVXpmblVCUFNleWZ6UWh6QVNSTGI0OFZiblVJb25xR252UmFpWGxQ?=
 =?utf-8?B?RmpVUllkL2xlbzBWYndIWE5xTUVTUkd4b0xGeUdrYVo3RTFtQXc5VEI3UFhm?=
 =?utf-8?B?ay9SNi9Gb3VMR2wreXA4cUNEZmpZc0xiMUs5c1hrby9tYm82cWpjRjRZK2tT?=
 =?utf-8?B?SHFMb016VDFqamRmQUJYc1dMaEMxUGd4c0UvZVFtbFBaMXJnNFJUb016YkZX?=
 =?utf-8?B?ZFU4OUozQ1ByT1ZsanhHRGRzbVprRmIyM1FWVjhZSjBwZWJSL2Fjb3VKTHJS?=
 =?utf-8?B?Rzg1L0xkUkFtN2pQU25rYjBZaTRqSmcvdXZJOTdYalpqSUh3K2xtOUVDMDdJ?=
 =?utf-8?B?TzZMTVl6RnliSGlIanduSzNDdkJTSGgvb2tmVU1QL1VCUWFDcEZkRk1SUmN6?=
 =?utf-8?B?WjBUU1VsUWxnbzJ6OGk2SVBxUW5EbEMzUTVGL2Q4NXErQ3VUTWpxVjVrcjZX?=
 =?utf-8?B?Q3BUUFZxRmpoQ1BsMzFoemN6cm92VSsvVVBSSTg2NzZPSE5ldkxFMHFhcDdF?=
 =?utf-8?B?TE9LVCsyZFpZUVo0cy95N3lESzRZN0I3azBRSEtVZy9TZUZ4QTI5NG53bjU3?=
 =?utf-8?B?MnZlOE1DWk5VWSt5c1k2ckpWQlFNVlBmQjVSNkJtT2s3SzJTOTQyNDg5M0xa?=
 =?utf-8?B?dGNzeDlCWkxCMXJvdkR0Z3hreHJlY29ldnFiemdBRmtTblFYaEVDYkJYdHRa?=
 =?utf-8?B?N1Y3TXN2TVZuem15OUduVlE5VGpSM2FDWWozTnkvR1hkc3lEekx0NXE1bXln?=
 =?utf-8?B?aEZ1OWtEOU1aQ2pTNGR6bGowdExUNkd5VThBYjhkN3F0Z0syWUVvam9sWDVH?=
 =?utf-8?B?YzE3blBNUXUyTVJVMk91TUQrenB5SXlTYTgraVZRZVFPSGRidFFzaTh4b2VS?=
 =?utf-8?B?RE1yZjlNeG5BV3JGckxnZTZOM1QvdFJNekdNR3hPMlNvd2Q1MkF0aHQ4c0R4?=
 =?utf-8?B?NTE0aFV5WGZRMXZVZThjeVBGOUVkYU1hSkNzL0M5T3pMWWlFdVBzZDRoOU5j?=
 =?utf-8?B?M01JSnhEa21aVloxMmtpQko2cDNnVjh2dXV0YVc5V3NLUm9iQlpiYk9qVi85?=
 =?utf-8?Q?s+431+KJaymlWRBjnnNVS8fzg?=
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
	7VQ2XBmiVmYshJdp7rnQ87bwqopfEUmh8qeD1UsvTlXJRfy22slkG3MYEp5oUNfxFAkNmK6LqeUXcAh6TZ+QTS8KfKE/YVfN2JWYJi+846nnIPqZ0vaSc1Kc8g5cHBV5lQ5fXUMe1PkaZTDOUDO9mzfdHNHP5iDlTrn7sXW7BpVgTS2tlb9UVS8diHZ11T1RHFVeA6enDHm0VD9Yt3pNPHxiKygdsZViEbvOnkeZXWpg+pu1uiXKJ7xXsnrvJWjH5QwAloyIN0FeKs4JAhtYUoU9qQYK/Rw80PG/iHJ7SiedULY+5W9sYm3NHFOmNQyOUi6XRPRWqzfjA9XOPmhFogjpOYUaXF+xD1adv6jYrODvt2YZO08y5w4vIK2mTPgSbURl5LVanfhxdZ9sAdeq+hr8tH9/a46vtTQe45lHSHpSR84glnky1FYiw/ahG2JkSnCl0uSS2k2ZEGlf3lWphZHh211RTgoStgqDflZM6zg9T+HlPOLvT0MWy1WxaOJYL7G/ZNevkfXpZdp0nksbYXtdoVpCq4YnO5cRg+jO90yjk1vrq5u0Pks32S0zSmFdT5YyoaMvP1v03kEwk4aTdBnkxBXaL6Mxs3AqXlmuKxe3Y39a1S5gl3ounhZQeSWkeBFTMWLpxaigIltuqEug5Q==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac9a7a7-ecbe-46d0-5fdd-08ddbf875ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 07:57:03.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBHbbvuKtAD1zcIYm7e59JQR29NfeeOk7rauX+4VfbVBrwrsJT5Otlcee0nYX0bSgYwWn7mMXOZrNY9B2s2Smg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5192

PiANCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgLyoNCj4gPiA+ID4gICAgICAgICAg
KiBDdXJyZW50IGxpbWl0IHN3aXRjaCBpcyBvbmx5IGRlZmluZWQgZm9yIFNEUjUwLCBTRFIxMDQs
DQo+ID4gPiA+IGFuZA0KPiA+ID4gPiBERFI1MCBAQCAtNTc1LDMzICs1NzQsMjQgQEAgc3RhdGlj
IGludCBzZF9zZXRfY3VycmVudF9saW1pdChzdHJ1Y3QNCj4gPiA+IG1tY19jYXJkICpjYXJkLCB1
OCAqc3RhdHVzKQ0KPiA+ID4gPiAgICAgICAgIG1heF9jdXJyZW50ID0gc2RfZ2V0X2hvc3RfbWF4
X2N1cnJlbnQoY2FyZC0+aG9zdCk7DQo+ID4gPg0KPiA+ID4gTG9va2luZyBhdCB0aGUgaW1wbGVt
ZW50YXRpb24gb2Ygc2RfZ2V0X2hvc3RfbWF4X2N1cnJlbnQoKSwgaXQncyB2ZXJ5DQo+IGxpbWl0
aW5nLg0KPiA+ID4NCj4gPiA+IEZvciBleGFtcGxlLCBpZiB3ZSBhcmUgdXNpbmcgTU1DX1ZERF8z
NF8zNSBvciBNTUNfVkREXzM1XzM2LCB0aGUNCj4gPiA+IGZ1bmN0aW9uIHJldHVybnMgMC4gTWF5
YmUgdGhpcyBpcyBnb29kIGVub3VnaCBiYXNlZCB1cG9uIHRob3NlIGhvc3QNCj4gPiA+IGRyaXZl
cnMgdGhhdCBhY3R1YWxseSBzZXRzIGhvc3QtPm1heF9jdXJyZW50XzE4MHwzMDB8MzMwLCBidXQg
aXQga2luZCBvZg0KPiBsb29rcyB3cm9uZyB0byBtZS4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHdl
IHNob3VsZCByZS13b3JrIHRoaXMgaW50ZXJmYWNlIHRvIGxldCB1cyByZXRyaWV2ZSB0aGUNCj4g
PiA+IG1heGltdW0gY3VycmVudCBmcm9tIHRoZSBob3N0IGluIGEgbW9yZSBmbGV4aWJsZSB3YXku
IFdoYXQgd2UgYXJlDQo+ID4gPiByZWFsbHkgbG9va2luZyBmb3IgaXMgYSB2YWx1ZSBpbiBXYXR0
IGluc3RlYWQsIEkgdGhpbmsuIERvbid0IGdldCBtZQ0KPiA+ID4gd3JvbmcsIHRoaXMgZGVzZXJ2
ZWQgaXQncyBvd24gc3RhbmRhbG9uZSBwYXRjaCBvbiB0b3Agb2YgJHN1YmplY3QgcGF0Y2guDQo+
ID4gSSBzdGlsbCBuZWVkIHRvIGNvbnN1bHQgaW50ZXJuYWxseSwgYnV0IFllcyAtIEkgYWdyZWUu
DQo+ID4gVWx0aW1hdGVseSBob3dldmVyLCBDTUQ2IGV4cGVjdHMgdXMgdG8gZmlsbCB0aGUgY3Vy
cmVudCBsaW1pdCB2YWx1ZSwgc28NCj4gbXVsdGlwbHlpbmcgYnkgdm9sdGFnZSBhbmQgZGl2aWRp
bmcgaXQgYmFjayBzZWVtcyBzdXBlcmZsdW91cy4NCj4gPiBIb3cgYWJvdXQgYWRkaW5nIHRvIG1p
c3NpbmcgdmRkIGFuZCB0cmVhdCB0aGVtIGFzIG1heF9jdXJyZW50XzMzMCwgbGlrZSBpbg0KPiBz
ZGhjaV9nZXRfdmRkX3ZhbHVlPw0KPiA+IE1heWJlIHNvbWV0aGluZyBsaWtlOg0KPiA+DQo+ID4g
Ky8qDQo+ID4gKyAqIEdldCBob3N0J3MgbWF4IGN1cnJlbnQgc2V0dGluZyBhdCBpdHMgY3VycmVu
dCB2b2x0YWdlIG5vcm1hbGl6ZWQNCj4gPiArdG8gMy42DQo+ID4gKyAqIHZvbHQgd2hpY2ggaXMg
dGhlIHZvbHRhZ2UgaW4gd2hpY2ggdGhlIGNhcmQgZGVmaW5lcyBpdHMgbGltaXRzICAqLw0KPiA+
ICtzdGF0aWMgdTMyIHNkX2hvc3Rfbm9ybWFsaXplZF9tYXhfY3VycmVudChzdHJ1Y3QgbW1jX2hv
c3QgKmhvc3QpIHsNCj4gPiArICAgICAgIHUzMiB2b2x0YWdlLCBtYXhfY3VycmVudDsNCj4gPiAr
DQo+ID4gKyAgICAgICB2b2x0YWdlID0gMSA8PCBob3N0LT5pb3MudmRkOw0KPiA+ICsgICAgICAg
c3dpdGNoICh2b2x0YWdlKSB7DQo+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMTY1XzE5NToNCj4g
PiArICAgICAgICAgICAgICAgbWF4X2N1cnJlbnQgPSBob3N0LT5tYXhfY3VycmVudF8xODAgKiAx
ODAgLyAzNjA7DQo+ID4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgY2FzZSBN
TUNfVkREXzI5XzMwOg0KPiA+ICsgICAgICAgY2FzZSBNTUNfVkREXzMwXzMxOg0KPiA+ICsgICAg
ICAgICAgICAgICBtYXhfY3VycmVudCA9IGhvc3QtPm1heF9jdXJyZW50XzMwMCAqIDMwMCAvIDM2
MDsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBjYXNlIE1NQ19WRERf
MzJfMzM6DQo+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMzNfMzQ6DQo+ID4gKyAgICAgICBjYXNl
IE1NQ19WRERfMzRfMzU6DQo+ID4gKyAgICAgICBjYXNlIE1NQ19WRERfMzVfMzY6DQo+ID4gKyAg
ICAgICAgICAgICAgIG1heF9jdXJyZW50ID0gaG9zdC0+bWF4X2N1cnJlbnRfMzMwICogMzMwIC8g
MzYwOw0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIGRlZmF1bHQ6DQo+
ID4gKyAgICAgICAgICAgICAgIG1heF9jdXJyZW50ID0gMDsNCj4gPiArICAgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgICByZXR1cm4gbWF4X2N1cnJlbnQ7DQo+ID4gK30NCj4gDQo+IEkgdGhpbmsg
aXQncyB3YXkgYmV0dGVyIHRoYW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaW4NCj4gc2Rf
Z2V0X2hvc3RfbWF4X2N1cnJlbnQoKS4NCj4gDQo+IFN0aWxsLCBJIHN0aWxsIHRoaW5rIGl0J3Mg
d2VpcmQgdG8gaGF2ZSB0aHJlZSBkaWZmZXJlbnQgdmFyaWFibGVzIGluIHRoZSBob3N0LA0KPiBt
YXhfY3VycmVudF8xODAsIG1heF9jdXJyZW50XzMwMCBhbmQgbWF4X2N1cnJlbnRfMzMwLiBUaGF0
IHNlZW1zIGxpa2UgYW4NCj4gU0RIQ0kgc3BlY2lmaWMgdGhpbmcgdG8gbWUsIHVubGVzcyBJIGFt
IG1pc3Rha2VuLg0KPiANCj4gSSB3b3VsZCByYXRoZXIgc2VlIGEgbW9yZSBmbGV4aWJsZSBpbnRl
cmZhY2Ugd2hlcmUgd2UgbW92ZSBhd2F5IGZyb20gdXNpbmcNCj4gaG9zdC0+bWF4X2N1cnJlbnRf
MTgwfDMwMHwzMzAgZW50aXJlbHkgYW5kIGhhdmUgYSBmdW5jdGlvbiB0aGF0IHJldHVybnMgdGhl
DQo+IHN1cHBvcnRlZCBsaW1pdCAod2hhdGV2ZXIgdW5pdCB3ZSBkZWNpZGUpLiBNYXliZSBpdCBh
bHNvIG1ha2VzIHNlbnNlIHRvIHByb3ZpZGUNCj4gc29tZSBhZGRpdGlvbmFsIGhlbHBlcnMgZnJv
bSB0aGUgY29yZSB0aGF0IGhvc3QgZHJpdmVycyBjYW4gY2FsbCwgdG8gZmV0Y2gvdHJhbnNsYXRl
DQo+IHRoZSB2YWx1ZXMgaXQgc2hvdWxkIHByb3ZpZGUgZm9yIHRoaXMuDQorQWRyaWFuDQoNCklJ
VUMsIHlvdSBhcmUgbG9va2luZyBmb3IgYSBob3N0LT5tYXhfcG93ZXIgdG8gcmVwbGFjZSB0aGUg
YWJvdmUuDQpIb3dldmVyLCBnaXZlciB0aGF0Og0KYSkgdGhlcmUgaXMgbm8gcG93ZXIgY2xhc3Mg
aW4gU0QgbGlrZSBpbiBtbWMsIGFuZCB0aGUgY2FyZCBuZWVkcyB0byBiZSBzZXQgdG8gYSBwb3dl
ci1saW1pdA0KYikgdGhlIHBsYXRmb3JtIHN1cHBvcnRlZCB2b2x0YWdlcyBjYW4gYmUgZWl0aGVy
IGJlIGdpdmVuIHZpYSBEVCBhcyB3ZWxsIGFzIGhhcmQtY29kZWQgYW5kIGl0J3Mgc2hhcmVkIHdp
dGggbW1jLCBhbmQNCmMpIHRoZSBwbGF0Zm9ybSBzdXBwb3J0ZWQgbWF4IGN1cnJlbnQgaXMgZWl0
aGVyIHJlYWQgZnJvbSB0aGUgc2RoY2kgcmVnaXN0ZXIgYXMgd2VsbCBhcyBjYW4gYmUgaGFyZC1j
b2RlZA0KSSBhbSBub3Qgc3VyZSBpZiBhbmQgd2hlcmUgd2Ugc2hvdWxkIHNldCB0aGlzIG1heF9w
b3dlciBtZW1iZXIsIGJ1dCBJIGFtIG9wZW4gZm9yIHN1Z2dlc3Rpb25zLg0KDQo+IA0KPiA+ICsN
Cj4gPiAgLyogR2V0IGhvc3QncyBtYXggY3VycmVudCBzZXR0aW5nIGF0IGl0cyBjdXJyZW50IHZv
bHRhZ2UgKi8gIHN0YXRpYw0KPiA+IHUzMiBzZF9nZXRfaG9zdF9tYXhfY3VycmVudChzdHJ1Y3Qg
bW1jX2hvc3QgKmhvc3QpICB7IEBAIC01NzIsNyArNjAyLDcNCj4gPiBAQCBzdGF0aWMgaW50IHNk
X3NldF9jdXJyZW50X2xpbWl0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwgdTggKnN0YXR1cykNCj4g
PiAgICAgICAgICAqIEhvc3QgaGFzIGRpZmZlcmVudCBjdXJyZW50IGNhcGFiaWxpdGllcyB3aGVu
IG9wZXJhdGluZyBhdA0KPiA+ICAgICAgICAgICogZGlmZmVyZW50IHZvbHRhZ2VzLCBzbyBmaW5k
IG91dCBpdHMgbWF4IGN1cnJlbnQgZmlyc3QuDQo+ID4gICAgICAgICAgKi8NCj4gPiAtICAgICAg
IG1heF9jdXJyZW50ID0gc2RfZ2V0X2hvc3RfbWF4X2N1cnJlbnQoY2FyZC0+aG9zdCk7DQo+ID4g
KyAgICAgICBtYXhfY3VycmVudCA9IHNkX2hvc3Rfbm9ybWFsaXplZF9tYXhfY3VycmVudChjYXJk
LT5ob3N0KTsNCj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICAgIC8qDQo+
ID4gPiA+IC0gICAgICAgICogV2Ugb25seSBjaGVjayBob3N0J3MgY2FwYWJpbGl0eSBoZXJlLCBp
ZiB3ZSBzZXQgYSBsaW1pdCB0aGF0IGlzDQo+ID4gPiA+IC0gICAgICAgICogaGlnaGVyIHRoYW4g
dGhlIGNhcmQncyBtYXhpbXVtIGN1cnJlbnQsIHRoZSBjYXJkIHdpbGwgYmUgdXNpbmcgaXRzDQo+
ID4gPiA+IC0gICAgICAgICogbWF4aW11bSBjdXJyZW50LCBlLmcuIGlmIHRoZSBjYXJkJ3MgbWF4
aW11bSBjdXJyZW50IGlzIDMwMG1hLCBhbmQNCj4gPiA+ID4gLSAgICAgICAgKiB3aGVuIHdlIHNl
dCBjdXJyZW50IGxpbWl0IHRvIDIwMG1hLCB0aGUgY2FyZCB3aWxsIGRyYXcgMjAwbWEsIGFuZA0K
PiA+ID4gPiAtICAgICAgICAqIHdoZW4gd2Ugc2V0IGN1cnJlbnQgbGltaXQgdG8gNDAwLzYwMC84
MDBtYSwgdGhlIGNhcmQgd2lsbCBkcmF3IGl0cw0KPiA+ID4gPiAtICAgICAgICAqIG1heGltdW0g
MzAwbWEgZnJvbSB0aGUgaG9zdC4NCj4gPiA+ID4gLSAgICAgICAgKg0KPiA+ID4gPiAtICAgICAg
ICAqIFRoZSBhYm92ZSBpcyBpbmNvcnJlY3Q6IGlmIHdlIHRyeSB0byBzZXQgYSBjdXJyZW50IGxp
bWl0IHRoYXQgaXMNCj4gPiA+ID4gLSAgICAgICAgKiBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYXJk
LCB0aGUgY2FyZCBjYW4gcmlnaHRmdWxseSBlcnJvciBvdXQgdGhlDQo+ID4gPiA+IC0gICAgICAg
ICogYXR0ZW1wdCwgYW5kIHJlbWFpbiBhdCB0aGUgZGVmYXVsdCBjdXJyZW50IGxpbWl0LiAgVGhp
cyByZXN1bHRzDQo+ID4gPiA+IC0gICAgICAgICogaW4gYSAzMDBtQSBjYXJkIGJlaW5nIGxpbWl0
ZWQgdG8gMjAwbUEgZXZlbiB0aG91Z2ggdGhlIGhvc3QNCj4gPiA+ID4gLSAgICAgICAgKiBzdXBw
b3J0cyA4MDBtQS4gRmFpbHVyZXMgc2VlbiB3aXRoIFNhbkRpc2sgOEdCIFVIUyBjYXJkcyB3aXRo
DQo+ID4gPiA+IC0gICAgICAgICogYW4gaU1YNiBob3N0LiAtLXJtaw0KPiA+ID4NCj4gPiA+IEkg
dGhpbmsgaXQncyBpbXBvcnRhbnQgdG8ga2VlcCBzb21lIG9mIHRoZSBpbmZvcm1hdGlvbiBmcm9t
IGFib3ZlLA0KPiA+ID4gYXMgaXQgc3RpbGwgc3RhbmRzLCBpZiBJIHVuZGVyc3RhbmQgY29ycmVj
dGx5Lg0KPiA+IEkgYmVsaWV2ZSB0aGlzIGhpZ2hsaWdodHMgYSBjb21tb24gbWlzdW5kZXJzdGFu
ZGluZzogaXQgY29uZmxhdGVzIHRoZQ0KPiA+IGNhcmTigJlzIGNhcGFiaWxpdGllcyAoaS5lLiwg
dGhlIG1heGltdW0gY3VycmVudCBpdCBjYW4gc3VwcG9ydCkgd2l0aCBpdHMgYWN0dWFsDQo+IHBv
d2VyIGNvbnN1bXB0aW9uLCB3aGljaCBkZXBlbmRzIG9uIHRoZSByZXF1aXJlZCBidXMgc3BlZWQg
YW5kIG9wZXJhdGluZw0KPiBjb25kaXRpb25zLg0KPiA+IFRoZSBjYXJkIHdpbGwgbmV2ZXIgc3Bl
Y2lmeSBvciBhdHRlbXB0IHRvIGRyYXcgbW9yZSBjdXJyZW50IHRoYW4gaXQgaXMgY2FwYWJsZSBv
Zg0KPiBoYW5kbGluZy4NCj4gPiBJZiBhIGN1cnJlbnQgbGltaXQgaXMgc2V0IHRoYXQgZXhjZWVk
cyB0aGUgY2FyZOKAmXMgY2FwYWJpbGl0eSwgdGhlIGNhcmQNCj4gPiB3aWxsIG5vdCBkcmF3IGJl
eW9uZCBpdHMgbWF4aW11bTsgaW5zdGVhZCwgaXQgd2lsbCBvcGVyYXRlIHdpdGhpbiBpdHMgb3du
IGxpbWl0cw0KPiBvciBtYXkgcmVqZWN0IHVuc3VwcG9ydGVkIGN1cnJlbnQgbGltaXQgc2V0dGlu
Z3MgYXMgcGVyIHRoZSBzcGVjaWZpY2F0aW9uLg0KPiA+IFRoZXJlZm9yZSwgdGhlIGxvZ2ljIHNo
b3VsZCBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSBjYXJk4oCZcyBhZHZlcnRpc2VkDQo+ID4gY2Fw
YWJpbGl0aWVzIGFuZCBpdHMgcmVhbC10aW1lIHBvd2VyIHJlcXVpcmVtZW50cywgZW5zdXJpbmcg
d2UgZG8gbm90IGNvbmZ1c2UNCj4gdGhlIHR3byBjb25jZXB0cy4NCj4gDQo+IEkgdW5kZXJzdGFu
ZCB3aGF0IHlvdSBhcmUgc2F5aW5nIGFuZCBpdCBtYWtlcyBwZXJmZWN0IHNlbnNlIHRvIG1lLg0K
PiANCj4gTXkgcG9pbnQgaXMsIEkgdGhpbmsgd2UgbmVlZCBzb21lIG1vcmUgaW5mb3JtYXRpb24g
aW4gdGhlIGNvbW1lbnQgcmF0aGVyIHRoYW4NCj4gdGhlIHR3byBsaW5lcyBiZWxvdyB0aGF0IHlv
dSBwcm9wb3NlLiBJdCBkb2Vzbid0IG1hdHRlciB0byBtZSBpZiB5b3UgZHJvcCB0aGUNCj4gY29t
bWVudHMgYWJvdmUsIGp1c3QgbWFrZSBzdXJlIHdlIHVuZGVyc3RhbmQgd2hhdCBnb2VzIG9uIGhl
cmUgYnkgZ2l2aW5nDQo+IG1vcmUgZGV0YWlscywgdGhlbiBJIHdpbGwgYmUgaGFwcHkuIDotKQ0K
RG9uZS4NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICAgICAg
ICAqIHF1ZXJ5IHRoZSBjYXJkIG9mIGl0cyBtYXhpbXVuIGN1cnJlbnQvcG93ZXIgY29uc3VtcHRp
b24gZ2l2ZW4gdGhlDQo+ID4gPiA+ICsgICAgICAgICogYnVzIHNwZWVkIG1vZGUNCj4gPiA+ID4g
ICAgICAgICAgKi8NCj4gPiA+ID4gLSAgICAgICBpZiAobWF4X2N1cnJlbnQgPj0gODAwICYmDQo+
ID4gPiA+IC0gICAgICAgICAgIGNhcmQtPnN3X2NhcHMuc2QzX2N1cnJfbGltaXQgJiBTRF9NQVhf
Q1VSUkVOVF84MDApDQo+ID4gPiA+ICsgICAgICAgZXJyID0gbW1jX3NkX3N3aXRjaChjYXJkLCAw
LCAwLCBjYXJkLT5zZF9idXNfc3BlZWQsIHN0YXR1cyk7DQo+ID4gPiA+ICsgICAgICAgaWYgKGVy
cikNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgICAgICBjYXJkX25lZWRzID0gc3RhdHVzWzFdIHwgc3RhdHVzWzBdIDw8IDg7DQo+ID4g
Pg0KPiANCj4gWy4uLl0NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo=


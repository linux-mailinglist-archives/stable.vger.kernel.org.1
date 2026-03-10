Return-Path: <stable+bounces-224580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGqpAfyJsGnXkQIAu9opvQ
	(envelope-from <stable+bounces-224580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:15:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899C2582E7
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B85630238C9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F92E3C5DAC;
	Tue, 10 Mar 2026 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DScInl8j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009703C5DB4;
	Tue, 10 Mar 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177335; cv=fail; b=NY04SARCQxccVhjDXRuOJuGpVtyx1xR0fxhmWdTrrkJOE1OU92/HGQ/zuj+s98SdRr+/KRlI48OjNBrP7MD76144Uiw5Ol6u16J/lEPpJ4mmavwnazv0VLlHXOolkOPUZlw/fwIzp9xASrMyCo+Q834pNKqD64wLQHBvFxNUI+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177335; c=relaxed/simple;
	bh=BYI31asuwlN6AlDWXpX6BLACu/vJZzt+6XRU7NdAhAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ltirj68k3ydY5t55ONLTmC6xZ1kURxXRSkeheCHC6EgUnjiUbj26rSjSBNd33vc9WPLGjKcY4kYc1hY0jwe1MojCoWrth8oJcQKi5bNX0kRRrztLFjNMdwLDTL+J1/knsmRtrztVVbij1X2IQn0jx/Mi62thv4ryLUaHSA91xyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DScInl8j; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773177334; x=1804713334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BYI31asuwlN6AlDWXpX6BLACu/vJZzt+6XRU7NdAhAs=;
  b=DScInl8jIEjgo/IigvaYRYoZqoHfbaCQC/y5feNT0HwgoEpfk3FTNV2O
   dowR7Vy5q9MJz1FpmeFQgNVSUGMBvZcwvun5dJv9L0z+RRdsmMZKsmDzF
   9FPwOE1/EQjuF1tfuaPNX4XAR2nzPfC8UivQA78dPsfd9KNINa+eRCVWn
   RT6RdHdj7STpGm20EKkee9KQ08PnDlxQ6BipxaVFgdpZX2bpkUZc4cR0B
   jBlEijB4CsLQgRfp1belS+BUm449NGR/RH96p2+EcrSO8MhHVoD+r1mzE
   vBgyzA3DNaJOH8iRmopkzHQevRKiPg88hvn4NUArpduukp9bZH1aWWngs
   A==;
X-CSE-ConnectionGUID: jz2Wj1mNRvGfDstPje0uNg==
X-CSE-MsgGUID: PWO5KCM3RSyf3jSQnuO87A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76846911"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="76846911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:15:33 -0700
X-CSE-ConnectionGUID: eDIycwfPRd+4AYAtOAlsPQ==
X-CSE-MsgGUID: zY9fV/OfT+mVTlRL+om9Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="225207575"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:15:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:15:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:15:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEkxBG5MBpG+gbn7CvsR5nzLklc2GQE+p72VKXaTlE0yRWDLYoNBTrgNIkwvQtKtcGnyg+6CJXSOLTeYpj0QRDlao+KO2futFFLf34meJRz3a9M+sp9jM7lXoTSaQC5RrNV8RjSNUNZVe/aOJolU02zAaHsH4XkTN1ARmqsl1vNFP1tiJ1HpAyCVuw12xYnbgzEZYdr+MOlvfew5G71w0Ytnkrfgomq22HtYwbS1ykh8Se+aS/0JFoTWwJER/DmJK0TTK9z/mUviBsBx1RFAQvBB+1RR8yh4OMYOEBayO75btOf35nuqKAnc34msnBt64DU3YeeNY2qMgxRu6I8f8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYI31asuwlN6AlDWXpX6BLACu/vJZzt+6XRU7NdAhAs=;
 b=vau9N+cWnc6fliN9zkQd++p4vQfEar7/Y9Aw7HKfG0kbj9/1Jhtgp2UMgUDSIq/uS/eef8Y+WRODtSuJu9xABdgiX7rX9TzJo2CPz3XfreOeDmEGm/z0eNyGefD4KyN2xmovu5zxgBs69gYyPiqgFqb1n17G5giM92GALziiv5W6rOulxw/zA1N3DWjCjbd+7SzJgF2kCh7ps/qbyeGPueKEIlId9S/wyqd4vLLxDpq+RftRKBhER5F/egBSw6bpd2C+JXiY3w5yXLaSpq9PfJkbSt/djGD7gaoE2S2sjL+bu2xXgmpNcFWYnt1hjkS8MmRfEUp4HXo6D81hjXRvFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SN7PR11MB6557.namprd11.prod.outlook.com (2603:10b6:806:26f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Tue, 10 Mar 2026 21:15:29 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:15:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Topic: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
Thread-Index: AQHcqi6VGDAojXj0j0m1k3BT3zeBY7Wmcd0AgAD2LICAAG1GgIAAfFsA
Date: Tue, 10 Mar 2026 21:15:28 +0000
Message-ID: <402683f68fba4fcdff9b1e342189bb469a820d57.camel@intel.com>
References: <20260302102226.7459-1-kai.huang@intel.com>
	 <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
	 <88b3637c84737136da1fe373cde43801845bd062.camel@intel.com>
	 <abAhne3A5WNARgZo@google.com>
In-Reply-To: <abAhne3A5WNARgZo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SN7PR11MB6557:EE_
x-ms-office365-filtering-correlation-id: 7e23ed06-9aeb-4f7a-5540-08de7eea27e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: +JdQsPBsr3xZMvbGHBQ23wxi56G/3xx/1SdsScTJp6QtL8/xs2seMFSOdc1IQwzt3cJtjooM74TiYyakob/BVEZUZfUmcoWJC365re0z4Or034AURzO6U4unQg6GqA3vqqPLi+W5N5TnimdRbbHe8p29wUakUvZG85IGBnVMWqfi6DRN1QZeSxE60m/5ivY7vPp37DeDfpaCUWzJMaHqLra/ckzDoTWJT+GqWWZSEpXXvZjsprAFRoEBA85gXQg1YRmDJqgq3DcM/ygZE1nq7TkaWs0nj1u9lKw5t1zt9+Is1KWcL3zRmhIPpRI1VnouraLKmlwZrOJkSJp/W1icckIPNCiKia7W8Igb/69a12d8pVcch0MLWDEZoiQcv/R3Hoy+0WPtCsm5svvpM7skek0kcBvICf0F9thtVuzI8SPEWdvlPmcd0r4QdKrhvuGY9jcdU3OsZ1xYdQjKClxYYVKhH2KrEzjHWmHA7bLPwyE3EGKPs2YkO2Swce3fZBC3SG+eOfiy9tLexJNTxdngS/fQrwN7NmYZZlfD7Jw3t8cT0Yxsw5bA3r+0aXYkVuDvvIFZO4WkIEBwof+HTrse6mcut6NxPba9YiAGsP3ZC37OUAsxAuNQ2eWIc03lQ06yUZEVr8S2YT4qmBu5Do63Rw04MX2Ake7CleG3e++j6DLOWDHLkavfsc4IE+pbAz8fGweZM46C8ab2VFp7HQBOuOQkCunrBS4f1N/nNkF157Db8WBzFdAe1wZPYrbaFEq3V6mo6IbrWtgoLjhwtkUeUbBOyWS2E7kMEDEQVGgDnAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjZZNUFwYm5JZ3JqUkNCRjVhZ2w1NW4vVWtHcXBsdDBLeEhFT3RQMEhzOUFE?=
 =?utf-8?B?L2VkQk1ITEh6L2FkZmdockN3b29KVGZIOThGUGIrTUpCQTRDWnVJclhWQjJ4?=
 =?utf-8?B?bnUyMlVyMHlhdyt4Rkx5ZUJIL2tYL3RlWDN6WnNRZllVb280NXdEZTZnRmFa?=
 =?utf-8?B?L3BrZzdPamdKOFh6MjlkRXRuaDhqbHova2FRdERPR0tLZzk3YlBBV0k1c3Ru?=
 =?utf-8?B?V0JDVUZaNVVza0VFUUhTODU1TFkrTUFxYUgyKzRCbCtZeEtKWjBHQk9uTzZq?=
 =?utf-8?B?cXZoNWxoVC8zT3M0aGFxOGJ5aUUrbWVHUUlEWmNldDVyb1l2S2FVSDJjRUEx?=
 =?utf-8?B?K1pZdm1sTEI4REZ5UjREZEFyM285UXh3c1kycVJ5TFluSHdabXIvenhSYzI3?=
 =?utf-8?B?cklpV3ZBcXozbWV0ckNpQkR4VjFpNDEyNWY0cXA3S1hWMzdzMFllUU1MOFc0?=
 =?utf-8?B?YnVEUjlmZjYwUUVjOU05UzAxTmcxT2dsTzUrQm8xYmZ3UDFJS3U2Yitndldm?=
 =?utf-8?B?Z1IyQTZqYTBIc01IZHRRd0JpZFlXYUxyNjl1b3lPbWNyT2lMR3NLYVh5UXN6?=
 =?utf-8?B?TzVla2pHc3VGOWJ4aEdxd2UwVkhHOUVPWjFKSjRybnFVUkxwMHcxRXZpOVNx?=
 =?utf-8?B?WWdLZE5mWmNFdVBIQ0JubXp6djhUUHpxTmc0ODlTbFdQVE9iTE5YMHBERk5x?=
 =?utf-8?B?ak12NlVRWGowWXNPdC94WFV2RzFidjZlWEozbUdFTmIrVXUxNk5MRHFaVXBm?=
 =?utf-8?B?ekZmaUdEUW80V0ZNZEJzR3VDT1BaVzZTMVRhaHFFQm53Nnh4bU1uQTNoNjA5?=
 =?utf-8?B?UHQzT1FMSGtGWmFXR0ZZV3UzWjlKRVp0VDFLWnlKd21zaXNKblpEZERncXAw?=
 =?utf-8?B?UHhaQTVjQ3dkZEEyai9XeVozKzhSeUliZitrYWsxRXdMeVVCb3Voakg4a3g0?=
 =?utf-8?B?VUtmSE5ZQllhZGhPVE02R2UzWTFvYUcreGhaMXNKU2NwcXFuVlFpVFpWOWtK?=
 =?utf-8?B?TXpkSzVGQkY5UGxKWGQ3MWJHcGpNMlgrM28yY2RUYUMrTVpOQzBkRExENWF1?=
 =?utf-8?B?QUVCRzlQeEw0eHc4dkdFZCt4aTJLMDZEa3BEUllud294aXEvbjN3QVRCVWxw?=
 =?utf-8?B?dVhLbnpjRjZndkY0M3ZoNWt5L3RxcnBiUnhKM21RM2NOTmlMMzRuLzhHRFFW?=
 =?utf-8?B?cXpua3IreDdwSTZKbG1zTVdXVkRVRDZ0UjZXdk9SMHhFZ2RldnRSM2s5YzJH?=
 =?utf-8?B?NFdvUVdLVXQ4U1RwU1UzR2tsa21JNHBnTUZZRGdEVHJlbWNmMkxYVGVDdE1o?=
 =?utf-8?B?dVJOd3gxSFlVRXFZK01aYmoyRks4RUFNRm5nV1RvU2hoeldBWVcxaGtETkdv?=
 =?utf-8?B?ZTZWR05PNnlEUVZmeTNXQkRMdldYMG1hV2E3cEFJdko1bGUzRzBYUUpOZFZj?=
 =?utf-8?B?VTE3algzdzBvalp6dWg4RWQ4bFRhbEtOZXF5MzYrdmY3YUFJaEFlZWh3dlV3?=
 =?utf-8?B?eGlVQWY5bWIxZTd0azU4VmphVmYyeVZ0WlVoNHNXdlJHbnNTbnh0bnAxSkN3?=
 =?utf-8?B?azJRVzloTmRpVzRXaEc0VnMvOWxyR0RKTXRpVDQ3R3ZxUUF6RGxlVFhxR3kz?=
 =?utf-8?B?aE8xTnV0b01uOHA2SzNtbVFNYTVEMWVEZkF6dktnek1Pck5INjRqOUU1dHg4?=
 =?utf-8?B?VzNQdjl1cVp0UVd2cmJjaXhDOGxvVFJ2UVN5RmVRWUpManAxNys5czJSY3A5?=
 =?utf-8?B?VUpqNFpuUktMTHBuUHA0ZnlzeDlicWtmMkp4VldsdVEzU2JaTnlWV2tISWZ0?=
 =?utf-8?B?eXRoa1FRY2ROaHVMTTlZYUgxTnVkZG9xWW5Zb3BsODBRTUhWc1FPN2U4bC9R?=
 =?utf-8?B?WWd6MWwralk3OVBnTTFVQlpucjA3RDk5YTdaVWE0WThJVUUxVjhYblpkeWdR?=
 =?utf-8?B?SmthV3U3S0JSNlVJaUU4eFpjSSs4RVV4eVFucW8wZEl0Q1FjRXZGUGxubzVW?=
 =?utf-8?B?WVd2d25iYmlVcXhYQmo3UVJZdm9ic0FMLzB2QVI1VHJjdXNQVmk0MDhQRjVo?=
 =?utf-8?B?VExsNzd5em1sTTFJY1lQS24wYzNvRnRvZGlzTzZ3dUt2K3JsbzJvZm1kYlpM?=
 =?utf-8?B?cHBsSXduaWZPZ3JaM08waERqYXVhamd6U3ZwOExxSTJTVjFzbFgyVjVUWkdR?=
 =?utf-8?B?eUptUFBMV3ZVaURLcmJPcjM4WHZ4UnJja3FndzdtWDRtYkpxS0FzNDBVZmJo?=
 =?utf-8?B?cVpVakV2YUh3d2daajVkdVR3VGNidHF0OVBob0ZZQmFMTkZzbkJZSmRGY0Qw?=
 =?utf-8?B?SUtuNHVzZlA5M3U4S3pQV0thb21iQmJIeWFHc1RmZndaRnRhcVZMUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4125F67554BE443AF9F03729A80743B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X38ZGaYTEh+KUTxob+GKlmXm2Kil6ScRJ4wn82xeX+1Agcv2T3z+vek+e4h8YZsJh5bRm7tDr1xG2R9Vk8Kwma+w6neXbSaIUbFdy+5bDifF0lyB/EtUqdMBSeZA3Ad3vxHnkwJ94ND+LG748pUINNfOYaJx77MJ504ANV7oHDI4sCUTVBk5dAKPH7Jyjq1FL2sB1dpbdK/NX1U0ITkF1XyVSQ6R7h2REnpz1XQhpiJDEaDMxNS/z0bMZLqe+pQScFFgWIjEJ7l+LY8cJ+MtlSNYjVy37QFCsc1PZmtWiRH2/+rl9gk9es1pls3vS/aJuZi78N55qDc8jyKDOwInmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23ed06-9aeb-4f7a-5540-08de7eea27e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 21:15:28.9864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yw5DyKbnhlwWH5HUGbpTKYgSHZtK0i8DV+1IbSnmaUPZhCvQYbfyi5tv7BbmwRpAlknDl4AjroHuPIwJ0Ab1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6557
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 5899C2582E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224580-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDA2OjUwIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIE1hciAxMCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIE1v
biwgMjAyNi0wMy0wOSBhdCAxNjozOCArMDAwMCwgRWRnZWNvbWJlLCBSaWNrIFAgd3JvdGU6DQo+
ID4gPiBPbiBNb24sIDIwMjYtMDMtMDIgYXQgMjM6MjIgKzEzMDAsIEthaSBIdWFuZyB3cm90ZToN
Cj4gPiA+ID4gUmVtb3ZlIHRoZSB0b28gc3Ryb25nIGxvY2tkZXBfYXNzZXJ0X3ByZWVtcHRpb25f
ZGlzYWJsZWQoKSwgYW5kDQo+ID4gPiA+IGNoYW5nZSB0aGlzX2NwdV97cmVhZHx3cml0ZX0oKSB0
byBfX3RoaXNfY3B1X3tyZWFkfHdyaXRlfSgpIHdoaWNoDQo+ID4gPiA+IHByb3ZpZGUgdGhlIG1v
cmUgcHJvcGVyIGNoZWNrICh3aGVuIENPTkZJR19ERUJVR19QUkVFTVBUIGlzIHRydWUpLA0KPiA+
ID4gPiB3aGljaCBjaGVja3MgYWxsIGNvbmRpdGlvbnMgdGhhdCB0aGUgY29udGV4dCBjYW5ub3Qg
YmUgbW92ZWQgdG8NCj4gPiA+ID4gYW5vdGhlciBDUFUgdG8gcnVuIGluIHRoZSBtaWRkbGUuDQo+
ID4gPiA+IA0KPiA+ID4gPiBGaXhlczogNjEyMjFkMDdlODE1ICgiS1ZNL1REWDogRXhwbGljaXRs
eSBkbyBXQklOVkQgd2hlbiBubyBtb3JlIFREWA0KPiA+ID4gPiBTRUFNQ0FMTHMiKQ0KPiA+ID4g
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiBSZXBvcnRlZC1ieTogVmlzaGFs
IFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gVGVzdGVkLWJ5OiBWaXNo
YWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3
ZWQtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiA+
IA0KPiA+ID4gQnV0IHRoaXMgaXNzdWUgaXMgYWxzbyBzb2x2ZWQgYnk6DQo+ID4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9rdm0vMjAyNjAzMDcwMTAzNTguODE5NjQ1LTMtcmljay5wLmVkZ2Vj
b21iZUBpbnRlbC5jb20vDQo+IA0KPiBFdmVuIHdoZW4gdGhhdCBzZXJpZXMgY29tZXMgYWxvbmcs
IEkgd291bGQgcmF0aGVyIGhhdmUgX190aGlzX2NwdV97cmVhZHx3cml0ZX0oKQ0KPiBpbnN0ZWFk
IG9mIHRoZSBleHBsaWNpdCBsb2NrZGVwX2Fzc2VydF9wcmVlbXB0aW9uX2Rpc2FibGVkKCkuICBT
aW1pbGFyIHRvIHRoZSBXQVJODQo+IGFib3V0IElSUXMgYmVpbmcgZGlzYWJsZWQgdGhhdCBnb3Qg
cmVtb3ZlZCwgZXhwbGljaXRseSByZXF1aXJpbmcgdGhhdCBwcmVlbXB0aW9uDQo+IGJlIGRpc2Fi
bGVkIGZlZWxzIGxpa2UgYSBkZXNjcmlwdGlvbiBvZiB0aGUgY3VycmVudCBjb2RlLCBub3QgYW4g
YWN0dWFsIHJlcXVpcmVtZW50Lg0KPiANCj4gQXNzZXJ0aW5nIHRoYXQgcHJlZW1wdGlvbiBpcyBk
aXNhYmxlZCBnaXZlcyB0aGUgZmFsc2UgaW1wcmVzc2lvbiB0aGF0IHRoZSBjdXJyZW50DQo+IHRh
c2sgbXVzdCBub3QgYmUgc2NoZWR1bGVkIG91dCwgYmV0d2VlbiByZWFkaW5nIGFuZCB3cml0aW5n
IGNhY2hlX3N0YXRlX2luY29oZXJlbnQuDQo+IFdoaWNoIHRoZW4gcmFpc2VzIHRoZSBxdWVzdGlv
biBvZiB3aHkgc2NoZWR1bGluZyBvdXQgdGhlIGN1cnJlbnQgdGFzayBpcyBiYWQiLg0KDQpBZ3Jl
ZWQuDQoNCj4gDQo+ID4gVGhpcyBkZXBlbmRzIG9uIFNlYW4ncyBzZXJpZXMgdG8gbW92ZSBWTVhP
TiB0byB4ODYgY29yZSwgc28gaXQncyBub3Qgc3RhYmxlDQo+ID4gZnJpZW5kbHkuDQo+ID4gDQo+
ID4gPiANCj4gPiA+IEkgZ3Vlc3MgdGhhdCB0aGVzZSBjaGFuZ2VzIGFyZSBjb3JyZWN0IGluIGVp
dGhlciBjYXNlLiBUaGVyZSBpcyBubyBuZWVkDQo+ID4gPiBmb3IgdGhlIHN0cmljdGVyIGFzc2Vy
dHMuIEJ1dCBkZXBlbmRpbmcgb24gdGhlIG9yZGVyIHRoZSBsb2cgd291bGQgYmUNCj4gPiA+IGNv
bmZ1c2luZyBpbiB0aGUgaGlzdG9yeSB3aGVuIGl0IHRhbGtzIGFib3V0IGxvY2tkZXAgd2Fybmlu
Z3MuIFNvIHdlJ2xsDQo+ID4gPiBoYXZlIHRvIGtlZXAgYW4gZXllIG9uIHRoaW5ncy4gSWYgdGhp
cyBnb2VzIGZpcnN0LCB0aGVuIGl0J3MgZmluZS4NCj4gPiANCj4gPiBJIHNlZS4gIFdpbGwga2Vl
cCB0aGlzIGluIG1pbmQuDQo+ID4gDQo+ID4gPiANCj4gPiA+IFlvdSBrbm93LCBpdCBtaWdodCBo
YXZlIGhlbHBlZCB0byBpbmNsdWRlIHRoZSBzcGxhdCBpZiB5b3UgZW5kIHVwIHdpdGgNCj4gPiA+
IGEgdjIuDQo+IA0KPiArMS4gIEkgY2FuIHJlYWQgYSBiYWNrdHJhY2UgYWJvdXQgMTB4IGZhc3Rl
ciB0aGFuIGEgZnVsbCBzZW50ZW5jZSBkZXNjcmliaW5nIHRoZQ0KPiBiYWNrdHJhY2UuDQoNCkkn
bGwgaW5jbHVkZSB0aGUgYWN0dWFsIFdBUk4gc3BsYXQgaW4gdjIuDQoNClRoYW5rcyBmb3IgdGhl
IGFjayENCg==


Return-Path: <stable+bounces-161383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C9AFDFB8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A761C269CA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD62690F9;
	Wed,  9 Jul 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="hQF91cyd"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D6191484;
	Wed,  9 Jul 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752040583; cv=fail; b=PXY4CqFma0Pg3ig4eEf0/+4d1k6fiInxFR9lJM3/Lyk2/aj2/CfzKhhO67hOzzeIBrgKTQZQqrDvQ13IkAsnD0I3TVDA+5fiGAHQF3UY+PAzckibdqUvmQGLkprbmDKSDsILoQl1qTXj+IjzEBSqtiBxtaSWyXOvGd5J/Xb4jHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752040583; c=relaxed/simple;
	bh=My2y7VKZqXWHF7TTAOmaFLJQ+2Zp1y8X0E2ua7/ersw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABTqSqV+qgfg/ETTEgFc58XOoCmLzPABkJG/XYWdsIigdhXQz1D29ns+j9rL+xrzAzlMFFcEq9KjEm8Xn0WktiOzfpZrqIsUVP7BMgWvxKprXkU/OU2IIMaqszL5hPkS58Rf+n7TMmagUBjIsvmUAnLZgKoEvVUMoBiWP6ExTOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=hQF91cyd; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1752040581; x=1783576581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=My2y7VKZqXWHF7TTAOmaFLJQ+2Zp1y8X0E2ua7/ersw=;
  b=hQF91cydSp0U2Kk7gGOaIxiHalxUAsC5k2LI4zgmabrkZL2yAkr7rhhH
   pti0yEI7sRrlNfoLiQy5qMWCVvilM8zzQWvtkBIVbVghQw+pXZ5o5R3Q0
   wi7bB2osVAkU2Dkr6iy7+fNmyO+od1P6JS5dRbiQRSLUhhOMm+vRcH3lB
   zNjLhpAqhvaC/D0L81omRrqIKgFSMhtyJxmL8vtClnZc1qJBtJHYHvlu0
   DOV5+C2EZYpl9MQDCXR9GPN2QwOlXBHAeYpTSvYei29re/eDfKlH9IZHc
   olFQ3JnDnTsWLiqgpAEcCe5iccJurKYH0A0eCJZg0FtVANrriC9vGh3jl
   g==;
X-CSE-ConnectionGUID: 7RcTmXYISeShzmz6qYpVcA==
X-CSE-MsgGUID: FcyDrQlUR4mTEHGXvpJsYA==
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.125])
  by ob1.hc6817-7.iphmx.com with ESMTP; 08 Jul 2025 22:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8n/TntGWCqq307/WRUo7zTF74Gj/bIgvhXTN43HiajA3r+ywP4MS9O5knPIkplTbBLX1p++zgaGtA6NHMPC+P4hMWRvmNcRuEWUJ129OmOmvwuTksAn6UHhvCbOtNHVYkBG0y3j/vF+SgL95xjpAP4mH/89BfSgDs0i7NumsNDYGdahtWeKXUoGJeg//z8C3kGFz3NgCu7j1JWmNWLpVyg91O9WEe270qys70lkKWrunYROqbB/teXNWnyrKeTVzBSSZUvktGEK4knlU3hWzIEwQkxzgm1sQxwDz/tiQbwzjW7Cu/yXPP/3tDwlPl9GBk+5pQ1oYj6V5VXIiscH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My2y7VKZqXWHF7TTAOmaFLJQ+2Zp1y8X0E2ua7/ersw=;
 b=hs91fc5VR8lusxfqhKWToxFyztai1BKV6grO9siqd4ObAFTwNnbBIWbiE0x0yXhTwshS7D/weMR3CbUfvVIe9EJc7mvvTuns8Ww64mkbthBCDw5I0t2NbmEHL0Jl2VfuH0MKk5nnI+bpZ4EiqDfdJTQ3dRYUuwhY04SUSg3Q2/1UZ0yFy48yH/TrNuiYh4e2c8qZf/3bX62bz/nCTm8CVcdmdrf5WyWdxlNMJS1RloWI5nwoNBwhCUvbxT7WUNXtn0Cb6cT2iIEzryiKTRtVYuJbZQAeCwIPsPRxHNMzbIG56VWrylGv51nuA39OfmgVzzPVZoablZOUu/8QvjuTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SA0PR16MB3646.namprd16.prod.outlook.com (2603:10b6:806:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 05:56:17 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::542:41ae:6140:5595%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:56:17 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg
	<quic_sartgarg@quicinc.com>, Abraham Bachrach <abe@skydio.com>, Prathamesh
 Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, Sagiv Aharonoff
	<saharonoff@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: core sd: Simplify current limit logic for 200mA
 default
Thread-Topic: [PATCH 1/2] mmc: core sd: Simplify current limit logic for 200mA
 default
Thread-Index: AQHb4PkYIguyqSnEKE+kzs5sxHxMx7Qoc+mAgAD2aNA=
Date: Wed, 9 Jul 2025 05:56:17 +0000
Message-ID:
 <PH7PR16MB61967A5E2C2105B5B2F15398E549A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-2-avri.altman@sandisk.com>
 <CAPDyKFqJR+HwnVZU=Lerk0eJ3+_9J7KD-5DWv84t-YG3r5NYuA@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqJR+HwnVZU=Lerk0eJ3+_9J7KD-5DWv84t-YG3r5NYuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SA0PR16MB3646:EE_
x-ms-office365-filtering-correlation-id: a9ec21b7-9041-4a87-122a-08ddbead523a
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFZUTmQ0MHVrQTZwS09DZ1hkdEV4SnRtbmpHKzZMV1Foem5PYTNhSHdKM2pj?=
 =?utf-8?B?SFptUE45S0RpUFlkSnZLcnBmTlB5dFM2cS9jTkU2QVJWUzY3MmFuZHB6eFgz?=
 =?utf-8?B?d1ZHYkwvbEUvR2J2b3NYdUZVeTYxaUh2ejJBN2h5elUwOVRRK1p1SDNtNkMz?=
 =?utf-8?B?ejRoTTJHMFlCSW1tQk13T2Q3ak13VEpyeDM2TWVhaXV3dUNNKzRjb0pjV0pL?=
 =?utf-8?B?WFNOT1hlVmFrbFdnRkxmUE9GNlhGeFcvanlva2xBUzhpMFA3MFAvQnYyK2xI?=
 =?utf-8?B?UitzQWh6SVl4YmxkdHlaVVRBTE01dGgvYlZLS2R1ekRUK24yQXZzRVphL244?=
 =?utf-8?B?eWNSb1VTRW5iRHdOOVIxSjdRcWtqamptZk5nN0RMMC82MDlhZUo0ZEJvQ2hv?=
 =?utf-8?B?aFFEUGYrQ2lIS01hR0VQVTMwTkpoNmEvQWhFNW15NFFrTzJrUDBPRWZuL1Ex?=
 =?utf-8?B?N3RLWFJMRlBnNWVXQ2NSZFF0cWJlVHh1Y01kSFg5ZVFuaU51d2dFcDNRcUFP?=
 =?utf-8?B?N3RoZk1WMFcySTB0azlhKzgzOGVKMXE3cXFaQStZSjFTRDNZYVIwSDVqdzJh?=
 =?utf-8?B?ZUIvVEowZ3dzN2NUbU9nSk9lZytZWi96eVlmYUNTbkJ0ZEtSbExra2JhTUF6?=
 =?utf-8?B?K1VtZ2kybDdMb1gxbG94Ry9wQ1B6ejhOeENNWmNMMVJ5THA0azN2YjRMdmRo?=
 =?utf-8?B?bUVOenB3Q21hM1YrMEpZczNLMkdMQ3ROOTF5T053bEh3NWdxYlFoNmdrQ3hx?=
 =?utf-8?B?MnMyOFFLUXVML3JCeXk4ZE1mdHRUaHBpd1Z3emd3aHFaTjdkT1BkbkM1MktC?=
 =?utf-8?B?b204QmF1Ukd1ZzROY3dZWHpXd0JRQWZQUkI2TnZPOUd2R0w0R2NIa2xNT2hE?=
 =?utf-8?B?WlY4aktxWmRsSFEyYzFkQk9Na2RNUlUrNE9WUkxkRENmbEI0WG1uWThCenRq?=
 =?utf-8?B?OGZSenVwZnJYbHJoMlZ0NUFHNDRQY1I0UFlLVmdMUmc3K0hiWE1IaUVCSkh1?=
 =?utf-8?B?VWM1eGxKR0dxa0ZpaFZPNVp3NmV2YS9ocWthUUFUKzBGUDRnWWVRZ0x5ano2?=
 =?utf-8?B?Qm9zbnFZd1h4RWJKSmZlTE9VNk9kUzIrMnBhWEJxemh3TnJGdnptUHlNd0ZG?=
 =?utf-8?B?ZE1TRk1Ma2VxRkRwZElxQS9YRExicVNlZEdLeHpzTGw4dGJvVFFMWDJubEhj?=
 =?utf-8?B?eUl2clEvUzJSdmFEcW1acXJNWEN2eWRoek82Wm1uWlhKemJCMXJnYjgxQ2RM?=
 =?utf-8?B?MERZbUQzc2x1eDMwWWhvaXVSRTJsNE9BWDNVYVR4eUN5Wm5ub3dFRTR3SVlE?=
 =?utf-8?B?N2xzSEpicTVkd010eEVUNTk5NFhEOXFCbStiZm1RVWNGWk5oOFU2ZndvQ3JH?=
 =?utf-8?B?SWVzcTZtVkFGQ29KNUcyNlQ0Z29UdVJadnYwUnUxVERxM2RNTDlRb1Y2c1lj?=
 =?utf-8?B?UlNaOEVhY3I2ZEN5QmY3eURBRHBkWWZXcE1EL1RzelZvZjQ0cXdmb3ZjQ1JF?=
 =?utf-8?B?T0p3SXpGU2drQ2JJTnRhZlAyWVNHKzYvVmZWWFFFTjlpYkxObitVNHZMWGhG?=
 =?utf-8?B?bTJYU1BtZGlFK2htYWE5elRqSHRrK3Y3bmZkSEFlTkVxMFNBbjFBYUdRaC90?=
 =?utf-8?B?RzZmRERtbllvZlhRdHI4eG95K3dwam02aEZNQy9KSUNwMTloQjVJQ3U0dzZD?=
 =?utf-8?B?eC93MURrbjlRRjJkTjFvNVZPR3U1YS94bkY5N3lLOElBdHBkQUFxenZlbys5?=
 =?utf-8?B?Ymszb0ZGclh6cmVraFhUOS9IY2ZuVUZISUVGcXRPUjlLbUpOeWhiNmROTy96?=
 =?utf-8?B?WTUyNFBsM3RWenc0VDRLQUFJeFBTYVB2L0ltclNBQ2dtU3l2RHpQSWJLN3N5?=
 =?utf-8?B?T0NPRHV6RkVmN3VHdVBRYXZ2UjVzR3dja3RhUWczQjllRWh3ZWFnbU1Gek5V?=
 =?utf-8?B?eG1GMzhaMnpCVndpMi82dmFqQ0tram5YYk5DNXFJOXlnU3g2NWM2RWRiTDVY?=
 =?utf-8?B?UllqSFNqQUlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dW9NbkEvZWdTcEt6WUl1MDBxWjJpcUhkOFpIN1pIU0QyN0l4ZFVmTTgxQXJO?=
 =?utf-8?B?TURqODhrcmRTNUE0MG9jTERocTlOK1EwWkdwNGZkR0NzaU9NYUdmSGxjZDRt?=
 =?utf-8?B?RGdXY1lRVE1kWTNxMHJnZ0R3L2dDQjlpSEZla2U5RThWYmhvamhZY1V4VEts?=
 =?utf-8?B?ZXRVQklId3NMYmxWNlo4bDY5RUpOd2YxTVBad3hZd2lnLy91RVhZQVh2TDN1?=
 =?utf-8?B?enVKbVlWVE5kbEVaMU1Zd0cxZVl0YitqZlpoTHIrNitWK3h4TWVmNTcyQ0Ju?=
 =?utf-8?B?c0RidTZTZ2grSzhMTWhIUWdZRHBwbkZuNFFMdkdQQ29lczNCSmdiVVJYNjJq?=
 =?utf-8?B?QW9tZkcrMGMzc01ya1paUE5PU0tRMVd1UUx3ajNKUHE3dmtrcFlSaENUVUhn?=
 =?utf-8?B?VmtkSUpCcWp0czJpc3puTm1TQ1c5cW5Fb2c0N01rTDYwRGpyNThTaEhvaVdu?=
 =?utf-8?B?MkY2VzJWdVN6NzNhL25PSFFndlV2ZW9ZRFYwZzZuVlN1blc3ekpkQVFxckNE?=
 =?utf-8?B?cVBsNUlVdlhXY1ZrdUp2VGNaZXlKWnE1QU00NWZFYWhuUWczbW56TnA4SWJL?=
 =?utf-8?B?TmQraklBR0MrUDhpZXhxQ3NzNGdUSTlxREgwL2xhc1NzSVVjUE5UWmoyMTZK?=
 =?utf-8?B?d2ZTWlI5aFhGUUgvZytCNzRYNVdwT3RwSGg4K3o0cDc3VUxVcjRFUXZEaUh4?=
 =?utf-8?B?eTlyZjdpYmFTbGFDbk5lVXBRcHIrUE5HakxLeTVuaVV6RXdvVFczenRBZGYw?=
 =?utf-8?B?Rkx4Vml1a0RMNVM3RW9xS2dKZ1hPaEFJbFFwVGRkWXFlYndZc29iSHZ2eGhv?=
 =?utf-8?B?Vk53SEh4dzRtcXV2TFZRendrZm5nb2tud3B4ZnlNeFNKeWNyNHBuckI2UVdh?=
 =?utf-8?B?UzdRZ0tYbDJkdXRHTVdKd3FTbjI0ZnZEeG03aWNGdGJiZS9HeWtZTSsySFlI?=
 =?utf-8?B?NGNRLysvWWV3eElGV0cwLzhRRFZhOHdCWldvM3lHbHFRN2lpSlB4SXBEcGdh?=
 =?utf-8?B?Z1pMY0Nvcy9FL1ExMEx4ekUvNHZZUkpyUkwrTXMrL0V0cTVncVNUQUhDVWl1?=
 =?utf-8?B?NnJaYjZsTmh5cGFJWmMxVUxOZVF4NmRPNVRuZktQMUV1RUs3bzMrdjZneXJ2?=
 =?utf-8?B?dktwUVBZazJid0R1SHdhZVBFYkgrTmkrRjUvTmN6ZmsyeWVrNUJ6ZUNXK0tp?=
 =?utf-8?B?azhsdGtQTDhQY3VHODRzaUROaUFoSHVCZS9xTzQyamNEeWNocVo0c0pxWnJZ?=
 =?utf-8?B?OTBSVC90MFVSWWhKMDJIYnpVUlE5dlFPRXBvZjgyZUtRbmxRbUNDVE9Ua3Rx?=
 =?utf-8?B?ZHIxYmdiUDJmS2E3R2VMcDd5VkJPaW41SmhkdWxLbGRUZEVqOFVZWEd1K0NJ?=
 =?utf-8?B?Q3ZpOW95ZFZHYkgvdnJWOEJNWmZYckRkcVNIamVTR3Z1YTRBMFZrakxPdWZ4?=
 =?utf-8?B?dmJxQW9ibVcwSjdGajNnTG4wYVVDdmxlNUNzYjJNUW10UlRKbFl2NDZhMFdR?=
 =?utf-8?B?ZUJpMXJQUHVkOTdtVFdyTFBMUUtILytyaUtjT1ZNZHVRSEFoTElNYlVEcExp?=
 =?utf-8?B?SHMyNnhDbmp1Q0ZFdVQwV1BkUTFjRGFxRmx4WmpyV2NGc29DcVhiNGNPTkVa?=
 =?utf-8?B?Mi9WSFlIYnpQWitTbE1hRzR5VE13dlVlVjFFYWVyY1RWWEJDRXgvQXVsOS9u?=
 =?utf-8?B?WFExaFQ5K08zN0hWYVZqa1FZL1V1ODRzUDFsN2VCbVMvMWhndERDc2JTaVk1?=
 =?utf-8?B?d0tpaXFvT3M0UVlLU3dKakJPY01IR0wzNUNzenpxeUpYMkdDTkE2c001Uk00?=
 =?utf-8?B?WWRlOUhNcUVzSklPY3FINDZBeER4SUhSM0V1VXBDNGJhU2hZRFdYSXREZk5v?=
 =?utf-8?B?VThSOTFTUHQ1Y0YxallGakgydytRRUVJSE5zZG12alU3Y0U4bEZwMDQvcS9O?=
 =?utf-8?B?Y0t4MDFCTlpla0dkVDF5akJ4bW9ybjBIajZjYUpndVJWVUFJdnM4cHFFNFRv?=
 =?utf-8?B?SHBiUk9RbVBRaXd2cjFTa2gyend0Q3RzTHI3VkhucERDeU85aDZnWWhuOHUy?=
 =?utf-8?B?elJCNFlFbk81VGZ4ZHl1R3MvS0Jsd056bEt5U0l0K2lzbVVxQ3hCZ0ViL0pX?=
 =?utf-8?Q?Uy0hZaZ3WXs/xsYWfbJePmsKi?=
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
	DNRnpIMwLcAW8Ef8xUmSnIq+df5eVeOE0WXlKr00OgpBye7aiIMvrwhO4vjvilJOxX0aw3ux6E3eZcvuGsP6cwOKdkaTLetsj4EqCWvVg6ei0Wul80sbpMMvIN9wemozFJFvLeWy7LDfgIKL+jxHP/mhTotU4/tqO5vjpCQ1aHFCCuA5HUzgf1aeltKcUU02a/yU/oNSDZLd/Tp3DVbrfRKxDGrl1YdiFhNsmtCSEclu1LboDycuY4JTxKOTb/hcpLj/y6dfpyohCU6ute4rcKlhnKT1D8HOUTCBwSbQTLSkq741ViDK1w4thno1Ai0/pEnOMc90VO5vJR5nc0aC3HQqios2ZU5IwdvupA9V0lwFH/tlPjYLvBZ4R8C7M5WvCIxpBQEqM9RTZXI31VtFcx7rAFiqP30my1ajadtM+nd/r8KZze3imLFI90Vrk9vQ7QlXHQxkPinJGhNWbwJnbrJoq4050kdApVO4P/k3Rok2FrsJuYnQPaqRqxO4Jj9HPAfT4qHSfASRvY1deDLwq6MeHEgFCxVGvp/+Fag2ughD3lzRO/4wbEmA2ZefUtbW52INSbGbcnKf3dApGr5uFuUW1pDBKqE7z+M+2xWRNPzHo20hvIkT/n78kJAtMhVJZ4N83osFhaEBURnpFQ4a+g==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ec21b7-9041-4a87-122a-08ddbead523a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:56:17.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwaJC3O75GJ8AcHScJTdzKNZf9MReWp3sHbQXl8/xQpX6rTLEG6wdVD4TG3X6rPtdAH6FWGYjjeJQ0UZgnylHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3646

PiBPbiBUaHUsIDE5IEp1biAyMDI1IGF0IDExOjAzLCBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5A
c2FuZGlzay5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIFNEIGN1cnJlbnQgbGltaXQgbG9n
aWMgaXMgdXBkYXRlZCB0byBhdm9pZCBleHBsaWNpdGx5IHNldHRpbmcgdGhlDQo+ID4gY3VycmVu
dCBsaW1pdCB3aGVuIHRoZSBtYXhpbXVtIHBvd2VyIGlzIDIwMG1BICgwLjcyVykgb3IgbGVzcywg
YXMgdGhpcw0KPiA+IGlzIGFscmVhZHkgdGhlIGRlZmF1bHQgdmFsdWUuIFRoZSBjb2RlIG5vdyBv
bmx5IGlzc3VlcyBhIGN1cnJlbnQgbGltaXQNCj4gPiBzd2l0Y2ggaWYgYSBoaWdoZXIgbGltaXQg
aXMgcmVxdWlyZWQsIGFuZCB0aGUgdW51c2VkDQo+ID4gU0RfU0VUX0NVUlJFTlRfTk9fQ0hBTkdF
IGNvbnN0YW50IGlzIHJlbW92ZWQuIFRoaXMgcmVkdWNlcw0KPiB1bm5lY2Vzc2FyeQ0KPiA+IGNv
bW1hbmRzIGFuZCBzaW1wbGlmaWVzIHRoZSBsb2dpYy4NCj4gPg0KPiA+IEZpeGVzOiAwYWE2Nzcw
MDAwYmEgKCJtbWM6IHNkaGNpOiBvbmx5IHNldCAyMDBtQSBzdXBwb3J0IGZvciAxLjh2IGlmDQo+
ID4gMjAwbUEgaXMgYXZhaWxhYmxlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdnJpIEFsdG1hbiA8
YXZyaS5hbHRtYW5Ac2FuZGlzay5jb20+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gDQo+IEkgYW0gbm90IHN1cmUgdGhlcmUgaXMgcmVhbGx5IGEgYnVnIGhlcmUuIFRvIG1lLCBp
dCByYXRoZXIgbG9va3MgbGlrZSBhbg0KPiBvcHRpbWl6YXRpb24sIGFzIHdlIGFyZSBhdm9pZGlu
ZyBvbmUgdW5uZWNlc3Nhcnkgc3dpdGNoIGNvbW1hbmQuDQpEb25lLg0KDQpUaGFua3MsDQpBdnJp
DQoNCj4gDQo+IE90aGVyd2lzZSB0aGlzIGxvb2tzIGdvb2QgdG8gbWUuDQo+IA0KPiBLaW5kIHJl
Z2FyZHMNCj4gVWZmZQ0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvY29yZS9zZC5jICAg
IHwgNyArKy0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbW1jL2NhcmQuaCB8IDEgLQ0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkLmMgYi9kcml2ZXJzL21tYy9jb3JlL3Nk
LmMgaW5kZXgNCj4gPiBlYzAyMDY3ZjAzYzUuLmNmOTJjNWIyMDU5YSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21tYy9jb3JlL3NkLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkLmMN
Cj4gPiBAQCAtNTU0LDcgKzU1NCw3IEBAIHN0YXRpYyB1MzIgc2RfZ2V0X2hvc3RfbWF4X2N1cnJl
bnQoc3RydWN0DQo+IG1tY19ob3N0DQo+ID4gKmhvc3QpDQo+ID4NCj4gPiAgc3RhdGljIGludCBz
ZF9zZXRfY3VycmVudF9saW1pdChzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQsIHU4ICpzdGF0dXMpICB7
DQo+ID4gLSAgICAgICBpbnQgY3VycmVudF9saW1pdCA9IFNEX1NFVF9DVVJSRU5UX05PX0NIQU5H
RTsNCj4gPiArICAgICAgIGludCBjdXJyZW50X2xpbWl0ID0gU0RfU0VUX0NVUlJFTlRfTElNSVRf
MjAwOw0KPiA+ICAgICAgICAgaW50IGVycjsNCj4gPiAgICAgICAgIHUzMiBtYXhfY3VycmVudDsN
Cj4gPg0KPiA+IEBAIC01OTgsMTEgKzU5OCw4IEBAIHN0YXRpYyBpbnQgc2Rfc2V0X2N1cnJlbnRf
bGltaXQoc3RydWN0IG1tY19jYXJkDQo+ICpjYXJkLCB1OCAqc3RhdHVzKQ0KPiA+ICAgICAgICAg
ZWxzZSBpZiAobWF4X2N1cnJlbnQgPj0gNDAwICYmDQo+ID4gICAgICAgICAgICAgICAgICBjYXJk
LT5zd19jYXBzLnNkM19jdXJyX2xpbWl0ICYgU0RfTUFYX0NVUlJFTlRfNDAwKQ0KPiA+ICAgICAg
ICAgICAgICAgICBjdXJyZW50X2xpbWl0ID0gU0RfU0VUX0NVUlJFTlRfTElNSVRfNDAwOw0KPiA+
IC0gICAgICAgZWxzZSBpZiAobWF4X2N1cnJlbnQgPj0gMjAwICYmDQo+ID4gLSAgICAgICAgICAg
ICAgICBjYXJkLT5zd19jYXBzLnNkM19jdXJyX2xpbWl0ICYgU0RfTUFYX0NVUlJFTlRfMjAwKQ0K
PiA+IC0gICAgICAgICAgICAgICBjdXJyZW50X2xpbWl0ID0gU0RfU0VUX0NVUlJFTlRfTElNSVRf
MjAwOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoY3VycmVudF9saW1pdCAhPSBTRF9TRVRfQ1VSUkVO
VF9OT19DSEFOR0UpIHsNCj4gPiArICAgICAgIGlmIChjdXJyZW50X2xpbWl0ICE9IFNEX1NFVF9D
VVJSRU5UX0xJTUlUXzIwMCkgew0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSBtbWNfc2Rfc3dp
dGNoKGNhcmQsIFNEX1NXSVRDSF9TRVQsIDMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjdXJyZW50X2xpbWl0LCBzdGF0dXMpOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAo
ZXJyKQ0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggYi9pbmNsdWRl
L2xpbnV4L21tYy9jYXJkLmggaW5kZXgNCj4gPiBkZGNkZjIzZDczMWMuLmU5ZTk2NGMyMGU1MyAx
MDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiArKysgYi9pbmNs
dWRlL2xpbnV4L21tYy9jYXJkLmgNCj4gPiBAQCAtMTgyLDcgKzE4Miw2IEBAIHN0cnVjdCBzZF9z
d2l0Y2hfY2FwcyB7DQo+ID4gICNkZWZpbmUgU0RfU0VUX0NVUlJFTlRfTElNSVRfNDAwICAgICAg
IDENCj4gPiAgI2RlZmluZSBTRF9TRVRfQ1VSUkVOVF9MSU1JVF82MDAgICAgICAgMg0KPiA+ICAj
ZGVmaW5lIFNEX1NFVF9DVVJSRU5UX0xJTUlUXzgwMCAgICAgICAzDQo+ID4gLSNkZWZpbmUgU0Rf
U0VUX0NVUlJFTlRfTk9fQ0hBTkdFICAgICAgICgtMSkNCj4gPg0KPiA+ICAjZGVmaW5lIFNEX01B
WF9DVVJSRU5UXzIwMCAgICAgKDEgPDwgU0RfU0VUX0NVUlJFTlRfTElNSVRfMjAwKQ0KPiA+ICAj
ZGVmaW5lIFNEX01BWF9DVVJSRU5UXzQwMCAgICAgKDEgPDwgU0RfU0VUX0NVUlJFTlRfTElNSVRf
NDAwKQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==


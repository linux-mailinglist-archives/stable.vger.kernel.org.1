Return-Path: <stable+bounces-189161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D6C02EF0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 20:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 728CB50077C
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B634B1B8;
	Thu, 23 Oct 2025 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="OpDyaKND"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362523F40D;
	Thu, 23 Oct 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244075; cv=fail; b=t5OQ18ilTqfQ+p8SYXJO2WB76eIWQiJ4zN6G9OeED3ON6h2R9RF/P1gwknW7hhAEk2kSd2Ipj4V/3bnXMdMkKAyVeGTxsihR1bV7V15LR19HQ1S+3sdqAi9kLdhjCWON8kiF5TitCAE5iyGQg+5PeWFURdq+RWASM0S5SrXjVyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244075; c=relaxed/simple;
	bh=dbZ2NpJKBizFGILBqSudcKsOLniAQwDzh9hwX/nSE6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZbZBcZ6d0qM6CbfQnEKsc9qUhVTKrmHgfZtQIhebPzqKyAJXqL6zsKgYVdIPVOPELZyJ6OJdRmxF70u0WOjriGrsmGI13bj6k5Kmv+q44fPGkfmdAc775rO05+8zRseBPGTqZ2qJG41ufnGccGbwP0aYRX0pJAOg+DY2CzTAV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=OpDyaKND; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1761244074; x=1792780074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dbZ2NpJKBizFGILBqSudcKsOLniAQwDzh9hwX/nSE6A=;
  b=OpDyaKNDxBdrYSJFCAoPIpfTMAPkaiBh2T9k3nrY0aPZ3EImBlFbg8vb
   ut8JYn+/K+xoCTRYTOEDWhKoUpQ+SvFoL6STcEunxwXQ62YI4ljblMGf7
   cXXIMkT3Ti9cvk+ttRAwWf982ufmo5EC9ymwE1MbXSVSaxTLZyxAaZUX7
   7FK0a/Is7WMU+fJjMa6ehZZvQw43Ef5F6O/VZCKMdOyRLPrEhHy2k0wRu
   TBKr5SugJYX+sOwoMuv7dYQJZEt9qjnp4W/5p+jM6JKV7koKnfIZLj5BN
   SykoRk1Z4pVcu6wDI6gHxTLRj4q9WLMfrNVJ7CFrVpdwxlraiBLeyFtkD
   Q==;
X-CSE-ConnectionGUID: MhND5RpASmGFDSjeUH/hJw==
X-CSE-MsgGUID: QIbiE9OBQ2SJktJWvjrGuA==
Received: from mail-centralusazon11021080.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.80])
  by ob1.hc6817-7.iphmx.com with ESMTP; 23 Oct 2025 11:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeBLc+cPeZDxweAFIFihhJ9B3KfJcvqjLSgLDBu99clZmMrVRuclN93YOnEchD8rRoroFbsjy+TCnHw3AfUJ/N+ErIR9JlYH7QlumYRBbqGwJshdCbtzYQPw5Lbnj7IldyLAcjyse8QLSfflu8c7YN6rCeihwOUzC70rgvvKpR0axiypg0eHlXKFOrSpC1b4+/hVGLMtUqNvWrKQJhMHzZvf8nZanqW10h7YxMFF0V7Gv0QgxEFzVy2eJhdzpPrcwHWSarbdrE3fCwKsFOb+v/5KgzjBCwut5j3iTh0LSoGQ/b1UODq/LxlvGCLj82MhZAe9uq6ZDBGioAC4givM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbZ2NpJKBizFGILBqSudcKsOLniAQwDzh9hwX/nSE6A=;
 b=FPbdD5wKsUz2wYA6lPBHzKGL0Z2tta/pZwbhWvVlVB7CSbw/iCy5yLi8gM87Lt/OAO0wFYwwK5dgQI7SFqLYJVHCQ3UjFNpd6X6a6xSQOCztqt1vC23hBMM4dRnoulvCizN7aZV/GlcbqyC8ABQyw/Hmm9WiQjGpAJ5erAkNFczGRFb4OzPO/eA2XdYt5Pv7/GGK1pMsmaYDbAD7ofowcrRhc4U/qXpvWc+8vNeHPkhAv0sbPLaneiGm9DiSy01u1Q14DqG9XuihRqCF84ZhFQWIxMa5ySjxTKvLNAPn0YLS70UAgYD95RlHIkrTTaDvIS1GW/tgmbo6p9PNpSMtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by CH0PR16MB5448.namprd16.prod.outlook.com (2603:10b6:610:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Thu, 23 Oct
 2025 18:26:41 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::df4a:1576:a40e:5491%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:26:41 +0000
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
Thread-Index: AQHb4PkYIguyqSnEKE+kzs5sxHxMx7TQkb0AgABAykA=
Date: Thu, 23 Oct 2025 18:26:40 +0000
Message-ID:
 <PH7PR16MB6196A61CBAF7D843A810919DE5F0A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250619085620.144181-1-avri.altman@sandisk.com>
 <20250619085620.144181-2-avri.altman@sandisk.com>
 <CAPDyKFqgY7nVW+GYSk8xMH721Ar2myvFjFAb6EWQHYrk8zGbQw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqgY7nVW+GYSk8xMH721Ar2myvFjFAb6EWQHYrk8zGbQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|CH0PR16MB5448:EE_
x-ms-office365-filtering-correlation-id: 88f69000-2e1a-4c07-fbee-08de1261b625
x-ld-processed: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4,ExtAddr
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXIvOXd4L0lyQWN3aFdrc0gxcGhnMXFiQ2JUNlhrMEtxTlo4a1BaVFRHdEVT?=
 =?utf-8?B?RWo3YVNYV2JvbUR0Kyt6QTFKaFFGdHltYlQyUTA5aW14SDJkWnpqMFVMVW9j?=
 =?utf-8?B?eUhadXlLQ2pwNlV4WXRQVExSUnhtNFFOQjN3TVhnM09KaC9pMjE4WGdNcjJE?=
 =?utf-8?B?Q05RU3pWTC9GWThYTk9OKzlPc3VXQ01zcnFzaklFVGUzZ3cxcytGV25YVG5W?=
 =?utf-8?B?TG9jTWJGYzRFV1ZYUStXMEdudlgzRzFoM1dXVkJtbm9kUDBpdUpXZVF2azNV?=
 =?utf-8?B?UFJzajNuUlJZSG9TRlpRN2ZSSnZSbWV1UXV0bk03bWUxZ2RXajkrNmcxYjVZ?=
 =?utf-8?B?aFQxMGtrVklpS1VhdER1KytJQU9rakZZUmdrand1YXBscGw2NGZEOHdjc1Vl?=
 =?utf-8?B?RGdTbFR2VjhuUDIwUmswaEJ0RUtxck9ENTFTNURpd0xHL0txVXRuTno0KzhP?=
 =?utf-8?B?VnQwa3h3NVE5Y05nZ281SkU1SVc2a3dmK3NOZ2lockw3SVdtaW81VXFTVW5x?=
 =?utf-8?B?Y3duMjVIcTl0cG5yOE8rb1RZdWplSzVxNm1meVRUdWs5NjNIWUhjVFlzU0xH?=
 =?utf-8?B?OEwvdHZHNllKV1NRMjZ1ZkIrelpDNzBEaUNPYlF5RWhkeHZaN1JMRzRCTENJ?=
 =?utf-8?B?ZEYzN0wxVWRTZkFRMEtjNU5YbnhVM0pzWmZQTnN4WHJya3lzTkxWaHdXZzFz?=
 =?utf-8?B?VzBjUmdueS8wZUZOTGtiWWhJMC9oeXpsSDB6bGI2RlN1c2dpTVRSRUl2RHJa?=
 =?utf-8?B?dEplbVI4UEhNeHhFOThLbFRHejdyQWtETkdPODY0RDlscms3TC92R0pPeGlu?=
 =?utf-8?B?YlFNVmxMMHBMczc2cmJMbFlLQTBNN2JNZ0d0REo4T2RieGthKzIwVGhCRm1x?=
 =?utf-8?B?QXJjQlBoOGs3U0RUZ1pZenBHQ0d3bjFWNkpIWld1TnVURkVXakdEYlc2MWE2?=
 =?utf-8?B?aHdrUnhkODdhUmhBeTE3cmRiSkYwQVNUQUlyYmFIUFlrTjVmVW5XK0JNWEs4?=
 =?utf-8?B?dWJVdlliVlJTckRGSEpSWSsrbUJtQzZUVGUyTGk1cHA4WThWZXJkQzF5SnEw?=
 =?utf-8?B?b0NCZXVBY3pUTkxQOHcrcVlWNFpoSnhyVlB3UXhZVHBFbk05ZS9JRW5HV0ZJ?=
 =?utf-8?B?RFJOcSt1bmpjWVJ5WGpDcDNTbnZSbStZdmMwRmplai9Ya285QjNPUitzZGgx?=
 =?utf-8?B?RzVSeEY1ejJDUmFBVTUrY1lTQWZNdUxZaHhrT0Q3cmFZQVZlazU2VWdqMTlu?=
 =?utf-8?B?K1ZtRzJDcjRKWEczNTB0a0QrV2prUE9iVEJDQlpHa0VvanRSMi9MM0ZTS1ZN?=
 =?utf-8?B?ZEJqdzdITld3Z3cxcG5kazAxNmRnbUtTYWJneTJsekE0NGRkcEp4Nml2bzBN?=
 =?utf-8?B?ZjNqQWlrOE53dkdiblpucDB5MVI1anRBd2NIVHVGaW4vT3dORWR5SXBnSGxn?=
 =?utf-8?B?YmdlQXVLV0NHY2YwZjJzZ2IxTUZYMXlaWVI0R0tlK2RmZ2RmZ0tIb1JuY1E1?=
 =?utf-8?B?Znhod0xjdmhYOE9Vdjd0SWU5WWJOOVhCQ0taN0FUQ0ZyNjdTbTlEN0FDK2dh?=
 =?utf-8?B?aldVK2s1bmdKbWlWejI5Q1VHV0lzQmswQmVqZ3FuekJuNFU0dFhGSGhXTTRn?=
 =?utf-8?B?YWlZcDVhMVdtS0tFZGFNSEs5ME1tSG14bnc2Z1R4TzZZdC9VZFNtejJnbDBj?=
 =?utf-8?B?Mysvc2h3YW1TT1d1MEZjZXoxOUZOb3o4RUsxcEw1NWZlWDk3a2liSWVvVGN5?=
 =?utf-8?B?Y1IwVEgwYndUaHJUbUtPZWlWWURVbHFaYUFmdkE5bGtvbFEzbjZPL29ycXQ2?=
 =?utf-8?B?WDB1bU4yYnJLYjc4OGFtdnFGUllhd2lpWVlqNVhkd2l2SmxpU1ZYc2pJRXRK?=
 =?utf-8?B?R2NITndvY2NmMDVQVEY0azdQR0I1QThrcEVodUtQUDZqRCsyUVBlNTlrY056?=
 =?utf-8?B?d1pRRS9LOS9UMDEyNUkzekdicVhWY1BjQnBQN2l1QkZ2a1RVL01Sek0yTU5t?=
 =?utf-8?B?cUhkYVBQbzRicHBCZi9BZHh2RXQrZWU5K0pHU29yR2dTT28zTWJ3empBQmdn?=
 =?utf-8?Q?NdxGJv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aytpZEcxZjFOMktncElnd3JqbzFwa2xuQ1NTQ2pYZHJ3RFl4emZHWGo3RVFz?=
 =?utf-8?B?ZWtvdHdpRE9jSlpwa2lWNEJaa2hrZEtlYlBmaU5vNHdHNW9LbCt1YlRYSGk2?=
 =?utf-8?B?THUxV1RydHRaRDNWZEVtc2pFbG5iekVLVHd2clNZM0cxSTdvUWdibERrS3dI?=
 =?utf-8?B?RC9VR2pDaUlMaXJKTHE1L3N5TDRPeDQyNXlaZnJrRVRCbi93MVMwUHd4Rita?=
 =?utf-8?B?VGVESVJlN0ZTN04zTTcvaU56anlxTXFPTzdnR3l6bTRYOStNYUd6U0ZyVENB?=
 =?utf-8?B?MmFaVGtxdE1jTWVvMUxaQXJwL3d4QTBnczBOcWc5WTYxL1J2VDhsWlR0c3Rt?=
 =?utf-8?B?ZEdzMFg1QTYxZ08rLzk2QzR0TDJDOWZwM0wyR0lJSmFvTFNDM24rVEtpTk1a?=
 =?utf-8?B?REtOZ1lqM2J5TEtTTjhYYkRDb1R6dkw1dDBrQXhRZStGVi9nWGMxYWFXeldF?=
 =?utf-8?B?d09BdlEwLzhSUUljR3I2bC9pZHZnWkp1ZkRRSTZ6c2RiL1AwS3BjR2V2Njli?=
 =?utf-8?B?L0IxdlN2YzhkZHY0QSs5TFNORG4zNDZMM2NWOWx1cjJRR3BXTHRVYWpPUFN3?=
 =?utf-8?B?SmRJMjR0VUs0TnVZRWt6TVhoZGlVUmZsYUNrQ3RMcEQ1Zjd4Y2J1RTVubW10?=
 =?utf-8?B?NXpndlNtcW5rUkxpdnVrZ0QzU2IzODVnZVJ0RTc4Mk9tR1VMWW9xc1p1RmpO?=
 =?utf-8?B?dU9rWTRvVTNxM1pXZC9DWnVNa21qQWFUcDBUSkVDWWMyNWY4VXB2M3MvZ3Ra?=
 =?utf-8?B?SWtsRGsvSjhmUit5c3JIU21FUU00amw1bkZ1VllvMmlKaG91VnZaYmJPcUhh?=
 =?utf-8?B?V2ZEanMxSGJDY1BYc0ZWWlFlY0puMFNRN0FXL0dvT29FSzBRYzNpcU52WDd1?=
 =?utf-8?B?cFJCbWFpT2pkRWhGbzhVdzkwMTNZUDA3UzBvZUhMOWwveis3SzYrejlMZjFD?=
 =?utf-8?B?STgyY1Q4cUdxR1h4d1IrNTM1bjV6aVZDUDdQYjM4d2xiWkQ1SUhyUldpcHgy?=
 =?utf-8?B?djNTQU1hcDR2cXVNeFY3dFhmTlB0Qk0wMGQwR1BPYU9mNkRWUk1pdzQwdjhV?=
 =?utf-8?B?UEZ2T3IvVEFQUFdJM21nMkFBVG1jcCszbDh1T3ZXL0tvM3VyU1kvQVN3c3Yr?=
 =?utf-8?B?UXlyejhDdFJEMExsYVRadzJGNEh0NXZMd0RmZThhRGk1TWVDUmJvV2JQYUlJ?=
 =?utf-8?B?QXVyWGhpWFF3TVlGOGVkbkw3SndXdElpV2ZoYSszRjBUbmwvcmdWWnBXZzNN?=
 =?utf-8?B?TVBsTEdHVkRIbi9zQ0NQY3VLcWFRT3pHcDBDRWt0c1BqZThaT3hWUVBmUEFp?=
 =?utf-8?B?SVZrdW1keWg1cVFFZWtuZ0ttS0k4RlMwQ0RiRno0QW84MGdIMnVaenJXZC9t?=
 =?utf-8?B?N1lKalA2eXdmWFRmc3ZxOUd5YmpnQUNObUFmRkNrODBCeUJPOVZrT2xYbkt6?=
 =?utf-8?B?bHdKL1Z0UzB2VlZ4SDZwaCtjQitMUEM3NTFNR2pIUlpVbmlXRCtqbHhvNllQ?=
 =?utf-8?B?MEdSeUZtZ3JkeWRtVGFxTk5xeXZsN2NOT2l0ZTN6VG9PdmwxbzFtcjY1MDJ0?=
 =?utf-8?B?K0E0T0lHNm9TSVRvZElKS3o5djZLSU4yQXE2V0xvR0p4VHJqSDN2dGpZSmw1?=
 =?utf-8?B?MVZTYkhMSkk2UlZISi9ZTlNoRDhDRE9HRjdKNHdTZjJtTjMxLzBFbjdvTlRS?=
 =?utf-8?B?OWlMNTd6bjc4bE9tVGl4OE9SUitwemdSYWlDQ2dXczhSWWxFVzZwbWg2bTVz?=
 =?utf-8?B?N1hUWE41bFpFcTAzd1N3ZkRwb1M0MFU4Ymw4ekJPeU9ZWXJMQ0hMY3YxL1c0?=
 =?utf-8?B?bnora1dTSXIybHBZdVkvU0YwckZXSE8rNUp0b1pqM2Jhb3hoR0dvMWZPTFRW?=
 =?utf-8?B?Q3FzOFI3dXRMS2NZc0R2Q2dDd3FibityRkNmR01GVHZZZW51WjBUTXZoaW80?=
 =?utf-8?B?MTMwWG5rdS9SbU1jV09haWdGaTBVM3ViMUJwZkUxcU0vbG5yS3hPcXhhaE8r?=
 =?utf-8?B?S2l4MEQ4N2YvNmNmMHg5ajlxQjNtRFUwL0o4Z3ZVeENhcTM3RzF5clVQb0J6?=
 =?utf-8?B?eDQrTHlXaDIxM1BOdGJ6M21teHBwV2p3WG1IRXVZOXVmcWJTUkI2Ykgxa05w?=
 =?utf-8?Q?MEv9sXHYWSWUhHCvqTydDGitq?=
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
	3n+5xiehqBfYqVIOdjFS19QnCukXOv2tIxcVDql8YBFG6divHGOeWA/0YHtFYdY299xt2Qk3GdAEkmOJUslcnTXpIv2GFTEsiw/WqqArIlFVZvPQlZi9picXbVydDlA5ERY0CEhoisgjMeI6T/TFXrF0b1UqzstfTUd14XzvUf+4flIPsXaXhPkpVWS/l32EmKH6bPD3dwmIPfVdRXrvCvqKcmhBT5H8C3U1LV/W0xrwJ3Po0meg3+6InYtkqOY62j/0B1wK3kJCbI2HOQNBKzanr9J9Dt1KYEyMkoj7XMdEmuWDnQSJvxayiKTJy6LfTe6x/rL6B70lgGmOWEzb6EV0MKWUNnY97+IbIfZzS/ad12I8UlyhORzCnImZbThqPPjBnakJWcdoh9PQZYy01pK8T4QKyEoKKHSPXuoz9+TYD2m7NPmA4Yw7DvWdJZibujNw/zFR2uOLsLBSoPC1/t4+Fl8sFclFlRNMFlyMOVB2jYkjpvJybMdAS+hpsn8ElcWedXp1TqbDoWzO6F6DR1DjHMgdOx61RO3dRyBEy2pEp6Icqnd74qYlnpdX3X0O0675ikOHe4zRHizg8kFA7pCCIouJu7YCL1vDpnBzZEzplj6L5r/MyR/5DPaW/w9BSRfpDn16ffxi4t5YXJh0QQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f69000-2e1a-4c07-fbee-08de1261b625
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 18:26:40.9932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMurS9n8zMdwHFjx41WCc0+NcDZRgY73EYquoSraNw5v6W4SNGvgAc3WT30abjSNQ6yNMN1fDgDd2lUccSjdnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB5448

PiBJIGhhdmUgZHJvcHBlZCB0aGUgc3RhYmxlL2ZpeGVzIHRhZyBhbmQgY2xhcmlmaWVkIHRoZSBj
b21taXQgbWVzc2FnZSBhIGJpdCwNCj4gYmVmb3JlIEkgYXBwbGllZCB0aGlzIGZvciBuZXh0LCB0
aGFua3MhDQpUaGFua3MgYSBsb3QuDQoNCj4gDQo+IExldCdzIHRyeSB0byBtb3ZlIGZvcndhcmQg
b24gcGF0Y2ggMiB0b28uIEF2cmksIGlmIHlvdSBoYXZlIHRoZSB0aW1lIHRvIGRvIGEgcmUtDQo+
IHNwaW4/IE90aGVyd2lzZSwgSSB3aWxsIHRyeSB0byBnZXQgc29tZSB0aW1lIHRvIGhhdmUgYSBz
dGFiIGF0IGl0IHNvb24uDQpQbGVhc2UgZG8uDQpJIHdvdWxkIGJlIGludGVyZXN0ZWQgaW4gdGVz
dGluZyBpdCB1c2luZyBvdXIgU0QtRXhwcmVzcyBjYXJkcyB0aGF0IHRlbmQgdG8gZHJhdyBtb3Jl
IGN1cnJlbnQuDQpDYW4gYWxzbyBwcm92aWRlIHlvdSB3aXRoIGEgc2FtcGxlIG9mIG91ciBsYXRl
c3QgY2FyZHMgaWYgaXQgaGVscHMuDQoNClRoYW5rcyBhIGxvdCwNCkF2cmkNCg0KPiANCj4gS2lu
ZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Qu
YyAgICB8IDcgKystLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggfCAxIC0NCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZC5jIGIvZHJpdmVycy9tbWMvY29y
ZS9zZC5jIGluZGV4DQo+ID4gZWMwMjA2N2YwM2M1Li5jZjkyYzViMjA1OWEgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9tbWMvY29yZS9zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9z
ZC5jDQo+ID4gQEAgLTU1NCw3ICs1NTQsNyBAQCBzdGF0aWMgdTMyIHNkX2dldF9ob3N0X21heF9j
dXJyZW50KHN0cnVjdA0KPiBtbWNfaG9zdA0KPiA+ICpob3N0KQ0KPiA+DQo+ID4gIHN0YXRpYyBp
bnQgc2Rfc2V0X2N1cnJlbnRfbGltaXQoc3RydWN0IG1tY19jYXJkICpjYXJkLCB1OCAqc3RhdHVz
KSAgew0KPiA+IC0gICAgICAgaW50IGN1cnJlbnRfbGltaXQgPSBTRF9TRVRfQ1VSUkVOVF9OT19D
SEFOR0U7DQo+ID4gKyAgICAgICBpbnQgY3VycmVudF9saW1pdCA9IFNEX1NFVF9DVVJSRU5UX0xJ
TUlUXzIwMDsNCj4gPiAgICAgICAgIGludCBlcnI7DQo+ID4gICAgICAgICB1MzIgbWF4X2N1cnJl
bnQ7DQo+ID4NCj4gPiBAQCAtNTk4LDExICs1OTgsOCBAQCBzdGF0aWMgaW50IHNkX3NldF9jdXJy
ZW50X2xpbWl0KHN0cnVjdCBtbWNfY2FyZA0KPiAqY2FyZCwgdTggKnN0YXR1cykNCj4gPiAgICAg
ICAgIGVsc2UgaWYgKG1heF9jdXJyZW50ID49IDQwMCAmJg0KPiA+ICAgICAgICAgICAgICAgICAg
Y2FyZC0+c3dfY2Fwcy5zZDNfY3Vycl9saW1pdCAmIFNEX01BWF9DVVJSRU5UXzQwMCkNCj4gPiAg
ICAgICAgICAgICAgICAgY3VycmVudF9saW1pdCA9IFNEX1NFVF9DVVJSRU5UX0xJTUlUXzQwMDsN
Cj4gPiAtICAgICAgIGVsc2UgaWYgKG1heF9jdXJyZW50ID49IDIwMCAmJg0KPiA+IC0gICAgICAg
ICAgICAgICAgY2FyZC0+c3dfY2Fwcy5zZDNfY3Vycl9saW1pdCAmIFNEX01BWF9DVVJSRU5UXzIw
MCkNCj4gPiAtICAgICAgICAgICAgICAgY3VycmVudF9saW1pdCA9IFNEX1NFVF9DVVJSRU5UX0xJ
TUlUXzIwMDsNCj4gPg0KPiA+IC0gICAgICAgaWYgKGN1cnJlbnRfbGltaXQgIT0gU0RfU0VUX0NV
UlJFTlRfTk9fQ0hBTkdFKSB7DQo+ID4gKyAgICAgICBpZiAoY3VycmVudF9saW1pdCAhPSBTRF9T
RVRfQ1VSUkVOVF9MSU1JVF8yMDApIHsNCj4gPiAgICAgICAgICAgICAgICAgZXJyID0gbW1jX3Nk
X3N3aXRjaChjYXJkLCBTRF9TV0lUQ0hfU0VULCAzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY3VycmVudF9saW1pdCwgc3RhdHVzKTsNCj4gPiAgICAgICAgICAgICAgICAg
aWYgKGVycikNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIvaW5j
bHVkZS9saW51eC9tbWMvY2FyZC5oIGluZGV4DQo+ID4gZGRjZGYyM2Q3MzFjLi5lOWU5NjRjMjBl
NTMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gQEAgLTE4Miw3ICsxODIsNiBAQCBzdHJ1Y3Qg
c2Rfc3dpdGNoX2NhcHMgew0KPiA+ICAjZGVmaW5lIFNEX1NFVF9DVVJSRU5UX0xJTUlUXzQwMCAg
ICAgICAxDQo+ID4gICNkZWZpbmUgU0RfU0VUX0NVUlJFTlRfTElNSVRfNjAwICAgICAgIDINCj4g
PiAgI2RlZmluZSBTRF9TRVRfQ1VSUkVOVF9MSU1JVF84MDAgICAgICAgMw0KPiA+IC0jZGVmaW5l
IFNEX1NFVF9DVVJSRU5UX05PX0NIQU5HRSAgICAgICAoLTEpDQo+ID4NCj4gPiAgI2RlZmluZSBT
RF9NQVhfQ1VSUkVOVF8yMDAgICAgICgxIDw8IFNEX1NFVF9DVVJSRU5UX0xJTUlUXzIwMCkNCj4g
PiAgI2RlZmluZSBTRF9NQVhfQ1VSUkVOVF80MDAgICAgICgxIDw8IFNEX1NFVF9DVVJSRU5UX0xJ
TUlUXzQwMCkNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=


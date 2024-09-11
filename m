Return-Path: <stable+bounces-75883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 743AB9758FB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3118B24A1F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0151AED41;
	Wed, 11 Sep 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zbqzlCXM"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA21AC8B3;
	Wed, 11 Sep 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074274; cv=fail; b=G2JeJGcL0R/OHyA2ww8UhvZoOzfmbh6ZX7BoMHJisFqOwmokBzOZZUg3YJ+T6XlfSrz+oX3S50ToxhOzuT61509MApcmODRxOTpfM7auyx7T9FTM5rPTsOTn+MDvaNcFgcVv4GXG+ZK2YtrnVnZQdS/+PcJdwCsjI69klWgyv1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074274; c=relaxed/simple;
	bh=/6PlQ/oTZJ698VmKxDgZ4tlFUlqWYZdRVCa3Y1MXfmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tPRHccwy6MQIDIL60SR9llnv14Ly+/7lq3Ep42wNXkLds7UsjcM262gH1S1oc2JRpe0PyUsDtCk9g68U2dP192eVBezL8hpwh0tqg3R9+FDSFqcxchevqkZI1O7U2dorPhs2hefkJdPy/kZZjEHyRckkbjxVRDikZ6Yr+jPtmI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zbqzlCXM; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmxDLgXVwCDKu323tHelo7mCN9n5k73B8QiYsG4+QN1/njo/dPvZkXiZOMHw8PjoPxg/7ZUvFuCD0VKA3+a0A3turJiwcheX88qbuCt79GtGseusnsMtoTyUWT0dY+fOHgX22rr7gnFRRMMlLOyVtmblpbYWAmTW/3eiT+C803J2w6E1WdW+grAqD9N8Sjr1dLzbfOnl1LAR51E/iGRVhmoFEJGUS/AzazG8dBk99IzW1ItjpS0Xl8jyWhvi0PWMHNiSrp1AVjwM6B0fqX+sVKEbuytqlU0Hw45tlm/IFbnBdpCDaWc6TxYGxj6HfslMdy5IlwALP0uAL0SBOn9W8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6PlQ/oTZJ698VmKxDgZ4tlFUlqWYZdRVCa3Y1MXfmY=;
 b=IqV1BWMqMqQLgIaJLUOJ56pdKk3cFGRwUeRbdq3rUOF2iQ/pYrUz3f4Rbl84caM/v3ixN6gCYrx7F5mLgwwLvDensYvuC9mrLXcucwF293skCHZiTukvqn1NYnGuUjP279ceaSEr7iull7a3i9USdwe8bORuQh7eZg6UDIUhW02r3gcxKEW8CpLX75tDQSGclgY9nMJtm4jVBUcLxi5yVnG9//fqWTT4sLjpthl9lyaA/9DqpEn0ICzLPFj8cfiZ0QdQ7O6DgMsLZVS5Iii4MAMc4lB5d99UVlGNUaaj9Ko+9ZkEMfpS25oM8oESD785KdRC9xtyHj36bwWE3il34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6PlQ/oTZJ698VmKxDgZ4tlFUlqWYZdRVCa3Y1MXfmY=;
 b=zbqzlCXMMm0LJMr5ZQH6weR3xnuzZ8Q8nrGpX8Msvyjw46Cf1Z1EN40473CGVjNoLQAGQFx21HD/aTti+p3Ag+nrvdtoJ9tkBswb5bGBuIDPecLrfH8UGML3JICpc8TlVq9RMq2YeVrMRusiZaLISjNbCfK1QdTe/2q62irnLqC0MiBKCITYcvd5xJ/7vl4QZg18E5mTUts0V8s6sCxPo2HpX6RVZORj8/9GxjLFanxxx/bvwBIuhLTmONp3DJy0OSvPjrZXZOkH53GL79O15Ga9kTNWMLtCf5TkpvrP8Zw56+Y6tGpSkBx0weN5y7NT1GuPi1gFbXFZ8M5V3YdTCw==
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11)
 by GV1PR10MB8441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 17:04:28 +0000
Received: from DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2]) by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35b0:fbf1:3693:3ba2%5]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 17:04:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Topic: [PATCH net] net: dsa: lan9303: avoid dsa_switch_shutdown()
Thread-Index: AQHbBFjNdrluTsjNlkqTR6odzDTPnbJSxpkAgAAHpICAAAJigA==
Date: Wed, 11 Sep 2024 17:04:28 +0000
Message-ID: <06f6c7d6f1e812c862af892f89d56d74b69995f9.camel@siemens.com>
References: <20240911144006.48481-1-alexander.sverdlin@siemens.com>
	 <20240911162834.6ta45exyhbggujwl@skbuf>
	 <9976228b12417fd3a71f00bd23000e17c1e16a3f.camel@siemens.com>
In-Reply-To: <9976228b12417fd3a71f00bd23000e17c1e16a3f.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6876:EE_|GV1PR10MB8441:EE_
x-ms-office365-filtering-correlation-id: 6b8f5734-4ed1-4e14-8205-08dcd283cbed
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0F1dXBHaXQyaktUNzdlQ0Qvb2RsTFV0U29oQTJnWnpKaXZvQzR3bUc0VlN0?=
 =?utf-8?B?WlNCUUMwNDNsQmNFVnc2cFBaS3A2ZHRuTlRpdEgyRGNheEY1TzJ5TGwwOHp2?=
 =?utf-8?B?b1EwY2tkZUVaZit1cDRoemZyeXcxcjNGb092VjFwZHRUK2FLNFRvSGRBdVFu?=
 =?utf-8?B?Mi85VXdMSjJZdTltb1hGUVZTcUtBanAxVzRyVkZMdzQvcGFHR1N2bkFZaFN0?=
 =?utf-8?B?d2FJSEdCMW9qZStMVXFkbzZpNmVHUnJjMlhZdyszd2RSOUVBU3d6cHFCa21k?=
 =?utf-8?B?R2ZMVHc1YTFTTTBNanlQQnM3K3pBVzZkY081aytWODRWcVh0UUE4c0lnOUc1?=
 =?utf-8?B?YXIyMWlIT3YvMGlsQWtxK2VjL2F6c3E0eGEvM0VIQ1Q0UmEvRlF3N1VIdTdC?=
 =?utf-8?B?TkM1eVFGamJLWkorZjd3d2JaQk5BTUgrY0xJQyswckRaSmY3Z3Z3WllSWjZP?=
 =?utf-8?B?VWVNWktudHF4bkk2REJUZ294Skg5WU9sRytqbzhzY1hmNmJQekU5a3hOY3ZU?=
 =?utf-8?B?c3RBUXU0aEFVWG4xbS9ScGRCSnZCRUlqL01NODhJdGdtby8yVWVYRXFIblVU?=
 =?utf-8?B?OVhlQnhIVlZkS2JKcTJnNnRjZ1JLdEE4YzE1M1htdTkyMHNhYkxOczd0TjUz?=
 =?utf-8?B?NU5IclNXbjQxaWoycVJtQkxlVk52NElwdlIzeCs4M0YvM2FBa0RhQnpnRGwr?=
 =?utf-8?B?VXpPMU95ZWpIVnVta2FlVy9vQVl6UHkzeHRtdk9tYUFrbzJoclpLSnhiNkpr?=
 =?utf-8?B?cEU5ZEhja1RuY1dFYWNYc2lENk12NDBlZ2NVV3FJelFDdFVXZi9uV1R2ZStJ?=
 =?utf-8?B?d25sbU1nNy9JNXMxS0pZcG5KZjFGNHNHd3EvMndRcm00OGM4KzhoQ09hUlFn?=
 =?utf-8?B?UFFidllYTzdWbENRc3VHdkpDaGZpY1hrSS9BejlMM2k4ZjFFYklXR3dwUjBl?=
 =?utf-8?B?YkVteFExVjhqRlV5RUVHZ2pRSTc3UjdDSG13RXNETTkrZDFuQjFnZHkvT0pH?=
 =?utf-8?B?TUkyWG1zdEMzTlJwRy9qaXBHQ3VRdCs0bWtaZ3krVmNKNW5PYy90VVNOZ3Jj?=
 =?utf-8?B?d0N1Sm92WG14TGJBd2ppaWFPZ0dVVHVSZHJVT2cvUVY4cGVUYXoxcFJRcVFX?=
 =?utf-8?B?ekd1ZjVLazJ5M2dtU0J2QUJpTjBNd0loK0Z5eE5wejFNS3paS2ZBMTRHaGdt?=
 =?utf-8?B?SUZoU3p6WXVDL0w1aE1GcVNSUjBOdGVaNCt6MlBVMlpsNmhhNm5BZU1hbS9p?=
 =?utf-8?B?UzJUQ25uK0p4QWwrNTZkVE5ELzRDUWRNLzR0OVE0cFNzOHhrQVdGRFZOcGRh?=
 =?utf-8?B?MEtzK0FXb2JQUnZsVW1RMWV1c3JHRzY4TXlhaHFQNWJOTUpmRjBFNVZuQmVF?=
 =?utf-8?B?Q1ZFWEZCS25UY21JZUV5NkJkdmRsWmFpTjVDNm0vdy9FWW4yQm9PYXBTZnMw?=
 =?utf-8?B?Z29BQXBIY2lGdUNuejRFYnBjbHJNaXI4WHZuSmlDVUlTUXNTMk1PVXVnd3ly?=
 =?utf-8?B?T3pob2Z2MTkzVXRWMmxyZ21oRFgzZ1lTN1NIb1AyaDlBMFBacDNCY2kzTy9B?=
 =?utf-8?B?Z1RoZjRwRzM3Mk5HYldVeFN0VTU0N1hxckV6RWxJTDBlZXJZc3I3SE1xOWg5?=
 =?utf-8?B?QlZEUmt5eDNoMjVaajFSQmdsNmJBR1FXMS91RDRVWC9vcm50bzJvaE5DWUhO?=
 =?utf-8?B?V2N2dzA2NU5vSFhTY3Z6U2NvUnMrNUE0c2hqNVBhVmFBaGVDcCt3aS9oZFpO?=
 =?utf-8?B?MmNIKy9IWGtkN2l5Y3Z6YTh4Nm53RklLRFlZK3kzT1o4djRQMmk4Z0lJcy9F?=
 =?utf-8?Q?AoSbfCbwNItVTpEqvWzYCG873AMOFzEQW0iJ4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVRvS3E4cFIrL3hYRE14VFhkbHBTNC96d3ZrLzBCVTJNeDNwQ2QrZEtHRkRH?=
 =?utf-8?B?L3djYlJwdzhQZWFxMVFPR3ZXdzNZaW5kV3lGUHoweitkSEYybU9oUndpOGtN?=
 =?utf-8?B?SDMxN2ZQZ05QRkZ1K2RaQ2k2WmlrZVk2OS93VWk3SkdyUC9NcUZwQjJ6WDU0?=
 =?utf-8?B?STVjNEFqb3g0Z2MyVGltVDJkeE1PcnZrNENmSEFJZHNMSWswVlFFMjNvTGZh?=
 =?utf-8?B?RVEzb3FpVnBpajIxRUVFMUNQODFZenVXUFVweFBzUVlhckpJSkV0YlY2ajJp?=
 =?utf-8?B?V1lQS0Y1Z1BaR1RCeHdrSHhwZWNycURaanFyRGNCSnBDTi8wOTJ5YzdFTk5C?=
 =?utf-8?B?blRsc3FUeHpzVVhZcnhJWjFQR3p0RWdtQW5nUDdxV09vaER2OHhuZG9qSjY5?=
 =?utf-8?B?TGRxQ0toSlY1Y3FkUzMrTGNmYVBDS3dwamRkSVM5N0cvSTA1ajdOMVRJTHZS?=
 =?utf-8?B?MFJ1TS9ha0hxOFU5QWpRdEhPNVdzSkdPWldmUGJqcHg3ZEI0RkpESnp5em9Y?=
 =?utf-8?B?dUR0RDNIWFp1M0Q3TzlNbEtKSjI4V21JK1lGelE3ZWhVMytNZnN3bzlpWmNC?=
 =?utf-8?B?dWcxSUlURGFyTVF2ZTFEdnBuQ3JTZkE2MnF2enB6d3BtWkV2aDAwOE05M3Qr?=
 =?utf-8?B?SEpPVm8zdk14aENuZmtuMzUzanNuazlVZmVjci9CZWdGUnhiTjhiSkU1cG04?=
 =?utf-8?B?dnBLTjB0TTU0bWVXRE4xeVBGUVFXZ1JCZVhmRGh2ZHhmTTVqSHd2WDFsMkla?=
 =?utf-8?B?TTE1ajBSWnNNeXZSNndjdVJYOG9OTTB0WXFqbjhDazJDQTN4UGpjcWNSdklE?=
 =?utf-8?B?L2RYWkNWejhZUVZ6ZkZGaHFKb0docHhwcU13dHowaURSN0l4aXZIZStxZDJE?=
 =?utf-8?B?ZmxCZTEydDk4bERLeG5wampoT2ttTFl6Zkx5S2VtbXAzZXRub0ZVK1FlZzNt?=
 =?utf-8?B?a0hKK0ltcE9Na011eXhWY0hQc3llbC9MVHRTQ0FzWXJGTmlQVzVhOWo1aGlU?=
 =?utf-8?B?YWUzVy9MYTJ5a3pnSjB0c0R4NHZxTVY4MFU2UFNPeHR1SW1LdnBLeHNkY1l1?=
 =?utf-8?B?Mjg4ZGJjOCtXbWhsRmxESms2SG9ZcHlEenpQQkpKekNKVmc4aWlBVkVHdThi?=
 =?utf-8?B?cVc2MlBSSFdQYTA1QUFVSWthSzdqM2RKS0hJNWRHOFhIMmo1V2tnUkZYNXdj?=
 =?utf-8?B?eEVDVWhwbWxQR2RjSTJuOGJTa2owdkdZUHZ2Y2tnMVp0aGEwSWhFQWxoUXVj?=
 =?utf-8?B?VTF2YTNsNGlRb0tHTi9rbGt6V2dhOGFkNDhVYjRXcTd3RGR4SFErY0pobnRP?=
 =?utf-8?B?YmZBSm9RN1lWNUNmUkpibGR5NGQxT2FBNkZETW5uSkpmMXJsbU5RRVdTSHQ0?=
 =?utf-8?B?ZWRWeTloUFk3ck1ENVduTVdTTmU3a21yS3kvYzFQb0VMUTdmZlNKTWVTZm5a?=
 =?utf-8?B?ZitkRFlqbUw4NVVGS2RJS0tObWJxYXNUSVpmOFg3Tllaa2N5Z0Z5ajRyVW1n?=
 =?utf-8?B?RzdIMWowbzJ2Vld1a0FSK3p2bkdCTFdtU3hLcFdodVFZbWU2UmQ0NXdxcUJz?=
 =?utf-8?B?LzErYUxBRnFWTGlNQkhLaTBFY0hrVE01OFNwKzdpSWJobkN1QTlDcThReU9z?=
 =?utf-8?B?dld5YkhQR0Q5YkFpVnY5eXRwOU95a3ljZ0NWYm5UclRMSTI1RUdPc0VRMklZ?=
 =?utf-8?B?cFo5aHIvK2ZaVWRCYzR6bXpUVWVYMzFJcTJILzhDclZrWThkTmozS0FRUklL?=
 =?utf-8?B?ZTJIL25waVRxTFdWdmRCa0pocXJNcnZaaTJaR1Azb1NIbDlTeVdWQUpqVVBW?=
 =?utf-8?B?YVdtQVRtaUtzcExZZzMrYmVIRkIyMCtrQkZTdHV6Q214VERxdDZGcmI5QnJ1?=
 =?utf-8?B?OFRWNE5aTFNtY2pWTGNFRHZRV2w4SDlGYkljaDNDS3BKRm1Zamw2S2UyTm5i?=
 =?utf-8?B?RDNRcjNSR1V0cGdJOWlrM3lyeW01RmtlK1VqcytKc3JNTUlyYmpyaDFCQitj?=
 =?utf-8?B?YzdvYkdHOUs3dDlQdE05eUhLU04vZkNMSjFTUGoxeEh2VnF2UldQT0loOXlH?=
 =?utf-8?B?UkIzVHVDRlY1K3hSWG5hMTdGcENVZkpLWk5iSzRDODBhWkhIbExGbEEyYjQ4?=
 =?utf-8?B?L3BoVEhpSDY1NXB5NC9abVJITk1CQjc3MHV3aWw4Q2FxYWp1a3IwOFpBWEcv?=
 =?utf-8?Q?gDxslR41BJVjXRzjEkhL0M0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F049F57223880469BB9A77A95FAE74F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f5734-4ed1-4e14-8205-08dcd283cbed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 17:04:28.3586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2J9BoeIg//KoZZULQU2T0MXTAzMDnmkUQBI+3T4U66jkgyloBbd3C8kdsgZC3v2TSmCDVu/5vqlI7/WGXnEYBfcyg7JftJgn4X0ORZL2dH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8441

SGVsbG8gVmxhZGltaXIsDQoNCk9uIFdlZCwgMjAyNC0wOS0xMSBhdCAxODo1NSArMDIwMCwgQWxl
eGFuZGVyIFN2ZXJkbGluIHdyb3RlOg0KPiA+IFlvdSd2ZSBzYWlkIGhlcmUgdGhhdCBhIHNpbWls
YXIgY2hhbmdlIHN0aWxsIGRvZXMgbm90IHByb3RlY3QgYWdhaW5zdA0KPiA+IHBhY2tldHMgcmVj
ZWl2ZWQgYWZ0ZXIgc2h1dGRvd246DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2
L2M1ZTBlNjc0MDA4MTZkNjhlNmJmOTBiNGE5OTliZmEyOGM1OTA0M2IuY2FtZWxAc2llbWVucy5j
b20vDQo+ID4gDQo+ID4gVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGF0IGFuZCB0aGlzIGlzIHRo
ZSBleHRyYSBsYW45MzAzX2Rpc2FibGVfcHJvY2Vzc2luZ19wb3J0KCkNCj4gPiBjYWxscyBoZXJl
LiBCdXQgd2hpbGUgdGhhdCBkb2VzIGRpc2FibGUgUlggb24gc3dpdGNoIHBvcnRzLCBpdCBzdGls
bCBkb2Vzbid0IHdhaXQNCj4gPiBmb3IgcGVuZGluZyBSWCBmcmFtZXMgdG8gYmUgcHJvY2Vzc2Vk
LiBTbyB0aGUgcmFjZSBpcyBzdGlsbCBvcGVuLiBObz8NCg0KYmVzaWRlcyBmcm9tIHRoZSBiZWxv
dywgSSd2ZSBleHBlY3RlZCB0aGlzIHF1ZXN0aW9uLi4uIEluIHRoZSBtZWFud2hpbGUgSSd2ZSB0
ZXN0ZWQNCm12ODhlNnh4eCBkcml2ZXIsIGJ1dCBpdCAoYWNjaWRlbnRhbGx5KSBoYXMgbm8gTURJ
TyByYWNlIHZzIHNodXRkb3duLg0KQWZ0ZXIgc29tZSBzaGFsbG93IHJldmlldyBvZiB0aGUgZHJp
dmVycyBJIGRpZG4ndCBmaW5kIGRldl9nZXRfZHJ2ZGF0YSA8PSBtZGlvX3JlYWQNCnBhdHRlcm4g
dGhlcmVmb3JlIEkndmUgcG9zdGVkIHRoaXMgdGVzdGVkIHBhdGNoLg0KDQpJZiB5b3UnZCBwcmVm
ZXIgdG8gc29sdmUgdGhpcyBjZW50cmFsbHkgZm9yIGFsbCBkcml2ZXJzLCBJIGNhbiB0ZXN0IHlv
dXIgcGF0Y2ggZnJvbQ0KdGhlIE1ESU8tZHJ2ZGF0YSBQb1YuDQoNCj4gVGhpcyBwYXRjaCBhZGRy
ZXNzZXMgdGhlIHJhY2Ugb2YgemVyb2luZyBkcnZkYXRhIGluDQo+IA0KPiBzdGF0aWMgdm9pZCBs
YW45MzAzX21kaW9fc2h1dGRvd24oc3RydWN0IG1kaW9fZGV2aWNlICptZGlvZGV2KQ0KPiB7DQo+
IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsYW45MzAzX21kaW8gKnN3X2RldiA9IGRldl9nZXRfZHJ2
ZGF0YSgmbWRpb2Rldi0+ZGV2KTsNCj4gwqDCoMKgwqDCoMKgwqAgDQo+IMKgwqDCoMKgwqDCoMKg
IGlmICghc3dfZGV2KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0K
PiDCoA0KPiDCoMKgwqDCoMKgwqDCoCBsYW45MzAzX3NodXRkb3duKCZzd19kZXYtPmNoaXApOw0K
PiDCoMKgwqDCoMKgwqDCoCANCj4gwqDCoMKgwqDCoMKgwqAgZGV2X3NldF9kcnZkYXRhKCZtZGlv
ZGV2LT5kZXYsIE5VTEwpOw0KPiB9DQo+IA0KPiB2ZXJzdXMgDQo+IA0KPiBzdGF0aWMgaW50IGxh
bjkzMDNfbWRpb19waHlfcmVhZChzdHJ1Y3QgbGFuOTMwMyAqY2hpcCwgaW50IHBoeSzCoCBpbnQg
cmVnKQ0KPiB7DQo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsYW45MzAzX21kaW8gKnN3X2RldiA9
IGRldl9nZXRfZHJ2ZGF0YShjaGlwLT5kZXYpOw0KPiANCj4gd2hhdCB5b3UgcmVmZXIgdG8gaXMg
YW5vdGhlciByYWNlLCB6ZXJvaW5nIG9mIGRzYV9wdHIgaW4gc3RydWN0IG5ldF9kZXZpY2UgdmVy
c3VzDQo+IHRoZSB3aG9sZSBuZXR3b3JrIHN0YWNrLCB3aGljaCBJIGFkZHJlc3NlZCBpbg0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNDA5MTAxMzAzMjEuMzM3MTU0LTItYWxl
eGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tLw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0K
U2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=


Return-Path: <stable+bounces-20313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1395856CDD
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F5AB22B3E
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 18:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9013AA21;
	Thu, 15 Feb 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NXA6ICQq"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FB13A884
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021662; cv=fail; b=i+BPuz7aycc/d4uobRXTFevs95uvp9DsGidZ98t6KeavMwlnvpMXAAbyBxbf9t8XQLcWkMwAPxqxcanen43Oyxma8pE940xc989VvBv+zEriTDaxjc/A29cwGIk/QDnxPaeyKTWFowGDPnEj0yDuWgLL/10vrGeAl14x/TDELF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021662; c=relaxed/simple;
	bh=jsOCUnbr98vbDGKOUgFahpBAyQxbDwFtVFBqJRJjBs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lO8DvHUunQO0EZ6uBXRF+SmAaDyaCZUdFaanWRzOlVcDt1OrgkhrtzRXQGl4kkPnTOrqCOJbDR+d2RocO5CG4nadz74ofUBTzIxwAU0peyLyIaVR6uqMYgAJ/4YY3I+0bT7p9JEgr4kF3HCyPeCBx71qhPwyqodbngOExVYi6+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NXA6ICQq; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwdEyo0C10cqd7YHkFz0Z/y4yx4VpioMfZk6rN6AM08d1QX6Q+qKOwOWYTynUs3TWx6otSRL2u4qDmc8eBINTKsvA6bZex6QwCye2jvv+T1U+S9KYaNJyIeX3U58bxxSIMn+V5WGo2VM/R4mEBKcQ7szupcKlkOdgh9cJApsEMlOTtilAFOMSlyyJeZKxFKuOFxOwLdmDfNlC8V8K4B/TeMlPy0K0wOE6f5twOWrON9/mqkOEKD6o3YpYUPluhQ6NI4EJFOl1FJyTaViYQmTa2zfTv0vQSSOghh7b95L5zn2Rb7W9ZMrH8q1tfUzHsLqYSCHhZq0K6V3lisEhKU2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsOCUnbr98vbDGKOUgFahpBAyQxbDwFtVFBqJRJjBs0=;
 b=hT46hO0jlvk0PXOMVCbI16C36HgPTRkhHJM6yNk5pKXnjppHR8YAlybwf/L0e6XOl8Xx3fKqsAZtcmuYWTnQ0LS4jTxR2i4Mma9NCuiTa5dP5WEDOr+wKCVdH4ceb+Ez4gmtK18woWvxvBn4TQfU3mBvm3NKLMAeIeetSqUqpxNm/T/sJdSg/NsTjjWAlgHL+zasxJhW8UPGOD/JOoGnXLGg2zYZpzyF7ca/ubjSE3fzwTZA2q2QAxIR8Z7ZyRqPPm9USnKhnfAqVIzwR4rCaah5G8jJVCa0T0AW+SJePqt+iLEby7T7XHnxLGwKyVpz6ddOTjmXF3ODcVRnfAovYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsOCUnbr98vbDGKOUgFahpBAyQxbDwFtVFBqJRJjBs0=;
 b=NXA6ICQqjMFT97fSa8rYnKeHRIq6xgGHsNnNCW+M2f8pv8d8xViTOfphKZ4DnVatTETTyl1ZRW9BNg+dzokzXk9rfKdGNOzky4LeluI9Kpa4wv6KjMAhZ5ijeKtNXf0qDSHjUEri68mNP3pIcB9Zq/ZZUqnJFf0mXy580CIg49g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 18:27:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::e1ab:29b9:e3b4:dfdb]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::e1ab:29b9:e3b4:dfdb%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 18:27:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Michael Zimmermann <sigmaepsilon92@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
Thread-Topic: 7840U amdgpu MMVM_L2_PROTECTION_FAULT_STATUS
Thread-Index: AQHaYCgR966oKJ+smUug/3K4P9Vf/7ELt8ag
Date: Thu, 15 Feb 2024 18:27:36 +0000
Message-ID:
 <BL1PR12MB514429AB5077226D9AC829B9F74D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References:
 <CAN9vWDLbM3tiBQRz0rNxfrLP4bMrEOiTNLRd4avvYKiEcpUr4g@mail.gmail.com>
In-Reply-To:
 <CAN9vWDLbM3tiBQRz0rNxfrLP4bMrEOiTNLRd4avvYKiEcpUr4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=375b840d-9119-45b8-a726-5a1c1333065c;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-15T18:23:22Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA0PR12MB8352:EE_
x-ms-office365-filtering-correlation-id: 7c116eea-240b-425c-6bdc-08dc2e53c89c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zglSjQPCYOXPv8JxNFEN6V5hvrtKgdbSjQTE59y6U0GJ/vlTe6DrzaEUj4HnDkEqun7LKfl/crmxMpaQ6yevdsDo2DGnMpYdkuzR7C+qfg9UehqAINbynI+9eR3L56nY2I+pDh3v/Ij1t3pZVa1WkHOPqI9rYXzJPsxsoVUwuokoOCTVYyTIiTYJYwS80SSIohfPZjE3AvZBZhFBdXpewVw/ADiBZbvgf1Ox9GkthVtUzSwODzL/j1ylAr9dH7v9DCqrsFhWzQY33Agi6X++xS7eQU9hwjsBT/1u+KiKDY4NZVlP7J7HVUNbaYhGGHPhGBwpdXzZQ5x4tB9l+YkS35CgigXbq3ddVN42iI0X9S1qKi33ZclH/4bQiPQt2U2LeaD74+zm0HEVxpTlqbTohgGSygxErCOAjjPMM+em/oD2jL3/HEv3V0IV3JofydurkfWE6v+fYkMrHWv06bt3a61L4vPeQIncl4JQIh9uf5soV7w0ZnIFpuf1xfa2E2ErNm9I6oO5zEeZLy0VZ08gOHG+k+X2pFvKHbu2PgWoF49idgQKZj0F9U7FTR59knE8cW9RrkJFNSrzGcANZuu4tiQ6DoCq9FOuxO7ka7ZELsNbDuZ/jjo5PauYDa9hwObM
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(9686003)(71200400001)(55016003)(41300700001)(52536014)(38070700009)(4326008)(8676002)(2906002)(8936002)(5660300002)(6506007)(66446008)(53546011)(66946007)(66476007)(66556008)(7696005)(110136005)(316002)(122000001)(64756008)(54906003)(76116006)(83380400001)(86362001)(38100700002)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHlLYkR1Qmc3ZVA3Y0dqd2t4N0krLy9CRFQrd1U4anc5WmFzaUlXcXZPV1pV?=
 =?utf-8?B?SjF4RnRpd3BLeTIrSVBLcFdyQXVmanhCWmV0Y0pzUXhwUjBlcHlRK1Bvcm1K?=
 =?utf-8?B?L21uRENRTFN6Wmg0ekM5S3V3M2ZxSG9nUGpxVC9hT29DUTFZbzJLK2Y0R2lZ?=
 =?utf-8?B?MHQ2NldSNXZlRy9ibUJia3kyYjJDdWdiR3hkbkdPeG9BWTZDZGlSN3NwMXkx?=
 =?utf-8?B?QlpsT2MvT0RWMjBIZDRjT0FrRDQvV2xDa1NRYWQ3TTlYR1dLRjFGVU1yUkVL?=
 =?utf-8?B?SFRCK05PK2FMN1NFVTV0R1IxTGNOQmJoRVBocnRPYWliZW83dnFmUWVVZnJS?=
 =?utf-8?B?ZFp5SGRyWnNuRms4eS9FS1dWV0p6bS9zS2VHMmRwRy9Bdyt2NTg1aTQzcnVZ?=
 =?utf-8?B?YXpxR2tBbDdFRlhkbzBaS3NoUXN2NkU0cWQ1ckx1ck9CV0s2RjZTTDkwdVhJ?=
 =?utf-8?B?VHh0YWJRSXNJRVhKclVtdTNNRVBUaTJzd0EwNjFlWEFmRWNuQmpzWHRjeW5l?=
 =?utf-8?B?YW9LS1NNQ1g3Qy9YdlFKRFVBNnM3NGZFNFNYeGt3ZUlBNXlQY2VQUjNRWkps?=
 =?utf-8?B?MDl6OGFSejBpeHVtUlA2Y3drZkJnNElWY1drUTZHN20xZUJVWXdHZmVabmRT?=
 =?utf-8?B?VmhSYVUwZEhseGZYUTRjOERtQ2htM3IzRksvY1VlUDV1Ny9LQjlMLzZMSFMy?=
 =?utf-8?B?WDJMeUJ1SU1GRUhnS1pjRWd6VzdqRkpoallWdUFrbHJDM2llTHp5aHRTNi9J?=
 =?utf-8?B?dTdnRXhtTDVlSzZuMXMvY1prc0l3M1pPNy8vdzdobEk0ZFNrMGFVSURCcXFy?=
 =?utf-8?B?cjI0a29JL3FZby9pdFIyMTBRSWRQcmQ1NnFhaGRrRWFVK2tIMmhrQUtWZE55?=
 =?utf-8?B?YWpVdDhqOWg0Rm5ocmhJaGtROG1xNWpzS1ZGb3RqeHRWN3kxRHc5MXhQc3J3?=
 =?utf-8?B?NTZ2U2I5WjFSTS9ER09oU2RKcG9UTlJPQVk1RTJWMm9mZTJ6ZEdDK2RUajQ2?=
 =?utf-8?B?YU1iT2xkaG9HSmNzUzRTUGtwd1dhV2pTSEtBdFoxMExGOEdWQlB6Ky9TNytr?=
 =?utf-8?B?QXpadnhCaW81NlJPZmEvSWxycC9ibGpnUVRTYlJYUlFxdzBFaTIvaFV6SkF0?=
 =?utf-8?B?L2lucjJhUG9UMmwxMHFRdnBFRnI0UUlDa3RhNlc3VUFINS8zbzhOMitFRWFs?=
 =?utf-8?B?SHFBRU5QckJQNzNlcUU4Yy9FUkNJcE9zbFA3NWR3R2ZucTE1TVIrKzl1azU3?=
 =?utf-8?B?aDJmdFQ5aWhKVmRYU3ZSclFwZEtpUHpUN0VLakpVbFRMZSs3eVdjTGszTUlM?=
 =?utf-8?B?Z1VpZ0xQR2p5TW1PSENiSndHSUVVQkJTY1BDcUlpanpXaE5ML1V0T2tkeDJ5?=
 =?utf-8?B?UUJMTCt2RjRCZHl1WGZUbU56U0hvOFdxVEc2M2tJOGZibUF0MGR0MS9jNzlw?=
 =?utf-8?B?ak9nL05wMkZuM3ZJTDZHUWhkMVM1ajRSNTEvcDUrVUpMTlR3QXJhUGRsOWcw?=
 =?utf-8?B?TTY2SVZUVFNESG9lTjBPTXdzRFRwNjBXNHZXUDdRRTV5b0RsQmhocE9aTzJ1?=
 =?utf-8?B?eGdMbjFjNDIxWjUySjNiRk1vdXZZcUtkU1I4Z2lGR1pVc2VzUE9IMXNVUmo2?=
 =?utf-8?B?RmRxTnRVOEVQb2xYYkFDNVhEQzg1N3BWS1I1ME5UWFF3ME9xSEtZRWFZd3dD?=
 =?utf-8?B?Y1JXa2ZYWUlnbzNyK1VzUlBFcGxiUGtKbzdOb0s5S3JNOU9rQlFGclI1M3Iw?=
 =?utf-8?B?VHZCV3FpRDVnT05EOWh6cVNhUnNFZnFCVGp3THZLZjhjaE5DUmNGN2hHVXF0?=
 =?utf-8?B?cHZUNUtEZ1ZJMmpMNUowZG1EM3JYNTNnSzBzZHRRRDR2MktNMGJyZlE1RDJK?=
 =?utf-8?B?eEVwaWVBVFo5SVBmQ1RYSlFMVzY2QnJOSDJDYU8yUnJSa2ozeHR6WThPU0Ny?=
 =?utf-8?B?MnlnNEpvWFkwQlhvNmcxdkRJZ09RUFpFVENXbkUveGxUNmRtcEtqakdVOGRR?=
 =?utf-8?B?bzE2eEpncEhpWEw5dmM3WkVrZUZFa0lPMFdzWldEaW0wRlZmYVZKbTY0Z3l6?=
 =?utf-8?B?T1ZYL1J1amVOQmxOSzFFR3o2Y2hySisvUVUvMXh3N0J6RmRzM254ZHZJaFJi?=
 =?utf-8?Q?KgjU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c116eea-240b-425c-6bdc-08dc2e53c89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 18:27:36.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZSqNrZjT6qbvc2Xb/otad78xoTEFd2KWU0BN5ae/cNpnWMWlqTba/0qH0dW2rT+hXT4YEZzd03uJOLS+OHmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVs
IFppbW1lcm1hbm4gPHNpZ21hZXBzaWxvbjkyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDE1LCAyMDI0IDExOjAwIEFNDQo+IFRvOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY7IERldWNoZXIsIEFsZXhhbmRlcg0K
PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0K
PiBTdWJqZWN0OiA3ODQwVSBhbWRncHUgTU1WTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUw0K
Pg0KPiBJIGhhdmUgYSBGcmFtZXdvcmsgMTMgd2l0aCBhIDc4NDBVIGFuZCBzdGFydGVkIGhhdmlu
ZyBtYXNzaXZlIEdQVSBkcml2ZXINCj4gaXNzdWVzIGEgZmV3IHdlZWtzIGFnbyAoaW5jbHVkaW5n
IHN5c3RlbSBmcmVlemVzKS4NCj4gVW5mb3J0dW5hdGVseSB0aGUgaW5mb3JtYXRpb24gb2Ygd2hl
biBleGFjdGx5IHRoaXMgc3RhcnRlZCB0byBoYXBwZW4gaXMgZ29uZSwNCj4gYnV0IEl0IHNob3Vs
ZCBiZSBzb21ld2hlcmUgaW4gYmV0d2VlbiA2LjYuMCBhbmQgNi43LjQuDQo+IEkgZ290IG1hbnkg
ZGlmZmVyZW50IGFuZCByYW5kb20gZG1lc2ctZXJyb3JzIGFuZCBzeXN0ZW0gYmVoYXZpb3JzLCBi
dXQgSQ0KPiBjdXJyZW50bHkgY2FuIG9ubHkgcmVwcm9kdWNlIG9uZSwgc28gbGV0J3MgZm9jdXMg
b24gdGhhdCBmb3Igbm93Lg0KPg0KPiBGaXJzdCBzb21lIGJhc2ljIGluZm86DQo+IEknbSBvbiBB
cmNoIExpbnV4IHVzaW5nIHRoZSBgbGludXhgIGtlcm5lbCBwYWNrYWdlLihjdXJyZW50bHkgYXQg
Ni43LjQpLg0KPiBJIGhhdmUgYW4gZXh0ZXJuYWwgbW9uaXRvciBjb25uZWN0ZWQgdmlhIGEgdGhp
bmtwYWQgdGh1bmRlcmJvbHQgNCBkb2NrLg0KPiBJIGFtIHVzaW5nIGFtZGdwdS5zZ19kaXNwbGF5
PTAgYW5kIFZSQU0gc2hhcmluZyBpcyBjb25maWd1cmVkIHRvDQo+IFVNQV9HQU1FX09QVElNSVpF
RCBpbiB0aGUgZmlybXdhcmUgc2V0dGluZ3MuDQo+DQo+IElmIEkgc3RhcnQgcGxheWluZyBhIHlv
dXR1YmUgdmlkZW8gaW4gZmlyZWZveCB3aXRoIGhhcmR3YXJlIGFjY2VsZXJhdGlvbiBlbmFibGVk
LA0KPiBpdCBzdHV0dGVycyB1bnRpbCBpdCBzdG9wcyBwbGF5aW5nIGFmdGVyIGEgZmV3IHNlY29u
ZHMuIEkgY2FuIHNlZSB0aGlzIGluIHRoZSBrZXJuZWwNCj4gbG9nLiBJIHNlZSB0aGlzIG11bHRp
cGxlIHRpbWVzIGZvciBtYW55IGRpZmZlcmVudCBhZGRyZXNzZXMuDQo+IFsgNTY0MS4wNzA1NDBd
IGFtZGdwdSAwMDAwOmMxOjAwLjA6IGFtZGdwdTogW21taHViXSBwYWdlIGZhdWx0DQo+IChzcmNf
aWQ6MCByaW5nOjQwIHZtaWQ6MSBwYXNpZDozMjc4NiwgZm9yIHByb2Nlc3MgUkREIFByb2Nlc3Mg
cGlkIDM2ODANCj4gdGhyZWFkIGZpcmVmb3gtYmk6Y3MwIHBpZCAzODUyKQ0KPiBbIDU2NDEuMDcw
NTQ5XSBhbWRncHUgMDAwMDpjMTowMC4wOiBhbWRncHU6ICAgaW4gcGFnZSBzdGFydGluZyBhdA0K
PiBhZGRyZXNzIDB4MDAwMDAwMDAwMDAyMDAwMCBmcm9tIGNsaWVudCAxOCBbIDU2NDEuMDcwNTUz
XSBhbWRncHUNCj4gMDAwMDpjMTowMC4wOiBhbWRncHU6DQo+IE1NVk1fTDJfUFJPVEVDVElPTl9G
QVVMVF9TVEFUVVM6MHgwMDE0M0E1MQ0KPiBbIDU2NDEuMDcwNTU2XSBhbWRncHUgMDAwMDpjMTow
MC4wOiBhbWRncHU6ICAgICAgRmF1bHR5IFVUQ0wyIGNsaWVudA0KPiBJRDogdW5rbm93biAoMHgx
ZCkNCj4gWyA1NjQxLjA3MDU1OV0gYW1kZ3B1IDAwMDA6YzE6MDAuMDogYW1kZ3B1OiAgICAgIE1P
UkVfRkFVTFRTOiAweDENCj4gWyA1NjQxLjA3MDU2MV0gYW1kZ3B1IDAwMDA6YzE6MDAuMDogYW1k
Z3B1OiAgICAgIFdBTEtFUl9FUlJPUjogMHgwDQo+IFsgNTY0MS4wNzA1NjNdIGFtZGdwdSAwMDAw
OmMxOjAwLjA6IGFtZGdwdTogICAgICBQRVJNSVNTSU9OX0ZBVUxUUzoNCj4gMHg1DQo+IFsgNTY0
MS4wNzA1NjVdIGFtZGdwdSAwMDAwOmMxOjAwLjA6IGFtZGdwdTogICAgICBNQVBQSU5HX0VSUk9S
OiAweDANCj4gWyA1NjQxLjA3MDU2N10gYW1kZ3B1IDAwMDA6YzE6MDAuMDogYW1kZ3B1OiAgICAg
IFJXOiAweDENCg0KVGhpcyBpcyBhIEdQVSBwYWdlIGZhdWx0LiAgRS5nLiwgdGhlIEdQVSBhY2Nl
c3NlZCBzb21ldGhpbmcgdGhhdCB3YXMgbm90IG1hcHBlZCBpbnRvIGl0J3MgdmlydHVhbCBhZGRy
ZXNzIHNwYWNlLiAgSW4gdGhpcyBjYXNlIGl0J3MgR1BVIHdvcmsgZnJvbSBmaXJlZm94LiAgRGlk
IHlvdSB1cGRhdGUgbWVzYT8gIE1vc3Qgb2Z0ZW4gdGhhdCBpcyB0aGUgY2F1c2Ugb2YgR1BVIHBh
Z2UgZmF1bHRzOyBlLmcuLCBhIGJ1ZyBpbiB0aGUgdXNlciBtb2RlIGRyaXZlciB3aGljaCBjYXVz
ZXMgdGhlIEdQVSB0byByZWFkIHBhc3QgdGhlIGVuZCBvZiBhIGJ1ZmZlciBvciBzb21ldGhpbmcg
bGlrZSB0aGF0LiAgSWYgeW91IGNvdWxkIG5hcnJvdyBkb3duIHdoYXQgY29tcG9uZW50cyB5b3Ug
Y2hhbmdlZCAoa2VybmVsLCBtZXNhLCBmaXJtd2FyZSkgYW5kIHdoaWNoIHdhcyBjYXVzZXMgdGhl
IGlzc3VlIHRoYXQgd291bGQgYmUgaGVscGZ1bC4gIElmIGl0J3Mgb25seSB0aGUga2VybmVsIHRo
YXQgaGFzIGNoYW5nZWQgY2FuIHlvdSBiaXNlY3Q/DQoNClRoYW5rcywNCg0KQWxleA0KDQo=


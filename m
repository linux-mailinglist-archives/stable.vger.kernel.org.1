Return-Path: <stable+bounces-53666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64190DE81
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1531C20E81
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3A176FAC;
	Tue, 18 Jun 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="o67QnJXN";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KXwWOw6E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fQzSjg1o"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF513DDD2;
	Tue, 18 Jun 2024 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746589; cv=fail; b=GL6Vfz77X0eh5Stz/wMxyCOloTEK6D9ON9YzWFgyomkfPzzJBXn1RiRYXsH1vMencGBjomgRfKSoDl0FThLjwiFRLDEQ3y0TaJ0IlbrT3mgyhzMfUe5N8EeNeI8U4I6u7r5VrAIRGb0gVt3WHXpj7BazKXKP7kbgzajvaWWhM2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746589; c=relaxed/simple;
	bh=LcyG2G4xEcEfBaULSW2GKBSD4x+rw8Teasx7WVdOsBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2eYEpPfHs1pnIPKzWXREWtUqdV1CQRBuUVGJ3Tl14NUh5vvBWA3n+JfbxqVgPynfxAw2L8UipIxsa8n3uvNHRFcppMQRqXQqOnzCZkONK9vKBdy+6Un7ngj0G9AutEXmFNiOP5Cl7kqnZ8uvEDL8AZygzvG76UnF6Qh/CZyYyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=o67QnJXN; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=KXwWOw6E; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fQzSjg1o reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILWCkm007061;
	Tue, 18 Jun 2024 14:36:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=LcyG2G4xEcEfBaULSW2GKBSD4x+rw8Teasx7WVdOsBA=; b=
	o67QnJXNiy2+Hw0SQXG50mxOfxLWl9LcbeRcQGnpDrfc2GrEHUYOyJK5v/5zFwzm
	/hTzrenu4pllIsoR5HdEixG3tm49W8cBuyhp4qw3KjVJWzxqbQIx9wjeeIa7gBq/
	9pyAYOiD6zEio/zkYFYElamVGrDIfuFurumjeDEW4tRMPb6ei62PawHTwBtqoVna
	hRvKrbLSA2iHljK/flxabagYTKyNxwhotYXUY6WwMiySRJnkZ6eEmD4wNYDWpLrs
	UKdgdwLMl5m5GK8L/q0wKvW9Hj2Uo4LdikO/HNMVhz05XGrb3ErxGxIDRgJknosd
	hxCP9rgLsvIbvB3DIintng==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yuj86g0cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718746570; bh=LcyG2G4xEcEfBaULSW2GKBSD4x+rw8Teasx7WVdOsBA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KXwWOw6EdXdpMIjhRLJi3eF0wPNOK4K+RLEskFkIBntgVKp0y9O1hJe9obfshYuSr
	 lexNpRaR1asCD5+MpIrXRB7HC0H0DM1p2zmIM1vatyqkysUIpglwfItugzp1z2HnbG
	 Oc25FbFh0P2zelIYhgf9/nc3TpyZB4i71i1QfLL9eBcroHEsKYpSwYSN40DsxxbpUS
	 EpF/4bXd+OHj/JNE0jjF3Cf393orAa0IvTNfbEWYZb4MLrICEVDyUKNkNzHrp8tR3f
	 WsOIKD3aoevidHJn/Bs1iG+0rm9/d7ammWLSPE80LH21Lum2ogg5w65qkDH+pW07Rh
	 Nt7a2uRRU0fOg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E807405C9;
	Tue, 18 Jun 2024 21:36:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 09FE3A0071;
	Tue, 18 Jun 2024 21:36:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fQzSjg1o;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D0842401C4;
	Tue, 18 Jun 2024 21:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdJ3RU1/Y1yvY+CpAx2LrhDhixKhBOlutMhKLlpt6R/9jRPdxw0+gkKweI2RMUV+ksBaT9g3+pGUWg3upwZAfwW3f7/wtAaPRaJIjqvNn6FytvXRyxiN4odKpBukazxB5WtoQL4ruxNX1r2eDFWYBObl0xg1Ryso961wGNdTGNdmWp/sK7orpRmidmN+Psr9SA39WfmUfcuoDl73Yn9EY2zKNOD7lI8EOVnjpTdpD2cKr687RUNLIMp/byFwZUQG36HUqd3wu+gCLCEFSRtU7iyScPN47oJcgQDeB6KsFqg28MlCKvu0uussXEhrieFv22keq/2QyaeMe/qtVrbP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcyG2G4xEcEfBaULSW2GKBSD4x+rw8Teasx7WVdOsBA=;
 b=TUWjXBwHCbxMqbvLwYHOJUPcLIgMssWHga90/EZb9vD3IYKAVgDxov7tZlhlzCDD3T3LNtoyaQNGvHcmjpnDkoXE48PbBlXpFgbGR9m7Oc39/7f+tLTeHcFjSfZs8AuzW4Euipa9KuhsQHVchCrUKUJHmvArQS2W08CaHSrRxcbqYdeHQOhfk0RANFRNXE3hI171b+DcOHX52llhQkEjs3/cLbAsOKe70jmul+klOdH1ptFUc61e5TZiA9hw0zxAo0bjxiQQv7Xmz4ua78HlNSn8dmwqEwzDTYQZ+iyOMksjdm4Fz+Xl8w/v5UECEOnXyB9xocbxGWhtL+nipAVyDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcyG2G4xEcEfBaULSW2GKBSD4x+rw8Teasx7WVdOsBA=;
 b=fQzSjg1oyQU+ATK0GIIcsvy/Tz0njNALXAJL1mI2ZNkKpJ/Kq4aQWTO+eOMI9Xz3ksWAWeZOY70YYObUwUHRyDBZvuw8XMhxm/YQnoritGkuxj7vF85hB4/T11sXu1ZSJlFlagizt6ySipDK5EaXtBW/WvXmTdCHqmkp558arQw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:36:05 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 21:36:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jung Daehwan <dh10.jung@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, joswang <joswang1221@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHavN68+4rS9XFwd06IBuRrKh805rHEW20AgAE5awCABxe/AIAASH2AgAEgNAA=
Date: Tue, 18 Jun 2024 21:36:03 +0000
Message-ID: <20240618213600.63fdhod6nnx4h4m6@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh>
 <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
 <CGME20240618000530epcas2p15ee3deff0d07c8b8710bf909bdc82a50@epcas2p1.samsung.com>
 <20240618000502.n3elxua2is3u7bq2@synopsys.com>
 <20240618042429.GA190639@ubuntu>
In-Reply-To: <20240618042429.GA190639@ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB7695:EE_
x-ms-office365-filtering-correlation-id: c91e118c-e8bc-4ce9-cdf9-08dc8fdea74a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Qms5dGlUZHlmT2NQNHFuL2hTREljdTVjdmpHWUQ0NktsTHI1K3drZHozWVNF?=
 =?utf-8?B?RmNzd1lEc051elU4MEkzT3FZVkJ5aVlyMlR4UGhYRWNVS01BU1JiQTNjSGZB?=
 =?utf-8?B?K2VWWlh6SnVKekp5SWZBNFZZMDVRQnNLN0grRVJsVnE2SWFXYmo3WmZwRGp1?=
 =?utf-8?B?YS9YREt2YjRVQTFoUE9xN1JvUFVES0M1OUhHNzZ2TWd1U1dYaEE5MzdxVDMv?=
 =?utf-8?B?TWh4d0lFRjF0UE4rR0dQN0JVaTJDTGVLUXJXaDBscnBTdzJVVFNUWUJCcDdF?=
 =?utf-8?B?QWh0ZU9maFJ0Mk05Ykk3bXQyZDNLSmtlQmhCOUJ6QklybTUrUEZ3VnNMM2Na?=
 =?utf-8?B?RzZjalZ0SFI0MHdoVWlrd3ptcjNVdzRUUU1VeDczcUswQlVoS0ZOSmlqVzdM?=
 =?utf-8?B?bE5NWGJ6VnI1TXErelJkNk5ncU9BMy8vOEJFMENwS3BwbUFnT0l5TnlDRGpD?=
 =?utf-8?B?UFhvcGJIZ1NhTDR5NVUrYTBKNGZkNVloUUhsQ0U2T1lOa3h3eFhyZDBhb044?=
 =?utf-8?B?TjNTQ3dHZEUrVTdzLzFJT3EreDhkZ2ZhOXdqVnpaSlVualhiM0ZlR01Yc053?=
 =?utf-8?B?MFo2eWc5SWNMcUQ0bUhQaTFTWjRWQTMyQThSNnUrdkxvdUJhVmY3cVhxYTZl?=
 =?utf-8?B?TkZWNENId1RXcjdDM05qYkZkMHFYMjNWV0hoMDR0d3RJVGt3WlU0N1NVenRt?=
 =?utf-8?B?MWdBZCt4QitSSmcyTlZhcWRGNWFGQllKVDZhcWgwZTJ1U3hEem54dXU3UXp2?=
 =?utf-8?B?SVhyRTRIRVJJaGsvd21WaUdnRkNTNFlvNmJ0cEdmdFRqYjFCZW5GN1NOaENN?=
 =?utf-8?B?RjAzZmVQQnd4TW5xQUg3S3h6NnQvM3dxWUxZK2ZLK0tTdTN4T0dHalk5RmNu?=
 =?utf-8?B?NGR4cGRlRWVjZ2RpbVUzZXgzemg0LzZrOWV5NGVEYm43bGFVeTlCVWN6Znp0?=
 =?utf-8?B?TEFSQjYyVzBoc1gwMVFrUHRVdEdVRndKaWx3VE1BSWhEQWJKbjlML1FBZUsy?=
 =?utf-8?B?U0RPalpxeVRyT1N2UFc0YjNYUnpBanNTU1hZRUV3aEhwa054bXJjcDJUME1L?=
 =?utf-8?B?SHpRVTNJYVRiOUFsQkVsZEhITXIrR0FzcmdYVUJsTUM0cmhDWUkyWmlYSFF2?=
 =?utf-8?B?QkYwMDBHaW44d0wzVVhobUc4ejNiQWVQaVR0R2lBY1hwS1l5OU9COERSdjVq?=
 =?utf-8?B?bHJaTEpzbTBhbDFwSXhXZE1FVG81enhKalNMMEVxS1M1Vi83ZWFiY3YrbVM1?=
 =?utf-8?B?aHptSzlMcUtYWUFFaGRnZitOWGZPMTNPQk1kdFJBVUtTVk9TRVZ6N2xqaDg5?=
 =?utf-8?B?R2NQa0dBYndWUFE2OGJKcFhHQlpqL0ZjSTM3YXg4bkM2ZUplVHA4NGMySS8z?=
 =?utf-8?B?cDg2ZmlSUFFhemtoRVF2aUpKYjRIY2RZZURFRi9QSWs0cUNaay9HNkhOOGVh?=
 =?utf-8?B?d1dZK1ZpM01nTFVwdmtKRUoyVUtUajN4MU5xdDdURG9VaFJWMjRld0RNOXYy?=
 =?utf-8?B?V2I2VGZ6QlhvNWpDZmk5bXFPcFUrNmkrUy9UbitPVzZwZzN2eXN4SW9nRjJv?=
 =?utf-8?B?SkcxU2J0YUM0SlBZVytPbnJ5QXc1NlhyblRZYUNRR1hqdUpVV3ZrcjVOTHFs?=
 =?utf-8?B?MVBLTWRHemlHcnR5ZU5waVZ6blliRWdSSVNaMWthUjhPU1Q5VXdIRjUwK25m?=
 =?utf-8?B?K3J4RGZFbnRKdEEzQ2JrUHhvUDdTcjQyaTRTZ1BweHptSGFNS2I1a2tkc2NE?=
 =?utf-8?B?WmpaU29pb0VrR0N1OVVra09VeENsR1hzelU4b3JJd0kvcDRHV0l3SklwdWdM?=
 =?utf-8?Q?XXmTD0NES+dVdcske3/b3oXqlhSoZm0x0UR2c=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y1V4OWJ4eDFSVUlDaHdiejdwK2JnTzIvYmdYNlpBTXF1VGtrMHR1TG5yMjJv?=
 =?utf-8?B?R0liN1ZTNDNQNzJPdnVBdkpPbzdkUVlkbDBoSlNpdjBVZFVwZ01NcXBnTEFU?=
 =?utf-8?B?akMvcm4zMzhpM3hzVlpKRUhDMkZrTllJeTFwRTlnbU1Ka1RMWEVzK1Q5OUVs?=
 =?utf-8?B?RXZ1L0J4aGc1WElhdjd6VTJER3VzTytMOHIxWGFSQ1hGRk4xRXUydWNxOFlE?=
 =?utf-8?B?UnA1NVJkK3ByMUl1cEpCNWNaMVAwRkF2NUFFdW5uUE5CYko4YjJYZHFLR3NL?=
 =?utf-8?B?MEVpaHUxcHVERXVMaUx2MnBGTm5ZMHA4RDZzYWNNR0cwKzFPUGMvQ3hINlNz?=
 =?utf-8?B?aVc1SjRaVzBFSERVUWlzWjR6aTFycG40L2NNOVc4NXEwcUdpbVZ2dVFXeGM0?=
 =?utf-8?B?bGpJbkZVaVpnZnJxbnFGNHl1MmlIWU5zWUh6bDNSd3NNd0N5am83ZzgxcFpl?=
 =?utf-8?B?NXJrTEFxZ0xwK2JyaTdINFlaTmNuSTFMdmp3VDFsWFpjWnBNakhHLzNPalJl?=
 =?utf-8?B?ekRLbUsvc3o3YzZxNTVKbjJtN3FYV3htU0VnYTd1ZHdpMWl0KzI1TkNKQ1hq?=
 =?utf-8?B?d0ppU1FhenZwN3c1WXZwSjRTMHpyaUhLRmFodWoxdGo0NnhCSkNOeUJMekVu?=
 =?utf-8?B?Y2NIU0ljblFVajNPTm0rVXdhZTRUeTB3TmYrS09xN1ZIa2RDRXQxajNsaDEx?=
 =?utf-8?B?ZllaZE5DR0x0aUpSdlA3UmtPSnJJY3hIUVEvUU9VYjRMaFB0dDFRcE1kc3F3?=
 =?utf-8?B?aittUG9UWEJnWW1iOWlHcFBZY3d2WXFTTHd2YUEzS3hlS2o0L2t6TlJJV0dP?=
 =?utf-8?B?czE0anU2OVlkSTFDOTNta0IrT2svdkZBR1EvSmN6eVJtc2x3YkI1ZTRlcjQx?=
 =?utf-8?B?bnpPb3FzZDJHV3dMR3F1RUthVkRZNHpWcU1acjVUbTVSSHRSSWFOOEVtZEsz?=
 =?utf-8?B?b0hZNjJadmh4alpTTkJ0MHFNVTh0NFBQWnRpT200T1U2Tld1VmdncElOemU3?=
 =?utf-8?B?MFlNb2NkMDVKSjFLUE1OSFNHSFNWWWM5QjMxdXBnR1llb2N0K1c5TVNKV3VK?=
 =?utf-8?B?OHF6Z0VFRW1RWXBQK2U0djJacmI1SzBKSGNHVVQwcUNFV1BWSmtzdGlZRmtq?=
 =?utf-8?B?dllZaFFDZllzRGlkTzZMMmZUTm9UK3duN3oyNkRWcXBwdjM3MVM3TmJWQjN1?=
 =?utf-8?B?bFJIT2ZyTmlYMUUxRkNRSDVJVnRkTGtrS2JFa0tqZ2dIVUhyL29jMk9mYlN4?=
 =?utf-8?B?T0tGODBhVGVOWkJjc3RjNG5ZUTBGNythSTBkeWhlSmN0NFFBRDd6Qlh1MjlF?=
 =?utf-8?B?cUtmQ05kemUxNVRqV0RNOVJ1RkxoamtBaTllQTlaOHpNMS9XazMwY3V4ZE5p?=
 =?utf-8?B?SkhUQmRrSnVyNDc1ellhb1daRGV2aHNUMzJXUUlRY0ljWjV2QzZGL09IRktv?=
 =?utf-8?B?N1VzMk9nYWwwTnQ5cDZCeUdYUFF2aXp3cFh3MmFwcFd6QmFXQnBPa3Y5NGlF?=
 =?utf-8?B?dTFxcjhCczdrK25HcDlhMXZyamZ1ZUJBVU9LNVJaOTE1L0YxR3ZDYWxGMVRk?=
 =?utf-8?B?cEluaVdnYXdFOThSN2lRc3hhNk1YZXJqdnVsN2N3RThCYW1Ic0dCeVd0NWpM?=
 =?utf-8?B?Z3NqWklzSXFYcXZVR1hNYmQzS0ltcktXN3RIM2FReWl4ZGE3ZWFQSDFDWVBw?=
 =?utf-8?B?NGhVZzdKN1RSU3FkSjdmQzlKQXFGbUNGWjdYdHFxdkhvQURuT3pWeFk1U0M4?=
 =?utf-8?B?N2pTUEZPL1VwN1FiQXl3Qm1GbUQySGNTaVJvSUdIbU15N1VEeTl0dWJsOTBj?=
 =?utf-8?B?cFVzVk9qWUw5RGlVbHhJd0QzTE1vVkE4K1llTnV5SXdHVkk4ZVRBc0pXdXBO?=
 =?utf-8?B?b0dRRE1nYkllelBaMW0yWmwyU0FTTTBtRlJTd3Z1ZHVqR0U3Rkx2L1lXQWND?=
 =?utf-8?B?Y1JOUnpkcmhhNkRqU1VGOHhMTEE5N3BCdlM5eWs3bVVqWmpFbUFhSXRSUWJn?=
 =?utf-8?B?MVFyeDRrREQ2Y1l1UFVHV1pDV0lDSkYzUnM1SGQ3TE8yWkI0cGlIQ25tVHUv?=
 =?utf-8?B?eFVrcnFpY2szT1htUzdYYWVNR2JZVGY2K3h5WEtQMWRCaExSb1F3cWFjRGpC?=
 =?utf-8?Q?/EE6hnZnTQDtUzLbw3OstnuZV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0E1BC505F368D4FB92446544019A952@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IYNiM1nyha+9mRqalu08PghG/XwO6gcCbLeVKDhUxM1CTb/6NZZdpHLFwDaP+x1Pamyk9cYhSMqvH6utmx8H5D8Z9JkbGsXsLkDqZ0by9qZJ94tafnViepMmbr1Aj9wDLMvj3zsB8JGIGgpKqYy8NnIOK90beD7jnuKOHDHIWtqPe3nNF/qzUyd2IhjDa0fr8jxmV46A01UX0E79OEec/t0SnhVuINWZigcCDyc/v34uAgl2ElPvFOLR44o2m0Xaa0iuGye7mMEgiL+8A6sqfHdNKPlH1WjI2vQwLEc2YdJFc7NiKv/RcdyMqXVgavIbneOgSV4UGHdiqQy3MyNykQ7iT/GchL1jnDngzKFCdKoQuEU+bX3gBk52Ezlo9mZ3XxpvUgJT2eYqhpBPNUoq1k1iv7b7Ewak0qHzvDiQnymDuWscC/fOWazJb4beEzGBf7U37VT+gl0SS4SaUdqnp62yPJjL8XXdpvbgRG6iPzxOFUQGY5XCWmN1RUpMfVBh2xWzYHVHSrntCmyGjSZWlsiULbUK3vzrNyPUiz/lkzsRTiMzJETjwUEj493SNP+0IxgzCXxllclX5BHNwbHOL3mzd2T0mldR6CK/+MqUH5UE3tctjE+9vxitFqya6bQ4se0oNd2NnHyVcXmegIvxhg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e118c-e8bc-4ce9-cdf9-08dc8fdea74a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 21:36:03.1391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pYdQhUXuT9TrWctvjWEdJRycY/SyYhjbqfZxGM05yD2LG+UiU7jm1no04ZTjaFdUvXotYDwx1S9wPdq1KdS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
X-Proofpoint-ORIG-GUID: GDjvtPoN859pnF_c_mnGWuUaiat4QUDW
X-Proofpoint-GUID: GDjvtPoN859pnF_c_mnGWuUaiat4QUDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=498 malwarescore=0 mlxscore=0
 spamscore=0 clxscore=1011 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180158

T24gVHVlLCBKdW4gMTgsIDIwMjQsIEp1bmcgRGFlaHdhbiB3cm90ZToNCj4gDQo+IEhpIFRoaW5o
LA0KPiANCj4gV2UgZmFjZWQgc2ltaWxhciBpc3N1ZSBvbiBEUkQgbW9kZSBvcGVyYXRpbmcgYXMg
ZGV2aWNlLg0KPiBDb3VsZCB5b3UgY2hlY2sgaXQgaW50ZXJuYWxseT8NCj4gQ2FzZTogMDE2MzUz
MDQNCj4gDQoNCkhpIEp1bmcsDQoNCkl0J3MgYSBzZXBhcmF0ZSBjYXNlLiBQbGVhc2UgY2hlY2sg
dGhyb3VnaCBvdXIgc3VwcG9ydCBjaGFubmVsIHRvIGF2b2lkDQphbnkgbWlzY29tbXVuaWNhdGlv
bi9kaXNjb25uZWN0Lg0KDQpUaGFua3MsDQpUaGluaA==


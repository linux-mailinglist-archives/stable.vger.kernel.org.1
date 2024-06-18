Return-Path: <stable+bounces-52626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4564C90C00C
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 02:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D51C21E4B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067CA2D;
	Tue, 18 Jun 2024 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="g4lZnK1R";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RZKU1qtG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OS6+1+N2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AC2F52;
	Tue, 18 Jun 2024 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669120; cv=fail; b=X3H3901yAEdTawtfY7m6bx4YBouht/TrEl1sqIq4Gz3nV8wknSC1I5dcmoRDKI1noM2V01vjd5+AaNNeuC92sMQCP614X7yLVa7IY0Y5ABU6Hj/QSDf5XvrclVHjI6E79eDTdjb53xJQFEweJG2fMwTZ8m35Wr4dfF5DI1Nii04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669120; c=relaxed/simple;
	bh=rc/GNKxcR4yjURE3QYyFvvuOnFjMDTMFd1IMtRWlZI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KeT65dyMQkWbmYEvvqUEgu3ZB6yMp8I9xEhNc+AvRfiPlLZ3RP6A13kfndzNc+2IBOPSolRNjPaW9uvyIJ1paouRyTuJpWOAYDbt+1JTIE5Lv3tTRW+bwDPvHB9EE8Kd0ousG8RfwGNJ5nibRsOSbZUlwpYPaBnU1ivZhcOcM7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=g4lZnK1R; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RZKU1qtG; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OS6+1+N2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HHHXTr022241;
	Mon, 17 Jun 2024 17:05:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=rc/GNKxcR4yjURE3QYyFvvuOnFjMDTMFd1IMtRWlZI4=; b=
	g4lZnK1RoqTOUZrMHfh7rbi0An7EbvZiLy/NQPi+yBy0Q2ZzM702PV5RwudW4tSu
	L6dKKU2RFLkLJI/rjfxQgAjEFgDsfXFhUvApr98YyUexyMzbrAPN2ZlK9g8eWRow
	ZW5C61N7QwFbjcm4UA2arhH/fYkNQAJVDFpoetSDA9mXDz+bXHztvB4WZvWvK/KO
	AFFNPPb9IHE/9arQGzrqSmfVD+6Xbx2VEEAlmd/aw4VMNS/eZohnZ84zTBv6AwgC
	4Z7MZtPVMqUomNVAct+CUD6OA2fGyLCYc3/23BidR1/F4xl16lut7e74HToraLa7
	4D/pFZPiTXPIy3D/PGA9bQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ys9ykft8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718669110; bh=rc/GNKxcR4yjURE3QYyFvvuOnFjMDTMFd1IMtRWlZI4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RZKU1qtGGJbT5sBxO3KhVfZaQm3EUWyatrVHEjmk0/knzu2lvmjxS4gTxy295ktus
	 c0k+dl2bTDFIeklzDoQ/l33dl43UVbCk/QSCnTxrSIMexzt8JXjAwP+F582GvYo/XZ
	 GGaSICvn6G3RyDCdQZfTeTzQ/QllO7+gHt0qheboVXmvhDftKY8ORGtxNpqwwDK30q
	 UjAUzSrMjPuKGoPQLm5WzwlARrJn+paHT/OkFcOM3QkA/O6+tgO9NQcoAaoJjMW/LG
	 WW7a6zU4S8S7U0OsGjG+6hfuLeEz7Sm7sGevCKsBBmp/x+DsxaBezUmTiKr6YPXcSJ
	 DvU6Mo0ilBi0w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A4EA6401C6;
	Tue, 18 Jun 2024 00:05:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 50C23A0060;
	Tue, 18 Jun 2024 00:05:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OS6+1+N2;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A9A234048B;
	Tue, 18 Jun 2024 00:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDkMMepAnnCuQIq90il1O3mNf+zDz3KoGNqdCw/NhlWAwtqFsN/flpOUuOTisVRRCPFrhc0Mt92zFQRLmUmkH9Dog2PYy0WhGcDpRxICV3meNiP2kDEp+gagfSz9RkLrrJZnYZdfEmDxLdTXh0Ji+8vXUDbrIwfSZ78isKd/ml6sr3iJbKFH0otAD46xxz0Nl3vKGE8Y4JRphN9k5/XVH7fcNuN2pX2CiQGLH/ADjXMn6N6rzV2SfVM8Z6g2EF8rq5UTezQvHQnnLxqjYJghuoBiQyZL2cf7fci+vFG+fQsnPnA1vmS6NBTjldwpOHj/8qsOWyADNftLotWVsYpA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc/GNKxcR4yjURE3QYyFvvuOnFjMDTMFd1IMtRWlZI4=;
 b=hNg5CnVBKpJLXXsdmgd4XBPINzQ7CxUqbO1OqEKSBWG7aQEFw9grSU9t4npitzwa3oYKm1YVBo0awiYLCFmsX6YrCu20OhjQ/RldMeZB8AHMUO/Wv/vtzaxP3HknUX+wCj+ijQhbahSFaTQuE2TwojHnIFqbrUYI9bEN1bh1prC6ALAuX3KPIqooU+EWFHXsLHnV7j+eNfKlxZrt/CulOcvmK1ZUjhM2CCDXlOiUcFvaSvqA8dmcWDHyxDXUcY0s+bfDf45s1eIRebt4k+7XZHdVAmTdvoxQYx7R6q0kIeCb8ZUH/N+OGNCdtLjo04OPq3ii/AlI3UJIe6TuGaCLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc/GNKxcR4yjURE3QYyFvvuOnFjMDTMFd1IMtRWlZI4=;
 b=OS6+1+N26Wd2VMNcyN3xTw3H6lBdgiBysOy7Z440vsoLBoCr+GexvJaTwLfvhIAbgBTBdDa8nXD0VvlESnSNPIaiDNDO6wWGFdq9bCEVUegBoBV0FQq252ay6uu4oe7kwK25EtQts4LD5MliGQWRmyg23wdhORIqBOkV3eCNBGY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:05:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:05:05 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHavN68+4rS9XFwd06IBuRrKh805rHEW20AgAE5awCABxe/AA==
Date: Tue, 18 Jun 2024 00:05:05 +0000
Message-ID: <20240618000502.n3elxua2is3u7bq2@synopsys.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612153922.2531-1-joswang1221@gmail.com>
 <2024061203-good-sneeze-f118@gregkh>
 <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm0NWV_1sGNzpULAEH6qAzQgKT_xWz7oPaLrKeu49r2RzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB6750:EE_
x-ms-office365-filtering-correlation-id: dc713ef4-4e80-4c32-a078-08dc8f2a4f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y3p2dWxkdTkwWWZEYngvbGoxYU0wb0R4dkJjVlJ6aklWNVdxcEtYUDZxTlY4?=
 =?utf-8?B?QW5LUEptZmNDTWlhU3c0Y2c1NUt0R0JoZVI3SDlHZnhvOHdOeEFVQitjd2pr?=
 =?utf-8?B?a09hWWFsM3lZSjUyS3pGMlc2Q09xOFlWaDN2SEhKTVRCWjZReXlRSXI5TXRD?=
 =?utf-8?B?VE8zME5IS0JXVi9jTWdtdXJqaFUwMHZtdE0yNG1jdTBYdWt1TURtbXBBcThy?=
 =?utf-8?B?dzZOcnVWbDZzWXhnVDIxclpTemFUcUx5MTluZ29vd3JyOXNZQkticmwyVWE5?=
 =?utf-8?B?Njhnak1jL0VIc29iN0pBeWgrR2t6U0ZLZS9JbE9tQmlxMXdDQldIRk5reUhX?=
 =?utf-8?B?K1lSalpaZEdXWFJKMm4vaER1dE9QMEg0QWhnVEcrMG5nVnRmK2xTMnB2TDkx?=
 =?utf-8?B?RWJ2YU52QW9UZVVyS0dhSGVuTTQ2Um5yajhzUUhIV2J4eThLZmcxMTVQbE8x?=
 =?utf-8?B?dFV6M1dQbThUQi9oQW5GNEpxK3VVTm44aW90VlZDR1lqbE9FSkhKdldTSWQ2?=
 =?utf-8?B?a1NONUw1dWRxUUNNZSsvcks5dVpLMkVBT3BMcDBLMXVENmNqK1A5NG01dEI4?=
 =?utf-8?B?VzNNbkVrTTJJMFBOTGs0bmxtZis5QUNBM0JCb3c1THNpMTY5QUFGeUZLMlo4?=
 =?utf-8?B?OGNNaXd2a0JpRTFnemNFOGZBVisrSWNZT2UwcVp1MzFFaURGYUlMU1lBNUpl?=
 =?utf-8?B?Wlg0R1ZDV015R1RPK0w5bk5NL3FpajQyUmpVZ1grNmRZYmN6b3F2YTJoRVF0?=
 =?utf-8?B?MXk5R1pqcXg4WjhsbllrMm4vTFBmcFNreXNKOWg2Y2xpWnR1SlVDL3BlV2Ft?=
 =?utf-8?B?cFduSmhDc2pHSGVDSWVYMmhwcWhZZEFQMWxwUXlhZXExejFxeFpXNjRlbG1U?=
 =?utf-8?B?cW5IMzhTQWJuQ0plL0dZSXhaUlVkSktrQVF5SGlOY0VBd1ZqR2ZiSWNEamxG?=
 =?utf-8?B?YXhWQUNFTnVXU0R4bGZRZWhRdnhIN3EydEpFQ21JQU5QQndCai9HUnoxMTdU?=
 =?utf-8?B?NjNiSW5DUDNLS3JZRmRMendtTW9yTzg1eEhrVUIrQUNKOFhwaGM0cUo1VS9B?=
 =?utf-8?B?cHpVb2t6YWxyM2NOV3N1VzcyNVBBTmNHbWEwNTRxME02NmdzVnQ1SnF5OVFo?=
 =?utf-8?B?emp2WEdXRmR5eERkQ3JhQnFiZkVoR1ZIWE1Cc3dJMG1CRUtoSkZUdS9haThR?=
 =?utf-8?B?VnB6ejlIY25kbUc0b1k4MkhjRkdqK0tJQVhYNUttZ0RIRUs4NWtxWmtqbkdo?=
 =?utf-8?B?cGpmN3puV2hpT2FDRmtRZTQ1S1RWckNYaVNMb0NzMlhkVkJlOEd3M0NZNkRP?=
 =?utf-8?B?MXMwd29QSFErZ1g1WiszUHFybEJDOEFYamJyeUlkNGsvWjhzaE1Rb3doMGdI?=
 =?utf-8?B?RlJZQ0ZLcUZYaW9QTkxGU2NVTC9wWlNMUlQxMThZYW9GNDFPKy9RZXI3L052?=
 =?utf-8?B?MmovTThKSjRlQjJiaTgzRy9LTlAyVC83S1R2RVMyQ0hhZzhxdlUxSmtud2FL?=
 =?utf-8?B?LzlYL3hhRU5oUFpTOFJCVDVIbU10Ky83bzk3SDZyM2hBdDIzbTdaT3p3RWl4?=
 =?utf-8?B?aWxEVTllcDZpcGFzT2ZSemx0enM0MkNnYzZiWm1hdzZML0Y4RDJROVhaTWQ0?=
 =?utf-8?B?YXdtamZlSXMyK3lKSk1mY1Z2eVBDRnVGTkZzYyttbTRRSm16UXZVd1FibjFN?=
 =?utf-8?B?NFMyL3JoclZFK3N4ZDRHd1BnQ3lWL3EyUjNybTUyZE9rbUFTdzhXK0QwczlD?=
 =?utf-8?Q?ghLe06IZFHba4nf9XoC2zZcV6UB4k2El4XDESLE?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SVlPd2RENjRzbHNxRnV3VUlGKytNTXY4aEJUNWV6OFMxY0RBanFTWnlKNVFw?=
 =?utf-8?B?ZHdnc3NMZ1VLeGNXN1FlNUlCOVphcHJkeHBZMnh4T3FwdU1SeDVTYTFrSk1Z?=
 =?utf-8?B?MG4xcWJ0ZFpLQnpBMDdwTFFDK05GaDI4WVFvclUwUHA2WlFVK0RvbjlkUFZm?=
 =?utf-8?B?YkhYQ3lub1dNb1QwejZJb0xCaGFWcUE1bk4xcmtpNmhrLzVmTmFmQVpJZHFH?=
 =?utf-8?B?R2hPZThCclVkcC9iZTJtOGY2UWlVQTJHQzdsdGJtN2RYZS9kdXRBaGVPMnFi?=
 =?utf-8?B?M0U1aS9BM3dyeUtwdmZxUlhKS04rMXVBVmswUVlCSkk5UWMzLzd6SUhCL1Vv?=
 =?utf-8?B?YjhRdklwN3MwSHNQZ0FZT0laSXJIMjlrWGtMM214OHZmeFczdi8xamJkRzgr?=
 =?utf-8?B?L0lETThBUG1YdG5veWZWVS96Y0t3TTEybkZ0U1psWWI1bTZCTDRQWW5SU2lF?=
 =?utf-8?B?UjIvZXVtWlM2ZDJibi9aQk11U1lHNkg3S003K0hWUWZibU4xa0RUa21FenRV?=
 =?utf-8?B?S1JJbC8vVXJMdXViR1VyMjdCTXcvVlBySXYwamw1RHhNRFl5NHNscTd6VW5G?=
 =?utf-8?B?alpIZnV5bzFlUHNTRzZ1dDE5QUtYeGc0NVY3bUtrSUZKNWVkdlRoY3F2Rld0?=
 =?utf-8?B?ZWd0emZPSE1TNlduY09zNmx5L1RyRWhlcWxFUENwRjJ4dDNtNUI1YUM1Q0FU?=
 =?utf-8?B?VzJsZ2pNOGU3WlZXMXM2RDFQTGdYTFZOenBEYXlTVGU2aTQvYVQ5L3BtSmsw?=
 =?utf-8?B?bmJBcFVEQXczcW9oSTJBZDdwOUF1M0tRUzBIWGJqMWppV0FsMVd2disvU0Nx?=
 =?utf-8?B?QjhKd1RjbUw0eHd5OHV5Q0lOYTdXaEdsMFFkeEx2N3RSdFB2TUd3a3AwR2Rl?=
 =?utf-8?B?S1FrVjNKL0J4bnZMOTM0MiszVTlHdVJFRndEOE1hSm44ZzNBSlA2RHNVUks5?=
 =?utf-8?B?STZnTHFRZEJFTHRwYmdWV3NYVjMxOUtuNlhaNkpFNkdKZmlzVTYrOC9iWGlW?=
 =?utf-8?B?c2hIdkNHOU1ucUpCYjdIUVNGZjBuaE5PbU5rZVZVR1FDK3VraDFUZGNVSlpD?=
 =?utf-8?B?SEUrUEJVQ1BVcWYvdUc1QWluOVh2VmRENm56K0VtNlpYUEIrTE1uK0tmVTJn?=
 =?utf-8?B?elpqLzZMNnpNYkJwZm0rK1NKa09wOXdkS09kY0t6L2hOem5JSHJ1UEtIaEY5?=
 =?utf-8?B?Z2JvK1NHbzRZZ3N6a3VHeXBLWk5QbU84ejVUMER2Vk1hUFNVUWc0enB1UktB?=
 =?utf-8?B?MFJqQy9LWS9mTnRka1dFdkxZeThHL05xRURCSmk5TFNPTmVpNS8yR083MFVw?=
 =?utf-8?B?YXhrd2VGVUM3cmdnWDA3aEppeHJ6YXpkQmJNNEdZek9MSVliNHA4UGpFd1or?=
 =?utf-8?B?UkJqdEhhOGJybkJXY2J2YzRXeVBCQ0ZyUlNrVmNFM2tsU2J2M3NTTE9nZXJQ?=
 =?utf-8?B?N2lEYk9nUmhkY0FuaWh4MnNLNzhHbkVoWUw3R0o0eWVnUUNickpUbjFWSWRM?=
 =?utf-8?B?UzFSYTU4U3BLa3ZZMEJzYXZFcVdaTWN4dEhMbW1SaG13eEhyanVZenRiQ3gv?=
 =?utf-8?B?TU9sZEVKaS9wWm9SRnNrbUlPdk0yUE4wV0wzNHVkdFlKWkFJdFpUdkwzM2Vq?=
 =?utf-8?B?K3VwSldwbFVRZUJTcUZoOU92VGR2aGJiTUxzUVlmYzJ2ZkVGRUZDYVZhRTV1?=
 =?utf-8?B?TmlmRkljL0lGeGF4ZnhaaHIyRzVwYlAvUGhCc2FRdUpJQVRqUVlkYVkvZDlR?=
 =?utf-8?B?UUtYOEgyZjlwdXRpMlF5bE1nZElZYXdkaFk3Q1JXNXovUUZrWUZRRmhwWE9t?=
 =?utf-8?B?V2cvR3VJeGo5dkFaUTBTWU0xNVIzNGRQVnFXRmoyRU53VEhETXhBaTNaTGQz?=
 =?utf-8?B?a1I0N25rT0cvNmZHK0ZsWFMxSkh0N0l3dkx6RmdxSGVKa3dzZWgyOHhEc2Uz?=
 =?utf-8?B?OUlNRkpsNWlGS25ubjNUc0hIT3RaYjl0UGtJTE5QVFlwN1o5bUl6MmIrcVVZ?=
 =?utf-8?B?cVgwdFBpcHVVd0Q4VlN5Sy9iNFhBSWlaSSs4K2UxMzRqa2Fxa3d3a1RCaitB?=
 =?utf-8?B?aiszS3ZSbk9iWG81NjBmOXFHNE8yK2FDK01sd01vbGNPT0dWQlhha0NvMGU2?=
 =?utf-8?Q?FhTNPkFtUjXg/6F7syXBF88fJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0065E48C9A3629498CB0CE614625E989@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rhpR9jXA1ulWxB/TD4sdk1Wheb9LH5hQi0cf5WA90PqFznrrYQl58G/GWMxLv79ocMtg+UGEmDl6VMhCl5zvgaQenHXnr7mf8c5KfPcewHtKN6VDNFup4lA5bh63+l0xrfqHj0Zmt0ECIg+U1OJ9+OrZ7slG+9yz5YmEKyYZXvmNlTeVTLrhjhbbadcSs/c1a6LwnxKwxUsROULo91sYqqnRh0EZEjnh2tYNlKtrzQ6FF531wuDFyj1c1fOAnVuTFzzdSxN2u/H263555sXqSg9s8gUQcX0Pk7LZXO9GgHk7eLBppOIduAIGHWcgZgoUn9CDnbpNV4rgGY0/ZJTpJwG/pJalDq/G3BvaVroxugbpt76us1R8lLsC/qbgta5C3chQy7braKNOJJvVLDGP6oSk0NkwUeuxkkG9Zaep40X3jiMyiS4VXw9tdBiKv8VTDCdLO+2pftniip2+DbJn3qXkbK4vo73q6YinE9YZii7Z3JQFTo6h8RWBx9iWHGbwubqMnIOH7teqDQEnqL8dmIyJfGHly+Tf78GBUjjm4EzQC557z5SZFjFms5kUWmA423hGdbXS779LYz2c9IC8JC5oCrVgQ3wRCwDwHYJtCriwYB6u0b1VNRXxnvSdm1OsbnKjwrAnSzELx1bU/W3lWw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc713ef4-4e80-4c32-a078-08dc8f2a4f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 00:05:05.9045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUn5V2prNrNbFw4Asi5soyO+jP9+owQN2h6fzDbwSVWKRjEhCdq1Gw4nP7vcAyRR3kHCF7Rejoywh3/Z+YjEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
X-Proofpoint-ORIG-GUID: rAxdHPytflyjtC7965vC3r1o0WDiReYm
X-Proofpoint-GUID: rAxdHPytflyjtC7965vC3r1o0WDiReYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170185

T24gVGh1LCBKdW4gMTMsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9uIFRodSwgSnVuIDEzLCAy
MDI0IGF0IDE6MDTigK9BTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3Jv
dGU6DQo+ID4NCj4gPiBPbiBXZWQsIEp1biAxMiwgMjAyNCBhdCAxMTozOToyMlBNICswODAwLCBq
b3N3YW5nIHdyb3RlOg0KPiA+ID4gRnJvbTogSm9zIFdhbmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4N
Cj4gPiA+DQo+ID4gPiBUaGlzIGlzIGEgd29ya2Fyb3VuZCBmb3IgU1RBUiA0ODQ2MTMyLCB3aGlj
aCBvbmx5IGFmZmVjdHMNCj4gPiA+IERXQ191c2IzMSB2ZXJzaW9uMi4wMGEgb3BlcmF0aW5nIGlu
IGhvc3QgbW9kZS4NCj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBhIHByb2JsZW0gaW4gRFdDX3VzYjMx
IHZlcnNpb24gMi4wMGEgb3BlcmF0aW5nDQo+ID4gPiBpbiBob3N0IG1vZGUgdGhhdCB3b3VsZCBj
YXVzZSBhIENTUiByZWFkIHRpbWVvdXQgV2hlbiBDU1INCj4gPiA+IHJlYWQgY29pbmNpZGVzIHdp
dGggUkFNIENsb2NrIEdhdGluZyBFbnRyeS4gQnkgZGlzYWJsZQ0KPiA+ID4gQ2xvY2sgR2F0aW5n
LCBzYWNyaWZpY2luZyBwb3dlciBjb25zdW1wdGlvbiBmb3Igbm9ybWFsDQo+ID4gPiBvcGVyYXRp
b24uDQo+ID4gPg0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvcyBXYW5nIDxqb3N3YW5nQGxlbm92by5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
IHYxIC0+IHYyOg0KPiA+ID4gLSBhZGQgImR0LWJpbmRpbmdzOiB1c2I6IGR3YzM6IEFkZCBzbnBz
LHAycDN0cmFub2sgcXVpcmsiIHBhdGNoLA0KPiA+ID4gICB0aGlzIHBhdGNoIGRvZXMgbm90IG1h
a2UgYW55IGNoYW5nZXMNCj4gPiA+IHYyIC0+IHYzOg0KPiA+ID4gLSBjb2RlIHJlZmFjdG9yDQo+
ID4gPiAtIG1vZGlmeSBjb21tZW50LCBhZGQgU1RBUiBudW1iZXIsIHdvcmthcm91bmQgYXBwbGll
ZCBpbiBob3N0IG1vZGUNCj4gPiA+IC0gbW9kaWZ5IGNvbW1pdCBtZXNzYWdlLCBhZGQgU1RBUiBu
dW1iZXIsIHdvcmthcm91bmQgYXBwbGllZCBpbiBob3N0IG1vZGUNCj4gPiA+IC0gbW9kaWZ5IEF1
dGhvciBKb3MgV2FuZw0KPiA+ID4gdjMgLT4gdjQ6DQo+ID4gPiAtIG1vZGlmeSBjb21taXQgbWVz
c2FnZSwgYWRkIENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4NCj4gPiBUaGlzIHRocmVh
ZCBpcyBjcmF6eSwgbG9vayBhdDoNCj4gPiAgICAgICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA2MTIxNTM5MjIuMjUzMS0xLWpv
c3dhbmcxMjIxQGdtYWlsLmNvbS9fXzshIUE0RjJSOUdfcGchYTI5VjlOc0dfck1LUG51Yi1KdEll
NUlfbEFvSm16SzhkZ28zVUstcURfeHBUX1RPZ3lQYjZMa0VNa0lzaWpzREtJZ2R4Ql9RVkxXX013
dGRRTG55dk91ak9BJCANCj4gPiBmb3IgaG93IGl0IGxvb2tzLiAgSG93IGRvIEkgcGljayBvdXQg
dGhlIHByb3BlciBwYXRjaGVzIHRvIHJldmlldy9hcHBseQ0KPiA+IHRoZXJlIGF0IGFsbD8gIFdo
YXQgd291bGQgeW91IGRvIGlmIHlvdSB3ZXJlIGluIG15IHBvc2l0aW9uIGV4Y2VwdCBqdXN0DQo+
ID4gZGVsZXRlIHRoZSB3aG9sZSB0aGluZz8NCj4gPg0KPiA+IEp1c3QgcHJvcGVybHkgc3VibWl0
IG5ldyB2ZXJzaW9ucyBvZiBwYXRjaGVzIChoaW50LCB3aXRob3V0IHRoZSAnLCcpLCBhcw0KPiA+
IHRoZSBkb2N1bWVudGF0aW9uIGZpbGUgc2F5cyB0bywgYXMgbmV3IHRocmVhZHMgZWFjaCB0aW1l
LCB3aXRoIGFsbA0KPiA+IGNvbW1pdHMsIGFuZCBhbGwgc2hvdWxkIGJlIGZpbmUuDQo+ID4NCj4g
PiBXZSBldmVuIGhhdmUgdG9vbHMgdGhhdCBjYW4gZG8gdGhpcyBmb3IgeW91IHNlbWktYXV0b21h
dGljYWxseSwgd2h5IG5vdA0KPiA+IHVzZSB0aGVtPw0KPiA+DQo+ID4gdGhhbmtzLA0KPiA+DQo+
ID4gZ3JlZyBrLWgNCj4gDQo+IFdlIGFwb2xvZ2l6ZSBmb3IgYW55IGluY29udmVuaWVuY2UgdGhp
cyBtYXkgY2F1c2UuDQo+IFRoZSBmb2xsb3dpbmcgaW5jb3JyZWN0IG9wZXJhdGlvbiBjYXVzZWQg
dGhlIHByb2JsZW0geW91IG1lbnRpb25lZDoNCj4gZ2l0IHNlbmQtZW1haWwgLS1pbi1yZXBseS10
byBjb21tYW5kIHNlbmRzIHRoZSBuZXcgdmVyc2lvbiBwYXRjaA0KPiBnaXQgZm9ybWF0LXBhdGNo
IC0tc3ViamVjdC1wcmVmaXg9J1BBVENIIHYzDQo+IA0KPiBTaG91bGQgSSByZXNlbmQgdGhlIHY1
IHBhdGNoIG5vdz8NCg0KUGxlYXNlIHNlbmQgdGhpcyBhcyBhIHN0YW5kLWFsb25lIHBhdGNoIG91
dHNpZGUgb2YgdGhlIHNlcmllcyBhcyB2NS4gKGllLg0KcmVtb3ZlIHRoZSAiMy8zIikuIEkgc3Rp
bGwgbmVlZCB0byByZXZpZXcgdGhlIG90aGVyIGlzc3VlIG9mIHRoZSBzZXJpZXMuDQoNClRoYW5r
cywNClRoaW5o


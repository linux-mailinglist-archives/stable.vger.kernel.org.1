Return-Path: <stable+bounces-71357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E2961BC3
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776001F23F79
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726647F5F;
	Wed, 28 Aug 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HMZkfsgZ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G/2PBwq1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QhqvtUoI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C41B960;
	Wed, 28 Aug 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810651; cv=fail; b=od2L/Dx+edL1JQrp73j6OeLD9UEwTQZU67KFyJAsYbPMXXzhKIRtCV1va/6nCLB/UDtJdyZ4qdHDPjBiotXTI169HT59xHAQ/m/dPwm+OhdJ3ody16wvT245P99EaP5Iu7NNG3Gzcxktw29eI/Xarw0tWMz7SCb3Rbk3zCS6zYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810651; c=relaxed/simple;
	bh=PyUs5/x4FJZa8DYMnCpHDoVQVTT5wvviF9IhlrH6r6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JEh/aeIh0Sh2S/4MLetUFBIdCpxRgzLawfrD92A6FBCCMbbqMigJypchWf/OG+eKyGnfZguNU5AmEqQfu6Qva1zZLWEBISBjKOHoi2/qgq8nNklJif0snPvtH0+Smkw3nag3xWaqk8DM+SPVX/g9p5KnsTf3zbO/RZqJPzKlmqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HMZkfsgZ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=G/2PBwq1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QhqvtUoI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLhJwV024171;
	Tue, 27 Aug 2024 19:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=PyUs5/x4FJZa8DYMnCpHDoVQVTT5wvviF9IhlrH6r6U=; b=
	HMZkfsgZShRR4vh2SycnhieE1/X0voM/0tPYM1vfw4qyyGDwjIhL0nh/Eb5f4IAG
	wsxmbJElqZAj9QN42VR/yduBQgrjbnKoneSVJvaA9H8gPdCDzmqFWoGAQa7+yet6
	wlFrhTKsxExEdTSX38v8eQyB61fwu4uMd4TQS/cFpO1/wN0TIgoTZSRaHsTmefUq
	J2BbUnt2E2CZ0uh/yKUlZdRC4FrIvzy92Qt/07uHuvRANo5b679pUADXTO9dEcHK
	a7PmgDIdMsdmKghYoB8DqQL2LTA6TJp/9ZLmW1zaXlTuN0bDun4gRw0jdYovNrDd
	Lnx2lOCGKJn/CAdYKMDMHg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 419py4gwbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 19:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724810638; bh=PyUs5/x4FJZa8DYMnCpHDoVQVTT5wvviF9IhlrH6r6U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=G/2PBwq1aURL5pN9t5c1pltF4nFoa3ETMT6KxMs11/vz0jqYl0CEJalDp3ghYm8Ht
	 8Q/yW1u5+WXoyADlMrPGqEpQGwtrR2CthBbcrwiLB5jGds5XQLdmJU3lu01kG/UwDp
	 AZxR44sS1cqjAGhVBnyfEZ/cIQBdR0S4glQwlBOCCzSe7Wu4mo+RR9sfH7Nx+RXRzK
	 06o5Eg1da/bgq9Jbtp/fNl0+C3fbMj/K1CnN0p50ITxR869fuBB2cNS9tHBMo0XFjs
	 dpXnFj8JbaqwKRmaaDFtsGsywV2pOkPfLaQhCOc9Ti10Vlap2A+f7zgl96LRtjf5KQ
	 io8+rRn0x0o4g==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2860640407;
	Wed, 28 Aug 2024 02:03:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B970BA005C;
	Wed, 28 Aug 2024 02:03:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=QhqvtUoI;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B40A640236;
	Wed, 28 Aug 2024 02:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv34KWFd/M4rMugpr9XeZE+WrE4kIN1rm5P3UeaxfYjABCfMOWErGNjVQzKTx9zHP9z9+hLuyAs4RiCOsW/tWlhjkp5yIZ13DGqPPjfbYr039UYuW2LKkKjheoPYxekGBSq/kmEHcmr401HsxApsD4CLcq2jmJ9FKc7qOpKHb0oTab2QYu7d/eLUlLJGdWU6F5j+eOyaayY6Lb0LeYb9RfOdC5j2J48d2jFOjS5ET5vfhGbKY/0U1V1Efk/nawHwhkdXNHYejVsCSwjxdm+Nmoz4lc8Cc3roVcdiJ/KgWr8d4wmmVEKiqcWFcm1LLGy7Livo1ycsEZ+fMYrFsG6FVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyUs5/x4FJZa8DYMnCpHDoVQVTT5wvviF9IhlrH6r6U=;
 b=zPCik1JLIw5FvgPeKxGcTDw2xFHUEi2dO43gLhrVNJkMfjskIGJmzE5iAesmWaHxVTc1KKvcDI3av047VLgvReDSO55r8h51p9psC4w5L9UT5WNeozV9wyUTg4ZRc/DNvOlMXHnxyoNcJwNPwH7ETv/0SCn16VpUTQwhDjqi+TtsPYBe2DVaP/iWAwi1sQdADLBpkdr6Bnk+ZEsiUS+gc52NleTNQ7zymWAQCcA9c6ZuguXz7rPo+pSJj3bzKUSMK+gwj4UoU0yhOnRd70SEvtOegSgWIDnNOMOcu6c3ZP33LGuKu28m3oeJ/VsXcZDbEB87Yor9DMJB66fO1v8LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyUs5/x4FJZa8DYMnCpHDoVQVTT5wvviF9IhlrH6r6U=;
 b=QhqvtUoIEcXxN2AN3ApXurWZG/3miD3kxoEHOWnH4XOexfXohOiz/eigwWnwxIQ8iOo5cc4zz4WSfkhI5Bbf44EfabplUtwQ4eZuyZzPBvJFsIWu9h5G7+l75PMetqxAHEE6BZKPhnYI8GfNGtXdmVdP1UreUWne48SISvX5cFU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 02:03:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 02:03:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Topic: [PATCH v4] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Index: AQHa+FM+TrXLNHix+0yyuLwzn2+9QLI77GMA
Date: Wed, 28 Aug 2024 02:03:53 +0000
Message-ID: <20240828020348.z6575s5yowcf5bdx@synopsys.com>
References: <20240827073150.3275944-1-quic_prashk@quicinc.com>
In-Reply-To: <20240827073150.3275944-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB8167:EE_
x-ms-office365-filtering-correlation-id: beef26c3-4b62-42a2-d3c2-08dcc705aaa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1VQTDhITytFZU5XQk16TThmUGFwZFhrSVlvL0FRYVdDMXJPaWxjWkpRQXlV?=
 =?utf-8?B?NHhMQmp2N1ZGRGZrT2k5ODNKYzlTd1JuQUVnS0czQ3J0ZlVIdndLRHNzcDVY?=
 =?utf-8?B?TGVzRThMV0ZSSklBOFA4MWZQNzRVY3RjNEl0RU1EOCtiTmhqWHNzeENZL3JS?=
 =?utf-8?B?Y1Fhd1Znd3RNTDAreS9EN0RMZENoMDVMVlEzRTlzTnFwRGFZOFJycm1mdkIx?=
 =?utf-8?B?cWY3RTk0TmlHb08wWDFKdktycmlaRlI5L2NjOG5DeGZ0aTVMRDExcFMyT3g4?=
 =?utf-8?B?dGtEOHRPUjhyNjNNOUIxa0VLYnVGMnRNa3VJNGU5aVk5STdaVEZsNG5EbFFt?=
 =?utf-8?B?WGRhbFpwaXgwR2pIMEpUL1V6dllhZHdzY1UwQ3B1OHFLUkFSSU5KMXBiZ1NT?=
 =?utf-8?B?L3A5RFhsbkw4bncwczJuT1ZyMzF2UWJUSWJCSkhMT3lVaktJRGxGaTBiVGlh?=
 =?utf-8?B?MTloM1BXMWc4aVNwRlh0MUpRVFluQ0lTTjYxem5mZGZYSVhoRSs0TXd6UkNh?=
 =?utf-8?B?aEF2TEFDQkR2em55SHhITTFYa2RYRjJMb0ZRYjZ3d3lPMVJZZXFwTDRqTGdt?=
 =?utf-8?B?NHRWRFRoTHZnNWpQWEVQUkpFb0M1ZGNmZWlrWUN0cHo4YU05VnhkZ2xuSzR6?=
 =?utf-8?B?cWtFY2hnMVVoeHBxT1JFTkljdVBvbGFEMlp2ZXB2K3VqZmZKNnZueWVMU0JG?=
 =?utf-8?B?ZmtGcU5Qc0dLOXg2cnJ0eGhjVlJnSFdEK2R3STg4cWd2Z1g4WGJxTGZyTWtF?=
 =?utf-8?B?UUhBOEtkZ0tpWkROUS9acGRZWTVMb0pCd2ppNmo2bzdod2tMdG1NWFhJaFJE?=
 =?utf-8?B?WmMwalpzMVJsY0VrSUFDZVNnRUwvOTZKSW52azROWFcvd3dZQnZWZkxMU0dt?=
 =?utf-8?B?MnpLVUZjR1hLL09XRTdBYmN3Q0JnK1dxTWpNS0Jnd1pQZXo5RkdzWDZoQVdP?=
 =?utf-8?B?T0dkNDcxZmE5RGtyNnRES1J2VG9nZzJ5TDd5eUMwYktqTG5zWU9LVi9SRGlO?=
 =?utf-8?B?eGhKbFlKUFUxS3RqNEw2NU11ZW02WmxCYU5VNW9TQzF4dXhnYnhkYkpnZkxu?=
 =?utf-8?B?dnBRTE9TdGRLbGx2a2ZJeGJIaFBtaVFUM1lnTTJSOGFXTzcyc0Iya2MvdEpv?=
 =?utf-8?B?V1FOa2UzOWpUWmIyczF5ZUhaSnIvRGVqU0h2VloxeWpqZEZmbmZ2R0hKNEtN?=
 =?utf-8?B?dkk3S0Fnc1k0NDV1QVZwcnpoQlpjZDVOL3BlR05aNjdmSlc4d2ZtV2RnYnVO?=
 =?utf-8?B?a2QxdXQvazRwdXovTTFZL3lqRFAvaktQcWJrUmdTZ0p3QmRXc2hRSmNQNW54?=
 =?utf-8?B?c2xSYkM5OHVTMUcwOGR6ajA2aWkvUTFJRndUWlV0azlmNnVnZWlNTGN5NXJX?=
 =?utf-8?B?Mm5JV1dlSWxpTnFFKzhJRXBSUDNab216UmhwMWpNMkkxNFZ0ZHU1UTgyd0lZ?=
 =?utf-8?B?MWl2VUpnMWw2d1d4L1NxbDNQWG04SFN6SWphams1RVE5L3djTmdsTGkxbVZu?=
 =?utf-8?B?K01nWlhiTitPMmNkMEZoYm9neUxNTk00VTRIVE43SGpoczNUZ25TbkgyUGlu?=
 =?utf-8?B?WUZJeTNQYWwwZFdoYjM4RDI1YlY3NVhRNGRsZzBLY1ZBZnhvWmdCcVVWZFBu?=
 =?utf-8?B?aHV2dUZZVmkvSGk4MVFsclBva2VPWjNhTWRsOTBvRUEzaHlvQVhJczJIaXlC?=
 =?utf-8?B?Rjh2RTlGTjV0ZGFnNTdYNmdRVFBXUm1ET09GcFVVRStVMzlaZE85L0NNcWIz?=
 =?utf-8?B?WFMzOGRnQ3J6QmliYW9ZV0poMlFKb3NKZnN2VWZ3M1YzMmJ3aTBjc1dTK3F1?=
 =?utf-8?B?VEF5SkczQzFNdjc0TWFVRnYyY1FjRm41eWhUKzlUc3ZtMWljUzQycFkvR2k2?=
 =?utf-8?B?Vno0WFJIYWJrRnNjNkdEcElVdE1yVjVIYjVqU3dJVmx2VGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVN6MjgzNEVUSGFrZjhxMytVTDVQWnhCRlBWUURzQ3o2a0lBYWpYeVhjZlNB?=
 =?utf-8?B?WjVyN21GUWpqMGcrakJYRlMxRjFVWTdkSENnamtyRHBMQkx2S2ZmVzhCQnFP?=
 =?utf-8?B?VjhDbmhubmNuNW12SkhETXpSRVdlYjBYcVhZV0RVR3RHeFJWVGQ3Mjk2bUgy?=
 =?utf-8?B?ZXpQTW5laVh1Q3I4cXBseitBZ1l5MjVRa1I3SEdmTHJaZWYvZkJUR0Z6TEVD?=
 =?utf-8?B?TlZQWnNGYmIra09qNXROam5aaHJYbTRheUNqbFpQTUxJRVBmK3hmdU4zNDlM?=
 =?utf-8?B?eXdpNlVNa2dYUXZldjBiaGl3NXREQTlKMGJrc1czVlZSTzFwMUVLUUtQNWhO?=
 =?utf-8?B?SHhRV3RTQ0VVM1FUbElzaEsvOGkvdTlUMHk5SUdJWkd2NWZxUE1IQ2x2dWln?=
 =?utf-8?B?V1JPbHlaSlhFOTdkaUtmdHkxMERMOWlXdCttU2JHUURWNzV6RGZ1WFF5dmtj?=
 =?utf-8?B?Y2NRenN4VGJ4SEIvc00xa0Zrd0Q5Z3FPTEhWNG13cUdUcEFPQVFxV3RTZUhD?=
 =?utf-8?B?bzhNNG9jcFpPVmQ0NkYvOXhvSDJQV3lhTjhZYmFMdmNtd0pVTnN6THRjaC9a?=
 =?utf-8?B?MVNuOXdtQ2d1TnIyUUxZZVhKVXUyV2U2aHlmb29zckZobnM5VFo3aEpHNDdn?=
 =?utf-8?B?TlpJTHBTektuYjR4ajcyWWZVUGxudWk4RGpUM0hKbDNZbEVsS09wVmNSZWts?=
 =?utf-8?B?M3c1YnhjTmdkUy9OcmFnMUV3dEFVMXBPeVlxVWFXOFFMejBuelovUUZWODh0?=
 =?utf-8?B?djF2ckRZaVprU1lpSUw2bE1pK0UvNWRNTzJlYUsrbGRCV1JCNlQzUEtiRVdx?=
 =?utf-8?B?WkZhWXBKSEF3TG5Ka1pabk1ZTjRpT21YR0hueGpPeTZDcmxXR3h0a1hVKzA1?=
 =?utf-8?B?amx5K0t3ZWJsUGE1dVZhbGxjWGgwTWo1em9peXZnZjJXWjRjblMvVk0vWWxL?=
 =?utf-8?B?MDNhdE5leXN0aHdERjh2Wkp1cE9qeTNsNDFUL0Z0THJRUG1rVGIwNm5wS3li?=
 =?utf-8?B?Zm5sVHlMT25iWnJNays3WDM4Mk14MkhxNmMrSE1WRXlaQndlRWJIN1Q1MWZN?=
 =?utf-8?B?dUsvRTlvWVQ5Z3VFZkdHZW1tWTZKRStrOERuUlRMMDdXZmZINXBTckFtLzM0?=
 =?utf-8?B?WUVHK1liTzBRb2JjWktpVTM1a096OUd0b0p6TFNzSmVaa0U0eDJKdWhVVDJQ?=
 =?utf-8?B?VEFpZTJObDZFWnQ5V05Fd3gxUnZxRDdDOUJCWXZ0N0FJT1FwZmU4Z1BQcjYx?=
 =?utf-8?B?Z3p5T3Z4RnNncUkvemlKM2s1ODhOR2UvN0o5YkNmM0FGZDFPTXpuajdQNFVD?=
 =?utf-8?B?dzhPTzdtQk5oVXBDVlhrZFlWUW9ETVljQktWS0F2YlQwVGpoMm0zd3BPUGRi?=
 =?utf-8?B?ckMvYnYzWnRtVG9FMThKemJVRnhLWUUvdTdnV2crUFc0VGU2U3owaVk3Q05h?=
 =?utf-8?B?YTVDMmJHbUs0L2IwbU1ybzFGWURtZHdlSk9JdFlDYXhWYmRvakltZDNhT2la?=
 =?utf-8?B?RGUrTE5TNjlla1FVRWMxeEtkZnUrZ1JMRkpTY3Z5Tmg5SXpERjU5U042OUhQ?=
 =?utf-8?B?WFR5ZXNMSEMvMGJQUmwzRDFTT3dlWTA0TWJQU3BCVlRwRHFwNEVGTnlld2Fm?=
 =?utf-8?B?NDIrajdFOG5aTGhKWnZXODhaNHNHbE4wYjFtbHNMQzc4SjlLSm5kTEZkQzV0?=
 =?utf-8?B?MWlvUkZGVlZpalNlUm9WZmhwdTBaQm5TK1dUM3drb0d1WVVQVzVDQ29ZOE5T?=
 =?utf-8?B?R0pRSGxpQUloaUFvdklKSmF4Y1V5M2o3ajNrSHMxemRTYjNsVWk4S3Btc1FG?=
 =?utf-8?B?N1ZkZ3NyTzliS29WMDJNWWdzSEcwcmFXL1IwWEgrTzNlalNPWmNHOFF0ZGxi?=
 =?utf-8?B?b1RCMXNiTGRWV2ZmYU5zd3k1QVBSOVJiaEhYRG04RE9RT3FKVFdTYU1LWmhG?=
 =?utf-8?B?TCtzakR0Z2h2YnN2blNiS2E0ak02V3dVdnZxdDBrTDduOFZRMG85blRKQTNx?=
 =?utf-8?B?TjV2eDcrNnRVRnA0RTRTeWdPYUZDUmxON2Rmc0gzR3ArdHNPN3ozazMzY0t1?=
 =?utf-8?B?OGVXN2JIcHNkMmI3Njkzd0VjNWZpUWpxc1k5bDVycXY4SGdpUG9MZUhPQ2Yv?=
 =?utf-8?B?Vzl0Nk5UQUd1cFhLY3BQaks5RVlqV2FOeDFyUXhRem1FM2k4RmxNMEpZKzUy?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <117F0D1621422B43AE0168B3BCC9CC93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7K88SmZZYmoK9PrK2cXypcUjvBSmHGByfdrDSd5YKFyApK2ww4wcwFsZotXZvnBl7V68G/ZRSTpioOzejqjTw9sOAmRi3x4SzLwMbEiW6mtfDpbrj7RfYTlGsff+t7r5gtq5DOU/tO/tIk2OEX7SF/Ir4ySuHSAKvJtikCUubt43rTROsBE0lGN4xFOZOrqGpzezeKWUTc8BAV/MTT4ogqtEwGcvVApLkO0jrDzmC7sS8kfkrleYhZvWPICaW8FYPPhuOZmIcgpuTnXVmSO6Dd5sku/x61HAknXAeL87SvRLEhhv68PKYKDYQLb1iUPUsr3GGq+NYyblYHCCNGGPrkfXN2ipc3PehiXRk3dV2YMoqrbdHxAGpGvNNGaGoAc4cdrtDaJOGHMScSWzKozQExdrjiorPfXWOg12Ax7E8ycpZtQb2CkDuLQAEuC9qrjZqLFXNtPzeVJr8tzGu6iW9Uzo84zhf1FHof+ZVI5FbiX9lAbJZnsX12p1KqpMud+Gqy8Tcej9sEtCN/yoVfrtwwECBt8kJ8MsGUxtEgveuRmFcJrBBbqpezT1r8uO1shV1/Gc0ABdSY1DnVj1yi6ymM5uHo2GQcqKpRiHNB2WYot9hGtjLqySt9z51N3K0iHj7kXnC7aQhO6H8QTfboZBBw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beef26c3-4b62-42a2-d3c2-08dcc705aaa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 02:03:53.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psmVQbAbBVx/4FU+ziHb6XmuzbCibWggZM3YYorQc0T4qNR9l1ycDtnqZ9D/qEdEkYt3svT+inURvQfYMp3MQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
X-Proofpoint-ORIG-GUID: FXAPf5y5M_kBMFU-H014544_ox1n4hB8
X-Authority-Analysis: v=2.4 cv=d+2nygjE c=1 sm=1 tr=0 ts=66ce858f cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=COk6AnOGAAAA:8 a=u7KoiSVHHGN3NFrnuZoA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Lf5xNeLK5dgiOs8hzIjU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FXAPf5y5M_kBMFU-H014544_ox1n4hB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_01,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=854
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280013

T24gVHVlLCBBdWcgMjcsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBXaGVuIG9wZXJhdGlu
ZyBpbiBIaWdoLVNwZWVkLCBpdCBpcyBvYnNlcnZlZCB0aGF0IERTVFNbVVNCTE5LU1RdIGRvZXNu
J3QNCj4gdXBkYXRlIGxpbmsgc3RhdGUgaW1tZWRpYXRlbHkgYWZ0ZXIgcmVjZWl2aW5nIHRoZSB3
YWtldXAgaW50ZXJydXB0LiBTaW5jZQ0KPiB3YWtldXAgZXZlbnQgaGFuZGxlciBjYWxscyB0aGUg
cmVzdW1lIGNhbGxiYWNrcywgdGhlcmUgaXMgYSBjaGFuY2UgdGhhdA0KPiBmdW5jdGlvbiBkcml2
ZXJzIGNhbiBwZXJmb3JtIGFuIGVwIHF1ZXVlLCB3aGljaCBpbiB0dXJuIHRyaWVzIHRvIHBlcmZv
cm0NCj4gcmVtb3RlIHdha2V1cCBmcm9tIHNlbmRfZ2FkZ2V0X2VwX2NtZChTVEFSVFhGRVIpLiBU
aGlzIGhhcHBlbnMgYmVjYXVzZQ0KPiBEU1RTW1syMToxOF0gd2Fzbid0IHVwZGF0ZWQgdG8gVTAg
eWV0LCBpdCdzIG9ic2VydmVkIHRoYXQgdGhlIGxhdGVuY3kgb2YNCj4gRFNUUyBjYW4gYmUgaW4g
b3JkZXIgb2YgbWlsbGktc2Vjb25kcy4gSGVuY2UgYXZvaWQgY2FsbGluZyBnYWRnZXRfd2FrZXVw
DQo+IGR1cmluZyBzdGFydHhmZXIgdG8gcHJldmVudCB1bm5lY2Vzc2FyaWx5IGlzc3VpbmcgcmVt
b3RlIHdha2V1cCB0byBob3N0Lg0KPiANCj4gRml4ZXM6IGMzNmQ4ZTk0N2E1NiAoInVzYjogZHdj
MzogZ2FkZ2V0OiBwdXQgbGluayB0byBVMCBiZWZvcmUgU3RhcnQgVHJhbnNmZXIiKQ0KPiBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiB2NDogUmV3b3JkaW5nIHRoZSBjb21t
ZW50IGluIGZ1bmN0aW9uIGRlZmluaXRpb24uDQo+IHYzOiBBZGRlZCBub3RlcyBvbiB0b3AgdGhl
IGZ1bmN0aW9uIGRlZmluaXRpb24uDQo+IHYyOiBSZWZhY3RvcmVkIHRoZSBwYXRjaCBhcyBzdWdn
ZXN0ZWQgaW4gdjEgZGlzY3Vzc2lvbi4NCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgMzggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiBpbmRleCA4OWZjNjkwZmRmMzQuLmVhNTgzZDI0YWEzNyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+IEBAIC0yODcsNiArMjg3LDIwIEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAo
c3RydWN0IGR3YzMgKmR3YywgYm9vbCBhc3luYyk7DQo+ICAgKg0KPiAgICogQ2FsbGVyIHNob3Vs
ZCBoYW5kbGUgbG9ja2luZy4gVGhpcyBmdW5jdGlvbiB3aWxsIGlzc3VlIEBjbWQgd2l0aCBnaXZl
bg0KPiAgICogQHBhcmFtcyB0byBAZGVwIGFuZCB3YWl0IGZvciBpdHMgY29tcGxldGlvbi4NCj4g
KyAqDQo+ICsgKiBBY2NvcmRpbmcgdG8gZGF0YWJvb2ssIHdoaWxlIGlzc3VpbmcgU3RhcnRYZmVy
IGNvbW1hbmQgaWYgdGhlIGxpbmsgaXMgaW4gTDEvTDIvVTMsDQo+ICsgKiB0aGVuIHRoZSBjb21t
YW5kIG1heSBub3QgY29tcGxldGUgYW5kIHRpbWVvdXQsIGhlbmNlIHNvZnR3YXJlIG11c3QgYnJp
bmcgdGhlIGxpbmsNCj4gKyAqIGJhY2sgdG8gT04gc3RhdGUgYnkgcGVyZm9ybWluZyByZW1vdGUg
d2FrZXVwLiBIb3dldmVyLCBzaW5jZSBpc3N1aW5nIGEgY29tbWFuZCBpbg0KPiArICogVVNCMiBz
cGVlZHMgcmVxdWlyZXMgdGhlIGNsZWFyaW5nIG9mIEdVU0IyUEhZQ0ZHLlNVU1BFTkRVU0IyLCB3
aGljaCB0dXJucyBvbiB0aGUNCj4gKyAqIHNpZ25hbCByZXF1aXJlZCB0byBjb21wbGV0ZSB0aGUg
Z2l2ZW4gY29tbWFuZCAodXN1YWxseSB3aXRoaW4gNTB1cykuIFRoaXMgc2hvdWxkDQo+ICsgKiBo
YXBwZW4gd2l0aGluIHRoZSBjb21tYW5kIHRpbWVvdXQgc2V0IGJ5IGRyaXZlci4gSGVuY2Ugd2Ug
ZG9uJ3QgZXhwZWN0IHRvIHRyaWdnZXINCj4gKyAqIGEgcmVtb3RlIHdha2V1cCBmcm9tIGhlcmU7
IGluc3RlYWQgaXQgc2hvdWxkIGJlIGRvbmUgYnkgd2FrZXVwIG9wcy4NCg0KPiArICogU3BlY2lh
bCBub3RlOiBJZiB3YWtldXAgb3BzIGlzIHRyaWdnZXJlZCBmb3IgcmVtb3RlIHdha2V1cCwgY2Fy
ZSBzaG91bGQgYmUgdGFrZW4NCj4gKyAqIGlmIFN0YXJ0WGZlciBjb21tYW5kIG5lZWRzIHRvIGJl
IHNlbnQgc29vbiBhZnRlci4gVGhlIHdha2V1cCBvcHMgaXMgYXN5bmNocm9ub3VzDQo+ICsgKiBh
bmQgdGhlIGxpbmsgc3RhdGUgbWF5IG5vdCB0cmFuc2l0aW9uIHRvIE9OIHN0YXRlIHlldC4gQW5k
IGFmdGVyIHJlY2VpdmluZyB3YWtldXANCj4gKyAqIGV2ZW50LCBkZXZpY2Ugd291bGQgbm8gbG9u
Z2VyIGJlIGluIFUzLCBhbmQgYW55IGxpbmsgdHJhbnNpdGlvbiBhZnRlcndhcmRzIG5lZWRzDQo+
ICsgKiB0byBiZSBhZHJlc3NlZCB3aXRoIHdha2V1cCBvcHMuDQo+ICAgKi8NCg0KUGxlYXNlIHJl
d29yZCBhcyBiZWxvdzoNCg0KQWNjb3JkaW5nIHRvIHRoZSBwcm9ncmFtbWluZyBndWlkZSwgaWYg
dGhlIGxpbmsgc3RhdGUgaXMgaW4gTDEvTDIvVTMsDQp0aGVuIHNlbmRpbmcgdGhlIFN0YXJ0IFRy
YW5zZmVyIGNvbW1hbmQgbWF5IG5vdCBjb21wbGV0ZS4gVGhlDQpwcm9ncmFtbWluZyBndWlkZSBz
dWdnZXN0ZWQgdG8gYnJpbmcgdGhlIGxpbmsgc3RhdGUgYmFjayB0byBPTi9VMCBieQ0KcGVyZm9y
bWluZyByZW1vdGUgd2FrZXVwIHByaW9yIHRvIHNlbmRpbmcgdGhlIGNvbW1hbmQuIEhvd2V2ZXIs
IGRvbid0DQppbml0aWF0ZSByZW1vdGUgd2FrZXVwIHdoZW4gdGhlIHVzZXIvZnVuY3Rpb24gZG9l
cyBub3Qgc2VuZCB3YWtldXANCnJlcXVlc3QgdmlhIHdha2V1cCBvcHMuIFNlbmQgdGhlIGNvbW1h
bmQgd2hlbiBpdCdzIGFsbG93ZWQuDQoNCk5vdGVzOg0KRm9yIEwxIGxpbmsgc3RhdGUsIGlzc3Vp
bmcgYSBjb21tYW5kIHJlcXVpcmVzIHRoZSBjbGVhcmluZyBvZg0KR1VTQjJQSFlDRkcuU1VTUEVO
RFVTQjIsIHdoaWNoIHR1cm5zIG9uIHRoZSBzaWduYWwgcmVxdWlyZWQgdG8gY29tcGxldGUNCnRo
ZSBnaXZlbiBjb21tYW5kICh1c3VhbGx5IHdpdGhpbiA1MHVzKS4gVGhpcyBzaG91bGQgaGFwcGVu
IHdpdGhpbiB0aGUNCmNvbW1hbmQgdGltZW91dCBzZXQgYnkgZHJpdmVyLiBObyBhZGRpdGlvbmFs
IHN0ZXAgaXMgbmVlZGVkLg0KDQpGb3IgTDIgb3IgVTMgbGluayBzdGF0ZSwgdGhlIGdhZGdldCBp
cyBpbiBVU0Igc3VzcGVuZC4gQ2FyZSBzaG91bGQgYmUNCnRha2VuIHdoZW4gc2VuZGluZyBTdGFy
dCBUcmFuc2ZlciBjb21tYW5kIHRvIGVuc3VyZSB0aGF0IGl0J3MgZG9uZSBhZnRlcg0KVVNCIHJl
c3VtZS4NCg0KPiAgaW50IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKHN0cnVjdCBkd2MzX2VwICpk
ZXAsIHVuc2lnbmVkIGludCBjbWQsDQo+ICAJCXN0cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFy
YW1zICpwYXJhbXMpDQo+IEBAIC0zMjcsMzAgKzM0MSw2IEBAIGludCBkd2MzX3NlbmRfZ2FkZ2V0
X2VwX2NtZChzdHJ1Y3QgZHdjM19lcCAqZGVwLCB1bnNpZ25lZCBpbnQgY21kLA0KPiAgCQkJZHdj
M193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcpOw0KPiAgCX0NCj4g
IA0KPiAtCWlmIChEV0MzX0RFUENNRF9DTUQoY21kKSA9PSBEV0MzX0RFUENNRF9TVEFSVFRSQU5T
RkVSKSB7DQo+IC0JCWludCBsaW5rX3N0YXRlOw0KPiAtDQo+IC0JCS8qDQo+IC0JCSAqIEluaXRp
YXRlIHJlbW90ZSB3YWtldXAgaWYgdGhlIGxpbmsgc3RhdGUgaXMgaW4gVTMgd2hlbg0KPiAtCQkg
KiBvcGVyYXRpbmcgaW4gU1MvU1NQIG9yIEwxL0wyIHdoZW4gb3BlcmF0aW5nIGluIEhTL0ZTLiBJ
ZiB0aGUNCj4gLQkJICogbGluayBzdGF0ZSBpcyBpbiBVMS9VMiwgbm8gcmVtb3RlIHdha2V1cCBp
cyBuZWVkZWQuIFRoZSBTdGFydA0KPiAtCQkgKiBUcmFuc2ZlciBjb21tYW5kIHdpbGwgaW5pdGlh
dGUgdGhlIGxpbmsgcmVjb3ZlcnkuDQo+IC0JCSAqLw0KPiAtCQlsaW5rX3N0YXRlID0gZHdjM19n
YWRnZXRfZ2V0X2xpbmtfc3RhdGUoZHdjKTsNCj4gLQkJc3dpdGNoIChsaW5rX3N0YXRlKSB7DQo+
IC0JCWNhc2UgRFdDM19MSU5LX1NUQVRFX1UyOg0KPiAtCQkJaWYgKGR3Yy0+Z2FkZ2V0LT5zcGVl
ZCA+PSBVU0JfU1BFRURfU1VQRVIpDQo+IC0JCQkJYnJlYWs7DQo+IC0NCj4gLQkJCWZhbGx0aHJv
dWdoOw0KPiAtCQljYXNlIERXQzNfTElOS19TVEFURV9VMzoNCj4gLQkJCXJldCA9IF9fZHdjM19n
YWRnZXRfd2FrZXVwKGR3YywgZmFsc2UpOw0KPiAtCQkJZGV2X1dBUk5fT05DRShkd2MtPmRldiwg
cmV0LCAid2FrZXVwIGZhaWxlZCAtLT4gJWRcbiIsDQo+IC0JCQkJCXJldCk7DQo+IC0JCQlicmVh
azsNCj4gLQkJfQ0KPiAtCX0NCj4gLQ0KPiAgCS8qDQo+ICAJICogRm9yIHNvbWUgY29tbWFuZHMg
c3VjaCBhcyBVcGRhdGUgVHJhbnNmZXIgY29tbWFuZCwgREVQQ01EUEFSbg0KPiAgCSAqIHJlZ2lz
dGVycyBhcmUgcmVzZXJ2ZWQuIFNpbmNlIHRoZSBkcml2ZXIgb2Z0ZW4gc2VuZHMgVXBkYXRlIFRy
YW5zZmVyDQo+IC0tIA0KPiAyLjI1LjENCj4gDQoNCkZvciB0aGUgaGFuZGxpbmcgb2Ygc29tZSBj
b3JuZXIgY2FzZXMgc3VjaCBhcyB3aGVuIHJlc3RhcnRpbmcgdGhlDQplbmRwb2ludCBpbiB0aGUg
bWlkZGxlIG9mIHRoZSBzdXNwZW5kIG9yIHJlc3RhcnRpbmcgdGhlIGVuZHBvaW50IGJlZm9yZQ0K
YSByZW1vdGUgd2FrZXVwLCB0aGF0J3MgdG8gYmUgYSBzZXBhcmF0ZSBmaXguDQoNCldpdGggdGhl
IGN1cnJlbnQgaW1wbGVtZW5hdGlvbiBvZiBkd2MzIChhbmQgb2YgaXRzIHVzZSBvZiB1cGRhdGUN
CnRyYW5zZmVyIGNvbW1hbmQpIGFuZCBob3cgdGhlIGZ1bmN0aW9uIGRyaXZlcnMgYXJlIGN1cnJl
bnRseQ0KaW1wbGVtZW50ZWQsIGl0J3MgYW4gdW5saWtlbHkgc2NlbmFyaW8uIFR5cGljYWwgdXNl
IGNhc2Ugc2hvdWxkIG5vdA0KZW5jb3VudGVyIGFuIGlzc3VlLg0KDQpUaGFua3MsDQpUaGluaA==


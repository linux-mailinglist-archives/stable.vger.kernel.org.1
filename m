Return-Path: <stable+bounces-54848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5809130CE
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CDA287A61
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 23:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9E116F822;
	Fri, 21 Jun 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V/Re3ujD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hFETjOTV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ETENsWdd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D984E16E899;
	Fri, 21 Jun 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011406; cv=fail; b=cIDParbnSKASEPG3/Pri2zRhB9whHbgJoK40eGA95gGBHdWsaT6WDDqDYv1+9Tqv8qtUtdM1yy74GOSZMHoUZoiNUwSwEYyCiZMOD6lVU7EA63CkSnfjEtZTw7rqSm8TE65nGkWaqpX+XdwWJ316JYSlJEf/ISPZ1AiNRfDDGNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011406; c=relaxed/simple;
	bh=DcfwqwNjOkK5abg1Zb9MXbmxhHH3ZgxsP3gpFcUsIl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNtq8aFZFRg5dkPjDhPLiNqwYtDnV0mMoTobZjysHqZoDax9ZEYxtILXfyuTIy8sFjFyI0rvK+ul/hX8NKJHaidSgUemzXReOpAO96MOP/PxJQe6vNm/7TSdqtODypoNNaWowxDP6EeA1EFS7uKVzo1Fxvtbyugo8UGNBos9Mso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=V/Re3ujD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hFETjOTV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ETENsWdd reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LHjK4F017544;
	Fri, 21 Jun 2024 16:09:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=DcfwqwNjOkK5abg1Zb9MXbmxhHH3ZgxsP3gpFcUsIl8=; b=
	V/Re3ujD2suqlZKGlRhEKFk/2GE0kVOAG2N3GlLT+oj2D5trTKdJrgs+kOs6St0A
	tqJmJ2m80SbS6vKcamF9IGciGxnCdmHgwBsMIZ9Y9wyQc+KaxfrgpzVTxWIcnr3j
	WwwZkcPAVecULR9fUEY7NV97TKpqWhoDnrPz9RHbZB0sKcrKTkIbcQOeqDDde1Pz
	9rwyHkeT+IOwGacz9UJzuJ/TjXjqeiNeC8fmSOzcrSD5Dv6seykZHmSfBXNmL4Q5
	jI/Y/XF7tNOU/F+tVyw6rgDnN9LybBbTJxXWW6915momqIWcIbT2AYKFm0td14WJ
	plo+BNQq+0PDTxlOQLzqrQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yvrhyp969-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719011395; bh=DcfwqwNjOkK5abg1Zb9MXbmxhHH3ZgxsP3gpFcUsIl8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hFETjOTVj28PIKnlmaCF5NzLfzeK461pjOOmjTtSyAB/qMYCyDVPzZEzl9J8+kcaG
	 Nn0r8FV9KkIty1tEFpqCOonFkt9J7RyPE2DD/PHUvnYImc5xGkQw5gQ46Fypx3Owut
	 AvTn5KOV3LVDSx+vIQ9rB0w4C/7RIsJSz6QKd4Zp01QAt/W6/JfVKho4mDEKfTBTWN
	 kBYTcVngdCyhb/bqab6ha+rpjzBohgpvJy7vI7EpP0ORBUdjbJXaQQ3H7iFOH2jUES
	 6v0WN9kGGm/S34Rez0hXzU5wVZB7ULUD/jlIqM75SFnz+0WBnbEW1EU69xQzSc9tKr
	 ZcY2ft+oke/Hg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99D294035C;
	Fri, 21 Jun 2024 23:09:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 524E9A0263;
	Fri, 21 Jun 2024 23:09:54 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ETENsWdd;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E01D84035B;
	Fri, 21 Jun 2024 23:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8S/zSYn05FizR7xOctTHtsobqcTLU06TY5it01poziL9XWkviOApW0h1xktq1DAAHr5j5wLcRgbl9P/TRGdCpvOAzC0qFIjnUr06i6MDyRIQjvJQxx2q2HLjEQRQ8xSMnSynOMqKmmOCn+NQWD3J5AnqClYth3hC5MREwVJh/dR/OONWC/v1O8m6gPAc3uEHMlk95ZLztsfxiKG1Ncy80paf6Fbj4dSpsiIz3C/sgAOh1elG9fznDi3+SpkP14xihTGWIMYVKyKYBEUmZGBwUR6J6cPXrJ9tOUHCb96ZRDCuxvj3bF2dnqvu+YQGijOTPuzGjC2JfMV6jpA/G0O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcfwqwNjOkK5abg1Zb9MXbmxhHH3ZgxsP3gpFcUsIl8=;
 b=YmbQHogZFVuNSWRlx9N7TGJCafHX0QQ+HSBQ8eSN/hVgQ6oWxBf0INyRqPDp6MwAfEpxGyS8f82+Nwh3nkeN67RooXO/ce0LTfy65THQCUTp9/LaeWF/X6A5UlbOTFHww0Evu+SOE3XUuZhgY2+FfszVJAkTsPoxPNqixvHwQiOCQ/3uMF62s/SexoNXr5I6x7z7dzs30EKdHD4TuoDm/x8PmPgmA37SXaKZZXEazAaiqUqVEjbPyMbyuL3J/Qiuku61dc/M6GCfCYIyYGFmbkhwS4zWojtC0ZdyNh4mquf4ADsJ+YSxDMt3BbYsg0d7DDi/2rgGvLKYp88a/0QzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcfwqwNjOkK5abg1Zb9MXbmxhHH3ZgxsP3gpFcUsIl8=;
 b=ETENsWdd63tU842d6ZdLeQBy9v98nyVgvSa1pFS0ZHU6HJ6HaVL5hH8VcRPlB30eRFzzL6p1WbI0uLPKZinYckK4m0upQhB61ZzXCyYqMJN4btPS8AZXkceBFBAK24sGIgG+EJCro3jsayjqDlFznKB6HkMbXlqTg9EBE5Kk2sY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 23:09:50 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 23:09:50 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, joswang <joswang1221@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: 
 AQHawj43Ri5O9FacdU6gpV1LQKb6abHQ5pwAgACMzwCAAD1DAIAABnyAgAAB9ACAAAinAIAADYmAgAEMJQA=
Date: Fri, 21 Jun 2024 23:09:50 +0000
Message-ID: <20240621230846.izl447eymxqxi5p2@synopsys.com>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh>
 <20240621062036.2rhksldny7dzijv2@synopsys.com>
 <2024062126-whacky-employee-74a4@gregkh>
In-Reply-To: <2024062126-whacky-employee-74a4@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7148:EE_
x-ms-office365-filtering-correlation-id: 6655fa3f-cd2b-499b-7c13-08dc924740b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cER4bUJheGZsR2xRL1VaNlZyK3d3Nm5YeTVnZjVBWFU5TlN2RmM2ZVlleHpk?=
 =?utf-8?B?Z21jcHFEUlVXZDZmeVpnbk9kb1p5UGxLZ3RiODNheUhXNVJVeUtHaWEvWTBT?=
 =?utf-8?B?Vm9sVXNBdkxUTUxMR0VEZElTekhmWlFydWN6eFMvZmUrYjY4Z05YbXppVk8x?=
 =?utf-8?B?YnFyQjlvazdrK1NDdzJFcGJkMnRvc1YvdDFYVFl1Wm9QVXd4RDVkL21yWlZY?=
 =?utf-8?B?RGk0WlYyMmIrNXBlUWpKVTBXdXFjcXoyQUVNQk9PV05OYWdKNXhodmVFZmQ3?=
 =?utf-8?B?ciszblJZUEloOWIwM0I1ZmhNNFhpaWJzVmhER0ZVSkZjdklZQm9yU1kzZmRC?=
 =?utf-8?B?c21HYUNHaW9tZ1hJMHZyL3h3b29JUWJPRXJ6dHFxN0dvdFpBVTN3TUtJYVNI?=
 =?utf-8?B?cWY5UFpFK0VVcTVUaldPOGQ5STFoMHFDNkdLMHVMVnV3STlxdzV3YjJOUnlX?=
 =?utf-8?B?MWo1NDY3NmFlS0hlOGFVN0RUZk5jY2lodUk3bVNSbjdvVVJlcllmK0hmdmFT?=
 =?utf-8?B?cTZJa2JqMElHa3pLSENoZUlXNnlkRTJGZDQ4UytIL3hxUVFqemxLVzAwV3FF?=
 =?utf-8?B?S0c2YUJ4bDFqRDZrbEJVMkpEZWNNV050RUdCNjQvcWJSeWVFTVhnbmJObGxG?=
 =?utf-8?B?Z0FNclp0OHBxVGVvYUJiT0xWcGtBUW5YRUxpbUhIVEN0Uy91UlUybUxxbGp2?=
 =?utf-8?B?ajNqZUptbjdYY0FGT0VWRTlDcy9TV1htRnhLeFFRQTZiSTFMNVltaFd4Zmt3?=
 =?utf-8?B?VEpJVys4YTVLT1BWYzBTUVFQY0IrdlJObi9pVGt4TFA1RXdieHh2SXoybkxT?=
 =?utf-8?B?bXBnNHNwOWhjcVBVOXVvbE13d2xoay9zcTdsNlpuRFI1UklvYTZoZkZaZGxB?=
 =?utf-8?B?UFFFVzZhSXh0U3Y5QWE0R3hKMUs3WVFUaU1Ta1FFUDdmOVlLaDRvT01iTjRz?=
 =?utf-8?B?ZVVhUmVoWERHZ3pIaHF0bnpOMVpzQkRyRzl6MlQxQnc5c2pKZGpZN3MzOGtm?=
 =?utf-8?B?bGIyU01JQitKaEpmMWxOYlFBUFNVYzZUQmhVT2gzNFZuM29XeVprSVRGVkhr?=
 =?utf-8?B?amdiQ0FsN2pJelprYy9KMjFVY1V0OGx6Ym0vbWdWRWtCc3BVTElPRHRCella?=
 =?utf-8?B?QzcxZFEvZk5rdmFnaGZwUWVudjdLdWF5ZVY2ZFNuQlJLckJ0NUNqMVVCd1FD?=
 =?utf-8?B?T0VHNWxLOUxRUmhHWDJPYlQyaTFjTGMwWVR5VEdObVlaVXRNY2dUYXhNZmY2?=
 =?utf-8?B?Y3JSWWVjYnVVdFp2VG95Nmd6STlHc3d0emxTZnlLdXVEeUJqaGV3ak9rWGh6?=
 =?utf-8?B?cjZuakJYZFVoUGJnU1ZFSkpobDMrQ1FDL3JyTm90RjNOU2VZckNyTEZ1ckdC?=
 =?utf-8?B?YmZBaHgySmd0TEljVTBIR0pCMVZ4U1MrOERQcGhDMkRVUlBxTmJobEZIRFky?=
 =?utf-8?B?RFJZQTdqUFVQNlRGUldoeTlTeWhKclplbVNsVHlqdFg3cHlaUkU4M2t5bC9w?=
 =?utf-8?B?b2JFN0wrTlpSeG9nbHZ5US9vR3FQREdaZ2FONXcwQXFrOUpnQ1BGZEpmTkVH?=
 =?utf-8?B?K20rakN2a1JXamNjaUQ4R1BORkd6MEgxTWFMa0swZG9ISTEzWU53dlN4UEFX?=
 =?utf-8?B?SlJHb3NVUXN1WGtxSFVFdmRMc1liYm1nY3JiM3JoSFJaVFJubXQ5aVJiLzNj?=
 =?utf-8?B?WWlNcjgzQjFCRDRvUGp3cC9YaXFyZXdaMjRHY1JtQ3hpcXJtaTNkdFZzSjY5?=
 =?utf-8?B?bW1HdkRoVWFvVlhDUVIyZGZBVENSRkQ1NGdEMkVna3FqWm52ZW04NGhWY0s3?=
 =?utf-8?Q?SbLQ8ogTFUzrDvRufaYCXbjIeoiR+ppl6uLbs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NmZGVTNsNlpwMWZmRDNZeWJueTl0UW9qYy9xajVKNmtXeU9lbHE4aC8vU1ZM?=
 =?utf-8?B?UUlMdnk0RzU2QnpreXdVYzZQWUZFeGpPeHd3Y2VNUjcxVGkvWU1ONDUzRk5p?=
 =?utf-8?B?cWpoVzZEekRPSGZYTUdtTEpkWmYrbXdZMDdnY1hkdnp1Q01FSzJNM2xNZEJw?=
 =?utf-8?B?N2tyVDdjYmx3L0JIM0xzOEFkUUJlbXROOFgrRnc4SmJJSHpCaTdLcy8zNGFy?=
 =?utf-8?B?SHJXSmExZmZZZDdXVFhLWGt4OWVqM295Tnl3L09EaDc2Z3VuWXVXd2t5N2Vy?=
 =?utf-8?B?cFpNanBtTkg4Mmxha3EvNE95SXRFQnJTMlpXQ0NFazRMT2tMTy9GaTN5ejho?=
 =?utf-8?B?L0E1ZGtOTG1JdXFtUmFCWjl2a2NsN0RRK0Fhemg1M3Iya0RqMUNnT3JScm9n?=
 =?utf-8?B?U2x3dEFmeUUzTk8vckVZODJ6TmRkMG5RaEtNdDRFMzA5TWw5UWtpbWxZYUlB?=
 =?utf-8?B?Ynp4K0h4aXZhN1Z5S2tDLysxV3RmTUlBK2pyYy9tM1RmWnZDNGhLSnpIaXhj?=
 =?utf-8?B?K3gwY04rUWlGWENmaVVzb080RzJ4NE9qSFdzdzRXdlFpR1RmRUlCd3dhb1lq?=
 =?utf-8?B?bkVJRi9QaUVPRXBlckl2RTJaWlJQdWl2UzlHaERpWWdhRjhKRnVBek9yMWc4?=
 =?utf-8?B?OXFyQm5VVE5oL2tnRXpKZGx2NmlndUFzVjdBMVF3SWdxVHJHSUdsOExzY3Qv?=
 =?utf-8?B?VmN5bWtDNjNHMEJXQzBleERQRFFYNkU1TTVyVCsrUHZlQVdLdjFhK1c5T2ZR?=
 =?utf-8?B?aVBNQ28yRG5ta0VpdzJ2Z2VWNFp5Vm1YU29CWUl1YlJOa3FIM3JzNERvMW1z?=
 =?utf-8?B?OEJYN3owSXZoQkdYK1JmNlJyanZrbGgzWjlWUVpRa0Y3SThjR3pSM2RMdzlU?=
 =?utf-8?B?bHJsWHc1WTc4M2dmazZFck1ZM3lzYXdMSmZaNW4ybTYvVW5XcEovYXNLTTlC?=
 =?utf-8?B?TE1jRDJINU8rZVUvb2JFb3FPOFpFcktwcVF3ZXRzQzFOQmMvZVhlOCt3SUc0?=
 =?utf-8?B?b2FhM2tMR0sxY0prdCtCWllFRFh0eFFvaDZPNTA5eVVIWnhBNTBXVlgwbVl6?=
 =?utf-8?B?KzdiMnJIQmNFZnY3NVhSSmJ2ZHBRdzRqOVBMOGx1NjY0bUlxajRjYVlCOEdZ?=
 =?utf-8?B?WnNRaGtZNVhlWjVPM0pNMCt0dHhvLzgvL1NRYWdXMmFrQTZSZVJtcnkrWFIy?=
 =?utf-8?B?MDMzbzN1RGp3R01UVmk3ZWxGeEFZRnl1OUxtL0h6ZERHSzFDcUt0RExST2hD?=
 =?utf-8?B?OVZvbkY1bFhLVkdNUkFRQjJIdVczOXFmcU4wRTZzMnpORUFKWk10MEw1VXNK?=
 =?utf-8?B?YXNYVm1xL3JVK1BOMm9peVZjUkd6UWpNZ2V1K0ZLcTNWSEN2c2wxWnBwVkU0?=
 =?utf-8?B?SllPeXZlNncycVMyNHVpa2tFWEtBNlZVcXRUR3ZuSS84cmFZc3dhNy9IM3VJ?=
 =?utf-8?B?QS9aZkVsRno1VnMzQ2l3SDEvQ1hNMEVpKzRubllsVHNMUzFPWEZXNk5lTkNM?=
 =?utf-8?B?MUVTMUhGQml2Rm1PMkluRHlqbjI4SFQxZTNQYTNOODR6NENGTW11R1NkRUww?=
 =?utf-8?B?YURtUk9rMk9qa2RpbktleFo1WEVWMk5QZnM2RW1LeHdoVUVHZ3hTSVN4L0l0?=
 =?utf-8?B?OEozTWc3ZTZwQmxldFdrYkhUTTRRdUovTGhQWFoyaFRxallXbzR2Yzk2cG5M?=
 =?utf-8?B?ZWFMZXpYell0cFlFTitiQk5vU3hPeDhjem4ybHk4YmFsdWZ6YXBlbFJGRFFk?=
 =?utf-8?B?S2pON0F2ZUIydFo5NGc1R2FpOVNMZWE3TVYxam9oYWZPWkU5aFBobnV1SFlY?=
 =?utf-8?B?aHZHRmdNWnZ0cGxCTkJRY3NMM3cxQ2VrYnIxSm1McHhrR2NhNWszMTZkRTFa?=
 =?utf-8?B?L0NoL1I3RXBqVjFFSlVqZ1ZBejVqYXorY1lWaDl6ZnBCeHNkUDEzL2s1TnFl?=
 =?utf-8?B?QzVpaDMrMkQ5WGxja01nNDJFVVVjUGNuWVdQejMzaVpTdnQyZWEzMXdLMW9B?=
 =?utf-8?B?dnFaYzZpQmd1WVR1SUtHRUdIUEtBWFpPUk9Sbml6YWRKaVJGVTlhSExoczZ0?=
 =?utf-8?B?b2FXUS9iUlhyeGhheUNTZW1OeEFCS2ZzMTBLNzlyZnRQcHo0emQzVTkyTkdX?=
 =?utf-8?Q?k1wYsG5ZNeWwoY3CXDjgfZDI8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B1561FAECF2894891F2E1431E4434F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UvKgZsJPmbzF0FRNkknauRgGss+hUf4U9WwbkEi9lhdUIc9OSFxx7csIi6Nd4ZdXJTPJE8sdW561iykTeASnhUiTHzvUpTXZ6m3KNEHEvzbXr5UUD/G0l3SepAy5+5RXg0ZA+L6B9srZ4hhrxeItweLscNUUsxgGAHCv8BYOWNGaF+rRs3muuhgP2Zezx+ROU7m9EF5pgqRZmAT5LEUYRyA9TO7JV+lmx6Cl/DCiliKwPjsJz7icAj4kzQOC68S1p41lmhOD+x9lvvn4fMJztwRELBZDEvz5JSSJxduO9hb8RRdqGRF96rBTFsUtiGIL3SZ6zaCDaQftNef+TyFJ7f/s9JDGHD+nABndHZkKI3I6ocyP3QOypmRMzEb+N3VBDYM53onyWmDTZo1DrpkjiiAVGjXCw67XdCJYS2U/oMhKb4g0xEfmdSDaMAsCC5j6wABgYoBj/LwAP4bB/mwNF0IJFaIZUfu6xQ+HR9QJYWEwd3cfGenoVz8xmYDzIwbonQaK6cEumxEJDnUtWuPZ/G6ZeicXkuhczQF1qi1rZ5fxYHU2zUsYFMjOQSioIc+AMBdNZOEeTwlX0ZrEikKXlxRZiHG0WTzofO4VhGcEX3Jr/nQQUMW6JaA5MMIaVnyEz7H6Xbc/4dd5AE4LrisBSA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6655fa3f-cd2b-499b-7c13-08dc924740b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 23:09:50.5396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ytVwAGA06MfkPQO0EtNTz21lGaWicvSRYNaUOOofAANtGZX8UbBYFqPvYEo6KTFaXJHfJdKxC2bsph7hludkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
X-Proofpoint-ORIG-GUID: 9UHLF1iS3A-YUpZ1v7eiIpeLCbLfZafV
X-Proofpoint-GUID: 9UHLF1iS3A-YUpZ1v7eiIpeLCbLfZafV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210168

T24gRnJpLCBKdW4gMjEsIDIwMjQsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDIxLCAy
MDI0IGF0IDA2OjIwOjM4QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBGcmks
IEp1biAyMSwgMjAyNCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+IE9uIEZyaSwgSnVuIDIxLCAyMDI0
IGF0IDA1OjQyOjQyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gT24gRnJp
LCBKdW4gMjEsIDIwMjQsIEdyZWcgS0ggd3JvdGU6DQo+ID4gPiA+ID4gT24gRnJpLCBKdW4gMjEs
IDIwMjQgYXQgMDk6NDA6MTBBTSArMDgwMCwgam9zd2FuZyB3cm90ZToNCj4gPiA+ID4gPiA+IE9u
IEZyaSwgSnVuIDIxLCAyMDI0IGF0IDE6MTbigK9BTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE9uIFdlZCwg
SnVuIDE5LCAyMDI0IGF0IDA3OjQ1OjI5UE0gKzA4MDAsIGpvc3dhbmcgd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gRnJvbTogSm9zIFdhbmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgYSB3b3JrYXJvdW5kIGZvciBTVEFSIDQ4NDYx
MzIsIHdoaWNoIG9ubHkgYWZmZWN0cw0KPiA+ID4gPiA+ID4gPiA+IERXQ191c2IzMSB2ZXJzaW9u
Mi4wMGEgb3BlcmF0aW5nIGluIGhvc3QgbW9kZS4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+IFRoZXJlIGlzIGEgcHJvYmxlbSBpbiBEV0NfdXNiMzEgdmVyc2lvbiAyLjAwYSBvcGVy
YXRpbmcNCj4gPiA+ID4gPiA+ID4gPiBpbiBob3N0IG1vZGUgdGhhdCB3b3VsZCBjYXVzZSBhIENT
UiByZWFkIHRpbWVvdXQgV2hlbiBDU1INCj4gPiA+ID4gPiA+ID4gPiByZWFkIGNvaW5jaWRlcyB3
aXRoIFJBTSBDbG9jayBHYXRpbmcgRW50cnkuIEJ5IGRpc2FibGUNCj4gPiA+ID4gPiA+ID4gPiBD
bG9jayBHYXRpbmcsIHNhY3JpZmljaW5nIHBvd2VyIGNvbnN1bXB0aW9uIGZvciBub3JtYWwNCj4g
PiA+ID4gPiA+ID4gPiBvcGVyYXRpb24uDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEpvcyBXYW5nIDxqb3N3YW5nQGxlbm92by5jb20+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IFdoYXQgY29tbWl0IGlkIGRvZXMgdGhpcyBmaXg/ICBIb3cgZmFyIGJhY2sgc2hvdWxk
IGl0IGJlIGJhY2twb3J0ZWQgaW4NCj4gPiA+ID4gPiA+ID4gdGhlIHN0YWJsZSByZWxlYXNlcz8N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gdGhhbmtzLA0KPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBncmVnIGstaA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBIZWxsbyBHcmVn
IFRoaW5oDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEl0IHNlZW1zIGZpcnN0IGJlZ2luIGZy
b20gdGhlIGNvbW1pdCAxZTQzYzg2ZDg0ZmIgKCJ1c2I6IGR3YzM6IGNvcmU6DQo+ID4gPiA+ID4g
PiBBZGQgRFdDMzEgdmVyc2lvbiAyLjAwYSBjb250cm9sbGVyIikNCj4gPiA+ID4gPiA+IGluIDYu
OC4wLXJjNiBicmFuY2ggPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYXQgY29tbWl0IHNob3dl
ZCB1cCBpbiA2LjksIG5vdCA2LjguICBBbmQgaWYgc28sIHBsZWFzZSByZXNlbmQgd2l0aCBhDQo+
ID4gPiA+ID4gcHJvcGVyICJGaXhlczoiIHRhZy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4g
PiA+IFRoaXMgcGF0Y2ggd29ya2Fyb3VuZHMgdGhlIGNvbnRyb2xsZXIncyBpc3N1ZS4NCj4gPiA+
IA0KPiA+ID4gU28gaXQgZml4ZXMgYSBidWc/ICBPciBkb2VzIG5vdCBmaXggYSBidWc/ICBJJ20g
Y29uZnVzZWQuDQo+ID4gDQo+ID4gVGhlIGJ1ZyBpcyBub3QgYSBkcml2ZXIncyBidWcuIFRoZSBm
aXggYXBwbGllcyB0byBhIGhhcmR3YXJlIGJ1ZyBhbmQgbm90DQo+ID4gYW55IHBhcnRpY3VsYXIg
Y29tbWl0IHRoYXQgY2FuIGJlIHJlZmVyZW5jZWQgd2l0aCBhICJGaXhlcyIgdGFnLg0KPiANCj4g
U28gaXQncyBhIGJ1ZyB0aGF0IHRoZSBrZXJuZWwgbmVlZHMgdG8gd29yayBhcm91bmQsIHRoYXQn
cyBmaW5lLiAgQnV0DQo+IHRoYXQgaW1wbGllcyBpdCBzaG91bGQgZ28gdG8gImFsbCIgc3RhYmxl
IGtlcm5lbHMgdGhhdCBpdCBjYW4sIHJpZ2h0Pw0KDQpZZXMuIFRoYXQncyByaWdodC4NCg0KPiAN
Cj4gPiA+ID4gSXQgZG9lc24ndCByZXNvbHZlIGFueQ0KPiA+ID4gPiBwYXJ0aWN1bGFyIGNvbW1p
dCB0aGF0IHJlcXVpcmVzIGEgIkZpeGVzIiB0YWcuIFNvLCB0aGlzIHNob3VsZCBnbyBvbg0KPiA+
ID4gPiAibmV4dCIuIEl0IGNhbiBiZSBiYWNrcG9ydGVkIGFzIG5lZWRlZC4NCj4gPiA+IA0KPiA+
ID4gV2hvIHdvdWxkIGRvIHRoZSBiYWNrcG9ydGluZyBhbmQgd2hlbj8NCj4gPiANCj4gPiBGb3Ig
YW55b25lIHdobyBkb2Vzbid0IHVzZSBtYWlubGluZSBrZXJuZWwgdGhhdCBuZWVkcyB0aGlzIHBh
dGNoDQo+ID4gYmFja3BvcnRlZCB0byB0aGVpciBrZXJuZWwgdmVyc2lvbi4NCj4gDQo+IEkgY2Fu
IG5vdCBwb2Fyc2UgdGhpcywgc29ycnkuICBXZSBjYW4ndCBkbyBhbnl0aGluZyBhYm91dCBwZW9w
bGUgd2hvDQo+IGRvbid0IHVzZSBvdXIga2VybmVsIHRyZWVzLCBzbyB3aGF0IGRvZXMgdGhpcyBt
ZWFuPw0KDQpTb3JyeSwgSSB3YXNuJ3QgYmVpbmcgY2xlYXIuIFdoYXQgSSBtZWFudCBpcyB0aGF0
IGl0IG5lZWRzIHNvbWUgd29yayB0bw0KYmFja3BvcnQgdG8gc3RhYmxlIHZlcnNpb24gcHJpb3Ig
dG8gdjYuOS4gQW55b25lIHdobyBuZWVkcyB0byBiYWNrcG9ydA0KdGhpcyBwcmlvciB0byB0aGlz
IHdpbGwgbmVlZCB0byByZXNvbHZlIHRoZXNlIGRlcGVuZGVuY2llcy4NCg0KPiANCj4gPiA+ID4g
SWYgaXQncyB0byBiZSBiYWNrcG9ydGVkLCBpdCBjYW4NCj4gPiA+ID4gcHJvYmFibHkgZ28gYmFj
ayB0byBhcyBmYXIgYXMgdjQuMywgdG8gY29tbWl0IDY5MGZiMzcxOGE3MCAoInVzYjogZHdjMzoN
Cj4gPiA+ID4gU3VwcG9ydCBTeW5vcHN5cyBVU0IgMy4xIElQIikuIEJ1dCB5b3UnZCBuZWVkIHRv
IGNvbGxlY3QgYWxsIHRoZQ0KPiA+ID4gPiBkZXBlbmRlbmNpZXMgaW5jbHVkaW5nIHRoZSBjb21t
aXQgbWVudGlvbiBhYm92ZS4NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kLCBzb3Jy
eS4gIElzIHRoaXMganVzdCBhIG5vcm1hbCAiZXZvbHZlIHRoZSBkcml2ZXIgdG8NCj4gPiA+IHdv
cmsgYmV0dGVyIiBjaGFuZ2UsIG9yIGlzIGl0IGEgImZpeCBicm9rZW4gY29kZSIgY2hhbmdlLCBv
ciBpcyBpdA0KPiA+ID4gc29tZXRoaW5nIGVsc2U/DQo+ID4gPiANCj4gPiA+IEluIG90aGVyIHdv
cmRzLCB3aGF0IGRvIHlvdSB3YW50IHRvIHNlZSBoYXBwZW4gdG8gdGhpcz8gIFdoYXQgdHJlZShz
KQ0KPiA+ID4gd291bGQgeW91IHdhbnQgaXQgYXBwbGllZCB0bz8NCj4gPiA+IA0KPiA+IA0KPiA+
IEl0J3MgdXAgdG8geW91LCBidXQgaXQgc2VlbXMgdG8gZml0ICJ1c2ItdGVzdGluZyIgYnJhbmNo
IG1vcmUgc2luY2UgaXQNCj4gPiBkb2Vzbid0IGhhdmUgYSAiRml4ZXMiIHRhZy4gVGhlIHNldmVy
aXR5IG9mIHRoaXMgZml4IGlzIGRlYmF0YWJsZSBzaW5jZQ0KPiA+IGl0IGRvZXNuJ3QgYXBwbHkg
dG8gZXZlcnkgRFdDX3VzYjMxIGNvbmZpZ3VyYXRpb24gb3IgZXZlcnkgc2NlbmFyaW8uDQo+IA0K
PiBBcyBpdCBpcyAiY2M6IHN0YWJsZSIgdGhhdCBpbXBsaWVzIHRoYXQgaXQgc2hvdWxkIGdldCB0
byBMaW51cyBmb3INCj4gNi4xMC1maW5hbCwgbm90IHdhaXQgZm9yIDYuMTEtcmMxIGFzIHRoZSA2
LjExIHJlbGVhc2UgaXMgbW9udGhzIGF3YXksDQo+IGFuZCBhbnlvbmUgd2hvIGhhcyB0aGlzIGlz
c3VlIHdvdWxkIHdhbnQgaXQgZml4ZWQgc29vbmVyLg0KPiANCj4gc3RpbGwgY29uZnVzZWQsDQo+
IA0KDQpPay4gSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29kIHdoYXQgY2FuIGdvIGludG8gcmMyIGFu
ZCBiZXlvbmQgdGhlbi4gSWYgd2UNCmRvbid0IGhhdmUgdG8gd2FpdCBmb3IgdGhlIG5leHQgcmMx
IGZvciBpdCB0byBiZSBwaWNrZWQgdXAgZm9yIHN0YWJsZSwNCnRoZW4gY2FuIHdlIGFkZCBpdCB0
byAidXNiLWxpbnVzIiBicmFuY2g/DQoNClRoZXJlIHdvbid0IGJlIGEgRml4ZXMgdGFnLCBidXQg
d2UgY2FuIGJhY2twb3J0IGl0IHVwIHRvIDUuMTAueDoNCg0KQ2M6IDxzdGFibGVAdmdlci5rZXJu
ZWwub3JnPiAjIDUuMTAueDogMWU0M2M4NmQ6IHVzYjogZHdjMzogY29yZTogQWRkIERXQzMxIHZl
cnNpb24gMi4wMGEgY29udHJvbGxlcg0KQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUu
MTAueA0KDQpUaGlzIGNhbiBnbyBhZnRlciB0aGUgdmVyc2lvbmluZyBzY2hlbWUgaW4gZHdjMyBp
biB0aGUgNS4xMC54IGx0cy4gSSBkaWQNCm5vdCBjaGVjayB3aGF0IG90aGVyIGRlcGVuZGVuY2ll
cyBhcmUgbmVlZGVkIGluIGFkZGl0aW9uIHRvIHRoZSBjaGFuZ2UNCmFib3ZlLg0KDQpUaGFua3Ms
DQpUaGluaA==


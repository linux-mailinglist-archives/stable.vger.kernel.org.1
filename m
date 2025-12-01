Return-Path: <stable+bounces-198020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCCC99A53
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EFA3A3AC2
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C621A23AC;
	Tue,  2 Dec 2025 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O7ZSLmX2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H1IJGyXp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ttv+HlMr"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7D36D518;
	Tue,  2 Dec 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635051; cv=fail; b=FVJJTI6KwBFvFF0ZKcRX4AfIld1AfdBtvHBrHc0QWu6ZCK1jO7sgB8tYhpbQUwHdOMcq1axG7Q+dBMXI1xWAEEvQfffDuK4Ea9hTv8pKdgvJKUgqB6sCGrMyaGP5lVCMxlA4FCwGd+HKMQN4+PooIGXSjoSjweS0PC0kIU2D6GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635051; c=relaxed/simple;
	bh=DGtPJubjHhCkuYzFDYOn/OdzH+HnvWu3g0AD+lE6Lzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMLMadymejqajkJ7qC1fzSnz6FvjmPYaRDn0HB6Qr7u7FgnFROzr2kLUvtVcnzDHLOcLaccIhC05k2/Z5eQARS0kXpndEXsphwnIU+wIGN/9gnZ0QsGtw+Vh3jJayp6d0xX3PxmgN6jLHtiPfY9xyZ26OqspKwAKxLQK6J+uEj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O7ZSLmX2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=H1IJGyXp; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ttv+HlMr reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1M5KUM2964717;
	Mon, 1 Dec 2025 15:30:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=DGtPJubjHhCkuYzFDYOn/OdzH+HnvWu3g0AD+lE6Lzk=; b=
	O7ZSLmX2FWl4E4Fk/EMd3d+NjKcVC0fBB9a2e56oTTIpIxdlg8CFtIDza44ClLfu
	8gE8MsrlUTuSXyY1P4u11z/mMiBp+m8/XoFxsWxcWNfA9r4eQT58bN5qww6UxHRU
	3iix438TGY19DZCom6j96I1pDc7N4ML5Ix2idIywUR7YfcCvcprQ/4VxicLQiLbd
	0mlFwjo27SS01iUV3sPPyFbO/e9YHKI9k2tAm5BXYqT3A0rPqvGOmAuQV7/Pbqi9
	7bqEXjX5uvZuF1F3/Uey2w+G88bMQ5U5C9FO3jrME1yoZFiImHVHYWzoeCI0cHO6
	gj09ZUqUbhtgm1sVoZWfSA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4askbq89xc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1764631849; bh=DGtPJubjHhCkuYzFDYOn/OdzH+HnvWu3g0AD+lE6Lzk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=H1IJGyXpTt0MPr05vfjPZxAUvlSjNgiRWp/QaeNjRG3kFEFtFvtr4hnMuDIMCZidC
	 bgCW0EXWXi4JJqoS8E3b89OB1Pb1xUalHiXOmJe1MWsgxx5w3oPnU9xb3ka5YHldqe
	 oNaqZTVg5MlL2VmDMlmGmrkIPcbaAuqVnPKqLyCK88b9KjJQxugzLVOyAjP6zk78MI
	 y+wRxhCYZdXxMDSHSI6o2pKUnDVmHbQwnYxajzAYD6QOazqXAaIjAvubfbq75AudeJ
	 W5x0rb+Z9jRIgkCEYuhAtBYfy0ODSix2Iwskfipn84A1pPkIjpH9yEoxXJnY8iTC2G
	 PymRTTCvu3CpA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 51C0D40453;
	Mon,  1 Dec 2025 23:30:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 08BB7A005A;
	Mon,  1 Dec 2025 23:30:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ttv+HlMr;
	dkim-atps=neutral
Received: from CO1PR08CU001.outbound.protection.outlook.com (mail-co1pr08cu00105.outbound.protection.outlook.com [40.93.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 41B8440364;
	Mon,  1 Dec 2025 23:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNnDLhTaxtsCWsGjbX/PPsg8y6Lio9any910M/F6PVqeJ0OJqTNigWa9CGvg71W/JjLW3GRzVctw4R5IXGX5uADVxIW6VOg1qt0bgUo82MkhiwSmLAl5nlnX/62egD9PHuK3Aa4hLyQWnMPKwUTQKvS2eED9b+B5gNQFJcaR6aaxKIFI7HdmPHPsgnsy5/OrAZ+eynCrbXV0WSb5YOPnkaaKXHClcTa59lJYGIhO7knrBMAkWlTISiBXWpBqUlGoIgsX+k20UmM/WwotZ2amFejb3linDxiOaQWu8g8irVcDRyEjM87TS38XZG+Pjoxo72BUMLfCjzWs8Vnbimj+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGtPJubjHhCkuYzFDYOn/OdzH+HnvWu3g0AD+lE6Lzk=;
 b=XlrBwL/ceM4piG2jHBaot7u/lZknx4K/Crun3ULy9ZJHgSSZWXiFelrkxHNy6rqS1VXhxn2uwchR9AFn6a39ThEA6zlL1z3Xi57Soe/IRf14OgO1NJi4F/s/N6hQhNlUfaEUldVXCM7N8rl5ROPuFODt4CRgdbMh1iXCz1GS3zfq0zMOTTde3pC7wMXXYqtepEOteCDl5L7IuwqZM5zmgeKUcDafJ/mzD+/dvuWtToVqU7OZ/1AUNxpVhWmsfZFM3mwpq9KeZLqK5bseHMEMJow4sX0LDWT6o7q79PB0ZhCjmM/Oblu9JVqjRM/8o/8WT+6FYr2pKeHjSOAjOmdpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGtPJubjHhCkuYzFDYOn/OdzH+HnvWu3g0AD+lE6Lzk=;
 b=ttv+HlMrjrsptAnUE2D3KXrasb/11PGldhh+B89trTOX3HEpGJSaD5PP/bodIklLLYK6DDc9Mp5reu3DWPtqf+Kh73tA74apXueCFQPUhrrsqWWbEWb3QIqYgUIL2otSteQuc8um4CM1Jb/2z+Ao6MFDiFoOOvGwib9WUWr8mGg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:30:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 23:30:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Udipto Goswami <udipto.goswami@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: keep susphy enabled during exit to avoid
 controller faults
Thread-Topic: [PATCH] usb: dwc3: keep susphy enabled during exit to avoid
 controller faults
Thread-Index: AQHcXpd4mJ3hoJrQTk+5nvH8X0acVbUNd9SA
Date: Mon, 1 Dec 2025 23:30:44 +0000
Message-ID: <20251201233041.knt5lzx7lkk7foxx@synopsys.com>
References: <20251126054221.120638-1-udipto.goswami@oss.qualcomm.com>
In-Reply-To: <20251126054221.120638-1-udipto.goswami@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB7591:EE_
x-ms-office365-filtering-correlation-id: 06dbdd72-5752-4d35-ea77-08de3131a62d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVU4bEJ5cmlVN2dlT1MzNjROamRtZFhkRHJtOVRBU2Z3cTl4T2c2UUd3T0c5?=
 =?utf-8?B?aUhQQW9Gc2NPYmZ1T05XbVFaV2Y2My9BS3pxR3FjSk9rY09Cakp0U29BZ1ho?=
 =?utf-8?B?NkVpY1g4ekdxcHV4by9oaWs4SllsN0Z5WTR6VlhmaHB2ZFYzREhLdWt5cGV5?=
 =?utf-8?B?TDU1OHVtSVlxRzJvS3Q4L3F3elc1RHhZcHhpb0lpV1haT21ZZU5zcG1yZEds?=
 =?utf-8?B?UVJBNjFoaU5WcDVHWlUxa216Qm9SZlB1aHBzai93NGhxM2tjSmwvaENvTXds?=
 =?utf-8?B?T2NEQ2FpMENFbGlyK3AvelNiTDNTNE1kVlQyYllpTCtqRithNi9pemR1N3ZC?=
 =?utf-8?B?SW5TUk5NeGdCUTYxODBnWE1lQ1RYS3dJdWUxRmtFTXBkMnVpQUJTTlBsZmFl?=
 =?utf-8?B?bGJGU3Eyd2JSN3hVVmtBT0Y2dkdiekljMVVmR2NZUVhhbm56clRYM3ZFdTRH?=
 =?utf-8?B?ekR2M3dNRmE1K1Q3bFhYQmVEVURVNlVaZGtZdnoxeHgvNXMrblVka1pOMm1w?=
 =?utf-8?B?YTkwM0hEUXl0V2RJQVB6WkxTM05DYUFrUDNuS3VPbjZUMUJ6Tkh1YlI5U2Mr?=
 =?utf-8?B?L1JzbGRCcUQ2YW5COTM3MzM4aGVnWlJFaUJKWldQUXIrNGIzTHlVa0IrOVZE?=
 =?utf-8?B?cTBxdmFJYzVWNmY2eVo2ZlhUL0dkZlVMV3NYRXBDQlQ0emJkb1JYaWUzK2dx?=
 =?utf-8?B?TjBlYUY0NTh4ZnB6VG9VTHd0Tk5aZFhsaWNYRWdvdUcrelViTWN3S1dkUXVn?=
 =?utf-8?B?SFRLR2NQQ3hWSnRqUC9EYy9hbHZmSzg4aG4rOS9uWkVZVUVRUWdBQ2xhTTIx?=
 =?utf-8?B?dlJKQnV0T2FFU1FoamNDeFVnNUhwbjdUL3hZaG1IbEdzZFJqZG1uV0RJMTFh?=
 =?utf-8?B?K0tKNEhiR1J0V1pyQmkwVnB5Qks5azlCQXRjajlkZk5xVTBvUlZRakRKL1BS?=
 =?utf-8?B?OFZHdTlvUFExTGJVN0FZdExMeUZIUlFPNHoxYitnY3NpcWQ0RDNMRHhMKzhp?=
 =?utf-8?B?ZmVYTFYvRDczaGdlb3FxT0wxTWEvVXUxd3NucDN0Z2ptWDMyNnpocXdudG84?=
 =?utf-8?B?R2phY1ZWL2VkbzdvaEpDZDZsREZxOGRtSGtPZnZOYkFKSlhUQ2hDR0QzcnVw?=
 =?utf-8?B?UjJsTDIrV3U4VEdzRCtGdkoydXF6ZGR6RWdJeE9Jb1F1RWhKR0lETXUzMkJ2?=
 =?utf-8?B?a3ErY1VpM2MvM2s1MXF4V1ZldW1sMzBaTFVpMVcrZGFNeGxFMWNGSzNSZHhD?=
 =?utf-8?B?Vm5TVnRPQlB1VjJqdG8zeDRxMDVYYzYwYnJWZUltbzdxdnFEdTI5V283Ukt1?=
 =?utf-8?B?Ym42QnkxMXdhV3Bpa1dVbjdnMXU5VVRzcUo5VXRTQ0NhMTZMNnlCZ3h4TW92?=
 =?utf-8?B?c0tPa2JyQUNCQVVhYXQxNHE3MS9RRS9ZNlB3SVJzZHd2STAxN2FGNEZwa0NH?=
 =?utf-8?B?V25xN0daMm45aFhhSVcySXBJZ3N2cGNrcFdHcHAyWnEwMWN2eGhVUlVDNlFv?=
 =?utf-8?B?aWJ2aVFnd042M3A2NFVLbUJBSGFKWDFkZ2xnMm01MU9NbnptZ3lBQXlWS1Nm?=
 =?utf-8?B?QXBSZTNmSVdNenNOZE9wdjVTRnIwanBzS2x3eFJzR1h6Zk1BeU5pc2JIUEMr?=
 =?utf-8?B?Vm4vWkV3ako0bGt3RTVBZXpDNU5EQUhvWkNHSmYvSWdRRjlSbDJ3ZENweDlz?=
 =?utf-8?B?ZW81enZCZEI0T2FFRVJ3amhtdWVXMzRUUTY4Q1ZBU1FrY29YK2FFUzBIeGQz?=
 =?utf-8?B?RTNHRE1VZDBkUVV0Y21NTmJCTWZtRXhrWmk5SjJGUFpZMDQ5L3phMnlsbEQ1?=
 =?utf-8?B?YnF4UTJEYnNRaUtMdDJESXY2VlpMUHRKL1FNYncwdEtJZFFyZytUWm85dGpy?=
 =?utf-8?B?bDFVa0xOVkZqUWh2dVJMN0c5QkduNkFwZmorRHFwRFN0aytkaFVhWlpRa2o5?=
 =?utf-8?B?NUhKMCswd2lTbmdFN01LbXVOWmgrTVVtTm9JR0xFMTVpR2cxTVNsWGlxYkhr?=
 =?utf-8?B?TGJRcXZHRW13SGlISmp3SjQ3blA2QnBvVmFxVktNTTJsQVJQVHZGeFFmU2VM?=
 =?utf-8?Q?w50y62?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUVPMGNpMU5YZWtZV2pieVp2WDErM1h6THZQZGRVUHNDeEliMmlwM3RtWmEw?=
 =?utf-8?B?ZC9OWVc2eXcySkhoZjR1cEttUzRGVFgwSTE4Z29pdVBaY01jTW9mcjZ6L3Zz?=
 =?utf-8?B?b0FneEIyZzlRZzNYYXdFVGE4VjdDclZ3NmlhZlVocDlHRmtCNHBnK0ZBWnlC?=
 =?utf-8?B?WmRpbjlsbEFpZml2dXBHU2d6dVYwMTRvYXFidnRpYkRmQU50NHJxUndFQmFC?=
 =?utf-8?B?K295QkF6dTd4ay9wSXVLZW42Z2g4MXRuTUlNK1JyUnlYV2ZPU1dRNnFaT3Vk?=
 =?utf-8?B?c1hHZlBpdFdRNjJrZGk4d0VIODN3YjB5RkZKb05neFNaempiZlBLZU95SXo5?=
 =?utf-8?B?ejF5OGZtQXEvRjBjYk54Q0I0SzVLM1RPTTgyall5Tm91TExyUnpocy90Q21P?=
 =?utf-8?B?d2tvREZlL0JuVllVbXdjbFF5ZUY3WVRuM1RzWXNKbFhPQlZFbmlid1lsV0Vj?=
 =?utf-8?B?ZjR6bk03Yk1idTczVkQ2VDhrZXVuS3pKSlRvaW1xMU1oL1lEaTlaS1I1c1R3?=
 =?utf-8?B?bXBHTDZhaTlvOFZGN052ek9XY0EvemxPVHpqUEw5NStLZkV6QndDSnAwN3ZX?=
 =?utf-8?B?S05WaW83WHpLTXJ6MkVPdldBWEVGVTNFZjNvTk56SHNuQWQ5S0lVUmFHL3BD?=
 =?utf-8?B?d1J5SVNNRy9zYWdyL1BVci9PbnVkSTg3Z2w1ck4yeE16YTFSYk4zYnJUek03?=
 =?utf-8?B?T2krQ2N1dWZIeFo5WU5MYUhZMGFRaGZMVkJTNjBSSWtYUlFQZytuTzBOM3ZL?=
 =?utf-8?B?WEQwMWJ2Q2JxTnRJTnYyN00raHhZRnVGVFVzYjZxejJHb0RnTENqdVFlUkRX?=
 =?utf-8?B?T2xyNHJlM0JwN2lXT0lVYVkrWnVhY095WG11OHlINE43R2ZVUktvZTZjTGNB?=
 =?utf-8?B?eGJOVlNvZ1VRWE1vaDdPUmxzQXRBTER1dmUvMkdQMjR3aHROcm5zL09la09t?=
 =?utf-8?B?cFRRNFZPM0FPV2tFbnd5aWthT3pveUd0cWJWN256RGpCSjMzQVFSZzlJTEYw?=
 =?utf-8?B?N1JXRVJyRGtZeVhtaDdVVStqaFhVVURzYklyZFpwREtxejJxUXRmWlJidnNX?=
 =?utf-8?B?RXdHU043ck55aVVxaFdjR3JWU3ZKejdSUGl1S25TL0Z4NWo0RzRxdWk1M2lj?=
 =?utf-8?B?dkZ3bXNBMGk3ZFI2YVFHS0hKbnZ3NzFuUlE4VmYxQ0Yrb2gvVFJna0xWY3da?=
 =?utf-8?B?S1NMMVNZVHgrbCtYKzVOd1pCZ0d6c0QrRFRzRUlQMS9PRmdCRldRK2ZOTmtl?=
 =?utf-8?B?VHBMbkE3Z1cwd2xKOEVMWWt0RlFxRHdZNytxVXlIeVBpMlA4dS9QNjhYaUFq?=
 =?utf-8?B?bld0TTVPR0RZN1ZQbUtzUlZma25aOFRkWlFabldsRExxY3dRZnBlOHY5Z2Nq?=
 =?utf-8?B?aVlwYU93VVFvUHVOaGt6cXRqUVN1YUh4Z0xsaDlYTGVIbDJDN050a2RZRVdK?=
 =?utf-8?B?M2ZVcmNjY3diVVFiWEYvZWVhTjRtdkpzaytOU3NuQ0llOWlxSE5MNHpqMGh1?=
 =?utf-8?B?V3FBZVhnUllXclZrZjJ5ZHUxWU52dkNpamo1TmVobi9GMzVtZXkyRlVXY2Nz?=
 =?utf-8?B?YWRJdUNGMFNoNDFKcjliTzdHZCtmWmZHUTZFQWh4cERjQ1h1eittOWxzNGkz?=
 =?utf-8?B?QnpsbHhaUE55d0pLMFFqUnplcDFyNENXblhkTFg2dXNPOXpjS09EMFZpYlhk?=
 =?utf-8?B?bmFHWUxoTGt3WHN5R2ZnaUQrTXZBc0FBeGR1RTB4MDU3S3pCN0tLZVh1OGcw?=
 =?utf-8?B?UGt5WHhBVlBmejloSjBNMk11YjFsclFSeEpjRWx3UUdMSUxPRktyeUZNanU1?=
 =?utf-8?B?ak93MnNiNm94d3NFaFloRFRRNEErYTFmK2lHc2ZMKzM0SUZJZk15UmVZemQ3?=
 =?utf-8?B?TXR0Ty9BcFlYMEVZa1RNS05EMjlFLzlkT3c1V3ljeHh5clRkNFZpblZxYVBI?=
 =?utf-8?B?MklEeDFPSXA2YjA0VjhTdm9GN1lkOGNnUjJEWStlcGc4ZFI3a0YvbHpmVGxw?=
 =?utf-8?B?K0dSdFJTNm10QzFyUHNuYk8rMzl4a1ArTzJDMWQ3K1VRajQ5R3UwYmg2cW9j?=
 =?utf-8?B?MGtSY2Jmd3VGd3Ztc0ZPVzRpN08zT0lCblArdUdLK1F6MHZrRDNxdXNPQi9P?=
 =?utf-8?Q?zQDMLgwTS7fqEKUTHGd1f1VL9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B429510834CE64A9ABCFFC803B5142C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FStaz0s05flM07Kz3Ckn3Yi6yMNNH7MGs0HAXpgfv28ECPaMouPM998LzMwASvPRYvtEk1KpF3Or8j2seXP2RsyORoVz2PemqIg5+EE3Nt+UGlzM3+xqalcQugasmn6P8DEbwUOpNI+Qh8xtSeWnmOZgYed95rrfUcF6scyG1g7eejd57I4NKgvlIFyHmnCO4Xe1JRsR8H2xnJzaQq0KAABvASTSJHgHEEANcYwx13ONmhuDhB+Ivrwo/FQ+KM9sUe9RNYpo0Zybe2K3+aNRGfWW8Yc8cWOGoHeEJZUsOjd+X52nmX51QbcQY19mVxBvK9O8Rdhizstelcg85Zj90ZpYuRxxxwfxOY5FOAtVBcWzNGXpjdsici6I9fHBrPJGglsiBcSlgLnSTFtV16DtP3AoGW/qS9clB8ub3FQPMArGYXuqcn6vlLkfo6PDqMTA1pxBbCNIYjHZkBViVDw++3emYWtx03JYHObUmh/c7KYT1mA79MwbzYg702dFNU09fIJA9njjJXdNwZfHF7W46cOYyWN8XQuJnig6EplM7NIi6+izoD6pYMbsyDxCgjWeLH/U/7h+vuw0HgY1maFmLB/aI+B/Pzvp8rLkDJPZrJzPjCt0BeQTz1DTj5XaAZW4H3IEpc/+g0OedoGje/OOIA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dbdd72-5752-4d35-ea77-08de3131a62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 23:30:44.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQQkHlwFkXeGbTsAN76VnuPT20mRmEoWVyd54wIqaIntY7ExC3nAIERCQY5R71Tr83xxsOjPKUysA/6QROw9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE4OCBTYWx0ZWRfXxKM265eP8PWy
 fX35ShKiViCMHUl439pz+Bt+nfr3B9fLkZPCnKQnP9Vqx9M6pWuX7r+phSUfHUJVVFbC+E75Vjk
 Ts0n6Brs/WMp1QF/6sbr4rXV/uXaIBA0rhHMxTxJ6OBGMwRBrb9HAi/3T0YdUqQkekbECeZlrJE
 TlWX4X0bH64iQZtQrH11x0pJxIIav/FNSq2w5Aw5oTZAnNBFBv3t+mpS6hpIHUhgSmjha81LbTX
 3K7bGT7lsxhDKDcrqgOMhvAzeZDXum7ZfW5XHK+BDvzwNNw9FicSZ/G63VQfaXjFluWHuU1Mlm8
 Ve6wjbWPH19L9XfQXL2Pa5k9juCgF8x7uu8HVLyKLidsCF6Z0UIq7A+NAtmde66Ed2olAhYTzVa
 WgSsNSoS7z7owEaC0KjbIw+CJgrTLw==
X-Proofpoint-ORIG-GUID: dTjHWw7jL-n2xa5Y_7o9tDwo_M-y3iO7
X-Authority-Analysis: v=2.4 cv=U9yfzOru c=1 sm=1 tr=0 ts=692e252a cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8
 a=ubDrIgZHGS7N4OV453YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dTjHWw7jL-n2xa5Y_7o9tDwo_M-y3iO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512010188

T24gV2VkLCBOb3YgMjYsIDIwMjUsIFVkaXB0byBHb3N3YW1pIHdyb3RlOg0KPiBPbiBzb21lIHBs
YXRmb3Jtcywgc3dpdGNoaW5nIFVTQiByb2xlcyBmcm9tIGhvc3QgdG8gZGV2aWNlIGNhbiB0cmln
Z2VyDQo+IGNvbnRyb2xsZXIgZmF1bHRzIGR1ZSB0byBwcmVtYXR1cmUgUEhZIHBvd2VyLWRvd24u
IFRoaXMgb2NjdXJzIHdoZW4gdGhlDQo+IFBIWSBpcyBkaXNhYmxlZCB0b28gZWFybHkgZHVyaW5n
IHRlYXJkb3duLCBjYXVzaW5nIHN5bmNocm9uaXphdGlvbg0KPiBpc3N1ZXMgYmV0d2VlbiB0aGUg
UEhZIGFuZCBjb250cm9sbGVyLg0KPiANCj4gS2VlcCBzdXNwaHkgZW5hYmxlZCBkdXJpbmcgZHdj
M19ob3N0X2V4aXQoKSBhbmQgZHdjM19nYWRnZXRfZXhpdCgpDQo+IGVuc3VyZXMgdGhlIFBIWSBy
ZW1haW5zIGluIGEgbG93LXBvd2VyIHN0YXRlIGNhcGFibGUgb2YgaGFuZGxpbmcNCj4gcmVxdWly
ZWQgY29tbWFuZHMgZHVyaW5nIHJvbGUgc3dpdGNoLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gRml4ZXM6IDZkNzM1NzIyMDYzYSAoInVzYjogZHdjMzogY29yZTogUHJldmVu
dCBwaHkgc3VzcGVuZCBkdXJpbmcgaW5pdCIpDQo+IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBVZGlwdG8gR29z
d2FtaSA8dWRpcHRvLmdvc3dhbWlAb3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIHwgMiArLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgICB8
IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDMyMTM2MTI4ODkzNS4uMzRjNWE0ZGU2MTJlIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ4MDQsNyArNDgwNCw3IEBAIHZvaWQgZHdjM19nYWRn
ZXRfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWlmICghZHdjLT5nYWRnZXQpDQo+ICAJCXJl
dHVybjsNCj4gIA0KPiAtCWR3YzNfZW5hYmxlX3N1c3BoeShkd2MsIGZhbHNlKTsNCj4gKwlkd2Mz
X2VuYWJsZV9zdXNwaHkoZHdjLCB0cnVlKTsNCj4gIAl1c2JfZGVsX2dhZGdldChkd2MtPmdhZGdl
dCk7DQo+ICAJZHdjM19nYWRnZXRfZnJlZV9lbmRwb2ludHMoZHdjKTsNCj4gIAl1c2JfcHV0X2dh
ZGdldChkd2MtPmdhZGdldCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3Qu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+IGluZGV4IDFjNTEzYmY4MDAyZS4uMGMxNzEx
MThiZDU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiBAQCAtMjIzLDcgKzIyMyw3IEBAIHZvaWQgZHdjM19o
b3N0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlpZiAoZHdjLT5zeXNfd2FrZXVwKQ0KPiAg
CQlkZXZpY2VfaW5pdF93YWtldXAoJmR3Yy0+eGhjaS0+ZGV2LCBmYWxzZSk7DQo+ICANCj4gLQlk
d2MzX2VuYWJsZV9zdXNwaHkoZHdjLCBmYWxzZSk7DQo+ICsJZHdjM19lbmFibGVfc3VzcGh5KGR3
YywgdHJ1ZSk7DQo+ICAJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoZHdjLT54aGNpKTsNCj4g
IAlkd2MtPnhoY2kgPSBOVUxMOw0KPiAgfQ0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1i
eTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpU
aGluaA==


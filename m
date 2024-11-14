Return-Path: <stable+bounces-92969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6B79C7FAA
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 02:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E1282069
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1151C3F02;
	Thu, 14 Nov 2024 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VJSPMR6F";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GrNwBTXj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e1P79vtm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E61C3045;
	Thu, 14 Nov 2024 01:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546152; cv=fail; b=mobfGOFa2fgC8N8F4/NVRxfGu9jlQ4SDv17b9CGi5320BVFNmWIDHBcNFfagsaaLUxi2CMRMBhPOw0XDZifMZ8ZZJ6gS8OUfQYW7ttWn4uXbrrX/CZjeKWfuDLRhva7HXec46sEIx02yLvbk4NMkdLrFNcL2SLurxjVdBQWzMfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546152; c=relaxed/simple;
	bh=iyjSWeyHKgmn446zlVIp9RUghsXQBwOc70mz8065Z30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u9c4AWnR+ISH0V3B+xJAyu2+rPDLo30NmxYpGDNMMPQPSsud0g80rdEe7VX3yYbcFRbkfndeTTFq0qZtWhWpN668/r2BUFTh8mLyBBEM5Ce4XNOThDnQQ09lPG6yIkpefzQ42scYJ20pTFTA62FootyGH4PZHEOrCCz8P3G8/+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=VJSPMR6F; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GrNwBTXj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=e1P79vtm reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADMc6sK016901;
	Wed, 13 Nov 2024 17:02:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=GqL8/oKnzCuF2Z3LGMS2Iq4ItonGZ5ovjU5dzrsFR00=; b=VJSPMR6F3lQ+
	ABnZUi/a1s4UEBs4lYXQASN8qaxq9Jblcj7NLezVEaWwrHAih3Vikwi2k+CGnAub
	Pczi2RV2QYsyZszaShRu34oh2gCuJW4JvnOM7YTCXlTAu4bx2vXpN1LPJ0lv2A68
	XL/aa92+zR5n5b9UZkw/o8btFeMHpCAa97IXMM1fASYliLN7j3V/M5KOaXHzxxEb
	4aZW/e+TeAFSkjJUohI18xLgiFOBvCi5c7/2dsr3Z4UahsFQLoWImBeJPPT8sbxP
	I/AlFQCu7W3qlHRRciL2HE/xtYZyW6bXVKhtCgfNoRh9Y3I9OOX0A5upP8yp7ULW
	/U1nbmjSrw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42w52s8h9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 17:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731546141; bh=iyjSWeyHKgmn446zlVIp9RUghsXQBwOc70mz8065Z30=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=GrNwBTXjgs4RVYQqtV9L4KtFsWV2ZxcpI64ousX+lOgi5bdDOhwBlC1Uw51ynSXhB
	 4GnH+1PoD/XlbJrE0Pof+V0KCj0VXhxgEdZh80oA9h/cOCA8CVBLSQJksj1qrukmBH
	 41yaJsmm6InYD5oMkUMbEcnnunKsE7FVUxxWxXfSvdZV1o//f2ByS0KGMN0ZXrUERl
	 ZyxaBCRdzzccJxz62Pjk+fU3ZDlWsS9W4PCGWem7k6hc6KPB2boP5X5mANHjpaefcW
	 MwXmKL8/Hy4IEw2epS2JctAkMdBhmxHFgd4D9yfHmfCDZJL5dgegy4MZJVkZ1ZnhwH
	 HqtnMHI8xNJag==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CA631401F8;
	Thu, 14 Nov 2024 01:02:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B7AE5A0082;
	Thu, 14 Nov 2024 01:02:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=e1P79vtm;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8C0CA40424;
	Thu, 14 Nov 2024 01:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVRqiNnP+mB6H3lfz3KCO4bHP73t5ZwHzAjB3G0p/vhMS04hJfA+PO+8br+FiWE0Rx0SM5ZmBep//nvgSC0rXdyC0dul6rL/hO92Itg9hNdmbgUqOZai6JJNdVd0W8RvP4DnOQMqkAl0Bo4wAoDLstURRCh4Aj12z7KVAH/oIm7KHcqRPAV+AZabPu4FlQNdxen38U3MwFLFB68xtKgDfQgNcpiPS7ObUp+RWf4/r+h9+VYLzWV2HKyvNE1oheo5XoS4CH0Hk6r4bsDQEuh/id2o+W6ibeazjhH/NWsVy3CajA4ilV5wQmLg2cLUZ0rpX6ljMxryVcLxQYsYl4NbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqL8/oKnzCuF2Z3LGMS2Iq4ItonGZ5ovjU5dzrsFR00=;
 b=Q/rwih5WhW/X0ymLQLbeXom5w7LwKjfz33FR+CB0fT8wGWsMpmpIVWUtdPShWjeNAIlyAOKqyjzP3iQDfkQ20fFFlUdoekaStADfTu3fER1g0LZlpJ/0Yo/P5AikN6q60qlCrsL2+PfWOd52VRa7gQdfuj6hsQAPAkFaYEq+HyKpf9qfBoasm5SbF/wT37lRD1HJRnldJMqWPv0WilEVxzwMjhwAsmxy7VZGGoQRZddo2MQnDnlEE9v2TLPjN/DzPQRZhsRHUVCC9mJDxYSuaqtqQ6RUToEaXQhUSE6PKobjqrSg2VV3fCFHFh7Tpb/c55N83UKK6CkmS6uFTidFUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqL8/oKnzCuF2Z3LGMS2Iq4ItonGZ5ovjU5dzrsFR00=;
 b=e1P79vtmKks+3BHRfl+6HVCueweNnde+Qe6DK4JoWI0gzNWFOsytEDT5//NNrOIm9YPttU3aHUyt7yZJYTpRuwn+4l3z4yTWKfsQjTyJovNhj5epO8QcVNdwPhReq1A5ns5FDSG8wRL75sMRm+2bVTHBWcrvSBy2xC2FdBWw35A=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 01:02:18 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 01:02:18 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 3/5] usb: dwc3: gadget: Fix looping of queued SG entries
Thread-Topic: [PATCH 3/5] usb: dwc3: gadget: Fix looping of queued SG entries
Thread-Index: AQHbNjDaKoOF76BebUSIN2kMbnoZ1Q==
Date: Thu, 14 Nov 2024 01:02:18 +0000
Message-ID:
 <d07a7c4aa0fcf746cdca0515150dbe5c52000af7.1731545781.git.Thinh.Nguyen@synopsys.com>
References: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1731545781.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7950:EE_
x-ms-office365-filtering-correlation-id: 255f6e3b-316f-4c39-9cdd-08dd0447fcca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?f/tFAhgYS3PtJIgZQr7Nv6RhH3Zn8JjKPEB/ZJOkT0kOqQj9F2WB6c0tf9?=
 =?iso-8859-1?Q?4gNdJxHYoiM8CLC1I6kEUwDYCBxEC8tn5UJFljQ0/3iPfUD382iAuVK3pg?=
 =?iso-8859-1?Q?UxCLmVtd/GBjuaa9NGX96j0MrX7sggK86+v9EqJ3TjIBJxwf4D56uxrirR?=
 =?iso-8859-1?Q?UrtHlufdnPC48iUJaeFfqePQSwZCDgNO59AzjmZE9G9QagHWYrqe9U5DKl?=
 =?iso-8859-1?Q?eAWyVtVw1V7HCdvFN+7aGJg2HDky1mmRmRsSclEibb1mR32bT/MItI8vwM?=
 =?iso-8859-1?Q?vHs/cjRLrTxk9jk/FudgGIamXRkXbe0SLRePeSV+B6h4ZLqdIoY3GVuOhV?=
 =?iso-8859-1?Q?AVfes5XdA0Tb8HeVjYg5Fek/grn7Tr7baMQUsvy8tovvuBJjR/4TDMxTl/?=
 =?iso-8859-1?Q?lK7AeAXOfgPEvfbhqShjWE5Q0woaL5RKW65VCJYG7n7GIGWquUa9tQNicQ?=
 =?iso-8859-1?Q?02Vtlu79/kIUcrO4EESZprf3rKOQ8mx/QPkIS60pbDhxGUHL7BHS+gCJ3/?=
 =?iso-8859-1?Q?fNSnZG2JIGqOsFW2Hm2u6rr3j5HjQKcREDsdOK08JG6fsUdYkRboz11h6w?=
 =?iso-8859-1?Q?+8qDuETYwpL2nFcBmEkhm8uD2BZxgXFKK7HB3c0F6fq7rRTNUOUj8weSmM?=
 =?iso-8859-1?Q?1nLKOIjlPn+eYN2xaMpdI+tbrCXJGF/2VPG2JaPBnRSD5SXPypyi0TbX8C?=
 =?iso-8859-1?Q?kvTM5tk77SJmTRZpj6aoLKeOQH0ePtMvZxi88aHrxgDJVA4oxTX596uLrv?=
 =?iso-8859-1?Q?LKsyWJd8odOTuwuR/V2+UgfKziXOSILGJUMYoFDDSLcxCaCNQrmj5ZmJNc?=
 =?iso-8859-1?Q?aa58TxWcN/8pt7PpBCo4A8kQ2l0SM5F7cxSbyXTnX48FAMt9Pm479UobcE?=
 =?iso-8859-1?Q?SJO5PONxm15DfMHzrjmvLccLf/NqFaW5iyAeX5dkiBMkASUlw2+m/ThlJ/?=
 =?iso-8859-1?Q?i41qZ9UxF9WGxz9fiZyOu8qzlqgqephEKlmFlBNfT/VFp5mq7G/JABgiAO?=
 =?iso-8859-1?Q?3728RBH9duKU4R24t6MqBh05NU6KdE2B1qNgkHNBQfkhB8iGY9i1yvdO3y?=
 =?iso-8859-1?Q?NYlwnnRN47KEWeW/8jnmwVJz1oAetEP24jR2rp5dPULPdwZ2x+XdUOLbUe?=
 =?iso-8859-1?Q?CvDFV3hojNrUIldY2AnkfkQQJf/k5wnI7mhQtJu6V1/EMGyDOhKYcyCVUW?=
 =?iso-8859-1?Q?Ww3Y59Muox9CvZckKaoChTVFP0kB03qPvE9KzyQZelAY7z3A3Elk4l3TQp?=
 =?iso-8859-1?Q?c1iVkapBlx6/Xa1kwNRy6eaTPf8jkBfYRT3PuKE1e9GRyAO4x4cLHZ9CaD?=
 =?iso-8859-1?Q?it5U41cihx+CDrp0TQ9NGIu2hr5NhR1waleOFRntUZlUvW3+6pZkOpxLxv?=
 =?iso-8859-1?Q?DWnhi8iOsEZf/R1FXAFlijZ4V1GnR6TJMf+fDAh1xa2Gk+STtX03k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HfYiaIuqFog2Udc5SRyH4Dg1HyAu3SeVg+3AAVoRkIfavUa50kiq4UMeYg?=
 =?iso-8859-1?Q?VOFEsaOJ/cIax9QsAHZBJ/OFqvmMayxDmNJWcD+h8sUCX2REQj/Bdj31uS?=
 =?iso-8859-1?Q?4n6dx5Pa6NF1ulsPgelHAEIc8UiLhWqiB6sQeMfZu6lFLwJIznu+24aufB?=
 =?iso-8859-1?Q?aOfC41nfqwmWkbxDgv2XxASN/838Qwm62eea6+4o9bA1BfF72DRjz5n46s?=
 =?iso-8859-1?Q?zvf8k0qt1kTi6r42NewDJaOnSHJQx7fQvzec+w1diliXpXgash7cJVQKrM?=
 =?iso-8859-1?Q?kJurd7Frm6SgYG7FgvpGT3Jg+ViYOU2xwRQ7vSGQZZiGNihzCQDDlKm1wA?=
 =?iso-8859-1?Q?eJNImrGu/RUCA0q0ei2IxH08eJlY7JXj16OCD+cY/Y2OH2ZJSGUVyDfwq2?=
 =?iso-8859-1?Q?FujUC9ati3H4yRVhbrgOYdZKUZEvIzvJFYkimIvfH4xU7ukP1TX9pXhT0u?=
 =?iso-8859-1?Q?DIvtz2kpXB6IO+x9tqnpL9WWlpdsaAjla3h7dfJPQ7h0gkFruaec7bb1F5?=
 =?iso-8859-1?Q?RhRUhOfyBQ8hY4D1PZnrs38TH5S9emvQBNGgy1bHONT0HUHhwgsKMMpf6u?=
 =?iso-8859-1?Q?+ofFkpsJ31RUW64NoVa/MMeWAoxi0/ahWiqhqg40fQEvkpRbJNm3LiydU/?=
 =?iso-8859-1?Q?wdYBhnPxWBcviWS4LI9gguqZ4W5bgHM50Cwu1WXkQ3ltY1Eb2kAI1Td6FB?=
 =?iso-8859-1?Q?KGhw7CCpsUxN2bx+S8So9VjM/SFPc3e2GF1UKyuPZsUWp/0ml/ufE12FD4?=
 =?iso-8859-1?Q?dNuCZ4QBQKbtQUpXJnqEwCz9pldBSKq29FbxVRuEuz4Rc32VL+sljkMXGP?=
 =?iso-8859-1?Q?0iWASVa5iHEf+KzKIahNWW481A++uosmQuG7eI3j4sxr3RljHTw9c7v2Ax?=
 =?iso-8859-1?Q?aL/q5YSfZ6T2eHy1VpCDl6g2y2aHi5b8fG86XAdAf1N2+1ZwWLJMEAoUrI?=
 =?iso-8859-1?Q?ORP+VMrMhy1IvpUN6Lb2w7Aa29ZaOZBigkOtJ7zHsRvpz2a7/CAFMzmfim?=
 =?iso-8859-1?Q?KoLR4tGtqhYq5eyCv3z7HMEOT5VMHj0eU6pbc6A5i+FPA1oUWXfPFa6AYo?=
 =?iso-8859-1?Q?wqkdqKHmsHQCZPBTUxp/QOkav5UKFBqebmzusOLjx59cCj/bgY0zuH4rdH?=
 =?iso-8859-1?Q?lduGEiaQNDvGxDEm2Y/ZX7at/kqobsFfRQDFJWRHhQb3VeH7SmrN4Iyr4H?=
 =?iso-8859-1?Q?WL8rB5Fd1QrwVpqgzNQ31r8+NvBsZeuAiEAG7o+jrXRcv/KKW+96wQ+Lq9?=
 =?iso-8859-1?Q?/AK/fWvGtUb7OLqdL2gJGava6HP4HAC8kj4MEAeaKQX8tLTtHRJZAUcYTy?=
 =?iso-8859-1?Q?8I4ezScRV6iDKSDdiStPyUhYoznCa6F+5vmDdL0Qyjjo8aG+TfUxKeVBIO?=
 =?iso-8859-1?Q?oxBD7p/KedGH1t3VADQB6zcIL+SHOybJgoFzpzqjJh0kz8f6tvE83EsURm?=
 =?iso-8859-1?Q?nAhm2Maom4ss9O7P17pcmB4Kv3IFBcJsvEbtWzl4gZhgNhFfmLuFVbh9Eb?=
 =?iso-8859-1?Q?1fi3MQlBp6W8uWRRqNn/hGTe/dAF4jV2PlST+ezY1MzqJCiNJy0TfD25aD?=
 =?iso-8859-1?Q?sbZZ20Iqvq6slqpmJiQunVXT82fDgLRaidMOabLaGFcUCmi5M154HAxhLx?=
 =?iso-8859-1?Q?hWim6EKPBTF6Szv6d3k7J63lOorQ4OxV4N?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GNKOFYQ0Y7PrHiP5Lu4+r0TODrSoxvzWCCmcW4923BxyETLSi3sRca4oAULho5kftzo04meZYZ0EF/7IBaTR4bB5KYf8PElt8wcwftu/LRAlnuABPPHBUcT94gALj1uyuXaXinJHpeuMqiYSDo6mIH34jPlonRFqpW0K/Bxh9Cmdk1FLnUanKmieIEROXiRMP7HX4TQqvDgtBIIiNwbTUmrTdsmURZH07aBsHAVBrp6UPXLU39myZccaR69EMX8OzPf+hKRVCHBRL90DWXqxfNyX9WAnRgBgntMc4vKVQ7gjfYuQar+SMH1Y852uggfoyOtpEfFCRgy8461svzf4aheXuMQ8OqY22+kN0fqjLhnyw/HjHHFAQ3LA7GUZy5GX083WG9HEIF0c0g6u4Hs/ouJgaZoz4WT2L7KoPfNr1zyhGAC5NWaW63wbVCrmBtYufmmmarOZNihnDBQJ+1SnXnhRqjUlsRIC/j5hAKv7tcO/74of9ocBawUNAFfPYnu7uEDhGGQR4srtZZw6dOdBJf4vrh5QSn+JxWvU4brUbvlRhDtsUVHLI8PUVpK8f96IB1UdpAVeD2sTMiTx8APGkPqCVjlXAYX/PwnUf44/ZjbE5WVfDoS9ebA0q05Mz4Sjz2Ay6apEveSuZFzBgbF4Cg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f6e3b-316f-4c39-9cdd-08dd0447fcca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:02:18.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ8Eo1/0pIuopUHibh1Za69ETGVF7GfaPuTVAP9Lu/Z7RH2NqolXAe7yhx4H2KB+EvELEUh17lRRXSMYUhBiYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
X-Authority-Analysis: v=2.4 cv=UvMxNPwB c=1 sm=1 tr=0 ts=67354c1e cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=G-WRxraSjgDgK3-KZ7kA:9 a=wPNLvfGTeEIA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: 0F8NQY8sLdZpGYkm0VmQS6CUu3j2YFyu
X-Proofpoint-ORIG-GUID: 0F8NQY8sLdZpGYkm0VmQS6CUu3j2YFyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=919 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140005

The dwc3_request->num_queued_sgs is decremented on completion. If a
partially completed request is handled, then the
dwc3_request->num_queued_sgs no longer reflects the total number of
num_queued_sgs (it would be cleared).

Correctly check the number of request SG entries remained to be prepare
and queued. Failure to do this may cause null pointer dereference when
accessing non-existent SG entry.

Cc: stable@vger.kernel.org
Fixes: c96e6725db9d ("usb: dwc3: gadget: Correct the logic for queuing sgs"=
)
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 38c3769a6c48..3a5a0d8be33c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1470,8 +1470,8 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 	unsigned int length =3D req->request.length;
-	unsigned int remaining =3D req->request.num_mapped_sgs
-		- req->num_queued_sgs;
+	unsigned int remaining =3D req->num_pending_sgs;
+	unsigned int num_queued_sgs =3D req->request.num_mapped_sgs - remaining;
 	unsigned int num_trbs =3D req->num_trbs;
 	bool needs_extra_trb =3D dwc3_needs_extra_trb(dep, req);
=20
@@ -1479,7 +1479,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	 * If we resume preparing the request, then get the remaining length of
 	 * the request and resume where we left off.
 	 */
-	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
 		length -=3D sg_dma_len(s);
=20
 	for_each_sg(sg, s, remaining, i) {
--=20
2.28.0


Return-Path: <stable+bounces-223391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKYbBCNKq2mzbwEAu9opvQ
	(envelope-from <stable+bounces-223391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C6222812A
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09F6830048FF
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37518336EF1;
	Fri,  6 Mar 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TIp3xR4j";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K4zqMAfG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nCb3z0h4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97E7E0E4;
	Fri,  6 Mar 2026 21:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833312; cv=fail; b=D8/GqgEricI/beZRpOVjK/0B/j+ONjrbWzcKFIDidxvjLdyUOLHUAy3tVE78kRVntcq4gqtesyEt8xUjAApoyBhqVqNBa8Aw8QK/DYhWAH3YvgwvqKJCxFkEUvfSWALIEj+iZOXBTWfH8WWB/nqNMXIzDSMsStdhpsqwFdtl18A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833312; c=relaxed/simple;
	bh=qpcc83BIqG4OhnUZmp0bYWjybQIBmjOI5X7DktSs+Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b9scp0EdLlHQnuZg4iji1yjpEJSZ1JeH9TNo5+aVBR925ksErKZr5H+PMHEF0HYtBun2RjgJIydIVb7QIFff01qVNHz38V/r2yVX12dhfKGoicE5FqtTdtXvIxc1ojSHv51oPeQjJEaxR+MybW+gV7imoRyYOMA+WTayr+s2QvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TIp3xR4j; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K4zqMAfG; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nCb3z0h4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KcKn9697160;
	Fri, 6 Mar 2026 13:41:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qpcc83BIqG4OhnUZmp0bYWjybQIBmjOI5X7DktSs+Q8=; b=
	TIp3xR4j7c1Kr0GalqkwCuVu/p//scnTKcdKv8nn8W33bZEFfFzFpZNUPHizgPdf
	OdrZbv6zm2w4RpWkQq+52su6Qp7Uy4/O6WXwmEi5V8OEklev7tah4bPcPkhVqjX7
	hHbPixMlsTWlx3OPamb/Vv3mzXWtDxbI+68cFNyL27/DdkyBqoNPB9BCCie+qVfw
	yow3zNW4GQlZHxqAeXdn1U2MVr9eDHy5l1jmHsJVNxsgOYqTb4LoZi6MDjPmdPy/
	vfovJthkui05b5N3J6by3bytGKylMculsKqKH0m1wqac595UQsCRw+3XAYi26iEB
	0W2S5UlaUrR/IfdFWBnVJA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4cr2yqhnu0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 13:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1772833296; bh=qpcc83BIqG4OhnUZmp0bYWjybQIBmjOI5X7DktSs+Q8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=K4zqMAfG9zKvF9/JuCFYjrqLI8yLxTydAPCfz3PzlPETmqhP2V+6RnFd2Fu7VeCqe
	 ZpCDshQ51CUhahi7JuIDmu6BI9rXZJZ65HIJJ1IEzpbi54Rs1f7LmAYYZz1aoBvc+j
	 b4d5lqp2AEuAmRhhChp7+YlBG4nN1IvndHjzE0EQnOHNQhGFsIOqn50g6vIKrRaL2l
	 poHyuMD0GTl+FZT45Tx+D+bxeUmiYuvEHybgvrRPw4hAPQJZA3qsEzoTlzywB5GOSF
	 J5A3URGnu8bjSBch2IFvltI4QLcmjitIoHGMhjnxH61U0WCxGx+sxdwxWHSupxLwTR
	 6WpY6RoulDC6A==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 10B9240793;
	Fri,  6 Mar 2026 21:41:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BF784A0158;
	Fri,  6 Mar 2026 21:41:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nCb3z0h4;
	dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com (mail-bn1pr07cu00304.outbound.protection.outlook.com [40.93.12.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 035E522010B;
	Fri,  6 Mar 2026 21:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pmd4jYt9KpObz0MxalvcZncxYmz/zhFObIdI/pz034JOq60LJyV/oHcvR75MHsq6jggbZWESdXsuW4ynr5yLLIQS8LE7Tbb/i0uc7xq83gs2/nI3PtToYyq1Pe2fZjvZVO1yws+CUAiNUhPaPtSdg5v68sYUeVIqmIOm/48ppRODeRNieg2rvqaFJhtN+SIInbqzJGq69Z+6SYi/4HDhSXohpANkNjQ3b+zihD/cqH8Ymt+E5iioD9wPZNfTSCbsKlWevxU0pA2n0kP0qKmoh4I8nPfb8uoi6yyH3OUAymWd1mfP4QCILhFqQUKgc2Npe8g1a8sTMLzoXGyvSvORbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpcc83BIqG4OhnUZmp0bYWjybQIBmjOI5X7DktSs+Q8=;
 b=Xu56inblH2Kru5ey6i7MaE8hefLtJ8eSRj4RV5sBXG0PwuZOE6oqTb742pSwdAQwKvnVLl+WG3Ojiu8/Ki4hHWdYC9Gp9XmXzvN5lSkEbo/C5pPHlb0bI9DBUKtV5ZTlM3zJO7hxe5Ia5QGt6OwV50vVL8z1KmhFMOhi0BUJOIGeG3eG7abktkH5UG1jLnIAwAoD5hNt6fVlUjrKzKEQyYFJpuh/RkuSNw7RWZlfzl34VszPrCMKBAcn37lC7YsA1YXz2AtBQk/QCyTVYUuVx0XkYNF97jHqU/MbRdw5KnBfn2gi9E2lg4HglHdIuumHqH8l2+X9F1e/2NVVhA5mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpcc83BIqG4OhnUZmp0bYWjybQIBmjOI5X7DktSs+Q8=;
 b=nCb3z0h4DeZ5AwgYoTb9r+tw/mogBmJh8S6Wyv68xBSQo8IAfVn6VOl7WEY9kjB6YN309M869HLYCF5z+mOfb4J2flbsRfGpG7QgLf6kX7hbJiFeNN9lVty8C9FyI/cs/z/ce9UbXcpbHOsgbhmcELwS+YQ0YgVJWlyjilWMmfk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 21:41:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 21:41:28 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index: AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYCABYeXgIAAj9uA
Date: Fri, 6 Mar 2026 21:41:28 +0000
Message-ID: <20260306214123.3jnlzd2tmtwggch2@synopsys.com>
References:
 <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
 <20260227121236.963-1-selvarasu.g@samsung.com>
 <20260228002711.e442cuxwld4s2f66@synopsys.com>
 <20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
 <08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
In-Reply-To: <08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6601:EE_
x-ms-office365-filtering-correlation-id: 240ccc39-dba5-4839-9744-08de7bc91f8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 oH4I3h0eRUrvgGVKK9neK3qr1pYuqIbyWLpiaPstJdqTppF+/ZocKDV4e+vnT9zfqOWk7bp8W16MI2poHQ/42wq080tw0GOsR7VCu2qdnj9AC7TZdMZnSh1dM1i6wltQ7cn4UBN+68XTh3dVGzRkogVYd9w4D59qUi1KaKnad/mJ2cpYjMVwdsmwvSHaBEXsoKL1TfABPnq3N0tZmWLqY79tocuU6ytNwnd+mvu3yQCkhrEY8QGsf68TfQ8RIFQJhS4babDapGGcAy1URHf2cn95+SJfJi2whj3Dvllj641YY617FxcMY4VjY0lzF8f4Zj2HcHQb1tDS/Y1psmx6OSzZJIroCFONVHVJSl2ZuT1BrFvIofHvIhLFMeMLpcjHnK2BneULRNFWA15Q5KNlakaUAJQw530Arg6XTjKkkm4vKA87+Veemim0J+ZnBxNzOc43sjhpZQSnqTuq8W1p3ZQMtUML3GEfDV/0zm7bDavESqEHAnOUmmPRQZivTnXz2NoDo0ILM/AOwNGHX1qjY+UfTt6Xew6txHdXkIC6gZfgkeHvbceMI6Y4/zfo5SFM1YzfkWLO+pmqpXDdTIi8Oc0FvVncvtnoJ8mBaE+4AClgDD4+kLp6TN+E1XGPm5x51PqRAztNJ1zExQJF4Tyu36KwgEcrFjfLHkBWOCfba8izcF1H/WWco6uhCG7AdHQ+nBLi6WB0Cls0dH3VZWDluFsU9AgNvpmx0GME8yWHjNI74985jEm7Lz36b0A/RDN8INTNO5gJJkQNVcLH0HMU/3ppPEBxFWIHTggpBp5mYEQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVZYNk1ZVW5VOXBmUGNJYXhwWDFWdHd1VGhtYnJ1QTMxc3lWOS81dUlaRlg5?=
 =?utf-8?B?ckdMd2tLL1o5L0ttcW1qWGZ2Z1UrbTFYOHRhai9Hc2g5UGpjclgwSE5NNjF1?=
 =?utf-8?B?QmtiREF6MGwrQWFRQkVLZDVmY1ROeEp2NWorWDZPUUIxbHRlRXZoWWlpVmdj?=
 =?utf-8?B?UXJwL0k3RWRUY2R6bXMxMVpuRDBKcGpITUhGaTJERmZHVWtpMitCK2NsWXFq?=
 =?utf-8?B?VTdZOHNTenVYNWI3eXVyZFhnd1l4MVlOaVArNUJ0d20wVmVZZGlmSU0xSkhR?=
 =?utf-8?B?Z0tkaDNIS0lYQjRrSUZ5aU5oYTJqazg0eEd4NmVlTWlwZ1J6NWdPSVU5Y0c3?=
 =?utf-8?B?eld1ZFMwS3dydW1lTUhoeFRFOFZteW9zbUJScVVNTDk5TTEvV0NZdm5ZNndt?=
 =?utf-8?B?Ny9PNGRsYW9RVGU3SWJnYTZHdDFYT3RhRjJ0emFXVEpka2Y3Z2FONkVwcHI4?=
 =?utf-8?B?SDFSWVduQTdJOHlncnVIcXBnc0NJOUo5R0puUnA3cnpPZ3dOU3FGWTZQLzZ0?=
 =?utf-8?B?VjRMUjJiWmVzZEtTTjlGamdsUi9qQUFlVytaNkFZb1JkWjV6MjNQVlZwQVlq?=
 =?utf-8?B?YXFtSlN4N3UrUGw3cXFLM1RRcmNXSXo2R256R3NhdWUwMUdObDJTeW9CbVdT?=
 =?utf-8?B?YXArbDlQRCtPRXJVejNWRjNaTDBmYTRySjRnVDBkN0xIMllBbVNvNXpha0Nv?=
 =?utf-8?B?cWpSVFJIcFZOM3ZuOWdUa3Y4dm1SSldjeWlibkgyL2doTFh4ci9rbkdydGNB?=
 =?utf-8?B?VmdaNHllTEs4NTJBTWdCL1MwdWo3WnBmOVBBN1lMTW1NSHRTYXdNeUlVYlVJ?=
 =?utf-8?B?SVBlMEp5V3BLUzlrTVZFYkxCYk5XeUtYenpMd3ZRbUNTMDdtbXVDcEUvUGow?=
 =?utf-8?B?MDlhZ0p5TjBDNWIydm5FZ0dqVFcxWGxjUUJkMDRLU1hXTEsvaHFPcnU4d0VE?=
 =?utf-8?B?YzJKQ2lZMmdHNFFzTUUyNnkvZnpjQ055WjZ0anVLcE1ESmp4cWNpVTdvUkpq?=
 =?utf-8?B?Q0JSQmJUdkRqbmtCd0M3cHFKUEFRRVkyWlVCeTBCcTZ2ZzcwSUVubXcwR1NX?=
 =?utf-8?B?MHVtSFRzTndHZUZxRXJyckNQTHNIalE3YVZGVUVVc25TcWlIU2FkSEcyeTFQ?=
 =?utf-8?B?VnltN3RkRUJlcWlId25YemlWdDArOGI4RkxZWGVZOFJueldoT0o4ZkhEVWtq?=
 =?utf-8?B?Y1JJTERjZlJGUXE1Yko4RlhNc2JPdk1zYU84d1RlSE05TnlhU0sxK3JSZi9D?=
 =?utf-8?B?cWFKZktiekhqcmgxYTdEQklQVUdnMDBuaEd1MHdpMmNoRkJES3RHNnNaRnUy?=
 =?utf-8?B?LzhxbDN5MXVldkhxVnkrUU1YZk0yWkVWVXN5OWpJdytvRjRLNEVlNnlMdG1i?=
 =?utf-8?B?bExKV3g3Vnl6TUlpZklqL0FCMzkvV2pTbGtvY0VaYUF5WVExN2w1amEyRlgx?=
 =?utf-8?B?YTA0bkloYUJ0Tk42dWdMT2J1aWRkeUxCdGFWQ2pib2JtQTdOOXlBc3MrZEg5?=
 =?utf-8?B?ejNiemc0Z0R1VXNVUXJZU1dMRWlJcDdPUktqdzF6RkJ3OXVBVjhMY1YyRFFH?=
 =?utf-8?B?dXpsdzdCZXZoMGwvUll5RkpDd0djS2N3dStpTGd2ZERsRkZzOGNOR0lXSldv?=
 =?utf-8?B?c2xtYWMra3VWQnFKaTN3a0dhUGtOaHgyRTZVTkl1SG80Vy9vMnY4VW1pOFZp?=
 =?utf-8?B?V2dYVVJXR2RJVGc5cGxFdFBMRk9OdzBWZkVCSzdMTGZEd2YrZVF0QkVkOWdD?=
 =?utf-8?B?RDB3ekYvajY5ZDFMQW4zTFlsZEZjalpxU3FKRlpBNFVXUXoyTmdJa3QwTHNG?=
 =?utf-8?B?N2ttUmZFanFLbTJ2YjZWU1lZdnVCS3JRNjFNNUM1NlJvaVV5ZHlRb1U4TElM?=
 =?utf-8?B?Q1IzeDdWdHdrNytrZkRUWnEyRVJOdWdMbWR6SlpwNWpJamxoTWU3SDhYR0w4?=
 =?utf-8?B?QWtuL2JEZUNKUlJQUSswUmJIUlVPRGs3a3JkZTAzeHBVYmU4TEZ6cWFtdUFB?=
 =?utf-8?B?djMvcktEcVdCUzNoMVZoQVpSN2VyRzJXbmVoVSs0L21nSlhOMU1PMkxkY29O?=
 =?utf-8?B?T0QxVEhlaGJGSm4rM0VIaDZ2dFZiSVFva0ZCcS9JL0tOZ1dIZWY1YWpwWW1i?=
 =?utf-8?B?cHBFaHFXU09ZaytoT2ZRUWtNekZmbHNBdFlPSm5NNVFqWTVXM0hmUFJOTkJh?=
 =?utf-8?B?R3gxMUFmWHJFcnpQd0lhTWpPZzBWcHVaVnlYL2lzK2VFdDNIU1phaU1KQ3dy?=
 =?utf-8?B?eTdSME80aFpXMUFVS2hiUXpTcjRHNzBCQXRIai9idk5RTTRSQXBiaWw3MU9H?=
 =?utf-8?B?a0dDSXVuQ3dmTFdpekQ5ZHhwK0ZNNTBmRkgyTWY3a2lZQ2N5Rmpkdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E2654D563F7E42A93977866D762610@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P8+9LM7Au/O1r7/tWuu+BqdSZFoNjLIKOiKSA68E/L/Ow5aWMpFOaWSdzScz9CUDQmGZC1EZ6nLXYgFCa9D66vaF//XAf0Bi7eDQCcT6aERE1mXJUkYkTz8xcz+TKrNIQPNso8+XIFJgnfTX/alhqx8yzrTDKpYAYrrniDTmCrGm9XnfcM/ERboS1wWznMJzMiUIGm6dV78T6OVs1V5P4xCAWUA31MPlWuEfFdmgdC3oUHnHXLk/VOAqji+6CjwS18MHv4fhE6tUYQTWSUZyTrEpF9yL2fjp66mcX2/oTTZgzmACXk87bBPyqPW+c5Bo9eJe5HjZtzpY38PlM1Ja8V9ISdWXJtu/ZjhmganZOfWB+QkPzLJ3/RC9Abgm5B6Op7BO7LRCQj6cU+5M6sSZDXjJ6KAWbxpA57TDdS8r/NDT1pLU9TYdu1TPZ9454VQ3pVGqbchAQG0br4FcmjghuCFawTD7jnBs6Tlzltax2TSoqhGK7y3Pt+WITVsgaDWcBEo2CL7Yqg1DX2CNEi+2fqzH+MKrebrgJ2b8xAFJI6QJMdzW7wcSev84LMx8THREOVExxhAGfny6HjCEJuOmsxc7EKM8It+gV+4bHHKqrlhMgPnbNgNGG+ss7jKjHMPHl0KiiEqyty4vxmbDIpCBnQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240ccc39-dba5-4839-9744-08de7bc91f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 21:41:28.0839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGGvar7dMK+OHq5daViy07380ltDqjmgJcs4UpBTlPKPRX7b13Wyjj2rYm6vljwsYoo8MOcxrllnSeDSBe6j5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Authority-Analysis: v=2.4 cv=SZ/6t/Ru c=1 sm=1 tr=0 ts=69ab4a11 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=oEr_PaEPdCBvtNKmjkIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 81bjRjGjLMGAkypGDJRiru7Z0WUwM5_M
X-Proofpoint-ORIG-GUID: 81bjRjGjLMGAkypGDJRiru7Z0WUwM5_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwNCBTYWx0ZWRfX4ss1Ao3HRlaW
 aFEnf7U64DpNw7nWG8oB2xe6nqW8fXcRH3HZ7J/A+/QcZaPi3NjSG7nF0Hn0CazWiRsY5aDHLM0
 vszAzSt/9PW6jbnfSWsVNbO0lPd2J+OU2YB+9Tboq7k/Tmk0H17SZ4eV+ZmySFKQvGcBYafD0xh
 Lj4DgwMqxB1MpvSC+BkOQTjmHLih8Ov7r3GMT+3tj89S6uJ12q+vzIT7h6aUjjZUmeLHJBOZtAr
 nh52yzYspxu1Rq07lLV5vf/iukBQBL697urGNefDxPYmitq6SrFGqcP570BsgrTym6mnckcVeCP
 dOMzoO6SJ9i2qp5bJ3fKwj/DayqHFCG4RFxIFc9j9doNm9LaFVkXfCsqrbl0bten9982uVbkFLM
 mOeUAB+BDYGCbQmtsvLgYYCJcsZJlBNGET5hZrfIwZEY/mLefvk7Mjiigz3eqMCnneB0eTw7wu/
 KByiG1pRiB9MX3mG8rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2602130000 definitions=main-2603060204
X-Rspamd-Queue-Id: 75C6222812A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223391-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,samsung.com:email,synopsys.com:dkim,synopsys.com:email,synopsys.com:mid,urldefense.com:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gRnJpLCBNYXIgMDYsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
My8zLzIwMjYgNjowOSBBTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFNhdCwgRmViIDI4
LCAyMDI2LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+IE9uIEZyaSwgRmViIDI3LCAyMDI2LCBT
ZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToNCj4gPj4+IFRoZSBiZWxvdyDigJxObyByZXNvdXJjZSBm
b3IgZXDigJ0gd2FybmluZyBhcHBlYXJzIHdoZW4gYSBTdGFydFRyYW5zZmVyDQo+ID4+PiBjb21t
YW5kIGlzIGlzc3VlZCBmb3IgYnVsayBvciBpbnRlcnJ1cHQgZW5kcG9pbnRzIGluDQo+ID4+PiBg
ZHdjM19nYWRnZXRfZXBfZW5hYmxlYCB3aGlsZSBhIHByZXZpb3VzIFN0YXJ0VHJhbnNmZXIgb24g
dGhlIHNhbWUNCj4gPj4+IGVuZHBvaW50IGlzIHN0aWxsIGluIHByb2dyZXNzLiBUaGUgZ2FkZ2V0
IGZ1bmN0aW9ucyBkcml2ZXJzIGNhbiBpbnZva2UNCj4gPj4+IGB1c2JfZXBfZW5hYmxlYCAod2hp
Y2ggdHJpZ2dlcnMgYSBuZXcgU3RhcnRUcmFuc2ZlciBjb21tYW5kKSBiZWZvcmUgdGhlDQo+ID4+
PiBlYXJsaWVyIHRyYW5zZmVyIGhhcyBjb21wbGV0ZWQuIEJlY2F1c2UgdGhlIHByZXZpb3VzIFN0
YXJ0VHJhbnNmZXIgaXMNCj4gPj4+IHN0aWxsIGFjdGl2ZSwgYGR3YzNfZ2FkZ2V0X2VwX2Rpc2Fi
bGVgIGNhbiBza2lwIHRoZSByZXF1aXJlZA0KPiA+Pj4gYEVuZFRyYW5zZmVyYCBkdWUgdG8gYERX
QzNfRVBfREVMQVlfU1RPUGAsIGxlYWRpbmcgdG8gdGhlIGVuZHBvaW50DQo+ID4+PiByZXNvdXJj
ZXMgYXJlIGJ1c3kgZm9yIHByZXZpb3VzIFN0YXJ0VHJhbnNmZXIgYW5kIHdhcm5pbmcgKCJObyBy
ZXNvdXJjZQ0KPiA+Pj4gZm9yIGVwIikgZnJvbSBkd2MzIGRyaXZlci4NCj4gPj4+DQo+ID4+PiBB
ZGRpdGlvbmFsbHksIGEgcmFjZSBjb25kaXRpb24gZXhpc3RzIGJldHdlZW4gZHdjM19nYWRnZXRf
ZXBfZGlzYWJsZSgpDQo+ID4+PiBhbmQgZHdjM19nYWRnZXRfZXBfcXVldWUoKSB3aGVuIG1hbmlw
dWxhdGluZyBkZXAtPmZsYWdzLiBXaGVuDQo+ID4+PiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKCkg
Y2FsbHMgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSwgdGhlIGR3Yy0+bG9jayBpcw0KPiA+Pj4gdGVt
cG9yYXJpbHkgcmVsZWFzZWQuIElmIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgcnVucyBpbiB0aGF0
IHdpbmRvdywgaXQNCj4gPj4+IG1heSBzZXQgdGhlIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBm
bGFnIGFzIHBhcnQgb2YNCj4gPj4+IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKCkuIFdoZW4gZXBf
ZGlzYWJsZSByZXN1bWVzLCBpdCB1bmNvbmRpdGlvbmFsbHkNCj4gPj4+IGNsZWFycyBhbGwgZmxh
Z3MgZXhjZXB0IHRob3NlIGV4cGxpY2l0bHkgbWFza2VkLCBwb3RlbnRpYWxseSBjbGVhcmluZw0K
PiA+Pj4gRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGV2ZW4gdGhvdWdoIGEgbmV3IHRyYW5zZmVy
IGhhcyBzdGFydGVkLiBUaGlzDQo+ID4+PiBsZWFkcyB0byAiTm8gcmVzb3VyY2UgZm9yIGVwIiB3
YXJuaW5ncyBvbiBzdWJzZXF1ZW50IFN0YXJ0VHJhbnNmZXINCj4gPj4+IGF0dGVtcHRzLg0KPiA+
Pj4NCj4gPj4+IFRoZSB1bmRlcmx5aW5nIGZyYW1ld29yayBpc3N1ZSBpcyB0aGF0IHVzYl9lcF9k
aXNhYmxlKCkgaXMgZXhwZWN0ZWQgdG8NCj4gPj4+IGNvbXBsZXRlIHBlbmRpbmcgcmVxdWVzdHMg
YmVmb3JlIHJldHVybmluZywgYnV0IGlzIGFsbG93ZWQgdG8gYmUgY2FsbGVkDQo+ID4+PiBmcm9t
IGludGVycnVwdCBjb250ZXh0IHdoZXJlIHNsZWVwaW5nIHRvIHdhaXQgZm9yIGNvbXBsZXRpb24g
aXMgbm90DQo+ID4+PiBwb3NzaWJsZS4NCj4gPj4+DQo+ID4+PiBBcyB0ZW1wb3Jhcnkgd29ya2Fy
b3VuZHMgZm9yIHRoaXMgZnJhbWV3b3JrIGxpbWl0YXRpb246DQo+ID4+Pg0KPiA+Pj4gMS4gSW4g
X19kd2MzX2dhZGdldF9lcF9lbmFibGUoKSwgYWRkIGEgY2hlY2sgZm9yIHRoZQ0KPiA+Pj4gICAg
IERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBmbGFnIGJlZm9yZSBpc3N1aW5nIGEgbmV3IFN0YXJ0
VHJhbnNmZXIuDQo+ID4+PiAgICAgVGhpcyBwcmV2ZW50cyBhIHNlY29uZCBTdGFydFRyYW5zZmVy
IG9uIGFuIGFscmVhZHkgYnVzeSBlbmRwb2ludCwNCj4gPj4+ICAgICBlbGltaW5hdGluZyB0aGUg
cmVzb3VyY2UgY29uZmxpY3QuDQo+ID4+Pg0KPiA+Pj4gMi4gSW4gX19kd2MzX2dhZGdldF9lcF9k
aXNhYmxlKCksIHByZXNlcnZlIHRoZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQNCj4gPj4+ICAg
ICBmbGFnIHdoZW4gbWFza2luZyBkZXAtPmZsYWdzIGlmIGl0IGlzIGFjdHVhbGx5IHNldCwgcHJl
dmVudGluZyB0aGUNCj4gPj4+ICAgICByYWNlIHdpdGggZHdjM19nYWRnZXRfZXBfcXVldWUoKSBm
cm9tIGNvcnJ1cHRpbmcgdGhlIGZsYWcgc3RhdGUuDQo+ID4+Pg0KPiA+Pj4gVGhlc2UgY2hhbmdl
cyBlbGltaW5hdGUgdGhlICJObyByZXNvdXJjZSBmb3IgZXAiIHdhcm5pbmdzIGFuZCBwb3RlbnRp
YWwNCj4gPj4+IGtlcm5lbCBwYW5pY3MgY2F1c2VkIGJ5IHBhbmljX29uX3dhcm4uDQo+ID4+Pg0K
PiA+Pj4gZHdjMyAxMzIwMDAwMC5kd2MzOiBObyByZXNvdXJjZSBmb3IgZXAxb3V0DQo+ID4+PiBX
QVJOSU5HOiBDUFU6IDAgUElEOiA3MDAgYXQgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYzozOTgg
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQrMHgyZjgvMHg3NmMNCj4gPj4+IENhbGwgdHJhY2U6DQo+
ID4+PiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2Yw0KPiA+Pj4gX19kd2MzX2dh
ZGdldF9lcF9lbmFibGUrMHg0OTAvMHg3YzANCj4gPj4+IGR3YzNfZ2FkZ2V0X2VwX2VuYWJsZSsw
eDZjLzB4ZTQNCj4gPj4+IHVzYl9lcF9lbmFibGUrMHg1Yy8weDE1Yw0KPiA+Pj4gbXBfZXRoX3N0
b3ArMHhkNC8weDExYw0KPiA+Pj4gX19kZXZfY2xvc2VfbWFueSsweDE2MC8weDFjOA0KPiA+Pj4g
X19kZXZfY2hhbmdlX2ZsYWdzKzB4ZmMvMHgyMjANCj4gPj4+IGRldl9jaGFuZ2VfZmxhZ3MrMHgy
NC8weDcwDQo+ID4+PiBkZXZpbmV0X2lvY3RsKzB4NDM0LzB4NTI0DQo+ID4+PiBpbmV0X2lvY3Rs
KzB4YTgvMHgyMjQNCj4gPj4+IHNvY2tfZG9faW9jdGwrMHg3NC8weDEyOA0KPiA+Pj4gc29ja19p
b2N0bCsweDNiYy8weDQ2OA0KPiA+Pj4gX19hcm02NF9zeXNfaW9jdGwrMHhhOC8weGU0DQo+ID4+
PiBpbnZva2Vfc3lzY2FsbCsweDU4LzB4MTBjDQo+ID4+PiBlbDBfc3ZjX2NvbW1vbisweGE4LzB4
ZGMNCj4gPj4+IGRvX2VsMF9zdmMrMHgxYy8weDI4DQo+ID4+PiBlbDBfc3ZjKzB4MzgvMHg4OA0K
PiA+Pj4gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg3MC8weGJjDQo+ID4+PiBlbDB0XzY0X3N5bmMr
MHgxYTgvMHgxYWMNCj4gPj4+DQo+ID4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+
Pj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcu
Y29tPg0KPiA+Pj4gLS0tDQo+ID4+Pg0KPiA+Pj4gTm90ZTogTm8gRml4ZXMgdGFnIGlzIGFkZGVk
IGJlY2F1c2UgdGhpcyBpcyBhIHdvcmthcm91bmQgZm9yIHRoZQ0KPiA+Pj4gZ2FkZ2V0IGZyYW1l
d29yayBpc3N1ZSB3aGVyZSB0aGUgZ2FkZ2V0IGZyYW1ld29yayBjYWxscyB1c2JfZXBfZGlzYWJs
ZSgpDQo+ID4+PiBpbiBpbnRlcnJ1cHQgY29udGV4dCB3aXRob3V0IGVuc3VyaW5nIGVuZHBvaW50
IGZsdXNoaW5nIGNvbXBsZXRlcy4NCj4gPj4+IEEgcHJvcGVyIGZpeCByZXF1aXJlcyByZWZhY3Rv
cmluZyB0aGUgZnJhbWV3b3JrIHRvIG1ha2Ugc3VyZQ0KPiA+Pj4gdXNiX2VwX2Rpc2FibGUgaXMg
aW52b2tlZCBpbiBwcm9jZXNzIGNvbnRleHQuDQo+ID4+Pg0KPiA+Pj4gQ2hhbmdlcyBpbiB2MzoN
Cj4gPj4+ICAgLSBSZXZpc2VkIHRoZSBjb21taXQgbWVzc2FnZSB0byBkZXRhaWwgdGhlIHJlYWwg
Z2FkZ2V0IGZyYW1ld29yayBpc3N1ZQ0KPiA+Pj4gICAgIHBvaW50ZWQgb3V0IGJ5IHRoZSByZXZp
ZXdlci4NCj4gPj4+ICAgLSBNZXJnZWQgdGhlIHR3byBmaXhlcyBmb3IgdGhlIHNhbWUgZXAgd3Jp
bmdpbmcgaW50byBvbmUgcGF0Y2guDQo+ID4+PiBMaW5rIHRvIHYyOiBodHRwczovL3VybGRlZmVu
c2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjUxMTE3MTU1
OTIwLjY0My0xLXNlbHZhcmFzdS5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFjUXpRUTVr
QVdGNkNFNWhRZTdWcUZkbmF4cXd6c1RCMVpHTlQxR3ZDSDI4R29CX25FU1pSNVkyanR4ZFpCbHM2
d0JJTTRPdHB2RzRkU2F5bHZOQzNxYmg1NDdrJA0KPiA+Pj4NCj4gPj4+IENoYW5nZXMgaW4gdjI6
DQo+ID4+PiAtIFJlbW92ZWQgY2hhbmdlLWlkLg0KPiA+Pj4gLSBVcGRhdGVkIGNvbW1pdCBtZXNz
YWdlLg0KPiA+Pj4gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI1MTExNzE1MjgxMi42MjItMS1zZWx2YXJh
c3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0RjJSOUdfcGchY1F6UVE1a0FXRjZDRTVoUWU3VnFGZG5h
eHF3enNUQjFaR05UMUd2Q0gyOEdvQl9uRVNaUjVZMmp0eGRaQmxzNndCSU00T3Rwdkc0ZFNheWx2
TkMzOHotQ1JENCQNCj4gPj4+IC0tLQ0KPiA+Pj4gICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgMjIgKysrKysrKysrKysrKysrKysrKystLQ0KPiA+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMjAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
Pj4+IGluZGV4IDBhNjg4OTA0Y2U4YzUuLjNhZjFiYmZlM2Q5MmIgMTAwNjQ0DQo+ID4+PiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+ID4+PiBAQCAtOTcxLDggKzk3MSw5IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dh
ZGdldF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGFjdGlvbikN
Cj4gPj4+ICAgCSAqIElzc3VlIFN0YXJ0VHJhbnNmZXIgaGVyZSB3aXRoIG5vLW9wIFRSQiBzbyB3
ZSBjYW4gYWx3YXlzIHJlbHkgb24gTm8NCj4gPj4+ICAgCSAqIFJlc3BvbnNlIFVwZGF0ZSBUcmFu
c2ZlciBjb21tYW5kLg0KPiA+Pj4gICAJICovDQo+ID4+PiAtCWlmICh1c2JfZW5kcG9pbnRfeGZl
cl9idWxrKGRlc2MpIHx8DQo+ID4+PiAtCQkJdXNiX2VuZHBvaW50X3hmZXJfaW50KGRlc2MpKSB7
DQo+ID4+PiArCWlmICgodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXNjKSB8fA0KPiA+Pj4gKwkJ
CXVzYl9lbmRwb2ludF94ZmVyX2ludChkZXNjKSkgJiYNCj4gPj4+ICsJCQkhKGRlcC0+ZmxhZ3Mg
JiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpKSB7DQo+ID4+PiAgIAkJc3RydWN0IGR3YzNfZ2Fk
Z2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiA+Pj4gICAJCXN0cnVjdCBkd2MzX3RyYgkqdHJi
Ow0KPiA+Pj4gICAJCWRtYV9hZGRyX3QgdHJiX2RtYTsNCj4gPj4+IEBAIC0xMDk2LDYgKzEwOTcs
MjMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gPj4+ICAgCSAqLw0KPiA+Pj4gICAJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0RF
TEFZX1NUT1ApDQo+ID4+PiAgIAkJbWFzayB8PSAoRFdDM19FUF9ERUxBWV9TVE9QIHwgRFdDM19F
UF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gPj4+ICsNCj4gPj4+ICsJLyoNCj4gPj4+ICsJICogV2hl
biBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKCkgY2FsbHMgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSwN
Cj4gPj4+ICsJICogdGhlIGR3Yy0+bG9jayBpcyB0ZW1wb3JhcmlseSByZWxlYXNlZC4gSWYgZHdj
M19nYWRnZXRfZXBfcXVldWUoKQ0KPiA+Pj4gKwkgKiBydW5zIGluIHRoYXQgd2luZG93IGl0IG1h
eSBzZXQgdGhlIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBmbGFnIGFzDQo+ID4+PiArCSAqIHBh
cnQgb2YgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQuIFRoZSBvcmlnaW5hbCBjb2RlIGNsZWFyZWQg
dGhlIGZsYWcNCj4gPj4+ICsJICogdW5jb25kaXRpb25hbGx5IGluIHRoZSBtYXNrIG9wZXJhdGlv
biwgd2hpY2ggY291bGQgb3ZlcndyaXRlIHRoZQ0KPiA+Pj4gKwkgKiBjb25jdXJyZW50IG1vZGlm
aWNhdGlvbi4NCj4gPj4+ICsJICoNCj4gPj4+ICsJICogQXMgYSB3b3JrYXJvdW5kIGZvciB0aGUg
aW50ZXJydXB0IGNvbnRleHQgY29uc3RyYWludCB3aGVyZSB3ZSBjYW5ub3QNCj4gPj4+ICsJICog
d2FpdCBmb3IgZW5kcG9pbnQgZmx1c2hpbmcsIHByZXNlcnZlIHRoZSBEV0MzX0VQX1RSQU5TRkVS
X1NUQVJURUQNCj4gPj4+ICsJICogZmxhZyBpZiBpdCBpcyBzZXQsIGF2b2lkaW5nIHJlc291cmNl
IGNvbmZsaWN0cyB1bnRpbCB0aGUgZnJhbWV3b3JrDQo+ID4+PiArCSAqIGlzIGZpeGVkIHRvIHBy
b3Blcmx5IHN5bmNocm9uaXplIGVuZHBvaW50IGxpZmVjeWNsZSBtYW5hZ2VtZW50Lg0KPiA+Pj4g
KwkgKi8NCj4gPj4+ICsJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQp
DQo+ID4+PiArCQltYXNrIHw9IERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCj4gPj4+ICsNCj4g
Pj4+ICAgCWRlcC0+ZmxhZ3MgJj0gbWFzazsNCj4gPj4+ICAgDQo+ID4+PiAgIAkvKiBDbGVhciBv
dXQgdGhlIGVwIGRlc2NyaXB0b3JzIGZvciBub24tZXAwICovDQo+ID4+PiAtLSANCj4gPj4+IDIu
MzQuMQ0KPiA+Pj4NCj4gPj4gQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCj4gPj4NCj4gPiBPaCB3YWl0LCBkb24ndCBwaWNrIHRoaXMgcGF0Y2ggdXAg
eWV0Lg0KPiA+DQo+ID4gVGhpcyB3aWxsIGNhdXNlIGEgcmVncmVzc2lvbiBmb3IgVUFTIGRldmlj
ZS4gV2hlbiBzd2l0Y2hpbmcgYWx0LXNldHRpbmcNCj4gPiBpbnRlcmZhY2UgZm9yIEJPVCB0byBV
QVNQLCB0aGUgZGV2aWNlIG5lZWRzIHRvIGlzc3VlIGEgU3RhcnQgVHJhbnNmZXINCj4gPiBjb21t
YW5kLg0KPiA+DQo+ID4gVGhpcyB3b3JrYXJvdW5kIHdvbid0IHdvcmsuIENhbiB3ZSBmaXggdGhl
IHVzYl9lcF9kaXNhYmxlKCkgaW50ZXJmYWNlDQo+ID4gYW5kIHJld29yayB0aGlzIGluc3RlYWQ/
DQo+ID4NCj4gPiBCUiwNCj4gPiBUaGluaA0KPiANCj4gSGkgVGhpbmgsDQo+IA0KPiBXZeKAmXJl
IHRyeWluZyB0byBzZWUgaG93IHRoaXMgY2hhbmdlIGNvdWxkIGNhdXNlIGEgcmVncmVzc2lvbiBm
b3IgVUFTIA0KPiBkZXZpY2VzLg0KPiBDb3VsZCB5b3UgZXhwbGFpbiB3aHkgdGhlIHdvcmthcm91
bmQgbWlnaHQgYmUgYSBwcm9ibGVtIGZvciBVQVM/IEFyZSB5b3UgDQo+IGNvbmNlcm5lZCB0aGF0
IGl0IGNvdWxkIG1pc3MgYSB2YWxpZOKAr1N0YXJ0VHJhbnNmZXIgd2hlbiBhIHByZXZpb3VzIA0K
PiB0cmFuc2ZlciBmaW5pc2hlcyBsYXRlciB0aGFuIGV4cGVjdGVkIGFzIHBhcnQgb2YgZXBfZGlz
YWJsZT8NCg0KSW4gVUFTLCB0aGUgZGV2aWNlIGNvbnRyb2xsZXIgdXNlcyB0aGUgZmlyc3QgUFJJ
TUUgdG8gc3luY2hyb25pemUgd2l0aA0KdGhlIGhvc3QgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgdGhl
IFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQgY2FuIGluaXRpYXRlDQp0aGUgc3RyZWFtLiBBZnRlciBj
b25maWd1cmluZyBhbiBlbmRwb2ludCwgaWYgd2UgaXNzdWUgdGhlIFN0YXJ0VHJhbnNmZXINCmNv
bW1hbmQgdG9vIGxhdGUsIHRoZW4gdGhlIGRldmljZSBjb250cm9sbGVyIG1heSBub3QgaW5pdGlh
dGUgdGhlDQp0cmFuc2ZlciAoc2VuZGluZyBFUkRZKSwgYW5kIGhvc3Qgd2lsbCBub3Qga25vdyB3
aGVuIHRvIHN0YXJ0IHRoZQ0KdHJhbnNmZXIuDQoNClNvIHdlIGhhdmUgdGhpcyB3b3JrYXJvdW5k
IHRoYXQgd2Ugd291bGQgaGF2ZSB0aGUgZGV2aWNlIFN0YXJ0IGFuZCBTdG9wDQp0aGUgZW5kcG9p
bnQgaW1tZWRpYXRlbHkganVzdCB0byBhcm0gdGhlIGVuZHBvaW50IGZvciBVQVNQIHRyYW5zZmVy
cy4gSW4NCnRoZSBuZXdlciBJUHMsIHRoaXMgd29ya2Fyb3VuZCBtYXkgbm90IGJlIG5lZWRlZC4N
Cg0KPiANCj4gSWYgd2UgZG9u4oCZdCB1c2UgdGhpcyB0ZW1wb3JhcnkgZml4LCB0aGUgZHJpdmVy
IGNhbiBzdGlsbCByZXBvcnQg4oCcRVAgDQo+IHJlc291cmNlIGJ1c3nigJ0gd2hlbiBhbiBlYXJs
aWVy4oCvU3RhcnRUcmFuc2ZlciBoYXNu4oCZdCBmaW5pc2hlZCANCj4gYmVmb3Jl4oCvZXBfZGlz
YWJsZSByZXR1cm5zLiBUaGF0IGNhbiBoYXBwZW4gd2hlbiBhIFVBUyBkZXZpY2UgbmVlZHMgdG8g
DQo+IHN0YXJ0IGEgbmV3IHRyYW5zZmVyIGR1cmluZ+KAr2VwX2VuYWJsZSB3aGlsZSB0aGUgcHJp
b3IgdHJhbnNmZXIgaXMgc3RpbGwgDQo+IHBlbmRpbmcuDQo+IA0KPiBUaGUgcGF0Y2ggc2ltcGx5
IGJsb2NrcyBhIHNlY29uZOKAr1N0YXJ0VHJhbnNmZXIgd2hlbiB0aGUgc2FtZSBlbmRwb2ludCAN
Cj4gYWxyZWFkeSBoYXMgYSB0cmFuc2ZlciBpbiBwcm9ncmVzcyB0byBwcmV2ZW50IGEg4oCcRVAg
cmVzb3VyY2UgYnVzeeKAnSBpc3N1ZS4NCj4gDQo+IEFuZCBpdCBjYW4gY2F1c2UgYSBuZXfigK9T
dGFydFRyYW5zZmVyIHRvIGJlIGlzc3VlZCBsYXRlciBmcm9t4oCvZXBfcXVldWUgDQo+IHdoaWxl
IHRoZSBzdGFydHRyYW5zZmVyIHRoYXQgc2hvdWxkIGhhdmUgYmVlbiBzdGFydGVkIGR1cmluZ+KA
r2VwX2VuYWJsZSANCj4gaXMgc2tpcHBlZC4NCj4gDQoNCkFsc28sIGlmIHRoZSBnYWRnZXQgZHJp
dmVyIGp1c3QgdXNlcyB1c2JfZXBfZGlzYWJsZSgpIHRvIGhhbmRsZSB0aGUNCnRlYXJkb3duIGlu
c3RlYWQgb2YgcHJvYWN0aXZlbHkgZGVxdWV1aW5nIGFsbCB0aGUgYWN0aXZlIHJlcXVlc3RzLCB0
aGVuDQp0aGUgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGZsYWcgd2lsbCBzdGlsbCBiZSBjbGVh
cmVkIGltbWVkaWF0ZWx5IG9uDQp1c2JfZXBfZGlzYWJsZSgpIGFuZCB3ZSB3aWxsIHN0aWxsIHJ1
biBpbnRvIHRoaXMgaXNzdWUgYWdhaW4uDQoNCkFub3RoZXIgd29ya2Fyb3VuZCBpcyB0byBoYXZl
IHRoZSBkd2MzIGRyaXZlciByZXRyeSB0aGUgY29tbWFuZCBhZnRlciBhDQpzbWFsbCBkZWxheSBp
ZiB0aGVyZSdzIG5vIHJlc291cmNlIGVycm9yIHJlcG9ydC4gT25seSBkbyBkZXZfV0FSTiBhZnRl
cg0KYSBmZXcgdGltZXMgb2YgdGhlIHNhbWUgZmFpbHVyZS4NCg0KSWRlYWxseSwgd2Ugc2hvdWxk
IGZpeCB0aGUgdXNiX2VwX2Rpc2FibGUoKSBhbmQgaGF2ZSB0aGUgY29tcG9zaXRlDQpmcmFtZXdv
cmsgcHJvcGVybHkgaGFuZGxlIHRoZSAid2FpdCIgZm9yIGNvbXBsZXRpb24uDQoNCkJSLA0KVGhp
bmg=


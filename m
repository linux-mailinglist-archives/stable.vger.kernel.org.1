Return-Path: <stable+bounces-144640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14722ABA6A1
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD41A1BC5BCB
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B0280A3C;
	Fri, 16 May 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sk9SpQ0N";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c57LxUGt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R3g2Q0Z3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DE15A864;
	Fri, 16 May 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438744; cv=fail; b=Vy0lCvwp4Rmi73znPbBqB1pMRrXMw/GEOaoiChrZf56Fc19JqopmP2f+Ty+IXJYJaxJNaLJhUanF2gpU5joVmLh6MY33TRhTS0beSlFbZz7i/C9CK1rBhX6qeylM/PIc0AuoOjqKTGywK/BYorpqObeIWLnVSxGZOVqPUmUj1Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438744; c=relaxed/simple;
	bh=fAb/q0Bqvvbd4QU3s4J4QUtzj+Fn4gDXjWRH/+BexeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7crX3l+bIg8dU3QVFZnqfjZPCc6GMazUwpmlNZm4FwF4voT0wcsMe3zjerYgojphLArMu1CW/3nyvLUfDCywwzMHBkl8JzEGspSBN/JZJQebpBDE8JjRFZJSOPz7aLJQNlsofNX/1E+5eP67OZph1frkMVDIORaz6zyvZW/jM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sk9SpQ0N; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c57LxUGt; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R3g2Q0Z3 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GMC38I023079;
	Fri, 16 May 2025 16:38:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=fAb/q0Bqvvbd4QU3s4J4QUtzj+Fn4gDXjWRH/+BexeY=; b=
	sk9SpQ0NP5128qhQcgHIepjG+ifaZ3nb7OxsP2sTr7QUNJhJfZi+lT5G9Qj9FW7D
	JIt4/53jtp4aRuFSJdba5N6gfYMfwVFx3FBnrMWLbUmWY5XxNXScPXXmiBk350bX
	3UjN3huXjxl/Qij+0irH1eo8qWTq0MRZVAycoZsorkPAnxSOtHcxknWq3y+w//oK
	rbLnLzQhpmjdj2V5wXQUmPHQTFbACv0q1Ewf5GlM//FpRQi+tBS9n6PGQrISl0qF
	8j05g/CgsPAO+BLP52RMDS8giOtFoj8On3YaKoNiDoZKxunB9QYsd92x3KcQA+9k
	uSanm6JkUXUnkKqYdEgHKw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 46mbe5esav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1747438727; bh=fAb/q0Bqvvbd4QU3s4J4QUtzj+Fn4gDXjWRH/+BexeY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=c57LxUGtSxxPgLVCugUucP0U4aX0p1xgUXZCA354Ug4a8rrttXMZuQBiILGpGFyMl
	 ygPRf3lmAU60wxbFej0M6ozW3AFYsSqjZOGZsDM2YTN1rN3BHhEi6XcIP7XSMDITJ+
	 HjN8q8uSu2akXGmN2/pu+pZBrIpHuFrUokUhBas7DxcLduG8Q6rWVWrFbjUNiKg3CF
	 Xk+T6wLcX39T/Bu9jnec4D88RAHWfY/F9fGmEUpBUXTqzmc4o50PxGBbQ+1XJePuw0
	 wyLSEsyzmyLC8dsdZYoAd3/0bZP8wv8Le8qgFRP/NhomCSyfy6rgq0TI0caIVnv74e
	 KI2Q4YBXlI56Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A238B40141;
	Fri, 16 May 2025 23:38:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 48031A00AB;
	Fri, 16 May 2025 23:38:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=R3g2Q0Z3;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B536440126;
	Fri, 16 May 2025 23:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkGDpRfUNCWY+I43fMJu+6//PSEOA3fpdh9dQtqVEMsXiHVQAgsICDA3inSDPtQAEljEHD9xq9lBEW4Ch2wLd9vt8aZFN0QxtaxcUqS5mFoQum5MIbSgOyOUi7nX5w2WEmMElXnOIs9uMtDut1RDRC/uYr32dkeALhGWP39BT8NIy9D6MV29xNk0oD+sqR5+Kv85eQ2q/l/s5/T7I47rzCVahD4u3qkQ6FdgTv2F6TOXf/KJsGYdDmCWxunRixCtz4tD2hMObpwxzFc7ikO0GrQj7gGMHUl4U7LPql6Z/FMlEkGzjnkl87NXG7o3zgyPjZ/2NMStRoSb8Cgh6x3hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAb/q0Bqvvbd4QU3s4J4QUtzj+Fn4gDXjWRH/+BexeY=;
 b=d6Vd4mRQkT6rsdX8aG416s5XXSymxoI5I+ss7rHHZ1o1MJ6fX8WEeuUi98Q8CYX/yRVpgWX7VO8cm2rCRyWG7BGDcMFC/8vXhBkCcRnh5DV5l+yrMVCnyhf6BtM7qowd6XvbURrEUVX/ZFxTzqzZZl4R1Vnyw29iOyvt1rceFQ1n7n5dcOjYpE67fjVU4WSLiDpaBsSQvjKwfzzitdmctUXXJcW1+L3OTpxrbjWhsqzTnqbwrnbYOXB9Btq3uCaQUMuAArkLiQmIA6OQQ2ULS4MG7hP3ZehC3k4hAXBNrsIiuTPKfbKLWv2n5idGKgbsOyza022fv1+FT+kpdadGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAb/q0Bqvvbd4QU3s4J4QUtzj+Fn4gDXjWRH/+BexeY=;
 b=R3g2Q0Z3rFsw8ff5VlgmgWw1fcSUXSE9RyRzK5ywf2jrQMItCWR02k2cwItBlyXhb2If4JbplNELXtgG/toOvBA07Qlc/0c2O7Gi8zZU02+TN593Ocb0C5AledgES6OGsQmgCUTq8w0pslmU+apSMPfW8X/1iKqG98Ss3vEnN5g=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Fri, 16 May 2025 23:38:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 23:38:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>,
        =?utf-8?B?TWljaGHFgiBQZWNpbw==?=
	<michal.pecio@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Thread-Topic: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Thread-Index: AQHbxcqMuLhsoUUr9EONfc+97j2L9bPUWoYAgABywgCAARbNAIAAB5aA
Date: Fri, 16 May 2025 23:38:33 +0000
Message-ID: <20250516233829.ibffgnicnxgchbim@synopsys.com>
References: <20250515185227.1507363-1-royluo@google.com>
 <20250515185227.1507363-2-royluo@google.com>
 <20250515234244.tpqp375x77jh53fl@synopsys.com>
 <20250516083328.228813ec@foxbook>
 <CA+zupgwSVRNyf40JiDi6ugSLHX_rXkyS2=pwc9_VHsSXj4AV5g@mail.gmail.com>
In-Reply-To:
 <CA+zupgwSVRNyf40JiDi6ugSLHX_rXkyS2=pwc9_VHsSXj4AV5g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8344:EE_
x-ms-office365-filtering-correlation-id: 99239ad1-de9e-4c21-33a0-08dd94d2c5b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1JxSzErQmpZNGtCcWppcEZacHV0ZnRGOGlWZzhLbVpHejBWRWZ3TVU4Mlo2?=
 =?utf-8?B?QlpSQUVBNDVjTm4vWFE1eXNKaFZSenI3aWFhdkFPelRjcERQdHkwQU5heEdB?=
 =?utf-8?B?MWlYWEVNNkJEWHhRM1AvR0FNdzZaVzRpZWRvMExzTzU2S1VJRXBpdENoYU9U?=
 =?utf-8?B?YWpCMFloRzRyNHJMTnc2U1FYUDlYNzJXRnNEdndOekJWakdGY0VsamduNWN2?=
 =?utf-8?B?M2dLc0VFU2lRL2tFVW1PK1hsYmZPaXUwOVR2cHVuTEhhVkkralAxZ3ZieTFS?=
 =?utf-8?B?MnUzWldNeUUwY0owVWQraGw1enF6Sy9CaXVjK2YwOGdnV3p6b2kwSWNtYnVP?=
 =?utf-8?B?azJXYkR3b0R1RzRyVXpHdldCdmFFenI4S2tTb1V6Qmt4Wk5rT1ZYaGtaZkZq?=
 =?utf-8?B?MWUrZm4wdzBSSm9OZHozU2RjOUY4ZG5pRzBIeVZMc2ZINzEyY0Zpam4wSkNM?=
 =?utf-8?B?Qnd5RGx6MnMxc3lzbmN6V3h3WTN3MVBkVjVreUtiVXlMK29Jd0o5KzdrSnBw?=
 =?utf-8?B?R1hnb0d5L05kRE1mRmZnd2NMekRpemNQN0t5ekxzTVp1S3pYQlBNaGk0ZzdJ?=
 =?utf-8?B?TnJMK0tnMEZwR1FjY3JHTjluLzFINWxLS0ZTYlZoV3RQVkl3T1JPbVhkSENE?=
 =?utf-8?B?dm43L0RObVJnVUlnYjlCcFdmT1dvWnR3OEkvVjkvYjZVVEdocW51d2hEYjZC?=
 =?utf-8?B?Zlk3Z2dxS25GUVRwbWcvcWpYSUhVa3R1UWNlMmZ4NjJEZHpCck1INUJzRldp?=
 =?utf-8?B?aTZSS0oxZk1nNE8yR2pxMGZXa1duY241UmlWTnFNdzc2bXB3NnVvUFFPVDU2?=
 =?utf-8?B?aEJlUGEyMTVJVzBzM281SUZ4SmZEbEllRXlPemNJLzAvbGVRWklYVTBneG1i?=
 =?utf-8?B?RlVRWDRINXZMK0tmZk5PN1QxTyszbm16d3VlNEF6cUw4ejU3cWF5OGZqMFNs?=
 =?utf-8?B?V1Npb2JhZk5ieU5PbVZQM2kxUTVWZHBMaldCQTdyRGFDbzF2clJxMWtqVE1G?=
 =?utf-8?B?YUxkTVExOGNzSitxdFl6cnkrOC96ZWVCRUVlWG9BSFRQSkRBVCtUdkpZdkpT?=
 =?utf-8?B?dmhhZ3l5K1EraFlPQWUyamN1ZFFIOC9BbVE4UGVsV2Q5dzFpd3JmK2JjMVlQ?=
 =?utf-8?B?UnQ3eU1LQjhWR3ByYmZyQ2FURkNhTU5yMVJqeEExc2EzWHlJcmRTZnQrMS9J?=
 =?utf-8?B?dW5sMkRNL2NlNWxRVGhndU0xekVFSW8ySjBrcXZlUksvcFRoK2djZmdmVWpZ?=
 =?utf-8?B?aVVrampSTnRiZjVrd1NnemVtalBUejM2ZDJTQ0FSaDJZM1Z4UmRwQW5EenVH?=
 =?utf-8?B?QXU0ZVY0OU1RcmZ6VTM3amlvQ2hXZElVSFVqWUFnR2d3cDNiWXNFV1BocEk4?=
 =?utf-8?B?QytlSDg0UndTVE9tcXpHTlJOU21RWE1JY25QOHRINnJuYzJaRlBoM291NTdK?=
 =?utf-8?B?cHVRc01uUmdkZzNqRlE2SUxoU201dzRVRXdpeXlYUTVPcmMvZjJrcWVXY3Jv?=
 =?utf-8?B?QldPblJ3TmxsZXRTcExXOUFpd01sQTBTVTZ1SEl5TEY5SGVxbGQ0Q2ZYN0t2?=
 =?utf-8?B?RHVMZjZwbUVGTG0yS3JIUzFSM0FOeTFnOG84SUtSWUtMMUxKRWRkTFJpTEZH?=
 =?utf-8?B?cmpoK2g2TGNtcHZqOW9sTzRhVU40V3lUcnA3RHNUTkY0SjVaRjlwOUtxVm5z?=
 =?utf-8?B?NVdKYkFTZjMyQjIvWmxKd1Y3TE9QZVdDY25FdzRkeGF0TlpYL3YyYk1aVDRU?=
 =?utf-8?B?a2JQa1hHRXV1SmxTVUxKaXdGczQ4anpsMHhLS0d3cXF3MTBPeU11dEliQllP?=
 =?utf-8?B?clF5cHliTWE0Rk9HejN3RTR3d3YzaGpQOEJ1LytFaXZhTDNVZ1dwQUh6WlVG?=
 =?utf-8?B?VFQrQUZTbDJmbGY5NzFOeWNHNHdUVjc2a0g5K1dhMnB6WmtCU0ZlbHZJS28x?=
 =?utf-8?B?d0g4WFZOQ0lVb0JBYlk3YzU4V3JmYWhLc3ZHa250bkpmMWlobEZjR1ErMWU4?=
 =?utf-8?Q?T4PwhDe+GstXOrjch7Tkb7WROyG8Ak=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXZnUHYrQWZnQnlNVmlsY1ozSnM4dWUyV0crZndaY1grZWRoY0ZHU2xYWE14?=
 =?utf-8?B?U05FRUdLbGE0Sk5SMVIrZzB0ZWJtVVR0aGE2THlIRWY5SFd6SFB4UzhjQVlL?=
 =?utf-8?B?eW1FZllpekREREUwRW1GOWlwQnYxaUR0eGhRQlpHczBCWFpjbTZ1UExHQ1c1?=
 =?utf-8?B?ZXZQSjRtRGFqV2MyYXZ6NzFmVG1XSUF0QmcyRk9NajcwclVpZGVUc2VzTzFw?=
 =?utf-8?B?SXNEQzlkV3k2b1JJcm9Vd3lBVEd5RXpTUERYYVdDZlVreER3ayt0SWM3QXBG?=
 =?utf-8?B?R21BcytGNHgxNTREa0FHWS9TTHpMNVZueFFOZSszYU4ySHF6K0RlaE51N2ho?=
 =?utf-8?B?THM0cldXd3lOMTZadFRTaXRMRjE4Yng4bll2WjNVVkcwNks1OXRkZy9YNk1Y?=
 =?utf-8?B?TEh2c3hKMkxQVk1oZVRVb0xZdEFsSXp2dGkxSzJ2MFJyZ2FzaEVpb3dXd0N5?=
 =?utf-8?B?Skx4WFRnbWJ0aFlXRnpiTW85bWcrcTlSdWZ1ejFvTmVtK0JrS05oUW1lSlVy?=
 =?utf-8?B?djBUckxtb1A3enpwanBnWm5mY1ZlWWo4dThuVEZnMFdBeHNEbjQ5bUZpRkMr?=
 =?utf-8?B?Rm1HdDFQLzNlWG5ZK2pyNjlNOUtzamtJMHlSWUFoelUzU2IrYUxKRzNpUzhn?=
 =?utf-8?B?Rnd3YXhXUmpDUk9pa3lYanh2RjJXTS96QkxxM1FnSUxJZmc4NmVqckV0dzVY?=
 =?utf-8?B?Zzc2R3Nrb29ZMFdSM0ZkelV0R0o1MmhQbEJrQTBYQitlQ3lCbmdzTzhyVmFI?=
 =?utf-8?B?VHpkcHNvZzF3TGY4R2ZzZVZtQWlFU3dsTjZSb0wvWklDcUJQcmlDMDh5anFN?=
 =?utf-8?B?SGlzeHczWStCb01TK0N1Y3ZYRFN4ZzVUaGxlZ1dCa2l1ckdpMU9ReUVGZ09t?=
 =?utf-8?B?djBHc09hbHV0R01pTzNxT2Z0blpNNlNiUEp3T3lUYzFQL1dkTDh4Vkt3ZGJr?=
 =?utf-8?B?d0xTSE5HbVF5alV0ZlpuYjYrclk2YzBJczZNbFI2WXpnSWxnYzJ3MzdtVE43?=
 =?utf-8?B?QWU4aXIyUnBJcGZmKzdBZStKTXpzWUtIdGJySnViVlhsSUZEVXNnL0dDZXJT?=
 =?utf-8?B?SjkybDdRajR3Z1dwR2dPeGJ6dTJpUGJDKzJzamdsVTlGUHczSjhxNUkwRlBC?=
 =?utf-8?B?OEFndXJnNWpUSkczSktZMUM5U2IzaEUyNjJUMkdZSVRLejhBVktyWEVnUCs3?=
 =?utf-8?B?bis2QWk2L1p5dU11S2w2bzFzNUl4cEhUaEFvYXhDNjRHdTBHd0NzSkQxVDIv?=
 =?utf-8?B?elJNUU9wdFVEZFkyY0Y2VCs0S3J1ZFh4RkR4ajVvc1NQMWNJSmJPZXRUS2N4?=
 =?utf-8?B?YWlWUWVoRzA5anhtcE5EanE0KzNNV1dpYmFXUmF4R2FUOGJpWVNyWk1ZUmRy?=
 =?utf-8?B?SVV5SHkwaCtsUHRXdDY5ZWJ5Yk5Yd2pxMlRuMHlpalExdzV1ZWhKSVMwY29C?=
 =?utf-8?B?VHlEbDB1Sm9PZSt0SWlnckJkcDdUUTQ5b1NGb1ZhbmNaUXpYaTlKRi9Wczl4?=
 =?utf-8?B?Qit3ckVENnNSeG9seENMay9DaWgzZllZY3VGOVlGL3RtYXZ3OHdscThQalQ3?=
 =?utf-8?B?cVEvaGNtbmVXRURhRmFQUU9FUWdYclNCWVFiRWlPcEI0ZWRmWmNVV0VnYmNF?=
 =?utf-8?B?TXVJT2pzNUhUSGZXb0JBOTY3MHQ4WUVBbnJteG1iWVVxbmFyaE9xZDk5bEhz?=
 =?utf-8?B?aXhuV3FxWDVxZm4xYkIyUjJtZ3E5SEN1Y3JSUTkvTnJLMXB0cThva0txKzV1?=
 =?utf-8?B?TUNvUk5QVGlXMG40ZUEybXYxMHB6MVIvd0R6eWIvZnNsemZBNHZHODZ3Rk5x?=
 =?utf-8?B?Y3VoL1p5a0NxTmxWWGRNUjZ1dkUwWExKdnFxNG83eTZkdTJaMFRTeC9FNUJs?=
 =?utf-8?B?b0tPbzBPY085bFlkbGJKdUU4R3U5TmhYSWkwci9adXUxbWtnSnd3eUpZYXI2?=
 =?utf-8?B?SGoySnp6dTIxVkREMmxLNmxUWlFVT3ZOdTNmTk54SWVkNGV5WittNEdodC9v?=
 =?utf-8?B?cEV4TXVpdWlkTGFUWGFiK3pBbC92ZUdsaFJsRXRSUk5IZWtEdytjdlFoYWQ4?=
 =?utf-8?B?YngxMnduY0xZaUM1ZUdWbXVOV0JkRnhtbnp5dVorUlRPWjFJMElxR1kzMlZV?=
 =?utf-8?Q?f1wCIbd7rL3sIP1H1IceAqyn9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E74D47B1870AE4690F106408E5E541A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uOcnqso0e2KWfXrSwlaSxwOM1nBAeXVwe1KpS02br1yNCTXdyqUMzvB6Cmq2LoL6B1+czMSg5Hl4T81T2ZW8/xP1Sj4bybYwtsAX4f10IBjdlYu4SgGMQkT1H8dKkQCWsbEgHGZFjkMPC2IdDf+7TI+VJi4Ji2lL25TZf+AL6mFkxD/AO+HtYnW1u/lezVg8NrpzF/Xli7dgvdTSV1JdzCfpMsYqNWjfZvE9eRE7CQmBN8Q605nkB7dwSa+9VXd4MPJQhl0tsSwBPahhWF7xDgpDOuNpvUl8Kv+MAgE6dkqI3QKrTtkxZni2K8sorRPGwgLmjQEkw+s4vpas0evdFVoMtiV5Ppomnu6tRjvMZs0ewQ5a49xfK+wKPGaqZFiczrG0zk4WJvuJ45cvIxswUrbYIMMK1lItkCCCuRaayblxhRPN48TTBGLyo4t3nw02duA2y3C2dxWW4Dcga1eQyd2IcMw8v5MQV1qekhYq+5fks7UMU9bl9tC2pzQBBW8ksrAKoiOpIQdwBzhVd4l3V31582Rkzpcvf8n16f9xqb9tY+U+JJj82vlv+xSVbnglRO2FGeMMBqOu/TvRC+QJF6oIhrzQ2sUplX5QIFeC7smWlHh61kTLpJELfe7EjYhiTnsCYaNmEoKpuV+5kwiE5Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99239ad1-de9e-4c21-33a0-08dd94d2c5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 23:38:33.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRbkrlH3Gkx0Z7kZ66kgmWIj+OS5wMnKOWeZYW2ajcOQN5KeOm/ULuDy85onaCSSCygWYMzPm15IePcLYMJO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
X-Authority-Analysis: v=2.4 cv=GYEXnRXL c=1 sm=1 tr=0 ts=6827cc88 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=UHEMycVIqpxr96VE:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=qPHU084jO2kA:10 a=pGLkceISAAAA:8
 a=frzLskvbA_sinPRwjGoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIzMCBTYWx0ZWRfX3INbe/f3PaLp
 SXpVfB5aC7w/47RISZ/0PlgGhQuRk+BDEbSxSZBeuLh1P+8H4wiRSHX1C5JYR1l1DznRrWNBFyl
 uJpMMG0ll5gUnfeGsMXDlKMuaNWWCoxcHCC+me2fMpwYNKk47c0aB+f8I8uO5e7Mi+sMGqW76jh
 +S9FdXiIIcsirKyghmQNgg+nO2lBaVJr1quHgiFv2XZu18DEL83xI71AnUszIt+NL4DFubAprTy
 kd3F0i8qPlnfEWFtPW6niSLgQXhsnzIVYzi7idpDBo3pheFTuGTUCAPThwFXuOWpBHbiFYEAZ/m
 porSj5Euur78WH1rBfvF+NjBCQ6xK6H5yIwbGW5olp8sY3Lwg5nzbRq1XWmlyOhPK3ofxCww7NC
 Sgz71t6oL0KbSpOUQh9HN06xfbOJm+Nb+w4xnJYPW57FbbE45qh9PQpiEaCjjk7wp7G1e1dG
X-Proofpoint-GUID: gk7ZAVLWZE_6XBnRIvKRsEH_vRttmNiP
X-Proofpoint-ORIG-GUID: gk7ZAVLWZE_6XBnRIvKRsEH_vRttmNiP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam
 authscore=0 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160230

SGkgUm95LCBNaWNoYcWCLA0KDQpPbiBGcmksIE1heSAxNiwgMjAyNSwgUm95IEx1byB3cm90ZToN
Cj4gPiBUaGVyZSdzIG5vIHN0YXRlIDAuIENoZWNraW5nIGFnYWluc3QgdGhhdCBpcyBvZGQuIENv
dWxkbid0IHdlIGp1c3QgdXNlDQo+ID4geGhjaV9oYW5kc2hha2UoKSBlcXVpdmFsZW50IGluc3Rl
YWQ/DQo+IA0KPiBPaywgSSB3aWxsIGNoYW5nZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiAN
Cj4gT24gVGh1LCBNYXkgMTUsIDIwMjUgYXQgMTE6MzPigK9QTSBNaWNoYcWCIFBlY2lvIDxtaWNo
YWwucGVjaW9AZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgMTUgTWF5IDIwMjUg
MjM6NDI6NTAgKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IEluIGFueSBjYXNlLCB0
aGlzIGlzIGJhc2ljYWxseSBhIHJldmVydCBvZiB0aGlzIGNoYW5nZToNCj4gPiA+IDZjY2I4M2Q2
YzQ5NyAoInVzYjogeGhjaTogSW1wbGVtZW50IHhoY2lfaGFuZHNoYWtlX2NoZWNrX3N0YXRlKCkN
Cj4gPiA+IGhlbHBlciIpDQo+ID4gPg0KPiA+ID4gQ2FuJ3Qgd2UganVzdCByZXZlcnQgb3IgZml4
IHRoZSBhYm92ZSBwYXRjaCB0aGF0IGNhdXNlcyBhIHJlZ3Jlc3Npb24/DQo+ID4NCj4gPiBBbHNv
IG5vdGUgdGhhdCA2Y2NiODNkNmM0OTcgY2xhaW1lZCB0byBmaXggYWN0dWFsIHByb2JsZW1zLCBz
bw0KPiA+IGRpc2FibGluZyBpdCBvbiBzZWxlY3RlZCBoYXJkd2FyZSBjb3VsZCBicmluZyB0aGUg
b2xkIGJ1ZyBiYWNrOg0KPiA+DQo+ID4gPiBJbiBzb21lIHNpdHVhdGlvbnMgd2hlcmUgeGhjaSBy
ZW1vdmFsIGhhcHBlbnMgcGFyYWxsZWwgdG8NCj4gPiA+IHhoY2lfaGFuZHNoYWtlLCB3ZSBlbmNv
dW50ZXIgYSBzY2VuYXJpbyB3aGVyZSB0aGUgeGhjaV9oYW5kc2hha2UNCj4gPiA+IGNhbid0IHN1
Y2NlZWQsIGFuZCBpdCBwb2xscyB1bnRpbCB0aW1lb3V0Lg0KPiA+ID4NCj4gPiA+IElmIHhoY2lf
aGFuZHNoYWtlIHJ1bnMgdW50aWwgdGltZW91dCBpdCBjYW4gb24gc29tZSBwbGF0Zm9ybXMgcmVz
dWx0DQo+ID4gPiBpbiBhIGxvbmcgd2FpdCB3aGljaCBtaWdodCBsZWFkIHRvIGEgd2F0Y2hkb2cg
dGltZW91dC4NCj4gDQo+IE9uIHRvcCBvZiB0aGlzLCB4aGNpX2hhbmRzaGFrZV9jaGVja19zdGF0
ZShYSENJX1NUQVRFX1JFTU9WSU5HKQ0KPiBpcyBhbHNvIHVzZWQgZWxzZXdoZXJlIGxpa2UgeGhj
aV9hYm9ydF9jbWRfcmluZygpLCBzbyBhIHNpbXBsZSByZXZlcnQgaXMNCj4gb2ZmIHRoZSB0YWJs
ZS4gQ29tbWl0IDZjY2I4M2Q2YzQ5NyBkaWQgbm90IHNwZWNpZnkgd2hpY2ggcGxhdGZvcm0gYW5k
DQo+IGluIHdoYXQgY2lyY3Vtc3RhbmNlIHdvdWxkIHhoY2kgaGFuZHNoYWtlIHRpbWVvdXQsIGFk
ZGluZyBhIHF1aXJrIGZvcg0KPiBEV0MzIHNlZW1zIHRvIGJlIHRoZSBiZXR0ZXIgb3B0aW9uIGhl
cmUuDQo+IA0KDQpSZWdhcmRpbmcgdGhlIGNvbW1pdCA2Y2NiODNkNmM0OTcsIEknbSBhc3N1bWlu
ZyBVZGlwdG8gbWFkZSB0aGUgY2hhbmdlDQpmb3IgUWNvbSBwbGF0Zm9ybXMuIEhpIEBVZGlwdG8s
IGlmIHlvdSdyZSByZWFkaW5nIHRoaXMsIHBsZWFzZSBjb25maXJtLg0KDQpNYW55IG9mIHRoZSBR
Y29tIHBsYXRmb3JtcyBhcmUgdXNpbmcgZHdjMyBjb250cm9sbGVyLiBUaGUgY2hhbmdlIHlvdQ0K
bWFkZSBoZXJlIGFyZSBhZmZlY3RpbmcgYWxsIHRoZSBkd2MzIERSRCBjb250cm9sbGVycywgd2hp
Y2ggaGFzIGEgZ29vZA0KY2hhbmNlIHRvIGFsc28gaW1wYWN0IHRoZSBRY29tIHBsYXRmb3Jtcy4N
Cg0KPiA+DQo+ID4gQnV0IG9uIHRoZSBvdGhlciBoYW5kLCB4aGNpX2hhbmRzaGFrZSgpIGhhcyBs
b25nIHRpbWVvdXRzIGJlY2F1c2UNCj4gPiB0aGUgaGFuZHNoYWtlcyB0aGVtc2VsdmVzIGNhbiB0
YWtlIGEgc3VycHJpc2luZ2x5IGxvbmcgdGltZSAoYW5kDQo+ID4gc29tZXRpbWVzIHN0aWxsIHN1
Y2NlZWQpLCBzbyBhbnkgcmVsaWFuY2Ugb24gaGFuZHNoYWtlIGNvbXBsZXRpbmcNCj4gPiBiZWZv
cmUgdGltZW91dCBpcyBmcmFua2x5IGEgYnVnIGluIGl0c2VsZi4NCj4gDQo+IFRoaXMgcGF0Y2gg
c2ltcGx5IGhvbm9ycyB0aGUgY29udHJhY3QgYmV0d2VlbiB0aGUgc29mdHdhcmUgYW5kDQo+IGhh
cmR3YXJlLCBhbGxvd2luZyB0aGUgaGFuZHNoYWtlIHRvIGNvbXBsZXRlLiBJdCBkb2Vzbid0IGFz
c3VtZSB0aGUNCj4gaGFuZHNoYWtlIHdpbGwgZmluaXNoIG9uIHRpbWUuIElmIGl0IHRpbWVzIG91
dCwgdGhlbiBpdCB0aW1lcyBvdXQgYW5kDQo+IHJldHVybnMgYSBmYWlsdXJlLg0KPiANCg0KQXMg
TWljaGHFgiBwb2ludGVkIG91dCwgZGlzcmVnYXJkaW5nIHRoZSB4aGNpIGhhbmRzaGFrZSB0aW1l
b3V0IGlzIG5vdA0KcHJvcGVyLiBUaGUgY2hhbmdlIDZjY2I4M2Q2YzQ5NyBzZWVtcyB0byB3b3Jr
YXJvdW5kIHNvbWUgZGlmZmVyZW50DQp3YXRjaGRvZyB3YXJuaW5nIHRpbWVvdXQgaW5zdGVhZCBv
ZiByZXNvbHZpbmcgdGhlIGFjdHVhbCBpc3N1ZS4gVGhlDQp3YXRjaGRvZyB0aW1lb3V0IHNob3Vs
ZCBub3QgYmUgbGVzcyB0aGFuIHRoZSBoYW5kc2hha2UgdGltZW91dCBoZXJlLg0KDQpCUiwNClRo
aW5o


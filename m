Return-Path: <stable+bounces-111859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD2A245E4
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 01:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DD18835E4
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD33FC2;
	Sat,  1 Feb 2025 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hWQfCn23";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B+eb78qp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N9oIWu0P"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27A19A;
	Sat,  1 Feb 2025 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738368920; cv=fail; b=ImKrQcp9kfJCYQ+2kJMrnOrg8J46X7GfPNonyjfB4uoTiaevrdsjM7D5Da5qcgh19E4/ukM8jYIMJCHCBga7ffPCD6e7Ab6GoGtCRhVN8cdmy203mGV1wutueOQsmewf65Di87T7Iv/zZeyqE9YldA0IW6oXetox/uzQkPGyzzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738368920; c=relaxed/simple;
	bh=Z6dzN8rWFIv4sluL5AAawqwS9ug70WdAzf1dxv5gI4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gacl/riWvU9O6LnLYp//SiJz/K7BBvd6g64po6lC/7OEr/2ifdyrNvCePHAYHpV/G0jNbv5oYFr84DbZ68HVNtq4bHIqXZymdXYIQ4GZ1Kp1chRV+JQ6k2HipvQuvstc66ApWRvJMiGPdC0K2HlTAXad/L211jnVWmXttpRAQEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hWQfCn23; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=B+eb78qp; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N9oIWu0P reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VI25NA001466;
	Fri, 31 Jan 2025 16:15:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Z6dzN8rWFIv4sluL5AAawqwS9ug70WdAzf1dxv5gI4Q=; b=
	hWQfCn23OJz/RKj+K4d+J51BjcCX4fUYRtjxqD32DhJ+s9mwNN4iewUwntst6tPA
	ENFi6HW34XQiWrFs4KzO6XtpCd9yJ6XZDyTrNHhIox+dWzhoH6h4PyOoyUDWB48x
	PqqQwXI7IIRNQcwBkvL8QwoDSOsEDBwC4vDbUxH44OKlcM/G8wI+Y95HQVaBIoat
	LDlxJhMa5K0Q39ZzGbKkpUVVbtBtrIAY+Ti/02AjMPmQtUdrTFZ2SQUPC7JJXTRK
	F6n+u1gliHDacccrJcssAq007IDI1wvKk/Cl7929F+u/0wzR/CpyKwR3+MyV1e93
	G21U0Fo2GO79ORO5qkmX1g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 44h3ephejp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1738368913; bh=Z6dzN8rWFIv4sluL5AAawqwS9ug70WdAzf1dxv5gI4Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=B+eb78qp3NMjzWoBAa8jkXn9dkpoE/KkUSvLOvkouOqoEhKgwMqHfcD305GawWORw
	 LWHoR5/Z9EVuHcpa5HwfBZa9L9fgi3clxw/T5opjd2bk0yfiehRoIC48IWnQsX/mkR
	 rPmrw4zIXlQt8BZTWs59eE3h9Mh6/kdzvIoED9cmoJ+1wUCpKt115U+JHabN4n1Qnl
	 l7KeEym4qzwqqrbFy1iqRCAbqfCd1CldhHo78iPhs//MPHZYWOTpqPrQ/igdtNJjxy
	 mHTMiQquzeNuy/Tu/l8lrtx8B+JVyan8paa2X+rUVmalvRNqSpve9H+xoFAmjs8ZZW
	 L94l8M/OU6JcA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B63A400A2;
	Sat,  1 Feb 2025 00:15:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 21AE8A0063;
	Sat,  1 Feb 2025 00:15:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=N9oIWu0P;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 124D340126;
	Sat,  1 Feb 2025 00:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6Xi10rxxPPzsMtz0WV9cOZjzognNpTl62xdSvZfE5O1LeC121bkPKJaKy7bfGSqzw7m0t9tW2FRMIV8oBFaJfK597VzfA7iAGEdmdetrifBZT8IV7yrBUuXHTDsCz77RGaetpWpF9MchT2qG/ft/WCsoEbDWX/4Xu6gbiljZBwT04vouGg6h7wU4nCq8RTbdgyVoFZLfdwDQ7aPqyxhsVkUosxqc2l4y3IaWbH3df79ZbyrUN+QvkjGa3ykkGqssDjcOc41OD6kSbf2Oegwe6L7NWJOway5ztPx57mHiOKiurgD5HcjR1HUVuCG3MkvD2HEFoH1olVgJQmtHDnm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6dzN8rWFIv4sluL5AAawqwS9ug70WdAzf1dxv5gI4Q=;
 b=C99RzU+qNtTzKlZ71RjQXLLR5bW2NSeEx/tNpobc9+9yEfZgbL5XMMQQq6LKPaDC9OuAoFnErvbn4xAqGqD0WDBsZtjjzUpYdakOt7Hx3F3f7BZFB9rZqQ880GgfIR4w6j+33RTvDkb69G6T9OH5mT4u/vL6gHM2qO5aeYOPItWBhVc+gwEUg7+cTB9/s4op0kv+oLgvQymiWfXTP2GUv3DwkKCnAOlEyjzGIk2t4D2RY75O5zyWJLkK82g8B2hP+l1RH1dHPnhMc2vbAbV7rkmjIkoSmiYq0rekJ61gmNw3bha4+GQ4qHmB8ve2EqKcGWKb4VxUXka1jtvC/UzVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6dzN8rWFIv4sluL5AAawqwS9ug70WdAzf1dxv5gI4Q=;
 b=N9oIWu0PCXNcuvcAHH1ZeD5+fzP4OaihfLr6DxTQAZPjoZgT/h3RPEMa8g2ZofWIHgOQTJwyCoBh9NRsM6Mzn8Q4eAa3y+kV7AuJLp0rNh8Mzt7qw/Edb4j+XPzY+lOJpfjJpkM8OU+Pdgo/xLuMK7yzi1Ymx0ZGSR3w21kk3zk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Sat, 1 Feb
 2025 00:15:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8398.018; Sat, 1 Feb 2025
 00:15:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix timeout issue during controller enter/exit
 from halt state
Thread-Topic: [PATCH] usb: dwc3: Fix timeout issue during controller
 enter/exit from halt state
Thread-Index: AQHbc9CSbThlP1CLokGyOvQEPDScH7MxlQ8A
Date: Sat, 1 Feb 2025 00:15:09 +0000
Message-ID: <20250201001506.jr3yw4twwr7zutzd@synopsys.com>
References:
 <CGME20250131110910epcas5p25ee5f0ab53949ad3759c0825d11170b3@epcas5p2.samsung.com>
 <20250131110832.438-1-selvarasu.g@samsung.com>
In-Reply-To: <20250131110832.438-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8824:EE_
x-ms-office365-filtering-correlation-id: de0e936d-8143-4636-1f6b-08dd42557d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c2lXc2JGUmpDRVlxVjBkcndGckphdWlSTzNEVHVYL3grOXVMaGIrMVUxMFpy?=
 =?utf-8?B?YW5CVk1BRXd2MGRPcVVLUXQ3ZFpzWDVBc205RlVQRk5pbEJMeCtWOHJvRFQ2?=
 =?utf-8?B?YTU3N21hS0ZrSGpUNkN1dXFPT0Vwam1ZN0FjWjN5QkwrNlExeHpBM1N0bGh3?=
 =?utf-8?B?Mm1qZTUycHVmZWVsUU5tUVhUR1FxYVN3bFRpeFpISnF0Q09DdlRCMnNRU3J2?=
 =?utf-8?B?NGhScnBOdTlGS0ZlcTVhRytFYjY4V2h2U3F5dDhjL3ZVdjd1Sk1QMGl4bU0z?=
 =?utf-8?B?dFRtcEtVQjNMclpXTzhSK1JubHpkQVppTGpsWSt3WWcyYWlzbTZDcUh1Tlpu?=
 =?utf-8?B?NGl5NWZZZ0c0emZicmlXMzVOOXdGTjdXLzFtdEk2UnRZVzNzVXdNNEhJUUkv?=
 =?utf-8?B?NERrSDd6MUZnQmltSWpaT2VEUEJTcDRHbXlTWHpuYzVQNVFoSWxJZ2ZWOFFW?=
 =?utf-8?B?dUx3Nkg2K0xvU2gwTnAxdnVXRGR6WWFxZGN2ODFsV21jeFErWjJ5UHVIei93?=
 =?utf-8?B?WU9zRXgvN1FKb0FIMGJvbDYzY0d2clNlQzExRmd6TjVpazZYMGhPM0lsTm5H?=
 =?utf-8?B?U2QyckVlTFdxM1M2WUdpMlI4YnhERkNFdUliUXRNeDlHNUdDL25DVDhkZHND?=
 =?utf-8?B?Nm9nUWZ4TU1NRk5RSHlkU2pxeHpHekthTFJUVHFXdWxzREVBUHQ5V2RteVg1?=
 =?utf-8?B?S05pRDZMazN3aFRVNU4wa2NGaklab3Ftdk1veUtyMXEyMmV0Q3E3cjdPczNP?=
 =?utf-8?B?OHd3UHY4Tm4wb0FCbDBESElBbmxmUUFDOGx3bnZNNnNyeEpOaHUxQjM5bCtI?=
 =?utf-8?B?RmQ4Yjk4aDMweEFrTzM4UU14KzZ5QmpxRXU1UEpTTnMvdGlZa2I5ZlFiWmZT?=
 =?utf-8?B?V21vSUEyQ1MrWVpQd3MyM1MvNlMrVXdpWnBaUUtlZ0t5REo1T0lFRFU4MUVX?=
 =?utf-8?B?VWxSWXZlNFFUZnpWaFlyU1I5U1VSNFFUaWdSYTlEaUVCRHV5U2N4UzZPRFJ4?=
 =?utf-8?B?Q2FXUjNXN20wUVZNYyt3UHZEMVhZeVVDQk1zVHpETjNJazRaSDMyN0hWK09j?=
 =?utf-8?B?WEtsSG5wQ3FnZ2lxbVE3RXFnNHZoRnlXNFBGTjdaNmhEdTQxbUtLSFpBSk5V?=
 =?utf-8?B?UGNVcEVtbXZTaWNBR0hKWWMxUWpZRnJxejVNWFl6UE5JQ2JhVkcwbmpIWk9t?=
 =?utf-8?B?OUs5OHU3ZjBpWlJCUHp2YWg3YjRVdkh4ajJzYi9mM2FwZzJYUWYxMUZ1Snds?=
 =?utf-8?B?RG5OL1cxVldyRWcxVWk5dTJtTXVEM3IvbllFRTE1aFh3R2I4c3NBQTRmdmI2?=
 =?utf-8?B?eE9mdm1CRmRYbzEwWEwvMUVETVFPa2lCUXpHczhTWXZ2aWQ2cXpjZzRxSVYz?=
 =?utf-8?B?VlNrYktkMXRlNUJvNWE2ejB6RlRNc0I0ZGJlaUN0a0kxV1RmM1pUWURaT1hp?=
 =?utf-8?B?Y0VHTkZNZEtWckIxVGtzZGtmMDNCbm1ocnJ3UU8wTWNRVCt6V0gzaTR2Q2ZR?=
 =?utf-8?B?OVlVUFczL0ptWkJ2Z1o4OUc3T1QwMzNML3U2MTZ4WlJQOHMwYzNHS3RDZVUy?=
 =?utf-8?B?Q3lTSENwUjhGNXpnS2JJT3hwK2k5bUtrZVRVeEd2Z3pIMENjc1NCdGtHemtx?=
 =?utf-8?B?NVV1WUo3dnNlZVZ1UTloOGwvdmJVcnpYQlh4MWNpaEtVVENhcUdFMHRRdzN1?=
 =?utf-8?B?MDgzSEsyOUhXQmtUUTBKTmlMclJaR3FHcDVOdDVyS0Y5c3pQaE1KSDlFdnBt?=
 =?utf-8?B?Uyt5NmJHcC9SNHBvZkdybGJDUmQzelpEQUp0Z2IwSmtwV2J0Y0xxSHBwa1FL?=
 =?utf-8?B?RS9nQjdlQlJhcWpMQ1lkbG14Ykd5d29SSUVSallMUGZ0OXpzazFZc0VNOTUv?=
 =?utf-8?B?cWpMejNtUkttZFE3alZpSmdFZlhETzc3YjJRczUxV0VtdDNTTjdiTVNKb2Yy?=
 =?utf-8?Q?HSWRbu6/ajgNGYz+rAm1ECIOctgYjSnu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWRldVg5SkFWemhKeFBkOE16SXkwWjN3N3VvQThiTjlGcUw4Ym1wMGwzTUgw?=
 =?utf-8?B?WXYwT1pDV1YxZWFmM2hibm1UUlJrOTByNFlPK3VmenVYaFJhcjQ1TS9HKzh2?=
 =?utf-8?B?Ty9CNTg1c2JHZnlWazQxL2dteTBEUllXazlSSm1ybEVKaDRobTJxV1R4RDFX?=
 =?utf-8?B?Qm1HN3dkRWJCY3RFSXhGRWFXZ3BlRUp0OStvaE0rdjM0eG1aMWtZMWlDWnNl?=
 =?utf-8?B?WnVoWjE0R1hlQ0locG9QUWhBN3U5OTVaQWpGcWdHVE9GclBxeWNqektrZ0Nm?=
 =?utf-8?B?WGJ1REkzNTZ2cHIyMkhzdUZteGgxR3d3VXlSNVF3ZmNIV2tVQjJPNVVDM2Jr?=
 =?utf-8?B?TytlSVlxNHQ4MG1RWVpoY1g1bHRoUnQ4Rk40Q2xCSzVwRTNHSUdtcENEUEJv?=
 =?utf-8?B?dmhQeTEvaCtEdFpCZHRoVlRpQXpJUlVwRlZNTTF0cW9qRUs4Q1BGb0tja3dD?=
 =?utf-8?B?cG1pWmhPSUtKaVRkQisxdXNBZzV0WlY5OWxCYUJISW9PeDhYVGlReDNPNTdz?=
 =?utf-8?B?SzUxWm9IT0ZEcnJoL0ZkQVNaeDVZd2g5aTBlbURFcDY1MUo0cWMzMDJTQVdB?=
 =?utf-8?B?UWVBb056bWgrRXJTb3RPZlVWNlhHZk9YaGRqRS9wd2xkVXhicmJDZm9ORFRa?=
 =?utf-8?B?UE5wc3NlK2dqS3ROM3Z6RnJxM0VLODhLQ21FTlVrTk00R0hHcTArUDZiOERL?=
 =?utf-8?B?VkJGdnZ6N1BIeDUrMWZqY2t6T2hMNFhNSFhYWjhPMVlKS1VZUFVkWEtVdXE2?=
 =?utf-8?B?MnBRL1F0T0preUlvZHkxYWFSMExNc3ZYeTBra2JlbzBtdXZEaytGOXUvS2ho?=
 =?utf-8?B?eXorWUZHUXhNckxLbXFGNmRERzNteFFJWHFjYW1pK1M2eHFjQ1VxZERqaXpq?=
 =?utf-8?B?UkNuK3BJbjJuUHJSYmRiVmp0dStUU20xYnJMN2lwZzBZUThxUWVwMkhrcXJG?=
 =?utf-8?B?K0NqeW8wc3ZoWGt2QTV4MVVnaVRwSlFUQmQwZExPUko5bW1QMDdsWkMzZlM0?=
 =?utf-8?B?S25QOUgxUHpubjMxYy9SYWJqR1VnNWtGKzlaWnd4RkQ3ZmxyQnRERjJWNldK?=
 =?utf-8?B?cXZ1aHVQZUp4eTV5aTNDYXdGb2V5elhVZ3lpeFdlMUZvTVRiakN4eXNyRXR6?=
 =?utf-8?B?R0JOTVdGM09ndTZtaW5iYnBHc0pYL28yNkU0clp6emNCWEE5d0FKRW01aVlZ?=
 =?utf-8?B?QmxrTFd6b0ZsenJDZ1N1R0FCeElXek1MS1UzbndROFVObHNVeDNWQ05vZ0RW?=
 =?utf-8?B?MkdlNTVYZklab3ZnNWtGbmNkNUpHQXd0bkowdjMwWVpxRjBwWFpRaDRUaEtj?=
 =?utf-8?B?NldVVXZ2cVFLbFE3K0lEcXViMjhjM3cyeWU4c0llTDdKU1ZOYm00enJWRHNl?=
 =?utf-8?B?KzJsanhlSmMrU253UlFQTDNEV2kySTIvNXl1dzc5aitNaW0xQks4dldYdkZY?=
 =?utf-8?B?d2FCbEFxbVJrRVlBd2NRcjEvdGtVVGo4UEU4cndCMXNpRWVDaUtEZkJpbmRq?=
 =?utf-8?B?THhWWDVlU3NqaGowQnNuKzl0bkt4RFlZS0w1SnY0aEMvYVgxeVIvS0g5c2F2?=
 =?utf-8?B?YXROazBWclhaMGhoaUxEdW5VYnYzQmUyQmhKZWEvQ3JYVWdFbUR2M1c5Mndm?=
 =?utf-8?B?eUlGbjl0cnlObnQzV1ZYMVFFZy9QcVBVVkpBS1YwV2sxaWxxZ3owdnRYaUdS?=
 =?utf-8?B?U0VMbGNycE9rWTRwYWNwYmh6eTQvRXg3Q3NKNlF6MDBERnhFcDc5N1NrSVo2?=
 =?utf-8?B?ZWZPU3lNZHU1UkswQm9ZYTkyL2hwNTE0djA4cStqOG5IaEhaYkdWWldhMkNP?=
 =?utf-8?B?U0V2VjkyRzNlNmVJUUN0NWpBS3JuVmk0UHdyS2J3YVFBN3JzQ3RJWXp4dUZG?=
 =?utf-8?B?bExWSXNscGh5VDBkS3IzajZOcmhTQVREeGZMV3hDZnkrK3NjNC9TSDRqQXlj?=
 =?utf-8?B?MDlyYWVZZng3MWVteFp6TUEwdGxtUm83cTB1c0NkdmJVTXIrS3BZVzFCRnV4?=
 =?utf-8?B?MDArbzFtTW1zZVRlRmVxeHJBSVNqZ3V4N0ViNVhxb0g4SERqcXh0SWhQaFR0?=
 =?utf-8?B?WUFrYjNUOXdLZmlob3ZiN29waUFBUVlpTFMvdVQzb3hFdUpURkV5cWlSWlN3?=
 =?utf-8?Q?XfeMYIcsST4gpUSqjROalri67?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAE4E8C36C91BD489C1358023321A2B5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Z+cCotsrHKyQEwN2wvWDB7cwG+zNNeXi+Ijol2MdhJRVouz78PCErCbLm3dKtd7cm07FKl39aNOZJP/lZ8aAmEUR3JYJ5TR765kjVvjgiKacJv0gtSJRnFWgtgcojyGf83FSNqo14AGrBBubN97s9rFSTmB48Zg8nwEns5EVIz8x6nCTbYv/3ibcaWoOGwVWV4jI+7li/f6s1Q7VIHrScUNSpw1ffbSttI3vOp5QphSbaFM30YAJgTtB8jK0+5hM6/GDXEAO89V565c14QUJvfYRIttt7BTPLOtxOls4ZcbCUO5PF29D6gw1cEh0u2LzDOfFa2+6ctm/nwb803cRyBY+s0/GTuBckPv2SVRLG6Do1Uv4wnqZJVwg/Lqt+qTuS884llWlQp0auYTOw2CsF8+K8VJAb3HEHxGAjsCEvTWcQescWyFdBxRsy4txb71E4tFz/NJc83s+vZOoLoRWL+1JOFI22OaUxPSSonPVpsUWimmPnaTYwMARh8jCcHdhdowm0QtEAALsGfuqrF1TTFiyXeq6Fgkgwva7kfU2k96TBNRDNRAiXHhGLUBf3mWlxu4r2477uGzVqonSDJ0PUEyN9HLh0X30j48VOr4tqChO8fOFhtdB46f9M8Ab6wNCnSi1sLorPfgpVHr7TTAtg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0e936d-8143-4636-1f6b-08dd42557d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 00:15:09.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iMfPI54VmcHc8Ti4/cZUlskuVfRlMey3npohN5dn32H1D1TkDxCFyg0nRwqS5SGNQE5XZrWYvKqK1mOdjpJxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
X-Authority-Analysis: v=2.4 cv=O6jDvA9W c=1 sm=1 tr=0 ts=679d6791 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=C8FjesAmbsy8XVY_X6UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XDVhFAnxxt9g2sAWlAmX51DarZw7xcv0
X-Proofpoint-ORIG-GUID: XDVhFAnxxt9g2sAWlAmX51DarZw7xcv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=824 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502010000

T24gRnJpLCBKYW4gMzEsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGVyZSBp
cyBhIGZyZXF1ZW50IHRpbWVvdXQgZHVyaW5nIGNvbnRyb2xsZXIgZW50ZXIvZXhpdCBmcm9tIGhh
bHQgc3RhdGUNCj4gYWZ0ZXIgdG9nZ2xpbmcgdGhlIHJ1bl9zdG9wIGJpdCBieSBTVy4gVGhpcyB0
aW1lb3V0IG9jY3VycyB3aGVuDQo+IHBlcmZvcm1pbmcgZnJlcXVlbnQgcm9sZSBzd2l0Y2hlcyBi
ZXR3ZWVuIGhvc3QgYW5kIGRldmljZSwgY2F1c2luZw0KPiBkZXZpY2UgZW51bWVyYXRpb24gaXNz
dWVzIGR1ZSB0byB0aGUgdGltZW91dC7CoFRoaXMgaXNzdWUgd2FzIG5vdCBwcmVzZW50DQo+IHdo
ZW4gVVNCMiBzdXNwZW5kIFBIWSB3YXMgZGlzYWJsZWQgYnkgcGFzc2luZyB0aGUgU05QUyBxdWly
a3MNCj4gKHNucHMsZGlzX3UyX3N1c3BoeV9xdWlyayBhbmQgc25wcyxkaXNfZW5ibHNscG1fcXVp
cmspIGZyb20gdGhlIERUUy4NCj4gSG93ZXZlciwgdGhlcmUgaXMgYSByZXF1aXJlbWVudCB0byBl
bmFibGUgVVNCMiBzdXNwZW5kIFBIWSBieSBzZXR0aW5nIG9mDQo+IEdVU0IyUEhZQ0ZHLkVOQkxT
TFBNIGFuZCBHVVNCMlBIWUNGRy5TVVNQSFkgYml0cyB3aGVuIGNvbnRyb2xsZXIgc3RhcnRzDQo+
IGluIGdhZGdldCBvciBob3N0IG1vZGUgcmVzdWx0cyBpbiB0aGUgdGltZW91dCBpc3N1ZS4NCj4g
DQo+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyB0aGlzIHRpbWVvdXQgaXNzdWUgYnkgZW5zdXJpbmcg
dGhhdCB0aGUgYml0cw0KPiBHVVNCMlBIWUNGRy5FTkJMU0xQTSBhbmQgR1VTQjJQSFlDRkcuU1VT
UEhZIGFyZSBjbGVhcmVkIGJlZm9yZSBzdGFydGluZw0KPiB0aGUgZHdjM19nYWRnZXRfcnVuX3N0
b3Agc2VxdWVuY2UgYW5kIHJlc3RvcmluZyB0aGVtIGFmdGVyIHRoZQ0KPiBkd2MzX2dhZGdldF9y
dW5fc3RvcCBzZXF1ZW5jZSBpcyBjb21wbGV0ZWQuDQo+IA0KPiBGaXhlczogNzIyNDZkYTQwZjM3
ICgidXNiOiBJbnRyb2R1Y2UgRGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8
c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCBkMjdhZjY1ZWIwOGEuLjRhMTU4
ZjcwM2Q2NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0yNjI5LDEwICsyNjI5LDI1IEBAIHN0
YXRpYyBpbnQgZHdjM19nYWRnZXRfcnVuX3N0b3Aoc3RydWN0IGR3YzMgKmR3YywgaW50IGlzX29u
KQ0KPiAgew0KPiAgCXUzMgkJCXJlZzsNCj4gIAl1MzIJCQl0aW1lb3V0ID0gMjAwMDsNCj4gKwl1
MzIJCQlzYXZlZF9jb25maWcgPSAwOw0KPiAgDQo+ICAJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVk
KGR3Yy0+ZGV2KSkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCg0KQ2FuIHlvdSBhZGQgc29tZSBjb21t
ZW50cyBoZXJlIHRoYXQgdGhpcyB3YXMgYWRkZWQgdGhyb3VnaCBleHBlcmltZW50DQpzaW5jZSBp
dCBpcyBub3QgZG9jdW1lbnRlZCBpbiB0aGUgcHJvZ3JhbW1pbmcgZ3VpZGUuIEl0IHdvdWxkIGJl
IGdyZWF0DQp0byBhbHNvIG5vdGUgd2hpY2ggcGxhdGZvcm0geW91IHVzZWQgdG8gdGVzdCB0aGlz
IHdpdGguDQoNCj4gKwlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNG
RygwKSk7DQo+ICsJaWYgKHVubGlrZWx5KHJlZyAmIERXQzNfR1VTQjJQSFlDRkdfU1VTUEhZKSkg
ew0KDQpJIGtub3cgd2UgaGF2ZSAidW5saWtlbHkiIGluIHRoZSBvdGhlciBjaGVjaywgYnV0IHdl
IHNob3VsZCBub3QgbmVlZCBpdA0KaGVyZSBvciB0aGUgb3RoZXIgcGxhY2UuIFBsZWFzZSByZW1v
dmUgdGhpcyBoZXJlLg0KDQo+ICsJCXNhdmVkX2NvbmZpZyB8PSBEV0MzX0dVU0IyUEhZQ0ZHX1NV
U1BIWTsNCj4gKwkJcmVnICY9IH5EV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWTsNCj4gKwl9DQo+ICsN
Cj4gKwlpZiAocmVnICYgRFdDM19HVVNCMlBIWUNGR19FTkJMU0xQTSkgew0KPiArCQlzYXZlZF9j
b25maWcgfD0gRFdDM19HVVNCMlBIWUNGR19FTkJMU0xQTTsNCj4gKwkJcmVnICY9IH5EV0MzX0dV
U0IyUEhZQ0ZHX0VOQkxTTFBNOw0KPiArCX0NCj4gKw0KPiArCWlmIChzYXZlZF9jb25maWcpDQo+
ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSwgcmVnKTsNCj4g
Kw0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RDVEwpOw0KPiAgCWlmIChp
c19vbikgew0KPiAgCQlpZiAoRFdDM19WRVJfSVNfV0lUSElOKERXQzMsIEFOWSwgMTg3QSkpIHsN
Cj4gQEAgLTI2NjAsNiArMjY3NSwxMiBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9w
KHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19vbikNCj4gIAkJcmVnICY9IERXQzNfRFNUU19ERVZD
VFJMSExUOw0KPiAgCX0gd2hpbGUgKC0tdGltZW91dCAmJiAhKCFpc19vbiBeICFyZWcpKTsNCj4g
IA0KPiArCWlmIChzYXZlZF9jb25maWcpIHsNCj4gKwkJcmVnID0gZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KPiArCQlyZWcgfD0gc2F2ZWRfY29uZmlnOw0KPiAr
CQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCksIHJlZyk7DQo+ICsJ
fQ0KPiArDQo+ICAJaWYgKCF0aW1lb3V0KQ0KPiAgCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gIA0K
PiAtLSANCj4gMi4xNy4xDQo+IA0KDQpUaGFua3MsDQpUaGluaA==


Return-Path: <stable+bounces-127367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4845EA78557
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4AB16C68C
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F3219306;
	Tue,  1 Apr 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nMBs6MaR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SX2F3kQA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l0cwH22T"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394E1F03E0;
	Tue,  1 Apr 2025 23:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743551421; cv=fail; b=WGbkxtK8uEGocePTo9dQ1quZrk4WWQ6xQjVvtoYqc4ogQC5U6HyDzN7vLHljHzJIMkt8NFHuWHCtyPwUal0jfLxBW9DEDEQ5g3fYEJizcDLfL5wPoJF4TV0Jmvjs+u80WRTSTthwCYaGP1CVBu31oSOGgXiHa/9BQIGufBnzXnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743551421; c=relaxed/simple;
	bh=2cGCfpFzwXjCq8VLY6se3d7im8ui+JLHtV1DKth/BW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cSABfz7FSKq0PMQ+4kvp6Nq0Jzdm4gH9EN8kYHJbF/nnnOgOeUCTAe5Dbu3KQ6tucfXI10HIoWmiARHR2JsaycfmWm2IGJzU/uiExAxZFex2HqcxzzUu0HxMjMuCeoQaKgzqfeoyG27cXKFI2vPEA8Ca7KfcS6ZWTzB/PVgSi+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nMBs6MaR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SX2F3kQA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=l0cwH22T reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531IlVjW014852;
	Tue, 1 Apr 2025 16:50:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=2cGCfpFzwXjCq8VLY6se3d7im8ui+JLHtV1DKth/BW4=; b=
	nMBs6MaRyMW92fQVSzskzR+5cSuJWaaHgjHmDtWSzFuhgw6X7OkiqEc/A19T3h1e
	jZACajPPS6JgwCQieyyjrcUOLn9qOXiJ8L+ZJmeN2XmpjlTm0H79dpRoO0mPQWRw
	ghmVDWCcjpuOJDjANozvgWfZMAbiyXOzOc513CWfNKvXI/F9aWonDqsdd9Kz7aOB
	i4WtN0LprS/Iw5arpopLLNKv5eChTnbkppLzakmws6vhbMZ8r7TCaFa2/SeNmnt7
	ndO2hFqntzNVebjh/mhXD5QUK9xoySOhaoFUJd4TNkAH09dBEcY+1AL5hDuI386h
	EKvz/Hyb0Gbl8ae5QRcvGQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45pg487mas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 16:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743551415; bh=2cGCfpFzwXjCq8VLY6se3d7im8ui+JLHtV1DKth/BW4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SX2F3kQAf7HF3fKQ0EFurrrLzlbdDg6wLS9+Ywn3KsqJ0a0rnkOZvPAgur88R/IGL
	 wI2qBVdakz1e8QIonhSH0MpI9jdqzAQiUaPjZdOf/LFHTTQLlTeHU5HyWC7W0LSL2v
	 p5xdCF90q/2+eyFOmK8VWi7rEr2IkG1FerLzX23u86BMf4ggviaaq9mn6C8kEbRGQ8
	 9QvGhi3PaR3SpmGVp4JjwrsTzK2eqUHJSDnEmJCvxaObYRFR77I3u6oiGNCIZXNn8x
	 fyeUfH3sXjHG1dwtNHpe+WA94DYjS5V1LerH1O6O74BlRFniH/3Ol/P/uTFpUEF19w
	 iVgSj3GsT6XLg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 22B6C4034A;
	Tue,  1 Apr 2025 23:50:15 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6030FA006F;
	Tue,  1 Apr 2025 23:50:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=l0cwH22T;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E49B84028D;
	Tue,  1 Apr 2025 23:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRhwXy6JlUxEmKaP9hGbIIryTyeDGMlZ4j2RNEeZXnzw0nGfSrpb5xyFctbuagk7PWt4+2Q3lh3JMPL2Yn0VYsKEO5J2mO39VNGm4aUQt8FLF2BqwwY7MuUk2fUzDCHsaxP/Rztn7E4ANNaiIsLOb9fKw0Sk+Uqp0M8XdRKLujeBGd6+MR5rn1gyVNRQ1lqR3HNuvox0Jn8d6QjYe7l/WTp9BJd1uIinWUf1l6G0IXwrSk1obgPJBrATlQ4W+ExKqHCfsY3LAy8rB/vBDAlIX6Tq95WtulMNZmHH5wu/Zi92VU3sS3VKaPNJ/GZjh44EZ1ryI/bA+KHAFHDagk3XLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cGCfpFzwXjCq8VLY6se3d7im8ui+JLHtV1DKth/BW4=;
 b=XMygs0SNuB9i3qT36A/r2QVbeSSvIKf6bz6t2q7XNyAUqwXSbPQ0x8PmCq8HmTg6bNhEhhflb8aJC4r3ZEVv42qAS1moqi8pCRMd6rpYujgPx2xkdIvIZXFTG3XOqWE1SSEtVOKfFkoRqMOs+F5Pu+CRvpJsOLZGfT3KgVQiSNbxk9V4fqOp2rGXgZQtp/vPqUs5qiLhcaw0bl14dsLbfzqO6EcNe39otI82yFYxJsjqQGGAIJQpTrowrRb+EvU4MHAKc/ZS8otN48lwO4tftMVo/Pr8L4Vms5gZE3ljuHsaZpPCm9M/OlybyBsYWO6HkunqvRWykqa4PfqCHkGtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cGCfpFzwXjCq8VLY6se3d7im8ui+JLHtV1DKth/BW4=;
 b=l0cwH22Tkd4HenkWGh2dxn6x4sdb2QJ1Nh2EAuV1iBvImcCX295lEp0iEppyHFXj0sU0bGRhPHIjHgKuqsLEKEgbEeILoPhCNW/b72Fd0jswj1kcuVeHtNdfyMHM8JE7uRbf9DU+Ote3vbIDqZZ+83jMGzXxyURrlOnNiyKEzBc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 23:50:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 23:50:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH v3] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbnxy6MeNaOI1M2EGcaKKkFEqfa7OPg10A
Date: Tue, 1 Apr 2025 23:50:09 +0000
Message-ID: <20250401235006.akdxp3lv3gt3orym@synopsys.com>
References: <20250327133233.2566528-1-khtsai@google.com>
In-Reply-To: <20250327133233.2566528-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7166:EE_
x-ms-office365-filtering-correlation-id: 307b7291-dbfb-4926-bfcc-08dd7177efe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2dHUS9IbmEvSHYveW03N3MxVElCR09ROXoxM3hKektuV3JGWFlUbWg1WTB1?=
 =?utf-8?B?Z3V0anQ5SG0vYyt3cE92dGpiMzk0MUx5R0s4VkJnZ20ySFpBaVhCbnp4TEJ6?=
 =?utf-8?B?a2YxUjhiZ2hvZWhheEtnZzhaWTFsa1hEZ0tPdjJkbkt0bnJYK1o4ZFdzNUZD?=
 =?utf-8?B?QVB5UHdQV0kzSVFJK1NCeXdHei9CNFE0WmE1Qlh6UXBwNU9ZdDVhT0pLVlBy?=
 =?utf-8?B?TVN4SllRM3hMVTl3WFg5WW1wdGhMMElPTy9hYXd5d3V1MkdhbmZNTXFEcWVR?=
 =?utf-8?B?akwrZjBmY2x6ZGdWcVdBS1U4SEZvMDJXUWxZblJlb0hhdks2OTlDcXRITmlp?=
 =?utf-8?B?RFZhaFJzbWhudHZDV25vdzFzOVczNTh0WVhwWDdjZVF6dXp6SjdoYU5WN0JZ?=
 =?utf-8?B?a1d5MVVYVjhReEx6ZCtjKzZMNDRja1RHblhwVHR0emtJUUpHYlcvZHcyQy9n?=
 =?utf-8?B?ajdaNzYxVnJmQkNudXJMcGVWaTVWZnNEOWQvNC9IV0l1TUh2cE0xR1lhWWJz?=
 =?utf-8?B?ZnFvalpXdTQ1NVJZZWtuekxjTXJxdHdZa2pHc3dVYlFIMWhvNjFzM2V4V0xp?=
 =?utf-8?B?UGxuV2VjWk1hcGJseklNcTdPeHdpRjQzc051NXNOVnNFdTZZNXo0RlA4bVRr?=
 =?utf-8?B?R2FGRWF4ZWU1K2oyMWgwTGt0Q3N3UkljeDhRa28vQlZEblhCM0xPLzN3SzNE?=
 =?utf-8?B?SnZiRnNKaWRtL3Zac1ZmQ2h2SUQ4OVF2TUVtZ1VVbHQ2UGZHUDhHQkFBaG5t?=
 =?utf-8?B?S0dOWjBHcjZiaVRwSlBBQ1Y4QzVEUEpxU1J1NDM4ZnhWT1FpaHlKdDc3QjhW?=
 =?utf-8?B?VUpQRXJjdnc3UTZEK3hXWThoTmhiS1VmQ0hmd2Y3ZU16Z1Z0RjhwdS9manpR?=
 =?utf-8?B?RnhJOUlCRXI0VDdFdjJLeGpXRWNHaXFEaUR1TGV5WTdCS2xXc1NtcVUvTWhY?=
 =?utf-8?B?c0NtSUJaU1ZCVnJNKzNBYjN6blFneTVzM0lveDhZQzRmck85MmtEZnRPL1hX?=
 =?utf-8?B?bEZ2WWxtTEcyWFpkcU1tS0Jkd25qOXNJYktnbVFnUmlYKzhkQ21KTHl6SmQ0?=
 =?utf-8?B?STdEZ05HRnAwcENJQzVhTEQwL3ZFVXhSV3hkQmF1TmVVYXdlRnBqdWdWWW14?=
 =?utf-8?B?cWNGN3hEWW9jME9WMk02Z05UNkRCRXZCZUZVY3RhK0FhTVVXckpoemN5amc4?=
 =?utf-8?B?a2drM1BFNy9xbEdXN3p2aDRNcW11YUMvTUdtRUk3K0w2MzNLQm9QNlh4RjJK?=
 =?utf-8?B?cUNEYjE4ajBsT3lzQzFZaVlteE42Y2xpSHZjWXhRTXc5TjNCWWJoeXFHWU5J?=
 =?utf-8?B?R0xJWEpxeEVEaG9PNnFTTHFDeFpWcGxmRTZCQkhFMTh3OGZXdmJ3VnFMS0FV?=
 =?utf-8?B?S0dXblZ3SkVEcVJaaEdGOGtianZoRDB4eXF6MXUrZytORUxOMGxJUVE0RWJM?=
 =?utf-8?B?WlJtMWVFcnRvTzV2Vm5tNXczWEVKcXNXdFNpb3lEbWsrSThZVlQ2T1VDNExu?=
 =?utf-8?B?OWZZcDNrS1UyL0pKMVFFQm9DL0R4UmNSWmNKVXNFeE12UzBZcy9wcjNXbEFW?=
 =?utf-8?B?bm5aanMrSGYyd3Z4eFlSR3hxMVAxekUrdDRxdkc2RmpmOVRRQW96R2s0K09Y?=
 =?utf-8?B?QmdXRk1EbG8yZFFtSHhhOVM4VVBsaWJaaU4zclBlVm90Z0FsU0hIV1dpbEJa?=
 =?utf-8?B?dklYZmtOa0tJak5pcTl1UE5HbEJRcmFxTjBpQW5mUlI0ekE0eWRvaWpnT2FG?=
 =?utf-8?B?cEhDcVVGUVdTaUNzMGs0dWt1emlQTGs5UVg4ay8rVG1jamNFbnQvVWFjdS9l?=
 =?utf-8?B?YmN5bVVWVENlNjl3YjZjTEoxMTI1OU43V3ZMUDlrRHRLc1gvTW1rbk1zdC9I?=
 =?utf-8?B?VVBqSjBEZ2FZMXJCNWpoVkpaTktyY0gvUTA1amFhMXdjbnE2ME90Y205Ui82?=
 =?utf-8?Q?cRjoaGAS+WhnY7dypyKHPwgr6RVRv/jC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2syd2ZVQXZVRHo1Q01udGFvQlZPa0MxQ0F5WVJJOFdQRjR1VmI0QmdCeU1w?=
 =?utf-8?B?NW5haStRWW5QWFllaEdYQWZvQkFQdWtiRW9YbUtaWEJOUFdxSlluL3VlcU14?=
 =?utf-8?B?VDlTSXRXYWJyOGVKajNrQmNQdjFJVDdMSCtRSGJBMVdoaTRncVVGYVVpY1dp?=
 =?utf-8?B?TmNlVHRnNFFyUi9kS0VMZHpCRWpjdm1OZUF2b2ZmM2oveXBpZVpUdGR1REUy?=
 =?utf-8?B?dHJWNHRlU25yWjZHR2x3aEFyemp2YmFyTW5ZWjFYRUxJb2Q3THI4dWlZaDBm?=
 =?utf-8?B?YkdZc28xTC8vUGt0MTJhUzV6S2RBcXI1dWJYZlhzQkVNWmFVWjFNT2ttMGVX?=
 =?utf-8?B?SjYvMjNNdmtlNldtNlN3N3F5OHVvT2JXcXBlb1YyeERJMDFFZUVpbTlhaGt6?=
 =?utf-8?B?eXpsNlpRTnNKai9KL016cks2Z2s1ajVjTUxPZDF0STZnS0dXTzh3NWFpYVZG?=
 =?utf-8?B?L0VYTWNrbzNOVGI5b1NrcE5KYlhWcVlNcnk1SDhDZkE4aXJWOWtMRWN6TUcw?=
 =?utf-8?B?bEI2TGN0ZURJR09zbmlVc2d5cm1YWGRJejlWZHhzbmw0R3BLMGJjWUV3V0ow?=
 =?utf-8?B?djdzN29uN29WdEJuUGhlVVVUN1o3VjRnREovREJsYWVTcHJkMW56S1FtdWtl?=
 =?utf-8?B?RkgrdVdpTm1PQmpLY3pyL2luYUppQmtJNzY2dWl3MHBEYVkrcndiTUlzaXp1?=
 =?utf-8?B?S1MrUGxMUTgwV21maWJqdWhnQ0tLVVJBNnBuUVBGS1BFdkZuaDlCZWk2QmlL?=
 =?utf-8?B?V3JpNzJ1cG1US3pDcDd1VlE4N08rQTlMUU92d0F1dHFFNGl3M2RPejNzaXVW?=
 =?utf-8?B?SE1CZEd3b3lwcXo0QmtHazlIYVNYRE43eHA0TkdCbFo0M3hnZUdRWG9yQm9H?=
 =?utf-8?B?YUdOdkhTMDJwcm9TKzBLRnhqb3FkQnN4STU1aGdsVVFKYXlaTVZGMmpWYUFq?=
 =?utf-8?B?djhyWmtNZnRaQzVST3NtNWRQTUdTVmx1WDd0aGFGV2MrWFA5MitGNTdSdXMz?=
 =?utf-8?B?SGFubUdRZGY4L2h4WXoyOUtBaWdGL29SenZZOVp5WVZ4OGNMZnBPN2lNNG5r?=
 =?utf-8?B?cnVmZmZOSkZTcGkwL3VwcFB5THJYWGRlQXRxdHVYOW1MZ1JHV1NvRG4vcEVG?=
 =?utf-8?B?Y0RNWmFEaWYySmR1S3RCNW5RMG4rTVI4bVRwRlR4Zk1uN1EzM0tjNGRRNUJR?=
 =?utf-8?B?dFdaN3pnQm5zSTROVzlFWldoSWsvL3ZDdUtHSmpEN0xWdU1hdzJralY2ZHgv?=
 =?utf-8?B?VVhWVThXcGRSYVFoeGlFV0JpNEhxNnhqNFFURTZ6K1RwaGxYbjNRdVdqZWRJ?=
 =?utf-8?B?ODVCb1Y0dnFycHZlbmU3WUl5WUtKcEh5UDBwNG55bDlHWlBUMGxqSjcvUVBo?=
 =?utf-8?B?OVNCdVV5RU9CclRGWkpEeGcwdTc0SHFJZEVEKzMrblliUnl3NzVrUi9RdDBZ?=
 =?utf-8?B?L3g3cTBVSmRnM3k2MDEvaGJxdkcvTHRWYS9TRmppWU96amtjbnF2bkd0MWhZ?=
 =?utf-8?B?TnZLUEpIeWliclQybm5CK1grMkFtS3dCT0NqT3JIUk9jaldSR29jaElyK0Fq?=
 =?utf-8?B?NTdOK3NmM0c1UVljM01HaHBIeDU1WHlPODlodjJKV1d1ajdqTkFGZWJFZnJG?=
 =?utf-8?B?YlZLUDZnWjJNVjVZZG9XempZOE1IeFQ4aFVobDFiZkEvNFZsdlVnWEVlZUV5?=
 =?utf-8?B?ZXc4NlF0enVubzlqaEk2aUJDWEJSU0dZYSsvTCtCSVdFNmJtYU9FQm9UZmRQ?=
 =?utf-8?B?am9DdDZaUEcyQ2ZPUlErTHF2UTAyYnhsRk10azBhbXNQOHYzQ2RkNTl5bHZa?=
 =?utf-8?B?MGxzNkZuUk52dnFtVW5VV3ZZb25aQXpZcnRCbnR1bWNoajM4SlVTR3hlcVVT?=
 =?utf-8?B?Q0NWaWJqZW55SXlHZ0VPQVFnSVdEVnc2SW8zanJ5cWJoVS9CNEhTTnpEK29O?=
 =?utf-8?B?dUQrNlN5SzA3dnJ5aXhPZ3VEUCsweWExYTRqeGVIeFQ4S3prdVFjN3dhVlN6?=
 =?utf-8?B?WE1BRStKUmV6UkwrNEFXSWRsdnY1T1Nucms4QUIvWUNYUjQrVU5rMU0rSHRP?=
 =?utf-8?B?cGxZWm85alhpTDBDWFRSSStTZ2hNcSszTmt0cEN1Qm4ybWRsVEpzZXBKV0NS?=
 =?utf-8?Q?iMJVs+4NkHfoVJBUpNg0zlBGn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EB7856460149C4286DC1CB34DE0E639@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1f8IvL1QSjpdYC461GbsIGnq1Q7j9Bc+guO+aOUt2KKL4Cp2Ls3VaFYUz/W0K2G/msXq5MycHQ1S8kOsvCHy33+nRfhRMsauiXQGt71wCgITVdNWl/8cxwZBJVPCUzfjMMhdXK/qPXRltRKA/o0htvNjYZXRetE5nIpoXz+X6yrBP7Epkw+fXkLbgu9KespRcI9cn0yExKQn931NLy8l/amfps0HbiliuDDm54VPCLL6ppAtaBT9GVh5tByiJ/cOFIPiQVljWOGWcwcmr5YdqNHMm3vpVzRgACOLe+JfZDAtPK8TawFiiVuw+TDJJIjwsKikY0pS3NQmu70XiUooMG6QqSzkQvmwe5HeLtYDdmuevV0/ac03gUI4BoVHMKXqLSBoXjxgmo26CVBEvrn/7zd9GhIbqGRN/U8E/721oMDf+NbJdfMIcAjaOg8Z+9Hed+drocz6Kzpi5Tu0l+ROwK0l6iJBNADnceM50g1zje9k5gvXgfyW4zKL5kJ5cf+UdhtsKcKyHEtf7xUuATe7VD+Eu4Jsut/ivS/mhU7k5go+7mOboXf5rpH32aWTg7LMDeUP0qcC3kkOuhZ6uv24m1uLkZh870drBALCpwEkza12nWUtMaz9iT1p0VZXiol9tlX1T9QqTTQ2cu1VAhQEhg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307b7291-dbfb-4926-bfcc-08dd7177efe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 23:50:09.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfhFMym/mlD/pobhR5QKAEiPj6n20Np2mxRIgPkLNF5DNgobS7zN86OfD2hkx14QNZtjXYdFqXl/0UydMFRnOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
X-Proofpoint-ORIG-GUID: iO8SSm10COQ7-ToYXpq1wBXEqaL2J1Nv
X-Proofpoint-GUID: iO8SSm10COQ7-ToYXpq1wBXEqaL2J1Nv
X-Authority-Analysis: v=2.4 cv=OZ2YDgTY c=1 sm=1 tr=0 ts=67ec7bb7 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=JHzk6tn9kbUIW2eQ6dAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_10,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=904
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010147

T24gVGh1LCBNYXIgMjcsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IFdoZW4gZHdjM19n
YWRnZXRfc29mdF9kaXNjb25uZWN0KCkgZmFpbHMsIGR3YzNfc3VzcGVuZF9jb21tb24oKSBrZWVw
cw0KPiBnb2luZyB3aXRoIHRoZSBzdXNwZW5kLCByZXN1bHRpbmcgaW4gYSBwZXJpb2Qgd2hlcmUg
dGhlIHBvd2VyIGRvbWFpbiBpcw0KPiBvZmYsIGJ1dCB0aGUgZ2FkZ2V0IGRyaXZlciByZW1haW5z
IGNvbm5lY3RlZC4gIFdpdGhpbiB0aGlzIHRpbWUgZnJhbWUsDQo+IGludm9raW5nIHZidXNfZXZl
bnRfd29yaygpIHdpbGwgY2F1c2UgYW4gZXJyb3IgYXMgaXQgYXR0ZW1wdHMgdG8gYWNjZXNzDQo+
IERXQzMgcmVnaXN0ZXJzIGZvciBlbmRwb2ludCBkaXNhYmxpbmcgYWZ0ZXIgdGhlIHBvd2VyIGRv
bWFpbiBoYXMgYmVlbg0KPiBjb21wbGV0ZWx5IHNodXQgZG93bi4NCj4gDQo+IEFib3J0IHRoZSBz
dXNwZW5kIHNlcXVlbmNlIHdoZW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpIGNhbm5vdCBoYWx0IHRo
ZQ0KPiBjb250cm9sbGVyIGFuZCBwcm9jZWVkcyB3aXRoIGEgc29mdCBjb25uZWN0Lg0KPiANCj4g
Rml4ZXM6IDlmOGE2N2I2NWE0OSAoInVzYjogZHdjMzogZ2FkZ2V0OiBmaXggZ2FkZ2V0IHN1c3Bl
bmQvcmVzdW1lIikNCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiANCj4gS2VybmVs
IHBhbmljIC0gbm90IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3IgSW50ZXJydXB0DQo+IFdv
cmtxdWV1ZTogZXZlbnRzIHZidXNfZXZlbnRfd29yaw0KPiBDYWxsIHRyYWNlOg0KPiAgZHVtcF9i
YWNrdHJhY2UrMHhmNC8weDExOA0KPiAgc2hvd19zdGFjaysweDE4LzB4MjQNCj4gIGR1bXBfc3Rh
Y2tfbHZsKzB4NjAvMHg3Yw0KPiAgZHVtcF9zdGFjaysweDE4LzB4M2MNCj4gIHBhbmljKzB4MTZj
LzB4MzkwDQo+ICBubWlfcGFuaWMrMHhhNC8weGE4DQo+ICBhcm02NF9zZXJyb3JfcGFuaWMrMHg2
Yy8weDk0DQo+ICBkb19zZXJyb3IrMHhjNC8weGQwDQo+ICBlbDFoXzY0X2Vycm9yX2hhbmRsZXIr
MHgzNC8weDQ4DQo+ICBlbDFoXzY0X2Vycm9yKzB4NjgvMHg2Yw0KPiAgcmVhZGwrMHg0Yy8weDhj
DQo+ICBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUrMHg0OC8weDIzMA0KPiAgZHdjM19nYWRnZXRf
ZXBfZGlzYWJsZSsweDUwLzB4YzANCj4gIHVzYl9lcF9kaXNhYmxlKzB4NDQvMHhlNA0KPiAgZmZz
X2Z1bmNfZXBzX2Rpc2FibGUrMHg2NC8weGM4DQo+ICBmZnNfZnVuY19zZXRfYWx0KzB4NzQvMHgz
NjgNCj4gIGZmc19mdW5jX2Rpc2FibGUrMHgxOC8weDI4DQo+ICBjb21wb3NpdGVfZGlzY29ubmVj
dCsweDkwLzB4ZWMNCj4gIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9kaXNjb25uZWN0KzB4NjQvMHg4OA0K
PiAgdXNiX2dhZGdldF9kaXNjb25uZWN0X2xvY2tlZCsweGMwLzB4MTY4DQo+ICB2YnVzX2V2ZW50
X3dvcmsrMHgzYy8weDU4DQo+ICBwcm9jZXNzX29uZV93b3JrKzB4MWU0LzB4NDNjDQo+ICB3b3Jr
ZXJfdGhyZWFkKzB4MjVjLzB4NDMwDQo+ICBrdGhyZWFkKzB4MTA0LzB4MWQ0DQo+ICByZXRfZnJv
bV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gLS0tDQo+IENoYW5nZWxvZzoNCj4gDQo+IHYzOg0KPiAt
IGNoYW5nZSB0aGUgRml4ZXMgdGFnDQo+IA0KPiB2MjoNCj4gLSBtb3ZlIGRlY2xhcmF0aW9ucyBp
biBzZXBhcmF0ZSBsaW5lcw0KPiAtIGFkZCB0aGUgRml4ZXMgdGFnDQo+IA0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAgOSArKysrKysrLS0NCj4gIGRyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMgfCAyMiArKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5k
ZXggNjZhMDhiNTI3MTY1Li4xY2YxOTk2YWUxZmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0yMzg4
LDYgKzIzODgsNyBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMg
KmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gIHsNCj4gIAl1MzIgcmVnOw0KPiAgCWludCBpOw0K
PiArCWludCByZXQ7DQo+IA0KPiAgCWlmICghcG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYp
ICYmICFQTVNHX0lTX0FVVE8obXNnKSkgew0KPiAgCQlkd2MtPnN1c3BoeV9zdGF0ZSA9IChkd2Mz
X3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSkgJg0KPiBAQCAtMjQwNiw3ICsy
NDA3LDkgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2Ms
IHBtX21lc3NhZ2VfdCBtc2cpDQo+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRToNCj4g
IAkJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4gIAkJCWJyZWFrOw0KPiAt
CQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCXJldCA9IGR3YzNfZ2FkZ2V0X3N1c3Bl
bmQoZHdjKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVybiByZXQNCj4gIAkJc3luY2hyb25p
emVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ICAJCWR3YzNfY29yZV9leGl0KGR3Yyk7DQo+ICAJ
CWJyZWFrOw0KPiBAQCAtMjQ0MSw3ICsyNDQ0LDkgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRf
Y29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ICAJCQlicmVhazsN
Cj4gDQo+ICAJCWlmIChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0gRFdDM19PVEdfUk9MRV9ERVZJ
Q0UpIHsNCj4gLQkJCWR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gKwkJCXJldCA9IGR3YzNf
Z2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJcmV0dXJuIHJldDsN
Cj4gIAkJCXN5bmNocm9uaXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgCQl9DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gaW5kZXggODlhNGRjOGViZjk0Li4zMTZjMTU4OTYxOGUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBAQCAtNDc3NiwyNiArNDc3NiwyMiBAQCBpbnQgZHdjM19nYWRnZXRfc3VzcGVu
ZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWludCByZXQ7DQo+IA0KPiAgCXJldCA9IGR3YzNfZ2Fk
Z2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPiAtCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyOw0K
PiAtDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAtCWlmIChk
d2MtPmdhZGdldF9kcml2ZXIpDQo+IC0JCWR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4g
LQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQ0KPiAtCXJl
dHVybiAwOw0KPiAtDQo+IC1lcnI6DQo+ICAJLyoNCj4gIAkgKiBBdHRlbXB0IHRvIHJlc2V0IHRo
ZSBjb250cm9sbGVyJ3Mgc3RhdGUuIExpa2VseSBubw0KPiAgCSAqIGNvbW11bmljYXRpb24gY2Fu
IGJlIGVzdGFibGlzaGVkIHVudGlsIHRoZSBob3N0DQo+ICAJICogcGVyZm9ybXMgYSBwb3J0IHJl
c2V0Lg0KPiAgCSAqLw0KPiAtCWlmIChkd2MtPnNvZnRjb25uZWN0KQ0KPiArCWlmIChyZXQgJiYg
ZHdjLT5zb2Z0Y29ubmVjdCkgew0KPiAgCQlkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+IA0KPiAtCXJldHVybiByZXQ7DQo+ICsJc3Bpbl9s
b2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArCWlmIChkd2MtPmdhZGdldF9kcml2
ZXIpDQo+ICsJCWR3YzNfZGlzY29ubmVjdF9nYWRnZXQoZHdjKTsNCj4gKwlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0K
PiANCj4gIGludCBkd2MzX2dhZGdldF9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCj4gLS0NCj4g
Mi40OS4wLjQ3Mi5nZTk0MTU1YTllYy1nb29nDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUSGFua3MsDQpUaGluaA==


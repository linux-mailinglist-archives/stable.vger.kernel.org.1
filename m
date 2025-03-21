Return-Path: <stable+bounces-125793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A7A6C597
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 23:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDC83B2E9F
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1233E1F12E9;
	Fri, 21 Mar 2025 22:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vEd5tqhR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LoxDk7qV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="au+sa1CW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921A1C462D;
	Fri, 21 Mar 2025 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594637; cv=fail; b=Gu13xY4n8sVew23g4CkeEMTMnyQoMfmnrm/p6DrEZVWPSdb5FOR6Pzc1hjW0t7P1jNCPefhbIc6ffeHc2e5jKMYw29iIm2jRQ6j8w6leliPgXJlJnaerNJRqOu9tlCfR1UjH7KK/B3muW/oNVOXDTOVDslXtj/uOImdP+j5wAsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594637; c=relaxed/simple;
	bh=iDmiz4kiNw0YjYJD11ugHL14BtCkpw36yl1a5COt66M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+BVJ1n/UDl+OFlSjEuMypb6qUxT8NSfZDRDJfGjSaDwLbLEQ9/DOb708LhwFG/nzNVlGbYcoKAxU1BJkSLjdPfDF9jzYuNwnRaVBnnWPyR4k6zqNfD9gnDD0NE09VKv7v1BgBOHdUTe6+o5heS8IdAskt1tHQFcdqIDJRBUoxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vEd5tqhR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LoxDk7qV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=au+sa1CW reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LJf7mc015981;
	Fri, 21 Mar 2025 15:03:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=iDmiz4kiNw0YjYJD11ugHL14BtCkpw36yl1a5COt66M=; b=
	vEd5tqhRhF69fBXjDlSbwVbWmZIwtDjpN/YYxDOYNfGxDqf65sznbVlnVPgV2Ioa
	D3TY4ViMl83RAABuSLROuskuOXoa1/MKwYwES6o3lwhCFwQoA83pe5xc8aOr/+Oq
	IKu4bHGJ0i3zxneb2grqHh8Hag24gbQMj/LhimF/hnX9DnBQJ/nBzKX9A8+3ABSG
	+nahhQ+xm97k4MPqTxttsyEq69AV/ww7rIvJZNpsJe4PtL1TREL1ElXSy8rv5rMh
	BqlZwuG1/uIM99cGCZqOzPSZMWZtmwbVwIS72NE830vUyakBL1RckV9DQGG56SMi
	3AzgrqGHtjA4k2BIyJypDA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45fyyhysjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1742594632; bh=iDmiz4kiNw0YjYJD11ugHL14BtCkpw36yl1a5COt66M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LoxDk7qVusmm/GQ81QXVq8y2+FLRSEh2O9YNS5Vbm+ZAGEFisix8Z428wzcdT0ZC2
	 VZPim8oGb3vFCXiQJyIBGFH++/yjLU0gOZzDR0gA3CvbyzQS8CGzx5lYEixxJUBOFF
	 y9u14//2tTG79KQWCJiC1Tmd5BsKEtSg1gv9964TzeRskU7EEa00ENw+RJI9ErsZFf
	 vV58XKFwI7IUPXgvBM/Tn89SQ1x+w16jNQ0GMuSrIG78ObHoEz0slGkEeXhAKaB/Fr
	 Dwxncqvg0fAkni3OSS3ZtjVTJ+NvEhz+qzg0rVJgfvW93oOmdMVB84rDnX/vKX3RVA
	 zzpSIOR7AtEFg==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 16441401B7;
	Fri, 21 Mar 2025 22:03:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 91600A009F;
	Fri, 21 Mar 2025 22:03:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=au+sa1CW;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5B3D34045F;
	Fri, 21 Mar 2025 22:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuFBXYtBjb3DnjsmUIJ6gmG8kJepuS+SaI320UnrGCCMUV5sZhOi+irFPrlBEq75/M/MBzR/g84oND5iv27t8RyjGdBDnTMZPzQSYpe6TN31WLysBmJFWUOK26/G6FrD57jNgUHAqafmimHun7yCGbKih0cbUhZTKhLN39y2bD6DqpxQ2imrqVjDALuUbqzjvojlAIb2AB5uvmnuUGF/erAXcl4nFhWcgfBV7+G+XnwckDxHt3kC5K/LI78Cto+QxzA5AgaTbrzIjWVhDyD3qeppRC7nvlyz9aHN6CMUnCpqDn/surm2CsVwnC+Y0fRUMgIa/0cJKEJxIeY9fDetRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDmiz4kiNw0YjYJD11ugHL14BtCkpw36yl1a5COt66M=;
 b=BW1JGrYgeFEH0Dz9KVkSMJqPpMC/5Y7ChlRDIt2PApZbugUXt0rHptDyGmWJ1rCGuuBjvhG1lgKyTtZ37BYVJjLbGiCFBdntKK6D8taP/5ld3Y4JVNDqocbItT+nGU0wzxzG1+T1Q4Mm9vpe02hj230wp6xjJxszZxmGB64hW7znuXkhKjKs68I1eP3p0CC610D7K+sKNafTqJxqqCMvI0bPcs2ESzw2GXB3zP8yfBlDj2nDvZx8Zsa2CQbSo7/z3a1ZS7lmAlwZLVEfhESsNbJJkGClZ8yYv4yUQUMGC2JTvd9UNZYcotX4iEqQCcZleZY1vCVvtkFY0+bH36l2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDmiz4kiNw0YjYJD11ugHL14BtCkpw36yl1a5COt66M=;
 b=au+sa1CWt9unNdQyykGlqOuMsaMEVaInMIjxU4LTZpIE7RdL821pxkELZ1ha3a8TVvF+uzUuZRGW7FmACSEADG590v2sSg9yFocDTT8z6uTKVtNg08VIlOklAK8xtLu6eDUenwtTdHYpvDvU26FvIu/ZhUTZbBkQEce3g5bBZfk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 22:03:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:03:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kuen-Han Tsai <khtsai@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Topic: [PATCH] usb: dwc3: Abort suspend on soft disconnect failure
Thread-Index: AQHbmaAW4kfDEhto9U6nUPh2Ltc9KLN+JvsA
Date: Fri, 21 Mar 2025 22:03:48 +0000
Message-ID: <20250321220346.wwt3vfwmrcq3qwzj@synopsys.com>
References: <20250320135734.3778611-1-khtsai@google.com>
In-Reply-To: <20250320135734.3778611-1-khtsai@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7276:EE_
x-ms-office365-filtering-correlation-id: 849ffcf1-bad5-49ad-15af-08dd68c44217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yi96RTFTR1huVnZwNGJaWTBPc040cGJHUi8zYjUxYm91QVVaRWtteDgvSzM1?=
 =?utf-8?B?eHNPbVFVMW9vSkZ1WHZGeHg3cC9MV2p3Y2tIOXY1bCtHWE1nRzM5UCtaZDU2?=
 =?utf-8?B?cVh3Zk9SaHQrNmNNZ25RY21MSGRnNDh2Z1dnVXNjYlo3RFo4M3ZwMmN5ako0?=
 =?utf-8?B?Nk9NWC9yMnVEVEhXR3JTWGlZV2liOGhLUFlHRmhCeFdENTdJNlBIUjFLcmVM?=
 =?utf-8?B?UnIxalBUUzR1eWdKRkY1QWZXWlBUTUJZekhLM0tWQTB4SjR0UWN5a2ZlZEUr?=
 =?utf-8?B?aXFCZ2dDKy9wNTUzMlFHZ1FGbVBMbjE3WlUxeFg5VWh4KzdWa0dwNU40WDFy?=
 =?utf-8?B?QW5Dd2lsb1I5aXJHODhZSk5GQXVjQ0U4OHNVdGxJclRYZCszRWZpOCt2cWE2?=
 =?utf-8?B?Vno0dGdUa1AyR0lQOEFaTzVwaEVxOXdEQUNJdzZFQVZEOVA4OVFGb2ZEQ1kz?=
 =?utf-8?B?aDdiN1dOUFVxekZJR09SaUhsT1hySGhWMjlCZUpiZS82RllDNGtnRHVxYjlR?=
 =?utf-8?B?S0ZRZ091N00vdkZPZnZ0Qk10Q1RTUHc5YTB4QVgyeEhWczhwRUhNQzhadndF?=
 =?utf-8?B?TGRUZmp5SE5qWW1SYnliQjROQTgwYzdXOHIwR2FXOUE4S293R3ZlR0MxTURP?=
 =?utf-8?B?Q3NubVlhd3ROcFNrQUk1ZVpJZC9QSFZNZ05HbEdjK0M0OEpENzkyNnRBcE9O?=
 =?utf-8?B?WStVNjB6RkNmcFQ3amxQN1prMk9xcFVoNVdKWENJWEh5QkZ6Zk4wRks4TWRq?=
 =?utf-8?B?NHo3b1BSSm50eURIczhLVXFzdU1PMWZPcjlYRG90SkY0UDNMbUJnck85TDZU?=
 =?utf-8?B?NWxSaEo0U3hsU0d0UlIwSDZPU1RuTHk2bDZBZ1dlS1FmSmFWVVJVdmxIRkxF?=
 =?utf-8?B?a0owTnNkS0xxazU2a3QwNkpTNE5mdzJKUVJaVSt3VVFFc1FhUFZQcExoSVVh?=
 =?utf-8?B?MXJLbnhmNjhqMkJJc0hxbXA1ZDlhK0ZNbHk2SElFY0pzNFB5NmFrNDdlWGZW?=
 =?utf-8?B?QTRJa1FXT3NYNldpU0NvRGZaVnlvcERIVFh0VExRbXYyalo5Y05ZZVdYbGsz?=
 =?utf-8?B?SnFGZHYxK3dzU3ZDa2dpWlJwa0JjR0l6bjNxYkczai81V1BoeERiRUZ2UGox?=
 =?utf-8?B?WVpOMXFQMng2Z2hCZXJhaEZIN2pPcFNkWi9iOGlmQWhzeUg3dWdLQm5SblV3?=
 =?utf-8?B?anJFMXdROUQ2OTJVL0NDbDg4OUZPQTh5dGt5Ri8zejNxenJISnVWVHVlM2dC?=
 =?utf-8?B?OEZpZHBtdTl0RFhONGFWektkNWN0Q1orOGwyZFFvRm9oeTVTamtGeGRCZmF6?=
 =?utf-8?B?MnRYUjIwTWV4RXEyOFBwN0JpeW5DdXN3VXRPQUNMTm50VzczK1ZuU3VUU281?=
 =?utf-8?B?T21reTBVTXplOURsQWhrdGhlRVYyT0dlOUFab3FDUzA3ZnY3bmZtbGhiOGdJ?=
 =?utf-8?B?RXQ3MEVCKzVObHJjQjBrL1JJa1RWeWg3MVo0b2prSTdXNHhrUm1RVkpod2JJ?=
 =?utf-8?B?TC95bldoMjN1MXBpdS9jQnAwRVN3VnQ2SG1RcWpPNUtQeWhyZ09MNG15Q0pU?=
 =?utf-8?B?dWxLeWxMY3F0ZTlIMTF6bjNPWFdUQ0w4dThzdXlFVmZEcjkvLyttYjM4ajFl?=
 =?utf-8?B?L2lrWExvOS9sQ2NySXJ2M1F1RnZTYk9DYzZtWEF0WnBtaWNLV3FqcHBWTVkz?=
 =?utf-8?B?ZUQ4ajdzVkplRGl1Yi8rMVFYVXlPUGw4V1VRSVNVQXE2Z0tiTDBpTkJZb1gr?=
 =?utf-8?B?S1FhbVpkM0cvZDRLOXJGWk8za2ZPWDhReUt0NXM5d3dxaHpjbGtoNEYwQXpC?=
 =?utf-8?B?bkRmVysrcnh3RE5qcUJkbnJhZWRZRnBhelcvT0s3VnZGOEtjUlg4MmdOcDdh?=
 =?utf-8?B?U2xMVjBINTEzRW1YN2Q0RFdUUUFPSTVRTWpTeGU0NDIxdkp5QWJTWGlmS3V5?=
 =?utf-8?Q?w2fboljSeyFzttYsrOGIwjCeWb2gSJx9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWZidEhpM3N4V0hrbnRFc1RlZDY0OHJCa3lScm9vSTdwNVJVTVhaSG42YmRo?=
 =?utf-8?B?emNBeS9rRllyc2VaVUltZjJnOEppZ3E5MmVDSTcwWTM0NlhFN1AxTnhFdHhV?=
 =?utf-8?B?ZFB5LzRtUGcvd1QyMXVLTzBpUlBmSzBIdkdMUmdQNmRIWEQ5VU44ZDYrUTIx?=
 =?utf-8?B?OEVqR2h3QU1udlNYaVgrY2pRV3R3aG9ObGs1alZLWFJvdXM1TmFRMmRGbE44?=
 =?utf-8?B?Z2xhV3pzL0NtV3FwL05LMDZGRGZXdVFsSVFsNFhnQzN6S2NMRWRHcUgrOGJ5?=
 =?utf-8?B?NW5SSzVBRmRrTFkyS2F4ejByTXRXVWRpSFdwc3E3MmlXeWRxSGoyTitMRzVV?=
 =?utf-8?B?SGVQSXlJSDJkdkw4UGFOYjJONVM1K2pFeGo1Qi9TaTlQb2hLMnZjRko3TzJk?=
 =?utf-8?B?a3VtbnlLTkMwUVdEWElrVElNdDZ2K0FUbEYrRWt5enliSEZIVTAyanJzQito?=
 =?utf-8?B?OWpHN3B1Zjd5Z0VMVEFWSWc2c2QwN2s4ZjJDeHh4VHdkeEsvYUxUeUlaUlVL?=
 =?utf-8?B?aGtucVRaN1ZWR2JYSmRhNEJibk1BNFJTbm9lNXoya3ZySHZDK2tMZDNpVGZx?=
 =?utf-8?B?WC9oc3pHOEZBZlBmc1RyVnlsQk53SUduR2l4bVdqeENXSmc3K2ovZFBodm1J?=
 =?utf-8?B?K21QWXhrSWVqQSt0VHRIUkF0dDkyclBqd2ZYWkMxU3QyK0EzQ0hYODErRjA4?=
 =?utf-8?B?eCtnanJnNjZpamVib3g2MVhzOWkrZ3ZRaW5ZU2VYcFkvTGVabWpmTFArbkZp?=
 =?utf-8?B?WUR6azVsUmlwc3k5bit5bU9xVGh5cWhZUDFDZGtXaGxqMy84THlNZWFrYkQw?=
 =?utf-8?B?ZGFPVjhBVmxVQnB4Z1RadjNIeW1NMmJVLzY5UWRid09BbmkvNmtnTkU3T2M3?=
 =?utf-8?B?bFgxRUdBdnF3NHptTU1pU0MycW96M2ZFdXFRbVNLYWVsOFozZVpYRnpJc29v?=
 =?utf-8?B?RFI2ZVM2TVRxakR1R2VBMUNGWUc5RWo3Y2craXAyY0J0SStkTUNJbkYwTTJ4?=
 =?utf-8?B?clZ3R2FNdlM0KzVjMlJRK3dxckRzZzEzYVczQ3ZVNHE1T0VHc0g0cEhOdSsv?=
 =?utf-8?B?aDYrRDZIeWhCWWY0Yk1HbW05enJnaU40SnJXTHBmY25hYmJDWitzREdxaFJn?=
 =?utf-8?B?R2VZV2hsdElNZWswRHFtK3N4Z3BUTndPdjhyVjd0VUNXd2FVVmdhUFEwZkQy?=
 =?utf-8?B?bVJVUENOSnBBNS9ibWxzM2dYZlMxWU5NTkZlM05Sczg1dGFsNHJ0T0xOd0dy?=
 =?utf-8?B?KzFTYUlmeVk0eDBreHM4U01KUGd6dEd5YzYrSFV4SUM2WGlZakpjdHc4RzlP?=
 =?utf-8?B?K3VHQ3UxbWpOY01NNE1hMDFJSEREbDhqV3RoRHhrZGw2cUFydVpkTytjaGlu?=
 =?utf-8?B?UHlsak1hMklPZ1VLU0c2YTRaaENxNUN2N3dYbFVsUG1Xam1JSXBKWVZOSm04?=
 =?utf-8?B?TEdlYm5WcmhUMnlvY1ptL2FuU1pCcjl6R0NzeTBlcGE2NTBXUnBOUnZTdEFK?=
 =?utf-8?B?RmF0QVFEUTBsWkFIWmFyYUFuYjdEZ1ROUWYyTm10WXJWV2J4aHc5YmlFaFNE?=
 =?utf-8?B?enAzY3l2WldJZFJCTDczNWQxYjJUcmR5UUZ5VGZWK1hBUE56TjVOUmhGWGdG?=
 =?utf-8?B?b2J6RklFK01mN1lFMlBMOHViOUZIZDR0NFZqMlp5bjVNMTBmL09CWlZkQ0lJ?=
 =?utf-8?B?eS9pcGJlUTZjZW01WWpKUlc1VG1mVEUrcU0xQ1c1RDJocnFkQlF0Zk5sNTg5?=
 =?utf-8?B?dmdqM0NJei9menJaOHZERHFxTytwOVRkTDJ6ZnR1WkhldTJUSlUwc0grd2FE?=
 =?utf-8?B?eUZMbzVJeUNjTTNnNzlyRkh3TXAwSlp5WTI5RGRnTUVoZHcvUjRDRHNmbTZ1?=
 =?utf-8?B?cHFhWVNJYW5xcEZnVkdzWFN1dThZR3pUcDQyS0Z0NVQzbnlHOHJWdnZDVXpz?=
 =?utf-8?B?RnBZZXliK0g2WTd6TUZpZi9Oa3g4cUwyR251aERYUlVabTBucXhLd0w2MGJ2?=
 =?utf-8?B?Sms3cTFzNFhyWGlmd2luN000cmUyZjVTTHF5QSs1SDN2TVNzc1d6c0w5a0kw?=
 =?utf-8?B?MVZwc0xPdGRvSEMzZS9rNG5LZzFWT24rZlpBS01LWTlPc1FQZ0o2dldTYTlx?=
 =?utf-8?Q?IGF5Dl9TWeKl4D9MT/xDR+rdF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA6C26DE2BF6DC44BE5A2FF49770D595@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b6ux82NvgbL6MtShzR/xo5xggyv8g5R+zq8Og+OgwnFk+yJY2/h8v5B1kSRTUN5nbbOFs+h+wmTVrkZypwVc4MgCaDyV4Nbc4IloBxcvsfQGDpTZhBEEPhRr9KSRtqZVKZXiXhPzkcTz4Qm1J41dOQMNaNo6nRD3HpmFlmn5qitxQgCPV37P5MQC+3DbCIMDmJtJwJUrae+JltnUnm0plSgl2ym3RW3C1K6zZVZ2MF5czmFOmKbaHVIuJ8dmgv9MuedfRoNeT211iB0kU+fviHawdN089/ckaEnQ+vx9DCDeBgWNu50WdIdB33kl7tH7bnP7H0dwDAl/X46njkbBnIEzFDj6LOHR2QF2/P2gyMSU6nok0SmGJoY39vjsDaLhVQ19qrB3tcee08IhdgJNZdG92oMHvAxjydm4HlfhrSt/81uflj9L/OUWWQqh3b76NOzr2fJWJg2pRD7hP2SLcCbz49yLBHNRJfRP7Ya46bkrDErBi/49hkHrMAPbdo3VNH8mQifGuygLlzTqrJBQoQWaahenEUKvIdea/+48GVYgpA94XorRSjicImyRgzCpWCL2QaAuQ/XFhzrGl3ioL/XwsSp2oE9WJPAUHEVRR3DCkip7O9ndxcskOVfQdWTczoz0Dcf6j5OQeBxJ6aV6/w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849ffcf1-bad5-49ad-15af-08dd68c44217
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 22:03:48.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+caJt2U8dNgDPfHGCK47NcoKKAi9Yz/p2f6qz7xVGoNFxZCdCHgKnQ1e+M//ixhgel9MFJpNB9Go09dkbCZ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
X-Authority-Analysis: v=2.4 cv=Jaa8rVKV c=1 sm=1 tr=0 ts=67dde249 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=JHzk6tn9kbUIW2eQ6dAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8dcCV7lCv5mTRuFapBdVkNy50yqy3xw2
X-Proofpoint-GUID: 8dcCV7lCv5mTRuFapBdVkNy50yqy3xw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=851 clxscore=1011
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210161

T24gVGh1LCBNYXIgMjAsIDIwMjUsIEt1ZW4tSGFuIFRzYWkgd3JvdGU6DQo+IFdoZW4gZHdjM19n
YWRnZXRfc29mdF9kaXNjb25uZWN0KCkgZmFpbHMsIGR3YzNfc3VzcGVuZF9jb21tb24oKSBrZWVw
cw0KPiBnb2luZyB3aXRoIHRoZSBzdXNwZW5kLCByZXN1bHRpbmcgaW4gYSBwZXJpb2Qgd2hlcmUg
dGhlIHBvd2VyIGRvbWFpbiBpcw0KPiBvZmYsIGJ1dCB0aGUgZ2FkZ2V0IGRyaXZlciByZW1haW5z
IGNvbm5lY3RlZC4gIFdpdGhpbiB0aGlzIHRpbWUgZnJhbWUsDQo+IGludm9raW5nIHZidXNfZXZl
bnRfd29yaygpIHdpbGwgY2F1c2UgYW4gZXJyb3IgYXMgaXQgYXR0ZW1wdHMgdG8gYWNjZXNzDQo+
IERXQzMgcmVnaXN0ZXJzIGZvciBlbmRwb2ludCBkaXNhYmxpbmcgYWZ0ZXIgdGhlIHBvd2VyIGRv
bWFpbiBoYXMgYmVlbg0KPiBjb21wbGV0ZWx5IHNodXQgZG93bi4NCj4gDQo+IEFib3J0IHRoZSBz
dXNwZW5kIHNlcXVlbmNlIHdoZW4gZHdjM19nYWRnZXRfc3VzcGVuZCgpIGNhbm5vdCBoYWx0IHRo
ZQ0KPiBjb250cm9sbGVyIGFuZCBwcm9jZWVkcyB3aXRoIGEgc29mdCBjb25uZWN0Lg0KPiANCj4g
Q0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KUGxlYXNlIGFkZCBGaXhlcyB0YWcuDQoNCj4g
U2lnbmVkLW9mZi1ieTogS3Vlbi1IYW4gVHNhaSA8a2h0c2FpQGdvb2dsZS5jb20+DQo+IC0tLQ0K
PiANCj4gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3IgSW50
ZXJydXB0DQo+IFdvcmtxdWV1ZTogZXZlbnRzIHZidXNfZXZlbnRfd29yaw0KPiBDYWxsIHRyYWNl
Og0KPiAgZHVtcF9iYWNrdHJhY2UrMHhmNC8weDExOA0KPiAgc2hvd19zdGFjaysweDE4LzB4MjQN
Cj4gIGR1bXBfc3RhY2tfbHZsKzB4NjAvMHg3Yw0KPiAgZHVtcF9zdGFjaysweDE4LzB4M2MNCj4g
IHBhbmljKzB4MTZjLzB4MzkwDQo+ICBubWlfcGFuaWMrMHhhNC8weGE4DQo+ICBhcm02NF9zZXJy
b3JfcGFuaWMrMHg2Yy8weDk0DQo+ICBkb19zZXJyb3IrMHhjNC8weGQwDQo+ICBlbDFoXzY0X2Vy
cm9yX2hhbmRsZXIrMHgzNC8weDQ4DQo+ICBlbDFoXzY0X2Vycm9yKzB4NjgvMHg2Yw0KPiAgcmVh
ZGwrMHg0Yy8weDhjDQo+ICBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUrMHg0OC8weDIzMA0KPiAg
ZHdjM19nYWRnZXRfZXBfZGlzYWJsZSsweDUwLzB4YzANCj4gIHVzYl9lcF9kaXNhYmxlKzB4NDQv
MHhlNA0KPiAgZmZzX2Z1bmNfZXBzX2Rpc2FibGUrMHg2NC8weGM4DQo+ICBmZnNfZnVuY19zZXRf
YWx0KzB4NzQvMHgzNjgNCj4gIGZmc19mdW5jX2Rpc2FibGUrMHgxOC8weDI4DQo+ICBjb21wb3Np
dGVfZGlzY29ubmVjdCsweDkwLzB4ZWMNCj4gIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9kaXNjb25uZWN0
KzB4NjQvMHg4OA0KPiAgdXNiX2dhZGdldF9kaXNjb25uZWN0X2xvY2tlZCsweGMwLzB4MTY4DQo+
ICB2YnVzX2V2ZW50X3dvcmsrMHgzYy8weDU4DQo+ICBwcm9jZXNzX29uZV93b3JrKzB4MWU0LzB4
NDNjDQo+ICB3b3JrZXJfdGhyZWFkKzB4MjVjLzB4NDMwDQo+ICBrdGhyZWFkKzB4MTA0LzB4MWQ0
DQo+ICByZXRfZnJvbV9mb3JrKzB4MTAvMHgyMA0KPiANCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2NvcmUuYyAgIHwgMTAgKysrKysrKy0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDIyICsrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCA2NmEwOGI1
MjcxNjUuLmQ2NGQxNzY3N2JkYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIzODcsNyArMjM4Nyw3
IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXRfZm9yX3Jlc3VtZShzdHJ1Y3QgZHdjMyAqZHdj
KQ0KPiAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBt
X21lc3NhZ2VfdCBtc2cpDQo+ICB7DQo+ICAJdTMyIHJlZzsNCj4gLQlpbnQgaTsNCj4gKwlpbnQg
aSwgcmV0Ow0KDQpNaW5vciBuaXQ6IENhbiB3ZSBrZWVwIGRlY2xhcmF0aW9ucyBpbiBzZXBhcmF0
ZSBsaW5lcy4NCg0KPiANCj4gIAlpZiAoIXBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSAm
JiAhUE1TR19JU19BVVRPKG1zZykpIHsNCj4gIAkJZHdjLT5zdXNwaHlfc3RhdGUgPSAoZHdjM19y
ZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpICYNCj4gQEAgLTI0MDYsNyArMjQw
Niw5IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBw
bV9tZXNzYWdlX3QgbXNnKQ0KPiAgCWNhc2UgRFdDM19HQ1RMX1BSVENBUF9ERVZJQ0U6DQo+ICAJ
CWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2MtPmRldikpDQo+ICAJCQlicmVhazsNCj4gLQkJ
ZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiArCQlyZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5k
KGR3Yyk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0DQo+ICAJCXN5bmNocm9uaXpl
X2lycShkd2MtPmlycV9nYWRnZXQpOw0KPiAgCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiAgCQli
cmVhazsNCj4gQEAgLTI0NDEsNyArMjQ0Myw5IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2Nv
bW1vbihzdHJ1Y3QgZHdjMyAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiAgCQkJYnJlYWs7DQo+
IA0KPiAgCQlpZiAoZHdjLT5jdXJyZW50X290Z19yb2xlID09IERXQzNfT1RHX1JPTEVfREVWSUNF
KSB7DQo+IC0JCQlkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCQlyZXQgPSBkd2MzX2dh
ZGdldF9zdXNwZW5kKGR3Yyk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJldHVybiByZXQ7DQo+
ICAJCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIAkJfQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IGluZGV4IDg5YTRkYzhlYmY5NC4uMzE2YzE1ODk2MThlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gQEAgLTQ3NzYsMjYgKzQ3NzYsMjIgQEAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQo
c3RydWN0IGR3YzMgKmR3YykNCj4gIAlpbnQgcmV0Ow0KPiANCj4gIAlyZXQgPSBkd2MzX2dhZGdl
dF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gLQlpZiAocmV0KQ0KPiAtCQlnb3RvIGVycjsNCj4g
LQ0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQlpZiAoZHdj
LT5nYWRnZXRfZHJpdmVyKQ0KPiAtCQlkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0KGR3Yyk7DQo+IC0J
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+IC0NCj4gLQlyZXR1
cm4gMDsNCj4gLQ0KPiAtZXJyOg0KPiAgCS8qDQo+ICAJICogQXR0ZW1wdCB0byByZXNldCB0aGUg
Y29udHJvbGxlcidzIHN0YXRlLiBMaWtlbHkgbm8NCj4gIAkgKiBjb21tdW5pY2F0aW9uIGNhbiBi
ZSBlc3RhYmxpc2hlZCB1bnRpbCB0aGUgaG9zdA0KPiAgCSAqIHBlcmZvcm1zIGEgcG9ydCByZXNl
dC4NCj4gIAkgKi8NCj4gLQlpZiAoZHdjLT5zb2Z0Y29ubmVjdCkNCj4gKwlpZiAocmV0ICYmIGR3
Yy0+c29mdGNvbm5lY3QpIHsNCj4gIAkJZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQo+
ICsJCXJldHVybiByZXQ7DQo+ICsJfQ0KPiANCj4gLQlyZXR1cm4gcmV0Ow0KPiArCXNwaW5fbG9j
a19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwlpZiAoZHdjLT5nYWRnZXRfZHJpdmVy
KQ0KPiArCQlkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0KGR3Yyk7DQo+ICsJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4g
DQo+ICBpbnQgZHdjM19nYWRnZXRfcmVzdW1lKHN0cnVjdCBkd2MzICpkd2MpDQo+IC0tDQo+IDIu
NDkuMC4zOTUuZzEyYmViOGY1NTctZ29vZw0KPiANCg0KVGhlIHJlc3QgbG9va3MgZ29vZC4NCg0K
VGhhbmtzLA0KVGhpbmg=


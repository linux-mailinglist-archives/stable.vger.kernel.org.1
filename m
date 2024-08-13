Return-Path: <stable+bounces-67557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F67951099
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 01:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768C12848CC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811651ABECB;
	Tue, 13 Aug 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZnQmjUgZ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="krKAo8ZB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R7U/T0Xy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F518C3D;
	Tue, 13 Aug 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591869; cv=fail; b=MNlvL8ON8Iwb+FeazURJ0rfL2xb5gFhzdgUZE1htpIJrzOcN1KEb72yQC6HaGeXPGjrPK6T/L2wMjgJwq79vLYiXFRD4zYJR26eSpjqV5wffKRDeC/Lifsd08QBlT4Gt534iZuKVWNHy7owgEBDcQ3Ykn+qUSZ9JN4xqwheyDQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591869; c=relaxed/simple;
	bh=RW2k5lQG9Ij+WmyVhebaj0qa9LVgdDKqxAp1lXrtAAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQ0ZcnwYLFMcklCrrnJGU6tyicLKmg7ELBu4xvvBfzJTkC05R0v2JG0uJa8hdHgDhfY2iD0D+IY1qaDg+jrQWDSNtuYt/ONgtc/9oVEfk6mPgoZZdprIV1PxXhPYFbvQfRWbBeBuEon1rpR5FLZrYWNk/bOX2H7qxeyWmVZ5/rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZnQmjUgZ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=krKAo8ZB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R7U/T0Xy reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DN6v1O007524;
	Tue, 13 Aug 2024 16:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=RW2k5lQG9Ij+WmyVhebaj0qa9LVgdDKqxAp1lXrtAAY=; b=
	ZnQmjUgZrQ/6eu7/q2LHtu9H/+EdTNtEsB42uDPEIKyR2XMeOjT5zSDSNl9oQ1Mw
	b/HyT6GeL0z3LP1Zz/3RBVPGurvE3+0PHC/V/7cUeIBm/qZsAEhJkQtFGXNpiff4
	enB1iosUf5BqwQ3MWXfWQcPdNR4CqfiYXGCrNnkBKFl7GcGZ1uxI/WaRignypwG8
	x0IgtILdKiyzEbbSL5kaiWHlG0XJiiH4k2uqxbiCPZ8pYapa5r+LjUVeopzZ4J/d
	Jk+QYO/1Fia250w3Qc6hcXCcE5tw/D04UkD3xBI0F3PN9iF7Cx80TLj/C3kjDGTy
	GkNyacowTm5Co2u/ECTcSQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40x77jyw1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723591859; bh=RW2k5lQG9Ij+WmyVhebaj0qa9LVgdDKqxAp1lXrtAAY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=krKAo8ZBiB8rmQiPEiwP4ZnRC/cm/wf6sIPtSX0GDD0tNgZ/vzD+1Ovva7QwTXx3V
	 8KvrFOnWCjgwaILpqhrS/Sf937rRUrb5RbrFkV1zI3zNA0J2fQcJaOo/LDHyIDI+aw
	 eH8MBHOvoMPWNZhYdUQeeLJALspr/c7vrYlTTVwFpVblpUZfM/8PPTbbKMeHuThiHA
	 ps3gfQ/IzTLXvpdeIgcFsVAKoP3Bo9UW6uItQE/DnevdsUcRwUJuEMAuCL3QQ4Q6uT
	 7qlwtpbyisbT+3XtcMhWErsG1+ixclcyvZGL5YF/TxTRVccPuM7rUdfjS8HsZrXkso
	 h8qLjcXZdGcfQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3FBD140130;
	Tue, 13 Aug 2024 23:30:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 25203A007B;
	Tue, 13 Aug 2024 23:30:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=R7U/T0Xy;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A88644035C;
	Tue, 13 Aug 2024 23:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3KMxMLqPyB8PUT9MYBVV26fiL1Xgl2uUc0xXaClhJTMZMNVlM8XZvNyJll5ELltHzKIn1FXTBTEjUOB2ZylbOnErJvV61e+HD0ldiXGhBudgZ+0bDRdZKdVIo7YJovn8LRrwI9QsgOgRF8MQfMuzcQzTfNpUedmKpNN/Z17L9DOisDP/uyqoNLBGmvgUYxllw/CNv16ZTNY6GlkP7zDoQp2RDTFWcokfch80AZz0stRyrmxp55MYJaJa4pXwrQP6VjAvA1or7Uvqkzy1r6fMCg6YkA/2J9OB10zWE5g330D6ir9cyY69WSQpliPgaO88/tiyFz6+BX+dVmOiR8W4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW2k5lQG9Ij+WmyVhebaj0qa9LVgdDKqxAp1lXrtAAY=;
 b=sFnrvjc2wWvNi5S4xiHI3zPVzT8Okovx4QasWaAnLsKvW81NJRLkC6+NqrP4dwqsu5OZknprjRVO2iTmCZ3S7y7o/VkuwezCPNH09guqViiBwykIlkhQd9mRIGPNC/m1ZoE39UE95HuQD3zR6HIUPqHcyskhsgc6WDJgYfGBj1Ss6HrklJe+oQ7fU9s0L7JCxqsfpnKxmQ8m7RxrXBR5DuMba0xRMd6P+awLm+nTIK+UUWf4HziMINQCdTATCAbdWGqIrG4Fv7aW8IEuY6G1oADl5PD/9B1TuB0JzQvcq64IxB8cGD+CYcLFkNNEJFAhwaml0VfD3SpN6EPkqICC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW2k5lQG9Ij+WmyVhebaj0qa9LVgdDKqxAp1lXrtAAY=;
 b=R7U/T0XyTnQUHblxsiFiZL3Gw6/uR4WhfF1tNihKaodeRCqcDvJLjXoqx5yxukF54OioHkNLZL+Z30UobwPaCYADMsGWg++lV2zVwySgI1YINrWtRXs/Rwu4F23JYIw7zskC46BZ2sMtapYRkQuublEkqyJEWsPNdV+t+jF0qLU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 23:30:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 23:30:51 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Topic: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Index: AQHa4n64myRqI4MS10KyZQtJfHhLF7Ia8i4AgACktoCAAPGjAIAIf8sAgADkUYA=
Date: Tue, 13 Aug 2024 23:30:51 +0000
Message-ID: <20240813233043.uhsxocjr2pn4ujle@synopsys.com>
References: <20240730124742.561408-1-quic_prashk@quicinc.com>
 <20240806235142.cem5f635wmds4bt4@synopsys.com>
 <ec99fcdc-9404-8cd9-6a30-95e4f5c1edcd@quicinc.com>
 <20240808000604.quk6rheiqt6ghjhv@synopsys.com>
 <a89b5098-f9d6-4758-52b4-29d24244a09b@quicinc.com>
In-Reply-To: <a89b5098-f9d6-4758-52b4-29d24244a09b@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB8977:EE_
x-ms-office365-filtering-correlation-id: 7375a913-969f-4314-75d4-08dcbbeff835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUhFMXl6UUxpcjgxTDhVQ3ZMMzRDYllFTjJqeFlGdUVIc0thL3J0a3pISWlQ?=
 =?utf-8?B?OGd1NURIaC9MWnR6OWZmL00xT2hOOXFuY01zNzY2UDBsK2VhY0RDem80RXB6?=
 =?utf-8?B?a09qbTJsQWkvc0ZyYUx2RjAvWDlGdURKQUllWTNNNklZYWNUQkg4N1B2NnFY?=
 =?utf-8?B?Ly9mUFB3STJIcXQzMVpQSTRDRWQ2NUI3MDR1UTJYMG9TOUtLTk1RTlhQSlBa?=
 =?utf-8?B?Wnhad0h5cXMyYXFUTU1sYStheXJWNzhuRmdGMXVEN1FmSFNqRzZRTkNZT1dk?=
 =?utf-8?B?VXUzR0U0YWhyTTgrekgzZzZwWnRoL0FseU5EeU4wNVRFVFZXeDJyY2lkakZ6?=
 =?utf-8?B?VmoyZlNvRFBnWHRPN1Q2QnJiMTBrZ0pmSlBsSHY1aTF6Wmg2S3VUNjVtSlRN?=
 =?utf-8?B?M3BjeEN6TU9pUGo3UGI4cGRIQm41Q3dMRFhpclVMVWpETWRQSnNzUmlScElp?=
 =?utf-8?B?MUdxQ0Z4WTBLZ1Qzbll2cFpYSjF4WmFCbFhpZ0xpbVhESXExeEx5UFIyYzdy?=
 =?utf-8?B?aDVMeHQvMnhZNEpFRmdncEZPbVNaNE1mZ0RranVhQmJuRVc5ZDMrZHVTTlJr?=
 =?utf-8?B?bDJBSHo0L2V6RHFsNnk5UktIZ0FEQU9Db3ZzcjNIRnByOVg2OVNpdkRwVjA2?=
 =?utf-8?B?OU1zczIzcHRwNUNyQVk4WGFjUUcwRmpLU1AyWSsyeVNCbWFwVmFzWS80TDR3?=
 =?utf-8?B?czJEOE1BM0J0RW9IZ21oa1psRjlYM3UzZzY0Nk1hVlZIQ1QxVW50ZGx4VGVE?=
 =?utf-8?B?SXo3RnpzbDViaVowTHFFVXpiN3N4UmRjYnB0K1Fncld6SDlkN2JKdW1tRGpU?=
 =?utf-8?B?eGpNamdIcmVyZDRYODFvY1hUcW9WZk9wZzlOVmRQUVdnUGxEdnlvMjY0Wkh0?=
 =?utf-8?B?Ukt4U0N5TGVseW1KRlNCT0xIYytpZHNsSjArK3VlM3FsTE8rMkN4Tk5zRGQz?=
 =?utf-8?B?cHVZU3lxRWhsNFVPTFRENmlETGRSUGhva2t1K3IrRlhXQk44MWtTeEk5Mzc2?=
 =?utf-8?B?NFhwK281QWpqN2hxTzJwUWlDc0FISXVoRlQyZXdUV1hlejRzditoVlJDMCtV?=
 =?utf-8?B?WjZ5b0NBS0c1dnBaMktLUGRXZVpJbWxrRTJEWk8rUEt2WW9oeEZnNEwxUnNq?=
 =?utf-8?B?T0I5ajFadFRBTmJsWi9KV3g1N2hteDlkTm9yTS9GTFVPVURobFd1bU8rVmYy?=
 =?utf-8?B?SzAxQjdEeUZsdFRaYmk0VWJXaXpNR1Y4ZWU5SVArLzg2MDhHRDZSaTNiNVpQ?=
 =?utf-8?B?bnFaSDd3OGVPSDdBdDhzeXgxdWdXelk1clRKODhmQ3ZOL1l4cE1XemZYaGhC?=
 =?utf-8?B?ZEVUcmJ1Y0NPOE1zSWJFT0ZlcjV1YVFEN3JIRnFMbVV4Z0x1K0hOOWE0TytC?=
 =?utf-8?B?Y0lHblZMdkNNOG44SDY3ZFA2ejVBbGRTQ2pzTDMra2dxUGFEQkI0N0dMYUZO?=
 =?utf-8?B?ODR1TjhXSEdyT25NYitjSkhCVno5ZDU1SUtLbVU0VVEyVGJvZG1Ca3R3bEho?=
 =?utf-8?B?Q2Z0QnQ3cFVJUWpDcnpRc3ppUHhXN3NlVGJRaXVPQ0NTd0JsQzUySnhRT21q?=
 =?utf-8?B?OGJGbXRSMkh2ZUhucGhuMlZ1cVF3RjJkeDhsdXd2SlFWTmR0dlZ6U2l6Z2RB?=
 =?utf-8?B?TThiYjBwY3BCYzJXTHNqRElZaDloNFprYUM1Y2l0aUZ0V21KMGEvQXFnYmk3?=
 =?utf-8?B?bFNPZGR4UVNtWDRJalFiTExLYloveUYzT3pqNUgvSlA4RHVDclpyQjZtMjQ2?=
 =?utf-8?B?bFVJc1NsRlorWXJlMUtwL3pTbExzT055ZENWa1Btb0xXTHZiKzFIZzZGZUJS?=
 =?utf-8?Q?1wYFe9WkD2zT/yMHqNazTxzETIzOCDUk5zozM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0dSWHJWYjkwdDBWZkgxemN5SXFYbGc4bCtxYUpPSTJwQmhDTlZpM2Rnb0Fx?=
 =?utf-8?B?Wk5lNUFQYytpYTVLNlZ0WFdtaVJyRE1SY0pRS3E1N3hmUitNNVVPVEZyNUV5?=
 =?utf-8?B?VldKSlV2dzFqOG1Dd2pjaWE2dy9xaE5NWWcxN3Z2endWdTZhSVc4NGVrc0RO?=
 =?utf-8?B?bWM0NDJNNUExVjNxZFdhQzFCN2RhbWU5VVFUWTRXakt4VXR2RG1NZTRPVGxT?=
 =?utf-8?B?N0o1WEc3RXpIQWxoMTl0Q3pDYVA3bjNwQ29ncERTc1Vnb0RRbnZ5Q3VBemVW?=
 =?utf-8?B?dUJicm5hYldwTHVNcElnYjFSREd3ZGNoVXIzN3ZaaXpQalcwbENKSDdOVDY4?=
 =?utf-8?B?QUtxQ3FGZHFuYlJiSWZwUFRwclNsT2s1anhkTCtiWnh3OTdZazFZYUFTZ3NH?=
 =?utf-8?B?dWZmVUQ2UXRKbFZXdTZrS2sxdXVNc2phT1lvenliTHdmMjBBUFdYUnhxQkV6?=
 =?utf-8?B?TGZ1K1M0Z0V6T2p1ZC95U0tCYSszRTVaNGg3QWNRbk9iQisrNThmN3JqK25t?=
 =?utf-8?B?UHBJdUtqQkpuVTNQRXVjQkJ4eVhNRWl0dGVnazRrVjUzQlRXcHVJTkFrV1lV?=
 =?utf-8?B?NUYvK3o2VWhVQStQZWVSeTUzSUxjU2wyR0xEV3FLdmt2Zk5hTU05Z2VFencr?=
 =?utf-8?B?RGczNTRtWmN5MW5YMUdwTDBZcXpTSURrTTVXT2RnL1FmNElzZU1LU1l4YmpE?=
 =?utf-8?B?eG0wbjJ1b2hkSCtzUU8xb2IvSzFFYWtqVENXVlQzMFZUNXFQSkFyMmdNQ1Fi?=
 =?utf-8?B?aElyaDR5NHdxWXZEN1E4d3hTOXZXQUcxdVJsUGRuRWtiY3ZhTFE4THl6QzRP?=
 =?utf-8?B?em4vYm9NWmVQVTFOVFlIb2NibDBObHE1aEN5a3BjQlNGUGpQc2IrU0k4c2RJ?=
 =?utf-8?B?SkxtNXlMTmw0MDF6WFB2ZXFGaGwvOUJaR2k3Y3Naemt0ZjY1a3RTczR6bTVP?=
 =?utf-8?B?T1Y5OG9QcVZMa0pESUI0MHl1UVYzT0lXQkJHS0pVT2hmTFZmQXJzeDNGQkts?=
 =?utf-8?B?U2dIdHloY1lTQ0VPR2djU1lJU2dnR2RhUlRkYXkvb0xZUFhVSnJhblN2dXJt?=
 =?utf-8?B?ckhUWjRNVUs2RCsrWFJLVmM5N05vQUZCeGo0ZW9FUm5sTkJEQTFPaHIwcDNH?=
 =?utf-8?B?TFdJcGRLNVl6THBLZ1N4Z25MUVBQVEtzRmMzT2RRSE5tYkJpOFZtVDZsYm80?=
 =?utf-8?B?YkhGenFVb0paQzZibEVaa3p0OXFXbWIxSnlrN2JRS1lveG11Z3Z3eUdLN09X?=
 =?utf-8?B?N2pacmd6a2x1ZEF2OTgxQ055TVRxK29TVU82QjY0U1o4UkttL2JIeEFFSUVv?=
 =?utf-8?B?amZpU2FSdXpDeVZxSmp6Yk9EcTN4RnFEcE1nSTlPaDN1Wk8wSGQ0K1JhSm1u?=
 =?utf-8?B?MlhkT2FYbG5zaU93VzAvL1ExU2tyalJoL2lKaW1BdzlEazdUMDBKU0dObG81?=
 =?utf-8?B?WitmZG9pTGNWNFN6YnNSd2ZVU2ZkL1gyRU1mQkFLVEgvZnBvUUVXY2txb1U0?=
 =?utf-8?B?a0c4K2tMUnlScTNVK0JITWZuWnUvSUVvMytjRkk3dVRoa3RuRWhiRDkzRUkz?=
 =?utf-8?B?eW4vSlFkWmdXT2ZiOWpjaTFlNzBRVzZ6YjVZMXBlODZ2QzEvUmlCNFFFbC9S?=
 =?utf-8?B?VmZqZVpmWENVVDJMSlFLKzNzSE84TFpBUjRiQjVzZVA0bmJzQnZ1a1VaaWs4?=
 =?utf-8?B?cUQxSFljaVFHSzhjTUk2Vk8rVGZwUTAxTkYvQTVCWm5rTG5ZUzd1Y3MzS3Jx?=
 =?utf-8?B?RUU1WEdKN0MxQm9udzVtRDVvYzZFQkxxc25VUFpJdklCWWRZeG1NS0JPbFZr?=
 =?utf-8?B?WGRwYzBkZ0hlWDViN0JBRHRwNzMvV0h4MjZyM0gxbDI3T0ZRbUJhU2lIMWh2?=
 =?utf-8?B?L1YxaWxBd2hvZ1ZxTlFXYisrT1Y0WUl2UVI5TU9SUmF6aTYyRHMyRndkNS9t?=
 =?utf-8?B?elpTeXRTR2orbWFEeXlQNExuR3NjTGtEOTlHaVRlWlBEQUVFSUJuU3NSVXoy?=
 =?utf-8?B?MnVJcnNvNTZkUFgvOXU3dmJSUEVJM0FJTkJDbk56SFM3a1lwbHpSNEl5N0kx?=
 =?utf-8?B?UitWbUwrbG9hSGFnQzB0eHlWWlpYUzVYWTM5VFJnRzJBMnVjN05lR285OS9U?=
 =?utf-8?Q?5Y5MRhhIc+5V706DlI6qaAltx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2C2DCD8D1E87641A880B60FF48395A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EgZqbpo0KMhY/tAiOxyoLWqUKZovW6QME9m2Mc5Ndgvj03Q2/OB9S00UYbGZIZO3AjGFdCX8C+Ls53s/RuL791VBI901GeWJiXiATCa3T0PmMjXBVdYKtIBCQEDnxE3mQqCWS5F36tovlAwyozy7qI15bh8f7OFyZCR8qbnQ8l8Jt5shnc3nWuRUYNG3n6x0f+uKm9WehIEWz6w+QZnhQwnCqubx/id+TgKELhhWXAjUbWfpHqDAvoyfosb0Vfud2VTbYf/czDntL5KmiSRitfsIlIGnZqgqbZzhgNEvdcONUE8nll7hKGlAcnOAXgWpSXBrD6Ld7Me9VlGNNc+9tl1X2NR4m6ljukOalUuZ8NqXupxERMFKOwQ0ogEgc7ntzbZMlUg5eRyydWi/M6AK/hu69/gLPowBMF06NDV2/fqodWPntSB3cYehq9NHFezMhQjqOOquN5IQuP/+68Bjiy1LMxIEaBq+LZfIx+EEtR+mXylzgZF2R4vS3EZ4Xz+D9WiXPPcUb5tfRr4dQeUJgCNIfauQSNXEyt72AXVd8DMR1OcpVBR/XQOV3M0aP8dYqHQ0gBBSBrNYPgQc/keDAA4u779b7ApLZw6gNNyuKQmrcA5aHSC0FLd4+v5mNYnAd0RVGXqArdNF8IMQrGX0aQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7375a913-969f-4314-75d4-08dcbbeff835
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 23:30:51.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YFftiO0az6C6WQq2oZfM/Im1ghbOFjs1POxhiwLijcVcZ6FbiGQOZ5gjBMlM5I4utCiZZ+G+gUk3Q1TfsXxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
X-Proofpoint-ORIG-GUID: 8VnLO1fgEt4QqqU4QCYuuudi3pPq8ceH
X-Proofpoint-GUID: 8VnLO1fgEt4QqqU4QCYuuudi3pPq8ceH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130169

T24gVHVlLCBBdWcgMTMsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDA4
LTA4LTI0IDA1OjM2IGFtLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+IA0KPiANCj4gPiA+IEFuZCB0
dXJucyBvdXQsIHJldHJpZXMgMTUwMCB0byAxNTAwMCAod29yc3QgY2FzZSksIHdoaWNoIGNhbiBy
YW5nZSBmcm9tIDNtcw0KPiA+ID4gdG8gMzBtcy4gQnkgdGhpcyB0aW1lLCBjb250cm9sIGNhbiBy
ZWFjaCBzdGFydFhmZXIsIHdoZXJlIGl0IHRyaWVzIHRvDQo+ID4gPiBwZXJmb3JtIHJlbW90ZS13
YWtldXAgZXZlbiBpZiBob3N0IGp1c3QgcmVzdW1lZCB0aGUgZ2FkZ2V0Lg0KPiA+IA0KPiA+IFBv
bGxpbmcgZm9yIDIwSyB0aW1lIGlzIGEgYml0IG11Y2gsIGFuZCB0aGlzIHdpbGwgdmFyeSBkZXBl
bmRpbmcgb24NCj4gPiBkaWZmZXJlbnQgc2V0dXAuIFRoaXMgaXMgc29tZXRoaW5nIHRoYXQgSSB3
YW50IHRvIGZpeCBpbiB0aGUgd2FrZXVwKCkNCj4gPiBvcHMgYW5kIGtlZXAgZXZlcnl0aGluZyBh
c3luYy4NCj4gPiANCj4gVGhpcyB3YXMgZG9uZSBhcyBwYXJ0IG9mIGV4cGVyaW1lbnQsIGp1c3Qg
dG8gZGV0ZXJtaW5lIHRoZSBsYXRlbmN5IGluIERTVFMuDQo+IEFuZCBpdCB3YXMgYXJvdW5kIDMt
MzBtcy4gU2F3IHJoaXMgc2FtZSBiZWhhdmlvdXIgd2hlbiBwb2xsaW5nIERTVFMgaW4NCj4gX19k
d2MzX2dhZGdldF93YWtldXAoc3luYykNCj4gDQo+ID4gPiANCj4gPiA+IEZvciBTUyBjYXNlLCB0
aGlzIHJldHJpZXMgY291bnQgd2FzIGNvbnNpc3RlbnRseSAxLCBpdCB3YXMgcGFzc2luZyBpbiBm
aXJzdA0KPiA+ID4gdHJ5IGl0c2VsZi4gQnV0IHVuZm9ydHVuYXRlbHkgZG9lc24ndCBiZWhhdmUg
dGhlIHNhbWUgd2F5IGluIEhTLg0KPiA+ID4gDQo+ID4gPiA+IEdVU0IyUEhZQ0ZHLnN1c3BlbmR1
c2IyIHR1cm5zIG9uIHRoZSBzaWduYWwgcmVxdWlyZWQgdG8gY29tcGxldGUgYQ0KPiA+ID4gPiBj
b21tYW5kIHdpdGhpbiA1MHVzLiBUaGlzIGhhcHBlbnMgd2l0aGluIHRoZSB0aW1lb3V0IHJlcXVp
cmVkIGZvciBhbg0KPiA+ID4gPiBlbmRwb2ludCBjb21tYW5kLiBBcyBhIHJlc3VsdCwgdGhlcmUn
cyBubyBuZWVkIHRvIHBlcmZvcm0gcmVtb3RlIHdha2V1cC4NCj4gPiA+ID4gDQo+ID4gPiA+IEZv
ciB1c2IzIHNwZWVkLCBpZiBpdCdzIGluIFUzLCB0aGUgZ2FkZ2V0IGlzIGluIHN1c3BlbmQgYW55
d2F5LiBUaGVyZQ0KPiA+ID4gPiB3aWxsIGJlIG5vIGVwX3F1ZXVlIHRvIHRyaWdnZXIgdGhlIFN0
YXJ0IFRyYW5zZmVyIGNvbW1hbmQuDQo+ID4gPiA+IA0KPiA+ID4gPiBZb3UgY2FuIGp1c3QgcmVt
b3ZlIHRoZSB3aG9sZSBTdGFydCBUcmFuc2ZlciBjaGVjayBmb3IgcmVtb3RlIHdha2V1cA0KPiA+
ID4gPiBjb21wbGV0ZWx5Lg0KPiA+ID4gPiANCj4gPiA+IFNvcnJ5LCBpIGRpZG50IHVuZGVyc3Rh
bmQgeW91ciBzdWdnZXN0aW9uLiBUaGUgc3RhcnR4ZmVyIGNoZWNrIGlzIG5lZWRlZCBhcw0KPiA+
ID4gcGVyIGRhdGFib29rLCBidXQgd2UgYWxzbyBuZWVkIHRvIGhhbmRsZSB0aGUgbGF0ZW5jeSBz
ZWVuIGluIERTVFMgd2hlbg0KPiA+ID4gb3BlcmF0aW5nIGluIEhTLg0KPiA+ID4gDQo+ID4gDQo+
ID4gdXNiX2VwX3F1ZXVlIHNob3VsZCBub3QgdHJpZ2dlciByZW1vdGUgd2FrZXVwOyBpdCBzaG91
bGQgYmUgZG9uZSBieQ0KPiA+IHdha2V1cCgpIG9wcy4gVGhlIHByb2dyYW1taW5nIGd1aWRlIGp1
c3Qgbm90ZWQgdGhhdCB0aGUgU3RhcnQgVHJhbnNmZXINCj4gPiBjb21tYW5kIHNob3VsZCBub3Qg
YmUgaXNzdWVkIHdoaWxlIGluIEwxL0wyL1UzLiBJdCBzdWdnZXN0ZWQgdG8gd2FrZSB1cA0KPiA+
IHRoZSBob3N0IHRvIGJyaW5nIGl0IG91dCBvZiBMMS9MMi9VMyBzdGF0ZSBzbyB0aGUgY29tbWFu
ZCBjYW4gZ28NCj4gPiB0aHJvdWdoLg0KPiA+IA0KPiA+IE15IHN1Z2dlc3Rpb24gaXMgdG8gcmVt
b3ZlIHRoZSBMMS9MMi9VMyBjaGVjayBpbg0KPiA+IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKCks
IGFuZCBpdCB3aWxsIHN0aWxsIHdvcmsgZmluZSB3aXRoIHJlYXNvbnMNCj4gPiBub3RlZCBwcmV2
aW91c2x5LiBTbywganVzdCBkbyB0aGlzOg0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4
IDBlYTJjYTBmMGQyOC4uNmVmNmM0ZWYyYTdiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4g
QEAgLTQxMSwzMCArNDExLDYgQEAgaW50IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKHN0cnVjdCBk
d2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBjbWQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSwgcmVnKTsNCj4g
PiAgICAgICAgICB9DQo+ID4gDQo+ID4gLSAgICAgICBpZiAoRFdDM19ERVBDTURfQ01EKGNtZCkg
PT0gRFdDM19ERVBDTURfU1RBUlRUUkFOU0ZFUikgew0KPiA+IC0gICAgICAgICAgICAgICBpbnQg
bGlua19zdGF0ZTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIC8qDQo+ID4gLSAgICAgICAg
ICAgICAgICAqIEluaXRpYXRlIHJlbW90ZSB3YWtldXAgaWYgdGhlIGxpbmsgc3RhdGUgaXMgaW4g
VTMgd2hlbg0KPiA+IC0gICAgICAgICAgICAgICAgKiBvcGVyYXRpbmcgaW4gU1MvU1NQIG9yIEwx
L0wyIHdoZW4gb3BlcmF0aW5nIGluIEhTL0ZTLiBJZiB0aGUNCj4gPiAtICAgICAgICAgICAgICAg
ICogbGluayBzdGF0ZSBpcyBpbiBVMS9VMiwgbm8gcmVtb3RlIHdha2V1cCBpcyBuZWVkZWQuIFRo
ZSBTdGFydA0KPiA+IC0gICAgICAgICAgICAgICAgKiBUcmFuc2ZlciBjb21tYW5kIHdpbGwgaW5p
dGlhdGUgdGhlIGxpbmsgcmVjb3ZlcnkuDQo+ID4gLSAgICAgICAgICAgICAgICAqLw0KPiA+IC0g
ICAgICAgICAgICAgICBsaW5rX3N0YXRlID0gZHdjM19nYWRnZXRfZ2V0X2xpbmtfc3RhdGUoZHdj
KTsNCj4gPiAtICAgICAgICAgICAgICAgc3dpdGNoIChsaW5rX3N0YXRlKSB7DQo+ID4gLSAgICAg
ICAgICAgICAgIGNhc2UgRFdDM19MSU5LX1NUQVRFX1UyOg0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIGlmIChkd2MtPmdhZGdldC0+c3BlZWQgPj0gVVNCX1NQRUVEX1NVUEVSKQ0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLQ0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGZhbGx0aHJvdWdoOw0KPiA+IC0gICAgICAgICAgICAgICBjYXNlIERX
QzNfTElOS19TVEFURV9VMzoNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBfX2R3
YzNfZ2FkZ2V0X3dha2V1cChkd2MsIGZhbHNlKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICBkZXZfV0FSTl9PTkNFKGR3Yy0+ZGV2LCByZXQsICJ3YWtldXAgZmFpbGVkIC0tPiAlZFxuIiwN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAtICAgICAgICAgICAgICAgfQ0KPiA+
IC0gICAgICAgfQ0KPiA+IC0NCj4gPiAgICAgICAgICAvKg0KPiA+ICAgICAgICAgICAqIEZvciBz
b21lIGNvbW1hbmRzIHN1Y2ggYXMgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQsIERFUENNRFBBUm4N
Cj4gPiAgICAgICAgICAgKiByZWdpc3RlcnMgYXJlIHJlc2VydmVkLiBTaW5jZSB0aGUgZHJpdmVy
IG9mdGVuIHNlbmRzIFVwZGF0ZSBUcmFuc2Zlcg0KPiA+IA0KPiA+IFdoZW4gd2UgcmVjZWl2ZSB0
aGUgd2FrZXVwIGV2ZW50LCB0aGVuIHRoZSBkZXZpY2UgaXMgbm8gbG9uZ2VyIGluDQo+ID4gTDEv
TDIvVTMuIFRoZSBTdGFydCBUcmFuZmVyIGNvbW1hbmQgc2hvdWxkIGdvIHRocm91Z2guID4NCj4g
T2sgd2lsbCBkbyB0aGlzLCBJIGhvcGUgdGhlcmUgd29uJ3QgYmUgYW55IGNvcm5lciBjYXNlcyB3
aGVyZSB0aGUgbGluayBpcw0KPiBkb3duIHdoZW4gc3RhcnRfeGZlciBoYXBwZW5zLiBJIHdhcyBu
b3QgcmVhbGx5IHN1cmUgYWJvdXQgdGhlIGhpc3RvcnksIHRoYXRzDQo+IHdoeSB0cmllZCB0byBp
bmNvcnBvcmF0ZSBteSBmaXggaW50byB0aGUgYWJvdmUgSUYgY2hlY2suDQo+IA0KDQpJdCB3YXMg
aW5pdGlhbGx5IGltcGxlbWVudGVkIHZlcmJhdGltIGJhc2Ugb24gdGhlIFN0YXJ0IFRyYW5zZmVy
IGNvbW1hbmQNCnN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJvZ3JhbW1pbmcgZ3VpZGUgd2l0aG91dCBj
b25zaWRlcmluZyB0aGUgZHdjMw0KZHJpdmVyIGZsb3cuIEZpcnN0IGR3YzMgY2hlY2tzIGZvciBV
MS9VMi9VMyBzdGF0ZS4gVGhlbiB3ZSBmaXhlZCB0byBvbmx5DQpjaGVjayBmb3IgTDEvTDIvVTMg
c3RhdGUsIGJ1dCBpdCdzIHN0aWxsIG5vdCByaWdodC4gSSd2ZSBoYWQgdGhpcyBvbiBteQ0KVE9E
TyBsaXN0IGZvciBhd2hpbGUgYW5kIGhhdmVuJ3QgbWFkZSBhbiB1cGRhdGUgc2luY2UgaXQncyBu
b3QgY3JpdGljYWwuDQoNCj4gPiBXZSBkbyBoYXZlIGFuIGlzc3VlIHdoZXJlIGlmIHRoZSBmdW5j
dGlvbiBkcml2ZXIgaXNzdWVzIHJlbW90ZSB3YWtldXAsDQo+ID4gdGhlIGxpbmsgbWF5IG5vdCB0
cmFuc2l0aW9uIGJlZm9yZSBlcF9xdWV1ZSgpIGJlY2F1c2Ugd2FrZXVwKCkgY2FuIGJlDQo+ID4g
YXN5bmMuIEluIHRoYXQgY2FzZSwgeW91IHByb2JhYmx5IHdhbnQgdG8ga2VlcCB0aGUgdXNiX3Jl
cXVlc3RzIGluIHRoZQ0KPiA+IHBlbmRpbmdfbGlzdCB1bnRpbCB0aGUgbGlua19zdGF0ZSB0cmFu
c2l0aW9ucyBvdXQgb2YgbG93IHBvd2VyLg0KPiA+IA0KPiA+IFRoZSBvdGhlciB0aGluZyB0aGF0
IEkgbm90ZWQgcHJldmlvdXNseSBpcyB0aGF0IEkgd2FudCB0byBmaXggaXMgdGhlDQo+ID4gd2Fr
ZXVwKCkgb3BzLiBDdXJyZW50bHkgaXQgY2FuIGJlIGFzeW5jIG9yIHN5bmNocm9ub3VzLiBXZSBz
aG91bGQga2VlcA0KPiA+IGl0IGNvbnNpc3RlbnQgYW5kIG1ha2UgaXQgYXN5bmMgdGhyb3VnaG91
dC4NCj4gPiANCj4gU291bmRzIGxpa2UgYSBnb29kIGlkZWEsIHdlIGNhbiBtb3ZlIHRoZSByZXEg
dG8gcGVuZGluZyBsaXN0LCB0aGVuIGlzc3VlDQo+IGFzeW5jIHdha2V1cCwgYW5kIHF1ZXVlIGl0
IGJhY2sgb25jZSBsaW5rc3RzX2NoYW5nZSBpbnRlcnJ1cHQgaW5kaWNhdGVzDQo+IEwwL1UwLiBT
cGVjaWFsIGNhcmUgaXMgbmVlZGVkIGluIGR3YzNfZ2FkZ2V0X2Z1bmNfd2FrZXVwKCkgd2hlbiBt
YWtpbmcgaXQNCj4gYXN5bmMuDQo+IA0KDQpZZXMuIFRoYXQgd291bGQgYmUgZ3JlYXQuDQoNClRo
YW5rcywNClRoaW5o


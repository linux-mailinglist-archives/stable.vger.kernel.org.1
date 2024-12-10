Return-Path: <stable+bounces-100494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D19EBE92
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277BA18862E3
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 22:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCE1F1917;
	Tue, 10 Dec 2024 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nAjVskk+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HQa+qUwu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W8tD7j7n"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6C6204692;
	Tue, 10 Dec 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871119; cv=fail; b=rbCWo8z+rOBTlz8tV0a3DJeKbH3oTG6O8oVBUwR1awCrdpF7ydDIUrtiAbn14k73doTO+tKkGGhEjgvsXxGMk6jrIRIiC4Kxh/YzmOCn9zaybXEkakPKKSHE57I98kiUP7oczbQOKmmarjaYzaBK+H+qGcQV3vteQeMA4unlFG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871119; c=relaxed/simple;
	bh=7AIJrdRnNmHRLk4XgtWWPntEMnZaj/lBas2aLd+2Bbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdnJYZMtAcOOpIRVVLSnzFeu1R+ykE1ka4guO/9MpNinDQbeEetx8eWsvcjMo19Wg7PgZV36pH4NkyNSNbbcuqcKHlgVZRbhvGc+vPtKfIAc2O3fE0QyprzNMOM/oGziakKy9pcXC3k8T3rO+LGF20UZPACeMNDEVOj/ghHYTO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nAjVskk+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HQa+qUwu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W8tD7j7n reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAM2uMs017215;
	Tue, 10 Dec 2024 14:51:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=7AIJrdRnNmHRLk4XgtWWPntEMnZaj/lBas2aLd+2Bbg=; b=
	nAjVskk+n8lALnpVZQndKcxYu12TJRYgNxYs89k6kfsxOMwULEv1wrb7vPippkB9
	D38o6run/Ac02tWSKwM/yhetqnIfZk81ABzV2gKUOT4c9pSs6N3GIw2CMGxGP3FG
	mEsjXRtvdU3frN4Da0+WiMKhsaLVX6cQdcknhoJZXvCPqg2lAu8POXrxEJuNylhE
	XkMH7+4ZYaVkj4ZMX+2Bu1ACa+kkPvebd8VpxSSozhjwXex2dr5+LbletiPtaVDv
	h/1B6FkFjvA6Fv7WBSHiHjRvQvhqK4FidCcx+RRQSGy5oxjWmuZnrNozU76O73Sr
	LF5AJdewPZmtMEFwhVJeaA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 43cp60sk75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733871106; bh=7AIJrdRnNmHRLk4XgtWWPntEMnZaj/lBas2aLd+2Bbg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=HQa+qUwu5Kl/e862dGxRIki0pnmYtSumaqCB3fxA+LruDcbGuf1CfPH3gcJGTpinn
	 cCXfnt56iYV0u4QvzAv+DQ+fi7DkZDfLgEbrdwF9GgATzczHED88jBEQssqXIxGadK
	 RKCq708equ/cf2cTH+UbcSONL7rz3XnUTTFK1AW9StXdNbEKlAR/YBahwOzsurTPlr
	 noPvAwVL42PhHRKLWxVqCQbzLix7ZwC/xB3pwe0T2UtQ05kTB95G0WEFOtrIWrdLc/
	 Xnv6Jp1Bbb/FhJuHdsuseGa6cQA10R915bTZvnSee3EoaRyOYYW8pTLTacfNRpbKBG
	 hK8sqIAnXNHcg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 17AB340110;
	Tue, 10 Dec 2024 22:51:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C0D88A0082;
	Tue, 10 Dec 2024 22:51:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=W8tD7j7n;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2101B405D9;
	Tue, 10 Dec 2024 22:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj75FHf71KVadTYYqBZaMw5zKMJ4P/DEHq7yf2vwp4xY+N0F2G/jsGsdmahPG6pW61TlbrH6DV6n4cA6XAalLL8bKnBczG6pbSl2U/4fDGodPg0Dk9a8Qtyxv58ctEa1/EYTL+VI/OruMmSnDHrnSXbHhz1imzo5PZUvNga+hi8rN78qD9B9lmhVz5Wcjj/G1zO/uOkQ51qalHq0AjP6Rv0EfQXMOTKudce/X+wJwlK84F0WPgDDzIXQ1vi0dXkq2iMvBwsGqlIUjP+67txvPRizA61ZRDxWo+itmCK5zpkn1SR4K7K3v3QBJpT+tA4wC4CADv+jXRQwslDLM/fB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AIJrdRnNmHRLk4XgtWWPntEMnZaj/lBas2aLd+2Bbg=;
 b=HFbFB8kcIBcXOe59yNTY3nUC01UB6mIqkl1wuJcqFHP/DzhGO/Zga4JloYA0Jq8w0PEsX13Ct3d6q/iY+iDXVMzU+S8D51aNas3H8uMFLC/GvWjz/ojO/ImMNSpQXPnzBHFK9ACKatgL2/Ejex37f7ky8EDkWXWIf06jUpM6ksJH/ptOl9OKRAs8uRjGGt5X+2vzhG+tD31bFiEO7Slnbs+y8OVex2SY99QrjNQo1ANV1LP4+ppu31xMQoit6KgXQ40AL/P3wv4dBMEYdCdQVp9pleY8AP+QBKzs6wuTykmq7xojwmfymyA76PajEeGHK1OreK0iPt4k1xpDGnwNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AIJrdRnNmHRLk4XgtWWPntEMnZaj/lBas2aLd+2Bbg=;
 b=W8tD7j7nIGQwtRrTXjYOvD/320Mymy4j3ucmxMtBaI5Uq1b0TXfahiFkHvlrPyl/how/a5Rp/W3zGmhsdjUqzSnxqPzv9qgvmbrHK4SriLfx04dqwpHXFrGZt1XsxXt+9uGwMlVH8aetxn9MMoY8LrY7ke0k8dOiwKVshhQ69uw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 10 Dec
 2024 22:51:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:51:39 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <andre.draszik@linaro.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: fix writing NYET threshold
Thread-Topic: [PATCH v2] usb: dwc3: gadget: fix writing NYET threshold
Thread-Index: AQHbSjCSHdjtq7YA80qDyJ4dJV8slrLgF68A
Date: Tue, 10 Dec 2024 22:51:39 +0000
Message-ID: <20241210225122.5afdikznqgyweclc@synopsys.com>
References: <20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro.org>
In-Reply-To: <20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB6738:EE_
x-ms-office365-filtering-correlation-id: 3076f74e-e041-4401-a241-08dd196d3594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1dDTDY0SENSMzk3SjNzSGR2Q1M4Mk1TSUVIYWRCYkpYTFZLbkpYOUUwUWk0?=
 =?utf-8?B?ZFdqTzBqb3ZvdVpoSlQyK0UzVE52MGtXd1pFbXJJeGhMdUhNdkJMbTJKeWZI?=
 =?utf-8?B?NStGUTVReHFDaFN5OXNJdFZVaTA1UFpYbEVzNVIvZGVjSGRYaURDdUZYSjBU?=
 =?utf-8?B?cytXUEsxTGVZUnhndGVienowNzMwUC9ta0NuWndxdGU2RVVhK2RidkdQN1Qx?=
 =?utf-8?B?cmdEWmEzeWxmU3dhSWdwYk9lUTZuNHNEZDNmcERRay9CWlN4YXlKYWorT3lV?=
 =?utf-8?B?VG9EcklBc2VxTFprUVE3bjdSbXFNOWJvK1Fyd3RNNjhFdDR3ZzRKY2RmcUFX?=
 =?utf-8?B?N3RKdHB4ODdwb0gwanhrNGtIVnYzVWIzeHF3eGFnK0g3RlZVaEZYMWcvVnVh?=
 =?utf-8?B?ZDB1andldU51ZWF1NkpPYzZrU3hqUVNKQ0UyY21GK0JvSm1IWkhoZXhVbmZz?=
 =?utf-8?B?dUY2U25mODVuTXRJSitKN2pTUjdOZVVyWUE4MitXQlNBRzBpRzJBWkRjeG1M?=
 =?utf-8?B?VW5rd1V0SUxOS0xsQ3JJZlFrbk1yWCttOVFJdFEzTHNtbFhHOWY3bitvZlBo?=
 =?utf-8?B?RXdWWXl4VHlDUjA5ekFuOC9DNFZYbUxNcFUxdUk0eHhjTDBieHdBZXdqME5r?=
 =?utf-8?B?K3l1dFJYbjZ1RGwyajNnblFoSEpPaVlSVjhjb0FjaE1lK21PQ2R0dHhIc2FY?=
 =?utf-8?B?Z2M2cllDM3EyNGIrdG8zR3Q4Mk5yWEsxeHoxM24zODJtL0xNdWZnc1pBS1Nw?=
 =?utf-8?B?OWtUZHJ5YzhxcENudjNNNzJBTUxEU1ptanViTHdEWUpWbkE4TTlNclVSYXl6?=
 =?utf-8?B?N2pyMy9ERHVSMlBjTkhQNmVQd3prK0RzdDgyRmd5cnJvaHJhbnNSVVdwSzRS?=
 =?utf-8?B?YllHVU5BbStkZFBkaXFnNURRWFFIQmNNNmpja25BV25abEg2QWk4cEJTN1Fu?=
 =?utf-8?B?aExUQmJ1SzY4OEVLa256MytrdmtIcWwwV2NVRU1TWU1CL0k5Z3dkaWZsWE9W?=
 =?utf-8?B?d0VxaGMrUE01QUFySGVXN202OUxGNHdyMitVR3gxYXQzaEVRSmV1WGVrcUV1?=
 =?utf-8?B?SWxvbzduOXBIWk16OXljam54NzJpdHRhbGlTNjg4UE5tRjNKZlh2VEM1bkFL?=
 =?utf-8?B?d1dndmgxTDZKVkRJak5FUmlxZnIxaUJLRllUZnkyVTd6UGh4WTRNYm9PVm9E?=
 =?utf-8?B?Z29wUkQ0SUNvMk15WnF2UGFZbFI3ZDhkMUZJcDZBNFdHekJJOTA0Z3pnUGh6?=
 =?utf-8?B?UmY0RlNrRGwwYlpwQXBxcnl2RmErNy96ZE4vaVhBYUdBcDFyU0REUE5HTHVl?=
 =?utf-8?B?UlVlOFpXbTNhVm8wNUo0V2psWFp2MnVMUStxNXI2TE5wWG5NQkcyc01QdjIx?=
 =?utf-8?B?YVpRcmZtcDEvQ1o1TnRCbUw3azk2dXhKV2k5ZmJwL1FER3B1dURreXhWWkpm?=
 =?utf-8?B?cUpPTWtGWVRlK0kyMHVZNkM1ZUxOWFcxdUtHRTNqSFU2OGZ0TkZXL01XTndP?=
 =?utf-8?B?SllWVGpFbDMvWjNESUtiYjUyQ2s5Uy90aHMyRXN5dytoRkFrc1k5eFVvWENG?=
 =?utf-8?B?NkZPcXNsM0ZPS3BncEcvUlM5MldodjBldmlPRUhSbUVRWnRaYkFmYnBLTWJQ?=
 =?utf-8?B?dG5oRmRrZEFWWHIrWEo0SHR3cEc2YXZpT2J2U2hWRG54cW5FOU9tSEdWdS9M?=
 =?utf-8?B?K0xUUkpMaThxQzhHc1dkczBoZFZMcEh5bS94ZWNRbm80Y3lGcnBnbHo4VUh5?=
 =?utf-8?B?L1hOOW9uWHpCLzRjQnd3ZFVGN21jZkV6UG5jM2FGczE2UzhZaE84Ukg3NlJH?=
 =?utf-8?B?c252cThKR0ZlcU5WZkwwRmVrZEFCRE5Lc2FKWEc0VUV2MC9ONFNnbjlKVUJj?=
 =?utf-8?B?TE0zT0hRYlpxeThUY2ZabzdmYklobmRYdWtsR2pVTCsyTlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NC9ub2d3YUJscXVkb1JibDZtb1lxNEFGdmFiNVE5bHZib2I5Mi9GUFlaMjhp?=
 =?utf-8?B?Ymk0VmNuS05LN2Y0NVhPU09PaTk4VEkwenczb0hIZjdTM2ZsZExvZ0VIalNL?=
 =?utf-8?B?OE5YWExaRXY5cTNqRU5MYzJsWlc0MXVtSHNJY3lmOXpiQVZ1anZRYU1PaW5x?=
 =?utf-8?B?cmVvUEhJZVNaSHVvaE1ZdnVZQzN6L3Fia1lEd0ZsNGk4eVI3M1J4WFdOT2V4?=
 =?utf-8?B?V1h0L3kzMldiRDNuT3ZyeGZ5aTl2QXd1UWpZR3c2cyt0OFJ3OGNBWnlvVllK?=
 =?utf-8?B?cXVQQkc4cTNMU0pvQnNrbVFmK3JRQjNEcGZMcmhDNEIxVWtwNk1YVHdCWkFa?=
 =?utf-8?B?QWErUG4yOVBrWTR5RjNZMDBySGc1WGtnSERqRlJGWjVjcjlWcUVsTWpWZGsw?=
 =?utf-8?B?YjJxb0g1V1lSS0dHMlZLV3pab0ZVbDJEWTY3WE9UOWtIbHB3Ukh2RkwxZ3VT?=
 =?utf-8?B?ME16SWxOYVExc0wwVVg0dGU0RkdxdG9IRlV4L2c1VWs5L1c0K2NDTmNhRDda?=
 =?utf-8?B?aVFJR3pqRy9nbVUzM21VeG1uY2xUUmtwNG1GcEJiVUhGWm5BOE1SbU14UndM?=
 =?utf-8?B?WFVqb3ZkcFp2TGMxR01HNzd1L011VS9yOHhjSVhnb3EvUmkvTTExZDhmc0xp?=
 =?utf-8?B?MTlpaTlEMisvT3Z6SjZQRDczQzAwOWJMWkptWlBWSE82NTZvS1NZUjhmR3p6?=
 =?utf-8?B?VHJGVXI5SForMkRpcHlKQ2U5dlJCR0FOS0toV25FNFNZVUlTNXJLcjR1Y0JI?=
 =?utf-8?B?RXNHeFZuVlBNcHB1RFUxVzd2L29kZmZpMWM2L2E1anA1SUVsdmxQcU9rVFVN?=
 =?utf-8?B?RVhoMWdwWmkxRnhFQmUrem5UWU8vRmd0UHFLY0tIMWRQbURVOW9CdU0yQkxn?=
 =?utf-8?B?VjMyQWF2WWN3d0t3TXFoSG82Z0JmOElyZ1FzVHpDVGM2VFhUQXB0RUpiL0hy?=
 =?utf-8?B?aXJzWjJGN01YWmRhRUFhZkdhQlhWUS9FMVUrT2tQNitLQ2Y5TmV0TE1kdG81?=
 =?utf-8?B?ejF2ZTg4TjNUb0dkUGZ2MlBlazVpQkI0dlpCZUxydkJrRXRZN2xSd3FTbzZj?=
 =?utf-8?B?QTZvVGNKcS9SNDBOMUhPdE14amdHREVtOTE2L1RrT0c1SnJ0ZS9BcUV0bFA5?=
 =?utf-8?B?MHNwdnpjdmNWdFAya0ZIT3Uzd3Q5UDd6RElKUW5LdUNxQ3l1SXRUUkgzZ0pz?=
 =?utf-8?B?VWxIZ29JbUhPRzlzR2ZMUis2SGxlTkVqZVp6Z3hUdGNyT0VSRVB3SkNPOXEx?=
 =?utf-8?B?cXVlOXY2RUNiZXZ5VkZqaGZxU05yOUx1Rnh3UFpqbmorSnBBL0FlMWxrZ1V1?=
 =?utf-8?B?RndrZlNwcU1VS2xqUFVsa3hscW1vZnFlZzQrZmwvQUVtSS83dWJqblVnZnp3?=
 =?utf-8?B?bXFEVHhTbVZXUUc2UU1Wd3pzQnlrbC9tNmFndmdpL1BnWDVvUWVJeDN6TEww?=
 =?utf-8?B?Nkd1ZGtLSFZNSnZKN1ZsYzNJeU1HNnlqY2NNN0w0bmRUVGlWNHBNMnNzSjVD?=
 =?utf-8?B?T3ZScyszVGJsZUpXRlJ2dGt4VGJoalVhaXI2cFJkRU5rN1BKcFFsTFVGTTVK?=
 =?utf-8?B?K1pNbzU3SmNRNkVUanNHMkpXOS9SSjFZZ25pdlZYMW1ITnVHNDdTN2U0SGwr?=
 =?utf-8?B?cFIxdXdCQ2V1aU9UV28ybXlBQmtmUU1GdzFQNjJLblRhbU5FRTZ5M0cvVnNF?=
 =?utf-8?B?RG92b1FJTjIyRG9yQzR1dDdKOWtjeTdidTQzaUlmV3duNDRPZU5QL01wTWYr?=
 =?utf-8?B?SHpqTWp2bnNpcXJQVEpzVGVSb1lZek5QMFZXZnY0R3V0YWE2Q3FMd3BKVUY3?=
 =?utf-8?B?Y05DaElOcFc5RjNDTlVzRWloQ1lPMnViRkRMN3crdCtzazNsSWREdXI2N2RS?=
 =?utf-8?B?dXJYVHJwc2ZvVWV3cXR2a0lOTnh3em56K1lFdmJpY2srM3pPQlZ5cDN4Z0Iz?=
 =?utf-8?B?NmROa2I2OU40Tkp0NUZoa2lqSFhMcWRnc0xjdXN2ODVERGhDNmZIM2MyOWVj?=
 =?utf-8?B?YXhGdk9MaU1DUzkrUVFubXVzOVV2VFNEcU5GaUgxNUhDUXJ1OFhQMEJSM0gz?=
 =?utf-8?B?akc2YjRDLzRoYlJadU5mUHQ1dWlTT3l4bkRFRVp1NnphamloUUxvVG5PNGVW?=
 =?utf-8?Q?IZsi2OLf87mn61aqw4t8aPDdn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE37BDF39E1A0F478F75289F5BC83AA4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Z0UUDMQF34AemzlxCx41oJNsvYPmFjm0IIYUff8bX3JCC9Exz/p9mtrAilQ2vxQFBoHlRPGN4oH8k2pCCTrxPNjdb6pLwxPijnZH0kdUTfCmC6MK17wmfpbEVUCBsfJ7mIOAWXu1t9iMuKFKo09VOA+tzRALO1FLKj4PH8W92CFQJkfQNQN+o8vLm/muig4qbPYR0HE61MNa0Yy9D4Cz/hrIT8yuY43CAEXOpVRaK3wmig6OhhBcQ5R6llEyJ8iLqp4gRGw6l96fjUEq0hJ1HSaoFuvRqzqKAnodXLG25vVOGCFCIgkCDJIqwCTvIkH8yFae6eMeMSo30sPXAJ9EwxCPnc/vmuqp4dVWEOZqBOTr00nOcB/5c18h5+QpImL178Olu37jOnTKXs+gRQ5RfzW8vW24hWIeveddILvcYL+ftzG3M3IdW4t8Yeh5bmuNl+GGCwWKoF4pfga+8I1cwJ5NvBwT4TvFw+3HaJmf9P9dxHqlRw9jvkaD+NTNosDEvg22qVsNi3fdi9grSwGHnEJIXjZaPl6+7OpJLL94pFfO05LH040kxFCJQi28ju0H50dUbr5raNv0oXEeLsQjAFw28x8O42iV2aWPeJYzgFd6N/J/WqbvgzCu26+yoYvFLPBzneTuy8Htuss8kZU9w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3076f74e-e041-4401-a241-08dd196d3594
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 22:51:39.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtGDPTmpEMaK8ZvUk1om9+HwHjA7YTmXkNj/Ububu87ZdPW9IjSpEdbwigVHUPfcVlmoJ/cplpVP16W6D5he7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
X-Authority-Analysis: v=2.4 cv=Z9YWHGRA c=1 sm=1 tr=0 ts=6758c603 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=jIQo8A4GAAAA:8 a=4qzRAH8pN413FMayE24A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: UK3tGVHIFNVg3OqPLpSUj9bIzHwCBVK5
X-Proofpoint-GUID: UK3tGVHIFNVg3OqPLpSUj9bIzHwCBVK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412100164

T24gTW9uLCBEZWMgMDksIDIwMjQsIEFuZHLDqSBEcmFzemlrIHdyb3RlOg0KPiBCZWZvcmUgd3Jp
dGluZyBhIG5ldyB2YWx1ZSB0byB0aGUgcmVnaXN0ZXIsIHRoZSBvbGQgdmFsdWUgbmVlZHMgdG8g
YmUNCj4gbWFza2VkIG91dCBmb3IgdGhlIG5ldyB2YWx1ZSB0byBiZSBwcm9ncmFtbWVkIGFzIGlu
dGVuZGVkLCBiZWNhdXNlIGF0DQo+IGxlYXN0IGluIHNvbWUgY2FzZXMgdGhlIHJlc2V0IHZhbHVl
IG9mIHRoYXQgZmllbGQgaXMgMHhmIChtYXggdmFsdWUpLg0KPiANCj4gQXQgdGhlIG1vbWVudCwg
dGhlIGR3YzMgY29yZSBpbml0aWFsaXNlcyB0aGUgdGhyZXNob2xkIHRvIHRoZSBtYXhpbXVtDQo+
IHZhbHVlICgweGYpLCB3aXRoIHRoZSBvcHRpb24gdG8gb3ZlcnJpZGUgaXQgdmlhIGEgRFQuIE5v
IHVwc3RyZWFtIERUcw0KPiBzZWVtIHRvIG92ZXJyaWRlIGl0LCB0aGVyZWZvcmUgdGhpcyBjb21t
aXQgZG9lc24ndCBjaGFuZ2UgYmVoYXZpb3VyIGZvcg0KPiBhbnkgdXBzdHJlYW0gcGxhdGZvcm0u
IE5ldmVydGhlbGVzcywgdGhlIGNvZGUgc2hvdWxkIGJlIGZpeGVkIHRvIGhhdmUNCj4gdGhlIGRl
c2lyZWQgb3V0Y29tZS4NCj4gDQo+IERvIHNvLg0KPiANCj4gRml4ZXM6IDgwY2FmN2QyMWFkYyAo
InVzYjogZHdjMzogYWRkIGxwbSBlcnJhdHVtIHN1cHBvcnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZyAjIDUuMTArIChuZWVkcyBhZGp1c3RtZW50IGZvciA1LjQpDQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHLDqSBEcmFzemlrIDxhbmRyZS5kcmFzemlrQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiBDaGFuZ2VzIGluIHYyOg0KPiAtIGNoYW5nZSBtYXNrIGRlZmluaXRpb25zIHRvIGJlIGNvbnNp
c3RlbnQgd2l0aCBvdGhlciBtYXNrcyAoVGhpbmgpDQo+IC0gdWRwYXRlIGNvbW1pdCBtZXNzYWdl
IHRvIGNsYXJpZnkgdGhhdCBpbiBzb21lIGNhc2VzIHRoZSByZXNldCB2YWx1ZQ0KPiAgIGlzICE9
IDANCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvci8yMDI0MTIwNi1kd2MzLW55ZXQtZml4LXYxLTEtMjkzYmM3NGY2NDRm
QGxpbmFyby5vcmdfXzshIUE0RjJSOUdfcGchZXh3VDVYUEF5czlTOGw2Unl5VmFreTZBbktEMnN3
TnEtYmpZczV6YTZxUXZrdGZTUzgxMkNIWkdoLVU2b1BPdTFySXVKLXRQZTlUV0lFc0lIWW5iYk9t
c1JmcjckIA0KPiAtLS0NCj4gRm9yIHN0YWJsZS01LjQsIHRoZSBpZigpIHRlc3QgaXMgc2xpZ2h0
bHkgZGlmZmVyZW50LCBzbyBhIHNlcGFyYXRlDQo+IHBhdGNoIHdpbGwgYmUgc2VudCBmb3IgaXQg
Zm9yIHRoZSBwYXRjaCB0byBhcHBseS4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aCAgIHwgMSArDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNCArKystDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgN
Cj4gaW5kZXggZWU3Mzc4OTMyNmJjLi5mMTE1NzBjOGZmZDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBA
IC00NjQsNiArNDY0LDcgQEANCj4gICNkZWZpbmUgRFdDM19EQ1RMX1RSR1RVTFNUX1NTX0lOQUNU
CShEV0MzX0RDVExfVFJHVFVMU1QoNikpDQo+ICANCj4gIC8qIFRoZXNlIGFwcGx5IGZvciBjb3Jl
IHZlcnNpb25zIDEuOTRhIGFuZCBsYXRlciAqLw0KPiArI2RlZmluZSBEV0MzX0RDVExfTllFVF9U
SFJFU19NQVNLCSgweGYgPDwgMjApDQo+ICAjZGVmaW5lIERXQzNfRENUTF9OWUVUX1RIUkVTKG4p
CQkoKChuKSAmIDB4ZikgPDwgMjApDQo+ICANCj4gICNkZWZpbmUgRFdDM19EQ1RMX0tFRVBfQ09O
TkVDVAkJQklUKDE5KQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggODNkYzczMDRkNzAxLi4zMWE2NTRj
NmYxNWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNDE5NSw4ICs0MTk1LDEwIEBAIHN0YXRp
YyB2b2lkIGR3YzNfZ2FkZ2V0X2Nvbm5kb25lX2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
PiAgCQlXQVJOX09OQ0UoRFdDM19WRVJfSVNfUFJJT1IoRFdDMywgMjQwQSkgJiYgZHdjLT5oYXNf
bHBtX2VycmF0dW0sDQo+ICAJCQkJIkxQTSBFcnJhdHVtIG5vdCBhdmFpbGFibGUgb24gZHdjMyBy
ZXZpc2lvbnMgPCAyLjQwYVxuIik7DQo+ICANCj4gLQkJaWYgKGR3Yy0+aGFzX2xwbV9lcnJhdHVt
ICYmICFEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyNDBBKSkNCj4gKwkJaWYgKGR3Yy0+aGFzX2xw
bV9lcnJhdHVtICYmICFEV0MzX1ZFUl9JU19QUklPUihEV0MzLCAyNDBBKSkgew0KPiArCQkJcmVn
ICY9IH5EV0MzX0RDVExfTllFVF9USFJFU19NQVNLOw0KPiAgCQkJcmVnIHw9IERXQzNfRENUTF9O
WUVUX1RIUkVTKGR3Yy0+bHBtX255ZXRfdGhyZXNob2xkKTsNCj4gKwkJfQ0KPiAgDQo+ICAJCWR3
YzNfZ2FkZ2V0X2RjdGxfd3JpdGVfc2FmZShkd2MsIHJlZyk7DQo+ICAJfSBlbHNlIHsNCj4gDQo+
IC0tLQ0KPiBiYXNlLWNvbW1pdDogYzI0NWE3YTc5NjAyY2NiZWU3ODBjMDA0YzFlNGFiY2RhNjZh
ZWMzMg0KPiBjaGFuZ2UtaWQ6IDIwMjQxMjA2LWR3YzMtbnlldC1maXgtNzA4NWY2ZDcxZDA0DQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tIA0KPiBBbmRyw6kgRHJhc3ppayA8YW5kcmUuZHJhc3pp
a0BsaW5hcm8ub3JnPg0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=


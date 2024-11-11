Return-Path: <stable+bounces-92174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF049C4A7B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 01:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B0CB33208
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2041C9ED7;
	Mon, 11 Nov 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="agXqckfw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WTgmKeiJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nTunubHU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BE1BDAAE;
	Mon, 11 Nov 2024 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369252; cv=fail; b=LiFehLWha44DEUVN45cJIrnYeR3h1M3IAYpluqUnxTyHaDcOlvGTq1Ozkn0nsXcr/VeORlLVpgDZW0LB89QB5aiUbOolaLzksW+IdgjrvK4UqI5NH1lGPDAp4diTZqHuAXUUI8Z1U4n2AOhuHSAQCUYERO+mAGYAT0FX/Hu/A9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369252; c=relaxed/simple;
	bh=1iS/v2b9VIouDC2KR9cccxI5hKr9liPHLpcu4c399Nk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DWJ8CS6iwKfm5ixygJqvEgSsfx14SuAdkeqg5fJvfR3hcdaHtUZNDdOpQ0/6v9yLo4hjF4B9VzV9iS5V4SVhKNkOh08Trub0Zx8utqqnsb8DsC5lZZ/lc6ZdiQHbbgYmL6p5ZCCIKqH4BNkxIfB+LZIqyZAzlAM4kq305MROdP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=agXqckfw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WTgmKeiJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nTunubHU reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABN4ZHD006814;
	Mon, 11 Nov 2024 15:53:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=1iS/v2b9VIouDC2KR9cccxI5hKr9liPHLpcu4c399Nk=; b=
	agXqckfw33lmtfZfK5q4q3HWZ9b3rw66bni0nZlPhbrcHCrtpDlJsNRNl3/0qzxK
	iJZh3BADjpmYWVV9Wuf1XKgDbOwEP+IPHJJuWzrtJ2fiMAQchEPIsmQPSH4cS6sI
	yXGcDS63lwPKCwwy60Is+cXz2c61QKUq5L9nfG91Ep63CgDFPUk0xL2P6plPqMMs
	tkKF2HYpHneUIqbjdz9cU5V2A9/FGTlFBgLIg2ZXf6cDpGXTGss17KQAI6yAbAP9
	hiGGYsfgnleTnV2TVJNnv/IRK7lOwCRsr0qwT+OiupI9YC2zh6okXGPhK5swkvKG
	oIlaRdePXy3zMnADyaU06g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 42t78kmb7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 15:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731369234; bh=1iS/v2b9VIouDC2KR9cccxI5hKr9liPHLpcu4c399Nk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WTgmKeiJyBhVutYaT+KDmwK6j6/ZhG5tS8eVkv+x44H8Qi5csyg13mC3sfIAfUCXc
	 OiShDdaCCZAeu0OcE/6jP+b2haMnEHg7NuiJrStUG6uElSfUg6V+RuZEm9whnWLtPa
	 jImh5KU0gQ3/Y95SZd0NNdiSDqSLey/kJ3WczPJZM1LyRWAlyEfpJxFHpw+LaVzfnT
	 1s42C6Uh0t5IAcMJZzcWJdCiAyH+1wbRylXtgmSJn04VnG+otjBiaj2FTfdZm0DU2P
	 XFofcxwV1Xy/Znew20f8UMHpjYAFG8T1shVLnJHzJu70QT7PKM6s/3K1FUtDpL/mQe
	 Nc+CwwGAu140A==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1564640147;
	Mon, 11 Nov 2024 23:53:53 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8EB19A0070;
	Mon, 11 Nov 2024 23:53:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nTunubHU;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D651740114;
	Mon, 11 Nov 2024 23:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrlZXKk8ZU3wovMnA8vwVQ1amA774ZX3nG085oOutHzRjwN1/+u5rA4aX8Xc5NDgcRn+j44qJToPZCA8wWYcj4d8QIgHEqc1RRhs3VL7i9fPjZbItlyYwQr5J9wTvGi/wIlblcdnxzVG35lc28f2lS2FYdXF9aWDxF97i1ed6DGkxwssVgXoOOR1/mukHOkzygVJmXQpfQE3bvpd+cacGokNyoDhim8SEtTxLQQ3V0oyMm0xrC1Rw9Gpp743njdWpjYzX4ttq5UkdHoErQWzLkcUfyiw0qeNIv8TV7URbTQJ5koA846/Wplk4QLkZcG3CpwIDRSKw7TqVqQO4bW++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iS/v2b9VIouDC2KR9cccxI5hKr9liPHLpcu4c399Nk=;
 b=Daxz0ONQNtt5FtvbfCQ0jkKkn6IXFYrj3RS9yzfJj2UWbbI7qNO6mkkCtuIlZ11ewiga52GRA7KR8whCsmQKKrIwsXw4PCWzBhbZuPtl+kmzSdVRhSn+aq9Be2zYFOR6jEyfV9wk98yF/6iEWjO6VMw+GYbX6svbV8MMCchUhdZ80Ej/YV6+RFlEnwUG/u9JxD5fio0/jtNH51WO/Mr6sjWQQQjqqHPShRbNG5LnIsRb16Sh1PmBq/k2GRDLZocaWD6rzSj+R1s8xgQxbx7zr3O9rPg7SA30zo75E7x+gtHSdHASOCmxZbWjBXczSXdM9CRNVb5uyP1DqIgow/KZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iS/v2b9VIouDC2KR9cccxI5hKr9liPHLpcu4c399Nk=;
 b=nTunubHUydOEtHlA5P2vzkCcIsKUJH1LFcOfBU0opQRv6udT7Mq3V6Ou+1yhLyr+AaRwfQbrDFSJUQyp6aej0rfKzggmJkR61LE9xZ+KLGpEv56hTAP8ixmBfY3T3Oqqw9UR9dJAc3/WIkiIuxKulUvogDodQl/fTzNoPGdtmdY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 23:53:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 23:53:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Index: AQHbNEULP/y5D9+7QECCHsqfmPtsvLKywVmA
Date: Mon, 11 Nov 2024 23:53:48 +0000
Message-ID: <20241111235345.2vpht6ck2bwojdc7@synopsys.com>
References:
 <CGME20241111142135epcas5p32c01b213f497f644b304782876118903@epcas5p3.samsung.com>
 <20241111142049.604-1-selvarasu.g@samsung.com>
In-Reply-To: <20241111142049.604-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8028:EE_
x-ms-office365-filtering-correlation-id: 44470194-1494-4392-3d59-08dd02ac161e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXZuRHcrMC91R3RPR1VGY2doQkx0bVRFM1M5YnFLV1R4M2ZxVGZ3ZjJja3lN?=
 =?utf-8?B?T2hBSmY2S1NjVFJuV2tIQXhxeHovMmRkcnRqNElDQUdFOTdra0wrRHlRSmU3?=
 =?utf-8?B?MjBCNWpzczhoaGJaK2lvNnlQdjVtTDhlaWlieUdWWmNGRHljUHl3bmtXRmJ5?=
 =?utf-8?B?WlZFcWdPUmwzS1RWUDgrSDA5Z0VOVXprV2MvdSs1YVgxTDFPUXVrNUUvZWhv?=
 =?utf-8?B?NXR5djFMbjBjcWRZTmFuNzVDalNUUU1LMEUydll3YUl3Z3pEVUp3dTZsWFdz?=
 =?utf-8?B?T3pjcWpha1NLUjRLaVhOMVY0ak1MWXRpUUJZMGhLYitiY2VFdDJqcVZaNkU1?=
 =?utf-8?B?TmJadHU5WnhrZkFtSTZTeTBkenMyZjl3T3EyRUt1VHJWZ0dzdjdWam9hR0Mw?=
 =?utf-8?B?T1FpcG5kY3VZV25oZEZhUUJMU1FEVWJnTHpPM3NzRERwRGpGSVVNV3lSMXFk?=
 =?utf-8?B?S3JoTUJSWTRUN0MxUy9mbU5PL1JmamN6OGpVYUdLTFY3TVBUNm9xMmpKUU5n?=
 =?utf-8?B?aGxkVkZEdE80am4wbDVPSjlzREFQNTJHRVUrR2JXL1dpc3JDSWVFVnZkZW4y?=
 =?utf-8?B?aFRsQjlNU2ZuRVlLNUIxckZKWkRyajRpMXVmamlaaHdScUtoYTJnWGowT0Np?=
 =?utf-8?B?eVBPMjNHcWFEWE16YXUwVExzcWtOL3Z4cnRFY0EvTytXKzZ5b2JOV21ndDlQ?=
 =?utf-8?B?Y0lNTSsrVk9pNVY2UHZ4cEJaeGJtQ0VmZXZEODhFZUJBV3pnSDJRNTFUdUtE?=
 =?utf-8?B?OVhDRlh1S3QyQkhlVVFHS3QzNjVGbEtqTFdZVUc1bm0ycFBnTFFPMVliWGUz?=
 =?utf-8?B?cW9nTEc4bkYyaWxSYi90Z2JrL0hhZGZmdTBudGx6K0JiNEZuQi9DZWlmUWdF?=
 =?utf-8?B?Sk5LTGJjVFhUL0o0Q2hLd21MaXMrVm5CWk9nc2pYNURoV2pNQUI0eW1qbzVm?=
 =?utf-8?B?amlvdVJMbzVKLzJtbWNzVnZNM0ZmZ1pMa2pzTXpVa3RNbnk0c0xvN29rdHVu?=
 =?utf-8?B?VXBBS1p6V2dMTVVlQ21yWTEySGwrb3l2NjV5K1pnUEhrZXhicHhUME9DUW5N?=
 =?utf-8?B?WWJxTDVmUjJnZEFYaUlqb2FjU1FxNUhQdFIzd09tYXphUCtPTEc1YUZCSllR?=
 =?utf-8?B?Z0xxdXorQkJYZ01zVy9Ed2JEdVcwcHR0K3dMRzVMSm4vK2hIWEx6djhHdkEy?=
 =?utf-8?B?cy8xdzJ6dTdReXVCOW14bkt0SkZyOUUyZ01GQ3dObnk1V3BLL1FpcC81SnJa?=
 =?utf-8?B?N1ZzQjhkTkJxcDBKQVBaMlZsK2p5ZkVZem53RFlxVnB5TUI2ek9MNVljSElm?=
 =?utf-8?B?VFdHbklJTE54L3NIdjI0TFBEM01kaUFxYlZKSmFzZGJsNUlzV1VvdzNuN2xo?=
 =?utf-8?B?WlhaakR1SDhIQ0wwMWw5Wk56TjJmUHZkSjVkWWxHR3ZwQ21FaitWOFlrTHo5?=
 =?utf-8?B?ZThhbzVJQzNEcWI1QjlhaVUrK2xmS3VhVzJIaHlNQ2g1SEhPeC9TTnhDcHAr?=
 =?utf-8?B?ZWRMbDc2Qm5ibFc3Rldkc2VnNGNYcjROeWJVOUx1OUNkV1RGOUk1RFNVYTBw?=
 =?utf-8?B?NkJrV2J0blI5ektRdHVHTDQ0eGdZemxXMkFVOXB1YVFYSmZaNmM0a0cxWFJM?=
 =?utf-8?B?VHgxK3dCbUVWWUtabXczSVhEaFp4MVNSRVJUbTFxT3p2cVRVTGg3MnRpUmhR?=
 =?utf-8?B?Z282OXE0MzdlcVRaTGdsaURZTmN4WmIzUjdwcUkxTmFEeG5mL0pTWXhRenQv?=
 =?utf-8?B?dnhQMFQrRURuR1BsL3hac0JYRzZJb0JNaFZwSEd4Y2JZcDl5WjhzdEJXQWJ1?=
 =?utf-8?Q?gKhoPqERvzAkSPsGX+fahZ3QapdcXZU3oTMUQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aG51MUVxRUlVSWo0YktsdlJFWXhodlNQU214TUN3azQvZG9tTXd4SGNwN3VR?=
 =?utf-8?B?WkhUOTM2Mk9oakVxc2UyYzVKem94Z3FEWVlIN1RZTS9rc29UaC9SQ0FlZ1Aw?=
 =?utf-8?B?THFBS0ZoSitoMnB5cjVBOU11bWRSNW9JK0x6NjlKdkVXSHFmQ05ZUG1iTG9M?=
 =?utf-8?B?a0ZZRm9jSFhHb01sUDRCcHY4bXNxS25jclVsQytGT3FwQU1FOUZlTGdPbUNJ?=
 =?utf-8?B?dVRhNkFtcTNHYTZuTUpwU1pDOGdScW1US1ZMd0llSzVQTENKY2laSlA1bWt6?=
 =?utf-8?B?M3RET0p5K3BteitzZ0lBRTF2NWZIRVlaeCtodDdlU0IwaE56UFhjTXhqbHlJ?=
 =?utf-8?B?N3UreWs1Sk01TkxIYkJKckxDSkMvVXNVdUU4M0NJSkRHU3p1U21JR2JaNmE3?=
 =?utf-8?B?azFyYjNNc1pzTVIwZW5mQzU1VHVpS0hEa2FNU3VESDJuVyttRlVoQjlxVjhD?=
 =?utf-8?B?YlE5b01ZSitRc1U4V1JjS2R4VVRjNXNGQWswbDR2VUl3elpmV21wc1NTNlBQ?=
 =?utf-8?B?Y0t0bDdSV1gwejM0RWFlRXR1Wis1ZVNHZk52NGFNc3VncktqRVlud1RxZjhQ?=
 =?utf-8?B?eHJBaEdYT0NaSUc2d01HOFUwRmRocDltNjQ2WjZycWwzK2wxOFMrMmNWUHN4?=
 =?utf-8?B?U1ZmR2xtRGplNU5yVzBSSzhTbXF5cGxpbWl6Skx6UDdCSzl6T2RFUnhNSjQ3?=
 =?utf-8?B?dHZUcGphaHJUWlZFSStTWndIbXhVRmY1MFFldWdXci9ONittT2NTY0tkb3Uz?=
 =?utf-8?B?aXNqeTdBdHk4ekhselFrcTJLTVhNTFNQYkVJU0JNK2R1SHBUREpqeVNvZkZI?=
 =?utf-8?B?QU81M05Id0lUM2dNckg5clBkS0VCa3o5ZWpsOXZiY2ZtUCtJZmNudndtYmFy?=
 =?utf-8?B?cXpiaTAzUXZpV2dhaVVRZjVJYWNJSkxpQ2lONFQrdzNDbXZPbmtQSjJWYnRE?=
 =?utf-8?B?a05iaWpJWTVPcTROMWpoNDdoVGNRR1NPdjZXcng5K0ZBT2orcklHSCtWVlg2?=
 =?utf-8?B?cndrelQyT2ZsUG5QaEtEaWptdUdvZTdYV0JZcmZ1K29kNGZTcERtMng4OFUy?=
 =?utf-8?B?dmF5VWpOOVRVays0MXJ3NlVPVjZ3SjROaFBoeEl4dnRPR2JhWnV5elFSUm5T?=
 =?utf-8?B?QTVnQXpoaWFQWGd2dEdBa2RvbUlHcTNFZi9MUGY1SWIrY1Rkb0xUNy9ldzBW?=
 =?utf-8?B?cjc4d3djazljS1puWFdMck1nZ010ODVwS3diY01WcCtVQVJEdWFxRG5WVVdM?=
 =?utf-8?B?S0JXaHJlcko3YnVJMHBwK1JnaENyQW1BR2tQMXJ4NDMybm9HL3VqY2NtWWtp?=
 =?utf-8?B?UzVVRHFNVUtqUStzNVlrNFBrQWN3QmlEZkExcTdxMFBUQlZPdUhTNDlGTUgy?=
 =?utf-8?B?WHM4Q0JqYnhOYThNOVdZVW9ya0Mrd1JndkFEaTNKK1crSVNvVnI2cVhwZmlW?=
 =?utf-8?B?TVhKU2xxMDdrdVh3MGM3UEJVWlkyVEI1M1Z0OFlEaWdCeFFCUFlXRkZLbGk4?=
 =?utf-8?B?azBvTzNRUS9TUGN4enl3dDl0MnkwUkxuYUo3Tnk3b2JyRU1qWU5MZTJhU2Nu?=
 =?utf-8?B?MTJKK01LRnVSZFRrSTRSd2NJb1VmdUxGY0FVaEZRQ2tFY1NaY2tCOEtucGFD?=
 =?utf-8?B?ZCt6MGwyUHdJSFcrSHpwcVdpTzd1TzFoVHl4SWpaQWpEV3UyblBqSC9kamFh?=
 =?utf-8?B?Z1N6RW1oUWpsZkgyL1FhMVBvUk5jQTNkMkZ5ZHVRcW0xd3VBc1ZYNkw5ays1?=
 =?utf-8?B?dHpFUExSQ2xET0txU3lWaHdPeW9saUkxS1VBMVVhaUg1Mm55SUx5d0s0cmU4?=
 =?utf-8?B?WkJKRjlDdXZDMXdtZzltTSsza1pxc3J6UURBWDloK1NCSE1ZYjVxQnUrVzI0?=
 =?utf-8?B?cHVJTGV0ekorUjZnem9ETURaQWtHOWpQS1lES3B6Rkd3R1Z4TGpIUzB6WEEv?=
 =?utf-8?B?S3laam4vOExBa1cwYldTNWczYVhsYmZGNnVjd2xxUjVGYzdZSUQ0clJNR244?=
 =?utf-8?B?OTZVMnlrSW12aWtRQlY1MWdOWDRpMmZ6NE1zRDI2bXZxR3Z5ajJGLy9lZ0Ix?=
 =?utf-8?B?WnpJbE1hNFpGSXIybHdmNlZKdWdtd09PbGRoa1FRcWVoZHFLQWovTUVrYU5C?=
 =?utf-8?B?dms4RlZKWmdxbGQxUE45YU1FNWtpV0o0MTZ5OGRJemVISGh1Si8zbjZScFpW?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C6A95B49CCF946A1E19D46A910C9F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	noWaMPm6Bfs4jRMIYYWuS5wPjnNlranWEGtaUE6i/NLd4JJvQfuZDwOEEhbax/0rPRDLNbFY+gNUql+IYbgGtGZly20YRtyy+OgRdXb/zCkK8RJhLEBRNBFGQ6mxgMDVrw+Rmg5TtQ+UaA1qFfBJfCr3od5nYm/TD0lloJNObMa4PGE9MO1ZFiV6KK1hPTss7PWOa6I5Uc2LmuczMLjI6YK5ROHZQDlyV0YfxE/ndwYWOZVyGaKDBSQErulJJIkCwah8wfJQJrTov1SmnDbZo3MXAAozZP/uAc6OQk9Y+yzONemq9pdg0wl0avVNXiRCa0n8025nYalPzyHTcn66yZ+mfDlO+R3zRTj3zeDvHf35ezTXu/RfrAq+6/ELL63CtM/vMAKeXBQhIivcmVBv2ak8dG5nsLYF9v3dV0o7C4cMBpEccspBQD/3Oh6hJ6tewtazjVNrIMdA2xOyzJSJDhVa81jgA8xm6fLFqTtIPI18/kfYzsmzGgOMUKp6tQ56lbom7vPgqZs/KFxmxetUO8OP5JNtnBpv7xyw273FyH64quFYywgswL987wAMtJvpUxb7CKLW62inkpSwHdJLalmB+kLKf1L73fFnBIpNVPRqDUtRvOxwpN66TB1nPWXJ3dcnea212mGz47boARncMQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44470194-1494-4392-3d59-08dd02ac161e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 23:53:48.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKk2oC3y8rkSoM4pHvWCTqkkExfmVssMxfWOYBQC9gxkEiSQsNxvsKqI3RYrgQsJE0eo/MK3ydruyjRnpvxPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
X-Proofpoint-ORIG-GUID: Srhe0Jymzc66Vfid7c1r4qCutCADVIWw
X-Authority-Analysis: v=2.4 cv=NPuH+F6g c=1 sm=1 tr=0 ts=67329913 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=es7jtOQpjM_ZVYCrN4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Srhe0Jymzc66Vfid7c1r4qCutCADVIWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 phishscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110192

T24gTW9uLCBOb3YgMTEsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgZXhp
c3RpbmcgaW1wbGVtZW50YXRpb24gb2YgdGhlIFR4RklGTyByZXNpemluZyBsb2dpYyBvbmx5IHN1
cHBvcnRzDQo+IHNjZW5hcmlvcyB3aGVyZSBtb3JlIHRoYW4gb25lIHBvcnQgUkFNIGlzIHVzZWQu
IEhvd2V2ZXIsIHRoZXJlIGlzIGEgbmVlZA0KPiB0byByZXNpemUgdGhlIFR4RklGTyBpbiBVU0Iy
LjAtb25seSBtb2RlIHdoZXJlIG9ubHkgYSBzaW5nbGUgcG9ydCBSQU0gaXMNCj4gYXZhaWxhYmxl
LiBUaGlzIGNvbW1pdCBpbnRyb2R1Y2VzIHRoZSBuZWNlc3NhcnkgY2hhbmdlcyB0byBzdXBwb3J0
DQo+IFR4RklGTyByZXNpemluZyBpbiBzdWNoIHNjZW5hcmlvcy4NCj4gDQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnICMgNi4xMi54OiBmYWQxNmM4MjogdXNiOiBkd2MzOiBnYWRnZXQ6IFJl
ZmluZSB0aGUgbG9naWMgZm9yIHJlc2l6aW5nIFR4IEZJRk9zDQoNCllvdSBzaG91bGQgcmV3b3Jk
IHRoZSBwYXRjaCAkc3ViamVjdCBhbmQgY29tbWl0IG1lc3NhZ2UgYWxvbmcgdGhlIGxpbmUNCm9m
IGFkZGluZyBtaXNzaW5nIGNoZWNrIGZvciBzaW5nbGUgcG9ydCByYW0uIEZvciB0aGlzIHRvIHF1
YWxpZnkgZm9yDQpzdGFibGUsIGVtcGhhc2l6ZSB0aGF0IHRoaXMgaXMgYSBmaXggZm9yIGNlcnRh
aW4gcGxhdGZvcm0NCmNvbmZpZ3VyYXRpb25zLiBUaGVuIGFkZCBhIEZpeGVzIHRhZyB0aGF0IGNh
biBnbyBhcyBmYXIgYXMgOWY2MDdhMzA5ZmJlDQooInVzYjogZHdjMzogUmVzaXplIFRYIEZJRk9z
IHRvIG1lZXQgRVAgYnVyc3RpbmcgcmVxdWlyZW1lbnRzIikNCg0KPiBTaWduZWQtb2ZmLWJ5OiBT
ZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiANCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gwqAtIFJlbW92ZWQgdGhlIGNvZGUgY2hhbmdlIHRoYXQgbGltaXRz
IHRoZSBudW1iZXIgb2YgRklGT3MgZm9yIGJ1bGsgRVAsDQo+ICAgIGFzIHBsYW4gdG8gYWRkcmVz
cyB0aGlzIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2guDQo+ICAtIFJlbmFtZWQgdGhlIHZhcmlh
YmxlIHNwcmFtX3R5cGUgdG8gaXNfc2luZ2xlX3BvcnRfcmFtIGZvciBiZXR0ZXINCj4gICAgdW5k
ZXJzdGFuZGluZy4NCj4gIC0gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDExMDcxMDQwNDAuNTAyLTEtc2VsdmFy
YXN1LmdAc2Ftc3VuZy5jb20vX187ISFBNEYyUjlHX3BnIVl2WjRGNHo2VTZCYTlaNmhnc3c0LW1M
UHZtOVFCb3BOSWJnTWU3V1NxajdWQ1VxZjktSlFUU1Y0UkU2T2RYQ3czaEpSOXN1SGNqcVZyc1Js
WjdfM1pYUWtiQXMkIA0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5oICAgfCAgNCAr
KysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IGluZGV4IGVhYTU1YzBjZjYyZi4uODMw
NmIzOWU1YzY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBAQCAtOTE1LDYgKzkxNSw3IEBAIHN0cnVjdCBk
d2MzX2h3cGFyYW1zIHsNCj4gICNkZWZpbmUgRFdDM19NT0RFKG4pCQkoKG4pICYgMHg3KQ0KPiAg
DQo+ICAvKiBIV1BBUkFNUzEgKi8NCj4gKyNkZWZpbmUgRFdDM19TUFJBTV9UWVBFKG4pCSgoKG4p
ID4+IDIzKSAmIDEpDQo+ICAjZGVmaW5lIERXQzNfTlVNX0lOVChuKQkJKCgobikgJiAoMHgzZiA8
PCAxNSkpID4+IDE1KQ0KPiAgDQo+ICAvKiBIV1BBUkFNUzMgKi8NCj4gQEAgLTkyNSw2ICs5MjYs
OSBAQCBzdHJ1Y3QgZHdjM19od3BhcmFtcyB7DQo+ICAjZGVmaW5lIERXQzNfTlVNX0lOX0VQUyhw
KQkoKChwKS0+aHdwYXJhbXMzICYJCVwNCj4gIAkJCShEV0MzX05VTV9JTl9FUFNfTUFTSykpID4+
IDE4KQ0KPiAgDQo+ICsvKiBIV1BBUkFNUzYgKi8NCj4gKyNkZWZpbmUgRFdDM19SQU0wX0RFUFRI
KG4pCSgoKG4pICYgKDB4ZmZmZjAwMDApKSA+PiAxNikNCj4gKw0KPiAgLyogSFdQQVJBTVM3ICov
DQo+ICAjZGVmaW5lIERXQzNfUkFNMV9ERVBUSChuKQkoKG4pICYgMHhmZmZmKQ0KPiAgDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBpbmRleCAyZmVkMmFhMDE0MDcuLjRmMmUwNjNjOTA5MSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IEBAIC02ODcsNiArNjg3LDQ0IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfY2Fs
Y190eF9maWZvX3NpemUoc3RydWN0IGR3YzMgKmR3YywgaW50IG11bHQpDQo+ICAJcmV0dXJuIGZp
Zm9fc2l6ZTsNCj4gIH0NCj4gIA0KPiArLyoqDQo+ICsgKiBkd2MzX2dhZGdldF9jYWxjX3JhbV9k
ZXB0aCAtIGNhbGN1bGF0ZXMgdGhlIHJhbSBkZXB0aCBmb3IgdHhmaWZvDQo+ICsgKiBAZHdjOiBw
b2ludGVyIHRvIHRoZSBEV0MzIGNvbnRleHQNCj4gKyAqLw0KPiArc3RhdGljIGludCBkd2MzX2dh
ZGdldF9jYWxjX3JhbV9kZXB0aChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCWludCByYW1f
ZGVwdGg7DQo+ICsJaW50IGZpZm9fMF9zdGFydDsNCj4gKwlib29sIGlzX3NpbmdsZV9wb3J0X3Jh
bTsNCj4gKwlpbnQgdG1wOw0KDQpUcnkgdG8gbGlzdCB0aGlzIGluIHJldmVyc2VkIGNocmlzdG1h
cyB0cmVlIHN0eWxlIHdoZW4gcG9zc2libGUuIE1vdmUNCmRlY2xhcmF0aW9uIG9mIHRtcCB1bmRl
ciB0aGUgaWYgKGlzX3NpbmdsZV9wb3J0X3JhbSkgc2NvcGUuDQoNCj4gKw0KPiArCS8qIENoZWNr
IHN1cHBvcnRpbmcgUkFNIHR5cGUgYnkgSFcgKi8NCj4gKwlpc19zaW5nbGVfcG9ydF9yYW0gPSBE
V0MzX1NQUkFNX1RZUEUoZHdjLT5od3BhcmFtcy5od3BhcmFtczEpOw0KPiArDQo+ICsJLyoNCj4g
KwkgKiBJZiBhIHNpbmdsZSBwb3J0IFJBTSBpcyB1dGlsaXplZCwgdGhlbiBhbGxvY2F0ZSBUeEZJ
Rk9zIGZyb20NCj4gKwkgKiBSQU0wLiBvdGhlcndpc2UsIGFsbG9jYXRlIHRoZW0gZnJvbSBSQU0x
Lg0KPiArCSAqLw0KPiArCXJhbV9kZXB0aCA9IGlzX3NpbmdsZV9wb3J0X3JhbSA/IERXQzNfUkFN
MF9ERVBUSChkd2MtPmh3cGFyYW1zLmh3cGFyYW1zNikgOg0KPiArCQkJRFdDM19SQU0xX0RFUFRI
KGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM3KTsNCj4gKw0KDQpSZW1vdmUgZXh0cmEgbmV3IGVtcHR5
IGxpbmUuDQoNCj4gKw0KPiArCS8qDQo+ICsJICogSW4gYSBzaW5nbGUgcG9ydCBSQU0gY29uZmln
dXJhdGlvbiwgdGhlIGF2YWlsYWJsZSBSQU0gaXMgc2hhcmVkDQo+ICsJICogYmV0d2VlbiB0aGUg
UlggYW5kIFRYIEZJRk9zLiBUaGlzIG1lYW5zIHRoYXQgdGhlIHR4ZmlmbyBjYW4gYmVnaW4NCj4g
KwkgKiBhdCBhIG5vbi16ZXJvIGFkZHJlc3MuDQo+ICsJICovDQo+ICsJaWYgKGlzX3NpbmdsZV9w
b3J0X3JhbSkgew0KPiArCQkvKiBDaGVjayBpZiBUWEZJRk9zIHN0YXJ0IGF0IG5vbi16ZXJvIGFk
ZHIgKi8NCj4gKwkJdG1wID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1RYRklGT1NJWigw
KSk7DQo+ICsJCWZpZm9fMF9zdGFydCA9IERXQzNfR1RYRklGT1NJWl9UWEZTVEFERFIodG1wKTsN
Cj4gKw0KPiArCQlyYW1fZGVwdGggLT0gKGZpZm9fMF9zdGFydCA+PiAxNik7DQo+ICsJfQ0KPiAr
DQo+ICsJcmV0dXJuIHJhbV9kZXB0aDsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKiBkd2MzX2dh
ZGdldF9jbGVhcl90eF9maWZvcyAtIENsZWFycyB0eGZpZm8gYWxsb2NhdGlvbg0KPiAgICogQGR3
YzogcG9pbnRlciB0byB0aGUgRFdDMyBjb250ZXh0DQo+IEBAIC03NTMsNyArNzkxLDcgQEAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMyAqZHdjID0gZGVwLT5kd2M7DQo+ICAJaW50IGZpZm9fMF9z
dGFydDsNCj4gLQlpbnQgcmFtMV9kZXB0aDsNCj4gKwlpbnQgcmFtX2RlcHRoOw0KPiAgCWludCBm
aWZvX3NpemU7DQo+ICAJaW50IG1pbl9kZXB0aDsNCj4gIAlpbnQgbnVtX2luX2VwOw0KPiBAQCAt
NzczLDcgKzgxMSw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcmVzaXplX3R4X2ZpZm9zKHN0
cnVjdCBkd2MzX2VwICpkZXApDQo+ICAJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RYRklGT19S
RVNJWkVEKQ0KPiAgCQlyZXR1cm4gMDsNCj4gIA0KPiAtCXJhbTFfZGVwdGggPSBEV0MzX1JBTTFf
REVQVEgoZHdjLT5od3BhcmFtcy5od3BhcmFtczcpOw0KPiArCXJhbV9kZXB0aCA9IGR3YzNfZ2Fk
Z2V0X2NhbGNfcmFtX2RlcHRoKGR3Yyk7DQo+ICANCj4gIAlzd2l0Y2ggKGR3Yy0+Z2FkZ2V0LT5z
cGVlZCkgew0KPiAgCWNhc2UgVVNCX1NQRUVEX1NVUEVSX1BMVVM6DQo+IEBAIC04MDksNyArODQ3
LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9yZXNpemVfdHhfZmlmb3Moc3RydWN0IGR3YzNf
ZXAgKmRlcCkNCj4gIA0KPiAgCS8qIFJlc2VydmUgYXQgbGVhc3Qgb25lIEZJRk8gZm9yIHRoZSBu
dW1iZXIgb2YgSU4gRVBzICovDQo+ICAJbWluX2RlcHRoID0gbnVtX2luX2VwICogKGZpZm8gKyAx
KTsNCj4gLQlyZW1haW5pbmcgPSByYW0xX2RlcHRoIC0gbWluX2RlcHRoIC0gZHdjLT5sYXN0X2Zp
Zm9fZGVwdGg7DQo+ICsJcmVtYWluaW5nID0gcmFtX2RlcHRoIC0gbWluX2RlcHRoIC0gZHdjLT5s
YXN0X2ZpZm9fZGVwdGg7DQo+ICAJcmVtYWluaW5nID0gbWF4X3QoaW50LCAwLCByZW1haW5pbmcp
Ow0KPiAgCS8qDQo+ICAJICogV2UndmUgYWxyZWFkeSByZXNlcnZlZCAxIEZJRk8gcGVyIEVQLCBz
byBjaGVjayB3aGF0IHdlIGNhbiBmaXQgaW4NCj4gQEAgLTgzNSw5ICs4NzMsOSBAQCBzdGF0aWMg
aW50IGR3YzNfZ2FkZ2V0X3Jlc2l6ZV90eF9maWZvcyhzdHJ1Y3QgZHdjM19lcCAqZGVwKQ0KPiAg
CQlkd2MtPmxhc3RfZmlmb19kZXB0aCArPSBEV0MzMV9HVFhGSUZPU0laX1RYRkRFUChmaWZvX3Np
emUpOw0KPiAgDQo+ICAJLyogQ2hlY2sgZmlmbyBzaXplIGFsbG9jYXRpb24gZG9lc24ndCBleGNl
ZWQgYXZhaWxhYmxlIFJBTSBzaXplLiAqLw0KPiAtCWlmIChkd2MtPmxhc3RfZmlmb19kZXB0aCA+
PSByYW0xX2RlcHRoKSB7DQo+ICsJaWYgKGR3Yy0+bGFzdF9maWZvX2RlcHRoID49IHJhbV9kZXB0
aCkgew0KPiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiRmlmb3NpemUoJWQpID4gUkFNIHNpemUoJWQp
ICVzIGRlcHRoOiVkXG4iLA0KPiAtCQkJZHdjLT5sYXN0X2ZpZm9fZGVwdGgsIHJhbTFfZGVwdGgs
DQo+ICsJCQlkd2MtPmxhc3RfZmlmb19kZXB0aCwgcmFtX2RlcHRoLA0KPiAgCQkJZGVwLT5lbmRw
b2ludC5uYW1lLCBmaWZvX3NpemUpOw0KPiAgCQlpZiAoRFdDM19JUF9JUyhEV0MzKSkNCj4gIAkJ
CWZpZm9fc2l6ZSA9IERXQzNfR1RYRklGT1NJWl9UWEZERVAoZmlmb19zaXplKTsNCj4gQEAgLTMw
OTAsNyArMzEyOCw3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfY2hlY2tfY29uZmlnKHN0cnVj
dCB1c2JfZ2FkZ2V0ICpnKQ0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSBnYWRnZXRfdG9fZHdjKGcp
Ow0KPiAgCXN0cnVjdCB1c2JfZXAgKmVwOw0KPiAgCWludCBmaWZvX3NpemUgPSAwOw0KPiAtCWlu
dCByYW0xX2RlcHRoOw0KPiArCWludCByYW1fZGVwdGg7DQo+ICAJaW50IGVwX251bSA9IDA7DQo+
ICANCj4gIAlpZiAoIWR3Yy0+ZG9fZmlmb19yZXNpemUpDQo+IEBAIC0zMTEzLDggKzMxNTEsOCBA
QCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2NoZWNrX2NvbmZpZyhzdHJ1Y3QgdXNiX2dhZGdldCAq
ZykNCj4gIAlmaWZvX3NpemUgKz0gZHdjLT5tYXhfY2ZnX2VwczsNCj4gIA0KPiAgCS8qIENoZWNr
IGlmIHdlIGNhbiBmaXQgYSBzaW5nbGUgZmlmbyBwZXIgZW5kcG9pbnQgKi8NCj4gLQlyYW0xX2Rl
cHRoID0gRFdDM19SQU0xX0RFUFRIKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM3KTsNCj4gLQlpZiAo
Zmlmb19zaXplID4gcmFtMV9kZXB0aCkNCj4gKwlyYW1fZGVwdGggPSBkd2MzX2dhZGdldF9jYWxj
X3JhbV9kZXB0aChkd2MpOw0KPiArCWlmIChmaWZvX3NpemUgPiByYW1fZGVwdGgpDQo+ICAJCXJl
dHVybiAtRU5PTUVNOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+IC0tIA0KPiAyLjE3LjENCj4gDQoN
Ck90aGVyIHRoYW4gbWlub3Igbml0cywgdGhlIHJlc3QgbG9va3MgZmluZS4NCg0KVGhhbmtzLA0K
VGhpbmg=


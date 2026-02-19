Return-Path: <stable+bounces-217519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DweOc2Vl2nO1QIAu9opvQ
	(envelope-from <stable+bounces-217519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 23:59:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95D1636E5
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 23:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F09302A6BF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444C32E6BF;
	Thu, 19 Feb 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="q9MQfXkT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wo8VzIN4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S8ti8jiL"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9C32D7DA;
	Thu, 19 Feb 2026 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541911; cv=fail; b=HDnrjovKkJPPbZaz1Qz2h/nvsGxrhsxXVsUC11xNc5tQCly3LHBJV1ctQARFycY5BV6xBDE9zyMgReEcEvCxe+Pj640eoUpwZKcCws1yDnOC6jbQxamBwkDoR1Q52PXkeeMq62cN6IhQnU29VB2WsjnmQ3ZA/iTWTX4OkEJFxnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541911; c=relaxed/simple;
	bh=fvDy66AGsHE0CA4feLyLZp2hLM8LBb1X/YzXleIoQMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TInhuYgUVdk6hK0/5YF27L6h5T0edcLlWELZRsLBgeC+evCxp2L0IaiU5gMDHGD7nG5O0Ef1VbI5rWSGBfPU8w0vf0bR6QNLZrwqqffmvOPIXAMkoS1CRxsI1tDiUYYX2qtICpb29fS3B9YLVkqwy4uuWXm3bn+0SudMkuTtXeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=q9MQfXkT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Wo8VzIN4; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=S8ti8jiL reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JMfaXV4032777;
	Thu, 19 Feb 2026 14:57:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=fvDy66AGsHE0CA4feLyLZp2hLM8LBb1X/YzXleIoQMU=; b=
	q9MQfXkTC5ytC/9Vrou1cgxnYtc+Lam+vsXoUqBHnyDJoOSWcZPjiLgpdmJxUhId
	W3pflz/Bus2iVfAdf8Euu+m3H+osLSAzcgf2k6sAu8X8nMM2KlvB1bb2u2dUAnof
	Qz2/k2QnOX5/z6AMNzy0U/peWE1faoLfSinh/GvkrOWodvDcMYgl9mCfsGnW9ZoY
	BJHVuCqku+fEt3wZK5rH3mRDV0A3e+c5pCl0VQzhIHUKTESP1vagwxOZrveTi9ld
	m5wZtX86c5AcdiWasSPPS644dsEy/wV1FURTEohu7nU6VRfY0xDL6U5xWEMk1dTH
	pWbPNBvel4Yjppl/jCsMwQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4cdyepnc4e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1771541867; bh=fvDy66AGsHE0CA4feLyLZp2hLM8LBb1X/YzXleIoQMU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Wo8VzIN4se7jKI56oikhPvKt4JSaYLtlyIZTRZKP/DN1Kip1V6sERqrTKA6cjbpjS
	 GFnCgn7a5a+EH6ZCmfZBtzZ6D/GUKNwR9wv9c9Pd6urHByO8JRL9e4KNTVzbFObHQp
	 ndTwMMR9HWQM2xbgIgo67fgTA71/VtsA5CZX6VLI+sW3pwp4lwLfWjsb15h+PVTKsF
	 yBj8ILmvXwf4cs24QG0RGsmiKDJgVVblw2wf+m7zjxjBtSAbxRNSGLLjSQIKOCcudX
	 1Au0g3aA4O0pJ0LS4X1NLVTU8UcGsgdq1sXIuLZAJT+SQBim2+W4wlEN4S/uws/HB5
	 BJF9qVIVcc2sg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3207C402B2;
	Thu, 19 Feb 2026 22:57:46 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B9474A0072;
	Thu, 19 Feb 2026 22:57:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=S8ti8jiL;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00100.outbound.protection.outlook.com [40.93.14.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DE683403EC;
	Thu, 19 Feb 2026 22:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyg5+Q6B8aPzQfpCADv6ewWbfsNYyiHfmyQnTb74h8/KmzfnDwhkO43L3C5OgB8BzBwlIgZsvpCrEGi0z25uqFLMeecLttDOZf3IkmY8A5EQejzGfRfrR/Rkg0O6Aea519tLDHMUhrueR3kaEuuMTuhaxwFTna/4Nip/cqtllUj8BTkUAA7fxmQOqmm0aAzq84OKDC3ddlcKN7XxDmP+5SaUfg6QHSyO4YXgxySfGRvQ3FIbTynRxPX+og/mjVv85Yf1HY5aIpnrMZ/fjEKMTRw8tAf/K87wr7MI6vzoi2yNb1pV4u5AVnvVDPiwFGW4jkyH3kSGJWV5qTAOdtDk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvDy66AGsHE0CA4feLyLZp2hLM8LBb1X/YzXleIoQMU=;
 b=bWctag+MUOCf7Mx9powdvwQtaqXn36GDthstrj0jWFMVE3BUILp5O7G1ROBnKA8DcqTTeGG8aFHJ+UjlI53Rns9KhkKWecTsWia3VuKCyS4XsnQzdf2e97okeTVtV5FWWqMvss22xbbni4lJLAi0rtTqxZMoVVWW/x2qj7cpvEH4OtLV63KQYtgZtUR9moGZaPeUmQblULny8AU1+bVEohVD0q/bxxGDgEPH8xg1EQQJ3lTBREpLrVKIrZvL+JPnFTxU7cPIZL0cs75wp2HxeOdcWHeJQ//Y1osyTBMzkG/KUcSeeWo04X5uqEAZOZ4frR8Wo6jQ8YksNI1rDOFs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvDy66AGsHE0CA4feLyLZp2hLM8LBb1X/YzXleIoQMU=;
 b=S8ti8jiLajs95vJ2/w9UIv2ghZDHoXUKiWN/B758nm+L8DfrXqV7pvzjkDMz/nQSc1/G/EiheOu+49tftlb4hKIGaJqzt9EOvkCWkYLxWTqtaoClTEjSmdwR7JR0PzDoXG2oq1gh+cpT6aYtvIGv+FLo+Pak8zYrHKaqgXXUHH4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 22:57:36 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 22:57:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "andrzej.p@samsung.com" <andrzej.p@samsung.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "chenyufeng@iie.ac.cn" <chenyufeng@iie.ac.cn>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: gadget: f_tcm: Fix NULL pointer dereferences in
 nexus handling
Thread-Topic: [PATCH v3] usb: gadget: f_tcm: Fix NULL pointer dereferences in
 nexus handling
Thread-Index: AQHcoUjfENw3j6HztE+5tyAdRZAakrWKo7SA
Date: Thu, 19 Feb 2026 22:57:36 +0000
Message-ID: <20260219225735.alb7pcmx6rmidxsi@synopsys.com>
References: <20260219021757.eeq35yd7jumpk42n@synopsys.com>
 <20260219023834.17976-1-jiashengjiangcool@gmail.com>
In-Reply-To: <20260219023834.17976-1-jiashengjiangcool@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4119:EE_
x-ms-office365-filtering-correlation-id: 01db0bbe-a4b0-48e1-3476-08de700a461a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEpNeDM0Zjh5WHJJeWdxVUNIN3ZLV1VPMU9yT0trbUpqMGI1YTZUMzhTcmNV?=
 =?utf-8?B?WGJkbk9JazNxSm5XcEw0MmtvZS9JZW1SeGpsT1l4czV1K0JPSzRVM2FQL0Fp?=
 =?utf-8?B?QWVoYUF6b3F2SlJEWnZKSjlOOUplWDJrWHFBeXB0T0FXYmhaS05nWlJXdVMz?=
 =?utf-8?B?TmJ3WlIvSG9DQlo1YXhXS2NHNkR4UXh0OENnS3VNbHplaTUwQ2RkTnhFeTRL?=
 =?utf-8?B?WmtybkJxREFJY2NhWjNlNlJCUWFGQzVicTlhdkg3OTlWR3MzV2FGN05vNXhQ?=
 =?utf-8?B?REdPYUYxdlJXMDBGbyt5MmFTNWk0dnhJb080eExWR0xOc3pzT1FUTXcwVk9L?=
 =?utf-8?B?Nis3ZWgvQ3E3bFdXTW0vRjI1OGp0aFF0L3p2elVpVEkvVytUQ09UeXR6Wkhv?=
 =?utf-8?B?WW4rZVovdllIbEdtR0NIeWp4em9Sd3VSTnVSWmNIL09iZlRzcjhmN0ZuT0Jk?=
 =?utf-8?B?SXMxQXZNVlBYZHVjcmxFeDZZQ0xQbFNtSlZscTJOTXc1VXZQaTB3OTRXdmhs?=
 =?utf-8?B?UXZja3JUZVFjSDY5Rlp2RnI5OERmeEcrS2RWdncxNzdTd0tmZ09iMFNWSklv?=
 =?utf-8?B?ZHZRN3hobVMzL0h3d2ZJaWk1NkNNZXJQTkRiYkphZWtVNlorOStKczRqNWts?=
 =?utf-8?B?VEluZEpGamQrOU16MG1XamRnMHFMTTBEay9zemYyakk0UGtHeTZoUXIrM2pK?=
 =?utf-8?B?UFpJYUxVamR5bHExN2R5UHgvWldXV2JmcHVXL1JxZzhTbEVGekVCekhMeURG?=
 =?utf-8?B?WkNxWDBJUjN3aXVBMXk4cnhSeGxndW0rR1IrS0F6U1lrSldmcjEzNWoyZVZS?=
 =?utf-8?B?VGFYU0w3alFBTTVZclA4Z3dnV0QxQ1B6VnNXbkdCeDVYZnM1SHB4d0tVcGts?=
 =?utf-8?B?V2ZiYWs0MHp1Q2xXWGIxUDBRdVZmYSt2WjE4M1BhYVFieXZVeVIyQldjbUw0?=
 =?utf-8?B?enFFSnpqZS95eU9icnJxb1QrNU1VK0ovVDlaSllsZzNjcVJPWDByTmFSbERt?=
 =?utf-8?B?TC90SDNPSHlHZnMxdDQzYnV6UnRkL0JiWG5SVXlnVm9IVnhyWTd6SHI3UnRh?=
 =?utf-8?B?R0VkVUtPOWZMaVFJS3NqMXRaUXAzSmsxY0tRU1pLcm5Fa1FuS0lTUFJrZEU2?=
 =?utf-8?B?STl5ZlJLVzVuWThleXFTQ2pCRnBQR2Z6S0FRVU5kNVpqS1NxbDdFMDVYdG1Z?=
 =?utf-8?B?MEFKMG1lZGx6cEV1cS9XT1RQd0NuOURaQUlxcnNIRjJoZHJrYjVraWhHTEFG?=
 =?utf-8?B?Yzk5TVVOdWh4ZUIzRlFwUEJReGNPSjV2a00zSEVBRFFDakVXQys3d3pDdWgr?=
 =?utf-8?B?MUFCOGxxNWF5ZlFGSlYvWGJ3Z0xOTk5vR2kxem9BNWdOeFVHRjBZdFdOVE9U?=
 =?utf-8?B?dis3RTN5RUFLaEZidlE5ZlRLZ041UVVrRklQRFM3SVQzWTQ1d2REVzE5VUdN?=
 =?utf-8?B?MDJFVWE5RStiOU1vUEFZb3NPVld5WFdFMStWWjFNRTI2Wlo5alU0dlFwU2lq?=
 =?utf-8?B?RUlwbDJOZ0RjdGJJc1RsUjRBTFB5M2IrblZ1UW9ESW9GNEh3SDVieCtQU3J6?=
 =?utf-8?B?NHd3K0IvK0hoejlWMkk1T2xlNmJIR0lKSHgrbTgxNjBiVTJhOTNSWGh5Rnh4?=
 =?utf-8?B?SlkwNEdoMDNYWUVmcmx6UXg2MlZVeHNKMDkwYTJhS3dKR2M5OThONk5vR1Ni?=
 =?utf-8?B?TGsxa0x5OS84K0lIU2FQU2V3dzA2b1h1VExqaFAyZnM3aWZkUmJKb1JIVzFu?=
 =?utf-8?B?QS9veWNueHZTZExnbGV2T29YVDBkYlEyeUJrTDlqaFAvVlIveGZlaW16OHFu?=
 =?utf-8?B?YXJJWjVQT0xOcUVBV29FQVorMm50bkgyVGdqM2NnVHFRZFZSMk1mYlJWSXIr?=
 =?utf-8?B?M2FSUEpyM2FIWXBwS0IyOW9TNkNabjc1NkJ0ekprZkdHOGJvSmFkSmVwd0gv?=
 =?utf-8?B?RjdBd1VROTlwQk43SS9pQk03Y1VxWmtYOXV0OUFSOFU2OWdYRmN0NnZTdzZa?=
 =?utf-8?B?bThDV3phV0FpdHB5M3JQai9BdWxMVm41a2ZDV1NRWEY4cGNLSjNTd3F3RDBl?=
 =?utf-8?B?bjJNbDZBQ00xc3g3cWd0NkNWZitidDdaQVZyR3Y3a1NKc0RnOExteklvemVu?=
 =?utf-8?B?Zk5lSHQwWExXbERwVTdwcUtzTitzUHRzNVpZNWRwUDJTRWpmTDVhZnFzRXZE?=
 =?utf-8?Q?gVC/yt37suYaLtK+1Amb6A8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eC9IM21NZUtMMkkvVFRZRXBiUld5MlRLLzdIQnloS2d0aSt3Z0kycWJmRDdW?=
 =?utf-8?B?bWdPcnRHeEF1cUovb3ZYSGNLSGRqVVFpZHU1MGZNTUxoeStBQjg5STgxSENq?=
 =?utf-8?B?TEEyb1NIZ09oWHJxZm4yeEdFcVFGeEc4OTl2eVJqRTlIeUVlL251dTB3VUYx?=
 =?utf-8?B?aHZvdnRFeXJlQms2cXFRZUFqeWhaRmdGZmRiYUJac01rcXVqazZ6Q3NzQXVX?=
 =?utf-8?B?STR6RlhZRUNmUkhueEVLMUYyS2x1bXFFYVcwMG50OXRXYThueVo0R3JQODA0?=
 =?utf-8?B?U2dWYkEyek1tcHVJK3ZSemxyRm4wSlpqN29hR2FVQ29IMVpjbDl5QlZtS1Z5?=
 =?utf-8?B?ZENNN281aTJMU2ZpOTVnNFpuTlBiYVVUdnczN0tQTUJ1elJGcjJyQ3ZsYS81?=
 =?utf-8?B?TUF4S29vUWRJcXV3azBXbWZ5UC9US1hNNVQ1NWhxam1sYVZ5V0VBa0dIUFNM?=
 =?utf-8?B?T1JML1AvaUFWYUFWRHZwMUphYmFOeTZCclcyQ1N3bFFJNXRaUmFmbjEwMVAz?=
 =?utf-8?B?bzRSZzA2SzdUOXdSaTg5K29iQnU3VDE2b29QMTVNZkJLeklNS1Jvbmhyb01K?=
 =?utf-8?B?aGVvSE55SkN1RGVRZXJ2Q1hVcVZzdFp3ejVTZE9TWnRtRlpqRnQ4MVJvWmhI?=
 =?utf-8?B?OUdXTG5yNEplOGFtTUhQWTlEZWJwWFAwMW54UlJrSjlsUU1VOEJITkNOTmNF?=
 =?utf-8?B?UFRaNU1YQi82Ylc4VDFCUDk1a1dkZFJOZ3pLOUw4STJaTU0veSs1b2dDUnkv?=
 =?utf-8?B?YkRoUXlQZ2xLS0RVWkdMNitKazgwcVpaYVo2Ymt0cllCVnhIazdIVmtQVW8w?=
 =?utf-8?B?QTg2QjduL0RuSjQ3VTZmaXA3L0NtSldzemxtVVVYQ1dTVno1Z0VUTis5UHhH?=
 =?utf-8?B?S2tJcjN4K1Z4azdHdWg0NWhta1NlclFCSkw2Ync1M2tCUEpleExISklEVU5v?=
 =?utf-8?B?RWs5U1BacFdxTWNnSEVmWTlkazBjQ2FvRytxY1hkYWdBV3pyUUg5OUNCaG1X?=
 =?utf-8?B?bGRPSUlya3l6RjZGckRuajE1eWdkc3ZGQzV5VzdXdzN6SnAyRzBTWFNMeWlk?=
 =?utf-8?B?bCsvQVZIV29ielJXNDBGQUN1NlBudWQwWkJzY0xvWjNBdi9PeUp2cENDVnIv?=
 =?utf-8?B?VFUwYmtaZ0RraGFuNU12UXROVTVhOW93NEcyejk2cUdQM3lmM3lLb0FNeW9u?=
 =?utf-8?B?R1Z2QnBGeE1KZ0VySmlpak84eXJ3SkVQSis2blFtZnJqR0hQc3UwRGtSZEsv?=
 =?utf-8?B?U2xpVzFhdFd3Ym9hWnpFejdZZjVpOGlWSnZrZENVeVBsWU5aQlRHaGFtelB3?=
 =?utf-8?B?aXdBMWc4OFkzaW5PSU94eG1JMHlmdlVIRzNSd0pJcFBVS29WNjBTM2RZUEFI?=
 =?utf-8?B?ZTBFRkV0d0JoZnJPSGVEZWlEQ1AvZ2doNW5WQllmRmdkekVnSy9yRyttWXVn?=
 =?utf-8?B?V3Y5clhSTUFtNEFLVVNLNzRHT0thaERTeTIyK3ovdFJVK0ovcEcxR0RZa0RM?=
 =?utf-8?B?Q3lUaEJISmdZaDR6RS9xa3Z4MUhkMTdnc2VTY3ZPRHBCdWN4QTJCQ3R1emw4?=
 =?utf-8?B?L2lWTThmK05aS1hlYjlqMUJqQ1kzTEJZK3BVS0c1Rkx4cTdYY3U0UW0weitl?=
 =?utf-8?B?Qk9xRTZqREVuaXI3YTFaNnZycXgyK3JUckwvci9ZMzAxM3k1NTh2RXdjZGJP?=
 =?utf-8?B?bHFYUzdvZXBRalZxb24rZHR1MHlTR0dSODhIWWF0SEFYNEFzNmxlQStiT1kz?=
 =?utf-8?B?SmdKbzd4d3pja1QxNXM4Uk02bnllZ0dnNlBRMitNWXJtanN6TGhnOWs1SUE3?=
 =?utf-8?B?Mm5UazI3STM4Y3dCZ2hKNlhyZUxobG9ZRzdzZTA0UkN2NmZrS01HOVJGQjli?=
 =?utf-8?B?UnhIYVRoUGYvSm0wVy9CemF3eVh4NWxUZU41TURFWlRaMkdrTS9XOGFQb2JZ?=
 =?utf-8?B?NWt4NWhWK1ZpNnFPWjRmRXNBMnNyRnowL1Myd2tNTUQ5SnV6T3BKZHo0aTJj?=
 =?utf-8?B?NUxaRVArbHIvSkE4OVp3bkZnUW1uY1hXazhITDVSeThtRnJwOVFMaE5OM3A2?=
 =?utf-8?B?b1czWUw5SXkzRWFPY1RINTJESXBHaENkYVkrcHQ5T09RcmRWazVqMS9RMjM1?=
 =?utf-8?B?VlJqdlNEdDVvZHdCTlRFUmpiRjVHL0lIMHJIVGtLOUM2aVlTYUJaQXlhN3BD?=
 =?utf-8?B?QWg4Y0RHNjV5Rm9oWHk5M3dINTNYbVp4UFhiZFVzVnVHWHA2WFRFbTluTEZ6?=
 =?utf-8?B?Z2UzVE9ncUhZZ2ZLZDF0enFQbE9nblBuQU5sQjhJSHJlUVlIU0kycGg4b0lT?=
 =?utf-8?B?Y3JPcFpkU2xNT0tiaG14cFROWDNSdFVWYXphUDFkaGFMY1ZQT3dOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B014966632C8343A03988216785FE25@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8uCJhNrbM5ZAkEFBZET5ecHw9eOY6gX1UrBwc9JryphNiyaQk+MU8WGE+fZ1KYA12Rr/bhEef1y3rrr/LWhDSV8p+lNUT9ojEpXVGezYL6dCAbcgWSw0xcRM+8E+0OAEUsanWK6iyrD1oWt8dastMxWyaIcfbcEp+OmhcY6cY/m6QiSyeN4YEZV6Br+ZAxo569OxOLzD7LsftPmmV0veyYwk/8c92FloWXGpTawR+bq/oCfwqXL8JRyAvlV3DxQta7FoGgxhe+q0vge4rap88Pqhd5cmwIrje0LJUNY/VSVzXVlmTfVRNEKlEdyTIR4L35R0qqhBjRkmkiEN41GHesdbwwsRwO/CVOnUTpIzgcaYYo5gVj7K73yYZo+sXz7RqoiCurgImLE0TPgkjxSXU0hN6pcKMV37KBavJqhQATEF8HpQ4OsHpPcqHWy6IvVQ50eASX6f+ilqWPiFrWta8wnGvSxYgHR4YrOG723XQwrjJLD8O3hMwil2voGBlF9mwS+NonFXpAPmGkG/sumcouCGsJrQSU9m7ZM9IapsJSBrO4YWGDIUN2AR5Rjoc+6jagX/i+gKriqatSk1pa3I5nplpOe8JYCPT5fOX14EfEL00rSVtQRbHY88BpWbyX7o/flsRU13dhZmAatHGj7kOQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db0bbe-a4b0-48e1-3476-08de700a461a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 22:57:36.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4pqt2PIJ+3vj0P/BNC9L2RPJmMLtpyqGp8N0E3l221nYnLuNXVMvHZd5pOtnp6pMVfQcZKBrbeZd/SEIAzqnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119
X-Proofpoint-GUID: oaupFjsiJbB01F8eOGraFv7PL-9pc2lG
X-Proofpoint-ORIG-GUID: oaupFjsiJbB01F8eOGraFv7PL-9pc2lG
X-Authority-Analysis: v=2.4 cv=TfubdBQh c=1 sm=1 tr=0 ts=6997956c cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8 a=H9datkusnE2p8ygPloUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDIwNyBTYWx0ZWRfXyBB/0u3tsfjf
 R8kmLoYZQ1mAoq05uO57vvo+aVSe4ESahhiyPcRprEwU6ajhdtJeFC2j8PZh1TK8e2Bx1YlAJL/
 PVpZ75lXhZn2jAnygMrwe5HBgR1Da3GuSqZsJgOZPpfCan1USRiaUt+cHyupxwE/KINg9WWN1s7
 7zr+V7jtfbeSawW0ffxUWNiz1eZ8QwXB/eomg9tLjqjm3Bb7s+XMYEAYv+e8rZRI3WUtxNMOLQK
 Zd7Wl682noRLs1hyMqIPUcc/Wp2T5O16xetiUnXml9VWXfCcLb6N6OZNYMW+VDoDGBH6pFYrPvU
 EAD1N6Vn4y/OWDjxZOrfsZe4TWNWYOVke6s6NxEnWbdtR7I8F4z8vjum6jUhItS27vfrFlfqJaH
 laGpf5LnesT7crG5jZ2TtZhFeYubnHtpHH0z7x2M7Jp5H1geIyOgG1EwhQiN0XeY5NQkPCAPklx
 7GJOu9lZKZGHdKzGkig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602190207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217519-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:mid,synopsys.com:dkim,synopsys.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4A95D1636E5
X-Rspamd-Action: no action

T24gVGh1LCBGZWIgMTksIDIwMjYsIEppYXNoZW5nIEppYW5nIHdyb3RlOg0KPiBUaGUgYHRwZy0+
dHBnX25leHVzYCBwb2ludGVyIGluIHRoZSBVU0IgVGFyZ2V0IGRyaXZlciBpcyBkeW5hbWljYWxs
eQ0KPiBtYW5hZ2VkIGFuZCB0aWVkIHRvIHVzZXJzcGFjZSBjb25maWd1cmF0aW9uIHZpYSBDb25m
aWdGUy4gSXQgY2FuIGJlDQo+IE5VTEwgaWYgdGhlIFVTQiBob3N0IHNlbmRzIHJlcXVlc3RzIGJl
Zm9yZSB0aGUgbmV4dXMgaXMgZnVsbHkNCj4gZXN0YWJsaXNoZWQgb3IgaW1tZWRpYXRlbHkgYWZ0
ZXIgaXQgaXMgZHJvcHBlZC4NCj4gDQo+IEN1cnJlbnRseSwgZnVuY3Rpb25zIGxpa2UgYGJvdF9z
dWJtaXRfY29tbWFuZCgpYCBhbmQgdGhlIGRhdGENCj4gdHJhbnNmZXIgcGF0aHMgcmV0cmlldmUg
YHR2X25leHVzID0gdHBnLT50cGdfbmV4dXNgIGFuZCBpbW1lZGlhdGVseQ0KPiBkZXJlZmVyZW5j
ZSBgdHZfbmV4dXMtPnR2bl9zZV9zZXNzYCB3aXRob3V0IGFueSB2YWxpZGF0aW9uLiBJZiBhDQo+
IG1hbGljaW91cyBvciBtaXNjb25maWd1cmVkIFVTQiBob3N0IHNlbmRzIGEgQk9UIChCdWxrLU9u
bHkgVHJhbnNwb3J0KQ0KPiBjb21tYW5kIGR1cmluZyB0aGlzIHJhY2Ugd2luZG93LCBpdCB0cmln
Z2VycyBhIE5VTEwgcG9pbnRlcg0KPiBkZXJlZmVyZW5jZSwgbGVhZGluZyB0byBhIGtlcm5lbCBw
YW5pYyAobG9jYWwgRG9TKS4NCj4gDQo+IFRoaXMgZXhwb3NlcyBhbiBpbmNvbnNpc3RlbnQgQVBJ
IHVzYWdlIHdpdGhpbiB0aGUgbW9kdWxlLCBhcyBwZWVyDQo+IGZ1bmN0aW9ucyBsaWtlIGB1c2Jn
X3N1Ym1pdF9jb21tYW5kKClgIGFuZCBgYm90X3NlbmRfYmFkX3Jlc3BvbnNlKClgDQo+IGNvcnJl
Y3RseSBpbXBsZW1lbnQgYSBOVUxMIGNoZWNrIGZvciBgdHZfbmV4dXNgIGJlZm9yZSBwcm9jZWVk
aW5nLg0KPiANCj4gRml4IHRoaXMgYnkgYnJpbmdpbmcgY29uc2lzdGVuY3kgdG8gdGhlIG5leHVz
IGhhbmRsaW5nLiBBZGQgdGhlDQo+IG1pc3NpbmcgYGlmICghdHZfbmV4dXMpYCBjaGVja3MgdG8g
dGhlIHZ1bG5lcmFibGUgQk9UIGNvbW1hbmQgYW5kDQo+IHJlcXVlc3QgcHJvY2Vzc2luZyBwYXRo
cywgYWJvcnRpbmcgdGhlIGNvbW1hbmQgZ3JhY2VmdWxseSB3aXRoIGFuDQo+IGVycm9yIGluc3Rl
YWQgb2YgY3Jhc2hpbmcgdGhlIHN5c3RlbS4NCj4gDQo+IEZpeGVzOiBjNTI2NjFkNjBmNjMgKCJ1
c2ItZ2FkZ2V0OiBJbml0aWFsIG1lcmdlIG9mIHRhcmdldCBtb2R1bGUgZm9yIFVBU1AgKyBCT1Qi
KQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFzaGVu
ZyBKaWFuZyA8amlhc2hlbmdqaWFuZ2Nvb2xAZ21haWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlbG9n
Og0KPiANCj4gdjIgLT4gdjM6DQo+IA0KPiAxLiBVc2UgZGV2X2Vyci4NCj4gDQo+IHYxIC0+IHYy
Og0KPiANCj4gMS4gVXBkYXRlIEZpeGVzIHRhZy4NCj4gMi4gQWRkIENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnLg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3RjbS5j
IHwgMTQgKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl90Y20uYw0KPiBpbmRleCA2ZTg4MDRmMDRi
YWEuLjdiMjdmODA4MmFjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL2ZfdGNtLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMN
Cj4gQEAgLTEyMjIsNiArMTIyMiwxMyBAQCBzdGF0aWMgdm9pZCB1c2JnX3N1Ym1pdF9jbWQoc3Ry
dWN0IHVzYmdfY21kICpjbWQpDQo+ICAJc2VfY21kID0gJmNtZC0+c2VfY21kOw0KPiAgCXRwZyA9
IGNtZC0+ZnUtPnRwZzsNCj4gIAl0dl9uZXh1cyA9IHRwZy0+dHBnX25leHVzOw0KPiArCWlmICgh
dHZfbmV4dXMpIHsNCj4gKwkJc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCA9IGZ1YXNfdG9fZ2Fk
Z2V0KGNtZC0+ZnUpOw0KPiArDQo+ICsJCWRldl9lcnIoJmdhZGdldC0+ZGV2LCAiTWlzc2luZyBu
ZXh1cywgaWdub3JpbmcgY29tbWFuZFxuIik7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4g
IAlkaXIgPSBnZXRfY21kX2RpcihjbWQtPmNtZF9idWYpOw0KPiAgCWlmIChkaXIgPCAwKQ0KPiAg
CQlnb3RvIG91dDsNCj4gQEAgLTE0ODIsNiArMTQ4OSwxMyBAQCBzdGF0aWMgdm9pZCBib3RfY21k
X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCXNlX2NtZCA9ICZjbWQtPnNlX2Nt
ZDsNCj4gIAl0cGcgPSBjbWQtPmZ1LT50cGc7DQo+ICAJdHZfbmV4dXMgPSB0cGctPnRwZ19uZXh1
czsNCj4gKwlpZiAoIXR2X25leHVzKSB7DQo+ICsJCXN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQg
PSBmdWFzX3RvX2dhZGdldChjbWQtPmZ1KTsNCj4gKw0KPiArCQlkZXZfZXJyKCZnYWRnZXQtPmRl
diwgIk1pc3NpbmcgbmV4dXMsIGlnbm9yaW5nIGNvbW1hbmRcbiIpOw0KPiArCQlyZXR1cm47DQo+
ICsJfQ0KPiArDQo+ICAJZGlyID0gZ2V0X2NtZF9kaXIoY21kLT5jbWRfYnVmKTsNCj4gIAlpZiAo
ZGlyIDwgMCkNCj4gIAkJZ290byBvdXQ7DQo+IC0tIA0KPiAyLjI1LjENCj4gDQoNClJldmlld2Vk
LWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRoYW5rcywN
ClRoaW5o


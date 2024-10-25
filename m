Return-Path: <stable+bounces-88204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4379B12EE
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 00:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B228DB21D11
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 22:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535F0215C75;
	Fri, 25 Oct 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gqxY3I+5";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AJjT4VZv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W5W8ZAol"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9420213147;
	Fri, 25 Oct 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896060; cv=fail; b=BBQPquJWD4M3/JwZU1YIVg1QQwSCHOdUz3ooiHYcX4GjyN8EqGn1WSHBwiUU6zDn87sqxhp7svnlEy80aZ6HX7H7dJIhg6/WOQEHWjjpG8D6Dab+ki66KUG4A8OrCdlxXWPmmyoVhyHqMmI4xpY8ZUaVgWatHDeHgvhizs5boz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896060; c=relaxed/simple;
	bh=wNBXyC26dB+ETX00KQi6Lrqeaj0ooWakt9HvTNC5Msk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eCX7R6L+dbDKFOvXk7HW9CaWqWdrnaLyogZ43vZGXRMnpfIrep8rHz3QIIpGyeWkqQ1rMaedwEbyK9caeGcA//VW95t21SUqiuP9g4ooRjwYOwx0aymxlPH4MOnajzQQt6l+3y6K7bZ6VhsjBtqTCoi8a2pbIxjX8bk4PT7xdSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gqxY3I+5; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AJjT4VZv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W5W8ZAol reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PITxe8021577;
	Fri, 25 Oct 2024 15:40:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=wNBXyC26dB+ETX00KQi6Lrqeaj0ooWakt9HvTNC5Msk=; b=
	gqxY3I+51jtLV+joYD2PssvQYE18jFfFJ7upJUVw4cv9pZ3sgHo35Q70Kd+zfUJh
	J/dhxPFXK1h2YoiMhvGlLc+rqcPZt6bmqlRR2duf0u5RPzPkbaNAbmhemBQGrcW9
	lPswy6cL1hqw3+jnVqnG6Xqc+7MXHgtqGLsCF5k5/mUz6RT8FwDZ2JrZza1OtwDl
	e5tBaZP+F6ZdUW4yEZ6L1LurIN65Lz6/Fws3O71iIWB20LDI4rpa7yNDyrNhrjkp
	Zi5B3RniQvfyWNk/SBkbKNdQfzNtLjWnB99UJAVEcu8htQK10w9EBohsj01isLya
	eTuuwNRTn0ycri/2AiYUGQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42fs0ygs2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 15:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1729896015; bh=wNBXyC26dB+ETX00KQi6Lrqeaj0ooWakt9HvTNC5Msk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AJjT4VZvJyGFU1i5etCbCFxiQj/8GjM3V8pAQHARstzuXlcNCvVBgZMR8c3Xj7jt5
	 XyRltHrMQMk2koCH4DAbSfxVI9rbpTEPz/7nn8XmqE2OLkmjaItsfEDMqixxTwKPWy
	 FVHu2IxW3L338Js8QidlOfIzDx9QuQCTL4zkM3tXX76a0pp9PfrOYL2lAyexiT5N/Q
	 UG+JHgqyW2p8OUk5GB5uvQug/a2kFm1gMaa6apItwvLtwDJtz2dtsRY00anLfKJh6c
	 WuwIHCAHWKxcDw/bRGD1lmNn3As6+C5cx+YQTNISM3wG27Tk8IkN91EGDofoHjKAbi
	 pJlAxyzktQNow==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5949401CC;
	Fri, 25 Oct 2024 22:40:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 680A0A0090;
	Fri, 25 Oct 2024 22:40:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=W5W8ZAol;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5302F40146;
	Fri, 25 Oct 2024 22:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzOJMK5b0thN6/nXNKqn1E3Fy9tQIi1uGrWyWmRNdmtNA+JqGSpKGm5s5+GUKOM6oG3rzzul6VUJKsaHBpxc2IKc3unoA2R7xqRkvs+G3rG4HX0Q4g3DfItVhs8tcaopTMxzkwjOuMBkwxIFVX22t9P32wLNCtw/DrnmgNjsqgSHgUN4s1OZji5QWe1GIjYTKbIHOi7FKayZk3BhvKef6q+x7VPwxNApEE0GIhnlD9iRygacpOZ/U0eYliViac+UFoYOM0czv2QaaW77ywhapKIZhcDUGNGvZgx7Nn2b8BKpI37pavi2JMrzJ0dHVWXoirxnyA9vSQJ74L9QqOUwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNBXyC26dB+ETX00KQi6Lrqeaj0ooWakt9HvTNC5Msk=;
 b=kTNpgkoX6Mo9Jj77Mue2zYUMXW3gM+OK6Q0BURgrpzmSgRYrYc+SbucKCp9e2K/GYlvUJWN6vZgFIeB6kCbJF/yQoJrhrgBuHpy0OH5AA5aLmCSFVXLAHwnPtVW9ji9M2FvnTXQOSdO0pMmuaAwG+eWKWlWeCN5si4Q+weElV3jH/UyDANrKpxrhQjdTTeAbJegwNBSHhClfox4BKmgxYhqsMKKtfNMs6rxvWyFxaqNaxrEVczvsq/bUQHdHg28yzDWOB2MgkL6rjaQTvTzpwFlQgK0n26avgKSHylZvze7lPrwT+Uj5koAFN+a70t4zc+saY9Rmopt3DB2D0Ww44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNBXyC26dB+ETX00KQi6Lrqeaj0ooWakt9HvTNC5Msk=;
 b=W5W8ZAolaO6CUC6baZb9cM2G/+I5Hhb9BA4Uh0wJCZ43iu/r6MuDBRGu1yXFT7l5u+7WBa7uveJzRhFJ9NcmaczyuPMaNYKPpx4rmHrgzY/IhWaYMMekRdXDS8T9kTBZQzlWVooENcOjzhhC5K5xhqO8IXzTaHOHHKgyMLj1o3s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 22:40:04 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 22:40:04 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Chris Morgan <macroalpha82@gmail.com>
CC: Roger Quadros <rogerq@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "Vardhan,  Vibhore" <vibhore@ti.com>,
        "Govindarajan, Sriramakrishnan" <srk@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Topic: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
Thread-Index: AQHakFeioIjMhcyoIkClbCNPPNRvWLJpHmKAgC/myoCAADfOgA==
Date: Fri, 25 Oct 2024 22:40:04 +0000
Message-ID: <20241025224003.yfujqurxhrgzgzld@synopsys.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
 <1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org>
 <671bef75.050a0220.e4bcd.1821@mx.google.com>
In-Reply-To: <671bef75.050a0220.e4bcd.1821@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8644:EE_
x-ms-office365-filtering-correlation-id: ec52d0b8-40eb-4a90-07c6-08dcf545f812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VndTT1JhaGFscnBaWkpXeHUyQkUvcTJtNzBxQVpWMWVrVFJSbmlQQXF6NHpW?=
 =?utf-8?B?MFBYS2lMTzBETVZSUGJqZndBVVFHaTdJRFJKOXM1ZFluSHk1YjVKQ1BCVmpV?=
 =?utf-8?B?ZUpUOE0rQkppRisxMTVXVEhxU3ZYSjYzekJIdnNneUcrMUgrSWhrRGc1bjMr?=
 =?utf-8?B?bUNJc1RFcFRrNWk5eWJva1pqcEc5bHpYbk53cVYvTk9sV0I1cUk1MklQT3cz?=
 =?utf-8?B?WDgyTTZmb0RBU2RxUTFad2c2VGw3Znk0NEF5blhndVRhTS9mQmtoRGpwc3RI?=
 =?utf-8?B?TVNMcmxMOUxqUzFyY3Y2V3FVS21NQ0QyQjhORmdTWXk3dm1RdjR4OW9sS1o1?=
 =?utf-8?B?ejJxbDdSTVBNZ29nU3pTd0piT1JGYXNPbWYycDVCcFJjK1pMeEVQcmdjL2VE?=
 =?utf-8?B?ZkVsMk44UnByNjJ5OTBqcEdDcFZKT0JOWUE0MTFBbXpKRWEweUw3VUJ0YXZK?=
 =?utf-8?B?SWp3TlovY2FsWWEvNmJZcWUxS0lZaTBuN1JaUDc4Tkk0VTdjbm8vYk5qU2gy?=
 =?utf-8?B?MjlxZ0Rtam9lbE5rM2xzZ2dwbGdFSHR0VFd5Y2xyUE5NaVhqKzcrMFdiWmRo?=
 =?utf-8?B?NGYvVWMyUGIwbXQvdW91bmlmTmJoN2dpQ3BNWUlkeGorRWZjY1cyRkpXRDNq?=
 =?utf-8?B?M0RuTUhvU0NrWFFwQk9rRHFhdCtCeG5ISkU5cFFmbnJVSHpRUXgvczQweDM0?=
 =?utf-8?B?cjZiNmpsa2JnMnNsQzB6TnJaUFhaMUQ1T0ZpY05XYzIvekJrSEZkWGRJTW8z?=
 =?utf-8?B?YkJpWnBTcFhFSUhpbmVjMnpseDZ2VDNPRS8rOGpDV2pFWGNHSTFnT1hLakdw?=
 =?utf-8?B?UTM0Um85MEFPNzV2RGd5RVo3cEs3MU9jenB5OXo3bFV4QkhETlNCZDU2eit0?=
 =?utf-8?B?Tk5BaFE1eW0wcUNnSFBNOTN5YTlmSExBRm1RdjVGT3V1aGpOWWw1VkNqN0Ju?=
 =?utf-8?B?V1NQdmFaR1U0T3F6eG91cGJKeDB4Y0lqQ1VuYVh2NDBWS05ScE5ONkhpTmVI?=
 =?utf-8?B?RTJkTjFMWGs1ZHE5bENGa2F0Q3FuTlA1ZHBZdVdnYmxHc1krVFF1NDUzL1c2?=
 =?utf-8?B?TkxRdTBRS2RINWRxWmZtMzBHOWM3bnlUeWFvN1kvSTdLQUhSaC9aSnoxOFZT?=
 =?utf-8?B?OElkdG44c3JmWG91K3NyZmo3Z3loZ21KQy9nK3ZPcmVIbXNGYVZGSi9qZldS?=
 =?utf-8?B?aUJreTZnNGFuYUs2dTF2N1c1eDIwaUxiRHg3Y3E2YTB3NXFvNzduaDBUM2ZQ?=
 =?utf-8?B?MXpKTnN2RmtQUnJFQnNkUmlscXBFTW5xcHdlZFUrNFMyZllXR2E3T04yUkRL?=
 =?utf-8?B?U3BLZzYzQWZ4bTNOZlhiRWlZMVl3RXV5VmFzZ1pMa1Z5enFIZmtzdzVPSFho?=
 =?utf-8?B?VkhMbUZxUlNDYWV4WjVWNWVxTVliNW5BZkJYeWl1MkNuMDltekFzaUEzMnNI?=
 =?utf-8?B?SXRjQ2daY1JyNFB5TkhTRjJKaXp1eU1HZEo2R2o4blJudEcyaXlRM2NnZ1l6?=
 =?utf-8?B?b1p6S0s3alZNVUVGQzMxekZrZHNnNUxRSjRrNExQUUdoN0htUVZvMUl0OEk1?=
 =?utf-8?B?My9nZ0I4a1QrcGdLbWxTU1l0aHF2S09Yb1VKOW43NnBkSko2VzNScWtCTFhX?=
 =?utf-8?B?djl2bVN3a2ZWN2d1ajBWMm9TNFdWOU1wZzlCY3VSenk4cUJzemRGaHRIQmVk?=
 =?utf-8?B?RjQzTXRURHVXaTNQc3Y1MGFWQW9lUGViUHI0ZXlTRGNJbkpQNml1KzVnS2hs?=
 =?utf-8?B?QklIemU1Qk5YdVEvMEJRYkJnMGZTMnZVUGlXb0VNZ2NYcEVMSXNwdXFnQlZ5?=
 =?utf-8?B?MlN6cUpqSDREZDhMaGVEU3pGaGc1cTVSQ010QkhVaTdCRXRSQWo1KzN6cWtC?=
 =?utf-8?Q?J3TkIhXZz+hdF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3dWVDZ5cXBQYUxLSkhzWWVHV1h4WGJFL2gzNTJZOXIxbDBNUFZkT0I3UE1U?=
 =?utf-8?B?a25HOTlKMkF2Y2JvKzFyNDRyMXZ2TzdTSEhFNnRicWN1empsa0NQRGJjaG5s?=
 =?utf-8?B?Q0YvblhkaUNPYWRvY1c0RUFJU2pjKzFoMHhyOUVaMTlIZHNZZHdtTzdadlhv?=
 =?utf-8?B?RW9ZZWpkK1M3azVaTSszejE4TDd5WngyamhMMWFnQ05sVnBQeGhPR0MxZ1pX?=
 =?utf-8?B?Rk9YYVJtOHFsbjZEUDA4dGYyV3dWOXVrU0ovMVcvdkpYVzk5UCtvUk9IZnZ0?=
 =?utf-8?B?L2swbDRCV3BQV09oQ210SkQ3a2VCZU9rc1NUU0MrRGExU2lSVUNBc1dVYlBW?=
 =?utf-8?B?TkZWell5c2p4U1A5eDRXTXkwUXVjelArY1NXdDRDbFg0K2RmUmpTVjhPSGhs?=
 =?utf-8?B?YVJ2K041cCtIN2VKRDRBbUE3ajRkWEJzTzU1VEhXRzlQcW1nOUhma2h2cnI5?=
 =?utf-8?B?SDJzMGpIM2hQdnFEZUZtUTZqWGRlT0NPeVpnRDJ5M0hreHFmaDlKUVRFQlNX?=
 =?utf-8?B?bEY0aDRVS21wWUZTNm5NYkp5NGxhcnFaT28wS3dEMC9GZm5sV1FmSENzTlFG?=
 =?utf-8?B?eWljYTBMWDNQMDNIdWQ3OTJUQkZ0T2pqWmptMk1jeWtqdm9sRDJ4eDZSbXh2?=
 =?utf-8?B?dEFENHBHSjFPT0o4RWlqZHdQNmNyWGtDejlkYjhFY1VUeStaeHppRXdaVGFF?=
 =?utf-8?B?RnoxZ0RUK2UrRWV6WlRYbzh0Z0J6WmVBaHVZWmVjY1J1RUZwWlFLeU96OGFG?=
 =?utf-8?B?WnFZaVNETmY4ZXRwbTRMaDRqclV2WEd0SVVJUnhjdnFFZWU0bmpYOGlPK28x?=
 =?utf-8?B?S1hGQld2UzV0dUJsalpQbCtWMk5zSTlRQVA5bVdFVmYxblRqNzg2cmg2S2Qz?=
 =?utf-8?B?azdEZEhRME9tUk82dlJVZmRob2wrMWViazc3ZDZSSWlnYUtabkZNUmRhajJh?=
 =?utf-8?B?MGFnSDl3NXdJNlo1NWJZN282aHMwY0phNGVsQTIyUWdtd3AzOTNkSFFpeFBs?=
 =?utf-8?B?ZnV6ZlgwMDE2cWRsWHdaWkNrdDJLNk9yc1RDSjlZazNLV2NZTGFzaXo4czBz?=
 =?utf-8?B?citrbDR5YU40WTBZbnIydVgxZ2dTME5XVFBVQUxLSm5YNktrakpuSC9HWlpu?=
 =?utf-8?B?OGlCd25yY3dzRmY5UkFVQ3AydzMxc3FsSnJINFh4QkJZMWVyVUhHbGJGVndL?=
 =?utf-8?B?blVYR2FtQzJLM3RwMEw0T3dMcHZwWFhnSEM1UGtWR25YTjVMT1YvRUwxTTBp?=
 =?utf-8?B?dlkwR0J2MWx0cVJJUk1hYWRZWHhSaXJ4UHhLOFFuaEJaU0hTdlRjVVpNQVJC?=
 =?utf-8?B?SnNKRnpkVWNRdXBxMEk4SzNjWW8ySnhVY3RuM3I0d2NucFJqUE16MVUrZHMr?=
 =?utf-8?B?VHB4YlUyRVFzU1dtUEp2YVR0NjZ3RVhIUnZaOHNlYVg0ZDRpQUQ5ZXVKb0Ji?=
 =?utf-8?B?Wm1Yem1ZY0hTYlh3RkRManRGVTRTOXNKV2RiLzVTTTJPY3BDbTdueGpoa2tk?=
 =?utf-8?B?SDh5UnBJVWZsc1ErVDJEOGRRblAxMWg0ZzNNSzBmYTFFTDl1TjR6ZUI0ZlU2?=
 =?utf-8?B?WmZkRUs0c0dLRmZVT3FhQ25KOVFRT3hQaUhqRG1Ya3lWcE42WFcvM0owWitG?=
 =?utf-8?B?bGExaG9UOFV6ZXZrUzJrUEZjUzFRN3NRNktDZGFkdnJ1SkFwOXY0bG1zNy9x?=
 =?utf-8?B?NWdHWnVsSGxabWNSb291Si9xRHgxVFZlQVBDVW5RdnFzZzBVV1QrWXNPSmJQ?=
 =?utf-8?B?NzV5aFgrcm9aR0FRZmdaZ0xodkZMVVZ0UENEMGE3L2k5Z3ZoRlFhUEZkbm1T?=
 =?utf-8?B?enBCWFVnYm5USFJJZnpSaHhhMDJjYWRZNXc3NFZBbmIvL3V5c3Y3bCtzL3dR?=
 =?utf-8?B?U0xCa3FCYjc3UjRLYk9XbkdzdUN0TldOK0pKdk5jVCtaNnhPUG0zZk13dXFj?=
 =?utf-8?B?WitpdXV0VVRqUWlEWEZoRWIrZ25rY2NkYi9CcjdYVGx6RGNTZ05FYnE5WjNJ?=
 =?utf-8?B?K3NTY2prUVZhVGRWZklDVUVLWTRUN2U4SjFYa0FCa01qWk42SWwxd1Y5UXJN?=
 =?utf-8?B?L2FhUlRDZmF4SUFnUGdVVlVNZjcvTVFVQ2tTTHN4ZkVVempHMW9EQys5QUJo?=
 =?utf-8?Q?NyleFkCGwl6hB8PbdjwhH43tU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <321BCA2325E28840B5E6A1B5441223FD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PWyLRN8N7N8xzQ0Jo+3ckYrDFUtGCqKonOZGBkrg5iXWjF8Obj4xQ7wrlXURfSsrDYJSZs32BUU0gqp06P+AHghyseKc2ri5caDNtIjqapT7xaAjMCayHw489ELdF35IeLEp9hNz69oJ68u8DCj/7LSDRedtVBO9qqLl17IHXUnJ+dn77g2pQFgsb+CqnWWDESJtlztFODRAbv1+4b4X1te3m3jeG7r5xKKB9KdQIwK6xtTzSF64XkJjVWI3EBJ5MWQz4tUAdccOe30GdVrW86cZCnWsq8YTZ4EXe8RzvAQqpbOM6+C+DC4uOLMWrU90FqIafh0p44BYDon0SHNb83Zy6/PaIAKO22wHIBia3ollaSZ4beghXe/dUrTVfcE03PwCdG8Eafcg/au7hvmFvOVaF0uxDMs+K9auUB7HUNHXUgjcSHcZ3PpNAiJH7YdYF88hqWt6WZ39hLHN7+m0eP58v6djyat1z/p0R/sQFNyhlMR8t2ndoye/k46reVySAontu73lKMtefdytyINJ7UlqAJ/LRK+L+32q8SkeL9UuGxPrPPprfnCBxXikrleYRVcEON5q2gaibrpOUdfc6S05BwKhZXOuOuDySY6VuFVsrGh3/DZtYT737h9QoLT5I0K8MiHp9OAFyAhxJgqXFw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec52d0b8-40eb-4a90-07c6-08dcf545f812
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 22:40:04.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/gWOCsXBe1V7K3C00vYvxetFW5jz5OxNySsgxpNPnJ302kJJB962VyDQAzysheArq6JGIueQmy6Dsg6SOzllA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Proofpoint-GUID: kHlEEljXcstYjEM0YcgOmTXlEILwpTOT
X-Proofpoint-ORIG-GUID: kHlEEljXcstYjEM0YcgOmTXlEILwpTOT
X-Authority-Analysis: v=2.4 cv=fsWOZ04f c=1 sm=1 tr=0 ts=671c1e4f cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=UCoL41z9z_Y-KgceILwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=867
 mlxscore=0 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250176

SGksDQoNCk9uIEZyaSwgT2N0IDI1LCAyMDI0LCBDaHJpcyBNb3JnYW4gd3JvdGU6DQo+IA0KPiBU
aGlzIHBhdGNoIHNlZW1zIHRvIGJyZWFrIHN5c3RlbSBzdXNwZW5kIG9uIGF0IGxlYXN0IHRoZSBS
b2NrY2hpcA0KPiBSSzM1NjYgcGxhdGZvcm0uIEkgbm90aWNlZCB0aGF0IEkgd2FzIG5vIGxvbmdl
ciBhYmxlIHRvIHN1c3BlbmQNCj4gYW5kIGdpdCBiaXNlY3QgbGVkIG1lIHRvIHRoaXMgcGF0Y2gu
DQo+IA0KPiBNeSBrZXJuZWwgbWVzc2FnZSBsb2cgc2hvd3MgdGhlIGZvbGxvd2luZywgYXQgd2hp
Y2ggcG9pbnQgaXQgZnJlZXplcw0KPiBhbmQgZG9lcyBub3QgYWxsb3cgbWUgdG8gcmVzdW1lIGZy
b20gc3VzcGVuZDoNCj4gDQo+IFsgICAyNy4yMzUwNDldIFBNOiBzdXNwZW5kIGVudHJ5IChkZWVw
KQ0KPiBbICAgMjcuODcxNjQxXSBGaWxlc3lzdGVtcyBzeW5jOiAwLjYzNiBzZWNvbmRzDQo+IFsg
ICAyNy44ODUzMjBdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzDQo+IFsgICAyNy44ODY5
MzJdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIGNvbXBsZXRlZCAoZWxhcHNlZCAwLjAw
MSBzZWNvbmRzKQ0KPiBbICAgMjcuODg3NjQyXSBPT00ga2lsbGVyIGRpc2FibGVkLg0KPiBbICAg
MjcuODg3OTgxXSBGcmVlemluZyByZW1haW5pbmcgZnJlZXphYmxlIHRhc2tzDQo+IFsgICAyNy44
ODk2NTVdIEZyZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgY29tcGxldGVkIChlbGFw
c2VkIDAuMDAxIHNlY29uZHMpDQo+IA0KPiBUaGFuayB5b3UsDQo+IENocmlzDQoNCkRpZCB5b3Ug
dHJ5IG91dCBSb2dlcidzIGZpeD8NCjcwNWUzY2UzN2JjYyAoInVzYjogZHdjMzogY29yZTogRml4
IHN5c3RlbSBzdXNwZW5kIG9uIFRJIEFNNjIgcGxhdGZvcm1zIikNCg0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1p
dC8/aWQ9NzA1ZTNjZTM3YmNjZGYyZWQ2Zjg0ODM1NmZmMzU1ZjQ4MGQ1MWE5MQ0KDQpCUiwNClRo
aW5o


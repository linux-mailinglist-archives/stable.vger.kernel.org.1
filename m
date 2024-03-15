Return-Path: <stable+bounces-28220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F387C6E7
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 02:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E311F22142
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 01:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC8139D;
	Fri, 15 Mar 2024 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W+s6R/Ba";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IAmJrUC7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L+2iNMWG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE7469E;
	Fri, 15 Mar 2024 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464644; cv=fail; b=ba/LJygGN0kfJ9ntyB83Vr/VaVsqPfRIEDRLShlahfQLH+lRoF0/qKBA5pJINrtTjb/j3O659KFISa3zZhXHUjnQwfOICtHs8bVBgLIHB80nsqHSasgUgAt7EwVD50M4v1kpES34cYHvOnnyzmd6+QtO/gRmZsHA2dDwJ671gfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464644; c=relaxed/simple;
	bh=8/+nL2861ZPtVPBYK2a6Zi+6QSHSjxYXLdfN1M5Pue0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ek8TkBzn2p7cMZtZ5s1IAypDWRbXu1/bkWWcFM83GZ/YUuoJD7FDlQGXTPeLgKE3C3WXQkQyWgfi5cpNL7G/aR/6bTVwmECBNopBw2l2Jy+S1g1I2KDi1xneADtrkXqomd1AP2DzUe1+lVp8MRZMsIhonZsXbWPa3P7K8ECwlPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W+s6R/Ba; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IAmJrUC7; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L+2iNMWG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EMPAxN020071;
	Thu, 14 Mar 2024 18:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=8/+nL2861ZPtVPBYK2a6Zi+6QSHSjxYXLdfN1M5Pue0=; b=
	W+s6R/BazQLJZxl/sYz0tJr/nC0xUbt689JHNM43sBeYQTEpeQ21IpwHzT4fRHgO
	ExIJadIIcpiEFd8oS6LzQyV7DIY4nxrsqfGNf5xqq4M24CYpB/OoXJQEmxE6PDU1
	8rCdGNNs2lQZNUaaGDONgBT8MYxajPqt0Vr1/QYm4J4QZ/ycSeq3t1WH/3QDoAj4
	4izMvIGVRSD+ov7L/dHnsfBUfzdMebreul4DhayDmxmb0cfeiakU1NjxxOjN8vJR
	VTDQLTDjhx1srHYr4ekJPMjmVB13JwB1q5Vkh8DmZad/2eL+kxLtRwK+AHXFbq72
	FT4v3dPneAhHAM6z/nb7aw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wva05rf71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 18:03:44 -0700 (PDT)
Received: from m0297266.ppops.net (m0297266.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 42F11WIF002148;
	Thu, 14 Mar 2024 18:03:43 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wva05rf6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 18:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1710464623; bh=8/+nL2861ZPtVPBYK2a6Zi+6QSHSjxYXLdfN1M5Pue0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IAmJrUC7LtHQhVS3eY08Br/GswbNQVnJSicn0Cg5ZPBBPVWzmXevLN1qJk4VGZ1cf
	 gn4gKdoCGSM0bX+3KMUED/dpWPhAVJmYO4AxlZepna/A3/g6U+xfnhRNSGtt09gvzx
	 LKWDOCt8znhs/acG4pRghXdghTfjo1QWEEMZagMidYXFdoVU+xTThTHOA5uIPes5tm
	 hps1gH6MppLaH4+NmY+8fLvidE6SA4WZTp8r34ACYf7a4jcYe9lWELs9JrBnc4cXiA
	 w9nSdO+C92oRREMuiFrdcthlbB5oJFy7Pnw8jZMSqa8870aP85pp/HHU0ZqXVKar4a
	 WnWy43CLktqxA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 84761401CC;
	Fri, 15 Mar 2024 01:03:42 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id ECE68A005F;
	Fri, 15 Mar 2024 01:03:41 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L+2iNMWG;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id F118C4024D;
	Fri, 15 Mar 2024 01:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0U1EbozcjpwHcp1fsrAFz1LsPHodXoBfrTL7XR1exZ43vqrdvvubikR7cmHxVUMBTMdJF/wq4MwLHDa+WTyxL6eB2bdBZnj4kZcxIF5BgNFi841jv+k7YZXwC9cmIeKb/VXUm4E8pcBGOFK6cNGUDx2rY1rkp2PijavyfPFXmerTY6dVDvVDgLz7xcU+ZW5EDTZzn85INhz0Wpw0ujOyNK25ImkZzXyhKnZsi3wpL3aAcf+mLLaQD4jmINckZkaeh8it080dfTK7+igsWYL+ZyHwW3L/AZttwbY14bVkc9rQUh/l4x+UVpD6lo5MxEUGKI8jmcL+lXPhyWCF38+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/+nL2861ZPtVPBYK2a6Zi+6QSHSjxYXLdfN1M5Pue0=;
 b=h5c6v/t0im4MAo/zooShG/dyTKMkIBhZe4Oc3E9EUyz4NDEJvUpOpPtyFaqkYTlOUpqM1QlDf1yq3YZ3WQ8aiMWXkYEN5PfoN1lK1gwDM8a9X8K4v2cUWjjP6s4uicIsP2EiUAsaiTerHQP5PsrttTdhtwFZLsM1/m5YeE2DUzY7SYAOb8ENH/Im1ELSfSwS2LZoY147L02QC46a5PI/aiUD0+RC28EsEmCGmukXanaSm8Jz0/noI8ZtU+viDs5OYKF0al88IBH9gSXq5sYtsVpnCdgyObnaU1Xorzt2nf+4ISY6nBjeZRiKzJ2nxWLIbkqdvllKW5tG/yryHgSPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/+nL2861ZPtVPBYK2a6Zi+6QSHSjxYXLdfN1M5Pue0=;
 b=L+2iNMWGHyDDVOMzqhyYqORmF6Yb17pC16gkPZWIgy/IWoik76WOp2vshGt1mgcFyK+jhpleLUY6xjBJh64Q9+UIpH8M9vXg+e8Pb7OStwmo8ZmZiCt83NIxa8H8XPnEVKhFhxfPoDf+fiRq+Wt7eAf4Jzr2bAyWYjeCS7OehXk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 01:03:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 01:03:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        John Schoenick <johns@valvesoftware.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Vivek Dasmohapatra <vivek@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Properly set system wakeup
Thread-Topic: [PATCH] usb: dwc3: Properly set system wakeup
Thread-Index: AQHacQH5WA93E3+nbk+4E8/DCd+zxLEt6V2AgAod0QA=
Date: Fri, 15 Mar 2024 01:03:34 +0000
Message-ID: <20240315010332.x6xfu22bic6tqj5c@synopsys.com>
References: 
 <667cfda7009b502e08462c8fb3f65841d103cc0a.1709865476.git.Thinh.Nguyen@synopsys.com>
 <cac3f811-189f-be7f-e5fa-12ee6ca8a62a@igalia.com>
In-Reply-To: <cac3f811-189f-be7f-e5fa-12ee6ca8a62a@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ1PR12MB6148:EE_
x-ms-office365-filtering-correlation-id: da193540-f3f9-49dd-1efb-08dc448bbd4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z4XRdVeEh6Agt3TTwSh0HWtU1zYBKIQRtz1lD1aZXxAlfrppLUVOtQWLkat4TxWVQunqUeupNts2ni8WlFujoLbsBp3Ie1dtEtk7S+HPQnZO2Vr8EVFXjLOuJBpexUpYiBLGInoyQheZuKpp7Bq5G8PqCa2lTCDAkEwI2o/zCuynnD12sSPif0JfDwZxlxPiA6/FDRVXVesgGs+VNV+mbjrTSMC76eBWolfRzF9Uz9MNys4vpV5mMt1rwpyHYPO3q4itO1CdFUcIPabO02nYTzpDBWrFyDApzkSX2myjcZuhwT10zU7nFrN1iMlp+sk8fVyoWzF0PeYY4tO2R6yE+FL/+Ka1pHaUf7YtTOwKSzuFcMyFvys5h0wUQioG921vZ7Q3I36+Q5QIxVC+T2h/vCe5ipbVY5Xehjt9RfyGfOD2qlB3zdz7fbG71CSkVPhtTe9MYyeYKHshbDkKhGZHwcTX2a4QmIJCfJge+E3erXnOvLbPU3V7q1GLbHbroSbmi5X/GVhqqvnwIN6Kc4FKdJpLNGuWpi75n35LgqF5WCiCYlNktFKtE5H5X7E1N7DVc7OepYC8OKRrm2nBAnQYa2coT3IoL3KlHYIbxQorLgiAG+D46VgTQ7zIChPpc9GUVf9eRx5mugNMTOiVA9648v5DKcQ57Fib8b127zMkzCE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cnlwUENNSG1YZ2JwY1d4bmxNVU5TSkV1ZDJHaklmMXhTWTNhUlphU1JiQXJO?=
 =?utf-8?B?bHZyS0laQkhuOVVOUDlNSE9ERDV2VnkrU2RUSVhzbDJUOStka0JrNmRxY1hP?=
 =?utf-8?B?UHlUMjRTV09rbjZtMTlOeCtBZFhsamErK3RKdk9pRHowM2V4VWd4VWdkckhY?=
 =?utf-8?B?M0wxYThuOWpnRnFLcHpyTzArMUNQZHJZSFQwNG1QSjJRY1RXZGF3U1kvYWRR?=
 =?utf-8?B?Ym9ySDN1RzRhT1hOdldtSW5tUDUwOFkreGhjL1dwSVN1NWo5ZHlHNUFSNk9l?=
 =?utf-8?B?WWpCZHNoVFNpU0Z2ZmxnRFU0b1VqeEkzRlNxand5b3UxMnROWCtvWlZOOCsx?=
 =?utf-8?B?UmhOcDNmNis3S0I0Y0xvdjh0bUxTN2pjOEdWdmFpVDBwTHA1ZnFhOXFmc3VU?=
 =?utf-8?B?UldTRDIwM1BUdTBNUjBZL1U2a1RRT0RMZEYyRkN2OG44T0VaMFUzNTJXRHdn?=
 =?utf-8?B?TkNpRHpoUW1YOEZROGd3cjF3dHRtUTJNTitqUWlGZmJGbEFtUVQrVW5sQkxt?=
 =?utf-8?B?eWt3OEUrUzFWK3NlSFJBYW9UYzRDa1N3SUcwVUFydzJ6OHl4K3BoMEtVbEpV?=
 =?utf-8?B?Zk5jVXpjK3hnU3BWUHZ3a004aWlYcUR2UGtRUzZHclVQOENTeW9lUXYrWVVz?=
 =?utf-8?B?M0NKVHJUZFE1M2FUQkp0dnN4SVlqMnBSaXhmaXcvY09yVmo4SXhIbCtDSWxy?=
 =?utf-8?B?RHlzRzlGcHJxUEI2UXdycnVLVGlXTkI4WnVlVVZSb0g5YXNDcmUyQ0RBYjRI?=
 =?utf-8?B?enRqVnR6OUQ2N0hIWjd6elZsRk1KZ2RTQW5UK2dIT1dzSUt3MzhaNFQrODVa?=
 =?utf-8?B?V2xSLzc3TjcxbUJ6UUpDeEs3K1ZPV1l0NUx1aVRoRDJqUVIvSmJ1Y3NSM1Jk?=
 =?utf-8?B?Wlh6VlFTSHV2NHc3bjlvVzNYbGtWa3MwcmM0YzhydFBObXkvMmU2b0c4Rlhs?=
 =?utf-8?B?ZEllZUdJM3Z0SFk1Q2lvU1B3L2g3T3cwY0w2eC9iY3NVZzRwSUNBaTg3Y2lh?=
 =?utf-8?B?YW9VZUg0ZnUrYnBVQy9nbElBNUNZdzJpdzY0bWt4c3Q3aDFnd1l3eG9ma2JO?=
 =?utf-8?B?dzRrM3YvU1dNUnovSVFHdk81VXZaWmxwK2h3Qys4Ny9JaDNPTGI5UXZzRkZv?=
 =?utf-8?B?L3hXWEpBK3NMV2JMdUdWcHBVT3RHcHhGdWMxSkFJMjhqVHE4VVNKc3pQRnlk?=
 =?utf-8?B?aXpYZTdWZm82Q2tXS2dqc1Q3UHhxZm5RL3FTTUVadWtDWGxYR3FTYlUvUWhC?=
 =?utf-8?B?a29sR1lzWHBYL0RRMjhuTmF0SDl6OVkwb2xRRXpreklTb1FqMGNscm5SdVN4?=
 =?utf-8?B?UTNuK2srZElVMCs1VitKclB5UTRuVU1hZGlmUmlIRmtTVTVPRzB4VUJmZ1VD?=
 =?utf-8?B?ZmUraWoyVk52elcvZStRUyt1SzUwL29HSTVJRDBmWjVsRlJiNHh3enpMenFl?=
 =?utf-8?B?WExyT0NJYlE3dDI0Y0NIMjhkNEt1MTY5M2FoenNqRlk4eFNrdkZMemFkNEp1?=
 =?utf-8?B?QVZ1N01idzVuY3VLTExzNDJ3Uk8vcGg4OWVlcHJBM1RaczNQV0ExMEc1YXE2?=
 =?utf-8?B?TzJnZGlmSHIzZkdKYnBxb09oaGJZb242cFQ5bm5temZTdHVocEpaRjhqbXlo?=
 =?utf-8?B?cUtWZ1p4UDZSM2NDUW1aQUp4cFplV3VuQ3psTHJ5NmhNRzF1SjAva00vL2tN?=
 =?utf-8?B?MXBickdYZHlEMVM1TEk0N3NQUEdFTllXalZNQUswWk5mbHJEdzBEcGVxWWVo?=
 =?utf-8?B?dXNqbkY1aSs4YVJUbGZFTFdjQ25zajBvN001aldRa3dzWlRhOHNrNDNsZ3dT?=
 =?utf-8?B?Tmx4RHkrWUF2eUFrd0dPUzhRQ1BmMWlsVXVGWGVkd0Q1Qzd3ZWFHa3dDTGtw?=
 =?utf-8?B?T2E4QldxejMvOFpaZ0pJSE94RFVhOGZoUmlTMFVSYThlUnFVOWprV2xsWm1h?=
 =?utf-8?B?eXVwYzNTM0d2ZFFXNDgvT1ZyZ0l0QXo1TkdlL3d3RWpBd2dzNGdBY1pWcmJP?=
 =?utf-8?B?NEVJSTZ3RmhHa052UUdLQlZNcThSd2VHSHdSaEMycW1CRmFjL1FWaXhyMDN2?=
 =?utf-8?B?bGxWMVlyTUR2TTF6aGRlSHNTNkxzSS9zT0JmdG9EcFhFRzRodHlOazc5UkFK?=
 =?utf-8?Q?KzO1FsKPqduxgkRklwUI7SxD0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F470926AE808A4598D413389A0D40BF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	C3xVKZKyHqHaXv8iAf8fGJB80c2CcypVLEk5monTtNKHJw6riASSrFpzH+HYPIyoGWYDdneqfTyvL/7HtFR/I0RdMHa4DHIrkM2mlHFS5AQTrVW2CASWI2XCURYdyb2rQ49tHaNMyJmQHySE2GMrmzMBJHVyScj+p/whtX4riP1iulMx1c3lNYKZD13g7kCBUzJbhlPsz10bQ428Ff+k2dweNuLql7qtiqizsdfbSXmxteUQG3oygPBjRmU+rV6Gd9h1S7Vsi09aLsi4bb/Qj0FmFPC/AGYy0yKuL7/MDEWXXhbY08B6l0Pyt27DJhksvL4RX6DfC6gIkAjl2FJhJdQ9HyTTcRlVwtut3bc9oX2B3Ji6m0z0ANdWCk0frdVxaYkskov+Cj34YyJ0eQ4NMMHWzMFBx6K9YL/zDvQukTXQTgxSkleUKi5u+I0j64L2T2SKitWJ6GiJIq0wowpIvj5evDUSX15qI0bMAic4VznqsqM2ZZrWqRYvUVCYi4yiKACF4O41cw/WLyJSnubjw7PuUceJb2G2HDjRlsy0bEgEEOvLQRlIh5RVVIEXk/2E6N0SceG/x5u9Ko8m+PQLVKSmr8kAPlyDLi+XfCm+fIZJ9Bvc86JnZ/JxmhgOCDfDKvMWuO4ffFlabYgnO/D6jQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da193540-f3f9-49dd-1efb-08dc448bbd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 01:03:34.6633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QORQGcvhQiU0/SINROZhRuRPAiDscoa2fsTTuxzZJnYX7bKnNrpEL5kKXhTL//k3/oJzFK9AEv4V6iAzse8vvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
X-Proofpoint-ORIG-GUID: 2zfp5t4-9TSdvnWa9ApHPUZz2VMpdT4m
X-Proofpoint-GUID: vQzPcJPKPAV5rrKyO4GimsUG91QV7uA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 bulkscore=0 clxscore=1011 mlxlogscore=766
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403150004

T24gRnJpLCBNYXIgMDgsIDIwMjQsIEd1aWxoZXJtZSBHLiBQaWNjb2xpIHdyb3RlOg0KPiBPbiAw
Ny8wMy8yMDI0IDIzOjQwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSWYgdGhlIGRldmljZSBp
cyBjb25maWd1cmVkIGZvciBzeXN0ZW0gd2FrZXVwLCB0aGVuIG1ha2Ugc3VyZSB0aGF0IHRoZQ0K
PiA+IHhIQ0kgZHJpdmVyIGtub3dzIGFib3V0IGl0IGFuZCBtYWtlIHN1cmUgdG8gcGVybWl0IHdh
a2V1cCBvbmx5IGF0IHRoZQ0KPiA+IGFwcHJvcHJpYXRlIHRpbWUuDQo+ID4gDQo+ID4gRm9yIGhv
c3QgbW9kZSwgaWYgdGhlIGNvbnRyb2xsZXIgZ29lcyB0aHJvdWdoIHRoZSBkd2MzIGNvZGUgcGF0
aCwgdGhlbiBhDQo+ID4gY2hpbGQgeEhDSSBwbGF0Zm9ybSBkZXZpY2UgaXMgY3JlYXRlZC4gTWFr
ZSBzdXJlIHRoZSBwbGF0Zm9ybSBkZXZpY2UNCj4gPiBhbHNvIGluaGVyaXRzIHRoZSB3YWtldXAg
c2V0dGluZyBmb3IgeEhDSSB0byBlbmFibGUgcmVtb3RlIHdha2V1cC4NCj4gPiANCj4gPiBGb3Ig
ZGV2aWNlIG1vZGUsIG1ha2Ugc3VyZSB0byBkaXNhYmxlIHN5c3RlbSB3YWtldXAgaWYgbm8gZ2Fk
Z2V0IGRyaXZlcg0KPiA+IGlzIGJvdW5kLiBXZSBtYXkgZXhwZXJpZW5jZSB1bndhbnRlZCBzeXN0
ZW0gd2FrZXVwIGR1ZSB0byB0aGUgd2FrZXVwDQo+ID4gc2lnbmFsIGZyb20gdGhlIGNvbnRyb2xs
ZXIgUE1VIGRldGVjdGluZyBjb25uZWN0aW9uL2Rpc2Nvbm5lY3Rpb24gd2hlbg0KPiA+IGluIGxv
dyBwb3dlciAoRDMpLiBFLmcuIEluIHRoZSBjYXNlIG9mIFN0ZWFtIERlY2ssIHRoZSBQQ0kgUE1F
IHByZXZlbnRzDQo+ID4gdGhlIHN5c3RlbSBzdGF5aW5nIGluIHN1c3BlbmQuDQo+ID4gDQo+ID4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBSZXBvcnRlZC1ieTogR3VpbGhlcm1lIEcu
IFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+DQo+ID4gQ2xvc2VzOiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzcwYTc2OTJk
LTY0N2MtOWJlNy0wMGE2LTA2ZmM2MGY3NzI5NEBpZ2FsaWEuY29tL1QvKm1mMDBkNjY2OWMyZWZm
N2IzMDhkMTE2MmFjZDFkNjZjMDlmMDg1M2M3X187SXchIUE0RjJSOUdfcGchWmZ3QTEzSWtEY21C
WVI3aXhnbHpzTHM0LVFXVXNORXJzcWQzZEktQnpUQlJob0pKQmI1MDZPakNwVmwwZnJUUC0tdVlK
c3V3UXgtenRCMG0yVVFLWWckIA0KPiA+IEZpeGVzOiBkMDdlODgxOWEwM2QgKCJ1c2I6IGR3YzM6
IGFkZCB4SENJIEhvc3Qgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiANCj4gW0NDaW5nIHNvbWUgaW50ZXJlc3Rl
ZCBwYXJ0aWVzIGhlcmUgZnJvbSBEZWNrIGRldmVsb3BtZW50IHRlYW1zXQ0KPiANCj4gSGkgVGhp
bmgsIHRoYW5rcyBhIGJ1bmNoIGZvciB0aGUgZml4LCBhbmQgYWxsIHRoZSBzdXBwb3J0IGFuZCBh
dHRlbnRpb24NCj4gb24gdGhpcyBpc3N1ZSAtIG11Y2ggYXBwcmVjaWF0ZWQhDQo+IA0KPiBJJ3Zl
IHRlc3RlZCB0aGlzIGZpeCBvbiB0b3Agb2YgdjYuOC1yYzcsIGluIHRoZSBTdGVhbSBEZWNrLCBh
bmQgaXQNCj4gbWFuYWdlcyB0byByZXNvbHZlIHRoZSBzbGVlcCBwcm9ibGVtcyB3ZSBoYXZlIG9u
IGRldmljZSBtb2RlLg0KPiBTbywgZmVlbCBmcmVlIHRvIGFkZDoNCj4gDQo+IFRlc3RlZC1ieTog
R3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+ICMgU3RlYW0gRGVjaw0K
PiANCj4gDQo+IFNob3VsZCB3ZSB0cnkgdG8gZ2V0IGl0IGluY2x1ZGVkIGxhc3QgbWludXRlIG9u
IHY2LjgsIG9yIGJldHRlciB0byBtYWtlDQo+IHVzZSBvZiB0aGUgbWVyZ2Ugd2luZG93IG9wZW5p
bmcgbmV4dCB3ZWVrPw0KPiBDaGVlcnMsDQo+IA0KDQpJdCdzIHVwIHRvIEdyZWcuIEJ1dCBhdCB0
aGlzIHBvaW50LCBJIHRoaW5rIHdlJ2xsIHByb2JhYmx5IG5lZWQgdG8gd2FpdA0KdW50aWwgYWZ0
ZXIgdjYuOS1yYzEuDQoNCkJSLA0KVGhpbmg=


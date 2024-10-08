Return-Path: <stable+bounces-83099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A08B9958FF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 23:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6611C2122E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3812139A8;
	Tue,  8 Oct 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dFqbwRsO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iTig5Nse";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MPZMY4Ur"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7C1C1735;
	Tue,  8 Oct 2024 21:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728422119; cv=fail; b=nVVq0qbZxg991ga0jR5ob4KnS5scQrLj5dfKt1MCWiFE4FClUuHW3Yf2Ugem48qnbI9gGUbeHHOcoLURsZUo7wIB+1p+8fur8KFkENOZGAhYXX3LgU8/pvC+IOL1kbmDw35QiKLsbcSQcKl8+JVpDoqu/hFuj6Ds9H8uu6jr0A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728422119; c=relaxed/simple;
	bh=EArCK+JMb98bWLaMaUYdJSuGZFGo143+MFZCHEA7Hvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIw0LmF76UktmKnWEVU3d0N8sZyxuHFc+6DBg8N28g3etTin7z439fKLClYlwXS6RL10dgjzSOlyOITUY0HzZaiDeBPQbhCDYPoV/HbHnVxKdUwWvN4gxju48hkG7S+zJ2BdMVuUq5UZKKQg2hn3R1LET4jaOfp525Mo4EKk6YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dFqbwRsO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iTig5Nse; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MPZMY4Ur reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498G2P5a021959;
	Tue, 8 Oct 2024 14:15:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=EArCK+JMb98bWLaMaUYdJSuGZFGo143+MFZCHEA7Hvo=; b=
	dFqbwRsOe+hKfhCDje1GTaN/UBaNqd0fTieR9jLT3N7Xuxg6b55Tux4mtjZDMCwX
	NSXVZEl3OaLtzFsLsmkixX2LUP0F1QiO00eSXLg6afitk0GRqhhZxD+CNJA6XHvS
	SOC6zKUmNz+CdIF0w19s3VbslI+1lBM4/mUZKsakwteCM03KQt7C1WZ10TkApLI8
	nsuUchI1qHnwR6sjiyeaF17k/kisVHJyfbdbrWmAZeqZiqO0txRxwxiY3zruXu6M
	0AH6SaDHTXHyzu8mUmehXnz0AOMibncHCl8m1xXxqv8VEES+K7QV7Sj4vRkOE+p8
	sncPot3kI9GKl5ASBF46NA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4257w89gyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1728422113; bh=EArCK+JMb98bWLaMaUYdJSuGZFGo143+MFZCHEA7Hvo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iTig5Nse/eEwD4edI8FyY3Ql+hbYr0pz3Lb6xywKpD6k2dUUijXlm7qE/q5VddEE1
	 MKCKXmxFuAW9dRZmQYRH4sD8o3iNfkmF3/dZdIJYxXtCb9LoMPTV2MPvIZ/9/+4HI3
	 rRuCvAQLir/aRh2gvUyP7pWrEbH2lsn01P/rMeHVADD5UcqlsybS42Je2cU8AgAu7w
	 k7yzFJOB3Gme5xp26M0NgpkjRDmtMtkyPwr58Y0Nj9XsJSopc/rbj4zK58YiUOfhR/
	 LeuIZd7zwqvcLwAYab7EFCggK/ISvFNqCwoV/dx0edfs+d/N/IKAZ5Bw0n/E/YKHxW
	 60f4GrWO7SeVw==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1060C401C3;
	Tue,  8 Oct 2024 21:15:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C9066A00AC;
	Tue,  8 Oct 2024 21:15:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=MPZMY4Ur;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 154B34035B;
	Tue,  8 Oct 2024 21:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKWqrTgnRn8z1RarPfjw5EUB9RHs8rTDmsAMBR7LrAeO8dWK0itT9nEo4T1adUJAI4iN8208kAmRIJuz2HhtrRx6sgxGA3Vlv4DFBtIXHt86yeKqvMYoGz5TaDxSErP2DDssbRMU4NPHAzEjGhewxJsEpL+f50ewZjDJRuIHiR9p9B18K8jLaxzbDj9ys1KhQ9xJ+tEgMzbgVXlHJ9DL9wV4JUGrbS2hymsWYiUi+yRYIgMEI8u/yD9XxvQr1HWcB9Plz5VMQY2JKN6ZqB4Db2OUpcuZnwSiPm0PfGsbV+7OzvJZVZUMq+4dLrYCE1fp5IqZJdPptzG3viiPvi5e3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EArCK+JMb98bWLaMaUYdJSuGZFGo143+MFZCHEA7Hvo=;
 b=x91LGuUHA5pb4TMlgwGCm98cjbrP5nEgNndfN9/1W8TAseuAk7Y1prlTXqhicYjnBP8Keq4sOT9dirndUPqWAFaQFVlPz4vAgm7/FjtJJVW4lo8znzp7ERfUxvaHWY/5hnA9jtkPN814wOH2h3X3oO9vP5HTN1DWeOg2YcEzaN23NSUx7Hy4aVrvdaO+9UPpk5vS1J7FAJXbGXrm8X4c0r4pg2aU4XsAPJyM9JBnR8GQknCvCgFbGjfZM62yeAg1pNgaVlGZrUQ7S0ruoeAJ9gXtqmZjkF0JNMtE2mIZAx5TSUi5ESoXRxu+etkIcQ++UiIUymd6YUXk8QWYBxGHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EArCK+JMb98bWLaMaUYdJSuGZFGo143+MFZCHEA7Hvo=;
 b=MPZMY4UrkDROUnOjbQf9zeXP54wmlD+n6/dDLMNB6BtactonOf1SJr7d9Pe9K2oirwFxszQ74ro0L1owGNVDe45EGXw6beZmhGhWUmEtSpctvNPyBgNE53CaakZm2MF+7YZObn3Ch+6s8sSd97ByOAgG96Bmhv3h/RV5s0G9uTA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:15:08 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 21:15:08 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring
 GUSB2PHYCFG
Thread-Topic: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring
 GUSB2PHYCFG
Thread-Index: AQHbDmS7XuIxqPDVR0yP6DvWA5JKD7J9cYIA
Date: Tue, 8 Oct 2024 21:15:08 +0000
Message-ID: <20241008211506.kbszzkbfk33ozgxp@synopsys.com>
References: <20240924093208.2524531-1-quic_prashk@quicinc.com>
In-Reply-To: <20240924093208.2524531-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5817:EE_
x-ms-office365-filtering-correlation-id: cf78a34d-f012-4367-36ed-08dce7de498c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzFBazRkd3NRVHJKYm9OazEyUVE2SlVoNUdHWXJGOFlkd3RCYU9BUHkzU1Vu?=
 =?utf-8?B?a0pKbFVTUjZsU2RmcHloTG92UXZoT21HREFjNGJpRnQ0Zm0vS1BlclkrclRQ?=
 =?utf-8?B?K3N0dlIzakxvQjhkb2Z0YUFsZnB4a1A1YzJDME5WaFJmNTk3dWhQbm5NYkNi?=
 =?utf-8?B?UjZOKzkxWmF3T3h5WGU5TnRBZm42ZnpmU0VSdzVLMVFoNHBSQ3ZCMGZxdVQv?=
 =?utf-8?B?cWJHUmtBeXZLU3cweDFkNGIyT1FQV21Dd2k1NjBYVkN4QmszYmJUMjg4M1ow?=
 =?utf-8?B?MEgzcTU0c0ZwYlN4U09hM1dYQjVTVk95Y2VuNTUxS29CL1c0REFvcmJmNEtw?=
 =?utf-8?B?R1ExK05SMmVWV0EwYUozcHVHTXV3U0NqNi8zNHo3LzlKd1U1ZkFSMGpweS9R?=
 =?utf-8?B?dnZPMzFLOWFoWGJTNFN1QVdYdUtoaWJxUWs1WHA4NFFHdmluSWVqMURqVVpn?=
 =?utf-8?B?M095Y1hJWmpHMVhZMVpzY01yMmJ3bDJYKzBvYTl0aDgwQ25TL1U2cytpbmVz?=
 =?utf-8?B?ZE9GSFpBNm4xYjkvd2dIclZnb1l2UnUrTjQyMFJiVG43YmJKd0wweWhWMHgx?=
 =?utf-8?B?TjRjSlVVY1NKWnp6LzZkSHZUV0RVVjlBWkR0MVk3TkQ2WCtvTkloV0JJU3h2?=
 =?utf-8?B?TWhaeEFkdjBqMXI2SUJuREUzK2p3eFlHalJVelRISnJ6WFhiRjNrV0NCaSs4?=
 =?utf-8?B?b2k3S3pvamNkOWFIcmVFcjZTVHNjWTNpdDdhVTQ2S2VLUjArT3pFVm9iL2Qy?=
 =?utf-8?B?R0JmZC9zRk96OStLTVZVQkgrcVViZkhaWitiZlhSU3dnNlY1aUlFSlpPUFR2?=
 =?utf-8?B?L2l6cDY5dEZtaWxVWGtLNW9HU0NHbWF5WnRvenhwOXVoc2pSVkdtM0NrSWp0?=
 =?utf-8?B?NTNnZlRscWdqL3dzdyszMmxsSTFFVWp3RXNDK1paMXdVeWNRWVNURkljZTBI?=
 =?utf-8?B?OENHaUpSd2NFWWc2bEtERW9aZW1VcGVJVjJma29yZURlS3NzaStaeDJJbDY5?=
 =?utf-8?B?NjJFOWhTVERaSzk2dzlEMW00Vk9YV0pmejNiZ2I2YVByMjFxVjZYSytYdDg1?=
 =?utf-8?B?VEQ5eTNyNUlhdWVzaUtjaG5SYjRYZ3FHTko3T2dwU1hxYmVXRVkwNDZzazJ5?=
 =?utf-8?B?cEhxSExHOW9XLzBMZGtMajk4c0dDRmd5V3lBbDFJbkFuaVA1VzBhcUkweHRJ?=
 =?utf-8?B?aW4yWWxmVVZYOHpPTzllUFVteUozTExMemlhc1Mvb2UxRlBpbVFHM0w2d3BX?=
 =?utf-8?B?NjlhSmNGU2thQmREQWRjK2pWb2ZGOU1za3Q0a2RMWUxTQU9HaSsraDlPT0JZ?=
 =?utf-8?B?dEhCNHo1eDZrMlJtSURWdHR5Wkg3MWFtbi9JSlVkdWRENXZTVXdEaUhPNXYr?=
 =?utf-8?B?cEJmSmM5eThTb0NWaXIzODZRMUdlOURySFdhazZjaVNBaDhyZk8zV01zMHM5?=
 =?utf-8?B?U3g4UVlSUXprZWZLMjh2T2V6WUVkeEJhUTRaVVlYekFCUUJET1U4cThCSE5y?=
 =?utf-8?B?TExTN3RERithaHBURFp6TFp1cVJvbm03NUY0Zk5KYnVCRzZtNHMzaFdiNjdI?=
 =?utf-8?B?YTRnZXlnVjR1TkNhOTlCUTRxcFRUcVh5aC90ZXVMcGtHYmpOWUF0YS9QSkQv?=
 =?utf-8?B?dzNsNmNtRjFWYVlIcFBLNUh3b2ZnSUVkaTZYbmsvKzhQYzEyMnZvcHlsbi9F?=
 =?utf-8?B?a0srOEdlUXFFanltWFYyd2wyK3RxN2MzdmU0ZlhHZHVqbTdraXJXaHFibjZH?=
 =?utf-8?B?ZjZaa2VLZU96L1dNbSs3SkErVmt1a1h6OVNUdDFwaGU3aEtPcWEzRE90MnI5?=
 =?utf-8?B?MjI4amZyU3U0UUJSaHk3UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ulo0Y0RVM2JmYm56VDdVbGhaSVpoZnp4VlJaWVFRR2xXOHA3T3lMWi9OejZ5?=
 =?utf-8?B?YjdZTXRNNld3cFI3OWdBUnhJbzNFNkVFVUFjZENQdFJPWWxWMXVRSWRMc011?=
 =?utf-8?B?YWVRWE1QVURGcGN2SmdHblQ0UmZvT2FST0k3NzBDOUduMjJKNHh6TUJKMHJ5?=
 =?utf-8?B?T1NvWTFGbVV4Z1RIVis5NGhKZmNycDh2SXVYQ2pOWmZhanVBVnMyZG1lY09F?=
 =?utf-8?B?T2hMRStFei9zdnpINVlKbUs4alZMV2svVWF5ZVlMZVlLZGhSeU1wcGUreFB5?=
 =?utf-8?B?NlplS1BQWVEzZkhxZ0RCa0ZBeTgyUW44eVpzZGJ1Yk5FaVIzalFoVEJjL2ha?=
 =?utf-8?B?Y3pONzVRZnBYQmF4NVlDRHVRRHJSaWRPaHhpOE82RkhwYmhYRXFkanU4bW10?=
 =?utf-8?B?QkV2VmRsbkFVcTkwbmsyRWlLd3BFTHJseXZ6UVlaaXZQeDJZalRQK3MwWDMr?=
 =?utf-8?B?UDArN0ljbUlVZmJQNkRvY3lrS3l0NEZKeU5jY2tZM1ZZTnVQYUdoeCtmMnJa?=
 =?utf-8?B?YzM0d0RJME56SnNUdWdSeVZ3M1l1YU9iNWZScnc0YXR5U2RCNE9IN25CWGNL?=
 =?utf-8?B?R0tPMlg2MEsveS9LSno2UU5HK3lxT1MySy9ZM0J4KzRQVnp5WkljMko2NzFU?=
 =?utf-8?B?bmR3b2JGUytKalFBY2s4UFZTOGpaSk4vMFROYnBsejRPa3BaYVhWZDJsWEl2?=
 =?utf-8?B?NGx3ZlJzc015R1FRUXJ1YVZUMVBjRkRLRkhUNmlCcUZoTmdrOWJtSEhlNTVI?=
 =?utf-8?B?ajdPTTZMSFBkanNjYzJiSHhCWnJvd3Rrb2tqVGhidHZ0NC9xa2ZmeHNXQ1hC?=
 =?utf-8?B?aGkrQjFBa0Eyb2tiRDM2Vng2OFNOVXlmS0JKcG56emZyaE4rd0dpS0tIZDF0?=
 =?utf-8?B?azhEbWpKeUFXRUU3UUdNMVRxbjRFNW1WaTVCeUc4dWV4ZzQrSEdYYThzWUc4?=
 =?utf-8?B?T1ZSTk9xRFZ0RGE3Z2o2VENTRmxTTWsyaDZSc2VCMG54U3REWitZWHBySkZp?=
 =?utf-8?B?cE93a3Z0UzVKaVlvUGZYMGJscGQwV0lqTmRWU3BvbzZTVVlIMHhCUmRsclM5?=
 =?utf-8?B?dW5SbHBiUkdUak91ZlhwWHV4bmVPeTdUZERqYjZZcVZaZjUwNXpKU1l2ZTE4?=
 =?utf-8?B?aW9SczhlUEZBek5QeHVyUW9iU1dsTkIxYlhqbFRpRHdXbmgrcy9CdWM0a25l?=
 =?utf-8?B?M2EzL2VER3FyOENIZ212aHBQUWxRSFBHaVdzOHhucnd3WjZOVFdWOXlSaHlB?=
 =?utf-8?B?citMRElNOWNrME9lUVY2VDl1ME90Smc3dlQ4V0xpQkVMYklsWFBvNEFsMzJx?=
 =?utf-8?B?MnN3VkxqbWdYK1BNVVE3QW04OWZIUW9YWVd6OGxQL1dKVk5QMThsSHhWNTlE?=
 =?utf-8?B?ZGlMY1NJZGhZelM4WFl6OUVSQSsra3ZUZUo4b1lzUnBrbXJtYVdma2g5cTdK?=
 =?utf-8?B?ajRnZ0t0alFqL3U3S1pYQmFldG1ySXVKaXJabmFlRDN4cjQwMWJhQWVOS0NI?=
 =?utf-8?B?NXVKTTJpQXBmSk5pdmVjM3NSQy9tY0JKZTNtRG9TS1k5c1FJTkxkZmFNV3Aw?=
 =?utf-8?B?TnBleXB4OUMxVnM5K2UwNytBalhDeHVocEwrQnpINUZmZU1BUUFVRmg4WmNG?=
 =?utf-8?B?R0FyS05FajJWTXhxbnJnb2c2c0xnL1MzWDVCZEw1cUk0dkZsaTN6YkRKcUhL?=
 =?utf-8?B?MVhIeis2bGM0RFdGZDJYb0pnUGFOb0dOTnVscHZ3REJSNGtDejNtdjlEbDVw?=
 =?utf-8?B?Rit4b2kxMW9oYlhLVFFZeW42Sk9NMmlVdCs2blJkeHE3VVR4UTdleCsvRndq?=
 =?utf-8?B?WEZuNXVpNVV6dUJsR1JSTjhCRmJkNER1eHFtbUloUDl1RGxUOEtLUzNFbkdT?=
 =?utf-8?B?dlFyS2JZbDBHZnJ2dWw5L3RVREthQTNCRmwrSU0vdFB3K0hRTTNrTkx4ZHpi?=
 =?utf-8?B?cmx0ZmM0Yjduc20zeWt6NTR2ZUhoZUV3Q3hRS3RGb3dkMWlUUUQzU3p3Qkow?=
 =?utf-8?B?ckUvNkwzdTVEWlcvSWxqcEtwQ1hRRHpsMTRuQ256dk56cjJlMU1iSzVWLzJY?=
 =?utf-8?B?aUdRTjhuVXhFdmVvdDNDZEp4NVFkaCtscEp4R01CY3RZS3FRUTZ6bTBldXJB?=
 =?utf-8?Q?cL4uErDiv0XCVcVnPFnHL7pD8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E14048E00DF8042A0F02BD463AE033F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A3lSH3FyiCtxOGrLSZ26a/qzIgWUwcw7Ei623CZL1ZAE39UzjQ7B+CzYYUnrm5vnopo6JEoHKQ8oeBpTQ2ndxDXm37zpQUpLTd16CdgJPplAaQs9fTJjOObg9GT5kmjTZSkQgeNbs8t+n+2p8vDwMxc5Jx6Ql6aYCoE/bmFtW0w5rw3U68Tg7/cDbs7VUX6lNCPijXkilU87xB5JDKnTB0gtlZotEo6kq8teqAKpWWc9fpRXNnTpD5H8u0dQdTxSqzor0X0NHe8Hxqi4sryzWxkTy+H/qweiC6bMqELhcDfgI8qf63KyRD6emam2dJP2PlKe9JPZOl/SYdQZNDZ6qXO0+8JMjJwYrDJJTfuJ2CgknxQVrLUmTI45F9e98Uny9G+Xu30ekcITLSYRIcEX9wv3w3+9D//5mLmuSyX//OuBvwXqYjkQ7M8bXIwdYmrfiyXy4dqtjwcgwv2RkkLaqwrr53yjshDoKU5qbaO9rW/FTI90ZxUwodYdHlr5qx6EgNYVBsb9nus2RbaViCBskrYhyuDF9w1kwsiGSuFhkUN22H3SvkpOJjHJb2+I6aZd3J6clP8xfvpX8RDlir6cz1a5U0geUxkdR20OHSForelhjkEXoPgvprYAFBpK3XyfdtTKombNpEdoY9SDfYT5CQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf78a34d-f012-4367-36ed-08dce7de498c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 21:15:08.1979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gO3lN80y3CA7E1G4Wa2hws+BUOkDUQwYqeYL4GoZxv2+WpT5gk/pjaihHrNSD/M760r3qhzpBaj95m4SPLK9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
X-Proofpoint-ORIG-GUID: Hhi0gCJKzive8kV8dtXd5FDObMYIAiAv
X-Authority-Analysis: v=2.4 cv=IOpQCRvG c=1 sm=1 tr=0 ts=6705a0e2 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=CPLJqwJQaBXDVV5DLLAA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: Hhi0gCJKzive8kV8dtXd5FDObMYIAiAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=815 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080137

T24gVHVlLCBTZXAgMjQsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBEV0MzIHByb2dyYW1t
aW5nIGd1aWRlIG1lbnRpb25zIHRoYXQgd2hlbiBvcGVyYXRpbmcgaW4gVVNCMi4wIHNwZWVkcywN
Cj4gaWYgR1VTQjJQSFlDRkdbNl0gb3IgR1VTQjJQSFlDRkdbOF0gaXMgc2V0LCBpdCBtdXN0IGJl
IGNsZWFyZWQgcHJpb3INCj4gdG8gaXNzdWluZyBjb21tYW5kcyBhbmQgbWF5IGJlIHNldCBhZ2Fp
biAgYWZ0ZXIgdGhlIGNvbW1hbmQgY29tcGxldGVzLg0KPiBCdXQgY3VycmVudGx5IHdoaWxlIGlz
c3VpbmcgRW5kWGZlciBjb21tYW5kIHdpdGhvdXQgQ21kSU9DIHNldCwgd2UNCj4gd2FpdCBmb3Ig
MW1zIGFmdGVyIEdVU0IyUEhZQ0ZHIGlzIHJlc3RvcmVkLiBUaGlzIHJlc3VsdHMgaW4gY2FzZXMN
Cj4gd2hlcmUgRW5kWGZlciBjb21tYW5kIGRvZXNuJ3QgZ2V0IGNvbXBsZXRlZCBhbmQgY2F1c2Vz
IFNNTVUgZmF1bHRzDQo+IHNpbmNlIHJlcXVlc3RzIGFyZSB1bm1hcHBlZCBhZnRlcndhcmRzLiBI
ZW5jZSByZXN0b3JlIEdVU0IyUEhZQ0ZHDQo+IGFmdGVyIHdhaXRpbmcgZm9yIEVuZFhmZXIgY29t
bWFuZCBjb21wbGV0aW9uLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4
ZXM6IDFkMjZiYTA5NDRkMyAoInVzYjogZHdjMzogV2FpdCB1bmNvbmRpdGlvbmFsbHkgYWZ0ZXIg
aXNzdWluZyBFbmRYZmVyIGNvbW1hbmQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDEwICsrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMjkxYmM1NDk5MzViLi41
MDc3MmQ2MTE1ODIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtNDM4LDYgKzQzOCwxMCBAQCBp
bnQgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQg
aW50IGNtZCwNCj4gIAkJCWR3YzNfZ2FkZ2V0X2VwX2dldF90cmFuc2Zlcl9pbmRleChkZXApOw0K
PiAgCX0NCj4gIA0KPiArCWlmIChEV0MzX0RFUENNRF9DTUQoY21kKSA9PSBEV0MzX0RFUENNRF9F
TkRUUkFOU0ZFUiAmJg0KPiArCSAgICAhKGNtZCAmIERXQzNfREVQQ01EX0NNRElPQykpDQo+ICsJ
CW1kZWxheSgxKTsNCj4gKw0KPiAgCWlmIChzYXZlZF9jb25maWcpIHsNCj4gIAkJcmVnID0gZHdj
M19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkcoMCkpOw0KPiAgCQlyZWcgfD0gc2F2
ZWRfY29uZmlnOw0KPiBAQCAtMTcxNSwxMiArMTcxOSwxMCBAQCBzdGF0aWMgaW50IF9fZHdjM19z
dG9wX2FjdGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29s
IGludA0KPiAgCVdBUk5fT05fT05DRShyZXQpOw0KPiAgCWRlcC0+cmVzb3VyY2VfaW5kZXggPSAw
Ow0KPiAgDQo+IC0JaWYgKCFpbnRlcnJ1cHQpIHsNCj4gLQkJbWRlbGF5KDEpOw0KPiArCWlmICgh
aW50ZXJydXB0KQ0KPiAgCQlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7
DQo+IC0JfSBlbHNlIGlmICghcmV0KSB7DQo+ICsJZWxzZSBpZiAoIXJldCkNCj4gIAkJZGVwLT5m
bGFncyB8PSBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HOw0KPiAtCX0NCj4gIA0KPiAgCWRl
cC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RPUDsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAtLSAN
Cj4gMi4yNS4xDQo+IA0KDQpMb29rcyBnb29kIHRvIG1lIQ0KDQpBY2tlZC1ieTogVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MgZm9yIHRoZSBmaXgsDQpU
aGluaA==


Return-Path: <stable+bounces-200834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC339CB7990
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 02:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 654C43005790
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9955296BBE;
	Fri, 12 Dec 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gJaTOljb";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hxMYnee6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kDGB2rYc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89828980E;
	Fri, 12 Dec 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765504758; cv=fail; b=ARdrzCxRdeXFRV+lTfycjW9D8d2pXahHiJp7naiofQBKoKEFF4LTLxJh4IDQqHS0XIWh7/qG1+g5cO53HactDYlCkd0FVJEoPceykzwuNCKW5+RRtCapJr8lljLHMcOwp5NuhgJ92F38ENxnQbegNayW0wHYdeQTU8xEaaZR9b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765504758; c=relaxed/simple;
	bh=1qdjbiom+Kbk4YpTqFxH0fu2Gnh0DTFFeCnu30BWpsQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eqSB7bIH7loEanhYEQJqpUDagtmXgVeVs3Wp6IpCY9CfjKPCjHtgQKNqbZ2vbpMei23DnaVi5S+G3uorkLxHLUP9tW3TgNlGxjLzUdGa2eriAvUTx9Ur6ZK1eIYDcT/gzT+lJUgibn4MSrLG/dL1aHYPbMCvcfUeyZpOqJr4L0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gJaTOljb; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hxMYnee6; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kDGB2rYc reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBMLETh697644;
	Thu, 11 Dec 2025 17:21:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=1qdjbiom+Kbk4YpTqFxH0fu2Gnh0DTFFeCnu30BWpsQ=; b=
	gJaTOljbyGdCChvcOxxDiGSWDM7oJo79hi00IIi8SE56uOIM6uKzFibsJqx228Bz
	WvzmtYJDwf4phlfxEGeENnC9eCLnzZ8VMpZ574V7E/TCTLJTC/s/UD++pREE2tL0
	83ca35taEnQZ20e940kxc70sb95hdttSQWYZig1rYyddKWd+tq5UMybKkh9brLRz
	ELKColh2F5kp+c4Dj45FL2Z5GhTykWganKxcAwn0ik0aWLtd9iVZ4o/Dp980VvB1
	MQIHukf//oQhV1Mgn5NtzrHXG057y1TYBD/s9EDBsuR8MdmkUO8pGac/YqCWjynD
	ZL+8XMz/fyHSFtZXXD749w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4ayv4ybh00-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1765502476; bh=1qdjbiom+Kbk4YpTqFxH0fu2Gnh0DTFFeCnu30BWpsQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hxMYnee64V2WXZDHSzcB5cuiGSjJR6iO2CppKT6KldMH9iVTyCUTLVvIzf81yy9BL
	 TVg7/MNmsLxNbOJBzhqBOhSnIOQaSIVByec183Rr9jSeb+H/OLW7U6a19uuzwETZmY
	 PulUhpvUc64jS9aS+zgSx9KG5bzaU97TGvNesxxwrMORjAeNyL7limCkCNw/nosmD2
	 KZuDA6KpELb7UA99kkmWpe3hfYcddcxb82ns8uFaI/7fwu49xEclJDZ5POT9hZzaFU
	 Vx2LEziPIZ+jPFYjQaeok3rJyO4j6G6H6fTzFtwEsigCe7cypz4+mVUJ7rQfP2SOEJ
	 CLt5rmPnYu+jg==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4013440352;
	Fri, 12 Dec 2025 01:21:16 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DB813A0106;
	Fri, 12 Dec 2025 01:21:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=kDGB2rYc;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00106.outbound.protection.outlook.com [40.93.6.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4933440148;
	Fri, 12 Dec 2025 01:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb3BmvgKbAQOTU0eKyg/ZCAgSWDzxRd93/0UTl0uaA/WmduEQ/ASxjSY47x/xKiDsEGxvSO9Hdo9Ja2EyhChdNJ7QpnK7UKEbBR6ScKaWz1CaSdFuCdKzMdTIzgKvpW5IdgbsfCZKCRn4Vp/cXCLAjmc/Mn2gzWFXrat250BjmgZUu/JV4eJnQva28TuNTFQavaV0eXyQ7YSCRuQxn8YVUjh31CpSfBp8s7hBU3kWVimiW44aEJ2B3IxjPc3tHNcrvc8/XcIhPapsaFpsmcLdkJh2lOfljpHZNXmaH21id8ssmZBx11sfx7XQcN3ROQe0uf4MLsldrn7BSmUXEAOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qdjbiom+Kbk4YpTqFxH0fu2Gnh0DTFFeCnu30BWpsQ=;
 b=J3yXaaCPdQbLKtCEI2J72WKdjIrWib7NSGMkKTUy3QJvY1LDX4PUJJaDReeSSerVtxilgysxDU8Q5AFikBa4OELp9r83jfr0ojyGzPyB2gpn1Xw9+W0QmvdkSAUXcJp6Ij50B3p1FeNDgGd8qjFeJCGit8OMkzMNAxtpGgyKCKm21BGrsfFhzIEifCd+Mj9sEyaJiY/4BjaT7k0881GppPt/W1jlDiexXtVz0uO40NxnRkwrBxPKLm7C/WxYnI010j0TcS2tKC+I0Trd2FI9pJjKpzt1O+i73yw6/yfjTkJKLRqZugNl4QKJTzrlxbKId+1d+oPxkySvZKygZohqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qdjbiom+Kbk4YpTqFxH0fu2Gnh0DTFFeCnu30BWpsQ=;
 b=kDGB2rYcr8zaUeRTOy/zho3tfxb+0oImzn4pKPg/peFpPihHlDr1aibCG8HBtvYeg7gjXsuphjzVns32PzA/8BhDjSYcOqBFSWfw7Sufzv/YavhY/iL8mCjlYyF+rsVdH07xU1uzBZNkavaYh8aQY8P3IM+WPCiN7scw6lgZG0k=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.10; Fri, 12 Dec 2025 01:21:12 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 01:21:11 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgAgAAM6ACAEwJnAIABVnmAgAC/OICAAL5tgIAAC3WAgAoKnoCAAPZ4AA==
Date: Fri, 12 Dec 2025 01:21:11 +0000
Message-ID: <20251212012108.wjn2pavyg6qaiytt@synopsys.com>
References: <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
 <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
 <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
 <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
 <CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
 <20251204015125.qgio53oimdes5kjr@synopsys.com>
 <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
 <20251205003723.rum7bexy2tazcdwb@synopsys.com>
 <20251205011823.6ujxcjimlyetpjvj@synopsys.com>
 <28035b59-3138-40e6-beb3-1a3793e8df84@samsung.com>
In-Reply-To: <28035b59-3138-40e6-beb3-1a3793e8df84@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|DS0PR12MB6416:EE_
x-ms-office365-filtering-correlation-id: 39fdaa93-7184-4cc0-3159-08de391cbc71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2VhZXBjeEtOcHcyb2RHbE1qWDVyWnJROU4zSEwyMUJyb1R4QkgvYjFDUkNU?=
 =?utf-8?B?SUxJdXpuNlRvRlQ5S0U3OXNiU25TQVc0TzYyd3dBbjlodmRwWUJ6NG1MSnRr?=
 =?utf-8?B?andjanlaTnI0VE5yVUJGd28xL2IwQ3BrZnBDOFgrMEFLMzFjUEJRSVFtRmVr?=
 =?utf-8?B?SHpuY0xaK0hMT2NlMkZZS3BqQnpIWDdtMGU4b3dZZzh5Sk5VR3JoOVJnbEdB?=
 =?utf-8?B?TkdqZ2s4MHRpbXJZZjFsb3BtV2l4eENqVWZYNjVLcVRGM0JIeDR2S3JrcVow?=
 =?utf-8?B?ZVVDL1JMNHNlL25Kd3dEeVUxVXpjUGVUVVZBT3M3L3VKOVJHVE5KTG8xelBh?=
 =?utf-8?B?eDlxZFQvTVNBSjZud1ozdWQzUHM4R3Q0VGRUbE15cGo1QmMzQzUxQjdNQSsz?=
 =?utf-8?B?dW1Nbk9oQVJuY01WNzZRdm1PYmlySFlBem1icHpjTlBESWQ1YS9mQkJFMGVy?=
 =?utf-8?B?VmlYYmpuV2hQK09kWHR4bFMxWDFtcFdJdUU1ZHRmY0lmV255UU42VmVyRS9t?=
 =?utf-8?B?ZjJndjY1VWZHdXE5S1B1OGFwUm9ncUhwSHFuY3hkME5uT2oyZHhBRWtEWmk0?=
 =?utf-8?B?dnEzbTVETFpLVlF3NjVybjd3NmlxcDZZMitvQjk2anRNUytQYzNsN3JIMnMx?=
 =?utf-8?B?aWdTN1lNc2VnVm8zNzlTRHlueE9OU0JEaE5CdkpKaGxtbGRtMmc3Y0JpYlVx?=
 =?utf-8?B?YkZVY3Q4ek9aOVNJOUhrSnpmeldOTDI1WStjcWFUOWZZR1g2ZVpsMUhBcFVo?=
 =?utf-8?B?NTk4cTA0MGtFVGJqVm9weUkwaWF3bkhpcWl3b0RteEpUNXh4VVlaZjBVMUhY?=
 =?utf-8?B?VGRHVXJEelViaStiWTNVOWZOeWdENFUxRm5hL0dsNXRTOFdnbVBIbUNVazd0?=
 =?utf-8?B?NDVQSWtkRkhjQ2d0TnJLaDVwakt5UEo5eDcwenJOL29IQTVyNlB2S2lvTEI3?=
 =?utf-8?B?S1NWY1pCQ1AvckFzUnRnREdDRnFqNCtKcXFaSVFDeVkxTmt5aU41bTB1NjRl?=
 =?utf-8?B?NHRGdlVBMjRuc0k0OGJzR29XZXRYLzkyME1jRU9GQmhxRkpqc3ZtZkZIWmZG?=
 =?utf-8?B?YjJnUkFSditTR2RFOFVBT3I5YzFJdFFYTzhpZGJhNFNNdnc2QmN1cnVCZlZj?=
 =?utf-8?B?bElnMUJoOE1ob1E3c2FKbkJoR2g2VUg3Qjg1VEFYbXNGM01pSlFyUDdWMmZi?=
 =?utf-8?B?YS8rcGI0UlhDVzJaUGx0NmlFbEJCdUx5a1g0UTFPb2p0NHduRnhIUTdIQUV2?=
 =?utf-8?B?eHRESTExOEltdEl4MGQ2NFZEZ01XcWthQlJ2bVJMRU83ZVFXaXcwNWxzOFpJ?=
 =?utf-8?B?aUhmRS9nemk5Rk5VektTdUZFbkNzcXYvRitGZHpNS0hVcTZocGdWdG5xMHpr?=
 =?utf-8?B?T2Y3aFNwZG1PclkwWjRnRzdzV3BxN2VyVDIzdXBjQlJXbW11a0x4N3Flakxx?=
 =?utf-8?B?RnhMblpKaTdsMms2YkdKNlU3aXM4NHg3Tm5vejg4cytyU3dFejNpQ25Vc0F1?=
 =?utf-8?B?M1IvY2drdFRwSUxBUE1TT3grbjB0dlViclA2elVEYWVsSWkrM0FOaC9HYjV4?=
 =?utf-8?B?eGtVdUxNS0JJQzBXM3ZFaEV3ZEg0TlgyME1KSzRwUGFPMDRrZDhFRDYycFV4?=
 =?utf-8?B?d2F6alRmdUYrSy80c3RtQ1A5T3N4K21HOVRQSDBlcGpnanpxcTV6bGFtTjFY?=
 =?utf-8?B?eXBnNGdaU3cvbW84U01zWTJ4RGtqa250VzhPSDJlQnBDS2xkbHR5cmI2UHpy?=
 =?utf-8?B?SXYrZ0Uyb1kvaEovNlg1Ryt1VVd3MklXWVBiTTNHSHY1WFpqYVZIME5Nck43?=
 =?utf-8?B?R1drNVNRSTRWSUQzN2w5NmU1ZmhldStVUy9lazBOQ20rcGtiQitOZk1Xd25L?=
 =?utf-8?B?ZzkyZXBwaGV1eHJKdUNvS3hFRExTUm5FTVd3eC9vZXA5ZENjWFFSeU5lMTE3?=
 =?utf-8?B?enZSUXB0WXczaXA2VjVERXNUSURyVm1HbHpxK0I4VjB0WTFFTGZOT09hQ1Vh?=
 =?utf-8?B?L05mVmgvT1pxeXdoUHEzeWVMZ21WSytlQ0FoRk5MbWROOEh1L2VKQ2JkL0Jv?=
 =?utf-8?Q?ohcSW3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjNEL2hVdk1rM2NOMjRwcDFMYzdzRDMvM2ZKdjR2a2Nub0t1T1V1VG5PNVZz?=
 =?utf-8?B?MnhGS2d2cnN1RzdxSVoxSFRTV2dnYkU1RW51V1drQ0ZPUFF1dURNbmZJWi9L?=
 =?utf-8?B?QjhtTlJ3VkJVQ3UyQ1NnSXp4N0MxbWtac0l3VFBrc21CbmtWZUU5dG5vbjV4?=
 =?utf-8?B?eG9ndjZ0SEVvRkM0RHkySllibEhGYmE5QlE4OU1UTjFjWE9hYnM0dHdLd0Fh?=
 =?utf-8?B?dXpvbmI3T09KMVBpanJmRWFXRHZWZkRNNlV1aGw3T29kZ0l4YnE4MC9CUUk5?=
 =?utf-8?B?SGtOOVlmNTdVQWpQeEVvWWFGdmZnUnZkYnRURzhNb2RpellzTjNvWVN5YTJq?=
 =?utf-8?B?YzJOamlZSnRySEk2UlluQ1BqSW1PT1Z0cVNXR1pFRkhteUo4cG1NNnE3LzE3?=
 =?utf-8?B?R3RrYm02MC82R0lhL1huRjRlSWZhRjRiRjhKOGNKUEp3TWxWakljd1ljdVl0?=
 =?utf-8?B?VzBVMTRqL1FoSzBiQTJhUE1PVkJzQXpDKzlzTm1QUlcrWkUxZStpK3dZWm03?=
 =?utf-8?B?SHk4SHRSbU1aSG4rbU4xN3JESlA3U2EwTi9SOWoyMGh4UDhxelNvWkZja3VP?=
 =?utf-8?B?SytEMmpHWWNObWZ0cjBlcjdjS0R2dHdWdllmKzU4VDVVZEo3QkNRK2J1Z2x3?=
 =?utf-8?B?SGJOQk80L2VDYkw4MDN3VGVVVzlSUUFDNHdTQWY2elhvazEvQ202cjVVazhO?=
 =?utf-8?B?bzRQMDl0UFpEa3VKYVUyM0YyVSszSEx4amlLMnNBdHNKbzJ2bmhnWVhHZmds?=
 =?utf-8?B?cERuYk1LeVM1NTZranY4SDJWd01nWWpXalFzeTNLaVhDMm9RcHVFa1dtOE1R?=
 =?utf-8?B?SVRwZ21WSnMzbjJZdm1lbGtzL3U1MjgvNjdLK2UvUURpTGZWc0JpVE9sQzBt?=
 =?utf-8?B?RjAxWHpFMW1sUkwzYjhFTTNlYXVnMjlFQitvc01VWURzWlJrOWJQZGI3REtK?=
 =?utf-8?B?OHBBajdoUm1adU5QUmNDWmxVUUlESkV6Y3Q3cFViY0dReENzbTVpZG84bE5P?=
 =?utf-8?B?NllWRGsyU1ZvNDRRYzI1cWJVT0lyN3pSb3FSLzJ2YlA1dmFFWThUZEJxOE9U?=
 =?utf-8?B?RklBbEt2RldVU1JEQVFOYU9BZTF1YlFEdDl0dWE3THZ2STFyUS9pQ3ZuZ0dJ?=
 =?utf-8?B?WHVxc1cxV2FVV1FEbEdPUkNjQkdzendhcGN6TFBIbWhGOXdZT2VoQTl0V1hm?=
 =?utf-8?B?TndHbTduakJ2eWwvYVZaQlNwWldPcGQ0UTlkclRmaUFpZWhFSXNHd3N6NGJG?=
 =?utf-8?B?Skk3NUJxK0E5QnlRQWF5UjR2S295SnhlVkw2ZGJrRVFYZHpOZlJKb3RDakdO?=
 =?utf-8?B?WlZXME9SR3J0a200ZXMreUl0V1ZOMEpzSVY2WkRBZmZUQkFvVVhDVXdzQ3JW?=
 =?utf-8?B?NmtwWlppNHE3NnJQeEZXeE5hRnd3NU9XWkVvSlIyNndBM1Z3THFSMU1LZUJ4?=
 =?utf-8?B?QS83YWtXZGRObVYyTklSOWN0MWtnbjhKbVd3Y01yL3dDdGgwdGZBUTBIZWVs?=
 =?utf-8?B?VXFaeGZRaWxDaGc2MEF2WDEzNm02bkd6b2NlZmhTMjlheVpPOFlhMUZhN1A2?=
 =?utf-8?B?OGsvRWJsdzZwTUhQNUVKaURHNGVkSlB3ZW5KcWVndndlaVRCSTg1SmJIOUFz?=
 =?utf-8?B?ejhtR2Y1NE1ybDQrcDNmaHpjV1RLSjlkN0VZZUx3ZFFUZkFRN0pBcW9qSEs5?=
 =?utf-8?B?ZXJKeG5LSW5MbTZaejVzTG5ETkVyK2hGcWd4WW5MaUZFNkxhVk1FUkkrY2sy?=
 =?utf-8?B?ZE05Nk5MS1ZOa1ZXMktMYUx3ZEcrTTdtWXlCV0VZaXZ0Q3E0cGRxWW0venlW?=
 =?utf-8?B?NXJYNjd3SUNlTlZ5YldpdkZJSFRHR2owUktpNTZnOGlsb1NlNUZvSktkVDJJ?=
 =?utf-8?B?YUNHUTZvOHBDN3FGSHd2NHFsK1VCZTkvTDhuZWlBTTRrZ2IwM1UxZkI1ektp?=
 =?utf-8?B?Tkh4NmdwelI1em5tY0dOVnIyNGZtcGlPMWFFNi9mTm92Q1dNWm54emVFZXhW?=
 =?utf-8?B?SDZpL2pOMmxnTEdMRDM3RWQ0TGtLajJCclZlZy8wbHViVldQcDFCdnVienNk?=
 =?utf-8?B?V292b3VZZUV4VU9KeExZUndWT1RvT01rM2MwbVhMM21qcGRDQ3E2Ry9HS0ZG?=
 =?utf-8?Q?zvFD/hYv57rBpQijqmKp3J3Yf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBBA41172E776744BE075E1ED2005E35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7m+DPsvPZ0zhrdeXpVpGlirXgpX9/NpMGO+x22RE0qm+hP5EEl6KNyP8fnX2DnzOb6XE404JA9ClzlxGcwUJgK2a845eHT3KrbCIo1Qc8XsCKThE2XhC07+K8nytdHg+uPtac4eY1d1demchY4JPbhO/J373ofZgKbr7sCEa/FmSXVzsak0mAqPCNeRf5S44+qm0Mjy/ZY6H2ZX9HsevB37XnKV4ewqemGNkUcGGfNff2LEyKajgL/j/TMJqN6FnelvH2HEgh0HGM9BboupnR2a4qI8jR4CNFC4kaFWmCM+lXGg4RfFsRAW7oBH+xjGR+l/om1t7AbMM5HVj6VIrZYwwyUKU4NJivJdgfeAFrujR7dLrVMqkq5SySzC3fDnc3aRkzf9asSetERRQ7yR2KSmzJYhnW2zNai7Klb58xNzyZfxtmaqNV4H+99fABw+iqJ4wGE2xZx3TBaq16n8WNt8JAdyD1aCvkfMbnBkcJIHEFssk3qNgUQNSW3NiWNaYbPedqAnAJVbb/s25srvtKRY6pmB+YRqSkAUFZRQ1WwCqN80bDsvsRZYUB2+Gq8KfmMQGxiLR9teZ1C5YMjL8SojpNUGN5bB5vT7mc19WmV4egQWvcrTfoQDb+52f83bUzX5EjE2/IrEnfNn8Otrjvg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fdaa93-7184-4cc0-3159-08de391cbc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 01:21:11.5941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKIEP6df912W9ta9stCPdleK62wQXNtCjHwyFT3Um/AlkNKS+fI6Jv79qPfyu21evVmx08uaMOvVpA9IGJvKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDAwOSBTYWx0ZWRfX166nzaJXpL2A
 rr3ZIiebt6lf4KKJ4I3wssP/8may4/NpFX22YhlCKGNVXTUFHWPdd657xpHGm72vgej5ISCeNhz
 6M3By0atWl870hWfWqUOHyxtwh9Slmzf+dCCXhFVR+15RVxmA1KI0x5sefF9DSsyS+F9/kc3Uoa
 6rb64bi0BHPBDlldLeaXGJqILxpuE6g8q7S4JCNUYhpTjzSmO6CaQ4d7ZgKuIev1ZE697p0wha4
 XW+IZQ89aj/yAaRO8VkqIbf+nJkbUK7P27WavYuDj28XFtFENQqXswFC6RRfKqgg8jqDPJjwK6S
 WRiISNKB4N/2dcstOQ8b573jXbfORkv7UVisqodNDszF5pGk0IYhDfLnE0tR+s8kVz/lga/vONT
 o6iIOv4WNjOnFDYqiT6K4BGsJ0468g==
X-Proofpoint-GUID: 3SGTB8N6pLGW4Ncbm9KHKKn1aFAOGi-n
X-Authority-Analysis: v=2.4 cv=QOJlhwLL c=1 sm=1 tr=0 ts=693b6e0d cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hD80L64hAAAA:8 a=Kq6zDyiPd5Qu2LIfVvsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3SGTB8N6pLGW4Ncbm9KHKKn1aFAOGi-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512120009

T24gVGh1LCBEZWMgMTEsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
MTIvNS8yMDI1IDY6NDggQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4gSSB3YXMgaG9waW5n
IHRoYXQgdGhlIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgd29uJ3QgY29tZSBlYXJseSB0byBydW4N
Cj4gPj4gaW50byB0aGlzIHNjZW5hcmlvLiBXaGF0IEkndmUgcHJvdmlkZWQgd2lsbCBvbmx5IG1p
dGlnYXRlIGFuZCB3aWxsIG5vdA0KPiA+PiByZXNvbHZlIGZvciBhbGwgY2FzZXMuIEl0IHNlZW1z
IGFkZGluZyBtb3JlIGNoZWNrcyBpbiBkd2MzIHdpbGwgYmUNCj4gPj4gbW9yZSBtZXNzeS4NCj4g
DQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBpbnNpZ2h0ZnVs
IGNvbW1lbnRzLiBJIGFncmVlIHRoYXQgYWRkaW5nIG1vcmUgY2hlY2tzIA0KPiBkaXJlY3RseSBp
biB0aGUgZHdjMyBkcml2ZXIgd291bGQgYmUgbWVzc3ksIGFuZCBhIGNvbXByZWhlbnNpdmUgcmV3
b3JrIA0KPiBvZiB0aGUgZHdjMyBlcCBkaXNhYmxlIHdvdWxkIHVsdGltYXRlbHkgYmUgdGhlIGNs
ZWFuZXIgc29sdXRpb24uDQo+IA0KPiBJbiB0aGUgbWVhbnRpbWUsIEludHJvZHVjaW5nIGFkZGl0
aW9uYWwgY2hlY2tzIGZvciANCj4gRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGlu4oCvZHdjMyBk
cml2ZXIgaXMgdGhlIG1vc3QgcHJhY3RpY2FsIHdheSB0byANCj4gdW5ibG9jayB0aGUgY3VycmVu
dCBpc3N1ZSB3aGlsZSB3ZSB3b3JrIHRvd2FyZCB0aGF0IGxvbmdlcuKAkXRlcm0gZml4Lg0KPiBX
ZSBoYXZlIGFwcGxpZWQgdGhlIHBhdGNoZXMgYW5kIHBlcmZvcm1lZCBhZGRpdGlvbmFsIHRlc3Rp
bmcsIG5vIA0KPiByZWdyZXNzaW9ucyBvciBuZXcgaXNzdWVzIHdlcmUgb2JzZXJ2ZWQuDQo+IA0K
PiBDb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gd2hldGhlciBiZWxvdyBpbnRlcmltIGZpeCBpcyBh
Y2NlcHRhYmxlIGFsb25nIA0KPiB3aXRoIHlvdXIgcHJvcG9zZWQgZWFybGllciBwYXRjaCBmb3Ig
dW5ibG9ja2luZyB0aGUgY3VycmVudCBkZXZlbG9wbWVudCANCj4gZmxvdz8NCj4gDQo+IA0KPiBQ
YXRjaCAyOiB1c2I6IGR3YzM6IHByb3RlY3QgZGVwLT5mbGFncyBmcm9tIGNvbmN1cnJlbnQgbW9k
aWZ5IGluIA0KPiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlDQo+ID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KPiANCj4gU3ViamVjdDogW1BBVENIXSB1c2I6IGR3YzM6IHByb3RlY3QgZGVw
LT5mbGFncyBmcm9tIGNvbmN1cnJlbnQgbW9kaWZ5IGluIA0KPiBkd2MzX2dhZGdldF9lcF9kaXNh
YmxlDQo+IFRoZSBiZWxvdyB3YXJuaW5ncyBpbiBgZHdjM19nYWRnZXRfZXBfcXVldWVgIG9ic2Vy
dmVkIGR1cmluZyB0aGUgUk5ESVMNCj4gZW5hYmxlL2Rpc2FibGUgdGVzdCBpcyBjYXVzZWQgYnkg
YSByYWNlIGJldHdlZW4gYGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGVgDQo+IGFuZCBgZHdjM19nYWRn
ZXRfZXBfcXVldWVgLiBCb3RoIGZ1bmN0aW9ucyBtYW5pcHVsYXRlIGBkZXAtPmZsYWdzYCwgYW5k
DQo+IHRoZSBsb2NrIHJlbGVhc2VkIHRlbXBvcmFyaWx5IGJ5IGBkd2MzX2dhZGdldF9naXZlYmFj
a2AgKGNhbGxlZCBmcm9tDQo+IGBkd2MzX2dhZGdldF9lcF9kaXNhYmxlYCkgY2FuIGJlIGFjcXVp
cmVkIGJ5IGBkd2MzX2dhZGdldF9lcF9xdWV1ZWANCj4gYmVmb3JlIGBkd2MzX2dhZGdldF9lcF9k
aXNhYmxlYCBoYXMgZmluaXNoZWQuIFRoaXMgbGVhZHMgdG8gYW4NCj4gaW5jb25zaXN0ZW50IHN0
YXRlIG9mIHRoZSBgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEYCBkZXAtPmZsYWcuDQo+IA0KPiBU
byBmaXggdGhpcyBpc3N1ZSBieSBhZGQgYSBjb25kaXRpb24gY2hlY2sgd2hlbiBtYXNraW5nIGBk
ZXAtPmZsYWdzYA0KPiBpbiBgZHdjM19nYWRnZXRfZXBfZGlzYWJsZWAgdG8gZW5zdXJlIHRoZSBg
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEYA0KPiBmbGFnIGlzIG5vdCBjbGVhcmVkIHdoZW4gaXQg
aXMgYWN0dWFsbHkgc2V0LiBUaGlzIHByZXZlbnRzIHRoZSBzcHVyaW91cw0KPiB3YXJuaW5nIGFu
ZCBlbGltaW5hdGVzIHRoZSByYWNlLg0KPiANCj4gVGhyZWFkIzE6DQo+IGR3YzNfZ2FkZ2V0X2Vw
X2Rpc2FibGUNCj4gIMKgIC0+X19kd2MzX2dhZGdldF9lcF9kaXNhYmxlDQo+ICDCoCDCoC0+ZHdj
M19yZW1vdmVfcmVxdWVzdHMNCj4gIMKgIMKgIC0+ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcg0K
PiAgwqAgwqAgwqAtPl9fZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcg0KPiAgwqAgwqAgwqAgLT4g
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQgKGNtZCA9RFdDM19ERVBDTURfRU5EVFJBTlNGRVIpDQo+
ICDCoCDCoCDCoCDCoC0+aWYoIWludGVycnVwdClkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5T
RkVSX1NUQVJURUQ7DQo+ICDCoCDCoCDCoCDCoCAtPmR3YzNfZ2FkZ2V0X2dpdmViYWNrDQo+ICDC
oCDCoCDCoCDCoCDCoC0+c3Bpbl91bmxvY2soJmR3Yy0+bG9jaykNCj4gIMKgIMKgIMKgIMKgIMKg
IMKgLi4uDQo+ICDCoCDCoCDCoCDCoCDCoCDCoFdoaWxlIFRocmVhZCMxIGlzIHN0aWxsIHJ1bm5p
bmcsIFRocmVhZCMyIHN0YXJ0czoNCj4gDQo+IFRocmVhZCMyOg0KPiB1c2JfZXBfcXVldWUNCj4g
IMKgIC0+ZHdjM19nYWRnZXRfZXBfcXVldWUNCj4gIMKgIMKgLT5fX2R3YzNfZ2FkZ2V0X2tpY2tf
dHJhbnNmZXINCj4gIMKgIMKgIC0+IHN0YXJ0aW5nID0gIShkZXAtPmZsYWdzICYgRFdDM19FUF9U
UkFOU0ZFUl9TVEFSVEVEKTsNCj4gIMKgIMKgIMKgLT5pZihzdGFydGluZykNCj4gIMKgIMKgIMKg
IMKgLT5kd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCAoY21kID0gRFdDM19ERVBDTURfU1RBUlRUUkFO
U0ZFUikNCj4gIMKgIMKgIMKgIMKgIC0+ZGVwLT5mbGFncyB8PSBEV0MzX0VQX1RSQU5TRkVSX1NU
QVJURUQ7DQo+ICDCoCDCoCDCoCDCoCDCoCAuLi4NCj4gIMKgIMKgIMKgIMKgIMKgIMKgLT5fX2R3
YzNfZ2FkZ2V0X2VwX2Rpc2FibGUNCj4gIMKgIMKgIMKgIMKgIMKgIMKgIC0+bWFzayA9IERXQzNf
RVBfVFhGSUZPX1JFU0laRUQgfERXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEOw0KPiAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAtPmRlcC0+ZmxhZ3MgJj0gbWFzazsgLS0+IC8vIFBvc3NpYmxlIG9mIGNs
ZWFycw0KPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEV0MzX0VQX1RSQU5TRkVSX1NUQVJU
RUQgZmxhZyBhcyB3ZWxsIHdpdGhvdXQNCj4gIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vu
ZGluZyBEV0MzX0RFUENNRF9FTkRUUkFOU0ZFUg0KPiANCj4gIMKgLS0tLS0tLS0tLS0tWyBjdXQg
aGVyZSBdLS0tLS0tLS0tLS0tDQo+ICDCoCBkd2MzIDEzMjAwMDAwLmR3YzM6IE5vIHJlc291cmNl
IGZvciBlcDFpbg0KPiAgwqAgV0FSTklORzogQ1BVOiA3IFBJRDogMTc0OCBhdCBkcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jOjM5OA0KPiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2
Yw0KPiAgwqAgcGMgOiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2Yw0KPiAgwqAg
bHIgOiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2Yw0KPiAgwqAgQ2FsbCB0cmFj
ZToNCj4gIMKgIMKgIGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKzB4MmY4LzB4NzZjDQo+ICDCoCDC
oCBfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIrMHgyZWMvMHgzZjQNCj4gIMKgIMKgIGR3YzNf
Z2FkZ2V0X2VwX3F1ZXVlKzB4MTQwLzB4MWYwDQo+ICDCoCDCoCB1c2JfZXBfcXVldWUrMHg2MC8w
eGVjDQo+ICDCoCDCoCBtcF90eF90YXNrKzB4MTAwLzB4MTM0DQo+ICDCoCDCoCBtcF90eF90aW1l
b3V0KzB4ZDAvMHgxZTANCj4gIMKgIMKgIF9faHJ0aW1lcl9ydW5fcXVldWVzKzB4MTMwLzB4MzE4
DQo+ICDCoCDCoCBocnRpbWVyX2ludGVycnVwdCsweGU4LzB4MzQwDQo+ICDCoCDCoCBleHlub3Nf
bWN0X2NvbXBfaXNyKzB4NTgvMHg4MA0KPiAgwqAgwqAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNw
dSsweGNjLzB4MjVjDQo+ICDCoCDCoCBoYW5kbGVfaXJxX2V2ZW50KzB4NDAvMHg5Yw0KPiAgwqAg
wqAgaGFuZGxlX2Zhc3Rlb2lfaXJxKzB4MTU0LzB4MmM4DQo+ICDCoCDCoCBnZW5lcmljX2hhbmRs
ZV9kb21haW5faXJxKzB4NTgvMHg4MA0KPiAgwqAgwqAgZ2ljX2hhbmRsZV9pcnErMHg0OC8weDEw
NA0KPiAgwqAgwqAgY2FsbF9vbl9pcnFfc3RhY2srMHgzYy8weDUwDQo+ICDCoCDCoCBkb19pbnRl
cnJ1cHRfaGFuZGxlcisweDRjLzB4ODQNCj4gIMKgIMKgIGVsMV9pbnRlcnJ1cHQrMHgzNC8weDU4
DQo+ICDCoCDCoCBlbDFoXzY0X2lycV9oYW5kbGVyKzB4MTgvMHgyNA0KPiAgwqAgwqAgZWwxaF82
NF9pcnErMHg2OC8weDZjDQo+IA0KPiBDaGFuZ2UtSWQ6IEliNmE3N2NlNTEzMGUyNWQwMTYyZjcy
ZDBlNTJjODQ1ZGJiMWQxOGY1DQo+IFNpZ25lZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5lc2FuIDxz
ZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICDCoGRyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYjQyZDIyNWI2NzQwOC4uMWRjNTc5
ODA3MjEyMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC0xMDUxLDYgKzEwNTEsMjIgQEAgc3Rh
dGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoc3RydWN0IA0KPiBkd2MzX2VwICpkZXAp
DQo+ICDCoCDCoCDCoCAqLw0KPiAgwqAgwqAgwqBpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfREVM
QVlfU1RPUCkNCj4gIMKgIMKgIMKgIMKgIMKgbWFzayB8PSAoRFdDM19FUF9ERUxBWV9TVE9QIHwg
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gKw0KPiArwqAgwqAgLyoNCj4gK8KgIMKgIMKg
KiBXaGVuIGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoKSBjYWxscyBkd2MzX2dhZGdldF9naXZlYmFj
aygpLA0KPiArwqAgwqAgwqAqIHRoZcKgIGR3Yy0+bG9jayBpcyB0ZW1wb3JhcmlseSByZWxlYXNl
ZC7CoCBJZiBkd2MzX2dhZGdldF9lcF9xdWV1ZSgpDQo+ICvCoCDCoCDCoCogcnVucyBpbiB0aGF0
IHdpbmRvdyBpdCBtYXkgc2V0IHRoZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQgZmxhZyBhcw0K
PiArwqAgwqAgwqAqIHBhcnQgb2YgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQuIFRoZSBvcmlnaW5h
bCBjb2RlIGNsZWFyZWQgdGhlIGZsYWcNCj4gK8KgIMKgIMKgKiB1bmNvbmRpdGlvbmFsbHksIHdo
aWNoIGNvdWxkIG92ZXJ3cml0ZSB0aGUgY29uY3VycmVudCBtb2RpZmljYXRpb24uDQo+ICvCoCDC
oCDCoCoNCj4gK8KgIMKgIMKgKiBUaGUgYWRkZWQgY2hlY2sgZW5zdXJlcyB0aGUgRFdDM19FUF9U
UkFOU0ZFUl9TVEFSVEVEIGZsYWcgaXMgb25seQ0KPiArwqAgwqAgwqAqIGNsZWFyZWQgaWYgaXQg
aXMgbm90IHNldCBhbHJlYWR5LCBwcmVzZXJ2aW5nIHRoZSBzdGF0ZSB1cGRhdGVkIA0KPiBieSB0
aGUNCj4gK8KgIMKgIMKgKiBjb25jdXJyZW50IGVwX3F1ZXVlIHBhdGggYW5kIGVsaW1pbmF0aW5n
IHRoZSBFUCByZXNvdXJjZSBjb25mbGljdA0KPiArwqAgwqAgwqAqIHdhcm5pbmcuDQo+ICvCoCDC
oCDCoCovDQoNCldlIG5lZWQgdG8gZXhwbGFpbiB0aGUgdW5kZXJsaW5pbmcgcHJvYmxlbSBoZXJl
IGFuZCBpbiB0aGUgY29tbWl0DQptZXNzYWdlLiBUaGUgZnVuY3Rpb24gdXNiX2VwX2Rpc2FibGUo
KSBpcyBleHBlY3RlZCBiZSB1c2VkIGludGVycnVwdA0KY29udGV4dCwgYW5kIGl0J3MgYmVpbmcg
dXNlZCBpbiBpbnRlcnJ1cHQgY29udGV4dCBpbiB0aGUgY29tcG9zaXRlDQpmcmFtZXdvcmsuIFRo
ZXJlJ3Mgbm8gd2FpdCBmb3IgZmx1c2hpbmcgb2YgZW5kcG9pbnQgaXMgaGFuZGxlZCBiZWZvcmUN
CnVzYl9lcF9kaXNhYmxlIGNvbXBsZXRlcy4NCg0KV2UgYXJlIGFkZGluZyBhIHRlbXBvcmFyeSB3
b3JrYXJvdW5kIHRvIGhhbmRsZSB0aGUgZW5kcG9pbnQNCnJlY29uZmlndXJhdGlvbiBhbmQgcmVz
dGFydCBiZWZvcmUgdGhlIGZsdXNoaW5nIGNvbXBsZXRlZC4NCg0KPiArwqAgwqAgaWYgKGRlcC0+
ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpDQo+ICvCoCDCoCDCoCDCoCBtYXNrIHw9
IERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRDsNCj4gKw0KPiAgwqAgwqAgwqBkZXAtPmZsYWdzICY9
IG1hc2s7DQo+IA0KPiAgwqAgwqAgwqAvKiBDbGVhciBvdXQgdGhlIGVwIGRlc2NyaXB0b3JzIGZv
ciBub24tZXAwICovDQo+IC0tIA0KPiANCj4gMi4zMS4xDQo+IA0KPiANCg0KRm9yIHlvdXIgY2Fz
ZSwgaXQgbWF5IHdvcmsgYmVjYXVzZSB0aGUgZW5kcG9pbnQgaXMgcHJvYmFibHkgcmVjb25maWd1
cmVkDQp0byBiZSB0aGUgc2FtZSBpbiB1c2JfZXBfZW5hYmxlKCkuIElmIHdlIHJlY29uZmlndXJl
IHRoZSBlbmRwb2ludCBiZWZvcmUNCnRoZSBlbmRwb2ludCBpcyBzdG9wcGVkLCB0aGUgYmVoYXZp
b3IgaXMgdW5kZXJmaW5lZC4NCg0KWW91IGNhbiBjcmVhdGUgdGhlIHBhdGNoZXMgYW5kIENjIHN0
YWJsZS4gSG93ZXZlciwgSSB3b3VsZCBub3QgYWRkIHRoZQ0KIkZpeGVzIiB0YWcgc2luY2UgdGhl
eSAoSU1ITykgYXJlIG5vdCByZWFsbHkgZml4ZXMuIE1heSBhbHNvIG5lZWQgdG8NCm5vdGUgdGhh
dCB1bmRlciB0aGUgIi0tLSIgaW4gdGhlIGNvbW1pdCBleHBsYWluIHdoeSB0aGVyZSdzIG5vIEZp
eGVzIHRhZw0KYWxzby4NCg0KVGhhbmtzLA0KVGhpbmg=


Return-Path: <stable+bounces-54789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF9911A8A
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AEE1C23A5A
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 05:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B09153BFA;
	Fri, 21 Jun 2024 05:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="pzbnHQPy";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QZneaHSN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nbecbatO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C3137775;
	Fri, 21 Jun 2024 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948582; cv=fail; b=aCfvHLRoHZr7V+SLhW3sDy4GWVjJjNJa2h2Z9QWEETBkqJZEaXFWLGTm0lJDkFgzuHU3A8kxl7oI4PDo8ym2+N/10YHgJqf7FptIAcpMxt4ZzKRihaDW2KUFUjCjjytZAUF4KvcJpakRliIl5OVuLsqG9quGCHKu2CL7bk09d/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948582; c=relaxed/simple;
	bh=Hu0I3WuSsh5fx+SSXqOFl45XZqpFjBJLwDUHBrufJdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ivQVB+QS607e523nW2wNluYgZF1dqr2/eAmqfiXC8gubLns5MNalaBGzA8w+/W15lyHgk2/mcOwgFltPDh6nbbRL3y6VFDC3qImhZSSSmQE+0NjSI4yduFGWsZpguw4AKyk7uURaS9q6plLu8OmwMrvbQk9QpOJglD9827UVXeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=pzbnHQPy; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QZneaHSN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nbecbatO reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNK5Hw001938;
	Thu, 20 Jun 2024 22:42:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Hu0I3WuSsh5fx+SSXqOFl45XZqpFjBJLwDUHBrufJdY=; b=
	pzbnHQPyFRGDZyk0pvvGAhBokUuJl5Smjy1kAmbqR30JrdVDMQzZu/YNmn/XRe47
	RvHUZtBW+WWaLWOmGiamJnWxP2+KVoWMWwxzrAFUDfJZMqj9t0kKo+5H40NDdBx6
	itMtLB6BwVRZah+MeWb2WZ9t0KeE+zjqtMI5uEYCSXQHZ6p7bFbUECbJaDlDhQIV
	LK/F5FuJn7XhfpR3QS+mPt5hmKDZffjBqIlKLXTPHkeP8Yy315z7Ktwy9DTldgyu
	3OWjvSfcClbrPDg/IdEAwa3wsOC4t+ARrTM0zP8NswslK3CN/7w+jqMUxyEGucNJ
	586mPQfddo0jeewG4N/4qQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yvrhyjhjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718948567; bh=Hu0I3WuSsh5fx+SSXqOFl45XZqpFjBJLwDUHBrufJdY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QZneaHSN+S2MDBdmck4RhYDl5spZPNIxICHdkHQEnipnBNySeYW6v32eJkGsJ1Ld3
	 i6GbD6ullN2ztqIfXvgHyLwWbhs/GSRpPmjsGGaQGqyhuDUczr2/fYVDVf81abUBXy
	 Iy6WxI3NaFbAPZIrLcLS9CnzjtEYzOXzj95QzL3or5JDFVHBBixGkU1oiiTwfnhIs2
	 1hO4CCCeuQ5NvyIV/yQQiYdsSqt0ay263VmuDtczcS0Q8ya47upWYB7ogDqH/+DB1r
	 19IS26xyc2g7jAL7xrz+V/oaQFN6gwJ8MF/YROAQDQeCutzmwJbQIIWlvwhuudPTI3
	 FcO8fOKJHUkow==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5FE38401C6;
	Fri, 21 Jun 2024 05:42:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E4C06A0077;
	Fri, 21 Jun 2024 05:42:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nbecbatO;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 432194052E;
	Fri, 21 Jun 2024 05:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvzejUX8v3GFdgMj8XDi03rgMkfZCqG7eL7fczp8JFd5f0YCmVyLmX2USiqMxr630G51DZlUOIS3rd1U6PQq4VDaa2E15/YiYgFEwgyH/1CLPBGGqmzwZ0dged2PRXdf6VD58U39C5q2oHau+9RuY9B1VJ3DF90gZO501NiZNAV2dHL7rC/yL6CAFoe3U4bnlM4HBEvv/oRDqACpDaKAkF5AhL+0cjpwlFPlqzNS7zgWwnJtqusmCekavV4qNEq4xBQ2c+Pq1QbbCrAwYWpXd53fw9bpKgzhHnxGNdVQ06zLURbNvSe7GgWAOwCGIL8OhkFRMQPO7/xn26wSwzvSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu0I3WuSsh5fx+SSXqOFl45XZqpFjBJLwDUHBrufJdY=;
 b=i6NCI0KwYvv00WMiAGYWnzqoKiUQsDMMx2JCyDcdxUVzp6Fgnkfm+fs+bSVvJBWra3jjtkN0f/ltMwi+uz0ISL1m238HPRA2Zv2itorEAYyj4b4Y6r6q0NwMJZ8jPeeWC8V2uqYIDGhzE7z+398fXnfVWKcx1codzqlhcsab9uGRV0dBLKZVCc+n2yNXY5vTVhgunaAC7lKq4L/8h9uL26Rc1zD+W8QhfRIN0pbB3steoBRFdQY7xW+vXYXsDTo88+n28u6SuprHPPnmkRE31CF2Zro5bDKBOlcHMbOk9NiIb8QRzZEHDpzUR14R7zewIU/Ceu1vsdHgS0eTlzgFGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu0I3WuSsh5fx+SSXqOFl45XZqpFjBJLwDUHBrufJdY=;
 b=nbecbatO/gLZvtKGoRdeDxlFRF2afD5kKlV9i6edFTABjSoiD+2N4f5vZf6boqDQKKFzv8Kvym/RITP3DBWqZcVFxdlnV3SypZU+FC2ZO1RbCGYod10pfTBde+24nJRLLQ7X9pEDLu3gsdi9DYTSuky9/GsujIKRhtQMuu6G0ns=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:42:42 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:42:42 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: joswang <joswang1221@gmail.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: AQHawj43Ri5O9FacdU6gpV1LQKb6abHQ5pwAgACMzwCAAD1DAIAABnyA
Date: Fri, 21 Jun 2024 05:42:42 +0000
Message-ID: <20240621054239.mskjqbuhovydvmu4@synopsys.com>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
In-Reply-To: <2024062151-professor-squeak-a4a7@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB9242:EE_
x-ms-office365-filtering-correlation-id: 980abeb5-f6c3-464e-7f92-08dc91b4f819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?K2pBb2ZjbVJqZktuSkk3YWZyNW43ZWZDVk9RWW5LUGZvZnpzMUV1c2poeW45?=
 =?utf-8?B?b1FmZE41YmxwdlFrMGhUNXd5WCthUGxUbFV5NFp2aGh3d3hQd251M0h5enFw?=
 =?utf-8?B?R3JSdXBIZHZNWWY3YmlmdjIxMDlDeFZMaC84NHkwM0xsRWxIL0lOVlRuV2xY?=
 =?utf-8?B?MGtxTWJ6ZlYyS1Z0T0R5LzBJUENQWGw0bjUxZlg3SUhYdHZVa2tuWHluZjRS?=
 =?utf-8?B?eDRvZjJRWmlVQ21LeFQvdlBsQzhORlJleGZzYm1lK2hFeW1wVURNM1p4c0RD?=
 =?utf-8?B?UkdlQjFncURWRS9RMlA3alowbSs3Zk1GVy9URWNFQjdsUDlxd0RBdE93U3U2?=
 =?utf-8?B?bnM5UUhvVlp2eExxNlJkaklqYm16YSthd1M2L1JwTmcxVnZTeWIrbmNSaEw5?=
 =?utf-8?B?M3RQbG1lSG5rUGp5U2hsZXdob28vYzVJMzBEMk82cGpRelJFaUMvT29hazV6?=
 =?utf-8?B?K2E2cnhZMlZ5ZmIraGwxWEFpbVBxenlDYVVYK2pjSERabkNrNGhLWUZLV0Y5?=
 =?utf-8?B?NXRPM3BhYllqWXkzSUZkUlkvYmN0clNGbUN5T1V0TERlVjdETzdxTFdOZm9M?=
 =?utf-8?B?L3FFSkI1cGNhZkJlc0NsT3JHRjJQRzd3WmNNMmZNWGsyMGl6dldhVmxCenR5?=
 =?utf-8?B?MHhnNmorUVN5b3Z5RVVWZzIxeUZFeVlTam9Rc1dncmpMdWw3KzlJRFhZNVEr?=
 =?utf-8?B?UGtUNGg3L2tacHdoaVhJTjkxclB4aU00SmpkbHJRUGdHMFZtMUJramJvVEdV?=
 =?utf-8?B?Rm0zK1pMMU5xR1hKZjZyZk9NQ3lsNzRhakNJNzYrRXMxekZkaWhva1MveXZD?=
 =?utf-8?B?eGR6QjRIa3BFYys5ZTg2NFZ6TkUrZHpQa1JmaUFocjVvb0F5WDNjdno1OHJt?=
 =?utf-8?B?OHN0c2htTUh2ZCtqQkg1YVh4QjlJaklURnJBVzdBZDVWZUVnSHFCRkpmOENK?=
 =?utf-8?B?YjBvd0paRC84c3U5NnU5SnEyUitXOHV1ZmRKTlU2a2RydXdCb0NCdkxZYnpW?=
 =?utf-8?B?Zis1aVpSbmlVRUFhUWJ1TUVDVXNHc1h3R2hNN1Zob2NZZ2xnc0VKQ3h1NXlE?=
 =?utf-8?B?eWpOMnoyK0tCYStGdUd0ZWc0Mm5jTkNLYlJJUzlWbHNJbEhRa0tncEhiTzZ3?=
 =?utf-8?B?bWxBVHcrdzNuMFY3UWtPQjE1cmYvUTNZN0xtMWVvUVR2bTVWR3k3V2dQLzRi?=
 =?utf-8?B?NzMrUVgwSnlXNnlncnJLTG9GMFhKb0ppdXE0d3laajdldWk1b2tkazhsY3ky?=
 =?utf-8?B?RGZ6MHlHc3JnMHVQajRXU0QxZVFadmtITG16OHRVbWQ2Vi80clhwZVovUXVC?=
 =?utf-8?B?dlhoQzNjWWVjaDlVNUlwUnRzNS9qaUt2SVJXNlNQTUhIY0FKTUZZUGJQRDRU?=
 =?utf-8?B?eDkrMmtJZURkLzN4UjdGSjJNYU0zY3dSS3dxOXFnTnNGRTNZUmM0LzBYb1Rh?=
 =?utf-8?B?eWFBYzBwMklSdm1sdElSMmJ0N3F4OTQ4R1dDeVd6MWlPeUljOHpUV1dzT2lM?=
 =?utf-8?B?Y0Z1dmpIR1l0L2NKOXlzb2hNb2F2RC9qM081angyRUFxbkUxTHREOVFiemdu?=
 =?utf-8?B?SVRiNjFyZnRXT3FtdGl3eEFkZlVEVlNmNm9EaXkxQ3B1U0RGWHUxWmY0Zlc0?=
 =?utf-8?B?MWJWdHQvRTdPckpCUU9hZGRLUlY3SDBOWE42Q2REN2htUi82VnNHOFY5bHQw?=
 =?utf-8?B?YVNIVGFMNC9vTlczcmQvbS9GRStzR3lJdUlOU0tZNEtWMDUxK21EeURBYnl1?=
 =?utf-8?B?bktsdXZFcjhXKzVwdHQrUmdCRnVRS3pTZTBJSVdTYTlScHpKd1p1OEVUR2RR?=
 =?utf-8?Q?vTEJzwjwzYiye7wkg0n7QnePTKyzUSfZ5ZxgQ=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R2g4NkwzRTdpQXV3Um9BL0JadmxHbjhzL1NwL29MbkdYajFsVWtETm5kaXlo?=
 =?utf-8?B?WFRBQzNoSW9BbTFSZTM2VHV0UmRKWFdpc0VEa1dmdVRvM0RobjU2VzIwM0xj?=
 =?utf-8?B?cDI1Y1NYNzJwWmIrVENEdU1tNWpqVjRnUGdHSHpjZ2huZWxMSEc0WkNBREhP?=
 =?utf-8?B?R1pmeXNPOWhsM25rUGxwQmMxL2lIb1VTWFdlcXNSVUs4Y3hUWjFhMFo5cTl3?=
 =?utf-8?B?WkNsNmFlVEVsYkhiWHZtMzIxRnN5RVN5OCtMendkNXI1eHd5aU4vdHpyeG94?=
 =?utf-8?B?K1RaY1dqRXdoalNvZ3B5MDJXNklNNlNQUzI3Sk1TM0kyajFORDRBcmR6RTdn?=
 =?utf-8?B?Y0s2QXVpTUFrUWtPcE9sanQ3WTg4RGVSeEV1dndnQTlYUDg2VkFmd0tMTEhF?=
 =?utf-8?B?RUsrMEh2UUJZQzBQTHZwQ2VtTFJZTnV0TXg2clRxZDFBZDVBTEp2cDkrQ1NN?=
 =?utf-8?B?TmhjOXd2Tmtmc3d6VGNVMitsNTFzcUVCSkNpQTl1S1FxQWJ6cHh2THpCRTlL?=
 =?utf-8?B?TmNGQkhBaTBpOFRFa29vdXdoeHkvQXZhUkRmT0V5Qm1QcVFaQ2VhV2NuV3Uz?=
 =?utf-8?B?clY4RTFHYkY5Rk9ySjRFV1dZSXZoeXBsNDl6QzlCb0ViM3VLdi8zZ2Q3c3hl?=
 =?utf-8?B?OWllM01LMTBicFhjSm1SVno4UEhyRk1GUWQveFVNN3JTeHhwcVMvS0FpOU9H?=
 =?utf-8?B?cXR6Z05qN1cxd3ZnNW84bm1RT2JzZDNnMEFQRVh6VDZPUnp0a2VjRHZtUXRP?=
 =?utf-8?B?SGoycXhyZTludmZxS2RxR0hORDBPd2I1RThDVytBWWN0Z3VVR1JYWVFvd0pu?=
 =?utf-8?B?a25sU2daMnRqcng3eCtWcy8rdHhwemNiWjFCdU0wZVJEZVkwK2w2T3NRNGNt?=
 =?utf-8?B?bU1KOWI4Tzc1NE5xdWF4eHlZYW5EWnVkS3V5UWN4UkwxdUlJVkxxTTlXTUNN?=
 =?utf-8?B?TkFHWWJranAyckgwZXlPU2RrTmlNWkx4MDU1c2tGTXV3VThEby84NnB6UFFk?=
 =?utf-8?B?Zi9IaE82aUd4M1BZaWVUU2FKTCtWS3hVTlk4THA2bkZYZHJWSzhlWHdBNnFH?=
 =?utf-8?B?TldGbkpzT3ZuaEpmR2tqNkFCcnJGbm1IZlFkUEZ6eFl6SVM2TGNBWlo2ODBW?=
 =?utf-8?B?TlhvWnY1dytZczdIS1pHaFEybEJqa2ZNUXozZ1FKaUM2Rm5GSEh2bXNkdjV5?=
 =?utf-8?B?d1A2bnEyclhZWWo1U3VkM0M1MjBmN1lqOFBZcGtrQWo2T21oVWlEVW9OS2tq?=
 =?utf-8?B?cVNORG5qZlJIT1E0OS9NNzc3K2U2VnVLTGtJdC9MZDd4dDA3WXNjSHZLemlH?=
 =?utf-8?B?K1JqMjBjclowWnYzZjB5WUhKRnBWZVM4cjFFaXRaMDFWaVZXNDVxakcrYThJ?=
 =?utf-8?B?dVUxY3BHQzdRMHBtNjFlemY2Q0lmaDZrMEd0M3huaklpYThYZ2xVQVU1UHdx?=
 =?utf-8?B?S2E2N3NLOHBmZStOWGMyQ0E1ZnlZcU9ZVVVGWWtjVUM4Qk5aTWxaa0RaVldD?=
 =?utf-8?B?VzEwNk5jSmFTMTVrd2daYjFER282N2EvVVpoKzNjZVFjV0orY1pDT3lDYm8y?=
 =?utf-8?B?c21uRDlHcUd1QXE0dThXZnlzdWJDMEdvaVVZQXNpR3pTa0UrZzZhUlA4TG4y?=
 =?utf-8?B?N1hLVHRhS1dOOUM5bytVaHdyekFuTExsQlJqK0lmSTIrNnJsM3lLQXFkT1hX?=
 =?utf-8?B?U2NyOUNGSmpRMFl2NmFBR3RaLzljVHBETGJXTWFmZDJPVnJPYUpjMk5oUk9T?=
 =?utf-8?B?dHBoV1JMMkNEZ1lXV3pwMWpLU2JES1k2R25NL1VIWHFkaWtucC9zT2d6d21M?=
 =?utf-8?B?ZCtsdjRIWVpKcWlmT09ScXltNCtPMzB2ekRFVTFJQmZtM0EwUURqTUNOejEr?=
 =?utf-8?B?LytGNm1yUUNoZ2R0YzB5WDJTWHpwU2tLcDZNaXphSHFuNitjWVNmbDkxRXdE?=
 =?utf-8?B?ZXBRNjljbDBYZUZxT0p2eTdsQ1FjK1Nhc0MrdGV2L3J3NjBZWW5nVnBiSkxp?=
 =?utf-8?B?OEVtbDdnUm1lV01TYTRpS3I5emtrTjE4U29Jc2hCdDF3c1E5Uk9RVWpCZmkx?=
 =?utf-8?B?emkvU1JGaEliVVpXcWtIVkt4UVZEMXhybEw3TXNHOTZ3cjR0NjF4T1NvU1gz?=
 =?utf-8?B?MEJDOFYzNytLK1dNdmNxNk1ranNrM1BsRUE2T1NyV0JZcE16MnRFWGlObFU3?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8792D190E3369C4790901F0FA84A831F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ycLO/Ai6aLotmnbHvnmgLDzPWOjm0zIJNiDR4L3lAG8NLgX6oJr/MRE2sCA/OKrhyTnc6NmAzpm1WB3+fRs3U/NZyXDtoI7+6/WcDvTyEmJBFsP/2bRbMU2iEQGYj3WbDJTNiHRTsLCcNy7aVXR+ZGPtXh7Vl/o6/GA6mRk4wM+V505BpJPCVSonwJKz1CTCsJ1i71H9mFUplgZ4O1ZEMnVV6T+Fel9g0s1xurxXM1PNxbU+Rj/082hPtAwSYTChdf6REWuI8DkC5HMnbs5d7lzYl9X7yuReiCAeU6e5c5AoT106rI0dLI/tSgScxn+/M0gTDZWOByAlLX05r0YISaXhFXSdlLmgkBiI8R0WQRvxBYbR6qZpeJFRELzonVW7JsXkWS9yUuShFxrsNESkq6COf96/sUuU4XNs/2Lxo3B0udB7G264NtCWv/l8wjPSoTnCVQANR0BXVcPRb85GYKKUgaAThJmZBcQEaZxy16rSXeK36zh/cq44twHftO79RG1DrIP5I/YW0GW1CYCVhJwIO8F0JnZUeB0Ddfh5dtzpsJSPdKqInHgIsZBWi1FD6bzJ1jsnTSwAO6aXfRb2vfKh5Qb9Ta/3aqEJQuxPhz4fVNs9JfumZUecPp9GLf7kOCboVzsv4B9kOL9gt9USMA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980abeb5-f6c3-464e-7f92-08dc91b4f819
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 05:42:42.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTTP28vSl8oFQit8KgDymJwj+4xmmlTL8i9WDb6dAbzOFLRZCR3M6xoNSaWix2m3SXFdhZXn51fApSv7UErWRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
X-Proofpoint-ORIG-GUID: Mkdk-uXqgsTte26O52wgY_esdPpKS8Zt
X-Proofpoint-GUID: Mkdk-uXqgsTte26O52wgY_esdPpKS8Zt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 impostorscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406210041

T24gRnJpLCBKdW4gMjEsIDIwMjQsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDIxLCAy
MDI0IGF0IDA5OjQwOjEwQU0gKzA4MDAsIGpvc3dhbmcgd3JvdGU6DQo+ID4gT24gRnJpLCBKdW4g
MjEsIDIwMjQgYXQgMToxNuKAr0FNIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEp1biAxOSwgMjAyNCBhdCAwNzo0NToyOVBN
ICswODAwLCBqb3N3YW5nIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBKb3MgV2FuZyA8am9zd2FuZ0Bs
ZW5vdm8uY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGlzIGEgd29ya2Fyb3VuZCBmb3IgU1RB
UiA0ODQ2MTMyLCB3aGljaCBvbmx5IGFmZmVjdHMNCj4gPiA+ID4gRFdDX3VzYjMxIHZlcnNpb24y
LjAwYSBvcGVyYXRpbmcgaW4gaG9zdCBtb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGVyZSBpcyBh
IHByb2JsZW0gaW4gRFdDX3VzYjMxIHZlcnNpb24gMi4wMGEgb3BlcmF0aW5nDQo+ID4gPiA+IGlu
IGhvc3QgbW9kZSB0aGF0IHdvdWxkIGNhdXNlIGEgQ1NSIHJlYWQgdGltZW91dCBXaGVuIENTUg0K
PiA+ID4gPiByZWFkIGNvaW5jaWRlcyB3aXRoIFJBTSBDbG9jayBHYXRpbmcgRW50cnkuIEJ5IGRp
c2FibGUNCj4gPiA+ID4gQ2xvY2sgR2F0aW5nLCBzYWNyaWZpY2luZyBwb3dlciBjb25zdW1wdGlv
biBmb3Igbm9ybWFsDQo+ID4gPiA+IG9wZXJhdGlvbi4NCj4gPiA+ID4NCj4gPiA+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9zIFdhbmcgPGpv
c3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+DQo+ID4gPiBXaGF0IGNvbW1pdCBpZCBkb2VzIHRoaXMg
Zml4PyAgSG93IGZhciBiYWNrIHNob3VsZCBpdCBiZSBiYWNrcG9ydGVkIGluDQo+ID4gPiB0aGUg
c3RhYmxlIHJlbGVhc2VzPw0KPiA+ID4NCj4gPiA+IHRoYW5rcywNCj4gPiA+DQo+ID4gPiBncmVn
IGstaA0KPiA+IA0KPiA+IEhlbGxvIEdyZWcgVGhpbmgNCj4gPiANCj4gPiBJdCBzZWVtcyBmaXJz
dCBiZWdpbiBmcm9tIHRoZSBjb21taXQgMWU0M2M4NmQ4NGZiICgidXNiOiBkd2MzOiBjb3JlOg0K
PiA+IEFkZCBEV0MzMSB2ZXJzaW9uIDIuMDBhIGNvbnRyb2xsZXIiKQ0KPiA+IGluIDYuOC4wLXJj
NiBicmFuY2ggPw0KPiANCj4gVGhhdCBjb21taXQgc2hvd2VkIHVwIGluIDYuOSwgbm90IDYuOC4g
IEFuZCBpZiBzbywgcGxlYXNlIHJlc2VuZCB3aXRoIGENCj4gcHJvcGVyICJGaXhlczoiIHRhZy4N
Cj4gDQoNClRoaXMgcGF0Y2ggd29ya2Fyb3VuZHMgdGhlIGNvbnRyb2xsZXIncyBpc3N1ZS4gSXQg
ZG9lc24ndCByZXNvbHZlIGFueQ0KcGFydGljdWxhciBjb21taXQgdGhhdCByZXF1aXJlcyBhICJG
aXhlcyIgdGFnLiBTbywgdGhpcyBzaG91bGQgZ28gb24NCiJuZXh0Ii4gSXQgY2FuIGJlIGJhY2tw
b3J0ZWQgYXMgbmVlZGVkLiBJZiBpdCdzIHRvIGJlIGJhY2twb3J0ZWQsIGl0IGNhbg0KcHJvYmFi
bHkgZ28gYmFjayB0byBhcyBmYXIgYXMgdjQuMywgdG8gY29tbWl0IDY5MGZiMzcxOGE3MCAoInVz
YjogZHdjMzoNClN1cHBvcnQgU3lub3BzeXMgVVNCIDMuMSBJUCIpLiBCdXQgeW91J2QgbmVlZCB0
byBjb2xsZWN0IGFsbCB0aGUNCmRlcGVuZGVuY2llcyBpbmNsdWRpbmcgdGhlIGNvbW1pdCBtZW50
aW9uIGFib3ZlLg0KDQpCUiwNClRoaW5o


Return-Path: <stable+bounces-225770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DJ2LS4XuWmOpgEAu9opvQ
	(envelope-from <stable+bounces-225770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:56:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A342A60BA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAE8D304DC98
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFB39DBF2;
	Tue, 17 Mar 2026 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E0I6/IzT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DnMhhbAN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399D39C637;
	Tue, 17 Mar 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737763; cv=fail; b=m+EK/WttaYE9JAmgPf+nSescfwCvh03Jfe1grMqskD/Xok/suqTuJuFt1wHmJr8Ej+zeK7QUJ1jbDetEsuSg6bf/ycKozHnIMiclmtb7QL17PC8mdFyuJRHzecyzEeyguTUqm9y67SV61AXxbHL2/YRm5dz6EIM0KRPj2rXvKWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737763; c=relaxed/simple;
	bh=vBKLmvuhSXsNmWicJUQLt5jP3ziRpH3vC2V1rjk1Kig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LmJt7cTB9owWEmRy+cRXjZjBfBgzb2o1+5zsqgtbYray1Cls0fBWXAn2v9jX2vzeGN2FZ0Lz8F+zvyqP3F/pcn5Rvyat0uSFSwMfi2H/udm4accy5JZLBqefgvIyS7aBRo5pMufig7gfNuUdajfggPx7mPaxiUmeqlSfEHOAge4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E0I6/IzT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DnMhhbAN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GNKBE02823123;
	Tue, 17 Mar 2026 08:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7KKdYv+/6hRA6LUkZbJZkH0gEsLXOZ26spoZLhTyrdE=; b=
	E0I6/IzTFQTAUVsUFXXchVXplimij52oPlMQAFNH42QcTLKhhml+rl4ZUHgsNoLb
	PjhNRmAq4HcKluk0SAmEVqckwhgEKfU3cALAex3GbHaUO72HksNZ+S7XolJQhyc4
	L6c4KPl9jbhucnI+DIZqybx9pa1RvL1BBDwb6ec9QNoy4whzy0dLuaPNbKB4sxyI
	6UFUy9LCM4CkF7jtbgLrhvSsJ8VeWCCDGMTpRgYkvJ8rBEDMFNmnDfxdrEjSb6wf
	zGZdEOkhXVnssOJ+q7GkeL5T1rIB3v5kBDzGn42K/4S3bPLm8BNDkYoByPyrWn1c
	JxzC5n9svA+W8t4ZvVpXBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbuqbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 08:55:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7uIt2030579;
	Tue, 17 Mar 2026 08:55:25 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012035.outbound.protection.outlook.com [40.93.195.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx49rt2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 08:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot1evdPJPwkTmAAmgmy5LyeQ2nX5Me6B5EldZLsctNsvyhLQ4owT3OV2MtDhUEKSNYPrDO6LC4GvnmFlkIqLrylp5W7CfZvSDbOtpgHrrQRdqin2zgVafWlK36E1fdqwdvFOsXuyF3J0zAI1mXtOJ9txLDuT8d/pfc51B727n4lGxQnJJKtxuWY3xzi6eRKfQaxpVXpmivVDv6nGTUuOWdW38J6ltrfg9hsTry/G90gejlR5QwtGq0Lk4h/QV5+n+qCDfGfo55mrA1EMk9BZKExOa6iTs2TvJh5RmouBsdfRk50uEUwu/tdri0t7Or2m8987g4Ah8WHdKZDW+3Qjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KKdYv+/6hRA6LUkZbJZkH0gEsLXOZ26spoZLhTyrdE=;
 b=PZYgvASiNYJk+6SG3scUFvMw4eamv/QsuNAw+O7UbKJTD7OSVVaGtu9v/OsESMgwGuA3Y87NQSfS9qBEGWOS5i8MuZxSUqCf+ZZDhjFfsljn7TFY/gABVR4V9Y45C8JU2FoiDMdtoxZN/2WwDBLl+vQs4ZjdUkyVKGaNf8WAt0ERugtmlTm5lSPrwn8ckR/c+DIDVuYjmL5zuXcJgvWiEH4IkfFIzH6k3zPCSAgaD6NF1XmQSuDUhuS6UJhz4NUse/kaBzcvHFBN4X0zb2Vlw6zPr+hZ2bVaITZj8IHK83Eb8KZM0KYdzCgf5oQUIIlJ9BxLQZ3Zxtcm++aJCHXklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KKdYv+/6hRA6LUkZbJZkH0gEsLXOZ26spoZLhTyrdE=;
 b=DnMhhbANyzn6dw6q0pDBd2jYXQwS0kF8vpfBJgfoEeX/bLEGRxzZ8eS8KoA2iLS/dfjdLQpqMskBFxPuWOggccTzU8rtxo2WV3To7rkoEJSre333npI7HTl+8Ndu06vMKERl6pk7ZDdiOFUwsIHU9ANfhE9ppqlRrgXexovvE+g=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ5PPFA8FAAE4F4.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 08:55:19 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 08:55:19 +0000
Message-ID: <113fed67-e31e-452f-bad2-61a5c16c7a16@oracle.com>
Date: Tue, 17 Mar 2026 08:55:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-pci: handle dma_opt_mapping_size() returning
 0
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, ahuang12@lenovo.com,
        iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <20260316203956.64515-3-ionut.nechita@windriver.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316203956.64515-3-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0038.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::26) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ5PPFA8FAAE4F4:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee42ba-768a-463b-5342-08de8402ea43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	53QEUFZqHycAlqjMkR0FTMUQb1L3cqjLWsXUMN1pD118TiSAFt6qxKecof5dWMuz6ybTnTXQ1X7rVt4cO+taBzr1Wz0sLeVLGh1Nf0rye5zHvFWTNl2y0Tody/CpkGqBKP+LX+FjP2Uap8DgoOaYWBjKB4xPO/ny1bitOucsCl4xHvOo/xy5aLpaLBTukBFQFL8hDMS+6PjfY5bqq7hIhJvzbl1EZG/vwkAakOgHZIOfo2gk0CrOsl0R9rtMRbQvw/tqVGSRWJYxRdWF9ZP/ripFhBONMDMWarSaSl5qcFxwtTjrfdkhUwoKKePbEvlH1ZxZBwf6uUD+kAHG7wvVpPrK+0rD2HthIqOTVj5mIdAL4PUccbiGRnwqn1R/xjkWs5djMtZDP4ztYqraE7xnsGqlrqHWmZeT5Lza+L1NVs6rnEghX8OXh9M5dwx878VUKUigQsnV8h4xZ6a1GRjPrN8hRKAN+wGANwloCUGjyEY15odpo8Y8u8oK5DcHvhucSmqDY/+FXE1S9BmaWq1EbXylJyWEhvqsfzwPqSu/nrQv6cgM+8i3llmp4vO4+k6AZTBMwBp65uwMZ71hTLp4JK+SIeKPi749TBtvRvYIQXqFFNDKiaHQPeaAkupthCCinMgd1aDIbkLivUsAxRREySwaoi5AXtpNcz/EVs4x7Ct1QidjTVPvj0EcIaiZ4Vh/SPFDXh/RVgS1Sl4dGqlaodQN0207u5bxu3y2vwTsIGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0dubFVoTVd6S3NrdGVpQS9obmFaUmxYMnBFQ2thdEVuK0RRTmdWMDA1SUNI?=
 =?utf-8?B?SFloU0QvVENob0dycWp2NzVzUVU3K1U0eERCRCtOdG5aTHNXb0VPYTJJeXBh?=
 =?utf-8?B?RVoyTXBpTUNJMmZJcGJQUURoUDRwSCtWd01lRkxaUmFidk5uWUozNjlWbmtP?=
 =?utf-8?B?MUx3TFNmWEtod2lRWkx5clZIcTEwNDFLU2k2c1V6Z29vbFR3TzhNbHZSWlEr?=
 =?utf-8?B?MVNYSXY4cVJ4dlJRNnlkbVRkdVVlSGYwalBkdzl4djZmLzRkWWRSbGl4eFN1?=
 =?utf-8?B?TVJSUnBybU9YbHlsTi9jMHNhRW9tbWxJTmNQdlVSNU4wNmc1M1Joc1BWc1hp?=
 =?utf-8?B?T1huNmk0WnM5U1ltN0trSDZWamRMTktkaTVpSTRWL1BQYmZZNjVkQ2dodFly?=
 =?utf-8?B?QUVmVkpKdFo2S3FFRGY2WVVrS3lKOU5aQkpMdXZ0ZW1id0o3MFh4Sm83WUdx?=
 =?utf-8?B?NmpteWhvWjkyMloyNWcrRW9WditUUE1Oc0YxQ05Ec082L1Y1MVpLbkxsaXd1?=
 =?utf-8?B?c1JnQS9kRDluMkFYOGpuR3dwY3c0SUxaeUUxYld2ckpHRDBITTBsbjNleFN0?=
 =?utf-8?B?VDNqMWo4WjBGTVUvTXR4WlBoa0oxMnlpaWpwbEpiNmNCWitGd1U0YUE1bloy?=
 =?utf-8?B?eHdCYU16dUxPS1ZyWVFjME4vTlVMYitxRWNTV0liTDB1Y1ZoV1dzdVBaYTQ3?=
 =?utf-8?B?MVRsZFFqTWU0SmhUcFNjWlFDTE0xc0g2RUdNcUk4WjJXY3RkeG51WFg5YVRr?=
 =?utf-8?B?T0FQUEZKeFpyN21JS2NoR21EWVc1WEdRdmF4bnkwamVBd05YQUkvZ09OSm53?=
 =?utf-8?B?blozbWVzV01wWGgwNndQdkhMU3VJVWo3Nys1ekdnYkgzS3gxTStKY1YrcTJJ?=
 =?utf-8?B?MDJBRWMzQzlHbktZYnMvZjlSR3BTeE1NUnJSbllRdWZYanZuTzJCdlZjVmlp?=
 =?utf-8?B?MjJSS2tGRkt2ZHRrN2R4TlRDSGx6M0cvUHpJSkd4c3l2N3lMcDk3Z21DRWdI?=
 =?utf-8?B?SmRPek9ad1RZY0hvdmxaeDVrL0Q0b2ExTXRxc0d3MjlMTUYwN2V4KzZCdTJK?=
 =?utf-8?B?VUNoQkM2OGVldzJ1M0o5ZEpvSmxpZ0tTUWV3Q2tLNXM2T1ozekZ0Y0U3dUM0?=
 =?utf-8?B?UlV1K3VQZ0o0azZBSWN4MmpKbHZ5WnJzYTdBL0YyVUtFa0pjNVRGZXFBSEVM?=
 =?utf-8?B?RHVMakpvcE8xUXliRHA3dXVCMC9IZEt1N1lDSjAvdkNhSEJpVmZBbkZrUDVV?=
 =?utf-8?B?eFJoV3NMVW51ZkpsV0VQaFRYcWk5dmRHUDhUSzVtVFBCaXFUSTBHUUpXWVVB?=
 =?utf-8?B?ZjZQbitzZEhOcUN1bDdHRGliQVZITm1hN2JkVHkvd0R0b3pTdDJsUmxhb1oz?=
 =?utf-8?B?cmJlNE4rN2xnNFVEYXUvYndHRlBmRC9zaC9kTG9qajV0cS8zSDc5Z0hiRXVY?=
 =?utf-8?B?TDMyYkl0QktMTFVLaURZazVSaG0rbXl4ekNMRnJPRHIzL2ZZelZCRk1VRDVP?=
 =?utf-8?B?aGE3cVdCb29iNGRoOGdCSVBtNnJyN05LZldFR3Y1Z1VkZjV2eklzREl5NDU3?=
 =?utf-8?B?K0o0SXVnUlpTTWQrWmFob21GOGhUTVRFVnV1cHVJUFB0VWpmaUMzV3F1RUhj?=
 =?utf-8?B?TE40RXFBbmoxK1pCSGtOTWRjc1cwNmxjdVdHU0lzd2VHVUJjSCtmQU01am1J?=
 =?utf-8?B?aW9NRjZONVFRejRFOW83aDJpclZvajY0YmhFemh3dzl3TXMxaWE3ajdwc3BL?=
 =?utf-8?B?dHptak1sTlkzZjc4V1VMR0R1YThYenBONklZckJRcmNKMkI3NzF0Q3RXMVYw?=
 =?utf-8?B?dlpTVC81cTlVZ2Y5MzdCbjZlSmxJb21CN1g1R2FUbzA3V2g5TGNubkNYdzlo?=
 =?utf-8?B?bVVFTGd2WmlNd0NSQk5SOExWeGZwditITHFuNmJzNDhzOGlaTzBTbjVQTGlT?=
 =?utf-8?B?SEROS1lBcUFicUM0dnN6SkwramM1ZnFJNFphRWVCNW00RlVmQmIzNThKUi9o?=
 =?utf-8?B?NUNXcGV4Q0dOejF2TW9qQnhleXdyRG9DeWl0Q1oxNTFEa0J5dndIZHA3anVU?=
 =?utf-8?B?SW92ckVMZHNLZFBNNzZPUTdkK0hxM0RNUERXYXBhZjZ3ZWhEbHkwamRsTHU2?=
 =?utf-8?B?MG9rdlhwRFVVeE1ocENBMnVFUGxBWTBjc1Q4am9kMStaZ2lnZXNxZDg3OE9i?=
 =?utf-8?B?LzVQdzhhc0FySVVlOGZ5ZjZWRTIzQnhLVGhZUGZ4N09tK1I5NUlwRXdIYVVV?=
 =?utf-8?B?SG1NSzY5aGZPNUppUi9RRndyd2FFQ3BmdE5RMkt2L0g2MU1Uck9tZmhGMVlw?=
 =?utf-8?B?MFBPdVpkTXFSV3pCa0pzVlFOSVdYZG5oY2p6U1NnQnN2YjBGRjF1Zz09?=
X-Exchange-RoutingPolicyChecked:
	qgsegilHvcdb5mRJrgrv6yisx7BjeiVCLPHXb4+jSIBHgc5ROLUAE4Wk66KEh7vDMw+AaVXkD6o0fOXdIX3bbnzW8fgoTiX2htY3l1MWviXDMhDdJsgnmSBDGXOCAfsCHjgQp1KGfCWBpmMJa6WIt9M5E8bWR8TY7wwsjkC38fk9dVH06ScGTshyjJvy0qnd8ti3NxJ1yFZmSFNLmcLf5p1C8PjfldoL2yD0oFdsDP7ymVuQT7V+hcMNSauBWJz+e42sLfBLjXWkZw62NwyU563rMk/6drwtjVNz4lP8Zc8GaLyLsHncrvvTpUAiGh2hFvPNsc3wqBnbBO+vcuxEog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	08Nb6+vIiqtrossjycV2rosVCYw2VnBcB3VFApqW8e35ZnNnwFv2jRlNRz98uWVUmkFiA1HCzGZbzbmFUpJd/eutLLawegvMMdNejICz+fgRfQjKiThB9oyPgYxP5/ysw6eK2yzU6YWtBbzKwYNVgC5UaAp2Xca+YnXaVedGXFRL9rjp60tvWgYC3d1vy7DV8Z2SEqCNfUrXDEADtTjxaFg76u1s1mQdWywnyzsrmGAJjXD1Yz4JaLSOtc6gR4A1zB8nXrED/zy48BfHdslAbiIP6lDIa96C+NEAMI4FsTEayyxJDbeHcq5vlJX8tgD/o0qoLe0IP2KW00kfIxpw+ISyu3Dia/MzxIJIliDCfd/RrSQCemBcoUGOJiPs8LhPYfu/FRi3MT5S3okwO7zTjgWzZRJRzHeW5QjBrkNSGKzLRDSLjK7DemVW3D/oygLKNtk7sIm0u40jCo7O7gJ6dBBzyxu+KewLKLavFrTqBkwEh0Pbh2NmgoQsis1Y24sQ+S18n3BYcQwoPk2K7s/aG5Zn8PWDOB5RLUP7riFC9WShdtbWVCGsJcIpdonDjzVPhkaeFwrYUwI5Hqp++BrUhZVBhn6U7fes8BlbRaRtWoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee42ba-768a-463b-5342-08de8402ea43
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:55:19.0872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1sm85NgaxkhsgBSR1g1UxaJsJh86IpVY2fZfxyO8Or4F/S1yKHAsuITJIxcsfWghfyH1JW1RzT1v3Gu035sxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA8FAAE4F4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3OCBTYWx0ZWRfXxwY4cJrftnqJ
 8qCl7tHlY4tGuFJYkF+RKK/Rp0Fp30qt+DWL997T8Icz/ZC3XwKGiJ4/5G4ws/SABphGLMJyyzi
 5E2br/jIQA1C5ux81aeE1zImYV3zFWvOQFCz8pOXpQWJL1HO3+sSypTvHBU/l55t9GMqXyB6I8E
 /NLUIW1+pd+XxukqxFtVFJzOUD0J4z8vS1bJYAMfeO/XGCh7PRx4lrgkum2xpqPUw14abn4ixg6
 PUcGGwbPmoR5OAp5o+Q70I1gaXNfHvyTVdTBl5BSZdWJ9OwZY1tL4rrx3SEJPs+tlJgHJGsE1ZW
 DM9UU2FjOLKpdB9tSyxU0WEnD4nvxFvBys9+ZCmbBSpfdbcRzhf+iu6yoEnkOKqq2oJMKW9lSSl
 G/mbvRgmWtsc7t0mNuEbAxbymcJyHZoHVJ8kJnKgSCt3W33Gg1WjbXHxn5qkvNY44mpkKA/+9To
 3RxIYlFhRxsMON4l0Kw==
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69b916fe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=u5gZpgB8sjyAWNAkIGcA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 5ssykTMWXXw-yrRne-kX7mry2-91jvcI
X-Proofpoint-ORIG-GUID: 5ssykTMWXXw-yrRne-kX7mry2-91jvcI
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-225770-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 20A342A60BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/03/2026 20:39, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After the previous commit, dma_opt_mapping_size() returns 0 when no DMA
> backend provides an optimal mapping size hint (e.g. IOMMU in passthrough
> mode with no ops->opt_mapping_size callback).
> 
> The NVMe PCI driver used min_t(u32, NVME_MAX_BYTES >> SECTOR_SHIFT,
> dma_opt_mapping_size() >> 9) to cap max_hw_sectors.  With a 0 return
> value this would set max_hw_sectors to 0, which is invalid.

With the first patch you have introduced a temporary breakage.

> 
> Guard the min_t so that max_hw_sectors is only capped when
> dma_opt_mapping_size() provides a real hint.  When it returns 0, fall
> back to the existing NVME_MAX_BYTES >> SECTOR_SHIFT default.
> 
> Fixes: 3710e2b056cb ("nvme-pci: clamp max_hw_sectors based on DMA optimized limitation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>   drivers/nvme/host/pci.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b78ba239c8ea8..dc148fb6eff28 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3640,6 +3640,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   {
>   	unsigned long quirks = id->driver_data;
>   	int node = dev_to_node(&pdev->dev);
> +	size_t dma_opt;
>   	struct nvme_dev *dev;
>   	struct quirk_entry *qentry;
>   	int ret = -ENOMEM;
> @@ -3691,12 +3692,16 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
>   
>   	/*
> -	 * Limit the max command size to prevent iod->sg allocations going
> -	 * over a single page.
> +	 * Limit the max command size to prevent iod->sg allocations
> +	 * going over a single page.  Only apply the DMA optimal mapping
> +	 * size limit when the DMA layer actually provides one (non-zero
> +	 * return from dma_opt_mapping_size()).
>   	 */
> -	dev->ctrl.max_hw_sectors = min_t(u32,
> -			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);
> +	dev->ctrl.max_hw_sectors = NVME_MAX_BYTES >> SECTOR_SHIFT;
> +	dma_opt = dma_opt_mapping_size(&pdev->dev);
> +	if (dma_opt)
> +		dev->ctrl.max_hw_sectors =
> +			min_t(u32, dev->ctrl.max_hw_sectors, dma_opt >> 9); 

SECTOR_SHIFT can be used instead of hard-coded '9'

>   	dev->ctrl.max_segments = NVME_MAX_SEGS;
>   	dev->ctrl.max_integrity_segments = 1;
>   	return dev;



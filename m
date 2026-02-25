Return-Path: <stable+bounces-219620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHhLIOn5nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:32:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B11981BD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 852C4304260B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2733AEF5B;
	Wed, 25 Feb 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UemHVlUe"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65663B8D4A;
	Wed, 25 Feb 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026330; cv=fail; b=JH1fAeHw3TLXy3A/0N6qTamMkxSfACTglwvTiYUdB9TCf4V7FR58wmhdv9G8s72IeygO9MPJmJabq80F3kQO1AyNw/UzOK/tAuWoE+6AWRpS6XZYfSN5mJbdVC4+RywEYPLMQz3KfbjPw8QIJ9WKZJtTUGupPdU8RFsjoGOXFEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026330; c=relaxed/simple;
	bh=8tka9GDF/VBVwqE4sduxSjsgVr+EcxLD1NEF7ZV0lhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJOOClUd2oWvZVHNiEbyS2VDjHS9VGpv2gKIO/4ixSUVDJU8h3kL9bHa51/iVo1HNL7bM+OtzA36VircxxySeEDn4KrUZRfptfsMYZL0PLeou9ZB5BL5FFleZlzoEzyUybwsUAZ6O38vF2oZw69NpKDboV9Q8sYqYYjali8NI+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UemHVlUe; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P6lKDI3631151;
	Wed, 25 Feb 2026 05:31:53 -0800
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021117.outbound.protection.outlook.com [52.101.52.117])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chf1mtqg1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 05:31:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwuc1iFcXxAp1n7JoiPfEnA/0Dp2XTLB3mE9kvrZ/XZZGoR10gNqwkFwCIS6dlAIf4DvGpSbgMu/w2XT/hCaRZ99FGrQ3kR0jHV+cAyNYoy1YZYzcdLIcPelgsVBbzFL7dGaXGlZZm+V9+bBXl+FrDvYTAaK8pY5QZ6Q1LautdOlDHFG/lyqWgKZFlHJgOBTtHETDbG+7zT3CfhDhxmLtj9fH/Lxq/HeHg2KZMgzi5cqArRFkgmplk7HBrkhf886t4yqBHnkJUgie5P0ZauYE1lgA8PhvhvUE3SBTQrvZtKX6E9M1nSgXTIanJGZj4rX5KAcdDQ7iBx/fGmA/PJi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tka9GDF/VBVwqE4sduxSjsgVr+EcxLD1NEF7ZV0lhQ=;
 b=rIkI5cueM3IqmctsOdndPHer/lvi+x3OfUMfRUC5goysVzc+UeSZIn3eHHcg26LMaQbpDc5hPRCIGsI4WvmBKAyyZ1QN+A5rqabd8ueNw85cjnG/+L0G5G9jQaub01wOEr+/p3C2SlLzbHHckxm2sjBBB1KJke2NkgMxcWAdnYh+f8ItRiGyfsU/2DH572EGuAaMH+ylcV38moCz++k3JS1K0U+e2XWhKB1KpS3/8cJdiLFHNStmcuLBBE7AJNB7rUqjQSlJVPum3PQHu1ppQhdcEfZgBVvtR4tQQoHt6viIomnlOIBGO0KSkCL8D2bgE/NCx5Qcl5R6qCTm+VSNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tka9GDF/VBVwqE4sduxSjsgVr+EcxLD1NEF7ZV0lhQ=;
 b=UemHVlUeUxAwIJFopKdWMryn2wSIefGyV3BlLNJ6dkAlLihQTrpa1wz5VdUJtx7RREWx6TQpAzNszjrrul0cS/NsmzeZqP5GwAGA8+Q3gDTobAfDJ0JdfVIOAHGwnIIVCobgOErVUanaIb0vzlcRRct6FoopJLSLh0z7jYnyBog=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by BN9PR18MB4297.namprd18.prod.outlook.com (2603:10b6:408:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.10; Wed, 25 Feb
 2026 13:31:51 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 13:31:50 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index:
 AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+ICAAAJzgIAAAelwgAABfwCAAAGJIIAAAtEAgAAH/QCAAADq8A==
Date: Wed, 25 Feb 2026 13:31:50 +0000
Message-ID:
 <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225081735-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225081735-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|BN9PR18MB4297:EE_
x-ms-office365-filtering-correlation-id: 723109fd-8701-403c-50fb-08de74723ba6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7142099003|38070700021;
x-microsoft-antispam-message-info:
 eGnIVm0oHKokLFfoVRxzMOtZxBzMiQbpPqhAZqoT8JjXcOcZHmGqYdzY4vLkwCL3VuuQa2NLCx2b+g8E6KoxdkPHxtrKOrkKamk9dgOXL0h43fHFfK/hZV9hOrrvlqciI9ASAyg5IfckVd4yTAm1f17wSpunwRdfq3PP1Emx8E39XPtq3vWEH4bZ/lnHPLG7F/X6sTLiLwGxGhGkDqTVU48fkRjK2WO8ZaiqGJxLYwSsiwgZ/GaR/rIQp0GHKAPuuILkVnAVqnw4UJWXw6eKLdnh3jENq2V4cb7VZFh8SJhiRxiVFiWl+iqS75mdsTa6irulHey97roe6xdrB9re20lm+5pLwlEvGEjHy/m8cF7YHV8EmrrwAVDYzj1+0ETNKGuS2xNxAb3s5eWlOyc/NRGQ2/OmI94wwWkAhfwXmFRMlXFRnuyrA1wCyJRBjV6i+JBJoAJzBxJN2HfTAAtfoxt/a8Tv1Q3TVAtO1zyQfFXFQDUR+wI8aJzENbOUwGwIySj8U2lAVJBHkyRlwu68h/xCIyglE/H+pwp7qX6g7wSFumDa1/rNzhWIKVjR/2XbNGJPwGFZ47FBH1YW4aNBFZuNdKpOaTiwrVvuBuTfM6TWLNbMl7vnkSBneepEXSajKIQ2UDr6aT6AHtQpEGW2IgSy9GZuskQxNz7X5psTRB2xJ65K+nGhdjn4VV6oq6j6Mz3WjY7g4JtXwXBpL0pM2dJkGszSxQlCr5nWR8lHOpIPvNpN8oYhRerPnDqHqUe/cPpGQspZUIhtR+PsVGUw1IcrW7vEACB/vRPd5eVzk/E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7142099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1ErZ0tVWHZoajBNYXZ1a21veWorV2dWdjkwMm5nTEdTeTNFM3hXSXFXaks1?=
 =?utf-8?B?ZHNjaUpLZXZEWmtxQ00vTU45VkNwWlhydTZLQUVZY3lRWkZJd0p1bzMvQ3hs?=
 =?utf-8?B?eWZxUzBDaU5ybFA0REU4Z29renM0a2dWYjV5S3RjNkdLTVhLU1FJNUM5R202?=
 =?utf-8?B?NXc4UmVGVjdVTXBiRlNFRStnbmZPVkVNYnhUUTZDcllXNUVnS3ZGeXBrUUo1?=
 =?utf-8?B?Y3FnOE9oWGR1Skl6QTByYVNDTW5xVVJ0cWVqTDBpaXAzUmpMWit3ZEdLcjY4?=
 =?utf-8?B?dFVZR0lWR09MQm52NzVGNUY2VW4vZWZ2VFBINVZ2emhVc0tKekNSSkFhcFZF?=
 =?utf-8?B?QjlMQ3AyMG1TRVBPNmU1Y2hVMUtwdWJkTmJNMjVMMEFaTGZuckcyUVczVFQ2?=
 =?utf-8?B?Qk5ZQ1RtK2hNK1RrWWRyenZ2RjdhZUdaNjFrSEorMGtmWmg5anNYVlE4eXdy?=
 =?utf-8?B?bnZaOHJOZHhNN1owTm1Nem1xVjZrZUg1Wkp3SGlZUWF5QkUwY2hzV2MybGpk?=
 =?utf-8?B?VEZYQkhnSFFoZUV2MDJuZFJNY3IycVdXZjhrTUd4RmRvLzhDZXZYRVJ2SE9E?=
 =?utf-8?B?Wk80cnNyMVRDRytxNVdGTm5RVmFpajVRQ0JZbXA2V3Z2TytpdmFyeUl2NVNn?=
 =?utf-8?B?RjY3dk1rY3hRR1B2Sk1nQm9oUlIxVC9DbEhUb01NaGZUZG9BQXVua0FjZUlQ?=
 =?utf-8?B?eFc4RXBXK0RHVU10cUZuK2xQdS9pZzRRQWs1Q25VWEp6RUdFdkh5WGxudFYr?=
 =?utf-8?B?SWJaQkpFMDROOURJWklRK2EzRm1LZTVBNTlybnVXNC9PUThqRDhKUVV3Ukdr?=
 =?utf-8?B?UXFjWVRYTWk5K1lKNEZtckgrR2t3MjFMb0JYTGtUVTZYUUhyQTdjbE1mdGd2?=
 =?utf-8?B?Zk9TYkZOempOUEk1R0EzT2x6VVZ3MjRvM2czcTJHemRaWmpKdjM2RTk0cU1s?=
 =?utf-8?B?QXlHZjdCTndCd1dGdmtyeU1JbE9FQlk0YkpJSVZ6QVM3TW96WjR5Y0JHUTRO?=
 =?utf-8?B?UEpoRmdtQ21yV0dyUEpITGdCTEdPK1dlazI3RU1qbWNIWnNIdDczS3ZqMmt4?=
 =?utf-8?B?am5RTDBYQlBvZDBMTmVuR2dwTU9SVFlId3U0N2RZU1p3WVppa0w0Q0dJNkww?=
 =?utf-8?B?dEh4ZmkxY1RSVmhJcy9ZY2llY0o2QUZYQTFRNXY3VzIwRWtDZzdmNC9CbEoy?=
 =?utf-8?B?dDg3YUJ4NkRoaHE1ZW0veHFBYWNxazVXb2VjeUtreTRDMmhLWWtvOEVxOFRP?=
 =?utf-8?B?Y3hLQWRvM3p2OUU2Q00xQkh4dFNwZVV0TStCcjVDZ2NUeS9rR2hvaG51b2hv?=
 =?utf-8?B?eFppUjQxc2hHVlRlemwxZTNtWkV1RVFJaU12Qjl6czljMXpHcXBCR1NJOGxw?=
 =?utf-8?B?RFF3WkRjc2VZVk40SVpnNTdIRVF0cTJDL1hCTVpJa0VENTA0QkRoZ3RCbXZx?=
 =?utf-8?B?QTh2VGZ3SE5CblF2U0NyLzBYWG5WRU83SElTd0c3NTlpUjZndHdoblU3Qm5m?=
 =?utf-8?B?S3pUdnErRWIyanorTC8rTUFzTHNDWUpoejd4eXhXUzBzQzg1UDZHNVV6Mmp2?=
 =?utf-8?B?clFZbm91enBxcFRsaUhOd1Bvbi9vVytOZVRQTFlXejlHK3hLMGdYM1RlQ0Zx?=
 =?utf-8?B?cVJib203QzVLVXgwTzdtVklqRkcyMjF0SkZ2MWlLd0piVFNoSXNyQTVzRjlM?=
 =?utf-8?B?VTUxSmREOVFNK254eU0zdDFwd3BUNVc2eE1BWTl5UDZZOVNjR1BsYUFkNkVH?=
 =?utf-8?B?VW1uSlY1UTNhaHpSVGFHVklXdWFtZ01jS1pZSGtKRjU5TGRiL0ZoUjFEdExx?=
 =?utf-8?B?dm9tc09LOE1VUndNMHc4RFRhSFNJR0k3ZytPRWc1ZUFsYWhpRHFtY2pYZm5H?=
 =?utf-8?B?VW1CVUYyVFp5aHZ5bjg1ZkdSR0U1RWFGR1grdWp1bnFhblFwMnJYdWVEOTZa?=
 =?utf-8?B?c2lUMHFidFZMTVAxYjBQSm9JQWNBWVhONEdtcHh6K3M1S1ZmMldaUzVVb3RZ?=
 =?utf-8?B?V2lSSVNuNjJqdXQ3aWVFTVY4ZU9xdkVQVDhkQmZ2dlp2bTdRWm1wdUs3dDJK?=
 =?utf-8?B?Syt3WDV2aS84TGdpcDRFQmRqR21HbU40VlJZZ296QUVFSk4wS1FFUElONnNu?=
 =?utf-8?B?V0crWlNJVHdpMW1sbWMycnc2bWhRUGR4VTNZNEhaK29SSEEzQWhzTmR3cGI5?=
 =?utf-8?B?UHlLcjk2SHV4dkc0OXlodXdKV2JBMmJibTJVbjI3Q04zbUFQV1JYSTNUdXk0?=
 =?utf-8?B?Zmc3dUFwZkFDcGZ5WEFiRklDNmxtczJrTkhVWUNIanNxMzRVUGNleTREVUxo?=
 =?utf-8?Q?p633+AcCgTYkx/giBJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723109fd-8701-403c-50fb-08de74723ba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 13:31:50.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEzs+SXjS15UFqWfWxJjSqLDudbIvtYiCpkk/mQ3xNJwrQOApyvvIcWRWMS82M4A4TKxoUFXjrg4twi7ib8UAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4297
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzMCBTYWx0ZWRfX2j8NKYdFIRNt
 IH8fy564QgkkZCnA09zpdVJfI7WzuX+621MJ+LmriuNszaY+qZ8JVGKCQMvvWeO29ub59mNTGna
 kGf4KZbWkNjuH+WsXuNCtHXqGyXFoUojHcooPTJeKxSlki3Q1h9K/OJJ6vtuN4XMOZBk+4Ub3rs
 9SfSpA+DslJzzD9JBJQpS/uketusJGA2vbKGPD0GHlV8f7N7lYyfcp0PHe4Is0wCLwQMhYZQ0TB
 O2gFXIlXSi9w1IZMp+Qp1HJJOPNR5lDYOPHoCTTYmSkS7yjW9EkJcUC4aMPiTrsWDy4sbD/N5fm
 uynopzSpZM4C+QErGVDQo9K8hY4u0FRF2nssIcEQHSt+UdaixBrx47zvtS7gVZuwY1Ovl/LDwhD
 6MdJaEvXCcoHr6s4+lY0xatTWq3rUPLLWCynpyWIDjeGFXNRNuzgsMV86xXVrAdUBl6MfxOHz1M
 RxifA0b4NoAvyw4qiNQ==
X-Authority-Analysis: v=2.4 cv=a+c9NESF c=1 sm=1 tr=0 ts=699ef9c9 cx=c_pps
 a=nUtUY41U26iC5jD0qKn5yw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=gKo3r9lPQe9sujMFkigA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TjqFY0vfPTT2k5RlESep98g9o0r4AuF5
X-Proofpoint-ORIG-GUID: TjqFY0vfPTT2k5RlESep98g9o0r4AuF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BY1PR18MB6374.namprd18.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F15B11981BD
X-Rspamd-Action: no action

PiBPbiBXZWQsIEZlYiAyNSwgMjAyNiBhdCAxMjo1NjoxOVBNICswMDAwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gU28gaWYgZGV2aWNlIGlzIHBvd2VyZnVsIGFuZCBzdXBwb3J0cyBhIHZlcnkgYmlnIGtleSBz
aXplIHRoZW4uLi4NCj4gPiA+ID4gPiA+ID4gPiB3ZSBkaXNhYmxlIHRoZSBmZWF0dXJlPyBob3cg
ZG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQo+ID4gPiA+ID4gPiA+IFRoZSBpbnRlbnQgaXNu4oCZdCB0
byBkaXNhYmxlIHRoZSBmZWF0dXJlIG9uIGNhcGFibGUgZGV2aWNlcywNCj4gPiA+ID4gPiA+ID4g
YnV0IHRvIGVuc3VyZSB0aGUgZHJpdmVyIG5ldmVyIGFkdmVydGlzZXMgc3VwcG9ydCBmb3IgUlNT
DQo+ID4gPiA+ID4gPiA+IGtleSBzaXplcyBsYXJnZXIgdGhhbiB3aGF0IHRoZSBuZXQgZGV2aWNl
IGNhbiBhY3R1YWxseQ0KPiA+ID4gPiA+ID4gPiBoYW5kbGUuIEV2ZW4gaWYgYSBkZXZpY2UgcmVw
b3J0cyBhIHZlcnkNCj4gPiA+ID4gPiA+IGxhcmdlIGtleSBzaXplLCB0aGUgZHJpdmVyIGlzIGNv
bnN0cmFpbmVkIGJ5DQo+ID4gPiA+ID4gPiBORVRERVZfUlNTX0tFWV9MRU4sIHNpbmNlDQo+ID4g
PiA+ID4gPiBuZXRkZXZfcnNzX2tleV9maWxsKCkgZW5mb3JjZXM6DQo+ID4gPiA+ID4gPiA+IEJV
R19PTihsZW4gPiBzaXplb2YobmV0ZGV2X3Jzc19rZXkpKTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBzbyBjYXAgaXQgdG8gTkVUREVWX1JTU19LRVlfTEVOLiBXaHkgaXMgdGhhdCBhIHJlYXNv
biB0byBjbGVhcg0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+IGZlYXR1cmU/DQo+ID4gPiA+ID4g
T3VyIGRldmljZSBtYW5kYXRlcyB0aGF0IGhhc2hfa2V5X2xlbmd0aCBtdXN0IGJlIGlkZW50aWNh
bCB0bw0KPiA+ID4gPiA+IHJzc19tYXhfa2V5X3NpemUgdG8gZ3VhcmFudGVlIHN5bW1ldHJpYyBi
aWRpcmVjdGlvbmFsIGZsb3cgaGFzaGluZy4NCj4gPiA+ID4gPiBJZiByc3NfbWF4X2tleV9zaXpl
IGlzIGxhcmdlciB0aGFuIFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSwNCj4gPiA+ID4gPiBj
bGFtcGluZw0KPiA+ID4gPiB0aGUgdmFsdWUgaXMgbm90IGZlYXNpYmxlLg0KPiA+ID4gPg0KPiA+
ID4gPiBJIGRvbid0IGtub3cgd2hhdCB0byB0ZWxsIHlvdS4gcnNzX21heF9rZXlfc2l6ZSBpcyBq
dXN0IHRoZSBtYXgNCj4gPiA+ID4gZGV2aWNlIHN1cHBvcnRzLiBkcml2ZXIgc2hvdWxkIGJlIGZy
ZWUgdG8gdXNlIGEgc21hbGxlciBzaXplLg0KPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0
IHRoaXMgcGF0Y2ggcHJldmVudHMgdGhlIHByb2JlIGZyb20gZmFpbGluZw0KPiA+ID4gYnkgZGlz
YWJsaW5nIHRoZSBmZWF0dXJlIGluc3RlYWQuDQo+ID4gPiBHaXZlbiB0aGUgY3VycmVudCBpbXBs
ZW1lbnRhdGlvbiwgdGhlIGRyaXZlciBiZWNvbWVzIHVudXNhYmxlIHdoZW4NCj4gPiA+IHRoaXMg
Y29uZGl0aW9uIGlzIGhpdC4NCj4gPg0KPiA+IEkgdW5kZXJzdGFuZCB0aGF0IHRoZSBkcml2ZXIg
aXMgYWxsb3dlZCB0byB1c2UgYSBzbWFsbGVyIFJTUyBrZXkgdGhhbiB0aGUNCj4gZGV2aWNl4oCZ
cyBhZHZlcnRpc2VkIHJzc19tYXhfa2V5X3NpemUuDQo+ID4gQnV0LCBvdXIgaGFyZHdhcmUgZG9l
cyBub3QgYmVoYXZlIGNvcnJlY3RseSBpbiB0aGF0IGNvbmZpZ3VyYXRpb24uIEZvcg0KPiA+IHN5
bW1ldHJpYyBiaWRpcmVjdGlvbmFsIGhhc2hpbmcsIHRoZSBkZXZpY2UgcmVxdWlyZXMgdGhhdCB0
aGUNCj4gaGFzaF9rZXlfbGVuZ3RoIG1hdGNoIHJzc19tYXhfa2V5X3NpemUgZXhhY3RseS4NCj4g
PiBJZiB0aGUgZHJpdmVyIHVzZXMgYSBzbWFsbGVyIGtleSwgdGhlIGhhcmR3YXJlIHByb2R1Y2Vz
IGluY29uc2lzdGVudCBoYXNoDQo+IHZhbHVlcyBmb3IgZm9yd2FyZCB2cyByZXZlcnNlIGZsb3dz
Lg0KPiA+IEJlY2F1c2Ugb2YgdGhpcyBkZXZpY2UgcmVxdWlyZW1lbnQsIHdlIGNhbm5vdCBjYXAg
dGhlIGtleSB0bw0KPiA+IE5FVERFVl9SU1NfS0VZX0xFTiB3aGVuIHRoZSBkZXZpY2UgYWR2ZXJ0
aXNlcyBhIGxhcmdlcg0KPiByc3NfbWF4X2tleV9zaXplLg0KPiANCj4gV291bGQgeW91IG5vdCBz
YXkgaXQncyBhIGJ1Z2d5IGRldmljZSB0aGVuPw0KTm8uIFRoZSBkZXZpY2Ugd29ya3MgY29ycmVj
dGx5IHdoZW4gYSBzbWFsbGVyIGtleSBpcyB1c2VkLiBUaGUgbGltaXRhdGlvbiBvbmx5IGFmZmVj
dHMNCnN5bW1ldHJpYyBiaWRpcmVjdGlvbmFsIGhhc2hpbmcuIEZvciB0aGUgb3RoZXIgdXNlIGNh
c2VzIGNhcHBpbmcgdGhlIGtleSBzaXplIGlzIGZpbmUuDQo+IA0KPiAtLQ0KPiBNU1QNCg0K


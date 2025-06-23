Return-Path: <stable+bounces-155288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA331AE3531
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 07:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2674116C2FE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35021D9346;
	Mon, 23 Jun 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ro/CndgV";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PtopMFqn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1901D86DC;
	Mon, 23 Jun 2025 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657890; cv=fail; b=hTGc+daxem8XHWcWhPduNi6ZJf9uhWel8TVCSx3EDJbbXuDUeLc4X52k86pLpfg0nsnuBsaBgQkAbkxN4jy6FBS2FowW7vss+SmMkFU1xBBqEQUZHxPY1ppKv0Owg0b7ojAPZ8FFrN0yoZvfrZVNKO7vr/hGKRdyPTzxLv4kVXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657890; c=relaxed/simple;
	bh=r6ECp2/PrxdM4rNOZULA7D8Vv0gjuQ2g/y4G1uKNbP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qGSlGZ9iX4pFhcLAPWxIys7avVDQuL31mUHW5lTThhXGFpbbFJIlq6IuSMOjkE9W62utJ+y4gRazY8jiLklbBCLq4orzdz63k2XIrndeyPknF9d+NbGxzYI3FbtQbKOUH7gvxzrotS8w4mvblrMSfpruriEWUqN39ZTJAkfidO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ro/CndgV; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=PtopMFqn; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MLTRBK028964;
	Sun, 22 Jun 2025 22:51:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=53+1BzpDmjTyDg0GEzNjBkV+0fEzChHhZBQkv2fyCik=; b=ro/CndgVBIO6
	1Y1aqZAam48CqlJKjpWcTMFLKh1IRTYPEnY4G6MbZhHeZek5kYmXQsEmp5obujp6
	+oXYFam3p+wXcCLgE6h37xtavhFLyZQZsHIO6OuXSbmdVf0k+1QHaqarKOlKkwpH
	bAQlo24gbaVv5Joj4LgY1Bwou/9teu5MYECwjnpcsGHXL4UN03Cz2w5FPwyBcnea
	JuFFb8v136XyVEn77ENEsG0uKW3idSMZaPs1T6SCBzfYzSgJUUbPo/ZLN2kKYCJF
	ERWJ3Ru5VhZODAKWauCZRDgyN4uoElcbdpRVFbsC7EQ6zUzbSQwBA+h/mAJL3tLE
	Kxu/wzK1eA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 47ds9ybqaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 22:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhvL8RgoIaLMQyFEBEpEkGT0FW5Mf0By775VVeE+bNpijPeVT46TZJ2tONaEsnAfG2rr3tw8Gm5Es/TtaFVtM7nDNcELC2uo6EopBcqWtXgRFQ1v2rH9Yvhu7+MEEpNxVcndJgRMg/FCrdW+E+1LCz3uP0Xrk0UaCLHQgIL0Bsp0m3V8LW7K7c1sXdWHNSJkolbXHLrvZhZNgZ8iUcaYFq6W2aG4qlKGcqPP2K8NbKNgmHkgw+2UaXaFxW22oCfYcgj3wBncdr/VeKuwFKArM32YpWKTBjZV9xhOuLnu11F/TEMFhnfxyjzmX83gCiq1dgvYaQR7zyb25owhdyDKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53+1BzpDmjTyDg0GEzNjBkV+0fEzChHhZBQkv2fyCik=;
 b=NmaPQ64ZvTqkav17l8yh/cL2e10m1dS+o3PPLUpDTBkJlj6gsDEBMw5pWWDomkaxquyeJDZaJ3tDJ4HrK47OSldDi+1ZWRRry9464QLg9U6BiEck7hmnNvqvLJCNXQz2JoOR7fav1B5aVPJngsJdR4Fh67ly8aPb1fH+9XaQpZxuxEXB1LsUDga/oXBIVaf9yF4hEZ6ALGuIv6F7RNwAvLwYGKjoqjLXyY88Rf02P/rDbdMORTknvvUyJzQaquenoIdviCaR6+5qqGU+rTQ6PaWf9Azdmr3H4iLJ8sCz4emSbMaJPWgHULxUgVMMvKOQxSHPcFYOAMSr0oUl5kxWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53+1BzpDmjTyDg0GEzNjBkV+0fEzChHhZBQkv2fyCik=;
 b=PtopMFqnhO4SrJqefEjKqZJE+cLIkBl/IU4w9VzCNrT3W1hUdv+OdVVzbubwwuf7uo8dYeB4H5pemoh/WzYUt7EnnGpo3eMESuv7Y7AgAWWjC97KYOh3ERNUXk46Q0kfoeTYxkMWnfMIFMAKn127qHfgYDxQocf/an4qmzpe4Cc=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by CO1PR07MB11235.namprd07.prod.outlook.com (2603:10b6:303:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 05:51:08 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:51:08 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Topic: [PATCH v3] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Index: AQHb4byQPqa7j5J6MUG7SRmJB3iE/rQMxaWAgAN5JwA=
Date: Mon, 23 Jun 2025 05:51:08 +0000
Message-ID:
 <PH7PR07MB953862997AC245FB4ADEE60FDD79A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250620074306.2278838-1-pawell@cadence.com>
 <PH7PR07MB95382CCD50549DABAEFD6156DD7CA@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250621003643.GA41153@nchen-desktop>
In-Reply-To: <20250621003643.GA41153@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|CO1PR07MB11235:EE_
x-ms-office365-filtering-correlation-id: 5c97982d-3f60-4a64-e210-08ddb219f387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZxqVXp0+C00L0B+chLvTF45GAWJODU0gmJzKM7cq+52JnvD7b6lUyhsJmPtx?=
 =?us-ascii?Q?2xouTkp1zlS/jZuuAy133A5Hp9wMjx6XfhqA45dSYWKxQYvupQolrBFmZbjm?=
 =?us-ascii?Q?HuBjhRiFlJbYMFsUe3QPJhlYHfVVUgC02NMYiYBbmgl1RInr0QdDIvIqiXkC?=
 =?us-ascii?Q?lv+9h4Ws0kS2ASvY/yCCFZGxzMqF+Mq89Xi+FPXCQIMF7JxyqEFXfirRMq9M?=
 =?us-ascii?Q?42taeESmlSGaULz4E3u6l1z13jyAkWQlmguk27eGDstBrgqrbnAZ18Kl869C?=
 =?us-ascii?Q?8UGd/io7on8kvIjbgKN9x9jkCMJBiFrgqmIPBpNkHsj+o/c2A45dlbk1rJqr?=
 =?us-ascii?Q?RHKzAMqrwdx8HLt3L5cgKsDiklyBtMAcPNZLKaNaDG/Gq1H7FCNT5S1ZdkCY?=
 =?us-ascii?Q?JcDUTQaamxDHE5cq8e6gwfiZjnrZu9rrfwiletRnqpyKY4NVvEAXyjSZuWPK?=
 =?us-ascii?Q?Nf14fbImr/ABx8Yc34flR8qFST2ccdxceHNQK8OiimTpNdfOeQ0Dk3JEVyoa?=
 =?us-ascii?Q?FISvdlJMn+LmJqSNUpVETk+NAiROvGyUS1G3B/QxFEM5fCyJyFwIEQmhmlZ1?=
 =?us-ascii?Q?cwa9pEcn9EbW5byWVmIK7+cm7MrKGhARbhm2D3a47UWvDDmwHF6RbAeSTYdj?=
 =?us-ascii?Q?HQ+VcuVRALy7SNyzSdO35A/5dVelpeWOXcXlwHCcrPvk7lLAEcX8N+ZKGsrD?=
 =?us-ascii?Q?MtkSdQ/9z+6XgmNZ6PBrwWk8LNaAJYI7ekS5AXyz/8GwbXG1EdbF//j8YsrP?=
 =?us-ascii?Q?1so8bXGAgKok/mIHxaRNFU4xxrqBmPxX9BLm4ujmMiv3iCBEoOQE1V4QM3Cq?=
 =?us-ascii?Q?PBa1AAgzxF3EDA+5MEiUTR13RcTFfmxV4AV3YGMHQWEOtFrH1rYBJGyEoaPC?=
 =?us-ascii?Q?kWfa/geXwzmzBMhyqZKiE3Uov/LUo7zvmW5smwT2N9TmHrAZ+GOQopRWwe0U?=
 =?us-ascii?Q?ivOo4/VMWNMJ/+YRlMi5fIX9rgZ/Tq+wWmypaDV0ZbTLlhZaLcqGBwRHX5B2?=
 =?us-ascii?Q?uxF2FkwHt/oNVhLBpP01tfyc/8kVpGmjU/Dxjki5HuIaEkDbJlWGGGQCVUOG?=
 =?us-ascii?Q?zIi6WEVgAa6QODsYIkEDUktftN+tnsBuvSy7KD98xts/6Jjx6G3Q6C4O4Cxj?=
 =?us-ascii?Q?VWqR+WGQVvzjvEvHdkO16UzY4NhTopf1WmiFUhCcMz2t+aATxQ9VmbJs6BGd?=
 =?us-ascii?Q?UE/26967fJQ4WNhmBlCFn3g6r6xh6FvfMtAZ6ZxxSVDuj9nWzitIPsl0yyyw?=
 =?us-ascii?Q?3uYU0+tIEOVrVfxK+jVELcqHOHyvP74Of3nEy6PxFAoJewtOqymW4BpX609Y?=
 =?us-ascii?Q?yjh8q34H+55zFLAWi9hmmYbZEFwwXr3/fBo9k/g7UGcDJzbs6D8x6BOoFA45?=
 =?us-ascii?Q?l24AVcWzTH4nuC2dG+fgpX5zXwffX15gLE3NwTP2xhppP7f9PBfYNQQkmaGI?=
 =?us-ascii?Q?J51HYDw9kEY2y/YM73UE7HAiBzwv0LDTsQi1nbGTk4Sm/4JGqK0m3Ge4AWhT?=
 =?us-ascii?Q?y8yH9qBw3Mz1TRY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iwaEu+WqLEMqjLWPBcCEzBqFQVRlzOkf1oIu704OR7660CdC5VthXhc/P1il?=
 =?us-ascii?Q?OTzJh2rRnm6peWP+oJSjBptht4KLO8ojGeGPjeERLvv+9ooAYBSCsuT2U7fX?=
 =?us-ascii?Q?dJQJV54WvTBZDPlbTE5IhIiE9M0ulQ5kWlcWaoE+D99XDXspVGRJzkMMba6o?=
 =?us-ascii?Q?2OV7os+lXVpOaprWG0wCPxBylcbWwCFzSskOV14wH/pFBetsg1KxK0/gF7Bk?=
 =?us-ascii?Q?p38L/2Co7Fu9/stc2GsEeaQyDQ2Aj7HYHmAdCrSPJFqzVHtW1eiFNpqRvh+C?=
 =?us-ascii?Q?vG/CtL896o5kXFfnbM6WSxsmtuICC7C3c32kV81gl+2SGJNp6+JrNEtJ79pN?=
 =?us-ascii?Q?XlLVsBn8vAWG2//V35FTLidwQlXuI6RtI4fL+Bo18Q7KAmwkI5jFx2g4Kz8C?=
 =?us-ascii?Q?gWkI6Exzb2xd9c4qiEkjaYfymlM9MJJ6fHueRQq9Fys1o03kBIRx9vcGXeJ3?=
 =?us-ascii?Q?1I7mmQgwwQUYTw/MLJ8U12neWte1mxbJR2LJYp7GuYw/ff+0cSgpjhRfXRHO?=
 =?us-ascii?Q?dAVi2X18TDKgTRmFd7+DyQzvuQaO2uttESEGDdQ1kmn1zGl/mhDOAtZwWKPO?=
 =?us-ascii?Q?MPSMk8qQ4HomS/5DhOMpHSBUsYQTWX0A5vAZnerhgIxe11kMn8SdmAVQ+Yue?=
 =?us-ascii?Q?oifT1MebvMQIXWS3x/FzKyaPw/ualsDnooflYqdm3lH82Nq4+HbfTXVuUwdW?=
 =?us-ascii?Q?pB7xd4gAR21mkDvbPubv6oWQi/QVByA66aHeo4T8BgXiPBHBaTuStSEUmnMs?=
 =?us-ascii?Q?7sJBGBjfqnY3URcWbD3NFek3RLiA4CQ0X7dsIZvTU01F2Hy/y6y1KHHag5WL?=
 =?us-ascii?Q?3j2n/BQiUYvJUz2sWAf/dOKsUZD8vhLjre2yjqX27LhStT8FT/FrFYEsDgWg?=
 =?us-ascii?Q?37d7GlYw/NiU60DsIZbzn+mkoowdUSwgc6T2SvlnEsGoYEO83SR3hc1y0ada?=
 =?us-ascii?Q?i07fyRfOmePjLGsBb1L2mbb6YKRW9sXGNFzEDcTYqUWV+MUHLp+TjAd1JgrR?=
 =?us-ascii?Q?OOda4ieETs184gJMFSdQbY14KasOxCTG8yfnGEMF/OEZYu4fSbUTjUY0WDjb?=
 =?us-ascii?Q?YDY5xjy1eIPTdxYqVHLkeHPglmww+knia4caJhXOizjLx8A1ssXM36/477pR?=
 =?us-ascii?Q?IQp93AEt/WcNTMNou05W9hYQuv9xDeRQ75ebm4vnSVRWV6PT9zNTXbnBd3oH?=
 =?us-ascii?Q?eJctunCP3s4PwenRNISXikM+m+hfA+RIRfo7ktA0/ehKXmfhv+imo1nw/JDF?=
 =?us-ascii?Q?fQgwWu77ZFuytByb++03GE87j2v0EaKPMjeCFq8ImdrEKVtqzuTWnEjAwP0u?=
 =?us-ascii?Q?msGGwWSkeFdWuh7OS8gD0allfMoQqKChAiYWm7iEjqfOckQhwCH34DvXvphm?=
 =?us-ascii?Q?+ReMuatv0F0CSWsNAkPlmhMv+pPSMcT+LSW/6c4b7RKpiuTEThmwXb1kN4LK?=
 =?us-ascii?Q?5dtc88KUz8TXBBL5yfftYVCagZiy3gDXRGC7dmA6VntejwHFYyphc12N4QOd?=
 =?us-ascii?Q?TUJCRiYgbKymAUExc90fYjq6jqBOPd8Qt3WsZTs1xFz0zeo/JZaP1WTNpB4E?=
 =?us-ascii?Q?pfrM/qdVIPlw7sroxwxJYnq+Ks4gYfCI03RHc4w+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c97982d-3f60-4a64-e210-08ddb219f387
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 05:51:08.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wP8GspOpKUlednMa4ouAkXs/ElZ6P7EtXm6a0d+bFyeSr7vErI1wYVDisO5f5XKLUCvSo9boU99tHI4frGpH16OSp4VyoiemixkxE5r5qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB11235
X-Authority-Analysis: v=2.4 cv=fPA53Yae c=1 sm=1 tr=0 ts=6858eb4f cx=c_pps a=pfCY2Ats7XXgTBCGz+4jpg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=kG_ig2eaEDhO6EZHpVsA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: GW5rktK4tIT55ZH4WBBqEC0HTXnC1zih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzMyBTYWx0ZWRfX4x73izePoX/Z NIZjN+BvpY4TimFKHvMy1C/RSOtf5QsMYc3PGEzwB8s+cpNYeryAX32+GxXYDHGudoJ9yf1++EA Z403FSeo6sDRT1NLY+VkIo8RirrnvH95ZrPRpGCYnO9amCyqkBBP2NImglyoietvswY2BDgtiXh
 tLF7AFCvVhiO/K0EhV6LUrTSFusOGA28r2sBB+ByVlEIxkXK4dovrqW9fdnFyABZ+Eukuo5ruPi C48yY4le8nAm2xdlAddkCza62gnNIaZQUvySHaV3r5U3XL++XQkGwqV6kkn8apAwTD1xgcQnAUQ vBmeKHlmNr1BNPhZZJikXGya1TgvU19UT5Ia4aas2Tie3D01+8nQwxqZ0jYfiae55VL6AmJGyHb
 0aIKgXlMxkNdOJPmcBVW8EJBujjscsqvRQs/jbZwVuDD0pQCxY3a1MFlHUTpdS2hX0LTyn8a
X-Proofpoint-GUID: GW5rktK4tIT55ZH4WBBqEC0HTXnC1zih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=759 malwarescore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230033

>On 25-06-20 08:23:12, Pawel Laszczak wrote:
>> The SSP2 controller has extra endpoint state preserve bit (ESP) which
>> setting causes that endpoint state will be preserved during Halt
>> Endpoint command. It is used only for EP0.
>> Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
>> failed.
>> Setting this bit doesn't have any impact for SSP controller.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>> Changelog:
>> v3:
>> - removed else {}
>>
>> v2:
>> - removed some typos
>> - added pep variable initialization
>> - updated TRB_ESP description
>>
>>  drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
>>  drivers/usb/cdns3/cdnsp-ep0.c    | 18 +++++++++++++++---
>>  drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
>>  drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
>>  4 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-debug.h
>> b/drivers/usb/cdns3/cdnsp-debug.h index cd138acdcce1..86860686d836
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-debug.h
>> +++ b/drivers/usb/cdns3/cdnsp-debug.h
>> @@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char
>*str, size_t size, u32 field0,
>>  	case TRB_RESET_EP:
>>  	case TRB_HALT_ENDPOINT:
>>  		ret =3D scnprintf(str, size,
>> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
>%c",
>> +				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags
>%c %c",
>>  				cdnsp_trb_type_string(type),
>>  				ep_num, ep_id % 2 ? "out" : "in",
>>  				TRB_TO_EP_INDEX(field3), field1, field0,
>>  				TRB_TO_SLOT_ID(field3),
>> -				field3 & TRB_CYCLE ? 'C' : 'c');
>> +				field3 & TRB_CYCLE ? 'C' : 'c',
>> +				field3 & TRB_ESP ? 'P' : 'p');
>>  		break;
>>  	case TRB_STOP_RING:
>>  		ret =3D scnprintf(str, size,
>> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c
>> b/drivers/usb/cdns3/cdnsp-ep0.c index f317d3c84781..5cd9b898ce97
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ep0.c
>> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
>> @@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct
>> cdnsp_device *pdev,  void cdnsp_setup_analyze(struct cdnsp_device
>> *pdev)  {
>>  	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
>> +	struct cdnsp_ep *pep;
>>  	int ret =3D -EINVAL;
>>  	u16 len;
>>
>> @@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device
>*pdev)
>>  		goto out;
>>  	}
>>
>> +	pep =3D &pdev->eps[0];
>> +
>>  	/* Restore the ep0 to Stopped/Running state. */
>> -	if (pdev->eps[0].ep_state & EP_HALTED) {
>> -		trace_cdnsp_ep0_halted("Restore to normal state");
>> -		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
>> +	if (pep->ep_state & EP_HALTED) {
>> +		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_HALTED)
>> +			cdnsp_halt_endpoint(pdev, pep, 0);
>> +
>> +		/*
>> +		 * Halt Endpoint Command for SSP2 for ep0 preserve current
>> +		 * endpoint state and driver has to synchronize the
>> +		 * software endpoint state with endpoint output context
>> +		 * state.
>> +		 */
>> +		pep->ep_state &=3D ~EP_HALTED;
>> +		pep->ep_state |=3D EP_STOPPED;
>
>You do not reset endpoint by calling clear_halt, could we change ep_state
>directly?

It's only "software" endpoint state and this code is related only with ep0.
For SSP2 the state in pep->out_ctx - "hardware" endpoint state in this
place will be in EP_STATE_STOPPED but "software" pep->ep_state
will be EP_HALTED.=20
Driver only synchronizes pep->ep_state with this included in pep->out_ctx.

For SSP the state in pep->out_ctx - "hardware" endpoint state in this pleas=
e
will be in EP_STATE_HALTED, and "software" pep->ep_state will be
EP_HALTED. For SSP driver will call cdnsp_halt_endpoint in which
it changes the "hardware" and  "software" endpoint state
to EP_STOPPED/EP_STATE_STOPPED.

So for SSP the extra code:
		pep->ep_state &=3D ~EP_HALTED;
		pep->ep_state |=3D EP_STOPPED;
will not change anything

Pawel

>
>Peter
>>  	}
>>
>>  	/*
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>> b/drivers/usb/cdns3/cdnsp-gadget.h
>> index 2afa3e558f85..a91cca509db0 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
>>  #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31,
>16))
>>  #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
>>
>> +/*
>> + * Halt Endpoint Command TRB field.
>> + * The ESP bit only exists in the SSP2 controller.
>> + */
>> +#define TRB_ESP				BIT(9)
>> +
>>  /* Link TRB specific fields. */
>>  #define TRB_TC				BIT(1)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> b/drivers/usb/cdns3/cdnsp-ring.c index fd06cb85c4ea..d397d28efc6e
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct
>> cdnsp_device *pdev, unsigned int ep_index)  {
>>  	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT)
>|
>>  			    SLOT_ID_FOR_TRB(pdev->slot_id) |
>> -			    EP_ID_FOR_TRB(ep_index));
>> +			    EP_ID_FOR_TRB(ep_index) |
>> +			    (!ep_index ? TRB_ESP : 0));
>>  }
>>
>>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int
>> intf_num)
>> --
>> 2.43.0
>>
>
>--
>
>Best regards,
>Peter


Return-Path: <stable+bounces-195050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DDC674D5
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 05:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA958354C24
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CB28DB46;
	Tue, 18 Nov 2025 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WI9k7n15";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TZT79Ifd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A41212D7C;
	Tue, 18 Nov 2025 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763441919; cv=fail; b=SjwB8KxCbLTzPxtT2TNMBz/6YBBfoA8Qb7hFYLiab44LkHUxA0DQDX4mSBg8LW6b8g2MFeAkWcynpZPly6G6a37gP9ruGvnZ78qqXs9+p9/QawZ3+Xnjv4tYbrmcWRqxs4nujfWPQAepACiL4UZIyCs3zr87nsJAZ99UeYTsOgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763441919; c=relaxed/simple;
	bh=jR1jCzFNirxU3ueD9q9ChF6cZKo5+U1QBvFAaqEknhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nLrtu4quqV9DewXQ9y0S4wLmxaUO0Mj5wNeHrL+935vCyBTPIu6vidhEDC0wpDL3YLXvIX103T96qPBjKF7uP+Qap9SNPZx1PrVAMcdPTx8dDVgokbxZMviBNn1kWvCAFyJ6ScXaUlpgHiZBUfK+/8u2T9EFokrYj6qYGTYjmIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WI9k7n15; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TZT79Ifd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI2hGIY020198;
	Tue, 18 Nov 2025 04:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jR1jCzFNirxU3ueD9q9ChF6cZKo5+U1QBvFAaqEknhM=; b=
	WI9k7n15QyajJ4VyY6wWi105KuZGP+bv4VFbffkw1TcpIbFAcgBiHWqZlf5BcvFm
	4B57zg+G9HKrIfSMSOk30uQoA1KETJ3sEp8l8V8WB1ZmyqezcUMx10vq5aX89sqc
	lIaOheSBCom1urGinD0hip3+0cEStydfdHqeJkXd1kQ9e6Krkz/wSu037jcdUL0o
	0nLS2iGGSdkWXRhtBZr+B5AOEU8X0wy8EMo3N6DtCVuArjvjvbgTunrwHN8xkncj
	MVsB1ijT9x8C7t3xqudXOCKuz6VxnQfe8mMn9bB3xuAcNSCueCd1kUYP+uR0MVt/
	srraQYd1W3rvHQiBvJdRRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbc5ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 04:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI4bLtr039959;
	Tue, 18 Nov 2025 04:58:32 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyjx3nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 04:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VT/cpmAXR7ytgPM3DEInAkBrbEzzfmlippz7CCO6r2MgDfQVCzwAYu4rmIdUOIneNyWY5wtUGjmYNBL8nEPrYZWeBUsSTvAuaOp2nWfm7Mq5VkjpVVjyw1lFkwC6hLZxbZu8JABmb0xi9jMywUCL3+tYLFQ8klFjjOpIGJffywTU0g4ekWnlDSIvGgBc8gO616t05FkaUnCrJ1lqKW5DVqzk+cHf0bvw/lkJybwiTxT742UBSS6BK7vKqMbE0e0XY8ObeIEqp12U7p4f1l0AV1HC5n+JOCcN8Nt5APtr6r5/43q9uCO9wHLA58FKMrcJKdcnL0owmGx0v5BzOltOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR1jCzFNirxU3ueD9q9ChF6cZKo5+U1QBvFAaqEknhM=;
 b=mGMblmFQKEgcDzy9vOiUNXv1bNJ5aET6Jv/8GMfuLfzQE/zN5A61ZvylNkXtFJKuAxbyJI4rg7hqA6HwGqK2NCgB++L3LB6Nvhh/7X71ZSxmngfq8G/vbsixggSTP67C+5FVd8+55pQODR3v3rVACkyhI3R0RNaGXIBJ9KCaiOWamm4M/snc4OINnokJ7f8HaTmOLPRxWkcfxhtb1U3ouOCsdBToB2ayWObFpnldeZLUUkYFc+dtFQSe3sx7uMIk1GEgx/27X5KJXvlrU7ja40VkzmNBgTX+i1PumSVSxyxn5yuOkV1JULIqLshwERGtaO//Bw7EKsqmhXe4qgfMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR1jCzFNirxU3ueD9q9ChF6cZKo5+U1QBvFAaqEknhM=;
 b=TZT79IfdDHU7OSext6Fq3S9gZQhu87h+FCQDIil8blbIyQqdz+g9aQVxd5NaSsg6Npmk8AyEWOkNUCBuf9cewRptG0PL0FMOc2j8RrvCHD0No/puq8VQAKh71iWHdodndSQrt2oR6fHOzlk6lxgVWKuFE2F2TocIgdRxzyaO/4k=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by CH3PR10MB7742.namprd10.prod.outlook.com (2603:10b6:610:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 04:58:24 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::6ac8:536a:b517:9364%3]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 04:58:24 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Topic: [PATCH 2/2] Revert "block: don't add or resize partition on the
 disk with GENHD_FL_NO_PART"
Thread-Index: AQHcWC0EXEJKAooKnkemT7DWcQ8CSrT33tig
Date: Tue, 18 Nov 2025 04:58:24 +0000
Message-ID:
 <IA1PR10MB724026C01ABF778B9E9EA10698D6A@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20251117174315.367072-1-gulam.mohamed@oracle.com>
 <20251117174315.367072-2-gulam.mohamed@oracle.com>
 <2025111708-deplored-mousy-1b27@gregkh>
In-Reply-To: <2025111708-deplored-mousy-1b27@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Enabled=True;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_SetDate=2025-11-18T04:55:45.0000000Z;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Name=ORCL-Internal;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_ContentBits=3;MSIP_Label_f3e58186-1c1b-4537-900b-8707ad116850_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|CH3PR10MB7742:EE_
x-ms-office365-filtering-correlation-id: 7b66c01c-fd68-4f3a-ddfa-08de265f1a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-7?B?dEtoNG4wQThwbVpPZEN4RFdCaFNxSmJ3MDIyV1JyTG8zMUJKWEQ1NUtsTSst?=
 =?utf-7?B?RGxka0lKelc3Q2VCanpGbVE4RWJqKy1tWjFnb013Q0JDeDZCeHJrWWdrRVZC?=
 =?utf-7?B?NVY1Vml5d0JuTkFuZVhNSU9aVlJlcmR6Wm8rLWFzM0o1NzFhUXA4R0tvRGo1?=
 =?utf-7?B?N0J3eDY3UkN5Ykd1TnhINVQ0dnRMZHVBTmtjeEJZWlVzZFErLWJHWDZwd3Vo?=
 =?utf-7?B?Zm5XSndFUlRoY2FzQWdrTk5EQ3pnaVA3V2JnSWpoenJuU2NYczU4UzdGMElh?=
 =?utf-7?B?MXdkKy0vUFIrLUtmcC9QYlhiSkFiN1NaVzdDL0ROMjRwQmRiRjlHdzN6eFBh?=
 =?utf-7?B?ZEhXeFdsMndUdGZLWUl5WjMzMDhFTTRWdktnV2pPbk5EcHdmUEhGb3M1a0VY?=
 =?utf-7?B?WTRjcFZIVW53SlV4UjBNOUJiL0E4aFczb3FkMm1iZmh0b3NpeDlKUGI3RkpP?=
 =?utf-7?B?S3NKQ1cvUTBEaTlZa0xJWHQxYjI0TTVSN0dsbW9CSXBiMWF2Sk0vN3Y3U00x?=
 =?utf-7?B?aWxQTXYyWnNOZUxRR3dnVmtVeUhlRTNhMzZtM0UrLW9lbjdlYzdXd0hrT3A=?=
 =?utf-7?B?Mista3NxSndDay9Uc2JMKy05RUROM01NUHk5dVB3NEo2T2J0UVd0U296dWdY?=
 =?utf-7?B?NnMrLXk0OHB1eWxGbGhUTmxkSnJZOTdNV01EWEJHNkFNdWFRSSstajBsaDRj?=
 =?utf-7?B?NDR2Snc4bVc1VG5RMy82cjUxemVoTDVxallndktrZmlLZ0JTbDJIOE9pTzdk?=
 =?utf-7?B?Ky1PUUZKREh3ZlJUMXF2TFdDNEttWS8zYmlWV240RFZRNVowNCstVDlsTnMw?=
 =?utf-7?B?UDFrckxGVTBWNlArLWZxNmV4c0UxQzhuNm5YZ0JqVTJtd2V2SzR3ZnYrLTB6?=
 =?utf-7?B?RjJNOUkzaGt4ejFJSHQxMElqOU11TTRWS1l2b2Q0T2JFRkd5YzNudmhxVFJ0?=
 =?utf-7?B?YTVySDhSRmVWVVZJS3BMSzBTa0RyUmUxQldlUnNNUFlkaFVnUHlrWU5xbyst?=
 =?utf-7?B?U20zdHhrQ3NwN3lXT054QkRxbDRpTFlZMVJ0WU1Rb2N0eXZuUWtmYjBnWUZh?=
 =?utf-7?B?b3JZa3ZyZmdEbTlrYzVEM0tMQWM5dVhyOXhvUkQ1ckFtTkh4OWx4eE1MUU5E?=
 =?utf-7?B?R1FsamZES2RVVUllYlNadFpkYWJjdnlvZ2QzWkt0V243TG84YzhBdTlWblo=?=
 =?utf-7?B?Ky0rLTRFWWcyeFhSZFI4bDZkWXhzTlRpUEVNYWtHQWxnT05RVFE1M1RMeU5l?=
 =?utf-7?B?L205dGMzWUNtMExHUUphUUVPTnJvN0NrUXV1U082SjlQZnZPcUhhS0d5Vist?=
 =?utf-7?B?ejN2L0ZyUjFXRWhyam1wdVV1aU5vNzR6V3JBR3lJclVwRXpoajgyYXpyS3N2?=
 =?utf-7?B?UistZnBnOW9ROXFQMW5wSG9lNlpYWVI3RG5zZ3FYMHVsN3hjRUFncnZBeVBU?=
 =?utf-7?B?Q3dtR2tvTTE0RE9yaGZtSkNzeUgxZy85VzNpejQyTFRqRjE5TFJQTG5DRG5k?=
 =?utf-7?B?MFU1dnVPNmNIcThqSVd3L3BmSGZ3dVR2OTdQZGh0N1krLXYzemlHMUVoaE9r?=
 =?utf-7?B?SHQxenlhTU1IV2tHTGJOL0IrLVBkeThtUWF6V3NFOFlmL01jSU1DQWZCRWkw?=
 =?utf-7?B?dVl1RlVPVEF5UDZDcVNwMno3bDBjSndOWXF6UXVJY3JWKy04N2NiZzhsQXVV?=
 =?utf-7?B?YystSmxuL1ZxTVdLWTNWekg1d0tlSGZGRVJ1c01YblZDMWlEVjE3WGlLVmJ2?=
 =?utf-7?B?VlVwTjFkYWluUEhMZkVtWTRZZ0lHM0t1SG15aU5MTjZWUzVPYmJ4NHJ6bjRP?=
 =?utf-7?B?ekR3RHNFVERmaXg3M3IwbzZRbm5mT1pmNkg4QTJUWlljcnlDMEZxaGl3ekh5?=
 =?utf-7?B?WC84eml0cXdKMC8xdjhlaGdFTkd1c1kwR2w4djlBM3BsNjg0cC9JQmlvMGJu?=
 =?utf-7?B?RCstaHhEMystam1WQXJ6NTlJajBBcS9CS2JvZlcxT2xjb0JKVTg0eUZacHp3?=
 =?utf-7?B?WGhhNGl5ZG1WN0lCNVJ1SjFaNXVvZU9KSlNzY0VKWWNybWlPSzZwY2xmcHk1?=
 =?utf-7?B?eUVnU1M4b0szcSstTW9LNWNrR0NHV1Y3cno1aTN4WjQwSlk=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?bEN2TVEwSGg5STRjOEtOZ29CMzAwTWFJMVd5bFo3YXRpMW1UNmlEb290MzVQ?=
 =?utf-7?B?bG9DU21VdWRBUFVyZ2N6T0NSUE5Ya3l6U2JCeWx5MDBTUVVSMDlyVE10MWtI?=
 =?utf-7?B?eldxb1dUUVBaRTdxY0Q0d3owQk5KaHI0NVYzUDlZeFdFNEx0czJyNGVzUm01?=
 =?utf-7?B?aXVLZHB2aHZEWkZpbGcvOEthNWdOUzlaNUxFR3JLRUNJd081blh4Mnlsdist?=
 =?utf-7?B?MGxMZW5RVC8vc0krLTBacks4WUsxSWR1dCstVzZPcmZDcnB5eHNyTDBNSFV2?=
 =?utf-7?B?b1ZsSnJ6a09IZ211aDVwT2c2QnZ6b0hRUHpKeDFrdjkxSzd2eFdYV3hFSDNz?=
 =?utf-7?B?Ui9kRzZ3TVRDMWtLbjJsUUJPZE04d2Q0SGt1M1BXZystWlA5R0J0VVJ5Ky03?=
 =?utf-7?B?b3p6eWdjenJNcS9VTWRaMkV4WTJ1cW0yampSczZDWDl0VmpMTDlmRWtYWWto?=
 =?utf-7?B?QnRIS0FnTXp3WGM2TDhCVi9CSi9kYzM1aGxBMHBKbG9lU3gzZmphd2d1YkFY?=
 =?utf-7?B?dDZWbnI5Ky1qdDVaZnoyM0tjb2o5WTRLeGEyM2s0RHJaM1AvZVJGMFZGRU1I?=
 =?utf-7?B?QmtZTTZQcENkVnpZcGI3VXRKMFpRUHNaMW5xM2NkUGo1Sm1nZEFXbFlrUHpm?=
 =?utf-7?B?TUxTbSstMFNrZmM4bW50UktCcHpJaUJlNXJSRTJDZmhZZ3BMVWpwaystZ2h4?=
 =?utf-7?B?bGlXVFJsUTBqYmVFZzFOQVpIek1OUlBiNmNEVnc5cUdDSUxlamsvT3FOejdC?=
 =?utf-7?B?U3hGcUFhOWpiNGFoSEdvQjFiallyKy0zKy1HVVdmUURLelBFTDN5VTNhNGJZ?=
 =?utf-7?B?Q25oWjdHQUVaZ055Y1g3NHAwcFo1b3NtMGNMbTIxczRaci9wckIweGI1U1lh?=
 =?utf-7?B?NHlEaWpMbFQ1aCstZ2hHdzZWNTdjSUxEdkNOSUNqWTZ0OHBtQlhTcGdERWJL?=
 =?utf-7?B?NnVOUlhpMGUyYU1EM21mclhpTWRUTkhSaistNEg2U0h5TVJXSlhnVGJSWnRx?=
 =?utf-7?B?alhaRThKOSstQ3lOU09NTjh1dlZNY3FXU0lDeURCR3Jyb2cvb1FFYUJDR3FX?=
 =?utf-7?B?Z3lld3hFNExvN0JpUFRFeVpJNkVyblNVNjJJdWxSeVVtaUh0UWk3SHdTT2xU?=
 =?utf-7?B?T1VJWWNtQ21sWXk2a0hSMkVVRGs4T3FDdEdKa2c0Nk8ya1JJSjFPdnRxMzRI?=
 =?utf-7?B?MlllN1FwYmV5SGc0dldmQURwMEFEOVAxYm5Gdk9YZFZpVUhqLzY2cGNEOEhx?=
 =?utf-7?B?T1V0ajg2Ky1TbkhBWVRsM0hSYkRLQms3aS80aXFydEdlS09wMURyb2RObjFk?=
 =?utf-7?B?bHIyUlpDLystZ2p1ZFpqQm1mWllraUo0Qmd0SUlMY0VadHNDTUsvTFp0NnU3?=
 =?utf-7?B?Yy9RdHlYSCstZDNNSTdZWFVxM0FydERsUWwyeTdKL0VUd1Jkbmo5OGNQdmhH?=
 =?utf-7?B?TjdReFVGZTA2RlRWU2VjRmZhU1VuaFpCTW0zSEpuMGJ4NjVPTlF4ejNzN0Ns?=
 =?utf-7?B?YW9lb3F3RXo0Ullvc1crLUR2Wlg2TGxkSlFUOTVpV0NMaVRxSlNlcHE0aHl1?=
 =?utf-7?B?Ti9XL1h6cEpxd3l3cmE3ekVhQUJrVEVBRTZaUjNUSE9xS0EvSkV3Y2dObk8w?=
 =?utf-7?B?R21OOEoxSWYybU1iOVVNMjZEQnFGT1FhcWJNRndxSnVCMDBhb25vVlY5Yms5?=
 =?utf-7?B?Vjd4S05LN2U3TTFGa0FDT3Z2aVFPWFBjVU1XanFad2w2TCstR25zb2UzSWE2?=
 =?utf-7?B?SU1Ua3o4TUc3bWF4MHJVelIzYmp0cnJqVVl2YkYzQVJMa1QxNUE2eVg5S2pM?=
 =?utf-7?B?WmpjKy12eUZGcDRkYlFJanNZZG10S20yaG1lU0dieEEzMGgxV1B2VlNvTG1x?=
 =?utf-7?B?VDdoaDhMVGpwd0RYNHQ0aDdvc3RwVWNUWlpNR1NIVk9PRHJSQXhSelhtZG95?=
 =?utf-7?B?MTR1bUZmVUFFUTVIRmdCbmFrUmppaXlJSW5odmg0Wks0VTg3SWZYUmxLUEI5?=
 =?utf-7?B?b2VjZjVqWmtkbDJTYXZWSkVER2tXUnlGYi96SGlzSUYzUXdoREMxZVdCQUI=?=
 =?utf-7?B?Ky1sVWJveUdWM0dYZ2ZLR2ZPZTg4WUc4dDBIOW9KbkhUWUZ1VGNra3B0MUQx?=
 =?utf-7?B?OElyTmxJKy1zWnhsMGpRSTBTdkhMRE1DYktaZG9Hd09tWEVzVFVmS3B4a3ZG?=
 =?utf-7?B?Vno=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3V4p07rKehNFTskEclMNxL7hH3JRtwTrwsLYJeuVbDAMPvU9IavxJa/sMs4KWfonJ7UrL94O1cB04zHLCeOc2J/3cFMRG4bE6AFKIZpI7R2xhZYqUe38gABwxEiYrvJUPmAW8YZu0qxp3rj26UHa4+jdTfUDjwt9ea55xNuB7rq1S0ejBmpJAgqb0st4L1xQw5PA1xDKaZk6094d9zY/XRAz0JnzdLJ+qP/p/5TgznEEQ3s6m2riF3fTNBGTn0lu2MoETXXigy1Ex+X9K3L2zLQ5ctW8h4sH0T4x94h+9KjNEA5wrSym1YI25M+Q4vFP7ZtQTI6dsnDEDzJw5pNCfwNyh74Kd7B0QcgQESjo08RO4iiG1e/oC3QL5wUy/Yt8LwG2seVrcYS3SSl2vmYrjh+QTMrAmvbp2ewKc3Nwp5pA9ec3Wv+7yPaDk9xHhMG9nDlp4AYPm4fokLOXnmg3s9VWtqqiVx+CBv/TsiIaELvnhHmYqxJTdmjfuTH3w0TWQxBc85uLzpGxT5wxOOoagPqoOPW0hoYG83t7UxSvakvr8vzkijX4upQJmX6sI3tPZn++kazrI58QBPMqa10upbohg+Dn7bdJeiT5WF2NRLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b66c01c-fd68-4f3a-ddfa-08de265f1a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 04:58:24.3043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6i34mgimosaRsgo9cdAdJgNFmXwvNE3AuBPFyp9ZpYf9ZV9IV43Uw7QD/Qu3CPHtUQnsx3QyxRw34/xlKMLS6EWW9GMD7QJk8R9Q22/c4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180037
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691bfcf9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=WJJPNcJBAAAA:8 a=mQvHCebiAAAA:8 a=MnuRmBL2WD6gd_GmWN0A:9
 a=avxi3fN6y70A:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Orvq6HXzVWGNNdQUjdZg:22
 a=wsrb8zZI_WQ3QAEBCXTy:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: vDYbTXKjPfrZO84mC5xMECUHy9pDdKXd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3fbtyQZF+E1i
 p8yvySFXOFyD9Un2RIpvT0amhxqHvgZJ5M/Lh/OLxImZZe/JnkbnyqPtJxM9h963UNIBkjOsWff
 zC1cdlIx9MacaEj5uJVX4lND/GMw6ACmj0gkRq9FO8T/BWy7BiDy4fP7C5NyXn5XiTQR6/zPCQi
 kYsaKhrEI7AxYU0boqTkAZVEy9AU5liJD8Gv+ziXX1ZFi8f2DuSwlIQlQPAwDXOuebux/6T6+Cd
 ZJr/cw3cnpbTZd4Bw+Km+EaLgACgwKrmNp5wAfODTGFZ16n7jWwNn/Ez/1ZHFMYrxPYSJQlywnh
 0nvquIzcGyBPBkbdFJ2LThGL3E0UwRICFgYAXXgRtvdA5AU/IqYXSiI+f69ofxMAqapxXWPDdIS
 QX3RFEA84EKtLvQOk9a+Qtt8J2SZ4pXSuzK0GlJnjD3/H0Qv6DY=
X-Proofpoint-GUID: vDYbTXKjPfrZO84mC5xMECUHy9pDdKXd

Hi Greg,

Thanks for looking into this. This is the 2nd of the two patches I have sen=
t. The first one is +ACIAWw-PATCH 1/2+AF0- Revert +ACI-block: Move checking=
 GENHD+AF8-FL+AF8-NO+AF8-PART to bdev+AF8-add+AF8-partition()+ACIAIg-. I ha=
ve mentioned the reason for reverting both these patches in the first patch=
.

Also, this is for +ACI-5.15.y+ACI- kernel.

Regards,
Gulam Mohamed.


Confidential- Oracle Internal
+AD4- -----Original Message-----
+AD4- From: Greg KH +ADw-gregkh+AEA-linuxfoundation.org+AD4-
+AD4- Sent: Tuesday, November 18, 2025 7:15 AM
+AD4- To: Gulam Mohamed +ADw-gulam.mohamed+AEA-oracle.com+AD4-
+AD4- Cc: linux-kernel+AEA-vger.kernel.org+ADs- hch+AEA-lst.de+ADs- stable+=
AEA-vger.kernel.org
+AD4- Subject: Re: +AFs-PATCH 2/2+AF0- Revert +ACI-block: don't add or resi=
ze partition on the
+AD4- disk with GENHD+AF8-FL+AF8-NO+AF8-PART+ACI-
+AD4-
+AD4- On Mon, Nov 17, 2025 at 05:43:15PM +-0000, Gulam Mohamed wrote:
+AD4- +AD4- This reverts commit 1a721de8489fa559ff4471f73c58bb74ac5580d3.
+AD4- +AD4-
+AD4-
+AD4- No reason why?
+AD4-
+AD4- :(


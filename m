Return-Path: <stable+bounces-163690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A775B0D7F8
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B4B189433C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E4288CA0;
	Tue, 22 Jul 2025 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfK4Dqkd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X0T+4kUV"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A63286D6B
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182796; cv=fail; b=ZrR/SXvTViLGt4U6WeeKXh22rHpr78jdvJvSVrJAaT3ZUMrvF55npfUkNv8GstRjX0gWuENhlPD6xvCMPtGSLha8vnOK6v7hwZGTg7bWr7VzDkrnbOlBheEuSl6gSZKV+Vwe/7ADr5mvELDvRQoN173+s/yFnL8HTQdCsorxiIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182796; c=relaxed/simple;
	bh=WYcwuLPnWNKRVsO6VMzPraJ2oooRnWSFdOdFhglrMOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoUHZCsmnYBGme/0SrusenT+1RKJBE50m1KCYkS7dztdU2Ig0yHtu3sCr8sDUgQOciyk1nZoxmtDq9xLEXPMZ6V96MrpKn0YXI+dVVbCeRDfVQksIQ0sc6VyKMog1Tix1qOuhdxiqWM0svdmLfry5skIdshmGzEjIZ5ECC5ksgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EfK4Dqkd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X0T+4kUV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TC7u031671;
	Tue, 22 Jul 2025 11:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WYcwuLPnWNKRVsO6VMzPraJ2oooRnWSFdOdFhglrMOM=; b=
	EfK4DqkdJzQV+2ECCia1sI0ezWNWSRRx8+b2mEFQzDtgryOgnBAcYYJxgy9z+jnG
	mtmMaXG8nZzITVy8E6oVCvZ5FHuvNDlwPqbb4msOZHM3G0c37WPN+bNOi2H09mdl
	bbbBPYaELYMDAWWjsVj+NR7ShjEdypoiHGff2ITM33S2oM4UQ5w1LZeZfFrNnrUV
	TQlHD/yIC6EP0JZXvKv19Zso3TAjYiaKiNQClujGiAEsBWuLIPxrM2dSOtuK9q4Y
	D8l1TvqQmMHqTksBIjwkqPrVSkMvvc/9IBGCS1HUox1Q3HxfoP2NhIrs2efF6Guy
	siIUnISJOzmi+Do6eyhwAg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576mvvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:13:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAa3Ud011010;
	Tue, 22 Jul 2025 11:13:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t96tw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:13:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EckHnDb7aFCekZNd1asv55JLHwplrhSSMPT4ljZuaUUS5gtl8FuHo4LiSB7Vl0VLqmPYD9Uf01b2qafd9YNEgxoWa/QcQZPC3s+fSWdjRhgYyKXSDL9STaT/x8IKJ03mC0BJ2E3YVyrbPYRcP/e+vrZtTq/+c8iyWd+eDtBLXNe7eOgiQfFWRqlW1zLIS/BY4SxOlnh4K6MgrsYpRqbYRCpMpRE4Jz4vaVSht9u9D33FG0TXpSXC9lFc80s/1Pgu8cRHC/d9Yb8qq1h3VEa5M9w+EFFyvWw8pTWapYb4MvITPzKYirTWYTGJW0n16mAadITJTWq0T5XTJM/85M97kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYcwuLPnWNKRVsO6VMzPraJ2oooRnWSFdOdFhglrMOM=;
 b=qr0xy7qqTfEImFBDDJdRIYyWjr2+OYGOiaDs3p7YGPpnwjNXGpWXbcai4MkOyrF04tx+4oWuVLADSl92biwwb7C1hUAIR5/E5E8zHnaSjzyvGvc4/cDthAgWbomzAppax6x0MdRd+hHnwCVXGW89IdBI6AKGOUAlT591fNbytdMQqONtZ5H/ZgKas6j0+MwthbBvJnPBxNef8+KOfEzfiJdzML6PlRmKFfZnEu2tjZ9EKv2qUIuRLoRtlOO0hLO5HQpFT2qyZfc9cm9zUToO5FWMTLOoEeJKsC0X43d6LOILsJtHCJK1nPI5EzS9/51CuX2LGMLKlFIoSakKTPAgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYcwuLPnWNKRVsO6VMzPraJ2oooRnWSFdOdFhglrMOM=;
 b=X0T+4kUVE9e1vHjAB+xxHDPpprKvlhT59Zvpxk4Jwg2yMNd57d2VMqGaJbTjThSd4PGRN4oOdHwG7KW8nli+5v7wUlZ2AznERdQRr97dI2UJYwRose288PffnXBl6EP6useWQrIpGr9e4obmMv4R1/XkHCY3YMhQkhK/ovga7iQ=
Received: from CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18)
 by DS0PR10MB7408.namprd10.prod.outlook.com (2603:10b6:8:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:13:08 +0000
Received: from CY5PR10MB6012.namprd10.prod.outlook.com
 ([fe80::192:a20d:4346:47ae]) by CY5PR10MB6012.namprd10.prod.outlook.com
 ([fe80::192:a20d:4346:47ae%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 11:13:08 +0000
From: Siddhi Katage <siddhi.katage@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [External] : Re: [PATCH 5.15.y 0/4] Fix blank WHCAN value in 'ps'
 output
Thread-Topic: [External] : Re: [PATCH 5.15.y 0/4] Fix blank WHCAN value in
 'ps' output
Thread-Index: AQHb+u4sflrVYZijDE+reB17NZ2VEbQ9+2jQ
Date: Tue, 22 Jul 2025 11:13:08 +0000
Message-ID:
 <CY5PR10MB601266A9818ADA77134550EB8B5CA@CY5PR10MB6012.namprd10.prod.outlook.com>
References: <20250722062642.309842-1-siddhi.katage@oracle.com>
 <2025072252-urban-triage-41c9@gregkh>
In-Reply-To: <2025072252-urban-triage-41c9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR10MB6012:EE_|DS0PR10MB7408:EE_
x-ms-office365-filtering-correlation-id: 0eb10e5c-d854-496d-b860-08ddc910bcf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pwL3EFCsPVE25210theEglnbNQ7R6XEd8XpKmm9AYEArrYYYTAjsCH8Hpjyj?=
 =?us-ascii?Q?r5t9FvLO/mMpJcGxfCZyn3bNh0Bp8K8w7nFx4tjTGvDz+7hMcOO2kv9ef8F3?=
 =?us-ascii?Q?vsq6hZjYcvtxKjCZAbqqkXlu99krskLG+NGukCj9KaCZpJwin3ZfUFDU6Yjm?=
 =?us-ascii?Q?S3buVY9RD72c8eSHoYaQfiCPx1/S/0aYsQ8KfEeuaCiPpPxP5ZsvGclWM/Cv?=
 =?us-ascii?Q?p3Aias8cXyOflr1hYFJqVJQaQZ4Rt0m2Lxn7Dt/WJjGaXt22vmLslNPvGlge?=
 =?us-ascii?Q?No2gefudMFme6frvLQIJeNXv3qdiuPtpPBa+Y1OmTP2LTx620j6Mh4vjChvF?=
 =?us-ascii?Q?GqQU2lkngNoG7LckqRY8QofrWxiKueCofEdZdgbwiM+bt7r5UnNneHMdAQpC?=
 =?us-ascii?Q?vvu/zGUidHiR4Ntnkx9m3xmv01tsu9c3qZy1RH7bxVx7w1tOsveNqhuY4JkF?=
 =?us-ascii?Q?4I7Mb1zzoWFQbvcJNnRHvg7wZJQDsILEFJXqkX94yalI1lWR28vlmJ+m470k?=
 =?us-ascii?Q?Nh4pjj7ADvEKhZ3zeQL8QZ5CNZpagkXMhdzypvoAhL3RjSAg4plXpaVleksl?=
 =?us-ascii?Q?ZwhXFV6bMMlVXwC9xgti+V84RE1bAWbAo6h6WNgnM+RxVvJgXX18TK02GBOc?=
 =?us-ascii?Q?2SQksxI0Mzp2zs4SWJ81PCkh38ibggzJcEqc2p6vDVPhLs+dirNFPxsdGAKJ?=
 =?us-ascii?Q?y2IyX5enDFjR9jGmDIsdv8/7wNEz7lRi75S6zp/lVLWqxH4eOyABu9DAOblT?=
 =?us-ascii?Q?+8VEL9Pc1KXz1mAiYATHqql/z0nArl6M2h6spRnl3RMxbkDTbSqOSJw1ZTqP?=
 =?us-ascii?Q?8tx/17HW3SbiFEwzKTvhFcBbbHfyr/n8qyZhwjzpFLM5qpmvBtCfvQeZ3T5j?=
 =?us-ascii?Q?xmFiegCfBmYe0PIu1Si7UJYYMssN9JZ+YS80awUIymSA3izKCWHV/X6dtID9?=
 =?us-ascii?Q?Jvz/XjLKVnFy9uueD31Um2cPONyYAqn95a1wqeM2H0cK4xpp5icBkvsXsvQU?=
 =?us-ascii?Q?1aqt6zCfm309I2S/ecTpxGN2Gm2e3x0WK4gEMj5uxkO5FSm63BRVtl4RVPfl?=
 =?us-ascii?Q?Vd01mfOFzhtEs6+zeZpq1IzEORUKpaneFDvk7IjzpCJyd4QYS5mxFyny2cTQ?=
 =?us-ascii?Q?2aepvh/hpI3WF2AJfpy4rLqMP5jhrjru1JYvWzsFxsPSSnfTg6/aJCNnD7f8?=
 =?us-ascii?Q?oc/Lw5uE4RAEEjvs6M4Abk7ATC5mWOUdKtW28WCC8Rpib09EjrUdQPsgwVvB?=
 =?us-ascii?Q?r+j98Col00BaYMcHFmq8apk3FiBg9M3Kyu9tDyELozXbapl3e8i3L9YHJndE?=
 =?us-ascii?Q?qqQoESNx+P2APc7Fdu4BrnC8qGlSEbSLXwyjlLIzhhkFeUlC3x2oPcT3+EM1?=
 =?us-ascii?Q?wBEO3mCpBhxBeG2Bvtnuzc3p8/22kUueBEneGgvO1HMht4WxyfIpfNjlypL3?=
 =?us-ascii?Q?kQ2r4VMGzAhUjpD2mbr8vfO9vGpRQql+F9Dc5QDmiEubviR3bddvL+Oyibp9?=
 =?us-ascii?Q?PRMoaoPjmlKxXf8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6012.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZzxprPAufQngXHN1aoXc0K3vHVnWli5RdOCQRwVYf6M5b27wkfvRlIeuXs/G?=
 =?us-ascii?Q?ZVMjyqmat+yK7rS0GXuiKmpv5JcbksjehvWuSk3iql6HStZ+IGIQVZP2CP8L?=
 =?us-ascii?Q?mMyWMnQ4zWGs31F8VGMp6r9yVuufldq1vlNxn2CMuBMEiwgo8GYMUPqxtjzx?=
 =?us-ascii?Q?IbRqcLTfd69FX8DHDfmzGgew2844jncJoULhnEoYYJ89XRjvH5oeHaWBu/2Z?=
 =?us-ascii?Q?yu5GP09gefjnTsd7CHqSXzLnwbBT6i2m78ExtiqBWGhr0cN+gYtf5Aw5Lvm8?=
 =?us-ascii?Q?ocmDuzQ/n0Mt8Hl67Zj44Hwsl3ByzFn5N1q8Rv/BcknuaRg6JtGkdJ0uzlp/?=
 =?us-ascii?Q?xjl8rZcYABssTnvNElSJkKZond+2btqmTvxkFp/mpdx9YeLikkV8MfH2ygsk?=
 =?us-ascii?Q?ZUCgFebW7QCsNyeRzM56Qzo838Rv6VuQaQART3mUfiyhzRo1s5Bs0cBBfvb/?=
 =?us-ascii?Q?hTQhdgPgTtaAEGyBhhItwu9yyWR7BGlXA6bYRrXlXezM7iEXE6QLc/F+Cs1b?=
 =?us-ascii?Q?hK+5W8fxguTnzrFzel3Q8tNTd/yfGAt+PdRONGi2vsh8j0KUbKycCR0EJpBx?=
 =?us-ascii?Q?5VXgYOcWa40ghaXdgs5dzDEFs1IHuJPAskaVgPYahY+RuMH+D5GBUEgTvUyO?=
 =?us-ascii?Q?tm6EyhMa/F9CSDEatGYV8Euxf7hFkJ4MxwUWyuzBUXgVbC0bSwWftgF4vVuG?=
 =?us-ascii?Q?LrNVmbTSjkzB9MqDmWKpBszK/TPp7XvM4zOQuifDTz9vP/5i0OKiHD2S1aWa?=
 =?us-ascii?Q?/I+F8bJxLuPCm27phX4n7UFa7e2RchaWUMnKtYFYD2WGFLvcPYXx1RB8QYHw?=
 =?us-ascii?Q?kFWUjUEcqRLmda8qJKnvFW1zGHy4UWtD2jKJNVug+X5MLS0MfIafiW0vKPNk?=
 =?us-ascii?Q?+uAv7h0Xb0zWOFmRWdf7xQ0UHlBe1ZGoH4K9FMm6G1t4ntufHXd8Qb3H0lX7?=
 =?us-ascii?Q?xgPtNPUUeGYBiwcXqIeatrH86i42eWxE8gDZCdMW7WFmLimR3o0XBE9EU6xr?=
 =?us-ascii?Q?wfMIbk6nhGSqh5uS9ojxwwO9UvKwxcrlcDUIApkI4wThCWHRBr6W8AdX1Zie?=
 =?us-ascii?Q?xFxS7A4XOZtQIjC0axcZypX4+q3P6fA9j5KQpOuE5YmrgazciFpcywY86mIN?=
 =?us-ascii?Q?pqpOXOdu18ISpUFLPNyPViPSo3UQTdD1Xx55iI3iVpIZ5VMyFgLeTt1SBk62?=
 =?us-ascii?Q?LSzF6xXwpSA4M+4ODbaxOrum3rrfi5O7/e4BH0ntMH+wVWh8P0GkcFWMv4VJ?=
 =?us-ascii?Q?yA2vY5mGG2ydTsIjtv3N3WEE4Bo/NNYzflUMX8riImH/cLcJA4FVmH4Ly6hx?=
 =?us-ascii?Q?Z4NOKTa5wmE0KMIomzmtB3fLpSzrCNYpGGKuWO7zBydfnkJ73l3VcsZ+v5Hn?=
 =?us-ascii?Q?+lXFc6BmihIz0+X5krwYEd/Foh5x8ICtzFAtenjLyEbKgQ7y4da2Pfmn7Iul?=
 =?us-ascii?Q?HS8Mv5R/By06NO/SdZYjKoTec93rpEH1d5rzG5yMYj8mZgJKlVcIsb4mgy+6?=
 =?us-ascii?Q?5Lin/8DGneUVuRHqT22tgSz3UFXZy8OmabwBaZCo272E3ernCmGujE4lDp4+?=
 =?us-ascii?Q?iOMKvj2X5c/7pLgixEQ8vRen5fX6uYtZxqQUaMbj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LozsaWPQNquqW4MG5Y0O8sIdsd3MknjW91FikdECdXz4pbITYIBla/MtK9ByqAYRd4dVTqW8Jy0pduwvM/Mg5V39ZXzmwr4NqvqfbcMRCGPpcWK4+sMnuP7DsxLDePnq73rB1ff1nZ2MT5K1aMafhq+LKQXrrSIGo8uBV8ICOQTryg/vTkw7WNnc8+TQb8jcuvwiNUlwzD+CJ5lJ3tcUbY8sfENLZt4oUpSrNau8YRe1A4yP3h5PuHaJhiI6315vXs3lK3W2Pu55NNVTQXYSu2NnxN+7olNiPTz2OdYxdBnSgy4+ICyknx7JdSi0Gwwfs/BlC0gc7UFksqyraPeH9yqB2fHneS7C6dSaprZEHWfFkagqk47j9OSlkA+efsD5/ycJ2B0tytnNg1J60wJAJOo/Rbo/0nkobxDQigYi6XKp7y82xDe6asiUSsmQ7EKFSkxFgIaaYxpVJZPOtzocv+UOCQLghdx9BIXUAmW009kM9yEcAgkdeE71SJQZZE8SHl0WeoyIX1izQTrXyU8W+uuUno9H5UnKsn4dTO7H9UYJzaa4ydBDwa7fcBa8AK3UIWfv/RgmpCILEfnSx6an1BrYhZWigNiJTHKMuAKCmlQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6012.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb10e5c-d854-496d-b860-08ddc910bcf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 11:13:08.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xrRT2ib2OttN/vx0ZUpaBJBMgMA2WO75gW9RcQWI9TEfPRhNpjDvcYeCq63fs/6IKh5uODgwOTh80CskVTc8kkNZ1sOjw7GC2tbNZ96Wsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfXxxJdzcPQnmP1
 daHM01gZ+kwq+yu4a7DDlvkOAXM4XW9n9J9Uwt/fU5ZOzHn5jF6/6vaT6V+jPnXprljBhcXP/cn
 5OpBR4RGKHKU4kK59lIen+qZ1XMTa+ZEbxHwnqyEdqnNqtXQwYLuxHz66xNyELJm/i8QN7E7kNv
 bsHoTnmjjao4Iwn0Q7paSa90P9EhY/h0d1CHTq+1/udCSBaWBi1/wN231oDxkjL91mDUgla3bng
 TeXWgoekRl46nYdNtdB6qV0i89vZEtBp9Qu56jR5Nh9zsDn1NZstLXg4ythq9+p3FiOJG1W0hyr
 TdvtswVoF0ryNJQ/G3Fd3nTjRxPS+P5ACr6ObGpvn60le/HOlMAmCwRyMuAB4hwgfpu6rYQ4XNd
 dT3g1+O9vLnUith8MTwCVlsnqwjlLKkfOK6JVgS6CPZFTSruq5ykX4BHuvR9daA0Xnt0RBnA
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687f7247 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=9erGk1wPk7Tfc_DrizgA:9 a=CjuIK1q_8ugA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: Y3K1wsuon5MG0LS6SD_O06-izyzzkDzJ
X-Proofpoint-ORIG-GUID: Y3K1wsuon5MG0LS6SD_O06-izyzzkDzJ

Hi Greg,

This patch is already present in stable-5.15.y.


Thanks,
Siddhi.
-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Tuesday, July 22, 2025 3:21 PM
To: Siddhi Katage <siddhi.katage@oracle.com>
Cc: stable@vger.kernel.org
Subject: [External] : Re: [PATCH 5.15.y 0/4] Fix blank WHCAN value in 'ps' =
output

On Tue, Jul 22, 2025 at 06:26:38AM +0000, Siddhi Katage wrote:
> The 'ps' output prints blank(hyphen) WHCAN value for all the tasks.
> This patchset will help print the correct WCHAN value.

Did you forget to also backport commit b88f55389ad2 ("profiling: remove pro=
file=3Dsleep support") for this series?

thanks,

greg k-h


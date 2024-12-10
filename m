Return-Path: <stable+bounces-100490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587B9EBDD6
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B311916406C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6AD2451E5;
	Tue, 10 Dec 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kusttdKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dopXldjr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A32451C1
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869744; cv=fail; b=CLydf9JdBP5+B9Rq0DgGmO8kHVJQz20WVtxW505A4D8fTBovN6mNzKTK5TDnhgWcZ38xXAZRiDRoM99mIA0obgmyH16B0ynJSC+2bQUKtVRb/1QJNQnFp4isVW4vXFEBCwQ3XlFLT38Du/61Jcf7nxugr9wFPQm7OL/3vvfKVLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869744; c=relaxed/simple;
	bh=7u/y1UNb0goK37rQEOwY/3QD2tbg9Pve8ihDGUvCg/I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CBGbuTF9uOUx/fsjqEx3S20JXSZJ+8eMlJCVEz8KxGFTGhWu7MYjLDohMAFNlEb6ciipid0HGTDt+Za1mhndV1k6CS5vRdSbSSdxU+lGh9aa0fGgbCg+NOcxj4fPrHRpURA2Xye+mHQd24rWtrDfLakOmbccX5LTuB60p59u7Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kusttdKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dopXldjr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BALlucL011280
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=vf236
	6aIXkdxGSGInNnZPMokd2xJMbIN1fD2WvcfYWo=; b=kusttdKPH5m+0CJ9wxAuY
	7FAZ6TwEduuveyiE6ajSPRvRHlePvA4KaACamgaYfnfhL7v92SbXhajaeialCt8G
	5iIaujzm4S0ePTMIRiLjxn9urKy6X/ysdQKsXuJ+Cg46ivGj4o8q0ALIFFcGTQBH
	3q0Nm0xyLKx5Zbjw/4xhPTRgwLwUOTunYvJbkit6bPcjEPTNUm/Daepl9jJTn1uZ
	O6CVP8ok6UI5MpWKZ1+GMai5gNuoY6Nw260gCCDVGUNyCim0uXb37PFX5Abnzqk6
	GBIIcc1KRVojP9fbEeGs6UV6DCVevUpi4hcTwYECoXjgkXeZuYljUPIyeAMQRT9F
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt775u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:29:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BALOU62008669
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:29:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct9066f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 22:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0GzkocOxJoR4yIPf7cn8kqly9gPwemA8O3N8FNkdG7N+xX9KX/0iF685AIoDJAt7cSIi/GwaTG1OkThPVweqnUiXl7TJAGJYnttqsrq9GJ4X5/vrz6UGR36wMeVTcqLHthV7Z1HOuBhbEV/MIXkDh3WDUf/leL/ddya4jX1NLtC6QnU/pXR7Y4PFMKP9OwHld5To0gGfN01+b/BAFGj6o8NpEsQ6S24+yKmdhLhl9rZ9Ksh8uJbv9lPl3etWrtWt3v/UZdxVtB8mkd4vIc9ur/ovzmvVgmo1gr0RWwY6hILU5Rt2QAq7/4s5g4qayH6QvuLsZ61Qmf98bEtvJQlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf2366aIXkdxGSGInNnZPMokd2xJMbIN1fD2WvcfYWo=;
 b=D+/ggcJnbkkkXPvAX2iCAXibyfb5HmHncwN9Hrkh2CTD5vs/4kqKwvrcdAUhmOxsI6BvvkAKUuvrIZyBNkXRBfX5RUQLiMGEklNQzDOXnl3b6KYafM8MBdFU0JIBivpOzUHBT374a0ziMiTDa1BmlV8+24BnVgaWnsyVFq3iWnX1SyR0fHRG0JZHWzd4A95tDp9ElHv00nBNdyKd2bsfbZ+rgP83Mo8tUsq/khJ38zxX3ev9OCXSYyC59v++O0Y5G7rGL3TnfS1sckaaysVqmzr1YOrVCszK59cYcpdF4cGWbpRiEcJlQZ3dRZH8B3S1LEWcw+RwcshcqxEBq/IRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf2366aIXkdxGSGInNnZPMokd2xJMbIN1fD2WvcfYWo=;
 b=dopXldjrJJBvsut94TeAElNMqfQuEB6NVMlsguldIBzrZTKep4CER3TTVkY8FhJuY2XtPHRMp2Wno1A8wp0qi3f6MkpMlzFWet5UQmSzRtPxsBCsVAOmJrJCsTJ2KmLMNGp9Wi5kxuMpudkpRETk9N/cyMKeYdboNcnbrm9U6+4=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by BLAPR10MB5121.namprd10.prod.outlook.com (2603:10b6:208:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 22:28:57 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%6]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 22:28:57 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: performance regression fix in nvme backport to 6.12.y
Thread-Topic: performance regression fix in nvme backport to 6.12.y
Thread-Index: AQHbS1LmuShlCIESWE2L8ivaxqa6nw==
Date: Tue, 10 Dec 2024 22:28:57 +0000
Message-ID: <1DB6C887-2C97-40C8-8C8D-0F38CE68AC0F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|BLAPR10MB5121:EE_
x-ms-office365-filtering-correlation-id: f73c6532-a7df-4bc7-5af3-08dd196a097a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fuC3gWupwNmgsV7yG9dsaE7EQOUkn4gtHn+q1ZCcGKmE42k2bOqJV3ssCFVK?=
 =?us-ascii?Q?x0ehmNHK9ynMKN/REyon2208DZuGTXn5ocjboX2FpiizeNkQw0OjKfcoSq7o?=
 =?us-ascii?Q?6CM53LPL027VXDesgmwUA9LvqvrDu+VerDdejsIyAljaWYvvMHG8L/WKvCuJ?=
 =?us-ascii?Q?F/iFad7iFFV9+rcFs2ZcCMR/jUWD3KBln3w7gqe8ujAp4bbYOR0PFfyBk3gB?=
 =?us-ascii?Q?j26yQZSk/5KXYSqEz4VDs3Kp8njfDbUubF9toKNYqwt/kVbl018Ed2R3orF1?=
 =?us-ascii?Q?xNGfwioNxvwT2/ozYdb8d6Oi43vmEfBl9MWi5gxMn4NTwuGIEYyRpFQh/Nx9?=
 =?us-ascii?Q?cDQdmJ7vHSkPnwjBler4u3upjb12CTO5OT2hiEytMan+FnVTwLUAwJqbN2lZ?=
 =?us-ascii?Q?R/ZzF0PxN484Ham5CnaUcavrBdkEJxVi207GpOvPK2CWEjZ1seh194bTNmPv?=
 =?us-ascii?Q?3NEwtH2mbIEKPcJxgza8kTQDbXp1QQVJWKQH7BtQxeOLItaaF/iI0vIrKjl7?=
 =?us-ascii?Q?tsNu5NajNQ+ZRrtaYhIZ4PgeyzbUNua14qmmWuedFKoj5WVnuYKaKdMxETRi?=
 =?us-ascii?Q?3xkwkYy/dwN//9GjGXP74jQsNSO1OZ2nL6Qn7gPJ4lM2KE2tskQOa/WMG0ha?=
 =?us-ascii?Q?PqiSrDg33udxbortB8ASpFMbNDRCazMTPzrZmwuDfSbIsH8j+N5LUQ8YS2F2?=
 =?us-ascii?Q?r+iipPYvIgl/uT6AaFJ0fXC+nmKI+aKibZXaGgisfi05ig76Cpgivuu3LFoT?=
 =?us-ascii?Q?h0KlITRBuFxocFHplLVHUiyLqnbyEjHRVGafDvqHnZIWB41ViKLBvsAf/YSb?=
 =?us-ascii?Q?J4314VbPkUwGqmk059mRs0qyzt6JhhwIcyAW9+71k7A8BniRX/5KgOHyUZdL?=
 =?us-ascii?Q?ul+UYCKCN9UmpygfRE5Ti1nMrYpzqhAm7/ul4PguqHQl14Gr69aw2HY4aK42?=
 =?us-ascii?Q?IYuNXt2lEBkAvt2kDrsu4Z8f9+qNS+eUH8ku7BCQF+nXDRaMJ6o+COsbL4Xl?=
 =?us-ascii?Q?W3bqBe78QQ2whNMcvfoXZsTPvLjlzuKDPbn2NJ8xb6J7eBrzynbDD0n3FcKz?=
 =?us-ascii?Q?DIrNgwaTIA28ki8OsMtHkFXyDOcVsSOBaiF0CFO6ueGYzqYJxWG15RrGs7dG?=
 =?us-ascii?Q?WoVjkeaAb2ViPXaxGi0ab7hnYiNdXnrNLqOr59+yFfo+DB/LpkcCG1uvguIE?=
 =?us-ascii?Q?Ygt+Qca5GevTSCmo6ECPOk0gKOEaNi/+wKeDOXrsPT8HKu59MxDly8VBKlVj?=
 =?us-ascii?Q?KXdHNO5xEWTrRQruglJ5pIUJklUA/j+VSYZEZxNiWB5R1IofFY+qpScEUWkS?=
 =?us-ascii?Q?PeuDgm/ih+/2JKtybkulpVdy6n96AiCo8Jt6H7KsnG/bOZyP0tg7gRzJMa3J?=
 =?us-ascii?Q?HfPIeigLFkCswzyQ6/T9/bsvOxdwOSFHYoJoki3HxuTLGNsuww=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2rqs1BMoMLaHS9ngf/jOsBG2pjJefKhwsWSYuOQ/8GcQtsI1bWCQvseM5aIu?=
 =?us-ascii?Q?utS3ISv1lG5mqn+EymVrgQQ/ISyyTSYlPMR/0veDbg7bCtVd2TSsiDmxzNWQ?=
 =?us-ascii?Q?CHAf6CR8QUzz1RKbdGoTpLn6Hn7sgLhswWeV289uUD8tA9RiAHaTwKhqBwpW?=
 =?us-ascii?Q?W/G7B3spQ7LaBfut1gDDWS3ehqMW6ilaItdCQG7j0sqaRPvSrXX5IgEV5JKV?=
 =?us-ascii?Q?Mnm0VEpvdRSjd0X+xkMiasOIrwXJoKp5kF9mVi6NNoCX+MYTNYgTMdSMFbbh?=
 =?us-ascii?Q?pnkFOgwOOIQ8tNI/YUrx4dcLBCU35iugsQRzy2IJfZ3iQUiL1xBrWTNWtRpS?=
 =?us-ascii?Q?xb+wFINagIRLgffWinJXyuGjF8vWp3NVdXWs+Edma2KNF0Ay0b5iM5hY4EPB?=
 =?us-ascii?Q?stFLG475YVcB7X0D1o5tYBae/IoD648RQNjBPpZrAyIhnswWsn4gcmTeJT51?=
 =?us-ascii?Q?2RSUy/4IH52F8+axfJYCs32XcmIlt/PTn6BaomhVw8N8PA418onisIIo6H4/?=
 =?us-ascii?Q?/XU8g6GW8CqlLJ1erJGGgZwMBLK4x9uBTnKk8gtHrqdS+GKc3bAC2mBy+mMd?=
 =?us-ascii?Q?MUodeNxA4o8EpFHDXJDi9aI/mpGahpIOIPLDUSVABE8/DgjaIMivhOkkxf3q?=
 =?us-ascii?Q?M7/47ewojDle0GbPe7l10fVhOgmUQEmM1u13E+GViq4MguMe1NTkGsugQpzP?=
 =?us-ascii?Q?C2cssW6u7ugR7vfVqH9MTHpyeYw9QHEphuaHHoy8Uev1LZF63mVsaXReEyFU?=
 =?us-ascii?Q?ODCR4kBrK6e2qtYCDmjBvRs/BLK+GNYVUy1lNqe/OSd7jOR1tGjcYwkKbSVu?=
 =?us-ascii?Q?gxbzWvo47Y2TOPSJWJeb1qiUCmgd98fy9LkRoEn/Rbwo1WjD3O+jvqWILoij?=
 =?us-ascii?Q?NIWXSRZQoZhYZMODU3UV5d+RX+CZFtwC2d2WY5ZZsNRCi5T9vEpnCK8POKVV?=
 =?us-ascii?Q?AqwpXsBYqW6gZWvd7o1A49uHr/JFhtjFwfVU25oABzj34MJEIuBYNSfeZbUN?=
 =?us-ascii?Q?i80kTPsIewHLPVXzVj3HS/7iq88/OgKspzg2PzLXxrOarrkuGvBeBa7MwzQ4?=
 =?us-ascii?Q?nON0+r5oOLMKkypf1iEb5ENPyCK3K2jdDWnheBc3CpzLuijo3yr8aKqJqAyx?=
 =?us-ascii?Q?ToLiQnhR3TDmfW4ib/Xx2Xhjfm87+0Du7DBYYPvRM1VOiJMeR11cXTTRM31B?=
 =?us-ascii?Q?J/5Td7Q5xGVoARXPwFTWpeOknxn3MxY82Buxrcina7ZsdS8XpSEZYcMz9A5C?=
 =?us-ascii?Q?txmP1sNA1vYHdEu7dGdlXoTBhA7w6eCyIfsWJHqTUW092Kyxw7jr6nQIbDdu?=
 =?us-ascii?Q?tDJ2MYb5SKGwFMY5rn/csnuiAGxH0w+vT4yxjhntPt7GNH6C8BL7mw18Mxma?=
 =?us-ascii?Q?xE4Chw6mpFu7YbTEM1SQked70WUbo69VxGazRbAKJOA5BxARyhokLZ74znY1?=
 =?us-ascii?Q?4PLqt0EPGATBzT2ywoqsqmR3egvxhteUm2jQVwKa6FShWSJux2l8BbDuk/b5?=
 =?us-ascii?Q?cqU5wyKzQOU5AFdn0sco+UGYmiTYVUcqFwd9DPKAnttox6LMyBLsFfBMxlyw?=
 =?us-ascii?Q?yZo6cxivY8zqRrv+laZG2TQoJHHS7pnCPux/E7TFvEyZKujZB3rGWiwcIVqV?=
 =?us-ascii?Q?cnlhr1hhX/GDd3lA5v2bvnRvT/9fcSpRALJ+cmyibuQs?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0CAD6AC9E27754FA7E79D60E4BC0B8B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kmj3xNr4Cvh/fpNvb9bsEtXkmoYEwUmODmrjvYItPjA5//6b3Skr+na1ktHRjI6Em2QxNeonprnSwLhjc1+OOPhF+fufYNqGJ/Ifb62pyGyzX9hMRSC3wCwpy0S3609HArLzTU/32ZmY1/6Z3xRFQTalupmCg2EiaGsIMCigxT5M5iC6gqaZr5Ee9HzZTD8YGjOmGKyOrM8pnfujOIQfoUULRoIQAzybY1S3m6jadXYcpl6XGjB2YPXI4k7mI8mXFV0mEawNWKsBvLrS31VZPZ3vRwzseAZeLz6T13Gi3nA94q4fZYFuPZJfbQ+PzBm2+yWfaJJSTR04ySXhZYqN2vJf7MOB9QNPRL7hluHU4vPdI1aU5J+4xVhGQJQMb7rlMpM6o8jLvcELHwVIOR6k4oqAAjbhGgjgGPIGm2OZWFCJX89p5bbdPXs/LXAflifrE4+TNkhClo2PBWb/aNKzNuFua7Eiw5BhfxNvdbYXNdm0H8XdbiBr6mB0dZpeEhuzeMxEPM4fgIr/OC6wihlg3T95UQJA9NcZjPaD6aOAJjKshubffAQrn/mQv38P0it+xyNxQjccjRwqFUa65qH2cqcvG0g5mhQc14VTDjmONPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73c6532-a7df-4bc7-5af3-08dd196a097a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 22:28:57.2483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zutovbvjlQ19m3pGXiwjMNGe1dEGe75MlJOiWt8yhrgbXzbje2abOto9RdOQiMpsmeeuy6ljKcuSwzJY4aIsizLkvW4X5FzyZt97U5UhLgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=771 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100161
X-Proofpoint-ORIG-GUID: AUhzA8RVsw7JRkArHPsUV1YCfkeTdlMH
X-Proofpoint-GUID: AUhzA8RVsw7JRkArHPsUV1YCfkeTdlMH

Hi,

Could you please apply the following performance regression fix that is now=
 in mainline to 6.12.y stable branch?

Commit Data:
  commit-id        : 58a0c875ce028678c9594c7bdf3fe33462392808
  summary          : nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DS=
M is not supported
  author           : hch@hera.kernel.org
  author date      : 2024-11-27 06:42:18
  committer        : kbusch@kernel.org
  committer date   : 2024-12-02 18:03:19
  stable patch-id  : 7975710aeefd128836b498f0ac4dedbe6b4068d8

In Branches:
  kernel_dot_org/torvalds_linux.git  master                 - 58a0c875ce02
  kernel_dot_org/linux-stable.git    master                 - 58a0c875ce02


Thanks,
Saeed



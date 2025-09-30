Return-Path: <stable+bounces-182857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02685BAE4FF
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19C537ACBC7
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FF238C29;
	Tue, 30 Sep 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lSPKXcd+"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013086.outbound.protection.outlook.com [52.103.14.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614620FA81
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256916; cv=fail; b=eMxYV42gfkZBMaacjG/uVUGRcMoJiM5amaRRguF4S+/xKzWEJtxblPgKyhjpYUqr2fPuzEsS/NSHkWMCFrhNniogH2bCP9TVUpPm0SVZqoPuK6+jyQGUyfIjps3DU1lVFaKuVVWRpdwfCi/5O3GlMgqM/TpTXJM2Qxr5FJFmgTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256916; c=relaxed/simple;
	bh=KL35s5lZeRyWC5wR8yhambil7aiee3ZembDwB1oTQuc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WJXY6qrCHbHoxbQgwaRZZv7IMBbVEZ2fYsc0bar86z2YkBGjqINwzN2C3rM4w7dx07+8h5eFXI1n3zbPvXuN6Vlbp4pYLbAp16wzSbw6P+4LRn6MVHExGKj8Hp8LxSt0Crj+PV5KPwVNsFIDGWy+XMoLmfqqmCFI6S6+vYAlxbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lSPKXcd+; arc=fail smtp.client-ip=52.103.14.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxhDhJEFrgPRqE6tlpzb0686inqDZz8CKjsYIHQMMSt5pQnJNMloDqg0UqhWKXjro/t2+Ej53yVDHfAa+oesDpvDRFeIYTH5UJkPZnvl6a351LIidjFV+XrvVqATke93hzGNQEGwTGfbxw2rdEECYNcEFOnOKZk1+Ii+b+RrNnEXVR+lsTxpXs9w6r7lYZk6CjgZSvqa7HNs90mis8SqaGrJGoL3LiGNUw407tXNTHMvfSdsCNSqpygdPfp86KavLbITrM1Wdc5LQ5KgbM+fuhk2WbyD/wHLElRnwRHFZ2KDJ6Z2YRzaHlJRkZbE/TF83EP/s/MkNO3O/3FzWZHqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL35s5lZeRyWC5wR8yhambil7aiee3ZembDwB1oTQuc=;
 b=J9xIZRVGquBpCpvP1XZ8/ciBKs5ft5S6jE5kWxeHfhQxRP+Bm5lHrB9ZRKPZh0qvQ0l0UXE1u0RLTZQhmwJLfN+emoALfoTKcUvkeiUUO9i3Ybk8UKgVDFVEt7clijrMX/3aBx6I0J22GSqoO+4zVPe5C75tXCpTs6LcOMgUttkMXChvZvtm+w2UT97IdbhCQ08rhyy0R8JAXGxBu7lnCmoTRHz3Kxj3LruXjshrGkJkhr341azjkqJ9aE2rIFiZi4jRzeawjnemmaSXU8g4P9ZN+0GAd1Dxj1vDWK9QL0umdB9z+DbRjLiLOcwzd0Kyam7gA3xwB8HpvKaDqmQ9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL35s5lZeRyWC5wR8yhambil7aiee3ZembDwB1oTQuc=;
 b=lSPKXcd+PK6cHWZu4PgLUTt/q3dplztJITS38X3DJ+zJU4q9z3gZHIgaJIwLzALA8dtF21lXphBY6mOMYQhvugPamgYy9sMxoccNqlh7yIkvLsYx9xD8B2Hm7xi//FvN++I/QQlLbnFrLhXC/hlsrVmmA3AFZ6JF0eoS8S4iMtt+JWq0UUSyUl8AP2RLsoKjJeDQrtoGWnYn0CaIpoLY9CyDmaFauxWqlyFTQ7n87cKHvAZSzEZk3t7qYzdoSinilakPzLq9Y7M2t1bio0PWAVNwNj1EabYUrm/wVHbHSpKRiTwZMAD7CfR7KZg6DZOTsNmMPvgUDE5XwqvdAwdB5g==
Received: from BY5PR04MB6376.namprd04.prod.outlook.com (2603:10b6:a03:1e4::15)
 by PH0PR04MB8228.namprd04.prod.outlook.com (2603:10b6:510:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 18:28:25 +0000
Received: from BY5PR04MB6376.namprd04.prod.outlook.com
 ([fe80::42a5:b39a:f00c:cf4e]) by BY5PR04MB6376.namprd04.prod.outlook.com
 ([fe80::42a5:b39a:f00c:cf4e%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 18:28:25 +0000
From: Brenda Wilson <brenda.prospecttechconnect@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: Executive Assistants and HNWI Directory to Enhance Your Marketing
 and Networking
Thread-Topic: RE: Executive Assistants and HNWI Directory to Enhance Your
 Marketing and Networking
Thread-Index: AdwyGI7ssIZJBT0lQfioe3cxYwBItA==
Disposition-Notification-To: Brenda Wilson
	<brenda.prospecttechconnect@outlook.com>
Date: Tue, 30 Sep 2025 18:28:25 +0000
Message-ID:
 <BY5PR04MB637612305678B7AC83B8D625941AA@BY5PR04MB6376.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6376:EE_|PH0PR04MB8228:EE_
x-ms-office365-filtering-correlation-id: 29a6ee4d-2c8f-447f-b984-08de004f2504
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|12121999013|19110799012|461199028|13091999003|31061999003|19061999003|440099028|40105399003|3412199025|102099032|31101999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ush0z7phSj4hoNIeaFQO0JZ3Xb+x7VwCoSUZIp8CmMq8xNQYhTA6o8FdSu?=
 =?iso-8859-1?Q?pHFcKMWfTUM6ArYpBncnLc06BP+hmi/bXr6ndnnPLDcgL4XlgM/ZGiokEP?=
 =?iso-8859-1?Q?bmcER4suzr3eeH/vOoecy0h46O9/wa8Dzsa+1rqnK03WOGSckgaAScENq/?=
 =?iso-8859-1?Q?TJ0H5DIgYr82OTtBo+i9IX+DLh/KrohmkW8ij7mXlJd71+fhINjWFM/GHX?=
 =?iso-8859-1?Q?iq1RQK7sG5hPH62bOk2RNnmpzHfeKrnteWaphYfW+FcO27iP8gbz7IVS4p?=
 =?iso-8859-1?Q?wPwBIiitutZMY/+h15okmBPap1pla9/VmaZt2czTvfMKE8RVZkoO6Qg3Ys?=
 =?iso-8859-1?Q?MFpaTUUgtqxFTi30OzZR4of+ej/ZYLP+LumFVBl5dYBMVnwfcaY/eNfk2n?=
 =?iso-8859-1?Q?11Hergr6m7MpnsSetCPHOt8sUozuUbVjgdEt8tWahNz5xgT774MGr3gZDH?=
 =?iso-8859-1?Q?YvfRW3rizHdE5xXYXOcx5npsIns1vZzrX3miKP426oL8J/wYfeweKlEtiN?=
 =?iso-8859-1?Q?LQ0lKAStxrEWXP7dxvR5LZ+6opciEL8oU0MsnrFOJyc9ZPA+ZLwoiftrG0?=
 =?iso-8859-1?Q?1XPkWeKT9FRTeTACBu2kdJX/RT3xUmVPjvJmr19RUN2hR2K+4TgLVLDSLi?=
 =?iso-8859-1?Q?ppsCaXjO+HOdP9elvyt+F46Eu6ijpMlXjMWE7bQXHK3hJgTL+Vfkqc1pFo?=
 =?iso-8859-1?Q?c6yBCc4RXYRr0dM1M/wc7EppMq/japDXUWhqLfOyYV3sxQv7sSqfgQ1dz0?=
 =?iso-8859-1?Q?CshlvCiFyXg8wnBL9iS18KAyzSz7A6U8sEDJ9roGa0mrNY4F1FV0mQyVt4?=
 =?iso-8859-1?Q?6forTCjZtRr6R9Ugt4pVSbFUGs0diKwsD3Da1X8xf9uzX/lsamh9sKV8QC?=
 =?iso-8859-1?Q?6B+ESJaHzQG6wSFDMxhO94fdj/ktlUO+vfUhAL54ejbBr38Gc8+tW9R9Vh?=
 =?iso-8859-1?Q?pppmPHqhFCpz6jxkxLx3FNMRQ6jLXuqNqeP/RS8OvIqUrzulLGv4qEoji5?=
 =?iso-8859-1?Q?09/v+rxW5nSOETwg0BTepyJq3w5kdSuMpsKU6aBeOCxtlS5QhRO5y7Oer2?=
 =?iso-8859-1?Q?FiRV6LTyMb0ZYIqGflWrwDJP0m4Z7Xlo23MLKdQ4lxPOVJbhKdI05S+HCn?=
 =?iso-8859-1?Q?ZlR6dbK9A6v1kfO3sJovuWJ+rIGtYttcAaYn8B9GgybAfggaatlHcPImTV?=
 =?iso-8859-1?Q?KxwZiMPwdPj1sCiuJupjim+erHuF4AsAD5TnztG+3EXvUe9zTFTpJUmLuJ?=
 =?iso-8859-1?Q?qVib8tk7tOfHRFkSVNWiOypK0Xk/X1XMLPLqbuG9A44As1/E5aB84BzLp7?=
 =?iso-8859-1?Q?Bm/EDjj3b4vgpnbSSQaFJTXqJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9b78sLYoTc7qzc/aTttSLAYpePKB3QLDo3w2SoahIdcQo76PS7oJZO1Ho8?=
 =?iso-8859-1?Q?8eNPXTDmESaZHB1AzKtA7mHJL715U34Y3yG8/P4ijDkrP8mUHh/+rQka3Y?=
 =?iso-8859-1?Q?nLa4wNmSqQIZaW5fJcn1gdMmtvJsvr0j0g3MgBF9/nGHLK5GRRMz3pTkOo?=
 =?iso-8859-1?Q?4f8rAVafoq/SmIebg5TsiE9qIq+YulrG8sQAb/6jNLbisNGIIb9FdDFlKj?=
 =?iso-8859-1?Q?XWkRi4t24RbEpDnuIaLABTu2jUuFmarcqjceYdgtn5wUey5xCwytMWMNYU?=
 =?iso-8859-1?Q?b3oHYmYWigx87KJdG5Dlcp/WaTqdZ4bw4HLPRlfbcmIieZeEVBeGTyYSkv?=
 =?iso-8859-1?Q?OtoCAoHh7cWzb7a/LnOGW+g1XXYjiUT2oCD+2klBjXg/DFmj62TEeoOmaw?=
 =?iso-8859-1?Q?Y6jC8MIATCTHkO4xkbBcA7VbesVwcXRpmZw30mzumfxmwh7zRuxSgtFNfX?=
 =?iso-8859-1?Q?yMlHanBrmmj8DQrBK2Ua+TRV25sbd0y2OGlZ8sZ/tCB2kc15/bLVTcPPDu?=
 =?iso-8859-1?Q?dVH/daTkaRWa2SOQrQscvmZxK21a6DDuwfoCsgLJQuF79oGpqqmgUu/ADC?=
 =?iso-8859-1?Q?QbuBQRl8raSMfok4cVyEhBYO457un2E+InCPwRWuTTHAXN952lMptrJ8QE?=
 =?iso-8859-1?Q?YdsPvS3uf+A7j7wWq63fb8eBUOf85+jWJGiExAEpaW2oQOtDHc9/mJTUE8?=
 =?iso-8859-1?Q?doFCN1UgCKZHhAsQenL5XBnC3+BKPZT+e/t889Mf8whuHmDytpCB+PgNF/?=
 =?iso-8859-1?Q?aT5NJfvF1r5nTZZMnIchVT/i6BngsvVssVNHFGc92VCWL0c6kyl6cdezga?=
 =?iso-8859-1?Q?AIJhj1K0WxWgIfLyGfGK4xpaUu+13ckO7xEeZSbKWphkid0QkiIupwMuJ/?=
 =?iso-8859-1?Q?2P4rbO6AXDkL32+P469sud72rUO3snOHDj/WTlm9nM1w4hOJbAiriAl0v5?=
 =?iso-8859-1?Q?Qr54clnJNZP+xASipYJX/2X6mhDDPYjkFtbRltt+zw0BejZ+fDFByCMCdF?=
 =?iso-8859-1?Q?wFGQ2ZvbW4JhyCTMiBrqH4SxbHtG9iMYwg8vM2h0czYG8bcV5/U/gvoiOt?=
 =?iso-8859-1?Q?0jcf8dRJ3hdGuJc8uvOE4UrMuJqI0tRc1iySIXB08lKWuMwHrZ/vByKOQt?=
 =?iso-8859-1?Q?NPZmJn0GDqBhY8CP+67+UoYWfy2iBa9voJqGuibIOjjQH0L4Rdmw2uChZn?=
 =?iso-8859-1?Q?9tof+W0t6QTyXWBV4VCfuv3WLueYYgFUutq0cp0lVRB5vFBck0/5/fcEH3?=
 =?iso-8859-1?Q?JOzTgM43M/22K+qX9oDp7cq5ezDYtBywvuXq75gZYffb+h/iZGB5hUho1U?=
 =?iso-8859-1?Q?Hucg6SgrksKKRzCWfTd9v6JA35w7bSfSQUtXs77nMBdkLFUAej6NKGroaJ?=
 =?iso-8859-1?Q?SRvEV5vzZa/DPa0cOG9ZSbLFGbRx9LQQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6376.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a6ee4d-2c8f-447f-b984-08de004f2504
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 18:28:25.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8228

Hi ,
=A0
Hope you're doing well. I wanted to check if my previous email reached you.
=A0
Do you need any additional information regarding my previous email? If so, =
I can provide it for your review.
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails
=A0
-----Original Message-----
From: Brenda Wilson
Subject: Executive Assistants and HNWI Directory to Enhance Your Marketing =
and Networking
=A0
Hi ,
=A0
Our verified database enables accurate outreach to Executive Assistants and=
 high-net-worth individuals.
=A0
Executive Assistants (by region):=20
USA =A0=A0=A0=A0=A0=A0: 50,000 contacts=20
Europe =A0=A0=A0=A0=A0=A0: 15,000 contacts=20
Canada =A0=A0=A0=A0=A0=A0: 2,000 contacts=20
Middle East : 2,500 contacts=20
=A0=20
HNWI & Senior Decision-Makers (by region, incl. EAs):=20
USA : 500,000 contacts=20
Europe : 50,000 contacts=20
Canada : 10,000 contacts=20
UAE : 7,500 contacts=20
=A0
Titles we cover: Business Owners, Founders, Entrepreneurs, C-Level Executiv=
es, VPs, and Executive Assistants.
=A0
Data fields: Name, Job Title, Company, URL, Email, Revenue and more.
=A0
This list helps reach gatekeepers and decision-makers who oversee charter s=
ervice partnerships.
=A0
Happy to share prices if that helps.
=A0
Eager to receive your feedback.
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails


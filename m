Return-Path: <stable+bounces-52095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945EB907BA6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2F1F277C4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75C14E2D6;
	Thu, 13 Jun 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X9zG0Wtj"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF214D716
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303937; cv=fail; b=YdITNJ8ttOkrwQk3P+AnLl4nOxaekIqJi0kg3ZULXY6GxvqEunrw4FfVUsmoBpUZbEDh0QIvkullEYwETS/dNSZ8C5ciW18BY4giRzUWDcdM78FlLgHN9vfaptCG+VqItoO8xxW0siGzRNggak3woQAQDQOARjinw7jBeRrRWmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303937; c=relaxed/simple;
	bh=A4eQQrIayhauIcjUgdv+vcjp+GgAT/Y5lf4hz6P/4Ec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZd13xVjObj2z+IZr2cZ2G9WvlhMtEdEemSAHtAjlkyGf2AhDJIhylc3l/JBHWKqg3foe2hxUIy1+0pj9D4A4YEyngiWZJIK+xgARb0wnjt+ti0rc8RlLVrlEogY9GduXqGUdBT/xfRBQAokb3Ngk5jVHcUJwPS5hXOy//Yfbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=X9zG0Wtj; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJKCSIXTFlvO+icMnTZqLaJuxT1SC/X+NELF7j/kcaqxQ5ft/yBG1RqdRE4P9XPhA+10eZiXYyU4ewkjB0FUrjf80K7o3jxILT60EV1mxYmk3UvVoJKevgJfZ7m/4dVg1zW/SftidT18HZ06THZi9SfumWHtN7Ze4DZ9AE+692XhOpVA44omSVSRDgiIntffbgJv1wjjWijLwd7M6O7bwfbAErYOPBD+03rm90UCha3cipbHpnhIpMs+LRwYELgtXqwL9S5Oe8x1EUUEUXWZyMRbfbU4kMu+HT3+DGIpx3Oko2ELi5H5YjINQWAVRthrVN4yGpS4sohJvSnMtMGEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hUAvxqX15RNxb5WuCXA9ip+iPHR9LrgpgYvX/L5XTU=;
 b=nRkDTbCYHtCWKWELel9Y2HwpWuBUWG1SmyjmXWxi6eakM2HLVy0XdJ9wNnxsqmLjyaoSrKTX4hR3zEn6GNfC3kGGsi0jsCcY57cxJMZkwy1SqlhXlDFtyEvorpwoRhTps1L3/aeh+MVj/Zl0jhqDjjEG1RXm8q5bDZqs9bku11YWVoXuw8xAOy/p7ZARI1TCdLX2SRRL+TJcR83kqT3PxXBCR7dnApYlGTju8zFFtP338taWTNRirZajSG/AEOUgfytrgue1/x64putGC4Pxgg5aG74S8kDuTY6nQz+acD3Y/U8Aqm6VtZjsGi+T+Ap8ov6L0Mm28gU8ju1jClKj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hUAvxqX15RNxb5WuCXA9ip+iPHR9LrgpgYvX/L5XTU=;
 b=X9zG0Wtjwf9m1LNeWNYX3CHG8g1dGcuf3it2yv1kIE8Q/33H2PYga0lI8hvzAQOkjyxY+oaUcZKtoG5DaZUoFUJNKeSMrks6nHTaX1cUuPaH//yiOeNzKmW6ZkayG6TjTSAjYRJr2bRQ0SF5/OrLlFfTqAZH7n+VjcdAZOeRifM=
Received: from MN0PR21MB3607.namprd21.prod.outlook.com (2603:10b6:208:3d0::19)
 by CH4PR21MB4217.namprd21.prod.outlook.com (2603:10b6:610:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.10; Thu, 13 Jun
 2024 18:38:44 +0000
Received: from MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b]) by MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b%5]) with mapi id 15.20.7677.014; Thu, 13 Jun 2024
 18:38:44 +0000
From: Steven French <Steven.French@microsoft.com>
To: Thomas Voegtle <tv@lio96.de>
CC: Greg KH <gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, David Howells <dhowells@redhat.com>,
	"smfrench@gmail.com" <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Topic: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Index: AQHavMcRBv1KA1AGQUO0gMRBt6xvHrHENH6AgAACgYCAACbfoIAAI/GAgAGEuFA=
Date: Thu, 13 Jun 2024 18:38:43 +0000
Message-ID:
 <MN0PR21MB3607C6D879D4A92EFCAB1664E4C12@MN0PR21MB3607.namprd21.prod.outlook.com>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
 <2024061242-supervise-uncaring-b8ed@gregkh>
 <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>
 <2024061215-swiftly-circus-f110@gregkh>
  <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
 <07f55e43-3bab-33fd-fffb-2b6a39681863@lio96.de>
In-Reply-To: <07f55e43-3bab-33fd-fffb-2b6a39681863@lio96.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27d3ea5f-b269-4f30-89d7-299a427148a1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-13T18:32:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3607:EE_|CH4PR21MB4217:EE_
x-ms-office365-filtering-correlation-id: 210f4d25-9665-4e8a-fa6d-08dc8bd80dcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jLEB+sdzQ++TLJpXeMuSwZXxcGOVP9bm+0xslq/l20usX7ldAnslRbkYAw5K?=
 =?us-ascii?Q?V1Xh6Jm546/fiV0aLrgqbWYdoOEpb7bpJwK9QA2U9oQrjDY3OAUcrMxyUEOD?=
 =?us-ascii?Q?EFhFI2uJn5IZBk/PMxZqIHV/WGDgSWyfQY4ll8EOAGA5rIVZwtJaEsZLCkWz?=
 =?us-ascii?Q?16ORT2s2tmb7nDXhZQZmnxHN31SKVo6mXxN/ZgQGmObN4PN0Exynqfkjnmj+?=
 =?us-ascii?Q?7VZytvBeN+UgusdH+FB2Yt8iYtw6y2dQstaZSSusNQHxarZA97q96qGeA3fm?=
 =?us-ascii?Q?+A6a8ixShjXumNez0QCQlqsUiybrm+RST1sRaL+/tXbLMwDIvUWWgUpT9B8R?=
 =?us-ascii?Q?YWUITQ+BsEFNtuoDDyeKo1KSDfrYDIX7ElVJfQXfkqg6sxwxSeVZER+qObgC?=
 =?us-ascii?Q?2FipKnDX0a+T0ZZXynU2BiMoOQj4FpfY+Q1pPP8Z/eyoycF8ufTcvdLnCH++?=
 =?us-ascii?Q?jn5qmLdjXRZkwXsT5QxW2EMWjbmZSS5c3RvVBSafzXDYN5zpR+4QqTTlGAXM?=
 =?us-ascii?Q?PbaeUnfSGVAhpyfPnBa38Ghv4QOXao2rhEBUDnzXp5G1K94/eBRK1OmLkB1u?=
 =?us-ascii?Q?fxm/vLcx+qyIdcfZAMHTx5VptBBnXf1VSUbUbYImHLB1c6Q9KmSQ/FWy1jYy?=
 =?us-ascii?Q?SjYXnRwpnZGoOc6RUTTKsj3+S5gkLWhkY9PxVi8Vx2yxj6eMk6JtiaAZIk8f?=
 =?us-ascii?Q?+hZsvw0rI3CYqhsTSILVaQVSI4MME5i1ra618xmlWNh22xKqGIEMmxAxpqIg?=
 =?us-ascii?Q?RJ2vSIB+qsytU168adteREZZzlcR+/p8S8RtiA2YdZjY3ott9oYQFFtxBM/K?=
 =?us-ascii?Q?OM+T2iYSgQo4bY3JKJARAcIZR+EBuw1ezqB3i599CcYZlej+378PSTFAsOu5?=
 =?us-ascii?Q?71Xn83ALP7L0Cjgm28yCJ/+fMq5FeLbpD2FFjZ1lyUPLDld38gbTCeZxG2LC?=
 =?us-ascii?Q?AMZG4gVs+5TIVsEajzcJ1Cv8hZuyM9YqVpswckhaH3tQCRsT17xTRcBk/A+E?=
 =?us-ascii?Q?ni9vzttApQh6LqVFe2ByiRWdS+R21GW0TRMaiLvfP9/2RB85G8YLfEe8GBKN?=
 =?us-ascii?Q?HhImVPHfGduGnd60ShRzFZHjX1q0P7m4FHkNTrhSxgF6NAwTyrpIFaiqomXF?=
 =?us-ascii?Q?XbFQp7DlKYBDKlrbMqaUo/rd0cOmsKJldX3Ii15VKMgZaugpvBtr88LlKCZe?=
 =?us-ascii?Q?YzyiDnDHuRWEa7VGOxFKScowZAJobEZ6uO/1AYGga38atyFUnIS4G3r+fdw1?=
 =?us-ascii?Q?3n8gr4XSSzLirCFXZf2crF7vlp/FLy+IXZ/uUXutcviGqO5EHJJsg01+LBMZ?=
 =?us-ascii?Q?2OlA5Vd4sotNj5ZCycB9sYc3Yhfpa7tqnbj4K3fotWIWxiR3IOwrzynKwjvb?=
 =?us-ascii?Q?669txEM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3607.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YM2cae4pp3aguMSVZB8C/34eGfF9I8DSNeOPnWtBdLl86rqSPmlhdInoLkCh?=
 =?us-ascii?Q?SOp4FwKVl+SBPYzVKxcRsmuCI3XPjv1RvewKxBfkpKcROxO6oLZcCUWX+aLc?=
 =?us-ascii?Q?MjYrRbr3JSTSlXvd2NBxKg0mdcPX6p1FmqxN3op6Td79KpxztAN4mdO+S0Ua?=
 =?us-ascii?Q?ko31YK6XSk/fFjYtxHm/WrJYSTqDBUFEKDcg10GWatMzB+84f+t1qq/deCik?=
 =?us-ascii?Q?5aoFceW68O6JKsNA9UEU7FnfErORQ9WsiYaeRyU7B6/gj3YNlyOLo+QLPIPv?=
 =?us-ascii?Q?WtwRapW0sqmhBPEwYJ3gNoG7wRLcgonQwvfR5vpkhL3o6R9XOss2BDC5jnTr?=
 =?us-ascii?Q?m627Rphs0ww5pgz6DnHXXJk7gFmWIjhiZ8U5KY2iQHQGsBG4+pVsL/wcwazL?=
 =?us-ascii?Q?8N2gBWryD/t+F1pHox0XDvNpqs986XZf5yBJBmHlGAtZVHXeSYniIMHp9Gn2?=
 =?us-ascii?Q?9Nw1y+ENQc9ZBMrMmY7okygcw+/oBBIjnvMJdseZF5HOvoraBGlh/Ln4y8nZ?=
 =?us-ascii?Q?t8gLX6ipSG/qK/RCrGmTQEPNSdeX0bedAmibpYDglQzYeqjR5zGPG7SzZLqG?=
 =?us-ascii?Q?8FxukklMTmlGIV844EFzH1NmMyTFPOwWGHpqDgWNfUf+XTs2g9y+7gQGm7kI?=
 =?us-ascii?Q?c3tucvgmm70mVk2JKcwQihEHbyKxHarHQWh+ooHVW6u37KbP7JoRrc04YPsJ?=
 =?us-ascii?Q?U9jyZgLEf3vrjxoupEgs5263It1T3uLPDpRTo6HDy7LhlAICKDHygKt1Wq/I?=
 =?us-ascii?Q?j2RqKirMqOsDqTHPPeQzdO1121vEVcM808bszuPB5UIPc7vKZ9Ptlkno0Wib?=
 =?us-ascii?Q?EhCNViqnwgxFwushz+xVketh1lStBCe9HqAMibjOYfogRGA1K+7MFL6XjYzl?=
 =?us-ascii?Q?59KqZKtTCqqphfrp7wIiAYCOyJ6/vcSnDzUEdDyQ83YL/5OGuNklhwpqRh9Y?=
 =?us-ascii?Q?l8amS4Ti0UM7MUx6j2fq1tEuvUVtfjsXKqhdiho4BXz159U+e3Z5vzX6sLjF?=
 =?us-ascii?Q?7mlKnY2MGgTipekFWequ+TwYEFjlUOWTZVurTknsKvrqbZ+jjpFGETVF7iwV?=
 =?us-ascii?Q?jqkj1r2PdDRn0pTtTswL+Ws/U/CZT6hcfIzhly1cjmgX1+qed+HfexbdTPSi?=
 =?us-ascii?Q?7b9buETsu7SIMGMdXuZ0APDYjGvQkrYjwxaHXkgX8egW0Iw+jjmIAtb/hQ+6?=
 =?us-ascii?Q?gAcGcpfSUfAvb03eWlcXyRm6NEcus5PS8DyYWbwu2i3lJRfplEbVcRDNldGy?=
 =?us-ascii?Q?N2k+Ez0aojEg9iPj+r9snNZGN7ISmhNqr/K+tiX23/sIN9wS+nplM/APV3Qa?=
 =?us-ascii?Q?njh9oSxPXzxxRQEO8uDM5AVsGlpTm8seHmYcwXncurD7zxJkzyJPOo1yxo/i?=
 =?us-ascii?Q?o9tTnV8JR36S95ongUUEg3K6pHV+RsQX3UC6uj4zNLaMWppMjQ5iJHvo3QiV?=
 =?us-ascii?Q?QHD+1N5aM5rTHIMpJZsQQ4SMZgqzepdyKketrlc0a0y+EbjADtjOZjQVaodB?=
 =?us-ascii?Q?/ZO3KMeXQFGFKndTfYIq3immnr+wslKrZ+yrkIZIBFGnXJ+Zsu/X+8zVJiic?=
 =?us-ascii?Q?X3Hk2T0/UMcHuVsQRLDw7f6yx1Ag3DE9rLRf/OeewrpffepANviv4TTA/wXE?=
 =?us-ascii?Q?5bf8tPq25yFBHE3bss4e2Jua3bgAaE50gQP+30Ore9JJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3607.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210f4d25-9665-4e8a-fa6d-08dc8bd80dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 18:38:43.9866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4xJ7oIRlD8lishtZBbg8onqa+Nwh3B+9GJJ1VPVrWYDIZDhpflPBIDExF7hRn5eVmNZVt7NhJr9SgizL05GQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4217

I haven't been able to repro the problem today with vers=3D1.0 (with 6.6.33=
 or 6.9.2) mounted to Samba so was wondering.

For the "vers=3D1.0" and "vers=3D2.0" cases where you saw a failure can you=
 "cat /proc/fs/cifs/Stats | grep reconnect" to see if there were network di=
sconnect/reconnects during the copy.

And also for the "vers=3D2.0" failure case you reported (which I have been =
unable to repro the failure to) could you do "cat /proc/fs/cifs/Stats | gre=
p Writes" so we can see if any failed writes in that scenario.

And can you paste the exact dd command you are running (I have been trying =
the copy various ways with dd and bs=3D1MB or bs=3D4M) in case that is why =
I am having trouble reproducing it.


-----Original Message-----
From: Thomas Voegtle <tv@lio96.de>=20
Sent: Wednesday, June 12, 2024 2:21 PM
To: Steven French <Steven.French@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>; stable@vger.kernel.org; David How=
ells <dhowells@redhat.com>; smfrench@gmail.com
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big fil=
es with vers=3D1.0 and 2.0

[You don't often get email from tv@lio96.de. Learn why this is important at=
 https://aka.ms/LearnAboutSenderIdentification ]

On Wed, 12 Jun 2024, Steven French wrote:

> Thanks for catching this - I found at least one case (even if we don't=20
> want to ever encourage anyone to mount with these old dialects) where=20
> I was able to repro a dd hang.
>
> I tried some experiments with both 6.10-rc2 and with 6.8 and don't see=20
> a performance degradation with this, but there are some cases with=20
> SMB1 where performance hit might be expected (if rsize or wsize is=20
> negotiated to very small size, modern dialects support larger default=20
> wsize and rsize).  I just did try an experiment with vers=3D1.0 and=20
> 6.6.33 and did reproduce a problem though so am looking into that now=20
> (I see session disconnected part way through the copy in=20
> /proc/fs/cifs/DebugData - do you see the same thing).  I am not seeing=20
> an issue with normal modern

You mean this stuff:
         MIDs:
         Server ConnectionId: 0x6
                 State: 2 com: 9 pid: 10 cbdata: 00000000c583976f mid
309943
                 State: 2 com: 9 pid: 10 cbdata: 0000000085b5bf16 mid
309944
                 State: 2 com: 9 pid: 10 cbdata: 000000008b353163 mid
309945
                 State: 2 com: 9 pid: 10 cbdata: 00000000898b6503 mid
309946
...

Yes, can see that.


> dialects though but I will take a look and see if we can narrow down=20
> what is happening in this old smb1 path.
>
> Can you check two things:
> 1) what is the wsize and rsize that was negotiation ("mount | grep cifs")=
 will show this?

rsize=3D65536,wsize=3D65536 with vers=3D2.0

rsize=3D1048576,wsize=3D65536 with vers=3D1.0

> 2) what is the server type?

That is an older Samba Server 4.9.18 with a bunch of patches (Debian?).
I can test with several Windows Server versions if you like.


>
> The repro I tried was "dd if=3D/dev/zero of=3D/mnt1/48GB bs=3D4MB count=
=3D12000"
> and so far vers=3D1.0 to 6.6.33 to Samba (ksmbd does not support the=20
> older less secure dialects) was the only repro

For vers=3D2.0 it needs a few GB more to hit the problem. In my setup it is=
 58GB with Linux 6.9.0. I know. It's weird.


              Thomas



>
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 12, 2024 9:53 AM
> To: Thomas Voegtle <tv@lio96.de>
> Cc: stable@vger.kernel.org; David Howells <dhowells@redhat.com>;=20
> Steven French <Steven.French@microsoft.com>
> Subject: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big=20
> files with vers=3D1.0 and 2.0
>
> On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
>> On Wed, 12 Jun 2024, Greg KH wrote:
>>
>>> On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
>>>>
>>>> Hello,
>>>>
>>>> a machine booted with Linux 6.6.23 up to 6.6.32:
>>>>
>>>> writing /dev/zero with dd on a mounted cifs share with vers=3D1.0 or
>>>> vers=3D2.0 slows down drastically in my setup after writing approx.
>>>> 46GB of data.
>>>>
>>>> The whole machine gets unresponsive as it was under very high IO=20
>>>> load. It pings but opening a new ssh session needs too much time.
>>>> I can stop the dd
>>>> (ctrl-c) and after a few minutes the machine is fine again.
>>>>
>>>> cifs with vers=3D3.1.1 seems to be fine with 6.6.32.
>>>> Linux 6.10-rc3 is fine with vers=3D1.0 and vers=3D2.0.
>>>>
>>>> Bisected down to:
>>>>
>>>> cifs-fix-writeback-data-corruption.patch
>>>> which is:
>>>> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
>>>> and
>>>> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
>>>>
>>>> Reverting this patch on 6.6.32 fixes the problem for me.
>>>
>>> Odd, that commit is kind of needed :(
>>>
>>> Is there some later commit that resolves the issue here that we=20
>>> should pick up for the stable trees?
>>>
>>
>> Hope this helps:
>>
>> Linux 6.9.4 is broken in the same way and so is 6.9.0.
>
> How about Linus's tree?
>
> thnanks,
>
> greg k-h
>
>

       Thomas

--
  Thomas V



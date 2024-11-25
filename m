Return-Path: <stable+bounces-95426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09759D8C45
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 19:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D1C1687F6
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78B1B87D1;
	Mon, 25 Nov 2024 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BtXMPG+1"
X-Original-To: stable@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazolkn19010014.outbound.protection.outlook.com [52.103.64.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B61B81B2
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.64.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559722; cv=fail; b=q1mZotUpTrerkbc4sGA3wCwRiCXuateQdl3HazAIA3qR3uqLTW+o1I+GKUnaj1aUJTaL/APla3KA3UrqbACo1Kg9KEFmW8YuO2wYbzEDFRO4N/P69zgCT4E3vdZ8+avJqTEjxX8mrpsmaIFEMaB7b3CYdFRlyuAQi2vKvvOMskg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559722; c=relaxed/simple;
	bh=Cz+XObbxOfYI4RALdE5lhCz/gSAVh0XGkVQ7e1tIabg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HextFJ6+9t9+kx8QkwfOSVgHLR5iSzK3UlqUrp91aEmWq4BJ9nIN4sDkmmdT9oXtlBenLOVlSGLNPeVhyNWwM5uEIjl2KUjfFHdkz9r7FmKfc3xHJnOER6tzz6yQkmILGabIC1ZmaQCiCfLyeEGDqNqHTLzBgcOzLid1GwScjVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BtXMPG+1; arc=fail smtp.client-ip=52.103.64.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+HgjGQU0t5jumDC2P7zZ7X7KTxZ8f+FZAhN9zC1ALt5bjkbwbhLJCOVffJWD56vAAsPTRkIueVmBFSC5vI1/JDtC6WB66LCCfaTXMUvhUA4CKXzXm/5fQpgqBAcWCrxSMTvMslQwbZVgtqWP1esfM4giRmSYmUhJOdeF1y8tgUrv+6+MrChIs/FBkfsvM5UrhZC6+gMnyGZ4OUI70KCuF9UvQ6sHbZAO4OWMyrFfRc4TMlBIsZj4gLMiD4EMMHFx4NdTwskseu9+OIQkS7pP7NSXcny1bLYykHJtZkKnrwQU9h3H1GQAAHdlIUNDdWVOi1OR6IQSObjV1rpALacAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz+XObbxOfYI4RALdE5lhCz/gSAVh0XGkVQ7e1tIabg=;
 b=V2XQlFlu0MBrMDUHECljI0XoNpSDO3VT+C6iWxlgRN79JvGx7s19QVxv4aPRMebCqA3sdj3WJrB/9XWcQPZjtrFjAtLqUG+RwL/vO+FmEEvR9ZflRDtppe2UM3c85/NW+K/EdtjBjQq/suVjUbZ/AS8C1eUCcumrVms5ylae4Q6Zi6+GSOE+jukG4bdbtknbM3RyG/JmhAubboJHAK5L+M88rbTXX/1p6gQXBiv3h+uxRQShVgeWifWt5t8XqynyjC9fEPkEhbLOL+7+Rqk07vG/yY3OaHjqFA+g5Vp9g8hbWFTLZ0jTbUqd7ge6EyauuXDH5mUNvvPMvozHrJa4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz+XObbxOfYI4RALdE5lhCz/gSAVh0XGkVQ7e1tIabg=;
 b=BtXMPG+132UHlq4ftESze4/yXJ2+4C2nEenIrm/ALl4ASPFNT3tHINn9zx20RIYV+P9QJpZO2k60REUXmic35shrTZblqitLIWh3l+IE4LviL9los7iKSBtPOH5BJiON5jOASAnQvmu9VfCnWVFh3w+Hj+sQztmJLh0mY4oJ6WrBci8vDUQTc8x2p56jnOvClt8vQlwOI3QuM4c4Eo2mN0IQU6PBpscEGYWv4EKWYcv/TrugwTt6Uw+J2EwLQ4CMuxoj+KdDAeYoDMcZcQxC8213L2feAxBDFGhynWwFvGj9tDPCc3JwXnoLqPzEBXLUWPoPenmVhbNswOlQ0y8bxA==
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c6::12) by KL1PR01MB5776.apcprd01.prod.exchangelabs.com
 (2603:1096:820:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 18:35:15 +0000
Received: from TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2]) by TYZPR01MB4209.apcprd01.prod.exchangelabs.com
 ([fe80::8f93:1206:1c13:f5d2%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:35:12 +0000
From: Rachel Taylor <rachel.apolloleads@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: Taking a look at the NRF Retail Show 2025
Thread-Topic: Taking a look at the NRF Retail Show 2025
Thread-Index: Ads6qYQQ9Arym7QnRMG+gsn7vUgHNQEvzwAQ
Disposition-Notification-To: Rachel Taylor <rachel.apolloleads@outlook.com>
Date: Mon, 25 Nov 2024 18:35:12 +0000
Message-ID:
 <TYZPR01MB4209C949A62D7D308F226DC88D2E2@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
References:
 <TYZPR01MB4209A522147B2AFADA21AE7F8D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
In-Reply-To:
 <TYZPR01MB4209A522147B2AFADA21AE7F8D202@TYZPR01MB4209.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB4209:EE_|KL1PR01MB5776:EE_
x-ms-office365-filtering-correlation-id: 9db2df24-25d5-4252-ed49-08dd0d7fe5fa
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|19110799003|8060799006|7042599007|8062599003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZktWvJ+Ff0EDLUYmyLJX97oWnHS+Q9H4YQ7uq5dfZhy/VTxg7ufdyzrmF9kB?=
 =?us-ascii?Q?zL99UvjJDEvTU7JhEUFaWiwbS8Itrq2y/549b3OGrDaVtuQKtqn7hKNEtuS4?=
 =?us-ascii?Q?5yG9euvnsZazcN7yArldleGJopK7s5mNJACMYuhNkx+SNGzokQB+oL8Oyikg?=
 =?us-ascii?Q?NyI78qNJIit4EFeXzEVMVdiPWle6SC8OO7f9iAiMYuDWr0xxzg90xyPptGih?=
 =?us-ascii?Q?z4MH8XJ2XxcaPaVqY5M6W+AUujwEUFnIwjiy+FcW1E0NOY95MfBNdGUE2mG/?=
 =?us-ascii?Q?a5a4S6/apf5WyxD7t06AJEVc+aQYjvdpWznWkh28WPhrOig/jggAiu542kpr?=
 =?us-ascii?Q?pIHwLjo4sx5RBSb52C25e6EDitpKNgP8RMUJzFs1UGe+KdU/DY94Fxi+eLxk?=
 =?us-ascii?Q?Wqg43y4Q/+oHhPwQmVuKUtU5m7/ml92+oum03O1dsRXhGbMZJfDjrWzwQqMy?=
 =?us-ascii?Q?J0odnvUCiZV8M5d4Cgdqm2fK9eMD9VolI48S8AAghjJgd2nTYGOAwReGVmFs?=
 =?us-ascii?Q?L9ulEFzW4+YIc2ZDQwQoSuFJzK6ekk7Dp0J4pgAkST7Z4pkkCHvxQiJoKwe/?=
 =?us-ascii?Q?pX8ugKP4WKPUtSDfJEU27N3vjLTUYubvIx/nYEX10ScAolfxaRXEXA2XgJpW?=
 =?us-ascii?Q?d3+qjV9eXXNkNv2YghGzn0U5efs4EhpydMDzacnSPJqMsAsHadvW9PSEOmsd?=
 =?us-ascii?Q?iVSZN+wI4GXEBALr2kUltub/VvUOXBVx4/AM2MWif3XahiZnRnhVBf82QGA8?=
 =?us-ascii?Q?I6LCu+bO4VFflhAuV9l1S1sBTnKcC9NwFSo6XDKJxVjFveI5cC56gGh9y0yi?=
 =?us-ascii?Q?U9i+/McViobzH3qxTpujxbOAr06RZO/xpdIb2Ou6SkorytDYdW9dQkmH43UK?=
 =?us-ascii?Q?zStNIyEmxXJ96ti/P3GfP7XB13fnAm1JBOSDipNDQ73yDldX5PF1Xhk5ESWx?=
 =?us-ascii?Q?fWfPsLP5lCOwmSFIkFquVnBheNhTy/VmT9WpkfWngsqJq5f530hkA71N0Ug+?=
 =?us-ascii?Q?6eZywb5/fVuguYhQ3sweqSm6pClXGFTJhbkfwjpLzZp5loI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NMPuzNKJlQf/fpQMEKNXQ3LcwpncDZHvjWJM0y40XBQYCEqlmL0vpTEq5Nao?=
 =?us-ascii?Q?EQ5VBBtGuKFj7N8y1DRxwi5VCGovk2MtJrRPd5lOjOBjiocGHB/JDNvkJfNk?=
 =?us-ascii?Q?3bzfP6JsuyDH4WDRwtqBZ5REA3e+/ZQKbnE0H/ELqbDo0WLYo7okQf7Rp48q?=
 =?us-ascii?Q?LrzDJ5ih+ytB5+Nxu3TXU8sDyIDYufZLNjDxq0t+rT7vjcX1tR0ns+aGa604?=
 =?us-ascii?Q?1hF+Vtgdxpc03ZQvuCSK0MDP4Ym/0Up5YMK/2TfmSlu3PP6ACR+tdI/ABoTg?=
 =?us-ascii?Q?s/2MMwSBpK8ZAxZR6p3aO40L9Geq1Msfs0VIM6NWB18Q25+ZI4UvucrHil3N?=
 =?us-ascii?Q?H/vCycx3wzhxxbJ3vwn6pkN5gaIYSY/zi3Tq5dCZjbbzA4RxdE4hdGf1beeQ?=
 =?us-ascii?Q?UXKJC1v2i4EK/3h46AExvNhmGReOY78O9ioTOYLpo7G9d6lU/jh2eyJPgV5A?=
 =?us-ascii?Q?e1N2iUsbzdlrPjyjwqkpopYy/kQqZaaFTZoGyIznIGmC2B6Vk/J0/Gj/kcoP?=
 =?us-ascii?Q?P91QBZd3rczKg8c+3KPyN+QfmgjLvjLPMH5yHPymhQ7TrpbwAsz17mC5feeL?=
 =?us-ascii?Q?MIDiuKEyDvLLIFcSp++0VEgb7jo73Ipldv57xv4F/lIl0rN6mPaWb6gVC0bD?=
 =?us-ascii?Q?BtpMN6ayAjfQqHqdAGDWbUpQrtfCrjLiDAlBlanOjRuLEPry8Esf8h+4JF5c?=
 =?us-ascii?Q?qPWiGKlynLrm69IzfBAWOQw9GrjsIw0SSKPDlHguveHVgsAr5Ym7eGMg+wqi?=
 =?us-ascii?Q?qQLaDwfryOM8QncJK0jE12MMi07AGapoODnUib5y9vuN3ro1DNs4uJGO5jLT?=
 =?us-ascii?Q?8OXUUlOf6B3VldYL47ObkVeQvFC33Y+MpmTMtn+jhluBZt+Lt6kZDZ/9UtTm?=
 =?us-ascii?Q?eBAyGfkKFqQRrEt5lqIqnuysfdhsiQRa8JpbpGQzYfOPNVg9ejs4fOjzVzSP?=
 =?us-ascii?Q?hj5sJdytdNaVJO2J5WYZlLkWkdobbdMUpeD/iBbon8Yygroc+YnA9S4vpJIY?=
 =?us-ascii?Q?epot+zNAkOtJ6ACWkSVRan+HnmMsHKiJdA0vpk8bWKgEIAPqnmjzi7wTH/OS?=
 =?us-ascii?Q?Ca/zM4/khDg0Bxi3WK7VQYXsp752U/fr77RyR4nlkP7HzNo+XEdDlNFuAkt5?=
 =?us-ascii?Q?bXdtoJPhAzrV7xsmiWsRxmwKGLLSBLuxD2Zp9bXhdBEfTiSUymSM9qSsJzGo?=
 =?us-ascii?Q?rduGS+zfiH1lBqRSrcytVeFfXNw46Ctidm023owF0URRrk9O0XYMRIR8zYJ8?=
 =?us-ascii?Q?gKunV4L/BU2RUY5aWtIt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB4209.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db2df24-25d5-4252-ed49-08dd0d7fe5fa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 18:35:12.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5776

Hi ,

Just wanted to make sure you received my previous email. Can you let me kno=
w if you have any questions or concerns?

If yes please let me know your thoughts, I will be glad to share more infor=
mation for your reference

I'm waiting for your response.

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails

-----Original Message-----
From: Rachel Taylor <rachel.apolloleads@outlook.com>=20
Sent: Tuesday, November 19, 2024 10:55 AM
To: stable@vger.kernel.org
Subject: Taking a look at the NRF Retail Show 2025

Hi ,

Hope this email finds you well

I am reaching out to let you know that we have a list of attendees in NRF 2=
025 Retail's Big Show=20

Attendees count: 20,000 Leads

Contact Information: Company Name, Web URL, Contact Name, Title, Direct Ema=
il, Phone Number, FAX Number, Mailing Address, Industry, Employee Size, Ann=
ual Sales.

Please let me know if you are interested in acquiring this list, I can shar=
e pricing information for you review

I would like to thank you for never keeping me waiting for your reply

Regards
Rachel Taylor
Demand Generation Manager
Apollo Leads Hub Inc.,

Please reply with REMOVE if you don't wish to receive further emails



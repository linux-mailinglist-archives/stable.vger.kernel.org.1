Return-Path: <stable+bounces-244723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGfIBiGu/WmlhgAAu9opvQ
	(envelope-from <stable+bounces-244723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:34:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D4F4F44C3
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 189C930342BA
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2C3BFE52;
	Fri,  8 May 2026 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Ij7soy7l"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9B381AED;
	Fri,  8 May 2026 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232783; cv=fail; b=TVnBwPE9yiqIaq/WE4ytGWHuYs3xMecj3+bCK8EtxwAdaAjT+1+H5T8krjlXxHF+xtTjzpl1MbOo9moDiH+Rk1SIsYxfde5kI46d4sOrsid7xk9SAbj8hHBsFJ4s5aP3YdAO7wFu/2idV1yN+lF6BgjKZ7HFAUfTGOeCegrfk+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232783; c=relaxed/simple;
	bh=wled2V9cWeFfqRLeUMoEfnPAsbqU5bBLJyozC/d3mfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jWpqL9dXqMaS4IHo+TaHpiJtQx+IwSdGLVSOe/wGsPacmkEq1ORP+vCfj2fv/2tUrYzr7KdYD4WS/Nf877TU7sPvEuKQ2SaMQGT6LNKP9YF4oZAvII0kXE2PpSIB4LCVsFNAlYISHH9lKdFrw4asLCYFCzDh06CPZYDaLxU+/58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Ij7soy7l; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7tfKEOemCVgUkn51TUCHgq6i6BZe3iHS3UEuPUgAqRsLUEuw7MeHl/rsByVvG4K0pcLTEQ2cQK8gNUpQywi7NAWVRtGgaL871hh5GmDk69sPYDwmvoyvDT+f5J9ETTxdp5E/z5277b2pPr5A6+fPoyU8D105kO2Wz0xOQB8KY71A6oKfXaTC7Kz6FolnmVkZvyCHZgLBPLwDmcRvE4ATOTKGnHlRl+aOQ0/IUHsXx9H/CHYMbFn80fzlZ+NLBBV1poY6Xcu5g8PH5jNl5lheRPkM7jYLFzUNK14mG13N1TpilCOUHjBrdPefALK+CLOPIKcba03zKwwzZnjMwzi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wled2V9cWeFfqRLeUMoEfnPAsbqU5bBLJyozC/d3mfk=;
 b=BPdsyHTxw9O7bDq/zMfR1/TEHjEDJaoTvvfVWzycCRk7y3oiz+PdsBzuJVbHyyLncbSKKRHNHeKvtrG4Lpi8GD6kOubJQIIl6qkyL+WCeD/iHSMYOXhhyl9WOvbXlH7gyXAURNDxF2ysOZmp9pgpMtjB6TMFH5EUrZxQvuCjkV55ktjw/UznBaCh7zqFp88AsnCGsYhJ5AoFQXsYBjMEYHzTr0YMe4+j1uA4OWSzYz0QjDmKMIIWl++1idO/VfuUEQmdyNJCScgslEYsazV8bjqQoN2zsJ7e4SCp/TQVE/J9vaXSmZnJF32SlZ/k4/3rhyga/Qm/A0Ho1pOno0svTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wled2V9cWeFfqRLeUMoEfnPAsbqU5bBLJyozC/d3mfk=;
 b=Ij7soy7luBzGsbsIxii4pn5Ki3OyRjSdj50ZSV3DG6CyKNnulUSTPhBxkyDKoAM2XEe95EMUnil+6A1TgYgnuPXMAbhwJUmKyiJXwIkDvniR5mPqvALX7c/hQkC40FR0zoak4vnQxEACPc48B2jJWRo9Xu7Xx9ioV1PFvmFm3F/9/GdmAhVv3opZzDZqgQ2Evuu53Ntv2HxnDshoNZ2F6dksXAX3B0CF/o/cfO9uAMajDt/T3EGIUnUn22P/gHLuziVi9/d6j/F1L2ZYx1aUlMtkaLS15EnRNnZlgSOTLdNpWiKA+to5GPTcxvQwaotNIO3FQDiNEY158IbvvTUe5A==
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by BL1PR03MB6197.namprd03.prod.outlook.com (2603:10b6:208:30b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 09:33:00 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:32:53 +0000
From: "MOHAMAD JAMIAN, MUHAMMAD AMIRUL ASYRAF"
	<muhammad.amirul.asyraf.mohamad.jamian@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>
CC: "Rao, Mahesh" <mahesh.rao@altera.com>, Matthew Gerlach
	<matthew.gerlach@altera.com>, Anders Hedlund <anders.hedlund@windriver.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] firmware: stratix10-svc: Fix probe failure with old
 ATF
Thread-Topic: [PATCH 0/2] firmware: stratix10-svc: Fix probe failure with old
 ATF
Thread-Index: AQHczXG92FyIcKUIxEm5bkSFyEiQu7X/doEAgASJ5AA=
Date: Fri, 8 May 2026 09:32:53 +0000
Message-ID: <625db1c1-e8d2-4e62-ab65-43eed05af454@altera.com>
References:
 <20260416072207.27074-1-muhammad.amirul.asyraf.mohamad.jamian@altera.com>
 <15ea8185-49ac-4a43-aecf-b650e54a2a9c@kernel.org>
In-Reply-To: <15ea8185-49ac-4a43-aecf-b650e54a2a9c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5458:EE_|BL1PR03MB6197:EE_
x-ms-office365-filtering-correlation-id: 9e77f8c0-e75e-43c8-d398-08deace4c7dc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 P+xclBBr2wXMiVLfzTUVaGR3o5jX81E0bDqJ1MECiH16sRmTd4vVjesu7GtDKDlXYXieLisBhXkfFTBC/BDI52k06By5VsqCMM9a44sd/6UPfesk12UWZqvDevbocCCkUd3tuYk1JGX3xaITn6cBgAmihccEie6pE6nrM9X/Juv7YY6OOBZOuGdWhIhJafj3feJ3LyI0b+3PpgJEsyGjCF5AbjNaRiQl+fThTbAzIICjBb0+msNv5N8gwlEfsIAIxVU4+wGt03/IRRU9rD1FtGb6wQujySu+zMKgOovJ7Ne/wOYiw5wRjbgEzHs4pfdN9rWmFmguUXarWty9N7H2anVmwU3Nu/oL/yw5+5PiM5oXJQ+k2CJ6IeN/I0lp8886MFvBjiRnKI5Oc9Vplv7jhojspZHtpS9FAxuabQwIabf54e+WL+ZvMfd/XCOsQppsHK6PdpWCN73Dnq/Y3643gU/eh6FyXtSbGryLbxkdYYEe2AOa1L9r2xrhvc+7a5J7WFk+7SE2Xg4TkRNiLpvUkXhZk7R23ODVt7iifCN7oKSGg0earcsyMfm/MSY7ijVSsja6XOT/y9Mx48BgoQJwUyaDF7MxY1ktQJZ4L4GvslFuEj719eABrOU7eJP7j3LRll+hn3CPXOgixrgixcz5n4uOBgwb7L5JG9CMdFQRtlUubUp2QpK75dblzVQg9/DFt5fCLB+CLhc84T3ERv2gk6VKFYW3I7s8s4bmcAjuVi6fG8Tcq0Zud1eXuIGLWzAU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5458.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q21uajlHWURWSC8ydXluM0x3cUwvWGU0cXJ2eWVmd1NWZGlxTTE5VXl2WGNJ?=
 =?utf-8?B?TGpUWityWkxxNXQzbGZDb010OTRyWFhOVmNKUVQ2RUs1VlhBVEVBUkpzYmdC?=
 =?utf-8?B?d2ZPYzZseGV5Y05KQ1hMVFlHa2VRRDRhRGRoODI1eWlVaDhXSi9DTDVCSEZy?=
 =?utf-8?B?NjZiKy9yRzJBYjZqMUZzNHBSQUJINlRydzVTRFBjbGJEQjkrUFdXU1JVcUZv?=
 =?utf-8?B?L1BleTE2Zzd0cVRpbjRmTVBxOHN4dHZxRXN4VkhGVndFd0ZJMmVwNFVIbWUr?=
 =?utf-8?B?M1BHREFoWEQvRlRUT1I5aEJUZk0ydytHTklMNlFtQmNtUm9YajZZL09tWWty?=
 =?utf-8?B?aTZWbkx1NHpkR3VkVVg2YmNYdkJxMUdTaG5MVXFZV1M0aHNFalhCcFlyK0JF?=
 =?utf-8?B?WW9Gc2hGTDk0YnlRTzJmeFcvV2NUUUVQaERwcnF0c0Q3VEg5ck5CeDh2N0py?=
 =?utf-8?B?MlNMLzQxMHN0YW1OUkpYckE5Sit5N3NxSlA1ZndWSEJ5UWdjcEorcDUrZ3Vk?=
 =?utf-8?B?N3ErZ05TcmlnQXBTZlVZbUdMdDhSZXBmZ2VtNWNYQlB2R0o3S2ZxM0kvK2RO?=
 =?utf-8?B?Qy9nK2dla2JFa1hGQXVXQU54MWJHV0RCMHV2am4wVEJHYXJ2eE4vbHliWHJp?=
 =?utf-8?B?MlB6N0ltVEI0ZXNiOElqeHk2OTNWT0hZMjFhTUR0Q1piUHVrN2pqb3Jia2ZT?=
 =?utf-8?B?SmJIamN4a3BMYTdPTXZUcFljdDd6Zit0QnZKU0xMYzZnSTJzbnhnQUU0S1ZQ?=
 =?utf-8?B?eG1GMDhhOXJKWUJ6bUEyYXNQSjZBM2VVdkc4SldweDl1NnY5bVVNZlI5Zmln?=
 =?utf-8?B?QlJQN29nOUFLSzVjU3kwOEIwRzdTRWdDQklhVXd5UWhuWVdhNGMxSnMxU3Vo?=
 =?utf-8?B?RkwrdlVkRFhWZWdFdi9pUTh4U0Z5Q2pVY3dvTGJnc1Rxbk12ZVJGbUVRRzJH?=
 =?utf-8?B?bjhBWUhyR2NkUFNRam9wMlArTllhcGdMWFpLUW5jU1dpZEZ2dEM1bFV0NHlE?=
 =?utf-8?B?aWFQT2ZRYmVPZEQrU3VlQVdtQVc0MFRDUnFSeEhsUzdSZGZYTTN2UnFLT21M?=
 =?utf-8?B?c0NLRXAvZ3p0RWpNUmsyUW04UDdwK3MyUEh3K3VzRlM0WWQyMDdmcVhIYktw?=
 =?utf-8?B?UFhZUnNUWmZJcDkwNHJQYTRpQVJqbmhqYjhvSGp1ei9DL0RDOEo0T0Y2RFFK?=
 =?utf-8?B?N0UzU3RpUlovdDUzaXlZRmx4amlFcnl6U1djd2hXZWRwZXZwaVdLSk1sd2kv?=
 =?utf-8?B?S0xxVU43RHljNmRsbHZmblZiWUdvenc4Qk1EWWh4VVdZaWZNcTFNWUMyU3hi?=
 =?utf-8?B?b2lQYVlXV2p6WWxHR1hkM3VoaFpHT3hQcUpIdmlpcDFDSXBEVFdyU29NaE9Q?=
 =?utf-8?B?QmZRRjcxc01VODIyL3BGSFljeGJacCt1NXBQaVNzcXNuUFpTRXEwZDZYMGlQ?=
 =?utf-8?B?RG8xUUNSSmdsb3RYVktJMHNDaEhKdC9mdHdYMU85QUdleTdHQ1JLeWw1Znhm?=
 =?utf-8?B?bUcrbHBzS1pNUFpjRGJURnhiOEdBV0d1YjZremptSkpWZFRkNjN3aENIaTZP?=
 =?utf-8?B?WFRXVnE0N3pPRXk5MWNxMVdqS1BOWEFUMUk1SFBDY1JGZDVyVEpnMmxOYmhi?=
 =?utf-8?B?WjF1WG5vdlZ1WGRqRE9lbU5ReDFVM3BvTWc4blBYZmdxNURqS1Z2ajIxRU1D?=
 =?utf-8?B?eXBsalltNVBUQkJNOXZIbjZsRFpobEpXNXlmREdNNjhvaUxxN0xiZkF4WXZF?=
 =?utf-8?B?U0NsWlJnbVF0dnI4TENuUzBnMlRmV0lNRmZJZVFsbFZQckZieFVwUS9Va1RV?=
 =?utf-8?B?eTRkTnUxbHh6SzVFWWVlV1drd3J2anI5K05kM3Rvazh3WEJBalNrWGI1THN4?=
 =?utf-8?B?ZnJua3I1TWJXRzg3ZzByd21MbmQvUzlnNmJzN3pFY0tMNkVERExFVTQvZnd0?=
 =?utf-8?B?SE4zVHVzdDloTG1ZbWM5Q3hZaVU2YVhQODNvZ081cHI4eGNTMUdENTFML2gv?=
 =?utf-8?B?WGorR0hoMXJpNy9IUW1IQmhBYXc4elNydDdTWElsemQzcVVlTW1zeHczME1Y?=
 =?utf-8?B?MTZ3OE1aV2tVQWRmUnRmL2ZSSUE1clBtdmxrcFRTNUtSeUJUNGlCNlA3N1hZ?=
 =?utf-8?B?am5XYmh4VEpBMnpWVThIYzZqSnBieXdOQ0hIRWhBOUd4R29JamRoUzhsNklC?=
 =?utf-8?B?RHJXTDlCdlJZNVJDSmpLZDlWblJLeGdlbWRkQXdPRjBqSEhuMEM5dm5kYzlz?=
 =?utf-8?B?aitwRHZHamNhS1ZGZVVIT202TU95OXIwY0dyVHVteVBSbzFVbGs0b1VyTWZE?=
 =?utf-8?B?UExNZ0VNaExsZ0IzTTdoUittSG5DM0VlNHI1TFpPYlFDYmFsZUx4a05LYW9S?=
 =?utf-8?Q?CUarF1LW09fU8RwPlOJ+rt0GyfxDyzNQmjkPqK7/kXfMI?=
x-ms-exchange-antispam-messagedata-1: 3kcf9I3CweAVXgU8bEM3MkjjJ9UJfWqXHus=
Content-Type: text/plain; charset="utf-8"
Content-ID: <402CAE6AE80D0949A52A751FF6185B2D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e77f8c0-e75e-43c8-d398-08deace4c7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:32:53.8295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmmkB5mysPb+ftmIQoi1CZTMSFsYhpb3TvWQ0U7QAPef21H479Ogqx0QSiLiJye+9l4o8IZ7Z2vBUBbf9brUJTrkD6f/xo5vtcZnsbEu2asRPiRalwX9Xt872Bhcewri0/w+lY/QIkbCA5uI2C33K8eUMNo5QDMdVglQDadEjG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6197
X-Rspamd-Queue-Id: 76D4F4F44C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244723-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.amirul.asyraf.mohamad.jamian@altera.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim]
X-Rspamd-Action: no action

T24gNS81LzIwMjYgODoxNCBwbSwgRGluaCBOZ3V5ZW4gd3JvdGU6DQo+IA0KPiANCj4gT24gNC8x
Ni8yNiAwMjoyMiwgTXVoYW1tYWQgQW1pcnVsIEFzeXJhZiBNb2hhbWFkIEphbWlhbiB3cm90ZToN
Cj4+IFNpbmNlIGNvbW1pdCBiY2I5ZjRmMDcwNjEgKCJmaXJtd2FyZTogc3RyYXRpeDEwLXN2Yzog
QWRkIHN1cHBvcnQgZm9yDQo+PiBhc3luYyBjb21tdW5pY2F0aW9uIiksIHRoZSBTVkMgZHJpdmVy
IGZhaWxzIHRvIHByb2JlIGVudGlyZWx5IHdoZW4NCj4+IHJ1bm5pbmcgd2l0aCBBVEYgdmVyc2lv
bnMgb2xkZXIgdGhhbiAzLjAgKGUuZy4gQVRGIDIuNSkgdGhhdCBkbyBub3QNCj4+IHN1cHBvcnQg
U0lQIFNWQyB2MyBhc3luY2hyb25vdXMgb3BlcmF0aW9ucy4NCj4+DQo+PiBzdHJhdGl4MTBfc3Zj
X2FzeW5jX2luaXQoKSByZXR1cm5zIC1FSU5WQUwgZm9yIG9sZCBBVEYsIGFuZCB0aGUgcHJvYmUN
Cj4+IGZ1bmN0aW9uIHRyZWF0cyBhbnkgbm9uLXplcm8gcmV0dXJuIGFzIGZhdGFsLCBjYXVzaW5n
Og0KPj4NCj4+IMKgwqAgc3RyYXRpeDEwLXN2YyBmaXJtd2FyZTpzdmM6IHByb2JlIHdpdGggZHJp
dmVyIHN0cmF0aXgxMC1zdmMgZmFpbGVkIFwNCj4+IMKgwqDCoMKgIHdpdGggZXJyb3IgLTIyDQo+
Pg0KPj4gVGhpcyBwcmV2ZW50cyBhbGwgZGVwZW5kZW50IGNsaWVudCBkcml2ZXJzIChod21vbiwg
UlNVLCBGQ1MpIGZyb20NCj4+IHByb2JpbmcgZXZlbiB0aG91Z2ggdGhleSBjYW4gb3BlcmF0ZSBj
b3JyZWN0bHkgdmlhIHRoZSBzeW5jaHJvbm91cyBWMQ0KPj4gU01DIHBhdGguDQo+Pg0KPj4gVGhp
cyBzZXJpZXMgZml4ZXMgdGhlIGlzc3VlIGluIHR3byBzdGVwczoNCj4+IMKgwqAgMS4gUmV0dXJu
IC1FT1BOT1RTVVBQIChpbnN0ZWFkIG9mIC1FSU5WQUwpIHdoZW4gQVRGIGFzeW5jIGlzDQo+PiDC
oMKgwqDCoMKgIHVuc3VwcG9ydGVkLCBzbyBjYWxsZXJzIGNhbiBkaXN0aW5ndWlzaCAibm90IHN1
cHBvcnRlZCIgZnJvbQ0KPj4gwqDCoMKgwqDCoCAiYmFkIGFyZ3VtZW50IC8gcHJvZ3JhbW1pbmcg
ZXJyb3IiLg0KPj4gwqDCoCAyLiBUcmVhdCAtRU9QTk9UU1VQUCBhcyBub24tZmF0YWwgaW4gcHJv
YmUsIGFsbG93aW5nIHRoZSBTVkMgZHJpdmVyDQo+PiDCoMKgwqDCoMKgIHRvIGxvYWQgaW4gc3lu
Yy1vbmx5IG1vZGUgc28gYWxsIGNsaWVudCBkcml2ZXJzIGNhbiBwcm9iZSBub3JtYWxseS4NCj4+
DQo+PiBCb3RoIHBhdGNoZXMgZml4IGJjYjlmNGYwNzA2MSBhbmQgYXJlIHRhZ2dlZCBmb3Igc3Rh
YmxlLg0KPj4NCj4+DQo+IEkgdGhpbmsgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byBzcXVhc2ggdGhl
c2UgMiBwYXRjaGVzIHRvZ2V0aGVyLiBQYXRjaCAxIA0KPiBhZGRzIHRoZSAtRU9QTk9UU1VQUCwg
YnV0IGRvZXMgbm90IG1ha2UgdXNlIG9mIGl0LiBQYXRjaCAyIGFjdHVhbGx5IA0KPiBtYWtlcyB1
c2Ugb2YgdGhlIC1FT1BOT1RTVVBQLiBTbyBJIHdhcyBhIGJpdCBjb25mdXNlZCBvbiBob3cgdGhl
IGNoYW5nZSANCj4gaXMgZ2V0dGluZyB1c2VkLg0KPiANCj4gRGluaA0KQWRkcmVzc2VkIGluIHYy
DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDUwODA5MjkzNi4xODM4MC0xLW11
aGFtbWFkLmFtaXJ1bC5hc3lyYWYubW9oYW1hZC5qYW1pYW5AYWx0ZXJhLmNvbS8NCg0KVGhhbmtz
LA0KQW1pcnVsDQo=


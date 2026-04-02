Return-Path: <stable+bounces-233060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ6cFmKYzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:25:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF438BD0B
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDB383031328
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299A3EF674;
	Thu,  2 Apr 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="tfzkYMqf"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB603C2787;
	Thu,  2 Apr 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146753; cv=fail; b=oiKmAseLczEkrfd4/OpizEtQF0VY4fCtTTbJY7dELv4x1/hYUK8mFGd83CaTnLiaa1hfQY4HseEzXnOivEiLvpqOpk1Hh56q1/2nZgVdAD6zzfB+KfdPcl/50MR23Rdm1gHZmS6v+0vDmWRsk/TZMhjredLIQrr7BSsaA7hjtiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146753; c=relaxed/simple;
	bh=C+XHZ8WhzITfveDJaXsBoNGUyC/CrmFqwE7bjP/TGVw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JqaxbSuc3lRGGS8JwnBWset7Llzbs1fqd+XseGyf69YBZ0K3krh1wxQKG4fVIOPuA17t08anCnORv52yx3Dafmwg+qpC0XOXWMGbfYwc72lig4q2VlUx1Aj2AamOHO1xmAr38ews1JNR7Dm+CDt8SQbfTMZ4zSdklOAChh/zRb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=tfzkYMqf; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUc1mD2z0VHPpa1hofPjx4OCPMU58rurKXqfIuqheosaTDfAy/W2u1jomkOXpef//CB6O1ZzG0Cv+IfcotV06DPyuWMOALdT6RLhhIslY8SEfsm4zBnTsp4vyFE1uAWXdvJHnr5m/Tnu0B1WgsBXRbyApVOPZMyU9cgIZY29+sJ00fRkbtIy5EKyRgfXiY19/EqZhXbo1kaeiXaTuPsm9HBR0JsEIR8mjHz+bWeFNdLPRSoCXVLr1akldz3Es0tBDUU2L0ptT1JYFhiQbRp8ApyLlwPxQz2xlYEUVUQJ9hNRU3LSKavBACNWnhbDVvd8/3VjPg+6Qg6+RNiJG6HfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+XHZ8WhzITfveDJaXsBoNGUyC/CrmFqwE7bjP/TGVw=;
 b=LEHtuzWJ9GL9iaIVs+vYTWQrAfrWJfJ9mI97QWNJgOfndMtnmVHbKKj8XvnnX9mZGXAs7QgUVBZVRkrJMUvkExSwaZNusMV+C9PME8O5SAxBinBbRB0aelFSpX56gmT5pKidiAUH8czmW/M6dWng4Fv7dzh5s0xG3isRPhGyt41X7cy6V9DwHHZIgNvuoHPXPrgEUd9afnZGeR9T+xVOr87NBcoHgh34Kazfy/m9lD11u6u/7TZlgfjOKnJ1LSr+HUYAPhnyo1HgB/dF42IwxbaUIqU8F9yMVsFuD4N0pnn38SXnFmjaoxlV1iwrlFzSx2IjwlkVkZw6YgmHQCU7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+XHZ8WhzITfveDJaXsBoNGUyC/CrmFqwE7bjP/TGVw=;
 b=tfzkYMqfS3eE1j++2gh/I3/UR96RyKL+inBcGXIWzGJzPXmOnhFhTCyuOE7cYW/8ByfiUXxUTbG1QAst6za8DZvhTqW9ULHWXpq9itWkmQoBaLz8lgpH7+VIIXq5SAmLo0A73UdrcLfVJyquCBgyz5AyKQfNF9SHo/gw3gRCPImBYnZWh4o/soTw4WfOl6oEcMSARD5RN2ZOI751keBDrniW8cdv79RizuWZWVhdYBWmajyF5+FJv6yHexJoe9ZtHCHpRAi//cqKBrtJLIobA4M6nhaTzaRWCEfCKQutRirtRR9kOljHa7PFgRESSCyIOGC9dq0ccktAHKBlpOhwQw==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by DB9PR07MB7770.eurprd07.prod.outlook.com (2603:10a6:10:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 16:19:09 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:19:09 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: [PATCH v4] uio: fix unregister_device
Thread-Topic: [PATCH v4] uio: fix unregister_device
Thread-Index: AQHcwrxvWsnEo9+U1EWsXpKuW9UsQw==
Date: Thu, 2 Apr 2026 16:19:09 +0000
Message-ID: <8927c7a9-e23b-4a02-a88e-1eb47fe287e6@nokia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|DB9PR07MB7770:EE_
x-ms-office365-filtering-correlation-id: d150bf3a-bb01-4c02-6d45-08de90d391c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 xOEu5EJZUzPV0GJyAbzKQAt4X7UUB6mqhY/vncaANTiJd4tDhQdA40L3GVCIF5nsVvFOPGHMQEoMSHjZjAiJUzQ4jZJV0kTjVda+/DylLtpbeCPN/AZjDBIl+eCQurDprOWZ/1hNuLvEWZ9G4GeyRYeziRCnNm9194MUkRpSmU6sEnwbWhFz/krMnZHCOHsVPyseXCOEwk1S2RG55QsSClrJBXMzjMGA5g0fP2++VCN+ImZRk6hZ5rnsbV/MyjSkm0uzHiMHVP2vC6Yo7K9pKhP4zgqWo8HIsSrcpG95epjUp3R/55WIVVSrs59CzmjRrCPIERrU429JtE6lt+N518pIUmMIJbSa9x3yNX0pgVuHiHh0dS96iK/s2mRKDR4TO0DpBg2N1+ozMK1EokrknjW5mjpbgSWpqrwoCPW+imzFoBi3UIuwUe+LhZy1pvrjJGlHQHSDGxZpeRdjpuTU+vvb+tlID5DqfXhhDwXm8tqdVZUUkTuRXm3p42bMhYuXnUnUKhfd3ASRYE0mgsT7mRUjhTWJ605rYQyqKAia/SxEVkeAVAYQFi/uDJr9rO+ukF7RNoBoj3rxgZg86sFjn4tIpfX8/0HY3OZI6NiGXVYByNUsRKusdO226oGW/60IiXUi6FgENs4WNoopmv6Dwsl40SWQ756uE6C+VH3E5+G9CqopotZFyCDFe5c0pNJzZF0DC2l9JZmDnEgSe0qT/AYLRw27rYsdwRIP6169LKU8BfUgxlpNnY4cst7YmIq2Ij20cEIlcKbiPZDabRVbDTJdJH2XUfyEjHUmdpCe00o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alhTU3BMekk2eSszSUpmdW9Fd3ZPT2tGSFVOMUZ6M0pVM1hUVjZKSURJWGhM?=
 =?utf-8?B?ekxYcVRueC90aUZnMHpvS1I3V2Rvbk9MMU1qOEMxSDhkTzV5ZWhBWWpOS0tt?=
 =?utf-8?B?c1lhd29nZ05xOW4ycHYwMUNicEQyaEJST2V5QTB5bUhWNXBVQVpTL2srQXNF?=
 =?utf-8?B?K01GaVVmM2pQWG1pUFgrUE5HYklWZnpsNTd1SUFDVzZ0elpqRUJjVmUyUEMy?=
 =?utf-8?B?TTNaUTFYaXBoTmIrT3pmNU12aTNCWW1aMHhBdUxrNTZpRHhaeXphd0FFUjIy?=
 =?utf-8?B?Njhkc0N5RWFIYko3cVJWT3dEeXgrdjY5VEhqRzBLdFA2Vk5JMDVyb1Z5OUNu?=
 =?utf-8?B?NkJYWVpCaVMwdUVjWjdBcU5CUTdVM3E1WHNZemliVGxrbzJ3ck9tR1RDQjlV?=
 =?utf-8?B?TjNrRGltT0Y4WWlZTDlsbFJWeHF4S2YxbnJnMkNrclNhUSt1L3VTQ2J6THNa?=
 =?utf-8?B?MEF2YnQwRmdYVnd5YlRLc3hudTl0T2crNTlSL21tK2RodHl3dHJqRU1RNklG?=
 =?utf-8?B?YWhyaHd4NVJhRDduTklQWEJxQ3Y5SDF5U0JCaWIwdzBlOHltaEUwYjlqZ1pm?=
 =?utf-8?B?aEx5WkhPeXNTZUUyZjg4WEhVOHY0eDhFOHZhTkNBVEpuT0U4dE1ERDByV2JP?=
 =?utf-8?B?Um1yZ1BFRmkvZ1d5TG9OZUZkcW1XTXFscm5mM1RVcTN0OG9peVlaa2x3azcw?=
 =?utf-8?B?ejF1T0ZqeE9BTW9PUTVqMG9vVENtRlBZT3ZVT1BUcnZSMnJCR0xYTUpZR1ZR?=
 =?utf-8?B?Q0pvUVRsTmRhb29pNnI0TGpibG9LTGduYjJpSExibFQxUUlRYVBJMkc0YzRN?=
 =?utf-8?B?bDhuTWN3cnUwdWF0MGU4N3dXY0ZBc1ZsZUxYcFpkNnV2VTFZV2wrWk01VTQx?=
 =?utf-8?B?U21mMWVINVNVclg3T0Q1RWI5ZkdRL0x1MHZuaG9JRkpGbEVjMThTenJJUFVX?=
 =?utf-8?B?djNtL0dzeFFEL29ncGJzbHhwMDZ4SFdMMVEvU1JpdDF1bE5WdGZEajYyejY5?=
 =?utf-8?B?R2ZEWHFOMm1GTWkyN3luK2NidDBSckFBWHkwMDRubGxza2lKMUdSSW9NQWFG?=
 =?utf-8?B?dkJaRXBuSTZ6VTBkUFhTSjlBSGlCdzJLSDNUbERVQUhXSkhLYURaM05OVTFv?=
 =?utf-8?B?dVFYM3dEaFhsSkQycTlXMEUwaWhSN1ovVzRTRFJRbkFPSGZIaGIreWlDT0ls?=
 =?utf-8?B?Z3pvT0xReStKUkxrWDhBNFRnYUpQTUpoMHdnQm9lL1Q4U1VocXNJZks2T0Va?=
 =?utf-8?B?cnRPdmRyd1VjUEM2TGNOeWQwV1B5WndOZ1V5enVQUXJyMWpTdlJRaG01c0Ft?=
 =?utf-8?B?b1BCN0RYTmVPaUJaUmN4YnArbFpMVG9UZVFCeDhKQWF0WEFQSzlZdFZJdzYr?=
 =?utf-8?B?clltZE12eE10VUFCdE1acDdORDEweUI0bHpXZEZBYjgxaVFFcXFXTmQ2Y2xw?=
 =?utf-8?B?OXJjRG1XTTA3OVVVbTdmaWQ2RDVJWXBFSUUyaTd5RkN3c2pkcFAySDBKV3BU?=
 =?utf-8?B?ckVKdnRZeGRTQzRESFpIRFREQWVvZ2pmb3lqczhCekgyVXNURERYZnZWcXZu?=
 =?utf-8?B?Q0JzMEVzQkRkNVhFZ2plWm1BZVJMbTA1M0grY2NrZkZpQ1lvcC90dUlmcWJF?=
 =?utf-8?B?THJhOWZCaUZiVDc1T0FRZUV5NWE0Tlhnem9PMzVnN1FLU2NranM5WmlGSzlr?=
 =?utf-8?B?bi8ySkNuOTFYUlFudmlmdkNnWTZXTEQ0bUJRcmlxZ2N4TkVnTGdCUndHc2pz?=
 =?utf-8?B?bzR2c1FKZ25xNkNPekpxWlJYRXp4R2xiZVJXV2R0UFp2ZFMvamNSbHNYcDMv?=
 =?utf-8?B?bnY3MUpSMVdmNFYwNnlVQWI1RzBhTHA1SHFPRmJzblUyWUU1Z2VLRWZOVmkx?=
 =?utf-8?B?cVZ4V1M1RFl4VlE0T1VGNE13U0ZJNXlaWTFySXpFTEJEU3JYNUlBQjFGVGZV?=
 =?utf-8?B?a3hGeExscFc1UzJaN1ZZRVc5TkdjUWlZd2ZlNzFBUkUzLytiMlpWSldiTnFZ?=
 =?utf-8?B?L0RiVEVWWjN3TjJQc1F2bHJvcWZQbkFwUVZhalpWWCs4Y0ZGQ01mWEhseUcv?=
 =?utf-8?B?RlVMTUN0RWFJSFFmdHoxK0xDcythZGxDNnZHQWhocVlvczltUXZ5dXdXT1NK?=
 =?utf-8?B?d1FjeXhaNjNSREd1dzhTYUE2MlMrNWJaM1hoVXJzby9WeTgvejNMdDdUMU9t?=
 =?utf-8?B?UGM1M0ZiR003OVBDSjVaWmYyNVZVQUZYVGE1UGNDWGhCOWJtQVg0TEJnaWRB?=
 =?utf-8?B?Wkcwa1g3Tm1hUmhMTXVjc2N1dXZmQkRjV1JKTndFQm5IeFk5eEtpc3hOaFVI?=
 =?utf-8?B?Ny96OXFtcGNvcDlXSHNVUnB2bGlvcFpkUkdTRTV6amE0eUd2M20vTFo1cXNP?=
 =?utf-8?Q?OrMD9mAwz8dLDhA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EE692F02F0B3A4185AD5C1CB3E010DC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7204.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d150bf3a-bb01-4c02-6d45-08de90d391c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 16:19:09.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seDvSSI0YcVFLxDCE2gdR7SDGhuuZS2aAkG1v6WR5tfBdvLAdSyoYM9c7/B/BJN/ZkmfvFFyF+LqYEwvzbKegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7770
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233060-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A7FF438BD0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dWlvOiBtaXJyb3JlZCB1aW9fcmVnaXN0ZXIvdW5yZWdpc3Rlcl9kZXZpY2UNCg0KV2hlbiB1aW8g
ZGV2aWNlcyBhcmUgY3JlYXRlZCBlbmQgcmVtb3ZlZCBpbiBwYXJhbGxlbCwgdGhlbiB3ZSBzb21l
dGltZXMNCmVuY291bnRlciBrZXJuZWwgdHJhY2VzIGFsb25nIHRoZSBmb2xsb3dpbmcgbGluZXM6
DQoNCiAgc3lzZnM6IGNhbm5vdCBjcmVhdGUgZHVwbGljYXRlIGZpbGVuYW1lICcvY2xhc3MvdWlv
L3Vpbzg5OScNCg0Kd2hpY2ggc3RlbSBmcm9tOg0KDQogIHN5c2ZzX2NyZWF0ZV9saW5rKzB4MjQv
MHg1MA0KICBkZXZpY2VfYWRkKzB4MmYwLzB4NzgwDQogIF9fdWlvX3JlZ2lzdGVyX2RldmljZSsw
eDE4Yy8weDU1MA0KDQpUaGUgc3lzZnMgZGlyZWN0b3J5IGNyZWF0aW9uIGlzIHBlcmZvcm1lZCBz
eW5jaHJvbm91c2x5IGFzIHBhcnQgb2YgdGhlDQpkZXZpY2VfYWRkIGNhbGwuIFRoZSBoaWdoIGxl
dmVsIHNlcXVlbmNlIGZvciB1aW8gcmVnaXN0cmF0aW9uIGlzOg0KDQogIDEuIHVpb19nZXRfbWlu
b3IgKGlkciBjYWxsLCBpbiBjcml0aWNhbCBzZWN0aW9uKQ0KICAyLiBkZXZpY2VfYWRkIChsZWFk
cyB0byBzeXNmcyBkaXJlY3RvcnkpDQogIDMuIG1hbmFnZSBhdHRyaWJ1dGVzIChwb3B1cGxhdGVz
IHBhcnQgb2YgdGhlIHN5c2ZzIGRpcmVjdG9yeSkNCg0KRm9yIHVucmVnaXN0cmF0aW9uIHdlIGhh
dmUgYnkgZGVmYXVsdCB0aGUgZm9sbG93aW5nIGZsb3c6DQoNCiAgMS4gY2xlYW4tdXAgYXR0cmli
dXRlcw0KICAyLiB1aW9fZnJlZV9taW5vciAoaWRyIGNhbGwsIGluIGNyaXRpY2FsIHNlY3Rpb24p
DQogIDMuIGRldmljZV91bnJlZ2lzdGVyIChjbGVhbnMgdXAgc3lzZnMgZGlyZWN0b3J5KQ0KDQpU
aGlzIGNyZWF0ZXMgYSByYWNpbmcgcHJvYmxlbSB3aGVuIHdlIGFyZSBpbiBwYXJhbGxlbCBjcmVh
dGluZyBhbmQNCnJlbW92aW5nIHVpbyBkZXZpY2VzLg0KVGhlIHVpby1taW5vciB0aGF0IGlzIGZy
ZWVkIHdoZW4gY2FsbGluZyB1aW9fZnJlZV9taW5vciBjYW4gYmUNCmNsYWltZWQgYnkgYSBzdWJz
ZXF1ZW50IHVpb19nZXRfbWlub3IgY2FsbC4NClRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGRldmlj
ZV9hZGQgZmxvdyBjYW4gZW5kIHVwIHRyaWdnZXJlZCwNCmxlYWRpbmcgdG8gYSBzeXNmcyBkaXJl
Y3RvcnkgY3JlYXRpb247IHdoaWxlIHRoZQ0KZGV2aWNlX3VucmVnaXN0ZXIgZmxvdyBoYXMgbm90
IHlldCBjbGVhbmVkIHVwIHRoZSBzeXNmcyBkaXJlY3RvcnkuDQoNClRoaXMgcGF0Y2ggY2xlYW5z
IHVwIHRoaXMgcHJvYmxlbSBieSBtaXJyb3JpbmcgdGhlIHJlZ2lzdHJhdGlvbiBhbmQNClVucmVn
aXN0cmF0aW9uIGZsb3cgY29ycmVjdGx5Lg0KQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIHVucmVnaXN0
cmF0aW9uIGZsb3cgYmVjb21lczoNCg0KICAxLiBjbGVhbi11cCBhdHRyaWJ1dGVzDQogIDIuIGRl
dmljZV91bnJlZ2lzdGVyDQogIDMuIHVpb19mcmVlX21pbm9yDQoNCkZpeGVzOiAwYzlhZTBiODYw
NTAgKCJ1aW86IEZpeCB1c2UtYWZ0ZXItZnJlZSBpbiB1aW9fb3BlbiIpDQpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgQmVsZXQgPHBoaWxpcHBlLmJl
bGV0QG5va2lhLmNvbT4NClJldmlld2VkLWJ5OiBJZ29yIEtsb2Noa28gPGlnb3Iua2xvY2hrb0Bu
b2tpYS5jb20+DQotLS0NCiB2NDoNCiAgLSByZWZvcm1hdCB0aGUgcGF0Y2gNCiB2MzoNCiAgLSBV
cGRhdGVkIGVtYWlsIHN1YmplY3QNCiB2MjoNCiAgIC0gRml4ZWQgY29tbWl0IG1lc3NhZ2Ugd3Jh
cHBpbmcNCiAgIC0gUGxhY2VkIDEyIGNoYXIgc2hhMSBpbiAiZml4ZXMiDQogICAtIGNjJ2Qgc3Rh
YmxlDQogdjE6DQogaHR0cHM6Ly9ldXIwMy5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZQ0KIC5rZXJuZWwub3JnJTJGbGttbCUyRkFNOVBSMDdN
QjcyMDQzNEEyQjBDQzk5QkMwQkRDRDc0RThENjFBJTQwQU05UFIwN00NCiBCNzIwNC5ldXJwcmQw
Ny5wcm9kLm91dGxvb2suY29tJTJGJTIzJmRhdGE9MDUlN0MwMiU3Q2lnb3Iua2xvY2hrbyU0MG5v
DQoga2lhLmNvbSU3QzA2NWZlMGRjMzRhNzQyYTgxNWQyMDhkZTkwYmVlNDk0JTdDNWQ0NzE3NTE5
Njc1NDI4ZDkxN2I3MGY0NA0KIGY5NjMwYjAlN0MwJTdDMCU3QzYzOTEwNzM0NjczODA3OTcxNCU3
Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGUNCiBVMWhjR2tpT25SeWRXVXNJbFlpT2lJ
d0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkDQogVUlqb3lm
USUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9Mmg3d2NzUFB5MGlpRkcwakNZQ1RnbDNpUnphbiUy
RlNJUDJGNQ0KIHhESnJ6SGM0JTNEJnJlc2VydmVkPTANCi0tLQ0KIGRyaXZlcnMvdWlvL3Vpby5j
IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvLmMgYi9kcml2ZXJzL3Vpby91aW8uYw0KaW5k
ZXggNWE0OTk4ZTJjYWY4Li4xMGUyNjVjNDkwMzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vpby91
aW8uYw0KKysrIGIvZHJpdmVycy91aW8vdWlvLmMNCkBAIC0xMTI1LDggKzExMjUsOCBAQCB2b2lk
IHVpb191bnJlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdWlvX2luZm8gKmluZm8pDQogCXdha2VfdXBf
aW50ZXJydXB0aWJsZSgmaWRldi0+d2FpdCk7DQogCWtpbGxfZmFzeW5jKCZpZGV2LT5hc3luY19x
dWV1ZSwgU0lHSU8sIFBPTExfSFVQKTsNCg0KLQl1aW9fZnJlZV9taW5vcihtaW5vcik7DQogCWRl
dmljZV91bnJlZ2lzdGVyKCZpZGV2LT5kZXYpOw0KKwl1aW9fZnJlZV9taW5vcihtaW5vcik7DQoN
CiAJcmV0dXJuOw0KIH0NCi0tDQoyLjQzLjcNCg0K


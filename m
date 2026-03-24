Return-Path: <stable+bounces-230224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JFF/OyLswmk4nQQAu9opvQ
	(envelope-from <stable+bounces-230224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:55:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFB731BEEB
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98F843055797
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CF31F9AD;
	Tue, 24 Mar 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=1seal.org header.i=@1seal.org header.b="Gzz3b02Z"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023081.outbound.protection.outlook.com [40.107.159.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58322D78A;
	Tue, 24 Mar 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382071; cv=fail; b=sjqhqqH8mhRfVrXi5Q0xtyMxn759uRHUPhInyYfdSFOsfojJfe1O0qVWtvsCeT0CpL/odPAz4HY5u/a5hKl10iEMQZzwEoOQSldxW44gz84IReZUcKyYhGPyuK2JZxQB3aN+K5zTga03gAW3Puu5u7Yh0pNTjtS8BAYWM3I+9Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382071; c=relaxed/simple;
	bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qxj8a4uZwFnZe0jyoT2zD2RD50uUhrVb6WEQzt/D4O9tG6naylVXJNaI7xwURSTttVl4WIZH70Ri5brJKZ8AEG9nCXauM/osslbYdb5Bs3Tfx4YIHgpPWgqVxxfObjCf0E5oIDZNlqKgHk0C2ofLCmG1E6s7US28J4SqdWi0TTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=fail (0-bit key) header.d=1seal.org header.i=@1seal.org header.b=Gzz3b02Z reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.159.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/DLoCf3KV1q5fYK9KY8t27xphJsOZmHwPoeOOJtBzahcCYHgAp1CIswuon0xCEATRWGtlCiubLMa7q9sJliv5Met2/2/Xkj9DtaSJQcHc6Ely/hYUJARyztX/DpUVDrWWvn5DVSUaZmnxklyk6rT65lL3IMB05B4rO2I0YHfJsCgMVPRw0fK+QEEI1GHNyekOsJdCEGoEmdfIeaut/hZ+X44Veg+IB67/CbleyctIlkzcXW5nMAWmoGCRfofqK8pmafIjPtj78xdxSXyNCmKVClFXc/JkgCOiIYq9IXiPvlVoHZt5Ilpp6NyYj5vYwjWOIEmStsFTd/2jmGbTjhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
 b=D190eDX6Kaxdjmyup6JEzh5VBh0XfpmsBnwwp8MZbJMxeVVlFwBiPcKpaigT90owexDzNDjIW6h3kLqcXVolrBn8vgvVPqd72cDGrFfo7+qSl5VvTynxW4XwdT1fC1W+hlKyio0ANWegUEaxupKxQPGkzq7djPKl28k2bqWlkcExZ6bpMfiv4b9EM+OauH2kbNrpL3lF0fRxVItKlj/rtvItQwFHhzmMnvSVO9a9C0QhoSVxVbKu955HM6IsNH5nqIpFbM4X92Tt742imCepSoM0JDLzTdqhZWTi/52CKFXshHVP9ErR62+gJax+eUrGdqr6VIz4pCOPls3makvayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
 b=Gzz3b02ZCT3sS+EPsMRuBbwdfsM2OtGVBBpMKixfwxq3l/DkBlJRFTsXyrthJdFAimE7AkPSaAdv1xa+j2xwqVgch7epZjWSlrWzsLMbuq6XPGUdwY6yqZReppAjDIvAHYMuLUWpJADczf+7LMqKfq+Yl37yTi/ZEyq/ltCU5SYkvyGYvRs/xCibVKCXIIbdoJcbCf70W/H3qQobSEeOvkRRT8JwAAC3/tmGR8s+NkKiS5g4I9+W6A3jBEHotWejqpaGJNkRTRE89TYN02sqBf9aAVqkEMQ00XuXPbD1iBKpA8YKeVFQUnMnMrWcu97HETMa9LmE0HqWrH4Qw9biLQ==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by VI0PR04MB12008.eurprd04.prod.outlook.com (2603:10a6:800:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 24 Mar
 2026 19:54:25 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 19:54:25 +0000
From: Oleh Konko <security@1seal.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] nfc: llcp: fix tlv offset wrap and missing bounds checks
Thread-Topic: [PATCH net] nfc: llcp: fix tlv offset wrap and missing bounds
 checks
Thread-Index: AQHcu8gEDiQXsiampkmSzf6iWkaApw==
Date: Tue, 24 Mar 2026 19:54:25 +0000
Message-ID: <f6323d4a8b3648ada51abcb1cb864392.security@1.0.0.127.in-addr.arpa>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|VI0PR04MB12008:EE_
x-ms-office365-filtering-correlation-id: da417ae0-2afa-4c84-4a17-08de89df26f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|7055299006|56012099003|38070700021;
x-microsoft-antispam-message-info:
 ornpRCbAaI8ANXsaeebHNYftAC9sjVRwt1rRKkaeCHy9yrxoUFbnm6VXSk4U2T66rfd+e1PTzDeRIcjPQ90ugrhdJ6rl4JDMYYkPqsbW4l7MPdVrxV2WVdRXgs0MFCTrwUT0zij8IeIB+shjpBhAOlm9LNLFhl9GaIIaYIaoqzmgIMFTG9MMSH+acxyGl9z06kM/QLTUohcU9MjxDMbC9QzqnUXl0weZlyGXFUQ6Yv25DZ03+0W1TRuIFwrNeVu8FHnkLqpH7DaDs0VVhZp1cs6V7IcDmbxiyA/qKqrbLaaxMcjVgMqz8Tp/S7yjCSGW6cMdu1BVN9xF4iS13Vou6kVuY21lYRFsdtABvj3m6L3Txfw2nKu/goMxkdFSB45lvKVjfCeoLHkSuaYFIOBVWZwB+4PEh+sVh5NXzJSsX9bQ+wW7E2sVjBtNtcIuPqMT5W7znOPuBgpqaRjK39OKOVc5rwLWgN3u5O3IYjGVTJzeVFnBPIvMThsww11oyIjO1OBaEDhhakPE9L4PHQwHzDbLsfpCr7Oq2kng93ZnFF5nNK05NvivQLBNVMWaz5PbM43t2RPMBsxilnJmtk4b2FSvotFKUvlVbJlc19nI49YoiwxVy8B1ko3WV4rkZkffAHh0xERk3bf/caEMnEBdkjsv69Yg5kpEk2cv8bf9lXt0ub/DA9OSszqa/lK5qemVkK2mudaLJDWv0iRuBbjYjUFw3cjqitEbCYnyIO1uBqOEVlG/oTV/k9DZ9jRLeoddCaR9HMTmFJgmNl71EuD6ck1Dw9b0E6/Cq/mvUKRhxg6R2HibYrdXp2c/J96qMe8R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(7055299006)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWhXNXJTc25XMzUxWlVJNm1PQ056R1puNmY0QUxWRVRhT1MvanNjVnlCNGZs?=
 =?utf-8?B?T1I4bHhySnVLSHJ4TGVuVHQ5QW9qQ2NtajR6L1JucGgrd2dzWnEwZVorSmRX?=
 =?utf-8?B?K2VxZkkvcGRzTDlLcyttNktvUFJ3cEV5cUMyQ1B4QklzRnZaRTVuK1orZW9n?=
 =?utf-8?B?OUNiL210TldvYVROTXduOEVGcWo1WjZ6dWdhNlVWYlppR0VqOFZwMlptbjVv?=
 =?utf-8?B?UlExQ0d5NExBUWc5L3hZTkhRdE1EM2pvM2NYQkF3ZHBDc0VxbDFkVFdOQWxM?=
 =?utf-8?B?R1J3RzR3Qnk0Nk81U2ZkZjdvM2M4TUpua3JDTkVuZ2RzaEZvcmpLUzNPTFcx?=
 =?utf-8?B?bG5WMnYyTDM2cWFUQTBKbjBYYkljQWxXQW16d1Y1QUd0dTU1U0xhZXB4ZDBr?=
 =?utf-8?B?UXpOZFdlRWhGRi9mK2ZqUnhVZHVWaWI2amY2UDltRjVLbVovc1BIVXV2NFVo?=
 =?utf-8?B?bTVQVDNlU3hBcTg1ekc2ZDBaL3lIRExEalRkUlBWWmJnSysyMkI1U3hkbWow?=
 =?utf-8?B?MmhRd05HOVp2MkNPSEhIa1Ywb1lqTUpxMlpxTUplSnpST0hoVys4RmcyR1RK?=
 =?utf-8?B?QzZMdmdUUy9vZVRnVU9hbTlIeGR1ZnN1TUFVRjZLdkVPL1JpT0JXbFo5bllF?=
 =?utf-8?B?QnYxL0NZb2xsd0F3V0RDM2JzcEFQWmFIaHIxRXNtbmRRYUhIckF1OFhRRHhY?=
 =?utf-8?B?VmZycGFWajJqY0VpMTRZSnQ5M3BleVlPbXRHbnd4UmpsNnBSZHBzazg3YS9I?=
 =?utf-8?B?NkdiMW5iVVV0NHVQejlpMEk3U2VMMEZCQ1BQM2Nkc3MrblBGdXBsLzRHWGsy?=
 =?utf-8?B?Vmh2NThJQmt3ekVPK1poVjVQaHY5YU94azdFM3VCeHVCVmw4T0VBTGN3aVlk?=
 =?utf-8?B?NWxnQS9LdXU5S2huUWc5YkNJZjdNeGZ4U0F6Uyt1emFIZWtNR0lNOENWY3lK?=
 =?utf-8?B?M08vSzdwbFpqSzduaDIzOGtkQ1RaTk04aHJkV3I0Rk5xVExuMFZYcG9GZm1V?=
 =?utf-8?B?NnpyRlZIOVYwZ09qYjZ5cGRVZ0huNWxadXBrNlJrWnFMbDdJY2VVL3Vaem9s?=
 =?utf-8?B?azM1RENpZFBia0FIZEhKNm0zY1draEZUelBQdjVIdktoM0wvN3dRUEYzQ2JY?=
 =?utf-8?B?ejdNU3dPS3Byai9qSndEMFh1Q3dac1d0SlFMellXd2p6Qk95NjJnY0lYRi81?=
 =?utf-8?B?ZmhDWEVvMk5LY2RrZUM2blJERDE0azZ0amFJbnBQSkF3TVJ3dDFUZkdtZXlX?=
 =?utf-8?B?SDRjcnI2Y3E5eEJVb0FGSmhDaWFJOW9VVnBoMTVnbkU4Z3E1UXZCTE4wYU1D?=
 =?utf-8?B?bnlMQUIxVndaZWc4VnZtSUtZdlRXWDNBM3lyZXFWRVo4VU1YbUNnMC9CV05k?=
 =?utf-8?B?TEk2bmJBSk9ZeEZtQ0U3OWxpMVkxby91Rnl0MFljci9reDRUaFJZUjBkaDVr?=
 =?utf-8?B?QjB1VHV1RHV4VVJUWXZUNzRNR3YzRWI3aitPZkFIbHN2aW9GeDJuRk8zNTZV?=
 =?utf-8?B?VUFoVnc2SDBUWC93b25QZjVQb0I4bU1nUmNab1ZwVnVPQ1RSVHNFRDNLZVV1?=
 =?utf-8?B?dlAxNEhyT1ZjclZvYTdBTXp3RFc2cXc4a3pnYndNaE5zK3JGSXlLWHB2YzRK?=
 =?utf-8?B?Mk54MkVoNmFBQXZwSnZKYlFSTHRUd0pMMzBrVDhGVXExM2x1RUhLU1dpZVI4?=
 =?utf-8?B?RUVkcFM2bGxod0FUUVlCN0xJUSt3NHVrekZ2Uys3TnBoTkVBbSs3SGxBZWRx?=
 =?utf-8?B?Ni9FT25USmZyOFhnb1pMWDRtd3c0Yi9kcHczSmMxVGhEWUlzTHlRSWFBelVp?=
 =?utf-8?B?d2VNM0Z1Mm9wVEdBYURWSXF0cVkxWmN1SUZQaStOWGFTUEU0UGhlZkJ1SHZE?=
 =?utf-8?B?YTZJSlB6T0U5SER6cEtNSFdSZUNEUVY2UDVzWGJlSmpPdDdpTzQzL1RCVU1t?=
 =?utf-8?B?eDd2N293QVF3OUk2NU9DRHZrNWVCcDFDNnVoMGFyTzFCT1Q2dGdoSVc2MENy?=
 =?utf-8?B?RVpvWmNJNEUxNFhKVThrSGkxOXZMYjN3TUMzMmdJdFlROVVHWE5NMUx3Smxz?=
 =?utf-8?B?aVhoWXI4UkRLclRzN083UmZsYjYxalRFbytKWDAwK1ZEMzhvN05Xd01YU3VQ?=
 =?utf-8?B?UFlyVCtQSXN5b25md0RuZTYvaCtCc2psY2tJNWMrOGNialhoOGhvNzdSaXZR?=
 =?utf-8?B?SVpJZE1pY2FuUUFiazEvS2wxTG03Z2ZmbFdERjltK3Q1NzJIVjR1VlV6VkZo?=
 =?utf-8?B?WVlReFZ2bHN1ZjlEZzVHc2pLZEJNeVViWkVtalVFR2dSeUFvNkc0TkowZmM4?=
 =?utf-8?Q?gTmpXkDLaax/7ffhqr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFFAB0A0D4A8DC45A061A616D935E705@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da417ae0-2afa-4c84-4a17-08de89df26f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 19:54:25.6851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjH1MAd6uY9B748ysDF6Aue2uxuVBe8JUJXI001uVI1xSEz4i/FAweUEzcj8VY6+C7ZxG191ydErHExUP9ZV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12008
X-Spamd-Result: default: False [3.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[1seal.org : SPF not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-230224-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[1seal.org:s=selector1];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[1seal.org:~];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.0.0.127.in-addr.arpa:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEFB731BEEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bmZjX2xsY3BfcGFyc2VfZ2JfdGx2KCkgYW5kIG5mY19sbGNwX3BhcnNlX2Nvbm5lY3Rpb25fdGx2
KCkgaXRlcmF0ZSBhCnUxNiB0bHZfYXJyYXlfbGVuIHdpdGggYSB1OCBvZmZzZXQuIG9uY2UgY3Vt
dWxhdGl2ZSBUTFYgY29uc3VtcHRpb24KY3Jvc3NlcyAyNTUgYnl0ZXMsIG9mZnNldCB3cmFwcyBh
bmQgdGhlIGxvb3AgbWF5IGNvbnRpbnVlIHBhc3QgdGhlCmRlY2xhcmVkIFRMViBhcnJheSBib3Vu
ZHMuCgpib3RoIHBhcnNlcnMgYWxzbyByZWFkIHRsdlsxXSBiZWZvcmUgY2hlY2tpbmcgdGhhdCBh
IGZ1bGwgMi1ieXRlIFRMVgpoZWFkZXIgcmVtYWlucywgYW5kIHRoZXkgYWR2YW5jZSBieSBsZW5n
dGggKyAyIHdpdGhvdXQgdmFsaWRhdGluZyB0aGF0CnRoZSBkZWNsYXJlZCBwYXlsb2FkIHN0aWxs
IGZpdHMgaW4gdGhlIHJlbWFpbmluZyBhcnJheS4KCmZpeCB0aGlzIGJ5IHdpZGVuaW5nIG9mZnNl
dCB0byB1MTYgYW5kIGJ5IHJlamVjdGluZyBpbmNvbXBsZXRlIGhlYWRlcnMKb3IgdHJ1bmNhdGVk
IFRMVnMgYmVmb3JlIGRlcmVmZXJlbmNpbmcgb3IgYWR2YW5jaW5nIHRoZSBjdXJzb3IuCgpGaXhl
czogZDY0Njk2MGY3OTg2ICgiTkZDOiBJbml0aWFsIExMQ1Agc3VwcG9ydCIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5v
cmc+ClNpZ25lZC1vZmYtYnk6IE9sZWggS29ua28gPHNlY3VyaXR5QDFzZWFsLm9yZz4KLS0tCiBu
ZXQvbmZjL2xsY3BfY29tbWFuZHMuYyB8IDE4ICsrKysrKysrKysrKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0
L25mYy9sbGNwX2NvbW1hbmRzLmMgYi9uZXQvbmZjL2xsY3BfY29tbWFuZHMuYwppbmRleCAyOTFm
MjZmYWMuLjE1N2FmZDYyZiAxMDA2NDQKLS0tIGEvbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMKKysr
IGIvbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMKQEAgLTE5Myw3ICsxOTMsOCBAQCBpbnQgbmZjX2xs
Y3BfcGFyc2VfZ2JfdGx2KHN0cnVjdCBuZmNfbGxjcF9sb2NhbCAqbG9jYWwsCiAJCQkgIGNvbnN0
IHU4ICp0bHZfYXJyYXksIHUxNiB0bHZfYXJyYXlfbGVuKQogewogCWNvbnN0IHU4ICp0bHYgPSB0
bHZfYXJyYXk7Ci0JdTggdHlwZSwgbGVuZ3RoLCBvZmZzZXQgPSAwOworCXU4IHR5cGUsIGxlbmd0
aDsKKwl1MTYgb2Zmc2V0ID0gMDsKIAogCXByX2RlYnVnKCJUTFYgYXJyYXkgbGVuZ3RoICVkXG4i
LCB0bHZfYXJyYXlfbGVuKTsKIApAQCAtMjAxLDYgKzIwMiw5IEBAIGludCBuZmNfbGxjcF9wYXJz
ZV9nYl90bHYoc3RydWN0IG5mY19sbGNwX2xvY2FsICpsb2NhbCwKIAkJcmV0dXJuIC1FTk9ERVY7
CiAKIAl3aGlsZSAob2Zmc2V0IDwgdGx2X2FycmF5X2xlbikgeworCQlpZiAodGx2X2FycmF5X2xl
biAtIG9mZnNldCA8IDIpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwogCQl0eXBlID0gdGx2WzBdOwog
CQlsZW5ndGggPSB0bHZbMV07CiAKQEAgLTIyNyw2ICsyMzEsOSBAQCBpbnQgbmZjX2xsY3BfcGFy
c2VfZ2JfdGx2KHN0cnVjdCBuZmNfbGxjcF9sb2NhbCAqbG9jYWwsCiAJCQlicmVhazsKIAkJfQog
CisJCWlmICh0bHZfYXJyYXlfbGVuIC0gb2Zmc2V0IDwgKHUxNilsZW5ndGggKyAyKQorCQkJcmV0
dXJuIC1FSU5WQUw7CisKIAkJb2Zmc2V0ICs9IGxlbmd0aCArIDI7CiAJCXRsdiArPSBsZW5ndGgg
KyAyOwogCX0KQEAgLTI0Myw3ICsyNTAsOCBAQCBpbnQgbmZjX2xsY3BfcGFyc2VfY29ubmVjdGlv
bl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCQkJICBjb25zdCB1OCAqdGx2X2Fy
cmF5LCB1MTYgdGx2X2FycmF5X2xlbikKIHsKIAljb25zdCB1OCAqdGx2ID0gdGx2X2FycmF5Owot
CXU4IHR5cGUsIGxlbmd0aCwgb2Zmc2V0ID0gMDsKKwl1OCB0eXBlLCBsZW5ndGg7CisJdTE2IG9m
ZnNldCA9IDA7CiAKIAlwcl9kZWJ1ZygiVExWIGFycmF5IGxlbmd0aCAlZFxuIiwgdGx2X2FycmF5
X2xlbik7CiAKQEAgLTI1MSw2ICsyNTksOSBAQCBpbnQgbmZjX2xsY3BfcGFyc2VfY29ubmVjdGlv
bl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCXJldHVybiAtRU5PVENPTk47CiAK
IAl3aGlsZSAob2Zmc2V0IDwgdGx2X2FycmF5X2xlbikgeworCQlpZiAodGx2X2FycmF5X2xlbiAt
IG9mZnNldCA8IDIpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwogCQl0eXBlID0gdGx2WzBdOwogCQls
ZW5ndGggPSB0bHZbMV07CiAKQEAgLTI3MCw2ICsyODEsOSBAQCBpbnQgbmZjX2xsY3BfcGFyc2Vf
Y29ubmVjdGlvbl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCQlicmVhazsKIAkJ
fQogCisJCWlmICh0bHZfYXJyYXlfbGVuIC0gb2Zmc2V0IDwgKHUxNilsZW5ndGggKyAyKQorCQkJ
cmV0dXJuIC1FSU5WQUw7CisKIAkJb2Zmc2V0ICs9IGxlbmd0aCArIDI7CiAJCXRsdiArPSBsZW5n
dGggKyAyOwogCX0KLS0gCjIuNTAuMAoK


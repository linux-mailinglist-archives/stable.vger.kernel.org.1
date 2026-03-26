Return-Path: <stable+bounces-230464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB93OIM5xWn/8AQAu9opvQ
	(envelope-from <stable+bounces-230464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:49:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60655336437
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A672C318BE8A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C702DECC6;
	Thu, 26 Mar 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="WRqORwsW"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021114.outbound.protection.outlook.com [40.107.130.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252F2D6E4B;
	Thu, 26 Mar 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531975; cv=fail; b=QRu58PNQ6n3vyIFMd334SwGZSqMOp3cTFH+v0OqKw8HjRPe/bDoX/EPdZOne8+09ZZD7PvLZhtJcaxsd4pHJ8CQnqvmMp6Mt2OVZRQ/A3mDpRTBBwrQT+ja/4HY6gQTvD0BpLjzrX8dK3/ZMEeBMrmHNgVnc87j/ENzWYV1WOQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531975; c=relaxed/simple;
	bh=Nz/NsebAXnofWjEw6aqwTRhwpHYrGm0wtp90N/IAAZ0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=p7fPAPzruN3cSWt/oDJaOvtA19L7lEetYHZQtVHEeDtBhxEJFzmT6xbuQLRqBdVUrLymHy6zTSUUG5iRrlGwqiZio8ktNFbq4nA8w/HdKBqr9668Uhd3ClV3anZD3954yAmU6f39NPks28VuvYbpnlHhQ1tk3Cnmsu/8dtx6JL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=WRqORwsW; arc=fail smtp.client-ip=40.107.130.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz+VSUDdLH2rjeTvRg4CuBH7tsbIyaQzVe7tT8MFMckn2WHzzd1We3z+hDCIFPpp4FkKreLndOcTL+XfrScKijP7SILZq9H7UyaPNaqEWEaN+W3pHnMv4BNDpVRA0MIruOGbyL4cn1f2NDbdedYUJBtqUujHZ89pQf7lC0lmFyrMCybfm2Ugh8mGldw87ZXdsKYOA08fJA0BThBU8xFl9TmdsMqVICdhxE2I27BE/7mf6G+PhavHAQniMEvTMIIWD59OqIiJay/qFpkcDyOa6/pGb2Dc+Riq0kYf+BT67rK3qwb2ukSU30Hf+wJ9O1ABz0DEHw619m3RY4het5pUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz/NsebAXnofWjEw6aqwTRhwpHYrGm0wtp90N/IAAZ0=;
 b=axAcOL7eERKwwlq9CUZZmxMtNpcrRQiFDoAfqPjdqJ/CZIMuVpoWv613mvAMTRMT6Mn+6wjUyEsl3uEA+0E3lNORWaq38vW7bIpeIBZy3Nhds4EINoYQQ/Ue17JTGsDW4ElpniO+RLq2hI2nLF9Oul8TXkUWnc2ir7tdGdQ63aiD6mWXPkZlLVEpiGTLOkACKXEm5cuDZP7jcSNtCr+m9r4K8B5ky2x/ZinBHvBxZpRrAxBI6MqIz6J0jexPXAkUthP5/GrOaA/wCQACEKRQ3XkGD8viPi7qb2NLiq0W/YHEXRfpdy9OYefNTkYUpzO713LH+yzE7EgL4X2JhaRTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz/NsebAXnofWjEw6aqwTRhwpHYrGm0wtp90N/IAAZ0=;
 b=WRqORwsWyCRUZn9zwQX15+fnz/X/FfwtB65qJU/X8wk3RCgsfAOmqXcPu+hkEGdWUt0qqsFvHOxJ3R0W1rxecSZcrG4hEeH3yHLAW53pVRHDOUBXUleOFZYIObD69QDjJBnWt96ts+FJNLhPOUXwq8Rq5zRbHfvc1Y6ASLkcm065qxhldssrTlZ54/B02GKL+zeo7WyfiDD28lrSLgyzyN/HwdbqPFqhCUN0bYl4ejiGXCcSR5aNwuPFKZNYuI/dwx3wnoiSsTYXxk0NJoazLvyZVtiu9+xa6Jp9vlbxD1wxyrNyOpm8bB9v/zpCRoBPLHjKrwbsBYYetQE37YhT2w==
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com (2603:10a6:102:e0::20)
 by AS8PR04MB8500.eurprd04.prod.outlook.com (2603:10a6:20b:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 13:32:50 +0000
Received: from PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d]) by PA4PR04MB7679.eurprd04.prod.outlook.com
 ([fe80::7e8:b5fc:9762:7a6d%5]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 13:32:50 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Topic: [PATCH v3] Bluetooth: hci_event: move wake reason storage into
 validated event handlers
Thread-Index: AQHcvSUK7PL4RIBG1k6HyOgoH+VmKw==
Date: Thu, 26 Mar 2026 13:32:50 +0000
Message-ID: <9b8a0917d56b4a67ba541e8a5eb3abb8.security@1.0.0.127.in-addr.arpa>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7679:EE_|AS8PR04MB8500:EE_
x-ms-office365-filtering-correlation-id: 15c32368-2d29-45e7-adad-08de8b3c2cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|7055299006;
x-microsoft-antispam-message-info:
 YMSAkovzt0NfPcG4MII9uXSek/yx+w6aSQalkqGQLX1a3hplea0LRwFBw8uQCziAnd4GY8dGVzKLNywzXfELkG7PkF7OokewLUZKdNhDOPWkTFkGjCM1YRJRHwfUvUrmfXeM4IXhsqBX1DfWNbuv4BYCv1ak25+BlSkPK7CXQOf7mhMGOO5k0++wLNov31yLUqvTxWp901j/4S3lRavZNDlu/X0/6mEeQuZPsIjIdtp7Z1es8fcvipEGlzlaS6YzBhZldKWz+B3FhIgJuEoIadMP270bgVKhOaVpJaKEbMbX5MM//jSg4ftPm4JoHreSCdgiKb/WmnCHQdLrsCm1340YezlaRjpZzpke3E5dCtTRwFCnR24Q79MM5uIQgiDJyJEvczpTXkSHxKjSUZubnHrC4IL8yHaB0u2wER+m2PXziQa5aV6VVQU5BK1RBNBfENlGmFUfOP0fS9IWeoZsT7sSCancMsHdHwPKOtC5r91KHFKhTnvMmKEOHYHo8P95MVDEZu0BBwtz3HkHDZqse2r2vZooihl0dkypWoK1x8e8cP4HPxHVRuohAjfcBSl0VUapSBcidZV1RCNmp5WCF7Z2BasHMRtdTP41klciXKvKpZTggHDBqx0YTAZGaS+xw/z0hFJRnLc+Q8el7zt/SmtQ8v38Ws24Og+P8NPDEJrRnfS+ivuJZU413PMDB698faO0pgFSOuMOv0TBQZVdgEh9D6yodaP6Br2scRxMjP1Ev3k1+dnWjRTFriOlzwuLdU1w3r6W29JlJn2OimH8JmMJTiR0HMSVhtefn3bz2AfpgOZb4SXG1XqSgyf7/hxj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7679.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3NrczkzYkEwOFVkLzVZQXZjOHVyZm5aYWJqaWhSRTFPRXVRcDduWWVaNERZ?=
 =?utf-8?B?U2JEQVp4YmRKMU42VTFBTkZtZ3F1TnV5NVZiTEQxeWZRcGRYRlAxQXZMTkNX?=
 =?utf-8?B?L3pvWE85ZGFYRkljUllwbHpBaHBubkxEVGgzR25VbnBkWUxRN3JzSWRmdys5?=
 =?utf-8?B?bWkxUWZmR0RKK0I1amg1L2RIQTc5dVcrcGRxdVhiZ0JZbFhQUFRFQVlldmk0?=
 =?utf-8?B?QmxEekE1enp1eXAxMHhPekQyclZJVWFmTUM5M1VPbGdWTnBTQzROL0FjQXpM?=
 =?utf-8?B?VHRtQlF3K0ZnUXhJcjQ4aDFXd2N4WnpJSDRtWDlwendqNlZkQ0RCNlVsdERy?=
 =?utf-8?B?VjJYQ1ptbG9KVVByWGNiWEVGcTBTYUpVY1E2S3NSTzI2d3loUEhvM3BKa1pn?=
 =?utf-8?B?clpldTNxQVE0WEQ4aHZIMlJQNml0MlYzNzA1NWZoQTFpcnFnYzA5cnp5NmFj?=
 =?utf-8?B?Mm9oTUYrKzN4bmlCV1NvMFBETEJ6S2krRFE3VHRra1ZOcW94RjZRRk5DaC9Y?=
 =?utf-8?B?SEtRRDgvc1Y5WkpEUW56TFhHSmp0azJFampkaW5xVEpNdFcrUS9kZi9QdHVY?=
 =?utf-8?B?UU9oY3ZzRGFFWWlZWW9vSGdLUm1QUko1a1dJbFdIQVN5cHprSmsydEtSbHl5?=
 =?utf-8?B?VGR5Ynl0TTNyakduaGVYczRWNDM5NXFYcnhvdzVBOXczNUZhenF4aVZTR1d1?=
 =?utf-8?B?SFBxbTREekpBdGI2S2p1LzZseW9SekZjNnlZS01PdDBTRGIwWERjd0ZrYmhp?=
 =?utf-8?B?U200TzQwWkw0ZCtiSEZNdnZVaUd5QThUb29WTVR2TDhwaDBiYldGQUZDTURW?=
 =?utf-8?B?aEkvVnIwMXVzMUkrbEhObFNMdldaZWQ4QWxGYW9MSGRTc2hHRlluWEVnejJ5?=
 =?utf-8?B?OEh1YTQ4SWRNYkpnVkZOM0QzVm9hNWxZQjJXZkRzNXM1bDgxcloyTjJLNkNz?=
 =?utf-8?B?ZEpNbjVsMVJZWFlPZERoTFZMdDlIV1JoL29aMXM5SmJwUlcxOEVOZS9iMlh5?=
 =?utf-8?B?RzdCa1ZNSGx3YlZXb2w1d3UxeURxOTMxQ2dUMis5Yk12YXEvTXVKTEYxeEY1?=
 =?utf-8?B?ODB0U0Q4WXllRXQvR3doTDNkcTdKZWJmYVlDTUZvTytlWjVZRm1OajA0dUhG?=
 =?utf-8?B?QVBjT3JJcDhxRlhIa3R5dXF2VE1tT2tnWkcvUjVWay8zaG1BaWhRdFBkSi9P?=
 =?utf-8?B?VDBhMVhWbUk4RHNWcnRxWEIyL05zcXV5eEtlZWswWFFKYUVUZVFpeUgrTFhB?=
 =?utf-8?B?cU5YNHhIRGVFNVAza2t1TWNoUmR2RUxXYndoUkcyN2RpeitnT3QrWEFwZHU1?=
 =?utf-8?B?U3RDbEJQcU1FLzRFNzc4UGVZRHpJQ2dCR2tqdWkvYjFybTl4Q0lpQUpnL2RB?=
 =?utf-8?B?MmxkYU1OV3ExTUdsektxY20vWFczcmR2Z1Z2Y3ZzaGNqVTRwZjg4TUNwN3lI?=
 =?utf-8?B?OUxVM2pRcDZpN1BUeXdoSU9yYXFkMHgxK2RGb2RIMkdGcFl0Y2R4aUlQSVJT?=
 =?utf-8?B?OGdzNUdGOGR3bXRhTmNkdk45ckZPK21TRE4xTllrN2orUmMzYUk2U3FaWHNX?=
 =?utf-8?B?c0dUQ01jd01nQ0RobjlKZDVVRlpGdjh5REJUQlpzRmdPWkgrTk55MnNBQndS?=
 =?utf-8?B?d2dNMElLT0hzbGx3Q2FzSG9RYWlZT0p6SGp6ZW56QVFlbjduei9hZ2t6elhu?=
 =?utf-8?B?UlVmOGlWNjJBUit2OHNqai9FYU90STRjZUtzYTh1dFRNL25ZYUVCam55MDhC?=
 =?utf-8?B?RzA4dEh5cThJR2JxTkppYlptbXRrZUx2eDRhcjR2ZmxrS0p0NC9rUGV3Z25w?=
 =?utf-8?B?QXJpcmVZK2I4cUhQU3pCRmZkU3FPdGh2d1ZGc01KRk1qQk83M2tHRzBrN0R1?=
 =?utf-8?B?eWFob0dXUk5JUTdWYU9nNjltcHl5OUUzN0RFVkY1eXJjYU9GRjJaTWd6dmd6?=
 =?utf-8?B?M3YrTjB1SjE4dnFSelpxSkJ1RjdaSHJ1MDVqbU9pSVhHc3lELzU1WVRUY2tU?=
 =?utf-8?B?QU10SWx3SndVOHZSeVBNSEFET3Y0N2ptcVhEblhMTkN6Y2lLWHp1Rnp6RDcy?=
 =?utf-8?B?YitBcjZ4R09vbUpoQUVoZElQd0phUFVlY29MMTloK24zVmdPb1VqRVdVcmFY?=
 =?utf-8?B?cWxEUmJTeEVMSEp5dWU5OTdaY3RmK28vWmgrNWxpTzUzbWN4ak5tSWRPUlhM?=
 =?utf-8?B?WFM0eU95UzdlN0hTbVVCWG1iRS9hM3B1MllDQ0NkZXBPcVJBaE1FMEtQYXQz?=
 =?utf-8?B?RVlGMUErN1dWdDRwUVZaSFVMZVlvSEViT2hJVWtHK09uSkU3YnZneWdnMity?=
 =?utf-8?Q?Vvgfpay0cVLZyCu2Rm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCE344AEC0D68F499F7F3E34A668EDCE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7679.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c32368-2d29-45e7-adad-08de8b3c2cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 13:32:50.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziDwfe6ikqLtrJ0tptr5gwW1F6wEm3KkQT94njS0nEkPN9nC35O22XTz3kGOtksJVjbOccy2EXSxAyUKLbdulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8500
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230464-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[1seal.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1seal.org:dkim,1seal.org:email]
X-Rspamd-Queue-Id: 60655336437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbSBmMGU4YjJhYmFmNGE4OTVmYWQ4MTc1NjI3NzAxNDU4MmM3NzM4MDhkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5vcmc+CkRhdGU6
IFRodSwgMjYgTWFyIDIwMjYgMTQ6Mjk6NTggKzAxMDAKU3ViamVjdDogW1BBVENIIHYzXSBCbHVl
dG9vdGg6IGhjaV9ldmVudDogbW92ZSB3YWtlIHJlYXNvbiBzdG9yYWdlIGludG8KIHZhbGlkYXRl
ZCBldmVudCBoYW5kbGVycwoKaGNpX3N0b3JlX3dha2VfcmVhc29uKCkgaXMgY2FsbGVkIGZyb20g
aGNpX2V2ZW50X3BhY2tldCgpIGltbWVkaWF0ZWx5CmFmdGVyIHN0cmlwcGluZyB0aGUgSENJIGV2
ZW50IGhlYWRlciBidXQgYmVmb3JlIGhjaV9ldmVudF9mdW5jKCkKZW5mb3JjZXMgdGhlIHBlci1l
dmVudCBtaW5pbXVtIHBheWxvYWQgbGVuZ3RoIGZyb20gaGNpX2V2X3RhYmxlLgpUaGlzIG1lYW5z
IGEgc2hvcnQgSENJIGV2ZW50IGZyYW1lIGNhbiByZWFjaCBiYWNweSgpIGJlZm9yZSBhbnkgYm91
bmRzCmNoZWNrIHJ1bnMuCgpSYXRoZXIgdGhhbiBkdXBsaWNhdGluZyBza2IgcGFyc2luZyBhbmQg
cGVyLWV2ZW50IGxlbmd0aCBjaGVja3MgaW5zaWRlCmhjaV9zdG9yZV93YWtlX3JlYXNvbigpLCBt
b3ZlIHdha2UtYWRkcmVzcyBzdG9yYWdlIGludG8gdGhlIGluZGl2aWR1YWwKZXZlbnQgaGFuZGxl
cnMgYWZ0ZXIgdGhlaXIgZXhpc3RpbmcgZXZlbnQtbGVuZ3RoIHZhbGlkYXRpb24gaGFzCnN1Y2Nl
ZWRlZC4gQ29udmVydCBoY2lfc3RvcmVfd2FrZV9yZWFzb24oKSBpbnRvIGEgc21hbGwgaGVscGVy
IHRoYXQgb25seQpzdG9yZXMgYW4gYWxyZWFkeS12YWxpZGF0ZWQgYmRhZGRyIHdoaWxlIHRoZSBj
YWxsZXIgaG9sZHMgaGNpX2Rldl9sb2NrKCkuClVzZSB0aGUgc2FtZSBoZWxwZXIgYWZ0ZXIgaGNp
X2V2ZW50X2Z1bmMoKSB3aXRoIGEgTlVMTCBhZGRyZXNzIHRvCnByZXNlcnZlIHRoZSBleGlzdGlu
ZyB1bmV4cGVjdGVkLXdha2UgZmFsbGJhY2sgc2VtYW50aWNzIHdoZW4gbm8KdmFsaWRhdGVkIGV2
ZW50IGhhbmRsZXIgcmVjb3JkcyBhIHdha2UgYWRkcmVzcy4KCkNhbGwgdGhlIGhlbHBlciBmcm9t
IGhjaV9jb25uX3JlcXVlc3RfZXZ0KCksIGhjaV9jb25uX2NvbXBsZXRlX2V2dCgpLApoY2lfbGVf
YWR2X3JlcG9ydF9ldnQoKSwgaGNpX2xlX2V4dF9hZHZfcmVwb3J0X2V2dCgpLCBhbmQKaGNpX2xl
X2RpcmVjdF9hZHZfcmVwb3J0X2V2dCgpLgoKRml4ZXM6IDJmMjAyMTZjMWQ2ZiAoIkJsdWV0b290
aDogRW1pdCBjb250cm9sbGVyIHN1c3BlbmQgYW5kIHJlc3VtZSBldmVudHMiKQpDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2Vh
bC5vcmc+Ci0tLQp2MzoKLSByb3V0ZSB0aGUgdW5leHBlY3RlZC13YWtlIGZhbGxiYWNrIHRocm91
Z2ggaGNpX3N0b3JlX3dha2VfcmVhc29uKE5VTEwsIDApCiAgYWZ0ZXIgaGNpX2V2ZW50X2Z1bmMo
KSwgYXMgc3VnZ2VzdGVkIGluIHJldmlldwoKIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgfCA4
OSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAyOSBpbnNlcnRpb25zKCspLCA2MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1
ZXRvb3RoL2hjaV9ldmVudC5jIGIvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYwppbmRleCAyODY1
MjlkMmUuLmMwZTBiNGExYyAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYwor
KysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jCkBAIC04MCw2ICs4MCw5IEBAIHN0YXRpYyB2
b2lkICpoY2lfbGVfZXZfc2tiX3B1bGwoc3RydWN0IGhjaV9kZXYgKmhkZXYsIHN0cnVjdCBza19i
dWZmICpza2IsCiAJcmV0dXJuIGRhdGE7CiB9CiAKK3N0YXRpYyB2b2lkIGhjaV9zdG9yZV93YWtl
X3JlYXNvbihzdHJ1Y3QgaGNpX2RldiAqaGRldiwKKwkJCQkgIGNvbnN0IGJkYWRkcl90ICpiZGFk
ZHIsIHU4IGFkZHJfdHlwZSk7CisKIHN0YXRpYyB1OCBoY2lfY2NfaW5xdWlyeV9jYW5jZWwoc3Ry
dWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJCQkJc3RydWN0IHNrX2J1ZmYgKnNrYikK
IHsKQEAgLTMxMTEsNiArMzExNCw3IEBAIHN0YXRpYyB2b2lkIGhjaV9jb25uX2NvbXBsZXRlX2V2
dChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAlidF9kZXZfZGJnKGhkZXYsICJz
dGF0dXMgMHglMi4yeCIsIHN0YXR1cyk7CiAKIAloY2lfZGV2X2xvY2soaGRldik7CisJaGNpX3N0
b3JlX3dha2VfcmVhc29uKGhkZXYsICZldi0+YmRhZGRyLCBCREFERFJfQlJFRFIpOwogCiAJLyog
Q2hlY2sgZm9yIGV4aXN0aW5nIGNvbm5lY3Rpb246CiAJICoKQEAgLTMyNzQsNiArMzI3OCwxMCBA
QCBzdGF0aWMgdm9pZCBoY2lfY29ubl9yZXF1ZXN0X2V2dChzdHJ1Y3QgaGNpX2RldiAqaGRldiwg
dm9pZCAqZGF0YSwKIAogCWJ0X2Rldl9kYmcoaGRldiwgImJkYWRkciAlcE1SIHR5cGUgMHgleCIs
ICZldi0+YmRhZGRyLCBldi0+bGlua190eXBlKTsKIAorCWhjaV9kZXZfbG9jayhoZGV2KTsKKwlo
Y2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmV2LT5iZGFkZHIsIEJEQUREUl9CUkVEUik7CisJ
aGNpX2Rldl91bmxvY2soaGRldik7CisKIAkvKiBSZWplY3QgaW5jb21pbmcgY29ubmVjdGlvbiBm
cm9tIGRldmljZSB3aXRoIHNhbWUgQkQgQUREUiBhZ2FpbnN0CiAJICogQ1ZFLTIwMjAtMjY1NTUK
IAkgKi8KQEAgLTY0MDMsNiArNjQxMSw4IEBAIHN0YXRpYyB2b2lkIGhjaV9sZV9hZHZfcmVwb3J0
X2V2dChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgdm9pZCAqZGF0YSwKIAkJCQkJaW5mby0+bGVuZ3Ro
ICsgMSkpCiAJCQlicmVhazsKIAorCQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8t
PmJkYWRkciwgaW5mby0+YmRhZGRyX3R5cGUpOworCiAJCWlmIChpbmZvLT5sZW5ndGggPD0gbWF4
X2Fkdl9sZW4oaGRldikpIHsKIAkJCXJzc2kgPSBpbmZvLT5kYXRhW2luZm8tPmxlbmd0aF07CiAJ
CQlwcm9jZXNzX2Fkdl9yZXBvcnQoaGRldiwgaW5mby0+dHlwZSwgJmluZm8tPmJkYWRkciwKQEAg
LTY0OTEsNiArNjUwMSw4IEBAIHN0YXRpYyB2b2lkIGhjaV9sZV9leHRfYWR2X3JlcG9ydF9ldnQo
c3RydWN0IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJCQkJCWluZm8tPmxlbmd0aCkpCiAJ
CQlicmVhazsKIAorCQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8tPmJkYWRkciwg
aW5mby0+YmRhZGRyX3R5cGUpOworCiAJCWV2dF90eXBlID0gX19sZTE2X3RvX2NwdShpbmZvLT50
eXBlKSAmIExFX0VYVF9BRFZfRVZUX1RZUEVfTUFTSzsKIAkJbGVnYWN5X2V2dF90eXBlID0gZXh0
X2V2dF90eXBlX3RvX2xlZ2FjeShoZGV2LCBldnRfdHlwZSk7CiAKQEAgLTY4MzQsNiArNjg0Niw4
IEBAIHN0YXRpYyB2b2lkIGhjaV9sZV9kaXJlY3RfYWR2X3JlcG9ydF9ldnQoc3RydWN0IGhjaV9k
ZXYgKmhkZXYsIHZvaWQgKmRhdGEsCiAJZm9yIChpID0gMDsgaSA8IGV2LT5udW07IGkrKykgewog
CQlzdHJ1Y3QgaGNpX2V2X2xlX2RpcmVjdF9hZHZfaW5mbyAqaW5mbyA9ICZldi0+aW5mb1tpXTsK
IAorCQloY2lfc3RvcmVfd2FrZV9yZWFzb24oaGRldiwgJmluZm8tPmJkYWRkciwgaW5mby0+YmRh
ZGRyX3R5cGUpOworCiAJCXByb2Nlc3NfYWR2X3JlcG9ydChoZGV2LCBpbmZvLT50eXBlLCAmaW5m
by0+YmRhZGRyLAogCQkJCSAgIGluZm8tPmJkYWRkcl90eXBlLCAmaW5mby0+ZGlyZWN0X2FkZHIs
CiAJCQkJICAgaW5mby0+ZGlyZWN0X2FkZHJfdHlwZSwgSENJX0FEVl9QSFlfMU0sIDAsCkBAIC03
NTE3LDczICs3NTMxLDI3IEBAIHN0YXRpYyBib29sIGhjaV9nZXRfY21kX2NvbXBsZXRlKHN0cnVj
dCBoY2lfZGV2ICpoZGV2LCB1MTYgb3Bjb2RlLAogCXJldHVybiB0cnVlOwogfQogCi1zdGF0aWMg
dm9pZCBoY2lfc3RvcmVfd2FrZV9yZWFzb24oc3RydWN0IGhjaV9kZXYgKmhkZXYsIHU4IGV2ZW50
LAotCQkJCSAgc3RydWN0IHNrX2J1ZmYgKnNrYikKKy8qIGhkZXYgbG9jayBtdXN0IGJlIGhlbGQu
IHBhc3MgTlVMTCBiZGFkZHIgdG8gcmVjb3JkIGFuIHVuZXhwZWN0ZWQgd2FrZS4gKi8KK3N0YXRp
YyB2b2lkIGhjaV9zdG9yZV93YWtlX3JlYXNvbihzdHJ1Y3QgaGNpX2RldiAqaGRldiwKKwkJCQkg
IGNvbnN0IGJkYWRkcl90ICpiZGFkZHIsIHU4IGFkZHJfdHlwZSkKIHsKLQlzdHJ1Y3QgaGNpX2V2
X2xlX2FkdmVydGlzaW5nX2luZm8gKmFkdjsKLQlzdHJ1Y3QgaGNpX2V2X2xlX2RpcmVjdF9hZHZf
aW5mbyAqZGlyZWN0X2FkdjsKLQlzdHJ1Y3QgaGNpX2V2X2xlX2V4dF9hZHZfaW5mbyAqZXh0X2Fk
djsKLQljb25zdCBzdHJ1Y3QgaGNpX2V2X2Nvbm5fY29tcGxldGUgKmNvbm5fY29tcGxldGUgPSAo
dm9pZCAqKXNrYi0+ZGF0YTsKLQljb25zdCBzdHJ1Y3QgaGNpX2V2X2Nvbm5fcmVxdWVzdCAqY29u
bl9yZXF1ZXN0ID0gKHZvaWQgKilza2ItPmRhdGE7Ci0KLQloY2lfZGV2X2xvY2soaGRldik7Ci0K
IAkvKiBJZiB3ZSBhcmUgY3VycmVudGx5IHN1c3BlbmRlZCBhbmQgdGhpcyBpcyB0aGUgZmlyc3Qg
QlQgZXZlbnQgc2VlbiwKIAkgKiBzYXZlIHRoZSB3YWtlIHJlYXNvbiBhc3NvY2lhdGVkIHdpdGgg
dGhlIGV2ZW50LgogCSAqLwogCWlmICghaGRldi0+c3VzcGVuZGVkIHx8IGhkZXYtPndha2VfcmVh
c29uKQotCQlnb3RvIHVubG9jazsKKwkJcmV0dXJuOworCisJaWYgKCFiZGFkZHIpIHsKKwkJaGRl
di0+d2FrZV9yZWFzb24gPSBNR01UX1dBS0VfUkVBU09OX1VORVhQRUNURUQ7CisJCXJldHVybjsK
Kwl9CiAKIAkvKiBEZWZhdWx0IHRvIHJlbW90ZSB3YWtlLiBWYWx1ZXMgZm9yIHdha2VfcmVhc29u
IGFyZSBkb2N1bWVudGVkIGluIHRoZQogCSAqIEJsdWV6IG1nbXQgYXBpIGRvY3MuCiAJICovCiAJ
aGRldi0+d2FrZV9yZWFzb24gPSBNR01UX1dBS0VfUkVBU09OX1JFTU9URV9XQUtFOwotCi0JLyog
T25jZSBjb25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLCB3ZSBzaG91bGQgb25seSB3YWtlIHVw
IGZvcgotCSAqIHJlY29ubmVjdGlvbnMuIEl0J3MgdXNlZnVsIHRvIHNlZSB3aGljaCBkZXZpY2Ug
aXMgd2FraW5nIHVzIHVwIHNvCi0JICoga2VlcCB0cmFjayBvZiB0aGUgYmRhZGRyIG9mIHRoZSBj
b25uZWN0aW9uIGV2ZW50IHRoYXQgd29rZSB1cyB1cC4KLQkgKi8KLQlpZiAoZXZlbnQgPT0gSENJ
X0VWX0NPTk5fUkVRVUVTVCkgewotCQliYWNweSgmaGRldi0+d2FrZV9hZGRyLCAmY29ubl9yZXF1
ZXN0LT5iZGFkZHIpOwotCQloZGV2LT53YWtlX2FkZHJfdHlwZSA9IEJEQUREUl9CUkVEUjsKLQl9
IGVsc2UgaWYgKGV2ZW50ID09IEhDSV9FVl9DT05OX0NPTVBMRVRFKSB7Ci0JCWJhY3B5KCZoZGV2
LT53YWtlX2FkZHIsICZjb25uX2NvbXBsZXRlLT5iZGFkZHIpOwotCQloZGV2LT53YWtlX2FkZHJf
dHlwZSA9IEJEQUREUl9CUkVEUjsKLQl9IGVsc2UgaWYgKGV2ZW50ID09IEhDSV9FVl9MRV9NRVRB
KSB7Ci0JCXN0cnVjdCBoY2lfZXZfbGVfbWV0YSAqbGVfZXYgPSAodm9pZCAqKXNrYi0+ZGF0YTsK
LQkJdTggc3ViZXZlbnQgPSBsZV9ldi0+c3ViZXZlbnQ7Ci0JCXU4ICpwdHIgPSAmc2tiLT5kYXRh
W3NpemVvZigqbGVfZXYpXTsKLQkJdTggbnVtX3JlcG9ydHMgPSAqcHRyOwotCi0JCWlmICgoc3Vi
ZXZlbnQgPT0gSENJX0VWX0xFX0FEVkVSVElTSU5HX1JFUE9SVCB8fAotCQkgICAgIHN1YmV2ZW50
ID09IEhDSV9FVl9MRV9ESVJFQ1RfQURWX1JFUE9SVCB8fAotCQkgICAgIHN1YmV2ZW50ID09IEhD
SV9FVl9MRV9FWFRfQURWX1JFUE9SVCkgJiYKLQkJICAgIG51bV9yZXBvcnRzKSB7Ci0JCQlhZHYg
PSAodm9pZCAqKShwdHIgKyAxKTsKLQkJCWRpcmVjdF9hZHYgPSAodm9pZCAqKShwdHIgKyAxKTsK
LQkJCWV4dF9hZHYgPSAodm9pZCAqKShwdHIgKyAxKTsKLQotCQkJc3dpdGNoIChzdWJldmVudCkg
ewotCQkJY2FzZSBIQ0lfRVZfTEVfQURWRVJUSVNJTkdfUkVQT1JUOgotCQkJCWJhY3B5KCZoZGV2
LT53YWtlX2FkZHIsICZhZHYtPmJkYWRkcik7Ci0JCQkJaGRldi0+d2FrZV9hZGRyX3R5cGUgPSBh
ZHYtPmJkYWRkcl90eXBlOwotCQkJCWJyZWFrOwotCQkJY2FzZSBIQ0lfRVZfTEVfRElSRUNUX0FE
Vl9SRVBPUlQ6Ci0JCQkJYmFjcHkoJmhkZXYtPndha2VfYWRkciwgJmRpcmVjdF9hZHYtPmJkYWRk
cik7Ci0JCQkJaGRldi0+d2FrZV9hZGRyX3R5cGUgPSBkaXJlY3RfYWR2LT5iZGFkZHJfdHlwZTsK
LQkJCQlicmVhazsKLQkJCWNhc2UgSENJX0VWX0xFX0VYVF9BRFZfUkVQT1JUOgotCQkJCWJhY3B5
KCZoZGV2LT53YWtlX2FkZHIsICZleHRfYWR2LT5iZGFkZHIpOwotCQkJCWhkZXYtPndha2VfYWRk
cl90eXBlID0gZXh0X2Fkdi0+YmRhZGRyX3R5cGU7Ci0JCQkJYnJlYWs7Ci0JCQl9Ci0JCX0KLQl9
IGVsc2UgewotCQloZGV2LT53YWtlX3JlYXNvbiA9IE1HTVRfV0FLRV9SRUFTT05fVU5FWFBFQ1RF
RDsKLQl9Ci0KLXVubG9jazoKLQloY2lfZGV2X3VubG9jayhoZGV2KTsKKwliYWNweSgmaGRldi0+
d2FrZV9hZGRyLCBiZGFkZHIpOworCWhkZXYtPndha2VfYWRkcl90eXBlID0gYWRkcl90eXBlOwog
fQogCiAjZGVmaW5lIEhDSV9FVl9WTChfb3AsIF9mdW5jLCBfbWluX2xlbiwgX21heF9sZW4pIFwK
QEAgLTc4MzAsMTQgKzc3OTgsMTUgQEAgdm9pZCBoY2lfZXZlbnRfcGFja2V0KHN0cnVjdCBoY2lf
ZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQogCiAJc2tiX3B1bGwoc2tiLCBIQ0lfRVZF
TlRfSERSX1NJWkUpOwogCi0JLyogU3RvcmUgd2FrZSByZWFzb24gaWYgd2UncmUgc3VzcGVuZGVk
ICovCi0JaGNpX3N0b3JlX3dha2VfcmVhc29uKGhkZXYsIGV2ZW50LCBza2IpOwotCiAJYnRfZGV2
X2RiZyhoZGV2LCAiZXZlbnQgMHglMi4yeCIsIGV2ZW50KTsKIAogCWhjaV9ldmVudF9mdW5jKGhk
ZXYsIGV2ZW50LCBza2IsICZvcGNvZGUsICZzdGF0dXMsICZyZXFfY29tcGxldGUsCiAJCSAgICAg
ICAmcmVxX2NvbXBsZXRlX3NrYik7CiAKKwloY2lfZGV2X2xvY2soaGRldik7CisJaGNpX3N0b3Jl
X3dha2VfcmVhc29uKGhkZXYsIE5VTEwsIDApOworCWhjaV9kZXZfdW5sb2NrKGhkZXYpOworCiAJ
aWYgKHJlcV9jb21wbGV0ZSkgewogCQlyZXFfY29tcGxldGUoaGRldiwgc3RhdHVzLCBvcGNvZGUp
OwogCX0gZWxzZSBpZiAocmVxX2NvbXBsZXRlX3NrYikgewotLSAKMi41MC4wCg==


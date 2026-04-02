Return-Path: <stable+bounces-232980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOXGOM9LzmmjmgYAu9opvQ
	(envelope-from <stable+bounces-232980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:58:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B31B38800D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E97A3047415
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F0394496;
	Thu,  2 Apr 2026 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="zpsZ1T9N"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D435E95A;
	Thu,  2 Apr 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127364; cv=fail; b=h38LZBLL259Z/WNN0yBbwsuPDkIknPNwYKaXczIULCVThuTvKuNSnrd0wbRcIIKlw7c+e9VyyS+kH1C0zjrHtNS6sZLwqld11/9/GE225KEUhVvN8DReAnVjkLt/sBQK1cSs4imbmjN7Gip4q/AprvYSMp2+F9UCrPwOV4y+Xbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127364; c=relaxed/simple;
	bh=dFFC74rgnfHafveoGrfIiYA7BTMy750XTkr1O1/BzX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UXVo7rcWAlZSyc/PipvnnBw7bwZe5tE4T6UFgI8m7JUqon1HwcPVCtWv74PMeNs4hn/g0D2Q7Bi/CKQz29nk8AA3gSKx8tm5e8810v2Q5Au617kXSVXi6K3XaowzbM+9JwRDVDvITUrnHZwbKHzvfK7MZhZFMBwEQPiM4uPYpxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=zpsZ1T9N; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6ZllIitG/COYZw4Pb8mtY2NDK8EZJZ9xUZb+erxc+fT2VbwHHrCTH2Uo7uyyEr4CCWXsTNYZJ0euojANmjvlIS5wJ8/toeQm3MQK90AyybtDojDWYZKQyBXdpjrE7dSAFzx+ezngdxwgTG5qt9ujb70NMwPMRwybKoppCr2GCZWeDCgXLIYLmOfE4HV/tvjpUhF6l0+NG+3X73a+8uLlLERM/EvngDFaBesVreiG6lUCVdnYNPgS6H+KUAjpI0D6aauRwS0iFhGi6GA7Tz+siCKcOeKU60v3bnGezZD3EjMPAIVmRF0proIffIWLauH7cbQkd2aWrW+YleX4glDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFFC74rgnfHafveoGrfIiYA7BTMy750XTkr1O1/BzX8=;
 b=upya/+9TOhcI4IoUgQG4x9pMt+BRfWsTt9DIKtGhQ6X0UoGTqJFyC5Nlz4v4cnbFB0ZBk38K5pmvGu7cmmcucdaL6IqpiX6KZHcTRrO5UB7JCpZFT55b8Om4/8qln+HF3wsjCi7rthoeWXxdoOwq5bwosbCfS2ANoGjxMXY24nsCs8EmiYv3EPKD16EfbxaaaHhXZri3/4Dh99n4uRJiNDvZaUyIBArJRC0bgpPb+MSRdESh8/2ZyrIQJdZRjT0Ol0jh183AEwfhOPFsTOotWEDB8sCtrqiNaxPCkn0gbc+wI0QCJpmxLq5m/hms/jzRtDISN4iDA4FK/EhdDQOw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFFC74rgnfHafveoGrfIiYA7BTMy750XTkr1O1/BzX8=;
 b=zpsZ1T9N+Oh0HpjnsvvhYmzFUos/LglnbwBClYWOlBsPuxKCCO3212CPIqrjqSymEIfUfL81PG4iRxxaPtrbTsH64RcmTfkeSmaCKdIPuBe3SwBjm+qDy5Ya2OtzLn3CqJS7Sw+J33i1gip0elKPJSv3a7TROUqzpk3wWW9MBY+snPg1isq7Po0V4UTh+pMV+ZjeHI6//4XbQWS7WhIQxp+guqkyWIUdSHE6Sw1uqXPyNlGaPZfGUjpqIpJk/RRsCtyEDp9GLnVjn4P9lZesE7BCPk9IVOMLJp3rPUxuAkbppngzEwYLOX7aiU84JBOB7gswtTasLJNYYk7hFx6cNw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI0P189MB3357.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 10:55:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 10:55:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Oleh Konko <security@1seal.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Topic: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwoXtbgM45gO9AE+JdR/jF4ztBrXLmNzw
Date: Thu, 2 Apr 2026 10:55:57 +0000
Message-ID:
 <GV1P189MB19882190ACEB3707F90F5C3BC651A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <41a4833f368641218e444fdcff822039.security@1seal.org>
In-Reply-To: <41a4833f368641218e444fdcff822039.security@1seal.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI0P189MB3357:EE_
x-ms-office365-filtering-correlation-id: 488d7b34-0c58-4a96-c97c-08de90a66b7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 nkxbEOEGcqbtjqMt+7ZmD/FoEhHaqqQXF0aE2s3sqqQjq3zFcwwlUzTyv7ONOO6NffemWAQezNgG2oA9OzpUrfa1uE+ETHW8VcQ3/mzyLH6e/vBhR/m1/yBi7i59X1AAVddGc+uLhYExGIakr3CkuBysQGwdSAznNBqHZmAmjnTEOq8p0bxKoqijH/pKb67zwN6/vqiQhuANsX8REOuLS+SIx5dj6V14hiXrQ8pW/w05rIsoP+qXN+LDPk85ezyYmHq+iyyJ2tFuEM4+NjhAa4gwcU1MbzNZvoLw4eew00TBGzhiQzQ7N/7wZQAktz9WOf5qN0gWQz0jyms6roa/16SGre+OPlAzEvgM7IGewEnyf06EJoZO/H65SOgRDMRvdY3TsAxTczOWd4UZGaAwsRkBfOzrBhqWaEkcs4qBxiSC9Y7OlyqGD6wuTYHU2ZOlhYFGYRrGrxv5AvFcgvWGdlUA1N94LwYiat/gXF1L6ZQL4JLFzL6kt69j8HcLvKPadcqI2KXZi1yB0ZlbkYuuspTYBLQj03Ey5EUn2pUI1NqoZC2M1fbBCwq3SyvNhMEbRKrRn8JuToPXcBfJo8vxlKzCDQuxk4rvklDpYBmSiuSyOBOCYOnqX+0c/DCVyIvBrYY5N9y0bnKKPgoyhzX+G6hFvFoGmGsddhrVHBOSUm0PPlmk53RcLxoc28NLkkfrAFOYXdzWsE/ct6wzBo4y8tIOBXNdvoEpqZqeDimaUEBibU7pK4iw0KOY9Vbb2/XnZW0Y6zjgXXeNrceTemsFbBky4jaDlWt4qdcWlovmLA0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mkhxa2lqdjNYc2NnSzNtWTJadGovNCtzMGMxK1MrOUFLMWxaNEtnWGI4UTVE?=
 =?utf-8?B?UlgzaW5ESDRjM2FXZ0hmR2pnSGY5alpyZzdBYUg5cm9sU0c2RzFqUjZ0R2g0?=
 =?utf-8?B?YkVRKzhYRzc5dlNOQkEwczVLelRLLzJzbVdCQkhvMDJ3RXB1TFBGcEZWbFAv?=
 =?utf-8?B?WUJSeXE0MXUwVnozVml0V2J4TWVUcFVKSmlmbS96ajJEQUZlcWJpS3ZOMlpL?=
 =?utf-8?B?M3VLQk45aXFZeWV5c1FJMlpkcEtXYXNtaFd6cjh3ejRoQ1ZrSGk3NXRRSEdO?=
 =?utf-8?B?YkxPUHdsRHBRakI2WEw4c2hzV0lRWjg4TVNrUnVJbDZIejlSRndOd25iWS90?=
 =?utf-8?B?WmtGcHk5NWZvMFlWZkk1RlE5cEdtYVloNHJLalFBckp2TEpqYXZYaGsvcWVM?=
 =?utf-8?B?ZnNYbW1WbExVNzFqd1pvTFZ3azVvci96MFo4WEI1L1BlQVlGUTJPTTVycE1L?=
 =?utf-8?B?aTVxTW4xQWZXY0FXVW9STURaVkRGL25sRHZILzdZdHozNFd5cVhYeEo5VENS?=
 =?utf-8?B?YXRzOTdGRkFFelNYZXNPNkFZNEtQb2hGZVdxU1JvK2FPZVVQM25mc3FrWXBt?=
 =?utf-8?B?anZUK2RyM2MraE9ZUVZiRkp4MnZEb00zQWZDTzNQdy8raVZocnJIWlFDYmJC?=
 =?utf-8?B?SU5xVEhFYm9ZMnpqazVSN0t2VkxkZmFDc3d4dWhNOUpjSGhLQWgvYjdyNVJM?=
 =?utf-8?B?WmxuTEZiOTNXWWNySVhqZW9OTFhDUDhPdUtTQy9mblFQVklZZjFsdUc2M3Nu?=
 =?utf-8?B?bzlkanlaR2FpMjFYaHFCSzRPdzhWMmI5UFhCUE5FTWdiUkVhVWg0OXFsRHZP?=
 =?utf-8?B?Q2dMUkM3VkdGTStOZEMrc25BYUVNZFZ4d0xXR0R6NnZyQWFGV2lTaS9PeGpk?=
 =?utf-8?B?MElucmo2ei95cFRaRjl5NkhwY01Kb2l4eTZsY2N0UENURzh1VUJpajNTV0hu?=
 =?utf-8?B?VW5Md1B2bS9adU4zMHpabHMwM1VVT25FME5rb1ovY2dSbWo3VXlYanN3MTRn?=
 =?utf-8?B?bk9VdTdYWXFCcWFRZUJ6QitIZkhnMjBUc3NKS2ZGalYxNXYrT29wSkZqOWpN?=
 =?utf-8?B?WDYxbXk5Um4vRC9VT29EVUZRTi8xUWJqSEQ4VmNBYUE3RjhDNjdsSjdBWEhP?=
 =?utf-8?B?NFNoUDBJbFlhQUdmZG9pMDVsZUtubzJ4L1BHM2VlZlh4bWJGczh1S252Q1d1?=
 =?utf-8?B?Q2o2OVlYNDlJWkhkRW5NMHViSXVDYW82VTRsaTJGc1loclBxSnlocEJ3VW5j?=
 =?utf-8?B?OXdqN08xZFFOK2tIb0pYUzRuZmZYTU1ld0UrUmF5MFBvRndWaXJZWGVuYnJu?=
 =?utf-8?B?cG1sTUt4eEVXazVhM2V4N2ZzcDJCQzVadTFnQ0xaMkswbVZaNEdlMTE3QjhH?=
 =?utf-8?B?L3pIY3FXWEpCMGo4aUtnYjd2ZFJ6VWNYUm92QURsNStqV3dXUGkwcTZxS292?=
 =?utf-8?B?Q2VYSDNSUnQvcFlzT0RxYUFzaVByN1JPR1gwU081bkZBSkpnY0x6Y25PMzFs?=
 =?utf-8?B?NXhwUnFqdXBYS1M3aEdCdTBtVkxRd3pWcHNkSHA4cVRLbUJEb1l4K1F4SmQ0?=
 =?utf-8?B?L0NhblJXUFdJUGgwb1oxaldkWDRpK3JVUzQ0TURTK1M2OVJFaGJ4Tkx2T2xG?=
 =?utf-8?B?N1VQd1RJM29ZME9yUzR3bGhBRnFLeERQQzRHS0RhWG5SUWM4S3BZWmNiRFB6?=
 =?utf-8?B?UmtuNnZhRXd3YTFBdmJPcjhHdU01SFNMQWUveFNwcE1VZHVaSmtCZjRDNWFx?=
 =?utf-8?B?YTVMMGgyYTJSdXJmQVhhV2IzSFJjTEoyTnlTV3EvVGp6T0EzQ3lVTEhPVTV1?=
 =?utf-8?B?VzFvQ2hIaEFMdVJvZGpVelNTZjBmeFVrRCtDSW9JMlduVEU5QWZTbmdBTWxP?=
 =?utf-8?B?OGpaVVRzYWd2dS8rNmtFRSsydzlWdHVMNmd2RW1KaVVrUWlDU0tqSXd6cFF5?=
 =?utf-8?B?U0hySlQ4Tmh1VlE0bmttM0hLMUhmaDhwK0x4SzdjNm9HN1lxbEZjaEZZTE9w?=
 =?utf-8?B?Szl3NC9QRENPQkVnVFZCWVhJcS92cGVFRmMyQzNqZnlUZUdqMXJIV1Bxc1hs?=
 =?utf-8?B?UW4raWRXZVpHaENzcURjd3JoRXdJVUwrUkVrOTZBaHkwYWlSSkZRSzRmNlAv?=
 =?utf-8?B?RzJjNXRwTEt1RXB3a2ZGUnp0MkFCNGtmNHFGT1ZIK243M2M0eXRmZ2JVSERk?=
 =?utf-8?B?cjdrU0ZyYkViM0ZkY2VTdEhKOWVrejk3WWh4MDhuaVR1WUsxQUUzRENSNnov?=
 =?utf-8?B?L2pscXVoNVhBRlArU2hCY3ZXZHFSQVE1dWYvMlAzR2FGTG9vVGZ1RzNPOVpz?=
 =?utf-8?B?aGFmbE1OaWFteHlDa2FhQnI3dHJaWFBHNmNlQ3RqOFZqMmpJa0dSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d7b34-0c58-4a96-c97c-08de90a66b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 10:55:57.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyjR68RwI4T7QksPydfbLk095gbQ0f6QDuar8Za9fMGabgUCAdJYg99GmAF4CskJmwb2jszHtvABEnjzdwGGeKozXf3xZnX+H8+D1aFngT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3357
X-Spamd-Result: default: False [1.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-232980-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:dkim,est.tech:email,1seal.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B31B38800D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjNdIHRpcGM6IGZpeCBiY19hY2tlcnMgdW5kZXJmbG93IG9u
IGR1cGxpY2F0ZQ0KPkdSUF9BQ0tfTVNHDQo+DQo+VGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXIgaW4g
dGlwY19ncm91cF9wcm90b19yY3YoKSBjdXJyZW50bHkgZGVjcmVtZW50cw0KPmJjX2Fja2VycyBv
biBldmVyeSBpbmJvdW5kIGdyb3VwIEFDSywgZXZlbiB3aGVuIHRoZSBzYW1lIG1lbWJlciBoYXMN
Cj5hbHJlYWR5IGFja25vd2xlZGdlZCB0aGUgY3VycmVudCBicm9hZGNhc3Qgcm91bmQuDQo+DQo+
QmVjYXVzZSBiY19hY2tlcnMgaXMgYSB1MTYsIGEgZHVwbGljYXRlIEFDSyByZWNlaXZlZCBhZnRl
ciB0aGUgbGFzdCBsZWdpdGltYXRlDQo+QUNLIHdyYXBzIHRoZSBjb3VudGVyIHRvIDY1NTM1LiBP
bmNlIHdyYXBwZWQsDQo+dGlwY19ncm91cF9iY19jb25nKCkga2VlcHMgcmVwb3J0aW5nIGNvbmdl
c3Rpb24gYW5kIGxhdGVyIGdyb3VwIGJyb2FkY2FzdHMNCj5vbiB0aGUgYWZmZWN0ZWQgc29ja2V0
IHN0YXkgYmxvY2tlZCB1bnRpbCB0aGUgZ3JvdXAgaXMgcmVjcmVhdGVkLg0KPg0KPkZpeCB0aGlz
IGJ5IGlnbm9yaW5nIGR1cGxpY2F0ZSBvciBzdGFsZSBBQ0tzIGJlZm9yZSB0b3VjaGluZyBiY19h
Y2tlZCBvcg0KPmJjX2Fja2Vycy4gVGhpcyBtYWtlcyByZXBlYXRlZCBHUlBfQUNLX01TRyBoYW5k
bGluZyBpZGVtcG90ZW50IGFuZA0KPnByZXZlbnRzIHRoZSB1bmRlcmZsb3cgcGF0aC4NCj4NCj5G
aXhlczogMmY0ODc3MTJiODkzICgidGlwYzogZ3VhcmFudGVlIHRoYXQgZ3JvdXAgYnJvYWRjYXN0
IGRvZXNuJ3QgYnlwYXNzDQo+Z3JvdXAgdW5pY2FzdCIpDQo+Q2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj5TaWduZWQtb2ZmLWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5vcmc+DQo+
LS0tDQo+djM6DQo+LSBjb3JyZWN0IHRoZSBGaXhlcyB0YWcgdG8gdGhlIGNvbW1pdCB0aGF0IGlu
dHJvZHVjZWQgR1JQX0FDS19NU0cgYW5kDQo+YmNfYWNrZXJzDQo+DQo+djI6DQo+LSBtYWtlIGR1
cGxpY2F0ZSBvciBzdGFsZSBHUlBfQUNLX01TRyBhIGZ1bGwgbm8tb3AgdmlhIGVhcmx5IHJldHVy
bg0KPi0gcGxhY2UgYWNrZWQgaW4gcmV2ZXJzZSB4bWFzIHRyZWUgc3R5bGUNCj4NCj4gbmV0L3Rp
cGMvZ3JvdXAuYyB8IDYgKysrKystDQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4NCj5kaWZmIC0tZ2l0IGEvbmV0L3RpcGMvZ3JvdXAuYyBiL25ldC90
aXBjL2dyb3VwLmMgaW5kZXgNCj5lMGU2MjI3YjQzMy4uMTRlNjczMjYyNGUgMTAwNjQ0DQo+LS0t
IGEvbmV0L3RpcGMvZ3JvdXAuYw0KPisrKyBiL25ldC90aXBjL2dyb3VwLmMNCj5AQCAtNzQ2LDYg
Kzc0Niw3IEBAIHZvaWQgdGlwY19ncm91cF9wcm90b19yY3Yoc3RydWN0IHRpcGNfZ3JvdXAgKmdy
cCwgYm9vbA0KPip1c3Jfd2FrZXVwLA0KPiAJdTMyIHBvcnQgPSBtc2dfb3JpZ3BvcnQoaGRyKTsN
Cj4gCXN0cnVjdCB0aXBjX21lbWJlciAqbSwgKnBtOw0KPiAJdTE2IHJlbWl0dGVkLCBpbl9mbGln
aHQ7DQo+Kwl1MTYgYWNrZWQ7DQo+DQo+IAlpZiAoIWdycCkNCj4gCQlyZXR1cm47DQo+QEAgLTc5
OCw3ICs3OTksMTAgQEAgdm9pZCB0aXBjX2dyb3VwX3Byb3RvX3JjdihzdHJ1Y3QgdGlwY19ncm91
cCAqZ3JwLA0KPmJvb2wgKnVzcl93YWtldXAsDQo+IAljYXNlIEdSUF9BQ0tfTVNHOg0KPiAJCWlm
ICghbSkNCj4gCQkJcmV0dXJuOw0KPi0JCW0tPmJjX2Fja2VkID0gbXNnX2dycF9iY19hY2tlZCho
ZHIpOw0KPisJCWFja2VkID0gbXNnX2dycF9iY19hY2tlZChoZHIpOw0KPisJCWlmIChsZXNzX2Vx
KGFja2VkLCBtLT5iY19hY2tlZCkpDQo+KwkJCXJldHVybjsNCj4rCQltLT5iY19hY2tlZCA9IGFj
a2VkOw0KPiAJCWlmICgtLWdycC0+YmNfYWNrZXJzKQ0KPiAJCQlyZXR1cm47DQo+IAkJbGlzdF9k
ZWxfaW5pdCgmbS0+c21hbGxfd2luKTsNCj4tLQ0KPjIuNTAuMA0KUmV2aWV3ZWQtYnk6IFR1bmcg
Tmd1eWVuIDx0dW5nLnF1YW5nLm5ndXllbkBlc3QudGVjaD4NCg==


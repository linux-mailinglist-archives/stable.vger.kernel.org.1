Return-Path: <stable+bounces-241192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIXGA5117mmquAAAu9opvQ
	(envelope-from <stable+bounces-241192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:29:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F5546B100
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 22:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0388300B615
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B82DAFDE;
	Sun, 26 Apr 2026 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="aFUiyxt/"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF102AD00
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235354; cv=fail; b=rEHd5faOkiAbky/hdxIr89q6w4QYGGMLfhmy7lBm8w41Wky1BcIadA/NqxEuEd9x0YJxri6iMi/D1qPBjoGuDOJRaZZKlH61JUYVua7vGWWadmEjqTqKPWaeXevjevSS+RdOtLRFX+6N7tUxmnuSCK/+nFRbXRh5YAMk5dz4hMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235354; c=relaxed/simple;
	bh=kczToTvcNh6XnB68HlqOKCRCaaQ0FO6HMbmrKz2Ew5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgzUng5GonDtjPEcvy7X3M0I+QG+VQRvwNbPvEwOsDkBo9+2rZWJ1gA8azL+976Od7bEo+iQ8fVqkZf8jXsQOD6449dsYsWJwKos9bMoFykZ85tYyNJiakLN9hG3Ymh3wjjKRL/3m+5eMrso8uLjWGxC0HxcLlBvdOwukLZ846o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=aFUiyxt/; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0IdKU5fH0p4fncepDxOcdMQ0UXGH5qZkdLt1QTlDtvTc1S83q8wv/+cSY3CvK8BtLS4t+OGvb1J4TukxOKfOxrCuBKyDYSKeJwtFLD67UyP9OjsHNM4Ptz0641yGd58aqjLwQlGVWLOg5YT6ywyml+YaBzq1a3MHmjBEEeyfO0oUkb9rARWLqtdpAmTgM90FAoqJZYO3hWgY158+krJ5jmS4802lxk/7mnqHvl8YLWfqRxabHgf+nQQtNR5NknrXwiz19sKPOfOtroPqP3v9GmDfgsPhIdl9ITFAzwxHGUSOQOQWYFtJ1tpH0/qGRVMZU8RUdiETdPeZnWYHrTLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kczToTvcNh6XnB68HlqOKCRCaaQ0FO6HMbmrKz2Ew5w=;
 b=Tpdi006hgO3xCijyOIpkeRZAHGqvnOhS57VV+zNkEY2gAeXCkWABjCmAqfhpo0hhyKwlsZceqwjmFHkjfR7f/HEwPasZViAiHpmjuQzKNgMIgOdPGLSAZNOrQjLFQCD1Ys2n9RVaPii3dnEVRLoUxOVP2a6L009FvJRHKv1VLBTUzVC3KEpgS97YWowGTc67/yqAgBASrNyerluKTLPwXSgSwNZ9iT9qrY9vptcy7Jqy0sT5p8eKL72NZkKndLZP7hqThIv2KxxzcjUAtc9JEk2TDSnV5MCQ5ISln5zU1scBG/eSIBulGEtkyMdvpMnR6mPvgfrfVTThfeapNVvukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kczToTvcNh6XnB68HlqOKCRCaaQ0FO6HMbmrKz2Ew5w=;
 b=aFUiyxt/AFTOAm7fUGuw+oTpLJCGwz9MJV0ucuOukmHonDBE5iFfKLy7/DdwM9pIMUModBDN7dHGTHmXfq2QpYoq4vbU6+aajLW5FGL7tlhDZTbIbe4mWLuOU/2xkEXCekA9WCKYnsyWGht/cTK0U54k8Z+yqWJUiq4I7tKKVLCdmmmsc2O4qYV/bMnwWNM60l6lc0fQmXvHNWk9gPcvj+D4fST0Hr2gXFRgI9R6h2q89RdNxsb/6YW5k2fVhYJ2IF5eHMIP9wyBd9q2N4O/Qn1zN+IRA/Py0l3d+OaFYL3W+H13Y7YET9k00/oPebsSZXPthNpxEqVCjYPaJaO3AA==
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM7PPF8CB7473A2.EURP189.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::69d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Sun, 26 Apr
 2026 20:29:08 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9846.025; Sun, 26 Apr 2026
 20:29:08 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"sashal@kernel.org" <sashal@kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Chen Zhen
	<chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, Malin Jonsson
	<malin.jonsson@est.tech>, =?utf-8?B?RGF2aWQgTnlzdHLDtm0=?=
	<david.nystrom@est.tech>, =?utf-8?B?Um9sYW5kIEtvdsOhY3M=?=
	<roland.kovacs@est.tech>, "ysk@kzalloc.com" <ysk@kzalloc.com>,
	"42.4.sejin@gmail.com" <42.4.sejin@gmail.com>
Subject: Re: [PATCH 6.1.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Topic: [PATCH 6.1.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Index: AQHc1bjiwePzwpt0WkCapYOsSReCmrXxyzgA
Date: Sun, 26 Apr 2026 20:29:08 +0000
Message-ID: <be6a5abb-e524-47ba-bcda-1d832964c74f@est.tech>
References: <20260426201107.465633-2-yunseong.kim@est.tech>
In-Reply-To: <20260426201107.465633-2-yunseong.kim@est.tech>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB1752:EE_|AM7PPF8CB7473A2:EE_
x-ms-office365-filtering-correlation-id: 22305619-8dbf-476f-943e-08dea3d2782b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Zn3ddvD2745TEjTcM3F8oaZxRVIHFoOBeU/kxtVnE+19LbKM3/GVp22JJbpRAgx1FNP4SoRpaXmBLYgogdWEnjLT77PlNIc5+enRqv7XgnkYk2vq7hvLC+nMou5iw6T5976ALI/R91yEPXh/GeQ6lygbV5Gd/GYb2JcAe4QW5Dk0PbJOiGD/kGP3/By8lrclVQ18RS6T2LXnxNBQ2VuGsh6PoJoEZI7QhUhlPVGBrSH/pv8HQw0dOUtPuHZRVp4QWDSHrHJ+OhYddnZIA5Ayp9uI/VxTjSSsrOMBExxm+WJ3ze1qspvIe4h6V5Xa2OLDf2k8PTpUa/88/zT+p7texLxdLShwQSo9UfhUEhiEiFIoFcOcpokVdQnMWZXjXf0Rw+5sNOxvy3wb07O5YjXjQLpCPzojtAiNY1EXonIj3upECvM7YydcsHaYDatag4+UrjVuhYoTebjEFMc0KpsOHAuFdpF0CDhWX8tUIw8/px4/uyW4Qmopwg1uMURCtH8ggvZd2X7r5PpEWG70SF5cRehJBd1YA3Ei0rc69ZQ/zh5QLpaWN5cqFEm9ySMr9n5+jj5UmMj+wNDHeWTGlgFYZdarMJyb+7aXnFVL8ilOusfHvg33boep0jGZB6o2j9olN9pmRHCu1cq7m5n2jQC94yuoMQydo5eYKccTcX60kQSsLyW/u0i2L5F3VL0mSIB8pZRjaQInn+1fVcgKWnZ6vBU9xeVNsaZs+9bzRaAnABiBP1J7HUfpl9U9BYYS/ggC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnU5ZmZMZ2JlMy9FTzhxdmlJVG1rVkxEVjMyQldrZEprcnFkbkVQczJMUUxv?=
 =?utf-8?B?bExMckRadzZxTlBKRXZKRndhWTRhVTN2eDRsUHFreXBqZWJ1ZHJmcFd6WmVv?=
 =?utf-8?B?V0ZkamxkZitnemt6U2oyR3lSNm5kNjdBMVI5ZjN3OHh6THNpN1VvY3lGOTZD?=
 =?utf-8?B?eXc0Zm14NFpnZTl0S3hLTTV1bkpEdDlydFRsL2daSDZ3NGpnd0xyYXhuVTNB?=
 =?utf-8?B?RlA3ZDJiU3Y3SFdvSG5NZlFtOGh5dDJIZFAxM3psQ0VzdW9UTWJ1NlEybEha?=
 =?utf-8?B?VHRyWTMxdGhwMnFpeU44QTRONkk0Vmgxd0FJUEJuc1BwcjlhU3RCVTJNTlJv?=
 =?utf-8?B?ZlQ3NUE4b0M1YUZLYWgvazhOdkNhTGNvMFEyU0ZvbXh4K0JmWjlnakQyelp6?=
 =?utf-8?B?a0VCYWdNaHg1bjRuY2lBR2xud0RGUDFzTktUc0FvWjAxY2pENkpJOTd2ZWx1?=
 =?utf-8?B?NW9KVng1aDlPbFBEVnRHT1F2Q21HR2UyK3FaYjNwNlZxaGNkSUR4ZEdSQ2F0?=
 =?utf-8?B?WHJ1VWd2U3lOOFppb3lnS2QxaUVuYzk0TjdWSU1BTFBDbkdlaGMxUkh5blZv?=
 =?utf-8?B?WTVIR2VZb3kvSVJ5NFQ3dzRCWENJeGxFZUhKemtidjY5eWpYZnM4R1piTTU1?=
 =?utf-8?B?UytVcGhhWUk1WUxXTHYycXEyYW1QSmpiNjhoS1E4Z1J1ZGhvbmtCVG5qMnZN?=
 =?utf-8?B?aVZsZmRHT2NGZjd2OGo3TWdrcVdBdnRYYjhsSENEazBzZHZmdEtDdHU5MTdL?=
 =?utf-8?B?dmNXV0diK285aTVQU2N5dERDZ2N2N29mbG5iYlR0aEwzSHBqOGtxYU5ibXpp?=
 =?utf-8?B?Vm8rQytFTWVBZW1vZEo2aFZ2VjZ1aFExMGpHMzFpSlBIT1EyOEJzSTF4WDN0?=
 =?utf-8?B?SmNjRmg5bE5qRlJlT1I4L3hCNitLZFV1UEw1VEpPMkd1QnR6ZVlWVFdic0lC?=
 =?utf-8?B?d2xiVm5heHJxT0NmN3NLdnBVcjBLdmdlMStkOEdXMzNMMjF3NjlqZGhPcjJ6?=
 =?utf-8?B?bjVMNWZZWVJHeU95N1ZaOFp3ckVSVHZlSGhaeTNLLzFaQjl0QWQyRzFYWlJZ?=
 =?utf-8?B?RDdZbVM1MUN2Rm4yT2MyNTB1Q2N1OEs0SVQ0VHlxbGFVdm80K1U4S3hxKzhx?=
 =?utf-8?B?Mm5CeXE4Q3MwUXhtanJraWpLWng2YndOUGFYTUgwVjBrY0k5cmRONHFSWm00?=
 =?utf-8?B?Z2poL2tldkJEYS9KVDlUa0JiQjhGYnlOUElzME1wb3h3ZEJpazlIeHYyWjlN?=
 =?utf-8?B?azhZWndZQ3FJUjB2ZkRNemtlbW5QUHIzeXROMTdWaTYveXhFb0VRVVQ3V1Jz?=
 =?utf-8?B?TnNnSXQvek9aU2l2d3JvZ1Jaa01hclltZzVzbjk3UFRweXlIbkdTUlRpMVZN?=
 =?utf-8?B?MWlaN2gyNHRiZS9NN09sRzNUaUk2bS9PNjlIbjNFd2NPNUltVGxLak1jUk05?=
 =?utf-8?B?ZFNPMDRKcGN4Rnc1M1M5TWlyb0IwZGNreEhFMnN1K3JBQXZaeGJIeUVkRFlZ?=
 =?utf-8?B?dEticURMdU5pWkJjdXVQSGxtZVFId3NNWm5RMkRoWmUzR2NtaS9xd3pvVWtL?=
 =?utf-8?B?TkU5a1ByR3I1cENCbUNIclg3Nms5R1p6akVsc0M5Sk5CamZZNUV1cE1PM0Jl?=
 =?utf-8?B?SkFHdEhDc1NNRE9iWUR6OUJBU0pJNEh0L09zTDBENktXcW5nRlVKQXVCYlI4?=
 =?utf-8?B?SnVaMkVadk5rMjN6dzNacTc3YlNNRjQwNnk4ZStEN1dodnc1cWVTT3dvS3lI?=
 =?utf-8?B?ZWxJY1FXTktpMFQ5OEtQUGNkcEwxallLSjEvQ0tCc0tCWmN0TDlhY0VMMUlK?=
 =?utf-8?B?SHZKaThmekkxWkJ4ZkY2UzFhTE5LZVNCRXBZYzVJVHhSMzcrcmZrbCtjbkdh?=
 =?utf-8?B?Q0QwbEhxZk9GM3NENndTNnA0MGZkZ0diZDBsbEUwU0R0MGJtb3NDaUw4Q0VF?=
 =?utf-8?B?dTZPTmVPeUdVdlpDWEtDdURHVjh6MFY2OWxISXZSQ1lNejBaYnRKUFlGWnQy?=
 =?utf-8?B?WjZzSkdDeXI2Q1FZL3pQZ2dQTzdjNnNoLzA3UjNEU2lxdzVJY0ZQckM2MWc3?=
 =?utf-8?B?VVZpSkVjT3NYQko0Z0oyMHZoUDMyWXF1RlFDMXFOMXJUVWE5cDVzNGFqcXZ1?=
 =?utf-8?B?WWo4azZjdnd5Nk15dW9kM2pYVEYwRWE5ZG8rSTdFenp3T05KMlMxMUltYkM5?=
 =?utf-8?B?QW1TRkF0TkVPQWNTSzMzZm8xcVJkTllaNnlHVFloUmlXYnFld05LV0JLUlZG?=
 =?utf-8?B?RU1ZUjJ0N2plZnJYUGlUYVVPc1VjN3lHbW4zQlRYVmh1NWpmRDdaWVpBbFAz?=
 =?utf-8?B?UXYxRjRNckhQUU5KbmFadjQ3RkdwMkRoNFlEd3VBWGZCR0R1enNDSVlyazA1?=
 =?utf-8?Q?Giiw0Ypjd+ABubBKPV/zfh5Zt5uN4Ut36r3Ew?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F8D247C2CD0847A69045D8F3E4FB7B@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22305619-8dbf-476f-943e-08dea3d2782b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2026 20:29:08.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p00Znu3vGi+d9mHyTrtVgtufYFPKpeCJal0ticpjC17V7zppzamQW97IAeZ2lXnIQb3E8jS0XG2N2cX7YZjJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF8CB7473A2
X-Rspamd-Queue-Id: 56F5546B100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241192-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:email,blackwall.org:email]

T24gNC8yNi8yNiAyMjoxMSwgWXVuc2VvbmcgS2ltIHdyb3RlOg0KPiBGcm9tOiBHcmVnIEtyb2Fo
LUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiANCj4gWyBVcHN0cmVhbSBj
b21taXQgZjZjMzY2NSBdDQoNCk15IGJhZCwgSSBjYXVnaHQgYSB0eXBvIGluIHRoZSB1cHN0cmVh
bSByZWZlcmVuY2UgcmlnaHQgYWZ0ZXIgaGl0dGluZw0Kc2VuZC4gVGhlIGNvcnJlY3QgaGFzaCBp
cyBlOWFjZGE1Lg0KDQpTZW5kaW5nIGEgdjIgc2hvcnRseSB0byBmaXggdGhlIG1ldGFkYXRhLiBQ
bGVhc2UgaWdub3JlIHRoaXMgb25lLg0KDQo+IEZpeCBhIHVzZS1hZnRlci1mcmVlIHdoaWNoIGhh
cHBlbnMgZHVlIHRvIGVuc2xhdmUgZmFpbHVyZSBhZnRlciB0aGUgbmV3DQo+IHNsYXZlIGhhcyBi
ZWVuIGFkZGVkIHRvIHRoZSBhcnJheS4gU2luY2UgdGhlIG5ldyBzbGF2ZSBjYW4gYmUgdXNlZCBm
b3IgVHgNCj4gaW1tZWRpYXRlbHksIHdlIGNhbiB1c2UgaXQgYWZ0ZXIgaXQgaGFzIGJlZW4gZnJl
ZWQgYnkgdGhlIGVuc2xhdmUgZXJyb3INCj4gY2xlYW51cCBwYXRoIHdoaWNoIGZyZWVzIHRoZSBh
bGxvY2F0ZWQgc2xhdmUgbWVtb3J5LiBTbGF2ZSB1cGRhdGUgYXJyYXkgaXMNCj4gc3VwcG9zZWQg
dG8gYmUgY2FsbGVkIGxhc3Qgd2hlbiBmdXJ0aGVyIGVuc2xhdmUgZmFpbHVyZXMgYXJlIG5vdCBl
eHBlY3RlZC4NCj4gTW92ZSBpdCBhZnRlciB4ZHAgc2V0dXAgdG8gYXZvaWQgYW55IHByb2JsZW1z
Lg0KPiANCj4gSXQgaXMgdmVyeSBlYXN5IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSB3aXRoIGEg
c2ltcGxlIHhkcF9wYXNzIHByb2c6DQo+ICBpcCBsIGFkZCBib25kMSB0eXBlIGJvbmQgbW9kZSBi
YWxhbmNlLXhvcg0KPiAgaXAgbCBzZXQgYm9uZDEgdXANCj4gIGlwIGwgc2V0IGRldiBib25kMSB4
ZHAgb2JqZWN0IHhkcF9wYXNzLm8gc2VjIHhkcF9wYXNzDQo+ICBpcCBsIGFkZCBkdW1kdW0gdHlw
ZSBkdW1teQ0KPiANCj4gVGhlbiBydW4gaW4gcGFyYWxsZWw6DQo+ICB3aGlsZSA6OyBkbyBpcCBs
IHNldCBkdW1kdW0gbWFzdGVyIGJvbmQxIDE+L2Rldi9udWxsIDI+JjE7IGRvbmU7DQo+ICBtYXVz
ZXphaG4gYm9uZDEgLWEgb3duIC1iIHJhbmQgLUEgcmFuZCAtQiAxLjEuMS4xIC1jIDAgLXQgdGNw
ICJkcD0xLTEwMjMsIGZsYWdzPXN5biINCj4gDQo+IFRoZSBjcmFzaCBoYXBwZW5zIGFsbW9zdCBp
bW1lZGlhdGVseToNCj4gIFsgIDYwNS42MDI4NTBdIE9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBm
YXVsdCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAweGUwZTZmYzI0NjAwMDAx
Mzc6IDAwMDAgWyMxXSBTTVAgS0FTQU4gTk9QVEkNCj4gIFsgIDYwNS42MDI5MTZdIEtBU0FOOiBt
YXliZSB3aWxkLW1lbW9yeS1hY2Nlc3MgaW4gcmFuZ2UgWzB4MDczODAxMjMwMDAwMDliOC0weDA3
MzgwMTIzMDAwMDA5YmZdDQo+ICBbICA2MDUuNjAyOTQ2XSBDUFU6IDAgVUlEOiAwIFBJRDogMjQ0
NSBDb21tOiBtYXVzZXphaG4gS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHICAgIEIgICAgICAgICAg
ICAgICA2LjE5LjAtcmM2KyAjMjEgUFJFRU1QVCh2b2x1bnRhcnkpDQo+ICBbICA2MDUuNjAyOTc5
XSBUYWludGVkOiBbQl09QkFEX1BBR0UNCj4gIFsgIDYwNS42MDI5OThdIEhhcmR3YXJlIG5hbWU6
IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1kZWJpYW4t
MS4xNi4zLTIgMDQvMDEvMjAxNA0KPiAgWyAgNjA1LjYwMzAzMl0gUklQOiAwMDEwOm5ldGRldl9j
b3JlX3BpY2tfdHgrMHhjZC8weDIxMA0KPiAgWyAgNjA1LjYwMzA2M10gQ29kZTogNDggODkgZmEg
NDggYzEgZWEgMDMgODAgM2MgMDIgMDAgMGYgODUgM2UgMDEgMDAgMDAgNDggYjggMDAgMDAgMDAg
MDAgMDAgZmMgZmYgZGYgNGMgOGIgNmIgMDggNDkgOGQgN2QgMzAgNDggODkgZmEgNDggYzEgZWEg
MDMgPDgwPiAzYyAwMiAwMCAwZiA4NSAyNSAwMSAwMCAwMCA0OSA4YiA0NSAzMCA0YyA4OSBlMiA0
OCA4OSBlZSA0OCA4OQ0KPiAgWyAgNjA1LjYwMzExMV0gUlNQOiAwMDE4OmZmZmY4ODgxN2I5YWYz
NDggRUZMQUdTOiAwMDAxMDIxMw0KPiAgWyAgNjA1LjYwMzE0NV0gUkFYOiBkZmZmZmMwMDAwMDAw
MDAwIFJCWDogZmZmZjg4ODE3ZDI4YjQyMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4gIFsgIDYw
NS42MDMxNzJdIFJEWDogMDBlNzAwMjQ2MDAwMDEzNyBSU0k6IDAwMDAwMDAwMDAwMDAwMDggUkRJ
OiAwNzM4MDEyMzAwMDAwOWJlDQo+ICBbICA2MDUuNjAzMTk5XSBSQlA6IGZmZmY4ODgxN2I1NDFh
MDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogZmZmZmZiZmZmM2VkOGMwYw0KPiAgWyAgNjA1
LjYwMzIyNl0gUjEwOiBmZmZmZmZmZjlmNmM2MDY3IFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6
IDAwMDAwMDAwMDAwMDAwMDANCj4gIFsgIDYwNS42MDMyNTNdIFIxMzogMDczODAxMjMwMDAwMDk4
ZSBSMTQ6IGZmZmY4ODgxN2QyOGI0NDggUjE1OiBmZmZmODg4MTdiNTQxYTg0DQo+ICBbICA2MDUu
NjAzMjg2XSBGUzogIDAwMDA3ZjY1NzBlZjY3YzAoMDAwMCkgR1M6ZmZmZjg4ODIyMWRmYTAwMCgw
MDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQo+ICBbICA2MDUuNjAzMzE5XSBDUzogIDAwMTAg
RFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ICBbICA2MDUuNjAzMzQz
XSBDUjI6IDAwMDA3ZjY1NzEyZmFlNDAgQ1IzOiAwMDAwMDAwMTEzNzFiMDAwIENSNDogMDAwMDAw
MDAwMDM1MGVmMA0KPiAgWyAgNjA1LjYwMzM3M10gQ2FsbCBUcmFjZToNCj4gIFsgIDYwNS42MDMz
OTJdICA8VEFTSz4NCj4gIFsgIDYwNS42MDM0MTBdICBfX2Rldl9xdWV1ZV94bWl0KzB4NDQ4LzB4
MzJhMA0KPiAgWyAgNjA1LjYwMzQzNF0gID8gX19wZnhfdnByaW50a19lbWl0KzB4MTAvMHgxMA0K
PiAgWyAgNjA1LjYwMzQ2MV0gID8gX19wZnhfdnByaW50a19lbWl0KzB4MTAvMHgxMA0KPiAgWyAg
NjA1LjYwMzQ4NF0gID8gX19wZnhfX19kZXZfcXVldWVfeG1pdCsweDEwLzB4MTANCj4gIFsgIDYw
NS42MDM1MDddICA/IGJvbmRfc3RhcnRfeG1pdCsweGJmYi8weGMyMCBbYm9uZGluZ10NCj4gIFsg
IDYwNS42MDM1NDZdICA/IF9wcmludGsrMHhjYi8weDEwMA0KPiAgWyAgNjA1LjYwMzU2Nl0gID8g
X19wZnhfX3ByaW50aysweDEwLzB4MTANCj4gIFsgIDYwNS42MDM1ODldICA/IGJvbmRfc3RhcnRf
eG1pdCsweGJmYi8weGMyMCBbYm9uZGluZ10NCj4gIFsgIDYwNS42MDM2MjddICA/IGFkZF90YWlu
dCsweDVlLzB4NzANCj4gIFsgIDYwNS42MDM2NDhdICA/IGFkZF90YWludCsweDJhLzB4NzANCj4g
IFsgIDYwNS42MDM2NzBdICA/IGVuZF9yZXBvcnQuY29sZCsweDUxLzB4NzUNCj4gIFsgIDYwNS42
MDM2OTNdICA/IGJvbmRfc3RhcnRfeG1pdCsweGJmYi8weGMyMCBbYm9uZGluZ10NCj4gIFsgIDYw
NS42MDM3MzFdICBib25kX3N0YXJ0X3htaXQrMHg2MjMvMHhjMjAgW2JvbmRpbmddDQo+IA0KPiBG
aXhlczogOWUyZWU1YzdlN2MzICgibmV0LCBib25kaW5nOiBBZGQgWERQIHN1cHBvcnQgdG8gdGhl
IGJvbmRpbmcgZHJpdmVyIikNCj4gU2lnbmVkLW9mZi1ieTogTmlrb2xheSBBbGVrc2FuZHJvdiA8
cmF6b3JAYmxhY2t3YWxsLm9yZz4NCj4gUmVwb3J0ZWQtYnk6IENoZW4gWmhlbiA8Y2hlbnpoZW4x
MjZAaHVhd2VpLmNvbT4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYv
ZmFlMTdjMjEtNDk0MC01NjA1LTg1YjItMWQ1ZTE3MzQyMzU4QGh1YXdlaS5jb20vDQo+IENDOiBK
dXNzaSBNYWtpIDxqb2FtYWtpQGdtYWlsLmNvbT4NCj4gQ0M6IERhbmllbCBCb3JrbWFubiA8ZGFu
aWVsQGlvZ2VhcmJveC5uZXQ+DQo+IEFja2VkLWJ5OiBEYW5pZWwgQm9ya21hbm4gPGRhbmllbEBp
b2dlYXJib3gubmV0Pg0KPiBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjAxMjMx
MjA2NTkuNTcxMTg3LTEtcmF6b3JAYmxhY2t3YWxsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9s
byBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmlu
IDxzYXNoYWxAa2VybmVsLm9yZz4NCj4gVGVzdGVkLWJ5OiBZdW5zZW9uZyBLaW0gPHl1bnNlb25n
LmtpbUBlc3QudGVjaD4NCj4gU2lnbmVkLW9mZi1ieTogWXVuc2VvbmcgS2ltIDx5dW5zZW9uZy5r
aW1AZXN0LnRlY2g+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvYm9uZGluZy9ib25kX21haW4uYyB8
IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMg
Yi9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFpbi5jDQo+IGluZGV4IDdmZTc0ODVmYmIxNi4u
ZDM4ZDMxYTgzY2U1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ib25kaW5nL2JvbmRfbWFp
bi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2JvbmRpbmcvYm9uZF9tYWluLmMNCj4gQEAgLTIyNTYs
OSArMjI1Niw2IEBAIGludCBib25kX2Vuc2xhdmUoc3RydWN0IG5ldF9kZXZpY2UgKmJvbmRfZGV2
LCBzdHJ1Y3QgbmV0X2RldmljZSAqc2xhdmVfZGV2LA0KPiAgCQl1bmJsb2NrX25ldHBvbGxfdHgo
KTsNCj4gIAl9DQo+ICANCj4gLQlpZiAoYm9uZF9tb2RlX2Nhbl91c2VfeG1pdF9oYXNoKGJvbmQp
KQ0KPiAtCQlib25kX3VwZGF0ZV9zbGF2ZV9hcnIoYm9uZCwgTlVMTCk7DQo+IC0NCj4gIAlpZiAo
IXNsYXZlX2Rldi0+bmV0ZGV2X29wcy0+bmRvX2JwZiB8fA0KPiAgCSAgICAhc2xhdmVfZGV2LT5u
ZXRkZXZfb3BzLT5uZG9feGRwX3htaXQpIHsNCj4gIAkJaWYgKGJvbmQtPnhkcF9wcm9nKSB7DQo+
IEBAIC0yMjkyLDYgKzIyODksOSBAQCBpbnQgYm9uZF9lbnNsYXZlKHN0cnVjdCBuZXRfZGV2aWNl
ICpib25kX2Rldiwgc3RydWN0IG5ldF9kZXZpY2UgKnNsYXZlX2RldiwNCj4gIAkJCWJwZl9wcm9n
X2luYyhib25kLT54ZHBfcHJvZyk7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKGJvbmRfbW9kZV9jYW5f
dXNlX3htaXRfaGFzaChib25kKSkNCj4gKwkJYm9uZF91cGRhdGVfc2xhdmVfYXJyKGJvbmQsIE5V
TEwpOw0KPiArDQo+ICAJc2xhdmVfaW5mbyhib25kX2Rldiwgc2xhdmVfZGV2LCAiRW5zbGF2aW5n
IGFzICVzIGludGVyZmFjZSB3aXRoICVzIGxpbmtcbiIsDQo+ICAJCSAgIGJvbmRfaXNfYWN0aXZl
X3NsYXZlKG5ld19zbGF2ZSkgPyAiYW4gYWN0aXZlIiA6ICJhIGJhY2t1cCIsDQo+ICAJCSAgIG5l
d19zbGF2ZS0+bGluayAhPSBCT05EX0xJTktfRE9XTiA/ICJhbiB1cCIgOiAiYSBkb3duIik7DQoN
Cg==


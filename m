Return-Path: <stable+bounces-238305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NY6El7K4GkdmAAAu9opvQ
	(envelope-from <stable+bounces-238305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:39:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9209440D820
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E00301BCDF
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEA43AB297;
	Thu, 16 Apr 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="I3/WQkQe"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3AD390C80;
	Thu, 16 Apr 2026 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339270; cv=fail; b=D7vohPDaxp0FCHW6fZFUzuBOC+gHQNZZbq4pQ5j/PXiTqNcnhYtGABzUiG97EMluo/KW1c8zSBWs2UaC3XmCNF3c2qRcgMDDJJXyYKhLD4TPfCH1K0auCM+RTsuztwq729nQS1B8HJMCIdouR72UU+YUSpUHVEEdZXsTc9EoIQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339270; c=relaxed/simple;
	bh=rtZ5/KyxX0uZvzTygoeTMlo+/SDtfMCUOOdFYVXz2Oc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FS4FB/wY+eeUJwlyNmtKGBnaLyHXRtSvJcYbbOfyx+8fEsDoXnmf/eG/EBlBsPUQJfyV6RmlbMsvkMuQ2mzAjFMmnTks0tCBMn+6+AoSqQ9aB/Jc/eLe4lHa3hqHV1UaqYH7igYT4vxv0z3n7ADcMbAGC9a4WfxItr9OO1obuL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=I3/WQkQe; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDDWKevqYoexayToFm0ck7ByNbkTno7hI6dy1pIMIjr8gXg3z0cOTAbNreWVMeA13G6jex9WnDVPVupD2I3LullxZ7gwzEd5hdWpAkS7bn3SGeKMLsonP+S0VJ7VIO/XrIyv1uNyZXclnfsj0qlLTRHV9EuNXHu+G8UD4ae1uVnpwWu15G86JNhdw338qs7Hp2AnVqcHn8ePgs+RpyJbNFK0KbeCzX8xaczFn49QXqOTQNOvrmX8eFZaOs9xkYk5mgbDH4u/72wnhsgGdXUnTZN7TRCVRM3ROC1hWtc6LiTD+SUDkcPPuHduCIZy4078bv5pcW0kyusMpcm+ucgFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtZ5/KyxX0uZvzTygoeTMlo+/SDtfMCUOOdFYVXz2Oc=;
 b=mBCX35EewgGX34U3ioL/FpL/kNpv+Nph3VMkqUIQOyaQsgflfG3NSonovHR3C3FGK9yIXLyExHEWfx3AMdNey61xE/hM9Y9RsZHzgMvfbMPx+enK9pPmJHuZ41au+SGeuOC52g3KmFuo5fbZCeM6gU/9AyIZaCyWkBXB3soptxKBSasA/rpmXd4R66g2qF0eu2sT3r95S8QKcl3/v5kqla4HEic+VZZ/ERYEPy2PQDH2s94nYI1PboyEbQT30tCCQyV3XAwkj7jAhuahEyjll2+aIonTwofqEUlxU9H7Om/vSEQs4F3dFsWmoyaHsXpxb96NUHtM5RbxMvklzyAE1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtZ5/KyxX0uZvzTygoeTMlo+/SDtfMCUOOdFYVXz2Oc=;
 b=I3/WQkQeepaP6dvhNpWjxd3jmz3PWhWfky9nUIFdNBpAtp35CSQ7wPW08e/P5LIqCpIrxQRHxhqYLJpbB5ia1JrOtJbcVMzfqU4+7wmA+BWH/ODdMH7HKpHavNF3orx6iCKA97lKQ+4lBiTzHnUSDsJsVZXfaZ+neJPOPGzeyeVpH9eHEmOtfJYOS+ZO/SZzrwnchOEAZeDSlW59e8QiEkOd+REtRfcdHhS+KRF2SqiUzmAxkRQe7o5UrAxux8uyDhBiqGiQYO8M7RpmLOMDQIdir6rrKkfDXJtaOzsw3I9r897h51cpLBrSfTwHd99N69Lg2z3CxbMTZbAfJza43A==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by PR3PR07MB6794.eurprd07.prod.outlook.com (2603:10a6:102:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 11:34:26 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%7]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 11:34:26 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: [PATCH v5] uio: fix unregister_device
Thread-Topic: [PATCH v5] uio: fix unregister_device
Thread-Index: AQHczZT7IfHclcurcUKzNIat5r4L9g==
Date: Thu, 16 Apr 2026 11:34:26 +0000
Message-ID: <0e82fc96-d6c6-4383-ae96-1accfb40d5c6@nokia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|PR3PR07MB6794:EE_
x-ms-office365-filtering-correlation-id: 5840a7c5-3dcb-4802-607b-08de9bac1d8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 8GRlcAHKxPuv+oJWpRodoL8KrTGWOZZ42scvJsuKhAHw6SZd0r9r6wyd0NleBPyBljUB9exDYfX0/wKkUV+yQGnmAdy1FWwAzoYsWk4C/U4tDanLusWervraz+g2TFvss0+eTpc3TIUIrjOHHa37cccmFZNmiyLQ24rbazzkxTIcsCgngZNhUYUV1tyofg5JJ/hWiCZ9On39uJSBa/6g2d/UbnqSSxnIIGMyN0EFjKCtla7Cln7jweRnEFtBToWJkbAEBaSUnGpghnaBIIIoL11JOXfSQUMO9fO6sVCU+eJQKAEfQcUegJ6lU51pigriHrC+F/8/VEM+y+G8xhSSzojiY77QM+ijAMNppnVxAZqtnepqdn2bKlSZVu7U4VKjg8E2rdzSriwMTjVDW84uViqX/bJXUtyq7HcZgDTVXMlBm6WP1Jbd7uxAH4ATGLYa5iNxE88MTdaBEHX/otR5sTl1PLdOnjODOo5zor6y8U1g+835V5wniIjLL4M6a/oeJ+lTBFU3U58cVkQgwm1GomUGZiTMnonxmcLMhhpxlWh1UHgHwfo7jA6ru0mCkj2TK8ib1UIhvgKjbEbtfb/RYyMrB2Ws2X8vQUIGzeU782MP5LmDyHXX/TtBAEBks0+XGSwZwGYicdu9HEewIZUrcVn4RThEnFBXDig2LJSmsznPflEp0zF72tryEtFzSe5Nt5k/vHIhulC5aNgd7P49h7LU4a05u1FKPvy2Q0MkpU6LC7Z5C6FFBej+G79X3OdmdFuoLOsG+qMRK9Bj17E8L14ZoNBNvs0+fRwrb4UfLbc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cExuQlQwUlVQMXZmaFlQb0Z0T1lzRTdqTHNIOUFGVFR1QkdmM1BKeXdYeWVo?=
 =?utf-8?B?NHd1U1dhdGJjNy9jbjRRdC9kbEgyMlNQOWtjWUJLemZ1UE81OE5PNXlFVklw?=
 =?utf-8?B?NVJTcllLVGVid0ZzV2UrdXhyamkzRFdDM0JxNHpRKzNGSFRxK1N5Y1FyK0g3?=
 =?utf-8?B?azU4dW9MT29kNVpEeDJSQnM3MThaa0Rkci84YjJ0c3ozQXoxb3B3L281cmVV?=
 =?utf-8?B?aG1jaStFOXRZNlBOSEZacUZjS2xULzh1emVoTEhsVFlSdFdFZ0VPMjZVcFIy?=
 =?utf-8?B?ZjR3OXRJNmd3RSs4SWZyeUJDbFhnbFI3OHh3N2dpenQwNjdsS2tGbWhTOFlX?=
 =?utf-8?B?bCsyc3Vqbzh5eFIwMGV6Z3EvaFhNdVRKNVh3cXZ1YnViMG9wTURXQUF2WWI4?=
 =?utf-8?B?VFZTc2l3eUFuUFpUMWxUeHBIU0tWa25Eek8xVFRpZXFlODFVVVUwaWxRSGc5?=
 =?utf-8?B?UHl4SXlXN0cydktYL0x2TnZNclBVNGYzT3VlckxacGs4L0laVFJLeGlpQ3pN?=
 =?utf-8?B?a1JUSUhnQUg4bXhiUUtyaGVxaURkbHpsYS9NTFBSR25wMSsySmZJeVl4RHZ5?=
 =?utf-8?B?cDhHZ2lUUXVnNVMvWndKYkFVMVdydWt3MjIzWGx1OE43L0ZXZGlhdjBYVitt?=
 =?utf-8?B?ZzFHbnhGbENBVzdkdHJEcmpMcGVFbnJvSjRPOWpRUFRveXF1N2YzMlZsbDAz?=
 =?utf-8?B?TnpCaHRZWmFjTmt4OGFpZXRqWVF4NG1zU05BbVNEcEpSR2xkaVJlZWpuQWpm?=
 =?utf-8?B?dld3QjM0TktWblJ3SnYyY3dMdXVhNnVwdjNCQ0ZtQjJXL3lIUjZ5NEdxazYw?=
 =?utf-8?B?cGhrRGFuOC9VSGQrdFJXQnhpQ2FGZzJzek84RWNnS1BsTENrZjUvLy9jSHZM?=
 =?utf-8?B?MjhxcExYd2lEOEJVMk9BOXNwOXhPMVdlblE5TmlFRk55RHNPVzREamFVa1pJ?=
 =?utf-8?B?bUFMZ0lYcW9lcFhybndmMmpBcmhPeE82YVFOdHVsOXZDYjZxWElpVDEzMkZq?=
 =?utf-8?B?dzFqMnZKK3JxbW40MFRjdHF3OGMybEd2Y3V2M3ZrckQ1WmZTZGgwaHpTTHNC?=
 =?utf-8?B?WUJqMzdVMWVqWVBvdG42SUtLS0lPU0Q0SUtNaEtrYXVyZTJWRTNsUzVCQlZJ?=
 =?utf-8?B?ZzN4dWpWbWxXQVhjWkxuWWVEWVk3WTFDWjdiVDVCNFRvZVZodGFJd25XWjl3?=
 =?utf-8?B?N3UwVUF0bjVnNzJ3VlRKTlJ5UTh1Y0duRS91VDg5Sm10SWJCUmppOHBjS3BU?=
 =?utf-8?B?N1hIVThySUkvMnhwSUZYcm1Tak9jOEJXSGF0ck1VY25pYTlRWmpzOXRKMmtp?=
 =?utf-8?B?cnQwVXlXdzNPbmEvNVJQK3VhV21tMVZLVU9PVUNlMVZUbThUS01lYStzK3V4?=
 =?utf-8?B?Y25BSmljT3hQQnUxeG4yR2lGTG1xRGY1M2t4VE5IOHdHbVI1dGJFNklPZU1I?=
 =?utf-8?B?QmV0eWJQdE9IRUs1WkxYQTNHR1Z1SGU1bTdRUGxLU2xoSmxTZjVsaHNBNlZl?=
 =?utf-8?B?S3lBZ2orK1VnZnN0SzJhek9ybjFUcUNEeFBqMDQvVnh1aVBhei9PZENhWTNs?=
 =?utf-8?B?dklueFBCRU5SRjdrUlgzbzgzRTI4YVFVbUVtTHpMMjhFZ0pXY1VMb2hSRVh4?=
 =?utf-8?B?Smd5anJ0QmZjSzVvalptc0dHL3FNelRSdWVYWHl4WUp1cHVVNk56MXBCd2tk?=
 =?utf-8?B?ODdWRnBhU0hXZjFzeU1lVWJIZGF6b1BtdHN0REMvRjZHQnVuWGh1dGZnVlJx?=
 =?utf-8?B?SVFiTmJSQVYwOC9uUEpxWXJ4T0F3N2htNnJ3VEw2aDgrOVZQcCtIZzFLd3RY?=
 =?utf-8?B?UlNaT2JSZmlVQXZ3RzFBcG1VVzR0blRkbTdFOWYzWi9WVTlJdjVOMmFzWVRj?=
 =?utf-8?B?Vk1ZeEJDRENMWDdjOFRHc0xJZG1qUGZNSWdZaURtZEF6a2JaL2xuN3Z3K2Yy?=
 =?utf-8?B?TE9Nc00vakI4T1NyR3RTeUViRTU2QlJrUjhBeWJmdElhWXRHQmhXcXFXRTg2?=
 =?utf-8?B?bmxtQ1VQYUxkemlsN1l4RzFJMzVVTjJvcXhseDJPVkJLK0d6MEJZZFNIdVFM?=
 =?utf-8?B?THlDTGVJWC83VVRwVVMyc0FEeFc1VjZ2YldiRFJDUXBxQlVjUVNPZWIrNEpR?=
 =?utf-8?B?YVhXM213UFBIQllFVkt1RHBiMzFjamUxdGcrd0VubThkZjNVN1lXRnE2Rkta?=
 =?utf-8?B?dWUzUUhId013R0ZJK0hxdDdSQ3Y0TG94UCs5OFJvNGxQS0FnQS9XWWsyYmhU?=
 =?utf-8?B?bEFjWWdXazAzeTJ0TEFMNnlJbHdlbjc1Vk5lVk91MldycUx3SG1SaTBsTW1S?=
 =?utf-8?B?Yk13OXVDWld3SGZVOERhVm1ZcUk4aVhQZzdIbjNwZ051bm5UOUdmQUpUUnFN?=
 =?utf-8?Q?PpUPKmTGBgDYP6Rg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <870BDCB8F729CD4A82A680C4F7578CCB@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5840a7c5-3dcb-4802-607b-08de9bac1d8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 11:34:26.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mc7Fw7EeSXiUiz1912yE/AI1s6znVHMRowaGZNuBGyNNwYliUj6Wa1ZoMDVrgvgttN/QKxdNYnFHWpWXsSgIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6794
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-238305-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nokia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia.com:email,nokia.com:dkim,nokia.com:mid]
X-Rspamd-Queue-Id: 9209440D820
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
b2tpYS5jb20+DQotLS0NCiB2NToNCiAgIC0gZml4ZWQgYnJva2VuIGxpbmsNCiB2NDoNCiAgIC0g
cmVmb3JtYXQgdGhlIHBhdGNoDQogdjM6DQogICAtIFVwZGF0ZWQgZW1haWwgc3ViamVjdA0KIHYy
Og0KICAgLSBGaXhlZCBjb21taXQgbWVzc2FnZSB3cmFwcGluZw0KICAgLSBQbGFjZWQgMTIgY2hh
ciBzaGExIGluICJmaXhlcyINCiAgIC0gY2MnZCBzdGFibGUNCiB2MTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsL0FNOVBSMDdNQjcyMDQzNEEyQjBDQzk5QkMwQkRDRDc0RThENjFBQEFNOVBS
MDdNQjcyMDQuZXVycHJkMDcucHJvZC5vdXRsb29rLmNvbS8NCi0tLQ0KIGRyaXZlcnMvdWlvL3Vp
by5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvLmMgYi9kcml2ZXJzL3Vpby91aW8uYw0K
aW5kZXggNWE0OTk4ZTJjYWY4Li4xMGUyNjVjNDkwMzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Vp
by91aW8uYw0KKysrIGIvZHJpdmVycy91aW8vdWlvLmMNCkBAIC0xMTI1LDggKzExMjUsOCBAQCB2
b2lkIHVpb191bnJlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdWlvX2luZm8gKmluZm8pDQogCXdha2Vf
dXBfaW50ZXJydXB0aWJsZSgmaWRldi0+d2FpdCk7DQogCWtpbGxfZmFzeW5jKCZpZGV2LT5hc3lu
Y19xdWV1ZSwgU0lHSU8sIFBPTExfSFVQKTsNCg0KLQl1aW9fZnJlZV9taW5vcihtaW5vcik7DQog
CWRldmljZV91bnJlZ2lzdGVyKCZpZGV2LT5kZXYpOw0KKwl1aW9fZnJlZV9taW5vcihtaW5vcik7
DQoNCiAJcmV0dXJuOw0KIH0NCi0tDQoyLjQzLjcNCg==


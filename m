Return-Path: <stable+bounces-237981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DnoG97M3mnnIQAAu9opvQ
	(envelope-from <stable+bounces-237981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30D3FF061
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F7530115BA
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D4B3B2FC8;
	Tue, 14 Apr 2026 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="E8q9hq/B"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020101.outbound.protection.outlook.com [52.101.152.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82103B0AEE
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209075; cv=fail; b=WsdryeDHwGzqNZ5F0BjKd4UYKF116rPfy7aVuNv0E1eEoN7Q6ESLykEA0+JJXItFgm3bjEPJZPaFUaxZGtWrXg6sPPrGDMVaUxaCfdYtsDNns5mwcW0I/u9qnl1980hdFpYyaNhJtSUEc32fVcIjBfD9RPXJ8SpYK0ayMOdgrzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209075; c=relaxed/simple;
	bh=hjFARfC6gge3ji+AazRIQllgR/CeDkjlHT8ncbVv7ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckY9i6yCS4ecUE6KyMdEh3CDSiOtEweXWoHHP83hntxgZ0wCZItGVhdyY1/scgkHAWeO+4G6IWoZoE0F16QT5ivobj79wVkN8Ru1VryKMR1fYvwplTf+L0Xc6vctIPMrzFUX3R9q7aPta1GQkFDitm6C4BBmHQF9ohp0h8Hi9gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=E8q9hq/B reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCmOF8+QpkHhE2Lw6x2rzxgAQx46PatgKCELafeuhDliS19N+xeTdKSLY47n8n4X00pXJFE3gKLysj9HA80JmTFLwJ6TVuH2Nla/sdATqUfGyh7suxw/kt3HWCoW4Ep8NyDm1wQUUcSPNJJRz+Nq3ZzO4lfxoyocW10FFm6ibUX9aPFodgShrjn35OiJxmm/YF6oBA2AQJswbflRet7M5Jvssbv1HGHYpL0MfsIB37NAEX4UFkmauLqBzNIRHTM/hJkCfvdVzto56ms4kOZk5TVZNnJwB1lhQl/7tzu/1ZEcws9JZW7mjIeOf+TM69bwNVW12k9ylYSlPUId5XJlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbIVBFdk6k/kY9iZE0wCzzpOc/4f5TUXRbwC4kpuZzE=;
 b=ogF31YH0HwEGYE/NPdorEmZf8yEnlzD8CFPlDIZ8WSlQz3A05PvconT9qMa7fnUWRt923XqCTYuP3afFTih5DdoFfLFdUdSWnlcLniwMhsConaiZDbG5yX1/rTuehAl5olO78fd29sFZ4sTlcIt0kg68ReMmdaeGevLjkOO48shp0fodQC2IT7YG9wBjpgJPl3859oBypEtGUl2MOKZC03zzU5mao34X6b5lgOsWYJIM7DgOjioW64u9GJDOK9Ljb1qDUWAiyzdZ003gbDdmZ6l7xDGRWrBV0escANhPx+cxkvzYgHEV2yjy5kZVVS3cWcI1AMeOi+O56S2cDqvg6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbIVBFdk6k/kY9iZE0wCzzpOc/4f5TUXRbwC4kpuZzE=;
 b=E8q9hq/BqqywjL1KlcHxmsZwKpNw8OL7MPvTvzwucQ8EF2SFWaDsx4lQnEA6mNgXIposH+6BT+25wci/5N+hEA9N1B/LZsIMjhMg4BtVo8hg5D7ogWL/z0KNijdNmXS/IRdWIFIKFqg9hPiyYIbDiRxryUrM7ik6G8IxkCzWwfD3WrBtBTq59bIENhjkIE7Xf58bNP1Y5dmIB+W14EJGXb2ge+FTItqMD3qMulUm7CbtGyohVNe7nl2eTDc9A7eZ/g9peSWaSYvCQC2uaQNm2g7s7byyVyP8tzEdU2xClkyIRAEoiWu+VyOguaPXU9BCjNUEvIrvsx2ovrq3U/iq5w==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY8P300MB0299.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:267::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 23:24:30 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 23:24:30 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Steve French <smfrench@gmail.com>
CC: Werner Kasselman <werner@verivus.ai>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2 1/1] smb: client: fix OOB read in symlink error response
 parsing
Thread-Topic: [PATCH v2 1/1] smb: client: fix OOB read in symlink error
 response parsing
Thread-Index: AQHczGXYYwr7a8fmCUCrG2MEN32eoA==
Date: Tue, 14 Apr 2026 23:24:30 +0000
Message-ID: <20260414232426.640314-2-werner@verivus.com>
References: <20260414232426.640314-1-werner@verivus.com>
In-Reply-To: <20260414232426.640314-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY8P300MB0299:EE_
x-ms-office365-filtering-correlation-id: 9390b8c4-bc9b-4ca1-e1b4-08de9a7cfaa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ERNv2vmmpl8KRZVu3m+z0ftCptkFjGtvJ7ZU9YsuCKpgLLzO7NFvv6oEnMX7gKbqoHlQ6/WdN75Ae+RHX3jRZ4JnaVUPc99okjSWFg8P8pHpunHlzenDP3n+y3G+4HULqH7cuQlbRCu1Eo3bM4SukiFQk5GYckOaeUbhkJPq3kvgXfzHdnIqg6p6Mb1phoqgb3Axs/2tFf6Pqe//FJoFp8jmfdm45eN8Rc+G62hq0n9kYKau2Q8mIaYF0HjZFwCR/5g1e/sgUNJe8HqOZ6TdfqMK/daYeAVtNCd1sVfFk95iij1W3FUUrSG3tpZ0ZecPY1A1eTdOLosOFbKw9MSBgLmS0dCoAUAxKJhA4xZJ1KkcZaVegVAS+BIMzYFr0TWC0Uk7zx5VCKBtlvbVLP4R+n9aBWAzvCjPjpiF90dYSTTsAjHc1Cj6E8scrrWWYF1wzXvistN0fi5e3lVKLkYLVkq8Lsxy7sArmmiyvTmAlgo7IZl3wz467PURdofkNoXpfyXoyzMONINzgQloP7se8kfJc8RaPVBc/wrMggehv02tJqX7brYjxrGPc7MVNSibOn3tDm9wDkeecCa75TbJHvWpLJaoXNYOb+YbcZvXyvI8UvGl92XBen15L0BsQenRaa+3Y1Vk1CJNWCcMYQpOxS3cGoB7S9vc8SLyCbGlpIqKWZdmyFwVmBeBGv4hBiPobmoJaT1+wd54yNsJliqyN6vbtBdCDEmLSjTgIPkyR19EkmL3oJZw0/ZpgT9s2EsVtyvDQgOgUDNMYn3LXypiHtmi6LImwQS50jNabu48JuM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+s/8RZKtNq9aZ4BqUq1V500cST/nfv6jXrZeIIcD8+m8yANLyGj8L803pB?=
 =?iso-8859-1?Q?ZYwG6QpffVK+LK1pjQcc7spb8OqYi7eTJ9JvBMBR8JBuxyF/uz1l5jxmrq?=
 =?iso-8859-1?Q?k6kMvOvw+Y0P3NswTcK3T6qa1HqcSnJf4gGp64FKf2/E2jD0j5xq170dm/?=
 =?iso-8859-1?Q?gdi9/dx592L0nNJ6lvO2iBtrurRcPKPAYuyoxeJRe3T2v1dt47FSr9fJsB?=
 =?iso-8859-1?Q?wgtFpJxaJ/eZCAd1tsuXah+RUr58REsIo1ttjTzjVFB4RgtLlvdFyKYZXi?=
 =?iso-8859-1?Q?+xKUcTRNJBEJybW3inSR0l/gg0ERcZr/ng3vs8T/jXdfglK7cyI+102WU6?=
 =?iso-8859-1?Q?iZ2ZFx+7ciKREdiGgjIo2g+CKOhC5FGWaZf+oWwuyNCuSyIM7OUy02Q0kN?=
 =?iso-8859-1?Q?VQXhQ57VM7gn6xtrLseuZtRlEvrmeLycxziihKHwxsOD+zH7j+2myfumJK?=
 =?iso-8859-1?Q?KNbCMY0dlGzGQRuyeMo+BpXz9wQG9mdeRwtdMPu0kQGnBSKUMxLepkLvLd?=
 =?iso-8859-1?Q?UcVAjKFpONzKQatpeRwRBlL0HdTeTRHTnXAkotWX0ucsdp/XJjdGqFXqPe?=
 =?iso-8859-1?Q?iBs3IFvJSRy5JH4mZVx9LF2DHt0lCGqaISi89hX4OswYMoljpkMizA9xtW?=
 =?iso-8859-1?Q?/SXHFGbX8HlR7zybSB844KRQx3j7kPhH3hBbufhq2bKJc7eOUG1fLnpAmh?=
 =?iso-8859-1?Q?jTAlKIJ3ljl/ioYX9jEe1CDsySwhMcEJjDykKV8CZxC7Pra/dcsmLSIxr6?=
 =?iso-8859-1?Q?vS8gyiDDtGIGglb+gRy6Lq2UW+6ZJ+32Riy/6ws9ZKraPi9I4j3VKBUSS8?=
 =?iso-8859-1?Q?i4GKAb2Ka8+4bm6tP/LWaaJ96wbRwqjjCFNR83Q7yuwoBhrfCWX4c+p+VT?=
 =?iso-8859-1?Q?njly2LvNT26C6pGMIq6oF1zminUb3sE1gPklbEc6JPzeajiE3hF/0jyA63?=
 =?iso-8859-1?Q?Od7m1XRBhLmZaOMrisTY5Lkcp41VaCPCYvqdSOP1qFob0md3sI4Rz527mk?=
 =?iso-8859-1?Q?9izrgdCovWybVU31GXHIboTHa8Hz4FgOZ/ZnLDZu2gkS20Qnkjf0Slkuxb?=
 =?iso-8859-1?Q?IreOMvazW60UfMFF9xzsQg+D7iswPuXJ7suMlag5ghxZA9WOdFHqFqcfhB?=
 =?iso-8859-1?Q?p0GMK0rpuH8AYDVM0zDaH3HgqWLZOOIWLV/uGVaXe5A8RRz58eti4CTq9n?=
 =?iso-8859-1?Q?Nn3x5z6VM2EhfFX3dWmGtHfpXkedYGqB7mPJc2IZDuCD4ajE7BH8wAEG90?=
 =?iso-8859-1?Q?XnntAU/ft7mU1t0pqoHD718Hv4fJ7v+yE2uBuVc7JYkYyvqeIZ18zKUobw?=
 =?iso-8859-1?Q?fhP06ys+UDRoa/NAfAJsEJKmcWzptiuZuhqEmCUt9iqn/1PtO16g4ASxoQ?=
 =?iso-8859-1?Q?zTtZHoxC13V5Gf6MUPa/xkEELucDukI7QXcPaBBM7c4wtYn5CjMHmsnJPa?=
 =?iso-8859-1?Q?7qRrHZkc552Ip+vCS9VMXJeHaiy1iZ0GKDwC2MsKkct4JYMA4TMB+HsDf7?=
 =?iso-8859-1?Q?uyh8zD0uDo7pTx4221bKYHlLpQXc4AxlYPqdlhmxnbia6OhL2X0Wej4cj/?=
 =?iso-8859-1?Q?Ekw8UC8/HYt0nErNJPfmEyBWGv+0AnDe6ioeRIivB2b58eaemviOct0iz+?=
 =?iso-8859-1?Q?5KxyXKBYtRm2y6MZ6yhSLVYK6MtO4FYHWsh3qPdRN/1pKhrhytgC0DjQfp?=
 =?iso-8859-1?Q?dDIO2JHJQsoDVEXJIk+E2+ZWzDOgvpJuDwm8wzNQGr9VWEHEzBTI9KQCgS?=
 =?iso-8859-1?Q?eQtBQAMa6RGyZuFoP6L+SvBDf5rCa53kyXlKRA5WuLOcLFGldtE7UYUcgn?=
 =?iso-8859-1?Q?Uqwima2QwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9390b8c4-bc9b-4ca1-e1b4-08de9a7cfaa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 23:24:30.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lztfVUymWkDtt2r65j0CzEhr39Le/63Bgf35mP2VUKfVk5UG/u6bkHq9R/5PeePycm+7kuujevvILGuXAJgJ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0299
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-237981-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[verivus.ai:-];
	NEURAL_HAM(-0.00)[-0.746];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE30D3FF061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

symlink_data() walks server-supplied SMB2 error contexts to locate the=0A=
smb2_symlink_err_rsp before returning it to smb2_parse_symlink_response().=
=0A=
When ErrorContextCount is non-zero, sym can land at an attacker-chosen=0A=
offset past the smb2_err_rsp header, bounded only by iov_len.=0A=
=0A=
Reads of err->ErrorContextCount and err->ByteCount occur without checking=
=0A=
that the smb2_err_rsp header and required trailing byte fit in the response=
=0A=
buffer. Reads of p->ErrorId and p->ErrorDataLength in the walk loop occur=
=0A=
without checking that the smb2_error_context_rsp header fits, and sym is=0A=
dereferenced for SymLinkErrorTag/ReparseTag without checking that sym itsel=
f=0A=
fits. A context header placed near iov_end produces an OOB read.=0A=
=0A=
The walk to the next context is also driven by attacker-controlled=0A=
ErrorDataLength. Without bounding that step against the remaining response=
=0A=
buffer, p can be advanced outside the response before the next iteration.=
=0A=
=0A=
The bounds check in smb2_parse_symlink_response() uses the compile-time=0A=
SMB2_SYMLINK_STRUCT_SIZE as the base for SubstituteName and PrintName=0A=
ranges. That only matches the fixed layout when ErrorContextCount is zero;=
=0A=
with contexts, the actual PathBuffer offset in iov is larger, and the read=
=0A=
of sym->PathBuffer + sub_offs for sub_len bytes can extend past iov_len=0A=
into adjacent slab memory. The copied bytes reach userspace via readlink()=
=0A=
on data->symlink_target.=0A=
=0A=
STATUS_STOPPED_ON_SYMLINK responses are served from the 448-byte small=0A=
buffer pool, so the overread reliably crosses the slab object boundary.=0A=
=0A=
Validate the smb2_err_rsp header before reading its fields, bound each=0A=
context header and each step to the next context during the walk, verify=0A=
sym fits in the response before dereferencing its length fields, and=0A=
compute the PathBuffer bound from sym->PathBuffer's actual offset into iov.=
=0A=
=0A=
Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 fs/smb/client/smb2file.c | 34 ++++++++++++++++++++++++++--------=0A=
 1 file changed, 26 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c=0A=
index ed651c946251..6680c8a0ccc9 100644=0A=
--- a/fs/smb/client/smb2file.c=0A=
+++ b/fs/smb/client/smb2file.c=0A=
@@ -29,8 +29,12 @@ static struct smb2_symlink_err_rsp *symlink_data(const s=
truct kvec *iov)=0A=
 	struct smb2_symlink_err_rsp *sym =3D ERR_PTR(-EINVAL);=0A=
 	u32 len;=0A=
 =0A=
+	if (iov->iov_len < offsetof(struct smb2_err_rsp, ErrorData) + 1)=0A=
+		return ERR_PTR(-EINVAL);=0A=
+=0A=
 	if (err->ErrorContextCount) {=0A=
-		struct smb2_error_context_rsp *p, *end;=0A=
+		struct smb2_error_context_rsp *p;=0A=
+		u8 *end;=0A=
 =0A=
 		len =3D (u32)err->ErrorContextCount * (offsetof(struct smb2_error_contex=
t_rsp,=0A=
 							      ErrorContextData) +=0A=
@@ -39,8 +43,10 @@ static struct smb2_symlink_err_rsp *symlink_data(const s=
truct kvec *iov)=0A=
 			return ERR_PTR(-EINVAL);=0A=
 =0A=
 		p =3D (struct smb2_error_context_rsp *)err->ErrorData;=0A=
-		end =3D (struct smb2_error_context_rsp *)((u8 *)err + iov->iov_len);=0A=
+		end =3D (u8 *)err + iov->iov_len;=0A=
 		do {=0A=
+			if ((u8 *)p + sizeof(*p) > end)=0A=
+				return ERR_PTR(-EINVAL);=0A=
 			if (le32_to_cpu(p->ErrorId) =3D=3D SMB2_ERROR_ID_DEFAULT) {=0A=
 				sym =3D (struct smb2_symlink_err_rsp *)p->ErrorContextData;=0A=
 				break;=0A=
@@ -49,16 +55,24 @@ static struct smb2_symlink_err_rsp *symlink_data(const =
struct kvec *iov)=0A=
 				 __func__, le32_to_cpu(p->ErrorId));=0A=
 =0A=
 			len =3D ALIGN(le32_to_cpu(p->ErrorDataLength), 8);=0A=
+			if (len > end - p->ErrorContextData)=0A=
+				return ERR_PTR(-EINVAL);=0A=
 			p =3D (struct smb2_error_context_rsp *)(p->ErrorContextData + len);=0A=
-		} while (p < end);=0A=
+		} while ((u8 *)p < end);=0A=
 	} else if (le32_to_cpu(err->ByteCount) >=3D sizeof(*sym) &&=0A=
 		   iov->iov_len >=3D SMB2_SYMLINK_STRUCT_SIZE) {=0A=
 		sym =3D (struct smb2_symlink_err_rsp *)err->ErrorData;=0A=
 	}=0A=
 =0A=
-	if (!IS_ERR(sym) && (le32_to_cpu(sym->SymLinkErrorTag) !=3D SYMLINK_ERROR=
_TAG ||=0A=
-			     le32_to_cpu(sym->ReparseTag) !=3D IO_REPARSE_TAG_SYMLINK))=0A=
-		sym =3D ERR_PTR(-EINVAL);=0A=
+	if (IS_ERR(sym))=0A=
+		return sym;=0A=
+=0A=
+	if ((u8 *)sym + sizeof(*sym) > (u8 *)err + iov->iov_len)=0A=
+		return ERR_PTR(-EINVAL);=0A=
+=0A=
+	if (le32_to_cpu(sym->SymLinkErrorTag) !=3D SYMLINK_ERROR_TAG ||=0A=
+	    le32_to_cpu(sym->ReparseTag) !=3D IO_REPARSE_TAG_SYMLINK)=0A=
+		return ERR_PTR(-EINVAL);=0A=
 =0A=
 	return sym;=0A=
 }=0A=
@@ -115,6 +129,7 @@ int smb2_parse_symlink_response(struct cifs_sb_info *ci=
fs_sb, const struct kvec=0A=
 	struct smb2_symlink_err_rsp *sym;=0A=
 	unsigned int sub_offs, sub_len;=0A=
 	unsigned int print_offs, print_len;=0A=
+	size_t pathbuf_off;=0A=
 =0A=
 	if (!cifs_sb || !iov || !iov->iov_base || !iov->iov_len || !path)=0A=
 		return -EINVAL;=0A=
@@ -128,8 +143,11 @@ int smb2_parse_symlink_response(struct cifs_sb_info *c=
ifs_sb, const struct kvec=0A=
 	print_len =3D le16_to_cpu(sym->PrintNameLength);=0A=
 	print_offs =3D le16_to_cpu(sym->PrintNameOffset);=0A=
 =0A=
-	if (iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + sub_offs + sub_len ||=0A=
-	    iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + print_offs + print_len)=0A=
+	pathbuf_off =3D (const u8 *)sym->PathBuffer - (const u8 *)iov->iov_base;=
=0A=
+=0A=
+	if (pathbuf_off > iov->iov_len ||=0A=
+	    iov->iov_len - pathbuf_off < sub_offs + sub_len ||=0A=
+	    iov->iov_len - pathbuf_off < print_offs + print_len)=0A=
 		return -EINVAL;=0A=
 =0A=
 	return smb2_parse_native_symlink(path,=0A=
-- =0A=
2.43.0=0A=
=0A=


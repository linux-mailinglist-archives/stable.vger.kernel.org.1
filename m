Return-Path: <stable+bounces-249629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOJ9HEuGDGoniwUAu9opvQ
	(envelope-from <stable+bounces-249629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:48:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEC581B74
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44741300BD5A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1723C4F3;
	Tue, 19 May 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RapiM2Jz"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95840803A;
	Tue, 19 May 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204857; cv=fail; b=ngmgEWJKGJVmWF2tkSBx3cAxO1IGH/oX2BPmnpqKPrrBxBPLZz6EXl/SgiHQyShYalZfzBQn0zVDvJ9JrM9tcgOJ3b0Ts1jv/p0NTfNUai7+LZ5CAh5j5Lilq5fGMoRhgK4DODiIkIBLcuY8nVOhwNrwD13GvAdgl1aZv7RVOP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204857; c=relaxed/simple;
	bh=lBn+pOcTE73df12jmPTQNvHa4w9B5HNlgRmm/XIkOBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hZVs/RmRZbsOJI5D6q8Lk9NKOM1HPEzuO0ZDszgqdED6nmliuUX6CfvBOoEPGZCkRJy28012pyw/OGc4cvVXSVaxXukwZbuii6OC7IZMR9RC8s9ShfLduJ9r01PYuSMZM43mRbE5DYyfsigem68iNrnxMZcizqos18nYalHsg/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RapiM2Jz; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQsYzs2FTr8Exysb+6cjPvQX8mg3hGQAO6Upp/avAKl65wy3K3smJ9jFd+LhXGMKVtDNEP1S9cZL15tIjtyezx0bAY/yHSeCIIWWBVIdrRrRaloDniMHJiSavWh4t/KhRgLFW8HkMviWgW4qlgdZIQwCOUKhzyyINKHnFfd3gy+RbiJ9poRP2hwo9UQSpzY0EtMOWTa9FeU7RNyB0LADKslGsdqRdH9OeF4yfBhd1BPspdyCYDYOxfqvaCnRVcmBmL6p4Qj2Wnb5LZeFvGEZoi3xH0mBorfwVa+Xh/rNZRRj+xPjNvkDyeSnnYQz8xWivWoL5Uyfc/d/jEztJTZoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv7K4r9BFQjMz3RfcKomoRNZoNfadwxvlHkU1nWcBg4=;
 b=PAg1W6xlClO+LLpYvIlqtriD9i7FFXuMvMLDB0rbcMsqKAW6Y8s0PIxg45/1XO2tCdz+Eg2nv+ZHs1qDDLt7GmEA8vJYXPOz5MozeAm/qeikBk6F1iNJFsgkp3pG65DrvRy5+8nDwxiDuz2AwTBBP4KHlL9tC/7JFcSjzsdMS0PEbDsT+XzJbR3hqBvi3zbZS9WHlgoLq2DAWlvOUxkpbv8+A+60h7lGI+HTWXMfc3N2oaYmR+p3thKGPXQuV96leW85GF72z+nVVwr6/8SLD3akNko1hmXJOdfXHg4A1ZBxBPJQoIHRjVNQq1cEIIR40/vxGZL6mla9ZGZWC4cQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv7K4r9BFQjMz3RfcKomoRNZoNfadwxvlHkU1nWcBg4=;
 b=RapiM2Jz0ZzMjuIp/Mwxi0CROQLrBX2Y7o5wCdqEKab2tqMkkwoeY77aORc0Wp3dbmEYb62bIorBVyoAIyhJQQSeGixz88ecVZUeRbQA1rRmABjd2ivxCKbruM6GD4KSMjoV8CPqRNGmTd5hibgNFuJwLdFiYC39OofDVA2ikoj5LRATV4amBplDQOZVRIWzuv67ih646STsb7DrDzIOaTmEG2Ob5vDT9WN/lM718gtX1qAnKCL66ajpRKmKOu8m0PfwThR5TzjHf5L/mQ3N8LTFgCuxGe3GFVo/zzpS/rhp+0n+pjdwOpTJ/BXnzdPPkHjlRrHZJZSLS/vdQZ699Q==
Received: from PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 15:34:11 +0000
Received: from PH8PR12MB8431.namprd12.prod.outlook.com
 ([fe80::d6b:1180:9eb3:dd70]) by PH8PR12MB8431.namprd12.prod.outlook.com
 ([fe80::d6b:1180:9eb3:dd70%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 15:34:11 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v3] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc5ykcfyYGKvV4qUmok0MZew/ajbYVH2SAgABcHQA=
Date: Tue, 19 May 2026 15:34:11 +0000
Message-ID: <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
References: <20260519004746.3203156-1-mochs@nvidia.com>
 <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB8431:EE_|DS7PR12MB5742:EE_
x-ms-office365-filtering-correlation-id: fc7541b2-76e3-4711-366b-08deb5bc1331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|4143699003|22082099003|18002099003|56012099003|11063799006;
x-microsoft-antispam-message-info:
 SU1wppR90yjO8C1rOAuPS+D+wLqFd/4hVUHCbz9FcabJWT6aOXMD36uy31Qr/5Bk+JmlyprnIQHsGbzOVvPm0X3RbOTq0xz6ib1iZalU1Vf3l3+5K9F6ffzWuCby6INim/hF8vFmS+57Gp4+JwSjt27I1/PJy/BETEiO6RvlkWQzdjkEecnBS3Q2RaHiFYWzZuZ+JbEHAhLTV2+lEVPs9CrP0Xj2oPegNJCR/m6v/W4BiLhqvL4DW3aSmGuANhxnEj9HL1GVQiJ3fRhsDEzjtpxvUTtZfszdD5eecasnQjRegakHmUgdqWT/an+XfUJ74LvWqAC/y4R5KHsTOD/jhspkgwAZoAD8xUy3NvYUT5L86y0A4GS4ULhz8iaiPkHLRai7dOjK47YPk8R6u3SruDo4GbklEfxtW0UlsY4MKTkE6e8WH3JuaKlk5ibNXhj7d445fGxA7VnWnZEIwJ0u4hkkQnj7pS1XowDEUoNIPQyK/h24oIGfS+NyCkXdvE66ktpKvIfSTOdOGPyzcr7iEsWcqooN55vhs5T3GjutBH9oDr5gdNBBEYMgT/x5A3Ro/pwL9OlMCnfwwwJc7N+hk37Q7/T9E89+azUKAFDH7Fouy3yWbTKUcFXb4YZrelk+ojxv4LAsUXOQHiv198fR9VYTFoxwlTr0WwkcRJJtTdYVPDwccm7OpNqibfC46brUH1msqylMIY6qECoviAUYY4AlquIj0lTDpISLxneCVyAjhRxjBqMkS9nZ087PXmpb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB8431.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?khU5hdEzFsMUuOVHxUr7IlZQJh8PxdGX5btnhq7HzBSdeNTnZqTmc4a7wTCS?=
 =?us-ascii?Q?QR3lHTI4n+Ze7C6knmzAvOwfK1/HksvMZ3ZzrjrDk6w1/pBsUfxLeWy9LKkT?=
 =?us-ascii?Q?T7SeBx/rSeVvhmw6jkwlzJATKu8LMufiOLnKXUrFbfSbbRuhNy5PxdOkqLHu?=
 =?us-ascii?Q?4ubihvXLIcSB2JubsfRBGal5L9YhadPuqOW7NGp+9Leam5FYqpZJg75pSjO7?=
 =?us-ascii?Q?zArnPCSt2/rA1keSnJJ56C6lzBIeqaGLzTd/5w9Q2wdjSxgZLW8HxnVNcFBR?=
 =?us-ascii?Q?cY5aKvvh7gT7ffNfp3mSbTFhXhS9jefOuuRtxsSOXTbfn62YGIifn7A+Pm/O?=
 =?us-ascii?Q?QtNqX2EwNoFBclXkhVPPceEZamcIuhKKcls84sssvkmyYAxFkZWIEtu0sScb?=
 =?us-ascii?Q?u0Y83jQA0pmYnNvczODGjuk4IGqJX6H4u2pClq2gh4sWZbuWVH8WNjFLw+XD?=
 =?us-ascii?Q?6lxeyGsbsFKYGtP97ywxvBD8lwzCKiE8M/Qg6bUNGZgjqnnWCQSQfuRi79da?=
 =?us-ascii?Q?wZXhgEw2O48NS+dMiuGKAzqw8Tz2kzU4MwseuUnzGgyjJwsmBoGp/JvOPKUg?=
 =?us-ascii?Q?8khMIkD8sTlxN7QE6hOTX67ppx/mPuilc8mw6NYxBAjetg0jZkXb7YJF9GRW?=
 =?us-ascii?Q?wJWHQCbxV63sV0LIgmg7OvuDj6GhlRBTtiN3Ecuq9Y9YzhIPSNUDiv9H/cX7?=
 =?us-ascii?Q?egUqTJNEfkkhYJbk/BxwtSlHpF5GBpHMRe9guiR77iwWtZxXv4mj1NUolzbc?=
 =?us-ascii?Q?dUYzn2qTnsJyC0n+vFSEQGEUua1LeNVGf8iC62Dba9eonJjrBtpHl3wrClWQ?=
 =?us-ascii?Q?ouvBfNY1OOQoYz7Fite3qOZxI9aNljVCyKmtNLo/1AXnz/vIIKf/WHw8ix2R?=
 =?us-ascii?Q?r4w7bZPVynej8yq4lcGmPs4D3Hymeg97D4Udv2gj8sGILghdKV/PdkecK1wH?=
 =?us-ascii?Q?n5Fe9Fh2jnYUAeGWo71YgOangc5ftwDVSKCzQF/TuZG/UQ/iQqA6fUBdWqKY?=
 =?us-ascii?Q?d1xw9T7ZXmlQI24CkypqwHTiSdN6ZKoexX33My6DMQQTXES0eef79m/yGJkL?=
 =?us-ascii?Q?w9JuiMyjZpnAez9Jkot/C/TLf6IHj8Gqb8wrgjOxYuR5R3HlDd89dEBKcMN1?=
 =?us-ascii?Q?8wUHDRzzSKlLMMWvfCIa0PLcbYjXDqR1BC5OBdzlgJ6acyWr1nPGWW+cHQ7x?=
 =?us-ascii?Q?DVoluLHBYXzdUB1ka30Cq7PEj5tsszFTzV7vBUK1UnJqM9T3+bI/pjKdpy/F?=
 =?us-ascii?Q?Wb/3yopjGpL1JJzJGUcXKGZw7l5jdYoW0itK70w98l1ikZhhoEH25kLt1WFB?=
 =?us-ascii?Q?UDwGZauBvAFbECQYGnusMKRQSr+0CfvgZMt83w93zQFgoxAAwz6ClCedhM/1?=
 =?us-ascii?Q?fQrpyTCWrJfd+8wrK6t5NnNSE4YwXSCaHIcZ6qCRopMI/isnphbfu0A2KwFO?=
 =?us-ascii?Q?YVCCHcoJHGW/qNziiYqeUmpNaSDF4grC/S2Io26dmckir18u09rLwE+3ZZto?=
 =?us-ascii?Q?VMQhWAmAlY1C5hTAUTh3ubjJZhAbPrbjlaRYSh5G53YunHQLxqi3NskzlQyB?=
 =?us-ascii?Q?cCsWbjl+74Y+9T7nuXnzd82w7ZGZ7cAvqE6pE6+GijoJ/fRovbyPmJlfecCj?=
 =?us-ascii?Q?QQw4YwNScuUPk7dqnCjZSS+0+BWWBdoI5aqtOwKpOdu+MtaZ5LBQmAMzeiCf?=
 =?us-ascii?Q?EVrnWY2vM8GPTL/lOGXJhomi/nlJHs/fKD8ImtWzU0rnBZ5yTATR0wKQavw9?=
 =?us-ascii?Q?SiizeUfrqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8AF0F04B639AD418BF7E33FBC05FEC0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7541b2-76e3-4711-366b-08deb5bc1331
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 15:34:11.3463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/ZTX+KK4AypMw9lWYZzLUjAMUf+prF2aw1HsSn1L5H9IHQSBTEjhaeNDcaLV/qjTtWawPjN4qF/dwa7vKDBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249629-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mochs@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,szeredi.hu:email,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66EEC581B74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On May 19, 2026, at 05:04, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Tue, 19 May 2026 at 02:47, Matthew R. Ochs <mochs@nvidia.com> wrote:
>=20
>> This was observed with a 64K-page guest on a 4K-page host, using an
>> overlayfs mount whose lower directory is on virtiofs. Reading a merged
>> directory through overlayfs failed with:
>>=20
>>  ls: reading directory '<path>': Cannot allocate memory
>=20
> IDGI, the patch makes FUSE_READDIR supply an array of folios.
> Virtiofs shouldn't need to allocate a large argbuf after that.
>=20
> What am I missing?

You're right. After switching READDIR to out_pages, the large READDIR
reply payload should no longer be copied through req->argbuf. My commit
message conflated that with the separate request-size issue.

What I saw while testing the page-backed version was that the READDIR
size was still derived from fc->max_pages using the guest PAGE_SIZE. On
the failing 4K host / 64K guest setup that produced:

  PAGE_SIZE=3D65536 max_pages=3D124 max_read=3DUINT_MAX max_write=3D1048576
  bufsize=3D8126464 nr_pages=3D124

With out_pages but without the byte-size cap, fuse_simple_request()
still returned -ENOMEM. Capping the request to 1048576 bytes / 16 pages
made the same test pass.

So the out_pages change fixes the large reply-payload argbuf problem.
The fc->max_read/fc->max_write cap is addressing the separate issue that
fc->max_pages is only a page-count limit and can translate to an
oversized READDIR byte count when the client PAGE_SIZE differs.

I can rework the commit message to make that distinction clear.


-matt


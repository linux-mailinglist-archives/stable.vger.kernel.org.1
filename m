Return-Path: <stable+bounces-235371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPpLH7+B12knPAgAu9opvQ
	(envelope-from <stable+bounces-235371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:38:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 844983C938C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 966493009F3A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4413B6379;
	Thu,  9 Apr 2026 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ouSmajb9"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010020.outbound.protection.outlook.com [52.103.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91A37AA9F;
	Thu,  9 Apr 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731129; cv=fail; b=CxpiAbxfShFeVUzUsiLDR5e5Y2E7AUF7DE4iG3O3zX4e7jxTaEYD5Txp3R/R5/wMY5qYiUwPNs+FUdcrn0O6QgGLoFWq8rhHUPQMc1F03uPRwtDc/tT/0ZFGQw/lwSpqsmIcA0d++SBWhldwWs7i6/OYMs+vb51RL0Qprf7CS3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731129; c=relaxed/simple;
	bh=ClBRQZme8j2rhX4Eu6b3uJtdS4AKm9j+NI5cWve12b0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+XaPPwXodZeCUWTeJNTKAQ1lPGcZrbclCdg1t5FRKqz25m+PUNz5MYns0s6ovJx/MrLJomzqzyRBwBWD1J/zVkG7ODT5unhLrhpKXa2do45gZ+KNzgEYggmrVGSFRmFht3SDUHmQJ6KLFPo6FbLp35MjhftecodS/toi9m5ygk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ouSmajb9; arc=fail smtp.client-ip=52.103.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFK9E/IL/Wsv64yOOaMNIgnLdSJeYJpErHjrji/HQ0r7FCZGdOMeLuR7TtKDMOoroV1iBEj5Ck1gJ5cRU+Kj7BDtXOBjkd5nltz7xmpoQDuFEuhpR9H75rcD0UrFVU4XoAQgCaWghIf9cg9LLI8asb89MJvOe1mbMEF7h0yvs14b5ty4YJjrz4c0RTJDPXbKWkoORJ4u7olQYpKcxNn4L2uusmwxuMETqTal374iMAy/pW9UAQcecoCUI9o3hCwN0m5bht45WHpVBPOzb6kBSLLue51gDuocr1AWs1v4nkrcCzFSatnay+Tx7af5uMJQamCjXac1qx1XpevksFnHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWOtbV/eJS54D3qzObNAAk9vEylWH8M9XoU3o/H3KAI=;
 b=UjtyIP8/WeXn4INcvICyxVbveSVVERUAjKXHtypo3pMuj7IETS/yJQXXaP1Tqw3Ip9nohkt9n2FLuRU4dEjoxbFKNQi4bxgNzfHd6AWmCBROjZmuZovQPSbBQZOwa8sKOSmMfyB9hS+S8LQh/HHKKGdsF58yGcIdpdwchcZ1uxNLxsXq3nHTpmQvFKtUBagPKtg3RZWMbsoLs0kaO1d8z3+7pHY/suQTUfvGjEbAT1Fp+JG98KmXn49slWX1p5ilmbbtfhbgxY1dksl5H9zsJHphldBbWc3jWfqKF0fL7jeWbkMIkK3NTG1R1Z3TKAZ6sck4x+URg2dmeZ3tGPoV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWOtbV/eJS54D3qzObNAAk9vEylWH8M9XoU3o/H3KAI=;
 b=ouSmajb9RnLDoK7nAvM7Qx++qdWZVx/HB9aVQ3njyij/cY0S+ijac8TswmexJWOvERkAZdCUlH/FVGfcZ09/9s6X6lL11yJJgBxsDZd12T202ZKoPtrYXgbnAPjiMumVOggznNBiROjwgAhacsIPpAzMkTFui/A9gc1koDxyat+6Houf7sKdd8TQfIDKdPljEGhAKNZZ0P/+AhsVIaQpL2Hbc22M31cc4jsDjowx8YkwcnjNxLarQ/aRovsM0gpF+aE4NJkwwZhDSsM/Crcv2eNXdxtOdYLLXcjogLqVj/x0+vpw2s7jA6FTcgjjuG7fqbE6SnaaeMZM0W17zqmbJg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY8PR01MB9032.ausprd01.prod.outlook.com (2603:10c6:10:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 10:38:42 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 10:38:42 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu
	<zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
	<dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo
	<guochunhai@vivo.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Topic: [PATCH] erofs: fix unsigned underflow in
 z_erofs_lz4_handle_overlap()
Thread-Index: AQHcx+59WJTQzAOqcU+DqK3g7FYXK7XWVQWAgAA1IoA=
Date: Thu, 9 Apr 2026 10:38:42 +0000
Message-ID: <3F909329-EB34-4B5E-A26D-081D9031DE01@outlook.com>
References:
 <SYBPR01MB78811E3B3E935EFCD5D63334AF582@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
In-Reply-To: <31b4e893-44f4-49b4-935f-9cf37b5a0790@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY8PR01MB9032:EE_
x-ms-office365-filtering-correlation-id: 1dc0557b-c356-4956-92b8-08de96242b84
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|41001999006|461199028|15080799012|19110799012|31061999003|51005399006|8060799015|22091999003|24121999003|12121999013|440099028|3412199025|26121999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2ytJNpkS/3CDNK1Gp2Yj1E/5UEzl1vnviWN7jSb3a8urlyM+aCfe0J82oZf9?=
 =?us-ascii?Q?3f1yuncptvNmRf2cADFZ7r/rE07lNWkwvXFIsbLgs7Gm+zBPs7XtOZYmAjhd?=
 =?us-ascii?Q?7tLrZuFNFnyUaCcCDYoYD3dgwaGsDp6NoYpiXh08dv6H243Nt14AwiqLEF4q?=
 =?us-ascii?Q?/p5w4Gm+Z4f2YMj66DDbRHzC97OpG2a3u8QNpkxxTRTS97/AuwjMGQz4SglK?=
 =?us-ascii?Q?iYWm2g3eUNuh1BHCYwtQrTS1x7M8jIM24JlOYnAm2bsjVn87L0JfcGqP8zI6?=
 =?us-ascii?Q?FmrEGiGN46kML5/IiVBhOPj8O0OrgJK+Y6eTYjlNUwGGuSrJgQ4Iw8AdnxPf?=
 =?us-ascii?Q?9XcUV7YoEWjSpuFZVo8/e2Z6oc/R8EkEY2w+HgPir/qiPuECA3VmDnbaNzvk?=
 =?us-ascii?Q?JD2FKD5wdP/uDT5pjO9jcs4jtqHP38F7EvLygKobAV9s82jcAfr/o6sOZpJE?=
 =?us-ascii?Q?dmvvoLQJu59xuWMD+kPm1Ri2s4YLoO8mhtQUW9BsBxmUHokCPUZ4ILLA0pBM?=
 =?us-ascii?Q?wcieHRB9fTvWYkA42qcePtDHej0tfd87EY1QW2OJhNQvCaVKSskjgxTIdOTJ?=
 =?us-ascii?Q?YyORSu+Z+O4e4YjeWNzU8n1X1iRdtH5zZW+uFi/Z2ICw0ObOl7MTLH5eZwty?=
 =?us-ascii?Q?UZ3HLwLuGgDUGLTv+qDBsBG1hYygC1GT9alA+kzIsTMlNGi7ss6MFDVMDOax?=
 =?us-ascii?Q?RBc/XXaw9khVW6ONHgp7rTsVqU8JMgwZ7mGER1Bw86EjbPUSP/E79exa4hqv?=
 =?us-ascii?Q?us+WgcFzAjc2tNtl700ztdU/bG9h8cByJ8SaIioPRl6GmeqBpQlKdBQV6GQ1?=
 =?us-ascii?Q?cPGgk572lfQ2q2FR2O/kx8PRB0BKHya93mZ2mOjol+0Kb0QS+XNNgjjQ+p5A?=
 =?us-ascii?Q?tgJJM/llqaOrIxXHzJcVmtZ8ZRLiwBPxndRHwqMuTDgw7wOSE8uN7Zv5+9Nt?=
 =?us-ascii?Q?9QVawsqNGNluZPBr/c1FNPBi1oWj55ntM/seLbmjkQywtXqwr9AJqG+WmII1?=
 =?us-ascii?Q?KICZtNNZj24TObI1bAsJBtQiSFB/aGa0VLbZymt7G9L3Ek2jNxrIWsfPoC+y?=
 =?us-ascii?Q?jwDo1+1R?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zsEZPd9u7El7n7+LeNUKjqxSBZYLx2JXBCp6b1tt55yoRQJbm/zkMMapMWbI?=
 =?us-ascii?Q?0JZOLg8SRiZ8x6gzSXFXsf18nlAFrfV/fTxqdH1hRB7I3rLxcbaWJ5aPoWF7?=
 =?us-ascii?Q?x8UEaVdS2/Yyjk8F6YM7m6qLr9JFLzmBAXgGM1MU9cDJgHF6foOuqZ49OZ72?=
 =?us-ascii?Q?kT16+UE8q9lCKW+HusMj1v2GSm5L7k4HWPqbRWvgaGWZ90cVUocYpY0JQDmx?=
 =?us-ascii?Q?2SoMPq0H8pZttHP/Nw+H8tWimwpZ04BP/vbp+2jvsiXX19NzCC4ZNjggnac+?=
 =?us-ascii?Q?kUd7J3ysTDX4evcPxC/7zJO+YWGs8AM5uzy0uum3xPfMXnVgtr3hP8BVlb3N?=
 =?us-ascii?Q?xqC9p9iRcmjXB4dygA51cs0+PmJx3aR4+gD6BqZ4qcs/X1id5D/2yTL5fjTK?=
 =?us-ascii?Q?5RIrMmPLq0JIElLHyUAD65WoNh65cdILAkknpUYNwphcUdtM2RkFDmQy5SSY?=
 =?us-ascii?Q?2QYjTGHR6umSFxyii4WQY1AmvRpxCY2G/FrbSswFNursYmYwt1D9cY65ZIZn?=
 =?us-ascii?Q?bblwuuIetoGeQZdqLg+UTJC9LKxrn3hhTJZzrAMZZGsPUVjNpKosst6kO5Gg?=
 =?us-ascii?Q?FZMQHX/ekHZ5KZ5mlXWTzvgNDqwmO0AaAEswB1LTiIxwRn+XJ688xl2oC1ia?=
 =?us-ascii?Q?Mb8FoCCCr/2bPja3+G1yp6L8sjGJlXyJ+rfRAsji1cZeqqeXIkRF2n1ku8e/?=
 =?us-ascii?Q?A2qtaKJS3k+xyCbyi/f3wp3fvpCDIR1sMdPPwiNaZSOldJZ3ofMNaPpGbEgz?=
 =?us-ascii?Q?pu537Y7PujrVYhvL9Flok7M/Zs1TcG3XK/8eHhlQFZ9aYMDoyeEzSltdkXZN?=
 =?us-ascii?Q?DzCjAP0A7BtgJzBVbnM5/2ZVXEC+Zy5YqcBcg64fV8QGIpLcjl+Hj1O/HJFY?=
 =?us-ascii?Q?LMr+iPmJg1mW7wTbQq6YFU3skauAGgyxOcb/C0rN8fO+t2ICwggU0HwBDilO?=
 =?us-ascii?Q?fldqNhRtIe5VaqZzHQ5uZw/sG1tQ1T8s1MblVG+h6KQGmE81xVEKKd6VlybY?=
 =?us-ascii?Q?LAt6oz/FWdVP888mM3y2F2qHNvA4QzVGCBI3YoVDalnKRhzXwUVPrdEH687e?=
 =?us-ascii?Q?uHpidpJJdX5pinxfyJYV/nN6qc6mvONTEuN30yWMqCnSPJsINUxu7oeAUgmV?=
 =?us-ascii?Q?QhIFfJ16mfIZuBjhKMWsR48/OqyGt4ugSI7gENlvO3IA2BF5ng3BRWVIK7x8?=
 =?us-ascii?Q?LbEc9wsVU8cAak+oPXyhtj90JHU4sC5xo29NUS0xK5c3jBZ8iPCGpTD8/XnX?=
 =?us-ascii?Q?rYhywvZ2O1XY23ZIJOQ9X54no9YjalEzOeOBWJg9rFmNK+TzTgvYp4n6NsT9?=
 =?us-ascii?Q?QY2LTnsxI7ii1CZtmn7gKpRHQ/MCcpKTW7ayRJZZdHl25qtj7M/hEDBq0Jxg?=
 =?us-ascii?Q?SZ7DJ5nAy+9F83lCZeswQBk/bKyiwixwCeFc4F6Uzn+C3I103Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32CD674898504E49A6692FA0864AC33A@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc0557b-c356-4956-92b8-08de96242b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 10:38:42.5707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8PR01MB9032
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235371-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: 844983C938C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Gao Xiang,

Thank you for the review.
=20
On Thu, Apr 09, 2026 at 03:28:21PM +0800, Gao Xiang wrote:

> For this kind of stuff, do you have a reproducer?

I constructed a crafted EROFS image declaring plen=3D8192 and i_size=3D4096=
, giving
inpages=3D2 and outpages=3D1. Tested under QEMU with kernel (v7.0-rc6) plus=
 a temporary
pr_warn trace in z_erofs_lz4_handle_overlap():

[   12.889652] erofs: BOUNDARY CHECK: outpages=3D1 < inpages=3D2

The image mounts and the decompressor is reached with
partial_decoding=3Dfalse and outpages < inpages.

> I'm not sure what you're saying, but I don't think
> you really understand the entire logic.
>=20
> `m_la + m_llen` should not be page-aligned for typical
> erofs images, you can just mkfs.erofs -zlz4hc with some
> file and check it yourself.
>=20
> BTW, I just check upstream, and the inplace branch
> works prefectly.

During testing I observed that the inplace branch was not entered with
my crafted image and incorrectly concluded it was structurally unreachable.
I apologize for the incorrect analysis.

Later, I crafted another image :

	COMPRESSED_FULL layout, h_advise=3D0x0007 (32-byte extents)
	feature_compat=3D0, 5 blocks total

	Extent 0: lstart=3D0,    pstart=3D4096,  plen=3D8192 (LZ4)
	Extent 1: lstart=3D2000, pstart=3D12288, plen=3D4096 (LZ4)
	i_size=3D4096
	Block 0: superblock + inodes + extent records
	Block 1-2: extent 0 compressed data (non-zero padded)
	Block 3: extent 1 compressed data
	Block 4: padding

Mounted with cache_strategy=3Ddisabled, reading the file triggers:

[   11.454290] BUG: unable to handle page fault for address: ffffed1100fecf=
57
[   11.459901] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[   11.466542] RIP: 0010:z_erofs_lz4_decompress+0x888/0x10f0

Thanks,
Junrui Luo=


Return-Path: <stable+bounces-78130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D698888E
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2593C1F221AD
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5F1C0DFB;
	Fri, 27 Sep 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="Q2Lx+ws2"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2095.outbound.protection.outlook.com [40.107.249.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29E15443B
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452318; cv=fail; b=gJ2xuzxPNFTug9gXbyWnvXu+pqWxEdF3c4Upepj5y1j7K4LGVN8q5y6z6LVOnArAxUMcenKld+CON35dAcKkCBqG5KOo86ICQQ6iMvaEDZpIUPO+zIPO+Xav1ZWTgjdLxiG0mA9vpz6USs7a+GatKhTlnqbjTY5gxUP2rtMvD3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452318; c=relaxed/simple;
	bh=pIV4+2LO1NjQkd8gnmmeGEKwk63fzust8G1/lwQMrN4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aCMmCeT6OdCPs77FNBi8PC1QNQDFxkV8vxL+A/8mCoKzisWOnY1G+lDAPWzMG1DqiATxxkE5iMoHRfeaiHn4X4PkHub1yh5ZnnVunkOLv6pCw73KVLC+32hAuT285lCm0BTQor0fW0IMPXyraQ5jRHImHDfn6RuDM527d1jqg68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=Q2Lx+ws2; arc=fail smtp.client-ip=40.107.249.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t20EmQM264eFK/blhlyNmMfg3+TKIJXPV+lbu4iBCuF462QVzmScJWkHdaTpILF1UVcZpJ1zmegJJeHTekZeQ1SPTRaDKPBw60v1omEGJBMi2wQ9SAFHTPp5oey6zfOpwzrrf/S2oNiVXe4kUSJnfZEPTDyZZ03t7rhne92wuQlNOQcVB/hqDalP0iup+q5kpPx9FD1K4TskwFL+3u3iFVRE56G+/BHZnv24pbxTSXcTos4QAg71sLeb9wSOz4DcPp2jwB5EIycKuvvgM/gcYxHZT5A3haiW0T8bU+wzTa1vEIyY7jsyW9BCjNqgVzdo/o6QVvJttT6SRHRnkRqW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek3mfOx7830yFuaoPmZarW1RQ8g1yDuS5RxQckVwBOc=;
 b=uwoSpKTddoS+pBWL0MXdZr/vNE0XjrJdu/WBECA4RbcbR2Eydwp2mBCAHDaUN+v50ncPtx8fPSakf8pZzmIkSYu9vmPSd85HjoPJx+Gz16GlJfnr9YZeeNiubUkKnSmR+JAA5wArtjG3gSStrm21RX+VtzrSPfElkWXtjQJK8FR2eg5/gom2g6+Lk968gAGeHyjrAC/9ZvvwQqyrU9hSvXS3OuKfumeMZLe4KN6Z9t69X95FfyQZYjPIyaoxGEwv7fl8SqvwqSjIXQJkLaRFl/oefqjyya9gQKSqfWCiVonjmXkBzUHep6eFcxmXKz8RfXFpu0dk8dOCB0NzJ/OoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek3mfOx7830yFuaoPmZarW1RQ8g1yDuS5RxQckVwBOc=;
 b=Q2Lx+ws2mHB+zXXnuCRd6JK3NUgfyBqbXt8wRauFVCp0EeOGCOkFqsIly3xAZn5gbGSatQ5aYkkS6C65DWmUTC3jotkfr3tMKEdGby/n6/gXII1HXQi290AraKQ8jtlHLCHOI99REQGmvtnmIgbVtRKbk6xdJtok+0bsDl5iAj2IRxZJjolDzrZCmvyBHiKkldD9hrUtjsY0K9YR+aybnHCVlHcA+/gt/g5ADGs8xLjI9nQkkJeGLviS97CW2yYfM8JeCDIkO7oJnAPf+mm69V9pBPugbYyjABN0ZU3hAM5aHb9Jy5AvyAZRE4sid+tJrBgAau/m+K24ETyPWEwOHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by GV1P192MB1740.EURP192.PROD.OUTLOOK.COM (2603:10a6:150:54::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.30; Fri, 27 Sep
 2024 15:51:50 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 15:51:50 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Hailey Mothershead <hailmo@amazon.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH v5.4-v4.19] crypto: aead,cipher - zeroize key buffer after use
Date: Fri, 27 Sep 2024 17:51:26 +0200
Message-ID: <20240927155126.91269-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0450.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::9) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|GV1P192MB1740:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bf6574-03f2-444e-5f34-08dcdf0c4ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hzg7zYIua0jjeZezxHtmuu0M9vHf2U+Te2TzLOD0oGgI4KyLKim+v3G9NZZE?=
 =?us-ascii?Q?tBuPyxms5I/tI/JXa9g3KsNJu7N5BTUxW4KW+XkWuADWf7YjVsogg3N8FOR/?=
 =?us-ascii?Q?bbcRN4PHtiuM+J3DfHHhIse810DqVb2ky35eBqtvf86nnLz8bYHjSKRB94Da?=
 =?us-ascii?Q?inRGotdn9O9p8TtjoG9wWq0p2eQJsvtIS1cvs/fAdLeJ7xT/HjG0Y7wOAOvL?=
 =?us-ascii?Q?D6LhUsoYjCOclum6rRFwhiz3kEHKYlmoMsV3faWtfpX6QFn63TPUjeaKSJj+?=
 =?us-ascii?Q?oUfjrQswjKv4j36CAYczegkjFVkGjevgROUMwQjg/wPl+LBI0pIlLoMqZQ96?=
 =?us-ascii?Q?vxN02N+am+T2+PuQ6cbkLaOsB7x2i3bDLvdpTfKCcLQLVrXRfpRtXcTN04uT?=
 =?us-ascii?Q?koGX2QEEyt1kMYNdI15zOyratCy8MyokJl3OIxUKcqaztwFHWIOQI4G/hMCl?=
 =?us-ascii?Q?B6V7kwPEwrDzCiKNedh2ZJHUgYCtMUKpyHwFaWOpkOMKwNmS0JNRubV6c00T?=
 =?us-ascii?Q?ia1J/plcjtaPRtLVicN+jcA9JLqqLFYSkcigilhTK1pkPs/JyD1w3zNjCY4n?=
 =?us-ascii?Q?bY2iqlIAJDlzARtONIi+JepDoqmfUAtKOZoC0GEavgrkjPDDnwgf4/TZFDUl?=
 =?us-ascii?Q?MIkfHAznXnuD6V5t08LkhUdxXub1Hvb/cqVe5GE5eYDjxvbrJR0KAu6nY0Tb?=
 =?us-ascii?Q?rt/odPHc2Gx+Q5TUYfmuONaXOUgtJmaRKOGRoqFYbNN6nyGvj9yYOZKHRIrb?=
 =?us-ascii?Q?sRC5maJYfp0OGB3IU0+WyCc/ngYPSOENiTpG8d2Bik+AxiQbIKgfnhdUODti?=
 =?us-ascii?Q?ejyx6Pzb0s3U/3plN8IdyJiVi0/lvPjcmEminR8fClaXltBgkunL8AACHPCW?=
 =?us-ascii?Q?ywHIPYIfD0pTj0VbBYs8tOQUbRxgHlnRPHjMdfwEGXp3KS3c0LBx0dYw79/B?=
 =?us-ascii?Q?Wbat+qp5Ca2cGCiKqoTJkuPoqsU3tz5amXwK3PipG344uvvIxg+GkcO34oRc?=
 =?us-ascii?Q?ZGSwmEeOzpWx5Xos/10K2tpQFfMAv3FbomPAVWQUEOnUTZDXeXphoDLG51t8?=
 =?us-ascii?Q?ROaGeBD6S860ioSR5WU4iwiExQxy5sfTTe9rCmgYoTbIqXDqmWbHRjQN0fzt?=
 =?us-ascii?Q?ofbQaQEt3EZ0Ilhj2fInWbwjt8gHUWJkNP+hlSYNdO197+pxCG4zdO3ge/+A?=
 =?us-ascii?Q?/+/20iIJrov6JyQ1Yk+FW7HI2DjYoZhsd2pR2tq9RCn4YCUlHyTfuGdalOoY?=
 =?us-ascii?Q?6xYIou0MRDN0VTWYbYSudqlAwd100wKdvjxMYNUwwJqnhXqKbAecO+5br3Jp?=
 =?us-ascii?Q?xh1VRefcUV15KYvPyq1rcklZYJ7aZB89oDu+1jOwmg3WBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PM5Wx2RRlBZg0OByL7V1ZEdzxiR9sRLoLnRleLVWqgbzdRfKQ88OdaziiOl5?=
 =?us-ascii?Q?W3DTj053J2juOvvb13NXTTCmNAfB/LAbo3SGIkMelOcih0PWfmlQfOzz/5M4?=
 =?us-ascii?Q?Qvti2i/NXFaiRfgQoEKN5XKgXCScYxNt690KVtdwppDRsWGKgMwvCBo8n7s8?=
 =?us-ascii?Q?92sm4btgdqIHG2n0RWJJhJpEA2qZDAEns2dnLRHeHv/v4OD2SvlOyHKJHSxx?=
 =?us-ascii?Q?7tbJxbqltARV1oegmrmj0pTq9tUzx3e9KeIgx0TqHnafFQWT0/rQIfz4Us4c?=
 =?us-ascii?Q?uRyXQh31epJbymZE1ecLBQsMFw4wSMi71j44WJuVL7vDotIr7oS1BH0odryI?=
 =?us-ascii?Q?VP7eEdC34VQRQOPcjFxC3HMu3YjYCoUcaJ8Nh68Qp82u2MMcafjdcseTRWFg?=
 =?us-ascii?Q?KmSEHW8LM7m8omNAztsvdFayFT0hCLx+MHAZMFsC5uEqz1qmP55pbN3HVwBd?=
 =?us-ascii?Q?LS0Zd1rMudNS6yd8mwDYslIMlSzpoL6rmtb/g4smja+Ld1kKFQNlfzXdLnUM?=
 =?us-ascii?Q?UoeJhpwgTQ5L3fG7wp3SZZz2vwUN6+wuJ5RIshyrECnBxkr1wSI7XaPnQ/8/?=
 =?us-ascii?Q?puznVoY1uEE1MwxHXyfSck5xR+6p9rKw2aeMB2gassOeo6K+kU5qU85AqF0S?=
 =?us-ascii?Q?HSjUa1AYyTfgi8fKIfumEq/tV3qYDzVbNAUJjGXDNFTVqy/9Kzw1VxkFlkjR?=
 =?us-ascii?Q?4s0Ehdn7KMkKREpm4Fm8+jNNSYhXaJj1olZLG0+iGMpozDeN4iKonLpGCms7?=
 =?us-ascii?Q?I9bfSkvINiE5zFGTDOQoVj8Obj1tUwwEqRt9s5fxdhFW1koElZN66UBMvPGz?=
 =?us-ascii?Q?JsYJLp40VV0P8YoVuLSpTOG9v1T0PcxaH7ljvIJ2CWtT0kgoqHlY/CdT/eM/?=
 =?us-ascii?Q?bdQxu7aBhuLj3NIq8r32rPA/Y2Y24S5lMaSTgC7opDj3B++NtiEbraykfuxJ?=
 =?us-ascii?Q?AoF2gbtZIqvaB2OiLIUfgXu0OZNnCTwGyJ+57ZQbig7cJYLMEKETWipK16j/?=
 =?us-ascii?Q?aVvUinecInief92dVx1PIkgB/gs76NNsCCv0PxSo9x1A+rF3mH9KFMHSjuaU?=
 =?us-ascii?Q?pPs+6v6rvDxk3c1KNrtwEUcIgEJzpEwNTuGp7ppEiISBgGBN8s09qH/WmQDj?=
 =?us-ascii?Q?pyFMrPhHxOEiEBwhr7LOBU/REEaQqrurB/mkQU3uIpySkcq6LkNmDIROrdA2?=
 =?us-ascii?Q?bvEGwjCAox/JTqqEX1YG3tekFo+7WemRd2rlTRr/qubmOymfvfpkCE7gb4SO?=
 =?us-ascii?Q?WN99vbqSmtbYjo+Y8p2RHDENdX5Bz8r3aCfvBdRxpEOdghOFo0lN0xjlR4M2?=
 =?us-ascii?Q?nL4kMhUvggcTlx3TshoAodIe6NnP3xcdIYLOhdZFAAvIFcAj4FHAs45HavkM?=
 =?us-ascii?Q?olHaa9Lf3Q3pZz6VHediPWYwLLYaZs+OGetWEQKSlbvd5S2u1D9LN8saGv0o?=
 =?us-ascii?Q?PRwTmnsWoWR5Is2/TBnpNUCivyDPjxPvqEhdjQrqewZd1NLiw3FLo0YvJaka?=
 =?us-ascii?Q?G+KVuUrnX6kUUiLR5YRF/GNS69yJtJTNNwGcQOc4gtGp84C2CQ4j3BLC+Fgr?=
 =?us-ascii?Q?bK/rw03PKXYzXEDhiOj0XwKWzCceTymVpmTgJG3clskM4fUNWMVsA3UBoIkl?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bf6574-03f2-444e-5f34-08dcdf0c4ca2
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:51:50.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITCM6P+bOsxf2VKq923Kek325ubRZyf0ICr0mQd3GBCOvXrxWvIDRZjYdZH3VcaRvnwz1zWqUJCgDXE4PSMSxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P192MB1740

From: Hailey Mothershead <hailmo@amazon.com>

commit 23e4099bdc3c8381992f9eb975c79196d6755210 upstream.

I.G 9.7.B for FIPS 140-3 specifies that variables temporarily holding
cryptographic information should be zeroized once they are no longer
needed. Accomplish this by using kfree_sensitive for buffers that
previously held the private key.

Signed-off-by: Hailey Mothershead <hailmo@amazon.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
---
 crypto/aead.c   | 3 +--
 crypto/cipher.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index 9688ada13981..f8b2cd0567f1 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -45,8 +45,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kzfree(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 57836c30a49a..3d3fa8d0d533 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -38,8 +38,7 @@ static int setkey_unaligned(struct crypto_tfm *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kzfree(buffer);
 	return ret;
 
 }
-- 
2.43.0



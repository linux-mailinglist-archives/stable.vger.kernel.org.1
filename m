Return-Path: <stable+bounces-121736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B73A59BDF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396A3188CDE9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A1233710;
	Mon, 10 Mar 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="lEr+B2TM"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50881230988;
	Mon, 10 Mar 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625992; cv=none; b=lf5H+EPNv01Y0Hd7CQKg/Lqan0G0mBhqXKl/5C3mWJ18dcRS7EuDgeAH4PBQKpPqGRxnFNjjbRuVTKsKmpVVG9m/llu2HpKiwJRaQ5FB3ivR5yi1mHuhnjsBztgZMAD4cM0y1uHOuXfhHlJpcoAlcZl3fMcFNo/f8ncx7Aefs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625992; c=relaxed/simple;
	bh=km2IGdJt2Zt2W/qgfZG1Lab7vtwETfZ7Ls52FOlKepE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0k/p8bvr7MYrEOKumr5zcxTg954mDA/OWi0IF2SrUcZJDKGULPkF+CiTZmN6mN5WZrWSOe8RvwDA6rseuOqYlQ4ViPHbQHziTNzNitsdZBOPLxeNKhVisqbwRrFaEOkSP0VEg90MpsqTX+fDUJn/dPrji+l0WGxf/QoJWiAy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=lEr+B2TM; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741625981; x=1742230781; i=fiona.klute@gmx.de;
	bh=km2IGdJt2Zt2W/qgfZG1Lab7vtwETfZ7Ls52FOlKepE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lEr+B2TM1og/6h/R/DnZdw0KAubAPCXD6CmmBFRJkoBa/AOYay1Txdn/g1o+y4K3
	 oXtnPx/5qwXIr6cqzSq3GgMYXbhMN6lPlEqF1NjKEszAEvrsnN3vJmFOJIFZO19ct
	 7Ck9eH19W+nrOU5zqstS/R4DpAz5T8jiS2+G40KPammcEKzXUqv+smnGqZAZGLcrZ
	 Ld74SXCrnFQhYGkjj7VAnFky/TjWwHPC4B4klm7p+RK+tHfXcYq23CRcis6tdmWxy
	 WR7g1h4zttFF5eXZgAYZsjRzUAjN753IlEz0jK/4nmO2Zr/uG9DWmBUCtgbKqRFNo
	 DCKG1KxKbvUrDSCXIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.124.30]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhyc-1u4LeA3Hne-000h9z; Mon, 10
 Mar 2025 17:59:40 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: netdev@vger.kernel.org
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fiona Klute <fiona.klute@gmx.de>,
	kernel-list@raspberrypi.com,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling period
Date: Mon, 10 Mar 2025 17:59:31 +0100
Message-ID: <20250310165932.1201702-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:YYGO+4uzgBGjMBAgVnoBmWV0/iNMfrX+PvlpPtClFX82DXYtx/t
 V0hQLs/Lg7kApN6BGiEWA2n61AMZfA6qQ2HRixcdn8FMqrckdrIS7msv3MwjsuNTBT6VVVw
 ezeEhMzwrdrEDhv1Vh7om3hdSPLUi9GdScYkxG4fKFH/9/vQ9MG2WmoEmnW3QufDVST5mIl
 OgTNEL0HEhBDmFpQBM9kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xX8wuS/r/h4=;d3UWide7pAM7x2u3z4E84qqiQ5x
 zTF/zGW9SAqyXGT7WMtqYfz1BzXB2bI2Lvlb5KDs+kByY2s7VNwDvbq/o+UjI0kjd+GbW8Nwp
 SRW/wtSCbA3z0+vC/XHVLQkJvm3meHrdwzUcg9Hx/k+Fdl5SblIwMEiloMaXR0JX9i7nxdsU4
 cSDHar6Pcu51kaYOhT7NOOKM3IIn6SutZYBerYbaxFziII5UzI7WTMHdip6fB9SxVZDOr1k7+
 OoS/L+e2+TZOuCKc9ix0zHspFlX0at0ZQSvpgXNhSnfmkR8Yq/dTF+v7EY4f+FsgbJX0CFzdM
 fhRheSQmLq/99dhgsIJmi+NufP1dyG902rT6xuQJ6odF03O3lwdTRTkxnWOWZpN2pnWmUBK1C
 4nI5eXidryEpYi4ARlmYxjhN9vMlv4PGhEEMSp4CcMe0SQvquNQ/YzB6CPFkgnZNXjeTpBW0m
 eBf5kD8tSXGlwuQW+vORm7emELY7VyKHDQHte0GRn9preQENFhPev9uQvEVBNzLlk6MHFBTg8
 OmPq4sCqRCdNC3KXKwUvxabN2unP37NjfDjCIUcKnBGD/m4Pgafg/ymrG2isIWGTz2eR2MC+a
 O0iaUdO5qRID0mvN9+jFfk/yqngkZRdFDUhuksYvoLLl1CFz1zU2SgLiSeHgnNB5GsbN0A6ye
 6B9eHQYjjq1EKmRsQQpweOiT8j0zrlvKT8x2bSoCN6X9OpPbWU3z+YNpjM0UkkTMF9A70iXvR
 voPJwwCcTUD2e2gFaDi96wXKTE3QIvB7zJS+Gxr7ao73R+oIlUfLI7hzsVSx08jy/R88JOncN
 hmT3XnK+XTz9+iOpy8CmF57ktIYKWDzCYbIf4pTniCN8MndXIDJ0mMzepeBQSUz+jwvtvr5Bd
 j0BfyDl9mo+vE+XIcL87TBZDQLryOlf5dwDFIagNLzY0WWrjfbdHho0Pwb6uN87mMPfhLZpVQ
 vTwLWV/hL5X+zuoMLATMbRx2zTg5oVUroB0SYNNHPftpQGCeYPfTBeqFMr8LpKSgD+GgyUmyY
 e0PrOkb+2s/Rqox3SAmeDoGebRTYZg2lj50lYPepP6uGPeA0ucFPe6nQouNYO3Qzr/Fynm+BB
 t6JUy20vmod5O55FsBRMNADKL9UsktvjnV2N0Y/y9VnbtRvr/Et8hL4uOWKoAmTMPZkphkCp/
 KUcFbROOX6OJcsgawpC2GZEVrcJ683iEJGTwKDIPdabCIglh4ovZd1l20gEaqTtdDnH3X9LS0
 Gw+mBZkKugO9oP1WP9hj5sDvkrZtz56v0I6ipZ7xOi0hf/d1llzGZOdS0Jq7UYRRODSd0vH2s
 lnUJT8CKrPbdU46wBPOYDu6KkueS/KedqsHTvvxxrYLTm53Gl+idGzNzDTUTkeRMAXbCg2xDV
 zC6RiRc0YlQYBWZ+G4y0MrHP+k7zA7+Yw6S5I9/6iCLtghs/oEM/bfqJI3O17KSqmYOP7y0h2
 D1jC8zyznKx00Gob7FCyw//fXS0RW6tXXv0yziycjBiql+/Ii

SWYgYSBuZXcgcmVzZXQgZXZlbnQgYXBwZWFycyBiZWZvcmUgdGhlIHByZXZpb3VzIG9uZSBoYXMg
YmVlbgpwcm9jZXNzZWQsIHRoZSBkZXZpY2UgY2FuIGdldCBzdHVjayBpbnRvIGEgcmVzZXQgbG9v
cC4gVGhpcyBoYXBwZW5zCnJhcmVseSwgYnV0IGJsb2NrcyB0aGUgZGV2aWNlIHdoZW4gaXQgZG9l
cywgYW5kIGZsb29kcyB0aGUgbG9nIHdpdGgKbWVzc2FnZXMgbGlrZSB0aGUgZm9sbG93aW5nOgoK
ICBsYW43OHh4IDItMzoxLjAgZW5wMXMwdTM6IGtldmVudCA0IG1heSBoYXZlIGJlZW4gZHJvcHBl
ZAoKVGhlIG9ubHkgYml0IHRoYXQgdGhlIGRyaXZlciBwYXlzIGF0dGVudGlvbiB0byBpbiB0aGUg
aW50ZXJydXB0IGRhdGEKaXMgImxpbmsgd2FzIHJlc2V0Ii4gSWYgdGhlcmUncyBhIGZsYXBwaW5n
IHN0YXR1cyBiaXQgaW4gdGhhdCBlbmRwb2ludApkYXRhIChzdWNoIGFzIGlmIFBIWSBuZWdvdGlh
dGlvbiBuZWVkcyBhIGZldyB0cmllcyB0byBnZXQgYSBzdGFibGUKbGluayksIHBvbGxpbmcgYXQg
YSBzbG93ZXIgcmF0ZSBhbGxvd3MgdGhlIHN0YXRlIHRvIHNldHRsZS4KClRoaXMgaXMgYSBzaW1w
bGlmaWVkIHZlcnNpb24gb2YgYSBwYXRjaCB0aGF0J3MgYmVlbiBpbiB0aGUgUmFzcGJlcnJ5ClBp
IGRvd25zdHJlYW0ga2VybmVsIHNpbmNlIHRoZWlyIDQuMTQgYnJhbmNoLCBzZWUgYWxzbzoKaHR0
cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJyeXBpL2xpbnV4L2lzc3Vlcy8yNDQ3CgpTaWduZWQtb2Zm
LWJ5OiBGaW9uYSBLbHV0ZSA8ZmlvbmEua2x1dGVAZ214LmRlPgpDYzoga2VybmVsLWxpc3RAcmFz
cGJlcnJ5cGkuY29tCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCi0tLQpGb3IgdGhlIHN0YWJs
ZSBjcmV3OiBJJ3ZlICp0ZXN0ZWQqIHRoZSBwYXRjaCB3aXRoIDYuMTIuNyBhbmQgNi4xMy41IG9u
CmEgUmV2b2x1dGlvbiBQaSBDb25uZWN0IDQgKFJhc3BiZXJyeSBQaSBDTTQgYmFzZWQgZGV2aWNl
IHdpdGggYnVpbHQtaW4KTEFONzgwMCBhcyBzZWNvbmQgZXRoZXJuZXQgcG9ydCksIGFjY29yZGlu
ZyB0byB0aGUgbGlua2VkIGlzc3VlIGZvcgp0aGUgUlBpIGRvd25zdHJlYW0ga2VybmVsIHRoZSBw
cm9ibGVtIHNob3VsZCBiZSBwcmVzZW50IGluIGFsbAptYWludGFpbmVkIGxvbmd0ZXJtIGtlcm5l
bCB2ZXJzaW9ucywgdG9vIChiYXNlZCBvbiBob3cgbG9uZyB0aGV5J3ZlCmNhcnJpZWQgYSBwYXRj
aCkuCgogZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYyB8IDEyICsrKysrKysrKysrLQogMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC91c2IvbGFuNzh4eC5jIGIvZHJpdmVycy9uZXQvdXNiL2xhbjc4eHguYwppbmRl
eCBhOTFiZjljN2UzMWQuLjdiZjAxYTMxYTkzMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNi
L2xhbjc4eHguYworKysgYi9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jCkBAIC0xNzMsNiArMTcz
LDEyIEBACiAjZGVmaW5lIElOVF9FUF9HUElPXzEJCQkoMSkKICNkZWZpbmUgSU5UX0VQX0dQSU9f
MAkJCSgwKQogCisvKiBoaWdoc3BlZWQgZGV2aWNlLCBzbyBwb2xsaW5nIGludGVydmFsIGlzIGlu
IG1pY3JvZnJhbWVzIChlaWdodCBwZXIKKyAqIG1pbGxpc2Vjb25kKQorICovCisjZGVmaW5lIElO
VF9VUkJfTUlDUk9GUkFNRVNfUEVSX01TCTgKKyNkZWZpbmUgTUlOX0lOVF9VUkJfSU5URVJWQUxf
TVMJCTgKKwogc3RhdGljIGNvbnN0IGNoYXIgbGFuNzh4eF9nc3RyaW5nc1tdW0VUSF9HU1RSSU5H
X0xFTl0gPSB7CiAJIlJYIEZDUyBFcnJvcnMiLAogCSJSWCBBbGlnbm1lbnQgRXJyb3JzIiwKQEAg
LTQ1MjcsNyArNDUzMywxMSBAQCBzdGF0aWMgaW50IGxhbjc4eHhfcHJvYmUoc3RydWN0IHVzYl9p
bnRlcmZhY2UgKmludGYsCiAJaWYgKHJldCA8IDApCiAJCWdvdG8gb3V0NDsKIAotCXBlcmlvZCA9
IGVwX2ludHItPmRlc2MuYkludGVydmFsOworCXBlcmlvZCA9IG1heChlcF9pbnRyLT5kZXNjLmJJ
bnRlcnZhbCwKKwkJICAgICBNSU5fSU5UX1VSQl9JTlRFUlZBTF9NUyAqIElOVF9VUkJfTUlDUk9G
UkFNRVNfUEVSX01TKTsKKwlkZXZfaW5mbygmaW50Zi0+ZGV2LAorCQkgImludGVycnVwdCB1cmIg
cGVyaW9kIHNldCB0byAlZCwgYkludGVydmFsIGlzICVkXG4iLAorCQkgcGVyaW9kLCBlcF9pbnRy
LT5kZXNjLmJJbnRlcnZhbCk7CiAJbWF4cCA9IHVzYl9tYXhwYWNrZXQoZGV2LT51ZGV2LCBkZXYt
PnBpcGVfaW50cik7CiAKIAlkZXYtPnVyYl9pbnRyID0gdXNiX2FsbG9jX3VyYigwLCBHRlBfS0VS
TkVMKTsKCmJhc2UtY29tbWl0OiBkZDgzNzU3ZjZlNjg2YTIxODg5OTdjYjU4YjU5NzVmNzQ0YmI3
Nzg2Ci0tIAoyLjQ3LjIKCg==


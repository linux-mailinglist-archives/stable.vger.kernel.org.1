Return-Path: <stable+bounces-200814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E4CB6BA0
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C0B301460D
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B132E759;
	Thu, 11 Dec 2025 17:28:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from postmaster.electro-mail.ru (postmaster.electro-mail.ru [109.236.68.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A732E74B;
	Thu, 11 Dec 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.236.68.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474122; cv=none; b=iawgprq65+8FlL+X07I4rSchbcfoANnhbLDBUse6S6bRTY0ZFD/xOjGtLlC4uQfsppQdnjIaDzJOUELXFkcQvUVnTRnlwTtv4sl0/KYyFzWF2NwywjIzbOLF9jqUkENF8e3lHYBFEt04OMTRSBBsXV5GznUoMnWK4L7EQX0d7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474122; c=relaxed/simple;
	bh=T/dm7OIlslDZXHic99rW+tVYDUBXp3KoPXPGBWq5XDk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNPAAb5FX1G1kiuCBCujGsB6TIh0tNHGIK4Lan3THx5bu1L1gdSQYMU6fhNItAuMLusXFVVpLLkfCbSaMKFSnd0nHLn5EYHkvgfFfAhn9miMwARh99LPGKj+Ql0wiy4ZGAsEsVojcz6Iqk5qNhANBJX/8R16KxKJ243ebcUOAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru; spf=pass smtp.mailfrom=tpz.ru; arc=none smtp.client-ip=109.236.68.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from localhost (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTP id 2BE861006BA1;
	Thu, 11 Dec 2025 20:21:02 +0300 (MSK)
Received: from postmaster.electro-mail.ru ([127.0.0.1])
	by localhost (postmaster.electro-mail.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zg4ggldvyhIu; Thu, 11 Dec 2025 20:21:01 +0300 (MSK)
Received: from postmaster.electro-mail.ru (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id 6F3B61006E0F;
	Thu, 11 Dec 2025 20:21:01 +0300 (MSK)
Received: from email.electro-mail.ru (unknown [10.10.0.10])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id 5E3251006BA1;
	Thu, 11 Dec 2025 20:21:01 +0300 (MSK)
Received: from lvc.d-systems.local (109.236.68.122) by email.electro-mail.ru
 (10.120.0.4) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 11 Dec 2025
 20:20:59 +0300
From: Ilya Krutskih <devsec@tpz.ru>
To: Nick Terrell <terrelln@fb.com>
CC: Ilya Krutskih <devsec@tpz.ru>, David Sterba <dsterba@suse.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v3] zstd: fixed possible 'rtbTable' underflow in FSE_normalizeCount()
Date: Thu, 11 Dec 2025 17:19:49 +0000
Message-ID: <20251211171950.852001-1-devsec@tpz.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-ServerInfo: srv-mail-01.tpz.local, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09.10.2024 20:59:00
X-KSE-Attachment-Filter-Scan-Result: Clean
X-KSE-Attachment-Filter-Scan-Result: skipped
Content-Transfer-Encoding: quoted-printable

'rtbTable' may be underflowed because 'proba' is used without
checking for a non-negative as index of rtbTable[].

Add check: proba >=3D 0

Cc: stable@vger.kernel.org # v5.10+
Fixes: e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream zstd version =
1.4.10")
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 lib/zstd/compress/fse_compress.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/zstd/compress/fse_compress.c b/lib/zstd/compress/fse_com=
press.c
index 44a3c10becf2..6b83f8bc943a 100644
--- a/lib/zstd/compress/fse_compress.c
+++ b/lib/zstd/compress/fse_compress.c
@@ -492,9 +492,10 @@ size_t FSE_normalizeCount (short* normalizedCounter,=
 unsigned tableLog,
                 stillToDistribute--;
             } else {
                 short proba =3D (short)((count[s]*step) >> scale);
-                if (proba<8) {
-                    U64 restToBeat =3D vStep * rtbTable[proba];
-                    proba +=3D (count[s]*step) - ((U64)proba<<scale) > r=
estToBeat;
+		if ((proba >=3D 0) && (proba < 8)) {
+			U64 restToBeat =3D vStep * rtbTable[proba];
+
+			proba +=3D (count[s]*step) - ((U64)proba<<scale) > restToBeat;
                 }
                 if (proba > largestP) { largestP=3Dproba; largest=3Ds; }
                 normalizedCounter[s] =3D proba;
--=20
2.43.0



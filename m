Return-Path: <stable+bounces-191492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E05FC152DC
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88853584B64
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872F336ED5;
	Tue, 28 Oct 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ldy13xPC"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79A3081AC;
	Tue, 28 Oct 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661691; cv=none; b=Dt5AzyEYJ3nlXcHcBWiC23KkFR5Zua386W1p99DnzYlzLIQgoS6j/PcwvOb7kBSgnrblW+PL9PTYwM5v5GrFDg58RFxWY/ze5OMJwz/phqmxZLi8dSdNpR4DPrEXz2rusIfzHytVdEchjgDeHvwP9jJVKwQctzT8/x12V7u3tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661691; c=relaxed/simple;
	bh=RPppPMVEQPsh2y1GjpYuNxHxtRlMaDPmxSkKWCrYkjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cw4akZgQhnmaFRR27kqS4BLRKKhMzn+0EbQmnTBXlL6lBtdmiz38sb2dzcCE7EQe+NyymR4wOyu2L4GHoB/G7GOCKSNGlxcrwKTJtzEA4em2c/fTkfGele9nRcwZyuNFAY51gxFCTMlOFPd/C9sBMtXxSP7MeN6dDutXTZRbYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=ldy13xPC; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 808E180A9D;
	Tue, 28 Oct 2025 17:27:57 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:2::1:3d])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id qReQdZ2b5W20-gMxKwSGD;
	Tue, 28 Oct 2025 17:27:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1761661676;
	bh=sk8MoiTs5k5APW6gtqgCF2xdeZ/K2hxjvJJvk7+8Gco=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ldy13xPCco84f30jCUKGJK2uye3U0A4XDxBVSzjuUzDP/hE3rCRahp0ngOdPLzjuO
	 9bx/+jxFXKx1KQjjHiyT+URHWikCkLFn6JkRaG4GjuFJeQ3NwkPQ5R+417i7hiMKYU
	 auX0v2/if7KFGUbpkkOUMj63prQGubGFDCe+R4BI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] ipv6: sr: Fix MAC comparison to be constant-time
Date: Tue, 28 Oct 2025 17:27:55 +0300
Message-ID: <20251028142755.2059-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@kernel.org>

commit a458b2902115b26a25d67393b12ddd57d1216aaa upstream.

To prevent timing attacks, MACs need to be compared in constant time.
Use the appropriate helper function for this.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Link: https://patch.msgid.link/20250818202724.15713-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Andrey Troshin: backport fix for 5.10]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2025-39702
Link: https://nvd.nist.gov/vuln/detail/CVE-2025-39702
---
 net/ipv6/seg6_hmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 4a3f7bb027ed..8bb7f94cba1e 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -35,6 +35,7 @@
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/algapi.h>
 #include <crypto/sha.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
@@ -270,7 +271,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;
-- 
2.34.1



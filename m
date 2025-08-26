Return-Path: <stable+bounces-175341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FFB367B9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B75A563D34
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF634166B;
	Tue, 26 Aug 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmxjLD+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E176C22128B;
	Tue, 26 Aug 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216779; cv=none; b=bQD7vqDTVj9yOIYGlXkuGyZkqU9EPSWw3Va3q9CBnIIgsNDxUE7APsIo/Z2jr4pGZvKGAUXysDqmK6ICrHtDFqKR8QphuhpyoPIomVwRaqnV6UIf2DiKb9FJ0kJoHIUwhddHgranStxGJMVkpHpsU6OKpuP5W9dD5oqRfsqCLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216779; c=relaxed/simple;
	bh=90SrEAJGTNZGkRrlUBN1Xbca6tI2O4rl8p2dnBNK0/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8dNHBn2u0CEbemOg+mGGxpmfTeiZ6uq/P3glANMWeVTkCWAVuevdg9SjXX1CJtUwW+CWhVb9QeiJcc1U6gsGe98dGBJ2QhF5UC2zKRvruLyVD+mE4VBwpJWq57Nxf3FMbJvonPweh8pGblnGEf9N3vmEV2D43eEJhWo6UsmCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmxjLD+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74074C4CEF1;
	Tue, 26 Aug 2025 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216778;
	bh=90SrEAJGTNZGkRrlUBN1Xbca6tI2O4rl8p2dnBNK0/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmxjLD+EhYs6/qCNKzSkMx6PNmFAPD5+81gyT3o2sC5D+/DQQHNiSfJxzrYgU3Neo
	 g0opJpjHOpFJ2U4j5Ed52xjvMeGnZ0+BiZFLhgHRcRKK5gMorquHe/wOmrdJdTYZas
	 BtnMFPd/xwFLXNLdIEOzsB0Tpo67VHJ0zdjlyBS0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 500/644] ipv6: sr: Fix MAC comparison to be constant-time
Date: Tue, 26 Aug 2025 13:09:51 +0200
Message-ID: <20250826110958.885884651@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
---
 net/ipv6/seg6_hmac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -35,6 +35,7 @@
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/algapi.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -269,7 +270,7 @@ bool seg6_hmac_validate_skb(struct sk_bu
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;




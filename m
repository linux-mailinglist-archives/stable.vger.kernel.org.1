Return-Path: <stable+bounces-173533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD72B35DD0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD637188FE9E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71523D7FA;
	Tue, 26 Aug 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kXC/8O4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE393DD1;
	Tue, 26 Aug 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208495; cv=none; b=ouV3XrCa/791wd3VCCEwGHLQQ/rMXPbZlQXvH6xOwtpThdTh+x+boIzJioiHv1zA8CrvxGAz7e7/ZG8wYjgR4PvSxMB54xc+/9R1Xq9a2KvfNUzPzJXImRG/aAFV/3obTX6RZP5OT99fUtPBe3KyQ6Ejp86hDYWgdLZhoL+GHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208495; c=relaxed/simple;
	bh=Q08WXDafU4pVzOK1n45X45NtyOnutR+BuVdHgJ7DMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iduN8SV10ua69st9K7n3iRoRLLmxFu8WiSQnH4XHqmEmD3Roy/aKuKD2NZBMHHirEkTHSFcDmTFOUHvim4+qJbk7fB4zWMe9tCzURH67KbJZchSKlSA1UWT6s3DcNEHEGw7m2zt7zChiTtrDtVkYf5kDaur1U9sXp7EdmCzj70U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kXC/8O4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F6FC4CEF4;
	Tue, 26 Aug 2025 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208495;
	bh=Q08WXDafU4pVzOK1n45X45NtyOnutR+BuVdHgJ7DMdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXC/8O4xRtkpt+OVl1I9ysKb+3Vf9gWk+IOiVRJ+Wo0W+PbpqABReNrXXrcfCc68M
	 LDExCM2PMMWG3ilI2jJsOm7ei2vWlKxawi03w5YAWXYRqCQLjschvQClobRIRguIDx
	 0+IwlOGG1hJUkxSTf4c/dTFUe8Grey8lachW0YqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 133/322] ipv6: sr: Fix MAC comparison to be constant-time
Date: Tue, 26 Aug 2025 13:09:08 +0200
Message-ID: <20250826110919.083630254@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
+#include <crypto/utils.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -271,7 +272,7 @@ bool seg6_hmac_validate_skb(struct sk_bu
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;




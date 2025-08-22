Return-Path: <stable+bounces-172287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEDB30E4F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5CA5E04CD
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFD2E2DCE;
	Fri, 22 Aug 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e54yyojC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FB2E2DC7
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842046; cv=none; b=F8+6Sc6oTlPN/xOKN8GGpX5r/jyld8/D/QVYjW6pIy53HABRRCMYfWuewpAbASlrUuLsiTs4xuuhXQKDrTtoIwxths3Eh+scGMEXOQqZ6BEhEzhaqdFHN/r/Evs2F6yTreEM29HxOA0DqzKvLiXflJdEgE5jg1vvD0Lx8wKbFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842046; c=relaxed/simple;
	bh=ewf6lmrVx8psNP/HZfhfFBVHGdbqh4uih7B1X/x+enw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RlLAF/BZxSKQCKjIVZFosIS1UtZlyv+rTs91mVPFLjXSUtyyRNicFKWhq/sOA856W6JB1aCRb76Z6slMa24d1bvUTOJWGDHOxh/+fyLhPe6lo4Z0Ot/w9KqfM5Y1tdav6+ZxM49uTWzTrBj1axNq9CeDMoqUduEZVD330EmplHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e54yyojC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03AAC4CEF1;
	Fri, 22 Aug 2025 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755842046;
	bh=ewf6lmrVx8psNP/HZfhfFBVHGdbqh4uih7B1X/x+enw=;
	h=Subject:To:Cc:From:Date:From;
	b=e54yyojCJhYNEDspTtayL7n34wr4C4VBjEmvx9D5YElVTGXUzrFqqY4F/vL1o8QgF
	 OKQkEKXZ8tO7XvN90+C9r17GSqOY9E/C24LGoKsy5oK8dra8snFizxRMMglBNjAHYp
	 rh/GlE+0B5+HfaylFPfJQ21SE1teftD2gtGPaRog=
Subject: FAILED: patch "[PATCH] ipv6: sr: Fix MAC comparison to be constant-time" failed to apply to 5.4-stable tree
To: ebiggers@kernel.org,andrea.mayer@uniroma2.it,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 07:53:50 +0200
Message-ID: <2025082250-legwork-enhance-f1d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a458b2902115b26a25d67393b12ddd57d1216aaa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082250-legwork-enhance-f1d3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a458b2902115b26a25d67393b12ddd57d1216aaa Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 18 Aug 2025 13:27:24 -0700
Subject: [PATCH] ipv6: sr: Fix MAC comparison to be constant-time

To prevent timing attacks, MACs need to be compared in constant time.
Use the appropriate helper function for this.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Link: https://patch.msgid.link/20250818202724.15713-1-ebiggers@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index d77b52523b6a..fd58426f222b 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -35,6 +35,7 @@
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -280,7 +281,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;



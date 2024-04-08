Return-Path: <stable+bounces-36584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9889C080
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8F7281585
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BE6FE1A;
	Mon,  8 Apr 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zakUwgrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC182DF73;
	Mon,  8 Apr 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581753; cv=none; b=EPvE/n4AApmGc2GF1wH/J0RRg5XY3t5o926rwdOmuOdudROx7XWXCU65Cccj1cqOpGu3SAXo56X6XE+uGkQHe0phuFpfz7G+8jKi60Pfh3oOzOIBIorNLzkObGVWtXXvm9jRTIKVq/svAtLyplWKG3aiX8NcZ1bSSVkABrL5eHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581753; c=relaxed/simple;
	bh=O30wXV4IcYtbSW1ped+41W4byDuPSHLFrLSfVLbGN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaJlcxHm2rCrmZeH/ojG0Trygg+EixY5XJzhTOADW5nmhWUKo+GxoX5F8rtCx596mmSKvAr+3cc2OGljf3FfZCMRO7TVCTU/fi5p0TAR5MeRfdTX76siVGWFxdqs5wAeVj0YTQc/pT2Ugj1+KGUGFnu4pa3yiU4X/VEE/nE/IE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zakUwgrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DA1C433F1;
	Mon,  8 Apr 2024 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581753;
	bh=O30wXV4IcYtbSW1ped+41W4byDuPSHLFrLSfVLbGN0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zakUwgrTpggGF6Z1y0CnV/PIXfsHe6BG9NNAIAkJuK9WyBCuLX+92ot4HO5+MOfHR
	 2IQNaqypt8i56U7o5I+iS/bZvd9bX18ZtDpxOMRki5Jvx52JUZrF/aGxgttjDgKkaj
	 hkbOPh4RWMSzXAwf27i/3IHvBKv+Ng2KeI53vAh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/252] tls: adjust recv return with async crypto and failed copy to userspace
Date: Mon,  8 Apr 2024 14:55:29 +0200
Message-ID: <20240408125307.582009646@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 85eef9a41d019b59be7bc91793f26251909c0710 ]

process_rx_list may not copy as many bytes as we want to the userspace
buffer, for example in case we hit an EFAULT during the copy. If this
happens, we should only count the bytes that were actually copied,
which may be 0.

Subtracting async_copy_bytes is correct in both peek and !peek cases,
because decrypted == async_copy_bytes + peeked for the peek case: peek
is always !ZC, and we can go through either the sync or async path. In
the async case, we add chunk to both decrypted and
async_copy_bytes. In the sync case, we add chunk to both decrypted and
peeked. I missed that in commit 6caaf104423d ("tls: fix peeking with
sync+async decryption").

Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/1b5a1eaab3c088a9dd5d9f1059ceecd7afe888d1.1711120964.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8e753d10e694a..925de4caa894a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2158,6 +2158,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek, NULL);
+
+		/* we could have copied less than we wanted, and possibly nothing */
+		decrypted += max(err, 0) - async_copy_bytes;
 	}
 
 	copied += decrypted;
-- 
2.43.0





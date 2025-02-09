Return-Path: <stable+bounces-114456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75CCA2DF80
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2873A5692
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1531E0B77;
	Sun,  9 Feb 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTCcXczn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F5E1119A;
	Sun,  9 Feb 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122930; cv=none; b=Gsp1Z5D3JFKZcK06JKC1D8b7QRMiR4jWl5sbSKrp8/x6r/X/eSNOFJZKphifeVbL8mzmuxi2ed4BcVPwCUmd0eyVumYK9G4oKnNLRKiZQtfRigKFb4x+qIXLYgg209nBJmEAf2uaM96aigUQjv/qfRrUWphmhGQ8DJQ5LyIeCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122930; c=relaxed/simple;
	bh=F7lSmTtZ12m/cWxNcdEPbmyjEXmPj1XaxnHpeuWnrN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzS1LRCMIgKxnf2YE66r47w5W66+uxZrv4KSGP5DwYrM6KMdKlbxZVdxpAX42jXhnBaSe3uKC42f8RR8Y6LvYxiGnu91A1xmRQoWh7PTz4WDuRqgPEiL/mnSRAIJJS3G0sHQcYqprRz2V060zQDjIwszbTyLPzQjc/VoWnfV49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTCcXczn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF65BC4CEE5;
	Sun,  9 Feb 2025 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739122929;
	bh=F7lSmTtZ12m/cWxNcdEPbmyjEXmPj1XaxnHpeuWnrN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTCcXczneZRQ1/S1vKPuvaCggrb2AfFl9RERaYVYTqcOmTh3KUdV7q8cStQw7Bbgg
	 u2ojecCC8LdK58bAs1NldRMPHiNISFDSpZRfSDFx8BjShLGJ8+xSJKfFED616M1sMt
	 V7O/8zccg/vrXuDHj27S8R4qMqzeNoqOGlpc6ByG0fLU9dqSzAhQvp7LZL4fzaS90/
	 +i5yq1B9gixa0mRgXqhS3pUTH/Q2HvZlPuSj53kU+9/SxF15w+uit7zbLqW3nZKOSE
	 wsVl0yYElZa6o7DQtBe3xx1dy31YhB7mvrK5u+MwHiOz3hJ8BU7rlmfmuTSbbtPu1t
	 fhPxbQAq+6rBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 2/3] mptcp: prevent excessive coalescing on receive
Date: Sun,  9 Feb 2025 18:41:56 +0100
Message-ID: <20250209174153.3388802-7-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025020428-unashamed-delicate-248c@gregkh>
References: <2025020428-unashamed-delicate-248c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401; i=matttbe@kernel.org; h=from:subject; bh=HeyVUCKT0HMgrifLoTkaS/d9bUfjgdVIGBDHCLIkFbE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOjhbSWQ2y+P62ITRLHru8idpdv3A0XMdsvI5 I1OpIMeB4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jo4QAKCRD2t4JPQmmg cyy5D/9643udON/LE5wd+52jxPH/wK3B6nUk2+YfwufEBCKtsZC4FfURGLCpmfLKa39wyeyFgbe tHemS9a+zwjCIgfDzhF4/qtp6NWvHdsDfsbpJRsijUTg7L0vY8h/ZuS30zbUBJtyX5zhYY5OJu5 Bz56PsYU/GMftvMLeNfDMJ+6RfZ0W3sQJ/dXvg0r7XqeanNEHCewbthk446trcrdYGjcGIGIfGe ot4copnNFpXUSLCyUZ74t8xpofKZ9sSfHd0gd0fHoKVto30+PX0u1RV6azxW/q+J9F4jynYQE/B TK4M6EtKibdC7zCS9XXIUArKPYTfGWK0PZt7Kzhg2y8rZQaUoWZ4SsNbBnCyAX62SozQ1iCW+6i /nsH14io8jJwtbMLMWH5CcMPVuACTVgpELVmfrhL+UpeIrQ0ewvneej/gmjt99NkTwGkyvFMjZj 15rTR/8wqUm6sZiRCgUUSfUd5aBmxXvIpJxcMAEGUqs3rvOk0myV96Az5m1QVy73mFdn8DBjz2D LTLoewnoc6c9OHwidPpX9Hq+1vVSBTDGNQScLfrWFtZ8AnR3bKLyZPneoqVN1b2bkSMi/hzHNL9 1PuHJb9nVpFvwz0vvgugmA9v3we3LUU6qquojoWezbmd7sw3ykn1Vje2df5FvWuWHxsFXi81rF8 efbKnP9mQV19t6A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5143214695dc..140c3ffcb86b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -138,6 +138,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.47.1



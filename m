Return-Path: <stable+bounces-191409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C82C137DA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5D11A28110
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705762DC766;
	Tue, 28 Oct 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt5J+hvo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2962DBF76;
	Tue, 28 Oct 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639442; cv=none; b=SBl90qWiZXKPatl9qDnJgswgWygJambZUddYNVehSqbdb4aTwx913mIIuBGzsy9Ds5G7SDGpXSeNB1/PLd/TgM2zzKWmAM4Td7ak9ii8n04CVG76M/zD4RzmMrmTuM7qc5RzyYyRA81l5woCAZoIQopUiB/3balfhFW9RIptAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639442; c=relaxed/simple;
	bh=MymROo5KMNC0/BGAYHfaUej+w8REkBWRZ3GOvJZswpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgFKYUr+0HdfhuJ39vlBqPKXJXZh99t1j2AttrFw6WeKyfvh1HFpPpAlDY5a4v9ZAeS99egCOoP++ku6B5zo06vArJN6fyRTDIkpNccD8R8SWXJ01PLLcbUhnXovZUXQaEeK3SkSQ6oYuw+8BCMKWW8217QZpaHeRs9Y2i1rWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt5J+hvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B57C4CEFF;
	Tue, 28 Oct 2025 08:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639442;
	bh=MymROo5KMNC0/BGAYHfaUej+w8REkBWRZ3GOvJZswpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dt5J+hvov2+AXiFEWXlzd1XhrXpk0fkoIepJOlWRibB1vGdf/gCB2LySIVzNNKNA9
	 y6MREpEXOcK+0vtkqEcMpUvZp8eG0QLEO5LUhMHxvZ50kq1BFrHsr7vjnxPIxd6Pmw
	 43As6k/b7h2zARafAot6LaveRSL7kj07ue3vDkDY7XiUX1+mR7dgM0oTtHxDuRDBWC
	 y19sqB9nFDq4X1yCy46i9A/5J6HYB0wx5jlcD62lo7YDyQ/dFI5jI7zXkSQ4d/4KWS
	 IJc5v5n2sVtV+d3teT8N9z5W1q3yr2ASsNoAD6AG3EbthHCm003GUHs5Us21etGH6s
	 2dYtf78cbpkzg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 09:16:54 +0100
Subject: [PATCH net 3/4] mptcp: restore window probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-mptcp-send-timeout-v1-3-38ffff5a9ec8@kernel.org>
References: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
In-Reply-To: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=q1if2Zh0yPb1hHZTezlXTUXfw6KBLXDo86EIQ69syLg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZaljZVq7JSbLoUYg526M4l2eJWCx348bpWWVMUU6X/
 xSrtHl2lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATERQgOG/23QPIZ2vm26Knz/7
 1JFfYeoUFvN9nNavHcSczlbvOFWjz/BXSj1+UtQtv+5u28YPJ9Ku8BkeuPn1Qa+N4snznCsP7nr
 JBQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Since commit 72377ab2d671 ("mptcp: more conservative check for zero
probes") the MPTCP-level zero window probe check is always disabled, as
the TCP-level write queue always contains at least the newly allocated
skb.

Refine the relevant check tacking in account that the above condition
and that such skb can have zero length.

Fixes: 72377ab2d671 ("mptcp: more conservative check for zero probes")
Cc: stable@vger.kernel.org
Reported-by: Geliang Tang <geliang@kernel.org>
Closes: https://lore.kernel.org/d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6d1553fbd61..2feaf7afba49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1290,7 +1290,12 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	if (copy == 0) {
 		u64 snd_una = READ_ONCE(msk->snd_una);
 
-		if (snd_una != msk->snd_nxt || tcp_write_queue_tail(ssk)) {
+		/* No need for zero probe if there are any data pending
+		 * either at the msk or ssk level; skb is the current write
+		 * queue tail and can be empty at this point.
+		 */
+		if (snd_una != msk->snd_nxt || skb->len ||
+		    skb != tcp_send_head(ssk)) {
 			tcp_remove_empty_skb(ssk);
 			return 0;
 		}

-- 
2.51.0



Return-Path: <stable+bounces-231799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDPrLi/7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB636D340
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D2F530A1B14
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400F426EA2;
	Tue, 31 Mar 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ihGKlJcQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580D425CFF;
	Tue, 31 Mar 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975099; cv=none; b=tnznALe+KH2wN0rbIdWzyPFfF5i+usvr99tcp0h5b0JDoznXKs8hLCXkg73D5d603d9M8AC+p5lQuWxt0XPe8O1BW5PIsMoA8EXX2wXu+TgYRXFk4YUIGWG65IsBRd56G8+aHXcEBmMUiDsXaM2xfA//iKCVttdrSJ+Fbbhhli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975099; c=relaxed/simple;
	bh=+JXU/DUJfqf/nzKdKTT9IyHPfGBnZiBfqk/VU9I9exE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eF0DqjkioY/hVMT4DUdyiA2OG3WhHjNqTBfpK6jAAne0pmpVLMENVgCC2i2w0tV/aa7zejkhRyGk5K15XWlspAssbtIFKEqp79q0OMiT+uSJ/rGzeb5ANixy0BVmFm5krAmKxE8iUkJXGEOp7/ePv1D53xs4LWJLS7R8VldR/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ihGKlJcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D66C19423;
	Tue, 31 Mar 2026 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975099;
	bh=+JXU/DUJfqf/nzKdKTT9IyHPfGBnZiBfqk/VU9I9exE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihGKlJcQF0Cr0/mzuxJJI/NNbGN6qw2BD4cww76iiHf5suguB1Ru9diUnQNgREe0R
	 jK5aDZa4UMEzkR8CFTeyOLi+7rqaXZnEld79JaS+chDwg1inOs52YTPgLFzj4sa8pF
	 oNFidJHAVBbasJYoXiBsxlxD2pBrK35rw6yPBrfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Chris Arges <carges@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 131/342] net_sched: codel: fix stale state for empty flows in fq_codel
Date: Tue, 31 Mar 2026 18:19:24 +0200
Message-ID: <20260331161803.827752150@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231799-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5CEB636D340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

[ Upstream commit 815980fe6dbb01ad4007e8b260a45617f598b76d ]

When codel_dequeue() finds an empty queue, it resets vars->dropping
but does not reset vars->first_above_time.  The reference CoDel
algorithm (Nichols & Jacobson, ACM Queue 2012) resets both:

  dodeque_result codel_queue_t::dodeque(time_t now) {
      ...
      if (r.p == NULL) {
          first_above_time = 0;   // <-- Linux omits this
      }
      ...
  }

Note that codel_should_drop() does reset first_above_time when called
with a NULL skb, but codel_dequeue() returns early before ever calling
codel_should_drop() in the empty-queue case.  The post-drop code paths
do reach codel_should_drop(NULL) and correctly reset the timer, so a
dropped packet breaks the cycle -- but the next delivered packet
re-arms first_above_time and the cycle repeats.

For sparse flows such as ICMP ping (one packet every 200ms-1s), the
first packet arms first_above_time, the flow goes empty, and the
second packet arrives after the interval has elapsed and gets dropped.
The pattern repeats, producing sustained loss on flows that are not
actually congested.

Test: veth pair, fq_codel, BQL disabled, 30000 iptables rules in the
consumer namespace (NAPI-64 cycle ~14ms, well above fq_codel's 5ms
target), ping at 5 pps under UDP flood:

  Before fix:  26% ping packet loss
  After fix:    0% ping packet loss

Fix by resetting first_above_time to zero in the empty-queue path
of codel_dequeue(), matching the reference algorithm.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Fixes: d068ca2ae2e6 ("codel: split into multiple files")
Co-developed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reported-by: Chris Arges <carges@cloudflare.com>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/all/20260318134826.1281205-7-hawk@kernel.org/
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260323174920.253526-1-hawk@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/codel_impl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index 78a27ac730700..b2c359c6dd1b8 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
-- 
2.51.0





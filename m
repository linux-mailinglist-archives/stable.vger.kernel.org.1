Return-Path: <stable+bounces-229091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB1gLhRswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CC2F86BC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79EC831211FF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B561A6822;
	Mon, 23 Mar 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ewGEOX/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DB17A305;
	Mon, 23 Mar 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278032; cv=none; b=uw86w/QE+3KBcPx8x8WzonICcXgsW0QEhrCQGwGqZaPvafWmTUkryzHXp78Q//iI8B3fZ4pcRpsi4VMSml2U6NAfzBW3SqSaTSpIOIw331OntIbFHcPeaTTGFQl4NW1IO3k7U0Vsa7q9EetlP7zqdyJd+bfugSwz9CUCekwZQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278032; c=relaxed/simple;
	bh=zY/+WYR71DO+6BbTVWJlBtNUG1JAZKr2+oWIS01AKAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nC2ym3sheVX5XiVhzpiL1AAJkdOvcLTi4mgHVt/Ktte+yp2lYCsaOD4e8tI93tAT+KDveDV7WZc/Yric+IYGde+jwSx5YvY+Ckde0Z9pRIa6jPI9ZwlhUaSQYPntW9hcV6dZHE+yLH9YCr2oqWhrauwvOogH8n+oNr3/YN2Kn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewGEOX/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0FEC4CEF7;
	Mon, 23 Mar 2026 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278032;
	bh=zY/+WYR71DO+6BbTVWJlBtNUG1JAZKr2+oWIS01AKAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ewGEOX/Hdve9W3ie9c8D0FAtkVSwfR/0RZ7HFUTVU9c6X0MkscZOXPbmK1joykbNE
	 cgcUtvJAmT28H2QAffKBbphNc+UZSaskhe14Kd+3EABzD5AH7cW1t8vak/vmyKuQyS
	 22coEJ6DP0bkPLpYby+6qtSMvBNCgs1wbvzsaSP8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/567] xdp: use modulo operation to calculate XDP frag tailroom
Date: Mon, 23 Mar 2026 14:41:38 +0100
Message-ID: <20260323134538.248185877@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229091-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 166CC2F86BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit 88b6b7f7b216108a09887b074395fa7b751880b1 ]

The current formula for calculating XDP tailroom in mbuf packets works only
if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
defeats the purpose of the parameter overall and without any indication
leads to negative calculated tailroom on at least half of frags, if shared
pages are used.

There are not many drivers that set rxq->frag_size. Among them:
* i40e and enetc always split page uniformly between frags, use shared
  pages
* ice uses page_pool frags via libeth, those are power-of-2 and uniformly
  distributed across page
* idpf has variable frag_size with XDP on, so current API is not applicable
* mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool

As for AF_XDP ZC, only ice, i40e and idpf declare frag_size for it. Modulo
operation yields good results for aligned chunks, they are all power-of-2,
between 2K and PAGE_SIZE. Formula without modulo fails when chunk_size is
2K. Buffers in unaligned mode are not distributed uniformly, so modulo
operation would not work.

To accommodate unaligned buffers, we could define frag_size as
data + tailroom, and hence do not subtract offset when calculating
tailroom, but this would necessitate more changes in the drivers.

Define rxq->frag_size as an even portion of a page that fully belongs to a
single frag. When calculating tailroom, locate the data start within such
portion by performing a modulo operation on page offset.

Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://patch.msgid.link/20260305111253.2317394-2-larysa.zaremba@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e5dc1f699297b..58109f6201b76 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4137,7 +4137,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
 		return -EOPNOTSUPP;
 
-	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
+	tailroom = rxq->frag_size - skb_frag_size(frag) -
+		   skb_frag_off(frag) % rxq->frag_size;
 	if (unlikely(offset > tailroom))
 		return -EINVAL;
 
-- 
2.51.0





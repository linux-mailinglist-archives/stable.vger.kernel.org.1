Return-Path: <stable+bounces-215448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IGuHgn5iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:11:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11D111ACD
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8ADA30A6E89
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E043793B0;
	Mon,  9 Feb 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tx485DBy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E228312F;
	Mon,  9 Feb 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648826; cv=none; b=OjyMFmJY5Qcg7sfGA885tHCMnxs91JAoPd8WyH3PgQDqdQfckxeEp3zsSn/0t2+YYm5/bOFSHPjDgHj+YEEARJn7VpmDfORi8fFxB6fk7PjrUcUJWONvFdcKSA23IWpgQ539D59jO4k74dbyh6pF9L3hdBRoEc6g7rGGWMJB6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648826; c=relaxed/simple;
	bh=O7IxVPvVrwyb0KuKybMeTdhkDNNp2xQ4SM6+pDcBarw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IH+USopjng2mhelQ/p3S3hAFFXMiGAaH8t2sqUrSlmfgAYCr9H5xdHmkAQs8x1MuEmJ8qT5jlJT5DTJpRCmyq0G+U6oIfjj+CnxSbn9PQ2D+YLYdziK2Fvm1KTJ6NOj1ZlX/y3nRoKXbwtopzrqqXDuwWur2BI3L3ne7sDesgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tx485DBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C6C116C6;
	Mon,  9 Feb 2026 14:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648826;
	bh=O7IxVPvVrwyb0KuKybMeTdhkDNNp2xQ4SM6+pDcBarw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx485DByy4C1UJKD91zdVnk3mq8EFW4NV3Ez1kExsXhH0jJFQ3C1oVTaaSxoBZxy+
	 JdPT+6WQD/EvPqDOA4p5B1YdgkLWwV++s14uBCP94luNqIBxbFwqP9Q/f44TLeXslK
	 vV7oA5XfbnkLj4bDisglS1uNZMbVOlbKt/nv+ZgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH 5.15 07/75] netfilter: nft_set_pipapo: clamp maximum map bucket size to INT_MAX
Date: Mon,  9 Feb 2026 15:24:04 +0100
Message-ID: <20260209142302.104585833@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215448-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: EB11D111ACD
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit b85e3367a5716ed3662a4fe266525190d2af76df upstream.

Otherwise, it is possible to hit WARN_ON_ONCE in __kvmalloc_node_noprof()
when resizing hashtable because __GFP_NOWARN is unset.

Similar to:

  b541ba7d1f5a ("netfilter: conntrack: clamp maximum hashtable size to INT_MAX")

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ Keerthana: Handle freeing new_lt ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_set_pipapo.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -667,6 +667,11 @@ static int pipapo_resize(struct nft_pipa
 	}
 
 mt:
+	if (rules > (INT_MAX / sizeof(*new_mt))) {
+		kvfree(new_lt);
+		return -ENOMEM;
+	}
+
 	new_mt = kvmalloc(rules * sizeof(*new_mt), GFP_KERNEL);
 	if (!new_mt) {
 		kvfree(new_lt);
@@ -1360,6 +1365,9 @@ static struct nft_pipapo_match *pipapo_c
 		       src->bsize * sizeof(*dst->lt) *
 		       src->groups * NFT_PIPAPO_BUCKETS(src->bb));
 
+		if (src->rules > (INT_MAX / sizeof(*src->mt)))
+			goto out_mt;
+
 		dst->mt = kvmalloc(src->rules * sizeof(*src->mt), GFP_KERNEL);
 		if (!dst->mt)
 			goto out_mt;




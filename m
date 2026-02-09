Return-Path: <stable+bounces-215204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHO9JvnziWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:49:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6B11108B
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8921330CA257
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938337C0F1;
	Mon,  9 Feb 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TUbIqfes"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF22222B2;
	Mon,  9 Feb 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648021; cv=none; b=IQhcqyGZdWlVY0aR++qkTUyRfe0A21VJ3tzvtxoG32WP0SFpQjvpxUcS0yVxp3MiysJhCW3Mm4pi9M0OihBYpyulNTuI2806HSQsl8u43EEMst3Vt6FDMTEHe6YJVr6Lic4pG9U3yGmElhHrF3rcCD7KX/T28yMdIZNs7HacSVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648021; c=relaxed/simple;
	bh=10c+rhVDfERDo3IOIiKnjGFCMruyrN9Ia4x8302a9NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PN0IThvzEVazbXR/S4ikBlqavPAHCAqFdKD+CEqbkhqXHpzXzSJVjmX4wikBJ+rEnEKEOKOuKMrf6qhMehp/rtfV4n8tU4SVXYPBiSgvzOfL/rauy16n7tqsb0hYbG7eD7BoafoJXbXsDDabb39IhyN8KVCWDqPbhqOsZeii/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TUbIqfes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D7AC116C6;
	Mon,  9 Feb 2026 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648021;
	bh=10c+rhVDfERDo3IOIiKnjGFCMruyrN9Ia4x8302a9NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUbIqfesGNC0hEIB8h9WoArufVuNHJs8GW0mCOX+HUsESiLfRilVtwzMi3Ta7xwu3
	 5piMqxezygiYpRMgLsGALRYcUior0fh/HNeVQIsEHwrs05KAGgpbgqtZwQp6A15fhK
	 tTt1TiuOySoWIlZI8nEo0oGO2WJmp3FKGOclUNPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 096/113] net: gro: fix outer network offset
Date: Mon,  9 Feb 2026 15:24:05 +0100
Message-ID: <20260209142313.629849469@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215204-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3DA6B11108B
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 5c2c3c38be396257a6a2e55bd601a12bb9781507 ]

The udp GRO complete stage assumes that all the packets inserted the RX
have the `encapsulation` flag zeroed. Such assumption is not true, as a
few H/W NICs can set such flag when H/W offloading the checksum for
an UDP encapsulated traffic, the tun driver can inject GSO packets with
UDP encapsulation and the problematic layout can also be created via
a veth based setup.

Due to the above, in the problematic scenarios, udp4_gro_complete() uses
the wrong network offset (inner instead of outer) to compute the outer
UDP header pseudo checksum, leading to csum validation errors later on
in packet processing.

Address the issue always clearing the encapsulation flag at GRO completion
time. Such flag will be set again as needed for encapsulated packets by
udp_gro_complete().

Fixes: 5ef31ea5d053 ("net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/562638dbebb3b15424220e26a180274b387e2a88.1770032084.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index 0ad549b07e039..40aaac4e04f34 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -265,6 +265,8 @@ static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 		goto out;
 	}
 
+	/* NICs can feed encapsulated packets into GRO */
+	skb->encapsulation = 0;
 	rcu_read_lock();
 	list_for_each_entry_rcu(ptype, head, list) {
 		if (ptype->type != type || !ptype->callbacks.gro_complete)
-- 
2.51.0





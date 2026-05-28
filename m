Return-Path: <stable+bounces-256039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK2YITeqGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:48:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFD5F999A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 738CD30B7A09
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660E345CAF;
	Thu, 28 May 2026 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGb3Uf/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A12339866;
	Thu, 28 May 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000583; cv=none; b=fu++fUDfnNq+E7pzmL1B87s8u8Tn347ndpQHKG1jOUVQs+VQ7ObWt4LDD7y1+FIIyykW+WULMqvYpdmetlvna4GEWugEO2jl9ZZtBYbTVaEjwxpvycrQO6OD/FX7J0K/nLfqvupKFjhtnWAKgdkZ7SMekOse6iIa3npfk/xVpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000583; c=relaxed/simple;
	bh=ZAzKe5IftU4JGfhH/l+vc8SM6kfN/hZNYDGDC9IKBL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOMg4mf+GIluvuyxWqZQ50q/iel4BespzXO/s6LDNvZyjn7ZmsaheqzN37iwtGFdVW4FqhkCBRXM2F6b7f3/Uu8DDYKfHO4JCLmKQvbA8ui/mhNgmWVPQWmdhsY20JItyzwy0iGnZgGHg0iHjuLTu9m63qg+4ZqQ92F4uZNhii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGb3Uf/6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1169F1F000E9;
	Thu, 28 May 2026 20:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000582;
	bh=EohF4MSGGjY6jaxao7xAkKdM1W3bNtLjX5pM9MJaQwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGb3Uf/6LZh5qEgDv7y2eHeOI3wWiWHtTsiqA/yiJ5o9hoVOif8kUqZiWY0p/vezb
	 EzJg/P59Gpopk6xfJ1+8u2DK2inPIJLGdcRwCFDz+JMpVa4EIVrXZ1GV28URfHUtyE
	 Daw9iQzPQZ/rcHE/VV8Cogp4uwqCo4jGN6PNa4JY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12 097/272] wifi: mac80211: consume only present negotiated TTLM maps
Date: Thu, 28 May 2026 21:47:51 +0200
Message-ID: <20260528194632.095433601@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-256039-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 8ECFD5F999A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit a6e6ccd5bd07155c2add6c74ce1a5e68ad3b95ea upstream.

ieee80211_tid_to_link_map_size_ok() validates negotiated TTLM elements
against the number of link-map entries indicated by link_map_presence.
ieee80211_parse_neg_ttlm() must consume the same layout.

The parser advanced its cursor for every TID, including TIDs whose
presence bit is clear and therefore have no map bytes in the element.
A sparse map can then make a later present TID read past the validated
element.

The bad bytes land in neg_ttlm->{up,down}link[tid] but are gated by
valid_links before being applied to driver state, so a peer cannot
turn the read into a policy change.  Under KUnit + KASAN with an
exact-sized element allocation the OOB read is reported as a
slab-out-of-bounds; whether the same trigger fires under the
production RX path depends on surrounding allocator state.

Advance the cursor only when the current TID has a map present.

Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260515151719.1317659-2-michael.bommarito@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mlme.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7290,6 +7290,7 @@ ieee80211_parse_neg_ttlm(struct ieee8021
 					 "No active links for TID %d", tid);
 				return -EINVAL;
 			}
+			pos += map_size;
 		} else {
 			map = 0;
 		}
@@ -7308,7 +7309,6 @@ ieee80211_parse_neg_ttlm(struct ieee8021
 		default:
 			return -EINVAL;
 		}
-		pos += map_size;
 	}
 	return 0;
 }




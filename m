Return-Path: <stable+bounces-255189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDD/N2GeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3985F78DA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 770E53075FC9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108C33F5B4;
	Thu, 28 May 2026 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLZEaPNI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B03340409;
	Thu, 28 May 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998212; cv=none; b=o4oCm5PMEeZtwnreblMCv+xublXNBeteDG4O9Ey4zj7Df9ciHgq4HAQUJR8tAn94vyS1Xyk092nwfj1ydao1RX761hxAnYReI8x4VB4rNhK0c8fAJk/3J+cUTDwv2vQMUb4oCz8wC91ytQW0Pg1NeRcCp6P9mvYY9qDtMrBfqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998212; c=relaxed/simple;
	bh=eL/XaZH4Bsnw621E/BbSvOAJTVD9EKpKf/7hTtdUwmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka22Y2oU2L3awNExqwMYCkonDX/J5EGr+QI/YXkxRW5wEqQFSP28kG8JG91+H/288TcLjaHxRLgBO8JpejfCWWHFwTuYP7LTTrHCnoMJ7wIb2sSl/0TU6TwG9EqwW0k/EzaQDyv7INo6Fwl11PScEvIRMOTFSaxKQFNaygDeEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLZEaPNI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7638B1F000E9;
	Thu, 28 May 2026 19:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998211;
	bh=dlPuiXr62WniOdF6e10fLwiJ0NQij8roTooivzi7nXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLZEaPNIDS98MX2N3LDSFZJkcyMdNfl957HGske5cETtbGWUJBcyG9RPKDHfiXmeJ
	 6T3DMJWFIxjMP5XW25eOhOZhzyEkcDgpghghcmCp0djX+BnyVrdLdnKMfKTBmuc3Ji
	 oRx0BPVjtvUm37CbN+JN5UGLYtrnkDKBBKfaiO9o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7.0 094/461] wifi: mac80211: consume only present negotiated TTLM maps
Date: Thu, 28 May 2026 21:43:43 +0200
Message-ID: <20260528194649.660302469@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-255189-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 5E3985F78DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8070,6 +8070,7 @@ ieee80211_parse_neg_ttlm(struct ieee8021
 					 "No active links for TID %d", tid);
 				return -EINVAL;
 			}
+			pos += map_size;
 		} else {
 			map = 0;
 		}
@@ -8088,7 +8089,6 @@ ieee80211_parse_neg_ttlm(struct ieee8021
 		default:
 			return -EINVAL;
 		}
-		pos += map_size;
 	}
 	return 0;
 }




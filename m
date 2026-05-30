Return-Path: <stable+bounces-257848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIngCK0gG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:38:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79439610189
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12399305B124
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F633F8B4;
	Sat, 30 May 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tTBGPjSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540030E853;
	Sat, 30 May 2026 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162374; cv=none; b=jVy/GUcJix1/qXbUhUflC3RsBEoZG6hK8GBbAJz2wKWNWfvVXcaTvxKWzqIEqIYltsYVCJ0pDFc4GQPvOlwH0mt9N/E8vsxzxzguLyUL9L60oYwspOQqovyz7z9VvKePgSqXzLX8DBGLnmaJGpq5VbzRn/i90luTKfwINsERQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162374; c=relaxed/simple;
	bh=OIPmE8c52v1bc8Chi8wKYnEjBfhZAS7Ux+EQxQTla3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYK/KEXlBg6uhsL1/pxeVSr9UcWUelcPNKMVLhUqYZ7R8AnL1focVmRuS1dH1Mh3xCF+A8k2Dw3hKOJ16jtKJfwqJTLbMk30deSXFsUJTnyLi9TWKNOpIaNQIUBNMbYGj1IlV0AF27+sGauxiUSQNIjSmdcuXlb6AGIdE2sfAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTBGPjSY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDD51F00893;
	Sat, 30 May 2026 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162373;
	bh=xw9FbziTZn4VSc4J3kCWWLXRLVccsAWFHyVCVCr9deU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tTBGPjSY7ohN6Sp0s4ZZFskksKaOGrEhlV1HuvS015kjG8f/u3oD/nBoH1qNKTrcD
	 ptNk9coVU8RTDX44/Zy92pGeGNhGagcJmdgLW5JICFURwSzbHbd+HwD2hugnypv407
	 cZY03WT0opLvbvVtIbQbKdexFaszj3k9dSYTd664=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Walker <johnwalker0@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 863/969] wifi: cfg80211: advance loop vars in cfg80211_merge_profile()
Date: Sat, 30 May 2026 18:06:27 +0200
Message-ID: <20260530160324.505197792@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257848-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 79439610189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Walker <johnwalker0@gmail.com>

commit 7666dbb1bacc4ba522b96740cba7283d243d16e1 upstream.

cfg80211_merge_profile() reassembles a Multi-BSSID non-transmitted BSS
profile that has been split across multiple consecutive MBSSID elements.
Its while-loop calls

	cfg80211_get_profile_continuation(ie, ielen, mbssid_elem, sub_elem)

but never advances mbssid_elem or sub_elem inside the body.  Each
iteration therefore searches for a continuation that follows the same
fixed pair; the helper returns the same next_mbssid; and the same
next_sub bytes are memcpy()'d into merged_ie at a growing offset until
the buffer fills.

Advance both mbssid_elem and sub_elem to the just-consumed continuation
so the next call to cfg80211_get_profile_continuation() searches for a
further continuation beyond it (or returns NULL when none exists).

A specially-crafted malicious beacon can take advantage of this bug
to cause the kernel to spend an excessive amount of time in
cfg80211_merge_profile (up to as much as 2ms per beacon received),
which could theoretically be abused in some way.

Cc: stable@vger.kernel.org
Fixes: fe806e4992c9 ("cfg80211: support profile split between elements")
Signed-off-by: John Walker <johnwalker0@gmail.com>
Link: https://patch.msgid.link/20260507230720.64783-1-johnwalker0@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/scan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2239,6 +2239,9 @@ size_t cfg80211_merge_profile(const u8 *
 		memcpy(merged_ie + copied_len, next_sub->data,
 		       next_sub->datalen);
 		copied_len += next_sub->datalen;
+
+		mbssid_elem = next_mbssid;
+		sub_elem = next_sub;
 	}
 
 	return copied_len;




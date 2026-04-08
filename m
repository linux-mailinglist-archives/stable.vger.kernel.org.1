Return-Path: <stable+bounces-233758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPzoE1nq1Wkd/QcAu9opvQ
	(envelope-from <stable+bounces-233758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:40:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E6D3B74C7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A94C3017272
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D787B35AC10;
	Wed,  8 Apr 2026 05:40:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741E3BB4A
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775626808; cv=none; b=MhljVRr9QUHFF1rI6b1k3jhnVIYGv88Qt8Hq+nxEuxnpz54bnlT2VvDDr2+UBF+Pe8iyUpZarQZqkhJeQTaJAPBDy6/YDVMADynLn5drkYQG6S+Z9X+Ak8EOJy7EgR2OhuynT+LKCtSn8UT9z75Q+mQ5YipbFOgZBwWbMymFjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775626808; c=relaxed/simple;
	bh=QFumA4meAgAZu3M8J5rhxumv2GXtbPmzh8sqXIro7AY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nhraIAyDtOD+BZ0SDgiORIAOv02K+3qPGMx7dkUqMGpSCgKGwBTfUpFYr9NHqP9+bHfdnPWPn7NM9Zk5tpRgQgnoh60nT9pIFBn1FuEHQdkDSsY/Ndk9fdJwDesCTnsr/5yIDIicJMOSJ3BNj/Yw+1DuuICjQQaYPnnyTstImfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.18:0.1362225724
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.144.79.172 (unknown [10.158.243.18])
	by mail.189.cn (HERMES) with SMTP id D2A4B400088;
	Wed,  8 Apr 2026 13:36:04 +0800 (CST)
Received: from  ([39.144.79.172])
	by gateway-153622-dep-76cc7bc9cd-8dbpn with ESMTP id 438444cddc8442a79bd2a4bce7b4382a for johannes.berg@intel.com;
	Wed, 08 Apr 2026 13:36:05 CST
X-Transaction-ID: 438444cddc8442a79bd2a4bce7b4382a
X-Real-From: charles_xu@189.cn
X-Receive-IP: 39.144.79.172
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: Charles Xu <charles_xu@189.cn>
To: johannes.berg@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] wifi: radiotap: reject radiotap with unknown bits
Date: Wed,  8 Apr 2026 13:36:02 +0800
Message-Id: <20260408053602.3205-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-233758-lists,stable=lfdr.de];
	DMARC_NA(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.392];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,189.cn:email,189.cn:mid,intel.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: B4E6D3B74C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

commit c854758abe0b8d86f9c43dc060ff56a0ee5b31e0 upstream.

The radiotap parser is currently only used with the radiotap
namespace (not with vendor namespaces), but if the undefined
field 18 is used, the alignment/size is unknown as well. In
this case, iterator->_next_ns_data isn't initialized (it's
only set for skipping vendor namespaces), and syzbot points
out that we later compare against this uninitialized value.

Fix this by moving the rejection of unknown radiotap fields
down to after the in-namespace lookup, so it will really use
iterator->_next_ns_data only for vendor namespaces, even in
case undefined fields are present.

Cc: stable@vger.kernel.org
Fixes: 33e5a2f776e3 ("wireless: update radiotap parser")
Reported-by: syzbot+b09c1af8764c0097bb19@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/69944a91.a70a0220.2c38d7.00fc.GAE@google.com
Link: https://patch.msgid.link/20260217120526.162647-2-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 net/wireless/radiotap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index ae2e1a896461..9ac97d59f888 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -239,14 +239,14 @@ int ieee80211_radiotap_iterator_next(
 		default:
 			if (!iterator->current_namespace ||
 			    iterator->_arg_index >= iterator->current_namespace->n_bits) {
-				if (iterator->current_namespace == &radiotap_ns)
-					return -ENOENT;
 				align = 0;
 			} else {
 				align = iterator->current_namespace->align_size[iterator->_arg_index].align;
 				size = iterator->current_namespace->align_size[iterator->_arg_index].size;
 			}
 			if (!align) {
+				if (iterator->current_namespace == &radiotap_ns)
+					return -ENOENT;
 				/* skip all subsequent data */
 				iterator->_arg = iterator->_next_ns_data;
 				/* give up on this namespace */
-- 
2.35.3



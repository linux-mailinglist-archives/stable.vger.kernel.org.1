Return-Path: <stable+bounces-219785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LusLY8aoGmzfgQAu9opvQ
	(envelope-from <stable+bounces-219785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:03:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674661A3EA7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EEF308ED71
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F239C63B;
	Thu, 26 Feb 2026 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="fn3PoxEr"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BA22157B
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099958; cv=none; b=kg/DsLvVZnjZff3zL9ltRlNuoiAoj6guQ5s4cpN++FU++kx/JXQVF7RZUJ82ln5fQEad997ReaOSPK58GU/PUHBIvUIOdDgty5daGATVci+vFUGfUX61ssr50gxnbaRWExNPsrHbLRmcDvGktLhOK10wBJLKfFa2tPAACRG3Pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099958; c=relaxed/simple;
	bh=YqWLVZbCwAgZruDRx59dg9BQ43hNBO/FpjP3ODRxLco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NLsK4HgDmz2iOPssKQbQyDLIxSZLUfwCbtpkD6VSG/iNlo77g1YdjPA/jeQQL9qMEqY1yeiWOI3uYWpkWF2cc38f+kn/ZZCjqTwU/zGSMSsFo+sNidW8/tGgQABu2WEGnDAs6iAPdogpnmUyDupBbjSgklqoQXjs273wUq/1NiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=fn3PoxEr; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fn3PoxErcch6AN61AGuQF2j4HWL5tqYLUPkZzj9nPp+v0lunoUJsQWW8Slsc0tEf1pGntjbpv/5/K
	 spaC5uoxh5hVnVTDNu2ugSJNMOIGVXddINFF8jUNuV2wjJACdRMbV3bI09wtlPbsChIy9OzZoh7zqD
	 9QTsJNE5efA5pQdo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from ubuntu24.corp.ad.wrs.com (unknown[120.244.194.215])
	by rmsmtp-lg-appmail-02-12080 (RichMail) with SMTP id 2f3069a018b05f8-0fe6f;
	Thu, 26 Feb 2026 17:56:01 +0800 (CST)
X-RM-TRANSID:2f3069a018b05f8-0fe6f
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.1.y 1/2] net: add skb_header_pointer_careful() helper
Date: Thu, 26 Feb 2026 17:55:50 +0800
Message-ID: <20260226095551.4183-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219785-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,139.com];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[139.com:mid,139.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 674661A3EA7
X-Rspamd-Action: no action

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 13e00fdc9236bd4d0bff4109d2983171fbcb74c4 ]

This variant of skb_header_pointer() should be used in contexts
where @offset argument is user-controlled and could be negative.

Negative offsets are supported, as long as the zone starts
between skb->head and skb->data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260128141539.3404400-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9a04a188b9f8..d07517a29cc1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4081,6 +4081,18 @@ skb_header_pointer(const struct sk_buff *skb, int offset, int len, void *buffer)
 				    skb_headlen(skb), buffer);
 }
 
+/* Variant of skb_header_pointer() where @offset is user-controlled
+ * and potentially negative.
+ */
+static inline void * __must_check
+skb_header_pointer_careful(const struct sk_buff *skb, int offset,
+			   int len, void *buffer)
+{
+	if (unlikely(offset < 0 && -offset > skb_headroom(skb)))
+		return NULL;
+	return skb_header_pointer(skb, offset, len, buffer);
+}
+
 /**
  *	skb_needs_linearize - check if we need to linearize a given skb
  *			      depending on the given device features.
-- 
2.43.0




Return-Path: <stable+bounces-274950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9MUgGvqfV2qGYgAAu9opvQ
	(envelope-from <stable+bounces-274950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:58:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45075FAE8
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 16:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HSpUc4HJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274950-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274950-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47387353A946
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1EC3859C3;
	Wed, 15 Jul 2026 14:38:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81323921C0
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126330; cv=none; b=JttTRIROqvQ2d8or+h6hft9vXSDpyTffE0sfUjmIfatZMhuBUiQxfapSd54dQWeU6+HiEbg22SxRfW9vgVOPk7UMYP9t0W045vtfCgsh+pVyPtx01rfCUamWWzwFlHVBEcBAdFKgieqz6O65QCbxa6EHkT9fDi0OBmBmmf0Fsds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126330; c=relaxed/simple;
	bh=yTp9MmimMCkUqb/kKgakfAIf/c0uds1uUezrS8tx74k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L5mi1utQD4xLtbaahRhU6hd18XydWjM3IlMQCmSlfX0wC+qezxjtwN2i4Oq3ZmpKzgl4YdWDHqD3l1/85wRUvOQ9MPWf0f6Wo+xz2DFXvToHLaSe5RazI0BerExr8qRuaBckkgHdfVylAOKCawUtFNraV/nYNfIQaTRdCQ1Lh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSpUc4HJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844F21F00A3A;
	Wed, 15 Jul 2026 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126321;
	bh=90oFv4uASxy8qmmcUQ2rzxRoUKaH/RrxEZUbdSFS2WY=;
	h=Subject:To:Cc:From:Date;
	b=HSpUc4HJpOmSPTd8u895icpyWZ2kqW6VAT8HglfDXzpujSWi1eTBO/MyiliD4+J3P
	 yY8eEbaVl8SMiFudpqnHViXzv3QG/EaR+zBFwskYaBfe0fomJOQY7faHTkvNRDdHt1
	 kbqcDaIvhax/Oea7L07kGxZshwy4DkOJdU4GEGaM=
Subject: FAILED: patch "[PATCH] audit: fix potential integer overflow in audit_log_n_hex()" failed to apply to 6.1-stable tree
To: rrobaina@redhat.com,paul@paul-moore.com,rgb@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:38:26 +0200
Message-ID: <2026071526-proposal-crusher-04da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274950-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rrobaina@redhat.com,m:paul@paul-moore.com,m:rgb@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B45075FAE8
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071526-proposal-crusher-04da@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0 Mon Sep 17 00:00:00 2001
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 2 Jul 2026 11:04:11 -0300
Subject: [PATCH] audit: fix potential integer overflow in audit_log_n_hex()

The function calculates new_len as len << 1 for hex encoding. This
has two overflow risks: the shift itself can overflow when len is
large, and the result can be truncated when assigned to new_len
(declared as int) from the size_t calculation.

Fix by using check_shl_overflow() to catch shift overflow and
changing new_len and loop counter i to size_t to prevent truncation.

Cc: stable@vger.kernel.org
Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
[PM: remove vertical whitspace noise]
Signed-off-by: Paul Moore <paul@paul-moore.com>

diff --git a/kernel/audit.c b/kernel/audit.c
index feaa4e2271d7..562476937fa7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -62,6 +62,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <linux/sctp.h>
+#include <linux/overflow.h>
 
 #include "audit.h"
 
@@ -2080,7 +2081,8 @@ void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
 void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 		size_t len)
 {
-	int i, avail, new_len;
+	int avail;
+	size_t i, new_len;
 	unsigned char *ptr;
 	struct sk_buff *skb;
 
@@ -2090,7 +2092,12 @@ void audit_log_n_hex(struct audit_buffer *ab, const unsigned char *buf,
 	BUG_ON(!ab->skb);
 	skb = ab->skb;
 	avail = skb_tailroom(skb);
-	new_len = len<<1;
+
+	if (check_shl_overflow(len, 1, &new_len)) {
+		audit_log_format(ab, "?");
+		return;
+	}
+
 	if (new_len >= avail) {
 		/* Round the buffer request up to the next multiple */
 		new_len = AUDIT_BUFSIZ*(((new_len-avail)/AUDIT_BUFSIZ) + 1);



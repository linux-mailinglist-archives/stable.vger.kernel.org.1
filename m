Return-Path: <stable+bounces-253706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHGYNT8IEGotSwYAu9opvQ
	(envelope-from <stable+bounces-253706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:39:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E09755B015F
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D491F3004CA6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAB314B73;
	Fri, 22 May 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qeX1+hBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A61E49F
	for <stable@vger.kernel.org>; Fri, 22 May 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435577; cv=none; b=qFkWA8ziOKnVnfhcTxZ0g6yRcC+DuuFCIeKOYSVa1PkP0kTBaaEIdfh/25p0ClflcB7FgoOkoNCOxI+ReP1T4AE1I5qEncHgRzZ2+7tBlLe4lAe7PSezel9eADAYpT/dozgIO29XhZD8diolYMstmiFsbARqDWWGMLHRUFSB+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435577; c=relaxed/simple;
	bh=gnxgukPHXG8ENmGGSH2upB5OIC6JiIX5z4R8wlTKh8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LlEZti0E+yYCMHZIFfN3z1unpOOEaWop4hZ/nwrPKVB2u/MKtjIKLWpR2UTub8aEQOukEwRij5694E+/d543VN1/RPVkhrF6dsQpv6wYJf+K/7Wvmc/ssxmKpHjWRwRnwe4dXc7MXtNi15oJlXNxgMKxp5jjjDZnXBgSm4Wrywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qeX1+hBY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38D31F000E9;
	Fri, 22 May 2026 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779435575;
	bh=tiruPKDzl2PP5A8BX1Eln59aeZqFA4lBkTAGHMLjKSc=;
	h=Subject:To:Cc:From:Date;
	b=qeX1+hBYlrUCow+rxSn91OUALUMUCV963yoJ6nfA4xEDkV1dA4ssVlXGMKJ+YprKZ
	 8HLWdnbF6W5QfY7UvLHcTS+rAwCnrQ/ZBWILho9Znyq8cG4itgO7RpVBSw1jOizLna
	 7upOaRlMuM7EQ1QoGoO8McP8SCMdYfE71/oZyL8s=
Subject: FAILED: patch "[PATCH] net: skbuff: propagate shared-frag marker through" failed to apply to 5.15-stable tree
To: imv4bel@gmail.com,aaron1esau@gmail.com,ben@decadent.org.uk,malin89@huawei.com,pabeni@redhat.com,rajat.gupta@oss.qualcomm.com,sd@queasysnail.net,sultan@kerneltoast.com,tanjingguo@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 May 2026 09:39:30 +0200
Message-ID: <2026052230-kilogram-proving-cd58@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,huawei.com:email,queasysnail.net:email]
X-Rspamd-Queue-Id: E09755B015F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 48f6a5356a33dd78e7144ae1faef95ffc990aae0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052230-kilogram-proving-cd58@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48f6a5356a33dd78e7144ae1faef95ffc990aae0 Mon Sep 17 00:00:00 2001
From: Hyunwoo Kim <imv4bel@gmail.com>
Date: Sat, 16 May 2026 07:28:53 +0900
Subject: [PATCH] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers

Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
moving frags from source to destination.  __pskb_copy_fclone() defers
the rest of the shinfo metadata to skb_copy_header() after copying
frag descriptors, but that helper only carries over gso_{size,segs,
type} and never touches skb_shinfo()->flags; skb_shift() moves frag
descriptors directly and leaves flags untouched.  As a result, the
destination skb keeps a reference to the same externally-owned or
page-cache-backed pages while reporting skb_has_shared_frag() as
false.

The mismatch is harmful in any in-place writer that uses
skb_has_shared_frag() to decide whether shared pages must be detoured
through skb_cow_data().  ESP input is one such writer (esp4.c,
esp6.c), and a single nft 'dup to <local>' rule -- or any other
nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
skb in esp_input() with the marker stripped, letting an unprivileged
user write into the page cache of a root-owned read-only file via
authencesn-ESN stray writes.

Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
were actually moved from the source.  skb_copy() and skb_copy_expand()
share skb_copy_header() too but linearize all paged data into freshly
allocated head storage and emerge with nr_frags == 0, so
skb_has_shared_frag() returns false on its own; they need no change.

The same omission exists in skb_gro_receive() and skb_gro_receive_list().
The former moves the incoming skb's frag descriptors into the
accumulator's last sub-skb via two paths (a direct frag-move loop and
the head_frag + memcpy path); the latter chains the incoming skb whole
onto p's frag_list.  Downstream skb_segment() reads only
skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
shinfo as the nskb -- both p and lp must carry the marker.

The same omission also exists in tcp_clone_payload(), which builds an
MTU probe skb by moving frag descriptors from skbs on sk_write_queue
into a freshly allocated nskb.  The helper falls into the same family
and warrants the same fix for consistency; no TCP TX-side in-place
writer is currently known to reach a user page through this gap, but
a future consumer depending on the marker would regress silently.

The same omission exists in skb_segment(): the per-iteration flag
merge takes only head_skb's flag, and the inner switch that rebinds
frag_skb to list_skb on head_skb-frags exhaustion does not fold the
new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
so segments drawing frags from frag_list members carry the marker.

Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
Suggested-by: Ben Hutchings <ben@decadent.org.uk>
Suggested-by: Lin Ma <malin89@huawei.com>
Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
Suggested-by: Aaron Esau <aaron1esau@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Link: https://patch.msgid.link/ageeJfJHwgzmKXbh@v4bel
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/gro.c b/net/core/gro.c
index 31d21de5b15a..9f8960789b2c 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -213,10 +213,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	p->data_len += len;
 	p->truesize += delta_truesize;
 	p->len += len;
+	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	if (lp != p) {
 		lp->data_len += len;
 		lp->truesize += delta_truesize;
 		lp->len += len;
+		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
 	}
 	NAPI_GRO_CB(skb)->same_flow = 1;
 	return 0;
@@ -244,6 +246,8 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
+	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	NAPI_GRO_CB(skb)->same_flow = 1;
 
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c4e8d331d6d..44ac121cfccb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2248,6 +2248,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 			skb_frag_ref(skb, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
+		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 	}
 
 	if (skb_has_frag_list(skb)) {
@@ -4349,6 +4350,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	tgt->ip_summed = CHECKSUM_PARTIAL;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
+	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
 	skb_len_add(skb, -shiftlen);
 	skb_len_add(tgt, shiftlen);
 
@@ -4959,7 +4962,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
+		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
+					    skb_shinfo(frag_skb)->flags) &
 					   SKBFL_SHARED_FRAG;
 
 		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
@@ -4976,6 +4980,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
 				frag_skb = list_skb;
+
+				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
+
 				if (!skb_headlen(list_skb)) {
 					BUG_ON(!nfrags);
 				} else {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f9d8755705f7..6e4bb411dc04 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2626,6 +2626,7 @@ static int tcp_clone_payload(struct sock *sk, struct sk_buff *to,
 			todo = min_t(int, skb_frag_size(fragfrom),
 				     probe_size - len);
 			len += todo;
+			skb_shinfo(to)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
 			if (lastfrag &&
 			    skb_frag_page(fragfrom) == skb_frag_page(lastfrag) &&
 			    skb_frag_off(fragfrom) == skb_frag_off(lastfrag) +



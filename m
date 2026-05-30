Return-Path: <stable+bounces-258570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOlsORUpG2rg/ggAu9opvQ
	(envelope-from <stable+bounces-258570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE0611528
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D92A430221CE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ECD39A7FE;
	Sat, 30 May 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="suocSwsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC557175A6B;
	Sat, 30 May 2026 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164791; cv=none; b=CLF89jGNWS8lzUH0dGFevYZgk+fuylbLhKCJOGmCJRZA09vbNeis+7VInDEp7wob3sLb5/cIBgVdIl9/udN6O8ZYy4tq0ZRwSgNTN3MGR+fJqEUQMT8JWDpxfuPIlzPYuuJFTlALJeCrB+gHcd3f9pBq+0Kiph+uiYNoKUm4Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164791; c=relaxed/simple;
	bh=paRji6FskpEjMB4jmlof0YX5vXJzb18SmOh6aPSATFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTrRSY3NYZ2FeyoovwgIQafl6O9+9bpXrlr0uqLRpFneroBe+gUXxnwYT9MWNgGf5TdN4FiOsdninp8AIlvofm/dCWPQHVfZGGBw2diVHpKPClKl4hrvF6qGN/aWFo0EqVFtBxgPgo+lk8wdXWoym08fCUkyYoTwhRvIY1m88WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=suocSwsi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC41F00893;
	Sat, 30 May 2026 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164790;
	bh=SvcftRJGzM64RmFgo2bSXElIwota63FGQh569Qbmtxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=suocSwsiZxoZOag0cWlu5nPCvgBgnqwRKDscrgzsDAASwZnEHlkhj7y8z84BZNT4C
	 mZVVnYUk/KdxxFylut/V7mKqkkH5Y7OxqlAns/a2lQdhTALoMIFduVcIsyCrIjhhhl
	 yObGI4xmMP8J5r28ZdyN3QWeAye/D6oqtg38D0Cw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15 661/776] libceph: Fix potential out-of-bounds access in crush_decode()
Date: Sat, 30 May 2026 18:06:15 +0200
Message-ID: <20260530160256.980722100@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258570-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tu-ilmenau.de,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-ilmenau.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ABAE0611528
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit 4c79fc2d598694bda845b46229c9d48b65042970 upstream.

A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
one bucket has two fields holding the bucket algorithm. If the values
in these two fields differ, an out-of-bounds access can occur. This is
the case because the first algorithm field (alg) is used to allocate
the correct amount of memory for a bucket of this type, while the second
algorithm field inside the bucket (b->alg) is used in the subsequent
processing.

This patch fixes the issue by adding a check that compares alg and
b->alg and aborts the processing in case they differ. Furthermore,
b->alg is set to 0 in this case, because the destruction of the crush
map also uses this field to determine the bucket type, which can again
result in an out-of-bounds access when trying to free the memory pointed
to by the fields of the bucket. To correctly free the memory allocated
for the bucket in such a case, the corresponding call to kfree is moved
from the algorithm-specific crush_destroy_bucket functions to the
generic crush_destroy_bucket().

Cc: stable@vger.kernel.org
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/crush/crush.c |    6 +-----
 net/ceph/osdmap.c      |    4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -47,7 +47,6 @@ int crush_get_bucket_item_weight(const s
 void crush_destroy_bucket_uniform(struct crush_bucket_uniform *b)
 {
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_list(struct crush_bucket_list *b)
@@ -55,14 +54,12 @@ void crush_destroy_bucket_list(struct cr
 	kfree(b->item_weights);
 	kfree(b->sum_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_tree(struct crush_bucket_tree *b)
 {
 	kfree(b->h.items);
 	kfree(b->node_weights);
-	kfree(b);
 }
 
 void crush_destroy_bucket_straw(struct crush_bucket_straw *b)
@@ -70,14 +67,12 @@ void crush_destroy_bucket_straw(struct c
 	kfree(b->straws);
 	kfree(b->item_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_straw2(struct crush_bucket_straw2 *b)
 {
 	kfree(b->item_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket(struct crush_bucket *b)
@@ -99,6 +94,7 @@ void crush_destroy_bucket(struct crush_b
 		crush_destroy_bucket_straw2((struct crush_bucket_straw2 *)b);
 		break;
 	}
+	kfree(b);
 }
 
 /**
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -502,6 +502,10 @@ static struct crush_map *crush_decode(vo
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
 		b->alg = ceph_decode_8(p);
+		if (b->alg != alg) {
+			b->alg = 0;
+			goto bad;
+		}
 		b->hash = ceph_decode_8(p);
 		b->weight = ceph_decode_32(p);
 		b->size = ceph_decode_32(p);




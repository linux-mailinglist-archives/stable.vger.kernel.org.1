Return-Path: <stable+bounces-252813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGTeBgP/DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBA1596B5B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE27F305B8DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50B3D1CC6;
	Wed, 20 May 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/15VIZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BC3CCFB0;
	Wed, 20 May 2026 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301656; cv=none; b=l7+R7QbgzJZc+FPJNYcFlESGA0+P5LekBcFCBewnaB46S/5s16ZO4NT6dXO2g4j04kdWx29nuyV2ZWvy3FF4AmPdiAm4iCdytPoXlF4EJjguebGFt0jcZ9oZrsuxNRdN9C6uPZTih/keMf21bNBBvwM3OFBXQbN+M1qHiMEQbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301656; c=relaxed/simple;
	bh=TScwjoSuYt0nRQ+yCAM79Fs2B66cJohZMjFcHR6yfUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQ83PMF100AWkKxkx9ejdx/lNYySL3KnZBAyeIT1RPjpZxRRPshrrEiDw4SF/lf0b9n3Ska512rZsPmISZ+XSKj+83kQJ4sDJCu5bTKCjV4t2VTGLoYL7VD97E6cNjwjM4RkXm4Vx0Aa5YHCuGFHVZlG4udry46vgrz9lEuej7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/15VIZz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476291F000E9;
	Wed, 20 May 2026 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301654;
	bh=9mI5m3KlpSSYyjE5dElR8Sfx6c3tRMRaD13iwFLyzeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V/15VIZzpaxWxBvGnpvkOvATTLBp2V/O9sADcGJ/mXLLe7p5wYJSJWxkzDmsHNIYy
	 u+NdsBRLxBk508LF0taKSs9wFM+3IwIHX7V5/VzI/4kNRRrVMVHg/SH84pBuy7JZJK
	 +Htsa9JoQutWvn+hXfOFdHHWJ21BLtnCC3zbkQIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.12 637/666] libceph: Fix potential null-ptr-deref in decode_choose_args()
Date: Wed, 20 May 2026 18:24:08 +0200
Message-ID: <20260520162125.082892187@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252813-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tu-ilmenau.de,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tu-ilmenau.de:email]
X-Rspamd-Queue-Id: DDBA1596B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

commit 28b0a2ab8c82d0bbdeb8013029c67c978ce6e4bf upstream.

A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
contains a CRUSH map. When decoding this CRUSH map in crush_decode(), an
array of max_buckets CRUSH buckets is decoded, where some indices may
not refer to actual buckets and are therefore set to NULL. The received
CRUSH map may optionally contain choose_args that get decoded in
decode_choose_args(). When decoding a crush_choose_arg_map, a series of
choose_args for different buckets is decoded, with the bucket_index
being read from the incoming message. It is only checked that the bucket
index does not exceed max_buckets, but not that it doesn't point to an
index with a NULL bucket. If a (potentially corrupted) message contains
a crush_choose_arg_map including such a bucket_index, a null pointer
dereference may occur in the subsequent processing when attempting to
access the bucket with the given index.

This patch fixes the issue by extending the affected check. Now, it is
only attempted to access the bucket if it is not NULL.

Cc: stable@vger.kernel.org
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/osdmap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -390,7 +390,8 @@ static int decode_choose_args(void **p,
 				goto fail;
 
 			if (arg->ids_size &&
-			    arg->ids_size != c->buckets[bucket_index]->size)
+			    (!c->buckets[bucket_index] ||
+			     arg->ids_size != c->buckets[bucket_index]->size))
 				goto e_inval;
 		}
 




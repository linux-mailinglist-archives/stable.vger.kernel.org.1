Return-Path: <stable+bounces-213413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIf+K4xbg2mYlwMAu9opvQ
	(envelope-from <stable+bounces-213413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2FE7505
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EC33031308
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254041B343;
	Wed,  4 Feb 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZQLQ87b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4571A280A3B;
	Wed,  4 Feb 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216254; cv=none; b=svkjXmlGjYiN3K9ogDf0M7GyWW1miniLhy51n5pNUUibT608jeJWe9TS3eKk6xVCQ0MHmSYSuBBqJROxwCjQqPC55WjcUOcMTI4GtenynZQHW9plQZsvBdqKjJCHJU4INQe64FbhPWcORwrQ2n891bvqo++e9MuvGIbU6JKCzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216254; c=relaxed/simple;
	bh=SMAbFt/O4nUk6C6HqvHF96AkyxWWCVdfbBW+cSrH+dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJbFkmrLYBzvMdEmONr5xjBae/dAefSRoyFBwNKmvIIduHGiFJ7jralO1SuMVIy0uOThhFJ+tTQwzTPx2ksu/M7DwO31QD6wDEYUpaIJ88E6hO+2f7FHFGyzfbsOXNFyRVDRqrq0NyYBk42up0v+J7VjhUYeHk5f8TDE+iequ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZQLQ87b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E04C4CEF7;
	Wed,  4 Feb 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216253;
	bh=SMAbFt/O4nUk6C6HqvHF96AkyxWWCVdfbBW+cSrH+dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZQLQ87bx+tKzJvdP510PBNSyIigq2Tc68GPD1kxOGvSPekZ/z9VxDZ6UCfbgrRhS
	 TklLkSxa0P0ITXELKCvcZGNWr2I/X4mcWC37PhQ5tygFzdbXf7so1J4o2wDH6A0VcW
	 q6RT510m1QNULRU7nBzeobiVoYc6vrs64xL64eM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Airlie <airlied@redhat.com>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 5.10 034/161] drm/nouveau/disp/nv50-: Set lock_core in curs507a_prepare
Date: Wed,  4 Feb 2026 15:38:17 +0100
Message-ID: <20260204143852.988539132@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213413-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 12C2FE7505
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 9e9bc6be0fa0b6b6b73f4f831f3b77716d0a8d9e upstream.

For a while, I've been seeing a strange issue where some (usually not all)
of the display DMA channels will suddenly hang, particularly when there is
a visible cursor on the screen that is being frequently updated, and
especially when said cursor happens to go between two screens. While this
brings back lovely memories of fixing Intel Skylake bugs, I would quite
like to fix it :).

It turns out the problem that's happening here is that we're managing to
reach nv50_head_flush_set() in our atomic commit path without actually
holding nv50_disp->mutex. This means that cursor updates happening in
parallel (along with any other atomic updates that need to use the core
channel) will race with eachother, which eventually causes us to corrupt
the pushbuffer - leading to a plethora of various GSP errors, usually:

  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 00000218 00102680 00000004 00800003
  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 0000021c 00040509 00000004 00000001
  nouveau 0000:c1:00.0: gsp: Xid:56 CMDre 00000000 00000000 00000000 00000001 00000001

The reason this is happening is because generally we check whether we need
to set nv50_atom->lock_core at the end of nv50_head_atomic_check().
However, curs507a_prepare is called from the fb_prepare callback, which
happens after the atomic check phase. As a result, this can lead to commits
that both touch the core channel but also don't grab nv50_disp->mutex.

So, fix this by making sure that we set nv50_atom->lock_core in
cus507a_prepare().

Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 1590700d94ac ("drm/nouveau/kms/nv50-: split each resource type into their own source files")
Cc: <stable@vger.kernel.org> # v4.18+
Link: https://patch.msgid.link/20251219215344.170852-2-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/curs507a.c
@@ -84,6 +84,7 @@ curs507a_prepare(struct nv50_wndw *wndw,
 		asyh->curs.handle = handle;
 		asyh->curs.offset = offset;
 		asyh->set.curs = asyh->curs.visible;
+		nv50_atom(asyh->state.state)->lock_core = true;
 	}
 }
 




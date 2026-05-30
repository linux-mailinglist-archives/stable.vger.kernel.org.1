Return-Path: <stable+bounces-259222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHC1DyMzG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:57:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B85612DAE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE0F43035D4A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF68231A21;
	Sat, 30 May 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ICJQ+tVZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B44137750;
	Sat, 30 May 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167018; cv=none; b=OMRDKXkzjO8vKDL9kUTgVLPPdeufjSoz1UUnX21gW3/A0NO/wVFNiweM1oxwQyqwgWvMxxXFBk65enYFeTed8NyDbCPgzHKP3bZJlDfSgWiK5wHGXwgGCZcoc+216X5jPxeDe4tv9ihr6wnbP+AY+ASQXMGeYkLijzGA+oF6RYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167018; c=relaxed/simple;
	bh=SKTGVG1R44ZdIx/AxO5yWA743zY1ZESykpesX4bmi0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJmpd0jEtGaN8FZo0tf7iXRBkCtiOd0IUi24AOM2rK6HVPnwGY/aHtqLX7G5e7PT5Mvks8pQgtDFfpZ9jzVd1alQ4MTVTQKbL3RiisGFDiyz94u9NpdDTEFiu/AZbASNtLAUgyHQxJ16WR9M8zoZ42GvFvYVeKpEZByFafICqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ICJQ+tVZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5BC1F00893;
	Sat, 30 May 2026 18:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167017;
	bh=m8rJHqGpp0gcVajv0OpQLW9W4v4nkyxPgEJSZ38k43Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ICJQ+tVZ8g/VcBCO7/wJHZF2a8mH5L3flfjMujbrYC5ysHO3hAEaf6g28i19Q4voG
	 bvtSPlKarKlsr7lJaJOWZU/I0VRNl14DUbikU3gB0n1rlC9/EgdkJJt0YSPGOukaPt
	 CsuLBRBDbJCqWAzoYXCkDJYKQa9FanwXeBEP5RYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.10 510/589] ceph: fix a buffer leak in __ceph_setxattr()
Date: Sat, 30 May 2026 18:06:31 +0200
Message-ID: <20260530160238.008128786@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-259222-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ibm.com,redhat.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9B85612DAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

commit 5d3cc36b4e77a27ce7b686b7c59c7072bcb3fa8e upstream.

The old_blob in __ceph_setxattr() can store
ci->i_xattrs.prealloc_blob value during the retry.
However, it is never called the ceph_buffer_put()
for the old_blob object. This patch fixes the issue of
the buffer leak.

Cc: stable@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/xattr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1132,6 +1132,7 @@ retry:
 
 do_sync:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_buffer_put(old_blob);
 do_sync_unlocked:
 	if (lock_snap_rwsem)
 		up_read(&mdsc->snap_rwsem);




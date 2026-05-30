Return-Path: <stable+bounces-258586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBAKFUUpG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B96115C4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C963042F1C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A42F90E0;
	Sat, 30 May 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3eK+Xs4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98869175A6B;
	Sat, 30 May 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164846; cv=none; b=BkSFrIS0tyVwbX384H4VmaMYwONxXKPCNV9dW4upmRp5F5dDuuXb5VWTQJ5+WNxM4C8+Dy46NMIxDlQp2lYnjFVBOxnvuODgqsjCHYjwQnyFgfKgJNrzqvMGC1X1XP/r8xqzLcOBMmOh/J3exo97INUTxsgKWDCXqzXruj9kwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164846; c=relaxed/simple;
	bh=/VuWmQVSa+rRzry/JXyTZYx1iQgFlG80nI3riE1C7I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRYh7JteNuhhxmoLRpMhBB/r2gnLIl9Sryk4i0zq0rXl5JZMVzfnfCwJ/gfSAIfg27DwzCcwDKvinA2E7m/nLtq74ypCTjqIoUHN7XpD8oH8dxy6vVjXg8v0McvYI2yWot+t/PJbkmpATKv1F107lATHAjFJkYKFYZUSjS1jEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3eK+Xs4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CF51F00893;
	Sat, 30 May 2026 18:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164845;
	bh=Y+RKYpxdt/PCFdRIaCW4jnnCvjHIUHY+8IO6s+Ak96A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3eK+Xs4ialPqFzoPscKg5lYkN0diTdE3E7FUiHCNVKi1LNwnbIRqQmAJ64wl+Bn1
	 RGnd/A4ik18dsvfTKQcVrVU8jSHlsq73WFU1L3BVbTNEcTf6Q4BOnaHjeHiPPC/mNq
	 neI63h2bFwhbQOncwZbf9TkjzhpjETBtA5yUmlLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Steve French <stfrench@microsoft.com>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 5.15 676/776] smb: client: reject userspace cifs.spnego descriptions
Date: Sat, 30 May 2026 18:06:30 +0200
Message-ID: <20260530160257.336649076@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258586-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pm.me:email]
X-Rspamd-Queue-Id: ED0B96115C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asim Viladi Oglu Manizada <manizada@pm.me>

commit 3da1fdf4efbc490041eb4f836bf596201203f8f2 upstream.

cifs.spnego key descriptions contain authority-bearing fields such as
pid, uid, creduid, and upcall_target that cifs.upcall treats as
kernel-originating inputs. However, userspace can also create keys of
this type through request_key(2) or add_key(2), allowing those fields to
be supplied without CIFS origin.

Only accept cifs.spnego descriptions while CIFS is using its private
spnego_cred to request the key.

Fixes: f1d662a7d5e5 ("[CIFS] Add upcall files for cifs to use spnego/kerberos")
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Salvatore Bonaccorso: Apply changes to fs/cifs/cifs_spnego.c instead of
fs/smb/client/cifs_spnego.c before 38c8a9a52082 ("smb: move client and server
files to common directory fs/smb") in v6.4-rc1 and backported to v6.1.36]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/cifs_spnego.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/list.h>
+#include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <keys/user-type.h>
@@ -46,12 +47,27 @@ cifs_spnego_key_destroy(struct key *key)
 	kfree(key->payload.data[0]);
 }
 
+static int
+cifs_spnego_key_vet_description(const char *description)
+{
+	/*
+	 * cifs.spnego descriptions are authority-bearing inputs to cifs.upcall.
+	 * They are only valid when produced by CIFS while using the private
+	 * spnego_cred installed below.  Do not let userspace create this type
+	 * of key through request_key(2)/add_key(2), since the helper treats
+	 * pid/uid/creduid/upcall_target as kernel-originating fields.
+	 */
+	if (current_cred() != spnego_cred)
+		return -EPERM;
+	return 0;
+}
 
 /*
  * keytype for CIFS spnego keys
  */
 struct key_type cifs_spnego_key_type = {
 	.name		= "cifs.spnego",
+	.vet_description = cifs_spnego_key_vet_description,
 	.instantiate	= cifs_spnego_key_instantiate,
 	.destroy	= cifs_spnego_key_destroy,
 	.describe	= user_describe,




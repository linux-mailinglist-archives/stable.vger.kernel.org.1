Return-Path: <stable+bounces-235222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NWqE0em1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:02:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E838D3C2396
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EA523004C26
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460D3D8139;
	Wed,  8 Apr 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JvfFkNAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F333D648A;
	Wed,  8 Apr 2026 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674885; cv=none; b=QLV3ZpBANGg+QHXHAfiE5uN/qwJDBLgPhsCkEqC6cvKDLaU2ZpZpH/TIHQnn2GoRV6/aOfFFCfpxQVdWqEBGDLOC45FvSGMmMd0JyTzR+xSu4OsKk7ePW15uSDegQ1oO0YisWkzY8mtjyqgrlrGrYllBLsMb8XyzjrQ3XCDqKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674885; c=relaxed/simple;
	bh=hA1V/klznBu6TVT6VowyTXL+7C40ckjqtpoIih94qtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eG2SMI0R9KE5Tzo0Hbi/02LxBQJB/C0QyWQUAR/XT4RHDLjwZ2UTF3pIl4C69mw6uPU5U/ZfHlt8eRsa2dFm6CzRKSTrx880ungs2Q/X0M50/Z5388p7ya0pNDclhJFWRc1NaNB6iWvY4SBI+dBBMz8K5GeCH8esCeUAmXp0Axo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvfFkNAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A32C19421;
	Wed,  8 Apr 2026 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674884;
	bh=hA1V/klznBu6TVT6VowyTXL+7C40ckjqtpoIih94qtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvfFkNAJOa8I06EVng+SyO9VJx7PxA5DlRDcbMQrSCfRITtq4ljOJmohXUfpe6G8v
	 22NJxEihWZDxShZ6L6u5XUBgg6HHSIcburnd4w/VVeR8fKT+ie3RSf1+bSeHdm/SWD
	 lOcXHBhE03RmUus2hmCSp7tOrOI+8GAV3bjxkJFE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Liav Mordouch <liavmordouch@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 6.19 270/311] vt: discard stale unicode buffer on alt screen exit after resize
Date: Wed,  8 Apr 2026 20:04:30 +0200
Message-ID: <20260408175949.463910947@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235222-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,fluxnic.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fluxnic.net:email]
X-Rspamd-Queue-Id: E838D3C2396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liav Mordouch <liavmordouch@gmail.com>

commit 40014493cece72a0be5672cd86763e53fb3ec613 upstream.

When enter_alt_screen() saves vc_uni_lines into vc_saved_uni_lines and
sets vc_uni_lines to NULL, a subsequent console resize via vc_do_resize()
skips reallocating the unicode buffer because vc_uni_lines is NULL.
However, vc_saved_uni_lines still points to the old buffer allocated for
the original dimensions.

When leave_alt_screen() later restores vc_saved_uni_lines, the buffer
dimensions no longer match vc_rows/vc_cols. Any operation that iterates
over the unicode buffer using the current dimensions (e.g. csi_J clearing
the screen) will access memory out of bounds, causing a kernel oops:

  BUG: unable to handle page fault for address: 0x0000002000000020
  RIP: 0010:csi_J+0x133/0x2d0

The faulting address 0x0000002000000020 is two adjacent u32 space
characters (0x20) interpreted as a pointer, read from the row data area
past the end of the 25-entry pointer array in a buffer allocated for
80x25 but accessed with 240x67 dimensions.

Fix this by checking whether the console dimensions changed while in the
alternate screen. If they did, free the stale saved buffer instead of
restoring it. The unicode screen will be lazily rebuilt via
vc_uniscr_check() when next needed.

Fixes: 5eb608319bb5 ("vt: save/restore unicode screen buffer for alternate screen")
Cc: stable <stable@kernel.org>
Tested-by: Liav Mordouch <liavmordouch@gmail.com>
Signed-off-by: Liav Mordouch <liavmordouch@gmail.com>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
Link: https://patch.msgid.link/20260327170204.29706-1-liavmordouch@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1907,6 +1907,7 @@ static void leave_alt_screen(struct vc_d
 	unsigned int rows = min(vc->vc_saved_rows, vc->vc_rows);
 	unsigned int cols = min(vc->vc_saved_cols, vc->vc_cols);
 	u16 *src, *dest;
+	bool uni_lines_stale;
 
 	if (vc->vc_saved_screen == NULL)
 		return; /* Not inside an alt-screen */
@@ -1915,7 +1916,18 @@ static void leave_alt_screen(struct vc_d
 		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
 		memcpy(dest, src, 2 * cols);
 	}
-	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+	/*
+	 * If the console was resized while in the alternate screen,
+	 * vc_saved_uni_lines was allocated for the old dimensions.
+	 * Restoring it would cause out-of-bounds accesses. Discard it
+	 * and let the unicode screen be lazily rebuilt.
+	 */
+	uni_lines_stale = vc->vc_saved_rows != vc->vc_rows ||
+			  vc->vc_saved_cols != vc->vc_cols;
+	if (uni_lines_stale)
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+	else
+		vc_uniscr_set(vc, vc->vc_saved_uni_lines);
 	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */




Return-Path: <stable+bounces-232441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDOKCWgHzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:42:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C85336F263
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 768F6300462C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886F2FDC5E;
	Tue, 31 Mar 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FFKk4nd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99A2FE042;
	Tue, 31 Mar 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976755; cv=none; b=bgFIAE7942gsTZrCem2TblNkeIxVFRZuAnDfLDSg2UVRzDEVK+UPiKncHTqkIDiutOIGwO2dq2g2pCpn4LSoZIRT9cxQLb4MWQlLGFEtNZA46FTSvWyV+eV2b5db7ANBvBVx0mosKKOqhe/BLAHjcHWskTm3k4rh9L5hZNzomg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976755; c=relaxed/simple;
	bh=K1qgHuU6FxK/+pfmQFNJs1EldLOOKLGEI0OQ7w1bRug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6S3xctfy9F13hYjvkG5NL701hjsE60gabR1OxsaO5e6/lVdKdhYBb7qTanU6hZ5G4a6YzA6TiGNVnh1zdG8rOSsGgZiOh7zL77P2OoZqiSyZOhnJIFnD7hZDTTAyBUssmLJ+VD7prXT0tCZxLrVq4a37Ux3uS876BObKqbwD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FFKk4nd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D97C19423;
	Tue, 31 Mar 2026 17:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976755;
	bh=K1qgHuU6FxK/+pfmQFNJs1EldLOOKLGEI0OQ7w1bRug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFKk4nd72sqPP9knoQ/Ke+8ZxXomIPz5naPgTqnB+zPRUAxBY9F02iVndFaOMkmPa
	 5msU9k327lOMlkX/4/cEvw0gJQ/3KHFshvvl6gUv+jCKYX1SJIRLR+ZikCin+koRBw
	 5M+FacudWsrJq5jUUpvXLjpE/chNqsoBAjQ2G35Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 6.18 216/309] ovl: fix wrong detection of 32bit inode numbers
Date: Tue, 31 Mar 2026 18:21:59 +0200
Message-ID: <20260331161801.399807842@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232441-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5C85336F263
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 53a7c171e9dd833f0a96b545adcb89bd57387239 upstream.

The implicit FILEID_INO32_GEN encoder was changed to be explicit,
so we need to fix the detection.

When mounting overlayfs with upperdir and lowerdir on different ext4
filesystems, the expected kmsg log is:

  overlayfs: "xino" feature enabled using 32 upper inode bits.

But instead, since the regressing commit, the kmsg log was:

  overlayfs: "xino" feature enabled using 2 upper inode bits.

Fixes: e21fc2038c1b9 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/util.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -90,7 +90,10 @@ int ovl_can_decode_fh(struct super_block
 	if (!exportfs_can_decode_fh(sb->s_export_op))
 		return 0;
 
-	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
+	if (sb->s_export_op->encode_fh == generic_encode_ino32_fh)
+		return FILEID_INO32_GEN;
+
+	return -1;
 }
 
 struct dentry *ovl_indexdir(struct super_block *sb)




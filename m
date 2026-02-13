Return-Path: <stable+bounces-216166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFqbMggtj2ksLgEAu9opvQ
	(envelope-from <stable+bounces-216166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF4136B03
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 396113010B81
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0A35FF49;
	Fri, 13 Feb 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CI+Mj3sJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FD54723;
	Fri, 13 Feb 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990854; cv=none; b=emT9LjshqMhZ8jwMgqJgMmEq5owB2hHbfy5MumSjdyeYbKTyI1u14edERui3++pdONm0dk/NYFmyVQBuS9QEEVVMlXo8PQMJcV3YbwklhiJKRTKr2BN9EbO+U/lXII85iuKih9F0KRi4/deKRQ7xpr3c9Sxf3aWpCrlbHlBqMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990854; c=relaxed/simple;
	bh=ORQwWgT038onrW2mxgCt36+jnO/pvvt5po+wuRjiKtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud35ZYX3UICbfeWKisA0YjDtcDaBMcB+FZjmFUYrwnvcqjoyrjc6IIHtg87juYrctHCayPiSyu1dOFSuQ+iNhYDXeRCoj+sSuBzm8nGnIxbrjiAlzYIt14OCGVRFMDzWv2OK9ErZTvNCcRz/cxHEck5v53pJe6vhHki7seMMVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CI+Mj3sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A57C116C6;
	Fri, 13 Feb 2026 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990854;
	bh=ORQwWgT038onrW2mxgCt36+jnO/pvvt5po+wuRjiKtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CI+Mj3sJasipmQRZiK2pxfftr/i4QDengPG2oyYVrOSa5GbLbWph3cCBIbXEymgRf
	 +XOH8u/CR0zwO/Q8rTmXsEArTzz726MtIND1MLEchPS2hipt4qNff6OmeF1Q+Sk7J+
	 8FIU4zq4AeoY5uwc/45IqNWBjNpHM0JUgvMlo4hs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	r772577952@gmail.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.18 45/49] xfs: fix UAF in xchk_btree_check_block_owner
Date: Fri, 13 Feb 2026 14:48:29 +0100
Message-ID: <20260213134710.511759795@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216166-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,lst.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,lst.de:email]
X-Rspamd-Queue-Id: 44AF4136B03
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

commit 1c253e11225bc5167217897885b85093e17c2217 upstream.

We cannot dereference bs->cur when trying to determine if bs->cur
aliases bs->sc->sa.{bno,rmap}_cur after the latter has been freed.
Fix this by sampling before type before any freeing could happen.
The correct temporal ordering was broken when we removed xfs_btnum_t.

Cc: r772577952@gmail.com
Cc: <stable@vger.kernel.org> # v6.9
Fixes: ec793e690f801d ("xfs: remove xfs_btnum_t")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jiaming Zhang <r772577952@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/btree.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -370,12 +370,15 @@ xchk_btree_check_block_owner(
 {
 	xfs_agnumber_t		agno;
 	xfs_agblock_t		agbno;
+	bool			is_bnobt, is_rmapbt;
 	bool			init_sa;
 	int			error = 0;
 
 	if (!bs->cur)
 		return 0;
 
+	is_bnobt = xfs_btree_is_bno(bs->cur->bc_ops);
+	is_rmapbt = xfs_btree_is_rmap(bs->cur->bc_ops);
 	agno = xfs_daddr_to_agno(bs->cur->bc_mp, daddr);
 	agbno = xfs_daddr_to_agbno(bs->cur->bc_mp, daddr);
 
@@ -398,11 +401,11 @@ xchk_btree_check_block_owner(
 	 * have to nullify it (to shut down further block owner checks) if
 	 * self-xref encounters problems.
 	 */
-	if (!bs->sc->sa.bno_cur && xfs_btree_is_bno(bs->cur->bc_ops))
+	if (!bs->sc->sa.bno_cur && is_bnobt)
 		bs->cur = NULL;
 
 	xchk_xref_is_only_owned_by(bs->sc, agbno, 1, bs->oinfo);
-	if (!bs->sc->sa.rmap_cur && xfs_btree_is_rmap(bs->cur->bc_ops))
+	if (!bs->sc->sa.rmap_cur && is_rmapbt)
 		bs->cur = NULL;
 
 out_free:




Return-Path: <stable+bounces-232475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFFyOL4HzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:43:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CE36F33D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8423314CA2D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA830AD00;
	Tue, 31 Mar 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5MnrC1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D5303A07;
	Tue, 31 Mar 2026 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976843; cv=none; b=THbh0gqt1Eidh8L0kReCQmdm2Ttjo+Y/BjofV3bZA1e9vSBCzDqe1JJEzYVfQY/Id3YduKopdEqqxS9XF0CxEDoi3HU3fPBtbue0RxgGjakJEZQd3wBFXQovusxBOPOG6FXviNnKwAcqGDL70P4pBRUGq4bmK1kXhLq2uo7D9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976843; c=relaxed/simple;
	bh=M6XN84OZBkXXdnpxuI7/nDZy7RQudNqIYf3R8QelJKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi0sZFuZTbdFQJ/+RuQ6PN3Ng0WEbaTKhM16PKiiSJDjq+ba/ELhMRhMxquGOG9Na0EmzUzvX1Uk604ofoyBV2Kb1Tjew7kQQowAO6LV1CkD3wRZmhYEr8s6xp1wmJ8j3RnumFE7rh6CJPQzl0Dux74mcEfKiSCFgE0jf51ZNwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5MnrC1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759FFC19423;
	Tue, 31 Mar 2026 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976843;
	bh=M6XN84OZBkXXdnpxuI7/nDZy7RQudNqIYf3R8QelJKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5MnrC1rrzDK2RL2BEa7EByWM97Pm95OmvagayLakMyg+56GkFs4PvwefLZ/Z+qfR
	 X37FbkM2wc/5TF+/taClz5T0I/YdjSXwKp2v4RS046YpEbjNrXYTET4cKFuj/a3vC/
	 b5KJk4Wp4e1L9m0BAgamY7cFe4E/Vt3KNl9yCAfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hongao <hongao@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.18 250/309] xfs: scrub: unlock dquot before early return in quota scrub
Date: Tue, 31 Mar 2026 18:22:33 +0200
Message-ID: <20260331161802.775369447@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232475-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,uniontech.com:email]
X-Rspamd-Queue-Id: 1F6CE36F33D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hongao <hongao@uniontech.com>

commit 268378b6ad20569af0d1957992de1c8b16c6e900 upstream.

xchk_quota_item can return early after calling xchk_fblock_process_error.
When that helper returns false, the function returned immediately without
dropping dq->q_qlock, which can leave the dquot lock held and risk lock
leaks or deadlocks in later quota operations.

Fix this by unlocking dq->q_qlock before the early return.

Signed-off-by: hongao <hongao@uniontech.com>
Fixes: 7d1f0e167a067e ("xfs: check the ondisk space mapping behind a dquot")
Cc: <stable@vger.kernel.org> # v6.8
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/quota.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -174,8 +174,10 @@ xchk_quota_item(
 
 	error = xchk_quota_item_bmap(sc, dq, offset);
 	xchk_iunlock(sc, XFS_ILOCK_SHARED);
-	if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, offset, &error))
+	if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, offset, &error)) {
+		mutex_unlock(&dq->q_qlock);
 		return error;
+	}
 
 	/*
 	 * Warn if the hard limits are larger than the fs.




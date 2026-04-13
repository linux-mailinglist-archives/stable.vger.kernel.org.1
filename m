Return-Path: <stable+bounces-236517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JpJJgsd3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FFE3EF937
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C61130B0B73
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0D2F6931;
	Mon, 13 Apr 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w97+C/zD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391932EBB8C;
	Mon, 13 Apr 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097110; cv=none; b=bdQIHKnNX7QX99k1Y4eiLQds4tZ7x1IFOb9k+ed60UqEhBuHcl+YVrtLIt0ycQNnuSHeHedl5Rn0/ys+sDLsjKRhBsJ4KB8lywuDNQ4k/uNlteuA8YqIHgCx2HjrZ+CCREnvf7kQEIoJToGD/NW+yRS+uT25sAVPUC79sjfG3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097110; c=relaxed/simple;
	bh=rRa+Y4DOwcm7TSQ2smyj/RIXqtrt57F0E5XO57Jm/r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHbAdlTosKCJfr4HkTRyqit2k/drroECokbLZfDy6sg12C0iwKHw1tAwlQ+m5x+AXui0trUKcB+DMkVr+UgIuwe3wNsKf/el5NFL29HZQfBtlEk1kC4smv3kpABcfZNb8SSE1FYRyDHm7aI1g59S9NRTqHLiG1kkMaJKCQp2T4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w97+C/zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D7C2BCAF;
	Mon, 13 Apr 2026 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097109;
	bh=rRa+Y4DOwcm7TSQ2smyj/RIXqtrt57F0E5XO57Jm/r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w97+C/zDYr+yB4Kz/YODAlDDjRfqVQj7wPe9zqHT7gnhbHkQyQYU+6fGUHe4m1On3
	 ywKMIcQkZN3e2kgwheQpXAauFtTIsVhH9fEcis0/KqF1xS55e7XToDTISwjDVDp21F
	 nqP5qodQJg9Bxz50LbgzS3bLXf5Eqtl+TUQeg9OI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@fb.com>,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <mark@harmstone.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 010/570] btrfs: fix incorrect key offset in error message in check_dev_extent_item()
Date: Mon, 13 Apr 2026 17:52:21 +0200
Message-ID: <20260413155830.785309481@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236517-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,fb.com:email,harmstone.com:email,suse.com:email]
X-Rspamd-Queue-Id: 05FFE3EF937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <mark@harmstone.com>

[ Upstream commit 511dc8912ae3e929c1a182f5e6b2326516fd42a0 ]

Fix the error message in check_dev_extent_item(), when an overlapping
stripe is encountered. For dev extents, objectid is the disk number and
offset the physical address, so prev_key->objectid should actually be
prev_key->offset.

(I can't take any credit for this one - this was discovered by Chris and
his friend Claude.)

Reported-by: Chris Mason <clm@fb.com>
Fixes: 008e2512dc56 ("btrfs: tree-checker: add dev extent item checks")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <mark@harmstone.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8f96ddaceb9a7..86042c1f89f0b 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1680,7 +1680,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 		if (unlikely(prev_key->offset + prev_len > key->offset)) {
 			generic_err(leaf, slot,
 		"dev extent overlap, prev offset %llu len %llu current offset %llu",
-				    prev_key->objectid, prev_len, key->offset);
+				    prev_key->offset, prev_len, key->offset);
 			return -EUCLEAN;
 		}
 	}
-- 
2.51.0





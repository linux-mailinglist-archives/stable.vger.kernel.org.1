Return-Path: <stable+bounces-227273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOfVNj7iu2njpQIAu9opvQ
	(envelope-from <stable+bounces-227273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:47:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E02CA910
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487D5328CA2F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82DB3B47CB;
	Thu, 19 Mar 2026 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTsSlivE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FC3C2796
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920409; cv=none; b=ipeCe9fqm+5JiXAwshJ47eiiKf6ulryxssYnJxJNBgZ32EsYM5qXEXFGs5Wwu5dfE6UefoI+3p1IYbmT5Yu5DZ+HSnmtYR6zkVEIhzrtGGWleYq83QrIycQ7ngAH5EVl8kUFTa79kLGjPcfrZMfCr08bNC3tmLIRH9mHxi3OoT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920409; c=relaxed/simple;
	bh=qIkLNR7+ZeHfeqFPzxIPCfzS+ttK2D0PbrApFdChGkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAdJOrLCS2/MxzwzlwOj0cvvI/HRx7/2FLalcf1xcZzrJ+RxomMqbB3XZJX0iextsW5tU6UiYNsJIgWDTu6A/EBhzprh0ld0uTtWjgvWqAss+2JaqUY1vV2BSw9kyrR6hTnPN8wzrtOQ/pO5+AaPlG7FqevHXLW7VxIKERWt1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTsSlivE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA01C19424;
	Thu, 19 Mar 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920409;
	bh=qIkLNR7+ZeHfeqFPzxIPCfzS+ttK2D0PbrApFdChGkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTsSlivEVoEq0kLeC1INKxxtS/0T07V+ceuXBAMEwwwU6dsFVhXctVvK3IGwm9W+o
	 2gGYpmYFHQp/beS9Or+TGctcgP6owb0AipLETtmfGmmFbXNfq5/j8Nhj5Fbi+CVb92
	 uzYzbVD9rzcf10E7r84GNxs7gUl+YEqCecc7Wq7ZK1zre6BfTXtoIaFOPysADHS28J
	 KffED7pr2yxvWUdFN2nsO/2dVjDQ1Qoj5osCOJh+ButCNFzm3CGQ7fKfwnhbHkIG1M
	 gKaP0YuXKOpZRS84aGA2S9KuqNbznDBMb42JtQcYAht2b4kgkhzb48rrx1bhAAG81C
	 MYai+GuoHvNQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: fix integer overflow in bmap intent sort comparator
Date: Thu, 19 Mar 2026 07:40:07 -0400
Message-ID: <20260319114007.2348969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031715-deepen-kabob-15c4@gregkh>
References: <2026031715-deepen-kabob-15c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227273-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 169E02CA910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 362c490980867930a098b99f421268fbd7ca05fd ]

xfs_bmap_update_diff_items() sorts bmap intents by inode number using
a subtraction of two xfs_ino_t (uint64_t) values, with the result
truncated to int. This is incorrect when two inode numbers differ by
more than INT_MAX (2^31 - 1), which is entirely possible on large XFS
filesystems.

Fix this by replacing the subtraction with cmp_int().

Cc: <stable@vger.kernel.org> # v4.9
Fixes: 9f3afb57d5f1 ("xfs: implement deferred bmbt map/unmap operations")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ replaced `bi_entry()` macro with `container_of()` and inlined `cmp_int()` as a manual three-way comparison expression ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_bmap_item.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 984bb480f1774..a3b350437db26 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -273,7 +273,8 @@ xfs_bmap_update_diff_items(
 
 	ba = container_of(a, struct xfs_bmap_intent, bi_list);
 	bb = container_of(b, struct xfs_bmap_intent, bi_list);
-	return ba->bi_owner->i_ino - bb->bi_owner->i_ino;
+	return (ba->bi_owner->i_ino > bb->bi_owner->i_ino) -
+		(ba->bi_owner->i_ino < bb->bi_owner->i_ino);
 }
 
 /* Set the map extent flags for this mapping. */
-- 
2.51.0



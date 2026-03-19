Return-Path: <stable+bounces-227258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FBQAgHWu2k4owIAu9opvQ
	(envelope-from <stable+bounces-227258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:54:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A832C9CA8
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FFD31E5BDF
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B3C3B19A9;
	Thu, 19 Mar 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzsRHQAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C03C4561
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917390; cv=none; b=i90WVFNHWNIJgr94nkMvU0yHhYzWZJy7W3zK45qt6d7LPSHdcorugNHhaTLqliQ8jO8jp060NhRCtqCLjUKGYrvcMUed7G+qg3q0xiYKIfMVwxBjwjbjHgHH+w7YaSX+S+6RuTSORz0rhQ9uUskR9Rf/lPclMO4hcJjNMkLiQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917390; c=relaxed/simple;
	bh=iadSmaFVIHrM/fuvZz2TT2rivN9unaZaBVrQHwmMjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBx9V4FKr4WyCQ8eRIAwje65sPDLdOu5m71nGoiTgzWr3kkFMe7ABqWGMeo+b6TlTT7uLZwgbk1x9eVUdSCTWMkusHZmzvqhHXVOEyci4SnXMoUdgFgQoQEKEY7wvV1kPec9lgZV11FVcON3Pj7mSRQVbKfnpd31r3h1xAn7vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzsRHQAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7485C19424;
	Thu, 19 Mar 2026 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773917389;
	bh=iadSmaFVIHrM/fuvZz2TT2rivN9unaZaBVrQHwmMjbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzsRHQAviEv8e+4buBPnGTHF1hC20swVcOW5e0DFiWyFGi+x04NFwoFOK/6NtiJiL
	 hiDTqhkzWIYBaWHj6ROI3vONfz7RHmnXZ8GrWxZXkVtKxRmJRCfDP0y4XmKSrEX6/k
	 tjWRJdVw7qhEOd1GVNA0mysj/SQ+IoWSR/YfzflCqSB1QYpRiG4t9HEAdIBNZzJyOd
	 xvIonUQfsCTdHehcMtrGPaIC+MGCFHrW7exwnA+901nTkzFg4yWiXxce583tUIwSrQ
	 kGpnHp7+pEUw+N6G5LGBg4E5cO0XPdtC2e7AoMfTNc0Gk4U7QOqyRpmlS935pfzzEh
	 Op+X1A3nckRbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Long Li <leo.lilong@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fix integer overflow in bmap intent sort comparator
Date: Thu, 19 Mar 2026 06:49:47 -0400
Message-ID: <20260319104947.2288756-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031713-nectar-disparity-ab02@gregkh>
References: <2026031713-nectar-disparity-ab02@gregkh>
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
	TAGGED_FROM(0.00)[bounces-227258-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A832C9CA8
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
index b6d63b8bdad5a..969cad575c302 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -278,7 +278,8 @@ xfs_bmap_update_diff_items(
 
 	ba = container_of(a, struct xfs_bmap_intent, bi_list);
 	bb = container_of(b, struct xfs_bmap_intent, bi_list);
-	return ba->bi_owner->i_ino - bb->bi_owner->i_ino;
+	return (ba->bi_owner->i_ino > bb->bi_owner->i_ino) -
+		(ba->bi_owner->i_ino < bb->bi_owner->i_ino);
 }
 
 /* Set the map extent flags for this mapping. */
-- 
2.51.0



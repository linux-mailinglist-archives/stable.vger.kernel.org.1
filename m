Return-Path: <stable+bounces-252476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJj9Blr9DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8259644B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B76B23106B71
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D13F8707;
	Wed, 20 May 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t+FB5fLF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35403C140F;
	Wed, 20 May 2026 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300773; cv=none; b=EpYK96cK3EasWRfqv0FY+xTddHS2wv0XwNBXHAzSGZlk4IfiKfJXJcevAZf7/zJ+nK8D8awouwAxRjPCNO/TcqzF2kXoNvEQJMWxWpTnLsE46/mjkwgATgtu9QfIA0WEp/zCDB7RgLLCoMYBOHRIPsnuBzI0QJ6xN5yKpYOJ+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300773; c=relaxed/simple;
	bh=wJ7hU3khEqSC9ZAcInkWzcq7QGA/WJQ4ToErhfAKuZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5u5+Lokn9/wy17zLmYueBLiqE1zwwTJ8Zosx2doJytDDv+kq9pLMY8ZSacKu5TW29ayujLWZLKNKvocxj4uzXyEm4b00/CRw6NNPHqmvXFqOOWdTa9cf05BWObymcoSfRIVR13TUcwKojOXflIN0yug1lDs/aF4KUC7vx0EPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t+FB5fLF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DEA1F000E9;
	Wed, 20 May 2026 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300772;
	bh=1tBVHEZsqVFnUZglCdsLXx3dOjf6SomyBbfXoa5NSuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t+FB5fLF87a7UOkJ0RRlrXXnzbPN0ANEJXnhkbB81H034aa3isVmKVM6T9mqsSu1P
	 pTTumsCNd46eLt+KzcrazSbirmUClkIO53cCSo4IkuskA2IFoHsOjyMdN/ssGWvkx5
	 d3IsGleJ8PzWFYbHBQ11EgitccKEMyNY5W6qgcck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 260/666] gfs2: prevent NULL pointer dereference during unmount
Date: Wed, 20 May 2026 18:17:51 +0200
Message-ID: <20260520162116.853456367@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-252476-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: DDB8259644B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 74b4dbb946060a3233604d91859a9abd3708141d ]

When flushing out outstanding glock work during an unmount, gfs2_log_flush()
can be called when sdp->sd_jdesc has already been deallocated and sdp->sd_jdesc
is NULL.  Commit 35264909e9d1 ("gfs2: Fix NULL pointer dereference in
gfs2_log_flush") added a check for that to gfs2_log_flush() itself, but it
missed the sdp->sd_jdesc dereference in gfs2_log_release().  Fix that.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202604071139.HNJiCaAi-lkp@intel.com/
Fixes: 35264909e9d1 ("gfs2: Fix NULL pointer dereference in gfs2_log_flush")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/log.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 592f69602e5aa..ecc5c59b87008 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -471,8 +471,9 @@ void gfs2_log_release(struct gfs2_sbd *sdp, unsigned int blks)
 {
 	atomic_add(blks, &sdp->sd_log_blks_free);
 	trace_gfs2_log_blocks(sdp, blks);
-	gfs2_assert_withdraw(sdp, atomic_read(&sdp->sd_log_blks_free) <=
-				  sdp->sd_jdesc->jd_blocks);
+	gfs2_assert_withdraw(sdp, !sdp->sd_jdesc ||
+			atomic_read(&sdp->sd_log_blks_free) <=
+			sdp->sd_jdesc->jd_blocks);
 	if (atomic_read(&sdp->sd_log_blks_needed))
 		wake_up(&sdp->sd_log_waitq);
 }
-- 
2.53.0





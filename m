Return-Path: <stable+bounces-221787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IxHN9eco2k3IQUAu9opvQ
	(envelope-from <stable+bounces-221787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:56:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B01CC531
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 428CD32ACD80
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAF2F360A;
	Sun,  1 Mar 2026 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hshb0Xp6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05082899;
	Sun,  1 Mar 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329135; cv=none; b=tzmIz1sYifiRyi1y8POAeBM6u7V1nq8urCvB82WrMv+ld8kH9tTyJ3XDJsn0Lpl4IZ+aakAMIrW5MoVmmvw81p9QasWpxQp2xv6rQini7IUczdkX5XjR0vgxLOtHB4YRK8TJqA3Z5jENFNb71vzRTt8tNAy4Ce7d0zKkMAbX+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329135; c=relaxed/simple;
	bh=WrRldZHKCM57Wj+ZSwnWa1FPyVNkymSyoQSVQKYT1nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgY/YBGtdqqf6ZIHTb/+rHlL9MPVTvrBhioilN03z4BmRFx90o8a3VBC9FwGJgF/CAu/Drlx9KfOjHPgUJAKTDFkCQoyAI2sGQ7o5Fz47OunlGoHAgCSigmIKdRHAKZY9+nhuOKpT5WZqCJd5ORX+rgjJVL8GrY37wFovWrsvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hshb0Xp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CCEC19421;
	Sun,  1 Mar 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329135;
	bh=WrRldZHKCM57Wj+ZSwnWa1FPyVNkymSyoQSVQKYT1nQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hshb0Xp6X5K9Z7qTseNtivOA2Rttm4dosunmsH20YJ0RPdWwUDB9rVR/oWauFQY79
	 ykvNHfr6BQinHf5y/7ca3qU0wF1ICD7SL0EYdTKkJKMKWF8M/Ul3cv7LuNO1EO/+wv
	 FGpdHXNH//nLT8IlfMtySytggqyJtPoJfKGdch/8PZnPdEoGExSFYyKjUsfsmXqb7g
	 6rxgDm93xdM2CNJM12neUf0dMRO7ANz8mOCzdSygLCaaX6iseEOHBXEtHqoDsmWuRZ
	 QvMbqyR4iHopqt3yJM+E0wkX6FhijaCZzKU4vCrwJ6kGO2//WYrAvsGz/48WyAg1rC
	 Ryz4TzHn0niwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tzimmermann@suse.de
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: Remove struct fbcon_display.inverse" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:53 -0500
Message-ID: <20260301013853.1699698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,suse.de:email]
X-Rspamd-Queue-Id: 786B01CC531
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 30baedeeeab524172abc0b58cb101e8df86b5be8 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 9 Feb 2026 17:15:43 +0100
Subject: [PATCH] fbcon: Remove struct fbcon_display.inverse

The field inverse in struct fbcon_display is unused. Remove it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1cd10a7faab0f..fca14e9b729b9 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -30,7 +30,6 @@ struct fbcon_display {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
-    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
-- 
2.51.0






Return-Path: <stable+bounces-232277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHiLLef+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41A36DD96
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56E7C30ABCB5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24707423A62;
	Tue, 31 Mar 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkqiwXm/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BF423A9B;
	Tue, 31 Mar 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976333; cv=none; b=QbWo3mhGficG2x0CYPo7dT8RSCgc4BuatIbvKPoXzCozbAPPjnmh0STzM810xvIRAUbSZdox1jECAEtxSIIjVuPevZoal9y4rCbxC7ESkTO+U41/bvM2UsONkcp+LSnthDj6zKq2ZwUw8DdNwhpCuCJXMl6ZdSbxrazGOJj8zkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976333; c=relaxed/simple;
	bh=Ppr7srrS/WwRbpx776ZMdHOC2gaHXaS4ROEeW4q8LYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mscYFq42uOI3fJ37EJnTq4a+gKDA+HGwTW3L3Nd82qM0NRfD5bHj0BTyuNdAonrIeNvPR6giNamWYPHDdkjHL3p5FJ/jQwyhLnPtuW5SqY5wy2fYLAP8CQUgULEeUPE7rSFJNhVPgjpwndsQEuzU2pW922AMbM8KBIiFhGAaoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkqiwXm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700A9C19423;
	Tue, 31 Mar 2026 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976333;
	bh=Ppr7srrS/WwRbpx776ZMdHOC2gaHXaS4ROEeW4q8LYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkqiwXm/rzC2JrlpeT/LDDcpsUdB3PzovMmcSkxHWYUHRWRfmSAZixmzzKSmqqrRi
	 9sdPtETfaVYKPVqthSk8y6CHkD03VLDnctdDk3Ep30QQ3Voxpwsl6KAAc3fn4iHwR2
	 FW93QdvqZ70yEieTmP34Kznw7Vw8eprBJSrqJy6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 051/309] drm/ttm/tests: Fix build failure on PREEMPT_RT
Date: Tue, 31 Mar 2026 18:19:14 +0200
Message-ID: <20260331161755.364098357@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232277-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lankhorst.se:email,intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3B41A36DD96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Lankhorst <dev@lankhorst.se>

[ Upstream commit a58d487fb1a52579d3c37544ea371da78ed70c45 ]

Fix a compile error in the kunit tests when CONFIG_PREEMPT_RT is
enabled, and the normal mutex is converted into a rtmutex.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602261547.3bM6yVAS-lkp@intel.com/
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Link: https://patch.msgid.link/20260304085616.1216961-1-dev@lankhorst.se
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/tests/ttm_bo_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
index 6c77550c51af1..40a55f81bf47d 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
@@ -222,13 +222,13 @@ static void ttm_bo_reserve_interrupted(struct kunit *test)
 		KUNIT_FAIL(test, "Couldn't create ttm bo reserve task\n");
 
 	/* Take a lock so the threaded reserve has to wait */
-	mutex_lock(&bo->base.resv->lock.base);
+	dma_resv_lock(bo->base.resv, NULL);
 
 	wake_up_process(task);
 	msleep(20);
 	err = kthread_stop(task);
 
-	mutex_unlock(&bo->base.resv->lock.base);
+	dma_resv_unlock(bo->base.resv);
 
 	KUNIT_ASSERT_EQ(test, err, -ERESTARTSYS);
 }
-- 
2.51.0





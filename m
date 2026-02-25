Return-Path: <stable+bounces-218114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I66CFpQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E769B18EB8B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5ABC300CA29
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15881D5ABA;
	Wed, 25 Feb 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qI5BFDSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F121D596;
	Wed, 25 Feb 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982892; cv=none; b=G86yg1MJIS8OK5bXj0/es1YOOV4A0+iM7rkWCoalpyyLvhPmbqMRzRsz4EAALi8DqSqmW8gMSJxQa5/Aynjnfa76usBwlh/7FcBke8DiUYPO6fDznodsaH7BX79TGjI/ZqCc4yY4OtfqttF/JQXzAIZWTyDiag2S2a+JkYlYziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982892; c=relaxed/simple;
	bh=eH6BMuGiFWR0Qo/gYRQEe79KfTj141wVQoBQfZb0TfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCzIfmDoXu2OYb6lBYvmW7qte5kqulaBNFLgA1iFWa0BqYA29u2dFRUM8jPqxnHgScuyv4bIcuCuWr7NZnOFEs+qSJtX+KSiiUVLEjZxjytSGM7b8Vhf9Dv19sHQN33zGQI5LuPiXYRHWy8iG4rir8dhTU5MFssW/gox+jwkY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qI5BFDSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467F0C116D0;
	Wed, 25 Feb 2026 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982892;
	bh=eH6BMuGiFWR0Qo/gYRQEe79KfTj141wVQoBQfZb0TfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qI5BFDSqM/ZnzDCwmvdXymcUu4HRkaE5RiCslkCgkgoYVt9u8gtMgpdYo+SCuE5cy
	 TPDqxGqBKIhuXo/lTD2mzwNIvXIo9Jrt77z8jb93vklAPI5HzsH8/tQWToUDtVnXX4
	 ovf3lWXHtEFaghXu2JmTWcth2nGfN8TKFgsXGjgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 077/781] time/sched_clock: Use ACCESS_PRIVATE() to evaluate hrtimer::function
Date: Tue, 24 Feb 2026 17:13:06 -0800
Message-ID: <20260225012401.590706540@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218114-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E769B18EB8B
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 3db5306b0bd562ac0fe7eddad26c60ebb6f5fdd4 ]

This dereference of sched_clock_timer::function was missed when the
hrtimer callback function pointer was marked private.

Fixes: 04257da0c99c ("hrtimers: Make callback function pointer private")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/875x95jw7q.ffs@tglx
Closes: https://lore.kernel.org/oe-kbuild-all/202601131713.KsxhXQ0M-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/sched_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index f39111830ca36..f3aaef695b8cd 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -215,7 +215,7 @@ void sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 
 	update_clock_read_data(&rd);
 
-	if (sched_clock_timer.function != NULL) {
+	if (ACCESS_PRIVATE(&sched_clock_timer, function) != NULL) {
 		/* update timeout for clock wrap */
 		hrtimer_start(&sched_clock_timer, cd.wrap_kt,
 			      HRTIMER_MODE_REL_HARD);
-- 
2.51.0





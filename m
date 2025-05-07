Return-Path: <stable+bounces-142671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0927AAEBB0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA67B9E387D
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0B28DF3C;
	Wed,  7 May 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2OXxYiRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9F21504D;
	Wed,  7 May 2025 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644968; cv=none; b=jZkTW7x+K/GOBC/fVdtXdULlEtOZHIq1fRKwsMhnWxMXtGXjRRgBW/Iw5J+EdFjJI25yr4gQGQDElmowgcMeUPtsXO7ahrpl47gh6T54Wo+qzkLLpAyFYeBBowicn3ULRAnlicbudzDHAJc85aBpXkDcIstkBUxr4quBCCZIX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644968; c=relaxed/simple;
	bh=mCXczVHXL50Wu6CpsWvzK0k8INyRIahJrNUm7O9t1qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6CsFzb9A/DChcMgG/I2MrM+r5w9FACBXmgXug2xGjDbA3ymYKyPmQQTmrr4+aNW0JdpQ7fXlHQWkBOth2DyNDV36EOAHnonWgugCyBrhSUjC6T5LGOqZFrNerI0ACDTUi+EtClF/ohu7aZgeu5CzEhQ0YRA/kPc4zQFfx8ixv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2OXxYiRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D53C4CEE2;
	Wed,  7 May 2025 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644968;
	bh=mCXczVHXL50Wu6CpsWvzK0k8INyRIahJrNUm7O9t1qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2OXxYiRA/qglAfb0GW7uI0cMgIjVCV/wsEMGnuw5DwZLHijoWv5sANeyP11hNP8Zh
	 sdLMmt9zkvyupZq19js8NYYNKhBV7CTiaTOHPzca2zSmxonxEc81AlwhARp01t66Yj
	 ptIhUgW+I+9ECqJN7lN+2BoMt+DvOJrzwp6lKZb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.6 022/129] dm-integrity: fix a warning on invalid table line
Date: Wed,  7 May 2025 20:39:18 +0200
Message-ID: <20250507183814.432409292@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 0a533c3e4246c29d502a7e0fba0e86d80a906b04 upstream.

If we use the 'B' mode and we have an invalit table line,
cancel_delayed_work_sync would trigger a warning. This commit avoids the
warning.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-integrity.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4687,7 +4687,7 @@ static void dm_integrity_dtr(struct dm_t
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);




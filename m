Return-Path: <stable+bounces-98984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F49E6BA7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0E416D505
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217841EF08A;
	Fri,  6 Dec 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+Euu47j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400D1FA254
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480124; cv=none; b=uF2nqOCo44Yfcc7koG3XgDdRj20sTTBcNMMSSXN2EAVAxi0w4a0Ou6PPoH+JbyR4U5mniP89tCPqLbWrDUnugOeyhPxPumnMNuwtwnHLAGUIZTCNEtHxye83PrYbgF7AZ1GGouhBH8bAiIBEq6xjqMREsLVuiI9A4taWe4ApcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480124; c=relaxed/simple;
	bh=13sfPCAy960DjYmFqluRdeedXocJSBtmQpDpNOrV/iY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BJuOtHo8cz9ONtoQiIuW9bCid0mVNYdjweEp/AjxnVNNJ7blXvEoM4LI7HOmbHz2pVHomL8ZkFEIaieIIrUkUd1ZH9WZlG5y9mkvNdWGrww8eYBmzoq/af1F84mqBrIa8vg8TbiEtTTelmiaxVQgHWGmA8i5mHHGiElTQi8fES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+Euu47j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB334C4CED1;
	Fri,  6 Dec 2024 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733480124;
	bh=13sfPCAy960DjYmFqluRdeedXocJSBtmQpDpNOrV/iY=;
	h=Subject:To:Cc:From:Date:From;
	b=M+Euu47jNV2v3SCGy0dQSuyRovxfUVzm1D4t8FJULExe61l9jLdCIMYpkiFK88vWB
	 HyFm5saAmXTzKnjiPjRizrKYd2QcjUTfGWXpxLCxu3htVWlQl/byAlZ6qcPQdhI8JD
	 VPAF09CUNU5ZeUDwKI1jJ/h5rPPtTbYJucfeWusA=
Subject: FAILED: patch "[PATCH] zram: clear IDLE flag in mark_idle()" failed to apply to 6.12-stable tree
To: senozhatsky@chromium.org,akpm@linux-foundation.org,bgeffon@google.com,kawasin@google.com,minchan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:15:21 +0100
Message-ID: <2024120621-diffused-tweezers-95e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d37da422edb0664a2037e6d7d42fe6d339aae78a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120621-diffused-tweezers-95e1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d37da422edb0664a2037e6d7d42fe6d339aae78a Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Tue, 29 Oct 2024 00:36:15 +0900
Subject: [PATCH] zram: clear IDLE flag in mark_idle()

If entry does not fulfill current mark_idle() parameters, e.g.  cutoff
time, then we should clear its ZRAM_IDLE from previous mark_idle()
invocations.

Consider the following case:
- mark_idle() cutoff time 8h
- mark_idle() cutoff time 4h
- writeback() idle - will writeback entries with cutoff time 8h,
  while it should only pick entries with cutoff time 4h

The bug was reported by Shin Kawamura.

Link: https://lkml.kernel.org/r/20241028153629.1479791-3-senozhatsky@chromium.org
Fixes: 755804d16965 ("zram: introduce an aged idle interface")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Shin Kawamura <kawasin@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a16dbffcdca3..cee49bb0126d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -410,6 +410,8 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
 #endif
 		if (is_idle)
 			zram_set_flag(zram, index, ZRAM_IDLE);
+		else
+			zram_clear_flag(zram, index, ZRAM_IDLE);
 		zram_slot_unlock(zram, index);
 	}
 }



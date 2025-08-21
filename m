Return-Path: <stable+bounces-172116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2FBB2FB0E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337C2AE3722
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8456338F35;
	Thu, 21 Aug 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sfucFI7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8661338F30
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783262; cv=none; b=nduTZSA+DIUVgKIzszJCHLoGiMs0vO8yC7tS+fjB0FO+lUDc1v4tt3yYAfUk1XAnKkbn7/Sz38saC3DBXmgKxS8wP8MyUz6S+NRHW96rIQtHRyz5fdC/dPSYW3Tr9lbsf8ys++wGPadA4RYMSn8lHD1gLtz/yRgNDVlneE/nip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783262; c=relaxed/simple;
	bh=kpeyr8znxhpzcWpP3fxTxtLbKlwen863P3lrSnz5EW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i7bsLIbDJJYOE3ML5gQOMMKq7wuDuUcfTP33lbXzh6DQTBQ9QXTcRN49aE21dRT4CqvPdMqdx5udfJVtyP3GIMt+vY4uwXEfT/dCacjz6uFiOqq41H8hhhu9B3StjXTV6Gk7sFbJbdQtjqjHpj55dwTqhYBfK4x5yL8moXOz8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sfucFI7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D71C4CEEB;
	Thu, 21 Aug 2025 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783262;
	bh=kpeyr8znxhpzcWpP3fxTxtLbKlwen863P3lrSnz5EW4=;
	h=Subject:To:Cc:From:Date:From;
	b=sfucFI7DGY+zYN+eH0HyG9jT9ctObKAWPYno2Zcyt/fUNNuq9K9BmDuF327W40RSt
	 YqBET++vInwE24IK4FZpTOytV+pINeS0CEhPaJA5zwPNAjzdJMXILWs1b196/CJX8k
	 6qOyQlQ42fJVP3ED5YkPKNAp9UHa3i8kOsCmxfNk=
Subject: FAILED: patch "[PATCH] parisc: Try to fixup kernel exception in bad_area_nosemaphore" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:34:19 +0200
Message-ID: <2025082119-refining-upstream-528c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f92a5e36b0c45cd12ac0d1bc44680c0dfae34543
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082119-refining-upstream-528c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f92a5e36b0c45cd12ac0d1bc44680c0dfae34543 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Mon, 21 Jul 2025 16:13:13 -0400
Subject: [PATCH] parisc: Try to fixup kernel exception in bad_area_nosemaphore
 path of do_page_fault()

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c39de84e98b0..f1785640b049 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -363,6 +363,10 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
+	if (!user_mode(regs) && fixup_exception(regs)) {
+		return;
+	}
+
 	if (user_mode(regs)) {
 		int signo, si_code;
 



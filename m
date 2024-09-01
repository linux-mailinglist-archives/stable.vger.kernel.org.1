Return-Path: <stable+bounces-71777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218EB9677B2
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BE31C20DD5
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357517F394;
	Sun,  1 Sep 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4wh2a+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3062C1B4;
	Sun,  1 Sep 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207781; cv=none; b=QW6VamLqUpg5Iv7zg74jR4Hh2sfObcl+e26Q+hhwpkOtPdDLwyzrGD5AbLP2k96aSjvVyLbZZXYvuDqoFJPeLw9rsUN3dSrEGcCrg3TaYkiNQA8F5fktUdh6r6JqCW9pqPRXyX0Sq4APlUSyrAdzrQF34RBt6c9vbJlRwJvieh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207781; c=relaxed/simple;
	bh=CbaUy3bVzhNgOxzdXB7U9RXc+hGcT+VCYDT52Fa/9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeM0ngLyHOZQkY9rB9VMx7CFP72xu2zKM9Pvia5hwV9u6u3hICZ2/m7dF3rLBEuKTeFWTp6MjBNMnyOTEcO/8Deay7vsrQdFEa0ZobpgjHweEI2FyR/Fx2XL0gEDNu7ahcrnvb0Ch1cY/eDGITBoIIRn7CqTrDdQJLIqy+lxY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4wh2a+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B237C4CEC3;
	Sun,  1 Sep 2024 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207781;
	bh=CbaUy3bVzhNgOxzdXB7U9RXc+hGcT+VCYDT52Fa/9x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4wh2a+sqOoXIaTgYoP2BfOudZc5qOD0SAKFKXXHuZLmBEnooPsfWzTn4vIamszPU
	 hncls47CXTVCfmxGSDmJcxDBH8ZIiosyF/wa7x6lxHx9aMKnr1oSuYhpp7WnMPtm+9
	 vPG3JtVUFuMQWyJBV/2l1vwBn6BBVkN0W/Lna/Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 4.19 75/98] dm suspend: return -ERESTARTSYS instead of -EINTR
Date: Sun,  1 Sep 2024 18:16:45 +0200
Message-ID: <20240901160806.524742946@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 upstream.

This commit changes device mapper, so that it returns -ERESTARTSYS
instead of -EINTR when it is interrupted by a signal (so that the ioctl
can be restarted).

The manpage signal(7) says that the ioctl function should be restarted if
the signal was handled with SA_RESTART.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2468,7 +2468,7 @@ static int dm_wait_for_completion(struct
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 




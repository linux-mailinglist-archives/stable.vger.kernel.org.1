Return-Path: <stable+bounces-70856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235D696105E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97F01F23A7A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89061C4EE8;
	Tue, 27 Aug 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UAXReP/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302D1C4603;
	Tue, 27 Aug 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771288; cv=none; b=RkMPUxISECFAu52wpJUOFF41olRFpofZpShAppSd8iA3Wx9v9JnfIw/U+lZi2q20awTCzOh9Uw85a0Aie+DfWiqx5kxpgqUspUvsaXwubm103FFcxP3h45t3gTywiAAg5iCHICnnuhE1oFS4xKMqDcL2L3PgZ+84hhvrskc3efY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771288; c=relaxed/simple;
	bh=HFck/GUtvPPD1UZK01PQl2Ib2QX3uxl28CkrCqCfOlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJblap137FH8fmEbi39UxcKKL41vXanDj2RzEZjp0D3IjD/gIr2WrmffsKIyYCAjpp6ufuWs94+T2I6WCIZ05gni49lV1e0mODwNa8jwjqz0MqsTmgTgKcpzuz/aUU8WezG0jXCrk57XscwPe0qyipKl1qCZQrMgGqA1tpj1RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UAXReP/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11523C61074;
	Tue, 27 Aug 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771288;
	bh=HFck/GUtvPPD1UZK01PQl2Ib2QX3uxl28CkrCqCfOlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UAXReP/BBWEf55NEiaSv+RbaWJIhVnbOiiAcdHZ+jNH+CvXQrDtN7XkqrBX1FhVYr
	 EMB0xw5Ui4oe4MEacqJ2zkqea5b3yVx6mEDmV93KdtuT9wftUMZRoM5+GvGSwfTyp1
	 e6HvUw3IVLGNZdCNSTyEx3D7T2L5NKRqjfAZG9gA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 144/273] dm suspend: return -ERESTARTSYS instead of -EINTR
Date: Tue, 27 Aug 2024 16:37:48 +0200
Message-ID: <20240827143838.887280167@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 1e1fd567d32fcf7544c6e09e0e5bc6c650da6e23 ]

This commit changes device mapper, so that it returns -ERESTARTSYS
instead of -EINTR when it is interrupted by a signal (so that the ioctl
can be restarted).

The manpage signal(7) says that the ioctl function should be restarted if
the signal was handled with SA_RESTART.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 13037d6a6f62a..6e15ac4e0845c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2594,7 +2594,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int ta
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
@@ -2619,7 +2619,7 @@ static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_st
 			break;
 
 		if (signal_pending_state(task_state, current)) {
-			r = -EINTR;
+			r = -ERESTARTSYS;
 			break;
 		}
 
-- 
2.43.0





Return-Path: <stable+bounces-193679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710BC4A95C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F12A3B917C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF53347FDF;
	Tue, 11 Nov 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MmbSCo/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984D347FD3;
	Tue, 11 Nov 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823754; cv=none; b=fxRS4DniYgJNar3ls/ssRyWmouDWLEwffYWp4ACp1QlnHgpOHM4cJepCaJiCJfuNxVk9CLGaA9Fvggc0nGmMVmK6uDmW6gp8tTi8bEozzmF5oSjNjlirmC7yYlgo2Tfh3mSdbVACb9vMSulcnGV4yJjBiau9n/+DBUsgBZAW/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823754; c=relaxed/simple;
	bh=o3+J/fXNqqOHOiAVlsFRJg1l5g4EvwRPSGKdFNbliwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwj99xqDlfaJr5YEw8mhNwdT/ZD1KHKbkklhWFI4UrqhI0pc7YqG4IUYd07wax+8ThpAgIuhHoe+556X5es0t4mOQA2JAKqr8zvMN4zNbv40Ce5tcjXsQfo/rZhqI0PU/qWPZKfHeea/gzige1ciZQvdpHjlKsz+EGK1OYYghdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0MmbSCo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D958DC113D0;
	Tue, 11 Nov 2025 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823754;
	bh=o3+J/fXNqqOHOiAVlsFRJg1l5g4EvwRPSGKdFNbliwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0MmbSCo/smPO0Qz7uxLHwdadlWqBth1PB7eDqNnBaQNWdJCdeoRarybG+j1nAYnHv
	 o9r7ffw4FxPl1SgRRSoXCGBopxOK9xHiRNV9MhGKuOG64GjFq5VxSwC/xVqukCpLHb
	 3b8PwAddEx1jMlKobAq7O0R2QWqZsV4QVjtvYuRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zizhi Wo <wozizhi@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 313/565] tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()
Date: Tue, 11 Nov 2025 09:42:49 +0900
Message-ID: <20251111004533.927620816@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zizhi Wo <wozizhi@huaweicloud.com>

[ Upstream commit da7e8b3823962b13e713d4891e136a261ed8e6a2 ]

In vt_ioctl(), the handler for VT_RESIZE always returns 0, which prevents
users from detecting errors. Add the missing return value so that errors
can be properly reported to users like vt_resizex().

Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
Link: https://lore.kernel.org/r/20250904023955.3892120-1-wozizhi@huaweicloud.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 1f2bdd2e1cc59..387b691826623 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -923,7 +923,9 @@ int vt_ioctl(struct tty_struct *tty,
 
 			if (vc) {
 				/* FIXME: review v tty lock */
-				__vc_resize(vc_cons[i].d, cc, ll, true);
+				ret = __vc_resize(vc_cons[i].d, cc, ll, true);
+				if (ret)
+					return ret;
 			}
 		}
 		console_unlock();
-- 
2.51.0





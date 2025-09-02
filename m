Return-Path: <stable+bounces-177040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB45B402D1
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36218172571
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00E30649E;
	Tue,  2 Sep 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYZz4LIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72D30649C;
	Tue,  2 Sep 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819375; cv=none; b=Cgnot9/0cD/hbMBDCkJS7j+FvTeomPKuzGunD4X82fu8r/6yWdgSW2d5areu63P2viOAeR55+lfPOCip50EjegO0X/sgsAZjZMAR+L4JqiUO2zVwOF2l+E/X3v+SDZ8ocW4hxgFQDVgMwJFPrZcglPbB5m8gmD7b/Vxny3isZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819375; c=relaxed/simple;
	bh=Ax/GFBE9rNsWu1S/gjG2DkvVoFHsXws1aKthJRXPJqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/ersyJ2GK6Ok1iwrcKqh4hLT8TUb+HQtWjf6RGqbh62gK2veKR3vbKBadTdqIfxoHbmkP2IT4aNKSmFtLyGVFsj5gFEywEpsOzEKvmMJVp5ha/+kPE64dGJjk0eecWTdiVTlNjXlPh4AJRpl2qstd+9VC64qnL/f9I6neZAJBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYZz4LIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB65C4CEED;
	Tue,  2 Sep 2025 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819375;
	bh=Ax/GFBE9rNsWu1S/gjG2DkvVoFHsXws1aKthJRXPJqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYZz4LInvMrfB8xEX9ZxTxwveFGt693RMF/XE8JZKP2kgYPZUixbZCOWqHTpbRSxR
	 eBFLtVXb7z0fO9i6Rs9dosWaYe6B6lFF4a5g5fK/JYiwBDUvs1I/AMLIzWuzuRFRZ9
	 eRZBcKXBk0TPKIozsA4I3xhUPFll47rD145t1ATs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 016/142] vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER
Date: Tue,  2 Sep 2025 15:18:38 +0200
Message-ID: <20250902131948.774825954@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
References: <20250902131948.154194162@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 24fc631539cc78225f5c61f99c7666fcff48024d ]

The VHOST_[GS]ET_FEATURES_ARRAY ioctl already took 0x83 and it would
result in a build error when the vhost uapi header is used for perf tool
build like below.

  In file included from trace/beauty/ioctl.c:93:
  tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c: In function ‘ioctl__scnprintf_vhost_virtio_cmd’:
  tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: error: initialized field overwritten [-Werror=override-init]
     36 |         [0x83] = "SET_FORK_FROM_OWNER",
        |                  ^~~~~~~~~~~~~~~~~~~~~
  tools/perf/trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c:36:18: note: (near initialization for ‘vhost_virtio_ioctl_cmds[131]’)

Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Message-Id: <20250819063958.833770-1-namhyung@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/vhost.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index e72f2655459e4..d284a35d8104b 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -254,7 +254,7 @@
  * When fork_owner is set to VHOST_FORK_OWNER_KTHREAD:
  *   - Vhost will create vhost workers as kernel threads.
  */
-#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
+#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x84, __u8)
 
 /**
  * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhost device.
@@ -262,6 +262,6 @@
  *
  * @return: An 8-bit value indicating the current thread mode.
  */
-#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
+#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x85, __u8)
 
 #endif
-- 
2.50.1





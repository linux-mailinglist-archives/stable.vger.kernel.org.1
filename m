Return-Path: <stable+bounces-197318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE9C8F0F7
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E23B86DC
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B33126C0;
	Thu, 27 Nov 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idWv/UWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AC28D8E8;
	Thu, 27 Nov 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255473; cv=none; b=d4xyWopgACgIklNbiGDwJcOYg+/7avpYQhDqNRzoGEXEKYAYF6qR2aL6hq2SbZnHdUaf9VKWJWHdZ9BVvF1lsqRrnhsgYRD1MdRlKHj+n/Ir0/kTWzkOWIMEt19usHbttj6HWX5limZ1TITUFyHjAoDSFiN92sf8UQUX3wZg3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255473; c=relaxed/simple;
	bh=9VIOsWuh/4wdEDdI0q1pjT5ab6BRb56ifB1OppQJNL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRFdLNl7tQwg3amxfpXpPu4HiSpxkl/rzHMBPboPUwqjjhJxGahKYsGwmABcPqmvgjprgUawxgX7TNmqqNI5gmjBJ0ou9ClmTc4SKejEHMreKNZIdde6/sQ4x0DtdH/A0OMApjjs5PIFnmGFlrL1ZWVFWz/3VeJ7c6slsGhiuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idWv/UWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F871C4CEF8;
	Thu, 27 Nov 2025 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255473;
	bh=9VIOsWuh/4wdEDdI0q1pjT5ab6BRb56ifB1OppQJNL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idWv/UWQBaRx+f4KBmK07lNlDMm3oahM0haDbBPv+XsOHFWhDsxPP1uX+MPI4lrHr
	 xHpwIs7cs8sRVIjnqL0ReK4yDC3E0YzU80BMzLXDAl3cOgKuLJFQLU30JjLKdHOr++
	 org8xKjyp/KeSI0QnRaT9otljkpyxL5bsztb4rBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jari Ruusu <jariruusu@protonmail.com>
Subject: [PATCH 6.12 103/112] tty/vt: fix up incorrect backport to stable releases
Date: Thu, 27 Nov 2025 15:46:45 +0100
Message-ID: <20251127144036.611553005@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144032.705323598@linuxfoundation.org>
References: <20251127144032.705323598@linuxfoundation.org>
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


Below is a patch for 6.12.58+ and 6.17.8+ stable branches only.
Upstream does not need this.

Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>
Fixes: da7e8b382396 ("tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt_ioctl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -924,8 +924,10 @@ int vt_ioctl(struct tty_struct *tty,
 			if (vc) {
 				/* FIXME: review v tty lock */
 				ret = __vc_resize(vc_cons[i].d, cc, ll, true);
-				if (ret)
+				if (ret) {
+					console_unlock();
 					return ret;
+				}
 			}
 		}
 		console_unlock();




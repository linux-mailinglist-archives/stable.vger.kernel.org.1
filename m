Return-Path: <stable+bounces-38381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42F8A0E4A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BBA1F24073
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717B145B3E;
	Thu, 11 Apr 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KT9R5YWz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C91DDE9;
	Thu, 11 Apr 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830398; cv=none; b=sAHw09AbuKFi5JkmXwopwd1aZswG7Cv2zuBKIYvPNkWKW/SEVogBPj1gY0iL3vZGvuBM6N1E9UQgqrt1RN8M3PyEGzUYHwFcvyNiDiYL6KA59gGtCevKDqVMGUHXg1VlxxA0eSjqsm54CytKgy1BZNNKYVyZMd7v+KtbN9vmLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830398; c=relaxed/simple;
	bh=zHcSwJtu2UXRy+BZfCnQDnIepZMvJiOSKWKIqqQkVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4F+OWXS+kZskZTyBc1qBoSMw7kZjLX9suNqopUyh3BlVnGICPKwSrKfoKhk3WFg24WiNvWAwtdJ1Vl2+9sIuT0PZGlCn6HAXRP8oRSdJna2AMwopD1M07mOL7TnTq6mWywGA8bmLtfLa3r0F6UE+Cm/UR0fYYgc1qMxGz81NEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KT9R5YWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63EC433F1;
	Thu, 11 Apr 2024 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830398;
	bh=zHcSwJtu2UXRy+BZfCnQDnIepZMvJiOSKWKIqqQkVcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KT9R5YWzD033KEXR9CyMjshStQvvJB22nXgysvjEusBHCJplHmZf2MwwQyV9Y1hRM
	 S9zl0BIbig/TTcaCaK0NgVtb0qaFTM7Es289+tiyPnuvLDpfRax6C/cHp5PWVXPxfq
	 no+FpBHEw2OkbMCI4tqJ7mJpkOv7HIAjmAdiEC54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.8 131/143] gcc-plugins/stackleak: Avoid .head.text section
Date: Thu, 11 Apr 2024 11:56:39 +0200
Message-ID: <20240411095424.846891922@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

commit e7d24c0aa8e678f41457d1304e2091cac6fd1a2e upstream.

The .head.text section carries the startup code that runs with the MMU
off or with a translation of memory that deviates from the ordinary one.
So avoid instrumentation with the stackleak plugin, which already avoids
.init.text and .noinstr.text entirely.

Fixes: 48204aba801f1b51 ("x86/sme: Move early SME kernel encryption handling into .head.text")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403221630.2692c998-oliver.sang@intel.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240328064256.2358634-2-ardb+git@google.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gcc-plugins/stackleak_plugin.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -467,6 +467,8 @@ static bool stackleak_gate(void)
 			return false;
 		if (STRING_EQUAL(section, ".entry.text"))
 			return false;
+		if (STRING_EQUAL(section, ".head.text"))
+			return false;
 	}
 
 	return track_frame_size >= 0;




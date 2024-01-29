Return-Path: <stable+bounces-17233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6184105C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D326287BB5
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AED15F31D;
	Mon, 29 Jan 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6dsPlq/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AC15B975;
	Mon, 29 Jan 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548608; cv=none; b=hkMk915wSx8x0XE6ue/mtQtwj1jf9c8e+PF5zZj7VoumGsDy1738yoHkzGzAdDG7EZIP/zQbwPzeVM3g6ENGReFpFZnOYVBNL9EOwe3tGgC+nDKAMHjArxEHcAsRXcLJDmOotUiJEawGH5u5p0XXCPhJ3CwjLTnz8ka3wespWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548608; c=relaxed/simple;
	bh=rULr6lInr3S3QEwYuBv4r3yrzUY+O7WV+QGen10QEqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE/0RODi9+QQHfhues+ViImF7MKOmEkiBVYVh2DYigkc6rvxcVPmuzWdV0CVMQZjAx/E1pH1Quf9apItkgZ+h6lnBR7dpDPtz8KSWQUs+3jQTuKRx53l2lfAa7kkdgHgeqUQ0g81Wnd0X2m0pFlwRChgODpvsZd4Q0WlNWpR8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6dsPlq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B827C433C7;
	Mon, 29 Jan 2024 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548608;
	bh=rULr6lInr3S3QEwYuBv4r3yrzUY+O7WV+QGen10QEqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6dsPlq/IW2QSuwkGwdLR+thalWBxkAKF5cyJtvlLrHuEL46akXB+nSVhV4g1+x4V
	 31zK6D5K1geefpQII6iWpBxjD0P9oHNp9nRCBcoIRTfmmIjGim8zTV/XauQZivoI/M
	 Hgovto2UFby/SlMagmyl8Gx8sDy9tKw/iD2bMM8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaak Ristioja <jaak@ristioja.ee>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.6 249/331] Revert "drivers/firmware: Move sysfb_init() from device_initcall to subsys_initcall_sync"
Date: Mon, 29 Jan 2024 09:05:13 -0800
Message-ID: <20240129170022.172617266@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit d1b163aa0749706379055e40a52cf7a851abf9dc upstream.

This reverts commit 60aebc9559492cea6a9625f514a8041717e3a2e4.

Commit 60aebc9559492cea ("drivers/firmware: Move sysfb_init() from
device_initcall to subsys_initcall_sync") messes up initialization order
of the graphics drivers and leads to blank displays on some systems. So
revert the commit.

To make the display drivers fully independent from initialization
order requires to track framebuffer memory by device and independently
from the loaded drivers. The kernel currently lacks the infrastructure
to do so.

Reported-by: Jaak Ristioja <jaak@ristioja.ee>
Closes: https://lore.kernel.org/dri-devel/ZUnNi3q3yB3zZfTl@P70.localdomain/T/#t
Reported-by: Huacai Chen <chenhuacai@loongson.cn>
Closes: https://lore.kernel.org/dri-devel/20231108024613.2898921-1-chenhuacai@loongson.cn/
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10133
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: stable@vger.kernel.org # v6.5+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240123120937.27736-1-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/sysfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -128,4 +128,4 @@ unlock_mutex:
 }
 
 /* must execute after PCI subsystem for EFI quirks */
-subsys_initcall_sync(sysfb_init);
+device_initcall(sysfb_init);




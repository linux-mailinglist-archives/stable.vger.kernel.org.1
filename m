Return-Path: <stable+bounces-182143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF708BAD518
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C39C3C6DF6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA03043DA;
	Tue, 30 Sep 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3C1frmC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A4303A16;
	Tue, 30 Sep 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243978; cv=none; b=d0kVjQ8YhtX9bqmxY+7e0krw/G4b4TZwcXKk0ScLo9mggiSKfM0gpv4wSdUlx2ylNV96L7MLaahBqo+jzP2MTxRIbItBnuRSkWgqCyu6XX9X/gRvPTA5OlCn2bW3PJwA4hhPBORmfQLISazPwbd8DFwD34TzGY0rtgQdeYpu15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243978; c=relaxed/simple;
	bh=/iETv8s4/dysVgthExeGhnEx4d3T/hkkV68XAAVrQLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8y2+xRyC7HrzwZIMA+pfR/EXrCT9JpgSI8V0Tdcrb5s+QAZZIDbNezcJ9NCD6ofvDgxxA1T9BepXkfIAw+q2FvGtqVmJcY/6CoT3SrBC8wx8O16Pz1NbkBrl9wM7qI6VT5zapGIz1EEBy37IC9TOEre2v8iR5BjIhYfQ4velqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3C1frmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6C8C4CEF0;
	Tue, 30 Sep 2025 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759243977;
	bh=/iETv8s4/dysVgthExeGhnEx4d3T/hkkV68XAAVrQLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3C1frmCxfuSuIFXtgzuXxdS3TPbiwOEQ6NrS3HEs6dOFQ2yT7rEvO9gxtHjaeBFw
	 MiUUw9qBCm6vXI5RkzjHy8DSiqMF/uniHG+8BZ2AeyCsncrMY+I5bA1KtIrg8mFqEr
	 U81XEOGE/cEueKk6S+BYJqf+7Jb6VL2katBcLLHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	George Kennedy <george.kennedy@oracle.com>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	Zsolt Kajtar <soci@c64.rulez.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 5.4 74/81] fbcon: Fix OOB access in font allocation
Date: Tue, 30 Sep 2025 16:47:16 +0200
Message-ID: <20250930143822.802613888@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
User-Agent: quilt/0.69
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 9b2f5ef00e852f8e8902a4d4f73aeedc60220c12 upstream.

Commit 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
introduced an out-of-bounds access by storing data and allocation sizes
in the same variable. Restore the old size calculation and use the new
variable 'alloc_size' for the allocation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 1a194e6c8e1e ("fbcon: fix integer overflow in fbcon_do_set_font")
Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15020
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6201
Cc: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: George Kennedy <george.kennedy@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Shixiong Ou <oushixiong@kylinos.cn>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org> # v5.9+
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Qianqiang Liu <qianqiang.liu@163.com>
Link: https://lore.kernel.org/r/20250922134619.257684-1-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2482,7 +2482,7 @@ static int fbcon_set_font(struct vc_data
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2515,10 +2515,10 @@ static int fbcon_set_font(struct vc_data
 		return -EINVAL;
 
 	/* Check for overflow in allocation size calculation */
-	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &size))
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
 		return -EINVAL;
 
-	new_data = kmalloc(size, GFP_USER);
+	new_data = kmalloc(alloc_size, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;




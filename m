Return-Path: <stable+bounces-173325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19266B35C82
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4756C7B96EE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F0322524;
	Tue, 26 Aug 2025 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lua9a1Dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E833321457;
	Tue, 26 Aug 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207954; cv=none; b=VkLEeexQPSFJohCM2RdcMjuq5ngelI0KG/+QbpHzaVKRoQf3o7JjHWiaarvtetLH5ZdpvJDBQtAKjXpTflEDZuEOD2BxyhMHJay6L+o9f82+gLKcLPj1m7gbj2JYRVmrL0GfcmUYUYZ4D+IHmirxOxurfvQqd5XHSFqkzBJvEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207954; c=relaxed/simple;
	bh=sninqmlYord2E1/MYzhR+lnMdATjZRuak76Uu862mv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEfys57i+AmqchZKs9CSLVHcuz0H3zefNKVqQhudD5HZzJx7hjxKwaWzhXONlstGDj/97/V3mXgxLCZkabZzHhLufsVsr8CPk0Dmz+xOn5fBIrWD0h1fDyIu081zqsBTYYe99Zv5LO2mSmOXXvssVKmqL8GUXrsW4XZDoyKAvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lua9a1Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46132C4CEF1;
	Tue, 26 Aug 2025 11:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207953;
	bh=sninqmlYord2E1/MYzhR+lnMdATjZRuak76Uu862mv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lua9a1DvLl6BUH9Lo/UK4bNL4CHDw3q61PiJDCYl94EHc4XGRIeFdGDl4V2wueyDa
	 TP0XN+bS7hTxTJpsFZ2wKpS1Jf9v9On3uX5ipkiOIhySl3SsNr4w3viQkgJmMfqdXy
	 oIKvgE8r+FGmDC8YUJ9nKsZf94xAU9gJh/JYuR/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 350/457] drm/tests: Fix drm_test_fb_xrgb8888_to_xrgb2101010() on big-endian
Date: Tue, 26 Aug 2025 13:10:34 +0200
Message-ID: <20250826110945.973778495@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

From: José Expósito <jose.exposito89@gmail.com>

[ Upstream commit 05663d88fd0b8ee1c54ab2d5fb36f9b6a3ed37f7 ]

Fix failures on big-endian architectures on tests cases
single_pixel_source_buffer, single_pixel_clip_rectangle,
well_known_colors and destination_pitch.

Fixes: 15bda1f8de5d ("drm/tests: Add calls to drm_fb_blit() on supported format conversion tests")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250630090054.353246-2-jose.exposito89@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 8b62adbd4dfa..e17643c408bf 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -1040,6 +1040,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 	memset(buf, 0, dst_size);
 
 	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
-- 
2.50.1





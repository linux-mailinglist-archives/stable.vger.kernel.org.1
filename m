Return-Path: <stable+bounces-92376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A969C53DB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41591B2BE7C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836F421216C;
	Tue, 12 Nov 2024 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEOSRjJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9620DD7D;
	Tue, 12 Nov 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407458; cv=none; b=YO7KIEGHvDY7wxd+NGJs6rSFHnq+HJGMUqx28qrCVtmu+YkDZdTTJdG1PZl3P2RsAIy2cAKe4W3jwsH+kqC30DKOOaR79i3J6QPhmqDYLsFjHnpXvzSqz9E9L7gWajrkTz0cGwZgXo+OKWNZ2JtqyLwVuYuu6ibGk0bXE4lYMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407458; c=relaxed/simple;
	bh=EQU4g40FFrV8JlVjQRfO04shZ4op57BUUHzPyjeP6Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1aaUQGzRsSKk2AnjBx7UbdfPtiGAfc8TX/hSyYMXFO9fgZ4O9kLwehcvNVVaNL7LTpdwFDtpEtMPvdxVxC4M4rXUcBa85tvYVitmGRDjh3xZE7jxKW9tSCHEs3LsMzH6aovpmbGPkRPvnJhZ4re+NNOwwx81RptsUXndVd6aYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEOSRjJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B57C4CECD;
	Tue, 12 Nov 2024 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407457;
	bh=EQU4g40FFrV8JlVjQRfO04shZ4op57BUUHzPyjeP6Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEOSRjJnHlryXK+Ye9rFYwXxgU5aAkPOCqr5s2dBEPhmpoBQwLe+P++HEPbGiW7hm
	 2oJ5SWjmvOv6UYbP9nefmB7Y3wEcm+rQE+3Z+vHe/Z64vj6HPkWsu7o/TzDJHZ6OOo
	 dFOuCGOBKWkhnAMWmJFfYVY9+WKQuKR3vU25zUWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@maxima.ru>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 40/98] ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()
Date: Tue, 12 Nov 2024 11:20:55 +0100
Message-ID: <20241112101845.800591138@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@maxima.ru>

[ Upstream commit 8abbf1f01d6a2ef9f911f793e30f7382154b5a3a ]

If amdtp_stream_init() fails in amdtp_tscm_init(), the latter returns zero,
though it's supposed to return error code, which is checked inside
init_stream() in file tascam-stream.c.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 47faeea25ef3 ("ALSA: firewire-tascam: add data block processing layer")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20241101185517.1819-1-m.masimov@maxima.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/tascam/amdtp-tascam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index 64d66a8025455..ad185ff3209db 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -244,7 +244,7 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 	err = amdtp_stream_init(s, unit, dir, flags, fmt,
 			process_ctx_payloads, sizeof(struct amdtp_tscm));
 	if (err < 0)
-		return 0;
+		return err;
 
 	if (dir == AMDTP_OUT_STREAM) {
 		// Use fixed value for FDF field.
-- 
2.43.0





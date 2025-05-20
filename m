Return-Path: <stable+bounces-145215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBC8ABDA93
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703041891D90
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D824337B;
	Tue, 20 May 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLNbfmM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE24169B;
	Tue, 20 May 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749506; cv=none; b=pVWQFmjFF//uLBt7hCnV0Tb3Hxvzmy3nXs7jV44G4Vvjkib2CkEvnQmENZFRfNABzSIbftg9/E6/J05Ba7sglejR4c2nxS2zxV6t1fj8VKXSy6S5ikYsJRMmodUwtrmFV+LSNokrGmT85tAN+bPy/Qn2k0MuEA7v9mS6ZZMggr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749506; c=relaxed/simple;
	bh=Bncx0pvxE/1OYgKOSZbH4/ZfMxotMB9k9I/32QTIOXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0xDHU/nm7Fm5ssqd0iSlwFlWQa/TLj9z4FaciAvJwyAvALh4BlP+D+8i4hDnKpxkaHa6uDHFyXoQj3RbI7DvTzp57YQ6dJpHAXhfAj+wNCL1rRLjR4olwXCfCryu5IbwoPT//4czm3+5hxTK+mK2aNnPjFb76A9W6vFRh+4PXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLNbfmM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BCC4CEE9;
	Tue, 20 May 2025 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749506;
	bh=Bncx0pvxE/1OYgKOSZbH4/ZfMxotMB9k9I/32QTIOXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLNbfmM8DpvlvCU7K1XRbaG47GRtEPY9ZwGUxLjDbB8IHjuG0JZJVmd+q9kkOq3YD
	 oKtp+pfCJbE90sGAz/AqrWpU0m0fBc46iWPyAyuoxQeRmEVsvLTyFCzWzbwRtzjRg0
	 UI+HTrichbgh2t1ZgmciYzrHlyDX6IuJgwBGe2lQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 26/97] spi: loopback-test: Do not split 1024-byte hexdumps
Date: Tue, 20 May 2025 15:49:51 +0200
Message-ID: <20250520125801.688819740@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a73fa3690a1f3014d6677e368dce4e70767a6ba2 ]

spi_test_print_hex_dump() prints buffers holding less than 1024 bytes in
full.  Larger buffers are truncated: only the first 512 and the last 512
bytes are printed, separated by a truncation message.  The latter is
confusing in case the buffer holds exactly 1024 bytes, as all data is
printed anyway.

Fix this by printing buffers holding up to and including 1024 bytes in
full.

Fixes: 84e0c4e5e2c4ef42 ("spi: add loopback test driver to allow for spi_master regression tests")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/37ee1bc90c6554c9347040adabf04188c8f704aa.1746184171.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-loopback-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index dd7de8fa37d04..ab29ae463f677 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -410,7 +410,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
-- 
2.39.5





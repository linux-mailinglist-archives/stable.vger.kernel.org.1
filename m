Return-Path: <stable+bounces-162662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B6B05F33
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0971C244F5
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0652EE617;
	Tue, 15 Jul 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycNzU31J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B352EBDD8;
	Tue, 15 Jul 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587145; cv=none; b=QQS3OXSXColW9X3ishRlLRHaJdWNFDuUsfhKgtSgLYZfqn8VWJeVc4VJTTLdYA/6ovVUfQxf65b13yOke5rY3Sp9tIeT3RuZo5qTcME1dpB27y6oirTPgCKO/FjhLU0kIlanEWhdyzND/fyH1wFBnArifA11zTYr8I8zTJRtaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587145; c=relaxed/simple;
	bh=6fdXDYsDStWkpXDuykBHxmLwUxaqLn+Y/DKRnZHiAPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhisMdOuD+SiRgy6WfAq6aM0nHwHSh6zKc+rcLFndnqodFwAY7segVExWFgwuHhhqp8JHmXWCqGsyUSMycrvwMqc5iAYk+NnNcVzGdM//1i5kX1slTlHO4YA4EXMVAZfz9C9PEVTl3nOm0WGvwvur4eA1yGhZ1N4/7UTgF1E8DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycNzU31J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E7FC4CEF6;
	Tue, 15 Jul 2025 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587145;
	bh=6fdXDYsDStWkpXDuykBHxmLwUxaqLn+Y/DKRnZHiAPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ycNzU31JE0gKKRFSAxuF/OUUckUYK6lp4Km9CuxW0b0IMVKI2l/iHkD521Sxu3QQk
	 DBP0VDA4nasOt9PmahMwCV4T03SSgyrl79miNck7XFSvQaLjaxYK5W12vXtYlSdsFy
	 174IHmoEkvDRTgASp46oJ2ndirlcVbiLVHrhD0WM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Pitre <npitre@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 183/192] vt: add missing notification when switching back to text mode
Date: Tue, 15 Jul 2025 15:14:38 +0200
Message-ID: <20250715130822.265230970@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <npitre@baylibre.com>

[ Upstream commit ff78538e07fa284ce08cbbcb0730daa91ed16722 ]

Programs using poll() on /dev/vcsa to be notified when VT changes occur
were missing one case: the switch from gfx to text mode.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/9o5ro928-0pp4-05rq-70p4-ro385n21n723@onlyvoer.pbz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/vt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f5642b3038e4d..ed5bbf704a7d1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4566,6 +4566,7 @@ void do_unblank_screen(int leaving_gfx)
 	set_palette(vc);
 	set_cursor(vc);
 	vt_event_post(VT_EVENT_UNBLANK, vc->vc_num, vc->vc_num);
+	notify_update(vc);
 }
 EXPORT_SYMBOL(do_unblank_screen);
 
-- 
2.39.5





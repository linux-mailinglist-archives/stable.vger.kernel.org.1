Return-Path: <stable+bounces-42754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123468B747C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF241F22A3D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5512D762;
	Tue, 30 Apr 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LNZjnwEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AA12D755;
	Tue, 30 Apr 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476676; cv=none; b=SxlU6EUxkxk+sue9WKGM6rfQzYno5mgeuqybu7H2i+BPIa+J5lS7rGBM8ccfzaq3C0hzZpQkfVPuMIO2FP5N4p69L8aKVYe1MbbW6ELrt41d9+EIqkedZ0dllpmLPHfteQh10Z6aKNxkeVoccpUak6kUgvnqLK2c/YCS0eJVAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476676; c=relaxed/simple;
	bh=b5WIOCyPQg3iRQuwSKCccPvQyc1zMAnN0B0+7JmwLvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNWb1c4lYLKQmegEjbppoJptmqKwRpIDWrS7F0WBws6Mp5NdoPBXUmMtfX/8Mfw4uxA/1kryNuuWUgMpMVf5HAV9MftVxJ0TjYjAlhgblGBc9g0sgWpFCL8Klt/hlXbB4icbTYHiJDTui9YoqPNPO6s25+S6vAY0n3h5P+Ok+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LNZjnwEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BDDC4AF19;
	Tue, 30 Apr 2024 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476675;
	bh=b5WIOCyPQg3iRQuwSKCccPvQyc1zMAnN0B0+7JmwLvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNZjnwEJj5VmDWvLEd6IL9JyjyD+1cli1MkbL03Ln0Isb7Q883uuDTyd/I4uRigOc
	 ja0VnJfka8WTj61PPWbjjJeeFTjdqBekt6VXh8kDIeIvRvDS9uvJprb0NTkc+Xy6Oa
	 AM/AUa1QYLeKIwi68TmyBKodJARKp+wCmwSQd/ck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB=20=D0=9D=D0=BE=D0=B2=D0=BE=D1=81=D0=B5=D0=BB=D0=BE=D0=B2?= <m.novosyolov@rosalinux.ru>,
	=?UTF-8?q?=D0=98=D0=BB=D1=8C=D1=84=D0=B0=D1=82=20=D0=93=D0=B0=D0=BF=D1=82=D1=80=D0=B0=D1=85=D0=BC=D0=B0=D0=BD=D0=BE=D0=B2?= <i.gaptrakhmanov@rosalinux.ru>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.1 107/110] bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS
Date: Tue, 30 Apr 2024 12:41:16 +0200
Message-ID: <20240430103050.733737906@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 5af385f5f4cddf908f663974847a4083b2ff2c79 upstream.

bits_per() rounds up to the next power of two when passed a power of
two.  This causes crashes on some machines and configurations.

Reported-by: Михаил Новоселов <m.novosyolov@rosalinux.ru>
Tested-by: Ильфат Гаптрахманов <i.gaptrakhmanov@rosalinux.ru>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3347
Link: https://lore.kernel.org/all/1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru/
Fixes: f2d5dcb48f7b (bounds: support non-power-of-two CONFIG_NR_CPUS)
Cc:  <stable@vger.kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bounds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, order_base_2(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN




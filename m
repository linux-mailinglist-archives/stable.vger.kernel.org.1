Return-Path: <stable+bounces-42037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA08F8B7110
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276DA1C2202C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DA912C48B;
	Tue, 30 Apr 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6byFdu6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236E4176D;
	Tue, 30 Apr 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474355; cv=none; b=F0JqvhBzYrsys7ciUo1lfyTx+BPahy5P/LgaDMIlZPV+FS/SChCGTrlEF4pPrkYg4ciLM46+K98nlwDJ+WmzbXf6tH0/zCOTjYrv51/uWPNAHw0K1dX8FkY5YU6W9KeJiQMMnsCwJfhOuXsZFKWZi5VB7uhxJPGNbQJCYPpvShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474355; c=relaxed/simple;
	bh=1SCj6RtobMHdH89nlHQWlrbICeTNJj8ex0KLihchP70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmmyTuEtnD57qkdfVGAfvDIvZh9P0bRtlMpiii100jOdlb8Wwm6c+DlyJKwMphq7cjA6O7KzRAVkjMel2VAQAVe9COj1rIJhL7i1iI9R0y1rMTLJ9lcR2J5xnAmJHVqDbBivA0dWGgbFDQ0iEQSkU+pxXEfr7DVOqS7BsBWXxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6byFdu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC605C2BBFC;
	Tue, 30 Apr 2024 10:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474355;
	bh=1SCj6RtobMHdH89nlHQWlrbICeTNJj8ex0KLihchP70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z6byFdu6U4JrWWXzy7frWZPdKHlmzzvJuRta2PCCsqaeYBG0DtNu5zOp1KdX+Becy
	 J3KLbHt1zplGqO5CXag50t5ZrJLWcMClNjXf94KXlIgzoUvHSJRr47x68FYL61Dc0y
	 1DhiYaLWt7q0T6xmC5BAVkx0xTMotHgHj6M6kVcA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenkuan Wang <Wenkuan.Wang@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.8 132/228] x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range
Date: Tue, 30 Apr 2024 12:38:30 +0200
Message-ID: <20240430103107.612535041@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

From: Wenkuan Wang <Wenkuan.Wang@amd.com>

commit 2718a7fdf292b2dcb49c856fa8a6a955ebbbc45f upstream.

Add some more Zen5 models.

Fixes: 3e4147f33f8b ("x86/CPU/AMD: Add X86_FEATURE_ZEN5")
Signed-off-by: Wenkuan Wang <Wenkuan.Wang@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240423144111.1362-1-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -572,8 +572,7 @@ static void bsp_init_amd(struct cpuinfo_
 
 	case 0x1a:
 		switch (c->x86_model) {
-		case 0x00 ... 0x0f:
-		case 0x20 ... 0x2f:
+		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
 		case 0x70 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);




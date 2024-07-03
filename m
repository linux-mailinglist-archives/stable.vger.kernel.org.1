Return-Path: <stable+bounces-57064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05560925A85
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6FA1F20632
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41005176AB4;
	Wed,  3 Jul 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ou1x+Eu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BE17625B;
	Wed,  3 Jul 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003735; cv=none; b=LIopyvStOfsZJe9N20JCcW2Zme1lo9HycgJjXCzxMN/nQoAakKiAQ58ZBU/kqhSbwwJRxwVdX8xwZ94tiFHb8rsOezZHloF9tIWs3xVp0TtA28As1yvAnoZ27RLaB4r3kyhlODCcsTJUZPqjtkxbIlr/6D5yWMQzKSsRsHkGwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003735; c=relaxed/simple;
	bh=B+2GzjjAnSePjaCZUkhiBpjWldo37cO626kN6ebRGog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otXHkmLl8eYKQrcR1S5QUrapebcx4kYG/YMZQSIUm/Fy0fZVhkohZAtfeAxZPtPpRRdW5ZNX20izDU2hOyRGi55HpSnyV1dNBiwlMNy3b1APx8QMG9EirCSmZ71a1I7eniScQw8iMrMHgJ4l1JXqcKhx+NYFiLvOKg0KJC2AXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ou1x+Eu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2865AC2BD10;
	Wed,  3 Jul 2024 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003734;
	bh=B+2GzjjAnSePjaCZUkhiBpjWldo37cO626kN6ebRGog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ou1x+Eu+38O4eJF4w0yQEccZ7FNIsHfPwqit3dOyjjjZdGEFGK8ZQ5Yw/HeBUhJnH
	 nEb15iE2eCPQd0fWa7LNZXxptT6/FRBBoSecw4moHHq45buyRqlGaTTITDIQL2Ypht
	 Ma5nh+yn6bOgFbuSvAhkTLD0kxSDhtnn/WRn6sXE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH 4.19 130/139] drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_modes
Date: Wed,  3 Jul 2024 12:40:27 +0200
Message-ID: <20240703102835.345639403@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 66edf3fb331b6c55439b10f9862987b0916b3726 upstream.

In nv17_tv_get_ld_modes(), the return value of drm_mode_duplicate() is
assigned to mode, which will lead to a possible NULL pointer dereference
on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625081828.2620794-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -208,6 +208,8 @@ static int nv17_tv_get_ld_modes(struct d
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(encoder->dev, tv_mode);
+		if (!mode)
+			continue;
 
 		mode->clock = tv_norm->tv_enc_mode.vrefresh *
 			mode->htotal / 1000 *




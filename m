Return-Path: <stable+bounces-91603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE89BEEBF
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00E7D1F2132B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3BA1DF278;
	Wed,  6 Nov 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fwC189WY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA83646;
	Wed,  6 Nov 2024 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899219; cv=none; b=uAyXknWBYPi9/PhrOgjIjDfyL+sYNyxADBLQ2UTdHdDZ90ftQBIwQftQOjje/6TTve/yueQwtwxqqLBv7cWzyPudD4+rUy6xNhvMjXmxN3ajfG9H5G1tFNy8kmtMDbnGSPrMxOCNb5ZOd+ZH0S7jBHH1eFipd5EP2J/Ng3UHo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899219; c=relaxed/simple;
	bh=am9J6t25tR6vRNKoNdTSDP1iKBQvWDZepy24r+NtT3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXaqF6DMFieUkfEwbWDakleLmWU//XeaBT/Lm6TplfQBWMeggCtwLE/eKxZTS0qbJrwUBIfD1MS8MtTbREi4Es1cP0hAkMZyUsDCqpa3p44uX8qXasjkpp9a0ZolB4vW3/Z6xM8Y3nxBETSCwIOku12pTi+QmCh04VKSy8WXvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fwC189WY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FBDC4CECD;
	Wed,  6 Nov 2024 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899218;
	bh=am9J6t25tR6vRNKoNdTSDP1iKBQvWDZepy24r+NtT3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwC189WYNsMWop1j8D5S/lU3LwmsfWRZz0c+d5q1uqMxYbmg0nmj+kcXk9kYHTC/f
	 JwiFZFsUIo3JcoLdjsp0PMEKEjvA7jLFD3FE5jhNp5rMVqAh7jzgXds5sqoUPOYNbG
	 SZ6VxWJIj8zytwyAzVaZA6zzkxc5ak7UihqRmx9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongren Zheng <i@zenithal.me>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH 5.15 38/73] usbip: tools: Fix detach_port() invalid port error path
Date: Wed,  6 Nov 2024 13:05:42 +0100
Message-ID: <20241106120301.101087782@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

commit e7cd4b811c9e019f5acbce85699c622b30194c24 upstream.

The detach_port() doesn't return error
when detach is attempted on an invalid port.

Fixes: 40ecdeb1a187 ("usbip: usbip_detach: fix to check for invalid ports")
Cc: stable@vger.kernel.org
Reviewed-by: Hongren Zheng <i@zenithal.me>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Link: https://lore.kernel.org/r/20241024022700.1236660-1-min_halo@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/usb/usbip/src/usbip_detach.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;




Return-Path: <stable+bounces-209213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D5D26BEA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C2C2310B471
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90E2D9494;
	Thu, 15 Jan 2026 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSaZcvkr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA973D34A7;
	Thu, 15 Jan 2026 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498055; cv=none; b=M1WpI4BzC+qqN99fMiuPzO+MMDmvWHDVJ4bXpptMJPpZhRCikZQEa/dowI+WvsejLfIqDYvOZSUVN8V3Yk6/R9otkr3eVgIqA/oVP3KcHkIS3UJc1JxVlPmnPjRs1w9c9IGxTHQZ2Pr+H92UV//Q76bEec0iQGpp1DfiWmg/QXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498055; c=relaxed/simple;
	bh=iGFKqqn7r+INX+DlU4k9dm+nmdquKnWn9lRPMG6to2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgjGQsEuPuTs+UPhYODdYR6m3yK0Y7hnFJ1uvLKodSpJPo11+/uqrTlXFwTWCz0c/I43+lrrVOvuBlzcreNC2HUsJLOyEIcY3uMc0pZUF2ipqvQInn3Gavuq7GEXctoOXVtjsDILS3V+I1989M4ANhv3UWgB/AiaPF1FiKkDva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSaZcvkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8CEC19425;
	Thu, 15 Jan 2026 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768498055;
	bh=iGFKqqn7r+INX+DlU4k9dm+nmdquKnWn9lRPMG6to2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSaZcvkrqzshpaTaTZ3EQ5Gc3dtKU7dSVSS/cUikLMzLhBY/pxZxDmQQOGUU70n8c
	 mpJJmxQ85kU4CSpllY6Xp7/s5bP5cOq1kS21c/FO5tg2h/PTURGwDXu73VlbI1rUmT
	 J4Vz2wgeEzk7qXQOmiwmeTnqkEzerg9+XF9OIGg0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH 5.15 297/554] usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
Date: Thu, 15 Jan 2026 17:46:03 +0100
Message-ID: <20260115164256.983977668@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Haoxiang Li <haoxiang_li2024@163.com>

commit 36cc7e09df9e43db21b46519b740145410dd9f4a upstream.

usbhsp_get_pipe() set pipe's flags to IS_USED. In error paths,
usbhsp_put_pipe() is required to clear pipe's flags to prevent
pipe exhaustion.

Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Cc: stable <stable@kernel.org>
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Link: https://patch.msgid.link/20251204132129.109234-1-haoxiang_li2024@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/renesas_usbhs/pipe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -713,11 +713,13 @@ struct usbhs_pipe *usbhs_pipe_malloc(str
 	/* make sure pipe is not busy */
 	ret = usbhsp_pipe_barrier(pipe);
 	if (ret < 0) {
+		usbhsp_put_pipe(pipe);
 		dev_err(dev, "pipe setup failed %d\n", usbhs_pipe_number(pipe));
 		return NULL;
 	}
 
 	if (usbhsp_setup_pipecfg(pipe, is_host, dir_in, &pipecfg)) {
+		usbhsp_put_pipe(pipe);
 		dev_err(dev, "can't setup pipe\n");
 		return NULL;
 	}




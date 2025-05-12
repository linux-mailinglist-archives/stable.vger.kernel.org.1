Return-Path: <stable+bounces-143543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B4AB403E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BF3466A29
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471FA255222;
	Mon, 12 May 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUYADNY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336F1A08CA;
	Mon, 12 May 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072297; cv=none; b=V+HCs4HjhplLxoN+xzebLlqvPE6qUOLnmgati+hqmNo3bNf3tJ9i3lu6R/4l1Dqw0oQCRCv9WPSOjLM2+9cjn2jntGKh8RdHgWNzToYeIyIvtFu559h4w+FUEqiYvt5Q75a2U5OSYOu3hp/UcWKYlOxcZeEL6EnLACehLZcpElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072297; c=relaxed/simple;
	bh=ex0E5Nkjol5Uz6Q2pDH7Qvhr/HMZ9eWO62v/BAl/1F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II/fwgzEgTTLgwLxBxtCSeVw/Vad/9aQJC6xUIie40cU/Iuki4UnKXuQrKJKq+zEuiGyY0hQ4b4DH09hdFN6wxAbuywUo9PZEJjLoOCLFvlvx/kUhilu4MpbarlfLNQOe+eT2pwFHXQGKYRusJX/tGgnLshqXJFAx8HEugUuOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QUYADNY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E70EC4CEEF;
	Mon, 12 May 2025 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072296;
	bh=ex0E5Nkjol5Uz6Q2pDH7Qvhr/HMZ9eWO62v/BAl/1F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUYADNY4+IgLxHHl7FXMGuDBr5FmByCs+qrUwx/f3smMRAFw0VWqf1+swpiAyzPUV
	 mYS1IFQk1AdoxbLljP6g1zBFoc4gAGX8hJmRvr7aM5fEs7b+NbFabc3YqLvYWycSIZ
	 /6+Flqjs5JjMpKj639Ub/hRqFKyTunmW9xkMcVqc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 164/197] nvme: unblock ctrl state transition for firmware update
Date: Mon, 12 May 2025 19:40:14 +0200
Message-ID: <20250512172051.062588548@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 650415fca0a97472fdd79725e35152614d1aad76 ]

The original nvme subsystem design didn't have a CONNECTING state; the
state machine allowed transitions from RESETTING to LIVE directly.

With the introduction of nvme fabrics the CONNECTING state was
introduce. Over time the nvme-pci started to use the CONNECTING state as
well.

Eventually, a bug fix for the nvme-fc started to depend that the only
valid transition to LIVE was from CONNECTING. Though this change didn't
update the firmware update handler which was still depending on
RESETTING to LIVE transition.

The simplest way to address it for the time being is to switch into
CONNECTING state before going to LIVE state.

Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Closes: https://lore.kernel.org/all/0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 150de63b26b2c..a27149e37a988 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4492,7 +4492,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_unquiesce_io_queues(ctrl);
-- 
2.39.5





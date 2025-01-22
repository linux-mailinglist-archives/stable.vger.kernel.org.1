Return-Path: <stable+bounces-110097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A1A18A38
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 03:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E38169816
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AB14A09C;
	Wed, 22 Jan 2025 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GogVAmSf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D40219FC;
	Wed, 22 Jan 2025 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514228; cv=none; b=hmI2/6W3KDNbz5GLD8/9LOO+sQhi5G+lVeqxzwAij+PL+Dm14WjZlgFR5sFU+u7FVO/ett/0FmpYK+mFdjleVCqbdoBsNjPrDDqscT+8amORwQccZ3c69ypegkREQryWN2kfzhWQZ7TYM19zAW63qDZ2PoQ1eGQAWQ8ZlCKIINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514228; c=relaxed/simple;
	bh=tSe8zq64GYFFDsH13XEnW64yDOeQMrGH+qPo7B8Ok28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnUUiW8rg+M1rzonz9e0u8W/FBixyWsQIzjKTRvNB9QMe1BWLFk2p9iXQsp3iNzIKzAfLkWOQvr+ih57L8qPmoXtwtt+uXd1dQ3bed+G90Va3yi1XpxdllGmX7oXE4Dr87cjSmlBwqDeMc4wL3HBfWuBP7i4YeaYxYn1YIPY8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GogVAmSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB21C4CEDF;
	Wed, 22 Jan 2025 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737514228;
	bh=tSe8zq64GYFFDsH13XEnW64yDOeQMrGH+qPo7B8Ok28=;
	h=From:To:Cc:Subject:Date:From;
	b=GogVAmSfJYD3c9wtlsfGAdufGgBuUZhlf+ZlgbQzv2dpLTY6oS1LpIks7fFXFy2A9
	 eJ4k8bkzWAArTIgzVmnDk3es/nlWXv6SFFHxfom5wEbQoLCYGvfVWYYZDqlSSyuW5L
	 +xlLC1DhuB+M6/vJFHn4PmyTOPClAsDYtramHrnL/meRTlU04pK2aeBcQC07/HE0vo
	 uxHHqE4489gQFlJiIy9RM8xYkVeByOWZSZuSw7L9XSmszjI80ddHxzmNhSwFLPMQ+H
	 dxNfQMNpMw5WJUnDyZwzF1Cvu5iHK2D0NoBIEGxg9Zae4ZDokESNRhyg+qJZMA3wxk
	 t3lh6DhyYupVA==
From: guoren@kernel.org
To: palmer@dabbelt.com,
	guoren@kernel.org,
	conor@kernel.org,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] usb: gadget: udc: renesas_usb3: Fix compiler warning
Date: Tue, 21 Jan 2025 21:50:13 -0500
Message-Id: <20250122025013.37155-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
directive output may be truncated writing between 1 and 11 bytes into a
region of size 6 [-Wformat-truncation=]
2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
                                    ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^

Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501201409.BIQPtkeB-lkp@intel.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index fce5c41d9f29..89b304cf6d03 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -310,7 +310,7 @@ struct renesas_usb3_request {
 	struct list_head	queue;
 };
 
-#define USB3_EP_NAME_SIZE	8
+#define USB3_EP_NAME_SIZE	16
 struct renesas_usb3_ep {
 	struct usb_ep ep;
 	struct renesas_usb3 *usb3;
-- 
2.40.1



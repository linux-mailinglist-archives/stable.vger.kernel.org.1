Return-Path: <stable+bounces-132659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC2A88B83
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963F11899D19
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1489289374;
	Mon, 14 Apr 2025 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="MOaTYnc/"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CC192D6B
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655992; cv=none; b=q2IlEwQ2EDuHzTDwi3mGvfCuM1BGnytemM4eYBbhA/fjzZLRZvskJ37ValIWjTYPrzpDn3nltcQvnlsVOqW1Z/ehC2hH9E7oty7C2jPTXM57vanYQT3qldZtDWBYcnreeup0bPJhqzxI+KeAwlZltxjQcI2oO5BUJe2f7fJAvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655992; c=relaxed/simple;
	bh=s2YUvKONZpYv6BeESkipXTOMCM3/ZgRQk8zLNK4GcdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zjohc6VLY85G3GlYTmjL1UfO91SrkFSXv9Id/K1ClUDQ8xkFiOpVQmpGnT98tH7lf8+y6Ngsl/PYo9ui5mX4aIT/+nqLJVCBTMeaZupwyTJ5NZ/ao0vNVuPGBOMQhC4YdEXa6+APVKNnS13AYvNr6qfO+Q1XTLKLk+7aFX1Hp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=MOaTYnc/; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 5888B1C0E87
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 21:34:34 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1744655674; x=
	1745519675; bh=s2YUvKONZpYv6BeESkipXTOMCM3/ZgRQk8zLNK4GcdM=; b=M
	OaTYnc/HQEO/PMwboMK+lWs/8VUDiRjPLpHBrTI0m5QUvdCVdVaHL6PpSvBrHl2e
	VbtW5TkXXKB1aM+938SKNRlF4bPYmG2QpIBRwC7X2pxzmJZCVZO43fk8Zs5XiBPP
	7Y3G33QkaVxLWCueFHo3aOPy2U9BsdtmG+rsQ/Gdc4=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YEfdvf58Kl_U for <stable@vger.kernel.org>;
	Mon, 14 Apr 2025 21:34:34 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 9EB5A1C08C3;
	Mon, 14 Apr 2025 21:34:15 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Juergen Gross <jgross@suse.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()
Date: Mon, 14 Apr 2025 18:34:01 +0000
Message-ID: <20250414183403.265943-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function xdp_convert_buff_to_frame() may return NULL if it fails
to correctly convert the XDP buffer into an XDP frame due to memory
constraints, internal errors, or invalid data. Failing to check for NULL
may lead to a NULL pointer dereference if the result is used later in
processing, potentially causing crashes, data corruption, or undefined
behavior.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/net/xen-netfront.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 8425226c09f0..e99561de3cda 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -987,6 +987,10 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	case XDP_TX:
 		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
+		if (unlikely(!xdpf)) {
+			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
 		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
 		if (unlikely(!err))
 			xdp_return_frame_rx_napi(xdpf);
-- 
2.43.0



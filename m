Return-Path: <stable+bounces-13381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC8837BD6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696F61F2A641
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C67154C16;
	Tue, 23 Jan 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W5y71uy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D46154C05;
	Tue, 23 Jan 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969403; cv=none; b=WVobAY+cisM0jI/nhEmPu56AwsggiMZTGWSBVU+/wj8eH1DxE0TFAhEQr5raDyIoo7yxTBxhTXZtn+HmIPLlUqVxR0QaSlEyw7Fh0hmSgP0aBzGjdkHIvfcE0DUl1h1WJ9A3TZoq1Vc+PkDAubiQYDcMObspWfMdSu/kBIPN784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969403; c=relaxed/simple;
	bh=igOXk0SW/A6ytzECeCSi8/1dqi2mRJpHSfGfQK+gu2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGNuhU4Eo4bW1q2bXJ+dOiJhrnWbKp82bxNOeDSgpUITkPQ9WesGsI24MFSbYT2+i6kPpy2RRr3ayCon4mQCUZNngyULmJWdM7ICq+sgQKKbNZ4KV9eEDa/YyEVHJMbSvTKeN4P1o2h6PE0AorRRzGPw43jse4MZlHDLnmGPsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W5y71uy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A37FC433B1;
	Tue, 23 Jan 2024 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969403;
	bh=igOXk0SW/A6ytzECeCSi8/1dqi2mRJpHSfGfQK+gu2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5y71uy+u8zov9zQ2Agnwx9vBzMeD/QFjlAVGufqasjlRzyeY6ngv+HkstsYaxAcT
	 EtuBFvYaBixlokpz0402yQGq3qvpdYKWDtnfmmOCioX08D3pb1iUVB3Kc3jE67KxLG
	 52syL4v1G88Bwaf1OuBcIZwiQJWLIIguQAnq1Ny4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 224/641] Bluetooth: btnxpuart: fix recv_buf() return value
Date: Mon, 22 Jan 2024 15:52:08 -0800
Message-ID: <20240122235824.947162742@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 94d05394254401e503867c16aff561d3e687dfdc ]

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return a negative number in case of issue, just print an error
and return count. Before this change, in case of error, the returned
negative number was internally converted to 0 in ttyport_receive_buf,
now when the receive buffer is corrupted we return the size of the whole
received data (`count`). This should allow for better recovery in case
receiver/transmitter get out of sync if some data is lost.

This fixes a WARN in ttyport_receive_buf().

  Bluetooth: hci0: Frame reassembly failed (-84)
  ------------[ cut here ]------------
  serial serial0: receive_buf returns -84 (count = 6)
  WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
  Modules linked in: mwifiex_sdio(+) ...
  CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
  Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
  Workqueue: events_unbound flush_to_ldisc
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : ttyport_receive_buf+0xd8/0xf8
  lr : ttyport_receive_buf+0xd8/0xf8
...
  Call trace:
   ttyport_receive_buf+0xd8/0xf8
   flush_to_ldisc+0xbc/0x1a4
   process_scheduled_works+0x16c/0x28c

Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btnxpuart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b7e66b7ac570..951fe3014a3f 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1276,11 +1276,10 @@ static int btnxpuart_receive_buf(struct serdev_device *serdev, const u8 *data,
 	if (IS_ERR(nxpdev->rx_skb)) {
 		int err = PTR_ERR(nxpdev->rx_skb);
 		/* Safe to ignore out-of-sync bootloader signatures */
-		if (is_fw_downloading(nxpdev))
-			return count;
-		bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
+		if (!is_fw_downloading(nxpdev))
+			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
 		nxpdev->rx_skb = NULL;
-		return err;
+		return count;
 	}
 	if (!is_fw_downloading(nxpdev))
 		nxpdev->hdev->stat.byte_rx += count;
-- 
2.43.0





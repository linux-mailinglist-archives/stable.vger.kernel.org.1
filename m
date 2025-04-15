Return-Path: <stable+bounces-132762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B9A8A3E0
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD7E3B92AA
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B3297A40;
	Tue, 15 Apr 2025 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRQmlYla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EF29A3CF;
	Tue, 15 Apr 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733726; cv=none; b=HD9FFY4sXCwwtaww4KdT6QjBHrR+ZZVkaQ7xhea4QOdQCqEEg2o1Kunv1qfLT8rBE2oydKcaid3d2Mw+u0qSt8DtKYfDs/3yy9P3br6NFiswT50KbSstksA1AxvvNsevkENg9JV++i+qbhAfsxe6jZxsQFlg6w5GvYknOnMTQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733726; c=relaxed/simple;
	bh=HQiKLDCl2eF/XpMkmuhblugmtzE528iSc40LM7GDCRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bzzrb7J+ougyHuYgcdspsSVT5hn7ZIejl4J/uqjSQusy6StTlVEKMZBaaVBGmv67MWtlewA2X5TMoNDcjj6CuHheozpnzlr5qQKrxSiw9NX4BMPYNtjJMPtx+PdFCnvmLSzfhztcX9K2kOxw6hz5ZUs5XbggFfMGWo0ctu4h85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRQmlYla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD940C4CEEB;
	Tue, 15 Apr 2025 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744733725;
	bh=HQiKLDCl2eF/XpMkmuhblugmtzE528iSc40LM7GDCRU=;
	h=From:To:Cc:Subject:Date:From;
	b=CRQmlYladOpjXHqqp0izQD+0500CErQvcsWiX39uwzr0g0wMWh7GNvb8jSCyPHwLf
	 Ey+q607FARhZYTO1ZHd9h7ZEmT7GfcOxQAYovM1iWH1kcu2p9jT55OqJI1C4f23Ktm
	 fbV8hPFy9Itcqpq9mprmE5rFz3vqvil9znbkQ/biM1PEsB9tS83hbjui9ffOtLtZ1K
	 fO+cAZSEbRph3igJL+Si/5TOsOK3dwwLhOc7Bx141DshRBSQL2PXl4BkJyobRL6kxx
	 kjhVC2PgbCe5euAOsoNWDkkcfcfDG+1dp8KgB0xpTNHXhpJhTLsfrqrcenmngOTreK
	 7UfV4xE9hHNVw==
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-bluetooth@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Manish Mandlik <mmandlik@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: vhci: Avoid needless snprintf() calls
Date: Tue, 15 Apr 2025 09:15:19 -0700
Message-Id: <20250415161518.work.889-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=kees@kernel.org; h=from:subject:message-id; bh=HQiKLDCl2eF/XpMkmuhblugmtzE528iSc40LM7GDCRU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOn/2sQyVMoN+q/5bOkRnq9z958wp0j1epvqbG2bCk6Tp l0zmBk6SlkYxLgYZMUUWYLs3ONcPN62h7vPVYSZw8oEMoSBi1MAJnK+i+F/+jyT5ymJV9Pitkyu e3fkm8TFna8Mfitv7A9d46U9ceatpwz/Y2xECqOO/OI0THNYdid/0t4fP26Jye+ctv4JU3BpnaA iIwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Avoid double-copying of string literals. Use a "const char *" for each
string instead of copying from .rodata into stack and then into the skb.
We can go directly from .rodata to the skb.

This also works around a Clang bug (that has since been fixed[1]).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401250927.1poZERd6-lkp@intel.com/
Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
Link: https://github.com/llvm/llvm-project/commit/ea2e66aa8b6e363b89df66dc44275a0d7ecd70ce [1]
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/hci_vhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 7651321d351c..9ac22e4a070b 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -289,18 +289,18 @@ static void vhci_coredump(struct hci_dev *hdev)
 
 static void vhci_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	char buf[80];
+	const char *buf;
 
-	snprintf(buf, sizeof(buf), "Controller Name: vhci_ctrl\n");
+	buf = "Controller Name: vhci_ctrl\n";
 	skb_put_data(skb, buf, strlen(buf));
 
-	snprintf(buf, sizeof(buf), "Firmware Version: vhci_fw\n");
+	buf = "Firmware Version: vhci_fw\n";
 	skb_put_data(skb, buf, strlen(buf));
 
-	snprintf(buf, sizeof(buf), "Driver: vhci_drv\n");
+	buf = "Driver: vhci_drv\n";
 	skb_put_data(skb, buf, strlen(buf));
 
-	snprintf(buf, sizeof(buf), "Vendor: vhci\n");
+	buf = "Vendor: vhci\n";
 	skb_put_data(skb, buf, strlen(buf));
 }
 
-- 
2.34.1



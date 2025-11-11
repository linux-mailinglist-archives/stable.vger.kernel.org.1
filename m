Return-Path: <stable+bounces-193509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6FC4A50C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A684A34BDAC
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8602330F7F6;
	Tue, 11 Nov 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYGFufIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9E30E0F6;
	Tue, 11 Nov 2025 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823350; cv=none; b=TbIS1+TqbRsjCSe5pyhOpi9yrhuBm+IzKoUMC2cJ0oW8fqtqcVFLylLp7IlUKu7fVm3NgJi0vvUrgqoU3IfW8WdJyMchUL3qWxL8U1BA6C2caogaVu54FR/LjI0lN7MLCWKtorgut4PdRx4sMMz+M8mfuLg3ZYsC5g4OhKnBGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823350; c=relaxed/simple;
	bh=U+3ef1XtRn0dVYpkfoQGcTy/UOQMjovy5li6hRcidxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkD/ggKbYWBG7BpCxrnzddKPTI+/nwdGGmRl56dlA9Gma6eEvCtiFotd7/tBoGlTT8W4WY07/Gpg4GizEnw43HlYZg07M4QD7ade179r7XuftwIAWJfD74p9tqo56Ww/HOxGaD2D1Q45ng1IVTs1jJRn7w+TupftO/J+aVpVg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYGFufIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D055BC113D0;
	Tue, 11 Nov 2025 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823350;
	bh=U+3ef1XtRn0dVYpkfoQGcTy/UOQMjovy5li6hRcidxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYGFufIp7rokV0w6bcAG7hsUpgWoIUhwpnQBY84Fs2V3iai1QXz8q1ykLu94rMV11
	 oryVAJwqQwCfPg/cKiJjKF6hW7MpJukV+zg/NTsFvtbsPRn3SZfgg4TukUIeLxn7qc
	 CnmtxlNW60vTZ6Vf4r7HfrjLRS109qQdcwSX5KtY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 281/849] selftests: drv-net: devmem: flip the direction of Tx tests
Date: Tue, 11 Nov 2025 09:37:31 +0900
Message-ID: <20251111004543.215963679@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c378c497f3fe8dc8f08b487fce49c3d96e4cada8 ]

The Device Under Test should always be the local system.
While the Rx test gets this right the Tx test is sending
from remote to local. So Tx of DMABUF memory happens on remote.

These tests never run in NIPA since we don't have a compatible
device so we haven't caught this.

Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20250811231334.561137-6-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/devmem.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 0a2533a3d6d60..45c2d49d55b61 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -42,9 +42,9 @@ def check_tx(cfg) -> None:
     port = rand_port()
     listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd) as socat:
-        wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port}", shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
@@ -56,9 +56,9 @@ def check_tx_chunks(cfg) -> None:
     port = rand_port()
     listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
 
-    with bkg(listen_cmd, exit_wait=True) as socat:
-        wait_port_listen(port)
-        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
+    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
+        wait_port_listen(port, host=cfg.remote)
+        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port} -z 3", shell=True)
 
     ksft_eq(socat.stdout.strip(), "hello\nworld")
 
-- 
2.51.0





Return-Path: <stable+bounces-167466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1FB2301F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAAA560DED
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DA2D46AC;
	Tue, 12 Aug 2025 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qddtr6mR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054232E972E;
	Tue, 12 Aug 2025 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020911; cv=none; b=Amwwr5nsnCCWvfWVU3dxlvaooVcsF+u5+NRnmW5DXxIbIUulK4LK0ZzLusscEf4xK/wV6iCyNkATVcIq9qqQVxI0nn7GGVIOGGDgW7P3TPUSH0G8PObY/9V/GYqxUsXd7IunB+yITUF9WhQDIMz7pQsKWnK1ac9b8XzSn27IREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020911; c=relaxed/simple;
	bh=SnT7n/a02pR2iaEVce4NYkLdcj0jHMtTdUmIK9yd7YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krYhvHc4UaD/X7C+TkJy4lwqF4syLU4JQAuo6OOV7PtaXZJtBODcWVtP+vDxoO1h1TfaV4nEt80JOc4HJYJikxNEpfci2Hpnv9MAeyIK9boJqxMiMT6yuskK8ivhbv57nnU1Z3jKI5a0VKZN7vpFDRtyL4avl6/xdAMchBqkWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qddtr6mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DCAC4CEF0;
	Tue, 12 Aug 2025 17:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020910;
	bh=SnT7n/a02pR2iaEVce4NYkLdcj0jHMtTdUmIK9yd7YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qddtr6mRmSCW4rGhTImB+xt3i9UXg7RcdGye4bUNhj7TbNC71mQ5lgaLVjHVijxL+
	 qzmArm9p6ySpnDEodSvKMLGClkP/25LnmBwoyEHjWrCNvrm9s5rq6cYBzoLrRqrGrk
	 NmqMUyTXdAFfjvQjYk6dMJwH6iqfx3reCZ+l+3I8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/262] usb: early: xhci-dbc: Fix early_ioremap leak
Date: Tue, 12 Aug 2025 19:27:00 +0200
Message-ID: <20250812172954.333967187@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit 2b7eec2ec3015f52fc74cf45d0408925e984ecd1 ]

Using the kernel param earlyprintk=xdbc,keep without proper hardware
setup leads to this:

	[ ] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
	...
	[ ] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
	...
	[ ] calling  kmemleak_late_init+0x0/0xa0 @ 1
	[ ] kmemleak: Kernel memory leak detector initialized (mem pool available: 14919)
	[ ] kmemleak: Automatic memory scanning thread started
	[ ] initcall kmemleak_late_init+0x0/0xa0 returned 0 after 417 usecs
	[ ] calling  check_early_ioremap_leak+0x0/0x70 @ 1
	[ ] ------------[ cut here ]------------
	[ ] Debug warning: early ioremap leak of 1 areas detected.
	    please boot with early_ioremap_debug and report the dmesg.
	[ ] WARNING: CPU: 11 PID: 1 at mm/early_ioremap.c:90 check_early_ioremap_leak+0x4e/0x70

When early_xdbc_setup_hardware() fails, make sure to call
early_iounmap() since xdbc_init() won't handle it.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Fixes: aeb9dd1de98c ("usb/early: Add driver for xhci debug capability")
Link: https://lore.kernel.org/r/20250627-xdbc-v1-1-43cc8c317b1b@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/early/xhci-dbc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 341408410ed9..41118bba9197 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -681,6 +681,10 @@ int __init early_xdbc_setup_hardware(void)
 
 		xdbc.table_base = NULL;
 		xdbc.out_buf = NULL;
+
+		early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
+		xdbc.xhci_base = NULL;
+		xdbc.xhci_length = 0;
 	}
 
 	return ret;
-- 
2.39.5





Return-Path: <stable+bounces-34997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7258941D7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC818B22899
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA94644C;
	Mon,  1 Apr 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzE3DfJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52141C0DE7;
	Mon,  1 Apr 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990001; cv=none; b=J1UdyacAJdA1DAFrKrnjez1/R9FMWPwUZZ6vk93wgk/sm8kqyWD0h819JEA6n2N1sHPXzledsWwAIUffQsnIkBhuO484zGtEk4/elUS9fnlFL9Sq7RjHo9/h8DYEBowWJi38ISnPcRHh3NFifizJH9RoPsThGwwtshHpX869qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990001; c=relaxed/simple;
	bh=Scozw4gdAvSn5fh4kAsB9LsG7FUCELy4U459+GQbKis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=morf15tyW3k7uXS/5XuC9dqE6r4VD6K7F7+T00BNmZ0G81YTS1j47yVDYWgXYY41PmVBvZKoO4QOV2oNe++n2HnybTw4owquy9b7zPahsiEKvJo2bDfEkviI73sQQsSO456Kmp/efwtQCy1b8y+DAT+M1Tpp+XvtlI9V1fGIJ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzE3DfJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A95C433F1;
	Mon,  1 Apr 2024 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990000;
	bh=Scozw4gdAvSn5fh4kAsB9LsG7FUCELy4U459+GQbKis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzE3DfJm3B1rhfAXc7GtmATgEA+CcXIpgI4htxdRSHc46K2sDC9lMpyDzDJ6jI70T
	 TDivaFiWp4Z1FDTuWChETx++Oo3ayECMsGqMrygZ8DunZU/3jzAGZLs8SOnxADpWri
	 ZQ9W0R8LtznqJHd2qQN0ApnLwuVHFVXHHus0+ReU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/396] wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}
Date: Mon,  1 Apr 2024 17:43:47 +0200
Message-ID: <20240401152553.250570955@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

[ Upstream commit e995f5dd9a9cef818af32ec60fc38d68614afd12 ]

This option is needed to continue booting with QEMU. Recent changes that
made this optional meant that it gets unset in the test harness, and so
WireGuard CI has been broken. Fix this by simply setting this option.

Cc: stable@vger.kernel.org
Fixes: 496ea826d1e1 ("RISC-V: provide Kconfig & commandline options to control parsing "riscv,isa"")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/wireguard/qemu/arch/riscv32.config | 1 +
 tools/testing/selftests/wireguard/qemu/arch/riscv64.config | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
index 2fc36efb166dc..a7f8e8a956259 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
@@ -3,6 +3,7 @@ CONFIG_ARCH_RV32I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
 CONFIG_SOC_VIRT=y
+CONFIG_RISCV_ISA_FALLBACK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
index dc266f3b19155..daeb3e5e09658 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
@@ -2,6 +2,7 @@ CONFIG_ARCH_RV64I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
 CONFIG_SOC_VIRT=y
+CONFIG_RISCV_ISA_FALLBACK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.43.0





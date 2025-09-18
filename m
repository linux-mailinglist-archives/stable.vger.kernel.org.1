Return-Path: <stable+bounces-167607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E7AB230D4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20519684C9D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4552FAC02;
	Tue, 12 Aug 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LgP1UEpn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7D2FA0DB;
	Tue, 12 Aug 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021386; cv=none; b=Ktcv3kQjHdpJfPe7HWIIDZ1QZAmjYWZBErw1fvZGYo/aMEL54ss4+mSQMdcrGFGxZSBm9LIksWUSjDEBRapuq8jTUtykSr5UrPVyqbpy5EeenQcztwBCx4vC8z/m23+noPeWoEu7l+VfbonOr5DPzZZIjCi8T6Gwx/Vw7V3aRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021386; c=relaxed/simple;
	bh=bMbGRzpw59ADrS9wyoapxWDBmI+r6T0Cihdb2ufN9zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXGT+Lhw3ASWqpftqwKXrctKqeGRF0ryZ+0HNKzbqAwj5pPIDnCD6uplFQufUExVgZTATi5wTvNdY489sMZKkURKnO94JL7F7bs4SoJST3GUeMqJQ8bS1Ao0VkICePIe5vWCXPxru7FdcqiXZGGrmZUzzLbHDwfgVVV9RUzNZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LgP1UEpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4FC4CEF0;
	Tue, 12 Aug 2025 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021385;
	bh=bMbGRzpw59ADrS9wyoapxWDBmI+r6T0Cihdb2ufN9zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgP1UEpnBZwly95pBElPK45UvQLg0c5Op6CLkpcU25atgVWR8nQz7W5442GAC5Dmx
	 KkPwdNc9DPbCF+YZkqUB8n5128pHHscqSGBAg2DWS3F9fLLr6M6xtEaoAYBuqytxKo
	 nQJd4OgnsXrJhCpMjzkhBDmq7UtoqFhBepQ6sSdM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 106/262] bpf/preload: Dont select USERMODE_DRIVER
Date: Tue, 12 Aug 2025 19:28:14 +0200
Message-ID: <20250812172957.604771197@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 2b03164eee20eac7ce0fe3aa4fbda7efc1e5427a ]

The usermode driver framework is not used anymore by the BPF
preload code.

Fixes: cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/bpf/20250721-remove-usermode-driver-v1-1-0d0083334382@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/preload/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/preload/Kconfig b/kernel/bpf/preload/Kconfig
index c9d45c9d6918..f9b11d01c3b5 100644
--- a/kernel/bpf/preload/Kconfig
+++ b/kernel/bpf/preload/Kconfig
@@ -10,7 +10,6 @@ menuconfig BPF_PRELOAD
 	# The dependency on !COMPILE_TEST prevents it from being enabled
 	# in allmodconfig or allyesconfig configurations
 	depends on !COMPILE_TEST
-	select USERMODE_DRIVER
 	help
 	  This builds kernel module with several embedded BPF programs that are
 	  pinned into BPF FS mount point as human readable files that are
-- 
2.39.5





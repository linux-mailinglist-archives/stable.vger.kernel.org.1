Return-Path: <stable+bounces-108933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8B7A12107
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1644B3AC218
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875201E98E3;
	Wed, 15 Jan 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7sTP9qL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B59248BCB;
	Wed, 15 Jan 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938292; cv=none; b=Uxp8czXxC/m4NOzKuJoMj62mEKrQfcI9AMJR/FkxyBEdDIAkkmH9Q11rz0PfsSHNW/+X2zxsOjagpr3W/w+HMxbPkbRltPy5u8s3hnZOmN4A3t383Ks4rr5/rTxp5pd1fMWpITeRrVkMw/l4X+IOQmrsPk4VSg6adWsq65JKyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938292; c=relaxed/simple;
	bh=TK7dTgpgB5+f46RRVtt/RL/gq7X8v/zc04Q5wQYDvHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0FUk2dYxLG8U8Me/HFhQ3FnL2HlgTXh5U10Zy4S2UA7gpd7l/HbF2Oa0s1kV1YyeNEmnDzLE5LAhT+OmvQOermC9I2/oplhre4uMuoH/vGuSspF+K1giQC/adQgnn8wLhUtdCox6HMxHWhkGgKmLobZpazNT58dkv0Ypq44Ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c7sTP9qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C161C4CEDF;
	Wed, 15 Jan 2025 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938291;
	bh=TK7dTgpgB5+f46RRVtt/RL/gq7X8v/zc04Q5wQYDvHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7sTP9qLvs8oyMuQ/rM8GRJnYcA2w5itAniPPDedzOdjA07PZAOYu982N/YzfMb96
	 JOEv/pHb74j1HiZhMpe0kAjKIjY0nX9v/9yaaMg09jUZtTHK//aANXQ9pPpV3geRkc
	 kVZHIIMknQBGBlXTFpPwLu1kcXawL0tclmDybH7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable <stable@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.12 140/189] tty: serial: 8250: Fix another runtime PM usage counter underflow
Date: Wed, 15 Jan 2025 11:37:16 +0100
Message-ID: <20250115103612.013750785@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit ed2761958ad77e54791802b07095786150eab844 upstream.

The commit f9b11229b79c ("serial: 8250: Fix PM usage_count for console
handover") fixed one runtime PM usage counter balance problem that
occurs because .dev is not set during univ8250 setup preventing call to
pm_runtime_get_sync(). Later, univ8250_console_exit() will trigger the
runtime PM usage counter underflow as .dev is already set at that time.

Call pm_runtime_get_sync() to balance the RPM usage counter also in
serial8250_register_8250_port() before trying to add the port.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
Cc: stable <stable@kernel.org>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20241210170120.2231-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -812,6 +812,9 @@ int serial8250_register_8250_port(const
 			uart->dl_write = up->dl_write;
 
 		if (uart->port.type != PORT_8250_CIR) {
+			if (uart_console_registered(&uart->port))
+				pm_runtime_get_sync(uart->port.dev);
+
 			if (serial8250_isa_config != NULL)
 				serial8250_isa_config(0, &uart->port,
 						&uart->capabilities);




Return-Path: <stable+bounces-128071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF9FA7AEEA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49E418924D1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EB3227B95;
	Thu,  3 Apr 2025 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLZZWNUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DE22759C;
	Thu,  3 Apr 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707896; cv=none; b=asfo0K8QooJFAE48rtAPomyv9cyL6n83dvcoH+lYHmCwDmkWcJoHfEQCawmcU3EUga31Z7wVw10tcOdCEz0f2EcruUA4UpDFB+zde/wj3RLuLLgiYMm7zX+Y7uvpot/jWM17sesFhZQxGTqycW1M2scoxaet64pmSDD+0anFgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707896; c=relaxed/simple;
	bh=0VF2LzGBub+hBJUyzP6SWup11ZhL4r4nVCB1/CkpoRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilfkK8W1m6bT7IVpqTpmFTP5Jkm5/VZQdLBA8mH0wi+purZvYPhLZ7RM2BkF3BBPeAVWNNNuKwJGLgjDgJN6GwNrZXo4lh/0IfvpsRzK5pTLa/i77Hq3irNYGsHKzhF6T1U2UzQLfD0R8mzLGgIsghhJJDTpqoEQ0yDyP95JN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLZZWNUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE9AC4CEE9;
	Thu,  3 Apr 2025 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707895;
	bh=0VF2LzGBub+hBJUyzP6SWup11ZhL4r4nVCB1/CkpoRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLZZWNUzVasSsdmtkU5OQPIHL17yvWsSyuqUA09k3fYpIGvDrk28AfPz1oLg+lS6t
	 HAD5GpHvQNd7jWDRJGHYkoamaxe9Qi0D14NdWPHJ1C9SgH+oVt591GlQakcsycGEuE
	 dWjHknYwnpW54x5t3PD1s/VTDEl5tj3qYHSi013HDo5C/sulejqgAKbjYMo0gddua+
	 ewORUFhEkhaH1hPjpK6NfZ8dtLTKQWn0meXgxPaiMqg3Zidbq8WuOFEboeu5kaf4hU
	 sHZ8wHQRfX6rZpiYbbRiOsN2lCJXBsWyYXTfEBaO1p/7qvb7vIVyqDibB/A6QmZ373
	 QdY3eJWcDHKyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan McDowell <noodles@meta.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	peterhuewe@gmx.de,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 33/33] tpm: End any active auth session before shutdown
Date: Thu,  3 Apr 2025 15:16:56 -0400
Message-Id: <20250403191656.2680995-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Jonathan McDowell <noodles@meta.com>

[ Upstream commit 1dbf74e00a5f882b04b398399b6def65cd51ef21 ]

Lazy flushing of TPM auth sessions can interact badly with IMA + kexec,
resulting in loaded session handles being leaked across the kexec and
not cleaned up. Fix by ensuring any active auth session is ended before
the TPM is told about the shutdown, matching what is done when
suspending.

Before:

root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
root@debian-qemu-efi:~# systemctl kexec
…
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
- 0x2000000
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#
(repeat kexec steps)
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
- 0x2000000
- 0x2000001
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#

After:

root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~# kexec --load --kexec-file-syscall …
root@debian-qemu-efi:~# systemctl kexec
…
root@debian-qemu-efi:~# tpm2_getcap handles-loaded-session
root@debian-qemu-efi:~# tpm2_getcap handles-saved-session
root@debian-qemu-efi:~#

Signed-off-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e526..87f01269b9b53 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -300,6 +300,7 @@ int tpm_class_shutdown(struct device *dev)
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
+			tpm2_end_auth_session(chip);
 			tpm2_shutdown(chip, TPM2_SU_CLEAR);
 			tpm_chip_stop(chip);
 		}
-- 
2.39.5



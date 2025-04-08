Return-Path: <stable+bounces-129760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB1A80101
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0605A188A86A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236D26A0AB;
	Tue,  8 Apr 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NokqpFHz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0611269831;
	Tue,  8 Apr 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111905; cv=none; b=ZKAtJy9xst131MDZPPTmI4UkPPzm8JMq7xUhFbr6GiIhz/UMJl8NUchDq2aTTPKyJ7cXjCXxPjSg/jlWvOOsPLn2U8wMVx87by0Ua9x4/dtLi6YeFeJB5TXPSsxTJXvO4cE9tUA8WJhJdBFJu43yW6K+CSj1hnvT/TYHfM8ffLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111905; c=relaxed/simple;
	bh=0njutHfedylVy8SzqV6EQRS9NW8obyWYjFXT5XWNbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0PleQK33GRM+xDzc+isYF6BL0ylG6CkyfP0S+0plA2btmT4Mg8e1ocUZS1VIBpcukvu4eEOjDyzXpxNSrO1MzsKNG9JBSvvaIntHZ6FryckA+De+AeITG9p1dCe54G4RkjQDiUMZQIDodbtM23giSCkfvN5qQAO4RlAbfbCQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NokqpFHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDAFC4CEE5;
	Tue,  8 Apr 2025 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111905;
	bh=0njutHfedylVy8SzqV6EQRS9NW8obyWYjFXT5XWNbOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NokqpFHzBvOs/gOJqLbGKF/SCOkrZGQefoR+SJUPrfRXf8zXiYP5TTSyZ4IShhr4Y
	 wgYXnbIy3JpWS00WTHfvwv4OyElHor8RtUoAJAarQQZVV8snokCuevvlpErPJPNB+J
	 hiI5DPaCncSaiY6N66hKdfVmvc/S5IFKFkeyX2ho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 604/731] riscv/purgatory: 4B align purgatory_start
Date: Tue,  8 Apr 2025 12:48:21 +0200
Message-ID: <20250408104928.322312192@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 3f7023171df43641a8a8a1c9a12124501e589010 ]

When a crashkernel is launched on RISC-V, the entry to purgatory is
done by trapping via the stvec CSR. From riscv_kexec_norelocate():

  |  ...
  |  /*
  |   * Switch to physical addressing
  |   * This will also trigger a jump to CSR_STVEC
  |   * which in this case is the address of the new
  |   * kernel.
  |   */
  |  csrw    CSR_STVEC, a2
  |  csrw    CSR_SATP, zero

stvec requires that the address is 4B aligned, which was not the case,
e.g.:

  | Loaded purgatory at 0xffffc000
  | kexec_file: kexec_file_load: type:1, start:0xffffd232 head:0x4 flags:0x6

The address 0xffffd232 not 4B aligned.

Correct by adding proper function alignment.

With this change, crashkernels loaded with kexec-file will be able to
properly enter the purgatory.

Fixes: 736e30af583fb ("RISC-V: Add purgatory")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20250328085313.1193815-1-bjorn@kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/purgatory/entry.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0e6ca6d5ae4b4..c5db2f072c341 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -12,6 +12,7 @@
 
 .text
 
+.align	2
 SYM_CODE_START(purgatory_start)
 
 	lla	sp, .Lstack
-- 
2.39.5





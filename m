Return-Path: <stable+bounces-84371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF94699CFE0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD37B2092E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8C1B4F14;
	Mon, 14 Oct 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkSk8Two"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28881ABEA1;
	Mon, 14 Oct 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917777; cv=none; b=tQf5vSLWCH4LjtNPLSuNO+2v0bMLyIRs7tQFM2Jor77e2doyMnObsWia63MFM1dUl+LDU0rY3hEUEKDNaJm5bUJ7lpxGVj8989QeBtRYhyAl+0GgcMHxOGhkiqTH6tRAbJ/pogz9b0FeMH/v0GZpUl8SWPTBYQqmmqqyFZs/rSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917777; c=relaxed/simple;
	bh=oUUWw7F2HhziOK559nptQdI8SNKdcIvutQPoVVzfbBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb0nYByRF2xGYw7fxxBvmjlSCqQHvzu06DCO2V7kwn5Nh6rTs3aKzyVt/59I717JaYterBA6HF6psJaP88N2DjFuKEVATrek2IOIvoVT/ERbEQy+kxbXPHimgKyxD4qrNDsUqEWQhbQpqRvqtySU+/1Veof27syfSPyDUwcxtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkSk8Two; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFCAC4CEC7;
	Mon, 14 Oct 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917777;
	bh=oUUWw7F2HhziOK559nptQdI8SNKdcIvutQPoVVzfbBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkSk8Twoz/JD+hvj2Z1jHitKIRMhcfRpVbLTghc5dS6fXY8LrT1rSMXVA1GOUFywK
	 di8T9Ylx2ZpWAJZTRxERsyQdDH1hAcnE3xakR/d2ng1/z94Il+iJAVyfCZpVsAK1uY
	 I8ZnqWy3xF0mdLmdfpa2CDdDYU3fNeCzcvcLW2iA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Jan Beulich <jbeulich@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/798] xen: use correct end address of kernel for conflict checking
Date: Mon, 14 Oct 2024 16:11:26 +0200
Message-ID: <20241014141223.107663466@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit fac1bceeeb04886fc2ee952672e6e6c85ce41dca ]

When running as a Xen PV dom0 the kernel is loaded by the hypervisor
using a different memory map than that of the host. In order to
minimize the required changes in the kernel, the kernel adapts its
memory map to that of the host. In order to do that it is checking
for conflicts of its load address with the host memory map.

Unfortunately the tested memory range does not include the .brk
area, which might result in crashes or memory corruption when this
area does conflict with the memory map of the host.

Fix the test by using the _end label instead of __bss_stop.

Fixes: 808fdb71936c ("xen: check for kernel memory conflicting with memory layout")

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8db26f10fb1d9..46a2cb782ab7d 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -853,7 +853,7 @@ char * __init xen_memory_setup(void)
 	 * to relocating (and even reusing) pages with kernel text or data.
 	 */
 	if (xen_is_e820_reserved(__pa_symbol(_text),
-			__pa_symbol(__bss_stop) - __pa_symbol(_text))) {
+				 __pa_symbol(_end) - __pa_symbol(_text))) {
 		xen_raw_console_write("Xen hypervisor allocated kernel memory conflicts with E820 map\n");
 		BUG();
 	}
-- 
2.43.0





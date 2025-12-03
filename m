Return-Path: <stable+bounces-199066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8863C9FF34
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E1230265DE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5719F35295C;
	Wed,  3 Dec 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h+7uxWWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBA3128CC;
	Wed,  3 Dec 2025 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778586; cv=none; b=K/wi2BlP+k32GOzRLxDNdLdgTmsVnkDXHq31r3wH5t2fSzUT0AZ8n65at1Fh9WyHI8l9Ib85ntOzOPbYtot/Nt+aaTi2SUfBeS3QyH3a5gBmnzZBcUHVh0iQDB4nNZuniqzETnsIYK0QlKwZ/R6F+CG07dx32HtV3vNBc6XnQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778586; c=relaxed/simple;
	bh=b7wpGmqppmgkGf+3uAebo0ar21M3idHJ+FjyWhq2qyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huFqKnK3PQGRFp0MBrvx/AeRUIU82UsOUY591lHqJ/z2CFOQkRqaIro1s3j1vcgzTnAbkFf3g3lRGv2O34RpxlVNC1sTTg3441E51Vf4WIhfoji9Ez1R36MwOYK+bFy392F4w5gLaWBMvX+cEx0iST/sTFpJuazolt4gt52YIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h+7uxWWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C81C4CEF5;
	Wed,  3 Dec 2025 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764778585;
	bh=b7wpGmqppmgkGf+3uAebo0ar21M3idHJ+FjyWhq2qyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+7uxWWXwOSXGJ+5qIO+s1uK7RjpVO4JqM0yHZF0PUENO2H+KAFdntO/i1tPUZnIh
	 tvD7X6TIJulA6DBZPfkQR5Vzv3EKr7SPwVgcsazagYYkfFTL3udVc8zZk+M733rbqX
	 S7ydXiF39pDqiW9CkDvAtgVPCGfakGLvCuhsUbc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Amjad OULED-AMEUR <ouledameur.amjad@gmail.com>
Subject: [PATCH 5.15 391/392] libbpf, riscv: Use a0 for RC register
Date: Wed,  3 Dec 2025 16:29:01 +0100
Message-ID: <20251203152428.580170269@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yixun Lan <dlan@gentoo.org>

commit 935dc35c75318fa213d26808ad8bb130fb0b486e upstream.

According to the RISC-V calling convention register usage here [0], a0
is used as return value register, so rename it to make it consistent
with the spec.

  [0] section 18.2, table 18.2
      https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf

Fixes: 589fed479ba1 ("riscv, libbpf: Add RISC-V (RV64) support to bpf_tracing.h")
Signed-off-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Amjad OULED-AMEUR <ouledameur.amjad@gmail.com>
Link: https://lore.kernel.org/bpf/20220706140204.47926-1-dlan@gentoo.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/bpf/bpf_tracing.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -207,7 +207,7 @@
 #define __PT_PARM5_REG a4
 #define __PT_RET_REG ra
 #define __PT_FP_REG s0
-#define __PT_RC_REG a5
+#define __PT_RC_REG a0
 #define __PT_SP_REG sp
 #define __PT_IP_REG pc
 




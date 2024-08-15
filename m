Return-Path: <stable+bounces-68653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C695335A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB45285D64
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51321A76AB;
	Thu, 15 Aug 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXOFY6XB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CD19F473;
	Thu, 15 Aug 2024 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731243; cv=none; b=JN0tLWX3YAe6K0Xz9cfrnuk0ECX5RQ5JFIqt8SEjAztxsSTlfNUqFw0ZTkfwTosfRQtHjGuEwNFdLabsCE7Dv+Z6Z2+PYrPd3dCqmoabeCoW5v+vo5FF/Sr7CYRRAHlrhGDTub9ICvfwKOC08Fwf9uRul11wO8OcogbivFM53A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731243; c=relaxed/simple;
	bh=7XTa9wUuqIWCOmPaXlXQCut4zCWGELckwLhoq4x33q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg3nFTd+LXlDGa0gQILOEtzWCELh4JmP3kevTM8jFCL94Mcaj6ipmKNYPJUjpU3pV1xRIxejVRu5ZxMnpVmrLBNodowZT1JdMISGWGMDcPVkKheXwTkKi4hwgrU4SwjWvw63V0AY2pu/ZnRcnpuU56fPPZegw/so0RUQC98LiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXOFY6XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBCAC32786;
	Thu, 15 Aug 2024 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731243;
	bh=7XTa9wUuqIWCOmPaXlXQCut4zCWGELckwLhoq4x33q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXOFY6XBLROgZIgxt41Tpak2zwGUkH8yF+doorIzUOWKlAlMn+CVuWu0fzFn282Qw
	 9XSNUb4lluXar84xio1TSJG+rpkD8bBzPAQfyBUFaaj0AyauuV30jdAb8RjzoWLLU+
	 M1nBSXM3L5Hrd58FgnCN77WQKlJJqKqcOh+Bytp4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/259] m68k: cmpxchg: Fix return value for default case in __arch_xchg()
Date: Thu, 15 Aug 2024 15:22:39 +0200
Message-ID: <20240815131903.807660676@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@toblux.com>

[ Upstream commit 21b9e722ad28c19c2bc83f18f540b3dbd89bf762 ]

The return value of __invalid_xchg_size() is assigned to tmp instead of
the return variable x. Assign it to x instead.

Fixes: 2501cf768e4009a0 ("m68k: Fix xchg/cmpxchg to fail to link if given an inappropriate pointer")
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/20240702034116.140234-2-thorsten.blum@toblux.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/include/asm/cmpxchg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 38e1d7acc44dc..1f996713ce876 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -33,7 +33,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		x = tmp;
 		break;
 	default:
-		tmp = __invalid_xchg_size(x, ptr, size);
+		x = __invalid_xchg_size(x, ptr, size);
 		break;
 	}
 
-- 
2.43.0





Return-Path: <stable+bounces-90169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EBA9BE704
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3B9285110
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B71D5AD7;
	Wed,  6 Nov 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPUSATlk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB971DE3B8;
	Wed,  6 Nov 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894974; cv=none; b=XvU3X3lU+mMHlu5277ZFXZra+E/Ds9ndfkWb236UvpQmbsd0FCGa/uXP2GYAHzYtaO7xP4CXMwHTiACip6TGMLZnFSzkXdh+yNpWJurE+07Rl0WU/Xk/wJ0cXHpmqOhn7xYqrKebDUsSoHB4xki+7Q/j5xiijg4FozoPK/eg3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894974; c=relaxed/simple;
	bh=R5/V3Q2dTBZZy5qZKSEknTni53372Z6bn6vLI18/adM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHEMrtOPjY+WRbCfL/5lJnFJshUA8uGHXhkHcvEy3U4VSuMtafWAO9yoH45BqcjgEH9aMRDwVeUJydkeNPxGFfzR7BHB/vyecg/lXP0BlqtTGNDliyEkaiPL2UHYWs/CryX5lLxZIoJhnQdwnVZUG21/+cLIhz8zEvq+XGIgqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPUSATlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7566C4CECD;
	Wed,  6 Nov 2024 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894974;
	bh=R5/V3Q2dTBZZy5qZKSEknTni53372Z6bn6vLI18/adM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPUSATlkqZ9x0r/pRaw0KzwoXzeG/0nXwhw0COD7pNKpDi4jf/F4BYSeroLp/KiFA
	 j5LKrSVJZphE+HJgaPLHbgEBXMoU+ev80wuk1+zES5ivvjeGUlacWxZiJ8pnxPoWiz
	 lWtbjpvDN7OItd9Z5Uuvasx8BHquowJiXGeWoEdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Jan Beulich <jbeulich@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/350] xen: use correct end address of kernel for conflict checking
Date: Wed,  6 Nov 2024 12:59:51 +0100
Message-ID: <20241106120322.447186555@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 075ed47993bbf..69fd1134b7fcf 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -862,7 +862,7 @@ char * __init xen_memory_setup(void)
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





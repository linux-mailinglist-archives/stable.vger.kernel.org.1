Return-Path: <stable+bounces-3472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A87FF5D1
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03008B20D81
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D13482DC;
	Thu, 30 Nov 2023 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ucYJhYWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDB54FA4;
	Thu, 30 Nov 2023 16:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E25C433C8;
	Thu, 30 Nov 2023 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361920;
	bh=bK6F9Z29i3hLWXAKP8s23VrROVNSfBftxRATnRp+T0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucYJhYWOYeRpZ0YnXtfHU+k9H8BuNf1n+Wy0gTrtvJ3ZmXn5QsReT9irANuHsyFxM
	 352mKSRt958Aueal6IwSuTCav631XH2fIFxaIHm2YdxfIvWqB0HbvWfX/izAmu/t1g
	 pVRGzAcxUOrSfgwx+5/7K/gxzBk0+YTZxm5VCZjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Stabellini <stefano.stabellini@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 16/69] arm/xen: fix xen_vcpu_info allocation alignment
Date: Thu, 30 Nov 2023 16:22:13 +0000
Message-ID: <20231130162133.615667622@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Stabellini <sstabellini@kernel.org>

[ Upstream commit 7bf9a6b46549852a37e6d07e52c601c3c706b562 ]

xen_vcpu_info is a percpu area than needs to be mapped by Xen.
Currently, it could cross a page boundary resulting in Xen being unable
to map it:

[    0.567318] kernel BUG at arch/arm64/xen/../../arm/xen/enlighten.c:164!
[    0.574002] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP

Fix the issue by using __alloc_percpu and requesting alignment for the
memory allocation.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>

Link: https://lore.kernel.org/r/alpine.DEB.2.22.394.2311221501340.2053963@ubuntu-linux-20-04-desktop
Fixes: 24d5373dda7c ("arm/xen: Use alloc_percpu rather than __alloc_percpu")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/xen/enlighten.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 27277d6bbfa5a..59de416c61a30 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -359,7 +359,8 @@ static int __init xen_guest_init(void)
 	 * for secondary CPUs as they are brought up.
 	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
 	 */
-	xen_vcpu_info = alloc_percpu(struct vcpu_info);
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+				       1 << fls(sizeof(struct vcpu_info) - 1));
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
-- 
2.42.0





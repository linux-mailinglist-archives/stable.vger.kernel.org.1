Return-Path: <stable+bounces-69056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CD953538
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0D1F2A7A5
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172619FA90;
	Thu, 15 Aug 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDHB8jzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD117BEC0;
	Thu, 15 Aug 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732523; cv=none; b=eDynzvT0zPObCOepdrrkjPVOmNUurI+TPqtoAMzIFBJg6uxoX7oAm1AvmRDM5fOgs5FEpR660ouh3c5rqT6xM58V1kKSO2ymCp2TICRKb4Q88SW51PexH7OAdMJOilN6RJ88uwwgc4jmkBUGpvUdOGRmYxUp4KIhO2+aiqJonz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732523; c=relaxed/simple;
	bh=3AptlZz955Ij+jyziNkdDq1zm+R0Ror5jaHFtqamHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZemVRspeIlaxdxiY/GQV8qMiQHjUtE5JpLGpjdk6fx2+WsdG/1Of/Y4GFYpiHhnBKrtYAeOcDq58WWHYYW3v2jOuCIEdlDponjRzThJjg+fXhmfNtf4cSZ0Dxx8FGcuSy/TOwwzOx+EfBbrXT206N3TbUOE/Djrbjxlf3GSmII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDHB8jzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E188C4AF0D;
	Thu, 15 Aug 2024 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732523;
	bh=3AptlZz955Ij+jyziNkdDq1zm+R0Ror5jaHFtqamHsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDHB8jzN9iVTrjot99fT1R1YEbFbUNoayd6mHW5tOqzT+WSkOgMah3Lfky9gzb5So
	 m8Xmv3kpP+3paf+q9jUnrO08Rm4YmPvfqWt/6NoZ83bM2MVwr8AYrPSr5KaZzNJnJy
	 KM9cZY+7Prs9sglzNdUv+9Jcf8T11z8g3Ml3baHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 205/352] powerpc: fix a file leak in kvm_vcpu_ioctl_enable_cap()
Date: Thu, 15 Aug 2024 15:24:31 +0200
Message-ID: <20240815131927.198057699@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit b4cf5fc01ce83e5c0bcf3dbb9f929428646b9098 ]

missing fdput() on one of the failure exits

Fixes: eacc56bb9de3e # v5.2
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/powerpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ef8077a739b88..0f5ebec660a78 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1956,8 +1956,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			break;
 
 		r = -ENXIO;
-		if (!xive_enabled())
+		if (!xive_enabled()) {
+			fdput(f);
 			break;
+		}
 
 		r = -EPERM;
 		dev = kvm_device_from_filp(f.file);
-- 
2.43.0





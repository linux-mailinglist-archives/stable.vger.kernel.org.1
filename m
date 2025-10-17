Return-Path: <stable+bounces-187438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0232BEA45F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B94D25A10E3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB104330B2E;
	Fri, 17 Oct 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1U1L5PgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CF330B28;
	Fri, 17 Oct 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716072; cv=none; b=YxbT8w/3cTeocU9vEz0BR7+ttBwjCjoNB/r7FmhWurGhHaJtUIXOtd5p/c7KRVZmOygYuEDNp54+SI3KDLH1DciMLucTU+jdSYfiKoSYJ3/AXDwegVtyTY/ymTV7j9Pd1OOoxmWAP7qim7f8oHXRItajKJd4A7DXbycg0djitsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716072; c=relaxed/simple;
	bh=YTiO+OxLOe4wAkPS6GNc7pTCXsgDGhZ9k93vbTu+yfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MibavAKEDmMewUM7bUoABfSvxrVJcAyRCCBFRsjDXo367Vyz9TM1KAd9XDATxfiNh7sbXzZxb32/d/EQmHiKZga0akKenpZjeYsm8ix5YiOyumA/m3NUCueLV3Vq34+j6I+BnKb6eK6eBfK54e3QBXGgJ/DGn0t15UvxUz+nYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1U1L5PgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61D4C4CEE7;
	Fri, 17 Oct 2025 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716072;
	bh=YTiO+OxLOe4wAkPS6GNc7pTCXsgDGhZ9k93vbTu+yfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1U1L5PgJVofZfjBhey9mEmmzIaGyP/tz0avyt0UchN21G97ncEphCD7WCYllfz1uY
	 vCA6CaQAWcirGo3lMU9jC3MyKnfYRN3Fnsl55Rq+bAWxj43N2xNFuE3UuPjBiCCcGJ
	 i4leQHoSASp1jiFcW1DuWe2Arh3rje41kkhtk4pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/276] drm/amdkfd: Fix error code sign for EINVAL in svm_ioctl()
Date: Fri, 17 Oct 2025 16:52:36 +0200
Message-ID: <20251017145144.789745805@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit cbda64f3f58027f68211dda8ea94d52d7e493995 ]

Use negative error code -EINVAL instead of positive EINVAL in the default
case of svm_ioctl() to conform to Linux kernel error code conventions.

Fixes: 42de677f7999 ("drm/amdkfd: register svm range")
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7f55decc5f37b..d21bebfa884ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3228,7 +3228,7 @@ svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
 		r = svm_range_get_attr(p, start, size, nattrs, attrs);
 		break;
 	default:
-		r = EINVAL;
+		r = -EINVAL;
 		break;
 	}
 
-- 
2.51.0





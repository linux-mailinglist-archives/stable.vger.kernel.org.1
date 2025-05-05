Return-Path: <stable+bounces-140240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1BEAAA675
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A7A1886652
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB13272BB;
	Mon,  5 May 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEIy25wv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398D3272AF;
	Mon,  5 May 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484482; cv=none; b=c1+mlZlySe60aM2g4HVr7FpiVx8yieChoYpHNyV7xu+JKgpg8i4983ArieO6uexKd2CROCCB2ADNeZVOyTwJP6BB82e2U7xEZCXbW0MJMGtUk3qXkQ5mIFVscROn7jRRb1g6misYoh+V5xBbUx//BJ295fjQKZwJ+YIThVg0ofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484482; c=relaxed/simple;
	bh=DYs97fnCcKXqsXxMsXf3adT5nR9m4ohxW0ZVfVou3XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+SXz1jkUzoRD8jaoJwJXxct5fBb0BnBS+qrVW5+41eloF2FYCyJ4Y8AxYbDbWSsiqrpJPkHqfmDAiGqMevZnunvaJLOnA+7z/oxxQOqQ/xHnEFq8iZ6eUdmTXXabOqupUdMIa+0rAgtYSRg8VfN9Q9a9Xo/yOA1CjZRecvJbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEIy25wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B509C4CEF1;
	Mon,  5 May 2025 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484482;
	bh=DYs97fnCcKXqsXxMsXf3adT5nR9m4ohxW0ZVfVou3XI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEIy25wvn8Qm6lJ6S85Qfa1sj9y+R3YNhbceGymgku944wRODqQgbcBFHBrZ/mV4+
	 CTw/2HbGxrCGopIOHJfuytNG5R1p6Z3BM91m3ntzFQpacf9qkvSp8au4Xe5CB7KivT
	 sqBk6n9rqBSGWn75DK0k4g6TycAyMEvj8cKGeoXj8sEfu6ZGys1d2ZV2RQBbVi25cz
	 8PPfwNDt4mWmfprzYh6ndkTMfn22AkZFBmleQkZRMX+WHaFVpoTRXmdq4DmNgQwea2
	 c4dXUqHRJojh+DVFHTazHaSgeHySachB16o/aTEgUB6WOT2UG92C7C4zs4dkWILaL7
	 6NWIxLqRfmIqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 492/642] xfrm: prevent high SEQ input in non-ESN mode
Date: Mon,  5 May 2025 18:11:48 -0400
Message-Id: <20250505221419.2672473-492-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit e3aa43a50a6455831e3c32dabc7ece38d9cd9d05 ]

In non-ESN mode, the SEQ numbers are limited to 32 bits and seq_hi/oseq_hi
are not used. So make sure that user gets proper error message, in case
such assignment occurred.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 82a768500999b..b5266e0848e82 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -178,6 +178,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay seq and seq_hi should be 0 for output SA");
 			return -EINVAL;
 		}
+		if (rs->oseq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay oseq_hi should be 0 in non-ESN mode for output SA");
+			return -EINVAL;
+		}
 		if (rs->bmp_len) {
 			NL_SET_ERR_MSG(extack, "Replay bmp_len should 0 for output SA");
 			return -EINVAL;
@@ -190,6 +196,12 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 				       "Replay oseq and oseq_hi should be 0 for input SA");
 			return -EINVAL;
 		}
+		if (rs->seq_hi && !(p->flags & XFRM_STATE_ESN)) {
+			NL_SET_ERR_MSG(
+				extack,
+				"Replay seq_hi should be 0 in non-ESN mode for input SA");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
-- 
2.39.5



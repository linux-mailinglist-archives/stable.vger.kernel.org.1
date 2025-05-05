Return-Path: <stable+bounces-140371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D2AAA7F4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC73164D24
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863F295521;
	Mon,  5 May 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiGvS4EQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AE34451D;
	Mon,  5 May 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484712; cv=none; b=fPOXeALR0zohxQ7AfhGVkjI8K9MyUW2BIqr/oYKPK/lpYW2Er13jjA9kT6DqheXFNfYsZIK51U1J/9hz3vn3tFbqgXYRIEXNR2lp8h9Wr7ZWKtDHMF9pVzexpPtz1wsEX/RZhyT5WZ7faGmoMnrCmY/gnmuQ2w1pEnAeIKl5pgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484712; c=relaxed/simple;
	bh=xzIqIZgerJnM3pWkDT5WnBHc7fyqGwyOl3LIJ3Oq8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXGhQWwVKfSWzVqI+Diy7rvrsz2wojnOC3S0qYXTOAglpXGHbsa5nLjlfXKTTA2v5KeyC5xdt5Vl/FE4zTmu0fka1MVeqwLuCYEPHTdIemGwRfmuCezUgQNqgxBCRqTxHdIIrk0+Ectc5S22rvhIIsH38qLS7Cb/U+ieD5RPYQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiGvS4EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C900C4CEE4;
	Mon,  5 May 2025 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484712;
	bh=xzIqIZgerJnM3pWkDT5WnBHc7fyqGwyOl3LIJ3Oq8mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiGvS4EQ/y45WGtX6VQ/ploUhIU20XXDdG+i4Duby8/eFyX7Ih+8SuopylJzEtP0H
	 FAyxkJ8Q87Wp0SQRjEWz5zJjiQjdofOvwkv0pJTfkCRnpAgWyaXuF0BCREkODZDj40
	 Es69ll1tR1SS+L/VqSYBYJmG7PMav4OyeimLtn60oKN/7wyZW+VvZXWf9ipGWIqhXp
	 n9RrksOiMBrX8EQ01s/2kek0ag88q5NJSwazD9uSCYVWFIbZpdmXPxLIx5pIgAdnh1
	 AVObUYAw704ueYcVhniwsMnbSZU9hT1dDgyxyP+wGWXXDH1c5pZtnGIrd9HMq0MRat
	 cxCw2PxvzD4Tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	miquel.raynal@bootlin.com,
	Frank.Li@nxp.com,
	yschu@nuvoton.com,
	linux-i3c@lists.infradead.org,
	imx@lists.linux.dev,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 622/642] i3c: master: svc: Fix implicit fallthrough in svc_i3c_master_ibi_work()
Date: Mon,  5 May 2025 18:13:58 -0400
Message-Id: <20250505221419.2672473-622-sashal@kernel.org>
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

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit e8d2d287e26d9bd9114cf258a123a6b70812442e ]

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/i3c/master/svc-i3c-master.c:596:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
    596 |         default:
        |         ^
  drivers/i3c/master/svc-i3c-master.c:596:2: note: insert 'break;' to avoid fall-through
    596 |         default:
        |         ^
        |         break;
  1 error generated.

Clang is a little more pedantic than GCC, which does not warn when
falling through to a case that is just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to silence
the warning.

Fixes: 0430bf9bc1ac ("i3c: master: svc: Fix missing STOP for master request")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250319-i3c-fix-clang-fallthrough-v1-1-d8e02be1ef5c@kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2cf2c567f8931..75127b6c161f0 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -552,6 +552,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
 		svc_i3c_master_emit_stop(master);
+		break;
 	default:
 		break;
 	}
-- 
2.39.5



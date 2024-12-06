Return-Path: <stable+bounces-99426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A239E71AA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA00B283A15
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997B1537D4;
	Fri,  6 Dec 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zB/5lI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F410E0;
	Fri,  6 Dec 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497119; cv=none; b=hSHZHCuRKCzf1Ow7SbAoLX2hjn/Ptoh6OYkW6c+e8iYcb2xeyGfuFPpaDlHz4UwCmiG0KlwhZ2qTAOF+neWzvNTIhmIdIPmaTAdXf4ECvcGZHZ2yB8B2CBAugmXQtuzc0EI+JDILmLryTxGJ8uZh2ErEQemRSNOlHH7S25UD264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497119; c=relaxed/simple;
	bh=Qw3jIXdQeyZbFkR5/upEHydjTv5F2YcUT9w9JO1+IXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOJDUXtNvo5Wm8RBy0+aQGLOv3uRSUZb9SrbwrMZzMPUQmkahxogx5Lbhq9fwFI+O3cseuLFNGtVu9LegeP3k+9BqYIO+6c5Rn2pCSENdCxl5d3CZaJK9J3IMDCa0vJPXozhWK+uagvAiMx62R7fbrzFt/eDbA8up34UA2UDSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zB/5lI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E40BC4CED1;
	Fri,  6 Dec 2024 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497119;
	bh=Qw3jIXdQeyZbFkR5/upEHydjTv5F2YcUT9w9JO1+IXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1zB/5lI/f6ROQBojhyHTmZJHv1eSxOUcU4EfyCSEBGM+x/woeOslMkCOwra9jJVt4
	 LGroEf4S63LODV2QgUrxpkzjGLAnDWmeozC1vdMKo86t2X9B5M0bYdctrxzRBGWFzz
	 A0BRt+Q3mlbCihMVSCteAFXedOfhnaJIYAHJQ9RA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Fastabend <john.fastabend@gmail.com>,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 200/676] selftests/bpf: Fix txmsg_redir of test_txmsg_pull in test_sockmap
Date: Fri,  6 Dec 2024 15:30:19 +0100
Message-ID: <20241206143701.158426487@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijian Zhang <zijianzhang@bytedance.com>

[ Upstream commit b29e231d66303c12b7b8ac3ac2a057df06b161e8 ]

txmsg_redir in "Test pull + redirect" case of test_txmsg_pull should be
1 instead of 0.

Fixes: 328aa08a081b ("bpf: Selftests, break down test_sockmap into subtests")
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Link: https://lore.kernel.org/r/20241012203731.1248619-3-zijianzhang@bytedance.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 1a9660554bd2b..4bfadafe51baa 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1609,7 +1609,7 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 	test_send_large(opt, cgrp);
 
 	/* Test pull + redirect */
-	txmsg_redir = 0;
+	txmsg_redir = 1;
 	txmsg_start = 1;
 	txmsg_end = 2;
 	test_send(opt, cgrp);
-- 
2.43.0





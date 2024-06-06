Return-Path: <stable+bounces-49559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB18FEDCA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011BB1C23DB1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F81BD50A;
	Thu,  6 Jun 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Asb7Cvwt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8D1990AA;
	Thu,  6 Jun 2024 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683526; cv=none; b=kIi4gr83wZ3UHgdPEHVn1jp2vJ/R+IKnWAZrKIqcmdiZ1kOeYXAuV5YNusf2Lc9fxOWHggLHBDjghCqsQesh003U3l4RRqN/EZPKwNJVKrKrYsP4RXeOKv9VzLY4Ivd+z2dicrfgPJVlOuZ5sK7rxCW+A4I4kC3K1D5cGRbHAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683526; c=relaxed/simple;
	bh=hCaXcCo0LwFXi2gIucAdH+pSd0MTNJM5C1YQLWgjiP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5WhX1ugf+7TSMLrOoTm/6D5dbZkpPoKNiVBY3mQx5sgKqxGQYSjBOSjZCR0BOKoZlo+p98QmkvIpltAOE3u2EuECINrErLWchPWRHT+/LncoZ+i6aZ9fHnRy6ZGRSFRYHKq21MH1tMkXVsGMF6JWAgBNpQlGGdqzHalKZ6VHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Asb7Cvwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14FAC4AF09;
	Thu,  6 Jun 2024 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683526;
	bh=hCaXcCo0LwFXi2gIucAdH+pSd0MTNJM5C1YQLWgjiP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Asb7CvwtKVjYoSNLSFsoiSoIkSMmTcKSvJGl3+thAHVKuGbOCTdxDbEB9hSa5v/Hh
	 dw9hBOSUqZSREZHHbZtkbUAg9b/ekva++b4Eu/CGO0GwOi9KWZKNDP0geISrT1ABMQ
	 ZjdMDQX5OxTrZvVp2VCRbWiKRqLNNw0exEnnHMVk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Li <yang.lee@linux.alibaba.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 417/473] rv: Update rv_en(dis)able_monitor doc to match kernel-doc
Date: Thu,  6 Jun 2024 16:05:46 +0200
Message-ID: <20240606131713.571851741@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 1e8b7b3dbb3103d577a586ca72bc329f7b67120b ]

The patch updates the function documentation comment for
rv_en(dis)able_monitor to adhere to the kernel-doc specification.

Link: https://lore.kernel.org/linux-trace-kernel/20240520054239.61784-1-yang.lee@linux.alibaba.com

Fixes: 102227b970a15 ("rv: Add Runtime Verification (RV) interface")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/rv/rv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c97cc2d754aa..d0d49b910474f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
@@ -256,6 +257,7 @@ int rv_disable_monitor(struct rv_monitor_def *mdef)
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
-- 
2.43.0





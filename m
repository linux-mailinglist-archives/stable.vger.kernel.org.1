Return-Path: <stable+bounces-178199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755CB47DA5
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B1817CB1A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8826FA67;
	Sun,  7 Sep 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LPTNXohH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52671B424F;
	Sun,  7 Sep 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276079; cv=none; b=mcMXKV/QbKgEabSa8LqdMQTfAQsbIxzpB1b6EPl3QElUCRjiJICR5Vyzjm5BQsWOdBoIcBYwo4zg/uRQVXhIVY1vXwaZRS3YXVEHFW81oJtO8bXsiNBFT/QeHEmhUQfZMCYdD0rW4/ZNK+Z6Jxrv8D05mBws+nRoc/2AMvpKNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276079; c=relaxed/simple;
	bh=7g+6ZgA/spz+m7rvGmUiViEFn5tp/jNBBcRms5aSMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osYcwh5mEM/NQ5/T+hR80+IMtONszX+ncpkZpGd419hOXQ5MbWKkGEW5zX24ZeOoCfCQmJz27XNm0UJCuwRDVh1XLLCy5LtjZ3dLf2L5oG9Suj4EtC/uFajNQ871zVz1/PBsngkW9quV3D+sPHpf9JYTVeCvW74MRN2JtsZDl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LPTNXohH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40080C4CEF0;
	Sun,  7 Sep 2025 20:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276078;
	bh=7g+6ZgA/spz+m7rvGmUiViEFn5tp/jNBBcRms5aSMIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPTNXohHy3uEy0Kq9lrj3kexSGTSJOEIoKq3HvunJ0vECQPtG/bk+C5ESZVHPkX6l
	 g2ML/lYUkpYslAAggO5xHj84ilTbwAMkYlb1oPHjRjbZpvas/R+HWgWY2byoCSN3w/
	 3ihgtiMxXNtw1p7QUXe9cq4MTj9KZm0frCdgQdRs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 56/64] pcmcia: Add error handling for add_interval() in do_validate_mem()
Date: Sun,  7 Sep 2025 21:58:38 +0200
Message-ID: <20250907195604.963858086@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 4a81f78caa53e0633cf311ca1526377d9bff7479 ]

In the do_validate_mem(), the call to add_interval() does not
handle errors. If kmalloc() fails in add_interval(), it could
result in a null pointer being inserted into the linked list,
leading to illegal memory access when sub_interval() is called
next.

This patch adds an error handling for the add_interval(). If
add_interval() returns an error, the function will return early
with the error code.

Fixes: 7b4884ca8853 ("pcmcia: validate late-added resources")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index e6c90c0bb7646..58782f21a442a 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -375,7 +375,9 @@ static int do_validate_mem(struct pcmcia_socket *s,
 
 	if (validate && !s->fake_cis) {
 		/* move it to the validated data set */
-		add_interval(&s_data->mem_db_valid, base, size);
+		ret = add_interval(&s_data->mem_db_valid, base, size);
+		if (ret)
+			return ret;
 		sub_interval(&s_data->mem_db, base, size);
 	}
 
-- 
2.51.0





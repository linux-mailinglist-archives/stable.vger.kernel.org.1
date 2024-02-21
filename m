Return-Path: <stable+bounces-22413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62185DBEC
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B85B28175A
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39B69318;
	Wed, 21 Feb 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HN5SBFbC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78455E5E;
	Wed, 21 Feb 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523214; cv=none; b=buofLtZrzgC0nsOjAoc1gak+6emrsgl/hZUsIReOtbcCyz7h/r9Zn3eiv99t4v8G+8YbcUQ8FqV4j97CsT9OTC7Fm6zZI84aaGpLz0IVxawKZ/anTxb7UmdMmwp4enS7QuugSrbgta0TGI6G6pmWjLlD1Xi9gwPj1vjI+5z/TZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523214; c=relaxed/simple;
	bh=HQHMI2sQXGHD+JU3oPqScDb8u9QIcbsZpuXH0Tp6+Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3jmAtZYEUdgHVwVCmuWLpAzg0P8eFAQU8B4NPsYuy/qZ5eRkOgxHGX/KlgBZpNeYnAid50Q5sXmaITE1QZQOmTY6tpzhrMFNjW8F8G1z3+0MYdEliTxklURXr/3NJyX9oxQotua+1Pv6YYCk9pKRNUePYgm/FOb+KQRisw0jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HN5SBFbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532AC433F1;
	Wed, 21 Feb 2024 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523214;
	bh=HQHMI2sQXGHD+JU3oPqScDb8u9QIcbsZpuXH0Tp6+Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HN5SBFbCn8GMJK59eSVHOHPygLeL/VMfvxPho6FRkt/rBYsskyqpLcmrFowxUJDpj
	 mbsPbUiMCnnDAe7trNaiG3XbBptAGHjYBpyUSNhz5iUyF68XvSlccnFhLTaf7kioyI
	 Qni2aOsrXiuySaLHcJlEmb3dZykktS7LbA3ut1xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Lu <alexious@zju.edu.cn>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 370/476] media: ir_toy: fix a memleak in irtoy_tx
Date: Wed, 21 Feb 2024 14:07:01 +0100
Message-ID: <20240221130021.713992480@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit dc9ceb90c4b42c6e5c6757df1d6257110433788e ]

When irtoy_command fails, buf should be freed since it is allocated by
irtoy_tx, or there is a memleak.

Fixes: 4114978dcd24 ("media: ir_toy: prevent device from hanging during transmit")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ir_toy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 53ae19fa103a..658d27d29048 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -324,6 +324,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_EXIT), STATE_RESET);
 	if (err) {
 		dev_err(irtoy->dev, "exit sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
@@ -331,6 +332,7 @@ static int irtoy_tx(struct rc_dev *rc, uint *txbuf, uint count)
 			    sizeof(COMMAND_SMODE_ENTER), STATE_COMMAND);
 	if (err) {
 		dev_err(irtoy->dev, "enter sample mode: %d\n", err);
+		kfree(buf);
 		return err;
 	}
 
-- 
2.43.0





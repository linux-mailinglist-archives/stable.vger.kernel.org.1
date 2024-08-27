Return-Path: <stable+bounces-70521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E602E960E8F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FC81C2327D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6BE1BFE06;
	Tue, 27 Aug 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRjrBHGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD8DDC1;
	Tue, 27 Aug 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770184; cv=none; b=qORViAgywRFAWO2aVcFRjHhb4TmzrCPmq8IGPspeX0bq+75zZ4ot1CYmBu5qLCs3lILYzEWP3xQtk4TLErTSy1ROfO0D+J4DDrP6TNFLIQO1J0zvBms5oxij+4aauWc39p0dr5IIbIDtNx3pS5bz/rit8QKJAdPLEF2XQq+8Q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770184; c=relaxed/simple;
	bh=TexKarRH9vEKwzuf/mQxvvnbV3WEqiVUMfuXEnz8+Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDsBQ76nraYjV/5pnBPFZfPQsk146oq/5NeuXsovD2w82zEp3cDtGN0F/GQvUfpfdazF+r6k1aE4u2fPpbL7Be3Gx0f9AHaEHmg0+i0EtPYi9rMEumZgCDRHLZsFS4U0sGU38iPci6ve8avo/st/EnlnwJTl7L/A6Uf0zNoTPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRjrBHGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36999C4AF1C;
	Tue, 27 Aug 2024 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770184;
	bh=TexKarRH9vEKwzuf/mQxvvnbV3WEqiVUMfuXEnz8+Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRjrBHGbWljapLRvDIwRag7UmQARfhXEicfeQ/mgM4rgmzYzuNAUdy8vQ0vxouZGW
	 WiC6QGkOEQIcQzPCFGx/PCWOB63VAYIT/KW+N4kXSdev/9BvL3CD229ndJaOtPdUbG
	 uGguLQQKZmmVH/Wj3Hn71t6qAmRmv9vW/dAsF4VY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 121/341] media: qcom: venus: fix incorrect return value
Date: Tue, 27 Aug 2024 16:35:52 +0200
Message-ID: <20240827143848.018424175@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 51b74c09ac8c5862007fc2bf0d465529d06dd446 ]

'pd' can be NULL, and in that case it shouldn't be passed to
PTR_ERR. Fixes a smatch warning:

drivers/media/platform/qcom/venus/pm_helpers.c:873 vcodec_domains_get() warn: passing zero to 'PTR_ERR'

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4dba..a1b127caa90a7 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -870,7 +870,7 @@ static int vcodec_domains_get(struct venus_core *core)
 		pd = dev_pm_domain_attach_by_name(dev,
 						  res->vcodec_pmdomains[i]);
 		if (IS_ERR_OR_NULL(pd))
-			return PTR_ERR(pd) ? : -ENODATA;
+			return pd ? PTR_ERR(pd) : -ENODATA;
 		core->pmdomains[i] = pd;
 	}
 
-- 
2.43.0





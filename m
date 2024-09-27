Return-Path: <stable+bounces-77922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6E988437
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0171C21EE2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04718BC0A;
	Fri, 27 Sep 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lC7wkE3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49A18BC1D;
	Fri, 27 Sep 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439928; cv=none; b=CFiD7l1bJR6X1VPzzlccDmOCnR6wgOHdtCbTj4wRuyAReycsIw8uf98ELqqrXbzHdstXU0+wdbXiZByrVcDAEgXX4aM4d6AkyQdoabAfvINnUyUvaR99otdoYBbQycQT8G3SFNQ+Ab8RIPFonD48uJCD408GzbiDpv7g6Oa8v1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439928; c=relaxed/simple;
	bh=Rdd3ynJaiVhfiMj4qc4oSG6f1NS2ElpMPDHNGvZb15Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCKBEFtvDByu4TB8OYYuj7TBJSwgkFTZ7XdcESeCtH/B6AC8fv0skR9aMFIetnGgjXGUpDPdPqGX5U9kguURoOvb/OwNinxwYJCxJNNh3UhyQlCFj5IVt/VAxV1Fqsucysp/Z36AyopguMhGWbuDxLmm4PXMJ4hHj+AaijLyjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lC7wkE3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D8BC4CEC4;
	Fri, 27 Sep 2024 12:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439927;
	bh=Rdd3ynJaiVhfiMj4qc4oSG6f1NS2ElpMPDHNGvZb15Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lC7wkE3S1hQLd6YB40NFoJxTeLj73iYAF2lVukjoBu3ltSoyp+8iaXjvaFYlormSt
	 1ga5fKtx2FCIGjYt2an38HOSNEsosl2pHKSAeBE/onJxpOI5+9rus7zTc1g2XlVIEM
	 +kaurKqpRaYMT12SKUaIlr9VEvvJgRfHCKwxAYkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 25/54] ASoC: tda7419: fix module autoloading
Date: Fri, 27 Sep 2024 14:23:17 +0200
Message-ID: <20240927121720.747748601@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
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

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 934b44589da9aa300201a00fe139c5c54f421563 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-4-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tda7419.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index e187d74a17376..3914deb060cac 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -623,6 +623,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
-- 
2.43.0





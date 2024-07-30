Return-Path: <stable+bounces-64486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D9D941E4B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F830B232D6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F01A76B6;
	Tue, 30 Jul 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvDegOcb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC41A76A1;
	Tue, 30 Jul 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360281; cv=none; b=oMbmQses/zGS0l5GEWmJS2vC3qBj9w5uoAJcma2WhlJEFpbkDC4cPpxYTJGLmCFGMKE7tNUkFYsnNigi3om2jvgSxOXUDGb45wTdFEsgnjKlNIUZ7Zzbb78bOywlZpo2p4lplCQKnLfB3IK3qofLs87PsrOhSE8ovp5vmpTz7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360281; c=relaxed/simple;
	bh=sob2k1ewE6PQQwD2ZSSAqokDco0SphN+Me1erpovU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szd+kjuRGmkHIy2zRf6AVV5FY9I9q8jf3vwjh5RI1WwW0gPeTW+2c7KbHf5u516/nC+9ni05MNWckFH2vr79bur6lIFVdQoFslmu1cUSw/o/ZkGr1IygaFxfoBBwzUOIts+Nx7T6Vk58TWG8Kf6S3s9ZWT8ME9Af+O3CVJjbYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvDegOcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755FC32782;
	Tue, 30 Jul 2024 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360281;
	bh=sob2k1ewE6PQQwD2ZSSAqokDco0SphN+Me1erpovU9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvDegOcb9HOh14+nGZESfU5WnFMVcO4+ldr+pU35FolK5iFt2KZDMIi7czqY9bkHw
	 /I/vCVXxVyK/XYhevaBH9AXBJdpb5R2a+Heg9SqGE9+qoy6vl3wtgv2zqQ61Kzr92S
	 XAR1sfrehW2pV56aJ2dxIzXw0XdZu9lxHKH3/lRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.10 651/809] ASoC: fsl: fsl_qmc_audio: Check devm_kasprintf() returned value
Date: Tue, 30 Jul 2024 17:48:47 +0200
Message-ID: <20240730151750.590937578@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

commit e62599902327d27687693f6e5253a5d56583db58 upstream.

devm_kasprintf() can return a NULL pointer on failure but this returned
value is not checked.

Fix this lack and check the returned value.

Fixes: 075c7125b11c ("ASoC: fsl: Add support for QMC audio")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://patch.msgid.link/20240701113038.55144-2-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_qmc_audio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -604,6 +604,8 @@ static int qmc_audio_dai_parse(struct qm
 
 	qmc_dai->name = devm_kasprintf(qmc_audio->dev, GFP_KERNEL, "%s.%d",
 				       np->parent->name, qmc_dai->id);
+	if (!qmc_dai->name)
+		return -ENOMEM;
 
 	qmc_dai->qmc_chan = devm_qmc_chan_get_byphandle(qmc_audio->dev, np,
 							"fsl,qmc-chan");




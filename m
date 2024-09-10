Return-Path: <stable+bounces-75706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF07973FD5
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECAC281ADF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF861BE86A;
	Tue, 10 Sep 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THvIPpp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E151A38EE;
	Tue, 10 Sep 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989023; cv=none; b=ngQu6RtTPS74J7JhQE6MDURERknfRaUiWg/I6OnMRUK4uqt3qD0yI3DFDH42lireTSiuGUXZxvM6psO3wunB3Zh9krYmgAouZFLJLFLy13ChhCXNHkTmPP1F7IVL2BWrBBPGeE83NcilA0XkphL9CgBrpGD3CJ8+BSUMBfVMOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989023; c=relaxed/simple;
	bh=Rn3Nj4X4oqnHqsfTRBpopwiQlSlZenarmV/PiU2uyzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQMNo2doDQSNvUHmnoZsI+AKqRZGfwsYZdz+JDNrY73wrqmxf1EayGxe8Bgqc1eAqPwP+xd0UDxG9Udm1eTt8y4MoDdnh8cUfEvaacMU8zrnJm8YinKAfuJgwN4Eh0IXrw6CripUXLv+7Muffmjl+pJ62rU4FdrLQ3J+GNH/zds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THvIPpp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C679FC4CECD;
	Tue, 10 Sep 2024 17:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989023;
	bh=Rn3Nj4X4oqnHqsfTRBpopwiQlSlZenarmV/PiU2uyzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THvIPpp1qXaxOsNiur9aA1jyKZVl+/VD3XpKIkbfg1BL5hC8CKwY7YXCyN4ISQv00
	 q7d4vtQHMWzw2ZptVxQef0hBnxHI/8qtApXi0vobL/NfN19yeALh5JYhXZKfZGhbm9
	 adpqgVs0MQQN0OaLrBqK/52OLWHJDBPmwRSxUQLo3Am7Bcrpo4+8+Ks55gm7DBtXkV
	 LRiNSxoUZLMK+E9G1H+KbgttQfTilDquPap6yOeKoVUPgJgjZbrseaYRlgC3gWunHY
	 HL7KtzUdCEZovavzxQeY8Sq3lsm1KcIMBimCasQyNClDxXbzt1MTIlsavyFkTFffZ2
	 l/LBZO7eOmR3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	andy.shevchenko@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/8] ASoC: tda7419: fix module autoloading
Date: Tue, 10 Sep 2024 13:23:24 -0400
Message-ID: <20240910172332.2416254-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172332.2416254-1-sashal@kernel.org>
References: <20240910172332.2416254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
Content-Transfer-Encoding: 8bit

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
index d964e5207569..6010df2994c7 100644
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



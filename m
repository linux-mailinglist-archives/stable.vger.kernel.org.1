Return-Path: <stable+bounces-65206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E1943FB4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D38B1C227CA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA81EA0DE;
	Thu,  1 Aug 2024 00:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taNDLm08"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C11EA0A9;
	Thu,  1 Aug 2024 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472860; cv=none; b=kTGm7pJj3+1EPRQGGaaAbe/ZVNjDAqtNHEgSyF2ndYmyBEZSKBLUfBvOEeUMMYvLKZXVEN0u7XbsFrDovr0lCnJUW6yjj2u4kEdxp4QYczpIIb7PoThBZnMR+EuUZNwRzuKxriDxa3BXPS0kF/cpgBZQya+oRtJuoMq37JnEye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472860; c=relaxed/simple;
	bh=aAZs5msIReOHMjel2MWfn1tq9+vDR7M4zBIfaF1jOzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjqeiL39IWbgNQIOGxf+CcvOJe1Gp+PeB0fKXRDQqaZHMpRuk04HNykSp+/8S/BhUyUBQ9CTY0xowmlseQoe25LD0AttS6aZskgurhqH0MA+z4CK02Fqm8qaUI+hlu42826vcqzxBztbP0eSZxATX7t8nyDYxYDLL7rdcrqRhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taNDLm08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C86C4AF10;
	Thu,  1 Aug 2024 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472860;
	bh=aAZs5msIReOHMjel2MWfn1tq9+vDR7M4zBIfaF1jOzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taNDLm08JFZhiS/K65x4bMo5yFFgsCyPt72V3YMOjIVVRJdnUfvhMXZBNZNpM+uR/
	 2/eDfG9LXSIsuaOb9xK/nQMf437qBzovbfPuWGB7dsmaMeJBIAdfOnkO5BYwIwEqIh
	 KBIj17K3AWvU9W5LYO2TllK0TsrCR5bC96uHlf2SGN7sELom59DOaSWiphgMx39SGp
	 tW6IM+k0satV6FL+p257Brq09wEG+o3hlPzgXSGmQ8Wv+D+kjnWjO8efVgsZUObUYx
	 1F3CcofkX8SnWGOR/kMXkJGfyAfM45wUHNNXlAm6WOLD3G5pIMic6Nwqo9SRYaJ5/c
	 RLonjGwl/6OaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	roberto.sassu@huawei.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 09/14] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:40:17 -0400
Message-ID: <20240801004037.3939932-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 824ac4a5edd3f7494ab1996826c4f47f8ef0f63d ]

The pointer isn't initialized by callers, but I have
encountered cases where it's still printed; initialize
it in all possible cases in setup_one_line().

Link: https://patch.msgid.link/20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/line.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 71e26488dfde2..b5c3bc0e6bce0 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -391,6 +391,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -414,6 +415,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0



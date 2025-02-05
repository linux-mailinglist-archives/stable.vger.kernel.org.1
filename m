Return-Path: <stable+bounces-112716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08922A28E0C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D1E164A0E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990801494DF;
	Wed,  5 Feb 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6jUIF61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC71519AA;
	Wed,  5 Feb 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764503; cv=none; b=t84nBENP9soWSQGiUrlypWyj5xfgeocIsKbcf9V7exhE+pGit3WOuY/YaLE2WhsG6h7c/deXIYT4hQHvAx4SVoG2s8Fdjn3iblVrTBtIQesqYxSkXjqZtzJs3/mOTV7sdFu4IYcggdbC3gJrcpOd43f+ugnX4tkfHP6Ky8qrxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764503; c=relaxed/simple;
	bh=y2zmzusKzEOXtXxpNeyVhflbYCoz8nMqQ/h4hxgHolM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuPTFslvRt+gZEMo+UjyLx4snc/yUZ4ExHrPZmuXZxRaq37rHRTg3biYpCi4f7nw1Q33QgoJiHEjyH+4uYU1SzyEntbE812agLKx9rN6A8vSmapzVcgObnFWiOoXjBJ6Q3vA9E/bT3Prg501+SrIh4n1GVAc5/jFiVv2guLNBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6jUIF61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E106BC4CED1;
	Wed,  5 Feb 2025 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764502;
	bh=y2zmzusKzEOXtXxpNeyVhflbYCoz8nMqQ/h4hxgHolM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6jUIF61wpST13Efqu56Kr3VUB7xDfkqgJvPyc5xTektd0ks69aNJrU3g5WsP7ymn
	 Zs8EeUi0OeEoWsz+SxbqkKpHAiMyEMyLf7sdFLuJTnOKftaueCf3AO4+Cqfw7J5j2A
	 iq5LbTz2TubPnS03Sjai11yQtrZPl9eEkARFRIt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 133/590] regulator: of: Implement the unwind path of of_regulator_match()
Date: Wed,  5 Feb 2025 14:38:08 +0100
Message-ID: <20250205134500.355502917@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit dddca3b2fc676113c58b04aaefe84bfb958ac83e ]

of_regulator_match() does not release the OF node reference in the error
path, resulting in an OF node leak. Therefore, call of_node_put() on the
obtained nodes before returning the EINVAL error.

Since it is possible that some drivers call this function and do not
exit on failure, such as s2mps11_pmic_driver, clear the init_data and
of_node in the error path.

This was reported by an experimental verification tool that I am
developing. As I do not have access to actual devices nor the QEMU board
configuration to test drivers that call this function, no runtime test
was able to be performed.

Fixes: 1c8fa58f4750 ("regulator: Add generic DT parsing for regulators")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20250104080453.2153592-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/of_regulator.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 3f490d81abc28..deab0b95b6637 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -446,7 +446,7 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 					"failed to parse DT for regulator %pOFn\n",
 					child);
 				of_node_put(child);
-				return -EINVAL;
+				goto err_put;
 			}
 			match->of_node = of_node_get(child);
 			count++;
@@ -455,6 +455,18 @@ int of_regulator_match(struct device *dev, struct device_node *node,
 	}
 
 	return count;
+
+err_put:
+	for (i = 0; i < num_matches; i++) {
+		struct of_regulator_match *match = &matches[i];
+
+		match->init_data = NULL;
+		if (match->of_node) {
+			of_node_put(match->of_node);
+			match->of_node = NULL;
+		}
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(of_regulator_match);
 
-- 
2.39.5





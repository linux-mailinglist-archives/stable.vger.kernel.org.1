Return-Path: <stable+bounces-233810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKysDOQE1mkbAwgAu9opvQ
	(envelope-from <stable+bounces-233810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B523B854E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560CA305A5C2
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CA3859FE;
	Wed,  8 Apr 2026 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX/uCdC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B5383C7F;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633514; cv=none; b=Tskv4arVsrqxiNVNFlCqInTx4CVq+posouOo2pFnoZ6HjZEJfs3MpVPlMqDy1yeHmEEL9iKu8ngsfAycNNXy0cpk9hgTlGnzL728UrEOWjDOe9IwWE97MM+J8AaPZb+EaWKjA4aL5m490c9bVJQf1KsYE22MFZFg7J9xRKOyUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633514; c=relaxed/simple;
	bh=BrHrnOrC503xqRHeINjDCqs4CrINRM35jf9JKJhXl/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXFiAFvsX7h4G4LViZeXt7zRLBCy9PeaCmGJN3QPrqmd9oiq5AWLPVQcAlbY9dhmlCsVAbd1GTmWa3Mkwpyop9/k7LKlWmchjVxbM6vsCT9q/GSctRccmEpqelygugB/B7HnpFhcU+sd2Y08+YG/Iz8khc0JxeLv0Vl6W2L4hOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX/uCdC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67402C2BCAF;
	Wed,  8 Apr 2026 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775633514;
	bh=BrHrnOrC503xqRHeINjDCqs4CrINRM35jf9JKJhXl/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WX/uCdC98GwgP5PZguiqfV0IKxWpDfn7SsQZmtaH0h/roilkFl8Qc22RS+KYq4bjG
	 32C27EvV+yHKOu5qNlC1IY+4ltloJY88sL33QyX297FA3PBdRaHf/yUEwE0WvRSs6J
	 PfZIBh5oQGwn9srNJt8cCAnq6T13RL9ATKwcfsuKVB0PSRUze+j+6JfKWs2LKqKWOm
	 rH1EJHNxx0CKYdDpJRFGGY8NuCmIlOyfcDyqrTONGGgj8jsWM2qy2rmJKF89Dr4xLv
	 BczmSG43tiDQ+OiQpcLct/CGfCwwFO13ALsKK6xeWGXeQKVWkEjD3EiEW5hRHO1W/b
	 LaLLhXzjy8UgQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wANOB-000000001Mf-47hF;
	Wed, 08 Apr 2026 09:31:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 3/7] regulator: max77650: fix OF node reference imbalance
Date: Wed,  8 Apr 2026 09:30:51 +0200
Message-ID: <20260408073055.5183-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408073055.5183-1-johan@kernel.org>
References: <20260408073055.5183-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,collabora.com,linaro.org,chromium.org,vger.kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233810-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0B523B854E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: bcc61f1c44fd ("regulator: max77650: add regulator support")
Cc: stable@vger.kernel.org	# 5.1
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/regulator/max77650-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index a809264c77fc..11b04a13f889 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -337,7 +337,7 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 	parent = dev->parent;
 
 	if (!dev->of_node)
-		dev->of_node = parent->of_node;
+		device_set_of_node_from_dev(dev, parent);
 
 	rdescs = devm_kcalloc(dev, MAX77650_REGULATOR_NUM_REGULATORS,
 			      sizeof(*rdescs), GFP_KERNEL);
-- 
2.52.0



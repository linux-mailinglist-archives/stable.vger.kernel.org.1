Return-Path: <stable+bounces-220572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF9DDJlOo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:22:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8CD1C849F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DE2732A8FEA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5F48A2A8;
	Sat, 28 Feb 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYk/rh4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7A3DC69E;
	Sat, 28 Feb 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300453; cv=none; b=mfJ/RecXRr4AAP7+UE6MfC4s8AmYaZ49MUwak8AONGSUkKYtJHid2/T80bW7fctLbOOI3MpzPf2JjzlX8kyw26ONhUw0NBNqWXIsyiyCBPbrVBOY6z9oJ7m3GcPWiWiPV18sL33fF8HRSQG2AwjfTICQA4OrNrmsi0sVZXdnxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300453; c=relaxed/simple;
	bh=+M3Ojoc64XvgPwIK89boFs6nFnX5f6iJJtVGh9XQs3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoT8Mab0yHpSgUy8K8rlhDkFEKOoMm2f2I+8cEo0wEX852hSECfQXTTEMO0XQrcg/4p3Z/90lEhOKY5pyVc8PCnJUgeZoal8wkVB51DIJuo0+PPOuoTGr7iVs60LjuRnwVnf+oYxGVJV6TMU5J4FlJWsK6Slu00okIw1Yuinh+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYk/rh4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B839BC19425;
	Sat, 28 Feb 2026 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300453;
	bh=+M3Ojoc64XvgPwIK89boFs6nFnX5f6iJJtVGh9XQs3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYk/rh4hn7tItJ17gvh4O3Rml2I9Hr7A2RhQiUFwlFPa90EHSx7cS/3adNynI4ZoY
	 jwnsb547tu0PezLO0UPnn6DlBe4qgKd+I5Us28tZ23m6h9lvwh67J7/BDwQOFAdYfG
	 AY70UJA3LPeFzc1+WgvL6q6ZEi4OlS3Fp9Zb6e4uAncU7TOthFAwUaiC42K0HLuTxu
	 G4zRkbL8s89zQ3T9gzdqXi+ap0/1ScX2pKNStBKOq4mlPPSah59Ubcd+uzglhrmdSA
	 cNza/n3vJnjXyzvlMDwENEK8Os50mguSpYN3+ahCPvsGZDKW4BJ3re5gWk6ipb88eI
	 RXMLKmLuMQ+1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Gu <ustc.gu@gmail.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 493/844] dpll: zl3073x: Remove redundant cleanup in devm_dpll_init()
Date: Sat, 28 Feb 2026 12:26:46 -0500
Message-ID: <20260228173244.1509663-494-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220572-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D8CD1C849F
X-Rspamd-Action: no action

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 676c7af91fcd740d34e7cb788cbc58e3bcafde39 ]

The devm_add_action_or_reset() function already executes the cleanup
action on failure before returning an error, so the explicit goto error
and subsequent zl3073x_dev_dpll_fini() call causes double cleanup.

Fixes: ebb1031c5137 ("dpll: zl3073x: Refactor DPLL initialization")
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260224-dpll-v2-1-d7786414a830@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/zl3073x/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index b20d4f24c0e94..b9b7c751b7602 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -978,11 +978,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	}
 
 	/* Add devres action to release DPLL related resources */
-	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
-	if (rc)
-		goto error;
-
-	return 0;
+	return devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
 
 error:
 	zl3073x_dev_dpll_fini(zldev);
-- 
2.51.0



Return-Path: <stable+bounces-198688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C0CA095B
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E4E32D3FE1
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67394305970;
	Wed,  3 Dec 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATPLM0aN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA3338597;
	Wed,  3 Dec 2025 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777361; cv=none; b=rMO7ywgjXCcxee9x13mr0pFX10iZgIeQGeAaNEchWkx+EBv+MVAcwtcn3JJ9Z7/hlbl1tmQK2XJpRstYovJZTnfYfri6lFkAlIlCcLhnq7nrFLiq+j1iaMpYLJbwrlk+UtQTgVS+550Z1I86i/zJpdXbJOvALgEz1FjE7JCn21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777361; c=relaxed/simple;
	bh=GLr8eELwDBRHw6VEicbHk6Ag95TlxJsS+Qc0Z188mnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAGyS2NLc32r4lWdsJzq1+i1DJPhBw1E0XaQOXExkb8970Kj2zAFX9dbjcAy+O4Nz94fCXlQ40jwBR/T/riTOUeIJ0H3U7aKp91Hu9h/S18TVl/dJ0niQWoAlstJ3ku9KdS3mng6T9Km2MyutPwiIa80KFB44oD9ADM9sRhjw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATPLM0aN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7017C4CEF5;
	Wed,  3 Dec 2025 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777361;
	bh=GLr8eELwDBRHw6VEicbHk6Ag95TlxJsS+Qc0Z188mnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATPLM0aNjb2wGtD95+x5qv4fgwevLyX9PAWnTKsabVchCQCdMrSPBla8d9t6Ij7zV
	 enFKf5xOLzu/QZVS1K4Hom3sxCOfDQwH9bE0qfbgbQNpSLJKT6hSotizVD4wCD00R5
	 LEtDPFLS95jc9rl5HU6frQ3qxsWZ25fjWq6KlUo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 015/392] ASoC: qdsp6: q6asm: do not sleep while atomic
Date: Wed,  3 Dec 2025 16:22:45 +0100
Message-ID: <20251203152414.665699631@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit fdbb53d318aa94a094434e5f226617f0eb1e8f22 upstream.

For some reason we ended up kfree between spinlock lock and unlock,
which can sleep.

move the kfree out of spinlock section.

Fixes: a2a5d30218fd ("ASoC: qdsp6: q6asm: Add support to memory map and unmap")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20251017085307.4325-2-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6asm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -376,9 +376,9 @@ static void q6asm_audio_client_free_buf(
 
 	spin_lock_irqsave(&ac->lock, flags);
 	port->num_periods = 0;
+	spin_unlock_irqrestore(&ac->lock, flags);
 	kfree(port->buf);
 	port->buf = NULL;
-	spin_unlock_irqrestore(&ac->lock, flags);
 }
 
 /**




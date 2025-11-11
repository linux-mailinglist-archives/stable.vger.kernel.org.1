Return-Path: <stable+bounces-193087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 237EDC49F3E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A20E634BD6B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6C244693;
	Tue, 11 Nov 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXfRISET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0554C97;
	Tue, 11 Nov 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822269; cv=none; b=qMjxFi1LFMJiI6qReroD+xO95nHFnDeeDoqk3F3ell8FX06UjfuMyVMigNFX60ByayK4bsH2Op7Q9hvyeJNiExsWoIcJKlUo3iqK3URbwm2+4egSdR83sURq/cHBb+2U9WCiXjksiYfqu7lOwiVhvwk1Enr54DQ/bOBqA+fIrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822269; c=relaxed/simple;
	bh=WPSdfXQqXmwBvUgXXTrRvPsQ0FlAmUlC7Gh2z1b03zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bxh3cBxTzTSCkIWv6oZb1x6nbg9EFoqILm95xCvRvsedtWWFyBYqtYMGhYSps/OLQUhi6cj/AV8r3nGLKcP7g+Bkp2+0PTd0Y/R6jfUPYW/SckqCBqDE3CFSBOjzN6YY0/qhxzO4y+bZzE+54vIc8rYokBxTP7vFty2TZAnEY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXfRISET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E8AC113D0;
	Tue, 11 Nov 2025 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822269;
	bh=WPSdfXQqXmwBvUgXXTrRvPsQ0FlAmUlC7Gh2z1b03zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXfRISETALt0LIh5gzjJtJHlk7Fx2qAc7FFutIGOpbk3l7sxTAg7Yz4OmRJZkfnU3
	 3MykOqzsbU21xwGLM0hL9oLCMNIvwidRaKZG8PKCfz27xB7SnVDaXIvmagTu7FfmBg
	 6/KO0UjyszsgBoY//nAyzaGl6JZdHaFqgIgoEJoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 015/565] ASoC: qdsp6: q6asm: do not sleep while atomic
Date: Tue, 11 Nov 2025 09:37:51 +0900
Message-ID: <20251111004527.208508941@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -377,9 +377,9 @@ static void q6asm_audio_client_free_buf(
 
 	spin_lock_irqsave(&ac->lock, flags);
 	port->num_periods = 0;
+	spin_unlock_irqrestore(&ac->lock, flags);
 	kfree(port->buf);
 	port->buf = NULL;
-	spin_unlock_irqrestore(&ac->lock, flags);
 }
 
 /**




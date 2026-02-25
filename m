Return-Path: <stable+bounces-219239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB/7NRuenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:00:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F4D192B8F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62F9930F57FF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEA2C0F97;
	Wed, 25 Feb 2026 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zPGm5l/5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E92C11CF;
	Wed, 25 Feb 2026 06:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002586; cv=none; b=ZwcXo0mRYOxRqd097fB46jVhEuEVxWTfOidUfIm7siPa6hlY21+CE8KfawTOiKpWHM7FWaAsQxmywzho0nVFUjkBRrL58ekq1yLEhNgBXMIpLOCqTdYIkCSPov4uS/T1GivmFVJNkAtnRQCag0kwF12d5LEVEA33mTX1c0dHFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002586; c=relaxed/simple;
	bh=DAW3SZpW+fxoMm+bdYz/508j9eZ8hKJ+RAI5Ag8AOGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxaLyVXwz6PhMb94jd06oaHSScdPSastyPCeVARUVi1wVg1Aox4OE8EgqDzA/bfuNJKGDUJR/pg4NAkWmfkEJf2khaXo1I6IxsxLG1cSs/tX+FCCjzBidBc0bHwYMX5AeXdv91sgbsc+hP7x2V4WUdNkxt9itpcJeIJfuJ/ilPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zPGm5l/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4FDC116D0;
	Wed, 25 Feb 2026 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002585;
	bh=DAW3SZpW+fxoMm+bdYz/508j9eZ8hKJ+RAI5Ag8AOGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zPGm5l/5rRmpkf1aJoY41tEj3UBvOboEcJTNSb0jq+Re5UA67LyrgjVEDrjxWd9q9
	 uAYEmTsnmD6SntPR8SLHbe+ZFoti2uEIxRZc/Z38uUgwb6wwbUtCaFkvhjO0u6/EYp
	 dAi9DUJYGda2Lm3vGG09j5U1V6PwX6Kp9/YfD5xU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 322/641] dpll: zl3073x: Fix output pin phase adjustment sign
Date: Tue, 24 Feb 2026 17:20:48 -0800
Message-ID: <20260225012356.507956631@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219239-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39F4D192B8F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 5d41f95f5d0bd9db02f3f16a649d0631f71e9fdb ]

The output pin phase adjustment functions incorrectly negate the phase
compensation value.

Per the ZL3073x datasheet, the output phase compensation register is
simply a signed two's complement integer where:
 - Positive values move the phase later in time
 - Negative values move the phase earlier in time

No negation is required. The erroneous negation caused phase adjustments
to be applied in the wrong direction.

Note that input pin phase adjustment correctly uses negation because the
hardware has an inverted convention for input references (positive moves
phase earlier, negative moves phase later).

Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://patch.msgid.link/20260205181055.129768-1-ivecera@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/zl3073x/dpll.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 38551cf788494..11ca32e1bb829 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1222,10 +1222,8 @@ zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = zl3073x_out_state_get(zldev, out_id);
 
-	/* Convert value to ps and reverse two's complement negation applied
-	 * during 'set'
-	 */
-	*phase_adjust = -out->phase_comp * pin->phase_gran;
+	/* The value in the register is expressed in half synth clock cycles. */
+	*phase_adjust = out->phase_comp * pin->phase_gran;
 
 	return 0;
 }
@@ -1247,10 +1245,8 @@ zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
 
-	/* The value in the register is stored as two's complement negation
-	 * of requested value and expressed in half synth clock cycles.
-	 */
-	out.phase_comp = -phase_adjust / pin->phase_gran;
+	/* The value in the register is expressed in half synth clock cycles. */
+	out.phase_comp = phase_adjust / pin->phase_gran;
 
 	/* Update output configuration from mailbox */
 	return zl3073x_out_state_set(zldev, out_id, &out);
-- 
2.51.0





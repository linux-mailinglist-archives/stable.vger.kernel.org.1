Return-Path: <stable+bounces-256086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPPyABCrGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222775F9C0E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4DA2304F41B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9204313550;
	Thu, 28 May 2026 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yetDjByc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACF2F1FEC;
	Thu, 28 May 2026 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000715; cv=none; b=EVJZErWpZWJLQ8CrPsFoXsY49B4bCfO9AlQdJ0SWvkYJKiO/SGMSukMAGkEKN9tfrTeOQYIUNJqzV3QKJQDztFtaraBVp/63MXsPhG44ZQNVea2B7ABiRU9HWh0U+kcUqc7LWHf2h5Jq9aq+UW05/j20KLrS5Qo6IUlzTyDzMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000715; c=relaxed/simple;
	bh=g6w5WzS87WlvmlM4ne2KIgzBa71w7AWwfOW/TotMLzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0R+C2GrNdkgqPN/lbxDkjQTL5uX2JmpmOBlxWvKfCkMZQ86rvLRWt5+NQqupG8cXydqF72Ggr+qI7gk2pc7HEFJzjuupMG4uQBxZ3She8+aSlBskHzffRtt8nIy9FGDmDE7pUmtIeCsaozIVLPV4qPAMjUhKHf+bKaTPRYI9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yetDjByc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA481F000E9;
	Thu, 28 May 2026 20:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000714;
	bh=t7jL5mPFkCyjdWXGKbCzjSS+uKrbiZHwZoPrkmPrEdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yetDjBycLEaqMZOiVFVuDFA1vClvjr+TEpy4H2lHVVPF3uM4hrDdSSB2xt2FNzHAN
	 Lh9Mc0VZcVujjhwBC63DzzTICCSjs8Q3OmrMI09AYYYEM/P7L0MSzGXe3rsugLA5/Z
	 GKgrzrnlq1g23IwQvfJC4n35hyqDfeCbY0PAjhac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 144/272] pinctrl: renesas: rzg2l: Fix incorrect PUPD register offset for high pins during suspend/resume
Date: Thu, 28 May 2026 21:48:38 +0200
Message-ID: <20260528194633.403824812@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256086-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,glider.be:email]
X-Rspamd-Queue-Id: 222775F9C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 6dba9b7268cc50166bce47608670192fd874e363 ]

When saving/restoring pull-up/down register state during suspend/resume,
the second PUPD register access was incorrectly using the same base offset
as the first, effectively reading/writing the same register twice instead
of the adjacent one.

Add the correct + 4 byte offset to the second RZG2L_PCTRL_REG_ACCESS32
call so that pupd[1][port] is properly saved and restored from the next
32-bit register in the PUPD register pair, covering pins 4–7 of ports
with 4 or more pins.

Fixes: b2bd65fbb617 ("pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260328090548.84124-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index bcb0c39369e05..17e27879fd623 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2849,7 +2849,7 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
 						 cache->pupd[0][port]);
 			if (pincnt >= 4) {
-				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off),
+				RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + PUPD(off) + 4,
 							 cache->pupd[1][port]);
 			}
 		}
-- 
2.53.0





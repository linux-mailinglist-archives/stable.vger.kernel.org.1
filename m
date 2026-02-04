Return-Path: <stable+bounces-214239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6K87Ivtqg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:51:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B149E97BF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A44C303DC68
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8EB1C5D57;
	Wed,  4 Feb 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tY3zEhYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D622332E;
	Wed,  4 Feb 2026 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219027; cv=none; b=CM2JX6pqVNuH2kyXjRkJz1DpXdoDP23pNUjkZwrVKJpwF1ormnUVBMtVt2plnFAISomMWcXIDuNfnv1b1ZTrzC9QroXks1AgVQxlj3xymAb7VVgzvAy02uAJUzlP7VDwNEqUDuMWcHcSHAS0sezP1nR9Y1xANoe1FqhcDQgw4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219027; c=relaxed/simple;
	bh=HCI02s3xp5ahZixVx+wY2DOZhxQL9fBqGNt1JUAfE/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcbVj6F4VlW/qL99afi9EK3ZLY1JvK5MmwpaL67h0rdAqjyTNOX9XYJvLQZN/UQkA70r56BmTAmHGl6+Iny+YR+dx/2EPvtQqhssDRZqC5hF5y7Uzqi6nXCX6d/a8apteDCyLUOMIJl+yGv0BFQsvadDFbfoFZlI20lWdSX0XBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tY3zEhYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B13C4CEF7;
	Wed,  4 Feb 2026 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219027;
	bh=HCI02s3xp5ahZixVx+wY2DOZhxQL9fBqGNt1JUAfE/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tY3zEhYMEaUIZ7hXSJQrkHNXyd85aR8AdeYtR4gMT83f62qWoSjR1ZQtFW+I1MJqo
	 ToGq3/1agFs/D+1uhYx6tSkToaoWvbSr60amlTGAJMc20IREGmMA/k7w+nJXg+Cgkw
	 N07+s5rFFI9nyitZuMTbo6N6feknQw9vKZYiSR1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 045/122] gpio: brcmstb: correct hwirq to bank map
Date: Wed,  4 Feb 2026 15:40:27 +0100
Message-ID: <20260204143853.479773325@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,broadcom.com,kernel.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-214239-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,broadcom.com:email]
X-Rspamd-Queue-Id: 9B149E97BF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit b2cf569ed81e7574d4287eaf3b2c38690a934d34 ]

The brcmstb_gpio_hwirq_to_bank() function was designed to
accommodate the downward numbering of dynamic GPIOs by
traversing the bank list in the reverse order. However, the
dynamic numbering has changed to increment upward which can
produce an incorrect mapping.

The function is modified to no longer assume an ordering of
the list to accommodate either option.

Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260127214656.447333-2-florian.fainelli@broadcom.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-brcmstb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index f40c9472588bc..f0cb1991b326c 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -301,12 +301,10 @@ static struct brcmstb_gpio_bank *brcmstb_gpio_hwirq_to_bank(
 		struct brcmstb_gpio_priv *priv, irq_hw_number_t hwirq)
 {
 	struct brcmstb_gpio_bank *bank;
-	int i = 0;
 
-	/* banks are in descending order */
-	list_for_each_entry_reverse(bank, &priv->bank_list, node) {
-		i += bank->chip.gc.ngpio;
-		if (hwirq < i)
+	list_for_each_entry(bank, &priv->bank_list, node) {
+		if (hwirq >= bank->chip.gc.offset &&
+		    hwirq < (bank->chip.gc.offset + bank->chip.gc.ngpio))
 			return bank;
 	}
 	return NULL;
-- 
2.51.0





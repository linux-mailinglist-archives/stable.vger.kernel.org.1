Return-Path: <stable+bounces-243108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ia3MBWm+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F78F4BE3A7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDAEF30363BC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA03D6481;
	Mon,  4 May 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k55SnBLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C23DCD95;
	Mon,  4 May 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903038; cv=none; b=PTjl++DDBFvxl48Fon+xgbAPtG1l8axDWLrUd8BuRK8BYZ2fHAm87yZ/HUzbn0UVhuF80JXv4zSaEELRr3SWOPGLhStHUwC0h+J5CrsspkPZVc2cJmJknw+CuIikAWhcJw83R265KKkfS8Dh6CHZSWtClOskuftEzJvA0NnW5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903038; c=relaxed/simple;
	bh=HeYFmKrV2q9qk6Et/PvJA8xOx/Di3cQNN2NTUZdm4gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpfEBC03i0MPg0JuGa5/sZF0Kb/D/IvoG1ciD4ZDGoprqbwzNhLal9etoHAVHs2YtPhAlHPB4M8kFKD9v6L/p9aFTDtJROZzmKfBOxe144s7kk4wO6Wrehst/66FnQb0j12nuLsf0wg1Kt4xkm/TeiljFAKJZ1yOY+hIYo55d4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k55SnBLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC521C2BCB8;
	Mon,  4 May 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903038;
	bh=HeYFmKrV2q9qk6Et/PvJA8xOx/Di3cQNN2NTUZdm4gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k55SnBLtVZLrGyKlrLazvXWxq0TW+oRcHm3HZIYPkMoUvJLh7hUsYxk28rQ19rp3s
	 dlWfQ+4LF/EL4doSJPbKlNP1TcezJzirZsrjp15B0r28E4mwVGmOMxwSN3KraPwis5
	 2i9aOCfkZJytkLDtzbErfTcZ6ZvKatr9ni5F+QRQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 7.0 080/307] mfd: stpmic1: Attempt system shutdown twice in case PMIC is confused
Date: Mon,  4 May 2026 15:49:25 +0200
Message-ID: <20260504135145.822091629@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3F78F4BE3A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243108-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nabladev.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@nabladev.com>

commit ffdc5c51f8bcd0e5e8255ca275a0a3b958475d99 upstream.

Attempt to shut down again, in case the first attempt failed.
The STPMIC1 might get confused and the first regmap_update_bits()
returns with -ETIMEDOUT / -110 . If that or similar transient
failure occurs, try to shut down again. If the second attempt
fails, there is some bigger problem, report it to user.

Cc: stable@vger.kernel.org
Fixes: 6e9df38f359a ("mfd: stpmic1: Add PMIC poweroff via sys-off handler")
Signed-off-by: Marek Vasut <marex@nabladev.com>
Link: https://patch.msgid.link/20260122111423.62591-1-marex@nabladev.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/stpmic1.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -16,6 +16,8 @@
 
 #include <dt-bindings/mfd/st,stpmic1.h>
 
+#define STPMIC1_MAX_RETRIES 2
+
 #define STPMIC1_MAIN_IRQ 0
 
 static const struct regmap_range stpmic1_readable_ranges[] = {
@@ -121,9 +123,23 @@ static const struct regmap_irq_chip stpm
 static int stpmic1_power_off(struct sys_off_data *data)
 {
 	struct stpmic1 *ddata = data->cb_data;
+	int ret;
+
+	/*
+	 * Attempt to shut down again, in case the first attempt failed.
+	 * The STPMIC1 might get confused and the first regmap_update_bits()
+	 * returns with -ETIMEDOUT / -110 . If that or similar transient
+	 * failure occurs, try to shut down again. If the second attempt
+	 * fails, there is some bigger problem, report it to user.
+	 */
+	for (int retries = 0; retries < STPMIC1_MAX_RETRIES; retries++) {
+		ret = regmap_update_bits(ddata->regmap, MAIN_CR, SOFTWARE_SWITCH_OFF,
+					 SOFTWARE_SWITCH_OFF);
+		if (!ret)
+			return NOTIFY_DONE;
+	}
 
-	regmap_update_bits(ddata->regmap, MAIN_CR,
-			   SOFTWARE_SWITCH_OFF, SOFTWARE_SWITCH_OFF);
+	dev_err(ddata->dev, "Failed to access PMIC I2C bus (%d)\n", ret);
 
 	return NOTIFY_DONE;
 }




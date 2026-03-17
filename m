Return-Path: <stable+bounces-226764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAUqIeyUuWk2KwIAu9opvQ
	(envelope-from <stable+bounces-226764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:52:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87F2B049A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90942332D795
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF6032548B;
	Tue, 17 Mar 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UE3WOfAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1931E841;
	Tue, 17 Mar 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768108; cv=none; b=sGUMOPMaZg7N0o+3aHd+VapDhkA0fWBKURVVqGJbZBjy/DULuOFxq36dku15xw84wDc/XP7sCg8rzQnZZFiWWkaAa7ZwteaJjcI8HXgOVB+hrXoQNRQCmMGuThfu37m0y2Xul3LCra2JzXSh4Wc/N/pQr57/b41OQU3K6iobWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768108; c=relaxed/simple;
	bh=K0rZEf3dKkp9xEuYj+6/rYoxzoxCIrhILCl/ZQWrQUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UztCLfIhwcaWfPDdWQ7ppyKX1Ii95wZRdjdKzldbqdUebH0pIf2Y6JDsf0MfxmVOo6V4Bf2EWpokdVynP0sY8F8tdt63xpstCHfrw/IaDYL5qQQCuIQfnUMusoDGVldqm2ThARV90bN7s5xsndvxlgT9k9Nj+dsLXmvvJMCo1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UE3WOfAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC9EC4CEF7;
	Tue, 17 Mar 2026 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768108;
	bh=K0rZEf3dKkp9xEuYj+6/rYoxzoxCIrhILCl/ZQWrQUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UE3WOfAbhhhYG6UaYgQCPDWcQB2EsDIxex08QnxpbvJ8uw+7U5fxCDFl75QsIv5RH
	 hSC5LnPiiFgZvgUxnVbC7IFxl0s1dsn5Q+gQlXrfTWMZY21ftBFYGMRaMQj5ogIRBR
	 +TDY06CWNndfEQj95xmD+JaHTF0JS75dT8BnZMvE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Franz Schnyder <franz.schnyder@toradex.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 232/333] regulator: pf9453: Respect IRQ trigger settings from firmware
Date: Tue, 17 Mar 2026 17:34:21 +0100
Message-ID: <20260317163007.968966068@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226764-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C87F2B049A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Franz Schnyder <franz.schnyder@toradex.com>

commit 2d85ecd6fb0eb2fee0ffa040ec1ddea57b09bc38 upstream.

The datasheet specifies, that the IRQ_B pin is pulled low when any
unmasked interrupt bit status is changed, and it is released high once
the application processor reads the INT1 register. As it specifies a
level-low behavior, it should not force a falling-edge interrupt.

Remove the IRQF_TRIGGER_FALLING to not force the falling-edge interrupt
and instead rely on the flag from the device tree.

Fixes: 0959b6706325 ("regulator: pf9453: add PMIC PF9453 support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
Link: https://patch.msgid.link/20260218102518.238943-2-fra.schnyder@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/pf9453-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/regulator/pf9453-regulator.c
+++ b/drivers/regulator/pf9453-regulator.c
@@ -819,7 +819,7 @@ static int pf9453_i2c_probe(struct i2c_c
 	}
 
 	ret = devm_request_threaded_irq(pf9453->dev, pf9453->irq, NULL, pf9453_irq_handler,
-					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					IRQF_ONESHOT,
 					"pf9453-irq", pf9453);
 	if (ret)
 		return dev_err_probe(pf9453->dev, ret, "Failed to request IRQ: %d\n", pf9453->irq);




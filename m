Return-Path: <stable+bounces-213816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBCWFPVkg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0818E8850
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20EA30EA954
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DC426D11;
	Wed,  4 Feb 2026 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QviMOixz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF68426D06;
	Wed,  4 Feb 2026 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217606; cv=none; b=FK0iXCOc1ml6atJdwVtpCbFk5iSpkoNtjQ2D+idK0rM2Zc87l20t9OV8AAFpGLKDlFiENBFOHHJLEEXa82BZsbH63jIlD0gcA4cWWlGUYAryowbMFOg3NfMfpa9WsGuiVthqwF91nK/yWIt0JivbqDaeCUqelqYHwloxgMn5qxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217606; c=relaxed/simple;
	bh=puE2166XQoEqLX1E/0wZAHvXKc/hlT0n1yEezxGbSfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBAwzOFIiewd+BNkvFmNWePZgM5MAzcLP7hyEDr4pjqd7EuLJYHE2S7W0FeVuLhArl9TC7xDfZWm3KbM9SNGNyj20uVZkM0c6GWz8BH7sFB+wit1S8VFvY9deG97smaoVvT9pm1M7F5undiY2P4611nerAZper5R5AQ5pjRawPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QviMOixz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA467C116C6;
	Wed,  4 Feb 2026 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217606;
	bh=puE2166XQoEqLX1E/0wZAHvXKc/hlT0n1yEezxGbSfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QviMOixz/0EGYpvFUQH4FAcvgxzaaHrubxAd7ynmJF2yrSoLOYe+Ej/aEAD6rjuAY
	 D9aeXXWWvL/STyX1Q91ryy7wrxEness/BBw9U3oWQddyxESEkohDIFEIYlUo1PhZ+R
	 eIuduXJ5H/qvYwwBgR4DMdyyUHsVbTSL1yVbm0XQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Gompa <neal@gompa.dev>,
	Janne Grunau <j@jannau.net>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 066/280] dmaengine: apple-admac: Add "apple,t8103-admac" compatible
Date: Wed,  4 Feb 2026 15:37:20 +0100
Message-ID: <20260204143912.030537962@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213816-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gompa.dev:email]
X-Rspamd-Queue-Id: D0818E8850
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janne Grunau <j@jannau.net>

commit 76cba1e60b69c9cd53b9127d017a7dc5945455b1 upstream.

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,admac" anymore [1]. Use
"apple,t8103-admac" as base compatible as it is the SoC the driver and
bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Cc: stable@vger.kernel.org
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
Link: https://patch.msgid.link/20251231-apple-admac-t8103-base-compat-v1-1-ec24a3708f76@jannau.net
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/apple-admac.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -937,6 +937,7 @@ static int admac_remove(struct platform_
 }
 
 static const struct of_device_id admac_of_match[] = {
+	{ .compatible = "apple,t8103-admac", },
 	{ .compatible = "apple,admac", },
 	{ }
 };




Return-Path: <stable+bounces-230902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHNlNK0myWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BD3522A1
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E3F03016246
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F337474A;
	Sun, 29 Mar 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RdLkBT5y"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD76374E6D
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790300; cv=none; b=B0MEhWf/x3keqVeyv89YKROJJXyKUqMuDBZD2olQVts4tFKktd+YsyRVqmfg7BPT9Z+Oqywa9lOoAvm8AEbA6r0R9Kg/FaloDgOQWo3gsrA9eSqOdXv+KupfCkbEZWFFy/+289p7B5W4T3gGKdV0SFPxnP0rCRW3c+gonzW+wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790300; c=relaxed/simple;
	bh=y2P83wKRehTdey/wXhXQhHXFV2PIJpY9vSNo4cPkzg8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=k8fqP3H6BUrPzExgzRzVL5rH2QoafbHhciI5Nougqv9TFl2gOVCPH6lElXgxSqvHyvNOw0gL1FztWZIEgaylaG5OxAW853tJ9FDGrp/KgxnnOm2S6Ow0zd6b4NXiCqWNnWhnzWMLgK7QSjiyjUQXxId/6oXi93Mz1lsqIso/Dgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RdLkBT5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEAAC2BCB1;
	Sun, 29 Mar 2026 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790299;
	bh=y2P83wKRehTdey/wXhXQhHXFV2PIJpY9vSNo4cPkzg8=;
	h=Subject:To:From:Date:From;
	b=RdLkBT5yWW06i0orGMpRUy/uXPgaxgOuWglE7QmmG+X1pbpf3DW2MAqZxqTaJ7iN4
	 fCEde0ZSKkc12VqF5GmlWTlai3aL8qCkpnQ8XaHILiVo5wjkhawye4FUMLRGuoCD9u
	 NYmijF6CFiSZxYz6V1v2shuubRsQ+pcnP4tTso28=
Subject: patch "iio: adc: ade9000: fix wrong return type in streaming push" added to char-misc-linus
To: giorgitchankvetadze1997@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,antoniu.miclaus@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:09 +0200
Message-ID: <2026032909-upload-krypton-86b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230902-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org,analog.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,analog.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 537BD3522A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: fix wrong return type in streaming push

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 57b207e38d414a27fda9fff638a0d3e7ef16b917 Mon Sep 17 00:00:00 2001
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Tue, 24 Feb 2026 17:23:55 +0400
Subject: iio: adc: ade9000: fix wrong return type in streaming push

The else branch of ade9000_iio_push_streaming() incorrectly returns
IRQ_HANDLED on regmap_write failure. This function returns int (0 on
success, negative errno on failure), so IRQ_HANDLED (1) would be
misinterpreted as a non-error by callers.

Return ret instead, consistent with every other error path in the
function.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 945a159e5de6..1abbfdfcd554 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -787,7 +787,7 @@ static int ade9000_iio_push_streaming(struct iio_dev *indio_dev)
 				   ADE9000_MIDDLE_PAGE_BIT);
 		if (ret) {
 			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
-			return IRQ_HANDLED;
+			return ret;
 		}
 
 		ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);
-- 
2.53.0




Return-Path: <stable+bounces-230900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNufDJwmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD245352274
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D469300599C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0410C374722;
	Sun, 29 Mar 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtRBan08"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908A2FD7D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790296; cv=none; b=C6PzDlWLCTTDOFZwN7wk6H5uQ365r7LyHAzXKelHOe/6VUwLoyO409lV3f0D53ivPbPf4xUWMa3+wsA7WGg25G5ljokriNKTz8MqWBai/2Q1e8P4o7wDaUouNmSCkk2U7l55KxXn4+0J4tzgEaKSRYk+Lpva4mw0iSu870xTUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790296; c=relaxed/simple;
	bh=t60l10PbFOUJdfo4xtQXo1rSEJzPBzRAgI7pGO6BgWk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=nsHkrTKJY5zyDdBQLZ9Jjy1zQ+sFUzJqF1N+apOZoSMDnU5xGEa4R6rkAJYBkZZqB/StLzNuz62qPPhn/ddeUSq+j99U8GX53LUl1FXjoBPFUpEq7jde8QzvWrGt/3O1HM9yqiu1HpprNCfdSwRTIZ3xT+lP/SDulqrpKWIbdYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtRBan08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A19C116C6;
	Sun, 29 Mar 2026 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790296;
	bh=t60l10PbFOUJdfo4xtQXo1rSEJzPBzRAgI7pGO6BgWk=;
	h=Subject:To:From:Date:From;
	b=JtRBan081MuuyKs+HlcIqvIitC5DPGGE99xVZWvkdXMj28nKzAbjlCVFmlWxjweCW
	 QOB7L4uw5OYtT+2ZE3XOl4Xc53imUlvTM6VtYuGn+wAmrx3dxLRJZgzXmOqdHqppZu
	 xBDhApR9qUgpf6VkfPOxjKpqV2Yx8C86UpCOv30M=
Subject: patch "iio: adc: ade9000: move mutex init before IRQ registration" added to char-misc-linus
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:08 +0200
Message-ID: <2026032908-laptop-subsidy-e780@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230900-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,analog.com:email,huawei.com:email]
X-Rspamd-Queue-Id: BD245352274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: move mutex init before IRQ registration

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 0206dd36418c104c0b3dea4ed7047e21eccb30b0 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 27 Feb 2026 15:33:30 +0200
Subject: iio: adc: ade9000: move mutex init before IRQ registration

Move devm_mutex_init() before ade9000_request_irq() calls so that
st->lock is initialized before any handler that depends on it can run.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ade9000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index db085dc5e526..c62c6480dd0a 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1706,6 +1706,10 @@ static int ade9000_probe(struct spi_device *spi)
 
 	init_completion(&st->reset_completion);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
 	if (ret)
 		return ret;
@@ -1718,10 +1722,6 @@ static int ade9000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_mutex_init(dev, &st->lock);
-	if (ret)
-		return ret;
-
 	/* External CMOS clock input (optional - crystal can be used instead) */
 	st->clkin = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(st->clkin))
-- 
2.53.0




Return-Path: <stable+bounces-230898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFtvKp0myWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7435227B
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A12A3015496
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0627FD75;
	Sun, 29 Mar 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1efTGZtu"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419237474A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790286; cv=none; b=BxtmvgcIwG6i6LYdlzQf1Q8J2tjULv04cRx1WeU4t4/2ikM3WfCV3kG/kyMYO7+fHfY8Ihk7FxBinzQxYHcUQfLIX8710rJtXRgIg6+7UaRiRJ3Mk1z664grt79mEAUiicu7BnfjDWSwxaGeF5vMEifq0I8F6+7K3EfEtNtceYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790286; c=relaxed/simple;
	bh=MqLY/OmW7ChbcRNEEnyMddeXNq0k9wQ75+maPDPqIoE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rIvi3hnG/eYoFiqVRc4kz4gCwXbPqmpPUgrdLhtC+l4NpDCteTeN35YeRlCMDhH/1JaXQ0vIWmqUp4g8ZF6iw7s5jn85QU/0vgVq7UtvLLa85svSlmDDnyL2D/TIG5+8NZwjLI5O4cRBSzfFIEpbxOHwl0sUO7K22Uy2HRgyWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1efTGZtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E83FC116C6;
	Sun, 29 Mar 2026 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790285;
	bh=MqLY/OmW7ChbcRNEEnyMddeXNq0k9wQ75+maPDPqIoE=;
	h=Subject:To:From:Date:From;
	b=1efTGZtuTwV2/W2IQ9YLaNjD+XvYaDMEAujUiPd3egQh7TwyKKI3jURQHUknmUF7b
	 dDUrYO8DM1PO89C53GWbjIM29xYiyY7RaOyMlIFUphA87W7RuJQsn426SH0QDP6ARE
	 YPzqzmaNYjV7Jmsayg5O//5fb8DKcDh1dxP+4AIE=
Subject: patch "iio: adc: ti-ads1119: Fix unbalanced pm reference count in" added to char-misc-linus
To: ustc.gu@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,jpaulo.silvagoncalves@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:07 +0200
Message-ID: <2026032907-impound-chamomile-af15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230898-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 25E7435227B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1119: Fix unbalanced pm reference count in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 48a5c36577ebe0144f8ede70e59b59ea18b75089 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 28 Feb 2026 01:48:19 +0800
Subject: iio: adc: ti-ads1119: Fix unbalanced pm reference count in
 ds1119_single_conversion()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In ads1119_single_conversion(), if pm_runtime_resume_and_get() fails,
the code jumps to the pdown label, which calls
pm_runtime_put_autosuspend().

Since pm_runtime_resume_and_get() automatically decrements the usage
counter on failure, the subsequent call to pm_runtime_put_autosuspend()
causes an unbalanced reference counter.

Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index c9cedc59cdcd..4454f28b2b58 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -274,7 +274,7 @@ static int ads1119_single_conversion(struct ads1119_state *st,
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
-		goto pdown;
+		return ret;
 
 	ret = ads1119_configure_channel(st, mux, gain, datarate);
 	if (ret)
-- 
2.53.0




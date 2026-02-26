Return-Path: <stable+bounces-219874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JI/KNfcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1D51B10BB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CE2D3019E3D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752F32E729;
	Thu, 26 Feb 2026 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpQz52Hw"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79B32E732
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149965; cv=none; b=gsgZeBxM0TmBoHLr8EHigBVeJEp7ISF3KeEL9Z4PlgkpqW7HnvIZQ9ZjE2mIfWUvzmwuJwniO8iSFU+y7vls6k67qYfYczAdKkorETI/Ykl2j0zZ1EvGx/13IslgFyfbiHMhALmcf2kxCjrShLpxW3etEtDS+VBW3X5Iz9mdE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149965; c=relaxed/simple;
	bh=2LQz5eSYa8eQNR73DpY12D+lNk2IPV86r4irqcPL4Rw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=lybwZJZkIBlHK7Qfbiu1x0SfW6fXAhZm96pc3kWVWVi5V1TFcA3evosRZ5dpG/wjLja/NMxnL4TUAABuNzh/JwRaDaa4sLA7u+tcIR8FppgwTQZqtlCGSdAPMdmO/wh39Hy3+R8LKFk35bw1n52oMwydM/YRaV7q16XMj9+HeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpQz52Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D573C116C6;
	Thu, 26 Feb 2026 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149965;
	bh=2LQz5eSYa8eQNR73DpY12D+lNk2IPV86r4irqcPL4Rw=;
	h=Subject:To:From:Date:From;
	b=UpQz52HwLU8H+pm9yvt/K/pj3CMntk7o/Mt4XeM+Bj3B7+mJRX0dDQpw4KScfjDjl
	 nN5627lJABVYTS//APwawYIpg1raA6LGSdBxDp6zGJOHYTVjALKd3bo3UqR6boO8sA
	 KTMXC5yx1WmWFszexqd+XQ/vtek6Ga/12Cv7niw8=
Subject: patch "iio: potentiometer: mcp4131: fix double application of wiper shift" added to char-misc-linus
To: lukas.schmid@netcube.li,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:34 -0800
Message-ID: <2026022634-cruelly-finale-bba2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219874-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BD1D51B10BB
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: potentiometer: mcp4131: fix double application of wiper shift

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 85e4614524dca6c0a43874f475a17de2b9725648 Mon Sep 17 00:00:00 2001
From: Lukas Schmid <lukas.schmid@netcube.li>
Date: Mon, 2 Feb 2026 21:15:35 +0100
Subject: iio: potentiometer: mcp4131: fix double application of wiper shift

The MCP4131 wiper address is shifted twice when preparing the SPI
command in mcp4131_write_raw().

The address is already shifted when assigned to the local variable
"address", but is then shifted again when written to data->buf[0].
This results in an incorrect command being sent to the device and
breaks wiper writes to the second channel.

Remove the second shift and use the pre-shifted address directly
when composing the SPI transfer.

Fixes: 22d199a53910 ("iio: potentiometer: add driver for Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X")
Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>#
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiometer/mcp4131.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index ad082827aad5..56c9111ef5e8 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -221,7 +221,7 @@ static int mcp4131_write_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 
-	data->buf[0] = address << MCP4131_WIPER_SHIFT;
+	data->buf[0] = address;
 	data->buf[0] |= MCP4131_WRITE | (val >> 8);
 	data->buf[1] = val & 0xFF; /* 8 bits here */
 
-- 
2.53.0




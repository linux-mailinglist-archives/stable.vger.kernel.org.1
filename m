Return-Path: <stable+bounces-213081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJzuEBHTgGlBBwMAu9opvQ
	(envelope-from <stable+bounces-213081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:38:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98034CF0FD
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 531A6309A1C8
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B41378804;
	Mon,  2 Feb 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IXYly0QJ"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2323278D
	for <Stable@vger.kernel.org>; Mon,  2 Feb 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049863; cv=none; b=vF/d2WzhXWbMuOh1mTwHGDbRwwTYGvY/hOPAFXDaY6YqtEohpLsU7xDYzpTu81OSP5pXbrKZXxREtDN3ZMIVkaVjCBb2EArFeL2F8eSieiJpcbFfw06RwWlInULKkuUOLrfRankXldVBZl8yFjPlOBzU6lPsS7L4me9gI9RCSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049863; c=relaxed/simple;
	bh=xzw0bKN22ni6DjoVH4CzWiSJkubODpSfkmGaUs2AySc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ETQ5Hv8+dhPI7LTA5xCMXLLC/nJ73GUv6ZSQe3VRqd02CpdSLyeP+Y69fvrCde1JbVPyN4rB7dUl+enUL9a1Ey6sKmnBu2ZwfvS5odeBKXPn5goiv5Zmot3GRNMDmB9UMjQMp20olJbvLCFGyTfRhlQ0Yx/mZ62FD53wsCkz2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IXYly0QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEF2C116C6;
	Mon,  2 Feb 2026 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770049863;
	bh=xzw0bKN22ni6DjoVH4CzWiSJkubODpSfkmGaUs2AySc=;
	h=Subject:To:From:Date:From;
	b=IXYly0QJzawyteZ29pWyjwtAqvDCTItyAStQG7Qi+fs3F04Y5TSEOVsoGS5eIa4W3
	 oYw4gNyd7t1CjmzIvHQO0ghRtuh8vkhwj6Q0MwGYOLFHaT7ffRYDP/ym+vTZv2zGrw
	 Ta/7H5Lx6e3qQAnVDYD1NKWZOX65JLE/0x5Rh73g=
Subject: patch "iio: accel: adxl380: Avoid reading more entries than present in FIFO" added to char-misc-next
To: flavra@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Feb 2026 17:14:56 +0100
Message-ID: <2026020256-detract-liquefy-3ac3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213081-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98034CF0FD
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: accel: adxl380: Avoid reading more entries than present in FIFO

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c1b14015224cfcccd5356333763f2f4f401bd810 Mon Sep 17 00:00:00 2001
From: Francesco Lavra <flavra@baylibre.com>
Date: Mon, 19 Jan 2026 11:23:16 +0100
Subject: iio: accel: adxl380: Avoid reading more entries than present in FIFO

The interrupt handler reads FIFO entries in batches of N samples, where N
is the number of scan elements that have been enabled. However, the sensor
fills the FIFO one sample at a time, even when more than one channel is
enabled. Therefore,the number of entries reported by the FIFO status
registers may not be a multiple of N; if this number is not a multiple, the
number of entries read from the FIFO may exceed the number of entries
actually present.

To fix the above issue, round down the number of FIFO entries read from the
status registers so that it is always a multiple of N.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index ba550142866a..a77c2323d1aa 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -966,6 +966,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
 		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
 					&st->fifo_buf[i],
-- 
2.52.0




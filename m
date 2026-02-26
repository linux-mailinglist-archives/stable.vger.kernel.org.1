Return-Path: <stable+bounces-219882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM0wKOjcoGmMngQAu9opvQ
	(envelope-from <stable+bounces-219882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:53:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F431B10EF
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D8F3025E2E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 23:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1332E758;
	Thu, 26 Feb 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kayr84Qo"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6932ABC4
	for <Stable@vger.kernel.org>; Thu, 26 Feb 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772149973; cv=none; b=ZNxxO5rmsX6e52zWYasYRi1BM9mkATXHn5j+Tou1uj+CZW4z4mrerY4rfqBFATOBPQkuaU+Lkgc4ZdTvuH/0VMok7recMQhBHQd22RRz8wNhD4/Ucwmabx9s2uVE3LJpG9psxeC4kOwf0UTUgAR9x6wo+hK56uFPReLL9nicSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772149973; c=relaxed/simple;
	bh=2Ag+M+5ZkYzUrlnofVRrrl4Cq0bSWToi/N4fm5J4zjg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=A48Rar+5+nc0RgdLPgouw9nK3Yp0T78y+tFfy0cihAYbVIsHT+6q/lbVY2Zf6Yi5nWk3Nl/BvelliI7g7w1f3bOoMSNDyQetvVZvmEFlfOO37ydZ1te3VOzCmILV0Y0FXKBJJoZ5z0qPA4DXh3WkDJhabXGZbqZ6Gs/pl/87L34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kayr84Qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21D1C116C6;
	Thu, 26 Feb 2026 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772149972;
	bh=2Ag+M+5ZkYzUrlnofVRrrl4Cq0bSWToi/N4fm5J4zjg=;
	h=Subject:To:From:Date:From;
	b=kayr84QoO5M/lW2UpVHaIhP4V2utl/e/puBUfe5zAeD/pMbDuh26wQjjiUuPDRQZ3
	 53lqD1USBIz6VMI9N2MxKvsSabLNjQnJkMwArLJweI6OzWDu+qEWNMqGKJB4jdkT3D
	 UzoKM81nEQOMtdHoPvka/j1FolOx6d9i7lMLLWkA=
Subject: patch "iio: buffer: Fix wait_queue not being removed" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 26 Feb 2026 15:52:36 -0800
Message-ID: <2026022636-affront-rectified-832e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219882-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,analog.com:email]
X-Rspamd-Queue-Id: C9F431B10EF
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: buffer: Fix wait_queue not being removed

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 064234044056c93a3719d6893e6e5a26a94a61b6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 16 Feb 2026 13:24:27 +0000
Subject: iio: buffer: Fix wait_queue not being removed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the edge case where the IIO device is unregistered while we're
buffering, we were directly returning an error without removing the wait
queue. Instead, set 'ret' and break out of the loop.

Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f15a180dc49e..46f36a6ed271 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -228,8 +228,10 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 	written = 0;
 	add_wait_queue(&rb->pollq, &wait);
 	do {
-		if (!indio_dev->info)
-			return -ENODEV;
+		if (!indio_dev->info) {
+			ret = -ENODEV;
+			break;
+		}
 
 		if (!iio_buffer_space_available(rb)) {
 			if (signal_pending(current)) {
-- 
2.53.0




Return-Path: <stable+bounces-230915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPR8M9cmyWm/vAUAu9opvQ
	(envelope-from <stable+bounces-230915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D4B3522F0
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125543004C91
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD731F98C;
	Sun, 29 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y7SGSZ45"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB3280A5A
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790352; cv=none; b=vAv3jS/Jo3j77HLlFCBTVcN6P/MDIyRItfPcPgb5r2xJG64znhddi54lE7sb/ue+8rZPQyXMnx2VX+n5NkWoB5hAMt0hJOUJpCptV2ucN25KDv2nJ0UjAbqUr8yBIp0IDOkrT+pRvn7d4rRaajGwUG/1DARbo+WL9mhLpiOXGOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790352; c=relaxed/simple;
	bh=LtDOzgwtYW9QFDa9xorKTq6xi6KmmuDAfEMsTbiEYDI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=MCj4Z/stjC5r+azc1R3b2Dhewh59DhbYQj2BVA1iD5HKmTh6j+FTaoYUeUQ7HTE9b+CgFHbq7VUtFlkzMfLT6srX3TsQaKLrrDqJSkPRiR3iSNxIUZme57yJVfaJ9WsJTdR95/oPGQYuziFTbAIFKfTh9qdB34Z8ig8bw4W3Cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y7SGSZ45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B464C116C6;
	Sun, 29 Mar 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790352;
	bh=LtDOzgwtYW9QFDa9xorKTq6xi6KmmuDAfEMsTbiEYDI=;
	h=Subject:To:From:Date:From;
	b=Y7SGSZ45UAFneDxqyEy3X4Sy29JeAo242M+UmM7X9ySNIVAOihVPkaGMLhDIfF0u3
	 mIVuoa0vUpmTE3w4z+ubbKGvW9+HNp76rYOWbjQcL5Wwmh236r7xp8IooneIy5QNXu
	 lNyh2rpmvFRD0fqSYeh9jGXuh/cvtQwJsUgXRJLM=
Subject: patch "iio: orientation: hid-sensor-rotation: fix quaternion alignment" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,lixu.zhang@intel.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 14:50:15 +0200
Message-ID: <2026032915-deviant-harmony-5863@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230915-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,baylibre.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F0D4B3522F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: orientation: hid-sensor-rotation: fix quaternion alignment

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 50d4cc74b8a720a9682a9c94f7e62a5de6b2ed3a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Feb 2026 14:02:23 -0600
Subject: iio: orientation: hid-sensor-rotation: fix quaternion alignment

Restore the alignment of sampled_vals to 16 bytes by using
IIO_DECLARE_QUATERNION(). This field contains a quaternion value which
has scan_type.repeat = 4 and storagebits = 32. So the alignment must
be 16 bytes to match the assumptions of iio_storage_bytes_for_si() and
also to not break userspace.

Reported-by: Lixu Zhang <lixu.zhang@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221077
Fixes: b31a74075cb4 ("iio: orientation: hid-sensor-rotation: remove unnecessary alignment")
Tested-by: Lixu Zhang <lixu.zhang@intel.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/orientation/hid-sensor-rotation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e759f91a710a..6806481873be 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -19,7 +19,7 @@ struct dev_rot_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
-		s32 sampled_vals[4];
+		IIO_DECLARE_QUATERNION(s32, sampled_vals);
 		aligned_s64 timestamp;
 	} scan;
 	int scale_pre_decml;
-- 
2.53.0




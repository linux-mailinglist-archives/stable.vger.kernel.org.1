Return-Path: <stable+bounces-68918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D4795349B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B821C231EA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA21A00DF;
	Thu, 15 Aug 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u66jeYm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80863C;
	Thu, 15 Aug 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732081; cv=none; b=dZmQI0ARnZRuQkN3wkSN913Uo4btt6+1fdRSRsUeo0dqUEgA2gNslOK5Bv0JX08J2zvp45VBIlNwJagx6sBcRx6kB1YzeA0SKQLIBlLCQ01d9Zu3UTgUGznVggRRriQDkC72JFQ/pAvfZw7b4uPqHZiBxC8wF5TuVuFApRDdjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732081; c=relaxed/simple;
	bh=d0jtqOuJpxo1cRqQ8AbSkENIWtquMFs7X5cEwmUmxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtKkp6acQ2tpEHrTn9HDZorEtVlCVvHm8250OpQoo9N1wi92nfNzPfBp8ggpQx9LaO7twXCGF9e3Qr74Qo9fz5HR6275b3LFayFuiBGyPorTU521Y+3ixiglpmKvd1QsgdHzA3EwNk35WGyR6d7bbVXMVsvsKJQ0pdAzEVqCYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u66jeYm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1DC4AF0C;
	Thu, 15 Aug 2024 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732081;
	bh=d0jtqOuJpxo1cRqQ8AbSkENIWtquMFs7X5cEwmUmxEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u66jeYm8zROPiBEFg439MITf0a8cqfGYccAnCB3ELh3NguzhXbW0dWuGNS4mABT/W
	 DNovcgfbavB8wg925y50zqADYIOOl/nGH29lZWw2CbOJDHaMr26OvRPACajekDaA7k
	 c5pbz/fgFtS+Iaeo9xAFIwXUm46m5tj/V9ihSbss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 068/352] media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()
Date: Thu, 15 Aug 2024 15:22:14 +0200
Message-ID: <20240815131921.871240885@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 2052138b7da52ad5ccaf74f736d00f39a1c9198c ]

Infinite log printing occurs during fuzz test:

  rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
  ...
  dvb-usb: schedule remote query interval to 100 msecs.
  dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
  dvb-usb: bulk message failed: -22 (1/0)
  dvb-usb: bulk message failed: -22 (1/0)
  dvb-usb: bulk message failed: -22 (1/0)
  ...
  dvb-usb: bulk message failed: -22 (1/0)

Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
that is in rc_core_dvb_usb_remote_init() create a work that will call
dvb_usb_read_remote_control(), and this work will reschedule itself at
'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
see following code snippet:

  rc_core_dvb_usb_remote_init() {
    ...
    INIT_DELAYED_WORK(&d->rc_query_work, dvb_usb_read_remote_control);
    schedule_delayed_work(&d->rc_query_work,
                          msecs_to_jiffies(rc_interval));
    ...
  }

  dvb_usb_read_remote_control() {
    ...
    err = d->props.rc.core.rc_query(d);
    if (err)
      err(...)  // Did not return even if query failed
    schedule_delayed_work(&d->rc_query_work,
                          msecs_to_jiffies(rc_interval));
  }

When the infinite log printing occurs, the query callback
'd->props.rc.core.rc_query' is cxusb_rc_query(). And the log is due to
the failure of finding a valid 'generic_bulk_ctrl_endpoint'
in usb_bulk_msg(), see following code snippet:

  cxusb_rc_query() {
    cxusb_ctrl_msg() {
      dvb_usb_generic_rw() {
        ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
                           d->props.generic_bulk_ctrl_endpoint),...);
        if (ret)
          err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
          ...
      }
  ...
  }

By analyzing the corresponding USB descriptor, it shows that the
bNumEndpoints is 0 in its interface descriptor, but
the 'generic_bulk_ctrl_endpoint' is 1, that means user don't configure
a valid endpoint for 'generic_bulk_ctrl_endpoint', therefore this
'invalid' USB device should be rejected before it calls into
dvb_usb_read_remote_control().

To fix it, we need to add endpoint check for 'generic_bulk_ctrl_endpoint'.
And as Sean suggested, the same check and clear halts should be done for
'generic_bulk_ctrl_endpoint_response'. So introduce
dvb_usb_check_bulk_endpoint() to do it for both of them.

Fixes: 4d43e13f723e ("V4L/DVB (4643): Multi-input patch for DVB-USB device")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 35 +++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 58eea8ab54779..6cf6d08cc4ec9 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -23,11 +23,40 @@ static int dvb_usb_force_pid_filter_usage;
 module_param_named(force_pid_filter_usage, dvb_usb_force_pid_filter_usage, int, 0444);
 MODULE_PARM_DESC(force_pid_filter_usage, "force all dvb-usb-devices to use a PID filter, if any (default: 0).");
 
+static int dvb_usb_check_bulk_endpoint(struct dvb_usb_device *d, u8 endpoint)
+{
+	if (endpoint) {
+		int ret;
+
+		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev, endpoint));
+		if (ret)
+			return ret;
+		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void dvb_usb_clear_halt(struct dvb_usb_device *d, u8 endpoint)
+{
+	if (endpoint) {
+		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, endpoint));
+		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, endpoint));
+	}
+}
+
 static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 {
 	struct dvb_usb_adapter *adap;
 	int ret, n, o;
 
+	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint);
+	if (ret)
+		return ret;
+	ret = dvb_usb_check_bulk_endpoint(d, d->props.generic_bulk_ctrl_endpoint_response);
+	if (ret)
+		return ret;
 	for (n = 0; n < d->props.num_adapters; n++) {
 		adap = &d->adapter[n];
 		adap->dev = d;
@@ -103,10 +132,8 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	 * when reloading the driver w/o replugging the device
 	 * sometimes a timeout occurs, this helps
 	 */
-	if (d->props.generic_bulk_ctrl_endpoint != 0) {
-		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
-		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
-	}
+	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint);
+	dvb_usb_clear_halt(d, d->props.generic_bulk_ctrl_endpoint_response);
 
 	return 0;
 
-- 
2.43.0





Return-Path: <stable+bounces-87395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA129A64C7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5221F21488
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7E1F8F01;
	Mon, 21 Oct 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qZz5zMRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C11F8EF7;
	Mon, 21 Oct 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507478; cv=none; b=bjN1Hl2ZZmzAcYcWby5rUTJhn549KfEzzbB0JOMVml5x4oxWg+r17Grj/5K8B42U//yVUOJFtS9OP9RShtj2YfvASS/eGhGbm+6ICLl9w9mrzWBdE8okPeSsy8fJ51E86c3803hOkNzm0uSluKlS6iwuUXzSGm6RWcmgbrX/4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507478; c=relaxed/simple;
	bh=S4oWmPfrB9l39OGcFwT0nFnKGqTxGdm306yVX7pZDMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIE99NU8x4ma49nBYSt88SqAa69y4SM/MVgLBkxwQMsIyL5S+CC2uhwHpzj9Gop1N6fg9hk06F17S+q4FY3nTXxRhVByGRVBt/HgiLYdM0/Cd0FMHTsH71fUNyPnKQsTxvKDpK+Cnsdjo5FFGcx41Wekdhu5InP2aML/TQR6Uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qZz5zMRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E96C4CEE5;
	Mon, 21 Oct 2024 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507478;
	bh=S4oWmPfrB9l39OGcFwT0nFnKGqTxGdm306yVX7pZDMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZz5zMRjADAU5URxVjpgeC9JOBy6pFHvhTe6Yp/DOlad6YKnjvEMB0t/LfjZ4lVaU
	 R+NKAjm4aDKC4muyTD2kxOSuCZOI9auw33SSkY+awzjapxZtLOuR3EcU3WnahfGeHN
	 s4VklAES8pcvsMBmNNTfv9LsFV5rdxVBinfo3LaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 59/91] iio: hid-sensors: Fix an error handling path in _hid_sensor_set_report_latency()
Date: Mon, 21 Oct 2024 12:25:13 +0200
Message-ID: <20241021102252.122058664@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 3a29b84cf7fbf912a6ab1b9c886746f02b74ea25 upstream.

If hid_sensor_set_report_latency() fails, the error code should be returned
instead of a value likely to be interpreted as 'success'.

Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -32,7 +32,7 @@ static ssize_t _hid_sensor_set_report_la
 	latency = integer * 1000 + fract / 1000;
 	ret = hid_sensor_set_report_latency(attrb, latency);
 	if (ret < 0)
-		return len;
+		return ret;
 
 	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
 




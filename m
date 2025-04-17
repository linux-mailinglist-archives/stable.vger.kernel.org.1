Return-Path: <stable+bounces-133463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD67DA92649
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679D77B79BD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67525B68D;
	Thu, 17 Apr 2025 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNT0mSXx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C61EB1BF;
	Thu, 17 Apr 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913153; cv=none; b=K4cjTbMPIlUu5BLeVbdLt0NrEqPsTEXK8B3IdFPMvUK2dpJnZn3r6SD/EACU2zyqVzYaGHES2mJrZlJWV3vTGX+Yh8ywZcdbhseuONWJhhjKc4h9E7lNJ/po7QM8MTNIIyMeXauGVlugGB6GM6g/nDdS/wKvWS65tmcDXlBRnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913153; c=relaxed/simple;
	bh=QKwF1Pk2Dlf4fLE5T0oHC+1U/UcvKq4wvBScUArOE9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czuioE1TEqsg4wP9hS1d6srfcQh6/9qldlQx9CmFhU6oLJWDkYxpl14JfUSegmoJY+fL++Q1XcXwGcusqAP4C/H5Kdeyngz/AxVIyyBUsMwGUssWO4LfOcHlYSXSpZF7d3to9H6w21KLgjGkf4IjfflV8UMm9ZogrnxUwmO6nJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNT0mSXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103F0C4CEE4;
	Thu, 17 Apr 2025 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913153;
	bh=QKwF1Pk2Dlf4fLE5T0oHC+1U/UcvKq4wvBScUArOE9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNT0mSXxT5uziKo7FDalZi/mqB0mpWxMakzrrAJLigLy3i5lYJNtLLrsHS0KLT1y9
	 +UZF/KCH3bNKKLk0ApiHBmZQi5GYUlzU+NvJSTK6SK/Ph3mb3AZDeuWyrlIXONRMT+
	 MKDbDDOJp2l7nGzpbc/fISL0YCqyklnZj5saGRug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.14 245/449] media: hi556: Fix memory leak (on error) in hi556_check_hwcfg()
Date: Thu, 17 Apr 2025 19:48:53 +0200
Message-ID: <20250417175127.858103447@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit ed554da65abd0c561e40d35272d1a61d030fe977 upstream.

Commit 7d968b5badfc ("media: hi556: Return -EPROBE_DEFER if no endpoint is
found") moved the v4l2_fwnode_endpoint_alloc_parse() call in
hi556_check_hwcfg() up, but it did not make the error-exit paths between
the old and new call-site use "goto check_hwcfg_error;" to free the bus_cfg
on errors.

Add the missing "goto check_hwcfg_error;" statements to fix a memleak on
early error-exits from hi556_check_hwcfg().

Fixes: 7d968b5badfc ("media: hi556: Return -EPROBE_DEFER if no endpoint is found")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/hi556.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/hi556.c
+++ b/drivers/media/i2c/hi556.c
@@ -1230,12 +1230,13 @@ static int hi556_check_hwcfg(struct devi
 	ret = fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
 	if (ret) {
 		dev_err(dev, "can't get clock frequency");
-		return ret;
+		goto check_hwcfg_error;
 	}
 
 	if (mclk != HI556_MCLK) {
 		dev_err(dev, "external clock %d is not supported", mclk);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto check_hwcfg_error;
 	}
 
 	if (bus_cfg.bus.mipi_csi2.num_data_lanes != 2) {




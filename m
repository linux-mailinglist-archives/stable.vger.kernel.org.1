Return-Path: <stable+bounces-17067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E6E840FB2
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77601C2338C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61BD6FE19;
	Mon, 29 Jan 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jHvNlfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A816FE01;
	Mon, 29 Jan 2024 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548485; cv=none; b=P45OZSQUbBX9xDpCKr63sVfvwqzIAUx7JUhehEjNjvlKSxC7Q9yuUqVo+wOc/nyAFYZYVfzyI95ezGt9IO+t//fonsYYiGbi9396Ss7xXYd5ziy1GaG++diLimojCBY2fujTFDR+kMfDqyk8CN0x/JI5cP2NYW3SGc1GtkIe5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548485; c=relaxed/simple;
	bh=kthOad3VX0qOOa1TvC5l0w4z4Ecmt+kieqMoJvUe83o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQ3k9rB2akDRio77fEsuYaEbYRfrxBKlNYQ9I5aAkDsQ1m9v7wiOiThov3oUcRDkM0RxBzPMBofwWErHLtYSwHNpIWl2Di1BYQzBKICgQqaA3Oz5ZHOT56wFtZLinJTBfTDUytDXYcuS0WCUbwNlUMbwyhjqODCx6+jjgdfVMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jHvNlfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FEC433C7;
	Mon, 29 Jan 2024 17:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548485;
	bh=kthOad3VX0qOOa1TvC5l0w4z4Ecmt+kieqMoJvUe83o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0jHvNlfbQOfKIsgjPBJ0R9NRevPkbKz/2s/j+AeK92CCirEvVQiU00vrcutxPHwW4
	 lbWR4ctTlF52zaWu0DoLUEcLhIal41ERFdnnQ9nP7q4NPJf3M3ekIDcZfCBZrM2X/D
	 eFTLDaf9Z5WJlRyXIYCEK+IwyGRAynlDuPRt8Bsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alain Volmat <alain.volmat@foss.st.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.6 106/331] media: i2c: st-mipid02: correct format propagation
Date: Mon, 29 Jan 2024 09:02:50 -0800
Message-ID: <20240129170018.036325283@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alain Volmat <alain.volmat@foss.st.com>

commit b33cb0cbe2893b96ecbfa16254407153f4b55d16 upstream.

Use a copy of the struct v4l2_subdev_format when propagating
format from the sink to source pad in order to avoid impacting the
sink format returned to the application.

Thanks to Jacopo Mondi for pointing the issue.

Fixes: 6c01e6f3f27b ("media: st-mipid02: Propagate format from sink to source pad")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/st-mipid02.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -770,6 +770,7 @@ static void mipid02_set_fmt_sink(struct
 				 struct v4l2_subdev_format *format)
 {
 	struct mipid02_dev *bridge = to_mipid02_dev(sd);
+	struct v4l2_subdev_format source_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 
 	format->format.code = get_fmt_code(format->format.code);
@@ -781,8 +782,12 @@ static void mipid02_set_fmt_sink(struct
 
 	*fmt = format->format;
 
-	/* Propagate the format change to the source pad */
-	mipid02_set_fmt_source(sd, sd_state, format);
+	/*
+	 * Propagate the format change to the source pad, taking
+	 * care not to update the format pointer given back to user
+	 */
+	source_fmt = *format;
+	mipid02_set_fmt_source(sd, sd_state, &source_fmt);
 }
 
 static int mipid02_set_fmt(struct v4l2_subdev *sd,




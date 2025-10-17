Return-Path: <stable+bounces-186585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C240EBE9AFF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC462172C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B60232E144;
	Fri, 17 Oct 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QpgbRSyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022CF330317;
	Fri, 17 Oct 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713659; cv=none; b=d0gzJaADpo18drcBGwLdUe/MbUM4g6Zry26nLi57wsGFAKSRJHFZkjb2MVnnLYqyRAfZ1u9HJzZRHA7vRUVI6qJdhvxk+xxiy7lLrqqq5FjRgX33kcT90aepYoXsdqi1MNE5B/x3/ldLuZpT6o27CZgUvOS4SH43VhVrIzd2Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713659; c=relaxed/simple;
	bh=07fuNhLn1efOFg/Te8ggwlHbRWpNtyC/quXaRaaEYjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bbdqp75uKlI6tIhpuomwoAbj7aYuvjTexMjXJ695GHHR4JZgK2qF5agP32ylnN2YwRBvLxLgYo2TvVWWgbSlkEzEz9+JVOzu8WD2MzK2Kfey1eAiWvCXfi4QckrdTIMG/INmuMUZ8oVaALoURV9LX5x7pFLPNMuMfXQadSgpkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QpgbRSyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF2C4CEE7;
	Fri, 17 Oct 2025 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713658;
	bh=07fuNhLn1efOFg/Te8ggwlHbRWpNtyC/quXaRaaEYjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpgbRSyNZaADrmtz5OBHm/YCSSqNQQaYcn8GIZ/UXewoD/4mHCNUUF64PU0cZSUiW
	 H+0kTKbp5RBB9F7gDjO3MfKhwAy7kbITZ0hir7q2BGiGI3aNeI9d/gPCPZF0e3PSDg
	 R1YUn6c2AaOn3FeGuw0nbfKrdNdppzgXFNccLDuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.6 073/201] media: i2c: mt9v111: fix incorrect type for ret
Date: Fri, 17 Oct 2025 16:52:14 +0200
Message-ID: <20251017145137.437837908@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Qianfeng Rong <rongqianfeng@vivo.com>

commit bacd713145443dce7764bb2967d30832a95e5ec8 upstream.

Change "ret" from unsigned int to int type in mt9v111_calc_frame_rate()
to store negative error codes or zero returned by __mt9v111_hw_reset()
and other functions.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Fixes: aab7ed1c3927 ("media: i2c: Add driver for Aptina MT9V111")
Cc: stable@vger.kernel.org
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/mt9v111.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -534,8 +534,8 @@ static int mt9v111_calc_frame_rate(struc
 static int mt9v111_hw_config(struct mt9v111_dev *mt9v111)
 {
 	struct i2c_client *c = mt9v111->client;
-	unsigned int ret;
 	u16 outfmtctrl2;
+	int ret;
 
 	/* Force device reset. */
 	ret = __mt9v111_hw_reset(mt9v111);




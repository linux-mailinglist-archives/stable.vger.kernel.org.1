Return-Path: <stable+bounces-96550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651F9E2083
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DBA167D50
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C901F7584;
	Tue,  3 Dec 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="roIMawGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30001F4283;
	Tue,  3 Dec 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237877; cv=none; b=Kdj1BopjjBKNxOm1RkwuFsz4rX97hBNRZcUUu9lbunDhsDgwc0He+kP5jKRWOZrdt2mUEOVNzsn/0xLas9G4f6mpd2w/cnNJ/IlhCtI2/Lw408PCt3UEVJI2z5rB/fFRLRT41ji8Pys86gocK+pjojQ+Yv+zh22FVJirnwYIC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237877; c=relaxed/simple;
	bh=wRlRHxYwS6lrfoNxSvL6jdL6pmlhICnr25KfFW4uXzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRdNyuIjKDkCjLTAkLUVMuuFry++DfyjnCE39mxsViMQ475egFGleoSTMAwtWbT5A941fLO37kIEOO97ZBGYAFm5xddhLSnA1zcgMeKurl1XFKpg99CgXqOVLmdNY7SE6333NcExTXUTcgfwMFmvd9daTqjLR0OlRini4GHVlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=roIMawGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AC3C4CECF;
	Tue,  3 Dec 2024 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733237877;
	bh=wRlRHxYwS6lrfoNxSvL6jdL6pmlhICnr25KfFW4uXzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roIMawGNMI3WQampYXv438BTDSfuidJyf5E2HvPy4lQVOIqdF7c/ryjVBfu/WCjvx
	 5uLEh3Ez+ZUa6oDr+1C8QN3XBrcoqDfRwrvQHUGAIBoB9QH3DF5p00IqSGXcZIdMBU
	 rwc61W/AUB8JDcBmH+efgP45x5xvtBUfMwv3k2r0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 094/817] crypto: qat/qat_4xxx - fix off by one in uof_get_name()
Date: Tue,  3 Dec 2024 15:34:26 +0100
Message-ID: <20241203143959.374084255@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 475b5098043eef6e72751aadeab687992a5b63d1 ]

The fw_objs[] array has "num_objs" elements so the > needs to be >= to
prevent an out of bounds read.

Fixes: 10484c647af6 ("crypto: qat - refactor fw config logic for 4xxx")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 9fd7ec53b9f3d..bbd92c017c28e 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -334,7 +334,7 @@ static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
 	else
 		id = -EINVAL;
 
-	if (id < 0 || id > num_objs)
+	if (id < 0 || id >= num_objs)
 		return NULL;
 
 	return fw_objs[id];
-- 
2.43.0





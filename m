Return-Path: <stable+bounces-137308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220AAA12BB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B05E4A13D9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B65248866;
	Tue, 29 Apr 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6y8sr+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748522A7E6;
	Tue, 29 Apr 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945681; cv=none; b=FnD+W7tVXzLAo3TPSEXqJRqjvBGYxKRRXgX8o3pT9nB79ASkzhFk5J6hxsxws4PrRs+GvWzSUDUTABpC/BNozRciI4ipbVZIZmf+P0HjYz/uJJaXHeqj4Bt+9l2Q1iqZd+RSVaAwn20MP+hZ9jXH1waPaKmoJLknCotJ+GvYG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945681; c=relaxed/simple;
	bh=KExSWepIrt0ZXRZtknHRzxb7DgDyEK0piRPFZiJjFrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1sRzO0zv0aa17dHdynL8KwLPwHcPoi/J1baYSvqkcTptT0yJpjfOIAMy99TDgBmdVfWL2VTqLgaydy9VKfLpEAGY1mPsw9NEKWTqqjGJi/SEF8BOTd0GmonZizPXXhx6R7lQ9mU2U6JFtCA+XF0aXoizEM63Q+cOaM3i8mIOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6y8sr+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DAC4CEE3;
	Tue, 29 Apr 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945681;
	bh=KExSWepIrt0ZXRZtknHRzxb7DgDyEK0piRPFZiJjFrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6y8sr+7dUA7gzdjz+Man6czdyV0Z0dmaIHc109P0vFIZIHzTkyKVOSDmEe3gdoGL
	 nAfLtCY5Fjnmh/D/amdUj1YhfXS3QeW6XabLnkFVNIqm0z9xa4Ybi2e9AjuCyte35l
	 +OTalawnmOjFh0RWBXQRM99ayRBBGDYK8rhFoFFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 014/311] iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check
Date: Tue, 29 Apr 2025 18:37:31 +0200
Message-ID: <20250429161121.614161342@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 0af1c801a15225304a6328258efbf2bee245c654 ]

The data used is all in local variables so there is no advantage
in setting *val = ret with the direct mode claim held.
Move it later to after error check.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250217141630.897334-13-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 8236644f5ecb ("iio: adc: ad7768-1: Fix conversion result sign")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7768-1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 6f8816483f1a0..c78243a68b6e0 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -370,12 +370,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		ret = ad7768_scan_direct(indio_dev);
-		if (ret >= 0)
-			*val = ret;
 
 		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
+		*val = ret;
 
 		return IIO_VAL_INT;
 
-- 
2.39.5





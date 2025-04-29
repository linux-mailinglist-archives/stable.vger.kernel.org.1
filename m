Return-Path: <stable+bounces-138443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4DAA180D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6B91BC56EB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D925334E;
	Tue, 29 Apr 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4BPN0Qt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B35227E95;
	Tue, 29 Apr 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949271; cv=none; b=hs2ddWtWJiFyYSPkPrD3hAgR78deg9PFbgN4i1oBhaFkfebZ2VyLR4dD5G5hSFOHWkEDeMLxnnjbgxz4SBf+L7VfKcAhoRAIGooVZNNXmRJU8r3xV5B1eDZD7o0dC7rDLdl6oBAjJ29oxxOyMl3OdgQpPfuV4QZyw3Lb/zW5Ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949271; c=relaxed/simple;
	bh=JCYi8IlQ9+Kv0WRkdeuWLGRGnM3oO3fawsyisr4Kqds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj6G+4eQinUP8pEcNqqQwwog4Tj9sO2ftXuP8dze/OqHvvG3XQlOoG6xHWYM7RngJmeDc+RuHeXbW32OJqD4sT8759nJiCLA1cWfDNp0p5VuRZ1y0TTAOFK477xUJFUyt/mvSTzO8SqTaNTb9I5tn+O0fNfShWheQabMqH783qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4BPN0Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC4C4CEE3;
	Tue, 29 Apr 2025 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949271;
	bh=JCYi8IlQ9+Kv0WRkdeuWLGRGnM3oO3fawsyisr4Kqds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x4BPN0Qt7MkJmGM14hDkab/KTaB9+85cKrOBKMQB3vJhYe9jyO6BhXCEfhlkfBNQd
	 FKNGhPOU6z4AlDW63HTQRreme2ssNd+64UJsU7cJuzlZyTLtIg15hhJNynlNYmdCPq
	 SVgl5lG6mcJerGJep4OkWW95HcHYA65fhRoZT1lk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/373] iio: adc: ad7768-1: Move setting of val a bit later to avoid unnecessary return value check
Date: Tue, 29 Apr 2025 18:42:23 +0200
Message-ID: <20250429161134.061735879@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index aa42ba759fa1a..22c0303587b07 100644
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





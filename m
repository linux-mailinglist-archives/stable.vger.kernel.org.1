Return-Path: <stable+bounces-143437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19DAB3FC3
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E317465E3D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543A81C3BE0;
	Mon, 12 May 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wW1+GqlT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B5295DA6;
	Mon, 12 May 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071949; cv=none; b=E0Uomu4miocHGD+E3CnR5QAXx6rBk2gZQMdClCKhK37eFWbKlHey/EdBiNcJFjsny8bPDeKVFIJNAzh7F7u348TXMcmCNjrfhd+8rFv9L8Xaoy9EAU5rkf52nsF1HMDpg97H8pYW1N3gzKHWwKRCqWKP7hmti8qSOohNPRiEv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071949; c=relaxed/simple;
	bh=gc6C0EuBw+0/Mcno1JOVvoUkSadhUc0vewS6bQwUEf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiQC2eE7OJ9aUX1h8EDfQ2nUowYfX2GDoBhozUrFYpbP7J2OpSallYw+fSuU9zoaMyM2Gjo4nOY4PvoU52l6M1zgNJLQjEGMd5DRZ9woTAf/7x92XvMo5vWdpDk0X3+VPGJygPIlG9ExxN1WFeUUn3IvvIe02+nkcCKVZtYhiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wW1+GqlT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953F2C4CEE7;
	Mon, 12 May 2025 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071948;
	bh=gc6C0EuBw+0/Mcno1JOVvoUkSadhUc0vewS6bQwUEf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wW1+GqlTsghTEq95aHFOpId5OxAEAkgVW/ISWRt/Epjk3DBzc4vmYaUFx4BQRLwqg
	 CvlNgHgJXhPZQRDPhwzrEWXJEVTRPO94xjpUU09d1pmcJlzc5Nqf7nTLchT3M5IPTm
	 p7KUJnzZ1yZR96BkFJGvEVxmkwGPUPyOiQaQ6w28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.14 087/197] iio: adc: ad7266: Fix potential timestamp alignment issue.
Date: Mon, 12 May 2025 19:38:57 +0200
Message-ID: <20250512172047.918418046@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
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

commit 52d349884738c346961e153f195f4c7fe186fcf4 upstream.

On architectures where an s64 is only 32-bit aligned insufficient padding
would be left between the earlier elements and the timestamp. Use
aligned_s64 to enforce the correct placement and ensure the storage is
large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7266.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 




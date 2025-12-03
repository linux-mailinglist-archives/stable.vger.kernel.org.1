Return-Path: <stable+bounces-199714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF7CA02F8
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 124B03000948
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3B393DEF;
	Wed,  3 Dec 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZXEe1CX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90A7393DEB;
	Wed,  3 Dec 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780695; cv=none; b=lvlFOcl4v/w3alzhESk7GkA27tIV0TRGxwdcNF5TkRQ0Z+aoMEJEPNXs3kWXSl/yk5mWiZFq/BmT+NUnbBBIeUi/InOwO6VDKaRN6qRHSOjUxu1qyuxHRoALJAMjhBxEkpRGmbjL1m0xFBcM9ZfCknGR6u5Jv5MOKGyv+nRsawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780695; c=relaxed/simple;
	bh=y5CklfYdyGC7jX59jx+rNLpzWWBS50jIFFlsTJgrekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpxMgYiZswmI00HGkI98AqGR/6FvS12vq+7td4OBKHAKnsq5iId7KeX7wRDkkJcA6iKRIlvGQes8Sow2N1W7k/bpPJY10T6d5B1kOcaWy79a8HFPDk3HR7pPiMMy8dlLKpksOVUHT0Zteix2R7u6l1lPJn2dUgqffm+dzA3LyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZXEe1CX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110BAC4CEF5;
	Wed,  3 Dec 2025 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780695;
	bh=y5CklfYdyGC7jX59jx+rNLpzWWBS50jIFFlsTJgrekc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZXEe1CXPA/yQrPML1GIu89dp6sUeeheFoFcC64u+WavP7sUtrQrcIM0UXZtxbgdb
	 pW4UHbqUi3fAsFs0hO31UWcINhFdofV8baq9AYqlTjZ5NgT300BWv3GFc9YSrxlUJY
	 5jfOV601VgeDkye34DidaAFYJ4TMtU0Mh2sbaY8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 061/132] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Date: Wed,  3 Dec 2025 16:29:00 +0100
Message-ID: <20251203152345.556886518@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
References: <20251203152343.285859633@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

commit bd886cdcbf9e746f61c74035a3acd42e9108e115 upstream.

Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.

iio_str_to_fixpoint() has a bit of an unintuitive API where the
fract_mult parameter is the multiplier of the first decimal place as if
it was already an integer.  So to get 3 decimal places, fract_mult must
be 100 rather than 1000.

Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI naming")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7280a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_time
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 




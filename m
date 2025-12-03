Return-Path: <stable+bounces-198593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C3CA1167
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7DE32E4487
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E232E745;
	Wed,  3 Dec 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cfy8R9j/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749832E73E;
	Wed,  3 Dec 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777055; cv=none; b=p7BhNHSAYgui3AkC3Skz/z0dKNW/g1mOYvH6ic6mAEV85Ls2BoXZSLVq4Fi+VrRvCCPgQXD59aD54rKzssTYnGNCOx8q2zqAXRrKbksd82rrWOCh+Uw5AIOdupZEoFORBaPb8HgWia/A1rdz5ZM8/2phfUS58Yz5WQF5voFk1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777055; c=relaxed/simple;
	bh=/87He4ZMfudSoISOk00TaIv+lOsHtcMO/+mlidK5ubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMgX7EGMyxJVLkkFcwNPa6VBixphrJdiSj7J9PF22VfpyMGnxkiGI3xKolR+I0Em+gtMKwRBM3IgjFhkc2ctBbXfbXHBHxcckOBAKw87yvVJ1X/+3vEDybmPkUYxD91lH39H2dkFzR0D1iIcA9F5dq6Z+eKAamVV0d93D5F8aUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cfy8R9j/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1981C4CEF5;
	Wed,  3 Dec 2025 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777055;
	bh=/87He4ZMfudSoISOk00TaIv+lOsHtcMO/+mlidK5ubg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cfy8R9j/U2HpMyFVSA1f6PPeQF6+oAZblkdUWw1OYeyunDhEFqcxVgZtsp0/neGkU
	 HeRofasgTna1+YcVyFVIf2h0ucKJx5nQl6gnCxqyNa975xt/bVDZ6b4VYQcOZJ1eNG
	 Qk96jhej5A289CR4gVDKx/phv6Ph3by5UFjB94Xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.17 067/146] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Date: Wed,  3 Dec 2025 16:27:25 +0100
Message-ID: <20251203152348.919009812@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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
 




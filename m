Return-Path: <stable+bounces-57039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A0925C66
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA54B3210A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184681957E8;
	Wed,  3 Jul 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cCMHhMK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F361953A3;
	Wed,  3 Jul 2024 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003652; cv=none; b=HfWUeGpubyVR5166z/Hs2dpTTQzcoOqp4s815alT9Q84Tf5+8j/VzILpGlohjr5mHX9uorS1rQh4YXcjEw/+Dy321v/kbTehu9G91y1FW2Nymra6laQHIbObXWp9UUvYN9zU1yRr/ixP1x5juOB3jAlB6wbamLbzqbmj9I4tOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003652; c=relaxed/simple;
	bh=htDmqfy3FrRftAXW45gc/LF/yhndeGg00QDUDN0+VUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aacqUUT0DmRQKdvnRZtPwOhz1x1PBqRhEu9g4ZsRUg9hdGzMJ1/jnnV1gEyKYZnuPVc2nPwiiyZLUfOi/XUBTsPpbrS4q+tWbRPeLctXI/puaO04y1rtWXKIrKdQg62it8RSyYTVDGXWOGUSx37bZDJhGbARd04nijRZpQkgrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cCMHhMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE49C2BD10;
	Wed,  3 Jul 2024 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003652;
	bh=htDmqfy3FrRftAXW45gc/LF/yhndeGg00QDUDN0+VUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0cCMHhMK5hMkqv3ESVPDr3TX0bLZWZY58nJkadoXzwg+YnU47OMpJ6F8EdE2HU0Ew
	 tA5lfeqQQygRxABWQu/q30GFT2gD8W3Z12MaEHKi3gMeoGwaX/Ao9eghtTxJXZfjpx
	 GsGRwWMa6pLsOCLiNhzU7F/p3voVPD9amaUrvxJQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Yang <hagisf@usp.br>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 118/139] iio: adc: ad7266: Fix variable checking bug
Date: Wed,  3 Jul 2024 12:40:15 +0200
Message-ID: <20240703102834.896210990@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102830.432293640@linuxfoundation.org>
References: <20240703102830.432293640@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fernando Yang <hagisf@usp.br>

commit a2b86132955268b2a1703082fbc2d4832fc001b8 upstream.

The ret variable was not checked after iio_device_release_direct_mode(),
which could possibly cause errors

Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")
Signed-off-by: Fernando Yang <hagisf@usp.br>
Link: https://lore.kernel.org/r/20240603180757.8560-1-hagisf@usp.br
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7266.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -160,6 +160,8 @@ static int ad7266_read_raw(struct iio_de
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val, 11);




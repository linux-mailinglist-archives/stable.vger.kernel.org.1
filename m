Return-Path: <stable+bounces-212339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFwuNmQwemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3767EA48BE
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD2EB3019179
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406F303A15;
	Wed, 28 Jan 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ON2p9T13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379982F747F;
	Wed, 28 Jan 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615187; cv=none; b=ANPI94Vs/N3Rr6fC3mwNW9BrB7Arpz4OuX5d1LlNDAWMkIX/+5nNIjEfAZkGX8IB5BfiqY+07/rdR8VfpgjoW+ZYn/2l2Vfca0RXokp/RB0YA3NeYW92ZVigbsM1ZZo0e28uQuCCAi8aMmxlpbAGt3I79+zj2YnDaqVU/2Pa4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615187; c=relaxed/simple;
	bh=yoUjvplyljhIlbyAdd8MeopQyuQ6+j9VqJfuQbp6YVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shqTZoF22ZYPdByzfBFb/JYDTOtxTgCatXj2Tp1TKBKuVcOS1/TnAQarHHYQG0AwJ4uKUlcj9QC6pM1cnU/iK5v23QeCLsJ2mufDQFcPQzCv9beaBxCh3wJV5t1WBV9kG6XxciEgJC8JMkZJg5XwI3rcMRN4FPf/ozmNn+tLeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ON2p9T13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A035FC4CEF1;
	Wed, 28 Jan 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615187;
	bh=yoUjvplyljhIlbyAdd8MeopQyuQ6+j9VqJfuQbp6YVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ON2p9T13W99GdC6gh5lg6UaLDVYrkTH0A8MFdnuZlpKbln9LaFABYyUPWueDDxV74
	 gxp03dYvkxaSsPqIYjuUffwlHf1iS91NZJs/27B2fabpK/p1eMnojB2inQZQOs27qY
	 gLZHeUSLwzGSbC7udpUv/BDgaySf1ZCaRshzHS9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 104/169] iio: accel: adxl380: fix handling of unavailable "INT1" interrupt
Date: Wed, 28 Jan 2026 16:23:07 +0100
Message-ID: <20260128145337.751181774@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212339-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,baylibre.com:email]
X-Rspamd-Queue-Id: 3767EA48BE
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

commit 4ff39d6de4bf359ec6d5cd2be34b36d077dd0a07 upstream.

fwnode_irq_get_byname() returns a negative value on failure; if a negative
value is returned, use it as `err` argument for dev_err_probe().
While at it, add a missing trailing newline to the dev_err_probe() error
message.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/adxl380.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1730,9 +1730,9 @@ static int adxl380_config_irq(struct iio
 		st->int_map[1] = ADXL380_INT0_MAP1_REG;
 	} else {
 		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
-		if (st->irq > 0)
-			return dev_err_probe(st->dev, -ENODEV,
-					     "no interrupt name specified");
+		if (st->irq < 0)
+			return dev_err_probe(st->dev, st->irq,
+					     "no interrupt name specified\n");
 		st->int_map[0] = ADXL380_INT1_MAP0_REG;
 		st->int_map[1] = ADXL380_INT1_MAP1_REG;
 	}




Return-Path: <stable+bounces-218338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ABBCcxRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D875D18F0AE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B30EC3087440
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB01D5ABA;
	Wed, 25 Feb 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="10IVTMrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2681E2834;
	Wed, 25 Feb 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983145; cv=none; b=shGcfN8qmfcpXdGT8dQ9RZVNDJDIorBR9+VJWZmHKPyY6HwNXT6JtenxpIV25VBDLd4rxDqbDB5I0gwL5NPHdq4okLO6oP9ytxMiugEKLOjSkcrzyCadB1EwnIVoZi9SbE8UUbXeLUHc3/wof6iVwmI8NwHMtPZP4/J5R/emfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983145; c=relaxed/simple;
	bh=cKQ1AyfPsNxwlebNcoIm1mvXfd09AqVbzSPFW5SGTv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o05t4Q3kut4B8CabIxvFfATDwlFePTfrX4J8G8pMhr3AQoKeB1CQn2159RJsYFsStnyqcf83ETxYbwlWmjdh3kvmCs/dK5EDstHu1GQfAkkV1hUg5OnheYUX/L2kYQFGTSbmGjH8piQjzphqQRYpQO/91HY2t5k6RXAk6nqy/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=10IVTMrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02A3C116D0;
	Wed, 25 Feb 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983144;
	bh=cKQ1AyfPsNxwlebNcoIm1mvXfd09AqVbzSPFW5SGTv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=10IVTMrKo1ZyLqNG77MvUAdNCzREbJo9V5XQYYlXW1oAhkp79RNcDnMbX4Mp8YVcJ
	 DpitazYcM/dKVXZdboxFiIRlDYfowRC4+sHC7bdhaazc9toJJJclBvoq3La20CZYbJ
	 clUfzD2qI9pT3TZxEFI5Tf4lhIaiOihTnSWvNUMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 298/781] HID: Intel-thc-hid: Intel-thc: Fix wrong register fields updating
Date: Tue, 24 Feb 2026 17:16:47 -0800
Message-ID: <20260225012407.016444429@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218338-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,suse.com:email]
X-Rspamd-Queue-Id: D875D18F0AE
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Even Xu <even.xu@intel.com>

[ Upstream commit e4aa247d94a04574297a8bc9fabbede0dcba1ab6 ]

Clear the target bit fields in register before setting new values. This
ensures proper field updates by removing any existing bits that might
interfere with the new configuration.

Fixes: 22da60f0304b ("HID: Intel-thc-hid: Intel-thc: Introduce interrupt delay control")
Fixes: 45e92a093099 ("HID: Intel-thc-hid: Intel-thc: Introduce max input size control")
Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7e220a4c5ded7..d8e195189e4bf 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1597,6 +1597,7 @@ int thc_i2c_set_rx_max_size(struct thc_device *dev, u32 max_rx_size)
 	if (ret)
 		return ret;
 
+	val = val & ~THC_M_PRT_SPI_ICRRD_OPCODE_I2C_MAX_SIZE;
 	val |= FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_I2C_MAX_SIZE, max_rx_size);
 
 	ret = regmap_write(dev->thc_regmap, THC_M_PRT_SPI_ICRRD_OPCODE_OFFSET, val);
@@ -1667,6 +1668,7 @@ int thc_i2c_set_rx_int_delay(struct thc_device *dev, u32 delay_us)
 		return ret;
 
 	/* THC hardware counts at 10us unit */
+	val = val & ~THC_M_PRT_SPI_ICRRD_OPCODE_I2C_INTERVAL;
 	val |= FIELD_PREP(THC_M_PRT_SPI_ICRRD_OPCODE_I2C_INTERVAL, DIV_ROUND_UP(delay_us, 10));
 
 	ret = regmap_write(dev->thc_regmap, THC_M_PRT_SPI_ICRRD_OPCODE_OFFSET, val);
-- 
2.51.0





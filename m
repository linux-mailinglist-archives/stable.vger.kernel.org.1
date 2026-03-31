Return-Path: <stable+bounces-232251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG6XCEX+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FD36DB9F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3EE306DFE7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73A29DB8F;
	Tue, 31 Mar 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSciALul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B61413258;
	Tue, 31 Mar 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976266; cv=none; b=Aawt9Z1pZ1fG8+d678KnbghMg/wbxkqzPpL5B4QhSb4l/OpzbtaykmyJ6GM46//rhkg1GTOK7iPMh1UnGj5N9A1QI2oQI8tyathDBRq4mSJSMmGNZN+DVuFpf2Gp2yDzlnpko/aFMwT4cu5nM6lKXRgP9g1tjaUVdOpRBSZmDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976266; c=relaxed/simple;
	bh=xw1RxmS/Xf5Qyu/hKT+1pxW3gQY8eP7PL9c8hYKwg8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqb/vfU4zT9ik/eKxnZAWZl3dYbxNhg5VChT3sgWlYWUiYDNGTz9Hd3Z/Wc5COZtcOy1HDWPBgVzyyaczzQkhgVAMtzYK8Vifw6luKQrMX2M9O4c7GD6xO+U+CTyJKVD9/aKVj73qi6RbSwvBl1MzVe3NjC0I4evH0M5k+KDtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSciALul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5698FC19424;
	Tue, 31 Mar 2026 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976266;
	bh=xw1RxmS/Xf5Qyu/hKT+1pxW3gQY8eP7PL9c8hYKwg8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSciALulmAuuoXy6uSOziPvCN23sIZWJzSycC998HvRUlnUY8vjHqsw9boQinYsBh
	 0T6axt7BaplSUd/PImOBr8b5oIbP4w6rhM5t1Gdpjy1nkF+j3qcIk/rJWOULLTwDTA
	 n5A0o8OKI2LtMLxSSkI9EQge19MlCk94RkArrSRc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 008/309] hwmon: axi-fan: dont use driver_override as IRQ name
Date: Tue, 31 Mar 2026 18:18:31 +0200
Message-ID: <20260331161753.783616980@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232251-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,roeck-us.net:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 909FD36DB9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit 813bbc4d33d2ca5b0da63e70ae13b60874f20d37 ]

Do not use driver_override as IRQ name, as it is not guaranteed to point
to a valid string; use NULL instead (which makes the devm IRQ helpers
use dev_name()).

Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260303115720.48783-4-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/axi-fan-control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index b7bb325c3ad96..01590dfa55e60 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -507,7 +507,7 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(&pdev->dev, ctl->irq, NULL,
 					axi_fan_control_irq_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-					pdev->driver_override, ctl);
+					NULL, ctl);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to request an irq\n");
-- 
2.51.0





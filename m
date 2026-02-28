Return-Path: <stable+bounces-220309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePM2CPg0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F7B1C5F2E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BC631857A6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212C38F643;
	Sat, 28 Feb 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofF4iSga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F038F62E;
	Sat, 28 Feb 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300212; cv=none; b=W7vfrS5bUE36C6z2ocfAd03EzN74Ldw+O2SQVs1NBdKr48PLoRuAdYPLSWnVptUJ5dmZir47Ry/aw9YRikh5RMX0AikzV34kRo4T5GtbrlO930HELOZr+XeHdWB0M/TA5CunynpvIY6tdRrsfvUY8ViK0mqTPh6lnDGvj2Bs9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300212; c=relaxed/simple;
	bh=e2nLUu8MmNd6l5CuMURTnwn6ibpsiDxSDRgNZmh8Gyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJraz6m8DfmM/KQpHhR2jAu+RTKN3OGXOxLMlc5+HezwuJPjQKm66alvNLtg5a2T5pA2luwVP7rhYImxUxiN8hRx3oROwHAgLccqj4UqyHWUjkhdtUaR+s5bfh8BSb77VqGW9TLA3R2enrV9bpbtmnLGafwL0i87CUE4R7XQQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofF4iSga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBE6C116D0;
	Sat, 28 Feb 2026 17:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300212;
	bh=e2nLUu8MmNd6l5CuMURTnwn6ibpsiDxSDRgNZmh8Gyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofF4iSgah7RrEpRPKkvUTXYquDKmhLH6BTvUUlTIQhF1iSB65/nMbi5ke5rkP43on
	 z5KBxwWWdXksv2pv+VaxtyiYIZR3zfneIhGSjkXiAgmfjt+P8Dgx2hkYHjnUuNhs7w
	 wepZMZ7XimFOFNE9ICeElaKpDfJrYtZ7fUoJ76POAnbyGxuz1/224LoM48SSXSwk3d
	 re4O6lrBtAF0M0NzkO570euRvWfBDZQsvE1T4h9JS/fD7lB5f54RikehZUOOwiXchs
	 5hwVz/2lAFDS5dxKdwmcpGHeRR9X6FYiQxY5vhpLXF7OKKlAyT0TirBKmK9RAq7DRf
	 pJeUfU4S2XLmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Gu <gu_0233@qq.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 231/844] hwmon: (emc2305) Fix a resource leak in emc2305_of_parse_pwm_child
Date: Sat, 28 Feb 2026 12:22:24 -0500
Message-ID: <20260228173244.1509663-232-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[qq.com,roeck-us.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220309-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 76F7B1C5F2E
X-Rspamd-Action: no action

From: Felix Gu <gu_0233@qq.com>

[ Upstream commit 2954ce672b7623478c1cfeb69e6a6e4042a3656e ]

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In emc2305_of_parse_pwm_child, it does not release the reference,
causing a resource leak.

Signed-off-by: Felix Gu <gu_0233@qq.com>
Link: https://lore.kernel.org/r/tencent_738BA80BBF28F3440301EEE6F9E470165105@qq.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/emc2305.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index ceae96c07ac45..67e82021da210 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -578,6 +578,7 @@ static int emc2305_of_parse_pwm_child(struct device *dev,
 		data->pwm_output_mask |= EMC2305_OPEN_DRAIN << ch;
 	}
 
+	of_node_put(args.np);
 	return 0;
 }
 
-- 
2.51.0



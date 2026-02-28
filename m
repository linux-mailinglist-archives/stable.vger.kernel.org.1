Return-Path: <stable+bounces-220751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KkWH6pAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE71C6EC1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF0D6312CB0B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FDA403DB8;
	Sat, 28 Feb 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S53LyoAY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5A403DB0;
	Sat, 28 Feb 2026 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300631; cv=none; b=A401a3TwFHz8OIxbgrCA2JFX/adJP6YfsHHJ0y5OMbKHzlcLVVX8PpG11D7aJwbXLJEnfxAvXkWWCQaFxF2ad6CecdhxP56Ie3eJCpY+RmmP1l3U7C+XyZZnAByktvYMNr19Nbzwd3ded30O5JZwHLghnraUyIPa46fg7/4BLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300631; c=relaxed/simple;
	bh=aGufSnDeM09fNoVcAA8rqkEr8huu5NfEvQm0sdGaDhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdBX+ZNndR8KcCDlmIbt1CbTM6Y/VHbk7VNdLsNlAT8p+ujCkfi+kINvHEqFR5vYNzooL9buEALmnI7PDH6y7Yxc33bUSgHrvCk9jgN+85maY3kMtLlMGg1dGTl7wsiEyIQIVGKL1FOwM4Rhuj24e8dlhhRftq7S8z3kRPN/4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S53LyoAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD806C19423;
	Sat, 28 Feb 2026 17:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300631;
	bh=aGufSnDeM09fNoVcAA8rqkEr8huu5NfEvQm0sdGaDhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S53LyoAYm60WnaT5EkDFZtmPBJgaT6Ow0d688FYz4rwSMmhZysFFelBBdAby50NL3
	 uVjzzL96em074AibcYqaWGswrJsObWCfj1ulDaIJUq3MqTNdXF9HV/pRjzI4BpHLxc
	 8zp+/jeokUl5x/gaVL5CqWGPLggD3u/9agKhampqrlKldK5lWHRMg9x+X6WYpNe2dy
	 ezBv6dF+wyQEtZG2cqMlj2gGb2340UzArCssggCha2NxaeAmXU9WacaCtyPbBfttRt
	 n22+LRQmgBYFlLDJCgA5xwd5EyJ5UwHx/Hl75ERmU1sEG5oSNoSrNhvgUC6wByu/vu
	 UaISIZBsQ6dcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Francesco Lavra <flavra@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 672/844] iio: accel: adxl380: Avoid reading more entries than present in FIFO
Date: Sat, 28 Feb 2026 12:29:45 -0500
Message-ID: <20260228173244.1509663-673-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220751-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: E8BE71C6EC1
X-Rspamd-Action: no action

From: Francesco Lavra <flavra@baylibre.com>

[ Upstream commit c1b14015224cfcccd5356333763f2f4f401bd810 ]

The interrupt handler reads FIFO entries in batches of N samples, where N
is the number of scan elements that have been enabled. However, the sensor
fills the FIFO one sample at a time, even when more than one channel is
enabled. Therefore,the number of entries reported by the FIFO status
registers may not be a multiple of N; if this number is not a multiple, the
number of entries read from the FIFO may exceed the number of entries
actually present.

To fix the above issue, round down the number of FIFO entries read from the
status registers so that it is always a multiple of N.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index aef5109c1ddd9..9f6c0e02575a6 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -949,6 +949,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
 		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
 					&st->fifo_buf[i],
-- 
2.51.0



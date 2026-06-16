Return-Path: <stable+bounces-266553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gyzkDpWfMWopogUAu9opvQ
	(envelope-from <stable+bounces-266553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:10:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7D694D2D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:10:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eUQ2VTEB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266553-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266553-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A2523050F20
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CA3DE422;
	Tue, 16 Jun 2026 19:09:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735935DA78;
	Tue, 16 Jun 2026 19:09:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636987; cv=none; b=dzn2+Y4TUKt3YTLEgx9/6ah7FlIJ8KhxDS/iZS8aPnrkQosgYJW0ZOrF4dVYstQutWP2U7Qw6kK3awVTOmMff61g9sUQIC03Tu8wWFK/UruMchZnul31u3aAK4c3TV85LphfkV2MdCnOJ48gJM0WMKSUucCtSbSy0n3sb2EutuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636987; c=relaxed/simple;
	bh=CYl+JudXYw9QPWHxVMZI777FEZVmWqLhmdJivIMb7ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjHkGM9P9chIZ4ZnqfLqNUnGoZrqwwPtuZOUPPk5RlP+R0xjExQ76nxGd1jGtVA0Rp6tKf4Z4tU850IC9RbtqGKvaonxdjCk+lUXgzes5PAcXIC5R33PuOM0zyP0l1bHy2sXbucNmJNdDT0oOaohDKAp+CAvrrCH64lR7k+yGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUQ2VTEB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599461F000E9;
	Tue, 16 Jun 2026 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636986;
	bh=IdejpBWN5C0rFAG6x6AM1zvK6myP6fnsGVJFI/nqBrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUQ2VTEBGAUog6P+wB7x9WJEiioQHc0rdtn9+FVh7W8zHBY6eac8YotluyElPoP9c
	 CRiYZ2Fj/Gm7UWVV+ZhjJQIjbXcGLToWE2ZUXVpPV+Uedb/BZi7n0szxvuLdPhT9dN
	 YrgnmdGbNa6J5RgpTAIuLUD1QBlvX53Rb8hC2/WA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 322/342] iio: chemical: scd30: fix division by zero in write_raw
Date: Tue, 16 Jun 2026 20:30:18 +0530
Message-ID: <20260616145103.564003443@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266553-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:antoniu.miclaus@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4D7D694D2D

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit 5aba4f94b225617a55fed442a70329b2ee19c0a5 ]

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/chemical/scd30_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -257,7 +257,7 @@ static int scd30_write_raw(struct iio_de
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;




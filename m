Return-Path: <stable+bounces-220973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIDTJeNco2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B31C8FBC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC8833629A4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916764B8DC2;
	Sat, 28 Feb 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovF2xvMb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EB4ADDAA;
	Sat, 28 Feb 2026 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301318; cv=none; b=sjeP40nh4wlMwXqBXVVFQBktnRPMGwFSdxaPzJg1Ke6PAgg0JlnkrP1J/eWrT6kJlNXcMhH96mmp4UeA8t4MS0dQYjiSJWu1hLZhUh4q+mRRUshdt19H9D7c3xbeFm30qTFDLOMYy4ZmJXWD2zQBN1H4I2SpemZA7EazlQ+05MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301318; c=relaxed/simple;
	bh=NhBI4Zw7iljTeIMT/PmDChE4/1t5ww44aTSvxK64uAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTHEBOR7kWTsSJS1wwJ0Bm1fyvPdx02P1kXP/2s+lG0CTPLZK1UGaj9jwJmIvHC8eUEhTQpAQnTiyKyC1n8xlulL38prP62AD6lLWynqcd/iDgamP4EgLLTVp35tNEJgj/cEvOkrozLelkLUGHHA6MWswuso6WcQqwnTgxtC3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovF2xvMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98545C19424;
	Sat, 28 Feb 2026 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301318;
	bh=NhBI4Zw7iljTeIMT/PmDChE4/1t5ww44aTSvxK64uAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovF2xvMbnm+NTEHZCG21en+066MevMp2WNEqN7e7IknSc5hzmhUWkWiSh5Sld3pu1
	 0VsBt8dU9BV6lohPWcNV4aylOPBd/rNHwmCWCsBMekwZpdOv3JAhm08bTyNxPW2Nhp
	 i24f9wnF0LdBR+wSek6hV3nhJDW4po2lhFoqq0hD0sN+iim9xqd/l4iOeCVdkFL2FL
	 uHJ7cSbv9sUG1Z5A1E2mFMey9sXEJmY/7xCPXMZqdzMSenaPlKRiT6Qa7+6YlQLXCT
	 qYVkG+pqgYZhEMBdSM51r0iTbuWIsrkU95jlu1H9AqLi4zLqZ5+veWIfKqCBcKji5+
	 XUgM3Kx3oI22A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 504/752] HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()
Date: Sat, 28 Feb 2026 12:43:35 -0500
Message-ID: <20260228174750.1542406-504-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220973-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: C19B31C8FBC
X-Rspamd-Action: no action

From: Günther Noack <gnoack@google.com>

[ Upstream commit 1547d41f9f19d691c2c9ce4c29f746297baef9e9 ]

Do not crash when a report has no fields.

Fake USB gadgets can send their own HID report descriptors and can define report
structures without valid fields.  This can be used to crash the kernel over USB.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d117cf0b6de04..6b463ce112a3c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4313,7 +4313,7 @@ static int hidpp_get_report_length(struct hid_device *hdev, int id)
 
 	re = &(hdev->report_enum[HID_OUTPUT_REPORT]);
 	report = re->report_id_hash[id];
-	if (!report)
+	if (!report || !report->maxfield)
 		return 0;
 
 	return report->field[0]->report_count + 1;
-- 
2.51.0



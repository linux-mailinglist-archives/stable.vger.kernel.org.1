Return-Path: <stable+bounces-211644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDnnNWaPd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:59:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BB98A6E3
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0CEF3013789
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6E34027E;
	Mon, 26 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA4j9Fry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16C26E6F4
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443172; cv=none; b=Vg1j1fs8JLmiWwHSoSiWwhc3ndd1Pe+opKljXTC6VD3y8TAQUz/NNkV5x7tScp0sCbxNEZJAII014bg38KVakK2L9FWYlSKq7wc1J5a7AwuC0iEK5+BQKwsM7nwlIJDorP5jIlHMI9lt9VncwmlnY0j3UyKEGu3NkpKhSwiVjls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443172; c=relaxed/simple;
	bh=koOSQYAdIwY+/FkaRCvDAYsDte1R+WRLE3csHer9qv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRPXH3facD9/NTEASK9hS7S1VSgHbL2Sw5FC5gEv34EOlpCr2Jaqc4gjDGBMO5E9mSbiBSa1xwmzakefwjAPs90bJb176cEMnLb80RZbKwQN8H9uRZYiz9U4tfzcSibZsafuSIA/pnb5gsaUg0FrA0ZvVNfm3g1xG74nXkFo6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA4j9Fry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F55C116C6;
	Mon, 26 Jan 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769443171;
	bh=koOSQYAdIwY+/FkaRCvDAYsDte1R+WRLE3csHer9qv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA4j9Fry/iTWkYaPYs+id2knJybxq0d6OflnkO2xcaZ6dGTGFOatHxtz46amRncn3
	 ykJeLSUJkVUWLuT/oly7cU8vvzZ/OKcs4MOyIlJ/RwdqVN3Zl/OFQoLTDPKudIdbfZ
	 BT5vTOAgxF7nrAKwjc/LDETBjPi1qoP/7u0lcinfhoD23zOHFGs+ZFbblnavMXzq4A
	 8jSF5uWjn91DpHf1+G6ivVHxWFn7sDf4NgjQSscJ6sAokGGMMFAxtrLtJgksfuXHx+
	 GHUgv+CgnHI2RqdZgsBM6A659PMGeoV2Q/2MLalE+9K8nZApdOu4yETi+HEqt7UBui
	 2s/U6KHQmhy0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Guang <yang.guang5@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	David Yang <davidcomponentone@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] w1: w1_therm: use swap() to make code cleaner
Date: Mon, 26 Jan 2026 10:59:28 -0500
Message-ID: <20260126155929.3332297-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012603-washday-underfoot-7004@gregkh>
References: <2026012603-washday-underfoot-7004@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zte.com.cn,gmail.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 11BB98A6E3
X-Rspamd-Action: no action

From: Yang Guang <yang.guang5@zte.com.cn>

[ Upstream commit e233897b1f7a859092bd20b10bfd412013381a10 ]

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Link: https://lore.kernel.org/r/cb14f9e6e86cf8494ed2ddce6eec8ebd988908d9.1640077704.git.yang.guang5@zte.com.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 761fcf46a1bd ("w1: therm: Fix off-by-one buffer overflow in alarms_store")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_therm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 3888643a22f60..ad8276cc82f5b 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1783,7 +1783,7 @@ static ssize_t alarms_store(struct device *device,
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1834,9 +1834,8 @@ static ssize_t alarms_store(struct device *device,
 	th = int_to_short(temp);
 
 	/* Reorder if required th and tl */
-	if (tl > th) {
-		tt = tl; tl = th; th = tt;
-	}
+	if (tl > th)
+		swap(tl, th);
 
 	/*
 	 * Read the scratchpad to change only the required bits
-- 
2.51.0



Return-Path: <stable+bounces-232280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ9AFwsGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521C36EF9F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D957730A1BA8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB86425CD6;
	Tue, 31 Mar 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOPtOMDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC6423A8E;
	Tue, 31 Mar 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976341; cv=none; b=dt8cNg1HG989UaosgT2P2uyFMAYKUK6C97WPEJu7Qqmqu/3FTVl0lfM38ABdAD8cUsxER1FIW4StCx+3pCtbSgoSrateW4kLaVpyiMQS+/k2FGzShHRWsSMpEmv2lL7zZLfJFbN1ck6oRrEP1w6daZRMkI9CbOFdfusLaJnZEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976341; c=relaxed/simple;
	bh=1T9wx893O04FqG929rnw6paWFaEq5lFY/PZE1o2x2+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiCcB9DR2+wT2NVuyKaHwaNj4aFIXY0bpl6/7zZn2wFixXpjIgIWHbViMg1uE1fzBbtbms+YmB0r7heo7RJDmMOGeK21skICBkV06K1dMHHcRTXdRnoqHooGXhmG++tajQGM5YRGEEVq1AYrOvoIwzfFVL8AApUNfCbf+hQ9QpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOPtOMDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EB0C19423;
	Tue, 31 Mar 2026 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976341;
	bh=1T9wx893O04FqG929rnw6paWFaEq5lFY/PZE1o2x2+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zOPtOMDkiZfFG+VB4oiod+ZVzUIM6orRNPb887hF/pchYiP4m5yU5gLedrG7Xq56Q
	 /3BML1kB8jV+kiIX7LVvD9ujv+QprLEklxChTzNXYCOtAdA5oOMF6BdSOwxDVq+Eyd
	 6ChmLK9R0b39o4t/F6Tpos7ZDXQ/iV+BQMuPqWNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/309] HID: apple: avoid memory leak in apple_report_fixup()
Date: Tue, 31 Mar 2026 18:19:17 +0200
Message-ID: <20260331161755.475596985@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232280-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7521C36EF9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Günther Noack <gnoack@google.com>

[ Upstream commit 239c15116d80f67d32f00acc34575f1a6b699613 ]

The apple_report_fixup() function was returning a
newly kmemdup()-allocated buffer, but never freeing it.

The caller of report_fixup() does not take ownership of the returned
pointer, but it *is* permitted to return a sub-portion of the input
rdesc, whose lifetime is managed by the caller.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 2f9a2e07c4263..9dcb252c5d6c7 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -689,9 +689,7 @@ static const __u8 *apple_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up Magic Keyboard battery report descriptor\n");
 		*rsize = *rsize - 1;
-		rdesc = kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
-		if (!rdesc)
-			return NULL;
+		rdesc = rdesc + 1;
 
 		rdesc[0] = 0x05;
 		rdesc[1] = 0x01;
-- 
2.51.0





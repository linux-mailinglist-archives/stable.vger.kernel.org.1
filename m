Return-Path: <stable+bounces-220642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CtVJrpRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037701C86ED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5780325261E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F23E3EDF3B;
	Sat, 28 Feb 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRj/6iz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E343EDF35;
	Sat, 28 Feb 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300524; cv=none; b=pRkZngI2YJFuEIEndaxnhL4MaduuleWQseTpaBImx8oyMbBs1/yVPkD6fLMtDjaVDa/Ou8tgefW6KCMOGosB9oXLUtHHnJZj/4QL0vmttnVUJiXjufuZYj6EgKS+a+1RJNYNS7PCRjsalxfaVJBQJndKXSN02RYPQZaLiay//7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300524; c=relaxed/simple;
	bh=DQyDUUNHdxKEpOPzA8AuiATJG9SYp80KZnKbmMotIPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O58jAUDASVt129u/nGoOrEcfTIUpsSwDij9NM5dr67rr2WAxUBvJgm6wJ3HKd0aEpdqRbed2yFBhmK2iKir5yPZ6D2YCU/dG8Q9STv3c3kD2qfNTFdgOaauhuseFFUwSAU4kCU+isyS/MNDeFDZc0NZHG6+e7NkAGDJMOPBBD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRj/6iz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E73C19425;
	Sat, 28 Feb 2026 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300524;
	bh=DQyDUUNHdxKEpOPzA8AuiATJG9SYp80KZnKbmMotIPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRj/6iz19TN6rHaC0tsVP8HdrSbs0JSuooDHpuw8kiinreDWMHpST0hi7c8Xjb1j3
	 1RJa8x+Y3VWOjBxGepjNviyC6OiP5IUmoP4loq/HbpTylSFx6ZTY4aTidbQyM7EHiV
	 k4b86Beh7etkdtDFbaIfpc4CJMUdNIg/ivxhaHu2blBygs2jRrd7ZlfapWtEjTW3Hg
	 3czYGxkdYr+vIT+ffA2/qRK+hAHhV/y6qkSy26KXUjceXkRzN+Bk1Nbl2LW6vDs6Mo
	 cZNAoaNSxqxgLhXxvNBWK5XwsoKMsKcjALorWuRl3k/YafJEqiBkIbURak+nDNwNWc
	 LImua0WcD5EcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 563/844] HID: logitech-hidpp: Check maxfield in hidpp_get_report_length()
Date: Sat, 28 Feb 2026 12:27:56 -0500
Message-ID: <20260228173244.1509663-564-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 037701C86ED
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
index ca96102121b85..02d83c3bd73d4 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4314,7 +4314,7 @@ static int hidpp_get_report_length(struct hid_device *hdev, int id)
 
 	re = &(hdev->report_enum[HID_OUTPUT_REPORT]);
 	report = re->report_id_hash[id];
-	if (!report)
+	if (!report || !report->maxfield)
 		return 0;
 
 	return report->field[0]->report_count + 1;
-- 
2.51.0



Return-Path: <stable+bounces-223979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBQ+Maz9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E824A49D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26EE431A3210
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6D37417C;
	Tue, 10 Mar 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONWzpY0N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28E313537;
	Tue, 10 Mar 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141112; cv=none; b=c6WYkzMOB8lmSe2H5bsFg06JNiGR31zGEwCFYJ/48e2pDO/6Lbi9z2Peuh1jjaNmiN7BXKRVDph+X9XcZtCVHIu7Sv1cCWzOF4g5YgMVMHkm8nIzl8dDnAfqtl4Ehb1jVsVxsGJy4zJJgri0FiHaYp0eist/Edgqy3Dv6ACDW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141112; c=relaxed/simple;
	bh=M05alRrTI/oPVhn80DxYuCD6UHuxnI4LYiGzXOqwhxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cg3z3/F8cFO9//4oENWnkEl0hxtpObK0FpB4mLjoEwcHro6NotWnHzeXhYSRrGTKokdxIRj90Urm9VBeBN2drgfjwyEDbbwjev3JhZmbIvQNRUED3ME/7KN74l110ozn5EJ4OE4l+F23Hwck5e7vzPFG83ir7AAxOws/jYxXiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONWzpY0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10256C2BC86;
	Tue, 10 Mar 2026 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141112;
	bh=M05alRrTI/oPVhn80DxYuCD6UHuxnI4LYiGzXOqwhxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ONWzpY0NlhbQnBwFZbZSF4TgrXZDHQ7zdgCOUaQnyBFnLqznMAoWzamVgNmguZjxB
	 VA6k7Z5yrRgMyu2fXeukVjBZMtngDZWgBvyS9namVOsaYDNOjPsJ5rc226UiyK1tsD
	 XvTIVXPXn31RteQXPYosbO9cScyKhxyzL2nCPLAi6PuUXeebIOt0zKIlXEGqAA02TB
	 PjupLwjmgk2poJ8xllaLI6UPQYLIGvVsWVSbSIKkGNZkvSxUWyV8oMAvGzbJBcarQM
	 ZH9UQRIlcOPmNRYofvAmTDq8EBFhsK8UxXbmHtHUjC7bwUPFTJmh5hAupcU3Vpd0WL
	 UBe6maT/355VA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 114/311] HID: pidff: Fix condition effect bit clearing
Date: Tue, 10 Mar 2026 07:02:41 -0400
Message-ID: <2757d8477689d2e4be3cacdaee00ad307c027588.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 640E824A49D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223979-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

commit 97d5c8f5c09a604c4873c8348f58de3cea69a7df upstream.

As reported by MPDarkGuy on discord, NULL pointer dereferences were
happening because not all the conditional effects bits were cleared.

Properly clear all conditional effect bits from ffbit

Fixes: 7f3d7bc0df4b ("HID: pidff: Better quirk assigment when searching for fields")
Cc: stable@vger.kernel.org # 6.18.x
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/usbhid/hid-pidff.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index a4e700b40ba9b..56d6af39ba81e 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1452,10 +1452,13 @@ static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
 		hid_warn(pidff->hid, "unknown ramp effect layout\n");
 
 	if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
-		if (test_and_clear_bit(FF_SPRING, dev->ffbit)   ||
-		    test_and_clear_bit(FF_DAMPER, dev->ffbit)   ||
-		    test_and_clear_bit(FF_FRICTION, dev->ffbit) ||
-		    test_and_clear_bit(FF_INERTIA, dev->ffbit))
+		bool test = false;
+
+		test |= test_and_clear_bit(FF_SPRING, dev->ffbit);
+		test |= test_and_clear_bit(FF_DAMPER, dev->ffbit);
+		test |= test_and_clear_bit(FF_FRICTION, dev->ffbit);
+		test |= test_and_clear_bit(FF_INERTIA, dev->ffbit);
+		if (test)
 			hid_warn(pidff->hid, "unknown condition effect layout\n");
 	}
 
-- 
2.51.0



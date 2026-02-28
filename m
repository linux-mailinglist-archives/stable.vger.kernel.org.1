Return-Path: <stable+bounces-220640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI+MJpxBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457BA1C701D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE0935E0399
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8733EB6DC;
	Sat, 28 Feb 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJckFi6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160E3EC6DC;
	Sat, 28 Feb 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300522; cv=none; b=Y6fdHmUnXvq9vhJ9RdPOD1ldUEHA7DO6JgmsnUb83doSMbIgAtrqmnXNzDAdvb+orIQuHYwBIpQK3HkrmMAP+P6qNDWX9FJG3H5sWoQimUWylzm2qA/z3Ysfvo8fjdLAwXUI0Qrtd9z96/yAuSaWgrY+wTsJhG/StDjN7xeXAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300522; c=relaxed/simple;
	bh=jTY4FYVwDJIGe5KfCtsL6WWiMnwR77HoDz51E9tumDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihityZm5nInNaECZxf7io5l+WSSwORi93ANUhrF2A5LBa7uzkLBrulFJD3NZr1gIyGhw9TO2yuw1KeKKGQH5T1TJj1/07He0lV7JlAEGvw1GeS5fdAPW2c3EzFdEK0axZNnZv0NLE/32avbObRgqYse+Alhbf1+F/VBfuQOB0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJckFi6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E444C19423;
	Sat, 28 Feb 2026 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300522;
	bh=jTY4FYVwDJIGe5KfCtsL6WWiMnwR77HoDz51E9tumDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJckFi6PtQekcLsrbs4r/sKGjAI3ZXmf72hqwv81OKijOQ8E2HHMlSpi+PpOwOurY
	 WS6lxjcCBva6kPcCmfGgw9tP7wHRPLNWrvt0om4EyAIc29x8MHX8xHd13qohabOi82
	 fhlP9VyJlmITZWkLJ9iWDSPjo/LyJ58o+u9A9VNMxC0Q5iWcBJR9uofTLs1ELWd2t7
	 xGUaH6PK7ktmksLEUx9tVo8c6JUHvDibib3q0JVCD9gtJnGjIedujK2+xTzpbCYaPl
	 2b5NHSmC90blwnAzzKQ3Gm1XhXU3KmcNLtwBnlEil0RyMZtpBP3n+2F7JNBAsLQagz
	 Bqvyz01v0Boug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 561/844] HID: magicmouse: Do not crash on missing msc->input
Date: Sat, 28 Feb 2026 12:27:54 -0500
Message-ID: <20260228173244.1509663-562-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220640-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 457BA1C701D
X-Rspamd-Action: no action

From: Günther Noack <gnoack@google.com>

[ Upstream commit 17abd396548035fbd6179ee1a431bd75d49676a7 ]

Fake USB devices can send their own report descriptors for which the
input_mapping() hook does not get called.  In this case, msc->input stays NULL,
leading to a crash at a later time.

Detect this condition in the input_configured() hook and reject the device.

This is not supposed to happen with actual magic mouse devices, but can be
provoked by imposing as a magic mouse USB device.

Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6de0eb..91f621ceb924b 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -725,6 +725,11 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	int ret;
 
+	if (!msc->input) {
+		hid_err(hdev, "magicmouse setup input failed (no input)");
+		return -EINVAL;
+	}
+
 	ret = magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
-- 
2.51.0



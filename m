Return-Path: <stable+bounces-220258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAmpBX8yo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCF81C5B79
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AA1731FF68E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69137CB09;
	Sat, 28 Feb 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZJMM+fm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300947DD4D;
	Sat, 28 Feb 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300161; cv=none; b=r3iMQq7X2bh123IP1V6MOykyRtA5w4rEHqokTmsaNIffDZMwre8MBHaWC1w4Q/SWMBa4h5Pg95gSxTtgu8mVSfBEAgaiHQWW84K6mfdeMUQqxrSAdEQq5Ib6vmxbw4PjsgSR1I1lhRNJzf7ZbdtDnNfGOcQmLml7bMx+90gRq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300161; c=relaxed/simple;
	bh=yKsvD2YtzuvtxDbpqNH9SY22GB/GFuAqSTj5wKz7q3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYxCZlsUdA8q2CjfHAY2oB8eL/0v25Am7j1+ErUTtLxnPGhqoqkz9ft6npob8Bt7weOLTnJBf625GxzZmUbThD9/Y+oNpSlBKzfVTZaJjY1UX+NPj6tXyh1/AWP1lig/WVLeiyvzZsSXA4QiMLu9pfVCTexG1fV94nP9tEfh5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZJMM+fm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056F4C19423;
	Sat, 28 Feb 2026 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300161;
	bh=yKsvD2YtzuvtxDbpqNH9SY22GB/GFuAqSTj5wKz7q3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZJMM+fmDXX7P/zNJwsLP1ZtgeRQHcpuyO12mZis4m1CEAxGxjPzeLc4T0KnJyNou
	 Cfc1RUmGouWO6q/8kvVvHmuuTEblQyQxAlNorKR5U+GwIkwZ5rjC4Gin8+Stuqbwbe
	 Wn/N4KGY+PXIqe6E0YscP622sJLG9tj0mkEKSxCGWOUMe84EaFVkEZ0fh69aeDUfDX
	 13pGCujt2aMGIDPzpzaJbs9jAF/LLkDxsVN6d47XxZsNTaMSOhQEDuBOea7NbiNzUe
	 6jCNyMO9MbDVDOOPQkXt38pm9NUEvwuVm//fff8Ye8UBBw00jVRJ3yPNOzc6jWyO6h
	 ZQwpop7EJoYnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 180/844] media: solo6x10: Check for out of bounds chip_id
Date: Sat, 28 Feb 2026 12:21:33 -0500
Message-ID: <20260228173244.1509663-181-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220258-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACCF81C5B79
X-Rspamd-Action: no action

From: Kees Cook <kees@kernel.org>

[ Upstream commit 0fdf6323c35a134f206dcad5babb4ff488552076 ]

Clang with CONFIG_UBSAN_SHIFT=y noticed a condition where a signed type
(literal "1" is an "int") could end up being shifted beyond 32 bits,
so instrumentation was added (and due to the double is_tw286x() call
seen via inlining), Clang decides the second one must now be undefined
behavior and elides the rest of the function[1]. This is a known problem
with Clang (that is still being worked on), but we can avoid the entire
problem by actually checking the existing max chip ID, and now there is
no runtime instrumentation added at all since everything is known to be
within bounds.

Additionally use an unsigned value for the shift to remove the
instrumentation even without the explicit bounds checking.

Link: https://github.com/ClangBuiltLinux/linux/issues/2144 [1]
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: fix checkpatch warning for is_tw286x]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/solo6x10/solo6x10-tw28.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/solo6x10/solo6x10-tw28.c b/drivers/media/pci/solo6x10/solo6x10-tw28.c
index 1b7c22a9bc94f..8f53946c67928 100644
--- a/drivers/media/pci/solo6x10/solo6x10-tw28.c
+++ b/drivers/media/pci/solo6x10/solo6x10-tw28.c
@@ -166,7 +166,7 @@ static const u8 tbl_tw2865_pal_template[] = {
 	0x64, 0x51, 0x40, 0xaf, 0xFF, 0xF0, 0x00, 0xC0,
 };
 
-#define is_tw286x(__solo, __id) (!(__solo->tw2815 & (1 << __id)))
+#define is_tw286x(__solo, __id) (!((__solo)->tw2815 & (1U << (__id))))
 
 static u8 tw_readbyte(struct solo_dev *solo_dev, int chip_id, u8 tw6x_off,
 		      u8 tw_off)
@@ -686,6 +686,9 @@ int tw28_set_ctrl_val(struct solo_dev *solo_dev, u32 ctrl, u8 ch,
 	chip_num = ch / 4;
 	ch %= 4;
 
+	if (chip_num >= TW_NUM_CHIP)
+		return -EINVAL;
+
 	if (val > 255 || val < 0)
 		return -ERANGE;
 
@@ -758,6 +761,9 @@ int tw28_get_ctrl_val(struct solo_dev *solo_dev, u32 ctrl, u8 ch,
 	chip_num = ch / 4;
 	ch %= 4;
 
+	if (chip_num >= TW_NUM_CHIP)
+		return -EINVAL;
+
 	switch (ctrl) {
 	case V4L2_CID_SHARPNESS:
 		/* Only 286x has sharpness */
-- 
2.51.0



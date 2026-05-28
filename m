Return-Path: <stable+bounces-255301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II10H2KgGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:06:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57D5F7D75
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF6E9312BEC4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2832ABC0;
	Thu, 28 May 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gadOnr+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102426B973;
	Thu, 28 May 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998525; cv=none; b=AwICwjdwalW8Vfsc4PnqZHCRsCMKsTjP0TerPApCJFE+dQvMaT9V5cM5f8+Ta00dCVYD1Lmq++J88ExfHke/SMzuA054OdnXpaaxGtGqWJdIVFxedRJS583DLHw+o4wIQrDti3jw9OQqdNAwbHQHNAUFwI2BvJ7RHQLUjKRJM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998525; c=relaxed/simple;
	bh=SmTvzbvOGnDVguYp4YI1Fla27TjpvzSRHOlsrurIU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyENTxQZYc3CKySN3h+RgwW91A5MTyTXKx/vVZuHS80tZ2F8x8oj6XIBdXSqh/ZuTz7USDWxNXqCaeGEIo44JSsdM6WFPwNKCBKJHLSTnlVb+kdfGCoUhC2xPmHi6JaKV3sBp/6q3RPSrd6vU2ROxp2gfGuNGJrLzNkas/tu8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gadOnr+2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC001F000E9;
	Thu, 28 May 2026 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998523;
	bh=/sLfSDFb+86D4J80726+Wso9c+FnWhLaiZkVoCZd2MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gadOnr+2gaVDeU3VmpX/nV9LQv6a0l4Yu3Qezy4FOwKNJiUhCGttee5N6JfkMUnYs
	 Mpjv5V1sjQ960vGQsVSkVNeyX9G8ELuyEWbh5vRtb+K2Lpn/Rz+CsRzfJfCGCoOi2m
	 JkaUpenG7XElAabFv7aHXs2NO7Q296oXfNbj2oWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuhao Fu <sfual@cse.ust.hk>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 205/461] ALSA: hda: cs35l41: Put ACPI device on missing physical node
Date: Thu, 28 May 2026 21:45:34 +0200
Message-ID: <20260528194653.042956328@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255301-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cirrus.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ust.hk:email]
X-Rspamd-Queue-Id: 1A57D5F7D75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuhao Fu <sfual@cse.ust.hk>

[ Upstream commit fca7401fe37f7abc6e54147ea560f37279231137 ]

acpi_dev_get_first_match_dev() returns a refcounted ACPI device and
callers must balance it with acpi_dev_put().

cs35l41_hda_read_acpi() stores the returned ACPI device in
cs35l41->dacpi. That reference is normally released by the later
probe cleanup or the remove path, but the NULL-check on
physdev exits before either of those paths can run.

Drop the lookup reference before returning -ENODEV.

Fixes: c34b04cc6178 ("ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_hda_read_acpi()")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Tested-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260428081238.GA1659932@chcpu16
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index b64890006bb70..acfccc848f82d 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1896,8 +1896,10 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 
 	cs35l41->dacpi = adev;
 	physdev = get_device(acpi_get_first_physical_node(adev));
-	if (!physdev)
+	if (!physdev) {
+		acpi_dev_put(adev);
 		return -ENODEV;
+	}
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
-- 
2.53.0





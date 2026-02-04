Return-Path: <stable+bounces-213348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OgED5fIgmmzbAMAu9opvQ
	(envelope-from <stable+bounces-213348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:18:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A50E1858
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97E930737E0
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 04:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654EE34A3DA;
	Wed,  4 Feb 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j9L4lmAo"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F1347FE3
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178708; cv=none; b=KBJfsadgJ4u7F1b3U+yN0W9MOFkNV6582yE2GuxKz+23YoVD0Uh5+ClS2LUJutjkJeZVFiDYLEMFCO91gqcOZYdbeeenS6idm89qqgGM7xAbzWbbNLxE0C97M8DzBtX2Ju9yYM+JsLU0Jq40EF2qFcHlT8pGOqJNeDOrxbR6VO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178708; c=relaxed/simple;
	bh=2aarK3bBNBbWIYY3CJ2mvH15Xg4bC1+KoxvJUWOCUEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+VQxRVPX+BMlgXRO9F8Hj53/FzcVbtHcLcv9EjMXC3X5ZjuDL2hv1b2sL6EeeDQLoXyeYDgW3I52FZIZekqRoQaSPIGOnIGcXtkUr19a7MGF9ZqLlK62nqdRzB0g2/uOfVAe6QvuKLFxX8rByAVlDopq9pKZev1cyDHYG1MNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j9L4lmAo; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1770178652;
	bh=8EtOyNRXnsx1AkXOcMmq9y5vg1zdJAgWIb8YApIYJ3c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=j9L4lmAob3pXXTfKPHi2GgDbkJbJrOKmp64pT6izywTgtDSyBuzdjE7VKUkjYQC+A
	 kCaKrv9feGTWPyvA3r0lnvIjBYrsFaa8aaHM7r02GLhHrbzSKgd6de9qEZoHb3h7e/
	 BvkMpgWVr3qIRYMjvgCQLPNbf3DyG4zxSCHGGL9g=
X-QQ-mid: zesmtpip4t1770178647t0f720189
X-QQ-Originating-IP: aPwL48zzZE1x2IPgLMpLMqs1XpbuoM3HlwLpcBmWslA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 12:17:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4183931645728144275
EX-QQ-RecipientCnt: 6
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Pavel Machek <pavel@denx.de>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 v2] ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check
Date: Wed,  4 Feb 2026 12:16:36 +0800
Message-Id: <20260204041636.1218693-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OH2bKVRJtexUjh9G4dho0FngX/fe7tDe2x7FIJBPPB4eZNZ/W4huUeV9
	+ZNssuAwvQ4WWT61kMZwEB6EgpSPktC2lVi7xWXqz7cOJVy45Z4zu0Zyuoko0I2e08xIQch
	uNiSE3ncPmPi3O8Nj6AA058Mnms80/aBkMZ37w6X+ZDw7WKsiE9YgfsLLP8W0MS1rJymuRJ
	LrK5dy5L+uv1TMp6ZRSRCjOdLoo4E7zLduDPz+Fsxjt/kQsiTkwDyzp0A94OWRY4CIbttwa
	fMsLIpF5HvB51DMkQFXEptRAFRHAThblg1wzu6CY/pUZv4JPRsv6QSadpxagQtfxsxOcwtv
	N3MxWw344Qcz2yoNn/ykcJtQzsV85l4Z++45Nbs/nx9vQNdsNMb1J+jKiwyRgtM1kE8BzgI
	27r5AvWQu984uVfxOw65itNoz2R4ccSm3ybSY4nVwTeLaA3iHWsobppK5styqNxjTWv0uCx
	iB3ovG9pXCEiLRUKRuPNyquSYs5VttcsidwxOSaj+GAl6j7hFL6ahy+0n7nIFno/pLeHidc
	x7LLzj/reMjnKqqorKWIW3YLtEc5QcyUZVk8QmaPPW6q/UdsSwNr+iDlBVto1s+Se/SrnG+
	njfi7Z2fWY3WCiYZslrCSaE3Zsp3e88UYkHVBEa13yhlQuzrBLxjX3JxqVxk0nWUkmuQGMm
	YgbqLQgc3/EaomKJj8TGqAUnmm40Dk2UJVT45ArkRyyZ19DjwkaMgKQ/oCYrzFN1GKtdMQ9
	LFgtQYKetyCNp1z0tvaph0RClIoF4sbu7dqmNhStILrP3tQYwrvEnDIR94JTDdQXyOd9bcX
	b3UG04qTDznBzIr+7LtiDyDgj+lq+lsk9SQ1sLbFVBzW7vyRlLh48rB6Rh/RK0+ZEGsaAgw
	mOwPUaRIroaBwduSi6qzIT7NyGgqeY7d9ROgB1BrsIbYoi+mJmWTbXYSMhPH7+xYJn3DPOL
	sALbOg3wtw71eXBmcdVtJdRhj53OkZTAMWDfJsfblLrhXp9KcCWKnslhj1JYyH9lU9zuAkt
	/NWbpJfrjA/dHWs4WbckpwihDDTov/zrWkasecknK9sAlV5AOz2q8fCKO7pLU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213348-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[denx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid,suse.de:email]
X-Rspamd-Queue-Id: 34A50E1858
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

The recent backport of the upstream commit 05a1fc5efdd8 ("ALSA:
usb-audio: Fix potential overflow of PCM transfer buffer") on the
older stable kernels like 6.12.y was broken since it doesn't consider
the mutex unlock, where the upstream code manages with guard().
In the older code, we still need an explicit unlock.

This is a fix that corrects the error path, applied only on old stable
trees.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/aSWtH0AZH5+aeb+a@duo.ucw.cz
Fixes: 98e9d5e33bda ("ALSA: usb-audio: Fix potential overflow of PCM transfer buffer")
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit fdf0dc82eb60091772ecea73cbc5a8fb7562fc45)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
changelog v2:
reformat from v6.6.121
---
---
 sound/usb/endpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index b05ad2eb623db..17ae74b067c5e 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1386,7 +1386,8 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
 	if (ep->packsize[1] > ep->maxpacksize) {
 		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
 			      ep->maxpacksize, ep->cur_rate, ep->pps);
-		return -EINVAL;
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	/* calculate the frequency in 16.16 format */
-- 
2.20.1



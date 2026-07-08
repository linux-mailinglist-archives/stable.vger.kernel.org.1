Return-Path: <stable+bounces-272660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0j79FmleTmqmLQIAu9opvQ
	(envelope-from <stable+bounces-272660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:27:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E535A72755A
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:27:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=fdpQEf+f;
	dmarc=pass (policy=none) header.from=yandex.ru;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272660-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272660-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 328BF30EE3EF
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDD048C3EE;
	Wed,  8 Jul 2026 14:20:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9548033E;
	Wed,  8 Jul 2026 14:20:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520408; cv=none; b=KWD0JujyeicbBv7WtYkqjmhvWv2uOLnxVv2FI73mmnPUb4wVk9A+mcnJyttJrEt40xce3iqf+2/Qu+QlLXxUDHLhoELqJ0s4fEqay7EZ4m8G84vIyX+vyFa9wE26u5JHRLr0xz4948y3EV6a45hvwnrGiSTq3h00ijLHkIcrxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520408; c=relaxed/simple;
	bh=IGaJkHpQuPjMeqZ96N2urPwytfUmszyiSFdkyGUAIok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Az95Mdf+m/n9wAUMZVF2mYX3w5jEEZRc55ubCgwQEWFah31FHo5NUmXkkHYOFchop+hekQ10mFB6kwal18XNoOlHJerEjNf55EGA/TUn2QTUMth5Pr/9BFLyfqeTkkt1wD9xVsa3pinZxedJ6XJeiOuN6oMoYJn/ePmL6YWu2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=fdpQEf+f; arc=none smtp.client-ip=178.154.239.218
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward203d.mail.yandex.net (postfix) with ESMTPS id D39518783C;
	Wed, 08 Jul 2026 17:13:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:20:0:640:25ef:0])
	by forward102d.mail.yandex.net (postfix) with ESMTPS id 83785C0458;
	Wed, 08 Jul 2026 17:13:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id cCKwa9LfB4Y0-2aR2CPl9;
	Wed, 08 Jul 2026 17:13:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783519989; bh=08hl6ivCVHD7yM4ehDDkN/Lp6od+e04MxBxkOp4utlI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fdpQEf+fa8mZxXNeTkv0HfljgYOmvJOQPdgndc3Prt0Gc3dHmFgtm5MjWVwFyT7SX
	 YDRhiCntU7z9dL5+RWASs7bkV+sgtEDRyC3dxXa/e9juLX+K5ramQbcbwO9btvO1on
	 L3u5eF9KRFv6DLAw7T8Igg1n0mO1pxHubH1F0dEw=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	perex@perex.cz,
	tiwai@suse.com,
	kees@kernel.org,
	eblennerhassett@audioscience.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] ALSA: hpi: Check transport errors during HPI6000 adapter initialization
Date: Wed,  8 Jul 2026 17:11:44 +0300
Message-ID: <20260708141147.18253-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272660-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[yandex.ru,perex.cz,suse.com,kernel.org,audioscience.com,vger.kernel.org,linuxtesting.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:perex@perex.cz,m:tiwai@suse.com,m:kees@kernel.org,m:eblennerhassett@audioscience.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex.ru:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E535A72755A

create_adapter_obj() retrieves adapter information by calling
hpi6000_message_response_sequence(). This function reports transport-level
errors through its return value and DSP-reported errors via hr0.error.

The current code only checks hr0.error, causing transport-level errors to
be ignored. As a result, adapter initialization may continue with an
invalid response.

Check the return value of hpi6000_message_response_sequence() before
examining hr0.error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 719f82d3987a ("ALSA: Add support of AudioScience ASI boards")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Changes in v2:
- Fix the Fixes tag to point to the commit that originally added the code
  (suggested by Takashi Iwai)
---
 sound/pci/asihpi/hpi6000.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index c8d1518ee3e7..fd7fe9dba0b8 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -537,6 +537,11 @@ static short create_adapter_obj(struct hpi_adapter_obj *pao,
 		hr1.size = sizeof(hr1);
 
 		error = hpi6000_message_response_sequence(pao, 0, &hm, &hr0);
+		if (error) {
+			HPI_DEBUG_LOG(ERROR, "message transport error %d\n",
+						  error);
+			return error;
+		}
 		if (hr0.error) {
 			HPI_DEBUG_LOG(DEBUG, "message error %d\n", hr0.error);
 			return hr0.error;
-- 
2.43.0



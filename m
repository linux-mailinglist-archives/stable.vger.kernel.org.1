Return-Path: <stable+bounces-243346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPWGGbiq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BE4BF0B0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A3D307CECC
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03B3DEAF2;
	Mon,  4 May 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHPs4NDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363A3A7F4C;
	Mon,  4 May 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903650; cv=none; b=WdolD8f0Co5lGNIbVsLP7noE/+SxdWMClMq+5aZVBQ4NDCj5UClXlA42J0j/KOF7nlO7IIo7PnsssLV3TSIH73aOH8JKOjedtdINQjIvHauJDCDVFsCWeqt2ZOQqiPqY4A5XvgREW9Wsfggg9lcAybuV9MNsKHaZoFAA6r6oA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903650; c=relaxed/simple;
	bh=oMi3JsNaO+E/WwYY4c3L8yGbs7Sd2S0NqUo9pvjW/fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1AkHodJB4i5U3cXzXHO/3yZraezgiB8oIB+V5/FYDlcmUDRY4+Hj6CLVdP30PLmiZMOnE+Ek6vaGOInKhEU/l5F1vxDtA0kEO3NgkFjbernecWrCOImZrTZ/99sNS3+EwdZc3o/rZAHQI1HD1JNGkyP4NCXZag6Eb7LbI4u8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHPs4NDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7880AC2BCB8;
	Mon,  4 May 2026 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903649;
	bh=oMi3JsNaO+E/WwYY4c3L8yGbs7Sd2S0NqUo9pvjW/fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHPs4NDoyDT+jJA/vWY8H2npXROPnidP2juj8PW+io7dxZvN26Q9/7l3toC8Zv5nc
	 Pba7iNvpNu1L8zWVSASsjoUHifq5tkhv/CNFGo+n3fAMQSkW+6WTwyj8lpkosdrGWb
	 VuVNsb+Tb+QcTX3W1uEOkHSboERBNH7BgJwdFUkE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d56178c27a4710960820@syzkaller.appspotmail.com,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 001/275] ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
Date: Mon,  4 May 2026 15:49:01 +0200
Message-ID: <20260504135142.989741281@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C35BE4BF0B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243346-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d56178c27a4710960820];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,syzkaller.appspot.com:url,appspotmail.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit 3c318f97dcc50b2e0556a1813bd6958678e881fd upstream.

parse_uac2_sample_rate_range() caps the number of enumerated
rates at MAX_NR_RATES, but it only breaks out of the current
rate loop. A malformed UAC2 RANGE response with additional
triplets continues parsing the remaining triplets and repeatedly
prints "invalid uac2 rates" while probe still holds
register_mutex.

Stop the whole parse once the cap is reached and return the
number of rates collected so far.

Fixes: 4fa0e81b8350 ("ALSA: usb-audio: fix possible hang and overflow in parse_uac2_sample_rate_range()")
Cc: stable@vger.kernel.org
Reported-by: syzbot+d56178c27a4710960820@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d56178c27a4710960820
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260415-usb-audio-uac2-rate-cap-v1-1-5ecbafc120d8@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/format.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -463,7 +463,7 @@ static int parse_uac2_sample_rate_range(
 			nr_rates++;
 			if (nr_rates >= MAX_NR_RATES) {
 				usb_audio_err(chip, "invalid uac2 rates\n");
-				break;
+				return nr_rates;
 			}
 
 skip_rate:




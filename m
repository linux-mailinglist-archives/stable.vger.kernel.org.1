Return-Path: <stable+bounces-238143-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO8+OoKq32mOXgAAu9opvQ
	(envelope-from <stable+bounces-238143-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:10:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BD405B85
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C84B30ACD07
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F183D8125;
	Wed, 15 Apr 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj+PihuL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516813D1CDF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265518; cv=none; b=muiR33gkVVPxHbXmFXbIYk4qR4UgIb95PJaMps9zSSDzmVR+odDcQJBdUT0IlM5irR9dO+gpw7anr7/RHU0JOXwP8KRTUqgIXg0TUVNVDjDP2CvLYCO/eOgO8KrXc4G7fDvNesegViWd1B4Kp5tKzsHWuE99mUdmMouBOjbN4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265518; c=relaxed/simple;
	bh=NdFOSdbMJ9vf315N4Dc7tSEJ4WJsvUqrGMOnuhhLwgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JFnX2cyCivCH7hpCs4C2Kr9u4XwjXeMuy0jAy2yjdfZoewzWPnLic92xH14y7JkyHogksv2swA8dnGAaAuSMJnlhekn+zI8oEJ/mlz0jaA+cvK72zTLPEJfkIEiw6Vgdrmx/oWI8DU9dc7wBWlGWSnnwZFFD4GWhRPzWYMvYHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj+PihuL; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso1768413eec.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776265515; x=1776870315; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNKSDxA3bbuCnyIBU41Bvy1qxQJrNbNn16c/JgR4kHA=;
        b=mj+PihuLAU2N0v1Pt5yuLXNZ/KB4iHM9kYA1xXekuRi2xRCwX+ZEESm/ckMELR1zhK
         EjZCUaD8GifWOrKxkuuB1LmbUzGKow9EkeVTjeOsEComtaRpyp3fypEkT6+tFMCi8yVp
         ojY7BVFkyehiYlGYX70A8Jc/VNnE0ro10o0XPcQiW3OYazUgZF9LKOWWy0aDtc6I8ScT
         zFmg9TVcEDw3SJa76TqaTHzDeOWK17JEUh9PStGLD7NP5I9oyBzrYMGquhqxQPJl/1uI
         ahA+b0/HHoOgj/V45kNS7c3fr8CEHAzlI5nCrl6aAqdtQWPuHgZwk7J01sSddv1C0/85
         bpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265515; x=1776870315;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNKSDxA3bbuCnyIBU41Bvy1qxQJrNbNn16c/JgR4kHA=;
        b=d5E7f7zyIs1o45F8NxuO8NIIGWKivfhHrd90digofWRkK1ZmXtxAhMvYIoqiWI/PYJ
         KSjxbFs6jLffLe/d8OjDuX06fs6ImLG6aKME6Xb8gmmdPKdTXzU0b6jcMoVtpF+LZTVf
         g6Aj8HwW2oT4BJMd0BCAayFaI507GniV2N7FeKUuFPG6YC016WpgicrYV4NNaGsJD2Z6
         hW0JnLb8hs87jzwMgX2IyyPhFQHSOg6fSoSAX28XUGbKEwZmeCs35TbrN8nyC/I6SZ4g
         l9DSc6ts4lGOu/QyfvGh4OS+EgpIZqvLH6FqXAXxVnacUp8w2X2nPGyeFgDbyTkZ5S2v
         7niw==
X-Forwarded-Encrypted: i=1; AFNElJ9RUfZKFynOecZXcqpa5d9XuzXT/Bnav8+DGFQGYooeBuXwIBUTjVdjCHqsNOxXL4t24ShoQhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylwWNEJosYiEdOdSxDoU3+J9Md5oqMQ/XO3jOjLwGOjgy5eVex
	WIUWS/BjNjRD8aLMidxsjVBLxtkuXktDlQG0+DlTkvEZARgbu/Y5e6Eu
X-Gm-Gg: AeBDievNChvNBHTSket5HIsOyTz5E7NOX5+MUpY+y7lnFKqSVLUTgVc+T4fq+dASQV3
	+AvDjGvkmOAyCs4ww51r9T42a+cGtWfBVQX6ObtbeOUzK0FmVOdG2D1baYRl1ilhSlSaeJ5J/+A
	I4FB+PLCYUbfUog3dbxOVhy+gAemiHBAGVjxXJa6EfrimgkB9gIwwFPDUXXuO8P7b2YyuVR2Cyr
	kGrG7/MHGX1bGSN2IoBoiAp79+IGi6fTUSbYA/pLHxUwrYiMRMoCOapAbKMX2Agbc4fS6sTKT71
	ly3sj00el7j7Xrkp15cdr7OD2dP457YkbcCbstwLIuOsNcU5sz2Iour4koJAlFc05XLHApgpULU
	76Sbz6f2H9Dku6sNPyJS+aS2/xiB0dCO+0AIZGTiwry8Z3c4aloEDX8spff2h3tpNhTejGYT6AK
	dBK0FqqlQuxesMVeRDwWPEkftCF84COf+Nr10qyyzMIdzZxyh7tdjG1PnZQlq93Upg3Z2ChsV4x
	HpJ
X-Received: by 2002:a05:7301:4b03:b0:2de:e194:5fb1 with SMTP id 5a478bee46e88-2dee19467f1mr779818eec.7.1776265514977;
        Wed, 15 Apr 2026 08:05:14 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f965c5fsm2882844eec.26.2026.04.15.08.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:05:09 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 15 Apr 2026 12:04:53 -0300
Subject: [PATCH] ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260415-usb-audio-uac2-rate-cap-v1-1-5ecbafc120d8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz7UESUC0V6kYTHDBDIDiBCEh7
 t7Qjm/4/wTlIKzwKk4IvIvKumRUjwL8RMvIKEM2mNI0patqTNojpUFWTOQNBoqMnja0rX02TLW
 zroVcb4E/cvzO7+5vTf3MPt47uK4vy00WJ3sAAAA=
X-Change-ID: 20260415-usb-audio-uac2-rate-cap-38396ea54348
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Xi Wang <xi.wang@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org, 
 syzbot+d56178c27a4710960820@syzkaller.appspotmail.com, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=NdFOSdbMJ9vf315N4Dc7tSEJ4WJsvUqrGMOnuhhLwgE=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJn3V8qWpsttcYvcWpZ7+DpLPiN3EMui6pj776coFv27I
 736i+esjlIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZhIcSTD//wdO6a1W0zjr/JR
 iJOYmMme87uwU5VjU1/URfZ9+TlHwxj+B++YOvnExB0lPCuYz9k0BubO3iWi3fJQydLqUyzPafc
 /TAA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,syzkaller.appspotmail.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-238143-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,perex.cz,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d56178c27a4710960820];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 389BD405B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 sound/usb/format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 030b4307927a..4830f9f93ad7 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -470,7 +470,7 @@ static int parse_uac2_sample_rate_range(struct snd_usb_audio *chip,
 			nr_rates++;
 			if (nr_rates >= MAX_NR_RATES) {
 				usb_audio_err(chip, "invalid uac2 rates\n");
-				break;
+				return nr_rates;
 			}
 
 skip_rate:

---
base-commit: 894f1f133f8ee078d25813ebe10c8c3f396a57c8
change-id: 20260415-usb-audio-uac2-rate-cap-38396ea54348

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>



Return-Path: <stable+bounces-219803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFNPHeVHoGkuhwQAu9opvQ
	(envelope-from <stable+bounces-219803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:17:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBD1A63D3
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F19A3128FF8
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A965318BBF;
	Thu, 26 Feb 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kytDZLgU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262A1314D2F
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111498; cv=none; b=PO0/vREXJkHhSjQ62Hbd2wEAmDFEGWAv/7QA0PrgQMMpxF1tXENJJmPY6ikACIkpKpPkuaEUdBsQkvzWwMk4tuyLlVGduLewNjBhOtkN+D/7ixfqhSQnPq157B16hQ8kwE7WbuWDd/o8c4CbKmuG/lQrBs4oRsiVxgntScOuj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111498; c=relaxed/simple;
	bh=0R1WoZ5pqlXLkimXuZO/hVP+ydmsIeNVMtvfxguyoe4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DewQeaKJnlSarlQwwVIfzcbXUDUM1kh8rsJ0JioPyUuG9P1SEeWjD2LO/n+JxPngS/c+g0tCLaPwnCZhrtGRljiE1jjCUXhWmmUdjS3lSYJ8KsOCDr9ZR3ltor29/ztqwMynxxA1ibkGFY1DUmsOaTduCN7s1JEZf1ZvgSf37LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kytDZLgU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so10069625e9.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772111495; x=1772716295; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPnwn7qk3luW4iML714eLyIf29N08tbW9a1oS6Qc5EU=;
        b=kytDZLgUcQ2DtCvMAn0RdWolHA7V5DU3tNee4Vpzpa340bXDGv3SijKxK9uVJhNDaP
         pY85SYEQ7l+A7XU9S6JzbYQB8c/ODTBBKJixHYhWI/gyAQLEECXEuOdmvqsDiS+7+eir
         f6uvvzXNDcMxSG4jAxXXKwB7AJGNViusbFW49CnxBlNYZyNM6Q5l5BIRZqKzgK8D+Wu9
         ZrN4la2Gx4qEl1GcVKlwwph7raClu8aSXRSQKOih9NAE98g7V0dyBK4SrSWoJZpvoHdZ
         Mg3ffqoxCec+ASUd4HS0x1ioWVoIggLvJEIWoo4eoEnjPKIHWK57Rzaj690dCOXMysYs
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111495; x=1772716295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPnwn7qk3luW4iML714eLyIf29N08tbW9a1oS6Qc5EU=;
        b=d8fV/kSCGAcIL52eI5a9kMxzmOoSph3vYq2DIvraRQ8dbzWsFa5WT+8HAR5mMM/YmH
         U5CJZgVIKT9wCYBbZx8hY0FY8+iL3Kes5V5mTjNZAEI82ODna0HxE602s/QANJF7klhv
         TkD47RzLItHMYnieuS8F4ohUpHiY8y/gzI6W2XBHsLRCdYaHTRkDH/5+wQLvAKsN+Fnr
         V8NkHkOut3Hz39mpC2XVO7y4KscP+e0v5ijHiY+hKD8BjAgNLh18R9Y7FvxltSlxHznf
         KSAAk/B8jYFN8VbKOXa4jfNBIq27OJCKTTyiP9V1zck2jhWuqyOI4f5aVl/fWZF+C/Vt
         PLrg==
X-Forwarded-Encrypted: i=1; AJvYcCVuJ92xix3LII1GhncLsrBgjvoRMasdD3z756F5af5vt7vNIaeNgbcmZ1v9zOGk5vH7D7KJsmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0P739dA1Z7y7lO1ZlwLFFccvsE9k9wWK9DeRUOaCP11qQaXX
	wVVB1xHq+OnQWeSHFnOiAifOQQV3KWDHBeIf4A9sa2A6tqzCD4JBPRs6
X-Gm-Gg: ATEYQzxnbH6FpZV0TD669UPfpRctcihL5u0es24oEVOARD91kPI8/cYluzKMYzK0CqU
	sVc7cvRShlJEVhONhEXor0J0dI2FCDTnWT4iVWgZU2X4iplDP0vFC1cl7NxWUBTWlbcoIH/Y9O8
	ngb/pPO+IdXZmfRnhVdGQFDrNK0lfk7kjRIfM/oZgUWDbPjZeO8vASr03a+BTxzl931Mf+uu4qY
	jrNPL0bSeVt4VagqN36vmdIQfRzB7MCdRUp0yHGgDnDzovLcYHPLjiXPYRKlpOz8CHyl+j0+LV9
	S1gkQqf70LEq0La9gmQaNpaE8HnUy+rs0ga34Kfw572PqqNP0rFrs4xe1LyRi/jaSkzxdIiWgJn
	arclsOEcYW1XG38Pi53wkLAt1i+SLTuCblbZXanVHBRE0V6pttG9tbEAae3kbaqk6+/OC04r2j9
	3U1U6x46PaTnJfGcQIfpbBsAEm1MZJs8KVjX7S5k7EzGkuN/+I/5dq
X-Received: by 2002:a05:600c:5250:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-483c3db3180mr31418995e9.6.1772111495342;
        Thu, 26 Feb 2026 05:11:35 -0800 (PST)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-483bfb789efsm64827145e9.2.2026.02.26.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:34 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v4 0/2] i2c: pxa: fix I2C communication on Armada 3700
Date: Thu, 26 Feb 2026 14:11:26 +0100
Message-Id: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH5GoGkC/4XNywrCQAwF0F+RWTuSSZ/jyv8QF+NMbAP2QVuLI
 v1304JY3HSXG25O3qqnjqlXx91bdTRyz00tId7vlC9dXZDmIFkhYAKJAc3odft0+sbPZfZNVT1
 q9m6QSx1RGshQFMCnSoy2Iyku/vkiueR+aLrX8m408/Yrmw15NBo0WbBZAOvAJKeicnw/SEvN8
 og/Ld/WUDTvYiSXmzx4+69FKw2zLS0SDRL09mpsmjpca9M0fQCKjgAFZgEAAA==
X-Change-ID: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6
To: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Hanna Hawa <hhhawa@amazon.com>
Cc: Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219803-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sartura.hr,vger.kernel.org,lists.infradead.org,gmail.com,kernel.org,openwrt.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j4g8y7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2FBD1A63D3
X-Rspamd-Action: no action

There is a long standing bug which causes I2C communication not to
work on the Armada 3700 based boards. The first patch in the series
fixes that regression. The second patch improves recovery to make it
more robust which helps to avoid communication problems with certain
SFP modules.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v4:
  - rebase on tip of i2c/i2c-host-fixes
  - collect Tested-by tags
  - Link to v3: https://lore.kernel.org/r/20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com

Changes in v3:
  - rebase on tip of i2c/for-current
  - remove Imre's tag from the cover letter, and replace his SoB tag to
    Reviewed-by in the individual patches
  - rework the second patch so it does not need changes in the I2C core code,
    and drop the first one as it is not needed now
  - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-0-ca42ea818dc9@gmail.com

Changes in v2:
  - collect offered tags
  - rebase and retest on tip of i2c/for-current
  - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-0-e9097d09a015@gmail.com

---
Gabor Juhos (2):
      i2c: pxa: defer reset on Armada 3700 when recovery is used
      i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700

 drivers/i2c/busses/i2c-pxa.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)
---
base-commit: b4b4d88ebfbfd3aadb4c9a0f2bfe1abdbaf5822c
change-id: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>



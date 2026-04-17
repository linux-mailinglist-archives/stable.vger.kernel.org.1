Return-Path: <stable+bounces-238477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISCEI0V4mnZ1QAAu9opvQ
	(envelope-from <stable+bounces-238477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:12:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B4D41ABC5
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC4C43021D2E
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FB13B8D76;
	Fri, 17 Apr 2026 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH1xde/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76D2010EE
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424309; cv=none; b=InwM6BqKt3i8yw8TaOuoswImp5dw3AYZQAFzjGAY5DuFsiFGYyyiIdItNK2sQL/YgrCJtWt3rCtiMm+Vh1o64kNhYSt2XNdi++ZfapcIVxOd6g2PKokxFC5SyJngGyDKjrBbRUtaS/W1pFAI8c0Bx2oyGZjPMWdSoDonPXqr7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424309; c=relaxed/simple;
	bh=6jZsOBog8nCDRX+b4qhGP4hvs66ICQ7vRIqQ46orEtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYWFKm5Q63pKkkc6mIu03HoN5J+41vj3CAC+TBKmudoTOQQofrWtj8Y2tLdUkMwqzbSJX/bWcMGQRz2RLJEb08XcNn4mqfXVVIgRviTJNTnCIl3ZHhaji6Pd78ystMfyVPviHLxCbOnBSSs4/XctygS55je19kfMkWcCzKFUOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tH1xde/k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso5972855e9.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776424307; x=1777029107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lILZ9xCRIhsyc5RGRj7FW3WYBtZ8SuhhYrZ8gfxfmyY=;
        b=tH1xde/k41b2TcY/FjhdGJ7BXHntbeBs3ZZ/NhIk2XfmiznQ6eAVWxygJK8elLisHr
         fc3e1jYpi3Q0OKCthdQjeslkyHkM12GjdgNTGJogoTYhlXb3lyIct1WSoaj2XYeOf6TR
         Y2fmD+IDwmugFenaisIsaBriT36E6ZJ8ZwlcUiO9krsIuZbOrxs46OBmsf6tNxjWUtGc
         8cE0WTvYLd+BpX3TK4iNyE39NZJnDugle8hzQiLWequq3HPKxWCkefh6hbd+JRbUNseF
         S1oN9/JNapLiG8dZswcGwG/H0S0zwQaxiFTpAs0/VdQEgamzE8x0ZN3gLtwoI64OEjvx
         WfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424307; x=1777029107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lILZ9xCRIhsyc5RGRj7FW3WYBtZ8SuhhYrZ8gfxfmyY=;
        b=IuhFhu1AX8p8HKhoodHeg1oOkEIQAGHFn2WCpJ0+cp2UwyFsf1eaf4BoTPjZjInErb
         EF6E+5ksG87ayPGeW4wGiAyrisBwN3Fo0odYqsM/sQLLV03/BcSRxyFKVxk+QuwfdCIf
         5P5V68GSQyofkrU24RiKrrnldMAds2s3ctPkQKemkwGjqtzAibJvhyp79ZtyPTF4mQ0s
         mRSV4J5ZcM/fqVO9pUWE9AB5xaUyQbhAv6eNq5tkwQwDJjjCBe6AMZySGV9UNFCJLzLQ
         KE4fMXLKRuwcycW0HVNeBUxKbKWt3geoT85tGchlJclQO7kIcuQiy4BqxMOrzrmjQ5Lh
         wZsg==
X-Forwarded-Encrypted: i=1; AFNElJ90VMKL7XZMpU7LXMBmZ26JV/hIIwmfh5aZApFv0v5E61k3/QUejrNltJbYh4AYyRq4n/SJh48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dFxw70N/IxVlF25Zy6qEJoFRXCAneg5YZIK53lrxq/Q4kWs6
	n4KYDwF+EgrHucR6f36rKi6fnOdT3tg+d4EMZfMAaOQL99qRK0hTS8A=
X-Gm-Gg: AeBDiev7uqml+Cugbov8tPBG369YSfwtks5smTBhDWgKPE5rVQSBP0vPxe4vxlYcCav
	rO48wcJs+OjWoYOiGuahRz3KMV+JMzRo4TIbCJv/LsrvuNu3grJRy9D79OWoIm4SmpjpfILrnYV
	ZjxNGgnOWORgVDLcltbrN6URHUS/2a0/x2FgvgoI0WTdQYNg/4hg/f/Qg+yWhB3GHMmKRN8XXtw
	jKRcgPTbJUzixpv4RaVuwlGGnQlFrE4xIz6AFTWLMSuOZ930YnvWAYh0wHEPBbpcL8vvAgOUHIK
	QcRpB7UIBmeZWKUUXUyovZX8pkc71Ao2rwix+IbL41NFYBAn8rhfflrJhQBQ8qOeMQvfsp0ZdAR
	hx7lB57TZNtFjWtVGxXPISC25OhDuHwRGmWC4IsrkAjLKnuSWmjg2JKV25Y8Agns2V6JSxVl2Og
	Sm6Gc=
X-Received: by 2002:a05:600c:3e05:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488fb78280bmr36497025e9.24.1776424306538;
        Fri, 17 Apr 2026 04:11:46 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm62121235e9.3.2026.04.17.04.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:11:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	jonas.gorski@gmail.com,
	m@bues.ch,
	b43-dev@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] wifi: b43: enforce bounds check on firmware key index in b43_rx()
Date: Fri, 17 Apr 2026 11:11:44 +0000
Message-ID: <20260417111145.2694196-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,bues.ch,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238477-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bues.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0B4D41ABC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled key index in b43_rx() can exceed the dev->key[]
array size (58 entries). The existing B43_WARN_ON is non-enforcing in
production builds, allowing an out-of-bounds read.

Make the B43_WARN_ON check enforcing by dropping the frame when the
firmware returns an invalid key index.

Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Acked-by: Michael Büsch <m@bues.ch>
Fixes: e4d6b7951812 ("[B43]: add mac80211-based driver for modern BCM43xx devices")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/broadcom/b43/xmit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/xmit.c b/drivers/net/wireless/broadcom/b43/xmit.c
index 7651b1bdb..f0b082596 100644
--- a/drivers/net/wireless/broadcom/b43/xmit.c
+++ b/drivers/net/wireless/broadcom/b43/xmit.c
@@ -702,7 +702,8 @@ void b43_rx(struct b43_wldev *dev, struct sk_buff *skb, const void *_rxhdr)
 		 * key index, but the ucode passed it slightly different.
 		 */
 		keyidx = b43_kidx_to_raw(dev, keyidx);
-		B43_WARN_ON(keyidx >= ARRAY_SIZE(dev->key));
+		if (B43_WARN_ON(keyidx >= ARRAY_SIZE(dev->key)))
+			goto drop;
 
 		if (dev->key[keyidx].algorithm != B43_SEC_ALGO_NONE) {
 			wlhdr_len = ieee80211_hdrlen(fctl);
-- 
2.47.3



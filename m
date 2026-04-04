Return-Path: <stable+bounces-233308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GgYRLQKl0WmCMAcAu9opvQ
	(envelope-from <stable+bounces-233308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:55:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87639CE33
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 01:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52E0300B988
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 23:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B21F2FF657;
	Sat,  4 Apr 2026 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjwF6wlz"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5B286D70
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775346943; cv=none; b=Vp7jvmYVravPL2t7la8LwrehLUbPTc0e4HALTKq474Nw9hbAq9gMT9B5wjY2+ockZLFMxlPJTjAoft4HAbvPIwj+41n58OO0SK7eITB5xhF1jQJjGuqBsLwqCLyIO3eZL0J/O0tx8ul0Rtz8ObfJMobxHs1Hb1MnsWLwzPH5IFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775346943; c=relaxed/simple;
	bh=EyUYcp2qyvrkMNQ5gO1OaVokxM7EP/0buscgSwGAgTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvP+qrI82mTedM8TU3IQyL40pW4PLeo/UHNOnApCTLi5s3PMpkAWGLUt5C39bgQbR5vdbGOobxGedqRtSFK6kRwDcgPVlcqW5RwvH7r6/CM5I8tEYR94LPKr47O1cRM6As0i48276C0GSyjzhWZdepgFdfwjNyt7okk7qLd9gWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjwF6wlz; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d89f35940so994394e0c.2
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 16:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775346941; x=1775951741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lcWK2ZmstYCPUTW7q2PYzGVzcHD7v4lIlVs5LsX4CQ=;
        b=YjwF6wlzugxlzoMYOLhkxn/BlIDIj678fd8UJi8rLTTDcDo3de/H17JIDKwp6aFT5z
         eH/86MNlNfQ0CmrWj8uqEDiOSH/fH8nEnOmSk6gV9JBcyNiN9Ta9CV9FM/ypgoVdZNSv
         anLdhEP2IJbLsB/VAEPpVRU2+7VsaiLR668RbP64BSgWr91tNiO+36/mL/+w3N2ITi0p
         ksWMzG7i1l3bVoa2XSKW7WOpT1m+ukyx4j1dgx6cqkmv1CbIZzz/4br2sT33YY3yQqWb
         a82pDn2NV97tmdTa0aLjIDdErHek58/SnX6Lw67/tRIwp+K3F99at5l7aS865fmb4LKo
         YcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775346941; x=1775951741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lcWK2ZmstYCPUTW7q2PYzGVzcHD7v4lIlVs5LsX4CQ=;
        b=iiOjoR/ATwtFJOnVo+E8d6x6y0Bxc2aQKkWzRSwVjUt8YGqQ5D+ykaRvltD+srRxbH
         /oW9xJuYI+17ZdqBAm6x7c3vqi+V+kvMTh+P292LoInEW8A3CN5BzdF+9AFb3ETXP/26
         NajHZQdLNrgjWOKeVptPEpAchPhqzpRHuheUjL2mvYIyrvakgfW3BXAJ3mhMQfWl7jUi
         Gb9dHIJQjPvhNFP8lbwYIlpu+BfpPmmSx73aBPGifje+QxvAWbSVmXxVNcRd5YZhms35
         px3cfBV3b3WWg8CibGwiKmHWNjGcT9EXHOD5Q6mFRAOazCLYKJ4P1LCFJ2rNeLsPdZua
         Cheg==
X-Forwarded-Encrypted: i=1; AJvYcCW2gU4xVLgSgvDNTrE66cOhffLsR+lKC4Sjjs8acVPFgn6EQ/Kf+MmQN6lyh35K8yGsG6v+fgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1dVDWTrlYxF2lkhbKvbea2mpdkSYFPpMIDT4JwJsLzVmYNtp
	/ewKuJzy9OLJ6CR48zuFxXZItI4Tz2ZKVl3kUwfWgQqmcSBH6ioLlQhS
X-Gm-Gg: AeBDievt0xqXHCuJPwIIsr6HSYeXU4mn7R4N4t1/P1FbI+zgluPxPwWKF8zIK+ZDVjZ
	ChRoQzgHpY01YZ4JIgdOko7RFDP4gsPG+79CWUwVC8DlOazRL+zIbnmpBXHwXDOPt7AGaiDdnNg
	UvGQiZ76ZDzI53jJdqcgs1Bz6aSxcHcNMr/804gnkyNQdmYgaZWCCcGrkN0kVFLhcUX9EV0BqY/
	3b4y+tDbQ+q3qil+TLMZ47HglNR0QXT++aHeJ4NQlw5yVplINXnTEMpTFzApc7aiNxWNhVY0OeA
	mJjdZ36exfxghoo3hpWAnUj3BUJcLyBKXgS/qsxR4BqziJuJj/rG6yRSV+k6onKfZWz99j9fBLm
	aRnnt7jC9fMAUkjGGli3RaRFbqVEAhxnk4LsIQq7K+wVDhOPCzbOeVY7AHwb+tIzoi6sq30yHwS
	Izhk01y2N+2OUjhCf11lcrC4GOVhzYhO9WwaRFj6KDIdhOInPikX8=
X-Received: by 2002:a05:6102:8557:20b0:605:b96a:a0d4 with SMTP id ada2fe7eead31-605b96ab4d7mr1003426137.27.1775346940957;
        Sat, 04 Apr 2026 16:55:40 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fbb1a0d7sm9447301241.13.2026.04.04.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 16:55:40 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: fix integer underflow in TKIP MIC verification
Date: Sun,  5 Apr 2026 00:55:22 +0100
Message-ID: <20260404235522.72483-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404225752.61297-1-delenetchior1@gmail.com>
References: <20260404225752.61297-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233308-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A87639CE33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In recvframe_chkmic(), datalen is computed as:

  datalen = len - hdrlen - iv_len - icv_len - 8;

All operands are unsigned, so if the frame is shorter than the sum of
header, IV, ICV, and MIC lengths, the subtraction wraps to a very
large value. This corrupted datalen is then passed to
rtw_seccalctkipmic() and used as a pointer offset, leading to
out-of-bounds reads on kernel heap memory.

Add a minimum frame length check before the subtraction to prevent
the unsigned integer underflow.

Cc: stable@vger.kernel.org
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f78194d50..1fc8bcf39 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -390,6 +390,13 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				mickey = &stainfo->dot11tkiprxmickey.skey[0];
 			}
 
+			/* Ensure the frame is large enough for TKIP MIC verification */
+			if (precvframe->u.hdr.len <= prxattrib->hdrlen +
+			    prxattrib->iv_len + prxattrib->icv_len + 8) {
+				res = _FAIL;
+				goto exit;
+			}
+
 			datalen = precvframe->u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len - prxattrib->icv_len - 8;/* icv_len included the mic code */
 			pframe = precvframe->u.hdr.rx_data;
 			payload = pframe + prxattrib->hdrlen + prxattrib->iv_len;
-- 
2.43.0



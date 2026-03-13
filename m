Return-Path: <stable+bounces-225397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAFNNciOtGnipwAAu9opvQ
	(envelope-from <stable+bounces-225397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:25:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1228A624
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F6D03050431
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA16385534;
	Fri, 13 Mar 2026 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbz0RRCC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E73603C1
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440709; cv=none; b=UM7L90+zZYaXxySMnlTV1UYKf+S9R1rVxhnPJeQnPSSE1M8LRI58HCuHrZGViVIOL6JVvVBzD9/vtlVGejC+iRMT4MXa+cx98jHGPXsn/W7oGxA35EU4OgotuOEAsLHxxkfycxpB9YvK3AyRzJSejIfZR+ajfKIV0CngLQiSvXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440709; c=relaxed/simple;
	bh=0dXQFfLwyqTDNO02P7pMGtlWHfEe0Lwb57EnQeVRc2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sim8rSsW2XzQyLNPnzKbrfZxUXttIAineOB0vTlb2isgEI3N/i5M9uPM+f9TuZGh8F0nI+elQeBHq+mJ5RSD5VKBWvRbOFs/u+vGjr8WEPkn0JuFCWOChmewwk48YZyBmijJ8PyJtJTlsnZkDGjtDPE/kaItCtidxbEMc+/Kef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbz0RRCC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506bcb23a78so22401951cf.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773440707; x=1774045507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ16Ge3prHbi18Wm6MkAhYmn4692JC5/iHiiLdA10g4=;
        b=Kbz0RRCCkBrP8OGmX3NCu47hBdkXSGtYA0PTtvRRyh6bF+L72ue4hAR0b4RpQXg2Uj
         PHCupMoZXTzPbk3o5EfS5XJXdtmY+j8q+jorQPg9kGzXZ3rr3Q6vEY9KfQSdLAyBp6bY
         /j9zuyD6XlTgWbQHm/6SvaS4HXq9kF9SMyoMbTy+jtfRZ6V+v65CW4+GUbBksQVQrPSn
         7cDVra02XZE+5M8GQ8tUNRyBtppC6oyqJkL6Soy73ydMZv/EkUPBcEFybxWX92+7Xd+v
         H1dXITC4mhTxmcpodMgMKO2hsLM5z3p9+VNzBTD/xwP6KRlVAOH97GCpSp6WOlTpO2Xm
         JZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773440707; x=1774045507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ16Ge3prHbi18Wm6MkAhYmn4692JC5/iHiiLdA10g4=;
        b=XYSv2nf0vpDoprkfqRoRRjpOnkEZ2j5N275gBfgXgg/SZ9Zuv1/h47wI9EkMboI1dp
         1QQnkvwuxM+8vqrIA/fW9zOjJSDA/w0HyW/IHx/IYYUPCcs7CJn/gXq+Ak0Jbnmb9Uzr
         Bbs7WVBNCzpsvYVWX0nAVD6xilfXNRiaIWaOlZ7scD4PvrMAbvSQd6PTG0Fg15J03VL0
         YRpfEqTemOnSBzM+MFPEy1sRLhmjBsqcKVOTRqaDoz+s+QJlz85riWnGRADpAfqg1XAu
         JFCYOPYbzKgN637vSWYPDxuBh9S04IdCUKPBmquMipgg9x6L6f/pbYstyPwv47w59tHI
         NDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNgZ8DGfCSAbLPxW9UzIHQ0l9GHJ1l5ODKjuQM4h0MeLHPLsTrjuPsrnqPRYcnQkkR113l8qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC0Fg3brqxA6YxaEAhoHMK1XMGoMdsTUJwOAZ9Xb4EaTyrl7Z
	lVwAdwmqrIlWVZGjbJf7KoTgjFfa1Ei5+mVQ3BzBoJTtUqJ1EBW+nx6j
X-Gm-Gg: ATEYQzzngUBB92pV3F6UJ7xcnDe3jZ1UngJNtiMiJo8TcvMWfd9t6RcuB+7vnZQ099W
	FOFqw1xuXWGjw1ONTXISczWHgEFigcKhJJfSRJRqLPh6NsYO+64LHyrL8o5WdpeIyLYjuWPSd26
	tepSiTOfopOPhmwY/QakwprTVqlHa3Ew+ZcWl/P0r8gu9uhQRnaFmmep6K4d9gyYUXH31rt3sDf
	DdpjjfC/ohRnc3wSgxlU40t29GXfw/0wmJLODj43huIgpDsRktHThpxgtAc6jRMP6Ha/YQdTWl+
	Wo79hcgRy2LSstD/6dd3tpJ6Mm8hXGUyB+4zkZ0nSVovZDUGlmrIEE1OVXlOBt+t2FceGo7JD3S
	K6PxMV8ZwBQnDZjfexLGG4Lx+bQvJeRzcrvabpBgRyw03GylmaRffVVoO46OiCc5HBppGWCqLF8
	GeL+aNxE9dv+8oQrwRuW9gfP6I+lDKXizKAlprae3r2vaBLW5oMwsIZ8CyFDs2s841A9pVKU2fA
	/HNLCN+ej2FXR1uQkDY
X-Received: by 2002:ac8:5e06:0:b0:509:2222:420a with SMTP id d75a77b69052e-50957e37e66mr61462371cf.60.1773440707324;
        Fri, 13 Mar 2026 15:25:07 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfec56sm67069096d6.39.2026.03.13.15.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:25:06 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v5] usb: typec: ucsi: validate connector number in ucsi_notify_common()
Date: Fri, 13 Mar 2026 18:24:53 -0400
Message-ID: <20260313222453.123-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,dartmouth.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225397-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 4DD1228A624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The connector number extracted from CCI via UCSI_CCI_CONNECTOR() is a
7-bit field (0-127) that is used to index into the connector array in
ucsi_connector_change(). However, the array is only allocated for the
number of connectors reported by the device (typically 2-4 entries).

A malicious or malfunctioning device could report an out-of-range
connector number in the CCI, causing an out-of-bounds array access in
ucsi_connector_change().

Add a bounds check in ucsi_notify_common(), the central point where CCI
is parsed after arriving from hardware, so that bogus connector numbers
are rejected before they propagate further.

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
v5:
 - Fix format specifier: %u -> %lu for unsigned long (kernel test robot)
v4:
 - Moved bounds check to ucsi_notify_common(), the single point where
   CCI is parsed after read_cci(), so bogus connector numbers never
   propagate to ucsi_connector_change() (Greg KH)
 - Changed dev_warn to dev_err
v3:
 - Added changelog (Greg's bot)
v2:
 - Kept bounds check in ucsi_connector_change() rather than moving it
   to ucsi_notify_common() (Greg KH)

 drivers/usb/typec/ucsi/ucsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a7b388dc7fa0..b77910152399 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -42,8 +42,13 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 	if (cci & UCSI_CCI_BUSY)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+	if (UCSI_CCI_CONNECTOR(cci)) {
+		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
+			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+		else
+			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",
+				UCSI_CCI_CONNECTOR(cci));
+	}
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
 	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
-- 
2.43.0.windows.1



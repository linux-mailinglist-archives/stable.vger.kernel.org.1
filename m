Return-Path: <stable+bounces-238191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHZ0LN/f32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F884073B8
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673A33070AF4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD93134DCE3;
	Wed, 15 Apr 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXOn2vK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FD246BD5
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279331; cv=none; b=nS60auDwdqwUAIRp+5b0/NDVGA7lPVNCD7qXhbskxdwDmxKifm2fsRd1Oqivcq8Lq+dN/yyi4syHh+KJKGneZRTx/UR0tC2DmO6X84LdkHvT/rjhAOjMmFk/6jiLQZKsieVNvpwpRBWbYBvJDwvqJT9350fJSlldQBFHbfuHZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279331; c=relaxed/simple;
	bh=CRgVnOUGI0q7Ct790HwLPHGc1VsZ9A/1dQk17MZfoXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPopAHo/7ld7qBpKi1SkbL/hbK3OwpXKMEwNLBGkOrWJT399vjhF3wn9Au486fswXqCcc2Hgqkw8iGPXPci0aR9caqrc39kaO1BrDQa7k74yDEZvafYKY+WyvWroecjpP5Msl8cnIZkGllUNGqIyPZ/Lo9rYW62yroj0qL46Yso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXOn2vK5; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56eec951db1so2383175e0c.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279329; x=1776884129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDeo3f8CvooXNOU/9jKD56jXgK68+sHfUc7ysM/Ab5g=;
        b=DXOn2vK5mhgjLvKlobouyRIP+kyA0M5PGP3v+vYZjn9p9tL3n4ow0XQx8VQlGeC3/Q
         IelPzAA/tpbcPqjQWGIbK8GXgtnPMbLaomKqKwDqRG19dzg0ezYM5Xh0nDCfx+tIvceZ
         vLTdhkVK8abUJgutZ+wpiMQUjOAUZ/BcIEnPu7D6b21QJ3NiRbVHe/lGENV1dv0CFz8I
         34zpDZu1JC0nFTdQAk0CQ5T39r2LQP7mYRFXkwUu/Gst9GAnIi/AOWyIcAyU5MWZ80rM
         acGiSi7tU5g8sWF1FViTDIUjpxdBGQ9yNnEXYK4RwOontQPN4F7pywi4quWQ52UgHk+d
         aLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279329; x=1776884129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDeo3f8CvooXNOU/9jKD56jXgK68+sHfUc7ysM/Ab5g=;
        b=pczxUuGjvvIdld0g7EHsfiTii0atvGKqMJetMagYrJdVEUWmF6UQL7UqVM/UVOGQSW
         U5FUvgM+59DMUinLrYVcsF22V/n0NF695itPNUvGemmH1ULDfi+ZyXlVkasAHVOA0JYr
         GBGxTUkK7xTP6q/SkXfc0Azw395L+cfSywLLfCnTFwmXYNtySie93HGC7ENOHH7k0LON
         zGsYWNgjQ2HTm34cxSqEc/4RQPqqmtvdC9uwLMWArViDEz/LZcRf9e5Pffr5D6ag6NEM
         V/jgE6IJy1NNvJ5tbX1jluX0SSQps02RjxKWYTRHu5dSPrbZd8UBqi7YMet9tTQUQQsl
         UnDw==
X-Forwarded-Encrypted: i=1; AFNElJ8h7f7wBqMyONL0k6mh8CZB9BkqHO812bjVy6BbAsl3ua7xC00xDaY7mRrZdaQDIQOYqKeeFNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtysT9UAqXPjQBRgSR/rVvVwEP0oGr/M0/qnliGv/sp4lJwIrE
	jcAgYMufVRQLQprVuxzKjtKRTvt3kxdLrha0CYoTWfUqTcpZrfBeMdYe
X-Gm-Gg: AeBDieuNvK7WojPGoSMlpPxKrdd39vC3xTHKbYpLXj6zitY1J6/yDJVsS9J/P70b2NQ
	/upsb5r7WtS9FVwYAA/895JzVM+PLmeuW0aAg2aW/4DTYMIi8yWJz6ItpTnw6mOrigMf3ZlpGUI
	dA2zQ3VhaS9bTB9hTeAh6/l3BVVvXtZjJflx8mAURNjHRizNeckeORmt3zFDjW8+ycFM9415foh
	q+mbO4CI7ENC0FrojefA1Huyh/+yO7BA0AYQ4ySJlGivfXb2D5/0DSpv+9ehCCsVxeu+NMy1czV
	VS6WwRBOpTln66m8Wo7GzhQ9yD61nhnjKq5mLyVlWk9yFUQg6VyIkB3bOw0s6AUIGztFRmeH8AU
	tuualbIZinxIjH8a6xu3ag1NFfavif02hnLmOO8tBnPdBR3FpBrtHGzPS4HdGg7m6awYtZ91Kwl
	vV0nWYmIKc/KWiK7TzdCOCkK+vt9MX2PAfqjNt7AKV1YeiPs7AcbQR
X-Received: by 2002:a05:6122:1796:b0:56f:31e3:9445 with SMTP id 71dfb90a1353d-56f3b9e4996mr10565205e0c.0.1776279329111;
        Wed, 15 Apr 2026 11:55:29 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:28 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 0/5] staging: rtl8723bs: fix multiple security vulnerabilities
Date: Wed, 15 Apr 2026 19:54:56 +0100
Message-ID: <20260415185501.440492-1-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238191-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56F884073B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes five remotely-triggerable memory safety issues in
the rtl8723bs driver. All of them are reachable from the air by an
attacker within WiFi radio range, without authentication, via
crafted management or data frames:

  1. Heap buffer overflow in recvframe_defrag() when reassembling
     fragmented frames whose total payload exceeds the receive
     buffer capacity.
  2. Integer underflow in TKIP MIC verification when a frame is
     shorter than the sum of header, IV, ICV and MIC sizes.
  3. Out-of-bounds read in portctrl() when a non-EAPOL frame is
     shorter than the 802.11 header + IV + LLC + ether_type.
  4. Out-of-bounds reads in three IE walkers (rtw_get_wapi_ie(),
     rtw_get_sec_ie(), rtw_get_wps_ie()) due to missing validation
     of the TLV length byte.
  5. Integer underflow in rtw_wep_decrypt() when a WEP frame is
     shorter than the header + IV.

Each patch was found by code review and is not tested on hardware.

Changes since v3:
 - Patch 1/5 (recvframe_defrag): check the return values of
   recvframe_pull() and recvframe_pull_tail(); on failure those
   helpers revert their pointer updates and return NULL, so the
   subsequent rx_end - rx_tail bounds check must not run on stale
   pointers (Dan Carpenter).
 - Patch 1/5: drop the unnecessary (uint) cast in the bounds
   check (Dan Carpenter).
 - All patches: add Fixes: tag pointing at the driver import and
   add the stable backport tag, per Dan Carpenter's request.
 - Patches 2-5: carry Reviewed-by: Luka Gejak. Patch 1/5 lost
   Luka's tag because the code changed.

Changes since v2:
 - Sent as numbered series with cover letter.
 - Cc list regenerated from scripts/get_maintainer.pl.

Changes since v1:
 - Rebased on staging-next (v1 was based on v7.0-rc6 and did not
   apply).

Delene Tchio Romuald (5):
  staging: rtl8723bs: fix heap buffer overflow in recvframe_defrag()
  staging: rtl8723bs: fix integer underflow in TKIP MIC verification
  staging: rtl8723bs: fix out-of-bounds read in portctrl()
  staging: rtl8723bs: fix out-of-bounds reads in IE parsing functions
  staging: rtl8723bs: fix negative length in WEP decryption

 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 15 ++++-
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 55 ++++++++++++++-----
 drivers/staging/rtl8723bs/core/rtw_security.c |  6 ++
 3 files changed, 60 insertions(+), 16 deletions(-)


base-commit: bf9c95f3eeefb7fc4b4a6380cc23f1dca744e379
--
2.43.0



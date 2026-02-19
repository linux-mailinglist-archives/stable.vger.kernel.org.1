Return-Path: <stable+bounces-217333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEC0LghTlmmXdwIAu9opvQ
	(envelope-from <stable+bounces-217333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:02:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80415B101
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 01:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95409302334F
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 00:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78711758B;
	Thu, 19 Feb 2026 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvTdova4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E5C2FF
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771459333; cv=none; b=mRwoHSAIlpthh/w+rCZebxSV/HnJ7LYzFHUvtkuFjOejH0xyUd0ev73HbFohlM6tudMzh4TTLk9jYCi1GzmOZUJMOA0+NG5Inu3NyzfSP5luBAk16yrRF9aDLHMH4st9fbVJlMojIwjaOuPDGAOY9IkCt8bJkG4BB5nn0vSPm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771459333; c=relaxed/simple;
	bh=Wbl/dPkf7zltRU/iSKR4uCDvjP5h4Ahb4VKhh8gwK5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IxPMz4zjkmE57Xdu269BWJKmQMymXQd92+kdji5ihOPYyF8Rmo/m/9zeqyCB5/Sw2kxYJPNlvI9GJwZGb4UBnFI9lqyU3cgYmIGJMFd/a3Taj0aaI53qGDiRx9ZxYz7H05h62hg+Ao1USKDX8Rm4Ut0xS2ZD1vBZvpw/t6uMhxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvTdova4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371119eacso3503235e9.2
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 16:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771459331; x=1772064131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S8E+BXCV8EBtKlA1y+aZMc2zEzyG2Wkm5hVPzVUHo2U=;
        b=SvTdova4uXblMcTZQo1zA4cpgeKW2u6F8gFKLTcCet6WEY8bTRRI4d298s/FiAQ08J
         S7RuCrXcZfH4rHgYJmZpcI/6MsQl/5RQeibPCgbdUwBopRsShJNbIe4erObOezPQ+YfP
         nX9tFSi5wfF3iY6StLE7tvoAheX6HVhRCmAQbV0mmDZ1Dp5bVekHUZ91breohLeRgch1
         rg2vXn9pLrZLwzn+zrEyjLRQTJimDq0r7fK4Ei6PRIZAyC3k4OSOQhEqiFms7eeVw5Vg
         O4RTbEdqYWSQgck73qxqlPKPEzvpf4Hul6BsYEI6zwLYkUe+bHakAgNBqhEKMtv7FuQt
         Q2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771459331; x=1772064131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8E+BXCV8EBtKlA1y+aZMc2zEzyG2Wkm5hVPzVUHo2U=;
        b=n7Puuaer3Hs9+azNnjz3NZtxVxNawp6u/h5h5tdIuGwyRT2ZIJCzCGCvqXMIDxI1kM
         /JG7LEosxSBcGPdq9SJPDxpYIUO2i5MbQPRugrZQOmPgPGv7iZf4pkThEKX8PK6S/auc
         /aKqr8QuPYPxjR+AfbYj2Fclm0YeEeevh7q+mhMV6avJCMtud5Ys+iV45tZ9BrYYk052
         gRDbG8hZ3jJ7chlEVOKnacZE8hgMa5uJPTkwwrTjJcf+A/MdAY0LcW6St5RaJRbTE0VI
         ubLteWOHrW/aKpi3taTpjfIZL/GBCLscIsPLk0jmD+3Rq+etvaq6v7GFriEluXs05cH6
         WaCw==
X-Forwarded-Encrypted: i=1; AJvYcCXe7CEyZnbd9D+cDWuBkTmgW2NL3uhW6r1xzkt9YfGwvN1kmL5MdKGghmTBF5Fv8Yydc6NBh1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rc4k8XaRolT5Xg6p0QUWpXzqdweFYnWo+DuI0yUJzzI9CRJE
	owCw2sEoHmhq+8iZMp2cPJKirMJN2982ouUFirtO24eFAjihdOQe/Szz
X-Gm-Gg: AZuq6aKF4fFU/eqbNb2kggMh5i0u6pwPwDAYn3OXgAau6FfmgRw+Kfegdc74OKDbby0
	TJ+iQvTt0JqDd5Wz0/WTRtjIvHmdTuPNCsOi1vVIHR0+CNmDxi3nxHN66QaDZAmsyPYMQIymtq7
	ltqbmQR8cI2jjcZQHOimC33ePlN0BctF6IbKeRx9xL21hpfpdRbCd8cZq+8pBZY1LJTQW61/GZJ
	vfqDzFR1M0etNLLpU0wqQP/BcMFUN90ZXJS6Y/U8T7CkgNofN6PBXh/de5uktoeH8r15CfCI2a7
	BDJPS/BHkys3z5tEHfV2nY4WAIS/OmV6bUQm+wIMZ+Md/qmCUcylMZ6UTv/26LaVelitqBnlkux
	X6cdr4nA8yE5mQ5p/2OTEzmfWujZ9jxxN6tdSRUL5GOuUaEkbKnKG35MXPK+vPJNyU+J6aZU8yQ
	USKN5xcc2S7WEljQQdcrGXYsPtjSgdAHcYjkr+3jKx8GE5/wxkViy2+gjMCmjQl8SIOEuB32yjd
	8GDN8zEZti9tY0FB33jKz8ANkGDREIRkKxtW4sRhVbh9PnIOwGf/qqGZlZ8dxA8lAAH4ofXJKsx
	CP8Bn8wb
X-Received: by 2002:a05:600c:83cf:b0:483:71f7:2767 with SMTP id 5b1f17b1804b1-48398a7dd18mr63602975e9.11.1771459330366;
        Wed, 18 Feb 2026 16:02:10 -0800 (PST)
Received: from capaj-ryzen-7-9900x (185-219-167-224-static.vivo.cz. [185.219.167.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm712029075e9.3.2026.02.18.16.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 16:02:10 -0800 (PST)
From: Jiri Spac <capajj@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	stable@vger.kernel.org,
	=?UTF-8?q?Ji=C5=99=C3=AD=20=C5=A0p=C3=A1c?= <capajj@gmail.com>
Subject: [PATCH] drm/amdgpu: disable pipe1 for Navy Flounder (GC 10.3.2) to fix ring timeouts
Date: Thu, 19 Feb 2026 01:01:46 +0100
Message-ID: <20260219000146.21818-1-capajj@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-217333-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capajj@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 1D80415B101
X-Rspamd-Action: no action

From: Jiří Špác <capajj@gmail.com>

Navy Flounder (Navi22, RX 6700/6700 XT, GC IP 10.3.2) suffers repeated
gfx_0.1.0 ring timeouts when multiple applications request high-priority
Vulkan GPU contexts simultaneously (e.g. VS Code + Brave browser, both
Electron/Chromium-based).

On GC 10.3.x hardware, high-priority contexts are routed to the pipe1
hardware queue (gfx_0.1.0). When multiple processes compete on this
single queue the Command Processor hangs, and ring reset fails:

  amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 timeout, signaled seq=107039, emitted seq=107040
  amdgpu 0000:03:00.0: amdgpu: Ring gfx_0.1.0 reset failed

The seq delta of 1 is consistent with a single job submitted to pipe1
that never completes due to a preemption/scheduling deadlock. Once reset
fails the display manager crashes and the login screen appears.

Fix this by setting num_pipe_per_me = 1 for GC 10.3.2, disabling pipe1.
All other queue parameters are kept identical to the rest of GC 10.3.x.

Reported-by: Jiří Špác <capajj@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4985
Fixes: 3b094d4df4b0 ("drm/amd/amdgpu: add pipe1 hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiří Špác <capajj@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb..a44103622 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4773,7 +4773,6 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	case IP_VERSION(10, 3, 0):
-	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
@@ -4787,6 +4786,22 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
 		break;
+	case IP_VERSION(10, 3, 2):
+		/*
+		 * Navy Flounder (Navi22): enabling pipe1 (gfx_0.1.0) causes
+		 * GFX ring timeouts under concurrent high-priority Vulkan
+		 * workloads (e.g. multiple Electron/Chromium apps). The
+		 * high-priority contexts routed to pipe1 contend on a single
+		 * hardware queue, the CP hangs, and ring reset fails, crashing
+		 * the display manager. Disable pipe1 to avoid this.
+		 */
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 2;
+		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 4;
+		break;
 	default:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
-- 
2.51.0



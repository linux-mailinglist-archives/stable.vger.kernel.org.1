Return-Path: <stable+bounces-217617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULQjBRwqmWk6RQMAu9opvQ
	(envelope-from <stable+bounces-217617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:44:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B382E16C0F0
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 339EC303A8C2
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371F2E8B83;
	Sat, 21 Feb 2026 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIO+IUr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B92C0F8C
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 03:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645462; cv=none; b=WJTY1su/9XQTLn/QeKz+BYLyzdoQhRyvhM5YTQYCdjvIycf0XHKCB65+QiOl0h7kbxyMQP+S2ZAJ/OIeNTceM06whMrjwgbn8WYDOmJYqN38Mpxa5DY+j7NC4B7OBSTva8vLTRTh2vHeFVAKBvfJgfBSvGaOgUBomq5GkzeJOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645462; c=relaxed/simple;
	bh=yfUUIsYErtPOr1ae0rOGUrT8/YffgDE9U2Xx79AlNe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ECuHrwoUpxGdECtrErVIOiO2gSQzOofFE7USzA20Xb6QfV2GY6pKTvKMNNK1MSjquNyLTwAVCaDasrCgIjM8nXicSyhbP6QnXXslNdLjRU+feGkdxGAzpd33wVHZRePfhk3OjA3bcfk1KB4jDNpMZ89RWthlQIzHycx2N1C7a84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIO+IUr4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8249cb73792so2442820b3a.3
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771645461; x=1772250261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2lZPUnhsjUnXBJgHs4dvnaHovSRN+TSfVBm8NcKAvE=;
        b=CIO+IUr4kWk4ehkbnRbHbSfVmVRLthhKGO9Yg83zr/7KPLCDlfUOMc1rf7xC3IkDGD
         r5a3AN/sZRpHCf37ZrSHZml+JtWAoYk9vi86cruJfRO85GGZ+dL8NQ0gEuYdqy4bNUVG
         /SzT4mcqBeAoqWmg9E83PIglZ2SAmsWFUwvkFvwejTn1ja0C5egC6y31Wz8yALS10cSd
         NSTrt0Ws003LScuBEyAiTyZoB/AP4heua18qUmLgJPuVZsF0aKae44bhP2WDc9QLddO3
         qOzoMT52FVKtXTmUzy38qMYLYbdGLzHYMPprzMfhN3xvX0XL/g4W+pL6hDW+2G8/06jR
         paeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771645461; x=1772250261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2lZPUnhsjUnXBJgHs4dvnaHovSRN+TSfVBm8NcKAvE=;
        b=BRgXsaWWW76hSYpyxOof3Hqxj+1WtBqizgmdJbNxKJHndi+FfFu3xxQlNHERHqM3wB
         d5X6iO8qEqIfL6dyDXzTJaDs8IFKbiCMit2T6NpNwebh3CYNQscHt/4hfijCo04UBTPi
         7USGTEfYOWT+/t/he3pfd56o/JUcsHcex0vkl/+2p6NoZH0i2/9+KUhIkzMyvNThHJBE
         l3AVSC1xJnrUXRpw7pjcu935SIX2p/LmJNw3oE3jVlCQpRUFNb9byoOprLE+PZ7jIA7C
         do3GD5zGnbI3Ah/AwsjKWVVbWC83mAUAZPai6mMnSvptmqQA3cgAOH5glUrcipcc20aC
         Jbjg==
X-Gm-Message-State: AOJu0YxzDZMGVQlAZXg0Clz8vKYfKZtdKfY+4LTQXal+TjSUmLckBUBn
	hoIsBa51xCR3R2iIubRtLHlWQ8OQb+znEYdAm3Eu+5vv9ih8kTUDU8rwZeTD6K4/
X-Gm-Gg: AZuq6aL/GNlWDx5VHjP5vcNMKQzIAXA2V9ZesodXzDuunHqrf6kYFYfOZB+PWzvHHxQ
	tS8D66lngdJE/tMCXG+lXe3t1hiPja+urI8jqrFi7tDfxPK2+cYqGp29ONiwaChSYGc6zzZSScJ
	khIB+tqLCCQO2Y7KviE1/W1TXNBV3VWCwOj79p2WJPx87RpDbK3Y+dVaSYIkTq91ah2GI0QUlRJ
	9gxEsmeBvjMH2LTIwtRu2qye1afOVm8lBMGTs+/SRAboJ0bmA3J95uSN+5ust4R8f/+rnVrDzJ6
	DRaGd0kA1MtXAjbNYUrlvbX/6rJ+5+6YPFRqy0w2MlW87XWz8Ljg3WHp01cZ4v+KmICbtHU2WUF
	aAnQM58LsugIk5L9iISbmy29Iu/hOVPtTG+KiRHyzLqSLMgdjEXEcL10HOFQMj0yfsTM9
X-Received: by 2002:a05:6a00:4c19:b0:824:374a:13f6 with SMTP id d2e1a72fcca58-826daa0424amr1768522b3a.31.1771645460652;
        Fri, 20 Feb 2026 19:44:20 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm714951b3a.50.2026.02.20.19.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:44:20 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:AMD POWERPLAY AND SWSMU),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/2] 6.12 and below: amdgpu: fix panic with SI and DC
Date: Fri, 20 Feb 2026 19:44:00 -0800
Message-ID: <20260221034402.69537-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217617-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B382E16C0F0
X-Rspamd-Action: no action

The first commit is needed for the second one to be reverted cleanly.

The second breaks DC support on my AMD 7750. Kernel panics and I get a
black screen on boot. With these two reverted, 6.12 is usable again.

Tried to git cherry-pick the fixes but that proved to be difficult to
do cleanly.

I see 6.6 also has these two commits.

Not sure what the proper procedure is to request reverts on stable
kernels.

Rosen Penev (2):
  Revert "drm/amd/pm: Disable MCLK switching on SI at high pixel clocks"
  Revert "drm/amd/pm: Disable SCLK switching on Oland with high pixel
    clocks (v3)"

 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 36 ----------------------
 1 file changed, 36 deletions(-)

--
2.53.0



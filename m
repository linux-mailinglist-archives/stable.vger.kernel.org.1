Return-Path: <stable+bounces-217529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPXIF7HWl2k99QIAu9opvQ
	(envelope-from <stable+bounces-217529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D316469A
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0F6D3032070
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F862DCC13;
	Fri, 20 Feb 2026 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZvGhKYG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF922DB78E
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558556; cv=none; b=cqJH6EUUB1vNIXMWS44fkIWEQQY7bv4AxMWuMKUBlAx2+0dgRQv7/14dO4d2pKB0h9H0gHCGgdx56nNSv+E9LECIBGAwPNx1tDthJCovoEionutUCQlDIu3LcWsbCb/qbkXCx0jGOpGLSoqMpdBf+X+VZTlbmBjsBrhGGtL0HME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558556; c=relaxed/simple;
	bh=u7qtzELmU0xOUlRYfq6pmRVDkEceHJiG781cdFj6Mmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBxULmhkNuqbqqoahL/XlagMw3UBEUzHlGEKkbIY40DDJBNkujvn0eVHM9TH0jqyPTuniDvX9wbKstBE4E8leF0iM3PV/aZ39yQ+HTRfxK3+sODv3LwIBc/KJtbxLfBanu9akkYRZjbJ0OHOtRZLtlV0EnfvMn1JFLdV7hFRbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZvGhKYG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaf9191da3so10144095ad.2
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 19:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771558555; x=1772163355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9RtH3VDdHvCGowWw21cotg2dMzVihzJvU6s07yH8n4=;
        b=fZvGhKYGSnES7v0nmEJblKj17+c7Z5b44xuBiUQ8cB/SHTl+jw0bOHH7FytkKv/ACY
         NZ7XIHEchhpzMlGFMWViLpV5ddi8ZvTdtOrvnZ8gWBjRuBksiXmBrc+gvVBmtKZXMSjG
         tLJaRTJ2xmUHkY+wJELoG7h/bMcK4dzYCSLNebBagORXTmtDGX1x9kgRoOvtUaSM18AI
         zK7wu71/mOWi0wGQY8AYS9fkpXIohvOr9ugqCC46FARpJJR2JL4P5JqDO5rKtzgpaQee
         HLaj6L7yL8yT67eTCdZr20gYh1IkVCN7lpDvoj8jCIlN55jj6ohqrI7GPdffLhEr4AXR
         WH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558555; x=1772163355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9RtH3VDdHvCGowWw21cotg2dMzVihzJvU6s07yH8n4=;
        b=O8q48sf0TqEOQjrQQ/xwnd6d3rZd7CpJdXmB3JA0k4vuJ/R2V1w1yvpRSgmndm2UrL
         Ak5fM6tRvNhRiik5jmQzuvLRXcXo4OIkYzHsNSfIQnWq1XAHCqL03GCsUfiuSS/7wOsj
         qveSWlxWCacF5iRB+2aTWC6FgGnmYt0HwGck1/vr4hUBMMIoUnfloqEk6YT/MX9DT12v
         MbhXwhuWPm3XFOzx1MCoONi5giKdpCCXCPfzJ6gyoMxFU+xet0YttReouufgC61EGcoA
         OnOqwwd1RZK/wtdd5M+ELCU7t7CoSnQKqCS+RXi3ndG95NFnHQFuYF87Vx3H4JmfjKpn
         UoZA==
X-Gm-Message-State: AOJu0Yy1trLDTMr6iMel4FP/Wzp6Aj79irOchP2hkeCa/LFNgXRC47p+
	IfGBMdqOrOxO8CDPMg3NIDep+GgiP7+2LdLr60RLzpYmLUXL2hKvOrG4/nGHPUbn
X-Gm-Gg: AZuq6aL1KpRw5v+VBBRbfMbd8rkmzrxtS06bNLhm/SZ/gKon1siOIq4u5N2aSpn4Uz3
	g4acerDlT3ysjnjXPs170tIOVHU6Xj412bgvdQ0uICziq4ZiO2mULobJeckfG0WDgFNjG+4Eu+R
	eyUszRzuUNINuFY2CWrHcq0+GpWLlCsIgBMX4azb8D8hhtwsdTcKdqxg+RMC/vgNHh3ORwY8hjB
	LMyKGKIcwzJ5CbJJuh/R/ai8bFFFlbLByVsC5LB+uXdpec5JQHUQAPROhO+pLnukQjj2rl66Q/d
	QFTwMCvj1//SA0vb/Dpe2FW4+pHjYsJ6Qpi8Z6rejYnE1B0k1rtceW9LStVi/yqx0whzcH6oHwV
	7VZtnMS560d7bBX73O9CV27Ql6KsXkGxKQ7cP3VTJPXbxxgvekBPy1Ixd+t3HaNkHR5giRhQGTF
	6UdZOn7axOS+wr00F8QZwaUVR1m5R+aAW7up7YMuQyL2thbS65hzNtaDqOG9WH
X-Received: by 2002:a17:903:2a8f:b0:2aa:e285:f249 with SMTP id d9443c01a7336-2ad50e757a5mr67786975ad.1.1771558554897;
        Thu, 19 Feb 2026 19:35:54 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5cf8sm177143675ad.52.2026.02.19.19.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:35:54 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.19.y 6.18.y 0/2] drm/exynos: vidi: fix various memory corruption bugs
Date: Fri, 20 Feb 2026 12:35:48 +0900
Message-Id: <20260220033550.124346-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217529-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B36D316469A
X-Rspamd-Action: no action

This backport patch should have been backported along with commit 52b330799e2d
("drm/exynos: vidi: use ctx->lock to protect struct vidi_context member
variables related to memory alloc/free"), but was written separately because
some commits were missing.

https://lore.kernel.org/all/20260119082553.195181-1-aha310510@gmail.com/

After this patch is backported, we plan to write additional patches to
backport to the remaining longterm kernels.

Jeongjun Park (2):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 36 +++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)


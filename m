Return-Path: <stable+bounces-217618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORTKjAqmWk6RQMAu9opvQ
	(envelope-from <stable+bounces-217618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:44:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29316C109
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041DE30602E2
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1232693D;
	Sat, 21 Feb 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhSk7UMk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29489313545
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 03:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645464; cv=none; b=Bv5XT3PDS7/PUhOzt7/BUU5bnMiAvHBYv1ZCNWbe2aGJ3TBfJI+7lAPzdSMG+0MKM7vC3byYXJ5DAulClq647YtbOq0D6kfjofSEeu8pJP36X+kyjtQmqjfyBBsexgXu7fcddX+byTL4cAMeJg9WnKO6rEvvdv//QNe4ms0KCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645464; c=relaxed/simple;
	bh=cRJ21TAOaUNrKCuhjjSTfURKHg3z8sy6l5ntWsy8ogY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqIo6PlYPF1FB3dYCMSa93/XAAzKnrQazuUcXukaEX0ge3ejnOKPZiegcWUiGIdqjySJT8vLC8Kc2oaa7edM6LzlI+uuAKixMa5yjHAzklzsyl6NB6LD5hJvPx81s50PyGsBt0iWJwBlXleVzJ1l43LopjXhy2XQdpHDMHKLTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhSk7UMk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-826c49b7628so1239913b3a.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 19:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771645462; x=1772250262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJmFbB3FwMiKYWU/wDkbhYitxVoyIrAuDm/JRU1AydA=;
        b=PhSk7UMkiu7I8PueyUKLo9gJugomXpMz95e8UxBaQX1qC/UaxxSkbbSnxWzFbw7aOj
         PY5gwjpoS33jbHUodiQRyq/E6wZAQnRPLop8kRLWDyZOOpJtCLhnqbMO16VGhXbCxp/P
         5O2fVcJF5J6e8qVadllzRzmPeRsJ8cUM7iiK49+vY/ngkDLcZQZyed8R59ja4Ykl5eOT
         xg+QRbVHoDhOdiB/YYUuDPlPUTYLV+j2gbnwmA+n0iEUQh8tmteZ3PP393zede4QyVUi
         JmQwg2D9eaBQso2yYhjMwjRhclI4vgkQGOw9Fwy/Ghl4Km0H4P7UJl53IJGSvmYFFCDE
         2yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771645462; x=1772250262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJmFbB3FwMiKYWU/wDkbhYitxVoyIrAuDm/JRU1AydA=;
        b=NTw+TTPOGO3ZL2wxjWUbwmud2ItgOrmNB0KqNLqzrHwJlcYS+vXM2yrhppN4yWK2is
         JjMVF5bSJTgd258yYkQa9+BExzZM/SEjZer/DSgGJWKHHCkXse3ysTH+H5QDGzIh7lN7
         KvFGzdiVeW+gKi7QYIFWLoHbDLSmJUbUkEfOlxOZIbSRPWhunSJWFIo60uMIdY2xQQzO
         kfbv2bHLco5KlNwsNxWCRAdII6+hpZ16ofQii39FIVIDq8qYZd9UXohoYnYfDlWpwc3m
         vRyvzMu+nVNuWa7EnnZi/GwmuC1ZOGuBzyKg5C+f0Mw3qec8sTJMnUX611cwTcrtQoAt
         RyaQ==
X-Gm-Message-State: AOJu0Yxo7y9HC+i29FPAWRWHcU44wc36lwNN1qx5V1HwFqQLPLS0GU66
	3dfvao+WDZNJbfV2p6wZsA+5W7NSDQGYvmSMiqGGuBcGe1rFMwZkInqDlJXvIe8f
X-Gm-Gg: AZuq6aLqOZ17IE0ANArXUcg6Y4fLWFiulI1OXkBj9fUrDBm1XKfeOp/ULgS/dZ4gHiV
	1BWgGCeXOmOxCfnmJDwWk4J6Tdgx/x2XJIj37HWpee5Pxs/J34GQSjLmYftwFIcp4UtaD1SpH/H
	DdwW6HB+Hd0ms7DfnzQDY3nEjUFIVTgvOWm2CRjas9hl83VnQPpLJrZrJfiWMxi9v/jc+JvccZu
	KWCapVmcHYRDW4ReY5bPhFI9zcpvLL+5K99oEWEpfoQCdGWUXbOPXPOA+LaDST9dFXu1dDsPlJM
	7pl4qe19Uu6z5ndAVXYX9oM/BuCAP9z4XGaRG8jMCPRB0DQumZDXmh7ouNVp6PWePjctNP1HLNQ
	dDmYXGj1aSowYpH89wM8tYDR2K4Lfs2UY47cuOXZprjzmaeFPFSMorLLG1K7VpuoDTHJb
X-Received: by 2002:a05:6a00:430c:b0:822:682d:2c5f with SMTP id d2e1a72fcca58-826da948eddmr1927546b3a.28.1771645462263;
        Fri, 20 Feb 2026 19:44:22 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm714951b3a.50.2026.02.20.19.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:44:21 -0800 (PST)
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
Subject: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at high pixel clocks"
Date: Fri, 20 Feb 2026 19:44:01 -0800
Message-ID: <20260221034402.69537-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221034402.69537-1-rosenp@gmail.com>
References: <20260221034402.69537-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-217618-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3F29316C109
X-Rspamd-Action: no action

This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.

Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 29cecfab0704..05eaa06dfa34 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3486,11 +3486,6 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	 * for these GPUs to calculate bandwidth requirements.
 	 */
 	if (high_pixelclock_count) {
-		/* Work around flickering lines at the bottom edge
-		 * of the screen when using a single 4K 60Hz monitor.
-		 */
-		disable_mclk_switching = true;
-
 		/* On Oland, we observe some flickering when two 4K 60Hz
 		 * displays are connected, possibly because voltage is too low.
 		 * Raise the voltage by requiring a higher SCLK.
-- 
2.53.0



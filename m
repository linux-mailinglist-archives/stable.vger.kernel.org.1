Return-Path: <stable+bounces-253976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PKhOpQXEmo+vAYAu9opvQ
	(envelope-from <stable+bounces-253976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2805C0CCC
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 23:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D615330065D3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9312EDD58;
	Sat, 23 May 2026 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUyjo+eM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4C63B9
	for <stable@vger.kernel.org>; Sat, 23 May 2026 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779570578; cv=none; b=Nq5GYrGhnpO+oD035gPgfSzmKYrlu40MAbRfl8yB7I0Kqz58quO/bdWdUWA9K7CVOz2PMKQT9CT91H+cxDtWxs8mCeIE7hz8t89PK7L7zv1d2LlT08qw4qJJ4JceXJGvPP6Ei1CrES2RSq33WgrtEsj9pOBknmSZSdWuXrNS2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779570578; c=relaxed/simple;
	bh=oHGjU5VtT4Nj+CBqr98cWbGax9+xfd2+ZbclZmJ2Mcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMFjalYoD/o1IYFivuzsTbAVOTCet/rVRqWOuhKZRyXGXd5/wtD6EDiMOTYcxMVY87lp9koByx7Im+Gy/Nm/KjFZC2pz31SjbyceKUjvjTxpQW0dNHa5h5GEIBnAtUQy3VrC/Xa9yQFYvPGO0kqbspG4LSK/6ypIpBogvU2gPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUyjo+eM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-835b78c3797so3714356b3a.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779570576; x=1780175376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m75pjVJH9fVWqs1GIsLd17VZCLb6FKMxe/bCaTR72AE=;
        b=mUyjo+eMK96GNqUxTYUzivC6+za2Dd54zXz/zSoA5B6hA6y2DfdCqV31+ZpYZLOfCc
         KqgIigz787tnD4hjSZ3JAIddwTqJhb/352gS9po/MtpLcEUBDy0a3+dV41Egyk7P+Yy3
         i0Hatd+BFayL2LZ+9RzvrYwxWEKlY2GfEGTaj+QYZUnN5w87nG5dy/tEA1UFqNrjc/NM
         xbmftJOHFy8eFrVkck0+38L585V4xmu0f0BkxJRAn3gvYXabpmuVLCa6f356vF8e4b3m
         ouL3GR3HI8mHlfvoNz5GmogcV1gZCKORot0oZ1ts7enh85dwNXzg1hor2x4pjz8QCok2
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779570576; x=1780175376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m75pjVJH9fVWqs1GIsLd17VZCLb6FKMxe/bCaTR72AE=;
        b=n37Q0Hx/5IiOmNObFf50FydG1aTCK3W3i+9RdO8OD4iwLSkIH0Y7nEhl9grCWUK64V
         u5tQcVGhfu7RLbyxm7xewgBZnLpEo6/63v+LS4OjE6IUAnR4eFyZJUI3H6kR9nJ3XiY+
         kB3+Rd66387xpecIhw9Wk3G/wo0ucDpZIT31e8RMmVRL8i4XAAOyZVvvxvo4y9+sKJjC
         FLs3TDIUeF9PYWlV8G/c3yvtY+70MfabrrCF7nKyuCwKH2q1QkEyRcxdImC+62dLrm04
         dZLN0c0aVmCxAK7EEhiNOC+rggpX4KSqDC//F4pMeHQFZDZSyrFkU9rEuKoTGkuXBfTI
         uX4g==
X-Forwarded-Encrypted: i=1; AFNElJ9G3J6SPxePXfqndQfxAdtALpEGxeD8F/Lq+M42taoYh8hZFr9EO0FCzfP3eN7rQl2GA9bNRwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVe/zwuBheSa0cKJqFNGY18ATbYI40k4psTrW9HKZPdfZ7wycR
	nFoeGmnCbZxA7l8sTsyf+2/JioiMDEYQ4ISbzOZu0loXmxURlJgJ7izf
X-Gm-Gg: Acq92OEJh2mr1aBRpZwK2+1ADUDryWE+9zTSbLHg8QTmfADHlhz3Sj10axp397knOPZ
	k6HjgwATdUoyOgTYNHsnpOEi287SjfAhiEncCYSDdN5cuzZ5/iYDb7tnVnORDBIzjA+wUFndtY6
	FHkFOzTPePc8m6m0Efgw+2sfQ6U3GJqc32DY2JHHjLbsIizdiRVHYufsTODs9A8DcxsSVRm3N8x
	6Dr85A/ztjF8pNijMwGhm27U2uWmOskRg6py0Seua+CHkLSHigs7v/+wpL7oCvDR4wEqtBxFcf0
	GvqoS8MolTPdQj0UaaFFF44T4Pw+11gr4pcELmV90ZmwHtqcezndS6OVwhWl0to6w9lILRuwWT1
	aAF9SPvnRmX9OQC+Sevy0sbgnlH69KiUvMtLiH9AmO0i/FEQDNZg+v/cStgvGda8qB/Q5xGaSjW
	hNreSINfdiSLyRNzKRDNpG8drD2Qt3Fa1QxzZYgL7LhfbgT16y7h3XqMI8rBzgHLDkYIXu7hgLR
	vjYFfGfBeO9pG7TYexEKeZaZoQP0Ag8rSIt2nVKhpJat9pEZjq1p867FOPCikpXW7IFlNSR3MjJ
	rH74NjaY6bE=
X-Received: by 2002:a05:6a00:348a:b0:837:e9cc:d460 with SMTP id d2e1a72fcca58-8415f15b4dcmr8301554b3a.18.1779570576015;
        Sat, 23 May 2026 14:09:36 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc646bsm5406884b3a.46.2026.05.23.14.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 14:09:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 2/2] accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85
Date: Sat, 23 May 2026 21:07:53 +0000
Message-ID: <20260523210840.92039-3-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523210840.92039-1-meatuni001@gmail.com>
References: <20260523210840.92039-1-meatuni001@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253976-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B2805C0CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On non-U65 hardware (e.g. U85), opcode 0x4093 is NPU_SET_WEIGHT2_LENGTH.
The BASE handler for the same opcode correctly assigns to
st.weight[2].base, but the LENGTH handler mistakenly assigns cmds[1]
to st.weight[1].length instead of st.weight[2].length.

This leaves weight[2].length at its initialised sentinel value of
0xffffffff and corrupts weight[1].length with the user-supplied value,
breaking the software bounds-check state for both weight buffers on U85.

Fix the index to match the BASE handler.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 043541407a8f..5a02285a4986 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -600,7 +600,7 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 			if (ethosu_is_u65(edev))
 				st.scale[1].length = cmds[1];
 			else
-				st.weight[1].length = cmds[1];
+				st.weight[2].length = cmds[1];
 			break;
 		case NPU_SET_WEIGHT3_BASE:
 			st.weight[3].base = addr;
-- 
2.53.0



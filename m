Return-Path: <stable+bounces-227654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GyZE7MqvmlkIAMAu9opvQ
	(envelope-from <stable+bounces-227654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:20:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FA2E3590
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5108E3005AA2
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376E2EBBAF;
	Sat, 21 Mar 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgnQn96e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D532E0901
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070449; cv=none; b=H7iVL2NK6y3qnDMUO8jlB0naiXB/O+waXe4Hvns/j9Pu76YJ/QDR1In/oZqGEEL488xdAjEq60ScfiZU4grLtQ5NxXHaYKwTNcMmqQZGyyIxjC+NSkayWvO9IVubtFEc52UHAfUMAI7lifgms3YbLMj5rVix8Np/HRB4e/L3cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070449; c=relaxed/simple;
	bh=0HlEjlh9o1lgGMMom2cutQKWfoE7OmxJMcZAedt8JfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MxoZG60mGl9+aQHP05A8UHYSXk4YvAwAl4Ac6KsMTYMtMtN6OR5aQFMNKmTCvuhQUXLm47DzbdiVU6Dana0wURLmubmhFLfDvNxYKEXlDFdXnMNSNIzCd1jVyuqEYA9/jqrJYVd7lFhctkFzI3hxsnfm7eBgOUI8YjIxbZJbPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgnQn96e; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486b96760easo28702035e9.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070446; x=1774675246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EKq1vLfgwYt/zYwN9FJYIigJVZ+pwHlskrnj75NFik=;
        b=EgnQn96eOOylYH42hNztxrVwvanZeOpuw6n/cVVZ5AWWgIl9JLCHtPwRmRhrqAIFBv
         Fo1oviwdLvgg2hGDB4rjmtgN0ypX15sNketrseJUlbe9fZUBgog1z5Po6GeMRaQCiDai
         78dHIgUsEFvXVbMPg0v2ACd61Yy8oUjtbCcKmuv2GdN5MOdW1FP2bbx1SQRNn0i9lH6Z
         oIn5iXqmvwjNUAoi2dMt7IezyYMfK9ZF9kNL/p6RRPmYft7R7srFV0PGjq+nVZgSPBx6
         iWikD1/7MgJHbWyb2iLO7rsUZjpEQ3bwS8CIoD1cnHUQ2W15HuA46bYSqKu6oJupg/Bf
         TceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070446; x=1774675246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EKq1vLfgwYt/zYwN9FJYIigJVZ+pwHlskrnj75NFik=;
        b=pVDSMLlZ3Qa6RKry+7NyngbN6juj88j/BsCHLNOfLITy2AcoXVSoosrGoWqqS0G4hg
         s/KzId1Eu+EHFjdi61YYE7DuFLlJjpPrvyTxtafSneaTH3GuVaZyTVoknd0XTixvnE2K
         asKg+T7lJdz8WI+joIaxWcAl8x4JS91NMvleuFaPu+D7mFwY2WBXvm+jUT5tOmql72v8
         KKdKaBVcNoFM8r4w+WeqT6U5j2PovWUD/yyOifNEyOusNDQTQcIC+7E4yAsQ/Q1w1JeI
         weakLp/hGEX47y7z1AB02gmVtJWh7Rwms/Sn3uqlipW/hlVmmnXpEFcm4xoafAMKgzjT
         e1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1pyBvpgdBABez3NXIAusE/xCYvYBajukViI5zJbkRrVH7aC/TySLQ1Tuc34P9UFU9E635hlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXx7z8RH7oZZNgINyq9dX478P0obeQp+ttR4U2AwnQ2Fd1ZIJS
	H1nOgrUxifCmwxBnaxx1rwRpnl9Pz39iZll/9VN+ciob/J5yZCaAiOVd
X-Gm-Gg: ATEYQzyn/CTtmBYk85n9c2gD+zizr/EWs0fr3tjTbu33j4bbdufw7ep2S+YyRWVMJ0w
	vyrHC1/qNRX11aXMgNaA1OTLE2CxmZTxNwIDNbdiB05TUIpKKedkJx5DzaEeevwED5EU2vW8az4
	qgFg0Hfa8b8Z/jJg+/yiDYz4EI0y8K1qFKZ3/+QAvNef+qxPy8o7hc9g86r0E7OJsdV/u6Kn967
	DgXVitBPEn71RjH42HkdAFZ+nC8EQd2JuYV0QFi3Q2yB8mteZK5cysqpTC05a3IYOCT49tpr4F9
	4gVfKF1YSnpUkVKWtE4Lg06OzSWvLxUiRgGaY5nGoEJ5Tfdtlwy60pJiKn+fYN5iitsAyIHymGX
	eIacwsJvMfHe+PIjygGNTDrBG7twL+9qzJGjb293R5OWO5AfstL+OHSvNVEFvD20Rdl0tdNk73Y
	vw/B+cIQh51AjJztjJE9wp1MIvSVngUg4rOxhVpx24S05j944ypLC4mJP8aa5vzSkKdLR4vxoQF
	nNpkgN/uSTqsMGPLEjab34w9PeFj6/wii5/zvElhc9+pJ2s5a/vHmeX5pmzytzpDGfL
X-Received: by 2002:a05:600c:3b07:b0:485:5ba3:37d8 with SMTP id 5b1f17b1804b1-486fedab1e5mr73958065e9.5.1774070445643;
        Fri, 20 Mar 2026 22:20:45 -0700 (PDT)
Received: from groovy.localdomain (dynamic-2a02-3100-5a1e-5a00-2fe0-b647-7443-5e95.310.pool.telefonica.de. [2a02:3100:5a1e:5a00:2fe0:b647:7443:5e95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe032a55sm208361275e9.7.2026.03.20.22.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:20:45 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	mario.kleiner.de@gmail.com,
	stable@vger.kernel.org,
	Aric Cyr <aric.cyr@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Krunoslav Kovac <krunoslav.kovac@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Change dither policy for 10 bpc output back to dithering
Date: Sat, 21 Mar 2026 06:20:33 +0100
Message-ID: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,vger.kernel.org,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227654-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mariokleinerde@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E92FA2E3590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to
round") degraded display of 12 bpc color precision output to 10 bpc sinks
by switching 10 bpc output from dithering to "truncate to 10 bpc".

I don't find the argumentation in that commit convincing, but the
consequences highly unfortunate, especially for applications that
require effective > 10 bpc precision output of > 10 bpc framebuffers.

The argument wasn't something strong like "there are hardware design
defects or limitations which require us to work around broken dithering
to 10 bpc", or "there are some special use cases which do require
truncation to 10 bpc", but essentially "at some point in the past we
used truncation in Polaris/Vega times and it looks like it got
inadvertently changed for Navi, so let's do that again". I couldn't find
evidence for that in the git commit logs for this. The commit message also
acknowledges that using dithering "...makes some sense for FP16...
...but not for ARGB2101010 surfaces..."

The problem with this is that it makes fp16 surfaces, and especially
rgba16 fixed point surfaces, less useful. These are now well
supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayland,
and they used to provide more than 10 bpc effective precision at the
output.

Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffer,
e.g., gamma tables, CTM, can be used for color correction and will
benefit from an effective > 10 bpc output precision via dithering,
retaining some precision that would get lost on the way through the
pipeline, e.g., due to non-linear gamma functions.

Scientific apps rely on this for > 10 bpc display precision. Truncating
to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
down to 10 bpc, causes a serious loss of precision. This also creates the
undesirable and slightly absurd situation that using a cheap monitor
with only 8 bpc input and display panel will yield roughly 12 bpc
precision via dithering from 12 -> 8 bpc, whereas investment into a
more expensive monitor with 10 bpc input and native 10 bpc display will
only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properly
set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc out
precision) would allow effective 12 bpc precision output.

Therefore this patch proposes reverting that commit and going back to
dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8 bpc
output.

Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 with
a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer and
measuring resulting color precision with a photometer. No apparent visual
artifacts or problems were observed, and effective precision was measured
to be 12 bpc again, as expected.

Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc to round")
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: stable@vger.kernel.org
Cc: Aric Cyr <aric.cyr@amd.com>
Cc: Anthony Koo <anthony.koo@amd.com>
Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c9fbb64d706a..29db5404c4a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 			option = DITHER_OPTION_SPATIAL8;
 			break;
 		case COLOR_DEPTH_101010:
-			option = DITHER_OPTION_TRUN10;
+			option = DITHER_OPTION_SPATIAL10;
 			break;
 		default:
 			option = DITHER_OPTION_DISABLE;
-- 
2.43.0



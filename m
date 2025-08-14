Return-Path: <stable+bounces-169476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E5B25887
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAED1C05D9D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 00:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5C1E519;
	Thu, 14 Aug 2025 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY28UbLO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB662FF650
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132367; cv=none; b=uxMVnYMUC1f/TlZ+Adu/q8ajfOPaoQSrh9WJta/c/4U6OCbp4Cpw1e+l3Y5M2LW63vq+2NT9Oa7qytP+qOQj/vB9JHBZVI/B36y6KPBlcJD6IzybynSSQpPf9G5V276tyuzQLebYWwZrcsh0TD+X7fF6k2N9d7Nrg8gTECkPU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132367; c=relaxed/simple;
	bh=5w+IdFQJtNg3a8WphQ2x0IqHxANNq/CpMOEW7Sv7cks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDy8qub/wHAx7xyVYbseo+tYIsl21srZkLie9IfldtxT17CLpafCclnzUToVhsWaW2VptQuzplO3owusVL3Hm8My9mrp/x7yo5vs7CLTU8ra84Z3a9gLKJjvIZVdLncwABXfDu/75NIl3cno/a3mgN6fEaihbz/Yfew/8dBhCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY28UbLO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a88dcb665so6021536d6.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755132365; x=1755737165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q41+NSBC4T/Dra//vDMOeJpZowCSiZ0Hg0y/Z29NAzI=;
        b=kY28UbLOmd2nrDSbQPdicWvWQbiDBPNcLMzE9BXrIEU2a+7swtcQ4n731xux5ghwwc
         8o9rkv3gMOHhtd5Sj+xpftYPfsYXRFi+GTx23zQc7y0azwDtum5Gy3I/hAKVIMCUKTlp
         qlFQnEdiSQtLbCsK51I225cm1wWLQ8fs9ke/bWF6K/Bg0i44uRH5RQ5IyovNScR9HzTY
         WslgCCeTnOXBZOi+4gx74JdfZkwY0tq1ZytV8mKRa9RIHZ+rbJ9636gHAFlrLxyuoXSL
         Fj41jneMYeKB0nLLYJ0C2doS4DUk5vvcWN2Ipa+o+5Nh/OsMT3b25eRfFWUV/tuPWdsH
         IpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755132365; x=1755737165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q41+NSBC4T/Dra//vDMOeJpZowCSiZ0Hg0y/Z29NAzI=;
        b=eqjKNb2+B2tPylGCH4c9Oc5XnoG1hDMTp1iHpZ8iDwjbfwoyguUKnQ52FBYu6zhw/n
         AJtinbC89cjNEWiayDWNIp0NeAayPErFNvBIw0ktZm9M260uEesZWt5PiPFvh8N6AYo6
         KKZJ7yED4oyVaGisjzQ+jYbp1Skb6GS/tRBZuUtoWcQ/bkW24zR8ktGSz9PjVWIsAg8M
         DyY4XDKgALXPQPlPIIdJrq7KzNHwwt0w7map8BGMlvyc8eRDxXaxDb5D+GMcy3cG1ZBf
         7JibjvQlxF+6iCtqunlyeXyIiUIKU80YsvFGeHLWOSHNlMpFthGETw9hwX/7cqotRCFy
         pl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXdwfvvRt/mq1f9wBlmxnyQwKK97kip8Twsa11Sfd1roKm7j7TlE44jArtEImt4IlPH+Nb68kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXJnfoyRLxzAQPQnz0Y1tHwJL2st11lMSnlyM/KC27NiMOWl8
	H9uZOVNjbvrXeCn5EqOdEboDIWfcQdSZB9rsH1ANHA2YUqZrmOl/C37V
X-Gm-Gg: ASbGncvdQ5D4NUUIs2D8XqlalZtGNyKop1WL80VQGOO4fW4a4qDvbf5KDubDIh7eqox
	yyfoODaCQ6aGza7CC5gxX0NYZ0jwBZbJw6vfHQfrws6OQ6y2pQfwJJkF4zXwtTI106IRK2P+/zA
	JsOGtq26zRHpNJFfjlcjtmhankthTonoCInowOlzVux0cty8HoKy2F5uHvj4px5t+SNtnsYwV06
	seNfiDtUfvJKsn1leadfQb3xlKE2sSIE77WUhJqXTn7UAFbqFIjoiSrZr6qcpPekRghCJNeRigK
	haSqO6YJ5edL018TP8yj0X52lUNHE5xnVAOqO88DXiRE9jkZpaQXcMejafgq/933DqePxr1XX41
	zo8/Fg54faJyX/YcIG43DkIS9knZzVSRs4+Q6Osz/Cmw/dq68ivuZ
X-Google-Smtp-Source: AGHT+IFS8u/L5HYpJlowfRzlk1wT6NRPgj+C/RCfTI4i77S1oz5V9DmtjRmxODN3POKE/d+REenf9g==
X-Received: by 2002:ad4:5d43:0:b0:700:be60:9515 with SMTP id 6a1803df08f44-70af5c02bdbmr19331046d6.9.1755132365038;
        Wed, 13 Aug 2025 17:46:05 -0700 (PDT)
Received: from zenbook (lns5-pool6-090.adsl.user.start.ca. [184.171.213.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ae6cc98e4sm6006916d6.21.2025.08.13.17.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:46:04 -0700 (PDT)
From: Kevin Oh <kevoh1516@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>
Cc: Kevin Oh <kevoh1516@gmail.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Add HDR workaround for specific eDP
Date: Wed, 13 Aug 2025 20:45:45 -0400
Message-ID: <20250814004605.100262-1-kevoh1516@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[WHY & HOW]
Some eDP panels suffer from flicking when HDR is enabled. I am adding
a case for my panel to disable VSC to stop flickering.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4452

Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Oh <kevoh1516@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index fe100e4c9801..1a16bea10afb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -86,6 +86,10 @@ static void apply_edid_quirks(struct drm_device *dev, struct edid *edid, struct
 		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_colorimetry = true;
 		break;
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4171):
+		drm_dbg_driver(dev, "Disabling VSC on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_colorimetry = true;
+		break;
 	default:
 		return;
 	}
-- 
2.50.1



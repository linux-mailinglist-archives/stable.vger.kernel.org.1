Return-Path: <stable+bounces-254660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPlWFytLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF375E9B1B
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E8F8308B9A9
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F93B19AC;
	Wed, 27 May 2026 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjAug6No"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A437B007
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911299; cv=none; b=LndWECP2Letcq6c9VL6niyW0ltrHjPdn5YrXugdRbB5XhE3bXvCS2f/iNf6P0ZZHpL5LVKb8fEFWpqMTPRyvfJl+YbwvAb2JhpNYJxB9K+6Y8Xps4bXC/0YUo/eNFNaG0DROwRFoLqJIg+mddmPuDDL+Y2bAjWojhSCqvG8MCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911299; c=relaxed/simple;
	bh=y+E8ZzupUHLf3gc/wNrJPKcphCNANPEiF+VWr/qbaf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yek99eFVpjN7bmRZhokAzU5qQTRrpKL3lXlw+Jx0MDL6nrhou5PyccAiy0T091RNh3D+iLqzx/c/UyDRS1dMDIROWb3eV6VNrX0J9l3kck59yuOw5ElPzOs0NrkQC/qhwyIdz4MUn4RxfvANTK7IeM1u5TPOlECMVv7qDoK8FKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjAug6No; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-914a8522bc6so735299985a.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911296; x=1780516096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8mDciBpPj7QyAvnzZsu2M6LtyDI2HbLOpEqsNC58XE=;
        b=BjAug6NozGbX9p5nbs4G+DAgooiNz5PRAhLl37xzA5AgY5p2OLulpzCrcIfbTnbo//
         7o2jRjxP9QwDh6s2vyir6uoLVq3s1MGG+YwGBIlVsJd6Jv8rUaa53lDtn98rzMVfNFVR
         grjy/ineC4NHaNzGwu4xF8GG+RbBkvzE4Swde3gyEqVaOkSHKJKt0LkquEc+3zVOPRX5
         EeFrUjTMDQNEdo3yRbTxbLgVP7yTMg32z9khvHRITpBt93lZ6QtkCyHEj/XWAP2VzffA
         hkSmYm5v327p3XfOVorRVKF2GD9qcU726co9I9ipxLxKHQlPONxKXKDR0I8VU9PZludG
         FUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911296; x=1780516096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8mDciBpPj7QyAvnzZsu2M6LtyDI2HbLOpEqsNC58XE=;
        b=URvumJF49KTKdR74mQE48oDxAQLYDeeE1kv+eb8r1F3iWw09poe+DLKvFnucDgvn+z
         2lhLnz1OOn9kTQB3MzNRFOrO47OFnMidL2JU6gnL/wgs1vW/ZwjdaOks3f4p1473CSWx
         U1ho0wL8SK313BUZn9xRSVb2ISw7PvyqYAeblFIHS6tMvTk8RlsR+MOtKVvZKkK1cToG
         RCyCDYDJAkGrxze8ou5Prpa7zK4b75EGtEaV7NegKtSRxx9bwZ79biBHlDl5S/RhbBys
         HmUw38yjgCLvw3Ir5NoJkZQEyyIwhZc3DTWW7jrdXMqFn+7NCIk9woIXe16VLLB7u/38
         1+sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eDJdnGf1ECjZHvce3FkhohuGffSZFWGLumf+q/5QIlYdxwj8XkmccylfT7I4ahm12Xg9Rduo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZ/MBNU5lvyeoqDqE0+FWL9W2+btG0PmBY28i5xiDSoRZWc1n
	QanrFiJvlKs2uQcsOJlDGzCztjR8bXHLu/FTI4RKGxpAZJ366zC7agGetz4GxEo4CE4=
X-Gm-Gg: Acq92OFUzrLPwuMIBygQqdGGmZkuiaeL0EBA6qHisR6wcW+eVUSqfg7NIiBpiraZQgj
	ehekPBbSPINozUKoDLFNzszXD7en0nuS2E0t+LIXqCLB/1BcPYhss+isdryq7C618QwMg0Fp/D3
	Wx3b0t62wW2KSw+mkyzWITzKIml2KA7YF5bmDy0UNxDLkA0M0z1W1RaJl8UH6m5BHAGlOtI2lbc
	BumtP18t55DKWpq/GiRV0G2Z6K/mnbVaQQz0DmwRiXytMBFLlQe/OLZJhfCtNUq7s2Gj0dZ4Qkx
	ZX76oYzWvTTt155wStOYy8ym5HxpXS7X+xV1ePRPTu8qp9tjFoivYjKtYdPXyxufUfbBxcqP9op
	MpyHRyWL9PtJ5b58CeQXtVzPxiCJUX+JKn7sL8plzTkOYFp4F+oqJnZ/s3BJEn9f1DuKRAx9U8B
	GCWIRHd/vapZN3cLVAGebdID12M1B/64Hq7YPqMGNvZIs0edUamRLP0Azr75+ru8tSDBH7CcwQ1
	Mv4hGlXNIp3e2DYFJ9GEGVn+HBt9VmqI5Vw6865bSCZC5Otf8MCaA==
X-Received: by 2002:a05:620a:1b81:b0:912:1:b415 with SMTP id af79cd13be357-914b4934c9dmr3420082985a.26.1779911295913;
        Wed, 27 May 2026 12:48:15 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87017a0sm564942385a.15.2026.05.27.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:48:15 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/3] media: rkvdec: hevc: bound EXT SPS RPS control counts
Date: Wed, 27 May 2026 15:47:34 -0400
Message-ID: <20260527194737.1999409-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513181922.2075438-1-michael.bommarito@gmail.com>
References: <20260513181922.2075438-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254660-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CAF375E9B1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A userspace V4L2 client that can open the Rockchip RKVDEC m2m decoder
node can submit HEVC EXT SPS RPS controls whose spec-derived count
fields exceed the driver's fixed hardware descriptor tables and
temporary helper arrays. KASAN under a KUnit harness wrapping the real
rkvdec_hevc_assemble_hw_rps() helper confirms slab-out-of-bounds writes
on num_short_term_ref_pic_sets > 64, num_long_term_ref_pics_sps > 32,
num_negative/positive_pics > 16, and an OOB read via u8 ref_rps_idx
underflow when delta_idx_minus1 + 1 > idx.

v2 splits the single validation function from v1 into three layers at
the appropriate level, per Detlev's review:

  1/3  Tighten .cfg.dims on EXT_SPS_ST_RPS (65 -> 64) and
       EXT_SPS_LT_RPS (65 -> 32) to match the HEVC spec limits and
       let the V4L2 control framework reject oversized payloads.

  2/3  Add SPS ST/LT count validation plus
       num_negative_pics / num_positive_pics validation in
       v4l2-ctrls-core.c so every consumer driver is protected.

  3/3  Guard the delta_idx_minus1 underflow in
       st_ref_pic_set_prediction() in the rkvdec construction code.

Cc: stable@vger.kernel.org

Changes in v2:
- Split the monolithic rkvdec-hevc-common.c validation function into
  dims, v4l2-core, and construction-code layers as Detlev suggested.
- Drop the rkvdec-local #defines and pr_err_ratelimited; the V4L2
  framework now handles the bulk of the rejection, including the SPS
  count fields that drive the rkvdec loops.

Michael Bommarito (3):
  media: rkvdec: hevc: tighten EXT SPS RPS control dimensions
  media: v4l2-ctrls: validate HEVC EXT SPS RPS counts
  media: rkvdec: hevc: guard INTER_REF_PIC_SET_PRED index underflow

 .../platform/rockchip/rkvdec/rkvdec-hevc-common.c |  3 +++
 drivers/media/platform/rockchip/rkvdec/rkvdec.c   |  4 ++--
 drivers/media/v4l2-core/v4l2-ctrls-core.c         | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
--
2.53.0


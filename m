Return-Path: <stable+bounces-203415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A96CDE5A8
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 06:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6451300A359
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 05:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3A23BD1A;
	Fri, 26 Dec 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWUjcvaz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23D21F5842
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766727472; cv=none; b=hYTG7WRXwwezCedGy3056sxhiJUToqLpItpxFgrJR01OwPnzG/Eun/XwWtbuVwo0392m48QfWb2BcBiLFYLwhuGkJ7jhYVDLM62AftEvYIxdjDRiIeCnyt/+/lCNpqDWOrBii/7PSsB4SAcwnYN/3SZm5BpHQb9y3B2itxKx1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766727472; c=relaxed/simple;
	bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WxZI+KroqnCFpmK4Ub1ifkIiV1Nosq4W+Ru906YX03phUnbuvSBzHFuebzc+zavQ3f7ElVI858ngn2s2KXW6J6wN6HZIoYh0kZEU5F9PlNe8seMX72ujiioXTE0UhGoOaY90dQLNkrl+yP3PggJAXfrx7DvNVwMEaZUTYzJcR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWUjcvaz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0f3f74587so98651225ad.2
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766727469; x=1767332269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
        b=HWUjcvazx9v/7iGJm8OsV7/MylhDUAVKNwzmZXyLBKbR3gLNINi/L/gTe560kxnnr7
         KK/jBF44SDViT+38gHDairfxjb6sqdxcfOq7ow/4yT6uElXmNmZq85Y/Yr6TdXs3dxWj
         AE6ElB0lsvEAFAQpGPGnzfjHydnyUJSH6ryAe2MCci0AOTgCEGMOVqFC22cL8Qre5rRM
         50it65A5gg1XXbe5Fqcq7vn0psYSX2g64K6VRE2LQ9ucV9PcwjwFuKwFDwsgbCVPTe20
         PYD6NDhlg1fZZqZ290bpbi1COCI0oMfbz5UKpogXungdFHCOcohc8HCg8O7dbkU4Vhs6
         oygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766727469; x=1767332269;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNfjI1T1+B23dZV3+u5LqFMovbJwrjQnRfDKEwasWwU=;
        b=wCskQ06tpKgYog8vW5QDnwt60OvreITpFyg3XPrjqHGKY6fPZPXadpQEjKlr5dqLXr
         di+Ijfr82TqJwSNOMxqLnzCJ7Jc2xM4B3494L1bKtOxl4xb2CXP8I5qqDb+HDTfGOod8
         hI7BBbe0tBSPkPJDKfSbSLWb98i2sR923l0B/KXmtV9hz32qm416z3+sKPhSYT5X2Pj2
         nzoRgoun7ab1cqKuWOddxSydXX8FhZ6EoUJoUPGIiaA4sDXAcMtO/auccWy1DujCQlY2
         oJD9nVNjBZSd+i6W+iA+yIpOCw/qm7aXKRNiq0cnFD8KJFZ2vWscWvg5r9/BZQIb1v5n
         DEUg==
X-Gm-Message-State: AOJu0YzB7svfYtONFUfdbGP0o2jUVc3CJ+aoFxgquzZDhFqXXVRaxcSP
	Dm4FUCnQ79noEmG4Vlj7suz82vYSgG5P/7ZoUU9LMMK3Pozssw5XycHcu5eQATUxNwVY/xRm6Lp
	L15T7HW/cZBxtE4n56NqLonCFjhEdtVJiOrGT
X-Gm-Gg: AY/fxX5WuJlRX1uSfnvTplH6glOlLZq4syPouS+ozAadavZavrG3aeERekTnNoSjTO8
	bPSNP3Wx+kjmtMm5Ld+yvZV09yJFg3VQDerlg5VsN55lKzchqJLbTSZAFCsk+OnJQs5kP0NE1M0
	dzLtlgirLCDa7tr+vNXG88+/WE1Nd6WWnHitNld3NM3krkT6ZKEcydIqXpQJ4QSjTRMznqTZdNQ
	Uew3a/pt7XTWh+re3/uqA71/Y+hVYcXuD5FlrIykAHnyMIJ+3EMem1H6+P4lk9bOE5ifKdoV4Cf
	IbF5UoKBcjKNu7g2HKk=
X-Google-Smtp-Source: AGHT+IFHmB3KAtgnAFZEBLxVZw8dua5doOOkhyb8dga0r6/LbV83FGc+6ZMMGYXDisl2Q9jYYm/7PROAUjWhG9ZCnvo=
X-Received: by 2002:a17:903:18b:b0:295:fc0:5a32 with SMTP id
 d9443c01a7336-2a2f221284fmr227033725ad.3.1766727469576; Thu, 25 Dec 2025
 21:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Fri, 26 Dec 2025 13:37:38 +0800
X-Gm-Features: AQt7F2pMD-yyutgxIcP81xrEnfriCzQVdNO_izI04YscekyKSdJbpbOdUCutT6k
Message-ID: <CAK+ZN9qttsFDu6h1FoqGadXjMx1QXqPMoYQ=6O9RY4SxVTvKng@mail.gmail.com>
Subject: [BUG] net/sunrpc/auth_gss: Memory leak in gssx_dec_status/gssx_dec_buffer
To: stable@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

A potential memory leak exists in the gssx_dec_status function (in
net/sunrpc/auth_gss/gss_rpc_xdr.c) and its dependent gssx_dec_buffer
function. The leak occurs when gssx_dec_buffer allocates memory via
kmemdup for gssx_buffer fields, but the allocated memory is not freed
in error paths of the chained decoding process in gssx_dec_status.

The gssx_dec_buffer function allocates memory using kmemdup when
buf->data is NULL (to store decoded XDR buffer data). This allocation
is not paired with a release mechanism in case of subsequent decoding
failures.
gssx_dec_status sequentially decodes multiple gssx_buffer fields
(e.g., mech, major_status_string, minor_status_string, server_ctx) by
calling gssx_dec_buffer. If a later decoding step fails (e.g.,
gssx_dec_buffer returns -ENOSPC or -ENOMEM), the function immediately
returns the error without freeing the memory allocated for earlier
gssx_buffer fields. This results in persistent kernel memory leaks.

This memory allocation is conditional. I traced upward through the
callers gssx_dec_status and found that it is ultimately invoked by the
interface gssx_dec_accept_sec_context. Although I have not identified
the specific code execution path that triggers this memory leak, I
believe this coding pattern is highly prone to causing confusion
between callers and callees, which in turn leads to memory leaks.

Relevant code links:
https://github.com/torvalds/linux/blob/ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1/net/sunrpc/auth_gss/gss_rpc_xdr.c#L84-L92
https://github.com/torvalds/linux/blob/ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1/net/sunrpc/auth_gss/gss_rpc_xdr.c#L304-L347

I have searched Bugzilla, lore.kernel.org, and client.linux-nfs.org,
but no related issues were found.


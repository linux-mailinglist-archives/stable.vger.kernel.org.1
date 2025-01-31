Return-Path: <stable+bounces-111855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12430A244FD
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 22:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3501884506
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2A1F2C25;
	Fri, 31 Jan 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfT/gm9y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1041F9FE
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738360172; cv=none; b=gGXVheZYM9XNNO3PdJjpSvDze77f6OgNVpgFAf2TWEk7wVXFkShEwRj8DEGloPwBteYjsA3qSWJLwCeB/6q22l+uLXfyDJVrTXltylf4c/trqkhNIvH24Tx3zRDH//hIeGYQZo0IxcLPI3NQqUrS7muceZ/nXRQKL03p2gI0/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738360172; c=relaxed/simple;
	bh=H+idgXkKGw197QkF+ZzXn5zv5vDEpQwyOivec+67Anc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e7piuib0/rOmgrUZqnWweA/VncB5KreVaTwQR7pDpjhLHcz+/DLGYf4V2oimGPTYvitzUL8YjIDrPkV9uZL5HVRjtFiKUClUycHPTP0mWH8LjvL8yIb+aYi1HAUIIqXjmzI9iyYWClD+w7cMPDTABApTfvSF7+4vPeWR62TQ3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfT/gm9y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e384e3481so2163390e87.2
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 13:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738360168; x=1738964968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H+idgXkKGw197QkF+ZzXn5zv5vDEpQwyOivec+67Anc=;
        b=qfT/gm9y0bBh8P3sgiMU4Z5ewI9Q/Nmdgzifq3uduCnyqCz2CduB5pwtZy/5NgcSZ7
         5f4ZIkgdgmcXJafSLp81lBFoNGM25kg/41K1blFELWl4QhR/B6e4hBTVEtZIAjF6nrFm
         p5n/7fr4KvCfPtLOdp9317fB9SKtRfXmlN7WMTklpYERuzTP+NNDQ+c+9KgiNsLDVK5s
         DvEdDazst79iV3hjReHAQzQfgo9u/aH0VhYfbEdeBUmsKy61S2pjycCHC6gSXBJ9X5MN
         kDqecLWoJ3JK43A9etobf2EDlm9XuVh6IPqbh7n3Jt79DFrnALemG8JfsmVE109rPXnR
         LDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738360168; x=1738964968;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+idgXkKGw197QkF+ZzXn5zv5vDEpQwyOivec+67Anc=;
        b=VBM7yxq8allkDPeIxUI1Cb+cm+cyifvQTjgp70+/8EXqFfr8hRvwJZ0Ax+pnEZHcR/
         /YTCeRTJRf3vRMr1hz/zvqlMJzEETzkWv/w15hP/mDcrJbB4gA8fQVpyJI67kzosmKYF
         ja4f6I3xMTSe3QTKRW8FeWR3zd2ttObQympPYASoc18N2E++JK1ho8xrnV5a7V92tD8C
         aRxyLcwU8xib49oM8NKyAr4/C/d1L4K/NHb1NF+UeRwwQPfzOq6nmBPsbveCj13hj9zw
         9tMXVZiAQVneBMXW+j+0vYf0u8B/mz/tldyIUWcF7E/IIkwCXrqrCC7HVtOuNesbmkXp
         vOSg==
X-Gm-Message-State: AOJu0Yzbk74jX3bkXqHodb0DoRi4JgxwszrzDfEa/bXCJvTdjPfU7Vqt
	J3wIeVQ6R2xLxwwkDfCye6/etM2/p9ook9KzWy4iIH25/JO2dfO/GWqs85scfMcJErx5RvBnNBO
	LcMlh6MpfDdBY5YVoT21ME2ICXGG2YKnL6JbfhoZRGaSXKwOJj43n
X-Gm-Gg: ASbGncvdz/YGVSm1zWthZhERJyCFkT8iK+MmGjej2NW0c5tJlvjNP/2YL3VLW6pH6FR
	ZbC2hUPbTTJ12V9Y+FTss22t7rOFTeFkFl2MKfonWqkRFERqZEQ/4vjObTvPdoFL+Ek4RhpbLRj
	q+g1DZRN9QysWvY/zKDHHMpW4/Fg==
X-Google-Smtp-Source: AGHT+IGQNpCOOYqb4gQCEfoVkpPqHUGgSzIqEfsH8Z/4kX7qrbCWBRLAhKgveqnjtYy3OM+cMcvM0SYviKNcjZ1cJuw=
X-Received: by 2002:a05:6512:3d13:b0:540:3561:8897 with SMTP id
 2adb3069b0e04-543e4c3258bmr4347511e87.39.1738360167864; Fri, 31 Jan 2025
 13:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Rosenberg <drosen@google.com>
Date: Fri, 31 Jan 2025 13:49:16 -0800
X-Gm-Features: AWEUYZmEdlgeHOtbJpUaQHFiGmj6x5H7_BeDEv1Z3-OHOcNWNOTLcLldoKtEcPA
Message-ID: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
Subject: f2fs: Introduce linear search for dentries
To: stable <stable@vger.kernel.org>
Cc: Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"

Commit 91b587ba79e1 ("f2fs: Introduce linear search for dentries")
This is a follow up to a patch that previously merged in stable to restore
access to files created with emojis under a different hashing scheme.

I believe it's relevant for all currently supported stable branches.

-Daniel


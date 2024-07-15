Return-Path: <stable+bounces-59371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F11931CCC
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153C728268C
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 21:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2913D28C;
	Mon, 15 Jul 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roBN248y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724A13E88B
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080323; cv=none; b=LyWRGvSgpByEcRwD2GWzWtkOCNDd5b5RIWbwax6IsDoBf6rC3fslv6kgckV+Bf3TWJTg3hn9imQOjYwJliYMAd2L5BWp4+SDSJVs4iv+oUkriJvlAPvcPVHbtjMe4tOhuLEk/DQGKvkbip0jDDxF+JXIqlvVsEV7TTb5ecrtEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080323; c=relaxed/simple;
	bh=YFbplF/GVZKVJhwwbTHnz75/G8QvrkICbsADbOKY5VA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=smdLq2m8tX3sIk/tS4sl9VOFD6EGPzQW+HfYfRD2HxM3YQ1adsQ9Fdoi3x0urstJJR/FIZRA4jl7NG6KfOhg7FxNaZ+4E0vOUibAvPE9KubvpEWkCshd6BQZOMmXQlIwuYp3qw9MtNy7qyG9nbKSPT3BCjYBoKyUKUj8D9A+1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roBN248y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42725f8a789so6455e9.1
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721080320; x=1721685120; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFbplF/GVZKVJhwwbTHnz75/G8QvrkICbsADbOKY5VA=;
        b=roBN248yDPDye00P/nX2oQrj2B7h6pnTKzVtZ1B/t/+yAQyyxYWdg2EufnYAygm8iw
         vGIPhm8hQmdffbOFBmiBqX0IlEpGj89bNOuBNb22jn4W5M1NoNA4xRGBdYMgUZHvbBDS
         Bmsto2Z+8LRz9Sj0kh1V3KIyKBj6pAC4qzTVxDGb3J8/yMX8WqnlqWDkJbS6C6NUnUGS
         ePX9sjwef1pjeEzggF07TDPRIfS5oRLoXbOv9bnfF4r8RZiW2DHngxvBVYXwK9VySIY/
         CzwqEYbX7Cyq/OC2MFOcjGZixWhc8MYtvOGG4/Mo47LVcO+UFI3qjwoo93214BHfZ49O
         93kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721080320; x=1721685120;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFbplF/GVZKVJhwwbTHnz75/G8QvrkICbsADbOKY5VA=;
        b=mwvPVCR31h4FU01uhqilpIfyqmLjIl5WZviLUmrYPl6zSZaGSMD1vhr1LZ/Bg5FIvf
         l6Et6TkzWIEcdiQu3uWU2OhxJ8kX/sCQNfLM7kvXSZSF4iKdUYmq0hc3k1ab06yMBbpZ
         9ja5aMQ+ltY4TWYenXcJn6eSJ9kqG9tSa4uKcFwOakDr3bII9z+DOesNwaj4u/q+cf5B
         fP/KU2jzpx99V8vPVz7U5t60tAwIY5jJLynXkeu6afq6ba2byOg2P2waJvyCpF36xnat
         pihK2K6vfaRiOU5w2yIp1e85Y/VCwvmJen4zB6xhFMWLpaVJMfd02882gG9HUxm6A3z2
         mxBg==
X-Gm-Message-State: AOJu0YxHgA1zA0jiBInLJVCfAwGZGRNwXGZO4v8CzweFTZPSNDGruyyF
	dhxUIGzRh9jxziPKZnFLO1wVA/3EmchGOEEeOgAlY8CMPep20SPEnKM0t0q0acfGel3kvbmm/Lo
	GkEH6RDcVJ1Djcyz/4USPz9zocJbI0Ll28BZXY+iX4wUiSgVETgQkqZQ=
X-Google-Smtp-Source: AGHT+IF1UitvAZUprT8KNnaAPkXc5Ij54hbGDqTipf08dfOQvYcHWksuXz2ozoyTL+UUhubngG/5lB4XthwECvBmSbw=
X-Received: by 2002:a7b:ca55:0:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-427ba6b952fmr154125e9.7.1721080319469; Mon, 15 Jul 2024
 14:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: He Gao <hegao@google.com>
Date: Mon, 15 Jul 2024 14:51:33 -0700
Message-ID: <CAGVOQjGG8_=FC8eT33Tf-t2CuM=Z_-0evWN59CP-2mwAMk0QLA@mail.gmail.com>
Subject: Request for backporting bpf patches to v6.6
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

There are two patches for bpf that I think should be backported to
v6.6 kernel to fix a privilege escalation vulnerability in kernelCTF.

bpf: Fix too early release of tcx_entry
1cb6f0bae50441f4b4b32a28315853b279c7404e

selftests/bpf: Extend tcx tests to cover late tcx_entry release
5f1d18de79180deac2822c93e431bbe547f7d3ce

Thanks!

Best regards,
He


Return-Path: <stable+bounces-180587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588BB872E8
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 23:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E168A1C87B3A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD73F2D7DDE;
	Thu, 18 Sep 2025 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8mRoC96"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572D72222B4
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232334; cv=none; b=aBDQuEjIxDvuDm9/e4EIQp4wjP+kxUwdW6tdJXcBszkJ30+Jjcmni+b8ki4MAz5MqQv35YvhqR/mUbFXbXRAlSmVjv3RAIm7IIRw3vU9n7Fnhr4DhbpApeuiW+wQLpSJh+jcP/FNz5Yba3c5DyKznt3UAfL1S8kv1JP1co18xF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232334; c=relaxed/simple;
	bh=Ipq/8bMEmZ3YBB5MvHG7bBIQs7fEdskNxCmPXaIoyDg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qd+HpvkoXX/MWfrHq7UJMpRZt2eirHzdfh6cpW8pgWhfBmsTsF4Bf4nOFv2oEwAzGXzzF3Vovs/QwbobTAgvPJqeqzrnPHdaFiv6xviBT2TgCWF+esmhf5okiojGkAkaZPEYYZUBI+ihGXRnGoAf3hcjx78+HpWKTV7oFsRWSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--angeladetula.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8mRoC96; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--angeladetula.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b595so678769a91.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758232332; x=1758837132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GYOx61hntVPS8SRxPrDcvDgBzheZb9eAW8Va69wNEpA=;
        b=E8mRoC966Uzm29jX3osvHTJI2KL6bKPc/T19rJPIRXKk95Vp66pG1eVnj6L1/Zezfg
         YOpYJW/ZGbXBXKh6AfSM7dp7wjMr3wKQHkr5JV0p0QVRdBdjL6Lhkp/l14n/NxxMwErl
         mfM2dPq6ifpiVFprBfLWI/IyLJKO+nn2O+AOeVzVYT9v1v74HYWbmrCnGEfr0yjInNOs
         vsTKmTVe5biZ/ADaZUi1vGMm4EvS4KV7e7FnNluex1h/MwA6mvEuvc6htuevvT3ke7/Y
         MIWOdc5OEpNdpQ/z5paF/P2Hvw7crZFD+ehggERWvY97dc0L0f09Y+CIS1J+BEUgXXNv
         fmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232332; x=1758837132;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYOx61hntVPS8SRxPrDcvDgBzheZb9eAW8Va69wNEpA=;
        b=JuW8fkj9sEHT+3jFLVe50K/PbHGbue4IZ15ICBr0TCVVXftb8IXobvb5IHy3RLjUqC
         Xf4+cv5/uqBAcUcIU9kOFFvQrpHONbSNb6rHup8gKZxxtrIXqdgb+kWA7CjfVqpPHjaX
         RDP/6WJB+BM+1vM3/QZcLWx2I+93N/7BYvUHCLYMlQ0Bzd/N9wi1qCv/SNK+ySja8jkk
         2n4a4oQpGmEmtPYSRbz9jrbaIDEL26CQXOq7x+wEi9jxmnDoDe+KvLFL5TtJA+xyHhwk
         qbAD1EWe5br2TpnW/ON6jgimzv47KN3BgsevIZyxiBfPHOVUuRatLRv+Rgc+7zixO+T/
         /0Lw==
X-Gm-Message-State: AOJu0YyLNXkO/Ej5yYzqznlnsYbkPunu8WCJO/EYRMEZBvV4QQfKNMpQ
	Bajk7O3JAkrTUQZ94fiPVylT41Ou9z5Y2JXb2sh/zY+FKkvGAc5Rk7dT2SsbXknr6aw8rsFyEMv
	2hJDGN7Y6n5J+PRYx/YgSVveChIPtvbgyG7rsZY12A4BGH81Uyj9rlzbY5OdOF4LGbM3eSKkLMQ
	ZLKioUkLHeDGw/xKZlhix+eHf0jdYpiAIUDx6gYleYLSQtgPkCBzjedXnAuBgHapbKiZFP
X-Google-Smtp-Source: AGHT+IGgQI99UJIJxD+7ygUSt4Mcoi3zB6/kj33XSbRnNR5dyvIydoA2dUlmxw8CkrzgTyz87dnBUIOaCNoonciUz+s=
X-Received: from pjkk4.prod.google.com ([2002:a17:90b:57e4:b0:327:e021:e61d])
 (user=angeladetula job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d8f:b0:32e:e5:a90a with SMTP id 98e67ed59e1d1-33097fd0f1fmr1126840a91.8.1758232332436;
 Thu, 18 Sep 2025 14:52:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 21:52:07 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250918215208.1108713-1-angeladetula@google.com>
Subject: [PATCH 0/1] perf/x86/intel: Fix crash in icl_update_topdown_event()
From: Angel Adetula <angeladetula@google.com>
To: stable@vger.kernel.org
Cc: Angel Adetula <angeladetula@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch fixes a crash in icl_update_topdown_event().

This fix has already been applied to the 'linux-6.1.y', 'linux-6.6.y', and
'linux-6.15.y' stable trees. This submission is to request application to the
'linux-6.12.y' stable tree, as it appears to be still missing there.
This should also fix kernel bug CVE-2025-38322.

Kan Liang (1):
  perf/x86/intel: Fix crash in icl_update_topdown_event()

 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: f6cf124428f51e3ef07a8e54c743873face9d2b2
--
2.51.0.470.ga7dc726c21-goog



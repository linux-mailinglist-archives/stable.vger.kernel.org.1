Return-Path: <stable+bounces-21756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43C85CC28
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A381F23DC8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF50154BE7;
	Tue, 20 Feb 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0ve3wr+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89C154457
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708472619; cv=none; b=u7yr2C8OaLgRJ5pq+kbWAegDZ9BE+Ro6PlhZoXJcX8qwFY05B28X58mP/YHdxvUGSXav2vBPm/M4OLHY4Udno/y/ZLbUs3FrWM6VH+7Y1uBEbZqacQTC7VtFJx1pL5fws56q4qzquSTHz3CQUXUnZe+3V8FPm8jHkaUS6oYJjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708472619; c=relaxed/simple;
	bh=Ru1fKAcyuMwgKmoOKEz6wuzRm31huRedSj8xM9llnMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sKVmiwiv4KAanTsAJxU1HJOWScU+pQFT9641M+DEii1DwNwWLcR8Q8iAntSt0BSLi4ey8ZrGPoyVDMHSaGCZyhRAxqpjqjitpQVTYAkK1EoXDB9EJ4okE6Tzvs41Wl2NzvBt4F9brzQQqRMAn6FtQ2alSGLfUi/EUTbP5VbD8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0ve3wr+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dbde77b6f1so32423105ad.1
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708472617; x=1709077417; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48wEXAjnvTDiosZGrDnyzDx3zyyLfBFRFih75qboPJ8=;
        b=N0ve3wr+YZJwfkUZbx5s5LHcJ8GRRcpF9ABt+kVHNWQrfCl649xjQE0zCSZwns+Jq+
         mzD3HkLuWbfQ6KYuzXeB83S0prprRXA1UnYY+IK/mKbfUwNc5Zidlb461mCqNY+Zaxez
         Oujthwv+zaMh1VncfMKGFOyhQkRI8quCrU6if0WehoYlisT/Ebd8IWAhCMUesMvZmklg
         Y+/4TacFm91z56oK+kcO4HCMoM+nNOr6kRfCkNvLwFZqqAe92O86hOdk/b+2J/z8QkTq
         SIodYujJ0nO/EvyHERUz3SaRf2ctus2WMqhL1w6lYhqHVO+q9mWp9YFUQmDP+J94oxVB
         rlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708472617; x=1709077417;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48wEXAjnvTDiosZGrDnyzDx3zyyLfBFRFih75qboPJ8=;
        b=ixBI70v2hCahYm6/VD26z/SfYcl/lNWVo0SpCxsJme08clM6QOha0fQy8FWrgltU01
         FJySbdEzGkJ4/DkHH3EN/EfuvpYBlh4iYGiJYtwxcyWh18FlygWHKNPWtTPCbPowL3dC
         2PSvnG8csjnob3xOB4eymWPAuJx/05H466MdslZEfJ9OPkmlPRrqNd0kcf0iw3OePDJK
         6S56Xkaz5JZ1gE5Ub5PrWp/0wT5JXvzENNREqEfX675+uk3wvZScB0z66wMirHGEcAdm
         A2IzAYKDuxiftr1oaItendUIBa2MY8QflXuszfUL7M8JTptJ5df6q2/8b/yFWWGLSQJ0
         dxDA==
X-Gm-Message-State: AOJu0YyB409yxQXaWYjBNFJ2FIJHtfdelfsadlGZoFwNZSMany4fDwWs
	gur8EtddTTcjFrwgOvDQkFKf5C0GfcgSqxYI8Z6BQRAyfsDhpKoOC+8aWnGvsj+/L8WI0wNKCFd
	RKQ8swWRwt57mYJoFOuJ4FuIXiJs+ILS4c4JpIUWyH7R6cFAFbDDKbG0x8VKcjIpGLyYLo0fDwn
	xCBvSeXqLajkWUIT/UNh05dcmkzEU=
X-Google-Smtp-Source: AGHT+IH2mjIV6u03aVqh0I1r/vUN32tkfe5i7i/immZyV8OJ66AXwlhVsroUcK0xWKaznvfkJkYUZzv7HA==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a17:902:f382:b0:1db:b8a6:dbb2 with SMTP id
 f2-20020a170902f38200b001dbb8a6dbb2mr282727ple.13.1708472617071; Tue, 20 Feb
 2024 15:43:37 -0800 (PST)
Date: Tue, 20 Feb 2024 23:43:05 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220234306.3852200-2-hegao@google.com>
Subject: [PATCH 5.15] Backport the fix for CVE-2024-23851 to v5.15
From: He Gao <hegao@google.com>
To: stable@vger.kernel.org
Cc: He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the fix of CVE-2024-23851 for kernel v5.15.

Upstream commit: https://github.com/torvalds/linux/commit/bd504bcfec41a503b32054da5472904b404341a4

Changed code not affected by the patch for the old version.


He Gao (1):
  dm: limit the number of targets and parameter size area

 drivers/md/dm-core.h  | 2 ++
 drivers/md/dm-ioctl.c | 3 ++-
 drivers/md/dm-table.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog



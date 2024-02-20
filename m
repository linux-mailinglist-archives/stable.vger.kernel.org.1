Return-Path: <stable+bounces-21758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A585CC42
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E2284ADB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DB154C17;
	Tue, 20 Feb 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaUpSyIr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B764154C12
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473021; cv=none; b=sZYMV5cjE7FJ6v1Oz+9Nu64TCV7RwqoFZElftE8w5O8t/tQEpCHJFeA9nyj5uBxFHQAkr4pl7PJdE1ETI4+E6m1srOVAkj/TyFcHheoBvEpOpKey9MPxtfFuz1tkIQjD7SriG+yWxmFQe7sD0QZHBwUX2aP1HJyzTqRKxbsqGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473021; c=relaxed/simple;
	bh=92mmqFWpdL54fK+3E+vzSQhCz9+VqYOa0sc4jXRw9pE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LVWU1Kv7j3j53UyK5oO6LZ486OyE/9IWWLphwMnbP6OeEyUZLUNxQAQdsSJXyqU8wn1rAAxqgb4QN++wheosMjEpg68iG7YN5NfzpHg4LfRH0R6i3VSjmw1sBu+x2NmkI2TOQr9ckdn32PXFJMu3e/a0T1lAYmLD0FAfqiInuTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaUpSyIr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608084ce3c3so693667b3.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708473018; x=1709077818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PXTqg5NGKfb4eg7voAn8+lfxea/WcaTvH/XS+C1OFI=;
        b=LaUpSyIrUby3ETS+tfpv3RFGeDHYXE0wyr9l+0WPabQrYsxFBhR/aFi0xGO50xzyK4
         k1KC8CXNHiaYhBfbYxKaFsVcI6vGCkrUEsPjn9KlqQwvHLxagW5WNsvt953Qz/DSGDrv
         WnrN4NyrOTE4RN9vDT3oujD88tTGpja8e7IJQQUyi+XqL3Qh0bSTtQrvtImoJnV1uh6v
         lAGRVHKeyoAcnMgHGCUbXFK1yBk4O3dPu8uhQn3pPv33fSdG9RAZ/0GdpmXr80arwhd/
         sp+i1MwId67k3v4cR+a4gmIgg0sUer/NRkuivL1MhoLE9N3ibeAWaDFWbWp4KF9/k0b1
         9I2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708473018; x=1709077818;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PXTqg5NGKfb4eg7voAn8+lfxea/WcaTvH/XS+C1OFI=;
        b=GB+kzO521rUL+XKzhedr+9DopJifnS+9mp8Remq+/2PMc8MrK3UtWiVOU8HdFLgBGQ
         qFUKWmgqH4NFtnG97xe0S6i/8N2rW1V3sd2MFaoMtbZ5q1Q6nLaUptjb6FoZ2UDw+vHK
         Aphvz3mW+OHvOJNJD16VM9XmN8hNRa4YWwemzF4Ce0ME2r7+G1ErL8AfwiUf2WI43MuJ
         NaNSF6M1Pz6HWOYMttsGp1bptVo8rgx+9LYlkOx9/1c6UVpS087bTYl6jnDXWzrmZzD7
         Ak/QQNDReOn177RF4c+4Vnx5IQwYUbSWju8kExAtq9Eh2xQXJdDJKuBmcJBFwPvzHzQJ
         OyTw==
X-Gm-Message-State: AOJu0Yx69p1/nvAaMmG2kGJjjs90eoOtqsLj6by8tnRZD3I7eVX/mKDv
	EiqXoYqBvyvlrluyDb82ZK2vtyeSyEf0AfbQi2NMBtFP1QnPQZ+Q3Bv7JfRzWkKTrDmO3YNsPnl
	JCD9FWpC+XNbMfj7Am9FzdB+CGmSNzovLXT9Fn0AzP7ymVTTe+TKkTnMBxPMzEmLgvGNRWOaW5T
	SMyIqnb3J4g04pX0tfDAvwMAGnlvw=
X-Google-Smtp-Source: AGHT+IGEPh7cVAdqKTXI6deaDD7Kp/tgkJa0NuVTOkr7t/1uRYDXWa+xMUtuZmDvmpdhcDX0gVX0GXatJg==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a05:6902:188f:b0:dc6:dfc6:4207 with SMTP id
 cj15-20020a056902188f00b00dc6dfc64207mr4464250ybb.10.1708473018431; Tue, 20
 Feb 2024 15:50:18 -0800 (PST)
Date: Tue, 20 Feb 2024 23:50:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220235013.3854860-1-hegao@google.com>
Subject: [PATCH 5.10] Backport the fix for CVE-2024-23851 to v5.10
From: He Gao <hegao@google.com>
To: stable@vger.kernel.org
Cc: He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the fix of CVE-2024-23851 for kernel v5.10.

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



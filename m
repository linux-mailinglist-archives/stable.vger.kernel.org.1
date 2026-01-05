Return-Path: <stable+bounces-204952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BDACF5F88
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 00:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536543057E9F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7312EFD98;
	Mon,  5 Jan 2026 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEgc8P04"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405F3A1E63
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655508; cv=none; b=X6cmCvL+9xIDrxBeR9/P9jOgYvmQwHm604/mAOnF6K75kbrisW4osIOFVql1JeGBxBkmYEiVL0NIP6U6ZHLMKWtYTD13yy+zyRJ7H9BONfzwYLyVGGSN9LYjimHS82JWROclw54xT/yVpCOBlFHe8pOUFx8my7jVVXAwWDH7ft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655508; c=relaxed/simple;
	bh=2PCUcxAxYvAy2hcKx+rpzCh92HmmXeKRsj2JwCyhNNo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J8rYUtpoTXkrxuJ5JBE1HMnLkRkAo3h1gBN1sM6Eou4MRYsfwCy+hAbMqSmGF4LRR5bbRjyQRGkoKvpn3ZFLgbDbnHe6yQdHsD1eP8HeIgtBVzMIXPJuwR9ibjE9yx21UXhu1Vgem1XiLnCbEcoK8+UENMyH9uoZBSWCxACBGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEgc8P04; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7bf5cdef41dso876874b3a.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767655506; x=1768260306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oan93+lIIMYyN82Q1bThEoWEawSCNkralKofR36luXo=;
        b=mEgc8P042RNqmJ+zaeHwBN4l0EPeu3Xpyw7kGAHM9Lw1Beq/mXqAexQKjeHV0jy7kA
         4nLLGTr7oOP3TCHxV6j4LlwED8RtTRraePCZhN/Xkw5cI5QbOgfyoP0JKGQFW8yfz/yU
         KVUPwVAgnX3H9vj+zT5qjHmarEs6F10JGpnUeoo8D4SvR+s4fkZHKvY2kaRNrWNOLMa5
         e2HqGXRgyVYsATDLV4phJSg2CU548ud4X1lkpdCfMOo1uuSsWkGaPzLvwvu7ik1wuhG5
         nc9XjpiEfnZAQtclAHQJu6ToLyzulmY8LCKHQ8T2HsozenlKWE2QCteONxhjaCoEDgC6
         GTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767655506; x=1768260306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oan93+lIIMYyN82Q1bThEoWEawSCNkralKofR36luXo=;
        b=wWsCKLBXBwuXL2/Nb7rgVn3gWJTjWGvGzjr5uqSi76Nf7+zPVybssdWLge6sXkwGaN
         8E4M0+TJReFafcTEULGpf40CSpnBxCL8nTpxQUJS07Fo81GCQFNZDiAadPV1K7t2d5Xa
         9QShbDGcgT8y5fG8c17m45SASVP6niTszf1h8UAghyKcpTYhXZQEAwQ350IQ8rI9pAZd
         At0/j3VosFhpZHHFgKY8Y9UJFWcyr+AgxpojBtDKN0Ia6KNb/gW9T+8+F8nwmINgwXRs
         Qj9qU4vNPUwOiryw2kjvY85X8ZOqZ0x888yG41ESMGYAjbv2fgYj3Z4/tvj+T/V6KymU
         QK8w==
X-Forwarded-Encrypted: i=1; AJvYcCXX8O2v2TLceJye6IhFeZG1A3Wa6WNL3+d/BqMdK+0r3GcNaHSdP50zCo0apTbBM2uPcc5HcHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmgqf2sQv2R9UCJ3LI7+1H9SNbYtxJkOVCGrzoZNKyrcY16khL
	vTVSajnS0xBCPXSQxEi/KqU6rEJ4Yjj/ivTAJqxOuEjSb8QHdyhIhE6nWlCzYDku+9bdm+1viVg
	pmfuPbNTnn2Aj4g==
X-Google-Smtp-Source: AGHT+IFjGBS1OewhxpTi+b0M8y/KRXURzfVXrE7TyQAgG4fiHsq4dPh1ARjDDlzv84hCcBhZTI9UvHqsSHQXXA==
X-Received: from pgbfy11.prod.google.com ([2002:a05:6a02:2a8b:b0:c06:f719:e7b6])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a120:b0:366:5bda:1ebd with SMTP id adf61e73a8af0-3898223c070mr773538637.2.1767655506441;
 Mon, 05 Jan 2026 15:25:06 -0800 (PST)
Date: Mon,  5 Jan 2026 15:25:02 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105232504.3791806-1-joshwash@google.com>
Subject: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Ankit Garg <nktgrg@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Catherine Sullivan <csully@google.com>, 
	Luigi Rizzo <lrizzo@google.com>, Jon Olson <jonolson@google.com>, Sagi Shahar <sagis@google.com>, 
	Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

This series fixes a kernel panic in the GVE driver caused by
out-of-bounds array access when the network stack provides an invalid
TX queue index.

The issue impacts both GQI and DQO queue formats. For both cases, the
driver is updated to validate the queue index and drop the packet if
the index is out of range.

Ankit Garg (2):
  gve: drop packets on invalid queue indices in GQI TX path
  gve: drop packets on invalid queue indices in DQO TX path

 drivers/net/ethernet/google/gve/gve_tx.c     | 12 +++++++++---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c |  9 ++++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.52.0.351.gbe84eed79e-goog



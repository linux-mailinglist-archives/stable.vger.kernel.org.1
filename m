Return-Path: <stable+bounces-108351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9634CA0AD75
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DB73A750D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92F74040;
	Mon, 13 Jan 2025 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0SyIWr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D443AA8;
	Mon, 13 Jan 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735849; cv=none; b=hT7yOynpKNn4uis7wIHBF2mnygu71QdGQizTpmvwjH64Cr8CsTyWEqDqPTes6YyZgPcPpf2ncCyJJmG002eKOE4fDQiJPlsDmmUlCloRYzeNPerIRl9gHqY7UWLYUHKZWFgq7ei+y0+cUOeosGfKRRkISY0fgY9OwKrykhrrMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735849; c=relaxed/simple;
	bh=UIxfsTwqEIBdcQvZJkRmJ4MdX3kwQJLrA5Opg+OvUZY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aXLJYc5wTo1HUM34NGFMSz/+kl+XYN63tXz5b6VeGRPk/GYtMs3/EMHefnAoQE7LA06B4mkDKe7VI0W0Ktj/1bnpFIbnvodFK8Wq1uUpZrm/2LvbAD/OePkA9BFRQK+Ex/je84E4f9w5OQG3J1kCK4rgL55BfphLtiulBDYKzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0SyIWr5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163dc5155fso67771865ad.0;
        Sun, 12 Jan 2025 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736735847; x=1737340647; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/J8PrmwWc4g1mmb+aK/IpQZdIBa7MQhNVsZGDeANEQ=;
        b=Z0SyIWr5Duz4SH8NU6CcMiEk3NCcaWMOB9TC6XoN8I1mXVdDYUtFzPHcF/bagbQzQ4
         +Ws63BLERcY2rr7I2KFtvSSzbI5xzex9pVSEsnkk1tlRR+OMzQqmiqXE540MqIFifMlr
         ENk1PRr8/lziE8xvanA6G0JB6JVyrUxNZWVCG9bk77zqOp8gAYz4qa9POGOgTAUjhbvh
         NMgJWn2VjQX6NBCEZ8FCqc4dQktK4SBuxmeSFeQfrrS4kiW9ZcEijqpYwqV+YRQdYU78
         R5EhUn+DQ6TVMPKxOP/uu3qW631NqCyyHoyDGH+LfLhP/B1ciUcJtu9ZXmTcleEf8BXR
         j59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735847; x=1737340647;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/J8PrmwWc4g1mmb+aK/IpQZdIBa7MQhNVsZGDeANEQ=;
        b=sima3urFlvk/a67h0W0GwChxgkA05FCZUk1xKTL4Ymg5x3BDP38u33CxNMpIKJahze
         XBI1koy+5Fs4ppz/9QmsuY9FeRnx8m1TGY8frxxWIFqqq2I6zTDiDqqcKNSp8INEtZMP
         gbyd+cQrh0vG7GEtXMbVRUH87AdU399uJENYXK6bVeRfcoVzBj++phljVs+7uEpyMJmO
         ramssR61xCVq55tQ767VPaf5r6iGVTu4eh7b/dafE6cNtSUhmuBX4xYhoyVfWuREhc9d
         hyHfSoOp/xY8yEjcpDtBv/yau7AYZP/62aE6a5G/Jo49rsxnliNN/2ExZ5sm8q6ZUfiY
         P88A==
X-Forwarded-Encrypted: i=1; AJvYcCWYn4ok6V9ofrjKTeOIX1GSMPZ85RJ/jpeO+TqOqKGGhC75XIx1EZtpjHtwAEZwjPyUxHKwNgs2@vger.kernel.org, AJvYcCXEFq23Wy8t0sOb+gQ1fsxe+uVxLnCNCnqB/0oalgcyDxxMG+k0UYReoOodQKeojpT/nKHXxxpMdbQYhD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8CLVFoA00WdkKMQFjBJT3VdXK+vDpDDE54R6692tdcHN6AkP
	odVAtXsuEhDUlEw8/4k5mJ4JnI/jtxl/o6xhNpmWiUoGf9CGhspy
X-Gm-Gg: ASbGncs7i4MUjdFRHHXK0mGuA1lLuje8hKms+1eg4wf+wPnBdSsimbdQu9GKUFWFdJn
	OPmVYlpHCifoijIb+mVOQdKxRzxyC6OfNkc+Uxrqjyrng4ThIY/HHafhQhCb0CRzKvQ/8OD6OXm
	y1NFdLugFFhxxhofuZiD8rUMpXPmHb601acQ4USpF2cEE+Y6yN2g2FHdX1zabkfHupnlZ2Rpc1r
	Hc5pCrNvI6Pbkvi8NUpVa3i+Q8GH4yVIqrwL+fpr8mGvCznh4/5rM1WfmKVeN/gZB5KeRHkEdwG
	H6D94SA54iq60RGH+XWDAR/PU9+SZ1pZiw==
X-Google-Smtp-Source: AGHT+IHlQz0mBc3CaxiLiwZpvKmkXsqTAr5MAfY8mkqHMCMWaZlILVtddhKOciiElVdCyFISb1811A==
X-Received: by 2002:a17:902:f545:b0:216:4499:b836 with SMTP id d9443c01a7336-21a83f70dd1mr171648975ad.26.1736735846929;
        Sun, 12 Jan 2025 18:37:26 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22d2dasm44639045ad.172.2025.01.12.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 18:37:26 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 0/2] net/ncsi: fix oem gma command handling and state
 race issue
Date: Mon, 13 Jan 2025 10:34:46 +0800
Message-Id: <20250113-fix-ncsi-mac-v3-0-564c8277eb1d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZ7hGcC/3WMQQrCMBBFr1Jm7UgmqVBceQ/pIqaTdsCkkpSgl
 Nzd2L3L9z/v7ZA5CWe4djskLpJljQ3MqQO32DgzytQYtNIXRUTo5Y3RZcFgHRL3DzP53pAnaMo
 rcfuP3H1svEje1vQ56kX/1j+holHhYAZWlqw2xt7mYOV5dmuAsdb6BYwsO2KoAAAA
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Paul Fertser <fercerpav@gmail.com>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, stable@vger.kernel.org, 
 Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736735843; l=1174;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=UIxfsTwqEIBdcQvZJkRmJ4MdX3kwQJLrA5Opg+OvUZY=;
 b=IRl33z4FT55EDEYU0VPK06IXcDng0gkeBMajy9YeN1eX5bvZcXGuE1dCtrom2rlVluZneT3KH
 cmT1KBuAgn5A5KCysGsSFARoocZjZ+M2FrI3v3M0ARnGxtpoYl5Ta6J
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

We are seeing kernel panic when enabling two NCSI interfaces at same
time. It looks like mutex lock is being used in softirq caused the
issue.

This patch series try to fix oem gma command handling issue by adding a
new state, also fix a potential state handling issue. 

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v3:
- Fix compile error by removing non-exist variable.
- Link to v2: https://lore.kernel.org/r/20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com

Changes in v2:
- Add second patch for fixing state handling issue.
- Link to v1: https://lore.kernel.org/all/20250109145054.30925-1-fercerpav@gmail.com/

---
Cosmo Chou (1):
      net/ncsi: fix state race during channel probe completion

Paul Fertser (1):
      net/ncsi: fix locking in Get MAC Address handling

 net/ncsi/internal.h    |  2 ++
 net/ncsi/ncsi-manage.c | 21 ++++++++++++++++++---
 net/ncsi/ncsi-rsp.c    | 19 ++++++-------------
 3 files changed, 26 insertions(+), 16 deletions(-)
---
base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
change-id: 20250111-fix-ncsi-mac-1e4b3df431f1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>



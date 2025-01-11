Return-Path: <stable+bounces-108263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B33A0A332
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 12:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD99164B93
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B7191F92;
	Sat, 11 Jan 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js41VSjC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FD24B249;
	Sat, 11 Jan 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736593351; cv=none; b=f2kvYyCIz1nML5qHFwLBkp1p2EHPizX6O0j70CwNlf2XwGYT8k3f5M5Kxw+q4EXl5hHXo/p00+JkDY6MKFAb6U5vHf8d2QuApu5StWINds6Xnr3VU7IfQewweSyFhIN+aGMHr1Z7lJUOGJhwpTfMgsXmUlLrYjOrnD/PCxiiaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736593351; c=relaxed/simple;
	bh=2vKcGERmM+rnMEyk9sBu1E9qFIj+oblBDImz1PKw8AM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iKLCXBsoiZqGY6gFAHwPMFv3qvEsO9ecbi3/3hfD7xqQr2+D2VUTiyBze9YtmlX0BcXpFWYtuyyf/Ge2UDB9+1DETrz51nR2rMo4GqAsliZolwJvkGk6wfFt7bR1ZZdexvW07EhH8NtErFpoFTf2BATRWYHBjHzf4kKVmXrJMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js41VSjC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21661be2c2dso46686475ad.1;
        Sat, 11 Jan 2025 03:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736593350; x=1737198150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrVCV9b6zJgZJNvFo9Xxuzg1AHjgJdoB3vUsspLLPR4=;
        b=js41VSjC6go+AT+a4ox+o3FRTQ9z7DaHVMbNlvgFeB4aeLEJTMhyCtjU5+i+YJselI
         PZrUpWfv7iTYPtV6gtTKXSGnGZ1nbNxp2JGv5//QTboLeQnxf9KYqQ5wVPro/dwkc/mv
         Y01xbmyhA5Ypl+jak60lsODz1XP35FhteP4PBIJR2PEz3EEzPBckaHESO3+jzCsyvDqR
         UKrnha07YKmnyV6IglulCgmNNSmVh63Qd5XFauQcpt4TONoI3JLCLBN+051Fg3wVyadJ
         ElghATKdRAE/BjQOwiw79uVKXTk3xVfeIlCA899rz8YzYJgrWnylZXfxJdc70HIsi0Li
         VoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736593350; x=1737198150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrVCV9b6zJgZJNvFo9Xxuzg1AHjgJdoB3vUsspLLPR4=;
        b=DehnnPBaVrErGwMdk5wC5/HQzKHpVASIIc2+hzW6GHCk7SqQEGJycSD1Jk20y48v+F
         XrARzhbbSF7S3ImciCNhttO2nuZ+Wok3LY/bk91taLfXCbFBI/PUEQcbJ990rsLyFg/+
         cJlZKqIlvuWokJ4dT1LsL3Q1cInISuTlAhAPd/dhaq3GTH13oskTEvDQFG6YZ6l2IlKt
         Y9/rOJOb5u+G5vjVPjL24nbwNa28eCDmnO/5xPmW3elD70fFR0dwbtI/IM4gLAVmneZQ
         7w8K2cqQJC5u6utA5cS8RSiluCE1jiGJOSqSKo0p81RrL95PwogwlJ8KSNE9GoPMEdWu
         y9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEXNuHOFukl+2ttVceHXEclLhw01tMj7TUsODEY5Qbsm034H1uoNocmgXk/HPiMJN0Du9+NZMdNmImvjI=@vger.kernel.org, AJvYcCXxTXAm6bxRi1dPg1liLntMYLHZVXt8SZlReqVeoS6ZaU406HlCUBn9m+o51v4wqlU90ku4Bru9@vger.kernel.org
X-Gm-Message-State: AOJu0YwWobgj3j3kF2cpOGvF+hp8XfawSzMqnZy49KJ2Q5OB+ngphxVL
	895ZdqvBt1Ss25ITD64gyfFZik6ja/iHOJxJzvV63l0ErcqpDMkZ
X-Gm-Gg: ASbGncsrTCjsMZwgfHHGQ2EQq/h6VkRWIaxL3gwxdvILhpPRlVKU61vK/Y66zJ+9E5O
	EbgCfIOSTXHxabQpCcoWYSL0wdFimB4tO4A9yzkT1oceUVan4bUYgTUtup0p00ew89dL09/6qRh
	Dn/9CBVddVmUmf4FxoSJIk78RFa/fxHTSMpDj6EgDJgesu6m9iU7CFGf2mkshLQF+PLx8MAriSV
	Hm2vbQ9pj7KjV6LMOasHOt41k6bPonD0VZ5LXwDrvp2QCasMk+r4411PsHWRRk5unFbNm/w0v+K
	2E9+n3alyRG4qFKeUpl/qXRoQPyLOku22w==
X-Google-Smtp-Source: AGHT+IFKBMm49fx66Z6VI2zKjfj0BJley+mXuBPcnuROVQPn1S6GbppUHHXckWO2qTQTp2kQtrmuAA==
X-Received: by 2002:a05:6a20:c887:b0:1db:ff9c:6f3a with SMTP id adf61e73a8af0-1e88d320c3fmr20881804637.42.1736593349654;
        Sat, 11 Jan 2025 03:02:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e5csm2953826b3a.143.2025.01.11.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 03:02:29 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] net/ncsi: fix oem gma command handling and state
 race issue
Date: Sat, 11 Jan 2025 18:59:42 +0800
Message-Id: <20250111-fix-ncsi-mac-v2-0-838e0a1a233a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5PgmcC/x2MQQqAIBAAvxJ7bsFVu/SV6GC61h6yUIhA/HvSc
 RhmKhTOwgXmoULmR4pcqYMeB/CHSzujhM6glZ4UEWGUF5MvgqfzSGw3E6I1FAl6cmfu/t8ta2s
 fRo7fz14AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736593346; l=928;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=2vKcGERmM+rnMEyk9sBu1E9qFIj+oblBDImz1PKw8AM=;
 b=DemqqyhpEEArEjPiFwz6DuVOhulHspPlM0hURdDotYTMQmXqIjJ7EztPWCoILxOfffiBtGlI9
 FcgEGD1YDLgCk2c1oEZK/j0agvbbJzKYGPqTtIvPPttxz/w2A4EXDu7
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

We are seeing kernel panic when enabling two NCSI interfaces at same
time. It looks like mutex lock is being used in softirq caused the
issue.

This patch series try to fix oem gma command handling issue by adding a
new state, also fix a potential state handling issue. 

v1: https://lore.kernel.org/all/20250109145054.30925-1-fercerpav@gmail.com/

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
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



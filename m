Return-Path: <stable+bounces-8602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B155C81EE29
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BE21C20D1A
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2F2C872;
	Wed, 27 Dec 2023 10:26:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629E2C867
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so1522113b3a.1
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672787; x=1704277587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Efkga04RPKL6t9PTCfiTFjsqRk3mWgmhgUx4vAYEGi4=;
        b=NzD8oqDq/fLJmJeGM897hNaClqc4BiZjjxHoM2YWog3Ow2xx2p45U07k518V+uMV7l
         NNBIU5lUn+3eTflCfEaXR9W1t0QDQSpW9JOuGctLk1Ga4NIUs9OlSpGjwGo7Xh/FP5ol
         1Ky97zSuhUh8rf6/kOhFDgUVYfxMBojMPpwU3EJGFb+xA38HGK9cqIMPm92MfhX6Eohl
         Vc8eDvgrquM3zZaF8Fv8lDatnCtbuYvQAUQF+yP177xk9oycdX4+ZBdIPismKrS71CxW
         fxBVgzoJhPL3IN6r97eYVWUIrn+rDgz4EQstOia4g5EYnQedKD3PzMc/mx2oZ55EXWpw
         Kp7A==
X-Gm-Message-State: AOJu0YxdR27NUQL24q8CL8xDde5/wn9Ory6yDzhFl+ByArJqvaRItmvH
	sMI/wb9ovfhgCFqGt4mcEnscUoBBftE=
X-Google-Smtp-Source: AGHT+IGrtYcMfmlOcqI2onIB872GHZ7kPQqlgLVA6LdpEmz7jFgEvB3nxGLrzTpDnolNavl/PQSXng==
X-Received: by 2002:a05:6a20:244b:b0:196:31f0:10de with SMTP id t11-20020a056a20244b00b0019631f010demr137647pzc.14.1703672786661;
        Wed, 27 Dec 2023 02:26:26 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:26 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 5.15.y 0/8] Additional ksmbd backport patches for linux-5.15.y
Date: Wed, 27 Dec 2023 19:25:57 +0900
Message-Id: <20231227102605.4766-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are backport patches to support directory(v2) lease and
additional bug fixes for linux-5.15.y.
note that 0001 patch add a dependency on cifs ARC4 omitted from
backporting commit f9929ef6a2a5("ksmbd: add support for key exchange").

Namjae Jeon (8):
  ksmbd: have a dependency on cifs ARC4
  ksmbd: set epoch in create context v2 lease
  ksmbd: set v2 lease capability
  ksmbd: downgrade RWH lease caching state to RH for directory
  ksmbd: send v2 lease break notification for directory
  ksmbd: lazy v2 lease break on smb2_write()
  ksmbd: avoid duplicate opinfo_put() call on error of
    smb21_lease_break_ack()
  ksmbd: fix wrong allocation size update in smb2_open()

 fs/Kconfig           |   4 +-
 fs/ksmbd/oplock.c    | 115 ++++++++++++++++++++++++++++++++++++++-----
 fs/ksmbd/oplock.h    |   8 ++-
 fs/ksmbd/smb2ops.c   |   9 ++--
 fs/ksmbd/smb2pdu.c   |  61 +++++++++++++----------
 fs/ksmbd/smb2pdu.h   |   1 +
 fs/ksmbd/vfs.c       |   3 ++
 fs/ksmbd/vfs_cache.c |  13 ++++-
 fs/ksmbd/vfs_cache.h |   3 ++
 9 files changed, 171 insertions(+), 46 deletions(-)

-- 
2.25.1



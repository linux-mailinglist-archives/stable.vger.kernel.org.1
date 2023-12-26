Return-Path: <stable+bounces-8575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A479D81E6FB
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F40B2142A
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F84E1A9;
	Tue, 26 Dec 2023 10:54:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6164E1A1
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3357244a12.0
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588040; x=1704192840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzX+tvOgur4p7obq3Xs7WubZSc0BClxUaP8BUR7u2hE=;
        b=WLCs7xcOZiuh0EDEspZZB8ouyoNCU6s/aNUlW0S5FlwAtYyzub4/u/OYojSqlMVa8X
         VjMEEqExI52Q4D5yRYv4WjqcEDzHxA0wiRcZsVz5/5VAZHHe22k39YJvHOafy2xaPiWK
         EYvhSGWXW+6kcTtL6R2ps/DYpiDPkbQk9vhz41zBPdnY/Nl77DZ9YmGzQOJBtQT/SHNx
         7OW4LAxkmf3Hjf/Br2tPV//x4IBI7ZnBpUr3ePT/Pqm4ibXlRMnJ6bUAm//Adhp+Z+yx
         +9Q5KlTxIBb/WeZ5H4VFXTugHVDyanPZlyUcfVCKEA9jABfy9whP9kWhvVSGAzTNaTrs
         edhg==
X-Gm-Message-State: AOJu0YwObykKt7l7NiQM+tLi3UwzQbRG/9Q94hVYGk4qSCmakHjRW+WC
	vhDfS/1AsUX+ROnKv8DM0mxzwjaK8A8=
X-Google-Smtp-Source: AGHT+IGBMk7ddV0qetYDIIsXjs/zOI1URGmFRN2gI9AI0huSc9dca4OBtKIRMyGcWb60pZDOqGwVGQ==
X-Received: by 2002:a05:6a20:b982:b0:190:354d:f90b with SMTP id ff2-20020a056a20b98200b00190354df90bmr6732292pzb.114.1703588040097;
        Tue, 26 Dec 2023 02:54:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:53:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 0/8] Additional ksmbd backport patches for linux-5.15.y
Date: Tue, 26 Dec 2023 19:53:25 +0900
Message-Id: <20231226105333.5150-1-linkinjeon@kernel.org>
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

Namjae Jeon (8):
  ksmbd: add support for key exchange
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



Return-Path: <stable+bounces-227377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD7FOtJSvGkXwwIAu9opvQ
	(envelope-from <stable+bounces-227377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:47:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E02D1C87
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E89C309EE05
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD430E847;
	Thu, 19 Mar 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOHupTOW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582872356C6
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949646; cv=none; b=UU4Vu9jvXc203q1HkOBz24uMsGOdy6ERVEgJlgHuFNin8nT/tvZSi0LaVAGGEcUcUNSmeBVgYjvPDegtJQ3Fbq/pAKTwgtlAMlW1E2swFmK56NM3h7rPED894PKJKVXM7k8zrui/I1Ss2SxTIkxz1frsYQc6aDH504Fw2attTtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949646; c=relaxed/simple;
	bh=nyiZdk69JHyRMSxsgfCfmEEAuMmh5HcweuE0na5MKlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L8CcQTdG/wBRFOtsCZ/GUQcuSwd/B1d/bddJxm1DP2K19z1vWi9TK3GrQEUVoVEtCrjFgBUevQIcty74P22wxumFqkYYtmFSHjCBDanPF1IjS6ZIe3TaveWDfKzJjYDrlCl4/Pef76rG3E74NCuNfI+jG/QeXoE50CJZc6936uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOHupTOW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8296dabef74so928507b3a.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773949645; x=1774554445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=lOHupTOW2CZmjz9ZssNobBmJa9n5wVBwHhoX1Vbfe3vIoILrFRpBbwmtKtnOVMREJv
         gF8TPL/UpW8Q2ZjAWxJWojuzhHJjCtbeBEoZzXzAi+Y+D68ejyodU3GDGEOawbexUxQ2
         ++4WM+CW29D583OAuo9tWPIQnPYNdAH/Q71z6o2P9WQySuDOOSDk00uzxeWkNGiujuQz
         xZ7ai2FTPYgsEpwKGVEZcvW4A8HkuOX6bjXOwuFgp7PIrfP/mRyn/EpgoxmMjktOE3fV
         P9sD0WEse8pw0O1dOxpBXFeHTo0iiqfFmtr0yGQ8SJwkZ7UYYAwtRciG44G01ZKUe3Zk
         edMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773949645; x=1774554445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKET5NPA5ASmk1jkTd7kXsD4vcOiadP7Y/oX3DOtA4E=;
        b=AtrCzSeFq00LzqF90ubWdsjtNx3m/fm2YwdFheJ5x5hUjE9kHVT6qLnZ6Scb3ShLoD
         B3r7WURKcPGJSAbMDiJMfi7vXbeX7SlrtIgBDYMX01zxR63RPUsfvy+iLHSOx/j7e6gO
         g+38m9TpjdyHfDL+y/aVm1HEfUfXIl1GApivFivPqpmgg3TJOvQdlymumdkK9AdCnlg9
         538grBK9R18gk8oxOgSJNBU/GLCVzVv5ypAM78EtdY99GwVPLbQFhOxLUXNhiAGE0lG9
         VzwJaiKC//hWvNWtuW6wh9f8f8Q3vbLTP77vDGSzdPIILMkDny/er85WWQTch4URPjjh
         kZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5A/qyX7eXxFWKHtqhggRZbfclu/yAuyP7hXfl3m6LCVlxGxukL+dDuc1jTQugGIn6zApTz6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzig3DYHt173Hqm/DYZLDDrQoiqc2isEP5robZJlcHlssO4zhy4
	NGdj6wbIfN7QDIevbUOMzqP6BfamyKoDBk9wNwspMJq58fnlwiO1urWehUo+0A==
X-Gm-Gg: ATEYQzzCc3NeAEKl5p+xNDBAWLtK/5MUIMbF0YgdMUit4XHkpucD86le5C3H+bZlvYd
	BSv2IYvPeNhQ25ZzlRDpeQ0F+YJNBzjT0HuFuiiTx6dZwnw4SDxIRvHQQJPRZaYyndSPYt4BEK0
	wb/Y3bM6WRp3AwvGkXBLO8aTxtwvLtORh2m/LG79xUZwTATZA5gMZswk2TUb0PpSVq7wRYX1GKd
	IOxhKo1FF4Kqy2nmzBt0kGb0dICoV5ysuXyZbUaQWJ1EaNTm/CDSO+OqbvyDa0NUFbjYpGPG56A
	rxB1vIWyYwgQPi2M1hBCJ1EdGamyo47WuK3w64xKZHDeeFvJtdP55MbMtDku8nEvwELZeOa/sJg
	aStclgUZldhprPfsdDfii+35fBmAwVwa7RVGzu31VJWYd35OrxxI7DPpc4l2PQgSP4Sd2rRRFoP
	jj7I0hf+MyqRmadjCwqA==
X-Received: by 2002:a05:6a00:2d96:b0:82a:768c:9a49 with SMTP id d2e1a72fcca58-82a8c32727cmr360003b3a.42.1773949644550;
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da7besm11132b3a.49.2026.03.19.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:47:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/1] writeback: don't block sync(2) for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 12:45:39 -0700
Message-ID: <20260319194540.3463371-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227377-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.926];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 546E02D1C87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260318225604.71545-1-joannelkoong@gmail.com/
v1 -> v2:
* Still kick off flusher threads for writeback for SB_I_NO_DATA_INTEGRITY,
  instead of skipping that entirely (Jan)
* Improve commit message (me)

Joanne Koong (1):
  writeback: don't block sync(2) for filesystems with no data integrity
    guarantees

 fs/fs-writeback.c              |  7 +------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 fs/sync.c                      |  7 ++++++-
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 6 files changed, 10 insertions(+), 21 deletions(-)

-- 
2.52.0



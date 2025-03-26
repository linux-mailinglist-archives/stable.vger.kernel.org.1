Return-Path: <stable+bounces-126753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86180A71B80
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B381742E1
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B921F4E56;
	Wed, 26 Mar 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="J5CbCd7I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292CE1F471D
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005056; cv=none; b=BmlKXciJR1o7bCgDut4AK1KjhoI9l+6rPb2O7C1hvC9ZPz0urqE2JQfU+g+BQ3IN8oTMrqCre6XeJbQ3ZV9jhM9Wa2AGD+bjo+9Z4Hjn97S5qK4x7Dm/f0ssnZfIOPm6YDnnr15w2kcF52faZOtGclYgrUUii8K3qq7vb0OQRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005056; c=relaxed/simple;
	bh=oqYKM1ZpqC7RtfF7IzC0cixXHyD/NT9TgSDoB1yKb90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aohzGmj1DlCqf6L3cveGRkUBwYBjjITl19TrfO9kSE8tIH8N86T77hGT8PC+JyLEPycD7FpiD1g1KJBk9i2lm5k2LqNphRd+sDAECxyDOvY6QmvNHqboavqM5CsOsr0LUsqzQuXSU2FuCR1cy3Q2WITRE1JelGdiB+L5vqGTAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=J5CbCd7I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224019ad9edso1225095ad.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743005054; x=1743609854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=J5CbCd7IhHSd5Doa2D3yEmNf2yBrzCT9957Q1N/HEdy+tC6KpSCHIWZLnF5XyAstxb
         jG4XXMbGvCCdv9p97UmuLfsTnPMVonYwr5lPd+77pxWEhV0bJa89bJVzLN0gtn8vWHY3
         KhIQRzM56xdA5BQnMWiCSiwDohx6qDIHCwv9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005054; x=1743609854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V92Mcu6ROGqDUYrr0Vu3d5f14OfoLPIUJ7IhtsUxhlQ=;
        b=nBgjM6omSTbsHrcYtxcYl+I87+pyT0NFxJwRc2VhEto/P2AH6xz1aoakap8IO2wqFC
         P2/UPytcpuv+1uMqY0voXJgfLmBKVg/04VTNo3Rpi1b0llskxFT1N/xSh2g53FlazatP
         4A64TCNQGPU/GiaXXpn9dYlhxC2St6mO6ZsdNLFHFr5K+d8/mamo5wyzZFYZe+kfLILL
         qboN3bDjwh3zKjZsueqSuhTnNsjcJdcA+/Am0G6eMR2zlgoh4UhJeVTFSr3BV/3Ah6Th
         xAKLOI+141JLRWYMU7KtgDKzfLTKukozxvVpXE8TatpyWvOt/q601sdn36HdzUdORa9/
         C+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWVpKN+CB248TPoL3D7gW1vSbBMon0T6X3cqkVdiHc4AOWRhjd0S4f/aPw7DarA3LSqWR6gx6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNx4NHqifRNeNIEvRrMyjxNOu04u0qC0q5khBzQESpM9Op0+0
	a+XKwJUMtaVM005JTQf1pv2dUULWQ56VkV45GzmBtabT6Zcl9WiAqq4CFRw7m3w=
X-Gm-Gg: ASbGncvvwR44p45yQmzuWVp3G19KaWrBFEmvcHxMLx2uJwhIJA8A5/hSMhZLW+4+Ghm
	99A32oxkC83MMMM028R+0xOIPRwjQtxT8RMLCq9dGIxZ7FJD4ofW+lcWvIHj9+9UsAudXboDkyX
	ZT3+xNl1yrzn0+dNwTy+mPJKo2RM8lICfnZV3lm966d7t/HSe0vemZUxCqrV3aFKGkfwPL1kM7A
	3YIhCbymt4VWkZaPIX3ZUUUPaMfOUbljU3qDO9FhctIr9f90gB/0hDztH53UutgzA9DOOQWT1nb
	/btLBtVx59Dhvf/XQqY0lc8FDww5sBAEz8RqnmBiFPhVTGim1lB0OqDbaS4B0GRsx4uvLLdtYdF
	VnJdB
X-Google-Smtp-Source: AGHT+IHW8xu1XUEic/d8MMjR4RQnRgGFxBNA9gZny8EZQSOeF0ZVLLhc++6oIw8DXemWvzAssm4PLg==
X-Received: by 2002:a05:6a00:180b:b0:736:6d4d:ffa6 with SMTP id d2e1a72fcca58-739610a4c99mr141933b3a.15.1743005054274;
        Wed, 26 Mar 2025 09:04:14 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73907b36bfasm12217947b3a.2.2025.03.26.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:04:13 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 6.13] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Date: Wed, 26 Mar 2025 16:03:51 +0000
Message-ID: <20250326160351.612359-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the io-uring fixed buffer cmd flag is silently dismissed,
even though it does not work. This patch returns an error when the flag
is set, making it clear that operation is not supported.

Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: stable@vger.kernel.org
Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4d9305fa37a8..98d99f2f7926 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4906,6 +4906,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		ret = -EPERM;
 		goto out_acct;
 	}
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		ret = -EOPNOTSUPP;
+		goto out_acct;
+	}
+
 	file = cmd->file;
 	inode = BTRFS_I(file->f_inode);
 	fs_info = inode->root->fs_info;
-- 
2.43.0



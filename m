Return-Path: <stable+bounces-203423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B709CDEB3D
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C1C300ACF7
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68622319879;
	Fri, 26 Dec 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.b="a2PDBHUx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C468280325
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766752522; cv=none; b=Lm35QF7OTP9xBH2Uadm3XwbjaEWGN5GhKlTyzJFGy4XCXEe5TLD3PSUUTYwSU8dmTea/UzVspbA+l8pFjYHW4scsZ+uGOsqcblhGBGLNSqmcD57KKoDe2WnIE+3mVB6vYkLqB+1JHSEmai5VKKpnOcOiDDdtjudgIoeiSQ/6nGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766752522; c=relaxed/simple;
	bh=0rJ95WY4LkO1lS96o4vxvfUz6Rz7lIC7caKrw4+SpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVxmv8FV2KrxCrnPgQb14U7KlS6ujXEvEGheLSJrMzCNgwU0+fIWpfyHmag0X+h3MkVri1snx+3vBLyu0dGJbyC6mWEyJ0cZ+Z34O2sSZMdN/FvZdsblsPMuWxn/MloqmpDZhXwY8gTG522iA7ovCI6AaAGP2G6tCml6Kgjz0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io; spf=pass smtp.mailfrom=itoolabs.com; dkim=pass (2048-bit key) header.d=itoolabs-com.20230601.gappssmtp.com header.i=@itoolabs-com.20230601.gappssmtp.com header.b=a2PDBHUx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=digitaltide.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itoolabs.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47774d3536dso56672815e9.0
        for <stable@vger.kernel.org>; Fri, 26 Dec 2025 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itoolabs-com.20230601.gappssmtp.com; s=20230601; t=1766752517; x=1767357317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6tRdcuP0wqKPHELS2CPAX3klPxKMBxEEEHLvH3w9ao=;
        b=a2PDBHUxtKLEZJWp1kq+GQjQALJpdiAewwf+3uhkn+pESggN3cH631r+4tg7xOk74r
         KdbQU1YFjGvnDVc/lUIomXONO7l4j5F7ebfk7gvGALKp6kfvFPziT3DoaUoQZtcJP7+4
         0SfPVvCRRErnM8PU1n81W6hbNOokhUzcwICcyppjlJ/Uwgkcpg2ZKZlkD5LKEajayrpq
         MkH07NwJ+122DH0u0IvRy7VV14Kc7rf6BgO4Nb3Jl+mQqcELatGBlDWP9H9Ey5DhZuS/
         KhEuaSHAGRffN00sKLmw89TwWnFoMfGwpvp+/iCZMJnIJf3p6UCMhy6AhLphXX7gbw+x
         jwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766752517; x=1767357317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6tRdcuP0wqKPHELS2CPAX3klPxKMBxEEEHLvH3w9ao=;
        b=J/kZTFQyac4jOgEZ0o58Wda+sfoWOtE0j8q+7nfybvrdmfIuiH+J1qs1wag9wDGwai
         Avry01O6b9NNJaC7JHtCn5GyxzTBzE9RcdGUBZ0mskp+R8xzxqvb2SQtlSjm+26+Olni
         O069/qV3Es30bTDyXA7Rdhr+Y09uk7fnYnsSTqaupGIhNlPmbTcWh7OmMJjUfHYJdnr3
         +2CGRn0t5w5uD1rRhCRoScCBZY78P3g58B26uxcLIzP2jY3HEMbd9/nBxLRZEOrajwAp
         x7KRgPLDb1aE7JT/lC1fsuiSsyd+E2CyV4jkq3ercZ2Ug/4tdl85yydg0HrKGyWioWDH
         59Lw==
X-Gm-Message-State: AOJu0Yw50oqan8hTAyKydVmcY/pT+6cmNX6Jax8eszej02Z9bw/qloGT
	qmSLWEpRohAJY/Tl9/O9e6/cfZpkWfm7R66fmT/gDravZ4YRHBxlRUmreddzIrFPaoX8b4C5bM3
	IizqM
X-Gm-Gg: AY/fxX5mRrHxNCyjVC88sUsBKO4cDUGgnwDWK2GT1fBWBSZ+09ll3cMOow5tKccUMS4
	IdJ4p3tUUylSCGxIpRm7FrG4K4xFLISBbmKFTJCM2PFbLvsQFJyhKWwSNOTFtbCxpg0DNM384nV
	3RBW2TxJkGuVUm8pW2Za7eWKBBZzZo40zcfHrCxFjU7Izj8ETDKL6veUd19nw6Q4NF3RSH9ltj2
	PlxOM69XBuGrU1JQ3wACKQUhi56tyrUR3ZOuC35reEKpR41yNX9l+QT+OGXrgnfjR0V7OxQVDOo
	bMZ+svWbKskIS64U3wCe0VrXap8ViU7itLob1vBog503B9YZKKKBzbPR3+q3oauw1VwYCFij+Uc
	gGNLS2vX2GIJN8gPIzINR0TnKYTk/PCnlteVwoKcZaS2Ol9ju3xZMS2LDyRJOiQoisRza50laO0
	mD54q5Idc=
X-Google-Smtp-Source: AGHT+IGpcB6fzs67bzB42F3nEfa7jC6d98MoCdt0ERV86bPdMf/lMarUyr6A03ZLX3YHQkzarY7wEw==
X-Received: by 2002:a7b:c454:0:b0:477:7588:c8cc with SMTP id 5b1f17b1804b1-47be29adacbmr184783165e9.7.1766752517546;
        Fri, 26 Dec 2025 04:35:17 -0800 (PST)
Received: from gamestation ([188.26.196.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272e46fsm432931215e9.4.2025.12.26.04.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 04:35:17 -0800 (PST)
From: =?UTF-8?q?Aleks=C3=A9i=20Naid=C3=A9nov?= <an@digitaltide.io>
To: stable@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	xiang@kernel.org
Subject: [REGRESSION] erofs: new file-backed stacking limit breaks container overlay use case in 6.12.63
Date: Fri, 26 Dec 2025 13:34:37 +0100
Message-ID: <20251226123453.5914-1-an@digitaltide.io>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I am reporting a regression in the 6.12 stable series related to EROFS file-backed mounts.

After updating from Linux 6.12.62 to 6.12.63, a previously working setup using OSTree-backed 
composefs mounts as Podman rootfs no longer works.

The regression appears to be caused by the following commit:

    34447aeedbaea8f9aad3da5b07030a1c0e124639 ("erofs: limit the level of fs stacking for file-backed mounts")
    (backport of upstream commit d53cd891f0e4311889349fff3a784dc552f814b9)

## Setup description

We use OSTree to materialize filesystem trees, which are mounted via composefs (EROFS + overlayfs) 
as a read-only filesystem. This mounted composefs tree is then used as a Podman rootfs, with 
Podman mounting a writable overlayfs on top for each container.

This setup worked correctly on Linux 6.12.62 and earlier.

In short, the stacking looks like:

  EROFS (file-backed)
    -> composefs (EROFS + overlayfs with ostree repo as datadir, read-only)
        -> Podman rootfs overlays (RW upperdir)

There is no recursive or self-stacking of EROFS.

## Working case (6.12.62)

The composefs mount exists and Podman can successfully start a container using it as rootfs.

Example composefs mount:

    ❯ mount | grep a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c
    a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c on /home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c type overlay (ro,noatime,lowerdir+=/proc/self/fd/10,datadir+=/proc/self/fd/7,redirect_dir=on,metacopy=on)

(lowedir is a handle for the erofs file-backed mount, datadir is a handle for the ostree 
repository objects directory)

Running Podman:

    ❯ podman run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l
    root@d691e785bba3:/# uname -a
    Linux d691e785bba3 6.12.62 #1-NixOS SMP PREEMPT_DYNAMIC Fri Dec 12 17:37:22 UTC 2025 x86_64 GNU/Linux
    root@d691e785bba3:/# 

(succeed)

## Failing case (6.12.63)

After upgrading to 6.12.63, the same command fails when Podman tries to create the writable overlay 
on top of the composefs mount.

Error:

    ❯ podman run --rm -it --rootfs $HOME/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c:O bash -l    
    Error: rootfs-overlay: creating overlay failed "/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c" from native overlay: mount overlay:/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/merge, flags: 0x4, data: lowerdir=/home/growler/.local/share/containers/ostree/a31550cc69eef0e3227fa700623250592711fdfd51b5403a74288b55e89e7e8c,upperdir=/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/upper,workdir=/home/growler/.local/share/containers/storage/overlay-containers/a0851294d6b5b18062d4f5316032ee84d7bae700ea7d12c5be949d9e1999b0a1/rootfs/work,userxattr: invalid argument
    ❯ uname -a
    Linux ci-node-09 6.12.63 #1-NixOS SMP PREEMPT_DYNAMIC Thu Dec 18 12:55:23 UTC 2025 x86_64 GNU/Linux

## Expected behavior

Using a composefs (EROFS + overlayfs) read-only mount as the lowerdir for a container rootfs overlay 
should continue to work as it did in 6.12.62.

## Actual behavior

Overlayfs mounting fails with EINVAL when stacking on top of the composefs mount backed by EROFS.

## Notes

The setup does not involve recursive EROFS mounting or unbounded stacking depth. It appears the new stacking 
limit rejects this valid and previously supported container use case.

Please let me know if further details or testing would be helpful.

Thank you,
-- 
 Alekséi Nadénov




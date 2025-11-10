Return-Path: <stable+bounces-192885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE56AC44CF7
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 03:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 951014E35D2
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 02:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138BD237163;
	Mon, 10 Nov 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Zy5kTuaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776218C008
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743546; cv=none; b=OJgRUdfj/C4/6kuRMCybp0MVUmh27HZeC8BSQzFhAXbkKzpjk9e6ni5ypNEyqqVcmeCxSrRA5LhTRQXoMJXW9o+Nt65BKWt/3iiRYugSdm/dht3FwMHBTN3byc8uO1/Kxj8/XiH8Gm4zTtLztyIbR6H9IB2ufNbu8XAIXSsFYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743546; c=relaxed/simple;
	bh=l/zuH8vAN+y7QLXqaOHwYwFiXsmJRDF3kXgiJk6x96I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=eDcMLtiHy/51aLRTYbKXaSYywwF0vzAxqitrxwY5egY9uh5N76eJoHCjM4VcE6XwM5cL2N1TplruNlTaXs4BEmoAoNER6A5tIJUS6UoziH1+FjDef87jIv6FizFOs0F7frOa6AjPRoNGF8HRJsdAf0AtNQ6TNXYYUI2MPx0NgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Zy5kTuaB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550eff972eso1438952a12.3
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1762743544; x=1763348344; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFpyqRz/6BHaZgu5ojhxFNT0JjUtt/So2MNHPPblb24=;
        b=Zy5kTuaB6ehYq8WuU/3F88/NegLKmzsCkjoVy7iCisZuU/fchoa4S8kMGUQf6LO0J0
         rtrmy/NY3eE7QGVYv9VRXtF24HNSs799NjztvFiHGsICpRZ4PTEFsFkDeP7koq3f+mKG
         fVx3GK49nkDKVmv8zG18c77BCJ2/hdspBX8TdaJi6+PinVfU8H6HhrCe+FyAj6HKsfC/
         BYdJ1aJ9iU32EPOdzQxwlOdpiOLoMKRt0TQegl4PNPUwd+XOWHJZCGpJUTOfjYgsqIpK
         R41YBxc0smR84nfLEruUjnjtLLRTVelvumGJ1EENaDg3XQ++veOGqneT+OpLLZTyXdYn
         Dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762743544; x=1763348344;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFpyqRz/6BHaZgu5ojhxFNT0JjUtt/So2MNHPPblb24=;
        b=QFX2+yTL/oU7p4meo3wHIW2SZtDhvMp30QPsuc1eIPf7QXfxSnMYVeajG+I7soDylu
         TcDuvvX8x38wkiqLoAIw1YtUxsLdfZPCGUisMPcR5RMXXy6bfyORcKucPcvRUDzFnjG4
         xDWYKPW6HzvJvc+wJ6HXcYa05R0sXyNy/Gx9wbnWnaXXUtrXQxhA1UaZG7Tk0ZRX7ynu
         YCiHEcXc3Q5jU/Z+yw27oOr01UxN36/SDdykvTlkkZtAr6eifcsHCeL+foGNtOZiuPT/
         K8wwV8pNvqsdLqKNZzIOYHkNUzh1w7+t9RyAFGs0k1GVFe3OMQ/hMpq9QMYjy3YPle/t
         8w4A==
X-Forwarded-Encrypted: i=1; AJvYcCUq5rDoVWKbzwHZnuMeSO0W4ykl+4rWxvvcuqPK1F3yxmCI6SBylV/IsBTkz6a6J6tq9TREIbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8JYNtnZHKnGxxMxyqF+8wkktoVVesa+Nw+vAXnMHra3SE1Lo
	Lj/Ko1+hLrrwxa8ElwoTqgiLExktPuPZZY3MrH/VCX/WSUi/mrXJiIKGHEh//n8noVUAfw8Ap7q
	EJEiZ
X-Gm-Gg: ASbGncsdzs/jLT6vrNlx0cumKjqNxXmlM4pgVHv3qM19nh9BLZZ/WmIBIy70gZMKX69
	jh0+PHkaytuzb9IrGodx0fMQ27M4G1GoBmiEp64Gby9XZ0TFwQEUo3lzbvkWed/vrrpLmUstnyC
	VN5hdtJOFexvDgrwENWymav4QFhe/8uqq9qxcvhGcBknJsVq3jwWETj+hQd4SYHNdmZOd7H6oPy
	R5BW5Cdg26CeA4gITWPSpRTcj7hAesp8oLInD89JUmLcpokSKcmhLZK2j/yLnMSQICClvJZvcZy
	mG/Pjvb1O10A1w3gVuCmTbrz8dx3Gn+UHmY8w5gPNkM0ibbftln8FYkrT1OALCp1pm9sXWqz2wk
	I+zpxGV6pWrM9o9TRpQo6Hiy2bcQCB5T1h7bEsLNrZMfpjMejYg6xbjG+IxW+r2jUmINgrACejk
	zNynzk
X-Google-Smtp-Source: AGHT+IEwAJej/jHAJFiLTOsBSr881ieRpXv7u4FwU6R6tz2FQqeSJ2TEVA3eOWoO3Xj+eqFPfafhRQ==
X-Received: by 2002:a17:902:d2c5:b0:297:dd7f:f1e0 with SMTP id d9443c01a7336-297e56f8ef5mr91414595ad.43.1762743544412;
        Sun, 09 Nov 2025 18:59:04 -0800 (PST)
Received: from efdf33580483 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm126481795ad.102.2025.11.09.18.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 18:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) field designator 'cells'
 does not
 refer to any field in type 'cons...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 10 Nov 2025 02:59:03 -0000
Message-ID: <176274354330.6253.4780490220267846488@efdf33580483>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 field designator 'cells' does not refer to any field in type 'const struct tegra_fuse_soc' in drivers/soc/tegra/fuse/fuse-tegra30.o (drivers/soc/tegra/fuse/fuse-tegra30.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:557d8aefb2cd31b889c264fe3d70e3de37098cdf
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  06c4dcc61972453a17212bd1c6f2cb3f29246b5b



Log excerpt:
=====================================================
drivers/soc/tegra/fuse/fuse-tegra30.c:250:3: error: field designator 'cells' does not refer to any field in type 'const struct tegra_fuse_soc'
  250 |         .cells = tegra114_fuse_cells,
      |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/soc/tegra/fuse/fuse-tegra30.c:251:3: error: field designator 'num_cells' does not refer to any field in type 'const struct tegra_fuse_soc'
  251 |         .num_cells = ARRAY_SIZE(tegra114_fuse_cells),
      |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-allmodconfig-69114b0cf21f07610dda7980/.config
- dashboard: https://d.kernelci.org/build/maestro:69114b0cf21f07610dda7980

## multi_v7_defconfig on (arm):
- compiler: clang-17
- config: https://files.kernelci.org/kbuild-clang-17-arm-69114b09f21f07610dda797d/.config
- dashboard: https://d.kernelci.org/build/maestro:69114b09f21f07610dda797d


#kernelci issue maestro:557d8aefb2cd31b889c264fe3d70e3de37098cdf

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org


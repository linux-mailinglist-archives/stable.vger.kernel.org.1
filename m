Return-Path: <stable+bounces-11857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A780F830A02
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945121C22728
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2FA21A13;
	Wed, 17 Jan 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mozzu9K+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03222306
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506485; cv=none; b=Mgjr6fw15WGeRmwNArg6or96UF65stcfOa6QTToxCUz8Sz4SRfF2bt1dKpxhKooBPEl5dyfeKxo1w9yZVysdn/x86mgtJgstJoDmR/Cbwgdn/5dFhkOqHS/gkEQ3oki1hIv7YiJIpUXFozb9cY+XxfLQvp9CZlHEpFg0k005aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506485; c=relaxed/simple;
	bh=mu7VhaAc515ipMhWdzPtT2TPxqqmKOKMcNFGqTwz8wM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=VtSkZ2Vbb+Rwqhjzp0vTCagQjeV4dNxMOMXFxm3JQL9o5pdR7DaNX1hL++X+DLWqig2KeiLSPkuvXI4TI0/z+PRd8W1QOt+DpW/ozMgpycgAgtQcg6xItWnqxfjwVt0Va+w7E+lofV/cpC/HTS1b6CB5ynDJ/gAGcJT0OZYzFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mozzu9K+; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7beeeb1ba87so54389439f.0
        for <stable@vger.kernel.org>; Wed, 17 Jan 2024 07:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705506482; x=1706111282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBwQPpl+zXik806WtECeSYlAHrweUHc1hm7lYkwTJFs=;
        b=mozzu9K+nmHJy5WeFP+F0bOU78P4JJr4xv1z1j4HKBISbL89EbcfFZf+0Xx7H/c2VA
         kTf9A8Xi++6dB+1h5Xuy9/asxCN+b4PQYI4DcdqjJkS6qUJpyNzF8zBvoEttVWPyN1Fr
         PkCiGQlXesvlySenB2Wt1BongGGycIn4kVxg9SWqnDqaJFhjltlTEJelguJTD4GzAdYo
         hg9rD9Fb6gd75W6YrDUNvBvFFiLy4Jwp7TbZrKj7ovSxQ9uSIbSfg/kk8K4RXJK4pUq4
         2Q0eAlKluaBg9CsFolEkhHbG9ojPdnrWBmeaevZ7aRG+bAA2CWoWyyJX5OMX2IuMUPYB
         3erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506482; x=1706111282;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBwQPpl+zXik806WtECeSYlAHrweUHc1hm7lYkwTJFs=;
        b=rPvg901bBPhDEVek0xpJZSWpe7D/edHF83urVZWn353CIPfx7ONU6ucwazm4U0n67X
         g0iFxVpHjEaqVFF7g15qWSnlmY3rXF3Ge+kTeoYYLhsyhNffhaosd0s1h2ntrD7UmI3s
         6Bpj7/DRfBQ33Qpdasd3T3eOgf2j06t4973JadyviEUBBmtN14TdADNragldIqbvlIZ0
         QDR6m7FsxH09O5yQaYFZRr4TnJ6VSMYx4Yn2UBBt3KdQPsZfEoxMSMki2HQNHHsR1fQU
         UObkiq6/FukJgzmaWq3x/PhvrOeCH6PM4AkbECAl2unbWOVigVPqFbjMdlsaMcS5KjBZ
         W6tw==
X-Gm-Message-State: AOJu0Yz07m4sZsiOzrfXwoTFvWAGckMxI8kP1/mc6wqfgvEK/uzKoQ/r
	V7386HGGG7vDV/fAqLT0f4v9JOav5xsuQA==
X-Google-Smtp-Source: AGHT+IFZZGSI3LvvEy+XRSDgw/MUW2O98Sa/T0cEKhvZ1zzsrKqvOW8y4/IMwgbP32kgoihbqtn42w==
X-Received: by 2002:a6b:5803:0:b0:7bf:4758:2a12 with SMTP id m3-20020a6b5803000000b007bf47582a12mr8519442iob.0.1705506482496;
        Wed, 17 Jan 2024 07:48:02 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c34-20020a029625000000b0046e4c2f9f5csm482353jai.28.2024.01.17.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:48:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20240112132657.647112-1-edumazet@google.com>
References: <20240112132657.647112-1-edumazet@google.com>
Subject: Re: [PATCH net] nbd: always initialize struct msghdr completely
Message-Id: <170550648165.620853.7074880501945877841.b4-ty@kernel.dk>
Date: Wed, 17 Jan 2024 08:48:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 12 Jan 2024 13:26:57 +0000, Eric Dumazet wrote:
> syzbot complains that msg->msg_get_inq value can be uninitialized [1]
> 
> struct msghdr got many new fields recently, we should always make
> sure their values is zero by default.
> 
> [1]
>  BUG: KMSAN: uninit-value in tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   inet_recvmsg+0x131/0x580 net/ipv4/af_inet.c:879
>   sock_recvmsg_nosec net/socket.c:1044 [inline]
>   sock_recvmsg+0x12b/0x1e0 net/socket.c:1066
>   __sock_xmit+0x236/0x5c0 drivers/block/nbd.c:538
>   nbd_read_reply drivers/block/nbd.c:732 [inline]
>   recv_work+0x262/0x3100 drivers/block/nbd.c:863
>   process_one_work kernel/workqueue.c:2627 [inline]
>   process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
>   worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
>   kthread+0x3ed/0x540 kernel/kthread.c:388
>   ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> [...]

Applied, thanks!

[1/1] nbd: always initialize struct msghdr completely
      commit: 78fbb92af27d0982634116c7a31065f24d092826

Best regards,
-- 
Jens Axboe





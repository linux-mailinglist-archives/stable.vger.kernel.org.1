Return-Path: <stable+bounces-45211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D408C6BB3
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E18E2839A1
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 17:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F815886F;
	Wed, 15 May 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uB9QVarF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6D17C96
	for <stable@vger.kernel.org>; Wed, 15 May 2024 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715795138; cv=none; b=ZoY5uShlfxOqkiZXf/jXYDAbV1Rqp5VrlSOZ6e0MRm9aci5EHsTxNOW4gzsnCSNIZlRWeI28Nat9hGwvZSD5K2GCfbeh5J7Y4NDdHNbwNuHFvmj7XfB/6Pf7glxvPhl7HOd8FeHOTDz/G51hAJC4MdbYwUoohlHty/DsHKx2Tr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715795138; c=relaxed/simple;
	bh=4/Ooyl624TPv9kwXfjH+lDC71HS+OXDH+JgzPAYD2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEx5JWgq35vvgr4xUOkg7Ms3K9r9MnRYrnQMx3Uu+Y50FT7uaOIo1Q7hpBaTQo3k9gcLgWZPlgfkhN+IhYEDa7uyTkSVQcdc4M2HKSQoishpOvNdU40wYRxtOy1dVhqINXW+jDeP8a21ZKVPdqZtWi9l1KlKPF4fpo1L+eQ1OWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uB9QVarF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f5053dc057so3634085b3a.2
        for <stable@vger.kernel.org>; Wed, 15 May 2024 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715795135; x=1716399935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Inmc+syrxkqK6aZQdAoIkvH5UOxtf+2Na/UaXVJLBFc=;
        b=uB9QVarF9WLvj0e5WVOHnuGsT4TqCGGo5RmhUtWjXCWY1BVR6n5kkyJtwBRMnzM/MF
         euunpYdjb1LA8eKBRVoFGytmRrXrX+i4tuDnPjUpxWqjm7TJY0BJfkxgBup+o6ZaflPZ
         g7s21VvIlP93kTaDb4Fm6TQfmc5Y83UgJYI1UypSjOoq6lfKQoT9ksZmoZxfPdjH4qDO
         OEaGdB71kyFqAPqPLmJKfV4BerByzLwgroow7UFyh08y2/UcN+bGHIxYpeat9sNnEXqc
         dWqqPu4tOJ7OZaXC2hM5ttAgH3rCG1CFzuSHmLr8N5kT+3ITVRy17V77i5EPKBv3jkdv
         JJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715795135; x=1716399935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inmc+syrxkqK6aZQdAoIkvH5UOxtf+2Na/UaXVJLBFc=;
        b=fCf6CU8MUeq9GubfZyJ64H78IJQrQJeIrB5JTO4tr7nNrgScjDAhbBga1N54NNw7qq
         CpfL9wNP/iOVY120K0QUWGjxKvAXCVTFce05VAh0DzVLZkBv0+LOHxSFb6t5iGSabNU8
         gTXsBbG/ePgwAexD6t3QHGt3qVJW0AQZJjz32dWiPcZNomaKNYFiXK4iYhKtfeAdHBU3
         1RE79qMnqaRmVEok0bQKGlcxy7h1cc9nNfJzEni40hTY3sBu3lNGfzgngFD9uzlT+Erc
         hwGoOZuqGxFyY/j/r3JkpiIrBpWhTq4129wkslkzuEZPdexxJ9EOZ/exyojhUZz6CFQ2
         tI6Q==
X-Gm-Message-State: AOJu0YwYbN5ElCAtWhZ5R1W2vUhwHRSLNNk3Pq9FiDrKFF15gtsslfWZ
	RppHrwjjjaFGgy0IKDAfpjnBGxl0evae9s+ieNTx0zpOKOe/5e2d4a9a7u1nEhaDBlYAsqMsyo1
	gIj1l
X-Google-Smtp-Source: AGHT+IHqT+V07QT8d8OIJOetBXVRP2MvqJqTkiAGp4q63p16McqvNFOMMSJe88kfRvnGTsQMprg35Q==
X-Received: by 2002:a05:6a00:270f:b0:6f6:7b6c:51f6 with SMTP id d2e1a72fcca58-6f67b6c5295mr995107b3a.24.1715795135090;
        Wed, 15 May 2024 10:45:35 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a828e2sm11379011b3a.72.2024.05.15.10.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 10:45:34 -0700 (PDT)
Date: Wed, 15 May 2024 17:45:31 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Simon Horman <horms@kernel.org>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 5.15 2/2] netlink: annotate data-races around sk->sk_err
Message-ID: <ZkT0u3RMc89Fe6PV@google.com>
References: <20240515073644.32503-1-yenchia.chen@mediatek.com>
 <20240515073644.32503-3-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515073644.32503-3-yenchia.chen@mediatek.com>

On Wed, May 15, 2024 at 03:36:38PM +0800, Yenchia Chen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> syzbot caught another data-race in netlink when
> setting sk->sk_err.
> 
> Annotate all of them for good measure.
> 
> BUG: KCSAN: data-race in netlink_recvmsg / netlink_recvmsg
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28147 on cpu 0:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> write to 0xffff8881613bb220 of 4 bytes by task 28146 on cpu 1:
> netlink_recvmsg+0x448/0x780 net/netlink/af_netlink.c:1994
> sock_recvmsg_nosec net/socket.c:1027 [inline]
> sock_recvmsg net/socket.c:1049 [inline]
> __sys_recvfrom+0x1f4/0x2e0 net/socket.c:2229
> __do_sys_recvfrom net/socket.c:2247 [inline]
> __se_sys_recvfrom net/socket.c:2243 [inline]
> __x64_sys_recvfrom+0x78/0x90 net/socket.c:2243
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x00000000 -> 0x00000016
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 28146 Comm: syz-executor.0 Not tainted 6.6.0-rc3-syzkaller-00055-g9ed22ae6be81 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Link: https://lore.kernel.org/r/20231003183455.3410550-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: yenchia.chen <yenchia.chen@mediatek.com>
> ---

The conflict resolution looks good to me, thanks!

Reviewed-by: Carlos Llamas <cmllamas@google.com>


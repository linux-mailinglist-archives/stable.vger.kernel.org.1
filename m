Return-Path: <stable+bounces-161885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D877B04822
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C667A2F47
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3132475E3;
	Mon, 14 Jul 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFLDJoxF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4A2367DF;
	Mon, 14 Jul 2025 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523077; cv=none; b=P8UDVPTUP/CMZAiGdTf8Il5EULFPi+swzAcBq7p7y3ziXVDQs7HMudZpQfTAoZ9dD56qefrHUcQoy8Q7U9Spf3Ueni/mE+wrykLzjQi/JZuF5IY0ywqSCLot+08H3WevPEOKph6SleDp5RoFBnEqVlHeDVZksuqE3YqpLrL4KI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523077; c=relaxed/simple;
	bh=Uk5w1V6I4YwPMjZtuY2O0PIn9pPbYViPRep+5RgeIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qKlDPGcYHNSBwhVtCkyj44MsKhJ1x+Jk1h6BzixchADNs4drlP5Rg4+5qDacGk9ECyxrBlbLoi0v/RfQv5dhm9zX2ThvFfsVKl2PZ5PnTqzhpKPhciOEpsIvruerkrgprk79By7UEmg/pKAabGhiKkpcyDysrWFL242SQoY94MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFLDJoxF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so7823837a12.1;
        Mon, 14 Jul 2025 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752523074; x=1753127874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=00htzvS//PxmAK1/kqageAXUez+cznfXa5IYx31PylU=;
        b=CFLDJoxFZ1O3yXEkX5LkPmsjGV3hEUaZlWOVKTsc0+63mmWgtLIP9F/gaibuLfAv4X
         D9Kq0eB2JNtiHtABmyVoA7kJjG1fz2haUMRD1ul5LUXtnNGiOdt0BPnXj6JsQoiIctWA
         GMopbjW8Mel4acFPRm2lRaDQ+IeOuyceD3bSw5XNHRXzSMMurm9qfIZroMHL9BOVRTC0
         z+2R2gKnkD1ajsZZEZVS8/HGEGCuw5FvMsCpfcL+blhD+QlN+FiKAXRmpuA5LRJn36N8
         9MNr5V6zwDcj97yI5C8DYBvPmmWfuqnF1kwdkPDlE1+RQnnOInAieMh05kGYZ6+Ow8/x
         fKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523074; x=1753127874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00htzvS//PxmAK1/kqageAXUez+cznfXa5IYx31PylU=;
        b=wYk2yEId7wEkHCSr5dYxNADbjytwbuKD1r85noPcM5az2o3VD3OOPEFnegAB1yKN9h
         xxp6e4MWDNeP8gnT8yraLeqB85XtEUU1CfAVnr7VvFfMklyztt+THcAgXyThzVAarAee
         cKcOXVOCHpcEgkUNjK/qmX2Iufow/Xuhz5Xdm1STAy1NQ52U89ew3+WVjeQgZn6/Y76S
         tqYQ+eahgtKkMhwcrTNyJOrruUv0IakCM0uxFEfUMa5hLrkmYZpRlwu7t/8asPzjTxvq
         aqU2Ax6d9ier5X67vLJ5lXMnp6MH/nyIz+n4LJOs0NfsP6mOF3ZIhMlXZmzl5e9hMKe1
         KMPw==
X-Forwarded-Encrypted: i=1; AJvYcCV3tLdMrivKn3UkLfMcY36VOElu6zNogCrob8AufOq9aZKJBKkI8GEkTL9KBLKQZqRTgB8bnLYC@vger.kernel.org, AJvYcCVivt43YitkZ4EJvSqAipvVMDI/xHw+8EQpirB5To50i+l6aGIpf0TWJvGc/MWgHhvgfabXSJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Iprms3zaa4j1C1y3jiCls9BP6CP86veTpnDbtOjCYlByQpLM
	CKPP+lLJahBvf08d8fAJsOwjK2NbYQlakZ+1hoBqavFqLBCT7KPKYHQn
X-Gm-Gg: ASbGncvqNfpnSL2LifJJYwkPUQB+AkGSHhATW+nfeuQgD5KoGzoHox3mGMwbv4i84D/
	64sZGusWThjnCbHOJCN8ayAdio3b+a8pf8afxAUF2jz1QuF4iyVUN19wFck6QOBFDv+PHhcMucf
	b64jKF+WRwLoUJeTkYQZiImcgDZvJZS7cpLsY8n5WZG+9cYX8KWkKCexSnNv/CEgT4RYa4qKBqi
	Zh2x4Oxiyud7bE8EWMbogJrhEfMDKfoP7l+9akZVhh9snwyCtj9Ls+5nbGkESB64pn0VzM6d4EG
	DR74sIAuXvFoXxGkI1gux77uT+GYq6dVIn3ZguMAuGildYMY0Yuv8/mRipHx2HvHpkdaPmh8Q6C
	Zs2qS69lK3bHzxG68HySJo31PWjecf+i9cFmUasE2IAOmZN/nozL0xoP6+tXkgDlxPh2JBJl4lL
	iU
X-Google-Smtp-Source: AGHT+IG8cI1AwM6WE16Z8zxT3NpTjDoZqeS9GrJMxlRZ5DUBoix7AwUjHNbjadZtnPsAHQK/pQUcEg==
X-Received: by 2002:a17:906:c14b:b0:ae3:7b53:31b9 with SMTP id a640c23a62f3a-ae70125f453mr1245606366b.35.1752523073891;
        Mon, 14 Jul 2025 12:57:53 -0700 (PDT)
Received: from eldamar.lan (host-87-16-197-101.retail.telecomitalia.it. [87.16.197.101])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82952d2sm879782966b.140.2025.07.14.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:57:53 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 1052BBE2DE0; Mon, 14 Jul 2025 21:57:52 +0200 (CEST)
Date: Mon, 14 Jul 2025 21:57:52 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Guillaume Nault <gnault@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Aaron Conole <aconole@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Charles Bordet <rough.rock3059@datachamp.fr>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, 1108860@bugs.debian.org
Subject: [regression] Wireguard fragmentation fails with VXLAN since
 8930424777e4 ("tunnels: Accept PACKET_HOST skb_tunnel_check_pmtu().")
 causing network timeouts
Message-ID: <aHVhQLPJIhq-SYPM@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Charles Bordet reported the following issue (full context in
https://bugs.debian.org/1108860)

> Dear Maintainer,
> 
> What led up to the situation?
> We run a production environment using Debian 12 VMs, with a network
> topology involving VXLAN tunnels encapsulated inside Wireguard
> interfaces. This setup has worked reliably for over a year, with MTU set
> to 1500 on all interfaces except the Wireguard interface (set to 1420).
> Wireguard kernel fragmentation allowed this configuration to function
> without issues, even though the effective path MTU is lower than 1500.
> 
> What exactly did you do (or not do) that was effective (or ineffective)?
> We performed a routine system upgrade, updating all packages include the
> kernel. After the upgrade, we observed severe network issues (timeouts,
> very slow HTTP/HTTPS, and apt update failures) on all VMs behind the
> router. SSH and small-packet traffic continued to work.
> 
> To diagnose, we:
> 
> * Restored a backup (with the previous kernel): the problem disappeared.
> * Repeated the upgrade, confirming the issue reappeared.
> * Systematically tested each kernel version from 6.1.124-1 up to
> 6.1.140-1. The problem first appears with kernel 6.1.135-1; all earlier
> versions work as expected.
> * Kernel version from the backports (6.12.32-1) did not resolve the
> problem.
> 
> What was the outcome of this action?
> 
> * With kernel 6.1.135-1 or later, network timeouts occur for
> large-packet protocols (HTTP, apt, etc.), while SSH and small-packet
> protocols work.
> * With kernel 6.1.133-1 or earlier, everything works as expected.
> 
> What outcome did you expect instead?
> We expected the network to function as before, with Wireguard handling
> fragmentation transparently and no application-level timeouts,
> regardless of the kernel version.

While triaging the issue we found that the commit 8930424777e4
("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu()." introduces
the issue and Charles confirmed that the issue was present as well in
6.12.35 and 6.15.4 (other version up could potentially still be
affected, but we wanted to check it is not a 6.1.y specific
regression).

Reverthing the commit fixes Charles' issue.

Does that ring a bell?

Regards,
Salvatore


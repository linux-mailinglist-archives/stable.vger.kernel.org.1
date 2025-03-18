Return-Path: <stable+bounces-124804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8DFA6755A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93EA178CEF
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448A20D4EE;
	Tue, 18 Mar 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b="ExDJ3ppc"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CB20B21A;
	Tue, 18 Mar 2025 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305274; cv=none; b=u6gPSGBo+1tLCkB7OfPWUJXch0cIwE2xHFkvXPpfoVXYjFZ141tsquqJOiimGHI7ypdCRbgVY6QuiBAEjsz0bnX/oFijkY0tXmOvZT1cM1Fk3r17fxI2k0L5clna3OiGtjxZuZ6cO447lwUHBvbrXogT7KYR+lAPBd/nvDsYGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305274; c=relaxed/simple;
	bh=OjvPta/n5oLTELCWfeZVH8po1jhn6l56saTNYMpV6DU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Pa7m4h7cSA4QjcvClQXpy6/BLq3nbkxcSecQANv37Wkw6N/U6ilX/xqEGDKwP6tbMcwmE8bf75Onmdu0L5CzcVlumsq2XQY1I8rEOgx2tkVxNu25Q2PGNXzz1qZBWRkQe9gC8kKvZJSUR7cSsomKG14C6BBLVEwgubGJ+HITupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=frank.scheiner@web.de header.b=ExDJ3ppc; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742305249; x=1742910049; i=frank.scheiner@web.de;
	bh=gqWULTPXZo+EbXess34u0Qq7PeblGT8U0aZybYGNlaw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ExDJ3ppcV7dekWkbHx5OG91qa/Nua3xNiqVzzieIRPb2lI8PFxYyCVsNpNc9RxTk
	 c6Mt2SXxYz2uWVxzlfwf55lXWUBT+iWcvLo4P+FaDpznzJNeMLcmy5QKQ1mq4S/8T
	 +5/jLqSKfWDWIC+EvGqmdVKvZBayZrmXV/SwaNh66Pmv3nLczaAUvsk5XF4gZXATA
	 NTCU6BL6VOkS5i9hStEnPBpeL64GmIx5B5AXp1+Aq9/QrWI7iYmIorZ/U2/U9kjl9
	 XwVGXc2zrbN+VXtlmGCJ+CkAxcIKfQiEB4pnJ7fdXo0+LK5dZ0mvPrmLnNE/6ixtG
	 ZfWFY7fQPMGplObz+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.22] ([87.155.230.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8T7K-1tq7LF25w0-00CY4Q; Tue, 18
 Mar 2025 14:40:49 +0100
Message-ID: <8c6125d7-363c-42b3-bdbb-f802cb8b4408@web.de>
Date: Tue, 18 Mar 2025 14:40:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Frank Scheiner <frank.scheiner@web.de>
Subject: 6.1.132-rc1 build regression on ia64 (and possibly other
 architectures)
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dchinner@redhat.com, djwong@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1rbs+WAu+iOyWLiRMJplyoHPy0zQccEFh4SqiFKqm6+YCqWlZkQ
 wNARKrFRlMY7/jG4i9kbgoxqy1QVXKxIW7CG9KghilCWIYb2isgd5ojbqdKgGu3OvNjuSZD
 f8qrM++ShNRj2yxYstZzEngkJXqxy/mNz6MnuA5/nK0LnLQPTtDV37J56hXkppGcX/7xX9U
 ur+kW9I6H/tNdVXYhIokg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f+e/6AIskPk=;a6/fn4ZHxIiPyJI5CYG1ou265kH
 pzTpKf+s5R+mpuWuRbrJ/WmX/l3L1AavPgfNLfyKyceYQMQWbFkwUwDFe6ZO5tbiVXxFs8hjD
 UqlqQafRlLweaqw9s4AEtYqwvDMlnB9TXVyq3VnEvbH6rT6KVa7GPb0dGHUCuMYQS14toqgQ6
 +DeHjfvk3BNtvLHJAoAS34GXB2xt9gVqJKcrsOvUCLMpTKemLpuBNNYkUFQTO7JsOnOBBPzwn
 LKOgeIL7AYyLOD3lDS111AYVwDFR/DsuDiCBKIDuHEvHL8pMFedawQu/Ngrq35l/p9uwfR4uQ
 lxTH0jQykXQUd4N2prdGPnrRkWKQz13IFuAR6Vfzu+qdwqIsCaHDWVujpB+t+wsgFwqhkn6Hg
 S7OjHXpgiSsmaJy4/HW8N4B8vqBqe8eMxwQV6hqm9iwOMwnyAVuowU7sCflc3HZJyXuEjKy/c
 CHaXmMomFKvRfnXqO5PnzPEGBWUPXDwdXoCtmsxsa7LZIHdhQs8mN1XclmLA0H0VTtVqrqLe1
 J5JGEIT3Q3M7S3/hh5MMX2UDWWO5n1tASzonHIDWXjETlR2JN7gUBOTsd/nvkK3qVuC7p7dyu
 6aVbqkx49AEh6pFyTcPc0plCycp94dzW42EmT7leMHxBqyorIutY6ehY/TfMZTITGTsDHDRLC
 CegOR03vBvXWyfAmUB7QwYRgbveNH5J3LQdlXKQJzQOu/i3MgRWJSGgG0ZVX11ys7d+PsOO63
 Bt2DmQCfI5tiFqlBw7yD/cn08WaqW96C5hVDrGXy7oPCzAaKcbXAYrs0b7NrUcwhRM08GMbS3
 bpS8ReLg+PKCxyhCRgS2G24sMsnXiD1jRKA0X5Qxb3Y+atd1OvqF9hJbImBnAUl1tZnpZKvE0
 9whE4T/jS4kTdt2aAnvPIUAVB0t6lVnm+pfxTUY6lvDLxUbmCve24gIC/Gr3WnQcH9Outnbb2
 IbmJ+vsZ1YOdZLc8cue8RxxWYNsRtJGhAv2A8jMQNnSh5dyNUBlcrw+1O7JVSrRrpF0gVPevb
 Je48aTs1oKrIjZ35pUoFa8Kh5qvaEuijVH1eo246EmUhLDjiPRsAVn+QKhGwo9GQQHO/HMv5E
 NU4z4jhkv//ANd3qVMQKwFwfgpfdy0aG//FLc4hbs9vO1/9s4jViOj/yB+PIU+5RJbhqjPUP1
 3HWQE84QJmp5u8mBk8a0T0eKxtoVtdJhY58+Cp0h48UWsyBP5x5ld1/BvJg6vD/yDrGjP0DkY
 hkl8Wjaw2xj7u/AVA4jufS1pjlBjxske2dWzymqG0beneuJtoCexhUQA1vYsHESAcW/mMnOWW
 MeSMqspy4lP4lAS42yvYpKZP6gYGuymN/LONlVE5ovth+sruV4JeAFvzLolNQMTIouLiWAwMk
 xvYw2a6S7bKfD7mH84p56rOEBn2FLMyeCtwAUBmaHmEaTuocadhRqFGtdVB1FzYAwS+hFV9K3
 hT7vBllcHZ6Nwve8DgJjkX09pV8svdrH08WxHmw/VUXcJMTGHXp6gCkLH9+rKlOKxDiVKxA==

Hi again,

also for 6.1.132-rc1 the review hasn't started yet, but as it was
already available on [1], our CI has also tried to built it for ia64
in the morning. Unfortunately that failed, too - I assume due to the
following **missing** upstream commit:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f6b384631e1e3482c24e35b53adbd3da50e47e8f

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.1.y

Build failure (see [2]):

```
[...]
In file included from ./include/linux/string.h:5,
                 from ./include/linux/uuid.h:12,
                 from ./fs/xfs/xfs_linux.h:10,
                 from ./fs/xfs/xfs.h:22,
                 from fs/xfs/libxfs/xfs_alloc.c:6:
fs/xfs/libxfs/xfs_alloc.c: In function '__xfs_free_extent_later':
fs/xfs/libxfs/xfs_alloc.c:2551:51: error: 'mp' undeclared (first use in this function); did you mean 'tp'?
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~
./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
fs/xfs/libxfs/xfs_alloc.c:2551:51: note: each undeclared identifier is reported only once for each function it appears in
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |                                                   ^~
./include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
./fs/xfs/xfs_linux.h:225:63: warning: left-hand operand of comma expression has no effect [-Wunused-value]
  225 |                                                __this_address), \
      |                                                               ^
fs/xfs/libxfs/xfs_alloc.c:2551:13: note: in expansion of macro 'XFS_IS_CORRUPT'
 2551 |         if (XFS_IS_CORRUPT(mp, !xfs_verify_fsbext(mp, bno, len)))
      |             ^~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:250: fs/xfs/libxfs/xfs_alloc.o] Error 1
[...]
```

[2]: https://github.com/linux-ia64/linux-stable-rc/actions/runs/13914712427/job/38935973489#step:8:1292

[3] (7dfee17b13e5024c5c0ab1911859ded4182de3e5 upstream) introduced
the XFS_IS_CORRUPT macro call now in `fs/xfs/libxfs/xfs_alloc.c:2551`,
but the struct "mp" is only there when DEBUG is defined in 6.1.132-rc1.
The above upstream commit (f6b3846) moves "mp" out of that guard and
hence should fix that specific build regression IIUC. Again not
build-tested yet, though.

[3]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.1.y&id=4fc6b15f590bc7a15cb94af58668d9c938015d79

Cheers,
Frank


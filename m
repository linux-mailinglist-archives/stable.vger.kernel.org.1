Return-Path: <stable+bounces-247247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPiZIqz9BWrFdwIAu9opvQ
	(envelope-from <stable+bounces-247247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:51:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 826A4544F01
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61E363010233
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD8233EB10;
	Thu, 14 May 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3/xM5B6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103433556D
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777509; cv=none; b=N8gfTFwEU5FiBGyswze5bL4Z3Pb4KYF0JJhYUD9Z0CLXJJSBMvA68l+9bVAkXWbWfLBeEJ41DjExksQLJGSFo6Xh+dMPac9zrizUQtk0K2T0gkB1SiDqEUK3W9g9tz8oBAlwFpkDZjrk6HlXPLICWIjgyT00AB159LoLoW0mkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777509; c=relaxed/simple;
	bh=hYXAA7aXalALRkWgfGuP0w+RQxSmZCydDdMOcZxX1/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BopHU7mjIKEM8ZIDTvNESayKoAOc+pJRO5Q6XWozLOg6AfpkpMC8EKFRcZ5fcH/flnvC/jiyHa9Iht9C4sMEafoayq4K+AShqcvmSOOcvlh/YD8mGrgVXL8lZJEL5OxvDbHp43urx7s44aQjvSKViV3FuN6To3i1n2qJ9NcQj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3/xM5B6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba21d32776so55869105ad.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777507; x=1779382307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=m3/xM5B6pG2NR5nomGt3ZmTwYSS3wPcf0QyCE0vtPz9LK/9lv/CztxkWi9paUxO8FK
         eCyeJ8/pNI2q2SVBED/isBR8aOb8V3dG8/6JFJLzdngLizZnpjIi+ZOAf1YKiFnCm+PN
         LL/WeeY6kTdkBtwHwqcW491WeHdbnwkYDJ8JE/Zqf5UX4/6vCGjkqAJZ2xp8usoRUYiC
         jOiREK4U6MBShmtgHym0WSnAqk+XINlKuSyIcJK5jTtMwKk2EzOmvd626nb4cSyTSKuX
         bVAXGGQBoTglP+Q1Xc9os4xh5pc9bJ5BvwqcoRsj6IQhNY4zXH61/9xVGu7ZhIy2zROT
         GAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777507; x=1779382307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/6G3puYBsYAiupv27jIvciILYQ7U9jFSrjzR1wNOqo=;
        b=MufdxSZYihPa1mTUiGs9r2w6sDt6O4BIUqq+7y1R+umzs1V5PAoTcZm+Pi5ztEwUEb
         aUZG8BZIdGwTRtfMXhqMQu9fl77O6befWRhlLMWKJENt4JfnFyzK85xfQiArmTZLxkTf
         8kt1vKGpx4WkKUWmwJH1qY73Oh2RU0yJ0W7Gzh7oBQ/E/fM06MHBB0csvfL69UzubaUG
         U73uvFwzrzB42Rb6/0QNbYk6ocRubYewa6884oQnBdUjbcrWhJc2P3qRlLZodjUMVOAE
         qW2Pn0ZHaCF+rplQQQ3FSAXNDbFxYkU0bjbb7xltuamD94B6EiXku0B/2AZ+ymp3xqX+
         WA7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/FFHDmufg0ai5Aj20naRoE1Q4wzmlwZ/zz/RkeTtqKjHIxKiWGvksAN95ptAi58z0kAczwq6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2alt6/QCJjetE7KDajIl0+YtP6agSAUWLgGmQPZTMRsHTP6uI
	ipNOIohkrMVCYj3PZLndgfVL/OIByopipLCzHXVfeTV0C0VUXPXTqJta
X-Gm-Gg: Acq92OEM40/QhDh0n6SKbEWcV26CwPDyKvnd60JrlA6bULw3wXkI6klK0JhquFGhRrB
	gvvNhMvKO/kUNV6+cCFGt/pyYibMqETPdwJIFVKLUjlDpyBiwh1WpbZxxvW/i6xqBXR3TeDLLgH
	YTwARjpYHVmvvHqKC9m4XZFmV9TOWngjgb+86i83hbJNUkyNL5Nj1jPpVzFcrgHmFybM2NPCE8L
	KWbFx1BJUeTJpnCOp0rfctb7q6lAAfVz1/d90tjpLS4ByGMrFY/lB5MX+AD/z/yIxflWQqAUZ1E
	oUvoWnrvLVYWY24fy1/JSYnLRP6xdLmXfG7rvcyzXy7m9S7kL3RE0nwmkOWTAKmy4KWOdfLF26m
	bY24WiVKbeK79Ywem4dq4vH471EnL62C1Hv/rTjeexFNg4FajOJRJ/22IriFI6XL3h+7GJ8FCVv
	FbDY5apsowXfD9MOz9cUXlBdg89Bc9rPfTvKh/KFRL
X-Received: by 2002:a17:902:c94c:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2bd7e7c7ad0mr4187315ad.9.1778777507059;
        Thu, 14 May 2026 09:51:47 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:46 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH net 0/4] net: trust-after-modification fixes for IPv4 options + netlabel
Date: Fri, 15 May 2026 00:51:30 +0800
Message-ID: <20260514165139.436961-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 826A4544F01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com,paul-moore.com,codeweavers.com];
	TAGGED_FROM(0.00)[bounces-247247-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Four small bounds-check fixes for a recurring pattern in IPv4 options
and CIPSO/CALIPSO consumers.  The parse-time validator stores only
the option offset into IPCB / skb metadata.  Later consumers (cmsg
echo, mrouted report, netlabel getattr) re-read the length /
pointer / cat_len bytes from the skb body and use them for indexed
memcpy or bitmap walk.  An nftables payload mutation reachable from
an unprivileged user namespace (CAP_NET_ADMIN inside the namespace)
rewrites those bytes between parse and consume.

  1/4 __ip_options_echo()                40-byte stack OOB write
                                         (KASAN: stack-out-of-bounds,
                                         Write of size 255).
  2/4 ipmr_cache_report()                Up to 40-byte OOB read of
                                         skb head leaked into the
                                         IGMPMSG cmsg delivered to
                                         mrouted.
  3/4 netlbl_skbuff_getattr() / CALIPSO  ~232-byte slab OOB read
                                         driving SELinux/Smack MLS
                                         category bitmap.
  4/4 netlbl_skbuff_getattr() / CIPSO    Sibling of 3/4 on the
                                         AF_INET (CIPSO IPv4) path.

Qi Tang (4):
  ipv4: validate ip_options length in __ip_options_echo() against skb
    tail
  ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
  netlabel: validate CALIPSO option against skb tail in
    netlbl_skbuff_getattr
  netlabel: validate CIPSO option against skb tail in
    netlbl_skbuff_getattr

 net/ipv4/ip_options.c        |  8 ++++++++
 net/ipv4/ipmr.c              |  2 +-
 net/netlabel/netlabel_kapi.c | 27 +++++++++++++++++++++++----
 3 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.47.3



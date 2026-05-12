Return-Path: <stable+bounces-245810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJTXBHc/A2rO2AEAu9opvQ
	(envelope-from <stable+bounces-245810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:55:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BD15230D5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E75983169DB9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843D3BB69E;
	Tue, 12 May 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Parc8l9R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09CA3B8139
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597066; cv=none; b=OWmGiJUxvbF5VddYzYi3hzIIc3j78DMfCaiqJHfjYxddz8xoEg1E+8PrLgYqIKtcxmBagsSsN1Rk2NFFh3xLUrt6V87G8tD4mOQfZi8MrFXs8P8RyFmpu2XHnQQtGaITo62cPWc9dx2vZ5hdo7j2rqVM7W6fq4gF74IYYaPjNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597066; c=relaxed/simple;
	bh=pNjPLUfYOnlL9AuWfKEjlCxudFzPIGw2EJqVl9WOMxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9cpmrUQKrQKjwHt45oUN7gefbztdv+C/nIu5nVxNCcPOhOj6/PTihcF3T8JZUKwIe2bkP+vxjRKOu+reeoa+k3T58oS8HKnn38RMrriZAucJmcqEbPbJQBhvk90r1p12eCVR8t1rcUF/eb8QPKURI4oldQ1f9LmrWbTYkJM2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Parc8l9R; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3066160f8f.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597063; x=1779201863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sza2ZxpHlBY8pmqC5zMaFu/RPKkibTVxTiEJ6kAqjb8=;
        b=Parc8l9RtSWs1uSoBeSworOcRTD0ctS3rqLYfEtNkczKqfx9HYKPvgQs4ABgELQw57
         VXadQdQIH+fsvzks32Q8j6wKH44MDtuV0rg8mI5fdjaL/mIDpUpxFw2+2gVTP6isqz8o
         7AXHio+M/gEDejoCF7tXuHoY3Zid1fh9enhiyxmT8Jjd8MRtiZD/t8ffw5SVehrmggUs
         9OqGfo7OOFlknp6X8Hm32QjNNgJDEFD/B6gwGVf+GgNVGuxzmf2ZbqN7f8svy2v9NNq3
         wHGb+XGijRq24soHDH39ni1pWy26RB2ej9ZtBLqKXO92PA/g1z12221VM+pReObyhNjY
         Gwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597063; x=1779201863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sza2ZxpHlBY8pmqC5zMaFu/RPKkibTVxTiEJ6kAqjb8=;
        b=SoSdWSVh09Dc5BxVhxoeKCRQpMutMYLTNtzcuP6JQS/ffbThJnc3GGA6KbPrg1QOvm
         BzigJaR0J7mGsVJhLyDOMyDD6GFhMOnGYV4AyO6GjMy5/AJKKxT7BBXw+URDDuS58Ppm
         8NZlEsBWvDlcJmwISo7KAO1wsi/6tg8Na2OmDTbZOvcCTcZjzr+RFpZ13uQmOSpNCXr4
         i6UwMDt5tWykdYJZFGzU11TTvb0AgUGGakpBgoP8FrJtAX3Ny2jTNVkszbvBBYFPApl/
         uhq5E1B9gbSnC6bvOaq9gXTe9vmqsPxOXyZpFgmTZNFjL7JHPJh2FOIp78g8whxfEWFT
         kZhg==
X-Forwarded-Encrypted: i=1; AFNElJ8TvmBjV5+5gvGYBk2n7Onrbn6Lp73bszyHdNGbHWnxSSukPHi6eRxlC9FOQE+JFmzNcV/X5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBQ9tg5vkGvxX66XaxuH5wBy2azE9hgQdp+3M4cYf9QG98YF6
	gm4qTmMUmdi9qApEGSvPNpF+JPhnodfcqsS6sBL1g66prD4/c1c8jDaAFO2ouA==
X-Gm-Gg: Acq92OFRFYbUlSEB4nf0SZ7+WFBy1hi01F+lMjd1kym/NDVVYYNI1UeSAnwp3fPI557
	b+W4hd63DV9GGaA/bPoAOVEW9Ep2dKfs6P6NDsPNBMyrO+JXOLfCm1+cbwyYGTX7OlSqSaF85XH
	dd7zEQBCSf1p/UhLXbEGswLA0tk/eQ1iRu6boQfKne65wuoCDNRz7SsIZcHJwBu7RG2hg5ZAmoJ
	jE+9Hw/bicgrS1XmA6ghkkq3rVMe/AV5J4mkKXmeorofdcLxLOJYpYhJon+pBZTILlYR9VoZakB
	aCEXKTMRz14ig+WhsitW+1HOuauY3NJG3ZV2DoGdH4Sb+FoJiJa3aLkPx5JwpopgaOiswcnEqEn
	Zt/i91cA7kOciv8BZs795hlW85jzuCcWBfy80jX/hgsHIUE6n+pFCCW/6mvXt5vRgD3228IWTTY
	37w8xp+CC1N7RcaTZe7qUwdVkQ68nQYS9AssSArNtXW2EBBsFDu3xZbBF+qUQyOSvC2MHF1fAnq
	AbC
X-Received: by 2002:a05:6000:4011:b0:44a:aa3c:5927 with SMTP id ffacd0b85a97d-45b13e55d33mr5041184f8f.29.1778597063157;
        Tue, 12 May 2026 07:44:23 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-304-238.w86-195.abo.wanadoo.fr. [86.195.26.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm32858657f8f.34.2026.05.12.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:44:22 -0700 (PDT)
From: f6bvp <bernard.f6bvp@gmail.com>
To: toke@toke.dk,
	kuba@kernel.org,
	stable@vger.kernel.org
Cc: Bernard Pidoux <bernard.f6bvp@gmail.com>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio (hamradio) subsystem
Date: Tue, 12 May 2026 16:42:28 +0200
Message-ID: <20260512144416.9848-1-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87se8mytvv.fsf@toke.dk>
References: <87se8mytvv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78BD15230D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,vger.kernel.org,redhat.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245810-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

Toke Høiland-Jørgensen <toke@toke.dk> writes:

> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>

Hello Toke, Jakub, all,

I understand the decision to move AX.25, NET/ROM, and ROSE out of tree,
and I am not opposing it. The maintenance burden caused by AI-generated
syzbot reports with no human follow-up is a legitimate reason to act.

That said, I would like to raise one specific concern: the ROSE subsystem
accumulated a number of real bugs through upstream commits that were merged
without hardware testing. I have been running ROSE on actual packet radio
equipment and was able to reproduce and fix five of these bugs, confirmed
via KASAN and netconsole.

The most severe symptom is that the ROSE module cannot be cleanly unloaded
once an AX.25 connection has been established, which makes amateur radio
applications that rely on ROSE effectively unusable until a reboot.

My five patches address:

1. rose: fix dev_put() leak in rose_loopback_timer()
   Fixes: 0453c6824595 ("net/rose: fix unbound loop in rose_loopback_timer()")

2. rose: hold loopback neighbour reference across timer callback
   Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")

3. rose: fix race between loopback timer and module removal
   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

4. rose: clear neighbour pointer after rose_neigh_put() in state machines
   Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")

5. rose: guard rose_neigh_put() against NULL in timer expiry
   Fixes: 5de7665e0a07 ("net: rose: fix timer races against user threads")

Each patch carries the appropriate Fixes: tag and a Tested-by from me on
real hardware. They are visible on lore.kernel.org.

Since ROSE will no longer be maintained in-tree from 7.1 onward, the only
remaining users are those running current stable kernels (7.0.y and
earlier). Would it be possible to have these five patches queued for the
stable trees via Greg's stable process?

I am happy to resend them as a formal series tagged [PATCH stable] against
the current stable releases if that is preferred.

Thank you for your work on the Linux networking subsystem.

73 de Bernard Pidoux, F6BVP
<f6bvp@free.fr>


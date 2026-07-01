Return-Path: <stable+bounces-270257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WjwWM3qTRWq5CQsAu9opvQ
	(envelope-from <stable+bounces-270257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 00:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 359A36F20F9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 00:23:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b="b9/JBzma";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270257-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270257-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD0233061A07
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BA420E70;
	Wed,  1 Jul 2026 22:22:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2E3749E7
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 22:22:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944544; cv=none; b=qiOuKGL0c2RXG+FofHCUZj49F0jGaW4YY0xff3bTsavk4XlghuMdObz9osiwfu5BKHpRx599ZIl2p84w1Hcr7iRkZ1fTpgALQAuXFlVQuK3ggbsPCURpntXzUTrpzGZZE+UsF6KlZRM6/XrEFCYY6wG20+rZbWXOyTV/rkDNTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944544; c=relaxed/simple;
	bh=nsC8NFJSg8O/cmJlglfgAIYEwbzzUARXd3KnJnP1he4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=iSA3TKcPTGeG8+5dFSbmijVUMk2ev2hnD+EYNgoxGDMhQz1InSqSnYb8cTENu1/4RvpSqZPbS4NjCs5SDtDc9tx+D17ZoO5qxSkjHRauE9IOVZC4bHrLGshg3D/RQ3iAMI86AEOHsLq4oO0bGw/mHBF1hRbv2xAFNeyJuRAp0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b9/JBzma; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f0e5e36912so7895316d6.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782944542; x=1783549342; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDjVbAPkrL6odl57wphrkqpaqgjfsBhCuJy+AzVkWyk=;
        b=b9/JBzmajA1J46/l6ayN9WrxEGU9lxfMeQIpquWhmV/EstyuqJLXmix32Nagjqtp8/
         bj8XHMZvqePrhuJLFGIhoy5iomO/UACJIEUYDahCzIY54WlZTm3C4hFu16nw3F+zS5bd
         Ar2MLfZERweKG8RS+4rEm94d+J4ViH/4cR8Nkq/m8IiaWTKgtNKsgoCQaR3AZxk/L39M
         lFS467afguJUbvtQy0ZDVDUHtW5U83X1cQmWB3ICwWp6EV5GDwCNhcEa09zPVlCjuG8w
         eFHLmwrn+UuAtjT0uUfi28PIHh/bywoFoRrD9PqSdK+ABUcz8pJivHX3E2D8uOuRK9E3
         Iprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944542; x=1783549342;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDjVbAPkrL6odl57wphrkqpaqgjfsBhCuJy+AzVkWyk=;
        b=FV2+qx2YH38kyBfNPz3Cxn8pYOI2hBlJ9ARLOo3sPcHcDHLcfr+NUTrRbRq7k7gr1c
         YjB8CB/oOqdv56st1xnYGErlwyMaG9q8tQHZh2BXy3XgQVXVpmoo7rMAiLoawhH8GVS6
         OVaDcYmW+GGBrPTimC/zOncbJPwWbcyHahT8Cm+uxmK7/RvEHupXz4Icx6nJ1ZrBrclU
         qrlelxyxl8XwDBlEDjfEp2erLvRB2c+ZcjV4vSUF1MJ5xypKZTaNmLtz8UF9ugkb5aEw
         VWa8/KeK151+c+Jc6z8IJrX9nS0IBMYrgj9k5bLcg7Oh6M2YpIu7zUscmFCRzLvpBo0s
         xkQw==
X-Forwarded-Encrypted: i=1; AHgh+RoHVG2kWywefc9nnqCrQrkkOBnYCVQIg4tp4kPLR4HokYiv6bXj21pyzR6nRh+HXsLO8skrjKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkqw7fqJgk5n0PrbWEsfrfzvn4OiAmFS5iQE5TRfNEYhOdNE59
	+KJYqtIB/NzvgOuP4ipVQmOBHEtzMHBGqEci8avti6jVkkYS8PuqceRrAQ70mZWOUQ==
X-Gm-Gg: AfdE7ckhr4dTeP9MJSkX2R9dciIZdDBPazSm+OTYthKyiasfIMsPQcwEN44YBC3NCTG
	vZcVkyR5kIGUnIqzUvvEAwa76QpOQUXtQuOe8TQBS0i7bY/yG2xpeQIPM5RDNv9rfqrZHWKCIE/
	timSW6Pg6c0V1zALxL2MUwVEzxE27fuGe463vGa50AbmNMkrdOfC8WU7oJrrepBd4MhVz/cHyLK
	XklVGJAvspl8vL1qHb1A3Z/IkQLG7OsX6xtDWEeFBDjSCxgIKGnQyOs9IuoG1gmLKLLffLpNMg6
	bd3nHdwDzDnxgzDf1OZOLU2SymZgbB7GfgE4lRmmvbh3dLEUW/Y5he5Kdrh9vRhD0SIAceQJ1/M
	rED37rcAPy4Q+gn+hMXkpbcx1tf21BI74bWB0C0/OLAgdJUCxbv/92HgShQrOe/smjSvvjpGwow
	6G6aFQX/tTUpUj3HYUiA+FLuuJWJVfEnCcV6eb71CgBe15hFyC7bKblNPQsw==
X-Received: by 2002:a05:6214:2a47:b0:8f3:b922:b54f with SMTP id 6a1803df08f44-8f3ca37a4d6mr52803116d6.51.1782944542073;
        Wed, 01 Jul 2026 15:22:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4718141e6sm9298786d6.24.2026.07.01.15.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:22:21 -0700 (PDT)
Date: Wed, 01 Jul 2026 18:22:20 -0400
Message-ID: <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Tristan Madani <tristmd@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in  selinux_sctp_bind_connect()
References: <20260625235336.3641828-1-tristmd@gmail.com>
In-Reply-To: <20260625235336.3641828-1-tristmd@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270257-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:richard_c_haines@btinternet.com,m:selinux@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,btinternet.com,vger.kernel.org,talencesecurity.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email,vger.kernel.org:from_smtp,paul-moore.com:dkim,paul-moore.com:mid,paul-moore.com:url,paul-moore.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 359A36F20F9

On Jun 25, 2026 Tristan Madani <tristmd@gmail.com> wrote:
> 
> selinux_sctp_bind_connect() dereferences sk->sk_socket to pass a
> struct socket * to selinux_socket_bind() and
> selinux_socket_connect_helper().  However, when the hook is invoked
> from the ASCONF softirq path (sctp_process_asconf), there is no file
> reference guaranteeing that sk->sk_socket is non-NULL.  The setsockopt
> callers (bindx, connectx, set_primary, sendmsg connect) hold a file
> reference and are not affected.
> 
> Both selinux_socket_bind() and selinux_socket_connect_helper()
> immediately resolve sock->sk, never using the struct socket * for
> anything else.  Refactor the inner logic into helpers that take a
> struct sock * directly so that selinux_sctp_bind_connect() never needs
> to touch sk->sk_socket at all.
> 
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> Changes in v3:
>   - Keep comment describing IPv4/IPv6 address processing loop
>     (Stephen Smalley).
> 
> Changes in v2:
>   - Refactor selinux_socket_bind() and selinux_socket_connect_helper()
>     into sk-based inner helpers instead of adding a NULL check on
>     sk->sk_socket (Stephen Smalley).
> 
>  security/selinux/hooks.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Thanks, this looks good to me, I'm going to merge it into
selinux/stable-7.2 now.

However, there is another issue relating to the SCTP softirq code paths:
the fact that we call into sock_has_perm() in both
__selinux_socket_bind() and selinux_socket_connect_helper().  The
sock_has_perm() function uses current_sid() as the subject in the
avc_has_perm() call, and in the softirq case that is not what we want.

It's been few years since I spent any serious time with SCTP so it isn't
immediately clear to me what the solution is to this problem, but if you
wanted to look into this and come up with some ideas that would be a big
help!

--
paul-moore.com


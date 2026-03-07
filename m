Return-Path: <stable+bounces-223410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CCFOembq2kJewEAu9opvQ
	(envelope-from <stable+bounces-223410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:30:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AE229ECC
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690A43023680
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291EB3002B9;
	Sat,  7 Mar 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/244M4C"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF91DF74F
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854246; cv=pass; b=BtpP5dYIyJaRQspjtVzYytFaLLIa64Mbg41vfAxfATksRgRX4ctF68e3Xeoko4nkyVJINierUKdoG5CisafX5/W6YlHljuEQpAIpuN2jzC3poIFlzzb8ozZjRGGmpQS5nRPkPPnpgJUbmYIuFLEqvqLLYjX4SOzQEcsWjdzJXNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854246; c=relaxed/simple;
	bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNRIyS7P8NES3nCLXrVvOrMtEULzAmPDrAi2FsVX0TV1nZagt4quOOc8zbPeYpOD3LLOT2744bvHJVt8VtORhVqZXmxXlAAaVoKOXQVfdME8gds+vieMSNA+cGvd8K0qnF5NKWQYJq1SpzCRroIpUPWOGQ5RXdGoOZ74UZKWkRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/244M4C; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-503347dea84so1903841cf.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 19:30:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772854245; cv=none;
        d=google.com; s=arc-20240605;
        b=cs0dhvjcst6s60jk7uc9F9wMxcwRxWomyLsptbSv11qC6vJNPxSsb9wpsYt/15hn6b
         ayM5R3h0CUOPuOIH8RRLkVPnrsuoBo+wkCaH2vh6lVs2LPjc6omvf/EpR9g1RmZ1YAbH
         RL4j8DRwXWy8nLUVN7JMbc355Cx8FjUy/muUSb3lZB/Tx1E72mhWtuXdZJHFUKxvDup6
         2IHymajSxdpv4MH2LoyaFMltosO6GgpGDiPQS7Vs/99/Mizz+/WYVcHF75+fHVJ/g+oq
         bBmdhKvopMECe/RVMPgBtjgYw6+ukf3i0sRsTnucU4GdgXu5Pfb2/b5OiiIDwY2FiJvP
         hhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        fh=tII98Rnrg+93UjyXkg8RYXPcETY9xDfgUnUdwM49mbk=;
        b=jjXW3ZgmsrSzqq7Y3NV4bUpWYBoVZizXV609PrUxQv02PSdrCzW7OSPanNNKq1DM6r
         dbxLW3n5MCjYTPG9uVXertWP7q9Tqr+sJFw1hQFNdpNHe/25Hj9r7sAwCrKvkXisaePR
         kaj/IqTXG1DYgeeezA68eRvjL9YdWItXLxDXlNQxZfK6dAj14kX9/uVMMsk2IJRoThGc
         X8Chhg3i4nnaa95B4/kFQsJ+dIIH0tfdR4t4BJCdd6E+Pi5grAW/56WuGOmI7cOd1GLe
         aBJE/squghVu5EvCAs0s5KtbJ+fVSHw+JnhMJkDvkB6/wgR0MLQcoOed+8he0We3ADay
         HuGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772854245; x=1773459045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        b=z/244M4Cv+rUbQwwujE3b/ZK8z5ovrq9jGaxMbZoZ+DZ7mk/F0cyC55wToOJOHkoYO
         g16p7dcgCekHtZT2ml/c6oQsyKXvIydn0wmPA3hMzxjbDMgkLoWXri+QLS/B+i99sbHV
         EfhLwua3Qo0m+hkasEGAx55F/s9XAYxYbUPC4T2OiyrXAZb63AVy0CHOBJO9CxEwAY6n
         ljFyJ7FThs9ia9TM50xGyXcM/wqZM+46S6NviYmi0OJ0sZVO24rJAZX+k9GfKUjuEstk
         3LhoWYKf8LgQs5RC4C0X03vIX9nGj/n8OibN2nhlP/fzN4z5bUC9vs5HlJjmmyxTT6q7
         ZwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854245; x=1773459045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        b=EVjovIiPtXvd1SaU4IRrS2+N1iIQhANb86pxOZmGCh3VFa0Wwnan3S4mK9KXGpk7ya
         JgIpqwv+NPTkSdpJFy5tioQKCR31LhyKaeqqgPaHzsJ6lynFZS1t0/eg9TXIAZpMN55g
         elT6L95nJBsHubro8aZl/5tmYY2cw/VVEkCIgrFbkZ2Fjmct/hWAavQtkaTnXX6NGYks
         oaS2exPbqSh2+X3na4blJ8xPlrV5jPAuOg2Oz5aigeSPKC0U4ssJpgLVSC2USlI90Sho
         XNGWmwJ1yu9+6QfUf8IW5dNMWQd3TSRO0c2BnwFqaKoza2XasphDmFBNOqN5h/ZI1M67
         cAkg==
X-Forwarded-Encrypted: i=1; AJvYcCVumbX0MIIalGyYnaidNwI0zztVLcpMoNrHw5L16fIgijwwbEQLiRRGKPOkqLx+nvcNzTmrMwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqC8ijtOsYDTqYZaFEHYYOESv7STq/Nxnn90jSgD8RGOB8PtyA
	vLl3515LElIZXIZ2WBPRoSdU4Tjtji2d9466yGIsHGvoGUtlueybpr2rLGg6FkMA1av2zDxf3rg
	yteLS4ET7gSANGUbglEDDOVgERwd5WZmJw/d2lPW9
X-Gm-Gg: ATEYQzyQZEiqHlBz1CZ6obePqGen/J5owuM9e3laIIaA7r5ZxptHG43MIwHk5dInURX
	2ILFRyV5L6pfSn33tvAikjW6JMEnvEGkeQUfZHcuW/Oi8GwycTn7DJVx61FKdwnJmBqDQuEdqS5
	x8el4ZH0DMKFkpzyjtI4U7SeKm/BBgo4qMnbKwh9d0YLaGNegfK+XftMy0Wv0m84ifA9T/mIDfd
	dVHHFgwi1MGrYBVkabxTrNaSncAY7qfEbc/W2pxKFQBStoXFaJpvvBgsqNgq4uk4qsZOqvMRP4/
	+WuFYIhZ
X-Received: by 2002:ac8:5f90:0:b0:4f3:4cd3:164c with SMTP id
 d75a77b69052e-508f4916bb2mr60826821cf.21.1772854244481; Fri, 06 Mar 2026
 19:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306233821.196789-1-mehulrao@gmail.com>
In-Reply-To: <20260306233821.196789-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:30:33 +0100
X-Gm-Features: AaiRm52IxOwyQRAQ3DbMqKQin6IPUJE3w17Kvc7B_jjoZjTMnEHedgCvEMqhs0I
Message-ID: <CANn89iK6YAhfoEX2=dvJTrp4-JMjiDSmE0ELOCAt4j-m+-KVMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
To: Mehul Rao <mehulrao@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, petrm@nvidia.com, idosch@nvidia.com, 
	netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 902AE229ECC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223410-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 12:39=E2=80=AFAM Mehul Rao <mehulrao@gmail.com> wrot=
e:
>
> When removing a nexthop from a group, remove_nh_grp_entry() publishes
> the new group via rcu_assign_pointer() then immediately frees the
> removed entry's percpu stats with free_percpu(). However, the
> synchronize_net() grace period in the caller remove_nexthop_from_groups()
> runs after the free. RCU readers that entered before the publish still
> see the old group and can dereference the freed stats via
> nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
> use-after-free on percpu memory.
>
> Fix by deferring the free_percpu() until after synchronize_net() in the
> caller. Removed entries are chained via nh_list onto a local deferred
> free list. After the grace period completes and all RCU readers have
> finished, the percpu stats are safely freed.
>
> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>


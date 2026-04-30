Return-Path: <stable+bounces-242211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C6fJJDO82nq7AEAu9opvQ
	(envelope-from <stable+bounces-242211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 541864A8633
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 23:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B081C302BA2F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580D39EF19;
	Thu, 30 Apr 2026 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIeUjj3n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9239BFFA
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585800; cv=none; b=UKhBxn51suC2eVVdM4q99ZIoCkGHwUEavDM4a/Fb0AtUMhtc925+SRBc8OHYWktJrKyZC5MBPML/2M0OS+cubbF2FoQzrM4FDx6HNM6568uCBY4SZEbbqxaU5f7mIu6lFE0tZjcoTt+GBG3OipMSoZEDzihX/NWLncAv4S9/asY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585800; c=relaxed/simple;
	bh=85tk5QsJ9uyjCVoVZBAl1BfLHBLBZIfxn5vihRLucTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X58TphrFxwykMjdq81hIy5L28Cf6aNiFqX3nV3EEDCM2oUiS2lISGqOjspZR54EpHA/ceBVUYadSB8u/d1EpfK7NzQrshV2BQFKlpg9GIqG4xghg4UZPtoxK77q37Jw/FNf1x6vMW+E3FM8bigmyAjECc/lO4iRQECLdiBdGSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIeUjj3n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891f625344so15451905e9.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777585795; x=1778190595; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=co7aAOg5SysfklO7pgS2h74n35b039IvIzPWl7cCjfc=;
        b=CIeUjj3nCpEgA/zFx6LaFJLEDQpAnDz5HROpJ/A6b4WxragTW/tGTfNLNIyRyGgRxt
         2Qp3CJoLJAFXdqJedBoYx1t5v+EfFe1Y/PdJC4Gv56G9wCMETQp9EsaWw7ki5rKvMlbc
         xHQimS+0hEkPYJM3rQtWc53rHnb81PgBdKKzGle66RwccEHPx1miyurWzvABKJiOBnsc
         hqfWz/3W/dkJGaB3jT2jGfUudUrLb/RADufOudsSKi5PvnbXxArwptVZisb32Ys5YiWB
         219U4MIOjyRpgXyouIIFqZftPLOGDA5Ezkc/22SPFQh0xAo5xU6I/PlGm2cAJVoeoVgB
         TXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777585795; x=1778190595;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=co7aAOg5SysfklO7pgS2h74n35b039IvIzPWl7cCjfc=;
        b=h5yj1Nbtt2zkgND1taSZwwxWPXq9MlI2qhgEUdpM9BW366xR1Sz71KHIFOhKYMQsrh
         PZ2ywOYevsbwcvjMz16PmhtMPCj2dni4Yfr/ak5XsKBHgvaYRGKAZ6TvG7lKBUzcdjyF
         cItC9W6UliLdlG8h1N4aCub79M1knAwSnsoUOZeJjHTLISrowGFaVBBd7NSJw1WjtVLg
         0klxEpZl/VJrtrbaJuFMx+sfqabcSWUaBq2YMdEKnxhQaTdlaHZx+x804N966VOVO8vO
         zrnE2nZtAYDntt6CmooA5PWbRB+5bPEivtDNk/eTLPOoHJZ1rRvYVlFC9Px9TMNSS3as
         plPg==
X-Forwarded-Encrypted: i=1; AFNElJ8DRkaVU9WER0nWab8e8xYSQq1ipJhs1V/OCl3Looq4B3qiXI/o5dQGpBz/7GqKO0/ZOfGwT/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJ+VQYw/tjM090OdtZoDaGV7ZE621xBmS6D9dEyAaxT/f9ie7
	gA+QPxSLdMo44pMFl2vi8lJEBJ7IPWzRS+2aD3VkmOrOmlpWWbPxHoeXKQm1
X-Gm-Gg: AeBDiesZn5gmUw6IRvsS+e/LlAB9jun7wCrkVPBh0GYMrvbYs3OTA5bAeVXGiFVF7mt
	3s3p0RHFZeyjyZoc4Nxz4+GNhA5LprZ422Ba2uoATT+rxCtrJ4IwwWElH6IsnYFqXFz+caxltox
	gfT7n53DTuQD2lG7f3WvqKQZ8Onjd1NBE/EnEz4VcoSoEgS2xzyjEObrbvlE7ekbWVBPqGtJ8vf
	nuZrKGlXFdajZucCCbcgsZJyMWk+z0X7EmVodlEhHLosn3KePutMs+yPfsWfZDtSUOI0QBmVH1h
	RZadXRUThnvIJwUUIxur/ssfQeabUaodiX608eD/MK3JQffqKTzOsYUETrPkW99rCXrVGFHHooZ
	I8qhcZqynUjr+0DEFdofWf+29mdNhtwwc1evimie3BtE/qg2mR8gktf0bC3Mam92srZiig85Ats
	vFmAaLUFuhcDJ4PeAhmewNYbgGZZNfIWzlH6HJwyxiswo=
X-Received: by 2002:a05:600c:4f52:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48a85e684a8mr63270095e9.6.1777585795291;
        Thu, 30 Apr 2026 14:49:55 -0700 (PDT)
Received: from kali (88-173-4-42.subs.proxad.net. [88.173.4.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb55be7sm2654625e9.19.2026.04.30.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:49:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: fw@strlen.de
Cc: pablo@netfilter.org, phil@nwl.cc, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netfilter: ip_tables: guard
 ipt_unregister_table_pre_exit against NULL ops
Date: Thu, 30 Apr 2026 21:49:49 -0000
Message-ID: <177758578919.118018.11758358602621428742@gmail.com>
In-Reply-To: <afNYqx41pBCyDnjR@strlen.de>
References: <20260429175613.1459342-1-tristmd@gmail.com>
 <177750472539.3004201.15967003942391945312@talencesecurity.com>
 <177750474339.3016150.13196470704394042910@talencesecurity.com>
 <afNYqx41pBCyDnjR@strlen.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 541864A8633
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242211-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Florian Westphal <fw@strlen.de> wrote:
> Is there a reproducer for this bug?

Syzkaller hit it under failslab. The race is between the lazy
init path in ipt_register_table() and cleanup_net(). The table
becomes visible via xt_register_table() before ops is assigned,
so pre_exit can find it with NULL ops.

Cleaned crash log:

  Oops: general protection fault, probably for non-canonical address 0xdffffc=
0000000003: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  CPU: 1 UID: 0 PID: 604 Comm: kworker/u8:19 Tainted: G            E      6.1=
4.11 #1
  Workqueue: netns cleanup_net
  RIP: 0010:nf_unregister_net_hook net/netfilter/core.c:531 [inline]
  RIP: 0010:nf_unregister_net_hooks+0xbc/0x150 net/netfilter/core.c:613
  Call Trace:
   <TASK>
   ipt_unregister_table_pre_exit+0x8a/0xc0 net/ipv4/netfilter/ip_tables.c:1814
   iptable_mangle_net_pre_exit+0x21/0x30 net/ipv4/netfilter/iptable_mangle.c:=
99
   ops_pre_exit_list net/core/net_namespace.c:162 [inline]
   cleanup_net+0x4b9/0xbe0 net/core/net_namespace.c:632
   process_one_work+0x98f/0x1750 kernel/workqueue.c:3238
   worker_thread+0x679/0xf50 kernel/workqueue.c:3402
   kthread+0x3f0/0x7e0 kernel/kthread.c:464
   ret_from_fork+0x60/0x90 arch/x86/kernel/process.c:153
   </TASK>

> I'm working on a new unreg scheme to avoid rmmod racing with
> concurrent calls into iptables set/getsockopts.

That sounds like a different issue (rmmod vs sockopt). This one
is init vs cleanup_net -- the NULL ops window exists regardless
of the unreg scheme. V2 is a minimal guard for that.

Thanks,
Tristan


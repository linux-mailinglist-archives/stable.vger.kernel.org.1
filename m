Return-Path: <stable+bounces-241283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GIiEJMu72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:38:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9614470025
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D11DD3008782
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD53AF64D;
	Mon, 27 Apr 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvrboc/z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BAE3B2FF4
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282675; cv=pass; b=uXTBn08SWYHqc+Ryvbn4Y94tnLGC67JD0bz2AOetIpbPbHDmXpSZttCZjWIXZXUKNpC/0+z9G1rdZbGgSqy+fxqtJCK1OMzkJi775cBkZrD0ffQwID08aWpSQXCsG+LbUYNES7hUlL/YLuZKvXDjoETgW63Ye9Qyw3YjtWFzfdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282675; c=relaxed/simple;
	bh=khF6or3P7Ssf2kj43vsYhNI8CexRuRIQPUR2p95Zerc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sepi1CU7A4L4v+0Jxj6mhcY3eTmtZqj4QHr0fvFI5XYDeSyWGaJLZAJGifJvIWL/nwgVxvXrJHAdbzxLSONCvWz6ZlNk4YMzaNiQZ1EGnDuUvMAkno77HDd6GBhstDmnWQQS2iLSgyZWW28WomNIbJRA+VbFivEKKHN9+wmEQ7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yvrboc/z; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d95017a68so6598822a91.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282673; cv=none;
        d=google.com; s=arc-20240605;
        b=QlnyYHz/IPMB7bve97BUv8qTb/UXrdZlkwMOCG9QxJqiHaDOZFVns+5JFHgkpKNmS7
         El8X622U0dQi1Bw2xA8peO1a8r/vBNMKXOjIbXq+uW3+ygGpaTBcskc85PdXdND6Vr6P
         ka+NzOq+ZkTldZYiRJwMPd8lo7EtL86jVPxUqgYtKxnf7HYOfe0lX5GftUWcxLqSS/gq
         ZyVo85vYTz/4fi3qqgTanBPdgYvIJc5NMILsw8j8iXC5pCsCwUdjXVy2guLF4utyXBcP
         e6icmV2jtizSdInQ0CCPljds2wOJKypLrCW4QlyuTOev5nCZmLqOpf3cZ4F12We0nzmh
         Xvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        fh=fgiP+ZVJBB6zXuq53J2ST5D+9VMclkkMnBhEWeqD/X8=;
        b=hOIalrjWIlnVrwwReQnEM0Qdr2Ne1yXP2SXirR+3W8KfZ/B+6JX+nuEu2v1x2JDpgR
         iqMbdUdiONkV7RHYBJ+x7BucggF9H0I0gVzpdxjragHAPQD0ExmuS74p2wwAz6UrEGyF
         7NcF5CanjV1EdIktLv9RUVTJFZcvZk2/gy1BIqAUdWMpZbGRJiqcsFr7C+Cy3+b5BufD
         SHFPEp7F9akyMLmNML2A1zr6K5pUhFBzYhbKEiRVooI8Ocund8kLfg4u13MwTOvgTYJU
         EgVes/6jWnRhMvEMGh48qTHcd74wgbi7ud6F1ryQ3mOehFeavAIuylWKzi6PYTorDL1/
         Sc/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282673; x=1777887473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        b=Yvrboc/zkxGdplDhmWQRZkXBeVKRlUBeBm8CvRSCAsy5aIi+TYfZPIt0+qvyXr7+YU
         Rk5x0ZGYImqKqzqI2m6CuXo3YAyGGn0uC9ixTUCj6BmCRU/tWl5qXU5o6HP3xTUaoigs
         lVva3C34vewMxADKIcEaQFem5woqDuUNVGg0QFW6L6DVlEKlVKOKCq1YokrvLKAFtF+9
         yG22WZuiCvYakpf/shmOFGHNkmucmgc2DDaE62gE4S+5kOoWeQJYWu9an3syIYtYAjTD
         /fLCFcVYLebZAj89BwdtiGLM3IVHstyvfAIXB1EFUVQd08FsGXUR2zCvrc3wasOq9Usv
         8/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282673; x=1777887473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn6E9zoHRM2KLY1lbngZyriexLNgWW5A4g5dkFdwTns=;
        b=OQed/lvH8lvwo5PlBybVi0KuSXP9s8mdpwSyUq0e2t+4G5C/m6vt+I/IAfjfHP5u+/
         //+UeuHe5fEYL97XBi0VsLDE2OTtMYzBT1NDHp1IEU0dWD6ESkdfKHNQlcHjPGuLsy+4
         o6MuNwwl/h4FFVO7ysHvgyesEmz0Y2WIOQqkrxMG2/uhrb3F8ijNu3fcmDIc12Kop5he
         +9CHkuVR7XzqExl621Yub8XLCnXSiyL1It2mp2bCxC2YmCFmUwTGFs+TUDpnc2HTkqG7
         BgfVMdPpfvghOuZrEUeToBCR+RToOyAxQ1K+lX73GuaB18tfxPp1FbFscy6rJ+4zt4hU
         TEpw==
X-Forwarded-Encrypted: i=1; AFNElJ9wvxri8+EXc6nXpw+qVu0k43bMRlAHdUpgcQOreFG5xL0uUZhEJIGfzECmDYxDrsudbty9D+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXfJuHqVldUluzWLVUVkDZamsb8ZhZSzH6ntet5He2YraG/1d
	WoYt+QUMO/7jgA/loBUeHigwKPgVW0jQHF+LaeZ/GNPZxWQFXlu9eKdXaaTByD7sYH5U51YiHuf
	Yi18m/xAqDKNqeupHto9PO38HYsnmQqA=
X-Gm-Gg: AeBDievNiGNnJ35kEe86oHOKwG2pHMywNHHadFR2eMkwJs4XPLoVbczOuHObcMuM+xY
	EYKs6CuHlaylgssXVXKNbV85tr2vBIj/AV9SAFqQKaUqBw9xrPslY8YaPBNyP3MNzCP6Rcblbcc
	GWZ4d4kraty7RVsfigihivSDeZaUTKCQXx7dGXQMqXgJHSn9pSzZyYhzubjnj9P3x8NrR9P2z9U
	ofdbW22cER2ExBdBTjTIdTGXh+e/2qymyVM44iIEu64Lc3DyRcbNexZa4dzP4JcpwNDI2aqY4xp
	2FLm3YcZDR/wvg==
X-Received: by 2002:a17:903:883:b0:2b2:9f45:2266 with SMTP id
 d9443c01a7336-2b5f9f8302dmr320471305ad.21.1777282673433; Mon, 27 Apr 2026
 02:37:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422173846.37640-1-aha310510@gmail.com> <20260423041500.2020-1-hdanton@sina.com>
In-Reply-To: <20260423041500.2020-1-hdanton@sina.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 27 Apr 2026 18:37:44 +0900
X-Gm-Features: AVHnY4I1UFGxx0A28CvrdAM8FeQdsO0M2pXwCD2tOB76rFmHE8O7ZLuo4xDPRRA
Message-ID: <CAO9qdTGbB0YzvZYv1a4irM+i+P=GHYYVF=KwbYHKXr=f9rYUPQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: rsi: fix kthread lifetime race between self-exit
 and external-stop
To: Hillf Danton <hdanton@sina.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5de83f57cd8531f55596@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A9614470025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241283-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,5de83f57cd8531f55596];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:email]

Hi Hillf,

Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, 23 Apr 2026 02:38:46 +0900 Jeongjun Park wrote:
> > RSI driver use both self-exit(kthread_complete_and_exit) and external-stop
> > (kthread_stop) when killing a kthread. Generally, kthread_stop() is called
> > first, and in this case, no particular issues occur.
> >
> > However, in rare instances where kthread_complete_and_exit() is called
> > first and then kthread_stop() is called, a UAF occurs because the kthread
> > object, which has already exited and been freed, is accessed again.
> >
> Alternatively the race could be described with the regular diagram to better
> understand the uaf.
>
>         rsi_kill_thread()       rsi_tx_scheduler_thread()
>         ---                     ---
>         atomic_inc(&handle->thread_done); // set the done flag
>         rsi_set_event(&handle->event);
>
>                                 do {
>                                         something;
>                                 } while (atomic_read(&common->tx_thread.thread_done) == 0);
>                                 // exit after done
>                                 kthread_complete_and_exit(&common->tx_thread.completion, 0);
>
>         kthread_stop(handle->task); // uaf
>

I did not include the race scenario diagram separately to keep the
description brief. Apart from that, Hillf's diagram itself is accurate.

Regards,
Jeongjun Park


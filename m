Return-Path: <stable+bounces-231463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOOcD7H3y2kXNAYAu9opvQ
	(envelope-from <stable+bounces-231463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:34:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83236CC9A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BF20306AD21
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6A3EF0A2;
	Tue, 31 Mar 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B47tskhT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D13E1D09
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974051; cv=none; b=AX9WyOKrM4YuZzd3gCOlfSWubQIqU7nqFXSNDetCXp9TB7ZLL0ECXTGTzk4aAH4rofsLjWq7BZ09oSWErn+IACsVe9T40t1SxSEHV/DQ2oumhuBIMhgNPvHw1SnZ5PnJT90Tua53ettC3Yw3+yNxo3wb17CBuQYfyukbsQIp6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974051; c=relaxed/simple;
	bh=Skckb74KdBnV8+E7aXmFQFjtAKJYHMT2YXbPb3gpHhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc5kt69qjOLh6yhK6CZ7wMdMDyMwYkO+bHchahvFVZXG10HNcQEGKu6YxZj9iuzueTq2wtMzv1NmtwIGNkXY5OGx554C8ZNiHpF2betGeG14A8xI3Bq3DLBq8FvgFoPBXpFCVuhEt2XzypxO/P4SMU2kegx/mIN0qkVmE22C2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B47tskhT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so3963965a91.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774974050; x=1775578850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t53k6xqlseulquJHuVNZsyr/eU4NF62CkVK34QJvTOA=;
        b=B47tskhT6XG5BwzgtZp8TU7tlyS9WiwuChKJKdmvMT+T1tSH1NZCEn0THJsr93VKBW
         o8BK701N27RiT5BRqziA801/OmlsqXEO+8dWa6Kk5iqGKrqNnERyg/oHVMqF8wLg5mi6
         1XKLqbiT8gkSjwkxLJoXFTohNizBfY5z/HLDL7wUnwPHY9jw6Kt4IIE9f8D6+o2BxDvE
         HRVCOJpxod8RhpAOIG9B6uxs/w9EIrH3A8saGj5o/LMILOMAyHn4x95jkf7XRGPU9k8+
         LLMBGOHvGqbxcIeLlXSHeO1+OqqvV/SSIC7ySfg8bymvOW3k/k2xlRaX+KhKx36Odsi3
         ypYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774974050; x=1775578850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t53k6xqlseulquJHuVNZsyr/eU4NF62CkVK34QJvTOA=;
        b=qw0++6+nedXWSrpCp+xjSbN7dWmr7Ys/ysc+P7CtCiOXT22GxvjAM5Ik7CMk+TMHrQ
         5GhL+jjVRaGhlVlLn9dlDhT2sVT2UpRXNzdyC4MeBHVS386ygUowF6wXNkMeKi7mPdmb
         Y/5CAmtbs4gJS6O1cLTWWuGv9dQvMJTai4NP+VwOJYz2wBedqWHFS9d/VFlAAtWUz7IG
         b6FWM6GZ0V4nSWLDcZQJMh3MwIvjepy3cM/w6asTsQo4n4Ddb3g4ZK6sm+aLiD1pfvLP
         FwnEhol6QJQ3GDbRAANtIzOzi8Cxk1YStDLnovFjioD3TSbn1HzZzfdsSqYO8E1HvpgT
         tFTA==
X-Forwarded-Encrypted: i=1; AJvYcCWMmp26kWAjYICD7OU3V5Q/c6/Ox3LRQE/PpOBqKFG60Iff7QEWEd1wUykvD9jDI2yBz3828a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNe2d8GURTFfcj8GIqLounee94WEiZ6q+xaasi7QUaQ2vRoXpd
	YXUgdWORTioRQ+A7IluhUS/QQFigV4JHhivBcGtniXKEKOK+asKyK55G
X-Gm-Gg: ATEYQzzK0yvlugLmpaMxW5P88fi81f2aQ6p+Eu0O+27hHotqbH/jXWnx7u6Tj/yyGoU
	GI7MegW83AxaPRvKd980SBd40v6xpC8RvhPDmmpPcGC/sExNgh0CpPOXP2wlgpIqi7xmx7qsPJH
	ZCImnoUIlgMjMXoSRNryV9NLaTZCcEDADLF4TAUcCLW45M2ETr7etrFRb2dHjTBHASeWg6sxVND
	NZKjNt2UKULIn64YYVQzNF498epSpwIzDj6c3yFMavoTJwA3H9SbzqODYvloueFNaQ5R3LKddO/
	6AQ+Nxg9i0j4H3ILYoqQcFbq60cs5qveJ0bY1T0Ks7l4vl8gF7K6eq2CGVcU2OlbBuSPZpUfpsG
	22Cz/4s/vxO731mNFfK/+dHkmy0CootJmbEJssLq/dnaovnDUpwReuDlpu9vLrCKZ2BrWO1vdeq
	7Omsq8+Hh4Aa2A3loQTYgfYS0=
X-Received: by 2002:a05:6a20:914b:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-39c8787a81bmr18924760637.2.1774974049696;
        Tue, 31 Mar 2026 09:20:49 -0700 (PDT)
Received: from ubuntu24.lan ([14.219.52.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b9c20473sm991578a12.24.2026.03.31.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:20:49 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: akpm@linux-foundation.org
Cc: bsingharora@gmail.com,
	cyyzero16@gmail.com,
	fan.yu9@zte.com.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thomas.orgis@uni-hamburg.de,
	wang.yaxin@zte.com.cn
Subject: Re: [PATCH 1/2] taskstats: set version in TGID exit notifications
Date: Wed,  1 Apr 2026 00:20:40 +0800
Message-ID: <20260331162040.52631-1-cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330142909.3a5fe0ce22798a8cc34a8abe@linux-foundation.org>
References: <20260330142909.3a5fe0ce22798a8cc34a8abe@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231463-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,zte.com.cn,vger.kernel.org,uni-hamburg.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E83236CC9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 5:29 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 30 Mar 2026 03:00:40 +0800 Yiyang Chen <cyyzero16@gmail.com> wrote:
>
> > delay accounting started populating taskstats records with a valid
> > version field via fill_pid() and fill_tgid().
> >
> > Later, commit ad4ecbcba728 ("[PATCH] delay accounting taskstats
> > interface send tgid once") changed the TGID exit path to send the
> > cached signal->stats aggregate directly instead of building the outgoing
> > record through fill_tgid(). Unlike fill_tgid(), fill_tgid_exit() only
> > accumulates accounting data and never initializes stats->version.
> >
> > As a result, TGID exit notifications can reach userspace with
> > version == 0 even though PID exit notifications and
> > TASKSTATS_CMD_GET replies carry a valid taskstats version.
> >
> > Set stats->version = TASKSTATS_VERSION after copying the cached TGID
> > aggregate into the outgoing netlink payload so all taskstats records are
> > self-describing again.
> >
> > Fixes: ad4ecbcba728 ("[PATCH] delay accounting taskstats interface send tgid once")
>
> Thanks, lol, 20 years ago.
>
> Can you explain how others can trigger this?  Some combination of
> steps which results in the bad output?

Yes. This is easy to reproduce with `tools/accounting/getdelays.c`.

I have a small follow-up patch for that tool which:
1. increases the receive buffer/message size so the pid+tgid combined exit
notification is not dropped/truncated
2. prints `stats->version`.

With that patch, the reproducer is:

  Terminal 1:
    ./getdelays -d -v -l -m 0

  Terminal 2:
    taskset -c 0 python3 -c 'import threading,time; t=threading.Thread(target=time.sleep,args=(0.1,)); t.start(); t.join()'

That produces both PID and TGID exit notifications for the same process. The PID
exit record reports a valid taskstats version, while the TGID exit record reports
`version 0`.

>
> > Cc: stable@vger.kernel.org
>
> Is there a chance of breaking existing userspace here?  Some existing
> userspace code which is expecting 0 here and will get surprised by this
> change?

In practice, userspace uses `taskstats.version` to decide which fields are
present in `struct taskstats`, i.e. as a schema/version discriminator. A zero
version does not describe a valid taskstats layout, so it is hard to see how
userspace could use `0` as a meaningful or useful distinction here.

So I do not think fixing this in mainline should break sensible userspace. It
just restores consistency of the taskstats version semantics across
`TASKSTATS_CMD_GET`, PID exit notifications, and TGID exit notifications.

To be honest, I'm also not sure if this should backport to stable. But I think
mainline should still fix it.

Thanks,
Yiyang


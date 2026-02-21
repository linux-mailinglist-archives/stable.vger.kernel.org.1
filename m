Return-Path: <stable+bounces-217649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LUCIhsCmmmnXwMAu9opvQ
	(envelope-from <stable+bounces-217649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:06:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81816D9F1
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C009305E9A6
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331A118DB37;
	Sat, 21 Feb 2026 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZBffAxt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89290313540
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700730; cv=pass; b=OgolwTR8svxvy21P4UZt5ijJt9b4udI/5kKkDdWwESyqxhhoW6mUQ/V4Xl8wb/WS2O2TcwBYKVRlMyC3AXsN9x1agfTyb/2Ak5xu1VIlBCYwYL0goaWF8xIaTJNXoByLZLChF28p1bcMU43AxYb5J7gCJwVKNemJYJtKD4BuPyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700730; c=relaxed/simple;
	bh=exJ3K7abP6Op6YUh0xhRSNeYhIbD1YIdRlcKZgFQyew=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JU8Ll8Q/4seLVi7JBHXwc5X8KwY70Tt8c6Kb3OHeFrZrPs7jaJRo/nmTj9H1NgpcSUt8y15cFa7mEvcxMRUf3OGA42I+RP6ag++cMX1xUqGRJqkf8O2yyLueU4ZmqwtXBt1NFLuQ6Yu4fO/tbPSKUhaYoxD5OPnamj8a4uwjqxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZBffAxt; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b884a84e622so471976366b.1
        for <stable@vger.kernel.org>; Sat, 21 Feb 2026 11:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771700727; cv=none;
        d=google.com; s=arc-20240605;
        b=Xh9oBAIUpoG1fk0Ig+zN0WFYbzaQ8wCi1giQ3W/uJtBA8ZVru4EaemooctddCyoha1
         zO3/tHzaJhj4UCIELOf8rkS8aN0AlM0AA7/AphBKbqWfLG07s3L6qjmR5TxY4UNgNw8M
         5M/SPc8oxEVrvG1y3toklRZkt/7M7igQSBTEyN+6gcpY4kKIWdnfRZv43yjd8aciEgFP
         1m2iQmpBGovpRefYlwsgZOs7cgC9JDXxqjGYOo3zZiYJ52ceIExXOQ+U4cN3yhB+hB37
         92jJwxY5XQQRbWvMsOecRAvBOgMNG7zNXIiQxua2ho9JKI1bs5GNINYSAtf5db/xL4l4
         Yyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UNRYbZyq8FIW8ijBJNLipnaNqzNjI8fI+ewh05hEXeA=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=DAkYNHOjpa6l9X9f6jT+MNR20UbDxg2pMkhMiftZ+tWrXD4a0ytkGFNZygn4LVJQ36
         97zDa8ahd+2mHZBuQrZMYA/rIzZohsR5yosHj+NJiatMHki4RHW9alevm0zq57oGPjhY
         m8Hg61ynDEYxyjl+NVnLJJsnhvAmVTbKMv5JMam6NFUI8b+KZYZVkPkU75bYuqTikxoB
         z+ZdkngJ5Ff9mHm7KIQ2rNYrMECGpGafMRT52gF/9jnjdvYQRKb1pEFkUg3IcQcQX7oz
         9/R9R/2vWFvmNmLNtORfoFvCmo5P/flVWqSgc7rXB3lFUhyfAWi47FOILmCimY//kThl
         dZKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771700727; x=1772305527; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UNRYbZyq8FIW8ijBJNLipnaNqzNjI8fI+ewh05hEXeA=;
        b=iZBffAxtMFWWo2napXUaCGJ/SH3jjLGAiqruaHlUWJdPOwVePev5k/hymgcxrA3Uf1
         kR5FTjA+fM41EbMZamV24RR3lgTCfAlkEWytOhbmaBxPA0+mn/t3Tvq2pT1PPq0Xjhxr
         tjJ4eTgEg5VFWsoJWMUajcDizWsj4ravbpPl68x9pjvc4Q99f5+BrxaZQT0zSt9ipEsQ
         y84/vjB5ZwXJdZDFLZtEKeNXOYsmsAWfe+w6/faz/VWi59K5ra47r9QRv7/+d6fIWM2E
         uH+TQToAGJYCuN/wlenjl+eFkkTbVNc1DiVN2uDhflUEXqdoV8yfra/nPhQrn+Sz/Y/r
         9rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771700727; x=1772305527;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNRYbZyq8FIW8ijBJNLipnaNqzNjI8fI+ewh05hEXeA=;
        b=PTSCa3kXfnR6fLlL7znKY1WQJAm5HOGhbvdGXZnsx8g2F6m4AzoLhY9xjc4dgrFXJE
         p3md7gu+q98oC0RFRkpEeCD4xaQjB7WWBEdVm1TXB+eNgxpUW0F373yPo4obGsmlaA+J
         ssWjCK02w3tnw7ATOYzt5Kr9ppvXnwCEE2A2yqKsTTYuoW/StpDl9ZAldVEnUparI79s
         fSpUE4hTTakZeZ/uAaNtcgzqwai0fWay9QOM5r2IO9Ausp+PE7qZG3NrVTuHPj6CVjhT
         ABF+hI47wiOTcXPp+S/HsMlxEZPOAM5C5c732Na0MezIHVNWohtLzNnI8jzJsq/mRmzk
         bkBw==
X-Gm-Message-State: AOJu0YwYPOVuEIFSlCWoMPLkCgpe+EHayABCawZPoPqegx6pZ0Wd8TfQ
	LD/O7BCF43LevmbX1sMB+p6NMunMn59w42z5eH6xHydREgqBfDV3M9J3tJsWkkdJlV6jqJSKjjP
	9JsmxwAVZKqeeWFTeCNHEeQ0eAtDEDkSO0yAo
X-Gm-Gg: AZuq6aJ7/V5+7gngSlmNDLlDGPPhIvSml9Q7a7CsuB0JHK1YwEsmV9caLQBx+K3IK7S
	oYC8jMUJNA5pPfmeH9NjIbOkWGmvGMTtSNSv2Mru/WNKQ+P3e6s8IgX//TF6LGz9ySx4AcRUhBy
	lXGdzVOAyi0wOATcB42k0uOP9xE7G+sz8rV5Ei+g2o05xkWLKE7FQOdSNtsNlvzdFO5f5vU7DJP
	E3zh2CbaMl64qj98DfaxIDBRsvRPqYTJ/Vgikp6BjWboMIx8WbQKK+SqlDg7AnSL+ZzOKrDAZCk
	Y2pCguwTGiwBh9gH4EFYhi+gq+4KBoBMCp8dDB7TVg==
X-Received: by 2002:a17:906:f59a:b0:b8f:e9fa:ddf7 with SMTP id
 a640c23a62f3a-b9081b81c67mr219956866b.40.1771700726617; Sat, 21 Feb 2026
 11:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathaniel Filardo <nwfilardo@gmail.com>
Date: Sat, 21 Feb 2026 14:04:49 -0500
X-Gm-Features: AaiRm52vx_7kIOKHLYNojEBbl3UX9NjadI-c5bv5K_A_m0MZtzOM8XJFF2HVscY
Message-ID: <CAKsvP2YbMv+iiVb7NWSKmK_Ugi0Wgt78m1qtdDg9OkNVdhcEcQ@mail.gmail.com>
Subject: 6.12 build failure for non-SMP systems
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nwfilardo@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC81816D9F1
X-Rspamd-Action: no action

Hi stable@

The commit https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e61f636cc31042b717a46f6937a2dfaf21f45c91,
first included in 6.12.64, does not properly guard its new references
to `stop_sched_class` under `CONFIG_SMP`, leading to build failures
like the following, even with the significantly newer 6.12.74 release:

> linux-armv5tel-unknown-linux-gnueabi>   LD      .tmp_vmlinux1
linux-armv5tel-unknown-linux-gnueabi>
/nix/store/cn2gkcaa5kfgzjah31c0qlifv9y4yqg5-armv5tel-unknown-linux-gnueabi-binutils-2.44/bin/armv5tel-unknown-linux-gnueabi-ld:
kernel/sched/build_policy.o: in function `scx_ops_disable_workfn':
> linux-armv5tel-unknown-linux-gnueabi> /build/linux-6.12.74/build/../kernel/sched/ext.c:4746:(.text+0x704c): undefined reference to `stop_sched_class'
> linux-armv5tel-unknown-linux-gnueabi> /nix/store/cn2gkcaa5kfgzjah31c0qlifv9y4yqg5-armv5tel-unknown-linux-gnueabi-binutils-2.44/bin/armv5tel-unknown-linux-gnueabi-ld: kernel/sched/build_policy.o: in function `atomic_set':
> linux-armv5tel-unknown-linux-gnueabi> /build/linux-6.12.74/build/../include/linux/atomic/atomic-instrumented.h:69:(.text+0x11c6c): undefined reference to `stop_sched_class'

A possible fix is simply to add the requisite guard, thus:
diff --git a/kernel/sched/ext.c.orig b/kernel/sched/ext.c
index 9f03255..9a3e5b2 100644
--- a/kernel/sched/ext.c.orig
+++ b/kernel/sched/ext.c
@@ -1059,8 +1059,10 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)

 static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 {
+#ifdef CONFIG_SMP
  if (p->sched_class == &stop_sched_class)
  return &stop_sched_class;
+#endif

  return __setscheduler_class(p->policy, p->prio);
 }

But it may also be desirable to backport
https://github.com/torvalds/linux/commit/cac5cefbade90ff0bb0b393d301fa3b5234cf056
from mainline, which removes much of the distinction between UP and
SMP schedulers.

Cheers,
nwf

P.S. Originally reported to my distro at
https://github.com/NixOS/nixpkgs/issues/492672 and the maintainers
suggested I send this upwards, so here I am.


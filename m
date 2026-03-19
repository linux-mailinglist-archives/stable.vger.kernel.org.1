Return-Path: <stable+bounces-227255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL5LL0XRu2k4owIAu9opvQ
	(envelope-from <stable+bounces-227255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:34:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6212C989C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23635302086E
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD63BF680;
	Thu, 19 Mar 2026 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clPZQoi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0137AA99
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773916482; cv=pass; b=SY23Dh8++f1mq0Yeqg28kPSSE5WHytp87B3ZaufKQo4Wqm/J+ubCuOMUmopTyvUvVmqAZ1zFlHBlpg0jsDwu+dy5NJYI91G6lL6ewdHNKsNratBPULuA6GUFZNWONn9spL5RptM6pHr6Zqf2/0GCXTsW4mpEUZiopAXTO27eg2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773916482; c=relaxed/simple;
	bh=y425FapBRj1y3pJVl+gSic4atB/pFxxPUKGYOoGGkW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL7MuxDxqsz03M+uexuffKg0LfVvOTBNoSiqlrAM768XdsQWqEOu+UrPc9rtq2oR5xEWA96mnBWUa6wyQPYLpW+wiuu7Q3xZpjgys9tf0y2i3tXBWn6XIKR8EGFFRwrnyJsizfAHWJfY0qvzCZbDUT0BfyXEvUbdfwQbBE26yJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clPZQoi+; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-667cc4ec065so881770a12.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 03:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773916479; cv=none;
        d=google.com; s=arc-20240605;
        b=W40fnaHyDoWd9zrqHhQlBG/PN2hFUnN9cUFkPil657r8knwtRfQOeg80Ty7/59v4qr
         r76/nSTJ9V5A4jkhpHh8WF9Idiw3VWE/Mzcbo5EFpoMQAWAwhvape1dMqRjHu6NpKE9M
         QTvoociqpk+fYu8aFbfeoHffPMNSAbQIDsWgbFQyKJPOPzHud8jyy4z+D4G2eQP+r5qM
         aaXsMWjf8EwHG2s5/AtbAvAPQZUQJola8/r+csBlz7Zh+6bY+v2X5eLFBh2vdR5zEZnd
         d4zV2kX8OF0RA3wK7aVQEDzmo72QRm5myrdnR+FzTHmOeGBXLsTNPqymyVZtu1Yrc9lh
         gCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1u01jNvDsCaxllwQeIn5uc/G8Bi9UfpQM8KXwq2965s=;
        fh=E6b5sYBipLUYMlVcd6btJqQ24ytNAqtWgkt+BbDMVF4=;
        b=BuGDGFTCXwTNxZWE7y0bAiFsfY/tTeKdXoa3oR/F8BWnhVqoc26EJTe3PzEM1/4Xkr
         HJmf8ISv539mZolgCB3CkGvPIGOJvuK7ZsiHgiOC3ygiqNOrX/vd4Beqkpuoh3KJjLUq
         UhDAmHxkAHK39QRAXWd/0JZEtzp6nZXxGUbLQggvxw/WapnhiBCsDilC2ONijsxSx+pk
         7oW27elda0P1bTndOk3FPf5Fzyiwd3qkHEd4LjVWmcb4fKBverUAgJ/uOcuMJkorsEsm
         uTelx6Fz/kkjLXfI1SYG+IXQctog6Cgxzlx3fChFBzCIXwdqTzACMojie3VIOqb7Zr33
         LPDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773916479; x=1774521279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u01jNvDsCaxllwQeIn5uc/G8Bi9UfpQM8KXwq2965s=;
        b=clPZQoi+X+IM2Yf/PgM1NrTn3F9SUigPMbX6uJNgqS01n7ZXxIfWjfkw6Z551HRf43
         lXTg6xXPWnXoyz0wLw57GU/5f5syX96wYKbD55B4ZmsZHX26Jh0k+31tthDB56V0XAbb
         G5qNkYaBIUQr39Oouoim8++mYaXLGDakt1LrSspBrgrbKoDUEYK6b4h5hU/ACKHRAliE
         tXFkP2Ihwevjk9bRhGaTG73nBlxfERxi402j4mDGo2GEKKmmDvXQ3qWe9K7TbBnSLcAS
         CfE2F//7pIb/zYQD62aUIF2oDiiA1ad8mZZxwePV8ktfWOGIE6MokbPxbgLf3hqCdDl4
         GMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773916479; x=1774521279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1u01jNvDsCaxllwQeIn5uc/G8Bi9UfpQM8KXwq2965s=;
        b=pwHcN6JPpDe1dwfoE1JIzKH023zMXqaYBdDs13ykuO8oLxk4yRUo6//lFE409ndt79
         5/0/7kGXedSJJvIcrfZ3WvxmfH1jWc50V47HlEZk9684TbSqOmUEOi6Zq7WrffKTcJIB
         qq0O/oxGVYU579pNs80txU6l6XFIHVQ67BXDwu4+24A4EYZHL1ulHMelp5425tIUYuPh
         tX7jglG/ruTvN4DtbcIjkQYGLLPx4l32e7U3PkRe15CIXGuvlUTKjy7v2pKzQ5WvCfWK
         cHS3TZ2oHfuhyWo6x6mCmP9dIW2tTfVUkK6R6GGcYO3SyD60YGxDI2PPRHUs7NvjsKcJ
         odtg==
X-Forwarded-Encrypted: i=1; AJvYcCVzqK3Z570SwDVqI77kXnWFZvc2HSpHX5uqmMXPWxNQ0fw2iMYaHCfxQqoFHZ7Y6dRKlfxuF7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMEFaAepnjnK4jH/lLT5D6pWSrPpRw5IHf4fuqpl1gfWsSf9W+
	ItUFDGgzq+/lc4U5MUxcxYKnyXuRcHfE5HwFNV4XR+Er7PJLX3cS1/9QaN8RVsQIr3IvSCM6nSU
	++6qgqxc5S6LsQcnw9gK5RFcFrzO7zCo=
X-Gm-Gg: ATEYQzwBqyzqLZefY4PAvDFLD16Vs5/HzQGCX1uBg1W3XTYRvlTJaOqFEDPjeR2eTi6
	BdDttR4WdzxaRJU0VqKazfG3s4ZD7B0Qzxdcxjax18FU7dhyqGHIXTOvkGkJtoCnqMiQAyl7LA1
	ljUywNFTLkjtAR2RFIQI+UuLUN7fNYw+Ik7sU+iAdebGiDUQfntc53lbUj90YimKsA3sql4hL11
	d29xbdQrYWDmrEBG9Vit2qGR0/tS/eVktRctkp56LVxhxjY39nOrXW5S6yoPOHEi4s77L2rxIcF
	y/A8rzYDIDd5D152lYpUcCTWks62gv4Lv+jDKccjSzrqhFgbBdzgfbI=
X-Received: by 2002:a05:6402:5207:b0:668:73b9:b934 with SMTP id
 4fb4d7f45d1cf-66873b9bb4amr709044a12.26.1773916479208; Thu, 19 Mar 2026
 03:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318090410.3368669-1-gality369@gmail.com> <2026031816-numbing-unsorted-f21d@gregkh>
In-Reply-To: <2026031816-numbing-unsorted-f21d@gregkh>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Thu, 19 Mar 2026 18:34:26 +0800
X-Gm-Features: AaiRm533DqpzCizscL_2_xUNigMmQdLY4GBR7jb7922bmx5QEOOGR8eIcfgpQbY
Message-ID: <CAOmEq9W54=JSD6DmZC3xObqRodvWi_V8YZDqOxHd99kHSyvz7g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: reject non-directory inode in f2fs_get_parent() to
 prevent null-ptr-deref
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, cm224.lee@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227255-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,lists.sourceforge.net,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.903];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 3B6212C989C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 7:39=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> Does the f2fs fsck tool catch this issue when run on the corrupted
> image?

This issue was found by our fuzzing tool. We are still minimizing the
reproducer and checking whether fsck.f2fs catches this case, so that
part is not concluded yet. I would appreciate a bit more time on that.

> That is not a valid threat model, sorry.  If you can modify a filesystem
> image while it is mounted, this is the least of your worries :)

Thank you very much for taking the time to review the report and for
your reply. I really appreciate it.

I understand your point about runtime corruption not necessarily being
the primary threat model. I just wanted to provide a bit more context
on why I thought this case might still be worth reporting.

Our fuzzing tool does not aim to model an attacker with arbitrary
write access to a mounted filesystem image. What it does is apply
small metadata mutations during runtime in order to test filesystem
robustness when the kernel is exposed to inconsistent on-disk state.

I thought this might still be relevant from two angles:

1. Accidental media corruption at runtime

In practice, storage may return inconsistent metadata while mounted
due to bit flips, faulty firmware, transient I/O issues, or partial
writes. In that situation, even if the filesystem metadata is no
longer trustworthy, it still seems desirable that the kernel reject
the invalid state cleanly rather than hit a NULL dereference in a
deeper path.

2. Remote / distributed storage setups

In some cloud or distributed-storage environments, the machine serving
the backing data may be buggy or compromised, or the data may become
corrupted in transit. From the client kernel=E2=80=99s perspective, this is
again similar to receiving malformed metadata from the storage layer,
so I thought it might be worth ensuring that such cases do not affect
overall kernel stability.

I also noticed that f2fs already seems to contain some defensive
checks for unexpected runtime state. For example, in fs/f2fs/segment.c
there is the comment:

/*
* If checkpoints are off, we must not reuse data that
* was used in the previous checkpoint. If it was used
* before, we must track that to know how much space we
* really have.
*/

and there is also the extra __check_sit_bitmap() verification before
submission. That made me think f2fs does already try to guard against
certain forms of runtime inconsistency or corruption.

So my thought here was only that f2fs_get_parent() might want to
enforce its expected invariant a bit earlier, since
export_operations::get_parent should only operate on directory
dentries. The S_ISDIR() check seemed like a small defensive validation
that prevents the later NULL dereference.

I am still learning filesystem design and implementation, so if my
understanding above is incorrect, I would really appreciate any
correction.

Thanks again for your time.

Best regards,
ZhengYuan Huang


Return-Path: <stable+bounces-47766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBC8D5B79
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 09:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB75E1C20E23
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED175589C;
	Fri, 31 May 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JauxdRCu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5D28F7;
	Fri, 31 May 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140716; cv=none; b=b3oJqC9Di9EeSNZf9Fx1iyZ0CbN7MxBh82+DfATUeCDMXorsEUCvf/BFBVWqQ4542F+0faThS3yXsgEYx5rGr7P2WufACqClXCzn9nIqK47+4/lm8XGklv6bmRxjBuNNRb86A6Cf5VMH703Hc3G/7fmy8Shgn8wZXWFjL9vimw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140716; c=relaxed/simple;
	bh=Ve0RxmK60OBObziJeBlmhjOFnNuobyMOmg1zsMrCIC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffru+frwcw/BLlvmm1QHk2KHgr6AnqDqs+Q12wm48G5lhoGIPkaaUIhIf+ZSGNKhWZMWsFc3FiG+32DjNT0jk9MKrZr/oFp1lWyOJCDw1BODe6FieXA1Vv7l9AjZ8HJ+e63xkhtBxiV06ScowOUfE3BUCnoDBB6OBeoMWdE80i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JauxdRCu; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7948b7e4e5dso121968585a.1;
        Fri, 31 May 2024 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717140714; x=1717745514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1PpVIBB5Gv119uTgKZenxtrne9is9XD50hu+La1+04=;
        b=JauxdRCuuWd9vAhcLJLJJrTttQ/QVRlqVIy533Q6D5PeL29AolgAHTofA+R/SFgLUi
         dfAigwkMOjLQ1b5OZdJJpVTqtabIXKuOVReo92f4n3Rvwj47X1psK6roa44dAJyCCQt1
         Yr27N0zal70GaWolqZglsp6JQOInuKeurV1rI9X5UCmb0tV9/+9R9WbwE5rdtEXk9KGY
         4INjZgrl+Ebp7XenFziVeUFlKmecqxwFuPV+HTF+Tlc9o+XXmUntgo85K9Uw+si2t48b
         /j3EIRYym/WSrc9GUTYSz2mpKzRQa7Z/o76zwFJycJLJABLbuTHZ42jGskmZLbrKnLmx
         4YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717140714; x=1717745514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1PpVIBB5Gv119uTgKZenxtrne9is9XD50hu+La1+04=;
        b=ThS3/X9k0Sg1PdOi+phdH5TfHEvrnXuUQOBwvb21jbp9qhALJbzpYH0IS34X5plM5n
         LwmTJQAZM3Zg5OKHvAQAd0R88/jDmVwXOZUyOZ5vbusXkNhpjd7rv1z3YZuU5NGaQ19+
         pT/d3ujXkbF4Jd6YXaJIYtdIGQ2h5ztv1nGloZiffxzR28mwZ893cCQUH4ClPZKV/neC
         Nyv6C37BE/B2GQgDfPVwsJo00PbhjWLqQXnrkrCua+5LFhevozLbFQXhaVYgbe3HHbyp
         JAMBo++oH4u1425zJ1XKDzK5JebOLh/IGbPwvNp5bNmQj9lWaKMfpMiit3pgHt3e9/+m
         KiyA==
X-Gm-Message-State: AOJu0YxYJD60lzalUakhUxqWAojOSlzG3btXlV9p6FvJoAG+0g3y5hUB
	rjXFcTkPloPl8hxBDy1ZR4suOMGPEAFgVVkk77nd/4ZL1Qb8sLd2ClK8QN8yqnvazReiHaEaEn7
	DVlFneRIxROvXl7b/s/S6QemJQv1Uwwjl
X-Google-Smtp-Source: AGHT+IHQ5kFj/WZIHUxqT/gim2ymxdHv5bcEWgJlc6E1yogEgBZJFXMLI32PdDE+Zwm0h7nKU/WwrqpIuL6eRBUln8A=
X-Received: by 2002:ae9:f018:0:b0:792:e8c4:414 with SMTP id
 af79cd13be357-794f5c85fecmr89102385a.26.1717140714115; Fri, 31 May 2024
 00:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530190514.19646-1-sashal@kernel.org>
In-Reply-To: <20240530190514.19646-1-sashal@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 31 May 2024 10:31:42 +0300
Message-ID: <CAOQ4uxgx7Qe=+Nn7LhPWAzFK3n=qsFC8U++U5XBaLUiTA+EqLw@mail.gmail.com>
Subject: Re: Patch "splice: remove permission hook from iter_file_splice_write()"
 has been added to the 6.6-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:05=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     splice: remove permission hook from iter_file_splice_write()
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      splice-remove-permission-hook-from-iter_file_splice_.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 9519e9d1e625d4f01b3c8a1c32042e3f5da53b0b
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Nov 23 18:51:44 2023 +0100
>
>     splice: remove permission hook from iter_file_splice_write()
>
>     [ Upstream commit d53471ba6f7ae97a4e223539029528108b705af1 ]
>
>     All the callers of ->splice_write(), (e.g. do_splice_direct() and
>     do_splice()) already check rw_verify_area() for the entire range
>     and perform all the other checks that are in vfs_write_iter().
>

Alas, that is incorrect for 6.6.y, because it depends on prior commit
ca7ab482401c ("ovl: add permission hooks outside of do_splice_direct()")

And in any case, this commit is part of a pretty hairy shuffle in splice co=
de.
I'd feel much more comfortable with backporting the entire series
0db1d53937fa..6ae654392bb51 than just 3 individual commits in the
middle of the series.

I looked into it and ca7ab482401c does not apply cleanly to 6.6.y -
it depends on the ovl changes 14ab6d425e8067..5b02bfc1e7e3.
Not only for conflict, but also for correct locking order.

That amounts to quite a few non trivial ovl and splice patches,
so maybe you need to reconsider, but on the up side, all those ovl
and splice patches are actually very subtle bug fixes, so I cannot
say that they are not stable tree worthy.

There is also a coda commit that depends on this for conflict:
581a4d003001 coda: convert to new timestamp accessors

I did not check if it all compiles or works, only that it applies cleanly.

>     Instead of creating another tiny helper for special caller, just
>     open-code it.
>
>     This is needed for fanotify "pre content" events.
>
>     Suggested-by: Jan Kara <jack@suse.cz>
>     Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>     Link: https://lore.kernel.org/r/20231122122715.2561213-6-amir73il@gma=
il.com
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
>     Stable-dep-of: 7c98f7cb8fda ("remove call_{read,write}_iter() functio=
ns")

Why would you want to backport this commit?
It hinders backporting work - it does not assist it.

Any new code that open codes  call_{read,write}_iter() is not affected
by the existence of the helpers in stable kernels and any old code that
does use these helpers works as well.

Thanks,
Amir.


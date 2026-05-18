Return-Path: <stable+bounces-249363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGtJC5VdC2ppGAUAu9opvQ
	(envelope-from <stable+bounces-249363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:42:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7549457266B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A508C302BEB1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B22383C80;
	Mon, 18 May 2026 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvDw5Fkm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A142F90C5
	for <stable@vger.kernel.org>; Mon, 18 May 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129744; cv=pass; b=Im4W5WrxJ3AgX4w5wtITwLNtD7vA+PpS9ZUvCcjWpXN95XNOq0nOah5zFBs0RtDT1lmP3yzq4ylWswNo28Mtjj1NfW+FYqI580KSUNJZTqBBSjfPDdo5+3+PLJNCiiKvfRsgSoaS629IDSkLgXYY4FvQnKqZfP3rzCLegwCT0hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129744; c=relaxed/simple;
	bh=DsLFpVRh5VyNxz6WuD8pxXtWGh21asSHzpQ7H9IO9cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSxRWvNliRDoCB/D+TfvFjn4IZM4slo5IAiIqplF6SzipHCiNTGPGTuj91aCOJ6aGedxoUUqh3eDo/DN4PvGRzFO4q2qvwKND6iC6Vc5MpxtkHlkhU11QbjXIDbKOtlFyl5BXdK5CZ2LuUFGeBPJNBEMcAVDZPvIzVtCfHUZf1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvDw5Fkm; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso62a12.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 11:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779129741; cv=none;
        d=google.com; s=arc-20240605;
        b=bAMBku9prfax3p7RoN2Me2+HdjJ7VNhTDJjJM7Vsovm/rsxC2HSY3qfJec61E7NK1g
         977sZ0OrXuikr8P5iScoWD7k3KymY8HC2yXPHZRnXkT6YhdNFUBYg07HlEs6Xysnn5ji
         ca1wgRXVt0AEyJSm1RtBmwYEeqSsMdlbe/WwoZWEFUylxGc4hUcpH9aqY09UG+JyUnEC
         jbKV9jdUTcAtnGgPbBJAA7zYo4UJZ3j9D2ObKA04RH3RbUo6b6rwxKslU8FvbwrR+H0h
         ahaWawGDO7Qug+THY5Laap7TFF0FBtcVJTlaZccEW5ey90OB/GqTXw8FR+LJtTHoqTTT
         b6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+p1ThALA7tHsxgp3ecD+YLGFewUIoZYVb4FRUnieaW4=;
        fh=xWOgjnPa4RmRbSA5xajqZUVZdKYK++SXVHIQDPsFnSE=;
        b=gPSLO+HPZRol3NeiRHZchr0E3DSbJwYgGHjs27XcZxFw+j7nAVadAPNLoUeAF7UOMY
         SmUVADuZnLabvuy4r6EVtQ1z/DIcngpFDCmGCQbhAzsIZxIVuhh2oYOCX3QZNRNp1Vqf
         F7lfp1BL6m46f3eDr/sr+0SiP8T1fy7FF9pLV3YPGem+Zg8w5F1R+j4j5eA80vunrx55
         8EjJ3+Uq+P/l56m6u4m6lOmke8SRCQZkbfRc55WMd+kd9VnjXD1nL3hlqa5CdEK7a5eZ
         pFcHNc9bBpek6766ky+/ALg6TTQRouiW+CrWXQBr1F5IvpB1DbslelWdkkMi6cmYNsja
         R+dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129741; x=1779734541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p1ThALA7tHsxgp3ecD+YLGFewUIoZYVb4FRUnieaW4=;
        b=OvDw5FkmLdoFTV7L+cQOHwKv0udVli7GEwhbfqbqlOw0jUuXAFsXcPGWv1ZmM86SZY
         T+n/+a22E2ZBKrIMejy/IPcrjfmRcQ3PPV9lqjhQhMAYUngmhPZ+QE1RrP2Fj8wWjf93
         EAlpdoun88gxDsU4z2gqPwurfUgso3J+jKoqh2k4A0rF3fQmNV8BXZTTRiTmnvBpJmDb
         uhkxTOOKrC2kcK7T+ARGLJhj1moOaOLHF7kX/XV1ATMpAk9nuvMEKrqosLQE09p/OSAU
         eu8g2Rzs/t0CWH79uEZXROL+8S7sRXux0ooBI8jcj74U6k7Xv1RHdfJ9U5mHyEAh/iuh
         iJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129741; x=1779734541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+p1ThALA7tHsxgp3ecD+YLGFewUIoZYVb4FRUnieaW4=;
        b=qXTMD+CTpB39GUM8ncdCxYSSLx/l1Sm50bu8pQYZHJIg19e0I8nttu3vbH7yCQuWGL
         hUpucvOGyfKbAgksXW52Vrz6bjXXzoki5MRSf0mIc/X6DCb+LiVCJ8Ad9nWslwirkwVQ
         a3U4bHDsP5O5qWVC+qmazclTD/130gXmUCtOpgy0zLcyNFv0FLpnOeDm4c50s0j1bxJc
         WCN1TZ8x5drqUjdy+37eASAMtn1NsPrbyI+/HVSo/x+4qzGWrsPcSaGME6LZ0nef/sZv
         BbnwyDwFvWqFYi0FiHGnZUlEs9WxOk6wKLMya5JGnMq/sH6YzMTJXePYXMMPmc+Zu7wS
         fYGA==
X-Forwarded-Encrypted: i=1; AFNElJ9zTrwsY/zm/0rw/g147/+MslOdQDkXieEQ+0CS6Xg6GEWcr8AzEEsdAEZIyDYkBiJfBu2cCN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+weXm/DsN8+m8MUFjrMmpPtm7ensxpZGKF4RdEVbckGr5EKs
	74IQp6CGMaaVqYqKyKuvy0vdKXk00U0pEhXAlXgGsQgMz3mBcDnNjvWRM/7AWaK7LtIOgmKobqb
	yuefVl/SPH9MrPW8U649vMq8Vps+nlnesmrfE275l
X-Gm-Gg: Acq92OHRpjiVTV8Roic3hSDWGGAZI61lpGBypyLXmDIWF8xPLmfhNbB/Q2BCsj+I252
	s47xo8aioQ64RCmVjYhdeFFa34RlAJXtl601Y9fw2uM5wqAc2aXgspl4rhYqw1RxjPAk/gjrvUZ
	VSyYO1ttOdWyR+usfSErfaPAINHwK+Q8XIdnDhbMXW9uCjplOeNrQp2lDb+VM2THAj+ebJxqeSA
	N9MEIP2pwDUNu4GtbgATIHQWxILiUWg5GWIXvzh0pZvbtydOAI6Li4/lry8bu2bhdemdG+MOgcx
	tqZT0e3DMpGv9v1SKbguMo0qeI8f9BHO2AHz/9YYVhpU5VM=
X-Received: by 2002:a05:6402:17c1:b0:673:9b15:39ff with SMTP id
 4fb4d7f45d1cf-684986e13a1mr103311a12.5.1779129740542; Mon, 18 May 2026
 11:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
 <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
 <CAG48ez3jeAAvy5mymVkLq84Lf27VyQqM9JkjFYzXps+-jLKMkg@mail.gmail.com> <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
In-Reply-To: <CAHk-=wjxBg4Mb98zjJP95gYsC1kYzzBdtp-Yz+J3ZYD+3HrHyw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 20:41:43 +0200
X-Gm-Features: AVHnY4LstOPS__-9Aax3fzoyWaoHW_wSKT_XE_DeVocrxJninb7wmPZdDWUwtFQ
Message-ID: <CAG48ez0Gz_GghVeVzaixAQRNYBdWHYEj3K6FXBSzc+8WNsFxtA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Qualys Security Advisory <qsa@qualys.com>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249363-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 7549457266B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:11=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
> On Mon, 18 May 2026 at 10:20, Jann Horn <jannh@google.com> wrote:
> >
> > I mean... /proc/$pid/task/fd/$n probably has the same problem, no?
>
> Possibly. That said, the permissions on that directory changes when
> the process becomes a zombie, so it might almost accidentally be ok.
>
> > pidfd_getfd() is just more severe because it directly creates an FD
> > for the file, instead of going through normal VFS open() permission
> > checks. But /proc/$pid/task/fd/$n is theoretically also dangerous for
> > stuff like anonymous pipes or memfds, where security mainly relies on
> > not being able to reach the inode.
>
> If your security depends on "not reading the inode", your security is
> not security, it's a joke.

I mean... __shmem_file_setup() explicitly creates files with
S_IRWXUGO, and that is what memfd_create() uses. So the security of
memfds in particular always relies on the inode not being reachable,
unless LSM restrictions are involved.

user@vm:/tmp$ cat memfd_test.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

int main(void) {
  system("grep ^Umask /proc/$PPID/status");

  int memfd =3D memfd_create("foo", MFD_CLOEXEC);
  char cmd[1000];
  sprintf(cmd, "stat --dereference /proc/$PPID/fd/%d", memfd);
  system(cmd);
}
user@vm:/tmp$ gcc -o memfd_test memfd_test.c
user@vm:/tmp$ ./memfd_test
Umask:0002
  File: /proc/699/fd/3
  Size: 0         Blocks: 0          IO Block: 4096   regular empty file
Device: 0,1 Inode: 2064        Links: 0
Access: (0777/-rwxrwxrwx)  Uid: ( 1000/    user)   Gid: ( 1000/    user)
Access: 2026-05-18 18:24:31.669411864 +0000
Modify: 2026-05-18 18:24:31.669411864 +0000
Change: 2026-05-18 18:24:31.669411864 +0000
 Birth: 2026-05-18 18:24:31.669411864 +0000
user@vm:/tmp$


(Anonymous pipes are less problematic in this aspect, get_pipe_inode()
uses the current_fsuid() and sets mode 0600.)

> The /proc/pid/ interface has been around forever, and that's ignoring
> regular ptrace too. Files have absolutely *never* been private, and
> anybody who thinks they are some private thing is just wrong.
>
> And being a zombie doesn't even change that - files can stay around
> afterwards, and it's not a problem.
>
> I really think the *only* bug was literally the whole "people didn't
> think about mm->dumpable as a security thing wrt zombies"
>
> (And the entirely unrelated bug of IO-time vs open-time, which we've
> had many many times because it's such an easy mistake to make).
>
> > I think that would be kind of ugly because here, the MM is not
> > actually used for memory management thing; instead, the MM is just
> > used as the one place we have that stores state that is shared between
> > threads
>
> I agree. Except it is *not* "the one place". We have multiple shared plac=
es.
>
> In fact, I wonder if we should simply just move "dumpable" into
> "struct sighand_struct" instead (or "signal_struct"). Those stay
> around until the task is released, and they kind of are more natural
> for core dumping, since it's about signals.

I think signal_struct is not unshared on exec; so in this sequence of event=
s:

 - task T1 is a non-dumpable task
 - task T1 creates another thread T2
 - T2 exits
 - T1 goes through execve and becomes dumpable

I believe T1 and T2 are still associated with the same signal_struct,
which means that even though T2 is part of the pre-execve process, it
shares state with the post-execve process and it would wrongly be
considered dumpable.

I hadn't realized that the sighand_struct is unshared on execve, I
guess putting it in sighand_struct might be an option. (An
implementation detail regarding that is that a task can currently lose
its sighand_struct while there are still references held to the task,
but I guess changing that would be easy.)


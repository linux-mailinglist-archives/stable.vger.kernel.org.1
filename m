Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F677C786
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjHOGMH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 02:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjHOGLn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 02:11:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400541730
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 23:11:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9338e4695so78751931fa.2
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 23:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692079899; x=1692684699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uRmlNp0zVeV/2xZq56pyWJycC87MI6SKt4lbuSPPaQ=;
        b=RixMO+c72EN6CMA7cwO5cA40NZSIJCAL+YfvbGxtQi+qNWO77CYMEAkmlEZxPxVf+2
         oFEuEI8Wy3NAjfomoBrafT/Vfd3w2go6PjwAwtZykgf8RfTSe4GNd/dPbck4k7k941V4
         lsp/oC9NwnAZ91FjPDv3CZubs8ntI5LYx38xWs+H+EMgAdEyLpIZxS2biBJBOwIZOeS6
         HRHfp35h2nKMP79/32GIB8HZSp+aOm6F85pE4T1JpCLdwPOQSr1DXuxj8NovkE92UeiP
         ZmJVDJCBikEbRpWB8Lj2WQirBPd9v023p6KiOJlmaw55JViZttGWmjStw3wmc7sRkNBI
         4tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692079899; x=1692684699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uRmlNp0zVeV/2xZq56pyWJycC87MI6SKt4lbuSPPaQ=;
        b=KFkVwcJIyPrr++Uj5aV2BUX2zeB6Wo9E6P58eCSuKyOobv5xYtO0yMm6nYdoGnaCDi
         9jeKLIhdJiBMJAjYvr5Znl1qNdK43oZQsr/5V2UYyH6esu4ZB3WGsINmoyrykPxcL0gb
         /+8F12KaxK4cqdtua4s1xlj5MWvm5kvVlVT6uI3R7EJsnNDlH+mtgOxW+unzZsSyKRbE
         iv71TPZjpxoUSIZcS4zGufzVbiUHCmnczSuO9Zsjg62HoAnSI79O1x+I4za/WbH18J1n
         PaTkgM8Hz6VPn1iuWMvPbH8vh8XE+g7ZWaPtI0Rl5lF3T+nyKSZu7yGcoOtvwh/xHUxu
         7Plw==
X-Gm-Message-State: AOJu0YySnIixEHY+JzeLb4sRMwzRtcKgTQsu4PLxwaVPat5OAcmnbXbU
        FTGW12IIpd1Bodk9UBjjBD8vT0gpFcG6jp1x4P1zxQi1Gp5TVw==
X-Google-Smtp-Source: AGHT+IFQSCQw7lJnipy721GFX6ZIrO8Uvr6+vFiWWFVsa/Y8aqt4FOFC3qMVy58dw3me6QoZzaGkVuZsC/YFS2aBofM=
X-Received: by 2002:a2e:b0dc:0:b0:2b9:dfd1:3803 with SMTP id
 g28-20020a2eb0dc000000b002b9dfd13803mr8691959ljl.30.1692079899079; Mon, 14
 Aug 2023 23:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+prNOpqd2Tk1tiBAa9MT6ZPxB5gj9ftxOhaZ-u1WEay9H-oHQ@mail.gmail.com>
 <20230815053132.GB22301@1wt.eu>
In-Reply-To: <20230815053132.GB22301@1wt.eu>
From:   Xuancong Wang <xuancong84@gmail.com>
Date:   Tue, 15 Aug 2023 14:11:28 +0800
Message-ID: <CA+prNOrUVWM9-vozUZyW49-m=qFWZR3JAtikZb4T1EimV0ZCDw@mail.gmail.com>
Subject: Re: A small bug in file access control that all have neglected
To:     Willy Tarreau <w@1wt.eu>
Cc:     security@kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Yes, by "full access", I mean `chmod 777`. You can easily reproduce
this bug on any Linux machine by typing the following commands:

xuancong@mx:~$ sudo su
root@mx:/home/xuancong# echo yes >a
root@mx:/home/xuancong# chmod 777 a
root@mx:/home/xuancong#
exit
xuancong@mx:~$ echo no >>a
xuancong@mx:~$ cat a
yes
no
xuancong@mx:~$ ls -al a
-rwxrwxrwx 1 root root 7 Aug 15 14:08 a
xuancong@mx:~$ touch -m a
touch: setting times of 'a': Operation not permitted
xuancong@mx:~$ python -c "import os,sys;os.utime('a',(1,1))"
Traceback (most recent call last):
  File "<string>", line 1, in <module>
PermissionError: [Errno 1] Operation not permitted


Cheers,
Xuancong

On Tue, Aug 15, 2023 at 1:31=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
>
> Hello,
>
> On Tue, Aug 15, 2023 at 11:42:55AM +0800, Xuancong Wang wrote:
> > Dear all,
> >
> > I found in all versions of Linux (at least for kernel version 4/5/6), t=
he
> > following bug exists:
> > When a user is granted full access to a file of which he is not the own=
er,
> > he can read/write/delete the file, but cannot "change only its last
> > modification date". In particular, `touch -m` fails and Python's
> > `os.utime()` also fails with "Operation not permitted", but `touch` wit=
hout
> > -m works.
> >
> > This applies to both FACL extended permission as well as basic Linux fi=
le
> > permission.
> >
> > Thank you for fixing this in the future!
>
> Your description is unclear to me, particularly what you call "is
> granted full access": do you mean chmod here ? If so, you can't
> delete it, so maybe you mean something else ? You should share a
> full reproducer showing the problem. Also, the fact that one
> command (touch) works and another one (python) does not indicates
> they don't do the same thing. So I suspect it's more related to
> the way the file is accessed where both commands use different
> semantics. As such, using strace on both commands showing the
> sequence accessing that file will reveal the difference and very
> likely explain why one can and the other cannot change the last
> modification date.
>
> Willy
>
> PS: there's no need to keep security@ here, it's used to dispatch
>     issues to maintainers and coordinate fixes, now that your report
>     is public it will not bring anything anymore.

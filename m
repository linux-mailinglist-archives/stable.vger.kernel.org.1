Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBEC7D6110
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 07:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjJYFQf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 01:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYFQe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 01:16:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5AB3
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 22:16:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cd566d8dfso209981cf.0
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 22:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698210991; x=1698815791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baZe6Er/ufhd0Yrnb7R1vtwdXlCqo8z/yXvbEj5eRBg=;
        b=vSBxZUJKQY7TQMHR2uqY7embxDzmvDr2EkbRQxj9nPotyS14t6cuMJrnTyb4rwk3lu
         EKmBwFGGP5o1zKTSC63aW47g3Fkob0BydQoYYKcAp16Gm9msuLfUGRwrdJ8W7SSHV2rW
         LU6EfNITGOA+MUkZmyPNGdRTVSuOfeeWxyKh5d8Vnim4zkRc1xQ5fySPEKY96+fDTdjl
         /7UC5Sny4AaGLz4XcGvIHlNd64YzqeCwMZPwS3eJpeB1Qod+sj+4ilMsF55m6XaqelEf
         QDEn5y3+AjimyWka6j6qyuAQqPI7jCVNBm1h4pBq7jwoe+QrRDHHPtmpNTvWgZWvX/fr
         eHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698210991; x=1698815791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baZe6Er/ufhd0Yrnb7R1vtwdXlCqo8z/yXvbEj5eRBg=;
        b=mX0e3Zc4VXe8z0VXu4eZlixl6xhAtSSp1myXVLgXVJMmGTLKyspF8+yDry/gb/JPGv
         cZgGh1VDOActHJ5oefc1WxbIQWz9xAwijZ+zG26SjlmG+doeQ6HFhjlA6fOHV9OUi7v4
         fYhB2DQ1q4rJnXrK0qS7BKpdt1JQJjiB6xX07u1NCtN3hXU+DfZwAlHvkN8v6TkaWG5L
         BJjygs1RzIKgKIR7hoxAjmGUIL0JBZFSk9/9E0V+TvD+YQgFwAMmS/6uSXVFooQWetEG
         R23cXXf8gvD2sh018W4bjN21NYYsNlmfrMJB9PzcLrVjHYeitAC2Kg+yPXynZhJW6BQ8
         cAnw==
X-Gm-Message-State: AOJu0YwYj9frEY5M12ybQH0JhYQv9EL7u9uTI6Z13rPdkCyUslX5k8P8
        nZ6Oe1p8THKZWjf4KEUTWFTziIat9mixuDiV2njAzU6C8srjkKVNiA3iag==
X-Google-Smtp-Source: AGHT+IEzASoZCc/TRs0iyuhbg3NuUUgSxk35u16AmQj/DeiUVHb7V9/maMfbF9YIF+4At8GWNCRv/or/uAtFz+84vVs=
X-Received: by 2002:a05:622a:4784:b0:41e:29ad:8b8b with SMTP id
 do4-20020a05622a478400b0041e29ad8b8bmr142206qtb.10.1698210991149; Tue, 24 Oct
 2023 22:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230824170617.074557800@linuxfoundation.org> <20230824170623.040455914@linuxfoundation.org>
 <2023102428-implicate-predict-0966@gregkh>
In-Reply-To: <2023102428-implicate-predict-0966@gregkh>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Tue, 24 Oct 2023 22:16:18 -0700
Message-ID: <CAFNjLiWdyUzFpSSpfoPBjGRB4Eyhr=NH4TG0M0sydHTcUwvpxg@mail.gmail.com>
Subject: Re: [PATCH 5.10 134/135] objtool/x86: Fixup frame-pointer vs rethunk
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bp@alien8.de, jpoimboe@kernel.org, patches@lists.linux.dev,
        peterz@infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 24, 2023 at 11:12=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Oct 24, 2023 at 05:47:54PM +0000, John Sperbeck wrote:
> > > 5.10-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Peter Zijlstra <peterz@infradead.org>
> > >
> > > commit dbf46008775516f7f25c95b7760041c286299783 upstream.
> > >
> > > For stack-validation of a frame-pointer build, objtool validates that
> > > every CALL instruction is preceded by a frame-setup. The new SRSO
> > > return thunks violate this with their RSB stuffing trickery.
> > >
> > > Extend the __fentry__ exception to also cover the embedded_insn case
> > > used for this. This cures:
> > >
> > >   vmlinux.o: warning: objtool: srso_untrain_ret+0xd: call without fra=
me pointer save/setup
> > >
> > > Fixes: 4ae68b26c3ab ("objtool/x86: Fix SRSO mess")
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > > Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > Link: https://lore.kernel.org/r/20230816115921.GH980931@hirez.program=
ming.kicks-ass.net
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  tools/objtool/check.c |   17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >
> > > --- a/tools/objtool/check.c
> > > +++ b/tools/objtool/check.c
> > > @@ -2079,12 +2079,17 @@ static int decode_sections(struct objtoo
> > >     return 0;
> > >  }
> > >
> > > -static bool is_fentry_call(struct instruction *insn)
> > > +static bool is_special_call(struct instruction *insn)
> > >  {
> > > -   if (insn->type =3D=3D INSN_CALL &&
> > > -       insn->call_dest &&
> > > -       insn->call_dest->fentry)
> > > -           return true;
> > > +   if (insn->type =3D=3D INSN_CALL) {
> > > +           struct symbol *dest =3D insn->call_dest;
> > > +
> > > +           if (!dest)
> > > +                   return false;
> > > +
> > > +           if (dest->fentry)
> > > +                   return true;
> > > +   }
> > >
> > >     return false;
> > >  }
> > > @@ -2958,7 +2963,7 @@ static int validate_branch(struct objtoo
> > >                     if (ret)
> > >                             return ret;
> > >
> > > -                   if (!no_fp && func && !is_fentry_call(insn) &&
> > > +                   if (!no_fp && func && !is_special_call(insn) &&
> > >                         !has_valid_stack_frame(&state)) {
> > >                             WARN_FUNC("call without frame pointer sav=
e/setup",
> > >                                       sec, insn->offset);
> > >
> > >
> > >
> >
> > We still see the 'srso_untrain_ret+0xd: call without frame pointer save=
/setup' warning with v5.15.136.  It looks like the backport might be incomp=
lete.  Is this additional change needed?
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index 36ad0b6b94a9..c3bb96e5bfa6 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2202,7 +2202,7 @@ static bool is_special_call(struct instruction *i=
nsn)
> >               if (!dest)
> >                       return false;
> >
> > -             if (dest->fentry)
> > +             if (dest->fentry || dest->embedded_insn)
> >                       return true;
> >       }
> >
>
> Possibly, I remember this was a pain to backport.  Can you try this and
> see?  If so, can you send a working and tested patch?
>
> thanks,
>
> greg k-h

I think I can do that.  What's the process for a patch that would only
go to certain stable branches?  The 6.5 branch is okay.  A fix would
apply to 6.1, 5.15, and 5.10.  The original partial backport hasn't
gone into early releases, but I don't know if it will in the future.

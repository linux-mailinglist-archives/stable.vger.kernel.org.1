Return-Path: <stable+bounces-77719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575698658E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA7A1F21C0A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440453E23;
	Wed, 25 Sep 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRhYKS6X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9D282FD
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285149; cv=none; b=OHnl0cq9urobRfvP12BGy1y6cJO6ir5MPcD+fDmptiUAs0R3GWfzU1fFpYgINsu58PRczSq8BUQmebuVf573Qh/EeB2KNsEiFr/RdgQ623jhOuixNucm/eKcQ8T5JMxqfwnc7TfPNTadAMTpD84cCpvMLEJSZqx5n/wkpBB2DLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285149; c=relaxed/simple;
	bh=AhIrI2/RREyUMudfNwAS6DhHbvaxKQSlgWlYA7jCxio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgFORZLwhbudkfe4bIJaCYbt6T9DxMtLxQKIZhVtIDcgvS+S6gKfqKVwbV15MlVXiFENdSvbk8yaj4Zjpd91vYo/gPS3AqVRhbpH+G0Kv+Cv9qsxLrpYpqLiaWR7Vm2s/ffsC0aHufxrr9S6boeBzOqT857J+qYwqOhTvBUyPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRhYKS6X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2056aa5cefcso13655ad.0
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727285147; x=1727889947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Su+zjoG6C7WTkRHIK4B665kXbGV/0jJlFJ1AQFnRotk=;
        b=sRhYKS6XmdvGKQs4ZC9xNlzzNDsO6xViEc0M1xq5pDVXKbcqodK71r50GVP0yWew7b
         N1IGS7v54YWVhhNe5GIbgUCuRwbRPZulSq4ZqRjwegcC0plK8wfmGbKkNl7cUeW/hG6m
         CYEukS7enoywtrEHFqCUifX4re2sWYrsUTXM3bHr0Pv4bqqWzev9LduwrLDkXGKEWjQJ
         0Ya0UMxaS/C7pXZMjb0VCXwJbTmwhd04wkEUii1gGfDQcnO5FAGK7sAVJTtkhD9oyZgt
         V5NwLS2kU4ROgrhHrRPIbTTqqB3ZaliH8xZsR8OPvMi4FCqm8jtVO6UnDdtgKJI6uiy1
         Xkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285147; x=1727889947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Su+zjoG6C7WTkRHIK4B665kXbGV/0jJlFJ1AQFnRotk=;
        b=H9YdQfJHluk7W2NsQflYzWlkuueeGTexRikpAg6hBURGG8fXNNqkkk9XRLbwLyDc0/
         BFV8sD4F5TiNRObV8stl51w9xFhADtMPujP9oSA/ba9Mo95GnS/n+QKz2Ty0McBRDXWp
         +1kvyHpXv15+EwQTgJKwUKdXMokNKiJAUY1PPCcrmAT0Q6Gvzwa+rbEnRL4Wu5Nmpn0p
         t2wprFRzCphZa6uLw8ZOi3ldxomVXmM9BI7wrbXv/Abt6xK2QZt/Z6Tk/FC+998N+KNr
         4RQk504UKHIaGL2wxytgdyFZtGE4uXbcuRuRfpfWGgWBV7vuGDsB7dOeC7l7XoH3yDK0
         dekQ==
X-Forwarded-Encrypted: i=1; AJvYcCX43ivbxzXFhlANmUuElAGnSY/laQHTihOit1ga2HcASqvM+9b8La3pZDkYudJCVz6UcIK3Oxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcpSWD/gYO3pmfaAgd3Ty1JRWcc700P5pSZv5bPS9xt65GN2G
	W9bAfe5P55c+lfly/kHL95ADTzcwIydP25OHOPs4b38+DcJvHlbj3dPItfZ7tSywuHdGL6u4Z7V
	ksg==
X-Google-Smtp-Source: AGHT+IE8xSLmLUeRBYsrwfBKWKqV9fQVQjXZkbD13rmNiyBdqroV6ZDc6AJpgD0dk24lidaUaxE32w==
X-Received: by 2002:a17:902:da88:b0:205:753e:b49a with SMTP id d9443c01a7336-20b117e2767mr846595ad.18.1727285146641;
        Wed, 25 Sep 2024 10:25:46 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16fef3sm1799144a91.1.2024.09.25.10.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:25:46 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:25:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yu-Ting Tseng <yutingtseng@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
Message-ID: <ZvRHlmCSwGHbH70z@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-5-cmllamas@google.com>
 <CAH5fLgiDjNtt2G4S4NrHLGvGudSVT1udCKjkpTC+71v_3TuLZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiDjNtt2G4S4NrHLGvGudSVT1udCKjkpTC+71v_3TuLZg@mail.gmail.com>

On Wed, Sep 25, 2024 at 09:36:10AM +0200, 'Alice Ryhl' via kernel-team wrote:
> On Tue, Sep 24, 2024 at 8:44 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
> > entries and it shows up as "unknown work" when logged:
> >
> >   proc 649
> >   context binder-test
> >     thread 649: l 00 need_return 0 tr 0
> >     ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
> >     unknown work: type 10
> >
> > This patch add the freeze work type and is now logged as such:
> >
> >   proc 637
> >   context binder-test
> >     thread 637: l 00 need_return 0 tr 0
> >     ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
> >     has frozen binder
> >
> > Fixes: d579b04a52a1 ("binder: frozen notification")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index d955135ee37a..2be9f3559ed7 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
> >         case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
> >                 seq_printf(m, "%shas cleared death notification\n", prefix);
> >                 break;
> > +       case BINDER_WORK_FROZEN_BINDER:
> > +               seq_printf(m, "%shas frozen binder\n", prefix);
> > +               break;
> 
> What about BINDER_WORK_CLEAR_FREEZE_NOTIFICATION?

Oh, you are right! We also need this type here. I haven't played with
the clear notification path just yet (as you can tell). Thanks for
pointing it out though, I'll send a v2.

Looking closer, I see that BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT
is also missing, so I'll send a separate patch for that too.

Thanks,
--
Carlos Llamas


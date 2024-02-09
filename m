Return-Path: <stable+bounces-19393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5BA84FCA9
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 20:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FFEB225BB
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6840E82863;
	Fri,  9 Feb 2024 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puKLGbci"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598B7E770
	for <stable@vger.kernel.org>; Fri,  9 Feb 2024 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505741; cv=none; b=oFWoQzUa4rsY4JOkpZ/SPLB611xQzIuAT2AO5NL/xWcBRmZONeYajn9KB1c0ShWUM54VvzQGh/+wOFRWLbtbMHp/H+PW+9wS/XsoHyUNlGxz0yY3KDGT8+89oQRp+IAuqYVzeaQCuFMjegwCvjOoSaOO3K1PatiLaXpdjTfstE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505741; c=relaxed/simple;
	bh=Hn6SOPYX5XdFgwMPwvT7w6s6LMbj4IfWerDHMC9HM48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJWdhcWr0sWtkaIMxC/FL/ixNxwGvzDcpU8QLWCVbwsk/c+Nc4Rq2m7ZTgU+11DtIpHMVPzlfWnY6TvBZ/I1N0S724DTsnRppjcUYbh6TxR6753en6Tboq3UgzEcFqge6c5l8AWoo8RaLrDtwjok35QMPZIMWyXp6cno9nu2ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puKLGbci; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5116ec49365so1451780e87.3
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707505737; x=1708110537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn6SOPYX5XdFgwMPwvT7w6s6LMbj4IfWerDHMC9HM48=;
        b=puKLGbciUL4VksjuOxWNlrXr4ItBbCbaR38dWXj4bzB/HArU9BNBkN2JLbAEdGsbcE
         APsDPICXr0UfFjK9KZx9es0jJ10sJoRKPdvk5jrJHzlCrH2cF58Psd5X6l0gCBzKbAdE
         aKAXIm3A9RQCNut3SjxG0IOrJRJSq5n/wUqJ8IM/q05jaWlknZIn613+KezS90LWRsMb
         a8LSIwrauMxCENe+EViFVgU59OrBx2ZHMqA4szyNRLACB6estx84roWs5Hp/ic4VFpMj
         sq+1MIjDHzmgel5szU61zeTh3kooJsbvIhKS3X9elwUTJHOoQhf/9dYamkz5rpEOZ7z0
         6djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505737; x=1708110537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn6SOPYX5XdFgwMPwvT7w6s6LMbj4IfWerDHMC9HM48=;
        b=urxiVXoh71cANYBBCqfWZOaCiSc7VhCOb0cWJne6LTLYkMCKCkAmPHcqUMnwon4b+S
         GN368TyXK1ZCy4pqjgN+jgR4cLGWdQ9aCqK9v9A4OtHqb+hyvE7h72JC9Eva7z/TlJ8k
         RPy3a09cemDw0ZFlO+uZnYMfFv7yCVskvsOOpOo1jxuU6oRWIR9Xuo8sZ4V8bsvYMft6
         7f0ODvrFn6kcN0uwQDjhm3ufK53otoTBrz/M9ZsUrStpssyQgVea50t3yyOOnAiG77l4
         fh08F0VKDIDpmD6xG+WxCSGtrG4rdsVRsxAgXUmYCQ36zRzeNpiS7ca7mkHTRI08RzR8
         lRbQ==
X-Gm-Message-State: AOJu0YzjQPh4rNTIIagZPu9LCWnbyU6NsRqWPLRDfhLd5QBJzrKrWrHX
	dmrHMDIZbhC8y+QlPEnV4+Bg1trbIhsUOGzwiYdconeI9e/Moeu+QBNbU+mKMgVe322g3pAml7X
	0wCx0ldQYQhmCIFp3hCyBZr408HMJ8tY2tOpY
X-Google-Smtp-Source: AGHT+IFyfVi29qlmU5U7q8P07ZZUKTCm3dibnruRiBKwNhE+kM/wznhEvHHCqagJjnIlu4YlkA8hV8mYf3Rt88ectko=
X-Received: by 2002:a05:6512:3ba1:b0:511:5322:345b with SMTP id
 g33-20020a0565123ba100b005115322345bmr2459130lfv.7.1707505737383; Fri, 09 Feb
 2024 11:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209162658.70763-2-jrife@google.com> <ZcZ0Tb13ZG9knz_P@sashalap>
In-Reply-To: <ZcZ0Tb13ZG9knz_P@sashalap>
From: Jordan Rife <jrife@google.com>
Date: Fri, 9 Feb 2024 11:08:45 -0800
Message-ID: <CADKFtnROEHN4w8pRz7u1Udjg+Jm3kVb5meJSjGXZQ_=zQp-=qw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] dlm: Treat dlm_local_addr[0] as sockaddr_storage *
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ccaulfie@redhat.com, teigland@redhat.com, 
	cluster-devel@redhat.com, valentin@vrvis.at, aahringo@redhat.com, 
	carnil@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 10:52=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> On Fri, Feb 09, 2024 at 10:26:57AM -0600, Jordan Rife wrote:
> >Backport e11dea8 ("dlm: use kernel_connect() and kernel_bind()") to
> >Linux stable 6.1 caused a regression. The original patch expected
> >dlm_local_addrs[0] to be of type sockaddr_storage, because c51c9cd ("fs:
> >dlm: don't put dlm_local_addrs on heap") changed its type from
> >sockaddr_storage* to sockaddr_storage in Linux 6.5+ while in older Linux
> >versions this is still the original sockaddr_storage*.
>
> Or we can just take c51c9cd8addc ("fs: dlm: don't put dlm_local_addrs on
> heap") into the relevant trees?
>
> --
> Thanks,
> Sasha

Hi Sasha,

Just my 2c, but backporting c51c9cd8addc ("fs: dlm: don't put dlm_local_add=
rs on
> heap") feels a bit riskier than just correcting the call to kernel_bind()=
, as it's a much
bigger change. Maybe someone more familiar with the dlm codebase can chime =
in
and say whether or not they are confident with backporting this change.

-Jordan


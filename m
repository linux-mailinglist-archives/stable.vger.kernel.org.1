Return-Path: <stable+bounces-125833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E05A6D292
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 01:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B03B1291
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BEBEEC5;
	Mon, 24 Mar 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmA8mt6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D71917D4
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742776203; cv=none; b=tCRk2/V7PDHkIy6Nbd3CKHStuY3OthZlAElGp/51WyKIlHaRP4LZSLr6dYWkNm7uFT1+jJpd7SRyxP5kqm8ouO3HjOdrB9UXRmQ6qXzOysSlsN5xCQ2yMMwx4QH9jdfFY5f+dfn5SjgEXRYpt9vs45bcqeue5YLrlPBFfDKLnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742776203; c=relaxed/simple;
	bh=kVukTtvGlb5RnblVCBLgFLxMCdEyUChD0566UkZwzak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWvdn8AXKnBxv8OTpSm0tiRSOHfDDiVPVbNptglw7dgtv7LndoFSPTkstj+PyPPnpmrtLMtNlMvvFOmUo++BvW+C7tkevSH2O1wZX39G07556mlNe6/g6s/0HEgGHf2Qo0L3/b6Ogn/Dq9ZwEsy0B+Ge4rsbJOmCb1nF/ycBBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmA8mt6o; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e589c258663so3065239276.1
        for <stable@vger.kernel.org>; Sun, 23 Mar 2025 17:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742776200; x=1743381000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kVukTtvGlb5RnblVCBLgFLxMCdEyUChD0566UkZwzak=;
        b=VmA8mt6oktAP5v/Uk05fLSSZkXp8T6ktNylBNzBEsZj63HR9sYKIGJom0GW+z38PEE
         vRXbJIMu0/aHQFyHuFA59tkgNYxG0JU6+Ebg6LB8vTfWZzm4IbqOYtNmDUlUV5QwisGc
         XnS16x0PffaYNwsFD8lYsZf0MeKHXVd2LBr/oHCtLufj9S+DMWLdjQ1ebUUEKdh53zXQ
         2r9DRnZYs62dQE9mzrYOwCxTuRvDjGWe2YOpflv/Qd5E956cC/nrn/Rk+3nqSB3Fz4tA
         ublwHuoaBltfT1+I+wKWxFnTPRtFH+qd+Pjon16JS+/Tpu4wOwBu2ojRhP4J6kDgoXuu
         pJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742776200; x=1743381000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVukTtvGlb5RnblVCBLgFLxMCdEyUChD0566UkZwzak=;
        b=Ks80vr4M8ntZGAJ0xiBFnq6aiVkP+o/rZfEIY8tPBjpxBxzeGvZQEGHoKY0qwaja+U
         uYvUVQQLPclMTvq72LXpm7exaY9sbrJc2NMWi+mOULgx4U6v2uQ9quJFQFejZjGn0s26
         8Ykc85of3ns+DdN56qsBlV9FHMfvt39Jh5ebHRw54rH4an73ON/RvAVLjZaOYTmxJ3Gt
         32uxF76N/gto1v22Q1oazTpQDRRAnlPQ9BFtBhiaCXL3c9a8X6HIxKjAsG8h+m8oG4jD
         qrPjR9UOguZ/5DJerPwIOGmbKLci17TMKfJm9hvsj6crQ09Yj0OzBVyv7VTRlMn7IL/g
         UfJg==
X-Gm-Message-State: AOJu0YwBcM3Ry0mN4i9q538jol0nel4VMi01FTn8nc+gflIZcNXNiiMD
	kDK+1hiTLlAN7+qpskfaQZXlSblEp+Fv/KBOzREuq9nxb86xecL716thqZC50z5iqgl+3pD/Pql
	eeLSZxRF5pkp4wrFkzkrOaUGtQyk=
X-Gm-Gg: ASbGncurmhcHRH06u+urZIGrGKzDvUcpgJi9ZBClXPF74un5j8ZCJHvZ9+djkxV6w19
	6oYlHO8XhTtUJASakEgMSDOE40avMAzRpwKcngQJ7vAxMPs6GooQSOQuldycwtesXi7lJwd1Yds
	nlQvmWadlgrVlKCPu7+16H3Bfb
X-Google-Smtp-Source: AGHT+IEX25pXoivHozV/dBN2hgpJc4RlJ9ILmIwtsuIPlynN0xqImEfHzdc4CBPx/2GvbQCPBfg2fgPLpq6OSMLH14Y=
X-Received: by 2002:a05:6902:27c7:b0:e63:71cf:7a25 with SMTP id
 3f1490d57ef6-e66a4db1644mr13885045276.19.1742776200521; Sun, 23 Mar 2025
 17:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313202550.2257219-15-leah.rumancik@gmail.com>
 <6pxyzwujo52p4bp2otliyssjcvsfydd6ju32eusdlyhzhpjh4q@eze6eh7rtidg>
 <CACzhbgRpgGFvmizpS16L4bRqtAzGAhspkO1Gs2NP67RTpfn-vA@mail.gmail.com> <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
In-Reply-To: <oowb64nazgqkj2ozqfodnqgihyviwkfrdassz7ou5nacpuppr3@msmmbqpp355i>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Sun, 23 Mar 2025 17:29:49 -0700
X-Gm-Features: AQ5f1Jp9OpVOP6OZFxD83-ETLMNRRrwIjrbHztdyPEE-Ry56imRvEvrMMQrHqZA
Message-ID: <CACzhbgQ4k6Lk33CrdPsO12aiy1gEpvodvtLMWp6Ue7V2J4pu4Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 14/29] xfs: use xfs_defer_pending objects to recover
 intent items
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

Okay so a summary from my understanding, correct me if I'm wrong:

03f7767c9f612 introduced the issue in both 6.1 and 6.6.

On mainline, this is resolved by e5f1a5146ec3. This commit is painful
to apply to 6.1 but does apply to 6.6 along with the rest of the
patchset it was a part of (which is the set you just sent out for
6.6).

With the stable branches we try to balance the risk of introducing new
bugs via huge fixes with the benefit of the fix itself. Especially if
the patches don't apply cleanly, it might not be worth the risk and
effort to do the porting. Hmm, since it seems like we might not even
end up taking 03f7767c9f6120 to stable, I'd propose we just drop
03f7767c9f6120 for now. If the rest of the subsequent patches in the
original set apply cleanly, I don't think we need to drop them all. We
can then try to fix the UAF with a more targeted approach in a later
patch instead of via direct cherry-picks.

 What do you think?

- leah


>
> >
> > Also, the backport set you mentioned was based on a set from 6.6.y. I
> > don't see the suggested fix (e5f1a5146ec3) there either. If it's not
> > too much hassle, could you see if we have the same problem for 6.6.y
> > as well?
>
> Yes, the crash occurs there, too. And for 6.6 case it actually is for a
> released kernel (since v6.6.24).
>
> The remaining four patches of the original upstream series [1] - one of
> which is e5f1a5146ec3 - can be applied there without many problems,
> fortunately.
>
> I'll send them to you in a separate thread.


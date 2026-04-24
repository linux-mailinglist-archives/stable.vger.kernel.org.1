Return-Path: <stable+bounces-240968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIdjNLV162kQNAAAu9opvQ
	(envelope-from <stable+bounces-240968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:52:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ACC45FCE5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44C3D3007A7C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F03D903C;
	Fri, 24 Apr 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkNjGAb4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373543C3440
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038758; cv=pass; b=Qv4LRZxGrLmWx/GFFOuuTULJlnVSjpC9D7IRfipklBpzw76WVbCF8R7Uwhk3cKy81lN/HXHJoAQyV7llX7MyYhu7v/TdBJ9Z0uxgE1ZFuzzXjoPbzuYx6gjhhN6fcoBYJOmUW3SrTslylym1H+GIbnT1JTaEilHbsQtbq/LIO4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038758; c=relaxed/simple;
	bh=/kNEUq4+vMrJehBhGv0WTeFng4QIMYLHowGQS7Rn/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laC7jlVPvb1SKnrZ2bZubjVbKmlzw0CnZxJJUxmXTH39NDKfznhd8Hgu5WrX8WmMBHhcDayWnHShA2AB/3WlbFXIDSPS/xXp8LPjqI5It5bKHWoBYNVSgaEYDdAMnCY7HfWv3cpZDAVOkjgpc9umkrGhn3UygiyK1tQ75sQzYlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkNjGAb4; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so1935954a12.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777038755; cv=none;
        d=google.com; s=arc-20240605;
        b=a79jsYI5dK8VdoQ/ItSn/XrfeluFernbAvLLI163dJI9yEBbCr5KsvchA2ubMdqgvZ
         9Ys2jI2mFnV3tHnbTJXtpZ2/QdNEb5bB0V1TwacJ9yo9Xns9RoX6ZGb1yoriG5pQf/Co
         RSqkf4sl9743tC3jCTCVUt4mGm0TniulA7Sgecotu6rNGjV6QYFKXyOxT1DJ1DXVucRU
         2XGsYtXC3U6gXxIa+N083d95b42+m2IeRUxkR1h3ml1r0MvNZJdGl5SvNvcGA9kWrOCU
         i68h6eoE+jRQBuG4GhsF9Sbv/Iwd+qojw5yC5ZcyB53Ng66inPbDWwLTnc4Q94fudORy
         ep8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJJT0JoPIZZHN/QqfMLvwfSqlNJF6a+bk91astgGZbs=;
        fh=auQ7KU1h/rwn46mlxXE1QvV0rSXj9N9PtRErziEmyiE=;
        b=avv8Yw0qHgBrohMLJERAHZS9E+goakKUDyrwaCVr8X0vuXwxLXwSRUcWVnh+aljD/J
         iAJAlQ2g+XicfkAWiRaRpBoIqmyZkB9CXk7WQp1d85aWDL/5hvXzrWyEGwg0G4HJSBgm
         9TJUPtOIe+iOwCHW0N34GJdl15o76sdqB2UKqeV/iyR2fMgnGrabPE4It1krAcT8s6YC
         l3Iu+G/wvXorw9C/9Yd/7UHIiyOrDOiZ4sx+PPAtHe2/1jcHHgSAgUM4GVUD+A1E4vZR
         q58Jyie5uyyy5csW49OHcnN6yaRFARhSezX3FRHbRv8NN0wOaDd1Cdql9zE9/pBN4lI4
         +1Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777038755; x=1777643555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJJT0JoPIZZHN/QqfMLvwfSqlNJF6a+bk91astgGZbs=;
        b=pkNjGAb4njl3opb7rr8ARVz2X/cGMJozafUsICGruDsy2zTufNLdhMP0bpe3pS4AQc
         hpZUOYey0sij5zjb2rbqscZ4KWHI9bmd6kjnwL96ZQLoDxuylcG1VpQ8VJxGZg422HxU
         VjtoIDPoMB5fTEOj7WmokQFx7Yoo2HY9T1V2HsEEmWemLi6+HJNU/xMA6nIAATPsdYxB
         Cyti+wftXiNnoeuksRg8b080LWymj7CY+3KIfYLJUxHRA+OfXkSwea3tw1bSjkcCu8tn
         QY1K9TK7aaZHriVKtAfbTv7UoEerHbHC59yuFfFOyRAAhP28rQVHtucdT23vj6J3jpKT
         iGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038755; x=1777643555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJJT0JoPIZZHN/QqfMLvwfSqlNJF6a+bk91astgGZbs=;
        b=gkvWu2b5eETxqqz8xySXmiUnDR9+wg15YFGQk7dWIich9prp7Hr592gxYSgnt+9541
         tI4iedpPohIg3s94RuLko+BYFG6A+FiB8p4YkD5443u7gyFQHD7RExU3nlbrNdQZFzgb
         T8ZYtMZMZ2xf7DNvVnS63kG6ga4wFG1Di7T9EP8z2xCJV/yvWFIvkqmHI9b+3Hs/ueSE
         9Djg/xT4NoKSqiGPz4C8B5l8sLTg148PHtSbLymbxf9QmSqlyrz7pnWUqW8T+bev5H/h
         2HOIP++OFrlsYs+hITE+l/kSecaiX1PuutTfNKaIbHr5qD99fPK6vryFUnBgB4562wWb
         7Xjw==
X-Forwarded-Encrypted: i=1; AFNElJ+wRf1d46tyaZoqY4YiNEOrD9aSfZXfFvNFETbcICfX51QiBivl8vvzk9W6IiZNsRF+Lw8rA6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjck2UJygXoG8I3OXnfL0vzQvTaqdFnp+PAzlESmcNdlv01HpN
	bCKu+f52isWJmqEWXIvCadXoGya6mpRlcM673IokvFDKcmP7nzePZ7Fk9qM8Mk+OMVekCPXr4Ce
	sYePEWpadY9iXO46pml82aPO2UscL7VeMU/AwB0Yg
X-Gm-Gg: AeBDiev+y1SmfC3BqQWA/GR2AN9LQpD99/rjyT1u6O6tPYj24vqrhfC0iLEGnF9hm6E
	BTEtm+hNVVn+eWjTIdK3xqzuctJeJYaQGIcv6ATdXZwS84ypME4/b4ubTmOQqORLXCpF1gbsZ2t
	FLt/UOhNX0rmwdF0PRB5zUMkMeuiG4cdMv5u1L7bogjFaC7z1fWs3yC7ZvE0lLTw4UUl49Xwt5B
	MjGuNC/ie1lOXIytqYJ1nL3RNyK9N/Zf3n2yw+zS3IcH88UM6dFW7hM08+ukhvbID+VGt8c16zO
	wwhSt84qAOgWxMLvOHu3ZtIohthB68Udv9LKoOy6Jr6C2rDgPnzlya2MGLA1BgGj1mXdqg1mI0L
	t+kBZSKCWDiOmIFJw7Is=
X-Received: by 2002:a05:6402:312d:b0:670:8b38:5717 with SMTP id
 4fb4d7f45d1cf-672bfde2984mr8860876a12.24.1777038755002; Fri, 24 Apr 2026
 06:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026042433-outwit-cognitive-f970@gregkh>
In-Reply-To: <2026042433-outwit-cognitive-f970@gregkh>
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 24 Apr 2026 09:51:56 -0400
X-Gm-Features: AQROBzDJC9eu_b2xQIeP4q9m7u4xd26yz65cE70L66aUTsOtNmQZXfuDaxpbOmg
Message-ID: <CA+FuTScyXkgugNyRoyHUTSt98CQEzGv=2kGH5Zwq8ho1Q4_+Bw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] net/packet: fix TOCTOU race on mmap'd
 vnet_hdr in" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, patzilla007@gmail.com
Cc: kuba@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D1ACC45FCE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240968-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]

On Fri, Apr 24, 2026 at 5:50=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2c054e17d9d41f1020376806c7f750834ced4dc5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042433-=
outwit-cognitive-f970@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:

This appears to be due to feature commit dfc39d4026fb ("net/packet:
support mergeable feature of virtio"). Backporting that is not
practical, or wanted.

The actual conflict is small, on conversion of direct read

  +              if (po->has_vnet_hdr) {

with cached function variable

+               if (vnet_hdr_sz) {

I think we can fix that up in a backport fix. From quick check the
conflict is the same for 6.1 and 5.10 (i.e., no additional issues with
older branches).

Bingquan, do you want to send patches to these three stable branches
5.10, 5.15 and 6.1? Else I can take a stab.


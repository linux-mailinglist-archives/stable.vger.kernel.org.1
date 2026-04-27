Return-Path: <stable+bounces-241202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEWTB9W87mlQxQAAu9opvQ
	(envelope-from <stable+bounces-241202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:33:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94A46BF62
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1244300D941
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9EE2594B9;
	Mon, 27 Apr 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmsTlKp7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB02236EE
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253551; cv=pass; b=kxTIS5wNhjidOp21MvG4irit9KjUQo4Qa5FLemnJCOgj0VWTKi+UVcm6QyGDLjIm91KdGAIUFzmy4GVRTCn16kZdCy5UU09Ee4kb9im6BrCG4m3PxSyw/eoSzQ+Pg0OrV4uXOU6lpnQU1EL1Nqx0ZgPYlJv8rbfIMgyid7J9Tks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253551; c=relaxed/simple;
	bh=y+G0oWOXlpQW64UlBYANwp3syD6CPAqjbzxnvB9nUxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c073DmRVyH4yK3gkQLWpyojQmqxgPgYegUAr5REscxpFIdDHCUTPYhduPlwOA9ALTHj/6GTGT1TpHlb0/dMzWJJEiooiaIRmJMfJ1W8+msJtAePSIEZHheDtMhvp8DENk0+5X+IXNnDIe3Ouxse40dX5caT4xIjZ7LO65wsPHxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmsTlKp7; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651b71f5cffso1148779d50.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 18:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777253549; cv=none;
        d=google.com; s=arc-20240605;
        b=jwjCc3uKZW7T89E5l9wXdCuIy253m6sOgiXnBw78mOKT0gaNmAVcgyj/rdCUkXohaU
         Yqkxb3ibDU6Lfb9eZ7DN7jEz7Vk256fxrCtFWUeAnXyt14ZpeM4LxWslpvY3/0io59Y9
         7hCm7l5eWDU2D/lrKeOWhZKEyE7ZE0rVtsMeBoN1wdqCjDIp/l6iuRDDc5uq5l3fN+hj
         Eh2UOWgcQtJUzqIWwrP8Gibs9XOSjuTc9Wgmv4/QBSrqXlmaCbPbH4bK7tyaA8I/WsUA
         cR1L6utEyWmtIe+FdJql/zZyyzLqZqUu9X6BxScI+Crz5wQFWqXKeWWYPzk1lVpL1NbQ
         VxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D3XjL8cqpB+iAJRsk6beyhlYPIlA8zCv1g5vwWdh/Ok=;
        fh=90k0aRkwqNxtJR1NGXKkTeggvFroN6NO5snHueifh1o=;
        b=N5OzBJR7l1ltFrUSXhnAaEb88Ag7tC274QS1g3A1j8cEzPBZACDsFuyHBoB6igge2e
         5TRH7uNFqcW733lSA4wTuCkI75SgVNY/49rOG78tBytQkiNbCAXeNpcs7qMEJcES+tTi
         RLWJ7bn849XRnxnIKjFbGQ0FQQS5+sGWSCdZrB5Z/VPYR6gcjrcz8EKvIW7XY/KClz3f
         qjBt1soUIw9hmTRrA53BGUduqeAIYCqXbyfdKPq0H5pc4TO+EcsGABnfDEyd+J9Mwjdx
         wsTC9qQUZ+g+bXrIpxxDziWBydRSnWOCVuuEcb4ngoyRY96oRtL6y8Bw8tR172APdd67
         tGkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777253549; x=1777858349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3XjL8cqpB+iAJRsk6beyhlYPIlA8zCv1g5vwWdh/Ok=;
        b=HmsTlKp7DRwIsf0ato9z+ApYvEKJZmCNbmGBRaJ3Zyy0DkR63U66h3HAm9g+HZM0JU
         OElVjf0G5f6QrCmv+ZSWaiGreFP2F6N3vs6kM2OWVblGCUCxMQhLCWADBreR/7tCfbVa
         gQekqmJgZfV/JcuFeO8bTQsrvfUW67kcBFEYELcBFOzySaQtwhA1/1FIhx8VtTL8JEuM
         5vyWL2kZg51qXj7FXtazZ+fnjTHXu1/DqIuth2rBmUwV5FqsDcXdKGkOs2XVpJefDa6I
         vabs53XzaCU9jmRv8J/HrcQb1gfqPjd9LXIFdgLsahfj97VDBM0g71uh1r+t9zW1Ft3U
         Dthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777253549; x=1777858349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3XjL8cqpB+iAJRsk6beyhlYPIlA8zCv1g5vwWdh/Ok=;
        b=beNQzEDo2unA5q9GPaVPVkhZamNy9CTjSafJybv3My6IqwYhpWT4ybKYaAM4oDb9TM
         f4P1CBA9pqnLXQotE9HogGbgJbnnBjHelMRavw+ELsiMhW1mn8k0GHCJXfk0CXW86z1K
         9FpKbc2pqDD1mPIyx2AaXeqWxHv8txDycOLSS/7c1u7WOtZPkkdbVdMh9L1ZAXb5qa8Z
         y6XxyzftT0ndGhwbQBAU3i1PGot5lJpOER5BGa36dHf9iIhNf06doweMCa8cvNc+DdxF
         sq49NsNFMEOM41Qy5KFDFNSBjkc1w9vt8Pvhfaei121mRA0zNy/VMw/dCpuRZRvQ3tkH
         N1TQ==
X-Forwarded-Encrypted: i=1; AFNElJ94Qybc2/CsSUD5J7EX+8v0fpGmmVTPBC1WiPzMzPNwt8gu31YMRbKJkOm6L/6gXXWo9sS7m9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEM7VfeQwcnvWe8+N1/S/XxDgDIStWyl/SMwvg2Le44Hpmq6xT
	AmDZ8zlyld4hmSk7gjIpZiE4y0ki1XGiuqmHkM3QA8xbVQmNv1CXz0TXGHuJUsJDLjqeRv/SSCI
	JHjnZsNFjqObKHXdmTl9PDfmPrX2ZGpQ=
X-Gm-Gg: AeBDietEhf2svsuKleO4wpd7kywWT9UetGIzbu6VPxtRjt//3ANOIwqj1Zsf/RFzbab
	CZNAqRUdhE+6hPuNGmZcfQqr1cbWYVFsWeVWi4k0uVUp/ebtPT8PUFsu9/bKQd/zAq5c3h7SHWU
	tKi/ufX2TEaUq6HSuIFwxcJOfipE65kBGiX0KWAgYXDxvy+SisY0uILD7T9qi78ihRTeWN7Y1b+
	k7Z1xSYHv9m6GQUQp8/Ze6EJPn3iuG14ku+fQL+g+VuftLadcxqLKbYmWtqwZxewUsVHzrkdWfK
	RMY+GcPP781VitaZvMgWhYhkkWY/Xwn0eJaGmIgs8WSbIa+QytA=
X-Received: by 2002:a53:a844:0:b0:651:e0cd:587a with SMTP id
 956f58d0204a3-65310b49bf4mr18006946d50.7.1777253549333; Sun, 26 Apr 2026
 18:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425093829.4004785-1-charsyam@gmail.com> <20260425093829.4004785-3-charsyam@gmail.com>
 <CAKYAXd_1q_6jXT+A17s5Q6JgUFJvYAt4=GJ3vYG7ruz5x3PexA@mail.gmail.com>
In-Reply-To: <CAKYAXd_1q_6jXT+A17s5Q6JgUFJvYAt4=GJ3vYG7ruz5x3PexA@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Mon, 27 Apr 2026 10:32:18 +0900
X-Gm-Features: AQROBzDHhx-e8S0vlMohUSgaGGrKXX3RzxDI0zOAUgI7i495nH5ec52YhQr4nAM
Message-ID: <CAMrLSE63_CAqUn5JXuSP6RfLMh1r4KArxLet4H56mRudWo4ycQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ksmbd: centralize ksmbd_conn final release to plug
 transport leak
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8B94A46BF62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,chromium.org,talpey.com,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charsyam@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

   The intent was to snapshot the key returned by idr_get_next() so
that the idr_remove() target was a separate name from the
  iteration cursor =E2=80=94 the body grew with the two branches and the
unlock/relock around session_fd_check(), and I wanted "the
  key we just resolved" to read independently of "the cursor we bump
at the end of the loop".

  That said, on re-reading the final shape, id is not modified between
idr_get_next() and either idr_remove() call site, so
  saved_id is functionally just an alias. I'll drop it in v3 and pass
id directly.


2026=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:07, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > -
> > -               if (skip(tcon, fp, sess->user) ||
> > -                   !atomic_dec_and_test(&fp->refcount)) {
> > +               saved_id =3D id;
> What is the reason for backing up the id to saved_id?
>
> > +               if (!atomic_inc_not_zero(&fp->refcount)) {
> >                         id++;
> >                         write_unlock(&ft->lock);
> >                         continue;
> >                 }


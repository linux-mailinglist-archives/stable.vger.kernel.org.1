Return-Path: <stable+bounces-253446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKmnCveADmrC/AUAu9opvQ
	(envelope-from <stable+bounces-253446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE1F59E8E4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250603036741
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B5384CE7;
	Thu, 21 May 2026 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vt3yc6CV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281654654
	for <stable@vger.kernel.org>; Thu, 21 May 2026 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335377; cv=pass; b=M1kq+kW0vYO0rynTJ/Bjshrsrc91Y+hgZfTqwGYO5GuEmV0EHsK0N6mFoF9dcYb4OtwL8R9hm/Sehx+eF7osqYiYz0/D3WrUNArW0049lQ0exV+X6INriQeGbK5Oq3gfRU+wNiDurpVD58AH6A7Jqt8M4iyLluQO7SxmfiesJb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335377; c=relaxed/simple;
	bh=C+j4X1EjiAtuojkhVY0wXUNdkUfSZvrxMgm1ZzGtmaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEbe45umaToKmyaI3RlwIh7NblMIl6TIfgq9eojO8dEGfQhcwttP8gRtqP5y8jR3NoWgoyZzbQESmvkgUK1G/eSFHTI0Tzkve3AJgyFSIPiqj0f3uZJ8wxPdR9zyftxMWWEpU62RKFkxZKgSJvKJeiWvuZgWdl2VsvlWfmuHBDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vt3yc6CV; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d6b393d60so9021cf.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 20:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779335374; cv=none;
        d=google.com; s=arc-20240605;
        b=ZP/NQuQqMyIB3BtxMRfAIdaJ0YPSewRCjKO6PBV09pW1Mn4Br+JZi4dl9XswqTAm5O
         q2MVhTl5khf1FEdJxFkrqk3EOsWlHxmR1lLF/hQ7S+xRrbHf3Jdwj2Ey6AV3+5BGePfh
         g1nP0+aRuSB8gwZbCM9pLjwpl5RFdJLyE2Q06ENWmNzu3gECtHT0uxB8ZXeRpQvOH6jz
         eq6yZ4PcZ8uUBN2gHqNvHOk/54ZE1cI9cPaXbw912h8YHYo7FmmrLHqFX68XqKxqihqn
         iJFyFglUbFFofSQcj4r08xhOwxs/ThqfsPvkkW3tCu5pt3wU50eiiJJUV6cSMjua9qPf
         crZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        fh=txTKys/HdIvi+gHOUMNRu1vTCy3CkTS/2GMfNtyUkUU=;
        b=iBhDKXtZ3a3IwDYZnfN89veKesyfg+pO+1khnkW21RWeIRk0Q4MEwhqT+zo9zf4mGX
         IwrzyeqbJZyzPawSvjM/5x6lU5E/16hjVUZVSNtvzoKvkSPRMiEUj35Ua/YB3l4Sfcz2
         59XTvNDAY2fB/f+y5GpQSp2d1kQ4EwLl8eaZiD0Vjli46tOYvZZrDKmGQnYg6h/dbkVV
         s7laq9tYYniQx+fHTmjIAgrVMNKLzhnnejZBXACHxFJ2SePj5Y+sGrVlppy8ynbDluah
         eQywqdq995MzR6uMUnZqZnaM2r0PHoFbyO63++7jHN1i5hsdNfqP2ytVxmkn4BWSaKkm
         EKlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779335374; x=1779940174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        b=Vt3yc6CVONlNtbBeota7aD9LHSGYtgnxHBpf8Uk832vqkG8kWiZAJz6f6Tu84mlGPc
         4ed/xs5/BhbqVZxc/hI9rl28GWpN3YBlzAEN5sqmBYiVzGS5eMp9EH71wnPW82eBI2of
         QlLnqmUH1qOIob6lypZ5nkblLWC8N7luNgt0RN5owwAEuOnvYD6T1Nx8wotxeQhyripm
         SEfvtIuYx0iem0A7uH/jpkL9j/6P6L2dAuT9CpB2TQBfTIa86duysux41JEqXgeP87hh
         NvcgWW9RvVWWVuAdVlBzQ/+WQ3XVCUq8hcub6VodRdYfYC0t9qqkJKKDUDdmM/Xlfcxu
         wwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335374; x=1779940174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1qmBd6CsYV57a7wsuyvRdWAzffqjmM+Rz5NWT6mUuc=;
        b=bw0Lm8WjvPW34uXROG1clBrF8m+qHQoEn9in9zsawlO7XEGxxG5m1MFGoS4d3HJnnV
         TvYOXC1/jhM8objfcSOuDw+FsmIb4AXm/oQeJU9C7trMJSjpFDcOSonfZh+4+Yvvpnx2
         xBbh9vWui7/93PfEsRafU7T/HZbesf/q7hoRcHze5flDgwWs+p88wQ3rwBaUhmYkWTkr
         yddPiUU+dOSV0SWDqvIQ/hnt0tn6yNinOFlPLlXwAoSmeWgGqs0sBShqFbQupkEE3wn9
         6VDsZhBhMv+3jHrtuyNm+7fIZGTEVVxM81GtNw17Npd+eLLwxGxCB2La52O3MlxP0z5S
         bnTg==
X-Forwarded-Encrypted: i=1; AFNElJ8EMgZKQnq9kG9SSTSeDvA3R89REIe6hhfSHuL7ZCP5ABBPAEI++mAHlos+MDvwTFeOqXZu6lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CPhtdxS3EDqCHIy7UMOIpauaLurPMS/CTo8wtpuzTghJPuBm
	MF4vWNE4T3deGI1GYp2akItX+wYSNkuE+O9OIZjld/x724Ir9PuMdaekO/MaTrvooZQuaHAOrJz
	rUaL3sC2KANrHSOD3FHUSxS8qCUlKGLCAJXmU/PAM
X-Gm-Gg: Acq92OHy9r0xeZKwNQwRobLzX3Ok1lWmC5K/JaIGOp8H3qSrT9Yx9CdzD7OBjeMNy16
	2oCCV9+xh8RmBcGsUy214/S5nw9IBREPfI4tjbEV8rQ2H/F6bvmVY+lUyTXPdttvcGqe060pkUQ
	lNBIAofXt2N1Pm/YWfHVKnP5w4FUQgCrtFrEyXA4hhss3Cvjrga6MhTOb7zXxfGHTIT63dUpA4H
	1chnqR3ovTKa9Dx2ea8+q8ZXQ732Np25ZRRjPBINysJDGRYyfpuWKppY8+ZFAC0Ci05aKikdMp/
	TnpZ+eId69lxZpoP7RhVFU6wA2GF
X-Received: by 2002:a05:622a:4cc5:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-516c552713emr4320271cf.19.1779335373860; Wed, 20 May 2026
 20:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173449.3282188-1-rananta@google.com> <20260520125354.2e028b46@shazbot.org>
In-Reply-To: <20260520125354.2e028b46@shazbot.org>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 21 May 2026 09:19:22 +0530
X-Gm-Features: AVHnY4KgzM7bdCVNXJ-bEutq8PSATbXFCM7-DWURJaNecJOqaJz3xIil0Q_IlMM
Message-ID: <CAJHc60zA8Efs41dLj_JLaeVun8toTxVQoRPoPWNW2oJH-bQ47A@mail.gmail.com>
Subject: Re: [PATCH v2] vfio/pci: Use a private flag to prevent power state
 change with VFs
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
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
	TAGGED_FROM(0.00)[bounces-253446-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rananta@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shazbot.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7DE1F59E8E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alex,

On Thu, May 21, 2026 at 12:23=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> On Thu, 14 May 2026 17:34:49 +0000
> Raghavendra Rao Ananta <rananta@google.com> wrote:
>
> > diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_cor=
e.h
> > index 2ebba746c18f7..f1451ee4744ac 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -127,6 +127,7 @@ struct vfio_pci_core_device {
> >       bool                    needs_pm_restore:1;
> >       bool                    pm_intx_masked:1;
> >       bool                    pm_runtime_engaged:1;
> > +     bool                    sriov_active:1;
>
> We should drop the bitfield use.  I still need to respin my patches to
> cleanup bitfield races in general, but this looks like a runtime
> updated bitfield without any explicit locking convention with other
> flags in the same storage unit, so should therefore be its own bool.
>
> If we agree, I can do the s/:1// change on commit.  Thanks,
>
Sure, it should be fine to have this flag as its own bool member. Feel
free to make the change.

Thank you.
Raghavendra


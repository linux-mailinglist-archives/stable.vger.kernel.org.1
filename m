Return-Path: <stable+bounces-227267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJdxNrLbu2n2pAIAu9opvQ
	(envelope-from <stable+bounces-227267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:19:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142D2CA28F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99CD8323E3A4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF63C73C8;
	Thu, 19 Mar 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3MEIyuO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334463C73E8
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918841; cv=pass; b=mu4KiG+dTU7aGtUq7GbO4R2zf0L2mm6ApsGkhCbWy4GosneOcVQAxbeEied11abdURKw1HWz6aqQEM7qfhWfKj5dT0SOaqssXJKIxK5B5QCqlIoRwBTFpvOcHrxmUHVyQKT6rDH5aNiRMSGQOOlMtgX1OdpPjdllGgqezxzD630=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918841; c=relaxed/simple;
	bh=zUxBGlJ8iBNcfWPMQ3hQPJuAbRLGJJrNcunwQQ/mDLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FG3IwtY0ZCbUotr7xlz7fftCTkCr4zU0R+2ISBU43q4Q39nrCJb832sjq6s0qhK5uiV4HD42bdgl8k6yjL2C4bZKV5UplE+apU4vvcJa7AIFb40V9w/HiUeW6MEGNMqXTdznKXgSH38tNKPK9u8Tyn5wlGXp5AW8g5hiX2Bxg64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3MEIyuO; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso1196412a12.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 04:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773918837; cv=none;
        d=google.com; s=arc-20240605;
        b=E1oOWBPdcGlFGcya+oDkPEqYmWQz1cVBEEVHe/fyhg3pyXgMENeFrbu38HqAkiAL+U
         XB2BdtQ36ArKZmLAQrn5FXdaU5+GDh5jWSkkITxafcoLYZZYTg+kMQQkvzSBCgyptTSe
         yvQOJnvE65R7KkXp3W1CZpI1snDtljSUvLtPj3mHR5WOe24iQDgC8phg9mMxbZTbXep2
         SuRcfe1iCGB9jzzi/ShLgtH+JOrXc1mBAd9+Er0DKWU3WA/h2exq2a6l42SY2x159HKu
         /FCDefKj0TmzZ7NdElPJ61+uQ2E02Vk+xw3ugWab/yU22nuOvfO2n8wcz1lCxh7m73dc
         1A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQCqdWJc5ct/Ln0671uNZA25+9pYlVYY6Cy461/f4q8=;
        fh=eqoni1I2FKUth2ALfFKsfgRyJbkikOOlDTgj5AKcUoQ=;
        b=AEXfs5lQMMNtP1SEiIQHyy+/c64g0xpGv0StBczT0rOhvjKk2LlX2heqdJ80Cp9nlT
         Lm2HaZ3BsHlhle/WYm5niMj7bBGHFPybgioXvXELYbrNhcGEEun//4tJwnSl5INBfApy
         MDaOvwJOBOPNIzTzyvjt1sweqARteUuyx4HN9uXnZ7gMqRNCv54L5Yj9M/sJue2hBllV
         idwgtrNzD5/qxwGubUfelG4khmNXcymy5w9IAmfaHhvj1KimH72leW8UoG5Wq6OIFUfh
         /4cQE97GQxupDTv9UEhRxQQDyAYtceUkoDTIuRABH01OAnYpjTlw/WqfSJSn/2e68x5d
         oPOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773918837; x=1774523637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQCqdWJc5ct/Ln0671uNZA25+9pYlVYY6Cy461/f4q8=;
        b=V3MEIyuOMYszancQ12oQLhGYdbGu3jDzTlJcU/DZX5KcgkrpImu3p9PfZV6Kb0mDlr
         v2PgdunJNZUGZiXNsKnvqpcYQ6YzeSwrnSruvRI1249vLe9neFQ5qZoMwZn0mJLR3yg2
         /UXVHmmP3yA0t/wNWOjbvsbpOkm5e01mMRPyTGOIYnOR3cjxOPgu7p236YmYTjSXiWp4
         OfWBN3Me/o7UFOs6h37w6+tjRZkzJ/zPDzisxRc68Ib43HCgy3rPERZ9cbA+quSYGUtp
         uknwfE33GonByhoXMBFd9l1gharB9G+REQGPxqxsodHK6XSt2KHh8Hia0ufo7qeAQyx4
         rJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918837; x=1774523637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQCqdWJc5ct/Ln0671uNZA25+9pYlVYY6Cy461/f4q8=;
        b=LliHiVZ+MlDSMsZ9/9M1Ft1DCjby1lg0jL+SpakXhTimLSAMT9Ta/lj4FnIBCCswyD
         UTTG0R6/eaZynCu5e4HHwWv4tSowJK8B23KZX601+4W/KkT9pr/yYM8u/u/ZNrJfNwV7
         VPlFHsuRWC5yTeBW4M7OVSLhhimRLXkNAB56Ci4+Z8xggWHYobhizNPv65PkPfH/U01i
         OXjkehFmoNH4ea26dc3U7tltuxPBknXUNfOKb17pvnNYTvoMuVG5Bup6h38f0X6lkl+G
         r2aE0vlgDZAO6leoG6BIUDqzA2OFES9XbIhv2thUUsRDiggd33VITMboIMQByf2+zOYf
         4jzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzzXWXijX3IylYGeEkYfcH1yI6z4oXeulQcZBCpRE0Xygo2mkDsoQoo6S4EQaGZQsSNDxf20M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7e5ptL9iOBNrqzQtpkj1H2U7s8352G7Qt3rl+NmUOarg/04y
	qdAQyFZfQQGpeu5SznbhegIgbKbNZM87P9f8ZREF10Wj1zvjAL/52NvDWHXLArXQpA3TDzI0noY
	uStdAuo/W/1y+R60mXyF44wFC37wmO3o=
X-Gm-Gg: ATEYQzyGrrC0lg653deN+wJmxUSX4Xu8NfBrDE4i8KFiNGPjX/VyZvwY4NuzTw847Ii
	w66Yt/P6AM61XkdsxFYYfF1m9X8NkSck4ClpDcaMg6UhCvh88jQbJrIcXIs3pbv8qUb+biPDJ+u
	f2N0Jv5BcVNBuEDCYQZ2zPgCfPd27NqagPTo08D7ByoB2Wsuu9uVUtF/c110SPywrbU1T+H3kqB
	Q9t0aqa4s+PQkrREE3c0H1+lOrZr7zOnuNXUFvnjUraix8Umbk5sr6PI1V/YNCBKQV/ptDpzDWx
	EDvaZcNBSfKAcZEO/7DVs6whkDYwPVB8s/L+DbNHhQwAKRBu4q2LORc=
X-Received: by 2002:a05:6402:42c1:b0:664:bc6:69d5 with SMTP id
 4fb4d7f45d1cf-667b272b67dmr5012509a12.13.1773918837212; Thu, 19 Mar 2026
 04:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318075842.3341370-1-gality369@gmail.com> <20260318144509.GA82331@macsyma-wired.lan>
In-Reply-To: <20260318144509.GA82331@macsyma-wired.lan>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Thu, 19 Mar 2026 19:13:45 +0800
X-Gm-Features: AaiRm53XCVRVIob3kXItKft52onwEvV0lmGxp9ZoVPXr1yypSBOl1_l65hWsu1U
Message-ID: <CAOmEq9Uq5xMvhT7cyoY2uhSBhwSEEJ1vYRY36N4sxZSPCO1S8w@mail.gmail.com>
Subject: Re: [PATCH] ext4: xattr: fix out-of-bounds access in ext4_xattr_set_entry
To: Theodore Tso <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, tahsin@google.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227267-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[dilger.ca,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.876];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4142D2CA28F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 10:46=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote=
:
> Can you send us a pointer to the reproducer?  And does the reproducer
> involve actively modifying the mounted file system image, either via
> the block device or the underlying file (if a loop device is being used)?

Thanks for your reply. I'm happy to provide a reproducer. The
following PoC reproduces the bug deterministically.

The PoC is too large to inline in email, so I uploaded it here:
https://drive.google.com/drive/folders/1OzH1XvAOAb9ulpOKfL70U1LvXhhlHAyz

Steps to reproduce:
1. Download the PoC from the provided link and extract it.
2. Build the ublk helper program from the ublk codebase, which is
used to provide the runtime corruption capability:
  g++ -std=3Dc++20 -fcoroutines -O2 -o standalone_replay \
  standalone_replay_ext4.cpp targets/ublksrv_tgt.cpp \
  -I. -Iinclude -Itargets/include \
  -L./lib/.libs -lublksrv -luring -lpthread
3. Attach the image through ublk:
  ./standalone_replay add -t loop -f /path/to/image
4. Run the reproducer:
  ./syz-execprog -executor=3D./syz-executor -repeat=3D0 -procs=3D1 -threade=
d=3D0
  -sandbox=3Dnone -method=3Ddynamic -fstype=3Dext4 ./corpus0
I can reproduce the issue reliably on Ubuntu 24.04.

For completeness: the syz-execprog and syz-executor binaries here are
based on syzkaller, with only small local changes to add the
environment setup required by this reproducer. I can also provide the
modified sources if that would be helpful.

Apologies for the complexity of the reproducer. This issue was found
by our fuzzing tool, and I am still working on minimizing it,
which might take some time. I will send an updated, minimized version
as soon as possible.

And yes, the reproducer does involve actively modifying the mounted
filesystem image. We use ublk to enable this behavior.

thanks,
ZhengYuan Huang


Return-Path: <stable+bounces-241696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IrWLUfV8GkSZQEAu9opvQ
	(envelope-from <stable+bounces-241696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:41:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DC74881A8
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C81B309B1F7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6449D3932D8;
	Tue, 28 Apr 2026 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q16Rg7Ct"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092F8383C8F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390638; cv=pass; b=mk941BNVLAGXR/EXVxbodLekBF75BVQ/BnHiZ3mztcR2gqSp7VTB+Lfw42zBjNy5hCq2E4NjAFlHWvh1hzafkw5BjASLLWeKrUftuiDyxXbKVCH/Caq0NI6Yiq9Ri51nU9wO5wMwZvfwJ77P/BxgUYCWNxGimBH86OhT4J/4DNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390638; c=relaxed/simple;
	bh=V1TtIX/iCckhSPjdszHxO6qFRnUBFAjULVepW2Qu+Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9MVkoPIG09TTR1M6p5hT+VTT/JuMYYiqnp2/md16P73dFXBQ38TizstiAr+hs5RVWcSvTU/iwN0yHdHHOrnrUXj4iN305e27MZPDxgHqY3yxyfrDUW2eLH3T2hpGvQeuTZ3bQWzhxmizNoFtzg5vA30TQKGnC6yRdA3hrZRKxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q16Rg7Ct; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64eb84d1e37so9049345d50.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390636; cv=none;
        d=google.com; s=arc-20240605;
        b=AnBKV3Cr/yEQGr1sApb/e183af18kVl8gppUpA9doD4NZF1l7IKlFLm3F0YJliniXo
         zDKrDhlI3ThV4BM3KF2c2aEXS6BxSONPP5UEsv2+n80f6nIQHxTVN/jiBlfj8EZGbo4i
         NxXJ95mdGdWtP4bp/brFY/aaSrFiTEBpI3idD4738DOR5Jc435qJchEDXPHfomSpD2U+
         Zm0fyvdbPn9XUHLX4Uy5WGjKZ7v10EHkkwY9nEq5XNrRFfZWiRngxgQdRCwn8y3+ZrAW
         MDfBDZsuhrWC7tkgeuMygtfAq5Gjt0m2NwvqVtE8RW6uaawFY/xN1e4utqTPEBsOVRBK
         CE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        fh=f5NcBTvg66CDEGFgAWzU1OZ/74H3ZKsPxb16wuyjX8w=;
        b=TpYvf6E/A7ITQnZk61wfkiX1LYwxFZp/ctmysKNJH+In4qvNrlJnxIdrQKq/OR0V7f
         wwa7ddId46YFqNSYX81aDYNCnnOQAvJQHaJAIj8KrbUfMbjK8lufJ0VSuGVEMTs0M1D9
         iFITa8eFPF/AMTeqXcnj+NKqzpLp2tN/98vC5n7fuplfIx7Iqj88vy45ABq3++0nHqQ+
         qLfqRbiMMEpE0LhnyjL0NRAAEBpuarJsxZYHoeQdsL0MoQpsivObppAEQ2icqWS7VtSP
         N8IUMyN4/YTF+yJFv6DTNIS3stNx5ywWcTIbf/QNGz+cfS5wjNrJvVumM2NWftaTf3Pw
         qkIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777390636; x=1777995436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        b=q16Rg7Ctzl9Mzh5wRI16CTT3hHwB2iqDB46D1rr0VJRFktR3GUPnqHfocL0J6dwp0n
         6M69Bp0WXmjvab+b8YJ88w/7ZzQacn+G4hhFKelT9NKZ0eX82VVHv98d5hH0vr+h7FyT
         ZekAU+2Pp0X2kGWx3KM/M77Z0UZCEuFBs42mPSMoqlPA1RUHuZMVqQN4mkm8XANAUge7
         ZnLecV/lbMF9+GBVaAbrT3kSKNHEqqyT1ZCe6EmM2k6NAxKBXXdmQ9FRcftpyIpt6DSR
         fZpb7ws8hkb6+vvRRPbfgu5+otuQVLgIKFRDcKnHRGBzA25iPWE2Q0UEWxN7jQEEzVJ2
         B/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777390636; x=1777995436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeCSZMQihSoLfCaEjkAJJ1qhiWibtCZTiVn2NWtYWbk=;
        b=Oj3iMPkDCvAqU81F52sn2qIqV/ydADywxvj852OLteCuz294DodD5ovXTwONrCO/xQ
         XRdiEuwc7zjzWEeugZ1YfdNh9CUmh1aLzD6YSmGVD2mMf+XY+5H0uNr2hci8fWaWkGtk
         lqkIdlSjGHD/8M06f9nQbt/PT3HQcnS/R3fFCM0FtWE/G0Ik0LPtKoaOuxcJQR+8v3an
         ix375ZB+nOTOyjTMbY7hU2myf+6WhYQQgyOMprhPKddks7MONoKw5fjQV/mQ6lZ7fCgq
         WJ/XP0gl/35r+E7b2WxX3ErSCbGuqK6RTl19Dvad6duntQnzljwTnnUY7Jqu/WQ2e+IZ
         DJWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hoxagjZfk563uFu2iG8R2stvEo/E8JNlAkA6AYsFl5BDA+NAzBzx77eU85K5XMBk8fLQYg2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZDi6FOC+jYczGEbY062NkogQrgOJUNdo0GgA6Oe5qUYItgeZ
	7FQQ/DAjQvp5geX+CJV9Hs6w4DkDGTNX+u4IdySGcmiLe+XRnLf+LA/MTjnfs+TdHuMXF29f+L7
	nSV2DBKujURUnw6j+IlHqtif64GM6rMk=
X-Gm-Gg: AeBDieu8FU3nJ0QxSf9+/66qg+aHhajy5nldYIpuITnI2gL2glwayzltMEbNmgUeFC4
	KWIvg3Iw5ShGxchy6SNl8ZIz0NSLLs/lslfvlHohecWSxmjc3lfUEyM/9fTDc4AokwbDrr1mv+R
	T9WxSG8dK5KN//BFBlY3mRj2v0NLzstmgpXmZWeltAJuS9twChkJaxChbmhVDrTmAQyAJFKAci7
	wdE55Zr6quzsKFDmPAJGfKP/ongE7lCWIgxRp/LSLBbqG67lECtMgWjMKjEXsZOBVUeR8gclEqG
	EJ6pLvVp9IYDJl88KqfR
X-Received: by 2002:a05:690e:118a:b0:658:fc74:ed79 with SMTP id
 956f58d0204a3-65beed37b17mr3356969d50.11.1777390635964; Tue, 28 Apr 2026
 08:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413115949.2799399-1-lgs201920130244@gmail.com> <20260428143540.GA2647286@nvidia.com>
In-Reply-To: <20260428143540.GA2647286@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 28 Apr 2026 23:37:07 +0800
X-Gm-Features: AVHnY4KkUygxtZiOGzNnWJihtQ4bsHzFnByEuecYa_JlGLi4QJ_LnELCP7CDURk
Message-ID: <CANUHTR_=n8PSha-p5M=rF0pScTDo4GmVh2Ba+h44uL+3XCiq+w@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mlx4: Fix refcount leak in add_port() error path
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Roland Dreier <roland@purestorage.com>, Jack Morgenstein <jackm@dev.mellanox.co.il>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 21DC74881A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Jason,

Thanks for reviewing.

On Tue, 28 Apr 2026 at 22:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>
> Sashiko says this will crash because this was skipped:
>
>         p->pkey_group.attrs =
>                 alloc_group_attrs(show_port_pkey,
>                                   is_eth ? NULL : store_port_pkey,
>                                   dev->dev->caps.pkey_table_len[port_num]);
>
> Along with other problems.
>
> Jason

You are right! I missed that mlx4_port_release()
currently assumes pkey_group.attrs and gid_group.attrs are already
allocated. On the kobject_init_and_add() failure path they are still
NULL, so kobject_put(&p->kobj) can crash in the release callback.

I will respin v3 by making mlx4_port_release() tolerate NULL attribute
arrays and by dropping the parent reference taken before
kobject_init_and_add() before putting the embedded kobject.


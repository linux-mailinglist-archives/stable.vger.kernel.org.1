Return-Path: <stable+bounces-59367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A87931A42
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 20:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3074EB228A9
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 18:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BEE18B1A;
	Mon, 15 Jul 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF+2UIL2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7961FF0
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067963; cv=none; b=InKEk07Jx3SmPhcKRapE6vA9YkWhAVBkChkBEcmwEWRkpSfPSSRJ0Xbq80xMOD5EkDNIge+//CJLm9arwv6etuK0KADRZDLfFZl6RtVwfvzi5tjgmGNIbt9OGvL6gZ75woyUJC79Nh7wqUKGNWteOFwCDcPsO+pGK7QsmETJNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067963; c=relaxed/simple;
	bh=SNgfukte9/uRetp/NJ+Lof07eu2F4LkCEzuufrYExIA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kEHSs91IrjMqrjTtqMHtFh5CWjbl9pLEeiFM1toMoP2UPrqzSiziUMmSj9oNeBXi7nf14EKe1xdxG12wZMa4QXh1EDnwtMwTB7LY9kUmfFwcspTeUqfhmk+09j+5rWMTmXYXrxLXi5C9sXhZm1Uqzfvm6+3zLRWExy4XgXJ5m2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF+2UIL2; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-78964fd9f2dso2858728a12.3
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721067961; x=1721672761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SNgfukte9/uRetp/NJ+Lof07eu2F4LkCEzuufrYExIA=;
        b=KF+2UIL2KkUqLvBZfwAK4GF/QcWsuusfTOZeGqwLv9PoMXjg1t+M/tMsaayhamr6RH
         4KGXYfKWB0svcQlod44Xs5MLV7m6t0noNbHz0cP6zOCM8oUbS25JFKqb604L5JlsOtCl
         2bm+1bUQB546RoCmGza3B01KVknpJS1WHLbMgKfzxQWtG771eHlQxzsdGQJG0OkB0hpr
         pFK9X2SLVMw4gqe+0A/OVvcA/y79A/0iiHa/MB0hV2PEJ5XrpXuwqLVaHd3UHyGrXk8e
         HIGvSuchQY5H85iM8wRdqmZDWpZfuRUKrG9rwnyhNeG0fE0jdDN4l9pYNKMVKBsKCv7D
         1vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721067961; x=1721672761;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNgfukte9/uRetp/NJ+Lof07eu2F4LkCEzuufrYExIA=;
        b=QkGmIApOfNGuswYel5xvJrsjoDJWxL8mY2WlPLNvkyyunZuL7adRPRoGoVgPH7R51r
         P38Rby1BhrSWs7TGVqdQPe4bQZ7gp2uGNpH+z3RP/bnDY4dfg3hTiTrDGa9WU5/WL3Lf
         saaX+oyeL2jmz74otbVSYqmMeUcB4rOqjBXFxhTqiS5e1UP1K1AVJykikucdBK5EMaxk
         nnUB+nd23VH0UmZqqrIlATcVubLhqwM1pVa+lWmfL5ytWyR+S4bIvMWEnlQ2dDlSBTGa
         AILy2jnthG+r0Kgq0V4LbHkioqZTg9OQJbDOvLqK37Z/jl9XOzeGbUMk8mUnXpH32/bQ
         tMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1+xjgyYE0yDZBmi65ChNGjBvAQj21+t2oecX84Dxx+jfupGS3Ju4E1L7Cd5qfo/No5Y88yuqIikhQIY/WpdlSOxxegEnm
X-Gm-Message-State: AOJu0YzKqkg4AI/QPzB4Moea+pAXsJEW/81ac3GYMVojT3YeocoocW/J
	w6aTyctboINTZPUzKiftgTjNz5qzYudmXe2cW+/7s4IBpoTNnD3E98gIwg0TEvFyWoZALsb223d
	4oBfHPOieis9l5Z51uNo3PbyG1Ao=
X-Google-Smtp-Source: AGHT+IFdCM5h2xkxqxaJHmr1rY95kUahL0tlirCSlgR3AU4Kn/sv936BtoUbAHh+Maq5D13B2VG/1wjmR2TB/OGvpSc=
X-Received: by 2002:a05:6a20:1594:b0:1c2:8b78:880 with SMTP id
 adf61e73a8af0-1c3ee59f9b5mr816300637.41.1721067961251; Mon, 15 Jul 2024
 11:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robby Knipp <knipp30@gmail.com>
Date: Mon, 15 Jul 2024 14:25:50 -0400
Message-ID: <CABSVwikkDqE=XSXfiv=F6N4tE+kpNENxhPsP4gqvm1jg6D6cAw@mail.gmail.com>
Subject: Re: Xinput Controllers No Longer Working
To: Edward Wawrzynski <ewawrzynski16@gmail.com>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have created a bz for this issue as well -
https://bugzilla.redhat.com/show_bug.cgi?id=2293600

In my digging, it seems that the 6.9+ kernels do not have the xpad
kernel module (running # sudo modprobe xpad returns no value)

A workaround was to manually install xone or xpad kernel module and
self sign the key (keeping secure boot intact) however, this is
somewhat tedious since it did work before.


Return-Path: <stable+bounces-40366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D848AC7C3
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 10:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93F9280D3E
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586654913;
	Mon, 22 Apr 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkUFJEK3"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6845490A
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775746; cv=none; b=bdx8Mt1qJdWkj6SNaVqG50gFdXFxru6/VUZ9dv7+28o11oCbG9cksyRn8S1lx0jboaMwDqS9WMPnjovJjfQlN4/hzMACJzrSeVaHBIiDIGPEWbplJGKX/jGgXsacEFtjDRw1IXqP9i118DVvd0svzmcD6uM7aXxuT9n2giIvu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775746; c=relaxed/simple;
	bh=CT2XS1e89+VXbYTqzvXH0Y15mp2pRI9oxR2LT3rbeeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipxSxHRJyEard+McxCvAMyNdvEqsPIRxCbmpdJM2/mP3g04pA+uOZt3F6JQY85D3EpUaxoaAeopPlcWg/W/3/uyFC4MiN01pUkvBrGdZX2yw4KFke/8UmVsMAqqiFJ2ssUlXZmOTeFO4xunjYk8aNnO2D+Zw3t27H1s4k2ShymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkUFJEK3; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4dac92abe71so1025246e0c.2
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713775744; x=1714380544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81H2tvp2dnEImlGObJk9X2NDKqHXpLpFCie3SlEmMD0=;
        b=NkUFJEK3/S7dlNMbfaKMakzM77EmAHPN1I9IoZbq/fWLW5H4A2wmJ2NnFWcsaWfdD5
         aFiPAHSY0Y9pR3n9IpqHA7fjAzc1hUTfHLpfuuOKVqCFzAE+nAOTOwwrnyWuhxBV4+zm
         y+QJYLGevdhIPXXHGeQOUyMMWDkwlPnY7S0OKIsZc+EDu3DFa201Ad9C2foSq4xyLtvF
         lP6/vxltUGlFV3TUz37GFkKBDJtzfcLjp3sFCawryy6tZVdTIDqrGw744s8/6JRmhLOj
         d4Z1nSldogqYxnVyTA6VywdVbNAM0PEcXMLuixN8xbnFQl33lsBHoHgadN3za/HpABMH
         OGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775744; x=1714380544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81H2tvp2dnEImlGObJk9X2NDKqHXpLpFCie3SlEmMD0=;
        b=MZ+fI18OUebSrCtw7ava39Oxe4AJAVV/gqlBtmZ2ZCwM2tyNl/5GsqX8TOneVwvn/2
         0eCLP3ck22gi6CHG+8wW5YYiXP7IBjqoeLuoDYp3XNgqrogqUKrNroJaXLsjiV/f2vAO
         hyrAm+nuOt3mxzIp1QM8e9tX62pKvggQqdzBcQqQsAyjIdmiYazq4u4ZQ/BBvpXeK21E
         G+iBpNeS4No7NoswdWWvUjnUuzHYehNnRc4Zf5RqGegURnYhGKqeRfOFZmLWVSXqmUT5
         aboCnPSyAttXFJSx2CkNgoj+Z2YlRoxUPA4ywsp5cHV/8RnRhA0lRqCBMlOEPy90IC1o
         TNpA==
X-Forwarded-Encrypted: i=1; AJvYcCV4EQdU/iHG1g/mHh1vv46XZ1PsdK9H19njA8Uxz5koP1DfZ4i8y9M7/QojUqt0UJLXibiBxeCUroKgmIaZKxgDghoJ/eBL
X-Gm-Message-State: AOJu0YzvN0ALYqxpsvr5OfW6VO6HpIK+wbCaZ08ELAgwCJFLJA2sBbLV
	49VqN3IrWib+FlnKDmdGr2lh5cc4kdDvrs+Mw2S/6wleqi6QruUH0zAOyRUGYi8Ny5k1yOfOeEs
	XFgiD9vWxGvhghdwdNidxw1pHTriF2n/20aOl
X-Google-Smtp-Source: AGHT+IEQSgdlHXUsgOeV6YmT9G8tiLYTZX/LCUwTiWsJcbPy91Vh0VZt3NNcie66mXn1DRWyl2UOedjfFoim2Vi3Ou4=
X-Received: by 2002:a05:6122:916:b0:4da:a9d8:f719 with SMTP id
 j22-20020a056122091600b004daa9d8f719mr9487633vka.4.1713775742422; Mon, 22 Apr
 2024 01:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421173750.3117808-1-cmllamas@google.com>
In-Reply-To: <20240421173750.3117808-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 10:48:50 +0200
Message-ID: <CAH5fLggC597GVm3QQGi+VeqUNBJk6vfq2eQSKgGyUZfS6dHVqg@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix max_thread type inconsistency
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Serban Constantinescu <serban.constantinescu@arm.com>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 7:44=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> size_t to __u32 in order to avoid incompatibility issues between 32 and
> 64-bit kernels. However, the internal types used to copy from user and
> store the value were never updated. Use u32 to fix the inconsistency.
>
> Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREAD=
S declaration")
> Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


Return-Path: <stable+bounces-73102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048BD96C912
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 23:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B658B288021
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7A146D6F;
	Wed,  4 Sep 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ss3UlhVo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5F84A35
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483662; cv=none; b=asaIGZ/zv/SjGZdVWUbh2e6NURW8M6zqg6di5b0LQelTMviAe/OnzcgqvWKeEP/5KbjJv8JHPpOi8QuByBAkNUs7s5m5ByLH5ikooLeni3XmBmHd9UOUZWGUe34mSUCi+S3TSb63wnSGl7X05dpyE9hZ6jOOapKU8AvdSe7XvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483662; c=relaxed/simple;
	bh=6mZvpPxkfVOu0ZFd35R5wFQD7fx2RncTBsy2EMfZ9ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfDoPhuu0YS66SW1wQi/kGLdKem6CacH83V/cODAuQ+mOTCzGuoEg5k49KhhYVGt9Xlesg/7MFvKHUL1Vp9vUa1G8/B5zBk8lqoYvhxq4Fr6vM0Klc3FavE1cXU0osjr9Roh3k3S/xRcQ0dATzzTxqreQZo0pEpGuxAVfspQRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ss3UlhVo; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d50532d335so49664a12.1
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725483661; x=1726088461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiZuWXK4qxLeWtHyVXFrt7yE4yvp/8ojzfSZV0gOdEQ=;
        b=Ss3UlhVoEogZxoSjDxVHLc04yOp9ll+h7N3s4NOLWVVOA5aYn7MbWph9+I/NmS+9m/
         dGgaCpqe24KBDvu7ef3AafJZDJPJp7oq5LrlcomlG9fb++sY5iHwC6dW+5fs0KZigi03
         r8rijK9Q5jbtIhcDXd7xEC+AF2H3qe/iF2SbuGhestKN4hoKBmn5WHcx+m75pKl93Ani
         6a1LzYYnFreRZhd6nMRizxU5jp2QD2ry6mM17C4J/VxdndQqQfc2xNnm29l9ZPjzMwNf
         F5t2ZehA/69zk+2qCerwRNzItzDfIK+nehBdFg7cR/mJpk57KzEQyGhb30WgxX0NFptw
         yhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483661; x=1726088461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiZuWXK4qxLeWtHyVXFrt7yE4yvp/8ojzfSZV0gOdEQ=;
        b=EeiPEY1tbeTjoduHbN+4mUAqrK7asquoc9j39nc0ikHGLOS4KbDihYThXnyHxko/pu
         9vTcwyst8t72ojM0dRfuX8nW6gzI7m14qQootqJi2DoF2QvAA9cpYmWLmIBei3SGZKGo
         sQODAiPEHXB/KBFnV5sDrXa064hsH6+vssKPUch6ECFHLc8+SxqD6LAb7fV7hU9SgJCp
         9D/BwxDVPGCvYrmfk+qiEv6Aj8j6MffK5MmRNzGe2nezN4iytgWeuCC1LvyvlZTkorbQ
         gS7aYjksRsj9IVEfI+vRPKwwyPGjpQ4WPEhkl+e71mk2U+puhfaizHug+yVCr6rphttS
         MCzw==
X-Forwarded-Encrypted: i=1; AJvYcCVfJdqA3sXyf/q9wk+CjfyrzaUtH6YuA30nCBXaelOSVJxkBDNnfGnXCM4LAXLlBUp52t7mcPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWZrv7ZI0dGWxLXeBGcTTuA4jiayABdzP2UdHDnUOMHQltV1K
	zi6oVz4UZgxSSGo+6T+T65lstyTchLILJwCBpDoG3xwjRpDc3IiMmJpjOCBHcta/q/RwQZFRtXk
	VgbQ2KXt7DWhKVwbXNWgvlZJweyxJFKGhxGf8
X-Google-Smtp-Source: AGHT+IFrr+tEd7lLFICJECDLyNrj9D0lbcJ0b3ddg4esEHOXw6fT4dEDg1J1j1nIG+HttAkMlSfY3NTCzwx5YfOJNoQ=
X-Received: by 2002:a17:90b:4b0b:b0:2d8:e19d:f8d1 with SMTP id
 98e67ed59e1d1-2d8e19dfcf3mr11538514a91.30.1725483658866; Wed, 04 Sep 2024
 14:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904201839.2901330-1-bvanassche@acm.org>
In-Reply-To: <20240904201839.2901330-1-bvanassche@acm.org>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 4 Sep 2024 14:00:21 -0700
Message-ID: <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking complaint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org, 
	Amit Sunil Dhamne <amitsd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Bart,

On Wed, Sep 4, 2024 at 1:19=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> Suppress the following lockdep complaint:
>
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Fixes: fde0aa6c175a ("usb: common: Small class for USB role switches")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/usb/roles/class.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index d7aa913ceb8a..f648ce3dd9b5 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -21,6 +21,7 @@ static const struct class role_class =3D {
>
>  struct usb_role_switch {
>         struct device dev;
> +       struct lock_class_key key;
>         struct mutex lock; /* device lock*/
>         struct module *module; /* the module this device depends on */
>         enum usb_role role;
> @@ -326,6 +327,8 @@ static void usb_role_switch_release(struct device *de=
v)
>  {
>         struct usb_role_switch *sw =3D to_role_switch(dev);
>
> +       mutex_destroy(&sw->lock);
> +       lockdep_unregister_key(&sw->key);
>         kfree(sw);
>  }
>
> @@ -364,7 +367,8 @@ usb_role_switch_register(struct device *parent,
>         if (!sw)
>                 return ERR_PTR(-ENOMEM);
>
> -       mutex_init(&sw->lock);
> +       lockdep_register_key(&sw->key);
> +       __mutex_init(&sw->lock, "usb_role_switch_desc::lock", &sw->key);

https://lore.kernel.org/all/ZsiYRAJST%2F2hAju1@kuha.fi.intel.com/ was
already accepted and is perhaps better than what you are suggesting as
it does not use the internal methods of mutex_init(). CCing Amit as
well so that his patch can be submitted to stable trees as well.

>
>         sw->allow_userspace_control =3D desc->allow_userspace_control;
>         sw->usb2_port =3D desc->usb2_port;
>

Thanks,
Badhri


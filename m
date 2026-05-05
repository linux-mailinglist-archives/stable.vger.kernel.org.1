Return-Path: <stable+bounces-244233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO3iGZwr+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:40:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 469714D233D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39F7330314D6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6624A3402;
	Tue,  5 May 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wxbazo8G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECCE4A33EE
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002784; cv=pass; b=oKC/jv0gx+3GeFSXku019MP+5s6emf3Q7VjEzmNtgQLWHKt3haumai9KxpTCDdHf1MYpB61YIYqoVT26Rq2pwcKny9RVmGjD6UWIHFUGOK9bp8LGrAwXdKbZsgPs4+L5EhBSiKGS4mJ54J3nC4S7Ll01CrSiE5Fe6s9AKGN/7ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002784; c=relaxed/simple;
	bh=ndjRAJm3WzNlqQxhRRMI7QmuE7dHkDlI2JoUdx6DXIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izZ4hpJHQtdQNhIs1ieU3QKBNRizA59XesScB+1QS+QEqfvcB2X5EPUl9MK+Dh1yfMtYKUOgZvS1kEKbllp9D8IURjOEQCc4yQ29nuIrzhK0UeNiJQArCldKPa6T/r7t0bI03a4JTrgXt/WIY/ZTu0NqRc0uR3DN+exHpfOQ+TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wxbazo8G; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36535998b71so89258a91.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778002782; cv=none;
        d=google.com; s=arc-20240605;
        b=MVeZ7UJlqkIEN+C5N99XesERar/3bMzYWUBerxwJdGZ8OX1p9MLfEVtOcQ+fH7pP6z
         izcM4tYhwxwIew2G2YsNV/gULBXeOjAba2OctlPMjukUXO+5DYWQheZaT4Afn94ONSCN
         zfiAcoxJcEV2wz7nHTvSrbOy6I5JvbSQIJkjQt+YMM10nuY6gqGpIBprMQnfr+UQAHMQ
         VsvaqWGKtl2RhV+0RqJFZJ4tUfA1EsunmP9HETxmx50XtyOTe/ZnBLLEGLHygzDmrkLw
         OjPnbOkgcw848YwRqjHHaTbHwADwIAONwFozdsgWDG1O/eVnLSrNd5G9il6poucVnhpf
         E9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AIMU3lf9kc8EsYHBmuDo0jAnXxQba7uzrH34U2ph1no=;
        fh=VT2kRd5NrPQo8kkq6GcrLNTKatXQBcx62fe2ot8J+3M=;
        b=OH6Tyhc6k4BYsB4flF4OYXlsBzblF9i20Yvg+XS8+7eNy/muJDhqbuGDLb9KGzql7P
         y8hDxY0Wh6Y81QaPN5+73adwiiNUA2EjSYbAgulG99MRzwnvvUuVfx24q9yjdyU3ZSY+
         S4zwCnhk4YIBljemGx+7VwVLLLAXRO9WBtXYAzBiO/1+E/F9nOd+2U20wxG2xLx5GGn0
         6CZLpli4F95e7UE7+N/1wLtS8weHTcMi3hWJ/GwfDtsnN0h+zGHa8iz1Ens+VPd+LFDR
         WmOs1kTJSU2moNE6/1ggstU/l4xGD2hzVPq4IVAkWaLntzuqFALBR0nF/uWjA5GHGd0R
         NKbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778002782; x=1778607582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIMU3lf9kc8EsYHBmuDo0jAnXxQba7uzrH34U2ph1no=;
        b=Wxbazo8GIWv0qn/K+6yAh97qO4Bh1ts47Gu9nNx8raMw35tsLzNzh8dJS2oDH6DjSH
         Pv1FNNZSWyxWhN1f6VyAC2dj7jvrMXo5WFTGDsWt0ZYoO9j3rx6KS+xhq0b7b2BfHuxI
         Hiey3xDi00Ooe1FiG5EwHGNBvFlWz5TzAaURw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002782; x=1778607582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIMU3lf9kc8EsYHBmuDo0jAnXxQba7uzrH34U2ph1no=;
        b=s6mn/wIPQIxCwk2sDzraGFDQ1oY/f7fIVyHWFty11VfO5wiJBWCE/ZqpdKg4VVH0V7
         oAH3YNeWqqtc2rTH4O+CJWr8e9swOnXquLCLCOGUBNvlDAKjLRQ5baPGWhrINJz5wAvr
         OyUPt9CSrJW7J5+FEkpg7YKNKR1olG6n2M/T+QLq89Zr0mVrkrjTJaa6fuwmNdOFLpbX
         d32e2w15x05vCVj4X+vzKOrBPg+hIGWd6/0iamUPD8KJLmhaWTyOTvyNqvTBXN71Hp7t
         kzqNE+vsQenrQDACSIcgEEBTNkyXwkZVht9cFhUe5Fu2QIXZOTQzGkorVkGNp+ZkDzYu
         Ut7g==
X-Forwarded-Encrypted: i=1; AFNElJ8IX5cxJpEOG3W0GFhtFsSHgNRyCvPEUI99RfvyrbmvKCk8l6UPAS+Qp5LvmwWCnuoAddxS28Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVfECuKf9Y6Js8mfWEfavkkCREDzJUFwIlII/1CjJTiTUtwOo
	c340BxW0VhRsBH3jGG30wTl3477C3dQj6sD4gxotIBRu/hbaslD7430EvDjf2N5wxRD6VZJnaIS
	bRC904ZiQpGGQ3+aI3eJRKmLMatU9CljdBqE23156
X-Gm-Gg: AeBDiev9+ru0dzuvgspFSH+VaBnYkXQMcYAOwpSqtFASKSQSVUx0licOvHngIZdC7J4
	Fn6LCJIrIIgdfy0MkNnjkCoY7Wjp7B3+1vtghKd/D3SdDDIHujQcUUg2sf1c2R8p61qGGmdKgNQ
	6l0LsCrDxXjCjmKD0u0rznNPF2PZYCHCOJbAiFj6sWXcW8gAlxOYO1sjR8zJ4OQC0kQC1NTRxIy
	+TfEUe/ASwHrYDH2oPI5t7Fc4QmqCsbMIHsn9IND+aX8sr0zPN7f6ChuP3O5RkKhzywnQc54lqV
	Bq0niTw7DRNgKl9419Sm4daX+2JqX8sQ9j/lxPff0yVCcBWnFBeKfZVxaT0=
X-Received: by 2002:a17:90b:3e89:b0:35a:10b6:1208 with SMTP id
 98e67ed59e1d1-365728811fcmr3768761a91.14.1778002782151; Tue, 05 May 2026
 10:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505053403.3335740-1-tzungbi@kernel.org>
In-Reply-To: <20260505053403.3335740-1-tzungbi@kernel.org>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Tue, 5 May 2026 10:39:30 -0700
X-Gm-Features: AVHnY4L5fAq0tv1FZEX3wyukvmRw8Qh8kutB15RbJtcaQeRmgpHJfLeGTjyl_8A
Message-ID: <CANFp7mX51VHCvcEhKnydWOTpa2havzCwVAvAESo2L2k8EP+7oQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Init mutex in Thunderbolt registration
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 469714D233D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244233-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhishekpandit@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, May 4, 2026 at 10:34=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> cros_typec_register_thunderbolt() missed initializing the `adata->lock`
> mutex.  This leads to a NULL dereference when the mutex is later
> acquired (e.g. in cros_typec_altmode_work()).
>
> Initialize the mutex in cros_typec_register_thunderbolt() to fix the
> issue.
>
> Cc: stable@vger.kernel.org
> Fixes: 3b00be26b16a ("platform/chrome: cros_ec_typec: Thunderbolt support=
")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_typec_altmode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platf=
orm/chrome/cros_typec_altmode.c
> index 557340b53af0..66c546bf89b5 100644
> --- a/drivers/platform/chrome/cros_typec_altmode.c
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -359,6 +359,7 @@ cros_typec_register_thunderbolt(struct cros_typec_por=
t *port,
>         }
>
>         INIT_WORK(&adata->work, cros_typec_altmode_work);
> +       mutex_init(&adata->lock);
>         adata->alt =3D alt;
>         adata->port =3D port;
>         adata->ap_mode_entry =3D true;
> --
> 2.54.0.545.g6539524ca2-goog
>

Thanks for the fix.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>


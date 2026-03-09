Return-Path: <stable+bounces-223472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3QzpFSgmrmkdAAIAu9opvQ
	(envelope-from <stable+bounces-223472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:45:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5234233134
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 02:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3612300FEFA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 01:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39E31AE877;
	Mon,  9 Mar 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnX4rINo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7BD175A96
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773020707; cv=pass; b=ABgLe7idcHa5d55U3dttM1sitkjLrUPsqEFoSVSkh5vy5sAEmu+lwFoUPdpwxReIUTakvjS2Ky+wLSkCGTWeRq5+MVFeJ74BeMrLCXcc9y7JdctE/hrmafnuOhZCaK12v7Ktu25h2ejbipgfPnnOqFx7S1bNvhk6Z5zaCecNVXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773020707; c=relaxed/simple;
	bh=sl3u0WnxvGqOARG71GfXOFLB8Rpy4hpnABiC/wokmLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2jZMBoQtxawFQlglyVT6IvUc5MPxqEy2rvnT5dbZ3trm/dOuYcaG/ft/+7cynWPyPSrSgLPDLal0Tb+v2DB/03m46+B9Sd7CYQd28SjBLbifXEZofJZq5rdScK2d0PNGwq84hw7kKEhI5DVZ8bi1su++9raxV7WqYhlgN+WOoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnX4rINo; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d55b97f358so8229662a34.3
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 18:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773020705; cv=none;
        d=google.com; s=arc-20240605;
        b=VmXd4jJGW67NixeTMe4/uYztFK2Lb9hCP0Orr6crbN8Hf/sCbf8A/tMbVInd+Bz6C6
         lcMVho3lMMFw3HeRGanlAkPnTaqW82C8PXR7ZJl55l4vEifGkNCA3MCkOcpzaAQgAKLk
         AsjtXItrsXBaOWnu3j1y/jI/01gI4sN396WPS6yaIq9huAzPsWDNJVKUm49bhdwMyVp1
         PWKIALhHfhGG7sbOj76y4sLxI9Ucd0Yt2k5ByfsqXmXUXixp10llWBQZg7TqAkGnScjY
         5/fYWpXfC3WNIYKpoUkDDdKDoXzmHY/2RMk6uZHBye+fOSsYbudonAtJrgoraXH7gFUn
         oScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGGArcSJs1rDQltm8BaCdzDrm6Gq6DCk9mYsAsHFFXE=;
        fh=mAXfcDAohEPkqKhkU77S39hnEB5yGv4zKJ0YlxYNvXM=;
        b=lRVryqjirxjdsfNYev4ANNNESaW/wF8DbiFdYGC35CaTpdkcCgcPrYtMbwSUUcavXu
         PLwBt/Tc6nIwY8KLkulnwvs1TMWmUIitYQ3KfCC3QGKWrfHapRWCkKUzdZvF4r77O3PB
         rULh+MKodqQVsPd1nvSmZ09Q44bQCa2rpljXkyG1o2whyUMUTgugJGJm5JqwQZtPT2AK
         GwHCHgtmLAma7BMQVIGeqyR8l6bTHNNOplBfhRAfR21zE0Z0zP7dLuPkb/eN1OohHTiR
         2wxDMTYoHNRbJJ0Nlz/KXmX4uoK8n/ZI3cpnHdBoLwoa4v35+0A+4kGNpy83KHwntOzF
         WIWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773020705; x=1773625505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGGArcSJs1rDQltm8BaCdzDrm6Gq6DCk9mYsAsHFFXE=;
        b=ZnX4rINojEzJ6cJINZcFWofINwuC2T6I4HL7YuRq83T8zY3mQQQqyx8dYy4/cPILqK
         P/xRCXz+kVOyUS8VaRmuQZ0k7iSbRm+nbcecp/aFREOoCJTrIvfFXPBrSAHM2rDsShl+
         kLm42qAMeZ0O1nASAPoO6Yk8MH076mJgtrPiRT2lMYl3lj9M60buolzeP7wXWsz6VUSp
         5kJii0kmhQJzENzrGgWHJw2ISI+RcszHB1sfXbyexdvOqUlyNprxd78Oo9TIIzI6lDDD
         RJx9mSyh6AU5qmvLdUD+y+fmDbf0Jv1UwKXh80Oq3CzA5UtAEQZ0nomUGveNWKgn+0cX
         kdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773020705; x=1773625505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tGGArcSJs1rDQltm8BaCdzDrm6Gq6DCk9mYsAsHFFXE=;
        b=nTrDkKaq+2uEh9MndyTLv79QMEwWxipbmRlvdSdvtqK4KFyco4OvDHF1GavxTcsusi
         Yd35ggNZfQEY+LwHg2VroYHOw8w91KU9nnH2qUTWeVA0dGWg+5oeQQUUle3Ty2cifmk2
         1U6vbE2SQJveuMpkjoAjMRcP8JySJ9t9LnbuYhriNfPVb9yWX6QJo0ynBO+uaB4rx81F
         7hyOJbIOWv7bQclb1eIh3k3nVG0woqZ3klC1rpB6Xx1HtMp1Q5j4Y/kladW1ZMJh9kY6
         yaJ45EZBdllZ9A9MDPIMtaCYMq2GkeBcPyUwtYyKOel8CTv01F3DRcftbLDN73LAbOVT
         pDmw==
X-Gm-Message-State: AOJu0YxO9TmL7IeyHpE9c8YZPbKxjGPBGqrfEujA2VtaPnSTaE/GoVi8
	Wupl+75vNWvESbc2IH566Vna7axONvvsJVWYhE9wkxRRR0diYdPW4hO6+Zg+GIfTnwmdJh7IVzG
	gDEvaYFwcdixSnzqG+M9v4Hu9+D9GuODwkQuQ
X-Gm-Gg: ATEYQzw6aAuKz/XehdPqvYt5a5hDUlrSXjsgsU+gVYReWo3OIsCRaN1bmU7YDVeHX/g
	5KLPKbDIoKKFBWCQDXAUrJdFpfYefFhNcv0FH+rkP5FvsjUphIKpTfVfsNO+ebzbD1FPsHOxzIc
	cgjjpzDwo5ON10gVVqXt3bgpS//8IVcM84Ka/7kq4omHHOW+uqNNodbGcBxSJXnJl8vK7YWnw+h
	le2ewO6gB39mWHHhIypg6TzPPJI3+TXCygkCApXZb0LhvRoo31o/xEZ1rXasl0pRNlVZ6ulo6Vx
	64RhfzjvFeK7XiDqGLfTcuC+WByNiPJn9j0Cc2dNIhCWcF9BbBm5WS5kln1Djf15g/QuZO4dog=
	=
X-Received: by 2002:a05:6830:6b05:b0:7cf:cb0b:dd10 with SMTP id
 46e09a7af769-7d7270711c3mr5647275a34.33.1773020705036; Sun, 08 Mar 2026
 18:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308164617.27847-1-sashal@kernel.org>
In-Reply-To: <20260308164617.27847-1-sashal@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Mon, 9 Mar 2026 09:44:54 +0800
X-Gm-Features: AaiRm50zejcmzwFQYKq_l5AbMqet5Zv9Dp9lA6BFUOeWAsJIMXi8o4N6diT3LEM
Message-ID: <CALbr=LYLwyqdkOY08f1VGZbW-Zrfns1kprUjvCUNcqYrMVoCZQ@mail.gmail.com>
Subject: Re: Patch "driver core: enforce device_lock for driver_match_device()"
 has been added to the 6.1-stable tree
To: stable@vger.kernel.org, sashal@kernel.org
Cc: stable-commits@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5234233134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223472-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.897];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 12:46=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     driver core: enforce device_lock for driver_match_device()
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      driver-core-enforce-device_lock-for-driver_match_dev.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha,

Please drop this patch from 6.1 and all other stable queues.

This commit was reverted upstream. Enforcing the device_lock here
introduced side effects [1]. We are currently developing a new
approach to fix the original issue [2].

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D9de68394a615
[2] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.=
org/

>
>
>
> commit 43fcab97a217ccdc2da2d8644f88398dc061e1e9
> Author: Gui-Dong Han <hanguidong02@gmail.com>
> Date:   Wed Jan 14 00:28:43 2026 +0800
>
>     driver core: enforce device_lock for driver_match_device()
>
>     [ Upstream commit dc23806a7c47ec5f1293aba407fb69519f976ee0 ]
>
>     Currently, driver_match_device() is called from three sites. One site
>     (__device_attach_driver) holds device_lock(dev), but the other two
>     (bind_store and __driver_attach) do not. This inconsistency means tha=
t
>     bus match() callbacks are not guaranteed to be called with the lock
>     held.
>
>     Fix this by introducing driver_match_device_locked(), which guarantee=
s
>     holding the device lock using a scoped guard. Replace the unlocked ca=
lls
>     in bind_store() and __driver_attach() with this new helper. Also add =
a
>     lock assertion to driver_match_device() to enforce this guarantee.
>
>     This consistency also fixes a known race condition. The driver_overri=
de
>     implementation relies on the device_lock, so the missing lock led to =
the
>     use-after-free (UAF) reported in Bugzilla for buses using this field.
>
>     Stress testing the two newly locked paths for 24 hours with
>     CONFIG_PROVE_LOCKING and CONFIG_LOCKDEP enabled showed no UAF recurre=
nce
>     and no lockdep warnings.
>
>     Cc: stable@vger.kernel.org
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
>     Suggested-by: Qiu-ji Chen <chenqiuji666@gmail.com>
>     Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
>     Fixes: 49b420a13ff9 ("driver core: check bus->match without holding d=
evice lock")
>     Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>     Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>     Link: https://patch.msgid.link/20260113162843.12712-1-hanguidong02@gm=
ail.com
>     Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 2a6cf004dedc3..4e06810efe3e0 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -144,10 +144,19 @@ extern void device_set_deferred_probe_reason(const =
struct device *dev,
>  static inline int driver_match_device(struct device_driver *drv,
>                                       struct device *dev)
>  {
> +       device_lock_assert(dev);
> +
>         return drv->bus->match ? drv->bus->match(dev, drv) : 1;
>  }
>  extern bool driver_allows_async_probing(struct device_driver *drv);
>
> +static inline int driver_match_device_locked(const struct device_driver =
*drv,
> +                                            struct device *dev)
> +{
> +       guard(device)(dev);
> +       return driver_match_device(drv, dev);
> +}
> +
>  static inline void dev_sync_state(struct device *dev)
>  {
>         if (dev->bus->sync_state)
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 941532ddfdc68..78a64f2784d05 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -212,7 +212,7 @@ static ssize_t bind_store(struct device_driver *drv, =
const char *buf,
>         int err =3D -ENODEV;
>
>         dev =3D bus_find_device_by_name(bus, NULL, buf);
> -       if (dev && driver_match_device(drv, dev)) {
> +       if (dev && driver_match_device_locked(drv, dev)) {
>                 err =3D device_driver_attach(drv, dev);
>                 if (!err) {
>                         /* success */
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 6ad1b6eae65d6..02c846be7b174 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1175,7 +1175,7 @@ static int __driver_attach(struct device *dev, void=
 *data)
>          * is an error.
>          */
>
> -       ret =3D driver_match_device(drv, dev);
> +       ret =3D driver_match_device_locked(drv, dev);
>         if (ret =3D=3D 0) {
>                 /* no match */
>                 return 0;


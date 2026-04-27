Return-Path: <stable+bounces-241324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILmLE75h72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:16:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B89473403
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E871304D24F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E03C198D;
	Mon, 27 Apr 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjU22mZF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE33C3420
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295624; cv=pass; b=QX1yi5yewZkMWesykPTNdyocEsMh1MTNf9RMm/3I6c0QJDGHyHcPfX9u/g38m497rztc1mHSorB2Vc714M7QCP4g49j6pP9mMD/ixYTRC4JoLbgr+EfCsV/f2o2qSXZj9q6ax3TiTLie3zQYWzUeX9QQxWi3pxLC51gk1KGu18A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295624; c=relaxed/simple;
	bh=Zb8vYbMD9IRjw8Jcfa3NNa6YpDZ3/otQveWTR1RGHIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qshGG0dBMratnCG3h/O2qjgJeo/cD3Uf6KvUxjRRLp1/dlsH64SdRLsB9Nt+Asu6qQvJ4/hNye9S8Br0fBABqOd6X3YrZDfIlv6T3gtEo+D79H5dlMiz7LQY9OPjf+6uFrH4cJHPq4HhRQY2XJ1PROLi9uGJWxi7lTcpgJi2+hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fjU22mZF; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a402b2d102so10806836e87.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777295621; cv=none;
        d=google.com; s=arc-20240605;
        b=LyXFM7o6Uj5ynuPnsWszt5MX93U2JQ1xKTtY3RiD8CKt/6+Uxe20PPFiWuPYJ4tC9A
         GLo84KCxxIRDzbeHlLiSztalLYOXQcIUoYo+rHdjF2/wdjZBNFgxZ87dSs0PAqSuO1at
         uwfW8KK0b+T56Xf/UlWm1/wIKMGI+lmj0l0vafSMWcv4WxcBbBzQQpolb2cezM9j/V4R
         O9ue/U/PY5m47GjvPw4w+41oyOGpa5ggeHJfJ5FFELjIscjTHJ5Eu6rjfs0ars8nJYeV
         zvTe8KW5ynCjGDFFlcMInDZNr4k66YYeAzfiO9jZrRuC8pD9a/sfsYg54J3kvoWmjMc8
         Gjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        fh=wUAgXDrSfohIw0n5RavwagZIfYvaHCPk39N6VzPywa4=;
        b=IIL2sh5ebjru+8rc2Pu5K3FYD/XCPMreg6lSM7kSiijTdJDeqVuc3LYdGq2/dOcw1l
         1fZlauEm0nyalLdMcoF3uXTEreXFUWwJ9iVAZ04SuN1LLqPNBXGNeZegQ3RZ6Th4NaRj
         i06nnqqROfi7pIyFbXHnEPYlqE1kk2P8EBUxQXYNfvADYmhspNjwjcYayNrwqCdq1RUY
         eP2NJEeK+BHzRTVaH3eLsY6EuHmtHNrWhuOdaD24O0M5IUMj2v/oD3DjZ0qoVc8FHgNx
         bYMHlPTRKHWEUSYnv8VzXi1I3YUsFWNbbCLRhSTtlGZ0vLU/ch5acrbL/bhjEwg8vnL1
         T5ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777295621; x=1777900421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        b=fjU22mZFiFH8BPivB4f4hAuRn+Thear+i03qWKC7xdG2unGqshyPFLigZ6bwqTlztL
         7nEarz1LI7sAqEkMFCYrVZXCmfwppckkOjtLyTVsHgVydsnkpJQwA7znjLbOXQgkuREJ
         bWPpQXNVHRdkWD7uhasEgqshkkHcPP3GrU/cCFfsvfF4jxgbsQV7mJSejtML2p2Tt/VM
         4sbCQeFKG8P039G5T49QGy4i5y+axe17ygKxyIEuMHMDzYv8nBWAzgFeMCYV0GawT3HB
         bmhxFmIJmCsgmB9iurGWww5Z3p6Su8Y9+1Le9DRi9AQB+Z10kbecZX/8ctgcxZYot7Cs
         UD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295621; x=1777900421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zTEZOstYQ1Ndkmbxb0gXIziFqMiC9RX7BP1ekAY2J0=;
        b=LVNg7PvK+uCdrDtJ1CZTApa3XRnHUMlhGV7fMSNa7G4MKnjnLNZQGLpkIYI72a7AOY
         56vF0hGhwCtZ8Y0+iJ/7pttf2eEVswUTRFpbxt0iXIJa6KLU8AXKyVWxLTKA0b8KGFah
         YN7UAtTK5lZ9dha5chvSp5mNuSYKzN3c71+J+xf4P76zXhUW27sbtLvnXm9dflPpq3oK
         J3OGqx+005+qVHKbqdW3uS/SC7GjNPSTyDPL5s/nY5UDJTxmEdVLQSMd1AJ02r31rK32
         imwsbR1vCXOoNFY1zJoD16ZVtkjj2TmfuQ34NU89BO3cfYyQFK+ZEF12qa6b/nS2pXEJ
         Mfww==
X-Forwarded-Encrypted: i=1; AFNElJ+Wo3MjfAl/aOYKwfEIX1inm/u8lg480XxZKj1I410GCK7md2CYLC3D0h517SnWrb1wbwpSIRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bhMj6XX0m5jihybJtWdMlpA0jXiswZBW7WCuQTl7GJiPQUay
	mypMsvLy22cmWeS5sjFXKUhug1C+f5FcgNsZW+4B6GRk9Mj/DwPOePfKvIIC/2LmHekrOnhwo2T
	13kVnyhfTJIsZzcPEYx+MYRihJj9T+yx5T3Pw7ULNVw==
X-Gm-Gg: AeBDietRGl8gjO5fSTazgtb/EDHBFaxRfyApGxI6pZPZmBNiaDvG7Bai3Fqqdp0WWIt
	vgK1PWTSt7xPmqgD0SRNpqeC1oKeaWvvDJHLgn2j8nupoJcnU42wwnmzf94j9fL5ryy6UzTaox8
	wWuXpG4+p5BaxifPfeMmJmxktO2hpgcbmEFVmc6akizRDtB8mJKIKWqKKfAMc39C50fCP2awU59
	ofwFW0MRc3Oz7xm6blJX4P6UbZ4D7uSgWoxUH7L8lf/XN792Fll5T54ZSG/KpjzZvzuRyd7ijdb
	EamNCwOFPqtTNre1ckw=
X-Received: by 2002:a05:6512:3193:b0:5a4:1310:473a with SMTP id
 2adb3069b0e04-5a4172ca11dmr12799424e87.10.1777295621120; Mon, 27 Apr 2026
 06:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417111331.158190-1-ulf.hansson@linaro.org> <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
In-Reply-To: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Apr 2026 15:13:05 +0200
X-Gm-Features: AVHnY4LaoKv-9zR1nRT5b_JUXnSu76zcBHdPRCqIMP_MLLpQF4ZFC_5gwPwYYIM
Message-ID: <CAPDyKFrZvNsURsK+jmeorDmaN1icXnC8e4tDTk0A42UmtVSTcA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix detach procedure for virtual devices
 in genpd
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E1B89473403
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241324-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,linaro.org:email,glider.be:email,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 17 Apr 2026 at 20:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, 17 Apr 2026 at 13:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
> > genpd calls pm_runtime_enable() for the corresponding virtual device that
> > it registers. While this avoids boilerplate code in drivers, there is no
> > corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().
> >
> > This means these virtual devices are typically detached from its genpd,
> > while runtime PM remains enabled for them, which is not how things are
> > designed to work. In worst cases it may lead to critical errors, like a
> > NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
> > reported. For another case, we may end up keeping an unnecessary vote for a
> > performance state for the device.
> >
> > To fix these problems, let's add this missing call to pm_runtime_disable()
> > in genpd_dev_pm_detach().
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your patch!
>
> This survived more than 160000 bind/unbind attempts[1] on R-Car M3-W
> and M3-N, so
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for testing! I have queued the patch for fixes.

>
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
> >  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >  {
> >         struct generic_pm_domain *pd;
> > +       bool is_virt_dev;
> >         unsigned int i;
> >         int ret = 0;
> >
> > @@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
> >
> >         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
> >
> > +       /* Check if the device was created by genpd at attach. */
> > +       is_virt_dev = dev->bus == &genpd_bus_type;
> > +
> > +       /* Disable runtime PM if we enabled it at attach. */
> > +       if (is_virt_dev)
> > +               pm_runtime_disable(dev);
> > +
> >         /* Drop the default performance state */
> >         if (dev_gpd_data(dev)->default_pstate) {
> >                 dev_pm_genpd_set_performance_state(dev, 0);
> > @@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
> Above, out of context, there is an error return.
> Should we call pm_runtime_enable() again, to keep the reference count
> balanced? Or can we just ignore this? It's probably futile anyway.

Good point. I considered it, but I think it's safer to keep runtime PM
disabled, if we encounter an error.

If we end up converting genpd_dev_pm_detach() to return an int instead
of void, then we could revisit this.

>
> >         genpd_queue_power_off_work(pd);
> >
> >         /* Unregister the device if it was created by genpd. */
> > -       if (dev->bus == &genpd_bus_type)
> > +       if (is_virt_dev)
> >                 device_unregister(dev);
> >  }
> >

Kind regards
Uffe


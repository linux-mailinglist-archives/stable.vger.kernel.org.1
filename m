Return-Path: <stable+bounces-163392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A17B0AA10
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7ECAA6C28
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BBE1F30CC;
	Fri, 18 Jul 2025 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7CeTc2X"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413261E98FB
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862773; cv=none; b=CRA0CjahkhDKl/K9wQGvnkLQjnIIMCnsB3I6aR4yoUGu4hQizC5IJHPNIGIBWsK+ML6HtrWpMYBVZol3O6dE/czXWKhcOinlq4M7n9Lr7j25eGrIjKx7VMfNiImOEsaYlrcukt2pD2tfz/POb/+YzQWxYGYVlAFpcs6BkFjIklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862773; c=relaxed/simple;
	bh=34FVS4kZyUN8z0J64LY+FYLvw4SAjrJgfg+9PvBf/bc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tQA4R0ftoWPG+ZtGCKB8AIl/rAwFBP8hvJGQDf1WYlGxEYDMN5jzRFF9w9lmfxq3f7MmnGqQAVPN8kpdgE7VeBS6MpIJ1DyUcAy+6/sth30ZkhAUSlYXR3FA1i/ZQX+xPh+iwKiRqmL0FvWh10/pMA7oSUssC6ltEUga/6C7FHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7CeTc2X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45619d70c72so28199125e9.0
        for <stable@vger.kernel.org>; Fri, 18 Jul 2025 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752862770; x=1753467570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZoxL9CcSzlDoFJJH0NKdHgkv+I5OO5RtmkFXzepTuw=;
        b=O7CeTc2Xhi7SU8dUoY0EqfaKV9lxLSAHg8QgXcAVsbipNnAX9RncuipZWMX5wreAYX
         Ym1xG3PArpkG4Wg4dIlo6mgUPd0prM6ruUFihlTBYBXoaG3MnvTSoq6l23ovNXl+LGtS
         VlBI/EkaASnfKZEpMJL3ffaDS9FxdNk8PAoQbqdYXJlvzt2PJ3eiczLei0QKyFWYYRkU
         4Sl3uV5chpw0utrIFTIx3yHDUe6s4PV1xxYBxJGI7pA5b3u4ddvsjpTV3ZejguDUUHfx
         3kr6Fh2dJ2nvuDbTaQxewBaoj2rL3Ih6pQTTSP6A4Je9hKE2ivkHyHWeYIrgf7/06frF
         S0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752862770; x=1753467570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZoxL9CcSzlDoFJJH0NKdHgkv+I5OO5RtmkFXzepTuw=;
        b=gUe1Y6/UDagp4r0KwK9g0OfmA3bxVkJ0HQzEaQDUJya9/GthkQshiCWP2d63JgRTvY
         nycfSLRtz1/VhyIAvl34BLjZcNEFOuuGCknmnRwY1yX+P2ZRvH8mpl0jZ1Q7xOl+ZVaM
         QT0sjy+hCiSf9MNnZ2fHdrPP8RaNrefFqlQ80AfaAwgcBLefNGb0r+st+NFYkqVNOKqk
         VnZRvDSXy1Zb5HCE75A6yFOXZW8ske4jMgNcLK+J4JwAZEo6tZ10aL/5CDSzrN3fGODT
         0blOXaLPp7AlbSQ10DFK5+MBW1qS7soIR2AYTSAVVrc/USAV8anKGRvF0AMN/yukqbTa
         jvag==
X-Forwarded-Encrypted: i=1; AJvYcCXAUXW2C0dDsMrLevG8pAmH2oV0hgTzzkeU/ZSEvWFNM3hPEMu9EhI1ESlKIsZbjjIxIDub36o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAl8mbA4q/Vh5RYXiZN9m4DV8G7zdFn3C8nKgstSOusPPiQWeY
	lm1vaJTuur4bZtuab0N8IKzd9x9Ps795viCnWuEBqaGGz/QZ0tOCJucxbQNEZ5R/+NEUirRi/m9
	kFlWmxlTHvwIDfBNrnllKJBI6vncz8MhPPbOuC2dE
X-Gm-Gg: ASbGnctYaJzVKyGwWZs45eFeMNeHO6YH7V+uXEUz/QRPgC/nrqvfjBKqUfT85EDJb1T
	oRxfII2SGuhUHqTPaF6hDNOcTVoCQl+0KUvr1S2Vr2Dyi29bTWOlzC2Uc2rWzsBfLQi8N+Ruz8P
	vH1zbKJem0Uw/cGoFE/n3lgakvZ9DWsIita3ofpKlHWe24PUXJTxHpZShYrO+lpg41Bif3Qul5U
	/1uWWKvZl6nuEha3e7vU0c9lxo6oxa8FA==
X-Google-Smtp-Source: AGHT+IHELKeGUvq/utz7XfCwr+PXpx5iON13lzJnBgL8sRMjoRNU0XoQgObKyxgle1MtoSmvweLnwwnvK8tEhbt34yQ=
X-Received: by 2002:a05:600c:858d:b0:456:22f8:3aa1 with SMTP id
 5b1f17b1804b1-4563a4fdbd5mr37375195e9.2.1752862770445; Fri, 18 Jul 2025
 11:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@google.com>
Date: Fri, 18 Jul 2025 11:19:18 -0700
X-Gm-Features: Ac12FXwlW-eLtlDqPyhmYwPVR0xXpbglNsPKS-POR8Kg98oQdUjrjaip8zrN90E
Message-ID: <CAMHSBOXK6NScsoq6aP3-K0UGsHjDofQj6xJ=MiU4O7CeU6kHTg@mail.gmail.com>
Subject: RE: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: ricky_wu@realtek.com
Cc: Arnd Bergmann <arnd@arndb.de>, gfl3162@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gwendal Grignou <gwendal@google.com>, 
	kai.heng.feng@canonical.com, Linux Kernel <linux-kernel@vger.kernel.org>, 
	mingo@kernel.org, stable@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

> > > -                       if (val & (SD_CD | MS_CD))
> > > +                       if (val & (SD_CD | MS_CD)) {
> > > +                               device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
> > Why not calling rtsx_usb_resume() here?

> Because in this time rtsx_usb is not in runtime_suspend, only need to make sure child is not in suspend
> Actually when the program came here this suspend will be rejected because return -EAGAIN

> > >                                 return -EAGAIN;
> > > +                       }

I meant:

if (val & (SD_CD | MS_CD)) {
  rtsx_usb_resume(intf)
  return -EAGAIN;
}

It looks cleaner, as it indicates the the supsend is rejected and
needs to be undone. The code is in the end indentical to the patch you
are proposing. This is just for look anyway, the patch as-is is
acceptable.


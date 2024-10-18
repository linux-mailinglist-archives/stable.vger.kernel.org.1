Return-Path: <stable+bounces-86890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7629A49DE
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 01:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46B8284AB3
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 23:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4837BAEC;
	Fri, 18 Oct 2024 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="hvpc2sPa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAC143888
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293330; cv=none; b=S5yEF2DQ+dvzN06PAO31ufTpx1kYBbI0cqAb/NfVSYYWXAbckZxMK0XzQrFxvMPnOxf4MJtHAVd7LT0WQ+WeXJfoLCTCeIp9NBJA8CG2VKe12sSyWeUhMlS9/sYkj/ItmvZcgl1iAhzcTlgqauotd++vQijuVvQWVPq2tW5l7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293330; c=relaxed/simple;
	bh=WmM4mn1uG+W/QaiKQsfsqfIu6rhTJ+JkhO0oc8Vsrjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx6FYa+7eARzlG7Dpvi5TdqUyRL9YwYyaOm49MsjRfLJOTeldIK67aBe7sIITygCSSnU2JCkDyIT3H/S/HEX+XGuF6eoG+dVPrPXXpTOSfPKKo0hb+DObyna2mgdARepxmlGlVMoY0HBT6qbzheZAXAulbdf3IVxLr/TNvzitbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=hvpc2sPa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71eb1d0e3c2so225215b3a.2
        for <stable@vger.kernel.org>; Fri, 18 Oct 2024 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1729293328; x=1729898128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WmM4mn1uG+W/QaiKQsfsqfIu6rhTJ+JkhO0oc8Vsrjg=;
        b=hvpc2sPaHUDu5/Plq5+IFe77gD8Szzp/9bLmO5tvGngy9Op3C2opksJ20ZoOBxsYsd
         xUAffjV0nj9F6E9hwRvVHDsKlj1hIbsnmj65FXcrkefvx5YpeUJ259RD84N4ty0eBi3a
         rTz651egMbQGkFnabE/smdbwk/rSsUXKLdjljMbksrv6whRdgQllO84DiPWaif7fUi6T
         qHEDGu51AxURLUn9dzmTdiQmi7gbHJ6+Q1usDHAuYrdeKr7aPKm4W+/++RhX+e4bhGHs
         ztyCwSZmyHAs+DA6NSZWmGL7yT8/V7urSTfUrCJOhbAhep+GUCUChBiT3FyCUb2USiAk
         r+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729293328; x=1729898128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmM4mn1uG+W/QaiKQsfsqfIu6rhTJ+JkhO0oc8Vsrjg=;
        b=ELApSBsQ0GI1XUQ4jSTzg9cLTqrVixv1SOKT4sVXH5OLzhf6IjrVqQPB7+Awg20ALX
         EJz+F/UTa2qXHh81ZuL3SfQ+eG99lQEXZqm82cpVdRywdenfUo0uRCfoUq5ZWFl2qgqz
         1LEO9w1SJs2/Kml5ZODImpFOkYw10I8BA1hfCrseNKiEMsh+wKdzs+1HwlILD2er5oji
         tzumdvfhVv/9+FbEL64gHW4ZDHM/5XhEh/qPrwvT/9yRilHnSHX1HITqy3dDi/VclA3i
         tUrdgmnDH1irul2CTgs+DQ4wXgOSLBAiBBa+7NM8svsZ2sD8lMBxklov5IjS2OFcqQKa
         OBig==
X-Gm-Message-State: AOJu0Yw+ZSw57/DSImnTjB00pqLB3lWurloIhre3Z1zouVfJnvogANJq
	Odx+7SBXuw1iLSMkN4etyYvmCL/Fd0eCoN3klHWNmJRkrMrKwhzyVDmkkcUDLj2P9EUYAmic1MQ
	WqUFVhN8uyh1rVmfThazYOXIZUoA3lmJsepSZbg==
X-Google-Smtp-Source: AGHT+IHy0LHp2WpuZYGexp0T+Ju3IBaRu7XGQRgALvxfryYO/CTNmMzVsBhM8KF5jWh1WNbD0P1cW0f5eHkYYwt+r6U=
X-Received: by 2002:a05:6a00:3c8d:b0:71e:e3:608 with SMTP id
 d2e1a72fcca58-71ea3224f36mr5582634b3a.26.1729293327633; Fri, 18 Oct 2024
 16:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
 <2024101613-giggling-ceremony-aae7@gregkh> <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
 <87bjzktncb.wl-tiwai@suse.de> <CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
 <87cyjzrutw.wl-tiwai@suse.de>
In-Reply-To: <87cyjzrutw.wl-tiwai@suse.de>
From: Dean Matthew Menezes <dean.menezes@utexas.edu>
Date: Fri, 18 Oct 2024 18:14:51 -0500
Message-ID: <CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
Subject: Re: No sound on speakers X1 Carbon Gen 12
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Linux Sound System <linux-sound@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

I tried the patch on the Thinkpad X1 Carbon Gen 12 but it didn't work.
There is still no sound from the speakers.


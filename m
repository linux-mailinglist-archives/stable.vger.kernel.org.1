Return-Path: <stable+bounces-179188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A45B51451
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 12:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FEA3BB681
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217533168E0;
	Wed, 10 Sep 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr012LlV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA48262FE7
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501174; cv=none; b=qsZFwRCmbr+BsIevZ3cIERF5qdI4xbg+MvyYQ8EDJFafRoEMVyNkexKYZNrL4Bs1enD+0LV0Ww505HPYbj0vybBdERwiy7+e2LGc3IUGwuafe8mo3Ddyt/6cG7/1cZ4I8umXO2ysmoumHXi3F53Ji9yNOXjzLO7O3QSCMk4KQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501174; c=relaxed/simple;
	bh=YdQDjKnCp0fZZEDL6h7rSAoz3IU0LZop9X2eKSzS2tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3WtyfZkDlmy+MsBXmmLU3Erpm7NhImqm8Y16UBpqFJTJB4Frq1T5CzMJQ56xKaBED9gTxmOpMlgntJGvQ7mHy0lvdRyQhGuuwCM318xN4gdq62+v5z3+oJou3MIDaW9hvqM/2cmEBf/31IUKZ5nMRNwxw164wrkiDGcXFFzkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr012LlV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757501170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ish3TOdF5itkEce/x1a+uOeE11uGbtv2vXkIso/jAMo=;
	b=Xr012LlVME+G5KE53VkVKcXsTgQr7rHHsplHBscAVTHICNCy0lKfEu0DfpSAbIHhkRFyPd
	TC2RW59ixnnXpAahfQOPEFfEyUFq792/LkiOY6hD14X5ovve2ons0pgQDqTz8pV3YBjI6e
	VwH0UgRG9v/g2qWFeFDhWAgnynxC7/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-u7kwmt7ANIC4ClUO6UdXGg-1; Wed, 10 Sep 2025 06:46:09 -0400
X-MC-Unique: u7kwmt7ANIC4ClUO6UdXGg-1
X-Mimecast-MFC-AGG-ID: u7kwmt7ANIC4ClUO6UdXGg_1757501168
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de07b831dso22745755e9.1
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 03:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757501168; x=1758105968;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ish3TOdF5itkEce/x1a+uOeE11uGbtv2vXkIso/jAMo=;
        b=UQUAu36lmil/BEU8cFRpBb5qp60uTEKWLU8WGTchiq+IwFo/R7ADmluuXP187X0WNB
         YJ5pOsjwkp2JpM1H7+0R0/wrpeDQD2Rk741zR54KN3O8uu0Sp7As1opEo8TQ5epy2fB7
         OFsCnUFYjbJD18BqCFIOxeb1eyhvHIv3cfrlf08P5bDRf+M2j+z1DYa8eC/3Y+ubU6yw
         x0S/yHfmnn6zODtwKd6CfU3LpUD/6sOCBltrTkDaLqMc7WyZQdDNvVAcMfGQCkEKFR2b
         H2qyK+vGsMLKvlw0vmc/rTobhKZL784uNwKATkiudPk69zbNSJmEEScfqt5OwOhfWB1K
         ziMA==
X-Forwarded-Encrypted: i=1; AJvYcCVgqrmQ6xWDdoM+dnhTmOhK+wqtRHKrnUfodmc6BPOHTHE+UvyP/vXNkoStbs1nvgnF1s9KnjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOQ7ER/bSTbP6P58+hxsDjfjdceet51uE3WWm0jHicNzimy7T
	NwC8QhivjqkG7FRwzhKwwZG7zHlDxo+J6cjB6MyBaqcZsACOYmDlIqvuwStvZiYeR+KZY2j7xpi
	FliJRda1LANNVvHau189yzBtvWoDz3InB+8BSsbSAVYhFvRmtDTagjowD0Q==
X-Gm-Gg: ASbGncssK3dk8L6ym88kKreXakm5wR8TMhyriZuTCOmCXSNsQdE5AxHQEQUi/qStvdH
	GRDi1l7abk3qao3xh41U2CD63EB0fYW/N3W5lZRrKxvnVPQCaoeoczl6gQXn0B373yH9yBa7zVB
	Byh5VRDXKqX8eMJdp2e9VE/txtPnQCVPR8Ge3zNiOCm1Bm14LMz5xyiJKQYF5SuVggHo27sHaV2
	nco/BcsDwXbyFzawyhkbexnuh65Xxb+Wff4i7ACAKicDNSlLsDPQIyGG3L7aMOj4h8gMoH0NW1F
	85t4+pd1hk1QjGHrUEx0Lep8UvJxLO1CmH++02ngX7NjISpKUUiJ2HJrpj9QHUu/M+kN8sRS+Ku
	mNvM/iWFLlgYuKHaFFYuVIg==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr134563055e9.24.1757501168132;
        Wed, 10 Sep 2025 03:46:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE41It7Gch3Cc7HmzlNTf33KcOKcEcqR+1x/JRLAyd/4r51Mnyjg/51A7Gwi/T9TvTKWE/bSA==
X-Received: by 2002:a05:600c:45cc:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45dddec78d3mr134562745e9.24.1757501167668;
        Wed, 10 Sep 2025 03:46:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d193esm23564835e9.6.2025.09.10.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 03:46:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Brett A C Sheffield <bacs@librecast.net>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Simona
 Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Thomas Zimmermann
 <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Murad Masimov
 <m.masimov@mt-integration.ru>, Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>, Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 1/1] Revert "fbdev: Disable sysfb device registration
 when removing conflicting FBs"
In-Reply-To: <20250910095124.6213-5-bacs@librecast.net>
References: <20250910095124.6213-3-bacs@librecast.net>
 <20250910095124.6213-5-bacs@librecast.net>
Date: Wed, 10 Sep 2025 12:46:04 +0200
Message-ID: <87frcuegb7.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brett A C Sheffield <bacs@librecast.net> writes:

Hello Brett,

> This reverts commit 13d28e0c79cbf69fc6f145767af66905586c1249.
>
> Commit ee7a69aa38d8 ("fbdev: Disable sysfb device registration when
> removing conflicting FBs") was backported to 5.15.y LTS. This causes a
> regression where all virtual consoles stop responding during boot at:
>
> "Populating /dev with existing devices through uevents ..."
>
> Reverting the commit fixes the regression.
>
> Signed-off-by: Brett A C Sheffield <bacs@librecast.net>
> ---

In the other email you said:

> Newer stable kernels with this
> patch (6.1.y, 6.6.y, 6.12,y, 6.15.y, 6.16.y) and mainline are unaffected.

But are you proposing to revert the mentioned commit in mainline too
or just in the 5.15.y LTS tree ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



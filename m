Return-Path: <stable+bounces-214668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD1mGi0OhmkRJQQAu9opvQ
	(envelope-from <stable+bounces-214668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:52:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D1FFE71
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1E63039EC4
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440672C3255;
	Fri,  6 Feb 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="bI+XVa2z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CD2DA742
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393108; cv=pass; b=U0giD9rvKTz4e8Jixv1H57JNIv0ITNaYJWhlxvvEAhLNsTvetLh2bC5tB30fOd8Sr8OiPxD94nWmdg5yXxNUTQVPGnLY3jbBT82fTL4PHibsNNLSOEM0WRFj+UB45UrAHASP0AUrk0TTNT7zL+KX/VJBUflSxLWlrwQUXpAYYMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393108; c=relaxed/simple;
	bh=xrdDIefzzy0QOLTjUX92oOyd28Gi+PdL7ypt/PbFXsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd4MoN+kyK0vDYB4mMBrcTQs067DBPoLVsFhjZwho7UkM1NKbK0S/jS+yItOElAjU5iQZw5qPD1ED27RFc+X0HV6fn6IA8MvfyJDmwHH4AYn+83p+JIRfdfgZlz6xgXCE0UqCgtP9pSJYQZELqtPES+itgM4qvNXeIWQMGT7paU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=bI+XVa2z; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8871718b05so358216766b.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 07:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393106; cv=none;
        d=google.com; s=arc-20240605;
        b=dLkCPCnwfcGBSoid+XOr8D7RUtJZ+7gR885PCQaJ8HyeC4ftSPM0NV3LnYO/BYZWJO
         X4OlwHxd6LKj+POD+Zw3Etw07qi56yshAnwbePqXHjiCZZhNa69YC/rSdIg0YToTfeQ6
         +Qf9GoFZPIlpyGzywYDKy85+JAEq1y9vDPrvFZbplLLRItQhpGlFWLuYxC5NY7FpR+6V
         iW388FdW3MIccXbK5gof/CKik1gKgJSwfGoxr2OscVsswBE9wPOgpQkhtQ20eXK0MtPn
         nFwn57WplZE3tkdSVWFCXNjunTFrHO1cD6BzBYF5YQm1h7RCG/9DPEjW229xEJbTTw74
         luIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=hwJakASJSyTTgSvmqXKfmcW9qXJbAd0dbYkflOomiz02BV8GjObVXbeSONg+1WNxU0
         6yAHBDNsWLcpt3yF+G/9xyS3PNAI0W0HY9bKl+V2PPOS9siJw1aQiQoYsHdE7fOyp3iu
         tnDdxbhQZ9KJ3fO2eIJWjDxhccPYmpHgLee9NUwR5Q8Wxu18/sQcaFEFY3pVQUBYf3y2
         5wThBPuOWhb8dt077WPtiiXPZg8zc0MVIaWsK6j1/kmyxzjmo9kyzpGV2GOWpIWD4Uaa
         YftroFMDZGWhW8eU6WR8YU1Go4Z/Ma8+7hpTm3yA/UUbrCLAH99oAzHz5QJG0VfsnDAk
         PrOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770393106; x=1770997906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        b=bI+XVa2zMKhM9tqyICbDyVCrItnd5w1c9yQ8/P40XekEw0hyejqDR2qiRV3DRBv7Lu
         9OIfCqFGT4KSQkHkiXFPlq946kMkGtPqEuN8iacTtzHPH7iu+h4zf921ncrJQ6HmmYZN
         0FkV2WcmoYGkSWS2bXijYaJXgq5I9eIJmAmn1yqcT5oMN6KyfIOnydesnlql7lFtGfY/
         MHpHtALwGLNA3mMbqCIGbEj50gIAtcw40knwglRDeVpvJ/di095ORxig/4kde6XtMxr7
         fIau8e/ULFZtGsDVa2USK89Myz4tM3rG/JobR3QKZ3KjXpzEmB+ZQrceY1tFHJ3qKnI4
         4f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393106; x=1770997906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN5Q1rb74JGxqPEaMraAIeSQS8Pn+Rcaf55IL0Ede0A=;
        b=ehsAnORqxJm8iWiY0tCQu0mht2xJmMKnvWEvUxydy1WVnS5ycZJbYfXj2hOimDjaxb
         oYgN17UE7mmZmQwS+8pLsB87MOeAhibPOlU1U1XWpz5iqAWYnOqIaO12I6KnaWF6oR3R
         XKpQYwR1MP/zNjtMJuq+xgecCbTFePLik8FhC0CxGOQeEt2H31OHavZd8AfbO8VPK5YZ
         AFt7G4UVRRxU+bouugS1LpzJbIP6UiCDzPmr3qDPRVn1dN3QBS/ONHG18EYmeucoEREG
         tPkVSGvWGm1BiQEMUTF4AYLT0M282Yb5tc45TaPMIlh+4st9J2o5QXbvIqlMaAgCwpO/
         zIcA==
X-Gm-Message-State: AOJu0YyEb+Xzp3dvsRVeoioaE+XzMpE+zvQT/yCWv1jDqip1Iaf9ax3r
	tC0rCTawKW7u0lkxxiOj/9+9T7a4NFOiaT7kLHUzr4mgenSY2tbj8G3/4tz432Fn/f4ErFQhZhl
	bAtK/sCKLgR4ywinQHYeA0Wu/W9p7KZtt882IBbZBhw==
X-Gm-Gg: AZuq6aLAA6dqoVY1YiZlZja6Lf1RxBTTT0eyMUc1Uwe93K0pcnVmfYKULOdBMrIxE0n
	jDl6uLL6nyy7bqxLWDZagThVDV8oGYT4Iu3Dw4wCC9A5SDEREWUAmbBNhJ+t8AC52B80Tg1CcKP
	J0wmsU+bTIImmqOf/+txnPb3UFokZLDpH7RQq8Dl1pbRk4io1sJ5TPBPSCThujI1i2O2mK6cwb1
	jWU7I6/x3pk/LTjeJkOwgUi+3bRbj5oBTNhRX4hrZ2q4OYS8RJ//xd5bKOm8jPo9rJ1rb1GhFMg
	udiyi3g=
X-Received: by 2002:a17:907:9723:b0:b88:411c:fcbf with SMTP id
 a640c23a62f3a-b8edf17fb9cmr188366666b.12.1770393106104; Fri, 06 Feb 2026
 07:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205143441.536029503@linuxfoundation.org>
In-Reply-To: <20260205143441.536029503@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 6 Feb 2026 21:21:09 +0530
X-Gm-Features: AZwV_QiTxCz-tl8IaT3uzztf_pjB1hSwAWhovb8EAr3H6VOjHbymxHrowu4VA1I
Message-ID: <CAG=yYwn1Osj7kyK8qDrqZjZFNNwdefA67LOxLBqFoYbi1YWQBA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/203] 5.15.199-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214668-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BE5D1FFE71
X-Rspamd-Action: no action

 No  typical dmesg regressions.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology


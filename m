Return-Path: <stable+bounces-188859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA38CBF96DA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 02:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 071794EDAE4
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC91BDCF;
	Wed, 22 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArOB/JiP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F051DF72
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091671; cv=none; b=Y94Z4z7uvQmHlRzDWH9CZ8k3/CMPNpZaKyKjoBe7R6b4I0m/nkx97DbiMhdTGLRzyfppNdKG5UIlNklPOhC9P/eXaRpT3sO5+6XpViffuH1FYHDgpAoqrpjrZWLQAIwrWk30xDogomGxboOIryP7aaxoKWTNArej3N1eUKGXldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091671; c=relaxed/simple;
	bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUaaz7PJqG1eQRK3PeErbIstzbazzuT8uDbUi8/YY67pxB+h5Rc3wePUKly0ZYo1kjSUd6hiOYztHKkJ8L95hs7hLLqHE2lCg/ndQ9Q/S6Ly0FBFI9JxMin3QFylMU37ePp9OXx5brcljQ64zXWBkyAorz6zgQyarHVRocPJfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArOB/JiP; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89018ea5625so1511865241.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761091668; x=1761696468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
        b=ArOB/JiPpnduati9J80En2DfivPATFu7VtpXIZLMfBawihioB2cUnGQagP7ru8ErVr
         Uy/xJr+pOcmOiSrn6wMaDP2i9shhLeLG8OP4OECcQAq3tjs08NUG3yD1Rw1ja1z5k4Pd
         obHbX1FEGqs010XfLGFSHwbieKO+SUevDouPlVfTXiyYnIJ4u/rJJF8U4tsNWv1dvpiY
         K6SjW91ko9JwVBGU+FIZ2mNvzEnDO20+hOdYcTPta/aLc6THAV00m1rzwgCuZnMfflY7
         Wet9Tilu9N/ndtpHWjjyOaI2B/+ZPeW2IPbiJkue8FDY+tkXYwFiGrYorNkTxJpuebtf
         8uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761091668; x=1761696468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4rAzEVY+oK9Rlt9el+kLv1jai8azcglFs+lSP3+LP4=;
        b=lisLu6TQ0mAQrWK9Aj4g3lIotMUZwDen8DJ1YnAN96l6Ke1aiyuxQaMEpjKtaYWslT
         AkZrVDxqIEZM7kTAzvkQ7bD3is2/EsQISw4yvKWeiKrtxYtIcNm/jk54cEkdHqC7VvS4
         bYWQHIRe/iW6zwbUt27QInatqO6sjKYFbonEKq0jb7q+VNSKr8RF+yK//hYsW9SkARFD
         /lJIqxwoZz6aQ0brVd8Jb0a/8/4tpZE1sG3su3VBI+J727qEN3uDnID0jmb77blZoCM9
         aspZRQ9iEGccj6Q2WM+4ONLAEJyFhUoSxLoiAQdY/gLt4jmz3+oImVRYnqalYSU3Rhcn
         4OLw==
X-Forwarded-Encrypted: i=1; AJvYcCWJcEW/lLQcEBM+ILNekOg6X3RSFiojP0ubqas6KVq4QxAKmn79UXOoGRNtGWTz9ffw48aCc5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjD9H+RoqgOmXe5Fg1BD7uGkIAnhPY1tED5Lj6OkUnIT1ufBRG
	pR5ZuXzEwvq7Dnb+PFGgzORT8qvNwkvQzC0Thmar+C/GryeYT3AvuIGDnT77tJWjN+GoFZ5rGZR
	pcCD7kaNf9HyQM4fgUaOl/+JOT7JDrN5UynxDtcto
X-Gm-Gg: ASbGncuJRHMjO7gpyHl4s+yrvP//fRWi89ka/1fNYrQXZ2T33inWKMZkcq644N0fZrj
	FJHVGmZA6pizITyd+cKWTnFhnswAUQZ5wQgVwtpMSNDG2/L7telI5Cxfc7P59t0mDbK46b3x6Y0
	BHfRnivsiwejGRj90mzsCsSxaptS9qZ6m9XbUVSCy6D2T7QBHr7d6BH09wfT7dUTAfgVxPbWYpp
	GeZtgaANhjyDzhNBGfnU8bnG0We6Yz9sNglhtUF4b5XXNhet8dxnUTwbLL23Fyr+w+bHWiPMfCb
	EyFbQONOokRWqUuaYbUxqi5TXw==
X-Google-Smtp-Source: AGHT+IG7kemkMTF75DLYgBeYC72cxlpVChE2EPbjfTmlF9qvTWS9jzyzy2BE7qmqEqQP1ek6xqr2wkfhFZev/XU0VsM=
X-Received: by 2002:a05:6102:6313:20b0:5d7:de24:4b0d with SMTP id
 ada2fe7eead31-5d7de244f75mr4084318137.3.1761091667997; Tue, 21 Oct 2025
 17:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017223053.2415243-1-jthies@google.com> <2025101839-startup-backwash-3830@gregkh>
In-Reply-To: <2025101839-startup-backwash-3830@gregkh>
From: Jameson Thies <jthies@google.com>
Date: Tue, 21 Oct 2025 17:07:36 -0700
X-Gm-Features: AS18NWDlmX_v61JBT-NlUI9y7JTh8Ff3kMhR4mc9pCwQjIwup5yY3_5Idr-cCDU
Message-ID: <CAMFSARf1Mp5ewJsig5Pv_0n-kEsLq73Nio0i4r8A9YxTCHrJ8A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when disconnected
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	bleung@chromium.org, akuchynski@chromium.org, abhishekpandit@chromium.org, 
	sebastian.reichel@collabora.com, kenny@panix.com, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the incorrect commit message formatting. I'll resolve this
in a v3 update.

> What prevents this from changing right after checking it?

There is nothing that prevents the connection status from changing
just after this is checked, but that is true of most of the values we
are using to set power supply properties. If there is a connection
change, ucsi_port_psy_changed() will be called from
ucsi_handle_connector_change() in ucsi.c. This then calls
power_supply_changed() which should signal to userspace or other
drivers that this value needs to be reevaluated based on the updated
connector status.

-Jameson


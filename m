Return-Path: <stable+bounces-16233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26183F5B0
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E0F1C2244F
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CB923773;
	Sun, 28 Jan 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Be6XmJOE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813D2376A
	for <stable@vger.kernel.org>; Sun, 28 Jan 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706450479; cv=none; b=Lbbr+fiF8/LSWkfBzlkH1Mo8VSd6kg073LBHjDiKPccmoyz3sBLjuIZmJ+htnzQ1m/Yk5GBumnAhOsKBSGZpFensBBhbCN2Fp782XQDuB7JQ0BjDOQV1JvG9Zbn3tc/6Eicna+cy04APApOH8dY7lvdVO3VtNGvSQ8TYCh9HWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706450479; c=relaxed/simple;
	bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ervhF0Um5XLu6k7JGePDmiq+aIs464HtkPfyW/iTWtxJ31pN6VQZi6U3OA082iGIpz1RjQ2R3gT3/iYlZDECTsh4ghNTvkk+dwDFt/QAvK+2gyVF1pT/ymh3g8WJRCuHKadljx3/20x1g8BtU5bq0s9Uyd9j20SW9LlCTbtvblw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Be6XmJOE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a99dc9085so91061cf.0
        for <stable@vger.kernel.org>; Sun, 28 Jan 2024 06:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706450477; x=1707055277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
        b=Be6XmJOE95K8C9Hr0UPrko3RJZJYUNa/4ZDDUa8aYeKyh+1QVM5hWE0V5HDmcZ3gXh
         BCRX1HHdEQ6Bq5b/FnuMA8uWL0eVrVw1POtn6hT8DgHP4to8breZqXfCY7dVjotRLN0w
         GjWEx6DH0mSE8xH1e9h0MDLxVDQLkzOasfwLGI/ykBn+Wh65WEhHQVq97IC57B83cTZx
         ZKw2TObQ6VeU+5p4qgC6DvA88bSXyc3RsG7/NdTr7QAdOdOIhdLrGf9iTBl4wEsGdKYX
         RfNELY5Kr/Tnv26j3/CIUZYknhIx/KAtaaNpFJpeYhcNieIRS9TTUgJfX0+Vt8k1Io9v
         CsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706450477; x=1707055277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avMCpwuFUa2i4x7tiD4dco/h0z+G0ypjNSRfns11g5c=;
        b=RdUF4F5+ZazlNq2oNSmU0y4bRgPnU0TbquUd4YEw70WCzfFxe7g2MaJYDdZdL1dmEV
         GHAm6Ady0OceAoDSBJAf7mLd/9fgcZp1TYsC0f3ZR4K1N1QrR7uppwxT2YpnK0L7iLAW
         pFciyoTJe9PxnQe29sgcB8g2123mUz59E11kxzIpY+URq5vBsqu0gNEffyjyOeSU4yHL
         0+04vUS4mZqHB41Fi+ZvXxcGhikDBruYDMbxNOrZ31aSlj7UxmNs1b6FOcgTZamwOq0w
         bsss77/Gs89DWNO7BNcsq6RSaMgglGK6EwxFqNq7t8+nPTBj+ZGOd5M/fMSCOhOaI7S0
         eGKQ==
X-Gm-Message-State: AOJu0YzHnXXLmWv8k8S/7lHKrfMFyiDeEXem+LzI763owg0MzL4z0l5i
	DlzGunWveasUQC0sOBKtWyqGtYRza46pzsk8NdKsYL/DUmEfEfPG9GslOpaHiqptlWKsdKaeTxr
	RQ/Zuf101G/iII0YVzyi6nBdCXy1IamIX7Ak5X/ir7RnNGlJ58w==
X-Google-Smtp-Source: AGHT+IHh1HEBb8ULsyRDgozer+s4BS5WKyZ75DXxeVJYw3c1vuZ16gFOug+pKMBLafShcXmZ+HFEwzDxpPouZEg7gLM=
X-Received: by 2002:a05:622a:1bab:b0:42a:6b64:da7f with SMTP id
 bp43-20020a05622a1bab00b0042a6b64da7fmr402749qtb.27.1706450476977; Sun, 28
 Jan 2024 06:01:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116141801.396398-1-khtsai@google.com> <02bec7b8-7754-4b9d-84ae-51621d6aa7ec@kernel.org>
 <2024012724-chirpy-google-51bb@gregkh>
In-Reply-To: <2024012724-chirpy-google-51bb@gregkh>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Sun, 28 Jan 2024 22:00:49 +0800
Message-ID: <CAKzKK0oEO5_-CBKvYSw4DKY4Wp5UPrrt1ehBFRd79idy7FsUuQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer checks after
 RX/TX submission
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, quic_prashk@quicinc.com, 
	stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg & Jiri,

>> Or you switch to tty_port refcounting and need not fiddling with this at all
>> ;).
> I agree, Kuen-Han, why not do that instead?

Thanks for the feedback! I agree that switching to tty_port
refcounting is the right approach.

I'm currently digging into tty_port.c to understand the best way to
implement this change. Could you confirm if I'm on the right track by
using tty_kref_get() and tty_kref_put() to address race conditions?
Additionally, do I need to refactor other functions in u_serial.c that
interact with the TTY without refcounting?

Regards,
Kuen-Han


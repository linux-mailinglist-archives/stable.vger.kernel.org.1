Return-Path: <stable+bounces-111899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E49CA24AED
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5828C3A7013
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED151C5F0C;
	Sat,  1 Feb 2025 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxlKm2y9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065AAD27
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429610; cv=none; b=oJjBvE+QR2+f7hHV+Gp2ik9Xddq7MBGLpzwnXJJAOvMVQHTAVLqxtGwkrAufVlkHiOy2zdfDnUbeIkYiWSLov1T8kF4pjT+T/g13dnaDHqL3BaOrdaurqvRZkU3b+ehuv+dzNX6pO2v9VbcUJTYk46PqljAxMkr0Q8T8sIMZ4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429610; c=relaxed/simple;
	bh=TVi9m+FXpuuNy2WnVumAPaiIOOSbfmn/A3QvWde7BIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOsl3UpAI/4mnRk4kII9+ty15jxDfCiBF+81hFEmtLQ4xxqc3SNHo3dOinU4jakCBDF4chUvLB69mOZh+/0feIGgIEVJp/aA2w8HL09mrYNJRw9m29NOGPWk62ApXBk/in7EGTawFZWm2ej2bw/fpYlBVTvDRfDtntkjq+O0s+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxlKm2y9; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467a6ecaa54so23366381cf.0
        for <stable@vger.kernel.org>; Sat, 01 Feb 2025 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738429607; x=1739034407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uMW1If7utrTX27Jbrn7+nAJN99N37GgFMPi/bYQfcU=;
        b=DxlKm2y9/ax4iVmdbK34AVL+jglVzcSaB14PNEMlr36DDguF4zQvwkOnP8WfuZQnCK
         8MtFagsXAOAIsjXWHYfmSuO7Y/1negARsUlvd6sjkpsRMXMhUTI5vtF9o1RSEt/LbB/b
         NXNOSS88QAgQzbSIpx50Va/7VO51FQR0UrppaUdQUpkeJ4hYYS7KB5rMxu/ANnbmHBnK
         6FwRaBWgM8yIOaxQKAN+iZ2IifKqwOjGl5aOfrS8EszfYq7s/hs2RGlYbrsmtYVGA/gb
         U3jXQyoeKfNd2GRvGwZySLTauY26KAQVI1/fuqD4JftVRYwhKSIDeGFnjmSXN3U6BtLY
         tF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738429607; x=1739034407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uMW1If7utrTX27Jbrn7+nAJN99N37GgFMPi/bYQfcU=;
        b=ivIpdTPgK9AGXTYiKVXIFvLkrI3NlzX077srBeBe318+NxKMQYGc1tG6nFgYEPRbW6
         AjvDLbmp+Q1SY2fP6pZWsH1l1hmRhRH4pZ7mh07bvLtfSJxiITktpny4BzvJ4Te/sSBW
         Np5b9OupUGJ9S+B98QEBj0tO/70lY7NdjQoJ0jXqiIdCvOQhbPFuP2OYYM1J3ixadYyx
         pE6kemlW1zVIuT+XISA0HATJWl1skbOepWh2cGWgSJ5XFDPTPX4Swt8FCQxgmJSBjd18
         odmmRKpryZhfgzJEnwDYLmp4GaSDw7UhE0wKKqgU+O23admTmg3BdhStEBAaaMQnxEx4
         rJfA==
X-Forwarded-Encrypted: i=1; AJvYcCXM0IJaLvgMdRb5FWfqGqWIWcE+jYFzqyXnHaElpKVgiAo7NdbBf4/MHwsjAQ/L976P3lq4gv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDB1N8LUIgzaF6aWX6o6oiqhkmmMmRt8zKaBqZ6u+0ePvR2GtW
	hiGUD1fTDHqauD+AjHI47LhcMsTYDnF0VxA48wpcwqfMWbGERJeTWPOywHveKAHXLz8arb4NpEM
	qiWQItgQCymeURWfffc7ap+6Eqx8WmxJYs+kvURAeBPX2wAu25XwE
X-Gm-Gg: ASbGncuvQNjPzStZ+ET4QEGlnufyoec4HB06mXLRi7ct5SkYWhVSLuqQpVlQtqVEc+J
	DYemht3NV85jK0guWYUkoHv09nHMsWP9JiRahj0WTt9KNJiBPkZHAB/qdpdbwG4iTG1pm99jx
X-Google-Smtp-Source: AGHT+IFmC1HyNfwVTjPBgR7DBNvwyTQl2MJv0hzI7n3a6E8PW/dgJ45qo70UAMkqbo/fl0MCeow6Jituu2XCJMDjovo=
X-Received: by 2002:ac8:5fc5:0:b0:466:9018:c92f with SMTP id
 d75a77b69052e-46fd09e232cmr238160301cf.4.1738429606169; Sat, 01 Feb 2025
 09:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh>
In-Reply-To: <2025020118-flap-sandblast-6a48@gregkh>
From: Todd Kjos <tkjos@google.com>
Date: Sat, 1 Feb 2025 09:06:34 -0800
X-Gm-Features: AWEUYZkcnce7KDl336dS8FbFSUJhezYUek7ALiNpEBhoUG_jqp9Sgge6yNejDYM
Message-ID: <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
Subject: Re: f2fs: Introduce linear search for dentries
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Rosenberg <drosen@google.com>, stable <stable@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 12:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jan 31, 2025 at 01:49:16PM -0800, Daniel Rosenberg wrote:
> > Commit 91b587ba79e1 ("f2fs: Introduce linear search for dentries")
> > This is a follow up to a patch that previously merged in stable to rest=
ore
> > access to files created with emojis under a different hashing scheme.
> >
> > I believe it's relevant for all currently supported stable branches.
>
> As the original commit that this says it fixes was reverted, should that
> also be brought back everywhere also?  Or did that happen already and I
> missed that?

Before we can bring back the reverted patch, we need the same fix for
ext4. Daniel, is there progress on that?

>
> thanks,
>
> greg k-h
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>


Return-Path: <stable+bounces-95784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0829DC03A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 09:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE76281C8B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C81158558;
	Fri, 29 Nov 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DgZSLo6f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37B14F9F3
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867581; cv=none; b=rGDfcBE7hYkq1uvTxdTQAkannXfo80eDMHt8/aHQBrU6U9h5Tys4Z2fvo/DZ+jOVNGVUwhjSLF7mlrdoAotZIQ2n2vvnAkSWZne4ziIC9Q/2FPCeK6U78PoSmej1KqTh2P5QfeBwayWGGDw5c9dMNsfGBUje/V18OYX6Y0o/GV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867581; c=relaxed/simple;
	bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeg1WeIhi1qRiPeFcYwIJNeJkwe2wgT0lXAdhKJ4nkU/SRM17X7D8FwHiCw1N4bYZ+SRutAa6oUBK5e0H4/klbW9R/MNaoA3JBGVMh0ZGU/vpNIyOlB9PduxR44nOBWc8tPKHztFEDv3adDvIlLc1fYVpsgrtPheazPmoimbGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DgZSLo6f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso225094266b.1
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732867578; x=1733472378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
        b=DgZSLo6finV0NMFXlYdFweErnW8qpOLo5kRxIkGgnIIZ8gcVF5bBoFT/efZRT8lUu7
         xL3d0kAWfjHsGfwba50cG6Tyh2h19ovvJuX6NCVsO8oTKmQ95lW4Ry4U60VG8kVeeLlP
         mo6aOBsr/rFDXZj2AxDc2kPGteNnXB2LshgLA4my56t88qqxKKnHvY0PgMCs62OxCf9e
         M7PvOsWEkpklDYlNba+zJiQ6824wPpQnTrg14OpBH3CqNff9sMT85OXvEM7S6C0txj4G
         2WjEMvHeIDsomS76u7ONQXlY7JQQf7MlzHCEwL53foo2gRJN9ncmehTQJDy0CaQKnUOw
         njJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732867578; x=1733472378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdCc7So5WJlPDQV9tqtG5m+9pg/vhfSFOA4sIRrWx7g=;
        b=e0H6QqYkH/tclD38S+BCIj5GQso8tJW9gFqH2M5knvp69FU/7+YrNbHTLXpEKwDiAU
         c0yLaN4ASWhDfUYlqola/2Q+iWMU+/Lu6dSViKJvTGPjdPYh9A8Wb5atsAow/YFtewvH
         C94k5AYifd/tkIvKxVNrnCncqQ6XCGMh60+lZ26dJv56RGVHfHmFLy2zQdDRbk3uWCSk
         +Xs6S9dwca54LIYy6fsxhctTsJvR21OIJMBOcyH3rk44z05FHegwDTp2eSCzlZdr3UiH
         gA5g66c/VeQuMJnaBqhx1zOrl7FTOZKt/XtyRki/E12jFbqZb8uOrhJ9NedBgWX5V8QC
         fXSA==
X-Forwarded-Encrypted: i=1; AJvYcCUSp6XTUjbI/APjSAGVe3bA+EJIgWKsdizjM8d215wbmd05l4tGks4HkAXUmSU+vffROPy0lBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtxYHbp+oZGu11yNnyOZ9X4fhdfq6HOyt1UPr0HfUftDX3oW+
	8cp21MTxZDVJspSJzCdiSqXUKfBQCZgnZn8ZYhn0vP3pD9e/d/M4td28xoQ/SE+JwUI25STlg1S
	EC3RG3kiahcnWqPgOaf+dfD+2KrA51Rwo/6TbZw==
X-Gm-Gg: ASbGncsYUpS50h9h0UvDAx4+meMTaA+g7FyiEhYP9rB2GCYBKNtZ6bWBmJCrXWyPwHC
	WAcAdnH6Kz5wBaJytruQycy45vLzFnI2cSeZOLTSm72S3SPEvroEphQrcjl5J
X-Google-Smtp-Source: AGHT+IHvfYEqHD35f8UnLDugHPxFfBJiHJYV9810UXcLgYjqc2ISSIJrK1EXM5GwIAW4E5UPnf+3ZjJlrOLaI3o+G14=
X-Received: by 2002:a17:906:1baa:b0:aa5:cac:9571 with SMTP id
 a640c23a62f3a-aa580f4c51amr744110066b.28.1732867577853; Fri, 29 Nov 2024
 00:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com> <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
In-Reply-To: <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 29 Nov 2024 09:06:07 +0100
Message-ID: <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Alex Markuze <amarkuze@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> Pages are freed in `ceph_osdc_put_request`, trying to release them
> this way will end badly.

Is there anybody else who can explain this to me?
I believe Alex is wrong and my patch is correct, but maybe I'm missing
something.


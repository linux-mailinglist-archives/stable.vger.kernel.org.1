Return-Path: <stable+bounces-135198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37FA979BC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9381B63DF1
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEA22F758;
	Tue, 22 Apr 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0eyanCQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6172225402
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358674; cv=none; b=LzqKSg9uZooZM3FMYjKyknluG1xJkl2MNV9KiD8wSwZ2EcqdhK3ydRsyRQdWCya3+AEBXVrg2kjRiyJi+tHcATEKh4QiF6//OapxgEErvhBRsHVkglit26dlw+kLaxEl9eqpa/S1cXyb2y4OmiZkmp+YWocIDsnP5pZkrQZlgw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358674; c=relaxed/simple;
	bh=G1t682/Z5YQhVNZg2BBqTHLGZ0BD0DRxXvelvkk8FdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4licy/6B31G0y7SwnSQl2+Bb0B8n2qG+R4kRpGqMNhBHXdmCKIFwUU8oYrfHBwm3tzLczt7dAcrlL8MXB24Edphxd+od2brclLTJQBtnG//pdgYvEQZGKqqoM3V934SRYOjlw2i7aQsLw/Ir/GOm0834GgL0r3QM7ozg158dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0eyanCQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745358671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s1/IDzJNwKu9ird3fpx4gSzjCeLeBaq8w8B6OkdB/Zw=;
	b=M0eyanCQ44iTpWcijd7mZhx9YVSyLFr5hwqi0Wn9XTFUZFQKP5Zx0d94IfS6SciNS9X1Xm
	P8scUzAiLK0QJd4J06rdljMc+nb89C+8sTk12kBD58JHwDRkxJPQ7VFq3k7oGoOLtGRzIi
	wHf13MSofj0wnMDCW+ondO0T/Pu65wU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-L7daNg8rMEG4wKZVMwf_MA-1; Tue, 22 Apr 2025 17:51:01 -0400
X-MC-Unique: L7daNg8rMEG4wKZVMwf_MA-1
X-Mimecast-MFC-AGG-ID: L7daNg8rMEG4wKZVMwf_MA_1745358660
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913b2d355fso1669646f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745358659; x=1745963459;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1/IDzJNwKu9ird3fpx4gSzjCeLeBaq8w8B6OkdB/Zw=;
        b=Ja3c5ZWx+Fl8MsKIL+G4vLDEwFlY3O0LHkUz7vnguPfaNDcL1vc0spiK/m79RtN3PJ
         8+t+hG/5kwlBx5ShCSYjd077n6XfJ67F22Ypn92DkJ1C7Y+1kh8d5ZJJCshDPc3puSo1
         e6TabCkEYjYw5Utzpkor/nUBAwvfMpBMVp7fYRBQqBmvjYHj8VsFOxr3xTp9gwnIrzcu
         o5fhezCDeOHMmRaMXvcjmPniVrYawSdSftrMBzUCAwK/vA8iNk0OTxK50bJ0plXs/6wx
         Gws/m9YaH+ahoMuWC8COGNmvVW1bGLcePQRsOBCGPwCF8g1GUWlSze3eQyCPHiXKXFqk
         fcCA==
X-Forwarded-Encrypted: i=1; AJvYcCWS+r7rK7DhLAtNKdya+MQjgLH3UsZO1FNP7aDL7IusvfkxyRDFSdIrEbc9b82n8AxkA9Bmvgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2Q5wSHlNzs5SmfVIz63NNk+qgCX0UdOmC4M44cWOAhrJO5oT
	93jJEIqckB0Q9DuUtlm6rve43dBx8+hIioo9UQZqU6j6P0buDmVARo7Z5VjEMpk7HJS0ZZPfj2Q
	oNCpg/qfwYM5agmDz2jvftQT5T80VDDptmcCgS7LPmagF/t2oFBPzqUHQaTqOzQ==
X-Gm-Gg: ASbGncuMbvzmLb3x0hRwno9XKdCm2uQPkOoW5Y26E9ZwibjkdaJ9U4ViKbzZB6uoadk
	sUXUSN0LBa6HuGnXsKD2tb79jYP3dDi0JqpyeYWuFbw5p9HIFiThaansfhjBfbPPzcSpsjbVGGi
	7LPA9/M9zqisqmLlyUqXQpFos8rVP9XENeMekj7jlyYJZp0vVyPEofuax95xLzbUb5Lw+nlX/rf
	XyurqfvrB/erEc/qwyLgZI5b7yq3+SUGS4EiuKWSdAdZM3uSH6nOC7WTkGeCH6lmABL+04SUbBo
	FqHiftXKPYoDo3v30DpNexIWqsQmOdZkkvqt6B9js2HYrSVBE9v5ZS+OJLVLWaFMQeJ/Ag==
X-Received: by 2002:a05:6000:4310:b0:391:4189:d28d with SMTP id ffacd0b85a97d-39efba6c0d3mr11525094f8f.34.1745358659706;
        Tue, 22 Apr 2025 14:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQa7VnBYSPz5ieTPf8xaFFrtEIeqU3LTi5lgcJyNHMvngJBWDCobliaFl6EizYRrF/Sw9Ww==
X-Received: by 2002:a05:6000:4310:b0:391:4189:d28d with SMTP id ffacd0b85a97d-39efba6c0d3mr11525085f8f.34.1745358659393;
        Tue, 22 Apr 2025 14:50:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4d67sm16699401f8f.94.2025.04.22.14.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 14:50:58 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, iivanov@suse.de
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, "open list:PCI
 SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] video: screen_info: Update framebuffers behind PCI bridges
In-Reply-To: <527b7ebd-0a34-4fe0-82fb-9cdd6126e38e@suse.de>
References: <20250417072751.10125-1-tzimmermann@suse.de>
 <527b7ebd-0a34-4fe0-82fb-9cdd6126e38e@suse.de>
Date: Tue, 22 Apr 2025 23:50:57 +0200
Message-ID: <87ikmvc1by.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> cc'ing PCI devs
>
> Am 17.04.25 um 09:27 schrieb Thomas Zimmermann:
>> Apply bridge window offsets to screen_info framebuffers during
>> relocation. Fixes invalid access to I/O memory.
>>
>> Resources behind a PCI bridge can be located at a certain offset
>> in the kernel's I/O range. The framebuffer memory range stored in
>> screen_info refers to the offset as seen during boot (essentialy 0).
>> During boot up, the kernel may assign a different memory offset to
>> the bridge device and thereby relocating the framebuffer address of
>> the PCI graphics device as seen by the kernel. The information in
>> screen_info must be updated as well.
>>
>> The helper pcibios_bus_to_resource() performs the relocation of
>> the screen_info resource. The result now matches the I/O-memory
>> resource of the PCI graphics device. As before, we store away the
>> information necessary to update the information in screen_info.
>>
>> Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
>> EFI framebuffers") added the code for updating screen_info. It is
>> based on similar functionality that pre-existed in efifb. But efifb
>> did not handle bridges correctly, so the problem presumably exists
>> only on newer systems.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reported-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
>> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
>> Tested-by: Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
>> Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.9+
>> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat



Return-Path: <stable+bounces-203349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B74DCDAB5F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 22:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45D273004441
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E134313550;
	Tue, 23 Dec 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWhN2vwx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc4CxfUV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB58C311977
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 21:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526711; cv=none; b=mnn3mj9tUd9EbJx2WzevIboYKL+eRdmhvSRGlpVK73PzaXYWc9A8erY3s4PUQBZIuDbZ+DXHRKDn0CtoVYpoLrfaXhVe7QYD52YSUkAZr85zkAjwrV4AxyK4N2c1LfwtI9q8rOufEX+PuG1qA944J9wWNDpalmwaouHeGic8pWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526711; c=relaxed/simple;
	bh=cXthFECf7M+LNc4TyNVDwgQ997q3cl0n2gZfYwSKG+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLxJBBm0Rnx58Mej7Kw62sB4Md3qiQWbmCpO3YgKSkWrPfYaFyV4t0clLXWhOme6X7cFh4VIwFDwB3TSWheVWxKrohwD4A7UiFpgzgdxQ0K+I8BdgMj4tBn73lpqhuV46ECeyaWnoPhT9kqQIIEEmDkah0TifOVHCRPQbIJ0v5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WWhN2vwx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc4CxfUV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766526707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4yXAksJt5VhERsnm3173KkbdLg28LUkgCq4MTlnS5fI=;
	b=WWhN2vwxWweIvPX2SriQdF58AjqOD8fGdEqHZDPPYa0+KKnkMv4ImD2iRTZBzBSC1YHXCa
	7UgMQVeYKEbWYUObyBalITUuVr1OuV59+a2wPdHoI6TSgvXiFKY18Yz9z86PmXpUzg7NV3
	n0JIRwFTAMKgHrSxF6uC47yQ5VdSmhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-6iNb-95JPrGuXH1RVEcG_A-1; Tue, 23 Dec 2025 16:51:46 -0500
X-MC-Unique: 6iNb-95JPrGuXH1RVEcG_A-1
X-Mimecast-MFC-AGG-ID: 6iNb-95JPrGuXH1RVEcG_A_1766526705
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso39665045e9.3
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766526705; x=1767131505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yXAksJt5VhERsnm3173KkbdLg28LUkgCq4MTlnS5fI=;
        b=Zc4CxfUV7mnhIrMPeuLlVvlAUYeYOBMYEvJt6QJET6gEuthTWX2esKIYVxI4vnN+dt
         PjoH5iyyHLgfyOybzYs5DCfQZ+LhKczfZoxWwTxMgAUKiidMhS47HgPLR7YhcjBorq7Q
         J90FwhypngmPVIRN4i5TdjOqbNHSZgX4RF2eC+6r2zFN/J5Z+8bsevIMKMlG/pYSQJh+
         4rVDclquJdEdBoZg6JwXoiS2evEIDw7Nx4+Yx6oZwiNM6n7jkPDfXmFUybdqB9MLni8/
         XM5QXVSF10KoYtBfjs6zC28zeQHvBlp9iGIdP3cC46O1yAdhRX5ryBJRD61MAwynvV31
         uXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766526705; x=1767131505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yXAksJt5VhERsnm3173KkbdLg28LUkgCq4MTlnS5fI=;
        b=AOHGyivC7qp6rW0bpfFLLmNkOCgP+lb9QYM3Z8jifm3rjnii6Tn5ejaGATvcxsOjZs
         Q91jOsuOsNpfw7jteqVO1pOCg9Nv1yuBNQbcrTftXPC8xijewLsAhWrdyJjlpGEQVyEh
         CCleHCFpX4VCe84JDf1A20AZSAAirHOImllPtUqHOEoY8YmA6tDzm9//RVRLpb24KJxD
         KkEoCmSA/1hTwXbsrsy21Fm1HQa2lMSDwgzUSSDTzRMlc21qeq4fQHKafGma30rt8Nqc
         8u4XtyrBUTZxFRj1YGh7JDLeZff0Le3XeHUOlJ02m5yvbQ/zcxm8LcnuNze5kDxF1zBA
         SdLg==
X-Gm-Message-State: AOJu0YyAAqAYC0eFwDaJYSzOb41FGnDbTMJP/3HyROU2jwzmRWpkwowc
	oLLK1mDztdski7f99B3yeraNEuZLtAPqa7TW5BwvsI9lC124fmH1ne7/beq6X3zTQyIM2dh88CA
	A5mUjcOfF+0g7/zTLjG9e6zQcLqMoaVVXFJNYtpbadlzGaZM56hlghugT2w==
X-Gm-Gg: AY/fxX6anRoAayrPH2yD2otID49VsYDZcv9aSBil58mOWM9mxJDYyy837eUbwtWZq+4
	dYBePqSol63QVDncxGLYV97KoGXyb3zCpq7W3zDjFHdB5u2TB36X49pDZ7rjbrpHOKbEFt2ptuI
	Zftemr+YFCoqDshX7UdR5B1izyUxzMwlNBHFEaL5qAEEGO4DHx1KrOfQIlbAyC+ZuH9ujKRikrG
	tTmROlqwx4AwsS7xIgj789ihl82Ea6NaZiNYP7wL7E4iehe/zMciHcFByhqJp3e6RiClDUt89bH
	VkhT8dUfuPIGkmasfo+BnFPt0jB4fCeLs2SkFnM1kZ8Ef/uw0IahBHQMVsOx989ewQNHWJrcxh/
	o9K+vzUT/AqWKq5yZWWV+TBJpxWp5JzgVow==
X-Received: by 2002:a05:600c:46d1:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-47d1959d6a0mr155122285e9.35.1766526704890;
        Tue, 23 Dec 2025 13:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/v6UvGcz7cXLMbidc+dzXXEfdNJhnFZc3RSCYTM4ESPNS3/tqnOw9OV8rDCMJJSPHCNYfvQ==
X-Received: by 2002:a05:600c:46d1:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-47d1959d6a0mr155122155e9.35.1766526704446;
        Tue, 23 Dec 2025 13:51:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c637sm298058315e9.11.2025.12.23.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:51:43 -0800 (PST)
Date: Tue, 23 Dec 2025 16:51:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Daniel Verkamp <dverkamp@chromium.org>, Amit Shah <amit@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
Message-ID: <20251223165135-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
 <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b905018d5ac8a852759e8483ccf8d396eac4380b.camel@gmail.com>

On Tue, Dec 23, 2025 at 10:36:48PM +0100, Filip Hejsek wrote:
> Hi,
> 
> I would like to once again request backporting 5326ab737a47
> ("virtio_console: fix order of fields cols and rows") to LTS kernels
> (6.12.x, 6.6.x, 6.1.x, 5.15.x and 5.10.x). The patch fixes a
> discrepancy between the Virtio spec and the Linux implementation.
> 
> Previously, we were considering changing the spec instead, however, a
> decision has been made [1] to keep the spec and backport the kernel
> fix.
> 
> [1]: https://lore.kernel.org/virtio-comment/20251013035826-mutt-send-email-mst@kernel.org/
> 
> Thanks,
> Filip Hejsek


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> > Hi,
> > 
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> > 
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> > 
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> > 
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> > 
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.com/
> > 
> > Thanks,
> > Filip Hejsek



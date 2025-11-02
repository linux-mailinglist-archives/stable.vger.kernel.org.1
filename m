Return-Path: <stable+bounces-192083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EABEC29601
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 20:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64E83A4935
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 19:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734841F75A6;
	Sun,  2 Nov 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APQpyu6J"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0DC34D396
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762111950; cv=none; b=DJS8vS2VS2iI+ocY6m6v11ajuOUh/npjv3QW4kU+cPM4d4PQzWjNoNRIqggA2O2GT9E7a9WNUhU4oFOumb6X25xXmOkum6hLrL+Mf9TEaGlAQSvmN5koenWXzJPopQi49HhaQzUHpnBLaTE88wBPmExtRl2FN4m2BdsF2Te7E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762111950; c=relaxed/simple;
	bh=whjSaAoEidsCbRgS6I4kk5cKqtik1ZyQAhPwzT4v7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9dkw42U3clof5iQbTCNttWHp0lc2M+tVZ2S+dbfbqhtbFj0ZEGAsM/jNhxfKSyeaKsC+iOiMlN8LImLSOWTZrXl0XQh43UsHcpjRD9jaGvUcpD8KK12/01y5vpAw+ZsHjY2IINjD7Wz+PZ1c2bqati0NJ2UNzKEdMNZ9zLt3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APQpyu6J; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso17414795e9.0
        for <stable@vger.kernel.org>; Sun, 02 Nov 2025 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762111946; x=1762716746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eMU8pok1gsabfyo+tR79iwjRZxKmugJef8B2DtU1Jo=;
        b=APQpyu6JaQ+LBl7jAzSynCmEcUaVNqsjFYaMtwvqmtYQwYWfG6QP1A67PEvv44eok6
         w6v7eodpQGW87wV0aNqDE1EwjAdmLfo+ckkgHdNaYe6k0BoS55wc+ZglUVxRWunVDr/R
         /Wij7gpbh1imWdN/VovQkk5QMDyWAnZ2N4mkVVij/EK4bjD1WPpXxU5jT2WfD2svqBNi
         lddVxAHxxBHWeQ/UN+cT/pHwpDLfhhplBgGfBcN0/MD8t8UQ+FEeJrJLUWpMwoL89XdD
         WiXdJNDVyNXkZ9D93lOojgKWCQjBlHejh3botR9aQWhdincOHISOv394lT/dZiC9IXEY
         I7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762111946; x=1762716746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eMU8pok1gsabfyo+tR79iwjRZxKmugJef8B2DtU1Jo=;
        b=K2zZ4q/fF1t2lKUfgYtKsTA8/xQKVMDZER9D05Z2HvYgE4osc4IZq6Xn7qLs6T4jfy
         2ugs5RWGYoHPPpefKq+Ahd7Cc1XM8X6FZopP4MdyV92mkDdi93nQDlGlVyac0F6PKIA+
         KL3ecWuEVrrAz6SVM3zsEGzMi6XQiKPXY2zQlVhG+HBbluD3rRdJWGZ2aNzSKlmuDR36
         UCRqKBXe71SZWV3pseP7Hn8axhRoCFRYxWME25Y5PSf38idt1r7f4FklUdf2LJgpvd5/
         4KwafjsLqqHSY2h/Hs8F37oDODAFMmwt1Fv/bM/onKQPcSeDFCijZCJooOi7YPJhGIVN
         R8TQ==
X-Gm-Message-State: AOJu0YzfUlsBz7cYriYzvSCA89LYn584XMENgYdyB1lQhhFlSCani0ub
	zsnmszg+H5BESG2hRx+tTzkEm9ghNdaaS3B4gBVz9rJKFtD7c6VKNL9S
X-Gm-Gg: ASbGncsIksG6uZt9npvF8xAjghhUmpmPkkDSqBrBTXRAnuXXPeOSXkdQQTdgIhWI2VE
	CnO/2cvKf/LHjOc2DyxPusiErXHtms7BwNBsV2G63/KuAGVypjt1CyGOHiw3VlJqCOtsgVsFkSl
	qwORuCWUJ2voOAOCeBvZEXs4+PqbH28oKcF0sAMaPncYECPxQxict9kgMoNYl+2f8Yn9DuURSRW
	Y9MRZN5PAWunKT6LXbME5hnSVW/w6a+wOB1o44KowZX1bGlr6+IY8X+DO7kRhTj58sV+YAIrajQ
	gsWMuk0vEKTX2P3fnzQx+uafNWb38qllotk3ZooDDH7xn7qCDFYYZWz+AFjxLh4EtA0PgevHyE7
	0H6kPoGOqfn37zwP9YKyA90d9BI1UzQhJcrOIAxqBASaCeQnLfO2lb3fy4GfrzuTbZYJVtBzowU
	E4fy1MmuKbODP/cNf68Q424lFrif5qtT4Bug==
X-Google-Smtp-Source: AGHT+IF5SP0ccIt4MvydGShzSzqAzCg1KkGermAxVJoCXmKeDaQsnLv+TZBc3g5LnA1ZDOdJfqprCw==
X-Received: by 2002:a05:600c:b8d:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-47730893602mr121858655e9.34.1762111946265;
        Sun, 02 Nov 2025 11:32:26 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429cdf42104sm5780115f8f.3.2025.11.02.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:32:25 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 617D8BE2EE7; Sun, 02 Nov 2025 20:32:24 +0100 (CET)
Date: Sun, 2 Nov 2025 20:32:24 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: Missing backport of 3c591faadd8a ("Reapply "Revert
 drm/amd/display: Enable Freesync Video Mode by default"") in 6.1.y stable
 series?
Message-ID: <aQexyJCsE1Mx5Z05@eldamar.lan>
References: <aQEW4d5rPTGgSFFR@eldamar.lan>
 <BL1PR12MB5144C73B441AAC82055D9A6EF7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144C73B441AAC82055D9A6EF7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>

Hi Alex

On Wed, Oct 29, 2025 at 09:47:35PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> On Behalf Of
> > Salvatore Bonaccorso
> > Sent: Tuesday, October 28, 2025 3:18 PM
> > To: stable <stable@vger.kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Sasha Levin
> > <sashal@kernel.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> > Hamza Mahfooz <hamza.mahfooz@amd.com>
> > Subject: Missing backport of 3c591faadd8a ("Reapply "Revert drm/amd/display:
> > Enable Freesync Video Mode by default"") in 6.1.y stable series?
> >
> > Hi
> >
> > We got in Debian a request to backport 3c591faadd8a ("Reapply "Revert
> > drm/amd/display: Enable Freesync Video Mode by default"") for the kernel in Debian
> > bookworm, based on 6.1.y stable series.
> >
> > https://bugs.debian.org/1119232
> >
> > While looking at he request, I noticed that the series of commits had a bit of a
> > convuluted history.  AFAICT the story began with:
> >
> > de05abe6b9d0 ("drm/amd/display: Enable Freesync Video Mode by default"), this
> > landed in 5.18-rc1 (and backported to v6.1.5, v6.0.19).
> >
> > This was then reverted with 4243c84aa082 ("Revert "drm/amd/display:
> > Enable Freesync Video Mode by default""), which landed in v6.3-rc1 (and in turn
> > was backported to v6.1.53).
> >
> > So far we are in sync.
> >
> > The above was then reverted again, via 11b92df8a2f7 ("Revert "Revert
> > drm/amd/display: Enable Freesync Video Mode by default"") applied in
> > v6.5-rc1 and as well backported to v6.1.53 (so still in sync).
> >
> > Now comes were we are diverging: 3c591faadd8a ("Reapply "Revert
> > drm/amd/display: Enable Freesync Video Mode by default"") got applied later on,
> > landing in v6.9-rc1 but *not* in 6.1.y anymore.
> >
> > I suspect this one was not applied to 6.1.y because in meanwhile there was a
> > conflict to cherry-pick it cleanly due to context changes due to
> > 3e094a287526 ("drm/amd/display: Use drm_connector in create_stream_for_sink").
> >
> > If this is correct, then the 6.1.y series can be brough in sync with cherry-picking the
> > commit and adjust the context around the change.
> > I'm attaching the proposed change.
> >
> > Alex in particular, does that make sense?
> 
> Yes, that makes sense to me.

Thanks for the confirmation. Greg, Sasha so can this be picked up as
well for 6.1.y? The patch was attached in previous message, but I can
resubmit it if needed.

*But* the patch submission is solely based on the above and on the
request from https://bugs.debian.org/1119232 . I was not able to
verify myself the underlying issue. So I really appreciate the input
from Alex here and would prefer an explicit ack from him.

Regards,
Salvatore


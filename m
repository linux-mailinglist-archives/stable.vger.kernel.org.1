Return-Path: <stable+bounces-188249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C86BF37B4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8FD3AA38C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0D2DFA27;
	Mon, 20 Oct 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QfhJaCCR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE382D9482
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993047; cv=none; b=e1fXRKxa21dUcK/aWkT62EdxAl9xx2Zk9kIaER1XFh4SAWA3OWlNf8Ho7kmI5KSWnNapsK+08K0UypfaqcqMul9uM/fGywHDoo2omL+FpPtLzUnE3TEJ7t3XocHMftcoKXYDtFnC0uA9JxKzR+/0xIJ4bk4aMy78DGHtjlIEnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993047; c=relaxed/simple;
	bh=xopflpZWhKJFTA8H58JlhKFnEKOMqUn2HHt+Xg1Nc9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKwz+WiVn5X7t6+pgD9k03nJs9NLRvKm7EGy4PYjRNCGU9hi7sxFKl5raIMK1iZTCyLjS6JICnWRwSvmAwidjJasJ4EG8jzAas1UB77Kt3dRW2tRDx2n91cCCG1RvzQNsNXbMcKjk25cf8ym8LXghZ7csQ/4HkUKmV0ujq0GDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QfhJaCCR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781997d195aso3652377b3a.3
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760993044; x=1761597844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rs52wMSr0IxAxfkT+9Uj3x90FILAmQEMsLFMmIwcHAQ=;
        b=QfhJaCCRRvXnepZzFtjb31gDLCEmeCW1gwA9ox79FIqqe6gcr7y6TfstV+HKIHgup6
         W7yx9gL47OolkMGB0PdD04N/Z3raFOWqPnh7NgyGxh1H6yb6Bc8OIuA9zgWf0CQ+LZom
         w1Of+EM44un3mD4B+P23ehKQCMFbWGBuKMk6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760993044; x=1761597844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs52wMSr0IxAxfkT+9Uj3x90FILAmQEMsLFMmIwcHAQ=;
        b=GoUctClQBXBD0lZNOUYTDM0iZmdFNghRTMyaiVhbE6aMS8M21cvxqA4UqU2PV+P4Ti
         k9+6OcEiFqG4K6Wdo6K5jv8TDaLOcXTX2n2FOv92NGFpsblPGUK8ZE83f+5nt4yT6Ml7
         EZ2BIkV6LFYoDgYHxaOcDa8bsTMkDdrO2scAzWbkLEZDeAUKkBMdYwylB7xRy5qog/Vt
         3p/P0SQzNfPT8ucwBI68jU0510wnwvzHZarXqXoLiNCIXXsqCtx8EMiJTKnmjF12ijId
         KzSu6gjS9WNJlvs4XA5kHA4D4j8XHzwh03KOLjO1VGVlWCp7t4BknXPbwRTt5fPKI+jn
         w04w==
X-Forwarded-Encrypted: i=1; AJvYcCXKBwr6aA7XdpdFatA/4hnC5E9ir6efcmnIv3k0XgXzJdj6XHbHX+Bu2aae75lUqRCulVkvy/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzppDNbUfpXtTV2j4VWeAbl/o2W46/KVTCboQY/CayLFkKqChhT
	rjop1w4vX/6AVmfLhLrQbI/O8ndgGq6HLI3H7yGE88XJWVODNS1S/6bwqFdOzI4d8g==
X-Gm-Gg: ASbGncuLtZUJI7XPKofV4fFp/JXnmxhBza0mKXNsQ5sRm4vsxJ7Ee7XfF8rIkRciWk4
	Vj/XFPCVtVaroMiNnX0il5RH0V/5Epi8DIwCSVAa1iDUL35xXWM/+aRb0ctGSzfcxtHRxB0mSLU
	095McC3aCTyxkaU0A3/jaLxCq4OhZF8MAiGqgWpaEsW/SEymr/BQPyKaE2mFql6fmv7ALRoTklk
	u5oG6SCOSS0Q5Q7zYo+yQgVofPYGaUGDkIM8iVcnuInJeKTpPR4KRy5Hq0z3RydTc9sRDGfB4TU
	is2seAPq4knw/fhKr0xhdYHAntOwviB6QY/401waVZWZ1awtymzmfftDSVy7bde/kuEXghjK4lU
	1IPi7fRhBoV/yIsyHEI7/eCFQ3qKKRMkPAPpDwHDkz3BB4cufgbKwYQNimA8OGFnE7/mJW1fl6E
	b03Yiw0nOclJmIjt6ZsSyS7m1pQ2wxz/c5PG1fTQX25nG1rrY=
X-Google-Smtp-Source: AGHT+IEKl+dNV8DBbcUa8x7wahj8/3MoAZY0anClQC6T73QvDEO3Ag0bvciFHf56ksA/cDfQgxUC3A==
X-Received: by 2002:a05:6a00:2182:b0:781:1e08:4459 with SMTP id d2e1a72fcca58-7a220ab550bmr19946152b3a.18.1760993044231;
        Mon, 20 Oct 2025 13:44:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f21:3ecc:2915:f4cb])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a22ff15985sm9465045b3a.5.2025.10.20.13.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:44:03 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:44:02 -0700
From: Brian Norris <briannorris@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "PCI/sysfs: Ensure devices are powered for config reads"
 has been added to the 6.6-stable tree
Message-ID: <aPafEhXHnbLp_esg@google.com>
References: <2025101627-purifier-crewless-0d52@gregkh>
 <aPEMIreBYZ7yk3cm@google.com>
 <2025101714-headstand-wasp-855c@gregkh>
 <aPKB8V3NTeqcXCzu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPKB8V3NTeqcXCzu@google.com>

On Fri, Oct 17, 2025 at 10:50:43AM -0700, Brian Norris wrote:
> On Fri, Oct 17, 2025 at 08:58:20AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 16, 2025 at 08:15:46AM -0700, Brian Norris wrote:
> > > If adapting this change to pre-commit-d2bd39c0456b is better, I can
> > > submit an updated version here.
> > > 
> > > Without commit d2bd39c0456b, it just means that the 'max_link_speed'
> > > sysfs attribute is still susceptible to accessing a powered-down
> > > device/link. We're in no worse state than we were without this patch.
> > > And frankly, people are not likely to notice if they haven't already,
> > > since I'd guess most systems don't suspend devices this aggressively.
> > 
> > I'll gladly accept a fixed up patch for this, thanks.
> 
> I'll try to get that out today.

I didn't make time on Friday, and this patch was committed to 6.6.y
already. So I've submitted a "part 2" here:

Subject: [PATCH 6.6] PCI/sysfs: Ensure devices are powered for config reads (part 2)
https://lore.kernel.org/all/20251020204146.3193844-1-briannorris@chromium.org/

Brian


Return-Path: <stable+bounces-185908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0BBE23FA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AF63ABE09
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5E2E3AF5;
	Thu, 16 Oct 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJ7d+M64"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B75214A79
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605063; cv=none; b=FOkTJ9x8KRRHouZDJv4SHsNHNVY5LO19QvAEhRYoQLtJVzRjusVxXQNYoc+AciM44Jgrdr0j0eDP2WwnswqVoiqi+vtuknI/aSmqsACbc+5065quMZt92GbfWa2vag6oVdwZsPF5WmV4s/HrE456kEnTRKhKeFOtIIbSjR6iQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605063; c=relaxed/simple;
	bh=UZBHg8z1graxYq2jP0wH9Ynql08UCvk+brPCiW2Z7YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzjYK9iTvKdM4O4JmCY69sUszY42DeKGiGcBImKCMpKhNAYJ1VJPWdfJ26xtWt74YuvpVY/UToUS37EOFV2pEL2IWmzA4J2ri11VML0/99JOaVHq4y1LYF3FshMQWvHieO8j8JpTox7XinruB33w1wVgwTnt2oUqZaG1ohTU77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZJ7d+M64; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a02316bso375308b3a.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760605061; x=1761209861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3+9L/n/wF5eWVrlWgh0Rnj/Ofh6DOYI0vHxbYgNhEM=;
        b=ZJ7d+M64aSJiKcry9xOoM5jX6K9FfQc0fBJlfzL0RFrveOPyKmIbEwNwL8syz+sVpz
         n9LdWdOySXy719mevxzpnZinh6SR9gF957y4qeg6HLyGPJV1M3/gerGG6YR/WuQNwFAe
         fhCRdDjbzJBSZqPQSKbz9HgFTnMS3wf7TZ7ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605061; x=1761209861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3+9L/n/wF5eWVrlWgh0Rnj/Ofh6DOYI0vHxbYgNhEM=;
        b=e+vwh73YNcVvY/tUdEMGGJk5t5ieekA0PZFT+cP9c1rPhlRiQIbDns+B5rsdC2Lzut
         US4Ljve9VwjwU0ZtRQKN1FYFVZOTQkKnHP6X8F7td73ZAKi96g8r1lpbNLbHv8ZtgvXp
         ljJw5PzwWJAxab/ST21KlaXVIz29z3AMWGfD3efhZUDRayYV+2cj8jld4QHiY+ow1F/V
         MhlKRa4b5meN3dZKpXgt+Lz5S6F63AQJ5bLHo2m4C/pker0UUaWIg3ZeuA3lXkmh3adg
         RV9+nugtbQN1i1X+PSkRILK0zAe4aAfbj7efogC/YMOxAixzwh4RcBz7KWV1ikxzaWgn
         Sktg==
X-Forwarded-Encrypted: i=1; AJvYcCWWYXsy928D1Ns+V16U/QYXDiTlxUDkcEd8y90o9J6tP41MJGAaRFiX+c4RdIJfYRH+IEj4Qp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsn3YmV3Zafe5Awb5K65a41Fuq6Qs7IqGi4REn6m/qjaM8+DZ
	d/tbQnZtjgfiBSoGUYbO3IXVAgapHwufhPXLNMp5b5yEBJqvDTEnwbqMu4abuFs+jQ==
X-Gm-Gg: ASbGnctki3GAgpgUWGz/eAjvsgfo8TDkakalO87NcIJReVhK9A38+C516SCjp/Fcx6t
	VaitvowoRyMOuFs7Kdo7dkKArUWOCWvTzdvsuJiCXk9TfD+PK8/X0H5NBP+NGxSiK8jDXhaC4t4
	jfrEK45Cs685Zwh4XMseo6YY2WLlsiKoahCZWtoWRZT0PFYTgp1j3USijKngxE6kyJDBM876r9D
	XUWvnlWM2rh4smBrlvnSpePGVU5RFX00duiA6H6Jimh4Od3Nmtq6i88GoMJ9NU3ylVx+H9TQ12u
	UaOMBJbFm4DKmwx9EtLaXGhC/rZwhDrGMf85cDfx0342QSsJrS3OhKZDuljhHQJkGGudKiiLFHu
	OJIiA74B5BFQnyJDDDqmfGQcchW9/c67bztaJU0xwzqHBwVSk+HxSYKEfS2fHek6irH8pP+Sa38
	HyRnI=
X-Google-Smtp-Source: AGHT+IG4hmHpB6yqAJU7qJCsXOzla5nYCqrST/iLfELMlqAHCV17Rzruzv/yAVg8QPwwbWdf9aQb9g==
X-Received: by 2002:a17:902:dac6:b0:290:91d2:9304 with SMTP id d9443c01a7336-29091d29fa6mr38523475ad.4.1760605061481;
        Thu, 16 Oct 2025 01:57:41 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aba062sm22231145ad.98.2025.10.16.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:57:41 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:57:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Christian Loehle <christian.loehle@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
Message-ID: <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
 <2025101614-shown-handbag-58e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101614-shown-handbag-58e3@gregkh>

On (25/10/16 10:55), Greg KH wrote:
> On Tue, Oct 14, 2025 at 10:03:00PM +0900, Sergey Senozhatsky wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > 
> > [ Upstream commit fa3fa55de0d6177fdcaf6fc254f13cc8f33c3eed ]
> > 
> > Marc has reported that commit 85975daeaa4d ("cpuidle: menu: Avoid
> > discarding useful information") caused the number of wakeup interrupts
> > to increase on an idle system [1], which was not expected to happen
> > after merely allowing shallower idle states to be selected by the
> > governor in some cases.
> > 
> > However, on the system in question, all of the idle states deeper than
> > WFI are rejected by the driver due to a firmware issue [2].  This causes
> > the governor to only consider the recent interval duriation data
> > corresponding to attempts to enter WFI that are successful and the
> > recent invervals table is filled with values lower than the scheduler
> > tick period.  Consequently, the governor predicts an idle duration
> > below the scheduler tick period length and avoids stopping the tick
> > more often which leads to the observed symptom.
> > 
> > Address it by modifying the governor to update the recent intervals
> > table also when entering the previously selected idle state fails, so
> > it knows that the short idle intervals might have been the minority
> > had the selected idle states been actually entered every time.
> > 
> > Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful information")
> > Link: https://lore.kernel.org/linux-pm/86o6sv6n94.wl-maz@kernel.org/ [1]
> > Link: https://lore.kernel.org/linux-pm/7ffcb716-9a1b-48c2-aaa4-469d0df7c792@arm.com/ [2]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> > Tested-by: Marc Zyngier <maz@kernel.org>
> > Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> > Link: https://patch.msgid.link/2793874.mvXUDI8C0e@rafael.j.wysocki
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > (cherry picked from commit 7337a6356dffc93194af24ee31023b3578661a5b)
> 
> You forgot to sign off on this :(

Oh,
Greg, do you want me to resend or can you just add SoB?


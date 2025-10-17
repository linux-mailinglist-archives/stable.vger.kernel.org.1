Return-Path: <stable+bounces-187688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CADBEB1EA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270527414EE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C632E120;
	Fri, 17 Oct 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZAPHnWd4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892332C946
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723446; cv=none; b=JDSJGEaKxgCQfXldYCd3qLlGG4r6uTk3B7qiflfLAvyHulBFktL2nT/lzCDrG4ohLPJc042lyP+6OUvLTpPXRGlh4d2Beq7zRzWoMA4BcT2AMAdBuFVLf/+sHU9eS9dHJtFZIvG4p/PYHwTWI2GLS1UXnNxIl1fobgwqN85sTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723446; c=relaxed/simple;
	bh=SJP1YCWSXXzf4Z/h1GlnuOQL8JzomhU4Nc9/6KcfwQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKT5TiW0iH+9DMlQDz48zt+fyUG1Nm7L/PbItjdxoa6BxtXZw5yr9zb2luS9is8Ou/x4NzlivC9wXWXFe9tq0NHM6FYYA7QnVQfUQ+oH/I50mAw9h9rb3kXaNzqZV/FBQINNvTYAiIyO7lhzO7yO235bH/OzQeVe8DtHth1eoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZAPHnWd4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso1872875a91.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760723444; x=1761328244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XD640DxTKiPNBRsAPq9AK/pOEYwrCD7AoX1xVxKkqw=;
        b=ZAPHnWd4gOW1gFMG48ir/HVK2kEWWozEGeNJULlNq/qGKMdhQv+NDxFgwS9tKdS+oj
         LlcRgYyDHPEZRNNAXGf+/CeZiaJ7ImX4V3QtMg40wH2xmvEEY4DN3Acxw/QAmFlg4DC2
         +N8pvBC11Vys3THQLl5FUosupP9FDcT7DL+x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723444; x=1761328244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XD640DxTKiPNBRsAPq9AK/pOEYwrCD7AoX1xVxKkqw=;
        b=cNgAKHj06QTnw7Y3ckL6xbNYNw0dhb10BUkorVCR0P/73iNiTWF0chyHw6XuEWMIdR
         QNZKTCD8M+/VyaScXbMjtToDCf9CrCwENxrnT354e4e3l31gY29mMBlYK1Ovn/n3DJjX
         Yy2T5S72i2U3l8fKKWr1tr3dPBtM5c6RgXpHerakWRu6hXwxWxHFYU6iI7YVmxHuKnEa
         M1rlLZnW8XxtBtNcC9MOhb1jO3nLzr8+2NF+BiYWlLRs/Uos9JxWryqxwVuf4kIZaFMF
         3JCJ4kjwKnXjcVml3Jc3CwWJY7Op/wUpZdH98YNK2x4pEgT2Q8n+I7y5B/X7CzKtKqI6
         Tsvw==
X-Forwarded-Encrypted: i=1; AJvYcCVWD+BSdUmRadnFmV7yu7p37KBvNrarhvp5uV1w2ex61U31W7xGC58qRAwobZJmBDcwhhydBL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmBc//AAi+lXbTq8QM/zP/+LugX54hQqYuE1JJXgtRZsrBfoa
	baFmgHo9ntOphA4AD4kceBFejfFJSeuUWYD8t2QvXMUEvokoqdwmOgRl+YjTTzhkag==
X-Gm-Gg: ASbGncthsB7/HCrQsCqpPoCYtF4NY9oFYrT/aP22i3wuMuYTtIk1hNlDdl6OVgm6o3M
	uJJpKDH5ErlfdOAFu9BYkr765rQGz6RfpdxZU3PWKqDDHtaMMrQ/NdLTdAHChH49osJvLzD0fRn
	CcFeBjaSLPW0DX8PmniuQKYDa9UpKf8SV71lkTa2/RFVcS0WPhvKO4BptSEW2nzwzQbBStvt8hm
	8kCVlLIbnU6LdI8pVtl4hGxam8JhFFX/78uQJlYHlBcyeDS/Kt11m7xMOJ1uapV/hTGd+T4u+t0
	7IYgTfsDbLJB6+oBZlv7SqEa9adfBUBkMikgtFG3TYcT6bFnUigWmogNCrWel9Rcd7uGxbZaSrj
	/q9dZ9C0sslgGfNMgqoauxXbLtwVeS8PMpWQ3uz4IWXyN8+ZxGsXwc5EMTlL0bzrvHEEhCkkJHp
	F4zG7x2n0ihE7bBJdngPDqL0YIW5fIFWV9HnDd6dlUFkmK+b8z
X-Google-Smtp-Source: AGHT+IHicqVI41EMdc2ZuygODTrSQLzn6ilI+Sc+7dwpCsebduD1/Pn0+4CjFmoXk5NI0oU5iuuHdA==
X-Received: by 2002:a17:90b:3c42:b0:33b:ae28:5eae with SMTP id 98e67ed59e1d1-33bcf87ac11mr4992320a91.14.1760723443658;
        Fri, 17 Oct 2025 10:50:43 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5ca9:a8d0:7547:32c6])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33bb66c5cf0sm6268435a91.21.2025.10.17.10.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 10:50:43 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:50:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "PCI/sysfs: Ensure devices are powered for config reads"
 has been added to the 6.6-stable tree
Message-ID: <aPKB8V3NTeqcXCzu@google.com>
References: <2025101627-purifier-crewless-0d52@gregkh>
 <aPEMIreBYZ7yk3cm@google.com>
 <2025101714-headstand-wasp-855c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101714-headstand-wasp-855c@gregkh>

Hi Greg,

On Fri, Oct 17, 2025 at 08:58:20AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 16, 2025 at 08:15:46AM -0700, Brian Norris wrote:
> > Hi,
> > 
> > On Thu, Oct 16, 2025 at 03:09:27PM +0200, Greg Kroah-Hartman wrote:
> > > 
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     PCI/sysfs: Ensure devices are powered for config reads
> > > 
> > > to the 6.6-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      pci-sysfs-ensure-devices-are-powered-for-config-reads.patch
> > > and it can be found in the queue-6.6 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Adding to the stable tree is good IMO, but one note about exactly how to
> > do so below:
> > 
> > > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > > rest of the similar sysfs attributes.
> > > 
> > > Notably, "max_link_speed" does not access config registers; it returns a
> > > cached value since d2bd39c0456b ("PCI: Store all PCIe Supported Link
> > > Speeds").
> > 
> > ^^ This note about commit d2bd39c0456b was specifically to provide hints
> > about backporting. Without commit d2bd39c0456b, the solution is somewhat
> > incomplete. We should either backport commit d2bd39c0456b as well, or we
> > should adapt the change to add pci_config_pm_runtime_{get,put}() in
> > max_link_speed_show() too.
> 
> I missed that "hint", you need to make it bindingly obvious as I churn
> through the giant "-rc1 merge dump" very quickly as obviously those are
> changes that were not serious enough to make it into -final :)

Oh, no, I didn't mean to imply you "missed" anything. It was more of a
self-help comment, so I could refer to it when following up here.
Otherwise, I also might not trivially remember which commit was
involved. And I didn't know at the time how many branches would contain
commit d2bd39c0456b.

Sorry if my wording was a bit off.

> > Commit d2bd39c0456b was already ported to 6.12.y, but seemingly no
> > further.
> > 
> > If adapting this change to pre-commit-d2bd39c0456b is better, I can
> > submit an updated version here.
> > 
> > Without commit d2bd39c0456b, it just means that the 'max_link_speed'
> > sysfs attribute is still susceptible to accessing a powered-down
> > device/link. We're in no worse state than we were without this patch.
> > And frankly, people are not likely to notice if they haven't already,
> > since I'd guess most systems don't suspend devices this aggressively.
> 
> I'll gladly accept a fixed up patch for this, thanks.

I'll try to get that out today.

Brian


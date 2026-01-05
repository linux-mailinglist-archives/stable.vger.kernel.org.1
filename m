Return-Path: <stable+bounces-204806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43410CF4311
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B38B3063DAB
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF7346ADB;
	Mon,  5 Jan 2026 14:11:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA40346AC5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622291; cv=none; b=M0G6xNtI9zH78vXY/rrzym5HlMh3qK873RhA0JRZCEzarVENW8ZMKtZEGD8i8KFLSSo81Z+Cnaf+NxOzPCZ51W28/ovzdzJ0PJdxM6XjXbTwLdwWyNUDcaXj3sMbVH4SuNQ/w+KxsH/rWRhexNRFyeIargsrZkrEkhzcn3CyCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622291; c=relaxed/simple;
	bh=HN2CkVPM1eN6Kh9bWCQdL1MiYXNKTJ3dLqrwp7UfePw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMvF0cUIp/7TtLjDVbIbWBmq6Iv/cKb/ocPFEMAaFMCw7BY4CnvysyoUlST/eLHxHo/KQIZNB4ppWeZ6zHlg0qKc7TPh5Og8Mzhq/tKkKKO8wzeCRDnKFJ7JHgLgPqb+NqQC2K0TAu5F1+MCaYMu6reBQCzjLtwsbW5DuqLxtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c7660192b0so9653116a34.0
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 06:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622288; x=1768227088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HN2CkVPM1eN6Kh9bWCQdL1MiYXNKTJ3dLqrwp7UfePw=;
        b=Xz0TUj9NoW8RuZWanMrKvJKIlpnxckzFrd07zXcosHBWv/Ya44LhTDyzolOia/bzVv
         4cx4Mn5MVbn9wTrsLAjqYwD/XEuzVrPd55tTWyewFXhm6nlXuz+L7XRGVI+REbOty4Db
         ZUWblkw0ugWXFesjCgoia8+AuokO9vL1xn1KYYDtKW2mB1GeuvWB1zBHsBcD8kpbs6dY
         CSjUTpS+JRukHKkuQy1ow6XsWfWNQFJbGTDU3F37gseM64I2Ng3/MdwqGod+J6G1sFhI
         +6L199fj4qer/PWjZsFudnEC3lsKUFr+2YsyQIlcFAqyeNpCfl40MkfjMFa/MZkOywto
         KLjw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0tgo9h21qLonkJR9P1OGeeZQ1NsVH61C7KRvs5OwL7g4Ss2urXmSaUtn184Rx0+Z/5uX8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFQcl3rLu6eYAKVbaU3aM8GYGY/ifm5rDAnbApZ0Wi27eC4it
	70pX3r7cWClNfbqrOt2WHjT9mGzQDS3KUHRL9vt8ndkOiwWhmz2PTIKl
X-Gm-Gg: AY/fxX7Sr7X+CdMV3przsZz8PrM9IDqO+LHXQiiTw3yZSXwmJfa9zc9LDCJWNU9X4vy
	c+FlgfrghY26pX4slxlAjxJXkk5ajUonVGDO6u+UqcBNCT1nZQo9/6eU49yrjCLjsahxvKlByTk
	JbtFabFiUnHJ+vKyF6sdwcDoVeTw8s0pzoKSmtmLC9YeNngqjnITVFvHCMzeMoXcq7JpFHcOr3n
	qo9NDYPh8VGUBOOrW0lDEWXuT/fVE47am4R9hDL8R3jV2WnvyXAm09guB9UZGbB/w7Gx5GtHAry
	M6PBknMk8X+X2KuEJZ8xDLIjrknGIzmum+VaX1NB5QuGLgPsfYngs0ENjLCOEAIzo8Gs5vJ2G1Z
	jx37hmfQa516recKHbYKnEpcldBtJ9ql7qVT8j/8Mc3PKDKZLTrXXCChSwu5goT8DmE29PaZ+33
	l861/TPcndCNw1AmfAElPdg6s=
X-Google-Smtp-Source: AGHT+IFag+cDv1EyiaP4MYi1ZbK/LSZq6/9BQnh0bUb96hv7LJ+5A+T859z2mvDQYonPQSgWuytAgw==
X-Received: by 2002:a05:6830:34a8:b0:7c7:6063:8e02 with SMTP id 46e09a7af769-7cc668a4ba5mr27471112a34.6.1767622288604;
        Mon, 05 Jan 2026 06:11:28 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ec367sm33167544a34.23.2026.01.05.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:11:28 -0800 (PST)
Date: Mon, 5 Jan 2026 06:11:26 -0800
From: Breno Leitao <leitao@debian.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <ft63jjhpr2w5s6cdpriixbmmxft5phkvui25pdy46vexpawzz6@mu6gblhm7ofv>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>

Hello Russell,

On Mon, Jan 05, 2026 at 01:29:40PM +0000, Russell King (Oracle) wrote:
> On Mon, Jan 05, 2026 at 04:00:16AM -0800, Breno Leitao wrote:
> My guess is that this has something to do with firmware, and maybe
> upgrading it at runtime - so if the firmware gets upgraded to a
> version that doesn't support PTP, the driver removes PTP. However,
> can PTP be used while firmware is being upgraded, and what happens
> if, e.g. bnxt_ptp_enable() were called mid-upgrade? Would that be
> safe?

This crash happened at boot time, when the kernel was having another
at DMA path, which was triggering this bug. There was no firmare upgrade
at all. Just rebooting the machine with 6.19 was crashing everytime due
to the early failure to initialize the driver.


--breno


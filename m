Return-Path: <stable+bounces-241859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MobDA/g8Wn3kwEAu9opvQ
	(envelope-from <stable+bounces-241859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:40:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992A4930D8
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFE03037DC1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC383CCA12;
	Wed, 29 Apr 2026 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhOGMnBR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAED3ED5A3
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458984; cv=none; b=aLq9N/DqYNoXeOJM6acW7L2ELf0vvAmHAsfB4qDk95wcsXd+J/RflftAArewTtqWnsbg5yjiUtq/OuxLOlmxe5XYaq3VxWnVC+xQTvWDF5YeumPLCe0F4n5dJR8tEG+HyhljInYgqFJeZhGuBQFwADHrcDujyudlkUNXnCD1l0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458984; c=relaxed/simple;
	bh=Lztaoe8D6tALyIoNz2jIME1CJAhrcwGitSWeewC9wTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkD4wOw099cTi2osD0a0nkLRBl8azSmUZzrN9xTPTEl/iU1XWowDt9RY0eii500Capw+lfbrRY2jl/0SkYOvse7CjxTyllBYB2dd+mzQTuVB+WYFrAtc1ZW2/a+deNN7I3hvid0ZYs3l/Q6a57zbE8Qmcdvjg1j5S4JRJEOAzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhOGMnBR; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e594413c2so5025611cf.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777458969; x=1778063769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyypOgEbiK3dH2xH1H/KkEjHCpdt2R7NPE0TLtBJdyI=;
        b=fhOGMnBRbeVVkLq8fQ2e+2oJR11TO+kQQhlRcrcCCVtuAMDbxFEWZ4h9dEc9sZIUf+
         vWY2TIOxJIJglqNkkzE1rfRbDpmMNI7NmEn1NOegi6KTXk02SMFbf9lQ6J4sWdfMP9Pt
         WgEqHXTeDP1FsZ1GSmAmPEJ1BfrgQmPfKNiRwljMl7yZCMKFKtetWG5Is9DIt/DHqmI8
         3JTcwWsdL3DvpqReJkLDmHDY9KfJeH/BCUO8IEwdSg2ulaNBYLf+qzzItyNUzKiYt0eP
         Yq1uAWEAh/kPux8s+5tKyYDOjpCzNyFRIVFrYTHE0vsC2gLH5ZU8cGB33jiSgmN169c0
         aHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458969; x=1778063769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyypOgEbiK3dH2xH1H/KkEjHCpdt2R7NPE0TLtBJdyI=;
        b=BXbc7uUQWdKy1EklT85shrslHxSCfO+9oZfOr4p+P3o6Q6wN4u4FcPKx4Kj8k3ePop
         5CJJyCen+Q67J0ltmCREZhykZBtyVKlq/OuRkPXFi8Tn7UaXQo6mFTITBlIMclnDGu8k
         VCVgx5jh0a3oVE9btOBWobO5VE2HD5FNsw5FQTWRAy8uRP+6rooVmXjCboMsIaf4TxSd
         CJPD0773UzkdNtJ+NgQ6EZORoZPHS278CBUqtfDY+Bxtu8MCnHl6gxWh4fNca9wTWA7i
         ptjBtU6Qly8Y3ZuTzUK2bI/FeIDxnCou8NKPSWprTOQijB+txxDZpPiq1Y5gaQ7SuuBr
         L6PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iP0k9/JrPaUo6EkkMlP5QvklN8F/jcj3H1fZSDxr/hA1UgsIiTOrC2/ohfITjDdScFQ/CIN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYhY79DzPU7PkxoOl/55p+LZ4oVbXPR66QZssF8XiBfN07MVf
	2dcMwE6EmdCLYKX0b3dZQoISwW3GsFlE80sT/VXzUC5jJOXnrSVkB2bZ
X-Gm-Gg: AeBDievtWnS9VyYrz+4aKke2RCN+5pDOmGVbBgFXRvkNVsVOmnTqg3S09xF2kyXrkCx
	tuX80/q/BML7eaWMTJFDej4HmRKod/NU4jG68zvFNjgcfy9cUpK+pIUPsRn4VfajBEYp2oRZgO3
	TVy6dG2kfyzS9I90G77VyTV/DCx3uyps1kxB8rjZczT2ZLZ2XyV9O3UA9T4ycDkFIazlfPWDiSK
	ow1ms8xCruJ7afrtfsMzknSNxM+Zh0CYfi+SeKfEx6flho3xY0S8dvWgZi9SMSnX+Jx8jmg18M9
	OYM4TYSwHzqwEfoIJW/b21dqWaoT2LZfEFjg/5y7nLNpavwR4Nrpsf/9V3m4nV+iOmmd4byqo5u
	P4SVfoJ+mg02X1VfUfTXcEMrwXUKVayURu9TekUfOYr7HCQG7lmXbxL0VYIKzCDdkprJMOH6TQo
	gLMbKJOziVXuOnM3o6sj7u6hAY+U4qUadhV9tHa6Fwm8YwIKBv7vIIPZbZ2G/LlApHJy8=
X-Received: by 2002:ac8:5813:0:b0:50d:7632:ddb2 with SMTP id d75a77b69052e-51019a37774mr33183071cf.12.1777458969343;
        Wed, 29 Apr 2026 03:36:09 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ab30033sm14354911cf.0.2026.04.29.03.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:36:08 -0700 (PDT)
Date: Wed, 29 Apr 2026 06:36:06 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: eth: fbnic: Fix addr validation in pcs
 write
Message-ID: <afHfFj0CkBUIQxRT@PF5YBGDS.localdomain>
References: <20260428172810.175077-1-mike.marciniszyn@gmail.com>
 <20260428172810.175077-2-mike.marciniszyn@gmail.com>
 <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa57970-7377-4986-ab62-f3f5d4054625@lunn.ch>
X-Rspamd-Queue-Id: 6992A4930D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241859-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

On Tue, Apr 28, 2026 at 08:11:30PM +0200, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 01:28:07PM -0400, mike.marciniszyn@gmail.com wrote:
> > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >
> > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: d0ce9fd7eae0 ("fbnic: Add SW shim for MDIO interface to PMD and PCS")
> > Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
>
> Please don't mix fixed and going development work in one
> patchset. They should be applied to different trees, etc.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
>     Andrew
>

So I'm guessing I need to send the bug fix to net instead of net-next
and reissue the patch series?

BTW, the review notes that the patch wasn't sent to you
(https://netdev-ctrl.bots.linux.dev/logs/build/1087030/14544928/cc_maintainers/)
but that is because there are two addresses for you:

grep Lunn MAINTAINERS
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew+netdev@lunn.ch> <----
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>
M:      Andrew Lunn <andrew@lunn.ch>

That seems to foil my scripting.  Is MAINTAINERS wrong?

Mike


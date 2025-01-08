Return-Path: <stable+bounces-108026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F5A06343
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914637A1AC2
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213B200106;
	Wed,  8 Jan 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UfOOqQEU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DB1F239D
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357056; cv=none; b=WwKpQYoUueEzsnnTB8ytGZDygt5mO+tukYmxwhKc+B0bCyOHkmcVeHMVUrASOsTVXcm718mbMbyY6VSm0uPHfEgYBNKV+w58k49Hxtr/SrqzBf3UdK0FXkuCj34MNskClys6BSU7rT3kvInI5fMkPgBGTdr7Wx9YSG9OkKBAnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357056; c=relaxed/simple;
	bh=Hky0O+HooNHTwNG55Ps4LhGb1RK5fKkOSgaeUS7w7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bC8N1Yhjm90nBmUz1XL300ptv9j/ta+im+Lo8p6/XASFbdCIuGtANbakJpm0tzPzBqJwTy9Q7sxx6cdU1o4Je7xrsEIgaAlamMN1rVyJAv74aHViUh8ZbRemIk1Mn9sn68+c/LXDF+GkGkwJarLgMyZuk5/ecYrPk1aTzDQcvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UfOOqQEU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so204415275ad.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736357054; x=1736961854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONCg2OSf3VH3eMW5fDuexZj0M7g/dt03y2eyy26nduI=;
        b=UfOOqQEUnngRCPGSL1QXiz3gAhBID9aYXUr2/5Ap/L+8HiYfPyg0/JjcNMb80kS2ED
         OsXFNs/BiJYqI1368IvakesfsuTCCkbzMaUQ+/SsPgkbnYKNsvfkU1t2HHoaS5tAqTo+
         WsOYORJR+O4FZa+4Xr7lSDRgQG1R4FQvVXhqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357054; x=1736961854;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONCg2OSf3VH3eMW5fDuexZj0M7g/dt03y2eyy26nduI=;
        b=iHGTWli1CYwhn2VPVVVHod7ZAnASArkU0PxezDy+uPRNwqmNL+2uokVuBcrBPR2Wrx
         Mnff2D5QBUvm+wQX0qEDCRVZjlvC+qmncx6tpyQh+jmdDm2ltyjHFJ8cDvAg8aJddKnh
         IamUlWcRKI9AM+rStZPbyzI/ZaU728Zu7FOoJu220OCf41q/JvtEBZWIkcq0eYeMoZWN
         YPVUP3tS6XxpUAlsolunuQD4f8anqEhyLAp8/VIRHZzPzIcirqhcntl4wPKV6Vq/i3xn
         hx2chlKEX0XNPqEbvBUkB5EUKlAAmCN6RK+PP66b0Gtx9kY3jD0TobbVZNME9LLdFcby
         P29w==
X-Forwarded-Encrypted: i=1; AJvYcCVZqkCybGTL/WiYgSkyJ8yGXvKSzgr4vYMRRrGa/tLVfBBNxsjzvPfk0myJmUH1z5bFjiIBF08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwYM6z4y4tMLnrugr9tU8OQ23yH0ZTu0Qgql4vxpD7x6O0EjL
	JVVEr+FZptC9kNdHFQs+I3XWr+SQEmFOrdQxSUJGHxY/4WWh/LU02cRhnzVwvkg=
X-Gm-Gg: ASbGnctS2TMouN158GQDP+VpknpOFvqL4VU5DUG8/8tFSDNkTW1U/Dc3NRO+M88Z+QV
	02AcGD1cXUbIuX89faK1IiHu3P5Eb31U3M/g8w+NibumtZGlxYN2hdnEVXNdWk7CkMguqZxWUe+
	cHcAWMksJaDaDFsY4h2IMefLpMbB9JKH7wcgTtOGFeFsQBy/NoO1IVwWfb8oTqyrSqiqpkzIM+J
	MNWRt6xI+pf0i3MlMDS2BqM03E3dPcmZKjBmBHUaGAo9vbH1i9cdMLZ9obPTWPVG4LpTWouIHRS
	ETDrLpgq0ltN1gw/aFl5gaQ=
X-Google-Smtp-Source: AGHT+IFCU8nJXsp5a/nfECEtTqResZUxZXH3i0XAaYZEqyChLxSRwnXdmtEOu0lPXK5raQdTHTv/SA==
X-Received: by 2002:a17:902:d511:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-21a83f69cd4mr56438315ad.32.1736357053731;
        Wed, 08 Jan 2025 09:24:13 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f5195sm327911915ad.194.2025.01.08.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:24:13 -0800 (PST)
Date: Wed, 8 Jan 2025 09:24:10 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, stable@vger.kernel.org, almasrymina@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: prevent accessing NAPI instances from
 another namespace
Message-ID: <Z360uoTfHrl5VwSB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	stable@vger.kernel.org, almasrymina@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com
References: <20250106180137.1861472-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106180137.1861472-1-kuba@kernel.org>

On Mon, Jan 06, 2025 at 10:01:36AM -0800, Jakub Kicinski wrote:
> The NAPI IDs were not fully exposed to user space prior to the netlink
> API, so they were never namespaced. The netlink API must ensure that
> at the very least NAPI instance belongs to the same netns as the owner
> of the genl sock.
> 
> napi_by_id() can become static now, but it needs to move because of
> dev_get_by_napi_id().
> 
> Cc: stable@vger.kernel.org
> Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Splitting this into fix per-version is a bit tricky, because we need
> to replace the napi_by_id() helper with a better one. I'll send the
> stable versions manually.
> 
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: amritha.nambiar@intel.com
> CC: sridhar.samudrala@intel.com
> ---
>  net/core/dev.c         | 43 +++++++++++++++++++++++++++++-------------
>  net/core/dev.h         |  3 ++-
>  net/core/netdev-genl.c |  6 ++----
>  3 files changed, 34 insertions(+), 18 deletions(-)

Thanks.

Reviewed-by: Joe Damato <jdamato@fastly.com>


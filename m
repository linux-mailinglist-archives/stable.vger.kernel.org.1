Return-Path: <stable+bounces-67636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4C951A8B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8880FB21D9A
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 12:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262A13D51D;
	Wed, 14 Aug 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O2BKfviw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C121AE855
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637165; cv=none; b=c02Yd1yZm/c4pgLNDzJ5Cvd43+xBIAGKoArWIEPNdODDR1eloNeqRqtPbafN9jvtKUM/R+f1tH3SDwOwEshQ8dTIU+ZWrGNYWaIoi7nJ8RvfLTY/wDejEUpg21K8JK4/3mXbLXxP+2jfaE2wXL0UxYnUoo3X44KlKIk8KvUP4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637165; c=relaxed/simple;
	bh=gd0IZ5EN8FLvwLtcwZohMxrnj1Hv3wxOAK6EJ8hB1vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYd/rOqxtyaXLYPlqNuLqZ9c9/qQcY03yiD9JCv/TsVSwbsxGS+mF+JXS4a/Yp8Zu6PE7T3uVkaEs6eoiw8qdfZoqtxIEiqP+0GTeCsVhuR5rxSQAKDdatf3YQjMJfTtMm1O8PcOgGwmDdIEhHTnOHOTYRpGnvB1t9IDY19iZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O2BKfviw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280c55e488so4863435e9.0
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723637162; x=1724241962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd0IZ5EN8FLvwLtcwZohMxrnj1Hv3wxOAK6EJ8hB1vU=;
        b=O2BKfviwF+5TyvGAJdBqqNk7F09pmB5lqfuJGxAlc341S/GX3zxnIPOIL+Ip895GR8
         ZodHgnR5ty0aapPRtH4Xeozm/u5bDPreG3puWNlV4xlcp9VqRRBMDFLry9kXFio+VjaF
         qkKWiWeV2ncQK0SkWN8xc9yk7djWoz4988wMJVN7SZ/lDvzESyMzSg6k90fcYTd04uQ2
         19edCKVkLdOlHJfHhwkfo9Be8N+2/q6Ezw/RLATY7VbCWRxXIw3GIVtGUUz3JbUNDtMq
         Pa5B2+rmWBJt3c28H6z+ah4o6KhIFA3k0AV8+vvPbTkc8LXQcv5V1y++zhJkihmqOTCV
         pnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637162; x=1724241962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd0IZ5EN8FLvwLtcwZohMxrnj1Hv3wxOAK6EJ8hB1vU=;
        b=KVJSWuTvI0RFNeyI9mJbZ/f9133EU2ZzjCtcq0ooAP9i8cnrzV8gtHCMvpXw7iWPwZ
         CK43bos6/uRDitTb9Zlx2o/oZvqfFOGW7n1ZjZRpf51B9suZyQ4IYNLVTpI01QOlSLO9
         26jgUg3h3Nt0M0YTVcq3qDnd8p5pF8eff8ScOvfdLVLsp6x6xgA38uL1+Wx+Kl9X5VI1
         x/8qQtORrKUbDQJtMskAg7352W0KJdPe4+tPZQSgAxy495YrYV5PG5wjMsfjl6qnpIyb
         e3VgOPJK4Tc4/9OBI5l9FvmgSpNMZBFxkCbmBma97TyDLCUEKqhCxBe7cdSl32XXOoJJ
         +g0w==
X-Gm-Message-State: AOJu0YyBKeaLXmJ6MNpa2cQ8OAxX0N/oCfSyRzF8Bm3r2Dd8b9v5Vr/F
	ZZUzC96V+ZYMLG7Qoirnwlvkyu/uLR54TITGIreow0yGkcKjJNa+V1pTkpbRfx4=
X-Google-Smtp-Source: AGHT+IFK9tItiQFrBm0FFaTbJQ6kU3PJtrSKuDDXaxVjodxyGXKZveXBhaEMoW3T8np6iwQotEm4FA==
X-Received: by 2002:a05:600c:4514:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-429d62900cfmr51225855e9.6.1723637161918;
        Wed, 14 Aug 2024 05:06:01 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded2882esm17835185e9.13.2024.08.14.05.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:06:01 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:05:59 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 017/568] cgroup/cpuset: Prevent UAF in
 proc_cpuset_show()
Message-ID: <xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj>
References: <20240730151639.792277039@linuxfoundation.org>
 <20240730151640.503086745@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ewb2dnr3qonsceaz"
Content-Disposition: inline
In-Reply-To: <20240730151640.503086745@linuxfoundation.org>


--ewb2dnr3qonsceaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Tue, Jul 30, 2024 at 05:42:04PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> ...
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup_root is kfree_rcu after commit d23b5c577715
> ("cgroup: Make operations on the cgroup root_list RCU safe"),
> css->cgroup won't be freed during the critical section.
> To call cgroup_path_ns_locked, css_set_lock is needed, so it is safe to
> replace task_get_css with task_css.

This backport requires also the mentioned d23b5c577715 to be
effective (I noticed that is missing in 6.6.y at the moment).

Regards,
Michal

--ewb2dnr3qonsceaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrydpAAKCRAt3Wney77B
SZfxAP9ywyRvIKhBVUuIF+3idoVQKQWOlPsRUq+dEm0ScNqbmQD+MtZgzYHXuLkX
Mby2RxhSRXCwCsXKgpEdCEBqBpKvLw4=
=VlV7
-----END PGP SIGNATURE-----

--ewb2dnr3qonsceaz--


Return-Path: <stable+bounces-254690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ35OU13F2ruFggAu9opvQ
	(envelope-from <stable+bounces-254690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 00:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0D5EACF4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 00:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3FB303AA99
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01823C768E;
	Wed, 27 May 2026 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbAWvX0w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2C38A706
	for <stable@vger.kernel.org>; Wed, 27 May 2026 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922695; cv=none; b=jt20pcISZPW1DiX/5MzLm1S93R8Wb8DGCYffjZtiyVzvjODaNvnzRDS54OiQVRLXw02dHqLxtV/N8AIRCtblVauxYJd1G0dDNaOYN15L87pcZvG/IY/deKTUImcdYz5UQyoWovKvIQUH3mMtRiV/DlE7MH2nkZcOeA+aKIhbzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922695; c=relaxed/simple;
	bh=WsEkreIK3kaSY+Yks4fFmxDnN0WZRcmq6pLvjHV66TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atmjd5CUZ/U7I+nDmEEPyGlUZMd4ulG2ijoY5vFK9PKKP8isW4Z0mQ2f550NhSZQDORblSf4ySZRxR3CicVROIvKBKCScGXvtiJnw8k4t9ThCEBiIbC1B1+o1fwf6jPS168qm+fzMyQBzk5X0sYCXHsxvweEqI8+FF3eF0KfrbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbAWvX0w; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso1185ad.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779922694; x=1780527494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci2hLuxtqyG7acCyeI0Q2f/lfW0f79C74La8N7nlA1U=;
        b=gbAWvX0wz0krjFMqqoTJZUw/yeamSD3H8GQFafbYEU4MUyjor1+19NujLNkFUGM9ea
         bbHHI+cJAe6gtC5eIbh76vgu1uS4S1jwcvbwRsJNkJDpiyp+fqJsfnxdSlIekqslkdsz
         yRueoyRLvCUCEHGBy5O6ohgqmGP79bowFvCu8wRIykqocErPu3Ptd352B+pgHayi5yW9
         nLi4Vj6GptHfZLQj1BgpXink03UwI2Erolx5YGdPwETe7uXzNU3D1ZBx6mxOgB2qmyuf
         jFQ5G8YjnQPV/aWx/NsLirBkGCSiCZeNtR9prmKFfsuj2xHRyiHiM+2UA6/Qn+Muo2Hr
         1ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779922694; x=1780527494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci2hLuxtqyG7acCyeI0Q2f/lfW0f79C74La8N7nlA1U=;
        b=RLFTzbt5AKs+5eeL6nRRA+OZY6Hfj+Lp2NtQCZg1hx/cHMLgxxXQFbp57udLrFQGjk
         JdWRaCFMExYbAhlP5KG+XPHKc/vdlC/TwEpx2ASpNW0Y5/hwn5XKfaCZOUSyjL5yHYPC
         eDust8QycdLL2rphYIvg+cwzSw6FSNC0pTzLEUOawVLNEHjRlKP7M8Yd5Q7nXfdyhcps
         UXRYCHBqNoaR8nuccqQ4HAz79r3QWGoT+z8ltoFmRWUQ9PkZGGohrvMOd1wUKtIsGfBP
         TO8VDlK2h7T6SAPSbR0INTyAQXmBim0vp3RJZtmqLnbJ5sBq5RPmPX1LJ3KroDUv3+Ui
         1wwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PUFbnuSruy2wtl6uHfV83KpjhJR3DUN6UJPrb8i1Jivt73TyrCl1naWUAXByDgZGxGQFCXHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQtXqB5vPWboQtrGWYUMlaWqu5F/D5KHd3OZndMRHRjMrwZIL
	PLLKvphDehGVG95Fhj5azdQqPj2Ekb/PrJoH9I0gONrB2K7xto+SEKvK8Vpxu9R9Fw==
X-Gm-Gg: Acq92OHbAbXpQ07+z+WL/iUP3xVZYzqMbQj6Q442wRhEC7zkJTizr8+hPerwcIKyVyY
	6JBomb5eLk2R9aoSuFXXHvfqaJOwciVZ53OCAfQN2Oe9NqIAYgNR4+W61PGN/+lXtdCgvW3yL9O
	Nqn7aK/bYDMR4uMCbhmdiZ3HEzq39antdWyBmIySUvNYY6SUsA+sO2uJ4Fh5svEuGl/RuzYq6HF
	bjPLxzY5NB5sOZLRgBXwkRWmg4Ia3UJizD+MnTl4Ds770ETtTQHFQsf775LseWrkknyxCkYVHWe
	u0hXaAx5i3j0i2qE1nupwdMtpo/u5zH4eUoN84J+CkeTmS9UQPzJQMbg0N6WfBkbbfU4PkCHoml
	z/hj+EzUXbh047zkj5Gp7YZT09bwS3VPP5Mf5jw7FUe19vRMr37yP4rMMYOPGyaFx1vMvcBXExK
	VCN7N5QeoZkSKtA5DJzio3jrYvy08JrceMgYO3TrULBFyxfK36/FMPhB5RYQuV4v7cJffcVsEM8
	eoh4Q==
X-Received: by 2002:a17:902:f60c:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2bf03f0811bmr728115ad.16.1779922693181;
        Wed, 27 May 2026 15:58:13 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7baasm20666645a91.9.2026.05.27.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:58:12 -0700 (PDT)
Date: Wed, 27 May 2026 22:58:07 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Afi0 <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
Message-ID: <20260527225807.GA655711@google.com>
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com>
 <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
 <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
 <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254690-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samitolvanen@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 52D0D5EACF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 04:05:11PM +0000, Afi0 wrote:
>   Thanks for the correction. Updated commit message

Please follow submitting-patches instructions next time. I used
the v3 commit message and changed the Fixes tag hash to point to
the correct commit.

Applied to modules-next, thanks!

[1/1] module: decompress: check return value of module_extend_max_pages()
      commit: 3537d8d21112c2fc664cc09895bbef01fa64d34f

Best regards,

	Sami


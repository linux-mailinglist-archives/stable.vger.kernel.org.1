Return-Path: <stable+bounces-241284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFgVJhMx72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:49:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3147023B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C0993018C03
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278853B38AD;
	Mon, 27 Apr 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irb8qNzq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180493B38A1
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283326; cv=none; b=ZsaEtaek8LwEwMmnXSt99eTXVxiE+LrU8HbNhhjTQs2hS0BSErhe+mUM8ySdAMm4QpA7rFufpfQ4G6+3dr65rH9jeGISgTRQAxRkwkQMCDROfuV8G0mNt9fZmoOQ7EhvN6S39xKH22C3RpIbU0+r+PJ0FlM5g/Ja8xpfj5wpHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283326; c=relaxed/simple;
	bh=NWHIH3ouqqjU28LIsZMEpIlQaONQR66hx99uHDySAWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgijZjvm1MqcaNTvwANtTWSN+y/zWL++sWXn3eBe13/m6n5QlbIK2I1boGGw+dyF6FRXVYP95kxUIXNAbAMVU3dpzT9xBEcXY74QlbNLBComo2GzN3UM/5oCDTap34II9QXeobF7g8kpSrCJGdaaSAD922ciZVql90orp5DWvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irb8qNzq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso74034035e9.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777283323; x=1777888123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+utIrc2QBhWvwYujurwn2Jgp1vdBp2MWfdaAw3dv8I=;
        b=Irb8qNzqxyyiMPkuhFkkMRMjYMlY9uC+cqCzkXoGBA1oIJXpIqF6CcN6rMxIUR2i64
         1ALwIorR9+PpjVdDMN+70uIHjl92tLulR2Bo088HjRXeHfbPoiqPg0QIALpUsa3T/4V8
         2XijCHIZiGa7h2kl1EgaCieuiMYT4zN5ppCfCa6LH85LsttinAxrC8O6hfsixND28ByY
         F9k9cFtSF13ZC/UomIC0n6385ELvtghsE1PxVzfX1Gn04J/rfbjUIUE2FxZmWMjFCrNx
         Eqo0Tba43hAm+kSHGYqs4pHYSEaRmJBGqmB/9mVu/r9Y1mb7YOfWTnaRR/P8IjNXWJnh
         mFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283323; x=1777888123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+utIrc2QBhWvwYujurwn2Jgp1vdBp2MWfdaAw3dv8I=;
        b=L+w2B8sH3GvfP56zMBvHHB0StqRAzPmuZ5/xexAc3h/F98lOnTZ9YIErxozPmaxqjk
         tFePVFbx7dqhi1n8nKy9v9pv1huXZXo9yLdAw+sdXZgrWDePRqIILiDyQmFa87aL11TL
         4hyXnLZXK7lu8CN+qc52YY3DZGhzVHJQGChMFb1lA8DeqLI/smmVHssee6RJHHcb1uu+
         Fivdcu7rG4yIi3+VysnfM4Pls0MdqHjGErBhfKde+/d6mhTG0XzbCIVGcWR8HFtZqZQ7
         OisQUVp8SPgW+k34546upPBmY0LvEHjrvEq0o8YvX/AA7zHFN/WNdRHni/VkHP6Y4z9J
         v0/g==
X-Forwarded-Encrypted: i=1; AFNElJ9rFKsKN8eq40zuPkTyxLnQjqs9U4C2j+iNn/CHKhI1crAPBg5j/pxXORi24I46ExchpxF/TtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuOZX0v+onWUseeAFqN1GHCIuy9XS+J3JG/pYEKlbCGUCQggv
	4z4Iz3+l93ePrV+uF6T7JrWT7z7KwU5Ajp0tjSqVzHQq0TmWgCj1GFap
X-Gm-Gg: AeBDieszrhBB/beuScjiqVpR6/Hd/GMI0is93KHj+QPwm5X/O9xuzPdM0GatHJXXeyv
	adIT/6ByKS6qVytA6tKLzOjJZ30NqgFkGC1DqSRGwXFZ6Pgsb6Hv3iDn6HhDjz3p1wuH3/66aNf
	Umany0kuHzyI6XM3pdcLk0C8yake+fFqu/NrkenSCz5So3VoxvxqK81tceNRrn/WMbovzFE+Mp0
	/o7t/l3KDIPPDD2xEHN2U3fadSjXVJLnUloH3QmD34ScqI2tr/p/NV2xgy+Q4EiuODEtpEugyZA
	NjIfSPCUYDHvgRMNUBAoZZHFRpTLK9ejc6WAf7o+/6hUvvVkxaQ2KYKBWXqvBTHgpa1zFB4Yr0Q
	iM1tDUbORW3CgD7zmFq7c6N9YgjjRPxW1s92ZSmRVyIeCPLmjTxz0C00O4OScdT9scmQ9/2rmp8
	WLocrqE1VDdq2NRxrOM/kqo9r81LEJeQ==
X-Received: by 2002:a05:600c:450c:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-488fb768816mr586188275e9.14.1777283323221;
        Mon, 27 Apr 2026 02:48:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6124d7e7sm473159275e9.5.2026.04.27.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:48:42 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:48:38 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in
 HT_caps_handler()
Message-ID: <ae8w9tkpM8G2NWWM@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
 <20260427081748.3407939-2-hossu.alexandru@gmail.com>
 <ae8pq5YzEe2wTJmx@stanley.mountain>
 <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ef2c47.5d0a0220.2e33d8.bde8@mx.google.com>
X-Rspamd-Queue-Id: 41C3147023B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241284-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 02:28:39AM -0700, Alexandru Hossu wrote:
> On Mon, Apr 27, 2026 at 11:17 AM, Dan Carpenter wrote:
> > We need a little change log here.  I was hoping you would provide
> > a link to the AI review in the changelog.
> 
> Hi Dan,
> 
> Sorry about the missing changelog, will add it in v3.
> 
> For the AI review link, I don't have a direct link to the bot output.
> What I know is from Greg's reply in the v1 thread on lore.kernel.org,

What about a link to the email on lore?

> where he said both his fix and mine would break things on some systems
> according to the review bot and asked me to use truncation instead.
> I went with min_t() specifically because he asked for it.
> 
> You're right that technically early return would have been strictly
> better than the original, the original was already writing out of
> bounds so it wasn't working to begin with. But since Greg asked for
> truncation I kept it that way.

This is the path of least resistance, but it's better to push back
on bad advice from AI.  Greg won't be offended.  And if he still
doesn't like after you push back then you can still do the min_t()
version.  Both versions are fine really, but I generally go with
the stricter one when it doesn't break anything that wasn't already
very broken.

Better to use umin() instead of min_t(), btw.

regards,
dan carpenter



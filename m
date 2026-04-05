Return-Path: <stable+bounces-233329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADT9BVNB0mlMUwcAu9opvQ
	(envelope-from <stable+bounces-233329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:02:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398239E191
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21178300829B
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4C33F394;
	Sun,  5 Apr 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHIIaSJD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16C30E0E5
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386959; cv=none; b=SkuX6rvUMAqvMDl1m1UsyyVCpU3B2DfxGGib6Ol8qGCbqX92NozZezJnaRL8MDO3Iz7Ttx0hGwvfBQn/IoLdH1Rirq1hAPown3xScY7LmQn2hqmg994DyEMX5wglqiA0CTXJIgfhLIxZcAtQhGUVeYjm6kf9ge6DJubuGhKmU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386959; c=relaxed/simple;
	bh=uhcj4+M8ewsoJAYo4/IwJ+tyF+usWD9SiHrQBKbiJco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW8dGKAJ6Lob3+/5r+w9cGcyFYKgUd8+dq25NZetj09SVOBcP5+DsGvZ7UnHZMi2ko6DoVm5gbWjt6j00O4sH2drSDxJriho2zFN7KYWDIakey8Nx0lPKYSRGbRbPM+BaKpn6C//WxCJbxcfBayHY6XldW3FdAt/3MiaBLv6qgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHIIaSJD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso44960825e9.0
        for <stable@vger.kernel.org>; Sun, 05 Apr 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775386956; x=1775991756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z2SScjl33qfp9r9oSnvAllDjhwVuv6H0d941JxUe2o=;
        b=tHIIaSJDXx90oYylK8ldsZKuApxloOMBM5HY75Z7GwUCPDxFLYzMy1FsDfJjiamE6e
         lEzzXT4EnYtWiSlS/f6A8/tD1GHrkD2aO9nME+pEbauoQMtX0bLNe5bPB2mSb4wNhKKX
         OypNZFO/I6lTfCru2oFJeG8oBIDs/b9wEVfRYXe7i7KkmhpigKsTgk8CTyNGhXXENt+L
         VJe689925HHI7t2V1VZhESBY0nZIKTM3+bTfZ36IxX2rZbNE1wxx5x/beynhonM9Iwok
         G7EtJYAUj0uR1XFrnCTyrFLAtiQFIG2FjK3klYYbQGNIHYots6WCwe5Qrwg8vo70wdh1
         MWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775386956; x=1775991756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Z2SScjl33qfp9r9oSnvAllDjhwVuv6H0d941JxUe2o=;
        b=H/+nbySF8+lACs7o/hAekgZkrZHGmuHJUuNxcOVsBQtaL25U/9ffoxtb8SSNBmOprd
         Iam61WsevG89uAAcFEwVewH5ie63wgdjyssxEHAgLPqQYeXQUBnL4+R2mzBWbncILWAX
         JVYDZGxP48PotLRhg1xaU2zOkgI+76IDg2/u1fZfz+Cu54C9N0yrwCF1iFjUJw2Lc7yE
         97rALq3mxSckX0RDRoFYX+nqGUuSVTkyGoQ3fb73kuj1RYt6EMNgf2vG+BjWxF35i8gH
         whZ7UOy5TqwfkFZvN0e4s7PWIolDnUP9v51hQKsAo9pkWnVSkgieqLnnJRpAO+tUrJAE
         BqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVdx7okoeAROTGpgCLEwZznFOvdWCBrkXmtXqLrMOBBaIMwrj7WerOamDcS6cwbuJt9FyScoQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KKyOCGFPNVBiCWIYaymWTOZlJRImqWmG4kW10AGyjgCZYo1t
	D722RiLqK24e3eD8me4CrRWdx5lRGavJeOUORmxABht9HrGe0O9WOwy6
X-Gm-Gg: AeBDieuobmamwiv6lqDZH6Wg77HELrAaj77s8IkBPL6+cQBohDusoeet7S2IT7iLUbB
	WhrQQZECpyYZ6qSBcYftt1sIpvuWckwEmP2p49e6mBsk4YWTDBa1ZR51u/6JrbVZbO+pIblygsz
	ceGst352+pHrdh2KMD6uczN4YwS/5clRrdIoEIpM3Nw7xnT2zh/oGpRB+f9/MwjQDzPaB5q0RTE
	ma0mPfPvw2xMCjMYbwCxg995fFTcjo9F+bPZgXLDDn8arhInKF9YqSaYUPdjS7EasZiQOTrVY0i
	jWPAxWBxyZaOktJtMBVI+eL7F8ipeid/o2aDSoKhfyzp/2Xql9wxMXKVDzEeDQ4rCjgtsf46+do
	V0arFy9FhWVt9XjVm3dH0AIFXDxyXBEpAMsB223NWlzlqOt5kQHyO39maoLKDyfXkDseh1UyMH6
	7oPb90DQnqCMzxE49R0VSNmPYkiW27rw==
X-Received: by 2002:a05:600c:1394:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488994a7a76mr125133135e9.13.1775386955970;
        Sun, 05 Apr 2026 04:02:35 -0700 (PDT)
Received: from gmail.com ([2a00:f41:1c83:b0bd:2a0c:50ff:fe2f:36f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e457bdsm61329315e9.20.2026.04.05.04.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 04:02:34 -0700 (PDT)
Date: Sun, 5 Apr 2026 13:02:32 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix negative length in WEP decryption
Message-ID: <adI_j9c8MqDSdTjU@gmail.com>
References: <20260404230248.62203-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404230248.62203-1-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[azpijr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8398239E191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:02:48AM +0100, Delene Tchio Romuald wrote:
> In rtw_wep_decrypt(), length is declared as signed int and computed as:
>
>   length = len - hdrlen - iv_len;
>
> If the received frame is shorter than the combined header and IV
> lengths, length becomes negative. It is then passed to arc4_crypt()
> which takes a u32 parameter, causing the negative value to be
> implicitly cast to a very large unsigned value (e.g., -8 becomes
> 4294967288). This results in a massive out-of-bounds read and write
> on the heap via arc4_crypt(), and a similar overflow at the
> subsequent crc32_le() call using length - 4.
>
> Add a minimum frame length check before the subtraction to ensure
> length is always positive.
>
> Cc: stable@vger.kernel.org

since you cc'd stable, a Fixes tag is needed.

...

--
regards,
jose a. p-a


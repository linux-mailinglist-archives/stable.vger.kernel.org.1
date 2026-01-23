Return-Path: <stable+bounces-211409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLnAFQm7c2kmyQAAu9opvQ
	(envelope-from <stable+bounces-211409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:16:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD17974D
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 19:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A451305260C
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19F208994;
	Fri, 23 Jan 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+VDZZxn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4873EBF37
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769192131; cv=none; b=DR3wmmRt0T2d/FIeySU7xERPPeD0xNqc2x2xGO/VoHVsikalk6J8sBn1DzYqA8HeMfd59jmuYaCDdw/ePnC0ujvqZqc6pm5ZOlvW8xEiyRW0WClAuiMqpv9Du0wZZ11sJHeoBiAAWcyjzIfMtUWiiDS5CIR0CuniLtHch9emIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769192131; c=relaxed/simple;
	bh=GeiVkoys+ZV9WCFIh+pTRLKwojT6VShoLOOSeXRMB68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrZKhZTsvrdPA1D4kShSSH7jxxiL+3KoYAv92vf1XnPiIsnJk5KOfXsZsj8kEMKa3WsvL7B/SGRq/0F8qzz94Y2SucDjEoVxU+2ooNyhwEaug7ZoR5InV/epBDOpFJdt5U18KWjGnylThkjZ8LKOhAyh+O0oaKNvGfjvlHHVPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+VDZZxn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a35ae38bdfso3105ad.1
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769192129; x=1769796929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IohDYNeHkOn/d8TkWg/ylD9BddFNWCchlmynMRMxh7Q=;
        b=k+VDZZxnMZYiOqjaqAw5FpFZqRBVX5FQ+AuKWuFKPk7FiZlaVyNaZIEjDlZqU2e8oi
         AX1oeE6dDoHMnW+3PZiwtSEcQ+C5W4Ls1oPm2EjLDEPXSj81gspckTyqt1XRgFGugcIT
         XVElu56DwH3M1FyN+3XEnr4Cv2GyPjJMyLUYGelAfRM6Xvue3LQqawzVctDAGKbfSggu
         8cbqS8UR3aTxXZ9J4hunUf5TsBik0/3mfT4I1IX+hI/kaX0RotmYtxXXbr2SziKw3SiS
         W10HaoHg85UlTs46h0mEYLBYjdGMKYkVDfu2Oumk+Fy5hm5yCkZAB6bTFwtv2EcTOMpg
         FnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769192129; x=1769796929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IohDYNeHkOn/d8TkWg/ylD9BddFNWCchlmynMRMxh7Q=;
        b=dkLClmJ20lZ5IwKupqMKv3BPhPv8EP4n+7O+AiJGItE6j6suti1hETF3/qp808nWHE
         dP4ZEGORwKXb/EYLqHkvBGTiwRMzG1e+BizsUBvBieM/e8li24ivpZskezl8k3KhKK8F
         JiLLnnnAbTCQp+/vgmBB0lSHI0VFnpAg7+h88DbnqxWHC5pD6ISfT484oVStEgs3hfOy
         mvpQ57+2Jd5zZwnay8ohNFJPv/oI+2BG59eI9Okiq800atYjk50EBNQrNLu0WkUvdQKk
         Nv3zwUmdUnKSycp9uaFCiMDN4xUXJbmFP9mYJ7Hz9mmzUCeBgThEMVo8BcGrxPJbXLwJ
         HiIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVREwyUwPW0A+HF1N6KM50VukxE8ScVfFcgJPgiXuasidI/4YB8L6zJonX7keOCE10A5LFtFrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUBvUCTHakuyAMpLEkuHBLICsQNlYYhJgz8xKDjxgcUkoPJaK
	xCyvBad370mx+X0/NCWMqCZqDguTro4+VMQr41oRROg6fKVJPLvDXGy2iEeVI2hx6MXuWpKpOaJ
	EeX1xmg==
X-Gm-Gg: AZuq6aLfLA/SXX4Py/kyO/nE20X9faPP7V0cU/Qh0a+rgLfqyvsrKXQVkEe63xVG3J1
	9MN9hFDiF/l/dqJ2D0li1LdGFaS39Pv2FvWBplqxK8SsatUt2tnLKnnCcFrLd4AYM8p5jpm5qZk
	8Mgn879vClbUJVM+UjehchEfgTpLHOhonEpAzhR+vYsaFi3liBi08By5oHmN+SMm0iG2yMYFHou
	kxvoXwjGXFOz9UWP85SXINGMkExJPAFoDgxW7defcTt+KnS7O5CkQEbsOjbG6N+vl890vDpMhij
	j0ZqQtBx+Fc+dTCO/3yVhTjHLmRYDRCp5lTSxMr71In51T0GOnf0YjNxxzx/MYnYfyi+GbYHayF
	Ff5AXWqHdHLO/xSWFNtykCEEIkuBHKhy7WWenmadfAvq41XYoP8xO2yVFBOzW8/sIA1xQjDydfh
	dUqvjV2e8gI855sTpnX0ZvYqkJS+iplbYxc1+PPghS3Ngsvy34Kq3Uzv1Wq0/D
X-Received: by 2002:a17:902:b216:b0:294:ecba:c8e with SMTP id d9443c01a7336-2a82409033emr18055ad.3.1769192128631;
        Fri, 23 Jan 2026 10:15:28 -0800 (PST)
Received: from google.com (210.53.125.34.bc.googleusercontent.com. [34.125.53.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd97bsm26088195ad.35.2026.01.23.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:15:27 -0800 (PST)
Date: Fri, 23 Jan 2026 18:15:23 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust_binder: add additional alignment checks
Message-ID: <aXO6u8weGao9S-c5@google.com>
References: <20260123-binder-alignment-more-checks-v1-1-7e1cea77411d@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-binder-alignment-more-checks-v1-1-7e1cea77411d@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EFD17974D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:23:56PM +0000, Alice Ryhl wrote:
> This adds some alignment checks to match C Binder more closely. This
> causes the driver to reject more transactions. I don't think any of the
> transactions in question are harmful, but it's still a bug because it's
> the wrong uapi to accept them.
> 
> The cases where usize is changed for u64, it will affect only 32-bit
> kernels.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Acked-by: Carlos Llamas <cmllamas@google.com>


Return-Path: <stable+bounces-151621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBAAD03EF
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274823B31A1
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4013D52F;
	Fri,  6 Jun 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr1QraNu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B613A258;
	Fri,  6 Jun 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219662; cv=none; b=szEwgja8x8i44iBqOB9icFSGxc1iYcqHSfl52KbETzTmIMzOKqCA+ZhwD7CtMXUZfYaakpx0Au+/3bqTAPk72A4PVDDF792ZbraJLVY9hGohRA+u0Qo6t8v4nIEbaMm486RPe1LZn3CRLb2159l15WBFuCBrXr1fI6MgO5SbWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219662; c=relaxed/simple;
	bh=rSP2F/Vp8pAf45QmfKMDtzuSXKBxupSWAhnZGVm31eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q17u/+7kvhY7Vg6/O0PjJ3EIE9HCrDpuhM8Bi7BGvS2W9J1A+/DOdSLnSf0o+Qoo34ewUKm1HWWMKndajTnFxc0XoQWcZ75lmnzIaWTRc82wA4lhFrXW1AYIjWT52HsxSk1bMj8tKI1Mc6BjMtC0zVRkdUOKdIHerNbAf4t4Au0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr1QraNu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c336fcdaaso18812955ad.3;
        Fri, 06 Jun 2025 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749219660; x=1749824460; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oHF+BaYEidVFkRjLgW1RNqKQ9NAKcb2cnOs0pZlOZI=;
        b=Qr1QraNuxpm5zmQDlO6oHizRqfeUPmlK+VVtXg8liFA5qQOSKtcKMDRiyVrMPXs4kW
         F11znNhLYVM/kNh6daLVfgCaqyUFOzi8wfoN4SMubeAS0QGVzc01265hDpWVFW5+evNx
         CEqkNV5UPxHtc7QJrvxZeeSLajze3EwICA2o7e74+q3nEu1KAvce4B1Ypm4y4U8Nb4yg
         0fPU43faciW8s/MbMklXf7kZuRAf/DUYk5PqpY+uZaM/eJst87cqGLUy+ZMnVpZhplZl
         zLJi/J0gF2RiFJcQC2TYbBmiHheoPK6BFrDiMPXUPO5g3ilK8pdH1eaCEZ8/RB1OWa3t
         GLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219660; x=1749824460;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oHF+BaYEidVFkRjLgW1RNqKQ9NAKcb2cnOs0pZlOZI=;
        b=jfCibSwIRO+/bS79ASDI8Xvd2DIMnTCVEGJ7CFTulxppqNmu0v2PNXPAeQTYDhxBDA
         uuziAWsNUHXiztWj5EYMdUDnBHysybXpAk83KMUim9pt1IFp70ic37gZpVeJNhLIjfv1
         kI7/Jhzc6EamkFAGkNdCAkZu53EEqgYCMSQlzxBOt9COvBwxrw6guGCcqzeSrHwythw0
         jJqYXXtlGLlsgX27/HIagjpNPJtJr2TY4/+VzBbsfCHKb5KjWyUj9EhOwgESdiuyj1tz
         4/YJ7nuvYWdPnSuaLX0kYPpmaEuVFnrhuof/G2sbTESBL3C+3ixfJBMcCwYBIgPLWOM6
         KpPg==
X-Forwarded-Encrypted: i=1; AJvYcCVxwdMOJUg6lKYqPa4qRDpgHmg6RBcBmXpRIyX+VdLfeSH5nEiLpCPCZJy0RpphdCmeXacC/LPBuyE13Uk=@vger.kernel.org, AJvYcCWo+ABnrM3dsLtTTCWGubU3Y2S96xBReSwvAOlL5zN6Co/YthV0DlCDpDIzDxCLhsoUWTWLUBbM@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiVXrNStN+68lr9hAdWLcy9y0QCxtycdjXphnC2ORRRujGO+i
	z1bcX4KU5yQsflZEU3uptUm6/5Shu+s0FLCHnyroIHnWOFv3rtngaL1nLVFyDQ==
X-Gm-Gg: ASbGncsyCG336FjHkPzcXQ5pb2TEHI0lGpDGWMr5KA5K/mjfPE0ekGs7Hhqj1KeQcuf
	O+g9F32H0pHAisqpQ6FgHJi+JW6cf159aLxCvyzfWqUArpjOcGD4cVEwGnEPpO1J2yOxFFM0cdk
	CnQ2mNYiNHSJJToMjW6xVEAWNKm1R3owNnSZrLUbbtAF2oPW4Oizbk0N1L+5bRB+ip/RaFSz81K
	AnTBCUAj5anLCEiy5nHPpIcHhx4kIwSuRndvOnDT/92nTL6VK7Edqjy/sWC0MdLE9yGY/PGespw
	VdnW5T35mGvUd3bNVul4jZ5nMLyzoVn9urjSDlXkEG29SPtK0eQ=
X-Google-Smtp-Source: AGHT+IEV6Xg84XbMRZPliX18VduESPGpoHh056OZEWDuyhWAMYEW6h7oFD9MTeB4Fa5jUSxYd8HJdg==
X-Received: by 2002:a17:902:d48f:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23601cf5aadmr37529615ad.6.1749219659719;
        Fri, 06 Jun 2025 07:20:59 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccc4sm12934765ad.127.2025.06.06.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:59 -0700 (PDT)
Date: Fri, 6 Jun 2025 10:20:56 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: I Hsin Cheng <richard120310@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] uapi: bitops: use UAPI-safe variant of BITS_PER_LONG
 again
Message-ID: <aEL5SIIMxmnrzbDA@yury>
References: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250606-uapi-genmask-v1-1-e05cdc2e14c5@linutronix.de>

On Fri, Jun 06, 2025 at 10:23:57AM +0200, Thomas Weiﬂschuh wrote:
> Commit 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> did not take in account that the usage of BITS_PER_LONG in __GENMASK() was
> changed to __BITS_PER_LONG for UAPI-safety in
> commit 3c7a8e190bc5 ("uapi: introduce uapi-friendly macros for GENMASK").
> BITS_PER_LONG can not be used in UAPI headers as it derives from the kernel
> configuration and not from the current compiler invocation.
> When building compat userspace code or a compat vDSO its value will be
> incorrect.
> 
> Switch back to __BITS_PER_LONG.
> 
> Fixes: 1e7933a575ed ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Thanks Thomas. I applied it in bitmap-for-next. Is that issue critical
enough for you to send a pull request in -rc2?

Thanks,
Yury


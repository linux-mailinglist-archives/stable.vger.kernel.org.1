Return-Path: <stable+bounces-118410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92758A3D668
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E1A16F4DD
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885AC1F0E5A;
	Thu, 20 Feb 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AN6xyaBQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F61E5B6F
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046970; cv=none; b=nTh8dUcxaNCodqwOJv3GUJZsw+QSZudR/jOzgYPmj58f0S6ljWMUUkSf4GUvdlJnxPpp/lQiw+ewjx/4sgP0tHzUdYyRImfPY9MyQTJPwqfYn+wIgldWCAflnkwRG1iFoSgZyHGo4l/pQggBzO1WOv11bCZg1yCMRLas7iDs86A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046970; c=relaxed/simple;
	bh=dwV5C1T08uCJyhf61xNHGbLrnXfynaFJ/L/Ujo0Xy28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5nVKWT+cMtUFfT2kOEGc+uMHLuwbbA5WJMjf/C5D6+IXQk0lsbHvhWoZO/8Ci7/Qbab4i22uVq2129OLGZP9jBsIpS2GJuG+KA1Ji3/s2T0BP2VsuAnQaxgM9CLn+JtdgkyvaP87tSK5iZg2yyGZHqpHYu6gqe7QTbzBkXxmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AN6xyaBQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f286b5281so369486f8f.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740046967; x=1740651767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdJ1tjXDGbz7fnnLGr6p9xq7nJI8m1bb43amubJ0qpU=;
        b=AN6xyaBQmi9zBQcVep+o0zVfgKluhdmta3a2sU90KfgCm5Kfjp1sT/3Jbmh4tlaAxw
         NgWxJUcR4LdAIxqSrMUYRoxyWh3G1pUYQds0foLS+dJPQybkMKgq/la0xZvOJRDrBokl
         bQo17+XbHm6MJ0gycY1BkfKhSdnkHmPqfemN2nQph9V3jqEPPlyop6JXKK4+iQFbtf/J
         GtiyN8gDwRSZpY2Usno9vkxZFtxUNyJwNLgzAzopxMCJ/aJM+DRNdsgFjhheXATGlmTd
         YOs8Nw+nmrOZIEMQ824ZwlxNA/LP3x+Bj96sR0yaWH10wLb/Rh+p5ky3ZLaHGeEcTcWQ
         3zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046967; x=1740651767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdJ1tjXDGbz7fnnLGr6p9xq7nJI8m1bb43amubJ0qpU=;
        b=BjNVTyR/3KVf00a3U87KbTJO82C+KAG8Leomjp9Yf1m2aj8SCPpT8c5v1pTL11MofV
         qy0NZXW7TmY+SM95WcMD83u5bL5bTksz8vV3JG4r2dkQZBfFibj/AO4++Tf5kPehdg3W
         ptFhwFsTahXdfL9HNIZLd2TDdRfnU2A4hB5roe0sjwqjcHTCQbcCtNBfaUjA5y5xNjig
         3i2MqMlseg8E8zrBuwciIYCTE0L0M9dhdKMh3C2Y3xelWExEIFVTqKfVIbaMZNKDaHzO
         tI7Z+7jyV7ncMkc5qMPJm1oCeN0xiGCgnPwklw5CbdY4aSdkd+Ay2TkNJNCirIqKseAG
         rWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEPnQQ702uQrH2aRueIHGWK/5Of5JvmNoqyZ6W0t0jNHDWNoNG08GAcZYtxYRa3mURFiD+V3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBb6t/oJhLfSWUA1Np2nYbywxO3bBQ7VRlMILWvWPEJgytnWL/
	9piLrqrWTanLAIT+7W57VmfYt2s9V8K+X9T6j+2pzJsFt8iV0iJ7inrekDbgR9I=
X-Gm-Gg: ASbGncscpeSLSwyaxEjee9JGknSzGodj29meyx4+j56m9lJCSSdis830R3exrF4zQ+Y
	MhCdwdh3HLIgYXwgan5DQbsFqYn1dUGukfvNg+/dcDD+QT6L6/31KplYQ2vRBPC7SYv/BNI7soV
	v/ce9NzS3x0EOk9mZplBcELbFGMTMRFa9Gx5Ohrkv0FpFz9ieoTeIiqCKA98fWi4dNMKFMbnC4C
	D7ikKs/aY8zY5QdKA5/Mwu3zA++st5cjFXMigWLAA/jkxskwALYz3DMBYpN9uSGtEsskbGWnPz+
	MBJnumkjvaV9Pl0IhoMWf/RHP9uJnnuS9/o33HqpRhM/Jb42+vSyEYkYrQ==
X-Google-Smtp-Source: AGHT+IFNBKicqin94xs9R9bvB+x/bbDZRuNAbanJhmggJELPLRHyKJNVbt685+Z4xzMPELU/nUfw9w==
X-Received: by 2002:a05:6000:1fa5:b0:38f:4fa5:58ce with SMTP id ffacd0b85a97d-38f4fa55a25mr10752304f8f.6.1740046966694;
        Thu, 20 Feb 2025 02:22:46 -0800 (PST)
Received: from ?IPV6:2001:a61:136c:cf01:505d:b6ac:9103:aec6? ([2001:a61:136c:cf01:505d:b6ac:9103:aec6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65bcsm20344688f8f.65.2025.02.20.02.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:22:46 -0800 (PST)
Message-ID: <6d14b473-6d26-4b9e-88df-2532b0c88565@suse.com>
Date: Thu, 20 Feb 2025 11:22:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: Add error handling in usb_reset_device for
 autoresume failure
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu, christophe.jaillet@wanadoo.fr,
 mka@chromium.org, make_ruc2021@163.com, javier.carrasco@wolfvision.net,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250220095218.970-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250220095218.970-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 10:52, Wentao Liang wrote:
> In usb_reset_device(),  the function continues execution and
> calls usb_autosuspend_device() after usb_autosuspend_device fails.

This can only fail if the device needs to be physically
resumed. In that case you called usb_reset_device() while
you weren't supposed to. The purpose of the call is to keep
the counter elevated in order to disable runtime power management
temporarily.

The code is older than helpers to elevate the count. The correct
fix would be to use them rather than handle an error that cannot
happen.

	Regards
		Oliver



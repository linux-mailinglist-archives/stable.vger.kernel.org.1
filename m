Return-Path: <stable+bounces-116185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463ACA3478E
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCD816E6ED
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF92153828;
	Thu, 13 Feb 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="PJwAxXxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33815DBBA
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460614; cv=none; b=HfKrzNpUFbfOLi5zCzJ7SH61ETmsL/ojmJKSJDcydkk0I3SOB6CUUI18HW/p7DVE0Ag0fJt7nHhIvk2z98h9f6BPjId3u/jPCeFtUnXGwrgn1vAmSepDVNptlgCeL3k6pdU7w9CDiKkByqIOeESAhEG8oArrxWI2zZJyecOxI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460614; c=relaxed/simple;
	bh=CIC6QG19MUkOFnBkVOTHWWc79rnkVCbOB9b7kdnsa6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex6UmCRwEt9Ryy7z++QF6RcvNRJBykRIkNGc/SelkJNIMbxQa/t0WnPM7SMPc2ZvLDN9OvbIpQU3Kmzot36iJxj9aJ0Z82S/SXpH4vSJMf5VJgO3Bf2MXcH5g1cwSjX2DD+jCwvhA5dEPkaQ5gFXU7BtT0xxINaz5VVFs8REiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=PJwAxXxh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0819d8ebcso7996385a.2
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1739460611; x=1740065411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OyIrs9HvFfKVmUwHZOR1GwKDKzsItdw/GMVirRewx9o=;
        b=PJwAxXxh4usPSlREw4QudQf5pFPmqnObjxOjpxl/KBVmxss1vyDixPqOdSIsftlBTn
         ye/0RV4tYBwPKz8/cXw7pLokhRtBDSMpviZUfUaGecKJUurah4BcWxo7GIalUaPQs6s/
         368uzE35qHQ1bcD6MFynK3LYiIrv9Fhc3orAhELMNd+5hyEtd4f6REiiulJXZaZpGL1X
         qPI8Duqa8MXpthjmjr2+nzyOD1MqNNxGhKKE5BjuwJqgxHdbQs0iKhFAy0Im2rAfyoE0
         KWZ5u1wnIdSxLlLUTyNu80LrY0Zol2Ze4yAA5r0jW8UJHl6RVQYVI++g4LgM4exBfVMv
         v2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460611; x=1740065411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyIrs9HvFfKVmUwHZOR1GwKDKzsItdw/GMVirRewx9o=;
        b=iSgVJ1UUuoMsulR3QGDr84k0Di+WKUNKsI+nfe6eMJ9cxMHgIRLc9FWG8xjky6C29G
         4bY9VsCUNCR3K6jTsd3lmsa9a2nqdZ4mvKVW730eYIfzGz6u4XuHXHuKh/j3m1doziV/
         ZIE/m3aH0/9SR4r2R5HJoaXyIEbmNseeQ47ksHMQjPlXiOcCArrlbRkU49vyjwaiqv3H
         wI9n9dypNxhQUurbeEtCwKAlUh7hREVQjkteiSy72IaqB39ebDThwcQaPGbIdsicCxBv
         qmOJ2qyzEmJzUp95+7YCPHYqxsow1P7w4dxaNnAcYA5gLdiYPnG8CTu+JyE85nhbsi0E
         v5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVnW8eyOxqOxBO5k1GH0q4kDnxDRYnCglO13cnt8pM5+h61dlWjAJ092/FKfh1xl723hMVAARg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3juOHvtr9qtu7lZPxanv2LT3ChO1qUnHU53haTtSCfbIjDIog
	gqFxnG/xVchAK7atrnSQboN4qGvY8pQp+JuRKNdFJF4YCmGBSKXcwVtraIz87g==
X-Gm-Gg: ASbGncuAO4uVivUqXXJeJXPdc4sATNBIxQZDVGV0yJus2Hudz+eysp0+URJCSjwjiW6
	QY4h7n8lVyuIu/l29Q/J24SAiRxVvstO4xSyk6ZZ3SQrFGTkYa+M7z3E+VJY6+eHzIe0h6FuxYH
	qqkWHC4YoPHGNCvp4VsAFZuyp6LPxDXCI9RVggCwBORmeLNuIHUbbsFdrb74NjLKDxNIb5ATjFy
	pTgPqnMHabqbtP59M4ZBRPeYFQWYOtIZuF+c1hJA6X+dMuduwZCUAuROtgdQ4FkaA+r97T9Imn3
	lxkKKsCeJidkUZaw
X-Google-Smtp-Source: AGHT+IHGzwP5ohgrW42L4Vps5APegav+rOlNPMCt8pEeXEljcFQRbBfg7Tzw7Nsn5o5w3hwG3O27Fw==
X-Received: by 2002:a05:6214:2262:b0:6e4:3cf1:5624 with SMTP id 6a1803df08f44-6e46edb4aa4mr120418166d6.39.1739460611592;
        Thu, 13 Feb 2025 07:30:11 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9345])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f36f5sm10395756d6.75.2025.02.13.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:30:11 -0800 (PST)
Date: Thu, 13 Feb 2025 10:30:07 -0500
From: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci: lack of clearing xHC resources
Message-ID: <b39d468e-beb9-4a44-8fe6-83754ffbd367@rowland.harvard.edu>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>

On Thu, Feb 13, 2025 at 10:27:00AM +0000, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in correct order after resuming in case when while suspend device was reconnected.
> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force DUT to suspend
> - reconnect hub attached to root port
> - wake DUT

DUT refers to the host, not the LS/FS device plugged into the hub, is 
that right?

> For this scenario during enumeration of USB LS/FS device the Cadence xHC reports completion error code for xHCi commands because the devices was not property disconnected and in result the xHC resources has not been correct freed.
> XHCI specification doesn't mention that device can be reset in any order so, we should not treat this issue as Cadence xHC controller bug.
> Similar as during disconnecting in this case the device should be cleared starting form the last usb device in tree toward the root hub.
> To fix this issue usbcore driver should disconnect all USB devices connected to hub which was reconnected while suspending.

No, that's not right at all.  We do not want to disconnect these devices 
if there's any way to avoid it.

There must be another way to tell the host controller to release the 
devices' resources.  Doesn't the usb_reset_and_verify_device() call do 
something like that anyway?  After all, the situation should be very 
similar to what happens when a device is simply reset.

Alan Stern


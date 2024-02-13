Return-Path: <stable+bounces-19758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E7D853553
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910561F21D66
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629875F494;
	Tue, 13 Feb 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4k9+K6j"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AC5F476
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839710; cv=none; b=V/ZyHjUjt6NOji2UUUlOcP8lnkKy4qPp0xIxxSKhJqhPGPbZuUPhh+9WXBpScsMb/b2Ji8/KLXM20e67WAuDk8VH53kOgjVhL2B7Kr6TOiqCuPS1lB9FpnSLQBUYm3BxWzgSVsW6DHZb0hD5/ElyF/RqGthtgSAieu/AYrrxN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839710; c=relaxed/simple;
	bh=xsgxJAOX8DI/vf5lySI2U3o+0BDInfLVAtoc2OdnwzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD4ODO/wdm0vJIaiBUsvuLlouIB0nbf4S3kWDGMcUeZvbvpeweX4HUA785+hIp3UwNo8Dtwo/3CIBel89U6HrFNV8SXSYZkh1J4jFqlnmG4lgKXOkSo/+fQPGk3MWu4nTX0oY4vQefl8nLkk8p0FdE06m3ZAAsKKOMfL4v34zUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d4k9+K6j; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bfe5aa702fso175990439f.3
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 07:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707839708; x=1708444508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LwxIniMZti5uVl7y9nWIeGEVkoZmsZ8d7f4xUj1DkA=;
        b=d4k9+K6jetezz6i7JYk4GPr+XlDtqDfmtsvES/VU4LCgfRL1qgKcYs8A3HcVtXk/Sd
         O4uLLZQ6ltxVGIlbuuolM7LHw0oeE3DrjVIUgfvt8n/ShR+E1eLaSRZwxgiRkdQ3d7/v
         cYtunPZ5I7+wHI4BLzxmPo+xgHOESN3x8tJwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839708; x=1708444508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LwxIniMZti5uVl7y9nWIeGEVkoZmsZ8d7f4xUj1DkA=;
        b=Yej53D1+tq5xnkO5Xhq34cpDx5cYFLRbvSIicMsz+aN+G6FC8rXez1OmjsCojVuSWP
         0Ryv1463eVZJNvAzKyAVwZ8zGWKNM7YL9obpc6iCtTW6oAy0CBHPbj7LLfWQdhZmRKHa
         MfocGZShFHu+21G8CEMhrrT7S0O9vsczQ37/fjajypg38vxbaemm18N1av9UQP6jmC0I
         qW3VX6LWuzvIkWdoUF/aZSWSpMR0HWNEOdfZ3om9aeF/JHY3C8POGomRXbSEsoIv1EjS
         bQPpFugO0w2yLl4znL+0ss+CjA4ppmi7yH9FoCqU9hC1g6EERWPKeCfJiBtKD94A0Xsa
         Wtiw==
X-Forwarded-Encrypted: i=1; AJvYcCXaIw5Z9E0fwQ4YYCNs9UJK3JwGJ8VtBDizsgHMmze5fR8v/tzB98FxRMB8hFfKLHNnx3Csq0/YOSN3bG/6ekffkoOAh4SO
X-Gm-Message-State: AOJu0YyGMb0YK6psmsIav1Udf2TjiTeqU4K/wupZi92hubhW6H5V7dFm
	o2sowuVSu7+dlizj50iCnPz21Sv4GgxBmvdy5Ay3RnDSWnbxNnyxa8t5DByxAzGFBI78Mpar+tA
	=
X-Google-Smtp-Source: AGHT+IFcgOAA9HVjaOg0HpWxj0MxMiSh/UkPsu8PJDLUVDOZnnTTC4P8loz4UdzdtTD9Oeefe/k+xQ==
X-Received: by 2002:a05:6602:234b:b0:7c4:4942:17b1 with SMTP id r11-20020a056602234b00b007c4494217b1mr37577iot.19.1707839707359;
        Tue, 13 Feb 2024 07:55:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOqsqCoVdk8nI6W22kovhNRLZ1NdvljX60EjeMsMLuZxFfQxF9/Tapwm6e0KXScCRgCIlvi68PjPXS56CrVyDqGiA2MryIoPpl3vxIgBuP+uJ66h0l3AYISYMXXznwIoyA0PjqMRcSeiwmMscMBENyW3bgv20pN1QW6p91K7yHf7zJBaGXuAtcC84yC/a4wQzF0Sbx2oPndH+qFM+FIIYEnM2lJAQJQztdBBHP3NCG6lKo/O3QZ86RZqytFI2xnpUnHxXtLt/bQ9TYlNzEWNDPbhVzjl9zrwmI2VlMYtSmWc8kqlpgFTyTD1fNvWd2yCMHBVcwEXiqbPuifseo7y2hFJF7Sqw6fssu8Fd/YHhYFUijyxIaSsQErcX/8yGZNKYMwNuXVQaCc+W+cy1CKeU2NNYedd6sVYmnRqmFLTekXrd4KWIDWIw2NPWX38YJkLPCoxADV3HXj50sZ70uag==
Received: from localhost (147.220.222.35.bc.googleusercontent.com. [35.222.220.147])
        by smtp.gmail.com with UTF8SMTPSA id y11-20020a6be50b000000b007c44f8750c5sm1961995ioc.12.2024.02.13.07.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 07:55:06 -0800 (PST)
Date: Tue, 13 Feb 2024 15:55:06 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Johan Hovold <johan@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
Message-ID: <ZcuQ2qRX0zsLSVRL@google.com>
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <Zct_tB-y7HbZU1dp@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zct_tB-y7HbZU1dp@hovoldconsulting.com>

On Tue, Feb 13, 2024 at 03:41:56PM +0100, Johan Hovold wrote:
> Hi Luiz,
> 
> On Wed, Dec 27, 2023 at 07:03:06PM +0100, Johan Hovold wrote:
> > The WCN6855 firmware on the Lenovo ThinkPad X13s expects the Bluetooth
> > device address in MSB order when setting it using the
> > EDL_WRITE_BD_ADDR_OPCODE command.
> > 
> > Presumably, this is the case for all non-ROME devices which all use the
> > EDL_WRITE_BD_ADDR_OPCODE command for this (unlike the ROME devices which
> > use a different command and expect the address in LSB order).
> > 
> > Reverse the little-endian address before setting it to make sure that
> > the address can be configured using tools like btmgmt or using the
> > 'local-bd-address' devicetree property.
> > 
> > Note that this can potentially break systems with boot firmware which
> > has started relying on the broken behaviour and is incorrectly passing
> > the address via devicetree in MSB order.
> > 
> > Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
> > Cc: stable@vger.kernel.org      # 5.1
> > Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Can we go ahead and merge this one to get this fixed in 6.8?
> 
> I've spoken to Bjorn Andersson at Qualcomm about this and he is in
> favour of doing so. The only people actually using the devicetree
> property should be the Chromium team and they control their own boot
> firmware and should be able to update it in lockstep (and Android uses
> some custom hacks to set the address that are not in mainline).

Unfortunately it's not as trivial as it sounds for Chrome OS. The boot
firmware is controlled by Chrome OS, however for any baseboard (e.g.
'trogdor') there is a larger number binary firmware packages, one
for every model derived from that baseboard. There can be dozens of
models. Chrome OS Firmware releases are qualified and rolled out per
model. FW qual may involve the ODM, usually there are multiple ODMs
per board. In an absolute emergency it would be possible to coordinate
a qual and synced rollout for all models, but it's definitely
non-trivial in terms of operations.


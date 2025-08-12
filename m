Return-Path: <stable+bounces-167101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC4B21E6C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B8A1A22C9F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D6E257451;
	Tue, 12 Aug 2025 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KVfDvb88"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015626A0C5
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980561; cv=none; b=c+R2FZ6dQFJ0HOQbevucanx4AomypFPLl8Sz1DZFHmx5T/yRrGxWzhY4Ltyihbp9fjEQ3fdkrQjDFWMZOzyz2to61nu251g6X1z8nJdbEnL0nYv7n7XK1Oygrjn6qxwhbAHvGyIUcFI3u3xGUw498ZdoNa11dfxK5sZZGVz0cRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980561; c=relaxed/simple;
	bh=Dd0bs4PHJcmmAUUmJ+uh5pSZmSd5ljR8cFk2HlJiweU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgOK15y2FJt5VIj/YflHUnEwKF0U3Lf83mQMbgDCD2zciph0wKJrIredtEaesfoxfY+BJV0M+aMcT1kjiWsgh9apLMX4Ps/2CBfvtTA8TbJxNjg7g6lAO61Oo4IH8nEXB+zoOA6DckeAvw7hNouR++/NKN+pEaBgTTWhDWQcvAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KVfDvb88; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bdc73f363so4531754b3a.3
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754980559; x=1755585359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnoD6h13qSIRLdJ/px/Sk71vJwdpqEKSwXcXmI7sV9s=;
        b=KVfDvb88jpXOu3Ioom2EEkkv9NSqzuBZc3PBBbGyY6GMOd89L6REF5Er49NNkfSbSX
         GK69vFXzF0hpigISJoFU6T4hwT2iG+nKdkB/qSvePcw3NUdBG8KIXTThOB9RWAhOLzIA
         r88k09PR5TtQvRb1SrEUxqNiQPTJb2epRpeXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980559; x=1755585359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnoD6h13qSIRLdJ/px/Sk71vJwdpqEKSwXcXmI7sV9s=;
        b=pcSnoB6fve+yTcRKxG8X4KD8+wSaE2cI4ONUYGIuNFDRe/T7Zj8ZYbele+Blx0NJg2
         +4dgGogtaogm2YDGzupV4f7SWUflM3tbneNUbggCVmgQgLTjLzqTf2mPiFaE0yxMOlAJ
         kI/DxQfDA6oVN9xS0yqY1PiEOoxwsgAIPQcEh/pJ7bKLnqPBiHs6HSRrDTy0mI4pQH3N
         lQkKlknsLvFA4o0b4vLCNnzmGVPlHA7Sqh9O4G2Aoh6CC0kVp42A3EbBGmzqbcIpEg42
         89wOLSmA83zofo0gMSfnewBepx1cZylEoI5p8plgIpWaNIVKbEwEvvbFWv1AsNT+1Tvv
         Yi3Q==
X-Gm-Message-State: AOJu0YzNMAvm7PSf55ot135+309yxwvsGS9ZfVMTs4d6myrEt3osuL1n
	OJn4cBbOuSuf88i7dKxQLzUJ4w/S47vV11GifvEEn+fhVu+9y07fwlNPq70hy7vIZ5FT38d2i/e
	TYiA=
X-Gm-Gg: ASbGnctlHIEi1joS+hE3eeLGVEW1lynW6NFcQcvDi/Zglczh0RYON9yyrqqwLJBrhQr
	acvk3+mQXuAd/UWL3d/DX9T/hqPF2mdUDnche5qaoHHapXyE6HLFRsUP6reneVY/POWzJJA/ac/
	Umf6FZSnahIeALxfF7Mjztr59kexquUUsRSoT6CRH4S9JfUNDo6ezSD/+woH2qc9ttLw22QPTPS
	2CWxymbEtVTVHn2oAgoUfdETLMkW/NKH7xxa4DCxGiRx6AV/uhmRxTZXavN6vbBDJFpHL+kQ7Kn
	m1PJv80zY0XwijVzPC+4D2HtehdOF8th3gNNNz+N1iNqfavIfw9esC7J9jc0dgtR++CImsmd+dc
	57ABf1+OTnSGUowNpcVr7cl0HeA==
X-Google-Smtp-Source: AGHT+IHNm7jRcXUMooYsvrXleskTAS5kX8pBPlXF3oQe9Q2z8A8dqNvbjEeZcHhNiB4yPnDMVzffag==
X-Received: by 2002:aa7:88d4:0:b0:76b:ed13:40c4 with SMTP id d2e1a72fcca58-76e0df54368mr3276708b3a.13.1754980558753;
        Mon, 11 Aug 2025 23:35:58 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:e529:c59e:30f9:11d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61b958b0sm7627469b3a.44.2025.08.11.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:35:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:35:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp,
 hdmi}_connector() return type
Message-ID: <4r4r7x4b63f6366ep5ijnve6ru5m5xv65puarv3kwrsv47t7er@xuk6hsipfe3u>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
 <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>

On (25/08/05 11:11), Sergey Senozhatsky wrote:
> On (25/08/04 19:16), Sergey Senozhatsky wrote:
> > From: Jani Nikula <jani.nikula@intel.com>
> > 
> > [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
> > 
> > The caller doesn't actually need the returned struct intel_connector;
> > it's stored in the ->attached_connector of intel_dp and
> > intel_hdmi. Switch to returning an int with 0 for success and negative
> > errors codes to be able to indicate success even when we don't have a
> > connector.
> > 
> > Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> Just for the record, this series fixes multiple NULL-ptr derefs
> in i915 code, which are observed in the wild.

Gentle ping.


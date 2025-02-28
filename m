Return-Path: <stable+bounces-119956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CCBA49D4A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA711890BD4
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BB0271824;
	Fri, 28 Feb 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rHQbS4AI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D791EF385
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756142; cv=none; b=PoDBgzIbmAEb+jbQmcM5cJ5SpykCdD47gzh1KxWd3wRtVb1qD/2E74HnVtWN+FF7VkkHEFY6+0WXDPo1JseLwcieJ2z4lAg3PopbcgQYwfxRvlVpBZT+YJNzCeLqD/U9t0sugYwCQh53zB1yAh50IqFu8FSrWEvh17MndbweENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756142; c=relaxed/simple;
	bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KudENCr86OwWCc9fQhLNMf8pUiw5PoCPZiHmHWfPBOb+4aKhGIGaDsZVq4F92f3uduWyLd+cuMLw72LenslR0my25YrynONHF8doeVv6IjHDD8bLhdRieCgkDc6lDXajQOmGNsLBX7rBE07FWq/eXIFlj9ajSpx11m0H2pMTBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rHQbS4AI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso2930313a12.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740756139; x=1741360939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
        b=rHQbS4AICxK61+BHGsx5IfT47Ine+qCwkDHJ5T/MuQg7hWZjlFO3oyK9iZXOLWnCWm
         Lnh95jQP4IM8r4KPzBiCiGx3Xfe/AmtbUisbLEiXTqQcX0ciVxdXSkEnzASkN3ri53sq
         C4jF7J1O+fewyXrvXjRyFW0fYH2OgO1C3ym1MgoxGme8g4FKCyjldf65rHTwp8wPEXGx
         W4+NBI8FKX6s/m1EFeltBRQXjwFiwixaT+iXMQw7VhYj1bL9sBrewpDxro0TyL6ar8ea
         i+f0qrN4cfBvMGZJ4IybUYQFnfv3b9I4R15g384NBiCBI4oijfKjb5l/MqkEnodtq/0j
         8rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740756139; x=1741360939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqyLu6u+1ahNp3WxvxP4um+m+DWCdM/0jn00g31dnvA=;
        b=tqDo47/5azBo2aCHlyYtaIuV2JZlR+ZhOrKHPOWMuE43WMya9jNjVBrXw2IozSndGi
         N4hupsupM76/fxMdADV9F0oz3Lnj8cj+gDVpADkGQrVvBNdYe7hy1YqP+uZ2RkxO67/d
         zeGvBuDow1Sq3GUFD9jveTJg9PhND3ouqoiI+XDMnmWVTAaKIlF2+2ISRrbpnprARYm9
         qiFq8sYOOzZpMuuZuvwB2PUbsfWUQXFqa/nwJx9+bZzxTA5DQpJhBZvHUSov4Qj0X2EW
         w6HaDfhvZ/zJZr6+JF5SMU30ABvgPPoX44/OzTLEBQ5gZNf1NcKEEGFC3Pl/rptveO5U
         kicg==
X-Forwarded-Encrypted: i=1; AJvYcCVsF4iFYWlhDVEjLXoRO4N7V3RnIwPaZb/ZEWtKZD+c2vcoEBYKrOMwvsIBr7S8EyfSsnvsgvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHP1wov/LJxzvqn/azJayu+NuDRlYpj8FFuAojWPPhhj5bcJ+L
	nniHuzhy3aL/TwFYpzPAJgadH0oyFRvcylbrNalvUW0Zk2XeFy2Rf8iXKpaZdWs=
X-Gm-Gg: ASbGncscxnuQaaWngBke2pGHt086AqEEA/W1H3lzvc6NhdkyBVpfiErRvn3jel+Woq7
	fUfTSbkRIdhHnLHeo/GGNQ+NzcdTFsylD+CAQslnrK5tlRFlQLjzPCjnHcb/e9/w/TK9FP8bJE6
	uIcZKwf1YE0nGV+F4kzLgYyJn0wUBzZqaT0VbIkdtZ7DQicH/eIMcQqP5b3Z5EwYA5kEdgPI3C+
	HjEQD064p6hbFBgnYt212ASWjpSil9CAxVtV/VYBE7/efWosJj3qXR+EpCb3sIY+TrbyqxiFwY/
	hplVIiY9AB2S2N2Z2AmOBVtOcWofZ6FTltEaKq87RnmPzHjnG0j7Jw==
X-Google-Smtp-Source: AGHT+IF9qp8a/UWBHc5Cf5P7FBXKmaSQUjAHQFD/EXiBNU4nniytV0W3aEh9jTooEY6MlyF55dubEA==
X-Received: by 2002:a17:906:2dc6:b0:abf:47cf:8323 with SMTP id a640c23a62f3a-abf47cfaacdmr49876266b.22.1740756139004;
        Fri, 28 Feb 2025 07:22:19 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b99a6sm309411866b.13.2025.02.28.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 07:22:18 -0800 (PST)
Date: Fri, 28 Feb 2025 16:22:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: przemyslaw.kitszel@intel.com, arkadiusz.kubalewski@intel.com, 
	davem@davemloft.net, jan.glaza@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v4 net-next] dpll: Add an assertion to check
 freq_supported_num
Message-ID: <i4sqqg4wwlrh7gcvfrmif6jwv4uhjavwbzgzmvcsxc5ocma3jb@r5tf5wbairf4>
References: <20250228150210.34404-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228150210.34404-1-jiashengjiangcool@gmail.com>

Fri, Feb 28, 2025 at 04:02:10PM +0100, jiashengjiangcool@gmail.com wrote:
>Since the driver is broken in the case that src->freq_supported is not
>NULL but src->freq_supported_num is 0, add an assertion for it.
>
>Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


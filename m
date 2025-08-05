Return-Path: <stable+bounces-166523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A3B1AC54
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 04:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80FF189687B
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97819F421;
	Tue,  5 Aug 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONOe9iOc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383D7E0FF
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754359872; cv=none; b=j8axD08GaEckfMGNMPtJ+gKvA9xBIvdrZoWW5AzgV/hroEzJZS2VEjT9MrFEBTpdM5g3dfsV0kZ9nLAcQRPNxlrGr0F5tKZn5o4BbYkcz7gDn+DTNJQMoXDhmK1xSLnyGheDqY2dHI5nDpkZx5aWdf5pox03OeKjvBzqXkyKxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754359872; c=relaxed/simple;
	bh=BA8Sv5hAs0Cczzh842n3Igvr3nEwwonomZ+OfkBNOW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnAgn4ckWUq1hFo3d58GOHZwpfPKGeBVKhEkFKbN5okZ13+34PTk61r/s9yA5h37i25HwYfd8TRaLnR9vmgL5BcJ/J2ZOOdWMFzA3TMGZuLW+XYVgonDhLQw+3EcGGigXGD+flx55O6kX1NVjZ51UrSTsdC6fJtAlu//gQ1nITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ONOe9iOc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24009eeb2a7so40127885ad.0
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 19:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754359870; x=1754964670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUh5g9Edd3OUSt9SebxM8g8FvTY23ew38WLkTHJvAC8=;
        b=ONOe9iOcV6gSLfJxZYpD7zMJ4yFXtv0mth6puISVp52wDN4n2edE0RI5zzrkfAEkC1
         wvZKMs4rbrvoWP9bHBhxSYCARa4tGSLXHN+hbovRlko0Jj1juJn26snNr/jBduvobDXM
         sre9AekpeSs4LI4SuiG4dByI4ocIR6H4w/gBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754359870; x=1754964670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUh5g9Edd3OUSt9SebxM8g8FvTY23ew38WLkTHJvAC8=;
        b=FQBxiZ1q9yMx5vX7ZDUtqQpm6nZN0aK4n4DOshujD/H4IpFrgM48LpdBAb8sS7FZNl
         lVjHclsNOr1NICm+LEvzXEny7HfI6H37krKiUi1Or05z2EKNz1TgPv2LaQ0IR/FnPQnC
         A+Zy/kmkns8SWbxlP3Qrm90/mXlbH3N1qRDfLMk9b/qtGWHgUK/9SCJGD5VP36Z03J67
         GIiDR1YlJjLW9LcLfDzsCEPThp1khTGW9VAfr6RlMzE4XetZuKwA9e9PoXzMl+f41Fka
         kIRhxj5SxdfvAQHIdnYbzH56/iQTPh66UEWHV2zUFc+Oty2Lcx4m+6A0V4Dj9GKWcwzx
         mVPA==
X-Gm-Message-State: AOJu0YwhrYXmYfUU/8H+UhkBw8RJzZBqu7GnF37crkSILqKE2CTPTAhg
	f29ZZW4huhea0g+wR2CuzknTYGmLPdKRziIwnOQQFwO662GYBA2Mz2ch6SvcgiRsItywNgzBRFU
	kFyg=
X-Gm-Gg: ASbGncugWcKxLTqBuWPrCzkVv4RTR8Ct7PIYAbRBdFh35TojFwYrKIwc9rUIeVZhp1B
	ptfj9no1fya4zSOrsE+n/rwpVv13Uu61MBdJoDKCIaRH3dWzzBDlVmTRJzz+WlUnhpz0LUD3NTX
	Kh0s9LNDkvTW4oJzrR8mDPuTjQnqakmZd1AtA73em3BaACYZYKg/+RlJD2VDrxdQ60Y53l7dYkm
	0NLssXoMVQNl7HIWd3i+JhzCHhTzTrpb0tN58hlsMeGeBQYpqsZfFyMnzZwVovNsOhkqXgbIovR
	lpIc+VD3l4r/0PUt6Lp7OFlt53XDx4yiMZmUjjsTYEqUbPFSWn9Pw5ZvymDFJF99OaHc9qMuOwr
	QtpAUhxH3yW5auqkCJgdAOh3OjQ==
X-Google-Smtp-Source: AGHT+IE1ZSjPrjDXwmchVTE4HVKAjM1g0owlGRcz5xh5p2gT3KD5FnOXohnZI7h4aEjTJCMvWbEJ2Q==
X-Received: by 2002:a17:903:2111:b0:240:a21c:89a6 with SMTP id d9443c01a7336-24246f58785mr120491685ad.12.1754359869884;
        Mon, 04 Aug 2025 19:11:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6825sm120429435ad.30.2025.08.04.19.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:11:09 -0700 (PDT)
Date: Tue, 5 Aug 2025 11:11:05 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 6.12 1/6] drm/i915/ddi: change intel_ddi_init_{dp,
 hdmi}_connector() return type
Message-ID: <qtx56p35nqiuds6hvhi5d2rfl2hdh7xir7qjvoduw2n7hkyj34@4hq75a4bh23i>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>

On (25/08/04 19:16), Sergey Senozhatsky wrote:
> From: Jani Nikula <jani.nikula@intel.com>
> 
> [ Upstream commit e1980a977686d46dbf45687f7750f1c50d1d6cf8 ]
> 
> The caller doesn't actually need the returned struct intel_connector;
> it's stored in the ->attached_connector of intel_dp and
> intel_hdmi. Switch to returning an int with 0 for success and negative
> errors codes to be able to indicate success even when we don't have a
> connector.
> 
> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/8ef7fe838231919e85eaead640c51ad3e4550d27.1735568047.git.jani.nikula@intel.com
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Just for the record, this series fixes multiple NULL-ptr derefs
in i915 code, which are observed in the wild.


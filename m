Return-Path: <stable+bounces-203023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C44CCD493
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 19:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 679283016EF8
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE2309DDD;
	Thu, 18 Dec 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGDzobD7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247E215077
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083557; cv=none; b=C2KZc+mV0ldvObuP6MTyA43pk66fcke4O2deLfuHUOJ7uNtxnhgR1Yt9VVNc4A4fcVg4CPs2iIfcKJ5Q3Rid4Xb7G7gJKLjjWn5xwVexyAg7M/SbTqe2F29b4Ru3AdRcEG/9VdHSCTxGxBKiB3+864m3Kb2mdh/lH6sWQ96Km9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083557; c=relaxed/simple;
	bh=p5Bqvhm9Uz0EgW1eYEfaPx46PU7qQJ+ok3VbEbVuFx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aesOp9+c9+1Ssf2C6OSUvkp49OEh+aQowgxh53M2mwkN1x4Z4a6d6q87EYbnI1wFg3Nzv0/yOXc1UpCbL5K3+Xa6pNT/TmDQ8jrET7NkqyBD6CJ+GWC086FrRwNFCEy83eo4zGlfrt/QtSY2XYzyCalDABQ3Iufo8LJQv1xxhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGDzobD7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso882633a12.3
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766083555; x=1766688355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wmfBWSlqxmnAhnZcKZtlMX7MY1IBPsWKTf/0ApjpNo=;
        b=GGDzobD73ofylEzayBLTEXASfKtHrZzs1lD/x0vCtSTTKL3UbZ2OmVBjrhI+W4HQHs
         1yQzA/tQQfyWPFxPfAbe+NVQx7bN4e2X5BewQL5Jku1G862fJ+IKgXzKeIx+3YmDinQy
         9bW+ktiSuCjkhcEo/VmIRIVmm0za5ytdn6JKC4R7hg+ZPpyMi4KEXwzqr+Ive1WIHFqd
         571NBTUc5v4ezRhILgHIO2RAOU//eOfNGuDMfxnPqqCh3Uk/xo+jHC2eVG3ZHqlrQ0fk
         3aFXU+LuHhLgxyZreMRlGY2zm1l64grkhINUNYaRa+wF1l5HiZ1VuDaHowagOhbLxS9E
         kZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083555; x=1766688355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wmfBWSlqxmnAhnZcKZtlMX7MY1IBPsWKTf/0ApjpNo=;
        b=jVZP28UfRt0sUyDPhtUDJLbD0ISZxvlLPY4vUYuEI/qNzjPZhbY4v5Q1Q2tDFuhckG
         GAafukBoswQOoLcUyYKKDxe72iiM1C7JDlokntTMF4Djwm6tSwjow8OVYAD5wRwmeGbQ
         /8bidzKr46uwAYlozaz4MphAliEsgkTndlF5N04EAZhTr6g/bYJkjOk8s8TQjBa+Wdg8
         TRhgd8ibhsAIF8p28J4Ud30pUNGpT2stPCVsRPlRCGtm331jvGojJ6d5fJzK5u/wzdTU
         lGFgpj4uINP3ZxLVYQfe0sgnPBukSJHgClCauGSbcOSaN2epMTW6e3foqt87ZJp3mRrA
         8JrA==
X-Forwarded-Encrypted: i=1; AJvYcCUAxIJ9HKRnEl4ev3/traHjt9NmYGmThA3XSnh7D2T8/8bENx5dCQ1Z9yM+26ltjMhLkHy8J8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSBPUfm0eL981f4oXIC4A1yvoYv8NoWO/GBKZIXNg75UgoqkI
	5rGYM9MzWR9C/A3WGsiAYwIQZcIaQpyr3Hi/ZPvmXIr5pWNrlND8gInX
X-Gm-Gg: AY/fxX41L62nMbVXQxy38AJ8Zp4FXeHBIFY3MThbDh2aL1vLWvwFhyS+p14dwFonVUp
	V/P2rFe3Bc4LSf0z2X85h7RDvb9/RFmqTaLKK43rlDskuv0q4daZ5+ZPIvVoIB9mfvLgCHhyfnj
	XTScTHcGpDnaKh6poUak7zL/t9500cM/uY/9SwLPb/znd5g1SzXiBgckpIcSoPPK4gx6D63oRo/
	+v/obugR68JwU+p5k/7oaRu5+C9ewnTVG9W9H/rnvMtrfKVEMTs5IUKA95/kKAEhsrjyfqldybn
	pA2kp13n0VQ81BRCKWd+9SxaDjNzGmqeCC4mQdXmZCxtdIquHqUFQYsGH2DKRT2fBTSDOKYxzBP
	bvA7F2j6rR+jHZTf9/Dsrv5D7dL6DH9NBygDuu8B0NIfGaY4fscr1CZTyWYsvbY5qmxFUs6ng5U
	RkhUh7TnJaG6VBhKTZpJMMGObZN1hyWlYc4pY=
X-Google-Smtp-Source: AGHT+IFdn/tpF3WuizfJoWgd3nZLjSK0zE/rTug/rj8Eg7nFBBgTG33eu0obLAmnDYOdFkpi3DHT6Q==
X-Received: by 2002:a05:7301:2103:b0:2af:9a4a:da8b with SMTP id 5a478bee46e88-2b05ec85686mr411609eec.20.1766083555339;
        Thu, 18 Dec 2025 10:45:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm32748eec.2.2025.12.18.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:45:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Dec 2025 10:45:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
	"Mark M. Hoffman" <mhoffman@lightlink.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ibmpex) Fix use-after-free in sysfs removal
Message-ID: <2827458c-af0f-4533-9136-1fd66223b77a@roeck-us.net>
References: <SYBPR01MB7881BB1354955C1608A16502AFA8A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881BB1354955C1608A16502AFA8A@SYBPR01MB7881.ausprd01.prod.outlook.com>

On Thu, Dec 18, 2025 at 03:56:47PM +0800, Junrui Luo wrote:
> There is a use-after-free vulnerability in the ibmpex driver where
> the driver frees the sensors array while sysfs read operations
> via ibmpex_show_sensor() are still in progress.
> 
> Fix this by reordering cleanup operations in ibmpex_bmc_delete().
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 57c7c3a0fdea ("hwmon: IBM power meter driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

A more complete fix is already queued in the hwmon branch as commit
6946c726c3f4 ("hwmon: (ibmpex) fix use-after-free in high/low store").

Thanks,
Guenter


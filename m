Return-Path: <stable+bounces-77056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769E984D4B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 00:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC451F24B4E
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CA13D8A3;
	Tue, 24 Sep 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kdzyzaWV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EF42A8F
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215436; cv=none; b=pAL+wOHHdvRGYDBYJf2tbkQtvGJUqkpj0OrEYVxVasXerheBA2QObv9wZxI0KcA0Ghwazm3Y6xLesd6q4igyky/YZWKmcd851vzjaU4Mgg/9sH95DZ71rivezLgVm5WTBNj28r4RdkCh1ag/Zuqvl6A8DmJtRfOmkfdtAHmK88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215436; c=relaxed/simple;
	bh=Di3HHVeMmvsPvxJZ02RPKqpJDdCNdHt5T9u4XXK2OJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgOPsxD4mEczTxO76IjborZRAJzVAMJ4wjHw+7vX11usqRkmI9Mo7Nxl01nkTd9WVv8cwMbNl/vaF9BZBwrBjnPibFFTkXoPboNpIdgf/K3O7jRqRi0Wi+jpdjMM/94LAxN+dnY5oHvtDqT7rDdzf92gbr8WRYA9attiAH2UlcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kdzyzaWV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so4362978b3a.3
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727215434; x=1727820234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEs+9DP+HE2tK5M1HclRjQdhyaSyms1rELLomIrD//s=;
        b=kdzyzaWVuXKSTjbDfZF/3IMS820IIgL02WVNLfjxFk5VQVcjKbiJGXwlKYdBG8wltU
         Rz8K4sUMKTUq4VDst+tCEe4Oq32GZ+dZgcqK1XqnEFQkNbWe1EUMLn6NNvrLb+VeQROq
         N7QMod6PoUXEjjJDxcRrambAo6zcEeZvc60tKvxaQE44ZQ5Az/c0dbMoVYi07qcEYG9q
         RBpNkgvr77+J/On8aCwlPCiarGMJ/DY+LB8oV5fvYoRDEc3YuzBUZcuqRmapkXmXhmdr
         DbZotR4g3i92QLs61obu5H1ENQvzgArt5chcT7rYZ8bg3zYDxZaFAqq0JVxM7UEhGbp7
         1SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215434; x=1727820234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEs+9DP+HE2tK5M1HclRjQdhyaSyms1rELLomIrD//s=;
        b=FMZcHe85MgJXq2EwNihntp1MoJ8QKAj0k+7vVeNuY7DpVlpfY/20PuxIOSBJvslaTH
         bIoCoCw/KNg+DRoLzE4oaHJNvkaNNPSfm3q4dOTANxKyrU7f9H5pGIqgSG40QuU1CDn4
         +WKXhe2Ey5VTCsr0W59YKVVmHul6K4Xs7XPn8QND0p5zSileK8kcibTvNcqqjI1gwcxc
         9zI5Co/9u7OdBphU1K6jXJ64kWfs+vGVbLlgoDGko/rLED6QxGf4kuJqBfHHm6dntwPN
         Rr3KJHQtxXO4oPV4l/auAKajXWCWuwrj0PQ0pRyeZ7312WZbt0m66zWFQF3dNtjXgImE
         2C8Q==
X-Gm-Message-State: AOJu0Yw2sBHJXRth9pe0cQmrdv9sMwP3Vy0DOtKypNPnvRLMwJV656BY
	CtFrBTZdkF9W9IgfPFoHRMidDm08p3z/AR8BMEQVniqYdrBwfYoDZP+NFObXRusdge5eY4c3tJJ
	T
X-Google-Smtp-Source: AGHT+IHr/pTSH7JQH7QpJpwhHbi24g03qWDkFXAfKmtvvfuiQsgnuZctfyMui+Rb0qd8IWWwkBBIJw==
X-Received: by 2002:a05:6300:668a:b0:1d3:4301:3c86 with SMTP id adf61e73a8af0-1d4c6f2c90cmr879386637.7.1727215434408;
        Tue, 24 Sep 2024 15:03:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5a9bsm1611318b3a.186.2024.09.24.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:03:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1stDdO-009bHt-13;
	Wed, 25 Sep 2024 08:03:50 +1000
Date: Wed, 25 Sep 2024 08:03:50 +1000
From: Dave Chinner <david@fromorbit.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, linux-xfs@vger.kernel.org, amir73il@gmail.com,
	chandan.babu@oracle.com, cem@kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH 6.1 00/26] xfs backports to catch 6.1.y up to 6.6
Message-ID: <ZvM3RhJxJuMeARbV@dread.disaster.area>
References: <20240924183851.1901667-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924183851.1901667-1-leah.rumancik@gmail.com>

On Tue, Sep 24, 2024 at 11:38:25AM -0700, Leah Rumancik wrote:
> Hello again,
> 
> Here is the next set of XFS backports, this set is for 6.1.y and I will
> be following up with a set for 5.15.y later. There were some good
> suggestions made at LSF to survey test coverage to cut back on
> testing but I've been a bit swamped and a backport set was overdue.
> So for this set, I have run the auto group 3 x 8 configs with no
> regressions seen. Let me know if you spot any issues.
> 
> This set has already been ack'd on the XFS list.

Hi Leah, can you pick up this recently requested fix for the series,
too?

https://lore.kernel.org/linux-xfs/20240923155752.8443-1-kalachev@swemel.ru/T/

-Dave.
-- 
Dave Chinner
david@fromorbit.com


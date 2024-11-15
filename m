Return-Path: <stable+bounces-93552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D649CE138
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 15:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF9B2812AE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799771CEAD6;
	Fri, 15 Nov 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcavtvbI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB431B218E
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680986; cv=none; b=KeNbCZpvO64tDab6uWkiD22YcImc59ulPQnSvl/c5zLc6EZ9kgo9XekwCZ3fKVit9BKaIwW+tdxFpdKHNRybGWytjTz2j3Rr/l5e/mBpRZtJqW9DY171SW8R4x7V+h/pWGxmieNilwWLnXfNyocprghY85f0RL6QLv3p+2uSOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680986; c=relaxed/simple;
	bh=CJw27koqcTJbsFKHMxcqkO2MR5OeU7fMCY2tLEsTmCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=krEw8sdEVZGU+JPEXBHcqovvBcWOJW8OVb/uOSTbEq8g8GUJmupw5eWmH1vP5N2enuOcdFozP9+xEsMFAP3O/jbd8NMNb83U9jMKr+GVDZjLpRwI19kTbzl6NELwm6xMe+DwyjzmjNDp3TpZIyqofNQrbzHpqzTwwBdbuoNTfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcavtvbI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1877188e87.0
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 06:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731680982; x=1732285782; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXh4dEsfBFOvQmledmUvsF8K9B1Y19hzVeT7nkn4oxw=;
        b=hcavtvbId24YfZjeUmQNJWC1X4RIpiIY5uHMyBL6QhILO40TMTCFT/qh+QN1miB1ka
         Bo7FDLA/Vl6tXv+5JQrUSvTngsIZFmsRH0JCaoqYL41JfTxIrwIcWN6aNKCwv0LFWJmY
         wMHRf3NeXvspfURrMG2gHIW8GwP20pgcJw5zKcn1SAYKHNDwIjrVtCAowdQ2fJz8XTal
         bA0jm03dj47xsy2Bttz7TlszurfwG/LpBGqH/LynLEzfvDO64H2XtgLSf5ytedZtMsQT
         05uKM792BF7Syvfab6sKxsB2SEJDxWBCFuUngj/qyWDSgk6WrWExDt3WBtJktcKLCc6S
         tHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731680982; x=1732285782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXh4dEsfBFOvQmledmUvsF8K9B1Y19hzVeT7nkn4oxw=;
        b=Jix/ma34e1XdO5G7sGzzDaes+UUmPjIhVpWnP+d6425kH4qMXLwl57gJuW/LbYEISg
         rVspq20P//eMdVXoMme6coYzHloiKP2BnIE4f+yjUrxpQPzcEjjfQLraf9dTLn8nUjwl
         6efmnmqxWeoWnvTrglAcjBxwXvE5HBpnJI02d9Y0q9Echd/iVA8CcclNFBxGukh/u3Ib
         PHbhtU1GBVRXxar1R3rP4vOsW/Kx9SvchkkwNb82jtUIYRYVUYl3x3bsUKNq8RkfKRSY
         2JUlD0kKSI8JnaxQYZHGLX5qsGNUjRg2DsYDBTKCpxxtW2GZ/b8KgLDrdNkPia1I67UE
         Wdmw==
X-Gm-Message-State: AOJu0YzvbBRU9B3aTkdok9uM715O2TGrWXBjKNtGgMbmHiF9d4SJwb5e
	bi5uSDZysHRE0WCxR62EJVA3xzgik1cOZZ9HQXRJezRyAE7L0qyh/jDZ3KjfpBE=
X-Google-Smtp-Source: AGHT+IFWIXP3MUDsOdNPiu9rHtEJfAaNbjHnPLiNxyR3cup7iiA0qIQFfYTZ1QnV0J7ID/itot7+Wg==
X-Received: by 2002:ac2:4e0b:0:b0:53d:a000:1815 with SMTP id 2adb3069b0e04-53dab291668mr1412078e87.8.1731680982532;
        Fri, 15 Nov 2024 06:29:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad238sm4474208f8f.25.2024.11.15.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:29:42 -0800 (PST)
Date: Fri, 15 Nov 2024 17:29:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: mmc: core: add devm_mmc_alloc_host (5.10.y)
Message-ID: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sasha,

The 5.10.y kernel backported commit 80df83c2c57e ("mmc: core:
add devm_mmc_alloc_host") but not the fix for it.

71d04535e853 ("mmc: core: fix return value check in devm_mmc_alloc_host()")

The 6.6.y kernel was released with both commits so it's not affected and none
of the other stable trees include the buggy commit so they're not affected
either.  Only 5.10.y needs to be fixed.

regards,
dan carpenter


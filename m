Return-Path: <stable+bounces-152538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22018AD6953
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166611BC1A3F
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F7B2147E7;
	Thu, 12 Jun 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RB7mHz2P"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918F21325D
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714157; cv=none; b=cjrA2znvQ5jjuwsiHO7UcEUIIDd3E5jv9ZLXGGduEMSvpZQ2yvrIyr9aMQg76b/gIqcQT2AMy5Zoo+qatxBmdebkVr/p95/8s2J1Gj3VwBj1oSfwTjJzgDJgEoVB7xKLeHTvyfJBq6sWSLLQhYJkgPZH7vgWU2ZA+u2nG4WUT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714157; c=relaxed/simple;
	bh=liD84H33mldJ5FwcAo5b42k0QKzep4H4rmYW/0tE3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixM5j4fek/yWqHGTi/n3EZLMG2YH78Bs/SCE/Pzex37IaeWCAwVbwD2ICRt31hetOnl5bjVMRZAvoFE0ysOYWGaLkR6ouh4nPzebKfayZdHnbldy1D7mGpPTpl45yjuQeI/yLyTJs8I45tbsSQNIHU7N+pQoYU9DsFimsxQQlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RB7mHz2P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a3798794d3so710954f8f.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749714154; x=1750318954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOjdW6tvwIHGvqgEBjcYXxpqXXP0mM93Bi1E5VHKi0I=;
        b=RB7mHz2P2F0km9hNYYtu3w9W1j0fp/y1iV6+QIlaCDcvOSzig+rw9sfzzBLqoNB9My
         FC0BFiaK7emHFD9TfA3KoCEgVCMmooWs5v8kXWeJxYp0GXatPBKkxRo96PLPF6be1G70
         wLKRi4UcC1JJWBC9uNDWrtn9j2csf4afhir3kvjc+p4qP6Xck5DJsdbimN2+fS8KekDG
         wMVUbeTYauqAoKxVs/4Ljj2jEwi44JjRtkG58FmM7ZcHmw+95RfQ+1ZkGYPgww5xTQUV
         u7aKlNpEpnGPTunoHhOsXFFONPmfcpcL0onPOS4cxzaEC+EgcOJnsj8re5KGWIqnoJHj
         M2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714154; x=1750318954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOjdW6tvwIHGvqgEBjcYXxpqXXP0mM93Bi1E5VHKi0I=;
        b=e9vU5l+kFjiC5MW4yfoWkUQKZrzVEfx0xHXKKdeqT7BAnEO0zwri69iJKqqqdnnV2F
         3mtW3sZ2wtk6q8cv4rM5lfzkWUdX6O7RGKeA2iCxb7YkniVWf9RKSmpofudfNOG1F44y
         LwTtbpz+2MCGTgH3efBROuQDb37eRZwH28GBLFI+Qy6gDUgE8EdxFvy59T5Um0wM4CP6
         cfGL/WroYwuHyOEqC9fIAl2U58zZSoB59O2yDXS74TGOn25c+0BjHoVqOBVUoTRicSQ+
         XgmaIwV1HVmVpqdtm6wIr/zpLNchC5Fm1+yYQGXEItL6n5JPrgQ0seU9+Ch/XugwhPsm
         FH8A==
X-Forwarded-Encrypted: i=1; AJvYcCWj7fNaUashzWqyu+FCNmCYYPONdQRmgZtNW1oq4m08M42kLjBFMvFoXNv1OFoa00LFvZwcS9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZfw6vZyO36zLPoVRlGmULWlRM4rJdbcK/NgAUw66QBo6TBWq
	RwuBUhwKVhCLAniLf0LDsaKE2LX0B0kkQvR8B7MqjYrBZM3hgwFXhQaDLkJ+Y61jDGg=
X-Gm-Gg: ASbGnctD/68mSGysPQl7/60wE/q4WfyD2J3edrItfhYTj78rms6ox7oeyaTrtH/PHS1
	75msw2NVu38C42BO89rB2/xzm+ihRxY1s9WMzkQrTeIHZnLCpT6hf8A0TfqMkpEUVKkD8y+xd7s
	hcM63qGjvbq8CqD7dLfASIHQI3pATLV+3pbkjmXCtEIbCCcxbOro/aLKDbPdizzQrt4T35d36a/
	PGB5ImfRLByReqHbkC/w/6YhWMUK+uVJNABotJryWjjvvR4H/MNd2VeqlLz60At8bfcJgrBMQwy
	JMKrnwyfpLXwa41W2iGH0sA23UXBAErDBrOevWngI55MZf5ROaruHac7TvrzBb8wcKA=
X-Google-Smtp-Source: AGHT+IHK4uQuCn2XQWMjU/bTqraytEDLe7/LB0UXdjlju8466jLpB8n5+oghPZtv4fc6nLejDkqEyw==
X-Received: by 2002:a05:6000:2308:b0:3a4:e740:cd72 with SMTP id ffacd0b85a97d-3a56127883dmr1425617f8f.13.1749714154457;
        Thu, 12 Jun 2025 00:42:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453305a0d9dsm3836115e9.21.2025.06.12.00.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:42:34 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:42:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karan Tilak Kumar <kartilak@cisco.com>
Cc: sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
	gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
	aeasi@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com, revers@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] scsi: fnic: Fix crash in fnic_wq_cmpl_handler
 when FDMI times out
Message-ID: <aEqE5okf2jfV9kwt@stanley.mountain>
References: <20250612004426.4661-1-kartilak@cisco.com>
 <20250612004426.4661-2-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612004426.4661-2-kartilak@cisco.com>

On Wed, Jun 11, 2025 at 05:44:23PM -0700, Karan Tilak Kumar wrote:
> When both the RHBA and RPA FDMI requests time out, fnic reuses a frame
> to send ABTS for each of them. On send completion, this causes an
> attempt to free the same frame twice that leads to a crash.
> 
> Fix crash by allocating separate frames for RHBA and RPA,
> and modify ABTS logic accordingly.
> 
> Tested by checking MDS for FDMI information.
> Tested by using instrumented driver to:
> Drop PLOGI response
> Drop RHBA response
> Drop RPA response
> Drop RHBA and RPA response
> Drop PLOGI response + ABTS response
> Drop RHBA response + ABTS response
> Drop RPA response + ABTS response
> Drop RHBA and RPA response + ABTS response for both of them
> 
> Fixes: 09c1e6ab4ab2 ("scsi: fnic: Add and integrate support for FDMI")
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
> Tested-by: Arun Easi <aeasi@cisco.com>
> Co-developed-by: Arun Easi <aeasi@cisco.com>
> Signed-off-by: Arun Easi <aeasi@cisco.com>
> Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
> Cc: <stable@vger.kernel.org> # 6.14.x Please see patch description

I'm a bit confused.  Why do we need to specify 6.14.x?  I would have
assumed that the Fixes tag was enough information.  What are we supposed
to see in the patch description?

I suspect you're making this too complicated...  Just put
Cc: <stable@vger.kernel.org> and a Fixes tag and let the scripts figure
it out.  Or put in the commit description, "The Fixes tag points to
an older kernel because XXX but really this should only be backported
to 6.14.x because YYY."

regards,
dan carpenter



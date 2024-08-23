Return-Path: <stable+bounces-69917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42E95C1D3
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 02:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A0C1F2428F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5A19E;
	Fri, 23 Aug 2024 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3LYS8SW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F3B64C;
	Fri, 23 Aug 2024 00:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371374; cv=none; b=X8yt5UydHl7WTrH86MNZKMBLnFBp/2o68viw93ulIeSEvuxKuGuKx8401cVnM6hHhy5mgC3LLi34+6Yrrri0fC8sST+vokSSV4RqLW3yXYtKf5+pydNZhM5cFCxigchUEafWjuWQjN+VizOyhZ5cuLtAFD7NdqAWXeUUDUiklQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371374; c=relaxed/simple;
	bh=+B8Zf+qNab8dy7kut1N/Onir4GRcrJ78u1T4k/V3gjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckC3K+Gj2QvlbKX4ZJou6FS19U9WZxcKnlD0cKgYJIobqdytPTIHJV+Lsg7p4/0bKgpN7ueffXi0eVPI+Y1mXLG77S4XpgQf6tBRl1bjBOrx8P1kaeGlVRDAXwisuViZcy5vKDbTlPppAHgR+Ml4e5mJdITHys/+crlEsJ03GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3LYS8SW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso1129712b3a.3;
        Thu, 22 Aug 2024 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724371372; x=1724976172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98gnejDKaLO3dsc2ZNwfjSy1JDPda+0qVNeGwsqKFYM=;
        b=D3LYS8SWM4OEAa3cHqB36lKT6ULXK0rtQFp17wphmjqQgGng9OUStq1xfuKsMDlnLT
         1JPmiR3Ws1K7G7IVsLaNsTDqFFJFlgJ3+w5CgQEKPIrJxPIGd1dDewx8bWHaaV4ymfs8
         KKy206GCA0Y5elHTXH0ML+vpddYDXKLhF37uigkpQCQIlBA6D5VWT4fnYGe097ENtYF+
         a+toD0QZPqerhdo+j15JYEMU0QgHGgVYLstE9Ow+fehTWheQutkdeHG4vfaRrxR8S53w
         hP4Y2MpUHwoqfpGYiLZilVy7HPILL8iRcZ1GCtvOhA3PF4jTZIQ37H6itThPMFs5mpjg
         dR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371373; x=1724976173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98gnejDKaLO3dsc2ZNwfjSy1JDPda+0qVNeGwsqKFYM=;
        b=U3HmKj3KZ3FbDbrgq8EtS+/Mprv5caoLTrr2qbXZ+hMkR05BBQAuqShLWRC0f+TZtU
         LUZMO6zz8x0mwpPBbfa7MIIKgJ5gulE3AFebnEEq9eXeBGwUFInjhxhQcK8V9PPcS99o
         yvWc+c+XuJ1Frk9y9zyaiQRQMp2uwU64Z7VwhzGk+X37FacbAJwFFN+QDFdES3NVvZZ1
         +Z6Rx5cMbFFL4Q9XqTl6cg5xd724KPELxf2FJEvtqsK7F4qhpod/U220MWdct7/YRzby
         dkVta08Gd45AKV+59822Jr8LHb2w15kWX7DRQwY3eGdr7H5/QTZdVbaOY1SawNE8nHnU
         CJQg==
X-Forwarded-Encrypted: i=1; AJvYcCVYKrsN2+8DA+aQcDNKfVyx++f96HbxBbBF2FQAW+JcQ1rAvI9AvuevVCiFFNwdSe+6bBdqZVAZeKVFbq0=@vger.kernel.org, AJvYcCXTFBy8M7xqmB6QjWumOhhhDo1caM9gEuTR+vmRtpqLgHIy9rhh9piX9M6Z/134TxeocXjnhWll@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmn3uINnfJmO2M0RBChGpFK+lzAC5W0iaNoGtKLB21mnOvcIN
	7MSqndmu27Cvpq1rksqTl/DHEYlGvFLukFe1ZWR2qgUnmNTcLf+2qlbvFQ==
X-Google-Smtp-Source: AGHT+IFuJJdXrj7vSFjNsmUwiYecIehQy3YqxS92vV6AQfPGURczpl8Awv/qDMobK7kTttR8gFpprg==
X-Received: by 2002:a05:6a00:1e0b:b0:714:2ba6:e5c9 with SMTP id d2e1a72fcca58-71445772473mr717070b3a.7.1724371372460;
        Thu, 22 Aug 2024 17:02:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ccdb:6951:7a5:be1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430c10asm1990378b3a.176.2024.08.22.17.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 17:02:52 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:02:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <ZsfRqT9d6Qp_Pva5@google.com>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>

Hi,

On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> An uninitialized variable @data.have_async may be used as analyzed
> by the following inline comments:
> 
> static int __device_attach(struct device *dev, bool allow_async)
> {
> 	// if @allow_async is true.
> 
> 	...
> 	struct device_attach_data data = {
> 		.dev = dev,
> 		.check_async = allow_async,
> 		.want_async = false,
> 	};
> 	// @data.have_async is not initialized.

No, in the presence of a structure initializer fields not explicitly
initialized will be set to 0 by the compiler.

There is no issue here.

Thanks.

-- 
Dmitry


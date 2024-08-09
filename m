Return-Path: <stable+bounces-66102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DF94C7AA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 02:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110731F2312C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 00:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20872907;
	Fri,  9 Aug 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfb3r/so"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272B2581;
	Fri,  9 Aug 2024 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164052; cv=none; b=gPyO6wPalqHJWXLxRNiZ+qBgeg46ciGiieJA3FVs8aptBd4CxEcAoWnSUN2FiCiuCNQlWhrsnVyBJkdz0XFMgwKJXVpwBtwYQ6LiRDo4Zn9itltOOjH+XVDQIKZgV6AfrmJftQD6PwSeJf3mWHosqFsyNCzaDGf6XxXqlNfSb/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164052; c=relaxed/simple;
	bh=48WbLLpceiOye98tOvM//5IlVK2olSy8Acy0/6eBOE0=;
	h=Message-ID:Date:From:To:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar2kRj9AURgGTlneovRIe/NQ1Od6uwjtH/0kKUOPOir1pJN3IgNVxAUN98Vc1WEUlEMNShf9c0SlK4bl4/tzHBU1VvTLSnhpngBCrSiY2Wn4zg8H0yQ//m/DLk9nse5SyC0DgAl8vcMe//RLK2K5x+FPSP+rDP2F65B2CoAsG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfb3r/so; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso13565085ad.1;
        Thu, 08 Aug 2024 17:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164051; x=1723768851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=48WbLLpceiOye98tOvM//5IlVK2olSy8Acy0/6eBOE0=;
        b=nfb3r/soeHU5WJKh3tERGR1SOqwlRdYY/LMhS59ZLy4Gzybh6D0gSQfi6bU7a8HhFu
         NSWrVAxeCeRwx18qKOgrAWqD5ZkWbyGCyxW68zx9lLdRx90EiegEfMvjpAhKeo6EAr9h
         tUXNMnJtzR3r2q5Ma64MjKOtWnFDpUzBxMTTI5ptzy4ppzNkKVMs9MM5+dyZOUZxT54v
         F7E3+11nn3iRtmld4zP6zeR+iayTXdzuVflt/odkoGXuqtF9/eSe0xmdMcHp0UPKWntN
         OtIypTQTvAm2DFZYrZ1zJXdvszxjAlNrF0p7NRLDPulRzJ95Zy9yqgKyT2yiXLykN5bb
         4NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164051; x=1723768851;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48WbLLpceiOye98tOvM//5IlVK2olSy8Acy0/6eBOE0=;
        b=BzrJfbZCKCoxkhL7XwEnw3EpECVk6ZMrFPWV3SlC4h3qHnMZ+z0BiDYDLQk8mW9NFc
         K7CnClaXlRVTfzkr45PHC/snVkReddxGmSGhljZX/qLm6Rhr5DqywYO5DG2Cc/6u0mfO
         quggMm/jT5e/MMCcBrlWCIvrTaX2C72RafDxSS2lr5TddfzMVyOQ2eOKMfdNt/1ZtMRn
         k53TP8Pan1ojCnHvMAk5PVyyhtTl3WXpNY2J2fHV/5vhnqrXQKPJxLPjG1VPnUphgg5K
         8Q9rNuPnkfwHPV3ve9clvqfMdMSe8NR9N3EffIAG5BmQIhYG+rxko2fqbprIalIEyBEI
         01ew==
X-Forwarded-Encrypted: i=1; AJvYcCWqksgKTH1vqJEZHB2iiygwrCIRcGI1fuATcCMgQa2gu3wMiZvLqibZE5qMqEWNadeotW9Kj+qF4SxiEPBqaY2IOHAaapGGjEFhCsT5nrqctFWqS41BQ5UrtA7dvYnEWP2DaCF4
X-Gm-Message-State: AOJu0YyPbLe7Vb7xXX/qHut4AEYSXnn93EmedS0E6dDF0XnOQPwStst8
	N8f9UYFI2Y1RY45m/KnQRZ4VQjqbHQftincp6fZVA4m2lu8R4YQx
X-Google-Smtp-Source: AGHT+IGDqlBxiKLgTwDsGP0msdRT8cr+vsqXACt88Gy4mIrUYkWd1XSmbWH/1/iE6+N3me3iEqnFSQ==
X-Received: by 2002:a17:902:da8d:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-2009521fb0dmr45961295ad.6.1723164050539;
        Thu, 08 Aug 2024 17:40:50 -0700 (PDT)
Received: from Cyndaquil. (55.sub-174-231-130.myvzw.com. [174.231.130.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058cd5sm130314525ad.127.2024.08.08.17.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:40:50 -0700 (PDT)
Message-ID: <66b56592.170a0220.2f7c57.8fff@mx.google.com>
X-Google-Original-Message-ID: <ZrVljt7mZCdM48lH@Cyndaquil.>
Date: Thu, 8 Aug 2024 17:40:46 -0700
From: Mitchell Levy <levymitchell0@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
References: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com>

On Thu, Aug 08, 2024 at 04:30:10PM -0700, Mitchell Levy via B4 Relay wrote:
> Fixes: d72c87018d00 ("x86/fpu/xstate: Move remaining xfeature helpers to core")
Apologies, this Fixes tag is incorrect, it should instead be:
Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")

